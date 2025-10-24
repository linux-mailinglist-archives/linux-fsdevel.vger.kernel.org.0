Return-Path: <linux-fsdevel+bounces-65396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B075EC03EA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 02:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E3CB3582A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738AD2E0B68;
	Fri, 24 Oct 2025 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeytUpGs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC802D9786
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264015; cv=none; b=JMMcbGRO0rJ7OwGwzE8wd6rVxcH9pUaLnaKba/4JlReiZJsAin0Nu/SJZIAtNNSKYwA3/xe8KbCBEjKDgNf2b3hIywlAn7NsCoth09X2aAL3G8KfUbNdA6/gk+MLn2Hgvduwd9nm/c0S8q2NW06uADN4+c3tEzhHT/uUuhvO5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264015; c=relaxed/simple;
	bh=0IzC5y2SId6iPppGFHEwKe3OBHT3Twip0IZHWYCDQuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRkJKruLuv9RAzXPqAALs8ycb171dPmuUlFMXo4QSe+zON2XWyBgP8xVP8W7dlykvCWu+zzI1qOO5+6lRbfyVJQkkmatE9lnm6HT+X/EVV1u4kT4mKh2QF7hdj0MtKM8ulcxHNStVgJa9Kty+caktofmggWeZN+9Q9QX4Km4sBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeytUpGs; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8923b2d9954so98106685a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761264013; x=1761868813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuyE5hvy13CKVe6q8HkNS5JRzOQdk7AaqAJ0KTfxK3k=;
        b=DeytUpGsRjGgtLce0rde8M0cmZYMVgZSf5fGXA1EObyu7dbVjA9UAEx/2sLcjTYd7i
         UHokbVCWUxldr+Vn/lvRiQCRumFdtXLF2iYuAFSpMj3b24sY5KIiDzWUE7QgCgwXvCgy
         UF3BdIToTqMVx0yDPSpKPoEuYk+KsJrwfdagfjD76+N6wlVsHFXGnrFU0Pqq4if/YnLx
         RjxsXl90B4CdB+VKIhVP3mbr0aJDQeY6CxyPOQhv1GQcDc43J09RvDec0VJhqGTEOw6j
         VcfN23MIyh/WaJ2aKwnH3BK/UvFvApYmZmyB8wqekeqVrtrmrUm/uKBMXrw7Rn67SGng
         AVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264013; x=1761868813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuyE5hvy13CKVe6q8HkNS5JRzOQdk7AaqAJ0KTfxK3k=;
        b=NG1GvA/O39owG+6hQHkarNxBPqnCZys/S+hQAfcn3Y4nrt1sbhRXqmnYI3jU930iAg
         MMn2RgFV+35OZhBBT6xkA4mL+Gc8977sSFk8oSaL8HGGxZtrCo1rtarrH96ytw6Ev+Ve
         GYdU8+FbgPu7WBlbZi07WEBJRlRwhk22RNN+8BNBJ+q6TZ3x8iVZvPgMV94l8LsSrc4M
         /YCWEmmTu7J8FWCIHSqb18IpasrudtZC6CxLh8Nz69xZdR6GRESnI1dBqCnqMietirMe
         URhroQutCFl0s+CAyGRj4UkCmXC4bDLIWcbwY4cgk4gBaC0XqwMkfS/Cn4MtiRk5Tpjs
         Fl2w==
X-Forwarded-Encrypted: i=1; AJvYcCX7NUKbt11BZ52f0CzR8w0t35dhV9O9HFXZbqFhnL6fp7yWq84BnoZrm/T60jZ8qtNjcMnnyuMYeVQnEfxV@vger.kernel.org
X-Gm-Message-State: AOJu0YzN3BrwWuWLh08uPhbQ2IWVg1swFneu3mVRE4gkhP31aEveDsHy
	N8YuXARGezo8uwCb5HtgGwdiBhGwqmniR8Msd8gR0jQibq9I69xpxLUVXm8hGXtE1t6oqZl2HdW
	M52NwSDRVn/GnSCRdBREE+BejnoW8wN8=
X-Gm-Gg: ASbGncswnq5yO9LkHSO1XbA89L6UwB2vbyq6u9OMMdwqchZwGKb9VirHrWqD28f41UF
	ucL/QoRhR//ScSeCD5DGd/HZ2aOuWvUC514qTZtfeX/ALUBxdVP7K/z09vqNxOTIn39lnMHomn1
	3Z3Cyr+x3sQloLdIX3RNONovsTJdaApYCN4h09Q49NQLYw8pzpz2vs+YQfRnz4xdjOmjMOe2Uqt
	Q4QAyA9wHSTU8uU/BBmoTbykdLhaB1BAT4Rdt5Cmz5qsVELKkkWDB9MFLoR9VioxDVB6S5yQXBx
	l7tqkV6ndTAm3Ykd+D7P/DFu1Q==
X-Google-Smtp-Source: AGHT+IHc8Zg8xR/489kls1AGI4nQouWKVQJZ3IcQRrUMHze5+AHerK947JDwJs1jUmlAf3fvOdi08EIO+bJObK5EMtE=
X-Received: by 2002:a05:620a:2a10:b0:849:d117:e86a with SMTP id
 af79cd13be357-89070fc5496mr2922702185a.59.1761264012376; Thu, 23 Oct 2025
 17:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022202021.3649586-1-joannelkoong@gmail.com>
 <20251022202021.3649586-2-joannelkoong@gmail.com> <CADUfDZoeyDg2F1aSOTqg_7wANxH_LUuSGjiA5=-Auf5TDdj8AQ@mail.gmail.com>
 <CAJnrk1YT=raaSxSt7cE6w2YW6isn-HuJb7HtcXSUsKNjUpMffg@mail.gmail.com>
In-Reply-To: <CAJnrk1YT=raaSxSt7cE6w2YW6isn-HuJb7HtcXSUsKNjUpMffg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Oct 2025 17:00:01 -0700
X-Gm-Features: AS18NWALvC90qZiX3Sv9QocGdqGUh0cyDsNHGnF9AvoRBeDTMgzrms9W0esY7H0
Message-ID: <CAJnrk1Y0LaP2htgQUN=NpmTf-Y25hSYM5ZoxNk08jU6ObAeDHA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] io-uring: add io_uring_cmd_get_buffer_info()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	bschubert@ddn.com, asml.silence@gmail.com, io-uring@vger.kernel.org, 
	xiaobing.li@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:20=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Oct 22, 2025 at 8:17=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Wed, Oct 22, 2025 at 1:23=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cm=
d.h
> > > index 7509025b4071..a92e810f37f9 100644
> > > --- a/io_uring/rsrc.c
> > > +++ b/io_uring/rsrc.c
> > > @@ -1569,3 +1569,24 @@ int io_prep_reg_iovec(struct io_kiocb *req, st=
ruct iou_vec *iv,
> > >         req->flags |=3D REQ_F_IMPORT_BUFFER;
> > >         return 0;
> > >  }
> > > +
> > > +int io_uring_cmd_get_buffer_info(struct io_uring_cmd *cmd, u64 *ubuf=
,
> > > +                                unsigned int *len)
> > > +{
> > > +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > > +       struct io_rsrc_data *data =3D &ctx->buf_table;
> > > +       struct io_mapped_ubuf *imu;
> > > +       unsigned int buf_index;
> > > +
> > > +       if (!data->nr)
> > > +               return -EINVAL;
> > > +
> > > +       buf_index =3D cmd->sqe->buf_index;
> >
> > This is reading userspace-mapped memory, it should use READ_ONCE().
> > But why not just use cmd_to_io_kiocb(cmd)->buf_index? That's already
> > sampled from the SQE in io_uring_cmd_prep() if the
> > IORING_URING_CMD_FIXED flag is set. And it seems like the fuse
> > uring_cmd implementation requires that flag to be set.
>
> Thanks, I didn't realize the cmd->sqe is userspace-mapped. I'll look
> at what io_uring_cmd_prep() does.
>
> For v2 I am going to drop this patch entirely and pass in the ubuf
> address and len through the 80B sqe command area when the server
> registers the ring.

Actually, after looking at this some more and realizing that we can't
get away with recycling iters across requests, I like your
io_uring_cmd_import_fixed_relative() helper idea. I think I'll just do
it that way for v2 instead of having the libfuse server pass in the
buffer address and length, since otherwise we would need to pass that
info for every request (including commit/fetch, not just when
registering) or have to stash it somewhere.

Thanks,
Joanne

>
> Thanks,
> Joanne

