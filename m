Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755303883FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhESAw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352869AbhESAu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:50:57 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C9CC0613ED;
        Tue, 18 May 2021 17:49:38 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOU-00G4Fk-8v; Wed, 19 May 2021 00:49:02 +0000
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
Subject: [PATCH 09/14] d_path: introduce struct prepend_buffer
Date:   Wed, 19 May 2021 00:48:56 +0000
Message-Id: <20210519004901.3829541-9-viro@zeniv.linux.org.uk>
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

        We've a lot of places where we have pairs of form (pointer to end
of buffer, amount of space left in front of that).  These sit in pairs of
variables located next to each other and usually passed by reference.
Turn those into instances of new type (struct prepend_buffer) and pass
reference to the pair instead of pairs of references to its fields.

Declared and initialized by DECLARE_BUFFER(name, buf, buflen).

extract_string(prepend_buffer) returns the buffer contents if
no overflow has happened, ERR_PTR(ENAMETOOLONG) otherwise.
All places where we used to have that boilerplate converted to use
of that helper.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 142 ++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 75 insertions(+), 67 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 83db83446afd..06e93dd031bf 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -8,12 +8,26 @@
 #include <linux/prefetch.h>
 #include "mount.h"
 
-static void prepend(char **buffer, int *buflen, const char *str, int namelen)
+struct prepend_buffer {
+	char *buf;
+	int len;
+};
+#define DECLARE_BUFFER(__name, __buf, __len) \
+	struct prepend_buffer __name = {.buf = __buf + __len, .len = __len}
+
+static char *extract_string(struct prepend_buffer *p)
 {
-	*buflen -= namelen;
-	if (likely(*buflen >= 0)) {
-		*buffer -= namelen;
-		memcpy(*buffer, str, namelen);
+	if (likely(p->len >= 0))
+		return p->buf;
+	return ERR_PTR(-ENAMETOOLONG);
+}
+
+static void prepend(struct prepend_buffer *p, const char *str, int namelen)
+{
+	p->len -= namelen;
+	if (likely(p->len >= 0)) {
+		p->buf -= namelen;
+		memcpy(p->buf, str, namelen);
 	}
 }
 
@@ -34,22 +48,22 @@ static void prepend(char **buffer, int *buflen, const char *str, int namelen)
  *
  * Load acquire is needed to make sure that we see that terminating NUL.
  */
-static bool prepend_name(char **buffer, int *buflen, const struct qstr *name)
+static bool prepend_name(struct prepend_buffer *p, const struct qstr *name)
 {
 	const char *dname = smp_load_acquire(&name->name); /* ^^^ */
 	u32 dlen = READ_ONCE(name->len);
-	char *p;
+	char *s;
 
-	*buflen -= dlen + 1;
-	if (unlikely(*buflen < 0))
+	p->len -= dlen + 1;
+	if (unlikely(p->len < 0))
 		return false;
-	p = *buffer -= dlen + 1;
-	*p++ = '/';
+	s = p->buf -= dlen + 1;
+	*s++ = '/';
 	while (dlen--) {
 		char c = *dname++;
 		if (!c)
 			break;
-		*p++ = c;
+		*s++ = c;
 	}
 	return true;
 }
@@ -73,15 +87,14 @@ static bool prepend_name(char **buffer, int *buflen, const struct qstr *name)
  */
 static int prepend_path(const struct path *path,
 			const struct path *root,
-			char **buffer, int *buflen)
+			struct prepend_buffer *p)
 {
 	struct dentry *dentry;
 	struct vfsmount *vfsmnt;
 	struct mount *mnt;
 	int error = 0;
 	unsigned seq, m_seq = 0;
-	char *bptr;
-	int blen;
+	struct prepend_buffer b;
 
 	rcu_read_lock();
 restart_mnt:
@@ -89,8 +102,7 @@ static int prepend_path(const struct path *path,
 	seq = 0;
 	rcu_read_lock();
 restart:
-	bptr = *buffer;
-	blen = *buflen;
+	b = *p;
 	error = 0;
 	dentry = path->dentry;
 	vfsmnt = path->mnt;
@@ -105,8 +117,7 @@ static int prepend_path(const struct path *path,
 
 			/* Escaped? */
 			if (dentry != vfsmnt->mnt_root) {
-				bptr = *buffer;
-				blen = *buflen;
+				b = *p;
 				error = 3;
 				break;
 			}
@@ -127,7 +138,7 @@ static int prepend_path(const struct path *path,
 		}
 		parent = dentry->d_parent;
 		prefetch(parent);
-		if (!prepend_name(&bptr, &blen, &dentry->d_name))
+		if (!prepend_name(&b, &dentry->d_name))
 			break;
 
 		dentry = parent;
@@ -148,11 +159,10 @@ static int prepend_path(const struct path *path,
 	}
 	done_seqretry(&mount_lock, m_seq);
 
-	if (blen == *buflen)
-		prepend(&bptr, &blen, "/", 1);
+	if (b.len == p->len)
+		prepend(&b, "/", 1);
 
-	*buffer = bptr;
-	*buflen = blen;
+	*p = b;
 	return error;
 }
 
@@ -176,24 +186,24 @@ char *__d_path(const struct path *path,
 	       const struct path *root,
 	       char *buf, int buflen)
 {
-	char *res = buf + buflen;
+	DECLARE_BUFFER(b, buf, buflen);
 
-	prepend(&res, &buflen, "", 1);
-	if (prepend_path(path, root, &res, &buflen) > 0)
+	prepend(&b, "", 1);
+	if (prepend_path(path, root, &b) > 0)
 		return NULL;
-	return buflen >= 0 ? res : ERR_PTR(-ENAMETOOLONG);
+	return extract_string(&b);
 }
 
 char *d_absolute_path(const struct path *path,
 	       char *buf, int buflen)
 {
 	struct path root = {};
-	char *res = buf + buflen;
+	DECLARE_BUFFER(b, buf, buflen);
 
-	prepend(&res, &buflen, "", 1);
-	if (prepend_path(path, &root, &res, &buflen) > 1)
+	prepend(&b, "", 1);
+	if (prepend_path(path, &root, &b) > 1)
 		return ERR_PTR(-EINVAL);
-	return buflen >= 0 ? res : ERR_PTR(-ENAMETOOLONG);
+	return extract_string(&b);
 }
 
 static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
@@ -224,7 +234,7 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
  */
 char *d_path(const struct path *path, char *buf, int buflen)
 {
-	char *res = buf + buflen;
+	DECLARE_BUFFER(b, buf, buflen);
 	struct path root;
 
 	/*
@@ -245,13 +255,13 @@ char *d_path(const struct path *path, char *buf, int buflen)
 	rcu_read_lock();
 	get_fs_root_rcu(current->fs, &root);
 	if (unlikely(d_unlinked(path->dentry)))
-		prepend(&res, &buflen, " (deleted)", 11);
+		prepend(&b, " (deleted)", 11);
 	else
-		prepend(&res, &buflen, "", 1);
-	prepend_path(path, &root, &res, &buflen);
+		prepend(&b, "", 1);
+	prepend_path(path, &root, &b);
 	rcu_read_unlock();
 
-	return buflen >= 0 ? res : ERR_PTR(-ENAMETOOLONG);
+	return extract_string(&b);
 }
 EXPORT_SYMBOL(d_path);
 
@@ -278,36 +288,34 @@ char *dynamic_dname(struct dentry *dentry, char *buffer, int buflen,
 
 char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
 {
-	char *end = buffer + buflen;
+	DECLARE_BUFFER(b, buffer, buflen);
 	/* these dentries are never renamed, so d_lock is not needed */
-	prepend(&end, &buflen, " (deleted)", 11);
-	prepend(&end, &buflen, dentry->d_name.name, dentry->d_name.len);
-	prepend(&end, &buflen, "/", 1);
-	return buflen >= 0 ? end : ERR_PTR(-ENAMETOOLONG);
+	prepend(&b, " (deleted)", 11);
+	prepend(&b, dentry->d_name.name, dentry->d_name.len);
+	prepend(&b, "/", 1);
+	return extract_string(&b);
 }
 
 /*
  * Write full pathname from the root of the filesystem into the buffer.
  */
-static char *__dentry_path(const struct dentry *d, char *p, int buflen)
+static char *__dentry_path(const struct dentry *d, struct prepend_buffer *p)
 {
 	const struct dentry *dentry;
-	char *end;
-	int len, seq = 0;
+	struct prepend_buffer b;
+	int seq = 0;
 
 	rcu_read_lock();
 restart:
 	dentry = d;
-	end = p;
-	len = buflen;
+	b = *p;
 	read_seqbegin_or_lock(&rename_lock, &seq);
 	while (!IS_ROOT(dentry)) {
 		const struct dentry *parent = dentry->d_parent;
 
 		prefetch(parent);
-		if (!prepend_name(&end, &len, &dentry->d_name))
+		if (!prepend_name(&b, &dentry->d_name))
 			break;
-
 		dentry = parent;
 	}
 	if (!(seq & 1))
@@ -317,28 +325,29 @@ static char *__dentry_path(const struct dentry *d, char *p, int buflen)
 		goto restart;
 	}
 	done_seqretry(&rename_lock, seq);
-	if (len == buflen)
-		prepend(&end, &len, "/", 1);
-	return len >= 0 ? end : ERR_PTR(-ENAMETOOLONG);
+	if (b.len == p->len)
+		prepend(&b, "/", 1);
+	return extract_string(&b);
 }
 
 char *dentry_path_raw(const struct dentry *dentry, char *buf, int buflen)
 {
-	char *p = buf + buflen;
-	prepend(&p, &buflen, "", 1);
-	return __dentry_path(dentry, p, buflen);
+	DECLARE_BUFFER(b, buf, buflen);
+
+	prepend(&b, "", 1);
+	return __dentry_path(dentry, &b);
 }
 EXPORT_SYMBOL(dentry_path_raw);
 
 char *dentry_path(const struct dentry *dentry, char *buf, int buflen)
 {
-	char *p = buf + buflen;
+	DECLARE_BUFFER(b, buf, buflen);
 
 	if (unlikely(d_unlinked(dentry)))
-		prepend(&p, &buflen, "//deleted", 10);
+		prepend(&b, "//deleted", 10);
 	else
-		prepend(&p, &buflen, "", 1);
-	return __dentry_path(dentry, p, buflen);
+		prepend(&b, "", 1);
+	return __dentry_path(dentry, &b);
 }
 
 static void get_fs_root_and_pwd_rcu(struct fs_struct *fs, struct path *root,
@@ -386,24 +395,23 @@ SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
 	error = -ENOENT;
 	if (!d_unlinked(pwd.dentry)) {
 		unsigned long len;
-		char *cwd = page + PATH_MAX;
-		int buflen = PATH_MAX;
+		DECLARE_BUFFER(b, page, PATH_MAX);
 
-		prepend(&cwd, &buflen, "", 1);
-		if (prepend_path(&pwd, &root, &cwd, &buflen) > 0)
-			prepend(&cwd, &buflen, "(unreachable)", 13);
+		prepend(&b, "", 1);
+		if (prepend_path(&pwd, &root, &b) > 0)
+			prepend(&b, "(unreachable)", 13);
 		rcu_read_unlock();
 
-		if (buflen < 0) {
+		if (b.len < 0) {
 			error = -ENAMETOOLONG;
 			goto out;
 		}
 
 		error = -ERANGE;
-		len = PATH_MAX + page - cwd;
+		len = PATH_MAX - b.len;
 		if (len <= size) {
 			error = len;
-			if (copy_to_user(buf, cwd, len))
+			if (copy_to_user(buf, b.buf, len))
 				error = -EFAULT;
 		}
 	} else {
-- 
2.11.0

