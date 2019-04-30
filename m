Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8165AFE87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 19:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfD3RLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 13:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RLh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:11:37 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6843A20644;
        Tue, 30 Apr 2019 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556644296;
        bh=8OdPkThiapl6sD5rI5vnTwpDb7WnGUe6ZTHP6sxtc7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFnsbD2E/4SeyMn+nJ9xzGwMqUGI81s4uzsvgj75dY1+zR4Yig5vYb922Qy/vVmD4
         WY9pdj+uF13kzkZplUYGZTlhPZ6t8MNLdQyOsTBzoF4wQZ2hI9h77VsAMWqCyU69a2
         +MXBOc8pjIBEpfILurQrqRpw0uhHjSMIALdajaOg=
Date:   Tue, 30 Apr 2019 10:11:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V2 10/13] fscrypt_encrypt_page: Loop across all blocks
 mapped by a page range
Message-ID: <20190430171133.GC48973@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190428043121.30925-11-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428043121.30925-11-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 28, 2019 at 10:01:18AM +0530, Chandan Rajendra wrote:
> For subpage-sized blocks, this commit now encrypts all blocks mapped by
> a page range.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/crypto/crypto.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> index 4f0d832cae71..2d65b431563f 100644
> --- a/fs/crypto/crypto.c
> +++ b/fs/crypto/crypto.c
> @@ -242,18 +242,26 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,

Need to update the function comment to clearly explain what this function
actually does now.

>  {
>  	struct fscrypt_ctx *ctx;
>  	struct page *ciphertext_page = page;
> +	int i, page_nr_blks;
>  	int err;
>  
>  	BUG_ON(len % FS_CRYPTO_BLOCK_SIZE != 0);
>  

Make a 'blocksize' variable so you don't have to keep calling i_blocksize().

Also, you need to check whether 'len' and 'offs' are filesystem-block-aligned,
since the code now assumes it.

	const unsigned int blocksize = i_blocksize(inode);

        if (!IS_ALIGNED(len | offs, blocksize))
                return -EINVAL;

However, did you check whether that's always true for ubifs?  It looks like it
may expect to encrypt a prefix of a block, that is only padded to the next
16-byte boundary.
		
> +	page_nr_blks = len >> inode->i_blkbits;
> +
>  	if (inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES) {
>  		/* with inplace-encryption we just encrypt the page */
> -		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num, page,
> -					     ciphertext_page, len, offs,
> -					     gfp_flags);
> -		if (err)
> -			return ERR_PTR(err);
> -
> +		for (i = 0; i < page_nr_blks; i++) {
> +			err = fscrypt_do_page_crypto(inode, FS_ENCRYPT,
> +						lblk_num, page,
> +						ciphertext_page,
> +						i_blocksize(inode), offs,
> +						gfp_flags);
> +			if (err)
> +				return ERR_PTR(err);
> +			++lblk_num;
> +			offs += i_blocksize(inode);
> +		}
>  		return ciphertext_page;
>  	}
>  
> @@ -269,12 +277,17 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
>  		goto errout;
>  
>  	ctx->control_page = page;
> -	err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num,
> -				     page, ciphertext_page, len, offs,
> -				     gfp_flags);
> -	if (err) {
> -		ciphertext_page = ERR_PTR(err);
> -		goto errout;
> +
> +	for (i = 0; i < page_nr_blks; i++) {
> +		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num,
> +					page, ciphertext_page,
> +					i_blocksize(inode), offs, gfp_flags);

As I mentioned elsewhere, renaming fscrypt_do_page_crypto() to
fscrypt_crypt_block() would make more sense now.

> +		if (err) {
> +			ciphertext_page = ERR_PTR(err);
> +			goto errout;
> +		}
> +		++lblk_num;
> +		offs += i_blocksize(inode);
>  	}
>  	SetPagePrivate(ciphertext_page);
>  	set_page_private(ciphertext_page, (unsigned long)ctx);
> -- 
> 2.19.1
> 
