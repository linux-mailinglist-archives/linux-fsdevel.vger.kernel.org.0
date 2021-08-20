Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6193F32D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 20:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhHTSL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhHTSLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:11:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE406C061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 11:11:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bo18so7939067pjb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V5r0QBB3dH/OiX2kiIw1xmcLlB44IKRIoxKY/IbkIRc=;
        b=hO0R24oRUfX7HKsGgjaLXtOYFKth5/VwPHNvi6tBtj0DqIjyMnHUbvw+d0MxCQREb5
         ugF93aCdSCv7M9MSg2/KCEfN5tfK7u6q4cfxOP6KOSG9rG2FUGoPnq3HgVGLC7QhsmXU
         zCKzqVhy5J9DvlFq8Tj6KTpu/2J5YfYIa+2rAhFDCA4thtnruuArm+wo0PbszDBzCuJL
         CcaZq2JdTxox3kCvC7HNMiPnjnkxvogeCZJhumYKwM6+YyKuGLx3jeK4S6UbqbKA/a7M
         aJcsSuLs/c2zkC++TueHa85ms3HjLkR0vYKzEw/smK2txdK31F6UxP9rKLLq0a8xWojX
         +HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V5r0QBB3dH/OiX2kiIw1xmcLlB44IKRIoxKY/IbkIRc=;
        b=hB7tH1PQl9IxUgWaGefB9MSkGPqPHxvIjMJsCJjYQreSuMU+0ed37d6QO9u/7MGq/o
         cXiTO1PuPb0g1HjpzR5j2YS+jtJ9khOsXodsNFMC2txLo7GsjCy29X1dUvoxXmXz6bha
         l0PRw+wpsHrFEqzpy8WtU7lrq/YZcE126QAR6XZN8iO1p8gw3BAeO6SyrqVhf2LxHG7r
         PvR5VSM2WviNvI8MJEa0oWxTTSyBgJwZxxuTqnlL+5HP0ZQPOJu9XgpjM+FxMMmCCLjI
         GTCRMpiBcLNghp5NpbeQWGwiqVLTrWgxe+MJ4N164ncNofa7l1B88EqMBLRm0JN9pcRU
         dFgg==
X-Gm-Message-State: AOAM530Su9/5MN9A77rnbr1HrurOnwRasIMq4QJg6Ma8rOeOF1fHUhr4
        57xXJbugAnib67+DPNhvE7JHRQ==
X-Google-Smtp-Source: ABdhPJxWQOhci2cPJ0qbqpQ1FjpkM5lBLdHQ9WkZkJ3a7YWA5WiNmDOr/8mxCegSDQ1PhLs8q2lf9Q==
X-Received: by 2002:a17:902:b487:b029:12c:4051:a8de with SMTP id y7-20020a170902b487b029012c4051a8demr17415766plr.76.1629483074409;
        Fri, 20 Aug 2021 11:11:14 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:4387])
        by smtp.gmail.com with ESMTPSA id d15sm8983194pgj.84.2021.08.20.11.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 11:11:13 -0700 (PDT)
Date:   Fri, 20 Aug 2021 11:11:12 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v10 06/14] btrfs: optionally extend i_size in
 cow_file_range_inline()
Message-ID: <YR/wQPJcv25vPIp7@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <a00b59623219c8a07f2c22f80ef1466d0f182d77.1629234193.git.osandov@fb.com>
 <1b495420-f4c6-6988-c0b1-9aa8a7aa952d@suse.com>
 <2eae3b11-d9aa-42b1-122e-49bd40258d9b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2eae3b11-d9aa-42b1-122e-49bd40258d9b@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 05:13:34PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/20 下午4:51, Nikolay Borisov wrote:
> > 
> > 
> > On 18.08.21 г. 0:06, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > Currently, an inline extent is always created after i_size is extended
> > > from btrfs_dirty_pages(). However, for encoded writes, we only want to
> > > update i_size after we successfully created the inline extent.
> 
> To me, the idea of write first then update isize is just going to cause
> tons of inline extent related prblems.
> 
> The current example is falloc, which only update the isize after the
> falloc finishes.
> 
> This behavior has already bothered me quite a lot, as it can easily
> create mixed inline and regular extents.

Do you have an example of how this would happen? I have the inode and
extent bits locked during an encoded write, and I see that fallocate
does the same.

> Can't we remember the old isize (with proper locking), enlarge isize
> (with holes filled), do the write.
> 
> If something wrong happened, we truncate the isize back to its old isize.
> 
> > > Add an
> > > update_i_size parameter to cow_file_range_inline() and
> > > insert_inline_extent() and pass in the size of the extent rather than
> > > determining it from i_size. Since the start parameter is always passed
> > > as 0, get rid of it and simplify the logic in these two functions. While
> > > we're here, let's document the requirements for creating an inline
> > > extent.
> > > 
> > > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >   fs/btrfs/inode.c | 100 +++++++++++++++++++++++------------------------
> > >   1 file changed, 48 insertions(+), 52 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index 708d8ab098bc..0b5ff14aa7fd 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -236,9 +236,10 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
> > >   static int insert_inline_extent(struct btrfs_trans_handle *trans,
> > >   				struct btrfs_path *path, bool extent_inserted,
> > >   				struct btrfs_root *root, struct inode *inode,
> > > -				u64 start, size_t size, size_t compressed_size,
> > > +				size_t size, size_t compressed_size,
> > >   				int compress_type,
> > > -				struct page **compressed_pages)
> > > +				struct page **compressed_pages,
> > > +				bool update_i_size)
> > >   {
> > >   	struct extent_buffer *leaf;
> > >   	struct page *page = NULL;
> > > @@ -247,7 +248,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
> > >   	struct btrfs_file_extent_item *ei;
> > >   	int ret;
> > >   	size_t cur_size = size;
> > > -	unsigned long offset;
> > > +	u64 i_size;
> > > 
> > >   	ASSERT((compressed_size > 0 && compressed_pages) ||
> > >   	       (compressed_size == 0 && !compressed_pages));
> > > @@ -260,7 +261,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
> > >   		size_t datasize;
> > > 
> > >   		key.objectid = btrfs_ino(BTRFS_I(inode));
> > > -		key.offset = start;
> > > +		key.offset = 0;
> > >   		key.type = BTRFS_EXTENT_DATA_KEY;
> > > 
> > >   		datasize = btrfs_file_extent_calc_inline_size(cur_size);
> > > @@ -297,12 +298,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
> > >   		btrfs_set_file_extent_compression(leaf, ei,
> > >   						  compress_type);
> > >   	} else {
> > > -		page = find_get_page(inode->i_mapping,
> > > -				     start >> PAGE_SHIFT);
> > > +		page = find_get_page(inode->i_mapping, 0);
> > >   		btrfs_set_file_extent_compression(leaf, ei, 0);
> > >   		kaddr = kmap_atomic(page);
> > > -		offset = offset_in_page(start);
> > > -		write_extent_buffer(leaf, kaddr + offset, ptr, size);
> > > +		write_extent_buffer(leaf, kaddr, ptr, size);
> > >   		kunmap_atomic(kaddr);
> > >   		put_page(page);
> > >   	}
> > > @@ -313,8 +312,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
> > >   	 * We align size to sectorsize for inline extents just for simplicity
> > >   	 * sake.
> > >   	 */
> > > -	size = ALIGN(size, root->fs_info->sectorsize);
> > > -	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size);
> > > +	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
> > > +					ALIGN(size, root->fs_info->sectorsize));
> > >   	if (ret)
> > >   		goto fail;
> > > 
> > > @@ -327,7 +326,13 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
> > >   	 * before we unlock the pages.  Otherwise we
> > >   	 * could end up racing with unlink.
> > >   	 */
> > > -	BTRFS_I(inode)->disk_i_size = inode->i_size;
> > > +	i_size = i_size_read(inode);
> > > +	if (update_i_size && size > i_size) {
> > > +		i_size_write(inode, size);
> > > +		i_size = size;
> > > +	}
> > > +	BTRFS_I(inode)->disk_i_size = i_size;
> > > +
> > >   fail:
> > >   	return ret;
> > >   }
> > > @@ -338,35 +343,31 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
> > >    * does the checks required to make sure the data is small enough
> > >    * to fit as an inline extent.
> > >    */
> > > -static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
> > > -					  u64 end, size_t compressed_size,
> > > +static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
> > > +					  size_t compressed_size,
> > >   					  int compress_type,
> > > -					  struct page **compressed_pages)
> > > +					  struct page **compressed_pages,
> > > +					  bool update_i_size)
> > >   {
> > >   	struct btrfs_drop_extents_args drop_args = { 0 };
> > >   	struct btrfs_root *root = inode->root;
> > >   	struct btrfs_fs_info *fs_info = root->fs_info;
> > >   	struct btrfs_trans_handle *trans;
> > > -	u64 isize = i_size_read(&inode->vfs_inode);
> > > -	u64 actual_end = min(end + 1, isize);
> > > -	u64 inline_len = actual_end - start;
> > > -	u64 aligned_end = ALIGN(end, fs_info->sectorsize);
> > > -	u64 data_len = inline_len;
> > > +	u64 data_len = compressed_size ? compressed_size : size;
> > >   	int ret;
> > >   	struct btrfs_path *path;
> > > 
> > > -	if (compressed_size)
> > > -		data_len = compressed_size;
> > > -
> > > -	if (start > 0 ||
> > > -	    actual_end > fs_info->sectorsize ||
> > > +	/*
> > > +	 * We can create an inline extent if it ends at or beyond the current
> > > +	 * i_size, is no larger than a sector (decompressed), and the (possibly
> > > +	 * compressed) data fits in a leaf and the configured maximum inline
> > > +	 * size.
> > > +	 */
> > 
> > Urgh, just some days ago Qu was talking about how awkward it is to have
> > mixed extents in a file. And now, AFAIU, you are making them more likely
> > since now they can be created not just at the beginning of the file but
> > also after i_size write. While this won't be a problem in and of itself
> > it goes just the opposite way of us trying to shrink the possible cases
> > when we can have mixed extents.
> 
> Tree-checker should reject such inline extent at non-zero offset.

This change does not allow creating inline extents at a non-zero offset.

> > Qu what is your take on that?
> 
> My question is, why encoded write needs to bother the inline extents at all?
> 
> My intuition of such encoded write is, it should not create inline
> extents at all.
> 
> Or is there any special use-case involved for encoded write?

We create compressed inline extents with normal writes. We should be
able to send and receive them without converting them into regular
extents.
