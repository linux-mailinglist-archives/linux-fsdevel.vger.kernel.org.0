Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5129A3C25D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 06:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390955AbfFKEjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 00:39:20 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:33283 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388260AbfFKEjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:39:20 -0400
Received: by mail-lf1-f48.google.com with SMTP id y17so8223573lfe.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2019 21:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SMEwJWMeHtEyw0+L1caTDzGbNv810UPp3Lqsx3PUF8=;
        b=QoOOR0HYKqsx3JsW6Ew+a3guMYkQ2W/iAmuqxvOFKc2gBdgPpiDUc6GDNZv08ve+UL
         EI1jVlrxftmcd8GkeJ0oFp4Q1bcxwTC2j3DRi7CGlH9xQA0pIgDG9f/n8XTk+FnhBPSf
         5EUYmUYvqmN9yKTc9mv8oUSfj0cMJfJ9bKh/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SMEwJWMeHtEyw0+L1caTDzGbNv810UPp3Lqsx3PUF8=;
        b=t0B7/ykbXLQ2PFPLSWjREWijqvatDbFMA+h+QRx+lFukYZuzHuRcEvZ9saf7ZmivSk
         C7XV0NeUdDQwv3hTEvO94D+Z2RIhC5oyju0IDTaQN+Ka3XaT8Wl0ExkQtxUE69A25JcL
         IpgRNUna58tIZK7/6blLUmep8+zGyMKo1RZtR3UMWWIxtieJ4nTuz+4/EaAwvMQ8dMr2
         60d1n0Gpc3QKNUcefvHyIwaLkoOKwXGNktOceVguWRTNEa1aOGIxr8zfuaexoN174KeA
         eHewYGmkveTQ6iu9uK7WVAwFOLiOUEAbkk6mM/dB+wV/Oz7UzuHrri/7UToG9FB+cp5D
         pusQ==
X-Gm-Message-State: APjAAAUpFZmKXMVqDvflFSNcnkA98ugaKnV04nBeKlcQ50H5Uj+tPQCZ
        2tmLINLUn2sIZDJmBgDyokUJ49YmCRA=
X-Google-Smtp-Source: APXvYqzDR2zalV3y2GHqTe/aQ9yno9hCx3LOR52ecNPIwljPzlgBP1kFJFMxr5BlEH8gf8rhw142Og==
X-Received: by 2002:ac2:4358:: with SMTP id o24mr35662031lfl.13.1560227958244;
        Mon, 10 Jun 2019 21:39:18 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d4sm2322187lfi.91.2019.06.10.21.39.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 21:39:17 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id i21so10140266ljj.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2019 21:39:16 -0700 (PDT)
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr4973161ljs.44.1560227956599;
 Mon, 10 Jun 2019 21:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com> <20190611041045.GA14363@dread.disaster.area>
In-Reply-To: <20190611041045.GA14363@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jun 2019 18:39:00 -1000
X-Gmail-Original-Message-ID: <CAHk-=whDmeozRHUO0qM+2OeGw+=dkcjwGdsvms-x5Dz4y7Tzcw@mail.gmail.com>
Message-ID: <CAHk-=whDmeozRHUO0qM+2OeGw+=dkcjwGdsvms-x5Dz4y7Tzcw@mail.gmail.com>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 6:11 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Please, no, let's not make the rwsems even more fragile than they
> already are. I'm tired of the ongoing XFS customer escalations that
> end up being root caused to yet another rwsem memory barrier bug.
>
> > Have you talked to Waiman Long about that?
>
> Unfortunately, Waiman has been unable to find/debug multiple rwsem
> exclusion violations we've seen in XFS bug reports over the past 2-3
> years.

Inside xfs you can do whatever you want.

But in generic code, no, we're not saying "we don't trust the generic
locking, so we cook our own random locking".

If tghere really are exclusion issues, they should be fairly easy to
try to find with a generic test-suite. Have a bunch of readers that
assert that some shared variable has a particular value, and a bund of
writers that then modify the value and set it back. Add some random
timing and "yield" to them all, and show that the serialization is
wrong.

Some kind of "XFS load Y shows problems" is undebuggable, and not
necessarily due to locking.

Because if the locking issues are real (and we did fix one bug
recently in a9e9bcb45b15: "locking/rwsem: Prevent decrement of reader
count before increment") it needs to be fixed. Some kind of "let's do
something else entirely" is simply not acceptable.

                  Linus
