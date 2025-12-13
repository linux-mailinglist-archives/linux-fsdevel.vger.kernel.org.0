Return-Path: <linux-fsdevel+bounces-71239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E213CBA500
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 06:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36C9730A9541
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 05:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425EB1E22E9;
	Sat, 13 Dec 2025 05:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkHSvc9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F025182D2
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 05:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765602680; cv=none; b=oftWxLaa1/JyqbXxBf1rc9lhuHa+q5STikqWZz8EEAV5FR29inHtGlZgMDz+/yhcoYvgbnI3RAb9RpMDnYM2Ts+ktsKdsUgktNFQdk0myeJC4twdH7HnDwxMrnhOEIwt4VBrPAD4oQGwD4gi5bMKXTY6H25JpaKGF5LaHA20KdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765602680; c=relaxed/simple;
	bh=syEV0/FLiHAZC/PAiurnsJLsnmdLwzHGRNM7kYJ3f34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOPL8GOhI+IRj9rFruHAyEGCbIgTk/rpNRnSCg0ek1A2gkrJQzQ311lRcPMmXsjcHgdDqLMSTsXpLMTNjalvZPg8Q6LCn4D/B9nprejRhYs1R9zS04m7NH0sgEdMdt4G1N/pg2ooiKCC2CEtgtngnHEFR2UvFziR1bbL0AUfgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkHSvc9O; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4f1aecac2c9so21109701cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 21:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765602678; x=1766207478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oO5mXc19/bkHG/OQGgSGSbA7Gcjm1z9eNxoGQZ9t+I=;
        b=VkHSvc9Oi2JBzsRKuWS3MDfb7LqnsdaZmclzB9fjqVByXfOJgkStSzmJYSDSZD6+/u
         LYBQYd29M47yB2ShQ9YW020Mb53yqp4Zeb/igqtGaY79tjTrLUpQuBBckkJRejT7Bk/Y
         pDy/9CVKY7w5TCCXofXymafURT94wauKVBZefP/up2r0cf41O+RLJ8fmv7Q+Bcf4qgpZ
         35HDKuDeTN0SOTbr7eUAQgdeF26qk/4u1smCeCLcx0a2eLKRdDRhLNoYugJAsW3ltIKw
         0msLt6CIHsD2y//CMlJAvjx/tZ1x53pWQhpvkT/UX7JvuQtSc0hUylxaCcJjph2ctz/B
         2OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765602678; x=1766207478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5oO5mXc19/bkHG/OQGgSGSbA7Gcjm1z9eNxoGQZ9t+I=;
        b=AYtdMtswqsO8fNYsgl9y8zMbjYaRYgjSovIHF7fhjFkaMbBT10sXznahwdKBUnlaNI
         sIHVOKWUWgAcY1s74U3MpRql2so/PmLf4jxnAbmHSBGnK3ov0AEtHsHlSu27U2FGvwAd
         ff7nGWl7RaLkclGRzrRmpJmBfaITbGJIbE4n3GHWybTMW31p22yKRPE/yyjhnshenQpm
         Gbhfd7wZJS40IoxOciTBsSDfCXi6bMmdFap0MvjYS80dqulB9rf2q+qlgsYxuZuukapa
         APAZ/xfZ4G/z6sc13/uJ39bmp5us0noI2sBSt8k9d/J6D3ZG5n600j4dVS9jnFVFxpPX
         lYHA==
X-Forwarded-Encrypted: i=1; AJvYcCUyP1L0wsaUda99pUY2JoqHmbtePpjGjJFfuX+RgUevVNlUTfuAzf2krOa8ZvBF3X6FnsSfYirRDP3uM5IW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0JfYPLoPyyBYnOH8GaBVq2v0/GkKMXPGGj5bUFZiOMmjSFiuB
	QJtHBFm0l2bhcMBmGGoDBc9Xy+BrsoiQCG6bDctH4fDtuIVfHiuT7gzbV7xjQFEBjNUIhXon+RO
	hxfZqD+xAghzWa+1WRkYOmlrCH719SMc=
X-Gm-Gg: AY/fxX4KS0JiZ4acF5Eju4edvPCiOUcKO8/FMa7UpivoN8DoOHxQi2QnuA1I8Hl15aO
	Ioi3AtoQTTg7kmKunCelxz8oRoMdB4azEGk8bE3tUhEJAubjBJmB0BTG+FrGwfm1eITGtOSx7QO
	cHmYa+FLzBohNXOSGqV2BGcai3Fm6isi/bDOrb3imS8ebk5PmcugFYJLhMTp6bVKQWMA7jVJcZM
	9UWCvqkMx4onxgfovmZdbXCexBh1LFA8TGF/XtOzq9yx2tuTrUwoO6Q/QKz0iOMCez5o6cG
X-Google-Smtp-Source: AGHT+IFQfKyFwrVgAa+rr2QG+mOZUqAjIMt/0Uer3JkOvhELpjGEVT9Hh/oikQx7a29AZ7c+bGtB4lPzPQvpV4H6kb4=
X-Received: by 2002:a05:622a:8cf:b0:4ed:2715:6130 with SMTP id
 d75a77b69052e-4f1cf614407mr57782791cf.36.1765602678144; Fri, 12 Dec 2025
 21:11:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
 <20251203003526.2889477-23-joannelkoong@gmail.com> <CADUfDZp3NCnJ7-dAmFo2VbApez9ni+zR7Z-iGsudDrTN4qw1Xg@mail.gmail.com>
In-Reply-To: <CADUfDZp3NCnJ7-dAmFo2VbApez9ni+zR7Z-iGsudDrTN4qw1Xg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Sat, 13 Dec 2025 14:11:07 +0900
X-Gm-Features: AQt7F2rpMQBtSK4ORLC2iykOw4xczA77OTsnQlOWjzyhrCf2eU8E3aMFXaonYHo
Message-ID: <CAJnrk1YO+xWWAQtEvk_xAsoBStRR=o0=t3audmmGrEpKpYGPpg@mail.gmail.com>
Subject: Re: [PATCH v1 22/30] io_uring/rsrc: refactor io_buffer_register_bvec()/io_buffer_unregister_bvec()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 5:33=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Tue, Dec 2, 2025 at 4:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > +int io_uring_cmd_buffer_unregister(struct io_uring_cmd *cmd, unsigned =
int index,
> > +                                  unsigned int issue_flags)
> > +{
> > +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > +
> > +       return io_buffer_unregister(ctx, index, issue_flags);
> > +}
> > +EXPORT_SYMBOL_GPL(io_uring_cmd_buffer_unregister);
>
> It would be nice to avoid these additional function calls that can't
> be inlined. I guess we probably don't want to include the
> io_uring-internal header io_uring/rsrc.h in the external header
> linux/io_uring/cmd.h, which is probably why the functions were
> declared in linux/io_uring/cmd.h but defined in io_uring/rsrc.c
> previously. Maybe it would make sense to move the definitions of
> io_uring_cmd_buffer_register_request() and
> io_uring_cmd_buffer_unregister() to io_uring/rsrc.c so
> io_buffer_register_request()/io_buffer_unregister() can be inlined
> into them?

imo I think having the code organized more logically outweighs the
minimal improvement we would get from inlining (especially as
io_buffer_register_request() is not a small function), but I'm happy
to make this change if you feel strongly about it.

Thanks,
Joanne

>
> Best,
> Caleb
>
> > +
> >  /*
> >   * Return true if this multishot uring_cmd needs to be completed, othe=
rwise
> >   * the event CQE is posted successfully.
> > --
> > 2.47.3
> >

