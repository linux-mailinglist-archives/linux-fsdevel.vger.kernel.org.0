Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF23C9C72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbhGOKN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 06:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhGOKN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:13:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A19C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 03:10:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dt7so8342913ejc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=llFf0pvAUgVTGUvej6RM+dvd9ewojVEPgabg6+B9/WM=;
        b=EqHNSF8NZFta670dub/67zDsjZzM/OiK+aRQmwcv/shZP5Rn71O8+bM2+rNuhoXITc
         Tie0bFIAb1CXV84vYHF3axAuY19AYGyX/X7EVtm+F8QhQcDKI5bfb9CLjd1KwgCZyoBg
         +gtDaOiIDyyPS/QnyHK4H92KHQy6q5rHBrYt3xTzOstWc+W/1HCS0olx/kcQ9eE7qldN
         Z317IjdtRKP2RlJuyBpnBXSo2JoLFWOOOHrfZ95LuGeOz/2p1GX3HcDHFyf4+u9S7J0C
         Ibr6iEkxSgN+/aAK0oKeap4Ka9ZhCg/q3Cw/J1kvLwM4oX/V7+VnM0NdgWJ5dpmgbBwg
         tbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=llFf0pvAUgVTGUvej6RM+dvd9ewojVEPgabg6+B9/WM=;
        b=GUxxQY33kYWaS1xCyb2HVVI3v8NU9AbhB6RmSOjVPzRWtQvVLHIsugeLsBgBhoKAcB
         yfb6XlHdd5dbdXkhG9Vs3Cs8XMeHE+WSWdOkR380vCoNNIT7lbxrvKUopOuE4Z7UK5k8
         pKabBoyhyYY+Ios2ByZSnRGRbcrl959cW8jOcFwhO9S2pOm/yUi2mfaJhr0V/+ZZdlg0
         hj74/bu+shqf/ZwpZHvPiiaVwD2THyEmHNYIgEm4oiX7XzAPfa8AlqdGSziB1IQvO8Rm
         8/tHxJrQwAyOn+vRMTunyDoaYh2dtVm8629Ts9BCqNpVsubHpvx6TlvWFiUdL2x38e+u
         5Q/Q==
X-Gm-Message-State: AOAM530paJfZcAbqDmW37jmkdt7wuS453DYCQJtTyrfKt22lxp09Q+MX
        e/sbyLpdZvkLRK5HXnDS+wJ8hFMLk/72KDB85ue+4P0ezno=
X-Google-Smtp-Source: ABdhPJzyfQ+cml6uRnUScColi38vV0/bivUz5Yq99uDy3dNlKw6CElTmNi/o6kdOZuazq+Rc/ntQKl6Uq1xxRrSDXhE=
X-Received: by 2002:a17:906:718c:: with SMTP id h12mr4608644ejk.6.1626343833576;
 Thu, 15 Jul 2021 03:10:33 -0700 (PDT)
MIME-Version: 1.0
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Thu, 15 Jul 2021 18:10:22 +0800
Message-ID: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
Subject: [fsdax xfs] Regression panic at inode_switch_wbs_work_fn
To:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

#Looping generic/270 of xfstests[1] on pmem ramdisk with
mount option:  -o dax=always
mkfs.xfs option: -f -b size=4096 -m reflink=0
can hit this panic now.

#It's not reproducible on ext4.
#It's not reproducible without dax=always.

#Bisecting points to this
  commit c22d70a162d3cc177282c4487be4d54876ca55c8
  Author: Roman Gushchin <guro@fb.com>
  Date:   Mon Jun 28 19:36:03 2021 -0700

      writeback, cgroup: release dying cgwbs by switching attached inodes

#With this commit reverted, no panic.

#xfs_info output:

meta-data=/dev/pmem0p2           isize=512    agcount=4, agsize=532416
blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1,
rmapbt=0
         =                       reflink=0    bigtime=1 inobtcount=1
data     =                       bsize=4096   blocks=2129664, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

#call trace:

[  987.071651] run fstests generic/270 at 2021-07-15 05:54:02
[  988.704940] XFS (pmem0p2): EXPERIMENTAL big timestamp feature in
use.  Use at your own risk!
[  988.746847] XFS (pmem0p2): DAX enabled. Warning: EXPERIMENTAL, use
at your own risk
[  988.786070] XFS (pmem0p2): EXPERIMENTAL inode btree counters
feature in use. Use at your own risk!
[  988.828639] XFS (pmem0p2): Mounting V5 Filesystem
[  988.854019] XFS (pmem0p2): Ending clean mount
[  988.874550] XFS (pmem0p2): Quotacheck needed: Please wait.
[  988.900618] XFS (pmem0p2): Quotacheck: Done.
[  989.090783] XFS (pmem0p2): xlog_verify_grant_tail: space > BBTOB(tail_blocks)
[  989.092751] XFS (pmem0p2): xlog_verify_grant_tail: space > BBTOB(tail_blocks)
[  989.092962] XFS (pmem0p2): xlog_verify_grant_tail: space > BBTOB(tail_blocks)
[ 1010.105586] BUG: unable to handle page fault for address: 0000000005b0f669
[ 1010.141817] #PF: supervisor read access in kernel mode
[ 1010.167824] #PF: error_code(0x0000) - not-present page
[ 1010.191499] PGD 0 P4D 0
[ 1010.203346] Oops: 0000 [#1] SMP PTI
[ 1010.219596] CPU: 13 PID: 10479 Comm: kworker/13:16 Not tainted
5.14.0-rc1-master-8096acd7442e+ #8
[ 1010.260441] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
Gen9, BIOS P89 09/13/2016
[ 1010.297792] Workqueue: inode_switch_wbs inode_switch_wbs_work_fn
[ 1010.324832] RIP: 0010:inode_do_switch_wbs+0xaf/0x470
[ 1010.347261] Code: 00 30 0f 85 c1 03 00 00 0f 1f 44 00 00 31 d2 48
c7 c6 ff ff ff ff 48 8d 7c 24 08 e8 eb 49 1a 00 48 85 c0 74 4a bb ff
ff ff ff <48> 8b 50 08 48 8d 4a ff 83 e2 01 48 0f 45 c1 48 8b 00 a8 08
0f 85
[ 1010.434307] RSP: 0018:ffff9c66691abdc8 EFLAGS: 00010002
[ 1010.457795] RAX: 0000000005b0f661 RBX: 00000000ffffffff RCX: ffff89e6a21382b0
[ 1010.489922] RDX: 0000000000000001 RSI: ffff89e350230248 RDI: ffffffffffffffff
[ 1010.522085] RBP: ffff89e681d19400 R08: 0000000000000000 R09: 0000000000000228
[ 1010.554234] R10: ffffffffffffffff R11: ffffffffffffffc0 R12: ffff89e6a2138130
[ 1010.586414] R13: ffff89e316af7400 R14: ffff89e316af6e78 R15: ffff89e6a21382b0
[ 1010.619394] FS:  0000000000000000(0000) GS:ffff89ee5fb40000(0000)
knlGS:0000000000000000
[ 1010.658874] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1010.688085] CR2: 0000000005b0f669 CR3: 0000000cb2410004 CR4: 00000000001706e0
[ 1010.722129] Call Trace:
[ 1010.733132]  inode_switch_wbs_work_fn+0xb6/0x2a0
[ 1010.754121]  process_one_work+0x1e6/0x380
[ 1010.772512]  worker_thread+0x53/0x3d0
[ 1010.789221]  ? process_one_work+0x380/0x380
[ 1010.807964]  kthread+0x10f/0x130
[ 1010.822043]  ? set_kthread_struct+0x40/0x40
[ 1010.840818]  ret_from_fork+0x22/0x30
[ 1010.856851] Modules linked in: xt_CHECKSUM xt_MASQUERADE
xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables
nfnetlink bridge stp llc rfkill sunrpc intel_rapl_msr
intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel ipmi_ssif kvm mgag200 i2c_algo_bit iTCO_wdt
irqbypass drm_kms_helper iTCO_vendor_support acpi_ipmi rapl
syscopyarea sysfillrect intel_cstate ipmi_si sysimgblt ioatdma
dax_pmem_compat fb_sys_fops ipmi_devintf device_dax i2c_i801 pcspkr
intel_uncore hpilo nd_pmem cec dax_pmem_core dca i2c_smbus acpi_tad
lpc_ich ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c sd_mod
t10_pi crct10dif_pclmul crc32_pclmul crc32c_intel tg3
ghash_clmulni_intel serio_raw hpsa hpwdt scsi_transport_sas wmi
dm_mirror dm_region_hash dm_log dm_mod
[ 1011.200864] CR2: 0000000005b0f669
[ 1011.215700] ---[ end trace ed2105faff8384f3 ]---
[ 1011.241727] RIP: 0010:inode_do_switch_wbs+0xaf/0x470
[ 1011.264306] Code: 00 30 0f 85 c1 03 00 00 0f 1f 44 00 00 31 d2 48
c7 c6 ff ff ff ff 48 8d 7c 24 08 e8 eb 49 1a 00 48 85 c0 74 4a bb ff
ff ff ff <48> 8b 50 08 48 8d 4a ff 83 e2 01 48 0f 45 c1 48 8b 00 a8 08
0f 85
[ 1011.348821] RSP: 0018:ffff9c66691abdc8 EFLAGS: 00010002
[ 1011.372734] RAX: 0000000005b0f661 RBX: 00000000ffffffff RCX: ffff89e6a21382b0
[ 1011.405826] RDX: 0000000000000001 RSI: ffff89e350230248 RDI: ffffffffffffffff
[ 1011.437852] RBP: ffff89e681d19400 R08: 0000000000000000 R09: 0000000000000228
[ 1011.469926] R10: ffffffffffffffff R11: ffffffffffffffc0 R12: ffff89e6a2138130
[ 1011.502179] R13: ffff89e316af7400 R14: ffff89e316af6e78 R15: ffff89e6a21382b0
[ 1011.534233] FS:  0000000000000000(0000) GS:ffff89ee5fb40000(0000)
knlGS:0000000000000000
[ 1011.571247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1011.597063] CR2: 0000000005b0f669 CR3: 0000000cb2410004 CR4: 00000000001706e0
[ 1011.629160] Kernel panic - not syncing: Fatal exception
[ 1011.653802] Kernel Offset: 0x15200000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1011.713723] ---[ end Kernel panic - not syncing: Fatal exception ]---


[1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/
-- 
Murphy
