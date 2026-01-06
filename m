Return-Path: <linux-fsdevel+bounces-72559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 568B6CFB5A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 00:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEA6330285EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 23:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660092FD7D3;
	Tue,  6 Jan 2026 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh/rkw7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818E2D6E66
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742484; cv=none; b=QftrIHIPNdV1s9hnsSYLSM0VzSI9Ghqxex6zVgwTvfK2U0kcj4+J07gPah8ZQanhz3X+IFMZMXGxaPmDaDiNFYno+1mnDNX5HuPo5ieovV+Y9503ZNIPh0J6Wnj1IHuSMZRO8bOdX5lK3F8FfAPhjf+fglCiRyTetafJtsC9zfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742484; c=relaxed/simple;
	bh=vg9l9JiK6D4LbxEjL64fkMYOPNk1wwkoSLCeb5G+v60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCzfLQem4jrNuEXSd5bfRe1Wy4RG1xVei0WWMQNDZu497g8d50k7HkSYrZxmOuloRrFKeV1ZxAGTYWBOR4z+FmHipmCe3Y5TO9ngGqb7LkIsUte7pJACQjZNuLkpQZxFFduuclpkrFcMO/vubPk15jmLbwl6B6ExY8SvYd+SDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh/rkw7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D93C116C6
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 23:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767742484;
	bh=vg9l9JiK6D4LbxEjL64fkMYOPNk1wwkoSLCeb5G+v60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nh/rkw7dRSG7ogti5mIWsF4SATHGzDLQheJl69Ks8Yzv77ZcCuf/LFWycnB8H9738
	 FlY/nJaQq5SYERIvn2KqADVX54F3U6wuRuJT27rVl8790OZ79KP8azJ9J5zmYFW+aI
	 5gF/I9K4at6Nz1043eGga5ar6x2tIuQ+ex9hSrF0T0bRM/54ZfCs6hYvD2v7QSXdLv
	 ud7QPnilURolXB1fHSdWtgTYJbLkEPVqKzUyb3a27NiVbabOXdMz/DV1R8JkkH3VA5
	 jT/Xqt90st5pC08/usinXZ31atAxtBnnCVUiyoEv1WaQ0eVxKR/VYzld0py1hBuwYx
	 Zf0+mkxjMMJvw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b72b495aa81so277230366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 15:34:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfHeUHojsy/i5b03iIT4R3U6vGs9CHp1RHPovQYX/s3AwlXawFQwPX+9SD0N4eMv1TdldgDdmmndR7Y/Nz@vger.kernel.org
X-Gm-Message-State: AOJu0YwniZQmivCW5XqsvtUCveoVYv9N2GOFuQ98LTv3kjl0lsOLTTUf
	iMbK8FqggrStcVuBI3uJxBGrYxOtDYHrLZuHS7v838T1u8WQyMou2FWWjw/Q1Obf0IBgr32zcxi
	7EUA0x7VxV+35+kYO8BVPNzmmaR+stwQ=
X-Google-Smtp-Source: AGHT+IFOAl2OIfVOlQdJa4MAWiGKIEvdJnfMwIQC+boq97I/jLYhGG1u7gyFhekDgEOERBOgX/xAd/0d7JFNakUGuOM=
X-Received: by 2002:a17:907:3e18:b0:b73:6b24:14ba with SMTP id
 a640c23a62f3a-b84451efc6cmr67730466b.8.1767742482861; Tue, 06 Jan 2026
 15:34:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106131110.46687-1-linkinjeon@kernel.org> <20260106131110.46687-14-linkinjeon@kernel.org>
 <CAOQ4uxj8kuuUE4xPXHTiFY8VM1fjkBBkBtDppSU62rFyezoC2Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxj8kuuUE4xPXHTiFY8VM1fjkBBkBtDppSU62rFyezoC2Q@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 7 Jan 2026 08:34:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-OMxr+CePjY_fO42ysaqn3DFPSpqhEbAxH5OtBgOwL4Q@mail.gmail.com>
X-Gm-Features: AQt7F2p1qRXD943Ni5fwro9oatrMUNlb3FsXVriwt6WAfZkMgJAY9Ff3o8Gpcso
Message-ID: <CAKYAXd-OMxr+CePjY_fO42ysaqn3DFPSpqhEbAxH5OtBgOwL4Q@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] ntfs: add Kconfig and Makefile
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 12:03=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Jan 6, 2026 at 2:26=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org=
> wrote:
> >
> > This introduce Kconfig and Makefile for remade ntfs.
> > And this patch make ntfs and ntfs3 mutually exclusive so only one can b=
e
> > built-in(y), while both can still be built as modules(m).
> >
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Thanks!
>
> > ---
> >  fs/Kconfig       |  1 +
> >  fs/Makefile      |  1 +
> >  fs/ntfs/Kconfig  | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ntfs/Makefile | 13 +++++++++++++
> >  fs/ntfs3/Kconfig |  1 +
> >  5 files changed, 61 insertions(+)
> >  create mode 100644 fs/ntfs/Kconfig
> >  create mode 100644 fs/ntfs/Makefile
> >
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 0bfdaecaa877..43cb06de297f 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -152,6 +152,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
> >
> >  source "fs/fat/Kconfig"
> >  source "fs/exfat/Kconfig"
> > +source "fs/ntfs/Kconfig"
> >  source "fs/ntfs3/Kconfig"
> >
> >  endmenu
> > diff --git a/fs/Makefile b/fs/Makefile
> > index a04274a3c854..6893496697c4 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -90,6 +90,7 @@ obj-$(CONFIG_NLS)             +=3D nls/
> >  obj-y                          +=3D unicode/
> >  obj-$(CONFIG_SMBFS)            +=3D smb/
> >  obj-$(CONFIG_HPFS_FS)          +=3D hpfs/
> > +obj-$(CONFIG_NTFS_FS)          +=3D ntfs/
> >  obj-$(CONFIG_NTFS3_FS)         +=3D ntfs3/
> >  obj-$(CONFIG_UFS_FS)           +=3D ufs/
> >  obj-$(CONFIG_EFS_FS)           +=3D efs/
> > diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
> > new file mode 100644
> > index 000000000000..6b49c99e4834
> > --- /dev/null
> > +++ b/fs/ntfs/Kconfig
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config NTFS_FS
> > +       tristate "NTFS file system support"
> > +       select NLS
> > +       help
> > +         NTFS is the file system of Microsoft Windows NT, 2000, XP and=
 2003.
> > +         This allows you to mount devices formatted with the ntfs file=
 system.
> > +
> > +         To compile this as a module, choose M here: the module will b=
e called
> > +         ntfs.
> > +
> > +config NTFS_DEBUG
> > +       bool "NTFS debugging support"
> > +       depends on NTFS_FS
> > +       help
> > +         If you are experiencing any problems with the NTFS file syste=
m, say
> > +         Y here.  This will result in additional consistency checks to=
 be
> > +         performed by the driver as well as additional debugging messa=
ges to
> > +         be written to the system log.  Note that debugging messages a=
re
> > +         disabled by default.  To enable them, supply the option debug=
_msgs=3D1
> > +         at the kernel command line when booting the kernel or as an o=
ption
> > +         to insmod when loading the ntfs module.  Once the driver is a=
ctive,
> > +         you can enable debugging messages by doing (as root):
> > +         echo 1 > /proc/sys/fs/ntfs-debug
> > +         Replacing the "1" with "0" would disable debug messages.
> > +
> > +         If you leave debugging messages disabled, this results in lit=
tle
> > +         overhead, but enabling debug messages results in very signifi=
cant
> > +         slowdown of the system.
> > +
> > +         When reporting bugs, please try to have available a full dump=
 of
> > +         debugging messages while the misbehaviour was occurring.
> > +
> > +config NTFS_FS_POSIX_ACL
> > +       bool "NTFS POSIX Access Control Lists"
> > +       depends on NTFS_FS
> > +       select FS_POSIX_ACL
> > +       help
> > +         POSIX Access Control Lists (ACLs) support additional access r=
ights
> > +         for users and groups beyond the standard owner/group/world sc=
heme,
> > +         and this option selects support for ACLs specifically for ntf=
s
> > +         filesystems.
> > +         NOTE: this is linux only feature. Windows will ignore these A=
CLs.
> > +
> > +         If you don't know what Access Control Lists are, say N.
> > diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
> > new file mode 100644
> > index 000000000000..d235ce03289e
> > --- /dev/null
> > +++ b/fs/ntfs/Makefile
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for the ntfs filesystem support.
> > +#
> > +
> > +obj-$(CONFIG_NTFS_FS) +=3D ntfs.o
> > +
> > +ntfs-y :=3D aops.o attrib.o collate.o dir.o file.o index.o inode.o \
> > +         mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.=
o \
> > +         upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
> > +         iomap.o debug.o sysctl.o quota.o
> > +
> > +ccflags-$(CONFIG_NTFS_DEBUG) +=3D -DDEBUG
> > diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> > index cdfdf51e55d7..876dbc613ae6 100644
> > --- a/fs/ntfs3/Kconfig
> > +++ b/fs/ntfs3/Kconfig
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config NTFS3_FS
> >         tristate "NTFS Read-Write file system support"
> > +       depends on !NTFS_FS || m
>
> Do you need this also in config NTFS_FS or is  this here enough?
Adding it only here was enough when I tested.
> Maybe add the explicit dependency also there for clarity?
I couldn't add it to NTFS_FS kconfig because it triggers a recursive
dependency error.

error: recursive dependency detected!
symbol NTFS_FS depends on NTFS3_FS
symbol NTFS3_FS depends on NTFS_FS
For a resolution refer to Documentation/kbuild/kconfig-language.rst
subsection "Kconfig recursive dependency limitations"

make[2]: *** [scripts/kconfig/Makefile:56: menuconfig] Error 1
make[1]: *** [/home/linkinjeon/linux/namjae/smb3-kernel/Makefile:742:
menuconfig] Error 2
make: *** [Makefile:248: __sub-make] Error 2
>
> Thanks,
> Amir.

