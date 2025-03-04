Return-Path: <linux-fsdevel+bounces-43046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72228A4D3ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FFD1893D68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42DC1F462C;
	Tue,  4 Mar 2025 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z/LoVmCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BC481C4
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069994; cv=none; b=n+V2lkp7DM+5djPGMurHMtSK+yZQM/8tFVR9F/tTCc2PZ33d1F5MFvDGPWMtplk/97JIRwI3P4PflalDjpKVYOtFAIvhR1EorhgDZK6U9Ih4A2OBw5VHvrtRtWzzDWOW0LaFZ1XNDPQqwqUhPDO5pjfMrp832v+KXb6V6uK/o/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069994; c=relaxed/simple;
	bh=VcSDZCPSlilk/nQT3SJdh7P3PWn2QylOjDn5IxXXQak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzlN0yKyD3VpsRGmYq12zseil32TVwjFY9Kjd5S4kkTChpdS/LKXi0e6OdElzTEqBtBKesLJpoiqwcqcdRswHaBbOj3keKhg2ElRZG0LkAbJFiMreVJ+bP5RDsPji8HF1logATMKQwWrIcEP7Zmxex8PPfT7MJyl/INHmiOae38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z/LoVmCK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaec111762bso962240266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 22:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741069989; x=1741674789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UPfpycxRLeXPq3Vn47UB9XJqE73Xmj0YUhuOs6CYk+I=;
        b=Z/LoVmCKLnhJb81lughFALWjqBrpilunt9GEY8b2Oc2L6dwmrPqKfb/Aia9aYOeJ5K
         5shhzI9BRnk+YSlzKjTnYUT6xR0FMw3TWnZ2YZ3ZU/nDamenC9EZQMaQRWKtMnTYdprF
         MUleghMGXoRFsskH6UtSDGHX0qhVzhIgamXGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069989; x=1741674789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPfpycxRLeXPq3Vn47UB9XJqE73Xmj0YUhuOs6CYk+I=;
        b=KwumLxQviHsIu8Oqf2VYaXZc4KlQTBdwpge1rxTKFsn2ZrZCupnGemva83oxr8zVCH
         0gD5PoHLHFaFnPkrMbgcip2qswZGWH5qBHrluFxVV/5lrhhcfmMr/q9ssFqHZjORx9kM
         OT3qyW7ZZDwP2tBujKBkRefZEkr7k5L4k1OUElXl68Qdt89ikYQqYjdD6DpSwD1gf1rp
         0Mq2zkNPniqPK8YSFg0aq7CQYBJf4michZobvsdIXzymYPGyvdPuZPhhYymmyuRcsgR0
         /jTHkbZqbgst1oQQ/VmMBgmp9zNKIsAICIDGVUexYRW9nlKGHx45jyQFbwqjRhwNLAHw
         SsjA==
X-Forwarded-Encrypted: i=1; AJvYcCVBlKDCL5w0fWRN4WagWaPgNEAvswrV81UYiXytiYHYlmRyZ9MEFzb95ShxEsxPFdNjyZLz/YjwP/xX2+T4@vger.kernel.org
X-Gm-Message-State: AOJu0YycbUYmLRABgF/p+8LoOxZ+4Zk3naYJnOpU8PFbo/c6cXQ3Fd+6
	xsTrJNzbHS3gm+l5LqlMopScBYWYb0AKWz7cHc3VNhw4kuZHwqLpBJeC5GFyt3IITeezxlmwGC9
	SaYI=
X-Gm-Gg: ASbGncs/Vj7M3OulcumLwJXHFNyXOaGMwZEtUl71z1DxBvVZGipVjunX8kuduS4uVZr
	Tq22NSQbwIxxXH7Mgli9xZUvtw/WB0xki8seQjyIEoKmASoL+1yIHQzNEo573AoxyfZN2oUAggV
	TweGwCvwl6jNpWMRUsesfFTLKOQjMG57FK1IeWRrRklovZMmZPFZhr+xVhJconV44jdFUbqWJUz
	NHNlKUDt4zCNkIfN/xdz/1EDrPqQeI0akmFNgIBy/9GIBfaVYLIYu2IHrJfoEoNTJj5EOZnmu7t
	1rz3Y6M9C/sU46SNFYGBLzyc0LBAwqjNQbb4c8/ljkWIfPwgcUhs8HifPPR7IC1qtpmThGUiUNo
	sOWESQbSGkAnG9Cq6lR0=
X-Google-Smtp-Source: AGHT+IG2Abrrb2Bkf7fXxQiqMr72e9kTBh1GvfWBZ8QL5uolROn3v8+EEWeWxSghy3tITOYIesSJgg==
X-Received: by 2002:a17:907:3f1a:b0:ac1:da09:5d32 with SMTP id a640c23a62f3a-ac1da09d207mr510859166b.6.1741069989395;
        Mon, 03 Mar 2025 22:33:09 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf4cbd77b3sm586949566b.74.2025.03.03.22.33.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 22:33:07 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1016193166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 22:33:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgCAnem1/h9H/dni+1YEr+J3iI4KrOwUuOs0qK3rD0aojkJDcL3onfIJxHufGHqnW4VdX1kemX9+xGUZVF@vger.kernel.org
X-Received: by 2002:a17:907:d90:b0:ac1:e2be:bab8 with SMTP id
 a640c23a62f3a-ac1e2bec4cfmr418813066b.26.1741069986218; Mon, 03 Mar 2025
 22:33:06 -0800 (PST)
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
 <1a969884-8245-4bea-b4cc-d1727348bf50@amd.com>
In-Reply-To: <1a969884-8245-4bea-b4cc-d1727348bf50@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Mar 2025 20:32:49 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh804HX8H86VRUSKoJGVG0eBe8sPz8=E3d8LHftOCSqwQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqCPbp5F6rtPDaoEtKo2cLB4OW__15FO9jOkbpgZdLjhluznTu2FTcwa9g
Message-ID: <CAHk-=wh804HX8H86VRUSKoJGVG0eBe8sPz8=E3d8LHftOCSqwQ@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 19:31, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
]> > ENTIRELY UNTESTED, but it seems to generate ok code. It might even
> > generate better code than what we have now.
>
> With the patch on top of commit aaec5a95d596 ("pipe_read: don't wake up
> the writer if the pipe is still full"), we've not seen any hangs yet
> with a few thousand iterations of short loops, and a few hundred
> iterations of larger loop sizes with hackbench.
>
> If you can provide you S-o-b, we can send out an official patch with a
> commit log. We'll wait for Oleg's response in case he has any concerns.

Ack. With that testing background, please write a message and add my

  Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

and we'll get this all fixed up.

I assume this all goes back to commit 8cefc107ca54 ("pipe: Use head
and tail pointers for the ring, not cursor and length") back in 2019.

Or possibly 85190d15f4ea ("pipe: don't use 'pipe_wait() for basic pipe IO")?

But it was all hidden by the fact that we used to just wake things up
very aggressively and you'd never notice the race as a result, so then
it got exposed by the more minimal wakeup changes.

            Linus

