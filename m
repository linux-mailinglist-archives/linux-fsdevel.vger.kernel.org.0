Return-Path: <linux-fsdevel+bounces-29097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FFD97553E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 16:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170761C229A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E319F105;
	Wed, 11 Sep 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="uyIAPMqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D919E80F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064866; cv=none; b=TJM54WTboc05FTfyUZ86uwv9qcrlgdDIjrVbj/bns791oODuJ4T3TLaNjR+xegUvPyBjoBKT4nxO8lbC+gLR72zb2WO/I8RHKdamONHkaYy2hVqpj0JTKgvt9Qn3yytJ0D15502s83ysYndP7oAxmcm3ONtryAZagFLxE0mmgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064866; c=relaxed/simple;
	bh=XsNaCx+ESnBW7j1FgiRbRDjO5NDYDuCdrNrpKuqnkCg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kwpIm86Do8bZybOvQaIvYoDEgLiOlxNPLsjRic9/W/GqCqGgSZn1vHyD37g4motYBnsSBRY4WdU1AjrATWRpoxyqXCCxDUr5EmsXLq8pek2ufapi8xzJCG1aqcFMAj9HLIqk3PsNAXrupKI99ChqOXNCi20XzXU9T+CopIZaQjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=uyIAPMqZ; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D6C249C6196
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 10:17:47 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id BfQ6uR4WVtJB; Wed, 11 Sep 2024 10:17:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2684B9C5B8A;
	Wed, 11 Sep 2024 10:17:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 2684B9C5B8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1726064266; bh=NbfrTW0VkL84ki7zJnYu7KJj0KHduITmem0TL5wHUyQ=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=uyIAPMqZa/Qnc/I/lEjviwa31+S7w1jFt3LAymeHbTzj66g8HJso8zHdEIR/lNgAT
	 t3NqDiSo+jfa8XXfcgeWk6nBu5zBrRhXt2le+LHXzX/u+F0lAr6X6pad+u3HTKSdtl
	 V0qeX4gIFskQqXjvYZ/+GUespKppLDnTQH/NxtBCwHQk2yamAx0gbJNg1w7mav+LWn
	 mlk27WIxws+yaKIEZAH26QvuGMBlkH20rfDj6x3gEzuVWCqyU/JHfh/RCoTDDBjSz1
	 XjwdTyxbU+3T2E46RY5+yQKwjG/RTdZVJq0jyb5C6WlR3f2ntVf8KQqH6JKpu221xT
	 /SNh0q/8YB8Iw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id iuvbPkX8puhf; Wed, 11 Sep 2024 10:17:46 -0400 (EDT)
Received: from [192.168.216.123] (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AED819C2AFE;
	Wed, 11 Sep 2024 10:17:45 -0400 (EDT)
Message-ID: <454dbcab-c29b-401d-b7ce-b41169488cc1@savoirfairelinux.com>
Date: Wed, 11 Sep 2024 16:17:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: workqueue CPU hog with filesystem access
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I am encountering system freeze with the following dmesg appearing:

	workqueue: inode_switch_wbs_work_fn hogged CPU for >10000us 16384 
times, consider switching to WQ_UNBOUND
	watchdog: BUG: soft lockup - CPU#16 stuck for 26s! [kworker/u67:3:906186]

`top` reports that kworkers are using 100% of ~half cores, yet the 
system is completely unresponsive. I can sometimes squeeze in a shell 
command, but it may not even be possible. After a while, it may come 
back to normal.

This error looks related to a recent workqueue refactoring. Similar 
users have reported this kind of issues on other workqueues:

  - i915_hpd_poll_init_work (patched)
    https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/9245
    https://lkml.org/lkml/2023/8/30/613
  - hwmon/nct6775 (patched)
  
https://ubuntuforums.org/showthread.php?t=2490640&s=94bfdd22dbe4935b246941521bf52a59&p=14158255#post14158255
  - delayed_fput - bttrfs (no answer)
    https://bugs.launchpad.net/ubuntu/+source/linux-oem-6.5/+bug/2038492

My system is using the following filesystems on an AMD Ryzen CPU:
  - ntfs
  - ext4
  - fuse.bindfs

Can someone with experience on inode_switch_wbs_work_fn() have a look at 
the workqueue management for any regression?

Any help would be greatly appreciated.
Best Regards,

Enguerrand de Ribaucourt
Savoir-faire Linux

PS: Here's a stacktrace generated on affected CPU cores:

  $ uname -a
Linux <hostname> 6.8.0-40-generic #40~22.04.3-Ubuntu SMP PREEMPT_DYNAMIC 
Tue Jul 30 17:30:19 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

[ 9588.618040] watchdog: BUG: soft lockup - CPU#16 stuck for 26s! 
[kworker/u67:3:906186]
[ 9588.618051] Modules linked in: veth tls xt_conntrack nft_chain_nat 
xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables 
nfnetlink br_netfilter bridge stp llc rpcsec_gss_krb5 auth_rpcgss nfsv4 
nfs lockd grace netfs overlay sunrpc intel_rapl_msr intel_rapl_common 
binfmt_misc snd_hda_codec_realtek edac_mce_amd snd_hda_codec_generic 
snd_hda_codec_hdmi snd_hda_intel kvm_amd snd_intel_dspcfg nls_iso8859_1 
snd_intel_sdw_acpi snd_hda_codec kvm snd_hda_core snd_hwdep irqbypass 
snd_pcm rapl snd_timer eeepc_wmi snd wmi_bmof ccp k10temp soundcore 
mac_hid dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua sch_fq_codel 
msr efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 
raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor 
raid6_pq libcrc32c raid1 raid0 amdgpu amdxcp drm_exec gpu_sched 
drm_buddy radeon hid_generic drm_suballoc_helper drm_ttm_helper ttm 
drm_display_helper mfd_aaeon usbhid asus_wmi hid
[ 9588.618145]  ledtrig_audio cec nvme sparse_keymap platform_profile 
crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic 
ghash_clmulni_intel sha256_ssse3 sha1_ssse3 rc_core i2c_piix4 igb video 
ahci r8169 xhci_pci nvme_core dca libahci xhci_pci_renesas realtek 
i2c_algo_bit nvme_auth wmi aesni_intel crypto_simd cryptd
[ 9588.618176] CPU: 16 PID: 906186 Comm: kworker/u67:3 Tainted: G 
      L     6.8.0-40-generic #40~22.04.3-Ubuntu
[ 9588.618179] Hardware name: System manufacturer System Product 
Name/PRIME X570-P, BIOS 4602 02/23/2023
[ 9588.618182] Workqueue: writeback wb_workfn (flush-252:1)
[ 9588.618187] RIP: 0010:native_queued_spin_lock_slowpath+0x26e/0x300
[ 9588.618191] Code: 81 c5 80 59 03 00 49 81 ff ff 1f 00 00 0f 87 91 00 
00 00 4e 03 2c fd e0 3c 4f 91 4d 89 65 00 41 8b 44 24 08 85 c0 75 0b f3 
90 <41> 8b 44 24 08 85 c0 74 f5 49 8b 14 24 48 85 d2 74 05 0f 0d 0a eb
[ 9588.618193] RSP: 0018:ffffaf0086e83a98 EFLAGS: 00000246
[ 9588.618196] RAX: 0000000000000000 RBX: ffff8a7bc77ff458 RCX: 
0000000000000000
[ 9588.618198] RDX: 0000000000000017 RSI: 00000000005c0001 RDI: 
ffff8a7bc77ff458
[ 9588.618200] RBP: ffffaf0086e83ac0 R08: 0000000000000000 R09: 
0000000000000000
[ 9588.618201] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff8a8aaea35980
[ 9588.618203] R13: ffff8a8aaed35980 R14: 0000000000440000 R15: 
0000000000000016
[ 9588.618205] FS:  0000000000000000(0000) GS:ffff8a8aaea00000(0000) 
knlGS:0000000000000000
[ 9588.618207] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9588.618209] CR2: 0000709d480c5240 CR3: 0000000119b58000 CR4: 
0000000000350ef0
[ 9588.618211] Call Trace:
[ 9588.618213]  <IRQ>
[ 9588.618216]  ? show_regs+0x6d/0x80
[ 9588.618220]  ? watchdog_timer_fn+0x206/0x290
[ 9588.618223]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 9588.618226]  ? __hrtimer_run_queues+0x112/0x2a0
[ 9588.618230]  ? srso_return_thunk+0x5/0x5f
[ 9588.618234]  ? hrtimer_interrupt+0xf6/0x250
[ 9588.618239]  ? __sysvec_apic_timer_interrupt+0x51/0x150
[ 9588.618243]  ? sysvec_apic_timer_interrupt+0x8d/0xd0
[ 9588.618247]  </IRQ>
[ 9588.618248]  <TASK>
[ 9588.618250]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[ 9588.618256]  ? native_queued_spin_lock_slowpath+0x26e/0x300
[ 9588.618261]  _raw_spin_lock+0x3f/0x60
[ 9588.618263]  do_writepages+0x7c/0x1f0
[ 9588.618269]  ? native_queued_spin_lock_slowpath+0x28b/0x300
[ 9588.618273]  __writeback_single_inode+0x44/0x290
[ 9588.618276]  ? srso_return_thunk+0x5/0x5f
[ 9588.618280]  writeback_sb_inodes+0x211/0x510
[ 9588.618288]  __writeback_inodes_wb+0x54/0x100
[ 9588.618291]  ? queue_io+0x115/0x120
[ 9588.618295]  wb_writeback+0x2a8/0x320
[ 9588.618300]  wb_do_writeback+0x225/0x2a0
[ 9588.618306]  wb_workfn+0x5f/0x230
[ 9588.618308]  ? finish_task_switch.isra.0+0x8c/0x2f0
[ 9588.618312]  ? srso_return_thunk+0x5/0x5f
[ 9588.618315]  ? __schedule+0x284/0x6a0
[ 9588.618319]  process_one_work+0x16f/0x350
[ 9588.618324]  worker_thread+0x306/0x440
[ 9588.618328]  ? __pfx_worker_thread+0x10/0x10
[ 9588.618331]  kthread+0xf2/0x120
[ 9588.618334]  ? __pfx_kthread+0x10/0x10
[ 9588.618337]  ret_from_fork+0x47/0x70
[ 9588.618340]  ? __pfx_kthread+0x10/0x10
[ 9588.618343]  ret_from_fork_asm+0x1b/0x30
[ 9588.618349]  </TASK>

