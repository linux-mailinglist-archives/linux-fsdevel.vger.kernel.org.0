Return-Path: <linux-fsdevel+bounces-45789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D067A7C322
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D243BADE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B44E21C184;
	Fri,  4 Apr 2025 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoepOw1B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7520E33E
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790498; cv=none; b=kI/zXDq87oKRT8MQlYz12n2uTbgvJGmYIA/nwYEunGROnFHTEYcBWO7CzI72EEXSIIw6THyn3rNYdbdQKUl3elrWSs01kbsLybs1lZxuB7P4FSUpq6evtCdF6fLQCUr+0E6U6ysMMLiOU2yP+aj2K0QTZj+G8gV8D09jDfqQ77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790498; c=relaxed/simple;
	bh=+VBSKhX7j6A6N00BuuuQ2j8taWbUezB7KPMpQzMnqdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8dXAZ2VMRu0KkCk5LPDdLoOfKe+fxBHQMULynC0CUMgufL+nJIfaHszHzL8k1SkFCrYrks+ncQ82fBy0c8i0bcFJyimrP6IOJj6ioRchYLuhyO3CkAMj9NhQYjQGZTaoWAXqTI4OlzwlhFtTUos7e/JbBSSJjLV/3q5iEYhQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoepOw1B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f4c06e9fso22196095ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743790496; x=1744395296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3pkaibd9TvSbeaSTyou9b7M9WsE2MzhKDeNIDnWjds=;
        b=RoepOw1BiSFv1eiVxLP1kGXAg5EeS0Vbhdlt+PuyoFoj3Jd2lac6S7jvNteMWTCeB2
         RRcauJeynQH0/CVrB0zeeoLiyBZMlFchXaNEfZe6MM5GNELzbdj2ezKBi9arVPvFxNyD
         1Q+uWxocZufn0LUHEpisho/wCU70Gl3EryV+GJaqYVI663HP0HxL4cczlpXBus2cKgje
         CaUyGt6DE3YYpl8oQ1JurgH1N4qtH90cCIZ723vV3aQ1CwveJzakOkS5HlX1Rxmn+qze
         eJA8vkMo8R+FzhNE5XJIoNzks5I25+6ktSq0lOM99pYUNIBItXlMrz84+wARuE9ERY5i
         SJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743790496; x=1744395296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3pkaibd9TvSbeaSTyou9b7M9WsE2MzhKDeNIDnWjds=;
        b=KjZGGEd0DkoHtGor5rpQCa3X9qSTdjzZqfFatQZuYslACI1XCElhaUintb9uD+qXI1
         3PbiFLczX5IredcFyjg0OLzN8AdMp6V9eit4flWGSEIVDjXWfhH+fpfVIHl8KG0nHzeJ
         K5ulyBeM/JChkXuT0URcVDWEpb7zVFzGL9T22QDMrDjBmll2G+BAwiVenGUgrM3lHjPt
         tmEoNZm/HwSO2qNmH4Pxr2NpmaVMli+RvDW8JINlHE12kYKg/X8fkvIdaYrNSi8ZWA0P
         zpnfDdXXe8h/9yEsyJ73MkBCgxC2bdQOqC2VAtdm+117h1hW/ICD3pWpgGNyOBTNGL++
         NLhw==
X-Forwarded-Encrypted: i=1; AJvYcCUK6lqUHGnC24iHnZmUBMRJJIBMQwpEkCNFNJFvXGFa7sWASYWqO+iEWloxUpOsAFTwN0AVv1983XRKRet9@vger.kernel.org
X-Gm-Message-State: AOJu0YzZnLrBf2HzCwW9Oe0CqUnP05gP3k/M8eB97qob8px7gqaa4F/T
	ivdquZ99mR2jlSbLh0ub8WtBzSXCn06whOOVlm1oTqiY7PcofYsx
X-Gm-Gg: ASbGncsb7xqUJT2GN0dfMjo6U262dnxqOfKSGaS4+0FjS6RjWOBpajgGMBdQqdReP+E
	fa/yt/N30QKtQCitKlkw2quvQvwZFy55XwXxR+hPdiF/1nJfAF03QCJNbZ1dlV8G2JBmOipA+NM
	xTAt2//O2kUXHFJp44rEkF6ckjjsrvu2IRl1goG+e6MmGfuaSAWvcaOFlGE8+MVO8JEYfK3bMut
	dla+iXlZ/wOXi45N/m7KCYFBjHQYVyYJYilBtIIzdrhAUFzRLtIDAnBzq1iN5eoWzREU8LtVgBA
	cvuS8cSkMU66mB84WibDmUTTntIhxhcXBIKsNkFB
X-Google-Smtp-Source: AGHT+IHGa8Y8SuMd3n9iFFlNcrZys9TGj4hZu9tApDIQ/6HUQ+OVxypeR21UpAV43u4nzDqgfgcvCA==
X-Received: by 2002:a17:902:d54f:b0:21f:58fd:d215 with SMTP id d9443c01a7336-229765d1b7bmr123372805ad.11.1743790496199;
        Fri, 04 Apr 2025 11:14:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad943sm35587075ad.23.2025.04.04.11.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:14:55 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	david@redhat.com,
	bernd.schubert@fastmail.fm,
	ziy@nvidia.com,
	jlayton@kernel.org,
	kernel-team@meta.com,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v7 2/3] mm: skip reclaiming folios in legacy memcg writeback indeterminate contexts
Date: Fri,  4 Apr 2025 11:14:42 -0700
Message-ID: <20250404181443.1363005-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404181443.1363005-1-joannelkoong@gmail.com>
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently in shrink_folio_list(), reclaim for folios under writeback
falls into 3 different cases:
1) Reclaim is encountering an excessive number of folios under
   writeback and this folio has both the writeback and reclaim flags
   set
2) Dirty throttling is enabled (this happens if reclaim through cgroup
   is not enabled, if reclaim through cgroupv2 memcg is enabled, or
   if reclaim is on the root cgroup), or if the folio is not marked for
   immediate reclaim, or if the caller does not have __GFP_FS (or
   __GFP_IO if it's going to swap) set
3) Legacy cgroupv1 encounters a folio that already has the reclaim flag
   set and the caller did not have __GFP_FS (or __GFP_IO if swap) set

In cases 1) and 2), we activate the folio and skip reclaiming it while
in case 3), we wait for writeback to finish on the folio and then try
to reclaim the folio again. In case 3, we wait on writeback because
cgroupv1 does not have dirty folio throttling, as such this is a
mitigation against the case where there are too many folios in writeback
with nothing else to reclaim.

For filesystems where writeback may take an indeterminate amount of time
to write to disk, this has the possibility of stalling reclaim.

In this commit, if legacy memcg encounters a folio with the reclaim flag
set (eg case 3) and the folio belongs to a mapping that has the
AS_WRITEBACK_INDETERMINATE flag set, the folio will be activated and skip
reclaim (eg default to behavior in case 2) instead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
---
 mm/vmscan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b620d74b0f66..d37843b2e621 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1187,8 +1187,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * 2) Global or new memcg reclaim encounters a folio that is
 		 *    not marked for immediate reclaim, or the caller does not
 		 *    have __GFP_FS (or __GFP_IO if it's simply going to swap,
-		 *    not to fs). In this case mark the folio for immediate
-		 *    reclaim and continue scanning.
+		 *    not to fs), or the writeback may take an indeterminate
+		 *    amount of time to complete. In this case mark the folio
+		 *    for immediate reclaim and continue scanning.
 		 *
 		 *    Require may_enter_fs() because we would wait on fs, which
 		 *    may not have submitted I/O yet. And the loop driver might
@@ -1213,6 +1214,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * takes to write them to disk.
 		 */
 		if (folio_test_writeback(folio)) {
+			mapping = folio_mapping(folio);
+
 			/* Case 1 above */
 			if (current_is_kswapd() &&
 			    folio_test_reclaim(folio) &&
@@ -1223,7 +1226,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			/* Case 2 above */
 			} else if (writeback_throttling_sane(sc) ||
 			    !folio_test_reclaim(folio) ||
-			    !may_enter_fs(folio, sc->gfp_mask)) {
+			    !may_enter_fs(folio, sc->gfp_mask) ||
+			    (mapping && mapping_writeback_indeterminate(mapping))) {
 				/*
 				 * This is slightly racy -
 				 * folio_end_writeback() might have
-- 
2.47.1


