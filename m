Return-Path: <linux-fsdevel+bounces-59669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29596B3C5A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211ED3AB3D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADBE3081C7;
	Fri, 29 Aug 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U38iZ+0T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956C276025
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510793; cv=none; b=OVYpSiOQhxJ/pRMEQNeuczRbjGhPHIysvWtthnX9+sGwwW4ZWHJfx+qkeua9fiJoo5BOlzFg2SN4gYe+sF0kETFp1M9ALEsdVRzAO6QnQ3y23p92CMITepX8vFiH+aNcoBPjvO5pE6wRkZVH19tqewgv9eUBlbj4rlC4PWelHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510793; c=relaxed/simple;
	bh=4M84i9H0Ql3GhNZRoekcv4skJz1Zbju97F1Yr4gojnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSsyz+jpr2AnJTgh4Tgm9NDuYMCZN2mZXqsyCouKlIzf3xD8+atfDzZoAPySwWED3a+CvJbVJzhSQITRj1EJZakN9r+oeNxGQsqkui0iP/FMDNT9YVKE9U9FcFNFpmNM6Gts6vaN/YrWtcnGjwu6ACUcYDeQX2zn1mrrldx+vm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U38iZ+0T; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-772301f8ae2so981153b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510791; x=1757115591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSyM1Dze2EIm/h9CrLecmjxbT3LpGai1BWLIFT/iT5s=;
        b=U38iZ+0TlB1H5SNoWWNVP2MLFuKGtx+H8NKQJ4y2sBmVwNQt0Ggchwa/HkAZiD0z5e
         vmfQtrooqBA/226UDpUkE5BkXKfIkRj37yjMJvz4FFI4T9+k2+2EcztI5PS4g1Xv6oM2
         KwkE9w8PkQ2r6h9Df/82Q7xT19crSWWYuxaABfhKF26OEoY5/DJhGVYhfjUVdwcELJSV
         DqN0V7/g4fYbkKIk9MWbga7VgSP+Cmiwmg1ZUjd5Xfcu/HEHvp4eza4nXiDvhuP5MzrE
         IcXUxWY9pmF2VriEoW/bFRJ8MayNKAXH4/HFTU4xWyVmuwUyEs3myHyiy4BqcUvy0l82
         Mwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510791; x=1757115591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSyM1Dze2EIm/h9CrLecmjxbT3LpGai1BWLIFT/iT5s=;
        b=Z2ac2CGuPQXaTKiEnkGNr9Tm/uxFQ1D6iAD1ZD4BM4sgbvmpOYMMCHSgoBVQmaCzua
         +aMqR6CT4Gm7rTAFSnQ/NpnFZVihhQ93E0dPRbX1C3nRrdUZFaxsoQQ5nMZaJ2LuGS8Y
         Ha0Fy/hJt+gt+mI6SBWzuPEG0RXE+HSTAc8zOiKvHUnXmNNcCUwSJ0iz5ywNR0b/IZHF
         4BWOSBKYBS/i96uFd2hpfYW6SkgkPLJpzvjTx4J0gjTmZY3y4mppBb6ojTEG4R1zqr6k
         hFO0SlxWuBp+xBPw5QZkvb7RkHBfXxeD4hycKgyKbBkwwPC8e/QXsk7Q1rcVs2D/0BSf
         YBeg==
X-Forwarded-Encrypted: i=1; AJvYcCVAIXd0Q5ch6WDH43MCp9vhjGBtF+Zp3PWQdWxG0M2y934Grrn90AIDnrp0UfClEfaZBuDxGRk01pmPGX1Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7O6dRkNM/wjweq3ir33AwIBI/VDz15bzugaQhCXkCxBYVzpdH
	acLR6cDarl7pzRaHudwHeoC4b8qd7C/f1Xj9a1uDvFj8LlX/L6ILUYopp+O7aw==
X-Gm-Gg: ASbGncuhacgKtSdeYK2Js464CY6Y/vWHVINd0IntldyDLosasT8XCgxrsAKcec/nU9w
	ZWq4OCqBpX/Hly/kYcZ4OkcIHOypibO5r4GdsrDt/OK2ztniprm5vUJXezcX2paRRnLMRWk0YSO
	EZ/jkRxG0oFC48cDHzhTl448BotZl7E0NQFKa3kkOf9lEcDhw40LLC03k+1JMWO8BfZM1dYSLai
	2G0EIUAiIi5kikaAMA5Ar8LXBNnxkTkAFz3h2x1h3sRgVNLeikU0Sfsw+01EuE463N91bQzxLCi
	zReEErVd+qiLgJbT8B9yEl14wy9Dhew5eQT8wbP/GmNbuq7e4bB2nudELwY4P2vd5fiR3GOkV9z
	C3SoqO2nLi6ZcIsabXlaFpzLHBxsd
X-Google-Smtp-Source: AGHT+IH92kboLhqodMinTpDUK+736mlRKSOdcOh6Az8Rb87HymB90yQOgtuIY+YZl3qJhrrr1GD4fg==
X-Received: by 2002:a05:6a20:7f97:b0:243:a17b:6414 with SMTP id adf61e73a8af0-243d6e5b01dmr528924637.26.1756510791075;
        Fri, 29 Aug 2025 16:39:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d5csm3429829b3a.74.2025.08.29.16.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:39:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 01/12] mm: pass number of pages to __folio_start_writeback()
Date: Fri, 29 Aug 2025 16:39:31 -0700
Message-ID: <20250829233942.3607248-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829233942.3607248-1-joannelkoong@gmail.com>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an additional arg to __folio_start_writeback() that takes in the
number of pages to write back.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/btrfs/subpage.c         |  2 +-
 fs/ext4/page-io.c          |  2 +-
 include/linux/page-flags.h |  4 ++--
 mm/page-writeback.c        | 10 +++++-----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index cb4f97833dc3..895e0c96a8fc 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -456,7 +456,7 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 	 * ordering guarantees.
 	 */
 	if (!folio_test_writeback(folio))
-		__folio_start_writeback(folio, true);
+		__folio_start_writeback(folio, true, folio_nr_pages(folio));
 	if (!folio_test_dirty(folio)) {
 		struct address_space *mapping = folio_mapping(folio);
 		XA_STATE(xas, &mapping->i_pages, folio->index);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 39abfeec5f36..6b12a6b869f8 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -580,7 +580,7 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 		io_folio = page_folio(bounce_page);
 	}
 
-	__folio_start_writeback(folio, keep_towrite);
+	__folio_start_writeback(folio, keep_towrite, folio_nr_pages(folio));
 
 	/* Now submit buffers to write */
 	do {
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8d3fa3a91ce4..d1e0743217b7 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -832,11 +832,11 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-void __folio_start_writeback(struct folio *folio, bool keep_write);
+void __folio_start_writeback(struct folio *folio, bool keep_write, long nr_pages);
 void set_page_writeback(struct page *page);
 
 #define folio_start_writeback(folio)			\
-	__folio_start_writeback(folio, false)
+	__folio_start_writeback(folio, false, folio_nr_pages(folio))
 
 static __always_inline bool folio_test_head(const struct folio *folio)
 {
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index de669636120d..d1b2c91f0619 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3042,9 +3042,9 @@ bool __folio_end_writeback(struct folio *folio)
 	return ret;
 }
 
-void __folio_start_writeback(struct folio *folio, bool keep_write)
+void __folio_start_writeback(struct folio *folio, bool keep_write,
+		long nr_pages)
 {
-	long nr = folio_nr_pages(folio);
 	struct address_space *mapping = folio_mapping(folio);
 	int access_ret;
 
@@ -3065,7 +3065,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 		on_wblist = mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 
 		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
-		wb_stat_mod(wb, WB_WRITEBACK, nr);
+		wb_stat_mod(wb, WB_WRITEBACK, nr_pages);
 		if (!on_wblist) {
 			wb_inode_writeback_start(wb);
 			/*
@@ -3086,8 +3086,8 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 		folio_test_set_writeback(folio);
 	}
 
-	lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr);
-	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
+	lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr_pages);
+	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr_pages);
 
 	access_ret = arch_make_folio_accessible(folio);
 	/*
-- 
2.47.3


