Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6764C48D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 08:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbiLNH6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 02:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiLNH6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:58:46 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607B01DA5A
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 23:58:44 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x2so1211180plb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 23:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCJVs3JvPkJt01ise5A2DYJMouJHni1+mt8+0EsqMqg=;
        b=MCqWlZkqtFdRWiquQUWL34MEdxKfH50+pFvS2bZaG1Q9CS5H92Iuc0AiKNLlZnLFbx
         n5Y14W5fpEBYk58djgmc9QiExLqoHpFHzs0NcmvaCwbPa05xaIWbzOnS/1A5VXlvjZr3
         DZA9oy1+8osSM5uaW2yC9lPitJI+QFYF9lKE6V488eik8gaubBhIJWF7w1ANZE4+oslB
         SjHZrT8xncVuqfCujpkU1E9SiVOJQbQjjkon69aFMR7GFvAxQNSP57jqC5ARGd3vb7KV
         vp/w9v/M6Dm2XEX/AYy0EaIUkSrzRFBMNMB2VmieFOQnubnQJOiuFQrTUfYsg07TbHk0
         wwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCJVs3JvPkJt01ise5A2DYJMouJHni1+mt8+0EsqMqg=;
        b=mTv6fMp5VbflGgWLFVsBMDATSNYyPivjQvxmEh5u5FAGCfzoLnSt1Lgngcyg9fdv8I
         FGRj+3+i1uPmZeZ7PSqs+RSPHphvQRSKm2F+RrMP4V7eqc5ZDdSxSBp8peDMXcH5EY2v
         ja0h+TAYmY+xnytIb0rUCkP+iQPkpTpNXTiiZQxZVWe3T/7oCdWrrHMIPWnuCq2ao93w
         H8RKd+nq3k9BoydkbW3EqJ6OWksi+ilpPsgsTnYSSmijedrCr3YxyZ5V5Uhg9NleWGPN
         fURhe7LcOwL3rqF2P3xpf/r8AQg7LHaKizDOsE8mcPsi0PMP+ictAsWPqinY2bl4b3Fw
         f6Wg==
X-Gm-Message-State: AFqh2krhocp/fQZb1v8jiBYT7bTlhqfL00GglF4feGZf4FcJQJnQpPFe
        1zsLYR4N6A7I8ND1Hhl6dhEvTHYhUohN0vca
X-Google-Smtp-Source: AMrXdXvuCSAHzKYEsH52/u1/pH8iXPBR3SzbZOHekHVCSxV+jjTwYctOkpqJEIMPJgTHMF2YiVLnXQ==
X-Received: by 2002:a17:902:ef89:b0:190:dcdd:edcb with SMTP id iz9-20020a170902ef8900b00190dcddedcbmr3620039plb.56.1671004723646;
        Tue, 13 Dec 2022 23:58:43 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709027e8100b00188f7ad561asm1149893pla.249.2022.12.13.23.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 23:58:43 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5Mf1-008Geu-6H; Wed, 14 Dec 2022 18:58:39 +1100
Date:   Wed, 14 Dec 2022 18:58:39 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] xfs: add fs-verity support
Message-ID: <20221214075839.GJ3600936@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-11-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213172935.680971-11-aalbersh@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:29:34PM +0100, Andrey Albershteyn wrote:
> Add integration with fs-verity. The XFS store fs-verity metadata in
> the extended attributes. The metadata consist of verity descriptor
> and Merkle tree pages.
> 
> The descriptor is stored under "verity_descriptor" extended
> attribute. The Merkle tree pages are stored under binary indexes.
> 
> When fs-verity is enabled on an inode, the XFS_IVERITY flag is set
> meaning that the Merkle tree is being build. Then, pagecache is
> flushed and large folios are disabled as these aren't yet supported
> by fs-verity. This is done in xfs_begin_enable_verity() to make sure
> that fs-verity operations on the inode don't populate cache with
> large folios during a tree build. The initialization ends with
> storing of verity descriptor and setting inode on-disk flag
> (XFS_DIFLAG2_VERITY).
> 
> Also add check that block size == PAGE_SIZE as fs-verity doesn't
> support different sizes yet.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/Makefile          |   1 +
>  fs/xfs/libxfs/xfs_attr.c |   8 ++
>  fs/xfs/xfs_inode.h       |   1 +
>  fs/xfs/xfs_super.c       |  10 ++
>  fs/xfs/xfs_verity.c      | 203 +++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_verity.h      |  19 ++++
>  6 files changed, 242 insertions(+)
>  create mode 100644 fs/xfs/xfs_verity.c
>  create mode 100644 fs/xfs/xfs_verity.h
> 
> diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> index 42d0496fdad7d..5afa8ae5b3b7f 100644
> --- a/fs/xfs/Makefile
> +++ b/fs/xfs/Makefile
> @@ -131,6 +131,7 @@ xfs-$(CONFIG_XFS_POSIX_ACL)	+= xfs_acl.o
>  xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
>  xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
>  xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
> +xfs-$(CONFIG_FS_VERITY)		+= xfs_verity.o
>  
>  # notify failure
>  ifeq ($(CONFIG_MEMORY_FAILURE),y)
> diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
> index 57080ea4c869b..42013fc99b76a 100644
> --- a/fs/xfs/libxfs/xfs_attr.c
> +++ b/fs/xfs/libxfs/xfs_attr.c
> @@ -26,6 +26,7 @@
>  #include "xfs_trace.h"
>  #include "xfs_attr_item.h"
>  #include "xfs_xattr.h"
> +#include "xfs_verity.h"
>  
>  struct kmem_cache		*xfs_attr_intent_cache;
>  
> @@ -1632,6 +1633,13 @@ xfs_attr_namecheck(
>  		return xfs_verify_pptr(mp, (struct xfs_parent_name_rec *)name);
>  	}
>  
> +	if (flags & XFS_ATTR_VERITY) {
> +		if (length != sizeof(__be64) &&
> +				length != XFS_VERITY_DESCRIPTOR_NAME_LEN)

This needs a comment describing what it is checking as it is not
obvious from reading the code. I can grok what the
XFS_VERITY_DESCRIPTOR_NAME_LEN check is about, but the sizeof()
check is not obvious.

I also suspect it is also better to explicitly check for valid
values rather than invalid values. i.e.

		/* describe what name is 8 bytes in length */
		if (length == sizeof(__be64))
			return true;
		/* Verity descriptor blocks are held in a named attribute. */
		if (length == XFS_VERITY_DESCRIPTOR_NAME_LEN)
			return true;
		/* Not a valid verity attribute name length */
		return false.


> +			return false;
> +		return true;
> +	}
> +
>  	return xfs_str_attr_namecheck(name, length);
>  }
>  
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 5735de32beebd..070631adac572 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -325,6 +325,7 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
>   * plain old IRECLAIMABLE inode.
>   */
>  #define XFS_INACTIVATING	(1 << 13)
> +#define XFS_IVERITY		(1 << 14) /* merkle tree is in progress */

Does this flag mean the inode has verity information on it (as the
name suggests) or that the inode is currently being measured and the
merkle tree is being built (as the comment suggests)?
>  
>  /* All inode state flags related to inode reclaim. */
>  #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 50c2c819ba940..a3c89d2c06a8a 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -41,6 +41,7 @@
>  #include "xfs_attr_item.h"
>  #include "xfs_xattr.h"
>  #include "xfs_iunlink_item.h"
> +#include "xfs_verity.h"
>  
>  #include <linux/magic.h>
>  #include <linux/fs_context.h>
> @@ -1469,6 +1470,9 @@ xfs_fs_fill_super(
>  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
>  #endif
>  	sb->s_op = &xfs_super_operations;
> +#ifdef CONFIG_FS_VERITY
> +	sb->s_vop = &xfs_verity_ops;
> +#endif
>  
>  	/*
>  	 * Delay mount work if the debug hook is set. This is debug
> @@ -1669,6 +1673,12 @@ xfs_fs_fill_super(
>  		xfs_alert(mp,
>  	"EXPERIMENTAL parent pointer feature enabled. Use at your own risk!");
>  
> +	if (xfs_has_verity(mp) && mp->m_super->s_blocksize != PAGE_SIZE) {
> +		xfs_alert(mp,
> +			"Cannot use fs-verity with block size != PAGE_SIZE");
> +		goto out_filestream_unmount;
> +	}

Needs an EXPERIMENTAL warning to be emitted here, jus tlike the
parent pointer feature check above.

> +
>  	error = xfs_mountfs(mp);
>  	if (error)
>  		goto out_filestream_unmount;
> diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
> new file mode 100644
> index 0000000000000..112a72d0b0ca7
> --- /dev/null
> +++ b/fs/xfs/xfs_verity.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Red Hat, Inc.
> + */
> +#include "xfs.h"
> +#include "xfs_shared.h"
> +#include "xfs_format.h"
> +#include "xfs_da_format.h"
> +#include "xfs_da_btree.h"
> +#include "xfs_trans_resv.h"
> +#include "xfs_mount.h"
> +#include "xfs_inode.h"
> +#include "xfs_attr.h"
> +#include "xfs_verity.h"
> +#include "xfs_bmap_util.h"
> +#include "xfs_log_format.h"
> +#include "xfs_trans.h"
> +
> +static int
> +xfs_get_verity_descriptor(
> +	struct inode		*inode,
> +	void			*buf,
> +	size_t			buf_size)

So what is the API being implemented here? It passes in a NULL *buf
and buf_size = 0 to query the size of the verity descriptor?

And then allocates a buffer the size returned and calls again with
*buf of the right size and buf_size = the right size?

> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	int			error = 0;
> +	struct xfs_da_args	args = {
> +		.dp		= ip,
> +		.attr_filter	= XFS_ATTR_VERITY,
> +		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
> +		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
> +		.valuelen	= buf_size,
> +	};
> +
> +	error = xfs_attr_get(&args);
> +	if (error)
> +		return error;
> +
> +	if (buf_size == 0)
> +		return args.valuelen;
> +
> +	if (args.valuelen > buf_size) {
> +		kmem_free(args.value);
> +		return -ERANGE;
> +	}

Ok, this won't happen. If the provided value length (buf_size) is
smaller than the attribute value length found, xfs_attr_copy_value()
will return -ERANGE and set args.valuelen to the actual attribute
size found. That will be caught by the initial error return, so
you would never have noticed the kmem_free(NULL) call here.

xfs_attr_copy_value() deals with attributes both larger and smaller
than the provided buffer correctly.

> +	memcpy(buf, args.value, buf_size);

However, this will overrun the allocated args.value buffer if the
attribute that was found is smaller than buf_size - the actual
length of the attribute value that is copied is written into
args.valuelen and it may be less than the size of the buffer
supplied....

> +
> +	kmem_free(args.value);
> +	return args.valuelen;
> +}

It seems this this function can be rewritten as: 

{
	struct xfs_inode	*ip = XFS_I(inode);
	int			error = 0;
	struct xfs_da_args	args = {
		.dp		= ip,
		.attr_filter	= XFS_ATTR_VERITY,
		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
		.value		= buf,
		.valuelen	= buf_size,
	};

	error = xfs_attr_get(&args);
	if (error)
		return error;

	return args.valuelen;
}

And function as it does now.


> +
> +static int
> +xfs_begin_enable_verity(
> +	struct file	    *filp)
> +{
> +	struct inode	    *inode = file_inode(filp);
> +	struct xfs_inode    *ip = XFS_I(inode);
> +	int		    error = 0;

Hmmm. This code looks like it assumes the XFS_IOLOCK_EXCL is already
held - when was that lock taken? Can you add this:

	ASSERT(xfs_is_ilocked(ip, XFS_IOLOCK_EXCL));

> +
> +	if (IS_DAX(inode))
> +		return -EINVAL;

So fsverity is not compatible with DAX? What happens if we
turn on DAX after fsverity has been enabled on an inode? I didn't
see an exception to avoid IS_DAX() inodes with fsverity enabled
in the xfs_file_read_iter() code....

> +
> +	if (xfs_iflags_test(ip, XFS_IVERITY))
> +		return -EBUSY;
> +	xfs_iflags_set(ip, XFS_IVERITY);

Ah, so this is the "merkle tree being built" flag.

Can we name it XFS_IVERITY_CONSTRUCTION or something similar that
tells the reader that is a "work is in progress" flag rather than an
"inode has verity enabled" flag?


> +	/*
> +	 * As fs-verity doesn't support multi-page folios yet, flush everything
> +	 * from page cache and disable it
> +	 */
> +	filemap_invalidate_lock(inode->i_mapping);
> +
> +	inode_dio_wait(inode);

This only works to stop all IO if somethign is already holding
the XFS_IOLOCK_EXCL, hence my comment about the assert above.


> +	error = xfs_flush_unmap_range(ip, 0, XFS_ISIZE(ip));
> +	if (error)
> +		goto out;

	WARN_ON_ONCE(inode->i_mapping->nr_pages != 0);

Ok, so by this point nothing can instantiate new pages in the page
cache, and the mapping should be empty. Which means there should be
no large pages in it at all.

Which means it is safe to remove large folio support from the
mapping at this point..

> +	mapping_clear_large_folios(inode->i_mapping);

If Willy doesn't want to this wrapper to exist (and I can see why he
doesn't want it), just open code it with a clear comment detailing
that it will go away as the fsverity infrastructure is updated to
support multipage folios.

	/*
	 * This bit of nastiness will go away when fsverity support
	 * for multi-page folios is added.
	 */
	clear_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);


> +
> +out:
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	if (error)
> +		xfs_iflags_clear(ip, XFS_IVERITY);
> +	return error;
> +}
> +
> +static int
> +xfs_end_enable_verity(
> +	struct file		*filp,
> +	const void		*desc,
> +	size_t			desc_size,
> +	u64			merkle_tree_size)
> +{
> +	struct inode		*inode = file_inode(filp);
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_trans	*tp;
> +	struct xfs_da_args	args = {
> +		.dp		= ip,
> +		.whichfork	= XFS_ATTR_FORK,
> +		.attr_filter	= XFS_ATTR_VERITY,
> +		.attr_flags	= XATTR_CREATE,
> +		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
> +		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
> +		.value		= (void *)desc,
> +		.valuelen	= desc_size,
> +	};
> +	int			error = 0;

	ASSERT(xfs_is_ilocked(ip, XFS_IOLOCK_EXCL));

> +
> +	/* fs-verity failed, just cleanup */
> +	if (desc == NULL) {
> +		mapping_set_large_folios(inode->i_mapping);
> +		goto out;

I don't think it's safe to enable this while there may be page cache
operations running (i.e. through the page fault path). It also uses
__set_bit(), which is not guaranteed to be an atomic bit operation
(i.e. might be a RMW operation) and so isn't safe to perform on
variables that might be modified concurrently (as can happen with
mapping->flags in this context).

I think if verity measurement fails, the least of our worries is
re-enabling large folio support. hence I'd just leave this out for
the moment - the disabling of large folios is really only a
temporary thing...

> +	}
> +
> +	error = xfs_attr_set(&args);
> +	if (error)
> +		goto out;
> +
> +	/* Set fsverity inode flag */
> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_ichange, 0, 0, 0, &tp);
> +	if (error)
> +		goto out;
> +
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);

xfs_trans_alloc_inode()?

> +
> +	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;
> +	inode->i_flags |= S_VERITY;
> +
> +	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> +	error = xfs_trans_commit(tp);

I think this should be a data integrity commit here. We're setting
the on-disk flag and guaranteeing to the caller that the verity
information has been written and verity is enabled, so we should
really guarantee that it is persistent before returning to
the caller.

	/*
	 * Ensure that we've persisted the verity information before
	 * we enable it on the inode and tell the caller we have
	 * sealed the inode.
	 */
	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;

	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
	xfs_trans_set_sync(tp);

	error = xfs_trans_commit(tp);

	if (!error)
		inode->i_flags |= S_VERITY;

> +
> +out:
> +	if (error)
> +		mapping_set_large_folios(inode->i_mapping);

See above. 

> +
> +	xfs_iflags_clear(ip, XFS_IVERITY);
> +	return error;
> +}
> +
> +static struct page *
> +xfs_read_merkle_tree_page(
> +	struct inode		*inode,
> +	pgoff_t			index,
> +	unsigned long		num_ra_pages)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct page		*page;
> +	__be64			name = cpu_to_be64(index);
> +	struct xfs_da_args	args = {
> +		.dp		= ip,
> +		.attr_filter	= XFS_ATTR_VERITY,
> +		.name		= (const uint8_t *)&name,
> +		.namelen	= sizeof(__be64),
> +		.valuelen	= PAGE_SIZE,
> +	};
> +	int			error = 0;
> +
> +	error = xfs_attr_get(&args);
> +	if (error)
> +		return ERR_PTR(-EFAULT);
> +
> +	page = alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return ERR_PTR(-ENOMEM);
> +
> +	memcpy(page_address(page), args.value, args.valuelen);
> +
> +	kmem_free(args.value);
> +	return page;
> +}

Ok, this will work, but now I see why the merkel tree needs
validation on every read - the validation code makes the assumption
that the same *physical page* for a given tree block is fed to it
over and over again. It doesn't appear to check that the data in the
page is unchanged, just checks for the PageChecked() flag being set.
Not sure how the verify_page algorithm will work with variable sized
multi-page folios in the page cache, but that's a future problem...

I suspect we want to have xfs_attr_get() return us the xfs_buf that
contains the attribute value rather than a copy of the data itself.
Then we can pull the backing page from the xfs_buf here, grab a
reference to it and hand it back to the caller. 

All we need is a callout when the page ref is dropped by
verify_page() so that we can release the reference to the xfs_buf
that owns the page....

> +static int
> +xfs_write_merkle_tree_block(
> +	struct inode		*inode,
> +	const void		*buf,
> +	u64			index,
> +	int			log_blocksize)

"log blocksize"?

What's the journal got to do with writing a merkle tree block? :)

Hmmmm. The index is in units of blocks, and the size is always
one block. So to convert both size and index to units of bytes, we
have to shift upwards by "log_blocksize".

Yup, everyone immediately converts index to a byte offset, and
length to a byte count.

Eric, can we get this interface converted to pass an offset for the
index and a buffer length for the contents of *buf in bytes as
that's how everyone uses it?

> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	__be64			name = cpu_to_be64(index);
> +	struct xfs_da_args	args = {
> +		.dp		= ip,
> +		.whichfork	= XFS_ATTR_FORK,
> +		.attr_filter	= XFS_ATTR_VERITY,
> +		.attr_flags	= XATTR_CREATE,
> +		.name		= (const uint8_t *)&name,
> +		.namelen	= sizeof(__be64),
> +		.value		= (void *)buf,
> +		.valuelen	= 1 << log_blocksize,
> +	};

I'd prefer to store the merkle tree block as a byte offset (i.e.
index << log_blocksize) rather than a block index that is dependent
on something else to define the object size. That way we can
actually validate that the entire merkle tree is present (e.g. when
scrubbing/repairing inodes) without having to know what the merkle
tree block size is.


> +
> +	return xfs_attr_set(&args);
> +}
> +
> +const struct fsverity_operations xfs_verity_ops = {
> +	.begin_enable_verity = &xfs_begin_enable_verity,
> +	.end_enable_verity = &xfs_end_enable_verity,
> +	.get_verity_descriptor = &xfs_get_verity_descriptor,
> +	.read_merkle_tree_page = &xfs_read_merkle_tree_page,
> +	.write_merkle_tree_block = &xfs_write_merkle_tree_block,
> +};
> diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
> new file mode 100644
> index 0000000000000..ae5d87ca32a86
> --- /dev/null
> +++ b/fs/xfs/xfs_verity.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Red Hat, Inc.
> + */
> +#ifndef __XFS_VERITY_H__
> +#define __XFS_VERITY_H__
> +
> +#include <linux/fsverity.h>
> +
> +#define XFS_VERITY_DESCRIPTOR_NAME "verity_descriptor"
> +#define XFS_VERITY_DESCRIPTOR_NAME_LEN 17

Need to put a

	BUILD_BUG_ON(strlen(XFS_VERITY_DESCRIPTOR_NAME) ==
			XFS_VERITY_DESCRIPTOR_NAME_LEN);

somewhere in the code - there's a function that checks on-disk
structure sizes somewhere like this (in xfs_ondisk.c?)....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
