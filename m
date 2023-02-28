Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216266A5B08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 15:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjB1Org (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 09:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjB1Orf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:47:35 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9AE1CF4F;
        Tue, 28 Feb 2023 06:47:34 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id p8-20020a4a3c48000000b0052527a9d5f0so1593800oof.1;
        Tue, 28 Feb 2023 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677595654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQqtgFt2ZrPoR/y5o9mWftXFVOmEsTr/lW9kmkGwIeU=;
        b=hkwXo3LNwgRxN74Mc8UpBqQy4W9v8MFdb0B21cwtvjSroAqCKA3nGxYMkFFR/hxN8q
         aTNjbWywo7ciKcrX/dnDhIDIQDPXwAML1PurY27j4DuewIwMigmXK49TVFyd8Ex/y3yE
         +HV8wGXMGu4+MFmfYE+BOqwYdjWL1L0WpQ6ousW4/XWyjZADA7iGsERDoj0msCc5UTYg
         60I1980f/Qnl/D9OAjS91fUJF7lhM+U4NjMw9APFLMG5Gs5/G3xsza1BtMilSEGBupYQ
         ec7zxIdDR9BnETts277yPYHeIMGKkJOvGn5i4dITRj9MwYquyO21oXy9da1jQTWz/bqa
         fe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677595654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQqtgFt2ZrPoR/y5o9mWftXFVOmEsTr/lW9kmkGwIeU=;
        b=mXuFm/2zZzjskzTvO3nC8zP705zd6mAr7kEK45Uc5VbCQtgpvHrOrI4Wm901og9rT4
         AgZCfG5Ex5y9VZYSSoBCcen3UN0Txpc0eWpdUV3GnfLDuUAVIs0IQpsQ9Yg6hUhgy64o
         +jW0tqkCjsQZdbo6bNFxrASbTCgAJtav4w0jnTdamdQT0u0MFD8Sh7HucgNgH7msRxdQ
         leUjm0+Hc/qHvhxQbirLnJ5zj+HUYiKOs2SCW/gc7RzihiyS7S4lWvzMrKlZNZzfUdug
         HdumwBp0Urmu9UrfZYAo0Ni6ZgBpw5AaefSo6oYw7EVbRvQ610o23/2rMrCDQ9us83OA
         BFGw==
X-Gm-Message-State: AO0yUKUY3MPNwAxjH7h5U8pcwQ8fd4voAZQBFo/1Qud8cKP1RsiZkJ3S
        rwy2GLejJ+1xuuNHzkSW2YQD5P2b5NQUSoWQiNo=
X-Google-Smtp-Source: AK7set8WvLmeK/3EEtJ41emSb/vN7XfCJ35JD48P5Pnt1sFUrR4W6SiHncUKVeXAqFboiMUX6ywXwL5DpvosfbdPRH4=
X-Received: by 2002:a4a:a302:0:b0:525:2b47:93cb with SMTP id
 q2-20020a4aa302000000b005252b4793cbmr908579ool.1.1677595654090; Tue, 28 Feb
 2023 06:47:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:4304:0:b0:4c1:4768:8c59 with HTTP; Tue, 28 Feb 2023
 06:47:33 -0800 (PST)
In-Reply-To: <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com>
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 28 Feb 2023 15:47:33 +0100
Message-ID: <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
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

On 2/28/23, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/27/2023 5:14 PM, Linus Torvalds wrote:
>> On Wed, Jan 25, 2023 at 7:56=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
>>> +static inline bool cap_isidentical(const kernel_cap_t a, const
>>> kernel_cap_t b)
>>> +{
>>> +       unsigned __capi;
>>> +       CAP_FOR_EACH_U32(__capi) {
>>> +               if (a.cap[__capi] !=3D b.cap[__capi])
>>> +                       return false;
>>> +       }
>>> +       return true;
>>> +}
>>> +
>> Side note, and this is not really related to this particular patch
>> other than because it just brought up the issue once more..
>>
>> Our "kernel_cap_t" thing is disgusting.
>>
>> It's been a structure containing
>>
>>         __u32 cap[_KERNEL_CAPABILITY_U32S];
>>
>> basically forever, and it's not likely to change in the future. I
>> would object to any crazy capability expansion, considering how
>> useless and painful they've been anyway, and I don't think anybody
>> really is even remotely planning anything like that anyway.
>>
>> And what is _KERNEL_CAPABILITY_U32S anyway? It's the "third version"
>> of that size:
>>
>>   #define _KERNEL_CAPABILITY_U32S    _LINUX_CAPABILITY_U32S_3
>>
>> which happens to be the same number as the second version of said
>> #define, which happens to be "2".
>>
>> In other words, that fancy array is just 64 bits. And we'd probably be
>> better off just treating it as such, and just doing
>>
>>         typedef u64 kernel_cap_t;
>>
>> since we have to do the special "convert from user space format"
>> _anyway_, and this isn't something that is shared to user space as-is.
>>
>> Then that "cap_isidentical()" would literally be just "a =3D=3D b" inste=
ad
>> of us playing games with for-loops that are just two wide, and a
>> compiler that may or may not realize.
>>
>> It would literally remove some of the insanity in <linux/capability.h>
>> - look for CAP_TO_MASK() and CAP_TO_INDEX and CAP_FS_MASK_B0 and
>> CAP_FS_MASK_B1 and just plain ugliness that comes from this entirely
>> historical oddity.
>>
>> Yes, yes, we started out having it be a single-word array, and yes,
>> the code is written to think that it might some day be expanded past
>> the two words it then in 2008 it expanded to two words and 64 bits.
>> And now, fifteen years later, we use 40 of those 64 bits, and
>> hopefully we'll never add another one.
>
> I agree that the addition of 24 more capabilities is unlikely. The
> two reasons presented recently for adding capabilities are to implement
> boutique policies (CAP_MYHARDWAREISSPECIAL) or to break up CAP_SYS_ADMIN.
> Neither of these is sustainable with a finite number of capabilities, nor
> do they fit the security model capabilities implement. It's possible that
> a small number of additional capabilities will be approved, but even that
> seems unlikely.
>
>
>> So we have historical reasons for why our kernel_cap_t is so odd. But
>> it *is* odd.
>>
>> Hmm?
>
> I don't see any reason that kernel_cap_t shouldn't be a u64. If by some
> amazing change in mindset we develop need for 65 capabilities, someone ca=
n
> dredge up the old code, shout "I told you so!" and put it back the way it
> was. Or maybe by then we'll have u128, and can just switch to that.
>

Premature generalization is the root of all evil (or however the
saying goes), as evidenced above.

The fact that this is an array of u32 escaped the confines of
capability.h and as a result there would be unpleasant churn to sort
it out, and more importantly this requires a lot more testing than you
would normally expect.

Personally I would only touch it as a result of losing a bet (and I'm
not taking any with this in play), but that's just my $0.05 (adjusted
for inflation).

--=20
Mateusz Guzik <mjguzik gmail.com>
