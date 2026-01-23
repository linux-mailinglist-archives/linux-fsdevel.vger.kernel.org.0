Return-Path: <linux-fsdevel+bounces-75329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENLTIYYLdGkQ1wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:00:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D155D7B92B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C488301572D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B102DF6E6;
	Sat, 24 Jan 2026 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfpvuR0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E06423182D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769212800; cv=none; b=NRistpjlZnG1bp0JoBRNbo3VVMRz+d1pnW2QAAYfthl/MkWNO8Osbz2vy7Pyew4B1tgZouLaEh3Tan1oMCPLWyryfGryrwIFLvGf/yeIQtcbNzp6LXZsn6ifZ2kynwoInPuyYyfQ3EMvIbQQKKouYzstI0OX3ZSLXM4Mif2xMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769212800; c=relaxed/simple;
	bh=Q8oURI8EOS0Z1g59RtixAsz/r7bBSFvTYv+pg+g3rT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmzGS1rZg48o3QzUiiHkMAU7Mw1BOI8wLba0zJJwqdChp1xWLlzrRIloC3+etmsg0FEoPnSYoT44CoVQX+nd0z181so58L7ejePn5d5GuKnwIaBtR8VbA7BFZcHC5Cbcswl3wZ2TNbnf93c7ZLyUcgThLwFn97LAdpOrPvPBlZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfpvuR0/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so1380891b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 15:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769212798; x=1769817598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5REaKGKMwRlbVIOOcLhBfMycKZ4WyMEcTgxC2+IZbo=;
        b=PfpvuR0/KmIXtoZ5PjWjjft/2qnAtoEm2xERyJ28F4Wzv7H8b9+zdZZmL8AKWqKa/m
         JKbX3ROrgFMmh5EWZGIoVIQEpesD1prn3hGQ5vZwNGUnpJRR1bhCh86Vw6zzbQyCbCQu
         W3CQIHexvFtZ3f1yN+EZuXV+vWdOzx0X5MMfaOABLOw8xPFNIyXmoW/ucqKlYvLM9MUd
         CEtLAlxsaTk9FUN7hFWkj3kTdPDzyn66UT7jtedrkT+0OIW6DhgjYbVmgYX/afLXq+Uu
         sckk7yNpFRaCY82OGC9dEdoCsbiCxCZ5rHg0ySGqxTaoe7575/HPvXnjMqbcOJzEP0fm
         n8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769212798; x=1769817598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5REaKGKMwRlbVIOOcLhBfMycKZ4WyMEcTgxC2+IZbo=;
        b=jNuOguhouw/II2s4W2Cb0MuztTa5AmRVAzYrU+OJbpNBPsQ/wPi9P/gPRJFcDejwUI
         30HZSxOpYh0rIuawjY4iLSnhJzOX4XqbEhcZXwhvRk75YBAlSKkmvKF7DJCgAi0mY7N6
         onk7GQoUJFfwCk1J3wHPAFg5T26wSO/gci+ij14KWtCwGuQyZG5wKrX0BKE5nZls9LjJ
         GLgpHLHR9wUg1joN4aHyfwCK1JKfuWdPLgHD0SG73aAXIeFI8CmMxafmWbXwltDV7Upl
         6tEoCPQU7ySwys76el+3IYktAep1vj58F3GvlXhdykig1WfhG3F7uvCt2rK8pjIDvgoP
         z6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz8XmxJrFuzA1+SdT7sZGV/LgDBK+zJJOc8UDO8OK6VhhnigOUhORgr6/PRuz6viErZbcU3W2RAPbRKkdh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/K4fEw2exitF9s/wp1MXq17KeYuVtRiLSPjCEm7Kfe/ilhkG
	HAOMBIAsqbmeIOg1I4i0gqO7FbZ+vHn07XvYtFWHu02Nm/kitMNzeTUa
X-Gm-Gg: AZuq6aIgHElCA+tsd50R1X3ImVJdq36FtsLML7qFKfKVwVGrPHOo5mIdE5dNJE5t2RX
	ZILMxeSlpdhMTtUzEq34p8iLdWkFBGVp2z/jKMtuatyy3SHdhDk8fq5VM4ZgXJCzIydb5DvxRT8
	tBVvtZMawZCDd48zDxU+SybOAR8J0NpkiWjJW7P1DaGsi3DJMvbmoRDISsa2pAoJRSUvvf62dex
	eOHrT9nSgf1U48OrDdrpP/nxFBIlAdu5JcFg/wIOHbUpK9AfYHGTWFBDhATYh5R7P964FslYLc+
	e8NJCOTMGATRTScaa+ENaH67xFCNAv5Bw/lnm9xHrLaDxJ+VUpZO6rUs5QwQ0FM9PsTcpN4L2XO
	MT3525E6bsYk6NXXGCgLYdQ+ToDoZznYO0x8p/AcCu1hu2/NYttbuZlrw9W2s6UlWMlsFY9kS++
	12XH0RQQ==
X-Received: by 2002:a05:6a00:1493:b0:821:807a:e427 with SMTP id d2e1a72fcca58-82317d4b415mr3412469b3a.21.1769212798514;
        Fri, 23 Jan 2026 15:59:58 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231871ccc2sm3121620b3a.36.2026.01.23.15.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 15:59:58 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 1/1] iomap: fix invalid folio access after folio_end_read()
Date: Fri, 23 Jan 2026 15:56:17 -0800
Message-ID: <20260123235617.1026939-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123235617.1026939-1-joannelkoong@gmail.com>
References: <20260123235617.1026939-1-joannelkoong@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75329-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: D155D7B92B
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
 fs/iomap/buffered-io.c | 69 ++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6beb876658c0..f8937fd5ee8e 100644
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
@@ -483,18 +475,30 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
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
 
+static void iomap_read_submit_and_end(struct iomap_read_folio_ctx *ctx,
+		size_t bytes_submitted)
+{
+	if (ctx->ops->submit_read)
+		ctx->ops->submit_read(ctx);
+
+	if (ctx->cur_folio)
+		iomap_read_end(ctx->cur_folio, bytes_submitted);
+}
+
 static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, size_t *bytes_submitted)
 {
@@ -502,6 +506,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
+	size_t folio_len = folio_size(folio);
 	size_t poff, plen;
 	loff_t pos_diff;
 	int ret;
@@ -515,8 +520,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 
 	ifs_alloc(iter->inode, folio, iter->flags);
 
-	length = min_t(loff_t, length,
-			folio_size(folio) - offset_in_folio(folio, pos));
+	length = min_t(loff_t, length, folio_len - offset_in_folio(folio, pos));
 	while (length) {
 		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
 				&plen);
@@ -542,7 +546,15 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
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
@@ -572,10 +584,7 @@ void iomap_read_folio(const struct iomap_ops *ops,
 		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&bytes_submitted);
 
-	if (ctx->ops->submit_read)
-		ctx->ops->submit_read(ctx);
-
-	iomap_read_end(folio, bytes_submitted);
+	iomap_read_submit_and_end(ctx, bytes_submitted);
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
@@ -636,11 +645,7 @@ void iomap_readahead(const struct iomap_ops *ops,
 		iter.status = iomap_readahead_iter(&iter, ctx,
 					&cur_bytes_submitted);
 
-	if (ctx->ops->submit_read)
-		ctx->ops->submit_read(ctx);
-
-	if (ctx->cur_folio)
-		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
+	iomap_read_submit_and_end(ctx, cur_bytes_submitted);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


