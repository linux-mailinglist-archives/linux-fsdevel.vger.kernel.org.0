Return-Path: <linux-fsdevel+bounces-64974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B78BF7C47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6180541ECA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EAF3473F5;
	Tue, 21 Oct 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp/01MOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59557344D12
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065117; cv=none; b=UO0/f7rZcz9mJ3k8afE19p0Ipjp6i2IcldMvHwZS0JemBDFdKFX1v7Ois6KlEzhclLjUjV5x+8VOn2tCSPxuBnwQny0+pSGxk432EGUPmrEYc5VLi8LoQxrraZ7xT3WKmImz4DgZYlWQoTVMNvjTKZcRrnUQc6pj3MAYPTVz/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065117; c=relaxed/simple;
	bh=FwD2MrLnbZaqzuf2Z77JSgBwhn0IcLfO1ExqwgquWtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzTDl7VxFv59OwDsUGAA3J1ylL+s35zeDpbBOptflfZRW93ReFbKp8fDTkJ+EwhRfzBQIQR0QvSglQKx+Om6BvHEBXbMmMLBUKYyyDwGqrkitPrkMDjoBPYO8QW9iBiY+VFVnjaWf2CaadrPctWQ0cl99FHRTYi3hc/UEHSB3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp/01MOJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-791c287c10dso4516466b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065114; x=1761669914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mou3GN2yVuoD2m8F+DSJi+s0JLZwybE2aelm2ouoM78=;
        b=Gp/01MOJG1paycfWmEilcnc46Ik80TH/mvy+CntotInZzy05Xnu0oCwQFdW3bLIZY/
         ZTBKh1dn/4peam9WFLfVeBkrSVYOVBW6VwNiPgizDQi5snoL6mxq+bsehQN4ASjMn+qV
         RBLNCplKGnCKsrakXdB5TcQ1lgFzkdHCks3FFdmDWVKeOrgeOk1tp+E9keS83S3TBSZm
         50ESXZbm9g7VuYHwvHzIX7BmjG0caDUuxdIVzH/C7mYk8nPYw/B0hBCAg1L0OgHpuSMH
         DVvm6fQDpW16qfp3TgslnNo6/b5ePpyjXozvQV5qEy3b9zRCpPQ6Lr8Cg05tKTNxMO0V
         Cxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065114; x=1761669914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mou3GN2yVuoD2m8F+DSJi+s0JLZwybE2aelm2ouoM78=;
        b=OkvaDsjoqUBZIgY6k/9RyOhg+yLVVdrsApwLglfCZFRpmoNW37rIZ0E83fGJ4OYX8i
         FaQYp6NLlGiAUpQS4dobIIWTPX2beVXPdgxgBJzP5/DxCuX/LTGAG6RGLNmqL7QDHEgP
         YWHWOPuLfphJdC0Cf4qZMCj2Vd3aSHeX7XXFYgw5v81/rIy5juRGbxj3tShWjG1tX8hR
         qNw+7/ZXsMLEnwJJ0iy81FfeU2h0q8hrbDfJ9ELP1LmciEGWN4mEq6Siq/2dfIg0oQpF
         eVUmV0//Fxj8n7xbBW6o/JtBy7N4aRlOxKqoHbWuKWjG9kMS9Jf9xRMzPWL0LR9q0xpl
         QyYw==
X-Forwarded-Encrypted: i=1; AJvYcCWBj39lgkHopd8cqJociFWfsVK2+Srz0dQw3zyMwX8XJdtIwXkgUvSh7l9dgh27AcL9MB4OqaTlyTIGIWjA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8I5SA3k0kAFrYQ920XyBwgrgi528NPl0zDdz33R6T5G2M1pN
	8zD8grbuqoifFQsf465hD+OAbvoPjjFim6lSoKkavpeAMLITIwtlceHv
X-Gm-Gg: ASbGncuLgzg0wLqEFnwEe5tOzGNI3sEfw47U/1ieWu+6ceB05NiWZNy/rOQ3GSm6hv5
	RqOdQRH8ulOwYIk+6eLkhWtvWh6Ix9fEGkacxrK5vKs6fgB5bBK3FH4jbPKs5vYxPx9A99UePmJ
	0mL6OZ1aS5Hr7VfIhqZfUQzG24uaC317dyR6rGPCWm0m/oPHwPyPQzsA8FyvPcfZbNG3lui9V59
	rwPM7nNSsN6txs8GeTm/pBDftkQl96+Fc0RhtZPh91d6ubSZxwqErxcrAmJLGDayZaickMGTTVK
	cAq/P6l8AnHCjC9zAqw8ihNZpOpG6pG+60pP3MGFH4jqSRrN6Q9jE2yDaEr8para7UDqTQ2cyaZ
	T9zDET2d+J8cfrR1RrUfZ1nB1lGzaBf+qYTGkFTMBNk8nOTOBOWnT5tKjNbFPLPtn2IOtyZYo4y
	gbg5ve0NVx0rVJlSIaHQwyxdbmiaM=
X-Google-Smtp-Source: AGHT+IHAfCflVws/zMkWaZg80GELAc9tXrJ453XenewL//1NAt1Ryh10oEg9rR9gvFDBVagP/p18SQ==
X-Received: by 2002:a05:6a00:2e08:b0:776:1de0:4617 with SMTP id d2e1a72fcca58-7a220a57f26mr20392709b3a.11.1761065114181;
        Tue, 21 Oct 2025 09:45:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff39654sm11719712b3a.31.2025.10.21.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:45:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 4/8] iomap: simplify ->read_folio_range() error handling for reads
Date: Tue, 21 Oct 2025 09:43:48 -0700
Message-ID: <20251021164353.3854086-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021164353.3854086-1-joannelkoong@gmail.com>
References: <20251021164353.3854086-1-joannelkoong@gmail.com>
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
 fs/iomap/buffered-io.c                        | 26 +++++++++----------
 include/linux/iomap.h                         |  5 ++--
 4 files changed, 19 insertions(+), 29 deletions(-)

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
index 06d6abda5f75..82ebfa07735f 100644
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
index 655f60187f8f..b999f900e23b 100644
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


