Return-Path: <linux-fsdevel+bounces-31157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD3E9928F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 12:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54072B23CE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A4E18E059;
	Mon,  7 Oct 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JG1A22tr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2CB1E519
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296162; cv=none; b=CGeJBCIMpyozW1B0EaNbHZrUFVDlA7x1KbNg11jzu+ahcN+yJIBkMDZrRXyTg1PgSLtHZfsgPxw+LNqwjisIel6DFHzRZZpeWXPPcc8u0CcDd8eWTGaiQMAezHnoRu1US+VasDgOD7mP7XqFvFXA2lsQ7HeZU+xTJwbjEpRqAZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296162; c=relaxed/simple;
	bh=QEW8xS45co+9Q5+FEHW81DqGS+oo/TRSeAM4ZM3skio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6oXCqOQ7TYIbzibyVNt37znY/ZoFc0eJT+/TrJNKOBQOQLv4zF3g6CHNsaGJF4VvHEFuUqRo19Z55iIsxIuoNYlYJm28HMgBhXXRHh1NXnMYxN+qq7jUjqNSr2gtmSqu0txQW9vv0cJCJF3OmP0y9sC3qLCg/AKPxD68DDWW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JG1A22tr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d43657255so692795766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728296159; x=1728900959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uD7+x06HNAsGvnUsU1IbHnMrioZv6+EXemRCdJxKLoc=;
        b=JG1A22trKkxeWEox2orUGktlpl6VEbgDbaodTAd30NA32GSkOR5ZqZ3E6iZ9SFU5of
         rfebmBe6r/Cbr4stD1kD6AExUcInMJGWWID9u3qXr/8/AkHlRQ+avwntU7s/XS1mE4fN
         sMowWHkKxx/d7sEXaF2k7EegA+kA0LDlLDNgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296159; x=1728900959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uD7+x06HNAsGvnUsU1IbHnMrioZv6+EXemRCdJxKLoc=;
        b=uQKquXh2PxXWhgz7sjsuqLDa6lv/JsIGs3ommL+8BAyU3HUpsVTR2LPLaRbbpgCZS1
         QIR+ZKWpJInZh1VVGH5SWkvNxwQ04u9wf+G7iXw0f7U9AyAcd3wplpavMoUfoOtEBiSO
         uen9EiGIGy1rsEn/0wKi7ykxpI6ZheoMelwrF5/W8DvvnubHUV2tcPeAVgSb/CLUOv++
         aPvyDm2xieP2FlNHYw9jrKbvrZGrKC36DvxS51ZF0uBrsnqnahsvZPsK2tHUg5MITcGQ
         pO2QFP6sCZOYphcTTZyyFWGWFgfDn9+HFTF3iv/UCc9EUuy7H08UrszPSV4aOBLSFFpp
         GSKg==
X-Forwarded-Encrypted: i=1; AJvYcCWbutQ8FH2IZvTX2jc8t0wL68RZqGerfmpjAZPpt+xocitNYKXm9NM1myJ7TqcROCmRJ3bhj6FBuVAb/MYp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/qzxmccDgg+SpdPjw0RGu+nP1HDJVWsspypTynwo1m38ltFs
	30mcijl25aFgpQihkaYtrBsFkAWoMSzFwSmjOzyOSzrwuFWHNWkgCW0dX9+mrpEGS68WaSrUMyc
	DtIxRA7BSXzVmhdYapTzN7R+Hm8qxxd/1Yf/NhA==
X-Google-Smtp-Source: AGHT+IHCZRkH8BOWmS+bXReQgFIle5qN39Wo9G9kYJNjoBdkjLUW7WB9tEXtznOwowsN9Uy1rnTsh/v4dV2Zx1Ta3bQ=
X-Received: by 2002:a17:907:7206:b0:a99:3dbf:648d with SMTP id
 a640c23a62f3a-a993dbf6715mr607796966b.45.1728296158491; Mon, 07 Oct 2024
 03:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004181828.3669209-1-sashal@kernel.org> <20241004181828.3669209-48-sashal@kernel.org>
In-Reply-To: <20241004181828.3669209-48-sashal@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 12:15:45 +0200
Message-ID: <CAJfpegtNF6CkSsE7yWq8-4W7HP3aOjE4xnAzJp0uiU-S7Wb8pg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.11 48/76] fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Miklos Szeredi <mszeredi@redhat.com>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 20:19, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> [ Upstream commit efad7153bf93db8565128f7567aab1d23e221098 ]
>
> Only f_path is used from backing files registered with
> FUSE_DEV_IOC_BACKING_OPEN, so it makes sense to allow O_PATH descriptors.
>
> O_PATH files have an empty f_op, so don't check read_iter/write_iter.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/fuse/passthrough.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 9666d13884ce5..62aee8289d110 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -228,16 +228,13 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
>         if (map->flags || map->padding)
>                 goto out;
>
> -       file = fget(map->fd);
> +       file = fget_raw(map->fd);
>         res = -EBADF;
>         if (!file)
>                 goto out;
>
> -       res = -EOPNOTSUPP;
> -       if (!file->f_op->read_iter || !file->f_op->write_iter)
> -               goto out_fput;
> -
>         backing_sb = file_inode(file)->i_sb;
> +       pr_info("%s: %x:%pD %i\n", __func__, backing_sb->s_dev, file, backing_sb->s_stack_depth);

That's a stray debug line that wasn't in there when I posted the patch
for review[1], but somehow made it into the pull...

Since this isn't a bug fix, it would be easiest to just drop the patch
from the stable queues.

But I'm okay with just dropping this stray line from the backport, or
waiting for an upstream fix which does that.

Thanks,
Miklos

[1] https://lore.kernel.org/all/20240913104703.1673180-1-mszeredi@redhat.com/

