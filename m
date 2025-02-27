Return-Path: <linux-fsdevel+bounces-42761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 372D9A48438
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 17:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB453189774E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1363422157D;
	Thu, 27 Feb 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjwiSRff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746122083;
	Thu, 27 Feb 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672018; cv=none; b=l3ZNUMuX9/CS09YeAdPVNt0FOyE8MW5coLD1a5Hubm+oftzlmELLfJKYuv/IrT/Ft1S9vb4trCn01KnUzJVuauBEAt3Kwn6HJRwSCZeheVcKLiMQoEqD+3uLKss5Ibx0Kv7h3wCO/QwmD0svwB2qDUOHlIyDBKAK2jzI5CdF/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672018; c=relaxed/simple;
	bh=k5XN5asYTXtvnGtHfYGzwMdBpkPUZrta3kvhEEMWYN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFXv+adjXicztng6ACr5bcrf9paYQgLOARgdts/lZ+1GRAXtMincjeFNHuYDtX65vLn/yz5I7C42WhYPXiRipFLkzPv5LzM3ZI/eWjlLMZvpBJjBnAEJ5brrWGUKg0iqsY/8DFmyEupqDvF/71MaN371fp/P1zm10ows4hYe59E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjwiSRff; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso1728447a12.1;
        Thu, 27 Feb 2025 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672013; x=1741276813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2727ML+KiG1Cn2pM4ymWgQ3b4rvIsMgsg6rTRKiUcAs=;
        b=VjwiSRffL7T9JAN4CCvcZABfuDVBDhRztbcSbzLs+siGvBlSeLzLxtXHVQ+j2bFANz
         Og4mSdsJRgi4c0zaks3kCVOOH3SGcVX9taBkMiU+M8up/eDn/YgYmb0YhaEDtfDrC4JO
         qQ9ou/CAu3R3dWWDmvgS1P4WcyM/KXtlMRFNdDFF3G9nbZoUpAhA/zZU49zMR80m72II
         4OQvvBPYVtIx/ct6zKR9LS/uz8iPjkbqsUcgTD6+9uLTKSBXfgnOuqaHrMTVFyy5ImI4
         aHBMQyCb1UWj/j1/BcJEq0UlKSzm/QNx9zAXFqgLkIlmfH98lc8aBcmTzdtbuelMxQHd
         Mseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672013; x=1741276813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2727ML+KiG1Cn2pM4ymWgQ3b4rvIsMgsg6rTRKiUcAs=;
        b=R/LBygBnjmQ6dUiTRi8RAyBw35iYXqeLid5+bVpgSKD1oesNUg9FaJcClEcgXBYIYo
         UqqujT9WA8aUxvyiN6iPXgWphcoYpCPDsytj29ZPPyyoxmI9r6FKC3Fk5FCTYTKVKip3
         AnAdBl7VraayaWJGhfXecE2UX73xSRvTvfJh12G0j9Kc/u7dbANujMoKCfthNCSc43TE
         amGf2Yi23eLcQxDz7uw6TrIRldz0yLxmaeOCr+S9M6vfvMCfLD57hYyJT9nvptP8nsR/
         0HfGyPoCSg3S8R7UZZbKgkoSTCYnJ/kkvrWVWxGqmfzM41lf1tDhuybP37ZonWJaWR4d
         GUMA==
X-Forwarded-Encrypted: i=1; AJvYcCVqyt2mFyiy3tlSLA7PXkS7w/r1VbNKW1Eb4KQVhBFOhhntbh8/qv4YemqJCUZj2YxZS6shMByjFWt78mWT@vger.kernel.org, AJvYcCXlJX1SSCZuxSzTd14ghkXHn/xQd0+P/2rYuYe5sEGMcMAsww4uRedEi36W2zRwe3tQEjomzepCsTp6hzDx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmy+W/MyjfGLIE4e3JOWRXz2hfRZHtIw1GhUfnYbpfBV+Cvoyf
	IJVpbMAaj5O5IF6dhvTVi8a1S0ixuR7j0YC+XLcVe2AIV0RlQzAE2Erh15/7m/TG0hL1MgsxyXM
	obFbQm4sj6DbPfgSuqKL8tR9UJYE=
X-Gm-Gg: ASbGncsoZs6ME0QLYWNjTx0ACwD+R1Iof7RNg2pCPNofWIpoqwPyaoE7qCY4ujDbQjb
	P82UFxa48jjjZ/01uE6qooJp/JlbaMlzZMseyvQ3bwEEMSAuG3JnKfD6HbWlEKDYL+SnWvYMQhd
	li/PjgIwA=
X-Google-Smtp-Source: AGHT+IFV6UQdtWsCvT2+oOOm2u8kOsn/Ayhx4wetOqM6h0FXX/IAmw27yfxmRyNDoE5XyAdLDPYDVkXceFJIZaLyuWE=
X-Received: by 2002:a05:6402:40ce:b0:5dc:7fbe:72ff with SMTP id
 4fb4d7f45d1cf-5e4a0d45c57mr9584876a12.2.1740672012465; Thu, 27 Feb 2025
 08:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102140715.GA7091@redhat.com> <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250227125040.GA25639@redhat.com>
In-Reply-To: <20250227125040.GA25639@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Feb 2025 16:59:59 +0100
X-Gm-Features: AQ5f1JrexmCNGbPs-jHQxcBoY41xlAepN9GgpVYFvjWXW9MY6PKnEOeJdCOjphc
Message-ID: <CAGudoHHKf_FXrrNJQCqvC50QSV87u+8sRaPQwm6rWvPeirO2_A@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Manfred Spraul <manfred@colorfullife.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:51=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Hmm...
>
> Suppose that pipe is full, a writer W tries to write a single byte
> and sleeps on pipe->wr_wait.
>
> A reader reads PAGE_SIZE bytes, updates pipe->tail, and wakes W up.
>
> But, before the woken W takes pipe->mutex, another writer comes and
> writes 1 byte. This updates ->head and makes pipe_full() true again.
>
> Now, W could happily merge its "small" write into the last buffer,
> but it will sleep again, despite the fact the last buffer has room
> for 4095 bytes.
>
> Sapkal, I don't think this can explain the hang, receiver()->read()
> should wake this writer later anyway. But could you please retest
> with the patch below?
>
> Thanks,
>
> Oleg.
> ---
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index b0641f75b1ba..222881559c30 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -455,6 +455,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>          * page-aligns the rest of the writes for large writes
>          * spanning multiple pages.
>          */
> +again:
>         head =3D pipe->head;
>         was_empty =3D pipe_empty(head, pipe->tail);
>         chars =3D total_len & (PAGE_SIZE-1);
> @@ -559,8 +560,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>                 kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>                 wait_event_interruptible_exclusive(pipe->wr_wait, pipe_wr=
itable(pipe));
>                 mutex_lock(&pipe->mutex);
> -               was_empty =3D pipe_empty(pipe->head, pipe->tail);
>                 wake_next_writer =3D true;
> +               goto again;
>         }
>  out:
>         if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
>

I think this is buggy.

You get wakeups also when the last reader goes away. The for loop you
are jumping out of makes sure to check for the condition, same for the
first mutex acquire. With this goto you can get a successful write
instead of getting SIGPIPE. iow this should goto few lines higher.

I am not sure about the return value. The for loop bumps ret with each
write, but the section you are jumping to overwrites it. So if the
thread wrote some data within the loop, went to sleep and woke up to a
state where it can do a write in the section you are jumping to, it is
going to return the wrong number of bytes.

Unless I'm misreading something.

However, I do think something may be going on with the "split" ops,
which is why I suggested going from 100 bytes where the bug was
encountered to 128 for testing purposes. If that cleared it, that
would be nice for sure. :>

--=20
Mateusz Guzik <mjguzik gmail.com>

