Return-Path: <linux-fsdevel+bounces-43151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D91A4ED1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5200F8A66F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B2A27C146;
	Tue,  4 Mar 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SRBdHWNp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65327BF75
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112940; cv=none; b=eclB1YzSdVlUwPSQrCdURmsI7XllSAJiLHTas7CRmkiL9DmLdyf54jVHfdQwC40wC4hfV6uH9l91FAZ0Ep0nA6bgBcH0pFG6z3hd7RnzDn8ZEEn9MGNS7j57d4Oq2U7ISjVf14dOd6hROWYwTAZayyTYzni4QAwYDI4mWYZnmPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112940; c=relaxed/simple;
	bh=dsFhdaUzdEqC2qasKpn7vKxpyhWg4Pb3DHkJzlpkFgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PG6sZjTrS0cwBnfWgkkEuiM+BHywA4phJDLpw6ilhxrL1BXDIy3ePZqolQgbbfqW03xhVZI4W+eXCS6Qf3peZaV5/6GoySGSMvgI4VoTc37Vfm4ppdIhQnZfRBHiPhJ0wGW/w/Zhuoe1vgEAQfRvGeat/5BVXsMNM6mCos4Ve3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SRBdHWNp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf615d5f31so588959666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 10:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741112936; x=1741717736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tpV8lKFkk0m0qBuXaVnL7ZIVzaNVj3zbGGJTa8/gDWI=;
        b=SRBdHWNp1c3RMI5R4RpCwEmAChmkxrWOGTHCpJ28GAVuKgARKKTaYP/VB7zQcPmrLl
         9BJde9S8ixOv8yRE1SObYTAPNs4nxIFZg5iNmGPFbC2jll/pr/6w/pmR7qz+vjD+5MqT
         b3W2uL5jzszCmc1Qv0Oahkt8ENTpkWpdeuPns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741112936; x=1741717736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpV8lKFkk0m0qBuXaVnL7ZIVzaNVj3zbGGJTa8/gDWI=;
        b=S4d5Rf7ki/rinbfOpHkWLwFq3ovk10vsczgF2EKPNXJMEp57efJ3IknYVxNI/I3nYa
         J0M1lz3g/bYqJdMq5CpQ3quVrqSWC9BPrSC9oLxs5vCLr1KDK9cXXovEjDCD412HfblH
         sSbWscR9uJYKq6Ql6xSQd2G16fiunaYNPuCMPhHfu8bQ6exUYW2PcVXMjNeCRT9r4hgD
         nvcv9/2qv8VKHB2RegpoHyCpauzjchxy4bCbyIKmE8/ozkyWhPArgsFYrmNh4A5R1nf9
         yJhXPvIu30hTBdDuandXsjJn+NYEB8G86cy6Jx4Ltv5vWrS66oZvR7fflnqdPy9PfCN4
         8NfA==
X-Forwarded-Encrypted: i=1; AJvYcCX9gEKp0/yv0rjgRKaUbMsfN0kTUu1AVervKBLfR9Z0XKmOZZqyek3BDVk7mMOkMsAFs3518fYsHidCtmX+@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXQKMECMWvG79NMpGzRjquesDQyl+JGhpIsuhPpNtR1DlV8PY
	wMBdNSbAAfj7dxiVuCDvQTeZyR2eaLs035I50j2YiGnXDqpgzXpr8iHXkFMxq6HEx2A58Z8g4nC
	xl9p7aQ==
X-Gm-Gg: ASbGncuG90X3/GwuHZ0vGw/QS6vtGJUnlQhFujA0TKW0y9UAGtBkabJEy2fkAQcH6tV
	lJ1vKrGhvGXa4APe7andw+lXThrzGySIWj4lCXUdadmrfuR9leAZMi7B713wYx35NM1+jy4WPxq
	+SziC1X7mlxsJniaj6ystHd5RP2Zw1Nmyxoi+0FCGr1RVT62cT7CYnJq6QJgVVjRRtr08RyvZIZ
	kI7aVeCgo8CbBGleiT65v8woeAb/dibdOFITRt0e9e1JP7QDfbnH5fgPYL50Xqw1xYwIPzljOTl
	sdArNObF4q3iGKEuqG00M5JAhcT5zrsCouF3FuJRaMWShtc8NNjHVuYtXz3UwD7LdH70jnrhbVc
	mAtiQzYZo5O9FaXePz+Q=
X-Google-Smtp-Source: AGHT+IG2oxGuFOQiMcGwypeM7vp1/KjiIIYRWSWmCZCf+f8gGqoHIM6OQN8DGOs96Bj6F0PCrGtMkg==
X-Received: by 2002:a17:907:3f95:b0:abf:5aea:a586 with SMTP id a640c23a62f3a-ac20dadcb17mr29759866b.36.1741112936154;
        Tue, 04 Mar 2025 10:28:56 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf5c4d9fefsm574754766b.135.2025.03.04.10.28.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:28:53 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf615d5f31so588948066b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 10:28:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXw5jOD20/6xwH5rtL7V+fja6wKJptP3jb7HvLq29LkRNPUwqr68uFhPFbCq61DMb6Few7w7QAr0hd/7JDx@vger.kernel.org
X-Received: by 2002:a17:907:6d19:b0:ac1:e1a7:9445 with SMTP id
 a640c23a62f3a-ac20d849e4amr25960866b.12.1741112933068; Tue, 04 Mar 2025
 10:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com> <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <20250304125416.GA26141@redhat.com>
In-Reply-To: <20250304125416.GA26141@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 08:28:35 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgvyahW4QemhmD_xD9DVTzkPnhTNid7m2jgwJvjKL+u5g@mail.gmail.com>
X-Gm-Features: AQ5f1JoQpUveK-5XVbjjjnj7fnXJcnsNWYU213h7waPs2Np3fpI_1P-OUj8BWmA
Message-ID: <CAHk-=wgvyahW4QemhmD_xD9DVTzkPnhTNid7m2jgwJvjKL+u5g@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 02:55, Oleg Nesterov <oleg@redhat.com> wrote:
>
> I thought this is wrong, but then I noticed that in your version
> ->head_tail is the 1st member in this union.

Yes. That was intentional, to make the code have much less extraneous noise.

The only reason to ever use that "union pipe_index" is for this whole
"one word for everything", so I feel that making it compact is
actually more legible than adding extra markers.

> > + * Really only alpha needs 32-bit fields, but
> > + * might as well do it for 64-bit architectures
> > + * since that's what we've historically done,
> > + * and it makes 'head_tail' always be a simple
> > + * 'unsigned long'.
> > + */
> > +#ifdef CONFIG_64BIT
> > +  typedef unsigned int pipe_index_t;
> > +#else
> > +  typedef unsigned short pipe_index_t;
> > +#endif
>
> I am just curious, why we can't use "unsigned short" unconditionally
> and avoid #ifdef ?
>
> Is "unsigned int" more efficient on 64-bit?

The main reason is that a "unsigned short" write on alpha isn't atomic
- it's a read-modify-write operation, and so it isn't safe to mix

        spin_lock_irq(&pipe->rd_wait.lock);
         ...
        pipe->tail = ++tail;
        ...
        spin_unlock_irq(&pipe->rd_wait.lock);

with

         mutex_lock(&pipe->mutex);
         ...
         pipe->head = head + 1;
         ...
         mutex_unlock(&pipe->mutex);

 because while they are two different fields using two different
locks, on alpha the above only works if they are in separate words
(because updating one will do a read-and-write-back of the other).

This is a fundamental alpha architecture bug. I was actually quite
ready to just kill off alpha support entirely, because it's a dead
architecture that is unfixably broken. But there's some crazy patches
to make gcc generate horrific atomic code to make this all work on
alpha by Maciej Rozycki, so one day we'll be in the situation that
alpha can be considered "fixed", but we're not there yet.

Do we really care? Maybe not. The race is probably very hard to hit,
so with the two remaining alpha users, we could just say "let's just
make it use 16-bit ops".

But even on x86, 32-bit ops potentially generate just slightly better
code due to lack of some prefix bytes.

And those fields *used* to be 32-bit, so my patch basically kept the
status quo on 64-bit machines (and just turned it into 16-bit fields
on 32-bit architectures).

Anyway, I wouldn't object to just unconditionally making it "two
16-bit indexes make a 32-bit head_tail" if it actually makes the
structure smaller. It might not even matter on 64-bit because of
alignment of fields around it - I didn't check. As mentioned, it was
more of a combination of "alpha" plus "no change to relevant other
architectures".

                Linus

