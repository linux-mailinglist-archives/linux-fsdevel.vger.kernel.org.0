Return-Path: <linux-fsdevel+bounces-60587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEF7B498E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE9D189A3A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCF73203A3;
	Mon,  8 Sep 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3oSj4VN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC931C599;
	Mon,  8 Sep 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357548; cv=none; b=VFmRr7QluybDGzyDlzHVHx8Ko2UMn8jMspxtCYfvjTONqIwJM7J8nZAaWKVA1HIMz7VTQflNSHdQyMClRsn2FkoXV5bxzJZTjI/+JYxNRx3oCBI8NaZBcx/oc4AvkzHsC4SmW+Su5HDaxRQmUomMNyubuUU3LZwTZWB8GBYjEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357548; c=relaxed/simple;
	bh=tuTPPcv0GhCEg9ZlUjj/sQ51KnHH3/BIZc7oNrNtdXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecqyYhZ//umAvd+NsosjItyyX0s6NP/qFbR/fqQcLO7g10jeSKhIIU6I9IC7iV5RzefT5HG0LcKopD8siZBvOemvLM5oELD/ZBxhxMxgILY4bA5v9T/qqGULzg6w0LdPNV0ae5P8LzOcfJLSSh5PxH26xER5R7lF801KUL+M0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3oSj4VN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2518a38e7e4so25345685ad.1;
        Mon, 08 Sep 2025 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357546; x=1757962346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goWt39Fkq+eCOLTjHWSeRjr3Nh1DdyDKEBWyEMT6i6I=;
        b=Q3oSj4VNlVohnJstY8SEas7wHkcMP83gUYRILbPfJFoEsBOCNW1xVcJSk+hcWO2t0X
         Hs3T/uJLwAvnpvxkwh/V8UnjS3yAMCk+Dttu5O9vl69yVfWfdpaUiL0zgsqHP68BHhWg
         fzokOcC/WMGZ2UzlTKDySdDpWB/UdlTGYs4DNB66eEw/KC873PlA5fMgNtPs6P3PKUQf
         S9oW5edlLU4csxnj0zbfNC/8OslNddEHEhRCZ4OAWIzo3UnfrYlgUAtsmevmahBV24fK
         RXAiO3jXUQCIqfB2RN6D8thBu9zO4C23u0MV238wLo4+JaTS+QaE+5eTAF3kS0hTzGr7
         W9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357546; x=1757962346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goWt39Fkq+eCOLTjHWSeRjr3Nh1DdyDKEBWyEMT6i6I=;
        b=rSE9iD4UmpbXjyJNmL/lnWN3aOKF6qDkBBy2owQJBiwmtEuUQxnelQQTcHBdL4qbcq
         4kTuTbQk8ixXFuyH/7D3IXwEeM3SnDxVe7bXpajc8pmdLo09YvEvhJk57TGzA9ojLf9V
         NFjPVChTmlOVl2nmi4gNyECb6dBB/54ag40TwhiIY5Id9CZzQlXrgiObhgCqPIFzqLCz
         Qa7L21Fxxa3tIzZkzOFOEH0zJkcVj8eiSj7tCI8+HB3aJC6IO3TzEHCz+UgW6jUE4FZ+
         Oln5/2gdk51EDIurRKRdrBD+Zau/2V38V23dDonLWfczRXqD7v/9uOkeJlyPzpW2GoZk
         N94Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWW8CfzEiRLkHjhyzvTvAqrOSAewcdugjPqv223euhUInuIcPspeTFPoVn80xnYNWGMAkGigWtEr78@vger.kernel.org, AJvYcCVJ7Inc1B7mSr7cK08usZtdE79FK1/T0A/vtwb0Laz4FpfxMCBtaPJ5vstbzwsWAsDqWpLmZ51yAfo2oqbCBw==@vger.kernel.org, AJvYcCW9BJJtii50EvGAFvEqMhcXiHoNl9S+d4ZTPTpl+Mr+NNIPw4gJljLyQTZ68Bi2DlAKOctlNChpsggH@vger.kernel.org, AJvYcCWirCO1esLjpg3JZx3GLefnyRCUTL4SMfLRqUV2FVijC1w1py6dqZkEol40iqvbiWcm9NLvoZe+dNIE6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyslkSjv4tuEPYweBmHnsRiw1Hnd6b7chD+yQncNsvJNBZCfEjf
	M84tRigPd8cay9Gs16xweC+hF65U/rZFmDDv3HU8BylGKYMf+lc3u2/u
X-Gm-Gg: ASbGncsL214yB84LtV0HTOrx5W6F3U8zu9sDLEWXwd8UPXqh3mjzLC03YLlQ8+4oOiY
	iVJIIhbqDArp0fLL2mCsxO3rfqwASmWQQ4/+52RFsxdgq0oGOk3JcX5PRYTiDWZz1XRd77abk24
	ioYoOjn8RWLlkQlk++5ikC00J6aqWfQQwERcr5uZR6Mo4V6foolwGDmXRR3rpCKMkAbsxbcK7u+
	5vXRy8/ExtHFCns8nIaK8Q5rQU36Xtu8oDuf6VJTCai6BzSgQAv64lYK5dA3LBHvRupUXRrwPCp
	zS4b6n1ffJRJG3tRHPi5Wpn1hcaqAqUZb1v2b8biljoHZAQfzxaRZCUvVewY3mK0oW8Mhlvq5z5
	zsxe2j51BAhUUWXzJ0Q==
X-Google-Smtp-Source: AGHT+IERAAhYd0bg8my/cBytIc4RRvJX/gC9A2p0elhQ8hhrMITVukT4Yx0WzfIBjBYY53LZCUNutA==
X-Received: by 2002:a17:903:22c3:b0:253:65e4:205f with SMTP id d9443c01a7336-25365e4e33dmr95057825ad.3.1757357545748;
        Mon, 08 Sep 2025 11:52:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28e33d7sm134446375ad.89.2025.09.08.11.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:25 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 06/16] iomap: iterate over entire folio in iomap_readpage_iter()
Date: Mon,  8 Sep 2025 11:51:12 -0700
Message-ID: <20250908185122.3199171-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908185122.3199171-1-joannelkoong@gmail.com>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterate over all non-uptodate ranges in a single call to
iomap_readpage_iter() instead of leaving the partial folio iteration to
the caller.

This will be useful for supporting caller-provided async folio read
callbacks (added in later commit) because that will require tracking
when the first and last async read request for a folio is sent, in order
to prevent premature read completion of the folio.

This additionally makes the iomap_readahead_iter() logic a bit simpler.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 67 ++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 51d204f0e077..fc8fa24ae7db 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -431,6 +431,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
+	loff_t count;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -442,39 +443,29 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 
 	/* zero post-eof blocks as the page may be mapped */
 	ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
 
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-	} else {
-		iomap_read_folio_range_bio_async(iter, ctx, pos, plen);
-	}
-
-done:
-	/*
-	 * Move the caller beyond our range so that it keeps making progress.
-	 * For that, we have to include any leading non-uptodate ranges, but
-	 * we can skip trailing ones as they will be handled in the next
-	 * iteration.
-	 */
-	length = pos - iter->pos + plen;
-	return iomap_iter_advance(iter, &length);
-}
+	length = min_t(loff_t, length,
+			folio_size(folio) - offset_in_folio(folio, pos));
+	while (length) {
+		iomap_adjust_read_range(iter->inode, folio, &pos,
+				length, &poff, &plen);
+		count = pos - iter->pos + plen;
+		if (plen == 0)
+			return iomap_iter_advance(iter, &count);
 
-static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
-{
-	int ret;
+		if (iomap_block_needs_zeroing(iter, pos)) {
+			folio_zero_range(folio, poff, plen);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else {
+			iomap_read_folio_range_bio_async(iter, ctx, pos, plen);
+		}
 
-	while (iomap_length(iter)) {
-		ret = iomap_readpage_iter(iter, ctx);
+		length -= count;
+		ret = iomap_iter_advance(iter, &count);
 		if (ret)
 			return ret;
+		pos = iter->pos;
 	}
-
 	return 0;
 }
 
@@ -493,7 +484,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_readpage_iter(&iter, &ctx);
 
 	iomap_submit_read_bio(&ctx);
 
@@ -510,16 +501,16 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 	int ret;
 
 	while (iomap_length(iter)) {
-		if (ctx->cur_folio &&
-		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			if (!ctx->folio_owned)
-				folio_unlock(ctx->cur_folio);
-			ctx->cur_folio = NULL;
-		}
-		if (!ctx->cur_folio) {
-			ctx->cur_folio = readahead_folio(ctx->rac);
-			ctx->folio_owned = false;
-		}
+		if (ctx->cur_folio && !ctx->folio_owned)
+			folio_unlock(ctx->cur_folio);
+		ctx->cur_folio = readahead_folio(ctx->rac);
+		/*
+		 * We should never in practice hit this case since
+		 * the iter length matches the readahead length.
+		 */
+		if (WARN_ON_ONCE(!ctx->cur_folio))
+			return -EINVAL;
+		ctx->folio_owned = false;
 		ret = iomap_readpage_iter(iter, ctx);
 		if (ret)
 			return ret;
-- 
2.47.3


