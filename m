Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3410F2BA6BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgKTJ4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgKTJ4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:56:18 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D1C061A48
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 01:56:17 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so9368466wrc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnj1vSewnYJ6/gw6qejvRzkdxRWgCvvqGMHaDGl+NSM=;
        b=YJHuMUqOdXD3RjBDXwq4xxm28eTiQkgXVF1XT/DPzqcSwCe7bJ+AxNmLfgQwjHIsKW
         3SeM+TDUPXszr6Zc57JPx/POuZ5YPbxXs6IfAyzVdZ+bCJo3OgkoLmATYI/rVBFBr9pw
         e/MhE42helKCwyMkK6vSTfE6uxAtZHvyO2IBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnj1vSewnYJ6/gw6qejvRzkdxRWgCvvqGMHaDGl+NSM=;
        b=aC33hwGDCYW/7v6NSho4kKAke00kzOFhk1YM3BXTKkxgwFb/fbcfoAH57Vqvu5SpWu
         SIUGPFneKmRHNuaInkYZCsiwWBcilEBPDb5dA3TebTN3MsYmja8hJ9tljWuh1UU9EK8I
         8qI2eIPP0ddNvGzz5UquZSYBIjXFcskaEuVcgCsZjM/Bgn4SVLqf9EYhhYhYk33nUpyA
         fsOJ1k7h4Ip8SFz8VoEIHyjBpQZ39l4rLfF6YNaprmQ8KKZ6A8rvP053xiBJyd5yf1+i
         jUiQpOzR/V/Mpi8WqdenYQJDpv07+w+5tyww8RcDvYTQ35DbzKQPj/4WuBonVrJopTFB
         oumw==
X-Gm-Message-State: AOAM530TazXuh7cIa51pVred5kGP1wNAaxJN+8rHhD+kS4Qsm+6X/nZ6
        wLdW7d3Ax0ssYIQeZTwkG+M/DQ==
X-Google-Smtp-Source: ABdhPJweygNEvtsDvm694/J94/vH0HdxxfmvF5F1IyJUepsC34aungjZF3hY+8zZe4LmawNek04kBA==
X-Received: by 2002:adf:b74d:: with SMTP id n13mr15648919wre.101.1605866176083;
        Fri, 20 Nov 2020 01:56:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9sm4500208wrr.49.2020.11.20.01.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:56:15 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH] drm/ttm: don't set page->mapping
Date:   Fri, 20 Nov 2020 10:54:45 +0100
Message-Id: <20201120095445.1195585-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120095445.1195585-1-daniel.vetter@ffwll.ch>
References: <20201120095445.1195585-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Random observation while trying to review Christian's patch series to
stop looking at struct page for dma-buf imports.

This was originally added in

commit 58aa6622d32af7d2c08d45085f44c54554a16ed7
Author: Thomas Hellstrom <thellstrom@vmware.com>
Date:   Fri Jan 3 11:47:23 2014 +0100

    drm/ttm: Correctly set page mapping and -index members

    Needed for some vm operations; most notably unmap_mapping_range() with
    even_cows = 0.

    Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
    Reviewed-by: Brian Paul <brianp@vmware.com>

but we do not have a single caller of unmap_mapping_range with
even_cows == 0. And all the gem drivers don't do this, so another
small thing we could standardize between drm and ttm drivers.

Plus I don't really see a need for unamp_mapping_range where we don't
want to indiscriminately shoot down all ptes.

Cc: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Brian Paul <brianp@vmware.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/ttm/ttm_tt.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index da9eeffe0c6d..5b2eb6d58bb7 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -284,17 +284,6 @@ int ttm_tt_swapout(struct ttm_bo_device *bdev, struct ttm_tt *ttm)
 	return ret;
 }
 
-static void ttm_tt_add_mapping(struct ttm_bo_device *bdev, struct ttm_tt *ttm)
-{
-	pgoff_t i;
-
-	if (ttm->page_flags & TTM_PAGE_FLAG_SG)
-		return;
-
-	for (i = 0; i < ttm->num_pages; ++i)
-		ttm->pages[i]->mapping = bdev->dev_mapping;
-}
-
 int ttm_tt_populate(struct ttm_bo_device *bdev,
 		    struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
 {
@@ -313,7 +302,6 @@ int ttm_tt_populate(struct ttm_bo_device *bdev,
 	if (ret)
 		return ret;
 
-	ttm_tt_add_mapping(bdev, ttm);
 	ttm->page_flags |= TTM_PAGE_FLAG_PRIV_POPULATED;
 	if (unlikely(ttm->page_flags & TTM_PAGE_FLAG_SWAPPED)) {
 		ret = ttm_tt_swapin(ttm);
-- 
2.29.2

