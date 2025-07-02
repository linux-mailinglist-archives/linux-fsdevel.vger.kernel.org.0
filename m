Return-Path: <linux-fsdevel+bounces-53717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E0AF61CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE39B1C4458E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDC926B0A5;
	Wed,  2 Jul 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE5VIa3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D221B9C9;
	Wed,  2 Jul 2025 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482212; cv=none; b=lo5AhJVPr0Xa0Kk/zsQdqFlytT5eoBa62D2FlJzuQqh67QtH+kgSunn88V5WiTa7ZCH0pE82E5xtHUSLRpZa9b7BQMrMZm7GAMUmQFEYYTCTjW4Pjsk26H2aJsKmUOGrczcJQVuEhR3oWAOg+LikEuWgptFhRN4ng98yVPyRMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482212; c=relaxed/simple;
	bh=o38s9KW5xlL09If/ehLVMBXYY/kbSCjY6FI7qi81S48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYhQuSZ0ovgEPq9nNB5Az8LH5wDReE+flsuLI9MQstVTsJyhx0k3lTNdVGzNb3AFerzIMYSY7363E5YGPoH3PdAHiB+ZfHZK1Pr+ew9v8WtOj2HKsqFGHLLhouc6Fy1m3DJXvh7wBifRQZkPgkNYp9Umj0YH4lYzAR1+lgMi1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE5VIa3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B26C4CEE7;
	Wed,  2 Jul 2025 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751482210;
	bh=o38s9KW5xlL09If/ehLVMBXYY/kbSCjY6FI7qi81S48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cE5VIa3unfTIuwN5c3hc8ufJzNz+rbskyspGSVMI2zP6gbIGVCVmNm/GOqiPYXa27
	 WiJfiud82LYFAWQWUuyBUGQ+QT1TqkaGxTQpDVItcObfvBMJNH2ieuEruNRCjx11Ed
	 AjD/MAq1V+ldytYVXFBQfqtjLW+W+xpTfthwXOZIbT0j3QdJQ6OP1n6VJM6YML0hE7
	 oHS7p7ieTpUYEXz08wenTG0m5jWcIk+QzH/5ZhT0UUiGIJvqus6Vd3IShw9ONOlqWn
	 K3MWlAMSivYZsQ79tHUp/K20LAcZIISfZnfEvP2coY+hhVT2G3l6nyv4lWoEeFEI/Y
	 ekhdhgFAjsysg==
Date: Wed, 2 Jul 2025 11:50:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/7] xfs: fill dirty folios on zero range of unwritten
 mappings
Message-ID: <20250702185009.GX10009@frogsfrogsfrogs>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-6-bfoster@redhat.com>
 <20250609161219.GE6156@frogsfrogsfrogs>
 <aEgj4J0d1AppDCuH@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEgj4J0d1AppDCuH@bfoster>

On Tue, Jun 10, 2025 at 08:24:00AM -0400, Brian Foster wrote:
> On Mon, Jun 09, 2025 at 09:12:19AM -0700, Darrick J. Wong wrote:
> > On Thu, Jun 05, 2025 at 01:33:55PM -0400, Brian Foster wrote:
> > > Use the iomap folio batch mechanism to select folios to zero on zero
> > > range of unwritten mappings. Trim the resulting mapping if the batch
> > > is filled (unlikely for current use cases) to distinguish between a
> > > range to skip and one that requires another iteration due to a full
> > > batch.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  fs/xfs/xfs_iomap.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index b5cf5bc6308d..63054f7ead0e 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> ...
> > > @@ -1769,6 +1772,26 @@ xfs_buffered_write_iomap_begin(
> > >  		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
> > >  			end_fsb = eof_fsb;
> > >  
> > > +		/*
> > > +		 * Look up dirty folios for unwritten mappings within EOF.
> > > +		 * Providing this bypasses the flush iomap uses to trigger
> > > +		 * extent conversion when unwritten mappings have dirty
> > > +		 * pagecache in need of zeroing.
> > > +		 *
> > > +		 * Trim the mapping to the end pos of the lookup, which in turn
> > > +		 * was trimmed to the end of the batch if it became full before
> > > +		 * the end of the mapping.
> > > +		 */
> > > +		if (imap.br_state == XFS_EXT_UNWRITTEN &&
> > > +		    offset_fsb < eof_fsb) {
> > > +			loff_t len = min(count,
> > > +					 XFS_FSB_TO_B(mp, imap.br_blockcount));
> > > +
> > > +			end = iomap_fill_dirty_folios(iter, offset, len);
> > 
> > ...though I wonder, does this need to happen in
> > xfs_buffered_write_iomap_begin?  Is it required to hold the ILOCK while
> > we go look for folios in the mapping?  Or could this become a part of
> > iomap_write_begin?
> > 
> 
> Technically it does not need to be inside ->iomap_begin(). The "dirty
> check" just needs to be before the fs drops its own locks associated
> with the mapping lookup to maintain functional correctness, and that
> includes doing it before the callout in the first place (i.e. this is
> how the filemap_range_needs_writeback() logic works). I have various
> older prototype versions of that work that tried to do things a bit more
> generically in that way, but ultimately they seemed less elegant for the
> purpose of zero range.
> 
> WRT zero range, the main reason this is in the callback is that it's
> only required to search for dirty folios when the underlying mapping is
> unwritten, and we don't know that until the filesystem provides the
> mapping (and doing at after the fs drops locks is racy).

<nod>

> That said, if we eventually use this for something like buffered writes,
> that is not so much of an issue and we probably want to instead
> lookup/allocate/lock each successive folio up front. That could likely
> occur at the iomap level (lock ordering issues and whatnot
> notwithstanding).
> 
> The one caveat with zero range is that it's only really used for small
> ranges in practice, so it may not really be that big of a deal if the
> folio lookup occurred unconditionally. I think the justification for
> that is tied to broader using of batching in iomap, however, so I don't
> really want to force the issue unless it proves worthwhile. IOW what I'm
> trying to say is that if we do end up with a few more ops using this
> mechanism, it wouldn't surprise me if we just decided to deduplicate to
> the lowest common denominator implementation at that point (and do the
> lookups in iomap iter or something). We're just not there yet IMO.

<nod> I suppose it could be useful for performance reasons to try to
grab as many folios as we can while we still hold the ILOCK, though we'd
have to be careful about lock inversions.

--D

> 
> Brian
> 
> > --D
> > 
> > > +			end_fsb = min_t(xfs_fileoff_t, end_fsb,
> > > +					XFS_B_TO_FSB(mp, end));
> > > +		}
> > > +
> > >  		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> > >  	}
> > >  
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > 
> 
> 

