Return-Path: <linux-fsdevel+bounces-34177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CD19C3694
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 03:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557092815CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE47A85260;
	Mon, 11 Nov 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LM20ucsf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83823CB;
	Mon, 11 Nov 2024 02:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731292506; cv=none; b=IQ9zdIaZTFOMz3frmLUVEQ9mylfLwy8vI5APAoZa6DRXHpbnl3lYUXP63NTrXojsZRJE8TwznJg5p9+FEwL3vANw9oID7DmC602id4bjkndYpzE3VHDAuMqy7yRaFYLuFSb+8eALSaJ/3b1o/LwAiVPafnStyXIwvRnW9hy3QLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731292506; c=relaxed/simple;
	bh=N4u/9Qlg4NarCD+XkWN+IgphnpzAjEM/upXCTa11kBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V1FiKJJvt9Ee2PxFIOSWJcn3hw5d33jHqhFqCbV20dxotEfefSUPrAmp9IQ2fEEvYvx+VZq4mbXMp5Ov0C2Yg822I7GpUFNO5FbGDuthyyFi3Wg9drJqWDzWwpXGR+/CSR0HMSEAaoAf8zHwddpQ/3cUZrjBQF22IG2yk+/sunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LM20ucsf; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731292500; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CU3B1EyfsLW6KcRonKtvq9y8mTUGD04GuiPTTgA6r48=;
	b=LM20ucsfEJnQhI6Hqm2An/mNK8R329IqH0702yjy8Lc1+KOY3DIYJKeNV+M3pRjWhyDh/WFhzXgNll5nrsEsXhJBiap9YK38tNkF5XHvYtBG5m+3sq9uSJPRKHfsGw9mWge+yYK2VN+WoXCko4iM3ml723PpFzmD3eTlPCC/WUw=
Received: from 30.221.130.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJ3wtz9_1731292499 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 10:34:59 +0800
Message-ID: <916771cb-6131-4f81-8aed-33877dbdde97@linux.alibaba.com>
Date: Mon, 11 Nov 2024 10:34:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in read_cache_folio
To: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <66f574eb.050a0220.211276.0076.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <66f574eb.050a0220.211276.0076.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/26 22:51, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16084107980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba9c4620d9519d1f
> dashboard link: https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11084107980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a0d880580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-88264981.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e96d7b6835d2/vmlinux-88264981.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0e1e66778641/Image-88264981.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Mem abort info:
>    ESR = 0x0000000086000006
>    EC = 0x21: IABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x06: level 2 translation fault
> user pgtable: 4k pages, 52-bit VAs, pgdp=00000000462cce00
> [0000000000000000] pgd=080000004468e003, p4d=08000000466cc003, pud=0800000046cd6003, pmd=0000000000000000
> Internal error: Oops: 0000000086000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 UID: 0 PID: 3265 Comm: syz-executor218 Tainted: G    B              6.11.0-syzkaller-08481-g88264981f208 #0
> Tainted: [B]=BAD_PAGE
> Hardware name: linux,dummy-virt (DT)
> pstate: 61400809 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=-c)
> pc : 0x0
> lr : filemap_read_folio+0x44/0xf4 mm/filemap.c:2363
> sp : ffff800088e6bac0
> x29: ffff800088e6bac0 x28: f1f000000474e000 x27: 0000000020ffd000
> x26: 0000000000000000 x25: 0000000000000000 x24: 0000000002100cca
> x23: f6f0000006cd5c00 x22: 0000000000000000 x21: f6f0000006cd5c00
> x20: 0000000000000000 x19: ffffc1ffc02e3300 x18: ffff800088e6bc20
> x17: ffff8000804fee60 x16: ffff80008052fe10 x15: 0000000000000001
> x14: 0000000000000000 x13: 0000000000000003 x12: 00000000000706a3
> x11: 0000000000000001 x10: ffff800081f19060 x9 : 0000000000000000
> x8 : fff07ffffd1f0000 x7 : fff000007f8e9d60 x6 : 0000000000000002
> x5 : ffffc1ffc02e3300 x4 : 0000000000000000 x3 : faf0000005491240
> x2 : 0000000000000000 x1 : ffffc1ffc02e3300 x0 : f6f0000006cd5c00
> Call trace:
>   0x0
>   do_read_cache_folio+0x18c/0x29c mm/filemap.c:3821
>   read_cache_folio+0x14/0x20 mm/filemap.c:3853
>   freader_get_folio+0x1a8/0x1f8 lib/buildid.c:72
>   freader_fetch+0x44/0x164 lib/buildid.c:115
>   __build_id_parse.isra.0+0x98/0x2a8 lib/buildid.c:300
>   build_id_parse+0x18/0x24 lib/buildid.c:354
>   do_procmap_query+0x670/0x7a0 fs/proc/task_mmu.c:534
>   procfs_procmap_ioctl+0x2c/0x44 fs/proc/task_mmu.c:613
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:907 [inline]
>   __se_sys_ioctl fs/ioctl.c:893 [inline]
>   __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:893
>   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>   invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
>   el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
>   do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
>   el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
>   el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
>   el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
> Code: ???????? ???????? ???????? ???????? (????????)
> ---[ end trace 0000000000000000 ]---
> 

Sorry, I don't think the syz subsystems is correct
for this report (it seems related to procfs), so

#syz set subsystems: fs

Thanks,
Gao Xiang

