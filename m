Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126217742DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjHHRv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHHRvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:51:05 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847EEB4F3A;
        Tue,  8 Aug 2023 09:22:51 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1ba5cda3530so4607646fac.3;
        Tue, 08 Aug 2023 09:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511749; x=1692116549;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GCxwlyhJ8vXEVNF+yz9sQrPr3bcnp/8Z+q3sGhYbKzY=;
        b=eyYEBmT8U9BS0g9YiDGnxXjtGCDVRksgzluqxEPtICdyaVdggKOALR63x2PcECwMqD
         5MoUQi8ERs4RlPVnesDEPYSjONko7qcfZsBrumb9x1K1/UMqvjU26Ho3PAwaGMrqkdsh
         ScPN/kEIF334KbdDY43rB1lWj1V2DpiRtRIlglLsvSyhGOtWHH4uZ5qZfSAujgW1vZQ3
         wGm3VnLKKWDjf9nVgnyUjvaCfERuKMc0GG8YbfU9/RuaYpguciP86d5QB2kAR0uTTagt
         8fxrg3rNl05BnC8H+imitZHN34Es5Hhjc+bJqnaV/XPK1IrQNBZJcvojPsbgPpxcMcCz
         2eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511749; x=1692116549;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCxwlyhJ8vXEVNF+yz9sQrPr3bcnp/8Z+q3sGhYbKzY=;
        b=mEqKU1IdgBfyNl3nJ6i5LmvNUWZWX6OPVsq16dBm+KPlSxwbVh8bvGkVG5oyr9oc7C
         9xlv4NG0DIN3a0zRu4cZ4JIw8WrknQLkJl2Pbjhk2UCd1TwuMmCwbzcJKcC9DZ4dedTx
         SWG2JvBQrvW2dpGEJJ7Cru9vGumjtQgeEbvGXMhf5Pl3yDUPkQsY8MQmcQ8b+Uqzxd7+
         D5wlBgWHMSz8pRqynJxaBXTRuOl6368guFB7s+XDhJeW2BL81LSk3KmtfkGfCLYN85Hb
         tbDWukcrhFivCsIMZtPefX96OBVre4D8S+fjNyP3q10E+y6CM34NMHar2hUE+C0hXHz/
         Q0rA==
X-Gm-Message-State: AOJu0YzL3KroaHJUozzC5NGGeeiKF092qAv0lcJqbHRirFK2BO7flWOT
        mjWq3YIKCkxLVXbMMzcZoeHAmn1mRgTWyvBAVEiv8Ihf/wE=
X-Google-Smtp-Source: AGHT+IGOOwkdjvLToEWmeAFn8PNhrCDb0D7BXur/JKENEzDLzdhvPs+JtGOveAYXQ4R3LxtNi3mUSqHtZes+Z+zHw9s=
X-Received: by 2002:a05:6870:612b:b0:1bd:55be:5880 with SMTP id
 s43-20020a056870612b00b001bd55be5880mr14170980oae.42.1691486507460; Tue, 08
 Aug 2023 02:21:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:696:0:b0:4f0:1250:dd51 with HTTP; Tue, 8 Aug 2023
 02:21:46 -0700 (PDT)
In-Reply-To: <20230808-unsensibel-scham-c61a71622ae7@brauner>
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <20230808-eingaben-lumpen-e3d227386e23@brauner> <CAGudoHF=cEvXy3v96dN_ruXHnPv33BA6fA+dCWCm-9L3xgMPNQ@mail.gmail.com>
 <20230808-unsensibel-scham-c61a71622ae7@brauner>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 8 Aug 2023 11:21:46 +0200
Message-ID: <CAGudoHEQ6Tq=88VKqurypjHqOzfU2eBmPts4+H8C7iNu96MRKQ@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/23, Christian Brauner <brauner@kernel.org> wrote:
>> I don't think perf tax on something becomes more sensible the longer
>> it is there.
>
> One does need to answer the question why it does suddenly become
> relevant after all these years though.
>

There is some work I'm considering doing, but before that happens I'm
sanity checking performance of various syscalls and I keep finding
problems, some of which are trivially avoidable.

I'm genuinely confused with the strong opposition to the very notion
of making close(2) a special case (which I consider conceptually
trivial), but as you noted below I'm not ultimately the person on the
hook for any problems.

> The original discussion was triggered by fifo ordering in task work
> which led to a noticable regression and why it was ultimately reverted.
> The sync proposal for fput() was an orthogonal proposal and the
> conclusion was that it wasn't safe generally
> https://lore.kernel.org/all/20150905051915.GC22011@ZenIV.linux.org.uk
> even though it wasn't a direct response to the patch you linked.
>

Ok, I missed this e-mail. It further discourages patching filp_close,
but does not make an argument against *just* close(2) rolling with
sync which is what I'm proposing.

> If you care about it enough send a patch that just makes close(2) go
> sync.

But this is precisely what the submitted patch is doing. It adds
file_fput_sync, then adds close_fd_sync which is the only consumer and
only makes close(2) use it. *nobody* else has sync added.

One can argue the way this is sorted out is crap and I'm not going to
defend it. I am saying making *just* close(2) roll with sync is very
easy, there are numerous ways to do it and anyone involved with
maintaining vfs can write their own variant in minutes. Basically I
don't see *technical* problems here.

> We'll stuff it in a branch and we'll see what LKP has to say about
> it or whether this gets lost in noise. I really don't think letting
> micro-benchmarks become a decisive factor for code churn is a good
> idea.
>

That would be nice. Given the patch is already doing what you asked,
can you just take it as is?

I'll note though what I mentioned elsewhere
(https://lore.kernel.org/all/CAGudoHEG7vtCRWjn0yR5LMUsaw3KJANfa+Hkke9gy0imXQz6tg@mail.gmail.com/):
can they make sure to whack CONFIG_RANDOMIZE_KSTACK_OFFSET=y from
their kernel config? It is an *optional* measure and it comes at a
massive premium, so single-threaded changes are easily diminished.

-- 
Mateusz Guzik <mjguzik gmail.com>
