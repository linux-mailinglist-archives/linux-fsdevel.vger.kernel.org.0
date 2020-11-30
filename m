Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8192C890A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 17:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgK3QL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 11:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgK3QL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:11:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5D9C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9EbTkQUh4TzPSCrogdlxh+mLUPXZx99MPvA6FEyM6RI=; b=Zj2ZI4ABeMt0lc7HpZ5F+udcKD
        VJNu0QTzmyPTogjirejWuQv4NusVv8ZhoAWPz0RCEmHZxm+JWvHrj78uEre9FJSBpH2GszC88d6ZP
        bHkfe6J1qjXgru8L3cl1ZEwHmyOX/huBH1CvYnenoVU6XFZnlEgGbdSdYqCxGPxICr45EivLmEPlW
        igi1yx8MvOzre/yXwZY3f3uWZ9nFnYhcSSTmiBu3oZHIBlJvp+PhYiq0jLGp/+qdqLgwkZli6flJ0
        lzrRmUIzouClo8GpG3eTqIx3KGS4AB3bjSD1xd0NkEJr3JY+JrVlmoyhVneuYr5jSm3hiopJsnuXd
        omctrYVg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjllC-0007la-GR; Mon, 30 Nov 2020 16:10:42 +0000
Date:   Mon, 30 Nov 2020 16:10:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Gong, Sishuai" <sishuai@purdue.edu>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [Race] data race between do_mpage_readpage() and set_blocksize()
Message-ID: <20201130161042.GD4327@casper.infradead.org>
References: <A57702D8-5E3E-401B-8010-C86901DD5D61@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A57702D8-5E3E-401B-8010-C86901DD5D61@purdue.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 03:41:53PM +0000, Gong, Sishuai wrote:
> We found a data race in linux kernel 5.3.11 that we are able to reproduce in x86 under specific interleavings. Currently, we are not sure about the consequence of this race so we would like to confirm with the community if this can be a harmful bug.

How are you able to reproduce it?  Normally mpage_readpage() is only called
from a filesystem, and you shouldn't be able to change the size of the
blocks in a block device while there's a mounted filesystem.

> ------------------------------------------
> Writer site
> 
> /tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/block_dev.c:135
>         120
>         121  int set_blocksize(struct block_device *bdev, int size)
>         122  {
>         123      /* Size must be a power of two, and between 512 and PAGE_SIZE */
>         124      if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
>         125          return -EINVAL;
>         126
>         127      /* Size cannot be smaller than the size supported by the device */
>         128      if (size < bdev_logical_block_size(bdev))
>         129          return -EINVAL;
>         130
>         131      /* Don't change the size if it is same as current */
>         132      if (bdev->bd_block_size != size) {
>         133          sync_blockdev(bdev);
>         134          bdev->bd_block_size = size;
>  ==>    135          bdev->bd_inode->i_blkbits = blksize_bits(size);
>         136          kill_bdev(bdev);
>         137      }
>         138      return 0;
>         139  }
> 
> ------------------------------------------
> Reader site
> 
>  /tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/mpage.c:160
>         147  /*
>         148   * This is the worker routine which does all the work of mapping the disk
>         149   * blocks and constructs largest possible bios, submits them for IO if the
>         150   * blocks are not contiguous on the disk.
>         151   *
>         152   * We pass a buffer_head back and forth and use its buffer_mapped() flag to
>         153   * represent the validity of its disk mapping and to decide when to do the next
>         154   * get_block() call.
>         155   */
>         156  static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>         157  {
>         158      struct page *page = args->page;
>         159      struct inode *inode = page->mapping->host;
>  ==>    160      const unsigned blkbits = inode->i_blkbits;
>         161      const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
>         162      const unsigned blocksize = 1 << blkbits;
>         163      struct buffer_head *map_bh = &args->map_bh;
>         164      sector_t block_in_file;
>         165      sector_t last_block;
>         166      sector_t last_block_in_file;
>         167      sector_t blocks[MAX_BUF_PER_PAGE];
>         168      unsigned page_block;
>         169      unsigned first_hole = blocks_per_page;
>         170      struct block_device *bdev = NULL;
>         171      int length;
>         172      int fully_mapped = 1;
>         173      int op_flags;
>         174      unsigned nblocks;
>         175      unsigned relative_block;
>         176      gfp_t gfp;
>         177
>         178      if (args->is_readahead) {
>         179          op_flags = REQ_RAHEAD;
>         180          gfp = readahead_gfp_mask(page->mapping);
> 
> 
> ------------------------------------------
> Writer calling trace
> 
> - ksys_mount
> -- do_mount
> --- vfs_get_tree
> ---- mount_bdev
> ----- sb_min_blocksize
> ------ sb_set_blocksize
> ------- set_blocksize
> 
> ------------------------------------------
> Reader calling trace
> 
> - ksys_read
> -- vfs_read
> --- __vfs_read
> ---- generic_file_read_iter
> ----- page_cache_sync_readahead
> ------ force_page_cache_readahead
> ------- __do_page_cache_readahead
> -------- read_pages
> --------- mpage_readpages
> ---------- do_mpage_readpage
> 
> 
> 
> Thanks,
> Sishuai
> 
