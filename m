Return-Path: <linux-fsdevel+bounces-46213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0BA8476A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 17:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C9B19E4ED3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 15:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200D91E98FA;
	Thu, 10 Apr 2025 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR1l9WsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780BD1E8356
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297663; cv=none; b=oKsTT7aGWURP7qchvXv5rPXRXny0/OEEbyLtt57dQeAjVz1QRAKvdsNypNf0D6/uiUHdZbE5crU+ItEqxUi10xmut+PZtwvZwsK28xn/Qxk8gf36s0NhM6n56rdsfMp5L7fdeDicv9ctEjaXxSMgqAnkQxLaIjycCmN2sCoCTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297663; c=relaxed/simple;
	bh=XEkIMvxEz8UKT+Rz7b9x0y/NlOOKeDsZ4K4tv4EVOaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfS5LdQNnqbJXwS3GhPRgw0vXkXO5ci/Xaz/cnrUEZKJvjBoCfNn+gLKHjc8xR8apNHRr9j06JLZFU+DLJ/hY2v5kwSHpA+B0iMw7jkmv116780VgzsPAhJbH6qe6BWP4znFT94PoSwcuBzbZOS48uZP2RwNsfrtYHvM1JXulLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR1l9WsV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54d42884842so263133e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744297659; x=1744902459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnneFsSBHQjs5Y+8keCO9raiB8uFLlirdcef9i/OwQA=;
        b=aR1l9WsVcd3BS8PrcdF4C2dhJ8gzvIX4dckoSNBiyg98GrhivNvGbLlykdMju7qSxl
         HsVIo828zwWjtK6i1FXFveRbzDMG0E5koz5sqthGjzitdvIQ8DgtORP0Y8QfjlDFKc2z
         Y4Mfct8lRXTc8qzX0C+wIt8UtbpbwcsDwBNLcjelCIsgHcmJ7MySLABWYrFYnRWVcODG
         Eg4wvKU5I3uYHfrJc6ZnlVzyNWwXVP+aesaErsrCUDkeHQZNJwOJ0eQKshIVgnb0pJUH
         1Nhc6TWp8fyBL4abQq1XLmZcus0d7Zh9UssN/y6GmCzaXTHu3PNqaZMVBeJp6z13F7wl
         wcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744297659; x=1744902459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnneFsSBHQjs5Y+8keCO9raiB8uFLlirdcef9i/OwQA=;
        b=Z8kNuvg1SzV7JZBmK51zI5Q7qLlrzqA4X1aol+wYN8o1P2hcBXpCqHyCQZabFvqyMP
         bxXlo2rVIUdZ5fbhA2neiZDEL1u47/1/xkEJx45rYqjOEokNV6+ziinMv8jx2zf7x4ls
         2GQdtayjlJgn1FN8Azo08b9lVQmA9eub9mWgzHc5Fq+VNaFb2O+cEeGdddexQDE4LYED
         2EO3t4nY1gp2KPfeiRfsM25E0u7ZbQ2h7wsc7uCCOb/0GFe8Y7Hjt3gXqKCc6S4yF+aH
         JQ9fDzncKflV+6rM0nWwr7wKx4cJZebdmecAEmPHB3CBaswBiUp0nAANsRv3MsfMY54p
         5TOw==
X-Forwarded-Encrypted: i=1; AJvYcCWtVKP+5nIvzHbbgFE+18j5jNzpSDK6K0frknm8PKLNAQ/fQuTNxu6arh2LnF5E4JXk9dWMkl4UrMW6UI3Y@vger.kernel.org
X-Gm-Message-State: AOJu0YygskNbYDEV1Qwg4HClsrXQjHIF9pu24YGZ43wR91iMu+k74sh2
	iuHEyTQXrsfw2Ih2ZgJNPwylRS3DYjaEw4JXpu5hTrdtOIFqB9fRq7GUBZOsE/W3fsXkeq5oGRF
	tsHfWHS/N2egFv2BP1XrW8PkdhXQ=
X-Gm-Gg: ASbGncsVxORoW4rwd9B/1tKlf+IS0jWpnampGYtc9lVDOnyaHbp4UCTbfj75U0lDV2J
	6iNVbuFpjrgiWVKvZv8C3bQYqZySfTaEs6Wns5NhpZbcFlBESlhY+NkFSP5JUYhEm9dy8ocKMt+
	DviMdkGX20TxsyHXZPj5EPzzcoD+fmegtm
X-Google-Smtp-Source: AGHT+IHRtUYNWUNxDzi4/nSfOt7OrVyYp8hLoKm65hQ1sGNELiu2MmmusPeAcCf+CDu76CeULym1+xQDETP1rC9STGs=
X-Received: by 2002:a05:6512:238c:b0:549:4e79:d4c0 with SMTP id
 2adb3069b0e04-54cb689a69dmr940995e87.53.1744297658890; Thu, 10 Apr 2025
 08:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-4-joannelkoong@gmail.com> <db4f1411-f6de-4206-a6a3-5c9cf6b6d59d@linux.alibaba.com>
 <CAJnrk1bTGFXy+ZTchC7p4OYUnbfKZ7TtVkCsrsv87Mg1r8KkGA@mail.gmail.com> <7e9b1a40-4708-42a8-b8fc-44fa50227e5b@linux.alibaba.com>
In-Reply-To: <7e9b1a40-4708-42a8-b8fc-44fa50227e5b@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 10 Apr 2025 08:07:22 -0700
X-Gm-Features: ATxdqUH1Oqc5Eyd8iLIPoAOljO4GF5V74mMh2sLenANHKIAzSIQEix_4HUbWNKs
Message-ID: <CAJnrk1Z7Wi_KPe_TJckpYUVhv9mKX=-YTwaoQRgjT2z0fxD-7g@mail.gmail.com>
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

On Wed, Apr 9, 2025 at 7:12=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
>
>
> On 4/10/25 7:47 AM, Joanne Koong wrote:
> >   On Tue, Apr 8, 2025 at 7:43=E2=80=AFPM Jingbo Xu <jefflexu@linux.alib=
aba.com> wrote:
> >>
> >> Hi Joanne,
> >>
> >> On 4/5/25 2:14 AM, Joanne Koong wrote:
> >>> In the current FUSE writeback design (see commit 3be5a52b30aa
> >>> ("fuse: support writable mmap")), a temp page is allocated for every
> >>> dirty page to be written back, the contents of the dirty page are cop=
ied over
> >>> to the temp page, and the temp page gets handed to the server to writ=
e back.
> >>>
> >>> This is done so that writeback may be immediately cleared on the dirt=
y page,
> >>> and this in turn is done in order to mitigate the following deadlock =
scenario
> >>> that may arise if reclaim waits on writeback on the dirty page to com=
plete:
> >>> * single-threaded FUSE server is in the middle of handling a request
> >>>   that needs a memory allocation
> >>> * memory allocation triggers direct reclaim
> >>> * direct reclaim waits on a folio under writeback
> >>> * the FUSE server can't write back the folio since it's stuck in
> >>>   direct reclaim
> >>>
> >>> With a recent change that added AS_WRITEBACK_INDETERMINATE and mitiga=
tes
> >>> the situations described above, FUSE writeback does not need to use
> >>> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mapping=
s.
> >>>
> >>> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
> >>> and removes the temporary pages + extra copying and the internal rb
> >>> tree.
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
> >>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> >>> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> >>
> >
> > Hi Jingbo,
> >
> > Thanks for sharing your analysis for this.
> >
> >> Overall this patch LGTM.
> >>
> >> Apart from that, IMO the fi->writectr and fi->queued_writes mechanism =
is
> >> also unneeded then, at least the DIRECT IO routine (i.e.
> >
> > I took a look at fi->writectr and fi->queued_writes and my
> > understanding is that we do still need this. For example, for
> > truncates (I'm looking at fuse_do_setattr()), I think we still need to
> > prevent concurrent writeback or else the setattr request and the
> > writeback request could race which would result in a mismatch between
> > the file's reported size and the actual data written to disk.
>
> I haven't looked into the truncate routine yet.  I will see it later.
>
> >
> >> fuse_direct_io()) doesn't need fuse_sync_writes() anymore.  That is
> >> because after removing the temp page, the DIRECT IO routine has alread=
y
> >> been waiting for all inflight WRITE requests, see
> >>
> >> # DIRECT read
> >> generic_file_read_iter
> >>   kiocb_write_and_wait
> >>     filemap_write_and_wait_range
> >
> > Where do you see generic_file_read_iter() getting called for direct io =
reads?
>
> # DIRECT read
> fuse_file_read_iter
>   fuse_cache_read_iter
>     generic_file_read_iter
>       kiocb_write_and_wait
>        filemap_write_and_wait_range
>       a_ops->direct_IO(),i.e. fuse_direct_IO()
>

Oh I see, I thought files opened with O_DIRECT automatically call the
.direct_IO handler for reads/writes but you're right, it first goes
through .read_iter / .write_iter handlers, and the .direct_IO handler
only gets invoked through generic_file_read_iter() /
generic_file_direct_write() in mm/filemap.c

There's two paths for direct io in FUSE:
a) fuse server sets fi->direct_io =3D true when a file is opened, which
will set the FOPEN_DIRECT_IO bit in ff->open_flags on the kernel side
b) fuse server doesn't set fi->direct_io =3D true, but the client opens
the file with O_DIRECT

We only go through the stack trace you listed above for the b) case.
For the a) case, we'll hit

        if (ff->open_flags & FOPEN_DIRECT_IO)
                return fuse_direct_read_iter(iocb, to);

and

        if (ff->open_flags & FOPEN_DIRECT_IO)
                return fuse_direct_write_iter(iocb, from);

which will invoke fuse_direct_IO() / fuse_direct_io() without going
through the kiocb_write_and_wait() -> filemap_write_and_wait_range() /
kiocb_invalidate_pages() -> filemap_write_and_wait_range() you listed
above.

So for the a) case I think we'd still need the fuse_sync_writes() in
case there's still pending writeback.

Do you agree with this analysis or am I missing something here?

>
> > Similarly, where do you see generic_file_write_iter() getting called
> > for direct io writes?
>
> # DIRECT read
> fuse_file_write_iter
>   fuse_cache_write_iter
>     generic_file_write_iter
>       generic_file_direct_write
>         kiocb_invalidate_pages
>          filemap_invalidate_pages
>            filemap_write_and_wait_range
>       a_ops->direct_IO(),i.e. fuse_direct_IO()
>
>
> > Where do you see fi->writectr / fi->queued-writes preventing this
> > race?
>
> IMO overall fi->writectr / fi->queued-writes are introduced to prevent
> DIRECT IO and writeback from sending duplicate (inflight) WRITE requests
> for the same page.
>
> For the DIRECT write routine:
>
> # non-FOPEN_DIRECT_IO DIRECT write
> fuse_cache_write_iter
>   fuse_direct_IO
>     fuse_direct_io
>       fuse_sync_writes
>
>
> # FOPEN_DIRECT_IO DIRECT write
> fuse_direct_write_iter
>   fuse_direct_IO
>     fuse_direct_io
>       fuse_sync_writes
>
>
> For the writeback routine:
> fuse_writepages()
>   fuse_writepages_fill
>     fuse_writepages_send
>       # buffer the WRITE request in queued_writes list
>       fuse_flush_writepages
>         # flush WRITE only when fi->writectr >=3D 0
>
>
>
> > It looks to me like in the existing code, this race condition
> > you described of direct write invalidating the page cache, then
> > another buffer write reads the page cache and dirties it, then
> > writeback is called on that, and the 2 write requests racing, could
> > still happen?
> >
> >
> >> However it seems that the writeback
> >> won't wait for previous inflight DIRECT WRITE requests, so I'm not muc=
h
> >> sure about that.  Maybe other folks could offer more insights...
> >
> > My understanding is that these lines
> >
> > if (!cuse && filemap_range_has_writeback(...)) {
> >    ...
> >    fuse_sync_writes(inode);
> >    ...
> > }
> >
> > in fuse_direct_io() is what waits on previous inflight direct write
> > requests to complete before the direct io happens.
>
> Right.
>
> >
> >
> >>
> >> Also fuse_sync_writes() is not needed in fuse_flush() anymore, with
> >> which I'm pretty sure.
> >
> > Why don't we still need this for fuse_flush()?
> >
> > If a caller calls close(), this will call
> >
> > filp_close()
> >   filp_flush()
> >       filp->f_op->flush()
> >           fuse_flush()
> >
> > it seems like we should still be waiting for all writebacks to finish
> > before sending the fuse server the fuse_flush request, no?
> >
>
> filp_close()
>    filp_flush()
>        filp->f_op->flush()
>            fuse_flush()
>              write_inode_now
>                 writeback_single_inode(WB_SYNC_ALL)
>                   do_writepages
>                     # flush dirty page
>                   filemap_fdatawait
>                     # wait for WRITE completion

Nice. I missed that write_inode_now() will invoke filemap_fdatawait().
This seems pretty straightforward. I'll remove the fuse_sync_writes()
call in fuse_flush() when I send out v8.

The direct io one above is less straight-forward. I won't add that to
v8 but that can be done in a separate future patch when we figure that
out.

Thanks,
Joanne

>
> >>
> >>> ---
> >>>  fs/fuse/file.c   | 360 ++++-----------------------------------------=
--
> >>>  fs/fuse/fuse_i.h |   3 -
> >>>  2 files changed, 28 insertions(+), 335 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >>> index 754378dd9f71..91ada0208863 100644
> >>> --- a/fs/fuse/file.c
> >>> +++ b/fs/fuse/file.c
> >>> @@ -415,89 +415,11 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl=
_owner_t id)
> >>>
> >>>  struct fuse_writepage_args {
> >>>       struct fuse_io_args ia;
> >>> -     struct rb_node writepages_entry;
> >>>       struct list_head queue_entry;
> >>> -     struct fuse_writepage_args *next;
> >>>       struct inode *inode;
> >>>       struct fuse_sync_bucket *bucket;
> >>>  };
> >>>
> >>> -static struct fuse_writepage_args *fuse_find_writeback(struct fuse_i=
node *fi,
> >>> -                                         pgoff_t idx_from, pgoff_t i=
dx_to)
> >>> -{
> >>> -     struct rb_node *n;
> >>> -
> >>> -     n =3D fi->writepages.rb_node;
> >>> -
> >>> -     while (n) {
> >>> -             struct fuse_writepage_args *wpa;
> >>> -             pgoff_t curr_index;
> >>> -
> >>
> >> --
> >> Thanks,
> >> Jingbo
>
> --
> Thanks,
> Jingbo

