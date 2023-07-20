Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7C75A2F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 02:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGTAAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 20:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTAAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:00:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720E0172D
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 17:00:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991ef0b464cso298261966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689811237; x=1690416037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=COIx9PJNSvI0bd/8+R1trZjf1/QUjd+w4gApApqhVyk=;
        b=XLfa24sTCoY1wCmDjlNQ277e/jCHs0bjYQHPTQnrW+oGdycu9T1/orUS5RJJlyx2oX
         3eRa8H1zmNVPOmNC2S/Khmb9MDc4h+kN4V82M+7PkecVSGPPyAISs79J6UkLT7sXQuW6
         /7axDHNfB9I/y4mOqp+yQyT+8jCvO6wQYdZF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689811237; x=1690416037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COIx9PJNSvI0bd/8+R1trZjf1/QUjd+w4gApApqhVyk=;
        b=VDnXzz9NY+83uO6pk6oxdGw5vVYOUIJG3rgZZVXvfYvR2/mdyCxdlkjae0iTZh9rc7
         Ph7JFMQlWEDNAubKHjcUqvnfez680KDVIAnQruJ0lI4ZPvNdlgVdXTc+Q51e8GU1uajp
         too0EJoIVz0txX4Psl5QKL48M+Hr4ejHg47siHVNbJchjgz1QB9jClcj1VYlG46wDKN1
         QOaRSdkr3FckcojYUDLhsgVVllcj67/rOZY1JcbDjvAZGfH2kcRR/HFb2TWIw/+dIjGB
         B7xWqQ45HpS21P0Pf20vDshVhwKABs43StzrCkdS2tClYrnto7fwUbyvxkaI2xpFqfLn
         gfEA==
X-Gm-Message-State: ABy/qLYYevVCRhbGXcq0eT6xG7oUVJ9u2Bph7KB1rnxNvm8Vc0NppF/Q
        EhrqrDHyIBEgzca4I8RRVXZ0Wro5mi3JXb1qDOGD1o1i
X-Google-Smtp-Source: APBJJlHCaoKJ53rXz2ItEWpE1gDjznnLJa2XPgQMR/8QgH9f3f4nakvv2rbulYGWBnP5zVpNjqOLkw==
X-Received: by 2002:a17:906:224b:b0:993:e695:b585 with SMTP id 11-20020a170906224b00b00993e695b585mr4482159ejr.9.1689811236868;
        Wed, 19 Jul 2023 17:00:36 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id kj27-20020a170907765b00b00997e52cb30bsm2523503ejc.121.2023.07.19.17.00.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 17:00:36 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so603936a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 17:00:34 -0700 (PDT)
X-Received: by 2002:a50:fc13:0:b0:51d:914a:9f3d with SMTP id
 i19-20020a50fc13000000b0051d914a9f3dmr3806792edr.10.1689811234438; Wed, 19
 Jul 2023 17:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org> <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
 <6609f1b8-3264-4017-ac3c-84a01ea12690@mattwhitlock.name> <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
 <0d10033a-7ea1-48e3-806b-f74000045915@mattwhitlock.name>
In-Reply-To: <0d10033a-7ea1-48e3-806b-f74000045915@mattwhitlock.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jul 2023 17:00:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwdG9KnADHQg9_F9vXFMKYFRcbSyb=0btFnzr2ufpQ6Q@mail.gmail.com>
Message-ID: <CAHk-=wgwdG9KnADHQg9_F9vXFMKYFRcbSyb=0btFnzr2ufpQ6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To:     Matt Whitlock <kernel@mattwhitlock.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Jul 2023 at 16:41, Matt Whitlock <kernel@mattwhitlock.name> wrote:
>
> Then that is my request. This entire complaint/discussion/argument would
> have been avoided if splice(2) had contained a sentence like this one from
> sendfile(2):
>
> "If out_fd refers to a socket or pipe with zero-copy support, callers must
> ensure the transferred portions of the file referred to by in_fd remain
> unmodified until the reader on the other end of out_fd has consumed the
> transferred data."
>
> That is a clear warning of the perils of the implementation under the hood,
> and it could/should be copied, more or less verbatim, to splice(2).

Ack. Internally in the kernel, the two really have always been more or
less of intermingled.

In fact, I think splice()/sendfile()/tee() could - and maybe should -
actually be a single man-page to make it clear that they are all
facets of the same thing.

The issues with TCP_CORK exist for splice too, for example, for
exactly the same reasons.

And while SPLICE_F_MORE exists, it only deals with multiple splice()
calls, it doesn't deal with the "I wrote a header before I even
started using splice()" case that is the one that is mentioned for
sendfile().

Or course, technically TCP_CORK exists for plain write() use as well,
but there the portable and historical fix is simply to use writev()
and send it all in one go.

So it's hopefully only when you use sendfile() and splice() that you
end up with "oh, but I have multiple different *kinds* of sources, and
I want to cork things until I've dealt with them all".

            Linus
