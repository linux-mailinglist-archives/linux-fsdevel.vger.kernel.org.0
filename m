Return-Path: <linux-fsdevel+bounces-65392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C37ECC03A93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 00:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1A919C70CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EF41D6DA9;
	Thu, 23 Oct 2025 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irAGvhiP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532861C3C11
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761258030; cv=none; b=JIN6m8qoHNtxr2FvT8nucxUNMx5MQNKCQB4/tbf6IqidCZPZ30TWD87B3pJY3Kw4mKjHcdQA8eGaZJj+BX/1nOHTEGQ4oE49w+hPV90oJvr35VlB703Yq5Bta9JD4fvU9N9YDuULmOr5g8NRQulut+LpbH0/RQc8D13eTEHmOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761258030; c=relaxed/simple;
	bh=KciY27QQMOkLD7+yuXUbIa6MgQXQkoNkp0Dcz2MRORk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlhFdYYGF/q2zAGMt6vO52W5pOK29IswvurdHLpZvGSUUvP9MdJMJYiuxvu4c1LqKHImko7qBWUWmwlcG9cmiVqYLABgdwI1mzGhnINPNMoXkuqOwNSluQB98/dUIWQMyIUjF/hhD+QtF7IbcQUF64sJRSrN9HkO6D6surtpZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irAGvhiP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-88f79ae58f0so148991485a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761258028; x=1761862828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUeufiygmp+TFVkFWpVVfVawxfr5Dhy1bx36UCrMzZ8=;
        b=irAGvhiPJjrpkGUsvwBYTQkxi7qA/ijwHkQ2Tx43iT6d7tcO5fyMCa8Cc4KEf7a4xP
         Vym1VgCDfyLynYSKK3R9Q5P/OUZaa5pPS4/SG9Zyt+Mu74ay8jYMvCOkt4uNAna5mRvf
         3JkW364dUojcCW9z3sx1nvSmJsvltA4UkqaPaIVaLdD/1ZMixgD07xZubC/D4lnQVsm+
         yBbGQA02zfJGHOuGRhHu8Lp3w7MGuy0eTww9VU0Z0GUyAA3XoC33ETGMF/7MdseV1rRA
         Jni4+bRNTu9YV1av7mzN8zdGd/78ZLH8a3nrv3IbgjoLLkSeiGonOhxbH220rqsSfBwH
         R/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761258028; x=1761862828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUeufiygmp+TFVkFWpVVfVawxfr5Dhy1bx36UCrMzZ8=;
        b=Xh10eUiqSVe3YXs9dNum9wV8YLw8qIBBTr6GBeJC3wgcI002j+UxkjtM7kH6w9pN/f
         7ASYsO1mIT0T+KptG1SIMCXDRAWH2D4RLZ2Y3bu6IA5KkUddBGIQvAjHspsjYoq9OREs
         Tnrw2EPB1MtNVO0EqbtVLLtJYb1GdZGV7E9YgttperJlyJVyNjGdAJVeSXihW5DUk3ws
         pW63+GDvAyePdW+/GSdJKkjlrZHd3F6PTUjSZ43s4PmhC3rrjtlKEMX/p62OxpbtSDyC
         CUprzMjD9zRdiLlmxth9i/3N3Xo93cX0QauFncFhb6z8SSQtvkCsN3wZ91RhQiz5ND4w
         9vnA==
X-Forwarded-Encrypted: i=1; AJvYcCWtjBBuEzfBfuLHMBE2JuLKEJOxvcRaguPbRh+ky8C/ftYQIH+pGa4J47JKMiW00eGjGi7vWV7Y+j2SAGXl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4bZ05CSAvnR8p7goqDcnzUYxiCOyhdnR7dFfVfA9GbcURw/QC
	BXDHOg5HbVf8AruKsL4ies8ZdFJ3wuk1vE5MVTZvx1rCXenxeIApyvwm/E6Y7FGPhctQ9UfnKjp
	I6ZHPZSSGuI+dVemcI4Hq8R6TgR9Yto0=
X-Gm-Gg: ASbGncvH2b3hUrSes/rIGFEebGD/cDDrQB8Rm7Ypp773MK7AjSu9+/KIczlA2FXTNij
	hHNrRF0RniY2TEA0mU7L8zWOZUE9Mbcm6eXFxSLLW81cKmecaIFeQdS1QzDElK9HwRUGlU/jVzQ
	R5m0zYuzrpEOqpid/Qf/AZRd8RkHTHrTzYmWwOgI//q806TLNTVjDgTxJ2Ny+CGp1pm+j9ZGSGy
	J9WL3ULOR4eBjlVne4ZfERTgXxMIG64LYws8Vkx9g5L949JkR+id+cTN766pn8AJzWC+1HYRVaQ
	t70HiGl9TuMU8Tg=
X-Google-Smtp-Source: AGHT+IHOzQxkEfBA4KUWUPkVR/jHtf+5Vt2vGFe0Vb0IEV1hFrlxazNIjfdHlXxt5zwfZIA/fJLhxNoEVh8MTGzayCc=
X-Received: by 2002:ac8:7d50:0:b0:4e8:a608:42d5 with SMTP id
 d75a77b69052e-4e8a73e56b5mr300021871cf.63.1761258028161; Thu, 23 Oct 2025
 15:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022202021.3649586-1-joannelkoong@gmail.com>
 <20251022202021.3649586-2-joannelkoong@gmail.com> <CADUfDZoeyDg2F1aSOTqg_7wANxH_LUuSGjiA5=-Auf5TDdj8AQ@mail.gmail.com>
In-Reply-To: <CADUfDZoeyDg2F1aSOTqg_7wANxH_LUuSGjiA5=-Auf5TDdj8AQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Oct 2025 15:20:16 -0700
X-Gm-Features: AS18NWB_-a7lDuV3iK72JDXa0mwszeL49PrUBynHYA2NdS-ssEPZqj_JgF2nWpY
Message-ID: <CAJnrk1YT=raaSxSt7cE6w2YW6isn-HuJb7HtcXSUsKNjUpMffg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] io-uring: add io_uring_cmd_get_buffer_info()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	bschubert@ddn.com, asml.silence@gmail.com, io-uring@vger.kernel.org, 
	xiaobing.li@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:17=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Wed, Oct 22, 2025 at 1:23=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index 7509025b4071..a92e810f37f9 100644
> > --- a/io_uring/rsrc.c
> > +++ b/io_uring/rsrc.c
> > @@ -1569,3 +1569,24 @@ int io_prep_reg_iovec(struct io_kiocb *req, stru=
ct iou_vec *iv,
> >         req->flags |=3D REQ_F_IMPORT_BUFFER;
> >         return 0;
> >  }
> > +
> > +int io_uring_cmd_get_buffer_info(struct io_uring_cmd *cmd, u64 *ubuf,
> > +                                unsigned int *len)
> > +{
> > +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > +       struct io_rsrc_data *data =3D &ctx->buf_table;
> > +       struct io_mapped_ubuf *imu;
> > +       unsigned int buf_index;
> > +
> > +       if (!data->nr)
> > +               return -EINVAL;
> > +
> > +       buf_index =3D cmd->sqe->buf_index;
>
> This is reading userspace-mapped memory, it should use READ_ONCE().
> But why not just use cmd_to_io_kiocb(cmd)->buf_index? That's already
> sampled from the SQE in io_uring_cmd_prep() if the
> IORING_URING_CMD_FIXED flag is set. And it seems like the fuse
> uring_cmd implementation requires that flag to be set.

Thanks, I didn't realize the cmd->sqe is userspace-mapped. I'll look
at what io_uring_cmd_prep() does.

For v2 I am going to drop this patch entirely and pass in the ubuf
address and len through the 80B sqe command area when the server
registers the ring.

Thanks,
Joanne

