Return-Path: <linux-fsdevel+bounces-13937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A18759F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF171F245A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D228014198B;
	Thu,  7 Mar 2024 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYeC4xdH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9613BAEF;
	Thu,  7 Mar 2024 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849193; cv=none; b=qUkRifX4/S+weRQFG2h630NQAuZ2o/qBUUvXSMgVRybyCcyYy/Ys8K+Jck3lHRxJJ2dCuKZjKsIxJ+d2QofXFHh8WtMN81IndavqAtyek98EAUg/owWI8aqJzBIW/6FfO/JP2svmGfOq+fShpiwjTwkU9mUgmO9auA3EzWy28IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849193; c=relaxed/simple;
	bh=/bG8Q3F58RI//DAzOHq8g3U/oNqq2eaBGYh3sgI6/Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3RCON+U4hj9kw0goJuxUfELk2OY36G79mwXoP1Qf738HzzwmgJ0ATyEWSMn2x6n7LYtplF8eZyO9Q6dvMXERP8MNsPQ+iOaOYdxW5QTYIXf0MBsugpGZOv6UPoalYtE91PBGLAYAoHwX4fBbUllYaGbNIZA4KXWEBkgKUe/ed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYeC4xdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D8EC433C7;
	Thu,  7 Mar 2024 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849192;
	bh=/bG8Q3F58RI//DAzOHq8g3U/oNqq2eaBGYh3sgI6/Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYeC4xdH4KmqV6zEqgBoInUL65WFk1xRPDUH53NH6kglFTWiJkM5QRkaIXoQzxHRB
	 o2xawj9+X9NF+Natui9Cbcf9xv+rxOX6mWYPICM6pUYcsdFwHepM4XzBwrR2Vo9xhP
	 RdjPmt3uWWfQfQUPB849n0PcOKijmLpWv/wpK3hBdCyY9e595nenfrs32oii1+GxIO
	 EbrwdokzSuehUpEdyVBqV5mEQcpBVY1KABm+1jvrL1MitC0bbuERmWate2taHDEX14
	 VsPtCCbF/Yflo4EROHKnNg0BHwgaoaZ2HdOS0z/DUvxHgitsh842fdaNo5U4l2du5w
	 WgxJ1Mq7MtQPw==
Date: Thu, 7 Mar 2024 14:06:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 05/24] fs: add FS_XFLAG_VERITY for verity files
Message-ID: <20240307220631.GB1799@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-7-aalbersh@redhat.com>
 <20240304223548.GB17145@sol.localdomain>
 <20240307213911.GQ1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307213911.GQ1927156@frogsfrogsfrogs>

On Thu, Mar 07, 2024 at 01:39:11PM -0800, Darrick J. Wong wrote:
> On Mon, Mar 04, 2024 at 02:35:48PM -0800, Eric Biggers wrote:
> > On Mon, Mar 04, 2024 at 08:10:28PM +0100, Andrey Albershteyn wrote:
> > > @@ -641,6 +645,13 @@ static int fileattr_set_prepare(struct inode *inode,
> > >  	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> > >  		return -EINVAL;
> > >  
> > > +	/*
> > > +	 * Verity cannot be set through FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS.
> > > +	 * See FS_IOC_ENABLE_VERITY
> > > +	 */
> > > +	if (fa->fsx_xflags & FS_XFLAG_VERITY)
> > > +		return -EINVAL;
> > 
> > This makes FS_IOC_SETFLAGS and FS_IOC_FSSETXATTR start failing on files that
> > already have verity enabled.
> > 
> > An error should only be returned when the new flags contain verity and the old
> > flags don't.
> 
> What if the old flags have it and the new ones don't?  Is that supposed
> to disable fsverity?  Is removal of the verity information not supported?
> 
> I'm guessing that removal isn't supposed to happen, in which case the
> above check ought to be:
> 
> 	if (!!IS_VERITY(inode) != !!(fa->fsx_xflags & FS_XFLAG_VERITY))
> 		return -EINVAL;
> 
> Right?

Yeah, good catch.  We need to prevent disabling the flag too.  How about:

	if ((fa->flags ^ old_ma->flags) & FS_VERITY_FL)
		return -EINVAL;

That would be consistent with how changes to other flags such as FS_APPEND_FL
and FS_IMMUTABLE_FL are detected earlier in the function.

- Eric

