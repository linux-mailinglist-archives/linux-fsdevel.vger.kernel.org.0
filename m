Return-Path: <linux-fsdevel+bounces-38398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D8EA01706
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 23:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A6A162F82
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0991D5CCD;
	Sat,  4 Jan 2025 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H7bPl6kF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26B157A67
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jan 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736028373; cv=none; b=h5OtIP/kVivGV+ZNirloYg5kClOXk7RF9z4GOEjrf41T2An3vb6U79oV+DBcwu3pVul45FOMfTpfq8PQr9wQcJxuSl4Pm1LeDjypR1FUTJKBrDFTp8pSEj1PmppGzehPgKLDHyUoqya91QFAkTqZzhBBwUHa+wClCiM5LZyTSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736028373; c=relaxed/simple;
	bh=PZyUUMGWQ99TdEA2ys/ORrG29yLGIO8uIIsVJDLTFF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBVHm91z7WGX3UDRn3V1Unxb32A0Fo5tofGNoaJv+U/oIL1SO/0LeTQgsDy0dLExVbwG4QkQkhGo2p6dRnvW32ext/LOCp7sS/DTwGDUi5fN54CNLu2FtRCksieyR9OilYqvz2Ts/LZ/Z21zGctvJVmCFKD6owvy4c6m3Qp83TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H7bPl6kF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa696d3901bso1636005866b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jan 2025 14:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736028369; x=1736633169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nYKO0NnUzfqhaYI1HioLJFUWrXfhBCJrSebWyffvRhk=;
        b=H7bPl6kFFLhG30tyeR65KRGqaRItLX+NXWAhM8bbG5DQQRrMxNnBnXL3u7gQYa3F9O
         pIgFdIQxkeM823H4ZaX78JASGOtw0E9ev1YAR9FndP7ru5o3A5I2jVFcW0qSbWXjVYpp
         CtbIBs6pZbRqVnjRCJBbRz3c8i4vSQQyG4Daw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736028369; x=1736633169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYKO0NnUzfqhaYI1HioLJFUWrXfhBCJrSebWyffvRhk=;
        b=Yg0Hz7mm5xaf8b/H8OVYxL8aJ+jDPOD25qFNMoanZAYGnnGs2/T8AxMPrZltz4d7O1
         H+R97UJRvq6APbByOvYc9S0+hlyqjGczOQ9aQMkx/tYFQFP4wNpXGT5dzHDFPM4taqy2
         MFefJLXQt0heuknznhIDx1DCbtAzPPKhW6gaIN1XwVrI1LHgsJMw7+mPgpLdr32C2seu
         pJ6kDCQZdHwUaS9VLnIIWejQCgQZtZSj8d8Ubiw4Pba9nXgkkKHc1HfxGuKRmFGEayE2
         3i6bau4XeSYo5dBKIeuH55goViDGyfDQ3pehLLMUlmoyHb+lheHTwUgPv7HfewPsue6N
         9+ww==
X-Forwarded-Encrypted: i=1; AJvYcCVBOCIdLoUODi1r32wVli2LbY29NJxfNDTxJR/qySuYsK2N2RZeQXsB5v/LvyUHP1mz25x+AKOaTg748Nnk@vger.kernel.org
X-Gm-Message-State: AOJu0YxIRHsVaUK9UEzGR/9nfVKgrJOZwKQz0v9NpO+MXu8N9O6Vwvjg
	9nTYlVJ8t3qRmnb7MEvo8jKxtAPnu2aM0RKh99oGj6+c/cRHPcv5Zj9DWCwNisXgcOm5hwN37Sl
	J
X-Gm-Gg: ASbGncuYGMQt7Bgjj0b11Ls9UrWVcBrxtlNfmwbr6J13K86f++2UdH+bjRO+Y3kRaJE
	fwwgNFWyqK9LmN/5EtJ/Zo3D8/tasGqjuVGFIu598SbPfdJfdcifkai6RelKIv+/G9oHsIAaVpu
	hvEWCRDU6ZEZYEybqREnBAP/ofRfTPL3WRZDfPv2DEY9YC81uZQZveyHAeevfct4Ot4nrzsdMu9
	VoJmHEewXISXaA4i3QuLCXoOgRD4ujkYd9QL78UzKQ7XHeegKlyryts8URib7SpiMfYxEaBXFkE
	ATQVMU89efYSHn7uleUPE+Vjjh2ZZ2w=
X-Google-Smtp-Source: AGHT+IEb1N5WNSUjW2D71fXVFt0uvKzk+dnlrd+VtVhBbwuWC0VSyfkHrvfX4NcAc1k9snrlgDqBxA==
X-Received: by 2002:a17:907:3d87:b0:aa6:841a:dff0 with SMTP id a640c23a62f3a-aac2d458126mr4273378466b.32.1736028368999;
        Sat, 04 Jan 2025 14:06:08 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4b6bsm2069098066b.93.2025.01.04.14.06.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 14:06:07 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa696d3901bso1636002666b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jan 2025 14:06:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2B6Uelvw/I99Ap24mXcxca5qVyASU3115xG3si77+lwZ5LXgeMZq0VR18ZX12U1P53wF+wAdepeGFQ6TR@vger.kernel.org
X-Received: by 2002:a17:907:9722:b0:aa6:6fa5:65b3 with SMTP id
 a640c23a62f3a-aac3352c204mr4836721266b.47.1736028366076; Sat, 04 Jan 2025
 14:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241229135737.GA3293@redhat.com> <20250102163320.GA17691@redhat.com>
In-Reply-To: <20250102163320.GA17691@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 Jan 2025 14:05:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Hr4PBobc13ZEv3HvFfpiZYrWX2-t5F62TXmMJoL5ZA@mail.gmail.com>
Message-ID: <CAHk-=wj9Hr4PBobc13ZEv3HvFfpiZYrWX2-t5F62TXmMJoL5ZA@mail.gmail.com>
Subject: Re: wakeup_pipe_readers/writers() && pipe_poll()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Jan 2025 at 08:33, Oleg Nesterov <oleg@redhat.com> wrote:
>
> I was going to send a one-liner patch which adds mb() into pipe_poll()
> but then I decided to make even more spam and ask some questions first.

poll functions are not *supposed* to need memory barriers.

They are supposed to do "poll_wait()" and then not need any more
serialization after that, because we either

 (a) have a NULL wait-address, in which case we're not going to sleep
and this is just a "check state"

 (b) the waiting function is supposed to do add_wait_queue() (usually
by way of __pollwait) and that should be a sufficient barrier to
anybody who does a wakeup

Note that add_wait_queue() ends up doing a spinlock sequence, and
while that is not a full memory barrier (well, it is on x86, but not
necessarily in general), it *should* be sufficient against an actual
waker.

That's kind of how add_wait_queue() vs wake_up() is supposed to work.

Of course, the fact that we're not discussing the pipe code *not*
doing a full wake sequence (but just a "is the wait queue empty"
thing) is what then messes with the generic rules.

And this makes me think that the whole comment above
waitqueue_active() is just fundamentally wrong. The smp_mb() is *not*
sufficient in the sequence

    smp_mb();
    if (waitqueue_active(wq_head))
        wake_up(wq_head);

because while it happens to work wrt prepare_to_wait() sequences, is
is *not* against other users of add_wait_queue().

In those other sequences the smp_mb() in set_current_state might have
happened long long before.

Those other users aren't just 'poll()', btw. There's quite a lot of
add_wait_queue() users in the kernel. It's a traditional model even if
it's not something people generally add to any more.

Now, hopefully many of those add_wait_queue() users end up using
set_current_state() and getting the memory barrier that way. Or they
use wait_woken() or any of the other proper helpers we have.

But I think this poll() thing is very much an example of this *not*
being valid, and I don't think it's in any way pipe-specific.

So maybe we really do need to add the memory barrier to
__add_wait_queue(). That's going to be painful, particularly with lots
of users not needing it because they have the barrier in all the other
places.

End result: maybe adding it just to __pollwait() is the thing to do,
in the hopes that non-poll users all use the proper sequences.

But no, this is most definitely not a pipe-only thing.

          Linus

