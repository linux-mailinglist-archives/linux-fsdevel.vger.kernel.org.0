Return-Path: <linux-fsdevel+bounces-61135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D9B55747
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 21:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9EA3B83FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52A0285C82;
	Fri, 12 Sep 2025 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOxH2ult"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E828314B
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707021; cv=none; b=P5i2opNCtbV1drSeOErO+xZAFVwnBnEAuxxINsEZ7O+Xi22G9Ly/EknyfkoQzjUbiYEXBqxYqt8aI7ce6kzrdGNg4diE0oGGzVkGeIRVEWHg6LhY8fkkbxeSHJt4JceCpql+L4copr1an6zd93zyLnfYmYc+z30Ni4a8BFyzlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707021; c=relaxed/simple;
	bh=9974JDRogo0n+ndu39jG/pTKJ9xOsQJxVIFhpq5cF2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th6Tef1kJRPNrGXIlbpQDR4d6o4rf/E4LCJJUjLNd2UA077jL0Kp1Lv5epInbEPUX52uTpNOY+z9wflgERENHzffAPi4qN6OWVNNZTBRcihJj8j1FTHMrrUBc44pi8VZV9vsbKSudqAIcSTPOPY1MWGQ6sF25QvhKTkazxyFRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOxH2ult; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b48eabaef3so22027311cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757707018; x=1758311818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7xSd4hkSOJN4rFdOkhQDgdYqByzYvKS04ghFhqMINA=;
        b=OOxH2ultkNNykfG/eX/kJ4TBmTimXBeaI+Go7fJBGpVpq5Hgrf7VaxSZYPTr6AGBn/
         UHAzZV7xJFU2cVs1dgAGr0Esc5KZHYkX2LxJ5rdmdR8RgPTWubWu/p0JHTAbbzMvj8jD
         Wa6wwd/bRtiI+02E6YRSXZIJgpDZhJ65wkIHWotM9AVIaVbdm4xb36IYtdjq9Do2zZra
         asvwSxgXn5kh7u8i8JbkfI+g11FVm2n5tbMNKlT9/emZvUMVK6VcLjqfPNrzu8I5fekr
         gOcVykyYps84ghKe1c/6g23gU0S3Dwn0l4TI8iGmShIHDnb5ZGvh25WJxh5zgsgfh3tD
         /YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757707018; x=1758311818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7xSd4hkSOJN4rFdOkhQDgdYqByzYvKS04ghFhqMINA=;
        b=GOBS7LoOwigqpu1I4F4E8DXRH9Y6pAwP/NL/2U7dTItu/RYOwsbDHwjPj56RnmMZ9C
         VTg2sLBeEwOn+UEh1NS+4Run2BiPeSnO4pEhS3vz73LcN/1BUewkiNCaHIJAn6/ICnyc
         jMxYVAMzNP6VHcJDvtlZtSLWPeEbre7DMeIjgsd67TRzBtGQftz/UrcKEExlg99ykwJk
         K5ekwdTaTajaDRJIceImw0jeDh5OrFADcXzfRs4U8h8Kw7aEtlsGKFF6wzCJt0JzD11f
         DS8gts0xnGMTOJjVtflxP6AL3w0ZoqSPHpUaJ2xjqVaUy+nbOR4M0Z/6MTEPnL4Y5ma0
         5g6A==
X-Forwarded-Encrypted: i=1; AJvYcCXPmh4vOxiuLOlUtXTBPv9fVe0Ii21PokkU2PGEKlopjWAck7/VEhO+MWvs7GLBl3x6GPltWcPNLGCg8l2b@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQ9UQi09BLV4OONmolwU7aa68kmIKoY7IwTDjozr9f73PSg7X
	9gxP1AvYnSKS0ewqQV1U9PNxCczGJvbNTeU70N4kJ4g2ZP1OKT52RdL5aQ9qaUHRup5CckKCnLX
	jP8mDADkux73PGqK7qWaGYvYq79RMemg=
X-Gm-Gg: ASbGnctz0FyX6TAygoUHt+mBIy5SHa+PS6Fr5wRBpPbCttfIVPAIb6jFVqiVSu9BU8B
	PcSQYMfC6d2vwSwcuZ/Viq9/qNKQ+5tV476u2HeIB8CeDdsR9ya1H4eP4zgEoqC2HEVVFMZ8m9M
	iKRjBynBI4GoBhc9te1tg6t5ixiZdqje0ouzg1MxE/zzKeuGKmOxg52gHT4RPjDg37N8crkLQP/
	4w8MM+f3QLOLJZivpYr8B83TH3Zo3APEjhDLvY=
X-Google-Smtp-Source: AGHT+IE3Y9XDwSZ6E3ZQ8y5m+QPR+XrZ1uYBV4d8HA3U7M3Ul8GuqClPn48kHtz+IzOKrwCRkzgnQWFjtBYbq5kbM+g=
X-Received: by 2002:a05:622a:189f:b0:4b3:4d9d:940 with SMTP id
 d75a77b69052e-4b77d03ee10mr52771801cf.54.1757707017920; Fri, 12 Sep 2025
 12:56:57 -0700 (PDT)
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
 <267abd34-2337-4ae3-ae95-5126e9f9b51c@linux.alibaba.com>
In-Reply-To: <267abd34-2337-4ae3-ae95-5126e9f9b51c@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 15:56:46 -0400
X-Gm-Features: Ac12FXxsIfEqXTl7vZDqTv3N2Skfu1ouhD6pDB74GYzRtEBggDV7bqVgW104mes
Message-ID: <CAJnrk1Y31b-Yr03rN8SXPmUA7D6HW8OhnkfFOebn56z57egDOw@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, miklos@szeredi.hu, 
	djwong@kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:11=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> On 2025/9/12 09:09, Gao Xiang wrote:
> >
> >
> > On 2025/9/12 08:06, Gao Xiang wrote:
> >>
> >>
> >> On 2025/9/12 03:45, Joanne Koong wrote:
> >>> On Thu, Sep 11, 2025 at 8:29=E2=80=AFAM Gao Xiang <hsiangkao@linux.al=
ibaba.com> wrote:
> >>
> >>>> But if FUSE or some other fs later needs to request L2P information
> >>>> in their .iomap_begin() and need to send L2P requests to userspace
> >>>> daemon to confirm where to get the physical data (maybe somewhat
> >>>> like Darrick's work but I don't have extra time to dig into that
> >>>> either) rather than just something totally bypass iomap-L2P logic
> >>>> as above, then I'm not sure the current `iomap_iter->private` is
> >>>> quite seperate to `struct iomap_read_folio_ctx->private`, it seems
> >>>
> >>> If in the future this case arises, the L2P mapping info is accessible
> >>> by the read callback in the current design. `.read_folio_range()`
> >>> passes the iomap iter to the filesystem and they can access
> >>> iter->private to get the L2P mapping data they need.
> >>
> >> The question is what exposes to `iter->private` then, take
> >> an example:
> >>
> >> ```
> >> struct file *file;
> >> ```
> >>
> >> your .read_folio_range() needs `file->private_data` to get
> >> `struct fuse_file` so `file` is kept into
> >> `struct iomap_read_folio_ctx`.
> >>
> >> If `file->private_data` will be used for `.iomap_begin()`
> >> as well, what's your proposal then?
> >>
> >> Duplicate the same `file` pointer in both
> >> `struct iomap_read_folio_ctx` and `iter->private` context?
> >
> > It's just an not-so-appropriate example because
> > `struct file *` and `struct fuse_file *` are widely used
> > in the (buffer/direct) read/write flow but Darrick's work
> > doesn't use `file` in .iomap_{begin/end}.
> >
> > But you may find out `file` pointer is already used for
> > both FUSE buffer write and your proposal, e.g.
> >
> > buffer write:
> >   /*
> >    * Use iomap so that we can do granular uptodate reads
> >    * and granular dirty tracking for large folios.
> >    */
> >   written =3D iomap_file_buffered_write(iocb, from,
> >                                       &fuse_iomap_ops,
> >                                       &fuse_iomap_write_ops,
> >                                       file);
>
> And your buffer write per-fs context seems just use
> `iter->private` entirely instead to keep `file`.
>

I don=E2=80=99t think the iomap buffered writes interface is good to use as=
 a
model. I looked a bit at some of the other iomap file operations and I
think we should just pass operation-specific data through an
operation-specific context for those too, eg for buffered writes and
dio modifying the interface from

ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter
*from, const struct iomap_ops *ops, const struct iomap_write_ops
*write_ops, void *private);
ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter, const
struct iomap_ops *ops, const struct iomap_dio_ops *dops, unsigned int
dio_flags, void *private, size_t done_before);

to something like

ssize_t iomap_file_buffered_write(const struct iomap_ops *ops, struct
iomap_write_folio_ctx *ctx);
ssize_t iomap_dio_rw(const struct iomap_ops *ops, struct iomap_dio_ctx *ctx=
);

There=E2=80=99s one filesystem besides fuse that uses =E2=80=9Citer->privat=
e=E2=80=9D and
that=E2=80=99s for xfs zoned inodes (xfs_zoned_buffered_write_iomap_begin()=
),
which passes the  struct xfs_zone_alloc_ctx*  through iter->private,
and it's used afaict for tracking block reservations. imo that's what
iter->private should be used for, to track the more high level
metadata stuff and then the lower-level details that are
operation-specific go through the ctx->data fields. That seems the
cleanest design to me. I think we should rename the iter->private
field to something like "iter->metadata" to make that delineation more
clear.  I'm not sure what the iomap maintainers think, but that is my
opinion.

I think if in the future there is a case/feature which needs something
previously in one of the operation-specific ctxes, it seems fine to me
to have both iter->private and ctx->data point to the same thing.


Thanks,
Joanne

> >
> >
> > I just try to say if there is a case/feature which needs
> > something previously in `struct iomap_read_folio_ctx` to
> > be available in .iomap_{begin,end} too, you have to either:
> >   - duplicate this in `iter->private` as well;
> >   - move this to `iter->private` entirely.
> >
> > The problem is that both `iter->private` and
> > `struct iomap_read_folio_ctx` are filesystem-specific,
> > I can only see there is no clear boundary to leave something
> > in which one.  It seems just like an artificial choice.
> >
> > Thanks,
> > Gao Xiang
> >
> >>
> >>
> >>>
> >>>> both needs fs-specific extra contexts for the same I/O flow.
> >>>>
> >>>> I think the reason why `struct iomap_read_folio_ctx->private` is
> >>>> introduced is basically previous iomap filesystems are all
> >>>> bio-based, and they shares `bio` concept in common but
> >>>> `iter->private` was not designed for this usage.
> >>>>
> >>>> But fuse `struct iomap_read_folio_ctx` and
> >>>> `struct fuse_fill_read_data` are too FUSE-specific, I cannot
> >>>> see it could be shared by other filesystems in the near future,
> >>>> which is much like a single-filesystem specific concept, and
> >>>> unlike to `bio` at all.
> >>>
> >>> Currently fuse is the only non-block-based filesystem using iomap but
> >>> I don't see why there wouldn't be more in the future. For example,
> >>> while looking at some of the netfs code, a lot of the core
> >>> functionality looks the same between that and iomap and I think it
> >>> might be a good idea to have netfs in the future use iomap's interfac=
e
> >>> so that it can get the large folio dirty/uptodate tracking stuff and
> >>> any other large folio stuff like more granular writeback stats
> >>> accounting for free.
> >>
> >> I think you need to ask David on this idea, I've told him to
> >> switch fscache to use iomap in 2022 before netfs is fully out [1],
> >> but I don't see it will happen.
> >>
> >> [1] https://lore.kernel.org/linux-fsdevel/YfivxC9S52FlyKoL@B-P7TQMD6M-=
0146/
> >>
> >> Thanks,
> >> Gao Xiang
> >
>

