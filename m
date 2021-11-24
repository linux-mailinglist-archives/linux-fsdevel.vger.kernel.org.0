Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F3045B296
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 04:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbhKXDZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 22:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbhKXDZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:25:08 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69940C06173E
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 19:21:59 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n8so706359plf.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 19:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EL31Cy62VKrYRYptuLHbJfb/IYu8BUfyrtV7sdQIaLc=;
        b=tTzNJ2xX5PU2ZMtodj9dANcIKZZwQKRHX4lB/NL5LZNN4Zr1VE+P5ovmtCw8EES+Wi
         NQ80+oi4ntIVYsB1h9MkMbp03nngY0IViVo2xEBceq5t5+uhw3UVcNgcwXpITZJ3CCyC
         SpZn8KQKXy9b4rqCakALc7KqdS6D7C5QHJit1vCpGIDnMWhrdqyaarz+LrZmWI3mEXOm
         ygI9Ibrs/NzMWc7N8tOq7qOYtk6nUBQRWJgA2OarsoGDF20YgKNLJkU8STlFqZsVqk64
         ncL/ACZOLTjitKw6c3ssSTeyj3d8bbWUIk03dhK9dD82q1d41Wmi7s8ZhTarVWeBvFfe
         SvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EL31Cy62VKrYRYptuLHbJfb/IYu8BUfyrtV7sdQIaLc=;
        b=cJFmgUIFwimLLDHVqzabrQFgTProVTpwC4x+XxzICwpxQlYf4LUtKQOzb9VT2WGmx1
         /50nyzf/CPE4gD9sr7WBmde0OLiJN3lNvW5lQkSYXELyyF00J63aKTrafCreFqiHg58s
         aA7Mk2oZbrYkZtw19ZzYBVZtv4fvAfxgGrVF+WXdoclf22buhlfqIJnCfJID3oipBgeR
         1jy/wFrL8kLdawRtSa0gxzxqogk6bz5jYlcOBtANztFGxbnRMNshEHLefptu6iQet8mY
         5H8St1cl9Xh+ezqUMEfuNWZz6bgVf+1KJ1/R0fUcmsfOkM0f8VRj0rSeS4U440nODeG0
         4XTg==
X-Gm-Message-State: AOAM531DMUHgvOFYZAq0poUXNtHfS6H1/AhI45p5lPcpbGaEhMZ4fdXR
        xOaXrKJbRV3xXHy/3/20XMJ0EfKqc4jd2v8bBpUB3g==
X-Google-Smtp-Source: ABdhPJy2aFen0PqWttd8BjEdIQsqphuBXqzJVHlhc+QCr5UJA27t1P+Fp9qpkknnP9tnEfW8e0xOGoy/eRGZQ5QtCf0=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr3873250pjb.220.1637724118856;
 Tue, 23 Nov 2021 19:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-27-hch@lst.de>
In-Reply-To: <20211109083309.584081-27-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 19:21:47 -0800
Message-ID: <CAPcyv4hHQMngb634K87hJkEgQEhMkGKft30JCbFy2eEXA57oKA@mail.gmail.com>
Subject: Re: [PATCH 26/29] fsdax: shift partition offset handling into the
 file systems
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
> Remove the last user of ->bdev in dax.c by requiring the file system to
> pass in an address that already includes the DAX offset.  As part of the
> only set ->bdev or ->daxdev when actually required in the ->iomap_begin
> methods.

Changes look good except for what looks like an argument position
fixup needed for an xfs_bmbt_to_iomap() caller below...

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c                 |  6 +-----
>  fs/erofs/data.c          | 11 ++++++++--
>  fs/erofs/internal.h      |  1 +
>  fs/ext2/inode.c          |  8 +++++--
>  fs/ext4/inode.c          | 16 +++++++++-----
>  fs/xfs/libxfs/xfs_bmap.c |  4 ++--
>  fs/xfs/xfs_aops.c        |  2 +-
>  fs/xfs/xfs_iomap.c       | 45 +++++++++++++++++++++++++---------------
>  fs/xfs/xfs_iomap.h       |  5 +++--
>  fs/xfs/xfs_pnfs.c        |  2 +-
>  10 files changed, 63 insertions(+), 37 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 0bd6cdcbacfc4..2c13c681edf09 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -711,11 +711,7 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>
>  static pgoff_t dax_iomap_pgoff(const struct iomap *iomap, loff_t pos)
>  {
> -       phys_addr_t paddr = iomap->addr + (pos & PAGE_MASK) - iomap->offset;
> -
> -       if (iomap->bdev)
> -               paddr += (get_start_sect(iomap->bdev) << SECTOR_SHIFT);
> -       return PHYS_PFN(paddr);
> +       return PHYS_PFN(iomap->addr + (pos & PAGE_MASK) - iomap->offset);
>  }
>
>  static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0e35ef3f9f3d7..9b1bb177ce303 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
[..]
               }
> @@ -215,9 +218,13 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>         if (ret)
>                 return ret;
>
> -       iomap->bdev = mdev.m_bdev;
> -       iomap->dax_dev = mdev.m_daxdev;
>         iomap->offset = map.m_la;
> +       if (flags & IOMAP_DAX) {
> +               iomap->dax_dev = mdev.m_daxdev;
> +               iomap->offset += mdev.m_dax_part_off;
> +       } else {
> +               iomap->bdev = mdev.m_bdev;
> +       }

Ah, that's what IOMAP_DAX is for, to stop making iomap carry bdev
details unnecessarily.

[..]
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 704292c6ce0c7..74dbf1fd99d39 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -54,7 +54,8 @@ xfs_bmbt_to_iomap(
>         struct xfs_inode        *ip,
>         struct iomap            *iomap,
>         struct xfs_bmbt_irec    *imap,
> -       u16                     flags)
> +       unsigned int            flags,
> +       u16                     iomap_flags)

It would be nice if the compiler could help with making sure that
right 'flags' values are passed to the right 'flags' parameter, but I
can't think of

[..]
> @@ -1053,23 +1061,24 @@ xfs_buffered_write_iomap_begin(
>          */
>         xfs_iunlock(ip, XFS_ILOCK_EXCL);
>         trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
> -       return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
> +       return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW);
>
>  found_imap:
>         xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -       return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
> +       return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);

The iomap flags are supposed to be the last argument, right?
