Return-Path: <linux-fsdevel+bounces-72186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6877FCE6FA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0886E300F89B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCCC31A553;
	Mon, 29 Dec 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd3y+wFS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB424A076
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767017486; cv=none; b=qSoH1nzOHzpC5zw7yXJThkPskGgvCguY9L2foTHN7fOd9WZvNv59/m+d0IAIdoSL6k+zYd09uEsvbccRL4meKWeEz9APB7v0PDLhm6fFR/QhyEzSKx/6nAC+c40LY26RzCQ0h8p85yRyoHiQEc7GXUNijxz7BM6X+FVsMULwQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767017486; c=relaxed/simple;
	bh=t3UB8XF2FylXh/jmvAJm63up/05lgNzVOm9PhTc0BPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Za20K6j/ulZrvmv295x9z0VlXK4BPppNsbepI0GOdLWT9do5P2SSKjVPbGT/MjbQhBS/leZoR6yYI/Y/KJZ5W8FwV2rxDjSCLlOU5gvPYwCrqwnAiOG7v1zCRWxWEVTs6TPm9XHINv7LJBQLiyzGPORiUFMuDlFNQZ9zPEMqJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd3y+wFS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so13347591a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 06:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767017482; x=1767622282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPp80qtb/Sj3L0gwL5OXuS5QtKwHeh2dmzhLMbOdhEk=;
        b=bd3y+wFSZoaEkfwDDMfu6cN20bfx0vdOoEd3xgAWC2g85XSHGmS5YaOz7fpvibicEm
         7Z4N4hBXJoQgEW6NpEL8/bpPskQ+XW4RxKBKjjmT0W6KxXs2bT7PCCjpXsnYT6vVKHik
         xYTx9sDP6klAfckWdNctzCuPwJ4wiyAqz3I3tCvThxApOyJ0nA4+1badfkg3drjAGopI
         2rdYOizpLEQ3o9ZLE11m1d0GLhKII1/77gQbEpPzMNpAu8bmVkoMLgFCofNC5PqR9ZGi
         tsIny7KAMQNqBZjB7nJH3p+xKy5Hc+CncUDhTaK5pkIK8kh5ZmVvd32c/F3EPlT2Nw2a
         eg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767017482; x=1767622282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XPp80qtb/Sj3L0gwL5OXuS5QtKwHeh2dmzhLMbOdhEk=;
        b=SBcXKvJWb+URRoxLbUz1ytPfLpMGFLqhLE3lMdQPjVKZ8XLM5zIpZDvjkc0Pmi0fM6
         ajuaT90ZMWLfylAOPlpw15V2BpCvDV+8hI5RJeC+CmwD2338uu7AjU6FxIPLjrF35QCd
         GM0L3Oy0WQDHACW1X3ljt12J6o97bkcBluiRZqrRiB/jYHxvjGGqth4USmC5xa0nby5r
         ZxZhBOaKHFdOk1mhjuEUTlFlO+f731Z5xezVu6wYGA2KuGtMOwTo/xtH1VwLHLeQ3o4S
         qHYgFh5yvZnhqiNa1U7+63aOk/YGsuueo8GMjLzHCA5rQFshSiMEFWv1mNKJAoMLP1wc
         Zkrg==
X-Forwarded-Encrypted: i=1; AJvYcCWy5V6hTbxVEDx7VnLCdgJlfRddLmkAFwhvXqjzQal1pieD+b1edgrJeEpCzVnd3mlWNebz6nEunpKnGbzV@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDn3Ce35YXIuctIY+2IlzYhsFdWJtPVJaE1hdYFll5Eq79EcZ
	7cUB9nluQgcmRCbJri8OjfnJWtKyoSeUZIAVqPjbOnAJ/aSumTEFXjFG1S1Ta2e4tlfn59u8Svs
	rd2DGVrDsPN7HOVWaJyQlAOjxfO71uAU=
X-Gm-Gg: AY/fxX7VU8zoivPEzslbFNgQJB0XmpgEfGf4AmCKdDyz7EFwzliQcR48hOcQCeHIbRt
	L1iTwP+3bzhyA5H9VXp13+2HCBs4POwuEALV/i61SNIfDob4XBVCx6FCcD7LNkZBcqM3ukChaR7
	W1H/QPJxyxm01xFfGj95CIMuBQ5bBt4L4k1SlCkaXtHruoBJWNRbz7YB6yzgIp+VZ9RHSn8fJt5
	cJQzJsLRylUiQlUdDw15RPydy6dcGaEJiTSKuryC9tcMm//yBa4I/09IOMfXYB4S8MLpfBEFv9P
	91c7jJn4kY3DikC0CckXSDpSTF0m2Q==
X-Google-Smtp-Source: AGHT+IFu4+cqcBJUzatJXi2TaoexBh5W4JHYzbsBvOUflI/cogko+0YuFWkCO80T2WN5TVGhJJnRw3K9Y5qluyhqEr0=
X-Received: by 2002:a05:6402:13d5:b0:64d:498b:aeff with SMTP id
 4fb4d7f45d1cf-64d498bb493mr23958984a12.34.1767017482327; Mon, 29 Dec 2025
 06:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-14-linkinjeon@kernel.org>
In-Reply-To: <20251229105932.11360-14-linkinjeon@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Dec 2025 15:11:11 +0100
X-Gm-Features: AQt7F2qMKry2dmU-D7StY-dGj9BqQx01m43PGxiDrWZyFdnLtCE8pHH_MMs32KM
Message-ID: <CAOQ4uxjBUFxXNiuU5wua4-HNAsUXM786fjpm2Qz5ejzREsMf7w@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] ntfs: add Kconfig and Makefile
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 1:02=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> This adds the Kconfig and Makefile

Worth throwing in a word about the mutual exclusiveness of
ntfs/ntfs3 as built in default driver.

>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/Kconfig       | 18 ++++++++++++++++++
>  fs/Makefile      |  1 +
>  fs/ntfs/Kconfig  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs/Makefile | 18 ++++++++++++++++++
>  4 files changed, 83 insertions(+)
>  create mode 100644 fs/ntfs/Kconfig
>  create mode 100644 fs/ntfs/Makefile
>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 0bfdaecaa877..c57cb6a53baf 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -152,8 +152,26 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
>
>  source "fs/fat/Kconfig"
>  source "fs/exfat/Kconfig"
> +source "fs/ntfs/Kconfig"
>  source "fs/ntfs3/Kconfig"
>
> +choice
> +       prompt "Select built-in NTFS filesystem (only one can be built-in=
)"
> +       default DEFAULT_NTFS
> +       help
> +         Only one NTFS can be built into the kernel(y) when selecting a
> +         specific default. Both can still be built as modules(m).
> +
> +       config DEFAULT_NTFS_NONE
> +               bool "No built-in restriction (allows both drivers as 'y'=
)"

as m?

> +
> +       config DEFAULT_NTFS
> +               bool "NTFS"
> +
> +       config DEFAULT_NTFS3
> +               bool "NTFS3"
> +endchoice
> +
>  endmenu
>  endif # BLOCK
>
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
> index 000000000000..ef14c68ed36c
> --- /dev/null
> +++ b/fs/ntfs/Kconfig
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NTFS_FS
> +       tristate "NTFS file system support"
> +       depends on !DEFAULT_NTFS3 || m


I am not seeing similar change to fs/ntfs3/Kconfig

Thanks,
Amir.

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
> index 000000000000..01faad8cbbc9
> --- /dev/null
> +++ b/fs/ntfs/Makefile
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the ntfs filesystem support.
> +#
> +
> +# to check robot warnings
> +ccflags-y +=3D -Wint-to-pointer-cast \
> +        $(call cc-option,-Wunused-but-set-variable,-Wunused-const-variab=
le) \
> +        $(call cc-option,-Wold-style-declaration,-Wout-of-line-declarati=
on)
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
> --
> 2.25.1
>

