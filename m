Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAE0589281
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 20:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbiHCS5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 14:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiHCS5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:57:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF283CBEC
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Aug 2022 11:57:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w3so6962258edc.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Aug 2022 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/dqFZCHimKdfgJ5h2Hr/dgVrJv3glvLsMO7a64z+Kfw=;
        b=EVf6K6yS1s/uIkLCTDq/IPckjNF1FRgd+BEcICTHa2dhO1BuQMok9ES/sWfkORPWD9
         72cZfMHbz0woORa8syTupSGqbMlAQt16vp4Mjcz6+RL2EJNtdOfihZO7wX6ZryjGL/mV
         kwPnHvH3UEYHQZ7IBtgQmfGVkUXinWJgrYiKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/dqFZCHimKdfgJ5h2Hr/dgVrJv3glvLsMO7a64z+Kfw=;
        b=xjOnJDj83RjZTqzK1idr7OyKB8KKpbC1FzhSmF8g71tWzJkwIEB7B5CYRYxnePawe0
         6BqGZoQhoW8WXeSF5KbMKrFah3gws/pWEVdaUmBIir+ta3YvfBOCsfKgJCR//NOhMzCE
         vFJHkORWFMz+f3XvGtuRA0jC0jbtCSybCTbxuAXHFmVURzKRzYyA5/3xzXRzI7qQRzAT
         q13eSAqe9QNxtFg0T9uJi4yu9ykgW4YNmu/yFzuPxK8vB9wRocvxkJyxSMmUvwIwhW6w
         rF0llnPvLvsPr1Z5xT+7c/T3XI00OB3ALA6eOK8iO734L2YG9IpmOnAaVja9K4XyhrKZ
         ndtw==
X-Gm-Message-State: AJIora++1J/gYKaNsQYYYO/+/TAKnvW4TvoW/8e/I+3mJukZp7uwHnGP
        5ABEWIAXyHhczZUAZnGafeKex4pPc3uGe/IU
X-Google-Smtp-Source: AGRyM1tM7WNabshdFE+dLgvg5O1z+cOBQAYzm3CL2xeEP1d8YpTDFL+mlvAcVTBcuPkdiNGPp5r6lw==
X-Received: by 2002:a05:6402:3707:b0:437:61f9:57a9 with SMTP id ek7-20020a056402370700b0043761f957a9mr26451089edb.1.1659553065297;
        Wed, 03 Aug 2022 11:57:45 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id kx18-20020a170907775200b00722e50dab2csm7502980ejc.109.2022.08.03.11.57.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 11:57:44 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id z17so17907103wrq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Aug 2022 11:57:44 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr16553047wrw.281.1659553063979; Wed, 03
 Aug 2022 11:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <YurA3aSb4GRr4wlW@ZenIV>
In-Reply-To: <YurA3aSb4GRr4wlW@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 11:57:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
Message-ID: <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git pile 3 - dcache
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Wed, Aug 3, 2022 at 11:39 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Main part here is making parallel lookups safe for RT - making
> sure preemption is disabled in start_dir_add()/ end_dir_add() sections (on
> non-RT it's automatic, on RT it needs to to be done explicitly) and moving
> wakeups from __d_lookup_done() inside of such to the end of those sections.

Ugh.

I really dislike this pattern:

        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                preempt_disable();
       ...
        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                preempt_enable();

and while the new comment explains *why* it exists, it's still very ugly indeed.

We have it in a couple of other places, and we also end up having
another variation on the theme that is about "migrate_{dis,en}able()",
except it is written as

        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                migrate_disable();
        else
                preempt_disable();

because on non-PREEMPT_RT obviously preempt_disable() is the better
and simpler thing.

Can we please just introduce helper functions?

At least that

        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                preempt_disable();
        ...

pattern could be much more naturally expressed as

        preempt_disable_under_spinlock();
        ...

which would make the code really explain what is going on. I would
still encourage that *comment* about it, but I think we really should
strive for code that makes sense even without a comment.

The fact that then without PREEMPT_RT, the whole
"preempt_disable_under_spinlock()" becomes a no-op is then an
implementation detail - and not so different from how a regular
preempt_disable() becomes a no-op when on UP (or with PREEMPT_NONE).

And that "preempt_disable_under_spinlock()" really documents what is
going on, and I feel would make that code easier to understand? The
fact that PREEMPT_RT has different rules about preemption is not
something that the dentry code should care about.

The dentry code could just say "I want to disable preemption, and I
already hold a spinlock, so do what is best".

So then "preempt_disable_under_spinlock()" precisely documents what
the dentry code really wants.

No?

Anyway, I have pulled this, but I really would like fewer of these
random PREEMPT_RT turds around, and more "this code makes sense" code.

                Linus
