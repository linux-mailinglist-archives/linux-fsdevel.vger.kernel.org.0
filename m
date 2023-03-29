Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5056CF253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjC2SlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC2SlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:05 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7368186
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:02 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id o12so7243321iow.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115262; x=1682707262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5KADcBCQpRfoMxkvcFrp6CNMp4s704nt9GxbLk5mRk=;
        b=nWdycVsGGnTkb0KL3x/WbQKyUgfgtr0eaATuLfjWJRZBN6rb/fEU61r20Ka1NNihh7
         GwA7MrkMgY77qdf/YWd2EOMksSeeug+7OIlgbZ5Ai4qMwAxtDqldO3UBMAZj+yYQ8YH9
         h0ZFF/xGA05+i5sv3R6HvuJDl3bkr6p0GMtCy6UNfz7LEYBCDxxvhiw2XlpXlNhD+FKy
         74AIfEaB1e38gPpCptVTkRbDMTXTgf+9UT2xxO1RFbnxIVAP6gefP0Ze8aYYR9cWMBx0
         9hJetdSCseZRTs+Zv9eL2IOfZyPpQHvCJsAxR+Fs2Mc3Qh7BanvR24okoZTHH+uavlp7
         zhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115262; x=1682707262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5KADcBCQpRfoMxkvcFrp6CNMp4s704nt9GxbLk5mRk=;
        b=AHIZZXyeAtBsZJatxpq69bOrKQANw/OYnXjwh3cCoRQrlPHJsTMrXuTsHifBcM0VfZ
         zmhCiuXZwpTl55KzxbBefhtdBpOIJBu3lHG2TBqQrLgpgQf70rLBdcaiPayOU/T41fU0
         fQEiSlM3ewL83lCV6QxE5rLmYLb6tPQL3vMpMlSikqBqB3lBG44GoH/zhfSgz3BbQ0tT
         KtTGeaX0cwN+Yy/tUavaPewdFgtzSmg/Y0B46UkEeixtU3O2KnRsdkqNUz3aIsLSsU5V
         qWLrkYFaZWryZ9OXUrFEA4406AI76p9WBDu5is753ToGBtmFrU5vszNLUMmVVhNqfjbq
         4aOQ==
X-Gm-Message-State: AO0yUKUQKJsdvMmbc7Hh72mNg8Pw8j6gNnGYq2LkInwWLX1F96cBAH1U
        Oi9qUba+iE30Nd2ug1f+A+VwlyZZ9dFicQltsaQSzQ==
X-Google-Smtp-Source: AK7set/rKxF0aenbWIHl6xpcUHtWHJcHn+ym4kcfPVjbUYynt4zu2nzTms5QRLGUoXOqQdCYKfPEnQ==
X-Received: by 2002:a6b:b257:0:b0:758:8b42:ce5a with SMTP id b84-20020a6bb257000000b007588b42ce5amr11978855iof.1.1680115261721;
        Wed, 29 Mar 2023 11:41:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:41:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/11] iov_iter: add iter_iovec() helper
Date:   Wed, 29 Mar 2023 12:40:46 -0600
Message-Id: <20230329184055.1307648-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329184055.1307648-1-axboe@kernel.dk>
References: <20230329184055.1307648-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This returns a pointer to the current iovec entry in the iterator. Only
useful with ITER_IOVEC right now, but it prepares us to treat ITER_UBUF
and ITER_IOVEC identically for the first segment.

Rename struct iov_iter->iov to iov_iter->__iov to find any potentially
troublesome spots, and also to prevent anyone from adding new code that
accesses iter->iov directly.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-map.c                          |  4 +-
 drivers/infiniband/hw/hfi1/file_ops.c    |  3 +-
 drivers/infiniband/hw/qib/qib_file_ops.c |  2 +-
 drivers/net/tun.c                        |  3 +-
 drivers/vhost/scsi.c                     |  2 +-
 fs/btrfs/file.c                          | 11 +++--
 fs/fuse/file.c                           |  2 +-
 include/linux/uio.h                      |  9 ++--
 io_uring/net.c                           |  4 +-
 io_uring/rw.c                            |  8 ++--
 lib/iov_iter.c                           | 56 +++++++++++++-----------
 sound/core/pcm_native.c                  | 22 ++++++----
 12 files changed, 73 insertions(+), 53 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 3bfcad64d67c..04c55f1c492e 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -31,8 +31,8 @@ static struct bio_map_data *bio_alloc_map_data(struct iov_iter *data,
 		return NULL;
 	bmd->iter = *data;
 	if (iter_is_iovec(data)) {
-		memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);
-		bmd->iter.iov = bmd->iov;
+		memcpy(bmd->iov, iter_iov(data), sizeof(struct iovec) * data->nr_segs);
+		bmd->iter.__iov = bmd->iov;
 	}
 	return bmd;
 }
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index b1d6ca7e9708..3065db9d6bb9 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -287,11 +287,12 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	}
 
 	while (dim) {
+		const struct iovec *iov = iter_iov(from);
 		int ret;
 		unsigned long count = 0;
 
 		ret = hfi1_user_sdma_process_request(
-			fd, (struct iovec *)(from->iov + done),
+			fd, (struct iovec *)(iov + done),
 			dim, &count);
 		if (ret) {
 			reqs = ret;
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 80fe92a21f96..4cee39337866 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -2248,7 +2248,7 @@ static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (!iter_is_iovec(from) || !from->nr_segs || !pq)
 		return -EINVAL;
 
-	return qib_user_sdma_writev(rcd, pq, from->iov, from->nr_segs);
+	return qib_user_sdma_writev(rcd, pq, iter_iov(from), from->nr_segs);
 }
 
 static struct class *qib_class;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ad653b32b2f0..5df1eba7b30a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1486,7 +1486,8 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
 	skb->truesize += skb->data_len;
 
 	for (i = 1; i < it->nr_segs; i++) {
-		size_t fragsz = it->iov[i].iov_len;
+		const struct iovec *iov = iter_iov(it);
+		size_t fragsz = iov->iov_len;
 		struct page *page;
 		void *frag;
 
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index b244e7c0f514..042caea64007 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -671,7 +671,7 @@ vhost_scsi_calc_sgls(struct iov_iter *iter, size_t bytes, int max_sgls)
 {
 	int sgl_count = 0;
 
-	if (!iter || !iter->iov) {
+	if (!iter || !iter_iov(iter)) {
 		pr_err("%s: iter->iov is NULL, but expected bytes: %zu"
 		       " present\n", __func__, bytes);
 		return -EINVAL;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5cc5a1faaef5..f649647392e0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3730,10 +3730,15 @@ static int check_direct_read(struct btrfs_fs_info *fs_info,
 	if (!iter_is_iovec(iter))
 		return 0;
 
-	for (seg = 0; seg < iter->nr_segs; seg++)
-		for (i = seg + 1; i < iter->nr_segs; i++)
-			if (iter->iov[seg].iov_base == iter->iov[i].iov_base)
+	for (seg = 0; seg < iter->nr_segs; seg++) {
+		for (i = seg + 1; i < iter->nr_segs; i++) {
+			const struct iovec *iov1 = iter_iov(iter) + seg;
+			const struct iovec *iov2 = iter_iov(iter) + i;
+
+			if (iov1->iov_base == iov2->iov_base)
 				return -EINVAL;
+		}
+	}
 	return 0;
 }
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index de37a3a06a71..89d97f6188e0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1419,7 +1419,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 static inline unsigned long fuse_get_user_addr(const struct iov_iter *ii)
 {
-	return (unsigned long)ii->iov->iov_base + ii->iov_offset;
+	return (unsigned long)iter_iov(ii)->iov_base + ii->iov_offset;
 }
 
 static inline size_t fuse_get_frag_size(const struct iov_iter *ii,
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 27e3fd942960..4218624b7f78 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -51,7 +51,8 @@ struct iov_iter {
 	};
 	size_t count;
 	union {
-		const struct iovec *iov;
+		/* use iter_iov() to get the current vec */
+		const struct iovec *__iov;
 		const struct kvec *kvec;
 		const struct bio_vec *bvec;
 		struct xarray *xarray;
@@ -68,6 +69,8 @@ struct iov_iter {
 	};
 };
 
+#define iter_iov(iter)	(iter)->__iov
+
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 {
 	return i->iter_type;
@@ -146,9 +149,9 @@ static inline size_t iov_length(const struct iovec *iov, unsigned long nr_segs)
 static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 {
 	return (struct iovec) {
-		.iov_base = iter->iov->iov_base + iter->iov_offset,
+		.iov_base = iter_iov(iter)->iov_base + iter->iov_offset,
 		.iov_len = min(iter->count,
-			       iter->iov->iov_len - iter->iov_offset),
+			       iter_iov(iter)->iov_len - iter->iov_offset),
 	};
 }
 
diff --git a/io_uring/net.c b/io_uring/net.c
index 4040cf093318..89e839013837 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -184,8 +184,8 @@ static int io_setup_async_msg(struct io_kiocb *req,
 		async_msg->msg.msg_name = &async_msg->addr;
 	/* if were using fast_iov, set it to the new one */
 	if (iter_is_iovec(&kmsg->msg.msg_iter) && !kmsg->free_iov) {
-		size_t fast_idx = kmsg->msg.msg_iter.iov - kmsg->fast_iov;
-		async_msg->msg.msg_iter.iov = &async_msg->fast_iov[fast_idx];
+		size_t fast_idx = iter_iov(&kmsg->msg.msg_iter) - kmsg->fast_iov;
+		async_msg->msg.msg_iter.__iov = &async_msg->fast_iov[fast_idx];
 	}
 
 	return -EAGAIN;
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 4c233910e200..7573a34ea42a 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -503,10 +503,10 @@ static void io_req_map_rw(struct io_kiocb *req, const struct iovec *iovec,
 	if (!iovec) {
 		unsigned iov_off = 0;
 
-		io->s.iter.iov = io->s.fast_iov;
-		if (iter->iov != fast_iov) {
-			iov_off = iter->iov - fast_iov;
-			io->s.iter.iov += iov_off;
+		io->s.iter.__iov = io->s.fast_iov;
+		if (iter->__iov != fast_iov) {
+			iov_off = iter_iov(iter) - fast_iov;
+			io->s.iter.__iov += iov_off;
 		}
 		if (io->s.fast_iov != fast_iov)
 			memcpy(io->s.fast_iov + iov_off, fast_iov + iov_off,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 274014e4eafe..87488c4aad3f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -126,13 +126,13 @@ __out:								\
 			iterate_buf(i, n, base, len, off,	\
 						i->ubuf, (I)) 	\
 		} else if (likely(iter_is_iovec(i))) {		\
-			const struct iovec *iov = i->iov;	\
+			const struct iovec *iov = iter_iov(i);	\
 			void __user *base;			\
 			size_t len;				\
 			iterate_iovec(i, n, base, len, off,	\
 						iov, (I))	\
-			i->nr_segs -= iov - i->iov;		\
-			i->iov = iov;				\
+			i->nr_segs -= iov - iter_iov(i);	\
+			i->__iov = iov;				\
 		} else if (iov_iter_is_bvec(i)) {		\
 			const struct bio_vec *bvec = i->bvec;	\
 			void *base;				\
@@ -355,7 +355,7 @@ size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size)
 		size_t skip;
 
 		size -= count;
-		for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
+		for (p = iter_iov(i), skip = i->iov_offset; count; p++, skip = 0) {
 			size_t len = min(count, p->iov_len - skip);
 			size_t ret;
 
@@ -398,7 +398,7 @@ size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
 		size_t skip;
 
 		size -= count;
-		for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
+		for (p = iter_iov(i), skip = i->iov_offset; count; p++, skip = 0) {
 			size_t len = min(count, p->iov_len - skip);
 			size_t ret;
 
@@ -425,7 +425,7 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 		.nofault = false,
 		.user_backed = true,
 		.data_source = direction,
-		.iov = iov,
+		.__iov = iov,
 		.nr_segs = nr_segs,
 		.iov_offset = 0,
 		.count = count
@@ -876,14 +876,14 @@ static void iov_iter_iovec_advance(struct iov_iter *i, size_t size)
 	i->count -= size;
 
 	size += i->iov_offset; // from beginning of current segment
-	for (iov = i->iov, end = iov + i->nr_segs; iov < end; iov++) {
+	for (iov = iter_iov(i), end = iov + i->nr_segs; iov < end; iov++) {
 		if (likely(size < iov->iov_len))
 			break;
 		size -= iov->iov_len;
 	}
 	i->iov_offset = size;
-	i->nr_segs -= iov - i->iov;
-	i->iov = iov;
+	i->nr_segs -= iov - iter_iov(i);
+	i->__iov = iov;
 }
 
 void iov_iter_advance(struct iov_iter *i, size_t size)
@@ -958,12 +958,12 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 			unroll -= n;
 		}
 	} else { /* same logics for iovec and kvec */
-		const struct iovec *iov = i->iov;
+		const struct iovec *iov = iter_iov(i);
 		while (1) {
 			size_t n = (--iov)->iov_len;
 			i->nr_segs++;
 			if (unroll <= n) {
-				i->iov = iov;
+				i->__iov = iov;
 				i->iov_offset = n - unroll;
 				return;
 			}
@@ -980,7 +980,7 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 {
 	if (i->nr_segs > 1) {
 		if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
-			return min(i->count, i->iov->iov_len - i->iov_offset);
+			return min(i->count, iter_iov(i)->iov_len - i->iov_offset);
 		if (iov_iter_is_bvec(i))
 			return min(i->count, i->bvec->bv_len - i->iov_offset);
 	}
@@ -1095,13 +1095,14 @@ static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned addr_mask,
 	unsigned k;
 
 	for (k = 0; k < i->nr_segs; k++, skip = 0) {
-		size_t len = i->iov[k].iov_len - skip;
+		const struct iovec *iov = iter_iov(i) + k;
+		size_t len = iov->iov_len - skip;
 
 		if (len > size)
 			len = size;
 		if (len & len_mask)
 			return false;
-		if ((unsigned long)(i->iov[k].iov_base + skip) & addr_mask)
+		if ((unsigned long)(iov->iov_base + skip) & addr_mask)
 			return false;
 
 		size -= len;
@@ -1194,9 +1195,10 @@ static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 	unsigned k;
 
 	for (k = 0; k < i->nr_segs; k++, skip = 0) {
-		size_t len = i->iov[k].iov_len - skip;
+		const struct iovec *iov = iter_iov(i) + k;
+		size_t len = iov->iov_len - skip;
 		if (len) {
-			res |= (unsigned long)i->iov[k].iov_base + skip;
+			res |= (unsigned long)iov->iov_base + skip;
 			if (len > size)
 				len = size;
 			res |= len;
@@ -1273,14 +1275,15 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 		return ~0U;
 
 	for (k = 0; k < i->nr_segs; k++) {
-		if (i->iov[k].iov_len) {
-			unsigned long base = (unsigned long)i->iov[k].iov_base;
+		const struct iovec *iov = iter_iov(i) + k;
+		if (iov->iov_len) {
+			unsigned long base = (unsigned long)iov->iov_base;
 			if (v) // if not the first one
 				res |= base | v; // this start | previous end
-			v = base + i->iov[k].iov_len;
-			if (size <= i->iov[k].iov_len)
+			v = base + iov->iov_len;
+			if (size <= iov->iov_len)
 				break;
-			size -= i->iov[k].iov_len;
+			size -= iov->iov_len;
 		}
 	}
 	return res;
@@ -1396,13 +1399,14 @@ static unsigned long first_iovec_segment(const struct iov_iter *i, size_t *size)
 		return (unsigned long)i->ubuf + i->iov_offset;
 
 	for (k = 0, skip = i->iov_offset; k < i->nr_segs; k++, skip = 0) {
-		size_t len = i->iov[k].iov_len - skip;
+		const struct iovec *iov = iter_iov(i) + k;
+		size_t len = iov->iov_len - skip;
 
 		if (unlikely(!len))
 			continue;
 		if (*size > len)
 			*size = len;
-		return (unsigned long)i->iov[k].iov_base + skip;
+		return (unsigned long)iov->iov_base + skip;
 	}
 	BUG(); // if it had been empty, we wouldn't get called
 }
@@ -1614,7 +1618,7 @@ static int iov_npages(const struct iov_iter *i, int maxpages)
 	const struct iovec *p;
 	int npages = 0;
 
-	for (p = i->iov; size; skip = 0, p++) {
+	for (p = iter_iov(i); size; skip = 0, p++) {
 		unsigned offs = offset_in_page(p->iov_base + skip);
 		size_t len = min(p->iov_len - skip, size);
 
@@ -1691,7 +1695,7 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 				    flags);
 	else if (iov_iter_is_kvec(new) || iter_is_iovec(new))
 		/* iovec and kvec have identical layout */
-		return new->iov = kmemdup(new->iov,
+		return new->__iov = kmemdup(new->__iov,
 				   new->nr_segs * sizeof(struct iovec),
 				   flags);
 	return NULL;
@@ -1918,7 +1922,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 	if (iov_iter_is_bvec(i))
 		i->bvec -= state->nr_segs - i->nr_segs;
 	else
-		i->iov -= state->nr_segs - i->nr_segs;
+		i->__iov -= state->nr_segs - i->nr_segs;
 	i->nr_segs = state->nr_segs;
 }
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 331380c2438b..8bb97ee6720d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3521,6 +3521,7 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 	unsigned long i;
 	void __user **bufs;
 	snd_pcm_uframes_t frames;
+	const struct iovec *iov = iter_iov(to);
 
 	pcm_file = iocb->ki_filp->private_data;
 	substream = pcm_file->substream;
@@ -3534,14 +3535,16 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 		return -EINVAL;
 	if (to->nr_segs > 1024 || to->nr_segs != runtime->channels)
 		return -EINVAL;
-	if (!frame_aligned(runtime, to->iov->iov_len))
+	if (!frame_aligned(runtime, iov->iov_len))
 		return -EINVAL;
-	frames = bytes_to_samples(runtime, to->iov->iov_len);
+	frames = bytes_to_samples(runtime, iov->iov_len);
 	bufs = kmalloc_array(to->nr_segs, sizeof(void *), GFP_KERNEL);
 	if (bufs == NULL)
 		return -ENOMEM;
-	for (i = 0; i < to->nr_segs; ++i)
-		bufs[i] = to->iov[i].iov_base;
+	for (i = 0; i < to->nr_segs; ++i) {
+		bufs[i] = iov->iov_base;
+		iov++;
+	}
 	result = snd_pcm_lib_readv(substream, bufs, frames);
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
@@ -3558,6 +3561,7 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	unsigned long i;
 	void __user **bufs;
 	snd_pcm_uframes_t frames;
+	const struct iovec *iov = iter_iov(from);
 
 	pcm_file = iocb->ki_filp->private_data;
 	substream = pcm_file->substream;
@@ -3570,14 +3574,16 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	if (!iter_is_iovec(from))
 		return -EINVAL;
 	if (from->nr_segs > 128 || from->nr_segs != runtime->channels ||
-	    !frame_aligned(runtime, from->iov->iov_len))
+	    !frame_aligned(runtime, iov->iov_len))
 		return -EINVAL;
-	frames = bytes_to_samples(runtime, from->iov->iov_len);
+	frames = bytes_to_samples(runtime, iov->iov_len);
 	bufs = kmalloc_array(from->nr_segs, sizeof(void *), GFP_KERNEL);
 	if (bufs == NULL)
 		return -ENOMEM;
-	for (i = 0; i < from->nr_segs; ++i)
-		bufs[i] = from->iov[i].iov_base;
+	for (i = 0; i < from->nr_segs; ++i) {
+		bufs[i] = iov->iov_base;
+		iov++;
+	}
 	result = snd_pcm_lib_writev(substream, bufs, frames);
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
-- 
2.39.2

