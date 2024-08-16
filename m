Return-Path: <linux-fsdevel+bounces-26121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491DF954B61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 15:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCB7286F0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2939B1BC9E7;
	Fri, 16 Aug 2024 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="v4yVnjSS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC691B9B2A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815959; cv=none; b=jbkE7YomDNvwcdwiO6sDtRmJCe/Bnic6PJ1kxUcJbc/2f62sjJ3SgI00WN11Uk29ROawxrSO7y6KKaIIMGsza08y5nhwcPWu24R1UxsLtpp2rlfY+pzEzutf+NYgVZBDqv81CNylxtzkD31uQo0OUzkdxg5uKyTUPIJzZvESd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815959; c=relaxed/simple;
	bh=YjnkaqEjeiZJjCJ4SMEE+H6vOrJ3/vbOxyVXkygsqlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJNFd7aUoK4zCekx4iM3EyRFaYKMQu6CzUIcatEgEYFpns1HO1kOJJHW5DyzWwsEyCsjEOpiqMtGYX5+HZMUrjVslvXes6gYuPyJmpazuf8Olhl+UIodDsDChd+jQhP0YXZpBWwe3pM5VnCXWPtfiP7bHe+vPz9+q5HMEdNRsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=v4yVnjSS; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D4C023F31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723815947;
	bh=AgeewcS5kqKeOP856aRXSh6oiDU1aOWalQ4gW9NNbXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=v4yVnjSSlaMKDFj1GojuNvTRJlyATdi1l6XwO5BSO0iJ/vScvHMZK7Jeaoz6PfpQO
	 1oPFbJIQZIndS6sQPDbQXT6PSFIMS6NEk9FvjyGmUfs9+KJJ5XNLzhYhKDGnhsG9xi
	 jx9bc1OszUzqGlPsJ6QL5obVJRtmqtvlgRJ5NAPsLcsfdq2JCJ13QM5dpX1CJVrsox
	 PIamANS3ZhVNnoPkNKIwSUTvoLdIA/bR3k9KnACkgbdCTZaLEwS3A2vgQKbPNeP14y
	 Jz7qe0V6Q3mOcpqUkyPdRie0TCFyU/YcL/zS6qys5on/7A1oIF+BIZFXB4B54FAZpb
	 VnHy21Zp9PXZg==
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4f519ea76e5so907246e0c.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 06:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815946; x=1724420746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgeewcS5kqKeOP856aRXSh6oiDU1aOWalQ4gW9NNbXg=;
        b=p8KsbWmNlokrSwirqm+JDBun2iL39SE+y+xkSX6Lhn+jb9JghQVzVli0qipi2EseXF
         PIj2QTgbj2xCKSrHszC/TIz0i6E9HlRZ9FizoP0QB+KhWbWetqpjTTnDLERSNziRrueg
         1/zegsqMl13mpPCZkwpgMNLh4P2J0KMHMhLlwIFUcHfKNkyhp+hzBEF3d0l08HiNzlK+
         Q1fYZlEgIH0xytku/EmTtz7UJmouhxpuvA/D7KdFIEWjnw7UfdSFBoQrbntHkZu6s5WB
         Yh/lIMzwmqnGL5AHXA4Kzz8+9G4fwzUxTN9zSaf+ouHyM2JyUnwgcLLykcaHJ6ouInCW
         wbJg==
X-Forwarded-Encrypted: i=1; AJvYcCXWXRQ9kupPgUk0zt3EeinnQgOdLQtvE/wBUFGbyq34BJL0QMWJ0xsVvFmW7RefuQmfTwe41i6Hynwgjr9l@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2Z+Z4DYDFmmgccYAzt9h0GmYuk1UVcfhzJREo32PBlFpj0Zl
	WqeJ9FzJfU0NKKy6S/Nk4a5dN26A3jSlveHl5nsm73lFtwT5z2HGAhfYHPTIqOEyRoPYZ/GMg4T
	yZjQ10P7cSKKJi3KOsTE2de6r1uxFqmIPsybg6gYF4IhelXWcAAfJC2L26GJGmP/lylSPkclSiq
	XdnoDRmfg71zOFWPqHTHHcDsvBChBDHA6MsyIkQme9i4GaeOp1v2eLyg==
X-Received: by 2002:a05:6122:3124:b0:4f5:261a:bdc4 with SMTP id 71dfb90a1353d-4fc6c5e2d57mr3552261e0c.2.1723815946497;
        Fri, 16 Aug 2024 06:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHRRxgu1guXj0GfP5BNcgezp0uyDf7mr44vUMoChBSarxeu0X/lOyOo5YhWYYzIk9CCFqxf70d/aEV1D6sotU=
X-Received: by 2002:a05:6122:3124:b0:4f5:261a:bdc4 with SMTP id
 71dfb90a1353d-4fc6c5e2d57mr3552208e0c.2.1723815946058; Fri, 16 Aug 2024
 06:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
 <20240815-ehemaligen-duftstoffe-a5f2ab60ddc9@brauner> <CAEivzxf2qH8XBXA2a+U4bQeeVC+eB8m9tDC08jxT=trFEzLpTA@mail.gmail.com>
In-Reply-To: <CAEivzxf2qH8XBXA2a+U4bQeeVC+eB8m9tDC08jxT=trFEzLpTA@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Fri, 16 Aug 2024 15:45:35 +0200
Message-ID: <CAEivzxe2fdT1fPhbT4XUWLsR7LyTxv5oUmExyrq7QP4QfeDWyw@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] fuse: basic support for idmapped mounts
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:58=E2=80=AFAM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Fri, Aug 16, 2024 at 10:02=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> >
> > On Thu, Aug 15, 2024 at 11:24:17AM GMT, Alexander Mikhalitsyn wrote:
> > > Dear friends,
> > >
> > > This patch series aimed to provide support for idmapped mounts
> > > for fuse & virtiofs. We already have idmapped mounts support for almo=
st all
> > > widely-used filesystems:
> > > * local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, Z=
FS (out-of-tree))
> > > * network (ceph)
> > >
> > > Git tree (based on torvalds/master):
> > > v3: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v=
3
> > > current: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mou=
nts
> > >
> > > Changelog for version 3:
> > > - introduce and use a new SB_I_NOIDMAP flag (suggested by Christian)
> > > - add support for virtiofs (+user space virtiofsd conversion)
> > >
> > > Changelog for version 2:
> > > - removed "fs/namespace: introduce fs_type->allow_idmap hook" and sim=
plified logic
> > > to return -EIO if a fuse daemon does not support idmapped mounts (sug=
gested
> > > by Christian Brauner)
> > > - passed an "idmap" in more cases even when it's not necessary to sim=
plify things (suggested
> > > by Christian Brauner)
> > > - take ->rename() RENAME_WHITEOUT into account and forbid it for idma=
pped mount case
> > >
> > > Links to previous versions:
> > > v2: https://lore.kernel.org/linux-fsdevel/20240814114034.113953-1-ale=
ksandr.mikhalitsyn@canonical.com
> > > tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts=
.v2
> > > v1: https://lore.kernel.org/all/20240108120824.122178-1-aleksandr.mik=
halitsyn@canonical.com/#r
> > > tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts=
.v1
> > >
> > > Having fuse (+virtiofs) supported looks like a good next step. At the=
 same time
> > > fuse conceptually close to the network filesystems and supporting it =
is
> > > a quite challenging task.
> > >
> > > Let me briefly explain what was done in this series and which obstacl=
es we have.
> > >
> > > With this series, you can use idmapped mounts with fuse if the follow=
ing
> > > conditions are met:
> > > 1. The filesystem daemon declares idmap support (new FUSE_INIT respon=
se feature
> > > flags FUSE_OWNER_UID_GID_EXT and FUSE_ALLOW_IDMAP)
> > > 2. The filesystem superblock was mounted with the "default_permission=
s" parameter
> > > 3. The filesystem fuse daemon does not perform any UID/GID-based chec=
ks internally
> > > and fully trusts the kernel to do that (yes, it's almost the same as =
2.)
> > >
> > > I have prepared a bunch of real-world examples of the user space modi=
fications
> > > that can be done to use this extension:
> > > - libfuse support
> > > https://github.com/mihalicyn/libfuse/commits/idmap_support
> > > - fuse-overlayfs support:
> > > https://github.com/mihalicyn/fuse-overlayfs/commits/idmap_support
> > > - cephfs-fuse conversion example
> > > https://github.com/mihalicyn/ceph/commits/fuse_idmap
> > > - glusterfs conversion example (there is a conceptual issue)
> > > https://github.com/mihalicyn/glusterfs/commits/fuse_idmap
> > > - virtiofsd conversion example
> > > https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245
> >
> > So I have no further comments on this and from my perspective this is:
> >
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
>
> Thanks, Christian! ;-)
>
> >
> > I would really like to see tests for this feature as this is available
> > to unprivileged users.
>
> Sure. I can confirm that this thing passes xfstests for virtiofs.
>
> My setup:
>
> - host machine
>
> Virtiofsd options:
>
> [ virtiofsd sources from
> https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245 ]
> ./target/debug/virtiofsd --socket-path=3D/tmp/vfsd.sock --shared-dir
> /home/alex/Documents/dev/tmp --announce-submounts
> --inode-file-handles=3Dmandatory --posix-acl
>
> QEMU options:
>         -object memory-backend-memfd,id=3Dmem,size=3D$RAM,share=3Don \
>         -numa node,memdev=3Dmem \
>         -chardev socket,id=3Dchar0,path=3D/tmp/vfsd.sock \
>         -device vhost-user-fs-pci,queue-size=3D1024,chardev=3Dchar0,tag=
=3Dmyfs \
>
> - guest
>
> xfstests version:
>
> root@ubuntu:/home/ubuntu/xfstests-dev# git log | head -n 3
> commit f5ada754d5838d29fd270257003d0d123a9d1cd2
> Author: Darrick J. Wong <djwong@kernel.org>
> Date:   Fri Jul 26 09:51:07 2024 -0700
>
> root@ubuntu:/home/ubuntu/xfstests-dev# cat local.config
> export TEST_DEV=3Dmyfs
> export TEST_DIR=3D/mnt/test
> export FSTYP=3Dvirtiofs
>
> root@ubuntu:/home/ubuntu/xfstests-dev# ./check -g idmapped
> FSTYP         -- virtiofs
> PLATFORM      -- Linux/x86_64 ubuntu 6.11.0-rc3+ #2 SMP
> PREEMPT_DYNAMIC Fri Aug 16 10:23:41 CEST 2024
>
> generic/633 1s ...  0s
> generic/644 0s ...  1s
> generic/645 18s ...  18s
> generic/656       [not run] fsgqa user not defined.
> generic/689       [not run] fsgqa user not defined.
> generic/696       [not run] this test requires a valid $SCRATCH_DEV
> generic/697 0s ...  1s
> generic/698       [not run] this test requires a valid $SCRATCH_DEV
> generic/699       [not run] this test requires a valid $SCRATCH_DEV
> Ran: generic/633 generic/644 generic/645 generic/656 generic/689
> generic/696 generic/697 generic/698 generic/699
> Not run: generic/656 generic/689 generic/696 generic/698 generic/699
> Passed all 9 tests
>
> I'll try to do more tests, for example with fuse-overlayfs and get
> back with results.

Ok, it wasn't smooth to make xfstests to run with overlayfs-fuse.

It only started to live after I commented out a bunch of checks in
_check_if_dev_already_mounted/_check_mounted_on:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/xfstests-dev.git/tr=
ee/common/rc#n1613
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/xfstests-dev.git/tr=
ee/common/rc#n1635
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/xfstests-dev.git/tr=
ee/common/rc#n1644

I think we have some space for improvements for xfstests+fuse combination. =
:-)

$ cat /sbin/mount.fuse.overlayfs
#!/bin/bash
ulimit -n 1048576
exec /mnt/fuse-overlayfs/fuse-overlayfs -o $4 $1 $2

$ cat local.config
export TEST_DEV=3Dnon1
export TEST_DIR=3D/mnt2
export FSTYP=3Dfuse
export FUSE_SUBTYP=3D.overlayfs
export MOUNT_OPTIONS=3D"-olowerdir=3D/home/ubuntu/fuse_tmp/scratch_lower,up=
perdir=3D/home/ubuntu/fuse_tmp/scratch_upper,workdir=3D/home/ubuntu/fuse_tm=
p/scratch_work,allow_other,default_permissions"
export TEST_FS_MOUNT_OPTS=3D"-olowerdir=3D/home/ubuntu/fuse_tmp/lower,upper=
dir=3D/home/ubuntu/fuse_tmp/upper,workdir=3D/home/ubuntu/fuse_tmp/work,allo=
w_other,default_permissions"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D without idmapped mou=
nts support =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

# ./check -g idmapped
FSTYP         -- fuse
PLATFORM      -- Linux/x86_64 ubuntu 6.11.0-rc3+ #2 SMP
PREEMPT_DYNAMIC Fri Aug 16 10:23:41 CEST 2024

generic/633 0s ... [failed, exit status 1]- output mismatch (see
/home/ubuntu/xfstests-dev/results//generic/633.out.bad)
    --- tests/generic/633.out    2023-06-07 12:19:04.309062045 +0000
    +++ /home/ubuntu/xfstests-dev/results//generic/633.out.bad
2024-08-16 13:30:20.471569848 +0000
    @@ -1,2 +1,4 @@
     QA output created by 633
     Silence is golden
    +vfstest.c: 1561: setgid_create - Success - failure: is_setgid
    +vfstest.c: 2418: run_test - Success - failure: create operations
in directories with setgid bit set
    ...
    (Run 'diff -u /home/ubuntu/xfstests-dev/tests/generic/633.out
/home/ubuntu/xfstests-dev/results//generic/633.out.bad'  to see the
entire diff)
generic/644 0s ... [not run] vfstest not support by fuse
generic/645 10s ... [not run] vfstest not support by fuse
generic/656 0s ... [not run] vfstest not support by fuse
generic/689 0s ... [not run] vfstest not support by fuse
generic/696       [not run] this test requires a valid $SCRATCH_DEV
generic/697 1s ... - output mismatch (see
/home/ubuntu/xfstests-dev/results//generic/697.out.bad)
    --- tests/generic/697.out    2023-06-07 12:19:04.313062164 +0000
    +++ /home/ubuntu/xfstests-dev/results//generic/697.out.bad
2024-08-16 13:30:21.919598831 +0000
    @@ -1,2 +1,4 @@
     QA output created by 697
    +vfstest.c: 2018: setgid_create_acl - Success - failure: is_setgid
    +vfstest.c: 2418: run_test - Success - failure: create operations
in directories with setgid bit set under posix acl
     Silence is golden
    ...
    (Run 'diff -u /home/ubuntu/xfstests-dev/tests/generic/697.out
/home/ubuntu/xfstests-dev/results//generic/697.out.bad'  to see the
entire diff)

HINT: You _MAY_ be missing kernel fix:
      1639a49ccdce fs: move S_ISGID stripping into the vfs_*() helpers

generic/698       [not run] this test requires a valid $SCRATCH_DEV
generic/699       [not run] this test requires a valid $SCRATCH_DEV
Ran: generic/633 generic/644 generic/645 generic/656 generic/689
generic/696 generic/697 generic/698 generic/699
Not run: generic/644 generic/645 generic/656 generic/689 generic/696
generic/698 generic/699
Failures: generic/633 generic/697
Failed 2 of 9 tests

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D with idmapped mounts=
 support =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

# ./check -g idmapped
FSTYP         -- fuse
PLATFORM      -- Linux/x86_64 ubuntu 6.11.0-rc3+ #2 SMP
PREEMPT_DYNAMIC Fri Aug 16 10:23:41 CEST 2024

generic/633 0s ... [failed, exit status 1]- output mismatch (see
/home/ubuntu/xfstests-dev/results//generic/633.out.bad)
    --- tests/generic/633.out    2023-06-07 12:19:04.309062045 +0000
    +++ /home/ubuntu/xfstests-dev/results//generic/633.out.bad
2024-08-16 13:29:30.358557063 +0000
    @@ -1,2 +1,4 @@
     QA output created by 633
     Silence is golden
    +vfstest.c: 1561: setgid_create - Success - failure: is_setgid
    +vfstest.c: 2418: run_test - Success - failure: create operations
in directories with setgid bit set
    ...
    (Run 'diff -u /home/ubuntu/xfstests-dev/tests/generic/633.out
/home/ubuntu/xfstests-dev/results//generic/633.out.bad'  to see the
entire diff)
generic/644 0s ...  0s
generic/645 10s ...  10s
generic/656        0s
generic/689        0s
generic/696       [not run] this test requires a valid $SCRATCH_DEV
generic/697 1s ... - output mismatch (see
/home/ubuntu/xfstests-dev/results//generic/697.out.bad)
    --- tests/generic/697.out    2023-06-07 12:19:04.313062164 +0000
    +++ /home/ubuntu/xfstests-dev/results//generic/697.out.bad
2024-08-16 13:29:41.466783240 +0000
    @@ -1,2 +1,4 @@
     QA output created by 697
    +vfstest.c: 2018: setgid_create_acl - Success - failure: is_setgid
    +vfstest.c: 2418: run_test - Success - failure: create operations
in directories with setgid bit set under posix acl
     Silence is golden
    ...
    (Run 'diff -u /home/ubuntu/xfstests-dev/tests/generic/697.out
/home/ubuntu/xfstests-dev/results//generic/697.out.bad'  to see the
entire diff)

HINT: You _MAY_ be missing kernel fix:
      1639a49ccdce fs: move S_ISGID stripping into the vfs_*() helpers

generic/698       [not run] this test requires a valid $SCRATCH_DEV
generic/699       [not run] this test requires a valid $SCRATCH_DEV
Ran: generic/633 generic/644 generic/645 generic/656 generic/689
generic/696 generic/697 generic/698 generic/699
Not run: generic/696 generic/698 generic/699
Failures: generic/633 generic/697
Failed 2 of 9 tests

As we can see it's clearly not related to idmapped mounts, as I
compare two cases, overlayfs-fuse compiled *without* support for
idmapped
mounts and *with*.

>
> Kind regards,
> Alex

