Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535767B3D82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 04:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjI3CNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 22:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3CNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 22:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137EF1B2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 19:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696039937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uz9zDj0/dSUUJEbYZHeXOoVvSMTWtqtlQTW900AFqbk=;
        b=HeeCcY77yWD6YO3mLFPHeqDJ0H345Sbs2+nq2zqJKAyQjv39nAtTA/Yud1fdhlHrB+kAkt
        CNB4J7eV8KF1MbSYlLsRsuP/B/UAdxe/K6a+0aQigspvKEJHZgZVu4HCwF2uhekIzfQw9g
        dTbMzB71JV3fY7mCAsadRZJNfXbB6so=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-LEp7Uf8yMgigBc4OHvPFww-1; Fri, 29 Sep 2023 22:12:15 -0400
X-MC-Unique: LEp7Uf8yMgigBc4OHvPFww-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-570096f51acso955750a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 19:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696039929; x=1696644729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz9zDj0/dSUUJEbYZHeXOoVvSMTWtqtlQTW900AFqbk=;
        b=L+oOHik/DVBreqvhRh7y6dghj/8N+6EX9Lc2XupRerFnQF8b/rpMSWcBoxSaaXHDA3
         q+Ye8MORayK3RWSFAR63ZyNjg85coJWHmHFme62F4Zi/m8GjWq4/cfCn0doTjtfVszGL
         0z5CKWyf4u4vtDbXha1gMg/m/UE6eieMDXbtsAY6+CMwCq8ouoRPc3TYhqjTbVMxx53B
         A5hIUymkMu6sPAPjpXG7/BhxOf1Vo4UHMszF5NypSv2+s6D3BM1QyFDAx/3inOLIsMxr
         T8VZOjXMg3hpx9AYhFywq9TrjCVFWHpwLj1kfH2xBaipCwDVA7M16lB+nablFbMNMdG9
         jHWw==
X-Gm-Message-State: AOJu0YzzL8eQJlmxHPK+f9z/BCrgWa7EysOiC+szvoeLarS/1iJpmPIm
        Oca7OxIFRN81xJ2dX/sNS6VCcQ/ZJMcbHBFSqq7uuMcs/PVJ+tE1diFmmQnZcMNtp1lDc7rohwN
        W85tqX4ghItJNMpnq2MjfPCZF7w==
X-Received: by 2002:a17:902:e5d1:b0:1c3:e5bf:a9fe with SMTP id u17-20020a170902e5d100b001c3e5bfa9femr9645141plf.30.1696039928985;
        Fri, 29 Sep 2023 19:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF38Z7llet9+xDSgYMVjkTtdq5jBpTRh8NBrzeq12i052boiDTK+d9vY7qKX6+y9J1PHV7X+A==
X-Received: by 2002:a17:902:e5d1:b0:1c3:e5bf:a9fe with SMTP id u17-20020a170902e5d100b001c3e5bfa9femr9645114plf.30.1696039928551;
        Fri, 29 Sep 2023 19:12:08 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902748200b001c60e7bf5besm11924031pll.281.2023.09.29.19.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 19:12:07 -0700 (PDT)
Message-ID: <91bceeda-7964-2509-a1f1-4a2be49ebc60@redhat.com>
Date:   Sat, 30 Sep 2023 12:12:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Endless calls to xas_split_alloc() due to corrupted xarray entry
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Zhenyu Zhang <zhenyzha@redhat.com>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shaoqin Huang <shahuang@redhat.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAJFLiB+J4mKGDOppp=1moMe2aNqeJhM9F2cD4KPTXoM6nzb5RA@mail.gmail.com>
 <ZRFbIJH47RkQuDid@debian.me> <ZRci1L6qneuZA4mo@casper.infradead.org>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZRci1L6qneuZA4mo@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On 9/30/23 05:17, Matthew Wilcox wrote:
> On Mon, Sep 25, 2023 at 05:04:16PM +0700, Bagas Sanjaya wrote:
>> On Fri, Sep 22, 2023 at 11:56:43AM +0800, Zhenyu Zhang wrote:
>>> Hi all,
>>>
>>> we don't know how the xarray entry was corrupted. Maybe it's a known
>>> issue to community.
>>> Lets see.
>>>
>>> Contents
>>> --------
>>> 1. Problem Statement
>>> 2. The call trace
>>> 3. The captured data by bpftrace
>>>
>>>
>>> 1. Problem Statement
>>> --------------------
>>> With 4k guest and 64k host, on aarch64(Ampere's Altra Max CPU) hit Call trace:
>>>      Steps:
>>>      1) System setup hugepages on host.
>>>         # echo 60 > /proc/sys/vm/nr_hugepages
>>>      2) Mount this hugepage to /mnt/kvm_hugepage.
>>>         # mount -t hugetlbfs -o pagesize=524288K none /mnt/kvm_hugepage
>>
>> What block device/disk image you use to format the filesystem?
> 
> It's hugetlbfs, Bagas.
> 

The hugetlbfs pages are reserved, but never used. In this way, the available
system memory is reduced. So it's same affect as to "mem=xxx" boot parameter.

>>>      3) HugePages didn't leak when using non-existent mem-path.
>>>         # mkdir -p /mnt/tmp
>>>      4) Boot guest.
>>>         # /usr/libexec/qemu-kvm \
>>> ...
>>>           -m 30720 \
>>> -object '{"size": 32212254720, "mem-path": "/mnt/tmp", "qom-type":
>>> "memory-backend-file"}'  \
>>> -smp 4,maxcpus=4,cores=2,threads=1,clusters=1,sockets=2  \
>>>           -blockdev '{"node-name": "file_image1", "driver": "file",
>>> "auto-read-only": true, "discard": "unmap", "aio": "threads",
>>> "filename": "/home/kvm_autotest_root/images/back_up_4k.qcow2",
>>> "cache": {"direct": true, "no-flush": false}}' \
>>> -blockdev '{"node-name": "drive_image1", "driver": "qcow2",
>>> "read-only": false, "cache": {"direct": true, "no-flush": false},
>>> "file": "file_image1"}' \
>>> -device '{"driver": "scsi-hd", "id": "image1", "drive":
>>> "drive_image1", "write-cache": "on"}' \
>>>
>>>      5) Wait about 1 minute ------> hit Call trace
>>>
>>> 2. The call trace
>>> --------------------
>>> [   14.982751] block dm-0: the capability attribute has been deprecated.
>>> [   15.690043] PEFILE: Unsigned PE binary
>>>
>>>
>>> [   90.135676] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>> [   90.136629] rcu: 3-...0: (3 ticks this GP)
>>> idle=e6ec/1/0x4000000000000000 softirq=6847/6849 fqs=232
>>> [   90.137293] rcu: (detected by 2, t=6012 jiffies, g=2085, q=2539 ncpus=4)
>>> [   90.137796] Task dump for CPU 3:
>>> [   90.138037] task:PK-Backend      state:R  running task     stack:0
>>>     pid:2287  ppid:1      flags:0x00000202
>>> [   90.138757] Call trace:
>>> [   90.138940]  __switch_to+0xc8/0x110
>>> [   90.139203]  0xb54a54f8c5fb0700
>>>
>>> [  270.190849] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>> [  270.191722] rcu: 3-...0: (3 ticks this GP)
>>> idle=e6ec/1/0x4000000000000000 softirq=6847/6849 fqs=1020
>>> [  270.192405] rcu: (detected by 1, t=24018 jiffies, g=2085, q=3104 ncpus=4)
>>> [  270.192876] Task dump for CPU 3:
>>> [  270.193099] task:PK-Backend      state:R  running task     stack:0
>>>     pid:2287  ppid:1      flags:0x00000202
>>> [  270.193774] Call trace:
>>> [  270.193946]  __switch_to+0xc8/0x110
>>> [  270.194336]  0xb54a54f8c5fb0700
>>>
>>> [ 1228.068406] ------------[ cut here ]------------
>>> [ 1228.073011] WARNING: CPU: 2 PID: 4496 at lib/xarray.c:1010
>>> xas_split_alloc+0xf8/0x128
>>> [ 1228.080828] Modules linked in: binfmt_misc vhost_net vhost
>>> vhost_iotlb tap xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
>>> nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack
>>> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc
>>> qrtr rfkill sunrpc vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu
>>> ipmi_devintf arm_cmn arm_dmc620_pmu ipmi_msghandler cppc_cpufreq
>>> arm_dsu_pmu xfs libcrc32c ast drm_shmem_helper drm_kms_helper drm
>>> crct10dif_ce ghash_ce igb nvme sha2_ce nvme_core sha256_arm64 sha1_ce
>>> i2c_designware_platform sbsa_gwdt nvme_common i2c_algo_bit
>>> i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod
>>> fuse
>>> [ 1228.137630] CPU: 2 PID: 4496 Comm: qemu-kvm Kdump: loaded Tainted:
>>> G        W          6.6.0-rc2-zhenyzha+ #5
>>> [ 1228.147529] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
>>> F31h (SCP: 2.10.20220810) 07/27/2022
>>> [ 1228.156820] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [ 1228.163767] pc : xas_split_alloc+0xf8/0x128
>>> [ 1228.167938] lr : __filemap_add_folio+0x33c/0x4e0
>>> [ 1228.172543] sp : ffff80008dd4f1c0
>>> [ 1228.175844] x29: ffff80008dd4f1c0 x28: ffffd15825388c40 x27: 0000000000000001
>>> [ 1228.182967] x26: 0000000000000001 x25: ffffffffffffc005 x24: 0000000000000000
>>> [ 1228.190089] x23: ffff80008dd4f270 x22: ffffffc202b00000 x21: 0000000000000000
>>> [ 1228.197211] x20: ffffffc2007f9600 x19: 000000000000000d x18: 0000000000000014
>>> [ 1228.204334] x17: 00000000b21b8a3f x16: 0000000013a8aa94 x15: ffffd15824625944
>>> [ 1228.211456] x14: ffffffffffffffff x13: 0000000000000030 x12: 0101010101010101
>>> [ 1228.218578] x11: 7f7f7f7f7f7f7f7f x10: 000000000000000a x9 : ffffd158252dd3fc
>>> [ 1228.225701] x8 : ffff80008dd4f1c0 x7 : ffff07ffa0945468 x6 : ffff80008dd4f1c0
>>> [ 1228.232823] x5 : 0000000000000018 x4 : 0000000000000000 x3 : 0000000000012c40
>>> [ 1228.239945] x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
>>> [ 1228.247067] Call trace:
>>> [ 1228.249500]  xas_split_alloc+0xf8/0x128
>>> [ 1228.253324]  __filemap_add_folio+0x33c/0x4e0
>>> [ 1228.257582]  filemap_add_folio+0x48/0xd0
>>> [ 1228.261493]  page_cache_ra_order+0x214/0x310
>>> [ 1228.265750]  ondemand_readahead+0x1a8/0x320
>>> [ 1228.269921]  page_cache_async_ra+0x64/0xa8
>>> [ 1228.274005]  filemap_fault+0x238/0xaa8
>>> [ 1228.277742]  __xfs_filemap_fault+0x60/0x3c0 [xfs]
>>> [ 1228.282491]  xfs_filemap_fault+0x54/0x68 [xfs]
> 
> This is interesting.  This path has nothing to do with the hugetlbfs
> filesystem you've created up above.  And, just to be clear, this is
> on the host, not in the guest, right?
> 

Correct, the backtrce is seen on the host. The XFS file is used as backup
memory to the guest. QEMU maps the entire file as PRIVATE and the VMA has
been advised to huge page by madvise(MADV_HUGEPAGE). When the guest is
started, QEMU calls madvise(MADV_POPULATE_WRITE) to populate the VMA. Since
the VMA is private, there are copy-on-write page fault happening on
calling to madvise(MADV_POPULATE_WRITE). In the page fault handler,
there are readahead reuqests to be processed.

The backtrace, originating from WARN_ON(), is triggered when attempt to
allocate a huge page fails in the middle of readahead. In this specific
case, we're falling back to order-0 with attempt to modify the xarray
for this. Unfortunately, it's reported this particular scenario isn't
supported by xas_split_alloc().


>>> [ 1228.377124] ------------[ cut here ]------------
>>> [ 1228.381728] WARNING: CPU: 2 PID: 4496 at lib/xarray.c:1010
>>> xas_split_alloc+0xf8/0x128
>>> [ 1228.389546] Modules linked in: binfmt_misc vhost_net vhost
>>> vhost_iotlb tap xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
>>> nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack
>>> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc
>>> qrtr rfkill sunrpc vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu
>>> ipmi_devintf arm_cmn arm_dmc620_pmu ipmi_msghandler cppc_cpufreq
>>> arm_dsu_pmu xfs libcrc32c ast drm_shmem_helper drm_kms_helper drm
>>> crct10dif_ce ghash_ce igb nvme sha2_ce nvme_core sha256_arm64 sha1_ce
>>> i2c_designware_platform sbsa_gwdt nvme_common i2c_algo_bit
>>> i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod
>>> fuse
>>> [ 1228.446348] CPU: 2 PID: 4496 Comm: qemu-kvm Kdump: loaded Tainted:
>>> G        W          6.6.0-rc2-zhenyzha+ #5
>>> [ 1228.456248] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
>>> F31h (SCP: 2.10.20220810) 07/27/2022
>>> [ 1228.465538] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [ 1228.472486] pc : xas_split_alloc+0xf8/0x128
>>> [ 1228.476656] lr : __filemap_add_folio+0x33c/0x4e0
>>> [ 1228.481261] sp : ffff80008dd4f1c0
>>> [ 1228.484563] x29: ffff80008dd4f1c0 x28: ffffd15825388c40 x27: 0000000000000001
>>> [ 1228.491685] x26: 0000000000000001 x25: ffffffffffffc005 x24: 0000000000000000
>>> [ 1228.498807] x23: ffff80008dd4f270 x22: ffffffc202b00000 x21: 0000000000000000
>>> [ 1228.505930] x20: ffffffc2007f9600 x19: 000000000000000d x18: 0000000000000014
>>> [ 1228.513052] x17: 00000000b21b8a3f x16: 0000000013a8aa94 x15: ffffd15824625944
>>> [ 1228.520174] x14: ffffffffffffffff x13: 0000000000000030 x12: 0101010101010101
>>> [ 1228.527297] x11: 7f7f7f7f7f7f7f7f x10: 000000000000000a x9 : ffffd158252dd3fc
>>> [ 1228.534419] x8 : ffff80008dd4f1c0 x7 : ffff07ffa0945468 x6 : ffff80008dd4f1c0
>>> [ 1228.541542] x5 : 0000000000000018 x4 : 0000000000000000 x3 : 0000000000012c40
>>> [ 1228.548664] x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
>>> [ 1228.555786] Call trace:
>>> [ 1228.558220]  xas_split_alloc+0xf8/0x128
>>> [ 1228.562043]  __filemap_add_folio+0x33c/0x4e0
>>> [ 1228.566300]  filemap_add_folio+0x48/0xd0
>>> [ 1228.570211]  page_cache_ra_order+0x214/0x310
>>> [ 1228.574469]  ondemand_readahead+0x1a8/0x320
>>> [ 1228.578639]  page_cache_async_ra+0x64/0xa8
>>> [ 1228.582724]  filemap_fault+0x238/0xaa8
>>> [ 1228.586460]  __xfs_filemap_fault+0x60/0x3c0 [xfs]
>>> [ 1228.591210]  xfs_filemap_fault+0x54/0x68 [xfs]
>>>
>>>
>>>
>>> 3. The captured data by bpftrace
>>> (The following part is the crawl analysis of gshan@redhat.com )
>>> --------------------
>>> pid:  4475    task: qemu-kvm
>>> file: /mnt/tmp/qemu_back_mem.mem-machine_mem.OdGYet (deleted)
>>>
>>> -------------------- inode --------------------
>>> i_flags:               0x0
>>> i_ino:                 67333199
>>> i_size:                32212254720
>>>
>>> ----------------- address_space ----------------
>>> flags:                 040
>>> invalidate_lock
>>>    count:               256
>>>    owner:               0xffff07fff6e759c1
>>>      pid: 4496  task: qemu-kvm
>>>    wait_list.next:      0xffff07ffa20422e0
>>>    wait_list.prev:      0xffff07ffa20422e0
>>>
>>> -------------------- xarray --------------------
>>> entry[0]:       0xffff080f7eda0002
>>> shift:          18
>>> offset:         0
>>> count:          2
>>> nr_values:      0
>>> parent:         0x0
>>> slots[00]:      0xffff07ffa094546a
>>> slots[01]:      0xffff07ffa1b09b22
>>>
>>> entry[1]:       0xffff07ffa094546a
>>> shift:          12
>>> offset:         0
>>> count:          20
>>> nr_values:      0
>>> parent:         0xffff080f7eda0000
>>> slots[00]:      0xffffffc202880000
>>> slots[01]:      0x2
>>>
>>> entry[2]:       0xffffffc202880000
>>> shift:          104
>>> offset:         128
>>> count:          0
>>> nr_values:      0
>>> parent:         0xffffffc20304c888
>>> slots[00]:      0xffff08009a960000
>>> slots[01]:      0x2001ffffffff
>>>
>>> It seems the last xarray entry ("entry[2]") has been corrupted. "shift"
>>> becomes 104 and "offset" becomes 128, which isn't reasonable.
> 
> Um, no.  Whatever tool you're using doesn't understand how XArrays work.
> Fortunately, I wrote xa_dump() which does.  entry[2] does not have bit
> 1 set, so it is an entry, not a node.  You're dereferencing a pointer to
> a folio as if it's a pointer to a node, so no wonder it looks corrupted
> to you.  From this, we know that the folio is at least order-6, and it's
> probably order-9 (because I bet this VMA has the VM_HUGEPAGE flag set,
> and we're doing PMD-sized faults).
> 

Indeed, entry[2] is a entry instead of a node, deferencing a folio.
bpftrace was used to dump the xarray. you're correct that the VMA has
flag VM_HUGEPAGE, set by madvise(MADV_HUGEPAGE). The order returned by
xas_get_order() is 13, passed to xas_split_alloc().

/*
  * xas->xa_shift    = 0
  * XA_CHUNK_SHIFT   = 6
  * order            = 13      (512MB huge page size vs 64KB base page size)
  */
void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
                 gfp_t gfp)
{
         unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
         unsigned int mask = xas->xa_sibs;

         /* XXX: no support for splitting really large entries yet */
         if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT < order))
                 goto nomem;
         :
}

I've shared a simplified reproducer in another reply. In that reproducer,
we just run a program in a memroy cgroup, where the memory space is limited.
The program mimics what QEMU does. The similar backtrace can be seen.

Thanks,
Gavin

