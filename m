Return-Path: <linux-fsdevel+bounces-7339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F84823B72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 05:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2FC1F26363
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 04:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03118C3D;
	Thu,  4 Jan 2024 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c06zMUQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2F18647;
	Thu,  4 Jan 2024 04:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B142C433C8;
	Thu,  4 Jan 2024 04:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704342861;
	bh=W4B08C8GWMQQNHdZRI5GjHBbR9zWGTPqDufltD3JroA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c06zMUQ3RNgOkMdmDbzD8srtDGUno11Q3wS17Dh45mOzgLlXgGRqaJQIdBDyUbF7/
	 TBqPmYEJo5yFMyxvm+kYjSA+6j97DEJDtJ8XezNfIHbPgG/XusNLdofy+o61Sv0J3K
	 +g3yzIMPoa2K0RGk9NseSEM6GJwnYUTpwm+bLqm5yIODJfk2yUTW3cAXOULWQWg5qH
	 hQTl9M5WkEGuGP/FZlb4GxKpZu+u1AGOoCP0M2EQk0y5v6e6X2WvFq8294LOeMvU/+
	 nXwLshKGoVMmnWIfdedwwhCc2KBHgcku53kOm4YedQBB72d4aD5P3fa13C8lrGzYpN
	 jZ7Bv7pLYZBPg==
Date: Wed, 3 Jan 2024 20:34:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: [BUG REPORT] shrink_dcache_parent() loops indefinitely on a
 next-20240102 kernel
Message-ID: <20240104043420.GT361584@frogsfrogsfrogs>
References: <87le96lorq.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le96lorq.fsf@debian-BULLSEYE-live-builder-AMD64>

On Wed, Jan 03, 2024 at 12:12:12PM +0530, Chandan Babu R wrote:
> Hi,
> 
> Executing fstests' recoveryloop test group on XFS on a next-20240102 kernel
> sometimes causes the following hung task report to be printed on the console,
> 
> [  190.284008] XFS (loop5): Mounting V5 Filesystem 43ed2bb9-5b51-4bdc-af8d-af2ca7001f3f

Huh.  Which test is this, specifically?  And is this easily
reproduceable and new?  Or hard to re-trigger and who knows how long
it's been this way?

> [  190.291326] XFS (loop5): Ending clean mount
> [  190.301165] XFS (loop5): User initiated shutdown received.
> [  190.302808] XFS (loop5): Log I/O Error (0x6) detected at xfs_fs_goingdown+0x93/0xd0 [xfs] (fs/xfs/xfs_fsops.c:458).  Shutting down filesystem.
> [  190.308555] XFS (loop5): Please unmount the filesystem and rectify the problem(s)
> [  190.369214] XFS (loop5): Unmounting Filesystem 43ed2bb9-5b51-4bdc-af8d-af2ca7001f3f
> [  190.404932] XFS (loop5): Mounting V5 Filesystem 43ed2bb9-5b51-4bdc-af8d-af2ca7001f3f
> [  190.419673] XFS (loop5): Ending clean mount
> [  190.429301] XFS (loop5): User initiated shutdown received.
> [  190.431178] XFS (loop5): Log I/O Error (0x6) detected at xfs_fs_goingdown+0x93/0xd0 [xfs] (fs/xfs/xfs_fsops.c:458).  Shutting down filesystem.
> [  190.437622] XFS (loop5): Please unmount the filesystem and rectify the problem(s)
> [  369.717531] INFO: task fsstress:18269 blocked for more than 122 seconds.
> [  369.724323]       Not tainted 6.7.0-rc8-next-20240102+ #1
> [  369.727077] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  369.730717] task:fsstress        state:D stack:0     pid:18269 tgid:18269 ppid:1      flags:0x00004006
> [  369.734945] Call Trace:
> [  369.736468]  <TASK>
> [  369.737768]  __schedule+0x237/0x720
> [  369.739593]  schedule+0x30/0xd0
> [  369.741310]  schedule_preempt_disabled+0x15/0x30
> [  369.743555]  rwsem_down_read_slowpath+0x240/0x4d0
> [  369.745634]  ? xlog_cil_force_seq+0x200/0x270 [xfs]
> [  369.747859]  down_read+0x49/0xa0
> [  369.749436]  super_lock+0xf1/0x120
> [  369.751008]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  369.753530]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  369.755865]  ? xfs_log_force+0x20c/0x230 [xfs]
> [  369.758147]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  369.760391]  ? __pfx_sync_fs_one_sb+0x10/0x10
> [  369.762516]  iterate_supers+0x5a/0xe0
> [  369.764403]  ksys_sync+0x64/0xb0
> [  369.766104]  __do_sys_sync+0xe/0x20
> [  369.767856]  do_syscall_64+0x6c/0x170
> [  369.769684]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [  369.771975] RIP: 0033:0x7f2b24e3ed5b
> [  369.773732] RSP: 002b:00007fff7183b058 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
> [  369.777022] RAX: ffffffffffffffda RBX: 000000000007a120 RCX: 00007f2b24e3ed5b
> [  369.780177] RDX: 0000000000000000 RSI: 00000000796b9c69 RDI: 0000000000000000
> [  369.783356] RBP: 028f5c28f5c28f5c R08: 0000000000000008 R09: 0000000000001010
> [  369.787096] R10: 00007f2b24e15228 R11: 0000000000000202 R12: 0000000000000000
> [  369.790256] R13: 8f5c28f5c28f5c29 R14: 00000000004034c0 R15: 00007f2b250156c0
> [  369.793499]  </TASK>
> 
> The sb->s_umount semaphore was owned by a task executing systemd-coredump. The
> systemd-coredump task was busy executing shrink_dcache_parent() as shown below,
> 
> systemd-coredum   18274 [001] 85214.162988:                probe:d_walk: (ffffffff88218580) parent_path="/" fs_type="tmpfs"
>         ffffffff88218581 d_walk+0x1 ([kernel.kallsyms])
>         ffffffff8821a8e2 shrink_dcache_parent+0x52 ([kernel.kallsyms])
>         ffffffff8821ac9b shrink_dcache_for_umount+0x3b ([kernel.kallsyms])
>         ffffffff881f9c10 generic_shutdown_super+0x20 ([kernel.kallsyms])
>         ffffffff881fa667 kill_litter_super+0x27 ([kernel.kallsyms])
>         ffffffff881fb3b5 deactivate_locked_super+0x35 ([kernel.kallsyms])
>         ffffffff88226d30 cleanup_mnt+0x100 ([kernel.kallsyms])
>         ffffffff87eef72c task_work_run+0x5c ([kernel.kallsyms])
>         ffffffff87ec9763 do_exit+0x2b3 ([kernel.kallsyms])
>         ffffffff87ec9b90 do_group_exit+0x30 ([kernel.kallsyms])
>         ffffffff87ec9c38 [unknown] ([kernel.kallsyms])
>         ffffffff88b9930c do_syscall_64+0x6c ([kernel.kallsyms])
>         ffffffff88c000e5 entry_SYSCALL_64+0xa5 ([kernel.kallsyms])

Curious.  I wonder if systemd-coredump@ is tearing down its private
/tmp or something?  I've never had systemd coredump installed on a test
vm.

> Trying to obtain more debug data via perf caused the 'perf record' task to
> indefinitely enter into the TASK_UNINTERRUPTIBLE state. I will try to recreate
> the bug and debug it further.

Doh. :(

--D
> 
> The following is the fstests configuration that was used.
>   FSTYP=xfs
>   TEST_DEV=/dev/loop7
>   TEST_DIR=/media/test
>   SCRATCH_DEV=/dev/loop5
>   SCRATCH_MNT=/media/scratch
>   MKFS_OPTIONS='-f -m reflink=1,rmapbt=1, -i sparse=1,'
>   MOUNT_OPTIONS='-o usrquota,grpquota,prjquota'
>   LOGWRITES_DEV=/dev/loop6
>   SOAK_DURATION=9900
> 
> The recoveryloop group of tests can then be executed by,
> $ ./check -g recoveryloop
> 
> -- 
> Chandan
> 

