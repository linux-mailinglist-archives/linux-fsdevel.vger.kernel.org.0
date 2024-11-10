Return-Path: <linux-fsdevel+bounces-34151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9663A9C332D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269BB1F2142B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAA2155C9E;
	Sun, 10 Nov 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZfYZoDf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7BB13C8F3
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252564; cv=none; b=l4LIOYVew3cXPqhVyqeESBbRj0aB4V7Gbvz4J1i6973Y8jwCDqwZH/+2wBpWuUNCgUTwlnW4rh4ns34NgM6hbEMny9zvn6hMzwj3pC5bnOKhL3+FidVEA15TrTuPP4LJt0avtgB1Lva6tNoLbWAbJQ0Fzx0UBiTcqGRQ26aY6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252564; c=relaxed/simple;
	bh=aEnrAJGEshe44zlb6XbbKSp/FXpeH0RZvF9K0y5SLj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzjN/hL0ozaLM/hUPLD4mRgNNVvOQ49CMSmyjg8VpribhbMJp45ZACH+sSA+KxiGn/pqeKp4UJEaTcytqwpt83M6j2yjXxUTGDr1stypszp19ZCHrmDa7HlxN3mjfbHp97gknslIBo8KWG54FNCaKSi4/YQd7pRZDAJqzDeHV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZfYZoDf+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so2733162a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252562; x=1731857362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJBisbj/rGvidSFxNEf05dxDvPbQrKvqbgVXmZ2uTrI=;
        b=ZfYZoDf+c7eHi5RDHnl2c3+aGOxYMh/suv0VAX/EdlySskaQd/kZLeqqhvnLCvEofX
         c0YWuNqg/JguAUt09caneDLVxGTZujlvsqfOu/vK+01pgqFvp4YrHOvooGMDCfSXp0nQ
         tUuhFDrkr5BRwMPIYZwVD2GtMn/g3yTZCOCK/N6zHI+7rBaps2s7kqqm+HjbsWW4WJI+
         c+eedGZy5PrI+Kk3WzBak8rf300HSTYVdPfuZvNPmRvM/pklP8IqE/CIWJGEjjYb7qBU
         yrXnlnuNudylAeDbLPKeI3pn3R47UgLsQc5WTyy7srFK+oQCrEOlL7Tos+6gWGX4vlw/
         woQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252562; x=1731857362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJBisbj/rGvidSFxNEf05dxDvPbQrKvqbgVXmZ2uTrI=;
        b=V35WD4Jwm/4FXvalIlbgRQ1PGjrcRXdZntjhY960EtoGavcbnIt0QR+QgYY3BbcvIi
         LvPMHxr1sMs9gurjyRYh2BmyeJRgA/i4JoCln8/Fzs1kng3+BX7yLZIWtJDcoaxGItIt
         anewVgdU2sXAtKi/0/KPbum83Ocaj0QdbK6fI4F9JJzuXLdMPgbw8fUhckP1327THwG4
         Vn5vXPYeGY00h7xBOuqGcUqSY53iXLHPO7wzFuJYy4uZOyrLQH/5zrLNyDD+BA+YLEsg
         72kBsYK6TytlZSUpChVsmVvdf4f2upqM87G1ROHCspJyq1R7HLCs287XAI/K+H6lplIx
         4Ucg==
X-Forwarded-Encrypted: i=1; AJvYcCXK1TSP1uThIBXv9sCvGQZbe77Dvfa17x7B+LJEQmva4pXvWpPAoAkgBWHqNDJhiVR6d3cWyPf5MsN57Mdp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2OeGuO9XI4UYqGyiZZ9NVTiOIuhF/llw5fgrNjISx0yT9MFT
	vWHRKsfPRsyd8txajFF70/R3Cxa0EWW+Q7zBPu4KUfMqSZHDZDWQoSDjDL2g1s56m3S8m0rqUyw
	tSyc=
X-Google-Smtp-Source: AGHT+IEztLXy7pfG6RYnicaB5W8MU9mXcvU3VePtiJO2A6vGFaDJWmS6lrttgNl/g5B6W7Nsuo57hw==
X-Received: by 2002:a17:90b:224f:b0:2e2:da6e:8807 with SMTP id 98e67ed59e1d1-2e9b177fc52mr13814904a91.26.1731252562169;
        Sun, 10 Nov 2024 07:29:22 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/15] mm/truncate: make invalidate_complete_folio2() public
Date: Sun, 10 Nov 2024 08:27:58 -0700
Message-ID: <20241110152906.1747545-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make invalidate_complete_folio2() be publicly available, and have it
take a gfp_t mask as well rather than hardcode GFP_KERNEL. The only
caller just passes in GFP_KERNEL, no functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 2 ++
 mm/truncate.c           | 9 +++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8afacb7520d4..0122b3fbe2ac 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -34,6 +34,8 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count);
 void kiocb_invalidate_post_direct_write(struct kiocb *iocb, size_t count);
 int filemap_invalidate_pages(struct address_space *mapping,
 			     loff_t pos, loff_t end, bool nowait);
+int invalidate_complete_folio2(struct address_space *mapping,
+				struct folio *folio, gfp_t gfp_mask);
 
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
diff --git a/mm/truncate.c b/mm/truncate.c
index 0668cd340a46..e084f7aa9370 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -546,13 +546,13 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * shrink_folio_list() has a temp ref on them, or because they're transiently
  * sitting in the folio_add_lru() caches.
  */
-static int invalidate_complete_folio2(struct address_space *mapping,
-					struct folio *folio)
+int invalidate_complete_folio2(struct address_space *mapping,
+				struct folio *folio, gfp_t gfp_mask)
 {
 	if (folio->mapping != mapping)
 		return 0;
 
-	if (!filemap_release_folio(folio, GFP_KERNEL))
+	if (!filemap_release_folio(folio, gfp_mask))
 		return 0;
 
 	spin_lock(&mapping->host->i_lock);
@@ -650,7 +650,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 			ret2 = folio_launder(mapping, folio);
 			if (ret2 == 0) {
-				if (!invalidate_complete_folio2(mapping, folio))
+				if (!invalidate_complete_folio2(mapping, folio,
+								GFP_KERNEL))
 					ret2 = -EBUSY;
 			}
 			if (ret2 < 0)
-- 
2.45.2


