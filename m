Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168CB1B071F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 13:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgDTLOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 07:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726123AbgDTLOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:14:30 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61FC0610D5
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 04:14:30 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q8so7579748eja.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okPBkG9vtS/wVdJh/KDIc+hdg6krV+bND5agW6vUaRM=;
        b=IDveWlOS7Tzhrdb36+hZpTST6wjOAPrAj2jj5uib3vbWbabqwzW9IWuAtw8h4eTBNA
         9a9lkdgEJOm6Eb3fwCtOVTxrVmphaH2PGWy9bhlS9QBo4VsFK/CUgj6vV9uyCovU0arA
         5Kj1tMT4D5sNr37XYcPWFQo9UnIzxN1guBg1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okPBkG9vtS/wVdJh/KDIc+hdg6krV+bND5agW6vUaRM=;
        b=D/ddkrXk4ugKOI3YbwyV+GQ41S78s6lFggdN9GldT20lAs9NyF8ce30S+v1wlcDjM3
         SllirgUlCQf6ZTTZYMYD9y4zzG3DnzLGgcyobIdfgEWCHblph1dijFV/bybxqdbo4FQf
         Ompx7YymhomWM2FOn5kJ00P2WEflqUc6t6Bni+YEs+LIftTY165KIChAKYMNgPFxhBGs
         W+keQ/uOSxEaCU4r+2YDbmyCJduUcTRkhTMftwTlqKwqDSUDAl7oyCjastkEW2y/28ot
         f1y7o4FrSI9SRzZMS+OATXzqjYlQbsDkjrhbNPjuMEOfGFHpFLpHX+W7YaFbcExXXabP
         euMg==
X-Gm-Message-State: AGi0Pua1O2cPXkHTvzzEHgTvpUhAPaEW8unysEPY4vQvXhGCjZKV5Ysy
        j132fKwiQnS043hC8mg4UiWoE0cLELV37q+HJxRahg==
X-Google-Smtp-Source: APiQypIVhtjPPYqBEymAM1SkD4SYcU1V6bmTKvyt+63wSYT0tOjvuXxym8edoJZS6GcpMs4Nq+7PF2DextVY/K9Ax1g=
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr16038100ejx.43.1587381268754;
 Mon, 20 Apr 2020 04:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org> <20200414150233.24495-25-willy@infradead.org>
In-Reply-To: <20200414150233.24495-25-willy@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 20 Apr 2020 13:14:17 +0200
Message-ID: <CAJfpegsZF=TFQ67vABkE5ghiZoTZF+=_u8tM5U_P6jZeAmv23A@mail.gmail.com>
Subject: Re: [PATCH v11 24/25] fuse: Convert from readpages to readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Implement the new readahead operation in fuse by using __readahead_batch()
> to fill the array of pages in fuse_args_pages directly.  This lets us
> inline fuse_readpages_fill() into fuse_readahead().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  fs/fuse/file.c | 99 ++++++++++++++------------------------------------
>  1 file changed, 27 insertions(+), 72 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9d67b830fb7a..db82fb29dd39 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -915,84 +915,39 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
>         fuse_readpages_end(fc, &ap->args, err);
>  }
>
> -struct fuse_fill_data {
> -       struct fuse_io_args *ia;
> -       struct file *file;
> -       struct inode *inode;
> -       unsigned int nr_pages;
> -       unsigned int max_pages;
> -};
> -
> -static int fuse_readpages_fill(void *_data, struct page *page)
> +static void fuse_readahead(struct readahead_control *rac)
>  {
> -       struct fuse_fill_data *data = _data;
> -       struct fuse_io_args *ia = data->ia;
> -       struct fuse_args_pages *ap = &ia->ap;
> -       struct inode *inode = data->inode;
> +       struct inode *inode = rac->mapping->host;
>         struct fuse_conn *fc = get_fuse_conn(inode);
> +       unsigned int i, max_pages, nr_pages = 0;
>
> -       fuse_wait_on_page_writeback(inode, page->index);
> -
> -       if (ap->num_pages &&
> -           (ap->num_pages == fc->max_pages ||
> -            (ap->num_pages + 1) * PAGE_SIZE > fc->max_read ||
> -            ap->pages[ap->num_pages - 1]->index + 1 != page->index)) {
> -               data->max_pages = min_t(unsigned int, data->nr_pages,
> -                                       fc->max_pages);
> -               fuse_send_readpages(ia, data->file);
> -               data->ia = ia = fuse_io_alloc(NULL, data->max_pages);
> -               if (!ia) {
> -                       unlock_page(page);
> -                       return -ENOMEM;
> -               }
> -               ap = &ia->ap;
> -       }
> -
> -       if (WARN_ON(ap->num_pages >= data->max_pages)) {
> -               unlock_page(page);
> -               fuse_io_free(ia);
> -               return -EIO;
> -       }
> -
> -       get_page(page);
> -       ap->pages[ap->num_pages] = page;
> -       ap->descs[ap->num_pages].length = PAGE_SIZE;
> -       ap->num_pages++;
> -       data->nr_pages--;
> -       return 0;
> -}
> -
> -static int fuse_readpages(struct file *file, struct address_space *mapping,
> -                         struct list_head *pages, unsigned nr_pages)
> -{
> -       struct inode *inode = mapping->host;
> -       struct fuse_conn *fc = get_fuse_conn(inode);
> -       struct fuse_fill_data data;
> -       int err;
> -
> -       err = -EIO;
>         if (is_bad_inode(inode))
> -               goto out;
> +               return;
>
> -       data.file = file;
> -       data.inode = inode;
> -       data.nr_pages = nr_pages;
> -       data.max_pages = min_t(unsigned int, nr_pages, fc->max_pages);
> -;
> -       data.ia = fuse_io_alloc(NULL, data.max_pages);
> -       err = -ENOMEM;
> -       if (!data.ia)
> -               goto out;
> +       max_pages = min(fc->max_pages, fc->max_read / PAGE_SIZE);
>
> -       err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
> -       if (!err) {
> -               if (data.ia->ap.num_pages)
> -                       fuse_send_readpages(data.ia, file);
> -               else
> -                       fuse_io_free(data.ia);
> +       for (;;) {
> +               struct fuse_io_args *ia;
> +               struct fuse_args_pages *ap;
> +
> +               nr_pages = readahead_count(rac) - nr_pages;

Hmm.  I see what's going on here, but it's confusing.   Why is
__readahead_batch() decrementing the readahead count at the start,
rather than at the end?

At the very least it needs a comment about why nr_pages is calculated this way.

> +               if (nr_pages > max_pages)
> +                       nr_pages = max_pages;
> +               if (nr_pages == 0)
> +                       break;
> +               ia = fuse_io_alloc(NULL, nr_pages);
> +               if (!ia)
> +                       return;
> +               ap = &ia->ap;
> +               nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
> +               for (i = 0; i < nr_pages; i++) {
> +                       fuse_wait_on_page_writeback(inode,
> +                                                   readahead_index(rac) + i);

What's wrong with ap->pages[i]->index?  Are we trying to wean off using ->index?

Thanks,
Miklos
