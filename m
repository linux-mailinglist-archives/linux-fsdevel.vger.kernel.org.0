Return-Path: <linux-fsdevel+bounces-46577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D36A9092A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385A33B661C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877CB213253;
	Wed, 16 Apr 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOLyFSgS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20185213221
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821806; cv=none; b=E7DJxxo6qB71qGtBdvIb53lioap0kVxGQhK/CnlQiu24eHAAqRaYahuyajQ3Cs4z28Lem+4uL3ZzP/60gYN9Zk56x/yF/+IS8ZgSNSiu8GEdp8+5iReZqxhM/udG2hftMgtMavtsuT/88toqcL0a252YTkRGYPfpJPVZkwxqraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821806; c=relaxed/simple;
	bh=zlfJ16HY4pgmIQOAt+PmHLghJo5obCWArJKO9LKq46Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4mwUhMj8PyKzGo3B2EqUOQK6VWpK3w5iCgbvn0VeCinkmhN3Zl+FTlM9e7JbZ2ex+uFgiH6/niNnXivJYd6YSLWaa1/dAEHwTLhlgH7b2r1KV4H5Em6zhueFMx0LDje5pJlXlaSZtiGEvvJ4TuLZB3/ara9spHTXANk/cKOMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOLyFSgS; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5b2472969so683306885a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744821803; x=1745426603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JucdQ5DlZmC5EJz29kiAI+WzCFhEkuoOxCFmay4JEVU=;
        b=HOLyFSgS7zZG4RjGg1520Mosx69Mgqah4oEHZmy6uxNJdelnof2pcZcwtbIMzxqhZ5
         050CDVBNznwKqBZG2U1ZQdm0LVz6M6u2o4+5PwMsH4V6kFj4/Egou+OC8OX+fjX2iKLC
         ycOfpWikwYWSgGdlndByjur5mBwABP7+6WZNZMZJrwtEIBT//JMp260elryR3ArcwgCU
         PeB6wTfiUnyYl5Xc20bXWT6cKtd9WeIgAjsVIaNU8CeIlDvqkt8Pq3Pra8dhKoVSCC26
         Ijm8c88+ol0m2hPCctMihmdlIPJdGxzfq8HjlHv+Q33+lPJRWgymxoiOgVQ+NnlWacDV
         S9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744821803; x=1745426603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JucdQ5DlZmC5EJz29kiAI+WzCFhEkuoOxCFmay4JEVU=;
        b=oQOcF2T3gGPgW9PMykiwDv7KX3+X7CvCJXtjZtV7/ueGhYdm2ZpDDEwnigZKg4ZVjK
         YLX3OMJIOL697GsdOBxn7E3qF6z0gzarG2GAPvSNDYi/JXvJHtvqc5rhLLAlpV/1zhda
         8gVgM6o4k50YNXWD2As+CI4mm38q+++0fzdADm8HIEclpCzTC+fl0bGcbtcWXgGoi7Ay
         swTsSGO/UiZsVYQp/p5N2Wk8rJIfbakP9KaU08M3OByDgDbtd3xORcOGeWHV+Zq3K4ay
         9u6gSPB9CJQyHK7hY9pr5OuyDQUNwiWrVV4A8+aR9QqrCWQDLxS7arymi/P4kxT+1rCd
         DhYw==
X-Forwarded-Encrypted: i=1; AJvYcCURoW8l+DSGg5ST7I85MEJEiCPrrddC7KbhN2ib/XsRKfWvH6sM7LdrEy6Acrm31CYraZZs3mrfVEfFZl38@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbm2FUqJZHgL7IzQSRlM7yWZ+1KwdWZFv9cfZdEax0W6CIMCiG
	UG/D32JxbBvnJPOKZGyyw+C0CGRY3fNvn41zEYSKrZXa96dGb+kF/GF00Xv2GWvIwQEC3eGbRQF
	+t20KhDS4UzBOTZJXtLajmhXqNMM=
X-Gm-Gg: ASbGncvXDx4j15YqCPLJV+rqP6waNwL2I1JgXvH7f8LNrZm3iDye3Ua9FSVOwIRuHqZ
	YanFctwYcCym6MyGdEydukhsgGlFSPJ1EeYXdDYUJ7CvZ+YLt9HMCwpD5dzptL1F1ZQPwD5vW2V
	8TvrhnKShyi67r/55YgtNa2g==
X-Google-Smtp-Source: AGHT+IEywHem12CF/QZaY5V7xsM+8mI8ZK/OyLdC8/u/nwQnpmqFBwB3XE5PJMRMBk4z1R0WvhVUwAnCZUsUsX0UNh0=
X-Received: by 2002:a05:620a:424c:b0:7c5:4b91:6a41 with SMTP id
 af79cd13be357-7c9190633aemr278630185a.42.1744821802838; Wed, 16 Apr 2025
 09:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-4-joannelkoong@gmail.com> <db4f1411-f6de-4206-a6a3-5c9cf6b6d59d@linux.alibaba.com>
 <CAJnrk1bTGFXy+ZTchC7p4OYUnbfKZ7TtVkCsrsv87Mg1r8KkGA@mail.gmail.com>
 <7e9b1a40-4708-42a8-b8fc-44fa50227e5b@linux.alibaba.com> <CAJnrk1Z7Wi_KPe_TJckpYUVhv9mKX=-YTwaoQRgjT2z0fxD-7g@mail.gmail.com>
 <9a3cfb55-faae-4551-9bef-b9650432848a@linux.alibaba.com> <CAJnrk1a_YL-Dg4HeVWnmwUVH2tCN2MYu30kiV5KSv4mkezWOZg@mail.gmail.com>
 <a738a765-a5e1-44bc-b1cd-e1a42d73e255@linux.alibaba.com> <CAJnrk1ZZ7tRwPk0hUePDVcwKnec96qFkO3Mk1zyG2g5PO1XL=w@mail.gmail.com>
 <c66d712f-e2f1-4c6e-b9a6-14689101f866@linux.alibaba.com>
In-Reply-To: <c66d712f-e2f1-4c6e-b9a6-14689101f866@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 16 Apr 2025 09:43:12 -0700
X-Gm-Features: ATxdqUFdkj-lUnkpAvC23WtI0NTAhmFoMjBMxIeN1VnDZ3P5KfQM4kJi4zK58sU
Message-ID: <CAJnrk1buLrVuOxX-Q8QBZkqrM7fF_EaoOCmsxM0nyf1HndkYtA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev, 
	david@redhat.com, bernd.schubert@fastmail.fm, ziy@nvidia.com, 
	jlayton@kernel.org, kernel-team@meta.com, 
	Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 6:40=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> On 4/15/25 11:59 PM, Joanne Koong wrote:
> > On Tue, Apr 15, 2025 at 12:49=E2=80=AFAM Jingbo Xu <jefflexu@linux.alib=
aba.com> wrote:
> >>
> >> Hi Joanne,
> >>
> >> Sorry for the late reply...
> >
> > Hi Jingbo,
> >
> > No worries at all.
> >>
> >>
> >> On 4/11/25 12:11 AM, Joanne Koong wrote:
> >>> On Thu, Apr 10, 2025 at 8:11=E2=80=AFAM Jingbo Xu <jefflexu@linux.ali=
baba.com> wrote:
> >>>>
> >>>> On 4/10/25 11:07 PM, Joanne Koong wrote:
> >>>>> On Wed, Apr 9, 2025 at 7:12=E2=80=AFPM Jingbo Xu <jefflexu@linux.al=
ibaba.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 4/10/25 7:47 AM, Joanne Koong wrote:
> >>>>>>>   On Tue, Apr 8, 2025 at 7:43=E2=80=AFPM Jingbo Xu <jefflexu@linu=
x.alibaba.com> wrote:
> >>>>>>>>
> >>>>>>>> Hi Joanne,
> >>>>>>>>
> >>>>>>>> On 4/5/25 2:14 AM, Joanne Koong wrote:
> >>>>>>>>> In the current FUSE writeback design (see commit 3be5a52b30aa
> >>>>>>>>> ("fuse: support writable mmap")), a temp page is allocated for =
every
> >>>>>>>>> dirty page to be written back, the contents of the dirty page a=
re copied over
> >>>>>>>>> to the temp page, and the temp page gets handed to the server t=
o write back.
> >>>>>>>>>
> >>>>>>>>> This is done so that writeback may be immediately cleared on th=
e dirty page,
> >>>>>>>>> and this in turn is done in order to mitigate the following dea=
dlock scenario
> >>>>>>>>> that may arise if reclaim waits on writeback on the dirty page =
to complete:
> >>>>>>>>> * single-threaded FUSE server is in the middle of handling a re=
quest
> >>>>>>>>>   that needs a memory allocation
> >>>>>>>>> * memory allocation triggers direct reclaim
> >>>>>>>>> * direct reclaim waits on a folio under writeback
> >>>>>>>>> * the FUSE server can't write back the folio since it's stuck i=
n
> >>>>>>>>>   direct reclaim
> >>>>>>>>>
> >>>>>>>>> With a recent change that added AS_WRITEBACK_INDETERMINATE and =
mitigates
> >>>>>>>>> the situations described above, FUSE writeback does not need to=
 use
> >>>>>>>>> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode m=
appings.
> >>>>>>>>>
> >>>>>>>>> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappin=
gs
> >>>>>>>>> and removes the temporary pages + extra copying and the interna=
l rb
> >>>>>>>>> tree.
> >>>>>>>>>
> >>>>>>>>> fio benchmarks --
> >>>>>>>>> (using averages observed from 10 runs, throwing away outliers)
> >>>>>>>>>
> >>>>>>>>> Setup:
> >>>>>>>>> sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
> >>>>>>>>>  ./libfuse/build/example/passthrough_ll -o writeback -o max_thr=
eads=3D4 -o source=3D~/tmp_mount ~/fuse_mount
> >>>>>>>>>
> >>>>>>>>> fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1=
k,4k,1M} --size=3D2G
> >>>>>>>>> --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --director=
y=3D/root/fuse_mount
> >>>>>>>>>
> >>>>>>>>>         bs =3D  1k          4k            1M
> >>>>>>>>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> >>>>>>>>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
> >>>>>>>>> % diff        -3%          23%         45%
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>>>>>>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> >>>>>>>>> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> >>>>>>>>
> >>>>>>>
> >>>>>>> Hi Jingbo,
> >>>>>>>
> >>>>>>> Thanks for sharing your analysis for this.
> >>>>>>>
> >>>>>>>> Overall this patch LGTM.
> >>>>>>>>
> >>>>>>>> Apart from that, IMO the fi->writectr and fi->queued_writes mech=
anism is
> >>>>>>>> also unneeded then, at least the DIRECT IO routine (i.e.
> >>>>>>>
> >>>>>>> I took a look at fi->writectr and fi->queued_writes and my
> >>>>>>> understanding is that we do still need this. For example, for
> >>>>>>> truncates (I'm looking at fuse_do_setattr()), I think we still ne=
ed to
> >>>>>>> prevent concurrent writeback or else the setattr request and the
> >>>>>>> writeback request could race which would result in a mismatch bet=
ween
> >>>>>>> the file's reported size and the actual data written to disk.
> >>>>>>
> >>>>>> I haven't looked into the truncate routine yet.  I will see it lat=
er.
> >>>>>>
> >>>>>>>
> >>>>>>>> fuse_direct_io()) doesn't need fuse_sync_writes() anymore.  That=
 is
> >>>>>>>> because after removing the temp page, the DIRECT IO routine has =
already
> >>>>>>>> been waiting for all inflight WRITE requests, see
> >>>>>>>>
> >>>>>>>> # DIRECT read
> >>>>>>>> generic_file_read_iter
> >>>>>>>>   kiocb_write_and_wait
> >>>>>>>>     filemap_write_and_wait_range
> >>>>>>>
> >>>>>>> Where do you see generic_file_read_iter() getting called for dire=
ct io reads?
> >>>>>>
> >>>>>> # DIRECT read
> >>>>>> fuse_file_read_iter
> >>>>>>   fuse_cache_read_iter
> >>>>>>     generic_file_read_iter
> >>>>>>       kiocb_write_and_wait
> >>>>>>        filemap_write_and_wait_range
> >>>>>>       a_ops->direct_IO(),i.e. fuse_direct_IO()
> >>>>>>
> >>>>>
> >>>>> Oh I see, I thought files opened with O_DIRECT automatically call t=
he
> >>>>> .direct_IO handler for reads/writes but you're right, it first goes
> >>>>> through .read_iter / .write_iter handlers, and the .direct_IO handl=
er
> >>>>> only gets invoked through generic_file_read_iter() /
> >>>>> generic_file_direct_write() in mm/filemap.c
> >>>>>
> >>>>> There's two paths for direct io in FUSE:
> >>>>> a) fuse server sets fi->direct_io =3D true when a file is opened, w=
hich
> >>>>> will set the FOPEN_DIRECT_IO bit in ff->open_flags on the kernel si=
de
> >>>>> b) fuse server doesn't set fi->direct_io =3D true, but the client o=
pens
> >>>>> the file with O_DIRECT
> >>>>>
> >>>>> We only go through the stack trace you listed above for the b) case=
.
> >>>>> For the a) case, we'll hit
> >>>>>
> >>>>>         if (ff->open_flags & FOPEN_DIRECT_IO)
> >>>>>                 return fuse_direct_read_iter(iocb, to);
> >>>>>
> >>>>> and
> >>>>>
> >>>>>         if (ff->open_flags & FOPEN_DIRECT_IO)
> >>>>>                 return fuse_direct_write_iter(iocb, from);
> >>>>>
> >>>>> which will invoke fuse_direct_IO() / fuse_direct_io() without going
> >>>>> through the kiocb_write_and_wait() -> filemap_write_and_wait_range(=
) /
> >>>>> kiocb_invalidate_pages() -> filemap_write_and_wait_range() you list=
ed
> >>>>> above.
> >>>>>
> >>>>> So for the a) case I think we'd still need the fuse_sync_writes() i=
n
> >>>>> case there's still pending writeback.
> >>>>>
> >>>>> Do you agree with this analysis or am I missing something here?
> >>>>
> >>>> Yeah, that's true.  But instead of calling fuse_sync_writes(), we ca=
n
> >>>> call filemap_wait_range() or something similar here.
> >>>>
> >>>
> >>> Agreed. Actually, the more I look at this, the more I think we can
> >>> replace all fuse_sync_writes() and get rid of it entirely.
> >>
> >>
> >> I have seen your latest reply that this cleaning up won't be included =
in
> >> this series, which is okay.
> >>
> >>
> >>> fuse_sync_writes() is called in:
> >>>
> >>> fuse_fsync():
> >>>         /*
> >>>          * Start writeback against all dirty pages of the inode, then
> >>>          * wait for all outstanding writes, before sending the FSYNC
> >>>          * request.
> >>>          */
> >>>         err =3D file_write_and_wait_range(file, start, end);
> >>>         if (err)
> >>>                 goto out;
> >>>
> >>>         fuse_sync_writes(inode);
> >>>
> >>>         /*
> >>>          * Due to implementation of fuse writeback
> >>>          * file_write_and_wait_range() does not catch errors.
> >>>          * We have to do this directly after fuse_sync_writes()
> >>>          */
> >>>         err =3D file_check_and_advance_wb_err(file);
> >>>         if (err)
> >>>                 goto out;
> >>>
> >>>
> >>>       We can get rid of the fuse_sync_writes() and
> >>> file_check_and_advance_wb_err() entirely since now without temp pages=
,
> >>> the file_write_and_wait_range() call actually ensures that writeback
> >>> is completed
> >>>
> >>>
> >>>
> >>> fuse_writeback_range():
> >>>         static int fuse_writeback_range(struct inode *inode, loff_t
> >>> start, loff_t end)
> >>>         {
> >>>                 int err =3D
> >>> filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
> >>>
> >>>                 if (!err)
> >>>                         fuse_sync_writes(inode);
> >>>
> >>>                 return err;
> >>>         }
> >>>
> >>>
> >>>       We can replace fuse_writeback_range() entirely with
> >>> filemap_write_and_wait_range().
> >>>
> >>>
> >>>
> >>> fuse_direct_io():
> >>>         if (fopen_direct_io && fc->direct_io_allow_mmap) {
> >>>                 res =3D filemap_write_and_wait_range(mapping, pos, po=
s +
> >>> count - 1);
> >>>                 if (res) {
> >>>                         fuse_io_free(ia);
> >>>                         return res;
> >>>                 }
> >>>         }
> >>>         if (!cuse && filemap_range_has_writeback(mapping, pos, (pos +
> >>> count - 1))) {
> >>>                 if (!write)
> >>>                         inode_lock(inode);
> >>>                 fuse_sync_writes(inode);
> >>>                 if (!write)
> >>>                         inode_unlock(inode);
> >>>         }
> >>>
> >>>
> >>>        I think this can just replaced with
> >>>                 if (fopen_direct_io && (fc->direct_io_allow_mmap || !=
cuse)) {
> >>>                         res =3D filemap_write_and_wait_range(mapping,
> >>> pos, pos + count - 1);
> >>>                         if (res) {
> >>>                                 fuse_io_free(ia);
> >>>                                 return res;
> >>>                         }
> >>>                 }
> >>
> >> Alright. But I would prefer doing this filemap_write_and_wait_range() =
in
> >> fuse_direct_write_iter() rather than fuse_direct_io() if possible.
> >>
> >>>        since for the !fopen_direct_io case, it will already go throug=
h
> >>> filemap_write_and_wait_range(), as you mentioned in your previous
> >>> message. I think this also fixes a bug (?) in the original code - in
> >>> the fopen_direct_io && !fc->direct_io_allow_mmap case, I think we
> >>> still need to write out dirty pages first, which we don't currently
> >>> do.
> >>
> >> Nope.  In case of fopen_direct_io && !fc->direct_io_allow_mmap, there
> >> won't be any page cache at all, right?
> >>
> >
> > Isn't there still a page cache if the file was previously opened
> > without direct io and then the client opens another handle to that
> > file with direct io? In that case, the pages could still be dirty in
> > the page cache and would need to be written back first, no?
>
> Do you mean that when the inode is firstly opened, FOPEN_DIRECT_IO is
> not set by the FUSE server, while it is secondly opened, the flag is set?
>
> Though the behavior of the FUSE daemon is quite confusing in this case,
> it is completely possible in real life.  So yes we'd better add
> filemap_write_and_wait_range() unconditionally in fopen_direct_io case.
>

I think this behavior on the server side is pretty common. From what
I've seen on most servers, the server when handling the open sets
fi->direct_io depending on if the client opens with O_DIRECT, eg

        if (fi->flags & O_DIRECT)
                fi->direct_io =3D 1;

If a client opens a file without O_DIRECT and then opens the same file
with O_DIRECT, then we run into this case. Though I'm not sure how
common it generally is for clients to do this.

Thanks,
Joanne
>
> --
> Thanks,
> Jingbo

