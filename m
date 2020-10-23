Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200872976E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 20:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754774AbgJWSZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 14:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754600AbgJWSZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:25:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F1CC0613CE;
        Fri, 23 Oct 2020 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u0/bR0JXIWljNk0VNX4SxhSAaiuv2GldCnPLWjMch9I=; b=JWdyPz2DsQEVqUAElZovbld7ZJ
        fSjSKY+U+rEThybQrnXAlfgcv4jcFErG4EQzOfMTD9gYEAsc0/+SXHI/MgIJd8/2mpihU9b+xVNd3
        xtpDAckmH7svHLr+Erx7v04473GzUAOPo06oDPCkc5dK+MecSyQBM6L9WZ4AjTfpCE57lUofxhdlx
        7UCFX2ZkK1/s1tYSH2hxbmLuyFZyeuSBSi1kNAIquLBKCxMALkf4JQ7HPIpU+jwiZQ2TZDILi319y
        2AsEhNu61KGKRdUtjI4SkqvlTQ+LDTUiUsd4sRbKgYHD9ufzDBwC+YTw50C6DAt9YK8nkw8HEPaGw
        S0soAF+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kW1kO-00005y-2u; Fri, 23 Oct 2020 18:25:04 +0000
Date:   Fri, 23 Oct 2020 19:25:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com
Subject: Re: [PATCH v10 02/10] fs/ntfs3: Add initialization of super block
Message-ID: <20201023182503.GE20115@casper.infradead.org>
References: <20201023154431.1853715-1-almaz.alexandrovich@paragon-software.com>
 <20201023154431.1853715-3-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023154431.1853715-3-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 23, 2020 at 06:44:23PM +0300, Konstantin Komarov wrote:
> +
> +/*ntfs_readpage*/
> +/*ntfs_readpages*/
> +/*ntfs_writepage*/
> +/*ntfs_writepages*/
> +/*ntfs_block_truncate_page*/

What are these for?

> +int ntfs_readpage(struct file *file, struct page *page)
> +{
> +	int err;
> +	struct address_space *mapping = page->mapping;
> +	struct inode *inode = mapping->host;
> +	struct ntfs_inode *ni = ntfs_i(inode);
> +	u64 vbo = (u64)page->index << PAGE_SHIFT;
> +	u64 valid;
> +	struct ATTRIB *attr;
> +	const char *data;
> +	u32 data_size;
> +
[...]
> +
> +	if (is_compressed(ni)) {
> +		if (PageUptodate(page)) {
> +			unlock_page(page);
> +			return 0;
> +		}

You can skip this -- the readpage op won't be called for pages which
are Uptodate.

> +	/* normal + sparse files */
> +	err = mpage_readpage(page, ntfs_get_block);
> +	if (err)
> +		goto out;

It would be nice to use iomap instead of mpage, but that's a big ask.

> +	valid = ni->i_valid;
> +	if (vbo < valid && valid < vbo + PAGE_SIZE) {
> +		if (PageLocked(page))
> +			wait_on_page_bit(page, PG_locked);
> +		if (PageError(page)) {
> +			ntfs_inode_warn(inode, "file garbage at 0x%llx", valid);
> +			goto out;
> +		}
> +		zero_user_segment(page, valid & (PAGE_SIZE - 1), PAGE_SIZE);

Nono, you can't zero data after the page has been unlocked.  You can
handle this case in ntfs_get_block().  If the block is entirely beyond
i_size, returning a hole will cause mpage_readpage() to zero it.  If it
straddles i_size, you can either ensure that the on-media block contains
zeroes after the EOF, or if you can't depend on that, you can read it
in synchronously in your get_block() and then zero the tail and set the
buffer Uptodate.  Not the most appetising solution, but what you have here
is racy with the user writing to it after reading.

