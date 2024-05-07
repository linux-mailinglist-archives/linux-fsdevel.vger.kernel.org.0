Return-Path: <linux-fsdevel+bounces-18944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F5C8BEC42
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 21:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158951C23121
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 19:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FDD16D9DF;
	Tue,  7 May 2024 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DFUwi571"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332A14D2BE
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108851; cv=none; b=S4Gdk8oiTPqgXpFeH3aNTgKYfJfRRnLWth/CWBm0s/aSTcqf/EYfhPEbf5sT3JOyGAr/Iz9dxxUOaaqwOi3vRf/8YlzGPDWQ4lAY9KicJo1+mogMnrIPq26l9VB0yf9pMlnzP7cm7GRM3w+xw7zZ6d3K6z9pkpNhzj4wm8Lwhc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108851; c=relaxed/simple;
	bh=pui840tsR5Yet33PCWgvY2wZoLY0nvaSbhvNkKxiwJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb7pRYo/7sYjj1eVcWrzic0veyiMhLUm6ZFUUSUxKx7cF5cGUzTyNQr3vxl/p45wvOmfrWb9n6nh0y9UTNiKrkmo1H4039m6onUxlH+LitMIEg3kEiZOI+cAB/lWt0h8qlBx3iun9/WEjly3Jcd6aQp3z5rWMBiYG6rAlYCwRDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DFUwi571; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a599af16934so887769366b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715108848; x=1715713648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JwU1IWNzhlSP5EH9iyMHaFmRpSbbE8IFJCVgZMlAkcM=;
        b=DFUwi571hMybU1SwqwwPzNd8bQCjuiUB4OnZhMGkTqj/h1M2JrfFlye5c3fPt8sSMa
         56bEzZxMn21nPIiO2CmFrwljmDAScNRWYGg8dzSueW+f+Rmc0UUGBDtWkQz1/9WRqYTP
         wO1aLH8edV8HeIUdW22yvJ+T5YneqENlhPIRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715108848; x=1715713648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwU1IWNzhlSP5EH9iyMHaFmRpSbbE8IFJCVgZMlAkcM=;
        b=pJNfDJ5GZO2fOv2oAZ+npu8lmw9PHvN5dNAvfDwvEWBuVdcBtD1z/Ca6XimmzJqliu
         IJR2Aq69Pfzdym2ypxnvK8qYfBA1iLOf0s6cd6WomEEHBFCoPSuu6RtRsrrehAeN8c5F
         WEmfQiZK8jc0zqI5U9jIhgy+3ECPkofrpAOmR9o/I038ues9F2aBZyaKkLhzkOQIkBnB
         cFTgs48LkWpLYXRQNoDSuPsH64mLur9g5RFbDurG8xDvruS3VqKtzNJxMpY9qZ2VbYF7
         7apXJM1WrWvIaCM3q68bcTCm6YQw0CpGU8USWzAiNw035bxY32TVHoiLWgsXGf71P8Ao
         91Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXGhiakyGFc7n1c280Z/KyMTEeWBzpD57Nss1LZMzYC3upBnEKpyMgfvUvClmgnJKR//Gu3lp+m+65LxQIBALlQNaHrZKTv0NMcZ0SOuA==
X-Gm-Message-State: AOJu0Yyhdb9HaP/iML0Wwn6gWJ8JJJ4fSrFxvowlwcJgsGgfumf2w7c/
	nh1O2knhDzwAaW0XkJBXknBy1R0L48QIZUnRjciFCYgD30r/3ZhCw0vzPomS2kh7m+n4yP2OR/p
	MpnplEA==
X-Google-Smtp-Source: AGHT+IFkolD920waiAI0/dElFYh2YClHFwlXfIeMeO/fOQnYs7k1kJ3sFr2bWOFAf7x+nfkx6afShA==
X-Received: by 2002:a50:bace:0:b0:572:42ac:9b19 with SMTP id 4fb4d7f45d1cf-5731d922dc1mr467375a12.0.1715108848059;
        Tue, 07 May 2024 12:07:28 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id es26-20020a056402381a00b00572e2879500sm4472789edb.53.2024.05.07.12.07.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 12:07:27 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a5f81af4so918579266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 12:07:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFFsc0Yu/Z9KJHuq0s7R+YC6K31h1ExqzMGOEpu7udThsnredu6qtonwMKha8GlnvYJnVnbhWsGd6w+W8tMcdbfhbLzmoJht4JXmKRGw==
X-Received: by 2002:a17:906:1957:b0:a59:a977:a157 with SMTP id
 a640c23a62f3a-a59fb9f209dmr23097766b.73.1715108847432; Tue, 07 May 2024
 12:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
 <b1728d20-047c-4e28-8458-bf3206a1c97c@gmail.com> <ZjoKX4nmrRdevyxm@phenom.ffwll.local>
 <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com> <CAKMK7uGzhAHHkWj0N33NB3OXMFtNHv7=h=P-bdtYkw=Ja9kwHw@mail.gmail.com>
In-Reply-To: <CAKMK7uGzhAHHkWj0N33NB3OXMFtNHv7=h=P-bdtYkw=Ja9kwHw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 May 2024 12:07:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com>
Message-ID: <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH] epoll: try to be a _bit_ better about
 file lifetimes
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Simon Ser <contact@emersion.fr>, Pekka Paalanen <pekka.paalanen@collabora.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, 
	axboe@kernel.dk, christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 11:04, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, May 07, 2024 at 09:46:31AM -0700, Linus Torvalds wrote:
>
> > I'd be perfectly ok with adding a generic "FISAME" VFS level ioctl
> > too, if this is possibly a more common thing. and not just DRM wants
> > it.
> >
> > Would something like that work for you?
>
> Yes.
>
> Adding Simon and Pekka as two of the usual suspects for this kind of
> stuff. Also example code (the int return value is just so that callers know
> when kcmp isn't available, they all only care about equality):
>
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/util/os_file.c#L239

That example thing shows that we shouldn't make it a FISAME ioctl - we
should make it a fcntl() instead, and it would just be a companion to
F_DUPFD.

Doesn't that strike everybody as a *much* cleaner interface? I think
F_ISDUP would work very naturally indeed with F_DUPFD.

Yes? No?

                       Linus

