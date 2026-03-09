Return-Path: <linux-fsdevel+bounces-79816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAsTKSkAr2lILgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:15:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 457D023D7ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E75D13006B50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332703C3BE0;
	Mon,  9 Mar 2026 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLJgJVPU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42DF2C11D5;
	Mon,  9 Mar 2026 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076261; cv=none; b=rLFK2iKnRiBIjaEYR7zmEFji2szKMdFrIYt81+3F10tZmpCL8cp2R0xTA6NG0pkqWPzymWzFpJkoXZ8KSUi1BrW7LiPzCDcMOd9sXYdfSKEV8KHme0n/fT33pQ6keyRgXz37MXUKv9qYRHv2FtmJzEakgx4vhGWMwe//4v5UoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076261; c=relaxed/simple;
	bh=Dm81tFXTwK2Ykmj/RsuaMSiP+U7eQ2P5oswcUveft+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8J9WeGbfIIX+iFEVfUtaYzco4p9Fc7lSjbbd3VwKFD11UnRUKOfzAn5aHnRVWjIW4+w8DSL0PyDEV8aDFJnpnCKPS831eK520wNuvdMTPvjcHVutFYinEZphTUYAeOgWv8d3E4aEmZb9QaUDUWBS4vcQSW14UdjeEInr7GFRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLJgJVPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB76C4CEF7;
	Mon,  9 Mar 2026 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773076261;
	bh=Dm81tFXTwK2Ykmj/RsuaMSiP+U7eQ2P5oswcUveft+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLJgJVPUEiz6ollDUGetPVRMuqP1EywBxLHz/NEQCTS4Uw0IAyPqKzcDVyOymYFfN
	 homM9n+bQ0Xpn9unuS9H/oYf68PJwaCE5SptbtvnGn6UeyvxhebQAm633d/akXMxYt
	 nYbkfgsDXpKHs28nprxfdO2UuFt6yN3UUxu7UcbXcNMQ2c1KSeLFjdnzHZ5Yb5wQCd
	 Qvzp8IqQysA2P4/3LnmmNgP/vUwJ2j3xYJhi1npEumgE+qN1VPEgMM+wOMl91+fNoc
	 /OEySXdw/zxOSdzshD46KW9/3O4CLgl0/WARguv0uxSIOWO7py19bORH1zmgDT9af+
	 cyIsHAtIjR2rw==
Date: Mon, 9 Mar 2026 10:11:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 1/8] xfs: fix iomap hole map reporting for zoned zero
 range
Message-ID: <20260309171100.GL6033@frogsfrogsfrogs>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309134506.167663-2-bfoster@redhat.com>
X-Rspamd-Queue-Id: 457D023D7ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79816-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:44:59AM -0400, Brian Foster wrote:
> The hole mapping logic for zero range in zoned mode is not quite
> correct. It currently reports a hole whenever one exists in the data
> fork. If the first write to a sparse range has completed and not yet
> written back, the blocks exist in the COW fork as delalloc until
> writeback completes, at which point they are allocated and mapped
> into the data fork. If a zero range occurs on a range that has not
> yet populated the data fork, we will incorrectly report it as a
> hole.
> 
> Note that this currently functions correctly because we are bailed
> out by the pagecache flush in iomap_zero_range(). If a hole or
> unwritten mapping is reported with dirty pagecache, it assumes there
> is pending data, flushes to induce any pending block
> allocations/remaps, and retries the lookup. We want to remove this
> hack from iomap, however, so update iomap_begin() to only report a
> hole for zeroing when one exists in both forks.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/xfs/xfs_iomap.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index be86d43044df..8c3469d2c73e 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1651,14 +1651,6 @@ xfs_zoned_buffered_write_iomap_begin(
>  				&smap))
>  			smap.br_startoff = end_fsb; /* fake hole until EOF */
>  		if (smap.br_startoff > offset_fsb) {
> -			/*
> -			 * We never need to allocate blocks for zeroing a hole.
> -			 */
> -			if (flags & IOMAP_ZERO) {
> -				xfs_hole_to_iomap(ip, iomap, offset_fsb,
> -						smap.br_startoff);
> -				goto out_unlock;
> -			}
>  			end_fsb = min(end_fsb, smap.br_startoff);
>  		} else {
>  			end_fsb = min(end_fsb,
> @@ -1690,6 +1682,16 @@ xfs_zoned_buffered_write_iomap_begin(
>  	count_fsb = min3(end_fsb - offset_fsb, XFS_MAX_BMBT_EXTLEN,
>  			 XFS_B_TO_FSB(mp, 1024 * PAGE_SIZE));
>  
> +	/*
> +	 * When zeroing, don't allocate blocks for holes as they are already
> +	 * zeroes, but we need to ensure that no extents exist in both the data
> +	 * and COW fork to ensure this really is a hole.

But where is the cow fork check?  iomap_iter initializes srcmap to
IOMAP_HOLE, so if we end up here on an IOMAP_ZERO then we've scanned the
data fork and found no mapping.  But then we jump to out_unlock, which
means we don't actually look at ip->cowfp.

<confused>

--D

> +	 */
> +	if ((flags & IOMAP_ZERO) && srcmap->type == IOMAP_HOLE) {
> +		xfs_hole_to_iomap(ip, iomap, offset_fsb, end_fsb);
> +		goto out_unlock;
> +	}
> +
>  	/*
>  	 * The block reservation is supposed to cover all blocks that the
>  	 * operation could possible write, but there is a nasty corner case
> -- 
> 2.52.0
> 
> 

