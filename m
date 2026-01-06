Return-Path: <linux-fsdevel+bounces-72517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF88CF8F39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 16:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 231F130329CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B50F3346B8;
	Tue,  6 Jan 2026 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGHExYAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E383321B0
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711806; cv=none; b=NTYQ5Q220o4D0FI3b9agOZAlyCrB4EJ7qwbANARDkRe49bCoCZ9W5MDELwWYtipE8TCAp+kB4Z9mF/JRYAdhtM2mcietDQ4ZeMQO6zgqrVuuNQ7U2VLUncHVh/bsjr5WOP6AMyH54mbhzfJIldsDz0EnKDBhjVRkzLmK32uutlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711806; c=relaxed/simple;
	bh=In/Jg3aZaZe/PHkx5sYgnG5WFXWOIBid8VsALUhmOZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbEx+Lpkwyiu4zmiCptKKVCm8kWoxx5h8YOLne7MYv2C99AiRy7A92sE+F7elw5OAjf8PbshwZTMr4e6tN6KKFZA39loSY6Kw/NPN8vfKHGwnTVsERVdHTIRwSo34dZoLTGa5963N6fZH7cAeP+N79D/w761s4dSOl2ZxwOWp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGHExYAM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b79af62d36bso196013866b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 07:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711803; x=1768316603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQLhOeJbjmZJV/05C/0LnVGtNNWjGsxex2YgVKtSouY=;
        b=QGHExYAMExs98Cet7CC0iECLEaIC/5+clDeeVd17T22R6zQ9G+tMwJ4W0kXh+Y8XLe
         cDh+6dMzfia/m5fPv1QjlDnaHagiio0U5wPEYmvW/yDfUwtzMlGian821ZaztZkSJqF8
         xbVftawm5VjqR5A5ucSZkqaxmaUYxUZ8APTMxXYPsW8hj9aSusyDKpoR3RbpaqaIBaH6
         RiZKf3iAV3964MyS9d3kpdiPUk7OY2AHcvT8GPiQXV22RdRk+PSzlSHGFuIyQQowy4un
         upTXOWaM6OqSb7ri3UMK1M4Jq7qeQczPVQlIWZwSzFsPuw6G2Wxd6j4Xlde/VL/UsSUD
         OIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711803; x=1768316603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQLhOeJbjmZJV/05C/0LnVGtNNWjGsxex2YgVKtSouY=;
        b=nomjEvomHzNkGAoNkvCEzZ+lYEN/NG0GKO91Vbv7kY3eFrdSaeB/hN/pP/PjND84fK
         S9BxDt1WHJ1XxchAcLAdFY7QsfZyrmKOnS3dVgqUY64+hTYml0D2iRiQXyAA6MAO+K5o
         Fwi0SNEQkY/M9E7Mji6rIzJMgoEOBPCDRnzoogQKLKWLENJZoSIUJOAnolbteeuQnnll
         3d802w9p5CKnoXyFzsSKUjvoNvcz9p5J0RerI41nDwdYEg8Zo1RI99GkszV0WHpKz1l+
         YsGDYN0qogQ+AuRcN+D0yyXBu3h3g25tnAmmUSjOceuuVutlgsy1DwzET9BLzDLOBBBF
         /y4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxon55eAG0ZDNCvBhbl6pEcz1vhGP9kxItcNTb5TWxiyPzla5j2Zn6VWAbElHUAhr7EhHjxFzSR6duWb/L@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKsCC8LrdA3dnNPdfp657RebEg1GSlXLUauU/bNZvIWzxCC2d
	95AJU4tBoozJgHlrp9waqCvrM/7lCzgwdmwRVD5CbwX7Pu3pDodPQ5v0RJmLS1azJWgd/L6iKcb
	NcbeQMhaZgk57wB26CepzT2nhld7H4gs=
X-Gm-Gg: AY/fxX4Vw/vn4hwlpR81O4r7Q1+usqF9Y2KwuMbI9waCJ7pmK1uTRuYi0Yw9sKsH9oE
	dzCl1E53G+KrhMgtQy9+LLjxlGwJmKjCnNV7UK0Te9blcN6XGjrm7NraAkgcYzEo7a+mNzV1viq
	A3T69V8lJ46azgWKHc5gN7QQHPnBTN+xHlIdRPzo+v9oIVP2gnChmTH2nsieesgZXbFldIt6K8J
	VcW630NDGunaeurzPFouI6QoNkdsMsFcLx9oESCX9ISGaZjP2JazPBMVR7CGvg/xF1bNG5n7CNG
	iy+vzoYsZ/FLko7iLX88BerZroHL
X-Google-Smtp-Source: AGHT+IHveaolyYeEWd+uRLUeYnyOu6Z3ggO5PhlRiBgH+FDHRqjzmig2iSPy1bKfUaTS3eHfedwLNoXiiMUjm1mNb2c=
X-Received: by 2002:a17:907:9415:b0:b7f:c6c6:d27b with SMTP id
 a640c23a62f3a-b8426bf910amr302754466b.54.1767711802618; Tue, 06 Jan 2026
 07:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106131110.46687-1-linkinjeon@kernel.org> <20260106131110.46687-14-linkinjeon@kernel.org>
In-Reply-To: <20260106131110.46687-14-linkinjeon@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Jan 2026 16:03:09 +0100
X-Gm-Features: AQt7F2r4yCXf-laTiXwgkUonqQS-cYVQc_UYwPt2vhlg0U0Q3sryRnmxZf3IlF8
Message-ID: <CAOQ4uxj8kuuUE4xPXHTiFY8VM1fjkBBkBtDppSU62rFyezoC2Q@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] ntfs: add Kconfig and Makefile
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 2:26=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org> =
wrote:
>
> This introduce Kconfig and Makefile for remade ntfs.
> And this patch make ntfs and ntfs3 mutually exclusive so only one can be
> built-in(y), while both can still be built as modules(m).
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/Kconfig       |  1 +
>  fs/Makefile      |  1 +
>  fs/ntfs/Kconfig  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs/Makefile | 13 +++++++++++++
>  fs/ntfs3/Kconfig |  1 +
>  5 files changed, 61 insertions(+)
>  create mode 100644 fs/ntfs/Kconfig
>  create mode 100644 fs/ntfs/Makefile
>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 0bfdaecaa877..43cb06de297f 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -152,6 +152,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
>
>  source "fs/fat/Kconfig"
>  source "fs/exfat/Kconfig"
> +source "fs/ntfs/Kconfig"
>  source "fs/ntfs3/Kconfig"
>
>  endmenu
> diff --git a/fs/Makefile b/fs/Makefile
> index a04274a3c854..6893496697c4 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_NLS)             +=3D nls/
>  obj-y                          +=3D unicode/
>  obj-$(CONFIG_SMBFS)            +=3D smb/
>  obj-$(CONFIG_HPFS_FS)          +=3D hpfs/
> +obj-$(CONFIG_NTFS_FS)          +=3D ntfs/
>  obj-$(CONFIG_NTFS3_FS)         +=3D ntfs3/
>  obj-$(CONFIG_UFS_FS)           +=3D ufs/
>  obj-$(CONFIG_EFS_FS)           +=3D efs/
> diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
> new file mode 100644
> index 000000000000..6b49c99e4834
> --- /dev/null
> +++ b/fs/ntfs/Kconfig
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NTFS_FS
> +       tristate "NTFS file system support"
> +       select NLS
> +       help
> +         NTFS is the file system of Microsoft Windows NT, 2000, XP and 2=
003.
> +         This allows you to mount devices formatted with the ntfs file s=
ystem.
> +
> +         To compile this as a module, choose M here: the module will be =
called
> +         ntfs.
> +
> +config NTFS_DEBUG
> +       bool "NTFS debugging support"
> +       depends on NTFS_FS
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
> +config NTFS_FS_POSIX_ACL
> +       bool "NTFS POSIX Access Control Lists"
> +       depends on NTFS_FS
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
> diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
> new file mode 100644
> index 000000000000..d235ce03289e
> --- /dev/null
> +++ b/fs/ntfs/Makefile
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the ntfs filesystem support.
> +#
> +
> +obj-$(CONFIG_NTFS_FS) +=3D ntfs.o
> +
> +ntfs-y :=3D aops.o attrib.o collate.o dir.o file.o index.o inode.o \
> +         mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.o =
\
> +         upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
> +         iomap.o debug.o sysctl.o quota.o
> +
> +ccflags-$(CONFIG_NTFS_DEBUG) +=3D -DDEBUG
> diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> index cdfdf51e55d7..876dbc613ae6 100644
> --- a/fs/ntfs3/Kconfig
> +++ b/fs/ntfs3/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config NTFS3_FS
>         tristate "NTFS Read-Write file system support"
> +       depends on !NTFS_FS || m

Do you need this also in config NTFS_FS or is  this here enough?
Maybe add the explicit dependency also there for clarity?

Thanks,
Amir.

