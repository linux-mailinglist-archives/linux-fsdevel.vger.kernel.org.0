Return-Path: <linux-fsdevel+bounces-60590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A90B498F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE743AE663
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE3320CB7;
	Mon,  8 Sep 2025 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzA/Itc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C131C59A;
	Mon,  8 Sep 2025 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357552; cv=none; b=L0FytRwJwt/4a0PGy3EvWn2aVKQcVfwk4aRHUTvT8NqRJclX9uJr4jsQ0N142AU3x/+FgrGre2yB1++tTgZGV3CZ6db4FM6gWmUir5m1BlIt6sLHXCmGC5ZAxkdUMmlLRTmF871nDGFKDe5nrpCxOXp5evEyHPQT9gch6fpen9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357552; c=relaxed/simple;
	bh=8bVzq7rcd6+/oHguqVASvBdfwSnObq0kOuEOnIfHh0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhN5qC7+tGOtpGmrIOPQlwZpAyEMNLNSZskoNZXkD/BvBIvLyt3BsZs08InyX+U75FGiF7lEs9nATljuy4587paAba7F907csom0EtR66Ylm/fLJpwzy1+Nq+PMVIuvB/slIeYXh8H5vfeuoPY7xpdqHYg6MMXbmQx5YoCqiNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzA/Itc9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77251d7cca6so3964114b3a.3;
        Mon, 08 Sep 2025 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357550; x=1757962350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7rjD1iv39Js7KLe7xETVP5pGV3Dh0KHSA9Vqd5TnBE=;
        b=DzA/Itc96Zv8HcG3LO/uQ63XGJPizG3EttVDf3MfxqgCH00rHXF4Y5dRI3OT5NPt2J
         ZW9lAgSi0SvgEWyviJn8wvcZkdyI+6MVQUvb9qb9fOn++ubCUl392pLpmKWZT1oDK4ds
         CsZTUyCVJqm4Ru7UZKlKqMFKAwlcqGb2rWRORfjqQxkK8Ac1LuFgWdsEumsdmrOfvSFy
         BDYsOsgjl5PNggdqBjUeiNv/fpkr4ij6YG9iU352yBYNf6E0b6HKwEEmsauna9OKtq9h
         jIAzJ2jL8l0bx2oReMImqXecC4dolKypn+YDix2pFdR4JAXjStAAGwH3Q3qSQYSUbfam
         dOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357550; x=1757962350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7rjD1iv39Js7KLe7xETVP5pGV3Dh0KHSA9Vqd5TnBE=;
        b=UfyEmyUgLsLp0SXI9IJJ1uVkklcEYRe/v1J8RJDa4N2wDy4NqZPTCmRNllWDhr3+wi
         qWjRBxBFLgCt1Q3hucmjPt7IdrJfgFsM2sCj/t6QwT00PF7TKKWrBZdXIQ20QZAk1lRP
         4DYYlhGFX+OLwkWUAwzvuoZFHWQF5QeEElPlkgdnwYSH2b68taB4TKVU/YNTVfhz3d0e
         RiaY6Ty067anpXyYl8hep/fRu+LgJ3XPWzoUy8n+clFh34KjsJHsiQNhJXPx2IyTTTzA
         bM6nQzPoqs+/qosLdS/G6RKVJrpa2i4HHC5CFxqWdeGNUq34dvLA26d58Cn413Z3bt17
         sH7g==
X-Forwarded-Encrypted: i=1; AJvYcCU4QwL6vnAt1YJ84uZMjxfJln0IVm3R7f31oMFT7t3tbn6EQwyV0RePPAKFfXJG0oJeIjjVJMj3GaNt@vger.kernel.org, AJvYcCULn0MWN9wzBuBsfO17doelqk5ktTERwhE9aR6cGDFArOxpmsrKpfQcO9uo96JaTHX+ehXBQjqSvkmI1EywZg==@vger.kernel.org, AJvYcCUlzOeK72vpSwMoaHUlYJlLkyf+0P5URYoQeXd5+zJDSO5CMW9PRHSU6ykbDaWfm53BdGR1DJj5op1z2w==@vger.kernel.org, AJvYcCUo73PLskiX7toZ5JpzCTBLSNvelFjvJkZg1cqVkP/Ls5nivA7vBL8nFlL+8kuzKSW6ISVwfx/OARu6@vger.kernel.org
X-Gm-Message-State: AOJu0YykTzD90XT8jRSTCmcBl5c7o90OsApn12DGHC/53kMRLbjfqvy5
	2Rxkx7wdxn1JiIJ/Y4aWrGPLcqa5y32UBEGxqq6v4xwVtjLljulKJdyJ
X-Gm-Gg: ASbGncswXBB32Eyl6b+VOFJEOeBhTqG+cDZfdiDQ3L7tXLi5ERcw2MWitDV0VgHkLF8
	WGYwj2O/yycTKg8I4AB1gjOA54y/R3Esv83hJd6ekTGV+jWY5D1RUCeuArwuoFs4KZVYF0CO8B9
	S2SmNNRP4aX0+b33OVXQOvwkINCXddu0eK1tC3Bz/HWaT9rUTepFL9MylivpuIbE50edLlsKn1p
	q/Rv7k8Cs84ASuo9ixeN6UE1WkRPzqZCSMZ3T49uNUhLOCYjtUx7aAdjp10yKvyFa05qDr3VtYR
	/A9krPshgdAEuZQNRBcSQDrT++k7eMIKEXaPl4w+RZGKZnQQocl3m6d0Ryiwmv7NLrnhk91mvAL
	tRB8NksjRR6i5JkD6tA==
X-Google-Smtp-Source: AGHT+IGHbUW9FBEb8tIDxVtvLWASURviWnoIYFqblnFqkXVQubVBT8P2+9shF/FbVaCvTpCNN+baqA==
X-Received: by 2002:a05:6a00:4b0c:b0:772:63ba:124 with SMTP id d2e1a72fcca58-7742ddf2532mr10301902b3a.19.1757357550309;
        Mon, 08 Sep 2025 11:52:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4beb67sm30326993b3a.65.2025.09.08.11.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:30 -0700 (PDT)
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
Subject: [PATCH v2 09/16] iomap: add public start/finish folio read helpers
Date: Mon,  8 Sep 2025 11:51:15 -0700
Message-ID: <20250908185122.3199171-10-joannelkoong@gmail.com>
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

Move ifs read_bytes_pending increment logic into a separate helper,
iomap_start_folio_read(), which will be needed later on by
caller-provided read callbacks (added in a later commit) for
read/readahead. This is the counterpart to the currently existing
iomap_finish_folio_read().

Make iomap_start_folio_read() and iomap_finish_folio_read() publicly
accessible. These need to be accessible in order for caller-provided
read callbacks to use.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 26 +++++++++++++++++---------
 include/linux/iomap.h  |  3 +++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 008042108c68..50de09426c96 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -317,9 +317,20 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	return 0;
 }
 
-#ifdef CONFIG_BLOCK
-static void iomap_finish_folio_read(struct folio *folio, size_t off,
-		size_t len, int error)
+void iomap_start_folio_read(struct folio *folio, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs) {
+		spin_lock_irq(&ifs->state_lock);
+		ifs->read_bytes_pending += len;
+		spin_unlock_irq(&ifs->state_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(iomap_start_folio_read);
+
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	bool uptodate = !error;
@@ -339,7 +350,9 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
+EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
+#ifdef CONFIG_BLOCK
 static void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
@@ -381,18 +394,13 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
 	struct bio *bio = ctx->private;
 
 	ctx->folio_owned = true;
-	if (ifs) {
-		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += plen;
-		spin_unlock_irq(&ifs->state_lock);
-	}
+	iomap_start_folio_read(folio, plen);
 
 	sector = iomap_sector(iomap, pos);
 	if (!bio || bio_end_sector(bio) != sector ||
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..0938c4a57f4c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -467,6 +467,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 
+void iomap_start_folio_read(struct folio *folio, size_t len);
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error);
 void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
-- 
2.47.3


