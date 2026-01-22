Return-Path: <linux-fsdevel+bounces-74957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHySICN3cWkJHwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:02:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 438296028E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF43C57CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB076326D5D;
	Thu, 22 Jan 2026 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipHKrdbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B01C860B;
	Thu, 22 Jan 2026 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043731; cv=none; b=X9DU6+REwMqCaelzA3EGVGha+tmGwgzZch+X33eXbTQUBY1IC36WoF3YMukWh9LIEFsc8X6bGqFimwJofi06vfWx/gO+2RJ6M3C5vVhscGo2O2aXc0R19Y1Cscj9BD+wcNZIXHxOHyYCUNd+ehgtbGTpRWsAXMpFLyv34MERoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043731; c=relaxed/simple;
	bh=xD2JoIyoWBlge7MsN3AV44Gi7HGJugxGlByPOrGJueU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOtWyykD0YUQe/IabwMIVzHrmWFp+sdZJiyNCoV3FbL2E+Q7F1OOPqBpmC0Lkh53sA6jZE8oOxtb6ry+jlid03GoZJnyAbyJDBC+Zu0i8mpcsDiOU2Z+NOrtAH+lnExAkuFAsm1+v96M2iYPmUzkpGiDOH640RZ8jO7WTMEF07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipHKrdbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A819DC4CEF1;
	Thu, 22 Jan 2026 01:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043730;
	bh=xD2JoIyoWBlge7MsN3AV44Gi7HGJugxGlByPOrGJueU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipHKrdbtd1sVX0oWQwWDuPbIFKn344oGvNfUN3CJ3csbd6S8fcbYlo8jlziZH9AtT
	 0qY0VVD9pmQTP01delfwdIWZhoVWmsUHGr6oDjhzZU9lLfkGKqSe1Hz56l5gG18eka
	 geLqgKXTUCJvdxs9rt5LGdbB42HnRB3fogtMMh6LuNNtqk9Efk5kXMtxGz7WuBaMfa
	 50tKlcnk6kGT+V0j1Dd+fUzDVV5M6S9O4fJdKVikXgp9NPnCDn7hr+zAISJzjdDITw
	 mqU68ewPQh8f4TFoznfz0zhgsuHJdhyosKNPEPKviGe9+ZUmdWD/RGLDevHGiGRvvQ
	 cNh/bU8/LolOA==
Date: Wed, 21 Jan 2026 17:02:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/15] xfs: support T10 protection information
Message-ID: <20260122010210.GS5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-16-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-16-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-74957-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 438296028E
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:23AM +0100, Christoph Hellwig wrote:
> Add support for generating / verifying protection information in the file
> system.  This is largely done by simply setting the IOMAP_F_INTEGRITY
> flag and letting iomap do all of the work.  XFS just has to ensure that
> the data read completions for integrity data are run from user context.
> 
> For zoned writeback, XFS also has to generate the integrity data itself
> as the zoned writeback path is not using the generic writeback_submit
> implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_aops.c  | 47 ++++++++++++++++++++++++++++++++++++++++++----
>  fs/xfs/xfs_iomap.c |  9 ++++++---
>  2 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index c3c1e149fff4..4baf0a85271c 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -22,6 +22,7 @@
>  #include "xfs_icache.h"
>  #include "xfs_zone_alloc.h"
>  #include "xfs_rtgroup.h"
> +#include <linux/bio-integrity.h>
>  
>  struct xfs_writepage_ctx {
>  	struct iomap_writepage_ctx ctx;
> @@ -661,6 +662,8 @@ xfs_zoned_writeback_submit(
>  		bio_endio(&ioend->io_bio);
>  		return error;
>  	}
> +	if (wpc->iomap.flags & IOMAP_F_INTEGRITY)
> +		fs_bio_integrity_generate(&ioend->io_bio);
>  	xfs_zone_alloc_and_submit(ioend, &XFS_ZWPC(wpc)->open_zone);
>  	return 0;
>  }
> @@ -741,12 +744,43 @@ xfs_vm_bmap(
>  	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
>  }
>  
> +static void
> +xfs_bio_submit_read(
> +	const struct iomap_iter		*iter,
> +	struct iomap_read_folio_ctx	*ctx)
> +{
> +	struct bio			*bio = ctx->read_ctx;
> +
> +	/* delay read completions to the ioend workqueue */
> +	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
> +	bio->bi_end_io = xfs_end_bio;
> +	submit_bio(bio);
> +}
> +
> +static const struct iomap_read_ops xfs_bio_read_integrity_ops = {
> +	.read_folio_range	= iomap_bio_read_folio_range,
> +	.submit_read		= xfs_bio_submit_read,
> +	.bio_set		= &iomap_ioend_bioset,
> +};
> +
> +static inline const struct iomap_read_ops *bio_read_ops(struct xfs_inode *ip)

xfs_bio_read_ops to avoid conflicts with the block layer?

Otherwise this looks ok to me, so with that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> +{
> +	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
> +		return &xfs_bio_read_integrity_ops;
> +	return &iomap_bio_read_ops;
> +}
> +
>  STATIC int
>  xfs_vm_read_folio(
> -	struct file		*unused,
> -	struct folio		*folio)
> +	struct file			*file,
> +	struct folio			*folio)
>  {
> -	iomap_bio_read_folio(folio, &xfs_read_iomap_ops);
> +	struct iomap_read_folio_ctx	ctx = {
> +		.cur_folio	= folio,
> +		.ops		= bio_read_ops(XFS_I(file->f_mapping->host)),
> +	};
> +
> +	iomap_read_folio(&xfs_read_iomap_ops, &ctx);
>  	return 0;
>  }
>  
> @@ -754,7 +788,12 @@ STATIC void
>  xfs_vm_readahead(
>  	struct readahead_control	*rac)
>  {
> -	iomap_bio_readahead(rac, &xfs_read_iomap_ops);
> +	struct iomap_read_folio_ctx	ctx = {
> +		.rac		= rac,
> +		.ops		= bio_read_ops(XFS_I(rac->mapping->host)),
> +	};
> +
> +	iomap_readahead(&xfs_read_iomap_ops, &ctx);
>  }
>  
>  static int
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 37a1b33e9045..6ed784894b5a 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -143,11 +143,14 @@ xfs_bmbt_to_iomap(
>  	}
>  	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
>  	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
> -	if (mapping_flags & IOMAP_DAX)
> +	iomap->flags = iomap_flags;
> +	if (mapping_flags & IOMAP_DAX) {
>  		iomap->dax_dev = target->bt_daxdev;
> -	else
> +	} else {
>  		iomap->bdev = target->bt_bdev;
> -	iomap->flags = iomap_flags;
> +		if (bdev_has_integrity_csum(iomap->bdev))
> +			iomap->flags |= IOMAP_F_INTEGRITY;
> +	}
>  
>  	/*
>  	 * If the inode is dirty for datasync purposes, let iomap know so it
> -- 
> 2.47.3
> 
> 

