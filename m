Return-Path: <linux-fsdevel+bounces-18851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A18CA8BD45D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55448282B59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777E9158864;
	Mon,  6 May 2024 18:05:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2F157461;
	Mon,  6 May 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018732; cv=none; b=HY4M/X92MF8IeExtLFjF5IYUtDd4xgEjh8BF0Fydtx4xJe//tZQJSmwPehXQjASw8NXew52mglzRkDHGlJopWr1ZrKiQlz7erX7a/xAOpsLyhhMVKIT3NUVnK1It5pnY7h8jqrQTGZWdG4ABFJGFIKrUJolhPKO0kJD7nYm8XVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018732; c=relaxed/simple;
	bh=HAweM0HgvqyFvaD/mScF16RtQpGquNuC1nNHgYsJoBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXzRlNksCRrlPEaUm1NT6aV4wugvoBMpIpnKsMZ5MglwL129pMVFNjocSbax+IT8f64p8e2vJwfmDRBOpSf2Kb25o5Y9WQiHgfkwbn/AH1rqICsdbaxHT4WkP/3htjsDyvWv0Vbnzgrnuymqm5+fcJp0cB80LQY/5gCn8y22rOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b537cd50f9so1050309a91.3;
        Mon, 06 May 2024 11:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018729; x=1715623529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjoAhUIR9ZkGQNMFQcUUvnhFqNKKUEnkKVYMn75r7UQ=;
        b=pg9oVdefIGnsmtSTXPBwSFve5rSbAu+4jtC3U2XR0Ru4e5CjuG1QvL9XBcQRcFD+YR
         jalAamIF628bua5dFZAIY7qfmUc8fqG/HaN+uLWTFRKPYtjvudRsbg+AcxFuRMJFDJMx
         0HFThau936J2AOWGj2SO8XLiydKf7Sqe/H1P+5vzDkieBDpL2Q7XKg08T8ImOtEvvP8d
         gVp1drWoc6aAEFcoQoZILkH6liWV5qvvPkFcyLPK2qg5YeCLQHicS6aNd+ojJBKg+0AC
         7rdUaMmNHKVFOhSdPIhrJpWwJCZ7CcnNEA1cEFsBxqAuaoIHtZCKfWvVcBInWKI6LUfl
         UehQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyyVLRh8lsW9q/zoGZdF3JtXzT44/GM5TaaxcBeCjDM6Y7tSbu8IX1NXXQ570Mc2o4R2PjKo3MOQxf3HetCDYY3w+Ix9/GAoc3VAHZ+vnurCcdSSDSe7/FYNa5Icrb/lggqK0WgeRbfhkaNjj4XeteRjKz6rvpZNy49pRzgVtwXKvxcdHDy6b9Z5Qc957ADL6oZ/zQHqrldTgfDRPmCsxn6CU=
X-Gm-Message-State: AOJu0Yy+v/1OAzx5j8Nn7ba0EFb+U6Woqc30vYF1NpYAlX9Dm3l/SBIO
	YSfr10xxm3HkNAJUp8dpeEAkl+rnltGuSXfRrq/Y5nARqPi/IRAzyEtlWMjNRRKgjHQBpjt7SIb
	XRAticKJsULWsvIMAjfHosgLf92c=
X-Google-Smtp-Source: AGHT+IG0AJwJ75Dskmt7MNksqyZ7Lr2pYoBn2hi4v3ndqJ6tVk5twLK2cinATJhzuro6OjgcUdApfTCz3OTwnQpLd0w=
X-Received: by 2002:a17:90b:238f:b0:2b2:1514:b79d with SMTP id
 mr15-20020a17090b238f00b002b21514b79dmr8341339pjb.31.1715018728945; Mon, 06
 May 2024 11:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-3-andrii@kernel.org>
 <2024050439-janitor-scoff-be04@gregkh> <CAEf4BzZ6CaMrqRR1Rah7=HnTpU5-zw5HUnSH9NWCzAZZ55ZXFQ@mail.gmail.com>
 <ZjjiFnNRbwsMJ3Gj@x1>
In-Reply-To: <ZjjiFnNRbwsMJ3Gj@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 6 May 2024 11:05:17 -0700
Message-ID: <CAM9d7cgvCB8CBFGhMB_-4tCm6+jzoPBNg4CR7AEyMNo8pF9QKg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 6, 2024 at 6:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Sat, May 04, 2024 at 02:50:31PM -0700, Andrii Nakryiko wrote:
> > On Sat, May 4, 2024 at 8:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > > On Fri, May 03, 2024 at 05:30:03PM -0700, Andrii Nakryiko wrote:
> > > > Note also, that fetching VMA name (e.g., backing file path, or spec=
ial
> > > > hard-coded or user-provided names) is optional just like build ID. =
If
> > > > user sets vma_name_size to zero, kernel code won't attempt to retri=
eve
> > > > it, saving resources.
>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> > > Where is the userspace code that uses this new api you have created?
>
> > So I added a faithful comparison of existing /proc/<pid>/maps vs new
> > ioctl() API to solve a common problem (as described above) in patch
> > #5. The plan is to put it in mentioned blazesym library at the very
> > least.
> >
> > I'm sure perf would benefit from this as well (cc'ed Arnaldo and
> > linux-perf-user), as they need to do stack symbolization as well.

I think the general use case in perf is different.  This ioctl API is great
for live tracing of a single (or a small number of) process(es).  And
yes, perf tools have those tracing use cases too.  But I think the
major use case of perf tools is system-wide profiling.

For system-wide profiling, you need to process samples of many
different processes at a high frequency.  Now perf record doesn't
process them and just save it for offline processing (well, it does
at the end to find out build-ID but it can be omitted).

Doing it online is possible (like perf top) but it would add more
overhead during the profiling.  And we cannot move processing
or symbolization to the end of profiling because some (short-
lived) tasks can go away.

Also it should support perf report (offline) on data from a
different kernel or even a different machine.

So it saves the memory map of processes and symbolizes
the stack trace with it later.  Of course it needs to be updated
as the memory map changes and that's why it tracks mmap
or similar syscalls with PERF_RECORD_MMAP[2] records.

A problem with this approach is to get the initial state of all
(or a target for non-system-wide mode) existing processes.
We call it synthesizing, and read /proc/PID/maps to generate
the mmap records.

I think the below comment from Arnaldo talked about how
we can improve the synthesizing (which is sequential access
to proc maps) using BPF.

Thanks,
Namhyung


>
> At some point, when BPF iterators became a thing we thought about, IIRC
> Jiri did some experimentation, but I lost track, of using BPF to
> synthesize PERF_RECORD_MMAP2 records for pre-existing maps, the layout
> as in uapi/linux/perf_event.h:
>
>         /*
>          * The MMAP2 records are an augmented version of MMAP, they add
>          * maj, min, ino numbers to be used to uniquely identify each map=
ping
>          *
>          * struct {
>          *      struct perf_event_header        header;
>          *
>          *      u32                             pid, tid;
>          *      u64                             addr;
>          *      u64                             len;
>          *      u64                             pgoff;
>          *      union {
>          *              struct {
>          *                      u32             maj;
>          *                      u32             min;
>          *                      u64             ino;
>          *                      u64             ino_generation;
>          *              };
>          *              struct {
>          *                      u8              build_id_size;
>          *                      u8              __reserved_1;
>          *                      u16             __reserved_2;
>          *                      u8              build_id[20];
>          *              };
>          *      };
>          *      u32                             prot, flags;
>          *      char                            filename[];
>          *      struct sample_id                sample_id;
>          * };
>          */
>         PERF_RECORD_MMAP2                       =3D 10,
>
>  *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
>
> As perf.data files can be used for many purposes we want them all, so we
> setup a meta data perf file descriptor to go on receiving the new mmaps
> while we read /proc/<pid>/maps, to reduce the chance of missing maps, do
> it in parallel, etc:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ perf record -h 'event synthesis'
>
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
>
>         --num-thread-synthesize <n>
>                           number of threads to run for event synthesis
>         --synth <no|all|task|mmap|cgroup>
>                           Fine-tune event synthesis: default=3Dall
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> For this specific initial synthesis of everything the plan, as mentioned
> about Jiri's experiments, was to use a BPF iterator to just feed the
> perf ring buffer with those events, that way userspace would just
> receive the usual records it gets when a new mmap is put in place, the
> BPF iterator would just feed the preexisting mmaps, as instructed via
> the perf_event_attr for the perf_event_open syscall.
>
> For people not wanting BPF, i.e. disabling it altogether in perf or
> disabling just BPF skels, then we would fallback to the current method,
> or to the one being discussed here when it becomes available.
>
> One thing to have in mind is for this iterator not to generate duplicate
> records for non-pre-existing mmaps, i.e. we would need some generation
> number that would be bumped when asking for such pre-existing maps
> PERF_RECORD_MMAP2 dumps.
>
> > It will be up to other similar projects to adopt this, but we'll
> > definitely get this into blazesym as it is actually a problem for the
>
> At some point looking at plugging blazesym somehow with perf may be
> something to consider, indeed.
>
> - Arnaldo
>
> > abovementioned Oculus use case. We already had to make a tradeoff (see
> > [2], this wasn't done just because we could, but it was requested by
> > Oculus customers) to cache the contents of /proc/<pid>/maps and run
> > the risk of missing some shared libraries that can be loaded later. It
> > would be great to not have to do this tradeoff, which this new API
> > would enable.
> >
> >   [2] https://github.com/libbpf/blazesym/commit/6b521314126b3ae6f2add43=
e93234b59fed48ccf
> >
> > >
> > > > ---
> > > >  fs/proc/task_mmu.c      | 165 ++++++++++++++++++++++++++++++++++++=
++++
> > > >  include/uapi/linux/fs.h |  32 ++++++++
> > > >  2 files changed, 197 insertions(+)
> > > >
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index 8e503a1635b7..cb7b1ff1a144 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -22,6 +22,7 @@
> > > >  #include <linux/pkeys.h>
> > > >  #include <linux/minmax.h>
> > > >  #include <linux/overflow.h>
> > > > +#include <linux/buildid.h>
> > > >
> > > >  #include <asm/elf.h>
> > > >  #include <asm/tlb.h>
> > > > @@ -375,11 +376,175 @@ static int pid_maps_open(struct inode *inode=
, struct file *file)
> > > >       return do_maps_open(inode, file, &proc_pid_maps_op);
> > > >  }
> > > >
> > > > +static int do_procmap_query(struct proc_maps_private *priv, void _=
_user *uarg)
> > > > +{
> > > > +     struct procfs_procmap_query karg;
> > > > +     struct vma_iterator iter;
> > > > +     struct vm_area_struct *vma;
> > > > +     struct mm_struct *mm;
> > > > +     const char *name =3D NULL;
> > > > +     char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf =3D NULL;
> > > > +     __u64 usize;
> > > > +     int err;
> > > > +
> > > > +     if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)=
))
> > > > +             return -EFAULT;
> > > > +     if (usize > PAGE_SIZE)
> > >
> > > Nice, where did you document that?  And how is that portable given th=
at
> > > PAGE_SIZE can be different on different systems?
> >
> > I'm happy to document everything, can you please help by pointing
> > where this documentation has to live?
> >
> > This is mostly fool-proofing, though, because the user has to pass
> > sizeof(struct procfs_procmap_query), which I don't see ever getting
> > close to even 4KB (not even saying about 64KB). This is just to
> > prevent copy_struct_from_user() below to do too much zero-checking.
> >
> > >
> > > and why aren't you checking the actual structure size instead?  You c=
an
> > > easily run off the end here without knowing it.
> >
> > See copy_struct_from_user(), it does more checks. This is a helper
> > designed specifically to deal with use cases like this where kernel
> > struct size can change and user space might be newer or older.
> > copy_struct_from_user() has a nice documentation describing all these
> > nuances.
> >
> > >
> > > > +             return -E2BIG;
> > > > +     if (usize < offsetofend(struct procfs_procmap_query, query_ad=
dr))
> > > > +             return -EINVAL;
> > >
> > > Ok, so you have two checks?  How can the first one ever fail?
> >
> > Hmm.. If usize =3D 8, copy_from_user() won't fail, usize > PAGE_SIZE
> > won't fail, but this one will fail.
> >
> > The point of this check is that user has to specify at least first
> > three fields of procfs_procmap_query (size, query_flags, and
> > query_addr), because without those the query is meaningless.
> > >
> > >
> > > > +     err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, usiz=
e);
> >
> > and this helper does more checks validating that the user either has a
> > shorter struct (and then zero-fills the rest of kernel-side struct) or
> > has longer (and then the longer part has to be zero filled). Do check
> > copy_struct_from_user() documentation, it's great.
> >
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > > > +     if (karg.query_flags & ~PROCFS_PROCMAP_EXACT_OR_NEXT_VMA)
> > > > +             return -EINVAL;
> > > > +     if (!!karg.vma_name_size !=3D !!karg.vma_name_addr)
> > > > +             return -EINVAL;
> > > > +     if (!!karg.build_id_size !=3D !!karg.build_id_addr)
> > > > +             return -EINVAL;
> > >
> > > So you want values to be set, right?
> >
> > Either both should be set, or neither. It's ok for both size/addr
> > fields to be zero, in which case it indicates that the user doesn't
> > want this part of information (which is usually a bit more expensive
> > to get and might not be necessary for all the cases).
> >
> > >
> > > > +
> > > > +     mm =3D priv->mm;
> > > > +     if (!mm || !mmget_not_zero(mm))
> > > > +             return -ESRCH;
> > >
> > > What is this error for?  Where is this documentned?
> >
> > I copied it from existing /proc/<pid>/maps checks. I presume it's
> > guarding the case when mm might be already put. So if the process is
> > gone, but we have /proc/<pid>/maps file open?
> >
> > >
> > > > +     if (mmap_read_lock_killable(mm)) {
> > > > +             mmput(mm);
> > > > +             return -EINTR;
> > > > +     }
> > > > +
> > > > +     vma_iter_init(&iter, mm, karg.query_addr);
> > > > +     vma =3D vma_next(&iter);
> > > > +     if (!vma) {
> > > > +             err =3D -ENOENT;
> > > > +             goto out;
> > > > +     }
> > > > +     /* user wants covering VMA, not the closest next one */
> > > > +     if (!(karg.query_flags & PROCFS_PROCMAP_EXACT_OR_NEXT_VMA) &&
> > > > +         vma->vm_start > karg.query_addr) {
> > > > +             err =3D -ENOENT;
> > > > +             goto out;
> > > > +     }
> > > > +
> > > > +     karg.vma_start =3D vma->vm_start;
> > > > +     karg.vma_end =3D vma->vm_end;
> > > > +
> > > > +     if (vma->vm_file) {
> > > > +             const struct inode *inode =3D file_user_inode(vma->vm=
_file);
> > > > +
> > > > +             karg.vma_offset =3D ((__u64)vma->vm_pgoff) << PAGE_SH=
IFT;
> > > > +             karg.dev_major =3D MAJOR(inode->i_sb->s_dev);
> > > > +             karg.dev_minor =3D MINOR(inode->i_sb->s_dev);
> > >
> > > So the major/minor is that of the file superblock?  Why?
> >
> > Because inode number is unique only within given super block (and even
> > then it's more complicated, e.g., btrfs subvolumes add more headaches,
> > I believe). inode + dev maj/min is sometimes used for cache/reuse of
> > per-binary information (e.g., pre-processed DWARF information, which
> > is *very* expensive, so anything that allows to avoid doing this is
> > helpful).
> >
> > >
> > > > +             karg.inode =3D inode->i_ino;
> > >
> > > What is userspace going to do with this?
> > >
> >
> > See above.
> >
> > > > +     } else {
> > > > +             karg.vma_offset =3D 0;
> > > > +             karg.dev_major =3D 0;
> > > > +             karg.dev_minor =3D 0;
> > > > +             karg.inode =3D 0;
> > >
> > > Why not set everything to 0 up above at the beginning so you never mi=
ss
> > > anything, and you don't miss any holes accidentally in the future.
> > >
> >
> > Stylistic preference, I find this more explicit, but I don't care much
> > one way or another.
> >
> > > > +     }
> > > > +
> > > > +     karg.vma_flags =3D 0;
> > > > +     if (vma->vm_flags & VM_READ)
> > > > +             karg.vma_flags |=3D PROCFS_PROCMAP_VMA_READABLE;
> > > > +     if (vma->vm_flags & VM_WRITE)
> > > > +             karg.vma_flags |=3D PROCFS_PROCMAP_VMA_WRITABLE;
> > > > +     if (vma->vm_flags & VM_EXEC)
> > > > +             karg.vma_flags |=3D PROCFS_PROCMAP_VMA_EXECUTABLE;
> > > > +     if (vma->vm_flags & VM_MAYSHARE)
> > > > +             karg.vma_flags |=3D PROCFS_PROCMAP_VMA_SHARED;
> > > > +
> >
> > [...]
> >
> > > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > > index 45e4e64fd664..fe8924a8d916 100644
> > > > --- a/include/uapi/linux/fs.h
> > > > +++ b/include/uapi/linux/fs.h
> > > > @@ -393,4 +393,36 @@ struct pm_scan_arg {
> > > >       __u64 return_mask;
> > > >  };
> > > >
> > > > +/* /proc/<pid>/maps ioctl */
> > > > +#define PROCFS_IOCTL_MAGIC 0x9f
> > >
> > > Don't you need to document this in the proper place?
> >
> > I probably do, but I'm asking for help in knowing where. procfs is not
> > a typical area of kernel I'm working with, so any pointers are highly
> > appreciated.
> >
> > >
> > > > +#define PROCFS_PROCMAP_QUERY _IOWR(PROCFS_IOCTL_MAGIC, 1, struct p=
rocfs_procmap_query)
> > > > +
> > > > +enum procmap_query_flags {
> > > > +     PROCFS_PROCMAP_EXACT_OR_NEXT_VMA =3D 0x01,
> > > > +};
> > > > +
> > > > +enum procmap_vma_flags {
> > > > +     PROCFS_PROCMAP_VMA_READABLE =3D 0x01,
> > > > +     PROCFS_PROCMAP_VMA_WRITABLE =3D 0x02,
> > > > +     PROCFS_PROCMAP_VMA_EXECUTABLE =3D 0x04,
> > > > +     PROCFS_PROCMAP_VMA_SHARED =3D 0x08,
> > >
> > > Are these bits?  If so, please use the bit macro for it to make it
> > > obvious.
> > >
> >
> > Yes, they are. When I tried BIT(1), it didn't compile. I chose not to
> > add any extra #includes to this UAPI header, but I can figure out the
> > necessary dependency and do BIT(), I just didn't feel like BIT() adds
> > much here, tbh.
> >
> > > > +};
> > > > +
> > > > +struct procfs_procmap_query {
> > > > +     __u64 size;
> > > > +     __u64 query_flags;              /* in */
> > >
> > > Does this map to the procmap_vma_flags enum?  if so, please say so.
> >
> > no, procmap_query_flags, and yes, I will
> >
> > >
> > > > +     __u64 query_addr;               /* in */
> > > > +     __u64 vma_start;                /* out */
> > > > +     __u64 vma_end;                  /* out */
> > > > +     __u64 vma_flags;                /* out */
> > > > +     __u64 vma_offset;               /* out */
> > > > +     __u64 inode;                    /* out */
> > >
> > > What is the inode for, you have an inode for the file already, why gi=
ve
> > > it another one?
> >
> > This is inode of vma's backing file, same as /proc/<pid>/maps' file
> > column. What inode of file do I already have here? You mean of
> > /proc/<pid>/maps itself? It's useless for the intended purposes.
> >
> > >
> > > > +     __u32 dev_major;                /* out */
> > > > +     __u32 dev_minor;                /* out */
> > >
> > > What is major/minor for?
> >
> > This is the same information as emitted by /proc/<pid>/maps,
> > identifies superblock of vma's backing file. As I mentioned above, it
> > can be used for caching per-file (i.e., per-ELF binary) information
> > (for example).
> >
> > >
> > > > +     __u32 vma_name_size;            /* in/out */
> > > > +     __u32 build_id_size;            /* in/out */
> > > > +     __u64 vma_name_addr;            /* in */
> > > > +     __u64 build_id_addr;            /* in */
> > >
> > > Why not document this all using kerneldoc above the structure?
> >
> > Yes, sorry, I slacked a bit on adding this upfront. I knew we'll be
> > figuring out the best place and approach, and so wanted to avoid
> > documentation churn.
> >
> > Would something like what we have for pm_scan_arg and pagemap APIs
> > work? I see it added a few simple descriptions for pm_scan_arg struct,
> > and there is Documentation/admin-guide/mm/pagemap.rst. Should I add
> > Documentation/admin-guide/mm/procmap.rst (admin-guide part feels off,
> > though)? Anyways, I'm hoping for pointers where all this should be
> > documented. Thank you!
> >
> > >
> > > anyway, I don't like ioctls, but there is a place for them, you just
> > > have to actually justify the use for them and not say "not efficient
> > > enough" as that normally isn't an issue overall.
> >
> > I've written a demo tool in patch #5 which performs real-world task:
> > mapping addresses to their VMAs (specifically calculating file offset,
> > finding vma_start + vma_end range to further access files from
> > /proc/<pid>/map_files/<start>-<end>). I did the implementation
> > faithfully, doing it in the most optimal way for both APIs. I showed
> > that for "typical" (it's hard to specify what typical is, of course,
> > too many variables) scenario (it was data collected on a real server
> > running real service, 30 seconds of process-specific stack traces were
> > captured, if I remember correctly). I showed that doing exactly the
> > same amount of work is ~35x times slower with /proc/<pid>/maps.
> >
> > Take another process, another set of addresses, another anything, and
> > the numbers will be different, but I think it gives the right idea.
> >
> > But I think we are overpivoting on text vs binary distinction here.
> > It's the more targeted querying of VMAs that's beneficial here. This
> > allows applications to not cache anything and just re-query when doing
> > periodic or continuous profiling (where addresses are coming in not as
> > one batch, as a sequence of batches extended in time).
> >
> > /proc/<pid>/maps, for all its usefulness, just can't provide this sort
> > of ability, as it wasn't designed to do that and is targeting
> > different use cases.
> >
> > And then, a new ability to request reliable (it's not 100% reliable
> > today, I'm going to address that as a follow up) build ID is *crucial*
> > for some scenarios. The mentioned Oculus use case, the need to fully
> > access underlying ELF binary just to get build ID is frowned upon. And
> > for a good reason. Profiler only needs build ID, which is no secret
> > and not sensitive information. This new (and binary, yes) API allows
> > to add this into an API without breaking any backwards compatibility.
> >
> > >
> > > thanks,
> > >
> > > greg k-h
>

