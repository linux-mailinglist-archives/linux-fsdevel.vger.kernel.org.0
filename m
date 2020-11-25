Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694BC2C452F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgKYQ2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 11:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbgKYQ2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:28:44 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD1CC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 08:28:44 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id c80so3469860oib.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRACjaFJh4AZpkepxixl78ErKCZI3elRJ+hcGP1uvRc=;
        b=K4nmwFzet4CmWQbz4zwRTZ6CI5hxzbxZ25gbBnhWnCJH8Q8rKXsL79Ql5rlCpu29Lr
         bPggFh1VtIOTIpQaTQqFAtXfwAgUPiNMU07nzL7WEAwSqk0xgspIBThT1z03Zvfxcs3b
         aqQEsY9KeNryZDXQ07y5HihJ9KhEL6DoeL6A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRACjaFJh4AZpkepxixl78ErKCZI3elRJ+hcGP1uvRc=;
        b=azNYCtjjR9neOW8iaU/LLQwMc+2v6KoMzVwY6kASLwXc544LG2RJKGGMGWNcI9YHA1
         Oh7IaTlZFGDkkGJ9m7x3kSiRnH4xpA/u4LF4ug/laY6ms/hGWDEBGfFrQVDB9jldDWM4
         4OiC0Dgrh9dNh7cSI3L9ubzL3msjYGvivYZ79syTmLUibXPLawLdvb2Dv0vSCRutply+
         u5ssOf+5PHTQOhIe/339Mmm7Qvm/OWHiNHzfb2n9FAWs31WcCLoIdgjjmjQ3/bG1UfVc
         au0voa9U4j1oO1sEO1QxcE6UrwWzHaAWQzcvoyqVC4iDjY8hRdu+Dye5zK/jNboCJqNC
         Q5qA==
X-Gm-Message-State: AOAM530Q8aYfpJVSbv6IjeG2qMssHah9wv2t4+1WSvlCS1mXyCFRhkaD
        JlgbSq6SO4bRYwgM7gdj2NLD0kUXqlzqJa77GKVKyg==
X-Google-Smtp-Source: ABdhPJxFp4HuSi30fm1PHbzKdfrYvQxr8zUWpRKb+OichQq/lnbRaStrtSKPxiYo68cqfG34JDlvPm/6dqfZjcK5iGw=
X-Received: by 2002:aca:7506:: with SMTP id q6mr2814868oic.128.1606321723817;
 Wed, 25 Nov 2020 08:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20201125162532.1299794-1-daniel.vetter@ffwll.ch> <20201125162532.1299794-5-daniel.vetter@ffwll.ch>
In-Reply-To: <20201125162532.1299794-5-daniel.vetter@ffwll.ch>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 25 Nov 2020 17:28:32 +0100
Message-ID: <CAKMK7uGXfqaPUtnX=VgA3tFn3S+Gt9GV+kPguakZ6FF_n8LKuA@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: don't set page->mapping
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 5:25 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> Random observation while trying to review Christian's patch series to
> stop looking at struct page for dma-buf imports.
>
> This was originally added in
>
> commit 58aa6622d32af7d2c08d45085f44c54554a16ed7
> Author: Thomas Hellstrom <thellstrom@vmware.com>
> Date:   Fri Jan 3 11:47:23 2014 +0100
>
>     drm/ttm: Correctly set page mapping and -index members
>
>     Needed for some vm operations; most notably unmap_mapping_range() with
>     even_cows = 0.
>
>     Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>     Reviewed-by: Brian Paul <brianp@vmware.com>
>
> but we do not have a single caller of unmap_mapping_range with
> even_cows == 0. And all the gem drivers don't do this, so another
> small thing we could standardize between drm and ttm drivers.
>
> Plus I don't really see a need for unamp_mapping_range where we don't
> want to indiscriminately shoot down all ptes.
>
> Cc: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: Brian Paul <brianp@vmware.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>

Apologies again, this shouldn't have been included. But at least I
have an idea now why this patch somehow was included in the git
send-email. Lovely interface :-/
-Daniel

> ---
>  drivers/gpu/drm/ttm/ttm_tt.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index da9eeffe0c6d..5b2eb6d58bb7 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -284,17 +284,6 @@ int ttm_tt_swapout(struct ttm_bo_device *bdev, struct ttm_tt *ttm)
>         return ret;
>  }
>
> -static void ttm_tt_add_mapping(struct ttm_bo_device *bdev, struct ttm_tt *ttm)
> -{
> -       pgoff_t i;
> -
> -       if (ttm->page_flags & TTM_PAGE_FLAG_SG)
> -               return;
> -
> -       for (i = 0; i < ttm->num_pages; ++i)
> -               ttm->pages[i]->mapping = bdev->dev_mapping;
> -}
> -
>  int ttm_tt_populate(struct ttm_bo_device *bdev,
>                     struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
>  {
> @@ -313,7 +302,6 @@ int ttm_tt_populate(struct ttm_bo_device *bdev,
>         if (ret)
>                 return ret;
>
> -       ttm_tt_add_mapping(bdev, ttm);
>         ttm->page_flags |= TTM_PAGE_FLAG_PRIV_POPULATED;
>         if (unlikely(ttm->page_flags & TTM_PAGE_FLAG_SWAPPED)) {
>                 ret = ttm_tt_swapin(ttm);
> --
> 2.29.2
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
