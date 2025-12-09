Return-Path: <linux-fsdevel+bounces-71003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 610CECAED88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 05:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2057330184C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 04:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26A2C237F;
	Tue,  9 Dec 2025 04:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mxuFtw54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0211C84D7
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765253700; cv=none; b=fqJULoPUPuFhCgS3KrL/IqbXhMjBZq7ON9SgeZH6/zTllWFvqOQ6HAV5SChkVTz8YzgLyLsYU4h/IpAKyCuNUcXNRm9hqpNArBs5Cmtl7kdhenNHHS3Sw7u0c253xI3s8yzTAa1bGxikIN53CcS0vZzTUcmt820WlRi2P9LmoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765253700; c=relaxed/simple;
	bh=fxZrupnWzYXjC19sIxG0F03qERQwP8yqprJoPwhCsvM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DKrtESugWaC7OuAjzpmDW6xoc4Zo5qeb1goid1MSoMbhB7qiHfZDgT7nxyLoH4BSY41A2mKaTLpEwjuVQIJNi/Cqd6dUtzNLWMGcdUYyetkBDIatocBVuBAbVPWYiT4D09OxI3P2FAlgbOTTTRKSfIlbFyZ122KdPXjC0x8Offg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mxuFtw54; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78c5b5c1eccso6500077b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 20:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765253698; x=1765858498; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxOZQiVrIOkc6jsPHDGEQgDqVs4gmHDUYWM8/3JKHtc=;
        b=mxuFtw54Ze9wARIYSdNkhL2VICOwi45Bl3Kij+SeWD3M3VT0pgeTXdPnK+McC8AnZS
         iLySi2mVHnNvtIh/guZtRI+z2NzbCgutnZvFordysY8bcdOKZXkhQc5baZrAXcS8W6n4
         XogVp5olv1UjAty+ajijb9Y/z8+o60XOKN/v+8mtZgcSsrI5a/DbGGl92P+iK2+Csf5e
         6t5t8TzYpuoXXLzVe+FFlrm7MqdlUumRtvnXnSHefCvFCF16hmKkyU8SnXd3qPiC02E6
         M/8VMCni8TaFY4m96+ms1Jdqbs5sif/aHnoLRcIc92oMZ+WUX+6IwCzeAyeq5MgWmSAi
         vGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765253698; x=1765858498;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxOZQiVrIOkc6jsPHDGEQgDqVs4gmHDUYWM8/3JKHtc=;
        b=eWV6kmzaUUGuLkqrKPCv9Ow4kHvg0kpxsSlg3ZudD668NE7G0eCdlSuwJEB5oo17Dn
         ltDZbbNTdM/BgNjWaE5CFZnSSorBnyj9O5bqzM8hs2uJOElavoAp7XlvH+brG9I64VF/
         0AinCzKTRuSOWovt9JbROblWB1T5oKxg993R34aqqySouZf05eb1tWxA8rZ6eEGODxM5
         LcuOwZctWsDBgrg/DH9dQQ0yGPrV+T1ZTSbSeMziD9y+Lb61hrqHVSX/21M21rJYRxW0
         qpTGWvFR0oUdFLKrbQi2rQxSILJYl70DX5TeFqWGfO/GXEN6SDxDlupPgQROWQhZKHjT
         ZcKA==
X-Forwarded-Encrypted: i=1; AJvYcCVLND7uXDiw/gKnRgFTBBQ33m+PU6z/UPgTUjbYVrolU7BqKBmDxUTBm1wEvsSF/AB7BHL+UEgeSH9tKPHw@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZx5Nfn1YTFq43lxBNAZP3diXmAwdpYL3pVK6/TJ7OXaW5dv7
	HyozIIX1uwDYZPi5PZRDT4lWaAy94EzVovpHmovnUgaGEOo6af6GBGvzVosTPHFXrg==
X-Gm-Gg: AY/fxX65P//vFnVae095VPcYS4vtsD39w7bzY5QpN8/5Ge0GRvR+hL+6Xfaev3y2n1t
	T9JbhEifQWk05NPT9FUR03Phbz/fU/tTHe9D5Lclo11iy+h68GXUXCUPawKsgM66rgwcptMQeXj
	E/G+u4CN9frLHOwtvIy9jZdVU+Us68PjWX+f/jtnUcSndUCTBSEeU4ueBJAviC2/Sq3/SXmGq8W
	Mc0E1v/DjPd9ptgUPSe1kZdBREua6z215/6thJjCbOi2hjkNcUdceFVVG+jm23eBrq/81SBL3cF
	wLpTTeAaEZIJ6bXoJhhEzYkI6gFMyrw3MOe96lFqaArZ6TATQm09pu5Ou+T4Ua8r4N8sFU8nDxK
	dKZ3GXDUslA52AnIqNky+kb2RZUhmKi5B7dUN6gvncG90qHTjSkCSj65iYnbkeX9eupiBQFQmhT
	tJo7VWfZeoIz+dUkpJbbKP7gq78xXy6MTlN/NuK9CYvHr/dkq3pga8cbp22ZIAjsW1rKFfwFc=
X-Google-Smtp-Source: AGHT+IGStD3RTu8T+BCQkOHYtvAsKKgITO3CHa6arajrItSoFji6PAjkptYVeArSqR06eFO3YkONcA==
X-Received: by 2002:a05:690c:ec4:b0:78c:1213:58da with SMTP id 00721157ae682-78c60772f4fmr1081207b3.18.1765253697550;
        Mon, 08 Dec 2025 20:14:57 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4c9e43sm55152797b3.16.2025.12.08.20.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 20:14:56 -0800 (PST)
Date: Mon, 8 Dec 2025 20:14:44 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
cc: Hugh Dickins <hughd@google.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Matthew Wilcox <willy@infradead.org>, 
    Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tmpfs: enforce the immutable flag on open files
In-Reply-To: <toyfbuhwbqa4zfgnojghr4v7k2ra6uh3g3sikbuwata3iozi3m@tarta.nabijaczleweli.xyz>
Message-ID: <be986c18-3db2-38a1-8401-f0035ab71e7a@google.com>
References: <toyfbuhwbqa4zfgnojghr4v7k2ra6uh3g3sikbuwata3iozi3m@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-921943916-1765253696=:4936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-921943916-1765253696=:4936
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 8 Dec 2025, Ahelenia Ziemia=C5=84ska wrote:

> This useful behaviour is implemented for most filesystems,
> and wants to be implemented for every filesystem, quoth ref:
>   There is general agreement that we should standardize all file systems
>   to prevent modifications even for files that were opened at the time
>   the immutable flag is set.  Eventually, a change to enforce this at
>   the VFS layer should be landing in mainline.
>=20
> References: commit 02b016ca7f99 ("ext4: enforce the immutable flag on
>  open files")
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>

Sorry: thanks, but no thanks.

Supporting page_mkwrite() comes at a cost (an additional fault on first
write to a folio in a shared mmap).  It's important for space allocation
(and more) in the case of persistent writeback filesystems, but unwelcome
overhead in the case of tmpfs (and ramfs and hugetlbfs - others?).

tmpfs has always preferred not to support page_mkwrite(), and just fail
fstests generic/080: we shall not slow down to change that, without a
much stronger justification than "useful behaviour" which we've got
along well enough without.

But it is interesting that tmpfs supports IMMUTABLE, and passes all
the chattr fstests, without this patch.  Perhaps you should be adding
a new fstest, for tmpfs to fail: I won't thank you for that, but it
would be a fair response!

Hugh

> ---
> v1: https://lore.kernel.org/linux-fsdevel/znhu3eyffewvvhleewehuvod2wrf4tz=
6vxrouoakiarjtxt5uy@tarta.nabijaczleweli.xyz/t/#u
>=20
> shmem_page_mkwrite()'s return 0; falls straight into do_page_mkwrite()'s
> =09if (unlikely(!(ret & VM_FAULT_LOCKED))) {
> =09=09folio_lock(folio);
> Given the unlikely, is it better to folio_lock(folio); return VM_FAULT_LO=
CKED; instead?
>=20
> /ext4# uname -a
> Linux tarta 6.18.0-10912-g416f99c3b16f-dirty #1 SMP PREEMPT_DYNAMIC Sat D=
ec  6 12:14:41 CET 2025 x86_64 GNU/Linux
> /ext4# while sleep 1; do echo $$; done > file &
> [1] 262
> /ext4# chattr +i file
> /ext4# sh: line 25: echo: write error: Operation not permitted
> sh: line 25: echo: write error: Operation not permitted
> sh: line 25: echo: write error: Operation not permitted
> sh: line 25: echo: write error: Operation not permitted
> fg
> while sleep 1; do
>     echo $$;
> done > file
> ^C
> /ext4# mount -t tmpfs tmpfs /tmp
> /ext4# cd /tmp
> /tmp# while sleep 1; do echo $$; done > file &
> [1] 284
> /tmp# chattr +i file
> /tmp# sh: line 35: echo: write error: Operation not permitted
> sh: line 35: echo: write error: Operation not permitted
> sh: line 35: echo: write error: Operation not permitted
>=20
> $ cat test.c
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/ioctl.h>
> #include <linux/fs.h>
> #include <sys/mman.h>
> int main(int, char **argv) {
> =09int fd =3D open(argv[1], O_RDWR | O_CREAT | O_TRUNC, 0666);
> =09ftruncate(fd, 1024 * 1024);
> =09char *addr =3D mmap(NULL, 1024 * 1024, PROT_READ | PROT_WRITE, MAP_SHA=
RED, fd, 0);
> =09addr[0] =3D 0x69;
> =09int attrs =3D FS_IMMUTABLE_FL;
> =09ioctl(3, FS_IOC_SETFLAGS, &attrs);
> =09addr[1024 * 1024 - 1] =3D 0x69;
> }
>=20
> # strace ./test /tmp/file
> execve("./test", ["./test", "/tmp/file"], 0x7ffc720bead8 /* 22 vars */) =
=3D 0
> ...
> openat(AT_FDCWD, "/tmp/file", O_RDWR|O_CREAT|O_TRUNC, 0666) =3D 3
> ftruncate(3, 1048576)                   =3D 0
> mmap(NULL, 1048576, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =3D 0x7f09bbf=
2a000
> ioctl(3, FS_IOC_SETFLAGS, [FS_IMMUTABLE_FL]) =3D 0
> --- SIGBUS {si_signo=3DSIGBUS, si_code=3DBUS_ADRERR, si_addr=3D0x7f09bc02=
9fff} ---
> +++ killed by SIGBUS +++
> Bus error
> # tr -d \\0 < /tmp/file; echo
> i
>=20
>  mm/shmem.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d578d8e765d7..432935f79f35 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1294,6 +1294,14 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>  =09bool update_mtime =3D false;
>  =09bool update_ctime =3D true;
> =20
> +=09if (unlikely(IS_IMMUTABLE(inode)))
> +=09=09return -EPERM;
> +
> +=09if (unlikely(IS_APPEND(inode) &&
> +=09=09     (attr->ia_valid & (ATTR_MODE | ATTR_UID |
> +=09=09=09=09=09ATTR_GID | ATTR_TIMES_SET))))
> +=09=09return -EPERM;
> +
>  =09error =3D setattr_prepare(idmap, dentry, attr);
>  =09if (error)
>  =09=09return error;
> @@ -2763,6 +2771,17 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf=
)
>  =09return ret;
>  }
> =20
> +static vm_fault_t shmem_page_mkwrite(struct vm_fault *vmf)
> +{
> +=09struct file *file =3D vmf->vma->vm_file;
> +
> +=09if (unlikely(IS_IMMUTABLE(file_inode(file))))
> +=09=09return VM_FAULT_SIGBUS;
> +
> +=09file_update_time(file);
> +=09return 0;
> +}
> +
>  unsigned long shmem_get_unmapped_area(struct file *file,
>  =09=09=09=09      unsigned long uaddr, unsigned long len,
>  =09=09=09=09      unsigned long pgoff, unsigned long flags)
> @@ -3475,6 +3494,10 @@ static ssize_t shmem_file_write_iter(struct kiocb =
*iocb, struct iov_iter *from)
>  =09ret =3D generic_write_checks(iocb, from);
>  =09if (ret <=3D 0)
>  =09=09goto unlock;
> +=09if (unlikely(IS_IMMUTABLE(inode))) {
> +=09=09ret =3D -EPERM;
> +=09=09goto unlock;
> +=09}
>  =09ret =3D file_remove_privs(file);
>  =09if (ret)
>  =09=09goto unlock;
> @@ -5286,6 +5309,7 @@ static const struct super_operations shmem_ops =3D =
{
>  static const struct vm_operations_struct shmem_vm_ops =3D {
>  =09.fault=09=09=3D shmem_fault,
>  =09.map_pages=09=3D filemap_map_pages,
> +=09.page_mkwrite=09=3D shmem_page_mkwrite,
>  #ifdef CONFIG_NUMA
>  =09.set_policy     =3D shmem_set_policy,
>  =09.get_policy     =3D shmem_get_policy,
> @@ -5295,6 +5319,7 @@ static const struct vm_operations_struct shmem_vm_o=
ps =3D {
>  static const struct vm_operations_struct shmem_anon_vm_ops =3D {
>  =09.fault=09=09=3D shmem_fault,
>  =09.map_pages=09=3D filemap_map_pages,
> +=09.page_mkwrite=09=3D shmem_page_mkwrite,
>  #ifdef CONFIG_NUMA
>  =09.set_policy     =3D shmem_set_policy,
>  =09.get_policy     =3D shmem_get_policy,
> --=20
> 2.39.5
---1463770367-921943916-1765253696=:4936--

