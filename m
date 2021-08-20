Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0D3F28B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhHTIwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 04:52:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52322 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbhHTIwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:52:05 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E445D1FDEA;
        Fri, 20 Aug 2021 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629449486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLrGYtWxDnM40dQNIw+mgGouzhWLsKGdVn3Kr41/H9o=;
        b=jYDFWX83X51DFlqR4Wh5Oh3xTYsd0PmfhyIpHe3s9o3jpTM5NOwu/T162nCiTrA8NAbzzm
        mJWfHxwngCfTvdZraibp262kEwuQKepwnEKsAIQjY4bDE7Wmy2Hk9+6/aZE9FitBiXYJ3G
        4I239qrtZqUg6PNiQsmq7815p1nYmlE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7F4631333E;
        Fri, 20 Aug 2021 08:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ESGMHA5tH2ESUAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 20 Aug 2021 08:51:26 +0000
Subject: Re: [PATCH v10 06/14] btrfs: optionally extend i_size in
 cow_file_range_inline()
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <cover.1629234193.git.osandov@fb.com>
 <a00b59623219c8a07f2c22f80ef1466d0f182d77.1629234193.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1b495420-f4c6-6988-c0b1-9aa8a7aa952d@suse.com>
Date:   Fri, 20 Aug 2021 11:51:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a00b59623219c8a07f2c22f80ef1466d0f182d77.1629234193.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 18.08.21 г. 0:06, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Currently, an inline extent is always created after i_size is extended
> from btrfs_dirty_pages(). However, for encoded writes, we only want to
> update i_size after we successfully created the inline extent. Add an
> update_i_size parameter to cow_file_range_inline() and
> insert_inline_extent() and pass in the size of the extent rather than
> determining it from i_size. Since the start parameter is always passed
> as 0, get rid of it and simplify the logic in these two functions. While
> we're here, let's document the requirements for creating an inline
> extent.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/inode.c | 100 +++++++++++++++++++++++------------------------
>  1 file changed, 48 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 708d8ab098bc..0b5ff14aa7fd 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -236,9 +236,10 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
>  static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  				struct btrfs_path *path, bool extent_inserted,
>  				struct btrfs_root *root, struct inode *inode,
> -				u64 start, size_t size, size_t compressed_size,
> +				size_t size, size_t compressed_size,
>  				int compress_type,
> -				struct page **compressed_pages)
> +				struct page **compressed_pages,
> +				bool update_i_size)
>  {
>  	struct extent_buffer *leaf;
>  	struct page *page = NULL;
> @@ -247,7 +248,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  	struct btrfs_file_extent_item *ei;
>  	int ret;
>  	size_t cur_size = size;
> -	unsigned long offset;
> +	u64 i_size;
>  
>  	ASSERT((compressed_size > 0 && compressed_pages) ||
>  	       (compressed_size == 0 && !compressed_pages));
> @@ -260,7 +261,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  		size_t datasize;
>  
>  		key.objectid = btrfs_ino(BTRFS_I(inode));
> -		key.offset = start;
> +		key.offset = 0;
>  		key.type = BTRFS_EXTENT_DATA_KEY;
>  
>  		datasize = btrfs_file_extent_calc_inline_size(cur_size);
> @@ -297,12 +298,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  		btrfs_set_file_extent_compression(leaf, ei,
>  						  compress_type);
>  	} else {
> -		page = find_get_page(inode->i_mapping,
> -				     start >> PAGE_SHIFT);
> +		page = find_get_page(inode->i_mapping, 0);
>  		btrfs_set_file_extent_compression(leaf, ei, 0);
>  		kaddr = kmap_atomic(page);
> -		offset = offset_in_page(start);
> -		write_extent_buffer(leaf, kaddr + offset, ptr, size);
> +		write_extent_buffer(leaf, kaddr, ptr, size);
>  		kunmap_atomic(kaddr);
>  		put_page(page);
>  	}
> @@ -313,8 +312,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  	 * We align size to sectorsize for inline extents just for simplicity
>  	 * sake.
>  	 */
> -	size = ALIGN(size, root->fs_info->sectorsize);
> -	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size);
> +	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
> +					ALIGN(size, root->fs_info->sectorsize));
>  	if (ret)
>  		goto fail;
>  
> @@ -327,7 +326,13 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  	 * before we unlock the pages.  Otherwise we
>  	 * could end up racing with unlink.
>  	 */
> -	BTRFS_I(inode)->disk_i_size = inode->i_size;
> +	i_size = i_size_read(inode);
> +	if (update_i_size && size > i_size) {
> +		i_size_write(inode, size);
> +		i_size = size;
> +	}
> +	BTRFS_I(inode)->disk_i_size = i_size;
> +
>  fail:
>  	return ret;
>  }
> @@ -338,35 +343,31 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>   * does the checks required to make sure the data is small enough
>   * to fit as an inline extent.
>   */
> -static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
> -					  u64 end, size_t compressed_size,
> +static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
> +					  size_t compressed_size,
>  					  int compress_type,
> -					  struct page **compressed_pages)
> +					  struct page **compressed_pages,
> +					  bool update_i_size)
>  {
>  	struct btrfs_drop_extents_args drop_args = { 0 };
>  	struct btrfs_root *root = inode->root;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct btrfs_trans_handle *trans;
> -	u64 isize = i_size_read(&inode->vfs_inode);
> -	u64 actual_end = min(end + 1, isize);
> -	u64 inline_len = actual_end - start;
> -	u64 aligned_end = ALIGN(end, fs_info->sectorsize);
> -	u64 data_len = inline_len;
> +	u64 data_len = compressed_size ? compressed_size : size;
>  	int ret;
>  	struct btrfs_path *path;
>  
> -	if (compressed_size)
> -		data_len = compressed_size;
> -
> -	if (start > 0 ||
> -	    actual_end > fs_info->sectorsize ||
> +	/*
> +	 * We can create an inline extent if it ends at or beyond the current
> +	 * i_size, is no larger than a sector (decompressed), and the (possibly
> +	 * compressed) data fits in a leaf and the configured maximum inline
> +	 * size.
> +	 */

Urgh, just some days ago Qu was talking about how awkward it is to have
mixed extents in a file. And now, AFAIU, you are making them more likely
since now they can be created not just at the beginning of the file but
also after i_size write. While this won't be a problem in and of itself
it goes just the opposite way of us trying to shrink the possible cases
when we can have mixed extents. Qu what is your take on that?

<snip>
