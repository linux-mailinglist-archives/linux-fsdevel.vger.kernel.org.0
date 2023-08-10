Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA78A778447
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 01:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjHJXro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 19:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHJXrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:47:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239C7271E
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:47:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-523476e868dso1836298a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691711261; x=1692316061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F1xWybKR18fWfB7DSn1NMqec9tUAwt+hx2Ek1PR4oVQ=;
        b=L0yf5/i2QRjbI+DN9CltyUfw08xBvcJOtmQmOKVrZPdqbSQQGl8OJvF9KtXbpDmHl1
         2wLDpQj33DvVfgDLeb19fJyFXQmo7lui6nP6X/WSsbY2wCZXFeKTLlovS8rQx8tWhTnk
         4yfs/OJ6ZJLleGXhD6Mzha8ywIXJZkeCMfjcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691711261; x=1692316061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1xWybKR18fWfB7DSn1NMqec9tUAwt+hx2Ek1PR4oVQ=;
        b=gbWpMKjHQoC0e8V6XOfUIphjvDRjpQsfHfg6KLOr19n0CFO+KEJUUW0YWNONnx+g5k
         lKVpmWCNIkpcNfgo5IertFQgV+kO83ToKOR4LaH3SUc5SktMor0cRkXKBbD2hxt4UKR3
         pXcik1kFc8cSKrpdNxyAQdKfak7gbzEHcynMQxG1c8IPZm3/M+HpRJesFJ/wqMPmBj/r
         XswzM5HkkGkeQi3qgwDhtiCaKgphPag7h0pKvNJRojayVBhIPcsCB66UkWtoITFHZvQk
         kcdij6piYh8qr9zGqds9btX19uPs0caEbEpMIpHQ64Qpn7yv4uKnT/OV5PyIjNQHc7tG
         9bKA==
X-Gm-Message-State: AOJu0YwO0f5O1e3nObIGp/23OAT3y/Z6BIKgko8Qt8mtKVqc6IQdxK8s
        aEHUhInZXP1fSGDZwp1YRnCWHM3rm71K7OjHqr6GaL3r
X-Google-Smtp-Source: AGHT+IEzh80BYUoyHEmT39xLtGp6rV7r+DCYCgQl0Cu/8eijbfmYoNOR5ILj0GbCI2lxmb6I2Nh3Jg==
X-Received: by 2002:a17:906:30c3:b0:99b:22dd:f83d with SMTP id b3-20020a17090630c300b0099b22ddf83dmr347571ejb.55.1691711261510;
        Thu, 10 Aug 2023 16:47:41 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709066b8700b009737b8d47b6sm1508909ejr.203.2023.08.10.16.47.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 16:47:40 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-523c7b55d82so214127a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:47:39 -0700 (PDT)
X-Received: by 2002:a50:fa87:0:b0:523:6bcd:9451 with SMTP id
 w7-20020a50fa87000000b005236bcd9451mr398376edr.13.1691711259520; Thu, 10 Aug
 2023 16:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan> <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan> <20230810223942.GG11336@frogsfrogsfrogs>
In-Reply-To: <20230810223942.GG11336@frogsfrogsfrogs>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 16:47:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8RuUosugVZk+iqCAq7x6rs=7C-9sUXcO2heu4dCuOVw@mail.gmail.com>
Message-ID: <CAHk-=wj8RuUosugVZk+iqCAq7x6rs=7C-9sUXcO2heu4dCuOVw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, dchinner@redhat.com,
        sandeen@redhat.com, willy@infradead.org, josef@toxicpanda.com,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Aug 2023 at 15:39, Darrick J. Wong <djwong@kernel.org> wrote:
>
> FWIW I recently fixed all my stupid debian package dependencies so that
> I could actually install liburing again, and rebuilt fstests.  The very
> next morning I noticed a number of new test failures in /exactly/ the
> way that Kent said to expect:
>
> fsstress -d /mnt & <sleep then simulate fs crash>; \
>         umount /mnt; mount /dev/sda /mnt
>
> Here, umount exits before the filesystem is really torn down, and then
> mount fails because it can't get an exclusive lock on the device.

I agree that that obviously sounds like mount is just returning either
too early. Or too eagerly.

But I suspect any delayed fput() issues (whether from aio or io_uring)
are then just a way to trigger the problem, not the fundamental cause.

Because even if the fput() is delayed, the mntput() part of that
delayed __fput action is the one that *should* have kept the
filesystem mounted until it is no longer busy.

And more importantly, having some of the common paths synchronize
*their* fput() calls only affects those paths.

It doesn't affect the fundamental issue that the last fput() can
happen in odd contexts when the file descriptor was used for something
a bit stranger.

So I do feel like the fput patch I saw looked more like a "hide the
problem" than a real fix.

Put another way: I would not be surprised in the *least* if then
adding more synchronization to fput would basically hide any issue,
particularly from tests that then use those things that you added
synchronization for.

But it really smells like it's purely hiding the symptom to me.

If I were a betting man, I'd look at ->mnt_count.  I'm not saying
that's the problem, but the mnt refcount handling is more than a bit
scary.

It is so hugely performance-critical (ie every single path access)
that we use those percpu counters for it, and I'm not at all sure it's
all race-free.

Just as an example, mnt_add_count() has this comment above it:

 * vfsmount lock must be held for read

but afaik the main way it gets called is through mntget(), and I see
no vfsmount lock held anywhere there (think "path_get() and friends).
Maybe I'm missing something obvious.

So I think that comment is some historical left-over that hasn't been
true for ages.

And all of the counter updates should be consistent even in the
absence of said lock, so it's not an issue.

Except when it is: it does look like it *would* screw up
mnt_get_count() that tries to add up all those percput counters with

        for_each_possible_cpu(cpu) {
                count += per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_count;
        }

and that one has that

 * vfsmount lock must be held for write

comment, which makes sense as a "that would indeed synchronize if
others held it for read". But...

And where is that sum used? Very much in things like may_umount_tree().

Anyway, I'm absolutely not saying this is the actual problem - we
probably at least partly just have stale or incomplete comments, and
maybe I think the fput() side is good mainly because I'm *much* more
familiar with that side than I am with the actual mount code these
days.

So I might be barking up entirely the wrong tree.

But I do feel like the fput patch I saw looked more like a "hide the
problem" than a real fix. Because the mount counting *should* be
entirely independent of when exactly a fput happens.

So I believe having the test-case then do some common fput's
synchronously pretty much by definition can't fix any issues, but it
*can* make sure that any normal test using just regular system calls
then never triggers the "oh, in other situations the last fput will be
delayed".

So that's why I'm very leery of the fput patch I saw. I don't think it
makes sense.

That does *not* mean that I don't believe that umount can have serious problems.

I suspect we get very little coverage of that in normal situations.

And yes, obviously io_uring does add *way* more asynchronicity, and
I'd not be surprised at all if it uncovers problems.

In most other situations, the main source of file counts are purely
open/close system calls, which are in many ways "simple" (and where
things like process exit obviously does the closing part).

                Linus
