Return-Path: <linux-fsdevel+bounces-12091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE485B322
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 07:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA021C22594
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67CE2D79D;
	Tue, 20 Feb 2024 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CTiGDGoJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1C186F;
	Tue, 20 Feb 2024 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411847; cv=none; b=ABjrU8h9Qte0FvwEttHEZZvbmsH/Zsqvrhaer8aTlVTx+YF62h0Y/bRT7vxTLeNaOpjGqh/qUEWMGcZrq3lVZM7e6kVu46hu5GvgdxXyhqmpS/icNi/p8PpUcxZcgn9UNBW7qSHUgbMcJfYnTX6uhlz+IvAaVI5hPV3GD45Mtzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411847; c=relaxed/simple;
	bh=1TldbkS+a8zRsY4g2DHkkjRClR2M5MRBhycDY9JwnpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cEF246ObtcvgnxKqS1CopJLN4F0KXx0awS7hRo3zTn9soMtE9l0gGUgHe0iX5A53WpO7+zuNKdKfiiVTmIA4h8vdu0eULqwpQ+KCtkpoDMJ1tI5zmkVww5ZB7Cirx0uKu/PiRbvfnBDVirgqw+P1su+APQN74l4jdEIxIiGGsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CTiGDGoJ; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708411839; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Uu0JTbgDX+n2b6LlHjSeEKtpxD/BK+hGbl1jP9112HA=;
	b=CTiGDGoJRs43HY5BMRMgAuvA3HR7tQBXVnwgUp91Un4zshc295M4BzusgfwdccUkfu0fcTj4AIag2kSAKu6L9RluQqnciR0tuLo1PGzvLyfhg2dcm/JVtmq3OZ3rShcTKGGP25S8pcmSAtwTfKgn1VFgKnKTZ3jbJJd8a9QeMaM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W0vebgx_1708411838;
Received: from 30.97.48.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W0vebgx_1708411838)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 14:50:39 +0800
Message-ID: <0b1a06a7-0caf-43a3-bd51-64a57565390e@linux.alibaba.com>
Date: Tue, 20 Feb 2024 14:50:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress
 (3)
To: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>,
 chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 xiang@kernel.org
References: <00000000000090ebb6061054e22e@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <00000000000090ebb6061054e22e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

On 2024/2/2 00:57, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> [    T1] NFS: Registering the id_resolver key type
> [   20.847533][    T1] Key type id_resolver registered
> [   20.852991][    T1] Key type id_legacy registered
> [   20.859477][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> [   20.868251][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
> [   20.901326][    T1] Key type cifs.spnego registered
> [   20.907727][    T1] Key type cifs.idmap registered
> [   20.917413][    T1] ntfs: driver 2.1.32 [Flags: R/W].
> [   20.923298][    T1] ntfs3: Max link count 4000
> [   20.928297][    T1] ntfs3: Enabled Linux POSIX ACLs support
> [   20.934148][    T1] ntfs3: Read-only LZX/Xpress compression included
> [   20.941172][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
> [   20.947393][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
> [   20.953397][    T1] QNX4 filesystem 0.2.3 registered.
> [   20.958982][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
> [   20.965985][    T1] fuse: init (API version 7.39)
> [   20.976858][    T1] orangefs_debugfs_init: called with debug mask: :none: :0:
> [   20.985505][    T1] orangefs_init: module version upstream loaded
> [   20.993572][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
> [   21.034087][    T1] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
> [   21.051635][    T1] 9p: Installing v9fs 9p2000 file system support
> [   21.058997][    T1] NILFS version 2 loaded
> [   21.063484][    T1] befs: version: 0.9.3
> [   21.068879][    T1] ocfs2: Registered cluster interface o2cb
> [   21.075961][    T1] ocfs2: Registered cluster interface user
> [   21.083257][    T1] OCFS2 User DLM kernel interface loaded
> [   21.102750][    T1] gfs2: GFS2 installed
> [   21.142225][    T1] ceph: loaded (mds proto 32)
> [   25.265679][    T1] NET: Registered PF_ALG protocol family
> [   25.271965][    T1] xor: automatically using best checksumming function   avx
> [   25.280055][    T1] async_tx: api initialized (async)
> [   25.285498][    T1] Key type asymmetric registered
> [   25.290927][    T1] Asymmetric key parser 'x509' registered
> [   25.296825][    T1] Asymmetric key parser 'pkcs8' registered
> [   25.302732][    T1] Key type pkcs7_test registered
> [   25.308482][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 240)
> [   25.318600][    T1] io scheduler mq-deadline registered
> [   25.324054][    T1] io scheduler kyber registered
> [   25.331126][    T1] io scheduler bfq registered
> [   25.347558][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [   25.363347][  T136] kworker/u4:0 (136) used greatest stack depth: 11000 bytes left
> [   25.374100][    T1] ACPI: button: Power Button [PWRF]
> [   25.381760][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
> [   25.392277][    T1] ACPI: button: Sleep Button [SLPF]
> [   25.414526][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
> [   25.499231][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
> [   25.505226][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
> [   25.579195][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
> [   25.585070][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
> [   25.662347][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
> [   25.668284][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
> [   25.725221][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
> [   26.750369][    T1] N_HDLC line discipline registered with maxframe=4096
> [   26.758188][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [   26.770021][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [   26.799322][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [   26.828884][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
> [   26.856640][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
> [   26.903869][    T1] Non-volatile memory driver v1.3
> [   26.925949][    T1] Linux agpgart interface v0.103
> [   26.944845][    T1] ACPI: bus type drm_connector registered
> [   26.963460][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
> [   26.985308][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
> [   27.457414][    T1] Console: switching to colour frame buffer device 128x48
> [   27.612960][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
> [   27.621207][    T1] usbcore: registered new interface driver udl
> [   27.785853][    T1] brd: module loaded
> [   27.962515][    T1] loop: module loaded
> [   28.204419][    T1] zram: Added device: zram0
> [   28.227930][    T1] null_blk: disk nullb0 created
> [   28.232984][    T1] null_blk: module loaded
> [   28.238841][    T1] Guest personality initialized and is inactive
> [   28.247691][    T1] VMCI host device registered (name=vmci, major=10, minor=118)
> [   28.255558][    T1] Initialized host personality
> [   28.261000][    T1] usbcore: registered new interface driver rtsx_usb
> [   28.269847][    T1] usbcore: registered new interface driver viperboard
> [   28.277538][    T1] usbcore: registered new interface driver dln2
> [   28.284724][    T1] usbcore: registered new interface driver pn533_usb
> [   28.297696][    T1] nfcsim 0.2 initialized
> [   28.302508][    T1] usbcore: registered new interface driver port100
> [   28.309540][    T1] usbcore: registered new interface driver nfcmrvl
> [   28.325751][    T1] Loading iSCSI transport class v2.0-870.
> [   28.358008][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
> [   28.395519][    T1] scsi host0: Virtio SCSI HBA
> [   28.917048][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs 256
> [   28.933542][   T11] scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
> [   28.978523][    T1] Rounding down aligned max_sectors from 4294967295 to 4294967288
> [   28.988652][    T1] db_root: cannot open: /etc/target
> [   29.035870][    T1] =====================================================
> [   29.036118][    T1] BUG: KMSAN: use-after-free in __list_del_entry_valid_or_report+0x19e/0x490
> [   29.036138][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
> [   29.036138][    T1]  stack_depot_save_flags+0x3e7/0x7b0
> [   29.036138][    T1]  stack_depot_save+0x12/0x20
> [   29.036138][    T1]  ref_tracker_alloc+0x215/0x700
> [   29.036138][    T1]  netdev_hold+0xe2/0x120
> [   29.036138][    T1]  register_netdevice+0x1bc7/0x2170
> [   29.036138][    T1]  bond_create+0x138/0x2a0
> [   29.036138][    T1]  bonding_init+0x1a7/0x2d0
> [   29.036138][    T1]  do_one_initcall+0x216/0x960
> [   29.036138][    T1]  do_initcall_level+0x140/0x350
> [   29.036138][    T1]  do_initcalls+0xf0/0x1d0
> [   29.036138][    T1]  do_basic_setup+0x22/0x30
> [   29.036138][    T1]  kernel_init_freeable+0x300/0x4b0
> [   29.036138][    T1]  kernel_init+0x2f/0x7e0
> [   29.036138][    T1]  ret_from_fork+0x66/0x80
> [   29.036138][    T1]  ret_from_fork_asm+0x11/0x20
> [   29.036138][    T1]
> [   29.036138][    T1] Uninit was created at:
> [   29.036138][    T1]  free_unref_page_prepare+0xc1/0xad0
> [   29.036138][    T1]  free_unref_page+0x58/0x6d0
> [   29.036138][    T1]  __free_pages+0xb1/0x1f0
> [   29.036138][    T1]  thread_stack_free_rcu+0x97/0xb0
> [   29.036138][    T1]  rcu_core+0xa3c/0x1df0
> [   29.036138][    T1]  rcu_core_si+0x12/0x20
> [   29.036138][    T1]  __do_softirq+0x1b7/0x7c3
> [   29.036138][    T1]
> [   29.036138][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-syzkaller-g6764c317b6bb #0
> [   29.036138][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> [   29.036138][    T1] =====================================================
> [   29.036138][    T1] Disabling lock debugging due to kernel taint
> [   29.036138][    T1] Kernel panic - not syncing: kmsan.panic set ...
> [   29.036138][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B              6.8.0-rc2-syzkaller-g6764c317b6bb #0
> [   29.036138][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> [   29.036138][    T1] Call Trace:
> [   29.036138][    T1]  <TASK>
> [   29.036138][    T1]  dump_stack_lvl+0x1bf/0x240
> [   29.036138][    T1]  dump_stack+0x1e/0x20
> [   29.036138][    T1]  panic+0x4de/0xc90
> [   29.036138][    T1]  kmsan_report+0x2d0/0x2d0
> [   29.036138][    T1]  ? cleanup_uevent_env+0x30/0x50
> [   29.036138][    T1]  ? netdev_queue_update_kobjects+0x3f5/0x870
> [   29.036138][    T1]  ? netdev_register_kobject+0x41e/0x520
> [   29.036138][    T1]  ? register_netdevice+0x198f/0x2170
> [   29.036138][    T1]  ? __msan_warning+0x96/0x110
> [   29.036138][    T1]  ? __list_del_entry_valid_or_report+0x19e/0x490
> [   29.036138][    T1]  ? stack_depot_save_flags+0x3e7/0x7b0
> [   29.036138][    T1]  ? stack_depot_save+0x12/0x20
> [   29.036138][    T1]  ? ref_tracker_alloc+0x215/0x700
> [   29.036138][    T1]  ? netdev_hold+0xe2/0x120
> [   29.036138][    T1]  ? register_netdevice+0x1bc7/0x2170
> [   29.036138][    T1]  ? bond_create+0x138/0x2a0
> [   29.036138][    T1]  ? bonding_init+0x1a7/0x2d0
> [   29.036138][    T1]  ? do_one_initcall+0x216/0x960
> [   29.036138][    T1]  ? do_initcall_level+0x140/0x350
> [   29.036138][    T1]  ? do_initcalls+0xf0/0x1d0
> [   29.036138][    T1]  ? do_basic_setup+0x22/0x30
> [   29.036138][    T1]  ? kernel_init_freeable+0x300/0x4b0
> [   29.036138][    T1]  ? kernel_init+0x2f/0x7e0
> [   29.036138][    T1]  ? ret_from_fork+0x66/0x80
> [   29.036138][    T1]  ? ret_from_fork_asm+0x11/0x20
> [   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   29.036138][    T1]  ? filter_irq_stacks+0x60/0x1a0
> [   29.036138][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   29.036138][    T1]  __msan_warning+0x96/0x110
> [   29.036138][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
> [   29.036138][    T1]  stack_depot_save_flags+0x3e7/0x7b0
> [   29.036138][    T1]  stack_depot_save+0x12/0x20
> [   29.036138][    T1]  ref_tracker_alloc+0x215/0x700
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? netdev_hold+0xe2/0x120
> [   29.036138][    T1]  ? register_netdevice+0x1bc7/0x2170
> [   29.036138][    T1]  ? bond_create+0x138/0x2a0
> [   29.036138][    T1]  ? bonding_init+0x1a7/0x2d0
> [   29.036138][    T1]  ? do_one_initcall+0x216/0x960
> [   29.036138][    T1]  ? do_initcall_level+0x140/0x350
> [   29.036138][    T1]  ? do_initcalls+0xf0/0x1d0
> [   29.036138][    T1]  ? do_basic_setup+0x22/0x30
> [   29.036138][    T1]  ? kernel_init_freeable+0x300/0x4b0
> [   29.036138][    T1]  ? kernel_init+0x2f/0x7e0
> [   29.036138][    T1]  ? ret_from_fork+0x66/0x80
> [   29.036138][    T1]  ? ret_from_fork_asm+0x11/0x20
> [   29.036138][    T1]  ? kmsan_internal_unpoison_memory+0x14/0x20
> [   29.036138][    T1]  netdev_hold+0xe2/0x120
> [   29.036138][    T1]  register_netdevice+0x1bc7/0x2170
> [   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   29.036138][    T1]  bond_create+0x138/0x2a0
> [   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   29.036138][    T1]  bonding_init+0x1a7/0x2d0
> [   29.036138][    T1]  ? spi_dln2_driver_init+0x40/0x40
> [   29.036138][    T1]  do_one_initcall+0x216/0x960
> [   29.036138][    T1]  ? spi_dln2_driver_init+0x40/0x40
> [   29.036138][    T1]  ? kmsan_get_metadata+0x60/0x1c0
> [   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   29.036138][    T1]  ? filter_irq_stacks+0x60/0x1a0
> [   29.036138][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
> [   29.036138][    T1]  ? skip_spaces+0x8f/0xc0
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   29.036138][    T1]  ? parse_args+0x1511/0x15e0
> [   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   29.036138][    T1]  ? spi_dln2_driver_init+0x40/0x40
> [   29.036138][    T1]  do_initcall_level+0x140/0x350
> [   29.036138][    T1]  do_initcalls+0xf0/0x1d0
> [   29.036138][    T1]  ? arch_cpuhp_init_parallel_bringup+0xe0/0xe0
> [   29.036138][    T1]  do_basic_setup+0x22/0x30
> [   29.036138][    T1]  kernel_init_freeable+0x300/0x4b0
> [   29.036138][    T1]  ? rest_init+0x260/0x260
> [   29.036138][    T1]  kernel_init+0x2f/0x7e0
> [   29.036138][    T1]  ? rest_init+0x260/0x260
> [   29.036138][    T1]  ret_from_fork+0x66/0x80
> [   29.036138][    T1]  ? rest_init+0x260/0x260
> [   29.036138][    T1]  ret_from_fork_asm+0x11/0x20
> [   29.036138][    T1]  </TASK>
> [   29.036138][    T1] Kernel Offset: disabled
> 
> 
> syzkaller build log:
> go env (err=<nil>)
> GO111MODULE='auto'
> GOARCH='amd64'
> GOBIN=''
> GOCACHE='/syzkaller/.cache/go-build'
> GOENV='/syzkaller/.config/go/env'
> GOEXE=''
> GOEXPERIMENT=''
> GOFLAGS=''
> GOHOSTARCH='amd64'
> GOHOSTOS='linux'
> GOINSECURE=''
> GOMODCACHE='/syzkaller/jobs-2/linux/gopath/pkg/mod'
> GONOPROXY=''
> GONOSUMDB=''
> GOOS='linux'
> GOPATH='/syzkaller/jobs-2/linux/gopath'
> GOPRIVATE=''
> GOPROXY='https://proxy.golang.org,direct'
> GOROOT='/usr/local/go'
> GOSUMDB='sum.golang.org'
> GOTMPDIR=''
> GOTOOLCHAIN='auto'
> GOTOOLDIR='/usr/local/go/pkg/tool/linux_amd64'
> GOVCS=''
> GOVERSION='go1.21.4'
> GCCGO='gccgo'
> GOAMD64='v1'
> AR='ar'
> CC='gcc'
> CXX='g++'
> CGO_ENABLED='1'
> GOMOD='/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod'
> GOWORK=''
> CGO_CFLAGS='-O2 -g'
> CGO_CPPFLAGS=''
> CGO_CXXFLAGS='-O2 -g'
> CGO_FFLAGS='-O2 -g'
> CGO_LDFLAGS='-O2 -g'
> PKG_CONFIG='pkg-config'
> GOGCCFLAGS='-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -ffile-prefix-map=/tmp/go-build2170902610=/tmp/go-build -gno-record-gcc-switches'
> 
> git status (err=<nil>)
> HEAD detached at 373b66cd2
> nothing to commit, working tree clean
> 
> 
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> Makefile:32: run command via tools/syz-env for best compatibility, see:
> Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
> go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
> make .descriptions
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> bin/syz-sysgen
> touch .descriptions
> GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20240130-131205'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
> GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20240130-131205'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
> GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20240130-131205'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
> mkdir -p ./bin/linux_amd64
> gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
> 	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
> 	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3\"
> 
> 
> Error text is too large and was truncated, full error text is at:
> https://syzkaller.appspot.com/x/error.txt?x=12b5bad3e80000
> 
> 
> Tested on:
> 
> commit:         6764c317 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8b2756f2e75608e
> dashboard link: https://syzkaller.appspot.com/bug?extid=88ad8b0517a9d3bb9dc8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.

