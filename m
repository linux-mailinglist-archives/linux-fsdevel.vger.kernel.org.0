Return-Path: <linux-fsdevel+bounces-66996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B5C32F8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DCDF4EE3B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA7D2DF137;
	Tue,  4 Nov 2025 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoeVc7Nt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5412DC332
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289511; cv=none; b=fl5YnGk+3kI4N96fsX2f4Wm7/5Jal/hc/+stYRzGknAdpz+h4ZpVDO1xIbwDmPq3y4WRwyiOGNuKys6i+CXApcKGROFwfNMyBEdS1Um89tTTaBc2OTpOdG49AvuaqSQwDv54In1/ZJgwLwsItlK/kCzBX+zzvkcfBrhvbaBsRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289511; c=relaxed/simple;
	bh=+1UD3R/jJYPFvUtnyUcIE+PwXVexHila5mioUsN1+UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eE1GASM/OD8ApWsj7hrrYWVN8mezLVU8QLzZaMv+eKORKr15jgTdAeXs8a08E9thxz/iQFl+wtKVonkROOuuX1SfNfwMJ3mmWLmbsVRRJVxezPU2mhzhGmkENezR8nGGF6a3N/YCAUNUcj8Dj2nN68ipqRozmBTM4rWUx4PRk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoeVc7Nt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ba599137cf7so34220a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 12:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762289507; x=1762894307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5y6qSd6XMIiENdjFCfcjkAC7PHtJoyNVfwISDefnGc=;
        b=SoeVc7Ntsc3pA3k3Hk/b5w0wrdTmpoAqq+GuYONB5j2vCk/V6/KSRSUL6cA/qwjbtV
         3SUgVdlnAJdkr+FXJaLIT7EL7xVnI1WEYu/L0gVNd3ZSmOXDrEHdz6Wdb2mzRjNVRysq
         hOD5Nch85+qGDdkKy/5MxxCpQ+i0dEZxryBQGXhue/0qYI/60sUFvGTKQmIPYCuGb8/d
         KB6sM6MoLhc3rsX/NS3WH4NtvE4+0pFAN2m4/Zq2bQTvhMRNyqKUEnZJJhLNLSKKUgDH
         B8ABl+i3FszpEDsSxp7mtRzCUKEG0KV3qGuMlwKBFoGMOKyCM2W3C8la28OBgVHmbatP
         SuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762289507; x=1762894307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5y6qSd6XMIiENdjFCfcjkAC7PHtJoyNVfwISDefnGc=;
        b=d2rY/hOHZhyw86qc9jPe4/b/VVKUT51K9lFQaHjqNhWX6scbjk/86Va7cmsBK0wegL
         YWPoZGK6sRE8+Bjj+yk2p2hhS9Qx+qOFbN8MtxCD4I1yWVJ6hdE0lVHNgIPbGaFNIMDM
         37d4awh6oCiTpF/If2oFcz0uQX+qRp+2xZqjoz8CIy5xhIWLuSmPPYKGNZNP/LUTxNYl
         pu+TZ+LHm2zUaqg7fPKWXhDjXErJ75feDTuqr+AnObn3NjFBcW4uRgtpsSaz9e7xM46d
         kDzc4zNDTVgofQ7zPptJiYzVWlGvGiyQhNqBjpAgR0GPl3SYW6MROIkQa/tSljOfLggl
         chBg==
X-Forwarded-Encrypted: i=1; AJvYcCUlw9N5qhC3e/Pylm9GH81WNMatIppz9zmHFQTHV62CY1TSICoLOOYMVAC2MrddanRP43GDErKpRBTaSk9j@vger.kernel.org
X-Gm-Message-State: AOJu0YwKXHPHlSHWmaoas8OrbnDwF8QIdxhPFEj96AXHQfNQ7G1h+Lnq
	kmqw14diUOafy6i5CAnH+vQvmgvRRmunMrvVzV9NHwSbvH8NHJuBLyWI
X-Gm-Gg: ASbGncuom6r2+mr/B9nLi0VvKeM1EG0j+AGa4Mf6J99u663zbKYTxn8eiz5d+mJjeLM
	c2GIfKR04WShG34ZYsWYWtp64ZfVP6Ujq2T31K/hbc7VXXRKNXlRnyb4ZLwCD+GIkacPG3FBbkZ
	9XezGbC3FIsB7rGekt77CA80EEuVfRx597RSPmkPT/OZyw/DmPW6AJxv5Ev3s6XUUclscAnFMu1
	Vu0YKWFGknc/+kEq1UXzfgb2XCjAMteIBazosJ/D7pn24IyU93yZJRbggKvXWuYrDbYhNRlCOGK
	ZRBrXR2I9K1fdAfkB4i4Qu51ivfTZKPI/q4D6duw5dM55qp4SG5GLvQGaYI6+D81ubQGvUxE9se
	mN39JgJVCsB5U8StpgmZmGxChpgYTFT+TiXeQR0iv9zQxCSDy94bdwa4p6P5TEBGOdwLjNX+DtP
	DVKk+ojjJZqnznrdTFBaTMAGLaXw==
X-Google-Smtp-Source: AGHT+IF9iMWwl5XgxOjscnjNIKZX60uI5pWW4FD69VeY7dJHPwN2m94rJhYhQwTP9OEFq4rj9n6brQ==
X-Received: by 2002:a05:6a21:3399:b0:2e6:b58a:ddec with SMTP id adf61e73a8af0-34f8560f31bmr817224637.36.1762289507049;
        Tue, 04 Nov 2025 12:51:47 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a6155sm3270501a12.29.2025.11.04.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 12:51:46 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 4/8] iomap: simplify ->read_folio_range() error handling for reads
Date: Tue,  4 Nov 2025 12:51:15 -0800
Message-ID: <20251104205119.1600045-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104205119.1600045-1-joannelkoong@gmail.com>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
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
---
 .../filesystems/iomap/operations.rst          |  7 +++--
 fs/fuse/file.c                                | 10 ++-----
 fs/iomap/buffered-io.c                        | 27 +++++++++----------
 include/linux/iomap.h                         |  5 ++--
 4 files changed, 20 insertions(+), 29 deletions(-)

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
index e3171462ba08..0f14d2a91f49 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -398,7 +398,8 @@ static void iomap_read_init(struct folio *folio)
 		 * finished reading in the entire folio.
 		 */
 		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += len + 1;
+		WARN_ON_ONCE(ifs->read_bytes_pending != 0);
+		ifs->read_bytes_pending = len + 1;
 		spin_unlock_irq(&ifs->state_lock);
 	}
 }
@@ -414,19 +415,8 @@ static void iomap_read_init(struct folio *folio)
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
 		/*
@@ -451,6 +441,15 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
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
 
@@ -498,10 +497,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
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


