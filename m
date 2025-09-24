Return-Path: <linux-fsdevel+bounces-62657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C8B9B766
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B123BADC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5150419D8BC;
	Wed, 24 Sep 2025 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+zXtPln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200B31D735
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737910; cv=none; b=lDM8Z4eISvUXzgI+9gdY6V6V7BtTXGsuykYgoYxPcdw46PrR/RKShMdUYNv7CO0hvqRb0tSYEuzzyHggZ0wBgfVrNmfvocK8tIFB2TErDSrUZbSQxwoLtXG6zVxREijn4AutG/KanQaxcUSLXQfNal2b1PdeFjYKhGJSOikIAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737910; c=relaxed/simple;
	bh=ory5+NJ9BvZxsIZXubXLKy+nuRKqeT+Cb3ahLLWzLuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N77vWtb14m2VLYAHXkm0jKkkvrsJfl7K11uR6wZ4fPLk5uG7kHIbrkwNStdh2bbtXauuGRrx/IRvmhga3oPNfO47T5+RWgr4iyEaHDRFgkG7qcjnkzX2bY27T7qX8V9d9vxOInrCTXqKg5uAf4GF4o57GWLAYgGRNYGpkHTbxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+zXtPln; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4d00ad6337cso1648731cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758737907; x=1759342707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFTnrBy9ZUzyqzejBWKFr/WfTb6nZweuI2MfFnrt50Y=;
        b=N+zXtPlnVvENpWQkYMqEDebqaXajeS1Vcq+J4Z7zlTqQBOxMMK3IDg+CtL0yDUcADT
         +I6XC67pvMv9FF3/SYh72hqp4oiYPzpRyjkrB/GQO3rypASWhVZ+xMRE4ZKnKbL7CtUu
         Jc9Jhk551hvxEbAKk+2RJCm4nD9nuk+iNatqokdNbWxaSr7IO6JLWaxJRJ+f9X52ZH8q
         B4Ro4uN7ARVJ7/OAsD7l6b36x85gxzb4ESopn0PS3wEraF6enZPGlX/7UDb3h0eCd6u0
         VEdVyJjM/LNYJxaSkQCgeCYSNcw1O+ArMwc3mtPMVh/qExEIvr/4YlcwW2DYv9SM1jdR
         QJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758737907; x=1759342707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFTnrBy9ZUzyqzejBWKFr/WfTb6nZweuI2MfFnrt50Y=;
        b=Xz9wdO9TS5fCEj69TxSv4SEKeM2Jdxf1ZXdEwzZfFRcP+mA0kR+L2loQnizkTvN/Zx
         kK/nx4e155LOMJbd5PcGP0CKy3a4aAGcXaBFS/rGWiiHsxFqfooBN627ZxyVY+kTPSWo
         OCUa1kxBu2/HxMv3EnE3eqKrOTOXNz6GlwJ8cHp95+r18nvccftULDQXz+vwkgung9It
         Kr6PqGhp65N/ix1siUoBWyLNYFL/B/tXQ8xd5o6KTFvzR0fU8Ph0kSsEBsYTbXdYwlAX
         YWQOQpN5Wo/C25wj3dmnQ8x28pHByyXAZKu0/BsdRPhEoAESKFSiTClk6zx4eHu1YW3M
         kVxg==
X-Forwarded-Encrypted: i=1; AJvYcCU1FtKNfVSsXrl4A6dWzU+yY75Y3gGxY0D57D4LPRLBOQuoz0cCbqFydgg4PYQmhXEmYV3Y2NXfCYnR5Nnl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61YQxJhwDALDlGVJ6aOf4USz0hal3GP9FYXQMuYN/rTA9wzG1
	D3bPGwQSVQFVPjjd8exkzWxz6vlAYeX4ApeAiTwP2CrKQC9KLgFAZiYhqEyO3pvMKqlPwmpv/Uk
	fhXB/fHEDtjeYffy+AtOGsFbkgSFyqjCZLQkLbdY=
X-Gm-Gg: ASbGncsmCl29VKrrzjIDX8AfZ6SmvGqnZiX1LdYfGBM+gWlTpvgEwnC3pPT1H+WJZBd
	03Rc4ud7uMHwS1nEcAUSiVwlY6lswjF1OtOx3in2X36jAYtfW90TbQrvtWAv5VWqWu8UR+iTpZF
	aC2/1TIobPB/F5KLGH0dKQfpcDVeceYvOgimkRa+Oud5I5hGEz7vnYiV2O+NhW4kc0h4JjTd3oE
	YCzipwg9MhogfzhJPtj68kt5Y8SA0i8EkAbdt+/
X-Google-Smtp-Source: AGHT+IG0FJNATbowUCK2eCqu4TqdYgCRhA5RU6qsAcXIKcqgqCh/NZfG2X/A/r97ZJ/R+fCGywFmFYaqz9S0mvEbQig=
X-Received: by 2002:ac8:7d8e:0:b0:4d3:cc12:34ec with SMTP id
 d75a77b69052e-4da4c39d3d8mr9807261cf.55.1758737906418; Wed, 24 Sep 2025
 11:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
 <20250923002353.2961514-10-joannelkoong@gmail.com> <20250924002654.GM1587915@frogsfrogsfrogs>
In-Reply-To: <20250924002654.GM1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Sep 2025 11:18:14 -0700
X-Gm-Features: AS18NWDaLLz-85vyq1nHgT9THLWtQpVfc8Btmf12YhZ9wZJaiXl5Sn6PA4p4yN0
Message-ID: <CAJnrk1bYAaJofNBpYYKB2fWGVw-9BPrOUBy_ivmfnjR=49BmNQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] iomap: add caller-provided callbacks for read
 and readahead
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, hsiangkao@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 5:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Sep 22, 2025 at 05:23:47PM -0700, Joanne Koong wrote:
> > Add caller-provided callbacks for read and readahead so that it can be
> > used generically, especially by filesystems that are not block-based.
> >
> > In particular, this:
> > * Modifies the read and readahead interface to take in a
> >   struct iomap_read_folio_ctx that is publicly defined as:
> >
> >   struct iomap_read_folio_ctx {
> >       const struct iomap_read_ops *ops;
> >       struct folio *cur_folio;
> >       struct readahead_control *rac;
> >       void *read_ctx;
> >   };
>
> I'm starting to wonder if struct iomap_read_ops should contain a struct
> iomap_ops object, but that might result in more churn through this
> patchset.
>
> <shrug> What do you think?

Lol I thought the same thing a while back for "struct iomap_write_ops"
but I don't think Christoph liked the idea [1]

[1] https://lore.kernel.org/linux-fsdevel/20250618044344.GE28041@lst.de/

>
> >
> >   where struct iomap_read_ops is defined as:
> >
> >   struct iomap_read_ops {
> >       int (*read_folio_range)(const struct iomap_iter *iter,
> >                              struct iomap_read_folio_ctx *ctx,
> >                              size_t len);
> >       void (*read_submit)(struct iomap_read_folio_ctx *ctx);
> >   };
> >
> >   read_folio_range() reads in the folio range and is required by the
> >   caller to provide. read_submit() is optional and is used for
> >   submitting any pending read requests.
> >
> > * Modifies existing filesystems that use iomap for read and readahead t=
o
> >   use the new API, through the new statically inlined helpers
> >   iomap_bio_read_folio() and iomap_bio_readahead(). There is no change
> >   in functinality for those filesystems.
>
> Nit: functionality

Thanks, will fix this!
>
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  .../filesystems/iomap/operations.rst          | 45 ++++++++++++
> >  block/fops.c                                  |  5 +-
> >  fs/erofs/data.c                               |  5 +-
> >  fs/gfs2/aops.c                                |  6 +-
> >  fs/iomap/buffered-io.c                        | 68 +++++++++++--------
> >  fs/xfs/xfs_aops.c                             |  5 +-
> >  fs/zonefs/file.c                              |  5 +-
> >  include/linux/iomap.h                         | 62 ++++++++++++++++-
> >  8 files changed, 158 insertions(+), 43 deletions(-)
> >
> > diff --git a/Documentation/filesystems/iomap/operations.rst b/Documenta=
tion/filesystems/iomap/operations.rst
> > index 067ed8e14ef3..dbb193415c0e 100644
> > --- a/Documentation/filesystems/iomap/operations.rst
> > +++ b/Documentation/filesystems/iomap/operations.rst
> > @@ -135,6 +135,29 @@ These ``struct kiocb`` flags are significant for b=
uffered I/O with iomap:
> >
> >   * ``IOCB_DONTCACHE``: Turns on ``IOMAP_DONTCACHE``.
> >
> > +``struct iomap_read_ops``
> > +--------------------------
> > +
> > +.. code-block:: c
> > +
> > + struct iomap_read_ops {
> > +     int (*read_folio_range)(const struct iomap_iter *iter,
> > +                             struct iomap_read_folio_ctx *ctx, size_t =
len);
> > +     void (*submit_read)(struct iomap_read_folio_ctx *ctx);
> > + };
> > +
> > +iomap calls these functions:
> > +
> > +  - ``read_folio_range``: Called to read in the range. This must be pr=
ovided
> > +    by the caller. The caller is responsible for calling
> > +    iomap_start_folio_read() and iomap_finish_folio_read() before and =
after
> > +    reading in the folio range. This should be done even if an error i=
s
> > +    encountered during the read. This returns 0 on success or a negati=
ve error
> > +    on failure.
> > +
> > +  - ``submit_read``: Submit any pending read requests. This function i=
s
> > +    optional.
> > +
> >  Internal per-Folio State
> >  ------------------------
> >
> > @@ -182,6 +205,28 @@ The ``flags`` argument to ``->iomap_begin`` will b=
e set to zero.
> >  The pagecache takes whatever locks it needs before calling the
> >  filesystem.
> >
> > +Both ``iomap_readahead`` and ``iomap_read_folio`` pass in a ``struct
> > +iomap_read_folio_ctx``:
> > +
> > +.. code-block:: c
> > +
> > + struct iomap_read_folio_ctx {
> > +    const struct iomap_read_ops *ops;
> > +    struct folio *cur_folio;
> > +    struct readahead_control *rac;
> > +    void *read_ctx;
> > + };
> > +
> > +``iomap_readahead`` must set:
> > + * ``ops->read_folio_range()`` and ``rac``
> > +
> > +``iomap_read_folio`` must set:
> > + * ``ops->read_folio_range()`` and ``cur_folio``
>
> Hrmm, so we're multiplexing read and readahead through the same
> iomap_read_folio_ctx.  Is there ever a case where cur_folio and rac can
> both be used by the underlying machinery?  I think the answer to that
> question is "no" but I don't think the struct definition makes that
> obvious.

In the ->read_folio_range() callback, both rac and cur_folio are used
for readahead, but in passing in the "struct iomap_read_folio_ctx" to
the main iomap_read_folio()/iomap_readahead() entrypoint, no both rac
and cur_folio do not get set at the same time.

We could change the signature back to something like:
int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
const struct iomap_read_ops *ops, void *read_ctx);
void iomap_readahead(struct readahead_control *rac, const struct
iomap_ops *ops, const struct iomap_read_ops *ops, void *read_ctx);

but I think it might get a bit much if/when "void *private" needs to
get added too for iomap iter metadata, though maybe that's okay now
that the private read data has been renamed to read_ctx.


>
> > +
> >  static int iomap_read_folio_iter(struct iomap_iter *iter,
> >               struct iomap_read_folio_ctx *ctx, bool *folio_owned)
> >  {
> > @@ -436,7 +438,7 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
> >       loff_t length =3D iomap_length(iter);
> >       struct folio *folio =3D ctx->cur_folio;
> >       size_t poff, plen;
> > -     loff_t count;
> > +     loff_t pos_diff;
> >       int ret;
> >
> >       if (iomap->type =3D=3D IOMAP_INLINE) {
> > @@ -454,12 +456,16 @@ static int iomap_read_folio_iter(struct iomap_ite=
r *iter,
> >               iomap_adjust_read_range(iter->inode, folio, &pos, length,=
 &poff,
> >                               &plen);
> >
> > -             count =3D pos - iter->pos + plen;
> > -             if (WARN_ON_ONCE(count > length))
> > +             pos_diff =3D pos - iter->pos;
> > +             if (WARN_ON_ONCE(pos_diff + plen > length))
> >                       return -EIO;
>
> Er, can these changes get their own patch describing why the count ->
> pos_diff change was made?

I will separate this out into its own patch. The reasoning behind this
is so that the ->read_folio_range() callback doesn't need to take in a
pos arg but instead can get it from iter->pos [1]

[1] https://lore.kernel.org/linux-fsdevel/aMKt52YxKi1Wrw4y@infradead.org/

Thanks for looking at this patchset!

Thanks,
Joanne
>
> --D
>

