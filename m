Return-Path: <linux-fsdevel+bounces-75549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKznJejud2kVmgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:47:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD98E078
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4102A302A52C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52CA30BBA5;
	Mon, 26 Jan 2026 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVuYTndM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7C30748B
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467590; cv=none; b=FpPoD3I0XBfQ3o2mCtjwywMiZb1sp1W8zpvou9ObP8yWu47cqvfL4aJVXDIQPvZYzL5vJM2/GjnSd+8Dkaj1tAJ3FfdOk9UgM9CJc9meTrAPOzsl+NMB/q0RV2eCrAOEUinIUr5nlX+M7uvda0zVYdiDpFEIt/VH/SQBc/oq63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467590; c=relaxed/simple;
	bh=youd+UNjeO/ylpSLtvahAwQrpxIF7GpAZftN7kDTw2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0wUjHp+On+TOTRUlbI2pZ0+3IuvFl1CM0Th53UN5cy1ps0PYZBLcRTBbRIfkQwPeKDRhYKHcx7Dk2ewtj+ery6fdNBXLDVEBvNIO7YEgldkyUzCLo4vbm5tfdNpI4cinLP3A97UFe0RRdz8Hzo0dFCvPtwSokEQhOwSU8sZw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVuYTndM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a1022dda33so29856265ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 14:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769467588; x=1770072388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrPy5Pix90D5lZb0TQNVJRanlY1mdGRmWPUhg6O3J3c=;
        b=cVuYTndMgQt+ducsm3pHVuTTv5MWm0PY+QO3u9PHTRbRHgcI9uhQGHlxaMBID/jFZp
         zcEXVMHqsJ86PFWZ4JCacaKgWiGejyk/nieSWouNViRY0NdIgIV0r9xoo86p6ojQrqTf
         mzbzxr6c95rPzBUvUQp5QOFY7nsXREOYLEL8SW7vWexE2DSA7NtDgp3Hvyx+sfAoGFW6
         qkmnXl6MJWyujQtGBb1ub2pVYZqEUi46d7D0vR8+2RiE9GLagzGgnw1+Xpu5tqSqqjQ2
         yvv7wN4z6//K6Eixoq9N78PVG8IsYBoUoZyLCuB3oiuioZ4gFv34PLe4Xk1rHOwFAudU
         ckqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769467588; x=1770072388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mrPy5Pix90D5lZb0TQNVJRanlY1mdGRmWPUhg6O3J3c=;
        b=Azzj9VtQnDHh5j85p/7ilbHdjBAIor9aMwnBkIqIqwbN6TcgcO0CEJMa9ats18ChFI
         JLLoA4laFfjnGg1Xw1PjALXY38Kw1LBJsnkAWDLWTabXG2gLKQh1UtW5B5gER/pQQrs6
         qc9ohbmVQlinXkDnjysMi9tjE+3l7is1lZ1r39oC5ivIz4kPMVG94YCfx4J5z81fUuV0
         oyKX7c+Efk1VutcJ9quRuivNtOZVaPCR0/b+iNca8vKg/ef1kxKHwrRFGe4Wanm31/GY
         JWjrKh6WD0mhFOgEK0vuH7tnHHeCS8mlLIALUlu6ixU3iSWSI7ARXfbU2F1wvE971IzF
         3QoA==
X-Forwarded-Encrypted: i=1; AJvYcCVS4vfqBFVtJhloYkVEZdospNwP/5258sXDFl/X1Q4IzitNSXqMP/hfbGU8t2iq4+IqKY7EcNfJEFSh7J7H@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPfNcrQ2vkpLnLCex5bsoRxTXaB15UVO3sC3orZ0DD9hOu/pz
	B7jQmmu8WVby3LHyI85p5XdjBOqmaSsE6pos/8g5WxECV3o1i62LbtdX
X-Gm-Gg: AZuq6aLFm1lB7/KxiOcwQdd20V/DEOoQhQEA0Izb1jqGCnIV2uZm51stRuONltKJI7g
	v1PnFbCda6SPPQ5+SEAqAPMboET2KRvMRLRU2UFffM0FptL88wRdc7f8rPaH7Bm2rFaLNktD0A8
	WznPQrA+L2ZGAbAU82OP++7JXR5o/rJtOeid8uUuGm7OOUxGAVAXeb3Mcb7AUEnGR/gT4o11poz
	oaeu3TELd/l69wnYQ846oY1QuJb/+IAqBFNRHDt76UezLWh32CMxgD84gc3gJ7eWZiYJCyj4yHX
	mjdGwS/KabUZy/EGIIwLpWO/GwuIubZjjlY/hN6+Kf+uWC5RYn36cLFzudB9PGaMVhDrkrxHaca
	FMBxLMvvk2bavq0LqcyjcsKcfTma/JXB4JlOjvdcqgSCyA3A3i9t7D+MYBJYT+YKCb0VDruTYkA
	TtOslaJw==
X-Received: by 2002:a17:903:2b07:b0:2a0:be7b:1c50 with SMTP id d9443c01a7336-2a845222018mr58885355ad.14.1769467588314;
        Mon, 26 Jan 2026 14:46:28 -0800 (PST)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802edb3c4sm95595595ad.43.2026.01.26.14.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 14:46:27 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 1/1] iomap: fix invalid folio access after folio_end_read()
Date: Mon, 26 Jan 2026 14:41:07 -0800
Message-ID: <20260126224107.2182262-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126224107.2182262-1-joannelkoong@gmail.com>
References: <20260126224107.2182262-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-75549-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9FD98E078
X-Rspamd-Action: no action

If the folio does not have an iomap_folio_state (ifs) attached and the
folio gets read in by the filesystem's IO helper, folio_end_read() will
be called by the IO helper at any time. For this case, we cannot access
the folio after dispatching it to the IO helper, eg subsequent accesses
like

        if (ctx->cur_folio &&
                    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {

are incorrect.

Fix these invalid accesses by invalidating ctx->cur_folio if all bytes
of the folio have been read in by the IO helper.

This allows us to also remove the +1 bias added for the ifs case. The
bias was previously added to ensure that if all bytes are read in, the
IO helper does not end the read on the folio until iomap has decremented
the bias.

Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 51 ++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6beb876658c0..e3bedcbb5f1e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -409,8 +409,6 @@ static void iomap_read_init(struct folio *folio)
 	struct iomap_folio_state *ifs = folio->private;
 
 	if (ifs) {
-		size_t len = folio_size(folio);
-
 		/*
 		 * ifs->read_bytes_pending is used to track how many bytes are
 		 * read in asynchronously by the IO helper. We need to track
@@ -418,23 +416,19 @@ static void iomap_read_init(struct folio *folio)
 		 * reading in all the necessary ranges of the folio and can end
 		 * the read.
 		 *
-		 * Increase ->read_bytes_pending by the folio size to start, and
-		 * add a +1 bias. We'll subtract the bias and any uptodate /
-		 * zeroed ranges that did not require IO in iomap_read_end()
-		 * after we're done processing the folio.
+		 * Increase ->read_bytes_pending by the folio size to start.
+		 * We'll subtract any uptodate / zeroed ranges that did not
+		 * require IO in iomap_read_end() after we're done processing
+		 * the folio.
 		 *
 		 * We do this because otherwise, we would have to increment
 		 * ifs->read_bytes_pending every time a range in the folio needs
 		 * to be read in, which can get expensive since the spinlock
 		 * needs to be held whenever modifying ifs->read_bytes_pending.
-		 *
-		 * We add the bias to ensure the read has not been ended on the
-		 * folio when iomap_read_end() is called, even if the IO helper
-		 * has already finished reading in the entire folio.
 		 */
 		spin_lock_irq(&ifs->state_lock);
 		WARN_ON_ONCE(ifs->read_bytes_pending != 0);
-		ifs->read_bytes_pending = len + 1;
+		ifs->read_bytes_pending = folio_size(folio);
 		spin_unlock_irq(&ifs->state_lock);
 	}
 }
@@ -465,11 +459,9 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 
 		/*
 		 * Subtract any bytes that were initially accounted to
-		 * read_bytes_pending but skipped for IO. The +1 accounts for
-		 * the bias we added in iomap_read_init().
+		 * read_bytes_pending but skipped for IO.
 		 */
-		ifs->read_bytes_pending -=
-			(folio_size(folio) + 1 - bytes_submitted);
+		ifs->read_bytes_pending -= folio_size(folio) - bytes_submitted;
 
 		/*
 		 * If !ifs->read_bytes_pending, this means all pending reads by
@@ -483,14 +475,16 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 		spin_unlock_irq(&ifs->state_lock);
 		if (end_read)
 			folio_end_read(folio, uptodate);
-	} else if (!bytes_submitted) {
+	} else {
 		/*
-		 * If there were no bytes submitted, this means we are
-		 * responsible for unlocking the folio here, since no IO helper
-		 * has taken ownership of it. If there were bytes submitted,
-		 * then the IO helper will end the read via
-		 * iomap_finish_folio_read().
+		 * If a folio without an ifs is submitted to the IO helper, the
+		 * read must be on the entire folio and the IO helper takes
+		 * ownership of the folio. This means we should only enter
+		 * iomap_read_end() for the !ifs case if no bytes were submitted
+		 * to the IO helper, in which case we are responsible for
+		 * unlocking the folio here.
 		 */
+		WARN_ON_ONCE(bytes_submitted);
 		folio_unlock(folio);
 	}
 }
@@ -502,6 +496,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
+	size_t folio_len = folio_size(folio);
 	size_t poff, plen;
 	loff_t pos_diff;
 	int ret;
@@ -515,8 +510,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 
 	ifs_alloc(iter->inode, folio, iter->flags);
 
-	length = min_t(loff_t, length,
-			folio_size(folio) - offset_in_folio(folio, pos));
+	length = min_t(loff_t, length, folio_len - offset_in_folio(folio, pos));
 	while (length) {
 		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
 				&plen);
@@ -542,7 +536,15 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			ret = ctx->ops->read_folio_range(iter, ctx, plen);
 			if (ret)
 				return ret;
+
 			*bytes_submitted += plen;
+			/*
+			 * If the entire folio has been read in by the IO
+			 * helper, then the helper owns the folio and will end
+			 * the read on it.
+			 */
+			if (*bytes_submitted == folio_len)
+				ctx->cur_folio = NULL;
 		}
 
 		ret = iomap_iter_advance(iter, plen);
@@ -575,7 +577,8 @@ void iomap_read_folio(const struct iomap_ops *ops,
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
 
-	iomap_read_end(folio, bytes_submitted);
+	if (ctx->cur_folio)
+		iomap_read_end(ctx->cur_folio, bytes_submitted);
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
-- 
2.47.3


