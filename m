Return-Path: <linux-fsdevel+bounces-46589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74EA90D05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789391887DD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 20:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FCD229B35;
	Wed, 16 Apr 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+iCqnju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B327206F37;
	Wed, 16 Apr 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834927; cv=none; b=jtzDazgJ36M4ZIVXnCW8tFxxnLWN9Oog4RGzZ3bNDyD/7F0bHuns+n8g95DzuhCRnPic12GNrGc44TpI6h7X6QpMq2Rq8cVaZktY1gN1kTxx1YjzqPDvvBjf/95hiSG+fGlg6swgHJSApD/G43Nuumkx4jC0lg3upDN7gQev0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834927; c=relaxed/simple;
	bh=MyXEPU5aauDbge2EPjOklgh/uE/SeNRgZek57izFX9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbmYGJ9yW8fwjbfHHn7gHoHKHNG039zjrXmTdG2EtwkMG7IcSTx+hbuShaUQKCrlcuuhP70RSevLji/J2MQDTxGRN5Kz3vbq47tX+qINoaY/OMfWlZcTPOPiEnI33jK1C4M3p4OI9KcIVRSzLiHHrsktqCitol9voe981UFIIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+iCqnju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D070C4CEE4;
	Wed, 16 Apr 2025 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744834927;
	bh=MyXEPU5aauDbge2EPjOklgh/uE/SeNRgZek57izFX9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+iCqnjuAtgoc5WfsiFfZx5oSaOFsCNPsYfwoWR5mfhAJB7e7Dy8ZYRm6l0wTq6Ai
	 Wc0CEvD71QUOx/Z9PcPHX9sEsNko0w4jsTHkKB4XPPVMZwicRmBSq4C2vn0xHXLAwy
	 kKIuWV2cQeHUF7cYTdRJ3GAFlXefcbdI9X+6ehPxjRh5MOWRNFtNqWTbnO/S+12Sls
	 e6BD3F9SJmrsj72HjIOxEWtEqRwP/N1dHphINX6MnUH4OwltrqROMO0YuNEr9o5lEG
	 O5wp4/Y2zsWto+u4RMXEde0CFW/oUNWwhszGd0NLUrxu4I8BqcbovgWeNAlYwdOYpW
	 4C7VH8wl7uFtQ==
Date: Wed, 16 Apr 2025 13:22:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: linux-xfs@vger.kernel.org
Subject: Re: [6.15-rc2 regression] xfs: null pointer in the dax fault code
Message-ID: <20250416202206.GE25659@frogsfrogsfrogs>
References: <20250416174358.GM25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416174358.GM25675@frogsfrogsfrogs>

On Wed, Apr 16, 2025 at 10:43:58AM -0700, Darrick J. Wong wrote:
> Hi folks,
> 
> After upgrading to 6.15-rc2, I see the following crash in (I think?) the
> DAX code on xfs/593 (which is a fairly boring fsck test).
> 
> MKFS_OPTIONS=" -m metadir=1,autofsck=1,uquota,gquota,pquota, -d daxinherit=1,"
> MOUNT_OPTIONS=""
> 
> Any ideas?  Does this stack trace ring a bell for anyone?
> 
> --D
On Wed, Apr 16, 2025 at 07:38:36PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 16, 2025 at 11:08:37AM -0700, Darrick J. Wong wrote:
> > Hi folks,
> > 
> > I upgraded my arm64 kernel to 6.15-rc2, and I also see this splat in
> > generic/363.  The fstets config is as follows:
> > 
> > MKFS_OPTIONS="-m metadir=1,autofsck=1,uquota,gquota,pquota, -b size=65536,"
> > MOUNT_OPTIONS=""
> > 
> > The VM is arm64 with 64k base pages.  I've disabled LBS to work around
> > a fair number of other strange bugs.  Does this ring a bell for anyone?
> > 
> > --D
> > 
> > list_add double add: new=ffffffff40538c88, prev=fffffc03febf8148, next=ffffffff40538c88.
> 
> Not a bell, but it's weird.  We're trying to add ffffffff40538c88 to
> the list, but next already has that value.  So this is a double-free of
> the folio?  Do you have VM_BUG_ON_FOLIO enabled with CONFIG_VM_DEBUG?

Note that xfs/593 on x86_64 (same config but no pmem) seems to have
stalled with:

run fstests xfs/593 at 2025-04-16 03:33:38
XFS (sda3): EXPERIMENTAL metadata directory tree feature enabled.  Use at your own risk!
XFS (sda3): EXPERIMENTAL exchange range feature enabled.  Use at your own risk!
XFS (sda3): EXPERIMENTAL parent pointer feature enabled.  Use at your own risk!
XFS (sda3): Mounting V5 Filesystem c261642e-620a-4382-88f7-648a25d82213
XFS (sda3): Ending clean mount
XFS (sda3): EXPERIMENTAL online scrub feature enabled.  Use at your own risk!
XFS (sda4): EXPERIMENTAL metadata directory tree feature enabled.  Use at your own risk!
XFS (sda4): EXPERIMENTAL exchange range feature enabled.  Use at your own risk!
XFS (sda4): EXPERIMENTAL parent pointer feature enabled.  Use at your own risk!
XFS (sda4): Mounting V5 Filesystem 8db5080b-35d5-4308-90bf-cab53746ab63
XFS (sda4): Ending clean mount
XFS (sda4): Quotacheck needed: Please wait.
XFS (sda4): Quotacheck: Done.
XFS (sda4): EXPERIMENTAL online scrub feature enabled.  Use at your own risk!
INFO: task u16:4:277318 blocked for more than 61 seconds.
      Not tainted 6.15.0-rc2-xfsx #rc2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:u16:4           state:D stack:10728 pid:277318 tgid:277318 ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 __schedule+0x458/0x14c0
 ? folio_wait_bit_common+0x118/0x330
 schedule+0x2a/0xe0
 io_schedule+0x4c/0x70
 folio_wait_bit_common+0x144/0x330
 ? filemap_get_read_batch+0x330/0x330
 writeback_iter+0x305/0x340
 iomap_writepages+0x6f/0xb60
 xfs_vm_writepages+0x7c/0xf0 [xfs 05d1f477986dfc3e3925c4fd18979e6f6f9a9e35]
 do_writepages+0x82/0x280
 ? sched_balance_find_src_group+0x4d/0x500
 __writeback_single_inode+0x3d/0x330
 ? do_raw_spin_unlock+0x49/0xb0
 writeback_sb_inodes+0x21c/0x4e0
 wb_writeback+0x99/0x320
 wb_workfn+0xc0/0x410
 process_one_work+0x195/0x3d0
 worker_thread+0x264/0x380
 ? _raw_spin_unlock_irqrestore+0x1e/0x40
 ? rescuer_thread+0x4f0/0x4f0
 kthread+0x117/0x270
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x2d/0x50
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>
INFO: task fsstress:503330 blocked for more than 61 seconds.
      Not tainted 6.15.0-rc2-xfsx #rc2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:fsstress        state:D stack:10872 pid:503330 tgid:503330 ppid:503327 task_flags:0x400140 flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x458/0x14c0
 ? wb_queue_work+0x8e/0x100
 schedule+0x2a/0xe0
 wb_wait_for_completion+0x8d/0xc0
 ? cpuacct_css_alloc+0xa0/0xa0
 __writeback_inodes_sb_nr+0x9f/0xc0
 sync_filesystem+0x29/0x90
 __x64_sys_syncfs+0x40/0xa0
 do_syscall_64+0x37/0xf0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f0a3b837d17
RSP: 002b:00007ffd2eea1988 EFLAGS: 00000206 ORIG_RAX: 0000000000000132
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f0a3b837d17
RDX: 0000000000000000 RSI: 00005603860ff430 RDI: 0000000000000005
RBP: 000000000000eb44 R08: 000000000000005b R09: 00007f0a3b92f000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000001
R13: 8f5c28f5c28f5c29 R14: 00007ffd2eea19d0 R15: 0000560348867790
 </TASK>
INFO: task fsstress:503331 blocked for more than 61 seconds.
      Not tainted 6.15.0-rc2-xfsx #rc2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:fsstress        state:D stack:10872 pid:503331 tgid:503331 ppid:503327 task_flags:0x400140 flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x458/0x14c0
 ? wb_queue_work+0x8e/0x100
 schedule+0x2a/0xe0
 wb_wait_for_completion+0x8d/0xc0
 ? cpuacct_css_alloc+0xa0/0xa0
 __writeback_inodes_sb_nr+0x9f/0xc0
 sync_filesystem+0x29/0x90
 __x64_sys_syncfs+0x40/0xa0
 do_syscall_64+0x37/0xf0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f0a3b837d17
RSP: 002b:00007ffd2eea1988 EFLAGS: 00000206 ORIG_RAX: 0000000000000132
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f0a3b837d17
RDX: 0000000000000000 RSI: 00005603860ff430 RDI: 0000000000000005
RBP: 000000000000cc4e R08: 0000000000000036 R09: 00007f0a3b92f000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000001
R13: 8f5c28f5c28f5c29 R14: 00007ffd2eea19d0 R15: 0000560348867790
 </TASK>
INFO: task fsstress:503332 blocked for more than 61 seconds.
      Not tainted 6.15.0-rc2-xfsx #rc2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:fsstress        state:D stack:10872 pid:503332 tgid:503332 ppid:503327 task_flags:0x400140 flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x458/0x14c0
 ? wb_queue_work+0x8e/0x100
 schedule+0x2a/0xe0
 wb_wait_for_completion+0x8d/0xc0
 ? cpuacct_css_alloc+0xa0/0xa0
 __writeback_inodes_sb_nr+0x9f/0xc0
 sync_filesystem+0x29/0x90
 __x64_sys_syncfs+0x40/0xa0
 do_syscall_64+0x37/0xf0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f0a3b837d17
RSP: 002b:00007ffd2eea1988 EFLAGS: 00000206 ORIG_RAX: 0000000000000132
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f0a3b837d17
RDX: 0000000000000000 RSI: 00005603860ff430 RDI: 0000000000000005
RBP: 000000000000ecb4 R08: 0000000000000039 R09: 00007f0a3b92f000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000001
R13: 8f5c28f5c28f5c29 R14: 00007ffd2eea19d0 R15: 0000560348867790
 </TASK>
INFO: task fsstress:503333 blocked for more than 61 seconds.
      Not tainted 6.15.0-rc2-xfsx #rc2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:fsstress        state:D stack:10872 pid:503333 tgid:503333 ppid:503327 task_flags:0x400140 flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x458/0x14c0
 ? wb_queue_work+0x8e/0x100
 schedule+0x2a/0xe0
 wb_wait_for_completion+0x8d/0xc0
 ? cpuacct_css_alloc+0xa0/0xa0
 __writeback_inodes_sb_nr+0x9f/0xc0
 sync_filesystem+0x29/0x90
 __x64_sys_syncfs+0x40/0xa0
 do_syscall_64+0x37/0xf0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f0a3b837d17
RSP: 002b:00007ffd2eea1988 EFLAGS: 00000206 ORIG_RAX: 0000000000000132
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f0a3b837d17
RDX: 0000000000000000 RSI: 00005603860ff430 RDI: 0000000000000005
RBP: 000000000000df01 R08: 000000000000006d R09: 00007f0a3b92f000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000001
R13: 8f5c28f5c28f5c29 R14: 00007ffd2eea19d0 R15: 0000560348867790
 </TASK>

--D

