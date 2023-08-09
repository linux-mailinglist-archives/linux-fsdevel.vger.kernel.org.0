Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA38775054
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 03:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHIB1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 21:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjHIB1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:27:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7101986
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 18:27:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so856209a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 18:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691544468; x=1692149268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O6VpqXFhriUJuQ+K1KbAMi5ftxncBbuJpQzUZ//b884=;
        b=NhOseeA4SwuASXokYQLUhbrXsQ28snOmBb7IDfD0PPAsBKbjSgtP+BmsrakOR0HrXT
         i1j/idi9ZPn28d/JgGk+8/9QyGFjCiyh0P+uwAJeO/1ohJWfK2aj37VtZ1zoy2LeACHa
         Hd5OrZM+7U2adtuZJ3oL7xF2jSId/4Ue8jZgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691544468; x=1692149268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6VpqXFhriUJuQ+K1KbAMi5ftxncBbuJpQzUZ//b884=;
        b=eY2eDtWAmcElgwqeVu8p5IZhs/3o00Tr38IaH4hrCVQi1hPveXZS6+4JCKgFAXmnmz
         GnZM7aDGC4wTcuo8s20f4w0J7mI/1Knd+jWPnXdjIagI5CANl4mWpPrGhcuRZ5c3JTiK
         VIyBhQa5pvU9DwNKwAk0VAVlqv1jDRXMdGpTdoqk1ayz/k6NJ6ZFMGia9Uzfx8jdHHR8
         mX8EOcMXTx+QzR1cAGUtgV6p92T/jx6KM983eApcXMtjQSN9nqhQcBVFvfq/jBjP2qO0
         Sg4l/IMCOCO4qk/nx7ncFEXLJ0chgbyKCBKpNovBmOJKA2zL/CoJL78G4wyIiI0qbRis
         sPTg==
X-Gm-Message-State: AOJu0YwpUAP/009TYTkgKmqInhJJwzl0xdNmKAVogkPSLH7YuNRr5sk5
        WMhDMam7ZpwbQ5HhxxvHmT22ctPHzwT4NTbbxfsKFjJY
X-Google-Smtp-Source: AGHT+IE41Ftc5ziWaMfpUvMzGpXiZxpvfL1MFOV03BRRgJM4CnXAgXdVQIq0YhkCL8ll5JUd+sOzKw==
X-Received: by 2002:a05:6402:26cc:b0:523:463d:1ed3 with SMTP id x12-20020a05640226cc00b00523463d1ed3mr4516248edd.15.1691544468511;
        Tue, 08 Aug 2023 18:27:48 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id t5-20020a05640203c500b0052334659c50sm4306525edw.63.2023.08.08.18.27.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 18:27:46 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-99bdf08860dso88866666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 18:27:46 -0700 (PDT)
X-Received: by 2002:a17:907:168a:b0:99b:f42d:b3f6 with SMTP id
 hc10-20020a170907168a00b0099bf42db3f6mr14125951ejc.32.1691544466349; Tue, 08
 Aug 2023 18:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan> <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
In-Reply-To: <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 18:27:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
Message-ID: <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ *Finally* getting back to this, I wanted to start reviewing the
changes immediately after the merge window, but something else always
kept coming up .. ]

On Tue, 11 Jul 2023 at 19:55, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> So: looks like we missed the merge window. Boo :)

Well, looking at the latest 'bcachefs-for-upstream' state I see, I'm
happy to see the pre-requisites outside bcachefs being much smaller.

The six locks are now contained within bcachefs, and I like what I see
more now that it doesn't play games with 'u64' and lots of bitfields.

I'm still not actually convinced the locks *work* correctly, but I'm
not seeing huge red flags. I do suspect there are memory ordering
issues in there that would all be hidden on x86, and some of it looks
strange, but not necessarily unfixable.

Example of oddity:

                barrier();
                w->lock_acquired = true;

which really smells like it should be

                smp_store_release(&w->lock_acquired, true);

(and the reader side in six_lock_slowpath() should be a
smp_load_acquire()) because otherwise the preceding __list_del()
writes would seem to possibly by re-ordered by the CPU to past the
lock_acquired write, causing all kinds of problems.

On x86, you'd never see that as an issue, since all writes are
releases, so the 'barrier()' compiler ordering ends up forcing the
right magic.

Some of the other oddity is around the this_cpu ops, but I suspect
that is at least partly then because we don't have acquire/release
versions of the local cpu ops that the code looks like it would want.

I did *not* look at any of the internal bcachefs code itself (apart
from the locking, obviously). I'm not that much of a low-level
filesystem person (outside of the vfs itself), so I just don't care
deeply. I care that it's maintained and that people who *are*
filesystem people are at least not hugely against it.

That said, I do think that the prerequisites should go in first and
independently, and through maintainers.

And there clearly is something very strange going on with superblock
handling and the whole crazy discussion about fput being delayed. It
is what it is, and the patches I saw in this thread to not delay them
were bad.

As to the actual prereqs:

I'm not sure why 'd_mark_tmpfile()' didn't do the d_instantiate() that
everybody seems to want, but it looks fine to me. Maybe just because
Kent wanted the "mark" semantics for the naming. Fine.

The bio stuff should preferably go through Jens, or at least at a
minimum be acked.

The '.faults_disabled_mapping' thing is a bit odd, but I don't hate
it, and I could imagine that other filesystems could possibly use that
approach instead of the current 'pagefault_disable/enable' games and
->nofault games to avoid the whole "use mmap to have the source and
the destination of a write be the same page" thing.

So as things stand now, the stuff outside bcachefs itself I don't find
objectionable.

The stuff _inside_ bcachefs I care about only in the sense that I
really *really* would like a locking person to look at the six locks,
but at the same time as long as it's purely internal to bcachefs and
doesn't possibly affect anything else, I'm not *too* worried about
what I see.

The thing that actually bothers me most about this all is the personal
arguments I saw.  That I don't know what to do about. I don't actually
want to merge this over the objections of Christian, now that we have
a responsible vfs maintainer.

So those kinds of arguments do kind of have to be resolved, even aside
from the "I think the prerequisites should go in separately or at
least be clearly acked" issues.

Sorry for the delay, I really did want to get these comments out
directly after the merge window closed, but this just ended up always
being the "next thing"..

                  Linus
