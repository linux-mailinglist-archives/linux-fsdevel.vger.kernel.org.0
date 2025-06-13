Return-Path: <linux-fsdevel+bounces-51631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0122AD97BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7824A2A6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD0A28ECC8;
	Fri, 13 Jun 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcJVwqOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50CE26B75E;
	Fri, 13 Jun 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851467; cv=none; b=JnPHkdwAwu0xbA9ZykAF+823vpW7hgQ8qiI2DHs14U6JIRqvTw7jER6wRvz7SRVbLt3NNPx/fTkT1n8PndoozOP0CaGgWMWyjUqvm0g9CVbmJLFLVqaDBjjrdMP788fH5DTs1jK3UGuIp0V+P2NcU2hqXBBIG7Q89mlklLVqS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851467; c=relaxed/simple;
	bh=cBrYVGQj4lHBy/UsPaCTFXpOsO9+c6VWLcUCtFMjXqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRcgQGXNQHOM0WjXMVWLc4+e1vmUkyalRmHbflUaVoQj/31TG5ddmavUSHZB0lvO6YeEq3eRbxhhFZLNrh5hEAzURu9SyWHJEAuCx/pg3aGN0YmRJ7fzmRGVyzMo6q4OOF7DMpbMDZ/OnDDxsx6DZvWfPhz3PDPKW+foZbGhuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcJVwqOp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748435ce7cdso2333695b3a.1;
        Fri, 13 Jun 2025 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851465; x=1750456265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALPOapVbuDQmetN0MyS8mhaMorwK81IS1lBHrNJLKk4=;
        b=PcJVwqOpgXsfObnQK/KHWCWiRDC4w0Q/dDrFe63ra6S01Zcj4hIqhY/lZqRr7fUHQf
         SeoB7jO6foUbO0X2ECQpSB/kwgeIy2asQpWz3EtBnsHh5u2m5BdWVvLMhpSEkh1UNh6o
         kf4lkutxU+y3IfovaHtn21QRQK3b42oCH7OfbIZsXJux0EjN3K6T/UlwQ2TqteaFeqTB
         oLTUCVHBwvKSxWPZwObf/1S4LTeo8vpYdGoaK5LUBZEqoobfyX01GnHAcxdpjH+D3NpV
         XT1SSl5e2+ZXkuju1yc3oLTK7PxMVHWARWFS4o1kIjGkBLQ39e3X8jS9lh4h7/Nz9QBz
         OH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851465; x=1750456265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALPOapVbuDQmetN0MyS8mhaMorwK81IS1lBHrNJLKk4=;
        b=aiIoT7yuLn6NjRhAaCXu2tjJIih7U9Y6iNBgSELPZWiH6nP2STXV1ZzQ9twRQuGekZ
         3HIAJk168pLHQ10aaBFfjWoTsEk62XnvyDCvPSfEvcZipQhRclB/hCg+fNlbunZ9JseI
         E9hbPteEosB+FkG39HSvTt58VUbNKGPcGZrtMbIz0auuSRimj9OHZdozYTXSOPkVZrc0
         mwBJwoiPODROKHBgQrwK3EGfTw0pk7gaU3CXZCAm0rsjr0Nw7GGAdyzFjSTMXNK/Czq4
         iSA0O14JD+6ryG4dc7J+YwwzSodbd9yK4VCkJtVQUeV+PNQhFHs4dM38ZNQzIDa/2uxz
         1Xyg==
X-Forwarded-Encrypted: i=1; AJvYcCUDJ0yId271uEyXvmmLQlDpeMoy28F5mZ2JMMTVfVaGYbJcXf6GYn1OyLPwFM4VUTFjcdl7BlVhZag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqSvaCj4y00cTZ+KXrxZXDRDEHLNOeP1t2Ac+5SEfh9XK/2XH
	068P03xEWcvhEzbizPQBd97Vv27+R3yxQJsZ5+cW0Et/Lr+Ifgbl7z2yto5beA==
X-Gm-Gg: ASbGnctfG84W2i2n3ZTWNuhcEQuBlhpoEGdKtb/DSz4ao8Ee6S/zBmq7qAwpkwgSbGN
	IZPTKz8hQ2MKlzSRyYZnqzoFQbd3Y20Isph1H0+60TYAv9TJ3LW0MOmPiDS6LmXfEVii+meisPO
	lYVsQia/Omhmhv6/VMjzIe3eOztJAlYiZES78YUWF3XIoQ7CWasQzxkXpvqtf0tdij/ambjtLgL
	+0h1i2GuoeXnDPR/dPTpK+LPz4zKCig9Jx7+ogoYlOwu/rHDlXX4z0C+fyVi3q5a8SBqM2Om8iI
	olOh2keqqD55xZm0aEJFSUuyvn8vjgCWFTYeLhLW0SZ/Qvpl3uP90rkxAw==
X-Google-Smtp-Source: AGHT+IG0W1sT65DNpDyCtAcu5sZH9ZzKGGs6Mza802JCmDL5MP9pCgjbh8SXbt9vF2rn0j0GD1xBpA==
X-Received: by 2002:a05:6a21:6481:b0:1f5:9098:e448 with SMTP id adf61e73a8af0-21fbd54a6d8mr1096686637.5.1749851464876;
        Fri, 13 Jun 2025 14:51:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1643195sm2275105a12.22.2025.06.13.14.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:51:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 11/16] iomap: replace ->submit_ioend() with generic ->writeback_complete() for writeback
Date: Fri, 13 Jun 2025 14:46:36 -0700
Message-ID: <20250613214642.2903225-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the larger effort to have iomap buffered io code support
generic io, replace submit_ioend() with writeback_complete() and move the
bio ioend code into a helper function, iomap_bio_writeback_complete(),
that callers using bios can directly invoke.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../filesystems/iomap/operations.rst          | 18 ++++----
 fs/iomap/buffered-io-bio.c                    | 42 ++++++++++++++++++-
 fs/iomap/buffered-io.c                        | 38 +++--------------
 fs/iomap/internal.h                           |  4 +-
 fs/xfs/xfs_aops.c                             | 14 ++++++-
 include/linux/iomap.h                         | 26 ++++++++----
 6 files changed, 88 insertions(+), 54 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 5d018d504145..47213c810622 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -291,7 +291,7 @@ The ``ops`` structure must be specified and is as follows:
 
  struct iomap_writeback_ops {
      int (*writeback_folio)(struct iomap_writeback_folio_range *ctx);
-     int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
+     int (*writeback_complete)(struct iomap_writepage_ctx *wpc, int status);
      void (*discard_folio)(struct folio *folio, loff_t pos);
  };
 
@@ -319,13 +319,15 @@ The fields are as follows:
 
     This function must be supplied by the filesystem.
 
-  - ``submit_ioend``: Allows the file systems to hook into writeback bio
-    submission.
-    This might include pre-write space accounting updates, or installing
-    a custom ``->bi_end_io`` function for internal purposes, such as
-    deferring the ioend completion to a workqueue to run metadata update
-    transactions from process context before submitting the bio.
-    This function is optional.
+  - ``writeback_complete``: Allows the file systems to execute any logic that
+    needs to happen after ``->writeback_folio`` has been called for all dirty
+    folios. This might include hooking into writeback bio submission for
+    pre-write space accounting updates, or installing a custom ``->bi_end_io``
+    function for internal purposes, such as deferring the ioend completion to
+    a workqueue to run metadata update transactions from process context
+    before submitting the bio.
+    This function is optional. If this function is not provided, iomap will
+    default to ``iomap_bio_writeback_complete``.
 
   - ``discard_folio``: iomap calls this function after ``->writeback_folio``
     fails to schedule I/O for any part of a dirty folio.
diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
index e052fc8b46c1..e9f26a938c8d 100644
--- a/fs/iomap/buffered-io-bio.c
+++ b/fs/iomap/buffered-io-bio.c
@@ -151,7 +151,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
 	iomap_finish_ioend_buffered(ioend);
 }
 
-void iomap_bio_ioend_error(struct iomap_writepage_ctx *wpc, int error)
+static void iomap_ioend_error(struct iomap_writepage_ctx *wpc, int error)
 {
 	wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
 	bio_endio(&wpc->ioend->io_bio);
@@ -230,7 +230,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
 new_ioend:
-		error = iomap_submit_ioend(wpc, 0);
+		error = iomap_writeback_complete(wpc, 0);
 		if (error)
 			return error;
 		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos,
@@ -337,3 +337,41 @@ int iomap_bio_writeback_folio(struct iomap_writeback_folio_range *ctx,
 	return error;
 }
 EXPORT_SYMBOL_GPL(iomap_bio_writeback_folio);
+
+/*
+ * Submit an ioend.
+ *
+ * If @error is non-zero, it means that we have a situation where some part of
+ * the submission process has failed after we've marked pages for writeback.
+ * We cannot cancel ioend directly in that case, so call the bio end I/O handler
+ * with the error status here to run the normal I/O completion handler to clear
+ * the writeback bit and let the file system proess the errors.
+ */
+int iomap_bio_writeback_complete(struct iomap_writepage_ctx *wpc, int error,
+		iomap_submit_ioend_t submit_ioend)
+{
+	if (!wpc->ioend)
+		return error;
+
+	/*
+	 * Let the file systems prepare the I/O submission and hook in an I/O
+	 * comletion handler.  This also needs to happen in case after a
+	 * failure happened so that the file system end I/O handler gets called
+	 * to clean up.
+	 */
+	if (submit_ioend) {
+		error = submit_ioend(wpc, error);
+	} else {
+		if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
+			error = -EIO;
+		if (!error)
+			iomap_submit_bio(&wpc->ioend->io_bio);
+	}
+
+	if (error)
+		iomap_ioend_error(wpc, error);
+
+	wpc->ioend = NULL;
+	return error;
+}
+EXPORT_SYMBOL_GPL(iomap_bio_writeback_complete);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2b8d733f65da..bdf917ae56dc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1450,39 +1450,13 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-/*
- * Submit an ioend.
- *
- * If @error is non-zero, it means that we have a situation where some part of
- * the submission process has failed after we've marked pages for writeback.
- * We cannot cancel ioend directly in that case, so call the bio end I/O handler
- * with the error status here to run the normal I/O completion handler to clear
- * the writeback bit and let the file system proess the errors.
- */
-int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
+int iomap_writeback_complete(struct iomap_writepage_ctx *wpc, int error)
 {
-	if (!wpc->ioend)
-		return error;
-
-	/*
-	 * Let the file systems prepare the I/O submission and hook in an I/O
-	 * comletion handler.  This also needs to happen in case after a
-	 * failure happened so that the file system end I/O handler gets called
-	 * to clean up.
-	 */
-	if (wpc->ops->submit_ioend) {
-		error = wpc->ops->submit_ioend(wpc, error);
-	} else {
-		if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
-			error = -EIO;
-		if (!error)
-			iomap_submit_bio(&wpc->ioend->io_bio);
-	}
-
-	if (error)
-		iomap_bio_ioend_error(wpc, error);
+	if (wpc->ops->writeback_complete)
+		error = wpc->ops->writeback_complete(wpc, error);
+	else
+		error = iomap_bio_writeback_complete(wpc, error, NULL);
 
-	wpc->ioend = NULL;
 	return error;
 }
 
@@ -1661,6 +1635,6 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 	wpc->ops = ops;
 	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
 		error = iomap_writepage_map(wpc, wbc, folio);
-	return iomap_submit_ioend(wpc, error);
+	return iomap_writeback_complete(wpc, error);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index 6efb5905bf4f..bfd3f3be845a 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -32,7 +32,7 @@ u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 bool ifs_set_range_uptodate(struct folio *folio, struct iomap_folio_state *ifs,
 		size_t off, size_t len);
-int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error);
+int iomap_writeback_complete(struct iomap_writepage_ctx *wpc, int error);
 
 #ifdef CONFIG_BLOCK
 int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio,
@@ -40,12 +40,10 @@ int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio,
 void iomap_bio_readpage(const struct iomap *iomap, loff_t pos,
 		struct iomap_readpage_ctx *ctx, size_t poff, size_t plen,
 		loff_t length);
-void iomap_bio_ioend_error(struct iomap_writepage_ctx *wpc, int error);
 void iomap_submit_bio(struct bio *bio);
 #else
 #define iomap_bio_read_folio_sync(...)		(-ENOSYS)
 #define iomap_bio_readpage(...)		((void)0)
-#define iomap_bio_ioend_error(...)		((void)0)
 #define iomap_submit_bio(...)			((void)0)
 #endif /* CONFIG_BLOCK */
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 8878c015bd48..63745ff68250 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -493,6 +493,11 @@ xfs_submit_ioend(
 	return 0;
 }
 
+static int xfs_writeback_complete(struct iomap_writepage_ctx *wpc, int error)
+{
+	return iomap_bio_writeback_complete(wpc, error, xfs_submit_ioend);
+}
+
 /*
  * If the folio has delalloc blocks on it, the caller is asking us to punch them
  * out. If we don't, we can leave a stale delalloc mapping covered by a clean
@@ -532,7 +537,7 @@ xfs_discard_folio(
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
 	.writeback_folio	= xfs_writeback_folio,
-	.submit_ioend		= xfs_submit_ioend,
+	.writeback_complete	= xfs_writeback_complete,
 	.discard_folio		= xfs_discard_folio,
 };
 
@@ -630,9 +635,14 @@ xfs_zoned_submit_ioend(
 	return 0;
 }
 
+static int xfs_zoned_writeback_complete(struct iomap_writepage_ctx *wpc, int error)
+{
+	return iomap_bio_writeback_complete(wpc, error, xfs_zoned_submit_ioend);
+}
+
 static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
 	.writeback_folio	= xfs_zoned_writeback_folio,
-	.submit_ioend		= xfs_zoned_submit_ioend,
+	.writeback_complete	= xfs_zoned_writeback_complete,
 	.discard_folio		= xfs_discard_folio,
 };
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index fe827948035d..f4350e59fe7e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -437,14 +437,10 @@ struct iomap_writeback_ops {
 	int (*writeback_folio)(struct iomap_writeback_folio_range *ctx);
 
 	/*
-	 * Optional, allows the file systems to hook into bio submission,
-	 * including overriding the bi_end_io handler.
-	 *
-	 * Returns 0 if the bio was successfully submitted, or a negative
-	 * error code if status was non-zero or another error happened and
-	 * the bio could not be submitted.
+	 * Optional, allows the file system to call into this once
+	 * ->writeback_folio() on all dirty ranges have been issued.
 	 */
-	int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
+	int (*writeback_complete)(struct iomap_writepage_ctx *wpc, int status);
 
 	/*
 	 * Optional, allows the file system to discard state on a page where
@@ -563,4 +559,20 @@ typedef int iomap_map_blocks_t(struct iomap_writepage_ctx *wpc,
 int iomap_bio_writeback_folio(struct iomap_writeback_folio_range *ctx,
 		iomap_map_blocks_t map_blocks);
 
+#ifdef CONFIG_BLOCK
+/*
+ * Allows the file systems to hook into bio submission, including overriding
+ * the bi_end_io handler.
+ *
+ * Returns 0 if the bio was successfully submitted, or a negative
+ * error code if status was non-zero or another error happened and
+ * the bio could not be submitted.
+ */
+typedef int iomap_submit_ioend_t(struct iomap_writepage_ctx *wpc, int error);
+int iomap_bio_writeback_complete(struct iomap_writepage_ctx *wpc, int error,
+		iomap_submit_ioend_t submit_ioend);
+#else
+#define iomap_bio_writeback_complete(...)	(-ENOSYS)
+#endif /* CONFIG_BLOCK */
+
 #endif /* LINUX_IOMAP_H */
-- 
2.47.1


