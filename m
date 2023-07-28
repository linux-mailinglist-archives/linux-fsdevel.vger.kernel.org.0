Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1FE766341
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 06:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjG1Ejv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 00:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjG1Eju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB633213A;
        Thu, 27 Jul 2023 21:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6507C61FA3;
        Fri, 28 Jul 2023 04:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA33C433C7;
        Fri, 28 Jul 2023 04:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690519187;
        bh=ge89So1jb9hIs4Ley43Dd8vWKgj8VoZXcBRkaEPNd+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5myvG8JM7zyPXEC6v1cqnV2dD4SRQHFKR83TswjKWxNAaLF2Y/VOhsi8N6b3Ge5L
         pEB5OStGGq5dtgTtfsZigf5rd+Oy3xAKGlthnaK6gJaVRLx1xQR3ykotUI9FPi/ofB
         yziAP5I/aPsv3j/fhL3Q5m+Z756bx86tnUTA6xv6PDscvXZuf8Wteh4k9d9mfuXQVt
         QwgAVossrJQ/38KOyw9c54rl6hSWqnvbwCJjZaknnbTYP/OVHvAcU9yP7uL85TtOpH
         Tf3DYqS/F9yl1s+1PEXAZO9TucouiXL3OxL+CahBz25P4fw5atu3xbWQ8w0Ki9z9Ik
         3T6588u3Ow2SQ==
Date:   Thu, 27 Jul 2023 21:39:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] xfs: create a big array data structure
Message-ID: <20230728043947.GG11377@frogsfrogsfrogs>
References: <169049623563.921478.13811535720302490179.stgit@frogsfrogsfrogs>
 <169049623585.921478.14484774475907349490.stgit@frogsfrogsfrogs>
 <ZMMxu4wJYo9Iwp6m@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMMxu4wJYo9Iwp6m@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023 at 04:10:51AM +0100, Matthew Wilcox wrote:
> On Thu, Jul 27, 2023 at 03:25:35PM -0700, Darrick J. Wong wrote:
> > diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
> > index 7418d6c60056a..0b9e781840f37 100644
> > --- a/fs/xfs/scrub/trace.h
> > +++ b/fs/xfs/scrub/trace.h
> > @@ -16,6 +16,9 @@
> >  #include <linux/tracepoint.h>
> >  #include "xfs_bit.h"
> >  
> > +struct xfile;
> > +struct xfarray;
> 
> You dereference both a struct xfile and a struct xfarray.  Seems like
> you don't need these declarations?

I suppose not.

> > +/* Compute array index given an xfile offset. */
> > +static xfarray_idx_t
> > +xfarray_idx(
> > +	struct xfarray	*array,
> > +	loff_t		pos)
> > +{
> > +	if (array->obj_size_log >= 0)
> > +		return (xfarray_idx_t)pos >> array->obj_size_log;
> > +
> > +	return div_u64((xfarray_idx_t)pos, array->obj_size);
> 
> If xfarray_idx_t is smaller than an loff_t, this will truncate pos,
> which isn't what you want.

typedef uint64_t              xfarray_idx_t;

This won't be smaller than loff_t until you port Linux to 128-bit
integers in 2028.

> > +/* Compute xfile offset of array element. */
> > +static inline loff_t xfarray_pos(struct xfarray *array, xfarray_idx_t idx)
> > +{
> > +	if (array->obj_size_log >= 0)
> > +		return idx << array->obj_size_log;
> > +
> > +	return idx * array->obj_size;
> 
> Likewise, you need to promote idx to loff_t before shifting/multiplying.
> 
> > +static inline bool
> > +xfarray_is_unset(
> > +	struct xfarray	*array,
> > +	loff_t		pos)
> > +{
> > +	void		*temp = xfarray_scratch(array);
> > +	int		error;
> > +
> > +	if (array->unset_slots == 0)
> > +		return false;
> > +
> > +	error = xfile_obj_load(array->xfile, temp, array->obj_size, pos);
> > +	if (!error && xfarray_element_is_null(array, temp))
> > +		return true;
> > +
> > +	return false;
> 
> Wouldn't this be clearer as:
> 
> 	return !error && xfarray_element_is_null(array, temp);

<shrug> don't care either way.

	if (error)
		return false;
	return xfarray_element_is_null(...);

> > +int
> > +xfarray_store_anywhere(
> > +	struct xfarray	*array,
> > +	const void	*ptr)
> > +{
> > +	void		*temp = xfarray_scratch(array);
> > +	loff_t		endpos = xfarray_pos(array, array->nr);
> > +	loff_t		pos;
> > +	int		error;
> > +
> > +	/* Find an unset slot to put it in. */
> > +	for (pos = 0;
> > +	     pos < endpos && array->unset_slots > 0;
> > +	     pos += array->obj_size) {
> > +		error = xfile_obj_load(array->xfile, temp, array->obj_size,
> > +				pos);
> > +		if (error || !xfarray_element_is_null(array, temp))
> > +			continue;
> > +
> > +		error = xfile_obj_store(array->xfile, ptr, array->obj_size,
> > +				pos);
> > +		if (error)
> > +			return error;
> > +
> > +		array->unset_slots--;
> > +		return 0;
> > +	}
> 
> ... how often is this called?  This seems like it might be slow.

It's used in the refcount btree rebuilder patch, when it's trying to
stack rmaps to compute the refcount of a given extent from the number of
rmaps it's collected for that extent.

(Eventually I replace the xfarray with an indexed btree to eliminate the
linear searching, but that won't happen until the part 2 of part 1
because I decided to send only the first 51 of 209 patches.)

> > +	/*
> > +	 * Call SEEK_DATA on the last byte in the record we're about to read.
> > +	 * If the record ends at (or crosses) the end of a page then we know
> > +	 * that the first byte of the record is backed by pages and don't need
> > +	 * to query it.  If instead the record begins at the start of the page
> > +	 * then we know that querying the last byte is just as good as querying
> > +	 * the first byte, since records cannot be larger than a page.
> > +	 *
> > +	 * If the call returns the same file offset, we know this record is
> > +	 * backed by real pages.  We do not need to move the cursor.
> > +	 */
> 
> Clever.
> 
> > +ssize_t
> > +xfile_pread(
> > +	struct xfile		*xf,
> > +	void			*buf,
> > +	size_t			count,
> > +	loff_t			pos)
> > +{
> > +	struct inode		*inode = file_inode(xf->file);
> > +	struct address_space	*mapping = inode->i_mapping;
> > +	struct page		*page = NULL;
> > +	ssize_t			read = 0;
> > +	unsigned int		pflags;
> > +	int			error = 0;
> > +
> > +	if (count > MAX_RW_COUNT)
> > +		return -E2BIG;
> > +	if (inode->i_sb->s_maxbytes - pos < count)
> > +		return -EFBIG;
> > +
> > +	trace_xfile_pread(xf, pos, count);
> > +
> > +	pflags = memalloc_nofs_save();
> 
> Should we be calling this here, or should this be done by the caller?
> Presumably it's the current caller that can't stand reclaim starting?

Well... here's the thing -- scrub already does this by attaching a
(sometimes empty) transaction to the scrub context.  In the context of
"xfile as an xscrub infrastructure", it's unnecessary.

OTOH in the context of "xfile as something that may some day end up a
general kernel tool", I don't think we want an xfile access to recurse
into filesystems.

> > +	while (count > 0) {
> > +		void		*p, *kaddr;
> > +		unsigned int	len;
> > +
> > +		len = min_t(ssize_t, count, PAGE_SIZE - offset_in_page(pos));
> > +
> > +		/*
> > +		 * In-kernel reads of a shmem file cause it to allocate a page
> > +		 * if the mapping shows a hole.  Therefore, if we hit ENOMEM
> > +		 * we can continue by zeroing the caller's buffer.
> > +		 */
> > +		page = shmem_read_mapping_page_gfp(mapping, pos >> PAGE_SHIFT,
> > +				__GFP_NOWARN);
> 
> I'm kind of hoping to transition to shmem_read_folio_gfp(), but that
> doesn't have to happen before this gets merged.

<nod> I haven't figured out if we care about large folios for xfiles
yet.  Scrub data is supposed to be ephemeral so it likely won't care,
but I can imagine longer term uses for xfiles that might actually have
an opinion.

> > +ssize_t
> > +xfile_pwrite(
> > +	struct xfile		*xf,
> > +	const void		*buf,
> > +	size_t			count,
> > +	loff_t			pos)
> > +{
> > +	struct inode		*inode = file_inode(xf->file);
> > +	struct address_space	*mapping = inode->i_mapping;
> 
> I wonder if this shoudn't be xf->file->f_mapping?

<shrug> What's the difference for a tmpfs file?

--D
