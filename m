Return-Path: <linux-fsdevel+bounces-11409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2EC853951
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AF028CAD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F5760BAC;
	Tue, 13 Feb 2024 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Blf4h/D8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7FB60B87;
	Tue, 13 Feb 2024 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847195; cv=none; b=speFlRrP9liTcTuAMy34Ug8kLx5YYY0hGS3qSY5OpJm+x7YEfm3XnsXd6lCL4D2YhNG0VKlgTPnvtF/KZHMPaiqVe4gSOcx7/N7jRh658p/lTx99hCm9uFW/8HEmy1THqn5u1VvnuaHVk8BYc1SNSdqziKW8qLqjoX1XbIshKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847195; c=relaxed/simple;
	bh=EKKuv0v0Xfvbf7sIA0UUwvtI1/vskOEIWUwplXbuuls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJxGxa87xWt0XEqYylGDWglgP3sy0P2IyDIynwal+rKj3SPSu29GOBjvALPqE4GS0uY8f3JyosS0+E5MW55lAo+BBags+K7BHbLvA99koqcXhEaF2gFpAAeDYbDuQkIJdB2wbyVBx4Rrpv0eJ/K0Ui++SRtSx2HPJ8VnpMw3si4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Blf4h/D8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79BEC433C7;
	Tue, 13 Feb 2024 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707847195;
	bh=EKKuv0v0Xfvbf7sIA0UUwvtI1/vskOEIWUwplXbuuls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Blf4h/D8mCLYwDGS7d0MLXEril8zI2cFOoaK0yZ9HN9yLjeBcofbz3FRwzNKabKg2
	 UrpsrdprTTu7GMLAfQ7IcAfe1Wqpw+SV8wgHnEtIRKIwfWjHCqOzI4Y6OShsCWdES7
	 zADh/vToZ6k1U9eUxNxnnScFaid+20oJB3ij1V5QloliizV7Tjg6nvRsGS1Yb+58U5
	 hhU9VP/eNOwQ3EOZgnOZU6JJKMqWhtf108uJwvwb/LfJjANbjeE9tujU5+bZbIEnu9
	 YGFhtl4JyYtf55Y5mmiSk9z7mvaPbQLly1V3LDAcYHply5x49h/Q51A5iOJ8P2wVy6
	 aAerR+svFdyzw==
Date: Tue, 13 Feb 2024 09:59:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 6/6] fs: xfs: Set FMODE_CAN_ATOMIC_WRITE for
 FS_XFLAG_ATOMICWRITES set
Message-ID: <20240213175954.GV616564@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-7-john.g.garry@oracle.com>
 <20240202180619.GK6184@frogsfrogsfrogs>
 <7e3b9556-f083-4c14-a48f-46242d1c744b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e3b9556-f083-4c14-a48f-46242d1c744b@oracle.com>

On Mon, Feb 05, 2024 at 10:26:43AM +0000, John Garry wrote:
> On 02/02/2024 18:06, Darrick J. Wong wrote:
> > On Wed, Jan 24, 2024 at 02:26:45PM +0000, John Garry wrote:
> > > For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
> > > flag.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_file.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index e33e5e13b95f..1375d0089806 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1232,6 +1232,8 @@ xfs_file_open(
> > >   		return -EIO;
> > >   	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
> > >   			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
> > > +	if (xfs_inode_atomicwrites(XFS_I(inode)))
> 
> Note to self: This should also check if O_DIRECT is set
> 
> > 
> > Shouldn't we check that the device supports AWU at all before turning on
> > the FMODE flag?
> 
> Can we easily get this sort of bdev info here?
> 
> Currently if we do try to issue an atomic write and AWU for the bdev is
> zero, then XFS iomap code will reject it.

Hmm.  Well, if we move towards pushing all the hardware checks out of
xfs/iomap and into whatever goes on underneath submit_bio then I guess
we don't need to check device support here at all.

--D

> Thanks,
> John
> 
> > 
> > --D
> > 
> > > +		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
> > >   	return generic_file_open(inode, file);
> > >   }
> > > -- 
> > > 2.31.1
> > > 
> > > 
> 
> 

