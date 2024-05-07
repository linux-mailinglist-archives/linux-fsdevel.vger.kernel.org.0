Return-Path: <linux-fsdevel+bounces-18941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2028BEBFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213961F21C35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512C916D9CB;
	Tue,  7 May 2024 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+npPo0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE726CDC2;
	Tue,  7 May 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107964; cv=none; b=nPfNTJsXb/71NjE49G7QyCDbT7eRKwl+KieXX0Hrou6bUR0//x9sxY7v4bQqa+E6wJswjXd5iG3I9J/VUamZfn77GZ9Z/LpRoCtZHOcjez3F9sviTxoheBnvglEb4OWExsJTvJTFxUmaF5Q8NWguNbJOv15xci/n8HVjGgTCfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107964; c=relaxed/simple;
	bh=r0n+lAaUIJYL/6lmnO1EiLwZUHwaOjLhtCSzCjyhdAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hj+hNpRAIpu0NzH34Y3ZQL7UOFm1cjl9fOAFlmktnAm9PEmeacTcAz26kVpmz6pdEJnVhjGjEHzmEErEl9uHjpRcbyw3xpIMdvSCFyjpCWBfEFEFNCaBHlU0wfcc+TttMweiw5kyc8U3BRcIcB5bD/1panu0Qv+RbQF/OF3TTlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+npPo0A; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b387e2e355so2367305a91.3;
        Tue, 07 May 2024 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715107962; x=1715712762; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwLLEGYjxX+LEtBwUpGGf8LdmjjTex/ws/dicJ6KmUU=;
        b=j+npPo0AYi06aE6dz7DfMJFuJ3qMBsg/5+8Uf8eRhN9PiVV5MpzGLB1TeIF7Wy45AZ
         NRzs2n3+pg++EkvTQ2eGvdrVUjwIUMp4qb6Jt5kaEQybExAsKQ1jLcf8wJEqEdhIFgD3
         26bOEsxACoBVw02TLXNBiDhVATzXhr8F9hWpr38yKrN8gtO+LKyiZ4kXA2urUfksSVA5
         xVpaznEF2XVRpfqlSQhnr/iSozK/ODsbVMEex1HK0UMbKPeeO9F+NvUBam87uI38emex
         F5n6DbHlLwu2fp53GTVAkODXF4ff00rY2qrMa5HvRqcXpEglYMlXkV9tAZP0fPBPDLOZ
         kvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715107962; x=1715712762;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwLLEGYjxX+LEtBwUpGGf8LdmjjTex/ws/dicJ6KmUU=;
        b=j3+ZqEjVK39nEFtbokQCnNOOB2ZWFN/eVTelKvWxQUxcoFxXYa3BtxweIKoSQS04/K
         Nxt2mR8s+XDqMOQb/RJkp24x7jfi1BC028NnCxx+b7MoHn2SrSiYKk16J0Nt+mr0hMba
         bkxz4qa94S3cRXZKFqHa9DhC0T+LX/Dzj0LOtJhv40KjSZgKvcCZNcSiMVeqpZvi5JtD
         ZD59ouHIl7XKjrZxNfpTztC1wvpcyYJjaopIchnv83yFCTUUf2LhO3PcT1/TpI9cPERV
         iE9FZDRdwNxMdiGqCZ85BEFqFhokr/bXpKhVeiKpOjCFmv3qrDtZzQcSvDeWe54WJZ97
         No9g==
X-Forwarded-Encrypted: i=1; AJvYcCWR/+oEDBKVXhNCYPlX9EfIuuccsdXmuAM2lmn+j/DM+SL/l485jefU1EcHuUytfpI56xnb7Ib8bQY3EhIOJXLG1I08qCQUQ53SVDB1aGJCtVS7IYNsAMWReIYagRBfyExYY6yjxjap+w1xb3jvJXOsloa1KlzkNlWMyzSGxtC2aw==
X-Gm-Message-State: AOJu0YxyEMNNZCvbs3SswoG+CAP+idgtAfcNkscM0JWPoW07A4RU8zZq
	UvHes0430/SnLQhd8C7K2muTWbGsgottZI5/TiZ0TPUSfJv8yIaEGIuPaKxtQsoLUGhyqzPAkzD
	58nXFSUZoBvwBKZfSg2BkPiCPj4OT3bHD
X-Google-Smtp-Source: AGHT+IEP2PRAErTlJKaX5mCGUjXUHTm1j2QYD4mJIWSnjVBKhEf4IrxDiaZsBvKjXK1rTpYf+lSwrEtYTWi4YA61IoU=
X-Received: by 2002:a17:90a:fa02:b0:2b2:6339:b1a3 with SMTP id
 98e67ed59e1d1-2b616aedaf7mr472183a91.37.1715107962298; Tue, 07 May 2024
 11:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-3-andrii@kernel.org>
 <gn5i3p6w7ih3pabh6r3vryyauotiajpfnd4ftdn4akt7f242pa@thxj3gzzofnl>
In-Reply-To: <gn5i3p6w7ih3pabh6r3vryyauotiajpfnd4ftdn4akt7f242pa@thxj3gzzofnl>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 11:52:30 -0700
Message-ID: <CAEf4BzY2c8X--Yufh3jApU3uUK3Qb4BJRNqWpCO8NOGJ6fVryg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:10=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Andrii Nakryiko <andrii@kernel.org> [240503 20:30]:
> > /proc/<pid>/maps file is extremely useful in practice for various tasks
> > involving figuring out process memory layout, what files are backing an=
y
> > given memory range, etc. One important class of applications that
> > absolutely rely on this are profilers/stack symbolizers. They would
> > normally capture stack trace containing absolute memory addresses of
> > some functions, and would then use /proc/<pid>/maps file to file
> > corresponding backing ELF files, file offsets within them, and then
> > continue from there to get yet more information (ELF symbols, DWARF
> > information) to get human-readable symbolic information.
> >
> > As such, there are both performance and correctness requirement
> > involved. This address to VMA information translation has to be done as
> > efficiently as possible, but also not miss any VMA (especially in the
> > case of loading/unloading shared libraries).
> >
> > Unfortunately, for all the /proc/<pid>/maps file universality and
> > usefulness, it doesn't fit the above 100%.
> >
> > First, it's text based, which makes its programmatic use from
> > applications and libraries unnecessarily cumbersome and slow due to the
> > need to do text parsing to get necessary pieces of information.
> >
> > Second, it's main purpose is to emit all VMAs sequentially, but in
> > practice captured addresses would fall only into a small subset of all
> > process' VMAs, mainly containing executable text. Yet, library would
> > need to parse most or all of the contents to find needed VMAs, as there
> > is no way to skip VMAs that are of no use. Efficient library can do the
> > linear pass and it is still relatively efficient, but it's definitely a=
n
> > overhead that can be avoided, if there was a way to do more targeted
> > querying of the relevant VMA information.
> >
> > Another problem when writing generic stack trace symbolization library
> > is an unfortunate performance-vs-correctness tradeoff that needs to be
> > made. Library has to make a decision to either cache parsed contents of
> > /proc/<pid>/maps for service future requests (if application requests t=
o
> > symbolize another set of addresses, captured at some later time, which
> > is typical for periodic/continuous profiling cases) to avoid higher
> > costs of needed to re-parse this file or caching the contents in memory
> > to speed up future requests. In the former case, more memory is used fo=
r
> > the cache and there is a risk of getting stale data if application
> > loaded/unloaded shared libraries, or otherwise changed its set of VMAs
> > through additiona mmap() calls (and other means of altering memory
> > address space). In the latter case, it's the performance hit that comes
> > from re-opening the file and re-reading/re-parsing its contents all ove=
r
> > again.
> >
> > This patch aims to solve this problem by providing a new API built on
> > top of /proc/<pid>/maps. It is ioctl()-based and built as a binary
> > interface, avoiding the cost and awkwardness of textual representation
> > for programmatic use. It's designed to be extensible and
> > forward/backward compatible by including user-specified field size and
> > using copy_struct_from_user() approach. But, most importantly, it allow=
s
> > to do point queries for specific single address, specified by user. And
> > this is done efficiently using VMA iterator.
> >
> > User has a choice to pick either getting VMA that covers provided
> > address or -ENOENT if none is found (exact, least surprising, case). Or=
,
> > with an extra query flag (PROCFS_PROCMAP_EXACT_OR_NEXT_VMA), they can
> > get either VMA that covers the address (if there is one), or the closes=
t
> > next VMA (i.e., VMA with the smallest vm_start > addr). The later allow=
s
> > more efficient use, but, given it could be a surprising behavior,
> > requires an explicit opt-in.
> >
> > Basing this ioctl()-based API on top of /proc/<pid>/maps's FD makes
> > sense given it's querying the same set of VMA data. All the permissions
> > checks performed on /proc/<pid>/maps opening fit here as well.
> > ioctl-based implementation is fetching remembered mm_struct reference,
> > but otherwise doesn't interfere with seq_file-based implementation of
> > /proc/<pid>/maps textual interface, and so could be used together or
> > independently without paying any price for that.
> >
> > There is one extra thing that /proc/<pid>/maps doesn't currently
> > provide, and that's an ability to fetch ELF build ID, if present. User
> > has control over whether this piece of information is requested or not
> > by either setting build_id_size field to zero or non-zero maximum buffe=
r
> > size they provided through build_id_addr field (which encodes user
> > pointer as __u64 field).
> >
> > The need to get ELF build ID reliably is an important aspect when
> > dealing with profiling and stack trace symbolization, and
> > /proc/<pid>/maps textual representation doesn't help with this,
> > requiring applications to open underlying ELF binary through
> > /proc/<pid>/map_files/<start>-<end> symlink, which adds an extra
> > permissions implications due giving a full access to the binary from
> > (potentially) another process, while all application is interested in i=
s
> > build ID. Giving an ability to request just build ID doesn't introduce
> > any additional security concerns, on top of what /proc/<pid>/maps is
> > already concerned with, simplifying the overall logic.
> >
> > Kernel already implements build ID fetching, which is used from BPF
> > subsystem. We are reusing this code here, but plan a follow up changes
> > to make it work better under more relaxed assumption (compared to what
> > existing code assumes) of being called from user process context, in
> > which page faults are allowed. BPF-specific implementation currently
> > bails out if necessary part of ELF file is not paged in, all due to
> > extra BPF-specific restrictions (like the need to fetch build ID in
> > restrictive contexts such as NMI handler).
> >
> > Note also, that fetching VMA name (e.g., backing file path, or special
> > hard-coded or user-provided names) is optional just like build ID. If
> > user sets vma_name_size to zero, kernel code won't attempt to retrieve
> > it, saving resources.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  fs/proc/task_mmu.c      | 165 ++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fs.h |  32 ++++++++
> >  2 files changed, 197 insertions(+)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 8e503a1635b7..cb7b1ff1a144 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/pkeys.h>
> >  #include <linux/minmax.h>
> >  #include <linux/overflow.h>
> > +#include <linux/buildid.h>
> >
> >  #include <asm/elf.h>
> >  #include <asm/tlb.h>
> > @@ -375,11 +376,175 @@ static int pid_maps_open(struct inode *inode, st=
ruct file *file)
> >       return do_maps_open(inode, file, &proc_pid_maps_op);
> >  }
> >
> > +static int do_procmap_query(struct proc_maps_private *priv, void __use=
r *uarg)
> > +{
> > +     struct procfs_procmap_query karg;
> > +     struct vma_iterator iter;
> > +     struct vm_area_struct *vma;
> > +     struct mm_struct *mm;
> > +     const char *name =3D NULL;
> > +     char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf =3D NULL;
> > +     __u64 usize;
> > +     int err;
> > +
> > +     if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
> > +             return -EFAULT;
> > +     if (usize > PAGE_SIZE)
> > +             return -E2BIG;
> > +     if (usize < offsetofend(struct procfs_procmap_query, query_addr))
> > +             return -EINVAL;
> > +     err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
> > +     if (err)
> > +             return err;
> > +
> > +     if (karg.query_flags & ~PROCFS_PROCMAP_EXACT_OR_NEXT_VMA)
> > +             return -EINVAL;
> > +     if (!!karg.vma_name_size !=3D !!karg.vma_name_addr)
> > +             return -EINVAL;
> > +     if (!!karg.build_id_size !=3D !!karg.build_id_addr)
> > +             return -EINVAL;
> > +
> > +     mm =3D priv->mm;
> > +     if (!mm || !mmget_not_zero(mm))
> > +             return -ESRCH;
> > +     if (mmap_read_lock_killable(mm)) {
> > +             mmput(mm);
> > +             return -EINTR;
> > +     }
>
> Using the rcu lookup here will allow for more success rate with less
> lock contention.
>

If you have any code pointers, I'd appreciate it. If not, I'll try to
find it myself, no worries.

> > +
> > +     vma_iter_init(&iter, mm, karg.query_addr);
> > +     vma =3D vma_next(&iter);
> > +     if (!vma) {
> > +             err =3D -ENOENT;
> > +             goto out;
> > +     }
> > +     /* user wants covering VMA, not the closest next one */
> > +     if (!(karg.query_flags & PROCFS_PROCMAP_EXACT_OR_NEXT_VMA) &&
> > +         vma->vm_start > karg.query_addr) {
> > +             err =3D -ENOENT;
> > +             goto out;
> > +     }
>
> The interface you are using is a start address to search from to the end
> of the address space, so this won't work as you intended with the
> PROCFS_PROCMAP_EXACT_OR_NEXT_VMA flag.  I do not think the vma iterator

Maybe the name isn't the best, by "EXACT" here I meant "VMA that
exactly covers provided address", so maybe "COVERING_OR_NEXT_VMA"
would be better wording.

With that out of the way, I think this API works exactly how I expect
it to work:

# cat /proc/3406/maps | grep -C1 7f42099fe000
7f42099fa000-7f42099fc000 rw-p 00000000 00:00 0
7f42099fc000-7f42099fe000 r--p 00000000 00:21 109331
  /usr/local/fbcode/platform010-compat/lib/libz.so.1.2.8
7f42099fe000-7f4209a0e000 r-xp 00002000 00:21 109331
  /usr/local/fbcode/platform010-compat/lib/libz.so.1.2.8
7f4209a0e000-7f4209a14000 r--p 00012000 00:21 109331
  /usr/local/fbcode/platform010-compat/lib/libz.so.1.2.8

# cat addrs.txt
0x7f42099fe010

# ./procfs_query -f addrs.txt -p 3406 -v -Q
PID: 3406
PATH: addrs.txt
READ 1 addrs!
SORTED ADDRS (1):
ADDR #0: 0x7f42099fe010
VMA FOUND (addr 7f42099fe010): 7f42099fe000-7f4209a0e000 r-xp 00002000
00:21 109331 /usr/local/fbcode/platform010-compat/lib/libz.so.1.2.8
(build ID: NO, 0 bytes)
RESOLVED ADDRS (1):
RESOLVED   #0: 0x7f42099fe010 -> OFF 0x2010 NAME
/usr/local/fbcode/platform010-compat/lib/libz.so.1.2.8

You can see above that for the requested 0x7f42099fe010 address we got
a VMA that starts before this address: 7f42099fe000-7f4209a0e000,
which is what we want.

Before submitting I ran the tool with /proc/<pid>/maps and ioctl to
"resolve" the exact same set of addresses and I compared results. They
were identical.


Note, there is a small bug in the tool I added in patch #5. I changed
`-i` argument to `-Q` at the very last moment and haven't updated the
code in one place. But other than that I didn't change anything. For
the above output, I added "VMA FOUND" verbose logging to see all the
details of VMA, not just resolved offset. I'll add that in v2.

> has the desired interface you want as the single address lookup doesn't
> use the vma iterator.  I'd just run the vma_next() and check the limits.
> See find_exact_vma() for the limit checks.
>
> > +
> > +     karg.vma_start =3D vma->vm_start;
> > +     karg.vma_end =3D vma->vm_end;
> > +

[...]

