Return-Path: <linux-fsdevel+bounces-32239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EFC9A2A66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1F42862E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BC51DE4E2;
	Thu, 17 Oct 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SEtkOiDE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C81DF738
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184929; cv=none; b=JR6AH8aWxoiiLMhmPfJXk9mGy0FGv4Xy8PYcoAMZPy3czdDahgbgce1sWdJyJMsrV+irTU9uQU4nfu+/as0Kq5UPLGGAx7kVwHNgxSp8tUyGG3dZpCvqOtR1JvuftsWv1jOX+zkmhbOokUw4NIXaD9RRcgEvTWtteV8RUtj4ap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184929; c=relaxed/simple;
	bh=QnwOrWkOiWBRtT2fwbX8XIdh9CGI4VyY4LgOvW0lhZA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kOo79/8iuVptbASC5ta9Vuo/bf+KwFsk09YFe56LiV7LX7Jk7Z5rvkj6bMJ+d3jP80NRY9BRTHnw/+NArqUEFIuf6d+OLcjPDdN/B6HSjqgKPbuSVMRZIElWGOlEsGP+9fyvEyuo0iyXUkf9EV7SR8elukYAIeWz3oWIs0aR2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SEtkOiDE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BB2D12088F;
	Thu, 17 Oct 2024 19:08:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZG50pA9PS1rm; Thu, 17 Oct 2024 19:08:30 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 826FA2019D;
	Thu, 17 Oct 2024 19:08:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 826FA2019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729184910;
	bh=lgXdZ3ElqURap03Dw6yb1uheUy4KzKSG7mw4zXUeU2o=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=SEtkOiDEx7xx/PLwmANMaMwAUuzXIRDe910sS4qr6xRhDgzhF1mw9Zp3ONz9Ty4q2
	 5sKBhhzykLLoLOrTPJv+B8WeXS/+2RNr0bIWdU522TmrlwSuvSzfStLgRw9NcUVze/
	 3aiTM503et3jxiG3mhbf7+jHErd9UTQLaXIQXyFXo8o+uA34Y5wCy/tSTg0YHi1Z/e
	 lkt5ImLm7uxMrTwFkm+EA/J8ptlke2pnr/CvRhWb80/3C1ly0FUcN+iSUvD1ZhU2zb
	 /W2O/5Gg3fSRD5dmAQL6L6QwGUydgw6tEjpAD8E2mrDmf8PBIa6oJ26rmjhKX+ccxe
	 +dYwucQ7M6bLA==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 19:08:30 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 19:08:29 +0200
Date: Thu, 17 Oct 2024 19:08:27 +0200
From: Antony Antony <antony.antony@secunet.com>
To: <linux-fsdevel@vger.kernel.org>, <regressions@lists.linux.dev>
CC: Maximilian Bosch <maximilian@mbosch.me>, David Howells
	<dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, Antony Antony
	<antony@phenome.org>
Subject: 9pfs regression since 6.12-rc1
Message-ID: <ZxFEi1Tod43pD6JC@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi,

Starting with Linux 6.12-rc1, and continuing in -rc3, the automatic VM tests 
of NixOS don't boot, hits a bug. I see a similar issue reported, however, 
the fix mentioned there is not  enoguh in my case.

https://lore.kernel.org/lkml/D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me/T/
This fix is in -rc3. When running 6.12-rc3, I see a list curruption.

I bisected it back to
Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Here are the logs using v6.12-rc3

[   28.451336] list_del corruption. next->prev should be ffa38103000ccd88, but was ffa38103000c7108. (next=ffa381030010c208)
[   28.454010] ------------[ cut here ]------------
[   28.454184] kernel BUG at lib/list_debug.c:65!
[   28.454971] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   28.455339] CPU: 0 UID: 0 PID: 442 Comm: systemd-coredum Not tainted 6.12.0-rc3 #1-NixOS
[   28.455610] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   28.456081] RIP: 0010:__list_del_entry_valid_or_report+0xcc/0xd0
[   28.456326] Code: 89 fe 48 89 c2 48 c7 c7 f0 49 c1 aa e8 5d 90 ac ff 90 0f 0b 48 89 d1 48 c7 c7 40 4a c1 aa 48 89 f2 48 89 c6 e8 45 90 ac ff 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
[   28.456815] RSP: 0000:ff6344c7402679c0 EFLAGS: 00010246
[   28.457012] RAX: 000000000000006d RBX: ff4122917e03dc80 RCX: 0000000000000000
[   28.457200] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   28.457384] RBP: ffa38103000ccd80 R08: 0000000000000000 R09: 0000000000000000
[   28.457569] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[   28.457752] R13: ff4122917e03dc80 R14: ffa38103000ccd88 R15: ff4122917ffd6180
[   28.457999] FS:  00007ff00b991440(0000) GS:ff4122917e000000(0000) knlGS:0000000000000000
[   28.458223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.458381] CR2: 00007ff00b970008 CR3: 0000000004b60000 CR4: 0000000000751ef0
[   28.458693] PKRU: 55555554
[   28.458848] Call Trace:
[   28.459079]  <TASK>
[   28.459259]  ? die+0x36/0x90
[   28.459407]  ? do_trap+0xed/0x110
[   28.459511]  ? __list_del_entry_valid_or_report+0xcc/0xd0
[   28.459658]  ? do_error_trap+0x6a/0xa0
[   28.459769]  ? __list_del_entry_valid_or_report+0xcc/0xd0
[   28.459915]  ? exc_invalid_op+0x51/0x80
[   28.460048]  ? __list_del_entry_valid_or_report+0xcc/0xd0
[   28.460193]  ? asm_exc_invalid_op+0x1a/0x20
[   28.460329]  ? __list_del_entry_valid_or_report+0xcc/0xd0
[   28.460491]  __rmqueue_pcplist+0xa5/0xd00
[   28.460654]  get_page_from_freelist+0x2df/0x1910
[   28.460808]  __alloc_pages_noprof+0x1a3/0x1130
[   28.460940]  ? __alloc_pages_noprof+0x1a3/0x1130
[   28.461107]  ? filemap_get_entry+0x10f/0x1a0
[   28.461244]  alloc_pages_mpol_noprof+0x8f/0x1f0
[   28.461377]  folio_alloc_mpol_noprof+0x14/0x40
[   28.461503]  vma_alloc_folio_noprof+0x6b/0xd0
[   28.461630]  do_wp_page+0x184/0xce0
[   28.461749]  __handle_mm_fault+0xb1d/0xfd0
[   28.461883]  handle_mm_fault+0x17f/0x2e0
[   28.462017]  do_user_addr_fault+0x177/0x6b0
[   28.462149]  exc_page_fault+0x71/0x160
[   28.462267]  asm_exc_page_fault+0x26/0x30
[   28.462442] RIP: 0033:0x7ff00c25e90c
[   28.462817] Code: 1f 80 00 00 00 00 48 8b 32 8b 4a 08 4c 01 fe 48 83 f9 26 74 0a 48 83 f9 08 0f 85 5c 1e 00 00 48 8b 4a 10 48 83 c2 18 4c 01 f9 <48> 89 0e 48 39 da 72 d4 4d 8b 9a 08 02 00 00 4d 85 db 0f 84 84 0b
[   28.463282] RSP: 002b:00007ffec53f5d10 EFLAGS: 00010206
[   28.463426] RAX: 00007ff00b4141d8 RBX: 00007ff00b4c25b0 RCX: 00007ff00b82de90
[   28.463603] RDX: 00007ff00b4ba4b0 RSI: 00007ff00b970008 RDI: 00007ff00b4c3540
[   28.463779] RBP: 00007ffec53f5e30 R08: 000000000006eb20 R09: 00007ff00b4c2688
[   28.463956] R10: 00007ff00bb99be0 R11: 0000000000000000 R12: 00007ffec53f5dc0
[   28.464155] R13: 00007ffec53f5dc0 R14: 00007ff00bb99be0 R15: 00007ff00b400000
[   28.464392]  </TASK>
[   28.465174] Modules linked in: nf_tables libcrc32c sch_fq_codel fuse configfs efi_pstore loop tun tap macvlan bridge stp llc nfnetlink dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 overlay 9p ext4 crc32c_generic crc16 mbcache jbd2 9pnet_virtio 9pnet hid_generic usbhid hid netfs sr_mod virtio_net cdrom atkbd virtio_blk net_failover libps2 failover vivaldi_fmap crc32c_intel ata_piix libata scsi_mod uhci_hcd ehci_hcd virtio_pci virtio_pci_legacy_dev i8042 virtio_pci_modern_dev scsi_common serio rtc_cmos dm_mod dax virtio_gpu virtio_dma_buf virtio_rng rng_core virtio_console virtio_balloon virtio virtio_ring
[   28.467348] ---[ end trace 0000000000000000 ]---
[   28.467598] RIP: 0010:__list_del_entry_valid_or_report+0xcc/0xd0
[   28.467765] Code: 89 fe 48 89 c2 48 c7 c7 f0 49 c1 aa e8 5d 90 ac ff 90 0f 0b 48 89 d1 48 c7 c7 40 4a c1 aa 48 89 f2 48 89 c6 e8 45 90 ac ff 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
[   28.468210] RSP: 0000:ff6344c7402679c0 EFLAGS: 00010246
[   28.468355] RAX: 000000000000006d RBX: ff4122917e03dc80 RCX: 0000000000000000
[   28.468557] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   28.468730] RBP: ffa38103000ccd80 R08: 0000000000000000 R09: 0000000000000000
[   28.468902] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[   28.469070] R13: ff4122917e03dc80 R14: ffa38103000ccd88 R15: ff4122917ffd6180
[   28.469259] FS:  00007ff00b991440(0000) GS:ff4122917e000000(0000) knlGS:0000000000000000
[   28.469465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.469640] CR2: 00007ff00b970008 CR3: 0000000004b60000 CR4: 0000000000751ef0
[   28.469817] PKRU: 55555554
[   28.469984] note: systemd-coredum[442] exited with preempt_count 2
machine: Guest root shell did not produce any data yet...
machine:   To debug, enter the VM and run 'systemctl status backdoor.service'.
[   28.775636] systemd[1]: Assertion '!q->items[k].idx || *(q->items[k].idx) == k' failed at src/basic/prioq.c:73, function swap(). Aborting.
[   28.806829] systemd[1]: Caught <ABRT>, from our own process.
[   28.873961] systemd-udevd[411]: Using default interface naming scheme 'v255'.
[   29.096262] systemd-journald[383]: Received client request to flush runtime journal.
[   30.517929] iwhg72zrr04ywa4c8schr72x3m8vs5s9-mount-pstore.sh[388]: Persistent Storage backend was not registered in time.
[   30.820098] BUG: Bad page state in process udevadm  pfn:041e6
[   30.820999] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x29a pfn:0x41e6
[   30.821358] flags: 0xffffc000000000(node=0|zone=1|lastcpupid=0x1ffff)
[   30.822021] raw: 00ffffc000000000 dead000000000100 dead000000000122 0000000000000000
[   30.822231] raw: 000000000000029a 0000000000000000 00000001ffffffff 0000000000000000
[   30.822485] page dumped because: nonzero _refcount
[   30.822686] Modules linked in: nf_tables libcrc32c sch_fq_codel fuse configfs efi_pstore loop tun tap macvlan bridge stp llc nfnetlink dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 overlay 9p ext4 crc32c_generic crc16 mbcache jbd2 9pnet_virtio 9pnet hid_generic usbhid hid netfs sr_mod virtio_net cdrom atkbd virtio_blk net_failover libps2 failover vivaldi_fmap crc32c_intel ata_piix libata scsi_mod uhci_hcd ehci_hcd virtio_pci virtio_pci_legacy_dev i8042 virtio_pci_modern_dev scsi_common serio rtc_cmos dm_mod dax virtio_gpu virtio_dma_buf virtio_rng rng_core virtio_console virtio_balloon virtio virtio_ring
[   30.824431] CPU: 0 UID: 0 PID: 386 Comm: udevadm Tainted: G      D            6.12.0-rc3 #1-NixOS
[   30.824748] Tainted: [D]=DIE
[   30.824846] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   30.825149] Call Trace:
[   30.825271]  <TASK>
[   30.825359]  dump_stack_lvl+0x64/0x90
[   30.825498]  bad_page+0x70/0x110
[   30.825649]  get_page_from_freelist+0x9bf/0x1910
[   30.825804]  __alloc_pages_noprof+0x1a3/0x1130
[   30.825935]  ? mntput_no_expire+0x4a/0x260
[   30.826062]  ? path_get+0x15/0x40
[   30.826165]  ? do_dentry_open+0x57/0x450
[   30.826283]  ? mntput_no_expire+0x4a/0x260
[   30.826412]  alloc_pages_mpol_noprof+0x8f/0x1f0
[   30.826546]  folio_alloc_mpol_noprof+0x14/0x40
[   30.826701]  vma_alloc_folio_noprof+0x6b/0xd0
[   30.826840]  do_anonymous_page+0x2ce/0x810
[   30.826963]  ? __pte_offset_map+0x1b/0x190
[   30.827089]  __handle_mm_fault+0xb73/0xfd0
[   30.827226]  handle_mm_fault+0x17f/0x2e0
[   30.827345]  do_user_addr_fault+0x177/0x6b0
[   30.827476]  exc_page_fault+0x71/0x160
[   30.827595]  asm_exc_page_fault+0x26/0x30
[   30.827742] RIP: 0033:0x7f94aeca7c42
[   30.827873] Code: 8d 34 19 48 39 d5 48 89 75 60 0f 95 c2 48 29 d8 48 83 c1 10 0f b6 d2 48 83 c8 01 48 c1 e2 02 48 09 da 48 83 ca 01 48 89 51 f8 <48> 89 46 08 e9 3d ff ff ff 48 89 df e8 4d e8 ff ff 48 89 c1 48 85
[   30.828306] RSP: 002b:00007ffef7804b50 EFLAGS: 00010206
[   30.828453] RAX: 0000000000013df1 RBX: 0000000000001010 RCX: 000055da8fb0b210
[   30.828628] RDX: 0000000000001011 RSI: 000055da8fb0c210 RDI: 0000000000000000
[   30.828846] RBP: 00007f94aedf1ac0 R08: 0000000000000000 R09: 0000000000000001
[   30.829021] R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000001001
[   30.829196] R13: 0000000000000000 R14: 00000000000000ff R15: 00007f94aedf1b20
[   30.829385]  </TASK>
[   30.846642] systemd-journal[383]: segfault at 6f ip 00007f834f1f3894 sp 00007ffd95427128 error 4 in libzstd.so.1.5.6[b2894,7f834f14a000+b9000] likely on CPU 0 (core 0, socket 0)
[   30.847473] Code: 74 72 00 65 72 72 6d 73 67 69 64 78 00 61 6c 6c 5f 6d 61 73 6b 00 61 70 70 5f 6d 61 73 6b 00 6f 66 6c 5f 68 65 61 64 00 62 75 <66> 00 70 6f 70 5f 61 72 67 00 70 61 64 2e 70 61 72 74 2e 30 00 66
[   30.915249] BUG: Bad page state in process systemd-coredum  pfn:03388
[   30.915835] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x67 pfn:0x3388
[   30.916068] flags: 0xffffc000000000(node=0|zone=1|lastcpupid=0x1ffff)
[   30.916243] raw: 00ffffc000000000 dead000000000100 dead000000000122 0000000000000000
[   30.916437] raw: 0000000000000067 0000000000000000 00000001ffffffff 0000000000000000
[   30.916699] page dumped because: nonzero _refcount
[   30.916849] Modules linked in: nf_tables libcrc32c sch_fq_codel fuse configfs efi_pstore loop tun tap macvlan bridge stp llc nfnetlink dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 overlay 9p ext4 crc32c_generic crc16 mbcache jbd2 9pnet_virtio 9pnet hid_generic usbhid hid netfs sr_mod virtio_net cdrom atkbd virtio_blk net_failover libps2 failover vivaldi_fmap crc32c_intel ata_piix libata scsi_mod uhci_hcd ehci_hcd virtio_pci virtio_pci_legacy_dev i8042 virtio_pci_modern_dev scsi_common serio rtc_cmos dm_mod dax virtio_gpu virtio_dma_buf virtio_rng rng_core virtio_console virtio_balloon virtio virtio_ring
[   30.919573] CPU: 0 UID: 0 PID: 502 Comm: systemd-coredum Tainted: G    B D            6.12.0-rc3 #1-NixOS
[   30.920124] Tainted: [B]=BAD_PAGE, [D]=DIE
[   30.920363] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   30.921009] Call Trace:
[   30.921193]  <TASK>
[   30.921373]  dump_stack_lvl+0x64/0x90
[   30.921644]  bad_page+0x70/0x110
[   30.921884]  get_page_from_freelist+0x9bf/0x1910
[   30.922252]  __alloc_pages_noprof+0x1a3/0x1130
[   30.922532]  ? xas_load+0xd/0xe0
[   30.922759]  ? filemap_get_entry+0x10f/0x1a0
[   30.923103]  ? __lruvec_stat_mod_folio+0x83/0xd0
[   30.923409]  alloc_pages_mpol_noprof+0x8f/0x1f0
[   30.923712]  folio_alloc_mpol_noprof+0x14/0x40
[   30.923989]  vma_alloc_folio_noprof+0x6b/0xd0
[   30.924298]  do_fault+0x81/0x4d0
[   30.924550]  __handle_mm_fault+0x7c1/0xfd0
[   30.924849]  handle_mm_fault+0x17f/0x2e0
[   30.925138]  do_user_addr_fault+0x177/0x6b0
[   30.925421]  exc_page_fault+0x71/0x160
[   30.925680]  asm_exc_page_fault+0x26/0x30
[   30.925947] RIP: 0033:0x7f8a5282790c
[   30.926236] Code: 1f 80 00 00 00 00 48 8b 32 8b 4a 08 4c 01 fe 48 83 f9 26 74 0a 48 83 f9 08 0f 85 5c 1e 00 00 48 8b 4a 10 48 83 c2 18 4c 01 f9 <48> 89 0e 48 39 da 72 d4 4d 8b 9a 08 02 00 00 4d 85 db 0f 84 84 0b
[   30.926890] RSP: 002b:00007fff178b8b30 EFLAGS: 00010202
[   30.927042] RAX: 00007f8a52210588 RBX: 00007f8a5226ea58 RCX: 00007f8a5251b589
[   30.927254] RDX: 00007f8a52256080 RSI: 00007f8a52605010 RDI: 00007f8a522864e8
[   30.927444] RBP: 00007fff178b8c50 R08: 00000000000346c8 R09: 00007f8a52272910
[   30.927628] R10: 00007f8a528121e0 R11: 0000000000000000 R12: 00007fff178b8be0
[   30.927812] R13: 00007fff178b8be0 R14: 00007f8a528121e0 R15: 00007f8a52200000
[   30.928009]  </TASK>
[   30.943217] BUG: Bad page state in process systemd-coredum  pfn:0420a
[   30.943840] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x21 pfn:0x420a
[   30.944072] flags: 0xffffc000000000(node=0|zone=1|lastcpupid=0x1ffff)
[   30.944245] raw: 00ffffc000000000 dead000000000100 dead000000000122 0000000000000000
[   30.944440] raw: 0000000000000021 0000000000000000 00000001ffffffff 0000000000000000
[   30.944723] page dumped because: nonzero _refcount
[   30.944852] Modules linked in: nf_tables libcrc32c sch_fq_codel fuse configfs efi_pstore loop tun tap macvlan bridge stp llc nfnetlink dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 overlay 9p ext4 crc32c_generic crc16 mbcache jbd2 9pnet_virtio 9pnet hid_generic usbhid hid netfs sr_mod virtio_net cdrom atkbd virtio_blk net_failover libps2 failover vivaldi_fmap crc32c_intel ata_piix libata scsi_mod uhci_hcd ehci_hcd virtio_pci virtio_pci_legacy_dev i8042 virtio_pci_modern_dev scsi_common serio rtc_cmos dm_mod dax virtio_gpu virtio_dma_buf virtio_rng rng_core virtio_console virtio_balloon virtio virtio_ring
[   30.946462] CPU: 0 UID: 0 PID: 502 Comm: systemd-coredum Tainted: G    B D            6.12.0-rc3 #1-NixOS
[   30.946744] Tainted: [B]=BAD_PAGE, [D]=DIE
[   30.946871] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   30.947159] Call Trace:
[   30.947251]  <TASK>
[   30.947337]  dump_stack_lvl+0x64/0x90
[   30.947468]  bad_page+0x70/0x110
[   30.947582]  get_page_from_freelist+0x9bf/0x1910
[   30.947738]  __alloc_pages_noprof+0x1a3/0x1130
[   30.947907]  ? __alloc_pages_noprof+0x1a3/0x1130
[   30.948045]  ? filemap_get_entry+0x10f/0x1a0
[   30.948175]  ? __pte_offset_map+0x1b/0x190
[   30.948300]  ? next_uptodate_folio+0x89/0x2a0
[   30.948429]  alloc_pages_mpol_noprof+0x8f/0x1f0
[   30.948566]  folio_alloc_mpol_noprof+0x14/0x40
[   30.948692]  vma_alloc_folio_noprof+0x6b/0xd0
[   30.948840]  do_wp_page+0x184/0xce0
[   30.948965]  __handle_mm_fault+0xb1d/0xfd0
[   30.949102]  handle_mm_fault+0x17f/0x2e0
[   30.949223]  do_user_addr_fault+0x177/0x6b0
[   30.949354]  exc_page_fault+0x71/0x160
[   30.949474]  asm_exc_page_fault+0x26/0x30
[   30.949598] RIP: 0033:0x7f8a5282790c
[   30.949718] Code: 1f 80 00 00 00 00 48 8b 32 8b 4a 08 4c 01 fe 48 83 f9 26 74 0a 48 83 f9 08 0f 85 5c 1e 00 00 48 8b 4a 10 48 83 c2 18 4c 01 f9 <48> 89 0e 48 39 da 72 d4 4d 8b 9a 08 02 00 00 4d 85 db 0f 84 84 0b
[   30.950883] RSP: 002b:00007fff178b8b30 EFLAGS: 00010202
[   30.951030] RAX: 00007f8a52210588 RBX: 00007f8a5226ea58 RCX: 00007f8a5251feef
[   30.951209] RDX: 00007f8a522624e8 RSI: 00007f8a52614010 RDI: 00007f8a522864e8
[   30.951388] RBP: 00007fff178b8c50 R08: 00000000000346c8 R09: 00007f8a52272910
[   30.951566] R10: 00007f8a528121e0 R11: 0000000000000000 R12: 00007fff178b8be0
[   30.951744] R13: 00007fff178b8be0 R14: 00007f8a528121e0 R15: 00007f8a52200000
[   30.951955]  </TASK>
[   31.029030] systemd-coredump[502]: Process 383 (systemd-journal) of user 0 terminated abnormally with signal 11/SEGV, processing...
[   32.091594] (sd-parse-elf)[517]: segfault at 1fe2948d1b686 ip 00007f8a5233c790 sp 00007fff178b8728 error 4 in libsystemd-shared-256.so[13c790,7f8a52287000+28c000] likely on CPU 0 (core 0, socket 0)
[   32.092141] Code: c3 e8 3c 82 ff ff c7 00 0c 00 00 00 eb d0 4c 89 4c 24 18 44 89 44 24 14 89 54 24 10 48 89 74 24 08 e8 36 ff ff ff 4c 8b 4c 24 <18> 44 8b 44 24 14 8b 54 24 10 48 8b 74 24 08 e9 50 ff ff ff 48 89
[   32.094844] coredump: 517((sd-parse-elf)): RLIMIT_CORE is set to 1, aborting core
[   32.104636] systemd-coredump[502]: Process 383 (systemd-journal) of user 0 dumped core.
[   32.106806] systemd-coredump[502]: Coredump diverted to /var/lib/systemd/coredump/core.systemd-journal.0.1a33f3ab40664e608ad2005d7974ed9d.383.1729181777000000.zst
[   32.383768] BUG: Bad page state in process cp  pfn:0420c
[   32.384049] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x146 pfn:0x420c
[   32.384373] flags: 0xffffc000000000(node=0|zone=1|lastcpupid=0x1ffff)
[   32.384917] page_type: f0(buddy)
[   32.385146] raw: 00ffffc000000000 ffa3810300152108 ffa3810300106208 0000000000000000
[   32.385675] raw: 0000000000000146 0000000000000001 00000000f0000000 0000000000000000
[   32.386105] page dumped because: nonzero mapcount
[   32.386399] Modules linked in: nf_tables libcrc32c sch_fq_codel fuse configfs efi_pstore loop tun tap macvlan bridge stp llc nfnetlink dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 overlay 9p ext4 crc32c_generic crc16 mbcache jbd2 9pnet_virtio 9pnet hid_generic usbhid hid netfs sr_mod virtio_net cdrom atkbd virtio_blk net_failover libps2 failover vivaldi_fmap crc32c_intel ata_piix libata scsi_mod uhci_hcd ehci_hcd virtio_pci virtio_pci_legacy_dev i8042 virtio_pci_modern_dev scsi_common serio rtc_cmos dm_mod dax virtio_gpu virtio_dma_buf virtio_rng rng_core virtio_console virtio_balloon virtio virtio_ring
[   32.389366] CPU: 0 UID: 0 PID: 522 Comm: cp Tainted: G    B D            6.12.0-rc3 #1-NixOS
[   32.389750] Tainted: [B]=BAD_PAGE, [D]=DIE
[   32.389931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   32.390370] Call Trace:
[   32.390536]  <TASK>
[   32.390669]  dump_stack_lvl+0x64/0x90
[   32.390878]  bad_page+0x70/0x110
[   32.391056]  free_unref_page+0x363/0x4f0
[   32.391257]  p9_release_pages+0x41/0x90 [9pnet]
[   32.391627]  p9_virtio_zc_request+0x3d4/0x720 [9pnet_virtio]
[   32.391896]  ? p9pdu_finalize+0x32/0xa0 [9pnet]
[   32.392153]  p9_client_zc_rpc.constprop.0+0x102/0x310 [9pnet]
[   32.392447]  ? kmem_cache_free+0x36/0x370
[   32.392703]  p9_client_read_once+0x1a6/0x310 [9pnet]
[   32.392992]  p9_client_read+0x56/0x80 [9pnet]
[   32.393238]  v9fs_issue_read+0x50/0xd0 [9p]
[   32.393467]  netfs_read_to_pagecache+0x20c/0x480 [netfs]
[   32.393832]  netfs_readahead+0x225/0x330 [netfs]
[   32.394154]  read_pages+0x6a/0x250
[   32.394345]  page_cache_ra_unbounded+0x188/0x200
[   32.394600]  filemap_get_pages+0x13e/0x6d0
[   32.394830]  filemap_read+0xef/0x370
[   32.395056]  netfs_buffered_read_iter+0x7f/0xb0 [netfs]
[   32.395402]  do_iter_readv_writev+0x1d8/0x240
[   32.395660]  vfs_iter_read+0xed/0x150
[   32.395853]  backing_file_read_iter+0x16c/0x1c0
[   32.396074]  ovl_read_iter+0xca/0xf0 [overlay]
[   32.396367]  ? __pfx_ovl_file_accessed+0x10/0x10 [overlay]
[   32.396637]  vfs_read+0x29f/0x380
[   32.396764]  ksys_read+0x6f/0xf0
[   32.396879]  do_syscall_64+0xb7/0x210
[   32.397002]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   32.397161] RIP: 0033:0x7efd30243721
[   32.397285] Code: f7 d8 64 89 02 b8 ff ff ff ff eb bb e8 08 ba 01 00 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 45 f9 0e 00 00 74 23 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 77 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 db
[   32.397784] RSP: 002b:00007ffd8abda858 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   32.398012] RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007efd30243721
[   32.398204] RDX: 0000000000040000 RSI: 00007efd300fe000 RDI: 0000000000000003
[   32.398389] RBP: 0000000006442202 R08: 0000000000000000 R09: 0000000000000000
[   32.398579] R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
[   32.398801] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   32.398999]  </TASK>
[   32.603411] traps: udevadm[386] general protection fault ip:8548050f00005413 sp:7ffef7804f08 error:0
[   33.680055] traps: cp[562] general protection fault ip:7fb9b5f50141 sp:7ffd5fe41760 error:0 in ld-linux-x86-64.so.2[4141,7fb9b5f4d000+29000]
[   34.458402] traps: (udev-worker)[548] general protection fault ip:7f4ccccc5a24 sp:7ffed3928660 error:0 in libsystemd-shared-256.so[2c5a24,7f4ccca87000+28c000]
[   34.857113] BUG: Bad page state in process (udev-worker)  pfn:05ec8
[   34.857841] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x7f8a5153f pfn:0x5ec8
[   34.858082] flags: 0xffffc000000000(node=0|zone=1|lastcpupid=0x1ffff)
[   34.858259] raw: 00ffffc000000000 dead000000000100 dead000000000122 0000000000000000
[   34.858457] raw: 00000007f8a5153f 0000000000000000 00000001ffffffff 0000000000000000
[   34.858721] page dumped because: nonzero _refcount
[   34.858845] Modules linked in: ata_generic pata_acpi xt_pkttype xt_LOG nf_log_syslog xt_tcpudp nft_compat nf_tables libcrc32c sch_fq_codel fuse configfs efi_pstore loop tun tap macvlan bridge stp llc nfnetlink dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 overlay 9p ext4 crc32c_generic crc16 mbcache jbd2 9pnet_virtio 9pnet hid_generic usbhid hid netfs sr_mod virtio_net cdrom atkbd virtio_blk net_failover libps2 failover vivaldi_fmap crc32c_intel ata_piix libata scsi_mod uhci_hcd ehci_hcd virtio_pci virtio_pci_legacy_dev i8042 virtio_pci_modern_dev scsi_common serio rtc_cmos dm_mod dax virtio_gpu virtio_dma_buf virtio_rng rng_core virtio_console virtio_balloon virtio virtio_ring
[   34.860579] CPU: 0 UID: 0 PID: 576 Comm: (udev-worker) Tainted: G    B D            6.12.0-rc3 #1-NixOS
[   34.860837] Tainted: [B]=BAD_PAGE, [D]=DIE
[   34.860945] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   34.861214] Call Trace:
[   34.861299]  <TASK>
[   34.861382]  dump_stack_lvl+0x64/0x90
[   34.861506]  bad_page+0x70/0x110
[   34.861630]  get_page_from_freelist+0x9bf/0x1910
[   34.861776]  ? __memcg_slab_post_alloc_hook+0x212/0x3b0
[   34.861936]  __alloc_pages_noprof+0x1a3/0x1130
[   34.862066]  ? bpf_prog_e8932b6bae2b9745_restrict_filesystems+0xb7/0x132
[   34.862321]  ? mntput_no_expire+0x4a/0x260
[   34.862447]  alloc_pages_mpol_noprof+0x8f/0x1f0
[   34.862580]  folio_alloc_mpol_noprof+0x14/0x40
[   34.862706]  vma_alloc_folio_noprof+0x6b/0xd0
[   34.862869]  do_wp_page+0x184/0xce0
[   34.862990]  __handle_mm_fault+0xb1d/0xfd0
[   34.863124]  handle_mm_fault+0x17f/0x2e0
[   34.863241]  do_user_addr_fault+0x177/0x6b0
[   34.863371]  exc_page_fault+0x71/0x160
[   34.863488]  asm_exc_page_fault+0x26/0x30
[   34.863609] RIP: 0033:0x7f4ccc8a85fa
[   34.863726] Code: 84 0a ff ff ff 48 8d 7d 10 48 8b 04 fa a8 0f 0f 85 ab 01 00 00 48 89 c6 83 e9 01 48 c1 ee 0c 48 33 30 48 89 34 fa 66 89 0c 6a <48> c7 40 08 00 00 00 00 48 83 c4 10 5b 5d 41 5c 31 d2 31 c9 31 f6
[   34.864203] RSP: 002b:00007ffed3928560 EFLAGS: 00010202
[   34.864347] RAX: 000055b5b96227d0 RBX: 000000000000008d RCX: 0000000000000001
[   34.864522] RDX: 000055b5b95e2010 RSI: 000055b5b96226b0 RDI: 0000000000000018
[   34.864695] RBP: 0000000000000008 R08: 0000000000000000 R09: 000000000000008b
[   34.864869] R10: 0000000000000000 R11: 0000000000000000 R12: fffffffffffffec0
[   34.865070] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   34.865264]  </TASK>
[   35.198281] traps: (udev-worker)[575] general protection fault ip:7f4ccccc5a24 sp:7ffed3928660 error:0 in libsystemd-shared-256.so[2c5a24,7f4ccca87000+28c000]
[   35.276005] traps: (udev-worker)[574] general protection fault ip:7f4ccccc5a24 sp:7ffed3928660 error:0 in libsystemd-shared-256.so[2c5a24,7f4ccca87000+28c000]
[   36.337298] mousedev: PS/2 mouse device common for all mice
[   36.536129] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   36.545369] ACPI: button: Power Button [PWRF]
[   36.832638] parport_pc 00:03: reported by Plug and Play ACPI
[   36.845890] parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
[   36.883278] Floppy drive(s): fd0 is 2.88M AMI BIOS
[   36.900149] FDC 0 is a S82078B
[   37.183825] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[   37.190598] i2c i2c-0: Memory type 0x07 not supported yet, not instantiating SPD
[   37.281672] input: QEMU Virtio Keyboard as /devices/pci0000:00/0000:00:0a.0/virtio7/input/input4
[   37.418980] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
[   37.432711] Console: switching to colour dummy device 80x25
[   37.443402] [drm] Found bochs VGA, ID 0xb0c5.
[   37.443655] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebd0000.
[   37.457344] [drm] Found EDID data blob.
[   37.479602] [drm] Initialized bochs-drm 1.0.0 for 0000:00:02.0 on minor 0
[   37.551512] fbcon: bochs-drmdrmfb (fb0) is primary device
[   37.585358] Console: switching to colour frame buffer device 160x50
[   37.605472] bochs-drm 0000:00:02.0: [drm] fb0: bochs-drmdrmfb frame buffer device
[   37.937650] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input5
[   37.955888] cryptd: max_cpu_qlen set to 1000
[   38.152679] AES CTR mode by8 optimization enabled
[   38.900417] ppdev: user-space parallel port driver
[   39.881616] kvm_amd: Nested Virtualization enabled
[   39.881967] kvm_amd: Nested Paging enabled
[   39.882697] kvm_amd: Virtual GIF supported
[   39.882869] kvm_amd: PMU virtualization is disabled

The QEMU command line:

qemu-kvm -cpu max -name machine -m 1024 -smp 1 -device virtio-rng-pci -net 
nic,netdev=user.0,model=virtio -netdev user,id=user.0, -virtfs 
local,path=/nix/store,security_model=none,mount_tag=nix-store -virtfs 
local,path=/build/shared-xchg,security_model=none,mount_tag=shared
 -virtfs 
 local,path=/build/vm-state-machine/xchg,security_model=none,mount_tag=xchg   
 -drive 
 cache=writeback,file=/build/vm-state-machine/machine.qcow2,id=drive1,if=none,index=1,werror=report  
 -device virtio-blk-pci,bootindex=1,drive=drive1,serial=root -device 
 virtio-net-pci,netdev=vlan1,mac=52:54:00:12:01:01 -netdev 
 vde,id=vlan1,sock=/build/vde1.ctl -device virtio-keyboard -usb -device 
 usb-tablet,bus=usb-bus.0 -kernel 
 /nix/store/rv2vrmmg964wz19162sxxfwf3ika7y6b-nixos-system-machine-test/kernel 
 -initrd 
 /nix/store/vpp0qbjqpihfz7ikg1q63fmi4d28wrva-initrd-linux-6.12.0/initrd 
 -append console=ttyS0 console=tty0 panic=1 boot.panic_on_fail 
 clocksource=acpi_pm loglevel=7 net.ifnames=0 
 init=/nix/store/rv2vrmmg964wz19162sxxfwf3ika7y6b-nixos-system-machine-test/init 
 regInfo=/nix/store/f5nyq4ykvynvzvwa7x9rcisfhabjs43s-closure-info/registration 
 console=ttyS0  -qmp unix:/build/vm-state-machine/qmp,server=on,wait=off 
 -monitor unix:/build/vm-state-machine/monitor -chardev 
 socket,id=shell,path=/build/vm-state-machine/shell -device virtio-serial 
 -device virtconsole,chardev=shell -device virtio-rng-pci -serial stdio 
 -no-reboot -nographic

Nix command line to reproduce, with nixpkgs commit, 
9ed9b410adb43f959316d8a3919dabab1ddb396a

 nix-build nixos/tests/kernel-generic.nix -A linux_testing

 regards,
 -antony

