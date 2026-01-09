Return-Path: <linux-fsdevel+bounces-72965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21861D069FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 01:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 953C8300CF30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 00:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12C1DF723;
	Fri,  9 Jan 2026 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLxNKDPh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2161A9F9B
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767919109; cv=none; b=bvuuSE9tWrZ7sV2l0CLw+bC+smm7g9dLuEUpVas1SQKZlOOMsgsnnqpZA7yyQT8rM4db7/DTvnKStCd50boVlz40PNMWlYvZE+UCoedhKiFfZVXz7eC8Jf2+LgqFmFKGB2/vKssE95W2gd5pa/Vmb1pW50gqwT7ru4t+D6q7cg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767919109; c=relaxed/simple;
	bh=2Ja+vuDMzM6XAOLx2DkiGuo2zzMfRPI9eTb+dL6CJkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3B5y+KTG0WqAW3HfMeM17+wWbOQOAVK8Xwvsk0UARtvMuExBYzAlKmGJPdgmHE3UYBceZGVn9XXCpumv64Mrn3O4hUbj8kFp5F45jQlnBtsTASYnU9AMKoxsBnv4YyvxcDVzNB5FCWSLzD11ngox3VkxTQjNd9G8NPZVvO8A0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLxNKDPh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ffc5fa3d14so10924101cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 16:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767919107; x=1768523907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA2wrUNNfeaUB8bBTIRPXsTlDkNkN3e3OFp4KgAdPxI=;
        b=LLxNKDPhurCh3BF6DmO5UUYkg2RjVXCVgMNda50MtXMWnYhNfL5mO2WwKAphy92QA2
         4yGNWO/8xwIg7vwQvLUeF4GKUv2VE0l/w1lWyvKR4QK1rqPUNJw8mBFH4WKbQgG8bvMW
         KK42aEGsBbTpodPkOti4Qy2nozRz7cMQ+zuyyJDRNbDnkUySnNwL5YcwRI3f9n+jW2or
         Bhh5hYe/RIXRbVowJdNT2WjaqQZWjINMFeXjjkRdvlNGCzPYCobqXvc3ekq2M8ioEwxz
         MURheUo8KZ6lYPd3SAdh6YgB9rGLMDkentxHZRfZsHVgx9kTzaTURj3vHxlYqLHuTrLL
         Vjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767919107; x=1768523907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZA2wrUNNfeaUB8bBTIRPXsTlDkNkN3e3OFp4KgAdPxI=;
        b=SuwGZBiwQTyfytHz8jNrsoNwz6wTvV8Mt3leKDKCCUUAgC7Mx2zl0RqD+naCkaRxPj
         +nrZ0IfC2pZ46DqEQUzt0rcFyGRwJ196HVyXezQckV/2LwP8P98Ga8FyUTiganV+V56o
         TS4LRgPxYvK+b31SiawtRjOr1LeCaQ5GOwHw+kEjBzPTXGV6pOHxichbTwg8rm5awc+B
         ZFH6d2Ih6TwbVB4fWFwtTwU/ip4D4dEH7d7fCR2NLCqdoNCczpAwVrLSg6Q1+8nRo6p8
         3jejNyzfxoa+EOktJPfHDK0mPfNv1cRoUAGa+iBFAF5100oVig6HII6SJbVZ5Dr5IU6l
         F+ag==
X-Forwarded-Encrypted: i=1; AJvYcCUiL+eLyQl2y3L8S0Fng1skq+vBHi9wsjP81971QLYWeUcr6XK0xujGPbD1edIHsZqOInS8DmYgLPDPif6E@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKHwnTB9MtpV+YavO/tL5TAyArFK5cskrMgv8Yov6qlgw81mZ
	G/BTv0jjjCnRodu/KSJOd3Nzy886tfnrZrWQ4iSX3QYNWdkM1Fo7vOUHHKEhUtOjHkZJnwldCZJ
	KSLaQ2os8hyGYvIb3iczFVEmjKNaaeCY=
X-Gm-Gg: AY/fxX40Yt49fRiHjZ6ar2qcX4wNEF2+O92FaJj9/BgJboCqFBxGeodUWsjVRO0gBvM
	MCd490Ymn0duAIcSVsIfNxguI9PE+yT7nra3cpYYJmIoz9y8lM96p6z6Dwf00P6qB4sJVUVc1ZT
	S6wUhX/mvJgSLvYRJazM2myvAeNUng0erxMqe5bgElSwbCqdj0mzq/0erXIARJxf5ZJOH70GHxH
	h5G5QcfeHEbCSb8oSPOLGkN/28mYiFzAeowi3ddlVQZuT9gaP1lSg8Ui9MHyB1ntb8cBQ==
X-Google-Smtp-Source: AGHT+IH84R5SLiROEgQ9e7cxds3MkGSVNv/ZcRsl2xfFmsxfuGnR0HV9/fhCJ9VxBTJQjIvB8S2dSZXXWI5Eu2Zwrew=
X-Received: by 2002:a05:622a:5905:b0:4ee:4422:5a75 with SMTP id
 d75a77b69052e-4ffb4866306mr113811961cf.14.1767919106610; Thu, 08 Jan 2026
 16:38:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-11-joannelkoong@gmail.com> <CADUfDZqHhVi1RY71dvEFbWsHmrzLbTSgev5o8yRXxExV5=XY2g@mail.gmail.com>
In-Reply-To: <CADUfDZqHhVi1RY71dvEFbWsHmrzLbTSgev5o8yRXxExV5=XY2g@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 8 Jan 2026 16:38:15 -0800
X-Gm-Features: AQt7F2pylK_hSqMqxiXmGQu7R6bV5DpAl_WfJKo8Cv6Oi5s-3OROqaGWj5_cmYY
Message-ID: <CAJnrk1ZQqgQmQyC8v47rpP0TrpcwGRzw6r9w4Z=TQO8EpQOF3g@mail.gmail.com>
Subject: Re: [PATCH v3 10/25] io_uring/kbuf: export io_ring_buffer_select()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:34=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Export io_ring_buffer_select() so that it may be used by callers who
> > pass in a pinned bufring without needing to grab the io_uring mutex.
> >
> > This is a preparatory patch that will be needed by fuse io-uring, which
> > will need to select a buffer from a kernel-managed bufring while the
> > uring mutex may already be held by in-progress commits, and may need to
> > select a buffer in atomic contexts.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring/buf.h | 25 +++++++++++++++++++++++++
> >  io_uring/kbuf.c              |  8 +++++---
> >  2 files changed, 30 insertions(+), 3 deletions(-)
> >  create mode 100644 include/linux/io_uring/buf.h
> >
> > diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.=
h
> > new file mode 100644
> > index 000000000000..3f7426ced3eb
> > --- /dev/null
> > +++ b/include/linux/io_uring/buf.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +#ifndef _LINUX_IO_URING_BUF_H
> > +#define _LINUX_IO_URING_BUF_H
> > +
> > +#include <linux/io_uring_types.h>
> > +
> > +#if defined(CONFIG_IO_URING)
> > +struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *l=
en,
>
> I think struct io_kiocb isn't intended to be exposed outside of
> io_uring internal code. Is there a reason not to instead expose a
> wrapper function that takes struct io_uring_cmd * instead?

Oh interesting... I see struct io_kiocb defined in
include/linux/io_uring_types.h, so I assumed this was fine to use.
Hmm, we could wrap this in io_uring_cmd * instead, but that adds an
extra layer and I think it clashes with the philosophy of io_uring_cmd
being a "general user interface" (or maybe my interpretation of
io_uring_cmd is incorrect) whereas this api is pretty io-uring
internal specific (eg bypasses the io ring lock which means it'll be
responsible for having to do its own synchronization, passing the
io_buffer_list pointer directly, etc.).

Thanks,
Joanne

>
> Best,
> Caleb
>
> > +                                      struct io_buffer_list *bl,
> > +                                      unsigned int issue_flags);
> > +#else
> > +static inline struct io_br_sel io_ring_buffer_select(struct io_kiocb *=
req,
> > +                                                    size_t *len,
> > +                                                    struct io_buffer_l=
ist *bl,
> > +                                                    unsigned int issue=
_flags)
> > +{
> > +       struct io_br_sel sel =3D {
> > +               .val =3D -EOPNOTSUPP,
> > +       };
> > +
> > +       return sel;
> > +}
> > +#endif /* CONFIG_IO_URING */

