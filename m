Return-Path: <linux-fsdevel+bounces-64237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EACE4BDE377
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 13:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1252F501CAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4847231D375;
	Wed, 15 Oct 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epo8xP7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8772613
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526582; cv=none; b=RI6Nc9+uvwxr34MlJ+rznJ17fVjeSCf117b3dBG5VB+BV+p89hSxF3RYdBdsFe9WcL+zOpbn0MvLw4qkkPqEHPP6rp++FusiHi4aQSCS/DTjCVMU2H0nNPagC3goARn/N59QtzW56fAmWtiRO/q8NOEWe3zUSYLaTJItPbMID/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526582; c=relaxed/simple;
	bh=88TkFDgRlIfQHgl5zZUJJfAxExgz6tw1uTTkiNBGftA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptX64Jlg8NI6AItfc40cO1MvqB7bLgv3ULgaXAJQH/rIH/jfLKGErmzIrqWfbzUMdyVJw3GaamDLyTAXmnkEaAWd6pI9TvyWMy+T6lzedkxN7bxeOIp92y2g9IG0VDDZkiJqWNumvQFr4jOZxmITjp5R4gSct0WuDQJvgtdoayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epo8xP7+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b472842981fso852196066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760526578; x=1761131378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88TkFDgRlIfQHgl5zZUJJfAxExgz6tw1uTTkiNBGftA=;
        b=epo8xP7+PpLAo2TvR6GGCT3BgTQ0F/9gYN+cbz/m5/0aiMoNHQ2vfuJHdnEEg23LJF
         ga+iJMPws3j6dAU0D1JDRG5kEOnP6Kl/Np9Z7MBnsTVdzWjmoEPQBZrt2v3NQH/dnL2V
         6wyVSHLCKS+sNBnDMa3DrrSplTVp1T43XuJKJHoofz5qncS6fVlBBhJby9l0O2dzsn22
         BDCCut63+tIaIi1Nk5hOkPRc0aaFrR4FgAuzxtuOZ6nECGHJ7ivjj0A77HxXLNV9KHrR
         bE48VMKYKCw4llZ0ETy6yRx9NWlhvN8w/CSYgqkpxsj+xOrRQorWkVFncuSpBZuMOfbw
         Bd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760526578; x=1761131378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88TkFDgRlIfQHgl5zZUJJfAxExgz6tw1uTTkiNBGftA=;
        b=eu0+JWPTJtpOGCzT76iGHHN0wYWZ4JsiCoHowcZdyvRKO+maE5kPcErv4xJ5jys7in
         KKYM7LNhE5RUpioUzV1ujqoosmgDKqLHCUF2Bt7u0wOwzO5A377PTmvS4nCFFUiB9to3
         RZblvpXvanao2V4UYGLcS6K9u02UZfCFBpuROMnvgqik/smyAa/J6DmzdUkplcmlB5zz
         gRuICXoEk29qMGFdaZccmZpwxEqEcNCOIKf2xJFzEAWB8IV189ZXXAI0wGMXgoIKOiKZ
         giRJXvqS30LrYhrzi9r1zPSIF2LjuBMS2ShHzhQEJvSCoT5YNAcFG2s5AhrRo8PKa67X
         aw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1ZevpfDgHBlrPtNPA4mzDcBoXHUHD1wBl7/p/OkZdQ7cmaCx6KqHdPR4ueMjmzPqzA2n8WEw62GFLu6QV@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtNyTaAVkWZwjNiXJZkBkq3xPV2EhSz8h17ZnNksL0IvMpT3Y
	X0eFW6HeNGBHV5gBAImslaitWGVq3HGJ/cmNIVD0vV8eRlYrl7G+6SP8pM2Cw5i+AN0c8pEvPEq
	58dOKcrNpa3O1FNtioQ/04PuEhTX6J6I=
X-Gm-Gg: ASbGncsgBS9oBZRkGOHbayxWaVx/OUslj4Okccd+zhEKtg4OMFN9ukHE7Yxw6cVm3/f
	iTw2taG5OKFe+LsVqMrVe/ThBrcqQ9yiWCHGkS6nqaYIk/oTREZWsuJ5ljgI44lvIPRKcWHYk2t
	oqWlgNTNKNE8fVNEo8/AalH9ByaZShJL983f0rrdL9NmvVWXJNvzHtmF5sXMxDt42zoWynpU7My
	LoPCEDgn/mUfZenMUiIk9jHhNlD05SPiqD3bdf7j74YA4PAlIzJNn3ZzAl7GJn4e7QS9g==
X-Google-Smtp-Source: AGHT+IENjDPxTkztbzr5F/4b/vkt/9YGbwIRgds1ThqVuYJojpUBDdNcgRHeSnatUXLVLK+HdDDWjzqOKNDZToZ4Kf4=
X-Received: by 2002:a17:907:2d0d:b0:b4e:f7cc:72f1 with SMTP id
 a640c23a62f3a-b50aaba1161mr2875382066b.22.1760526577879; Wed, 15 Oct 2025
 04:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014015707.129013-1-andrealmeid@igalia.com>
In-Reply-To: <20251014015707.129013-1-andrealmeid@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Oct 2025 13:09:26 +0200
X-Gm-Features: AS18NWCfEzFg8NKV02k0sHR2LvSmLeMLWcVIZrTlRnWiT-LzhBHhe8mgd_BcgMg
Message-ID: <CAOQ4uxhrQQmK+tc+eOjm7Pz2u=S6_2cnneyo4mNjVgyA7RNooA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl index=on
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>, 
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 3:57=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Hi everyone,
>
> When using overlayfs with the mount option index=3Don, the first time a d=
irectory is
> used as upper dir, overlayfs stores in a xattr "overlay.origin" the UUID =
of the
> filesystem being used in the layers. If the upper dir is reused, overlayf=
s
> refuses to mount for a different filesystem, by comparing the UUID with w=
hat's
> stored at overlay.origin, and it fails with "failed to verify upper root =
origin"
> on dmesg. Remounting with the very same fs is supported and works fine.
>
> However, btrfs mounts may have volatiles UUIDs. When mounting the exact s=
ame
> disk image with btrfs, a random UUID is assigned for the following disks =
each
> time they are mounted, stored at temp_fsid and used across the kernel as =
the
> disk UUID. `btrfs filesystem show` presents that. Calling statfs() howeve=
r shows
> the original (and duplicated) UUID for all disks.
>
> This feature doesn't work well with overlayfs with index=3Don, as when th=
e image
> is mounted a second time, will get a different UUID and ovl will refuse t=
o
> mount, breaking the user expectation that using the same image should wor=
k. A
> small script can be find in the end of this cover letter that illustrates=
 this.
>
> From this, I can think of some options:
>
> - Use statfs() internally to always get the fsid, that is persistent. The=
 patch
> here illustrates that approach, but doesn't fully implement it.
> - Create a new sb op, called get_uuid() so the filesystem returns what's
> appropriated.

FWIW this operation already exists in export_operations.
It is currently only used by pnfs and only implemented by xfs.
I would nor object for overlayfs to use this method if implemented
and fall back to copying uuid directly from s_uuid
(better yet make it a vfs helper)
Note that commit
8f720d9f892e0 xfs: publish UUID in struct super_block
was done for a similar reason.
The xfs mount option nouuid is the poor man's solution for
mounting cloned disk images.

Thanks,
Amir.

