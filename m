Return-Path: <linux-fsdevel+bounces-14770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0909B87F08D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 20:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7571F22392
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 19:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A13956B83;
	Mon, 18 Mar 2024 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQiEOzaa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5056464
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791334; cv=none; b=ACtgDfwfwQuWtPqDP+xa14Ll44y2PwAg13HK6hu1Ir4rhkNCpixWvehkmObZiIzCNX3lrX3UYdEMT+MdRNLcfv+gbMvLXRR/s+lz0FvgR1ymJuZwXJo9u26QniNE4SSKEffvG2d0xuL0Osin5xH5e4RVzfWCs8Mc+9EidD7YjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791334; c=relaxed/simple;
	bh=HcyNRAaSvVR/TK1oY1imlZkpQ7tr6zcuYNe1c6B+IZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udX4R0GRhNX+POamexY24/wcv3YU6dF4nzWrv8nH5Rxh3BdeXArZJpCMP09OawKEzgjNPLvuR5jKvyYNXqXIliCRpxiduHfAB2uY7YU3o15XjeX3aPwCd9GCMs6onSy+l+TF5Fri071iDjWIX5sx4heL0qgqJQEPEATzf1ipcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQiEOzaa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710791331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOqdgcxTH2OLnV0pHfnH8Nt0Lqbw8koRvQxc7E7h07s=;
	b=BQiEOzaaSS6aJmaMmQReVVuqS9XKKVMp+keG7ThAVkL39X3kzvW97BljFsb7qLkDDP/wKg
	pbB1/BdH/nrkVjrVpCzEPXPaAcPoZTCRWGsMP+L11187RcY2geRK1S7Zax2oSUwxvYGX+z
	Q7GhmQfmdEke5XL09ZB17DTEv14004A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-dBADwuE8P3KWyaPWRbYgcQ-1; Mon, 18 Mar 2024 15:48:50 -0400
X-MC-Unique: dBADwuE8P3KWyaPWRbYgcQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed5ddd744so757352f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 12:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791329; x=1711396129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOqdgcxTH2OLnV0pHfnH8Nt0Lqbw8koRvQxc7E7h07s=;
        b=dDHFLP8tswjfRPo8+nFbDUGcC6BushW/3zJMDuOYdL9ZDo4NU584TzD96SLj76VDLO
         +CTQT5renvC6Sorqv/CVLRYB+HfGqbqOD+mnPQGXhtLbQsbHVmyrFBGi8zqRFNVKWN0x
         6/12vANw6U3cdGI9vyPNEHJ4AG7KC5QupDOEaTk7VP8ga0MiDO8P3AO6EVvDEtnEq8tR
         3w6/sL/Xpx3DNpR0hiT1cws91Ah9Ov/k6R55KbwUilwqo51qUmo5tbTOhZ2YFmJ0hSyi
         bSOnTjJKn4qsp+Qpi8m0jv+vRxx480v5kCC+trcscO9qCKYvwAEB1B+4iKk+QX5MvFa/
         U95Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMNQdN+mHjleRJKAIFYmyPq4cM9kP+xKk9nmtRDsJi98FYjOFTx87lRXWvUtbgPQlYJS2ilem49ez6hfVpJOmBkbtcr8gJRPpHjTZcjA==
X-Gm-Message-State: AOJu0YwNtT6TFgthU/bGooegq23IU5ruu/icDMxHU6cdlZjxtPL22tyz
	yCcWFU6XCNpedCXvU4DhqmgXvCRgRRF5SNVDvYVtklFrQTtb4btNTL5nI2A/2B9laHRce8z81N7
	pvrWzFQ6qd38lEfyrhriKTbJoBQ8TvQf2l7ELh5ZxTR+6iG804sj3ASiXUrQboA==
X-Received: by 2002:a05:6000:2c1:b0:33e:75fb:b913 with SMTP id o1-20020a05600002c100b0033e75fbb913mr362548wry.14.1710791329024;
        Mon, 18 Mar 2024 12:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmhHFEmeCMf0/MvrmnUNbFENwn/JsYxFZoXvcdt6TUYYdr+isHkaJA/RtYfMH4u+9ztYUvhg==
X-Received: by 2002:a05:6000:2c1:b0:33e:75fb:b913 with SMTP id o1-20020a05600002c100b0033e75fbb913mr362530wry.14.1710791328487;
        Mon, 18 Mar 2024 12:48:48 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id f22-20020a5d58f6000000b0033e7a204dc7sm10493478wrd.32.2024.03.18.12.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:48:48 -0700 (PDT)
Date: Mon, 18 Mar 2024 20:48:47 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 24/40] xfs: disable direct read path for fs-verity files
Message-ID: <eb7rlbfslyht2vmn7ocqcx5fkjyrle4ocgex6hmjxzs4gtkkgm@mvmsrj7sgojd>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246296.2684506.17423583037447505680.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171069246296.2684506.17423583037447505680.stgit@frogsfrogsfrogs>

On 2024-03-17 09:29:39, Darrick J. Wong wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> The direct path is not supported on verity files. Attempts to use direct
> I/O path on such files should fall back to buffered I/O path.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> [djwong: fix braces]
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/xfs_file.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 74dba917be93..0ce51a020115 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -281,7 +281,8 @@ xfs_file_dax_read(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*to)
>  {
> -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> +	struct xfs_inode	*ip = XFS_I(inode);
>  	ssize_t			ret = 0;
>  
>  	trace_xfs_file_dax_read(iocb, to);
> @@ -334,10 +335,18 @@ xfs_file_read_iter(
>  
>  	if (IS_DAX(inode))
>  		ret = xfs_file_dax_read(iocb, to);
> -	else if (iocb->ki_flags & IOCB_DIRECT)
> +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))

Brackets missing

>  		ret = xfs_file_dio_read(iocb, to);
> -	else
> +	else {
> +		/*
> +		 * In case fs-verity is enabled, we also fallback to the
> +		 * buffered read from the direct read path. Therefore,
> +		 * IOCB_DIRECT is set and need to be cleared (see
> +		 * generic_file_read_iter())
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;
>  		ret = xfs_file_buffered_read(iocb, to);
> +	}
>  
>  	if (ret > 0)
>  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> 
> 

-- 
- Andrey


