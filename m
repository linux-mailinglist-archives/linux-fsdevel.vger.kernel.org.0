Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFE0777E7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 18:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjHJQky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 12:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjHJQka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:40:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B73B90
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 09:40:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bccc9ec02so161598666b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691685628; x=1692290428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2VFl6oEBSVVW1GcX9JfYK1W8MqF2qqEU7n/dRYGTKOo=;
        b=gMJ7SFIBH29U7qQ/1kaMGp1FCIAkFP42YIi4w1X8HySaHrTKTFnWRri6Ygvp0THEkF
         AdtqS94XCMiBQdT5hGJhx+3z1OxXwSlLv0nIe73LpwiWCIiGWg8HSFa//kOoONn97dR5
         an1glS2+24IS7DmIadneY6Bu5YfuUgh59TPwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685628; x=1692290428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VFl6oEBSVVW1GcX9JfYK1W8MqF2qqEU7n/dRYGTKOo=;
        b=kGfydNceKHZmmup7hp8J6EDHGKZRa1DqcYqr8ua0pLMvw/7r1wN84oSgaPKpt7fl5/
         4lctw2B8JbYyCni+a4rFDLcOw5FCUR+hZgp25/ggwAclmuTdjboBDktvFgZK1hilwss3
         RAS4NfveN7fFPoG2fhhn5I5rtZXeKmAxE28tH91u2/dGAwkBvKlkKzGe8vVEhy9tiUBJ
         F8Dbcm9NltQModWqg5wDh+hq7iPDfxRVn5wtnJdYP4Dgj1CZBgEtCLn4kkySWSsA9zgB
         cEAkEnUaefJ7wUyzelFUfBRKXDpFDrTaJwNyhVcDR166z+KFSGWXapiimOkwjCxeEcdg
         4fsw==
X-Gm-Message-State: AOJu0Yzzzv9i8I3LSO1bmly72E5lhb/PYUrFtR8mWMgEYYJHf/OSyg07
        2qBndABRMVXFN9IrJf2K+jo979hcVPtEMY9gATonqQ==
X-Google-Smtp-Source: AGHT+IGoM1YyDsXCK653N2OBNs/3V9mQsIsNr1S6LcLk+TJmIFLktVDc38EdeCAbEIopr94dsKXuIg==
X-Received: by 2002:a17:907:77c4:b0:992:a80e:e5bd with SMTP id kz4-20020a17090777c400b00992a80ee5bdmr2837600ejc.48.1691685627715;
        Thu, 10 Aug 2023 09:40:27 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906640200b0099d0c0bb92bsm1152010ejm.80.2023.08.10.09.40.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 09:40:26 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9936b3d0286so165448666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 09:40:26 -0700 (PDT)
X-Received: by 2002:a17:907:77c4:b0:992:a80e:e5bd with SMTP id
 kz4-20020a17090777c400b00992a80ee5bdmr2837551ejc.48.1691685626083; Thu, 10
 Aug 2023 09:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan> <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com> <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
In-Reply-To: <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 09:40:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wie4U8hwRN+nYRwV4G51qXPJKr0DpjbxO1XSMZnPA_LTw@mail.gmail.com>
Message-ID: <CAHk-=wie4U8hwRN+nYRwV4G51qXPJKr0DpjbxO1XSMZnPA_LTw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
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

On Thu, 10 Aug 2023 at 08:55, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Heh, I liked the bitfields - I prefer that to open coding structs, which
> is a major pet peeve of mine. But the text size went down a lot a lot
> without them (would like to know why the compiler couldn't constant fold
> all that stuff out, but... not enough to bother).

Bitfields are actually absolutely *horrioble* for many many reasons.
The bit ordering being undefined is just one of them.

Yes, they are convenient syntax, but the downsides of them means that
you should basically only use them for code that has absolutely zero
subtle issues.

Avoid them like the plague with any kind of "data transfer issues", so
in the kernel avoid using them for user interfaces unless you are
willing to deal with the duplication and horror of
__LITTLE_ENDIAN_BITFIELD etc.

Also avoid them if there is any chance of "raw format" issues: either
saving binary data formats, or - as in your original code - using
unions.

As I pointed out your code was actively buggy, because you thought it
was little-endian. That's not even true on little-endian machines (ie
POWERPC is big-endian in bitfields, even when being little-endian in
bytes!).

Finally, as you found out, it also easily generates horrid code. It's
just _harder_ for compilers to do the right thing, particularly when
it's not obvious that other parts of the structure may be "don't care"
because they got initialized earlier (or will be initialized later).
Together with threading requirements, compilers might do a bad job
either because of the complexity, or simply because of subtle
consistency rules.

End result: by all means use bitfields for the *simple* cases where
they are used purely for internal C code with no form of external
exposure, but be aware that even then the syntax convenience easily
comes at a cost.

> > On x86, you'd never see that as an issue, since all writes are
> > releases, so the 'barrier()' compiler ordering ends up forcing the
> > right magic.
>
> Yep, agreed.

But you should realize that on other architectures, I think that
"barrier() + plain write" is actively buggy. On x86 it's safe, but on
arm (and in fact pretty much anything but s390), the barrier() does
nothing in SMP. Yes, it constrains the compiler, but the earlier
writes to remove the entry from the list may happen *later* as far as
other CPUs are concerned.

Which can be a huge problem if the "struct six_lock_waiter" is on the
stack - which I assume it is - and the waiter is just spinning on
w->lock_acquired. The data structure may be re-used as regular stack
space by the time the list removal code happens.

Debugging things like that is a nightmare. And you'll never see it on
x86, and it doesn't look possible when looking at the code, and the
oopses on other architectures will be completely random stack
corruption some time after it got the lock.

So this is kind of why I worry about locking. It's really easy to
write code that works 99.9% of the time, but then breaks when you are
unlucky. And depending on the pattern, the "when you are unlucky" may
or may not be possible on x86. It's not like x86 has total memory
ordering either, it's just stronger than most.

> > Some of the other oddity is around the this_cpu ops, but I suspect
> > that is at least partly then because we don't have acquire/release
> > versions of the local cpu ops that the code looks like it would want.
>
> You mean using full barriers where acquire/release would be sufficient?

Yes.

That code looks like it should work, but be hugely less efficient than
it might be. "smp_mb()" tends to be expensive everywhere, even x86.

Of course, I might be missing some other cases. That percpu reader
queue worries me a bit just because it ends up generating ordering
based on two different things - the lock word _and_ the percpu word.

And I get very nervous if the final "this gets the lock" isn't some
obvious "try_cmpxchg_acquire()" or similar, just because we've
historically had *so* many very subtle bugs in just about every single
lock we've ever had.

> Matthew was planning on sending the iov_iter patch to you - right around
> now, I believe, as a bugfix, since right now
> copy_page_from_iter_atomic() silently does crazy things if you pass it a
> compound page.
>
> Block layer patches aside, are there any _others_ you really want to go
> via maintainers?

It was mainly just the iov and the block layer.

The superblock cases I really don't understand why you insist on just
being different from everybody else.

Your exclusivity arguments make no sense to me. Just open the damn
thing. No other filesystem has ever had the fundamental problems you
describe. You can do any exclusivity test you want in the
"test()/set()" functions passed to sget().

You say that it's a problem because of a "single spinlock", but it
hasn't been a problem for anybody else.

I don't understand why you are so special. The whole problem seems made-up.

> More broadly, it would make me really happy if we could get certain
> people to take a more constructive, "what do we really care about here
> and how do we move forward" attitude instead of turning every
> interaction into an opportunity to dig their heels in on process and
> throw up barriers.

Honestly, I think one huge problem here is that you've been working on
this for a long time (what - a decade by now?) and you've made all
these decisions that you explicitly wanted to be done independently
and intentionally outside the kernel.

And then you feel that "now it's ready to be included", and think that
all those decisions you made outside of the mainline kernel now *have*
to be done that way, and basically sent your first pull request as a
fait-accompli.

The six-locks showed some of that, but as long as they are
bcachefs-internal, I don't much care.

The sget() thing really just smells like "this is how I designed
things, and that's it".

                Linus
