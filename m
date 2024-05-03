Return-Path: <linux-fsdevel+bounces-18700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555B48BB88C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 01:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A51282B2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08E985649;
	Fri,  3 May 2024 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZGjV9bOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C675824AC
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714780507; cv=none; b=CwElKTY39OLcHEC2iQjPR2hoyRsFo8mxibFVA43uRUueTDHn8g6JShk8iS6/lPTjzB1n0ntdTg5GDYCyVF/wcB0glsIIs2jItNGiIdetXQ+qJu/obqXNWWbLNNra6XBQxuSv4Ro74s9JWc4BcH/K3XiNxapJHqjEWgA8kH3QqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714780507; c=relaxed/simple;
	bh=tf8gPRKnHuj1S8RN72oCYha0zRiI+Zqb52T37Eym2SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i83VzJ9M84YZuvaxvwet3ExIhOcUtHFyPNMGXWlFaBm0426A6+DGd4aoCLrw/Gfl+Vpzc601wRzQuGSa7XE/vUpln20j2zly7N6uSOOIgw7V/UkiaTbBkfLrnVkJVCNPzkN0uUW7nlGESD9rndWQtYWHFOmQR2OXYsLm2ZAImFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZGjV9bOJ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e0a0cc5e83so2111671fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 16:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714780503; x=1715385303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxPhlO3npeMKaw71dXY38r1VkXmdKnYRPE7+RntnY6E=;
        b=ZGjV9bOJtsx4vpIPOC+jl/xOHEhJ7ml4JgIzgS1AsIh9S5KtVKfqLKs5lLGdXsqdqf
         rWkxV9dUaT0DUgXtI/DlRGk7Nc6D3XFWtZVWDF3oll1MHPi3o8BiJMn9wp/AQUXXjouJ
         RyC5Ror5S88Byqw9QIUO/60WEA9J8Zz0r3ca4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714780503; x=1715385303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxPhlO3npeMKaw71dXY38r1VkXmdKnYRPE7+RntnY6E=;
        b=fc1JrskSjNAteKIQ2PG9v974U+HI/D4Ux8b0BVrafDCR+t314mfBK2LYMkzi5PW1Tq
         i6CllDykB5EyARRmxX7OJ+WKUNzl2sw5hO6np32x0I/A/a7hdbs85zymYp50pwSAZqeZ
         /4KK50tv8HeMG04M06m/V9brG71Am5cQzirpEb+khn0e0X2OarJMuMySE6qCt9Ec6SWi
         c1RDiY2MxPT2SULFpmDE2spGLWa2Zl4ydjR/CUQN9EMBrF/v2FXlGdP8int6X1QkN97j
         oG7d/BZr3IBMBIzWvPkA27u+iiN41wo9/euLtsLgVofX4d9kGeB1VnKMKUNHgkonGkw5
         vf2g==
X-Forwarded-Encrypted: i=1; AJvYcCXA07dpk3ypnw5mYj8bo4OZ8BzVhBWoK294LiEmtTHJTTurSj0fbBs1QYUJvwqW5/RIRnwBfL8eTdc0Nb51QDNkP7KfUsH4LsERk9NTng==
X-Gm-Message-State: AOJu0YxBFIpj6TQtzXbJd8Y0+b0j+5iMVkJhBVoKgwWc+4zG+rZ/EWSz
	GkUSKf+53FGkyrukTohFFTuHxm6VRtHbD6CWMmYUDZMBpq7/4ImHbwn7XxHhtTTDHMExXLlk1Ng
	AEwd6Gw==
X-Google-Smtp-Source: AGHT+IHzVcRUStikRIJwhQ/1QD6CdRsGXYflsX3+SCD5jDsr2/KzGDDVWibtyDh1TPAYZir0Iqe/gw==
X-Received: by 2002:a05:6512:3f1a:b0:51e:1264:8435 with SMTP id y26-20020a0565123f1a00b0051e12648435mr3202902lfa.27.1714780503582;
        Fri, 03 May 2024 16:55:03 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id ot38-20020a170906cce600b00a5994c5c948sm1140306ejb.133.2024.05.03.16.55.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 16:55:03 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4702457ccbso27556766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 16:55:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYHQoRFSOQn3pVzmj4u11ag80YMQcEOk7HR5YGLLw7B9Q4ooCTDprjfqVL6bwwunnYZ+yX2wmxGtXtTEwJFmSnNWqFw9p67Wo2Tr1AWg==
X-Received: by 2002:a17:906:3e4e:b0:a59:a64c:9a26 with SMTP id
 t14-20020a1709063e4e00b00a59a64c9a26mr202788eji.23.1714780501707; Fri, 03 May
 2024 16:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240503214531.GB2118490@ZenIV> <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>
 <20240503220145.GD2118490@ZenIV> <20240503220744.GE2118490@ZenIV>
 <CAHk-=whULchE1i5LA2Fa=ZndSAzPXGWh_e5+a=YV3qT1BEST7w@mail.gmail.com> <20240503233900.GG2118490@ZenIV>
In-Reply-To: <20240503233900.GG2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 16:54:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjjsm=f+ZJRe3dXebBQS8PzpYmHjAJnk-9-2FAj3-QoQ@mail.gmail.com>
Message-ID: <CAHk-=wjjjsm=f+ZJRe3dXebBQS8PzpYmHjAJnk-9-2FAj3-QoQ@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: keescook@chromium.org, axboe@kernel.dk, brauner@kernel.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 16:39, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> *IF* those files are on purely internal filesystem, that's probably
> OK; do that with something on something mountable (char device,
> sysfs file, etc.) and you have a problem with filesystem staying
> busy.

Yeah, I agree, it's a bit annoying in general. That said, it's easy to
do: stash a file descriptor in a unix domain socket, and that's
basically exactly what you have: a random reference to a 'struct file'
that will stay around for as long as you just keep that socket around,
long after the "real" file descriptor has been closed, and entirely
separately from it.

And yes, that's exactly why unix domain socket transfers have caused
so many problems over the years, with both refcount overflows and
nasty garbage collection issues.

So randomly taking references to file descriptors certainly isn't new.

In fact, it's so common that I find the epoll pattern annoying, in
that it does something special and *not* taking a ref - and it does
that special thing to *other* ("innocent") file descriptors. Yes,
dma-buf is a bit like those unix domain sockets in that it can keep
random references alive for random times, but at least it does it just
to its own file descriptors, not random other targets.

So the dmabuf thing is very much a "I'm a special file that describes
a dma buffer", and shouldn't really affect anything outside of active
dmabuf uses (which admittedly is a large portion of the GPU drivers,
and has been expanding from there...). I

So the reason I'm annoyed at epoll in this case is that I think epoll
triggered the bug in some entirely innocent subsystem. dma-buf is
doing something differently odd, yes, but at least it's odd in a "I'm
a specialized thing" sense, not in some "I screw over others" sense.

             Linus

