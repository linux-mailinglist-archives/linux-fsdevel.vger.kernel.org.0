Return-Path: <linux-fsdevel+bounces-79830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N4bNT4Nr2nHMwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:11:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDF123E54E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 119DA3050435
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB5A3E5EEE;
	Mon,  9 Mar 2026 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1ehr5xu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFB3FB051;
	Mon,  9 Mar 2026 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078963; cv=none; b=tXNZHMgj5bEKR7rHxIfjWwoYFkF1zmCYnmCX/9ICkgrUxBoTamsne+N+TM8W3fexOhca/fwkr6EEZGkvX18V0rG8H3feO/AkBt47g+fU1Q5osJUgN9he/ilbequ+KlaYm3YlsalvpaMkcJBCu2vFsyZkXZgRal5trjaU4fY0e/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078963; c=relaxed/simple;
	bh=zqQ1M4c2Y7qiF4Yb6oHDeIKD+YastSuucsI4hR5wB0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5BipYOtSTZXpgmo1IPgzgysesy6EbLBdPhrmX7xClzzQZnYlMjzji/66oX2MkzFvDU5fmTYehmPHV2ykj9pOBecu44lcQwc1djrUIucUKTkYlsq2v/NtZQ+9mYHm2GSTcu1b1dv3zv9azX58DeSyviFXy52azShuiFZ4bwnRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1ehr5xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D14BC4CEF7;
	Mon,  9 Mar 2026 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773078963;
	bh=zqQ1M4c2Y7qiF4Yb6oHDeIKD+YastSuucsI4hR5wB0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1ehr5xunsGhI2ul9IZ21ExmgoTTA16YXbGjxk1KGocxdWmGGWa+JEifobDE1t7M2
	 lOVcaORnIFdytzQpk+5HarNc/39RT9MLKSihrEMTB/x/zVFBW9ChoaDG94spLXyCx7
	 ubedWUSVsVn18ziraRKzOybizGWrgfYUfbqTiXby9wmjptuupIhaH0lfgVmx35PRtH
	 yqOhxyI3I1Xd3T2i3nq080DPBJQ4as5xvZA/bmNOct0jhjmbqjxBKo75GGlR3BQ9w3
	 +QFFevzGa7IF1sLVd6ZsM58KjSAlllfC35QXfvaahsD0zMsiIK0Fa9GxJjPPkU3qIN
	 dez6HU0d9CPKg==
Date: Mon, 9 Mar 2026 10:56:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 8/8] xfs: report cow mappings with dirty pagecache for
 iomap zero range
Message-ID: <20260309175602.GR6033@frogsfrogsfrogs>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-9-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309134506.167663-9-bfoster@redhat.com>
X-Rspamd-Queue-Id: 8BDF123E54E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79830-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:45:06AM -0400, Brian Foster wrote:
> XFS has long supported the case where it is possible to have dirty
> data in pagecache backed by COW fork blocks and a hole in the data
> fork. This occurs for two reasons. On reflink enabled files, COW
> fork blocks are allocated with preallocation to help avoid
> fragmention. Second, if a mapping lookup for a write finds blocks in
> the COW fork, it consumes those blocks unconditionally. This might
> mean that COW fork blocks are backed by non-shared blocks or even a
> hole in the data fork, both of which are perfectly fine.
> 
> This leaves an odd corner case for zero range, however, because it
> needs to distinguish between ranges that are sparse and thus do not
> require zeroing and those that are not. A range backed by COW fork
> blocks and a data fork hole might either be a legitimate hole in the
> file or a range with pending buffered writes that will be written
> back (which will remap COW fork blocks into the data fork).
> 
> This "COW fork blocks over data fork hole" situation has
> historically been reported as a hole to iomap, which then has grown
> a flush hack as a workaround to ensure zeroing occurs correctly. Now
> that this has been lifted into the filesystem and replaced by the
> dirty folio lookup mechanism, we can do better and use the pagecache
> state to decide how to report the mapping. If a COW fork range
> exists with dirty folios in cache, then report a typical shared
> mapping. If the range is clean in cache, then we can consider the
> COW blocks preallocation and call it a hole.
> 
> This doesn't fundamentally change behavior, but makes mapping
> reporting more accurate. Note that this does require splitting
> across the EOF boundary (similar to normal zero range) to ensure we
> don't spuriously perform post-eof zeroing. iomap will warn about
> zeroing beyond EOF because folios beyond i_size may not be written
> back.

Hrmm.  I wonder if IOMAP_REPORT should grow this new "expose dirty
unwritten cow fork mappings over a data fork hole" behavior too?  I
guess the only user of IOMAP_REPORT that might care is swapfile
activation, but that fsyncs the whole file to disk before starting the
iteration so I think it won't matter?

> Signed-off-by: Brian Foster <bfoster@redhat.com>

/me isn't sure he sees the point of doing this only for IOMAP_ZERO but
you're right that it's weird to pass a folio batch and a hole mapping to
iomap so

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index df240931f07a..3bef5ea610bb 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1786,6 +1786,7 @@ xfs_buffered_write_iomap_begin(
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>  	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
> +	xfs_fileoff_t		eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
>  	struct xfs_bmbt_irec	imap, cmap;
>  	struct xfs_iext_cursor	icur, ccur;
>  	xfs_fsblock_t		prealloc_blocks = 0;
> @@ -1868,7 +1869,8 @@ xfs_buffered_write_iomap_begin(
>  	 * cache and fill the iomap batch with folios that need zeroing.
>  	 */
>  	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> -		loff_t	start, end;
> +		loff_t		start, end;
> +		unsigned int	fbatch_count;
>  
>  		imap.br_blockcount = imap.br_startoff - offset_fsb;
>  		imap.br_startoff = offset_fsb;
> @@ -1883,15 +1885,32 @@ xfs_buffered_write_iomap_begin(
>  			goto found_imap;
>  		}
>  
> +		/* no zeroing beyond eof, so split at the boundary */
> +		if (offset_fsb >= eof_fsb)
> +			goto found_imap;
> +		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
> +			xfs_trim_extent(&imap, offset_fsb, eof_fsb - offset_fsb);
> +
>  		/* COW fork blocks overlap the hole */
>  		xfs_trim_extent(&imap, offset_fsb,
>  			    cmap.br_startoff + cmap.br_blockcount - offset_fsb);
>  		start = XFS_FSB_TO_B(mp, imap.br_startoff);
>  		end = XFS_FSB_TO_B(mp, imap.br_startoff + imap.br_blockcount);
> -		iomap_fill_dirty_folios(iter, &start, end, &iomap_flags);
> +		fbatch_count = iomap_fill_dirty_folios(iter, &start, end,
> +						       &iomap_flags);
>  		xfs_trim_extent(&imap, offset_fsb,
>  				XFS_B_TO_FSB(mp, start) - offset_fsb);
>  
> +		/*
> +		 * Report the COW mapping if we have folios to zero. Otherwise
> +		 * ignore the COW blocks as preallocation and report a hole.
> +		 */
> +		if (fbatch_count) {
> +			xfs_trim_extent(&cmap, imap.br_startoff,
> +					imap.br_blockcount);
> +			imap.br_startoff = end_fsb;	/* fake hole */
> +			goto found_cow;
> +		}
>  		goto found_imap;
>  	}
>  
> @@ -1901,8 +1920,6 @@ xfs_buffered_write_iomap_begin(
>  	 * unwritten extent.
>  	 */
>  	if (flags & IOMAP_ZERO) {
> -		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> -
>  		if (isnullstartblock(imap.br_startblock) &&
>  		    offset_fsb >= eof_fsb)
>  			goto convert_delay;
> -- 
> 2.52.0
> 
> 

