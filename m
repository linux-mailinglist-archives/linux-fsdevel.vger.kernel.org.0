Return-Path: <linux-fsdevel+bounces-79839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDIwEJgTr2nJNQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:38:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C3723EB23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78DED301F4BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 18:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B11E37AA7B;
	Mon,  9 Mar 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VehPeTwg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694435F5F1;
	Mon,  9 Mar 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081489; cv=none; b=Ov12Cc+R+p/7Mr5jsMHQp5s6ATd1mWpJjQxgn/WwZiELHA+UfDxu9fiCIRJIdW9LJYiLrAZDFvUKmF80o9e6xp2aXIRvX3Dv2wZxvIHArmOw/sQJF3OLgjF8B9Fnq8E1rI61Vm3h0CHpwVJqFI42IQvSPQu6ixIEgdyH6jP7Z5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081489; c=relaxed/simple;
	bh=i+xt71aHCPOgKUuRNulfHzWARkqVhXEZq8CwSrmLxH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXCrLsHmmJrM4QfwGwhm/l4Kv5clXG9wDden16zcuG1jHMqfUDRIvhtGOvkyyMqU55o5WBSZc/vY1UKGwyVTpZnhptv4uLdSWc6EzfXrbolPtYyZZFclJh/gff4EFClPwo467BENg/1APyXq1xo6Fw3bXwcw12JUesJCs+hWNt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VehPeTwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A3AC4CEF7;
	Mon,  9 Mar 2026 18:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773081488;
	bh=i+xt71aHCPOgKUuRNulfHzWARkqVhXEZq8CwSrmLxH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VehPeTwgxXuwTsGV8f3jkcKQMk3hh6HObfWxxYl3vML2RyqHQcRFlX3HoPhevchaX
	 McUUwMHuCpnBI6/OKqje2FqBrVJCogHY74oT5eVF0fXmlp9moj0n/STeE9/y7w7GE0
	 4+AIUimk6hIbBQhfQnGi06uXFHHFkHsiXQnBEDghzRPfU9kpOcWnhT45nmOSqfED4/
	 Jr2PDpVuqlnlEQuDvnNFhllOl/6na7HP7MhDHrK9PpTjHxG465QbedBpjGVRYWUyQk
	 6d6E01cIon1jH/WN932Jf0HoagCVcKNzx/DdH12O3Qfqe9qRadOpFY8Zih/DBxeMu1
	 om97cmvOwtmIQ==
Date: Mon, 9 Mar 2026 11:38:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 8/8] xfs: report cow mappings with dirty pagecache for
 iomap zero range
Message-ID: <20260309183808.GS6033@frogsfrogsfrogs>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-9-bfoster@redhat.com>
 <20260309175602.GR6033@frogsfrogsfrogs>
 <aa8SAIBCokWCjTWJ@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8SAIBCokWCjTWJ@bfoster>
X-Rspamd-Queue-Id: F2C3723EB23
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
	TAGGED_FROM(0.00)[bounces-79839-lists,linux-fsdevel=lfdr.de];
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

On Mon, Mar 09, 2026 at 02:31:28PM -0400, Brian Foster wrote:
> On Mon, Mar 09, 2026 at 10:56:02AM -0700, Darrick J. Wong wrote:
> > On Mon, Mar 09, 2026 at 09:45:06AM -0400, Brian Foster wrote:
> > > XFS has long supported the case where it is possible to have dirty
> > > data in pagecache backed by COW fork blocks and a hole in the data
> > > fork. This occurs for two reasons. On reflink enabled files, COW
> > > fork blocks are allocated with preallocation to help avoid
> > > fragmention. Second, if a mapping lookup for a write finds blocks in
> > > the COW fork, it consumes those blocks unconditionally. This might
> > > mean that COW fork blocks are backed by non-shared blocks or even a
> > > hole in the data fork, both of which are perfectly fine.
> > > 
> > > This leaves an odd corner case for zero range, however, because it
> > > needs to distinguish between ranges that are sparse and thus do not
> > > require zeroing and those that are not. A range backed by COW fork
> > > blocks and a data fork hole might either be a legitimate hole in the
> > > file or a range with pending buffered writes that will be written
> > > back (which will remap COW fork blocks into the data fork).
> > > 
> > > This "COW fork blocks over data fork hole" situation has
> > > historically been reported as a hole to iomap, which then has grown
> > > a flush hack as a workaround to ensure zeroing occurs correctly. Now
> > > that this has been lifted into the filesystem and replaced by the
> > > dirty folio lookup mechanism, we can do better and use the pagecache
> > > state to decide how to report the mapping. If a COW fork range
> > > exists with dirty folios in cache, then report a typical shared
> > > mapping. If the range is clean in cache, then we can consider the
> > > COW blocks preallocation and call it a hole.
> > > 
> > > This doesn't fundamentally change behavior, but makes mapping
> > > reporting more accurate. Note that this does require splitting
> > > across the EOF boundary (similar to normal zero range) to ensure we
> > > don't spuriously perform post-eof zeroing. iomap will warn about
> > > zeroing beyond EOF because folios beyond i_size may not be written
> > > back.
> > 
> > Hrmm.  I wonder if IOMAP_REPORT should grow this new "expose dirty
> > unwritten cow fork mappings over a data fork hole" behavior too?  I
> > guess the only user of IOMAP_REPORT that might care is swapfile
> > activation, but that fsyncs the whole file to disk before starting the
> > iteration so I think it won't matter?
> > 
> 
> I'd have to take a closer look at that and some of the other iomap ops.
> I had similar thoughts in the past about whether this might help clean
> up seek hole/data and whatnot as well. For here it's primarily just a
> cleanup, but IMO it's better for iomap if it doesn't have to carry the
> caveat of "is this hole really a hole?"

Ooooh, right -- that does need to get fixed for SEEK_{DATA,HOLE} because
otherwise it'll miss dirty data over a cow preallocation.

> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > 
> > /me isn't sure he sees the point of doing this only for IOMAP_ZERO but
> > you're right that it's weird to pass a folio batch and a hole mapping to
> > iomap so
> > 
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > 
> 
> Thanks.

NP. :)

--D

> Brian
> 
> > --D
> > 
> > > ---
> > >  fs/xfs/xfs_iomap.c | 25 +++++++++++++++++++++----
> > >  1 file changed, 21 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index df240931f07a..3bef5ea610bb 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -1786,6 +1786,7 @@ xfs_buffered_write_iomap_begin(
> > >  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> > >  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> > >  	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
> > > +	xfs_fileoff_t		eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> > >  	struct xfs_bmbt_irec	imap, cmap;
> > >  	struct xfs_iext_cursor	icur, ccur;
> > >  	xfs_fsblock_t		prealloc_blocks = 0;
> > > @@ -1868,7 +1869,8 @@ xfs_buffered_write_iomap_begin(
> > >  	 * cache and fill the iomap batch with folios that need zeroing.
> > >  	 */
> > >  	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> > > -		loff_t	start, end;
> > > +		loff_t		start, end;
> > > +		unsigned int	fbatch_count;
> > >  
> > >  		imap.br_blockcount = imap.br_startoff - offset_fsb;
> > >  		imap.br_startoff = offset_fsb;
> > > @@ -1883,15 +1885,32 @@ xfs_buffered_write_iomap_begin(
> > >  			goto found_imap;
> > >  		}
> > >  
> > > +		/* no zeroing beyond eof, so split at the boundary */
> > > +		if (offset_fsb >= eof_fsb)
> > > +			goto found_imap;
> > > +		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
> > > +			xfs_trim_extent(&imap, offset_fsb, eof_fsb - offset_fsb);
> > > +
> > >  		/* COW fork blocks overlap the hole */
> > >  		xfs_trim_extent(&imap, offset_fsb,
> > >  			    cmap.br_startoff + cmap.br_blockcount - offset_fsb);
> > >  		start = XFS_FSB_TO_B(mp, imap.br_startoff);
> > >  		end = XFS_FSB_TO_B(mp, imap.br_startoff + imap.br_blockcount);
> > > -		iomap_fill_dirty_folios(iter, &start, end, &iomap_flags);
> > > +		fbatch_count = iomap_fill_dirty_folios(iter, &start, end,
> > > +						       &iomap_flags);
> > >  		xfs_trim_extent(&imap, offset_fsb,
> > >  				XFS_B_TO_FSB(mp, start) - offset_fsb);
> > >  
> > > +		/*
> > > +		 * Report the COW mapping if we have folios to zero. Otherwise
> > > +		 * ignore the COW blocks as preallocation and report a hole.
> > > +		 */
> > > +		if (fbatch_count) {
> > > +			xfs_trim_extent(&cmap, imap.br_startoff,
> > > +					imap.br_blockcount);
> > > +			imap.br_startoff = end_fsb;	/* fake hole */
> > > +			goto found_cow;
> > > +		}
> > >  		goto found_imap;
> > >  	}
> > >  
> > > @@ -1901,8 +1920,6 @@ xfs_buffered_write_iomap_begin(
> > >  	 * unwritten extent.
> > >  	 */
> > >  	if (flags & IOMAP_ZERO) {
> > > -		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> > > -
> > >  		if (isnullstartblock(imap.br_startblock) &&
> > >  		    offset_fsb >= eof_fsb)
> > >  			goto convert_delay;
> > > -- 
> > > 2.52.0
> > > 
> > > 
> > 
> 
> 

