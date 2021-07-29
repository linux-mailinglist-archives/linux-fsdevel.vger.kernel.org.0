Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7463D9C69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 05:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhG2DzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 23:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233444AbhG2DzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 23:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627530910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uC1FHB6Ltwg9aVPHNYZs7xQhWoFRsts5ruZx40NQ+EI=;
        b=ar04ruK8NJdtw+cHgyMLruRMdwBt75eSzHSTu5f0/yd4r+bjaKDYbSynr6f7FzuKX7Ld21
        dJ+1RbCSQeGymab9eg7Mn+fOFYE4iD26aoyz6y11Nx1GVF9VP5+gyHYPPtdtTK+WxYE/m/
        jW/2qH5TQzYoGNTEYvNT8AOQUM3tDEA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-hWXgbTVQPfKyP63d7ybPMw-1; Wed, 28 Jul 2021 23:55:08 -0400
X-MC-Unique: hWXgbTVQPfKyP63d7ybPMw-1
Received: by mail-wr1-f69.google.com with SMTP id c5-20020a5d52850000b0290126f2836a61so1726130wrv.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jul 2021 20:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uC1FHB6Ltwg9aVPHNYZs7xQhWoFRsts5ruZx40NQ+EI=;
        b=l4GL7JdbUMstbyraat33qdQ5iLZ/8JzNYaBYr+OK8GCU5N+DJuZBEGjBhA5SV3q04o
         bkqmp5Fm+WEw1enb6+ujzM/FKYUafUqdrPjahfdFxE9u1rQbQcpbeZ1nStnp5a407FJt
         bLRgKkbAv7grtJBqk7faXa7L1pm27RIKeTfihs4esqgri0jqxY5UYaFFMfQX9hEy6k2r
         YZJ9sk9kDXg5vHbaXiVtLzb54Y6hjfGkzSmt7Ga4UNQ/+qkcpNi7SZfNhaBKtc7qNT6X
         dgP3zdrW4lVF9KD0mzgPH4lBnS1rIciVMCDjTJHoEtp8dUnrrDGdp/xE6Ko9w1ic4qn3
         lZSA==
X-Gm-Message-State: AOAM531nBeUR1QN8Vmm3QjilaZ3OLuAwcdlnL/V7e4e6JpbvSwqKn7Bn
        pVgkaFp6eSASgtDpAcXZSNo2iyRzzZsjVPR1xZJviZ+2wjYY4VjkZjkbeN3vQYocuaj43X3gq7I
        m4i4vJWoW7OK2PSd1jQUTc9mvj0P3rjSrG8v0lcZWwA==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr2341667wrv.357.1627530907746;
        Wed, 28 Jul 2021 20:55:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyByMIX137ZLqJJiCVTQnxk6c1FnVSkm2nYKBkgw1Xej+SqUPl31fRTeEFWaBx/7Iuv8c60B/3IRkYVbRouDJo=
X-Received: by 2002:a5d:5286:: with SMTP id c6mr2341654wrv.357.1627530907583;
 Wed, 28 Jul 2021 20:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210729032344.3975412-1-willy@infradead.org>
In-Reply-To: <20210729032344.3975412-1-willy@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 29 Jul 2021 05:54:56 +0200
Message-ID: <CAHc6FU5E9AdiH7SnfADteOVdttNFGO1EN0PoiYYVyaftCJ1Mqw@mail.gmail.com>
Subject: Re: [PATCH v2] iomap: Support inline data with block size < page size
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 5:25 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Remove the restriction that inline data must start on a page boundary
> in a file.  This allows, for example, the first 2KiB to be stored out
> of line and the trailing 30 bytes to be stored inline.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2:
>  - Rebase on top of iomap: Support file tail packing v9
>
>  fs/iomap/buffered-io.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 66b733537c46..50f18985ed13 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -209,28 +209,26 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
>                 struct iomap *iomap)
>  {
>         size_t size = i_size_read(inode) - iomap->offset;
> +       size_t poff = offset_in_page(iomap->offset);
>         void *addr;
>
>         if (PageUptodate(page))
> -               return 0;
> +               return PAGE_SIZE - poff;
>
> -       /* inline data must start page aligned in the file */
> -       if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> -               return -EIO;

Maybe add a WARN_ON_ONCE(size > PAGE_SIZE - poff) here?

>         if (WARN_ON_ONCE(size > PAGE_SIZE -
>                          offset_in_page(iomap->inline_data)))
>                 return -EIO;
>         if (WARN_ON_ONCE(size > iomap->length))
>                 return -EIO;
> -       if (WARN_ON_ONCE(page_has_private(page)))
> -               return -EIO;
> +       if (poff > 0)
> +               iomap_page_create(inode, page);
>
> -       addr = kmap_atomic(page);
> +       addr = kmap_atomic(page) + poff;

Maybe kmap_local_page?

>         memcpy(addr, iomap->inline_data, size);
> -       memset(addr + size, 0, PAGE_SIZE - size);
> +       memset(addr + size, 0, PAGE_SIZE - poff - size);
>         kunmap_atomic(addr);
> -       SetPageUptodate(page);
> -       return 0;
> +       iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> +       return PAGE_SIZE - poff;
>  }
>
>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -252,13 +250,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>         unsigned poff, plen;
>         sector_t sector;
>
> -       if (iomap->type == IOMAP_INLINE) {
> -               int ret = iomap_read_inline_data(inode, page, iomap);
> -
> -               if (ret)
> -                       return ret;
> -               return PAGE_SIZE;
> -       }
> +       if (iomap->type == IOMAP_INLINE)
> +               return iomap_read_inline_data(inode, page, iomap);
>
>         /* zero post-eof blocks as the page may be mapped */
>         iop = iomap_page_create(inode, page);
> @@ -593,10 +586,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  static int iomap_write_begin_inline(struct inode *inode,
>                 struct page *page, struct iomap *srcmap)
>  {
> +       int ret;
> +
>         /* needs more work for the tailpacking case, disable for now */
>         if (WARN_ON_ONCE(srcmap->offset != 0))
>                 return -EIO;
> -       return iomap_read_inline_data(inode, page, srcmap);
> +       ret = iomap_read_inline_data(inode, page, srcmap);
> +       if (ret < 0)
> +               return ret;
> +       return 0;
>  }
>
>  static int
> --
> 2.30.2
>

Thanks,
Andreas

