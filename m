Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9779965E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 06:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbjIIE6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 00:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjIIE6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 00:58:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E21FCA
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 21:58:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c3726cc45so2749050f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694235494; x=1694840294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GxQANpgVeQfdQMQsfQ2n35clhF7Pc7Czuq+Dar+n48E=;
        b=F93gSTO1/ADGwjYcXWvaVemI5Z7K2NGfpRYavK6D2xf+NGIB0tDXDjbPNILgr+xKgJ
         tkqiNpxu68okiJbTstVJfIEgHRdvNAExoOw7GNwsjFdEfK/NwZyErZ2skjv/NjeRtTY1
         7GsDjnAGEfGKB1BcRp7ZAQgtG8G2/ZzxfM35s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694235494; x=1694840294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxQANpgVeQfdQMQsfQ2n35clhF7Pc7Czuq+Dar+n48E=;
        b=GERG0Cvcs4qXtg5YU3ltIuvrdtMTlfjYm7dxqcW4T0o5SLalzxNBChtHuuWAPHmuwy
         0JWS+0uqvAS+wd918P2AWuVLfBQzG9gEwZT15f1nY5kf3iPM+RngPa+boe1foFO4vKrA
         8XvaLVkss9KN29vyLwL7B6A5fR2LeCyps/cRufiNd+K1DtvZ9pW+pxQz1jme1mmNg/qP
         XfqgMHe3gsUlLhXa9GpL6YhqcHNaXCSRLkWsp5I0QRWhL+MSKN2TLtGFHNKCda4ajoi5
         LV/qlwr2A+fVPdgmP0iOap1Aa9kd+oEaWYKGP0LLrZ3hlu2Zgst6IiAazCWvRzbbK9sx
         uKPQ==
X-Gm-Message-State: AOJu0YymlLW8D3zH5Czy9GmTqTqdC+7u/i+Yqpza9+eklfzYAExALq5R
        sLSGUSRmKtlqQqwi/73NwYNBxj8ncPmZHcWNv1mKwF7t
X-Google-Smtp-Source: AGHT+IFoIdMdnhW8IOomwWv8srw10luYIV8EjZAyZTXgmcPjs72t1sWrLJ/Mb3f1CCgu4Y+ecAnVYA==
X-Received: by 2002:a5d:51cd:0:b0:317:7362:3fe8 with SMTP id n13-20020a5d51cd000000b0031773623fe8mr3442694wrv.9.1694235493721;
        Fri, 08 Sep 2023 21:58:13 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id e1-20020a056402148100b0052567e6586bsm1775288edv.38.2023.09.08.21.58.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 21:58:13 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99bcfe28909so328567466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 21:58:13 -0700 (PDT)
X-Received: by 2002:a17:906:21b:b0:9a1:ea01:35a8 with SMTP id
 27-20020a170906021b00b009a1ea0135a8mr3538438ejd.42.1694235492739; Fri, 08 Sep
 2023 21:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <ZPtdbS6FTadc3LVA@casper.infradead.org>
In-Reply-To: <ZPtdbS6FTadc3LVA@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Sep 2023 21:57:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaA0JL0TshZpQOwRoPsmRT7xKoHniv8gkdTdn+LF3oXA@mail.gmail.com>
Message-ID: <CAHk-=wiaA0JL0TshZpQOwRoPsmRT7xKoHniv8gkdTdn+LF3oXA@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 6.6
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
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

On Fri, 8 Sept 2023 at 10:44, Matthew Wilcox <willy@infradead.org> wrote:
>
> I had to update the expiration on my signing key.  I don't know if you
> pay attention to that, or whether my attempts to get my updated expiration
> date into the system were successful.

I'm sadly much too used (resigned?) to pgp keys being expired, so I
mostly ignore it, apart from the occasional internal swearing at
people who thought it was ever a good idea.

So exactly because the pgp key server infrastructure works so badly
these days, may I suggest either getting rid of expiration dates, or
at least putting them *far* in the future?

Honestly, the argument for expiration dates was never very strong, and
with how badly updates work, the constant low-grade annoyance from
them isn't worth it.

Because no, a "gpg --refresh" certainly did *not* get any expiration
day updates here. So your key does indeed show that it is expired for
me.

Which just should drive home how #$!* useless those expiration dates
are. Really.

So again - please stop expiring your keys, at least in any foreseeable
near future. The pgp key infrastructure isn't set up for it.

Make the expiration date go away, or make it a decade or two in the
future, and maybe it will show as active and valid some day.

               Linus
