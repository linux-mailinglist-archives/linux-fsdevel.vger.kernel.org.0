Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B213B067F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 16:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFVOJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 10:09:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231621AbhFVOJS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:09:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BA4F1063;
        Tue, 22 Jun 2021 07:07:02 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11D833F694;
        Tue, 22 Jun 2021 07:06:56 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v5 1/4] fs: introduce helper d_path_unsafe()
Date:   Tue, 22 Jun 2021 22:06:31 +0800
Message-Id: <20210622140634.2436-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210622140634.2436-1-justin.he@arm.com>
References: <20210622140634.2436-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper is similar to d_path() except that it doesn't take any
seqlock/spinlock. It is typical for debugging purposes. Besides,
an additional return value *prenpend_len* is used to get the full
path length of the dentry, ingoring the tail '\0'.
the full path length = end - buf - prepend_length - 1

Previously it will skip the prepend_name() loop at once in
__prepen_path() when the buffer length is not enough or even negative.
prepend_name_with_len() will get the full length of dentry name
together with the parent recursively regardless of the buffer length.

If someone invokes snprintf() with small but positive space,
prepend_name_with_len() moves and copies the string partially.

More than that, kasprintf() will pass NULL _buf_ and _end_ as the
parameters. Hence return at the very beginning with false in this case.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/d_path.c            | 104 +++++++++++++++++++++++++++++++++++++++--
 include/linux/dcache.h |   1 +
 2 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 23a53f7b5c71..84a738375698 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -33,8 +33,7 @@ static void prepend(struct prepend_buffer *p, const char *str, int namelen)
 
 /**
  * prepend_name - prepend a pathname in front of current buffer pointer
- * @buffer: buffer pointer
- * @buflen: allocated length of the buffer
+ * @p: prepend buffer which contains buffer pointer and allocated length
  * @name:   name string and length qstr structure
  *
  * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to
@@ -68,9 +67,84 @@ static bool prepend_name(struct prepend_buffer *p, const struct qstr *name)
 	return true;
 }
 
+/**
+ * prepend_name_with_len - prepend a pathname in front of current buffer
+ * pointer with limited orig_buflen.
+ * @p: prepend buffer which contains buffer pointer and allocated length
+ * @name:   name string and length qstr structure
+ * @orig_buflen original length of the buffer.
+ *
+ * With the original length of the buffer (p.ptr is changable), the dentry
+ * name string will be filled into the prepending buffer. Given the orginal
+ * length might be less than name string, the dentry name can be moved or
+ * truncated.
+ *
+ * Load acquire is needed to make sure that we see that terminating NUL,
+ * which is similar to prepend_name().
+ */
+static bool prepend_name_with_len(struct prepend_buffer *p,
+				  const struct qstr *name, int orig_buflen)
+{
+	const char *dname = smp_load_acquire(&name->name); /* ^^^ */
+	int dlen = READ_ONCE(name->len);
+	char *s;
+	int last_len = p->len;
+
+	p->len -= dlen + 1;
+
+	if (unlikely(!p->buf))
+		return false;
+
+	if (orig_buflen <= 0)
+		return false;
+
+	/*
+	 * The first time we overflow the buffer. Then fill the string
+	 * partially from the beginning
+	 */
+	if (unlikely(p->len < 0)) {
+		int buflen = strlen(p->buf);
+
+		/* memcpy src */
+		s = p->buf;
+
+		/* Still have small space to fill partially */
+		if (last_len > 0) {
+			p->buf -= last_len;
+			buflen += last_len;
+		}
+
+		if (buflen > dlen + 1) {
+			/* Dentry name can be fully filled */
+			memmove(p->buf + dlen + 1, s, buflen - dlen - 1);
+			p->buf[0] = '/';
+			memcpy(p->buf + 1, dname, dlen);
+		} else if (buflen > 0) {
+			/* Can be partially filled, and drop last dentry */
+			p->buf[0] = '/';
+			memcpy(p->buf + 1, dname, buflen - 1);
+		}
+
+		return false;
+	}
+
+	s = p->buf -= dlen + 1;
+	*s++ = '/';
+	while (dlen--) {
+		char c = *dname++;
+
+		if (!c)
+			break;
+		*s++ = c;
+	}
+	return true;
+}
+
 static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
 			  const struct path *root, struct prepend_buffer *p)
 {
+	int orig_buflen = p->len;
+
 	while (dentry != root->dentry || &mnt->mnt != root->mnt) {
 		const struct dentry *parent = READ_ONCE(dentry->d_parent);
 
@@ -97,8 +171,7 @@ static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
 			return 3;
 
 		prefetch(parent);
-		if (!prepend_name(p, &dentry->d_name))
-			break;
+		prepend_name_with_len(p, &dentry->d_name, orig_buflen);
 		dentry = parent;
 	}
 	return 0;
@@ -263,6 +336,29 @@ char *d_path(const struct path *path, char *buf, int buflen)
 }
 EXPORT_SYMBOL(d_path);
 
+/**
+ * d_path_unsafe - return the full path of a dentry without taking
+ * any seqlock/spinlock. This helper is typical for debugging purposes.
+ */
+char *d_path_unsafe(const struct path *path, char *buf, int buflen,
+		    int *prepend_len)
+{
+	struct path root;
+	struct mount *mnt = real_mount(path->mnt);
+	DECLARE_BUFFER(b, buf, buflen);
+
+	rcu_read_lock();
+	get_fs_root_rcu(current->fs, &root);
+
+	prepend(&b, "", 1);
+	__prepend_path(path->dentry, mnt, &root, &b);
+	rcu_read_unlock();
+
+	*prepend_len = b.len;
+
+	return b.buf;
+}
+
 /*
  * Helper function for dentry_operations.d_dname() members
  */
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 9e23d33bb6f1..ec118b684055 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -301,6 +301,7 @@ char *dynamic_dname(struct dentry *, char *, int, const char *, ...);
 extern char *__d_path(const struct path *, const struct path *, char *, int);
 extern char *d_absolute_path(const struct path *, char *, int);
 extern char *d_path(const struct path *, char *, int);
+extern char *d_path_unsafe(const struct path *, char *, int, int*);
 extern char *dentry_path_raw(const struct dentry *, char *, int);
 extern char *dentry_path(const struct dentry *, char *, int);
 
-- 
2.17.1

