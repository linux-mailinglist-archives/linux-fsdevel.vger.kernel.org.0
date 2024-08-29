Return-Path: <linux-fsdevel+bounces-27812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF596443B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F004DB26991
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215F196C67;
	Thu, 29 Aug 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Q89Cjwd9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5619408D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933898; cv=none; b=ofTVAx8/p77NyUXW8XGqfSUQDKD9NuJgKhyPI/XAYX7Uk3mImLO35r6m9ARV7O8JaUGtaKO+aJOE/NWdTZbGGNXTA2eypDbnPND8oIwb5ksOh3E1KT+OtlTvHwTW1EckJeCr38nyLMQt6sJaRrt+Tp2jFzKT0T7EvftEQnnBXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933898; c=relaxed/simple;
	bh=nPbtzIWPtGgZ8ddKgweGtAo97LnSRzhBtcpnzjo9y6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbK7qwoux6FuT60OSrSBUc2tI/4FBSSy9ek6d/PQiY3aUX+h1MgRKL4BpACH8oWQUogTy8kbdvXeXxtlYpb4IjaN2vTkAjlDcXKS6wl1m46rzt91bqW72qZQ4GcRbqOiy8Yhoj+uAu6VVS8qLV6wYfY7/I6cw4RrdWKGtyhdjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Q89Cjwd9; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 24EB83F2B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724933888;
	bh=agyuHbgeN5G+Glllc9xwF5iz8tsF/j2Kakno2rsBnCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Q89Cjwd9UEkV2vBPQIVfAPD2T/0vHSPCJMuj8bd1H7/Yh7KaQu9XssPRKrHTNI6JM
	 qzYw5A9IiSkUJzxKEAMUPCEA3veAvNPdXAAsAtBQX+R2nv7/0DF8Iy6tA5I3UC2f5x
	 2dsqq9ht5C2YQ36A2UFcF9UkjDsOj1nXZRqT4XulH8Ye1UhtBxn4l31mUAMy/nwTni
	 MnOOvSmlLwQy9kHkwWr0M58sAbhwOvPkH5m+/Kj8ZTaiwWWjMt+dt8M3hdr07aRgp1
	 sALjFP2cwZHMJY2iVVZIZuiiI8ZtsUzEm5xBWSZkt239ha2S0HAh45sVS7j6dW+J8l
	 pBZ7U64i2w5tw==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3df0df238b2so90309b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 05:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724933887; x=1725538687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agyuHbgeN5G+Glllc9xwF5iz8tsF/j2Kakno2rsBnCU=;
        b=d9JBfcaBQhK54FqYQQyXqaTtuoVEgdEf7ey7r5A2GcWp5hwrgLX+V1RpMdXdaZEImj
         3RNNex8pERKHdA5CDlhduvoq0cYnApumYcMnvnCgQPWQIPA5SQPw31bmoMuhRFjbIIRu
         n0Ar32fbnP4c4nVDO14SucUYFeyYG/sVV0+gTEEcwIza4etx4KBz6GvkMf3rfavWNPCq
         FRm6A9Sx0iVU4staKkUexRD2rP5OK7Io4WKB5SHDFqegu99fO5vnuyYnfAdrgnHUbL68
         ZKi1bctewSJ+w6an634DNvqHeqkKyaxd1uGVYSZOoiUP9QWwPXlLsbCaDj5hBwBhhgIA
         GO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYuIcwi4WuZYUPjiydO5ZNwUM0blihxs5uGXXoHGZMpgcLjOOGcjx4ezf6BfEvulIekb6AORtoOhxGg7OU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76Q+zDMUFhvwCxRxuPld1SaA4jwgqY2ePiO+GT5mEV8JtvcTD
	DxggJEGgbxl7o8hkHab9DRhWOd86w1kyqp6X+dhlW1ygRZJXv6hVswBdev6yWDkxQDfjrD8s0BH
	0jydYEWY6WAaqxLvSDiZGNYq16FjnSsTvcHOr+f5KmQ3S0NGQ+cbnQXJx2YdtjfYZla398uKJsD
	ijOHlCnxUx8GSj/c8AMvPNfXvw1lwNkK8Mt2YsHI9eGb1NoWGfWSeX1T+c0Eq6azFr
X-Received: by 2002:a05:6808:3a0d:b0:3df:dad:10e1 with SMTP id 5614622812f47-3df0dad14b9mr387493b6e.13.1724933886882;
        Thu, 29 Aug 2024 05:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGhWDrBHdruJc4RhJ06FsFQi5d5GDa/1GlsVFtFype7PVLTCKgslSYz+vhfd3O4egbh57iMWClm03kaSZZmS8=
X-Received: by 2002:a05:6808:3a0d:b0:3df:dad:10e1 with SMTP id
 5614622812f47-3df0dad14b9mr387457b6e.13.1724933886565; Thu, 29 Aug 2024
 05:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com> <20240829-hurtig-vakuum-5011fdeca0ed@brauner>
In-Reply-To: <20240829-hurtig-vakuum-5011fdeca0ed@brauner>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 29 Aug 2024 14:17:55 +0200
Message-ID: <CAEivzxf1TLUeR_j8h5LfkmLOAKzrenK55bw9Qj4OV0=7Dkx9=w@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:08=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Aug 29, 2024 at 10:24:42AM GMT, Miklos Szeredi wrote:
> > On Thu, 18 Jul 2024 at 21:12, Aleksandr Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > > This was a first Christian's idea when he originally proposed a
> > > patchset for cephfs [2]. The problem with this
> > > approach is that we don't have an idmapping provided in all
> > > inode_operations, we only have it where it is supposed to be.
> > > To workaround that, Christian suggested applying a mapping only when
> > > we have mnt_idmap, but if not just leave uid/gid as it is.
> > > This, of course, leads to inconsistencies between different
> > > inode_operations, for example ->lookup (idmapping is not applied) and
> > > ->symlink (idmapping is applied).
> > > This inconsistency, really, is not a big deal usually, but... what if
> > > a server does UID/GID-based permission checks? Then it is a problem,
> > > obviously.
> >
> > Is it even sensible to do UID/GID-based permission checks in the
> > server if idmapping is enabled?

Dear friends,

>
> It really makes no sense.

+

>
> >
> > If not, then we should just somehow disable that configuration (i.e.
> > by the server having to opt into idmapping), and then we can just use
> > the in_h.[ugi]d for creates, no?
>
> Fwiw, that's what the patchset is doing. It's only supported if the
> server sets "default_permissions".

Yeah. Thanks, Christian!

That's what we have:

+++ b/fs/fuse/inode.c
@@ -1345,6 +1345,12 @@ static void process_init_reply(struct
fuse_mount *fm, struct fuse_args *args,
                 fm->sb->s_export_op =3D &fuse_export_fid_operations;
             if (flags & FUSE_OWNER_UID_GID_EXT)
                 fc->owner_uid_gid_ext =3D 1;
+            if (flags & FUSE_ALLOW_IDMAP) {
+                if (fc->owner_uid_gid_ext && fc->default_permissions)
+                    fm->sb->s_iflags &=3D ~SB_I_NOIDMAP;
+                else
+                    ok =3D false;
+            }
         } else {
             ra_pages =3D fc->max_read / PAGE_SIZE;

So idmapped mounts can be enabled ONLY if "default_permissions" mode
is set. At the same time,
some fuse servers (glusterfs), even when "default_permissions" is set,
still have some UID/GID-based checks.
So, they effectively duplicate permission checking logic in the
userspace. We can not do anything with that, but only
fix fuse servers to stop doing so. See also my PoC for glusterfs-fuse
idmapped mounts support:
https://github.com/mihalicyn/glusterfs/commit/ab3ec2c7cbe22618cba9cc94a52a4=
92b1904d0b2

Kind regards,
Alex

