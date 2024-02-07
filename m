Return-Path: <linux-fsdevel+bounces-10544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD63384C18D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 01:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379271F24021
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AA7F515;
	Wed,  7 Feb 2024 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qwUJ5DxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947D6EEC4
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707267185; cv=none; b=LfTGayjimCY1rAnBCfOm5aFzCEFCeQ78N3MLUry0g7HnfrbeUVZ7oNU6/TkOnGGdthZI4/zysUgAiR01m1XYJGdmeDrhDLFSJFOA/fqPIW9hI7NRY1ORvcKyevPmd7Bb5oQROSUcF/xI9HbXmHlBG0UTqPO+Zo/PJ5X6Gsfmq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707267185; c=relaxed/simple;
	bh=i6MOU3XAf6ORd9eWxLKeFNLmu+/lfcJD3ylRSkOkZfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMJb/W0cz+2WnCRKdW/LrYDJOMf1LfcFceqxPSb0zId8tKcYnezSZm2ICqvIlmh9au3c/tt1vg6St/NiEReHl1KcromUTyrNym1LZwvZpf501NrDtXyBFtkicNq7k5TxvasVj/N6V2pjBkweCv2fRPJNT7nVEQRLIenbTjvKcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qwUJ5DxY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 Feb 2024 19:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707267180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xKJg4xDRPfxrmB09U1/OU0Wyf/oKOvuGfaF8SQKeioU=;
	b=qwUJ5DxYqSpZfutGhz4IjFVNbMmbJchD6Xs8Goyj2c0dLJns/fAD5iKCCBuY8a9hdE1fGY
	8ryIbZSG0MPPd2VNf2H1DfRcEiDZbW/9ZBOoMuV/bqGAMGTci4/8NEUkRj3RHvGIOvX7w4
	G8C0D31mwXazZukzt/DJD7ET04zq/rk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 5/7] fs: FS_IOC_GETSYSFSNAME
Message-ID: <kx372qkpaasuba7nnyk2u6g2plqc5nkojft4hn3vfbkauaxjkl@pphn5hoo7ixg>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-6-kent.overstreet@linux.dev>
 <ZcKyIMPy1D1o5Yla@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcKyIMPy1D1o5Yla@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 07, 2024 at 09:26:40AM +1100, Dave Chinner wrote:
> On Tue, Feb 06, 2024 at 03:18:53PM -0500, Kent Overstreet wrote:
> > Add a new ioctl for getting the sysfs name of a filesystem - the path
> > under /sys/fs.
> > 
> > This is going to let us standardize exporting data from sysfs across
> > filesystems, e.g. time stats.
> > 
> > The returned path will always be of the form "$FSTYP/$SYSFS_IDENTIFIER",
> > where the sysfs identifier may be a UUID (for bcachefs) or a device name
> > (xfs).
> > 
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  fs/ioctl.c              | 17 +++++++++++++++++
> >  include/linux/fs.h      |  1 +
> >  include/uapi/linux/fs.h | 10 ++++++++++
> >  3 files changed, 28 insertions(+)
> > 
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 046c30294a82..7c37765bd04e 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -776,6 +776,20 @@ static int ioctl_getfsuuid(struct file *file, void __user *argp)
> >  	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> >  }
> >  
> > +static int ioctl_get_fs_sysfs_path(struct file *file, void __user *argp)
> > +{
> > +	struct super_block *sb = file_inode(file)->i_sb;
> > +
> > +	if (!strlen(sb->s_sysfs_name))
> > +		return -ENOIOCTLCMD;
> 
> This relies on the kernel developers getting string termination
> right and not overflowing buffers.
> 
> We can do better, I think, and I suspect that starts with a
> super_set_sysfs_name() helper....

I don't think that's needed here; a standard snprintf() ensures that the
buffer is null terminated, even if the result overflowed.

> > +	struct fssysfspath u = {};
> 
> Variable names that look like the cat just walked over the keyboard
> are difficult to read. Please use some separators here! 
> 
> Also, same comment as previous about mixing code and declarations.
> 
> > +
> > +	snprintf(u.name, sizeof(u.name), "%s/%s", sb->s_type->name, sb->s_sysfs_name);
> 
> What happens if the combined path overflows the fssysfspath
> buffer?

It won't; s_sysfs_name is going to be either a UUID or a short device
name. It can't be a longer device name (like we show in /proc/mounts) -
here that would lead to ambiguouty.

> > +	char			s_sysfs_name[UUID_STRING_LEN + 1];
> 
> Can we just kstrdup() the sysfs name and keep a {ptr, len} pair
> in the sb for this? Then we can treat them as an opaque identifier
> that isn't actually a string, and we don't have to make up some
> arbitrary maximum name size, either.

What if we went in a different direction - take your previous suggestion
to have a helper for setting the name, and then enforce through the API
that the only valid identifiers are a UUID or a short device name.

super_set_sysfs_identifier_uuid(sb);
super_set_sysfs_identifier_device(sb);

then we can enforce that the identifier comes from either sb->s_uuid or
sb->s_dev.

I'll have to check existing filesystems before we commit to that,
though.

> 
> >  	unsigned int		s_max_links;
> >  
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 16a6ecadfd8d..c0f7bd4b6350 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -77,6 +77,10 @@ struct fsuuid2 {
> >  	__u8	uuid[16];
> >  };
> >  
> > +struct fssysfspath {
> > +	__u8			name[128];
> > +};
> 
> Undocumented magic number in a UAPI. Why was this chosen?

In this case, I think the magic number is fine - though it could use a
comment; since it only needs to be used in one place giving it a name is
a bit pointless.

As to why it was chosen - 64 is the next power of two size up from the
length of a uuid string length, and 64 should fit any UUID + filesystem
name. So took that and doubled it.

> IMO, we shouldn't be returning strings that require the the kernel
> to place NULLs correctly and for the caller to detect said NULLs to
> determine their length, so something like:
> 
> struct fs_sysfs_path {
> 	__u32			name_len;
> 	__u8			name[NAME_MAX];
> };
> 
> Seems better to me...

I suppose modern languages are getting away from the whole
nul-terminated string thing, heh

