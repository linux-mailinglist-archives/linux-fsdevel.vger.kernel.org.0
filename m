Return-Path: <linux-fsdevel+bounces-43208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFBEA4F634
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 05:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0A9188F1A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 04:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B161C7006;
	Wed,  5 Mar 2025 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hFyx2TG2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F143AB7
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741150369; cv=none; b=WGN9X+HkovAf7QSdRXDPNIlHsTS7HOe/v4elGjFMCI4tc0szaSSabelsTaT24baU6DBVhXrn5FkMoM5S4RIXON+7nQIKs1SOorJ3uInlQ403CGda6Sx3mF9X/UxmCRSfb0LOx5Vw075ulN3qDOukIzECDZB8Wcl99Bt2+jk9ens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741150369; c=relaxed/simple;
	bh=ZT0l/nMPp2V7swoimX/51KJfcSbvKA/yFOWbk+826KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rS+tw9mNVSG4XLjOxjd4Z/26uwOgpUpgOyEbv0rfSoHaszRd0PDko1Dry7ft0oo3AAwzREiNZig4ceu+73yBRKaxTGgnan87gTUK6r0+60WRQGXM5hDjNV2uAZCnFTIiqnNDZfSpmZ/WstWcPLh3J5zV+DocwevaZB8eAgJ1Wos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hFyx2TG2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab771575040so76305666b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 20:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741150365; x=1741755165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b/WCWHG9vDVmrx2Uuc4QQNowuOEGiOED3yZs8cjx2qg=;
        b=hFyx2TG2Z2um2IqR5U9KaY34cYI5jXgcTAyvkOh4Yfn0rL99qrId+Q1alRFkPbNIAW
         l4CVFmL8jPSyzfe2u6zOslWjZOzbYBvbnqKAKC7YOiDU7euNreIJYKgAF5G5h+IndfI6
         0ZnFpa9F2plpECzSKGhka86KRm3nJXEcW68GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741150365; x=1741755165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/WCWHG9vDVmrx2Uuc4QQNowuOEGiOED3yZs8cjx2qg=;
        b=KOJkb1Um3IDLwWs7B9vGTfc5YBApG9M5eITepl1hCyBgZgi0l9XwAl3VoQxvtYZKTE
         G/Jdi6QKZBd1fuUMpVxlKY3QH58oYrjjg9/KnECCDz7Yq+j/JG5Q70fxDpBY5c89Tb3a
         R8Gf/2WYfsr6hGI9Ump0cpq++0uqZ5F5cDO4D371HH+HkR75HLkh9J0gTLjGpGYIULv8
         jvmbqjgKW5cL03FU8wAd9RLStYtd0G/Yfh12bfyvhY2z9IixSqxpuXSS644vqJ14aEz1
         CTbss9VVnb9omtGhLCZRIzeyvEq0UImK5L1V1QFDRyDa+8KP6TlqKeqStmmaJILhpzvW
         kDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDD95lX0XdZcgFUYNFGfWd/UvOzRTpRN+BpGfqpCav+k5SubuMyGklWMaeATqZBBBF+wm+kvQxBq3+Basx@vger.kernel.org
X-Gm-Message-State: AOJu0YyALqqzWp0QKhpv7H2/Cq1HhVeHpbjsJV4Ifr8CuG/EILIm6Qkk
	5asKTvTXjIw3R0DGuV4pNvPvpPK8pkhF6wI5bQs6MvXUSFLHTrDNCYLddvoFzY9qCijWcm9Bb+H
	Sne1OwQ==
X-Gm-Gg: ASbGncuc9xwQcxZV/pPAryi3AIRjWvQuDzGCNWGE4RyMEKcIaD589lffCWDZWa3vO7u
	9jYbHpvT5PJc69GTFpVXJNG1/ld5l+okTp4DvrLy+0Uugr3dGR4UL9LxS6Zb1oRXsKb670gk1nR
	jzEN0aJAh4yYIZrhp3eEaUMfvRH78OOkee60GG7s93kY5zne+64vjjkjKNwlYdfaUbIXLUxO32h
	accc72RQOjijrMTvfeGQOBd/NZSp+ihRCgN6crX23i7UgXAzm1zWJNK07G1m7GKGdB3N5KMZ9jk
	8tPP5PqE8P5A53IQukWC3R0w4HoXKCgiqLO15JCRgGOyIHso+UBVppzuyX8twmOn4mI7WR1HLyb
	U3r8eT4H4cPUV2j/jBP8=
X-Google-Smtp-Source: AGHT+IFGXCEt9bwtqoZvL9ltfx3eFHW1xMNd7WyIC/yAX0082Hnga1baLf7mebQ8H8YEtTA6AA29mw==
X-Received: by 2002:a17:906:c148:b0:ac1:f247:69f5 with SMTP id a640c23a62f3a-ac20f0139aemr141205866b.28.1741150365438;
        Tue, 04 Mar 2025 20:52:45 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf727c9153sm513073066b.146.2025.03.04.20.52.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 20:52:44 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso815670a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 20:52:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXs5A/VcX8ZOHfym2T2wTEhW5ES6w67OWP13D0HVo7Ou0L73+n2opFmaZxMqvkLvz5dU2zWh//4hzC4losc@vger.kernel.org
X-Received: by 2002:a17:907:9702:b0:abf:48df:bf07 with SMTP id
 a640c23a62f3a-ac1f105c0fcmr649829666b.15.1741150363877; Tue, 04 Mar 2025
 20:52:43 -0800 (PST)
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
 <20250304125416.GA26141@redhat.com> <CAHk-=wgvyahW4QemhmD_xD9DVTzkPnhTNid7m2jgwJvjKL+u5g@mail.gmail.com>
 <8fe7d7c2-e63e-4037-8350-9abeeee3a209@amd.com>
In-Reply-To: <8fe7d7c2-e63e-4037-8350-9abeeee3a209@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 18:52:27 -1000
X-Gmail-Original-Message-ID: <CAHk-=whydHy48QDorhGeRLdxdL_1iNt=TJkaJ4rO1xF0WS+iTg@mail.gmail.com>
X-Gm-Features: AQ5f1JqKxqW5NIhKa7sKOCenQyWXH8O4R45njMY_gV-Bb9HHGkSc64y0bI_wRSU
Message-ID: <CAHk-=whydHy48QDorhGeRLdxdL_1iNt=TJkaJ4rO1xF0WS+iTg@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 18:41, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> >          spin_lock_irq(&pipe->rd_wait.lock);
> >           ...
> >          pipe->tail = ++tail;
> >          ...
> >          spin_unlock_irq(&pipe->rd_wait.lock);
>
>  From my understanding, this is still done with "pipe->mutex" held. Both
> anon_pipe_read() and pipe_resize_ring() will lock "pipe->mutex" first
> and then take the "pipe->rd_wait.lock" when updating "pipe->tail".
> "pipe->head" is always updated with "pipe->mutex" held.

No, see the actual watch_queue code: post_one_notification() in
fs/watch_queue.c.

It's isn't the exact sequence I posted, it looks like

        smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */

instead, and it's pipe->head there vs pipe->tail in pipe_read().

And I do think we end up having exclusion thanks to pipe_update_tail()
taking that spinlock if the pipe is actually a watchqueue thing, so it
might all be ok on alpha too.

So *maybe* we can just make it all be two 16-bit words in a 32-bit
thing, but somebody needs to walk through it all to make sure.

              Linus

