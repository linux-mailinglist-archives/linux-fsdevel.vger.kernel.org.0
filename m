Return-Path: <linux-fsdevel+bounces-10375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0617A84A949
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A5F1C261F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB51DDEE;
	Mon,  5 Feb 2024 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOz8cddh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5191DA2E;
	Mon,  5 Feb 2024 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172053; cv=none; b=bGtuY5Ppyxrhsd7saKUYBojtx+QgETQZ/peQZUYtk5pHevh3JYRKgdVqbT/HIwSbsZfYJKbab0rjqoJh4BvGSNckcal/Dyxhq1EJim8rr/2v1DnhXAGJyoHwNVIm3KZorMY50njCLfMrSuVRFOZvcWaF+2NmSq8/gfAVckZvmNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172053; c=relaxed/simple;
	bh=VgPZEFsjPxFWOJWslIFFnnk8V9OLOMScwT6wloqjZW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm053e7rvBOl8Sl/JmnZhr8MJEFTR2JSVB9qhmJhj82YBMSsn2H+Ra65yjYGS6xyANvb3On88Dy/LVx2bXmdiO0ZzKWqgIKnndH0VipoTEqe4B28v8vEwwOgayzKzy/vLF+r5vf12a4+E0Gu4ZgKLpTUf8GIel+sCAFAq+bTs0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOz8cddh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1E5C433F1;
	Mon,  5 Feb 2024 22:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707172052;
	bh=VgPZEFsjPxFWOJWslIFFnnk8V9OLOMScwT6wloqjZW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOz8cddhQO2oXsZMmqmj55BZxz+lfOZdddnWRhBGgH7aV5jO4z2FqiK0E2dKU+R+z
	 aIfBUn7anrIwfu3ZmJmCe6AszeJq3Lp7YaEuAqeF22fNX2snhvzz+flnhsB6q8Pxf3
	 OhMs0ff2cjcSyxXEkmADZjphuugzq11kOuzEYUdBH94IN4czgJQW+d5fhCk6gfOkRb
	 +azugqWICyfKC28Od1OVebgk+hgPHUYM5KOh+SwVZf4NmyZNny9Ndok2zPrEopikjw
	 rt1EicSQSBaGcNb+Jz04rcgqydQ80BKVacIx/NPpDm+9icGQ+U8sdGv03UNqqdZb5+
	 CL1u8ieD9T2Jw==
Date: Mon, 5 Feb 2024 14:27:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 4/6] fs: FS_IOC_GETSYSFSNAME
Message-ID: <20240205222732.GO616564@frogsfrogsfrogs>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-5-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205200529.546646-5-kent.overstreet@linux.dev>

On Mon, Feb 05, 2024 at 03:05:15PM -0500, Kent Overstreet wrote:
> Add a new ioctl for getting the sysfs name of a filesystem - the path
> under /sys/fs.
> 
> This is going to let us standardize exporting data from sysfs across
> filesystems, e.g. time stats.
> 
> The returned path will always be of the form "$FSTYP/$SYSFS_IDENTIFIER",
> where the sysfs identifier may be a UUID (for bcachefs) or a device name
> (xfs).
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/ioctl.c              | 17 +++++++++++++++++
>  include/linux/fs.h      |  1 +
>  include/uapi/linux/fs.h |  5 +++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 858801060408..cb3690811d3d 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -776,6 +776,20 @@ static int ioctl_getfsuuid(struct file *file, void __user *argp)
>  	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
>  }
>  
> +static int ioctl_getfssysfsname(struct file *file, void __user *argp)

ackpthspacesplease.

"ioctl_get_fs_sysfs_name"?

> +{
> +	struct super_block *sb = file_inode(file)->i_sb;
> +
> +	if (!strlen(sb->s_sysfs_name))
> +		return -ENOIOCTLCMD;
> +
> +	struct fssysfsname u = {};
> +
> +	snprintf(u.name, sizeof(u.name), "%s/%s", sb->s_type->name, sb->s_sysfs_name);

Does this actually guarantee that there will be a trailing null in the
output?  It's really stupid that GETFSLABEL can return an unterminated
string if the label is exactly the size of the char array.

> +
> +	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> +}
> +
>  /*
>   * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
>   * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
> @@ -861,6 +875,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>  	case FS_IOC_GETFSUUID:
>  		return ioctl_getfsuuid(filp, argp);
>  
> +	case FS_IOC_GETFSSYSFSNAME:

File System Ioctl Get File System System File System Name.

Yuck.

FS_IOC_GETSYSFSPATH?

Also, do we want to establish that this works for /sys/fs and
/sys/kernel/debug at the same time?

> +		return ioctl_getfssysfsname(filp, argp);
> +
>  	default:
>  		if (S_ISREG(inode->i_mode))
>  			return file_ioctl(filp, cmd, argp);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ff41ea6c3a9c..7f23f593f17c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1258,6 +1258,7 @@ struct super_block {
>  	char			s_id[32];	/* Informational name */
>  	uuid_t			s_uuid;		/* UUID */
>  	u8			s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
> +	char			s_sysfs_name[UUID_STRING_LEN + 1];
>  
>  	unsigned int		s_max_links;
>  
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 0389fea87db5..6dd14a453277 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -78,6 +78,10 @@ struct fsuuid2 {
>  	__u8        fsu_uuid[16];
>  };
>  
> +struct fssysfsname {
> +	__u8			name[64];
> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1
> @@ -231,6 +235,7 @@ struct fsxattr {
>  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
>  #define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
>  #define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
> +#define FS_IOC_GETFSSYSFSNAME		_IOR(0x94, 53, struct fssysfsname)

0x94 is btrfs, don't add things to their "name" space.

--D

>  
>  /*
>   * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
> -- 
> 2.43.0
> 
> 

