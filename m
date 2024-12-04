Return-Path: <linux-fsdevel+bounces-36453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B159E3B13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18CE5B2B9BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CF51B87F4;
	Wed,  4 Dec 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y3MCDtd7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E051B85D2
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318085; cv=none; b=WktCT6Ob36su+B8Z2bMvcjpLHIR+v3+E6RGe1DbvCqyLiz3sPUBZyxNJnvM1F+aXzkGIpo6k3yNsEkLCUOv6sE/l1bT9lLX3oYnFY7miJB80e5jt27jdqEOoemLgNX7kOIz3/fTlSlP+aZIAMDbagGI9lAr46QBXliTz4X8JrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318085; c=relaxed/simple;
	bh=rLVV409CY64ZSRwluz9Mht5QGfEiNLOv0uOGV1Pjm1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGl+MvvMAiqzHyo/4ICgBQX4vWdEwgGNXEAcrVejtxLbYTd3Nk60AFUnbEpYNAKYlN0ls9rIolIUAxOMOyNxYkC8xrjNYvZSbFqTuGQRGNZqtCc2poKbxaDyVwFac9VvRQNtYDxHZcHPuH73DJCcKB43tL1713ZKWrWLfHdY+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y3MCDtd7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso5902765b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 05:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733318083; x=1733922883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrlQyCUFpVLl6ALitqqxU49Yj2L6TmzAqXoYdoRDMMs=;
        b=Y3MCDtd7qIYQfDFiWQkXhfK5QX4JfFslq+GLJRPJezp2GGEmIrDkRq3b5gRSux0sUU
         EgfwzufDmMdSBBFjwCASmP26oBI6JgdVSr1ik1TxB5rsAhGK37pVMkok/8Q0D/BuqUNW
         vqY5r2tHH+WGTHzpi4+vkUMUZPQXcUnJVOzwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733318083; x=1733922883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrlQyCUFpVLl6ALitqqxU49Yj2L6TmzAqXoYdoRDMMs=;
        b=UDLXDcnZXpbIJhUr3b9QlMNDhHfhlZJVN3CvpUrkmgHckEfoD43ww0RYZV/5hJI3eM
         CPLGv7optmTzvS503SILYRghAhYI7VqOb9zvCtcByKCA2BNg5uulBGXkMAonuqYITFM5
         yDiC181FyCjgB2Wx3V0ESO5xo+r84zDhSWkDJo+9drARRpUHaZyiZrhYI+V1krNojbPP
         SAj86RX69RIXQ/rGdr8/JvlV9IMYDeLpb0ST51gyKI9cD7yPh4Lk8eClwBVOlQ4BRJMt
         zftM21xKYXN/e+8K+wnyCw+iNlSDwP48J1/rqLaV4IcDtXD4IPF9YTL7crtJyhIMQLOe
         scqg==
X-Forwarded-Encrypted: i=1; AJvYcCUNadOLy0ARemhHxMV5VnCjtoMhwPjR/nr/OVP2UfK7Z0vNxZrF4PRQZmsccr9xOVy5czLLdxhvrf170mvy@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmmvWH7JWAFBTx3sHzz2QyEexSxdc2zfYZm1Oy8GVATb6AmUH
	myzk30vbJwLjw4cytUvCnX2R/53UeSnNdiVhy7qy9DEkmDfRmrsTmgpm2G0b+rcpEHnJETP35Cs
	=
X-Gm-Gg: ASbGncvpvZe1lgizG5iJCkXE9OSFp4lm3URBObrdECUGH5kyrWOTheaF/61WUrVrCDk
	7Q1kBwW4uxMtCB4RNenecU9fVbrosqg3xcDn/sug283Fj7zUQidjxaaFeiOosip/UqxDCndunRi
	F4fpKocSit/HvGCrmXsbkwM+K/xhGDm6WhXGq0aGJvDjAis+Sxc07PNh9TqeCeny5WCtvYMmf5d
	q6kgNkS/M+kFkZ39IPdfo9rnYqVmkAqbC1r/0GewG1gr90cROrh
X-Google-Smtp-Source: AGHT+IEorHB1Z8gwb1vpmREDqDwZNW7Mn/lhp1ycCURVfE0rGBvK5zWOcIvP6Z/B43YKYzyDqLZLuQ==
X-Received: by 2002:a17:902:e84d:b0:215:4a31:47d8 with SMTP id d9443c01a7336-215bcfc531bmr81154535ad.9.1733318083608;
        Wed, 04 Dec 2024 05:14:43 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:84f:5a2a:8b5d:f44f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a6fd3f1esm45090985ad.72.2024.12.04.05.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 05:14:42 -0800 (PST)
Date: Wed, 4 Dec 2024 22:14:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>,
	Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Message-ID: <20241204131438.GA16709@google.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114191332.669127-3-joannelkoong@gmail.com>

On (24/11/14 11:13), Joanne Koong wrote:
[..]
> @@ -920,6 +935,9 @@ struct fuse_conn {
>  	/** IDR for backing files ids */
>  	struct idr backing_files_map;
>  #endif
> +
> +	/** Only used if the connection enforces request timeouts */
> +	struct fuse_timeout timeout;
>  };
[..]
> @@ -749,6 +750,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	fsparam_u32	("max_read",		OPT_MAX_READ),
>  	fsparam_u32	("blksize",		OPT_BLKSIZE),
>  	fsparam_string	("subtype",		OPT_SUBTYPE),
> +	fsparam_u16	("request_timeout",	OPT_REQUEST_TIMEOUT),
>  	{}
>  };
>  
> @@ -844,6 +846,10 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>  		ctx->blksize = result.uint_32;
>  		break;
>  
> +	case OPT_REQUEST_TIMEOUT:
> +		ctx->req_timeout = result.uint_16;
> +		break;
> +

A quick question: so for this user-space should be updated
to request fuse-watchdog on particular connection?  Would
it make sense to have a way to simply enforce watchdog on
all connections?

