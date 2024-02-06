Return-Path: <linux-fsdevel+bounces-10425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 072B884B09F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D57CB2218B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16712FF9F;
	Tue,  6 Feb 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sBYs4aO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7E12D15B
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210023; cv=none; b=DGeEIz3kqdIGQ64yVYtt521kR3bjlAKtsLVuZXt1oiMaI7dFKADd5rpThNsKo/yhHbmamAnK2nLJbM5XZZg2MymRXuradH9c65JuHv9xHssyjen9lrRN2Ma8mdQXxXhIbrHIU5/k3RcCurelfzXJ70w1VOrMBc+wHqde420Ol0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210023; c=relaxed/simple;
	bh=SxQjK5o9m31vC6NqNadgVRjnw+ctZnP6AU8Uj28TlSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzTmiTCUHg8vtrEX3kLiO/Dhuih63l063LG1av8Jsw4t9ymAT71BrXpferML0gYSP5X4QJ6XX9mvkuv7WH7ZlCLru2s+yGi5HVS7sYGeN+ZKgtbGFrKgmJo5a2OrxQSVkOIyOyoSwGSjtKr3ePSGf6mzEY8bNmFLfFU1WjP3m6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sBYs4aO+; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 Feb 2024 04:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707210019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBttTWG6B/hRu2GKdAEHTEeg0dT4Isyo/6hlXj+LQvY=;
	b=sBYs4aO+Y++ATlpT84BjTAhvWvoR0GYL0haejynyHKmKzxc28Vx8Pg51rmmqil7SzLhoiI
	d5AdLXPE5ZwYz5sYyDaH9a+hTGsy6CsjgIIEBWj6XRBCRXJAap7LePIe9HRmGU7MVsnI1A
	zn+Kynfd1VuvtLUGES2isUkNIiqoSYY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.or, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 2/6] fs: FS_IOC_GETUUID
Message-ID: <nmmxuryl7shlwionp6htpiifwosyl53hwbeurkcwkxwxb4ikdk@yxmtogitrx5w>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-3-kent.overstreet@linux.dev>
 <ZcFelmKPb374aebH@dread.disaster.area>
 <l2zdnuczo24zxc6z6hh7q5mmux3wr5iltscnrc7axdugt6ct2k@qzrpj6vc2ct5>
 <CAOQ4uxjvEL4P4vV5SKpHVS5DtOwKpxAn4n4+Kfqawcu+H-MC5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjvEL4P4vV5SKpHVS5DtOwKpxAn4n4+Kfqawcu+H-MC5g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 06, 2024 at 10:24:45AM +0200, Amir Goldstein wrote:
> On Tue, Feb 6, 2024 at 12:49 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Tue, Feb 06, 2024 at 09:17:58AM +1100, Dave Chinner wrote:
> > > On Mon, Feb 05, 2024 at 03:05:13PM -0500, Kent Overstreet wrote:
> > > > Add a new generic ioctls for querying the filesystem UUID.
> > > >
> > > > These are lifted versions of the ext4 ioctls, with one change: we're not
> > > > using a flexible array member, because UUIDs will never be more than 16
> > > > bytes.
> > > >
> > > > This patch adds a generic implementation of FS_IOC_GETFSUUID, which
> > > > reads from super_block->s_uuid; FS_IOC_SETFSUUID is left for individual
> > > > filesystems to implement.
> > > >
> 
> It's fine to have a generic implementation, but the filesystem should
> have the option to opt-in for a specific implementation.
> 
> There are several examples, even with xfs and btrfs where ->s_uuid
> does not contain the filesystem's UUID or there is more than one
> uuid and ->s_uuid is not the correct one to expose to the user.

Yeah, some of you were smoking some good stuff from the stories I've
been hearing...

> A model like ioctl_[gs]etflags() looks much more appropriate
> and could be useful for network filesystems/FUSE as well.

A filesystem needs to store two UUIDs (that identify the filesystem as a
whole).

 - Your internal UUID, which can never change because it's referenced in
   various other on disk data structures
 - Your external UUID, which identifies the filesystem to the outside
   world. Users want to be able to change this - which is why it has to
   be distinct from the internal UUID.

The internal UUID must never be exposed to the outside world, and that
includes the VFS; storing your private UUID in sb->s_uuid is wrong -
separation of concerns.

yes, I am aware of fscrypt, and yes, someone's going to have to fix
that.

This interface is only for the external/public UUID.

