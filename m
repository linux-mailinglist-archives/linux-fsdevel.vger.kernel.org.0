Return-Path: <linux-fsdevel+bounces-73484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F249D1ABF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDA653025717
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27F539341B;
	Tue, 13 Jan 2026 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgEnHaI2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646E346E54;
	Tue, 13 Jan 2026 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326751; cv=none; b=D4O3HAcvYbPVWVdRk+E4VCWBA60MHN2OEic/Q4K3GT4+wzNb6BEHa7A1Yu4tiU9LD7UoH5Q5AmbaR4B8bBI9pcq1p1PlvDD345mX5kermpk97Fm/MF67L3+zPg7lZfiH/lqa8ZdtsOc1JhWoPVIrzWG2o6Abp+O06BsMdWmfcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326751; c=relaxed/simple;
	bh=JVJhqbGmzD+zQrq9Wb8TW1M8vmovfrd6pNCgl2pl1O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm2Ef8YF7Vlkxjv1hYJt5rWs+1SKe18/1jJIEAujfcCnnA0nGM8hf6nEcuNe38jvCX9WVaSjHYm/Yc96C4DHQOS/6hBJQDr0SfbaCTxrCspoRZ4hsxizMhMun31a3LCJeEKUd6TUghJGsMxizRw//dNo+s4PpxJuS7E0xfOUFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgEnHaI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AD6C116C6;
	Tue, 13 Jan 2026 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768326750;
	bh=JVJhqbGmzD+zQrq9Wb8TW1M8vmovfrd6pNCgl2pl1O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgEnHaI2eH6G6c+UlMbDn0e/F559w3wNUJhD3D+EW5uz1J8WMyOmkFVIcHzELDJ0Q
	 QUIeBgbWt4k+tHjuwOwDdc8boKsvyNCww2Rq8eQxlsoBdP8h/fliQlKX6HPKZtpBqh
	 gfloknEzS7p6B8YAgCB6bRA0hR1E8Zfu4fTxeZLhc3KzrxCeChLLsm1+He2bXTLlmB
	 +lcrZJDt653T/lmSR/gXHvlQiBtLJIF2W+x8M0EIyIliKgXJGhmnxCmMqkTpPbRjUe
	 94Al46sQoSCejMLSN9/Hdt7q2Z1G7T2apIIx9/BeCydXGqGf5c8JI9plwswSajEgpY
	 F4rMpGsHw+DCw==
Date: Tue, 13 Jan 2026 09:52:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 1/22] fsverity: report validation errors back to the
 filesystem
Message-ID: <20260113175230.GV15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <dx6z2f5lrnevosqoqr4a2aa5bmxldmishn6ln22hvdkuxxmjqa@rddd4kri6bce>
 <20260113012911.GU15551@frogsfrogsfrogs>
 <7nix5lf63rm6hrkpr3y37culoiiz53rerj5lcur5bez6gbstc7@xgu6qwkx4qa6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7nix5lf63rm6hrkpr3y37culoiiz53rerj5lcur5bez6gbstc7@xgu6qwkx4qa6>

On Tue, Jan 13, 2026 at 11:27:49AM +0100, Andrey Albershteyn wrote:
> On 2026-01-12 17:29:11, Darrick J. Wong wrote:
> > > To: "Darrick J. Wong" <aalbersh@redhat.com>
> > 
> > Say    ^^^^^^^ what?
> 
> oh damn, sorry, that's my broken script
> 
> > 
> > On Mon, Jan 12, 2026 at 03:49:50PM +0100, Darrick J. Wong wrote:
> > > Provide a new function call so that validation errors can be reported
> > > back to the filesystem.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  fs/verity/verify.c              |  4 ++++
> > >  include/linux/fsverity.h        | 14 ++++++++++++++
> > >  include/trace/events/fsverity.h | 19 +++++++++++++++++++
> > >  3 files changed, 37 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> > > index 47a66f088f..ef411cf5d8 100644
> > > --- a/fs/verity/verify.c
> > > +++ b/fs/verity/verify.c
> > > @@ -271,6 +271,10 @@
> > >  		data_pos, level - 1, params->hash_alg->name, hsize, want_hash,
> > >  		params->hash_alg->name, hsize,
> > >  		level == 0 ? dblock->real_hash : real_hash);
> > > +	trace_fsverity_file_corrupt(inode, data_pos, params->block_size);
> > > +	if (inode->i_sb->s_vop->file_corrupt)
> > > +		inode->i_sb->s_vop->file_corrupt(inode, data_pos,
> > > +						 params->block_size);
> > 
> > If fserror_report[1] gets merged before this series, I think we should
> > add a new FSERR_ type and call fserror_report instead.
> > 
> > https://lore.kernel.org/linux-fsdevel/176826402610.3490369.4378391061533403171.stgit@frogsfrogsfrogs/T/#u
> 
> I see, will health monitoring also use these events? I mean if XFS's
> fsverity need to report corrupting error then

Yes, the stuff you put in xfs' ->file_corrupt function would get moved
to xfs' ->report_error function.  Something like:

static void
xfs_fs_report_error(
	const struct fserror_event	*event)
{
	if (event->inode && event->type == FSERR_VERITY &&
	    IS_VERITY(event->inode))
		xfs_inode_mark_sick(XFS_I(event->inode),
				XFS_SICK_INO_DATA);

	/* healthmon already knows about non-inode and metadata errors */
	if (event->inode && event->type != FSERR_METADATA)
		xfs_healthmon_report_file_ioerror(XFS_I(event->inode), event);
}

static const struct super_operations xfs_super_operations = {
	<snip>
	.report_error		= xfs_fs_report_error,
};

--D

> -- 
> - Andrey
> 
> 

