Return-Path: <linux-fsdevel+bounces-43278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BA3A50583
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 17:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EB73AA66A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE2F19B5A7;
	Wed,  5 Mar 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="drWJEmBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251E199E89
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192862; cv=none; b=Kb6CVTdp7QvTCkIciRan39hsfh1qpEol75UjhWl+aiuo5Q1VWHBYMtvsRopLN+k92fiIVYYeO6xiEpAkHXDSMK1/m83BB+/x4Xwo+NeLLebwuV7UaEUVyxoPZRDHm+jtAWdN/nKvE9CwdZzCUNB8tkNYzzXIexhS3jErS3w00l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192862; c=relaxed/simple;
	bh=GIZj5nXeV43qZLaLKVSZeSCAfiZ1aV247XMQYfCpLOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcQBHGsZeQUhaFOpregvnaC0nsNhU770gXjNjjjV51a/O3UlS4P2mB13D8/RSvFF6WlwuhK8Pw9DhMBCHVbl7wQAUuSiuegrk3Gc1TEis8TokK+kVTwsRegSMwQi47tm+GBNL1c3zB/+czqqw2mVsWDEShj32L1qyC2uzxllVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=drWJEmBD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso514886666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Mar 2025 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741192857; x=1741797657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bcj+FL6rUqtMKI8ucbJjAqXrCeckB3SlFcAWKVcfex4=;
        b=drWJEmBD2st9InYMIpRDzkZTPcgUSqEs0im2oAhDCtjVhPEKEHyKz+4g/LOpY39onX
         /O8RegX9LGCCBmrMJW5+x5E3mOd53MvuyyYFAtzy5tAwVuMG5Ep5lb3wLO+sJ/DKMFjc
         +5HIyIAc9Q97LDjYSXAuakV+MW+Qw/WSEbatM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192857; x=1741797657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcj+FL6rUqtMKI8ucbJjAqXrCeckB3SlFcAWKVcfex4=;
        b=ti/zXP4erJJG/22vDG6bsAQF1jtgBwYrBr1FZrDdmoA+RLJildNkXLovThC54zAWhX
         Ni01Uo4Xusm7Yl2kK4qrb/QC2uRWND299PcZ1dWZ45GQdvnQwLYG1AeDZ7moCe05ulr6
         Ksy+6K34ShpdK453E+5jp5aum1QrHXiXxOMfvnxJSVkkJCE3Nwyw1cVvn45bEncczvy+
         +sONGLLDs2NhjCj//Wc0CE31dXEMqjeU99rEc992hPGo1FaDmfNeC+hKENyrVzGvOTD7
         visfJ524wnwjVkpnCRfuEiNEfgT22xx9OzHnNCUjfeohEfakdRSECR3WpZqy0xpg+bbW
         ZiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz1iwsfGDpo+F030rMq6VzqGEoaZceAh6Hevq2MRiq1W2A2QaSABl5DaYvTo5DI19B1kclFC4OZ4ZsyJuI@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwFwJ5Sr9WGquI2bdTfyOdWSqftWI8euQpClT99tbBK6wgATW
	++vbHh2FFSSxlZ10eDThd3eF++cPfxRoZjjcL6IKUkkxpJhYeMJ7N5l1fnGRC86LFSBzYRmfeCq
	0p+/xoA==
X-Gm-Gg: ASbGncsjsgaE4RvE+5q+wh00948A1A6y7QJcIF0eN0N7vWaCHW1x7Boz8xjBnP6v6AH
	FZlBU4mofxXPRU5RbcHPQfq6z54Cl70AV27kqGTIw4oYa0Ao64AeJQQfj19loybrHiEZgcH3BkM
	iF01HMFTDw4TFiB22ifVBbTYciZO2G0G8WdrIZDpZQZkM0Rk5VpxqO5LeQXuqjR9V4Nvo5YqxdR
	ZHbwPgjKuKq6ms0hVk4WCHCq8NqFsrOkNjxopCHOT5qgqYA3j7X8qLpOplQ5mI3OM8g12ZylC4w
	3E025bTVy1hMq79SHwx/AcTAd1xvx0e4qnFROPMiWS0tLjHgTNJh0BDpt1tDhUv34hDuYVbUfpm
	/6AN0XHr/LZKTCVUBqvw=
X-Google-Smtp-Source: AGHT+IFVTJQg3qbpo6YX49VydLvtDlWtvj5efnIOb54eEBoxBxEVHq5ZqMxn5H/uqjbBuZ/l6x7VUg==
X-Received: by 2002:a17:907:7f2a:b0:abf:607b:d11 with SMTP id a640c23a62f3a-ac20d8bcb7fmr386794066b.18.1741192857251;
        Wed, 05 Mar 2025 08:40:57 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf7a3ea634sm536567066b.174.2025.03.05.08.40.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 08:40:55 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaeec07b705so1069356266b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Mar 2025 08:40:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZd0mZ7u7ubmDBAlDBUguLMOGkcIAEScEa28eJzYACM0uqXegzMm1N8md6YkNAbx7lhHCwnPy9W43GJeXA@vger.kernel.org
X-Received: by 2002:a17:907:7290:b0:abf:615d:58c2 with SMTP id
 a640c23a62f3a-ac20d92d6c5mr406399766b.34.1741192855487; Wed, 05 Mar 2025
 08:40:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com> <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
In-Reply-To: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Mar 2025 06:40:38 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jp0qXBcEd52erShw3zCywhVPd7l8QG-JqnvkqqMzAhLfYEXemeEXbrVY6s
Message-ID: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 10:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> ENTIRELY UNTESTED, but it seems to generate ok code. It might even
> generate better code than what we have now.

Bah. This patch - which is now committed - was actually completely broken.

And the reason that complete breakage didn't show up in testing is
that I suspect nobody really tested or thought about the 32-bit case.

That whole "use 16-bit indexes on 32-bit" is all fine and well, but I
woke up in the middle of the night and realized that it doesn't
actually work.

Because now "pipe_occupancy()" is getting *entirely* the wrong
answers. It just does

        return head - tail;

but that only worked when the arithmetic was done modulo the size of
the indexes. And now it isn't.

So I still haven't *tested* this, but at an absolute minimum, we need
something like this:

  --- a/include/linux/pipe_fs_i.h
  +++ b/include/linux/pipe_fs_i.h
  @@ -192,7 +192,7 @@
    */
   static inline unsigned int pipe_occupancy(unsigned int head,
unsigned int tail)
   {
  -       return head - tail;
  +       return (pipe_index_t)(head - tail);
   }

   /**

and there might be other cases where the pipe_index_t size might matter.

For example, we should add a check to pipe_resize_ring() that the new
size is smaller than the index size. Yes, in practice 'pipe_max_size'
already ends up being that limit (the value is 256 pages), even for
16-bit indices, but we should do this properly.

And then, *while* looking at this, I also noticed that we had a very
much related bug in this area that was pre-existing and not related to
the 16-bit change: pipe_discard_from() is doing the wrong thing for
overflows even in the old 'unsigned int' type, and the whole

        while (pipe->head > old_head)

is bogus, because 'pipe->head' may have wrapped around, so the whole
"is it bigger" test doesn't work like that at all.

Of course, in practice it never hits (and would only hit more easily
with the new 16-bit thing), but it's very very wrong and can result in
a memory leak.

Are there other cases like this? I don't know. I've been looking
around a bit, but those were the only ones I found immediately when I
started thinking about the whole wrap-around issue.

I'd love it if other people tried to think about this too (and maybe
even test the 32-bit case - gasp!)

                         Linus

