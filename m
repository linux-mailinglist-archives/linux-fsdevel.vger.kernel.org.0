Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983ED7A9DE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjIUTvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjIUTvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:51:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB884497
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5315b70c50dso1569313a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695324511; x=1695929311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gQeBC3WD5Q9pOBgHLJnTig2EHFJlKZ+82vyKLhOZTtc=;
        b=CZw6d2a559GAkYPmFSKPqKRuUbDsdQjBvC5kXov7uLpUQMCUuF1riF/5mxFfK+LhqG
         Mk3dz4JTULxZwkkm6fO8UTfI61WQRZ3oSELzgLxOt4FT1lF8ieZ8A/ODyS8oatOdMBCd
         HyyX0/yLwl3MKI4tBeGqPfuP/XmhLcMaA2tAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324511; x=1695929311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQeBC3WD5Q9pOBgHLJnTig2EHFJlKZ+82vyKLhOZTtc=;
        b=aGkNcOEFzLHOIXYoMJVGAVK9Qk5qncQ1HxemYQhFSsBXTK7A1PzHuvsWkIhZ6knAvC
         14fIY3JIZWdJ1KB7czt4Me/8lOFqzL4ruvQTPS3fpvrOcKtoOp4PLe2UZExYvCAQ52/y
         CSSCHmoEZRpQqLlpvt1JsXRHAK67M1thuxDkJUmk04D49PIwfpd6M64KzQY/0L3Nnoz9
         mfMUuDsMNi2IwAZtdN6cs9fWHAkVX12jXHihrM412l21HJhxdFG3WsEAK6XIBx+SxPyq
         BS29mISU+Dglemb7ayeSZ2v/1ZqPDHAR1a2SQzwLsmTrVNLVX7gmWNUbIi21xvlsguEF
         XVkw==
X-Gm-Message-State: AOJu0YwH1z/rc78hZ9BvMTxJmsfRLb0RK94Y2XvClOVQolqHzhWjLjr5
        rHh9jDx66KlNmxxTUNIjljfrBfAbuHdCXkeTHdQmTNlM
X-Google-Smtp-Source: AGHT+IGSl+v87YnShuD5ujIT6iAlURuJHPnc2IcSqAv3NKcBQEyuyqBUzXLg8/B2zBCJV/zelA6FmQ==
X-Received: by 2002:aa7:d487:0:b0:522:b112:6254 with SMTP id b7-20020aa7d487000000b00522b1126254mr5819714edr.4.1695324511095;
        Thu, 21 Sep 2023 12:28:31 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id c2-20020aa7c982000000b0053132e5ea61sm1224827edt.30.2023.09.21.12.28.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 12:28:30 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-53087f0e18bso1569403a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:30 -0700 (PDT)
X-Received: by 2002:a50:cb88:0:b0:533:23e2:c48 with SMTP id
 k8-20020a50cb88000000b0053323e20c48mr3881085edi.3.1695324510158; Thu, 21 Sep
 2023 12:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com> <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
In-Reply-To: <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Sep 2023 12:28:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
Message-ID: <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Sept 2023 at 11:51, Jeff Layton <jlayton@kernel.org> wrote:
>
> We have many, many inodes though, and 12 bytes per adds up!

That was my thinking, but honestly, who knows what other alignment
issues might eat up some - or all - of the theoreteical 12 bytes.

It might be, for example, that the inode is already some aligned size,
and that the allocation alignment means that the size wouldn't
*really* shrink at all.

So I just want to make clear that I think the 12 bytes isn't
necessarily there. Maybe you'd get it, maybe it would be hidden by
other things.

My biggest impetus was really that whole abuse of a type that I
already disliked for other reasons.

> I'm on board with the idea, but...that's likely to be as big a patch
> series as the ctime overhaul was. In fact, it'll touch a lot of the same
> code. I can take a stab at that in the near future though.

Yea, it's likely to be fairly big and invasive.  That was one of the
reasons for my suggested "inode_time()" macro hack: using the macro
argument concatenation is really a hack to "gather" the pieces based
on name, and while it's odd and not a very typical kernel model, I
think doing it that way might allow the conversion to be slightly less
painful.

You'd obviously have to have the same kind of thing for assignment.

Without that kind of name-based hack, you'd have to create all these
random helper functions that just do the same thing over and over for
the different times, which seems really annoying.

> Since we're on the subject...another thing that bothers me with all of
> the timestamp handling is that we don't currently try to mitigate "torn
> reads" across the two different words. It seems like you could fetch a
> tv_sec value and then get a tv_nsec value that represents an entirely
> different timestamp if there are stores between them.

Hmm. I think that's an issue that we have always had in theory, and
have ignored because it's simply not problematic in practice, and
fixing it is *hugely* painful.

I suspect we'd have to use some kind of sequence lock for it (to make
reads be cheap), and while it's _possible_ that having the separate
accessor functions for reading/writing those times might help things
out, I suspect the reading/writing happens for the different times (ie
atime/mtime/ctime) together often enough that you might want to have
the locking done at an outer level, and _not_ do it at the accessor
level.

So I suspect this is a completely separate issue (ie even an accessor
doesn't make the "hugely painful" go away). And probably not worth
worrying about *unless* somebody decides that they really really care
about the race.

That said, one thing that *could* help is if people decide that the
right format for inode times is to just have one 64-bit word that has
"sufficient resolution". That's what we did for "kernel time", ie
"ktime_t" is a 64-bit nanosecond count, and by being just a single
value, it avoids not just the horrible padding with 'struct
timespec64', it is also dense _and_ can be accessed as one atomic
value.

Sadly, that "sufficient resolution" couldn't be nanoseconds, because
64-bit nanoseconds isn't enough of a spread. It's fine for the kernel
time, because 2**63 nanoseconds is 292 years, so it moved the "year
2038" problem to "year 2262".

And that's ok when we're talking about times that are kernel running
times and we haev a couple of centuries to say "ok, we'll need to make
it be a bigger type", but when you save the values to disk, things are
different. I suspect filesystem people are *not* willing to deal with
a "year 2262" issue.

But if we were to say that "a tenth of microsecond resolution is
sufficient for inode timestamps", then suddenly 64 bits is *enormous*.
So we could do a

    // tenth of a microseconds since Jan 1, 1970
    typedef s64 fstime_t;

and have a nice dense timestamp format with reasonable - but not
nanosecond - accuracy. Now that 292 year range has become 29,247
years, and filesystem people *might* find the "year-31k" problem
acceptable.

I happen to think that "100ns timestamp resolution on files is
sufficient" is a very reasonable statement, but I suspect that we'll
still find lots of people who say "that's completely unacceptable"
both to that resolution, and to the 31k-year problem.

But wouldn't it be nice to have just one single "fstime_t" for file
timestamps, the same way we have "ktime_t" for CPU timestamps?

Then we'd save even more space in the 'struct inode'....

                  Linus
