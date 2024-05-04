Return-Path: <linux-fsdevel+bounces-18733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DE88BBCD6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EB7B20E85
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E733747F4B;
	Sat,  4 May 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HWYpKkor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E6225D0
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 May 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714837246; cv=none; b=AX9iLotGJHOXeF9aTc4M3OKrnSCYxycbT13jKIoi/p+DYVvhrTHvpK5yd5Q+O4Hi/4VdjtlRC42Y9p0T8EzkXEcjVNAHpXGK6pWdnRVujs5UexRC+D6W44eeJZxNoPwOniSpIA7s2AOwUKGaBwT2bXO/CqYLvMoKO5Z78tOcdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714837246; c=relaxed/simple;
	bh=+wl7Si+XKc7WGkikTFO8826D1qbowNHEhUrycKotHDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2opA8mp4asQKeBkgeu3wpSDidSu9g2UhBaGYEiuHm5nUScZD9tb+FGpeZ5j+HEW5wTX3qM8VxTrjht1tyT4PmQRIaQcJ/B6KCHKPURjfL4tl+Eia8usEQVpKaQTwbceQAU6ufdpJhGkhCXh3DIu/9DCCGLi/N6mk/M9OrwZqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HWYpKkor; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a64db066so126020566b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714837243; x=1715442043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PFxw8P3AYgeC7IB6rTn+68WOAU10n6cRPv/6X7o+SOY=;
        b=HWYpKkor+X0OlBZ+pN69qc1p+9D286NR/kjb9Eut9WyLQcVKAOVM+kjWJolAyRIjnb
         EleZB/FacFvDmPO7B6sIPd5rt4NS4hLPAbwx/r0yyPImDmy+aY8X2i+CokrQrNVi9S9s
         PrkfUJUNyE7Febc1tcRFEVT+pa1I32u++fKWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714837243; x=1715442043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFxw8P3AYgeC7IB6rTn+68WOAU10n6cRPv/6X7o+SOY=;
        b=DMnhXMZ2mTfK8lvwHfwmuT3PP0fJSdehTVXTJb5QwZ9R7cTL95hGOqXTB/BgDHyDhh
         pgminCJR7Hunavq9BpBjM3mr0OrqTlzOj4ELAe+pzKMFm5wUB2QCF1LR5pqHLspBCXfH
         6Xkhz5Aw26QIaq1WApJ3PxHtLWGAXXEgd29n23FQEpkEliwPOB04WYHii9FW486Osk1p
         jAt+FDwlpUBo2J8zF5ojRJPqwjXc7STGReEB5hTG0Eii4LXjIL4zFRhl+Vuy/H3l4wui
         e4dEI5bZjMBsATwGAr5LbLxxXX/Cgt/4dVokohlVW9iJC1lCmJfgpdBKzTk/ZtLChktc
         6MKg==
X-Forwarded-Encrypted: i=1; AJvYcCV+WyPBnoLc9u+TAJaDgWtdW8G97YzsyF3pmBf/L5JOVfo/yevvsrgaHQ+bUfxIIkCuMOPXlDi3hGVr5PPg2QMhGs7aPqvyNbFgW6hesg==
X-Gm-Message-State: AOJu0YxGnMRdoUuzqjhee+lWXk63+MbMxyP3auKKzHsOj+5lwLThLrGl
	3V0mTZ4yqaT8zGiMp4pR79cG6uFVTSUUvAzilok+AQWoCOgCequgLVez17q54IMaGuzd1TYuDJ6
	EYEJ96Q==
X-Google-Smtp-Source: AGHT+IGobBwwm+1fLjGi6v1ph1p/0bzgG9Ik1jjP7MZxdF3LXHfItHEKoxei4c2F/UPhybRQ2ybDkQ==
X-Received: by 2002:a17:906:b80b:b0:a59:a0ec:e02d with SMTP id dv11-20020a170906b80b00b00a59a0ece02dmr1473512ejb.8.1714837242922;
        Sat, 04 May 2024 08:40:42 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709060ac700b00a59a0ddcc3dsm1211576ejf.44.2024.05.04.08.40.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 08:40:42 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a9d66a51so91467966b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 08:40:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQ72wCPqxJJ1EJGG7O6TYwRD3QdsPkKeYinvexIIS8/u/xWN/7e3gwKQBquwwIDwQ9WIkIPfFWAyQcSfIuYE/2DGv31UAVNThbq/SUgg==
X-Received: by 2002:a17:906:cf83:b0:a55:75f6:ce0f with SMTP id
 um3-20020a170906cf8300b00a5575f6ce0fmr3540131ejb.13.1714837242162; Sat, 04
 May 2024 08:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
In-Reply-To: <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 08:40:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
Message-ID: <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
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

On Sat, 4 May 2024 at 08:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, during this TOTALLY INNOCENT sock_poll(), in another thread, the
> file closing completes, eventpoll_release() finishes [..]

Actually, Al is right that ep_item_poll() should be holding the
ep->mtx, so eventpoll_release() -> eventpoll_release_file_file() ->
mutex_lock(&ep->mtx) should block and the file doesn't actually get
released.

So I guess the sock_poll() issue cannot happen. It does need some
poll() function that does 'fget()', and believes that it works.

But because the f_count has already gone down to zero, fget() doesn't
work, and doesn't keep the file around, and you have the bug.

The cases that do fget() in poll() are probably race, but they aren't
buggy. epoll is buggy.

So my example wasn't going to work, but the argument isn't really any
different, it's just a much more limited case that breaks.

And maybe it's even *only* dma-buf that does that fget() in its
->poll() function. Even *then* it's not a dma-buf.c bug.

               Linus

