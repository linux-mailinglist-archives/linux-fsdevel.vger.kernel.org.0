Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4553A6CA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 19:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhFNRFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbhFNRFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:05:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F672C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 10:03:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a20so15352579wrc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=omDzTVl70cALNG8ECH/YWSfwVib/q/izF3uhBR3N9AU=;
        b=F62OetuzB4Jo5RSuWZqPHgDZFtlu6cxDvp1E9D3r8x1thwq5TILrwoLqB3DHrsMnEd
         nAYv1KH9ZTt3QpkVwPkwVynNqQZMrO9iT4mXL4fS0Mhsq3gho7hfoleojTiGZolQ/9bn
         MM4DWIaEJ/82vJb5BelRuNA6GXLpG3OTMlnjIIGGyQUDS5w9BcV939MnAzpOzUpF2qdU
         MvvkVA/+/w6zGZ/2HTeBt5ylsS85KrflGO+Uxk8wORDwnC4MomKk2J4lOS9KFM8d/WS7
         bBgMapSj4qkHfEDMfrPhUsGOURCPEnIW9s6jXV26G09WzJZHiPX8aJipeZSQk1Ey973K
         mQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=omDzTVl70cALNG8ECH/YWSfwVib/q/izF3uhBR3N9AU=;
        b=JLeHLgJ1FrM29ZWug1yV5d61MCq4Cxl1PaNIocob6CScF/WO1QRI6fLM8ON1oXGMME
         79Rb/tAJVyyG906d2wIAf8DpSV544oK6b/sDn++FV5tKzeq/SsKdCm9QRUjcRkHVbGCg
         mKHxqPqfJmQVwRZnALtKSohoaeV/EOMkr5LKAPC4g+AaYEiPFbKsuw85iSpzndaGW49p
         mkeAc7nwpwXZSUiLcT7OBHbrr7u030wR8F2HzAMmwBPY8EYFwN3Itib/BZhJatals5BR
         TYmP57Bybjwng0BK4hD9e6q58PsGdUhDt1Q8S45wdA/EGDeHyoDI2fwk1FHEjVR+zXtF
         Wtpg==
X-Gm-Message-State: AOAM532OZf6k24t3ILoGNCLrwRBKOK4G4ZgbwSKLvRB0c7p1Otzkcbc7
        p7fOmoAhw5GQNrloJ1m0S6MpFzVZKd2IN11kH4CBbaebnoABZaMe
X-Google-Smtp-Source: ABdhPJyg7dOaiEFSBE0w1UZSj8Cii9GMWpxti4HX8CUgzYM5rroFhjohFK4+s80rrclJMa6ilrYGt0HMy9J5JcoScTs=
X-Received: by 2002:a05:6000:1883:: with SMTP id a3mr9156040wri.65.1623690190675;
 Mon, 14 Jun 2021 10:03:10 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 14 Jun 2021 11:02:54 -0600
Message-ID: <CAJCQCtRQ57=qXo3kygwpwEBOU_CA_eKvdmjP52sU=eFvuVOEGw@mail.gmail.com>
Subject: WARNING at asm/kfence.h:44 kfence_protect_page
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

5.12.9-300.fc34.x86_64

File system is btrfs, 16G RAM, 8G /dev/zram0 is used for swap, and the
workload is:
* bees doing dedup
* btrfs send
* digikam scanning files and writing image metadata to a sqlite database
* chrome doing some webby things

And then kaboom.

Call trace (easy to read, expires in 7 days):
https://pastebin.com/x5KRU23V

Same call trace (MUA mangled, for the archive):
[60015.902283] kernel: WARNING: CPU: 3 PID: 58159 at
arch/x86/include/asm/kfence.h:44 kfence_protect_page+0x21/0x80
[60015.902292] kernel: Modules linked in: uinput rfcomm snd_seq_dummy
snd_hrtimer xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
nf_nat_tftp nf_conntrack_tftp nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
8021q garp mrp nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject bridge stp llc nft_ct nft_chain_nat ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nf_tables nfnetlink ip6table_filter ip6_tables
iptable_filter cmac bnep sunrpc vfat fat iwldvm mac80211 btusb btrtl
edac_mce_amd libarc4 btbcm snd_hda_codec_realtek iwlwifi
snd_hda_codec_generic ledtrig_audio btintel snd_hda_codec_hdmi
snd_hda_intel bluetooth kvm_amd snd_intel_dspcfg cfg80211
snd_intel_sdw_acpi ccp snd_hda_codec snd_hda_core kvm snd_hwdep
snd_seq joydev irqbypass snd_seq_device snd_pcm ecdh_generic ecc
k10temp rfkill i2c_piix4 fam15h_power
[60015.902361] kernel:  pcspkr snd_timer snd r8169 soundcore
acpi_cpufreq zram ip_tables amdgpu iommu_v2 gpu_sched crct10dif_pclmul
crc32_pclmul crc32c_intel radeon ghash_clmulni_intel sp5100_tco
i2c_algo_bit drm_ttm_helper ttm drm_kms_helper cec drm video fuse
[60015.902384] kernel: CPU: 3 PID: 58159 Comm: btrfs Not tainted
5.12.9-300.fc34.x86_64 #1
[60015.902387] kernel: Hardware name: Gigabyte Technology Co., Ltd. To
be filled by O.E.M./F2A88XN-WIFI, BIOS F6 12/24/2015
[60015.902389] kernel: RIP: 0010:kfence_protect_page+0x21/0x80
[60015.902393] kernel: Code: ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 53
89 f3 48 83 ec 08 48 8d 74 24 04 e8 cb e0 d7 ff 48 85 c0 74 07 83 7c
24 04 01 74 0b <0f> 0b 48 83 c4 08 31 c0 5b 5d c3 48 8b 38 48 89 c2 84
db 75 36 48
[60015.902396] kernel: RSP: 0018:ffff9fb583453220 EFLAGS: 00010246
[60015.902399] kernel: RAX: 0000000000000000 RBX: 0000000000000000
RCX: ffff9fb583453224
[60015.902401] kernel: RDX: ffff9fb583453224 RSI: 0000000000000000
RDI: 0000000000000000
[60015.902402] kernel: RBP: 0000000000000000 R08: 0000000000000000
R09: 0000000000000000
[60015.902404] kernel: R10: 0000000000000000 R11: 0000000000000000
R12: 0000000000000002
[60015.902406] kernel: R13: ffff9fb583453348 R14: 0000000000000000
R15: 0000000000000001
[60015.902408] kernel: FS:  00007f158e62d8c0(0000)
GS:ffff93bd37580000(0000) knlGS:0000000000000000
[60015.902410] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[60015.902412] kernel: CR2: 0000000000000039 CR3: 00000001256d2000
CR4: 00000000000506e0
[60015.902414] kernel: Call Trace:
[60015.902419] kernel:  kfence_unprotect+0x13/0x30
[60015.902423] kernel:  page_fault_oops+0x89/0x270
[60015.902427] kernel:  ? search_module_extables+0xf/0x40
[60015.902431] kernel:  ? search_bpf_extables+0x57/0x70
[60015.902435] kernel:  kernelmode_fixup_or_oops+0xd6/0xf0
[60015.902437] kernel:  __bad_area_nosemaphore+0x142/0x180
[60015.902440] kernel:  exc_page_fault+0x67/0x150
[60015.902445] kernel:  asm_exc_page_fault+0x1e/0x30
[60015.902450] kernel: RIP: 0010:start_transaction+0x71/0x580
[60015.902454] kernel: Code: d3 0f 84 92 00 00 00 80 e7 06 0f 85 63 04
00 00 65 48 8b 04 25 c0 7b 01 00 4c 8b a0 70 0c 00 00 b8 01 00 00 00
49 8d 7c 24 38 <f0> 41 0f c1 44 24 38 85 c0 0f 84 41 04 00 00 8d 50 01
09 c2 0f 88
[60015.902456] kernel: RSP: 0018:ffff9fb5834533f8 EFLAGS: 00010246
[60015.902458] kernel: RAX: 0000000000000001 RBX: 0000000000000001
RCX: 0000000000000000
[60015.902460] kernel: RDX: 0000000000000801 RSI: 0000000000000000
RDI: 0000000000000039
[60015.902462] kernel: RBP: ffff93bc0a7eb800 R08: 0000000000000001
R09: 0000000000000000
[60015.902463] kernel: R10: 0000000000098a00 R11: 0000000000000001
R12: 0000000000000001
[60015.902464] kernel: R13: 0000000000000000 R14: ffff93bc0c92b000
R15: ffff93bc0c92b000
[60015.902468] kernel:  btrfs_commit_inode_delayed_inode+0x5d/0x120
[60015.902473] kernel:  btrfs_evict_inode+0x2c5/0x3f0
[60015.902476] kernel:  evict+0xd1/0x180
[60015.902480] kernel:  inode_lru_isolate+0xe7/0x180
[60015.902483] kernel:  __list_lru_walk_one+0x77/0x150
[60015.902487] kernel:  ? iput+0x1a0/0x1a0
[60015.902489] kernel:  ? iput+0x1a0/0x1a0
[60015.902491] kernel:  list_lru_walk_one+0x47/0x70
[60015.902495] kernel:  prune_icache_sb+0x39/0x50
[60015.902497] kernel:  super_cache_scan+0x161/0x1f0
[60015.902501] kernel:  do_shrink_slab+0x142/0x240
[60015.902505] kernel:  shrink_slab+0x164/0x280
[60015.902509] kernel:  shrink_node+0x2c8/0x6e0
[60015.902512] kernel:  do_try_to_free_pages+0xcb/0x4b0
[60015.902514] kernel:  try_to_free_pages+0xda/0x190
[60015.902516] kernel:  __alloc_pages_slowpath.constprop.0+0x373/0xcc0
[60015.902521] kernel:  ? __memcg_kmem_charge_page+0xc2/0x1e0
[60015.902525] kernel:  __alloc_pages_nodemask+0x30a/0x340
[60015.902528] kernel:  pipe_write+0x30b/0x5c0
[60015.902531] kernel:  ? set_next_entity+0xad/0x1e0
[60015.902534] kernel:  ? switch_mm_irqs_off+0x58/0x440
[60015.902538] kernel:  __kernel_write+0x13a/0x2b0
[60015.902541] kernel:  kernel_write+0x73/0x150
[60015.902543] kernel:  send_cmd+0x7b/0xd0
[60015.902545] kernel:  send_extent_data+0x5a3/0x6b0
[60015.902549] kernel:  process_extent+0x19b/0xed0
[60015.902551] kernel:  btrfs_ioctl_send+0x1434/0x17e0
[60015.902554] kernel:  ? _btrfs_ioctl_send+0xe1/0x100
[60015.902557] kernel:  _btrfs_ioctl_send+0xbf/0x100
[60015.902559] kernel:  ? enqueue_entity+0x18c/0x7b0
[60015.902562] kernel:  btrfs_ioctl+0x185f/0x2f80
[60015.902564] kernel:  ? psi_task_change+0x84/0xc0
[60015.902569] kernel:  ? _flat_send_IPI_mask+0x21/0x40
[60015.902572] kernel:  ? check_preempt_curr+0x2f/0x70
[60015.902576] kernel:  ? selinux_file_ioctl+0x137/0x1e0
[60015.902579] kernel:  ? expand_files+0x1cb/0x1d0
[60015.902582] kernel:  ? __x64_sys_ioctl+0x82/0xb0
[60015.902585] kernel:  __x64_sys_ioctl+0x82/0xb0
[60015.902588] kernel:  do_syscall_64+0x33/0x40
[60015.902591] kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
[60015.902595] kernel: RIP: 0033:0x7f158e38f0ab
[60015.902599] kernel: Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff
5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 bd 0c 00 f7 d8
64 89 01 48
[60015.902602] kernel: RSP: 002b:00007ffcb2519bf8 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
[60015.902605] kernel: RAX: ffffffffffffffda RBX: 00007ffcb251ae00
RCX: 00007f158e38f0ab
[60015.902607] kernel: RDX: 00007ffcb2519cf0 RSI: 0000000040489426
RDI: 0000000000000004
[60015.902608] kernel: RBP: 0000000000000004 R08: 00007f158e297640
R09: 00007f158e297640
[60015.902610] kernel: R10: 0000000000000008 R11: 0000000000000246
R12: 0000000000000000
[60015.902612] kernel: R13: 0000000000000002 R14: 00007ffcb251aee0
R15: 0000558c1a83e2a0
[60015.902615] kernel: ---[ end trace 7bbc33e23bb887ae ]---


The full dmesg is attached to this downstream bug as "
journal-nobees.log (4.12 MB, text/plain)" which has all the beesd
entries removed (over 300M).
https://bugzilla.redhat.com/show_bug.cgi?id=1971327

The time between this oops and systemd-oomd starting to kill things
due to both swap and memory pressure is 81 minutes. I'm not sure the
two events are related. Or what the above stack trace is saying. Or
the consequences of it. But the system got wedged in totally
unresponsive and had to be forced off with the power button.

Thanks,


-- 
Chris Murphy
