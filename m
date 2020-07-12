Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C8221CBDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 00:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGLW3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jul 2020 18:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGLW3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jul 2020 18:29:08 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707DDC061794;
        Sun, 12 Jul 2020 15:29:07 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q3so9604417ilt.8;
        Sun, 12 Jul 2020 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bc9H7wG06eBJ4TrlnRHHD81L3+Zw4OegZPi+FVCbxMw=;
        b=Iyiap90qj1tlDLk0l+D2PaQcFywnJtrAH9DWAGoiCO6vkk5M4+Y/s4ZPhIdZo9tH2J
         ymN6EEgMJIreMyjJ37xq0H40wgZqXy/eNBmUvY3wURlbBqmcEzr3LtxUspj/vyFK5r0Q
         cxjUiBMGhhP3tKl0QVFS5mbqTI78u7baPECL1bmEwZodQO34W/HCY46OpnOqLoJHulX5
         bsEkTt8ZdU9ySvOJ7t8+J5/BnggTmA9IXpjbswCffOdi5SHzbSfmffYX6TrGpOJuNhmM
         XGn5LXAY6C0ijyb+JOznL242gcn/wOOGsLPQX9sdRUYURfv0IbGJa0pI+caju+6HkH6R
         zmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bc9H7wG06eBJ4TrlnRHHD81L3+Zw4OegZPi+FVCbxMw=;
        b=ZeSG6x3kXQXF1kfmcAmLBB4QEwS8U6TQ46LOH27pFdHhQ2+zMSJ0+jci0qCYv80McZ
         fJapNxwNpjQ578OedJLc/D02MLXLRXlnsEW89gsVGE3tF27MPQPqNiE1Pd3aiQc7HhR1
         F4n0TSbeGtcAbuLd0thYauS84PRwLHe84NPaHFBinmVSbxtAd9oQ49Voio3qXFyb+p+E
         Za4zOe7PU2qeY5V8t20scIehWs0jPgvM7iPbJezXLmuZYNvLK4pTWT6erNXEkracp2CW
         0gOVn8/PF5uGKFWvcXR+IcNJNS0NOtYZAEulxq6YPepsR9ez0jljF9sso0wYD18GSlyy
         J4jw==
X-Gm-Message-State: AOAM531PofnoTZJ917pabN1GwYyz/pNzAKovAbyMvZiyh72XdDmn/Klt
        Efd4RHRLyPfIpfdHbvgwid305+HpgVVphKddaq/CbwPF1yU=
X-Google-Smtp-Source: ABdhPJxeD+4XJQVucbbixMTylYKcyKLRzWj7W/FbAtl1OJOaLpnkhJ9Waaqj55irfkkTkKn9NJ2fZg7qxo+AK+/DO4s=
X-Received: by 2002:a92:c5cf:: with SMTP id s15mr57641008ilt.36.1594592946128;
 Sun, 12 Jul 2020 15:29:06 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 13 Jul 2020 03:28:55 +0500
Message-ID: <CABXGCsPPoeja2WxWQ7yhX+3EF1gtCHfjdFjx1CwuAyJcSVzz1g@mail.gmail.com>
Subject: [5.8RC4][bugreport]WARNING: CPU: 28 PID: 211236 at
 fs/fuse/file.c:1684 tree_insert+0xaf/0xc0 [fuse]
To:     linux-fsdevel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks.
While testing 5.8 RCs I founded that kernel log flooded by the message
"WARNING: CPU: 28 PID: 211236 at fs/fuse/file.c:1684 tree
insert+0xaf/0xc0 [fuse]" when I start podman container.
In kernel 5.7 not has such a problem.

[92414.864536] ------------[ cut here ]------------
[92414.864648] WARNING: CPU: 28 PID: 211236 at fs/fuse/file.c:1684
tree_insert+0xaf/0xc0 [fuse]
[92414.864652] Modules linked in: snd_seq_dummy snd_hrtimer uinput
rfcomm xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp
nf_conntrack_tftp tun bridge stp llc nft_objref
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nf_tables nfnetlink ip6table_filter ip6_tables
iptable_filter cmac bnep sunrpc vfat fat snd_usb_audio snd_usbmidi_lib
snd_rawmidi hid_logitech_hidpp gspca_zc3xx gspca_main
videobuf2_vmalloc videobuf2_memops joydev videobuf2_v4l2
videobuf2_common mt76x2u mt76x2_common videodev mt76x02_usb mt76_usb
mt76x02_lib xpad mc mt76 hid_logitech_dj ff_memless
snd_hda_codec_realtek snd_hda_codec_generic iwlmvm ledtrig_audio
snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec
[92414.864697]  mac80211 snd_hda_core edac_mce_amd amd_energy
snd_hwdep btusb btrtl btbcm snd_seq kvm_amd libarc4 btintel
snd_seq_device bluetooth kvm snd_pcm iwlwifi eeepc_wmi asus_wmi
snd_timer ecdh_generic irqbypass ecc snd sparse_keymap rapl cfg80211
video wmi_bmof pcspkr soundcore sp5100_tco k10temp i2c_piix4 rfkill
acpi_cpufreq binfmt_misc ip_tables amdgpu iommu_v2 gpu_sched ttm
drm_kms_helper cec crct10dif_pclmul crc32_pclmul crc32c_intel drm igb
ghash_clmulni_intel ccp nvme dca xhci_pci nvme_core xhci_pci_renesas
i2c_algo_bit wmi pinctrl_amd fuse
[92414.864738] CPU: 28 PID: 211236 Comm: sed Not tainted
5.8.0-0.rc4.20200709git0bddd227f3dc.1.fc33.x86_64 #1
[92414.864742] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 1407 04/02/2020
[92414.864749] RIP: 0010:tree_insert+0xaf/0xc0 [fuse]
[92414.864753] Code: 80 c8 00 00 00 49 c7 80 d0 00 00 00 00 00 00 00
49 c7 80 d8 00 00 00 00 00 00 00 48 89 39 e9 78 35 5f d7 0f 0b eb a5
0f 0b c3 <0f> 0b e9 71 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
00 00
[92414.864757] RSP: 0018:ffffb9b08b66f970 EFLAGS: 00010246
[92414.864761] RAX: 000000000000001c RBX: ffffb9b08b66fac8 RCX: 8c6318c6318c6319
[92414.864765] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9beac944fce8
[92414.864768] RBP: ffffeef599772a80 R08: ffff9bee81360d00 R09: ffffffffffffffff
[92414.864772] R10: ffff9beac944fce8 R11: 0000000000000000 R12: ffffeef584fe7b80
[92414.864775] R13: ffff9beac944f800 R14: ffff9beac944fd98 R15: ffff9bee81360d00
[92414.864780] FS:  00007f98023da840(0000) GS:ffff9bf1bda00000(0000)
knlGS:0000000000000000
[92414.864783] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[92414.864787] CR2: 00007ffc5071f080 CR3: 0000000030a0c000 CR4: 00000000003406e0
[92414.864790] Call Trace:
[92414.864798]  fuse_writepages_fill+0x5cc/0x690 [fuse]
[92414.864810]  write_cache_pages+0x225/0x560
[92414.864819]  ? fuse_writepages+0xe0/0xe0 [fuse]
[92414.864828]  ? rcu_read_lock_sched_held+0x3f/0x80
[92414.864835]  ? trace_kmalloc+0xf2/0x120
[92414.864842]  ? __kmalloc+0x136/0x270
[92414.864848]  ? fuse_writepages+0x5e/0xe0 [fuse]
[92414.864857]  fuse_writepages+0x7d/0xe0 [fuse]
[92414.864867]  do_writepages+0x28/0xb0
[92414.864876]  __writeback_single_inode+0x60/0x6b0
[92414.864884]  writeback_single_inode+0xa7/0x140
[92414.864890]  write_inode_now+0x8b/0xb0
[92414.864904]  fuse_do_setattr+0x42f/0x770 [fuse]
[92414.864914]  ? _raw_spin_unlock+0x1f/0x30
[92414.864921]  ? fuse_do_getattr+0x149/0x2c0 [fuse]
[92414.864946]  fuse_setattr+0x99/0x140 [fuse]
[92414.864954]  notify_change+0x333/0x4a0
[92414.864964]  chown_common+0xec/0x190
[92414.864978]  ksys_fchown+0x6c/0xb0
[92414.864985]  __x64_sys_fchown+0x16/0x20
[92414.864990]  do_syscall_64+0x52/0xb0
[92414.864995]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[92414.865000] RIP: 0033:0x7f9801cc0cd7
[92414.865003] Code: Bad RIP value.
[92414.865007] RSP: 002b:00007ffc506abb18 EFLAGS: 00000206 ORIG_RAX:
000000000000005d
[92414.865011] RAX: ffffffffffffffda RBX: 00007ffc506abba0 RCX: 00007f9801cc0cd7
[92414.865014] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
[92414.865018] RBP: 0000000000000004 R08: 0000000001cb9e70 R09: 00007f98023da840
[92414.865021] R10: 00007ffc506ab5a0 R11: 0000000000000206 R12: 0000000000000003
[92414.865025] R13: 00007ffc506acde1 R14: 0000000000000000 R15: 0000000000000000
[92414.865040] irq event stamp: 7637
[92414.865045] hardirqs last  enabled at (7645): [<ffffffff9716f2a7>]
console_unlock+0x4b7/0x6c0
[92414.865049] hardirqs last disabled at (7652): [<ffffffff9716ee9d>]
console_unlock+0xad/0x6c0
[92414.865103] softirqs last  enabled at (7668): [<ffffffff98000377>]
__do_softirq+0x377/0x4a2
[92414.865108] softirqs last disabled at (7659): [<ffffffff97e010d2>]
asm_call_on_stack+0x12/0x20
[92414.865111] ---[ end trace b83826add3a6ed4f ]---

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/5.8.0-0.rc4.20200709git0bddd227f3dc.1.fc33.x86_64/kernel/fs/fuse/fuse.ko.debug
tree_insert+0xaf
tree_insert+0xaf/0xc0:
tree_insert at /usr/src/debug/kernel-20200709git0bddd227f3dc/linux-5.8.0-0.rc4.20200709git0bddd227f3dc.1.fc33.x86_64/fs/fuse/file.c:1684
(discriminator 1)

It looks like a problem in the kernel fuse driver.

--
Best Regards,
Mike Gavrilov.
