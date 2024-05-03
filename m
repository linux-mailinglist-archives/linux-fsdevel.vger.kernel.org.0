Return-Path: <linux-fsdevel+bounces-18694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A078BB814
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 01:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7FCB22793
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5F5A4D1;
	Fri,  3 May 2024 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cr6KDcwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E983A0A
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778196; cv=none; b=QLc7+WZ7cNVG3Oc6AA3dBrey6owPKdkXIyJj4Xa13k9lZXtWSUOOcA6MEkS/2ZW9roaNEUhaLu1//bTl4MjnTfrEnufCYFgfcbMaLPHlQyYphYfJJWQX8kCvtneivqRMuW2ycUZlDQf8iXEbMIE0za2qfkZ1lkfIyoaFh7guJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778196; c=relaxed/simple;
	bh=10Im6Ev0hm6GCexrKsrsuAqt7UP5HFJ90hGsgvNShJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpzbZ/trUjir9le3I7Rayu7OZ0KZ2nSTnE3jxMO+80SOA1eePuI9gIOB9ZocMGBDNkpd7XgjzQJr6Wxi6ZoYOt/CxmQVJDmAbCJ1HqFuEHdjLotGdxx6x52YxKeskW/en0+iad5rXSQt1cQtdKdJoUdKpSFd42eS/QYepqC2/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cr6KDcwO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a599a298990so27261066b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 16:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714778193; x=1715382993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cGG/rn4AzL6EAyTxraRF01dNEmbt6QApJhVwyWVeemo=;
        b=cr6KDcwOBUIXzfzW+aNT6dgf8KM9w5+3PMr5OKvI6Ga+or8Tl/OQwW8KeaA6oNLpL/
         zpBaK+8FRxNloQNR4hpFVbJoQKsWtJg7hBuZZprnICOrHGrkjAWgzfCoPwj6V/tXaTie
         lVcB6kJEJs/RUNfT64DDvOdNFYBLvH2Izdegs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714778193; x=1715382993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGG/rn4AzL6EAyTxraRF01dNEmbt6QApJhVwyWVeemo=;
        b=G77kjG2sTIrDUluD2zN5TwLxLS9lFKr3Y9m/o2Z4RA64BmCDQjw1kwYyimq0MMkAwi
         0VpN9EbEo5JU/0Oj4o3KJWKl/2voDGada9UNs0Wvmu+u1ATWfkBFcX84aZnWo4u/h/Ut
         Jt9Yp55UbjRULQhJP/vbYAbMsxqMr1DJSnQxbsdZtXD4rUikum0KLPiH5L4FRjd2HLkC
         Bsgvr3gxUX9lrcMBhjNTFqwJbN9Oatz/2IRdkNtXsZ/CbZduzKga0aBvXZ2jaIzHVSsk
         BRJSHzDIPx/+b78oK2Nz+kOuJlF3GFUN05P1lt74QzKHB/yzhgapFSuu38VNeOgnahJU
         FIBA==
X-Forwarded-Encrypted: i=1; AJvYcCUSPH99OryKiDugGltI/5ZxhQfgAyfwm6dUh7ql5hLVOoWXwksTKbYHPL/H007qVG6xlvq6bEJF3ZtFnA3mAcFZimgpR/hXtGe/fWZB1Q==
X-Gm-Message-State: AOJu0Yxdc+Oyk4wmwcH5MIC9oo6X0jVG2z6/m5rUfx9dk1A11bMeGm8Z
	0D92M37XL8th3cmp0thuNEDQ92oaPOIFcxGI0l8I6LCGQQzJay6RH4Sryy3QXjg3vXNMb6eOw2Z
	slughrw==
X-Google-Smtp-Source: AGHT+IE0HaP1dfCwOURCwegHmXvvPMW/5uIsRQkfdDAYQmD0pcob0q3ociUtpejYT6BebqSTute23w==
X-Received: by 2002:a50:8e17:0:b0:56e:3774:749b with SMTP id 23-20020a508e17000000b0056e3774749bmr1878893edw.42.1714778192506;
        Fri, 03 May 2024 16:16:32 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id h25-20020a0564020e9900b00572cfb37bd6sm1409488eda.8.2024.05.03.16.16.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 16:16:32 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a595199cb9bso21647366b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 16:16:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuOqFU00FekI3wdmJTx1DTLBAh043G7eg+RJTrEsNfHwiDclm355gwIWshvz3yoL6w9sWftwA2W0Tnp1YBzBKc8+voh9KNfRIWbahjcQ==
X-Received: by 2002:a17:906:52c1:b0:a59:2e45:f528 with SMTP id
 w1-20020a17090652c100b00a592e45f528mr2851931ejn.38.1714778191864; Fri, 03 May
 2024 16:16:31 -0700 (PDT)
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
In-Reply-To: <20240503220744.GE2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 16:16:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whULchE1i5LA2Fa=ZndSAzPXGWh_e5+a=YV3qT1BEST7w@mail.gmail.com>
Message-ID: <CAHk-=whULchE1i5LA2Fa=ZndSAzPXGWh_e5+a=YV3qT1BEST7w@mail.gmail.com>
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

On Fri, 3 May 2024 at 15:07, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Suppose your program calls select() on a pipe and dmabuf, sees data to be read
> from pipe, reads it, closes both pipe and dmabuf and exits.
>
> Would you expect that dmabuf file would stick around for hell knows how long
> after that?  I would certainly be very surprised by running into that...

Why?

That's the _point_ of refcounts. They make the thing they refcount
stay around until it's no longer referenced.

Now, I agree that dmabuf's are a bit odd in how they use a 'struct
file' *as* their refcount, but hey, it's a specialty use. Unusual
perhaps, but not exactly wrong.

I suspect that if you saw a dmabuf just have its own 'refcount_t' and
stay around until it was done, you wouldn't bat an eye at it, and it's
really just the "it uses a struct file for counting" that you are
reacting to.

                Linus

