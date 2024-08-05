Return-Path: <linux-fsdevel+bounces-25011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B1947B33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A501C21131
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7167158DDC;
	Mon,  5 Aug 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Q7XfymlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C01803A;
	Mon,  5 Aug 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861988; cv=none; b=WedPEbAYycOQxNa0dg2kSW9haWWw2SqztgFmIwZoiU/HYImkghXyHry0DhklTBqvgHw2B+6r1ySyrLrhyY/PJj1nN/V5laRkjvDoq0ZBAuvqmcnyIYY6Ws2DeioZ2HUxhbOtAtYO1PhDpM/eysV9TeXn6T6/q61MnCbLEo3fHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861988; c=relaxed/simple;
	bh=qOsWAMDiq2Clu4LzrFVPMJFhiXipMC4Gs6gyCh7sW1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5hAv/Hd8ehTfo0UWL+k/y5IEYxmoIoXo5W1DcyOhHMzGbXyLg3AiYxZa4QZ+UxOBsQOUnBUmv9Se5U06pz+NIQK7QFXY0vlEKakI3zMntwXf2EnTthCCioZTglkwUk9h3fD/XC+vVa5cf/Ww0pSz6G0n+nU4ZsHKkQfiKQ27Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Q7XfymlX; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wcx542ZkKz9sSN;
	Mon,  5 Aug 2024 14:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1722861976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYO3adI1+xfD0J8UWHfGOa26AzQibf/gUQhzQh/b8sQ=;
	b=Q7XfymlXp8KO8qxjyIcI+IOTYgNPSIa5BCD/ywTWJEjMSyKhhgGaQbsuCk7iW2WK3fijmr
	Vk1DV21O6iSF8FocoFuh8oC+JHmEE+l0DDmIjwVf8gssU9QFMWK5B1BRcrmRrtj6617f9+
	pgkk7L1AaVnZ9FSm9D9g/B7Y+e+nSSYUEnAJkg7Sh00ouYgrGe0BqHfUH7fwXswJzw2dna
	uGLaDQf90r2+AqcOhx8Oeaypk6y+EFwCsdee8pOk82ZUeRbFtNjHsuVTgll3JtqdD9tRp3
	mqNixRZXlJa4TmQRXcgiij8/JeWymUqPQSI0pGPjhB8KtfuCeqfUS8WkOaR79A==
Date: Mon, 5 Aug 2024 12:46:08 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v11 10/10] xfs: enable block size larger than page size
 support
Message-ID: <20240805124608.jxtumw47y4zhpie7@quentin>
References: <20240726115956.643538-1-kernel@pankajraghav.com>
 <20240726115956.643538-11-kernel@pankajraghav.com>
 <20240729164159.GC6352@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729164159.GC6352@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4Wcx542ZkKz9sSN

On Mon, Jul 29, 2024 at 09:41:59AM -0700, Darrick J. Wong wrote:
> On Fri, Jul 26, 2024 at 01:59:56PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Page cache now has the ability to have a minimum order when allocating
> > a folio which is a prerequisite to add support for block size > page
> > size.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
> >  fs/xfs/libxfs/xfs_shared.h |  3 +++
> >  fs/xfs/xfs_icache.c        |  6 ++++--
> >  fs/xfs/xfs_mount.c         |  1 -
> >  fs/xfs/xfs_super.c         | 28 ++++++++++++++++++++--------
> >  include/linux/pagemap.h    | 13 +++++++++++++
> >  6 files changed, 45 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
> > index 0af5b7a33d055..1921b689888b8 100644
> > --- a/fs/xfs/libxfs/xfs_ialloc.c
> > +++ b/fs/xfs/libxfs/xfs_ialloc.c
> > @@ -3033,6 +3033,11 @@ xfs_ialloc_setup_geometry(
> >  		igeo->ialloc_align = mp->m_dalign;
> >  	else
> >  		igeo->ialloc_align = 0;
> > +
> > +	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
> > +		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
> > +	else
> > +		igeo->min_folio_order = 0;
> >  }
> >  
> >  /* Compute the location of the root directory inode that is laid out by mkfs. */
> > diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
> > index 2f7413afbf46c..33b84a3a83ff6 100644
> > --- a/fs/xfs/libxfs/xfs_shared.h
> > +++ b/fs/xfs/libxfs/xfs_shared.h
> > @@ -224,6 +224,9 @@ struct xfs_ino_geometry {
> >  	/* precomputed value for di_flags2 */
> >  	uint64_t	new_diflags2;
> >  
> > +	/* minimum folio order of a page cache allocation */
> > +	unsigned int	min_folio_order;
> > +
> >  };
> >  
> >  #endif /* __XFS_SHARED_H__ */
> > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > index cf629302d48e7..0fcf235e50235 100644
> > --- a/fs/xfs/xfs_icache.c
> > +++ b/fs/xfs/xfs_icache.c
> > @@ -88,7 +88,8 @@ xfs_inode_alloc(
> >  
> >  	/* VFS doesn't initialise i_mode! */
> >  	VFS_I(ip)->i_mode = 0;
> > -	mapping_set_large_folios(VFS_I(ip)->i_mapping);
> > +	mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
> > +				    M_IGEO(mp)->min_folio_order);
> >  
> >  	XFS_STATS_INC(mp, vn_active);
> >  	ASSERT(atomic_read(&ip->i_pincount) == 0);
> > @@ -325,7 +326,8 @@ xfs_reinit_inode(
> >  	inode->i_uid = uid;
> >  	inode->i_gid = gid;
> >  	inode->i_state = state;
> > -	mapping_set_large_folios(inode->i_mapping);
> > +	mapping_set_folio_min_order(inode->i_mapping,
> > +				    M_IGEO(mp)->min_folio_order);
> >  	return error;
> >  }
> >  
> > diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> > index 3949f720b5354..c6933440f8066 100644
> > --- a/fs/xfs/xfs_mount.c
> > +++ b/fs/xfs/xfs_mount.c
> > @@ -134,7 +134,6 @@ xfs_sb_validate_fsb_count(
> >  {
> >  	uint64_t		max_bytes;
> >  
> > -	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
> >  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> >  
> >  	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 27e9f749c4c7f..b2f5a1706c59d 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1638,16 +1638,28 @@ xfs_fs_fill_super(
> >  		goto out_free_sb;
> >  	}
> >  
> > -	/*
> > -	 * Until this is fixed only page-sized or smaller data blocks work.
> > -	 */
> >  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> > -		xfs_warn(mp,
> > -		"File system with blocksize %d bytes. "
> > -		"Only pagesize (%ld) or less will currently work.",
> > +		size_t max_folio_size = mapping_max_folio_size_supported();
> > +
> > +		if (!xfs_has_crc(mp)) {
> > +			xfs_warn(mp,
> > +"V4 Filesystem with blocksize %d bytes. Only pagesize (%ld) or less is supported.",
> >  				mp->m_sb.sb_blocksize, PAGE_SIZE);
> > -		error = -ENOSYS;
> > -		goto out_free_sb;
> > +			error = -ENOSYS;
> > +			goto out_free_sb;
> > +		}
> > +
> > +		if (mp->m_sb.sb_blocksize > max_folio_size) {
> > +			xfs_warn(mp,
> > +"block size (%u bytes) not supported; Only block size (%ld) or less is supported",
> > +			mp->m_sb.sb_blocksize, max_folio_size);
> 
> Dumb nit: Please indent ^^^ this second line so that it doesn't start on
> the same column as the separate statement below it.
> 
Done :)

