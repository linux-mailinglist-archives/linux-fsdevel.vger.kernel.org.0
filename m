Return-Path: <linux-fsdevel+bounces-43003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87566A4CB91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 20:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E211892312
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EB322E405;
	Mon,  3 Mar 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJQiw+Id"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73742135B2;
	Mon,  3 Mar 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028818; cv=none; b=RLaZ0B7iOD1ddrYC+lyBA2IPu0t0cX860/B8ZPs+CcQbs3R3FA6siiSBuI2WabBYe27BE+2iqUTMkFZlqkxZdlumVrRcmOkM0RJPtoZO13YlnI3v0TjGDfJ8DGjAc/14WAyQKvqjl1+nTTPiHgf7dC21wc16Bf0jgyBEdoFJ+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028818; c=relaxed/simple;
	bh=hvVPfbGXsdJOztV5prGhWkrN0mN9FMdMVPgi70bhb7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/+j1nWrAXrfIaGBnUpPdpEVjpy3iBhgcz2BGpCFdfrSgb1hKGMDjj/+/j+ORgX2VpD6eXyG/FO/GSt/I4nK50nWlxOKZOJgkDzsbZ88USbfk/8sbz1+PmK16fQOIryjVtP9TDO0JBNU7HuYnlKAAj2PD7siAKjPcPWk1L4AH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJQiw+Id; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so1675557a12.0;
        Mon, 03 Mar 2025 11:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741028815; x=1741633615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzobvjEsTmQfmmqq/BaMj0/5ZTRBS5Xw6V4zfXeMeRQ=;
        b=QJQiw+IdJf3RgBhsA+Lj+RMRu8/tju5xBPF5wIfvxnt1+z7RnNQxVuMBvVxBg5kJzC
         bVF+rquZtCDFfI1ggw4TrEYoUbBbe2OVnFfWpUuIdY20RGlAghcmKAM0NT/8yHAqR5O1
         2jkWnKRloE0U5UW4AsBrfXDVgLwVlOqcsHwKuqa5R8mCiv2w4ovxyC8Vfjp5gVvU95O5
         hAS3ggZcQzC08eHLSck8t+il9NubOCZtfS/veU9XXbF2gt9AY2qo4v9/RzH3z2RDsh5j
         WDvgBXQ4/Bl2NwRz1OEZSdGzi473KizEJfRb2aYIWqmCs+//jjuVJvkxTHhF8MIdlrlH
         4Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028815; x=1741633615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzobvjEsTmQfmmqq/BaMj0/5ZTRBS5Xw6V4zfXeMeRQ=;
        b=rh6SQzrTng+Fqb6C8k3cLz05o+PjEuMnSpyAfL5XVuzhdr3aKg9NU8hupjEoGCKXks
         gTXn6BQ35pc+wGLWJHpURvR7d5GQZBPXye6qU0D/SWUwWUMpt1UYKUh7lvNm/5tyA1KI
         avh1LEjnrITjJr/tUk+P8+SbLOr8pzMGQNiiiGQE/Sv/xJCmpmGS2ND4CKxboJBYdTQs
         c8ajf6McGYvz1wPhtN/DhGDMueOPg96lUVarXVDxneldJtz9MzUC71bX3sGFiLd06nZ/
         Ug5Z2ANQVpRguxvJ0yNa/LBBg3bPvKy1NOVE8owLutwEfSnZA3V6OYFXHvRLkyy+jc51
         lTUg==
X-Forwarded-Encrypted: i=1; AJvYcCVAHkZlmbzj9b56BCpgEbvqv/42McoIaDeGnnVby04fkRbvlSvcssf8zc/R00+AZE8MQ5oohEJ5CYKw/TQN@vger.kernel.org, AJvYcCXlB7XYHNsohDgSysO0XvCfk4XPl0SmXCli4nUiDimpHKlsn4qkhKUpj/4JKqO6N92hXc79sYXy9pprDqWG@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+B6Twqni1toJlueivYs37A7w5MvwC4ItoZpODG4o6OhZWLw1
	zCNa0SJz9AuQYqFjEf6ApQCgUttiMNuV2wlqEACUP4QTZt7J+d2d1RauJc2HRZCPKRRtl2fugSV
	Svf5WTA94ejPoK6OPEAlTQ4GFUO8=
X-Gm-Gg: ASbGncvUh3ZhSP883eqVb0iyycIjktbCb9APalbzRyTZkUcttY7U9EW7hVrUqvxf/j0
	kUHL1G59/d4Gd3qiRzko3+viQ8OD2X+8M4E7HPSUdBwdUAm8aYzkz6udlrR1ZiRY+VsJGvCBH6I
	nyWCzKsPmEhJQyianIGtOcpPOk
X-Google-Smtp-Source: AGHT+IEBMB50/uHZFfUsc+YT8+rxiD0OtAnvhvFj+TWLWIMhwAZEhKbQ2lfaxoBF1cSU97eh6SGPrAH1mkd7mIsCwFw=
X-Received: by 2002:a17:907:6d02:b0:abf:6bba:9626 with SMTP id
 a640c23a62f3a-ac1f1031e63mr35045466b.12.1741028814721; Mon, 03 Mar 2025
 11:06:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com> <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com> <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
In-Reply-To: <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 3 Mar 2025 20:06:41 +0100
X-Gm-Features: AQ5f1JqwaqTntE0aiFnL8IjG0WCd4LRcTepL_RrneL9DxrpiLNFaYihsffs7Vdw
Message-ID: <CAGudoHGDFS=2Wu0khGZOLNnHhWCB6uwyjYCPy_ZHkQNaou_RkA@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Oleg Nesterov <oleg@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 7:56=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 3 Mar 2025 at 08:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > The stock code already has a dedicated routine to advance the tail,
> > adding one for head (instead of an ad-hoc increment) is borderline
> > just clean up.
>
> There's currently a fair number of open-coded assignments:
>
>     git grep -E 'pipe->((tail)|(head)).*=3D' fs/
>
> and some of those are under specific locking rules together with other
> updates (ie the watch-queue 'note_loss' thing.
>
> But hey, if some explicit empty/full flag is simpler, then it
> certainly does fit with our current model too, since we already do
> have those other flags (exactly like 'note_loss')
>
> I do particularly hate seeing 'bool' in structures like this. On alpha
> it is either fundamentally racy, or it's 32-bit. On other
> architectures, it's typically 8 bits for a 1-bit value.
>
> But we do have holes in that structure where it slots.
>

I was thinking about just fs/pipe.c.

These helpers being used elsewhere is not something I was aware of (or
thought would be a thing). The relevant git grep makes me self-nak
that patch. :->

But that's some side stuff. Not only it is your call how to proceed,
but per the previous e-mail I agree 16-byte head/tail and a 32-byte
read would be best.

Hopefully the AMD guys will want to take a stab. Otherwise I'll hack it up.
--=20
Mateusz Guzik <mjguzik gmail.com>

