Return-Path: <linux-fsdevel+bounces-31124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF77991F02
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 16:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E971F219DA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3419B138490;
	Sun,  6 Oct 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="RxDzy/sd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31789482EF
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226379; cv=none; b=HP8kbEOahi+RG+L828YEZqjZjg9FruTQ8t+IipDtxJP47q7AU1rjgxcrXp5YjiP3JHqYxsxVAlql/mZqyJvd7NBvH8Q53EURny19yhjyNLB/G0UqS2oGpO8aYTG6b5C7ze7iL+EBJO0juJrdEd9/GbIl25kx73sRZtHzl1IXGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226379; c=relaxed/simple;
	bh=shgDBjQqYSVf0UslaCxth3Qda0hEBLGt1sWdyIHJPVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qGVNGZw2pRb2HwbHkAjhkYGlg3SlgDPeHDg1LrNwEnAEEv92WGeZZi+DgtKicRqTF1Rrcx/wccIhlFSJxN51hHVDNYbL9NQ5FLR9JHMHO78S1Rf38OOojd/KAnJaJarEYceGCxtRfg0eenUAI/cLKb7I2/gWvic76Ju3Lm7e6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=RxDzy/sd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e07d85e956so2974818a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2024 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728226377; x=1728831177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jN5IJB1E2Lr0al72GEamd2RYur9sqqi/hVsmg8n8rw=;
        b=RxDzy/sddpK++kRlX7NALV7binrBIaAPHAjYb1RFTHcEyReTxzdPYeLEVKFdTpt32b
         A0vj0Qs1satPkjmFxWMZJxNmmrmisCuhLu2B2RHyAt56mkTDTOBXw69D8q1+jULwQToH
         xJn17BmCM0zyRWrdRDJjkXB5fE+Oen2MQDlULNFP4S1VdXtdWNUvSitS4lrB5DnVPf5n
         XlUps8LrX7Plkieoq7wiWJRk7Vipob8RmCBQyQF3qNm2iSbzG6QCzCp6xUTd64i6ub+k
         ptddsiyFX7jwkGJm5/f1Cidq+r/mX1dsiSRW1bAwYFm0qyt3RsKFrpVEzExCIo6GUJcp
         2DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226377; x=1728831177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jN5IJB1E2Lr0al72GEamd2RYur9sqqi/hVsmg8n8rw=;
        b=rpxtSBWZjhzY6VNo+gw14xWwV7U5EWSwcTv7EHqvPOGxjslwwSzSL5wmVap0B+MU39
         /rhhIB6hgfcGQz9wn8AtrXeTpgh90cXrdXgdn8rL/WF1TC8rbCSZhJacULmilSXCEC1d
         75oRicmer4bxRtUzFP/BKT6eHkoQiSpGrYE1iU3OJ/fvIuAPpk2qfHUAxVDgvohDT6bC
         oNXqsM9k3QPB5KLW2gQZ3BNLkUt00ZNzqeWO/CXtdo5Pxz0qME7lH6wewOzahkVLsDhW
         hy20WAuns/6qEGzoeKChFpfSS8fYSLy6p/k0v3GNmF5LV4TPMco5sZWIUd9iUICLYG9O
         WeRA==
X-Forwarded-Encrypted: i=1; AJvYcCXrQNevFWe9j33ivzCKJ1wQGyPQqKrf+vhlX82Zfjj2hwuQceeXAewyzwFCSgBX3k8Lezkm4QlXoXsZibQf@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1Z8q7AiAC94M/gygz6VHFVl5lIzBdUvqfL4dvZ+ylEZkCVGf
	5+93Oa/RnHrQoJ9djL0Gg9mByrkvoV2hIpElIMmQFzBUOQqISgNJARsVyIIpB0M=
X-Google-Smtp-Source: AGHT+IGuPc5eZvJWKPTOyXTikGuhJmkR+fXTXGygxbFH1nWXgpOcVKkQSkjknXHFwPK0qUQPDVGQDA==
X-Received: by 2002:a17:90a:4bc6:b0:2d3:ca3f:7f2a with SMTP id 98e67ed59e1d1-2e1e62674damr9537001a91.22.1728226377448;
        Sun, 06 Oct 2024 07:52:57 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e8664bfasm5213680a91.44.2024.10.06.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 07:52:56 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: jack@suse.cz,
	hch@infradead.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	chandan.babu@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 0/3] Cleanup some writeback codes
Date: Sun,  6 Oct 2024 23:28:46 +0800
Message-Id: <20241006152849.247152-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

v2:
PATCH #1: Rename BANDWIDTH_INTERVAL to BW_DIRTYLIMIT_INTERVAL and update
some comments.

PATCH #2: Pick up Jan's Reviewed-by tag.

PATCH #3: xfs_max_map_length() was written following the logic of
writeback_chunk_size().


Tang Yizhou (3):
  mm/page-writeback.c: Rename BANDWIDTH_INTERVAL to
    BW_DIRTYLIMIT_INTERVAL
  mm/page-writeback.c: Fix comment of wb_domain_writeout_add()
  xfs: Let the max iomap length be consistent with the writeback code

 fs/fs-writeback.c         |  5 ----
 fs/xfs/xfs_iomap.c        | 52 ++++++++++++++++++++++++---------------
 include/linux/writeback.h |  5 ++++
 mm/page-writeback.c       | 18 +++++++-------
 4 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.25.1


