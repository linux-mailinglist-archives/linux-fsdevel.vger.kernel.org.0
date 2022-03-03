Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBE44CB4DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 03:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiCCCX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 21:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiCCCXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:23:23 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5893B22B35
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 18:22:32 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 3 Mar 2022 11:22:29 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 3 Mar 2022 11:22:29 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 3 Mar 2022 11:22:08 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
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
        melissa.srw@gmail.com, hamohammed.sa@gmail.com
Subject: Re: [PATCH v3 00/21] DEPT(Dependency Tracker)
Message-ID: <20220303022208.GA20956@X58A-UD3R>
References: <1646042220-28952-1-git-send-email-byungchul.park@lge.com>
 <Yh70VkRkUfwIjPWv@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh70VkRkUfwIjPWv@ip-172-31-19-208.ap-northeast-1.compute.internal>
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

On Wed, Mar 02, 2022 at 04:36:38AM +0000, Hyeonggon Yoo wrote:
> On Mon, Feb 28, 2022 at 06:56:39PM +0900, Byungchul Park wrote:
> > I didn't want to bother you so I was planning to send the next spin
> > after making more progress. However, PATCH v2 reports too many false
> > positives because Dept tracked the bit_wait_table[] wrong way - I
> > apologize for that. So I decided to send PATCH v3 first before going
> > further for those who want to run Dept for now.
> > 
> > There might still be some false positives but not overwhelming.
> >
> 
> Hello Byungchul, I'm running DEPT v3 on my system
> and I see report below.
> 
> Looking at the kmemleak code and comment, I think
> kmemleak tried to avoid lockdep recursive warning
> but detected by DEPT?
> 
> ===================================================
> DEPT: Circular dependency has been detected.
> 5.17.0-rc1+ #1 Tainted: G        W
> ---------------------------------------------------
> summary
> ---------------------------------------------------
> *** AA DEADLOCK ***
> 
> context A
>     [S] __raw_spin_lock_irqsave(&object->lock:0)
>     [W] _raw_spin_lock_nested(&object->lock:0)
>     [E] spin_unlock(&object->lock:0)
> 
> [S]: start of the event context
> [W]: the wait blocked
> [E]: the event not reachable
> ---------------------------------------------------
> context A's detail
> ---------------------------------------------------
> context A
>     [S] __raw_spin_lock_irqsave(&object->lock:0)
>     [W] _raw_spin_lock_nested(&object->lock:0)
>     [E] spin_unlock(&object->lock:0)
> 
> [S] __raw_spin_lock_irqsave(&object->lock:0):
> [<ffffffc00810302c>] scan_gray_list+0x84/0x13c
> stacktrace:
>       dept_ecxt_enter+0x88/0xf4
>       _raw_spin_lock_irqsave+0xf0/0x1c4
>       scan_gray_list+0x84/0x13c
>       kmemleak_scan+0x2d8/0x54c
>       kmemleak_scan_thread+0xac/0xd4
>       kthread+0xd4/0xe4
>       ret_from_fork+0x10/0x20

[W]'s stack trace is missed. But I guess this issue is the same issue of
what you reported following this one. We can discuss this issue on the
other report's thread.

Thanks,
Byunghcul

> [E] spin_unlock(&object->lock:0):
> [<ffffffc008102ee0>] scan_block+0x60/0x128
> ---------------------------------------------------
> information that might be helpful
> ---------------------------------------------------
> CPU: 1 PID: 38 Comm: kmemleak Tainted: G        W         5.17.0-rc1+ #1
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace.part.0+0x9c/0xc4
>  show_stack+0x14/0x28
>  dump_stack_lvl+0x9c/0xcc
>  dump_stack+0x14/0x2c
>  print_circle+0x2d4/0x438
>  cb_check_dl+0x44/0x70
>  bfs+0x60/0x168
>  add_dep+0x88/0x11c
>  add_wait+0x2d0/0x2dc
>  __dept_wait+0x8c/0xa4
>  dept_wait+0x6c/0x88
>  _raw_spin_lock_nested+0xa8/0x1b0
>  scan_block+0xb4/0x128
>  scan_gray_list+0xc4/0x13c
>  kmemleak_scan+0x2d8/0x54c
>  kmemleak_scan_thread+0xac/0xd4
>  kthread+0xd4/0xe4
>  ret_from_fork+0x10/0x20
> 
> > ---
> > 
> > Hi Linus and folks,
> > 
> > I've been developing a tool for detecting deadlock possibilities by
> > tracking wait/event rather than lock(?) acquisition order to try to
> > cover all synchonization machanisms. It's done on v5.17-rc1 tag.
> > 
> > https://github.com/lgebyungchulpark/linux-dept/commits/dept1.14_on_v5.17-rc1
> >
> [...]
> > Benifit:
> > 
> > 	0. Works with all lock primitives.
> > 	1. Works with wait_for_completion()/complete().
> > 	2. Works with 'wait' on PG_locked.
> > 	3. Works with 'wait' on PG_writeback.
> > 	4. Works with swait/wakeup.
> > 	5. Works with waitqueue.
> > 	6. Multiple reports are allowed.
> > 	7. Deduplication control on multiple reports.
> > 	8. Withstand false positives thanks to 6.
> > 	9. Easy to tag any wait/event.
> > 
> > Future work:
> > 
> > 	0. To make it more stable.
> > 	1. To separates Dept from Lockdep.
> > 	2. To improves performance in terms of time and space.
> > 	3. To use Dept as a dependency engine for Lockdep.
> > 	4. To add any missing tags of wait/event in the kernel.
> > 	5. To deduplicate stack trace.
> > 
> > How to interpret reports:
> > 
> > 	1. E(event) in each context cannot be triggered because of the
> > 	   W(wait) that cannot be woken.
> > 	2. The stack trace helping find the problematic code is located
> > 	   in each conext's detail.
> > 
> > Thanks,
> > Byungchul
> > 
> > ---
> > 
> > Changes from v2:
> > 
> > 	1. Disable Dept on bit_wait_table[] in sched/wait_bit.c
> > 	   reporting a lot of false positives, which is my fault.
> > 	   Wait/event for bit_wait_table[] should've been tagged in a
> > 	   higher layer for better work, which is a future work.
> > 	   (feedback from Jan Kara)
> > 	2. Disable Dept on crypto_larval's completion to prevent a false
> > 	   positive.
> > 
> > Changes from v1:
> > 
> > 	1. Fix coding style and typo. (feedback from Steven)
> > 	2. Distinguish each work context from another in workqueue.
> > 	3. Skip checking lock acquisition with nest_lock, which is about
> > 	   correct lock usage that should be checked by Lockdep.
> > 
> > Changes from RFC:
> > 
> > 	1. Prevent adding a wait tag at prepare_to_wait() but __schedule().
> > 	   (feedback from Linus and Matthew)
> > 	2. Use try version at lockdep_acquire_cpus_lock() annotation.
> > 	3. Distinguish each syscall context from another.
> [ ... ] 
> 
> -- 
> Thank you, You are awesome!
> Hyeonggon :-)
