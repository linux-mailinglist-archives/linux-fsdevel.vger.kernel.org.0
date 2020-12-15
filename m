Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B7F2DB68D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 23:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgLOWcz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 17:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbgLOWcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:32:47 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A38BC061793
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 14:32:07 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id m12so43523880lfo.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 14:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxztLd5LpgiQ3jjGwG9LaRkZFME3aZ+kypvHrh4LNDg=;
        b=AMbpPnRobT9T0nwyVIRGcKBuXRdrOKn3LWIRf7Ui4LdWYIE7HngVOQOd8U1LpMwIxj
         scqU/qZQPi0UZXWmNs17FJy5nMwNj6mKcsAOdA14a0SsTVINyC/OjxPKHqzmMes2guzZ
         34gdFEtMDUnJPU+5GnSUNB3c9A2V7+N4R/Rxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxztLd5LpgiQ3jjGwG9LaRkZFME3aZ+kypvHrh4LNDg=;
        b=oqP4t2VojWeEA58JqXrTJAZ71UytZUvJuif7VcIQi6e6P3eGj7VNX9wDxwikgq28RV
         608hv8nGgN5+VlYJW5w4HDFsM1QBn29q9y7cNW9utYm0Z4MnvFuzKSJbH5r3OFJfSyWt
         9iBhpeF3K+xeBhggD8gybTfWYpHemIctV8l3FFBKKSCZ/4HNia82qrViTJwWiawOGgv3
         qalsmqILoR4IdKZAv+GQLfhZ6KVxJA2gvt9lqwUYXuQuCJefpMDk8Caf1OmkSIikXngL
         /HPBnqnwHUO0HxMaP48USqWxJZQXsK/q8/Kz46Oz503J2/T9KKiAkTzuZCeQcITjxitL
         wBNA==
X-Gm-Message-State: AOAM533sIsoSBGPx48vTCRFshGmyqyeX8iLJN9MJXXWm4eT5za1pUKaz
        j/zqw4EmAAhlSpTJnFCXitgswUZF77pxRA==
X-Google-Smtp-Source: ABdhPJwt1B7ZQK3C4K9Mpy2hCT5aMVTRUyYACMzv79bvBPW9c6tUymaEQ6MIAsFBQidqcEuKp7MkJQ==
X-Received: by 2002:a19:cbd4:: with SMTP id b203mr12183978lfg.506.1608071525275;
        Tue, 15 Dec 2020 14:32:05 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id f26sm411ljg.137.2020.12.15.14.32.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 14:32:04 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id l11so43531428lfg.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 14:32:04 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr13312962ljm.507.1608071523819;
 Tue, 15 Dec 2020 14:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20201214191323.173773-1-axboe@kernel.dk> <20201214191323.173773-4-axboe@kernel.dk>
 <20201215222522.GS3913616@dread.disaster.area>
In-Reply-To: <20201215222522.GS3913616@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 14:31:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=whAhRQaFUn7dhDAgoofVRA2EJvbmiKAYFA0ciwPQjnGwg@mail.gmail.com>
Message-ID: <CAHk-=whAhRQaFUn7dhDAgoofVRA2EJvbmiKAYFA0ciwPQjnGwg@mail.gmail.com>
Subject: Re: [PATCH 3/4] fs: expose LOOKUP_NONBLOCK through openat2() RESOLVE_NONBLOCK
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 2:25 PM Dave Chinner <david@fromorbit.com> wrote:
>
> What text are you going to add to the man page to describe how this
> flag behaves to developers?

I think it was you or Jens who suggested renaming it to RESOLVE_CACHED
(and LOOKUP_CACHED), and I think that would be a good idea.

Make it explicit that this isn't primarily about avoiding blocking,
but about only doing name lookups that can be resolved directly from
the dcache.

Even in some other contexts, the traditional NONBLOCK naming isn't
necessarily about not blocking. Lots of operations tend to block even
for things that are requested to be "nonblocking", and in fact they
can even cause IO (ie a "nonblocking" read can and will cause IO when
it copies to user space, because _that_ part isn't nonblocking).

        Linus
