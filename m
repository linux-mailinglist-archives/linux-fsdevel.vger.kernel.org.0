Return-Path: <linux-fsdevel+bounces-33983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE1C9C12CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 00:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD421C2234A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342111F5837;
	Thu,  7 Nov 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTW21oxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33511F4264
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023793; cv=none; b=bBg13uMnKLpKJs0junr4BfkZVqZ0xOSDPSMK76KC6TOXamPiHH+DXcHAYH4AyN3LZdNU+Geq1+EA5M9k8FYT39LDlCxo68nV3aCk+cQiAieTtR9Kdi2vtkTXtnfVk/jgp5VdlTWtih6B8VtqydsRxuB7HxcbQEp3vsX/9+pyyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023793; c=relaxed/simple;
	bh=TNpy65gaPB+tGczJKWkCHgIevd+Hc74bVMSwhGgGHDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtL18w+Gxld4vx/BXPoCLq+I5XxRDm/Lfviy7QpHPYpfFzaanWA6oLtoMQQT8bI6NSa7B46XqvWFl/VCtIaw+sj/r1EMXq7UxbnnRIEa+OvR4uW5fSLS9pWOenKkfQEX6wfyion8IGrQwE1iexwjpfs01FmIp08w3F1QlebT7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTW21oxM; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e5e5c43497so12747017b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 15:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731023791; x=1731628591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGp398/OGKFadKTdBHGJCLRTWw479TJgb4XjwbwuJpk=;
        b=UTW21oxMWvh6mUInUxCecvr6EaxB5uCiAX3fc68Csh20QmuIxZ/y8eAKzAxRk9zPIG
         SehQv5SgG82zUnbj5t3CZumgB7uxHXtHv6HwQUNTkWOiaAijwURFaiqBiKLT9lqWrdKE
         TekjBX/rf5yaUFcyBymgblSkk9XSz7e/65gz+sAinaO9VPUFL7Je9WEX69QLuY0UZxGD
         JrgO7fVCaX1grHTDNRYp7VGMdvXULLzYClqGfnIukOvlfXf+Cqh5dkViuctrNWfMp+hZ
         WcaFXxZ3Vg8gTHreoLOrYPvCEUyl3KOlh7eKn4Gq5ZUKUcIdIJTiGOj5TDFTesCQy8Mb
         BieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731023791; x=1731628591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGp398/OGKFadKTdBHGJCLRTWw479TJgb4XjwbwuJpk=;
        b=ANJ/MFFeh2hBHQFDT0MO/GKsFD14GwK8c52MTXue/5gWAcey67G+dZQBO3XT2Cq603
         LYFhenngUd1v90+5v6QxgvXnFCTB9b3s2h6vyvFtfaNGfrye7L3jkBobpB1IfoJ9S45i
         85GWoVQCdQBZYVzSp0Lg6OAovBwnrMccWUQrIeGc7a4+BS1PKCfUFojHrYe4Hc966Jon
         GDZ7OnTZJ07ymj2YVJ2oCu0NkFx0Cd9H/+l69Iv4h9zjILetvnEpk+WRm9mVIqJnFEAl
         doYdIgu5h9FzghiRA568nYVvF0/f0TsQqhslbk2H8zvNYxdZpfD9tq/ziMPuC3r0BrwN
         LgxA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Rn3St4w0Uug8Jn1KQ2Kdu0nVrDgHQd67k/+cq+z1KpHL+qFeK8yxbeYxfTRhevynLF/ppuyvV0R+5EU0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvhtc6CJmnD7pm894svHvZxxGs7Wr19GNOldRWPmG9+nwsV2lS
	RguTuVAL+zv+8t2N9ZeVq6e5eEs59DKiWIqq75HkUBIJp3amrs9r
X-Google-Smtp-Source: AGHT+IGtwXdTUWVou6799sIkHT1OBBdHpywl7x1G3IHz/NTXy8iOQgd0OjfXXOssI2uPEUYjyoyP1g==
X-Received: by 2002:a05:690c:4b8d:b0:6e3:8ecc:bb0e with SMTP id 00721157ae682-6eaddd94248mr12819677b3.11.1731023790878;
        Thu, 07 Nov 2024 15:56:30 -0800 (PST)
Received: from localhost (fwdproxy-nha-012.fbsv.net. [2a03:2880:25ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb6563bsm4999937b3.77.2024.11.07.15.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:56:30 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v4 2/6] mm: skip reclaiming folios in legacy memcg writeback contexts that may block
Date: Thu,  7 Nov 2024 15:56:10 -0800
Message-ID: <20241107235614.3637221-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107235614.3637221-1-joannelkoong@gmail.com>
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
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

The issue is that for filesystems where writeback may block, sub-optimal
workarounds may need to be put in place to avoid a potential deadlock
that may arise from reclaim waiting on writeback. (Even though case 3
above is rare given that legacy cgroupv1 is on its way to being
deprecated, this case still needs to be accounted for). For example, for
FUSE filesystems, a temp page gets allocated per dirty page and the
contents of the dirty page are copied over to the temp page so that
writeback can be immediately cleared on the dirty page in order to avoid
the following deadlock:
* single-threaded FUSE server is in the middle of handling a request that
  needs a memory allocation
* memory allocation triggers direct reclaim
* direct reclaim waits on a folio under writeback (eg falls into case 3
  above) that needs to be written back to the FUSE server
* the FUSE server can't write back the folio since it's stuck in direct
  reclaim

In this commit, if legacy memcg encounters a folio with the reclaim flag
set (eg case 3) and the folio belongs to a mapping that has the
AS_WRITEBACK_MAY_BLOCK flag set, the folio will be activated and skip
reclaim (eg default to behavior in case 2) instead.

This allows for the suboptimal workarounds added to address the
"reclaim wait on writeback" deadlock scenario to be removed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/vmscan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c74..e9755cb7211b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1110,6 +1110,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (writeback && folio_test_reclaim(folio))
 			stat->nr_congested += nr_pages;
 
+		mapping = folio_mapping(folio);
+
 		/*
 		 * If a folio at the tail of the LRU is under writeback, there
 		 * are three cases to consider.
@@ -1129,8 +1131,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * 2) Global or new memcg reclaim encounters a folio that is
 		 *    not marked for immediate reclaim, or the caller does not
 		 *    have __GFP_FS (or __GFP_IO if it's simply going to swap,
-		 *    not to fs). In this case mark the folio for immediate
-		 *    reclaim and continue scanning.
+		 *    not to fs), or writebacks in the mapping may block.
+		 *    In this case mark the folio for immediate reclaim and
+		 *    continue scanning.
 		 *
 		 *    Require may_enter_fs() because we would wait on fs, which
 		 *    may not have submitted I/O yet. And the loop driver might
@@ -1165,7 +1168,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			/* Case 2 above */
 			} else if (writeback_throttling_sane(sc) ||
 			    !folio_test_reclaim(folio) ||
-			    !may_enter_fs(folio, sc->gfp_mask)) {
+			    !may_enter_fs(folio, sc->gfp_mask) ||
+			    (mapping && mapping_writeback_may_block(mapping))) {
 				/*
 				 * This is slightly racy -
 				 * folio_end_writeback() might have
-- 
2.43.5


