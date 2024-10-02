Return-Path: <linux-fsdevel+bounces-30753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB5598E17F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 19:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D28285369
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DE1D14E4;
	Wed,  2 Oct 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mbosch.me header.i=@mbosch.me header.b="h2aOnXpb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.mbosch.me (mail.mbosch.me [65.21.144.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3161D1311
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.144.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889288; cv=none; b=ZqfQC/Bg3Fs/9fCxGSuvj43R97SS0s2NsSm+BRsZENZqvkA0ZvSF9Qf5uDAa8ZqcQ7bSIh0OFsnet1KPfF6kl6MI+iWmO3Hk/rnXxHbocGsPayOfvjepYOeJQJhXYDI+rj8n7q5W2K2PeAPBfceHfZIUbvC7qCohErzZ3rF2RwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889288; c=relaxed/simple;
	bh=7uvyc+B9w3DkvGCxeAwjVC0OtvZjFwfYfGFkL5OlWHM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=Ye/wCYyEUFeHPdoIxPxJUFCBMWrLLQ9YqDWEG5X/7jK+OJHNxv6Tine9z38DMvXq2X04XQWlnIGE9gSkgt0uIuvgUNWPstSsw0jv9MptQ2RK0W7UYEW3t7t2XcZ0mYVeD9WWSeyFwChoS25wNaS8thZN8KM9ehAFPe3ooK5aYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mbosch.me; spf=pass smtp.mailfrom=mbosch.me; dkim=pass (1024-bit key) header.d=mbosch.me header.i=@mbosch.me header.b=h2aOnXpb; arc=none smtp.client-ip=65.21.144.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mbosch.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbosch.me
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mbosch.me; s=mail;
	t=1727888901; bh=tJhAUVUs6fGP3FMWBhmLpe02EBU8F52aF13lDteic4A=;
	h=Date:Cc:Subject:From:To;
	b=h2aOnXpbUul147cdUDG5tz6bz4O6qxiXOnFaXH41vFRT3I7fgUGjoAowD2tGdDNXH
	 qiFSTpA52TFgIcyxK8lESITr5AWgtijWedXM0CfUo4Ev/xqM+YIfJzc7R1TmbkKZBt
	 PGjI9y1nnSzrfEN1aBxzOBYTXYCTDXvanf+JhoRk=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Oct 2024 19:08:20 +0200
Message-Id: <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
Cc: <regressions@lists.linux.dev>
Subject: [REGRESSION] 9pfs issues on 6.12-rc1
From: "Maximilian Bosch" <maximilian@mbosch.me>
To: <linux-fsdevel@vger.kernel.org>

Hi!

Starting with Linux 6.12-rc1 the automatic VM tests of NixOS don't boot
anymore and fail like this:

    mounting nix-store on /nix/.ro-store...
    [    1.604781] 9p: Installing v9fs 9p2000 file system support
    mounting tmpfs on /nix/.rw-store...
    mounting overlay on /nix/store...
    mounting shared on /tmp/shared...
    mounting xchg on /tmp/xchg...
    switch_root: can't execute '/nix/store/zv87gw0yxfsslq0mcc35a99k54da9a4z=
-nixos-system-machine-test/init': Exec format error
    [    1.734997] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00000100
    [    1.736002] CPU: 0 UID: 0 PID: 1 Comm: switch_root Not tainted 6.12.=
0-rc1 #1-NixOS
    [    1.736965] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    [    1.738309] Call Trace:
    [    1.738698]  <TASK>
    [    1.739034]  panic+0x324/0x340
    [    1.739458]  do_exit+0x92e/0xa90
    [    1.739919]  ? count_memcg_events.constprop.0+0x1a/0x40
    [    1.740568]  ? srso_return_thunk+0x5/0x5f
    [    1.741095]  ? handle_mm_fault+0xb0/0x2e0
    [    1.741709]  do_group_exit+0x30/0x80
    [    1.742229]  __x64_sys_exit_group+0x18/0x20
    [    1.742800]  x64_sys_call+0x17f3/0x1800
    [    1.743326]  do_syscall_64+0xb7/0x210
    [    1.743895]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
    [    1.744530] RIP: 0033:0x7f8e1a7b9d1d
    [    1.745061] Code: 45 31 c0 45 31 d2 45 31 db c3 0f 1f 00 f3 0f 1e fa=
 48 8b 35 e5 e0 10 00 ba e7 00 00 00 eb 07 66 0f 1f 44 00 00 f4 89 d0 0f 05=
 <48> 3d 00 f0 ff ff 76 f3 f7 d8 64 89 06 eb ec 0f 1f 40 00 f3 0f 1e
    [    1.747263] RSP: 002b:00007ffcb56d63b8 EFLAGS: 00000246 ORIG_RAX: 00=
000000000000e7
    [    1.748250] RAX: ffffffffffffffda RBX: 00007f8e1a8c9fa8 RCX: 00007f8=
e1a7b9d1d
    [    1.749187] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000=
000000001
    [    1.750050] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000=
000000000
    [    1.750891] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000=
000000000
    [    1.751706] R13: 0000000000000001 R14: 00007f8e1a8c8680 R15: 00007f8=
e1a8c9fc0
    [    1.752583]  </TASK>
    [    1.753010] Kernel Offset: 0xb800000 from 0xffffffff81000000 (reloca=
tion range: 0xffffffff80000000-0xffffffffbfffffff)

The failing script here is the initrd's /init when it tries to perform a
switch_root to `/sysroot`:

    exec env -i $(type -P switch_root) "$targetRoot" "$stage2Init"

Said "$stage2Init" file consistently gets a different hash when doing
`sha256sum` on it in the initrd script, but looks & behaves correct
on the host. I reproduced the test failures on 4 different build
machines and two architectures (x86_64-linux, aarch64-linux) now.

The "$stage2Init" script is a shell-script itself. When trying to
start the interpreter from its shebang inside the initrd (via
`$targetRoot/nix/store/...-bash-5.2p32/bin/bash`) and do the
switch_root I get a different error:

    + exec env -i /nix/store/akm69s5sngxyvqrzys326dss9rsrvbpy-extra-utils/b=
in/switch_root /mnt-root /nix/store/k3pm4iv44y7x7p74kky6cwxiswmr6kpi-nixos-=
system-machine-test/init
    [    1.912859] list_del corruption. prev->next should be ffffc5cf80be02=
48, but was ffffc5cf80bd9208. (prev=3Dffffc5cf80bb4d48)
    [    1.914237] ------------[ cut here ]------------
    [    1.915059] kernel BUG at lib/list_debug.c:62!
    [    1.915854] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
    [    1.916739] CPU: 0 UID: 0 PID: 17 Comm: ksoftirqd/0 Not tainted 6.12=
.0-rc1 #1-NixOS
    [    1.917837] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    [    1.919354] RIP: 0010:__list_del_entry_valid_or_report+0xb4/0xd0
    [    1.920180] Code: 0f 0b 48 89 fe 48 89 ca 48 c7 c7 38 52 41 9f e8 42=
 91 ac ff 90 0f 0b 48 89 fe 48 89 c2 48 c7 c7 70 52 41 9f e8 2d 91 ac ff 90=
 <0f> 0b 48 89 d1 48 c7 c7 c0 52 41 9f 48 89 f2 48 89 c6 e8 15 91 ac
    [    1.922636] RSP: 0018:ffff96f800093c00 EFLAGS: 00010046
    [    1.923563] RAX: 000000000000006d RBX: 0000000000000001 RCX: 0000000=
000000000
    [    1.924692] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
    [    1.925664] RBP: 0000000000000341 R08: 0000000000000000 R09: 0000000=
000000000
    [    1.926646] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8fb=
ebd83dc90
    [    1.927584] R13: ffffc5cf80be0240 R14: ffff8fbebd83dc80 R15: 0000000=
00002f809
    [    1.928533] FS:  0000000000000000(0000) GS:ffff8fbebd800000(0000) kn=
lGS:0000000000000000
    [    1.929647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    1.930431] CR2: 00007fed6f09b000 CR3: 0000000001e02000 CR4: 0000000=
000350ef0
    [    1.931333] Call Trace:
    [    1.931727]  <TASK>
    [    1.932088]  ? die+0x36/0x90
    [    1.932595]  ? do_trap+0xed/0x110
    [    1.933047]  ? __list_del_entry_valid_or_report+0xb4/0xd0
    [    1.933757]  ? do_error_trap+0x6a/0xa0
    [    1.934390]  ? __list_del_entry_valid_or_report+0xb4/0xd0
    [    1.935073]  ? exc_invalid_op+0x51/0x80
    [    1.935627]  ? __list_del_entry_valid_or_report+0xb4/0xd0
    [    1.936326]  ? asm_exc_invalid_op+0x1a/0x20
    [    1.936904]  ? __list_del_entry_valid_or_report+0xb4/0xd0
    [    1.937622]  free_pcppages_bulk+0x130/0x280
    [    1.938151]  free_unref_page_commit+0x21c/0x380
    [    1.938753]  free_unref_page+0x472/0x4f0
    [    1.939343]  __put_partials+0xee/0x130
    [    1.939921]  ? rcu_do_batch+0x1f2/0x800
    [    1.940471]  kmem_cache_free+0x2c3/0x370
    [    1.940990]  rcu_do_batch+0x1f2/0x800
    [    1.941508]  ? rcu_do_batch+0x180/0x800
    [    1.942031]  rcu_core+0x182/0x340
    [    1.942500]  handle_softirqs+0xe4/0x2f0
    [    1.943034]  run_ksoftirqd+0x33/0x40
    [    1.943522]  smpboot_thread_fn+0xdd/0x1d0
    [    1.944056]  ? __pfx_smpboot_thread_fn+0x10/0x10
    [    1.944679]  kthread+0xd0/0x100
    [    1.945126]  ? __pfx_kthread+0x10/0x10
    [    1.945656]  ret_from_fork+0x34/0x50
    [    1.946151]  ? __pfx_kthread+0x10/0x10
    [    1.946680]  ret_from_fork_asm+0x1a/0x30
    [    1.947269]  </TASK>
    [    1.947622] Modules linked in: overlay 9p ext4 crc32c_generic crc16 =
mbcache jbd2 hid_generic usbhid hid 9pnet_virtio 9pnet netfs sr_mod virtio_=
net cdrom virtio_blk net_failover atkbd failover libps2 vivaldi_fmap crc32c=
_intel ata_piix libata uhci_hcd scsi_mod ehci_hcd virtio_pci virtio_pci_leg=
acy_dev virtio_pci_modern_dev scsi_common i8042 serio rtc_cmos dm_mod dax v=
irtio_gpu virtio_dma_buf virtio_rng rng_core virtio_console virtio_balloon =
virtio virtio_ring
    [    1.952291] ---[ end trace 0000000000000000 ]---
    [    1.952893] RIP: 0010:__list_del_entry_valid_or_report+0xb4/0xd0
    [    1.953678] Code: 0f 0b 48 89 fe 48 89 ca 48 c7 c7 38 52 41 9f e8 42=
 91 ac ff 90 0f 0b 48 89 fe 48 89 c2 48 c7 c7 70 52 41 9f e8 2d 91 ac ff 90=
 <0f> 0b 48 89 d1 48 c7 c7 c0 52 41 9f 48 89 f2 48 89 c6 e8 15 91 ac
    [    1.955888] RSP: 0018:ffff96f800093c00 EFLAGS: 00010046
    [    1.956548] RAX: 000000000000006d RBX: 0000000000000001 RCX: 0000000=
000000000
    [    1.957436] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
    [    1.958328] RBP: 0000000000000341 R08: 0000000000000000 R09: 0000000=
000000000
    [    1.959166] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8fb=
ebd83dc90
    [    1.960044] R13: ffffc5cf80be0240 R14: ffff8fbebd83dc80 R15: 0000000=
00002f809
    [    1.960905] FS:  0000000000000000(0000) GS:ffff8fbebd800000(0000) kn=
lGS:0000000000000000
    [    1.961926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    1.962693] CR2: 00007fed6f09b000 CR3: 0000000001e02000 CR4: 0000000=
000350ef0
    [    1.963548] Kernel panic - not syncing: Fatal exception in interrupt
    [    1.964417] Kernel Offset: 0x1ce00000 from 0xffffffff81000000 (reloc=
ation range: 0xffffffff80000000-0xffffffffbfffffff)

On a subsequent run to verify this, it failed earlier while reading
$targetRoot/.../bash like this:


    [    1.871810] BUG: Bad page state in process cat  pfn:2e74a
    [    1.872481] page: refcount:1 mapcount:0 mapping:0000000000000000 ind=
ex:0x1e5 pfn:0x2e74a
    [    1.873499] flags: 0xffffc000000000(node=3D0|zone=3D1|lastcpupid=3D0=
x1ffff)
    [    1.874260] raw: 00ffffc000000000 dead000000000100 dead000000000122 =
0000000000000000
    [    1.875250] raw: 00000000000001e5 0000000000000000 00000001ffffffff =
0000000000000000
    [    1.876295] page dumped because: nonzero _refcount
    [    1.876910] Modules linked in: overlay 9p ext4 crc32c_generic crc16 =
mbcache jbd2 hid_generic usbhid hid 9pnet_virtio 9pnet netfs sr_mod virtio_=
net cdrom virtio_blk net_failover atkbd failover libps2 vivaldi_fmap crc32c=
_intel ata_piix libata scsi_mod uhci_hcd ehci_hcd virtio_pci virtio_pci_leg=
acy_dev virtio_pci_modern_dev scsi_common i8042 serio rtc_cmos dm_mod dax v=
irtio_gpu virtio_dma_buf virtio_rng rng_core virtio_console virtio_balloon =
virtio virtio_ring
    [    1.881465] CPU: 0 UID: 0 PID: 315 Comm: cat Not tainted 6.12.0-rc1 =
#1-NixOS
    [    1.882326] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    [    1.883684] Call Trace:
    [    1.884103]  <TASK>
    [    1.884440]  dump_stack_lvl+0x64/0x90
    [    1.884954]  bad_page+0x70/0x110
    [    1.885468]  __rmqueue_pcplist+0x209/0xd00
    [    1.886029]  ? srso_return_thunk+0x5/0x5f
    [    1.886572]  ? pdu_read+0x36/0x50 [9pnet]
    [    1.887177]  get_page_from_freelist+0x2df/0x1910
    [    1.887788]  ? srso_return_thunk+0x5/0x5f
    [    1.888324]  ? enqueue_entity+0xce/0x510
    [    1.888881]  ? srso_return_thunk+0x5/0x5f
    [    1.889415]  ? pick_eevdf+0x76/0x1a0
    [    1.889970]  ? update_curr+0x35/0x270
    [    1.890476]  __alloc_pages_noprof+0x1a3/0x1150
    [    1.891158]  ? srso_return_thunk+0x5/0x5f
    [    1.891712]  ? __mod_memcg_lruvec_state+0xa9/0x160
    [    1.892346]  ? srso_return_thunk+0x5/0x5f
    [    1.892919]  ? __lruvec_stat_mod_folio+0x83/0xd0
    [    1.893521]  alloc_pages_mpol_noprof+0x8f/0x1f0
    [    1.894148]  folio_alloc_noprof+0x5b/0xb0
    [    1.894671]  page_cache_ra_unbounded+0x11f/0x200
    [    1.895270]  filemap_get_pages+0x538/0x6d0
    [    1.895813]  ? srso_return_thunk+0x5/0x5f
    [    1.896361]  filemap_splice_read+0x136/0x320
    [    1.896948]  backing_file_splice_read+0x52/0xa0
    [    1.897522]  ovl_splice_read+0xd2/0xf0 [overlay]
    [    1.898160]  ? __pfx_ovl_file_accessed+0x10/0x10 [overlay]
    [    1.898817]  splice_direct_to_actor+0xb4/0x270
    [    1.899404]  ? __pfx_direct_splice_actor+0x10/0x10
    [    1.900103]  do_splice_direct+0x77/0xd0
    [    1.900627]  ? __pfx_direct_file_splice_eof+0x10/0x10
    [    1.901308]  do_sendfile+0x359/0x410
    [    1.901788]  __x64_sys_sendfile64+0xb9/0xd0
    [    1.902370]  do_syscall_64+0xb7/0x210
    [    1.902904]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
    [    1.903604] RIP: 0033:0x7fa9f3a7289e
    [    1.904214] Code: 75 0e 00 f7 d8 64 89 02 b8 ff ff ff ff 31 d2 31 c9=
 31 ff 45 31 db c3 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 28 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 12 31 d2 31 c9 31 f6 31 ff 45 31 d2 45 31 db
    [    1.906436] RSP: 002b:00007ffe6a82bde8 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000028
    [    1.907400] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa=
9f3a7289e
    [    1.908241] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000=
000000001
    [    1.909184] RBP: 00007ffe6a82be50 R08: 0000000000000000 R09: 0000000=
000000000
    [    1.910212] R10: 0000000001000000 R11: 0000000000000246 R12: 0000000=
000000001
    [    1.911117] R13: 0000000001000000 R14: 0000000000000001 R15: 0000000=
000000000
    [    1.911998]  </TASK>
    [    1.912376] Disabling lock debugging due to kernel taint
    [    1.913479] list_del corruption. next->prev should be ffffc80e40b9d9=
48, but was ffffc80e40b9d0c8. (next=3Dffffc80e40b9c7c8)
    [    1.914823] ------------[ cut here ]------------
    [    1.915408] kernel BUG at lib/list_debug.c:65!
    [    1.916050] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
    [    1.916785] CPU: 0 UID: 0 PID: 315 Comm: cat Tainted: G    B        =
      6.12.0-rc1 #1-NixOS
    [    1.917877] Tainted: [B]=3DBAD_PAGE
    [    1.918350] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    [    1.919996] RIP: 0010:__list_del_entry_valid_or_report+0xcc/0xd0
    [    1.920903] Code: 89 fe 48 89 c2 48 c7 c7 70 52 41 ba e8 2d 91 ac ff=
 90 0f 0b 48 89 d1 48 c7 c7 c0 52 41 ba 48 89 f2 48 89 c6 e8 15 91 ac ff 90=
 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
    [    1.923423] RSP: 0018:ffff9ed880187748 EFLAGS: 00010246
    [    1.924210] RAX: 000000000000006d RBX: ffff94db3d83dc80 RCX: 0000000=
000000000
    [    1.925147] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
    [    1.926051] RBP: ffffc80e40b9d940 R08: 0000000000000000 R09: 0000000=
000000000
    [    1.926940] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000001
    [    1.927809] R13: ffff94db3d83dc80 R14: ffffc80e40b9d948 R15: ffff94d=
b3ffd6180
    [    1.928695] FS:  00007fa9f396eb80(0000) GS:ffff94db3d800000(0000) kn=
lGS:0000000000000000
    [    1.929728] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    1.930540] CR2: 00000000004d1829 CR3: 0000000001dd2000 CR4: 0000000=
000350ef0
    [    1.931444] Call Trace:
    [    1.931916]  <TASK>
    [    1.932357]  ? die+0x36/0x90
    [    1.932831]  ? do_trap+0xed/0x110
    [    1.933385]  ? __list_del_entry_valid_or_report+0xcc/0xd0
    [    1.934073]  ? do_error_trap+0x6a/0xa0
    [    1.934583]  ? __list_del_entry_valid_or_report+0xcc/0xd0
    [    1.935242]  ? exc_invalid_op+0x51/0x80
    [    1.935781]  ? __list_del_entry_valid_or_report+0xcc/0xd0
    [    1.936484]  ? asm_exc_invalid_op+0x1a/0x20
    [    1.937174]  ? __list_del_entry_valid_or_report+0xcc/0xd0
    [    1.937926]  ? __list_del_entry_valid_or_report+0xcb/0xd0
    [    1.938685]  __rmqueue_pcplist+0xa5/0xd00
    [    1.939292]  ? srso_return_thunk+0x5/0x5f
    [    1.940004]  ? __mod_memcg_lruvec_state+0xa9/0x160
    [    1.940758]  ? srso_return_thunk+0x5/0x5f
    [    1.941417]  ? update_load_avg+0x7e/0x7f0
    [    1.942133]  ? srso_return_thunk+0x5/0x5f
    [    1.942838]  ? srso_return_thunk+0x5/0x5f
    [    1.943508]  get_page_from_freelist+0x2df/0x1910
    [    1.944143]  ? srso_return_thunk+0x5/0x5f
    [    1.944696]  ? check_preempt_wakeup_fair+0x1ee/0x240
    [    1.945335]  ? srso_return_thunk+0x5/0x5f
    [    1.945905]  __alloc_pages_noprof+0x1a3/0x1150
    [    1.946489]  ? __blk_flush_plug+0xf5/0x150
    [    1.947105]  ? srso_return_thunk+0x5/0x5f
    [    1.947629]  ? __dquot_alloc_space+0x2a8/0x3a0
    [    1.948404]  ? srso_return_thunk+0x5/0x5f
    [    1.949116]  ? __mod_memcg_lruvec_state+0xa9/0x160
    [    1.949888]  alloc_pages_mpol_noprof+0x8f/0x1f0
    [    1.950514]  folio_alloc_mpol_noprof+0x14/0x40
    [    1.951153]  shmem_alloc_folio+0xa7/0xd0
    [    1.951692]  ? shmem_recalc_inode+0x20/0x90
    [    1.952272]  shmem_alloc_and_add_folio+0x109/0x490
    [    1.952940]  ? filemap_get_entry+0x10f/0x1a0
    [    1.953570]  ? srso_return_thunk+0x5/0x5f
    [    1.954185]  shmem_get_folio_gfp+0x248/0x610
    [    1.954791]  shmem_write_begin+0x64/0x110
    [    1.955484]  generic_perform_write+0xdf/0x2a0
    [    1.956239]  shmem_file_write_iter+0x8a/0x90
    [    1.956882]  iter_file_splice_write+0x33f/0x580
    [    1.957577]  direct_splice_actor+0x54/0x140
    [    1.958178]  splice_direct_to_actor+0xec/0x270
    [    1.958813]  ? __pfx_direct_splice_actor+0x10/0x10
    [    1.959442]  do_splice_direct+0x77/0xd0
    [    1.960018]  ? __pfx_direct_file_splice_eof+0x10/0x10
    [    1.960726]  do_sendfile+0x359/0x410
    [    1.961248]  __x64_sys_sendfile64+0xb9/0xd0
    [    1.961905]  do_syscall_64+0xb7/0x210
    [    1.962467]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
    [    1.963211] RIP: 0033:0x7fa9f3a7289e
    [    1.963711] Code: 75 0e 00 f7 d8 64 89 02 b8 ff ff ff ff 31 d2 31 c9=
 31 ff 45 31 db c3 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 28 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 12 31 d2 31 c9 31 f6 31 ff 45 31 d2 45 31 db
    [    1.965846] RSP: 002b:00007ffe6a82bde8 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000028
    [    1.966788] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa=
9f3a7289e
    [    1.967644] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000=
000000001
    [    1.968480] RBP: 00007ffe6a82be50 R08: 0000000000000000 R09: 0000000=
000000000
    [    1.969396] R10: 0000000001000000 R11: 0000000000000246 R12: 0000000=
000000001
    [    1.970315] R13: 0000000001000000 R14: 0000000000000001 R15: 0000000=
000000000
    [    1.971214]  </TASK>
    [    1.971572] Modules linked in: overlay 9p ext4 crc32c_generic crc16 =
mbcache jbd2 hid_generic usbhid hid 9pnet_virtio 9pnet netfs sr_mod virtio_=
net cdrom virtio_blk net_failover atkbd failover libps2 vivaldi_fmap crc32c=
_intel ata_piix libata scsi_mod uhci_hcd ehci_hcd virtio_pci virtio_pci_leg=
acy_dev virtio_pci_modern_dev scsi_common i8042 serio rtc_cmos dm_mod dax v=
irtio_gpu virtio_dma_buf virtio_rng rng_core virtio_console virtio_balloon =
virtio virtio_ring
    [    1.976558] ---[ end trace 0000000000000000 ]---
    [    1.977219] RIP: 0010:__list_del_entry_valid_or_report+0xcc/0xd0
    [    1.978033] Code: 89 fe 48 89 c2 48 c7 c7 70 52 41 ba e8 2d 91 ac ff=
 90 0f 0b 48 89 d1 48 c7 c7 c0 52 41 ba 48 89 f2 48 89 c6 e8 15 91 ac ff 90=
 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
    [    1.980179] RSP: 0018:ffff9ed880187748 EFLAGS: 00010246
    [    1.980847] RAX: 000000000000006d RBX: ffff94db3d83dc80 RCX: 0000000=
000000000
    [    1.981705] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
    [    1.982584] RBP: ffffc80e40b9d940 R08: 0000000000000000 R09: 0000000=
000000000
    [    1.983464] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000001
    [    1.984358] R13: ffff94db3d83dc80 R14: ffffc80e40b9d948 R15: ffff94d=
b3ffd6180
    [    1.987765] FS:  00007fa9f396eb80(0000) GS:ffff94db3d800000(0000) kn=
lGS:0000000000000000
    [    1.988805] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    1.989497] CR2: 00000000004d1829 CR3: 0000000001dd2000 CR4: 0000000=
000350ef0
    [    1.990418] note: cat[315] exited with preempt_count 2

I bisected it back to ee4cdf7ba857a894ad1650d6ab77669cbbfa329e which
also seems to touch part of the 9p VFS code.

Unfortunately the revert didn't apply cleanly on 6.12-rc1, so I couldn't
meaningfully test whether a simple revert solves the problem.

The VMs get the Nix store mounted via 9p. In the store are basically all
build artifacts including the stage-2 init script of the system that is
booted into in the VM test.

The invocation basically looks like this:

    qemu-system-x86_64 -cpu max \
        -name machine \
        -m 1024 \
        -smp 1 \
        -device virtio-rng-pci \
        -net nic,netdev=3Duser.0,model=3Dvirtio -netdev user,id=3Duser.0,"$=
QEMU_NET_OPTS" \
        -virtfs local,path=3D/nix/store,security_model=3Dnone,mount_tag=3Dn=
ix-store \
        -virtfs local,path=3D"${SHARED_DIR:-$TMPDIR/xchg}",security_model=
=3Dnone,mount_tag=3Dshared \
        -virtfs local,path=3D"$TMPDIR"/xchg,security_model=3Dnone,mount_tag=
=3Dxchg \
        -drive cache=3Dwriteback,file=3D"$NIX_DISK_IMAGE",id=3Ddrive1,if=3D=
none,index=3D1,werror=3Dreport -device virtio-blk-pci,bootindex=3D1,drive=
=3Ddrive1,serial=3Droot \
        -device virtio-net-pci,netdev=3Dvlan1,mac=3D52:54:00:12:01:01 \
        -netdev vde,id=3Dvlan1,sock=3D"$QEMU_VDE_SOCKET_1" \
        -device virtio-keyboard \
        -usb \
        -device usb-tablet,bus=3Dusb-bus.0 \
        -kernel ${NIXPKGS_QEMU_KERNEL_machine:-/nix/store/zv87gw0yxfsslq0mc=
c35a99k54da9a4z-nixos-system-machine-test/kernel} \
        -initrd /nix/store/qqalw1iq1wbgq3ndx0cvqn3bfypn56w2-initrd-linux-6.=
12-rc1/initrd \
        -append "$(cat /nix/store/zv87gw0yxfsslq0mcc35a99k54da9a4z-nixos-sy=
stem-machine-test/kernel-params) init=3D/nix/store/zv87gw0yxfsslq0mcc35a99k=
54da9a4z-nixos-system-machine-test/init regInfo=3D/nix/store/5izvfal6xm2rk5=
1v0r1h2cxcng33paby-closure-info/registration console=3DttyS0 $QEMU_KERNEL_P=
ARAMS" \
        $QEMU_OPTS

If you're using Nix, you can also reproduce this by running

    nix-build nixos/tests/kernel-generic.nix -A linux_testing

on 5c19646b81db43dd7f4b6954f17d71a523009706 from https://github.com/nixos/n=
ixpkgs.

To me, this seems like a regression in rc1.

Is there anything else I can do to help troubleshooting this?

With best regards

Maximilian

