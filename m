Return-Path: <linux-fsdevel+bounces-56493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2FCB17A9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB8E1C264EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675CC2E40E;
	Fri,  1 Aug 2025 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EByHH/kP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA758836
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008074; cv=none; b=GC6QkuKwAs5JU4lSnq96MKKwv6mpG+wU+BCIYJHxDct4MYdp95zgB8D/ec/lJldQ/Kyh6ZirZ7iqtQ6Dx+lB+/F3VHH8mZK9jtot+eM6nohq9rhSZIQbRflk8lgkvFWx4F3pIwZosZsAFhtV6ht5IWDAA/PJrkoiuyHdN8nebvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008074; c=relaxed/simple;
	bh=7jTuVCvN5ML63PQhddIEtItio+N6UTek5jJKJePWD9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP3mmEXGVjCU2c6+lpOQfPPOTL1z+RjTvl5fBn0iVg2QgC6nQJEfvRKbohRFgh4aoYu8Ney9BDStVOlVDLRqfQ5MOHSQiyGVTdm7XJX9OnCXFwoCW5jKCLFtgkQodwPijbgXzdYw3jtD8pa6us7X30AtISmLCAvl3GrTvWvT8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EByHH/kP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23fd91f2f8bso12691965ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008073; x=1754612873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deo2OGow1Yj8aDDN9/GvEalIjvbT4uSvY5E9OiEOryI=;
        b=EByHH/kPTgB3Jz7v/ojiop0EiY2Oq34YIJQs6v3q1mnruKbJvCy0e8/cgLtaqAj6vR
         Kcn9OfSDsJd0QBoQmBxfT427dXEyVy2CgLBodHfwECDoaENciUNLwMqRsIgJoEdgXnqR
         V6bLMTG1yTqdrcouLvDFodFP5645g4yTooB7fBhJC70suMSdKRHuMTsVm4KqKLkieumk
         gLzjx3nteB/xLHMlmQU4JbDncyp5DL61ZY5lhsgOS2vNj2/kMv57FGJvIMhMULNH10rR
         HsNrM1Mu+Kyf+pD5P3H49rZbEwZiHBh8JRQ0MD1GN7f4S7DHMrL5qQiqTothlCfdKpZc
         p3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008073; x=1754612873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deo2OGow1Yj8aDDN9/GvEalIjvbT4uSvY5E9OiEOryI=;
        b=X46uV6xleaUh3EUgefhNnoqjbtyShxPEbLrevIcJFtO2I08KHOBCIBUYi8b1uv1Xjn
         sXGCd2xUvAo2nIn8jxfXEkPzs4aN8ED/Ek+ZhYL87VyvYzdqg4G3zvO2UpOYGXprGnXT
         pV+UBEumjREtysqlcrUUBb80e2iSu4tY5cke6X/P8izuvOrJmpSgqPAhCms81yCPbeDJ
         Z7d1lGL+balyA/jKgNfswFmkwHsP5HDHeL7fDG9pNOff5yTcIdtU6mDxvnwasbuYGZXI
         vNa+fQVcSL45s6JsKfMQX2DUXkFUxIMXmd04CnJjUOx5b9c7ZzdKOt1UAKjiITKZo3U3
         EJuA==
X-Forwarded-Encrypted: i=1; AJvYcCXrBfrIJZYFRC+uLTejVyBZGCabDQqsM2T2ccX38eVHbG5e0LdVgn5XtQWybXcnzeK+MsRMDv//q6tKgQv7@vger.kernel.org
X-Gm-Message-State: AOJu0YyB6a4hmhc1nVRnVziPqYXE9Rh+AgfKuLHQKmQNJiUUcX2oA/+7
	1qsdtSnMuh4YM6UN7FJpxa/ppCJcnkEy0noYCCCHkGMIqKEXaApIPqaH
X-Gm-Gg: ASbGncv7yIUQETQjzyiGS/WFLc5st9qdy7aMjn/ICU5S/NTJfkEhpqr8qlBwXDChUaF
	RWD7F+e3UHc6s7RcQ5woiPdg4zhx4DIZtSbWW6qve9sJMfNlpXMt9i71B5mziRiHlZnspISEFwZ
	2GAUJPPyZZ7SGZ0qWre4tGluTM+smjUrJkC2oaX46aQOyz3la9IMO3pHHbGqs9FUHA4U3n3nXNW
	bVA9lr9SdoUgzC6nrSXn3rvJPzQw6VrWKGvTYpDYGskXeB0rJi55qiYHaCDrddMy0K2ZpLAAkxs
	d6H24EUeAY2aRsVdPNlRHIAY5EmDGGjjncxREeJWRlJSKqj7ywIo8Qh3Y5Qc7pw+IbsclCiRenK
	ptpfSnwSVROZbw36KNw==
X-Google-Smtp-Source: AGHT+IEFW+3MHl1Xhmh5G/8acxElaSDOU6mMRivRCf0Sdqqhiiwc1uT4itB/3yeBJid0a3++7wNkJg==
X-Received: by 2002:a17:903:1b6e:b0:240:79d5:8772 with SMTP id d9443c01a7336-24096b31ed0mr137542255ad.46.1754008072697;
        Thu, 31 Jul 2025 17:27:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef48fbsm28224925ad.36.2025.07.31.17.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:52 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 08/10] mm: refactor clearing dirty stats into helper function
Date: Thu, 31 Jul 2025 17:21:29 -0700
Message-ID: <20250801002131.255068-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801002131.255068-1-joannelkoong@gmail.com>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move logic for clearing dirty stats into a helper function
both folio_account_cleaned() and __folio_clear_dirty_for_io() invoke.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/page-writeback.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c1fec76ee869..f5916711db2d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2703,6 +2703,14 @@ static void folio_account_dirtied(struct folio *folio,
 	}
 }
 
+static void __clear_dirty_for_io_stats(struct folio *folio,
+			struct bdi_writeback *wb, long nr_pages)
+{
+	lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr_pages);
+	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr_pages);
+	wb_stat_mod(wb, WB_RECLAIMABLE, -nr_pages);
+}
+
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
@@ -2711,9 +2719,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
 {
 	long nr = folio_nr_pages(folio);
 
-	lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
-	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
-	wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
+	__clear_dirty_for_io_stats(folio, wb, nr);
 	task_io_account_cancelled_write(nr * PAGE_SIZE);
 }
 
@@ -2977,14 +2983,9 @@ static bool __folio_clear_dirty_for_io(struct folio *folio, bool update_stats)
 		 */
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 		if (folio_test_clear_dirty(folio)) {
-			if (update_stats) {
-				long nr = folio_nr_pages(folio);
-				lruvec_stat_mod_folio(folio, NR_FILE_DIRTY,
-						      -nr);
-				zone_stat_mod_folio(folio,
-						    NR_ZONE_WRITE_PENDING, -nr);
-				wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
-			}
+			if (update_stats)
+				__clear_dirty_for_io_stats(folio, wb,
+						folio_nr_pages(folio));
 			ret = true;
 		}
 		unlocked_inode_to_wb_end(inode, &cookie);
-- 
2.47.3


