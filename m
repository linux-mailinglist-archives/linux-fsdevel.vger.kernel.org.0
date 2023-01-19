Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A0672DC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 01:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjASA6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 19:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjASA6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:58:43 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E51F3683D9
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 16:58:41 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 19 Jan 2023 09:58:39 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 19 Jan 2023 09:58:39 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, duyuyang@gmail.com,
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
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
Date:   Thu, 19 Jan 2023 09:58:27 +0900
Message-Id: <1674089907-31690-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
References: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Torvalds wrote:
> On Sun, Jan 8, 2023 at 7:33 PM Byungchul Park <byungchul.park@lge.com> wrote:
>>
>> I've been developing a tool for detecting deadlock possibilities by
>> tracking wait/event rather than lock(?) acquisition order to try to
>> cover all synchonization machanisms. It's done on v6.2-rc2.
> 
> Ugh. I hate how this adds random patterns like

I undertand what you mean.. But all the synchronization primitives
should let DEPT know the beginning and the end of each. However, I will
remove the 'if' statement that looks ugly from the next spin, and place
the pattern to a better place if possible.

> 	if (timeout == MAX_SCHEDULE_TIMEOUT)
> 		sdt_might_sleep_strong(NULL);
> 	else
> 		sdt_might_sleep_strong_timeout(NULL);
> 	...
> 	sdt_might_sleep_finish();
> 
> to various places, it seems so very odd and unmaintainable.
> 
> I also recall this giving a fair amount of false positives, are they all fixed?

Yes. Of course I removed all the false positives we found.

> Anyway, I'd really like the lockdep people to comment and be involved.
> We did have a fairly recent case of "lockdep doesn't track page lock
> dependencies because it fundamentally cannot" issue, so DEPT might fix
> those kinds of missing dependency analysis. See

Sure. That's exactly what DEPT works for e.g. PG_locked.

> 	https://lore.kernel.org/lkml/00000000000060d41f05f139aa44@google.com/

I will reproduce it and share the result.

> for some context to that one, but at teh same time I would *really*
> want the lockdep people more involved and acking this work.
> 
> Maybe I missed the email where you reported on things DEPT has found
> (and on the lack of false positives)?

Maybe you didn't miss. It's still too hard to make a decision between:

	Aggressive detection with false alarms that need to be fixed by
	manual classification as Lockdep did, focusing on potential
	possibility more.

	versus

	Conservative detection with few false alarms, which requires us
	to test much longer to get result we expect, focusing on actual
	happening.

> 
> 	Linus

	Byungchul
