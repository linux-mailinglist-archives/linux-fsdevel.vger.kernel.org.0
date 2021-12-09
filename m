Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2F46F2B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 19:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbhLISGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 13:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbhLISGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:06:02 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608A2C061746
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Dec 2021 10:02:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so22445073eds.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Dec 2021 10:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqdZ3M76IB1SSykmh04Y3Lo84YOdOWQzNWkBQHhiwL0=;
        b=ZavXgalMvPws6B7jvVOJr9iYXFSQ+Ve+xzB/xQ0PKvdxMfmxrHbi4mOAwmtVap5HzF
         i7Nkk2JG3YWK49A5ao1c9B+9rNDuriLhMaU7X6p9gXoihI9+MzBmoDXPoCAxG7AMsjTc
         uY8XYPep0J+jvwo4NJwVAzrXtoSQ3VliSEvk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqdZ3M76IB1SSykmh04Y3Lo84YOdOWQzNWkBQHhiwL0=;
        b=RSM3/ae7aa1EeBSk8MDmt6poL7IWa5FcdvE8KbrD7HD/bsOKJzhpuoAa3sB1eRLTdu
         ienT1ExtHzalgQiRJfocwGlNBwC4aP3LOqoPdZVZmRq7Yjbbpws+r7hUvabrnVKbaMdV
         nTXonolImiBr63jpZAXhKbbs4bZGcZ+CRTmZyu2EoPM5O4WJenarxIV1AEmjViGiUQAl
         VZWSBjzuqdXDSt1hpVJipLYYgK9q6d08zNStcaS8HjQPtVVSu6qo2EXZeAFXSQ1Iuvei
         uG6gQ6BsBn0/+5aUmFaig2pvC5yDuivlAD25CXl6GtFl2lpAy5CkaHZhMM5gDSa2cvrZ
         Eymg==
X-Gm-Message-State: AOAM531oD2Okrysh/mtvLPCRCVLilHgDE/BlWoQGvxzyYK2kdyxKj7+C
        yv6yHxiddCyU7nrnp8t5Gj6ym42fuBc2cokWWuY=
X-Google-Smtp-Source: ABdhPJy9bOqRGGbRqIobCKOUs0abIYkq6vi3SsL3q/gcWyrPxeZL8jg/CsT0mshf50iiCvW9QvjuPw==
X-Received: by 2002:a50:eb85:: with SMTP id y5mr31678455edr.173.1639072868384;
        Thu, 09 Dec 2021 10:01:08 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id y15sm247199edr.35.2021.12.09.10.01.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 10:01:07 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id i12so4874521wmq.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Dec 2021 10:01:06 -0800 (PST)
X-Received: by 2002:a1c:800e:: with SMTP id b14mr9304451wmd.155.1639072866516;
 Thu, 09 Dec 2021 10:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20211209010455.42744-1-ebiggers@kernel.org>
In-Reply-To: <20211209010455.42744-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 10:00:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkXez+ugCbF3YpODQQS-g=-4poCwXaisLW4p2ZN_=hxw@mail.gmail.com>
Message-ID: <CAHk-=wjkXez+ugCbF3YpODQQS-g=-4poCwXaisLW4p2ZN_=hxw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] aio: fix use-after-free and missing wakeups
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 8, 2021 at 5:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Careful review is appreciated; the aio poll code is very hard to work
> with, and it doesn't appear to have many tests.  I've verified that it
> passes the libaio test suite, which provides some coverage of poll.
>
> Note, it looks like io_uring has the same bugs as aio poll.  I haven't
> tried to fix io_uring.

I'm hoping Jens is looking at the io_ring case, but I'm also assuming
that I'll just get a pull request for this at some point.

It looks sane to me - my only internal cursing has been about epoll
and aio in general, not about these patches in particular.

              Linus
