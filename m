Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B02F3C7CD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 05:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbhGNDYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 23:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237436AbhGNDYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626232888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lZvdbTNPQm/YRFZ3YwmMC1ooNY6R3jooh00awDT2kT4=;
        b=DY1hNFTO3dEbok6ixKmj5xWi6bWj7KH4FsYokwoz9cLSAidG9V744sJ8YxOELLMiV+FSPn
        2JD6Xc1/mEXV6VSfHztQOkP74vYxnQyuja9tlnqC6XZHMPwBo//cg0Ql0iA+kHKSvG2Djt
        XWuQvWz5RCfyna53DdVd+mWwbAo0zMs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-SKj5vwxXOPuqgMkPJwiy8A-1; Tue, 13 Jul 2021 23:21:27 -0400
X-MC-Unique: SKj5vwxXOPuqgMkPJwiy8A-1
Received: by mail-pg1-f197.google.com with SMTP id j13-20020a63594d0000b0290228b387f4a3so464395pgm.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 20:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lZvdbTNPQm/YRFZ3YwmMC1ooNY6R3jooh00awDT2kT4=;
        b=Erv9OKLGIiuGhjZ15u1FvuzEbijlo4nCQJDP2ktoaGvb/MzvsHUmT3rj+g7fjMn+/B
         E0ve+3dIGGTJMr6WAMvXpWcNCltqy1cyVKnnFxPxbCo+HB/23Il4j2zabQr7nU9ENPJn
         h1hhJk/OggJ1RGcao5uEY32A+K/BPMcyUe80s1KIKXfCVbOLJq9TuVdSTXkoyfMfDNNr
         a1j8HSL9n8DC86y9oSrTuYkm6Ilih/OHrotJR4FSoX1ZTDQfXfEzRTHOmaffgaaJDEN3
         eElbQWFtZ34Cq3apt/7dU4jWt+dm+d52s8F22ikOOb0O0uvOp++tq2Ixs8XijIK3/W1/
         72fg==
X-Gm-Message-State: AOAM530d8OpWcSkXzkjT60ffVASJykFHcRNKX1YTjv29zyMJxvvzIquN
        evwKWXwJ1qTUEg7BbK7ufj8sg6rPnddNCyOKo90ANuZprLPMiLZZohz4fkGyYElS+iRJT6eKCku
        PS5Dqa0BNRdPZdIGCn1gwC8EB1itp2hEorJ03CoDjwQ==
X-Received: by 2002:a65:4d4c:: with SMTP id j12mr1850013pgt.311.1626232886079;
        Tue, 13 Jul 2021 20:21:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/UqqhUhG305CuDl7ZMR+uDGccX5JQJ7PKPo7RT7TmgVSk/VqWAG14ofqzcNGbHuyKOYnlk9wtRV8spJw+M5s=
X-Received: by 2002:a65:4d4c:: with SMTP id j12mr1849982pgt.311.1626232885514;
 Tue, 13 Jul 2021 20:21:25 -0700 (PDT)
MIME-Version: 1.0
From:   Boyang Xue <bxue@redhat.com>
Date:   Wed, 14 Jul 2021 11:21:12 +0800
Message-ID: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
Subject: Patch 'writeback, cgroup: release dying cgwbs by switching attached
 inodes' leads to kernel crash
To:     linux-fsdevel@vger.kernel.org
Cc:     guro@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I'm not sure if this is the right place to report this bug, please
correct me if I'm wrong.

I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
running xfstests generic/256 on ext4 [1]. Looking at the call trace,
it looks like the bug had been introduced by the commit

c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes

It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing
was performed with the latest xfstests, and the bug can be reproduced
on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.

Thanks,
Boyang

1. dmesg
```
[ 4366.380974] run fstests generic/256 at 2021-07-12 05:41:40
[ 4368.337078] EXT4-fs (vda3): mounted filesystem with ordered data
mode. Opts: . Quota mode: none.
[ 4371.275986] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[ 4371.278210] Mem abort info:
[ 4371.278880]   ESR = 0x96000005
[ 4371.279603]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 4371.280878]   SET = 0, FnV = 0
[ 4371.281621]   EA = 0, S1PTW = 0
[ 4371.282396]   FSC = 0x05: level 1 translation fault
[ 4371.283635] Data abort info:
[ 4371.284333]   ISV = 0, ISS = 0x00000005
[ 4371.285246]   CM = 0, WnR = 0
[ 4371.285975] user pgtable: 64k pages, 48-bit VAs, pgdp=00000000b0502000
[ 4371.287640] [0000000000000000] pgd=0000000000000000,
p4d=0000000000000000, pud=0000000000000000
[ 4371.290016] Internal error: Oops: 96000005 [#1] SMP
[ 4371.291251] Modules linked in: dm_flakey dm_snapshot dm_bufio
dm_zero dm_mod loop tls rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver
nfs lockd grace fscache netfs rfkill sunrpc ext4 vfat fat mbcache jbd2
drm fuse xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64
sha1_ce virtio_blk virtio_net net_failover virtio_console failover
virtio_mmio aes_neon_bs [last unloaded: scsi_debug]
[ 4371.300059] CPU: 0 PID: 408468 Comm: kworker/u8:5 Tainted: G
       X --------- ---  5.14.0-0.rc1.15.bx.el9.aarch64 #1
[ 4371.303009] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[ 4371.304685] Workqueue: events_unbound cleanup_offline_cgwbs_workfn
[ 4371.306329] pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO BTYPE=--)
[ 4371.307867] pc : cleanup_offline_cgwbs_workfn+0x320/0x394
[ 4371.309254] lr : cleanup_offline_cgwbs_workfn+0xe0/0x394
[ 4371.310597] sp : ffff80001554fd10
[ 4371.311443] x29: ffff80001554fd10 x28: 0000000000000000 x27: 0000000000000001
[ 4371.313320] x26: 0000000000000000 x25: 00000000000000e0 x24: ffffd2a2fbe671a8
[ 4371.315159] x23: ffff80001554fd88 x22: ffffd2a2fbe67198 x21: ffffd2a2fc25a730
[ 4371.316945] x20: ffff210412bc3000 x19: ffff210412bc3280 x18: 0000000000000000
[ 4371.318690] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[ 4371.320437] x14: 0000000000000000 x13: 0000000000000030 x12: 0000000000000040
[ 4371.322444] x11: ffff210481572238 x10: ffff21048157223a x9 : ffffd2a2fa276c60
[ 4371.324243] x8 : ffff210484106b60 x7 : 0000000000000000 x6 : 000000000007d18a
[ 4371.326049] x5 : ffff210416a86400 x4 : ffff210412bc0280 x3 : 0000000000000000
[ 4371.327898] x2 : ffff80001554fd88 x1 : ffff210412bc0280 x0 : 0000000000000003
[ 4371.329748] Call trace:
[ 4371.330372]  cleanup_offline_cgwbs_workfn+0x320/0x394
[ 4371.331694]  process_one_work+0x1f4/0x4b0
[ 4371.332767]  worker_thread+0x184/0x540
[ 4371.333732]  kthread+0x114/0x120
[ 4371.334535]  ret_from_fork+0x10/0x18
[ 4371.335440] Code: d63f0020 97f99963 17ffffa6 f8588263 (f9400061)
[ 4371.337174] ---[ end trace e250fe289272792a ]---
[ 4371.338365] Kernel panic - not syncing: Oops: Fatal exception
[ 4371.339884] SMP: stopping secondary CPUs
[ 4372.424137] SMP: failed to stop secondary CPUs 0-2
[ 4372.436894] Kernel Offset: 0x52a2e9fa0000 from 0xffff800010000000
[ 4372.438408] PHYS_OFFSET: 0xfff0defca0000000
[ 4372.439496] CPU features: 0x00200251,23200840
[ 4372.440603] Memory Limit: none
[ 4372.441374] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
```

