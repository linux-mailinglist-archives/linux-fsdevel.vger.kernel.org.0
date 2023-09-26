Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE877AE721
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 09:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjIZHvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 03:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZHvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B73092
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695714629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z51xRhqUyQXWCjjVRiDRVuBOf40rCLed/28H3cdbhJo=;
        b=hikJANnMLEJX5jAVzWLu4l4ydoQRDagUVtu2x2MCiclSqTrNqTiStwbD2HRpHOP9hj0nmT
        8djz9C2QfiXoB+fhqFrGt8JC6OIiLxGrw7jjrRCNE/1VjSGo0oI/+CXhcdbzNKobhGNONq
        iIvQACkQgJelw3DhN8ovqXIhAZnsa5s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383--IqSCv9EPHqQl8km_rFkJQ-1; Tue, 26 Sep 2023 03:50:28 -0400
X-MC-Unique: -IqSCv9EPHqQl8km_rFkJQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a9e12a3093so353858166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 00:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695714625; x=1696319425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z51xRhqUyQXWCjjVRiDRVuBOf40rCLed/28H3cdbhJo=;
        b=dE+K8pOBlKYvoq8T4LFHN+XKp8BVZlqvJsJ/6eOBW3EzxTxoJXpClC2d2v0kT5F22r
         bQYrVDgEcevL7MXPnWOzLgCTnl8naBLNR93u/DGc/sZCtRWm/nPpdRhKJ1MknjCtNscY
         istEHaAHRQP4wR930GrLPQUnVhHezYFwMqnedkihOfghos2C2BNOAv2gE4XS+kWmBY6I
         JCRVE5XmJ+Giyjdz9vHK4PBcBSBSdXqI/yjM2T/brfsn/7MZaLonIhwlCzCOCFLD8yat
         n1CWyHz+iqG/Hc/1IHiitYI4UAFPmXUoQPlSCmJ9z4e7u8gkTDdIQgc3KzWGvxkGidZy
         17oA==
X-Gm-Message-State: AOJu0YyUHkJsY24nKZSGkRXqRo6nuw5yMXRkvP2mtlknImYJq5SV1oXJ
        2X+APxhwl7qqePV8qI+/JmI1Bln3Go+ukYL6QpaXd6puFajfUuVVk3yITYfAPeUmwzMl6xYx5Hy
        pmrfg9/54PgnV2HepGcAFhE/yOxjlrZbt77G9lFWvqA==
X-Received: by 2002:a17:907:d94:b0:9a5:b247:3ab with SMTP id go20-20020a1709070d9400b009a5b24703abmr2990461ejc.19.1695714625204;
        Tue, 26 Sep 2023 00:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN3P2SZ9eOI9CyO/RXhC6HZ9CmqPWZ+cF35mDJB1r17cBrRQERDFjp8fQP/+BLtqQCcny4ow1EmLcxqbPj+Ok=
X-Received: by 2002:a17:907:d94:b0:9a5:b247:3ab with SMTP id
 go20-20020a1709070d9400b009a5b24703abmr2990436ejc.19.1695714624806; Tue, 26
 Sep 2023 00:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFLiB+J4mKGDOppp=1moMe2aNqeJhM9F2cD4KPTXoM6nzb5RA@mail.gmail.com>
 <ZRFbIJH47RkQuDid@debian.me> <20230925151236.GB11456@frogsfrogsfrogs>
In-Reply-To: <20230925151236.GB11456@frogsfrogsfrogs>
From:   Zhenyu Zhang <zhenyzha@redhat.com>
Date:   Tue, 26 Sep 2023 15:49:47 +0800
Message-ID: <CAJFLiBKQPOMmUPTAe-jHpPjLEx+X2ZNUKD20qXh4+0Ay+napDw@mail.gmail.com>
Subject: Re: Endless calls to xas_split_alloc() due to corrupted xarray entry
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guowen Shan <gshan@redhat.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Darrick,

The issue gets fixed in rc3. However, it seems not caused by commit
6d2779ecaeb56f9 because I can't reproduce the issue with rc3 and
the commit revert. I'm running 'git bisect' to nail it down. Hopefully,
I can identify the problematic commit soon.

On Mon, Sep 25, 2023 at 11:14=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Sep 25, 2023 at 05:04:16PM +0700, Bagas Sanjaya wrote:
> > On Fri, Sep 22, 2023 at 11:56:43AM +0800, Zhenyu Zhang wrote:
> > > Hi all,
> > >
> > > we don't know how the xarray entry was corrupted. Maybe it's a known
> > > issue to community.
> > > Lets see.
> > >
> > > Contents
> > > --------
> > > 1. Problem Statement
> > > 2. The call trace
> > > 3. The captured data by bpftrace
> > >
> > >
> > > 1. Problem Statement
> > > --------------------
> > > With 4k guest and 64k host, on aarch64(Ampere's Altra Max CPU) hit Ca=
ll trace:
> > >     Steps:
> > >     1) System setup hugepages on host.
> > >        # echo 60 > /proc/sys/vm/nr_hugepages
> > >     2) Mount this hugepage to /mnt/kvm_hugepage.
> > >        # mount -t hugetlbfs -o pagesize=3D524288K none /mnt/kvm_hugep=
age
> >
> > What block device/disk image you use to format the filesystem?
> >
> > >     3) HugePages didn't leak when using non-existent mem-path.
> > >        # mkdir -p /mnt/tmp
> > >     4) Boot guest.
> > >        # /usr/libexec/qemu-kvm \
> > > ...
> > >          -m 30720 \
> > > -object '{"size": 32212254720, "mem-path": "/mnt/tmp", "qom-type":
> > > "memory-backend-file"}'  \
> > > -smp 4,maxcpus=3D4,cores=3D2,threads=3D1,clusters=3D1,sockets=3D2  \
> > >          -blockdev '{"node-name": "file_image1", "driver": "file",
> > > "auto-read-only": true, "discard": "unmap", "aio": "threads",
> > > "filename": "/home/kvm_autotest_root/images/back_up_4k.qcow2",
> > > "cache": {"direct": true, "no-flush": false}}' \
> > > -blockdev '{"node-name": "drive_image1", "driver": "qcow2",
> > > "read-only": false, "cache": {"direct": true, "no-flush": false},
> > > "file": "file_image1"}' \
> > > -device '{"driver": "scsi-hd", "id": "image1", "drive":
> > > "drive_image1", "write-cache": "on"}' \
> > >
> > >     5) Wait about 1 minute ------> hit Call trace
> > >
> > > 2. The call trace
> > > --------------------
> > > [   14.982751] block dm-0: the capability attribute has been deprecat=
ed.
> > > [   15.690043] PEFILE: Unsigned PE binary
> > >
> > >
> > > [   90.135676] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [   90.136629] rcu: 3-...0: (3 ticks this GP)
> > > idle=3De6ec/1/0x4000000000000000 softirq=3D6847/6849 fqs=3D232
> > > [   90.137293] rcu: (detected by 2, t=3D6012 jiffies, g=3D2085, q=3D2=
539 ncpus=3D4)
> > > [   90.137796] Task dump for CPU 3:
> > > [   90.138037] task:PK-Backend      state:R  running task     stack:0
> > >    pid:2287  ppid:1      flags:0x00000202
> > > [   90.138757] Call trace:
> > > [   90.138940]  __switch_to+0xc8/0x110
> > > [   90.139203]  0xb54a54f8c5fb0700
> > >
> > > [  270.190849] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [  270.191722] rcu: 3-...0: (3 ticks this GP)
> > > idle=3De6ec/1/0x4000000000000000 softirq=3D6847/6849 fqs=3D1020
> > > [  270.192405] rcu: (detected by 1, t=3D24018 jiffies, g=3D2085, q=3D=
3104 ncpus=3D4)
> > > [  270.192876] Task dump for CPU 3:
> > > [  270.193099] task:PK-Backend      state:R  running task     stack:0
> > >    pid:2287  ppid:1      flags:0x00000202
> > > [  270.193774] Call trace:
> > > [  270.193946]  __switch_to+0xc8/0x110
> > > [  270.194336]  0xb54a54f8c5fb0700
> > >
> > > [ 1228.068406] ------------[ cut here ]------------
> > > [ 1228.073011] WARNING: CPU: 2 PID: 4496 at lib/xarray.c:1010
> > > xas_split_alloc+0xf8/0x128
> > > [ 1228.080828] Modules linked in: binfmt_misc vhost_net vhost
> > > vhost_iotlb tap xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
> > > nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack
> > > nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc
> > > qrtr rfkill sunrpc vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu
> > > ipmi_devintf arm_cmn arm_dmc620_pmu ipmi_msghandler cppc_cpufreq
> > > arm_dsu_pmu xfs libcrc32c ast drm_shmem_helper drm_kms_helper drm
> > > crct10dif_ce ghash_ce igb nvme sha2_ce nvme_core sha256_arm64 sha1_ce
> > > i2c_designware_platform sbsa_gwdt nvme_common i2c_algo_bit
> > > i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mo=
d
> > > fuse
> > > [ 1228.137630] CPU: 2 PID: 4496 Comm: qemu-kvm Kdump: loaded Tainted:
> > > G        W          6.6.0-rc2-zhenyzha+ #5
>
> Please try 6.6-rc3, which doesn't have broken bit spinlocks (and hence
> corruption problems in the vfs) on arm64.
>
> (See commit 6d2779ecaeb56f9 "locking/atomic: scripts: fix fallback
> ifdeffery")
>
> --D
>
> > > [ 1228.147529] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
> > > F31h (SCP: 2.10.20220810) 07/27/2022
> > > [ 1228.156820] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> > > [ 1228.163767] pc : xas_split_alloc+0xf8/0x128
> > > [ 1228.167938] lr : __filemap_add_folio+0x33c/0x4e0
> > > [ 1228.172543] sp : ffff80008dd4f1c0
> > > [ 1228.175844] x29: ffff80008dd4f1c0 x28: ffffd15825388c40 x27: 00000=
00000000001
> > > [ 1228.182967] x26: 0000000000000001 x25: ffffffffffffc005 x24: 00000=
00000000000
> > > [ 1228.190089] x23: ffff80008dd4f270 x22: ffffffc202b00000 x21: 00000=
00000000000
> > > [ 1228.197211] x20: ffffffc2007f9600 x19: 000000000000000d x18: 00000=
00000000014
> > > [ 1228.204334] x17: 00000000b21b8a3f x16: 0000000013a8aa94 x15: ffffd=
15824625944
> > > [ 1228.211456] x14: ffffffffffffffff x13: 0000000000000030 x12: 01010=
10101010101
> > > [ 1228.218578] x11: 7f7f7f7f7f7f7f7f x10: 000000000000000a x9 : ffffd=
158252dd3fc
> > > [ 1228.225701] x8 : ffff80008dd4f1c0 x7 : ffff07ffa0945468 x6 : ffff8=
0008dd4f1c0
> > > [ 1228.232823] x5 : 0000000000000018 x4 : 0000000000000000 x3 : 00000=
00000012c40
> > > [ 1228.239945] x2 : 000000000000000d x1 : 000000000000000c x0 : 00000=
00000000000
> > > [ 1228.247067] Call trace:
> > > [ 1228.249500]  xas_split_alloc+0xf8/0x128
> > > [ 1228.253324]  __filemap_add_folio+0x33c/0x4e0
> > > [ 1228.257582]  filemap_add_folio+0x48/0xd0
> > > [ 1228.261493]  page_cache_ra_order+0x214/0x310
> > > [ 1228.265750]  ondemand_readahead+0x1a8/0x320
> > > [ 1228.269921]  page_cache_async_ra+0x64/0xa8
> > > [ 1228.274005]  filemap_fault+0x238/0xaa8
> > > [ 1228.277742]  __xfs_filemap_fault+0x60/0x3c0 [xfs]
> > > [ 1228.282491]  xfs_filemap_fault+0x54/0x68 [xfs]
> > > [ 1228.286979]  __do_fault+0x40/0x210
> > > [ 1228.290368]  do_cow_fault+0xf0/0x300
> > > [ 1228.293931]  do_pte_missing+0x140/0x238
> > > [ 1228.297754]  handle_pte_fault+0x100/0x160
> > > [ 1228.301751]  __handle_mm_fault+0x100/0x310
> > > [ 1228.305835]  handle_mm_fault+0x6c/0x270
> > > [ 1228.309659]  faultin_page+0x70/0x128
> > > [ 1228.313221]  __get_user_pages+0xc8/0x2d8
> > > [ 1228.317131]  get_user_pages_unlocked+0xc4/0x3b8
> > > [ 1228.321648]  hva_to_pfn+0xf8/0x468
> > > [ 1228.325037]  __gfn_to_pfn_memslot+0xa4/0xf8
> > > [ 1228.329207]  user_mem_abort+0x174/0x7e8
> > > [ 1228.333031]  kvm_handle_guest_abort+0x2dc/0x450
> > > [ 1228.337548]  handle_exit+0x70/0x1c8
> > > [ 1228.341024]  kvm_arch_vcpu_ioctl_run+0x224/0x5b8
> > > [ 1228.345628]  kvm_vcpu_ioctl+0x28c/0x9d0
> > > [ 1228.349450]  __arm64_sys_ioctl+0xa8/0xf0
> > > [ 1228.353360]  invoke_syscall.constprop.0+0x7c/0xd0
> > > [ 1228.358052]  do_el0_svc+0xb4/0xd0
> > > [ 1228.361354]  el0_svc+0x50/0x228
> > > [ 1228.364484]  el0t_64_sync_handler+0x134/0x150
> > > [ 1228.368827]  el0t_64_sync+0x17c/0x180
> > > [ 1228.372476] ---[ end trace 0000000000000000 ]---
> > > [ 1228.377124] ------------[ cut here ]------------
> > > [ 1228.381728] WARNING: CPU: 2 PID: 4496 at lib/xarray.c:1010
> > > xas_split_alloc+0xf8/0x128
> > > [ 1228.389546] Modules linked in: binfmt_misc vhost_net vhost
> > > vhost_iotlb tap xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
> > > nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack
> > > nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc
> > > qrtr rfkill sunrpc vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu
> > > ipmi_devintf arm_cmn arm_dmc620_pmu ipmi_msghandler cppc_cpufreq
> > > arm_dsu_pmu xfs libcrc32c ast drm_shmem_helper drm_kms_helper drm
> > > crct10dif_ce ghash_ce igb nvme sha2_ce nvme_core sha256_arm64 sha1_ce
> > > i2c_designware_platform sbsa_gwdt nvme_common i2c_algo_bit
> > > i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mo=
d
> > > fuse
> > > [ 1228.446348] CPU: 2 PID: 4496 Comm: qemu-kvm Kdump: loaded Tainted:
> > > G        W          6.6.0-rc2-zhenyzha+ #5
> > > [ 1228.456248] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
> > > F31h (SCP: 2.10.20220810) 07/27/2022
> > > [ 1228.465538] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> > > [ 1228.472486] pc : xas_split_alloc+0xf8/0x128
> > > [ 1228.476656] lr : __filemap_add_folio+0x33c/0x4e0
> > > [ 1228.481261] sp : ffff80008dd4f1c0
> > > [ 1228.484563] x29: ffff80008dd4f1c0 x28: ffffd15825388c40 x27: 00000=
00000000001
> > > [ 1228.491685] x26: 0000000000000001 x25: ffffffffffffc005 x24: 00000=
00000000000
> > > [ 1228.498807] x23: ffff80008dd4f270 x22: ffffffc202b00000 x21: 00000=
00000000000
> > > [ 1228.505930] x20: ffffffc2007f9600 x19: 000000000000000d x18: 00000=
00000000014
> > > [ 1228.513052] x17: 00000000b21b8a3f x16: 0000000013a8aa94 x15: ffffd=
15824625944
> > > [ 1228.520174] x14: ffffffffffffffff x13: 0000000000000030 x12: 01010=
10101010101
> > > [ 1228.527297] x11: 7f7f7f7f7f7f7f7f x10: 000000000000000a x9 : ffffd=
158252dd3fc
> > > [ 1228.534419] x8 : ffff80008dd4f1c0 x7 : ffff07ffa0945468 x6 : ffff8=
0008dd4f1c0
> > > [ 1228.541542] x5 : 0000000000000018 x4 : 0000000000000000 x3 : 00000=
00000012c40
> > > [ 1228.548664] x2 : 000000000000000d x1 : 000000000000000c x0 : 00000=
00000000000
> > > [ 1228.555786] Call trace:
> > > [ 1228.558220]  xas_split_alloc+0xf8/0x128
> > > [ 1228.562043]  __filemap_add_folio+0x33c/0x4e0
> > > [ 1228.566300]  filemap_add_folio+0x48/0xd0
> > > [ 1228.570211]  page_cache_ra_order+0x214/0x310
> > > [ 1228.574469]  ondemand_readahead+0x1a8/0x320
> > > [ 1228.578639]  page_cache_async_ra+0x64/0xa8
> > > [ 1228.582724]  filemap_fault+0x238/0xaa8
> > > [ 1228.586460]  __xfs_filemap_fault+0x60/0x3c0 [xfs]
> > > [ 1228.591210]  xfs_filemap_fault+0x54/0x68 [xfs]
> > >
> > >
> > >
> > > 3. The captured data by bpftrace
> > > (The following part is the crawl analysis of gshan@redhat.com )
> > > --------------------
> > > pid:  4475    task: qemu-kvm
> > > file: /mnt/tmp/qemu_back_mem.mem-machine_mem.OdGYet (deleted)
> > >
> > > -------------------- inode --------------------
> > > i_flags:               0x0
> > > i_ino:                 67333199
> > > i_size:                32212254720
> > >
> > > ----------------- address_space ----------------
> > > flags:                 040
> > > invalidate_lock
> > >   count:               256
> > >   owner:               0xffff07fff6e759c1
> > >     pid: 4496  task: qemu-kvm
> > >   wait_list.next:      0xffff07ffa20422e0
> > >   wait_list.prev:      0xffff07ffa20422e0
> > >
> > > -------------------- xarray --------------------
> > > entry[0]:       0xffff080f7eda0002
> > > shift:          18
> > > offset:         0
> > > count:          2
> > > nr_values:      0
> > > parent:         0x0
> > > slots[00]:      0xffff07ffa094546a
> > > slots[01]:      0xffff07ffa1b09b22
> > >
> > > entry[1]:       0xffff07ffa094546a
> > > shift:          12
> > > offset:         0
> > > count:          20
> > > nr_values:      0
> > > parent:         0xffff080f7eda0000
> > > slots[00]:      0xffffffc202880000
> > > slots[01]:      0x2
> > >
> > > entry[2]:       0xffffffc202880000
> > > shift:          104
> > > offset:         128
> > > count:          0
> > > nr_values:      0
> > > parent:         0xffffffc20304c888
> > > slots[00]:      0xffff08009a960000
> > > slots[01]:      0x2001ffffffff
> > >
> > > It seems the last xarray entry ("entry[2]") has been corrupted. "shif=
t"
> > > becomes 104 and "offset" becomes 128, which isn't reasonable.
> > > It's explaining why we run into xas_split_alloc() in __filemap_add_fo=
lio()
> > >
> > >         if (order > folio_order(folio))
> > >                 xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
> > >                                 order, gfp);
> > >
> > > folio_order(folio) is likely 6 since the readahead window size on the=
 BDI device
> > > is 4MB.
> > > However, @order figured from the corrupted xarray entry is much large=
r than 6.
> > > log2(0x400000 / 0x10000) =3D log2(64) =3D 6
> > >
> > > [root@ampere-mtsnow-altramax-28 ~]# uname -r
> > > 6.6.0-rc2-zhenyzha+
> >
> > What commit/tree?
> >
> > > [root@ampere-mtsnow-altramax-28 ~]# cat
> > > /sys/devices/virtual/bdi/253:0/read_ahead_kb
> > > 4096
> > >
> >
> > I'm confused...
> >
> > --
> > An old man doll... just what I always wanted! - Clara
>
>

