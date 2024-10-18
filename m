Return-Path: <linux-fsdevel+bounces-32330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044439A3A49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339FD1C24AC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B9F200B89;
	Fri, 18 Oct 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WdKVcvuO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3331FF7C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244545; cv=none; b=gnOeNuO4Rppc1t8k4jtE/ECH3pc05iIdKUsMIzLer4WdwaySi2aP1TvqNQJBpNKv28f3+rJzTumm8csgpq2/+6h8YZrmG630osTOLphVoEBVbI23uCugetB7FdXwx6y52LJ4zqTEGn1BkL6xX7cNr8UCR0KCsPLOYnDEfR1VEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244545; c=relaxed/simple;
	bh=++04TeDcGdV/Nw/ZsuVZzSKTSLg/T0y3AazsWTk66u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmB1MNTN2z5wMOa97Ri5pik28uVPZkCVWO3WR/OfMj56HiFqyI8GDcxjC3MquBGnA6wgb14fZg3g3dGr+dE5emLss/cVDpPLzJWDVXRMf5DAburDYROyOQLx//5fGPqUlzFlXKMtMsG8F4dnidWLEHe0ZHwJYWmY/66lakothf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WdKVcvuO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a628b68a7so165290866b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729244541; x=1729849341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sw9AwTwe/lSdKCrzY4oAj5Aeo7yDRO1/177hW5mT5co=;
        b=WdKVcvuOh2oiZJ6mmKV06VOVVLDz9og5Yl89KfC2ENii094+etGrnmjI/9i8e6+Dvi
         JIQH/4JvWA7fDFCyZtGMQJLEskCyYN2idN9wC0S/FwnGJcUrYilamNiA6Oqw3ataxriy
         PA4KlpECwfAvamCvr20Xg1WsDrueWlqkP6Bhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729244541; x=1729849341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw9AwTwe/lSdKCrzY4oAj5Aeo7yDRO1/177hW5mT5co=;
        b=G/2+VFj+SpddKCf55JMdLsxPdJ37pc4t5qKJlTN09vxGrPd/vdPeEr4pia7uHoUqnS
         9FU0KnneUpSk329+lqLaWtauRc45al0Ez3MH+WsTT53NebDhoXkV0gr/5eWZfigLU+65
         EdrnA47Afnxy5n0t2i9olbVpTRyE8iAKhsIlFtHKZeNrk23QFsTLFf9EutjnsKjY/17c
         VAJ0NiOsOXiAobkZsrrMm6223y0dvYxtCLmZ4z0RaHVwlm4/qkJnbbKaKLcaf+ocYfJn
         Tpi90mMx9e/81sQ7tMJAzVW/v809ZjNiBLf3srAIlhIarPnrUzQjx5+H8oDveHDIua4r
         U7aw==
X-Forwarded-Encrypted: i=1; AJvYcCWqG4VZ+9ZIu+6lM/T6OT9420YO1rFcyNc2fiAMZjv2qna783mYd1YV8yyVEIN1PYCI/VLA9XZlORsd0OJL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eqiTv6Re3XGoAg3I8nEH41SEQfrFnvCJoncG/rcZe5O0FOxJ
	A94+rUAfSvx/XK9fa8cR57alwCeEW1nJ2DODL1FixfVbgCgC+QMErn0X7E6StgM+poJ3ffMn+iY
	pjHl5W4keLLgFgVK6jWmdUAPhChHuFspnkKP0fw==
X-Google-Smtp-Source: AGHT+IEj9l4mWj/yLjIBXQx+ZfOpGTTtvj/jHJnSTnhPIN9nEREN5Bma9w2X4rE9TorROLNxJC3MjApWWvq3RTB6da4=
X-Received: by 2002:a17:906:6a1e:b0:a9a:1115:486e with SMTP id
 a640c23a62f3a-a9a69c6a83emr150343366b.45.1729244541139; Fri, 18 Oct 2024
 02:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org> <20241014-work-overlayfs-v3-2-32b3fed1286e@kernel.org>
In-Reply-To: <20241014-work-overlayfs-v3-2-32b3fed1286e@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 18 Oct 2024 11:42:09 +0200
Message-ID: <CAJfpegvqDPqVMfUkTxVSE580QF5mqOeorH7fT+zUoZGqqZ3TNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] ovl: specify layers via file descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 11:41, Christian Brauner <brauner@kernel.org> wrote:

> +static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
> +                          enum ovl_opt layer)
> +{
> +       struct path layer_path __free(path_put) = {};
> +       int err = 0;
> +
> +       switch (param->type) {
> +       case fs_value_is_string:
> +               err = ovl_kern_path(param->string, &layer_path, layer);
> +               if (err)
> +                       return err;

What guarantees, that layer_path will not be stored to in the error case?

Common sense, yes.  But I'm sure there are hundreds of cases where
it's not the case, despite common sense.

Can static checkers deal with this?

Thanks,
Miklos

