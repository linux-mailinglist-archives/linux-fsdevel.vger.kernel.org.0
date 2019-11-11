Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6430F7A74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 19:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfKKSFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 13:05:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43063 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKSFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:05:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id q5so4569201lfo.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 10:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvHuArWQZSt4FAfTL9KeJpBsocvaDQs9zK3jRy53Tcc=;
        b=ag0ij2l3tpP9oh4bJbAnRGep+63OugvYZJhjMCwlauwgfrGQ7pqUmJvv8qj0uakSts
         ZDSkRSJFWChbxsuYWUpcogXRNaLW+mnwqdTCozn5LsyQqxp2G8J+ESzbHFLEaLpk8fc1
         Wny6vPFLNuEJ1jLedmt1cN279S4odF0GC9reA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvHuArWQZSt4FAfTL9KeJpBsocvaDQs9zK3jRy53Tcc=;
        b=FlIjXjPUl55Muq4XKwX1swD207kU7/d+YUqBtrDJ3riuQBZ+F2506Y/eIOtwgynOWr
         /WZFPK5aAO4Pt6xUcBzhrz0Owu9IMEOXF5NKdRZHYJcfgh7/1S3R9WgrXbC+j2AV0HJ1
         PNvY6nFMt4Wf0QRQrvb4e50HUwvnaByYCA9fE8BG+yuvJ4U7T18te+A7qa+7DCRPlv10
         ibPy0OhNVFzbd7UuFfamk+XF2WH+MUvBb8bGRlcppyYGusdS1WqgHXtBIXj66unn8OFs
         OX7yoHoS8DbepBfvjNTLbpjLSsDgvM1xgPIybXEvP84jii83NP31fa96OmshRYB18hBE
         x04A==
X-Gm-Message-State: APjAAAV8TrBrLf85LpGEyH+OBvU3tORqSVfMMwR1aBsgX1U4rdcsbK+Q
        avoSL1tzQEkt9BsMhRoyhL28Z1xrUz4=
X-Google-Smtp-Source: APXvYqw3FzfS5dv+qlk2SIig/a5F0Frx0mdPxH2VUu0ADwega0KDxJYmpzU2pX2DgFKDScaIbgaFrw==
X-Received: by 2002:ac2:46d7:: with SMTP id p23mr16194278lfo.104.1573495514487;
        Mon, 11 Nov 2019 10:05:14 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id p14sm7216505ljc.8.2019.11.11.10.05.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 10:05:11 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id j14so10583661lfb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 10:05:11 -0800 (PST)
X-Received: by 2002:ac2:498a:: with SMTP id f10mr4549583lfl.170.1573495511138;
 Mon, 11 Nov 2019 10:05:11 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com> <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
In-Reply-To: <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 10:04:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
Message-ID: <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 9:52 AM Eric Dumazet <edumazet@google.com> wrote:
>
> Now I wonder what to do with the ~400 KCSAN reports sitting in
> pre-moderation queue.

So regular KASAN reports are fairly easy to deal with: they report
actual bugs. They may be hard to hit, but generally there's no
question about something like a use-after-free or whatever.

The problem with KCSAN is that it's not clear how many of the reports
have been actual real honest-to-goodness bugs that could cause
problems, and how many of them are "this isn't actually a bug, but an
annotation will shut up KCSAN".

My gut feeling would be that it would be best to ignore the ones that
are "an annotation will shut up KCSAN", and look at the ones that are
real bugs.

Is there a pattern to those real bugs? Is there perhaps a way to make
KCSAN notice _that_ pattern in particular, and suppress the ones that
are "we can shut these up with annotations that don't really change
the code"?

I think it would be much better for the kernel - and much better for
KCSAN - if the problem reports KCSAN reports are real problems that
can actually be triggered as problems, and that it behaves much more
like KASAN in that respect.

Yes, yes, then once the *real* problems have been handled, maybe we
can expand the search to be "stylistic issues" and "in theory, this
could cause problems with a compiler that did X" issues.

But I think the "just annotate" thing makes people more likely to
dismiss KCSAN issues, and I don't think it's healthy.

                Linus
