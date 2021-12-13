Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9C5471F94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 04:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhLMDaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 22:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLMDaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:30:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4FFC06173F
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Dec 2021 19:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4SqXW33yUre+xkYO0PBFilV3/sjnlMlgspRn/gOvV5A=; b=JTsFsMhhpWZpuUhJ1Ta8OZKfm+
        i2ztTFZiQ2KHkzsXHxrLcrBipYBCNk+nY+yWwfcYuR9t/vzdZseZMvDsynEgxOBi5PxS8zGZwXrmP
        V2H1UFEw01xksSluRpRm7ByJ4K1endvjq/OrNqHcO0cMIxfGsAUyQDwSjOqLmaVkgal98ohkhHdnI
        acG95j4PchozOB8RKEVZCGC516E3Ht92/2DTAAdSVwumn9pFAvRjJSQAegTisG9buAph+/5f8q5X0
        qQVHR0AlQvEN73eTADTBn8KNIEF5H/cV03DwvOGvF0qwO9H4GR8OcKv3SkfFMW/LzFI3qOFC9+Qii
        pmgznvTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwc2z-00CPL3-Uf; Mon, 13 Dec 2021 03:30:42 +0000
Date:   Mon, 13 Dec 2021 03:30:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [RFC] iov_iter support for a single kernel address
Message-ID: <Yba+YSF6mkM/GYlK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


When working on the vmcore conversion to iov_iter, I noticed we had a
lot of places that construct a single kvec on the stack, and it seems a
little wasteful.  Adding an ITER_KADDR type makes the iov_iter a little
easier to use.

I included conversion of 9p to use ITER_KADDR so you can see whether you
think it's worth doing.

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
