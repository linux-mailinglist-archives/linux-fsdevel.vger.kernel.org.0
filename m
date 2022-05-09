Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F5C5209A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 01:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiEIXsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 19:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiEIXrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 19:47:32 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9160B266C83
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 16:40:15 -0700 (PDT)
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 10 May 2022 08:40:15 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.126 with ESMTP; 10 May 2022 08:40:14 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 10 May 2022 08:38:38 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
Message-ID: <20220509233838.GC6047@X58A-UD3R>
References: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
 <1651795895-8641-1-git-send-email-byungchul.park@lge.com>
 <YnYd0hd+yTvVQxm5@hyeyoo>
 <20220509001637.GA6047@X58A-UD3R>
 <20220509164712.746e236b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509164712.746e236b@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 04:47:12PM -0400, Steven Rostedt wrote:
> On Mon, 9 May 2022 09:16:37 +0900
> Byungchul Park <byungchul.park@lge.com> wrote:
> 
> > CASE 2.
> > 
> >    lock L with depth n
> >    lock A
> >    lock_nested L' with depth n + 1
> >    ...
> >    unlock L'
> >    unlock A
> >    unlock L
> > 
> > This case is allowed by Lockdep.
> > This case is *NOT* allowed by DEPT cuz it's a *DEADLOCK*.
> > 
> > ---
> > 
> > The following scenario would explain why CASE 2 is problematic.
> > 
> >    THREAD X			THREAD Y
> > 
> >    lock L with depth n
> > 				lock L' with depth n
> >    lock A
> > 				lock A
> >    lock_nested L' with depth n + 1
> 
> I'm confused by what exactly you are saying is a deadlock above.
> 
> Are you saying that lock A and L' are inversed? If so, lockdep had better

Hi Steven,

Yes, I was talking about A and L'.

> detect that regardless of L. A nested lock associates the the nesting with

When I checked Lockdep code, L' with depth n + 1 and L' with depth n
have different classes in Lockdep.

That's why I said Lockdep cannot detect it. By any chance, has it
changed so as to consider this case? Or am I missing something?

> the same type of lock. That is, in lockdep nested tells lockdep not to
> trigger on the L and L' but it will not ignore that A was taken.

It will not ignore A but it would work like this:

   THREAD X			THREAD Y

   lock Ln
				lock Ln
   lock A
				lock A
   lock_nested Lm
				lock_nested Lm

So, Lockdep considers this case safe, actually not tho.

	Byungchul

> 
> -- Steve
> 
> 
> 
> > 				lock_nested L'' with depth n + 1
> >    ...				...
> >    unlock L'			unlock L''
> >    unlock A			unlock A
> >    unlock L			unlock L'
