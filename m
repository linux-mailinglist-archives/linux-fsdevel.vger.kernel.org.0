Return-Path: <linux-fsdevel+bounces-37190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E129EF1EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915421767DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66680242ABF;
	Thu, 12 Dec 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAVdikrs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC45223E81;
	Thu, 12 Dec 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020360; cv=none; b=brQaxMW8tyaPvuRMgBs7bKmKcBi4VuAsdeKb/4mFjtvC2P8tYEdEJP/e0f/NOiFxODiCc2V00AcNdXRhAQcFcscv9zj2IM5n32I11glKBVZmoXgTutAAZte3QZnSOLInHuogwCxblX7jEF0eqJ/37MbL1bPw5MDkFnJXlO0CTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020360; c=relaxed/simple;
	bh=3AlOJhFTa74OLr0nCvOAPlZ30e88mSroZvtJ8JdF1jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEI6itztq+yW49cqXpZZ22R46f5wp65oxymfV2aKdiXuMP7Hr6rXNS8HwR3pZq5gQMMWb6vQxQ5ss1SVzHIdeEukzKR+5oaSzWRQ+OC8Zf9CROtrhw2EzwM2/zhj9rIfdiyPPBpqWIb0nZ1vZIXP3JjIjvZyqStarfNBaXRF+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAVdikrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E316C4CECE;
	Thu, 12 Dec 2024 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734020360;
	bh=3AlOJhFTa74OLr0nCvOAPlZ30e88mSroZvtJ8JdF1jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAVdikrsaA4tJPnyQebLfJSNlbyz0F8ABNnwNk7leMEEX2zU/cJHsCMBxkb740hRN
	 BuwQ2hivIioOBgDuQRr+yr67sxla3T65BZ7+PgI1YTf3SvCtgh5OPGXMwpbAGPgPfQ
	 E6CQ4QLTJcDZqtOBUXIRi2BR9SoXNBaCOLHdDpkb5fDTT7EAJ3XBZZ/XJgERIp65yB
	 4Io/g6EHwGdN7OUamZp9uwgcRKsaiaMPwoKBFLiYksGypvczNotYZlbTTNG7k2ysxF
	 WrQYSjcj56XJ3f3jV/y0Ctbs7U0f7I4+1lM8azaszo3n8uzdyPb5TlZc9wckc6htPL
	 ebdV0doL9U5aQ==
Date: Thu, 12 Dec 2024 08:19:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR
 details
Message-ID: <20241212161919.GA6657@frogsfrogsfrogs>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181706.GB6678@frogsfrogsfrogs>
 <Z1oTOUCui9vTgNoM@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1oTOUCui9vTgNoM@dread.disaster.area>

On Thu, Dec 12, 2024 at 09:33:29AM +1100, Dave Chinner wrote:
> On Wed, Dec 11, 2024 at 10:17:06AM -0800, Darrick J. Wong wrote:
> > On Wed, Dec 11, 2024 at 01:24:03PM +0530, Ojaswin Mujoo wrote:
> > > Currently with stat we only show FS_IOC_FSGETXATTR details
> > > if the filesystem is XFS. With extsize support also coming
> > > to ext4 make sure to show these details when -c "stat" or "statx"
> > > is used.
> > > 
> > > No functional changes for filesystems other than ext4.
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  io/stat.c | 38 +++++++++++++++++++++-----------------
> > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/io/stat.c b/io/stat.c
> > > index 326f2822e276..d06c2186cde4 100644
> > > --- a/io/stat.c
> > > +++ b/io/stat.c
> > > @@ -97,14 +97,14 @@ print_file_info(void)
> > >  		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
> > >  }
> > >  
> > > -static void
> > > -print_xfs_info(int verbose)
> > > +static void print_extended_info(int verbose)
> > >  {
> > > -	struct dioattr	dio;
> > > -	struct fsxattr	fsx, fsxa;
> > > +	struct dioattr dio;
> > > +	struct fsxattr fsx, fsxa;
> > > +	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
> > >  
> > > -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > > -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> > > +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > > +		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {
> > 
> > Urgh... perhaps we should call FS_IOC_FSGETXATTR and if it returns zero
> > print whatever is returned, no matter what filesystem we think is
> > feeding us information?
> 
> Yes, please. FS_IOC_FSGETXATTR has been generic functionality for
> some time, we should treat it the same way for all filesystems.
> 
> > e.g.
> > 
> > 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> > 		if (is_xfs_fd || (errno != EOPNOTSUPP &&
> > 				  errno != ENOTTY))
> > 			perror("FS_IOC_GETXATTR");
> 
> Why do we even need "is_xfs_fd" there? XFS will never give a
> EOPNOTSUPP or ENOTTY error to this or the FS_IOC_GETXATTRA ioctl...

Yeah, in hindsight I don't think it's needed for FS_IOC_FSGETXATTR, but
it's definitely nice for XFS_IOC_FSGETXATTRA (which is not implemented
outside xfs) so that you don't get unnecessary error messages on ext4.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

