Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548773A851C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhFOPxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 11:53:35 -0400
Received: from foss.arm.com ([217.140.110.172]:39038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232319AbhFOPwN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:52:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA22C13D5;
        Tue, 15 Jun 2021 08:50:08 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4058C3F694;
        Tue, 15 Jun 2021 08:50:04 -0700 (PDT)
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
        Jia He <justin.he@arm.com>
Subject: [PATCH RFCv4 1/4] fs: introduce helper d_path_unsafe()
Date:   Tue, 15 Jun 2021 23:49:49 +0800
Message-Id: <20210615154952.2744-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210615154952.2744-1-justin.he@arm.com>
References: <20210615154952.2744-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper is similar to d_path except that it doesn't take any
seqlock/spinlock. It is typical for debugging purpose. Besides,
an additional return value *prenpend_len* is used to get the full
path length of the dentry.

prepend_name_with_len() enhances the behavior of prepend_name().
Previously it will skip the loop at once in __prepen_path() when the
space is not enough. __prepend_path() gets the full length of dentry
together with the parent recusively.

Besides, if someone invokes snprintf with small but positive space,
prepend_name_with() needs to move and copy the string partially.

More than that, kasnprintf will pass NULL _buf_ and _end_, hence
it returns at the very beginning with false in this case;

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/d_path.c            | 83 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/dcache.h |  1 +
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 23a53f7b5c71..4fc224eadf58 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -68,9 +68,66 @@ static bool prepend_name(struct prepend_buffer *p, const struct qstr *name)
 	return true;
 }
 
+static bool prepend_name_with_len(struct prepend_buffer *p, const struct qstr *name,
+			 int orig_buflen)
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
+	/*
+	 * The first time we overflow the buffer. Then fill the string
+	 * partially from the beginning
+	 */
+	if (unlikely(p->len < 0)) {
+		int buflen = strlen(p->buf);
+
+		s = p->buf;
+
+		/* Still have small space to fill partially */
+		if (last_len > 0) {
+			p->buf -= last_len;
+			buflen += last_len;
+		}
+
+		if (buflen > dlen + 1) {
+			/* This dentry name can be fully filled */
+			memmove(p->buf + dlen + 1, s, buflen - dlen - 1);
+			p->buf[0] = '/';
+			memcpy(p->buf + 1, dname, dlen);
+		} else if (buflen > 0) {
+			/* Partially filled, and drop last dentry name */
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
 static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
 			  const struct path *root, struct prepend_buffer *p)
 {
+	int orig_buflen = p->len;
+
 	while (dentry != root->dentry || &mnt->mnt != root->mnt) {
 		const struct dentry *parent = READ_ONCE(dentry->d_parent);
 
@@ -97,8 +154,7 @@ static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
 			return 3;
 
 		prefetch(parent);
-		if (!prepend_name(p, &dentry->d_name))
-			break;
+		prepend_name_with_len(p, &dentry->d_name, orig_buflen);
 		dentry = parent;
 	}
 	return 0;
@@ -263,6 +319,29 @@ char *d_path(const struct path *path, char *buf, int buflen)
 }
 EXPORT_SYMBOL(d_path);
 
+/**
+ * d_path_unsafe - fast return the full path of a dentry without taking
+ * any seqlock/spinlock. This helper is typical for debugging purpose.
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

