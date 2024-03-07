Return-Path: <linux-fsdevel+bounces-13931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159DF875972
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6CE287DE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC2513B7A2;
	Thu,  7 Mar 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFnBYldS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5524B33;
	Thu,  7 Mar 2024 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847552; cv=none; b=E6h7c812WMX1KwdLpyRpJOkC6IC5Wd7jTdb6sBWFT7UqDB8F71ARraLI6HU+JsV9/j+D19xK4qtIhpmOkj2SeCTim9G9lzw4Jcng+SgX/NRTFP30AYqExsSMirPcM3t1BI8D1ykJ+7jiUHd+nYny/uMO1eRT5ISpm0PeOQoy+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847552; c=relaxed/simple;
	bh=DqYfdI0D7/b0VkGK3sBgivez/zwT7fijueBnDZtQZaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLaSP9FhkQlTSi6293PV7+br/qRKF23ic+2/sudOYxSyKxs732w23oakzEIojJnHj9ShlYV1TsmdmkA6yGdl54E0QyTmcYC61zcGcCBTyNysfcjFPFyDELBxSwKTty0azZujKSjedG2LHL+x0EVhXxYlIJkixrGM/KcLZGUd/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFnBYldS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07886C433F1;
	Thu,  7 Mar 2024 21:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709847552;
	bh=DqYfdI0D7/b0VkGK3sBgivez/zwT7fijueBnDZtQZaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFnBYldSWkb12UoLEGWC1si4sijzz04+WQQ2deFlOYlez8wz0PoaW1D6N57leMlzv
	 JjhVUHzQDttWdyRgqm0UUk9/5y0Aj+moVhw8IPMmTLYP6FLqN4WgPB76s5d4iBycDk
	 BldFGiEqjwaOLz9bG5LD15Il6lquZj4A8jjeevSME7pg32LKg8O89oAfpGUeW+Llev
	 AFlOXLEhj8uR+AoKTKySWT1T3SnyOATaQdBbrGdhyYQezZsq79TYpxTxtpO3SErYb3
	 378EYVSdN8ULdYl7QtDrCY+rbT99l5tQzzpZmKTwTzRWZea0IcGMKcUqIUs6ddjPCn
	 fz28NJfe7LMpQ==
Date: Thu, 7 Mar 2024 13:39:11 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 05/24] fs: add FS_XFLAG_VERITY for verity files
Message-ID: <20240307213911.GQ1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-7-aalbersh@redhat.com>
 <20240304223548.GB17145@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304223548.GB17145@sol.localdomain>

On Mon, Mar 04, 2024 at 02:35:48PM -0800, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 08:10:28PM +0100, Andrey Albershteyn wrote:
> > @@ -641,6 +645,13 @@ static int fileattr_set_prepare(struct inode *inode,
> >  	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> >  		return -EINVAL;
> >  
> > +	/*
> > +	 * Verity cannot be set through FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS.
> > +	 * See FS_IOC_ENABLE_VERITY
> > +	 */
> > +	if (fa->fsx_xflags & FS_XFLAG_VERITY)
> > +		return -EINVAL;
> 
> This makes FS_IOC_SETFLAGS and FS_IOC_FSSETXATTR start failing on files that
> already have verity enabled.
> 
> An error should only be returned when the new flags contain verity and the old
> flags don't.

What if the old flags have it and the new ones don't?  Is that supposed
to disable fsverity?  Is removal of the verity information not supported?

I'm guessing that removal isn't supposed to happen, in which case the
above check ought to be:

	if (!!IS_VERITY(inode) != !!(fa->fsx_xflags & FS_XFLAG_VERITY))
		return -EINVAL;

Right?

--D

> - Eric
> 

