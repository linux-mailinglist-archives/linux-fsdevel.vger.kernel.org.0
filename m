Return-Path: <linux-fsdevel+bounces-43001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F7A4CB09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB61757F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FAE21638E;
	Mon,  3 Mar 2025 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKN62jzq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EC1E7C03;
	Mon,  3 Mar 2025 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026817; cv=none; b=sjAW+su6kAa3ObldD6P1B/Feh1wyAo/MzUQkjlP9FerE01vAOn5Udw5tj4TzKUtcsj1chKlSxgMVcxvoIYVJ6DWl1rFAizQezsL5aLAV4H3E/fJ/UpfJl2WwG9Wkyfy/oayY0BBSyUod64IMW9zXyIwGG/3RjhsWGfSW1NbMp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026817; c=relaxed/simple;
	bh=X7t0CacmHUpcpJhGItcuM8Xnn6Mn1r21B9z4Wx+RLZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXfjFvuTjuDrJh/e1+2naQTtdj6I6xb3P7E2u1+DB+81U9e4VuLRXtnh9DqHnZsfkujwIwS5GwffMIqTOMNuuJhfXE0ESiGYso/5obcCyyXufmbs2fpcKufcB4iexdllpeVzsI9dE99x37IodP0Od5l4D7BTYBVb80SAjYiKt+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKN62jzq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbd96bef64so758378966b.3;
        Mon, 03 Mar 2025 10:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741026814; x=1741631614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7t0CacmHUpcpJhGItcuM8Xnn6Mn1r21B9z4Wx+RLZY=;
        b=aKN62jzq2nrgAQFcAphKd2aWWPO9tc0T7FrvB+yeoMwZAMhybGwDIttMfl36UbDB9X
         LNj53B3oDFSRHLrtE6wLVl3piEDihvhDl2AFSfQqhh9YHpYspeWYD4H268gA06fBwx1+
         d1PjzZBEm2AzCeKcB10qpvU1n/9r2x0sUK0cJ3qaMF1Sf5CcZHNfkYbmy39G2WMlOgaC
         c9O03bkbJYxJ4Wqh3FxHSaoiiM9QlR1lfQCYbpJXPhZBVfpcRVTcAexaigSADNugk2n+
         v/77MSY2AGuelix6pwb8cgg9DJLGNuFZG9goxbd+hzKPRDC98AOY5NvPyFvkLpUX4HPa
         IP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026814; x=1741631614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7t0CacmHUpcpJhGItcuM8Xnn6Mn1r21B9z4Wx+RLZY=;
        b=IdkFALaLgLXc0Yx/+1Yr8dBYOE+7iutIpEqRz68lavobqhTzkCpA1LcrmGYyH3Ytc8
         pr1pQ1VSOFa3rAbZEZefQFb77iic9bW9KplxF2Qgrxdiaf45NpXKlEpBT6MX4sMXxh1W
         Jv9h0gkHb5vCqS+gG4yIYSNKIFtc0MpfJw4we7CLu/1j7wZwGbjP2adiT5/bzm4AxedH
         mZVuL2J0p2cfwn48u4ZabOfC2WiADrFCpxihc2TFFHI/zmT9Wi67LrLYADmkDXV5R2Nm
         hXPkEHsjc7/uaKMXfqcn0JvinsZyOJpsn3jBMdTMulumvaoospD/F65WtasJhtpE0QyJ
         OGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0mBS006O35I8OBx/9tu+VOcpbiCFs8ABJx++4CGMkriB4x+pgvTpHswGTIC6QKOeQmziumabeMjDgfTxE@vger.kernel.org, AJvYcCXm6igdPIi+BqZS7djAmx+5PiUwJJ6BLBm3Xjo0tI2NOMiItZp2V+wUREdSVsgidNvtRNqBRk4mUHNY10e5@vger.kernel.org
X-Gm-Message-State: AOJu0YyNh8zO0TycRwOt8dkYlhqwujpgWoIu8eRksdlhCg2WUGGw1nSj
	IB5Ol+VzqwQEGl0h1ZrVw0gv6mBuiR5togmswdW3HOlyEPfqTcNqmtqMU6s5ihpwd59PlxrIrme
	lYisnsNy3pXZ14u/iMLf8NqND46x2KEV6ayI=
X-Gm-Gg: ASbGnctkMTwo/jPZ/midtQVPh+STo+XxjDWr4weMpymZxLKKqXapt4ZpWFXAvWKrFoL
	t/R0bpj2M0nIBtNh8GMW+f+Vf+KMtI3oABMVrXRtoLuZA1pfngyHeKl24A2pF45fUjIwwFAAr+c
	uxKqPbqW+JVRSndB+XlFAEY8Wa
X-Google-Smtp-Source: AGHT+IEM5mh0zNC9LcJPthDBH8OtjUn9hOrzsAtZn9C2/MmE4wA9PPmrl3l+s6WJD5vVHHM3HoiTsAdh/3kjR7WGsu4=
X-Received: by 2002:a17:907:1b22:b0:abf:215b:4ac6 with SMTP id
 a640c23a62f3a-abf26859335mr1942194366b.53.1741026813516; Mon, 03 Mar 2025
 10:33:33 -0800 (PST)
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
In-Reply-To: <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 3 Mar 2025 19:33:20 +0100
X-Gm-Features: AQ5f1Jp3WPGBTVafA5aGFgB3i5XGo3XKvFMo6SCtl6TJl7LgydPyRLVBfSK-ltE
Message-ID: <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
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

On Mon, Mar 3, 2025 at 7:11=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> But I don't like the "add separate full/empty fields that duplicate
> things", just to have those written always under the lock, and then
> loaded as one op.
>
> I think there are better models.
>
> So I think I'd prefer the "add the barrier" model.
>

I was trying to avoid having to reason about the fences, I would argue
not having to worry about this makes future changes easier to make.

> We could also possibly just make head/tail be 16-bit fields, and then
> read things atomically by reading them as a single 32-bit word. That
> would expose the (existing) alpha issues more, since alpha doesn't
> have atomic 16-bit writes, but I can't find it in myself to care. I
> guess we could make it be two aligned 32-bit fields on alpha, and just
> use 64-bit reads.

I admit I did not think of this, pretty obvious now that you mention it.

Perhaps either Prateek or Swapnil would be interested in coding this up?

Ultimately the crux of the issue is their finding.

>
> I just generally dislike redundant information in data structures.
> Then you get into nasty cases where some path forgets to update the
> redundant fields correctly. So I'd really just prefer the existing
> model, just with being careful about this case.
>

The stock code already has a dedicated routine to advance the tail,
adding one for head (instead of an ad-hoc increment) is borderline
just clean up.

Then having both recalc the state imo does not add any bug-pronness [I
did ignore the CONFIG_WATCH_QUEUE case though] afaics.

Even so, per the above, that's a side note.

--=20
Mateusz Guzik <mjguzik gmail.com>

