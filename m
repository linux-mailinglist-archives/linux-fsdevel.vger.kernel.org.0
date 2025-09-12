Return-Path: <linux-fsdevel+bounces-61136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4215B5577A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 22:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E807BC5F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6240D2C178D;
	Fri, 12 Sep 2025 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV6u0Isg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21F2BEFF5
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707809; cv=none; b=IUgDcLEdqvsXBaAs2pDn2DeKPOgb/6hiFr+7k09dikKX49H1hUGDye5sJSkNHFUMBc+vcFEdFCln7zM1OyOvk2Fj8pqdhXMg3utetZlwIE+sWAy9hFJ787G0g4EY+OfiDTGjKZQ0sTepfVuHmc/+oVXobGrIngTMqJ7t8g++yMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707809; c=relaxed/simple;
	bh=J7whkdgtw+r5eOooTlUKSxqksHF4jMLVv76DD83j+Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atkJyKXCxBGCs8A+pUQLr+x0nczUnTk4fpqbFYZuI1R6uDm5d6qtbl+B1zImsB+AY59swYSB+9lnq4/WW6gQ19YNeXY++wRxlhsYzSoOupbpRkqE7h1a0ShTDIeiU5sCwDVdDxoLFnbgWj2i8NHsQrQfOmSTcccIAV0Qt2+lgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV6u0Isg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b34a3a6f64so22227681cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757707807; x=1758312607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUvk3PQT9iJETVmI+H9Y57Sl5Dee/ugWdBMz2xir9FU=;
        b=DV6u0IsgVFNPqGtB+m+ojn3dj4gHL2UmDA1mE0/ukBtGUT2Cfz53LgCswjm/9J9/Bj
         nJwW0gPDkQPJ50F0nGWv6vtV7i95GejKrkoAaCtJrkugobKs5CEAvHFAGOnjb3mlLgg6
         obLjFQ/wquE5e6jJwUi6yNuZ4QCuIc/HqRsjvgLOnAQVUnKHzlg+mhEpUAvk+KFtyFih
         rv1wxxdC61fCWVORHBuTOwNSEspRnI6UZFoXRVpOVNsV+9cNCikTrnBv2Ogdv9U5bkKE
         TxgYH90afG37tIayKuUmsTDbkn3SmjuVZzvjzeHCblj7QyyL4UrASKWMUi7qg9Wo6diu
         RwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757707807; x=1758312607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUvk3PQT9iJETVmI+H9Y57Sl5Dee/ugWdBMz2xir9FU=;
        b=cZTQYFjOxAkNv4WtXjV5HVxm3nkQ4WdVXEh/MLL/DVqempBqyXqG9lGwAKwbx43Uo/
         1buZ5NhOQUp+XPEZgXgQrcBX/W7vvHmGpw4c8wUo8j3IL0NQ2qqTrLLKvfj0eOEEWjPY
         /+vY65kTPGXnPhFAhMivEgK4wbrA9Kq7FNCWJC9T62UFVMRmn8hmja7koLyyVK9HzIDl
         kGb0ajOZA/ju7zf/zyg4Nw4nIqFaveN7Wz5k2RVMBxm+qTBiK2I0Ygi25G9+zxIPR6eO
         FVT2neFZzHkElZH2hrQTjKpyP3E288Dyq+k3qi7w3bF+aFrhKhw7pR3x3iy/DB72gPAh
         uTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfnUuu9JJzRW66ebuWyawj49WIVY66gc5ipl/C1fSmTz6AC6S3sD4oFm1UyH3AwBvzOoBSq72qO/x/C9VT@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbTE2xKRfGgJ6TCRgYjQRo1yGVbkm0JNchInmlbXLKQrLGCWy
	QCb1jehR8k+E/Glt1L7QoNIzlgmGESiyrjKpPzanrSMk9hLMIdOVIyAlhohRoTXd8gJs+S7j7Pc
	It1zT+EoMe4BjHQ7zMemrr0NRDqQr4m4=
X-Gm-Gg: ASbGncuPDUjqJY1s5kgtmTAWpaqeGL3oyhJ79R7i2gp86Yda3QwWO9XYOYZXvSk+g3Q
	HR1RI/AEvYxVplsce6oQ7BBgTMNyMXp7EXYVTskvhsxXPcn9LnqyLQm5pYYk01vizUV4rKtDRLK
	vTMWewQxsiaZVqLUetujZj5Rs0USv6Hvj0tcLbk0D7bgouzmRPhs/I8Qem7jl9yDNP9+Vumjjqr
	FVKubZEfvSUmUZDCXsJwbZabOX03UT31HlHA1uBQONRUF/YLYGvkek8iF9c
X-Google-Smtp-Source: AGHT+IEWbv39vMnYlQ1SD0ZUhw0yLiTfWxsf26h64ZL6lZSTKK/c4qoFwMSw183eQ+ZBkoMKnWL15JY76Ze4fGknDs4=
X-Received: by 2002:a05:622a:1805:b0:4b7:5de6:a69 with SMTP id
 d75a77b69052e-4b77d097ca4mr48388851cf.30.1757707806462; Fri, 12 Sep 2025
 13:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com> <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
 <CAJnrk1aCCqoOAgcPUpr+Z09DhJ5BAYoSho5dveGQKB9zincYSQ@mail.gmail.com>
 <0b33ab17-2fc0-438f-95aa-56a1d20edb38@linux.alibaba.com> <aMK0lC5iwM0GWKHq@infradead.org>
 <9c104881-f09e-4594-9e41-0b6f75a5308c@linux.alibaba.com> <CAJnrk1b2_XGfMuK-UAej31TtCAAg5Aq8PFS_36yyGg8NerA97g@mail.gmail.com>
 <6609e444-5210-42aa-b655-8ed8309aae75@linux.alibaba.com> <66971d07-2c1a-4632-bc9e-e0fc0ae2bd04@linux.alibaba.com>
 <267abd34-2337-4ae3-ae95-5126e9f9b51c@linux.alibaba.com> <CAJnrk1Y31b-Yr03rN8SXPmUA7D6HW8OhnkfFOebn56z57egDOw@mail.gmail.com>
In-Reply-To: <CAJnrk1Y31b-Yr03rN8SXPmUA7D6HW8OhnkfFOebn56z57egDOw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 16:09:53 -0400
X-Gm-Features: Ac12FXy-J-VlWsro9NrSIzcDj4rKWuNwCZfBlBwTbl7b7lNj5FofdR9Weg0GYow
Message-ID: <CAJnrk1ZXM-fRKytRFptKNJrdN9pSbKJqXLW80T4UY=RLRKOBKQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, miklos@szeredi.hu, 
	djwong@kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 3:56=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Thu, Sep 11, 2025 at 9:11=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibab=
a.com> wrote:
> >
> > On 2025/9/12 09:09, Gao Xiang wrote:
> > >
> > >
> > > On 2025/9/12 08:06, Gao Xiang wrote:
> > >>
> > >>
> > >> On 2025/9/12 03:45, Joanne Koong wrote:
> > >>> On Thu, Sep 11, 2025 at 8:29=E2=80=AFAM Gao Xiang <hsiangkao@linux.=
alibaba.com> wrote:
> > >>
> > >>>> But if FUSE or some other fs later needs to request L2P informatio=
n
> > >>>> in their .iomap_begin() and need to send L2P requests to userspace
> > >>>> daemon to confirm where to get the physical data (maybe somewhat
> > >>>> like Darrick's work but I don't have extra time to dig into that
> > >>>> either) rather than just something totally bypass iomap-L2P logic
> > >>>> as above, then I'm not sure the current `iomap_iter->private` is
> > >>>> quite seperate to `struct iomap_read_folio_ctx->private`, it seems
> > >>>
> > >>> If in the future this case arises, the L2P mapping info is accessib=
le
> > >>> by the read callback in the current design. `.read_folio_range()`
> > >>> passes the iomap iter to the filesystem and they can access
> > >>> iter->private to get the L2P mapping data they need.
> > >>
> > >> The question is what exposes to `iter->private` then, take
> > >> an example:
> > >>
> > >> ```
> > >> struct file *file;
> > >> ```
> > >>
> > >> your .read_folio_range() needs `file->private_data` to get
> > >> `struct fuse_file` so `file` is kept into
> > >> `struct iomap_read_folio_ctx`.
> > >>
> > >> If `file->private_data` will be used for `.iomap_begin()`
> > >> as well, what's your proposal then?
> > >>
> > >> Duplicate the same `file` pointer in both
> > >> `struct iomap_read_folio_ctx` and `iter->private` context?
> > >
> > > It's just an not-so-appropriate example because
> > > `struct file *` and `struct fuse_file *` are widely used
> > > in the (buffer/direct) read/write flow but Darrick's work
> > > doesn't use `file` in .iomap_{begin/end}.
> > >
> > > But you may find out `file` pointer is already used for
> > > both FUSE buffer write and your proposal, e.g.
> > >
> > > buffer write:
> > >   /*
> > >    * Use iomap so that we can do granular uptodate reads
> > >    * and granular dirty tracking for large folios.
> > >    */
> > >   written =3D iomap_file_buffered_write(iocb, from,
> > >                                       &fuse_iomap_ops,
> > >                                       &fuse_iomap_write_ops,
> > >                                       file);
> >
> > And your buffer write per-fs context seems just use
> > `iter->private` entirely instead to keep `file`.
> >
>
> I don=E2=80=99t think the iomap buffered writes interface is good to use =
as a
> model. I looked a bit at some of the other iomap file operations and I
> think we should just pass operation-specific data through an
> operation-specific context for those too, eg for buffered writes and
> dio modifying the interface from
>
> ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter
> *from, const struct iomap_ops *ops, const struct iomap_write_ops
> *write_ops, void *private);
> ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter, const
> struct iomap_ops *ops, const struct iomap_dio_ops *dops, unsigned int
> dio_flags, void *private, size_t done_before);
>
> to something like
>
> ssize_t iomap_file_buffered_write(const struct iomap_ops *ops, struct
> iomap_write_folio_ctx *ctx);
> ssize_t iomap_dio_rw(const struct iomap_ops *ops, struct iomap_dio_ctx *c=
tx);
>
> There=E2=80=99s one filesystem besides fuse that uses =E2=80=9Citer->priv=
ate=E2=80=9D and
> that=E2=80=99s for xfs zoned inodes (xfs_zoned_buffered_write_iomap_begin=
()),
> which passes the  struct xfs_zone_alloc_ctx*  through iter->private,
> and it's used afaict for tracking block reservations. imo that's what
> iter->private should be used for, to track the more high level
> metadata stuff and then the lower-level details that are
> operation-specific go through the ctx->data fields. That seems the
> cleanest design to me. I think we should rename the iter->private
> field to something like "iter->metadata" to make that delineation more
> clear.  I'm not sure what the iomap maintainers think, but that is my
> opinion.
>
> I think if in the future there is a case/feature which needs something
> previously in one of the operation-specific ctxes, it seems fine to me
> to have both iter->private and ctx->data point to the same thing.
>
>
> Thanks,
> Joanne
>
> > >
> > >
> > > I just try to say if there is a case/feature which needs
> > > something previously in `struct iomap_read_folio_ctx` to
> > > be available in .iomap_{begin,end} too, you have to either:
> > >   - duplicate this in `iter->private` as well;
> > >   - move this to `iter->private` entirely.
> > >
> > > The problem is that both `iter->private` and
> > > `struct iomap_read_folio_ctx` are filesystem-specific,
> > > I can only see there is no clear boundary to leave something
> > > in which one.  It seems just like an artificial choice.
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > >>
> > >>
> > >>>
> > >>>> both needs fs-specific extra contexts for the same I/O flow.
> > >>>>
> > >>>> I think the reason why `struct iomap_read_folio_ctx->private` is
> > >>>> introduced is basically previous iomap filesystems are all
> > >>>> bio-based, and they shares `bio` concept in common but
> > >>>> `iter->private` was not designed for this usage.
> > >>>>
> > >>>> But fuse `struct iomap_read_folio_ctx` and
> > >>>> `struct fuse_fill_read_data` are too FUSE-specific, I cannot
> > >>>> see it could be shared by other filesystems in the near future,
> > >>>> which is much like a single-filesystem specific concept, and
> > >>>> unlike to `bio` at all.
> > >>>
> > >>> Currently fuse is the only non-block-based filesystem using iomap b=
ut
> > >>> I don't see why there wouldn't be more in the future. For example,
> > >>> while looking at some of the netfs code, a lot of the core
> > >>> functionality looks the same between that and iomap and I think it
> > >>> might be a good idea to have netfs in the future use iomap's interf=
ace
> > >>> so that it can get the large folio dirty/uptodate tracking stuff an=
d
> > >>> any other large folio stuff like more granular writeback stats
> > >>> accounting for free.
> > >>
> > >> I think you need to ask David on this idea, I've told him to
> > >> switch fscache to use iomap in 2022 before netfs is fully out [1],
> > >> but I don't see it will happen.
> > >>
> > >> [1] https://lore.kernel.org/linux-fsdevel/YfivxC9S52FlyKoL@B-P7TQMD6=
M-0146/

(sorry, just saw this part of the email otherwise I would have
included this in the previous message)

Thanks for the link to the thread. My understanding is that the large
folio optimizations stuff was added to iomap in July 2023 (afaict from
the git history) and iomap is entangled with the block layer but it's
becoming more of a generic interface now. Maybe now it makes sense to
go through iomap's interface than it did in 2022, but of course David
has the most context on this.


Thanks,
Joanne

> > >>
> > >> Thanks,
> > >> Gao Xiang
> > >
> >

