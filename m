Return-Path: <linux-fsdevel+bounces-75827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ+pEd+temmv9AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:46:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A95ACAA586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24864302C5D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AD5228CA9;
	Thu, 29 Jan 2026 00:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkw6C1bg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62934CB5B;
	Thu, 29 Jan 2026 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647549; cv=none; b=RWCBkr14D3o0QmAEX9dSgiE2VOTlkwthIhGAl7BtG/G4Jh+FQf1toX8vu5eyPkW0LE0R3u9Ienb+CsVsgNZ9In4aXCuUqnmh1iCuM2WDqbEoBGTPYpCtIPFfYdJbCU5SIM34cS6J06ICdL/+lJNf7a5yRn4NTxjJBhVcviuSKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647549; c=relaxed/simple;
	bh=521PB98LoQFeuzDL2y570ukegXohZNWvlq4XD6gGUZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ael71rrtRMUxB1UFgxyHVAKEarJ5vdBlSvs99Sdr7vAz+TjyP7tRbM1pYhuqfh0PaOPQt+rlKNVDpK3bcsQhMGSHdvBGxKcF7AhA5TSkUevnCInSTWCw+Y28Gbf0KY4mrWBSVur2WvAOCwHJ6D4YMfy/cRX4H0CbBv4okbAAbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkw6C1bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542C5C4CEF1;
	Thu, 29 Jan 2026 00:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769647549;
	bh=521PB98LoQFeuzDL2y570ukegXohZNWvlq4XD6gGUZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qkw6C1bgR0YIMU/zkUe+tRHdDbV35uLOcxW6te6qYu1/CKpSxonhKeEtZs0FTCmb2
	 Nzor5bkcAJYlBk/eUA+gi85CY3bVIfB4ZgrVV71iHKKaVNsIUC95bofSmGo6Df05W4
	 VlZDGL4GV+zSIn5X/dI1zcHO5sjJsHQVjgooXShytu4Qn423C04pcaKW0w7gfDgWF8
	 fuozlF2hduYUZ3YT5CqP4ASngpHf29aIOYswugnWnJY8zhiZRF3S+mdZ1LXVEu8BJc
	 OcuU9S7oxoNN9+s4jOr6Viu8WHiWLwa2D6pV/vHocRDyqUpBinm8f+2mAVFvX9BJY/
	 ZYtfME5TmowVA==
Date: Wed, 28 Jan 2026 16:45:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	hch@lst.de, ritesh.list@gmail.com, dave@stgolabs.net,
	cem@kernel.org, wangyufei@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v3 2/6] xfs: add helpers to pack AG prediction info for
 per-folio tracking
Message-ID: <20260129004548.GB7712@frogsfrogsfrogs>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
 <CGME20260116101245epcas5p30269c6aa35784db67e6d6ca800a683a7@epcas5p3.samsung.com>
 <20260116100818.7576-3-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116100818.7576-3-kundan.kumar@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75827-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: A95ACAA586
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 03:38:14PM +0530, Kundan Kumar wrote:
> Introduce helper routines to pack and unpack AG prediction metadata
> for folios. This provides a compact and self-contained representation
> for AG tracking.
> 
> The packed layout uses:
>  - bit 31	: valid
>  - bit 24-30	: iomap type
>  - bit 0-23	: AG number

There are only 5 iomap types, why do you need 7 bits for that?

Also, can you store more bits on a 64-bit system to avoid truncating the
AG number?

--D

> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/xfs/xfs_iomap.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index ebcce7d49446..eaf4513f6759 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -12,6 +12,37 @@ struct xfs_inode;
>  struct xfs_bmbt_irec;
>  struct xfs_zone_alloc_ctx;
>  
> +/* pack prediction in a u32 stored in xarray */
> +#define XFS_AGP_VALID_SHIFT 31
> +#define XFS_AGP_TYPE_SHIFT 24
> +#define XFS_AGP_TYPE_MASK 0x7fu
> +#define XFS_AGP_AGNO_MASK 0x00ffffffu
> +
> +static inline u32 xfs_agp_pack(u32 agno, u8 iomap_type, bool valid)
> +{
> +	u32 v = agno & XFS_AGP_AGNO_MASK;
> +
> +	v |= ((u32)iomap_type & XFS_AGP_TYPE_MASK) << XFS_AGP_TYPE_SHIFT;
> +	if (valid)
> +		v |= (1u << XFS_AGP_VALID_SHIFT);
> +	return v;
> +}
> +
> +static inline bool xfs_agp_valid(u32 v)
> +{
> +	return v >> XFS_AGP_VALID_SHIFT;
> +}
> +
> +static inline u32 xfs_agp_agno(u32 v)
> +{
> +	return v & XFS_AGP_AGNO_MASK;
> +}
> +
> +static inline u8 xfs_agp_type(u32 v)
> +{
> +	return (u8)((v >> XFS_AGP_TYPE_SHIFT) & XFS_AGP_TYPE_MASK);
> +}
> +
>  int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
>  		xfs_fileoff_t count_fsb, unsigned int flags,
>  		struct xfs_bmbt_irec *imap, u64 *sequence);
> -- 
> 2.25.1
> 
> 

