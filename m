Return-Path: <linux-fsdevel+bounces-34353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E759C4A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 00:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985611F2268A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827D11CDFAF;
	Mon, 11 Nov 2024 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z93zQai8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059C1CCEC5
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368944; cv=none; b=Ykp8k5T3TvDt/emj8ZUTlnz/u0klXEvWVlJ/SJ7ZBifvr9vDMoCueKaQJchmCck3D1UeBH46IvLtyE3Wr/cjcXd6EN/s9WW3YIs4O+SCjSvSINzFFNR36Y8dGx0nBd6o1R+tUHhF/O1IqVITI7oNaU/csuAsLdcn+heIzPGVIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368944; c=relaxed/simple;
	bh=0ZmHSWGFJPGRrfbaLjT1JKVVHDI+Z6ojoSVY2VwoI0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvE5usRIEdrYKKx5sGi5YJeIMAnBWqMqhp2ZkyyovHFi66jyPNdCqmrXe01DZFAYXWkuEcrelVJ4CwiUNc8mKf1KFqYP7vuxonzZtSSaSAiAkVYIqexoAwldSq7wLbTVc/HcVP9zH3gpuOMBzWurgBzc/0b1AwwwUcbwqE/sVV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z93zQai8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720d01caa66so4744502b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368943; x=1731973743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34CEBvu7gjOMz8fnHdZ3R+2IdL/8ao7S7M5vWTfYjmM=;
        b=z93zQai8EpIDgD0jRAEwLB46HhfxNTDRich3xQOHrqHEJG5auElXfawUzoyo49tXVl
         SdcnVtshzSvFh/Xsz7tm7NXASeQuHaCfD2xrlIGRSvHx9PCnpda0OJxaH7rnsSPkPNie
         agc3KKChj1DU+YZs3+6rvxEw6n/Y41cLyUPlal5eoI4Ci+u2J4eOaYuuslRPPd2w9xVC
         YC8DH9rN1UwT8CIGTVmM/1KJwWytLIo+n92UC22ppiJYn7Ja40/a7UX82i9ve7kc5YhM
         zwSZbZX8U0ztvWOHyeYGyd79SesUdvtq+VlkvmU2nbd/DGPxN/XWVoN+1zWewLvEtEOv
         HOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368943; x=1731973743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34CEBvu7gjOMz8fnHdZ3R+2IdL/8ao7S7M5vWTfYjmM=;
        b=iPKnkaq3oc7ZV7mD4pOpiDdeuwGEfiVYu6VX2JZE3klmFU71FTA4JwYmGrjMuReT93
         EwPA6mKMCfTKoxfxk/WVP31PfS6KOxDRj2AP6fM5Fc+FTbSYsR12hLtTG59T3wu0ejrv
         h8h+X7WBBAFpmOVfu24tsVEdXZYUeauoH7EUunT+6fniN/qzEnepPNdTKvHuVHQ1Lp7N
         gvrThVOn3VYWEHMxpRZ8J86I9Kuo+v7sJiehTmMMYYcbVnbLz0jU7uGVdCLki8luGRyQ
         6tMfncoIAPGWVuJug0nFLgsjobtrFaZRg79OCf+ZkezLVpWgzTWNA4TRsPM0A8PeiPND
         Funw==
X-Forwarded-Encrypted: i=1; AJvYcCX0vPjBd91A32CJgLnkWT/IGCRfeh+GnwnKK8UrO1Ioa0nPH/55hlkdttbdw2C1mboJGSsc93MuoHH0Lk6H@vger.kernel.org
X-Gm-Message-State: AOJu0YzxdE3rxH6FAtvKEjBMGGg7Yb8pMqvO+7G4BuWaJSxNlB1lTkBA
	xFwpzrWI/rq+j4ttakQq8J2VH7nJYixcnBK+EPpvsrf+9pDUOMaQUS5rrZmwUpk=
X-Google-Smtp-Source: AGHT+IH/Zn0FG6bgzME+vU3LW7llTjZ8LDSnQYNIFX21AVqsAPSSvTFEg9AexjHSBcXEhmlzou7m5w==
X-Received: by 2002:a05:6a20:7292:b0:1db:e82f:2a63 with SMTP id adf61e73a8af0-1dc228c6973mr20790006637.3.1731368942803;
        Mon, 11 Nov 2024 15:49:02 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:49:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/16] mm/filemap: make buffered writes work with RWF_UNCACHED
Date: Mon, 11 Nov 2024 16:37:37 -0700
Message-ID: <20241111234842.2024180-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If RWF_UNCACHED is set for a write, mark new folios being written with
uncached. This is done by passing in the fact that it's an uncached write
through the folio pointer. We can only get there when IOCB_UNCACHED was
allowed, which can only happen if the file system opts in. Opting in means
they need to check for the LSB in the folio pointer to know if it's an
uncached write or not. If it is, then FGP_UNCACHED should be used if
creating new folios is necessary.

Uncached writes will drop any folios they create upon writeback
completion, but leave folios that may exist in that range alone. Since
->write_begin() doesn't currently take any flags, and to avoid needing
to change the callback kernel wide, use the foliop being passed in to
->write_begin() to signal if this is an uncached write or not. File
systems can then use that to mark newly created folios as uncached.

Add a helper, generic_uncached_write(), that generic_file_write_iter()
calls upon successful completion of an uncached write.

This provides similar benefits to using RWF_UNCACHED with reads. Testing
buffered writes on 32 files:

writing bs 65536, uncached 0
  1s: 196035MB/sec
  2s: 132308MB/sec
  3s: 132438MB/sec
  4s: 116528MB/sec
  5s: 103898MB/sec
  6s: 108893MB/sec
  7s: 99678MB/sec
  8s: 106545MB/sec
  9s: 106826MB/sec
 10s: 101544MB/sec
 11s: 111044MB/sec
 12s: 124257MB/sec
 13s: 116031MB/sec
 14s: 114540MB/sec
 15s: 115011MB/sec
 16s: 115260MB/sec
 17s: 116068MB/sec
 18s: 116096MB/sec

where it's quite obvious where the page cache filled, and performance
dropped from to about half of where it started, settling in at around
115GB/sec. Meanwhile, 32 kswapds were running full steam trying to
reclaim pages.

Running the same test with uncached buffered writes:

writing bs 65536, uncached 1
  1s: 198974MB/sec
  2s: 189618MB/sec
  3s: 193601MB/sec
  4s: 188582MB/sec
  5s: 193487MB/sec
  6s: 188341MB/sec
  7s: 194325MB/sec
  8s: 188114MB/sec
  9s: 192740MB/sec
 10s: 189206MB/sec
 11s: 193442MB/sec
 12s: 189659MB/sec
 13s: 191732MB/sec
 14s: 190701MB/sec
 15s: 191789MB/sec
 16s: 191259MB/sec
 17s: 190613MB/sec
 18s: 191951MB/sec

and the behavior is fully predictable, performing the same throughout
even after the page cache would otherwise have fully filled with dirty
data. It's also about 65% faster, and using half the CPU of the system
compared to the normal buffered write.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 29 +++++++++++++++++++++++++++++
 mm/filemap.c            | 17 +++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d55bf995bd9e..d35280744aa1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/bitops.h>
 #include <linux/hardirq.h> /* for in_interrupt() */
+#include <linux/writeback.h>
 #include <linux/hugetlb_inline.h>
 
 struct folio_batch;
@@ -70,6 +71,34 @@ static inline int filemap_write_and_wait(struct address_space *mapping)
 	return filemap_write_and_wait_range(mapping, 0, LLONG_MAX);
 }
 
+/*
+ * generic_uncached_write - start uncached writeback
+ * @iocb: the iocb that was written
+ * @written: the amount of bytes written
+ *
+ * When writeback has been handled by write_iter, this helper should be called
+ * if the file system supports uncached writes. If %IOCB_UNCACHED is set, it
+ * will kick off writeback for the specified range.
+ */
+static inline void generic_uncached_write(struct kiocb *iocb, ssize_t written)
+{
+	if (iocb->ki_flags & IOCB_UNCACHED) {
+		struct address_space *mapping = iocb->ki_filp->f_mapping;
+
+		/* kick off uncached writeback */
+		__filemap_fdatawrite_range(mapping, iocb->ki_pos,
+					   iocb->ki_pos + written, WB_SYNC_NONE);
+	}
+}
+
+/*
+ * Value passed in to ->write_begin() if IOCB_UNCACHED is set for the write,
+ * and the ->write_begin() handler on a file system supporting FOP_UNCACHED
+ * must check for this and pass FGP_UNCACHED for folio creation.
+ */
+#define foliop_uncached			((struct folio *) 0xfee1c001)
+#define foliop_is_uncached(foliop)	(*(foliop) == foliop_uncached)
+
 /**
  * filemap_set_wb_err - set a writeback error on an address_space
  * @mapping: mapping in which to set writeback error
diff --git a/mm/filemap.c b/mm/filemap.c
index 40debe742abe..0d312de4e20c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -430,6 +430,7 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 
 	return filemap_fdatawrite_wbc(mapping, &wbc);
 }
+EXPORT_SYMBOL_GPL(__filemap_fdatawrite_range);
 
 static inline int __filemap_fdatawrite(struct address_space *mapping,
 	int sync_mode)
@@ -4076,7 +4077,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	ssize_t written = 0;
 
 	do {
-		struct folio *folio;
+		struct folio *folio = NULL;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
@@ -4104,6 +4105,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
+		/*
+		 * If IOCB_UNCACHED is set here, we now the file system
+		 * supports it. And hence it'll know to check folip for being
+		 * set to this magic value. If so, it's an uncached write.
+		 * Whenever ->write_begin() changes prototypes again, this
+		 * can go away and just pass iocb or iocb flags.
+		 */
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			folio = foliop_uncached;
+
 		status = a_ops->write_begin(file, mapping, pos, bytes,
 						&folio, &fsdata);
 		if (unlikely(status < 0))
@@ -4234,8 +4245,10 @@ ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = __generic_file_write_iter(iocb, from);
 	inode_unlock(inode);
 
-	if (ret > 0)
+	if (ret > 0) {
+		generic_uncached_write(iocb, ret);
 		ret = generic_write_sync(iocb, ret);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(generic_file_write_iter);
-- 
2.45.2


