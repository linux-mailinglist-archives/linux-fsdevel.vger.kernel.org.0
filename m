Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23686AA076
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 21:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjCCUIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 15:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjCCUIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:08:23 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA213D61
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 12:08:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f13so14878152edz.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 12:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677874100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icUeuEqvqPbQnLnoTJFmZqOp/anQ4LMobszRgORXgsw=;
        b=f2MLzsq14+IZ8TyfPiFoG9W1v55K/iJwVqrLY+ExatakJDVAxbzI3HEhLavhUvW88+
         e0OAp1q6aIj6Hr7vee/Jkxfuz5A4MuBoRwjTQbSouqPLRLdC1Mp/P9Rpj5qLX1AaGVGt
         +1dOjBj8u+KCYqfbHCSCkSlfKCWOZirPrNnH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677874100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icUeuEqvqPbQnLnoTJFmZqOp/anQ4LMobszRgORXgsw=;
        b=BE7W03bAa5MXwUx88EuPNWJUStO8YABzuTQA3bBVj0HY1/D7/Ybu5BVceKs3bdbAJx
         UvlCNeD+EY5F9RFWYHHb/sc7yrvsgoMfMz67RgNwygI1juZXnQxhmtg8xg2jPjnREh3+
         o3Kw115gHFFJr6xwcigkRdQLR+OrzTH0IaWLjb9dW+hna+nrj/wM2y/w+m3R+4q1Gj2z
         Nu99c/6JgkR1csjb8WgO19KWGdwwdGnrj/Uk/0wLRAmNdqQhK6uTnChSi5wDh+FZ/z6u
         bzSvkGR1AE/eMkMdOq7NbVGXw2klqhaNFlRNr6tNVR4UXAfCIdRCZ7PvsUho2hlYMBmr
         3N/w==
X-Gm-Message-State: AO0yUKUEshM/3bO0nGncPt0F311aJEKO7fDYLZZKQSJF37Y676JKvXbv
        WvPrxQaeKoxILzIWZbArJ5IvGj6GLvirSwsPOIU=
X-Google-Smtp-Source: AK7set/Ws4jJgTidMbKRb/YKCdS5HIO9u+xpjl9t9Qah8N0WtsPKQmVvjnAW2fu7ggxFq8lLI0vL9A==
X-Received: by 2002:a17:907:97ce:b0:8f3:9ee9:f1bc with SMTP id js14-20020a17090797ce00b008f39ee9f1bcmr2922691ejc.13.1677874100643;
        Fri, 03 Mar 2023 12:08:20 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id k20-20020a17090627d400b008b17ca37966sm1302223ejc.148.2023.03.03.12.08.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:08:19 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id i34so14855726eda.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 12:08:19 -0800 (PST)
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr1471718eju.0.1677874098906; Fri, 03 Mar
 2023 12:08:18 -0800 (PST)
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
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com> <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
In-Reply-To: <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 12:08:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
Message-ID: <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
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

On Fri, Mar 3, 2023 at 11:37=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> I mentioned in the previous e-mail that memset is used a lot even
> without the problematic opt and even have shown size distribution of
> what's getting passed there.

Well, I *have* been pushing Intel to try to fix memcpy and memset for
over two decades by now, but with FSRM I haven't actually seen the
huge problems any more.

It may just be that the loads I look at don't have issues (or the
machines I've done profiles on don't tend to show them as much).

Hmm. Just re-did my usual kernel profile. It may also be that
something has changed. I do see "clear_page" at the top, but yes,
memset is higher up than I remembered.

I actually used to have the reverse of your hack for this - I've had
various hacks over the year that made memcpy and memset be inlined
"rep movs/stos", which (along with inlined spinlocks) is a great way
to see the _culprit_ (without having to deal with the call chains -
which always get done the wrong way around imnsho).

            Linus
