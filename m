Return-Path: <linux-fsdevel+bounces-10528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A2484C000
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 23:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66CFEB25BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493AF1BDE7;
	Tue,  6 Feb 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="eLoTXbf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0C1BF24
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258405; cv=none; b=b9uu5fLqIuspsHPsFfUmEiTnw4dJDWLB8oy1bwZLoZwVklAOGn28KwPoXT5xOdcoey9TPmcJ+tN3/j4+kAQi1i1nHpooHv5cbADk+mF9WGJAJxj9Bg3GRbGON0X/HkaVmFLNmzU6WO7GEIBbPzsOyxSCGR+QJmv1Mwr9noPeXxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258405; c=relaxed/simple;
	bh=7NKXRER/P0R+WvOprYnrpVcOl11n4pCfJMRdi249id0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pog94vbQZGX9GjXpsOxDUZZcNOC1bYA+bUPo+lkoQ2BD7S6UW4LPa+VTwIZa3SRCdct2JceZc8Y4oCaOsI6b2ExlfQmLWEi/bnkIi6nEcMjGP2A9jnvIO8IZloDOimcrabXNxtXaJEWomHd3/o6FTaTOhUQ/YEvvqykWMrCsbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=eLoTXbf2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e055c89dd9so914028b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 14:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707258403; x=1707863203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkCYhU8sz7KhMMXYrMxluLvjQclrFhCxCHtT9YV3MFM=;
        b=eLoTXbf2mODmob5PqJk1pmhN8FcD49PNaTKQL9/+5xmBlFCDEL2zUT0UKIvtS7Po/e
         11BC3iwJVChO0qAfj4gXI7Ecztlqk+kTl5ojgOfHTvaS4+ZbfMtogTpHhu9v2Zkk/l7U
         K9P6EsTYeZl5Tkl55l8zvdO40l4frQKocVJG2oN5Z5HsxXE7m7raeANYTI3EV94+efNJ
         T44I/FO7xZLfQ06Rq6m6qQOEXdjjlBGHpI/qWoc2GekeZhhUS0SGAWhT5gfIyQLxQXc+
         +DoL7zxonixzJ6a8c7COGHovTtGB2Dcryln1vYqJ6ZYJeyXdMvrKP7NOQuPu7lgwo1bu
         S7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258403; x=1707863203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkCYhU8sz7KhMMXYrMxluLvjQclrFhCxCHtT9YV3MFM=;
        b=kqmOXoiK/KM7KasKIhFylOwT4F17aopytAwYBy0pdntFs/51+lWyJBxOfpTMslfS2m
         S5DMRfpxx8M6rCIuJBuEvd8tc50EpPaa0vyErfsSYL7FBf4YOiYFbGOa6ujxBJN5Rdt3
         Awge3KUq+znJF8tgfhyvRrCPcGXJXBKhpByP1JhmZq8S4WKEbj2l/ez6sjssvHL9tJiJ
         SqXX4FTPf/2Dy9Qr0MhhfK0Z2cZ2jR9SO6shBWFetEwvMbzxvlHgE48dGUtLl3/jy0CC
         iDQHZZ7nraFRLBA76NJudnDQyKUg2c0V5QaEBF9X7euCW45zALGk3gbzLrvstOFOCIC6
         csSA==
X-Forwarded-Encrypted: i=1; AJvYcCUKLj3ddReRdCFQ2quNgWNAxOrt6sq31XRbUXjjIBQIIZZ1eofHUyivO9BWu1KmzNeUBDl41XJB7SyJAAjYxgv8lUQfZkHKE8aUbeCAQw==
X-Gm-Message-State: AOJu0YxM6UHYJtiB2I6V5DEd5eWp2X3eXShUSJfyTFYKY2t2YyclJcH4
	JbGCdGwmHVoF8+DPshArSweyaukw89GBqDdGZHyg1ZdVT5wJpC58t6Fk8a/gnAg=
X-Google-Smtp-Source: AGHT+IEmJx7APX29j/bi1m0kfAJDXA6gfp2826V2zha9m6jWfwcml+cfudCpbhTgeytkmfTrCk4XKg==
X-Received: by 2002:a05:6a20:e125:b0:19e:4ab2:c362 with SMTP id kr37-20020a056a20e12500b0019e4ab2c362mr3992788pzb.14.1707258403388;
        Tue, 06 Feb 2024 14:26:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUBadXnX1hn54OeJVNivy+9I4aorRApURMiN07jJkpYED1udYUTQnifFs2EtVAet9IjwuQdC2lpeL1laxsF/6bBJLSipjOmdTFtAZe7uFiUaGVk/c5AkCLo0ASK3gQUX6fxPpYG93PZ9fzKzvQ+8n2iz6Do0GocJLTjOLxwd/kiBSrd5JQKE8x8CwD9EaoRArT1rs4HruSDPpMoe/0MaF40SJuTxf1dLFfTdsUPiXeqAFvU3r4YRHVBJzovV0yhJub46emjvf0=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id p24-20020a63f458000000b005d8b2f04eb7sm2671326pgk.62.2024.02.06.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:26:42 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXTto-0030xI-0c;
	Wed, 07 Feb 2024 09:26:40 +1100
Date: Wed, 7 Feb 2024 09:26:40 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 5/7] fs: FS_IOC_GETSYSFSNAME
Message-ID: <ZcKyIMPy1D1o5Yla@dread.disaster.area>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-6-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206201858.952303-6-kent.overstreet@linux.dev>

On Tue, Feb 06, 2024 at 03:18:53PM -0500, Kent Overstreet wrote:
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
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/ioctl.c              | 17 +++++++++++++++++
>  include/linux/fs.h      |  1 +
>  include/uapi/linux/fs.h | 10 ++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 046c30294a82..7c37765bd04e 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -776,6 +776,20 @@ static int ioctl_getfsuuid(struct file *file, void __user *argp)
>  	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
>  }
>  
> +static int ioctl_get_fs_sysfs_path(struct file *file, void __user *argp)
> +{
> +	struct super_block *sb = file_inode(file)->i_sb;
> +
> +	if (!strlen(sb->s_sysfs_name))
> +		return -ENOIOCTLCMD;

This relies on the kernel developers getting string termination
right and not overflowing buffers.

We can do better, I think, and I suspect that starts with a
super_set_sysfs_name() helper....

> +	struct fssysfspath u = {};

Variable names that look like the cat just walked over the keyboard
are difficult to read. Please use some separators here! 

Also, same comment as previous about mixing code and declarations.

> +
> +	snprintf(u.name, sizeof(u.name), "%s/%s", sb->s_type->name, sb->s_sysfs_name);

What happens if the combined path overflows the fssysfspath
buffer?

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
> +	case FS_IOC_GETFSSYSFSPATH:
> +		return ioctl_get_fs_sysfs_path(filp, argp);
> +
>  	default:
>  		if (S_ISREG(inode->i_mode))
>  			return file_ioctl(filp, cmd, argp);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index acdc56987cb1..b96c1d009718 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1258,6 +1258,7 @@ struct super_block {
>  	char			s_id[32];	/* Informational name */
>  	uuid_t			s_uuid;		/* UUID */
>  	u8			s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
> +	char			s_sysfs_name[UUID_STRING_LEN + 1];

Can we just kstrdup() the sysfs name and keep a {ptr, len} pair
in the sb for this? Then we can treat them as an opaque identifier
that isn't actually a string, and we don't have to make up some
arbitrary maximum name size, either.

>  	unsigned int		s_max_links;
>  
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 16a6ecadfd8d..c0f7bd4b6350 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -77,6 +77,10 @@ struct fsuuid2 {
>  	__u8	uuid[16];
>  };
>  
> +struct fssysfspath {
> +	__u8			name[128];
> +};

Undocumented magic number in a UAPI. Why was this chosen?

IMO, we shouldn't be returning strings that require the the kernel
to place NULLs correctly and for the caller to detect said NULLs to
determine their length, so something like:

struct fs_sysfs_path {
	__u32			name_len;
	__u8			name[NAME_MAX];
};

Seems better to me...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

