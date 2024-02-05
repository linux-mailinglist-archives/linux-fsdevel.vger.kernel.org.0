Return-Path: <linux-fsdevel+bounces-10397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1175484AAEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 00:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C828AB98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD04CE06;
	Mon,  5 Feb 2024 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va3lu6Nc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A534D11B;
	Mon,  5 Feb 2024 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707177571; cv=none; b=kjNHYwySgcbyr8dRlWWPjuDhoUwRmVwltvWdm88m6BLrqOxOPCzGq6S7R8YfF4AwRfGtKBdrwsE0b4PTfsq2EP2Wj9rdX0mkcAax4FriehceUOKVn6hBZJhMSmMQ0aQoNIqEmY52aJ2DBjLm3XIEaYlEF3cCymwgl+PTRbnfEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707177571; c=relaxed/simple;
	bh=311rEKidzYaFW4/d84Q1AgvS1KB7if5JdpM6hqvaaio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSJMce713LXnE7uatxXyCKB6LoJWOFlySBQfO+azOt/OReGcYHoGlU+p/eHX81juVeNuAMirU+FdfotGAalVE8Qncef2cDwHiXuaoQfJN9OO+M0ez7Sl2xMI8lUYV7mrp60DOOtziRL2qwdKv8J8CgeVTfwKBUrf4d1YZWzUWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va3lu6Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2906AC433C7;
	Mon,  5 Feb 2024 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707177571;
	bh=311rEKidzYaFW4/d84Q1AgvS1KB7if5JdpM6hqvaaio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Va3lu6NcfuOkDZ0rurlc66h9UYINPbbON9v32BDL6fLEOoCWixiQbP/GsoYWNOA9c
	 WrfJ/1yk5q56bec70Pyx1deQVXeDTBl+jUu1HDjn1HjncpMvRYfEKTomPG8oxuGgVy
	 MnYK+k5MrGBa5pvBhh3dWjIlh5rTAwtrwOkVehDO9qJHq5osMC9cLHgN9AzIEgmpAE
	 /o7koH7OJOFk3JuAMj2OHiCiHYE/DSNlok7ASCCWyGxrMRLslbDkzf2HjCepbaYLaE
	 qrLHrMjXHSVC0YFmuyK+1Vr6HcFZWCwZ9yddbnpvxWPuxKSQ+cyyHMPEqzTLlO3h69
	 nA1nhIf9FgNRA==
Date: Mon, 5 Feb 2024 15:59:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.or
Subject: Re: [PATCH 2/6] fs: FS_IOC_GETUUID
Message-ID: <20240205235930.GP616564@frogsfrogsfrogs>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-3-kent.overstreet@linux.dev>
 <ZcFelmKPb374aebH@dread.disaster.area>
 <l2zdnuczo24zxc6z6hh7q5mmux3wr5iltscnrc7axdugt6ct2k@qzrpj6vc2ct5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l2zdnuczo24zxc6z6hh7q5mmux3wr5iltscnrc7axdugt6ct2k@qzrpj6vc2ct5>

On Mon, Feb 05, 2024 at 05:49:30PM -0500, Kent Overstreet wrote:
> On Tue, Feb 06, 2024 at 09:17:58AM +1100, Dave Chinner wrote:
> > On Mon, Feb 05, 2024 at 03:05:13PM -0500, Kent Overstreet wrote:
> > > Add a new generic ioctls for querying the filesystem UUID.
> > > 
> > > These are lifted versions of the ext4 ioctls, with one change: we're not
> > > using a flexible array member, because UUIDs will never be more than 16
> > > bytes.
> > > 
> > > This patch adds a generic implementation of FS_IOC_GETFSUUID, which
> > > reads from super_block->s_uuid; FS_IOC_SETFSUUID is left for individual
> > > filesystems to implement.
> > > 
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Dave Chinner <dchinner@redhat.com>
> > > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > > Cc: Theodore Ts'o <tytso@mit.edu>
> > > Cc: linux-fsdevel@vger.kernel.or
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > ---
> > >  fs/ioctl.c              | 16 ++++++++++++++++
> > >  include/uapi/linux/fs.h | 16 ++++++++++++++++
> > >  2 files changed, 32 insertions(+)
> > > 
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index 76cf22ac97d7..858801060408 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -763,6 +763,19 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
> > >  	return err;
> > >  }
> > >  
> > > +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > > +{
> > > +	struct super_block *sb = file_inode(file)->i_sb;
> > > +
> > > +	if (WARN_ON(sb->s_uuid_len > sizeof(sb->s_uuid)))
> > > +		sb->s_uuid_len = sizeof(sb->s_uuid);
> > 
> > A "get"/read only ioctl should not be change superblock fields -
> > this is not the place for enforcing superblock filed constraints.
> > Make a helper function super_set_uuid(sb, uuid, uuid_len) for the
> > filesystems to call that does all the validity checking and then
> > sets the superblock fields appropriately.
> 
> *nod* good thought...
> 
> > > +struct fsuuid2 {
> > > +	__u32       fsu_len;
> > > +	__u32       fsu_flags;
> > > +	__u8        fsu_uuid[16];
> > > +};
> > 
> > Nobody in userspace will care that this is "version 2" of the ext4
> > ioctl. I'd just name it "fs_uuid" as though the ext4 version didn't
> > ever exist.
> 
> I considered that - but I decided I wanted the explicit versioning,
> because too often we live with unfixed mistakes because versioning is
> ugly, or something?
> 
> Doing a new revision of an API should be a normal, frequent thing, and I
> want to start making it a convention.
> 
> > 
> > > +
> > >  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
> > >  #define FILE_DEDUPE_RANGE_SAME		0
> > >  #define FILE_DEDUPE_RANGE_DIFFERS	1
> > > @@ -215,6 +229,8 @@ struct fsxattr {
> > >  #define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
> > >  #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
> > >  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> > > +#define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
> > > +#define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
> > 
> > 0x94 is the btrfs ioctl space, not the VFS space - why did you
> > choose that? That said, what is the VFS ioctl space identifier? 'v',
> > perhaps?
> 
> "Promoting ioctls from fs to vfs without revising and renaming
> considered harmful"... this is a mess that could have been avoided if we
> weren't taking the lazy route.
> 
> And 'v' doesn't look like it to me, I really have no idea what to use
> here. Does anyone?

I thought it was 'f' but apparently that's ext?

--D

