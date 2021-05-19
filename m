Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D226F3883F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352887AbhESAwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbhESAu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:50:57 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E2C061760;
        Tue, 18 May 2021 17:49:38 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOU-00G4Fm-Bt; Wed, 19 May 2021 00:49:02 +0000
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
Subject: [PATCH 10/14] d_path: prepend_path(): get rid of vfsmnt
Date:   Wed, 19 May 2021 00:48:57 +0000
Message-Id: <20210519004901.3829541-10-viro@zeniv.linux.org.uk>
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

it's kept equal to &mnt->mnt all along.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 06e93dd031bf..3836f5d0b023 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -90,7 +90,6 @@ static int prepend_path(const struct path *path,
 			struct prepend_buffer *p)
 {
 	struct dentry *dentry;
-	struct vfsmount *vfsmnt;
 	struct mount *mnt;
 	int error = 0;
 	unsigned seq, m_seq = 0;
@@ -105,18 +104,17 @@ static int prepend_path(const struct path *path,
 	b = *p;
 	error = 0;
 	dentry = path->dentry;
-	vfsmnt = path->mnt;
-	mnt = real_mount(vfsmnt);
+	mnt = real_mount(path->mnt);
 	read_seqbegin_or_lock(&rename_lock, &seq);
-	while (dentry != root->dentry || vfsmnt != root->mnt) {
+	while (dentry != root->dentry || &mnt->mnt != root->mnt) {
 		struct dentry * parent;
 
-		if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
+		if (dentry == mnt->mnt.mnt_root || IS_ROOT(dentry)) {
 			struct mount *parent = READ_ONCE(mnt->mnt_parent);
 			struct mnt_namespace *mnt_ns;
 
 			/* Escaped? */
-			if (dentry != vfsmnt->mnt_root) {
+			if (dentry != mnt->mnt.mnt_root) {
 				b = *p;
 				error = 3;
 				break;
@@ -125,7 +123,6 @@ static int prepend_path(const struct path *path,
 			if (mnt != parent) {
 				dentry = READ_ONCE(mnt->mnt_mountpoint);
 				mnt = parent;
-				vfsmnt = &mnt->mnt;
 				continue;
 			}
 			mnt_ns = READ_ONCE(mnt->mnt_ns);
-- 
2.11.0

