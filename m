Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F05C7B0DF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 23:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjI0VSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 17:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:18:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB04D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 14:18:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b0168a9e05so1268548066b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695849530; x=1696454330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G8V+lk3a6Cym1PJ0mfiXsEqz7twyU2MgEXEYS1WTIfQ=;
        b=T9wMVK3bnjWmJO7M4kwiaAOm2VnWwbW9DXDejoQgfkvRvF/v80XY7LBZu4zJBwYnvA
         xri9lI7g/PYEk+OtcMavgWDlxkKriXtUDoBKmpIVBhf9EgSVV9RuhHKR6Q4WR1SFiQE2
         VtCC0PP4JAkGz0/6Q4XTi56sxmxOl7yWSTKCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695849530; x=1696454330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8V+lk3a6Cym1PJ0mfiXsEqz7twyU2MgEXEYS1WTIfQ=;
        b=FwBsf8pQePGO71OQHjXz3lk+UB9Qw5ywqSYUt4O/jATJFjNe6tQrPCfi11u2ADnOVc
         F4Pv1GjVWxnuHzuC274R0XilNLQpxY7Z4grzqxqzR/QxwovVUTyMU9Abo03J7LY5S8gG
         Z8E8V513VB79vmZBbLstXzrqsohhxIaLjWb3KxlIZR0uVkueRAGo9DBKQBxBV/m9MRYS
         sO6TRhRIcSqDr5eXHPP7+26Rp3ruWlJidHBIwx2f/zgwXc7dgemb4Jb4vxbgmCTujea9
         cMy44x/nf1pF7eek780JzUNuIT0svGE3FC970kfcbtJyuC07H8McfsyBydeWbpyyfHWk
         M+zw==
X-Gm-Message-State: AOJu0Yzfu4QlNT3oaYrcumzieDygGB27wwY68OcqH3cFCh3AauzCMSH5
        4TmELxfcNAOc5BZhWt+RR/yjbgS0Mh5DMLLtAo8/hg==
X-Google-Smtp-Source: AGHT+IEiZuv+0iKOl4lN9oAr7u9hqsJFMqiW29UK1l4MVee1a7iuDFEIJz1wuWjHHBOS9FLOPWoyfA==
X-Received: by 2002:a17:906:2b11:b0:9a5:9ddc:607d with SMTP id a17-20020a1709062b1100b009a59ddc607dmr2547422ejg.61.1695849530021;
        Wed, 27 Sep 2023 14:18:50 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090646c300b009ae57888718sm9814354ejs.207.2023.09.27.14.18.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 14:18:49 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-532784c8770so14882489a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 14:18:49 -0700 (PDT)
X-Received: by 2002:a05:6402:1652:b0:533:f1c4:5424 with SMTP id
 s18-20020a056402165200b00533f1c45424mr2803713edx.35.1695849528832; Wed, 27
 Sep 2023 14:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner> <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <CAGudoHH20JVecjRQEPa3q=k8ax3hqt-LGA3P1S-xFFZYxisL6Q@mail.gmail.com>
In-Reply-To: <CAGudoHH20JVecjRQEPa3q=k8ax3hqt-LGA3P1S-xFFZYxisL6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Sep 2023 14:18:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLX7-waQ+RX6DBF_ybzpEpneCkBSkBCeHKtmEYWaLOTg@mail.gmail.com>
Message-ID: <CAHk-=whLX7-waQ+RX6DBF_ybzpEpneCkBSkBCeHKtmEYWaLOTg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Wed, 27 Sept 2023 at 14:06, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I think you attached the wrong file, it has next to no changes and in
> particular nothing for fd lookup.

The fd lookup is already safe.

It already does the whole "double-check the file pointer after doing
the increment" for other reasons - namely the whole "oh, the file
table can be re-allocated under us" thing.

So the fd lookup needs rcu, but it does all the checks to make it all
work with SLAB_TYPESAFE_BY_RCU.

> You may find it interesting that both NetBSD and FreeBSD have been
> doing something to that extent for years now in order to provide
> lockless fd lookup despite not having an equivalent to RCU (what they
> did have at the time is "type stable" -- objs can get reused but the
> memory can *never* get freed. utterly gross, but that's old Unix for
> you).

That kind of "never free'd" thing is indeed gross, but the
type-stability is useful.

Our SLAB_TYPESAFE_BY_RCU is somewhat widely used, exactly because it's
much cheaper than an *actual* RCU delayed free.

Of course, it also requires more care, but it so happens that we
already have that for other reasons for 'struct file'.

> It does work, but I always found it dodgy because it backpedals in a
> way which is not free of side effects.

Grep around for SLAB_TYPESAFE_BY_RCU and you'll see that we actually
have it in multiple places, most notably the sighand_struct.

> Note that validating you got the right file bare minimum requires
> reloading the fd table pointer because you might have been racing
> against close *and* resize.

Exactly. See __fget_files_rcu().

          Linus
