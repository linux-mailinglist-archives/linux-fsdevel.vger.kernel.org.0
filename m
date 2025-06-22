Return-Path: <linux-fsdevel+bounces-52386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B637AE2EB4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 09:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF017A56F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2918FDBD;
	Sun, 22 Jun 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjjI7Pto"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E314658D;
	Sun, 22 Jun 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750576840; cv=none; b=AJya9KrTuUuOc5qlONKdGcVRdqmVQfRAtS+X3+wC0DA7UNklq/hZTu0J7vvJd48YK4nziDo9Pp88RCH5Hra1gQce0jsFl2Hty5NXf1ih1drs+4optWljL2Hs0rftYk9zyBL4YjjYfOhU10dszxmAkL6CCcSCAMXkKbFDYwNY4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750576840; c=relaxed/simple;
	bh=xsCeSIKrpuitGj5RpjSs5ZWjtiFxtBoNTPqaD/K1p6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ja1muibrU7W0l1D+6GY66TQaqUpgcy+P01F09jqDOyApKOkf9mq+u+VtPLzyB4+87Rl8KADON5HoGMHvB8I2LNH6ESAgm2rMmXj35dqsew9yI4+LijYYOgmeP1EVqEVIQtudoEAsxi2QFaiuyBkQEnvrd9QA8A2vC8Cza4l5I70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjjI7Pto; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad8826c05f2so590254466b.3;
        Sun, 22 Jun 2025 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750576837; x=1751181637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o30Y2lQBLgYsv5yiBQSksQ85lUbeMWS9bCkPQDj6kAk=;
        b=BjjI7PtorNUfy8uzyJOU+2lyvPGPkReQMvp/WxZPlV5ZpFlYJTRgsK8V2jSnyk4XMt
         6QJgyWHf9XFQDncIfo+svj1jPNGP8T/CdNVbmg7ozNSQ3UYcIsugp+XzqdvoQoImFtvv
         skG/4Kns2eKXB3de4CD3xWWY5JtlsFKYXCSPiZhW08LZP8APvkAuNwNgUZGG5Q8L0EAM
         tdTpXJpSZVJ+77kDYaAoS9k72M8L1wpkx4kWX/HgLfTBKm5zfaAfh8RbCTKrGH8VmBvh
         nzTZhUBu3CjXNj9+bRiDK2ZIctcWcU9+R/Y8iEIOPKXu6tHvjJRq0VpxbP/ck1Xb14dL
         0p+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750576837; x=1751181637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o30Y2lQBLgYsv5yiBQSksQ85lUbeMWS9bCkPQDj6kAk=;
        b=ms3XC6W80FEhdw775ABk3I3idtEUTFAKWSwrGVhP6ATmfFtcWkCQ9YAnUxzgEK0mO/
         PNKyKKSwWimFuaMaAJD7t/tSJRcXDvz722O/fF+Fw+gHkvHSFIrbNZNdL4lgkjhyqNQJ
         yqckb4Gyq6Xjx5O+Y2cPH8U6uPeXaU+QdFVFxMXVkH94Xlud5DqrHA6qmlDZM2jIjHmL
         f3f1WNyVad1AH/apKH9Svyg9LiD4mNx7BIdTu4Hhoa5oidkgK2gdRNGyRTqCWtrMUA2Z
         gQ1BYsoutEMTw3j9MIpal38iGXZoeME5fzZ+MPaTfzJ72VI+6Iy4/T3JE3cB3NQ5O99f
         noCg==
X-Forwarded-Encrypted: i=1; AJvYcCUSF2xyk75qX6wpESvbWGI7/UD3mbK+oDCo8hs3zxKFOUBWphEkFsyp1Ji6SP0llt1Yhy+5xKznanlS+azh@vger.kernel.org, AJvYcCWji0seVqJ6KQHU9evFW5n+nPWbuwLhn4X4trxeMPw5KFc1XoBR70ERJqDIE0IhQX1ACvBS9HLu49YEO7Zjqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUzc6wVBAgdUKjF4OxtjtxTjH+nPXpKRyTL2DeLsVWhM0OzZf
	bhzNBicrgDFNOztHsaMb0b/ZzvzwwgnaCLd/68X1/MAzXBomtqXoItqqpPABvITYhCDDV9n2tC1
	29FgLZigVtc8lsRotlLPKQ9uIz4IB1HE=
X-Gm-Gg: ASbGnctVgcM4wt3U3QcblPmXNfIUD/5jJLUIYRyySuf3qEprZ2/5Ya/jwbZPvkM4pAD
	ogkGLCXbETv1D/k3BEQHUbfqtT040Zh5lWVm6mAMkzMYA/2jAen0uPZUxgktAtTOnSnGXGSJcNV
	fZT0wo8uXjrw7Dcf6K9o57yN9qL2c41eiFaI8Ts9gi59DXVxNhvpiOFg==
X-Google-Smtp-Source: AGHT+IEEaWmYXA3co9D2Xg83kc5Csu/r6AYGmOfHWO0sdKCoIenqziUtz1FoGFJHBU/hSGuyl2hwdnPJSItkOUyC8HU=
X-Received: by 2002:a17:907:6088:b0:ad4:8ec1:8fc9 with SMTP id
 a640c23a62f3a-ae057b90470mr727960166b.42.1750576836593; Sun, 22 Jun 2025
 00:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602171702.1941891-1-amir73il@gmail.com> <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
 <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 22 Jun 2025 09:20:24 +0200
X-Gm-Features: Ac12FXzmN4RlRjktOqbrijx3XPUchCQybvvWcprKQbh1ZO5YwjNriDgGZ2kZTKc
Message-ID: <CAOQ4uxiNjZKonPKh7Zbz89TmSE67BVHmAtLMZGz=CazNAYRmGQ@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 10:06=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Sun, Jun 15, 2025 at 9:20=E2=80=AFPM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> > > Case folding is often applied to subtrees and not on an entire
> > > filesystem.
> > >
> > > Disallowing layers from filesystems that support case folding is over
> > > limiting.
> > >
> > > Replace the rule that case-folding capable are not allowed as layers
> > > with a rule that case folded directories are not allowed in a merged
> > > directory stack.
> > >
> > > Should case folding be enabled on an underlying directory while
> > > overlayfs is mounted the outcome is generally undefined.
> > >
> > > Specifically in ovl_lookup(), we check the base underlying directory
> > > and fail with -ESTALE and write a warning to kmsg if an underlying
> > > directory case folding is enabled.
> > >
> > > Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-1-=
kent.overstreet@linux.dev/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Miklos,
> > >
> > > This is my solution to Kent's request to allow overlayfs mount on
> > > bcachefs subtrees that do not have casefolding enabled, while other
> > > subtrees do have casefolding enabled.
> > >
> > > I have written a test to cover the change of behavior [1].
> > > This test does not run on old kernel's where the mount always fails
> > > with casefold capable layers.
> > >
> > > Let me know what you think.
> > >
> > > Kent,
> > >
> > > I have tested this on ext4.
> > > Please test on bcachefs.
> >
> > Where are we at with getting this in? I've got users who keep asking, s=
o
> > hoping we can get it backported to 6.15
>
> I'm planning to queue this for 6.17, but hoping to get an ACK from Miklos=
 first.
>

Hi Christian,

I would like to let this change soak in next for 6.17.
I can push to overlayfs-next, but since you have some changes on vfs.file,
I wanted to consult with you first.

The changes are independent so they could go through different trees,
but I don't like that so much, so I propose a few options.

1. make vfs.file a stable branch, so I can base overlayfs-next on it
2. rename to vfs.backing_file and make stable
3. take this single ovl patch via your tree, as I don't currently have
    any other ovl patches queued to 6.17

Let me know which is your preferred option.

Thanks,
Amir.

