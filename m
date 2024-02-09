Return-Path: <linux-fsdevel+bounces-10896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCFA84F2D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EB3289F8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C4D67E66;
	Fri,  9 Feb 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XuWP7lIy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4766B5F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472648; cv=none; b=otxJ9FeOib7rRtmwFIwdGAYSNB396ERrp1BUSiDp0pVhQKKcLIsX7q2KermhszKAEQVwC1E73Ax+bnELtHBRp12dku7j6p8OvN45RNZCzR7ZsHkCtCLBuT/FTSKhErT25on4sXabHUMPfpxpKqMClnbTGJHMZc/h23hh6soH3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472648; c=relaxed/simple;
	bh=1tgQ9pAQGezRgnEqBgCXyijBhkLKBenWcIFuv0m4I8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcQQPiyj5Oc3tbMaC7eab+14GQZUecm/8zPnVab59XUUZSbrk04sWQrT+uJxLapoKu+ZswK+IZvo1bHsvQR9Memi0pV/jUTIGMFRFcM8cdU0QD6TYU+QqSqN1RxIUxsYvevfQT5swERuSdX7DUEEJ34mcaeWHaZBPV3RywU/5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XuWP7lIy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a38291dbe65so87361766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 01:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707472644; x=1708077444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2zdT0cH8ypCu6giL2+e+8Y36Nksk/SaEM9Yqj0E3asY=;
        b=XuWP7lIyoApkDMrj4oSWkm0nKk9+/QzVrRR7HQtD1SWRxbNdRdH7jMksyCgb5qWygH
         LA3/bU2aKcRgkmICcC/GBkVK2Dfi2UXpUNCQlOesChQaelfyUjJjYIK4yTmRnQQcxlW5
         e4RUmJ41RNkzCsjLCpVz9prjWgZTaCOq8oyu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707472644; x=1708077444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zdT0cH8ypCu6giL2+e+8Y36Nksk/SaEM9Yqj0E3asY=;
        b=ZC9QMdHe/s3oN7lCrzrHaQo/pdIhZWpB8GGnoRg05NDgJ4Bnl5JwOXfrVc2tckSNiw
         pMLNfD1P8lS8p5pawGPyisQ6fBkoN/EUF/AZBVSepkqkt6sv8ZF9s2gitk0s8fsBeUqi
         4EkwTdU/doW/aHJvuW31GxHUZcNI2z2Y+/pV/QgzG1gySwWq6hNYYwnCpMNRa0/Lhk2k
         2oVOzaBvJKHhihBd6MpfpVznss4rDQwCKpTPC6J2J4mxmD50SCB6ayRcn2hOxj6Tok8F
         FDRecyqhUtkShFaSkcIo+hM6aJTduXj+aHsetK+9XS3FF7oSzzkpRXD73gPu2Q+1M0Nb
         lN4w==
X-Forwarded-Encrypted: i=1; AJvYcCXIlwTyW3trPq/mwYVh5pNF10D4uVYk2MxIjh9IinUioV8GGwTMNkBmpyVFh9vR31xs4VdaOY6G/BkAeQAqr1YEQruD5cek4n7V5Cqing==
X-Gm-Message-State: AOJu0YyPSDz7fvMtmiKmKkLjdfp4f6SWhvwcQDjEnsK8x4vuOYB92y7C
	GVAKWq3NbgSXd1O7fjMRLftZyXdvPwomWGZa54Hy3weR2oZ91YEZ6Wcmlaqt35mrU5cp9/095VU
	p+Aw1l8V3D2fUWAUbHuvzLDFmA3u0hdX8xDWvug==
X-Google-Smtp-Source: AGHT+IE2hm0RqomSRu+yFUfttemhVmES+idi2cWobjq/tN8y6SoxsaoCd0GXIJjyPIvtxW9aP3Id44kyiZ1qBoBnmwM=
X-Received: by 2002:a17:907:20bb:b0:a37:2153:a2ca with SMTP id
 pw27-20020a17090720bb00b00a372153a2camr751583ejb.1.1707472644193; Fri, 09 Feb
 2024 01:57:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-6-amir73il@gmail.com>
In-Reply-To: <20240208170603.2078871-6-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Feb 2024 10:57:13 +0100
Message-ID: <CAJfpegs4O1mXJUeWfQmT+B2X9xoXp9r8HoYLV_627WLpF+s64Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] fuse: allocate ff->release_args only if release is needed
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wrote:

> @@ -132,15 +134,16 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
>         struct fuse_conn *fc = fm->fc;
>         struct fuse_file *ff;
>         int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
> +       int noopen = isdir ? fc->no_opendir : fc->no_open;

bool?

>
> -       ff = fuse_file_alloc(fm);
> +       ff = fuse_file_alloc(fm, !noopen);
>         if (!ff)
>                 return ERR_PTR(-ENOMEM);
>
>         ff->fh = 0;
>         /* Default for no-open */
>         ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
> -       if (isdir ? !fc->no_opendir : !fc->no_open) {
> +       if (!noopen) {

I think this would be more readable without the double negation, i.e
if the bool variable was called e.g. "open".

Thanks,
Miklos

