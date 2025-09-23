Return-Path: <linux-fsdevel+bounces-62440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD41B93B2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711AC2E0B1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8046B1C54A9;
	Tue, 23 Sep 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzYHos0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129415ECCC
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587637; cv=none; b=T7qI8LtU/I3KfTG7WoVGOZhIUeAX8Kx0Kb+llq9Xz1ceoL2IsI5ie4QM3UaZmZzSAM3dJ83qmd6r1oyNAVmewEjzWDvBeN7O5pT9hZ/awtqdoYkuvLiRkgaeSAWjHfjheEIzA/IB4gG1XmivPTr59i2brU57q5Q1QOl6PW2SESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587637; c=relaxed/simple;
	bh=CSiGtKrWb8zqpNUe8yL7Pevqy9qFJhFmaY58ZJGrYSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOEZEhYUpOtlF90q6ArubTYtstHy8Vhx0+HOPsFgHy47XkWDrgS6GAnX2jYFjq0+g5yC0FsZVqKtDByW1wpc20l3+T8dtn5VOLnmoD0Mj/LshEWJ8Yn3eDPx/KQFbZzamfEB63ltn1n5Zu37tMEiNRGEeN2/6jQAVsmmasNdG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzYHos0j; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77da29413acso5322449b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 17:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587634; x=1759192434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8Zc1MP+97msutqoeYloSdkN6RJEwl1bHJXdXkLR+a8=;
        b=XzYHos0jTd0Cc+zCh4if+nFQs5Qe9MqaHzNgescPY6ANwnsfhs/BsI8D2MAbDOHTgU
         4teujGeqxpxArLOapynGfV3o0DVDb/BFjNNn/dT42chj0cHr3ncU6UpDQ0qgDAYuG3rm
         ypTEPCYI64jouXY71ZkM4fPSnW+KyL2inDzlbkkJQdrmjylLK0/ayvtQPlX/ErjBC73K
         uTa6ewd50dW5aGpTp96GHnb/T9fETG1zbpGvk1cSvphV12THa563vKzXWuW4pwrC3CLX
         897Sb9RYlEoPFYtWN3yxJ+0JTShC2H6JTvW64TldOz7RQFZorvEuJeT4h/kJsbbgaNzF
         HAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587634; x=1759192434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8Zc1MP+97msutqoeYloSdkN6RJEwl1bHJXdXkLR+a8=;
        b=svRuhDir/ElAjU/y1GN82p6vf/LdEx7GhDbeD4WXaBv7nMrhTDIm58u+g5Q6iIhdnD
         8frozVw5bsi/N7Ni4CaXf6ERZQZbCPzucaqRjkViaSd8O6+fLObdzeMj0JtIhd97mspP
         loqGdCxE/PSK4q5VHUaNgVoeynvNnP36rlQlhlmulCzd7KJacaISpIF4yuHxFIIIXqCr
         Oq/sD9WB1tjqBNyTQrtarH1A6HsvjvZmRO6N4vgyu5DXq+VIloL5gbKBvybxk9TRca2i
         dZ88qHBphMWpH7BZjplpsOwibHL/xXxUk50ubL7zQqx3CxU+vKXTxjziUjyI1p3KY43V
         hC7g==
X-Forwarded-Encrypted: i=1; AJvYcCX3cZsmJ6twCWAuwz5H8kWLFP2wYK4az6tKcUR0xQm3lKnZ2mwOkxr2yCqIJiurKVcSe64mKeUBvgOPZf/i@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzSCFUTarnsvSqYVIklsEL4bcw5BGu/ZGPtAqYm9swIoaM1Lw
	cgLMuBjHlKuY5OtUIVYqEmJ+6niouhWHRIXVRqvX0IJjBusL/i0bA8d1
X-Gm-Gg: ASbGncvH8JfJlT92bGQLeGn7dS16H4Vd6q39F2/WXDD8KWBLc/PloNmeNAH7OUwps3A
	zJBx4T3WDnEI9LNU/V2SxEcM5E0CPHmPEKeqgdhYiQqQ+9PopL9p4liVfExUq8rOsfpSNU+s+vD
	p2/BtLbCEDE65hD5uRohPOpt1Q7MBwg52ALU2lXoVZoMM7Wc1gO8KRyf6pCJv6iwgG4lo7y+s05
	P+5ujTjOBXX1dcKD0xSatY7ESLow0CA7iD2YejC6O6yUupv6Y570VeeWicR9IAc7RzUaGguz4Xh
	NUcl/4Unp9RObJZsUDtGNNPLrwabRLCowg59GVhgE64kANzDSaSQXaFDtEVUMEE2AFA55SUcgE1
	3wnnyY3b2c8dKfmRlKdCpzkw7VH6Fi4nLq+/lAvo7NRR+Ew==
X-Google-Smtp-Source: AGHT+IE9UTk9DOOxHIk7V9AusMOVMJaA+o0ouKvy94Kuhd+S63mgnV20FB06J29O2ckAhaW6BtwlSg==
X-Received: by 2002:a05:6a20:258b:b0:262:c083:bb38 with SMTP id adf61e73a8af0-2cfbb09d4e3mr1348063637.0.1758587633950;
        Mon, 22 Sep 2025 17:33:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff445dd7sm12934627a12.51.2025.09.22.17.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:53 -0700 (PDT)
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
Subject: [PATCH v4 01/15] iomap: move bio read logic into helper function
Date: Mon, 22 Sep 2025 17:23:39 -0700
Message-ID: <20250923002353.2961514-2-joannelkoong@gmail.com>
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

Move the iomap_readpage_iter() bio read logic into a separate helper
function, iomap_bio_read_folio_range(). This is needed to make iomap
read/readahead more generically usable, especially for filesystems that
do not require CONFIG_BLOCK.

Additionally rename buffered write's iomap_read_folio_range() function
to iomap_bio_read_folio_range_sync() to better describe its synchronous
behavior.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9535733ed07a..7e65075b6345 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -367,36 +367,15 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
+	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
+	struct iomap_folio_state *ifs = folio->private;
+	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
-	struct folio *folio = ctx->cur_folio;
-	struct iomap_folio_state *ifs;
-	size_t poff, plen;
 	sector_t sector;
-	int ret;
-
-	if (iomap->type == IOMAP_INLINE) {
-		ret = iomap_read_inline_data(iter, folio);
-		if (ret)
-			return ret;
-		return iomap_iter_advance(iter, length);
-	}
-
-	/* zero post-eof blocks as the page may be mapped */
-	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
-
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-		goto done;
-	}
 
 	ctx->cur_folio_in_bio = true;
 	if (ifs) {
@@ -435,6 +414,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
 	}
+}
+
+static int iomap_readpage_iter(struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
+{
+	const struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
+	struct folio *folio = ctx->cur_folio;
+	size_t poff, plen;
+	int ret;
+
+	if (iomap->type == IOMAP_INLINE) {
+		ret = iomap_read_inline_data(iter, folio);
+		if (ret)
+			return ret;
+		return iomap_iter_advance(iter, length);
+	}
+
+	/* zero post-eof blocks as the page may be mapped */
+	ifs_alloc(iter->inode, folio, iter->flags);
+	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
+	if (plen == 0)
+		goto done;
+
+	if (iomap_block_needs_zeroing(iter, pos)) {
+		folio_zero_range(folio, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
+	} else {
+		iomap_bio_read_folio_range(iter, ctx, pos, plen);
+	}
 
 done:
 	/*
@@ -559,7 +569,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -572,7 +582,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	return submit_bio_wait(&bio);
 }
 #else
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	WARN_ON_ONCE(1);
@@ -749,7 +759,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 				status = write_ops->read_folio_range(iter,
 						folio, block_start, plen);
 			else
-				status = iomap_read_folio_range(iter,
+				status = iomap_bio_read_folio_range_sync(iter,
 						folio, block_start, plen);
 			if (status)
 				return status;
-- 
2.47.3


