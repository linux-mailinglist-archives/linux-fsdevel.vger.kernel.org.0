Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9142638F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 06:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhJHEN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 00:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJHEN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 00:13:26 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ADFC061755
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 21:11:31 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id t11so8578291ilf.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 21:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXTUDJeSSZP7R5MQLkITGVvuZRsjMUzYbj73AZNZ2F4=;
        b=CjhqAwnk4JmMS35N1cyMZ2npni4FxyMIQR1c5FNlVa7sAhhtm2y33M+auLZdhuKria
         8MvfCwka1IK1gaWgYt9vZNwiIpzBQJOBMQkWaLIYWoy5hwrOzaAF3MBYWCH6sBTR5++F
         xwVGgytdVarrjGGeTyKvTNkZRi8AgsSGAo/g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXTUDJeSSZP7R5MQLkITGVvuZRsjMUzYbj73AZNZ2F4=;
        b=uDOEtqcojfvd8Lv7behdA3B/lWRNsngww8XmwcJaX1LSPOWGtUIZgx41iXdPGiJnjz
         9zIAhn9kqjMN/jRK3srPUYPmogDnBv9cB19NsGib+gdOKmflaiCC81DwJXYH8x9u3zlX
         hMFZuI2LnkmV7up6jAKKO+Qiuvw9DlW61PREiwUOrgCkXqdvYgGXpaDEK6UExNb/Uc7V
         ivRolhWXrRncNibglM/NRVtedDfeA3F3AEZVKWTrkZ2OQ5V7IcO4TlQSiADFuDU2w4Zg
         vDoGkbLIDc3alJadpXxmycmwEazgZV1PkppSH4cJYmrgzDEgeNGm+RDD+TkyjoA848tT
         4l8Q==
X-Gm-Message-State: AOAM531z69ctigK8uClBG8UdtNzDNrBJnyyRNvadWuMO5MiktVKjIqEU
        NYDMYAJ0NDkAF7eTEgdxlMJ+4fGzK6Q0ARQpSLKKVg==
X-Google-Smtp-Source: ABdhPJxi4hbGcN33/45t2W0AswoxgW37VS0j8R875zThFFQSNCrBzDYilGvSf2g1VzGbOSpwj/T3gVNDQp9npZCqIs8=
X-Received: by 2002:a05:6e02:1aa4:: with SMTP id l4mr5983277ilv.231.1633666290966;
 Thu, 07 Oct 2021 21:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAJMQK-g9G6KQmH-V=BRGX0swZji9Wxe_2c7ht-MMAapdFy2pXw@mail.gmail.com>
 <YV2GlrdkRMHGAPOE@casper.infradead.org> <CAJMQK-hVH9uFLPnuySyfQ7o5d-m7gSXG5=Nx_7-92t82M0PMnQ@mail.gmail.com>
 <YV2gpWYhcJxiDArT@casper.infradead.org> <CAJMQK-i0wL7SAo3C5r2Ty9SaJhZ7OyO+DJdq-E3i9LBW_vJ4Jw@mail.gmail.com>
 <CAJMQK-j-=q3gHyB6hb-5HvTY6QGf8wCg9q99cfj7wTCT+He4mA@mail.gmail.com> <YV76Dg+C4BT47ABN@casper.infradead.org>
In-Reply-To: <YV76Dg+C4BT47ABN@casper.infradead.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 8 Oct 2021 12:11:05 +0800
Message-ID: <CAJMQK-h24shNo3eKGaj0sVn8vH+oHht4g_R9yQbwUKSVCaUT-Q@mail.gmail.com>
Subject: Re: Readahead regressed with c1f6925e1091("mm: put readahead pages in
 cache earlier") on multicore arm64 platforms
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Phillip Lougher <phillip@squashfs.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 7, 2021 at 9:46 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Oct 07, 2021 at 03:08:38PM +0800, Hsin-Yi Wang wrote:
> > This calls into squashfs_readpage().
>
> Aha!  I hadn't looked at squashfs before, and now that I do, I can
> see why this commit causes problems for squashfs.  (It would be
> helpful if your report included more detail about which paths inside
> squashfs were taken, but I think I can guess):
>
> squashfs_readpage()
>   squashfs_readpage_block()
>     squashfs_copy_cache()
>       grab_cache_page_nowait()
>
Right, before the patch, push_page won't be null but after the patch,
grab_cache_page_nowait() fails.


> Before this patch, readahead of 1MB would allocate 256x4kB pages,
> then add each one to the page cache and call ->readpage on it:
>
>         for (page_idx = 0; page_idx < readahead_count(rac); page_idx++) {
>                 struct page *page = lru_to_page(pages);
>                 list_del(&page->lru);
>                 if (!add_to_page_cache_lru(page, rac->mapping, page->index,
>                                gfp))
>                         aops->readpage(rac->file, page);
>
> When Squashfs sees it has more than 4kB of data, it calls
> grab_cache_page_nowait(), which allocates more memory (ignoring the
> other 255 pages which have been allocated, because they're not in the
> page cache yet).  Then this loop frees the pages that readahead
> allocated.
>
> After this patch, the pages are already in the page cache when
> ->readpage is called the first time.  So the call to
> grab_cache_page_nowait() fails and squashfs redoes the decompression for
> each page.
>
> Neither of these approaches are efficient.  Squashfs need to implement
> ->readahead.  Working on it now ...
>
