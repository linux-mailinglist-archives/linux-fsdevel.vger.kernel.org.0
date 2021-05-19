Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D863883F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhESAwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352870AbhESAu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:50:57 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10E6C06138A;
        Tue, 18 May 2021 17:49:38 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOU-00G4Fq-Gy; Wed, 19 May 2021 00:49:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 12/14] d_path: prepend_path(): lift the inner loop into a new helper
Date:   Wed, 19 May 2021 00:48:59 +0000
Message-Id: <20210519004901.3829541-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... and leave the rename_lock/mount_lock handling in prepend_path()
itself

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 77 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 9a0356cc98d3..ba629879a4bf 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -68,6 +68,42 @@ static bool prepend_name(struct prepend_buffer *p, const struct qstr *name)
 	return true;
 }
 
+static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
+			  const struct path *root, struct prepend_buffer *p)
+{
+	while (dentry != root->dentry || &mnt->mnt != root->mnt) {
+		const struct dentry *parent = READ_ONCE(dentry->d_parent);
+
+		if (dentry == mnt->mnt.mnt_root) {
+			struct mount *m = READ_ONCE(mnt->mnt_parent);
+			struct mnt_namespace *mnt_ns;
+
+			if (likely(mnt != m)) {
+				dentry = READ_ONCE(mnt->mnt_mountpoint);
+				mnt = m;
+				continue;
+			}
+			/* Global root */
+			mnt_ns = READ_ONCE(mnt->mnt_ns);
+			/* open-coded is_mounted() to use local mnt_ns */
+			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
+				return 1;	// absolute root
+			else
+				return 2;	// detached or not attached yet
+		}
+
+		if (unlikely(dentry == parent))
+			/* Escaped? */
+			return 3;
+
+		prefetch(parent);
+		if (!prepend_name(p, &dentry->d_name))
+			break;
+		dentry = parent;
+	}
+	return 0;
+}
+
 /**
  * prepend_path - Prepend path string to a buffer
  * @path: the dentry/vfsmount to report
@@ -89,11 +125,9 @@ static int prepend_path(const struct path *path,
 			const struct path *root,
 			struct prepend_buffer *p)
 {
-	struct dentry *dentry;
-	struct mount *mnt;
-	int error = 0;
 	unsigned seq, m_seq = 0;
 	struct prepend_buffer b;
+	int error;
 
 	rcu_read_lock();
 restart_mnt:
@@ -102,43 +136,8 @@ static int prepend_path(const struct path *path,
 	rcu_read_lock();
 restart:
 	b = *p;
-	error = 0;
-	dentry = path->dentry;
-	mnt = real_mount(path->mnt);
 	read_seqbegin_or_lock(&rename_lock, &seq);
-	while (dentry != root->dentry || &mnt->mnt != root->mnt) {
-		struct dentry * parent;
-
-		if (dentry == mnt->mnt.mnt_root || IS_ROOT(dentry)) {
-			struct mount *parent = READ_ONCE(mnt->mnt_parent);
-			struct mnt_namespace *mnt_ns;
-
-			/* Escaped? */
-			if (dentry != mnt->mnt.mnt_root) {
-				error = 3;
-				break;
-			}
-			/* Global root? */
-			if (mnt != parent) {
-				dentry = READ_ONCE(mnt->mnt_mountpoint);
-				mnt = parent;
-				continue;
-			}
-			mnt_ns = READ_ONCE(mnt->mnt_ns);
-			/* open-coded is_mounted() to use local mnt_ns */
-			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
-				error = 1;	// absolute root
-			else
-				error = 2;	// detached or not attached yet
-			break;
-		}
-		parent = dentry->d_parent;
-		prefetch(parent);
-		if (!prepend_name(&b, &dentry->d_name))
-			break;
-
-		dentry = parent;
-	}
+	error = __prepend_path(path->dentry, real_mount(path->mnt), root, &b);
 	if (!(seq & 1))
 		rcu_read_unlock();
 	if (need_seqretry(&rename_lock, seq)) {
-- 
2.11.0

