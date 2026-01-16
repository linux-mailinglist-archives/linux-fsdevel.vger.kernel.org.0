Return-Path: <linux-fsdevel+bounces-74222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43385D38580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B891D3171BAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A72F342CBA;
	Fri, 16 Jan 2026 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdxO+PJY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D12FC037
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590523; cv=none; b=YdC9IJ3tzY6UvDJ07+2xbQvVcIJVDkYh2GHaPrTWgjlBKBgdXmjVe8+ASxxgHmassaza+wgQMB4fp24ic7FpTEuqDW/Qii5Re/T7ABKKMPISFwFT5peUcCKKpw89SpuM+yMdbpuHrzzKf3bD239CqHB5GwsW8lL/wfDebRh0srQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590523; c=relaxed/simple;
	bh=U3aS3WvOf2nzm+FaYIxxDr2bSsjibAemcZeM9r1e4FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEBq4xQzN7n5iwbsYq6EDAGciiiyztKB2kHVdKQNoA/mWSAwXSMJ7yptt1SyvpzCrW4b+mnpC5yKwexfFkEbwg01OJ32TxpD+X+sjL3srG75rKWNTQ4JV3tixWjttt1Otknsxzp/Ex6ooVB2uIHTPRY/uL0JTi2vFLieyQ4vjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdxO+PJY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso3773267a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 11:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768590520; x=1769195320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfuYOsVn4pgkxUWAHIOsTMorfpaqhye8fLIKpz+LFII=;
        b=NdxO+PJYmWzKbhl/6MHVzkiY64M9jU6V0ntUXauu+CdO2gTDg0o3V42Iu2yl6Dr9aF
         E8dqDaZLADJpiVav0E55xU/O2gi3wbiV6SV7YaBqfOq7ngyEZ07+bGAESxPjl9a7Ta9R
         26y6YsfD5p9n7dgsZKboFuEaTW8DoBDhrhEEdC2kc/FbaBk2ffaTuqe1MlfIjNv+1D+D
         ROYvOO1oo5LHb5zhGQcbt9TnHV2xhRriKTjyreQDxFQhVLA+CrfvufE3dn/tQng7uwGm
         ciHjuG40Xc5Ti/GsFJaMI6vP4QIzzUw/A13bDUQ7kIzw5z85qiQ4Zpcbz+Hc201t/hab
         Euiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768590520; x=1769195320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfuYOsVn4pgkxUWAHIOsTMorfpaqhye8fLIKpz+LFII=;
        b=KpX3K4e8HAyy18SLRXqX8Okn96LrKLoz5tNvDvSLWny8ek/RcNufxIFR6WKpZLzyyI
         tl0+ecxu1J9MGQTJ5WfZkVJNmxBeIA0wBnGiY+WDVp/UYJm2pv1hjklTFh7jxVjD+K4B
         hI/bY5sAgxrfz1JTYt37Ev0b05z6fIg6jc6x/o3LfaxBbCZb/uQMHX3jPLgOA/kktXsz
         y4v5CC6aT+gDUyAQfx4mISpV94XKWjwpEJd/eIjB8CdJItPigIv2eKx9wNvJFVmod9pP
         NVMSYMsB/fa3l7twVAGkO6wH6q+Y91FMNtiw88eDCH9Ib9VBA62MVQTUfuqxGYqMGLjC
         t5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCU/re3pjMWFPigVAEqM6OLHBtWjZXPa1DN/SiFQG7LxwuHWTLzUUH2TN1XY/EFSBwuJlHrlriw71cL61saS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo8QMvTMoiEOgWiJzD0OEOgqlWQYgh5Q6zIK5ZVweOLVU1nBhN
	6yqo/iDUSW+gxoCHAUBXPyUbfwSQR98GeniDhjXMxOoDXJkp/0iZmqq4dqYpsJFV1p8Aui58NDX
	hyNJV5yD7YymbhvnuR/HJY0e90BgnBfY=
X-Gm-Gg: AY/fxX560sF461ERyGOU24p4BgM8sGZ7qIQH3oHmo0CBfmO39iKChwxdCdMULmejLvT
	b6HkqqQcjS/T+wMVt5NiGW09dm5WJm/9R/rs2JC6bIQ1AZp7iQ2POz7Un+dPx24jS8CitnEQaya
	ZbRsiVvRmuoKuMBPkVnw9Wq0wVpGUET0V9ILvHFX0rJdWg6YWxc1DXZ0/ya033jvvTNI6mKGhR1
	WHAdH5UrT7GajiMBcoLv9ugMyezsGc4NloHdZUcKpeyeNVXFp9zQ2EA7YlhDQUYMUZam8JmtHSO
	GUshahLm+78GkYpudplSxkE573JEBh7zzALI8SmG
X-Received: by 2002:a05:6402:2808:b0:650:8563:fdbe with SMTP id
 4fb4d7f45d1cf-654bb4296d1mr2745902a12.23.1768590519893; Fri, 16 Jan 2026
 11:08:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115072032.402-1-luochunsheng@ustc.edu> <20260115072032.402-3-luochunsheng@ustc.edu>
 <aWjnHvP5jsafQeag@amir-ThinkPad-T480> <a0ccfa28-4107-46ed-af79-faf55c004da0@ustc.edu>
 <CAOQ4uxhOuBXT3tgoLxjh6efAwiOLg=oDxsyivLLMXCrSamSuEA@mail.gmail.com> <bff16d9e-d6e7-4d0e-9a58-6db37ec58ce7@ustc.edu>
In-Reply-To: <bff16d9e-d6e7-4d0e-9a58-6db37ec58ce7@ustc.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Jan 2026 20:08:28 +0100
X-Gm-Features: AZwV_QjE_eUn5iVflmBBj0X59_O3RrF4xBQyhUCmkzj71NXBrB25c93FDkWpMzg
Message-ID: <CAOQ4uxjv=EZ-W-L=o8m2V+399PcBLLedz7T4z=5XKZhkwYitWw@mail.gmail.com>
Subject: Re: [RFC 2/2] fuse: Add new flag to reuse the backing file of fuse_inode
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paullawrence@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 3:43=E2=80=AFAM Chunsheng Luo <luochunsheng@ustc.ed=
u> wrote:
>
>
>
> On 1/15/26 11:31 PM, Amir Goldstein wrote:
> > On Thu, Jan 15, 2026 at 3:35=E2=80=AFPM Chunsheng Luo <luochunsheng@ust=
c.edu> wrote:
> >>
> >>
> >>
> >> On 1/15/26 9:09 PM, Amir Goldstein wrote:
> >>> Hi Chunsheng,
> >>>
> >>> Please CC me for future fuse passthrough patch sets.
> >>>
> >> Ok.
> >>
> >>> On Thu, Jan 15, 2026 at 03:20:31PM +0800, Chunsheng Luo wrote:
> >>>> To simplify crash recovery and reduce performance impact, backing_id=
s
> >>>> are not persisted across daemon restarts. However, this creates a
> >>>> problem: when the daemon restarts and a process opens the same FUSE
> >>>> file, a new backing_id may be allocated for the same backing file. I=
f
> >>>> the inode already has a cached backing file from before the restart,
> >>>> subsequent open requests with the new backing_id will fail in
> >>>> fuse_inode_uncached_io_start() due to fb mismatch, even though both
> >>>> IDs reference the identical underlying file.
> >>>
> >>> I don't think that your proposal makes this guaranty.
> >>>
> >>
> >> Yes, this proposal does not apply to all situations.
> >>
> >>>>
> >>>> Introduce the FOPEN_PASSTHROUGH_INODE_CACHE flag to address this
> >>>> issue. When set, the kernel reuses the backing file already cached i=
n
> >>>> the inode.
> >>>>
> >>>> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> >>>> ---
> >>>>    fs/fuse/iomode.c          |  2 +-
> >>>>    fs/fuse/passthrough.c     | 11 +++++++++++
> >>>>    include/uapi/linux/fuse.h |  2 ++
> >>>>    3 files changed, 14 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> >>>> index 3728933188f3..b200bb248598 100644
> >>>> --- a/fs/fuse/iomode.c
> >>>> +++ b/fs/fuse/iomode.c
> >>>> @@ -163,7 +163,7 @@ static void fuse_file_uncached_io_release(struct=
 fuse_file *ff,
> >>>>     */
> >>>>    #define FOPEN_PASSTHROUGH_MASK \
> >>>>       (FOPEN_PASSTHROUGH | FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_W=
RITES | \
> >>>> -     FOPEN_NOFLUSH)
> >>>> +     FOPEN_NOFLUSH | FOPEN_PASSTHROUGH_INODE_CACHE)
> >>>>
> >>>>    static int fuse_file_passthrough_open(struct inode *inode, struct=
 file *file)
> >>>>    {
> >>>> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> >>>> index 72de97c03d0e..fde4ac0c5737 100644
> >>>> --- a/fs/fuse/passthrough.c
> >>>> +++ b/fs/fuse/passthrough.c
> >>>> @@ -147,16 +147,26 @@ ssize_t fuse_passthrough_mmap(struct file *fil=
e, struct vm_area_struct *vma)
> >>>>    /*
> >>>>     * Setup passthrough to a backing file.
> >>>>     *
> >>>> + * If fuse inode backing is provided and FOPEN_PASSTHROUGH_INODE_CA=
CHE flag
> >>>> + * is set, try to reuse it first before looking up backing_id.
> >>>> + *
> >>>>     * Returns an fb object with elevated refcount to be stored in fu=
se inode.
> >>>>     */
> >>>>    struct fuse_backing *fuse_passthrough_open(struct file *file, int=
 backing_id)
> >>>>    {
> >>>>       struct fuse_file *ff =3D file->private_data;
> >>>>       struct fuse_conn *fc =3D ff->fm->fc;
> >>>> +    struct fuse_inode *fi =3D get_fuse_inode(file->f_inode);
> >>>>       struct fuse_backing *fb =3D NULL;
> >>>>       struct file *backing_file;
> >>>>       int err;
> >>>>
> >>>> +    if (ff->open_flags & FOPEN_PASSTHROUGH_INODE_CACHE) {
> >>>> +            fb =3D fuse_backing_get(fuse_inode_backing(fi));
> >>>> +            if (fb)
> >>>> +                    goto do_open;
> >>>> +    }
> >>>> +
> >>>
> >>> Maybe an explicit FOPEN_PASSTHROUGH_INODE_CACHE flag is a good idea,
> >>> but just FYI, I intentionally reserved backing_id 0 for this purpose.
> >>> For example, for setting up the backing id on lookup [1] and then
> >>> open does not need to specify the backing_id.
> >>>
> >>> [1] https://lore.kernel.org/linux-fsdevel/20250804173228.1990317-1-pa=
ullawrence@google.com/
> >>>
> >>
> >> This is a great idea. However, we need to consider the lifecycle
> >> management of the backing file associated with a FUSE inode.
> >> Specifically, will the same backing_idbe retained for the entire
> >> lifetime of the FUSE inode until it is deleted?
> >
> > It's not a good fit for servers that want to change the backing file
> > (like re-download). For these servers we have the existing file
> > open-to-close life cycle.
> >
> >>
> >> Additionally, since each backing_idcorresponds to an open file
> >> descriptor (fd) for the backing file, if a fuse_inode holds onto a
> >> backing_id indefinitely without a suitable release mechanism, could th=
is
> >> accumulation of file descriptors cause the process to exceed its open
> >> files limit?
> >>
> >
> > There is no such accumulation.
> > fuse_inode refers to a single fuse_backing object.
> > fuse_file refers to a single fuse_backing object.
> > It can be the same (refcounted) object.
> >
>
> Sorry, I wasn't referring to `fuse_backing` refs.
>
> If the lifecycle of `fuse_backing` is the same as `fuse_inode`, and
> there are a large number of FUSE files on the file system, then when I
> iterate through and open the backing files, register the `fuse_backing`,
> and then set it to the `fuse_inode`, the FUSE service will hold a large
> number of backing file file descriptors (FDs).  These backing file FDs
> will only be released when the FUSE files are deleted.
>

Not until files are deleted. Until fuse inodes are evicted from inode cache=
.
FWIW, fuse_inode is ~900 bytes and filp is ~256 bytes, and when memory
is needed, memory shrinker will evict fuse inodes and backing file, so sure
backing files take up memory but not a game changer.

> For example, if there are 1000 FUSE files on the file system, and I
> iterate through and set the backing file for each `fuse_inode`, then the
> FUSE service will hold 1000 backing file FDs for a long time.  Extending
> this further, if there are even more files, could the FUSE service
> process exceed the `ulimit` configuration for open files?
>
> ```shell
> [root@localhost home]# ulimit -a |grep "open files"
> open files                          (-n) 1024
> ```
>

backing files do not account for the open files limit of the FUSE server
that's one of the design issues, but it is by design.

> >>> But what you are proposing is a little bit odd API IMO:
> >>> "Use this backing_id with this backing file, unless you find another
> >>>    backing file so use that one instead" - this sounds a bit awkward =
to me.
> >>>
> >>> I think it would be saner and simpler to relax the check in
> >>> fuse_inode_uncached_io_start() to check that old and new fuse_backing
> >>> objects refer to the same backing inode:
> >>>
> >>> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> >>> index 3728933188f30..c6070c361d855 100644
> >>> --- a/fs/fuse/iomode.c
> >>> +++ b/fs/fuse/iomode.c
> >>> @@ -88,9 +88,9 @@ int fuse_inode_uncached_io_start(struct fuse_inode =
*fi, struct fuse_backing *fb)
> >>>        int err =3D 0;
> >>>
> >>>        spin_lock(&fi->lock);
> >>> -     /* deny conflicting backing files on same fuse inode */
> >>> +     /* deny conflicting backing inodes on same fuse inode */
> >>>        oldfb =3D fuse_inode_backing(fi);
> >>> -     if (fb && oldfb && oldfb !=3D fb) {
> >>> +     if (fb && oldfb && file_inode(oldfb->file) !=3D file_inode(fb->=
file)) {
> >>>                err =3D -EBUSY;
> >>>                goto unlock;
> >>>        }
> >>> --
> >>>
> >>> I don't think that this requires opt-in flag.
> >>>
> >>> Thanks,
> >>> Amir.
> >>
> >> I agree that modifying the condition to `file_inode(oldfb->file) !=3D
> >> file_inode(fb->file)` is a reasonable fix, and it does address the fir=
st
> >> scenario I described.
> >>
> >> However, it doesn't fully resolve the second scenario: in a read-only
> >> FUSE filesystem, the backing file itself might be cleaned up and
> >> re-downloaded (resulting in a new inode with identical content). In th=
is
> >> case, reusing the cached fuse_inode's fb after a daemon restart still =
be
> >> safe, but the inode comparison would incorrectly reject it. Is there a
> >> more robust approach for handling this scenario?
> >>
> >
> > There is a reason we added the restriction against associating
> > fuse file to different backing inodes.
> >
> > mmap and reads from different files to the same inode need to be
> > cache coherent.
> >
> > IOW, we intentionally do not support this setup without server restart
> > there is no reason for us to allow that after server restarts because
> > the consequense will be the same.
> >
> > It does not sound like a good idea for the server to cleanup files
> > that are currently opened via fuse passthrough - is that something
> > that happens intentionally? after server restarts?
> >
> > You could try to take a write lease to check if the file is currently
> > open for read/write to avoid cleanup in this case?
> >
> > Thanks,
> > Amir.
> >
> >
>
> Yes, it happened after the fuse service crash recovery restart, because
> the refs of the backup files were cleaned up, causing them to be
> mistakenly garbage collected.
>
> I will consider how to prevent it from being mistakenly garbage
> collected by the fuse server.

See here https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Stora=
ge-Management-API#evicting-file-content
explanation how you can use F_SETLEASE to synchronize evicting
file content with file content readers.

Thanks,
Amir.

