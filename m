Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E75B54E273
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376838AbiFPNtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiFPNto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:49:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C125E9E;
        Thu, 16 Jun 2022 06:49:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g4so1953540wrh.11;
        Thu, 16 Jun 2022 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEQqsl9pwM+zJoYyACiVdckCPvOuDOSk6b/+a8FS2rc=;
        b=AZxNyoy3FQbS1ZUEYTph4NyyCXT4+I2IjnMpODPR8nRlZMQHqwVCafKDuqERkbtN3N
         U8QK7GSjXe7srjUYwMNarytnQ+xgwBEpdkUS489AMFdMPiwnNTT41Dx1g3V/i7GkOQBO
         NfCWtOxsQYXPqMA3U0mzeybCcTWZoC+h8gbkvaJ4brg/KgksoPFjwGoM5DmLlbu1g7eN
         d6EtFGzh0XgUb3OYG73GlewXphYkdWrNHAMV1PgXDB6DHsT8H9cCFHNnZZzstmi1ISup
         RltZa8VdPB82+PEi3ytTgiktvu2njs2IVQ6n0yfTvXblnJYjxzu40l8iOkWDHhi7iAi+
         3C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEQqsl9pwM+zJoYyACiVdckCPvOuDOSk6b/+a8FS2rc=;
        b=vPMe3qxxIs+/0PCt5vjGbMkLj6WO3INk5rt8+UL6qox8xHBKwOMoEO6kkldC/jlBgd
         DsiG/dzTH1SOuQxIxmS5ZR1m6MZHXKPkRz+DhmzJ9ajnBRac7yqaqCGZuPnmzL4FzK8S
         XB7nVQqd3kFTFei7XtJoiihOrlFcjpnLxAOAlQBU6gOhAK5DRaeYPGGCOewjtiLivQGX
         bIJ4FFVYP+K04QX8VixiWFEdSaEwYBT/26xDSIjC4R2L8YROtOxiWfVFTVYKxhw4Qp/7
         IrUbU7wAG5ZeAvZkwNOvBGhiU07c9AbJWIWukYck4HZ5tMY1gAKi2hgt+wjEq6+cY1iX
         PwXg==
X-Gm-Message-State: AJIora93zaYT0u9o8x3bMntzk+0k9cYiinwG/oNyMOXaBRHsirVUpbtq
        +xUDSuIaYgnu2JuyMDGrPcmKDVP5+g3qSDvX9Qs=
X-Google-Smtp-Source: AGRyM1vTSUiiEPOalh+elr7JOMsFRvOHqkSbQwRRfgdssjXN3MeSbPUJ1kvErQFaVgxVDCJGxXrG3Me6ejdw/ugny+M=
X-Received: by 2002:a5d:62c7:0:b0:216:fa41:2f81 with SMTP id
 o7-20020a5d62c7000000b00216fa412f81mr4827641wrv.249.1655387380151; Thu, 16
 Jun 2022 06:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <CAPt2mGNjWXad6e7nSUTu=0ez1qU1wBNegrntgHKm5hOeBs5gQA@mail.gmail.com> <165534094600.26404.4349155093299535793@noble.neil.brown.name>
In-Reply-To: <165534094600.26404.4349155093299535793@noble.neil.brown.name>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 16 Jun 2022 09:49:23 -0400
Message-ID: <CAFX2JfkhVNPM5-3dO+We8gbO617Cqj07OmaJ4HDvgPzU+BE+xA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] Allow concurrent directory updates.
To:     NeilBrown <neilb@suse.de>
Cc:     Daire Byrne <daire@dneg.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Neil,

On Wed, Jun 15, 2022 at 9:23 PM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 15 Jun 2022, Daire Byrne wrote:
> ...
> > With the patch, the aggregate increases to 15 creates/s for 10 clients
> > which again matches the results of a single patched client. Not quite
> > a x10 increase but a healthy improvement nonetheless.
>
> Great!
>
> >
> > However, it is at this point that I started to experience some
> > stability issues with the re-export server that are not present with
> > the vanilla unpatched v5.19-rc2 kernel. In particular the knfsd
> > threads start to lock up with stack traces like this:
> >
> > [ 1234.460696] INFO: task nfsd:5514 blocked for more than 123 seconds.
> > [ 1234.461481]       Tainted: G        W   E     5.19.0-1.dneg.x86_64 #1
> > [ 1234.462289] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [ 1234.463227] task:nfsd            state:D stack:    0 pid: 5514
> > ppid:     2 flags:0x00004000
> > [ 1234.464212] Call Trace:
> > [ 1234.464677]  <TASK>
> > [ 1234.465104]  __schedule+0x2a9/0x8a0
> > [ 1234.465663]  schedule+0x55/0xc0
> > [ 1234.466183]  ? nfs_lookup_revalidate_dentry+0x3a0/0x3a0 [nfs]
> > [ 1234.466995]  __nfs_lookup_revalidate+0xdf/0x120 [nfs]
>
> I can see the cause of this - I forget a wakeup.  This patch should fix
> it, though I hope to find a better solution.

I've applied as far as the NFS client patch plus the extra fix and I'm
seeing this stack trace on my client when I try to run cthon tests (I
was seeing it without the extra change as well):

anna@gouda ~ % virsh console client
Connected to domain 'client'
Escape character is ^] (Ctrl + ])
[  148.977712] BUG: unable to handle page fault for address: ffffa56a03e2ff70
[  148.978892] #PF: supervisor read access in kernel mode
[  148.979504] #PF: error_code(0x0000) - not-present page
[  148.980071] PGD 100000067 P4D 100000067 PUD 1001bb067 PMD 103164067 PTE 0
[  148.980859] Oops: 0000 [#1] PREEMPT SMP PTI
[  148.981323] CPU: 2 PID: 683 Comm: test7 Tainted: G        W
5.19.0-rc1-g3de25d30cb97-dirty #33479
5f05aa11df373b898aeb9103b7a17e0ee3946022
[  148.982824] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 0.0.0 02/06/2015
[  148.984016] RIP: 0010:d_alloc_parallel+0x1ad/0x5a0
[  148.984609] Code: 48 c7 c2 ff ff ff ff 89 c1 48 d3 e2 48 f7 d2 4d
31 c1 49 85 d1 0f 84 e2 00 00 00 66 90 4d 8b 6d 00 4d 85 ed 0f 84 3e
03 00 00 <45> 39 95 70 ff ff ff 75 ea 4d 39 a5 68 ff ff ff 75 e1 4d 8d
b5 50
[  148.986724] RSP: 0018:ffffa56a03e1bc50 EFLAGS: 00010286
[  148.987302] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9101b9400000
[  148.988084] RDX: 00000006ebc26d0c RSI: ffff9100c30b9020 RDI: ffff9100cb523480
[  148.988978] RBP: 00000000000009fc R08: 00000000000000c0 R09: ffff9100cb76d180
[  148.989752] R10: 00000000ebc26d0c R11: ffffffff846e8750 R12: ffff9100cb523480
[  148.990891] R13: ffffa56a03e30000 R14: ffff9100cb5234d8 R15: ffffa56a03e1bdc8
[  148.991741] FS:  00007f0c00660540(0000) GS:ffff9101b9d00000(0000)
knlGS:0000000000000000
[  148.992995] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  148.993686] CR2: ffffa56a03e2ff70 CR3: 000000010eaa2004 CR4: 0000000000370ee0
[  148.994494] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  148.995638] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  148.996462] Call Trace:
[  148.996752]  <TASK>
[  148.997036]  path_openat+0x290/0xd80
[  148.997472]  do_filp_open+0xbe/0x160
[  148.998136]  do_sys_openat2+0x8e/0x160
[  148.998609]  __x64_sys_creat+0x47/0x70
[  148.999057]  do_syscall_64+0x31/0x50
[  148.999479]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  149.000040] RIP: 0033:0x7f0c00502487
[  149.000444] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00
00 00 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 55 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 74 24 0c 48 89 3c
24 e8
[  149.002576] RSP: 002b:00007ffc01181a98 EFLAGS: 00000246 ORIG_RAX:
0000000000000055
[  149.003610] RAX: ffffffffffffffda RBX: 00007ffc01184d28 RCX: 00007f0c00502487
[  149.004511] RDX: 0000000000000000 RSI: 00000000000001b6 RDI: 00007ffc01181ae0
[  149.005351] RBP: 00007ffc01182af0 R08: 0000000000000000 R09: 0000000000000064
[  149.006160] R10: 00007f0c00406c68 R11: 0000000000000246 R12: 0000000000000000
[  149.006939] R13: 00007ffc01184d40 R14: 0000000000000000 R15: 00007f0c0078b000
[  149.007882]  </TASK>
[  149.008135] Modules linked in: cbc cts rpcsec_gss_krb5 nfsv4 nfs
fscache netfs rpcrdma rdma_cm iw_cm ib_cm ib_core cfg80211 rfkill
8021q garp stp mrp llc intel_rapl_msr intel_rapl_common kvm_intel kvm
snd_hda_codec_generic irqbypass crct10dif_pclmul crc32_pclmul
snd_hda_intel ghash_clmulni_intel iTCO_wdt joydev snd_intel_dspcfg
intel_pmc_bxt mousedev iTCO_vendor_support vfat snd_hda_codec fat
snd_hwdep snd_hda_core aesni_intel crypto_simd cryptd rapl snd_pcm
intel_agp qxl psmouse snd_timer i2c_i801 pcspkr i2c_smbus lpc_ich snd
soundcore usbhid drm_ttm_helper intel_gtt mac_hid ttm nfsd nfs_acl
lockd auth_rpcgss usbip_host grace usbip_core fuse sunrpc qemu_fw_cfg
ip_tables x_tables xfs libcrc32c crc32c_generic serio_raw atkbd libps2
9pnet_virtio virtio_rng 9pnet vivaldi_fmap rng_core virtio_balloon
virtio_net virtio_blk net_failover virtio_console virtio_scsi failover
crc32c_intel xhci_pci i8042 virtio_pci virtio_pci_legacy_dev
xhci_pci_renesas virtio_pci_modern_dev serio
[  149.020778] CR2: ffffa56a03e2ff70
[  149.021803] ---[ end trace 0000000000000000 ]---
[  149.021810] RIP: 0010:d_alloc_parallel+0x1ad/0x5a0
[  149.021815] Code: 48 c7 c2 ff ff ff ff 89 c1 48 d3 e2 48 f7 d2 4d
31 c1 49 85 d1 0f 84 e2 00 00 00 66 90 4d 8b 6d 00 4d 85 ed 0f 84 3e
03 00 00 <45> 39 95 70 ff ff ff 75 ea 4d 39 a5 68 ff ff ff 75 e1 4d 8d
b5 50
[  149.021817] RSP: 0018:ffffa56a03e1bc50 EFLAGS: 00010286
[  149.021819] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9101b9400000
[  149.021820] RDX: 00000006ebc26d0c RSI: ffff9100c30b9020 RDI: ffff9100cb523480
[  149.021821] RBP: 00000000000009fc R08: 00000000000000c0 R09: ffff9100cb76d180
[  149.021822] R10: 00000000ebc26d0c R11: ffffffff846e8750 R12: ffff9100cb523480
[  149.021823] R13: ffffa56a03e30000 R14: ffff9100cb5234d8 R15: ffffa56a03e1bdc8
[  149.021824] FS:  00007f0c00660540(0000) GS:ffff9101b9d00000(0000)
knlGS:0000000000000000
[  149.021826] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  149.021827] CR2: ffffa56a03e2ff70 CR3: 000000010eaa2004 CR4: 0000000000370ee0
[  149.021831] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  149.021832] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  149.021833] note: test7[683] exited with preempt_count 1
[  149.026665] BUG: unable to handle page fault for address: ffffa56a03e2ff70
[  149.026668] #PF: supervisor read access in kernel mode
[  149.026669] #PF: error_code(0x0000) - not-present page
[  149.026670] PGD 100000067 P4D 100000067 PUD 1001bb067 PMD 103164067 PTE 0
[  149.026674] Oops: 0000 [#2] PREEMPT SMP PTI
[  149.026674] Oops: 0000 [#2] PREEMPT SMP PTI
[  149.026676] CPU: 0 PID: 687 Comm: cthon.zsh Tainted: G      D W
    5.19.0-rc1-g3de25d30cb97-dirty #33479
5f05aa11df373b898aeb9103b7a17e0ee3946022
[  149.026679] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 0.0.0 02/06/2015
[  149.026680] RIP: 0010:d_alloc_parallel+0x1ad/0x5a0
[  149.026684] Code: 48 c7 c2 ff ff ff ff 89 c1 48 d3 e2 48 f7 d2 4d
31 c1 49 85 d1 0f 84 e2 00 00 00 66 90 4d 8b 6d 00 4d 85 ed 0f 84 3e
03 00 00 <45> 39 95 70 ff ff ff 75 ea 4d 39 a5 68 ff ff ff 75 e1 4d 8d
b5 50
[  149.026685] RSP: 0018:ffffa56a03e3bbf0 EFLAGS: 00010286
[  149.026687] RAX: 000000000000002a RBX: 000000000000002a RCX: ffff9101b9400000
[  149.026688] RDX: 000000047dd98e98 RSI: ffff9100c1da4030 RDI: ffff9100c5ea7540
[  149.026689] RBP: 00000000000009fc R08: 00000000000000c0 R09: ffff9100cb481600
[  149.026690] R10: 000000007dd98e98 R11: ffffffff846e7640 R12: ffff9100c5ea7540
[  149.026691] R13: ffffa56a03e30000 R14: ffff9100c5ea7598 R15: ffffa56a03e3bda0
[  149.026692] FS:  00007fa4232f9000(0000) GS:ffff9101b9c00000(0000)
knlGS:0000000000000000
[  149.026693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  149.026694] CR2: ffffa56a03e2ff70 CR3: 0000000104b90002 CR4: 0000000000370ef0
[  149.026698] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  149.026699] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  149.026700] Call Trace:
[  149.026702]  <TASK>
[  149.026704]  __lookup_slow+0x61/0x160
[  149.026707]  ? try_to_unlazy+0x14d/0x1f0
[  149.026709]  lookup_slow+0x33/0x50
[  149.026711]  walk_component+0x132/0x150
[  149.026714]  path_lookupat+0x4d/0x100
[  149.026716]  filename_lookup+0xeb/0x200
[  149.026718]  user_path_at_empty+0x36/0x90
[  149.026721]  do_faccessat+0x124/0x290
[  149.026723]  do_syscall_64+0x31/0x50
[  149.026726]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  149.026729] RIP: 0033:0x7fa423101ceb
[  149.026731] Code: 77 05 c3 0f 1f 40 00 48 8b 15 a9 b0 0f 00 f7 d8
64 89 02 48 c7 c0 ff ff ff ff c3 0f 1f 40 00 f3 0f 1e fa b8 15 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 79 b0 0f 00
f7 d8
[  149.026732] RSP: 002b:00007ffd7374d6a8 EFLAGS: 00000202 ORIG_RAX:
0000000000000015
[  149.026734] RAX: ffffffffffffffda RBX: 00007ffd7374d760 RCX: 00007fa423101ceb
[  149.026735] RDX: 000000000000002f RSI: 0000000000000001 RDI: 00007ffd7374d760
[  149.026736] RBP: 00007ffd7374d760 R08: 0000000000000001 R09: 0000000000000000
[  149.026737] R10: 0000000000000001 R11: 0000000000000202 R12: 000055b0c36db9d8
[  149.026738] R13: 00007ffd7374e760 R14: 00007ffd7374d770 R15: 00007fa42326ebb0
[  149.026740]  </TASK>
[  149.026740] Modules linked in: cbc cts rpcsec_gss_krb5 nfsv4 nfs
fscache netfs rpcrdma rdma_cm iw_cm ib_cm ib_core cfg80211 rfkill
8021q garp stp mrp llc intel_rapl_msr intel_rapl_common kvm_intel kvm
snd_hda_codec_generic irqbypass crct10dif_pclmul crc32_pclmul
snd_hda_intel ghash_clmulni_intel iTCO_wdt joydev snd_intel_dspcfg
intel_pmc_bxt mousedev iTCO_vendor_support vfat snd_hda_codec fat
snd_hwdep snd_hda_core aesni_intel crypto_simd cryptd rapl snd_pcm
intel_agp qxl psmouse snd_timer i2c_i801 pcspkr i2c_smbus lpc_ich snd
soundcore usbhid drm_ttm_helper intel_gtt mac_hid ttm nfsd nfs_acl
lockd auth_rpcgss usbip_host grace usbip_core fuse sunrpc qemu_fw_cfg
ip_tables x_tables xfs libcrc32c crc32c_generic serio_raw atkbd libps2
9pnet_virtio virtio_rng 9pnet vivaldi_fmap rng_core virtio_balloon
virtio_net virtio_blk net_failover virtio_console virtio_scsi failover
crc32c_intel xhci_pci i8042 virtio_pci virtio_pci_legacy_dev
xhci_pci_renesas virtio_pci_modern_dev serio
[  149.026793] CR2: ffffa56a03e2ff70
[  149.026795] ---[ end trace 0000000000000000 ]---
[  149.026795] RIP: 0010:d_alloc_parallel+0x1ad/0x5a0
[  149.026797] Code: 48 c7 c2 ff ff ff ff 89 c1 48 d3 e2 48 f7 d2 4d
31 c1 49 85 d1 0f 84 e2 00 00 00 66 90 4d 8b 6d 00 4d 85 ed 0f 84 3e
03 00 00 <45> 39 95 70 ff ff ff 75 ea 4d 39 a5 68 ff ff ff 75 e1 4d 8d
b5 50
[  149.026798] RSP: 0018:ffffa56a03e1bc50 EFLAGS: 00010286
[  149.026799] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9101b9400000
[  149.026800] RDX: 00000006ebc26d0c RSI: ffff9100c30b9020 RDI: ffff9100cb523480
[  149.026801] RBP: 00000000000009fc R08: 00000000000000c0 R09: ffff9100cb76d180
[  149.026802] R10: 00000000ebc26d0c R11: ffffffff846e8750 R12: ffff9100cb523480
[  149.026803] R13: ffffa56a03e30000 R14: ffff9100cb5234d8 R15: ffffa56a03e1bdc8
[  149.026803] FS:  00007fa4232f9000(0000) GS:ffff9101b9c00000(0000)
knlGS:0000000000000000
[  149.026805] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  149.026806] CR2: ffffa56a03e2ff70 CR3: 0000000104b90002 CR4: 0000000000370ef0
[  149.026807] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  149.026807] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  149.026808] note: cthon.zsh[687] exited with preempt_count 1
[  149.039191] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
[  149.039194] BUG: unable to handle page fault for address: ffff9100cb775fb0
[  149.039196] #PF: supervisor instruction fetch in kernel mode
[  149.039197] #PF: error_code(0x0011) - permissions violation
[  149.039199] PGD 1cfe05067 P4D 1cfe05067 PUD 100b7a063 PMD 800000010b6001e3
[  149.039203] Oops: 0011 [#3] PREEMPT SMP PTI
[  149.039206] CPU: 1 PID: 15 Comm: pr/tty0 Tainted: G      D W
 5.19.0-rc1-g3de25d30cb97-dirty #33479
5f05aa11df373b898aeb9103b7a17e0ee3946022
[  149.039210] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 0.0.0 02/06/2015
[  149.039212] RIP: 0010:0xffff9100cb775fb0
[  149.039215] Code: ff ff 80 5f 77 cb 00 91 ff ff d0 5b 77 cb 00 91
ff ff 20 35 52 cb 00 91 ff ff a0 5f 77 cb 00 91 ff ff a0 5f 77 cb 00
91 ff ff <30> b5 d7 cb 00 91 ff ff b0 de 9b 82 ff ff ff ff 00 00 00 00
00 00
[  149.039217] RSP: 0018:ffffa56a00110f28 EFLAGS: 00010286
[  149.039219] RAX: ffff9100c04ab530 RBX: 0000000000000004 RCX: 0000000000000004
[  149.039220] RDX: ffff9100c01c4c10 RSI: 0000000000000000 RDI: ffff9100c04ab530
[  149.039221] RBP: 0000000000000015 R08: 0000000080100006 R09: 0000000000100006
[  149.039223] R10: 7fffffffffffffff R11: ffff9100cb775fb0 R12: ffff9101b9cb25f8
[  149.039224] R13: ffffa56a00110f38 R14: ffff9101b9cb2580 R15: ffff9100c0318000
[  149.039226] FS:  0000000000000000(0000) GS:ffff9101b9c80000(0000)
knlGS:0000000000000000
[  149.039227] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  149.039229] CR2: ffff9100cb775fb0 CR3: 0000000103698005 CR4: 0000000000370ee0
[  149.039234] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  149.039235] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  149.039236] Call Trace:
[  149.039238]  <IRQ>
[  149.039240]  ? rcu_core+0x2f7/0x770
[  149.039245]  ? __do_softirq+0x152/0x2d1
[  149.039249]  ? irq_exit_rcu+0x6c/0xb0
[  149.039252]  ? sysvec_apic_timer_interrupt+0x6d/0x80
[  149.039255]  </IRQ>
[  149.039256]  <TASK>
[  149.039257]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  149.039263]  ? bit_putcs+0x503/0x7c0
[  149.039271]  ? fbcon_putcs+0x251/0x280
[  149.039273]  ? bit_clear+0x100/0x100
[  149.039276]  ? fbcon_redraw+0x152/0x220
[  149.039279]  ? fbcon_scroll+0xd4/0x1b0
[  149.039282]  ? con_scroll+0x1b1/0x240
[  149.039286]  ? vt_console_print+0x1f7/0x450
[  149.039289]  ? __console_emit_next_record+0x30b/0x3a0
[  149.039293]  ? printk_kthread_func+0x4a4/0x600
[  149.039295]  ? wake_bit_function+0x70/0x70
[  149.039298]  ? console_cpu_notify+0x80/0x80
[  149.039300]  ? kthread+0xd8/0xf0
[  149.039303]  ? kthread_blkcg+0x30/0x30
[  149.039305]  ? ret_from_fork+0x22/0x30
[  149.039310]  </TASK>
[  149.039311] Modules linked in: cbc cts rpcsec_gss_krb5 nfsv4 nfs
fscache netfs rpcrdma rdma_cm iw_cm ib_cm ib_core cfg80211 rfkill
8021q garp stp mrp llc intel_rapl_msr intel_rapl_common kvm_intel kvm
snd_hda_codec_generic irqbypass crct10dif_pclmul crc32_pclmul
snd_hda_intel ghash_clmulni_intel iTCO_wdt joydev snd_intel_dspcfg
intel_pmc_bxt mousedev iTCO_vendor_support vfat snd_hda_codec fat
snd_hwdep snd_hda_core aesni_intel crypto_simd cryptd rapl snd_pcm
intel_agp qxl psmouse snd_timer i2c_i801 pcspkr i2c_smbus lpc_ich snd
soundcore usbhid drm_ttm_helper intel_gtt mac_hid ttm nfsd nfs_acl
lockd auth_rpcgss usbip_host grace usbip_core fuse sunrpc qemu_fw_cfg
ip_tables x_tables xfs libcrc32c crc32c_generic serio_raw atkbd libps2
9pnet_virtio virtio_rng 9pnet vivaldi_fmap rng_core virtio_balloon
virtio_net virtio_blk net_failover virtio_console virtio_scsi failover
crc32c_intel xhci_pci i8042 virtio_pci virtio_pci_legacy_dev
xhci_pci_renesas virtio_pci_modern_dev serio
[  149.039392] CR2: ffff9100cb775fb0
[  149.039402] ---[ end trace 0000000000000000 ]---
[  149.039403] RIP: 0010:d_alloc_parallel+0x1ad/0x5a0
[  149.039407] Code: 48 c7 c2 ff ff ff ff 89 c1 48 d3 e2 48 f7 d2 4d
31 c1 49 85 d1 0f 84 e2 00 00 00 66 90 4d 8b 6d 00 4d 85 ed 0f 84 3e
03 00 00 <45> 39 95 70 ff ff ff 75 ea 4d 39 a5 68 ff ff ff 75 e1 4d 8d
b5 50
[  149.039408] RSP: 0018:ffffa56a03e1bc50 EFLAGS: 00010286
[  149.039410] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9101b9400000
[  149.039411] RDX: 00000006ebc26d0c RSI: ffff9100c30b9020 RDI: ffff9100cb523480
[  149.039412] RBP: 00000000000009fc R08: 00000000000000c0 R09: ffff9100cb76d180
[  149.039413] R10: 00000000ebc26d0c R11: ffffffff846e8750 R12: ffff9100cb523480
[  149.039414] R13: ffffa56a03e30000 R14: ffff9100cb5234d8 R15: ffffa56a03e1bdc8
[  149.039415] FS:  0000000000000000(0000) GS:ffff9101b9c80000(0000)
knlGS:0000000000000000
[  149.039417] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  149.039418] CR2: ffff9100cb775fb0 CR3: 0000000103698005 CR4: 0000000000370ee0
[  149.039421] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  149.039422] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  149.039423] Kernel panic - not syncing: Fatal exception in interrupt
[  149.039611] Kernel Offset: 0x1600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Hopefully something in there helps you figure out what's going on!

Anna

>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 54c2c7adcd56..072130d000c4 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2483,17 +2483,16 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
>         if (!(dentry->d_flags & DCACHE_PAR_UPDATE)) {
>                 /* Must have exclusive lock on parent */
>                 did_set_par_update = true;
> +               lock_acquire_exclusive(&dentry->d_update_map, 0,
> +                                      0, NULL, _THIS_IP_);
>                 dentry->d_flags |= DCACHE_PAR_UPDATE;
>         }
>
>         spin_unlock(&dentry->d_lock);
>         error = nfs_safe_remove(dentry);
>         nfs_dentry_remove_handle_error(dir, dentry, error);
> -       if (did_set_par_update) {
> -               spin_lock(&dentry->d_lock);
> -               dentry->d_flags &= ~DCACHE_PAR_UPDATE;
> -               spin_unlock(&dentry->d_lock);
> -       }
> +       if (did_set_par_update)
> +               d_unlock_update(dentry);
>  out:
>         trace_nfs_unlink_exit(dir, dentry, error);
>         return error;
>
> >
> > So all in all, the performance improvements in the knfsd re-export
> > case is looking great and we have real world use cases that this helps
> > with (batch processing workloads with latencies >10ms). If we can
> > figure out the hanging knfsd threads, then I can test it more heavily.
>
> Hopefully the above patch will allow the more heavy testing to continue.
> In any case, thanks a lot for the testing so far,
>
> NeilBrown
