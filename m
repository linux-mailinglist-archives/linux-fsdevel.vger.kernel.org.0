Return-Path: <linux-fsdevel+bounces-59117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF96BB349A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5647117E601
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29D309DB0;
	Mon, 25 Aug 2025 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLCKHKI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D42737E0;
	Mon, 25 Aug 2025 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144965; cv=none; b=mQHdTM69npDj+h1vtpFnNAdxMGuAVFnloT+IU9BzAqivYXcqNw51/yDnKZ54icy8tsBEXo8b5fumJCMP33CidasS/M69otfBFUhgTq7PvIOexqCRstq65P8kjdwn7y5RJi0X2dv9vEYAZe6nD6WSwR8AWWv3/ppO82QdoU/RQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144965; c=relaxed/simple;
	bh=bO93YHMity3JW3zcPdTgWP5tYDLILE3JK7gg860M89Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIfua47Ylj5n4I2q7WfBaUDNQokmgnp4KjZVE6n7cVbjD27IVzNAb3LQBQV9/+KyRtKX7put8PXXrkjKznZaX4yHP5fYsZE0qyVRpVSGx0l6gyzQTkX+MqNCjJBx7J8VsKmmW+bjunx4pL6zk4LCYf38DXU4g2+U2RjVxe1IMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLCKHKI/; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-435de6d0f5aso2890134b6e.1;
        Mon, 25 Aug 2025 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756144961; x=1756749761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWjjdZkS3kOEmAznhZwCYlPUFm9r6kfvZ4m+Rr2yBMM=;
        b=lLCKHKI/AOXU8psWRxXFmHJ39V+4U25m7hvawrkaiXp9n2ASdEzgxFUD2aLzKOJZaQ
         4kUxWygYligbss146MVmfN3n+WDZvGBbuhXCeVa8cgqNLXSt+20Dbct7BY02agzYCIgk
         4UNunQKNgp7Zjd0tLKOXfu/pVjktOMK95zMVaig9W6BmYB7yJLRJumhUT5pso3VB246c
         OfONHY/4qaak3C3EXEd2wwqtq6Wt9ys0fmid3rYxgTce623cCDZgirPjgXmAQHOxurh3
         x9go2nwX5mOXi7oVCDxQYEvy76fWsR0EAR93tJxsFPo/zgXsdLnKwrTRcuPt0E1sF3z7
         5DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144961; x=1756749761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWjjdZkS3kOEmAznhZwCYlPUFm9r6kfvZ4m+Rr2yBMM=;
        b=FgLZqQY9JeJixLqryEyfM1MVpYos6t6T8f8nm01QL8QMpKuBRfdWLyC0VJmqGDwxGS
         I9UtOABa8gYUKSAsPXNz41apAygszQLmmmhfGRiuAqdE7w82rPvHkCYZJEcj4Tut0Vdo
         dCVNcobA3YgB7sgU9OlTNpI+QbD63PAsSGVqaCH9JweVjrz7eaNckjaByM1pfqGiMVeI
         tMY1/gYfYT17eOqCIgkEflWOLY5ltaqMeDmaOJOuoRvoPdi1Lv7NcE0UZRtRndcNX/qg
         O7pasVEO5XlszqSY1PbnL+CdWILujrACH5hvvH3FrEmz4IKuzqQ7/1pce6n9fWMAkuci
         aZwg==
X-Forwarded-Encrypted: i=1; AJvYcCWuC7keWd5KvPQ/kn/HVWSPfaEePYvjVtDmpME2LdI5agLW5jsBiYoMSenAmWv9fKc6BjR4wqCCI2jYU/qi@vger.kernel.org, AJvYcCXYlirFxMQHsgKP3ZzwFSkKJlSjzsoUhjvNBt/sFNdivEFjXUXeE0VcNbPXs/lAzG39JUMP16k/8nqGrdIY@vger.kernel.org
X-Gm-Message-State: AOJu0YzZh9neDGU59Nq6rthbMZb0OQBBwTHVjTIBiJeqnfOzWPZ6AihU
	zEz4ZZQgkWZSYVFFXv+phivKtTA36iRQiRA4qDGsdv/HaB8MVAl32XXs6+r5UgB011Rula5nz0V
	dx9bLhF207usc0LecK3r3NMkZMHuuSGA=
X-Gm-Gg: ASbGncvKjLBVD3BN48QfJ1OROQD6H0S16XDYwc3BLiKel02r+KeSq3SEieg8FI9ahNw
	dl3g2yHoqpQwj0eYngHgJmeJ4HQifXflEsh5xUewyel2D3sgQOEpjKyFcQspPRa2XzJ5kO+jOqQ
	+stQtgUNZ/bFjb+RPF6OCLnOPuRKHCJP72fiZ3VlnO0xuq5DTCfpLOAw3XmbaPKi+VhzTyY2xbQ
	86IJcXT
X-Google-Smtp-Source: AGHT+IGVn1Byb1vBc09TjUHsAgjAK4BIr8u6jv+GG5qVH9suUlIglnpoZsN4iU1nxKdVKGf0A5Jic4FV/NL2cUkUwtw=
X-Received: by 2002:a05:6808:6d8d:b0:434:4b1:b650 with SMTP id
 5614622812f47-4378526d7efmr6093274b6e.39.1756144961386; Mon, 25 Aug 2025
 11:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68a8f5db.a00a0220.33401d.02e1.GAE@google.com> <tencent_F0CF4B761BAA2549BAA0BB1E33D09E561B08@qq.com>
In-Reply-To: <tencent_F0CF4B761BAA2549BAA0BB1E33D09E561B08@qq.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 25 Aug 2025 11:02:30 -0700
X-Gm-Features: Ac12FXy4s5Y-MPsvOYAErjvk6SGuELfAenDY9qGisgOsgzweZfLTHFf_eoIGTfA
Message-ID: <CAJnrk1acbc80OLZe9Pf7a-8HPRmkJhz=bZVRPOnJQWB78neVVg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Block access to folio overlimit
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:17=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> syz reported a slab-out-of-bounds Write in fuse_dev_do_write.
>
> Using the number of bytes alone as the termination condition in a loop
> can prematurely exhaust the allocated memory if the incremented byte coun=
t
> is less than PAGE_SIZE.

I don't think the last part of this is quite right. It's fine if the
incremented byte count is less than PAGE_SIZE (which will always be
the case if there's an offset). We only run into this issue when the
number of bytes to retrieve gets truncated by fc->max_pages as the
upper bound and there's an offset.

>
> Add a loop termination condition to prevent overruns.
>
> Fixes: 3568a9569326 ("fuse: support large folios for retrieves")
> Reported-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2d215d165f9354b9c4ea
> Tested-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/fuse/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e80cd8f2c049..5150aa25e64b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1893,7 +1893,7 @@ static int fuse_retrieve(struct fuse_mount *fm, str=
uct inode *inode,
>
>         index =3D outarg->offset >> PAGE_SHIFT;
>
> -       while (num) {
> +       while (num && ap->num_folios < num_pages) {
>                 struct folio *folio;
>                 unsigned int folio_offset;
>                 unsigned int nr_bytes;
> --
> 2.43.0

Thanks for the fix.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

