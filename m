Return-Path: <linux-fsdevel+bounces-72968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27591D06ACF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 02:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 295113028D8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 01:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E61A9B24;
	Fri,  9 Jan 2026 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1ls4t3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6F1632E7
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920713; cv=none; b=FImDM0muwd9IcoAXtPC8U4MKetWxMwVgvqbQHvgdmlpInM8aGmoTWLP+kvpNLeHFGUg/jeyI6/53na8hna2G7jJHU6ykJZQUxofc7Jr+UuEpyKYxbY+AevMnznCpBA7E3QxqximjYlogFL+GsVTrxllHRTN+a8jvJjqZ4f3TES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920713; c=relaxed/simple;
	bh=7gFn/kbffC2b2K7ZKbv+EphI6b1weHTRTlcBs50nkEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfjjfucMB/5hcvVcZNtaQcqc+elQC5UGaoGeKRkFe3Qc+oQ2EeznqpNrGDWPi+DL5DZewI7RtVrhAp3ytabyIT82e0fVy/36GsTylsCnE2RP3mQCYulT5+r9YKldrz/cZKR64yW/uwkSPECf9ZHVOTuxoYFpUO8hoNyEQmfFE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1ls4t3o; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee1879e6d9so42184201cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 17:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920711; x=1768525511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PRD3yO3JctHHM7B943g2Ei/qmzsZxkR5OBbWUkzXtY=;
        b=Y1ls4t3oSkXQyZdmxivWtpcFNH8PQiusTBER8lL0A1WzlauFA+96b5IqyGoXPt5/iC
         NAz0kRPgKnrj/n3GJtaw9bjrI6Pj08h69dT81Ry8SAn3DF7irjAyYwno3xabTq7NxxP3
         vxWOT00NWDLJz1JhbAJElrdpIkO2nIskFbcJgZOJ1lI/UD2i8sP+rmJBGZ+tR26TOwWL
         HAfF7dw3c9Zau3bNgl/EowImXaf7qXU8+jThjY4hb2SZE88c52hX0WL8pRgov21QbiRs
         Xb3kwgEDk7wDNp0dDNqFzOkpTnDhNlnwnsi1QyyhW+2nGY1jRERoJCLlhBX/4jYvJz2N
         5FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920711; x=1768525511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8PRD3yO3JctHHM7B943g2Ei/qmzsZxkR5OBbWUkzXtY=;
        b=RGwAvwFDgo5RF4BUWDRor5ZYHtxEk4ZtSMlBt6pd0h0if519yrIFt1PmJyy2TFnWfY
         JuzuyaWfa5hgIgo21UMxlrLVDMjh3PjLwBuoVEj7SY8zv6Dx4U6SWuI5w+SJ5jh2f7ef
         lwjOFLx3+C6NUcpipPG+vax6ZLWxsedELRWBqTM2abKstfMJImA/oqVVkBj7rLVefhFh
         Bv9icL6a9qd9nJO6zjceK8AVC7WJFy1b6lTYvdZNDLDkS0QDXlg9Rq7d5qE1xfx4kk+s
         ghaTTUhwl9qQiQhRhd1QDjZMuozyRi6NmE0rr46a1tDNiIXwqJTLPI3PUYZOyRwDkROR
         R1tw==
X-Forwarded-Encrypted: i=1; AJvYcCXFd732coeoIq/lpliX56zcyXM2/c93awB9AjiOtUkIHIeOLnJxbNdX3aGNF2Dbbv2MY70/7Oz/49LdX94U@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RkP6NthHjakWT2h2kuXhDGZoggNJd7aTN1T0MX1JbmlgJw4i
	fzuuBuZeDEkcAsn3TD5mlJHKNacQ+uC0x95VrFLskgBg89Xg13pvp0cEGTugSrPrOWCJvv1OD6k
	Ypeu79yJZgRPBb/MBrlsMrA2NoMyYuU8=
X-Gm-Gg: AY/fxX6+8Fhfp0L/ui+6u6ZXV2roWp0Sclz3Yq2lv6DI+4qXg0zIwC81MlUnb1H1lBC
	SqXPReUuMCAMUE5joYrMWDD+WJ8liHO76qtYcUbFy2abkqzYGSvTJFjl58zBKZ+yFC96wnlSDoe
	r5cimatAezgo4otJNQG3Y/RRZZ4ADQvtklL0PXa4galLD6gIPPh37H1Mei+rxRw2StTg8x7IeU3
	2UCN8FYFtq511iLEqwjgThrquyZp3/NdGDLiVMUK7JnvANuU9Ir2sslL7P7+GOcJPATNw85BdC2
	x0bS
X-Google-Smtp-Source: AGHT+IGNtKMMEcsVpub3pvnWl8mPBBVsnyogUJq8Km7gtnKFPujIzli01C84cufrl8ktpDilL5lamsD9MkT/ULCSDEA=
X-Received: by 2002:a05:622a:590c:b0:4ee:28b8:f110 with SMTP id
 d75a77b69052e-4ffb48d42e1mr125642041cf.29.1767920710614; Thu, 08 Jan 2026
 17:05:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-7-joannelkoong@gmail.com> <CADUfDZqKu0AN_Ci5fKZEgLzOCMgjtAVhfMbyO6KkX3PYfs4Xcw@mail.gmail.com>
In-Reply-To: <CADUfDZqKu0AN_Ci5fKZEgLzOCMgjtAVhfMbyO6KkX3PYfs4Xcw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 8 Jan 2026 17:04:59 -0800
X-Gm-Features: AQt7F2rWX2duJBYoOYNh_tJvoRawqhCbXGahMmtFCnOn0ZcTRvBmI8rSmnsfwMM
Message-ID: <CAJnrk1aYSUbnv1VvY01MjpDpvNRmz24tz4nj66sZXF4o8R6a_g@mail.gmail.com>
Subject: Re: [PATCH v3 06/25] io_uring/kbuf: add buffer ring pinning/unpinning
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 11:18=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Add kernel APIs to pin and unpin buffer rings, preventing userspace fro=
m
> > unregistering a buffer ring while it is pinned by the kernel.
> >
> > This provides a mechanism for kernel subsystems to safely access buffer
> > ring contents while ensuring the buffer ring remains valid. A pinned
> > buffer ring cannot be unregistered until explicitly unpinned. On the
> > userspace side, trying to unregister a pinned buffer will return -EBUSY=
.
> >
> > This is a preparatory change for upcoming fuse usage of kernel-managed
> > buffer rings. It is necessary for fuse to pin the buffer ring because
> > fuse may need to select a buffer in atomic contexts, which it can only
> > do so by using the underlying buffer list pointer.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring/cmd.h | 17 +++++++++++++
> >  io_uring/kbuf.c              | 46 ++++++++++++++++++++++++++++++++++++
> >  io_uring/kbuf.h              | 10 ++++++++
> >  io_uring/uring_cmd.c         | 18 ++++++++++++++
> >  4 files changed, 91 insertions(+)
> >
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index 375fd048c4cb..424f071f42e5 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -84,6 +84,10 @@ struct io_br_sel io_uring_cmd_buffer_select(struct i=
o_uring_cmd *ioucmd,
> >  bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
> >                                  struct io_br_sel *sel, unsigned int is=
sue_flags);
> >
> > +int io_uring_cmd_buf_ring_pin(struct io_uring_cmd *ioucmd, unsigned bu=
f_group,
> > +                             unsigned issue_flags, struct io_buffer_li=
st **bl);
> > +int io_uring_cmd_buf_ring_unpin(struct io_uring_cmd *ioucmd, unsigned =
buf_group,
> > +                               unsigned issue_flags);
> >  #else
> >  static inline int
> >  io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> > @@ -126,6 +130,19 @@ static inline bool io_uring_mshot_cmd_post_cqe(str=
uct io_uring_cmd *ioucmd,
> >  {
> >         return true;
> >  }
> > +static inline int io_uring_cmd_buf_ring_pin(struct io_uring_cmd *ioucm=
d,
> > +                                           unsigned buf_group,
> > +                                           unsigned issue_flags,
> > +                                           struct io_buffer_list **bl)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +static inline int io_uring_cmd_buf_ring_unpin(struct io_uring_cmd *iou=
cmd,
> > +                                             unsigned buf_group,
> > +                                             unsigned issue_flags)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> >  #endif
> >
> >  static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_r=
eq tw_req)
> > diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> > index 8f63924bc9f7..03e05bab023a 100644
> > --- a/io_uring/kbuf.c
> > +++ b/io_uring/kbuf.c
> > @@ -238,6 +238,50 @@ struct io_br_sel io_buffer_select(struct io_kiocb =
*req, size_t *len,
> >         return sel;
> >  }
> >
> > +int io_kbuf_ring_pin(struct io_kiocb *req, unsigned buf_group,
> > +                    unsigned issue_flags, struct io_buffer_list **bl)
> > +{
> > +       struct io_buffer_list *buffer_list;
> > +       struct io_ring_ctx *ctx =3D req->ctx;
>
> Would it make sense to take struct io_ring_ctx *ctx instead of struct
> io_kiocb *req since this doesn't otherwise use the req? Same comment
> for several of the other kbuf_ring helpers (io_kbuf_ring_unpin(),
> io_reg_buf_index_get(), io_reg_buf_index_put(), io_is_kmbuf_ring()).
>

I think this makes sense and is a good idea. I'll make this change for v4.

Thanks,
Joanne

> Best,
> Caleb
>

