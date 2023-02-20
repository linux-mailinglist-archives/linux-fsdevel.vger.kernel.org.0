Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB23B69C459
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 04:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjBTDEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Feb 2023 22:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjBTDEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Feb 2023 22:04:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0354CEB48;
        Sun, 19 Feb 2023 19:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676862264; x=1708398264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E8xZ7auVU/piWMLG1AXlZIsK3dlj5WYN4ckwufDorRE=;
  b=fx5m6EjFEpOjjb1VC55XvmG9onXIltobHC1vDcZD6GjLIdTHMyogRt6u
   Oaqqhc7FuleOTSCPtik26s72T/ulLlmqs/aC2FBQPbHM0z+JMwbUal7Dt
   KGldDAUoeK3yAXM3VINEL2yLC5TBj22fHrU7Q9sOBDCYUuWL5uQTLgQyA
   uS9JRJbr88mqGwfB51hTtS/RHKXoYp8LwUp+anetCZjnmMnqsoxe95rN3
   YgHdb3ktrVbl8XWHeTILDyWkNAVLkkKBK+XeKu3ocrMuRGU/naTOAMAV6
   j2k/7g7bnBgjuX9PK1adbkKZ2ArAMH4MgqRJ4KW/rbmAh8UmB3JgwZ1jX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="332319326"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="332319326"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 19:04:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="1000125665"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="1000125665"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
  by fmsmga005.fm.intel.com with ESMTP; 19 Feb 2023 19:04:13 -0800
Date:   Mon, 20 Feb 2023 11:04:12 +0800
From:   Yuan Yao <yuan.yao@linux.intel.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, david@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, jmattson@google.com,
        joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com
Subject: Re: [RFC PATCH 0/2] Add flag as THP allocation hint for
 memfd_restricted() syscall
Message-ID: <20230220030412.fgh3f5qzgihz4f4x@yy-desk-7060>
References: <cover.1676680548.git.ackerleytng@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1676680548.git.ackerleytng@google.com>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 18, 2023 at 12:43:00AM +0000, Ackerley Tng wrote:
> Hello,
>
> This patchset builds upon the memfd_restricted() system call that has
> been discussed in the ‘KVM: mm: fd-based approach for supporting KVM’
> patch series, at
> https://lore.kernel.org/lkml/20221202061347.1070246-1-chao.p.peng@linux.intel.com/T/#m7e944d7892afdd1d62a03a287bd488c56e377b0c
>
> The tree can be found at:
> https://github.com/googleprodkernel/linux-cc/tree/restrictedmem-rmfd-hugepage
>
> Following the RFC to provide mount for memfd_restricted() syscall at
> https://lore.kernel.org/lkml/cover.1676507663.git.ackerleytng@google.com/T/#u,
> this patchset adds the RMFD_HUGEPAGE flag to the memfd_restricted()
> syscall, which will hint the kernel to use Transparent HugePages to
> back restrictedmem pages.
>
> This supplements the interface proposed earlier, which requires the
> creation of a tmpfs mount to be passed to memfd_restricted(), with a
> more direct per-file hint.
>
> Dependencies:
>
> + Sean’s iteration of the ‘KVM: mm: fd-based approach for supporting
>   KVM’ patch series at
>   https://github.com/sean-jc/linux/tree/x86/upm_base_support
> + Proposed fix for restrictedmem_getattr() as mentioned on the mailing
>   list at
>   https://lore.kernel.org/lkml/diqzzga0fv96.fsf@ackerleytng-cloudtop-sg.c.googlers.com/
> + Hugh’s patch:
>   https://lore.kernel.org/lkml/c140f56a-1aa3-f7ae-b7d1-93da7d5a3572@google.com/,
>   which provides functionality in shmem that reads the VM_HUGEPAGE
>   flag in key functions shmem_is_huge() and shmem_get_inode()

Will Hugh's patch be merged into 6.3 ? I didn't find it in 6.2-rc8.
IMHO this patch won't work without Hugh's patch, or at least need
another way, e.g. HMEM_SB(inode->i_sb)->huge.

>
> Future work/TODOs:
> + man page for the memfd_restricted() syscall
> + Support for per file NUMA binding hints
>
> Ackerley Tng (2):
>   mm: restrictedmem: Add flag as THP allocation hint for
>     memfd_restricted() syscall
>   selftests: restrictedmem: Add selftest for RMFD_HUGEPAGE
>
>  include/uapi/linux/restrictedmem.h            |  1 +
>  mm/restrictedmem.c                            | 27 ++++++++++++-------
>  .../restrictedmem_hugepage_test.c             | 25 +++++++++++++++++
>  3 files changed, 43 insertions(+), 10 deletions(-)
>
> --
> 2.39.2.637.g21b0678d19-goog
>
