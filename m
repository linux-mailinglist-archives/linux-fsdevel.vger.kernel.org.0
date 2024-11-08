Return-Path: <linux-fsdevel+bounces-34070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0FC9C2446
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87C6B2799C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA121E10A;
	Fri,  8 Nov 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QgTefese"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6121A711
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087921; cv=none; b=IwCdKZXq/2VpbL9O6enxB9z8DUL9zM/mCQWChEzSJ2K4eyK8SMalBfvAIQjF0wJ2BgZBoqn9b0lSJPKDskOTgB5urjI3K6BtyzbuQuxeuNxfKxURBPe6VsUphTPqGWX8t9cs41cw+YzM2Pl1ajftLtljNwdYkEM9S/arrQ7MJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087921; c=relaxed/simple;
	bh=SpPgvJ1Ucle7567qSYAlsafWxvPkBXjWNV83/9D5Z3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXYVI+VVzfqIXZbKAGD8kjQweTeehXvxUAxKLD2Xy6GyCuY115NbZtMRW82UejkEyIHuDiD1CN5U66xTEGCKDu91neyAJff9z0Vy3nS+sQBkYFY1DbM2QDbvn5saCiIdwsufVTrFZ49lb+5GsqA7bj9XeQKz68tnIhYRndez38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QgTefese; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e6104701ffso1630395b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087919; x=1731692719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPkGwSldMNFXF3cURXd1feXLkclwp0ZCxyEpzT1cPW4=;
        b=QgTefesezjL6yt0YcDXrIafVcZ4En+JuRAc1rdbDoeHUtEYsG4hAg+fHlAjU1yRh6l
         DBcLsznGPacdN/HaFGb1Q+8FAFpfSSEwgeTa+9I4y9MzxrhLZDnb08dLNF2bxn+tBTUC
         FvrklWMXvlCqu7sNkjdnZFPYynBTicRuaMDrEiFBUDGo/e6H1JW93kTp4HhExkdn9owJ
         9XIC+pMxrHDuhrHB1U65vagZkZuj66cehY+oe/X1jT43H7nLKwOkq0+v1G/NqKqjRO0b
         bjUmdL01IHwCcRUsv/e3MjA3YeBnLL85v+NneWmbFIiLdmmmGD0/LK/P6BCfsHVASwvQ
         GFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087919; x=1731692719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPkGwSldMNFXF3cURXd1feXLkclwp0ZCxyEpzT1cPW4=;
        b=md0f4+aZMNGp9KxMZTYtMpLT/+wrCXmcjjIzY3whJ7iSKbzd4vS38l2QlchyMu4rs1
         moeJuOrmEvLajlujct+YLG7kBbIkMQGUg2GMeC9nEvVDJJGbuDSX0MefpcMERoNWzrYw
         8VRhgcdmxYRh9fRs/MdyKLg/zg9lr3WuPM2EFgS0iAWnaqZjmbLqZ2NJ2yJG1Il3y0hU
         Vsw6Gx903LHgSInylJdW7w1JNe9Jylr1bVhlpZ3OKKSr8obYjtAr+GGkBDgcRtSNUDk5
         pdLAvbKC7OvPV5XdwW3AFBTC4m+sJCjDNxmkgmsyKvRw82kKmTXbDBE01iul6JnINeLQ
         rP+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsU0CmWFOVc+136uVLvlykzgCE6yRX3sVz7TpcqiPBOVMUDgxJ/5lrkYE8HPL4bvyjonO3Ng3C/55mzzvv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pyg4QYWdwWureT63BcVODBTXxBWrRu2c49S0+hWV3glkUiNu
	+PcneIp5eGMC8+ahiZqRVquMe9nRUrN60wuZv10Q2wuoIMIjHtbyPhrbmRS6U9o=
X-Google-Smtp-Source: AGHT+IF9qnEH6iAmuqzMOZRDZm41rR73Vxyg2vpcvzcsSJsHVKcaTPsimGzR6K5FioRiJT7HzzWlGw==
X-Received: by 2002:a05:6808:2119:b0:3e6:134e:3b90 with SMTP id 5614622812f47-3e79470a347mr4589807b6e.30.1731087919330;
        Fri, 08 Nov 2024 09:45:19 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:18 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/13] mm/readahead: add readahead_control->uncached member
Date: Fri,  8 Nov 2024 10:43:27 -0700
Message-ID: <20241108174505.1214230-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
References: <20241108174505.1214230-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ractl->uncached is set to true, then folios created are marked as
uncached as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 1 +
 mm/readahead.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301..8afacb7520d4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1350,6 +1350,7 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool uncached;
 	bool _workingset;
 	unsigned long _pflags;
 };
diff --git a/mm/readahead.c b/mm/readahead.c
index 003cfe79880d..09cddbbfe28f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
 static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 				       gfp_t gfp_mask, unsigned int order)
 {
-	return filemap_alloc_folio(gfp_mask, order);
+	struct folio *folio;
+
+	folio = filemap_alloc_folio(gfp_mask, order);
+	if (folio && ractl->uncached)
+		folio_set_uncached(folio);
+
+	return folio;
 }
 
 /**
-- 
2.45.2


