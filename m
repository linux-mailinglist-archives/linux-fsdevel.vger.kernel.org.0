Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD24A93ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 07:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbiBDGVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 01:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiBDGVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:21:30 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54AAC06173D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 22:21:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id p12-20020a17090a2d8c00b001b833dec394so5322232pjd.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Feb 2022 22:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pCg5LRiqmbI3TAMDbxbNyx17A118iw1ZgmwbQZNhZc=;
        b=3V3KExznjp8wESoZXltleisSjwaUOua+bzzCIMq/fH/eo3G/62yVKSbNMwWWHQ156X
         +ZhOVGRPeRzxJPDdiVJ8BmEWgh51BDK2dVYjq2Rh/3WelKHpJtScg+IkPbKfTun++/4Y
         aXCY78xBIVe4k15srEh1t8FyOZ396mIU707Zcru78W3FGmItRp11+pgzL3GxHlTghRU6
         YOdEqPV0uFkx0h5+BpLgQNPEjjSNoFxb4xijJHK5iL1sdLiUrWAESrkp3RumVt+1HDn+
         qLWQbOB/sSLN0GIfOd/65rVWK1cqr8+H76F54LT1YbOtW0ZS92GKJOhr1IB8Ic/qcfSh
         SnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pCg5LRiqmbI3TAMDbxbNyx17A118iw1ZgmwbQZNhZc=;
        b=DKo2U1c2lPUokxkhsUCsxRPTnfdYXrfrBdge7RYdNeJJDZLPO0AEJ+nlgOy+lYiz31
         /vR/AUBJqRymx4NANnJMQzGLsnm4355P8ZAQGZaSH0xybaRSLtJzUg8Qc2mhQaZBXuz7
         g4xmlYU/6mUteoxLRPR6Eu+Dk/1hUGoyMTXAGFWxmQpJZW761mbq+mZZ5l+HgM4xGkIv
         C7WcMWsgH5M2hYYVkvwZaQYM6lJS9osJ14di3JBnHCk55WWlCYEZlr6vUxuO6s3xqOHs
         VnkpTmzsMZXW+b/DgVVyWaol9OQrrBgpDWaomCbm06A9AgQfUOBk2McA2AjuI2WNaVp0
         tXRQ==
X-Gm-Message-State: AOAM533UHVF7TLc20berM+IzDJA2lvVRL9t7xU3aQKTr/u9RWEr4WW9T
        bWlffCBCS/UeOinhSHKjYzTb5n6Yt9NWpJbH8XKy/g==
X-Google-Smtp-Source: ABdhPJxJdrprINds/3WPI72ybQtRLDGdXlGnE/VTYi5U2aLnedO5jvJlRA9psGdrpnDvDKM0rxpfae7Zs/uG9uBsBds=
X-Received: by 2002:a17:902:bcca:: with SMTP id o10mr1673853pls.147.1643955689386;
 Thu, 03 Feb 2022 22:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20220128213150.1333552-1-jane.chu@oracle.com> <20220128213150.1333552-6-jane.chu@oracle.com>
In-Reply-To: <20220128213150.1333552-6-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Feb 2022 22:21:17 -0800
Message-ID: <CAPcyv4ip=JZXcQkDOtjcSsD=y7wRJEA0GdYSbx9+UrGCg8BNvQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] pmem: add pmem_recovery_write() dax op
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

On Fri, Jan 28, 2022 at 1:32 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> pmem_recovery_write() consists of clearing poison via DSM,
> clearing page HWPoison bit, re-state _PAGE_PRESENT bit,
> cacheflush, write, and finally clearing bad-block record.
>
> A competing pread thread is held off during recovery write
> by the presence of bad-block record. A competing recovery_write
> thread is serialized by a lock.
>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  drivers/nvdimm/pmem.c | 82 +++++++++++++++++++++++++++++++++++++++----
>  drivers/nvdimm/pmem.h |  1 +
>  2 files changed, 77 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 638e64681db9..f2d6b34d48de 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -69,6 +69,14 @@ static void hwpoison_clear(struct pmem_device *pmem,
>         }
>  }
>
> +static void pmem_clear_badblocks(struct pmem_device *pmem, sector_t sector,
> +                               long cleared_blks)
> +{
> +       badblocks_clear(&pmem->bb, sector, cleared_blks);
> +       if (pmem->bb_state)
> +               sysfs_notify_dirent(pmem->bb_state);
> +}
> +
>  static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
>                 phys_addr_t offset, unsigned int len)
>  {
> @@ -88,9 +96,7 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
>                 dev_dbg(dev, "%#llx clear %ld sector%s\n",
>                                 (unsigned long long) sector, cleared,
>                                 cleared > 1 ? "s" : "");
> -               badblocks_clear(&pmem->bb, sector, cleared);
> -               if (pmem->bb_state)
> -                       sysfs_notify_dirent(pmem->bb_state);
> +               pmem_clear_badblocks(pmem, sector, cleared);
>         }
>
>         arch_invalidate_pmem(pmem->virt_addr + offset, len);
> @@ -257,10 +263,15 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>  __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>                 long nr_pages, void **kaddr, pfn_t *pfn)
>  {
> +       bool bad_pmem;
> +       bool do_recovery = false;
>         resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
>
> -       if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
> -                                       PFN_PHYS(nr_pages))))
> +       bad_pmem = is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
> +                               PFN_PHYS(nr_pages));
> +       if (bad_pmem && kaddr)
> +               do_recovery = dax_recovery_started(pmem->dax_dev, kaddr);
> +       if (bad_pmem && !do_recovery)
>                 return -EIO;
>
>         if (kaddr)
> @@ -301,10 +312,68 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
>         return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
>  }
>
> +/*
> + * The recovery write thread started out as a normal pwrite thread and
> + * when the filesystem was told about potential media error in the
> + * range, filesystem turns the normal pwrite to a dax_recovery_write.
> + *
> + * The recovery write consists of clearing poison via DSM, clearing page
> + * HWPoison bit, reenable page-wide read-write permission, flush the
> + * caches and finally write.  A competing pread thread needs to be held
> + * off during the recovery process since data read back might not be valid.
> + * And that's achieved by placing the badblock records clearing after
> + * the completion of the recovery write.
> + *
> + * Any competing recovery write thread needs to be serialized, and this is
> + * done via pmem device level lock .recovery_lock.
> + */
>  static size_t pmem_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i)
>  {
> -       return 0;
> +       size_t rc, len, off;
> +       phys_addr_t pmem_off;
> +       struct pmem_device *pmem = dax_get_private(dax_dev);
> +       struct device *dev = pmem->bb.dev;
> +       sector_t sector;
> +       long cleared, cleared_blk;
> +
> +       mutex_lock(&pmem->recovery_lock);
> +
> +       /* If no poison found in the range, go ahead with write */
> +       off = (unsigned long)addr & ~PAGE_MASK;
> +       len = PFN_PHYS(PFN_UP(off + bytes));
> +       if (!is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512, len)) {
> +               rc = _copy_from_iter_flushcache(addr, bytes, i);
> +               goto write_done;
> +       }

is_bad_pmem() takes a seqlock so it should be safe to move the
recovery_lock below this point.

> +
> +       /* Not page-aligned range cannot be recovered */
> +       if (off || !(PAGE_ALIGNED(bytes))) {
> +               dev_warn(dev, "Found poison, but addr(%p) or bytes(%#lx) not page aligned\n",
> +                       addr, bytes);

fs/dax.c will prevent this from happening, right? It seems like an
upper layer bug if we get this far into the recovery process without
checking if a full page is being overwritten.

> +               rc = (size_t) -EIO;
> +               goto write_done;
> +       }
> +
> +       pmem_off = PFN_PHYS(pgoff) + pmem->data_offset;
> +       sector = (pmem_off - pmem->data_offset) / 512;
> +       cleared = nvdimm_clear_poison(dev, pmem->phys_addr + pmem_off, len);
> +       cleared_blk = cleared / 512;
> +       if (cleared_blk > 0) {
> +               hwpoison_clear(pmem, pmem->phys_addr + pmem_off, cleared);
> +       } else {
> +               dev_warn(dev, "pmem_recovery_write: cleared_blk: %ld\n",
> +                       cleared_blk);
> +               rc = (size_t) -EIO;
> +               goto write_done;
> +       }
> +       arch_invalidate_pmem(pmem->virt_addr + pmem_off, bytes);
> +       rc = _copy_from_iter_flushcache(addr, bytes, i);
> +       pmem_clear_badblocks(pmem, sector, cleared_blk);

This duplicates pmem_clear_poison() can more code be shared between
the 2 functions?


> +
> +write_done:
> +       mutex_unlock(&pmem->recovery_lock);
> +       return rc;
>  }
>
>  static const struct dax_operations pmem_dax_ops = {
> @@ -495,6 +564,7 @@ static int pmem_attach_disk(struct device *dev,
>                 goto out_cleanup_dax;
>         dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
>         set_dax_recovery(dax_dev);
> +       mutex_init(&pmem->recovery_lock);
>         pmem->dax_dev = dax_dev;
>
>         rc = device_add_disk(dev, disk, pmem_attribute_groups);
> diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
> index 59cfe13ea8a8..971bff7552d6 100644
> --- a/drivers/nvdimm/pmem.h
> +++ b/drivers/nvdimm/pmem.h
> @@ -24,6 +24,7 @@ struct pmem_device {
>         struct dax_device       *dax_dev;
>         struct gendisk          *disk;
>         struct dev_pagemap      pgmap;
> +       struct mutex            recovery_lock;
>  };
>
>  long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
> --
> 2.18.4
>
