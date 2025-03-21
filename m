Return-Path: <linux-fsdevel+bounces-44725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F23CA6BF78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 17:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CBF3B09AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140622CBC4;
	Fri, 21 Mar 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQWQK0Ee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3C22DF81
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573683; cv=none; b=qbNB8HXUXn31SPGBZT2OYSr9jJ94YhVkS1hb6NEdaoYljr0MhDtB29xrkfKoOCcBiRFIXCI9MEFW/usJNv6yBvWsJZz484x6fu5d78AQPlngygPfTW9b5BztnVa9GOtP7Fs+D3kJsYazk31KtMgDMK5ayqdKBsShp25e+VZcNAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573683; c=relaxed/simple;
	bh=QJbi407Gq8VLLgi9E0vdiZ8uX6C0oRfqhu+9aRZPznQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daf9Kc8qBWAh2eyahM3RwOU6y2rDFcNCQviNS7yNvYmcMjX3pcq/4Fq1KcquJyD7mgSYN2R6UQ0SwGPYpVFui4pqOlHbRfERb4Y2xK44egekI8pHkhEbJn4I1jS5t0oF5DC5LTWuZe+xpyeNqque/RL176RliqUITTS3Bgfz7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQWQK0Ee; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742573680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSC5YwicpO03gYExoUotpiHs2EHAFn+TU50pqasUPmU=;
	b=TQWQK0EeiuoOCGDIzS8MkckStpt1RYcUxfP0h85eTS+bo0po6tcVT47WGopRzyHdGXYKtr
	PDReQ0vIr5YK2VhBGnziXDVVBQJ+HVgHnb038dS/DM3v67zEzz/nvKI8mQCfa/VKfs62vn
	amvsK5w4W/YYo1a/VWm2M3fRfpuTfik=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-Ev37cor8PDCv9N0Af2ivaQ-1; Fri,
 21 Mar 2025 12:14:37 -0400
X-MC-Unique: Ev37cor8PDCv9N0Af2ivaQ-1
X-Mimecast-MFC-AGG-ID: Ev37cor8PDCv9N0Af2ivaQ_1742573674
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3680C1801A07;
	Fri, 21 Mar 2025 16:14:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED872180174E;
	Fri, 21 Mar 2025 16:14:30 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steve French <smfrench@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] iov_iter: Add a scatterlist iterator type [INCOMPLETE]
Date: Fri, 21 Mar 2025 16:14:04 +0000
Message-ID: <20250321161407.3333724-5-dhowells@redhat.com>
In-Reply-To: <20250321161407.3333724-1-dhowells@redhat.com>
References: <20250321161407.3333724-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add an iterator type that can iterate over a socket buffer.

[!] Note this is not yet completely implemented and won't compile.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/uio.h |  10 ++++
 lib/iov_iter.c      | 121 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 0e50f4af6877..87d6ba660489 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -13,6 +13,7 @@
 struct page;
 struct folio_queue;
 struct scatterlist;
+struct sk_buff;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -32,6 +33,7 @@ enum iter_type {
 	ITER_DISCARD,
 	ITER_ITERLIST,
 	ITER_SCATTERLIST,
+	ITER_SKBUFF,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -77,6 +79,7 @@ struct iov_iter {
 				void __user *ubuf;
 				struct iov_iterlist *iterlist;
 				struct scatterlist *sglist;
+				const struct sk_buff *skb;
 			};
 			size_t count;
 		};
@@ -171,6 +174,11 @@ static inline bool iov_iter_is_scatterlist(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_SCATTERLIST;
 }
 
+static inline bool iov_iter_is_skbuff(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_SKBUFF;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -329,6 +337,8 @@ void iov_iter_iterlist(struct iov_iter *i, unsigned int direction,
 		       size_t count);
 void iov_iter_scatterlist(struct iov_iter *i, unsigned int direction,
 			  struct scatterlist *sglist, size_t count);
+void iov_iter_skbuff(struct iov_iter *i, unsigned int direction,
+		     const struct sk_buff *skb, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index ed9859af3c5d..01215316d272 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -12,6 +12,7 @@
 #include <linux/scatterlist.h>
 #include <linux/instrumented.h>
 #include <linux/iov_iter.h>
+#include <linux/skbuff.h>
 
 static __always_inline
 size_t copy_to_user_iter(void __user *iter_to, size_t progress,
@@ -918,6 +919,29 @@ void iov_iter_scatterlist(struct iov_iter *iter, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_scatterlist);
 
+/**
+ * iov_iter_skbuff - Initialise an I/O iterator for a socket buffer
+ * @iter: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @skb: The socket buffer
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator that walks over a socket buffer.
+ */
+void iov_iter_skbuff(struct iov_iter *i, unsigned int direction,
+		     const struct sk_buff *skb, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*iter = (struct iov_iter){
+		.iter_type	= ITER_SKBUFF,
+		.data_source	= direction,
+		.skb		= skb,
+		.iov_offset	= 0,
+		.count		= count,
+	};
+}
+EXPORT_SYMBOL(iov_iter_skbuff);
+
 static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned addr_mask,
 				   unsigned len_mask)
 {
@@ -2314,6 +2338,10 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 		return iov_iter_extract_scatterlist_pages(i, pages, maxsize,
 							  maxpages, extraction_flags,
 							  offset0);
+	if (iov_iter_is_skbuff(i))
+		return iov_iter_extract_skbuff_pages(i, pages, maxsize,
+						     maxpages, extraction_flags,
+						     offset0);
 	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
@@ -2449,6 +2477,97 @@ static size_t iterate_scatterlist(struct iov_iter *iter, size_t len, void *priv,
 	return progress;
 }
 
+struct skbuff_iter_ctx {
+	iov_step_f	step;
+	size_t		progress;
+	void		*priv;
+	void		*priv2;
+};
+
+static bool iterate_skbuff_frag(const struct sk_buff *skb, struct skbuff_iter_ctx *ctx,
+				int offset, int len, int recursion_level)
+{
+	struct sk_buff *frag_iter;
+	size_t skip = offset, part, remain, consumed;
+
+	if (unlikely(recursion_level >= 24))
+		return false;
+
+	part = skb_headlen(skb);
+	if (skip < part) {
+		part = umin(part - skip, len);
+		remain = ctx->step(skb->data + skip, ctx->progress, part,
+				   ctx->priv, ctx->priv2);
+		consumed = part - remain;
+		ctx->progress += consumed;
+		len -= consumed;
+		if (remain > 0 || len <= 0)
+			return false;
+		skip = 0;
+	} else {
+		skip -= part;
+	}
+
+	for (int i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		size_t fsize = skb_frag_size(frag);
+
+		if (skip >= fsize) {
+			skip -= fsize;
+			continue;
+		}
+
+		part = umin(fsize - skip, len);
+		remain = ctx->step(skb_frag_address(frag) + skip,
+				   ctx->progress, part, ctx->priv, ctx->priv2);
+		consumed = part - remain;
+		ctx->progress += consumed;
+		len -= consumed;
+		if (remain > 0 || len <= 0)
+			return false;
+		skip = 0;
+	}
+
+	skb_walk_frags(skb, frag_iter) {
+		size_t fsize = frag_iter->len;
+
+		if (skip >= fsize) {
+			skip -= fsize;
+			continue;
+		}
+
+		part = umin(fsize - skip, len);
+		if (!iterate_skbuff_frag(frag_iter, ctx, skb_headlen(skb) + skip,
+					 part, recursion_level + 1))
+			return false;
+		len -= part;
+		if (len <= 0)
+			return false;
+		skip = 0;
+	}
+	return true;
+}
+
+/*
+ * Handle iteration over ITER_SKBUFF.  Modelled on __skb_to_sgvec().
+ */
+static size_t iterate_skbuff(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+			     iov_step_f step)
+{
+	struct skbuff_iter_ctx ctx = {
+		.step		= step,
+		.progress	= 0,
+		.priv		= priv,
+		.priv2		= priv2,
+	};
+
+	iterate_skbuff_frag(iter->skb, &ctx, iter->iov_offset, len, 0);
+
+	iter->iov_offset += ctx.progress;
+	iter->count -= ctx.progress;
+	return ctx.progress;
+}
+
 /*
  * Out of line iteration for iterator types that don't need such fast handling.
  */
@@ -2463,6 +2582,8 @@ size_t __iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_iterlist(iter, len, priv, priv2, ustep, step);
 	if (iov_iter_is_scatterlist(iter))
 		return iterate_scatterlist(iter, len, priv, priv2, step);
+	if (iov_iter_is_skbuff(iter))
+		return iterate_skbuff(iter, len, priv, priv2, step);
 	WARN_ON(1);
 	return 0;
 }


