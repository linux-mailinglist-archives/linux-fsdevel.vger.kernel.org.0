Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EF6711CB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjEZBeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjEZBeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:34:36 -0400
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [IPv6:2001:41d0:203:375::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B70189
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 18:34:33 -0700 (PDT)
Date:   Thu, 25 May 2023 21:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685064871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6NBltaxcvPexbX2OhvX6CBqCLsP7PXDw7sii/NG22oc=;
        b=QlfagXEr72rtl8UdEI4zy61ZOm6SIFoBNyo79sTjBGYcDohPQbsJx2jpE7cs1wEcQuR+by
        K4e11fZLK/v3oDpJWABih8Baq/1c034L3JHCwalRSBEqhXf5UfhXBk9OPCQfd012k2/upT
        8J1ks4zi3xwwiTaABETHKisC7T/kEEE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] xfs: create a big array data structure
Message-ID: <ZHAMpeyu/KmXtRw8@moria.home.lan>
References: <168506056447.3729324.13624212283929857624.stgit@frogsfrogsfrogs>
 <168506056469.3729324.10116553858401440150.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168506056469.3729324.10116553858401440150.stgit@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 05:47:08PM -0700, Darrick J. Wong wrote:
> +struct xfarray {
> +	/* Underlying file that backs the array. */
> +	struct xfile	*xfile;
> +
> +	/* Number of array elements. */
> +	xfarray_idx_t	nr;
> +
> +	/* Maximum possible array size. */
> +	xfarray_idx_t	max_nr;
> +
> +	/* Number of unset slots in the array below @nr. */
> +	uint64_t	unset_slots;
> +
> +	/* Size of an array element. */
> +	size_t		obj_size;
> +
> +	/* log2 of array element size, if possible. */
> +	int		obj_size_log;
> +};
> +
> +int xfarray_create(struct xfs_mount *mp, const char *descr,
> +		unsigned long long required_capacity, size_t obj_size,
> +		struct xfarray **arrayp);
> +void xfarray_destroy(struct xfarray *array);
> +int xfarray_load(struct xfarray *array, xfarray_idx_t idx, void *ptr);
> +int xfarray_unset(struct xfarray *array, xfarray_idx_t idx);
> +int xfarray_store(struct xfarray *array, xfarray_idx_t idx, const void *ptr);
> +int xfarray_store_anywhere(struct xfarray *array, const void *ptr);
> +bool xfarray_element_is_null(struct xfarray *array, const void *ptr);

Nice simple external interface... +1

Since you're storing fixed size elements, if you wanted to make it
slicker you could steal the generic-radix tree approach of using a
wrapper type to make the object size known at compile time, which lets
you constant propagate through the index -> offset calculations.

But not worth it from a performance POV with the current implementation,
because...

> +/*
> + * Read a memory object directly from the xfile's page cache.  Unlike regular
> + * pread, we return -E2BIG and -EFBIG for reads that are too large or at too
> + * high an offset, instead of truncating the read.  Otherwise, we return
> + * bytes read or an error code, like regular pread.
> + */
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
> +		if (IS_ERR(page)) {
> +			error = PTR_ERR(page);
> +			if (error != -ENOMEM)
> +				break;
> +
> +			memset(buf, 0, len);
> +			goto advance;
> +		}
> +
> +		if (PageUptodate(page)) {
> +			/*
> +			 * xfile pages must never be mapped into userspace, so
> +			 * we skip the dcache flush.
> +			 */
> +			kaddr = kmap_local_page(page);
> +			p = kaddr + offset_in_page(pos);
> +			memcpy(buf, p, len);
> +			kunmap_local(kaddr);
> +		} else {
> +			memset(buf, 0, len);
> +		}
> +		put_page(page);
> +
> +advance:
> +		count -= len;
> +		pos += len;
> +		buf += len;
> +		read += len;
> +	}
> +	memalloc_nofs_restore(pflags);
> +
> +	if (read > 0)
> +		return read;
> +	return error;
> +}

this all, and the write path, looks a bit heavy - you're calling through
shmem_read_mapping_page_gfp() on every lookup. Does it matter?

If we care about performance, we want to get it as much as possible down
to just the page cache radix tree lookup - and possibly cache the last
page returned if we care about sequential performance.

OTOH, maybe shmem_get_folio_gfp() and __filemap_get_folio() could
benefit from some early returns -
	if (likely(got_the_thing_we_want)) return folio;

Another thought... if obj_size <= PAGE_SIZE, maybe you could do what
genradix does and not have objects span pages? That would let you get
rid of the loop in read/write - but then you'd want to be doing an
interface that works in terms of pages/folios, which wouldn't be as
clean as what you've got.

Just spitballing random ideas, looks good :)
