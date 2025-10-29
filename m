Return-Path: <linux-fsdevel+bounces-66339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E597C1C21D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF89B34BE50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F93358CA;
	Wed, 29 Oct 2025 16:36:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0CD30DEA2;
	Wed, 29 Oct 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755763; cv=none; b=BiO/Ym0ffEYTrJNKXIaIfxzUDepAauKPsFlRsWT1asPec9JVrjrUI3mMJrCnBHlSoSb/nmlirYXNNDNE84EXVwnMqYmH2q73PpBNt4uR4DU/KlOZoKawcJ1LXiWAxZPvKoGEsKD0l913IgQ6V22VMeiZYqecWbtwlbDM+QGG6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755763; c=relaxed/simple;
	bh=rCPwdW66hmOMy38Ru7EC/7oVCnr+6Ip/6njz2+9TvDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PydTEug0ViZQR/9HqMcxYg4zwtCT4ju9rC7eLuFM10O+6v/EVJNbd7+28W9MEbRqX5hbgM2F1VLfC0C9q6qV0Px87PpZldqw+9Y+3FlL+/JilPqqgZtDTgT0O2p1Znua8o9oe73ppQyLBPOH/h/ONkHXThhR2uoYGEEEX3bB+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4510F227A8E; Wed, 29 Oct 2025 17:35:56 +0100 (CET)
Date: Wed, 29 Oct 2025 17:35:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
Message-ID: <20251029163555.GB26985@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <20251029071537.1127397-5-hch@lst.de> <20251029155306.GC3356773@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029155306.GC3356773@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

[Adding Qu and the btrfs list]

On Wed, Oct 29, 2025 at 08:53:06AM -0700, Darrick J. Wong wrote:
> > +	if (mapping_stable_writes(iocb->ki_filp->f_mapping)) {
> > +		xfs_info_once(mp,
> > +			"falling back from direct to buffered I/O for write");
> > +		return -ENOTBLK;
> > +	}
> 
> /me wonders if the other filesystems will have to implement this same
> fallback and hence this should be a common helper ala
> dio_warn_stale_pagecache?  But we'll get there when we get there.

As far as I'm concerned they should.  Btrfs in fact has recently done
that, as they are even more exposed due to the integrated checksumming.

So yes, a common helper might make sense.  Especially if we want common
configuration for opt-outs eventually.

> >  	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> > -	file->f_mode |= FMODE_DIO_PARALLEL_WRITE;
> > -	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
> > -		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
> > +	if (!mapping_stable_writes(file->f_mapping)) {
> > +		file->f_mode |= FMODE_DIO_PARALLEL_WRITE;
> 
> Hrm.  So parallel directio writes are disabled for writes to files on
> stable_pages devices because we have to fall back to buffered writes.
> Those serialize on i_rwsem so that's why we don't set
> FMODE_DIO_PARALLEL_WRITE, correct?

Yes.

> There's not some more subtle reason
> for not supporting it, right?

Not that I know of anyway.


