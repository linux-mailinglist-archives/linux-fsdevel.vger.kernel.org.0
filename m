Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B51B12A3F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 19:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLXSml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 13:42:41 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42565 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfLXSml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 13:42:41 -0500
Received: by mail-il1-f196.google.com with SMTP id t2so1752191ilq.9;
        Tue, 24 Dec 2019 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xqxV/PEE6bYn+cCesmKtOM6GWV6C4KHq+hOMvSljTzc=;
        b=q2FWP5jbXb4l8wJ2xicY2J7h/aSq3HehlsJpixKYXzZ1pre/HiUv4AcndWEvdzLQe7
         Rm8E7KFO1ViEwU0RY1xm0+i2H8n2iE4kZcmXPrto3/GTxFUE7vDtmtRr68Bv/fWo7dyz
         no0O2IYEgAh9L3ByrUZbFhDrEbakGxHMGNK5W9hhM7JFB/D3vHYzM4J3hLarP+m6Wm1Q
         0wGG5rlqZXOSkFd7MlfIrfeh8+KVmXzx/4aseZ9rWdIyn/pOT4RHft+AX2RHV/B964oi
         OrfuoxWc3noZx60K3qs3Nm+5XHWIoJiAr7LLi2SXo6qoRGhhfjhsbkPXo/2a+y6MV/KM
         Y/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xqxV/PEE6bYn+cCesmKtOM6GWV6C4KHq+hOMvSljTzc=;
        b=YARrDKtAs1hZGx8Axt5n6Ym44F1lswlg9Cj770uF7PHBTtLX6misLIxrUtF9wXr55R
         R5sCZWf63Vs4VVtbMUBm+ljhTBND2XBDepNR/95w8I/2bUvdAP08puKOWxVYN1RGbmkZ
         NRHOfopmjpIz3UnsLljH43VNuswaiUj+7OPKfKesqw31JMkoRVBxR7WeDQcRWR/FAFKg
         aNnREKaawLy32Mw/hKPAGoW23q7BcXGAjGL3PcJJpa0n0MX9zdj4JXgBWLTx2eImmGfe
         ZemUE9XdLpuFadc3UzaCZN7QRDRoPx2cs9JpkBDeNM5dcVlbP0BwucIiQTF/ls6YWoS3
         Gzyw==
X-Gm-Message-State: APjAAAUqKulK4CkpQcWAcM2DU0+7fCIb3B9JjKhx33Erm0+4tlVR1/BL
        c5ndwH+VamcPBfg7t0mWWdWlAKp40fiDixZ5Rvc=
X-Google-Smtp-Source: APXvYqxCl8BbmHS2gZi51NZwytSgoz7mR+/HtZCCjMYpIMy2TS2IXRLD+uV+Y6UyowdCw4zvlucZDkAsDlvfODhhWrU=
X-Received: by 2002:a92:9c48:: with SMTP id h69mr27921407ili.222.1577212960469;
 Tue, 24 Dec 2019 10:42:40 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Tue, 24 Dec 2019 10:42:32 -0800
Message-ID: <CACsaVZLy=Edbvg2oAcfYgHOMugvW5+Eu4F8jnjkfBBe31viNwQ@mail.gmail.com>
Subject: BUG: unable to handle page fault for address: ffff8cb1a7beb900
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc:     Linux-Kernal <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fuse-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This seems to be reproducible quite easily unfortunately on this box.
Using MergerFS with 5.4.6 and keep getting weird kernel bugs like
this. After the bug happens this results in the system being unable to
poweroff (just hangs forever on shutdown).

I was running on 5.4.1 prior and tried upgrading after seeing the
patch from Rubrik in 5.4.3 - below is from 5.4.6.

[ 3517.458859] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
[ 3517.458955] BUG: unable to handle page fault for address: ffff8cb1a7beb900
[ 3517.459044] #PF: supervisor instruction fetch in kernel mode
[ 3517.459130] #PF: error_code(0x0011) - permissions violation
[ 3517.459216] PGD 468e01067 P4D 468e01067 PUD 6cd929063 PMD 8000000727a001e3
[ 3517.459308] Oops: 0011 [#1] PREEMPT SMP NOPTI
[ 3517.459394] CPU: 3 PID: 4965 Comm: mergerfs Not tainted 5.4.6-gentoo #1
[ 3517.459481] Hardware name: Supermicro Super Server/A2SDi-8C-HLN4F,
BIOS 1.1c 06/25/2019
[ 3517.459575] RIP: 0010:0xffff8cb1a7beb900
[ 3517.459659] Code: ff ff d0 b8 be a7 b1 8c ff ff e0 b8 be a7 b1 8c
ff ff e0 b8 be a7 b1 8c ff ff 30 25 f8 6c b2 8c ff ff 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e0 2d 1a d7
b2 8c
[ 3517.459771] RSP: 0018:ffffa37381b87c88 EFLAGS: 00010286
[ 3517.459856] RAX: ffff8cb1a7beb900 RBX: ffff8cb2d5539088 RCX: 0000000000000001
[ 3517.459945] RDX: 0000000000000000 RSI: ffffa3738047bdc0 RDI: ffff8cb2d376ba00
[ 3517.460034] RBP: ffff8cb2d376ba00 R08: 0000000000000000 R09: ffffa37381b87c28
[ 3517.460123] R10: ffffa37381b87b8c R11: 0000000000000000 R12: ffff8cb2d5539098
[ 3517.460212] R13: ffff8cb1a7beb900 R14: ffffa37381b87d28 R15: ffff8cb2d7572cc0
[ 3517.460302] FS:  00007f9a51cf5700(0000) GS:ffff8cb2dfac0000(0000)
knlGS:0000000000000000
[ 3517.460838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3517.461147] CR2: ffff8cb1a7beb900 CR3: 0000000852c56000 CR4: 00000000003406e0
[ 3517.461457] Call Trace:
[ 3517.461774]  ? fuse_request_end+0xae/0x1c0 [fuse]
[ 3517.462088]  ? fuse_dev_do_write+0x2a0/0x3e0 [fuse]
[ 3517.462403]  ? fuse_dev_write+0x6e/0xa0 [fuse]
[ 3517.462715]  ? do_iter_readv_writev+0x150/0x1c0
[ 3517.463023]  ? do_iter_write+0x80/0x190
[ 3517.463329]  ? vfs_writev+0xa3/0x100
[ 3517.463639]  ? do_vfs_ioctl+0xa4/0x620
[ 3517.463946]  ? __fget+0x73/0xb0
[ 3517.464251]  ? do_writev+0x65/0x100
[ 3517.464559]  ? do_syscall_64+0x54/0x190
[ 3517.464866]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3517.465176] Modules linked in: nfsd auth_rpcgss nfs_acl tda18271
s5h1411 cfg80211 rfkill 8021q garp stp mrp llc xt_length xt_conntrack
ip6table_filter ip6_tables cachefiles x86_pkg_temp_thermal
nf_conntrack_ftp kvm_intel nf_conntrack nf_defrag_ipv4 kvm irqbypass
snd_pcm coretemp saa7164 snd_timer crct10dif_pclmul tveeprom bcache
snd crc32_pclmul crc64 dvb_core crc32c_intel soundcore
ghash_clmulni_intel pcspkr videodev mc i2c_ismt acpi_cpufreq xts
aesni_intel crypto_simd cryptd glue_helper crc32_generic cbc
sha256_generic libsha256 ixgb ixgbe tulip cxgb3 cxgb mdio cxgb4 vxge
bonding vxlan ip6_udp_tunnel udp_tunnel macvlan vmxnet3 tg3 sky2 r8169
pcnet32 mii igb dca i2c_algo_bit i2c_core e1000 bnx2 atl1c msdos fat
cramfs squashfs fuse xfs nfs lockd grace sunrpc fscache jfs reiserfs
btrfs zstd_decompress zstd_compress ext4 jbd2 ext2 mbcache linear
raid10 raid1 raid0 dm_zero dm_verity reed_solomon dm_thin_pool
dm_switch dm_snapshot dm_raid raid456 async_raid6_recov async_memcpy
async_pq
[ 3517.465251]  raid6_pq dm_mirror dm_region_hash dm_log_writes
dm_log_userspace dm_log dm_integrity async_xor async_tx xor dm_flakey
dm_era dm_delay dm_crypt dm_cache_smq dm_cache dm_persistent_data
libcrc32c dm_bufio dm_bio_prison dm_mod dax firewire_core crc_itu_t
sl811_hcd xhci_pci xhci_hcd usb_storage mpt3sas raid_class aic94xx
libsas lpfc nvmet_fc nvmet qla2xxx megaraid_sas megaraid_mbox
megaraid_mm aacraid sx8 hpsa 3w_9xxx 3w_xxxx 3w_sas mptsas
scsi_transport_sas mptfc scsi_transport_fc mptspi mptscsih mptbase imm
parport sym53c8xx initio arcmsr aic7xxx aic79xx scsi_transport_spi
sr_mod cdrom sg sd_mod pdc_adma sata_inic162x sata_mv ata_piix ahci
libahci sata_qstor sata_vsc sata_uli sata_sis sata_sx4 sata_nv
sata_via sata_svw sata_sil24 sata_sil sata_promise pata_via
pata_jmicron pata_marvell pata_sis pata_netcell pata_pdc202xx_old
pata_atiixp pata_amd pata_ali pata_it8213 pata_pcmcia pata_serverworks
pata_oldpiix pata_artop pata_it821x pata_hpt3x2n pata_hpt3x3
pata_hpt37x pata_hpt366
[ 3517.468482]  pata_cmd64x pata_sil680 pata_pdc2027x nvme_fc
nvme_rdma rdma_cm iw_cm ib_cm ib_core ipv6 crc_ccitt nf_defrag_ipv6
configfs nvme_fabrics virtio_net net_failover failover virtio_crypto
crypto_engine virtio_mmio virtio_pci virtio_balloon virtio_rng
virtio_console virtio_blk virtio_scsi virtio_ring virtio
[ 3517.472664] CR2: ffff8cb1a7beb900
[ 3517.472976] ---[ end trace 526b6506602bdb74 ]---
[ 3517.516624] RIP: 0010:0xffff8cb1a7beb900
[ 3517.516964] Code: ff ff d0 b8 be a7 b1 8c ff ff e0 b8 be a7 b1 8c
ff ff e0 b8 be a7 b1 8c ff ff 30 25 f8 6c b2 8c ff ff 00 00 00 00 00
00 00 00 <70> 2b 40 e7 ad 8c ff ff 60 89 84 b4 ff ff ff ff e0 2d 1a d7
b2 8c
[ 3517.517745] RSP: 0018:ffffa37381b87c88 EFLAGS: 00010286
[ 3517.518055] RAX: ffff8cb1a7beb900 RBX: ffff8cb2d5539088 RCX: 0000000000000001
[ 3517.518368] RDX: 0000000000000000 RSI: ffffa3738047bdc0 RDI: ffff8cb2d376ba00
[ 3517.518681] RBP: ffff8cb2d376ba00 R08: 0000000000000000 R09: ffffa37381b87c28
[ 3517.518994] R10: ffffa37381b87b8c R11: 0000000000000000 R12: ffff8cb2d5539098
[ 3517.519308] R13: ffff8cb1a7beb900 R14: ffffa37381b87d28 R15: ffff8cb2d7572cc0
[ 3517.519622] FS:  00007f9a51cf5700(0000) GS:ffff8cb2dfac0000(0000)
knlGS:0000000000000000
[ 3517.520159] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3517.520469] CR2: ffff8cb1a7beb900 CR3: 0000000852c56000 CR4: 00000000003406e0
