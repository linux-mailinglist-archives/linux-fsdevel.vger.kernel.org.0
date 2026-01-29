Return-Path: <linux-fsdevel+bounces-75825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PxjGH2temmv9AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:44:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A555EAA549
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7518E3024137
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C52580D7;
	Thu, 29 Jan 2026 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI7vmT9C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB3247280;
	Thu, 29 Jan 2026 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647446; cv=none; b=sVoV+V6t/0wND2w2tKrWs0yTlZSA7o3b+90BZpjgbt96HW3wjjp188gWg/qediHqpUQqdX7u1m/HL7ylyBGqeqPTYhxWhj2LLOTeBCYHkzcVO5YN+vJ5NmPMCPUw7s6I5enyncdGaPvXtvtZauuqXfqu3rEG0ymd7T2v5HeQMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647446; c=relaxed/simple;
	bh=du+Chat2KKUjWi9KMstZ4LpJLC7xzl/p+SbRJ5Wo4Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlsrajPAlbhJX77TAeO/ACPLhXrRtRGEIRbixcH0QdvhoP492Bx612OkBPKwqKm9b40m+vnvOGGqFfzTjzTOLJ2DL6yplfFx09pduuaWWEFx1FYlvZKK3zIXeZw324T24jeD7st7/O5N2fWeqgCCHXSYRSYLzuMoVELWmiXfaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI7vmT9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D83AC4CEF1;
	Thu, 29 Jan 2026 00:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769647445;
	bh=du+Chat2KKUjWi9KMstZ4LpJLC7xzl/p+SbRJ5Wo4Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NI7vmT9CRQFjO8mg1hFcsnq+/zwLSuSJG5XMxheGO3KEhe7eyZQdBY7VfZb+1nCGe
	 R9woJsKNb3DCaoOzYBoG/vEBz6HwICn+EunyGgRGlbqhx2UAmewFUiSdIJZmHZJDFz
	 MbCo2VP9ytTKwTlIePkAuci6DO7CYMhxir91QvsfJQhVaIk5fHM81UQd3OdOdJiYj2
	 uaTuRP+cbyJ6/d24vJgrmraoutXjgUHHfsutaqzIJ5i9nteMYtT7QxBzSxQ3papiPZ
	 WihvCxMaKaukGT/qogCcD6Vtgg0RXFDPE/CFY9yjx4v20buEFL4QTRGtIr0HCTv4Oz
	 7XF37cwgR/2FA==
Date: Wed, 28 Jan 2026 16:44:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	hch@lst.de, ritesh.list@gmail.com, dave@stgolabs.net,
	cem@kernel.org, wangyufei@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v3 3/6] xfs: add per-inode AG prediction map and dirty-AG
 bitmap
Message-ID: <20260129004404.GA7712@frogsfrogsfrogs>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
 <CGME20260116101251epcas5p1cf5b48f2efb14fe4387be3053b3c3ebc@epcas5p1.samsung.com>
 <20260116100818.7576-4-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116100818.7576-4-kundan.kumar@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75825-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: A555EAA549
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 03:38:15PM +0530, Kundan Kumar wrote:
> Add per-inode structures to track predicted AGs of dirty folios using
> an xarray and bitmap. This enables efficient identification of AGs
> involved in writeback.
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/xfs/xfs_icache.c | 27 +++++++++++++++++++++++++++
>  fs/xfs/xfs_inode.h  |  5 +++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index e44040206851..f97aa6d66271 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -80,6 +80,25 @@ static inline xa_mark_t ici_tag_to_mark(unsigned int tag)
>  	return XFS_PERAG_BLOCKGC_MARK;
>  }
>  
> +static int xfs_inode_init_ag_bitmap(struct xfs_inode *ip)
> +{
> +	unsigned int bits = ip->i_mount->m_sb.sb_agcount;
> +	unsigned int nlongs;
> +
> +	xa_init_flags(&ip->i_ag_pmap, XA_FLAGS_LOCK_IRQ);

This increases the size of struct xfs_inode by 40 bytes...

> +	ip->i_ag_dirty_bitmap = NULL;
> +	ip->i_ag_dirty_bits = bits;
> +
> +	if (!bits)
> +		return 0;
> +
> +	nlongs = BITS_TO_LONGS(bits);
> +	ip->i_ag_dirty_bitmap = kcalloc(nlongs, sizeof(unsigned long),
> +					GFP_NOFS);

...and there could be hundreds or thousands of AGs for each filesystem.
That's a lot of kernel memory to handle this prediction stuff, and I"m
not even sure what ag_dirty_bitmap does yet.

> +
> +	return ip->i_ag_dirty_bitmap ? 0 : -ENOMEM;
> +}
> +
>  /*
>   * Allocate and initialise an xfs_inode.
>   */
> @@ -131,6 +150,8 @@ xfs_inode_alloc(
>  	ip->i_next_unlinked = NULLAGINO;
>  	ip->i_prev_unlinked = 0;
>  
> +	xfs_inode_init_ag_bitmap(ip);

Unchecked return value???

> +
>  	return ip;
>  }
>  
> @@ -194,6 +215,12 @@ xfs_inode_free(
>  	ip->i_ino = 0;
>  	spin_unlock(&ip->i_flags_lock);
>  
> +	/* free xarray contents (values are immediate packed ints) */
> +	xa_destroy(&ip->i_ag_pmap);
> +	kfree(ip->i_ag_dirty_bitmap);
> +	ip->i_ag_dirty_bitmap = NULL;
> +	ip->i_ag_dirty_bits = 0;
> +
>  	__xfs_inode_free(ip);
>  }
>  
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index bd6d33557194..dee449168605 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -99,6 +99,11 @@ typedef struct xfs_inode {
>  	spinlock_t		i_ioend_lock;
>  	struct work_struct	i_ioend_work;
>  	struct list_head	i_ioend_list;
> +
> +	/* AG prediction map: pgoff_t -> packed u32 */

What about blocksize < pagesize filesystems?  Which packed agno do you
associate with the pgoff_t?

Also, do you have an xarray entry for each pgoff_t in a large folio?

--D

> +	struct xarray           i_ag_pmap;
> +	unsigned long           *i_ag_dirty_bitmap;
> +	unsigned int            i_ag_dirty_bits;
>  } xfs_inode_t;
>  
>  static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
> -- 
> 2.25.1
> 
> 

