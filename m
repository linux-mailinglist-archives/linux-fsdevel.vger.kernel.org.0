Return-Path: <linux-fsdevel+bounces-27070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE6A95E5B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 01:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481C51F2172B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 23:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1B4778C;
	Sun, 25 Aug 2024 23:26:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD00A59
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Aug 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724628406; cv=none; b=m6Cnpo4zMFlmPaxWWwaDcSyFN2fr985TG7b90e2OjRKkc0nZMypRS6ew761YyGWRlPvqloZFgtz61phBa1zdn/2zagBupf8VLZb3ZeUntJRqKhRxptU/4ernkDA9Yrgb5E2WofXu7IFKOSYOXt65DAcoS+d5WOing6xCKDFvmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724628406; c=relaxed/simple;
	bh=pXnVOgxruy7upgSFMu4G4QAIQBR9xZKhYwM8ouYK2ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l5AtRY4izZiQlOiGK+4XT/znFaKHBTeG0hGnCP8MfXyny5mKNkKhv2p8S+LDPmOoQi7K7TCDxQojO870Vq37KGAi5xvCKxz3ZOX+oVTc8Tm1EFsN9VMEOUCL/r7DF2DBt2w1mBhbGF26xsJ7T/WMBe8WH1y2qRKNZbO4sH5J5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-189-143.static.sonic.net (192-184-189-143.static.sonic.net [192.184.189.143])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 47PNQfjR016820;
	Sun, 25 Aug 2024 16:26:42 -0700
From: Forest <forestix@nom.one>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc: linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        regressions@lists.linux.dev
Subject: [REGRESSION] cifs: Subreq overread in dmesg, invalid argument & no data available in apps
Date: Sun, 25 Aug 2024 16:26:42 -0700
Message-ID: <37fncjpgsq45becdf2pdju0idf3hj3dtmb@sonic.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVY9qXQA6gjyYUCqwUmjO34eOG5cOZDxGNJeFM6iyDDoSYbBnejS/v8rXX07lYcnqaR51DkoDWkqyM2hSy5c7rnM
X-Sonic-ID: C;/qwxfDlj7xGgZa5Sr7edkQ== M;nHZCfDlj7xGgZa5Sr7edkQ==
X-Spam-Flag: No
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd

#regzbot introduced: e3786b29c54c

Dear maintainers,

Recent kernel release candidates have a cifs regression that produces
unexpected errors in userspace and a WARNING (with stack trace) in dmesg.

I can consistently reproduce it with these commands on a mounted Samba
share:


$ echo hello > foo
$ ls -l foo
-rw-r----- 1 user user 6 Aug 25 15:41 foo
$ cat foo
cat: foo: Invalid argument
$ xxd foo
00000000: 6865 6c6c 6f0a 0000 0000 0000 0000 0000  hello...........
00000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
(...more null bytes...)
00001fe0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00001ff0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
xxd: No data available


The xxd command above also triggers these kernel log messages...

  Subreq overread: R3[1] 312 > 8192 - 7956
  WARNING: CPU: 30 PID: 421 at fs/netfs/io.c:495

...followed by the usual module list and stack trace.


The bug is present in kernel v6.11-rc5, but not the 6.10 series.

Git bisect says:

e3786b29c54cdae3490b07180a54e2461f42144c is the first bad commit
commit e3786b29c54cdae3490b07180a54e2461f42144c
Author: Dominique Martinet <asmadeus@codewreck.org>
Date:   Thu Aug 8 14:29:38 2024 +0100
    9p: Fix DIO read through netfs


Here's the full dmesg output when I run xxd on kernel v6.11-rc5:

[   48.137018] ------------[ cut here ]------------
[   48.137021] Subreq overread: R3[1] 312 > 8192 - 7956
[   48.137029] WARNING: CPU: 30 PID: 421 at fs/netfs/io.c:495 netfs_subreq_terminated+0x276/0x2d0 [netfs]
[   48.137046] Modules linked in: rfcomm algif_hash algif_skcipher af_alg cmac nls_utf8 cifs cifs_arc4 nls_ucs2_utils cifs_md4 dns_resolver netfs nft_masq nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bridge stp llc nf_tables nfnetlink nvme_fabrics essiv authenc crypto_null snd_seq_dummy snd_hrtimer snd_seq snd_seq_device qrtr zstd
zram bnep binfmt_misc nls_ascii nls_cp437 vfat fat mt7921e snd_hda_codec_realtek mt7921_common snd_hda_codec_generic mt792x_lib snd_hda_scodec_component mt76_connac_lib
snd_hda_codec_hdmi mt76 btusb snd_hda_intel amd_atl btrtl intel_rapl_msr snd_intel_dspcfg intel_rapl_common snd_intel_sdw_acpi btintel amd64_edac edac_mce_amd mac80211 btbcm
snd_hda_codec asus_nb_wmi eeepc_wmi btmtk asus_wmi kvm_amd snd_hda_core sparse_keymap bluetooth libarc4 snd_hwdep platform_profile kvm cfg80211 snd_pcm battery wmi_bmof rapl
snd_timer sp5100_tco ccp pcspkr watchdog snd k10temp rfkill soundcore joydev sg evdev nct6775 nct6775_core hwmon_vid msr parport_pc ppdev lp parport loop efi_pstore
[   48.137103]  configfs ip_tables x_tables autofs4 ext4 mbcache jbd2 btrfs dm_crypt dm_mod efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx
xor raid6_pq libcrc32c crc32c_generic raid1 raid0 md_mod hid_generic usbhid hid amdgpu amdxcp drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper drm_display_helper
sd_mod cec crct10dif_pclmul rc_core crc32_pclmul xhci_pci drm_ttm_helper crc32c_intel ttm ahci xhci_hcd drm_kms_helper libahci r8169 ghash_clmulni_intel libata sha512_ssse3
realtek nvme mdio_devres sha256_ssse3 drm usbcore scsi_mod sha1_ssse3 i2c_piix4 libphy video nvme_core i2c_smbus usb_common scsi_common crc16 wmi gpio_amdpt gpio_generic button
aesni_intel gf128mul crypto_simd cryptd
[   48.137148] CPU: 30 UID: 0 PID: 421 Comm: kworker/30:1 Not tainted 6.11.0-rc5 #3
[   48.137150] Hardware name: ASUS System XXXXXXXXXX
[   48.137151] Workqueue: cifsiod smb2_readv_worker [cifs]
[   48.137176] RIP: 0010:netfs_subreq_terminated+0x276/0x2d0 [netfs]
[   48.137182] Code: 66 ff ff ff 0f 1f 44 00 00 e9 5c ff ff ff 48 89 f1 0f b7 93 86 00 00 00 8b b5 ac 01 00 00 48 c7 c7 78 81 7a c2 e8 ba 68 2f da <0f> 0b 48 8b 43 70 31 d2 4c
8d ab 98 00 00 00 66 89 93 84 00 00 00
[   48.137183] RSP: 0018:ffffad8942637e58 EFLAGS: 00010282
[   48.137185] RAX: 0000000000000000 RBX: ffff9d09639a7200 RCX: 0000000000000027
[   48.137186] RDX: ffff9d107e721788 RSI: 0000000000000001 RDI: ffff9d107e721780
[   48.137187] RBP: ffff9d094bf38a00 R08: 0000000000000000 R09: 0000000000000003
[   48.137187] R10: ffffad8942637ce8 R11: ffff9d109de3cfe8 R12: 0000000000000001
[   48.137188] R13: ffff9d095fcf6000 R14: ffff9d09639a7208 R15: 0000000000000000
[   48.137189] FS:  0000000000000000(0000) GS:ffff9d107e700000(0000) knlGS:0000000000000000
[   48.137190] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.137191] CR2: 000055d1a3402760 CR3: 00000006b0222000 CR4: 0000000000750ef0
[   48.137192] PKRU: 55555554
[   48.137193] Call Trace:
[   48.137194]  <TASK>
[   48.137197]  ? __warn+0x80/0x120
[   48.137201]  ? netfs_subreq_terminated+0x276/0x2d0 [netfs]
[   48.137207]  ? report_bug+0x164/0x190
[   48.137210]  ? prb_read_valid+0x1b/0x30
[   48.137213]  ? handle_bug+0x41/0x70
[   48.137215]  ? exc_invalid_op+0x17/0x70
[   48.137216]  ? asm_exc_invalid_op+0x1a/0x20
[   48.137220]  ? netfs_subreq_terminated+0x276/0x2d0 [netfs]
[   48.137225]  ? netfs_subreq_terminated+0x276/0x2d0 [netfs]
[   48.137230]  process_one_work+0x179/0x390
[   48.137233]  worker_thread+0x249/0x350
[   48.137235]  ? __pfx_worker_thread+0x10/0x10
[   48.137237]  kthread+0xcf/0x100
[   48.137240]  ? __pfx_kthread+0x10/0x10
[   48.137242]  ret_from_fork+0x31/0x50
[   48.137244]  ? __pfx_kthread+0x10/0x10
[   48.137246]  ret_from_fork_asm+0x1a/0x30
[   48.137250]  </TASK>
[   48.137251] ---[ end trace 0000000000000000 ]---

