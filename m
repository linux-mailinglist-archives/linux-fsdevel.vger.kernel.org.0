Return-Path: <linux-fsdevel+bounces-33950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F6D9C0EBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9871C253EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E721732B;
	Thu,  7 Nov 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh4qo4Qb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C5186E58
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007047; cv=none; b=srNlJRVCFV5lvoPbUfmz6SBH153aM/lgvqA5IRfixnhoKX6Q2rzxYExpJfYYbyg+KKWIbEzS/7EXYCRvH0hLK6o5ZJ4S74mBxjkqqSIbtYAyrSJn+QLkX1Mbeg2uLUJNY5Wegxte3basuNATh4k7M3oaZFfh2nTS67BkN7PNtiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007047; c=relaxed/simple;
	bh=TNpy65gaPB+tGczJKWkCHgIevd+Hc74bVMSwhGgGHDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjy17oG5ohRGfn73BxaOZ2Ec7O1/BI0/CXl0RGl+jgCrxR08twsJuVE34Fl4H3fxLzox+kE5wCW/RehomfpUVN94d1awyXn6wFtkK1Er59XE83gAxvWbnZQ4SbmuULnSwzbpqBLHrE7eHNJgZdtW4nprCXPzMoZeNUWoKaO6tyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh4qo4Qb; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ea5f68e17aso14392457b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007045; x=1731611845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGp398/OGKFadKTdBHGJCLRTWw479TJgb4XjwbwuJpk=;
        b=Bh4qo4QbhFM8tjbGYTgWWIbBm6Al/CQivl9dUzUXQvKttcA00rCsDMrDBn/tVQxshx
         SfwPr+ttZjAnCzhwWeKx9rXq//PxAc5/s3ieK43DUHZsGNM/LM0aJw7GPUvMKuppfHvz
         xlosk3F6JeFvY0EnbInFshvVaLXxu79zGkZBwRGw8WhacNw76FS3oTol7Vd+k/jXMJ+l
         do+++WDiDLw6gCPniZx3LF8bJ6ZH/4dFdMdSdxDUS7vVMWq1IVfnmnrrHh+6+hxM8MF1
         i3ndqsBVrQfQUw0eOB0gT8heRGyc9n3yvtOLO+mdGV+oQW1V3kZVhCI0Q9C7aSqpt2A4
         Q4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007045; x=1731611845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGp398/OGKFadKTdBHGJCLRTWw479TJgb4XjwbwuJpk=;
        b=Zo3SLXCT1eNCqg+uLIRFfiIaaGLripce+CmzGErvZXXddGPIq9ZP+kVNAhV7SI0tqE
         Wr52MfWPvCMPxD22kYAFi9OQycc73+YnMhvsji8uat6fcJGTqCWwTPX85QSTkTxJiiyu
         pW4YiE+EyeEwObIX3gfvJgXp51hOoksCnecw656QaClqNm9Mc141QmheF3T6MmlJQSQn
         l14nIInFRHoZo4XtOQnSV0gEZMC340NGsYeIElWFQ3xOXNsHraAMTjzoq6O0/IdUiYa1
         iNwoQUqqrrhctECJD2W6O3xL45eMqdqlwYevKL3LEhTS0vgAlUlp3NiqD0haQwhc7oY6
         mk+A==
X-Forwarded-Encrypted: i=1; AJvYcCWQulQbOKsoQyfBIMVI+/ZoxVimgODVsOq1Hr/aSzrKm7s8Tm0jnI/icTk5yDRfy3xNYiwTXxwpIrOuL23e@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xTudojPHyat3j9KVwRvf0chNxWVYzf6+OZFGPcHZhQOwND/0
	I2Y5YvrIntb7raRrOHrkzc0qTOyMrQiUtPhf0Dz3v5i1rtgxBLH5
X-Google-Smtp-Source: AGHT+IH7Um593vs1SsckKVS39lYFZVnOlvrS2bG7U8disolXAeCbKEgSktqlpWFYBAXGxiiFp/wc6A==
X-Received: by 2002:a05:690c:c96:b0:6ea:85ee:b5d4 with SMTP id 00721157ae682-6eaddd86d12mr1008527b3.6.1731007044813;
        Thu, 07 Nov 2024 11:17:24 -0800 (PST)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb65d6csm4034397b3.72.2024.11.07.11.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:17:24 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v3 2/6] mm: skip reclaiming folios in legacy memcg writeback contexts that may block
Date: Thu,  7 Nov 2024 11:16:13 -0800
Message-ID: <20241107191618.2011146-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107191618.2011146-1-joannelkoong@gmail.com>
References: <20241107191618.2011146-1-joannelkoong@gmail.com>
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


