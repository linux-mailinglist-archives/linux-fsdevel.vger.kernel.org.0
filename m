Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D284752D032
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 12:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiESKL2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiESKL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 06:11:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C05A33A22;
        Thu, 19 May 2022 03:11:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72B3D619A6;
        Thu, 19 May 2022 10:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A385C385AA;
        Thu, 19 May 2022 10:11:14 +0000 (UTC)
Date:   Thu, 19 May 2022 11:11:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
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
Message-ID: <YoYXvsgVJwwaWrrZ@arm.com>
References: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
 <1651795895-8641-1-git-send-email-byungchul.park@lge.com>
 <YnYd0hd+yTvVQxm5@hyeyoo>
 <20220509001637.GA6047@X58A-UD3R>
 <YnpJ9Mtf+pjx4JYm@hyeyoo>
 <20220510233929.GB18445@X58A-UD3R>
 <YnuKQ9UIhk9WYoz7@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnuKQ9UIhk9WYoz7@hyeyoo>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 07:04:51PM +0900, Hyeonggon Yoo wrote:
> On Wed, May 11, 2022 at 08:39:29AM +0900, Byungchul Park wrote:
> > On Tue, May 10, 2022 at 08:18:12PM +0900, Hyeonggon Yoo wrote:
> > > On Mon, May 09, 2022 at 09:16:37AM +0900, Byungchul Park wrote:
> > > > CASE 1.
> > > > 
> > > >    lock L with depth n
> > > >    lock_nested L' with depth n + 1
> > > >    ...
> > > >    unlock L'
> > > >    unlock L
> > > > 
> > > > This case is allowed by Lockdep.
> > > > This case is allowed by DEPT cuz it's not a deadlock.
> > > > 
> > > > CASE 2.
> > > > 
> > > >    lock L with depth n
> > > >    lock A
> > > >    lock_nested L' with depth n + 1
> > > >    ...
> > > >    unlock L'
> > > >    unlock A
> > > >    unlock L
> > > > 
> > > > This case is allowed by Lockdep.
> > > > This case is *NOT* allowed by DEPT cuz it's a *DEADLOCK*.
> > > 
> > > Yeah, in previous threads we discussed this [1]
> > > 
> > > And the case was:
> > > 	scan_mutex -> object_lock -> kmemleak_lock -> object_lock
> > > And dept reported:
> > > 	object_lock -> kmemleak_lock, kmemleak_lock -> object_lock as
> > > 	deadlock.
> > > 
> > > But IIUC - What DEPT reported happens only under scan_mutex and it
> > > is not simple just not to take them because the object can be
> > > removed from the list and freed while scanning via kmemleak_free()
> > > without kmemleak_lock and object_lock.

The above kmemleak sequence shouldn't deadlock since those locks, even
if taken in a different order, are serialised by scan_mutex. For various
reasons, trying to reduce the latency, I ended up with some
fine-grained, per-object locking.

For object allocation (rbtree modification) and tree search, we use
kmemleak_lock. During scanning (which can take minutes under
scan_mutex), we want to prevent (a) long latencies and (b) freeing the
object being scanned. We release the locks regularly for (a) and hold
the object->lock for (b).

In another thread Byungchul mentioned:

|    context X			context Y
| 
|    lock mutex A		lock mutex A
|    lock B			lock C
|    lock C			lock B
|    unlock C			unlock B
|    unlock B			unlock C
|    unlock mutex A		unlock mutex A
| 
| In my opinion, lock B and lock C are unnecessary if they are always
| along with lock mutex A. Or we should keep correct lock order across all
| the code.

If these are the only two places, yes, locks B and C would be
unnecessary. But we have those locks acquired (not nested) on the
allocation path (kmemleak_lock) and freeing path (object->lock). We
don't want to block those paths while scan_mutex is held.

That said, we may be able to use a single kmemleak_lock for everything.
The object freeing path may be affected slightly during scanning but the
code does release it every MAX_SCAN_SIZE bytes. It may even get slightly
faster as we'd hammer a single lock (I'll do some benchmarks).

But from a correctness perspective, I think the DEPT tool should be
improved a bit to detect when such out of order locking is serialised by
an enclosing lock/mutex.

-- 
Catalin
