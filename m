Return-Path: <linux-fsdevel+bounces-67984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40DFC4F9E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654D13B1323
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29351329E7D;
	Tue, 11 Nov 2025 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1o7ynLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0245329E6A
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889930; cv=none; b=XhiW0Lyz0LS0fax0wyLiwQ1yqJ1uKa4CqDPlTihgVQy+j87zWb5tlW8cBJpUYz7MMzALuw4S0ptWs9QvqnYsg/GgbuvgxeqCpYLMpTmbY+Ei9Q2vdasUSVxKI9I3INdkNmjJ67DoXVrM/q+N0XlqnaFzozn6pFQ2KuuK4CyLQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889930; c=relaxed/simple;
	bh=+JePnWDL+ecx7qbe8BrzD7pbjNYNAwxgv5Ft9QnSo18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCcZZiiP7PnmVMUDcJebkHR8xIS4XPbPOQnUs9jv6D18wRZpinUxQ3MVQ8+qxYUPMneQCqX8eWHewvlLEkgx9A98Z/3z8vLJ23R+dQLaxq/27nUMrAMn/fHFjEYG6ChGK6sAox1SgoenTT8nXzA+kYKszMLlSA2ACfsi7EZ8TL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1o7ynLy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so73858a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889927; x=1763494727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BUw6VWxaTpW5CDvQvqWYnVvBvFtt95DW0TW+bVRCC0=;
        b=T1o7ynLyMBpYEMbi5y07Xo7O2E0jiW2iP9bH1WQtHXY+gsHr/18cP2K+eFQQxspm1C
         Bf/iwemeaZVnVYITeNBfy9c+J6oADL6Pzr7NKzZUSUXd1gwFwT0dQpVeP03+wUGzgLOz
         QFKEB9smC3tjpmbGVzHO3xvk/wu1hZcv49HoXLlUybf+LJ23JiYwzwabYJRgocYkUzUr
         fZKuQOj5XaxQ6zD50sMN59RYdVw2UwmEtSyWzLpvZIMMA1ZJs8Y5TCZlwQol09XA39t0
         J2kS/hP5jmiUdrpQncd8Zs8E5NOW+rG7dWO8v+ZNpQTEXXMatKSLNGobHoMLJK4Bw8t+
         rS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889927; x=1763494727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BUw6VWxaTpW5CDvQvqWYnVvBvFtt95DW0TW+bVRCC0=;
        b=TysM53XmgsBP8UkTUhvbodsgWxtMXMauXX7AfUU+bNPjmdwmUf/WKl5ga9ciQGFJlE
         2nbryPGz0xMTzEO5xqH3IEa6Izu90qUPYk8Gn+FjuEwV8nTa1MoGco9U1eGrz2Ydv72s
         65dbcch/GKIQyK81FqS5fx+FKxSF+sGUNDWG6KajiQooGbddFiPSP9yA5Oi65nHfneNO
         Iz9AdqcdOC3tpFVfa9bZZ12fHv61+I1owBoqgC0aGqidW8xA+PDULFjRzCuc1XvN69rL
         r7NbpuD0RrENLHaFKKBwlk8/P4O/LfsWKpd4LtmUF8dFekshUHXMg/pDeOaIBCMqfNUP
         VIqw==
X-Forwarded-Encrypted: i=1; AJvYcCXGeVsfcp1fL2n8uEcUHyDStCUNaBveRebP5/RULorEdY+5APh9IZqcXsfHlN8j9NO4uyt8OjuPZL4ELZyG@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFNMRFKT1oYF4Jr2AfWLcSyeuRl5PBxqTd0HYQG0+PFuQX0di
	vXIaVujGt1KzHaLjrt/3iCKU8ozC8pFsYc1HaWsBRINinOd1swnsxewW
X-Gm-Gg: ASbGncsAgA0FMrFXi1O+YhV0kNvRhqhLkTuIohyqPP4+E05keoDjD8i3x90UURF48gi
	CJBlWK4kEArMvFG6YxxtuwERWfIlVgcrNrhNXsv6HzthvtA/ZvG1Xn1SGldaNQ91T9SyqlzUN0a
	oeAkswgeHYM5rQyT04V/4xNcYYHyGBlkkt1U6EaUqSFSt8d0GoGFJmkyi5AzApLmnu/fBJgBqGr
	0SZKh3li59m+hp146SkVS1Z0BXLn9dl3ByIxA7SKQvyYVUm8x+o/Ljyw3TUJi60bpw/r8anwufU
	GoWjKrbqH6QtHEKf+42VQLWiu3aQ+ZtHyIPc2WfLzYl63/+GrdMZhxjaFI9FPXYNt59ZBAqoy0A
	hNtfeco9SpUiapzTqUT/PgVWvHyKQny0se6f8bJWy0Rln5S9z7Ce5KKKqURcLr848OwnoO93cQ3
	JPwjbtOwqCpumdl7Nu1z6AO3GzFg==
X-Google-Smtp-Source: AGHT+IEu4tgCt1EBjDUQMD1R47Ef2G8CRRPR1mRCdztQc5lj8W7XORQMclgh4WNyaAGC3FgUKOwv+Q==
X-Received: by 2002:a17:90b:3bc3:b0:32e:a4d:41cb with SMTP id 98e67ed59e1d1-343ddde867fmr465581a91.1.1762889927145;
        Tue, 11 Nov 2025 11:38:47 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343727dcf3dsm11425102a91.19.2025.11.11.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:38:46 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 5/9] iomap: simplify ->read_folio_range() error handling for reads
Date: Tue, 11 Nov 2025 11:36:54 -0800
Message-ID: <20251111193658.3495942-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111193658.3495942-1-joannelkoong@gmail.com>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of requiring that the caller calls iomap_finish_folio_read()
even if the ->read_folio_range() callback returns an error, account for
this internally in iomap instead, which makes the interface simpler and
makes it match writeback's ->read_folio_range() error handling
expectations.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 .../filesystems/iomap/operations.rst          |  7 +--
 fs/fuse/file.c                                | 10 +--
 fs/iomap/buffered-io.c                        | 63 ++++++++++---------
 include/linux/iomap.h                         |  5 +-
 4 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 4d30723be7fa..64f4baf5750e 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -149,10 +149,9 @@ These ``struct kiocb`` flags are significant for buffered I/O with iomap:
 iomap calls these functions:
 
   - ``read_folio_range``: Called to read in the range. This must be provided
-    by the caller. The caller is responsible for calling
-    iomap_finish_folio_read() after reading in the folio range. This should be
-    done even if an error is encountered during the read. This returns 0 on
-    success or a negative error on failure.
+    by the caller. If this succeeds, iomap_finish_folio_read() must be called
+    after the range is read in, regardless of whether the read succeeded or
+    failed.
 
   - ``submit_read``: Submit any pending read requests. This function is
     optional.
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b343a6f37563..7bcb650a9f26 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -922,13 +922,6 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 
 	if (ctx->rac) {
 		ret = fuse_handle_readahead(folio, ctx->rac, data, pos, len);
-		/*
-		 * If fuse_handle_readahead was successful, fuse_readpages_end
-		 * will do the iomap_finish_folio_read, else we need to call it
-		 * here
-		 */
-		if (ret)
-			iomap_finish_folio_read(folio, off, len, ret);
 	} else {
 		/*
 		 *  for non-readahead read requests, do reads synchronously
@@ -936,7 +929,8 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 		 *  out-of-order reads
 		 */
 		ret = fuse_do_readfolio(file, folio, off, len);
-		iomap_finish_folio_read(folio, off, len, ret);
+		if (!ret)
+			iomap_finish_folio_read(folio, off, len, ret);
 	}
 	return ret;
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1873a2f74883..c82b5b24d4b3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -398,7 +398,8 @@ static void iomap_read_init(struct folio *folio)
 		 * has already finished reading in the entire folio.
 		 */
 		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += len + 1;
+		WARN_ON_ONCE(ifs->read_bytes_pending != 0);
+		ifs->read_bytes_pending = len + 1;
 		spin_unlock_irq(&ifs->state_lock);
 	}
 }
@@ -414,43 +415,47 @@ static void iomap_read_init(struct folio *folio)
  */
 static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 {
-	struct iomap_folio_state *ifs;
-
-	/*
-	 * If there are no bytes submitted, this means we are responsible for
-	 * unlocking the folio here, since no IO helper has taken ownership of
-	 * it.
-	 */
-	if (!bytes_submitted) {
-		folio_unlock(folio);
-		return;
-	}
+	struct iomap_folio_state *ifs = folio->private;
 
-	ifs = folio->private;
 	if (ifs) {
 		bool end_read, uptodate;
-		/*
-		 * Subtract any bytes that were initially accounted to
-		 * read_bytes_pending but skipped for IO.
-		 * The +1 accounts for the bias we added in iomap_read_init().
-		 */
-		size_t bytes_not_submitted = folio_size(folio) + 1 -
-				bytes_submitted;
 
 		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending -= bytes_not_submitted;
-		/*
-		 * If !ifs->read_bytes_pending, this means all pending reads
-		 * by the IO helper have already completed, which means we need
-		 * to end the folio read here. If ifs->read_bytes_pending != 0,
-		 * the IO helper will end the folio read.
-		 */
-		end_read = !ifs->read_bytes_pending;
+		if (!ifs->read_bytes_pending) {
+			WARN_ON_ONCE(bytes_submitted);
+			end_read = true;
+		} else {
+			/*
+			 * Subtract any bytes that were initially accounted to
+			 * read_bytes_pending but skipped for IO. The +1
+			 * accounts for the bias we added in iomap_read_init().
+			 */
+			size_t bytes_not_submitted = folio_size(folio) + 1 -
+					bytes_submitted;
+			ifs->read_bytes_pending -= bytes_not_submitted;
+			/*
+			 * If !ifs->read_bytes_pending, this means all pending
+			 * reads by the IO helper have already completed, which
+			 * means we need to end the folio read here. If
+			 * ifs->read_bytes_pending != 0, the IO helper will end
+			 * the folio read.
+			 */
+			end_read = !ifs->read_bytes_pending;
+		}
 		if (end_read)
 			uptodate = ifs_is_fully_uptodate(folio, ifs);
 		spin_unlock_irq(&ifs->state_lock);
 		if (end_read)
 			folio_end_read(folio, uptodate);
+	} else if (!bytes_submitted) {
+		/*
+		 * If there were no bytes submitted, this means we are
+		 * responsible for unlocking the folio here, since no IO helper
+		 * has taken ownership of it. If there were bytes submitted,
+		 * then the IO helper will end the read via
+		 * iomap_finish_folio_read().
+		 */
+		folio_unlock(folio);
 	}
 }
 
@@ -498,10 +503,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		} else {
 			if (!*bytes_submitted)
 				iomap_read_init(folio);
-			*bytes_submitted += plen;
 			ret = ctx->ops->read_folio_range(iter, ctx, plen);
 			if (ret)
 				return ret;
+			*bytes_submitted += plen;
 		}
 
 		ret = iomap_iter_advance(iter, plen);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index b49e47f069db..520e967cb501 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -495,9 +495,8 @@ struct iomap_read_ops {
 	/*
 	 * Read in a folio range.
 	 *
-	 * The caller is responsible for calling iomap_finish_folio_read() after
-	 * reading in the folio range. This should be done even if an error is
-	 * encountered during the read.
+	 * If this succeeds, iomap_finish_folio_read() must be called after the
+	 * range is read in, regardless of whether the read succeeded or failed.
 	 *
 	 * Returns 0 on success or a negative error on failure.
 	 */
-- 
2.47.3


