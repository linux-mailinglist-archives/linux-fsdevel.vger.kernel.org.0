Return-Path: <linux-fsdevel+bounces-26102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415829544F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 10:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FF71C22935
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F1913DDC7;
	Fri, 16 Aug 2024 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aLay6emV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6313B286
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798721; cv=none; b=lCw1OfZE7mAdVCty1VNM72q/qC35a29+krCay4gGq+t/LLAURoTTg8REYgJ4n5mprJ3/GQndKdnsO/+mTnRPl67D6U7HIZH1z2gf8vgtUUeC3SQ2bjE9F4ixqDpmIMlPwgWApqKS91BxT8idDnaa2xzqhMW/MflyrhknnVH+xOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798721; c=relaxed/simple;
	bh=FzefXXQGvADrPX65XM5Hb5IRP3b/EgwpELN18Ulxmwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5XFYaii5O8k/8vWhzT7ylIVGqYadBhRTxm8uwO9t9OYXYtkD6OKKn4nsF8vMqfqfEZsINT8svt0YfPsR9mcbJVuePjK5RtHALptZltWyej330AxYfuB2yStUTeG1y1cNjQJ9aA6MQI2VhK4A/axBuMmru/fhAovCy2VnQacai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aLay6emV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 36D463F48A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 08:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723798714;
	bh=yqmTRLvnibvEjRY5HqDeK9lvfyHgdzJpnHG6YayP6Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=aLay6emVLj8qyFVsO7aawsTeu6G9QUICztqP0eJBZQp2tur8Mun+0uHJh9WuNtbv6
	 fKM33aQszMEPCkSYnp0/gYyOho9dgAK4XzufwY3e/V0rqVtekuULZiO5S7u05bMMYr
	 SIDOjLEa2y6Hq5dLMKjclwPFgdd/GFuBXMjvvPkkdJBnSB5DRzsjcIaE9Gvv+rRyS2
	 Yuidy7BKwzpvsvntysKn4O1DLuJIlnNjazZ+0n2cNHMCyoutfsZv0Vu90b59YcSR4q
	 Vyeh4e2keA6mPrNctaYDz3/QkqrfgfTdO+WTNaD3ZAA3PLEeopkYOC/Wzu7J8wXils
	 /h4zhfmMrWLUA==
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-843025058a3so153872241.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 01:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798713; x=1724403513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqmTRLvnibvEjRY5HqDeK9lvfyHgdzJpnHG6YayP6Ho=;
        b=ARXxERYm/Jzho2R7nwOmy5+oAtW5I9y8dWWyjZcqMp9kPxHNSb1+2Dxery0ZT3C1Gd
         kZzDkI/Hwf985smcv9o4TLghvR4W4PBbnmWC6H1U3ex+OE+y/pGQSjm/IEhv+2vNWY9s
         u2T+je/BZaeu92i8pk58WpLpfoXOvXPS4kHnQnTa8C4mO68U0/5oUVBKfASOnwz0/i67
         AaiiDBfI/MBHAvHxsOxMik5FJ9WEKRsqr3/0r8HfyETb5REL5gGPEnb+maQsEVYGI8Vo
         Ei+T2tx0Ry/hrku5hJQVdnpziOy7LvUVNe2BWd6katXP5i1dZOXFzCV9D55yn3mNQUMp
         7XXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4uUGnF2XMYe/5W331KYVJu7/uCbHFFCrNt7NTPW5hYZ+Ue7Tv9cdWNOqVxTu6pNn8Yzs55qIPN95ZexWnoI72Jjctb9kifUzCdn9Hvw==
X-Gm-Message-State: AOJu0YxJRSzaZB8FmDN3opuVuUBg6uNYxf/l9rOnrrTb0ZrLRWIGGXlw
	Ykoxsbwy6OwVH1jC1Z4IOMTWTv4XZoGyZ232NULJl/5RlnD2t7sBuUTytS5rwbYRAy22EhIrXC8
	CzFEYLTBiLfJ1NVLX+kd7GKL+VKkFBtEaRZilbrd8EUrK3Fm3Kt905b1NTZZMvln4iTR9OoUXqL
	HYjCQOJagz66AxaWy1cbGY917QsMHRKZ/Mg4FZn9RpYxO+0MdMeX2E+g==
X-Received: by 2002:a05:6102:304e:b0:493:b719:efaf with SMTP id ada2fe7eead31-497799b587emr2756144137.20.1723798713076;
        Fri, 16 Aug 2024 01:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhm27UN+fvyUuV5qkttHqILelIWDdRu2C3dzSzTnUDhviB8NPlkf46skhX5kIE0oEuyi6tM3DeJDok5XJti8c=
X-Received: by 2002:a05:6102:304e:b0:493:b719:efaf with SMTP id
 ada2fe7eead31-497799b587emr2756127137.20.1723798712758; Fri, 16 Aug 2024
 01:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com> <20240815-ehemaligen-duftstoffe-a5f2ab60ddc9@brauner>
In-Reply-To: <20240815-ehemaligen-duftstoffe-a5f2ab60ddc9@brauner>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Fri, 16 Aug 2024 10:58:21 +0200
Message-ID: <CAEivzxf2qH8XBXA2a+U4bQeeVC+eB8m9tDC08jxT=trFEzLpTA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] fuse: basic support for idmapped mounts
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Aug 15, 2024 at 11:24:17AM GMT, Alexander Mikhalitsyn wrote:
> > Dear friends,
> >
> > This patch series aimed to provide support for idmapped mounts
> > for fuse & virtiofs. We already have idmapped mounts support for almost=
 all
> > widely-used filesystems:
> > * local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS=
 (out-of-tree))
> > * network (ceph)
> >
> > Git tree (based on torvalds/master):
> > v3: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v3
> > current: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mount=
s
> >
> > Changelog for version 3:
> > - introduce and use a new SB_I_NOIDMAP flag (suggested by Christian)
> > - add support for virtiofs (+user space virtiofsd conversion)
> >
> > Changelog for version 2:
> > - removed "fs/namespace: introduce fs_type->allow_idmap hook" and simpl=
ified logic
> > to return -EIO if a fuse daemon does not support idmapped mounts (sugge=
sted
> > by Christian Brauner)
> > - passed an "idmap" in more cases even when it's not necessary to simpl=
ify things (suggested
> > by Christian Brauner)
> > - take ->rename() RENAME_WHITEOUT into account and forbid it for idmapp=
ed mount case
> >
> > Links to previous versions:
> > v2: https://lore.kernel.org/linux-fsdevel/20240814114034.113953-1-aleks=
andr.mikhalitsyn@canonical.com
> > tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v=
2
> > v1: https://lore.kernel.org/all/20240108120824.122178-1-aleksandr.mikha=
litsyn@canonical.com/#r
> > tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v=
1
> >
> > Having fuse (+virtiofs) supported looks like a good next step. At the s=
ame time
> > fuse conceptually close to the network filesystems and supporting it is
> > a quite challenging task.
> >
> > Let me briefly explain what was done in this series and which obstacles=
 we have.
> >
> > With this series, you can use idmapped mounts with fuse if the followin=
g
> > conditions are met:
> > 1. The filesystem daemon declares idmap support (new FUSE_INIT response=
 feature
> > flags FUSE_OWNER_UID_GID_EXT and FUSE_ALLOW_IDMAP)
> > 2. The filesystem superblock was mounted with the "default_permissions"=
 parameter
> > 3. The filesystem fuse daemon does not perform any UID/GID-based checks=
 internally
> > and fully trusts the kernel to do that (yes, it's almost the same as 2.=
)
> >
> > I have prepared a bunch of real-world examples of the user space modifi=
cations
> > that can be done to use this extension:
> > - libfuse support
> > https://github.com/mihalicyn/libfuse/commits/idmap_support
> > - fuse-overlayfs support:
> > https://github.com/mihalicyn/fuse-overlayfs/commits/idmap_support
> > - cephfs-fuse conversion example
> > https://github.com/mihalicyn/ceph/commits/fuse_idmap
> > - glusterfs conversion example (there is a conceptual issue)
> > https://github.com/mihalicyn/glusterfs/commits/fuse_idmap
> > - virtiofsd conversion example
> > https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245
>
> So I have no further comments on this and from my perspective this is:
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks, Christian! ;-)

>
> I would really like to see tests for this feature as this is available
> to unprivileged users.

Sure. I can confirm that this thing passes xfstests for virtiofs.

My setup:

- host machine

Virtiofsd options:

[ virtiofsd sources from
https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245 ]
./target/debug/virtiofsd --socket-path=3D/tmp/vfsd.sock --shared-dir
/home/alex/Documents/dev/tmp --announce-submounts
--inode-file-handles=3Dmandatory --posix-acl

QEMU options:
        -object memory-backend-memfd,id=3Dmem,size=3D$RAM,share=3Don \
        -numa node,memdev=3Dmem \
        -chardev socket,id=3Dchar0,path=3D/tmp/vfsd.sock \
        -device vhost-user-fs-pci,queue-size=3D1024,chardev=3Dchar0,tag=3Dm=
yfs \

- guest

xfstests version:

root@ubuntu:/home/ubuntu/xfstests-dev# git log | head -n 3
commit f5ada754d5838d29fd270257003d0d123a9d1cd2
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Fri Jul 26 09:51:07 2024 -0700

root@ubuntu:/home/ubuntu/xfstests-dev# cat local.config
export TEST_DEV=3Dmyfs
export TEST_DIR=3D/mnt/test
export FSTYP=3Dvirtiofs

root@ubuntu:/home/ubuntu/xfstests-dev# ./check -g idmapped
FSTYP         -- virtiofs
PLATFORM      -- Linux/x86_64 ubuntu 6.11.0-rc3+ #2 SMP
PREEMPT_DYNAMIC Fri Aug 16 10:23:41 CEST 2024

generic/633 1s ...  0s
generic/644 0s ...  1s
generic/645 18s ...  18s
generic/656       [not run] fsgqa user not defined.
generic/689       [not run] fsgqa user not defined.
generic/696       [not run] this test requires a valid $SCRATCH_DEV
generic/697 0s ...  1s
generic/698       [not run] this test requires a valid $SCRATCH_DEV
generic/699       [not run] this test requires a valid $SCRATCH_DEV
Ran: generic/633 generic/644 generic/645 generic/656 generic/689
generic/696 generic/697 generic/698 generic/699
Not run: generic/656 generic/689 generic/696 generic/698 generic/699
Passed all 9 tests

I'll try to do more tests, for example with fuse-overlayfs and get
back with results.

Kind regards,
Alex

