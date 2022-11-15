Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E465629CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKOPES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 10:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKOPEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:04:15 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FBE2AFF;
        Tue, 15 Nov 2022 07:04:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v1so24719458wrt.11;
        Tue, 15 Nov 2022 07:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9vY8unG47QxAuJnd1roku+YX8GCXOFfaJ/BSdj6qzU=;
        b=XX8LsXnuL6op6ju0gfkOMBaPrBFBAmNa22OjJNk94ZVxEPr7tUzVqIyZRV+G+AC/+g
         zBtCtYTpieuJpBokWMpVRtdu7GYOs3nJLmPTPSJ9P+ybKAyfGxSd0kM+qzqpPS/n9cCa
         SWZ5xn+2z0h/xdS98MjYBA9QCwsZwl/2UBHQddljuYSKvD78WEt4C4OZJ2CNa7k218pR
         rKjcY4Ya/nuRXeVLTozoN5hWc0BrlqJvvKx3DZvGItbP05W9r/Ss7jmE77CduNwMGBnh
         RYVBMg/U0HhRV3Bmva73GcKJ9mu65kBQs5Qx9xiyYh17K/cAY06apXv/eLeRVMLIR970
         fqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9vY8unG47QxAuJnd1roku+YX8GCXOFfaJ/BSdj6qzU=;
        b=tIe0M1j5dvaipokjnbt3Q3+qcdi/sYWollehR3jgxo6lAmBlGmhrffotDqkjUn0oqG
         ua+nPC7fCvGBOrbaJblC9z4FGkvCRldYDedbo/5eOQoJ3R6ca/F/2OXek8d6t4nJerwn
         dVNFs0Jd3hPp+cQrakgH6J60vH7D2NAhU985icSfRxMS86rYQAdLb44qF+fC9poGlzys
         PbZSkryaIhUjhRQqS7he8kfMOSkrAa6abCuR1Akv6fTgZ3WsiToBrG+KaSz7HyCn4EQ4
         6V/0flH6CPkaGwUBgtf+H1n8N+gs7PHIGfIRBE9yPSYrLMZj9V1cJXV6/laDJ11zm29d
         WAtQ==
X-Gm-Message-State: ANoB5pnunaM2mHDmb1Ri141FHsH/zbyfYHhe5P0rExC9IXR+IP5FlxFB
        4LZu46FajqqTI4su3hlgqE/5RcWdahn07qCzRkCelv1DT1WRCvwT
X-Google-Smtp-Source: AA0mqf65v9y0xySWHEdl0Q08d+W6e1YL1ENLC0+rYa00Y+CDcVBRZLPrXpXd70y+Ya26cjMcLAFi9xzZZeYyrYAlx2s=
X-Received: by 2002:a5d:660b:0:b0:235:e82c:ca7d with SMTP id
 n11-20020a5d660b000000b00235e82cca7dmr10691640wru.92.1668524652684; Tue, 15
 Nov 2022 07:04:12 -0800 (PST)
MIME-Version: 1.0
From:   ditang chen <ditang.c@gmail.com>
Date:   Tue, 15 Nov 2022 23:04:01 +0800
Message-ID: <CAHnGgyHAo+XQPchU4HaKshFbnyHYuD0EuHy17QvPRAZ4MFVq-w@mail.gmail.com>
Subject: fs/pnode.c: propagate_one Oops in ltp/fs_bind test
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here is a reproducer:
1. Run netns.sh script in loop
# while true; do ./netns.sh; done
# cat netns.sh
#!/bin/bash
num=3D1000
function create_netns()
{
for((i=3D0; i<$num; i++))
do
  ip netns add local$i
  ip netns exec local$i pwd &
done
}
function clean_netns()
{
for((i=3D0; i<$num; i++))
do
    ip netns del local$i
done
}
create_netns
clean_netns

2.  run fs_bind/fs_bind24 in loop, fs_bind24 only
# cat /opt/ltp/runtest/fs_bind
#DESCRIPTION:Bind mounts and shared subtrees
fs_bind24_sh fs_bind24.sh
# while true; do /opt/ltp/runltp -f fs_bind; done

This oops also exists in the latest kernel code=EF=BC=9A
[ 1381.034793] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000010
[ 1381.035608] PGD 0 P4D 0
[ 1381.035865] Oops: 0000 [#1] SMP PTI
[ 1381.036227] CPU: 0 PID: 281475 Comm: mount Kdump: loaded Not
tainted 4.19.90-2109.1.0.0108.oe1.x86_64 #1
[ 1381.037174] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[ 1381.038001] RIP: 0010:propagate_one+0x9d/0x200
[ 1381.038450] Code: 01 00 00 49 89 d1 49 8b 91 d8 00 00 00 4c 39 c2
75 e7 4c 8b 15 4c ae 9e 01 48 89 fa eb 09 48 8b 92 d8 00 00 00 89 c6
49 39 d2 <48> 8b 4a 10 0f 84 10 01 00 00 4c 39 81 d8 00 00 00 75 e1 40
84 f6
[ 1381.040317] RSP: 0018:ffffb7648932fdd8 EFLAGS: 00010282
[ 1381.041049] RAX: ffff893a8f19a101 RBX: ffff893aa421b500 RCX: ffff893a99e=
2f380
[ 1381.041776] RDX: 0000000000000000 RSI: 000000008f19a101 RDI: ffff893a9f9=
39200
[ 1381.043437] RBP: ffff893aadba5980 R08: ffff893aadba5980 R09: ffff893aa42=
1b500
[ 1381.044159] R10: ffff893a9f939080 R11: 0000000000017f40 R12: ffffb764893=
2fe28
[ 1381.044867] R13: 0000000000000000 R14: ffff893aa421b500 R15: ffff8939c7d=
08900
[ 1381.045578] FS: 00007fae96b07c80(0000) GS:ffff893ad7a00000(0000)
knlGS:0000000000000000
[ 1381.046395] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1381.046968] CR2: 0000000000000010 CR3: 00000001d8ea4006 CR4: 00000000000=
606f0
[ 1381.047678] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1381.048391] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1381.049104] Call Trace:
[ 1381.049366] propagate_mnt+0x11f/0x150
[ 1381.049745] attach_recursive_mnt+0x220/0x2e0
[ 1381.050191] do_mount+0xa6c/0xc80
[ 1381.050526] ? __kmalloc_track_caller+0x5a/0x200
[ 1381.051007] ? _copy_from_user+0x37/0x60
[ 1381.051403] ksys_mount+0x80/0xd0
[ 1381.051738] __x64_sys_mount+0x21/0x30
[ 1381.052124] do_syscall_64+0x5f/0x240
[ 1381.052500] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1381.053017] RIP: 0033:0x7fae96cbf24a
[ 1381.053378] Code: 48 8b 0d 59 7c 0b 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 26 7c 0b 00 f7 d8 64 89
01 48
[ 1381.055249] RSP: 002b:00007ffd13aa2d88 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[ 1381.056004] RAX: ffffffffffffffda RBX: 000055f4e88f6420 RCX: 00007fae96c=
bf24a
[ 1381.056714] RDX: 000055f4e88f6650 RSI: 000055f4e88f93d0 RDI: 000055f4e88=
f8350
[ 1381.057636] RBP: 0000000000000000 R08: 0000000000000000 R09: 000055f4e88=
f5010
[ 1381.058502] R10: 0000000000001000 R11: 0000000000000246 R12: 000055f4e88=
f8350
[ 1381.059236] R13: 000055f4e88f6650 R14: 0000000000000001 R15: 00007fae96e=
62224
[ 1381.059959] Modules linked in: veth xt_addrtype br_netfilter
dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio loop
ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4
xt_conntrack ebtable_filter ebtable_nat ebtable_broute bridge stp llc
ebtables ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat_ipv4 nf_nat iptable_mangle
iptable_raw iptable_security nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c rfkill ip_set nfnetlink ip6table_filter
ip6_tables iptable_filter vfat fat vmwgfx snd_intel8x0 snd_ac97_codec
crct10dif_pclmul crc32_pclmul ac97_bus snd_pcm ghash_clmulni_intel ttm
snd_timer drm_kms_helper snd syscopyarea joydev sg sysfillrect
sysimgblt fb_sys_fops soundcore i2c_piix4 drm pcspkr intel_rapl_perf
video ip_tables ext4 mbcache
[ 1381.067111] jbd2 sr_mod cdrom sd_mod ata_generic crc32c_intel
serio_raw ata_piix ahci libahci e1000 libata dm_mirror dm_region_hash
dm_log dm_mod
[ 1381.068437] CR2: 0000000000000010
