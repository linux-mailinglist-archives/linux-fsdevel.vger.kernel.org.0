Return-Path: <linux-fsdevel+bounces-11402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C68536D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55281B22CA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04F55FF01;
	Tue, 13 Feb 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCCw0gWT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121395FEEB;
	Tue, 13 Feb 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844082; cv=none; b=P30IqzBYnM+IIx7gdLTgrsvPJto59fFtJNe4Y93BGvfs2Tc5VGS7oy5ly3QGvMSDDupHWfnhSroLum/tTk/o5zIRlwRPmgQVzhzWt1dkELktZWrQ00yaRxhOTGFZykAaVjU6G27SxDruVVMmLOdJvIPYbN+PZOisHs7u7DTbxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844082; c=relaxed/simple;
	bh=kMKt48JtyhnSZZmYJ+tvCCqJgAdUtaJZ3EdoLQoxG8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMtiFnmue5DkO4yzaapB7Oti3qvzrl2jDEBtgmriu5tyUOeOOYFsYhT7pHJ0lAkaJap+vl54vEsvw7BTH2LeBYd8Xl/8KS+EMN1wGz8aHCOqu5kUtuTRFT5YKgMeWj8oTKBoETYf0Qz+baJbVpx3kgMiaB6OD6j6tgBIo0CDwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCCw0gWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72026C433F1;
	Tue, 13 Feb 2024 17:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707844081;
	bh=kMKt48JtyhnSZZmYJ+tvCCqJgAdUtaJZ3EdoLQoxG8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCCw0gWTjAL16cZFq1cKkWv34iqARLorO+GqyHVEmPmfKRM7IFt5RlIGulxSTJX+L
	 vNAsup03pZfjMdBvoSGqmT7lhjtiX0dIkIoCVZ/QdTvWUB7CyXztNE7xrPenIuZC6S
	 +mRelsv033/oQl+98xqRrieXD3LkrMFIzlupPKBoHc1mG4B43fxU/bwRod84hDaQvx
	 hi1BbVvZRog4Da8V5cnnokfX2mBhuNf737SUxr/QXftnZviTv+4b5bQzS2aWu0BZ5G
	 TceR8R12VIk/+VS0N+j5eE0IohF+orI9ueQmDxwFzzKDVE4/J6VFemmWD9qRSMCSIW
	 JI3ze1A+iHe7A==
Date: Tue, 13 Feb 2024 09:08:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 2/6] fs: Add FS_XFLAG_ATOMICWRITES flag
Message-ID: <20240213170800.GZ6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-3-john.g.garry@oracle.com>
 <20240202175701.GI6184@frogsfrogsfrogs>
 <28399201-e99f-4b03-b2c0-b66cc0d21ce6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28399201-e99f-4b03-b2c0-b66cc0d21ce6@oracle.com>

On Mon, Feb 05, 2024 at 12:58:30PM +0000, John Garry wrote:
> On 02/02/2024 17:57, Darrick J. Wong wrote:
> > On Wed, Jan 24, 2024 at 02:26:41PM +0000, John Garry wrote:
> > > Add a flag indicating that a regular file is enabled for atomic writes.
> > 
> > This is a file attribute that mirrors an ondisk inode flag.  Actual
> > support for untorn file writes (for now) depends on both the iflag and
> > the underlying storage devices, which we can only really check at statx
> > and pwrite time.  This is the same story as FS_XFLAG_DAX, which signals
> > to the fs that we should try to enable the fsdax IO path on the file
> > (instead of the regular page cache), but applications have to query
> > STAT_ATTR_DAX to find out if they really got that IO path.
> 
> To be clear, are you suggesting to add this info to the commit message?

That and a S_ATOMICW flag for the inode that triggers the proposed
STAT_ATTR_ATOMICWRITES flag.

> > "try to enable atomic writes", perhaps? >
> > (and the comment for FS_XFLAG_DAX ought to read "try to use DAX for IO")
> 
> To me that sounds like "try to use DAX for IO, and, if not possible, fall
> back on some other method" - is that reality of what that flag does?

As hch said, yes.

--D

> Thanks,
> John
> 
> > 
> > --D
> > 
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   include/uapi/linux/fs.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > index a0975ae81e64..b5b4e1db9576 100644
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -140,6 +140,7 @@ struct fsxattr {
> > >   #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
> > >   #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
> > >   #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> > > +#define FS_XFLAG_ATOMICWRITES	0x00020000	/* atomic writes enabled */
> > >   #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
> > >   /* the read-only stuff doesn't really belong here, but any other place is
> > > -- 
> > > 2.31.1
> > > 
> > > 
> 
> 

