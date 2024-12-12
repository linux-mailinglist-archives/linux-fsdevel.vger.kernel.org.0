Return-Path: <linux-fsdevel+bounces-37233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BA09EFDE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 22:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC421885584
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6211C2317;
	Thu, 12 Dec 2024 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chUhsNx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8E174EF0;
	Thu, 12 Dec 2024 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037681; cv=none; b=D/GI4WHESbOc2Ejapbqg2XQC2vR47P26lKwrs9rL+I7EKvuMMl5I7TNNeESK89IVdr6w4ScMaT5ssA3RGqu0ELd+ME3r4HKzAydxjlVOkM7PDwmsaw8oUVfmYoguidesPHhrsCyPFPUk0h7hNtmhCE3a47yG3mDLG0hj/jvA00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037681; c=relaxed/simple;
	bh=PBIseoIzz7QhT/pRERjDZ/l0g8VlNWxM4+wA3Tgo67g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwubHCCAnJvUlY5wWhlfBAaBVRYPSAyb3sX2iw+gCE8R5ULVsr9H5OG0NQA50b6EiYol6E0c2qHNQR/hPng3RvR8xrA1adacmjdPRhPDNnwMDECXRRHKk53SroKYMG06vFaDsUPnkUPunJ7qklg59D/Q+6AIgvz2FOowToWkJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chUhsNx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E54C4CECE;
	Thu, 12 Dec 2024 21:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734037679;
	bh=PBIseoIzz7QhT/pRERjDZ/l0g8VlNWxM4+wA3Tgo67g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chUhsNx1l66zDcZxhvbkFqarmrCfaQ+lpmIAvGwZ6+c23jD6RxX5KR7pcNWU/EWjv
	 67jHbT13ZQfjHmPbwgvnsLzSnbe9X2BYhBNEPXExqe6PP0UgM7pOBngY5yYThsn3Tt
	 6WG2IquDM3wxsZS9kY/1f6V9wevucU0P5FnMR+W5C5RX4gjErSseY1zKqlXJqMttXG
	 utPE/pVTjtoK1GZHHLbd/sELL3uJ2m0pGoCTJtRoSUhiWG1LBzcyVJlebeTjlr1AyE
	 cnes8Y1YtydhL4aM0Xj82mRMd5hGWJDyD3ThWV9BowCSFj7DNYPQ4idwWlQFG8QZ9D
	 LUZ1LPPvsKHAA==
Date: Thu, 12 Dec 2024 13:07:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR
 details
Message-ID: <20241212210758.GN6678@frogsfrogsfrogs>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181706.GB6678@frogsfrogsfrogs>
 <Z1oTOUCui9vTgNoM@dread.disaster.area>
 <20241212161919.GA6657@frogsfrogsfrogs>
 <Z1tLEQmRiZc7alBo@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1tLEQmRiZc7alBo@dread.disaster.area>

On Fri, Dec 13, 2024 at 07:44:01AM +1100, Dave Chinner wrote:
> On Thu, Dec 12, 2024 at 08:19:19AM -0800, Darrick J. Wong wrote:
> > On Thu, Dec 12, 2024 at 09:33:29AM +1100, Dave Chinner wrote:
> > > On Wed, Dec 11, 2024 at 10:17:06AM -0800, Darrick J. Wong wrote:
> > > > On Wed, Dec 11, 2024 at 01:24:03PM +0530, Ojaswin Mujoo wrote:
> > > > > Currently with stat we only show FS_IOC_FSGETXATTR details
> > > > > if the filesystem is XFS. With extsize support also coming
> > > > > to ext4 make sure to show these details when -c "stat" or "statx"
> > > > > is used.
> > > > > 
> > > > > No functional changes for filesystems other than ext4.
> > > > > 
> > > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > > ---
> > > > >  io/stat.c | 38 +++++++++++++++++++++-----------------
> > > > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > > > 
> > > > > diff --git a/io/stat.c b/io/stat.c
> > > > > index 326f2822e276..d06c2186cde4 100644
> > > > > --- a/io/stat.c
> > > > > +++ b/io/stat.c
> > > > > @@ -97,14 +97,14 @@ print_file_info(void)
> > > > >  		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
> > > > >  }
> > > > >  
> > > > > -static void
> > > > > -print_xfs_info(int verbose)
> > > > > +static void print_extended_info(int verbose)
> > > > >  {
> > > > > -	struct dioattr	dio;
> > > > > -	struct fsxattr	fsx, fsxa;
> > > > > +	struct dioattr dio;
> > > > > +	struct fsxattr fsx, fsxa;
> > > > > +	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
> > > > >  
> > > > > -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > > > > -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> > > > > +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > > > > +		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {
> > > > 
> > > > Urgh... perhaps we should call FS_IOC_FSGETXATTR and if it returns zero
> > > > print whatever is returned, no matter what filesystem we think is
> > > > feeding us information?
> > > 
> > > Yes, please. FS_IOC_FSGETXATTR has been generic functionality for
> > > some time, we should treat it the same way for all filesystems.
> > > 
> > > > e.g.
> > > > 
> > > > 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> > > > 		if (is_xfs_fd || (errno != EOPNOTSUPP &&
> > > > 				  errno != ENOTTY))
> > > > 			perror("FS_IOC_GETXATTR");
> > > 
> > > Why do we even need "is_xfs_fd" there? XFS will never give a
> > > EOPNOTSUPP or ENOTTY error to this or the FS_IOC_GETXATTRA ioctl...
> > 
> > Yeah, in hindsight I don't think it's needed for FS_IOC_FSGETXATTR, but
> 
> *nod*
> 
> > it's definitely nice for XFS_IOC_FSGETXATTRA (which is not implemented
> > outside xfs) so that you don't get unnecessary error messages on ext4.
> 
> I don't think we even need it for FS_IOC_GETXATTRA - if the
> filesystem does not support that ioctl, we don't print the fields,
> nor do we output an error.
> 
> After all, this "extended info" and it's only ever been printed
> for XFS, so we can define whatever semantics we want for foreign
> filesystem output right now. As long as XFS always prints the same
> info as it always has (i.e. all of it), we can do whatever we want
> with the foreign filesystem stuff.
> 
> Keep in mind that we don't need platform tests for XFS files - that
> has already been done when the file was opened and the state stored
> in file->flags via the IO_FOREIGN flag. We already use that in the
> stat_f() to determine whether we print the "xfs info" or not.
> 
> IOWs, I think all we need to do is  move where we check the
> IO_FOREIGN flag. i.e.:
> 
> print_extented_info(file)
> {
> 	struct dioattr  dio = {};
>         struct fsxattr  fsx = {}, fsxa = {};
> 
> 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> 		perror("FS_IOC_GETXATTR");
> 		exitcode = 1;
> 		return;
> 	}
> 
> 	printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
> 	printxattr(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
> 	printf(_("fsxattr.projid = %u\n"), fsx.fsx_projid);
> 	printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
> 	printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
> 	printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);
> 
> 	/* Only XFS supports FS_IOC_FSGETXATTRA and XFS_IOC_DIOINFO */
> 	if (file->flags & IO_FOREIGN)
> 		return;
> 
> 	if (ioctl(file->fd, FS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> 		perror("FS_IOC_GETXATTRA");
> 		exitcode = 1;
> 		return;
> 	}
> 	if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
> 		perror("XFS_IOC_DIOINFO");
> 		exitcode = 1;
> 		return;
> 	}
> 
> 	printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
> 	printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
> 	printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
> 	printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
> }
> 
> Thoughts?

Seems fine to me, though I'd print the fsxa before trying to call
DIOINFO.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

