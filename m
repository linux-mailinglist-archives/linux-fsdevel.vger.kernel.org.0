Return-Path: <linux-fsdevel+bounces-79825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMLRIWEGr2knLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:41:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E823DC34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3092730580A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D363D6460;
	Mon,  9 Mar 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE0YFeqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412D2F260C;
	Mon,  9 Mar 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078009; cv=none; b=K/MqP8STEAIrdv5b8kh6SVikpIj4eoaUQj7ooJoxR4FYZkzoBY9I7Hx917x4+2pu6Muo4AfR+vLqiKC+9y/BOCcejh4K4UT0l+Q58qXLZ5JYnnnjFBBQL3+oMS9ZMG7hj4EFj1KApW9haSafDcjKKZhGbTqfLTy8xFBCUp0Obn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078009; c=relaxed/simple;
	bh=xCB1rLERH4O4/XL0uHe/faGStCm8QjO0kIi2lwkxDkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBjukYBWh9XrX90RBxPQPjhosi9d5gWaqi5dpJ1IWRNuw1Z8UTH3jiwMC8F8nN3h7zf9KTrdfDzPpS4h5MciQOW4jqezwU43rlT15I4CiJPnhSFl+//aVYJlRINxUUvtHe28h/F4UjlMYHuX12fKaPJowrmh1Y4Ux3E1UqGmPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE0YFeqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718D6C4CEF7;
	Mon,  9 Mar 2026 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773078009;
	bh=xCB1rLERH4O4/XL0uHe/faGStCm8QjO0kIi2lwkxDkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pE0YFeqkP1myKJB9xLPp8PNR5Dhyvp6zEOUY0Jy2sbjCKpD+paZE8VG4dnfABQkoZ
	 4vPj5k2KnRlLeTiNW40oSE7pAN2o8N19l8wgSLUG301GctaZz85WgdiCGHENDKUA5U
	 tb5EDki4z08OoL38F4ScMOkPMfCR7esLahuJGwUgW74OENsOdEgiwj0zTHg5YaHzpL
	 /k95Q+lYNBmFLsh0jLgJK9kSfrqABb5/eP4pIzX9Jl8hfFqbr4gepuMtJSTgJJS6qA
	 9e4ysswZ0MpSyV9Pw1MIl2MTO9Vl+ge04th61ic9TY4yq5Sy7dhKPw7VdZnChShjlc
	 +eGsVKXVZRvLQ==
Date: Mon, 9 Mar 2026 10:40:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <20260309174008.GO6033@frogsfrogsfrogs>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309134506.167663-4-bfoster@redhat.com>
X-Rspamd-Queue-Id: CB4E823DC34
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
	TAGGED_FROM(0.00)[bounces-79825-lists,linux-fsdevel=lfdr.de];
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

On Mon, Mar 09, 2026 at 09:45:01AM -0400, Brian Foster wrote:
> iomap zero range has a wart in that it also flushes dirty pagecache
> over hole mappings (rather than only unwritten mappings). This was
> included to accommodate a quirk in XFS where COW fork preallocation
> can exist over a hole in the data fork, and the associated range is
> reported as a hole. This is because the range actually is a hole,
> but XFS also has an optimization where if COW fork blocks exist for
> a range being written to, those blocks are used regardless of
> whether the data fork blocks are shared or not. For zeroing, COW
> fork blocks over a data fork hole are only relevant if the range is
> dirty in pagecache, otherwise the range is already considered
> zeroed.
> 
> The easiest way to deal with this corner case is to flush the
> pagecache to trigger COW remapping into the data fork, and then
> operate on the updated on-disk state. The problem is that ext4
> cannot accommodate a flush from this context due to being a
> transaction deadlock vector.
> 
> Outside of the hole quirk, ext4 can avoid the flush for zero range
> by using the recently introduced folio batch lookup mechanism for
> unwritten mappings. Therefore, take the next logical step and lift
> the hole handling logic into the XFS iomap_begin handler. iomap will
> still flush on unwritten mappings without a folio batch, and XFS
> will flush and retry mapping lookups in the case where it would
> otherwise report a hole with dirty pagecache during a zero range.
> 
> Note that this is intended to be a fairly straightforward lift and
> otherwise not change behavior. Now that the flush exists within XFS,
> follow on patches can further optimize it.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c |  2 +-
>  fs/xfs/xfs_iomap.c     | 25 ++++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bc82083e420a..0999aca6e5cc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1642,7 +1642,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		     srcmap->type == IOMAP_UNWRITTEN)) {
>  			s64 status;
>  
> -			if (range_dirty) {
> +			if (range_dirty && srcmap->type == IOMAP_UNWRITTEN) {
>  				range_dirty = false;
>  				status = iomap_zero_iter_flush_and_stale(&iter);
>  			} else {
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 0e323e4e304b..966fb9d8b9df 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1811,6 +1811,7 @@ xfs_buffered_write_iomap_begin(
>  	if (error)
>  		return error;
>  
> +restart:
>  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
>  	if (error)
>  		return error;
> @@ -1838,9 +1839,27 @@ xfs_buffered_write_iomap_begin(
>  	if (eof)
>  		imap.br_startoff = end_fsb; /* fake hole until the end */
>  
> -	/* We never need to allocate blocks for zeroing or unsharing a hole. */
> -	if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
> -	    imap.br_startoff > offset_fsb) {
> +	/* We never need to allocate blocks for unsharing a hole. */
> +	if ((flags & IOMAP_UNSHARE) && imap.br_startoff > offset_fsb) {
> +		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * We may need to zero over a hole in the data fork if it's fronted by
> +	 * COW blocks and dirty pagecache. To make sure zeroing occurs, force
> +	 * writeback to remap pending blocks and restart the lookup.
> +	 */
> +	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> +		if (filemap_range_needs_writeback(inode->i_mapping, offset,
> +						  offset + count - 1)) {
> +			xfs_iunlock(ip, lockmode);
> +			error = filemap_write_and_wait_range(inode->i_mapping,
> +						offset, offset + count - 1);

Two tab indent here, but other than that nit this makes sense to me.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +			if (error)
> +				return error;
> +			goto restart;
> +		}
>  		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
>  		goto out_unlock;
>  	}
> -- 
> 2.52.0
> 
> 

