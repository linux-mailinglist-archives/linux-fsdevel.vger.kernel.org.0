Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE67FE53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfD3RBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 13:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfD3RBy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:01:54 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416392075E;
        Tue, 30 Apr 2019 17:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556643713;
        bh=oVoGpCRk3e9cMGbhChpi4VM9WziRJ8IUbj1IO6W9b30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1bUb7kJbzNOTKFj04oKViKl6iUVKgyDzhaJEYERMY0d+9XjzIRMUEe2L65NvXZ7eU
         1gXP07Tk2C/6mLOZ5hWvk2+t/TmKA9gEX/C77XGLGNI+3p3CCT3SL/RbI8Wgq1Fx4J
         ukvS0zQ6c1vJocSzlV58WS0Ro0pIi7E/a6g4jhpk=
Date:   Tue, 30 Apr 2019 10:01:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V2 11/13] ext4: Compute logical block and the page range
 to be encrypted
Message-ID: <20190430170151.GB48973@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190428043121.30925-12-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428043121.30925-12-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 28, 2019 at 10:01:19AM +0530, Chandan Rajendra wrote:
> For subpage-sized blocks, the initial logical block number mapped by a
> page can be different from page->index. Hence this commit adds code to
> compute the first logical block mapped by the page and also the page
> range to be encrypted.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/ext4/page-io.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 3e9298e6a705..75485ee9e800 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -418,6 +418,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  {
>  	struct page *data_page = NULL;
>  	struct inode *inode = page->mapping->host;
> +	u64 page_blk;
>  	unsigned block_start;
>  	struct buffer_head *bh, *head;
>  	int ret = 0;
> @@ -478,10 +479,14 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  
>  	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) && nr_to_submit) {
>  		gfp_t gfp_flags = GFP_NOFS;
> +		unsigned int page_bytes;
> +

page_blk should be declared here, just after page_bytes.

> +		page_bytes = round_up(len, i_blocksize(inode));
> +		page_blk = page->index << (PAGE_SHIFT - inode->i_blkbits);

Although block numbers are 32-bit in ext4, if you're going to make 'page_blk' a
u64 anyway, then for consistency page->index should be cast to u64 here.

>  
>  	retry_encrypt:
> -		data_page = fscrypt_encrypt_page(inode, page, PAGE_SIZE, 0,
> -						page->index, gfp_flags);
> +		data_page = fscrypt_encrypt_page(inode, page, page_bytes, 0,
> +						page_blk, gfp_flags);
>  		if (IS_ERR(data_page)) {
>  			ret = PTR_ERR(data_page);
>  			if (ret == -ENOMEM && wbc->sync_mode == WB_SYNC_ALL) {
> -- 
> 2.19.1
> 
