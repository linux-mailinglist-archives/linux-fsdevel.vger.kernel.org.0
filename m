Return-Path: <linux-fsdevel+bounces-40492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C68AA23E4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 14:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786EE166516
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FD71C5490;
	Fri, 31 Jan 2025 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJhIIxmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11C41C1F0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329841; cv=none; b=jo6Ly+teA9B02kCk6H843gZcVs1vTgDtQnEVpdDcWg1VU4jjlkAo38m2ZwUoOBj92aCFpv1cGagAXpeBri4l/JQ4TTWMB+KtwNUEGmxfzW1QJlebVHiO+hxIceQ5iXoX05CzQ/Bhyu56itJUkcxrczN1vbBXD/LElgsSEjKTW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329841; c=relaxed/simple;
	bh=FJ1C4RMO0SEeX6EDUORmsrKz4Q03g7bYy2b0FbqLXqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8NdY2CoeIoaBF2nBFyaaBtQm1tantNt8w3L0zpDz55pY9AXBkvMSL4fS8MpOycTvXSzbpC25z1gtmuNwfPNi1HFwiSFHIHZYCZxyBZFoKtvfOQ5BQkJwbRt8qE1vXnnb3Q6sP3MaNvJbm75FdRnP0kf+K0pysxOWvfQlNQLWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJhIIxmy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738329837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCBol3We8M/3Zpppbt6ubu72mHamNg9Ften2Jd/8He0=;
	b=MJhIIxmy0QFykHyiuTlk6vHqixTbGSAHNmohYHcE7Fmxcf6O15iHZbPIEPbkxv67kEbV5j
	gPIX+2qPalDVid27bQXCM6N3wUU+6ZJGs7ige7odwrtVILND1ZkmS9P/HmqMJPLntiBu7R
	k1IQZ7Vh2BMG5462ZH2mZv0FuFlYCG0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-mCrvCSH6OgSHDkdXG0hjtg-1; Fri,
 31 Jan 2025 08:23:52 -0500
X-MC-Unique: mCrvCSH6OgSHDkdXG0hjtg-1
X-Mimecast-MFC-AGG-ID: mCrvCSH6OgSHDkdXG0hjtg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F24091956083;
	Fri, 31 Jan 2025 13:23:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.119])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 05B201955F3B;
	Fri, 31 Jan 2025 13:23:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 31 Jan 2025 14:23:23 +0100 (CET)
Date: Fri, 31 Jan 2025 14:23:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250131132316.GA7563@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

(Add Oliver and Mateusz)

On 01/31, K Prateek Nayak wrote:
>
> On 1/2/2025 7:37 PM, Oleg Nesterov wrote:
> >wake_up(pipe->wr_wait) makes no sense if pipe_full() is still true after
> >the reading, the writer sleeping in wait_event(wr_wait, pipe_writable())
> >will check the pipe_writable() == !pipe_full() condition and sleep again.
> >
> >Only wake the writer if we actually released a pipe buf, and the pipe was
> >full before we did so.
>
> I noticed a performance regression in perf bench sched messaging at
> higher utilization (larger number of groups) with this patch on the
> mainline kernel. For lower utilization, this patch yields good
> improvements but once the system is oversubscribed, the tale flips.

Thanks a lot Prateek for your investigations.

I wasn't aware of tools/perf/bench/sched-messaging.c, but it seems
to do the same thing as hackbench. So this was already reported, plus
other "random" regressions and improvements caused by this patch. See
https://lore.kernel.org/all/202501201311.6d25a0b9-lkp@intel.com/

Yes, if the system is oversubscribed, then the early/unnecessary wakeup
is not necessarily bad, but I still can't fully understand why this patch
makes a noticeable difference in this case. I can't even understand why
(with or without this patch) the readers sleep on rd_wait MUCH more often
than the writers on wr_wait, may be because pipe_write() is generally
slower than pipe_read() ...

I promised to (try to) investigate on the previous weekend, but I am
a lazy dog, sorry! I'll try to do it on this weekend. Perhaps it would
be better to simply revert this patch...

As for the change you propose... At first glance it doesn't look right
to me, but this needs another discussion. At least it can be simplified
afaics. As for the waitqueue_active() check, it probably makes sense
(before wake_up) regardless, and this connects to another (confusing)
discussion, please see
https://lore.kernel.org/all/75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com/

Thanks!

Oleg.

> Following are the results from my testing on mainline at commit
> 05dbaf8dd8bf ("Merge tag 'x86-urgent-2025-01-28' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> with and without this patch:
>
>    ==================================================================
>     Test          : sched-messaging
>     cmdline       : perf bench sched messaging -p -t -l 100000 -g <groups>
>     Units         : Normalized time in seconds
>     Interpretation: Lower is better
>     Statistic     : AMean
>     ==================================================================
>     Case:         mainline[pct imp](CV)    revert[pct imp](CV)
>      1-groups     1.00 [ -0.00](12.29)     1.26 [-25.91]( 2.71)
>      2-groups     1.00 [ -0.00]( 3.64)     1.39 [-38.53]( 0.89)
>      4-groups     1.00 [ -0.00]( 3.33)     1.41 [-41.42]( 1.21)
>      8-groups     1.00 [ -0.00]( 2.90)     1.10 [ -9.89]( 0.95)
>     16-groups     1.00 [ -0.00]( 1.46)     0.66 [ 34.46]( 1.59)
>
> On my 3rd Generation EPYC system (2 x 64C/128T), I see that on reverting
> the changes on the above mentioned commit, sched-messaging sees a
> regression up until the 8 group case which contains 320 tasks, however
> with 16 groups (640 tasks), the revert helps with performance.
>
> Based on the trend in the performance, one can deduce that at lower
> utilization, sched-messaging benefits from not traversing the wake up
> path unnecessarily since wake_up_interruptible_sync_poll() acquires a
> lock before checking if the wait queue is empty or not thus saving on
> system time. However, at high utilization, there is likely a writer
> waiting to write to the pipe by the time the wait queue is inspected.
>
> Following are the perf profile comparing the mainline with the revert:
>
> o 1-group (4.604s [mainline] vs 8.163s [revert])
>
>     sudo ./perf record -C 0-7,64-127 -e ibs_op/cnt_ctl=1/ -- taskset -c 0-7,64-127 ./perf bench sched messaging -p -t -l 100000 -g 1
>
>     (sched-messaging was pinned to 1 CCX and only that CCX was profiled
>      using IBS to reduce noise)
>
> 							mainline			vs			revert
>
> Samples: 606K of event 'ibs_op/cnt_ctl=1/', Event count (approx.): 205972485144                        Samples: 479K of event 'ibs_op/cnt_ctl=1/', Event count (approx.): 200365591518
> Overhead  Command          Shared Object         Symbol                                                Overhead  Command          Shared Object         Symbol
>    4.80%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_safe_ret                                  5.12%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_safe_ret
>    4.10%  sched-messaging  [kernel.kallsyms]     [k] rep_movs_alternative                                 4.30%  sched-messaging  [kernel.kallsyms]     [k] rep_movs_alternative
>    3.24%  sched-messaging  [kernel.kallsyms]     [k] osq_lock                                             3.42%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_return_thunk
>    3.23%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_return_thunk                              3.31%  sched-messaging  [kernel.kallsyms]     [k] syscall_exit_to_user_mode
>    3.13%  sched-messaging  [kernel.kallsyms]     [k] syscall_exit_to_user_mode                            2.71%  sched-messaging  [kernel.kallsyms]     [k] osq_lock
>    2.44%  sched-messaging  [kernel.kallsyms]     [k] pipe_write                                           2.64%  sched-messaging  [kernel.kallsyms]     [k] pipe_write
>    2.38%  sched-messaging  [kernel.kallsyms]     [k] pipe_read                                            2.34%  sched-messaging  [kernel.kallsyms]     [k] do_syscall_64
>    2.23%  sched-messaging  [kernel.kallsyms]     [k] do_syscall_64                                        2.33%  sched-messaging  [kernel.kallsyms]     [k] pipe_read
>    2.19%  sched-messaging  [kernel.kallsyms]     [k] mutex_spin_on_owner                                  2.10%  sched-messaging  [kernel.kallsyms]     [k] fdget_pos
>    2.05%  swapper          [kernel.kallsyms]     [k] native_sched_clock                                   1.97%  sched-messaging  [kernel.kallsyms]     [k] vfs_write
>    1.94%  sched-messaging  [kernel.kallsyms]     [k] fdget_pos                                            1.93%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSRETQ_unsafe_stack
>    1.88%  sched-messaging  [kernel.kallsyms]     [k] vfs_read                                             1.91%  sched-messaging  [kernel.kallsyms]     [k] vfs_read
>    1.87%  swapper          [kernel.kallsyms]     [k] psi_group_change                                     1.89%  sched-messaging  [kernel.kallsyms]     [k] mutex_spin_on_owner
>    1.85%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSRETQ_unsafe_stack                           1.78%  sched-messaging  [kernel.kallsyms]     [k] current_time
>    1.83%  sched-messaging  [kernel.kallsyms]     [k] vfs_write                                            1.77%  sched-messaging  [kernel.kallsyms]     [k] apparmor_file_permission
>    1.68%  sched-messaging  [kernel.kallsyms]     [k] current_time                                         1.72%  sched-messaging  [kernel.kallsyms]     [k] aa_file_perm
>    1.67%  sched-messaging  [kernel.kallsyms]     [k] apparmor_file_permission                             1.66%  sched-messaging  [kernel.kallsyms]     [k] rw_verify_area
>    1.64%  sched-messaging  [kernel.kallsyms]     [k] aa_file_perm                                         1.59%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64_after_hwframe
>    1.56%  sched-messaging  [kernel.kallsyms]     [k] rw_verify_area                                       1.38%  sched-messaging  [kernel.kallsyms]     [k] _copy_from_iter
>    1.50%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64_after_hwframe                       1.38%  sched-messaging  [kernel.kallsyms]     [k] ktime_get_coarse_real_ts64_mg
>    1.36%  sched-messaging  [kernel.kallsyms]     [k] ktime_get_coarse_real_ts64_mg                        1.37%  sched-messaging  [kernel.kallsyms]     [k] native_sched_clock
>    1.33%  sched-messaging  [kernel.kallsyms]     [k] native_sched_clock                                   1.36%  swapper          [kernel.kallsyms]     [k] native_sched_clock
>    1.29%  sched-messaging  libc.so.6             [.] read                                                 1.34%  sched-messaging  libc.so.6             [.] __GI___libc_write
>    1.29%  sched-messaging  [kernel.kallsyms]     [k] _copy_from_iter                                      1.30%  sched-messaging  [kernel.kallsyms]     [k] _copy_to_iter
>    1.28%  sched-messaging  [kernel.kallsyms]     [k] _copy_to_iter                                        1.29%  sched-messaging  libc.so.6             [.] read
>    1.20%  sched-messaging  libc.so.6             [.] __GI___libc_write                                    1.23%  swapper          [kernel.kallsyms]     [k] psi_group_change
>    1.19%  sched-messaging  [kernel.kallsyms]     [k] __mutex_lock.constprop.0                             1.10%  sched-messaging  [kernel.kallsyms]     [k] psi_group_change
>    1.07%  swapper          [kernel.kallsyms]     [k] srso_alias_safe_ret                                  1.06%  sched-messaging  [kernel.kallsyms]     [k] atime_needs_update
>    1.04%  sched-messaging  [kernel.kallsyms]     [k] atime_needs_update                                   1.00%  sched-messaging  [kernel.kallsyms]     [k] security_file_permission
>    0.98%  sched-messaging  [kernel.kallsyms]     [k] security_file_permission                             0.97%  sched-messaging  [kernel.kallsyms]     [k] update_sd_lb_stats.constprop.0
>    0.97%  sched-messaging  [kernel.kallsyms]     [k] psi_group_change                                     0.94%  sched-messaging  [kernel.kallsyms]     [k] copy_page_to_iter
>    0.96%  sched-messaging  [kernel.kallsyms]     [k] copy_page_to_iter                                    0.93%  sched-messaging  [kernel.kallsyms]     [k] syscall_return_via_sysret
>    0.88%  sched-messaging  [kernel.kallsyms]     [k] ksys_read                                            0.91%  sched-messaging  [kernel.kallsyms]     [k] copy_page_from_iter
>    0.87%  sched-messaging  [kernel.kallsyms]     [k] syscall_return_via_sysret                            0.90%  sched-messaging  [kernel.kallsyms]     [k] ksys_write
>    0.86%  sched-messaging  [kernel.kallsyms]     [k] copy_page_from_iter                                  0.89%  sched-messaging  [kernel.kallsyms]     [k] ksys_read
>    0.85%  sched-messaging  [kernel.kallsyms]     [k] ksys_write                                           0.82%  sched-messaging  [kernel.kallsyms]     [k] fput
>    0.79%  sched-messaging  [kernel.kallsyms]     [k] fsnotify_pre_content                                 0.82%  sched-messaging  [kernel.kallsyms]     [k] fsnotify_pre_content
>    0.77%  sched-messaging  [kernel.kallsyms]     [k] fput                                                 0.78%  sched-messaging  [kernel.kallsyms]     [k] __mutex_lock.constprop.0
>    0.71%  sched-messaging  [kernel.kallsyms]     [k] mutex_lock                                           0.78%  sched-messaging  [kernel.kallsyms]     [k] native_queued_spin_lock_slowpath
>    0.71%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_unlock                                    0.75%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_unlock
>    0.71%  swapper          [kernel.kallsyms]     [k] srso_alias_return_thunk                              0.73%  sched-messaging  [kernel.kallsyms]     [k] mutex_lock
>    0.68%  sched-messaging  [kernel.kallsyms]     [k] x64_sys_call                                         0.70%  sched-messaging  [kernel.kallsyms]     [k] x64_sys_call
>    0.68%  sched-messaging  [kernel.kallsyms]     [k] _raw_spin_lock_irqsave                               0.69%  swapper          [kernel.kallsyms]     [k] srso_alias_safe_ret
>    0.65%  swapper          [kernel.kallsyms]     [k] menu_select                                          0.59%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_lock
>    0.57%  sched-messaging  [kernel.kallsyms]     [k] __schedule                                           0.59%  sched-messaging  [kernel.kallsyms]     [k] inode_needs_update_time.part.0
>    0.56%  sched-messaging  [kernel.kallsyms]     [k] page_copy_sane                                       0.57%  sched-messaging  [kernel.kallsyms]     [k] page_copy_sane
>    0.54%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_lock                                      0.52%  sched-messaging  [kernel.kallsyms]     [k] select_task_rq_fair
>    0.53%  sched-messaging  [kernel.kallsyms]     [k] inode_needs_update_time.part.0                       0.51%  sched-messaging  libc.so.6             [.] __GI___pthread_enable_asynccancel
>    0.48%  sched-messaging  libc.so.6             [.] __GI___pthread_enable_asynccancel                    0.50%  sched-messaging  [kernel.kallsyms]     [k] fpregs_assert_state_consistent
>    0.48%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64                                     0.50%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64
>    0.48%  swapper          [kernel.kallsyms]     [k] save_fpregs_to_fpstate                               0.49%  sched-messaging  [kernel.kallsyms]     [k] mutex_unlock
>    0.48%  sched-messaging  [kernel.kallsyms]     [k] mutex_unlock                                         0.49%  sched-messaging  [kernel.kallsyms]     [k] __schedule
>    0.47%  sched-messaging  [kernel.kallsyms]     [k] dequeue_entity                                       0.48%  sched-messaging  [kernel.kallsyms]     [k] update_load_avg
>    0.46%  sched-messaging  [kernel.kallsyms]     [k] fpregs_assert_state_consistent                       0.48%  sched-messaging  [kernel.kallsyms]     [k] _raw_spin_lock_irqsave
>    0.46%  sched-messaging  [kernel.kallsyms]     [k] update_load_avg                                      0.48%  sched-messaging  [kernel.kallsyms]     [k] cpu_util
>    0.46%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_se                                 0.47%  swapper          [kernel.kallsyms]     [k] srso_alias_return_thunk
>    0.45%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_cfs_rq                             0.46%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_se
>    0.37%  swapper          [kernel.kallsyms]     [k] __schedule                                           0.45%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_cfs_rq
>    0.36%  swapper          [kernel.kallsyms]     [k] enqueue_entity                                       0.45%  swapper          [kernel.kallsyms]     [k] menu_select
>    0.35%  sched-messaging  perf                  [.] sender                                               0.38%  sched-messaging  perf                  [.] sender
>    0.34%  sched-messaging  [kernel.kallsyms]     [k] file_update_time                                     0.37%  sched-messaging  [kernel.kallsyms]     [k] file_update_time
>    0.34%  swapper          [kernel.kallsyms]     [k] acpi_processor_ffh_cstate_enter                      0.36%  sched-messaging  [kernel.kallsyms]     [k] _find_next_and_bit
>    0.33%  sched-messaging  perf                  [.] receiver                                             0.34%  sched-messaging  [kernel.kallsyms]     [k] dequeue_entity
>    0.32%  sched-messaging  [kernel.kallsyms]     [k] __cond_resched                                       0.33%  sched-messaging  [kernel.kallsyms]     [k] update_curr
> ---
>
> o 16-groups (11.895s [Mainline] vs 8.163s [revert])
>
>     sudo ./perf record -a -e ibs_op/cnt_ctl=1/ -- ./perf bench sched messaging -p -t -l 100000 -g 1
>
>     (Whole system was profiled since there are 640 tasks on a 256CPU
>      setup)
>
> 							mainline			vs			revert
>
> Samples: 10M of event 'ibs_op/cnt_ctl=1/', Event count (approx.): 3257434807546                     Samples: 6M of event 'ibs_op/cnt_ctl=1/', Event count (approx.): 3115778240381
> Overhead  Command          Shared Object         Symbol                                             Overhead  Command          Shared Object            Symbol
>    5.07%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_safe_ret                               5.28%  sched-messaging  [kernel.kallsyms]        [k] srso_alias_safe_ret
>    4.24%  sched-messaging  [kernel.kallsyms]     [k] rep_movs_alternative                              4.55%  sched-messaging  [kernel.kallsyms]        [k] rep_movs_alternative
>    3.42%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_return_thunk                           3.56%  sched-messaging  [kernel.kallsyms]        [k] srso_alias_return_thunk
>    3.26%  sched-messaging  [kernel.kallsyms]     [k] syscall_exit_to_user_mode                         3.44%  sched-messaging  [kernel.kallsyms]        [k] syscall_exit_to_user_mode
>    2.55%  sched-messaging  [kernel.kallsyms]     [k] pipe_write                                        2.78%  sched-messaging  [kernel.kallsyms]        [k] pipe_write
>    2.51%  sched-messaging  [kernel.kallsyms]     [k] osq_lock                                          2.48%  sched-messaging  [kernel.kallsyms]        [k] do_syscall_64
>    2.38%  sched-messaging  [kernel.kallsyms]     [k] pipe_read                                         2.47%  sched-messaging  [kernel.kallsyms]        [k] pipe_read
>    2.31%  sched-messaging  [kernel.kallsyms]     [k] do_syscall_64                                     2.15%  sched-messaging  [kernel.kallsyms]        [k] fdget_pos
>    2.11%  sched-messaging  [kernel.kallsyms]     [k] mutex_spin_on_owner                               2.12%  sched-messaging  [kernel.kallsyms]        [k] vfs_write
>    2.00%  sched-messaging  [kernel.kallsyms]     [k] fdget_pos                                         2.03%  sched-messaging  [kernel.kallsyms]        [k] entry_SYSRETQ_unsafe_stack
>    1.93%  sched-messaging  [kernel.kallsyms]     [k] vfs_write                                         1.97%  sched-messaging  [kernel.kallsyms]        [k] vfs_read
>    1.90%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSRETQ_unsafe_stack                        1.92%  sched-messaging  [kernel.kallsyms]        [k] native_sched_clock
>    1.88%  sched-messaging  [kernel.kallsyms]     [k] vfs_read                                          1.87%  sched-messaging  [kernel.kallsyms]        [k] psi_group_change
>    1.77%  sched-messaging  [kernel.kallsyms]     [k] native_sched_clock                                1.87%  sched-messaging  [kernel.kallsyms]        [k] current_time
>    1.74%  sched-messaging  [kernel.kallsyms]     [k] current_time                                      1.83%  sched-messaging  [kernel.kallsyms]        [k] apparmor_file_permission
>    1.70%  sched-messaging  [kernel.kallsyms]     [k] apparmor_file_permission                          1.79%  sched-messaging  [kernel.kallsyms]        [k] aa_file_perm
>    1.67%  sched-messaging  [kernel.kallsyms]     [k] aa_file_perm                                      1.73%  sched-messaging  [kernel.kallsyms]        [k] rw_verify_area
>    1.61%  sched-messaging  [kernel.kallsyms]     [k] rw_verify_area                                    1.66%  sched-messaging  [kernel.kallsyms]        [k] entry_SYSCALL_64_after_hwframe
>    1.60%  sched-messaging  [kernel.kallsyms]     [k] psi_group_change                                  1.48%  sched-messaging  [kernel.kallsyms]        [k] ktime_get_coarse_real_ts64_mg
>    1.56%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64_after_hwframe                    1.46%  sched-messaging  [kernel.kallsyms]        [k] _copy_from_iter
>    1.38%  sched-messaging  [kernel.kallsyms]     [k] ktime_get_coarse_real_ts64_mg                     1.39%  sched-messaging  libc.so.6                [.] __GI___libc_write
>    1.37%  sched-messaging  [kernel.kallsyms]     [k] _copy_from_iter                                   1.39%  sched-messaging  [kernel.kallsyms]        [k] _copy_to_iter
>    1.31%  sched-messaging  [kernel.kallsyms]     [k] _copy_to_iter                                     1.37%  sched-messaging  libc.so.6                [.] read
>    1.31%  sched-messaging  libc.so.6             [.] read                                              1.10%  sched-messaging  [kernel.kallsyms]        [k] atime_needs_update
>    1.28%  sched-messaging  libc.so.6             [.] __GI___libc_write                                 1.07%  swapper          [kernel.kallsyms]        [k] native_sched_clock
>    1.23%  swapper          [kernel.kallsyms]     [k] native_sched_clock                                1.05%  sched-messaging  [kernel.kallsyms]        [k] native_queued_spin_lock_slowpath
>    1.04%  sched-messaging  [kernel.kallsyms]     [k] atime_needs_update                                1.05%  sched-messaging  [kernel.kallsyms]        [k] security_file_permission
>    0.99%  sched-messaging  [kernel.kallsyms]     [k] security_file_permission                          1.00%  sched-messaging  [kernel.kallsyms]        [k] copy_page_to_iter
>    0.99%  swapper          [kernel.kallsyms]     [k] psi_group_change                                  0.97%  sched-messaging  [kernel.kallsyms]        [k] copy_page_from_iter
>    0.96%  sched-messaging  [kernel.kallsyms]     [k] copy_page_to_iter                                 0.97%  sched-messaging  [kernel.kallsyms]        [k] syscall_return_via_sysret
>    0.91%  sched-messaging  [kernel.kallsyms]     [k] copy_page_from_iter                               0.96%  sched-messaging  [kernel.kallsyms]        [k] ksys_write
>    0.90%  sched-messaging  [kernel.kallsyms]     [k] syscall_return_via_sysret                         0.95%  sched-messaging  [kernel.kallsyms]        [k] ksys_read
>    0.90%  sched-messaging  [kernel.kallsyms]     [k] ksys_read                                         0.85%  sched-messaging  [kernel.kallsyms]        [k] fsnotify_pre_content
>    0.90%  sched-messaging  [kernel.kallsyms]     [k] __mutex_lock.constprop.0                          0.84%  sched-messaging  [kernel.kallsyms]        [k] fput
>    0.88%  sched-messaging  [kernel.kallsyms]     [k] ksys_write                                        0.82%  swapper          [kernel.kallsyms]        [k] psi_group_change
>    0.80%  sched-messaging  [kernel.kallsyms]     [k] fput                                              0.80%  sched-messaging  [kernel.kallsyms]        [k] __rcu_read_unlock
>    0.80%  sched-messaging  [kernel.kallsyms]     [k] fsnotify_pre_content                              0.76%  sched-messaging  [kernel.kallsyms]        [k] x64_sys_call
>    0.74%  sched-messaging  [kernel.kallsyms]     [k] mutex_lock                                        0.76%  sched-messaging  [kernel.kallsyms]        [k] mutex_lock
>    0.73%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_unlock                                 0.69%  sched-messaging  [kernel.kallsyms]        [k] __schedule
>    0.70%  sched-messaging  [kernel.kallsyms]     [k] x64_sys_call                                      0.67%  sched-messaging  [kernel.kallsyms]        [k] osq_lock
>    0.69%  swapper          [kernel.kallsyms]     [k] srso_alias_safe_ret                               0.64%  swapper          [kernel.kallsyms]        [k] srso_alias_safe_ret
>    0.63%  sched-messaging  [kernel.kallsyms]     [k] __schedule                                        0.62%  sched-messaging  [kernel.kallsyms]        [k] __rcu_read_lock
>    0.62%  sched-messaging  [kernel.kallsyms]     [k] _raw_spin_lock_irqsave                            0.61%  sched-messaging  [kernel.kallsyms]        [k] inode_needs_update_time.part.0
>    0.57%  sched-messaging  [kernel.kallsyms]     [k] page_copy_sane                                    0.61%  sched-messaging  [kernel.kallsyms]        [k] page_copy_sane
>    0.57%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_lock                                   0.59%  sched-messaging  [kernel.kallsyms]        [k] select_task_rq_fair
>    0.56%  sched-messaging  [kernel.kallsyms]     [k] inode_needs_update_time.part.0                    0.54%  sched-messaging  [kernel.kallsyms]        [k] _raw_spin_lock_irqsave
>    0.52%  sched-messaging  [kernel.kallsyms]     [k] update_sd_lb_stats.constprop.0                    0.53%  sched-messaging  libc.so.6                [.] __GI___pthread_enable_asynccancel
>    0.49%  sched-messaging  [kernel.kallsyms]     [k] restore_fpregs_from_fpstate                       0.53%  sched-messaging  [kernel.kallsyms]        [k] update_load_avg
>    0.49%  sched-messaging  libc.so.6             [.] __GI___pthread_enable_asynccancel                 0.52%  sched-messaging  [kernel.kallsyms]        [k] entry_SYSCALL_64
>    0.49%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64                                  0.52%  sched-messaging  [kernel.kallsyms]        [k] fpregs_assert_state_consistent
>    0.49%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_se                              0.52%  sched-messaging  [kernel.kallsyms]        [k] __update_load_avg_se
>    0.49%  sched-messaging  [kernel.kallsyms]     [k] mutex_unlock                                      0.52%  sched-messaging  [kernel.kallsyms]        [k] mutex_spin_on_owner
>    0.48%  sched-messaging  [kernel.kallsyms]     [k] update_load_avg                                   0.51%  sched-messaging  [kernel.kallsyms]        [k] mutex_unlock
>    0.47%  sched-messaging  [kernel.kallsyms]     [k] fpregs_assert_state_consistent                    0.47%  sched-messaging  [kernel.kallsyms]        [k] __update_load_avg_cfs_rq
>    0.46%  swapper          [kernel.kallsyms]     [k] srso_alias_return_thunk                           0.43%  swapper          [kernel.kallsyms]        [k] srso_alias_return_thunk
>    0.46%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_cfs_rq                          0.41%  sched-messaging  [kernel.kallsyms]        [k] __mutex_lock.constprop.0
>    0.43%  swapper          [kernel.kallsyms]     [k] menu_select                                       0.41%  sched-messaging  [kernel.kallsyms]        [k] dequeue_entity
>    0.39%  sched-messaging  [kernel.kallsyms]     [k] dequeue_entity                                    0.40%  sched-messaging  [kernel.kallsyms]        [k] update_curr
>    0.39%  sched-messaging  [kernel.kallsyms]     [k] native_queued_spin_lock_slowpath                  0.39%  sched-messaging  perf                     [.] sender
>    0.38%  sched-messaging  [kernel.kallsyms]     [k] update_curr                                       0.39%  sched-messaging  [kernel.kallsyms]        [k] file_update_time
>    0.37%  sched-messaging  perf                  [.] sender                                            0.37%  sched-messaging  [kernel.kallsyms]        [k] psi_task_switch
>    0.35%  sched-messaging  [kernel.kallsyms]     [k] file_update_time                                  0.37%  swapper          [kernel.kallsyms]        [k] menu_select
>    0.35%  sched-messaging  [kernel.kallsyms]     [k] select_task_rq_fair                               0.34%  sched-messaging  perf                     [.] receiver
>    0.34%  sched-messaging  [kernel.kallsyms]     [k] psi_task_switch                                   0.32%  sched-messaging  [kernel.kallsyms]        [k] __calc_delta.constprop.0
> ---
>
> For 1-groups I see "osq_lock" turning slightly hotter on mainline
> compared to the revert probably suggesting more optimistic spinning
> on the "pipe->mutex".
>
> For the 16-client case, I see that "native_queued_spin_lock_slowpath"
> jumps up with the revert.
>
> Adding --call-graph when profiling completely alters the profile but
> in case of the revert, I was able to see which paths lead to
> "native_queued_spin_lock_slowpath" with 16-groups case:
>
>
>   Overhead  Command          Shared Object            Symbol
> -    4.21%  sched-messaging  [kernel.kallsyms]        [k] native_queued_spin_lock_slowpath
>    - 2.77% native_queued_spin_lock_slowpath
>       - 1.52% _raw_spin_lock_irqsave
>          - 1.35% prepare_to_wait_event
>             - 1.34% pipe_write
>                  vfs_write
>                  ksys_write
>                  do_syscall_64
>                  entry_SYSCALL_64
>                  __GI___libc_write
>                  write (inlined)
>                  start_thread
>       - 1.25% _raw_spin_lock
>          - 1.25% raw_spin_rq_lock_nested
>             - 0.95% __task_rq_lock
>                - try_to_wake_up
>                   - 0.95% autoremove_wake_function
>                        __wake_up_common
>                        __wake_up_sync_key
> ---
>
> >
> >Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> >---
> >  fs/pipe.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >
> >diff --git a/fs/pipe.c b/fs/pipe.c
> >index 12b22c2723b7..82fede0f2111 100644
> >--- a/fs/pipe.c
> >+++ b/fs/pipe.c
> >@@ -253,7 +253,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >  	size_t total_len = iov_iter_count(to);
> >  	struct file *filp = iocb->ki_filp;
> >  	struct pipe_inode_info *pipe = filp->private_data;
> >-	bool was_full, wake_next_reader = false;
> >+	bool wake_writer = false, wake_next_reader = false;
> >  	ssize_t ret;
> >  	/* Null read succeeds. */
> >@@ -264,14 +264,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >  	mutex_lock(&pipe->mutex);
> >  	/*
> >-	 * We only wake up writers if the pipe was full when we started
> >-	 * reading in order to avoid unnecessary wakeups.
> >+	 * We only wake up writers if the pipe was full when we started reading
> >+	 * and it is no longer full after reading to avoid unnecessary wakeups.
> >  	 *
> >  	 * But when we do wake up writers, we do so using a sync wakeup
> >  	 * (WF_SYNC), because we want them to get going and generate more
> >  	 * data for us.
> >  	 */
> >-	was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
> >  	for (;;) {
> >  		/* Read ->head with a barrier vs post_one_notification() */
> >  		unsigned int head = smp_load_acquire(&pipe->head);
> >@@ -340,8 +339,10 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >  				buf->len = 0;
> >  			}
> >-			if (!buf->len)
> >+			if (!buf->len) {
> >+				wake_writer |= pipe_full(head, tail, pipe->max_usage);
> >  				tail = pipe_update_tail(pipe, buf, tail);
> >+			}
> >  			total_len -= chars;
> >  			if (!total_len)
> >  				break;	/* common path: read succeeded */
> >@@ -377,7 +378,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >  		 * _very_ unlikely case that the pipe was full, but we got
> >  		 * no data.
> >  		 */
> >-		if (unlikely(was_full))
> >+		if (unlikely(wake_writer))
> >  			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> >  		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> >@@ -390,15 +391,15 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >  		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
> >  			return -ERESTARTSYS;
> >-		mutex_lock(&pipe->mutex);
> >-		was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
> >+		wake_writer = false;
> >  		wake_next_reader = true;
> >+		mutex_lock(&pipe->mutex);
> >  	}
>
> Looking at the performance trend, I tried the following (possibly dumb)
> experiment on top of mainline:
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 82fede0f2111..43d827f99c55 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -395,6 +395,19 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		wake_next_reader = true;
>  		mutex_lock(&pipe->mutex);
>  	}
> +
> +	if (!wake_writer && !pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
> +		/*
> +		 * Proactively wake up writers if the pipe is not full.
> +		 * This smp_mb() pairs with another barrier in ___wait_event(),
> +		 * see more details in comments of waitqueue_active().
> +		 */
> +		smp_mb();
> +
> +		if (waitqueue_active(&pipe->wr_wait))
> +			wake_writer = true;
> +	}
> +
>  	if (pipe_empty(pipe->head, pipe->tail))
>  		wake_next_reader = false;
>  	mutex_unlock(&pipe->mutex);
>
> base-commit: 05dbaf8dd8bf537d4b4eb3115ab42a5fb40ff1f5
> --
>
> and I see that the perfomance at lower utilization is closer to the
> mainline whereas at higher utlization, it is close to that with this
> patch reverted:
>
>     ==================================================================
>     Test          : sched-messaging
>     Units         : Normalized time in seconds
>     Interpretation: Lower is better
>     Statistic     : AMean
>     ==================================================================
>     Case:         mainline[pct imp](CV)    revert[pct imp](CV)      patched[pct imp](CV)
>      1-groups     1.00 [ -0.00](12.29)     1.26 [-25.91]( 2.71)     0.96 [  4.05]( 1.61)
>      2-groups     1.00 [ -0.00]( 3.64)     1.39 [-38.53]( 0.89)     1.05 [ -5.26]( 0.93)
>      4-groups     1.00 [ -0.00]( 3.33)     1.41 [-41.42]( 1.21)     1.04 [ -4.18]( 1.38)
>      8-groups     1.00 [ -0.00]( 2.90)     1.10 [ -9.89]( 0.95)     0.84 [ 16.07]( 1.55)
>     16-groups     1.00 [ -0.00]( 1.46)     0.66 [ 34.46]( 1.59)     0.50 [ 49.55]( 1.91)
>
> The rationale was at higher utilization, perhaps there is a delay
> in wakeup of writers from the time tail was moved but looking at all the
> synchronization with "pipe->mutex", it is highly unlikely and I do not
> have a good explanation for why this helps (or if it is even correct)
>
> Following are some system-wide aggregates of schedstats on each
> kernel running the 16-group variant collected using perf sched
> stats [0]:
>
>     sudo ./perf sched stats report #cord -- ./perf bench sched messaging -p -t -l 100000 -g 16
>
> kernel                                                           :      mainline                         revert                          patched
> runtime                                                          :     11.418s                           7.207s                           6.278s
> sched_yield() count                                              :           0                                0                                0
> Legacy counter can be ignored                                    :           0                                0                                0
> schedule() called                                                :      402376                           403424                           172432
> schedule() left the processor idle                               :      144622  (    35.94% )            142240  (    35.26% )             56732  (    32.90% )
> try_to_wake_up() was called                                      :      237032                           241834                           101645
> try_to_wake_up() was called to wake up the local cpu             :        1064  (     0.45% )             16656  (     6.89% )             12385  (    12.18% )
> total runtime by tasks on this processor (in jiffies)            :  9072083005                       5516672721                       5105984838
> total waittime by tasks on this processor (in jiffies)           :  4380309658  (    48.28% )        7304939649  (   132.42% )        6120940564  (   119.88% )
> total timeslices run on this cpu                                 :      257644                           261129                           115628
>
> [0] https://lore.kernel.org/lkml/20241122084452.1064968-1-swapnil.sapkal@amd.com/
>
> The trend seems to be higher local CPU wakeups albeit with more wait time
> but that diesn't seem to hurt the progress of sched-messaging.
>
> >  	if (pipe_empty(pipe->head, pipe->tail))
> >  		wake_next_reader = false;
> >  	mutex_unlock(&pipe->mutex);
> >-	if (was_full)
> >+	if (wake_writer)
> >  		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> >  	if (wake_next_reader)
> >  		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
>
> If you need any more information from my test setup, please do let me
> know. All tests were run on a dual socket 3rd Generation EPYC system
> (2 x 64C/128T) running in NPS1 mode with C2 disabled and boost enabled.
>
> --
> Thanks and Regards,
> Prateek
>


