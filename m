Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229E845AE97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 22:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbhKWVt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 16:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbhKWVtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:49:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86182C061714
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:46:46 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so3212174pju.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IocG8TBulukDu9SjRxn8/4US7KH9kbedvt0a5PmxQv4=;
        b=e9bx4Kdo7I8ZUavJsyxsvU7II4UPysuYF1XHDALMVPKJXAOc/1HKibhwKn6zYiyyH2
         RzYhTkpVmzKjgYSXCxowfOO1tIpA97XEkSgj5sxdBD2rNwfxMZluX7Z3sIGYciYU6ogd
         ljTGFeV41L1PwjS3M0oGZcQzOS7HD/9q+lneTWJUTUlsrF1iQun9GNGHJHKiBEjHoaH7
         VF+7yXa8YUT3VIvlW6HfBrq4oSJCQYp+sWbnZhjUtVARWol5WTyHD5zAz213Rk2aIiZR
         KdTB0N54eXCKSFqzGMeu3tfOHYo1rlmF+MafxxcMzskESR21ZtpuTZoOQuZzNnz3/Z04
         qmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IocG8TBulukDu9SjRxn8/4US7KH9kbedvt0a5PmxQv4=;
        b=as+ZS9x0HXMgk1WK2MZWGviogWlyzoAklCr36yC7Bpf9VhQYmHRyzEmgmgEi9VV3RS
         RoAZ2UPcNWNKozci96T/2LHlk6gp9ha9xClnMjn3k76aORYomin3mEnDF4FIeG5zlNsa
         qSUrtTXeaXu1VKzEKV/RTj6LpxGMDL1Xop77xmu9Mao9ne0evciYSpQcjS25BjXEu4kW
         kjEK835Q68Fuh1X1Qe/61wl+wgFmi421BEmeSaANKj9TJiJTV0N4eXt6txotaIY0XvVU
         hVWfHrFQYADKXAkZUz+Q2oIS850wWP/Lr4awYPPpL5H4Qfx/VSlvNY14WammCDfaijVM
         ozaw==
X-Gm-Message-State: AOAM532hfGd4RMVIrVrRN3RYrf99QfVAeG3HXILZipAKQ/PhxdUpUyhN
        Lwlf6Y/IuQUMtmE2kivoPPrOyiVFF+pWMculOn35Zw==
X-Google-Smtp-Source: ABdhPJwtZaW+gMisb+Y0jgoHIg9GiWXk7YMizh+6qlrWxc1s5dOr//0YU5uLfuPStXFLmi95oQ+oVAG4VVG3WhAjY3g=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr7419326pjb.8.1637704005856;
 Tue, 23 Nov 2021 13:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-19-hch@lst.de>
In-Reply-To: <20211109083309.584081-19-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:46:35 -0800
Message-ID: <CAPcyv4hDG9-BQHjuJnQUQLJhq=xmrNi+w-uiu6TnV4Rcf0VDfQ@mail.gmail.com>
Subject: Re: [PATCH 18/29] fsdax: decouple zeroing from the iomap buffered I/O code
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Unshare the DAX and iomap buffered I/O page zeroing code.  This code
> previously did a IS_DAX check deep inside the iomap code, which in
> fact was the only DAX check in the code.  Instead move these checks
> into the callers.  Most callers already have DAX special casing anyway
> and XFS will need it for reflink support as well.

Looks ok, a tangential question below about iomap_truncate_page(), but
you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c               | 77 ++++++++++++++++++++++++++++++++++--------
>  fs/ext2/inode.c        |  6 ++--
>  fs/ext4/inode.c        |  4 +--
>  fs/iomap/buffered-io.c | 35 +++++++------------
>  fs/xfs/xfs_iomap.c     |  6 ++++
>  include/linux/dax.h    |  6 +++-
>  6 files changed, 91 insertions(+), 43 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index dc9ebeff850ab..5b52b878124ac 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1135,24 +1135,73 @@ static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
>         return rc;
>  }
>
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> +static loff_t dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
> -       pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> -       long rc, id;
> -       unsigned offset = offset_in_page(pos);
> -       unsigned size = min_t(u64, PAGE_SIZE - offset, length);
> +       const struct iomap *iomap = &iter->iomap;
> +       const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +       loff_t pos = iter->pos;
> +       loff_t length = iomap_length(iter);
> +       loff_t written = 0;
> +
> +       /* already zeroed?  we're done. */
> +       if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> +               return length;
> +
> +       do {
> +               unsigned offset = offset_in_page(pos);
> +               unsigned size = min_t(u64, PAGE_SIZE - offset, length);
> +               pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> +               long rc;
> +               int id;
>
> -       id = dax_read_lock();
> -       if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
> -               rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> -       else
> -               rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
> -       dax_read_unlock(id);
> +               id = dax_read_lock();
> +               if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
> +                       rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> +               else
> +                       rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
> +               dax_read_unlock(id);
>
> -       if (rc < 0)
> -               return rc;
> -       return size;
> +               if (rc < 0)
> +                       return rc;
> +               pos += size;
> +               length -= size;
> +               written += size;
> +               if (did_zero)
> +                       *did_zero = true;
> +       } while (length > 0);
> +
> +       return written;
> +}
> +
> +int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> +               const struct iomap_ops *ops)
> +{
> +       struct iomap_iter iter = {
> +               .inode          = inode,
> +               .pos            = pos,
> +               .len            = len,
> +               .flags          = IOMAP_ZERO,
> +       };
> +       int ret;
> +
> +       while ((ret = iomap_iter(&iter, ops)) > 0)
> +               iter.processed = dax_zero_iter(&iter, did_zero);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dax_zero_range);
> +
> +int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> +               const struct iomap_ops *ops)
> +{
> +       unsigned int blocksize = i_blocksize(inode);
> +       unsigned int off = pos & (blocksize - 1);
> +
> +       /* Block boundary? Nothing to do */
> +       if (!off)
> +               return 0;

It took me a moment to figure out why this was correct. I see it was
also copied from iomap_truncate_page(). It makes sense for DAX where
blocksize >= PAGE_SIZE so it's always the case that the amount of
capacity to zero relative to a page is from @pos to the end of the
block. Is there something else that protects the blocksize < PAGE_SIZE
case outside of DAX?

Nothing to change for this patch, just a question I had while reviewing.

> +       return dax_zero_range(inode, pos, blocksize - off, did_zero, ops);
>  }
> +EXPORT_SYMBOL_GPL(dax_truncate_page);
>
>  static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>                 struct iov_iter *iter)
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 333fa62661d56..ae9993018a015 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1297,9 +1297,9 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
>         inode_dio_wait(inode);
>
>         if (IS_DAX(inode)) {
> -               error = iomap_zero_range(inode, newsize,
> -                                        PAGE_ALIGN(newsize) - newsize, NULL,
> -                                        &ext2_iomap_ops);
> +               error = dax_zero_range(inode, newsize,
> +                                      PAGE_ALIGN(newsize) - newsize, NULL,
> +                                      &ext2_iomap_ops);
>         } else if (test_opt(inode->i_sb, NOBH))
>                 error = nobh_truncate_page(inode->i_mapping,
>                                 newsize, ext2_get_block);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0f06305167d5a..8c443b753b815 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3783,8 +3783,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
>                 length = max;
>
>         if (IS_DAX(inode)) {
> -               return iomap_zero_range(inode, from, length, NULL,
> -                                       &ext4_iomap_ops);
> +               return dax_zero_range(inode, from, length, NULL,
> +                                     &ext4_iomap_ops);
>         }
>         return __ext4_block_zero_page_range(handle, mapping, from, length);
>  }
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 1753c26c8e76e..b1511255b4df8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -870,26 +870,8 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
>
> -static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
> -{
> -       struct page *page;
> -       int status;
> -       unsigned offset = offset_in_page(pos);
> -       unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
> -
> -       status = iomap_write_begin(iter, pos, bytes, &page);
> -       if (status)
> -               return status;
> -
> -       zero_user(page, offset, bytes);
> -       mark_page_accessed(page);
> -
> -       return iomap_write_end(iter, pos, bytes, bytes, page);
> -}
> -
>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
> -       struct iomap *iomap = &iter->iomap;
>         const struct iomap *srcmap = iomap_iter_srcmap(iter);
>         loff_t pos = iter->pos;
>         loff_t length = iomap_length(iter);
> @@ -900,12 +882,19 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>                 return length;
>
>         do {
> -               s64 bytes;
> +               unsigned offset = offset_in_page(pos);
> +               size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
> +               struct page *page;
> +               int status;
>
> -               if (IS_DAX(iter->inode))
> -                       bytes = dax_iomap_zero(pos, length, iomap);
> -               else
> -                       bytes = __iomap_zero_iter(iter, pos, length);
> +               status = iomap_write_begin(iter, pos, bytes, &page);
> +               if (status)
> +                       return status;
> +
> +               zero_user(page, offset, bytes);
> +               mark_page_accessed(page);
> +
> +               bytes = iomap_write_end(iter, pos, bytes, bytes, page);
>                 if (bytes < 0)
>                         return bytes;
>
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d6d71ae9f2ae4..604000b6243ec 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1321,6 +1321,9 @@ xfs_zero_range(
>  {
>         struct inode            *inode = VFS_I(ip);
>
> +       if (IS_DAX(inode))
> +               return dax_zero_range(inode, pos, len, did_zero,
> +                                     &xfs_buffered_write_iomap_ops);
>         return iomap_zero_range(inode, pos, len, did_zero,
>                                 &xfs_buffered_write_iomap_ops);
>  }
> @@ -1333,6 +1336,9 @@ xfs_truncate_page(
>  {
>         struct inode            *inode = VFS_I(ip);
>
> +       if (IS_DAX(inode))
> +               return dax_truncate_page(inode, pos, did_zero,
> +                                       &xfs_buffered_write_iomap_ops);
>         return iomap_truncate_page(inode, pos, did_zero,
>                                    &xfs_buffered_write_iomap_ops);
>  }
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 324363b798ecd..a5cc2f1aa840e 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -14,6 +14,7 @@ typedef unsigned long dax_entry_t;
>  struct dax_device;
>  struct gendisk;
>  struct iomap_ops;
> +struct iomap_iter;
>  struct iomap;
>
>  struct dax_operations {
> @@ -124,6 +125,10 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
>  struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
>  dax_entry_t dax_lock_page(struct page *page);
>  void dax_unlock_page(struct page *page, dax_entry_t cookie);
> +int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> +               const struct iomap_ops *ops);
> +int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> +               const struct iomap_ops *ops);
>  #else
>  static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
>  {
> @@ -204,7 +209,6 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>                                       pgoff_t index);
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
>  static inline bool dax_mapping(struct address_space *mapping)
>  {
>         return mapping->host && IS_DAX(mapping->host);
> --
> 2.30.2
>
