Return-Path: <linux-fsdevel+bounces-72187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ACACE7000
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 758F93001628
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FAD31BCAA;
	Mon, 29 Dec 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9BtxHpN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247231B814
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018147; cv=none; b=YxKAU+UgZ66dZ/epSMBqX1YplZwS2kW4pcTkSV2kFWFemohElibBABURXOkjz7G2XgX2gXg+gcsFNdLiHX+0cNVXIMzHFjo4huXiJOkZqDYjtWlUSc9RWSBXem1muSLo7J2tO880wECTK/a7tH/gR3VGxOEuUw8JNm9kt5gPTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018147; c=relaxed/simple;
	bh=Dz9fhbhTHNycjcXRb4JHYXmlvtoBKSYDEJeKFaSEUUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxNDQEwkPcijZZDk/yAVLYn6FcN+CsyIWVhIt30+3rrCX7m0H/N674pvSPH5M2FbMJWadtpGTYv3e23gftjm6n3SUdVo31V2CscUIwq5emtXPgaB7TcrGJbdTD0lP6/2ZwnMvujS5Ho4LKl94JB737VXrKEuYKYgmKE054++Q2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9BtxHpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2C7C2BCB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767018147;
	bh=Dz9fhbhTHNycjcXRb4JHYXmlvtoBKSYDEJeKFaSEUUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T9BtxHpNz+CyJ3pxgCVMjExbj8veYYldEHkVCJ4nc+aflYN9UCFXWbVOM70SL3Qxr
	 d3H/BkfzfTcE74nDtxYS4CXapQUe3oQBh+5eznvXYz7bsyH+anBFRIjRD5dLeF4y7G
	 zBNtDGkd5NReTSxAY9VTIZscgg0bTsEc82O3X8Efg9pkCCZ63xfBnU8648Mmg4vKcZ
	 eghAHfFc9Am9JYslGbW8Br7Ze5KXlI+YP7sp2wZXQnHldBj28jDau7kLULgJkuIkwq
	 eWGkAmqg/wdo9A4GVyswkjqL9YjxHfYHRnO1gPB6syqNz9kizYgx0rfUvCokbd8aGb
	 qtOn4vT13JKOQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8018eba13cso1381310266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 06:22:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXVcQEM3R+5fuujH4pZ9QMQvFzZTHE3kDfug2M7/OWTcx3wunTbx7PFt0hwlE7jzN0z0ntniUzeVItz9oAP@vger.kernel.org
X-Gm-Message-State: AOJu0YzPediqVZQIxMLsVinXV7+3AAdJWOkbay9aKfamcVQHf08Uh8/F
	R3qZB1j5swyAYmfqAF7z2LJjicpq4naxxlEQRAstivxNkp48hjwHreJHugVcGFk5bG1MwIzFyMf
	NCu2bgZcnYg/WLqfcL1ivQZpevpAsNRI=
X-Google-Smtp-Source: AGHT+IG9womiHzxB+4gWP5mHTWOTIXmlWv9sVHhfPOZyI23CITWW77TSYoGageOIO7C0NJtME6ymJJsBrBWXK2OR64o=
X-Received: by 2002:a17:907:3fa2:b0:b72:5fac:d05a with SMTP id
 a640c23a62f3a-b80371790a3mr3207480866b.37.1767018145819; Mon, 29 Dec 2025
 06:22:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-14-linkinjeon@kernel.org>
 <CAOQ4uxjBUFxXNiuU5wua4-HNAsUXM786fjpm2Qz5ejzREsMf7w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjBUFxXNiuU5wua4-HNAsUXM786fjpm2Qz5ejzREsMf7w@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 29 Dec 2025 23:22:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9SxJ_cPGsn8fh+CkfJrpETLHUgQpQF2Y5reN0WL+afTQ@mail.gmail.com>
X-Gm-Features: AQt7F2pHH3-vQY_1U7jxmMj7zuI5fEB3CGQycf5FqJnn_hjzC0oG3RSaYtLutbc
Message-ID: <CAKYAXd9SxJ_cPGsn8fh+CkfJrpETLHUgQpQF2Y5reN0WL+afTQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] ntfs: add Kconfig and Makefile
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 11:11=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Mon, Dec 29, 2025 at 1:02=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > This adds the Kconfig and Makefile
>
> Worth throwing in a word about the mutual exclusiveness of
> ntfs/ntfs3 as built in default driver.
Okay, I will update it on v4.
>
> >
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > ---
> >  fs/Kconfig       | 18 ++++++++++++++++++
> >  fs/Makefile      |  1 +
> >  fs/ntfs/Kconfig  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ntfs/Makefile | 18 ++++++++++++++++++
> >  4 files changed, 83 insertions(+)
> >  create mode 100644 fs/ntfs/Kconfig
> >  create mode 100644 fs/ntfs/Makefile
> >
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 0bfdaecaa877..c57cb6a53baf 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -152,8 +152,26 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
> >
> >  source "fs/fat/Kconfig"
> >  source "fs/exfat/Kconfig"
> > +source "fs/ntfs/Kconfig"
> >  source "fs/ntfs3/Kconfig"
> >
> > +choice
> > +       prompt "Select built-in NTFS filesystem (only one can be built-=
in)"
> > +       default DEFAULT_NTFS
> > +       help
> > +         Only one NTFS can be built into the kernel(y) when selecting =
a
> > +         specific default. Both can still be built as modules(m).
> > +
> > +       config DEFAULT_NTFS_NONE
> > +               bool "No built-in restriction (allows both drivers as '=
y')"
>
> as m?
Right.
>
> > +
> > +       config DEFAULT_NTFS
> > +               bool "NTFS"
> > +
> > +       config DEFAULT_NTFS3
> > +               bool "NTFS3"
> > +endchoice
> > +
> >  endmenu
> >  endif # BLOCK
> >
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
> > index 000000000000..ef14c68ed36c
> > --- /dev/null
> > +++ b/fs/ntfs/Kconfig
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config NTFS_FS
> > +       tristate "NTFS file system support"
> > +       depends on !DEFAULT_NTFS3 || m
>
>
> I am not seeing similar change to fs/ntfs3/Kconfig
Yes, I am missing it. I will add it on v4.

Thanks for your review!
>
> Thanks,
> Amir.
>
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
> > index 000000000000..01faad8cbbc9
> > --- /dev/null
> > +++ b/fs/ntfs/Makefile
> > @@ -0,0 +1,18 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for the ntfs filesystem support.
> > +#
> > +
> > +# to check robot warnings
> > +ccflags-y +=3D -Wint-to-pointer-cast \
> > +        $(call cc-option,-Wunused-but-set-variable,-Wunused-const-vari=
able) \
> > +        $(call cc-option,-Wold-style-declaration,-Wout-of-line-declara=
tion)
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
> > --
> > 2.25.1
> >

