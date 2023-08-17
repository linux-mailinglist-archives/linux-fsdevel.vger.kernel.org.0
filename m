Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AF377FACA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351983AbjHQPb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352017AbjHQPbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:31:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0092D75
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:31:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99d937b83efso681859866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692286287; x=1692891087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZksWXJeiDtIMomMGS5LdQjB7hSovJabWytEHylyKmNA=;
        b=UZhUSWek8RNhfZ1nvdWBd+VSKvHqLrRH4TlPcZcnXec9/4z++prdyp6oZi8xdvLY93
         cL6IO6q2GI9wO9NyHvD+6x9NEuJQaao228zPlYh7PVH0FILGjOiAVnDEOlFqvCsdkMrC
         NhSbSYaogwrq+K42GWDoxB95/a/Su+x9Z86pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692286287; x=1692891087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZksWXJeiDtIMomMGS5LdQjB7hSovJabWytEHylyKmNA=;
        b=UCyg6Op0NYvwU1f/IulBbFovwPkDGqcWlUGGJS6NUKxT8cCr+Mi4u6URM0xvPJsW6w
         nyMfzfwGQVNYl1EPVAQBL+QHnIQCdvtZR042FeiG908s1JL+tmkSXYqwlmQvCchpw4nn
         4qvjSspziFguiKnN/1u0iciE80l4niF9C+WjTrjZaPowMdIWnHkdgvwJ3uoH4+5t35Nx
         M0ORTDun9APxZhMcqJLz85+zrIlMBK4MkmZ8iNMHXtVKGYW7p3cILn+iEa0FDYyB+532
         LzJ1tSz8cZGTLF09iHAg049/pLMZmnud0RJl1YWE4ER4Osp8fkTi5ENDd6iKXOCL95KM
         +xCw==
X-Gm-Message-State: AOJu0YymTMdtTDUKko8A4TCTDp5RXJ1Jn/1D3AHBZ09bkyIcQnx2qTaG
        Mgj5uf55rSrQr01jGvP39yRicTedGuODDAah137Rjtv7
X-Google-Smtp-Source: AGHT+IHjaq9lBl8Ud6OlWK45+t3LRzJqvTb5jvABRhlTri3hyhQyEEuze6DOsHskA6wHvjzuZRit8Q==
X-Received: by 2002:a17:907:1dc5:b0:99d:fed5:36be with SMTP id og5-20020a1709071dc500b0099dfed536bemr2423050ejc.55.1692286287575;
        Thu, 17 Aug 2023 08:31:27 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id h10-20020a170906854a00b00984822540c9sm10233484ejy.96.2023.08.17.08.31.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:31:26 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-99bcf2de59cso1014264666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:31:26 -0700 (PDT)
X-Received: by 2002:a17:906:5384:b0:98d:5ae2:f1c with SMTP id
 g4-20020a170906538400b0098d5ae20f1cmr4264910ejo.34.1692286286063; Thu, 17 Aug
 2023 08:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk> <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
 <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com> <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
 <2190704172a5458eb909c9df59b6a556@AcuMS.aculab.com>
In-Reply-To: <2190704172a5458eb909c9df59b6a556@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 17:31:09 +0200
X-Gmail-Original-Message-ID: <CAHk-=wj1WfFGxHs4k6pn5y6V8BYd3aqODCjqEmrTWP8XO78giw@mail.gmail.com>
Message-ID: <CAHk-=wj1WfFGxHs4k6pn5y6V8BYd3aqODCjqEmrTWP8XO78giw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Laight <David.Laight@aculab.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, 17 Aug 2023 at 17:16, David Laight <David.Laight@aculab.com> wrote:
>
> gcc for x86-64 make a pigs-breakfast when the bitfields are 'char'
> and loads the constant from memory using pc-relative access.

I think your godbolt tests must be with some other model than what the
kernel uses.

For example, for me, iov_iter_init generates

        testl   %esi, %esi      # direction test
        movb    $1, (%rdi)      # bitfields
        movq    $0, 8(%rdi)
        movq    %rdx, 16(%rdi)
        movq    %r8, 24(%rdi)
        movq    %rcx, 32(%rdi)
        setne   1(%rdi)            # set the direction byte

with my patch for me. Which is pretty much optimal.

*Without& the patch, I get

        movzwl  .LC1(%rip), %eax
        testl   %esi, %esi
        movb    $0, (%rdi)
        movb    $1, 4(%rdi)
        movw    %ax, 1(%rdi)
        movq    $0, 8(%rdi)
        movq    %rdx, 16(%rdi)
        movq    %r8, 24(%rdi)
        movq    %rcx, 32(%rdi)
        setne   3(%rdi)

which is that disgusting "move two bytes from memory", and makes
absolutely no sense as a way to "write 2 zero bytes":

.LC1:
        .byte   0
        .byte   0

I think that's some odd gcc bug, actually.


> Otherwise pretty must all variants (with or without the bitfield)
> get initialised in a single write.

So there may well be some odd gcc code generation issue that is
triggered by the fact that we use an initializer to set those things,
and we then have two bytes (with my patch) followed by a hole, or
three bytes (without it) followed by a hole.

But that bitfield thing improves things at least for me. I think the
example code you used for godbolt is actually something else than what
the kernel does.

               Linus
