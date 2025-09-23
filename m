Return-Path: <linux-fsdevel+bounces-62448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CC3B93B90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779C71884502
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9C72135B9;
	Tue, 23 Sep 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAuFk/xk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083820296C
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587649; cv=none; b=QmIXqFNy152tZHP4CixnLuVkK6ZBkBT7rf51+i9O2iTXDdQ2hSAJ5ME79sNxox6NaJJPISsGZKmqiS19fsp7mnY7JfsrWOHp4qxHKGNEEFZAr3d8w0q/GyNBOGttU3gipN1coe56LEyM7sPP4RWy9Wm9tkpC7uMmCitEayXnFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587649; c=relaxed/simple;
	bh=yLj6g5WJ4PjAjFCvmn5JiB1GDCM8kZxAtJld1CzxfWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE5HfURgtLje843OZFSzy+tVsC1TY2Jd4u2SiWkKJKEAEM9U84MqCCrScqVf5y3d28Lk8etL92r3T5dO+YHdvOmtu6ZLHv573U9FFTBKy1fJneUG/cj349zcfAt8o0oYxHcoKAZd/aKwVAbtjlztw/PASHE8+AuQm30TJMPWLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAuFk/xk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24457f581aeso49776905ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587646; x=1759192446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntuDtvvcxXIwL9deTSqYzeD3zNqVLETNsiY99SSIRBw=;
        b=lAuFk/xkwmV/OfnNXgGzaP/4AdVxRMN5itT/Kp6SrTshXpvhWas+CzsIdXBBQLiBXS
         1rubIRGBSC6t1Jz1RUCWoRNzE+Ic0Wxwplt43D+tYRdheAyFNdl1bv+6Ohd/CJJpS/PM
         ubpp9sQMZr+Vu/l4C33Zj3wa22IrhsGjeBeUSvFzj+5DkI7v48KKiP+5KEYjHveAvyi9
         sruzeCTcJVoFNqsPfSUbbSX6RvSR8nUNr4IOD4y+KOwYveMtmC73wI0goYRSXPeYiBZ1
         swJ6QS3yL1IxH8K3d3vwJoJYnrJvbUJ+I76i3LD1Clj8TVyPLaqzhoHDrUerJLThH5C4
         K3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587646; x=1759192446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntuDtvvcxXIwL9deTSqYzeD3zNqVLETNsiY99SSIRBw=;
        b=CzdNq1zqyO4zttEmBBA6cK4W8Rc4kpYLe98t9ACQVriSG8lSFP8uSrQCMXYYUWUA2x
         Jud0eCAX66MqZ2HKyyU8MrYC9EUkWw3q9Q1QlpT8gAHP/GFKIgW6HvCH4W/mo1lkTTl9
         meDwHcQqfrMLUaTYmBB08nyIYCRqJjBq8DOImcvZRFu0um0DCQII0C2RYEJGr0EjRGOU
         ntmahjPnU5GtEVgyjpl61pCVm8EGkGj8LXAi9cTIb/BbXihxWAjgGSdauTqF8YrKG6kv
         bmWYg0hXcmNzYTrzN/GOjit7xyST5Vs4yuzxofgZyrXqIxvEzCymgTonr4qmYGXDPVyL
         9FBw==
X-Forwarded-Encrypted: i=1; AJvYcCVNK/OUN2uCQ88YnwmucFVDBuxQ2yecRI6zoQGmr59FRnXXoFAcTUv23YpobLzeD2rMOlvWZIjPxDHMx0my@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5vk+TtnAias4WsI2phrVb3CFtg3H7BrAeGZsDVUkaTfw1PCw
	VPuzqTPXPq2FTHhTutC39fFzBkB16595quBB3rN+Ly/akAuweHl2ymch
X-Gm-Gg: ASbGncuK/EUSdzyfdCF1FkmFBExODTxy2HSXWid2bRz1OqFxAapcXBJsAggunzjl0Di
	yLJXAE20yfaxu3pXMUQxya0uNtAZDP2mnr3Qt0se8khMHJr7O7IkPEZivtBj3ne5vIyhJ6kzlxd
	z5O2ofgFQLHpvgcoxRSONKk4Yx7KrPvrEjMU7tlwbFVTPXaykgB2Y8YndIAVCewqpoDzNDJeqp8
	2QjSl+MOSHwP/tS88/WuyQ3ulfEu/9ub/mV+4QMs4h9kXSfZ5wxdT4V2WK5HnTiQQtbmvweryKm
	1+7bABC2GWKU29idYoRaOmOFnUsjgM16/2fMpovgfeLqnM9F6urXCdK87xM54t674hMAq96yQTt
	04IBc873MrdAIjsTJD43j/GyT1eDaeE3fF26I6ZU9vQh7X8LiEd1Bcuak4EXU
X-Google-Smtp-Source: AGHT+IEhTnBUYl+j3KLiqlpxHUCI/vnvNAMZQ6XSvAN+3hktfXKpSSHFQfOmtaK7JIZM3c79iCAhNw==
X-Received: by 2002:a17:902:ccd1:b0:269:74b6:8735 with SMTP id d9443c01a7336-27cc24e4231mr8951755ad.24.1758587646479;
        Mon, 22 Sep 2025 17:34:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053c88sm145125515ad.19.2025.09.22.17.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:06 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 10/15] iomap: add bias for async read requests
Date: Mon, 22 Sep 2025 17:23:48 -0700
Message-ID: <20250923002353.2961514-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-block-based filesystems will be using iomap read/readahead. If they
handle reading in ranges asynchronously and fulfill those read requests
on an ongoing basis (instead of all together at the end), then there is
the possibility that the read on the folio may be prematurely ended if
earlier async requests complete before the later ones have been issued.

For example if there is a large folio and a readahead request for 16
pages in that folio, if doing readahead on those 16 pages is split into
4 async requests and the first request is sent off and then completed
before we have sent off the second request, then when the first request
calls iomap_finish_folio_read(), ifs->read_bytes_pending would be 0,
which would end the read and unlock the folio prematurely.

To mitigate this, a "bias" is added to ifs->read_bytes_pending before
the first range is forwarded to the caller and removed after the last
range has been forwarded.

iomap writeback does this with their async requests as well to prevent
prematurely ending writeback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 48 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 81ba0cc7705a..354819facfac 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -430,6 +430,38 @@ const struct iomap_read_ops iomap_bio_read_ops = {
 };
 EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
 
+/*
+ * Add a bias to ifs->read_bytes_pending to prevent the read on the folio from
+ * being ended prematurely.
+ *
+ * Otherwise, if the ranges are read asynchronously and read requests are
+ * fulfilled on an ongoing basis, there is the possibility that the read on the
+ * folio may be prematurely ended if earlier async requests complete before the
+ * later ones have been issued.
+ */
+static void iomap_read_add_bias(struct iomap_iter *iter, struct folio *folio)
+{
+	ifs_alloc(iter->inode, folio, iter->flags);
+	iomap_start_folio_read(folio, 1);
+}
+
+static void iomap_read_remove_bias(struct folio *folio, bool folio_owned)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	bool end_read, uptodate;
+
+	if (ifs) {
+		spin_lock_irq(&ifs->state_lock);
+		ifs->read_bytes_pending--;
+		end_read = !ifs->read_bytes_pending && folio_owned;
+		if (end_read)
+			uptodate = ifs_is_fully_uptodate(folio, ifs);
+		spin_unlock_irq(&ifs->state_lock);
+		if (end_read)
+			folio_end_read(folio, uptodate);
+	}
+}
+
 static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, bool *folio_owned)
 {
@@ -448,8 +480,6 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		return iomap_iter_advance(iter, length);
 	}
 
-	ifs_alloc(iter->inode, folio, iter->flags);
-
 	length = min_t(loff_t, length,
 			folio_size(folio) - offset_in_folio(folio, pos));
 	while (length) {
@@ -505,6 +535,8 @@ int iomap_read_folio(const struct iomap_ops *ops,
 
 	trace_iomap_readpage(iter.inode, 1);
 
+	iomap_read_add_bias(&iter, folio);
+
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&folio_owned);
@@ -512,6 +544,8 @@ int iomap_read_folio(const struct iomap_ops *ops,
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
 
+	iomap_read_remove_bias(folio, folio_owned);
+
 	if (!folio_owned)
 		folio_unlock(folio);
 
@@ -533,6 +567,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 	while (iomap_length(iter)) {
 		if (ctx->cur_folio &&
 		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
+			iomap_read_remove_bias(ctx->cur_folio,
+					*cur_folio_owned);
 			if (!*cur_folio_owned)
 				folio_unlock(ctx->cur_folio);
 			ctx->cur_folio = NULL;
@@ -541,6 +577,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 			ctx->cur_folio = readahead_folio(ctx->rac);
 			if (WARN_ON_ONCE(!ctx->cur_folio))
 				return -EINVAL;
+			iomap_read_add_bias(iter, ctx->cur_folio);
 			*cur_folio_owned = false;
 		}
 		ret = iomap_read_folio_iter(iter, ctx, cur_folio_owned);
@@ -590,8 +627,11 @@ void iomap_readahead(const struct iomap_ops *ops,
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
 
-	if (ctx->cur_folio && !cur_folio_owned)
-		folio_unlock(ctx->cur_folio);
+	if (ctx->cur_folio) {
+		iomap_read_remove_bias(ctx->cur_folio, cur_folio_owned);
+		if (!cur_folio_owned)
+			folio_unlock(ctx->cur_folio);
+	}
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


