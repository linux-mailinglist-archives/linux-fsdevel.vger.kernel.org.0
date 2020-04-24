Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC781B7EBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 21:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgDXTUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 15:20:13 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10859 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXTUM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:20:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea33bdd0000>; Fri, 24 Apr 2020 12:19:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 Apr 2020 12:20:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 24 Apr 2020 12:20:10 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Apr
 2020 19:20:10 +0000
Received: from [10.2.53.96] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Apr
 2020 19:20:04 +0000
Subject: Re: [regression] Re: [PATCH v6 06/12] mm/gup: track FOLL_PIN pages
To:     Alex Williamson <alex.williamson@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Ira Weiny" <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
 <20200211001536.1027652-7-jhubbard@nvidia.com>
 <20200424121846.5ee2685f@w520.home>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5b901542-d949-8d7e-89c7-f8d5ee20f6e9@nvidia.com>
Date:   Fri, 24 Apr 2020 12:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424121846.5ee2685f@w520.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587755997; bh=iIXaq7rl/Kc1f1e/3UHujXINECD1rxz43lNoDUTLGmk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Pu1IiKasSwGDWdTgGr+/hBz1AR/YBPx262v8yLhkURTsWxhl8GpjCT7+NIlivvcHk
         TBRP6NnkKA9em34rhYHRdKdyL84WQTM4tGhE7fP22sDzyyMW9SFEgN528lOBK7O/mR
         BvY5eGoFGidCBt8zE3OlJEzL4+pPPgDiIwsvm1KoFXKuMuRb7GRwxbhv+ZChmZlWrE
         dvhVtNWkc8nG9GvZzSPBDZalPRrC3BpCYfKvGpnpsDsE3CNgdNNt6lQvHUo2xJbvom
         bKyF0dv3/YJVhmzDyraC62D2O2Y0TiaRKnaq/Yc1EBJnO5VbpPrY01kXqWTKUTO4NV
         GYwsmYzjzesMA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-24 11:18, Alex Williamson wrote:
...
> Hi John,
> 
> I'm seeing a regression bisected back to this commit (3faa52c03f44
> mm/gup: track FOLL_PIN pages).  I've attached some vfio-pci test code
> that reproduces this by mmap'ing a page of MMIO space of a device and
> then tries to map that through the IOMMU, so this should be attempting
> a gup/pin of a PFNMAP page.  Previously this failed gracefully (-EFAULT),
> but now results in:


Hi Alex,

Thanks for this report, and especially for source code to test it, 
seeing as how I can't immediately spot the problem just from the crash
data so far.  I'll get set up and attempt a repro.

Actually this looks like it should be relatively easier than the usual 
sort of "oops, we leaked a pin_user_pages() or unpin_user_pages() call,
good luck finding which one" report that I fear the most. :) This one 
looks more like a crash that happens directly, when calling into the 
pin_user_pages_remote() code. Which should be a lot easier to solve...

btw, if you are set up for it, it would be nice to know what source file 
and line number corresponds to the RIP (get_pfnblock_flags_mask+0x22) 
below. But if not, no problem, because I've likely got to do the repro 
in any case.

thanks,
-- 
John Hubbard
NVIDIA
> 
> BUG: unable to handle page fault for address: ffffae5cbfe5e938
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 18 PID: 3365 Comm: vfio-pci-dma-ma Tainted: G           OE     5.6.0+ #6
> Hardware name: AMD Corporation Diesel/Diesel, BIOS TDL100CB 03/17/2020
> RIP: 0010:get_pfnblock_flags_mask+0x22/0x70
> Code: c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 48 8b 05 bc e1 d9 01 48 89 f7 49 89 c8 48 c1 ef 0f 48 85 c0 74 48 48 89 f1 48 c1 e9 17 <48> 8b 04 c8 48 85 c0 74 0b 40 0f b6 ff 48 c1 e7 04 48 01 f8 48 c1
> RSP: 0018:ffffb55289b3fcc8 EFLAGS: 00010216
> RAX: ffff9e5cbff50000 RBX: 0000000000000001 RCX: 000001fffffe1d27
> RDX: 0000000000000002 RSI: ffffff0e93acd633 RDI: 0001fffffe1d2759
> RBP: ffffb55289b3fd88 R08: 0000000000000007 R09: ffff9e48a52476a8
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000001 R15: ffff9e48ab358cc0
> FS:  00007f4ef7269740(0000) GS:ffff9e48afa80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffae5cbfe5e938 CR3: 0000000c61eda000 CR4: 00000000003406e0
> Call Trace:
>   __gup_longterm_locked+0x274/0x620
>   vaddr_get_pfn+0x74/0x110 [vfio_iommu_type1]
>   vfio_pin_pages_remote+0x6e/0x370 [vfio_iommu_type1]
>   vfio_iommu_type1_ioctl+0x8e5/0xaac [vfio_iommu_type1]
>   ksys_ioctl+0x86/0xc0
>   __x64_sys_ioctl+0x16/0x20
>   do_syscall_64+0x5b/0x1f0
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f4ef6d7d307
> Code: 44 00 00 48 8b 05 69 1b 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 1b 2d 00 f7 d8 64 89 01 48
> RSP: 002b:00007fff76ada738 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4ef6d7d307
> RDX: 00007fff76ada760 RSI: 0000000000003b71 RDI: 0000000000000003
> RBP: 00007fff76ada930 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000213 R12: 0000000000400950
> R13: 00007fff76adaa10 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in: vfio_pci(OE) vfio_virqfd(OE) vfio_iommu_type1(OE) vfio(OE) amd64_edac_mod edac_mce_amd kvm_amd kvm rfkill sunrpc ipmi_ssif vfat irqbypass fat ipmi_si crct10dif_pclmul crc32_pclmul sp5100_tco ghash_clmulni_intel ipmi_devintf pcspkr joydev ccp i2c_piix4 k10temp ipmi_msghandler pinctrl_amd acpi_cpufreq ip_tables nouveau ast video mxm_wmi drm_vram_helper wmi drm_ttm_helper i2c_algo_bit drm_kms_helper cec ttm drm i40e e1000e crc32c_intel
> CR2: ffffae5cbfe5e938
> ---[ end trace a384ab7cc8e37d46 ]---
> RIP: 0010:get_pfnblock_flags_mask+0x22/0x70
> Code: c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 48 8b 05 bc e1 d9 01 48 89 f7 49 89 c8 48 c1 ef 0f 48 85 c0 74 48 48 89 f1 48 c1 e9 17 <48> 8b 04 c8 48 85 c0 74 0b 40 0f b6 ff 48 c1 e7 04 48 01 f8 48 c1
> RSP: 0018:ffffb55289b3fcc8 EFLAGS: 00010216
> RAX: ffff9e5cbff50000 RBX: 0000000000000001 RCX: 000001fffffe1d27
> RDX: 0000000000000002 RSI: ffffff0e93acd633 RDI: 0001fffffe1d2759
> RBP: ffffb55289b3fd88 R08: 0000000000000007 R09: ffff9e48a52476a8
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000001 R15: ffff9e48ab358cc0
> FS:  00007f4ef7269740(0000) GS:ffff9e48afa80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffae5cbfe5e938 CR3: 0000000c61eda000 CR4: 00000000003406e0
> 
> Thanks,
> Alex
> 


