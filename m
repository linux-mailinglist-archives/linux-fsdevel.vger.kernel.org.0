Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF051CDB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 02:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387225AbiEFAQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 20:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384126AbiEFAQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 20:16:52 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21D3651E73
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 17:13:09 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 6 May 2022 09:13:07 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 6 May 2022 09:13:07 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jack@suse.com,
        jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        djwong@kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
Date:   Fri,  6 May 2022 09:11:35 +0900
Message-Id: <1651795895-8641-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
References: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus wrote:
>
> On Wed, May 4, 2022 at 1:19 AM Byungchul Park <byungchul.park@lge.com> wrote:
> >
> > Hi Linus and folks,
> >
> > I've been developing a tool for detecting deadlock possibilities by
> > tracking wait/event rather than lock(?) acquisition order to try to
> > cover all synchonization machanisms.
> 
> So what is the actual status of reports these days?
> 
> Last time I looked at some reports, it gave a lot of false positives
> due to mis-understanding prepare_to_sleep().

Yes, it was. I handled the case in the following way:

1. Stage the wait at prepare_to_sleep(), which might be used at commit.
   Which has yet to be an actual wait that Dept considers.
2. If the condition for sleep is true, the wait will be committed at
   __schedule(). The wait becomes an actual one that Dept considers.
3. If the condition is false and the task gets back to TASK_RUNNING,
   clean(=reset) the staged wait.

That way, Dept only works with what actually hits to __schedule() for
the waits through sleep.

> For this all to make sense, it would need to not have false positives
> (or at least a very small number of them together with a way to sanely

Yes. I agree with you. I got rid of them that way I described above.

> get rid of them), and also have a track record of finding things that
> lockdep doesn't.

I have some reports that wait_for_completion or waitqueue is involved.
It's worth noting those are not tracked by Lockdep. I'm checking if
those are true positive or not. I will share those reports once I get
more convinced for that.

> Maybe such reports have been sent out with the current situation, and
> I haven't seen them.

Dept reports usually have been sent to me privately, not in LKML. As I
told you, I'm planning to share them.

	Byungchul

> 
>                  Linus
> 
