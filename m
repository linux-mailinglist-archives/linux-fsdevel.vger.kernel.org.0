Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF83C957C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 03:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhGOBRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 21:17:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231165AbhGOBRX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:17:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4653F11D4;
        Wed, 14 Jul 2021 18:14:31 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EB1A3F7D8;
        Wed, 14 Jul 2021 18:14:25 -0700 (PDT)
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
Subject: [PATCH v7 2/5] d_path: introduce helper d_path_unsafe()
Date:   Thu, 15 Jul 2021 09:14:04 +0800
Message-Id: <20210715011407.7449-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715011407.7449-1-justin.he@arm.com>
References: <20210715011407.7449-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper is similar to d_path() except that it doesn't take any
seqlock/spinlock. It is typical for debugging purposes. Besides,
an additional return value *prenpend_len* is used to get the full
path length of the dentry, ingoring the tail '\0'.
the full path length = end - buf - prepend_length - 1.

Previously it skipped the prepend_name() loop at once in __prepen_path()
when the buffer length was not enough or even negative.
prepend_name_with_len() will get the full length of dentry name
together with the parent recursively regardless of the buffer length.

prepend_name_with_len() moves and copies the path when the given
buffer is not big enough. It cuts off the end of the path.
It returns immediately when there is no buffer at all.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/d_path.c            | 118 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/dcache.h |   1 +
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 4eb31f86ca88..010b78f41140 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -67,9 +67,88 @@ static bool prepend_name(struct prepend_buffer *p, const struct qstr *name)
 	return true;
 }
 
+/**
+ * prepend_name_with_len - prepend a pathname in front of current buffer
+ * pointer with limited orig_buflen.
+ * @p: prepend buffer which contains buffer pointer and allocated length
+ * @name: name string and length qstr structure
+ * @orig_buflen: original length of the buffer
+ *
+ * p.ptr is updated each time when prepends dentry name and its parent.
+ * Given the orginal buffer length might be less than name string, the
+ * dentry name can be moved or truncated. Returns at once if !buf or
+ * original length is not positive to avoid memory copy.
+ *
+ * Load acquire is needed to make sure that we see that terminating NUL,
+ * which is similar to prepend_name().
+ */
+static bool prepend_name_with_len(struct prepend_buffer *p,
+				  const struct qstr *name, int orig_buflen)
+{
+	/*
+	 * The load acquire is to order against the subsequent READ_ONCE()
+	 * of ->len. It is paired with the store release in __d_alloc(),
+	 */
+	const char *dname = smp_load_acquire(&name->name);
+	int dlen = READ_ONCE(name->len);
+	int last_len = p->len;
+	char *s;
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
+			/* Dentry name can be fully filled into the space */
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
 
@@ -96,8 +175,7 @@ static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
 			return 3;
 
 		prefetch(parent);
-		if (!prepend_name(p, &dentry->d_name))
-			break;
+		prepend_name_with_len(p, &dentry->d_name, orig_buflen);
 		dentry = parent;
 	}
 	return 0;
@@ -261,6 +339,42 @@ char *d_path(const struct path *path, char *buf, int buflen)
 }
 EXPORT_SYMBOL(d_path);
 
+/**
+ * d_path_unsafe - return the full path of a dentry without taking
+ * any seqlock/spinlock. This helper is typical for debugging purposes.
+ * @path: path to report
+ * @buf: buffer to return value in
+ * @buflen: buffer length
+ * @prepend_len: prepended length when going through the full path
+ *
+ * Convert a dentry into an ASCII path name.
+ *
+ * Returns a pointer into the buffer or an error code if the path was
+ * errous.
+ *
+ * @buf can be NULL, and @buflen can be 0 or negative. But NULL @buf
+ * and buflen>0 is considered as an obvious caller bug.
+ *
+ */
+char *d_path_unsafe(const struct path *path, char *buf, int buflen,
+		    int *prepend_len)
+{
+	struct mount *mnt = real_mount(path->mnt);
+	DECLARE_BUFFER(b, buf, buflen);
+	struct path root;
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

