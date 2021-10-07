Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA344425498
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 15:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbhJGNtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 09:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbhJGNs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:48:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A411C061746
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=607rztqRurXcY14w9Lgc+y2pxf9wdHgqF9UDj5T8biM=; b=i0oyafqgh03DwZSBCYa3ytf/J4
        jaRFZw2g6BerSc7ArUtWmeu0hS/gl+nZU7rA6uO2sRIKMgHwujuFM5nlu1Pl0moOBY6sSzwPOKG0h
        EP0a7E1bBXMtvMY5HLdId/INO5ch7NqW2efZh/y7dZMF1Jl1tBVrI8TLhT92zN4HZ5+sJFlabMiXL
        /maSZx+Tgk5Rfz/jnWizFMlQM0LupV5M4dJcK1VsSMBFu2I+9i/M9XTGjTH8sYeQiPyswt6O6echA
        7U3d0Z/2FQDRK7VQg7d80D8WCxlF7sZgIv2QiTd0Avg8uv/Z9yCcHl3mdgno432WBzYfv3ZafrRfd
        wuUMYEZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYTiY-001tvX-WC; Thu, 07 Oct 2021 13:46:02 +0000
Date:   Thu, 7 Oct 2021 14:45:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: Readahead regressed with c1f6925e1091("mm: put readahead pages
 in cache earlier") on multicore arm64 platforms
Message-ID: <YV76Dg+C4BT47ABN@casper.infradead.org>
References: <CAJMQK-g9G6KQmH-V=BRGX0swZji9Wxe_2c7ht-MMAapdFy2pXw@mail.gmail.com>
 <YV2GlrdkRMHGAPOE@casper.infradead.org>
 <CAJMQK-hVH9uFLPnuySyfQ7o5d-m7gSXG5=Nx_7-92t82M0PMnQ@mail.gmail.com>
 <YV2gpWYhcJxiDArT@casper.infradead.org>
 <CAJMQK-i0wL7SAo3C5r2Ty9SaJhZ7OyO+DJdq-E3i9LBW_vJ4Jw@mail.gmail.com>
 <CAJMQK-j-=q3gHyB6hb-5HvTY6QGf8wCg9q99cfj7wTCT+He4mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-j-=q3gHyB6hb-5HvTY6QGf8wCg9q99cfj7wTCT+He4mA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 07, 2021 at 03:08:38PM +0800, Hsin-Yi Wang wrote:
> This calls into squashfs_readpage().

Aha!  I hadn't looked at squashfs before, and now that I do, I can
see why this commit causes problems for squashfs.  (It would be
helpful if your report included more detail about which paths inside
squashfs were taken, but I think I can guess):

squashfs_readpage()
  squashfs_readpage_block()
    squashfs_copy_cache()
      grab_cache_page_nowait()

Before this patch, readahead of 1MB would allocate 256x4kB pages,
then add each one to the page cache and call ->readpage on it:

        for (page_idx = 0; page_idx < readahead_count(rac); page_idx++) {
                struct page *page = lru_to_page(pages);
                list_del(&page->lru);
                if (!add_to_page_cache_lru(page, rac->mapping, page->index,
                               gfp))
                        aops->readpage(rac->file, page);

When Squashfs sees it has more than 4kB of data, it calls
grab_cache_page_nowait(), which allocates more memory (ignoring the
other 255 pages which have been allocated, because they're not in the
page cache yet).  Then this loop frees the pages that readahead
allocated.

After this patch, the pages are already in the page cache when
->readpage is called the first time.  So the call to
grab_cache_page_nowait() fails and squashfs redoes the decompression for
each page.

Neither of these approaches are efficient.  Squashfs need to implement
->readahead.  Working on it now ...

