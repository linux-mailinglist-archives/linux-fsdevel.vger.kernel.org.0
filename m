Return-Path: <linux-fsdevel+bounces-18730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF08D8BBCBA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 17:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6000B1F21258
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A787A4500E;
	Sat,  4 May 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f/fJiU4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A33EA9B
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 May 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714836748; cv=none; b=Dmw/NmwbF5C6Lu9SV2wSPWvMp8rxrKGEx8eMV3V5sqL2BuIWG82FmlAGZVDqpEwM0rOaBi2iLCYouM4In1t3e6YjPhbCkS91bDY4xQId0ORN9fs6WZ1YI3MbgbxdGj0v8YTfMjPHfPij/1mcKUt8qvGvWjiM/SDjN6AmR/yiXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714836748; c=relaxed/simple;
	bh=dmLzNSiqTCKSgtEtdi4RT/LW9OkahTnAY3Pn0EDC+4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cr/xBdaFU8BMaQjE+88261iRTjUE/vGQpctep7uSWuxkmu1CMSHvjAwQl8v/W/v9+U3Ov4+JnwqNHu6JXtkqmuufa6r/PugUHocBhy2Zx5PdvFrHmnPlljKZ2Qhr21Ch9eYPxZSg6BfXnOxRdp3C6455Ol3Hdyj/AvNFNercBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f/fJiU4L; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a8f0d941so104230566b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714836744; x=1715441544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BF+X0IVed+h7jlJZMJqRgUDnAGAy0IxXXOyqwBdkEc0=;
        b=f/fJiU4LHyGtFV9UlcTICC2xvhZyDCOnV/Vg/WOk1CZ5uhcQWKlMvgV4f4kTCXyOQf
         +tEGGQ/zAIjkNPJMJqfOPAjXaJ70kf/vgQ98zRoFH5swOwszOALS2IHCt2lm3wPzC9c2
         aXvqbmkbnHCwpnjfddbYX5hW4Gz6nlabdy6Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714836744; x=1715441544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BF+X0IVed+h7jlJZMJqRgUDnAGAy0IxXXOyqwBdkEc0=;
        b=nifziEvMR8PqBitHh9iC3K850Ovzux4onBc4wfZU0s6yAFE/Zh6dTpgtTsGNWW77mQ
         rEqVCLofF0GGUd/P/QPdoBc30T3t5SbD3dQEs87BYxAgnW2Igvu+e0zcbgMFL83QL+xW
         nouqpRE+WePOIgsJcZoWSw87cfCbjCmviHgyLgbiFzI96EOaC8ZQ0mOPe4rduFKZonbA
         mYep08u+Lcqc5tu1rdx/3H9QoZQzZmXXWAkrrVtXtvoSdCFeizAud2E1GCjX93NJhCZ9
         thLMvtd8/pu2YCaKWYjS11vJO+AXMq1kkBcaS6Eqj2rUD6XVKwDK3qjg0qSEKGs2df4K
         cJdA==
X-Forwarded-Encrypted: i=1; AJvYcCVRC3BW2P6+nPWDQuoPHHg4QpXdHymJo/JHjf7sASrKO9DTDN3DBQhVqQ4nQXFdGi9io5GZ8NXVmheNOxaay8v8/AtDnf1l3Iz+k3StgQ==
X-Gm-Message-State: AOJu0YzXxC1Y9NriRQzJdGa52Lgqqsh4RzUSPPiv4VOwaAOGpLkkXt4a
	LQ5aBiYJh6jSKy694YskiW4jfjT6niU7kAEj+XObaw9FC4DuuNPxbY+G3KBHr4XICsvnKLM+LJb
	kT8eNRA==
X-Google-Smtp-Source: AGHT+IEi9Lgi7E9WcfrDprRECcSRKUX+/1FGkqnHmW6bgm1zxNE5v8dxEvyWXFSX9pFgtcXX1BnOWA==
X-Received: by 2002:a17:906:110c:b0:a59:7db3:a0dd with SMTP id h12-20020a170906110c00b00a597db3a0ddmr3068441eja.65.1714836744268;
        Sat, 04 May 2024 08:32:24 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id q3-20020a1709060f8300b00a58a67afd2fsm3045740ejj.53.2024.05.04.08.32.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 08:32:23 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a0168c75so122140566b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 08:32:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUL7IGqiCLPbUwQlADdJMt0sJc8A2wNYX5zskjiOs3He6Y2SoXnuy/ytVf1W4yVDrHW0GbWRhXFQaC9nzV8R+LsTrFyTaHJr1csn6jVPA==
X-Received: by 2002:a17:906:5fd5:b0:a59:9e55:748d with SMTP id
 k21-20020a1709065fd500b00a599e55748dmr2287623ejv.35.1714836742417; Sat, 04
 May 2024 08:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner>
In-Reply-To: <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 08:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
Message-ID: <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 May 2024 at 02:37, Christian Brauner <brauner@kernel.org> wrote:
>
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -244,13 +244,18 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>         if (!dmabuf || !dmabuf->resv)
>                 return EPOLLERR;
>
> +       if (!get_file_active(&dmabuf->file))
> +               return EPOLLERR;
[...]

I *really* don't think anything that touches dma-buf.c can possibly be right.

This is not a dma-buf.c bug.

This is purely an epoll bug.

Lookie here, the fundamental issue is that epoll can call '->poll()'
on a file descriptor that is being closed concurrently.

That means that *ANY* driver that relies on *any* data structure that
is managed by the lifetime of the 'struct file' will have problems.

Look, here's sock_poll():

    static __poll_t sock_poll(struct file *file, poll_table *wait)
    {
        struct socket *sock = file->private_data;

and that first line looks about as innocent as it possibly can, right?

Now, imagine that this is called from 'epoll' concurrently with the
file being closed for the last time (but it just hasn't _quite_
reached eventpoll_release() yet).

Now, imagine that the kernel is built with preemption, and the epoll
thread gets preempted _just_ before it loads 'file->private_data'.

Furthermore, the machine is under heavy load, and it just stays off
its CPU a long time.

Now, during this TOTALLY INNOCENT sock_poll(), in another thread, the
file closing completes, eventpoll_release() finishes, and the
preemption of the poll() thing just takes so long that you go through
an RCU period too, so that the actual file has been released too.

So now that totally innoced file->private_data load in the poll() is
probably going to get random data.

Yes, the file is allocated as SLAB_TYPESAFE_BY_RCU, so it's probably
still a file. Not guaranteed, even the slab will get fully free'd in
some situations. And yes, the above case is impossible to hit in
practice. You have to hit quite the small race window with an
operation that practically never happens in the first place.

But my point is that the fact that the problem with file->f_count
lifetimes happens for that dmabuf driver is not the fault of the
dmabuf code. Not at all.

It is *ENTIRELY* a bug in epoll, and the dmabuf code is probably just
easier to hit because it has a poll() function that does things that
have longer lifetimes than most things, and interacts more directly
with that f_count.

So I really don't understand why Al thinks this is "dmabuf does bad
things with f_count". It damn well does not. dma-buf is the GOOD GUY
here. It's doing things *PROPERLY*. It's taking refcounts like it damn
well should.

The fact that it takes ref-counts on something that the epoll code has
messed up is *NOT* its fault.

                Linus

