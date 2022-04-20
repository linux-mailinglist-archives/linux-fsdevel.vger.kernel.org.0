Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF5508125
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 08:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbiDTG3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 02:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241372AbiDTG32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:29:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C56E33E9F
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 23:26:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v12so935292plv.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 23:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/B+07Pdy/i99xOuJm1AhASljd/y0M0ZEBVCIGcpJEk=;
        b=sopR1yn2nxsBc7ADfwFn/SWVrtJf9vSVuS5tSKUXtu79LcNiX52TDT5EJzOv8j990R
         X7on1VJ0Knbc/a/cZVJgJVVR1JkUoSMhNJF5tfTTfYnUfP9QcvppIdge2k2kdCaiCvdc
         mVPYdcWIKwQ5rqis8wCgcW0oBE0f2k8ZZXjP1fbM76+1LWFx5w7tUzyPB8K2CN37GhWa
         oPxDdQPnLA/ErxICkcFFOQ1K6VzYiWOXj60p3lURuXYdwhe2GR3SnGevDxFhRdcTHBc/
         I4harbVtT5a80PKLqmQ+ElWi/y3stKqfiP9jbb8Fp0glT1x3EqS4tDbnDcriWWXKWwO5
         gWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/B+07Pdy/i99xOuJm1AhASljd/y0M0ZEBVCIGcpJEk=;
        b=T9j154ghrunfEhF4gmq8x8HN/OGAHjdlYKbesVMbgrEsfGcEjCAmiwMocDo/pDhFkO
         /Msgoqo+5aTvxdc/EcEf9XyN3PjJTmtz2lVnyoi/dwFNdd5Dw2um6gOoB+v+vFey7kP+
         KKRj02XZNbD9csmSe9sqQ/jG/+TS39dePHL140+pkUd8QO2YVch6lBjLOMm3VAnixae7
         s0YtMemSUVmO/YKfG4PU62NT3yJkjSS8Kk7TseKtTgi+kRBsXPVrflmeydvemaRda+Nw
         Bb831x6pFVZbYgxJlVfJzSA17TwWnqNDgFUrmzVWXSnoPoPvBiNPtuE9jvQJ/UVy0I1Q
         Iqxw==
X-Gm-Message-State: AOAM531GhnGZsVroDENJ7dWFFXBQmywjAma8FAYJ+HBfJBa1b6VBGpkL
        AD8BVyZnB6wOhJP9PZZpi4z60ti/C3kK+aCuGeijmA==
X-Google-Smtp-Source: ABdhPJxixqBz/WgugT7SEaDoh37n3VChx++gr3ojEoEsdleLCNUq06QhC6jeLOdiLDQ4Vb1/+A5HVkXtu9FHqLKx4aA=
X-Received: by 2002:a17:90b:4c84:b0:1d2:cadc:4e4d with SMTP id
 my4-20020a17090b4c8400b001d2cadc4e4dmr2676295pjb.8.1650436002497; Tue, 19 Apr
 2022 23:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220420020435.90326-1-jane.chu@oracle.com> <20220420020435.90326-8-jane.chu@oracle.com>
In-Reply-To: <20220420020435.90326-8-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Apr 2022 23:26:31 -0700
Message-ID: <CAPcyv4gs2rEs71c6Lmtk1La2g3POhzBrppLvM0pkGxx+QZ3SbA@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] pmem: implement pmem_recovery_write()
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 7:06 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> The recovery write thread started out as a normal pwrite thread and
> when the filesystem was told about potential media error in the
> range, filesystem turns the normal pwrite to a dax_recovery_write.
>
> The recovery write consists of clearing media poison, clearing page
> HWPoison bit, reenable page-wide read-write permission, flush the
> caches and finally write.  A competing pread thread will be held
> off during the recovery process since data read back might not be
> valid, and this is achieved by clearing the badblock records after
> the recovery write is complete. Competing recovery write threads
> are serialized by pmem device level .recovery_lock.
>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  drivers/nvdimm/pmem.c | 56 ++++++++++++++++++++++++++++++++++++++++++-
>  drivers/nvdimm/pmem.h |  1 +
>  2 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index c3772304d417..134f8909eb65 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -332,10 +332,63 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
>         return __pmem_direct_access(pmem, pgoff, nr_pages, mode, kaddr, pfn);
>  }
>
> +/*
> + * The recovery write thread started out as a normal pwrite thread and
> + * when the filesystem was told about potential media error in the
> + * range, filesystem turns the normal pwrite to a dax_recovery_write.
> + *
> + * The recovery write consists of clearing media poison, clearing page
> + * HWPoison bit, reenable page-wide read-write permission, flush the
> + * caches and finally write.  A competing pread thread will be held
> + * off during the recovery process since data read back might not be
> + * valid, and this is achieved by clearing the badblock records after
> + * the recovery write is complete. Competing recovery write threads
> + * are serialized by pmem device level .recovery_lock.
> + */
>  static size_t pmem_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i)
>  {
> -       return 0;
> +       struct pmem_device *pmem = dax_get_private(dax_dev);
> +       size_t olen, len, off;
> +       phys_addr_t pmem_off;
> +       struct device *dev = pmem->bb.dev;
> +       long cleared;
> +
> +       off = offset_in_page(addr);
> +       len = PFN_PHYS(PFN_UP(off + bytes));
> +       if (!is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) >> SECTOR_SHIFT, len))
> +               return _copy_from_iter_flushcache(addr, bytes, i);
> +
> +       /*
> +        * Not page-aligned range cannot be recovered. This should not
> +        * happen unless something else went wrong.
> +        */
> +       if (off || !PAGE_ALIGNED(bytes)) {
> +               dev_warn(dev, "Found poison, but addr(%p) or bytes(%#lx) not page aligned\n",
> +                       addr, bytes);

If this warn stays:

s/dev_warn/dev_warn_ratelimited/

The kernel prints hashed addresses for %p, so I'm not sure printing
@addr is useful or @bytes because there is nothing actionable that can
be done with that information in the log. @pgoff is probably the only
variable worth printing (after converting to bytes or sectors) as that
might be able to be reverse mapped back to the impacted data.

> +               return 0;
> +       }
> +
> +       mutex_lock(&pmem->recovery_lock);
> +       pmem_off = PFN_PHYS(pgoff) + pmem->data_offset;
> +       cleared = __pmem_clear_poison(pmem, pmem_off, len);
> +       if (cleared > 0 && cleared < len) {
> +               dev_warn(dev, "poison cleared only %ld out of %lu bytes\n",
> +                       cleared, len);

This looks like dev_dbg() to me, or at minimum the same
dev_warn_ratelimited() print as the one above to just indicate a write
to the device at the given offset failed.

> +               mutex_unlock(&pmem->recovery_lock);
> +               return 0;
> +       }
> +       if (cleared < 0) {
> +               dev_warn(dev, "poison clear failed: %ld\n", cleared);

Same feedback here, these should probably all map to the identical
error exit ratelimited print.

> +               mutex_unlock(&pmem->recovery_lock);

It occurs to me that all callers of this are arriving through the
fsdax iomap ops and all of these callers take an exclusive lock to
prevent simultaneous access to the inode. If recovery_write() is only
used through that path then this lock is redundant. Simultaneous reads
are protected by the fact that the badblocks are cleared last. I think
this can wait to add the lock when / if a non-fsdax access path
arrives for dax_recovery_write(), and even then it should probably
enforce the single writer exclusion guarantee of the fsdax path.

> +               return 0;
> +       }
> +
> +       olen = _copy_from_iter_flushcache(addr, bytes, i);
> +       pmem_clear_bb(pmem, to_sect(pmem, pmem_off), cleared >> SECTOR_SHIFT);
> +
> +       mutex_unlock(&pmem->recovery_lock);
> +       return olen;
>  }
>
>  static const struct dax_operations pmem_dax_ops = {
> @@ -525,6 +578,7 @@ static int pmem_attach_disk(struct device *dev,
>         if (rc)
>                 goto out_cleanup_dax;
>         dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
> +       mutex_init(&pmem->recovery_lock);
>         pmem->dax_dev = dax_dev;
>
>         rc = device_add_disk(dev, disk, pmem_attribute_groups);
> diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
> index 392b0b38acb9..91e40f5e3c0e 100644
> --- a/drivers/nvdimm/pmem.h
> +++ b/drivers/nvdimm/pmem.h
> @@ -27,6 +27,7 @@ struct pmem_device {
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
