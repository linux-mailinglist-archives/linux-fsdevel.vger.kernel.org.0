Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D36D3AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 01:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDBXhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Apr 2023 19:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBXhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Apr 2023 19:37:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065D059F9
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Apr 2023 16:37:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so110611750edd.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Apr 2023 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680478638; x=1683070638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfCtccL05CLlozu24pLM9/mPiXt7Cp0Q8DBrhsBdgAE=;
        b=Pjy1U4ebTTfHf9ZQtQZWfiPj0Jxh4lW0d9lbte8KFf+W1wjs8djoFEPEHTufmaSvQU
         qyzEbrSYlrlazTKac1Lk8CrwuHwd5Q3Bu7t4pwh5QpS1dP8JFPfGyf/LrZRA7hkACL3K
         0o59Ag37G5zg0FFYc/b81K9yQP7ZrW9SYGGDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680478638; x=1683070638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfCtccL05CLlozu24pLM9/mPiXt7Cp0Q8DBrhsBdgAE=;
        b=pQMuZuPdzM7tvOjp6pcrjP9X73EK29dz2J5y7B+nc5beHo5vkJ/YMgZ1Sd2p930WJd
         DUYkwhyTM7VDWAFTcqNgMM2VTPSsa1w+4QIfMVOp8asWLOm2Eoa4mRtc/CTCfg+J7eAe
         9xulf96dujgMWnBTQiBoK8bxGP9oYTaN11Z/2Am6E8Ej1+cLImOFfHHANDIgJMqgA0mD
         mTyI3cwsp+78t33Daaky1p7sZy0wHrQLg3v8Cdg3Nn5HyP48vat/tjrhfNdIxWRnqUTB
         0KtEDZ2CGBp21B/ILBNmb6G+ryTtvwtaepEjxgPXV1QQjpqGsdxgm501NEGObL+8VtfA
         Yaig==
X-Gm-Message-State: AAQBX9e8k6ymAcXgt373ertP6oIq3QAPmghBHL5b9XuUDYM/JWsnzLPK
        B5dCohLz2R9lhZrf//ErsqbTvRN5/zymsG78Rbx3/A==
X-Google-Smtp-Source: AKy350Z3vc92I5HEGDesOMDkTkT8/ZbcWaxj8JagQbvlsAu8nRV4zcQYNlUaMTUfoBFpvWAAZR2QrQ==
X-Received: by 2002:a17:906:250d:b0:8ae:e724:ea15 with SMTP id i13-20020a170906250d00b008aee724ea15mr32354306ejb.76.1680478638143;
        Sun, 02 Apr 2023 16:37:18 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906941200b009316783c92csm3767831ejx.12.2023.04.02.16.37.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 16:37:17 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id er13so69605700edb.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Apr 2023 16:37:17 -0700 (PDT)
X-Received: by 2002:a17:907:3e16:b0:932:da0d:9375 with SMTP id
 hp22-20020a1709073e1600b00932da0d9375mr10105435ejc.4.1680478636864; Sun, 02
 Apr 2023 16:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230330164702.1647898-1-axboe@kernel.dk> <CAHk-=wgmGBCO9QnBhheQDOHu+6k+OGHGCjHyHm4J=snowkSupQ@mail.gmail.com>
 <de35d11d-bce7-e976-7372-1f2caf417103@kernel.dk> <CAHk-=wiC5OBj36LFKYRONF_B19iyuEjK2WQFJpyZ+-w39mEN-w@mail.gmail.com>
 <df0f88e5-c0af-5d50-bdd5-b273218861bf@kernel.dk> <d2447c57-efa0-8f52-e1f5-fd32f4322823@kernel.dk>
In-Reply-To: <d2447c57-efa0-8f52-e1f5-fd32f4322823@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Apr 2023 16:37:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizy81mp4JT=8SXXv=_0HRuXFh4csB2fs=r2D0GaZ-mfg@mail.gmail.com>
Message-ID: <CAHk-=wizy81mp4JT=8SXXv=_0HRuXFh4csB2fs=r2D0GaZ-mfg@mail.gmail.com>
Subject: Re: [PATCHSET v6b 0/11] Turn single segment imports into ITER_UBUF
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 2, 2023 at 3:22=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Linus, are you going to turn this into a proper patch? This is too
> good to not pursue.

So I initially was planning on doing just that for 6.4.

However, I looked more at it, and I'm now fairly convinced that the
biggest problem is that we have basically screwed up our simple
"copy_to/from_user()" with all the indirection.

So yes, that patch may end up being a 6% improvement on the made-up
load, but a *large* reason for that is that we just do horribly badly
on a plain "copy_from_user()", and I think I could fix that.

The problems with "copy_from_user()" are:

 - it's *two* function calls ("_copy_to_user()" and then "raw_copy_to_user(=
)")

 - we have entirely lost all "this is how big the copy is" at all levels

and my stupid patch basically improves on copy_iovec_from_user() by
fixing those two issues:

 - it inlines it all by using the "unsafe_get_user()" interfaces

 - it recovers the access sizes by just accessing the fields directly

and in the process it gets rid of us being really really piggy in
"copy_from_user()".

Now, there are a few reason *why* we are so piggy in copy_from_user(), main=
ly

 (a) CLAC/STAC is just slow and 'access_ok()' is big

 (b) we have lots of debug boiler plate crap. Things like
      - might_fault() (PROVE_LOCKING || DEBUG_ATOMIC_SLEEP)
      - check_copy_size() (HARDENED_USERCOPY)
      - test should_fail_usercopy() (FAULT_INJECTION_USERCOPY)
      - do instrument_copy_from_user_before/after (KASAN)
      - clear the end of the buffer on failures (legacy behavior)

 (c) you probably don't have a CPU with X86_FEATURE_FSRM

Now, what (a) and (b) does is to make it unreasonable to inline
copy_from/to_user(). Particularly when those debug options are set,
but even without them, it's just not reasonable to inline.

Long long ago, we used to special-case small constant-sized user
copies, but all of that has gone away. That's lovely (it used to be
horrid in the header files, and caused problems)

And (c) means that the small cases tend to suck, although with all the
other overhead (two function calls, possibly with return stack
counting, CLAC/STAC, 'lfence' for speculation control etc etc), that's
almost not an issue. It's just extra cycles.

Again, that hack to copy_iovec_from_user() ends up working so well
simply because it avoids all the *stupid* stuff. Yes, it still
obviously does the CLAC/STAC and the access_ok(), but it's ok to
inline when it's just that special code, not some random
'copy_from_user()' that doesn't matter.

Anyway, what this long rant is about is that I'm looking at what I can
do to improve "copy_from_user()" instead. It's a pain, because of all
those debug options, but I actually have a disgusting patch that would
make it possible to have a much better copy_from_user.

How disgusting, you say? Let me quote part of it:

  +#define __a(n,a) ((unsigned long)(n)&((a)-1))
  +#define statically_aligned(n,a) \
  +       (__builtin_constant_p(__a(n,a)) && !__a(n,a))
  +
  +extern unsigned long copy_from_user_a16(void *to, const void __user
*from, unsigned long n);
  +extern unsigned long copy_from_user_a8(void *to, const void __user
*from, unsigned long n);
  +extern unsigned long copy_from_user_a4(void *to, const void __user
*from, unsigned long n);
  ...
  +               if (statically_aligned(n, 16))
  +                       n =3D copy_from_user_a16(to, from, n);
  +               else if (statically_aligned(n, 8))
  +                       n =3D copy_from_user_a8(to, from, n);
  +               else if (statically_aligned(n, 4))
  +                       n =3D copy_from_user_a4(to, from, n);
  +               else
  +                       n =3D _copy_from_user(to, from, n);

and it turns out that both gcc and clang are smart enough that even
when you don't have a *constant* size, when you have code like

        if (copy_from_user(iov, uvec, nr_segs * sizeof(*uvec)))
                return -EFAULT;

that "statically_aligned()" thing will notice that "look, that size is
a multiple of 16", and my disgusting patch replaces the "I have lost
all sign of the size of the copy" user copy with a call to
copy_from_user_a16().

And interestingly, that "size is 16-byte aligned" happens a *lot*. It
happens for that uvec case, but it also happens for things like
"cp_new_stat()" that copies a "struct stat" to user space, because
'struct stat' is something like 144 bytes (9*16) on x86-64.

So yes, I can improve the iovec copy. Easy peasy. Get rid of the crazy
overhead from a generic interface and from our disgusting debugging
code.

Or I could try to improve copy_to/from_user() in general.

My current patch is too ugly to actually live, and making it even
better (encode the size range when it is statically known, not just a
few "size is X-byte aligned") would make it uglier still.

I'm idly thinking about trying to teach 'objtool' to pick the right
function target by hiding the size information in a separate section.

I may decide that "just doing iovecs" is just so much simpler, and
that trying to improve the generic case is too painful. But that's the
issue right now - I know I *could* just improve copy_from_user()
enough that at least with sane configurations, that iovec improvement
would basically not be worth it.

The problem here is at least partly "sane configurations". At least
Fedora enables HARDENED_USERCOPY. And if you have that enabled, then
"copy_to/from_user()" is _always_ going to suck, and doing a special
"copy iovecs by avoiding it" is always going to be better, if only
because you avoid the debug overhead.

Argh.

             Linus
