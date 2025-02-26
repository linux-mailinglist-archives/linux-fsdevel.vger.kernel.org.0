Return-Path: <linux-fsdevel+bounces-42681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A616A4609B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 14:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DA0179E14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F021B9F6;
	Wed, 26 Feb 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP0AQbPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F50218ABB;
	Wed, 26 Feb 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576106; cv=none; b=CuQ7z86OVlvlN24dt8vCfc/ys53cncta13zm4mb5+BUxARMeOEU4LzQepemD/OCPFOkvcX3cIh/bFUqvkHYvPy0jpMeRk4cS/RoGqQUfYINaIkL09Za2K/ltIZ/kF84rbPdjH+zoSzrAmN3WFmvoE+CM24yENdl+gVuNNUsOU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576106; c=relaxed/simple;
	bh=Q5/RUl+Bdu66WjUmXTWUC88O+wFDli3YPBlrDjyH4ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VW+hq3WYWAkPPIYlc7JdKGF4LPNC1KBZk48+qlmky+WTjIbgCZCbRKPLYWI/IcyE9VHvlBYPNwZuUdg2yE3Vi9vgODIqKyOiB7UjVqAXw8uqW6Z3Zbj2zzF0nEnFLbOsmgnR8fvSM/SBS8xKcneJix9lP0R/D7HSBlPFWw2CQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP0AQbPt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so12678616a12.3;
        Wed, 26 Feb 2025 05:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740576103; x=1741180903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5/RUl+Bdu66WjUmXTWUC88O+wFDli3YPBlrDjyH4ns=;
        b=VP0AQbPt+gXP5OYK0t6Y8BRgtfTm1E9gGc1CaAc0kWv63uLp1dULpPdfHjAa2begKH
         QisEX2Vh9y9MBy29jbJXAFdfLV2g+wUon/jjwu0xTYQ5dhkXm8Mt82mOlsDwWZgtgY4C
         3q7ACXMvnDjsZLpBwvBngZo+NqfMcI5Po/DoCxnox75UuVWDs6NNjhct54RmpPXZNeE2
         Kvgnhw9pCEXL8vokfTmG96YE0bzteoWmBsQBr9elXFWMa8zkdK9cUxyK4CQI32D444DV
         xqkAtWEU2hON7zd+1DvbG8dZXIMZH5flN8q7ofUQmyxIPLZxyKcPZQ8ZNVcZIqVq6HBy
         aojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576103; x=1741180903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5/RUl+Bdu66WjUmXTWUC88O+wFDli3YPBlrDjyH4ns=;
        b=KYUyN94G0nHCHPdv1bdGtuO89XEA6mdo5QtF/2TKYbPI+a7gdE/s3z0lSIYHr+iQGe
         p8eqLeotHAM4F4ImQzWag7CHvPqklOtw+DbhLq+E78v+7/HYOnDCdVZJLLZK67WB7tfV
         pRAGVgGSCj6h4uyR5EgAbs0+aRi3c9a76DN52Wuu4X7pdS0T0EhAcHGEyIOAb5wa1goB
         ZwlWhwrrHVQeHxc35bC3cmqylvy0/WsHnqWEsEeSQ0oCV23gSqZNmlgDldtLy8P3wAe1
         6l/9OZnwowtq8Qek/o618R46xJagUZjPBU026nva1rlOQTf75YDtNkSAw2QAIAHo0Zrm
         Drhg==
X-Forwarded-Encrypted: i=1; AJvYcCUz/aT/JI9OtfG5yc2dqlHOEG0jg5OmnRlmqrTCJ4iY+zrWNlb0zCwyRixRk+k/9/wXc9MM0ulq4cY1RuiA@vger.kernel.org, AJvYcCVAB50hcdLEN4oq1qMUVI6GeN4RMVGY0POEP27LblLTwA46g/1Y6m99Lrt8A/N0eumDnbpFSgv+oPmyOdPO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MRmAKCA7Sn+dGXq8V9ehOZYItmtmlaNKSbe8ZpbrdMP6YcZZ
	i8BGDxU41DjvR+xDW2spG/M2xczp0rMHnM8zZ5mW/bzGZbSM8Ip7M1TlETqyxYPms9RbEQex0lV
	uW7eIwe8qfTMO5p29r2VrcMeRTTIrly6c
X-Gm-Gg: ASbGncv5zL4P1TJB2LSImui6NrSAc7E2hnPd1Ruj6TYsnfbRPnaKJwzOPasbx7k3qtO
	fse1bZVEuAGCM1Zi7kHG1vPbENsiS3vSP20OMVRiV4/Cysd4WOOBIvjA0jgTbtCZVvy7T/AoBkc
	wFtIM2sK8=
X-Google-Smtp-Source: AGHT+IGnrQahi3Q3/mVtEzmJWDRXjMAImXcCfoKOuscgcPGPbIvjw9E630qsNx5l1cen6PJCOINvakCZSKGCmAiL5j4=
X-Received: by 2002:a05:6402:4304:b0:5e0:4276:c39e with SMTP id
 4fb4d7f45d1cf-5e44ba3fe8amr8275383a12.30.1740576102716; Wed, 26 Feb 2025
 05:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102140715.GA7091@redhat.com> <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com> <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
In-Reply-To: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 26 Feb 2025 14:21:30 +0100
X-Gm-Features: AQ5f1JrGRQ6x6P35CYIjcmeEYvxZDrHYDp6l3JtEAdtwlbXoEf2r6wGz-Q_6K8k
Message-ID: <CAGudoHGaJyipGfvsXVKrVaMBNk8d35o66VUoQ3W-NDa1=+HPOA@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:19=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Mon, Feb 24, 2025 at 03:24:32PM +0100, Oleg Nesterov wrote:
> > On 02/24, Sapkal, Swapnil wrote:
> > > Whenever I compare the case where was_full would have been set but
> > > wake_writer was not set, I see the following pattern:
> > >
> > > ret =3D 100 (Read was successful)
> > > pipe_full() =3D 1
> > > total_len =3D 0
> > > buf->len !=3D 0
> > >
> > > total_len is computed using iov_iter_count() while the buf->len is th=
e
> > > length of the buffer corresponding to tail(pipe->bufs[tail & mask].le=
n).
> > > Looking at pipe_write(), there seems to be a case where the writer ca=
n make
> > > progress when (chars && !was_empty) which only looks at iov_iter_coun=
t().
> > > Could it be the case that there is still room in the buffer but we ar=
e not
> > > waking up the writer?
> >
> > I don't think so, but perhaps I am totally confused.
> >
> > If the writer sleeps on pipe->wr_wait, it has already tried to write in=
to
> > the pipe->bufs[head - 1] buffer before the sleep.
> >
> > Yes, the reader can read from that buffer, but this won't make it more =
"writable"
> > for this particular writer, "PAGE_SIZE - buf->offset + buf->len" won't =
be changed.
>
> While I think the now-removed wakeup was indeed hiding a bug, I also
> think the write thing pointed out above is a fair point (orthogonal
> though).
>
> The initial call to pipe_write allows for appending to an existing page.
>
> However, should the pipe be full, the loop which follows it insists on
> allocating a new one and waits for a slot, even if ultimately *there is*
> space now.
>
> The hackbench invocation used here passes around 100 bytes.
>
> Both readers and writers do rounds over pipes issuing 100 byte-sized
> ops.
>
> Suppose the pipe does not have space to hold the extra 100 bytes. The
> writer goes to sleep and waits for the tail to move. A reader shows up,
> reads 100 bytes (now there is space!) but since the current buf was not
> depleted it does not mess with the tail.
>
> The bench spawns tons of threads, ensuring there is a lot of competition
> for the cpu time. The reader might get just enough time to largely
> deplete the pipe to a point where there is only one buf in there with
> space in it. Should pipe_write() be invoked now it would succeed
> appending to a page. But if the writer was already asleep, it is going
> to insist on allocating a new page.

Now that I sent the e-mail, I realized the page would have unread data
after some offset, so there is no room to *append* to it, unless one
wants to memmove everythiing back.

Please ignore this bit :P

However, the suggestion below stands:

>
> As for the bug, I don't see anything obvious myself.
>
> However, I think there are 2 avenues which warrant checking.
>
> Sapkal, if you have time, can you please boot up the kernel which is
> more likely to run into the problem and then run hackbench as follows:
>
> 1. with 1 fd instead of 20:
>
> /usr/bin/hackbench -g 16 -f 1 --threads --pipe -l 100000 -s 100
>
> 2. with a size which divides 4096 evenly (e.g., 128):
>
> /usr/bin/hackbench -g 1 -f 20 --threads --pipe -l 100000 -s 128



--=20
Mateusz Guzik <mjguzik gmail.com>

