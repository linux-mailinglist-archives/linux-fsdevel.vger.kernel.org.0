Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5776624C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 05:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjG1DLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 23:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjG1DLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:11:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84B9F3;
        Thu, 27 Jul 2023 20:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fR84h0xmQTbhhUm+zLcjqHD9kr8sZmMgJwmtk5SSV9Y=; b=XqUaO/MIQzXRAjNcGKGTQRQYBa
        L9AcV2VX/oNoHkskKqQI3S3FrqgH2qqif/I7veW7uJ2gH9zrKAx6rr+1xapshIh1naEPtUbVpEa3Z
        QwyOQ6piFxa9bHOvpKr/WVPkj53yHT/g0Gn+7EKc+jZSEBM50M85MbFCu5UWp9P97rCSjAEo1D0Ce
        M63tFuilmQTvZN9mxZxNXwa2W7rAHrXue81iK9XdC59tYZIGK3vmxmPJghCKH0CU9xfTplfgrIlSC
        47pPZM/vZmSMaPkhpJxRWi3JQYOfZVRyqDho7Zn/SVVo4nZuKhQZOjn95dpJxn4v9r2nK4F6u7KN9
        V5qxAXEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPDsR-0087p5-IY; Fri, 28 Jul 2023 03:10:51 +0000
Date:   Fri, 28 Jul 2023 04:10:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] xfs: create a big array data structure
Message-ID: <ZMMxu4wJYo9Iwp6m@casper.infradead.org>
References: <169049623563.921478.13811535720302490179.stgit@frogsfrogsfrogs>
 <169049623585.921478.14484774475907349490.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169049623585.921478.14484774475907349490.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:25:35PM -0700, Darrick J. Wong wrote:
> diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
> index 7418d6c60056a..0b9e781840f37 100644
> --- a/fs/xfs/scrub/trace.h
> +++ b/fs/xfs/scrub/trace.h
> @@ -16,6 +16,9 @@
>  #include <linux/tracepoint.h>
>  #include "xfs_bit.h"
>  
> +struct xfile;
> +struct xfarray;

You dereference both a struct xfile and a struct xfarray.  Seems like
you don't need these declarations?

> +/* Compute array index given an xfile offset. */
> +static xfarray_idx_t
> +xfarray_idx(
> +	struct xfarray	*array,
> +	loff_t		pos)
> +{
> +	if (array->obj_size_log >= 0)
> +		return (xfarray_idx_t)pos >> array->obj_size_log;
> +
> +	return div_u64((xfarray_idx_t)pos, array->obj_size);

If xfarray_idx_t is smaller than an loff_t, this will truncate pos,
which isn't what you want.

> +/* Compute xfile offset of array element. */
> +static inline loff_t xfarray_pos(struct xfarray *array, xfarray_idx_t idx)
> +{
> +	if (array->obj_size_log >= 0)
> +		return idx << array->obj_size_log;
> +
> +	return idx * array->obj_size;

Likewise, you need to promote idx to loff_t before shifting/multiplying.

> +static inline bool
> +xfarray_is_unset(
> +	struct xfarray	*array,
> +	loff_t		pos)
> +{
> +	void		*temp = xfarray_scratch(array);
> +	int		error;
> +
> +	if (array->unset_slots == 0)
> +		return false;
> +
> +	error = xfile_obj_load(array->xfile, temp, array->obj_size, pos);
> +	if (!error && xfarray_element_is_null(array, temp))
> +		return true;
> +
> +	return false;

Wouldn't this be clearer as:

	return !error && xfarray_element_is_null(array, temp);

> +int
> +xfarray_store_anywhere(
> +	struct xfarray	*array,
> +	const void	*ptr)
> +{
> +	void		*temp = xfarray_scratch(array);
> +	loff_t		endpos = xfarray_pos(array, array->nr);
> +	loff_t		pos;
> +	int		error;
> +
> +	/* Find an unset slot to put it in. */
> +	for (pos = 0;
> +	     pos < endpos && array->unset_slots > 0;
> +	     pos += array->obj_size) {
> +		error = xfile_obj_load(array->xfile, temp, array->obj_size,
> +				pos);
> +		if (error || !xfarray_element_is_null(array, temp))
> +			continue;
> +
> +		error = xfile_obj_store(array->xfile, ptr, array->obj_size,
> +				pos);
> +		if (error)
> +			return error;
> +
> +		array->unset_slots--;
> +		return 0;
> +	}

... how often is this called?  This seems like it might be slow.

> +	/*
> +	 * Call SEEK_DATA on the last byte in the record we're about to read.
> +	 * If the record ends at (or crosses) the end of a page then we know
> +	 * that the first byte of the record is backed by pages and don't need
> +	 * to query it.  If instead the record begins at the start of the page
> +	 * then we know that querying the last byte is just as good as querying
> +	 * the first byte, since records cannot be larger than a page.
> +	 *
> +	 * If the call returns the same file offset, we know this record is
> +	 * backed by real pages.  We do not need to move the cursor.
> +	 */

Clever.

> +ssize_t
> +xfile_pread(
> +	struct xfile		*xf,
> +	void			*buf,
> +	size_t			count,
> +	loff_t			pos)
> +{
> +	struct inode		*inode = file_inode(xf->file);
> +	struct address_space	*mapping = inode->i_mapping;
> +	struct page		*page = NULL;
> +	ssize_t			read = 0;
> +	unsigned int		pflags;
> +	int			error = 0;
> +
> +	if (count > MAX_RW_COUNT)
> +		return -E2BIG;
> +	if (inode->i_sb->s_maxbytes - pos < count)
> +		return -EFBIG;
> +
> +	trace_xfile_pread(xf, pos, count);
> +
> +	pflags = memalloc_nofs_save();

Should we be calling this here, or should this be done by the caller?
Presumably it's the current caller that can't stand reclaim starting?

> +	while (count > 0) {
> +		void		*p, *kaddr;
> +		unsigned int	len;
> +
> +		len = min_t(ssize_t, count, PAGE_SIZE - offset_in_page(pos));
> +
> +		/*
> +		 * In-kernel reads of a shmem file cause it to allocate a page
> +		 * if the mapping shows a hole.  Therefore, if we hit ENOMEM
> +		 * we can continue by zeroing the caller's buffer.
> +		 */
> +		page = shmem_read_mapping_page_gfp(mapping, pos >> PAGE_SHIFT,
> +				__GFP_NOWARN);

I'm kind of hoping to transition to shmem_read_folio_gfp(), but that
doesn't have to happen before this gets merged.

> +ssize_t
> +xfile_pwrite(
> +	struct xfile		*xf,
> +	const void		*buf,
> +	size_t			count,
> +	loff_t			pos)
> +{
> +	struct inode		*inode = file_inode(xf->file);
> +	struct address_space	*mapping = inode->i_mapping;

I wonder if this shoudn't be xf->file->f_mapping?

