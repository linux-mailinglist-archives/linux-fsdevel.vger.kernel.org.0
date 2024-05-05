Return-Path: <linux-fsdevel+bounces-18763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F658BC291
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 18:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E963F1C208BA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11043FB9D;
	Sun,  5 May 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jh0m25dd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85B28377
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714927588; cv=none; b=da/7es+JYBbrbRtG1tkOHvgVVWKfrSpEs3j5ND/qs2wu9HZKP76mdBQFyLGt6BN+vq6CWE274RujzuXDbmkjq6SyN2yoMk8Hvs4+/A+KzyitKYul8C6mmT374YcMVoKgdcObj9/goEZ7gaw0ENu1i0imTxxFDWm59UIZv+IUhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714927588; c=relaxed/simple;
	bh=CLhNByDrSyy3KlkeokG4swipYxw1p9LkQ6WM4wj072Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ui1HaqqxnTt3u3uHJN6zWMlVxb/WyRtHrw665z5DlaaS4sm1g+KF7GaUqyHYM7iioNItGzjp8H4s3Qke3wxS3CzYZ7CXCsVJbaC4xGL/+6rFBJAY+qZrQJTD88VnVsPTQJkaaNAIX2e+gAJIvqj4y/4BOleMf6EEKdGXPWXCF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jh0m25dd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f3761c96aso1470490e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714927584; x=1715532384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aYdtp3YANTth8Vi9S+yHKBJaPcPwhcLOgY9vMAI/QdY=;
        b=Jh0m25ddNdP2B2AMRer6g2SsW4aWlFV4wvbACB4nQ9lt2L9qHjX30wG6XAmXRJqb9b
         cnDKyodeqsI4AtByabWH8SPehOzuKTxu659W1aKn8zxvej/pit6U6xPJg7vIiRNCPxJT
         Pmhip1fNYVkrmjHVLDxwcOUHdbIpck4jh1lVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714927584; x=1715532384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYdtp3YANTth8Vi9S+yHKBJaPcPwhcLOgY9vMAI/QdY=;
        b=GAS0ozaFoNPAuyx4A8dkyKbI2byd73PQFYmNZvJJLs5LB0/R/whN0VX5ZfV3KIPRIg
         yWO9u68hLzcWqbPQL5xvkaoB4oNO0sLfhOTKwpZpOyPAi5089lryXPRdBxJk1AbYvVS5
         d/QI+acqnCJxIxjc4CEzLslafr9EUH7xb2dfdoKc/FEE+cAHEvnXYbKyJfaLZZWN9ra5
         7yXAKKUj9oRHlKqeqBmRIBoG5HOH7/V94ttZuW4hkY/EfuJBLsDirgzIw37iZpxj7Nxi
         +l/wnxpcBC4TwbHz5c0N8YZ+fDG3TYgnJX6XgddLz7oZtvdpaGI0S8d99Gzg/rdnLDBH
         AI8A==
X-Forwarded-Encrypted: i=1; AJvYcCXPwewC5X5tpWERNUug0fEolLQzouuaSeqsVo6dT8Kc3MQpIUrvtIkyWrHhqwz+NNjEto2El67q9JqNb7UkXKs6xy9RymhAvpAmBBoWOQ==
X-Gm-Message-State: AOJu0YzjFycCNdrj7EDpMP8LS2+2fg1E96S/oSuTCsswpeTECdL/gotw
	FsIsj84gULclgl3c79I3XfQsHy1Nzwto4bA1eiyn+kOQqGAb9hddhD8s5d1/VIyHO4SonnvIbwV
	va8sHRw==
X-Google-Smtp-Source: AGHT+IF7jtqNDZHFUEOsOFbvHN+cTHRmfLvqHJoH1sixO8hUSVKp/dtgwGcSa+tdybjm8apjwwuHpw==
X-Received: by 2002:a05:6512:310a:b0:51d:a5fb:bfd8 with SMTP id n10-20020a056512310a00b0051da5fbbfd8mr5980149lfb.32.1714927584430;
        Sun, 05 May 2024 09:46:24 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id fw17-20020a170906c95100b00a59cfc54756sm82976ejb.210.2024.05.05.09.46.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 09:46:23 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so212225866b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 09:46:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXekllREYPzHtaKMZlsOiGV6+WgEXvejgTd/Gx2jcOibeW1isRgtDKUcj7l4Ix9TnikU3z11q9k+g09BXITPmP50BMS7ickMbTKFKH53Q==
X-Received: by 2002:a17:907:3f9a:b0:a59:c5c2:a31c with SMTP id
 hr26-20020a1709073f9a00b00a59c5c2a31cmr2077374ejc.33.1714927582181; Sun, 05
 May 2024 09:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com> <20240505-gelehnt-anfahren-8250b487da2c@brauner>
In-Reply-To: <20240505-gelehnt-anfahren-8250b487da2c@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 May 2024 09:46:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMzzfPwKc=8yBdXwSkxoZMZroTCiLZTYESYD3BC_7rhQ@mail.gmail.com>
Message-ID: <CAHk-=wgMzzfPwKc=8yBdXwSkxoZMZroTCiLZTYESYD3BC_7rhQ@mail.gmail.com>
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

On Sun, 5 May 2024 at 03:50, Christian Brauner <brauner@kernel.org> wrote:
>
> And I agree with you that for some instances it's valid to take another
> reference to a file from f_op->poll() but then they need to use
> get_file_active() imho and simply handle the case where f_count is zero.

I think this is

 (a) practically impossible to find (since most f_count updates are in
various random helpers)

 (b) not tenable in the first place, since *EVERYBODY* does a f_count
update as part of the bog-standard pollwait

So (b) means that the notion of "warn if somebody increments f_count
from zero" is broken to begin with - but it's doubly broken because it
wouldn't find anything *anyway*, since this never happens in any
normal situation.

And (a) means that any non-automatic finding of this is practically impossible.

> And we need to document that in Documentation/filesystems/file.rst or
> locking.rst.

WHY?

Why cannot you and Al just admit that the problem is in epoll. Always
has been, always will be.

The fact is, it's not dma-buf that is violating any rules. It's epoll.
It's calling out to random driver functions with a file pointer that
is no longer valid.

It really is that simple.

I don't see why you are arguing for "unknown number of drivers - we
know at least *one* - have to be fixed for a bug that is in epoll".

If it was *easy* to fix, and if it was *easy* to validate, then  sure.
But that just isn't the case.

In contrast, in epoll it's *trivial* to fix the one case where it does
a VFS call-out, and just say "you have to follow the rules".

So explain to me again why you want to mess up the driver interface
and everybody who has a '.poll()' function, and not just fix the ONE
clearly buggy piece of code.

Because dammit,. epoll is clearly buggy. It's not enough to say "the
file allocation isn't going away", and claim that that means that it's
not buggy - when the file IS NO LONGER VALID!

                      Linus

