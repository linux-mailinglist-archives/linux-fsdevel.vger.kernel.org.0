Return-Path: <linux-fsdevel+bounces-60593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F9FB49903
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F42A3B43E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82B320CD8;
	Mon,  8 Sep 2025 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbO70fxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453231C59E;
	Mon,  8 Sep 2025 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357557; cv=none; b=SHHVytTZiz0RGgYn+aa7Yk4qmFAmuIN97D/g60uKx+mctV33eeNl1/ZwVr7jsfXbgRt0DbYBRbEJJ2nXxDzjPOhsOBLkEQzAKfWUXMgmWq7QcOSG+V8E5QHBR8gaudaSnyxr+/LGtg01jSasjvgA4ZyQZh6g81syAz4q8hJuqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357557; c=relaxed/simple;
	bh=XYDdbiCheJNYqFN+xdj3twDywVgXtenvowlZMieDVfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Czn5rpt/4GYgfNTuwfFlm9jgU9RfWPR0bMEqpSwXQmXl9dChnLWShRfvp9uh0hM6UslR/wQE+hcTOGo9ITTI19vPHuyqQpdm5xF7740SIW+xo3+AR4gDJL/BytpIXOSlAq2wOvBwnLrJvET8d+/zaciZ868nQeFw8u7v8bRSIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbO70fxG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so3991399b3a.3;
        Mon, 08 Sep 2025 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357555; x=1757962355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rKTaVko7JdJw65BUlzUAONrdRe7GE3jKL24dVmvC2I=;
        b=FbO70fxGITQH7YxSByEXggIBlkLuZG4aogmbE3s+2YFc71P/r6in9s2NQF2MAb64c1
         T84b13gvTiTMsU3bPtXRQ13tlqjEj6G5ADsWUQgwbhnReUDgM0KlkOh0PaXIRc1hJ0e3
         O7sCLSlqRRsZtDtowiQ+KQ51qrW8RqR7D7IFkBnMb8AqN7NsbQw6e7iK8XMhcrLJw3VO
         ALTD9N6AQInEj6f2oyueMOe9CyMZYJtDqS44Smzk5SRSwWc6AwKQ1p29OgsjzOk7kFWd
         h9WhgZsS9mbPBK/qJO1YD21Kf2VO8WUe3dCOIxD/rUHRx0AVlTulsIuz7mOf2FlPurI1
         kUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357555; x=1757962355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rKTaVko7JdJw65BUlzUAONrdRe7GE3jKL24dVmvC2I=;
        b=LD37+9yogvFc9xvOBUjRsi5Q3uix1m2+RPYVtcgc8ux04NlA1SsH+NWWc9SuHuAtZ4
         64RlG+JBsMeoplyH5nlfR7a4ZEqXqTOJHbyBZduiFUb6W0Onr6+uBl9haDtpx0bfuUos
         93LdSkAhhvuAWpkdXMgSNvshLm7bHCX7RxpcwRGE4+T7zBCCeu8JDh4dbCA+pZwN7cN4
         hP1Jh066ab3UwuHhnXQo1GHKEpP609bG+muD9nqhXuxaNpvW9XkflksRLPdMd6fldcd9
         0RHgp9uP4r+HT1zZDSgldArJHMAD1PpP3qzgsJ7t21ZzYoEned8mlusdq+Xm6BPn8GZ5
         ixBg==
X-Forwarded-Encrypted: i=1; AJvYcCWXCJG61GTS7mG5kRt2GKeraghH0SiWs0DO2IpmiBrhutiznRVKPthMT8i3EYpLXdFXCWyOIri4jro33ZcrBA==@vger.kernel.org, AJvYcCWa1dYNL4mOys+rFJM79+xmWE8sPMZ6GcaaXZxx+Rag1acZ/eEKeOjZMWdd+grJ+siMTCWsTsScAAD27Q==@vger.kernel.org, AJvYcCWaPYvPhTR3PqCC1a5PyDiniD3cgKOH0YY+KOdhC1q5jYoA21aprzDUs+B8F83qgwALI5cRZT5sLXSJ@vger.kernel.org, AJvYcCWpUUqdN2eAic1aZbHtyK6UTAhCI1LLzWDvv2+551/iI2T+s+2C3MTbzjTtPQz31J9tjNpK2iqnHIMW@vger.kernel.org
X-Gm-Message-State: AOJu0YzGoRboRS5F5RIbvRY/TrMVkUUMoXfF0PbtgDdKVR0OZovTQcfk
	ulbebN4Chojjuze0EP/Z/aJ3eurrdMMcBsEoOyoY20TB4Lx3c/sbrurAqnmGEw==
X-Gm-Gg: ASbGnct9m6PB0ULBATGTLDhiAz332M6EX8m6jnuyVq2gD4USSEol+twX1yEfIbeiTgF
	hRFMFs928RSodf6/I+SDCcC7sF4MRd0eL/iURfq9WdwOiJSaxCGNXaQDOD7uORuUcgT6Y3UWA75
	IqcsQo15GYJPs/z0NLtCab6qndUkNU0bwtcalyaa3anPsuy73c/Get/+Bi2mxBUIqIOFSA247+X
	FFPOGB9d7kMStl4cdSNInUFkcujXnvDahS3GAQGbJiO6uALmLLVxWtS2D2Z1zHvUAPMGOS/+jo9
	DZNzL9/PTO3xuO1XYCZSEcr7QPy3+lPRKcETsJcvgHWh00aRtj5jIEZ0CP2aZ3nkhXCYoqSH7zM
	wNdKqPihDC7Yft/mRvh05B5QOp9Q=
X-Google-Smtp-Source: AGHT+IEBOsJF9kmNPbxpjlNuPGBRNS2ZtwaXOFm/FJY0Ln5Ayeda8Xt4/B7oIVcSXTC3tK2bRuDPDw==
X-Received: by 2002:a05:6a20:394a:b0:24e:ced1:d91 with SMTP id adf61e73a8af0-2534519d1a8mr12004589637.41.1757357555318;
        Mon, 08 Sep 2025 11:52:35 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b362dsm30535084b3a.32.2025.09.08.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:35 -0700 (PDT)
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
Subject: [PATCH v2 12/16] iomap: add bias for async read requests
Date: Mon,  8 Sep 2025 11:51:18 -0700
Message-ID: <20250908185122.3199171-13-joannelkoong@gmail.com>
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
 fs/iomap/buffered-io.c | 43 ++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6fafe3b30563..f673e03f4ffb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -329,8 +329,8 @@ void iomap_start_folio_read(struct folio *folio, size_t len)
 }
 EXPORT_SYMBOL_GPL(iomap_start_folio_read);
 
-void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
-		int error)
+static void __iomap_finish_folio_read(struct folio *folio, size_t off,
+		size_t len, int error, bool update_bitmap)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	bool uptodate = !error;
@@ -340,7 +340,7 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		unsigned long flags;
 
 		spin_lock_irqsave(&ifs->state_lock, flags);
-		if (!error)
+		if (!error && update_bitmap)
 			uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
 		ifs->read_bytes_pending -= len;
 		finished = !ifs->read_bytes_pending;
@@ -350,6 +350,12 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
+
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error)
+{
+	return __iomap_finish_folio_read(folio, off, len, error, true);
+}
 EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
 #ifdef CONFIG_BLOCK
@@ -434,9 +440,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
+	struct iomap_folio_state *ifs;
 	size_t poff, plen;
 	loff_t count;
-	int ret;
+	int ret = 0;
 
 	if (iomap->type == IOMAP_INLINE) {
 		ret = iomap_read_inline_data(iter, folio);
@@ -446,7 +453,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
-	ifs_alloc(iter->inode, folio, iter->flags);
+	ifs = ifs_alloc(iter->inode, folio, iter->flags);
+
+	/*
+	 * Add a bias to ifs->read_bytes_pending so that a read is ended only
+	 * after all the ranges have been read in.
+	 */
+	if (ifs)
+		iomap_start_folio_read(folio, 1);
 
 	length = min_t(loff_t, length,
 			folio_size(folio) - offset_in_folio(folio, pos));
@@ -454,8 +468,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		iomap_adjust_read_range(iter->inode, folio, &pos,
 				length, &poff, &plen);
 		count = pos - iter->pos + plen;
-		if (plen == 0)
-			return iomap_iter_advance(iter, &count);
+		if (plen == 0) {
+			ret = iomap_iter_advance(iter, &count);
+			break;
+		}
 
 		if (iomap_block_needs_zeroing(iter, pos)) {
 			folio_zero_range(folio, poff, plen);
@@ -465,16 +481,23 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			ret = ctx->ops->read_folio_range(iter, ctx, pos,
 						plen);
 			if (ret)
-				return ret;
+				break;
 		}
 
 		length -= count;
 		ret = iomap_iter_advance(iter, &count);
 		if (ret)
-			return ret;
+			break;
 		pos = iter->pos;
 	}
-	return 0;
+
+	if (ifs) {
+		__iomap_finish_folio_read(folio, 0, 1, ret, false);
+		/* __iomap_finish_folio_read takes care of any unlocking */
+		*cur_folio_owned = true;
+	}
+
+	return ret;
 }
 
 int iomap_read_folio(const struct iomap_ops *ops,
-- 
2.47.3


