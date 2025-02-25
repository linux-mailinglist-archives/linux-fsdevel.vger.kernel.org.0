Return-Path: <linux-fsdevel+bounces-42596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646EFA448B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198DE164166
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE26419992E;
	Tue, 25 Feb 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7u83JB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BCF18C034;
	Tue, 25 Feb 2025 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505072; cv=none; b=ML765UakabD9voO/jlpzYx05sH3MG9hOzoLa/g97d8V3oPbKblFRGjNzVlqg32nVpkJWb6oPlZ6ae+Y0TqOPqmqsAM57q6pb6JxVw6M45v+DrPS0jGhqYORspEgF2S+sBKurfNHVhxWq7QYf1F215xi28bh4SZDPN896tQzMhsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505072; c=relaxed/simple;
	bh=GfOJ94UEFtr9KCJIYYUJVzye1Rk74YXHpVn5m+Jktmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a84expMXwf+tt0Sbda0IRvPtSTQQt9APhzhmSN6+xgl9Ll5i0V1pfOoATGZ/FSJYh/wD7q7fn+tFcjRn9QZobVHYD6sD8NUYUqt2SdTkwt9H7kc0x1zeTyCXduk9TZeXIfhGBqtyvQ2/MScCsT2Rjgb75RgQL0he5skIg1/hyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7u83JB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7521EC4CEDD;
	Tue, 25 Feb 2025 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505071;
	bh=GfOJ94UEFtr9KCJIYYUJVzye1Rk74YXHpVn5m+Jktmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7u83JB8UYQgNUI+A9EaeaxJ5kv1t1mZ3bhBQ2kUN6EqRGSfd5CwYGkZR6J//nYAE
	 YxRCTWB5JhKRscxS/az/P8xkBPeZ5f6NCTYRcfiXTtTY44QLS6j391htFQhS9rmdFo
	 2Dk1kGbUR2Ak+Vdy8HWTFfU0CHdAsWUWsj0alF1kkaqiyTJZaRmjY3RKZGV4YaCtXy
	 41zXDlf+S3pot1+wNLfylPZZ2Yyr57JH7PNP8LFE+8aApk1BoBeRaEIr5vITuGemvA
	 IUWQtKawTxFz/A7SlVuErv1H/3jVm/HR0mee3uik3zYiu3qDoHulYLFmJPILHXKZ1F
	 1jw1+DJ0wz3MA==
Date: Tue, 25 Feb 2025 09:37:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 06/11] xfs: Reflink CoW-based atomic write support
Message-ID: <20250225173750.GE6242@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-7-john.g.garry@oracle.com>
 <20250224203228.GI21808@frogsfrogsfrogs>
 <e1aa10da-046b-48a8-bb49-f494a5a2b383@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1aa10da-046b-48a8-bb49-f494a5a2b383@oracle.com>

On Tue, Feb 25, 2025 at 10:58:56AM +0000, John Garry wrote:
> On 24/02/2025 20:32, Darrick J. Wong wrote:
> > On Thu, Feb 13, 2025 at 01:56:14PM +0000, John Garry wrote:
> > > For CoW-based atomic write support, always allocate a cow hole in
> > > xfs_reflink_allocate_cow() to write the new data.
> > > 
> > > The semantics is that if @atomic is set, we will be passed a CoW fork
> > > extent mapping for no error returned.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_iomap.c   |  2 +-
> > >   fs/xfs/xfs_reflink.c | 12 +++++++-----
> > >   fs/xfs/xfs_reflink.h |  2 +-
> > >   3 files changed, 9 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index d61460309a78..ab79f0080288 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -865,7 +865,7 @@ xfs_direct_write_iomap_begin(
> > >   		/* may drop and re-acquire the ilock */
> > >   		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> > >   				&lockmode,
> > > -				(flags & IOMAP_DIRECT) || IS_DAX(inode));
> > > +				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
> > 
> > Now I'm /really/ think it's time for some reflink allocation flags,
> > because the function signature now involves two booleans...
> 
> ok, but the @convert_now arg is passed to other functions from
> xfs_reflink_allocate_cow() - so would you prefer to create a bool
> @convert_now inside xfs_reflink_allocate_cow() and pass that bool as before?
> Or pass the flags all the way down to end users of @convert_now?
> 
> > 
> > >   		if (error)
> > >   			goto out_unlock;
> > >   		if (shared)
> > > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> > > index 8428f7b26ee6..3dab3ba900a3 100644
> > > --- a/fs/xfs/xfs_reflink.c
> > > +++ b/fs/xfs/xfs_reflink.c
> > > @@ -435,7 +435,8 @@ xfs_reflink_fill_cow_hole(
> > >   	struct xfs_bmbt_irec	*cmap,
> > >   	bool			*shared,
> > >   	uint			*lockmode,
> > > -	bool			convert_now)
> > > +	bool			convert_now,
> > > +	bool			atomic)
> > 
> > ...but this can come later.
> 
> Do you mean that this would just be a new flag to set?

Sorry, I meant that the double booleans -> flags conversion could be a
cleanup patch at the end of the series.  But first we'd have to figure
out where we want the flags boundaries to be -- do we just pass the
IOMAP_{DIRECT,DAX,ATOMIC_*} flags directly to the reflink code and let
it figure out what to do?  Or do we make the xfs_iomap.c code translate
that into XFS_REFLINK_ALLOC_* flags?

Either way, that is not something that needs to be done in this patch.

> > Also, is atomic==true only for the> ATOMIC_SW operation?
> 
> Right, so I think that the variable (or new flag) can be renamed for that.
> 
> > I think so, but that's the unfortunate thing about
> > booleans.
> > 
> > >   {
> > >   	struct xfs_mount	*mp = ip->i_mount;
> > >   	struct xfs_trans	*tp;
> > > @@ -466,7 +467,7 @@ xfs_reflink_fill_cow_hole(
> > >   	*lockmode = XFS_ILOCK_EXCL;
> > >   	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
> > > -	if (error || !*shared)
> > > +	if (error || (!*shared && !atomic))
> > >   		goto out_trans_cancel;
> > >   	if (found) {
> > > @@ -566,7 +567,8 @@ xfs_reflink_allocate_cow(
> > >   	struct xfs_bmbt_irec	*cmap,
> > >   	bool			*shared,
> > >   	uint			*lockmode,
> > > -	bool			convert_now)
> > > +	bool			convert_now,
> > > +	bool 			atomic)
> > 
> > Nit:        ^ space before tab.
> 
> ok
> 
> > 
> > If the answer to the question above is 'yes' then with that nit fixed,
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> Thanks, but I will wait for your feedback to decide whether to pick that up.
> 
> John
> 

