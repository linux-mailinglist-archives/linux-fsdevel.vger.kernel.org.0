Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD28472EAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 15:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbhLMOTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 09:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhLMOTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:19:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D8C061574;
        Mon, 13 Dec 2021 06:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yWA4c0QfBa3QlJ8hhOMcOaJySGUuMbjYLGgiVEU05J0=; b=G4TVTzRK18vM/62jcQS5SO7VgL
        /Ms+ahnlCsJzB3lT3fWBUocIWYPmDbr9qspKPwfXl3FOzM60wO6+v1o3tHV8BTDJR8geqH5neqq0O
        cLmnsponzynvu8ZQCC4+XcXXHfuyuhFIi2H6m046WOpsHcqT1QAq0JKtsA8rGyAxfqaFL+cpNjpyp
        3OHUCHhywOPS6Qgd5XjfSrXBOUtDY/lRefFyMgs85Wj/ckqZA1Z/y4MSrtNEjzafaFbTPLb+hrWqs
        pmWgQ3wNQkkuKmJaklVGubZJngcxEc4NxuKKNhn+3aV+CJZmnn/xXRQ44DQLlVyrlUQH9Z7qlv6Zj
        AmM/6uzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwmAZ-00CrEQ-T8; Mon, 13 Dec 2021 14:19:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/3] iov-kaddr
Date:   Mon, 13 Dec 2021 14:19:07 +0000
Message-Id: <20211213141907.3064347-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213141907.3064347-1-willy@infradead.org>
References: <20211213141907.3064347-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---
 fs/9p/vfs_dir.c     |  5 +----
 fs/9p/xattr.c       |  6 ++----
 include/linux/uio.h |  9 +++++++++
 lib/iov_iter.c      | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 8c854d8cb0cd..cad6c24f9f0d 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -90,7 +90,6 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 	struct p9_fid *fid;
 	int buflen;
 	struct p9_rdir *rdir;
-	struct kvec kvec;
 
 	p9_debug(P9_DEBUG_VFS, "name %pD\n", file);
 	fid = file->private_data;
@@ -100,15 +99,13 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 	rdir = v9fs_alloc_rdir_buf(file, buflen);
 	if (!rdir)
 		return -ENOMEM;
-	kvec.iov_base = rdir->buf;
-	kvec.iov_len = buflen;
 
 	while (1) {
 		if (rdir->tail == rdir->head) {
 			struct iov_iter to;
 			int n;
 
-			iov_iter_kvec(&to, READ, &kvec, 1, buflen);
+			iov_iter_kaddr(&to, READ, rdir->buf, buflen);
 			n = p9_client_read(file->private_data, ctx->pos, &to,
 					   &err);
 			if (err)
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index a824441b95a2..6fb0e7640605 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -20,11 +20,10 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 	ssize_t retval;
 	u64 attr_size;
 	struct p9_fid *attr_fid;
-	struct kvec kvec = {.iov_base = buffer, .iov_len = buffer_size};
 	struct iov_iter to;
 	int err;
 
-	iov_iter_kvec(&to, READ, &kvec, 1, buffer_size);
+	iov_iter_kaddr(&to, READ, buffer, buffer_size);
 
 	attr_fid = p9_client_xattrwalk(fid, name, &attr_size);
 	if (IS_ERR(attr_fid)) {
@@ -105,11 +104,10 @@ int v9fs_xattr_set(struct dentry *dentry, const char *name,
 int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 		   const void *value, size_t value_len, int flags)
 {
-	struct kvec kvec = {.iov_base = (void *)value, .iov_len = value_len};
 	struct iov_iter from;
 	int retval, err;
 
-	iov_iter_kvec(&from, WRITE, &kvec, 1, value_len);
+	iov_iter_kaddr(&from, WRITE, (void *)value, value_len);
 
 	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu flags = %d\n",
 		 name, value_len, flags);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6350354f97e9..cedbc1ca5c15 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -23,6 +23,7 @@ enum iter_type {
 	ITER_KVEC,
 	ITER_BVEC,
 	ITER_PIPE,
+	ITER_KADDR,
 	ITER_XARRAY,
 	ITER_DISCARD,
 };
@@ -43,6 +44,7 @@ struct iov_iter {
 		const struct iovec *iov;
 		const struct kvec *kvec;
 		const struct bio_vec *bvec;
+		void *kaddr;
 		struct xarray *xarray;
 		struct pipe_inode_info *pipe;
 	};
@@ -79,6 +81,11 @@ static inline bool iov_iter_is_kvec(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_KVEC;
 }
 
+static inline bool iov_iter_is_kaddr(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_KVEC;
+}
+
 static inline bool iov_iter_is_bvec(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_BVEC;
@@ -236,6 +243,8 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction, const struct iove
 			unsigned long nr_segs, size_t count);
 void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec *kvec,
 			unsigned long nr_segs, size_t count);
+void iov_iter_kaddr(struct iov_iter *i, unsigned int direction, void *kaddr,
+			size_t count);
 void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
 void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 66a740e6e153..64e6bc33176a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -38,6 +38,22 @@
 	n = off;						\
 }
 
+#define iterate_kaddr(i, n, base, len, off, STEP) {		\
+	void *base;						\
+	size_t len;						\
+	size_t off = 0;						\
+	size_t skip = i->iov_offset;				\
+	len = min(n, i->count - skip);				\
+	if (likely(len)) {					\
+		base = i->kaddr + skip;				\
+		len -= (STEP);					\
+		off += len;					\
+		skip += len;					\
+	}							\
+	i->iov_offset = skip;					\
+	n = off;						\
+}
+
 #define iterate_bvec(i, n, base, len, off, p, STEP) {		\
 	size_t off = 0;						\
 	unsigned skip = i->iov_offset;				\
@@ -136,6 +152,8 @@ __out:								\
 						kvec, (K))	\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
+		} else if (iov_iter_is_kaddr(i)) {		\
+			iterate_kaddr(i, n, base, len, off, (K)) \
 		} else if (iov_iter_is_xarray(i)) {		\
 			void *base;				\
 			size_t len;				\
@@ -1185,6 +1203,20 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_kvec);
 
+void iov_iter_kaddr(struct iov_iter *i, unsigned int direction,
+			void *kaddr, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_KADDR,
+		.data_source = direction,
+		.kaddr = kaddr,
+		.iov_offset = 0,
+		.count = count
+	};
+}
+EXPORT_SYMBOL(iov_iter_kaddr);
+
 void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 			const struct bio_vec *bvec, unsigned long nr_segs,
 			size_t count)
-- 
2.33.0

