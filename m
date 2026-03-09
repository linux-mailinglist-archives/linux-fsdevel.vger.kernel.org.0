Return-Path: <linux-fsdevel+bounces-79818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NydKz8Cr2lmLgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:24:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8D123D9B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D5B6302B20B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445023ED5D0;
	Mon,  9 Mar 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6VH/W/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277E3ECBF7;
	Mon,  9 Mar 2026 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076940; cv=none; b=OuGFOXBk6W29IdGvaQrZkz6DwKG6c8zJ53oUWzQ+UpTKjmT1SN0Y23WD9GduoqIRWQbiOQFRk2woOxKGH+6E+bxTSqFveUsMyG7AiAOBvFMVgaPhlQhGe1GGUAU13KxhBCkT0j7ybB4ARY/L1tjcTEvfMhaIUJSIHOMfRSKOyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076940; c=relaxed/simple;
	bh=c7aX5fI7BtZLs0g0BTy5RmbjAQ0S7txzlahLBlrng3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0KnGXxj/oh54+cEFdew5GkkOBmHwFTJZmgoB9/rJINtTsuEB54+UidvdeXCgWC2cSYysyh47GljJvCWCdb7LF+gq0hUNzuB4ioU4o2rW6YXRCcT0x9xCufRFnrhN8pM04+kJcnvnaDqWg8ubJKQaXheN0IuIH2+5qttvFKO7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6VH/W/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6C4C4CEF7;
	Mon,  9 Mar 2026 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773076940;
	bh=c7aX5fI7BtZLs0g0BTy5RmbjAQ0S7txzlahLBlrng3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6VH/W/Wr+lM6FJLE+/xk/xnYiDs2dL3Y46pekI8diIsnlUHMem0lXSrw3zcRi1x1
	 lnB3sJ+l+jgKxE53ztzAuGH/9Kn3tVV6oHIEvR94wM1pxx4vO+2drj/eHD3F1tP8N3
	 1sSGy9SqY54uMCPws6/8V9JcypjORfeYQ3jMT4dUouiLnkwG6E8aipsUXvX/pAoGIy
	 +S4q1TN3PUl1eocyeOBCDOVQ3JoCorOCTH8dutJSfNeYVV9UXoEzuK/G+2uCPNJMXh
	 w6WiFDM+2HG0EZgjM/nCiViqhhdvPn7zq9e74uvEFXY0gi1XQaVpfn3pC6ivuSd38z
	 IdnbMqXBZV78w==
Date: Mon, 9 Mar 2026 10:22:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 2/8] xfs: flush dirty pagecache over hole in zoned
 mode zero range
Message-ID: <20260309172219.GM6033@frogsfrogsfrogs>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309134506.167663-3-bfoster@redhat.com>
X-Rspamd-Queue-Id: 5F8D123D9B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79818-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:45:00AM -0400, Brian Foster wrote:
> For zoned filesystems a window exists between the first write to a
> sparse range (i.e. data fork hole) and writeback completion where we
> might spuriously observe holes in both the COW and data forks. This
> occurs because a buffered write populates the COW fork with
> delalloc, writeback submission removes the COW fork delalloc blocks
> and unlocks the inode, and then writeback completion remaps the
> physically allocated blocks into the data fork. If a zero range
> operation does a lookup during this window where both forks show a
> hole, it incorrectly reports a hole mapping for a range that
> contains data.
> 
> This currently works because iomap checks for dirty pagecache over
> holes and unwritten mappings. If found, it flushes and retries the
> lookup. We plan to remove the hole flush logic from iomap, however,
> so lift the flush into xfs_zoned_buffered_write_iomap_begin() to
> preserve behavior and document the purpose for it. Zoned XFS
> filesystems don't support unwritten extents, so if zoned mode can
> come up with a way to close this transient hole window in the
> future, this flush can likely be removed.

Why does the mapping disappear out of both data and cow forks between
writeback setup and completion?  IIRC it is because the writeback ioend
effectively owns the unwritten mapping.  We want another writer thread
to see the hole and reserve its own out-of-place write because the write
mapping that writeback's working on is immutable once the disk actually
writes it.  Right?

I wonder if we could stash a delalloc mapping in the cow fork with zero
indlen during writeback to signal "get a real zoned space reservation"?

> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/xfs/xfs_iomap.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 8c3469d2c73e..0e323e4e304b 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1590,6 +1590,7 @@ xfs_zoned_buffered_write_iomap_begin(
>  {
>  	struct iomap_iter	*iter =
>  		container_of(iomap, struct iomap_iter, iomap);
> +	struct address_space	*mapping = inode->i_mapping;
>  	struct xfs_zone_alloc_ctx *ac = iter->private;
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -1614,6 +1615,7 @@ xfs_zoned_buffered_write_iomap_begin(
>  	if (error)
>  		return error;
>  
> +restart:
>  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
>  	if (error)
>  		return error;
> @@ -1686,8 +1688,25 @@ xfs_zoned_buffered_write_iomap_begin(
>  	 * When zeroing, don't allocate blocks for holes as they are already
>  	 * zeroes, but we need to ensure that no extents exist in both the data
>  	 * and COW fork to ensure this really is a hole.
> +	 *
> +	 * A window exists where we might observe a hole in both forks with
> +	 * valid data in cache. Writeback removes the COW fork blocks on
> +	 * submission but doesn't remap into the data fork until completion. If
> +	 * the data fork was previously a hole, we'll fail to zero. Until we
> +	 * find a way to avoid this transient state, check for dirty pagecache
> +	 * and flush to wait on blocks to land in the data fork.
>  	 */
>  	if ((flags & IOMAP_ZERO) && srcmap->type == IOMAP_HOLE) {
> +		if (filemap_range_needs_writeback(mapping, offset,
> +						  offset + count - 1)) {
> +			xfs_iunlock(ip, lockmode);
> +			error = filemap_write_and_wait_range(mapping, offset,
> +							    offset + count - 1);

Two tab indents, please.

--D

> +			if (error)
> +				return error;
> +			goto restart;
> +		}
> +
>  		xfs_hole_to_iomap(ip, iomap, offset_fsb, end_fsb);
>  		goto out_unlock;
>  	}
> -- 
> 2.52.0
> 
> 

