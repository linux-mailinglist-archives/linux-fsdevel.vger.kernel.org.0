Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0046713D88F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 12:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgAPLHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 06:07:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35767 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAPLHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:07:06 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so21315298iob.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 03:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VITAPFDDd79hMqanRWNrf77+lRP2uW414xXzMpS3FI=;
        b=fPi6pejC2KFCO2DuMNlZmaEHnRUUOSXm0xfWMmFjY5uooxVdSYNTu3FVF2O0HdgHgd
         i4oWenAk1fhMsJPm4z6zsWzbkm2GJQCgCWm92l1R9doik2Rq5QX0KF1OS1zcWJA9E38P
         MHpv/lJ6HTs8T7pi0VP5xNYQdvAMs4ML2oe48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VITAPFDDd79hMqanRWNrf77+lRP2uW414xXzMpS3FI=;
        b=g62qChWrsUxGjePiEmUPzIUh1nYLYuk8PFVaIZ9wEmfvtEgTPCDKyorHW7scK4FPFi
         hJUnSAbm2PoNUJ8eDzt0qbZ9UghuVgA0Fq2gpHbRnMSFJv4aWLO6CqCMfzBKb7/ZPbIp
         TDajyQibWTD0NC4xMWi2xbTcXhJoWCchdSN9uqRKpVWo7NTPGLiLGWb8ShBBzOXrOA1W
         Zv0usLo+xs5cazgxv6V/PVB78h1IWnefYPa4uuzw55c7w1Asqla7nfLMMfn4P02cXBvh
         TZG68dHXjJa3oW8NrAzTN7U7DUA9mSCZdZAvZq6+SeX8vt4PKXhnY0bod3ukw4wC+t4h
         Fk8Q==
X-Gm-Message-State: APjAAAUVjeAKOQxn+yaR4eMZaX+5NRvW6amPiiRlTkBziHRXRiRaut++
        8Ya5Aewmvny+Lz73dXfAFpzAF9OX0I3IHxVbxRMSaw==
X-Google-Smtp-Source: APXvYqyMn/AWRXzNu0akoUTXgUt3h/UjsnQYWrZuEj7/WQV7ptGYAcfkBFU2jbOhHWwI3GaeYvPPl0Lq4MJZSL+flAU=
X-Received: by 2002:a02:6a10:: with SMTP id l16mr27667700jac.77.1579172825083;
 Thu, 16 Jan 2020 03:07:05 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZLApLO=dNCU07ZjMx4qA8dv1=OA7n31uD9GzHkSFCm8oA@mail.gmail.com>
In-Reply-To: <CACsaVZLApLO=dNCU07ZjMx4qA8dv1=OA7n31uD9GzHkSFCm8oA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 16 Jan 2020 12:06:54 +0100
Message-ID: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
To:     Kyle Sanderson <kyle.leet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thanks for the report.

Is this readily reproducible?

Can you please do an "echo t > /proc/sysrq-trigger" after you see the
hang, and send the output.   Make sure you have enough dmesg buffer:

 - either add "log_buf_len=4M" to the kernel boot command
 - or recompile the kernel with CONFIG_LOG_BUF_SHIFT=22

Thanks,
Miklos


On Sun, Jan 5, 2020 at 2:15 AM Kyle Sanderson <kyle.leet@gmail.com> wrote:
>
> [400280.179731] BUG: unable to handle page fault for address: 0000000044000000
> [400280.179842] #PF: supervisor instruction fetch in kernel mode
> [400280.179938] #PF: error_code(0x0010) - not-present page
> [400280.180032] PGD 0 P4D 0
> [400280.180125] Oops: 0010 [#1] PREEMPT SMP NOPTI
> [400280.180221] CPU: 5 PID: 6894 Comm: mergerfs Not tainted 5.4.6-gentoo #1
> [400280.180318] Hardware name: Supermicro Super Server/A2SDi-8C-HLN4F,
> BIOS 1.1c 06/25/2019
> [400280.180424] RIP: 0010:0x44000000
> [400280.180520] Code: Bad RIP value.
> [400280.180610] RSP: 0018:ffffb155c1227c88 EFLAGS: 00010206
> [400280.180706] RAX: 0000000044000000 RBX: ffff88eb184b87f8 RCX:
> 0000000000000001
> [400280.180805] RDX: 0000000000000000 RSI: ffffb155c0857dc0 RDI:
> ffff88ed53bd5600
> [400280.180904] RBP: ffff88ed53bd5600 R08: 0000000000000000 R09:
> ffffb155c1227c28
> [400280.181003] R10: ffffb155c1227b8c R11: 0000000000000000 R12:
> ffff88eb184b8808
> [400280.181103] R13: 0000000044000000 R14: ffffb155c1227d28 R15:
> ffff88ed53b45e80
> [400280.181657] FS:  00007ff8076fc700(0000) GS:ffff88ed5fb40000(0000)
> knlGS:0000000000000000
> [400280.182211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [400280.182532] CR2: 0000000043ffffd6 CR3: 000000084812a000 CR4:
> 00000000003406e0
> [400280.183084] Call Trace:
> [400280.183419]  ? fuse_request_end+0xae/0x1c0 [fuse]
> [400280.183751]  ? fuse_dev_do_write+0x2a0/0x3e0 [fuse]
> [400280.184084]  ? fuse_dev_write+0x6e/0xa0 [fuse]
> [400280.184413]  ? do_iter_readv_writev+0x150/0x1c0
> [400280.184736]  ? do_iter_write+0x80/0x190
> [400280.185056]  ? vfs_writev+0xa3/0x100
> [400280.185383]  ? __fget+0x73/0xb0
> [400280.185699]  ? do_writev+0x65/0x100
> [400280.186020]  ? do_syscall_64+0x54/0x190
> [400280.186342]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [400280.186668] Modules linked in: nfsd auth_rpcgss nfs_acl tda18271
> s5h1411 cfg80211 rfkill 8021q garp stp mrp llc xt_length xt_conntrack
> ip6table_filter ip6_tables cachefiles x86_pkg_temp_thermal
> nf_conntrack_ftp kvm_intel nf_conntrack nf_defrag_ipv4 kvm irqbypass
> snd_pcm coretemp crct10dif_pclmul saa7164 snd_timer crc32_pclmul
> tveeprom snd dvb_core crc32c_intel soundcore pcspkr
> ghash_clmulni_intel videodev mc i2c_ismt acpi_cpufreq xts aesni_intel
> crypto_simd cryptd glue_helper crc32_generic cbc sha256_generic
> libsha256 ixgb ixgbe tulip cxgb3 cxgb mdio cxgb4 vxge bonding vxlan
> ip6_udp_tunnel udp_tunnel macvlan vmxnet3 tg3 sky2 r8169 pcnet32 mii
> igb dca i2c_algo_bit i2c_core e1000 bnx2 atl1c msdos fat cramfs
> squashfs fuse xfs nfs lockd grace sunrpc fscache jfs reiserfs btrfs
> zstd_decompress zstd_compress ext4 jbd2 ext2 mbcache linear raid10
> raid1 raid0 dm_zero dm_verity reed_solomon dm_thin_pool dm_switch
> dm_snapshot dm_raid raid456 async_raid6_recov async_memcpy async_pq
> raid6_pq dm_mirror
> [400280.186787]  dm_region_hash dm_log_writes dm_log_userspace dm_log
> dm_integrity async_xor async_tx xor dm_flakey dm_era dm_delay dm_crypt
> dm_cache_smq dm_cache dm_persistent_data libcrc32c dm_bufio
> dm_bio_prison dm_mod dax firewire_core crc_itu_t sl811_hcd xhci_pci
> xhci_hcd usb_storage mpt3sas raid_class aic94xx libsas lpfc nvmet_fc
> nvmet qla2xxx megaraid_sas megaraid_mbox megaraid_mm aacraid sx8 hpsa
> 3w_9xxx 3w_xxxx 3w_sas mptsas scsi_transport_sas mptfc
> scsi_transport_fc mptspi mptscsih mptbase imm parport sym53c8xx initio
> arcmsr aic7xxx aic79xx scsi_transport_spi sr_mod cdrom sg sd_mod
> pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor
> sata_vsc sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw
> sata_sil24 sata_sil sata_promise pata_via pata_jmicron pata_marvell
> pata_sis pata_netcell pata_pdc202xx_old pata_atiixp pata_amd pata_ali
> pata_it8213 pata_pcmcia pata_serverworks pata_oldpiix pata_artop
> pata_it821x pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366
> pata_cmd64x
> [400280.190120]  pata_sil680 pata_pdc2027x nvme_fc nvme_rdma rdma_cm
> iw_cm ib_cm ib_core ipv6 crc_ccitt nf_defrag_ipv6 configfs
> nvme_fabrics virtio_net net_failover failover virtio_crypto
> crypto_engine virtio_mmio virtio_pci virtio_balloon virtio_rng
> virtio_console virtio_blk virtio_scsi virtio_ring virtio
> [400280.194465] CR2: 0000000044000000
> [400280.194787] ---[ end trace 74cb513785034f62 ]---
> [400280.241518] RIP: 0010:0x44000000
> [400280.241864] Code: Bad RIP value.
> [400280.242181] RSP: 0018:ffffb155c1227c88 EFLAGS: 00010206
> [400280.242503] RAX: 0000000044000000 RBX: ffff88eb184b87f8 RCX:
> 0000000000000001
> [400280.243055] RDX: 0000000000000000 RSI: ffffb155c0857dc0 RDI:
> ffff88ed53bd5600
> [400280.243607] RBP: ffff88ed53bd5600 R08: 0000000000000000 R09:
> ffffb155c1227c28
> [400280.244158] R10: ffffb155c1227b8c R11: 0000000000000000 R12:
> ffff88eb184b8808
> [400280.244707] R13: 0000000044000000 R14: ffffb155c1227d28 R15:
> ffff88ed53b45e80
> [400280.245260] FS:  00007ff8076fc700(0000) GS:ffff88ed5fb40000(0000)
> knlGS:0000000000000000
> [400280.245813] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [400280.246134] CR2: 0000000043ffffd6 CR3: 000000084812a000 CR4:
> 00000000003406e0
> [444999.511865] potentially unexpected fatal signal 6.
> [444999.512234] CPU: 2 PID: 4341 Comm: rtorrent scgi Tainted: G      D
>           5.4.6-gentoo #1
> [444999.512783] Hardware name: Supermicro Super Server/A2SDi-8C-HLN4F,
> BIOS 1.1c 06/25/2019
> [444999.513329] RIP: 0033:0x7f6ce5da5ffb
> [444999.513635] Code: da b8 ea 00 00 00 0f 05 48 3d 00 f0 ff ff 77 3f
> 41 89 c0 41 ba 08 00 00 00 31 d2 4c 89 ce bf 02 00 00 00 b8 0e 00 00
> 00 0f 05 <48> 8b 8c 24 08 01 00 00 64 48 33 0c 25 28 00 00 00 44 89 c0
> 75 1d
> [444999.514421] RSP: 002b:00007f6cda9b9dc0 EFLAGS: 00000246 ORIG_RAX:
> 000000000000000e
> [444999.514424] RAX: 0000000000000000 RBX: 0000000000000006 RCX:
> 00007f6ce5da5ffb
> [444999.514426] RDX: 0000000000000000 RSI: 00007f6cda9b9dc0 RDI:
> 0000000000000002
> [444999.514427] RBP: 00007f6cd40020d0 R08: 0000000000000000 R09:
> 00007f6cda9b9dc0
> [444999.514428] R10: 0000000000000008 R11: 0000000000000246 R12:
> 00007f6cd46d7cb0
> [444999.514430] R13: 00007f6cda9ba160 R14: 0000000000000002 R15:
> 0000000000000000
> [444999.514431] FS:  00007f6cda9bb700 GS:  0000000000000000
> [461505.766196] saa7164 0000:02:00.0: DVB: adapter 1 frontend 0
> frequency 0 out of range (54000000..858000000)
> [548849.079581] saa7164 0000:02:00.0: DVB: adapter 1 frontend 0
> frequency 0 out of range (54000000..858000000)
> [634641.506417] saa7164 0000:02:00.0: DVB: adapter 0 frontend 0
> frequency 0 out of range (54000000..858000000)
> [696992.559904] potentially unexpected fatal signal 6.
> [696992.560225] CPU: 5 PID: 17827 Comm: rtorrent scgi Tainted: G
> D           5.4.6-gentoo #1
> [696992.567610] Hardware name: Supermicro Super Server/A2SDi-8C-HLN4F,
> BIOS 1.1c 06/25/2019
> [696992.568172] RIP: 0033:0x7febaf26cffb
> [696992.568478] Code: da b8 ea 00 00 00 0f 05 48 3d 00 f0 ff ff 77 3f
> 41 89 c0 41 ba 08 00 00 00 31 d2 4c 89 ce bf 02 00 00 00 b8 0e 00 00
> 00 0f 05 <48> 8b 8c 24 08 01 00 00 64 48 33 0c 25 28 00 00 00 44 89 c0
> 75 1d
> [696992.569259] RSP: 002b:00007feba38d8dc0 EFLAGS: 00000246 ORIG_RAX:
> 000000000000000e
> [696992.569262] RAX: 0000000000000000 RBX: 0000000000000006 RCX:
> 00007febaf26cffb
> [696992.569263] RDX: 0000000000000000 RSI: 00007feba38d8dc0 RDI:
> 0000000000000002
> [696992.569264] RBP: 000055db261423f0 R08: 0000000000000000 R09:
> 00007feba38d8dc0
> [696992.569265] R10: 0000000000000008 R11: 0000000000000246 R12:
> 000055db5c16fc90
> [696992.569266] R13: 00007feba38d9160 R14: 0000000000000002 R15:
> 0000000000000000
> [696992.569267] FS:  00007feba38da700 GS:  0000000000000000
> [721144.741527] saa7164 0000:02:00.0: DVB: adapter 0 frontend 0
> frequency 0 out of range (54000000..858000000)
> [727177.875112] BUG: kernel NULL pointer dereference, address: 0000000000000005
> [727177.875447] #PF: supervisor instruction fetch in kernel mode
> [727177.875767] #PF: error_code(0x0010) - not-present page
> [727177.876085] PGD 0 P4D 0
> [727177.876401] Oops: 0010 [#2] PREEMPT SMP NOPTI
> [727177.876721] CPU: 6 PID: 6919 Comm: mergerfs Tainted: G      D
>      5.4.6-gentoo #1
> [727177.877271] Hardware name: Supermicro Super Server/A2SDi-8C-HLN4F,
> BIOS 1.1c 06/25/2019
> [727177.877824] RIP: 0010:0x5
> [727177.878142] Code: Bad RIP value.
> [727177.878456] RSP: 0018:ffffb155c12cfc88 EFLAGS: 00010206
> [727177.878776] RAX: 0000000000000005 RBX: ffff88ed52fbdaa0 RCX:
> 0000000000000001
> [727177.879324] RDX: 0000000000000000 RSI: ffffb155c74e3d98 RDI:
> ffff88ed4a4e6600
> [727177.879871] RBP: ffff88ed4a4e6600 R08: 0000000000000000 R09:
> ffffb155c12cfc28
> [727177.880419] R10: ffffb155c12cfb8c R11: 0000000000000000 R12:
> ffff88ed52fbdab0
> [727177.880967] R13: 0000000000000005 R14: ffffb155c12cfd28 R15:
> ffff88ed539ee980
> [727177.881516] FS:  00007f45f3d17700(0000) GS:ffff88ed5fb80000(0000)
> knlGS:0000000000000000
> [727177.882066] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [727177.882386] CR2: ffffffffffffffdb CR3: 000000084838a000 CR4:
> 00000000003406e0
> [727177.882933] Call Trace:
> [727177.883266]  ? fuse_request_end+0xae/0x1c0 [fuse]
> [727177.883597]  ? fuse_dev_do_write+0x2a0/0x3e0 [fuse]
> [727177.883927]  ? fuse_dev_write+0x6e/0xa0 [fuse]
> [727177.884255]  ? do_iter_readv_writev+0x150/0x1c0
> [727177.884575]  ? do_iter_write+0x80/0x190
> [727177.884893]  ? vfs_writev+0xa3/0x100
> [727177.885209]  ? __switch_to+0x21/0x3f0
> [727177.885530]  ? __call_rcu+0xc3/0x190
> [727177.885848]  ? get_max_files+0x10/0x10
> [727177.886169]  ? __fget+0x73/0xb0
> [727177.886485]  ? do_writev+0x65/0x100
> [727177.886803]  ? do_syscall_64+0x54/0x190
> [727177.887122]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [727177.887446] Modules linked in: nfsd auth_rpcgss nfs_acl tda18271
> s5h1411 cfg80211 rfkill 8021q garp stp mrp llc xt_length xt_conntrack
> ip6table_filter ip6_tables cachefiles x86_pkg_temp_thermal
> nf_conntrack_ftp kvm_intel nf_conntrack nf_defrag_ipv4 kvm irqbypass
> snd_pcm coretemp crct10dif_pclmul saa7164 snd_timer crc32_pclmul
> tveeprom snd dvb_core crc32c_intel soundcore pcspkr
> ghash_clmulni_intel videodev mc i2c_ismt acpi_cpufreq xts aesni_intel
> crypto_simd cryptd glue_helper crc32_generic cbc sha256_generic
> libsha256 ixgb ixgbe tulip cxgb3 cxgb mdio cxgb4 vxge bonding vxlan
> ip6_udp_tunnel udp_tunnel macvlan vmxnet3 tg3 sky2 r8169 pcnet32 mii
> igb dca i2c_algo_bit i2c_core e1000 bnx2 atl1c msdos fat cramfs
> squashfs fuse xfs nfs lockd grace sunrpc fscache jfs reiserfs btrfs
> zstd_decompress zstd_compress ext4 jbd2 ext2 mbcache linear raid10
> raid1 raid0 dm_zero dm_verity reed_solomon dm_thin_pool dm_switch
> dm_snapshot dm_raid raid456 async_raid6_recov async_memcpy async_pq
> raid6_pq dm_mirror
> [727177.887564]  dm_region_hash dm_log_writes dm_log_userspace dm_log
> dm_integrity async_xor async_tx xor dm_flakey dm_era dm_delay dm_crypt
> dm_cache_smq dm_cache dm_persistent_data libcrc32c dm_bufio
> dm_bio_prison dm_mod dax firewire_core crc_itu_t sl811_hcd xhci_pci
> xhci_hcd usb_storage mpt3sas raid_class aic94xx libsas lpfc nvmet_fc
> nvmet qla2xxx megaraid_sas megaraid_mbox megaraid_mm aacraid sx8 hpsa
> 3w_9xxx 3w_xxxx 3w_sas mptsas scsi_transport_sas mptfc
> scsi_transport_fc mptspi mptscsih mptbase imm parport sym53c8xx initio
> arcmsr aic7xxx aic79xx scsi_transport_spi sr_mod cdrom sg sd_mod
> pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor
> sata_vsc sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw
> sata_sil24 sata_sil sata_promise pata_via pata_jmicron pata_marvell
> pata_sis pata_netcell pata_pdc202xx_old pata_atiixp pata_amd pata_ali
> pata_it8213 pata_pcmcia pata_serverworks pata_oldpiix pata_artop
> pata_it821x pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366
> pata_cmd64x
> [727177.890877]  pata_sil680 pata_pdc2027x nvme_fc nvme_rdma rdma_cm
> iw_cm ib_cm ib_core ipv6 crc_ccitt nf_defrag_ipv6 configfs
> nvme_fabrics virtio_net net_failover failover virtio_crypto
> crypto_engine virtio_mmio virtio_pci virtio_balloon virtio_rng
> virtio_console virtio_blk virtio_scsi virtio_ring virtio
> [727177.895163] CR2: 0000000000000005
> [727177.895480] ---[ end trace 74cb513785034f63 ]---
> [727178.401799] RIP: 0010:0x44000000
> [727178.402142] Code: Bad RIP value.
> [727178.402453] RSP: 0018:ffffb155c1227c88 EFLAGS: 00010206
> [727178.402769] RAX: 0000000044000000 RBX: ffff88eb184b87f8 RCX:
> 0000000000000001
> [727178.403312] RDX: 0000000000000000 RSI: ffffb155c0857dc0 RDI:
> ffff88ed53bd5600
> [727178.403854] RBP: ffff88ed53bd5600 R08: 0000000000000000 R09:
> ffffb155c1227c28
> [727178.404395] R10: ffffb155c1227b8c R11: 0000000000000000 R12:
> ffff88eb184b8808
> [727178.404938] R13: 0000000044000000 R14: ffffb155c1227d28 R15:
> ffff88ed53b45e80
> [727178.405482] FS:  00007f45f3d17700(0000) GS:ffff88ed5fb80000(0000)
> knlGS:0000000000000000
> [727178.406027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [727178.406343] CR2: 0000000043ffffd6 CR3: 000000084838a000 CR4:
> 00000000003406e0
> [743393.910213] BUG: kernel NULL pointer dereference, address: 0000000000000005
> [743393.910548] #PF: supervisor instruction fetch in kernel mode
> [743393.910868] #PF: error_code(0x0010) - not-present page
> [743393.911187] PGD 0 P4D 0
> [743393.911503] Oops: 0010 [#3] PREEMPT SMP NOPTI
> [743393.911823] CPU: 7 PID: 6921 Comm: mergerfs Tainted: G      D
>      5.4.6-gentoo #1
> [743393.912372] Hardware name: Supermicro Super Server/A2SDi-8C-HLN4F,
> BIOS 1.1c 06/25/2019
> [743393.912925] RIP: 0010:0x5
> [743393.913243] Code: Bad RIP value.
> [743393.913558] RSP: 0018:ffffb155c12dfc88 EFLAGS: 00010206
> [743393.913878] RAX: 0000000000000005 RBX: ffff88ed58471660 RCX:
> 0000000000000001
> [743393.914426] RDX: 0000000000000000 RSI: ffffb155c74e3d98 RDI:
> ffff88ed4a4e6600
> [743393.914973] RBP: ffff88ed4a4e6600 R08: 0000000000000000 R09:
> ffffb155c12dfc28
> [743393.915521] R10: ffffb155c12dfb8c R11: 0000000000000000 R12:
> ffff88ed58471670
> [743393.916068] R13: 0000000000000005 R14: ffffb155c12dfd28 R15:
> ffff88ed539ee980
> [743393.916617] FS:  00007f45f2b11700(0000) GS:ffff88ed5fbc0000(0000)
> knlGS:0000000000000000
> [743393.917168] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [743393.917487] CR2: ffffffffffffffdb CR3: 000000084838a000 CR4:
> 00000000003406e0
> [743393.918034] Call Trace:
> [743393.918366]  ? fuse_request_end+0xae/0x1c0 [fuse]
> [743393.918696]  ? fuse_dev_do_write+0x2a0/0x3e0 [fuse]
> [743393.919027]  ? fuse_dev_write+0x6e/0xa0 [fuse]
> [743393.919354]  ? do_iter_readv_writev+0x150/0x1c0
> [743393.919675]  ? do_iter_write+0x80/0x190
> [743393.919992]  ? vfs_writev+0xa3/0x100
> [743393.920309]  ? preempt_count_sub+0x5/0x90
> [743393.920626]  ? _raw_spin_unlock+0x12/0x30
> [743393.920948]  ? __call_rcu+0xc3/0x190
> [743393.921265]  ? get_max_files+0x10/0x10
> [743393.921584]  ? __fget+0x73/0xb0
> [743393.921901]  ? do_writev+0x65/0x100
> [743393.922220]  ? do_syscall_64+0x54/0x190
> [743393.922537]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [743393.922861] Modules linked in: nfsd auth_rpcgss nfs_acl tda18271
> s5h1411 cfg80211 rfkill 8021q garp stp mrp llc xt_length xt_conntrack
> ip6table_filter ip6_tables cachefiles x86_pkg_temp_thermal
> nf_conntrack_ftp kvm_intel nf_conntrack nf_defrag_ipv4 kvm irqbypass
> snd_pcm coretemp crct10dif_pclmul saa7164 snd_timer crc32_pclmul
> tveeprom snd dvb_core crc32c_intel soundcore pcspkr
> ghash_clmulni_intel videodev mc i2c_ismt acpi_cpufreq xts aesni_intel
> crypto_simd cryptd glue_helper crc32_generic cbc sha256_generic
> libsha256 ixgb ixgbe tulip cxgb3 cxgb mdio cxgb4 vxge bonding vxlan
> ip6_udp_tunnel udp_tunnel macvlan vmxnet3 tg3 sky2 r8169 pcnet32 mii
> igb dca i2c_algo_bit i2c_core e1000 bnx2 atl1c msdos fat cramfs
> squashfs fuse xfs nfs lockd grace sunrpc fscache jfs reiserfs btrfs
> zstd_decompress zstd_compress ext4 jbd2 ext2 mbcache linear raid10
> raid1 raid0 dm_zero dm_verity reed_solomon dm_thin_pool dm_switch
> dm_snapshot dm_raid raid456 async_raid6_recov async_memcpy async_pq
> raid6_pq dm_mirror
> [743393.922978]  dm_region_hash dm_log_writes dm_log_userspace dm_log
> dm_integrity async_xor async_tx xor dm_flakey dm_era dm_delay dm_crypt
> dm_cache_smq dm_cache dm_persistent_data libcrc32c dm_bufio
> dm_bio_prison dm_mod dax firewire_core crc_itu_t sl811_hcd xhci_pci
> xhci_hcd usb_storage mpt3sas raid_class aic94xx libsas lpfc nvmet_fc
> nvmet qla2xxx megaraid_sas megaraid_mbox megaraid_mm aacraid sx8 hpsa
> 3w_9xxx 3w_xxxx 3w_sas mptsas scsi_transport_sas mptfc
> scsi_transport_fc mptspi mptscsih mptbase imm parport sym53c8xx initio
> arcmsr aic7xxx aic79xx scsi_transport_spi sr_mod cdrom sg sd_mod
> pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor
> sata_vsc sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw
> sata_sil24 sata_sil sata_promise pata_via pata_jmicron pata_marvell
> pata_sis pata_netcell pata_pdc202xx_old pata_atiixp pata_amd pata_ali
> pata_it8213 pata_pcmcia pata_serverworks pata_oldpiix pata_artop
> pata_it821x pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366
> pata_cmd64x
> [743393.926289]  pata_sil680 pata_pdc2027x nvme_fc nvme_rdma rdma_cm
> iw_cm ib_cm ib_core ipv6 crc_ccitt nf_defrag_ipv6 configfs
> nvme_fabrics virtio_net net_failover failover virtio_crypto
> crypto_engine virtio_mmio virtio_pci virtio_balloon virtio_rng
> virtio_console virtio_blk virtio_scsi virtio_ring virtio
> [743393.937567] CR2: 0000000000000005
> [743393.937884] ---[ end trace 74cb513785034f64 ]---
> [743393.991952] RIP: 0010:0x44000000
> [743393.992275] Code: Bad RIP value.
> [743393.992588] RSP: 0018:ffffb155c1227c88 EFLAGS: 00010206
> [743393.992907] RAX: 0000000044000000 RBX: ffff88eb184b87f8 RCX:
> 0000000000000001
> [743393.993455] RDX: 0000000000000000 RSI: ffffb155c0857dc0 RDI:
> ffff88ed53bd5600
> [743393.994001] RBP: ffff88ed53bd5600 R08: 0000000000000000 R09:
> ffffb155c1227c28
> [743393.994549] R10: ffffb155c1227b8c R11: 0000000000000000 R12:
> ffff88eb184b8808
> [743393.995097] R13: 0000000044000000 R14: ffffb155c1227d28 R15:
> ffff88ed53b45e80
> [743393.995646] FS:  00007f45f2b11700(0000) GS:ffff88ed5fbc0000(0000)
> knlGS:0000000000000000
> [743393.996196] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [743393.996515] CR2: 0000000043ffffd6 CR3: 000000084838a000 CR4:
> 00000000003406e0
