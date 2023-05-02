Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B436F4959
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 19:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjEBR5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 13:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjEBR5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 13:57:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8F410DB
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 10:57:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bcc565280so2828056a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683050219; x=1685642219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqEVSi1tIs1lx7L3PYkMCAcIos89W6lP6qkbZVC6M00=;
        b=cozF2pcBtZM+69nHKAdfdK3xI+rn6wAsdaawLwTZavm8AVdaSEytAClmAfvh2RMHMl
         STdeX5uJrTqLMw671HtGS4Nam5xMr1HfxIm43M4g9j6u2oFwHWlMJcQyzfBxhVw5Ch7r
         gpIN6rxsYHjjR77hLEfUzdSmzNhCqGxPv/9HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683050219; x=1685642219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqEVSi1tIs1lx7L3PYkMCAcIos89W6lP6qkbZVC6M00=;
        b=aJyJUzjH2QzFdsv6w26hbxtTr73rqnxgKZiv4jVStU2wT6oV/35zB2NA7arefd9VPi
         K7lI0mYXeK6utaNbLk6MWS0r52QX0jgZrcv8Xjd2P/WSRGbOo1K3rRZop3xyneVdGxJU
         CCx0MkfKw3MzWDpMIwQPEVeaOJcA8LJPkNPO1NPLEXnMsz5xLVpaxvUL5SdtVoqz5Qnn
         /etC93GApu7G2kP3QPtBZ59K+CkZwv7FZuDgPslvM4HkIZoiTN+jReiLWRFrNZ8l+OD6
         xz0u+RD+xmiOxKXl6ta7sodIC3gn9XuGqyU38lraxFaxKyFOAqEMxoMJAimJSKsXwWLy
         refQ==
X-Gm-Message-State: AC+VfDzTojKStrTnLQyO+udDdTBkOWhsrlwaVOMtNIWUjINWJbW9fN6F
        3y0VYirT+58y6uoi/gQaliq/8bG+rYsimHpoZ9lt4w==
X-Google-Smtp-Source: ACHHUZ70bIxa2QBFjoLhtBTANSly+rbDucuAeAOOVSIOmFazQeYHCy2o/Lxy3vpu0qLqlT8EaucCaQ==
X-Received: by 2002:a17:907:749:b0:94f:4102:25c8 with SMTP id xc9-20020a170907074900b0094f410225c8mr904366ejb.61.1683050218802;
        Tue, 02 May 2023 10:56:58 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906054900b00923f05b2931sm16270358eja.118.2023.05.02.10.56.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 10:56:57 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-94f32588c13so697522166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 10:56:57 -0700 (PDT)
X-Received: by 2002:a17:907:360d:b0:94e:ec32:ba28 with SMTP id
 bk13-20020a170907360d00b0094eec32ba28mr797457ejc.29.1683050217302; Tue, 02
 May 2023 10:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230502163528.1564398-1-dhowells@redhat.com>
In-Reply-To: <20230502163528.1564398-1-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 May 2023 10:56:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioTxLt1pkt6uwVfFNaZ98fONWaMfY5ybZfzYt6BaSM2g@mail.gmail.com>
Message-ID: <CAHk-=wioTxLt1pkt6uwVfFNaZ98fONWaMfY5ybZfzYt6BaSM2g@mail.gmail.com>
Subject: Re: [PATCH 0/3] afs: Fix directory size handling
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 2, 2023 at 9:35=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> The patches can be found here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dafs-fixes

Ok, I started pulling this, and then I realized that this is the first
time in this release window that I've gotten a non-signed pull
request.

(Not that it was a proper pull request format anyway - the above is
just a gitweb pointer, not a real git branch pointer, but it was close
enough)

So can you please just make this a proper signed tag, and maybe we'll
have the first release ever when every single pull is done with
signage?

I know you can do this properly, since  I have several pull requests
from you that were signed, including for AFS.

                 Linus
