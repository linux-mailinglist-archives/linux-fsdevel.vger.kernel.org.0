Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C0158942B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 23:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiHCVzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiHCVzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:55:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033D85B07B;
        Wed,  3 Aug 2022 14:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F1A6159C;
        Wed,  3 Aug 2022 21:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD42C433C1;
        Wed,  3 Aug 2022 21:54:58 +0000 (UTC)
Date:   Wed, 3 Aug 2022 17:54:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git pile 3 - dcache
Message-ID: <YuruqoGHJONpdZcK@home.goodmis.org>
References: <YurA3aSb4GRr4wlW@ZenIV>
 <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 03, 2022 at 11:57:27AM -0700, Linus Torvalds wrote:
> 
> I really dislike this pattern:
> 
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 preempt_disable();
>        ...
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 preempt_enable();
> 
> and while the new comment explains *why* it exists, it's still very ugly indeed.
> 
> We have it in a couple of other places, and we also end up having
> another variation on the theme that is about "migrate_{dis,en}able()",
> except it is written as
> 
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 migrate_disable();
>         else
>                 preempt_disable();
> 
> because on non-PREEMPT_RT obviously preempt_disable() is the better
> and simpler thing.
> 
> Can we please just introduce helper functions?
> 
> At least that
> 
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 preempt_disable();
>         ...
> 
> pattern could be much more naturally expressed as
> 
>         preempt_disable_under_spinlock();
>         ...
>

The original patch years ago use to have:

 preempt_disable_rt()

 preempt_enable_rt()


That did exactly that, but an effort was made to get rid of it. But your more
descriptive "preempt_enable/disable_under_spinlock()" may make more sense.

-- Steve

