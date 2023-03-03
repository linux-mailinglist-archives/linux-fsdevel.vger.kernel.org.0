Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD296AA0AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 21:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjCCUjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 15:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCCUjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:39:14 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C8512043;
        Fri,  3 Mar 2023 12:39:13 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bh20so2721062oib.9;
        Fri, 03 Mar 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677875952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG6EKujrzKyN55ZG7hxXPBM9OaZ+zgs1s5FPu+FTZes=;
        b=lsqBDPsZuu7gE5EbM8Q+y8jrcDlY/HC/QV2Z2BrEljqejz2M6qHDnp1xPAbthI4ZYe
         6sFuYReqJu2i23Q8RB0PsHwKq3Z3mIwVyuPxkqSsCy9T03EmNZTiLFRpWJ+Qyv4pGQBh
         CeC2v8N2fZEAygBtyVB63+7wekUl2hnU4wAk30AULZ79SREwZ7OW98DSs0DG7AmzAZNL
         s6ovCMC7aA9+O5XoHmtgUy1FNFDQ+XiGicXrJ44W8VKrJXQiQjrILpupQ1q0wZNP5iE1
         2KjjOnCdunZ5NkiO78fqWOdQzz1d1Ru5qHw6amvCRLaspFa7zVvNjynMO90bUf9N8BLF
         ps2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG6EKujrzKyN55ZG7hxXPBM9OaZ+zgs1s5FPu+FTZes=;
        b=y/IGfJtysJrf6sUUaKsAjw2tig8IvITtQzA/dO/4/wJ6dmTdQS1r6de+Xn9ZckmHRX
         vQn22lprMGjQcKPNH2AJbu0TciGkVx9vwKuZ1bQIg1ZyxTjKLds/g+cQRjlRa7sCamfA
         ycD1Cnsc+QdVsWGdXuZw8+mtfGMHzzMl847KYvC4Bt4cGbkat7rko9wyySn75EYN4y7y
         ++61GSjYzj8kP73HYPGSnYgwQPeyfyoxP6nZ8V2JDI+tBViJ/rPW4k+MU0/3pxQXiLCa
         s/+UBNy9N4lN5BfRvSTBQLel25DUT5oAA5uy9b8+MZz8wACg4fti246ADgiKT+a5VUmT
         1dRQ==
X-Gm-Message-State: AO0yUKXfe2bCTq18/Xr44s2P7zzi2LX6TGWV66HrpxC8odq9Ad9fotPv
        MO65prMyKDbRF+Lt0t7yKmAmXLG8hb7bDJkqGZM=
X-Google-Smtp-Source: AK7set/mqM3zFV4SCOt6b4PSJMXUFm4gpSadoEGXGfUF3+qxJSFjjOfT1eDZ6LQYAmR+TkScgh4SpaRqJAGq2X6A3TU=
X-Received: by 2002:a05:6808:2098:b0:383:f981:b1e5 with SMTP id
 s24-20020a056808209800b00383f981b1e5mr3495245oiw.5.1677875952073; Fri, 03 Mar
 2023 12:39:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:31f:b0:4c2:d201:fe1f with HTTP; Fri, 3 Mar 2023
 12:39:11 -0800 (PST)
In-Reply-To: <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com> <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 3 Mar 2023 21:39:11 +0100
Message-ID: <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, Mar 3, 2023 at 11:37=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
>>
>> I mentioned in the previous e-mail that memset is used a lot even
>> without the problematic opt and even have shown size distribution of
>> what's getting passed there.
>
> Well, I *have* been pushing Intel to try to fix memcpy and memset for
> over two decades by now, but with FSRM I haven't actually seen the
> huge problems any more.
>

rep *stos* remains crap with FSRM, but I don't have sensible tests
handy nor the ice lake cpu i tested on at the moment

> I actually used to have the reverse of your hack for this - I've had
> various hacks over the year that made memcpy and memset be inlined
> "rep movs/stos", which (along with inlined spinlocks) is a great way
> to see the _culprit_ (without having to deal with the call chains -
> which always get done the wrong way around imnsho).
>

that's all hackery which makes sense pre tooling like bpftrace, people
can do better now (see the second part of the email)

I think there is a systemic problem which comes with the kzalloc API, consi=
der:
static struct file *__alloc_file(int flags, const struct cred *cred)
{
	struct file *f;
	int error;

	f =3D kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
	if (unlikely(!f))
		return ERR_PTR(-ENOMEM);
        [bunch of the struct gets initialized here]

the allocation routine does not have any information about the size
available at compilation time, so has to resort to a memset call at
runtime. Instead, should this be:

f =3D kmem_cache_alloc(...);
memset(f, 0, sizeof(*f));

... the compiler could in principle inititalize stuff as indicated by
code and emit zerofill for the rest. Interestingly, last I checked
neither clang nor gcc knew how to do it, they instead resort to a full
sized memset anyway, which is quite a bummer.

Personally i grew up on dtrace, bpftrace I can barely use and don't
know how to specifically get the caller, but kstack(2) seems like a
good enough workaround.

as an example here is a one-liner to show crappers which do 0-sized ops:
bpftrace -e 'kprobe:memset,kprobe:memcpy /arg2 =3D=3D 0/ { @[probe,
kstack(2)] =3D count(); }'

one can trace all kinds of degeneracy like that without recompiling
anything, provided funcs are visible to bpftrace

sample result from the above one-liner while doing 'make clean' in the
kernel dir:
@[kprobe:memcpy,
    memcpy+5
    realloc_array+78
]: 1
@[kprobe:memcpy,
    memcpy+5
    push_jmp_history+125
]: 1
@[kprobe:memset,
    memset+5
    blk_mq_dispatch_rq_list+687
]: 3
@[kprobe:memcpy,
    memcpy+5
    mix_interrupt_randomness+192
]: 4
@[kprobe:memcpy,
    memcpy+5
    d_alloc_pseudo+18
]: 59
@[kprobe:memcpy,
    memcpy+5
    add_device_randomness+111
]: 241
@[kprobe:memcpy,
    memcpy+5
    add_device_randomness+93
]: 527
@[kprobe:memset,
    memset+5
    copy_process+2904
]: 2054
@[kprobe:memset,
    memset+5
    dup_fd+283
]: 6162

--=20
Mateusz Guzik <mjguzik gmail.com>
