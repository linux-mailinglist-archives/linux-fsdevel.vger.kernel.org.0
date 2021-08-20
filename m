Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0363F35C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 22:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhHTUwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 16:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbhHTUwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:52:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B84DC06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 13:51:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so2845928pjb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULkGRivL56ptdhLg0qblOi29E6UuI3GKppQ73W5RcQM=;
        b=wljVRLX4qPe+NrAUHjhvsefxSXN6ijVZv63Pk+E8YjbzTLnFXsawQ4zasGGHJ9DI/j
         LNnvEAJOChgaeq15qhAKQrNdM+zSHl83TKm21KHMzu/Kj34ogt2J8PlNoComIFiSxTux
         ZKAeASlP7cb89cYcVuiKawdWSszkqhTR6dDUO6JiMBsI2TJxtUKHqwu8/Mu+C8IAY6TH
         IBg2Cuwk7G5a8G6lOMJjraA6x87/5aIT/X9Nt616MtxhG+Oyu8CGTIEk74nvOt3pIg5R
         jyMa0gao/WvU4WUXcSgzEhn+z0TTdpm2b2ioKkK5gyn1+vGrSRBrUOY03LKG9SxDZltK
         zElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULkGRivL56ptdhLg0qblOi29E6UuI3GKppQ73W5RcQM=;
        b=i8rn1z4MRKnfNaW/o5HELWnwhHZz9xeyVXsBq/lTn4o+Mhv9bWbwmR91XQKolRSoLE
         MwHxlFVLWUA4APgf9h2FhKE/ZzTXQvaAbGJaKorMYUmpa/Skhkr4+u2smWY+2uY9a4Ch
         ZhNiPiYWvDIiv8g5k6JCwZkqQJk5ZtwPe++WWUvPxEoEs3q0gRrkC3FVyNHzs8K/UeUP
         N2o+UxAGmqD/YDTT9eggKBLl1fdEi63/Xh/47bLlM4KjJhl/4RF76mLt2rbXanqwRaru
         Dm292Zr+/ZeYJdsp/3C5MfDVNgCRBEBENIeHVFb3Mk1yFosVlFIKFlqYrTeeg+2OHzi4
         zxeA==
X-Gm-Message-State: AOAM530y7+wjYSwQzjUjDSu/UIYghZ4IT0blgUYEBnp4xfwuR0rzmobf
        ZFtxFRUHt8Yb9Ham5iD30kAFu1My2yjPcBRI1u+XYA==
X-Google-Smtp-Source: ABdhPJzPJ2XQpEtJq+wbuCgzapFmXjO/y38fzH3RNB8Wj2SGZHiAnemQziTjbPerD3pCdyF6tyAETSGC8SlS9MQj/UI=
X-Received: by 2002:a17:902:e54e:b0:12d:cca1:2c1f with SMTP id
 n14-20020a170902e54e00b0012dcca12c1fmr17574055plf.79.1629492693543; Fri, 20
 Aug 2021 13:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com> <20210730100158.3117319-5-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210730100158.3117319-5-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 Aug 2021 13:51:22 -0700
Message-ID: <CAPcyv4hQgSV6n0nuiqm-cv7pvpwDgBgZMezW7TkdR9SaAiCNHg@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 4/9] pmem,mm: Implement ->memory_failure in pmem driver
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 3:02 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> With dax_holder notify support, we are able to notify the memory failure
> from pmem driver to upper layers.  If there is something not support in
> the notify routine, memory_failure will fall back to the generic hanlder.

How about:

"Any layer can return -EOPNOTSUPP to force memory_failure() to fall
back to its generic implementation."


>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/nvdimm/pmem.c | 13 +++++++++++++
>  mm/memory-failure.c   | 14 ++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 1e0615b8565e..fea4ffc333b8 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -362,9 +362,22 @@ static void pmem_release_disk(void *__pmem)
>         del_gendisk(pmem->disk);
>  }
>
> +static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
> +               unsigned long pfn, unsigned long nr_pfns, int flags)
> +{
> +       struct pmem_device *pmem =
> +                       container_of(pgmap, struct pmem_device, pgmap);
> +       loff_t offset = PFN_PHYS(pfn) - pmem->phys_addr - pmem->data_offset;
> +
> +       return dax_holder_notify_failure(pmem->dax_dev, offset,
> +                                        page_size(pfn_to_page(pfn)) * nr_pfns,

I do not understand the usage of page_size() here? memory_failure()
assumes PAGE_SIZE pages. DAX pages also do not populate the compound
metadata yet, but even if they did I would expect memory_failure() to
be responsible for doing something like:

    pgmap->ops->memory_failure(pgmap, pfn, size >> PAGE_SHIFT, flags);

...where @size is calculated from dev_pagemap_mapping_shift().

> +                                        &flags);

Why is the local flags variable passed by reference? At a minimum the
memory_failure() flags should be translated to a new set dax-notify
flags, because memory_failure() will not be the only user of this
notification interface. See NVDIMM_REVALIDATE_POISON, and the
discussion Dave and I had about using this notification to signal
unsafe hot-removal of a memory device.


> +}
> +
>  static const struct dev_pagemap_ops fsdax_pagemap_ops = {
>         .kill                   = pmem_pagemap_kill,
>         .cleanup                = pmem_pagemap_cleanup,
> +       .memory_failure         = pmem_pagemap_memory_failure,
>  };
>
>  static int pmem_attach_disk(struct device *dev,
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3bdfcb45f66e..ab3eda335acd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1600,6 +1600,20 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>          */
>         SetPageHWPoison(page);
>
> +       /*
> +        * Call driver's implementation to handle the memory failure, otherwise
> +        * fall back to generic handler.
> +        */
> +       if (pgmap->ops->memory_failure) {
> +               rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
> +               /*
> +                * Fall back to generic handler too if operation is not
> +                * supported inside the driver/device/filesystem.
> +                */
> +               if (rc != EOPNOTSUPP)
> +                       goto out;
> +       }
> +
>         mf_generic_kill_procs(pfn, flags);
>  out:
>         /* drop pgmap ref acquired in caller */
> --
> 2.32.0
>
>
>
