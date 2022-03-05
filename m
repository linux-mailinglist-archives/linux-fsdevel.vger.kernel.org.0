Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245394CE532
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 15:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiCEOQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 09:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiCEOQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:16:58 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAFFC22F960
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Mar 2022 06:16:03 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 5 Mar 2022 23:16:01 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 5 Mar 2022 23:16:01 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Sat, 5 Mar 2022 23:15:38 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
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
Subject: Re: Report 2 in ext4 and journal based on v5.17-rc1
Message-ID: <20220305141538.GA31268@X58A-UD3R>
References: <YiAow5gi21zwUT54@mit.edu>
 <1646285013-3934-1-git-send-email-byungchul.park@lge.com>
 <YiDSabde88HJ/aTt@mit.edu>
 <20220304004237.GB6112@X58A-UD3R>
 <YiLYX0sqmtkTEM5U@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiLYX0sqmtkTEM5U@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 04, 2022 at 10:26:23PM -0500, Theodore Ts'o wrote:
> On Fri, Mar 04, 2022 at 09:42:37AM +0900, Byungchul Park wrote:
> > 
> > All contexts waiting for any of the events in the circular dependency
> > chain will be definitely stuck if there is a circular dependency as I
> > explained. So we need another wakeup source to break the circle. In
> > ext4 code, you might have the wakeup source for breaking the circle.
> > 
> > What I agreed with is:
> > 
> >    The case that 1) the circular dependency is unevitable 2) there are
> >    another wakeup source for breadking the circle and 3) the duration
> >    in sleep is short enough, should be acceptable.
> > 
> > Sounds good?
> 
> These dependencies are part of every single ext4 metadata update,
> and if there were any unnecessary sleeps, this would be a major
> performance gap, and this is a very well studied part of ext4.
> 
> There are some places where we sleep, sure.  In some case
> start_this_handle() needs to wait for a commit to complete, and the
> commit thread might need to sleep for I/O to complete.  But the moment
> the thing that we're waiting for is complete, we wake up all of the
> processes on the wait queue.  But in the case where we wait for I/O
> complete, that wakeupis coming from the device driver, when it
> receives the the I/O completion interrupt from the hard drive.  Is
> that considered an "external source"?  Maybe DEPT doesn't recognize
> that this is certain to happen just as day follows the night?  (Well,
> maybe the I/O completion interrupt might not happen if the disk drive
> bursts into flames --- but then, you've got bigger problems. :-)

Almost all you've been blaming at Dept are totally non-sense. Based on
what you're saying, I'm conviced that you don't understand how Dept
works even 1%. You don't even try to understand it before blame.

You don't have to understand and support it. But I can't response to you
if you keep saying silly things that way.

> In any case, if DEPT is going to report these "circular dependencies
> as bugs that MUST be fixed", it's going to be pure noise and I will
> ignore all DEPT reports, and will push back on having Lockdep replaced

Dept is going to be improved so that what you are concerning about won't
be reported.

> by DEPT --- because Lockdep give us actionable reports, and if DEPT

Right. Dept should give actionable reports, too.

> can't tell the difference between a valid programming pattern and a
> bug, then it's worse than useless.

Needless to say.

