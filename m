Return-Path: <linux-fsdevel+bounces-72963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95761D06984
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 01:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A9E302068D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 00:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4994272618;
	Fri,  9 Jan 2026 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoWE8l+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2EA2E40B
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767917456; cv=none; b=YF2b35LLJwkY+7AF0KZ15fakR8LZSQlNAUbJjTZi5j4wvnn2Aa3g1K0TjA0GOZ+5+niViOIgQJIs/Jn/+HXcsEl7ksFhEkMliIFgYqgTZxLi2jXPXaYusytvM+57+nXU14DKTu3oXtals3awbKXMYqPKnY7q9ASMSri7aJxRdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767917456; c=relaxed/simple;
	bh=9aJSC2x1m+868DWnJu2WZWbYy0I8FxNRBYN9IH6lmuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc/pp9DnD2ava1ByRtcy+H+v1uHpbSYrrr+yCOKUypQYglbfM0aef7KNd8rIzwQw9QtqOFowrov7ojCFyEu/yISiqbsY9aDotxTsD2qsZoF7gB3PmhaB2xP7Zas9YraX4Nk082qznUPMapdLj/X1tCte8QFpBxl8DQL3Np71EhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoWE8l+F; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee1e18fb37so34194121cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767917454; x=1768522254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdkIlQ92g3yoewQ/1YLASbjQN70IOWFt/r8ioUdXHQA=;
        b=FoWE8l+F20wbKrcuN4tScKgwtH5MHG9Mw6qSXJYrM8fVYwHvzoUga31I/nxcWTm2JY
         z2Smw3FVvYg4iFmXir0edS/l1Iai3J8cOW8cf3wl5zkuEMPn1eJKK3WYNaQZ4xlsfV/B
         6TMaOVi4Jl5e5L6u2SeQANWDtSmD/2cAi5wdxB+SWPgxNqAiI4MpXmoQHJGgibTpPeGc
         4rDxtQ91luc8YHWwUxJTZWMKEZUe/X/dwWAnNxNB1+hMCV1CeeYzwuPdD/PI/NCAq4lo
         gQv6Wx8NrO6V1+kBctMWsyUy6bW3dzttc+J+mO4Z4/NgEuY4v25dGuv1s2zX2sYiPQZ0
         S9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767917454; x=1768522254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hdkIlQ92g3yoewQ/1YLASbjQN70IOWFt/r8ioUdXHQA=;
        b=wffuoAAX89KeMgiXPSQnXHIAKI8wbXh411Rjq8LCVNbGnpOtfKBmixc9wtZQT9WQFw
         iiB2VdGfKDBoTu960e3ATleee0NTntr2TGyryErvDFuxe0iNkBQRDELKnxOfnjOit2Ql
         jvbkqk6Ko68pu/7CJos22iwH4KgF1RaRxBOWQPV+kqrUg/cfRqO/5G5L4LVeIJUrDZ3H
         PwqvnDPVPqJRJi0ZiirlfejraqzGAzhYocB02wFlp8i6gMfwo0o2PGEJrfV5uwiBM0EW
         pYM8ddQcwYSz1sZL/Qky9wNmfcT4/cBrRkwxl+zjbNA8Z1hZQJqBuXww+MUwPNG6wWxR
         FhyA==
X-Forwarded-Encrypted: i=1; AJvYcCUkN0biEX6wt+W4v9mbuFJO2w4oAt/+wlNCrflKXNBTkkGGmKUIsTUwOfP/dvdKRXjCo9K7aGVZS1Zz3fFo@vger.kernel.org
X-Gm-Message-State: AOJu0YyepO50cld0X7DEIDAzgYpMT6W8byozPwC9d3m0Hkf0VK8k0xjs
	h3Ry2w08NP2B9khyTdqhg6nfG18d/SBNiu90qbBwnz1w3UNJoirgUrDTCOxROyJ0U48xnRN6tyv
	DMgfLL8HrhXlmvGvvSeauspKRQpvUCto=
X-Gm-Gg: AY/fxX7Bzu7eckGJzEivBybt174myuU2Ndx6ZWg1ACUPzntGZhItcai9599bgty9FuL
	CxTe3Sg96K/vtPA9H7zpd/rcDDGJhvt3OIGL4xMDMDOyXTpp19x47XOxrVMYvUbVAdZPPiZ75Ak
	c0sVePDRRQ0t6WcyuyLoU1tZPiuPubJLhvSx58ctFJ4AlW6zo5aig7jJr1Bp87tRy+QOrc2IqIt
	Ku3GZG9vTGAQyKrex+/Suos9dkPGfXOCxPxE6m0i1pMtm5rNIT/Qo7sx1i7XgA4FzQQ0Q==
X-Google-Smtp-Source: AGHT+IGRpNs2BVM2M3mmA6EJFK/F8gQRBPsbNdnT/JjPHAB18Z5c8PXXflr5K2EcfLWfgkhn+kSsbucB1ooWTiJbN4E=
X-Received: by 2002:ac8:5990:0:b0:4ee:219e:e74 with SMTP id
 d75a77b69052e-4ffb4a64015mr100743181cf.77.1767917454239; Thu, 08 Jan 2026
 16:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-24-joannelkoong@gmail.com> <CADUfDZoph-=on3E3sis0eLy_Fm7kUGShRUc89-0V1OjMHNLLAQ@mail.gmail.com>
In-Reply-To: <CADUfDZoph-=on3E3sis0eLy_Fm7kUGShRUc89-0V1OjMHNLLAQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 8 Jan 2026 16:10:43 -0800
X-Gm-Features: AQt7F2owGGc8SFUyf0A9PJnA-aVLIQfN01k8fWSFvCybzy0fMobi8XIvVBrTnDs
Message-ID: <CAJnrk1a-rHrCEXyxSRrZDJgSavK-qyb0aMXJ1XfdZUhfMswwtA@mail.gmail.com>
Subject: Re: [PATCH v3 23/25] io_uring/rsrc: add io_buffer_register_bvec()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 1:09=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Dec 22, 2025 at 4:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Add io_buffer_register_bvec() for registering a bvec array.
> >
> > This is a preparatory patch for fuse-over-io-uring zero-copy.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring/cmd.h | 12 ++++++++++++
> >  io_uring/rsrc.c              | 27 +++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> >
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index 06e4cfadb344..f5094eb1206a 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -106,6 +106,9 @@ int io_uring_cmd_is_kmbuf_ring(struct io_uring_cmd =
*ioucmd,
> >  int io_buffer_register_request(struct io_uring_cmd *cmd, struct reques=
t *rq,
> >                                void (*release)(void *), unsigned int in=
dex,
> >                                unsigned int issue_flags);
> > +int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct bio_vec *=
bvs,
>
> Could take const struct bio_vec *? Might also be helpful to document
> that this internally makes a copy of the bio_vec array, so the memory
> bvs points to can be deallocated as soon as io_buffer_register_bvec()
> returns.

I'll add the "const" and your suggested documentation for v4.
>
> > +                           unsigned int nr_bvecs, unsigned int total_b=
ytes,
> > +                           u8 dir, unsigned int index, unsigned int is=
sue_flags);
> >  int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
> >                          unsigned int issue_flags);
> > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > index 5a708cecba4a..32126c06f4c9 100644
> > --- a/io_uring/rsrc.c
> > +++ b/io_uring/rsrc.c
> > @@ -1020,6 +1020,33 @@ int io_buffer_register_request(struct io_uring_c=
md *cmd, struct request *rq,
> >  }
> >  EXPORT_SYMBOL_GPL(io_buffer_register_request);
> >
> > +int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct bio_vec *=
bvs,
> > +                           unsigned int nr_bvecs, unsigned int total_b=
ytes,
> > +                           u8 dir, unsigned int index,
> > +                           unsigned int issue_flags)
> > +{
> > +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > +       struct io_mapped_ubuf *imu;
> > +       struct bio_vec *bvec;
> > +       int i;
>
> unsigned?

Will do for v4.

Thanks,
Joanne
>
> Other than that,
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

