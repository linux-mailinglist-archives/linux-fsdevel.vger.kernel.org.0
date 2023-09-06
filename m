Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADD97943DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 21:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244222AbjIFTgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244206AbjIFTgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:36:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2821BF
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 12:36:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so143853a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694028997; x=1694633797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mtg/nQGifsLU9qENmxHQ00cXrbdcS8vGgWh6gQnrcGw=;
        b=XJTTyExyrCZTjrBfDnQQ/HMwGqwX2BPUSBxIIHdqUV2ciXhUa8L6Os2ZahiyUO6XyC
         MalAgtXIrD3yl1YmsZO6+toCC9Fi6tyu08ew8ZOQCwLSz+z7QyPHI1H8cPTPEYppGvSi
         ZcCipA14wvU1hg9bMcUkOH2uXG9N/dw3eSJhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694028997; x=1694633797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtg/nQGifsLU9qENmxHQ00cXrbdcS8vGgWh6gQnrcGw=;
        b=gsdlwVbkUpMDMhsJ9OW+I2JL/qwZtA2opDDrjQibokDqEJ4w7dbK8bpvidOQ27hn0R
         zIoFMxagIq3ixh4p6lT1Ok4Iffeo/rce5aodRyjUZOh6BlUy6cBusUwHdH5Mpi+2BB5V
         r2DdtOze1X5yb/UtcfopqrrmJROm/kWOayyQHv8BcAstRatFSzZRPoeQtXA3IRHajrvY
         HN/BnwzJo0R4+CfHcJo8o4jvvgZgR+0vFSN3HXK8ko/mJQrlJJgV+wmgSuSkPz+VnGoN
         +HDF884FDx7w1hqBU/ZHFMDuFP6Dkit9Pd4TFsBHyp5SEeSOHOhJfsFbhOhRDHT0ESZR
         EoJw==
X-Gm-Message-State: AOJu0Yw/rqg+bkjWHrnV3WKr1OCihYPur8hpFq0uRRZZqlCprlhwH2wz
        4gASyEj0i+izjLWcV2kPwyd7w1GrYrn8LNfxKfSU1Q==
X-Google-Smtp-Source: AGHT+IFGnkZ+XyW3GndBJ1x648GkPWYfAZxpuBsAvAKyuAdjCKL9QN6uVjs7JFA1iNZNYwXAxKxzFQ==
X-Received: by 2002:aa7:c394:0:b0:522:afec:3ca5 with SMTP id k20-20020aa7c394000000b00522afec3ca5mr3087676edq.28.1694028996775;
        Wed, 06 Sep 2023 12:36:36 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id d4-20020a50ea84000000b00521d2f7459fsm8714471edo.49.2023.09.06.12.36.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 12:36:36 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so150918a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 12:36:35 -0700 (PDT)
X-Received: by 2002:a05:6402:334:b0:525:6d6e:ed4a with SMTP id
 q20-20020a056402033400b005256d6eed4amr3250657edw.23.1694028995634; Wed, 06
 Sep 2023 12:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
In-Reply-To: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Sep 2023 12:36:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
Message-ID: <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So I'm starting to look at this because I have most other pull
requests done, and while I realize there's no universal support for it
I suspect any further changes are better done in-tree. The out-of-tree
thing has been done.

However, while I'll continue to look at it in this form, I just
realized that it's completely unacceptable for one very obvious
reason:

On Sat, 2 Sept 2023 at 20:26, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
>   https://evilpiepirate.org/git/bcachefs.git bcachefs-for-upstream

No way am I pulling that without a signed tag and a pgp key with a
chain of trust. You've been around for long enough that having such a
key shouldn't be a problem for you, so make it happen.

There are a few other issues that I have with this, and Christoph did
mention a big one: it's not been in linux-next. I don't know why I
thought it had been, it's just such an obvious thing for any new "I
want this merged upstream" tree.

So these kinds of "I'll just ignore _all_ basic rules" kinds of issues
do annoy me.

I need to know that you understand that if you actually want this
upstream, you need to work with upstream.

That very much means *NOT* continuing this "I'll just do it my way".
You need to show that you can work with others, that you can work
within the framework of upstream, and that not every single thread you
get into becomes an argument.

This, btw, is not negotiable.  If you feel uncomfortable with that
basic notion, you had better just continue doing development outside
the main kernel tree for another decade.

The fact that I only now notice that you never submitted this to
linux-next is obviously on me. My bad.

But at the same time it worries me that it might be a sign of you just
thinking that your way is special.

                Linus
