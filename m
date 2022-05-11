Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0925228DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 03:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiEKBSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 21:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbiEKBSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 21:18:18 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B453C58E4C
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 18:18:16 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 11 May 2022 10:18:15 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 11 May 2022 10:18:14 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Wed, 11 May 2022 10:16:37 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     tytso@mit.edu
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com,
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
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
Message-ID: <20220511011637.GC18445@X58A-UD3R>
References: <YnnAnzPFZZte/UR8@mit.edu>
 <1652161060-26531-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652161060-26531-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 02:37:40PM +0900, Byungchul Park wrote:
> Ted wrote:
> > On Tue, May 10, 2022 at 09:32:13AM +0900, Byungchul Park wrote:
> > > DEPT is tracking way more objects than Lockdep so it's inevitable to be
> > > slower, but let me try to make it have the similar performance to
> > > Lockdep.
> > 
> > In order to eliminate some of these false positives, I suspect it's
> > going to increase the number of object classes that DEPT will need to
> > track even *more*.  At which point, the cost/benefit of DEPT may get
> > called into question, especially if all of the false positives can't
> > be suppressed.
> 
> Look. Let's talk in general terms. There's no way to get rid of the
> false positives all the way. It's a decision issue for *balancing*
> between considering potential cases and only real ones. Definitely,
> potential is not real. The more potential things we consider, the higher
> the chances are, that false positives appear.
> 
> But yes. The advantage we'd take by detecting potential ones should be
> higher than the risk of being bothered by false ones. Do you think a
> tool is useless if it produces a few false positives? Of course, it'd
> be a problem if it's too many, but otherwise, I think it'd be a great
> tool if the advantage > the risk.
> 
> Don't get me wrong here. It doesn't mean DEPT is perfect for now. The
> performance should be improved and false alarms that appear should be
> removed, of course. I'm talking about the direction.
> 
> For now, there's no tool to track wait/event itself in Linux kernel -
> a subset of the functionality exists tho. DEPT is the 1st try for that
> purpose and can be a useful tool by the right direction.
> 
> I know what you are concerning about. I bet it's false positives that
> are going to bother you once merged. I'll insist that DEPT shouldn't be
> used as a mandatory testing tool until considered stable enough. But
> what about ones who would take the advantage use DEPT. Why don't you
> think of folks who will take the advantage from the hints about
> dependency of synchronization esp. when their subsystem requires very
> complicated synchronization? Should a tool be useful only in a final
> testing stage? What about the usefulness during development stage?
> 
> It's worth noting DEPT works with any wait/event so any lockups e.g.
> even by HW-SW interface, retry logic or the like can be detected by DEPT
> once all waits and events are tagged properly. I believe the advantage
> by that is much higher than the bad side facing false alarms. It's just
> my opinion. I'm goning to respect the majority opinion.

s/take advantage/have the benefit/g

	Byungchul
