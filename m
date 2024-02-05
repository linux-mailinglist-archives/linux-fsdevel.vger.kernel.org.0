Return-Path: <linux-fsdevel+bounces-10377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A08B84A98E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBCE1F2C0AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC228487B8;
	Mon,  5 Feb 2024 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GmmxtjAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81134482E1;
	Mon,  5 Feb 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173377; cv=none; b=UD6JQUaILJmkEPEvyzyGKkF4nDYN4+afPIyNfDkVDqceKBAUfmrfD6WsCKrbtqDAqqnrQOVZihn0Szve9velCb2m0m/AN9Q7hfRWeza/K6HnDdNcn64tev9ComPibOB6YzmTs56Hn+x5BCtsbkjF2unO9BZlrH4zWBq8th/5YCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173377; c=relaxed/simple;
	bh=gSkB5qu605nIllJgneK6rfkGevKPRemHKaMNIHlLHu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3odtMXZohcgj2VkaUTJDPTMEv24m0I7MRJYOKfqdT/mwDOUaY2eVOZsENH/08x3qZFEVZVruIaURH2/p8WPONcZHFspk52yiKqeaZxYCa/zPHYzOZ/gtdEsWqLUfehZQENNYZgToOjPX2qE8osK8SKq7vWs5LNZJyACO4wGRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GmmxtjAF; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Feb 2024 17:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707173373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6W/Apouukr79gnJbJL1r+WkWZbFFMLbtft/P9h8qhZ8=;
	b=GmmxtjAFOVCyVUw4gi0Ukee4FBUDFNFGT5cHObeMcXPcwYsglxek+UrabpTDmNn16fwhNr
	MOZhLO7pexGWpZrkTyM0QYaCnEGL5ReC62VtAvb4l7fzVdy6j1B4ImxNXOHhbjEOLkOZ/t
	njIJM/L9ehjIj2dYfP0v+AhG5Ev+iIg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.or
Subject: Re: [PATCH 2/6] fs: FS_IOC_GETUUID
Message-ID: <l2zdnuczo24zxc6z6hh7q5mmux3wr5iltscnrc7axdugt6ct2k@qzrpj6vc2ct5>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-3-kent.overstreet@linux.dev>
 <ZcFelmKPb374aebH@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcFelmKPb374aebH@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 06, 2024 at 09:17:58AM +1100, Dave Chinner wrote:
> On Mon, Feb 05, 2024 at 03:05:13PM -0500, Kent Overstreet wrote:
> > Add a new generic ioctls for querying the filesystem UUID.
> > 
> > These are lifted versions of the ext4 ioctls, with one change: we're not
> > using a flexible array member, because UUIDs will never be more than 16
> > bytes.
> > 
> > This patch adds a generic implementation of FS_IOC_GETFSUUID, which
> > reads from super_block->s_uuid; FS_IOC_SETFSUUID is left for individual
> > filesystems to implement.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: linux-fsdevel@vger.kernel.or
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  fs/ioctl.c              | 16 ++++++++++++++++
> >  include/uapi/linux/fs.h | 16 ++++++++++++++++
> >  2 files changed, 32 insertions(+)
> > 
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 76cf22ac97d7..858801060408 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -763,6 +763,19 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
> >  	return err;
> >  }
> >  
> > +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > +{
> > +	struct super_block *sb = file_inode(file)->i_sb;
> > +
> > +	if (WARN_ON(sb->s_uuid_len > sizeof(sb->s_uuid)))
> > +		sb->s_uuid_len = sizeof(sb->s_uuid);
> 
> A "get"/read only ioctl should not be change superblock fields -
> this is not the place for enforcing superblock filed constraints.
> Make a helper function super_set_uuid(sb, uuid, uuid_len) for the
> filesystems to call that does all the validity checking and then
> sets the superblock fields appropriately.

*nod* good thought...

> > +struct fsuuid2 {
> > +	__u32       fsu_len;
> > +	__u32       fsu_flags;
> > +	__u8        fsu_uuid[16];
> > +};
> 
> Nobody in userspace will care that this is "version 2" of the ext4
> ioctl. I'd just name it "fs_uuid" as though the ext4 version didn't
> ever exist.

I considered that - but I decided I wanted the explicit versioning,
because too often we live with unfixed mistakes because versioning is
ugly, or something?

Doing a new revision of an API should be a normal, frequent thing, and I
want to start making it a convention.

> 
> > +
> >  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
> >  #define FILE_DEDUPE_RANGE_SAME		0
> >  #define FILE_DEDUPE_RANGE_DIFFERS	1
> > @@ -215,6 +229,8 @@ struct fsxattr {
> >  #define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
> >  #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
> >  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> > +#define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
> > +#define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
> 
> 0x94 is the btrfs ioctl space, not the VFS space - why did you
> choose that? That said, what is the VFS ioctl space identifier? 'v',
> perhaps?

"Promoting ioctls from fs to vfs without revising and renaming
considered harmful"... this is a mess that could have been avoided if we
weren't taking the lazy route.

And 'v' doesn't look like it to me, I really have no idea what to use
here. Does anyone?

