Return-Path: <linux-fsdevel+bounces-38420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF0A022F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB47A3A3AF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8411DB52D;
	Mon,  6 Jan 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DS4FxTAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574341DACB1
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159468; cv=none; b=UvqH/PJY7eJQx1cId/81agVh5Ccu0QhW1hooEiJokbJB6Gt+x8K6gfuzV2ZP0JIqWMC/YXp7HhYEsn15BP2DhVLs9xoYSfaK7cYhU+ZGwLEz8DzuYT0+Hz6MTT+AhyqKoTfMpcJJpsHK19tdh27i33+3xvggRDvy35+oeTbpOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159468; c=relaxed/simple;
	bh=9CTkFjc37xe701ScXrb0bFwtx1yORF8ToUIqEQ2ZEqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plTTDElTNzdn+iYtIbKU7FMC0kVLhiIuAiJvzoKO0IGQDrBNt9x6+9PktnLshn5zShAyqKoSUjK8N9nHH2HJH5ZQG34KTpUvcLJuaSRjz/x2pY1rqfVWjJhcshHQ5/ZAwIikaVSsXHwkFGcvZNN0K/7liozr2AcY2dIjmPyiTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DS4FxTAe; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467b955e288so139368341cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 02:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736159465; x=1736764265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQH0J+aklI/Hd+xD02u83ANSb5DumiQD1WXPgBcGGVI=;
        b=DS4FxTAesGMT8xzUsLB3DIGt51QnAP9y1HOVODw97fx5RUT7qBuI/Ej7wqx6IFJJQL
         wfNXoUfmVYQTwJPPzKksv1ZpzXINGV4d4tj8p3TmqSF/xomIioSgs850asgiFbJiaGx4
         lc0FOKp5VVeNKdzSo6qEEgy17WxdijmEotf6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736159465; x=1736764265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQH0J+aklI/Hd+xD02u83ANSb5DumiQD1WXPgBcGGVI=;
        b=LFwt2kd8U+pqoYajjlsCzQzvnKMXgCMkpRZX1RAs58w6b273M94FFkt9v2X0gblykP
         m9wDsM8bhXoMQ823cB2xDCWHN3W3fkU46AzgzqX9fZipNUx6Ld19HtAqkTKFLEyzLaRN
         T5OFpWThZaBjq0lxc4UD+qT895H/8aiezEuSugy+v9xBDXg1nr7homJ8Lw7LdgDbDndL
         MoMjyZZWadbSZOVUkzSn/bRIyApcEratyghGXUjZfdtAc8E04GUgCv9dvEdF1diHgBn3
         vDNmf/DCPHNUASUdDclruWonb4ncTcQbNyRB3nOc0ztySjGYnlS+Jk7bu7eD9DoJCV37
         ZhJA==
X-Forwarded-Encrypted: i=1; AJvYcCVl4YeD09yGs7xCZ2cyKmJQmIKcFczXfY8vYrQlmDQvgi8956+jG8ALDKSBJcTcgK36QnEYB0tP5b5iIDCZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yymz64ZuZ6ZxPBq6A5Jvj6oLNtnYvqk4KeJ63eYn6EEu7NcqxUF
	xZ+kMAkkTycsLhUB6HML/ZUdbBaeXuImnaCxzYi/AwodIhBBRtL0uQps6IcMPWMg6amdE8rkq86
	DW1kYo5jkOGy+Yr61gTHZYo4v0nG6DuQrRiEbZQ==
X-Gm-Gg: ASbGncvANch8XYhtTg8i865qLfBHxaKiHAvBsj8An+GFGzg5XK5eFHLOKlD4hwY7xE9
	v0ztmQzSkXt+Zayw8CSkAtubapnJ8RkkNkV+iIg==
X-Google-Smtp-Source: AGHT+IEzylZxoU9H0L/Wy4Vi034OcnldSERq+lfqU0hvlPOC2GJtC8TNCQDpC9DTqXVZcYiT+ior9/Eqz0fQzkFYBQQ=
X-Received: by 2002:ac8:7c4e:0:b0:466:957c:ab22 with SMTP id
 d75a77b69052e-46a4a96bf07mr825807031cf.43.1736159465082; Mon, 06 Jan 2025
 02:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250101130037.96680-1-amir73il@gmail.com>
In-Reply-To: <20250101130037.96680-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Jan 2025 11:30:54 +0100
Message-ID: <CAJfpegvJsbK3A5p-c615KnN+gC0EF4sFGzAHp+GWaMDn=78CEQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: respect FOPEN_KEEP_CACHE on opendir
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Prince Kumar <princer@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Jan 2025 at 14:00, Amir Goldstein <amir73il@gmail.com> wrote:
>
> The re-factoring of fuse_dir_open() missed the need to invalidate
> directory inode page cache with open flag FOPEN_KEEP_CACHE.
>
> Fixes: 7de64d521bf92 ("fuse: break up fuse_open_common()")
> Reported-by: Prince Kumar <princer@google.com>
> Closes: https://lore.kernel.org/linux-fsdevel/CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> I verified the fix using:
> passthrough_ll -d -o source=/src,cache=always /mnt
>
> and watching debug prints from repeating 'ls /mnt' invocations.
>
> With current upstream, dir cache is kept even though passthrough_ll
> never sets keep_cache in opendir.
>
> passthrough_hp always set keep_cache together with cache_readdir,
> so it could not have noticed this regression.
>
> I've modified passthrough_ll as follows to test the keep_cache flag:
>
>         fi->fh = (uintptr_t) d;
> <       if (lo->cache == CACHE_ALWAYS)
> >       if (lo->cache != CACHE_NEVER)
>                 fi->cache_readdir = 1;
> >       if (lo->cache == CACHE_ALWAYS)
> >               fi->keep_cache = 1;
>         fuse_reply_open(req, fi);
>         return;

Thanks for fixing this, Amir.

Miklos

