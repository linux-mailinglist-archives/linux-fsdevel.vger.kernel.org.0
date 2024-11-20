Return-Path: <linux-fsdevel+bounces-35364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D46CF9D43A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 22:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527991F22038
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 21:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92BD1AF0A1;
	Wed, 20 Nov 2024 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY8vvy7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824113D897
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732139616; cv=none; b=L2EomEnSCE7HQYzdu81ulSXjADdpiJayrJX5BvIAfU+sCFyHP3uNruyGUHVeuGrZy04BXFprjsiQG4tEMuVxOwGHbsykKcuJdA49yDjb3UTztGYI8yCNYcmkcOG1BnEqsVqUGRpQ7pDWTdT7M27wZRD58QisjCyY3o9xT7Am0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732139616; c=relaxed/simple;
	bh=Cd5K41KkG5+C43a8cZpPBG6Tlh45gcAD91ytZYyWrd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWVG/bxPlGkKLKkvrXsmURqQ6GtzsmdwwOblthcMYcsupsXDCVYW/LLpBnW3oU//dwCfCkrLUz3wfwkYgfDvswZTZN+njMDZiN2ekIl+ItMLonUUhXpNwV5/EpT5Zai1xmtTYMJxvmCJ+lUD00AXmTfV3rei4fYd1duAibpaM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EY8vvy7P; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-514589ac56dso123308e0c.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 13:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732139613; x=1732744413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNqRnLkdM/MKN7Sbep9kEEBFrTQCIKbfDVRooqcVko8=;
        b=EY8vvy7P0md9LeLcYgA6lfFDtZQTCLgmTsVvH7dsqRUBnvINkg4V1t7+wZ2clt9V5t
         nZCV5bWwRySSf2DELZKbaHOFujOx2GZK00xKhd8qOgVgA89vvCi7IkTm+GG3++D3KqDJ
         HtcTdttHcZ8mJp6I3MPWJi+Rak8dHJvd2EGIoTPv3lVv6UeoFJtSsCwaelJcsEfVPlUL
         A5J1e2hPTIT/sl26I9tMkCPhXdSeNqUE8qJ3tSGJFGr0gNMA8LGyJVURht3jcgzRkeuZ
         +kKHld39bfbwI1BoGingz94GSFWDhTb0TbCkasTT16c2S8jA3LLNB6rx30cE1I0s6dbx
         gICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732139613; x=1732744413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNqRnLkdM/MKN7Sbep9kEEBFrTQCIKbfDVRooqcVko8=;
        b=L+dOQNGdt9YU3swK+QV3GYkH/bxIod1Olp8IzCeFVRuVM6Q9lBUWLVDqR4oMN0c77E
         Kyc7m4dZbC0k705wvDQy0CDchCUY8IwjvvoRrMrucsdhmFSDHkdTopbtoImDKMjRC1uz
         X5A8PC7SqQwThMNb0MYL5SOylJWR7/aPJ6lRWCXzuQl1FcCUzLPnyrmTHOpUqkLPNSsC
         kf3TSbF5t/ue9ZfD/PoUvg9L7uPUYt4FBhMktFPsCRsn3+Ar/Go21gtS9Rb35IzJwp/2
         2yPGkKqq1th0XLbigM8nixxNjnK3OszAQZX/P70M4yRM+n5guEivvK1H59eWQ69tKu6K
         F4+A==
X-Forwarded-Encrypted: i=1; AJvYcCW3EP4SjyVlQGScxEfIxC0/u6ux/JUI2zpc5QU4CCiKHaFyFLsw6H1PWBHWjrVlgIXluu4mSv22xu+QvCP2@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAjsZm5j3UQMzD9uzlvmjOGApYCZPQBszI1gRH+sxH855j+82
	R4xVMWfkXGU8mHkhOp7xr1WrECbE7q3aq+xG8D4ez8sHpJceEOqHXAnyit67T8UA/7HNgRRoHGw
	ccl6+t67dgSRX/IYNApgS6nnqz/U=
X-Google-Smtp-Source: AGHT+IFSgJi24wLaX+gTeo0PZKH1fBVzpcPBaSH3lmAcHsg4m1cvDTt/W9SIKJP9VDnUS2p7iECfvEcaPEq44ffTg3w=
X-Received: by 2002:a05:6102:3ec4:b0:4ad:48f4:8be1 with SMTP id
 ada2fe7eead31-4adaf60e2d5mr4213082137.25.1732139613318; Wed, 20 Nov 2024
 13:53:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115224459.427610-1-joannelkoong@gmail.com>
 <20241115224459.427610-6-joannelkoong@gmail.com> <cad4a8b3-8065-4187-875f-1810263b988c@linux.alibaba.com>
In-Reply-To: <cad4a8b3-8065-4187-875f-1810263b988c@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 20 Nov 2024 13:53:22 -0800
Message-ID: <CAJnrk1aiNZM_JhCwNX+XCdBWsqWxujLi3sUYaQEuN-qnA2gneQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 1:56=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> On 11/16/24 6:44 AM, Joanne Koong wrote:
> > In the current FUSE writeback design (see commit 3be5a52b30aa
> > ("fuse: support writable mmap")), a temp page is allocated for every
> > dirty page to be written back, the contents of the dirty page are copie=
d over
> > to the temp page, and the temp page gets handed to the server to write =
back.
> >
> > This is done so that writeback may be immediately cleared on the dirty =
page,
> > and this in turn is done for two reasons:
> > a) in order to mitigate the following deadlock scenario that may arise
> > if reclaim waits on writeback on the dirty page to complete:
> > * single-threaded FUSE server is in the middle of handling a request
> >   that needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback
> > * the FUSE server can't write back the folio since it's stuck in
> >   direct reclaim
> > b) in order to unblock internal (eg sync, page compaction) waits on
> > writeback without needing the server to complete writing back to disk,
> > which may take an indeterminate amount of time.
> >
> > With a recent change that added AS_WRITEBACK_INDETERMINATE and mitigate=
s
> > the situations described above, FUSE writeback does not need to use
> > temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mappings.
> >
> > This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
> > and removes the temporary pages + extra copying and the internal rb
> > tree.
> >
> > fio benchmarks --
> > (using averages observed from 10 runs, throwing away outliers)
> >
> > Setup:
> > sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
> >  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=3D4=
 -o source=3D~/tmp_mount ~/fuse_mount
> >
> > fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1k,4k,1M}=
 --size=3D2G
> > --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --directory=3D/roo=
t/fuse_mount
> >
> >         bs =3D  1k          4k            1M
> > Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> > After   341 MiB/s     2246 MiB/s     2685 MiB/s
> > % diff        -3%          23%         45%
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 339 +++----------------------------------------------
> >  1 file changed, 20 insertions(+), 319 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 88d0946b5bc9..56289ac58596 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1172,7 +1082,7 @@ static ssize_t fuse_send_write_pages(struct fuse_=
io_args *ia,
> >       int err;
> >
> >       for (i =3D 0; i < ap->num_folios; i++)
> > -             fuse_wait_on_folio_writeback(inode, ap->folios[i]);
> > +             folio_wait_writeback(ap->folios[i]);
> >
> >       fuse_write_args_fill(ia, ff, pos, count);
> >       ia->write.in.flags =3D fuse_write_flags(iocb);
> > @@ -1622,7 +1532,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, s=
truct iov_iter *iter,
> >                       return res;
> >               }
> >       }
> > -     if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
> > +     if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + cou=
nt - 1))) {
> >               if (!write)
> >                       inode_lock(inode);
> >               fuse_sync_writes(inode);
> > @@ -1825,7 +1735,7 @@ static void fuse_writepage_free(struct fuse_write=
page_args *wpa)
> >               fuse_sync_bucket_dec(wpa->bucket);
> >
> >       for (i =3D 0; i < ap->num_folios; i++)
> > -             folio_put(ap->folios[i]);
> > +             folio_end_writeback(ap->folios[i]);
>
> I noticed that if we folio_end_writeback() in fuse_writepage_finish()
> (rather than fuse_writepage_free()), there's ~50% buffer write
> bandwridth performance gain (5500MB -> 8500MB)[*]
>
> The fuse server is generally implemented in multi-thread style, and
> multi (fuse server) worker threads could fetch and process FUSE_WRITE
> requests of one fuse inode.  Then there's serious lock contention for
> the xarray lock (of the address space) when these multi worker threads
> call fuse_writepage_end->folio_end_writeback when they are sending
> replies of FUSE_WRITE requests.
>
> The lock contention is greatly alleviated when folio_end_writeback() is
> serialized with fi->lock.  IOWs in the current implementation
> (folio_end_writeback() in fuse_writepage_free()), each worker thread
> needs to compete for the xarray lock for 256 times (one fuse request can
> contain at most 256 pages if FUSE_MAX_MAX_PAGES is 256) when completing
> a FUSE_WRITE request.
>
> After moving folio_end_writeback() to fuse_writepage_finish(), each
> worker thread needs to compete for fi->lock only once.  IOWs the locking
> granularity is larger now.
>

Interesting! Thanks for sharing. Are you able to consistently repro
these results and on different machines? When I run it locally on my
machine using the commands you shared, I'm seeing roughly the same
throughput:

Current implementation (folio_end_writeback() in fuse_writepage_free()):
  WRITE: bw=3D385MiB/s (404MB/s), 385MiB/s-385MiB/s (404MB/s-404MB/s),
io=3D113GiB (121GB), run=3D300177-300177msec
  WRITE: bw=3D384MiB/s (403MB/s), 384MiB/s-384MiB/s (403MB/s-403MB/s),
io=3D113GiB (121GB), run=3D300178-300178msec

fuse_end_writeback() in fuse_writepage_finish():
  WRITE: bw=3D387MiB/s (406MB/s), 387MiB/s-387MiB/s (406MB/s-406MB/s),
io=3D113GiB (122GB), run=3D300165-300165msec
  WRITE: bw=3D381MiB/s (399MB/s), 381MiB/s-381MiB/s (399MB/s-399MB/s),
io=3D112GiB (120GB), run=3D300143-300143msec

I wonder if it's because your machine is so much faster that lock
contention makes a difference for you whereas on my machine there's
other things that slow it down before lock contention comes into play.

I see your point about why it would make sense that having
folio_end_writeback() in fuse_writepage_finish() inside the scope of
the fi->lock could make it faster, but I also could see how having it
outside the lock could make it faster as well. I'm thinking about the
scenario where if there's 8 threads all executing
fuse_send_writepage() at the same time, calling folio_end_writeback()
outside the fi->lock would unblock other threads trying to get the
fi->lock and that other thread could execute while
folio_end_writeback() gets executed.

Looking at it some more, it seems like it'd be useful if there was
some equivalent api to folio_end_writeback() that takes in an array of
folios and would only need to grab the xarray lock once to clear
writeback on all the folios in the array.

When fuse supports large folios [*] this will help lock contention on
the xarray lock as well because there'll be less folio_end_writeback()
calls.

I'm happy to move the fuse_end_writeback() call to
fuse_writepage_finish() considering what you're seeing. 5500 Mb ->
8800 Mb is a huge perf improvement!

[*] https://lore.kernel.org/linux-fsdevel/20241109001258.2216604-1-joannelk=
oong@gmail.com/

>
>
> > @@ -2367,54 +2111,23 @@ static int fuse_writepages_fill(struct folio *f=
olio,
> >               data->wpa =3D NULL;
> >       }
> >
> > -     err =3D -ENOMEM;
> > -     tmp_folio =3D folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> > -     if (!tmp_folio)
> > -             goto out_unlock;
> > -
> > -     /*
> > -      * The page must not be redirtied until the writeout is completed
> > -      * (i.e. userspace has sent a reply to the write request).  Other=
wise
> > -      * there could be more than one temporary page instance for each =
real
> > -      * page.
> > -      *
> > -      * This is ensured by holding the page lock in page_mkwrite() whi=
le
> > -      * checking fuse_page_is_writeback().  We already hold the page l=
ock
> > -      * since clear_page_dirty_for_io() and keep it held until we add =
the
> > -      * request to the fi->writepages list and increment ap->num_folio=
s.
> > -      * After this fuse_page_is_writeback() will indicate that the pag=
e is
> > -      * under writeback, so we can release the page lock.
> > -      */
> >       if (data->wpa =3D=3D NULL) {
> >               err =3D -ENOMEM;
> >               wpa =3D fuse_writepage_args_setup(folio, data->ff);
> > -             if (!wpa) {
> > -                     folio_put(tmp_folio);
> > +             if (!wpa)
> >                       goto out_unlock;
> > -             }
> >               fuse_file_get(wpa->ia.ff);
> >               data->max_folios =3D 1;
> >               ap =3D &wpa->ia.ap;
> >       }
> >       folio_start_writeback(folio);
>
> There's also a lock contention for the xarray lock when calling
> folio_start_writeback().
>
> I also noticed a strange thing that, if we lock fi->lock and unlock
> immediately, the write bandwidth improves by 5% (8500MB -> 9000MB).  The

Interesting! By lock fi->lock and unlock immediately, do you mean
locking it, then unlocking it, then calling folio_start_writeback() or
locking it, calling folio_start_writeback() and then unlocking it?


Thanks,
Joanne

> palce where to insert the "locking fi->lock and unlocking" actually
> doesn't matter.  "perf lock contention" shows the lock contention for
> the xarray lock is greatly alleviated, though I can't understand how it
> is done quite well...
>
> As the performance gain is not significant (~5%), I think we can leave
> this stange phenomenon aside for now.
>
>
>
> [*] test case:
> ./passthrough_hp  --bypass-rw 2  /tmp /mnt
> (testbench mode in
> https://github.com/libfuse/libfuse/pull/807/commits/e83789cc6e83ca42ccc98=
99c4f7f8c69f31cbff9
> bypass the buffer copy along with the persistence procedure)
>
> fio -fallocate=3D0 -numjobs=3D32 -iodepth=3D1 -ioengine=3Dsync -sync=3D0
> --direct=3D0 -rw=3Dwrite -bs=3D1M -size=3D100G --time_based --runtime=3D3=
00
> -directory=3D/mnt/ --group_reporting --name=3DFio
> --
> Thanks,
> Jingbo

