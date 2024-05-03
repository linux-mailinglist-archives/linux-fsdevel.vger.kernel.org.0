Return-Path: <linux-fsdevel+bounces-18682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1878BB5AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DC7B23ED0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 21:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7A884D3F;
	Fri,  3 May 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ft2VMkuz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599F5A4C0
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771507; cv=none; b=Qq9fGswA2Lw8wEiqAYACvpZy++xZODB719ur2dxGGYesQdN0evMJHO6UO2fGJnxVI/rO/gopOSOnvA04PgZXIuJ8scIRa2ysyBRSeUBcqOWe+vk2PDPKUoA+/geYlA5UALO/mSK+HijK+7xLN5Ieycc7e0p/jf+yUQSuLc1UHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771507; c=relaxed/simple;
	bh=N4MV6W6kLCjF7hioiCGBWf5TZPj+wehXzH5NmRppkU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/JMlZvekX8d/D57U+jKkFFLOUcTwRHZtVK/cl38dfSRe6RMJJT7D9/i20Ty+I2EDWZ4891iJ4P5NeIBej/IidbwSvtB8kdlu9DnCIPzCG8HpKr9m2l2XcOSK89iUYCQpBhzMT3OMqrBqSCRqS4d0DlCxogDmuIvPC6wM4e3PvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ft2VMkuz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f300b318cso79022e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714771504; x=1715376304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fhxz4aHpmXZJ6K0C5hNTESMtOJDx3oTLGnKkbndye9Q=;
        b=ft2VMkuz+l7vHGHn5A9ijcLbpznRqGHogQhm0BybeprsfPPT4cJ2+FJo+mQyi3iWdh
         tbMhs0d7vkf0pNMC+oYWALBHIM/O7LqRTUvlhEVc3lKrrHE0fYuUEmrUM+0Oq57HqwEw
         eNVCy91hpg8JX4bBokZdO3f3cmT3v6+c90Xag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771504; x=1715376304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhxz4aHpmXZJ6K0C5hNTESMtOJDx3oTLGnKkbndye9Q=;
        b=ozGoEpvxjjgA+MHhMQrad3RrY8cY5mvJae7poHTkmVrf/lzu/F6J5XaKuhB+v/1Ynr
         6UbgXqrgXNIOLznhONLtl/qTOD4getXIymsTkVPftLt7wqYSXPeE/OFTlEYTKQQegVpX
         ekHS6NeM6OaQCXsFMzhL7bB1rqrSfF2zi91BXMUzWn4MUtGAX/xaCkOxJONMnPl7RDp4
         b/+1Nol52tSdJ7hDhEkJHf1yHTAammew/nRnzdsV/N2CzHtXVAPCGneAelMO57cLSDVw
         XnW9IkiN7dmhNbqAwxmqE8A7N/r2/r2C+g2ON6MKWmHadVXj1LFd07v/gPpEA4azJGly
         wJLw==
X-Forwarded-Encrypted: i=1; AJvYcCUWr6Bd9a7ppvGh9F65k5wrLH8feXdF1eL95o4Bz09wklw4t/880PcpWubT+Ub0yOH5doW7RIp5AtUcAvNtP1EOrO3fZNM7NMas8YYjJQ==
X-Gm-Message-State: AOJu0YzNgrWKajPJmXp6i1jHn8ptzt/hfwTnFZ4JVRcHsWk0DOzPUSfY
	jpQLgf10z4T06wklo1MD1R5DqcGeBPHX0u+DO+YhzOJ/gOF3t8neqCoT7E8lI1uEEf7ydNE2+ES
	HJt+8KA==
X-Google-Smtp-Source: AGHT+IEuSD9hME5WALS6f4mU0NWS60HF6nPtrB82RZmUt5ufpn3a+kPjN1gFjGxlMnzLXqhb8mNdwA==
X-Received: by 2002:ac2:4214:0:b0:51e:4729:79cf with SMTP id y20-20020ac24214000000b0051e472979cfmr2479792lfh.58.1714771504154;
        Fri, 03 May 2024 14:25:04 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id g10-20020a19ac0a000000b0051ef206d0c7sm652985lfc.269.2024.05.03.14.25.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:25:02 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5171a529224so120849e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 14:25:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUu18cIca+4AyJha4G8ZQ8aIxWt6AGDa2xC1MP/Z7CI1jgY2QmBNlOciCNQM1nC+l6LXaOenoq8OOsZ/ubJl0C0lB2RPRYFqNTlmfxzPQ==
X-Received: by 2002:a19:381a:0:b0:51c:68a3:6f8e with SMTP id
 f26-20020a19381a000000b0051c68a36f8emr2449065lfa.31.1714771502428; Fri, 03
 May 2024 14:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002d631f0615918f1e@google.com> <7c41cf3c-2a71-4dbb-8f34-0337890906fc@gmail.com>
 <202405031110.6F47982593@keescook> <64b51cc5-9f5b-4160-83f2-6d62175418a2@kernel.dk>
 <202405031207.9D62DA4973@keescook> <d6285f19-01aa-49c8-8fef-4b5842136215@kernel.dk>
 <202405031237.B6B8379@keescook> <202405031325.B8979870B@keescook> <20240503211109.GX2118490@ZenIV>
In-Reply-To: <20240503211109.GX2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 14:24:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0de-P2Q=Gz2uyrWBHagT25arLbN0Lyg=U6fT7psKnQA@mail.gmail.com>
Message-ID: <CAHk-=wj0de-P2Q=Gz2uyrWBHagT25arLbN0Lyg=U6fT7psKnQA@mail.gmail.com>
Subject: Re: get_file() unsafe under epoll (was Re: [syzbot] [fs?] [io-uring?]
 general protection fault in __ep_remove)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Bui Quang Minh <minhquangbui99@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>, 
	io-uring@vger.kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 14:11, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What we need is
>         * promise that ep_item_poll() won't happen after eventpoll_release_file().
> AFAICS, we do have that.
>         * ->poll() not playing silly buggers.

No. That is not enough at all.

Because even with perfectly normal "->poll()", and even with the
ep_item_poll() happening *before* eventpoll_release_file(), you have
this trivial race:

  ep_item_poll()
     ->poll()

and *between* those two operations, another CPU does "close()", and
that causes eventpoll_release_file() to be called, and now f_count
goes down to zero while ->poll() is running.

So you do need to increment the file count around the ->poll() call, I feel.

Or, alternatively, you'd need to serialize with
eventpoll_release_file(), but that would need to be some sleeping lock
held over the ->poll() call.

> As it is, dma_buf ->poll() is very suspicious regardless of that
> mess - it can grab reference to file for unspecified interval.

I think that's actually much preferable to what epoll does, which is
to keep using files without having reference counts to them (and then
relying on magically not racing with eventpoll_release_file().

                Linus

