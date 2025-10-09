Return-Path: <linux-fsdevel+bounces-63692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C2BCB275
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E1519E7DCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33D1287247;
	Thu,  9 Oct 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTuqRZlH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC02D72625
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050666; cv=none; b=CjDQyYYNAfI6tPu0XmhmhKr19JtYTV+IuOfpcoEvAc4175S8zh8If0vwEtyDmo+G1RpRsu2ho73a6Uesx29VBMDM8oKHU84G6s7tU016+/jPu0e/YofLQMHdpEcRuAubqq/I6VYyiUGN+murxVLOaaFSja8w8X45GeKL7vUChMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050666; c=relaxed/simple;
	bh=Pp6eywmMbQRafpRNLONgu5bAGPmgsofJbHgPwF9A3is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9vXexyUYjVoWzzEXCKMzmDLzhsyxqaPsTkYB/7ItDPwN/Pjd4J6+Vv3X2f35hR5iu0IcbFb/L/3aoq/17oQAwF81GgLJRiKy+8ZltFt5EDlP/m9x6Q0wK68hVaaduaZO95LxnnId3DNDRlB1uT8lity9y5muORDeBw67KJ4umM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTuqRZlH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3322e63602eso2107024a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050664; x=1760655464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgnZJUT+/hycTvJxInJmFP2Qhki4iXOUj9ClFgGHdpo=;
        b=ZTuqRZlHASuFsrfSmdONgxAHwsf03eB7zSThK533w8r9W2MbDc6s1hr5qn7EgVunVC
         XUcklt9f9mSybL9hwfKAKS7xtVxqiGep9PiNLBLEGK7NerRuhfWpaNrN+5Z1iutW+XUn
         4fbXcbe4ALJ6wTC+fbDGWXpf5iknd1h95OMSlLgyRzoDAWizpiQxnbcDrex/uqLUZwpJ
         w78LzX/20NmU+p/tRInS/BlZ5p9p6vrt4wk7L9Z4DdH+qHNV+kFauA0fCbCKfv4w0+xM
         g0JY6io5slrq2vEL39WghuMhKo2dLzcpontOregFNPLjNrBwM1QRLmy+mvuVSD+5TU8P
         z8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050664; x=1760655464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgnZJUT+/hycTvJxInJmFP2Qhki4iXOUj9ClFgGHdpo=;
        b=Cxh02kLlq5Au3Fql1y4zdk3CeHBnEE3mYhDDkGuWDD8nGgeP0zPukrpSnW93KIi4Xy
         ZPiuMAn6y7MT3KXS3wB+ezm6westJRWeOOyqxNA3lGHqopyXY/vlEjOVYT+Oby2/IkRg
         yNk3/ZPsbB53dHYPStDMUx1sD6r3H6/WI+NJY6LlXvtxNWtrf/RxO+asR/sJqZwR7zTE
         TWfsVNYOdoOt+4HRQVPpdvltxLXm6p1aJH2n4eBy0Vjo157tXw+SZ3fNqrlRp/Tee7Dz
         EEw0omHQiMW0jKQHdkAfeTXpvc9sPXnCERy+xqeFj+kOEK60YoZ6o3JL6iFCQ2/djJej
         Ejhw==
X-Forwarded-Encrypted: i=1; AJvYcCWCs4UtkgpJ42Jfboozpkj4yiKmfY2SgDXGXOlO+C14fyDD9WPzhsg/PJA68k+oNNn1GnNRqB8oJHQwGKNM@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkw1hc/02QsO/zm17iFDUcYcpaEB2PMK9O61ik4+suvg0kzEy
	uX8ONRhvo8A+7/+46WO55cdTlhH/C0WzMXhW2JQNRNKlvtuqFyjgE65y
X-Gm-Gg: ASbGncsmfA02g99dEMb5zIEMzIqzPMijnbrTWNG4E9O76BZAEZ2eGomC+5M6NLIv7HG
	aFNjl0Uoea3ld/+SFh5Sf+0XnLLS/fG6KZW/DM7oBCBaoVFozK14buBLHytr2Y74gSM/olk42e0
	NEKX9hcwFrkt2ztVJd4f63XFlUI71vMbxcEcW3zVQuGc4r0WoOQkyBJbj2EJMs7BohISxGNNBjr
	rOPvUG8z9JTerePj23c2oHyfcBkYUU3gkvDhmTDFVkEf+6WNDJDa9qivOusWmVS0nFMcq3B2x7a
	RxcwD/sCiHPyNzODnG/8H9OL2ju5nrGDvXOL4stpjiDfJLqjLDWNiXLcWzrxEfJVXu4bmLvf8pL
	FoZ+xXC9ccQi2fD2jWBjGl0+fahJofTWIq2hKxs+Bfl0jUPAfszCrVBRJXBUrvoKOO/BYk9TKvg
	==
X-Google-Smtp-Source: AGHT+IEdQ66ZANXbTJ447dkogYcHmGTxQjTEaNbq8dg/ri4Qy/NZC4UTagM/EiVc+BOj7axdwqZnpg==
X-Received: by 2002:a17:90b:1e0c:b0:330:a228:d2c with SMTP id 98e67ed59e1d1-33b51161d53mr12683382a91.15.1760050663913;
        Thu, 09 Oct 2025 15:57:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f6c84sm3687906a91.5.2025.10.09.15.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:43 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 4/9] iomap: simplify ->read_folio_range() error handling for reads
Date: Thu,  9 Oct 2025 15:56:06 -0700
Message-ID: <20251009225611.3744728-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009225611.3744728-1-joannelkoong@gmail.com>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
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
---
 .../filesystems/iomap/operations.rst          |  7 +++--
 fs/fuse/file.c                                | 10 ++-----
 fs/iomap/buffered-io.c                        | 26 +++++++++----------
 include/linux/iomap.h                         |  5 ++--
 4 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 018cfd13b9fa..dd05d95ebb3e 100644
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
index 01d378f8de18..591789adb00b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -916,13 +916,6 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 
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
@@ -930,7 +923,8 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
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
index 7f914d5ac25d..dc05ed647ba5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -377,26 +377,16 @@ static void iomap_read_init(struct folio *folio)
 		size_t len = folio_size(folio);
 
 		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += len;
+		WARN_ON_ONCE(ifs->read_bytes_pending != 0);
+		ifs->read_bytes_pending = len;
 		spin_unlock_irq(&ifs->state_lock);
 	}
 }
 
 static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 {
-	struct iomap_folio_state *ifs;
-
-	/*
-	 * If there are no bytes pending, this means we are responsible for
-	 * unlocking the folio here, since no IO helper has taken ownership of
-	 * it.
-	 */
-	if (!bytes_pending) {
-		folio_unlock(folio);
-		return;
-	}
+	struct iomap_folio_state *ifs = folio->private;
 
-	ifs = folio->private;
 	if (ifs) {
 		bool end_read, uptodate;
 		size_t bytes_accounted = folio_size(folio) - bytes_pending;
@@ -415,6 +405,14 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 		spin_unlock_irq(&ifs->state_lock);
 		if (end_read)
 			folio_end_read(folio, uptodate);
+	} else if (!bytes_pending) {
+		/*
+		 * If there are no bytes pending, this means we are responsible
+		 * for unlocking the folio here, since no IO helper has taken
+		 * ownership of it. If there are bytes pending, then the IO
+		 * helper will end the read via iomap_finish_folio_read().
+		 */
+		folio_unlock(folio);
 	}
 }
 
@@ -462,10 +460,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		} else {
 			if (!*bytes_pending)
 				iomap_read_init(folio);
-			*bytes_pending += plen;
 			ret = ctx->ops->read_folio_range(iter, ctx, plen);
 			if (ret)
 				return ret;
+			*bytes_pending += plen;
 		}
 
 		ret = iomap_iter_advance(iter, plen);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index a156a9964938..c417bb8718e3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -491,9 +491,8 @@ struct iomap_read_ops {
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


