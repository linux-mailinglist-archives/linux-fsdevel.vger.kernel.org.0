Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35F042D991
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhJNM4u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 08:56:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35172 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhJNM4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:56:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3AF721A72;
        Thu, 14 Oct 2021 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634216080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOqnWQFz8SQPwRVzGa2Kx8eK/oHDX7tbm7yrVWv8p+A=;
        b=iGPTrB0pBZgG/S+nPPXTLAGmFvcudkMVj9PzCF05c6rldgJRFK7u7LvHbRpBlR/idcPO/Z
        zns+3cXd68lCBt03pctGxgtk3YBu+1rDlanqnkGycaaXBZSICUcWllz09jPmc1i8/Hsmss
        JdX3wuPDFFw8GcNNx0K4SKYzKDtg3Rk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 694E213D8D;
        Thu, 14 Oct 2021 12:54:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9LSaFpAoaGGhSgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Oct 2021 12:54:40 +0000
Subject: Re: [PATCH v11 06/14] btrfs: optionally extend i_size in
 cow_file_range_inline()
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <cover.1630514529.git.osandov@fb.com>
 <54ad4e1fe7d6c4dce4a87fd4f22de3a7b197d13b.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c8917715-54e9-7675-4c58-c91324cdb87f@suse.com>
Date:   Thu, 14 Oct 2021 15:54:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <54ad4e1fe7d6c4dce4a87fd4f22de3a7b197d13b.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
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


Overall I like where this is going, actually the diff is larger than it
should be because some refactoring is tucked in. If there would be yet
another submission with more substantial changes I'd like to see this
patch split into 2:

1. Patch does the refactoring

2. Adds the logic to update i_size alongside the addition of the
update_i_size parameter.

That will make the functional change a lot more obvious.

> ---
>  fs/btrfs/inode.c | 100 +++++++++++++++++++++++------------------------
>  1 file changed, 48 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6aad4b641d5c..a87a34f56234 100644
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

This function grows to 10 parameters, I think it's high time it took an
argument struct and each member can in turn be documented in this
structure,  otherwise it's very unwieldy to work with.

>  {
>  	struct extent_buffer *leaf;
>  	struct page *page = NULL;

<snip>


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

This function also has 6 parameters which is not on the extreme but I
have a feeling it also needs to be refactored to take an argument
structure.

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
> +	if (size < i_size_read(&inode->vfs_inode) ||
> +	    size > fs_info->sectorsize ||
>  	    data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
> -	    (!compressed_size &&
> -	    (actual_end & (fs_info->sectorsize - 1)) == 0) ||
> -	    end + 1 < isize ||
> -	    data_len > fs_info->max_inline) {
> +	    data_len > fs_info->max_inline)
>  		return 1;

With this change you allow to write more than PAGE_SIZE data in case of
a compressed extents, Qu said he had some concerns regarding this. I'm
CCing him so this can be discussed on this submission.

> -	}
>  
>  	path = btrfs_alloc_path();
>  	if (!path)

<snip>
