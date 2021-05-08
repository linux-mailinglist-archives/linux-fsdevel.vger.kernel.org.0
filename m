Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C973771B9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 May 2021 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhEHMaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 May 2021 08:30:22 -0400
Received: from foss.arm.com ([217.140.110.172]:53574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhEHMaU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 May 2021 08:30:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3BD81063;
        Sat,  8 May 2021 05:29:18 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FE853F73B;
        Sat,  8 May 2021 05:29:12 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ftp.linux.org.uk>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jia He <justin.he@arm.com>
Subject: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
Date:   Sat,  8 May 2021 20:25:28 +0800
Message-Id: <20210508122530.1971-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508122530.1971-1-justin.he@arm.com>
References: <20210508122530.1971-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper is similar to d_path except for not taking seqlock/spinlock.

Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/d_path.c            | 50 ++++++++++++++++++++++++++++++++----------
 include/linux/dcache.h |  1 +
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index a69e2cd36e6e..985a5754a9f5 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -61,7 +61,7 @@ static int prepend_name(char **buffer, int *buflen, const struct qstr *name)
  * @root: root vfsmnt/dentry
  * @buffer: pointer to the end of the buffer
  * @buflen: pointer to buffer length
- *
+ * @need_lock: not ignoring renames and changes to the mount tree
  * The function will first try to write out the pathname without taking any
  * lock other than the RCU read lock to make sure that dentries won't go away.
  * It only checks the sequence number of the global rename_lock as any change
@@ -74,7 +74,7 @@ static int prepend_name(char **buffer, int *buflen, const struct qstr *name)
  */
 static int prepend_path(const struct path *path,
 			const struct path *root,
-			char **buffer, int *buflen)
+			char **buffer, int *buflen, bool need_lock)
 {
 	struct dentry *dentry;
 	struct vfsmount *vfsmnt;
@@ -86,7 +86,8 @@ static int prepend_path(const struct path *path,
 
 	rcu_read_lock();
 restart_mnt:
-	read_seqbegin_or_lock(&mount_lock, &m_seq);
+	if (need_lock)
+		read_seqbegin_or_lock(&mount_lock, &m_seq);
 	seq = 0;
 	rcu_read_lock();
 restart:
@@ -96,7 +97,8 @@ static int prepend_path(const struct path *path,
 	dentry = path->dentry;
 	vfsmnt = path->mnt;
 	mnt = real_mount(vfsmnt);
-	read_seqbegin_or_lock(&rename_lock, &seq);
+	if (need_lock)
+		read_seqbegin_or_lock(&rename_lock, &seq);
 	while (dentry != root->dentry || vfsmnt != root->mnt) {
 		struct dentry * parent;
 
@@ -136,19 +138,21 @@ static int prepend_path(const struct path *path,
 	}
 	if (!(seq & 1))
 		rcu_read_unlock();
-	if (need_seqretry(&rename_lock, seq)) {
+	if (need_lock && need_seqretry(&rename_lock, seq)) {
 		seq = 1;
 		goto restart;
 	}
-	done_seqretry(&rename_lock, seq);
+	if (need_lock)
+		done_seqretry(&rename_lock, seq);
 
 	if (!(m_seq & 1))
 		rcu_read_unlock();
-	if (need_seqretry(&mount_lock, m_seq)) {
+	if (need_lock && need_seqretry(&mount_lock, m_seq)) {
 		m_seq = 1;
 		goto restart_mnt;
 	}
-	done_seqretry(&mount_lock, m_seq);
+	if (need_lock)
+		done_seqretry(&mount_lock, m_seq);
 
 	if (error >= 0 && bptr == *buffer) {
 		if (--blen < 0)
@@ -185,7 +189,7 @@ char *__d_path(const struct path *path,
 	int error;
 
 	prepend(&res, &buflen, "\0", 1);
-	error = prepend_path(path, root, &res, &buflen);
+	error = prepend_path(path, root, &res, &buflen, true);
 
 	if (error < 0)
 		return ERR_PTR(error);
@@ -202,7 +206,7 @@ char *d_absolute_path(const struct path *path,
 	int error;
 
 	prepend(&res, &buflen, "\0", 1);
-	error = prepend_path(path, &root, &res, &buflen);
+	error = prepend_path(path, &root, &res, &buflen, true);
 
 	if (error > 1)
 		error = -EINVAL;
@@ -225,7 +229,7 @@ static int path_with_deleted(const struct path *path,
 			return error;
 	}
 
-	return prepend_path(path, root, buf, buflen);
+	return prepend_path(path, root, buf, buflen, true);
 }
 
 static int prepend_unreachable(char **buffer, int *buflen)
@@ -291,6 +295,28 @@ char *d_path(const struct path *path, char *buf, int buflen)
 }
 EXPORT_SYMBOL(d_path);
 
+/**
+ * d_path_fast - fast return the path of a dentry
+ * This helper is similar to d_path other than taking seqlock/spinlock.
+ */
+char *d_path_fast(const struct path *path, char *buf, int buflen)
+{
+	char *res = buf + buflen;
+	struct path root;
+	int error;
+
+	rcu_read_lock();
+	get_fs_root_rcu(current->fs, &root);
+	prepend(&res, &buflen, "\0", 1);
+	error = prepend_path(path, &root, &res, &buflen, false);
+	rcu_read_unlock();
+
+	if (error < 0)
+		res = ERR_PTR(error);
+	return res;
+}
+EXPORT_SYMBOL(d_path_fast);
+
 /*
  * Helper function for dentry_operations.d_dname() members
  */
@@ -445,7 +471,7 @@ SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
 		int buflen = PATH_MAX;
 
 		prepend(&cwd, &buflen, "\0", 1);
-		error = prepend_path(&pwd, &root, &cwd, &buflen);
+		error = prepend_path(&pwd, &root, &cwd, &buflen, true);
 		rcu_read_unlock();
 
 		if (error < 0)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c1e48014106f..9a00fb90824f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -300,6 +300,7 @@ char *dynamic_dname(struct dentry *, char *, int, const char *, ...);
 extern char *__d_path(const struct path *, const struct path *, char *, int);
 extern char *d_absolute_path(const struct path *, char *, int);
 extern char *d_path(const struct path *, char *, int);
+extern char *d_path_fast(const struct path *, char *, int);
 extern char *dentry_path_raw(struct dentry *, char *, int);
 extern char *dentry_path(struct dentry *, char *, int);
 
-- 
2.17.1

