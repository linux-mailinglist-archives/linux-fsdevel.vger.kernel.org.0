Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F5F45B242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 03:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhKXCzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 21:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhKXCzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 21:55:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9EAC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 18:52:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p18so630529plf.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 18:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOfci/mx3akOO+4HmSZ2UPdC5Rli9mLX/eg9lyyjZ30=;
        b=Y7XkrixbrNlS8hQi6+YjpK4PZmxcaZt8IqYEL0x+AbApMNhFV77CzxIm1fpzZJvqGy
         z6D/gHDQ4xlWEfbCz9zV/Nr2rYvjyAJ/qcfvABnWEzU5q3sPzeWrzFiGiQQVw5TF5P/Q
         vGI8iomC/tTJLNOXXKE+qcAeV4HDU/nIHSo9sub+NaaMXbz5ALE5SX90GBKyPNNwTUeM
         U8Wl8gNSrdkT3Uzd5sOv409e3dENQvzi+2J3G8FjskgqDuk0PglVJ0u6ajEy8rV/j0R2
         Kp+xFLo9F8v5ClK8M1g/uaLLpJP0HiqMIi5yPKOPokQDDyomwLUF2ZncL/aMKydNlkDc
         qMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOfci/mx3akOO+4HmSZ2UPdC5Rli9mLX/eg9lyyjZ30=;
        b=eVyDhkfSjXkZHHTZRFq+8FgMki30/jsHRF0GeCE0bc0YpMP5pxQdzeYbxGbrzC4Up9
         LDAWrd4dNLQkD7hu6D+d0GrQek375+p8INPBN+dY/5hz4dO81mrFXZGj6MFYiVjRGOKf
         XPLaC+FWRq2eG/c38wx5UvnFGDT68hY3/SZKLlU5DS5/fHlu1opDQuxU07WTGv9irKnJ
         yvVOx0V1valDRpJj56OMMQgcAB0EQegIj0cF0bcuyju8sq29S8oi65Vz+7d/GCJZuk1O
         jp+x8coQy3H83CdYFFOiZm3zETDJKCI/bxxoST6TP8GGeEhUnZpOWRDfdFWjHligf552
         +8wg==
X-Gm-Message-State: AOAM532KYT6/VU72iaXXsPax0P3RldWnM9WzbC7julqZapbbYauAFKxw
        ozal7DZZ+4iJgVdaNFNgdmIIJnaesyMQ1OOwbRDC1Q==
X-Google-Smtp-Source: ABdhPJwYJBk3MOCLfOjDzIFwcn3St8lk3aeiUUUrOONNeXpKHHsZfcNKcAaGYukH/G67vklAJOZt7FEQ2h9y1bfGO+A=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr10191254pjb.8.1637722343903;
 Tue, 23 Nov 2021 18:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-25-hch@lst.de>
In-Reply-To: <20211109083309.584081-25-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 18:52:13 -0800
Message-ID: <CAPcyv4iRUDaT4rrLYhGrJB-zt9B-bGGoVW3wYoUnePRxx58Fdw@mail.gmail.com>
Subject: Re: [PATCH 24/29] xfs: use xfs_direct_write_iomap_ops for DAX zeroing
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> While the buffered write iomap ops do work due to the fact that zeroing
> never allocates blocks, the DAX zeroing should use the direct ops just
> like actual DAX I/O.
>

I always wondered about this, change looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 8cef3b68cba78..704292c6ce0c7 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1324,7 +1324,7 @@ xfs_zero_range(
>
>         if (IS_DAX(inode))
>                 return dax_zero_range(inode, pos, len, did_zero,
> -                                     &xfs_buffered_write_iomap_ops);
> +                                     &xfs_direct_write_iomap_ops);
>         return iomap_zero_range(inode, pos, len, did_zero,
>                                 &xfs_buffered_write_iomap_ops);
>  }
> @@ -1339,7 +1339,7 @@ xfs_truncate_page(
>
>         if (IS_DAX(inode))
>                 return dax_truncate_page(inode, pos, did_zero,
> -                                       &xfs_buffered_write_iomap_ops);
> +                                       &xfs_direct_write_iomap_ops);
>         return iomap_truncate_page(inode, pos, did_zero,
>                                    &xfs_buffered_write_iomap_ops);
>  }
> --
> 2.30.2
>
