Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7587A660AE4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 01:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbjAGAfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 19:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbjAGAfL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:35:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034AB84BD2
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 16:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673051631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+rn1xIi/vXf3GjGf1plHZZuBGr8pnhw47cogm7ndTTY=;
        b=fktjVTRPPJ8Bd/5pRXVxnftCi7pqy7SASiE7zwj4BTUgI23qND1myIL3nMPwh+4ltrIzgV
        DsYE3XBVXnU7KPLyxHTG/5XdlbV6aR+ZCAqqn8ePIKYgWYmPxZyz6Qo8kxPf4vXLj/mprE
        SAEJpWWgXSIRxlboLhlpHHF3W8Lrx50=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-jruMMBWuPKiacu8jmOLVxQ-1; Fri, 06 Jan 2023 19:33:47 -0500
X-MC-Unique: jruMMBWuPKiacu8jmOLVxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 700813C11A01;
        Sat,  7 Jan 2023 00:33:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B9CC140EBF5;
        Sat,  7 Jan 2023 00:33:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 2/7] iov_iter: Use the direction in the iterator functions
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 07 Jan 2023 00:33:44 +0000
Message-ID: <167305162465.1521586.18077838937455153675.stgit@warthog.procyon.org.uk>
In-Reply-To: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
References: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the direction in the iterator functions rather than READ/WRITE.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
---

 include/linux/uio.h |   22 +++++++++++-----------
 lib/iov_iter.c      |   46 +++++++++++++++++++++++-----------------------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 4b0f4a773d90..acb1ae3324ed 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -261,16 +261,16 @@ bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
 			unsigned len_mask);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
-void iov_iter_init(struct iov_iter *i, unsigned int direction, const struct iovec *iov,
+void iov_iter_init(struct iov_iter *i, enum iter_dir direction, const struct iovec *iov,
 			unsigned long nr_segs, size_t count);
-void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec *kvec,
+void iov_iter_kvec(struct iov_iter *i, enum iter_dir direction, const struct kvec *kvec,
 			unsigned long nr_segs, size_t count);
-void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
+void iov_iter_bvec(struct iov_iter *i, enum iter_dir direction, const struct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
-void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
+void iov_iter_pipe(struct iov_iter *i, enum iter_dir direction, struct pipe_inode_info *pipe,
 			size_t count);
-void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
-void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
+void iov_iter_discard(struct iov_iter *i, enum iter_dir direction, size_t count);
+void iov_iter_xarray(struct iov_iter *i, enum iter_dir direction, struct xarray *xarray,
 		     loff_t start, size_t count);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 		size_t maxsize, unsigned maxpages, size_t *start,
@@ -360,19 +360,19 @@ size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 struct iovec *iovec_from_user(const struct iovec __user *uvector,
 		unsigned long nr_segs, unsigned long fast_segs,
 		struct iovec *fast_iov, bool compat);
-ssize_t import_iovec(int type, const struct iovec __user *uvec,
+ssize_t import_iovec(enum iter_dir direction, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i);
-ssize_t __import_iovec(int type, const struct iovec __user *uvec,
+ssize_t __import_iovec(enum iter_dir direction, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i, bool compat);
-int import_single_range(int type, void __user *buf, size_t len,
+int import_single_range(enum iter_dir direction, void __user *buf, size_t len,
 		 struct iovec *iov, struct iov_iter *i);
 
-static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
+static inline void iov_iter_ubuf(struct iov_iter *i, enum iter_dir direction,
 			void __user *buf, size_t count)
 {
-	WARN_ON(direction & ~(READ | WRITE));
+	WARN_ON(!iov_iter_dir_valid(direction));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_UBUF,
 		.user_backed = true,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9a3ff37ecd1..fec1c5513197 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -421,11 +421,11 @@ size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
 }
 EXPORT_SYMBOL(fault_in_iov_iter_writeable);
 
-void iov_iter_init(struct iov_iter *i, unsigned int direction,
+void iov_iter_init(struct iov_iter *i, enum iter_dir direction,
 			const struct iovec *iov, unsigned long nr_segs,
 			size_t count)
 {
-	WARN_ON(direction & ~(READ | WRITE));
+	WARN_ON(!iov_iter_dir_valid(direction));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_IOVEC,
 		.nofault = false,
@@ -994,11 +994,11 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
 
-void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
+void iov_iter_kvec(struct iov_iter *i, enum iter_dir direction,
 			const struct kvec *kvec, unsigned long nr_segs,
 			size_t count)
 {
-	WARN_ON(direction & ~(READ | WRITE));
+	WARN_ON(!iov_iter_dir_valid(direction));
 	*i = (struct iov_iter){
 		.iter_type = ITER_KVEC,
 		.data_source = direction,
@@ -1010,11 +1010,11 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_kvec);
 
-void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
+void iov_iter_bvec(struct iov_iter *i, enum iter_dir direction,
 			const struct bio_vec *bvec, unsigned long nr_segs,
 			size_t count)
 {
-	WARN_ON(direction & ~(READ | WRITE));
+	WARN_ON(!iov_iter_dir_valid(direction));
 	*i = (struct iov_iter){
 		.iter_type = ITER_BVEC,
 		.data_source = direction,
@@ -1026,15 +1026,15 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 
-void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
+void iov_iter_pipe(struct iov_iter *i, enum iter_dir direction,
 			struct pipe_inode_info *pipe,
 			size_t count)
 {
-	BUG_ON(direction != READ);
+	BUG_ON(direction != ITER_DEST);
 	WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
 	*i = (struct iov_iter){
 		.iter_type = ITER_PIPE,
-		.data_source = false,
+		.data_source = ITER_DEST,
 		.pipe = pipe,
 		.head = pipe->head,
 		.start_head = pipe->head,
@@ -1057,10 +1057,10 @@ EXPORT_SYMBOL(iov_iter_pipe);
  * from evaporation, either by taking a ref on them or locking them by the
  * caller.
  */
-void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
+void iov_iter_xarray(struct iov_iter *i, enum iter_dir direction,
 		     struct xarray *xarray, loff_t start, size_t count)
 {
-	BUG_ON(direction & ~1);
+	WARN_ON(!iov_iter_dir_valid(direction));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_XARRAY,
 		.data_source = direction,
@@ -1079,14 +1079,14 @@ EXPORT_SYMBOL(iov_iter_xarray);
  * @count: The size of the I/O buffer in bytes.
  *
  * Set up an I/O iterator that just discards everything that's written to it.
- * It's only available as a READ iterator.
+ * It's only available as a destination iterator.
  */
-void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
+void iov_iter_discard(struct iov_iter *i, enum iter_dir direction, size_t count)
 {
-	BUG_ON(direction != READ);
+	BUG_ON(direction != ITER_DEST);
 	*i = (struct iov_iter){
 		.iter_type = ITER_DISCARD,
-		.data_source = false,
+		.data_source = ITER_DEST,
 		.count = count,
 		.iov_offset = 0
 	};
@@ -1447,7 +1447,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		unsigned long addr;
 		int res;
 
-		if (iov_iter_rw(i) != WRITE)
+		if (iov_iter_is_dest(i))
 			gup_flags |= FOLL_WRITE;
 		if (i->nofault)
 			gup_flags |= FOLL_NOFAULT;
@@ -1784,7 +1784,7 @@ struct iovec *iovec_from_user(const struct iovec __user *uvec,
 	return iov;
 }
 
-ssize_t __import_iovec(int type, const struct iovec __user *uvec,
+ssize_t __import_iovec(enum iter_dir direction, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i, bool compat)
 {
@@ -1823,7 +1823,7 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 		total_len += len;
 	}
 
-	iov_iter_init(i, type, iov, nr_segs, total_len);
+	iov_iter_init(i, direction, iov, nr_segs, total_len);
 	if (iov == *iovp)
 		*iovp = NULL;
 	else
@@ -1836,7 +1836,7 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
  *     into the kernel, check that it is valid, and initialize a new
  *     &struct iov_iter iterator to access it.
  *
- * @type: One of %READ or %WRITE.
+ * @direction: One of %ITER_SOURCE or %ITER_DEST.
  * @uvec: Pointer to the userspace array.
  * @nr_segs: Number of elements in userspace array.
  * @fast_segs: Number of elements in @iov.
@@ -1853,16 +1853,16 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
  *
  * Return: Negative error code on error, bytes imported on success
  */
-ssize_t import_iovec(int type, const struct iovec __user *uvec,
+ssize_t import_iovec(enum iter_dir direction, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs,
 		 struct iovec **iovp, struct iov_iter *i)
 {
-	return __import_iovec(type, uvec, nr_segs, fast_segs, iovp, i,
+	return __import_iovec(direction, uvec, nr_segs, fast_segs, iovp, i,
 			      in_compat_syscall());
 }
 EXPORT_SYMBOL(import_iovec);
 
-int import_single_range(int rw, void __user *buf, size_t len,
+int import_single_range(enum iter_dir direction, void __user *buf, size_t len,
 		 struct iovec *iov, struct iov_iter *i)
 {
 	if (len > MAX_RW_COUNT)
@@ -1872,7 +1872,7 @@ int import_single_range(int rw, void __user *buf, size_t len,
 
 	iov->iov_base = buf;
 	iov->iov_len = len;
-	iov_iter_init(i, rw, iov, 1, len);
+	iov_iter_init(i, direction, iov, 1, len);
 	return 0;
 }
 EXPORT_SYMBOL(import_single_range);


