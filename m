Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54722446F10
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Nov 2021 17:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhKFQvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Nov 2021 12:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhKFQvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Nov 2021 12:51:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FB6C061714
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 Nov 2021 09:48:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p17so11086262pgj.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Nov 2021 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7qTqnjZeJ3PhO4zL+B/3Z9KG2zg/h5ziZjbMP4gMkc=;
        b=dzwI9ts0838XlbbxFeG4YTMz5VcE9JgnGPxNXtfOFeqvl9W38LVbtW5UyAPRUB+v70
         MhgRhyipEXuRSBKPiTjY29nfsoIQX80kuTPFKGaIgMPWRN2m4Rw5K0nwHKXh26pKoC7/
         HL4snv+CRGki3KAmicqBnRuuk2hnvR13JBbWUEifvxtwPpgtC8PZ7kMOpRhki3EMETrC
         twHk4x7jLhDzKzbpmFlVJtQFy+t/GSx3j+3B+r3hYRTQEH8Wsl4kcpTfvWmkrO5HR3kQ
         M+Z026oGfI03erEYb5fgYBo255IdLho1TvHDoywn0Ad7b5odaovZpavuSfE2z2udK9kB
         FE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7qTqnjZeJ3PhO4zL+B/3Z9KG2zg/h5ziZjbMP4gMkc=;
        b=AeshxemAlH0q8EsmTcOh9OX5sZyqYbqkU4ElN30c8ku75Lgsaf3Guxss0fm3JJMa+I
         kQu0/jUeKp/illX7Vjk905hkmeCjuCyYLCypudV+ynb0ocIOSGWfneGbYy9TuG2liY7o
         gKo1knArwWXSxrumOWPuIGBt0WX6NLRYkjv7EirGj7EQJw6abH5ndZ/dcMz08yx58b8a
         9BdtRPtysKU7EyfYz1yqFA04ohqmI2MTVvfqYVT9SpzDRPT9p4pHes/rr/Mwlvp4gCmX
         tGO8JB90gRWSDhWVMc8AyZmia8lhXncBwrOyabXub6swug2ZUhoD69POvYVvElv/FDk+
         xq6A==
X-Gm-Message-State: AOAM5335MMPjj/wqnBnMxKe37qhpwfqm+m3GTnarS3C90wQxMOJs6VE4
        LvO5pMlWNElZHmqXE+g+ahJHvALaYI0aAuiBP33tkw==
X-Google-Smtp-Source: ABdhPJyVpGL/kpcfeEI/Nr3Xb6EdgK+j4sqLk0GA+BS/3MEn/0dlIKOmQEAYFjGMwnlaOHtt1UpglHaxqyrYLk6KLj8=
X-Received: by 2002:a63:6bc2:: with SMTP id g185mr50160127pgc.356.1636217330382;
 Sat, 06 Nov 2021 09:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211106011638.2613039-1-jane.chu@oracle.com> <20211106011638.2613039-2-jane.chu@oracle.com>
In-Reply-To: <20211106011638.2613039-2-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 6 Nov 2021 09:48:40 -0700
Message-ID: <CAPcyv4jcgFxgoXFhWL9+BReY8vFtgjb_=Lfai-adFpdzc4-35Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dax: Introduce normal and recovery dax operation modes
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 5, 2021 at 6:17 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> Introduce DAX_OP_NORMAL and DAX_OP_RECOVERY operation modes to
> {dax_direct_access, dax_copy_from_iter, dax_copy_to_iter}.
> DAX_OP_NORMAL is the default or the existing mode, and
> DAX_OP_RECOVERY is a new mode for data recovery purpose.
>
> When dax-FS suspects dax media error might be encountered
> on a read or write, it can enact the recovery mode read or write
> by setting DAX_OP_RECOVERY in the aforementioned APIs. A read
> in recovery mode attempts to fetch as much data as possible
> until the first poisoned page is encountered. A write in recovery
> mode attempts to clear poison(s) in a page-aligned range and
> then write the user provided data over.
>
> DAX_OP_NORMAL should be used for all non-recovery code path.
>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
[..]
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 324363b798ec..931586df2905 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -9,6 +9,10 @@
>  /* Flag for synchronous flush */
>  #define DAXDEV_F_SYNC (1UL << 0)
>
> +/* dax operation mode dynamically set by caller */
> +#define        DAX_OP_NORMAL           0

Perhaps this should be called DAX_OP_FAILFAST?

> +#define        DAX_OP_RECOVERY         1
> +
>  typedef unsigned long dax_entry_t;
>
>  struct dax_device;
> @@ -22,8 +26,8 @@ struct dax_operations {
>          * logical-page-offset into an absolute physical pfn. Return the
>          * number of pages available for DAX at that pfn.
>          */
> -       long (*direct_access)(struct dax_device *, pgoff_t, long,
> -                       void **, pfn_t *);
> +       long (*direct_access)(struct dax_device *, pgoff_t, long, int,

Would be nice if that 'int' was an enum, but I'm not sure a new
parameter is needed at all, see below...

> +                               void **, pfn_t *);
>         /*
>          * Validate whether this device is usable as an fsdax backing
>          * device.
> @@ -32,10 +36,10 @@ struct dax_operations {
>                         sector_t, sector_t);
>         /* copy_from_iter: required operation for fs-dax direct-i/o */
>         size_t (*copy_from_iter)(struct dax_device *, pgoff_t, void *, size_t,
> -                       struct iov_iter *);
> +                       struct iov_iter *, int);

I'm not sure the flag is needed here as the "void *" could carry a
flag in the pointer to indicate that is a recovery kaddr.

>         /* copy_to_iter: required operation for fs-dax direct-i/o */
>         size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
> -                       struct iov_iter *);
> +                       struct iov_iter *, int);

Same comment here.

>         /* zero_page_range: required operation. Zero page range   */
>         int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
>  };
> @@ -186,11 +190,11 @@ static inline void dax_read_unlock(int id)
>  bool dax_alive(struct dax_device *dax_dev);
>  void *dax_get_private(struct dax_device *dax_dev);
>  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
> -               void **kaddr, pfn_t *pfn);
> +               int mode, void **kaddr, pfn_t *pfn);

How about dax_direct_access() calling convention stays the same, but
the kaddr is optionally updated to carry a flag in the lower unused
bits. So:

void **kaddr = NULL; /* caller only cares about the pfn */

void *failfast = NULL;
void **kaddr = &failfast; /* caller wants -EIO not recovery */

void *recovery = (void *) DAX_OP_RECOVERY;
void **kaddr = &recovery; /* caller wants to carefully access page(s)
containing poison */
