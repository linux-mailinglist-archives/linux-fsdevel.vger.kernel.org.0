Return-Path: <linux-fsdevel+bounces-69992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC53C8D8CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 132D34E3BBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F0632143F;
	Thu, 27 Nov 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUohI1yH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24129239594
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235862; cv=none; b=AnQzr0dMifhvpvydYqOWvkf/mFQnFetUUUiZU0prsP9mUi6frhBBdzZeY+Yr5yLc0GymAwB+yfs3g4kPvq52afwQLyPXQA9eXO5MuOAErr75+EmOfOms+dYoZ6bDf2ktDuZmY8vKaA3/Z4VfUbPAWeqHE1ewdVxlwCrttkJMgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235862; c=relaxed/simple;
	bh=se2t5WE4HxSzB+Vwu5fDyf+dcCPsjcWcC0ist+n3bHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPND8HaWPJWz2B6xNl1pLShcrM6pdJpK+ihOrV5F5SCT4PQ4jkHMbJ2HYV60RCLEEpAyNYWLHf2jJy3k8mJNCVTbw8vtuvhGy1mmMUJmulomc8njbLJgPHKmMyh9mvs2kJqM05eRK1pyOwayTdKLqx10zx2H5oRpbVF4mno20xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUohI1yH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so1042584a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764235859; x=1764840659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzoh4U6IwXyrEd8vK/emhNCUHEuy42DKGAVt0QykwJQ=;
        b=NUohI1yHgytzfm5JeSwIhjlQdjSpeEBe0GsSzXZwhf86ltA1GfsH3JkKrco4KuPaSP
         qmr0rCV18dqAPPLE7C58M4Umf8IyMzPIiflP5XlwCQ6S3516wKXclIbYg1lSwtcghs1y
         0Nh14Gmtt2LPwcrZGrSvDp391KLLSsqvGsGhPbbkvIyibAqasB0rEeFfiKyykgwwsNuW
         jU78BXbslglPYEdIQwcKkYfljjHGRV6IYEwaHE95DWlVINNSchRTyTqlBW2WKOp+UoLC
         Fx9r3xNx3O8nLnXmao4FlchDbXbSYJ24LMMyNAs6D5GXcGLh3856tDeOAc+ojx4A/ogl
         zR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235859; x=1764840659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzoh4U6IwXyrEd8vK/emhNCUHEuy42DKGAVt0QykwJQ=;
        b=f6tJXtimtKKGqmKfXy4Fw7FP54nmqr2Co937GDA1XciGlzcN0fu9hRPvZKgbdgdYD6
         bmx+d1MfYpQQ9zRq5MVqaOlQsvdiNlizQczZCMFyQnikc/LNmMO05z5nCX7ovpqAP5d5
         4BKTKoapCqxXkDsEbHgTbxl/g075O8JRQ7pNIKqJ1dD7nS5S1XPJEpUD/OLI2R9gmHxf
         wRWCbLz/J7hI58nG5Ir28Qfg1winT+jMgczykXjPntI5ni7jO9rlsiPrjyDvW1e/a69v
         lg4Zec2we72wCcNP5DWLruZZphAq4wn0rQ0FsDrRk3IiknZ7Dx2yI0HoAfRUdX00/0iq
         ivng==
X-Forwarded-Encrypted: i=1; AJvYcCWq7ahBfLayBfPzAKzukhrEHNEH0svkIEnkPhI1SWFr/RYCckL3ZMBgJUDhTL4F4SdthUP5op9HjrqKwDfb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8j1fB4GYTz8GQR4HpDv0ws3Kxfzvvve1MfIQGtOo0IH01TiOD
	bDX0fCb0lVWQQSs+GvcWygt3coVT6Er9TAe24CjXXezBHj3oKUlM88ouUC3kZ63yOcsNi/MeG/I
	Uqj02WdQKFuRBsymM/62KoUDXK2gLFSw=
X-Gm-Gg: ASbGncu3VBw/fE2j7I1jjMCQgvuBmwW4cQ5jyQxTlbgNg7eevi31cRkaztBy+6Sp8uA
	t1ipQrF5xCPdrdFwvY+AdXsopwmFVvcQUJiNAQMEXZ1Gn0gfVvXxUMcumV8dcSbQ8a0WxooZ7mR
	n+mHAYVzQiTJnUP6IJPFKsQMtrs0ffuJ92ubWuk5NVg753ERX+HvS89/L9fSV9B8up9gXNtt26y
	Wxyd0c3ZG39zC5fwJbh7QWjnxiRGQQEc7FYFwNE2h+bJMlHpsbxy5P6/MWC+mmnDGYMxPU1IaJN
	klS7gwyQQcqZkuHcjL2YM7Q7rJk=
X-Google-Smtp-Source: AGHT+IETyNvIaSTacrs4m29QguWKX/bKN7qemKg74obYvxsaeh2zm4L8N8Ok006VoYEiBhB7lRhsJPhKhnKq5JfgipY=
X-Received: by 2002:a05:6402:270b:b0:640:c849:cee3 with SMTP id
 4fb4d7f45d1cf-645546a3cb9mr18840098a12.34.1764235859124; Thu, 27 Nov 2025
 01:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-12-linkinjeon@kernel.org>
In-Reply-To: <20251127045944.26009-12-linkinjeon@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Nov 2025 10:30:47 +0100
X-Gm-Features: AWmQ_blWlxDbzowMdVQ2tB-vishE7QVVWBKy3xTqo3oIFA_fr2SBkhIoF1X3nu4
Message-ID: <CAOQ4uxh7pxxOPkWxqOx_X8VE=vbT-P4aNhAQ+3BawZCWUZZuXA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ntfsplus: add Kconfig and Makefile
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:01=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> This adds the Kconfig and Makefile for ntfsplus.

MAINTAINERS?

>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/Kconfig           |  1 +
>  fs/Makefile          |  1 +
>  fs/ntfsplus/Kconfig  | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfsplus/Makefile | 18 ++++++++++++++++++
>  4 files changed, 65 insertions(+)
>  create mode 100644 fs/ntfsplus/Kconfig
>  create mode 100644 fs/ntfsplus/Makefile
>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 0bfdaecaa877..70d596b99c8b 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -153,6 +153,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
>  source "fs/fat/Kconfig"
>  source "fs/exfat/Kconfig"
>  source "fs/ntfs3/Kconfig"
> +source "fs/ntfsplus/Kconfig"
>
>  endmenu
>  endif # BLOCK
> diff --git a/fs/Makefile b/fs/Makefile
> index e3523ab2e587..2e2473451508 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -91,6 +91,7 @@ obj-y                         +=3D unicode/
>  obj-$(CONFIG_SMBFS)            +=3D smb/
>  obj-$(CONFIG_HPFS_FS)          +=3D hpfs/
>  obj-$(CONFIG_NTFS3_FS)         +=3D ntfs3/
> +obj-$(CONFIG_NTFSPLUS_FS)      +=3D ntfsplus/
>  obj-$(CONFIG_UFS_FS)           +=3D ufs/
>  obj-$(CONFIG_EFS_FS)           +=3D efs/
>  obj-$(CONFIG_JFFS2_FS)         +=3D jffs2/
> diff --git a/fs/ntfsplus/Kconfig b/fs/ntfsplus/Kconfig
> new file mode 100644
> index 000000000000..c13cd06720e7
> --- /dev/null
> +++ b/fs/ntfsplus/Kconfig
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NTFSPLUS_FS
> +       tristate "NTFS+ file system support"
> +       select NLS
> +       help
> +         NTFS is the file system of Microsoft Windows NT, 2000, XP and 2=
003.
> +         This allows you to mount devices formatted with the ntfs file s=
ystem.
> +
> +         To compile this as a module, choose M here: the module will be =
called
> +         ntfsplus.
> +
> +config NTFSPLUS_DEBUG
> +       bool "NTFS+ debugging support"
> +       depends on NTFSPLUS_FS
> +       help
> +         If you are experiencing any problems with the NTFS file system,=
 say
> +         Y here.  This will result in additional consistency checks to b=
e
> +         performed by the driver as well as additional debugging message=
s to
> +         be written to the system log.  Note that debugging messages are
> +         disabled by default.  To enable them, supply the option debug_m=
sgs=3D1
> +         at the kernel command line when booting the kernel or as an opt=
ion
> +         to insmod when loading the ntfs module.  Once the driver is act=
ive,
> +         you can enable debugging messages by doing (as root):
> +         echo 1 > /proc/sys/fs/ntfs-debug
> +         Replacing the "1" with "0" would disable debug messages.
> +
> +         If you leave debugging messages disabled, this results in littl=
e
> +         overhead, but enabling debug messages results in very significa=
nt
> +         slowdown of the system.
> +
> +         When reporting bugs, please try to have available a full dump o=
f
> +         debugging messages while the misbehaviour was occurring.
> +
> +config NTFSPLUS_FS_POSIX_ACL
> +       bool "NTFS+ POSIX Access Control Lists"
> +       depends on NTFSPLUS_FS
> +       select FS_POSIX_ACL
> +       help
> +         POSIX Access Control Lists (ACLs) support additional access rig=
hts
> +         for users and groups beyond the standard owner/group/world sche=
me,
> +         and this option selects support for ACLs specifically for ntfs
> +         filesystems.
> +         NOTE: this is linux only feature. Windows will ignore these ACL=
s.
> +
> +         If you don't know what Access Control Lists are, say N.
> diff --git a/fs/ntfsplus/Makefile b/fs/ntfsplus/Makefile
> new file mode 100644
> index 000000000000..1e7e830dbeec
> --- /dev/null
> +++ b/fs/ntfsplus/Makefile
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the ntfsplus filesystem support.
> +#
> +
> +# to check robot warnings
> +ccflags-y +=3D -Wint-to-pointer-cast \
> +        $(call cc-option,-Wunused-but-set-variable,-Wunused-const-variab=
le) \
> +        $(call cc-option,-Wold-style-declaration,-Wout-of-line-declarati=
on)
> +
> +obj-$(CONFIG_NTFSPLUS_FS) +=3D ntfsplus.o
> +
> +ntfsplus-y :=3D aops.o attrib.o collate.o misc.o dir.o file.o index.o in=
ode.o \
> +         mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.o =
\
> +         upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
> +         ntfs_iomap.o
> +
> +ccflags-$(CONFIG_NTFSPLUS_DEBUG) +=3D -DDEBUG
> --
> 2.25.1
>

