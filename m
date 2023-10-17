Return-Path: <linux-fsdevel+bounces-530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD87CC5BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 16:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7552819F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248843AA7;
	Tue, 17 Oct 2023 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2XvqQfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579243A84
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 14:17:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F7CFD;
	Tue, 17 Oct 2023 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZrpZDwfysdaLF96tjupfAFmYhqWMtpjSOZplJCsp7DI=; b=A2XvqQfwa4LL9+gK+9c6c+t90e
	X04jGQ5YO+KFT3QdjPV5ARmMkuNS3t2K+vO/TqdSmH7dLaxZp3wF9gy76rGMupD79KrE+2lQiRlmk
	L4f9p7WpYHrC1oUAR/Fc3qL9+BMrIVEGcjNSxo8FhfFsba8jy3uL9f2DgIJn99CYsnrNxlqu7oVb2
	3a1Qy004P5+Lw/pbszbyfSb2KGpTOU1JSwmqd7rE9d3frS+zpiIKOQ6D2OxjX96Ud0nQ7+dijbqc5
	hIiKEyanq1E8zjfYZabzKcfDOFek4MGYzlrqbuj92XXtRREiYHSMYYXg/yKo45vjKOZfb9Yval5S/
	ksfpsP2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qsksN-0079Qq-0F;
	Tue, 17 Oct 2023 14:16:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC7A7300194; Tue, 17 Oct 2023 16:16:50 +0200 (CEST)
Date: Tue, 17 Oct 2023 16:16:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, bsegall@google.com, dvyukov@google.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, nogikh@google.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in console_flush_all (2)
Message-ID: <20231017141650.GC1599@noisy.programming.kicks-ass.net>
References: <000000000000e40a2906072e9567@google.com>
 <000000000000bc00ea0607e9359d@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000bc00ea0607e9359d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 06:07:50AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    213f891525c2 Merge tag 'probes-fixes-v6.6-rc6' of git://gi..

> list_add corruption. next->prev should be prev (ffff8880b993d228), but was caff904900000000. (next=ffff8880783659f8).

Urgh, I've not seen that happen before. How reliable does this trigger?

>  __list_add_valid_or_report+0xa2/0x100 lib/list_debug.c:29
>  __list_add_valid include/linux/list.h:88 [inline]
>  __list_add include/linux/list.h:150 [inline]
>  list_add include/linux/list.h:169 [inline]
>  account_entity_enqueue kernel/sched/fair.c:3534 [inline]
>  enqueue_entity+0x97b/0x1490 kernel/sched/fair.c:5117
>  enqueue_task_fair+0x15b/0xbc0 kernel/sched/fair.c:6536
>  enqueue_task kernel/sched/core.c:2102 [inline]
>  activate_task kernel/sched/core.c:2132 [inline]
>  ttwu_do_activate+0x214/0xd90 kernel/sched/core.c:3787
>  ttwu_queue kernel/sched/core.c:4029 [inline]
>  try_to_wake_up+0x8e7/0x15b0 kernel/sched/core.c:4346
>  autoremove_wake_function+0x16/0x150 kernel/sched/wait.c:424
>  __wake_up_common+0x140/0x5a0 kernel/sched/wait.c:107
>  __wake_up_common_lock+0xd6/0x140 kernel/sched/wait.c:138
>  wake_up_klogd_work_func kernel/printk/printk.c:3840 [inline]
>  wake_up_klogd_work_func+0x90/0xa0 kernel/printk/printk.c:3829
>  irq_work_single+0x1b5/0x260 kernel/irq_work.c:221
>  irq_work_run_list kernel/irq_work.c:252 [inline]
>  irq_work_run_list+0x92/0xc0 kernel/irq_work.c:235
>  update_process_times+0x1d5/0x220 kernel/time/timer.c:2074
>  tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:254
>  tick_sched_timer+0xe9/0x110 kernel/time/tick-sched.c:1492
>  __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
>  __hrtimer_run_queues+0x647/0xc10 kernel/time/hrtimer.c:1752
>  hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1063 [inline]
>  __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:1080
>  sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1074
>  </IRQ>

