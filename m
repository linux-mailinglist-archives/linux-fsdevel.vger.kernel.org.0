Return-Path: <linux-fsdevel+bounces-23954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62295935218
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 21:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1AE7B20D73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 19:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6864145A05;
	Thu, 18 Jul 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PHm0brYC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB5144D3B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330450; cv=none; b=GjnohvrbTSu3O5vWgs/7UD7TD59XutjxA1fvkfV+5Ej0adUKk4MB9AoUCPQUOhLN0cyOyXiIBaD1pkPoivbrDak7h/XvqUIJnTNGNFpdz5i79d3d/9CjT0otX5x2Wzq7gj4LzJlWgidmWvOuO1tPlpFHjNZK3YDd00X949/lirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330450; c=relaxed/simple;
	bh=grBvaQOdED6hCAH14mGymT0GXVTYaOm4rP9U9pCbDUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeHtCGxdhBELwTa2Y0Z8adX8UU7Fk22/4f9xIfG8Rcn9SuU4gqRXVJfoo0zN0EHtzuruIMxGMixq+YtSh9uTNji3wLNJSre0gCf48b4f6/qTD/KkRJIJ+z8gykPzcL8zCen0si58y/WAr252/TmjSQc+nl6BorbjLwHKAUAfrw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PHm0brYC; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 78C214107F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 19:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721329939;
	bh=grBvaQOdED6hCAH14mGymT0GXVTYaOm4rP9U9pCbDUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=PHm0brYCYxN4QDIVLr5o1RilzZt6qjtKL0EnG+YmnCKCdnG9sTGvVeuVgBDm/cUov
	 sLcnYNiW3cO1saHQ361zxU7Uq8eHF+CZYUmC4XX7jmDWYWVWgOItmPN6cvRjdyfAQx
	 rShGBMZySG4vNjjWAS/1kl46lliLP28u3bpKnQGObCrrSgVUYpnex6LgM7/jWJIKRi
	 wMmpMe5uZAipPkoTyNWRtFavILyYBx52H9RW4PRemR1Wex9mCXy+dmkprXQq38EP3r
	 gZ3LZjlW0F3wQOLDKfEoFGXgCWVV/KjuuQCiNqWObhOIbHLRNaL1+UWnszaarbvOss
	 yf0t/V+1aFL4g==
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7044952eed4so1443581a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 12:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721329938; x=1721934738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grBvaQOdED6hCAH14mGymT0GXVTYaOm4rP9U9pCbDUA=;
        b=ryA1kTMU483qP1g6Bf9/MFmJ0/sv4BbGiXT55B0vj+GIfhrTAv1f9owIdEAhJLQ2gC
         nL+KqvYC0fAsuW28g6gaH2LEcJpcLTJnvnquZgaG+6sZUWljj1ByksNXmguiM69HaHwm
         peKT8MeSzAfk6DXz1DbeakVTy1L6GBuiTOBeBPpwupeBo1hdQxpMk0uNPI2+J+zjwixj
         S+yQOKXjQ/t8OJ4WD+hwPww8aqixlSXclVG+4TaTLHkM9LOP29wrrelucwSh81VL7mze
         2ItrsQzawm1UHnF/cWDF9HXL1Cj5/wMBAfEO4pEbgJoNDdbFiis7fX4Hfo9vkFIqMwma
         8EpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4jZp9tJ2EX7+9L+RAxhtHE21eqzA6C0h9/VaWRnVzNST13CEUrF96a9KCBHVHT6HCOp1l55zqkKCuoft/KSbEsDqrf58wAISI9Gv/xw==
X-Gm-Message-State: AOJu0YytogLLz+6tU5TAJ9dTQKqDRZfUKXPW9PA5OLWA0oPcV/l4oIdR
	yl8Z5rHlPObspo5lpIyrXQ2EGhoeYZIPMhmGBZhhrx2ekBGq5coiIucl8y2VvpL0CeIifYOcF1G
	AUMaM1q2MarObaucxthdx/xPVFvTLX3GYPXn23SlYr6RBAMTLhaFlgF9kzNYn0mUygNULP6PtVr
	0hUWq736FtrprKJAiIKIl4Kj4jCC1Ng39i9H4sGh0W/pAgqQhHHB0e7Q==
X-Received: by 2002:a05:6830:6606:b0:703:68c2:8356 with SMTP id 46e09a7af769-708ecde03e2mr3144853a34.17.1721329938210;
        Thu, 18 Jul 2024 12:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPpiUfyU6v+89c/NdcYUeKlInqIxF4T/X9TJ3w2fD6hXf3QUPktFwxty9MIyOzA1iEwcYvn+FsAMR2eLrf8FY=
X-Received: by 2002:a05:6830:6606:b0:703:68c2:8356 with SMTP id
 46e09a7af769-708ecde03e2mr3144835a34.17.1721329937865; Thu, 18 Jul 2024
 12:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com> <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
In-Reply-To: <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 18 Jul 2024 21:12:07 +0200
Message-ID: <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mszeredi@redhat.com, brauner@kernel.org, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 3:38=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Mon, 8 Jan 2024 at 13:10, Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > To properly support vfs idmappings we need to provide
> > a fuse daemon with the correct owner uid/gid for
> > inode creation requests like mkdir, mknod, atomic_open,
> > symlink.
> >
> > Right now, fuse daemons use req->in.h.uid/req->in.h.gid
> > to set inode owner. These fields contain fsuid/fsgid of the
> > syscall's caller. And that's perfectly fine, because inode
> > owner have to be set to these values. But, for idmapped mounts
> > it's not the case and caller fsuid/fsgid !=3D inode owner, because
> > idmapped mounts do nothing with the caller fsuid/fsgid, but
> > affect inode owner uid/gid. It means that we can't apply vfsid
> > mapping to caller fsuid/fsgid, but instead we have to introduce
> > a new fields to store inode owner uid/gid which will be appropriately
> > transformed.

Hi Miklos,

>
> Does fsuid/fsgid have any meaning to the server?

As far as I know, some servers use fsuid/fsgid values in server-side
permission checks.

Sometimes, for example in Glusterfs, even when "default_permissions"
fuse mount option
is enabled these values are still used for permission checks. And yes,
this is a problem
for idmapped mount support. That's why we need to have some fuse
connection flag from
the server side which means "yes, I'm aware of idmapped mounts and I
really want it" (FUSE_ALLOW_IDMAP).

>
> Shouldn't this just set in.h.uid/in.h.gid to the mapped ids?
>

It is a very good and tricky question ;-)

We had big debates like a year ago when Christian and I were working on idm=
apped
mounts support for cephfs [1].

This was a first Christian's idea when he originally proposed a
patchset for cephfs [2]. The problem with this
approach is that we don't have an idmapping provided in all
inode_operations, we only have it where it is supposed to be.
To workaround that, Christian suggested applying a mapping only when
we have mnt_idmap, but if not just leave uid/gid as it is.
This, of course, leads to inconsistencies between different
inode_operations, for example ->lookup (idmapping is not applied) and
->symlink (idmapping is applied).
This inconsistency, really, is not a big deal usually, but... what if
a server does UID/GID-based permission checks? Then it is a problem,
obviously.

Xiubo Li (cephfs kernel driver maintainer) asked, why we don't just
want to pass mnt_idmap everywhere, including ->lookup.
Christian and I came up with arguments, why it's not the best idea to
pass idmapping everywhere. [3], [4], [5]

[1] https://lore.kernel.org/all/20230807132626.182101-1-aleksandr.mikhalits=
yn@canonical.com/
[2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/
[3] https://lore.kernel.org/lkml/20230609-alufolie-gezaubert-f18ef17cda12@b=
rauner/
[4] https://lore.kernel.org/lkml/20230614-westseite-urlaub-7a5afcf0577a@bra=
uner/
[5] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3=
RKM=3DZOYLg@mail.gmail.com/

Kind regards,
Alex

> Thanks,
> Miklos

