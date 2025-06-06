Return-Path: <linux-fsdevel+bounces-50882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609E4AD0A65
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1EA3B27E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F09A24166B;
	Fri,  6 Jun 2025 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPgO0O3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429424113D;
	Fri,  6 Jun 2025 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253376; cv=none; b=mbltAwrMn5TW/DKl6kgXAJfCoLSX6RO6+XFlnf8JfIaAhDoQGCoAZpQJdlLX3dka6rZWaH60jSvz9WSvQo3saKyTmn+fTYA7/w1ZBsPXt1MXnV2fHtq+q4AOXny5IG+AstkeJRNESitj6b+uLl2WHwV4JDsx+l5uZk3rwbYZI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253376; c=relaxed/simple;
	bh=96UK2+LPXzKFmUcs0RjliNdpxKIQsgjbhw20OYGdBxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txX218wTVnMnw6vbNQnm67f4uMOhXV5fuvLF8IYZgvw+jZqJ5v/Vin5mUwT3XkCp/cYmsctNqvgnzYCBSw0h4wxim8gkSWH4krisBdJQM3VeC8X0h992t6TqBPxhlo37ny+HgDIksh3+4wyGpB2Y+BfzX/tgMBDxYekG6xJN4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPgO0O3v; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2345c60507bso19003365ad.0;
        Fri, 06 Jun 2025 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749253373; x=1749858173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpIwQKl7IUWt5bGgNbOhmwYs+fqqXDAEW8rHIZt5fbg=;
        b=SPgO0O3vh3h1BuN63Flfhw1mjhRDNbLwNlUmtueut9wTTle9NtUvnjKq9KWPGu2CYX
         bgsn2GYRRfs+NiEDpj9ZEIrMJVazvgEnKWDHaRUh1UFrwO7DpgkM2tW933hBxKiAibXu
         Rt8Vxi11dkxhKEvXol4AcIyIxmWivmp0yBTlP937H59zcLe1OHoShliXIV2YK+VzeQVn
         Byodk6wE0HDTEWy3ZbSEzZD8DbVkiiIcT4bPlPtLRUK6ZCCWDTE9YlKG9e/DSmAB1lSm
         qmhV9yo+ggEyv7/iFJPfyI/B5ncFDU0y7+h8PQEHj4r8/Pad8cQ1r9bULQ6Mv2ut79lM
         wfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253373; x=1749858173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpIwQKl7IUWt5bGgNbOhmwYs+fqqXDAEW8rHIZt5fbg=;
        b=As8yjJHUTt1QVp46hHfNCfYzBBtO3g5mzqfiEfSt4cLuYlsOIpgRFCaxfYTpK4c2WG
         cO9XG7rUEv32HK0MKsCyhZ5l+0+dHcp18pZZQu2m87xoKtNH8OX1YM06O5xwOe/SGnYM
         jXYxwAMwOqMY95LYCMv+JjUIjHPBRWmN8CUWfNnOLLFQ1KVvOQa2kI/XEq0ykzMWTrLt
         Uva7N0MC8FBpbL/CL8y4zlKcmmeJ0+lxeb5ZyjQ3/RMi5weS7SO5Z7/OcaUb9r1rJM4U
         s6fR3HNRKkvQHMG9SjUo9hWb4AUOYHaVhG8CYVzduvqy93xR4k/AvorC7zKdkXbOs25Q
         cSLA==
X-Forwarded-Encrypted: i=1; AJvYcCWKrHJbC59eKEqIAC97azxEYoxPtHQA0Ke0AM49tg81riQ4yCS7Q7hEa8ox/AaIxyzOATFg/H4wnCVA/Pnu@vger.kernel.org, AJvYcCWMCbEW94xmxrYS8d1JEsL8/j0864GKa1aP2Kr+hjykUdqGO0jF90Y5inKBbN9Wo7vf3PzK8UuOtvU1@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2MELpfUpoe8thz4nUjUjJqldT4d1kNdVWxZd0bGpPEccjZQW
	g7Q8nJ4zws9F+ACpU77NaS4dno2vkGnQAiND5XDS5fy/md53oAOEbyiS
X-Gm-Gg: ASbGncvOrund4LvrS+UeN3FhcMrH5HxwZR0Tv9enJCa6n7JQoBrKfmlAJiqw8HmKXzs
	Pi7VrbMTvRj0nt++A3nCMFCZHJSJgTbLCKflX788zXWzcjjNxeyRlY+JkhI5nLJwObTny3jLhcg
	7zywUi3u2iSvK2Rv3VL0PuTXtihEOyviOW6EW3nxHBwhTi4oKPidNglm0IxYxHaUykWCKS9tQ/O
	UPne/5jkSgUCceB0TnDX6/8z7XO2wm9HrqAVQcijMZvWeW3BHFaky/QV7unHYIMKRvCr/tI1onn
	z6OsGtOc3T8A67WwNXiKXUxpufvD15++lKMzbMh++x/o0A==
X-Google-Smtp-Source: AGHT+IEC/uyAQdEg/84Xco+44pZuTOsg0N3CxB+TGxS17Q2BGVK+edAel314O49UohXtgjnYst87ew==
X-Received: by 2002:a17:902:ccd2:b0:234:d399:f948 with SMTP id d9443c01a7336-23601d973bfmr79038485ad.33.1749253373426;
        Fri, 06 Jun 2025 16:42:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603096983sm17820435ad.85.2025.06.06.16.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:42:53 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1 4/8] iomap: add writepages support for IOMAP_IN_MEM iomaps
Date: Fri,  6 Jun 2025 16:37:59 -0700
Message-ID: <20250606233803.1421259-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows IOMAP_IN_MEM iomaps to use iomap_writepages() for handling
writeback. This lets IOMAP_IN_MEM iomaps use some of the internal
features in iomaps such as granular dirty tracking for large folios.

This introduces a new iomap_writeback_ops callback, writeback_folio(),
callers may pass in which hands off folio writeback logic to the caller
for writing back dirty pages instead of relying on mapping blocks.

This exposes two apis, iomap_start_folio_write() and
iomap_finish_folio_write(), which callers may find useful in their
writeback_folio() callback implementation.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io-bio.c | 12 --------
 fs/iomap/buffered-io.c     | 60 ++++++++++++++++++++++++++++++++------
 include/linux/iomap.h      | 18 ++++++++++--
 3 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
index 03841bed72e7..b7bc838cf477 100644
--- a/fs/iomap/buffered-io-bio.c
+++ b/fs/iomap/buffered-io-bio.c
@@ -96,18 +96,6 @@ int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio, size_t po
 	return submit_bio_wait(&bio);
 }
 
-static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
-		size_t len)
-{
-	struct iomap_folio_state *ifs = folio->private;
-
-	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
-	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
-
-	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
-		folio_end_writeback(folio);
-}
-
 /*
  * We're now finished for good with this ioend structure.  Update the page
  * state, release holds on bios, and finally free up memory.  Do not use the
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd2ea1306d88..92f08b316d47 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1441,15 +1441,15 @@ EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
 /*
  * Submit an ioend.
- *
- * If @error is non-zero, it means that we have a situation where some part of
- * the submission process has failed after we've marked pages for writeback.
- * We cannot cancel ioend directly in that case, so call the bio end I/O handler
- * with the error status here to run the normal I/O completion handler to clear
- * the writeback bit and let the file system proess the errors.
  */
 int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 {
+	if (wpc->iomap.type == IOMAP_IN_MEM) {
+		if (wpc->ops->submit_ioend)
+			error = wpc->ops->submit_ioend(wpc, error);
+		return error;
+	}
+
 	if (!wpc->ioend)
 		return error;
 
@@ -1468,6 +1468,13 @@ int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 			iomap_submit_bio(&wpc->ioend->io_bio);
 	}
 
+	/*
+	 * If error is non-zero, it means that we have a situation where some part of
+	 * the submission process has failed after we've marked pages for writeback.
+	 * We cannot cancel ioend directly in that case, so call the bio end I/O handler
+	 * with the error status here to run the normal I/O completion handler to clear
+	 * the writeback bit and let the file system process the errors.
+	 */
 	if (error)
 		iomap_bio_ioend_error(wpc, error);
 
@@ -1635,8 +1642,17 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 */
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
-		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode,
-				pos, end_pos, rlen, &count);
+		if (wpc->ops->writeback_folio) {
+			WARN_ON_ONCE(wpc->ops->map_blocks);
+			error = wpc->ops->writeback_folio(wpc, folio, inode,
+							  offset_in_folio(folio, pos),
+							  rlen);
+		} else {
+			WARN_ON_ONCE(wpc->iomap.type == IOMAP_IN_MEM);
+			error = iomap_writepage_map_blocks(wpc, wbc, folio,
+							   inode, pos, end_pos,
+							   rlen, &count);
+		}
 		if (error)
 			break;
 		pos += rlen;
@@ -1664,7 +1680,11 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
 	} else {
-		if (!count)
+		/*
+		 * If wpc->ops->writeback_folio is set, then it is responsible
+		 * for ending the writeback itself.
+		 */
+		if (!count && !wpc->ops->writeback_folio)
 			folio_end_writeback(folio);
 	}
 	mapping_set_error(inode->i_mapping, error);
@@ -1693,3 +1713,25 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 	return iomap_submit_ioend(wpc, error);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
+
+void iomap_start_folio_write(struct inode *inode, struct folio *folio, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
+	if (ifs)
+		atomic_add(len, &ifs->write_bytes_pending);
+}
+EXPORT_SYMBOL_GPL(iomap_start_folio_write);
+
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
+	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
+
+	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
+		folio_end_writeback(folio);
+}
+EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e748aeebe1a5..4b5e083fa802 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -424,8 +424,8 @@ static inline struct iomap_ioend *iomap_ioend_from_bio(struct bio *bio)
 
 struct iomap_writeback_ops {
 	/*
-	 * Required, maps the blocks so that writeback can be performed on
-	 * the range starting at offset.
+	 * Required if ->writeback_folio is not set. Maps the blocks so that
+	 * writeback can be performed on the range starting at offset.
 	 *
 	 * Can return arbitrarily large regions, but we need to call into it at
 	 * least once per folio to allow the file systems to synchronize with
@@ -436,6 +436,16 @@ struct iomap_writeback_ops {
 	 */
 	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
 			  loff_t offset, unsigned len);
+	/*
+	 * Forwards the folio writeback logic to the caller.
+	 *
+	 * Required for IOMAP_IN_MEM iomaps or if ->map_blocks is not set.
+	 *
+	 * The caller is responsible for ending writeback on the folio after
+	 * it's fully done processing it.
+	 */
+	int (*writeback_folio)(struct iomap_writepage_ctx *wpc, struct folio *folio,
+			       struct inode *inode, loff_t offset, unsigned len);
 
 	/*
 	 * Optional, allows the file systems to hook into bio submission,
@@ -459,6 +469,7 @@ struct iomap_writepage_ctx {
 	struct iomap_ioend	*ioend;
 	const struct iomap_writeback_ops *ops;
 	u32			nr_folios;	/* folios added to the ioend */
+	void			*private;
 };
 
 struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
@@ -538,4 +549,7 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 
 extern struct bio_set iomap_ioend_bioset;
 
+void iomap_start_folio_write(struct inode *inode, struct folio *folio, size_t len);
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio, size_t len);
+
 #endif /* LINUX_IOMAP_H */
-- 
2.47.1


