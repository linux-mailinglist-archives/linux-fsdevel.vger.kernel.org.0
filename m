Return-Path: <linux-fsdevel+bounces-70010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B25FCC8E3AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32FA234CB9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D37F32FA11;
	Thu, 27 Nov 2025 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTpDH/px"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461F32E723
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245932; cv=none; b=P71z6TEgfkS2rEo9PbPd90qV+r91U3xAxBF1D8i+WwPeHO3KpURAbkcOby2OEm09XO+jYmDiZ/EsyumZjSzGH2j8impEU9tQkZvUDcLX4wftIOak6ndai97456d9TkySvPFZ+q37bdjMbuZJTb1fP5dJyyFElROSw9YEXHNBYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245932; c=relaxed/simple;
	bh=tcD5hKKg+pbIxi7t9sypGRA2rpkqV3Ps5vyhOIbwdqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M33bG8iL6Et7yhhv5QbO5JIYggIaDcK3n7SUUtuc6bCsGL/Z3ZGGsxr6JTdwUxJJyhUKjIraGGS8YQagUbQhHU4eT1KgeCY2UazsXGwzJm6R3nhxOjXLir8hp6qrCbwijJlEbfEKa+VqS3aYcwFphyWTUhd4cbWIx1tsfO0rTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTpDH/px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F90C4AF10
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764245931;
	bh=tcD5hKKg+pbIxi7t9sypGRA2rpkqV3Ps5vyhOIbwdqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YTpDH/px6H8KIBM5n960cOIleN0A2T5bchf6LaOuCvOhNHZkP7XNAswM+YBkJpkQH
	 i9C7xylTorDkF7CkPcq30MmdzkriTNA7rRT/3+hKcOByo0FxP90Y3CxQS+Aek6kA+E
	 WUCqHH8d6FOCw9V42fAkim1cbTmMz+fY1ZRSyB63WuTr1cTIIyoglTHr1EAOHVBuYu
	 ReSjaaCmZGyZ1jDLIQV4V7QCFUJPrzaCOxFYOw9+VTZfBGpCToe0PY3bKPPUi22nv5
	 WH+Mny/6OMrNRdC49SCYWtRW3j4MjG9ZbdRMVGBh6MOTimdlFcpimmIKQYDZsawy/S
	 xku+6LTAQ504w==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so1342242a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 04:18:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUevCiZMwJWI+1M0fSLTwnVSDKCo6Gainn7pfrclkO0deOljxZNURwDljr+BbW1OYUM958EtMsSVHTaf0hb@vger.kernel.org
X-Gm-Message-State: AOJu0YzWskC/OKYVzFVKTojI55AvdeGiEfG5t9dTj4Wl0AHe7Mz90c1L
	4+3zfGoPsEbSW4KyJrkIwnHzkThaKe6TRSfxtHf1vyLAbZSv3AYcNDIPYe62UkkuauLLhVXAYmk
	q0mKvngaVOmdnkSsgB/JmxWgQ7VICJhk=
X-Google-Smtp-Source: AGHT+IGUEguVdYUPhTP5ONkQciE63Y8n3Sb23go17zaLa2tXaz5v/2EnYP6vp2cGD1AWQLEGEf429RkSha8+dFaEYnc=
X-Received: by 2002:a05:6402:2792:b0:641:966d:82ba with SMTP id
 4fb4d7f45d1cf-645eb23fe43mr7626923a12.1.1764245930083; Thu, 27 Nov 2025
 04:18:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-12-linkinjeon@kernel.org>
 <CAOQ4uxh7pxxOPkWxqOx_X8VE=vbT-P4aNhAQ+3BawZCWUZZuXA@mail.gmail.com>
In-Reply-To: <CAOQ4uxh7pxxOPkWxqOx_X8VE=vbT-P4aNhAQ+3BawZCWUZZuXA@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 27 Nov 2025 21:18:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_SGcWj74VpeqVzCVpBn2OxZv9tdW6XHudHOwGY_v_GBQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnO7JamW6BiT-GRWv9a6_5V4WHemNtmIOJJJg5oO4FDM0hpndAs1ivALc0
Message-ID: <CAKYAXd_SGcWj74VpeqVzCVpBn2OxZv9tdW6XHudHOwGY_v_GBQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ntfsplus: add Kconfig and Makefile
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:31=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Nov 27, 2025 at 6:01=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > This adds the Kconfig and Makefile for ntfsplus.
>
> MAINTAINERS?
Okay, I will add it on next version:)
Thanks!
>
> >
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > ---
> >  fs/Kconfig           |  1 +
> >  fs/Makefile          |  1 +
> >  fs/ntfsplus/Kconfig  | 45 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ntfsplus/Makefile | 18 ++++++++++++++++++
> >  4 files changed, 65 insertions(+)
> >  create mode 100644 fs/ntfsplus/Kconfig
> >  create mode 100644 fs/ntfsplus/Makefile
> >
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 0bfdaecaa877..70d596b99c8b 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -153,6 +153,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
> >  source "fs/fat/Kconfig"
> >  source "fs/exfat/Kconfig"
> >  source "fs/ntfs3/Kconfig"
> > +source "fs/ntfsplus/Kconfig"
> >
> >  endmenu
> >  endif # BLOCK
> > diff --git a/fs/Makefile b/fs/Makefile
> > index e3523ab2e587..2e2473451508 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -91,6 +91,7 @@ obj-y                         +=3D unicode/
> >  obj-$(CONFIG_SMBFS)            +=3D smb/
> >  obj-$(CONFIG_HPFS_FS)          +=3D hpfs/
> >  obj-$(CONFIG_NTFS3_FS)         +=3D ntfs3/
> > +obj-$(CONFIG_NTFSPLUS_FS)      +=3D ntfsplus/
> >  obj-$(CONFIG_UFS_FS)           +=3D ufs/
> >  obj-$(CONFIG_EFS_FS)           +=3D efs/
> >  obj-$(CONFIG_JFFS2_FS)         +=3D jffs2/
> > diff --git a/fs/ntfsplus/Kconfig b/fs/ntfsplus/Kconfig
> > new file mode 100644
> > index 000000000000..c13cd06720e7
> > --- /dev/null
> > +++ b/fs/ntfsplus/Kconfig
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config NTFSPLUS_FS
> > +       tristate "NTFS+ file system support"
> > +       select NLS
> > +       help
> > +         NTFS is the file system of Microsoft Windows NT, 2000, XP and=
 2003.
> > +         This allows you to mount devices formatted with the ntfs file=
 system.
> > +
> > +         To compile this as a module, choose M here: the module will b=
e called
> > +         ntfsplus.
> > +
> > +config NTFSPLUS_DEBUG
> > +       bool "NTFS+ debugging support"
> > +       depends on NTFSPLUS_FS
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
> > +config NTFSPLUS_FS_POSIX_ACL
> > +       bool "NTFS+ POSIX Access Control Lists"
> > +       depends on NTFSPLUS_FS
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
> > diff --git a/fs/ntfsplus/Makefile b/fs/ntfsplus/Makefile
> > new file mode 100644
> > index 000000000000..1e7e830dbeec
> > --- /dev/null
> > +++ b/fs/ntfsplus/Makefile
> > @@ -0,0 +1,18 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for the ntfsplus filesystem support.
> > +#
> > +
> > +# to check robot warnings
> > +ccflags-y +=3D -Wint-to-pointer-cast \
> > +        $(call cc-option,-Wunused-but-set-variable,-Wunused-const-vari=
able) \
> > +        $(call cc-option,-Wold-style-declaration,-Wout-of-line-declara=
tion)
> > +
> > +obj-$(CONFIG_NTFSPLUS_FS) +=3D ntfsplus.o
> > +
> > +ntfsplus-y :=3D aops.o attrib.o collate.o misc.o dir.o file.o index.o =
inode.o \
> > +         mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.=
o \
> > +         upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
> > +         ntfs_iomap.o
> > +
> > +ccflags-$(CONFIG_NTFSPLUS_DEBUG) +=3D -DDEBUG
> > --
> > 2.25.1
> >

