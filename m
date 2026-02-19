Return-Path: <linux-fsdevel+bounces-77736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMHAFeNkl2n/xgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 20:30:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CDB16208B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 20:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4A9F3039EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CCF309F18;
	Thu, 19 Feb 2026 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6mt63/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E12E0B71;
	Thu, 19 Feb 2026 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529418; cv=none; b=P0g4rsjZd7VDTHZ7RMVY9oq2sBh+S72irQlkgMzCb3tW+oOl6z07by0GcXr0J29FIE7uh0gzU+Edap3PsiL3eeqHQRMpOzLLdtUMrj1bAYdhAu9FcVDez5nsGi/hed41CQx9esr7aWr8sl4ltRCjWJr0VA86yi2ZK19+9JArDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529418; c=relaxed/simple;
	bh=X/X5RRyXeMbrbz/ZenwcyeIPn7dwKsb549deEqtV4Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoJpOXm0IF093g28zz3g7P2It8PWkCk7k4xthawiNMgfgMJbkzd0ufScq/TCPbSrEBDLepI4xONFCeLaF0a3G2LXji4GKKBxYV/yfj4YWvMB3xvv/dlcdhNygiqPwBxOMU2uE6jlI+FjxGX2Ges4nPiPJRD2WvU4MiNMEtgjjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6mt63/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8832CC4CEF7;
	Thu, 19 Feb 2026 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771529417;
	bh=X/X5RRyXeMbrbz/ZenwcyeIPn7dwKsb549deEqtV4Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6mt63/dEtr/b2f/BAwtqo2iR05YETFPx3v9WHh04gipNepb9nb1k9oDmx+YMK/C1
	 gQHWQCBHJgWODIPcXPmCKOeT8espIeE2AbCkaJznPpkfEurvvh8CWKSVrsHHskxZ+x
	 yTjEoAeQHhiyQrNJyWXw/tMfhDBobBkT5ETKal0FY6xjUmoDc3FWiqJa31e5N6/tkt
	 Lxo+9G9+8vv2WR4jeo81Lj94kYOmtBy6aKc6Sn16HdncvyxmfEenjDSlV7KmpXvpks
	 u0pAsF06U5CsZH7OGNiWlsw7pAbcF0B1FF1L3VYhRdigRx0HiaXrNmDBxQ91VH7Rhf
	 zqougAFRmBgHQ==
Date: Thu, 19 Feb 2026 11:30:16 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>, b@magnolia.djwong.org
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 27/35] xfs: use different on-disk and pagecache offset
 for fsverity
Message-ID: <20260219193016.GO6490@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-28-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-28-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77736-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8CDB16208B
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:27AM +0100, Andrey Albershteyn wrote:
> Convert between pagecache and on-disk offset while reading/writing
> fsverity metadata through iomap.
> 
> We can not use on-disk (1ULL << 53) offset for pagecache as it doesn't

nit: 'cannot', not 'can not'.

(English is a weird language, the two don't quite mean the same thing)

> fit into 32-bit address space and the page radix tree is going to be
> quite high on 64-bit. To prevent this we use lower offset, right after
> EOF. The fsverity_metadata_offset() sets it to be next largest folio
> after EOF.

I'd say "fsverity_metadata_offset() sets the pagecache offset so that
file data and fsverity metadata cannot be cached by the same folio."

> We can not use this pagecache offset for on-disk file offset though, as
> this is folio size dependent. Therefore, for on-disk we use offset far
> beyond EOF which allows to use largest file size supported by fsverity.
> 
> Also don't convert offset if IOMAP_REPORT is set as we need to see real
> extents for fiemap.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 12 ++++++++++--
>  fs/xfs/xfs_aops.c        | 13 ++++++++++---
>  fs/xfs/xfs_iomap.c       | 33 ++++++++++++++++++++++++++-------
>  3 files changed, 46 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 99a3ff2ee928..05fddd34c697 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -41,6 +41,8 @@
>  #include "xfs_inode_util.h"
>  #include "xfs_rtgroup.h"
>  #include "xfs_zone_alloc.h"
> +#include "xfs_fsverity.h"
> +#include <linux/fsverity.h>
>  
>  struct kmem_cache		*xfs_bmap_intent_cache;
>  
> @@ -4451,7 +4453,9 @@ xfs_bmapi_convert_one_delalloc(
>  	XFS_STATS_ADD(mp, xs_xstrat_bytes, XFS_FSB_TO_B(mp, bma.length));
>  	XFS_STATS_INC(mp, xs_xstrat_quick);
>  
> -	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION) &&
> +	    XFS_FSB_TO_B(mp, bma.got.br_startoff) >=
> +		    fsverity_metadata_offset(VFS_I(ip)))
>  		flags |= IOMAP_F_FSVERITY;

Hrmmm.  I wonder, why not create a set of fsverity-specific iomap ops
that wrap xfs_read_iomap_begin and/or xfs_buffered_write_iomap_begin?
The wrappers could then do the offset translation prior to calling the
real _iomap_begin function, and then undo that translation on the output
mapping and set IOMAP_F_FSVERITY?  Then we don't clutter up the regular
paths with the translation stuff.

<shrug> Thoughts?  This way seems to work as well.

--D

>  
>  	ASSERT(!isnullstartblock(bma.got.br_startblock));
> @@ -4495,6 +4499,10 @@ xfs_bmapi_convert_delalloc(
>  	unsigned int		*seq)
>  {
>  	int			error;
> +	loff_t			iomap_offset = offset;
> +
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +		iomap_offset = xfs_fsverity_offset_from_disk(ip, offset);
>  
>  	/*
>  	 * Attempt to allocate whatever delalloc extent currently backs offset
> @@ -4507,7 +4515,7 @@ xfs_bmapi_convert_delalloc(
>  					iomap, seq);
>  		if (error)
>  			return error;
> -	} while (iomap->offset + iomap->length <= offset);
> +	} while (iomap->offset + iomap->length <= iomap_offset);
>  
>  	return 0;
>  }
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 9d4fc3322ec7..53aeea5e9ebd 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -335,8 +335,8 @@ xfs_map_blocks(
>  	struct xfs_inode	*ip = XFS_I(wpc->inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	ssize_t			count = i_blocksize(wpc->inode);
> -	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
> +	xfs_fileoff_t		offset_fsb;
> +	xfs_fileoff_t		end_fsb;
>  	xfs_fileoff_t		cow_fsb;
>  	int			whichfork;
>  	struct xfs_bmbt_irec	imap;
> @@ -351,8 +351,12 @@ xfs_map_blocks(
>  
>  	XFS_ERRORTAG_DELAY(mp, XFS_ERRTAG_WB_DELAY_MS);
>  
> -	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION)) {
>  		iomap_flags |= IOMAP_F_FSVERITY;
> +		offset = xfs_fsverity_offset_to_disk(ip, offset);
> +	}
> +	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	end_fsb = XFS_B_TO_FSB(mp, offset + count);
>  
>  	/*
>  	 * COW fork blocks can overlap data fork blocks even if the blocks
> @@ -484,6 +488,9 @@ xfs_map_blocks(
>  			wpc->iomap.length = cow_offset - wpc->iomap.offset;
>  	}
>  
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +		offset = xfs_fsverity_offset_from_disk(ip, offset);
> +
>  	ASSERT(wpc->iomap.offset <= offset);
>  	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
>  	trace_xfs_map_blocks_alloc(ip, offset, count, whichfork, &imap);
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 6b14221ecee2..a04361cf0e99 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -32,6 +32,7 @@
>  #include "xfs_rtbitmap.h"
>  #include "xfs_icache.h"
>  #include "xfs_zone_alloc.h"
> +#include "xfs_fsverity.h"
>  #include <linux/fsverity.h>
>  
>  #define XFS_ALLOC_ALIGN(mp, off) \
> @@ -142,7 +143,11 @@ xfs_bmbt_to_iomap(
>  		    xfs_rtbno_is_group_start(mp, imap->br_startblock))
>  			iomap->flags |= IOMAP_F_BOUNDARY;
>  	}
> -	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
> +	if (xfs_fsverity_need_convert_offset(ip, imap, mapping_flags))
> +		iomap->offset = xfs_fsverity_offset_from_disk(
> +			ip, XFS_FSB_TO_B(mp, imap->br_startoff));
> +	else
> +		iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
>  	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
>  	iomap->flags = iomap_flags;
>  	if (mapping_flags & IOMAP_DAX) {
> @@ -629,6 +634,8 @@ xfs_iomap_write_unwritten(
>  	uint		resblks;
>  	int		error;
>  
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +		offset = xfs_fsverity_offset_to_disk(ip, offset);
>  	trace_xfs_unwritten_convert(ip, offset, count);
>  
>  	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> @@ -1766,8 +1773,8 @@ xfs_buffered_write_iomap_begin(
>  						     iomap);
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> +	xfs_fileoff_t		offset_fsb;
> +	xfs_fileoff_t		end_fsb;
>  	struct xfs_bmbt_irec	imap, cmap;
>  	struct xfs_iext_cursor	icur, ccur;
>  	xfs_fsblock_t		prealloc_blocks = 0;
> @@ -1790,8 +1797,12 @@ xfs_buffered_write_iomap_begin(
>  		return xfs_direct_write_iomap_begin(inode, offset, count,
>  				flags, iomap, srcmap);
>  
> -	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION)) {
>  		iomap_flags |= IOMAP_F_FSVERITY;
> +		offset = xfs_fsverity_offset_to_disk(ip, offset);
> +	}
> +	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>  
>  	error = xfs_qm_dqattach(ip);
>  	if (error)
> @@ -2112,8 +2123,8 @@ xfs_read_iomap_begin(
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct xfs_bmbt_irec	imap;
> -	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> +	xfs_fileoff_t		offset_fsb;
> +	xfs_fileoff_t		end_fsb;
>  	int			nimaps = 1, error = 0;
>  	bool			shared = false;
>  	unsigned int		lockmode = XFS_ILOCK_SHARED;
> @@ -2125,8 +2136,15 @@ xfs_read_iomap_begin(
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
> -	if (fsverity_active(inode) && offset >= XFS_FSVERITY_REGION_START)
> +	if (fsverity_active(inode) &&
> +	    (offset >= fsverity_metadata_offset(inode)) &&
> +	    !(flags & IOMAP_REPORT)) {
>  		iomap_flags |= IOMAP_F_FSVERITY;
> +		offset = xfs_fsverity_offset_to_disk(ip, offset);
> +	}
> +
> +	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	end_fsb = xfs_iomap_end_fsb(mp, offset, length);
>  
>  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
>  	if (error)
> @@ -2142,6 +2160,7 @@ xfs_read_iomap_begin(
>  		return error;
>  	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
>  	iomap_flags |= shared ? IOMAP_F_SHARED : 0;
> +
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
>  }
>  
> -- 
> 2.51.2
> 
> 

