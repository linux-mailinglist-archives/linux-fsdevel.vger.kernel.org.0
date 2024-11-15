Return-Path: <linux-fsdevel+bounces-34994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4083E9CFA81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 23:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C34B2C586
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11A1925B9;
	Fri, 15 Nov 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhobvgLK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09622191F9B
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710819; cv=none; b=cFfS+Z1zt3QwMjb2qZ+bpv0/K45aWwyPi0U2jf4cLqmHY7Jl3j7MVazKBTFU2rPmaEP+nLvxQkRBPyngwgPzJl0znVmsnNrj3cbXsIQTRucFMj4hymWbiRmpL91p/6wdzLcxkv8cMYea3e0FlUGS5aUL1Rv+RtcG5nWIU5k0pS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710819; c=relaxed/simple;
	bh=snEhwbjkOQNKji7/3kWdqfeV1eyrezZ9SDDncgYtzj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsBn6Bexg+zctMT8V8lAO3G+V78RnGrqa2bkjIdm/FqlkSbUaJQ4CoFzN9wdnWLQZjqWec+2tEFcLu6gD6iUiGl/HjOpiorgTA70+fDpq+qU1YED6oKMlBOc176ZTVQ3XDOq0sK0plMX8lujHwjBLs2Nr7F9CqvWf1MAjgr3Jdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhobvgLK; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e381cbdd03cso88545276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 14:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731710817; x=1732315617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqCGll30CJiyTPfCOluQLlSYspNea277q8s6Em+tUXY=;
        b=QhobvgLKnR3sth99k5+bOEaXmxwS2+O1kzI2Uz4WTBu0lnSY5gHQ2xyyGx3gNociFr
         kt/5Ig+3oyNBbStoa37//ys0X3xz+CYqnw1buZM2WxK3LqHWDYAhBj7mJ/gVvvWIxq4Y
         csHc59U9HKY9VxqvJcE+ZQoiH0LEQWuWzJhAyeKN5HPT7rpDm5c0MtUiWLvYDOxGJWD/
         DzpFwNQVPyU5iPHBwqJJVhQDmfBY5gRecmAt6TZvy6KvJVCynGTLcKtUUpmf9NWMVlYb
         hv5JhN+idazEqzwgTpHp86iCWutxWCU3atdWZoc5+VBiBQ5ywynvAiuDhPnZ/90DoDE9
         nlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731710817; x=1732315617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqCGll30CJiyTPfCOluQLlSYspNea277q8s6Em+tUXY=;
        b=H804oVesDY0t8isu8eHMbkgc/vY32s5EJQdk9kMY+1CjiDhiw2A4TyymHqIDoHMWqf
         a71Ta+u7jh6MoCOOUE7DwCy1puX5uyGCOP9mZ6GnIJ2nr8kHpuLQYQ+tSDDnaHiqr88s
         ly3f7prhftZh/or3jfq+BeB5Nd2CbhcOZ8TcHdH4JMtI+WsMQ7gnmAYcA1dVcPP5BA+h
         tYh9qoxhP/fNEBGpjDUbwvDNgGYYEa/MJvUM+MSF+0w/qHVPKezUAwoHincHxbetOIXz
         rIpreTBf1iKLOkw+ylPVzC1OV81QehLv8SmoGskkAE8oNNRXYl7HFS+9ZJu7ScftLWKs
         OIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmJvrWx/WHRlUCBqyVM/5o+9Obt+ggOLzo5EpyW/LxWJJ24Zy1wv09h3IISQLvFu9X9BV54KdRUKc60/4A@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFTNSdmPBZz4f91yMVnmnXSG+uzC+QsB7m+7Q3kz+N/mWsccK
	+Ls8khk7bM0Zu2OgUgeshOuvWrLKJ0LNxLRY033NdI3owXcm4TGa/DY90A==
X-Google-Smtp-Source: AGHT+IGSzVy1omnfV54BrGGJewgAW0DzxvxC726Kb7oZp1Mtso6nZFjz9TE4rzvmjlUt+ijR0WPOQw==
X-Received: by 2002:a05:690c:688a:b0:6ea:7c46:8c23 with SMTP id 00721157ae682-6ee55ef8021mr61486187b3.35.1731710816774;
        Fri, 15 Nov 2024 14:46:56 -0800 (PST)
Received: from localhost (fwdproxy-nha-001.fbsv.net. [2a03:2880:25ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7129dc7esm875747b3.40.2024.11.15.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:46:56 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v5 2/5] mm: skip reclaiming folios in legacy memcg writeback indeterminate contexts
Date: Fri, 15 Nov 2024 14:44:56 -0800
Message-ID: <20241115224459.427610-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241115224459.427610-1-joannelkoong@gmail.com>
References: <20241115224459.427610-1-joannelkoong@gmail.com>
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


