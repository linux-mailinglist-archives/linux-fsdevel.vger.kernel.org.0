Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF475405D65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 21:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbhIITjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 15:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbhIITjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:39:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAE7C061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 12:38:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id s10so5830238lfr.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCQSRehR2ZOFo/zjKqjv0LY16gqxQWCKetw3T+VgWXE=;
        b=AliT6R74tIzwlYSKpVb0jpl+QAkq5TlMBBdZh/VSrASCQJ5jZSDBd+2VKAtFoAun9o
         INXNuZN30cPsf7inYtabYnvsYnM+4N+LDuUwHBxHM3jEk1kzU0ACPdcHWBnoQ8KgEx2y
         DAJ3UQGzsVpIbYzABfU4I7iyeRkKdC3yHuQzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCQSRehR2ZOFo/zjKqjv0LY16gqxQWCKetw3T+VgWXE=;
        b=glMZ9Zd01NVXUkv5AIOrphlUlhEbUGOcBNTk8gg8tUBscTvQCWVAZ6j+lURbwMVe4S
         +gUxQCfzYonMnZW0ks7xsQyif1WF8emrQl33/vrh+e8kTiu7irGbexJGf7fg5xwFDVzQ
         MPjDP3j7Nwmpfm+mEwJ3ODqrpO9lCO7wqz8eUyaWIQZvfxxmyPRZomT/3DuTk1vCceJI
         SyuFtwUA/JueUYtpSx2som53qGs1uvZcv0C3UHFgxcWQK5kMzmu3yqdu9Ws+jlPcX6dI
         bnqTvCqR3NrF4l/HEoqc5uvopD9sVaC0t5chLbJ/miUJEfgGR6qmxlgjRtkMzSfuc4bp
         xiFw==
X-Gm-Message-State: AOAM532uM52bMM9WUvL+6eyPuQp9gGOIyYfyvVBUERMUGEoFMYj0wRms
        QzMlrwm0kUDgzuY/siv/QDpXJjgfk86duJFO4nI=
X-Google-Smtp-Source: ABdhPJxwHbsQV8NheFwBgTuTOzDRx3/Wc9DOizi1lguXGiWuFZyqNQF7aowSobfibgIOdSMVgVqLUA==
X-Received: by 2002:ac2:5510:: with SMTP id j16mr1148715lfk.152.1631216290818;
        Thu, 09 Sep 2021 12:38:10 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q189sm295164ljb.68.2021.09.09.12.38.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 12:38:10 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id t19so5815206lfe.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 12:38:10 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr1059425lfr.173.1631216289838;
 Thu, 09 Sep 2021 12:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
In-Reply-To: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 12:37:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
Message-ID: <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 8, 2021 at 9:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Fixes for io-uring handling of iov_iter reexpands

Ugh.

I have pulled this, because I understand what it does and I agree it
fixes a bug, but it really feels very very hacky and wrong to me.

It really smells like io-uring is doing a "iov_iter_revert()" using a
number that it pulls incorrectly out of its arse.

So when io-uring does that

                iov_iter_revert(iter, io_size - iov_iter_count(iter));

what it *really* wants to do is just basically "iov_iter_reset(iter)".

And that's basically what that addition of that "iov_iter_reexpand()"
tries to effectively do.

Wouldn't it be better to have a function that does exactly that?

Alternatively (and I'm cc'ing Jens) is is not possible for the
io-uring code to know how many bytes it *actually* used, rather than
saying that "ok, the iter originally had X bytes, now it has Y bytes,
so it must have used X-Y bytes" which was actively wrong for the case
where something ended up truncating the IO for some reason.

Because I note that io-uring does that

        /* may have left rw->iter inconsistent on -EIOCBQUEUED */
        iov_iter_revert(&rw->iter, req->result - iov_iter_count(&rw->iter));

in io_resubmit_prep() too, and that you guys missed that it's the
exact same issue, and needs that exact same iov_iter_reexpand().

That "req->result" is once again the *original* length, and the above
code once again mis-handles the case of "oh, the iov got truncated
because of some IO limit".

So I've pulled this, but I think it is

 (a) ugly nasty

 (b) incomplete and misses a case

and needs more thought. At the VERY least it needs that
iov_iter_reexpand() in io_resubmit_prep() too, I think.

I'd like the comments expanded too. In particular that

                /* some cases will consume bytes even on error returns */

really should expand on the "some cases" thing, and why such an error
isn't fatal buye should be retried asynchronously blindly like this?

Because I think _that_ is part of the fundamental issue here - the
io_uring code tries to just blindly re-submit the whole thing, and it
does it very badly and actually incorrectly.

Or am I missing something?

           Linus
