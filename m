Return-Path: <linux-fsdevel+bounces-35618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483C9D664C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 00:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90171B21C33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 23:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9271C5799;
	Fri, 22 Nov 2024 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI6u3I8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEC18A94C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317869; cv=none; b=SFXSJFt8P5ksuR+tM24MnEH7yBSa+fvG+MRCV08JyJuPMKhPE/kbBQ3sP5kjKwfqLwgAHF4bwDsZvOmCyk3/c1FJ0rOnug0Uv07TqO+nQ6gy7wT0c+femuGAhLRfQ8AyJuqVpYdabWuNZPYZjQb/8EkVS1tNyjuSqxrftIrVF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317869; c=relaxed/simple;
	bh=snEhwbjkOQNKji7/3kWdqfeV1eyrezZ9SDDncgYtzj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6H4qvpQgmvilRhsREoDyxVJumxLGVF4KbQvMM2/IACUaaySjgVjGlMvGFBxd5wzNpEBVUktUGguNiFkqJMfsNp+S/qCmwfNa9Vczft7mDTOwEhtEYvo9EbZDfWZ6oAzPrtQXpSQtstTJ58WUUN93kfIkj4sJRpG+lpzvzAj/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI6u3I8q; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6eb0c2dda3cso33763767b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 15:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732317867; x=1732922667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqCGll30CJiyTPfCOluQLlSYspNea277q8s6Em+tUXY=;
        b=jI6u3I8qmgJSq9My+EYB0VUJjb+UF8fxjqGnAgTwuVNVwRQrkkW13lbe+5Sp5HDyjg
         /yCU8Y2vk5pzXl2BTJVpwIqo4NDq4V+MgLh0hq8JeJEWc/2SjYyQ0BUuadgz0IzEgC5a
         mR3EzsMXvl3Fi+Bxa1Ub5sRXi13Goc2L8FkZ3mJrObz2SMvDR/MNvIZbhcNreRWocmch
         o0pC2vFFfRTPmGJgeS/Oytorh8tsaE/5uLlmXYHMu+CUovgJLsopu4pc2XQHaFgmVNXq
         vS+sNYi4QQjR/fOCfjFXpkF02JbLoIv8hSbfannMf230+iyUuD2PsdmlDuhF11/+UR0i
         nHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732317867; x=1732922667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqCGll30CJiyTPfCOluQLlSYspNea277q8s6Em+tUXY=;
        b=nsV2ao27MbtxC9GNVG0sLJghyGfK+TLC2BlsOjuTUFLRKnLV+bonB1+LotbdbvMePU
         /y3EWHqqOVSjeKxz4My/apiTTxiL5nLAjIFS45XlP4mP6SJOwFcJRNtbtO80sei84qYS
         JyLkbaf8A/6PI0l8EGB6su7xuAkHsGgQJGtg/DB2FDmlCBnk2ZESuSeJQxssLxuY3nZ2
         E5ZoRVY4rH2IV5LrTU4WfBMsT1G+rwTBaW6i+CPvoNWKCo3YlVQwHrpatoNdafxiUNVv
         kT/NJwjm0GNaLQz8xrfhktKGJ8NHAmEKCSDnnwiuE88PMLilc0L4eJAqomPwJxO0/R0c
         ppNA==
X-Forwarded-Encrypted: i=1; AJvYcCVXaUfddLKqFp/xpvpr1h1LobZMrGgoLtvd9NDRGbzd4Hm5jPSqPe1HUonNNa/hy7YguTu9Hz8ob0LrDeQR@vger.kernel.org
X-Gm-Message-State: AOJu0YxuEvBD3HmnwbetStf5o0KMS5Zp0B0mdZ91SUOLmm8ic9YhIowp
	/x3UQNr+UO3fBoj/yv2lD44FWaqGXylS7AkD1hOFHBb7XtX1o4TM
X-Gm-Gg: ASbGncvREM/AbdQAJPk9ibBp98J3mNvDxPTUCj3N8QuvM+/PGB/gZneKRoMMh9N+X1g
	Tip8c1W/WEKZ+SKq4g5aYINRHk7BJseqdfp/bZz6iHIqrfhu7I6z4hMUUF6l8T5G7aUyOOLCfc+
	hB7ohHtouHD6lnig8u/eojbGB5zjxflZR0rr4+bz75j1ZzW20FqRm61+aa/GeESJXdAF8kOX/Dd
	7Hleybh6z18fo/P5uTdqQgJtpAEh2DgDOfl4OGjci27Az354HfO5QDzxcZ8sj8zN/5IQeC0kHci
	HM34Yjog
X-Google-Smtp-Source: AGHT+IFKU5jQK1lagqG1ya3hMgLoQLO7xg2eEmLkI7xWE77dGiRpSdFWIYkKQ4nezV34Rrjdl5rIMA==
X-Received: by 2002:a05:690c:688a:b0:6ea:96bf:1706 with SMTP id 00721157ae682-6eee07c224emr61916467b3.0.1732317866710;
        Fri, 22 Nov 2024 15:24:26 -0800 (PST)
Received: from localhost (fwdproxy-nha-006.fbsv.net. [2a03:2880:25ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe2c142sm6918917b3.48.2024.11.22.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 15:24:26 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v6 2/5] mm: skip reclaiming folios in legacy memcg writeback indeterminate contexts
Date: Fri, 22 Nov 2024 15:23:56 -0800
Message-ID: <20241122232359.429647-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241122232359.429647-1-joannelkoong@gmail.com>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
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
---
 mm/vmscan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c74..37ce6b6dac06 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1129,8 +1129,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
@@ -1155,6 +1156,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * takes to write them to disk.
 		 */
 		if (folio_test_writeback(folio)) {
+			mapping = folio_mapping(folio);
+
 			/* Case 1 above */
 			if (current_is_kswapd() &&
 			    folio_test_reclaim(folio) &&
@@ -1165,7 +1168,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
2.43.5


