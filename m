Return-Path: <linux-fsdevel+bounces-60969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA536B53C7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 21:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9DA175FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 19:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F854242D9D;
	Thu, 11 Sep 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLBcoqgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4823C4E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619944; cv=none; b=rdyaeOBXm/l/IzokvcpAe1eLTQ/YDgaSRv673SsmeEMVjXEOpJqNkqIxyF3ydByFIVTh2JQBtl3FORyCsW7Fe9pOXv6cQV0hHO4Xg9kQfM0cpbyLBveMrS6B8sR5ZkhoCr0r58Kx8GLM94e9UqXbyFNCeI10MXp1klHqQaBP7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619944; c=relaxed/simple;
	bh=UQ+azyfBJLEVgkFhkxQAX5mILv2bK5F4BrYoZ1qtVXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5LT2Q5e2x/OQ+B9dqmv5XK1jfUUEhud6VIzPQjq54NjVx4X/RCvNrGBL4bAnxh6MksIO0kwZ75oFzxoHv9qrcar+5KM5zsumuXB4aL4OYKOUt7jXujWYeBqJqD+kpAomaE+hhTpaR9c1taz97L9oVr7XksWrPm7iwgN7Tusv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLBcoqgU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-805a55c09aeso127918485a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757619942; x=1758224742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P8qpgTT4CD1z1EW5R7hzuqr8lbCC0uLuzD1yVLy364=;
        b=YLBcoqgU97MjY4GRNc4p/EuGAC+N80AaYgJr+GJfZLPc509VrC1VeR8HsvfR35k/cz
         qutlvx+nqrTq52jml39wKxv/4H/RUi1rxsDFpt3F6ylRJzMNuqRn48mCjui6gcUkgyhR
         RCNOmF0pICwgFXQf6LZiAv890abcvcWFts0ttbuEa1iPw/6nAFmzSrf9nUXk1MRxjLxv
         1OOoWdXOncvmYRWUBIEWxhy9wx2BzYwjJ5i44HV/A6Xi3N4/bX+STLHybAc6q+RJHjWD
         N1CCWApIhgeGyBVezzrrOyBCE/DnR5IJ0pAN/bgxkcVv8a98e65s35+U8t3eTYYts5XX
         afXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619942; x=1758224742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P8qpgTT4CD1z1EW5R7hzuqr8lbCC0uLuzD1yVLy364=;
        b=ikg89s1kJYvdcqsrju+J5f9cJXZCNiokGlCXwmuGYCgtYIqUhlCOHRKs9Z11XPwPQz
         F1zqHys8fj+rlXta85Ejd6kdpdQ0SwdC2voh33uuA+JjgJQM6jOammbIRu7BvGyioeQY
         +9g5uLmp5Y07MFi1cRQD/b78biiPfZvyVntrx8wgrspr5l17qNeshZRfCLCHVgXdBX4S
         QvZzh/aD7hZkkMt+yex+euj71XUpQB1vKhd/N1OdQ/uyMXuQTxWkKDZZ4zdgpL+iLVNg
         bonW0R2qfjJUL6dcm2zSLwnIkbudBNV/1NUmWGwMsuKp1sXY7mtBf/vM02ZKxDNnSABa
         2x2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkqS42Z/o5NzNMCMd+DIgVGFU40IfgxhRXHkizXYBvF4lD5+smgBOTe+dKwbshoYuK8X0F50RmvMha7oK4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2i1cOHzNCGB3Dn/JWQksal5WFp1KxkAZBJpdO0q2jeEvzKuun
	Rlq+4r+sIb0pfuFOJk4bmVvzG4DKDLu1BEPY1gpA56vbnQg0uEzYkyvSTbye1I8SVdLeCQgjsAA
	cxoOej6aqHmAnrVMDMYTPQ6Pfo9W7GOQ=
X-Gm-Gg: ASbGncsBOzbIAHkC5Al5mfrcXuSZTloJOubkJuYTUoecs2p3PZKppfa42ZFfla/YYHm
	k17Au8OSaXiYXX/8xribz8qW7uyxx37NFP7gsfntO+s7xqoU7bmCKwcI2tTf2m6nrE2dtr7t0JQ
	4Z9b6cbavuem5x5c6r6h6ctPDo5PmbGjHXeLYdUmWnhSihFSuh4OqwWRewNOVpIgk/rRWMP1kRa
	14ISISVjdaKlcNAODAp6r2vvp+pz23wwgGmWMOSPWSr
X-Google-Smtp-Source: AGHT+IHtAw0lVlpGGJ06gAtOTDihqoXPOrWbMz80FfAkP5uWz95A2L7X1pd/xRQ1MQFSLXu83sUO6jrrXMjhd4e0uMw=
X-Received: by 2002:a05:620a:d88:b0:807:87a9:89a1 with SMTP id
 af79cd13be357-823fd41926bmr100960385a.37.1757619941606; Thu, 11 Sep 2025
 12:45:41 -0700 (PDT)
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
 <9c104881-f09e-4594-9e41-0b6f75a5308c@linux.alibaba.com>
In-Reply-To: <9c104881-f09e-4594-9e41-0b6f75a5308c@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 11 Sep 2025 15:45:28 -0400
X-Gm-Features: Ac12FXwgTb8F5lYaNAIGfAVGCddROzFscVCRkbUHIIucMvNsiS1K_faJqDoLwX4
Message-ID: <CAJnrk1b2_XGfMuK-UAej31TtCAAg5Aq8PFS_36yyGg8NerA97g@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, miklos@szeredi.hu, 
	djwong@kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 8:29=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Christoph,
>
> On 2025/9/11 19:37, Christoph Hellwig wrote:
> > On Wed, Sep 10, 2025 at 12:59:41PM +0800, Gao Xiang wrote:
> >> At least it sounds better on my side, but anyway it's just
> >> my own overall thought.  If other folks have different idea,
> >> I don't have strong opinion, I just need something for my own
> >> as previous said.
> >
> > I already dropped my two suggestions on the earlier patch.  Not totally
> > happy about either my suggestions or data, but in full agreement that
> > it should be something else than private.
>
> To just quote your previous comment and try to discuss here:
>
> ```
> On Wed, Sep 10, 2025 at 01:41:25PM -0400, Joanne Koong wrote:
> > In my mind, the big question is whether or not the data the
> > filesystems pass in is logically shared by both iomap_begin/end and
> > buffered reads/writes/dio callbacks, or whether the data needed by
> > both are basically separate entities
>
> They are separate entities.
> ```
>

Hi Gao,

> I try to push this again because I'm still not quite sure it's
> a good idea, let's take this FUSE iomap-read proposal (but sorry
> honestly I not fully look into the whole series.)
>
> ```
>   struct fuse_fill_read_data {
>         struct file *file;
> +
> +       /*
> +        * Fields below are used if sending the read request
> +        * asynchronously.
> +        */
> +       struct fuse_conn *fc;
> +       struct fuse_io_args *ia;
> +       unsigned int nr_bytes;
>   };
> ```
>
> which is just a new FUSE-only-specific context for
> `struct iomap_read_folio_ctx`, it's not used by .iomap_{begin,end}
> is that basically FUSE _currently_ doesn't have logical-to-physical
> mapping requirement (except for another fuse_iomap_begin in dax.c):

I don't think this is true. The other filesystems in the kernel using
iomap that do need logical to physical mappings also do not have their
context for `struct iomap_read_folio_ctx` (the struct bio) used by
.iomap_{begin, end} either. As I see it, the purpose of the `struct
iomap_read_folio_ctx` context is for processing/issuing the reads and
the context for .iomap_{begin,end} is for doing all the mapping /
general metadata tracking stuff - even for the filesystems that have
the logical to physical mapping requirements, their usage of the
context is for processing/submitting the bio read requests, which imo
the more high-level iomap_{begin,end} is a layer above.

> ```
> static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t le=
ngth,
>                              unsigned int flags, struct iomap *iomap,
>                              struct iomap *srcmap)
> {
>          iomap->type =3D IOMAP_MAPPED;
>          iomap->length =3D length;
>          iomap->offset =3D offset;
>          return 0;
> }
> ```
>
> But if FUSE or some other fs later needs to request L2P information
> in their .iomap_begin() and need to send L2P requests to userspace
> daemon to confirm where to get the physical data (maybe somewhat
> like Darrick's work but I don't have extra time to dig into that
> either) rather than just something totally bypass iomap-L2P logic
> as above, then I'm not sure the current `iomap_iter->private` is
> quite seperate to `struct iomap_read_folio_ctx->private`, it seems

If in the future this case arises, the L2P mapping info is accessible
by the read callback in the current design. `.read_folio_range()`
passes the iomap iter to the filesystem and they can access
iter->private to get the L2P mapping data they need.

> both needs fs-specific extra contexts for the same I/O flow.
>
> I think the reason why `struct iomap_read_folio_ctx->private` is
> introduced is basically previous iomap filesystems are all
> bio-based, and they shares `bio` concept in common but
> `iter->private` was not designed for this usage.
>
> But fuse `struct iomap_read_folio_ctx` and
> `struct fuse_fill_read_data` are too FUSE-specific, I cannot
> see it could be shared by other filesystems in the near future,
> which is much like a single-filesystem specific concept, and
> unlike to `bio` at all.

Currently fuse is the only non-block-based filesystem using iomap but
I don't see why there wouldn't be more in the future. For example,
while looking at some of the netfs code, a lot of the core
functionality looks the same between that and iomap and I think it
might be a good idea to have netfs in the future use iomap's interface
so that it can get the large folio dirty/uptodate tracking stuff and
any other large folio stuff like more granular writeback stats
accounting for free.


Thanks,
Joanne

>
> I've already racked my brains on this but I have no better
> idea on the current callback-hook model (so I don't want to argue
> more). Anyway, I really think it should be carefully designed
> (because the current FUSE .iomap_{begin,end} are just like no-op
> but that is just fuse-specific).  If folks really think Joanne's
> work is already best or we can live with that, I'm totally fine.
>
> Thanks,
> Gao Xiang
>

