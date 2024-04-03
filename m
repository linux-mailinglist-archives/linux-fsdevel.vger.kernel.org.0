Return-Path: <linux-fsdevel+bounces-16047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9555F8975AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 18:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B877A1C23084
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BCA152187;
	Wed,  3 Apr 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvCVs7iV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67D9150980
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163349; cv=none; b=jWp80LcKG46PRKwyZ8s0DnPpxXbFMVPkr9Jenoj/GhzerYSm5ZJIlx5Wln/UuWBvMywL7zLjbUGnx59WEuvNErgP9UCMdxEjzIn3aFW8x4kJzVN5A1MxicF+ULc7kuhQMm07CNVqTM58TkItt7Q0MHL0b8oZijo7ec/L8IV2Y7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163349; c=relaxed/simple;
	bh=ER2G/SPYbdhMyH/exF2rzBC3+1Ubd8xN/6vEMjXf8Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZF8Pe1ghTM432cXUZ+EoKng+0ToprEBIkpbhKOOjR8ITeG8erltrpsGl+gmL8gzZNCSJ9yjKfbrebbYpvGOCQfsAY6zQlQ0Jt+M8eVOLjvtWQ4P52t/xv0PuWxpiQDVCcP02Htu0jSCLWP/y9gh5CBt4n9y45ofpcI0+I7QJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvCVs7iV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712163345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qcFGTIgsVpRcFHL+8n4bltIbe5BCiFbcUwE7alUYftc=;
	b=cvCVs7iV7A+JfWN53Q97HNARkewbq+uFP9e7q05+d/BRkZVgmP3NiTcKsogyHuQIAparZN
	OmdrhjsbTyziMBDa0TVtNCmXCvHtJ1MfN37/MrjtLjLWZSKzmTE7n7392jQr/E5IgwO+oj
	Wtwl+lJKq5jEGBGem6rfDHc6e72AmFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-BbaFp3e6P9SwSkyIW3LFsQ-1; Wed, 03 Apr 2024 12:55:41 -0400
X-MC-Unique: BbaFp3e6P9SwSkyIW3LFsQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 479DF88D4E8;
	Wed,  3 Apr 2024 16:55:40 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 300632024517;
	Wed,  3 Apr 2024 16:55:39 +0000 (UTC)
Date: Wed, 3 Apr 2024 12:57:37 -0400
From: Brian Foster <bfoster@redhat.com>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 01/13] fs: fiemap: add physical_length field to extents
Message-ID: <Zg2Kgdn42odZVUtE@bfoster>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

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
...
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

Nit: Why start this field out as len if the next patch adds the param
and defaults to zero? Not that it matters that much due to the next
patch (which seems logical), but wouldn't it make more sense to set this
to 0 from the start?

Brian

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


