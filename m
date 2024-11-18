Return-Path: <linux-fsdevel+bounces-35097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D604C9D107B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 13:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A01F229A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E521419AA5F;
	Mon, 18 Nov 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ubof+VgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD71993BD;
	Mon, 18 Nov 2024 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932327; cv=none; b=UspLDU0v0pBotrx/A4eHpIlyYzthPNDhXtejju5TQzop71uIQMfHJiUXMhCGOhCDxJtZmZc9HcSjTMoCuU1Q4eNbgZ3cR1BwGBsVrOO/eD+E+ZnIKLS18cC9qUWwVewidlHHvPmrdlolCx+JfpUcnRV/xVSRDPVApCuyhhkfSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932327; c=relaxed/simple;
	bh=yDsohliDOZudRrQrujTiKASGsUMF3ytPqQxGXKnP1do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj8J7eibBvtgnhAp97t9xqv5/VQhZOnyPoRvKrh9WJBLsxPvNZEM0/GXjaJVyLfHnXf0WacD2xKc8AXRZ1DhUtHy21bctG6wB65g+BFnXTUEGdzg7bQUc2KS8hHYHtJp4Xj7VKCkoAh9rtOERZIvCwHreLx2ZA1ssKZ8EvDtEbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ubof+VgI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ec86a67feso806442266b.1;
        Mon, 18 Nov 2024 04:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731932324; x=1732537124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDsohliDOZudRrQrujTiKASGsUMF3ytPqQxGXKnP1do=;
        b=Ubof+VgIZOqM4vgQWB+j3ds7AhSzwssJ7xddTlhF5EyhR0oc8kaB5W8px1c8QreMJg
         oR2tTptpK29fgRok7OWJW98x60AGsNyPErmvb61iJVejUSfqfY2HQb4HQtP5V/PyZ72U
         2LeNmzhvhl/O/Pm88IhynxlImORdQf6vF9KVbUau7vGk3LBHw6kBnRBnfnbN78DrfRmu
         oKgYm6bdvxJXmWqRPy7CAci7dXlQPh3TnAFkrKXwfdsG6BxbEzQgLJsZ5tpjZJAs/BFT
         GBZrcrSFUXIJQM66rcf4MLfNGU5j9QZo/viNdSpn5j9AB4mS0qBKOgKm0OAfP2i48e9+
         j4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731932324; x=1732537124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDsohliDOZudRrQrujTiKASGsUMF3ytPqQxGXKnP1do=;
        b=Dk0zPl0kyXQMbFczYQ8MosCjiKx0WEP1uah1uMniVOq7SaNjZTQ0PpzYeow9t8jUJI
         h3hwkhbXDluyCBlNjVxHeBVa6hzALVINi0yer7ocT/BLAJqMr5XfbBaqVKXQCU3X0bpb
         JPogrUmY0JrTmcvK5H+Ls9PVrppXI+gznLr8eb9qZFgVnNCQRlNMLmCuRWSwX+mAUToe
         kIuD6XgPC79G7KtoOCifsQoWsEtvZW1+vRtlIYVPciONBAc+WkLLUz0UXjPfYhhAeDkL
         ZPgCbBBkCxnoYqPqwBlrphUnpBnRIDpW58I6i0razM2oJVDTg3PAVoWoLGsaJjFOA1u/
         FKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSkUEy/KqtRuUPv4s9973M2+GHYZgpStIL1a9UHbq7qKAzf03Xfp8P6ImUryhyadCGRnED5vgwUQf7zgt0@vger.kernel.org, AJvYcCXUjLuXOZsODeKD2WAWcmEBY8IcBK6l9N0+lbUUK9VN/nZsUOgxGL4KB4Hjaum7b+69QSBB1LapwvzyArHt@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQ5MQYM6Xs7AD+UewBdw4I7m07oGnEF8eXUc5MlXAJkkv8DJx
	DKyiCotCNqnSJvSAItE1tKKkhRSNQ9CX0HxHzxNm4TUN14+GKW58TopIxUcy7IUACl/v1ESFCSZ
	QFk47BEA90AdXyOeJS7P8unfNJ1E=
X-Google-Smtp-Source: AGHT+IHQJYYIr9PB+WzV3jcYDAnV8dwUhr1rpo/KX7OG4Saau0b2lt/S0o+p3wdDC3DA5c/HDTGyYIBYRMV+Di0Y2gI=
X-Received: by 2002:a17:907:9281:b0:a9e:43d9:401a with SMTP id
 a640c23a62f3a-aa4834263a3mr1118913166b.14.1731932323629; Mon, 18 Nov 2024
 04:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118002024.451858-1-mjguzik@gmail.com> <20241118112632.gfnhr7ldcjdi6d2z@quack3>
In-Reply-To: <20241118112632.gfnhr7ldcjdi6d2z@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 18 Nov 2024 13:18:31 +0100
Message-ID: <CAGudoHERYqaW8oNf44kHG19OHwtrGGAk0AW2UnnX_NKn8aQcOA@mail.gmail.com>
Subject: Re: [PATCH] vfs: move getattr in inode_operations to a more commonly
 read area
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 12:26=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 18-11-24 01:20:24, Mateusz Guzik wrote:
> > Notabaly occupied by lookup, get_link and permission.
> >
> > This pushes unlink to another cache line, otherwise the layout is the
> > same on that front.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > Probably more can be done to rearrange struct. If someone is down to do
> > it, I'm happy with this patch being dropped.
>
> This makes some sense to me although I'd like to establish some higher
> level guidelines (and document them in a comment) about what goes where i=
n
> the inode_operations struct. A lot of accesses to inode->i_op actually do
> get optimized away with inode->i_opflags (e.g. frequent stuff like
> .permission or .get_inode_acl) so there are actually high chances there's
> only one access to inode->i_op for the operation we are doing and in such
> case the ordering inside inode_operations doesn't really matter (it's
> likely cache cold anyway). So I'm somewhat uncertain what the right
> grouping should be and if it matters at all.
>

So I ran bpftrace attached to all ext4 inode ops during the venerable
kernel build.

As I expected getattr is most commonly used. But indeed the rest is a
footnote in comparison, so it very well may be this change is a nop or
close to it.

So ye, I this is probably droppable as is, I'm not definitely not
going to push one way or the other.

result:
@[kprobe:ext4_tmpfile]: 1
@[kprobe:ext4_symlink]: 2
@[kprobe:ext4_set_acl]: 18
@[kprobe:ext4_rename2]: 69
@[kprobe:ext4_rmdir]: 163
@[kprobe:ext4_mkdir]: 172
@[kprobe:ext4_get_acl]: 753
@[kprobe:ext4_setattr]: 3938
@[kprobe:ext4_unlink]: 7218
@[kprobe:ext4_create]: 18576
@[kprobe:ext4_lookup]: 99644
@[kprobe:ext4_file_getattr]: 5737047
@[kprobe:ext4_getattr]: 5909325

oneliner: bpftrace -e
'kprobe:ext4_create,kprobe:ext4_fiemap,kprobe:ext4_fileattr_get,kprobe:ext4=
_fileattr_set,kprobe:ext4_file_getattr,kprobe:ext4_get_acl,kprobe:ext4_geta=
ttr,kprobe:ext4_link,kprobe:ext4_listxattr,kprobe:ext4_lookup,kprobe:ext4_m=
kdir,kprobe:ext4_mknod,kprobe:ext4_rename2,kprobe:ext4_rmdir,kprobe:ext4_se=
t_acl,kprobe:ext4_setattr,kprobe:ext4_symlink,kprobe:ext4_tmpfile,kprobe:ex=
t4_unlink
{ @[probe] =3D count(); }'
--=20
Mateusz Guzik <mjguzik gmail.com>

