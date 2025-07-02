Return-Path: <linux-fsdevel+bounces-53635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944FAAF1505
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1077A8F51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCE426D4E2;
	Wed,  2 Jul 2025 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f/gwhw8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A126B77A
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458066; cv=none; b=W289ucJfh243gLoumiM9x04GJjPd2DQkJpAeToZYj87DwZJiqx30R5XaE9OHDz4DLY06ks59IdcWTFaQviwFxPptd3vomvYipXTC4Nwm03bh4pqbaRxg8eGW7AZKBc5/m7zYOf1t4j7XYMwQ4RjsqK4pf+NAEQCdUnvMXmFipR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458066; c=relaxed/simple;
	bh=ZI2jAdd/tl2LrFFYLbIi1x6/BWgv67q5CbcZq/xlx8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBC22+/nztQxovGjqUKITaKBSzIFEu0gAhnVjW1H96esR0UDbyQeqTdSh4wHuKWFOUg0zCJVgpd96kALWJBAAJqAyX9+sceXztkD1+WGfmDeMo8vJdDhTCWE3tnVii3OEYpZMrfTwmY/AkTFvDqef1P9fl0N3YYbsdVy5AyPO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f/gwhw8J; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a522224582so3550906f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751458062; x=1752062862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlxXRDx1sNDGTfPnLyjcJ7+ui+dpSHyY1Yt32/Z6wyI=;
        b=f/gwhw8JRv1QJN2wvccnqqrHMtNdf2Gc1kN/yrhh05uCnz0ALGFnnxWiCzbxQfgQMK
         /8MhOp9sLX2bOBCiFcOeWpV2A2sblz3clzXIwNNB9/8d3qYugRrMtN68Bj/iU4MMJI3T
         ZBq2plTjD4TSB8SMNEFySVR96UlEdDybyYWhsg3T/oNkiIfcdxiIVoeWLBQHkb5zGcYp
         eVcsGB1cckKasgNgU0vDM3LowE/SiTFN++HnEwgfIApxXEU8+jiwH1LxQWWuCD+voRH3
         CdvM/FupWVF4YNv5ur+dVyh3jB7BtbMHs+i3EHfnsI1VBGYa7CUYYGBXL5YKRtJ0KaV/
         FiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751458062; x=1752062862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlxXRDx1sNDGTfPnLyjcJ7+ui+dpSHyY1Yt32/Z6wyI=;
        b=AzgLFYEENuLsNY4IU15mNzUcF1UzZuVttjy4yqQuMdKgzpR3KJUXOZ8hTrA9eCPX2e
         qtbLPupjfuK5GiMlETIR4oe7Orr26NIlqo2PBD/eUrigq/nlYHUtq6ZPZ8jNPFEzmGI8
         VSH2wjOmx2X1+ezjtJ75HuHK1Rx8qniGW/v3/Lmjq4d++EmCPvxxqqOMJOFlHgPL3/Vb
         yl+aTPc2l0FLGMiVkSU7zK2SxIZECxgbudcYif+IJ+4fZibnbZeo7xNxMFRdxtVioLVX
         HZ4bIJDT5O4NCRITm330LvOty/Ieg1GNCK0Q8UsWHkuW7+6kisl5Cb7EhHGhYw2fJl/+
         nZUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVObljxrUnR9sQ3XRXRIBKAsiQM7CDy4B+ZsuyJK4mUJ8bhRRKkTCJwAxRjAZiSG0XxlkRuMPZLQSK8ztRc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0afkBuxleRJx5NbvlkwSdCAm3PkRJ+TlhVGpRB1SYtB0xS12c
	MqVBtdtjbujQN/029lBbJOW2556wkmrOxhHkOHXbBF+/8MX4Ji5Ut12qiWagP1KNEeU=
X-Gm-Gg: ASbGncsyAA3x+1HtRY1AGiwnlFb1cmWprHuHXgYfhPoaI3OfRYawOlklpt0+g2KNgnG
	K8wcTSgI3jHiq3OM6kmr4r+3BvzKTpa+Svm0Ycxjz6GIku1JciTZOZ1TGug2thqffbSdwdbgiYV
	rcslYwPK2Clzo680ArVJzZk+3aajO1PVOC0fxEH282OecXC7Zk0FBKSW385OQxcX0XVYyUQz86s
	RAmFq37nXV7rAJEc5V0i1nfNcGenuBJjTjRWRKNDnIwmZOk4Kod3eYZhvqKQZDoAq0SkK3fBEUR
	Ik/MnuuOpbaTYXURAakJyHAMrbPt50TNyTtQUV1WucP4t7ZcifA+Hoo8VLsfQPRL
X-Google-Smtp-Source: AGHT+IHaMqNxngBQGRe+eUlRc86pGW6SCRbENB7BAWCe6mwd1igaBcobAUdMU/n0hBvj41XCFKlSrA==
X-Received: by 2002:a5d:5e88:0:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3b2000b09d9mr1603596f8f.32.1751458061454;
        Wed, 02 Jul 2025 05:07:41 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39f488sm135491895ad.132.2025.07.02.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:07:40 -0700 (PDT)
Date: Wed, 2 Jul 2025 14:07:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-out-of-bounds in vsnprintf triggered by large
 stack frame
Message-ID: <aGUhAOkPPNRIpqXN@pathway.suse.cz>
References: <CA+Y4EYic=CpvZrjsRYt99PaoSDobt8=XKHCiiWq93xNSzk8wXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Y4EYic=CpvZrjsRYt99PaoSDobt8=XKHCiiWq93xNSzk8wXw@mail.gmail.com>

JFYI, the mail has later been re-sent as a plain text and the
discussion happens in the other thread, see
https://lore.kernel.org/r/9052e70eb1cf8571c1b37bb0cee19aaada7dfe3d.camel@gmail.com

Best Regards,
Petr

On Tue 2025-07-01 21:40:11, Shardul Bankar wrote:
> Hello,
> 
> I would like to report a slab-out-of-bounds bug that can be reliably
> reproduced with a purpose-built kernel module. This report was initially
> sent to security@kernel.org, and I was advised to move it to the public
> lists.
> 
> I have confirmed this issue still exists on the latest mainline kernel
> (v6.16.0-rc4).
> 
> Bug Summary:
> 
> The bug is a KASAN-reported slab-out-of-bounds write within vsnprintf. It
> appears to be caused by a latent memory corruption issue, likely related to
> the names_cache slab.
> 
> The vulnerability can be triggered by loading a kernel module that
> allocates an unusually large stack frame. When compiling the PoC module,
> GCC explicitly warns about this: warning: the frame size of 29760 bytes is
> larger than 2048 bytes. This "stack grooming" positions the task's stack to
> overlap with a stale pointer from a freed names_cache object. A subsequent
> call to pr_info() then uses this corrupted value, leading to the
> out-of-bounds write.
> 
> Reproducer:
> 
> The following minimal kernel module reliably reproduces the crash on my
> x86-64 test system.
> 
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/printk.h>
> 
> #define STACK_FOOTPRINT (3677 * sizeof(void *))
> 
> static int __init final_poc_init(void)
> {
>     volatile char stack_eater[STACK_FOOTPRINT];
>     stack_eater[0] = 'A'; // Prevent optimization
> 
>     pr_info("Final PoC: Triggering bug with controlled stack layout.\n");
> 
>     return -EAGAIN;
> }
> 
> static void __exit final_poc_exit(void) {}
> 
> module_init(final_poc_init);
> module_exit(final_poc_exit);
> MODULE_LICENSE("GPLv2");
> MODULE_DESCRIPTION("A PoC to trigger a kernel bug by creating a large stack
> frame.");
> 
> 
> KASAN Crash Log (on mainline v6.16.0-rc4):
> 
> Loading the module produces the following KASAN report and kernel panic:
> 
> [  214.241371] 006_state_corruption_poc_reduce_size: loading out-of-tree
> module taints kernel.
>   214.242338] Final PoC: Triggering bug with controlled stack layout.
> [  214.242340]
> ==================================================================
> [  214.242341] BUG: KASAN: slab-out-of-bounds in vsnprintf+0x5a6/0x1400
> [  214.242346] Write of size 1 at addr ffff88814269fee0 by task insmod/2258
> [  214.242348]
> [  214.242350] CPU: 6 UID: 0 PID: 2258 Comm: insmod Tainted: G           OE
>       6.16.0-rc4-custombuild #139 PREEMPT(lazy)
> [  214.242353] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  214.242354] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  214.242355] Call Trace:
> [  214.242356]  <TASK>
> [  214.242359]  ? console_emit_next_record+0x12b/0x450
> [  214.242362]  ? __pfx_console_emit_next_record+0x10/0x10
> [  214.242363]  ? __asan_memmove+0x3c/0x60
> [  214.242367]  ? console_flush_all+0x36c/0x570
> [  214.242368]  ? __pfx_console_flush_all+0x10/0x10
> [  214.242370]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242372]  ? console_unlock+0xbf/0x240
> [  214.242373]  ? __pfx_console_unlock+0x10/0x10
> [  214.242375]  ? __down_trylock_console_sem.isra.0+0x2e/0x50
> [  214.242377]  ? vprintk_emit+0x412/0x4b0
> [  214.242379]  ? __pfx_vprintk_emit+0x10/0x10
> [  214.242380]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242382]  ? _printk+0xc7/0x100
> [  214.242384]  ? __pfx__printk+0x10/0x10
> [  214.242386]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242388]  ? final_poc_init+0xd7/0xff0
> [006_state_corruption_poc_reduce_size]
> [  214.242390]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242486]  ? do_one_initcall+0xa4/0x380
> [  214.242488]  ? __pfx_do_one_initcall+0x10/0x10
> [  214.242490]  ? kasan_unpoison+0x44/0x70
> [  214.242492]  ? do_init_module+0x2cc/0x8e0
> [  214.242494]  ? __pfx_do_init_module+0x10/0x10
> [  214.242495]  ? netfs_unbuffered_read_iter_locked+0x47f/0x980 [netfs]
> [  214.242542]  ? init_module_from_file+0xe1/0x150
> [  214.242543]  ? __pfx_init_module_from_file+0x10/0x10
> [  214.242544]  ? vfs_read+0x6da/0xa40
> [  214.242547]  ? _raw_spin_lock+0x83/0xe0
> [  214.242549]  ? __pfx__raw_spin_lock+0x10/0x10
> [  214.242550]  ? cred_has_capability.isra.0+0x12c/0x220
> [  214.242553]  ? idempotent_init_module+0x224/0x750
> [  214.242555]  ? __pfx_idempotent_init_module+0x10/0x10
> [  214.242557]  ? fdget+0x53/0x4a0
> [  214.242558]  ? security_capable+0x87/0x150
> [  214.242561]  ? __x64_sys_finit_module+0xcd/0x150
> [  214.242562]  ? do_syscall_64+0x82/0x2c0
> [  214.242564]  ? count_memcg_events+0x1aa/0x410
> [  214.242567]  ? handle_mm_fault+0x492/0x910
> [  214.242569]  ? do_user_addr_fault+0x4b0/0xa30
> [  214.242571]  ? exc_page_fault+0x75/0xd0
> [  214.242573]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  214.242575]  </TASK>
> [  214.242576]
> [  214.242577] Allocated by task 2255:
> [  214.242578]  kasan_save_stack+0x30/0x50
> [  214.242580]  kasan_save_track+0x14/0x30
> [  214.242581]  __kasan_slab_alloc+0x7e/0x90
> [  214.242582]  kmem_cache_alloc_noprof+0x148/0x420
> [  214.242584]  getname_flags.part.0+0x48/0x540
> [  214.242586]  do_sys_openat2+0xb1/0x180
> [  214.242588]  __x64_sys_openat+0x10e/0x210
> [  214.242590]  do_syscall_64+0x82/0x2c0
> [  214.242591]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  214.242592]
> [  214.242592] Freed by task 2255:
> [  214.242593]  kasan_save_stack+0x30/0x50
> [  214.242594]  kasan_save_track+0x14/0x30
> [  214.242595]  kasan_save_free_info+0x3b/0x70
> [  214.242596]  __kasan_slab_free+0x52/0x70
> [  214.242598]  kmem_cache_free+0x17b/0x540
> [  214.242599]  do_sys_openat2+0x109/0x180
> [  214.242601]  __x64_sys_openat+0x10e/0x210
> [  214.242602]  do_syscall_64+0x82/0x2c0
> [  214.242603]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  214.242604]
> [  214.242605] Last potentially related work creation:
> [  214.242605] ------------[ cut here ]------------
> [  214.242606] pool index 109701 out of bounds (339) for stack id a1bbac86
> [  214.242623] WARNING: CPU: 6 PID: 2258 at lib/stackdepot.c:451
> depot_fetch_stack+0x68/0xb0
> [  214.242626] Modules linked in: 006_state_corruption_poc_reduce_size(OE+)
> 9p(E) rfkill(E) isofs(E) binfmt_misc(E) vfat(E) fat(E) ppdev(E)
> parport_pc(E) snd_pcm(E) parport(E) snd_timer(E) snd(E) virtio_net(E)
> soundcore(E) net_failover(E) joydev(E) bochs(E) failover(E) i2c_piix4(E)
> pcspkr(E) i2c_smbus(E) loop(E) nfnetlink(E) vsock_loopback(E)
> vmw_vsock_virtio_transport_common(E) vmw_vsock_vmci_transport(E) vsock(E)
> zram(E) vmw_vmci(E) lz4hc_compress(E) lz4_compress(E) 9pnet_virtio(E)
> 9pnet(E) floppy(E) netfs(E) serio_raw(E) ata_generic(E) pata_acpi(E)
> fuse(E) qemu_fw_cfg(E)
> [  214.242652] Unloaded tainted modules: snd_pcsp(E):1 hv_vmbus(E):1
> padlock_aes(E):2
> [  214.242657] CPU: 6 UID: 0 PID: 2258 Comm: insmod Tainted: G           OE
>       6.16.0-rc4-custombuild #139 PREEMPT(lazy)
> [  214.242659] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  214.242660] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  214.242660] RIP: 0010:depot_fetch_stack+0x68/0xb0
> [  214.242663] Code: c1 e7 04 81 e7 f0 3f 00 00 48 01 f8 8b 50 1c 85 d2 74
> 2a 48 83 c4 10 e9 16 a2 91 01 89 f9 48 c7 c7 08 61 c8 a5 e8 68 2f 58 fe
> <0f> 0b 31 c0 48 83 c4 10 c3 cc cc cc cc 0f 0b 31 c0 eb f1 0f 0b 31
> [  214.242664] RSP: 0018:ffff88814269faf8 EFLAGS: 00010046
> [  214.242666] RAX: 0000000000000000 RBX: ffffea000509a600 RCX:
> 0000000000000001
> [  214.242667] RDX: 1ffff110284d3f47 RSI: 0000000000000004 RDI:
> ffff88848ab2cf48
> [  214.242668] RBP: ffff88814269fee0 R08: ffffffffa1f4e7dc R09:
> ffffed10915659e9
> [  214.242669] R10: ffffed10915659ea R11: 0000000000000001 R12:
> ffff88814269fbe0
> [  214.242670] R13: ffffffffa4cf91e6 R14: 00000000fffffffe R15:
> ffff88814269fdc8
> [  214.242671] FS:  00007f5dec131740(0000) GS:ffff8884e241d000(0000)
> knlGS:0000000000000000
> [  214.242672] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  214.242673] CR2: 0000558a1aca08c0 CR3: 0000000104536000 CR4:
> 00000000000006f0
> [  214.242675] Call Trace:
> [  214.242676]  <TASK>
> [  214.242678]  ? console_emit_next_record+0x12b/0x450
> [  214.242680]  ? __pfx_console_emit_next_record+0x10/0x10
> [  214.242681]  ? __asan_memmove+0x3c/0x60
> [  214.242684]  ? console_flush_all+0x36c/0x570
> [  214.242685]  ? __pfx_console_flush_all+0x10/0x10
> [  214.242687]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242689]  ? console_unlock+0xbf/0x240
> [  214.242690]  ? __pfx_console_unlock+0x10/0x10
> [  214.242692]  ? __down_trylock_console_sem.isra.0+0x2e/0x50
> [  214.242694]  ? vprintk_emit+0x412/0x4b0
> [  214.242695]  ? __pfx_vprintk_emit+0x10/0x10
> [  214.242697]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242699]  ? _printk+0xc7/0x100
> [  214.242701]  ? __pfx__printk+0x10/0x10
> [  214.242703]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242704]  ? final_poc_init+0xd7/0xff0
> [006_state_corruption_poc_reduce_size]
> [  214.242706]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242834]  ? do_one_initcall+0xa4/0x380
> [  214.242835]  ? __pfx_do_one_initcall+0x10/0x10
> [  214.242837]  ? kasan_unpoison+0x44/0x70
> [  214.242839]  ? do_init_module+0x2cc/0x8e0
> [  214.242841]  ? __pfx_do_init_module+0x10/0x10
> [  214.242842]  ? netfs_unbuffered_read_iter_locked+0x47f/0x980 [netfs]
> [  214.242855]  ? init_module_from_file+0xe1/0x150
> [  214.242856]  ? __pfx_init_module_from_file+0x10/0x10
> [  214.242858]  ? vfs_read+0x6da/0xa40
> [  214.242859]  ? _raw_spin_lock+0x83/0xe0
> [  214.242861]  ? __pfx__raw_spin_lock+0x10/0x10
> [  214.242862]  ? cred_has_capability.isra.0+0x12c/0x220
> [  214.242864]  ? idempotent_init_module+0x224/0x750
> [  214.242866]  ? __pfx_idempotent_init_module+0x10/0x10
> [  214.242867]  ? fdget+0x53/0x4a0
> [  214.242868]  ? security_capable+0x87/0x150
> [  214.242871]  ? __x64_sys_finit_module+0xcd/0x150
> [  214.242872]  ? do_syscall_64+0x82/0x2c0
> [  214.242874]  ? count_memcg_events+0x1aa/0x410
> [  214.242875]  ? handle_mm_fault+0x492/0x910
> [  214.242877]  ? do_user_addr_fault+0x4b0/0xa30
> [  214.242879]  ? exc_page_fault+0x75/0xd0
> [  214.242880]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  214.242882]  </TASK>
> [  214.242883] ---[ end trace 0000000000000000 ]---
> [  214.242884] ------------[ cut here ]------------
> [  214.242885] corrupt handle or use after stack_depot_put()
> [  214.242892] WARNING: CPU: 6 PID: 2258 at lib/stackdepot.c:723
> stack_depot_print+0x43/0x50
> [  214.242895] Modules linked in: 006_state_corruption_poc_reduce_size(OE+)
> 9p(E) rfkill(E) isofs(E) binfmt_misc(E) vfat(E) fat(E) ppdev(E)
> parport_pc(E) snd_pcm(E) parport(E) snd_timer(E) snd(E) virtio_net(E)
> soundcore(E) net_failover(E) joydev(E) bochs(E) failover(E) i2c_piix4(E)
> pcspkr(E) i2c_smbus(E) loop(E) nfnetlink(E) vsock_loopback(E)
> vmw_vsock_virtio_transport_common(E) vmw_vsock_vmci_transport(E) vsock(E)
> zram(E) vmw_vmci(E) lz4hc_compress(E) lz4_compress(E) 9pnet_virtio(E)
> 9pnet(E) floppy(E) netfs(E) serio_raw(E) ata_generic(E) pata_acpi(E)
> fuse(E) qemu_fw_cfg(E)
> [  214.242915] Unloaded tainted modules: snd_pcsp(E):1 hv_vmbus(E):1
> padlock_aes(E):2
> [  214.242919] CPU: 6 UID: 0 PID: 2258 Comm: insmod Tainted: G        W  OE
>       6.16.0-rc4-custombuild #139 PREEMPT(lazy)
> [  214.242921] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  214.242921] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  214.242922] RIP: 0010:stack_depot_print+0x43/0x50
> [  214.242924] Code: ff ff 48 85 c0 74 17 8b 70 14 85 f6 74 0b 48 8d 78 20
> 31 d2 e9 2e eb 85 fe c3 cc cc cc cc 48 c7 c7 40 61 c8 a5 e8 8d 28 58 fe
> <0f> 0b c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
> [  214.242925] RSP: 0018:ffff88814269fb10 EFLAGS: 00010046
> [  214.242926] RAX: 0000000000000000 RBX: ffffea000509a600 RCX:
> 0000000000000001
> [  214.242927] RDX: 1ffff110284d3f4a RSI: 0000000000000004 RDI:
> ffff88848ab2cf48
> [  214.242928] RBP: ffff88814269fee0 R08: ffffffffa1f4e7dc R09:
> ffffed10915659e9
> [  214.242929] R10: ffffed10915659ea R11: ffffffffa87b4d46 R12:
> ffff88814269fbe0
> [  214.242930] R13: ffffffffa4cf91e6 R14: 00000000fffffffe R15:
> ffff88814269fdc8
> [  214.242931] FS:  00007f5dec131740(0000) GS:ffff8884e241d000(0000)
> knlGS:0000000000000000
> [  214.242932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  214.242933] CR2: 0000558a1aca08c0 CR3: 0000000104536000 CR4:
> 00000000000006f0
> [  214.242935] Call Trace:
> [  214.242935]  <TASK>
> [  214.242937]  ? console_emit_next_record+0x12b/0x450
> [  214.242939]  ? __pfx_console_emit_next_record+0x10/0x10
> [  214.242940]  ? __asan_memmove+0x3c/0x60
> [  214.242942]  ? console_flush_all+0x36c/0x570
> [  214.242944]  ? __pfx_console_flush_all+0x10/0x10
> [  214.242946]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242947]  ? console_unlock+0xbf/0x240
> [  214.242949]  ? __pfx_console_unlock+0x10/0x10
> [  214.242950]  ? __down_trylock_console_sem.isra.0+0x2e/0x50
> [  214.242952]  ? vprintk_emit+0x412/0x4b0
> [  214.242954]  ? __pfx_vprintk_emit+0x10/0x10
> [  214.242956]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242958]  ? _printk+0xc7/0x100
> [  214.242959]  ? __pfx__printk+0x10/0x10
> [  214.242961]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.242963]  ? final_poc_init+0xd7/0xff0
> [006_state_corruption_poc_reduce_size]
> [  214.242965]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.243090]  ? do_one_initcall+0xa4/0x380
> [  214.243091]  ? __pfx_do_one_initcall+0x10/0x10
> [  214.243093]  ? kasan_unpoison+0x44/0x70
> [  214.243095]  ? do_init_module+0x2cc/0x8e0
> [  214.243097]  ? __pfx_do_init_module+0x10/0x10
> [  214.243098]  ? netfs_unbuffered_read_iter_locked+0x47f/0x980 [netfs]
> [  214.243110]  ? init_module_from_file+0xe1/0x150
> [  214.243111]  ? __pfx_init_module_from_file+0x10/0x10
> [  214.243113]  ? vfs_read+0x6da/0xa40
> [  214.243114]  ? _raw_spin_lock+0x83/0xe0
> [  214.243116]  ? __pfx__raw_spin_lock+0x10/0x10
> [  214.243117]  ? cred_has_capability.isra.0+0x12c/0x220
> [  214.243119]  ? idempotent_init_module+0x224/0x750
> [  214.243121]  ? __pfx_idempotent_init_module+0x10/0x10
> [  214.243122]  ? fdget+0x53/0x4a0
> [  214.243123]  ? security_capable+0x87/0x150
> [  214.243126]  ? __x64_sys_finit_module+0xcd/0x150
> [  214.243127]  ? do_syscall_64+0x82/0x2c0
> [  214.243129]  ? count_memcg_events+0x1aa/0x410
> [  214.243130]  ? handle_mm_fault+0x492/0x910
> [  214.243132]  ? do_user_addr_fault+0x4b0/0xa30
> [  214.243134]  ? exc_page_fault+0x75/0xd0
> [  214.243135]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  214.243137]  </TASK>
> [  214.243138] ---[ end trace 0000000000000000 ]---
> [  214.243138]
> [  214.243139] Second to last potentially related work creation:
> [  214.243139] ------------[ cut here ]------------
> [  214.243140] pool index 131070 out of bounds (339) for stack id ffffffff
> [  214.243148] WARNING: CPU: 6 PID: 2258 at lib/stackdepot.c:451
> depot_fetch_stack+0x68/0xb0
> [  214.243150] Modules linked in: 006_state_corruption_poc_reduce_size(OE+)
> 9p(E) rfkill(E) isofs(E) binfmt_misc(E) vfat(E) fat(E) ppdev(E)
> parport_pc(E) snd_pcm(E) parport(E) snd_timer(E) snd(E) virtio_net(E)
> soundcore(E) net_failover(E) joydev(E) bochs(E) failover(E) i2c_piix4(E)
> pcspkr(E) i2c_smbus(E) loop(E) nfnetlink(E) vsock_loopback(E)
> vmw_vsock_virtio_transport_common(E) vmw_vsock_vmci_transport(E) vsock(E)
> zram(E) vmw_vmci(E) lz4hc_compress(E) lz4_compress(E) 9pnet_virtio(E)
> 9pnet(E) floppy(E) netfs(E) serio_raw(E) ata_generic(E) pata_acpi(E)
> fuse(E) qemu_fw_cfg(E)
> [  214.243171] Unloaded tainted modules: snd_pcsp(E):1 hv_vmbus(E):1
> padlock_aes(E):2
> [  214.243174] CPU: 6 UID: 0 PID: 2258 Comm: insmod Tainted: G        W  OE
>       6.16.0-rc4-custombuild #139 PREEMPT(lazy)
> [  214.243176] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  214.243176] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  214.243177] RIP: 0010:depot_fetch_stack+0x68/0xb0
> [  214.243179] Code: c1 e7 04 81 e7 f0 3f 00 00 48 01 f8 8b 50 1c 85 d2 74
> 2a 48 83 c4 10 e9 16 a2 91 01 89 f9 48 c7 c7 08 61 c8 a5 e8 68 2f 58 fe
> <0f> 0b 31 c0 48 83 c4 10 c3 cc cc cc cc 0f 0b 31 c0 eb f1 0f 0b 31
> [  214.243180] RSP: 0018:ffff88814269faf8 EFLAGS: 00010046
> [  214.243181] RAX: 0000000000000000 RBX: ffffea000509a600 RCX:
> 0000000000000001
> [  214.243182] RDX: 1ffff110284d3f47 RSI: 0000000000000004 RDI:
> ffff88848ab2cf48
> [  214.243183] RBP: ffff88814269fee0 R08: ffffffffa1f4e7dc R09:
> ffffed10915659e9
> [  214.243184] R10: ffffed10915659ea R11: 0000000000000001 R12:
> ffff88814269fbe0
> [  214.243185] R13: ffffffffa4cf91e6 R14: 00000000fffffffe R15:
> ffff88814269fdc8
> [  214.243186] FS:  00007f5dec131740(0000) GS:ffff8884e241d000(0000)
> knlGS:0000000000000000
> [  214.243187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  214.243187] CR2: 0000558a1aca08c0 CR3: 0000000104536000 CR4:
> 00000000000006f0
> [  214.243189] Call Trace:
> [  214.243190]  <TASK>
> [  214.243192]  ? console_emit_next_record+0x12b/0x450
> [  214.243193]  ? __pfx_console_emit_next_record+0x10/0x10
> [  214.243194]  ? __asan_memmove+0x3c/0x60
> [  214.243197]  ? console_flush_all+0x36c/0x570
> [  214.243198]  ? __pfx_console_flush_all+0x10/0x10
> [  214.243200]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.243202]  ? console_unlock+0xbf/0x240
> [  214.243203]  ? __pfx_console_unlock+0x10/0x10
> [  214.243205]  ? __down_trylock_console_sem.isra.0+0x2e/0x50
> [  214.243207]  ? vprintk_emit+0x412/0x4b0
> [  214.243208]  ? __pfx_vprintk_emit+0x10/0x10
> [  214.243210]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.243212]  ? _printk+0xc7/0x100
> [  214.243214]  ? __pfx__printk+0x10/0x10
> [  214.243216]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.243217]  ? final_poc_init+0xd7/0xff0
> [006_state_corruption_poc_reduce_size]
> [  214.243219]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.243344]  ? do_one_initcall+0xa4/0x380
> [  214.243346]  ? __pfx_do_one_initcall+0x10/0x10
> [  214.243347]  ? kasan_unpoison+0x44/0x70
> [  214.243350]  ? do_init_module+0x2cc/0x8e0
> [  214.243351]  ? __pfx_do_init_module+0x10/0x10
> [  214.243353]  ? netfs_unbuffered_read_iter_locked+0x47f/0x980 [netfs]
> [  214.243364]  ? init_module_from_file+0xe1/0x150
> [  214.243365]  ? __pfx_init_module_from_file+0x10/0x10
> [  214.243367]  ? vfs_read+0x6da/0xa40
> [  214.243369]  ? _raw_spin_lock+0x83/0xe0
> [  214.243370]  ? __pfx__raw_spin_lock+0x10/0x10
> [  214.243371]  ? cred_has_capability.isra.0+0x12c/0x220
> [  214.243373]  ? idempotent_init_module+0x224/0x750
> [  214.243375]  ? __pfx_idempotent_init_module+0x10/0x10
> [  214.243376]  ? fdget+0x53/0x4a0
> [  214.243377]  ? security_capable+0x87/0x150
> [  214.243380]  ? __x64_sys_finit_module+0xcd/0x150
> [  214.243381]  ? do_syscall_64+0x82/0x2c0
> [  214.243383]  ? count_memcg_events+0x1aa/0x410
> [  214.243384]  ? handle_mm_fault+0x492/0x910
> [  214.243386]  ? do_user_addr_fault+0x4b0/0xa30
> [  214.243388]  ? exc_page_fault+0x75/0xd0
> [  214.243389]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  214.243391]  </TASK>
> [  214.243392] ---[ end trace 0000000000000000 ]---
> [  214.243392] ------------[ cut here ]------------
> [  214.243393] corrupt handle or use after stack_depot_put()
> [  214.243401] WARNING: CPU: 6 PID: 2258 at lib/stackdepot.c:723
> stack_depot_print+0x43/0x50
> [  214.243403] Modules linked in: 006_state_corruption_poc_reduce_size(OE+)
> 9p(E) rfkill(E) isofs(E) binfmt_misc(E) vfat(E) fat(E) ppdev(E)
> parport_pc(E) snd_pcm(E) parport(E) snd_timer(E) snd(E) virtio_net(E)
> soundcore(E) net_failover(E) joydev(E) bochs(E) failover(E) i2c_piix4(E)
> pcspkr(E) i2c_smbus(E) loop(E) nfnetlink(E) vsock_loopback(E)
> vmw_vsock_virtio_transport_common(E) vmw_vsock_vmci_transport(E) vsock(E)
> zram(E) vmw_vmci(E) lz4hc_compress(E) lz4_compress(E) 9pnet_virtio(E)
> 9pnet(E) floppy(E) netfs(E) serio_raw(E) ata_generic(E) pata_acpi(E)
> fuse(E) qemu_fw_cfg(E)
> [  214.243423] Unloaded tainted modules: snd_pcsp(E):1 hv_vmbus(E):1
> padlock_aes(E):2
> [  214.243426] CPU: 6 UID: 0 PID: 2258 Comm: insmod Tainted: G        W  OE
>       6.16.0-rc4-custombuild #139 PREEMPT(lazy)
> [  214.243428] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  214.243429] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  214.243429] RIP: 0010:stack_depot_print+0x43/0x50
> [  214.243431] Code: ff ff 48 85 c0 74 17 8b 70 14 85 f6 74 0b 48 8d 78 20
> 31 d2 e9 2e eb 85 fe c3 cc cc cc cc 48 c7 c7 40 61 c8 a5 e8 8d 28 58 fe
> <0f> 0b c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
> [  214.243432] RSP: 0018:ffff88814269fb10 EFLAGS: 00010046
> [  214.243433] RAX: 0000000000000000 RBX: ffffea000509a600 RCX:
> 0000000000000001
> [  214.243434] RDX: 1ffff110284d3f4a RSI: 0000000000000004 RDI:
> ffff88848ab2cf48
> [  214.243435] RBP: ffff88814269fee0 R08: ffffffffa1f4e7dc R09:
> ffffed10915659e9
> [  214.243436] R10: ffffed10915659ea R11: ffffffffa87b6f46 R12:
> ffff88814269fbe0
> [  214.243437] R13: ffffffffa4cf91e6 R14: 00000000fffffffe R15:
> ffff88814269fdc8
> [  214.243438] FS:  00007f5dec131740(0000) GS:ffff8884e241d000(0000)
> knlGS:0000000000000000
> [  214.243439] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  214.243440] CR2: 0000558a1aca08c0 CR3: 0000000104536000 CR4:
> 00000000000006f0
> [  214.243441] Call Trace:
> [  214.243442]  <TASK>
> [  214.243444]  ? console_emit_next_record+0x12b/0x450
> [  214.243445]  ? __pfx_console_emit_next_record+0x10/0x10
> [  214.243446]  ? __asan_memmove+0x3c/0x60
> [  214.243449]  ? console_flush_all+0x36c/0x570
> [  214.243450]  ? __pfx_console_flush_all+0x10/0x10
> [  214.243452]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.243454]  ? console_unlock+0xbf/0x240
> [  214.243455]  ? __pfx_console_unlock+0x10/0x10
> [  214.243457]  ? __down_trylock_console_sem.isra.0+0x2e/0x50
> [  214.243459]  ? vprintk_emit+0x412/0x4b0
> [  214.243460]  ? __pfx_vprintk_emit+0x10/0x10
> [  214.243462]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.243464]  ? _printk+0xc7/0x100
> [  214.243466]  ? __pfx__printk+0x10/0x10
> [  214.243468]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.243469]  ? final_poc_init+0xd7/0xff0
> [006_state_corruption_poc_reduce_size]
> [  214.243471]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.243596]  ? do_one_initcall+0xa4/0x380
> [  214.243598]  ? __pfx_do_one_initcall+0x10/0x10
> [  214.243600]  ? kasan_unpoison+0x44/0x70
> [  214.243602]  ? do_init_module+0x2cc/0x8e0
> [  214.243603]  ? __pfx_do_init_module+0x10/0x10
> [  214.243605]  ? netfs_unbuffered_read_iter_locked+0x47f/0x980 [netfs]
> [  214.243616]  ? init_module_from_file+0xe1/0x150
> [  214.243617]  ? __pfx_init_module_from_file+0x10/0x10
> [  214.243618]  ? vfs_read+0x6da/0xa40
> [  214.243620]  ? _raw_spin_lock+0x83/0xe0
> [  214.243622]  ? __pfx__raw_spin_lock+0x10/0x10
> [  214.243623]  ? cred_has_capability.isra.0+0x12c/0x220
> [  214.243625]  ? idempotent_init_module+0x224/0x750
> [  214.243626]  ? __pfx_idempotent_init_module+0x10/0x10
> [  214.243628]  ? fdget+0x53/0x4a0
> [  214.243629]  ? security_capable+0x87/0x150
> [  214.243631]  ? __x64_sys_finit_module+0xcd/0x150
> [  214.243633]  ? do_syscall_64+0x82/0x2c0
> [  214.243634]  ? count_memcg_events+0x1aa/0x410
> [  214.243636]  ? handle_mm_fault+0x492/0x910
> [  214.243638]  ? do_user_addr_fault+0x4b0/0xa30
> [  214.243640]  ? exc_page_fault+0x75/0xd0
> [  214.243641]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  214.243643]  </TASK>
> [  214.243643] ---[ end trace 0000000000000000 ]---
> [  214.243644]
> [  214.243645] The buggy address belongs to the object at ffff88814269e600
> [  214.243645]  which belongs to the cache names_cache of size 4096
> [  214.243646] The buggy address is located 2272 bytes to the right of
> [  214.243646]  allocated 4096-byte region [ffff88814269e600,
> ffff88814269f600)
> [  214.243648]
> [  214.243648] The buggy address belongs to the physical page:
> [  214.243649] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x142698
> [  214.243651] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0
> pincount:0
> [  214.243652] anon flags:
> 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
> [  214.243654] page_type: f5(slab)
> [  214.243656] raw: 0017ffffc0000040 ffff88810039d680 0000000000000000
> dead000000000001
> [  214.243658] raw: 0000000000000000 0000000000070007 00000000f5000000
> 0000000000000000
> [  214.243659] head: 0017ffffc0000040 ffff88810039d680 0000000000000000
> dead000000000001
> [  214.243660] head: 0000000000000000 0000000000070007 00000000f5000000
> 0000000000000000
> [  214.243661] head: 0017ffffc0000003 ffffea000509a601 00000000ffffffff
> 00000000ffffffff
> [  214.243662] head: ffffffffffffffff 0000000000000000 00000000ffffffff
> 0000000000000008
> [  214.243663] page dumped because: kasan: bad access detected
> [  214.243663]
> [  214.243664] Memory state around the buggy address:
> [  214.243665]  ffff88814269fd80: 00 00 00 00 00 f1 f1 f1 f1 00 00 00 f3 f3
> f3 f3
> [  214.243666]  ffff88814269fe00: f3 fc fc fc fc fc 00 00 00 00 00 00 00 00
> 00 00
> [  214.243667] >ffff88814269fe80: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 fc fc
> fc fc
> [  214.243668]                                                        ^
> [  214.243669]  ffff88814269ff00: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00
> 00 00
> [  214.243670]  ffff88814269ff80: 00 00 f1 f1 f1 f1 00 00 00 f2 f2 f2 f2 f2
> 00 00
> [  214.243671]
> ==================================================================
> [  214.243695] Disabling lock debugging due to kernel taint
> [  214.403690] Kernel panic - not syncing: corrupted stack end detected
> inside scheduler
> [  214.404200] CPU: 6 UID: 0 PID: 2258 Comm: insmod Tainted: G    B   W  OE
>       6.16.0-rc4-custombuild #139 PREEMPT(lazy)
> [  214.404904] Tainted: [B]=BAD_PAGE, [W]=WARN, [O]=OOT_MODULE,
> [E]=UNSIGNED_MODULE
> [  214.405459] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  214.406193] Call Trace:
> [  214.406558]  <TASK>
> [  214.406910]  ? dump_stack_lvl+0x5d/0x80
> [  214.407336]  ? panic+0x257/0x4eb
> [  214.407738]  ? __pfx_panic+0x10/0x10
> [  214.408147]  ? __asan_memcpy+0x3c/0x60
> [  214.408564]  ? this_cpu_in_panic+0x1a/0x70
> [  214.408994]  ? _prb_read_valid+0x166/0x2e0
> [  214.409423]  ? this_cpu_in_panic+0x1a/0x70
> [  214.409855]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.410438]  ? __schedule+0x17b1/0x17c0
> [  214.410865]  ? __pfx___schedule+0x10/0x10
> [  214.411296]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.411889]  ? __pfx_prb_read_valid+0x10/0x10
> [  214.412341]  ? console_unlock+0xe5/0x240
> [  214.412776]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.413368]  ? preempt_schedule+0x53/0x90
> [  214.413811]  ? preempt_schedule_thunk+0x16/0x30
> [  214.414273]  ? this_cpu_in_panic+0x1a/0x70
> [  214.414714]  ? vprintk_emit+0x35c/0x4b0
> [  214.415144]  ? __pfx_vprintk_emit+0x10/0x10
> [  214.415584]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.416176]  ? _printk+0xc7/0x100
> [  214.416582]  ? __pfx__printk+0x10/0x10
> [  214.417006]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.417591]  ? final_poc_init+0xd7/0xff0
> [006_state_corruption_poc_reduce_size]
> [  214.418160]  ? __pfx_final_poc_init+0x10/0x10
> [006_state_corruption_poc_reduce_size]
> [  214.418871]  ? do_one_initcall+0xa4/0x380
> [  214.419302]  ? __pfx_do_one_initcall+0x10/0x10
> [  214.419752]  ? kasan_unpoison+0x44/0x70
> [  214.420174]  ? do_init_module+0x2cc/0x8e0
> [  214.420599]  ? __pfx_do_init_module+0x10/0x10
> [  214.421043]  ? netfs_unbuffered_read_iter_locked+0x47f/0x980 [netfs]
> [  214.421580]  ? init_module_from_file+0xe1/0x150
> [  214.422033]  ? __pfx_init_module_from_file+0x10/0x10
> [  214.422497]  ? vfs_read+0x6da/0xa40
> [  214.422904]  ? _raw_spin_lock+0x83/0xe0
> [  214.423322]  ? __pfx__raw_spin_lock+0x10/0x10
> [  214.423760]  ? cred_has_capability.isra.0+0x12c/0x220
> [  214.424225]  ? idempotent_init_module+0x224/0x750
> [  214.424675]  ? __pfx_idempotent_init_module+0x10/0x10
> [  214.425139]  ? fdget+0x53/0x4a0
> [  214.425520]  ? security_capable+0x87/0x150
> [  214.425942]  ? __x64_sys_finit_module+0xcd/0x150
> [  214.426380]  ? do_syscall_64+0x82/0x2c0
> [  214.426787]  ? count_memcg_events+0x1aa/0x410
> [  214.427210]  ? handle_mm_fault+0x492/0x910
> [  214.427614]  ? do_user_addr_fault+0x4b0/0xa30
> [  214.428026]  ? exc_page_fault+0x75/0xd0
> [  214.428407]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  214.428841]  </TASK>
> [  214.429413] Kernel Offset: 0x20400000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  214.430091] ---[ end Kernel panic - not syncing: corrupted stack end
> detected inside scheduler ]---
> 
> 
> This is my first time reporting a bug on the mailing list, so please let me
> know if any additional information or formatting is required.
> 
> Thank you,
> Shardul Bankar

