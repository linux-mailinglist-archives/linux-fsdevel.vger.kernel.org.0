Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AB06AA0C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 21:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjCCU6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 15:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjCCU6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:58:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A431218B09
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 12:58:33 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o12so15262301edb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 12:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677877112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o4OY5lQPKh+GkI89Rz6TXZXk/LYf31mRBJK3Sl9ezg=;
        b=PyBlh3TaC6AY2IaRzPfVxfaIj90lqsk2+bToAYFa2qzDIPO7VYLiLtVSDbJJBoEiy7
         TlkyueFoXWtTjF6K3CKXJCl90oaQr4OlkbH7D/mKfXsh81d9CQfm+sxys9D0R1l0jcU/
         CP01sDAjSuoPFCQyplTZizSeXN3DMAW1GJ6Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677877112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o4OY5lQPKh+GkI89Rz6TXZXk/LYf31mRBJK3Sl9ezg=;
        b=FYSaKPZBrTi7TswAoPBiHWB2bfKhgO3dYcmjAYd8WifydGUguVSMtMbwn5gsuvUZ0u
         5i6VcCQG1tTmX7x14PtNNeoJhkWodyO9H+X4ZKgCk0xNxHaWhDF7ew7ce4eynv8N3Zht
         uviIuJUN99MfvWfVh81NoV0bbx701Hn1oh3wH4bSjlTaH6GafxQQy6pI1Q5rvmJMNPfv
         jBvzydfCSdUFZKjxLQno17jVMTNv8foOOB1UwAyqZo3Zwq1SqhHgkzun1CMp7CwMugSN
         nSQdcyyuKbzmwSx9fEpHbmpwD01AqO8IOPEN/JOPUE8Jtx/4ZI/bWtjRgiNZGx/A4qRe
         6MHw==
X-Gm-Message-State: AO0yUKVwcR1gDVBsNVQ0ibVPD1r5YYlTDrVpISq+9mCo5V7Eqd1QE1NL
        LcqfbLIDEVhkZ1qLv0X34AcCkcc6cK4cRctZuWVW+A==
X-Google-Smtp-Source: AK7set/hjDq9Qry0h5k28gQSQYiP8yNgFMx2f39e8oqK4sOnX77vS+w+y1HmZVrMP6dZzYO5RZz6lA==
X-Received: by 2002:a17:906:3687:b0:881:4d98:fe2e with SMTP id a7-20020a170906368700b008814d98fe2emr2420505ejc.29.1677877111802;
        Fri, 03 Mar 2023 12:58:31 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090685c200b008dcaf24bf77sm1325379ejy.36.2023.03.03.12.58.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:58:30 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id g3so15435100eda.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 12:58:30 -0800 (PST)
X-Received: by 2002:a17:906:3d51:b0:8f1:4c6a:e72 with SMTP id
 q17-20020a1709063d5100b008f14c6a0e72mr1497478ejf.0.1677877109830; Fri, 03 Mar
 2023 12:58:29 -0800 (PST)
MIME-Version: 1.0
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
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com> <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
In-Reply-To: <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 12:58:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com>
Message-ID: <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 3, 2023 at 12:39=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> I think there is a systemic problem which comes with the kzalloc API

Well, it's not necessarily the API that is bad, but the implementation.

We could easily make kzalloc() with a constant size just expand to
kmalloc+memset, and get the behavior you want.

We already do magical things for "find the right slab bucket" part of
kmalloc too for constant sizes. It's changed over the years, but that
policy goes back a long long time. See

   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/=
?id=3D95203fe78007f9ab3aebb96606473ae18c00a5a8

from the BK history tree.

Exactly because some things are worth optimizing for when the size is
known at compile time.

Maybe just extending kzalloc() similarly? Trivial and entirely untested pat=
ch:

   --- a/include/linux/slab.h
   +++ b/include/linux/slab.h
   @@ -717,6 +717,12 @@ static inline void *kmem_cache_zalloc(struct
kmem_cache *k, gfp_t flags)
     */
    static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
    {
   +    if (__builtin_constant_p(size)) {
   +            void *ret =3D kmalloc(size, flags);
   +            if (ret)
   +                    memset(ret, 0, size);
   +            return ret;
   +    }
        return kmalloc(size, flags | __GFP_ZERO);
    }

This may well be part of what has changed over the years. People have
done a *lot* of pseudo-automated "kmalloc+memset -> kzalloc" code
simplification. And in the process we've lost a lot of good
optimizations.

I used to do profiling religiously, but these days I only do it for
particular areas (usually just the walking part of pathname lookup)

             Linus
