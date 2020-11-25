Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DC02C4516
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 17:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgKYQZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 11:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbgKYQZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:25:46 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC41C061A4F
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 08:25:45 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id x22so2503775wmc.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnj1vSewnYJ6/gw6qejvRzkdxRWgCvvqGMHaDGl+NSM=;
        b=YUoZKq8L06+FDLM6Fl810zMa4QNm9z7yylijbYlze6fR8otQLzenAvEmy/fayirA5N
         O41roW+Y0PCq5CiO8xCdkb7te5p4XNiNP2KMYNITnW7GvP766R3pheeUSYaMWtw/NCoq
         hiMpjQptcAu3Wxmv8w5zOIWpXb2cG4iSD2BBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnj1vSewnYJ6/gw6qejvRzkdxRWgCvvqGMHaDGl+NSM=;
        b=FxpqychtIBZW54XJMC+jVnAZZrLTi1gvL4VTaZj00r7HBkvXSNLu8KuD+6BuecfLlG
         2TrShfdcsKjQ0BQMyXsRP6w0YbQfnuWv12oOySc/qgknGFZ6oI+88uquP/blJf1uy76e
         CEHP56ZhJ5rf1MWyuU2Z+OKMhJue4OB1fXbOCAbtyBMykqcfV4+ox15px3nEq3kKPUTh
         dcMdVOVXhjIq3ph/h1ecwzOuiL98F2Ckds+esxgStMYkwYLFmJO6HLeoHLPR3DvqVAno
         CAB8mqco00I2d0WDEWWfzuc97PKm1llQFYUHZKrW9JaZASu94Pd4MKBkk5fba4CtXPBW
         KseQ==
X-Gm-Message-State: AOAM530TqXpvrLGYek1SZgGuOLb+xF1xRGooXJ92y29WR+IcOIoy6iPS
        Z702sQlc2//MNGbdBCdVwmUd6Q==
X-Google-Smtp-Source: ABdhPJzimL6dZ1eWi01TNV2dJDgqjd5jFZPTvE6ZnqLenNCICrynr5xXWljktH5hZBPm90Z1zf9kBQ==
X-Received: by 2002:a7b:cf26:: with SMTP id m6mr4920447wmg.121.1606321544420;
        Wed, 25 Nov 2020 08:25:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a21sm4855187wmb.38.2020.11.25.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:25:43 -0800 (PST)
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
Date:   Wed, 25 Nov 2020 17:25:32 +0100
Message-Id: <20201125162532.1299794-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125162532.1299794-1-daniel.vetter@ffwll.ch>
References: <20201125162532.1299794-1-daniel.vetter@ffwll.ch>
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

