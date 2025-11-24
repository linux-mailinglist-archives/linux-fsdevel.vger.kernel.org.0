Return-Path: <linux-fsdevel+bounces-69689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C1C812A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D38B3A43C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAACD284689;
	Mon, 24 Nov 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mX2lz1Kh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B12FD681
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995935; cv=none; b=RD7L1GZXtdUsAs1+aIW6MlhvGm1Fa6ea8S1Pre1qXcMmGby/Pg7nucyz03H6u+DIjijY7h/krZbAqVPmXczuodzSEXasZjSYBeCyXsuOZLSOT46YPR2BUQ/0ukD4jb6e+TYcRqo+M+sOmQSktaLiaPZZMjYFjidjL9HOKzlCKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995935; c=relaxed/simple;
	bh=KzEKBZLVQc3Agn1cDVm/wLXk57NjwmfW2KbNhTOY9tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzKRSyRap8VCt/u7hXuAswAKyb+cjf79+DrZIQpVxXz+GtUBK2lAnxSArqH9Iqo15iBP5Epl/IbPvL8/uQH3wEjiJ/7Mn8ZQ+St1/kfLed/ghNPYOukW9YNRlcQLlwHPKXSj2rJLypqLA7cKvbEkt6sl/q22gOjRneoERH9cYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mX2lz1Kh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2ea2b9631so451386485a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 06:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763995932; x=1764600732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cez96tfxwlGA2c0tKDaoR9Xu5g/35868diX2ocOdJ/g=;
        b=mX2lz1Kh0CqYRx+bRaCRyPfKkPO4VjBJawYe+c4NAcT7yJVCTXZb164nyhSJ3utRe+
         IBk2ddvC7cn5ExYertOXwH+SQXpsyRHAqwEmdNaSzos59czHJRd+8glM+rJX2wf19Qvj
         kWQxW7diTfXkS1Bbll/j3JqEnZRCfks9fjk3Tg0N59kRWsxTlBqDqoft/asoK5/db2Ha
         +ePD09DyKB2KcVXLML/gt0oVJb/DLHSbrwS55N5bpw+GrjHKRQraPkzKTXWcEaABfcoM
         El6ZcEjcNiV5pJWA6jCP5Xfhbyg+KsSKvzHRgtEQ51bDG4dDnw4LkBxMoChXnoB+1tzz
         GqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763995932; x=1764600732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cez96tfxwlGA2c0tKDaoR9Xu5g/35868diX2ocOdJ/g=;
        b=ThHTFWVnC360fds9EUOxUPqovePUBrG3vEdGFms/TsZqSyY/v55uYZ0z22cglRurBd
         wGYQHqi6rzGrP7G19ainHSQ6iq/7D12DMfanMJFVFdFJFc4kAzBDgxLTXc3Ph4jrTZ9k
         qnH+jfy6Pzr99lhucQMXwlzRSCsKqnSagK41nwBknBFLC22VoevKDYjtqHaZAFcSoLuS
         TH/biqb+MKz/5ttmKZYzc6v0alxqngcnuhfAj+gLV8P2LYhMmP6FskkCIYOGQdMAekfL
         xCnRJMi9oRbuKzgRYoZGhcfjsg1bqTq7pzpSspk4am4NV6gIbuDH17YfQarY0NLfOeLt
         2F3w==
X-Forwarded-Encrypted: i=1; AJvYcCXfbdV6y1P5UmrNcTmv3TvtcdHMi+Qg7KilZogX9IEAWi8NlJMWPZUiOVZnQG/68cdzR/3kaGpnlo/I/gWT@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVltmthtivUORWcBot3CxGPVFveUG9XpHx77CHSl35I53IVqj
	P6wIIm60UgztLIxGjXxeIStNVGXEbSgXGeoKZzaaTmkLNSVEUV8peDk3bsns+BCQuWIh6tac5Tp
	qI9v1
X-Gm-Gg: ASbGncu2HdOsunJoBpO7BAFLv986vynVK43q2p60K0u9Tn8c/N14BzqTyOJfVom2xIF
	LCC4SFoGWrenPZ7O7psRhJmVnU9qTcsZ5OQXbnGKiBsoyw+DqeKFHRGhKpq35aZjv+JDVANA1ch
	KGH4rQ8ZRk+DfWEuy3whDYy9d+dkG67ULcDEozGY+lzd3ZkeZj2uEpPKie/DDz0ef6Y4z/1Sjmx
	5rClsk398Zkg/pMq5NCb/fbXrYul/o2+DJ5j5tPXEWEhKlvyw/U2mvTf5gHD2eCubSBNS4bejaJ
	qk8U2QJPxGC3ah4eJnuPJwbDMPsuRnXq9u11RxcGs/OE2mNzWgbo9dgIwdrJyTSj5C4viw1BvB6
	D0MFjAVcGDC6TIQoerl6vJgY0xZyXwd6scARLHik6KVZ9Sz7Hdb5ckzalRA818j363FQ6yl+Tgm
	yPxS/UslLLUauKrtjcqZ9mx37iD1tZZj0woyvZ3u0I8fVaWc5CLfERPkpy
X-Google-Smtp-Source: AGHT+IF2+ObciKV0Gjs2aHEMdm1hSmFjw5Fv1qkER8r/KGCPkzxT9ltJj948xN9t4aIJRzJuENncbw==
X-Received: by 2002:a05:620a:c54:b0:8a4:e7f6:bf57 with SMTP id af79cd13be357-8b33d213076mr1550098985a.5.1763995932014;
        Mon, 24 Nov 2025 06:52:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932da24sm964672885a.6.2025.11.24.06.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 06:52:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vNXvH-00000001vKL-00J2;
	Mon, 24 Nov 2025 10:52:11 -0400
Date: Mon, 24 Nov 2025 10:52:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 43/47] vfio: convert vfio_group_ioctl_get_device_fd()
 to FD_PREPARE()
Message-ID: <20251124145210.GQ233636@ziepe.ca>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-43-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-43-b6efa1706cfd@kernel.org>

On Sun, Nov 23, 2025 at 05:34:01PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  drivers/vfio/group.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index c376a6279de0..d47ffada6912 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -299,10 +299,8 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
>  					  char __user *arg)
>  {
>  	struct vfio_device *device;
> -	struct file *filep;
>  	char *buf;
> -	int fdno;
> -	int ret;
> +	int fd;
>  
>  	buf = strndup_user(arg, PAGE_SIZE);
>  	if (IS_ERR(buf))
> @@ -313,26 +311,10 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
>  	if (IS_ERR(device))
>  		return PTR_ERR(device);
>  
> -	fdno = get_unused_fd_flags(O_CLOEXEC);
> -	if (fdno < 0) {
> -		ret = fdno;
> -		goto err_put_device;
> -	}
> -
> -	filep = vfio_device_open_file(device);
> -	if (IS_ERR(filep)) {
> -		ret = PTR_ERR(filep);
> -		goto err_put_fdno;
> -	}
> -
> -	fd_install(fdno, filep);
> -	return fdno;
> -
> -err_put_fdno:
> -	put_unused_fd(fdno);
> -err_put_device:
> -	vfio_device_put_registration(device);
> -	return ret;
> +	fd = FD_ADD(O_CLOEXEC, vfio_device_open_file(device));
> +	if (fd < 0)
> +		vfio_device_put_registration(device);
> +	return fd;
>  }

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Tough I'd bikeshed this name and suggest something with INSTALL in the
macro as we've always used install to mean the FD is visible to
userspace and is the barrier where we have to start to be careful.

Jason

