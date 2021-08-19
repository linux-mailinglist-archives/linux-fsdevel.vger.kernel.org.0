Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733893F2366
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhHSWyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 18:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhHSWyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:54:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58831C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 15:54:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k24so7317843pgh.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lv2BeH4bgVl/il3tYjXjqwuIZSwlS9CtCv+JW+Pfbnk=;
        b=dEJPorhN3VxbZejMS9q6PqBKwfMxKo1HPdf3+5BUH3dfXPgs88YSbj05k1hkBef+nM
         7vvU9XbId6WFv2lSIWSM6XXy2UPxLdeQ01Wfso2qKlbUco0zvIots/ul6DKzQ3DZcYNi
         P23cHa+p9+b2jIJWKtu1dQDl7lc5qIeAeuXdBKWusDgdFF5Zj6LRxzv+LIlIsEDHbKIC
         bA+OW2FTcspqya2PhtHxAy1glalU05anLkdQRHMAOe/TGgzUsBpfY3vrr6LgE6ZRnpxT
         PRy9SHdri/5ppUNRZwQkgaG+JzE/XBJi92LOIl7cj7phiuPVPAc4PUoOZ9875GEsDMjs
         SlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lv2BeH4bgVl/il3tYjXjqwuIZSwlS9CtCv+JW+Pfbnk=;
        b=oWxfk8keV+0xW+JWbePF3grz08cjEcgg1A/U0+kNFT18E/1zRa3rUZFzIKE48DGVPJ
         dGjOxAw+osd3dkjZ0jCQraX2NOIgjIr2rjOnt3jLynBt6hNsR4fFJuMb5ZPUAdpQeMIS
         LVVoHf8LWPV2j7whLrOD4pJy7+bHz3MBL3VHpZmrCYYhtHyd9+ZL65xcjKkvHoOEYTyR
         Pr0FAsr4dDsDO6+zLTx69Pfzg5OF8XpesXxsdHpUR2XsncEGO+wcGma+wsPQGNlTvlVZ
         1SRF7k+CGK26R4VlKLclXD9BFPCC/7BPedamyOXIvp/bmDCIT+rGF3+UYB2xmgrMK7MU
         YXAQ==
X-Gm-Message-State: AOAM5316eGlOn4SdARsXiIu5/u68+LcBpQ3WJkJ9Jd7iq263W69gUHce
        1A18pNxxiUZNlcIBX4e04ngljdDpbI9n6nZ/LqNuDA==
X-Google-Smtp-Source: ABdhPJy6c4gZ53hpbV6ORkyR2hmtHChkZnjGtdS6jdctPV28zWH0Y9aOAbm0cOMMyjXm7vkX87wjxDLfz1NQUUNKdrQ=
X-Received: by 2002:a05:6a00:16c6:b029:32d:e190:9dd0 with SMTP id
 l6-20020a056a0016c6b029032de1909dd0mr16584327pfc.70.1629413652651; Thu, 19
 Aug 2021 15:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com> <20210816060359.1442450-4-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210816060359.1442450-4-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 19 Aug 2021 15:54:01 -0700
Message-ID: <CAPcyv4iOSxoy-qGfAd3i4uzwfDX0t1xTmyM0pNd+-euVMDUwrQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/8] fsdax: Replace mmap entry in case of CoW
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 15, 2021 at 11:05 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> We replace the existing entry to the newly allocated one in case of CoW.
> Also, we mark the entry as PAGECACHE_TAG_TOWRITE so writeback marks this
> entry as writeprotected.  This helps us snapshots so new write
> pagefaults after snapshots trigger a CoW.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/dax.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 697a7b7bb96f..e49ba68cc7e4 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -734,6 +734,10 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>         return 0;
>  }
>
> +/* DAX Insert Flag: The state of the entry we insert */
> +#define DAX_IF_DIRTY           (1 << 0)
> +#define DAX_IF_COW             (1 << 1)
> +
>  /*
>   * By this point grab_mapping_entry() has ensured that we have a locked entry
>   * of the appropriate size so we don't have to worry about downgrading PMDs to
> @@ -741,16 +745,19 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>   * already in the tree, we will skip the insertion and just dirty the PMD as
>   * appropriate.
>   */
> -static void *dax_insert_entry(struct xa_state *xas,
> -               struct address_space *mapping, struct vm_fault *vmf,
> -               void *entry, pfn_t pfn, unsigned long flags, bool dirty)
> +static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
> +               void *entry, pfn_t pfn, unsigned long flags,
> +               unsigned int insert_flags)

I'm late, so feel free to ignore this style feedback, but what about
changing the signature to:

static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
                              const struct iomap_iter *iter, void
*entry, pfn_t pfn,
                              unsigned long flags)


>  {
> +       struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>         void *new_entry = dax_make_entry(pfn, flags);
> +       bool dirty = insert_flags & DAX_IF_DIRTY;
> +       bool cow = insert_flags & DAX_IF_COW;

...and then calculate these flags from the source data. I'm just
reacting to "yet more flags".

So, take it or leave it,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
