Return-Path: <linux-fsdevel+bounces-16461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9A589E044
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 18:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60601F24011
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 16:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6334513E885;
	Tue,  9 Apr 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOf15R97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F013E3EF;
	Tue,  9 Apr 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679753; cv=none; b=GVIDf/Rau8FvjBI5wDdXtGAhsiQQN3hTcIGgB5toGTb+HqSmKtCTKD7Eq+zl/XclKExfkRH1qR6Juo+RO5Ggssa9nflCG2zYIsTA0mG/noQIss1IVpiwtdpB001wEIxOcOzONo0p/oqXoCN929ioc0LIeOE37ACMuPGHck1Fq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679753; c=relaxed/simple;
	bh=s81ceGOY/UaeALO8XB1vF4xIKP6ybz9DnJl/IEpTMSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIbPt3n29SPe3OM1HQr4vEBpyYGCfPIVdAkE2fllySvx4PYg/zapleLTCLHq9O7WUlasVq0hkEbOVJZCGnYCs3cXVHb4znHD7OQ39zHRu6eps8Xu2KwO2XeI2ZpU2jZjG1lXChXjVEliMPJoBvpapLfa3TBbf3yG/h6F22g5P5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOf15R97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783B4C433F1;
	Tue,  9 Apr 2024 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712679753;
	bh=s81ceGOY/UaeALO8XB1vF4xIKP6ybz9DnJl/IEpTMSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOf15R97CfO4NRrpGlR+ut/EZaH8gJePsx76fVYZ2CwpkY6p2z9oJg8boVPOdOoce
	 WETlWuf5gfSinxoonTC04g5Kc3Sj2wZe9v17KvknHY3kunNrQaSO0L6nThQ5p/8nRJ
	 nKKPh7+OV5XuHOCgKUobpVWsMEUosqNN+Oy7MtOavp44t3NaOWktoHNU3flF3rj12P
	 bxvOmVWzXpwkP+BPmdlgreV35svfYgm5TTPVIxw45uz3NeIFb27nURTpm/B4vJffGz
	 rHBMtsPRwqA5Of0yoDXPSPXCbiEUfKL6dAA1Ko3ghM2b9lkhjl0APrqbDbXL3wc/MZ
	 nHjQ03z4Hsjsg==
Date: Tue, 9 Apr 2024 09:22:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 01/13] fs: fiemap: add physical_length field to extents
Message-ID: <20240409162232.GA6367@frogsfrogsfrogs>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <1ba5bfccccbf4ff792f178268badde056797d0c4.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba5bfccccbf4ff792f178268badde056797d0c4.1712126039.git.sweettea-kernel@dorminy.me>

On Wed, Apr 03, 2024 at 03:22:42AM -0400, Sweet Tea Dorminy wrote:
> Some filesystems support compressed extents which have a larger logical
> size than physical, and for those filesystems, it can be useful for
> userspace to know how much space those extents actually use. For
> instance, the compsize [1] tool for btrfs currently uses btrfs-internal,
> root-only ioctl to find the actual disk space used by a file; it would
> be better and more useful for this information to require fewer
> privileges and to be usable on more filesystems. Therefore, use one of
> the padding u64s in the fiemap extent structure to return the actual
> physical length; and, for now, return this as equal to the logical
> length.
> 
> [1] https://github.com/kilobyte/compsize
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  Documentation/filesystems/fiemap.rst | 28 +++++++++++++++++-------
>  fs/ioctl.c                           |  3 ++-
>  include/uapi/linux/fiemap.h          | 32 ++++++++++++++++++++++------
>  3 files changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/filesystems/fiemap.rst b/Documentation/filesystems/fiemap.rst
> index 93fc96f760aa..c2bfa107c8d7 100644
> --- a/Documentation/filesystems/fiemap.rst
> +++ b/Documentation/filesystems/fiemap.rst
> @@ -80,14 +80,24 @@ Each extent is described by a single fiemap_extent structure as
>  returned in fm_extents::
>  
>      struct fiemap_extent {
> -	    __u64	fe_logical;  /* logical offset in bytes for the start of
> -				* the extent */
> -	    __u64	fe_physical; /* physical offset in bytes for the start
> -				* of the extent */
> -	    __u64	fe_length;   /* length in bytes for the extent */
> -	    __u64	fe_reserved64[2];
> -	    __u32	fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
> -	    __u32	fe_reserved[3];
> +            /*
> +             * logical offset in bytes for the start of
> +             * the extent from the beginning of the file
> +             */
> +            __u64 fe_logical;
> +            /*
> +             * physical offset in bytes for the start
> +             * of the extent from the beginning of the disk
> +             */
> +            __u64 fe_physical;
> +            /* logical length in bytes for this extent */
> +            __u64 fe_logical_length;
> +            /* physical length in bytes for this extent */
> +            __u64 fe_physical_length;
> +            __u64 fe_reserved64[1];
> +            /* FIEMAP_EXTENT_* flags for this extent */
> +            __u32 fe_flags;
> +            __u32 fe_reserved[3];
>      };
>  
>  All offsets and lengths are in bytes and mirror those on disk.  It is valid
> @@ -175,6 +185,8 @@ FIEMAP_EXTENT_MERGED
>    userspace would be highly inefficient, the kernel will try to merge most
>    adjacent blocks into 'extents'.
>  
> +FIEMAP_EXTENT_HAS_PHYS_LEN
> +  This will be set if the file system populated the physical length field.

Just out of curiosity, should filesystems set this flag and
fe_physical_length if fe_physical_length == fe_logical_length?
Or just leave both blank?

>  VFS -> File System Implementation
>  ---------------------------------
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 661b46125669..8afd32e1a27a 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -138,7 +138,8 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
>  	memset(&extent, 0, sizeof(extent));
>  	extent.fe_logical = logical;
>  	extent.fe_physical = phys;
> -	extent.fe_length = len;
> +	extent.fe_logical_length = len;
> +	extent.fe_physical_length = len;
>  	extent.fe_flags = flags;
>  
>  	dest += fieinfo->fi_extents_mapped;
> diff --git a/include/uapi/linux/fiemap.h b/include/uapi/linux/fiemap.h
> index 24ca0c00cae3..3079159b8e94 100644
> --- a/include/uapi/linux/fiemap.h
> +++ b/include/uapi/linux/fiemap.h
> @@ -14,14 +14,30 @@
>  
>  #include <linux/types.h>
>  
> +/*
> + * For backward compatibility, where the member of the struct was called
> + * fe_length instead of fe_logical_length.
> + */
> +#define fe_length fe_logical_length

This #define has global scope; are you sure this isn't going to cause a
weird build problem downstream with some program that declares an
unrelated fe_length symbol?

> +
>  struct fiemap_extent {
> -	__u64 fe_logical;  /* logical offset in bytes for the start of
> -			    * the extent from the beginning of the file */
> -	__u64 fe_physical; /* physical offset in bytes for the start
> -			    * of the extent from the beginning of the disk */
> -	__u64 fe_length;   /* length in bytes for this extent */
> -	__u64 fe_reserved64[2];
> -	__u32 fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
> +	/*
> +	 * logical offset in bytes for the start of
> +	 * the extent from the beginning of the file
> +	 */
> +	__u64 fe_logical;
> +	/*
> +	 * physical offset in bytes for the start
> +	 * of the extent from the beginning of the disk
> +	 */
> +	__u64 fe_physical;
> +	/* logical length in bytes for this extent */
> +	__u64 fe_logical_length;

Or why not just leave the field name the same since the "logical length
in bytes" comment is present both here in the header and again in the
documentation?

--D

> +	/* physical length in bytes for this extent */
> +	__u64 fe_physical_length;
> +	__u64 fe_reserved64[1];
> +	/* FIEMAP_EXTENT_* flags for this extent */
> +	__u32 fe_flags;
>  	__u32 fe_reserved[3];
>  };
>  
> @@ -66,5 +82,7 @@ struct fiemap {
>  						    * merged for efficiency. */
>  #define FIEMAP_EXTENT_SHARED		0x00002000 /* Space shared with other
>  						    * files. */
> +#define FIEMAP_EXTENT_HAS_PHYS_LEN	0x00004000 /* Physical length is valid
> +						    * and set by FS. */
>  
>  #endif /* _UAPI_LINUX_FIEMAP_H */
> -- 
> 2.43.0
> 
> 

