Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A71286A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgJGWAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 18:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbgJGWAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 18:00:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E6BC0613D2
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2020 15:00:12 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e22so5143741ejr.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2020 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lT3B2ypuGco/P409+8M6gpuF12PaIQWc3S2n+DY8zro=;
        b=Ncyj5HRyOHiv/PCCXeiIOREYqhKi9W7Kz+qYVEQlXmRkJQFhr4mPMx/M7DMnm6YtOW
         DUL/0irEJWJ1u3Tn9PvlSn9dTNsY5IVKDzbC9mmRlGyJusWXyE84FSrRMHnC7+4R/s2K
         JlmM8UKi1+egfyf0npBB325upNgCiCd5lLpYz+Qt+xyrV5CQrPP3johyniRb8z+kgaE1
         GT+P5nqT7wPGuzMyK7J2sXKrVtMSHN7U9uJt8nssAD4vXadYIDhLD2lwmqXOOlH+//Pq
         Hz5f0mZ598OqpvKpcokOiVFhrrXoK3FDSB6Diw9PKUvJFn/Wdx3dxk6fca3QGoU6OwHC
         HCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lT3B2ypuGco/P409+8M6gpuF12PaIQWc3S2n+DY8zro=;
        b=QPtymkAz/HN1171IQnzq3TPBQSUjgcQf1IXGqemcQAWhjGrg9EYnJlB3IW/NdLR5XU
         NvVmPFwa94nVbytJ2GtaPZuMqBoYvkwoIMsmwyYDZMEbbLtWFpTHMZFfJLV8ACyZmjin
         PuCugzNkPgNRUgp9wxZl6NbfWdzoAp8isCIgFK7g8z5jxT+bBET5hGMTilnUSBe7QmWl
         13aX6AEiBShM3X8gZ1M7ZX2vKxgJOSbUh45qR3yTs+Ldgj3v0P1cf3+ivqA73/ZlFGyM
         8pechDTFRr5A95QJWKFX0n0bCzfL6bhXvgwLsD7k8syeUuPgBiBdk4Oo4NKepyYIlQML
         z1jA==
X-Gm-Message-State: AOAM532B14THwdbP7qeIXw9jR6YO+LmkyTuoiZtw/B16mqzQ7DeBqlol
        MEwhm0RFKjxnFlFlfVmjgjgbYH/Hs284mfLNsF87WQ==
X-Google-Smtp-Source: ABdhPJwku5mxYKwAyqqbDYZNawCeRw0Upn7X7sfFjzI/V4bf8n3ZT6QOAaXMTZWtxx4JzYTkY6EwLAJYedQOql+eTOc=
X-Received: by 2002:a17:906:4701:: with SMTP id y1mr5413376ejq.341.1602108010723;
 Wed, 07 Oct 2020 15:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201006230930.3908-1-rcampbell@nvidia.com> <20201007082517.GC6984@quack2.suse.cz>
In-Reply-To: <20201007082517.GC6984@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 7 Oct 2020 14:59:59 -0700
Message-ID: <CAPcyv4j=q4n1PDW5vwOFpkeDEoDv2_xXBL+xoGsRwPn_ej=hnA@mail.gmail.com>
Subject: Re: [PATCH] ext4/xfs: add page refcount helper
To:     Jan Kara <jack@suse.cz>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 7, 2020 at 1:25 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 06-10-20 16:09:30, Ralph Campbell wrote:
> > There are several places where ZONE_DEVICE struct pages assume a reference
> > count == 1 means the page is idle and free. Instead of open coding this,
> > add a helper function to hide this detail.
> >
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Looks as sane direction but if we are going to abstract checks when
> ZONE_DEVICE page is idle, we should also update e.g.
> mm/swap.c:put_devmap_managed_page() or
> mm/gup.c:__unpin_devmap_managed_user_page() (there may be more places like
> this but I found at least these two...). Maybe Dan has more thoughts about
> this.

Yes, but I think that cleanup comes once the idle page count is
unified to be 0 across typical and ZONE_DEVICE pages. Then
free_devmap_managed_page() can be moved internal to __put_page(). For
this patch it's just hiding the "idle == 1" assumption from
dax-filesystems.
