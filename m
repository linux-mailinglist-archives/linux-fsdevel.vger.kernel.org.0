Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856BD290CC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 22:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393364AbgJPUdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 16:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393322AbgJPUdD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:33:03 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B54420878;
        Fri, 16 Oct 2020 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602880382;
        bh=rCeTzsfFajUHfdF6Z2bKxTpM/2AbhqPSruQzC/G3qKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pgzaSJYjQJEdVSbtW++m+KOsc2chMUtEwDAMKOylsPA4rIxzDmdLbgop/QYSn4hlt
         q616M4UobLlyBfoXWfPeYHcg2xQjzj0C+RjtmXFjrPFM2Gf02KQk0YqnJIGQTJ88Bg
         gbqvkA/Wezg6NdhALItzD/D0n5YsZXQW4Fa1HJfs=
Date:   Fri, 16 Oct 2020 13:33:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     bugzilla-daemon@bugzilla.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, haxk612@gmail.com
Subject: Re: [Bug 209719] New: NULL pointer dereference
Message-Id: <20201016133301.aaff2b261a0afe5e15a32138@linux-foundation.org>
In-Reply-To: <bug-209719-27@https.bugzilla.kernel.org/>
References: <bug-209719-27@https.bugzilla.kernel.org/>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Fri, 16 Oct 2020 14:59:08 +0000 bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=209719
> 
>             Bug ID: 209719
>            Summary: NULL pointer dereference
>            Product: Memory Management
>            Version: 2.5
>     Kernel Version: 5.9-next
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: blocking
>           Priority: P1
>          Component: Other
>           Assignee: akpm@linux-foundation.org
>           Reporter: haxk612@gmail.com
>         Regression: No
> 
> Created attachment 293041
>   --> https://bugzilla.kernel.org/attachment.cgi?id=293041&action=edit
> Kernel oops from journalctl
> 
> Im sorry i didnt know to which table i should report this bug. So if i reported
> it to incorrect product and component then im sorry.
> 
> System: Acer Nitro 5 AN515-42
> Kernel: 5.9-next-20201015
> 
> I updated to newest tag on linux-next and system crashed at boot.
> Previously it only showed systemD message and then hidden it which i suspect is
> AMDGPU bug. I guess this bug is happening even before that one or the AMDGPU
> bug was fixed in linux-next.

Thanks for the report.

Probably autofs is interacting poorly with the __kernel_write() changes
in Christoph's 4d03e3cc59828 ("fs: don't allow kernel reads and writes
without iter ops").  I pasted the relevant oops trace.  Could folks
please take a look?


Oct 16 16:38:53 TimeMachine kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
Oct 16 16:38:53 TimeMachine kernel: #PF: supervisor read access in kernel mode
Oct 16 16:38:53 TimeMachine kernel: #PF: error_code(0x0000) - not-present page
Oct 16 16:38:53 TimeMachine kernel: PGD 0 P4D 0 
Oct 16 16:38:53 TimeMachine kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
Oct 16 16:38:53 TimeMachine kernel: CPU: 1 PID: 319 Comm: systemd-binfmt Not tainted 5.9.0-next-20201015-1-next-git #1
Oct 16 16:38:53 TimeMachine kernel: Hardware name: Acer Nitro AN515-42/Freed_RRS, BIOS V1.13 02/11/2019
Oct 16 16:38:53 TimeMachine kernel: RIP: 0010:__kernel_write+0x11b/0x2c0
Oct 16 16:38:53 TimeMachine kernel: Code: 8b 54 24 20 0f b6 92 8f 00 00 00 65 48 8b 0c 25 c0 7b 01 00 48 8b b1 48 08 00 00 31 c9 48 85 f6 74 04 0f b7 4e 14 89 44 24 58 <48> 8b 03 be 01 00 00 00 48 8d 7c 24 10 66 89 54 24 5c 48 89 e2 66
Oct 16 16:38:53 TimeMachine kernel: RSP: 0018:ffff9c04c0e6f880 EFLAGS: 00010286
Oct 16 16:38:53 TimeMachine kernel: RAX: 0000000000020000 RBX: 0000000000000000 RCX: 0000000000000000
Oct 16 16:38:53 TimeMachine kernel: RDX: 0000000000000000 RSI: ffff928701167a28 RDI: ffff9c04c0e6f8e8
Oct 16 16:38:53 TimeMachine kernel: RBP: ffff9287046a7d00 R08: 0000000000000130 R09: 00000010af978cf7
Oct 16 16:38:53 TimeMachine kernel: R10: 000000000000000f R11: ffff928708ce9110 R12: ffff9287046a7d00
Oct 16 16:38:53 TimeMachine kernel: R13: ffff9c04c0e6f8b8 R14: ffff928709f6d868 R15: 0000000000000130
Oct 16 16:38:53 TimeMachine kernel: FS:  00007fb657195000(0000) GS:ffff928a3fc40000(0000) knlGS:0000000000000000
Oct 16 16:38:53 TimeMachine kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 16 16:38:53 TimeMachine kernel: CR2: 0000000000000000 CR3: 0000000102f8e000 CR4: 00000000003506e0
Oct 16 16:38:53 TimeMachine kernel: Call Trace:
Oct 16 16:38:53 TimeMachine kernel:  autofs_notify_daemon+0x13f/0x2b0
Oct 16 16:38:53 TimeMachine kernel:  ? cpumask_next_and+0x19/0x20
Oct 16 16:38:53 TimeMachine kernel:  autofs_wait+0x606/0x7e0
Oct 16 16:38:53 TimeMachine kernel:  ? chacha_block_generic+0x6f/0xb0
Oct 16 16:38:53 TimeMachine kernel:  ? autofs_mount_wait+0x49/0xf0
Oct 16 16:38:53 TimeMachine kernel:  ? _raw_spin_unlock+0x16/0x30
Oct 16 16:38:53 TimeMachine kernel:  autofs_mount_wait+0x49/0xf0
Oct 16 16:38:53 TimeMachine kernel:  autofs_d_automount+0xd9/0x1f0
Oct 16 16:38:53 TimeMachine kernel:  __traverse_mounts+0x8f/0x220
Oct 16 16:38:53 TimeMachine kernel:  step_into+0x3d6/0x700
Oct 16 16:38:53 TimeMachine kernel:  walk_component+0x83/0x1b0
Oct 16 16:38:53 TimeMachine kernel:  ? _raw_spin_unlock+0x16/0x30
Oct 16 16:38:53 TimeMachine kernel:  link_path_walk+0x25d/0x390
Oct 16 16:38:53 TimeMachine kernel:  path_openat+0x8d/0x10b0
Oct 16 16:38:53 TimeMachine kernel:  ? _raw_read_unlock+0x18/0x30
Oct 16 16:38:53 TimeMachine kernel:  ? kmem_cache_free+0x116/0x450
Oct 16 16:38:53 TimeMachine kernel:  do_filp_open+0x9c/0x140
Oct 16 16:38:53 TimeMachine kernel:  do_sys_openat2+0xb1/0x160
Oct 16 16:38:53 TimeMachine kernel:  __x64_sys_openat+0x54/0x90
Oct 16 16:38:53 TimeMachine kernel:  do_syscall_64+0x33/0x40
Oct 16 16:38:53 TimeMachine kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 16 16:38:53 TimeMachine kernel: RIP: 0033:0x7fb657f85c1b

