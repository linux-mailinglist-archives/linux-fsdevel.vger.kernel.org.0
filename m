Return-Path: <linux-fsdevel+bounces-45364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 532EBA76904
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 17:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E359C3A3E15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2121421E;
	Mon, 31 Mar 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PL9hOs66"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230D21322E
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432229; cv=none; b=uQmUTEriqipO89TNLXQCN8C3I7mFOTogFcNahKQOU4FbAke/+MCZ5+naN8rLz3tQtEN5pRWFOXpLRO3xghS9Q+ZbJ9CCrcBGVZi3qC2VWMWB3JkaDaiXDlUDvbscR9yOaa6OMdpgGIrTJtdh5I497+eihKrrJwLdfQZ1v9eXPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432229; c=relaxed/simple;
	bh=xu/CRs/TiCjmHL7pvqmu0A8oIALDzlOKXo8RkZ0C48Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSSF98UDpxkK+JBsRHuefpL6sv0GFiGwm116WK6YW4gH6kiHMlk8ADf/Dd8eCwPgv0VLfdHseobwo1T9M16mTzaOfLZU2amYBeAeKeetVYN70BhHJLrGSPY0sLfIeS4bvE0WYnwmRX5oB+rI22R9u5l8E9XYJ2kWBCmo29fDe18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PL9hOs66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743432226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgdOiKSURos1R/goqTX4ZGP1yeUdfb2ccO8VIkTrdHs=;
	b=PL9hOs663MawBWSQy0inO/KfoVyJZJYik1YsPtSzDDj3LHCRbpuriPlqWmh2agUYRablxL
	HgSKavmekhBcF3yeM+C+Oj1/kVCfj+4Jb+KfuCogL3ZhGSbn4sJaiZUrOyPz6JwSOzCZBA
	2bPHPr9dlB6R6vRsoR18/u90o4MfZEQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-_Bcgo-JGPOSkAbvfJCvCng-1; Mon, 31 Mar 2025 10:43:44 -0400
X-MC-Unique: _Bcgo-JGPOSkAbvfJCvCng-1
X-Mimecast-MFC-AGG-ID: _Bcgo-JGPOSkAbvfJCvCng_1743432224
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so561411266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 07:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743432224; x=1744037024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgdOiKSURos1R/goqTX4ZGP1yeUdfb2ccO8VIkTrdHs=;
        b=AI9Xos0ZhltIhOJsb0v5mmjucpAV35aTGfcfmMyKAUVZBnrxYa9mY8KF1DzXFSI6Xm
         /3kZCC255TA9mrcuBqtMdNTzxwKkkYyV/2ZyNRLnFGwEozF35RmT6v/2dma9MCAbsckN
         g5PBnXCTL0LOKSR54kavn6Al3OjmVbQTfPagzAiVGVlNyK8rK3b0RxNF3oM8lzrzx0nf
         wUnO4/jr+6m2fUdfC4MYW9kUxIaEpgBKwEv+MHaYbVA3mR2iPPPNfHkrBk1d0tHODj01
         n65q/8x8TxcbSRt8sfWFAX4+elGGPhETLbSjGersKC9HM6C1l0FPolqW9JfTyOATABRm
         w2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWFqdGXAZpWHtLRoLj+ebi8N58hS5fjfZAQ/bkbuYKhSnXR0lA1xHOK2h4j1bc/wA6pAnc4geYqFv+pzXHa@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkSKJZX3TF9kosMSfiChiMeYjZMdYg84G2f0ms9PVVGCHtliR
	7Myo5/FefVX9t9QSk++x3cudAdUwsg3eboAK+7Bp6x4izhTb9bQxHsxA0SE3jROPgjapgYZUD9b
	yV0ugsC50Y4ucCrlJsufEpcZbx3d0r/MMlbOJIGm+8Y1frXmDYUEjG+8NLrDoGg==
X-Gm-Gg: ASbGnctcjlO84nJJsRqNk8sWHiRZiJbADUl0FQKdAeBU/cBqJSD0sv4AhtEuUVMLjXm
	rqPZl73VXhmnUaRojaDrZE4Ig33ypwPX7wJzvFTxQcubZTGs42E8rMbfpU2bd9Ghj+7diLZPyE8
	w1kTxh9Nizb4WqgzBKWKKIjHbkOxYDVIgDuDfCAIfq2hBcS4FfuxsQjAZg37BIaHe0+xEVFMR5y
	jFTSU7n7p1wml1xZ62ndJAat+DyXbctmqYV9Lfb8Fs3W78MDbs84i3VEbgkV2gUdQ5XPu9hsIwt
	N4GGLA6wGx40Y1wkT1fF8tJ1Ws+IiBWDN2M=
X-Received: by 2002:a17:907:9693:b0:ac1:dfab:d38e with SMTP id a640c23a62f3a-ac738a5b384mr928064966b.15.1743432223631;
        Mon, 31 Mar 2025 07:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsnL6kFFnERP/yk7CqtLubGB7LYnSO+4Up04wIQ/QjBOVblVJi0WXQ+7OIYDK9Qxx42He2ag==
X-Received: by 2002:a17:907:9693:b0:ac1:dfab:d38e with SMTP id a640c23a62f3a-ac738a5b384mr928062066b.15.1743432223169;
        Mon, 31 Mar 2025 07:43:43 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71f037234sm597479066b.131.2025.03.31.07.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:43:42 -0700 (PDT)
Date: Mon, 31 Mar 2025 16:43:42 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fs: prepare for extending [gs]etfsxattrat()
Message-ID: <h3gmwgfcfv3zl65p2kwt364go5jzcm5asfzi5gbweyyc77emdk@twb3e246vvig>
References: <20250329143312.1350603-1-amir73il@gmail.com>
 <20250329143312.1350603-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250329143312.1350603-2-amir73il@gmail.com>

On 2025-03-29 15:33:11, Amir Goldstein wrote:
> We intend to add support for more xflags to selective filesystems and
> We cannot rely on copy_struct_from_user() to detect this extention.
> 
> In preparation of extending the API, do not allow setting xflags unknown
> by this kernel version.
> 
> Also do not pass the read-only flags and read-only field fsx_nextents to
> filesystem.
> 
> These changes should not affect existing chattr programs that use the
> ioctl to get fsxattr before setting the new values.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Andrey Albershteyn <aalbersh@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/inode.c               |  4 +++-
>  fs/ioctl.c               | 19 +++++++++++++------
>  include/linux/fileattr.h | 22 +++++++++++++++++++++-
>  3 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 3cfcb1b9865ea..6c4d08bd53052 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -3049,7 +3049,9 @@ SYSCALL_DEFINE5(setfsxattrat, int, dfd, const char __user *, filename,
>  	if (error)
>  		return error;
>  
> -	fsxattr_to_fileattr(&fsx, &fa);
> +	error = fsxattr_to_fileattr(&fsx, &fa);
> +	if (error)
> +		return error;
>  
>  	name = getname_maybe_null(filename, at_flags);
>  	if (!name) {
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 840283d8c4066..b19858db4c432 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -540,8 +540,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
>  
>  void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx)
>  {
> +	__u32 mask = FS_XFALGS_MASK;
> +
>  	memset(fsx, 0, sizeof(struct fsxattr));
> -	fsx->fsx_xflags = fa->fsx_xflags;
> +	fsx->fsx_xflags = fa->fsx_xflags & mask;
>  	fsx->fsx_extsize = fa->fsx_extsize;
>  	fsx->fsx_nextents = fa->fsx_nextents;
>  	fsx->fsx_projid = fa->fsx_projid;
> @@ -568,13 +570,20 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
>  }
>  EXPORT_SYMBOL(copy_fsxattr_to_user);
>  
> -void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
> +int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
>  {
> +	__u32 mask = FS_XFALGS_MASK;
> +
> +	if (fsx->fsx_xflags & ~mask)
> +		return -EINVAL;
> +
>  	fileattr_fill_xflags(fa, fsx->fsx_xflags);
> +	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
>  	fa->fsx_extsize = fsx->fsx_extsize;
> -	fa->fsx_nextents = fsx->fsx_nextents;
>  	fa->fsx_projid = fsx->fsx_projid;
>  	fa->fsx_cowextsize = fsx->fsx_cowextsize;
> +
> +	return 0;
>  }
>  
>  static int copy_fsxattr_from_user(struct fileattr *fa,
> @@ -585,9 +594,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
>  	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
>  		return -EFAULT;
>  
> -	fsxattr_to_fileattr(&xfa, fa);
> -
> -	return 0;
> +	return fsxattr_to_fileattr(&xfa, fa);
>  }
>  
>  /*
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 31888fa2edf10..f682bfc7749dd 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -14,6 +14,26 @@
>  	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
>  	 FS_XFLAG_PROJINHERIT)
>  
> +/* Read-only inode flags */

Maybe it's only me, but this "read-only" is a bit confusing, as
those are not settable get-only flags and not flags of read-only
inode

> +#define FS_XFLAG_RDONLY_MASK \
> +	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
> +
> +/* Flags to indicate valid value of fsx_ fields */
> +#define FS_XFLAG_VALUES_MASK \
> +	(FS_XFLAG_EXTSIZE | FS_XFLAG_COWEXTSIZE)
> +
> +/* Flags for directories */
> +#define FS_XFLAG_DIRONLY_MASK \
> +	(FS_XFLAG_RTINHERIT | FS_XFLAG_NOSYMLINKS | FS_XFLAG_EXTSZINHERIT)
> +
> +/* Misc settable flags */
> +#define FS_XFLAG_MISC_MASK \
> +	(FS_XFLAG_REALTIME | FS_XFLAG_NODEFRAG | FS_XFLAG_FILESTREAM)
> +
> +#define FS_XFALGS_MASK \
> +	(FS_XFLAG_COMMON | FS_XFLAG_RDONLY_MASK | FS_XFLAG_VALUES_MASK | \
> +	 FS_XFLAG_DIRONLY_MASK | FS_XFLAG_MISC_MASK)
> +

I like the splitting but do we want to split flags like this? I can
imagine new flags just getting pushed into _MISK_MASK or these names
just loosing any sense.

>  /*
>   * Merged interface for miscellaneous file attributes.  'flags' originates from
>   * ext* and 'fsx_flags' from xfs.  There's some overlap between the two, which
> @@ -35,7 +55,7 @@ struct fileattr {
>  
>  void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx);
>  int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
> -void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa);
> +int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa);
>  
>  void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
>  void fileattr_fill_flags(struct fileattr *fa, u32 flags);
> -- 
> 2.34.1
> 

Otherwise, this patch looks fine for limiting the interface for now

I will include it in next iteration

-- 
- Andrey


