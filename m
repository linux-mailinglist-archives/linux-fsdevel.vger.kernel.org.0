Return-Path: <linux-fsdevel+bounces-2912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F5B7EC889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 17:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E59528120E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB82E651;
	Wed, 15 Nov 2023 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SAu7ZZ/A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62B3065F
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 16:28:44 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D559E98
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:28:42 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507ad511315so9993320e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700065721; x=1700670521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jsVx/Q3YhVxHOvs8227jfNskpZuE2YqOrJ9wOZRuNEs=;
        b=SAu7ZZ/AlLN/TSSg/g452fDGlbYSynZ1FJC5N5Evn7gop+Vf5JpnMefH1T8qOsiD0l
         vVG4647qBCRTY2avAp7e7ry6xjjYSsJcFT2vYr8fPnGJ513y/mpoJqxUKJ+azK/OSpBW
         fN1aSL+IEINQz+ioRFO7szjwMz9a4ZvOQmodo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065721; x=1700670521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsVx/Q3YhVxHOvs8227jfNskpZuE2YqOrJ9wOZRuNEs=;
        b=uN2HjXwgZ43C8q+/5nw3UFP+w74OkQMObQtNyIN6M4h5ruJ6ALmLe+6pYVS6fZ529R
         nWwWuf5P3ffPmJZHUXGFkzaFIXXhROAwC3M/Xc0XUnqFrUIMZZI2ro6F+8M4+syBt0ZW
         ace0ZTjAqn7hq1r7FpPTnT0Ttak6kD61OwGtfkG/1S1VeI/D9r9gih5whTjLs16JGgf1
         PIOe+ioJ6Njh++Q1S+Md4U+JgmjWhMxoYl0VzVegIE8NRVd10gNT7EdTMrJK0UAVpj5H
         1t5aWGPUjMF2retv2oxftkjN2xVS+nXP3YHLoCIfNvE/pGoUwIH6cyy1d++XJ1p6FNMn
         d7Ag==
X-Gm-Message-State: AOJu0YzC21nom5NiKn1/YDySTDQF5lOEvNY4YbIEvzGHXA0gI9e1+pCG
	lijRJWJ1fSRH9t3HpCYAxaGBzgVyc6El/qBjVxp9wWeL
X-Google-Smtp-Source: AGHT+IGkJnnDG/ua6+jZfHxiZaBRv+Q9VqGXFg6ZEVM+7zOJ7OJb//p818Y8dKWFGLl7GuBjSYeQWQ==
X-Received: by 2002:a19:9116:0:b0:500:b553:c09e with SMTP id t22-20020a199116000000b00500b553c09emr9489415lfd.32.1700065721061;
        Wed, 15 Nov 2023 08:28:41 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id q27-20020ac2511b000000b00509440d28bbsm1704124lfb.99.2023.11.15.08.28.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:28:40 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso9960884e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:28:40 -0800 (PST)
X-Received: by 2002:a05:6512:12cf:b0:503:3781:ac32 with SMTP id
 p15-20020a05651212cf00b005033781ac32mr12684125lfg.41.1700065720301; Wed, 15
 Nov 2023 08:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-9-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-9-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Nov 2023 11:28:22 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjytv+Gy-Ra0rhLCAW_120BvnzLC63tfkkZVXzGgD3_+w@mail.gmail.com>
Message-ID: <CAHk-=wjytv+Gy-Ra0rhLCAW_120BvnzLC63tfkkZVXzGgD3_+w@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] iov_iter: Add benchmarking kunit tests
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
> Add kunit tests to benchmark 256MiB copies to a KVEC iterator, a BVEC
> iterator, an XARRAY iterator and to a loop that allocates 256-page BVECs
> and fills them in (similar to a maximal bio struct being set up).

I see *zero* advantage of doing this in the kernel as opposed to doing
this benchmarking in user space.

If you cannot see the performance difference due to some user space
interface costs, then the performance difference doesn't matter.

Yes, some of the cases may be harder to trigger than others.
iov_iter_xarray() isn't as common an op as ubuf/iovec/etc, but that
either means that it doesn't matter enough, or that maybe some more
filesystems could be taught to use it for splice or whatever.

Particularly for something like different versions of memcpy(), this
whole benchmarking would want

 (a) profiles

 (b) be run on many different machines

 (c) be run repeatedly to get some idea of variance

and all of those only get *harder* to do with Kunit tests. In user
space? Just run the damn binary (ok, to get profiles you then have to
make sure you have the proper permission setup to get the kernel
profiles too, but a

   echo 1 > /proc/sys/kernel/perf_event_paranoid

as root will do that for you without you having to then do the actual
profiling run as root)

                Linus

