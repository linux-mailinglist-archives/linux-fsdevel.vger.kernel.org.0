Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014075895A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 03:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbiHDBdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 21:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiHDBdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 21:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E07D5A3EF;
        Wed,  3 Aug 2022 18:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 156166175E;
        Thu,  4 Aug 2022 01:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951A6C433C1;
        Thu,  4 Aug 2022 01:32:57 +0000 (UTC)
Date:   Wed, 3 Aug 2022 21:32:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git pile 3 - dcache
Message-ID: <20220803213255.3ab719e3@gandalf.local.home>
In-Reply-To: <YusV8cr382PeBNLM@casper.infradead.org>
References: <YurA3aSb4GRr4wlW@ZenIV>
        <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
        <YuruqoGHJONpdZcK@home.goodmis.org>
        <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
        <20220803185936.228dc690@gandalf.local.home>
        <YusDmF39ykDmfSkF@casper.infradead.org>
        <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
        <YusV8cr382PeBNLM@casper.infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 4 Aug 2022 01:42:25 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> > So let's make it verbose and clear and unambiguous. It's not like I
> > expect to see a _lot_ of those. Knock wood.  
> 
> Should we have it take a spinlock_t pointer?  We could have lockdep
> check it is actually held.

We don't care if the lock is held or not. The point of the matter is that
spinlocks in RT do not disable preemption. The code that the
preempt_disable_under_spinlock() is inside, can not be preempted. If it is,
bad things can happen.

Currently this code assumes that spinlocks disable preemption, so there's
no need to disable preemption here. But in RT, just holding the spinlock is
not enough to disable preemption, hence we need to explicitly call it here.

As Linus's name suggests, the "preempt_enable_under_spinlock" is to make
sure preemption is disabled regardless if it's under a normal spinlock that
disables preemption, or a RT spinlock that does not.

I wonder if raw_preempt_disable() would be another name to use? We have
raw_spin_lock() to denote that it's a real spinlock even under PREEMPT_RT.
We could say that "raw_preempt_disable()" makes sure the location really
has preemption disabled regardless of PREEMPT_RT.

-- Steve
