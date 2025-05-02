Return-Path: <linux-fsdevel+bounces-47887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862DEAA6953
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 05:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB254A5AF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 03:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B41719ABC2;
	Fri,  2 May 2025 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mALTpKF4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8661E487;
	Fri,  2 May 2025 03:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746156587; cv=none; b=sNDZBZ270Wc1eJgvK890UoJzA4eMbujHfsXhfFjAudZsXsQg1vudraqlb2iGmthi/251KaEjO8/T8MFsfsXnIdyGDKVhVb4Gsa+dqw/xB2Wx93pUU8PE6C7FxsC8EpKFpZW6JOHOPXGCr+dxkiGFeCvwkp7+JVJHXLIZX1RhvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746156587; c=relaxed/simple;
	bh=1Vfo6UxyrVA8Uw2LFErCgOYbbOibb5xD9ULhiLHKILI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mBth8AX1PwKHIgruzpECMNjKpeeXWUax+4RMaE2NSqOsX/gzQ/7aygv5/MN+e02En050xj5we/DHD3wYk+yZID0eeKisC4SzSGwKXoiPGacevuLlPdAY5ThlT8V20vkiMeSaTJEZO7KtGBRZmuqcxqBn9QYtlGZfD6dGS92VP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mALTpKF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44CBC4CEE9;
	Fri,  2 May 2025 03:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746156584;
	bh=1Vfo6UxyrVA8Uw2LFErCgOYbbOibb5xD9ULhiLHKILI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mALTpKF4SJBYkZgWGKhNgqJesO7HoQnZzCbTTiN8MU2+R8R+ED7sS/B5yBZWB+/ac
	 s3XDg347KVjXWG6LwRSOqghv3wXEagFovu9dBIt3mfUOO7ydNYjI0oI3Q7rT/uPn5b
	 artr3EP8Wbos0/CvDjqWm14UPP7rACTTXMmC7Og4=
Date: Thu, 1 May 2025 20:29:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "huk23@m.fudan.edu.cn" <huk23@m.fudan.edu.cn>
Cc: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, =?UTF-8?B?55m954OB?=
 =?UTF-8?B?5YaJ?= <baishuoran@hrbeu.edu.cn>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "syzkaller@googlegroups.com"
 <syzkaller@googlegroups.com>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 gfs2@lists.linux.dev
Subject: Re: WARNING in __folio_mark_dirty
Message-Id: <20250501202943.e72b7bae3d1957efa60db553@linux-foundation.org>
In-Reply-To: <TYSPR06MB7158B63753ECD29758D09D49F68D2@TYSPR06MB7158.apcprd06.prod.outlook.com>
References: <TYSPR06MB7158B63753ECD29758D09D49F68D2@TYSPR06MB7158.apcprd06.prod.outlook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 2 May 2025 03:26:20 +0000 "huk23@m.fudan.edu.cn" <huk23@m.fudan.edu.cn> wrote:

> Dear Maintainers，
> 

Let's Cc the gfs2 developers.

Do you know if this is reproducible on any other filesystem?

> 
> When using our customized Syzkaller to fuzz the latest Linux kernel, the following crash (37th and 76th)was triggered.
> 
> 
> 37th：
> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> git tree: upstream
> Output:https://github.com/pghk13/Kernel-Bug/blob/main/1220_6.13rc_KASAN/2.%E5%9B%9E%E5%BD%92-11/14-KASAN_%20slab-out-of-bounds%20Read%20in%20hfsplus_bnode_read/14call_trace.txt
> Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.15rc1/config.txt
> C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined/37repro.c
> Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined/37repro.txt
> 
> 76th：
> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> git tree: upstream
> Output:https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined/76call_trace.txt
> Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.15rc1/config.txt
> C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined/76repro.c
> Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined/76repro.txt
> 
> 
> 
> The two errors seem to have the same error points, but there are a few differences in the process. They all trigger warnings in the __folio_mark_dirty+0xb50/0xf10 function of backing-dev.h:251. In __folio_mark_dirty function, a warning is triggered when the code tries to access or modify the backing-dev information. The 76th call stack has longer call chains from file writebacks: writeback work queues → writeback inodes → GFS2 write inodes → log refreshes.
> We have reproduced this issue several times on 6.15-rc1 again.
> 
> 
> 
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>, Shuoran Bai <baishuoran@hrbeu.edu.cn>
> 
> 
> 
> 37th：
> ==================================================================
> WARNING: CPU: 2 PID: 9494 at ./include/linux/backing-dev.h:251 __folio_mark_dirty+0xb50/0xf10
> Modules linked in:
> CPU: 2 UID: 0 PID: 9494 Comm: gfs2_logd/syz:s Not tainted 6.15.0-rc1 #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:__folio_mark_dirty+0xb50/0xf10
> Code: ff ff 48 8d 78 70 e8 af e3 76 09 31 ff 89 c6 89 44 24 08 e8 72 d3 c5 ff 8b 44 24 08 85 c0 0f 85 af f9 ff ff e8 51 d1 c5 ff 90 <0f> 0b 90 e9 a1 f9 ff ff e8 43 d1 c5 ff 90 0f 0b 90 e9 59 f5 ff ff
> RSP: 0018:ffffc90014bb7b18 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: ffff88804298cb58 RCX: ffffffff81f5408e
> RDX: 0000000000000000 RSI: ffff888023edc900 RDI: 0000000000000002
> RBP: ffffea00015c9d80 R08: 0000000000000000 R09: ffffed10085319a0
> R10: ffffed100853199f R11: ffff88804298ccff R12: 0000000000000246
> R13: ffff888049bd8bc8 R14: 0000000000000001 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff888097c6b000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff2c7be9028 CR3: 000000000e180000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  mark_buffer_dirty+0x358/0x410
>  gfs2_unpin+0x106/0xef0
>  buf_lo_after_commit+0x155/0x230
>  gfs2_log_flush+0xd95/0x2cb0
>  gfs2_logd+0x29b/0x12c0
>  kthread+0x447/0x8a0
>  ret_from_fork+0x48/0x80
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> extracting prog: 1h56m11.644263162s
> minimizing prog: 14m12.695891417s
> simplifying prog options: 0s
> extracting C: 32.234365976s
> simplifying C: 9m50.565845853s
> 
> 
> 
> 
> 
> 76th：
> ==================================================================
> WARNING: CPU: 3 PID: 3051 at ./include/linux/backing-dev.h:251 __folio_mark_dirty+0xb50/0xf10
> Modules linked in:
> CPU: 3 UID: 0 PID: 3051 Comm: kworker/u18:5 Not tainted 6.15.0-rc1 #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: writeback wb_workfn (flush-7:0)
> RIP: 0010:__folio_mark_dirty+0xb50/0xf10
> Code: ff ff 48 8d 78 70 e8 af e3 76 09 31 ff 89 c6 89 44 24 08 e8 72 d3 c5 ff 8b 44 24 08 85 c0 0f 85 af f9 ff ff e8 51 d1 c5 ff 90 <0f> 0b 90 e9 a1 f9 ff ff e8 43 d1 c5 ff 90 0f 0b 90 e9 59 f5 ff ff
> RSP: 0018:ffffc90011e2f410 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: ffff88804266bfd8 RCX: ffffffff81f5408e
> RDX: 0000000000000000 RSI: ffff888043e48000 RDI: 0000000000000002
> RBP: ffffea000086e9c0 R08: 0000000000000000 R09: ffffed10084cd830
> R10: ffffed10084cd82f R11: ffff88804266c17f R12: 0000000000000246
> R13: ffff888012bf87f0 R14: 0000000000000001 R15: 0000000000000001
> FS: 0000000000000000(0000) GS:ffff8880eb46b000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6410e8e140 CR3: 0000000023648000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
> <TASK>
> mark_buffer_dirty+0x358/0x410
> gfs2_unpin+0x106/0xef0
> buf_lo_after_commit+0x155/0x230
> gfs2_log_flush+0xd95/0x2cb0
> gfs2_write_inode+0x371/0x450
> __writeback_single_inode+0xad7/0xf50
> writeback_sb_inodes+0x5f5/0xee0
> __writeback_inodes_wb+0xbe/0x270
> wb_writeback+0x728/0xb50
> wb_workfn+0x96e/0xe90
> process_scheduled_works+0x5de/0x1bd0
> worker_thread+0x5a9/0xd10
> kthread+0x447/0x8a0
> ret_from_fork+0x48/0x80
> ret_from_fork_asm+0x1a/0x30
> </TASK>
> 
> 
> 
> thanks,
> Kun Hu
> 

