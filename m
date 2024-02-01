Return-Path: <linux-fsdevel+bounces-9905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C568845DE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72CB282067
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BC0210F6;
	Thu,  1 Feb 2024 16:57:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933053AB
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806627; cv=none; b=pB6n1/NOERB9zWD+IT8bUc0SuA+H2gu5dce/9pndLiTKbTSjR8hvASfrQAfd16xXdn4npYLFVnTU24Ux7BehL9OERA/QXbViE2PqXDbhrxuZ2YFJtCZ5pNjwyTMUPifq4krF6nhX+dwoQlrypaOjuElid3Q2wwyaS7XIVdOJZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806627; c=relaxed/simple;
	bh=pxRxkGC8+INjc3x/HhLYNLWiVzH8X7yYEUT0R57oK9w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H8BarZti4CwRlqo2Atz8TcrImjan7vsRz/llo4cF6aP5eNfnTC4DNgRisYASwuKxMFZes+baKXOihPoov1KInDEHffkhodRvysVTZjG4FA4UXIgXWDjXTiekfyk0V905LEDcfYLBCDxdh6bjw4tCTOsskVjc7f+hbjukSSIR0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c0252f7749so85657039f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 08:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706806624; x=1707411424;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkceZr312rSmPmeH/wO2gbEfucSj+yo53mgsIX+3T38=;
        b=SNex6qUY+gCvAFLsHmJOrjir/t11oau0klQyWlPGeQIWsWAREt4cbL0X2bPcD9kVnE
         SDYIfHrbeulMWwp2cuAHlvPOMgTl4xU2oHWWmdCYcJPVQHpoyPwZ/SxTFtIgREcK8t5a
         hLYEkgBS3bPRLh4Z1VJXReD2wcNBQeJMDKrOOoi2oSUduYUDvCe2/mLti4/yZh36DBY0
         Y2z8fE4S7UhC9G0wuxDoDuz20NhJmCmVPpI7266yJCMBMT5x7YIMH5FeEGHkAtKT5fSs
         UhD1ndWA2bRLJKfq7ar3sqw55CEwQQ6z/w3zb0K20/2ZotBOz1+KHLCq06NK4ZWAaRmF
         20LA==
X-Gm-Message-State: AOJu0YyNg1wrPndQuN2VUxQunL6HL81eTscurrDxm3VzunTs4CLW+1Re
	T3gRcf6ie1QA7Ps3bA3r25nRwFTYhRZPIzW24LZM0fkCI/rCo1ZtAil7MDQSjQW6X5qnU5kD7Eg
	jxP39MthdBU7Acalq2pJTTra/XwLQzZTwwAMmfsMTWi5nCnIGfrYSXhg=
X-Google-Smtp-Source: AGHT+IGTPL9fBJcg+W8Pe7X31hLUkQPFC0gM12WQa4FAK42w9iOOzve7t2FvCYfF58CNCgOu04/bFgh5+TbhWr/4mDy4RE4CnECf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f92:b0:7bf:a4e8:1bfe with SMTP id
 fb18-20020a0566023f9200b007bfa4e81bfemr71314iob.1.1706806624707; Thu, 01 Feb
 2024 08:57:04 -0800 (PST)
Date: Thu, 01 Feb 2024 08:57:04 -0800
In-Reply-To: <ad9354d4-be00-4de4-aec8-ec9d56a9676c@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090ebb6061054e22e@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (3)
From: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>
To: chao@kernel.org, hsiangkao@linux.alibaba.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

[    T1] NFS: Registering the id_resolver key type
[   20.847533][    T1] Key type id_resolver registered
[   20.852991][    T1] Key type id_legacy registered
[   20.859477][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Regist=
ering...
[   20.868251][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[   20.901326][    T1] Key type cifs.spnego registered
[   20.907727][    T1] Key type cifs.idmap registered
[   20.917413][    T1] ntfs: driver 2.1.32 [Flags: R/W].
[   20.923298][    T1] ntfs3: Max link count 4000
[   20.928297][    T1] ntfs3: Enabled Linux POSIX ACLs support
[   20.934148][    T1] ntfs3: Read-only LZX/Xpress compression included
[   20.941172][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[   20.947393][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   20.953397][    T1] QNX4 filesystem 0.2.3 registered.
[   20.958982][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[   20.965985][    T1] fuse: init (API version 7.39)
[   20.976858][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:
[   20.985505][    T1] orangefs_init: module version upstream loaded
[   20.993572][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536
[   21.034087][    T1] SGI XFS with ACLs, security attributes, realtime, qu=
ota, no debug enabled
[   21.051635][    T1] 9p: Installing v9fs 9p2000 file system support
[   21.058997][    T1] NILFS version 2 loaded
[   21.063484][    T1] befs: version: 0.9.3
[   21.068879][    T1] ocfs2: Registered cluster interface o2cb
[   21.075961][    T1] ocfs2: Registered cluster interface user
[   21.083257][    T1] OCFS2 User DLM kernel interface loaded
[   21.102750][    T1] gfs2: GFS2 installed
[   21.142225][    T1] ceph: loaded (mds proto 32)
[   25.265679][    T1] NET: Registered PF_ALG protocol family
[   25.271965][    T1] xor: automatically using best checksumming function =
  avx      =20
[   25.280055][    T1] async_tx: api initialized (async)
[   25.285498][    T1] Key type asymmetric registered
[   25.290927][    T1] Asymmetric key parser 'x509' registered
[   25.296825][    T1] Asymmetric key parser 'pkcs8' registered
[   25.302732][    T1] Key type pkcs7_test registered
[   25.308482][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 240)
[   25.318600][    T1] io scheduler mq-deadline registered
[   25.324054][    T1] io scheduler kyber registered
[   25.331126][    T1] io scheduler bfq registered
[   25.347558][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[   25.363347][  T136] kworker/u4:0 (136) used greatest stack depth: 11000 =
bytes left
[   25.374100][    T1] ACPI: button: Power Button [PWRF]
[   25.381760][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN=
:00/input/input1
[   25.392277][    T1] ACPI: button: Sleep Button [SLPF]
[   25.414526][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[   25.499231][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[   25.505226][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[   25.579195][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[   25.585070][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[   25.662347][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   25.668284][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[   25.725221][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for leg=
acy driver
[   26.750369][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[   26.758188][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[   26.770021][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[   26.799322][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[   26.828884][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[   26.856640][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[   26.903869][    T1] Non-volatile memory driver v1.3
[   26.925949][    T1] Linux agpgart interface v0.103
[   26.944845][    T1] ACPI: bus type drm_connector registered
[   26.963460][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[   26.985308][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[   27.457414][    T1] Console: switching to colour frame buffer device 128=
x48
[   27.612960][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[   27.621207][    T1] usbcore: registered new interface driver udl
[   27.785853][    T1] brd: module loaded
[   27.962515][    T1] loop: module loaded
[   28.204419][    T1] zram: Added device: zram0
[   28.227930][    T1] null_blk: disk nullb0 created
[   28.232984][    T1] null_blk: module loaded
[   28.238841][    T1] Guest personality initialized and is inactive
[   28.247691][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[   28.255558][    T1] Initialized host personality
[   28.261000][    T1] usbcore: registered new interface driver rtsx_usb
[   28.269847][    T1] usbcore: registered new interface driver viperboard
[   28.277538][    T1] usbcore: registered new interface driver dln2
[   28.284724][    T1] usbcore: registered new interface driver pn533_usb
[   28.297696][    T1] nfcsim 0.2 initialized
[   28.302508][    T1] usbcore: registered new interface driver port100
[   28.309540][    T1] usbcore: registered new interface driver nfcmrvl
[   28.325751][    T1] Loading iSCSI transport class v2.0-870.
[   28.358008][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[   28.395519][    T1] scsi host0: Virtio SCSI HBA
[   28.917048][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs =
256
[   28.933542][   T11] scsi 0:0:1:0: Direct-Access     Google   PersistentD=
isk   1    PQ: 0 ANSI: 6
[   28.978523][    T1] Rounding down aligned max_sectors from 4294967295 to=
 4294967288
[   28.988652][    T1] db_root: cannot open: /etc/target
[   29.035870][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   29.036118][    T1] BUG: KMSAN: use-after-free in __list_del_entry_valid=
_or_report+0x19e/0x490
[   29.036138][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
[   29.036138][    T1]  stack_depot_save_flags+0x3e7/0x7b0
[   29.036138][    T1]  stack_depot_save+0x12/0x20
[   29.036138][    T1]  ref_tracker_alloc+0x215/0x700
[   29.036138][    T1]  netdev_hold+0xe2/0x120
[   29.036138][    T1]  register_netdevice+0x1bc7/0x2170
[   29.036138][    T1]  bond_create+0x138/0x2a0
[   29.036138][    T1]  bonding_init+0x1a7/0x2d0
[   29.036138][    T1]  do_one_initcall+0x216/0x960
[   29.036138][    T1]  do_initcall_level+0x140/0x350
[   29.036138][    T1]  do_initcalls+0xf0/0x1d0
[   29.036138][    T1]  do_basic_setup+0x22/0x30
[   29.036138][    T1]  kernel_init_freeable+0x300/0x4b0
[   29.036138][    T1]  kernel_init+0x2f/0x7e0
[   29.036138][    T1]  ret_from_fork+0x66/0x80
[   29.036138][    T1]  ret_from_fork_asm+0x11/0x20
[   29.036138][    T1]=20
[   29.036138][    T1] Uninit was created at:
[   29.036138][    T1]  free_unref_page_prepare+0xc1/0xad0
[   29.036138][    T1]  free_unref_page+0x58/0x6d0
[   29.036138][    T1]  __free_pages+0xb1/0x1f0
[   29.036138][    T1]  thread_stack_free_rcu+0x97/0xb0
[   29.036138][    T1]  rcu_core+0xa3c/0x1df0
[   29.036138][    T1]  rcu_core_si+0x12/0x20
[   29.036138][    T1]  __do_softirq+0x1b7/0x7c3
[   29.036138][    T1]=20
[   29.036138][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-=
syzkaller-g6764c317b6bb #0
[   29.036138][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[   29.036138][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   29.036138][    T1] Disabling lock debugging due to kernel taint
[   29.036138][    T1] Kernel panic - not syncing: kmsan.panic set ...
[   29.036138][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B       =
       6.8.0-rc2-syzkaller-g6764c317b6bb #0
[   29.036138][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[   29.036138][    T1] Call Trace:
[   29.036138][    T1]  <TASK>
[   29.036138][    T1]  dump_stack_lvl+0x1bf/0x240
[   29.036138][    T1]  dump_stack+0x1e/0x20
[   29.036138][    T1]  panic+0x4de/0xc90
[   29.036138][    T1]  kmsan_report+0x2d0/0x2d0
[   29.036138][    T1]  ? cleanup_uevent_env+0x30/0x50
[   29.036138][    T1]  ? netdev_queue_update_kobjects+0x3f5/0x870
[   29.036138][    T1]  ? netdev_register_kobject+0x41e/0x520
[   29.036138][    T1]  ? register_netdevice+0x198f/0x2170
[   29.036138][    T1]  ? __msan_warning+0x96/0x110
[   29.036138][    T1]  ? __list_del_entry_valid_or_report+0x19e/0x490
[   29.036138][    T1]  ? stack_depot_save_flags+0x3e7/0x7b0
[   29.036138][    T1]  ? stack_depot_save+0x12/0x20
[   29.036138][    T1]  ? ref_tracker_alloc+0x215/0x700
[   29.036138][    T1]  ? netdev_hold+0xe2/0x120
[   29.036138][    T1]  ? register_netdevice+0x1bc7/0x2170
[   29.036138][    T1]  ? bond_create+0x138/0x2a0
[   29.036138][    T1]  ? bonding_init+0x1a7/0x2d0
[   29.036138][    T1]  ? do_one_initcall+0x216/0x960
[   29.036138][    T1]  ? do_initcall_level+0x140/0x350
[   29.036138][    T1]  ? do_initcalls+0xf0/0x1d0
[   29.036138][    T1]  ? do_basic_setup+0x22/0x30
[   29.036138][    T1]  ? kernel_init_freeable+0x300/0x4b0
[   29.036138][    T1]  ? kernel_init+0x2f/0x7e0
[   29.036138][    T1]  ? ret_from_fork+0x66/0x80
[   29.036138][    T1]  ? ret_from_fork_asm+0x11/0x20
[   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.036138][    T1]  ? filter_irq_stacks+0x60/0x1a0
[   29.036138][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.036138][    T1]  __msan_warning+0x96/0x110
[   29.036138][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
[   29.036138][    T1]  stack_depot_save_flags+0x3e7/0x7b0
[   29.036138][    T1]  stack_depot_save+0x12/0x20
[   29.036138][    T1]  ref_tracker_alloc+0x215/0x700
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? netdev_hold+0xe2/0x120
[   29.036138][    T1]  ? register_netdevice+0x1bc7/0x2170
[   29.036138][    T1]  ? bond_create+0x138/0x2a0
[   29.036138][    T1]  ? bonding_init+0x1a7/0x2d0
[   29.036138][    T1]  ? do_one_initcall+0x216/0x960
[   29.036138][    T1]  ? do_initcall_level+0x140/0x350
[   29.036138][    T1]  ? do_initcalls+0xf0/0x1d0
[   29.036138][    T1]  ? do_basic_setup+0x22/0x30
[   29.036138][    T1]  ? kernel_init_freeable+0x300/0x4b0
[   29.036138][    T1]  ? kernel_init+0x2f/0x7e0
[   29.036138][    T1]  ? ret_from_fork+0x66/0x80
[   29.036138][    T1]  ? ret_from_fork_asm+0x11/0x20
[   29.036138][    T1]  ? kmsan_internal_unpoison_memory+0x14/0x20
[   29.036138][    T1]  netdev_hold+0xe2/0x120
[   29.036138][    T1]  register_netdevice+0x1bc7/0x2170
[   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.036138][    T1]  bond_create+0x138/0x2a0
[   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.036138][    T1]  bonding_init+0x1a7/0x2d0
[   29.036138][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   29.036138][    T1]  do_one_initcall+0x216/0x960
[   29.036138][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   29.036138][    T1]  ? kmsan_get_metadata+0x60/0x1c0
[   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.036138][    T1]  ? filter_irq_stacks+0x60/0x1a0
[   29.036138][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
[   29.036138][    T1]  ? skip_spaces+0x8f/0xc0
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.036138][    T1]  ? parse_args+0x1511/0x15e0
[   29.036138][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.036138][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.036138][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   29.036138][    T1]  do_initcall_level+0x140/0x350
[   29.036138][    T1]  do_initcalls+0xf0/0x1d0
[   29.036138][    T1]  ? arch_cpuhp_init_parallel_bringup+0xe0/0xe0
[   29.036138][    T1]  do_basic_setup+0x22/0x30
[   29.036138][    T1]  kernel_init_freeable+0x300/0x4b0
[   29.036138][    T1]  ? rest_init+0x260/0x260
[   29.036138][    T1]  kernel_init+0x2f/0x7e0
[   29.036138][    T1]  ? rest_init+0x260/0x260
[   29.036138][    T1]  ret_from_fork+0x66/0x80
[   29.036138][    T1]  ? rest_init+0x260/0x260
[   29.036138][    T1]  ret_from_fork_asm+0x11/0x20
[   29.036138][    T1]  </TASK>
[   29.036138][    T1] Kernel Offset: disabled


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2170902610=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 373b66cd2
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240130-131205'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240130-131205'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240130-131205'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"373b66cd2ba1fd05c72d0bbe16141fb287=
fe2eb3\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12b5bad3e80000


Tested on:

commit:         6764c317 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df8b2756f2e75608=
e
dashboard link: https://syzkaller.appspot.com/bug?extid=3D88ad8b0517a9d3bb9=
dc8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

