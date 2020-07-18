Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB9224A7F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgGRKAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jul 2020 06:00:39 -0400
Received: from verein.lst.de ([213.95.11.211]:41577 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgGRKAj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jul 2020 06:00:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B7CC68AFE; Sat, 18 Jul 2020 12:00:36 +0200 (CEST)
Date:   Sat, 18 Jul 2020 12:00:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 16/23] initramfs: simplify clean_rootfs
Message-ID: <20200718100035.GA8856@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-17-hch@lst.de> <CGME20200717205549eucas1p13fca9a8496836faa71df515524743648@eucas1p1.samsung.com> <7f37802c-d8d9-18cd-7394-df51fa785988@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f37802c-d8d9-18cd-7394-df51fa785988@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:55:48PM +0200, Marek Szyprowski wrote:
> Hi Christoph,
> 
> On 14.07.2020 21:04, Christoph Hellwig wrote:
> > Just use d_genocide instead of iterating through the root directory with
> > cumbersome userspace-like APIs.  This also ensures we actually remove files
> > that are not direct children of the root entry, which the old code failed
> > to do.
> >
> > Fixes: df52092f3c97 ("fastboot: remove duplicate unpack_to_rootfs()")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This patch breaks initrd support ;-(
> 
> I use initrd to deploy kernel modules on my test machines. It was 
> automatically mounted on /initrd. /lib/modules is just a symlink to 
> /initrd. I know that initrd support is marked as deprecated, but it 
> would be really nice to give people some time to update their machines 
> before breaking the stuff.

Looks like your setup did rely on the /dev/ notes from the built-in
initramfs to be preserved.

Can you comment out the call to d_genocide?  It seems like for your
the fact that clean_rootfs didn't actually clean up was a feature and
not a bug.

I guess the old, pre-2008 code also wouldn't have worked for you in
that case.

> 
> Here is the log:
> 
> Kernel image @ 0x40007fc0 [ 0x000000 - 0x6dd9c8 ]
> ## Flattened Device Tree blob at 41000000
>     Booting using the fdt blob at 0x41000000
>     Loading Ramdisk to 4de3c000, end 50000000 ... OK
>     Loading Device Tree to 4de2d000, end 4de3b206 ... OK
> 
> Starting kernel ...
> 
> [    0.000000] Booting Linux on physical CPU 0x900
> ...
> 
> [    0.000000] Kernel command line: root=PARTLABEL=rootfs rootwait 
> console=tty1 console=ttySAC2,115200n8 earlycon rootdelay=2
> ...
> 
> [    1.853631] Trying to unpack rootfs image as initramfs...
> [    1.858661] rootfs image is not initramfs (invalid magic at start of 
> compressed archive); looks like an initrd
> ...
> [    2.204776] Freeing initrd memory: 34576K
> 
> ...
> 
> [    4.635360] Warning: unable to open an initial console.
> [    4.640706] Waiting 2 sec before mounting root device...
> ...
> [    6.776007] Failed to create /dev/root: -2
> [    6.778989] VFS: Cannot open root device "PARTLABEL=rootfs" or 
> unknown-block(179,6): error -2
> [    6.787200] Please append a correct "root=" boot option; here are the 
> available partitions:
> [    6.795693] 0100           65536 ram0
> [    6.795697]  (driver?)
> [    6.801459] 0101           65536 ram1
> [    6.801462]  (driver?)
> [    6.807532] 0102           65536 ram2
> [    6.807535]  (driver?)
> [    6.813674] 0103           65536 ram3
> [    6.813677]  (driver?)
> [    6.819760] 0104           65536 ram4
> [    6.819763]  (driver?)
> [    6.832610] 0105           65536 ram5
> [    6.832613]  (driver?)
> [    6.848685] 0106           65536 ram6
> [    6.848688]  (driver?)
> [    6.864590] 0107           65536 ram7
> [    6.864593]  (driver?)
> [    6.880504] 0108           65536 ram8
> [    6.880507]  (driver?)
> [    6.896248] 0109           65536 ram9
> [    6.896251]  (driver?)
> [    6.911828] 010a           65536 ram10
> [    6.911831]  (driver?)
> [    6.927447] 010b           65536 ram11
> [    6.927450]  (driver?)
> [    6.942976] 010c           65536 ram12
> [    6.942979]  (driver?)
> [    6.958190] 010d           65536 ram13
> [    6.958193]  (driver?)
> [    6.973205] 010e           65536 ram14
> [    6.973208]  (driver?)
> [    6.988105] 010f           65536 ram15
> [    6.988108]  (driver?)
> [    7.002897] b300        15388672 mmcblk0
> [    7.002901]  driver: mmcblk
> [    7.018061]   b301            8192 mmcblk0p1 
> 654b73ea-7c04-c24d-9642-2a186649605c
> [    7.018064]
> [    7.035359]   b302           61440 mmcblk0p2 
> 7ef6fb83-0d6c-8c44-826b-ad11df290e0c
> [    7.035362]
> [    7.052589]   b303          102400 mmcblk0p3 
> 34883856-7d52-d548-a196-718efbd06876
> [    7.052592]
> [    7.069744]   b304          153600 mmcblk0p4 
> 8d4410d0-a4ff-c447-abb9-73350dcdd2d6
> [    7.069747]
> [    7.086888]   b305         1572864 mmcblk0p5 
> 485c2c17-a9e8-9c45-bb68-e0748a2bb1f1
> [    7.086890]
> [    7.103991]   b306         3072000 mmcblk0p6 
> 7fb2bbf3-e064-2343-b169-e69c18dbb43e
> [    7.103993]
> [    7.121290]   b307        10413039 mmcblk0p7 
> b0ee9150-6b6a-274b-9ec3-703d29072555
> [    7.121292]
> [    7.138722] Kernel panic - not syncing: VFS: Unable to mount root fs 
> on unknown-block(179,6)
> [    7.151482] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
> 5.8.0-rc5-00064-g38d014f6d446 #8823
> [    7.164026] Hardware name: Samsung Exynos (Flattened Device Tree)
> [    7.174556] [<c011188c>] (unwind_backtrace) from [<c010d27c>] 
> (show_stack+0x10/0x14)
> [    7.186799] [<c010d27c>] (show_stack) from [<c05182e4>] 
> (dump_stack+0xbc/0xe8)
> [    7.198533] [<c05182e4>] (dump_stack) from [<c01272e0>] 
> (panic+0x128/0x354)
> [    7.210002] [<c01272e0>] (panic) from [<c1001580>] 
> (mount_block_root+0x1a8/0x240)
> [    7.221961] [<c1001580>] (mount_block_root) from [<c1001738>] 
> (mount_root+0x120/0x13c)
> [    7.234325] [<c1001738>] (mount_root) from [<c10018ac>] 
> (prepare_namespace+0x158/0x194)
> [    7.246751] [<c10018ac>] (prepare_namespace) from [<c0ab7684>] 
> (kernel_init+0x8/0x118)
> [    7.259086] [<c0ab7684>] (kernel_init) from [<c0100114>] 
> (ret_from_fork+0x14/0x20)tatic void __init populate_initrd_image(char *err)
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
---end quoted text---
