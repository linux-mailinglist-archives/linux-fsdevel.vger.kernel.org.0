Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207DF35C52B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 13:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhDLLbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 07:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbhDLLbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:31:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C456C06138C;
        Mon, 12 Apr 2021 04:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kWQ0c8ucYe9UV0ATqeFAnzRMY2iAE51PlhKV5u1lmgA=; b=cUlG6NlYie3LJa9ROPnR/w8KN2
        JCdeSfOVfIeml1p84gNnsCv7tp+9EaP/qi6AjJ9B9nZGmaLGGKWPjHTdIvaWcevxZqaAkVyH2zIYp
        YpK1Vp4IdlP++IDrzLyQJenh0Z9PQiQc5EmbthkHVGgJYwguPfIaBbOh+NnGPEke9NwJew87h0P4l
        V7bgqTmOzaNfOfdXMhCBPWNLGUefhossu8yUlPa9K5YVUlircfzjRegGT3hQYhaUB86Eo/A+q8Lh9
        FyKa4e0if+oxWZxVJ/gYi8OJ+vHclbw/A6CDRpuHpMycMwJB4pNR6QVEd0Gvi7jbQGTdY01NUVmYY
        Rk6/snpw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVumD-004Fyn-9X; Mon, 12 Apr 2021 11:30:49 +0000
Date:   Mon, 12 Apr 2021 12:30:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Eric Whitney <enwlinux@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 3/3] ext4: Fix overflow in ext4_iomap_alloc()
Message-ID: <20210412113045.GI2531743@casper.infradead.org>
References: <20210412102333.2676-1-jack@suse.cz>
 <20210412102333.2676-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412102333.2676-4-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 12, 2021 at 12:23:33PM +0200, Jan Kara wrote:
> A code in iomap alloc may overblock block number when converting it to

"overflow"?

> byte offset. Luckily this is mostly harmless as we will just use more
> expensive method of writing using unwritten extents even though we are
> writing beyond i_size.
> 
> Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0948a43f1b3d..7cebbb2d2e34 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3420,7 +3420,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>  	 * i_disksize out to i_size. This could be beyond where direct I/O is
>  	 * happening and thus expose allocated blocks to direct I/O reads.
>  	 */
> -	else if ((map->m_lblk * (1 << blkbits)) >= i_size_read(inode))
> +	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
>  		m_flags = EXT4_GET_BLOCKS_CREATE;
>  	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> -- 
> 2.26.2
> 
