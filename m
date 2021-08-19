Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8073F2328
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 00:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhHSWga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 18:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHSWg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:36:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B81C061575
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 15:35:51 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y11so6864798pfl.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vudk/EOySfEiiY9A24sWft0bhUL180j9m8QPEF4uz6c=;
        b=0Xxr8jIM2HMzf0WPifeV6tQR8uOpDfc/VM285bvMQ+l4YWpX46Oe5VWSRciM6KIkUt
         MhPP7SqNXVxnWZHOIYGs/ljAuxpd+TgHW6sVMTSwdLy+BZ3yLy1VqN9fany6FId5XiFq
         ICdJ1p+tbdcqhy8TkeQTk6IBnM2aUjMLtuiwVq22IEPrxt1zC/iodS2ktV9y3jN2ajE+
         qqAf3FcTFi7eTrwhvXFUHJMrBNS7A0Ycu6HeWPO+JsW8QLuLRn502iEbLKN91zElVFkD
         1Fww0C8S3k4nks/dycAufg+tMflw7FoUE/x4FO4gC0gy5OMflbsPtLaD7yc+sihCRY7I
         5zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vudk/EOySfEiiY9A24sWft0bhUL180j9m8QPEF4uz6c=;
        b=oushJevvEoj6B0sbCHtiyYAHkXdRd/OErex+pEuBT3zIz5S1nm18F8kvFKsOjzvoEu
         2HO08WrWPydTGs3qg0Adx4O3oEUJOGaEkPgYWiyDPixy6wMEOOAWBCXYYCkulX5G4o8m
         tk3eH2ElXnZhjBssPPNGMrliEdPSfve7K5LjLv39njYF6lBitHkaxkoyhVsUkwuv9chX
         cHF6hlHd26WD/gCIfXOkGHI+mQtefnFLSSCDVi5cuaziv8Ev76D2Mi79ypaqGCFk9YFJ
         rNQRftEbHs7a24bHIfIJqbTCQKv+uCWNjIuoUR8z6rlJwK0exIZu+C2gGKZu3SURcimy
         a1eQ==
X-Gm-Message-State: AOAM532ANOdRk729/ySUs6tCQXHfRF3Ho+NErWBkznx6PU1Ev+Euu5Ls
        HfqC9b/QOaVOTrJImfRXvufKKDPKxOl3DrFc9afhbA==
X-Google-Smtp-Source: ABdhPJyc0dTMzzmlKtwiaxfOJsarrU57Dp6/OtwlCDCZ7UQ+mcF/IKGoEsR68g+yAdujwwFjDuViQ1HBEFqXHO/ngfU=
X-Received: by 2002:a65:6642:: with SMTP id z2mr3987693pgv.240.1629412551161;
 Thu, 19 Aug 2021 15:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com> <20210816060359.1442450-3-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210816060359.1442450-3-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 19 Aug 2021 15:35:40 -0700
Message-ID: <CAPcyv4h0dukvcxN4Bc5a-jHk2FQ-j7ay9P1AB0wq9pNNSBU8-A@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] fsdax: Introduce dax_iomap_cow_copy()
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
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 15, 2021 at 11:04 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> In the case where the iomap is a write operation and iomap is not equal
> to srcmap after iomap_begin, we consider it is a CoW operation.
>
> The destance extent which iomap indicated is new allocated extent.

s/destance/destination/

That sentence is still hard to grok though, did it mean to say:

"In this case, the destination (iomap->addr) points to a newly
allocated extent."

> So, it is needed to copy the data from srcmap to new allocated extent.
> In theory, it is better to copy the head and tail ranges which is
> outside of the non-aligned area instead of copying the whole aligned
> range. But in dax page fault, it will always be an aligned range.  So,
> we have to copy the whole range in this case.

s/we have to copy/copy/

>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/dax.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 84 insertions(+), 5 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 9fb6218f42be..697a7b7bb96f 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1050,6 +1050,61 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
>         return rc;
>  }
>
> +/**
> + * dax_iomap_cow_copy(): Copy the data from source to destination before write.

s/():/() -/

...to be kernel-doc compliant

> + * @pos:       address to do copy from.
> + * @length:    size of copy operation.
> + * @align_size:        aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
> + * @srcmap:    iomap srcmap
> + * @daddr:     destination address to copy to.
> + *
> + * This can be called from two places. Either during DAX write fault, to copy
> + * the length size data to daddr. Or, while doing normal DAX write operation,
> + * dax_iomap_actor() might call this to do the copy of either start or end
> + * unaligned address. In this case the rest of the copy of aligned ranges is

Which "this", the latter, or the former? Looks like the latter.

"In the latter case the rest of the copy..."

> + * taken care by dax_iomap_actor() itself.
> + * Also, note DAX fault will always result in aligned pos and pos + length.

Perhaps drop this sentence and just say:

"Either during DAX write fault (page aligned), to copy..."

...in that earlier sentence so this comment flows better.

> + */
> +static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
> +               const struct iomap *srcmap, void *daddr)
> +{
> +       loff_t head_off = pos & (align_size - 1);
> +       size_t size = ALIGN(head_off + length, align_size);
> +       loff_t end = pos + length;
> +       loff_t pg_end = round_up(end, align_size);
> +       bool copy_all = head_off == 0 && end == pg_end;
> +       void *saddr = 0;
> +       int ret = 0;
> +
> +       ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
> +       if (ret)
> +               return ret;
> +
> +       if (copy_all) {
> +               ret = copy_mc_to_kernel(daddr, saddr, length);
> +               return ret ? -EIO : 0;
> +       }
> +
> +       /* Copy the head part of the range.  Note: we pass offset as length. */

I've re-read this a few times and this comment is not helping, why is
the offset used as the copy length?

> +       if (head_off) {
> +               ret = copy_mc_to_kernel(daddr, saddr, head_off);
> +               if (ret)
> +                       return -EIO;
> +       }
> +
> +       /* Copy the tail part of the range */
> +       if (end < pg_end) {
> +               loff_t tail_off = head_off + length;
> +               loff_t tail_len = pg_end - end;
> +
> +               ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
> +                                       tail_len);
> +               if (ret)
> +                       return -EIO;
> +       }
> +       return 0;
> +}
> +
>  /*
>   * The user has performed a load from a hole in the file.  Allocating a new
>   * page in the file would cause excessive storage usage for workloads with
> @@ -1175,16 +1230,18 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>                 struct iov_iter *iter)
>  {
>         const struct iomap *iomap = &iomi->iomap;
> +       const struct iomap *srcmap = &iomi->srcmap;
>         loff_t length = iomap_length(iomi);
>         loff_t pos = iomi->pos;
>         struct block_device *bdev = iomap->bdev;
>         struct dax_device *dax_dev = iomap->dax_dev;
>         loff_t end = pos + length, done = 0;
> +       bool write = iov_iter_rw(iter) == WRITE;
>         ssize_t ret = 0;
>         size_t xfer;
>         int id;
>
> -       if (iov_iter_rw(iter) == READ) {
> +       if (!write) {
>                 end = min(end, i_size_read(iomi->inode));
>                 if (pos >= end)
>                         return 0;
> @@ -1193,7 +1250,12 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>                         return iov_iter_zero(min(length, end - pos), iter);
>         }
>
> -       if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
> +       /*
> +        * In DAX mode, we allow either pure overwrites of written extents, or

s/we allow/enforce/

> +        * writes to unwritten extents as part of a copy-on-write operation.
> +        */
> +       if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
> +                       !(iomap->flags & IOMAP_F_SHARED)))
>                 return -EIO;
>
>         /*
> @@ -1232,6 +1294,14 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>                         break;
>                 }
>
> +               if (write &&
> +                   srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> +                       ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
> +                                                kaddr);
> +                       if (ret)
> +                               break;
> +               }
> +
>                 map_len = PFN_PHYS(map_len);
>                 kaddr += offset;
>                 map_len -= offset;
> @@ -1243,7 +1313,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>                  * validated via access_ok() in either vfs_read() or
>                  * vfs_write(), depending on which operation we are doing.
>                  */
> -               if (iov_iter_rw(iter) == WRITE)
> +               if (write)
>                         xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
>                                         map_len, iter);
>                 else
> @@ -1385,6 +1455,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>  {
>         struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>         const struct iomap *iomap = &iter->iomap;
> +       const struct iomap *srcmap = &iter->srcmap;
>         size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
>         loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
>         bool write = vmf->flags & FAULT_FLAG_WRITE;
> @@ -1392,6 +1463,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>         unsigned long entry_flags = pmd ? DAX_PMD : 0;
>         int err = 0;
>         pfn_t pfn;
> +       void *kaddr;
>
>         if (!pmd && vmf->cow_page)
>                 return dax_fault_cow_page(vmf, iter);
> @@ -1404,18 +1476,25 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>                 return dax_pmd_load_hole(xas, vmf, iomap, entry);
>         }
>
> -       if (iomap->type != IOMAP_MAPPED) {
> +       if (iomap->type != IOMAP_MAPPED && !(iomap->flags & IOMAP_F_SHARED)) {
>                 WARN_ON_ONCE(1);
>                 return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
>         }
>
> -       err = dax_iomap_direct_access(&iter->iomap, pos, size, NULL, &pfn);
> +       err = dax_iomap_direct_access(iomap, pos, size, &kaddr, &pfn);
>         if (err)
>                 return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
>
>         *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
>                                   write && !sync);
>
> +       if (write &&
> +           srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> +               err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
> +               if (err)
> +                       return dax_fault_return(err);
> +       }
> +
>         if (sync)
>                 return dax_fault_synchronous_pfnp(pfnp, pfn);
>
> --
> 2.32.0
>
>
>
