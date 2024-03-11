Return-Path: <linux-fsdevel+bounces-14168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28BE878A97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 23:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D364B1C20DA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 22:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E15732B;
	Mon, 11 Mar 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="RTqI2Z48"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194AB58229
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195154; cv=none; b=o9qJ2R4VLBXPoZeWdnFsqC60biTjOScPAl8xpzwGy+AsPILOXhtUpQTMhXzOmVpvgDVppvCGvE6Tfb+D5orJdBVnpUS5huS0LIJnyNKXq0rEJnrtnfJEFhdGt9xKWdIXHVcXCYBvC/lJ/A/tDyd2IP7gzc6cKTQWxIg3uSwZe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195154; c=relaxed/simple;
	bh=osu0hSiORSyIZpQ3dd416kqvq4IzeIB1wejEPaBnlik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrnzPDTkFZ3D9es+aFwhmp8JyRM2Ev8VeVxA5qfaJwBMV0tFOrtp042pJkOgdkQQcA8ZhVWXpix2vxlRNcCDNf3eHTOqgJq3L6wtakOHY2aqhGNAR5Mpe4PsGHGHGKr8LlSi46CsASmtfZvdacg3+fHeI8jpDPGNirNSOY/ieys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=RTqI2Z48; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e5d7f1f25fso2280442b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710195152; x=1710799952; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tQPLox6coVczJgg0u74CQV/by37pFi2dP23Pejr0Xzo=;
        b=RTqI2Z48fG/ip5+diNjwq/s+3flD3Zi1Ba+u6B9tUK0U+f4YOtQqVKNXihqAaU7YVl
         fw8qBk9pLqzudm4ajH6kL0u5vMvZfo01/pfQZDlGAtNgNzqF7ZjOQi4v4/bL3jjagXIa
         nzNr8hJmnq3HLf61AAfpVz5bnPmE53Fg26iM8FfPEY/enQ+dGUfXmSYO4jkzCE6aHebo
         zeQ0svAsR2kLl3PfLYvIduGP6lc4969a/lM4ogyClF0btiv0gNaIU9Sa45r7hM38OzR3
         1P+q62gsHyXyQv+v+WZL0uUoSn8HkjR3b68xKKeJDkXb1bhNfEzOsuyDKkINae9rwcqU
         YMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710195152; x=1710799952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQPLox6coVczJgg0u74CQV/by37pFi2dP23Pejr0Xzo=;
        b=cmF0ovoX8KKGLeO3xqi8zhjsGqD4cqB1jqD2RJF68wEqHGinAr4nNuevP+RaNZ4VtB
         b5P8JznL4HPEf03BhfuMw0DvwDMsVEgGulhsW9LE54/RoKvWivqvxYCT+brUQoIilHR3
         1BnElukHtKB50zPuS+8CLgzBtmdUABdMbgM2YtkhYXaFRwUWcb03xhgUAvzXvvpA7TNC
         vouZ1Pk1H18mZP0k0wKvVjFwmltxQ0TkUbv5xX5MXC08wwX7LuCgBgKJKw2HTsgf8wNJ
         dicCfJuIJ+EpyEvEoSxkiALpPUgI7U9LrXczez7JaOZA35DmtmLlZyvu0muVjhhIMj7L
         jo8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRqDPyHQwUq7ukOKgYj7OxciOl6ZHWALcgZEo3FmVdeOLnrE8E3CawhjUZZYVIFsK/OHYreX5qo6D+q/m5/iSqeZuYw+2EZG/Hu+ed3Q==
X-Gm-Message-State: AOJu0Yzg5mkGKS3Q+/F+xexEhdU+4U+Z0Pnn5yUq5Sg9+bF8gKjDp0xb
	exyhu8YYSTBGzdckqsjJ7s4UPRMMdVUr0Z8fRmssQYn9mU92Rkxuy3Lh8XgD2b0=
X-Google-Smtp-Source: AGHT+IHsPrYogruVW4mJKMDgJ2q1LIJp88fe4SdPPockPPpcW/D/vyRq0hbPBBvNUvbjpoP/PYjXNg==
X-Received: by 2002:a05:6a20:748c:b0:19e:ac58:7b0d with SMTP id p12-20020a056a20748c00b0019eac587b0dmr5917598pzd.5.1710195152095;
        Mon, 11 Mar 2024 15:12:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id a14-20020a62d40e000000b006e6629e6a76sm5055702pfh.137.2024.03.11.15.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 15:12:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rjnsi-000dQB-1R;
	Tue, 12 Mar 2024 09:12:28 +1100
Date: Tue, 12 Mar 2024 09:12:28 +1100
From: Dave Chinner <david@fromorbit.com>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Message-ID: <Ze+BzMyBp1vRIDKv@dread.disaster.area>
References: <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area>
 <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <ZervrVoHfZzAYZy4@google.com>
 <Ze5YUUUQqaZsPjql@dread.disaster.area>
 <Ze7IbSKzvCYRl2Ox@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze7IbSKzvCYRl2Ox@google.com>

On Mon, Mar 11, 2024 at 10:01:33AM +0100, Günther Noack wrote:
> On Mon, Mar 11, 2024 at 12:03:13PM +1100, Dave Chinner wrote:
> > On Fri, Mar 08, 2024 at 12:03:01PM +0100, Günther Noack wrote:
> > > On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
> > > > On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> > > > > I have no idea what a "safe" ioctl means here. Subsystems already
> > > > > restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> > > > > "safe" clearly means something different here.
> > > > 
> > > > That was my problem with the first version as well, but I think
> > > > drawing the line between "implemented in fs/ioctl.c" and
> > > > "implemented in a random device driver fops->unlock_ioctl()"
> > > > seems like a more helpful definition.
> > > 
> > > Yes, sorry for the confusion - that is exactly what I meant to say with "safe".:
> > > 
> > > Those are the IOCTL commands implemented in fs/ioctl.c which do not go through
> > > f_ops->unlocked_ioctl (or the compat equivalent).
> > 
> > Which means all the ioctls we wrequire for to manage filesystems are
> > going to be considered "unsafe" and barred, yes?
> > 
> > That means you'll break basic commands like 'xfs_info' that tell you
> > the configuration of the filesystem. It will prevent things like
> > online growing and shrinking, online defrag, fstrim, online
> > scrubbing and repair, etc will not worki anymore. It will break
> > backup utilities like xfsdump, and break -all- the device management
> > of btrfs and bcachefs filesystems.
> > 
> > Further, all the setup and management of -VFS functionality- like
> > fsverity and fscrypt is actually done at the filesystem level (i.e
> > through ->unlocked_ioctl, no do_vfs_ioctl()) so those are all going
> > to get broken as well despite them being "vfs features".
> > 
> > Hence from a filesystem perspective, this is a fundamentally
> > unworkable definition of "safe".
> 
> As discussed further up in this thread[1], we want to only apply the IOCTL
> command filtering to block and character devices.  I think this should resolve
> your concerns about file system specific IOCTLs?  This is implemented in patch
> V10 going forward[2].

I think you misunderstand. I used filesystem ioctls as an obvious
counter argument to this "VFS-only ioctls are safe" proposal to show
that it fundamentally breaks core filesystem boot and management
interfaces. Operations to prepare filesystems for mount may require
block device ioctls to be run. i.e. block device ioctls are required
core boot and management interfaces.

Disallowing ioctls on block devices will break udev rules that set
up block devices on kernel device instantiation events. It will
break partitioning tools that need to read/modify/rescan the
partition table. This will prevent discard, block zeroing and
*secure erase* operations. It may prevent libblkid from reporting
optimal device IO parameters to filesystem utilities like mkfs. You
won't be able to mark block devices as read only.  Management of
zoned block devices will be impossible.

Then stuff like DM and MD devices (e.g. LVM, RAID, etc) simply won't
appear on the system because they can't be scanned, configured,
assembled, etc.

And so on.

The fundamental fact is that system critical block device ioctls are
implemented by generic infrastructure below the VFS layer. They have
their own generic ioctl layer - blkdev_ioctl() is equivalent of
do_vfs_ioctl() for the block layer.  But if we cut off everything
below ->unlocked_ioctl() at the VFS, then we simply can't run any
of these generic block device ioctls.

As I said: this proposal is fundamentally unworkable without
extensive white- and black-listing of individual ioctls in the
security policies. That's not really a viable situation, because
we're going to change code and hence likely silently break those
security policy lists regularly....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

