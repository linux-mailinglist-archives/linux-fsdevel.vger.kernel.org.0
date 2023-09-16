Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD407A2BC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 02:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjIPASg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 20:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbjIPASS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:18:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898E8359E
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:12:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962c226ceso42845151fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694823134; x=1695427934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8c5EEQNtbw0MpT7TQp8klkowES4X88JiAqVKAD/YI88=;
        b=SAzVGnsSi8BcZpTJaUyPPV8QfS1io9zyJoTpqj/aCUaU/DHdZCtTSJlyO2gONTR6NL
         QN7/53scWRsHIWD4L+z0R6jDQvMVQMNL889eo3RqKkAEJ0xqj4ijq5Lyd0C5r2dkWerS
         00YOYT6DSopPN+IQ5PZaPjwqLI6IerIpyeQn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694823134; x=1695427934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8c5EEQNtbw0MpT7TQp8klkowES4X88JiAqVKAD/YI88=;
        b=hQhbq7Tw5pB5FnjJQaz2wTHfeYxfhMb/ntysesUvdlEjVVWoLgkIMRzlVxjZU3a+mT
         GqL07e+RzTn0vTZBK5gvJHHHOmvEwxSm5xuoX+X4lkVzajqeBfsUm95euUA4vxfgn+ef
         s91LIaka5mcuYMtufZRRSigWVpOW2l/QzwiMiijIm19AEushgTxhlJ/CLc5ZBER8JIPV
         Y4QjdPXHUmdJClwsWx70n8M9eafxXjrHiu1FaGelzoD0jKx97BhcTgVxBWzL0yj4yVlS
         adyKeevY2qG9ZnMZy99xQiyzVGIHJ9mO8SLohAXe+fH4Q7lerN/EneB2RtFfpLK52BGy
         AhLA==
X-Gm-Message-State: AOJu0YwIBZn5ApzKyG8RP5LWpCoGrysFBVW2aYvEsZHyllTxdGsRIFNY
        C4ZDjRAs1isB+XBz+UMvqWYtTde5FubwnJvk0flQpWWR
X-Google-Smtp-Source: AGHT+IHjE8SmTNuqafYg0bp2VuBqlbqRiotom8qd84rYTF1KV1Jurr8NFBvNNAcEKCf0cI3nQ5LxMg==
X-Received: by 2002:a2e:8018:0:b0:2bc:baa0:57b8 with SMTP id j24-20020a2e8018000000b002bcbaa057b8mr2541814ljg.15.1694823134566;
        Fri, 15 Sep 2023 17:12:14 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id um12-20020a170906cf8c00b009a219ecbaf1sm3039765ejb.85.2023.09.15.17.12.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:12:13 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-530a6cbbb47so887957a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:12:13 -0700 (PDT)
X-Received: by 2002:aa7:d758:0:b0:525:6d6e:ed53 with SMTP id
 a24-20020aa7d758000000b005256d6eed53mr2493234eds.27.1694823132722; Fri, 15
 Sep 2023 17:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-3-willy@infradead.org>
In-Reply-To: <20230915183707.2707298-3-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:11:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
Message-ID: <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
Subject: Re: [PATCH 02/17] iomap: Protect read_bytes_pending with the state_lock
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Perform one atomic operation (acquiring the spinlock) instead of
> two (spinlock & atomic_sub) per read completion.

I think this may be a worthwhile thing to do, but...

> -static void iomap_finish_folio_read(struct folio *folio, size_t offset,
> +static void iomap_finish_folio_read(struct folio *folio, size_t off,

this function really turns into a mess.

The diff is hard to read, and I'm not talking about the 'offset' ->
'off' part, but about how now about half of the function has various
'if (ifs)' tests spread out.

And I think it actually hides what is going on.

If you decide to combine all the "if (ifs)" parts on one side, and
then simplify the end result, you actually end up with a much
easier-to-read function.

I think it ends up looking like this:

  static void iomap_finish_folio_read(struct folio *folio, size_t off,
                  size_t len, int error)
  {
        struct iomap_folio_state *ifs = folio->private;
        bool uptodate = true;
        bool finished = true;

        if (ifs) {
                unsigned long flags;

                spin_lock_irqsave(&ifs->state_lock, flags);

                if (!error)
                        uptodate = ifs_set_range_uptodate(folio, ifs,
off, len);

                ifs->read_bytes_pending -= len;
                finished = !ifs->read_bytes_pending;
                spin_unlock_irqrestore(&ifs->state_lock, flags);
        }

        if (unlikely(error))
                folio_set_error(folio);
        else if (uptodate)
                folio_mark_uptodate(folio);
        if (finished)
                folio_unlock(folio);
  }

but that was just a quick hack-work by me (the above does, for
example, depend on folio_mark_uptodate() not needing the
ifs->state_lock, so the shared parts then got moved out).

I think the above looks a *lot* more legible than having three
different versions of "if (ifs)" spread out in the function, and it
also makes the parts that are actually protected by ifs->state_lock a
lot more obvious.

But again: I looked at your patch, found it very hard to follow, and
then decided to quickly do a "what  happens if I apply the patch and
then try to simplify the result".

I might have made some simplification error. But please give that a look, ok?

              Linus
