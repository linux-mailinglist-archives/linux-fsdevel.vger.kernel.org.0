Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3685892E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 21:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiHCTtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 15:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiHCTti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:49:38 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36177248FB;
        Wed,  3 Aug 2022 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZWxbbnA21y0t6xKiYRqKvDsF1ANgoMiT3UqVXr62jW8=; b=mkpdGKKxh/8AWrjM3cHiHjNIQn
        Ncudfbw+CQQ1JyuOtXr9PQBC/D+yGe1fRbeskX1lECGyAhuLhsrROwwPe1YUbgd8EbJTIpkL+oxUJ
        W9aAuOaYabYkjj8ekbFfAQGwGgNVoiujl1JPXV/g7+GhU4DjgyszZj2YCtwoo2X2pNcJkXMVVwQYk
        R9yQ8cTIRCjg9QDl81tQmncfWTxYjzni8CJ0MbGyqWo3rf9ARNli6tvUsLBCEZmZuQSFryB4iOaK+
        iiwhrMWr5aHClmKXr7t+jkGYubh5rZnMsPrd6h6hQuPEvg4mv8uUFulECuh0MFPoG7R/ucsMRxk1m
        jlR7Z3Sg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oJKN3-000va8-00;
        Wed, 03 Aug 2022 19:49:33 +0000
Date:   Wed, 3 Aug 2022 20:49:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git pile 3 - dcache
Message-ID: <YurRTBO40kil4Bw5@ZenIV>
References: <YurA3aSb4GRr4wlW@ZenIV>
 <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 03, 2022 at 11:57:27AM -0700, Linus Torvalds wrote:
> On Wed, Aug 3, 2022 at 11:39 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         Main part here is making parallel lookups safe for RT - making
> > sure preemption is disabled in start_dir_add()/ end_dir_add() sections (on
> > non-RT it's automatic, on RT it needs to to be done explicitly) and moving
> > wakeups from __d_lookup_done() inside of such to the end of those sections.
> 
> Ugh.
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
> which would make the code really explain what is going on. I would
> still encourage that *comment* about it, but I think we really should
> strive for code that makes sense even without a comment.
> 
> The fact that then without PREEMPT_RT, the whole
> "preempt_disable_under_spinlock()" becomes a no-op is then an
> implementation detail - and not so different from how a regular
> preempt_disable() becomes a no-op when on UP (or with PREEMPT_NONE).
> 
> And that "preempt_disable_under_spinlock()" really documents what is
> going on, and I feel would make that code easier to understand? The
> fact that PREEMPT_RT has different rules about preemption is not
> something that the dentry code should care about.
> 
> The dentry code could just say "I want to disable preemption, and I
> already hold a spinlock, so do what is best".
> 
> So then "preempt_disable_under_spinlock()" precisely documents what
> the dentry code really wants.
> 
> No?

Fine by me, but I think that this is better dealt with by the rt folks;
I've no objections to replacing that open-coded stuff in dcache.c with
better documented primitives, so when such patches materialize...
