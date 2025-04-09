Return-Path: <linux-fsdevel+bounces-46142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CEFA834D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E48D18875D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 23:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B428A21B9C3;
	Wed,  9 Apr 2025 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJdsKcdu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF91A5BA4
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242478; cv=none; b=Pb/V5J786f7Fpg22HEQi6L8vL7Dq2CJ8MV9YCiJjtcjjX5FrWB0jrb5UEwV01HP1F/la7ZbPAogzYIeFJkAaSV0D9k9PrHiUpU5MKa4Bq4hLpfezJnfnyOFs6P0YqCyRFH+s25biKKeIol5RoMK3Ug0iAky9zXfDToKUHKvX3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242478; c=relaxed/simple;
	bh=1FmwsXMbjbaY0ObMfp5u1Dj0t+XZbK6vM1XXjCH59hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iksQB9Mgf0DhqCEESJlwSsAT+y77ZNFW5JS++fSims+QaeDKgz/QzfmgevFNcYodkpQ8PUecf8QtkgQeHe6RBUkNJRuInND9q8Kgwd4IPHmIDwOdZmyG4VmMcsz7oqvmdNV7+suoK+mGPuVuH7Hkj5k5ePj2NakTD7kt9IDLk70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJdsKcdu; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4775ce8a4b0so3239011cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 16:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744242475; x=1744847275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sH6s526b/H/uV5A/JlFAjOiPD/1m+0j9a+DTV4AyZK8=;
        b=EJdsKcdu3HJ7HuJanuBW3QtN8wtCzj3GX5r/mRTB5+3L2l40+SA3tpmoQ8NH4T5bzm
         MvKcItUcUG9DIcXS1WhRXDxH22w5qjW2+GEuuSqPDHZwszqGan4vv7D7DPrV5kyw/aLM
         NQaNAPjwWzIhXVkU73Q3NY0KkccARn+HAMKzJGG/wc+WOINCP0OGmMC+uy4mRwJDrrWl
         FFgOMwkUijeV4ZB2s4vGv/UqxJSPnZEYBbeqQ4p+pHde5P2/pk9e7GWtSddfBVsYY/ZO
         mYdmZxMnM8W+Fg+TKXbT6cycYg94AjrYK0AgSNiBbFew56tP03bU3UuDUN9V56Gg+NMw
         k4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744242475; x=1744847275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sH6s526b/H/uV5A/JlFAjOiPD/1m+0j9a+DTV4AyZK8=;
        b=VyasH2sFQ092YgbStHmc0cszi/Ra6A+azvL6AizQINSUdxQSAz/j6fA0a5kcOg6Pbs
         H/ZbQwmO0xD/xdRF/L2HGNOezXI7rYmv9PQ757VBd1mkr/my0tXTcSKATJ1WWpxI/sxI
         e4aypSorKXhHf8OipsKWdMJAB4VtNOmponmsed123aN9YgoKreK3wsTVsPosW0ktGVOB
         AXphysSsVMLzInStXcwrTiZ9D7kAKWkd+XFwni0gbdyLzEHKBdeoEELPFs9B2DV8jCMD
         pGlraK77chAMoG7xjG9xQYMvC7BAqfkGGi8F6yFinrNbr9tIFUVn9zoC1C3cc7Yo8Q/4
         /dIA==
X-Forwarded-Encrypted: i=1; AJvYcCVhH/pU0lK3WwB1z9Tw9S4eWGcKB+GZNto/owCV2I8NgjLzT4OCklqZdLWpq6MEJMJ6qoPFvprgW7/9JLIP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yp/197rpglyvCmF+rf2lsBiO7EqYzsLfnhgsXmsy4DJ+9aZk
	/AJEj63NPFAazm5OFNPUjUcyjTozTq+52oNYC+D8P+EL1FDQi/vC6BMjCs6GBC087wKQMgjn44X
	r3De4zkDL5Bopvua+ZSoWPCfe4SU=
X-Gm-Gg: ASbGncuaROYofwVlkbbL8Ou9DuEyNOoar+TLWVA1Z8ycLbQ6pPel82+B/7wLX84YPtM
	TvRz/DqCjRzD64o8Bb45nzPXqR7fpLm2JQs0k/TuuLkqnl9HmC50AQYduNQFnwhyquVSZedjPgF
	o8D3dfUcNpO/exai0aN+w5rp/rYEnzpvyD6CPlyQ==
X-Google-Smtp-Source: AGHT+IERGk9wevWZ+l8YN4KmfhTtuWPlo1z7SWNtw+b0FP/EVbjZvk/hiqxi/Dtw/Rfy6TIJou3oyTAlEtYj4nRO3Rk=
X-Received: by 2002:a05:622a:302:b0:476:ad9d:d4f0 with SMTP id
 d75a77b69052e-4796cd2b6a5mr11020881cf.48.1744242475178; Wed, 09 Apr 2025
 16:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-4-joannelkoong@gmail.com> <db4f1411-f6de-4206-a6a3-5c9cf6b6d59d@linux.alibaba.com>
In-Reply-To: <db4f1411-f6de-4206-a6a3-5c9cf6b6d59d@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 9 Apr 2025 16:47:43 -0700
X-Gm-Features: ATxdqUH1fd4rusWjsAd3F0sRWY5U7a_9O4LHaVYFSacQdPCkdCpyUId4hSVdGBo
Message-ID: <CAJnrk1bTGFXy+ZTchC7p4OYUnbfKZ7TtVkCsrsv87Mg1r8KkGA@mail.gmail.com>
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

  On Tue, Apr 8, 2025 at 7:43=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
>
> Hi Joanne,
>
> On 4/5/25 2:14 AM, Joanne Koong wrote:
> > In the current FUSE writeback design (see commit 3be5a52b30aa
> > ("fuse: support writable mmap")), a temp page is allocated for every
> > dirty page to be written back, the contents of the dirty page are copie=
d over
> > to the temp page, and the temp page gets handed to the server to write =
back.
> >
> > This is done so that writeback may be immediately cleared on the dirty =
page,
> > and this in turn is done in order to mitigate the following deadlock sc=
enario
> > that may arise if reclaim waits on writeback on the dirty page to compl=
ete:
> > * single-threaded FUSE server is in the middle of handling a request
> >   that needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback
> > * the FUSE server can't write back the folio since it's stuck in
> >   direct reclaim
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
> > Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > Acked-by: Miklos Szeredi <mszeredi@redhat.com>
>

Hi Jingbo,

Thanks for sharing your analysis for this.

> Overall this patch LGTM.
>
> Apart from that, IMO the fi->writectr and fi->queued_writes mechanism is
> also unneeded then, at least the DIRECT IO routine (i.e.

I took a look at fi->writectr and fi->queued_writes and my
understanding is that we do still need this. For example, for
truncates (I'm looking at fuse_do_setattr()), I think we still need to
prevent concurrent writeback or else the setattr request and the
writeback request could race which would result in a mismatch between
the file's reported size and the actual data written to disk.

> fuse_direct_io()) doesn't need fuse_sync_writes() anymore.  That is
> because after removing the temp page, the DIRECT IO routine has already
> been waiting for all inflight WRITE requests, see
>
> # DIRECT read
> generic_file_read_iter
>   kiocb_write_and_wait
>     filemap_write_and_wait_range

Where do you see generic_file_read_iter() getting called for direct io read=
s?

For direct io reads, I'm only seeing

fuse_direct_IO()
  __fuse_direct_read()
    fuse_direct_io()

and

fuse_file_read_iter()
    fuse_direct_read_iter()
        fuse_direct_IO() / __fuse_direct_read()

>
> # DIRECT write
> generic_file_write_iter
>   generic_file_direct_write
>     kiocb_invalidate_pages
>       filemap_invalidate_pages
>         filemap_write_and_wait_range

Similarly, where do you see generic_file_write_iter() getting called
for direct io writes?
My understanding is that it'd either go through fuse_file_write_iter()
-> fuse_direct_write_iter() or through the fuse_direct_IO() callback.

>
> The DIRECT write routine will also invalidate the page cache in the
> range that is written to, so that the following buffer write needs to
> read the page cache back first. The writeback following the buffer write
> is much likely after the DIRECT write, so that the writeback won't
> conflict with the DIRECT write (i.e. there won't be duplicate WRITE
> requests for the same page that are initiated from DIRECT write and
> writeback at the same time), which is exactly why fi->writectr and
> fi->queued_writes are introduced.

Where do you see fi->writectr / fi->queued-writes preventing this
race? It looks to me like in the existing code, this race condition
you described of direct write invalidating the page cache, then
another buffer write reads the page cache and dirties it, then
writeback is called on that, and the 2 write requests racing, could
still happen?


> However it seems that the writeback
> won't wait for previous inflight DIRECT WRITE requests, so I'm not much
> sure about that.  Maybe other folks could offer more insights...

My understanding is that these lines

if (!cuse && filemap_range_has_writeback(...)) {
   ...
   fuse_sync_writes(inode);
   ...
}

in fuse_direct_io() is what waits on previous inflight direct write
requests to complete before the direct io happens.


>
> Also fuse_sync_writes() is not needed in fuse_flush() anymore, with
> which I'm pretty sure.

Why don't we still need this for fuse_flush()?

If a caller calls close(), this will call

filp_close()
  filp_flush()
      filp->f_op->flush()
          fuse_flush()

it seems like we should still be waiting for all writebacks to finish
before sending the fuse server the fuse_flush request, no?

>
> The potential cleanup for fi->writectr and fi->queued_writes could be
> offered as following separate patches (if any).
>

Thanks,
Joanne
>
> > ---
> >  fs/fuse/file.c   | 360 ++++-------------------------------------------
> >  fs/fuse/fuse_i.h |   3 -
> >  2 files changed, 28 insertions(+), 335 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 754378dd9f71..91ada0208863 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -415,89 +415,11 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_o=
wner_t id)
> >
> >  struct fuse_writepage_args {
> >       struct fuse_io_args ia;
> > -     struct rb_node writepages_entry;
> >       struct list_head queue_entry;
> > -     struct fuse_writepage_args *next;
> >       struct inode *inode;
> >       struct fuse_sync_bucket *bucket;
> >  };
> >
> > -static struct fuse_writepage_args *fuse_find_writeback(struct fuse_ino=
de *fi,
> > -                                         pgoff_t idx_from, pgoff_t idx=
_to)
> > -{
> > -     struct rb_node *n;
> > -
> > -     n =3D fi->writepages.rb_node;
> > -
> > -     while (n) {
> > -             struct fuse_writepage_args *wpa;
> > -             pgoff_t curr_index;
> > -
>
> --
> Thanks,
> Jingbo

