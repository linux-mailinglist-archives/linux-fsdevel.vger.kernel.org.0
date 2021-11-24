Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6609045B22C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 03:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhKXCua (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 21:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhKXCua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 21:50:30 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338CFC061714
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 18:47:21 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t4so771414pgn.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 18:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDkzPn+vIexNrKZKKgoJ7mQpee2ZSq2mCl3rdYSyZRs=;
        b=v+mOAcq/SMKI/6q1YGZhpUVRcKk3Bw1T+5aGwwKv9mK2S2/X3/d4jBb8CtZv2zYTwr
         Pg1AqI7Z4Z4TlelZDn+KthnTvqDSRv6A+lCI2+ceJjR1FEDifVcdUwxhPiddV3WPjYrv
         lC+zURcqUQmJYR3vyh6zvz4VGUf4KNwKq0in9nWSpYOBf6f6zXAokmgGs5Cq/v3LtIph
         O7RhU1t8NRctmET5Lo+hqoJpyIArJ0ylytKPnuKYBx+d5J1szUdYJ5z55Dp/Qo4PGCAg
         Moyefg0QnBnsCQDIz9YLw+w9C+cvtilKMUc0ArCtcauRumPts8w7o0gMvfkEEACUlRsr
         KeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDkzPn+vIexNrKZKKgoJ7mQpee2ZSq2mCl3rdYSyZRs=;
        b=RbEuhvQhU9+TIOYwWJXI3OYS1rE75Hi3h2YoX9z6QNQdvcZJK3ITAIVXJSUCUwuloO
         NctaUG8ZobRJoyxT9Q9EmonQLVt4CoAW7YXB6TI+I/jZCsgYW7CqA58F1IZHjLQg1iUo
         iH875rzWCgHb1+I0Kxt7fbg3oLNSaFlGUA5aYmpJ7NjI6tYUKvRhr/RwtdL9wIqN2W5e
         p/xzV28Faic/RZQl0uj5GQ1YbwOkqcFoLbucm48y7CYOqOzu0vkeu4pv83HcM1DMX/Uw
         FKtYFcH58EBfSQ+NDQMQdMzWJOC1xbZbzwGPdVifYlQcr2pyhBVKWCfJpv1GFS0jycPp
         ohbA==
X-Gm-Message-State: AOAM533CyR6MdAHbwDxdAIrswiL8WfORGGUi4UgzyJHHGEtDlCws6WRI
        T/YCm7YAEXgcqpsCrHf2YayXi8O6fRIPmAdWvOqdzA==
X-Google-Smtp-Source: ABdhPJwhulY7o10L5eF793HT2VpAfIjkz05UxjHV38L6J4vJZLIxSbRiUXQ9JXqnOQ3P5Me+Dt5jaZMn/7VokxocR94=
X-Received: by 2002:a63:8141:: with SMTP id t62mr5500508pgd.5.1637722040536;
 Tue, 23 Nov 2021 18:47:20 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-23-hch@lst.de>
In-Reply-To: <20211109083309.584081-23-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 18:47:10 -0800
Message-ID: <CAPcyv4gQO6F5-8Ux8ye5cU-W3ZQVDjj5614Xb8EsTvH9UhfAfg@mail.gmail.com>
Subject: Re: [PATCH 22/29] iomap: add a IOMAP_DAX flag
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
> Add a flag so that the file system can easily detect DAX operations.

Looks ok, but I would have preferred a quick note about the rationale
here before needing to read other patches to figure that out.

If you add that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c              | 7 ++++---
>  include/linux/iomap.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 5b52b878124ac..0bd6cdcbacfc4 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1180,7 +1180,7 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>                 .inode          = inode,
>                 .pos            = pos,
>                 .len            = len,
> -               .flags          = IOMAP_ZERO,
> +               .flags          = IOMAP_DAX | IOMAP_ZERO,
>         };
>         int ret;
>
> @@ -1308,6 +1308,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>                 .inode          = iocb->ki_filp->f_mapping->host,
>                 .pos            = iocb->ki_pos,
>                 .len            = iov_iter_count(iter),
> +               .flags          = IOMAP_DAX,
>         };
>         loff_t done = 0;
>         int ret;
> @@ -1461,7 +1462,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>                 .inode          = mapping->host,
>                 .pos            = (loff_t)vmf->pgoff << PAGE_SHIFT,
>                 .len            = PAGE_SIZE,
> -               .flags          = IOMAP_FAULT,
> +               .flags          = IOMAP_DAX | IOMAP_FAULT,
>         };
>         vm_fault_t ret = 0;
>         void *entry;
> @@ -1570,7 +1571,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>         struct iomap_iter iter = {
>                 .inode          = mapping->host,
>                 .len            = PMD_SIZE,
> -               .flags          = IOMAP_FAULT,
> +               .flags          = IOMAP_DAX | IOMAP_FAULT,
>         };
>         vm_fault_t ret = VM_FAULT_FALLBACK;
>         pgoff_t max_pgoff;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6d1b08d0ae930..146a7e3e3ea11 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -141,6 +141,7 @@ struct iomap_page_ops {
>  #define IOMAP_NOWAIT           (1 << 5) /* do not block */
>  #define IOMAP_OVERWRITE_ONLY   (1 << 6) /* only pure overwrites allowed */
>  #define IOMAP_UNSHARE          (1 << 7) /* unshare_file_range */
> +#define IOMAP_DAX              (1 << 8) /* DAX mapping */
>
>  struct iomap_ops {
>         /*
> --
> 2.30.2
>
