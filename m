Return-Path: <linux-fsdevel+bounces-74066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCCED2DFAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 696B2309282B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 08:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782BF2FFF99;
	Fri, 16 Jan 2026 08:24:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE72F747F;
	Fri, 16 Jan 2026 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551840; cv=none; b=fx7KIk6DOjdBIu5tjYvspo8RbypK+SzcehkIr1Ok+fEy0YUBJYl5YpEfXhcFfVRGPxWNwpU9xlN5tgr0DxFuopX+wanAGoqmW43KU6OF/L1T5t7Vj2q8KQc1Xv6bdNTJIqLvV8zRWBQUNLo558XSB6ZQFTA9HSriDOBR5AAzfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551840; c=relaxed/simple;
	bh=r5ExPMtr+AMji138aOPKWg/xk7Z4I3U4l5jSoloO00U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9lJF5ZzHk8LGkGFced5Kc32sAPQrSdfKH45aIEsIGaCd7T7ZXTL6wCcuz22e04bdB96QEQRyLTok8UC6kedZwU/H7vtgr2apuYJx1erKlUQJeEwy4F99vk99JxSp9fm4hP9eR36iFATPuHukZC89iFr5TyaC7vd3JVTUc8y5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B28E0227A8E; Fri, 16 Jan 2026 09:23:52 +0100 (CET)
Date: Fri, 16 Jan 2026 09:23:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v5 02/14] ntfs: update in-memory, on-disk structures
 and headers
Message-ID: <20260116082352.GB15119@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-3-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-3-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 11, 2026 at 11:03:32PM +0900, Namjae Jeon wrote:
> This updates in-memory, on-disk structures, headers and documentation.

A little bit of a description of what is updated would be very
useful.  In fact to review all of the patches except for the first
and the last three would probably easier at least as far as the actual
code is concerned (documentation makes sence to be standalone obviously).

Anyway, I'll chime in here with a few random bits, mostly cosmetic:

> +The new ntfs is an implementation that supports write and the current
> +trends(iomap, no buffer-head) based on read-only classic NTFS.
> 
> +The old read-only ntfs code is much cleaner, with extensive comments,
> +offers readability that makes understanding NTFS easier.
> +The target is to provide current trends(iomap, no buffer head, folio),
> +enhanced performance, stable maintenance, utility support including fsck.

All of this makes sense in a commit message, but not really in persistent
documentation, where all of this, including the "new" gets stale very
quickly.  Also please add a whitespace before the opening brace.

> +- Write support:
> +   Implement write support on classic read-only NTFS. Additionally,
> +   integrate delayed allocation to enhance write performance through
> +   multi-cluster allocation and minimized fragmentation of cluster bitmap.

I'd drop the comparisons with classic NTFS, future readers will barely
have any idea what this is about.

> +
> +- Switch to using iomap:
> +   Use iomap for buffered IO writes, reads, direct IO, file extent mapping,
> +   readpages, writepages operations.
> +
> +- Stop using the buffer head:
> +   The use of buffer head in old ntfs and switched to use folio instead.
> +   As a result, CONFIG_BUFFER_HEAD option enable is removed in Kconfig.
> +
> +- Performance Enhancements:
> +  write, file list browsing, mount performance are improved with
> +  the following.

...

> +- Stability improvement:

...

Similarly, all this is commit message information, not really
for persistent documentation in the source tree.

> - * attrib.h - Defines for attribute handling in NTFS Linux kernel driver.
> - *	      Part of the Linux-NTFS project.
> + * Defines for attribute handling in NTFS Linux kernel driver.
> + * Part of the Linux-NTFS project.

Does the Linux-NTFS project still exists, and in what form is this
part of it?  Sorry for the sneaky question, but that statement feels
a bit weird here.

>   *
>   * Set @count bits starting at bit @start_bit in the bitmap described by the
>   * vfs inode @vi to @value, where @value is either 0 or 1.
> - *
> - * Return 0 on success and -errno on error.
>   */

Any reason for dropping these Return documentations?  From a quick
looks the remove statements still seen to be correct with your
entire series applied.

> +	struct runlist runlist;	/*
> +				 * If state has the NI_NonResident bit set,
> +				 * the runlist of the unnamed data attribute
> +				 * (if a file) or of the index allocation
> +				 * attribute (directory) or of the attribute
> +				 * described by the fake inode (if NInoAttr()).
> +				 * If runlist.rl is NULL, the runlist has not
> +				 * been read in yet or has been unmapped. If
> +				 * NI_NonResident is clear, the attribute is
> +				 * resident (file and fake inode) or there is
> +				 * no $I30 index allocation attribute
> +				 * (small directory). In the latter case
> +				 * runlist.rl is always NULL.
> +				 */

Maybe it's just be, but I think if you write this detailed comments
for fields in a structure, move them above so that you get a lot more
screen real estate and make it more readable.  The same applies
to a lot of places in thee series, and also to bit definitions
(i.e. the NI_* bits very close in the patch here).

>  /*
>   * The full structure containing a ntfs_inode and a vfs struct inode. Used for
>   * all real and fake inodes but not for extent inodes which lack the vfs struct
>   * inode.
>   */
> -typedef struct {
> -	ntfs_inode ntfs_inode;
> +struct big_ntfs_inode {
> +	struct ntfs_inode ntfs_inode;
>  	struct inode vfs_inode;		/* The vfs inode structure. */
> -} big_ntfs_inode;
> +};

It seem like big_ntfs_inode is literally only used in the conversion
helpers below.  Are there are a lot of these "extent inode" so that
not having the vfs inode for them is an actual saving?

(Not an action item for getting this merged, just thinking out loud).

>  /**
>   * NTFS_I - return the ntfs inode given a vfs inode
> @@ -223,22 +269,18 @@ typedef struct {
>   *
>   * NTFS_I() returns the ntfs inode associated with the VFS @inode.
>   */
> -static inline ntfs_inode *NTFS_I(struct inode *inode)
> +static inline struct ntfs_inode *NTFS_I(struct inode *inode)
>  {
> -	return (ntfs_inode *)container_of(inode, big_ntfs_inode, vfs_inode);
> +	return (struct ntfs_inode *)container_of(inode, struct big_ntfs_inode, vfs_inode);

Both the old and new version here aren't good.  Instead of the casts
just dereference the ntfs_inode field in the big_inode:

	return container_of(inode, struct ntfs_big_inode, vfs_inode)->ntfs_inode;

> -static inline struct inode *VFS_I(ntfs_inode *ni)
> +static inline struct inode *VFS_I(struct ntfs_inode *ni)
>  {
> -	return &((big_ntfs_inode *)ni)->vfs_inode;
> +	return &((struct big_ntfs_inode *)ni)->vfs_inode;

Same here, please don't cast:

	return container_of(ni, struct ntfs_big_inode, ntfs_inode)->vf_inode;


>  static inline void *__ntfs_malloc(unsigned long size, gfp_t gfp_mask)
>  {
>  	if (likely(size <= PAGE_SIZE)) {
> -		BUG_ON(!size);
> +		if (!size)
> +			return NULL;
>  		/* kmalloc() has per-CPU caches so is faster for now. */
> -		return kmalloc(PAGE_SIZE, gfp_mask & ~__GFP_HIGHMEM);
> +		return kmalloc(PAGE_SIZE, gfp_mask);
>  		/* return (void *)__get_free_page(gfp_mask); */
>  	}
>  	if (likely((size >> PAGE_SHIFT) < totalram_pages()))
> @@ -49,7 +50,7 @@ static inline void *__ntfs_malloc(unsigned long size, gfp_t gfp_mask)
>   */
>  static inline void *ntfs_malloc_nofs(unsigned long size)
>  {
> -	return __ntfs_malloc(size, GFP_NOFS | __GFP_HIGHMEM);
> +	return __ntfs_malloc(size, GFP_NOFS | __GFP_ZERO);
>  }

This whole ntfs_malloc machinery is pretty outdata in many ways.
I think you're better implementing is using kvmalloc and friends,
and using the _nofs scope where needed.

> +static inline void *ntfs_realloc_nofs(void *addr, unsigned long new_size,
> +		unsigned long cpy_size)

... and kvrealloc here.

> +#define NTFS_DEF_PREALLOC_SIZE		(64*1024*1024)
> +
> +#define STANDARD_COMPRESSION_UNIT	4
> +#define MAX_COMPRESSION_CLUSTER_SIZE 4096

Please throw in comments explaining these magic constants.

> +#define UCHAR_T_SIZE_BITS 1

Why not use sizeof(unsigned char) in the one place using it?

> +#define NTFS_B_TO_CLU(vol, b) ((b) >> (vol)->cluster_size_bits)
> +#define NTFS_CLU_TO_B(vol, clu) ((u64)(clu) << (vol)->cluster_size_bits)
> +#define NTFS_B_TO_CLU_OFS(vol, clu) ((u64)(clu) & (vol)->cluster_size_mask)
> +
> +#define NTFS_MFT_NR_TO_CLU(vol, mft_no) (((u64)mft_no << (vol)->mft_record_size_bits) >> \
> +					 (vol)->cluster_size_bits)
> +#define NTFS_MFT_NR_TO_PIDX(vol, mft_no) (mft_no >> (PAGE_SHIFT - \
> +					  (vol)->mft_record_size_bits))
> +#define NTFS_MFT_NR_TO_POFS(vol, mft_no) (((u64)mft_no << (vol)->mft_record_size_bits) & \
> +					  ~PAGE_MASK)

A lot of this is pretty unreadable.  At least break the line after
the macro definition, e.g.:

#define NTFS_MFT_NR_TO_POFS(vol, mft_no) \
	(((u64)mft_no << (vol)->mft_record_size_bits) & \ ~PAGE_MASK)

But inline functions with proper typing would help a lot.  As would
comments explaining what this does given the not very descriptive
names.

> +/*
> + * ntfs-specific ioctl commands
> + */
> +#define NTFS_IOC_SHUTDOWN _IOR('X', 125, __u32)

This isn't really NTFS-specific, but really something originating
in XFS and then copied to half a dozen file systems.  Maybe start
adding it to uapi/linux/fs.h as a start, and then we'll slowly
migrate the other file system over to it?


