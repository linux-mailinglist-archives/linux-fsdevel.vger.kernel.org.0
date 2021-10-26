Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8F43B61E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhJZPzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbhJZPyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:54:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907CDC061348;
        Tue, 26 Oct 2021 08:52:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g8so14365936edb.2;
        Tue, 26 Oct 2021 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPVlSd43MaGLNnv2bHAgLRIpF45DjHAQcAaR9piQZVw=;
        b=mL1u3WabTdo6TubLxq+VUVT7yFq5GGUdgPYcF7n8IlsDSrQNG0Ug76qmuYYJ7QiVum
         E4jqz6ajdkVD9jLrd7X8Ui9LfYUDf4yp2FTkiy/bv71WJbQUVFfzstzUwKolNlPlFE+F
         Q78qkSFEpvVHrcFqu7VLfrSei2neTDiIoreLkUFHW8+oFW8ZTAASekwr7sN43NHaLVKN
         CzfkcXDS1X38syzFULd+WLOxJbRE72xfW/2+653wvqexvSE7bAaWMXE1C730dOCGgMTy
         g4RkQHPFq6Utpb3L2MIyc7F8P9GVZLMPp1r7fj/6e6uHtjmSIi48ydZrl2qByDegCWqx
         w4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPVlSd43MaGLNnv2bHAgLRIpF45DjHAQcAaR9piQZVw=;
        b=mRZ/X39ua9rKQF1fwR0l7WND+7UObnTbSEXLxgU/XmNrUGjpO0ICLNKk6pJWTyxcSd
         /q6zDx787GFErHTeR2A5AO/TttpEqipiNK73Lh2n9vHu9M6Ni8TEM0S5pnJST1NGby+K
         7jsMdvRRtz86ITdqRVpvQOWbW4cjDul9sBbWxc/NTESWHfpGFq9C/TaYAKi54txUdJs0
         kLo1mJrRvVkv4pnFZvySbfRINnj7zf3AbqN5JUXLUXCEpHz4fUnj2IExNz0CzYz/dQIy
         YQJv8CupLnPWeuarKXesB9AsHjtDOxSqCxL1+R+ZE0y1o+6tfvcfmef4QurlzutDBpk4
         YOvQ==
X-Gm-Message-State: AOAM532dsdDE7mSKo1LFjCvsKhRnETu7Wsf/mpKHHYXn9tC2gEITKFYv
        wklQvWvWp9IQiyxTFuEkrCGdY1PZHdfRQnNRTTEAlMIfK5/mYQ==
X-Google-Smtp-Source: ABdhPJxqIn1UxV+0bZlUbnyq6SqlrKSdHvqrBtSN0t8LXMbFZdTV/iOwOHH1bsLWVmn9c4H5Ign0HOLUzi5MW/KlTi4=
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr36360121edc.106.1635263323553;
 Tue, 26 Oct 2021 08:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211025150223.13621-1-mhocko@kernel.org> <20211025150223.13621-3-mhocko@kernel.org>
In-Reply-To: <20211025150223.13621-3-mhocko@kernel.org>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Tue, 26 Oct 2021 17:48:32 +0200
Message-ID: <CA+KHdyVqOuKny7bT+CtrCk8BrnARYz744Ze6cKMuy2BXo5e7jw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Michal Hocko <mhocko@suse.com>
>
> Dave Chinner has mentioned that some of the xfs code would benefit from
> kvmalloc support for __GFP_NOFAIL because they have allocations that
> cannot fail and they do not fit into a single page.
>
> The larg part of the vmalloc implementation already complies with the
> given gfp flags so there is no work for those to be done. The area
> and page table allocations are an exception to that. Implement a retry
> loop for those.
>
> Add a short sleep before retrying. 1 jiffy is a completely random
> timeout. Ideally the retry would wait for an explicit event - e.g.
> a change to the vmalloc space change if the failure was caused by
> the space fragmentation or depletion. But there are multiple different
> reasons to retry and this could become much more complex. Keep the retry
> simple for now and just sleep to prevent from hogging CPUs.
>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmalloc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c6cc77d2f366..602649919a9d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2941,8 +2941,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>         else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
>                 flags = memalloc_noio_save();
>
> -       ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> +       do {
> +               ret = vmap_pages_range(addr, addr + size, prot, area->pages,
>                         page_shift);
> +               if (ret < 0)
> +                       schedule_timeout_uninterruptible(1);
> +       } while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
>

1.
After that change a below code:

<snip>
if (ret < 0) {
    warn_alloc(orig_gfp_mask, NULL,
        "vmalloc error: size %lu, failed to map pages",
        area->nr_pages * PAGE_SIZE);
    goto fail;
}
<snip>

does not make any sense anymore.

2.
Can we combine two places where we handle __GFP_NOFAIL into one place?
That would look like as more sorted out.

-- 
Uladzislau Rezki
