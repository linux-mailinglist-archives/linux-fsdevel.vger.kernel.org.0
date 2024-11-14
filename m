Return-Path: <linux-fsdevel+bounces-34836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E7E9C91A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 19:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C17BB31BFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 18:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A6198E81;
	Thu, 14 Nov 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxfstF/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BAF1925BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608391; cv=none; b=JAEFWmglqAy6spfi4VeePFIE0jnYkR1uOBmH879kkDtNIofSUesf4PNrFjbizl+bqNMuiRPoMUs0C+IBaH2Z8gGd2PxuSgbmdop0OX6x2zmg4AXrdwW21OhD49xsRhuiL0IXj4sG8pq6cX87wlyjlruK5PwPxt6BIXddXzr+SPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608391; c=relaxed/simple;
	bh=RupI1yUSJYi96hk6jQDPxCbMRMfKggmctUs8CXvD6P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVy1qk8M5NvHHdDrTo/YPtAnsv0VngBWlb4srcgo/1KWIdJnKFxEauniu07WnBiwmHGYMYeS6Xc9upvByE6NEPUMeYkOyug7ad+cQh1aVcGtv1X/IIEJ2JmaZKA/xk5uAt5rTSqRPqC++UEWjWxIEWZjHeCdlVdETj/o3YzK1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxfstF/Y; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460af1a1154so5823011cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 10:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731608388; x=1732213188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQmTHDuEtoYVL2J2etb8ouHOFXYwfhcn0IXo14bDCmA=;
        b=PxfstF/YXcH22Z5GkERlPEYvaZKeHNvBOI8gE2PU/jRsrRdKFJzY36AXjw+Zw4dpg+
         y4YQ2w32ZF1/goUstmPM8fYdcV17Emwe/Uz5nRg7agilb05DjAov+Znezp7r0BMLVVU7
         f4hrUCwT2KQHsVpPZvLvHpmVm+mandsjpCJS1i9U4QdHJXmiuVGtl8Eb0NX++MmMTTon
         Fu7LeXIhGliq9dexq6UvK3RV05WPL8TcBcBtaE7DOPlik9y+9KxCxkcmmF50pJuuVdRh
         ywd1k9mkLOgX7dsDeRbN3oM2dWlbAeigbOJpcPbRNBzu11RdCIF4o84mYvJts2mEWy47
         zj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731608388; x=1732213188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQmTHDuEtoYVL2J2etb8ouHOFXYwfhcn0IXo14bDCmA=;
        b=s6oC9aerFk3Gf+8zn5NX3GNhiBS0DXXcPoyGuCQCYxCeB6bkBgqimOtXFPF9gxc1nV
         JYWwxUQDoZg6vSC4AdGp5S+NCdjHpulFsZvB6Y3Z4dHUavBrwK31wJgI1qoc2nwoXqeC
         SNzCSP7+zxRQP7ypacwerloU9okcgG5IeicgkgXZIMvKhS3wVhJHidW6NMH8ja1EDxpJ
         GVa5mle/xWn8XEvja0csYnZJ+BekZTcqgl2VvCpxIBr1qxrJ1sutVTXpy+qN0GGMGPeV
         QruKGvyZFdxzuY3rt4T5WsrelVtLoZuvrcdZxsSnT6F1FZMy9meDACqPjG/DHKxOcuwu
         eFDA==
X-Forwarded-Encrypted: i=1; AJvYcCXBw/NkR4aYhZGnDkWTXeH8WEXcFIxOpxwZW51m7T1qC1QVRglDIMruocbd+jkKeqjZYcGqFQFxW0UcsnIY@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+PFchW9REMvE52k2YtuPhBNO6UQwRV2x0tSGcGKCRxP/UkhF
	cy0JFAXNedrAu/3I1EnOVk1pYyCLu/3LSHYOpz3AJgjgdY7FeLw3o066MKFkvqAh1bak38TfkSY
	QIynHJ3JQKcnqLmpYkNjvhC4I/Bk=
X-Google-Smtp-Source: AGHT+IGQww8gmC2Pzz5s2vUBPlXM6kYc+70EQ9eTZNXhBo9J8EpEQU9p/KGYbYMkSA7AmfcTN43Bn88giUGrvqr0ogI=
X-Received: by 2002:a05:622a:5b94:b0:447:e769:76fc with SMTP id
 d75a77b69052e-4634b537fffmr90511671cf.34.1731608388309; Thu, 14 Nov 2024
 10:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-7-joannelkoong@gmail.com> <e85bd643-894e-4eb2-994b-62f0d642b4f1@linux.alibaba.com>
 <CAJnrk1bS6J9NXae5bXTF+MrKV2VZ-2bi=WqkyY1XY2BggA01TQ@mail.gmail.com> <47661fe5-8616-4133-8d9c-faeb1ab96962@linux.alibaba.com>
In-Reply-To: <47661fe5-8616-4133-8d9c-faeb1ab96962@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 14 Nov 2024 10:19:37 -0800
Message-ID: <CAJnrk1Y+CZq5uL72kp1vXxF4Vf1kf+Nk_oGmYFHA8b-uw2gfgQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:47=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 11/14/24 8:39 AM, Joanne Koong wrote:
> > On Tue, Nov 12, 2024 at 1:25=E2=80=AFAM Jingbo Xu <jefflexu@linux.aliba=
ba.com> wrote:
> >>
> >> Hi Joanne,
> >>
> >> On 11/8/24 7:56 AM, Joanne Koong wrote:
> >>> Currently, we allocate and copy data to a temporary folio when
> >>> handling writeback in order to mitigate the following deadlock scenar=
io
> >>> that may arise if reclaim waits on writeback to complete:
> >>> * single-threaded FUSE server is in the middle of handling a request
> >>>   that needs a memory allocation
> >>> * memory allocation triggers direct reclaim
> >>> * direct reclaim waits on a folio under writeback
> >>> * the FUSE server can't write back the folio since it's stuck in
> >>>   direct reclaim
> >>>
> >>> To work around this, we allocate a temporary folio and copy over the
> >>> original folio to the temporary folio so that writeback can be
> >>> immediately cleared on the original folio. This additionally requires=
 us
> >>> to maintain an internal rb tree to keep track of writeback state on t=
he
> >>> temporary folios.
> >>>
> >>> A recent change prevents reclaim logic from waiting on writeback for
> >>> folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
> >>> This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
> >>> will prevent FUSE folios from running into the reclaim deadlock descr=
ibed
> >>> above) and removes the temporary folio + extra copying and the intern=
al
> >>> rb tree.
> >>>
> >>> fio benchmarks --
> >>> (using averages observed from 10 runs, throwing away outliers)
> >>>
> >>> Setup:
> >>> sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
> >>>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=
=3D4 -o source=3D~/tmp_mount ~/fuse_mount
> >>>
> >>> fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1k,4k,1=
M} --size=3D2G
> >>> --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --directory=3D/r=
oot/fuse_mount
> >>>
> >>>         bs =3D  1k          4k            1M
> >>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> >>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
> >>> % diff        -3%          23%         45%
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>
> >> I think there are some places checking or waiting for writeback could =
be
> >> reconsidered if they are still needed or not after we dropping the tem=
p
> >> page design.
> >>
> >> As they are inherited from the original implementation, at least they
> >> are harmless.  I think they could be remained in this patch, and could
> >> be cleaned up later if really needed.
> >>
> >
> > Thank you for the thorough inspection!
> >
> >>
> >>> @@ -891,7 +813,7 @@ static int fuse_do_readfolio(struct file *file, s=
truct folio *folio)
> >>>        * have writeback that extends beyond the lifetime of the folio=
.  So
> >>>        * make sure we read a properly synced folio.
> >>>        */
> >>> -     fuse_wait_on_folio_writeback(inode, folio);
> >>> +     folio_wait_writeback(folio);
> >>
> >> I doubt if wait-on-writeback is needed here, as now page cache won't b=
e
> >> freed until the writeback IO completes.
> >>
> >> The routine attempts to free page cache, e.g. invalidate_inode_pages2(=
)
> >> (generally called by distributed filesystems when the file content has
> >> been modified from remote) or truncate_inode_pages() (called from
> >> truncate(2) or inode eviction) will wait for writeback completion (if
> >> any) before freeing page.
> >>
> >> Thus I don't think there's any possibility that .read_folio() or
> >> .readahead() will be called when the writeback has not completed.
> >>
> >
> > Great point. I'll remove this line and the comment above it too.
> >
> >>
> >>> @@ -1172,7 +1093,7 @@ static ssize_t fuse_send_write_pages(struct fus=
e_io_args *ia,
> >>>       int err;
> >>>
> >>>       for (i =3D 0; i < ap->num_folios; i++)
> >>> -             fuse_wait_on_folio_writeback(inode, ap->folios[i]);
> >>> +             folio_wait_writeback(ap->folios[i]);
> >>
> >> Ditto.
>
> Actually this is a typo and I originally meant that waiting for
> writeback in fuse_send_readpages() is unneeded as page cache won't be
> freed until the writeback IO completes.
>
> > -     wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first,=
 last));
> > +     filemap_fdatawait_range(inode->i_mapping, first, last);
>

Gotcha and agreed. I'll remove this wait from readahead().

>
> In fact the above waiting for writeback in fuse_send_write_pages() is
> needed.  The reason is as follows:
>
> >>
> >
> > Why did we need this fuse_wait_on_folio_writeback() even when we had
> > the temp pages? If I'm understanding it correctly,
> > fuse_send_write_pages() is only called for the writethrough case (by
> > fuse_perform_write()), so these folios would never even be under
> > writeback, no?
>
> I think mmap write could make the page dirty and the writeback could be
> triggered then.
>

Ohhh I see, thanks for the explanation.

> >
> >>
> >>
> >>>  static void fuse_writepage_args_page_fill(struct fuse_writepage_args=
 *wpa, struct folio *folio,
> >>> -                                       struct folio *tmp_folio, uint=
32_t folio_index)
> >>> +                                       uint32_t folio_index)
> >>>  {
> >>>       struct inode *inode =3D folio->mapping->host;
> >>>       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >>>
> >>> -     folio_copy(tmp_folio, folio);
> >>> -
> >>> -     ap->folios[folio_index] =3D tmp_folio;
> >>> +     folio_get(folio);
> >>
> >> I still think this folio_get() here is harmless but redundant.
> >>
> >> Ditto page cache won't be freed before writeback completes.
> >>
> >> Besides, other .writepages() implementaions e.g. iomap_writepages() al=
so
> >> doen't get the refcount when constructing the writeback IO.
> >>
> >
> > Point taken. I'll remove this then, since other .writepages() also
> > don't obtain a refcount.
> >
> >>
> >>> @@ -2481,7 +2200,7 @@ static int fuse_write_begin(struct file *file, =
struct address_space *mapping,
> >>>       if (IS_ERR(folio))
> >>>               goto error;
> >>>
> >>> -     fuse_wait_on_page_writeback(mapping->host, folio->index);
> >>> +     folio_wait_writeback(folio);
> >>
> >> I also doubt if wait_on_writeback() is needed here, as now there won't
> >> be duplicate writeback IOs for the same page.
> >
> > What prevents there from being a duplicate writeback write for the
> > same page? This is the path I'm looking at:
> >
> > ksys_write()
> >   vfs_write()
> >     new_sync_write()
> >        op->write_iter()
> >           fuse_file_write_iter()
> >             fuse_cache_write_iter()
> >                generic_file_write_iter()
> >                    __generic_file_write_iter()
> >                        generic_perform_write()
> >                            op->write_begin()
> >                                fuse_write_begin()
> >
> > but I'm not seeing where there's anything that prevents a duplicate
> > write from happening.
>
> I mean there won't be duplicate *writeback* rather than *write* for the
> same page.  You could write the page cache and make it dirty at the time
> when the writeback for the same page is still on going, as long as we
> can ensure that even when the page is dirtied again, there won't be a
> duplicate writeback IO for the same page when the previous writeback IO
> has not completed yet.
>

I think we still need this folio_wait_writeback() since we're calling
fuse_do_readfolio() and removing the folio_wait_writeback() from
fuse_do_readfolio(). else we could read back stale data if the
writeback hasn't gone through yet.
I think we could probably move the folio_wait_writeback() here in
fuse_write_begin() to be right before the fuse_do_readfolio() call and
skip waiting on writeback if we hit the "success" gotos.


Thanks,
Joanne
>
>
> --
> Thanks,
> Jingbo

