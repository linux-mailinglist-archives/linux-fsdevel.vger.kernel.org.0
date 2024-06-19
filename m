Return-Path: <linux-fsdevel+bounces-21915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD67B90E73C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 11:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CB31F22861
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441C7BB13;
	Wed, 19 Jun 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAdV2xvu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5BD6F2E4
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790331; cv=none; b=eB57d81h4RklmjcOU9hqAD1B7JoV46UBojucHfsVa9exi66pZU2WjlJNVTMJm6qEzoW4KDupsuAEGaNw0SEi/Hd3xcuMmccKJsif5Y26wosAiCjhtw8s9g+SLqVH2Yp6yivmgmqMQdvCe1Vr0r9zQiUzFVFlG8+f9Ckjziyoy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790331; c=relaxed/simple;
	bh=5jgnhsUy5Kli1NSQsSj3Nk8h8zvWNrUuj/LCKAOqNos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOumqJ12u+cWPBzr9mWacTG8iNPCOqgTvVfx02QrXgF6jlwjLinaUbhaKJhS6+amfFJ1rF5TJLDLxgfT9NJG/dHprRMgqbfrAumYHzlMIzANaD9EHBuzTsVhvp5rx9HSHlzAejP132kH/kM7SMQLh/iqTCrsGru0GGBpBXiVddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAdV2xvu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718790327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O243OS1BRlXQHpKJHhOKa16DeG5iGbOGYwgIlaIyaCc=;
	b=QAdV2xvu/oWYCh2qzNe9/j15FVzY3QcKk62qaaBDdTMjz4AiaDxGhH2gTJhjK5Iym3g0XP
	Siev8EFcCXUrJ38vghZhV0uO3aDwI/FuY1Rpbm8HPsk1QTqHg9FvSf7nufxOy1EV3ZTTy3
	QwsI5E+5nEaenSa69PEo2dcfmlcjJUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-30i6VNoCPSa0xgAwmbSgiQ-1; Wed, 19 Jun 2024 05:45:26 -0400
X-MC-Unique: 30i6VNoCPSa0xgAwmbSgiQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42181c64596so38356055e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 02:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718790325; x=1719395125;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O243OS1BRlXQHpKJHhOKa16DeG5iGbOGYwgIlaIyaCc=;
        b=p1785hL3PKhJ8qtXarwDqJ3VEMP5rNONU/GJv34P0+KBWGa2OUQLLM+btTj8YSq3z6
         n3fWiXO5TSR1QqjRjkpKR6ofz0FFQ2eWvc9UZW9EjMnSLiN+s2GXx5iEyejVFzGppdWw
         q6QToTZfjd3R3ldGBhCAtDAMydSRwxyvs8wFDwwMFD0ng86wW534uEziX56q0/E9OCCS
         s1OJA2fwzDwYbPaL5ux8dOhaVCveL+rfxH1lA4byWPysXFPGl2H6Q/XNvz5nhEfIqfl1
         dlPElVoWjjheXXre14r+He53wL5xRUQafUx2pemHbdB5jGKRp/KqhKf0HsM7/HhgOYKC
         miQg==
X-Forwarded-Encrypted: i=1; AJvYcCVwZiS6EacZ2UBIUzPi76kA057VUz1Q0aoOcooX6BJTIS4ZHOTx0q/AnvcA/Fnj4s7wIoqe2VcQi2MVHOMPv6EQkRAW4FOd65d0HsleYg==
X-Gm-Message-State: AOJu0Yw4PmvkFpi6rkbyEyk/KD0h050sY7ZppUkp0eQ6Z0bsRjUPTSSH
	BvaAVznJQn0OIgD3uO/PbZ278BfPUcskkJ8oLl/dAfHOOHP1pXfZinp8zcJ0T+W/GsgINSLHZI4
	Xr8uyYWyKNmj+4wm+PIZkIu8gjVpCVofbCVPnRhz2C15swRNPUdvbm13Vw/9p/Uc=
X-Received: by 2002:a05:600c:418b:b0:424:78c5:c55d with SMTP id 5b1f17b1804b1-42478c5c5e3mr5878585e9.12.1718790325103;
        Wed, 19 Jun 2024 02:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAFccat0/5fKdTmB5A+CuG5lim3ykA07VjjB36+Ceb9p2ug3FpJa59K+ioDtTzPrLitxfdyg==
X-Received: by 2002:a05:600c:418b:b0:424:78c5:c55d with SMTP id 5b1f17b1804b1-42478c5c5e3mr5878375e9.12.1718790324528;
        Wed, 19 Jun 2024 02:45:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ab00:f9b6:da12:cad4:6642? (p200300cbc705ab00f9b6da12cad46642.dip0.t-ipconnect.de. [2003:cb:c705:ab00:f9b6:da12:cad4:6642])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73bcsm254107395e9.41.2024.06.19.02.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:45:23 -0700 (PDT)
Message-ID: <6d3687fd-e11b-4d78-9944-536bb1d731de@redhat.com>
Date: Wed, 19 Jun 2024 11:45:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Endless calls to xas_split_alloc() due to corrupted xarray entry
To: Gavin Shan <gshan@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Zhenyu Zhang <zhenyzha@redhat.com>, Linux XFS
 <linux-xfs@vger.kernel.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shaoqin Huang <shahuang@redhat.com>, Chandan Babu R
 <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <CAJFLiB+J4mKGDOppp=1moMe2aNqeJhM9F2cD4KPTXoM6nzb5RA@mail.gmail.com>
 <ZRFbIJH47RkQuDid@debian.me> <ZRci1L6qneuZA4mo@casper.infradead.org>
 <91bceeda-7964-2509-a1f1-4a2be49ebc60@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <91bceeda-7964-2509-a1f1-4a2be49ebc60@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.09.23 04:12, Gavin Shan wrote:
> Hi Matthew,
> 
> On 9/30/23 05:17, Matthew Wilcox wrote:
>> On Mon, Sep 25, 2023 at 05:04:16PM +0700, Bagas Sanjaya wrote:
>>> On Fri, Sep 22, 2023 at 11:56:43AM +0800, Zhenyu Zhang wrote:
>>>> Hi all,
>>>>
>>>> we don't know how the xarray entry was corrupted. Maybe it's a known
>>>> issue to community.
>>>> Lets see.
>>>>
>>>> Contents
>>>> --------
>>>> 1. Problem Statement
>>>> 2. The call trace
>>>> 3. The captured data by bpftrace
>>>>
>>>>
>>>> 1. Problem Statement
>>>> --------------------
>>>> With 4k guest and 64k host, on aarch64(Ampere's Altra Max CPU) hit Call trace:
>>>>       Steps:
>>>>       1) System setup hugepages on host.
>>>>          # echo 60 > /proc/sys/vm/nr_hugepages
>>>>       2) Mount this hugepage to /mnt/kvm_hugepage.
>>>>          # mount -t hugetlbfs -o pagesize=524288K none /mnt/kvm_hugepage
>>>
>>> What block device/disk image you use to format the filesystem?
>>
>> It's hugetlbfs, Bagas.
>>
> 
> The hugetlbfs pages are reserved, but never used. In this way, the available
> system memory is reduced. So it's same affect as to "mem=xxx" boot parameter.
> 
>>>>       3) HugePages didn't leak when using non-existent mem-path.
>>>>          # mkdir -p /mnt/tmp
>>>>       4) Boot guest.
>>>>          # /usr/libexec/qemu-kvm \
>>>> ...
>>>>            -m 30720 \
>>>> -object '{"size": 32212254720, "mem-path": "/mnt/tmp", "qom-type":
>>>> "memory-backend-file"}'  \
>>>> -smp 4,maxcpus=4,cores=2,threads=1,clusters=1,sockets=2  \
>>>>            -blockdev '{"node-name": "file_image1", "driver": "file",
>>>> "auto-read-only": true, "discard": "unmap", "aio": "threads",
>>>> "filename": "/home/kvm_autotest_root/images/back_up_4k.qcow2",
>>>> "cache": {"direct": true, "no-flush": false}}' \
>>>> -blockdev '{"node-name": "drive_image1", "driver": "qcow2",
>>>> "read-only": false, "cache": {"direct": true, "no-flush": false},
>>>> "file": "file_image1"}' \
>>>> -device '{"driver": "scsi-hd", "id": "image1", "drive":
>>>> "drive_image1", "write-cache": "on"}' \
>>>>
>>>>       5) Wait about 1 minute ------> hit Call trace
>>>>
>>>> 2. The call trace
>>>> --------------------
>>>> [   14.982751] block dm-0: the capability attribute has been deprecated.
>>>> [   15.690043] PEFILE: Unsigned PE binary
>>>>
>>>>
>>>> [   90.135676] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>> [   90.136629] rcu: 3-...0: (3 ticks this GP)
>>>> idle=e6ec/1/0x4000000000000000 softirq=6847/6849 fqs=232
>>>> [   90.137293] rcu: (detected by 2, t=6012 jiffies, g=2085, q=2539 ncpus=4)
>>>> [   90.137796] Task dump for CPU 3:
>>>> [   90.138037] task:PK-Backend      state:R  running task     stack:0
>>>>      pid:2287  ppid:1      flags:0x00000202
>>>> [   90.138757] Call trace:
>>>> [   90.138940]  __switch_to+0xc8/0x110
>>>> [   90.139203]  0xb54a54f8c5fb0700
>>>>
>>>> [  270.190849] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>> [  270.191722] rcu: 3-...0: (3 ticks this GP)
>>>> idle=e6ec/1/0x4000000000000000 softirq=6847/6849 fqs=1020
>>>> [  270.192405] rcu: (detected by 1, t=24018 jiffies, g=2085, q=3104 ncpus=4)
>>>> [  270.192876] Task dump for CPU 3:
>>>> [  270.193099] task:PK-Backend      state:R  running task     stack:0
>>>>      pid:2287  ppid:1      flags:0x00000202
>>>> [  270.193774] Call trace:
>>>> [  270.193946]  __switch_to+0xc8/0x110
>>>> [  270.194336]  0xb54a54f8c5fb0700
>>>>
>>>> [ 1228.068406] ------------[ cut here ]------------
>>>> [ 1228.073011] WARNING: CPU: 2 PID: 4496 at lib/xarray.c:1010
>>>> xas_split_alloc+0xf8/0x128
>>>> [ 1228.080828] Modules linked in: binfmt_misc vhost_net vhost
>>>> vhost_iotlb tap xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
>>>> nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack
>>>> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc
>>>> qrtr rfkill sunrpc vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu
>>>> ipmi_devintf arm_cmn arm_dmc620_pmu ipmi_msghandler cppc_cpufreq
>>>> arm_dsu_pmu xfs libcrc32c ast drm_shmem_helper drm_kms_helper drm
>>>> crct10dif_ce ghash_ce igb nvme sha2_ce nvme_core sha256_arm64 sha1_ce
>>>> i2c_designware_platform sbsa_gwdt nvme_common i2c_algo_bit
>>>> i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod
>>>> fuse
>>>> [ 1228.137630] CPU: 2 PID: 4496 Comm: qemu-kvm Kdump: loaded Tainted:
>>>> G        W          6.6.0-rc2-zhenyzha+ #5
>>>> [ 1228.147529] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
>>>> F31h (SCP: 2.10.20220810) 07/27/2022
>>>> [ 1228.156820] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> [ 1228.163767] pc : xas_split_alloc+0xf8/0x128
>>>> [ 1228.167938] lr : __filemap_add_folio+0x33c/0x4e0
>>>> [ 1228.172543] sp : ffff80008dd4f1c0
>>>> [ 1228.175844] x29: ffff80008dd4f1c0 x28: ffffd15825388c40 x27: 0000000000000001
>>>> [ 1228.182967] x26: 0000000000000001 x25: ffffffffffffc005 x24: 0000000000000000
>>>> [ 1228.190089] x23: ffff80008dd4f270 x22: ffffffc202b00000 x21: 0000000000000000
>>>> [ 1228.197211] x20: ffffffc2007f9600 x19: 000000000000000d x18: 0000000000000014
>>>> [ 1228.204334] x17: 00000000b21b8a3f x16: 0000000013a8aa94 x15: ffffd15824625944
>>>> [ 1228.211456] x14: ffffffffffffffff x13: 0000000000000030 x12: 0101010101010101
>>>> [ 1228.218578] x11: 7f7f7f7f7f7f7f7f x10: 000000000000000a x9 : ffffd158252dd3fc
>>>> [ 1228.225701] x8 : ffff80008dd4f1c0 x7 : ffff07ffa0945468 x6 : ffff80008dd4f1c0
>>>> [ 1228.232823] x5 : 0000000000000018 x4 : 0000000000000000 x3 : 0000000000012c40
>>>> [ 1228.239945] x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
>>>> [ 1228.247067] Call trace:
>>>> [ 1228.249500]  xas_split_alloc+0xf8/0x128
>>>> [ 1228.253324]  __filemap_add_folio+0x33c/0x4e0
>>>> [ 1228.257582]  filemap_add_folio+0x48/0xd0
>>>> [ 1228.261493]  page_cache_ra_order+0x214/0x310
>>>> [ 1228.265750]  ondemand_readahead+0x1a8/0x320
>>>> [ 1228.269921]  page_cache_async_ra+0x64/0xa8
>>>> [ 1228.274005]  filemap_fault+0x238/0xaa8
>>>> [ 1228.277742]  __xfs_filemap_fault+0x60/0x3c0 [xfs]
>>>> [ 1228.282491]  xfs_filemap_fault+0x54/0x68 [xfs]
>>
>> This is interesting.  This path has nothing to do with the hugetlbfs
>> filesystem you've created up above.  And, just to be clear, this is
>> on the host, not in the guest, right?
>>
> 
> Correct, the backtrce is seen on the host. The XFS file is used as backup
> memory to the guest. QEMU maps the entire file as PRIVATE and the VMA has
> been advised to huge page by madvise(MADV_HUGEPAGE). When the guest is
> started, QEMU calls madvise(MADV_POPULATE_WRITE) to populate the VMA. Since
> the VMA is private, there are copy-on-write page fault happening on
> calling to madvise(MADV_POPULATE_WRITE). In the page fault handler,
> there are readahead reuqests to be processed.
> 
> The backtrace, originating from WARN_ON(), is triggered when attempt to
> allocate a huge page fails in the middle of readahead. In this specific
> case, we're falling back to order-0 with attempt to modify the xarray
> for this. Unfortunately, it's reported this particular scenario isn't
> supported by xas_split_alloc().
> 
> 
>>>> [ 1228.377124] ------------[ cut here ]------------
>>>> [ 1228.381728] WARNING: CPU: 2 PID: 4496 at lib/xarray.c:1010
>>>> xas_split_alloc+0xf8/0x128
>>>> [ 1228.389546] Modules linked in: binfmt_misc vhost_net vhost
>>>> vhost_iotlb tap xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
>>>> nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack
>>>> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc
>>>> qrtr rfkill sunrpc vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu
>>>> ipmi_devintf arm_cmn arm_dmc620_pmu ipmi_msghandler cppc_cpufreq
>>>> arm_dsu_pmu xfs libcrc32c ast drm_shmem_helper drm_kms_helper drm
>>>> crct10dif_ce ghash_ce igb nvme sha2_ce nvme_core sha256_arm64 sha1_ce
>>>> i2c_designware_platform sbsa_gwdt nvme_common i2c_algo_bit
>>>> i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod
>>>> fuse
>>>> [ 1228.446348] CPU: 2 PID: 4496 Comm: qemu-kvm Kdump: loaded Tainted:
>>>> G        W          6.6.0-rc2-zhenyzha+ #5
>>>> [ 1228.456248] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
>>>> F31h (SCP: 2.10.20220810) 07/27/2022
>>>> [ 1228.465538] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> [ 1228.472486] pc : xas_split_alloc+0xf8/0x128
>>>> [ 1228.476656] lr : __filemap_add_folio+0x33c/0x4e0
>>>> [ 1228.481261] sp : ffff80008dd4f1c0
>>>> [ 1228.484563] x29: ffff80008dd4f1c0 x28: ffffd15825388c40 x27: 0000000000000001
>>>> [ 1228.491685] x26: 0000000000000001 x25: ffffffffffffc005 x24: 0000000000000000
>>>> [ 1228.498807] x23: ffff80008dd4f270 x22: ffffffc202b00000 x21: 0000000000000000
>>>> [ 1228.505930] x20: ffffffc2007f9600 x19: 000000000000000d x18: 0000000000000014
>>>> [ 1228.513052] x17: 00000000b21b8a3f x16: 0000000013a8aa94 x15: ffffd15824625944
>>>> [ 1228.520174] x14: ffffffffffffffff x13: 0000000000000030 x12: 0101010101010101
>>>> [ 1228.527297] x11: 7f7f7f7f7f7f7f7f x10: 000000000000000a x9 : ffffd158252dd3fc
>>>> [ 1228.534419] x8 : ffff80008dd4f1c0 x7 : ffff07ffa0945468 x6 : ffff80008dd4f1c0
>>>> [ 1228.541542] x5 : 0000000000000018 x4 : 0000000000000000 x3 : 0000000000012c40
>>>> [ 1228.548664] x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
>>>> [ 1228.555786] Call trace:
>>>> [ 1228.558220]  xas_split_alloc+0xf8/0x128
>>>> [ 1228.562043]  __filemap_add_folio+0x33c/0x4e0
>>>> [ 1228.566300]  filemap_add_folio+0x48/0xd0
>>>> [ 1228.570211]  page_cache_ra_order+0x214/0x310
>>>> [ 1228.574469]  ondemand_readahead+0x1a8/0x320
>>>> [ 1228.578639]  page_cache_async_ra+0x64/0xa8
>>>> [ 1228.582724]  filemap_fault+0x238/0xaa8
>>>> [ 1228.586460]  __xfs_filemap_fault+0x60/0x3c0 [xfs]
>>>> [ 1228.591210]  xfs_filemap_fault+0x54/0x68 [xfs]
>>>>
>>>>
>>>>
>>>> 3. The captured data by bpftrace
>>>> (The following part is the crawl analysis of gshan@redhat.com )
>>>> --------------------
>>>> pid:  4475    task: qemu-kvm
>>>> file: /mnt/tmp/qemu_back_mem.mem-machine_mem.OdGYet (deleted)
>>>>
>>>> -------------------- inode --------------------
>>>> i_flags:               0x0
>>>> i_ino:                 67333199
>>>> i_size:                32212254720
>>>>
>>>> ----------------- address_space ----------------
>>>> flags:                 040
>>>> invalidate_lock
>>>>     count:               256
>>>>     owner:               0xffff07fff6e759c1
>>>>       pid: 4496  task: qemu-kvm
>>>>     wait_list.next:      0xffff07ffa20422e0
>>>>     wait_list.prev:      0xffff07ffa20422e0
>>>>
>>>> -------------------- xarray --------------------
>>>> entry[0]:       0xffff080f7eda0002
>>>> shift:          18
>>>> offset:         0
>>>> count:          2
>>>> nr_values:      0
>>>> parent:         0x0
>>>> slots[00]:      0xffff07ffa094546a
>>>> slots[01]:      0xffff07ffa1b09b22
>>>>
>>>> entry[1]:       0xffff07ffa094546a
>>>> shift:          12
>>>> offset:         0
>>>> count:          20
>>>> nr_values:      0
>>>> parent:         0xffff080f7eda0000
>>>> slots[00]:      0xffffffc202880000
>>>> slots[01]:      0x2
>>>>
>>>> entry[2]:       0xffffffc202880000
>>>> shift:          104
>>>> offset:         128
>>>> count:          0
>>>> nr_values:      0
>>>> parent:         0xffffffc20304c888
>>>> slots[00]:      0xffff08009a960000
>>>> slots[01]:      0x2001ffffffff
>>>>
>>>> It seems the last xarray entry ("entry[2]") has been corrupted. "shift"
>>>> becomes 104 and "offset" becomes 128, which isn't reasonable.
>>
>> Um, no.  Whatever tool you're using doesn't understand how XArrays work.
>> Fortunately, I wrote xa_dump() which does.  entry[2] does not have bit
>> 1 set, so it is an entry, not a node.  You're dereferencing a pointer to
>> a folio as if it's a pointer to a node, so no wonder it looks corrupted
>> to you.  From this, we know that the folio is at least order-6, and it's
>> probably order-9 (because I bet this VMA has the VM_HUGEPAGE flag set,
>> and we're doing PMD-sized faults).
>>
> 
> Indeed, entry[2] is a entry instead of a node, deferencing a folio.
> bpftrace was used to dump the xarray. you're correct that the VMA has
> flag VM_HUGEPAGE, set by madvise(MADV_HUGEPAGE). The order returned by
> xas_get_order() is 13, passed to xas_split_alloc().
> 
> /*
>    * xas->xa_shift    = 0
>    * XA_CHUNK_SHIFT   = 6
>    * order            = 13      (512MB huge page size vs 64KB base page size)
>    */
> void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
>                   gfp_t gfp)
> {
>           unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
>           unsigned int mask = xas->xa_sibs;
> 
>           /* XXX: no support for splitting really large entries yet */
>           if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT < order))
>                   goto nomem;
>           :
> }

Resurrecting this, because I just got aware of it.

I recall talking to Willy at some point about the problem of order-13 not
being fully supported by the pagecache right now (IIRC primiarly splitting,
which should not happen for hugetlb, which is why there it is not a
problem). And I think we discussed just blocking that for now.

So we are trying to split an order-13 entry, because we ended up
allcoating+mapping an order-13 folio previously.

That's where things got wrong, with the current limitations, maybe?

#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER

Which would translate to MAX_PAGECACHE_ORDER=13 on aarch64 with 64k.

Staring at xas_split_alloc:

	WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT < order)

I suspect we don't really support THP on systems with CONFIG_BASE_SMALL.
So we can assume XA_CHUNK_SHIFT == 6.

I guess that the maximum order we support for splitting is 12? I got confused
trying to figure that out. ;)


diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e37e16ebff7a..354cd4b7320f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -352,9 +352,12 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
   * limit the maximum allocation order to PMD size.  I'm not aware of any
   * assumptions about maximum order if THP are disabled, but 8 seems like
   * a good order (that's 1MB if you're using 4kB pages)
+ *
+ * xas_split_alloc() does not support order-13 yet, so disable that for now,
+ * which implies no 512MB THP on arm64 with 64k.
   */
  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define MAX_PAGECACHE_ORDER    HPAGE_PMD_ORDER
+#define MAX_PAGECACHE_ORDER    min(HPAGE_PMD_ORDER,12)
  #else
  #define MAX_PAGECACHE_ORDER    8
  #endif


I think this does not apply to hugetlb because we never end up splitting
entries. But could this also apply to shmem + PMD THP?

-- 
Cheers,

David / dhildenb


