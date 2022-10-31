Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA05B613C73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 18:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiJaRsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJaRsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:48:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9BB25D5;
        Mon, 31 Oct 2022 10:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNCbRMqU9a0Jhhqlst2BIfOGaPYtd9pSk72WBWu0HdnxLqQ/W3OX0DJmUtpLcmnniESSazAhru43s3niZMyMbjXDZIYqMTYbgOrkzM5yjqXSX3OlV+hQBjzpXd2U/0mUKB72A41TDnl8AastD5ET+PdSfwmWiR1dHlC7Zks7TinPuboGoPaU6yxLq5XsMyAjQCrFfx8eraKok4kyiAfYuARhBqhdTfqo5VT6nidr2CKTmFIaBop7hvq7xAWbpOih8+07OxJlZtjDiR5xgniTg1WllCYajLE2HVyT6Qa/tcdZvOnp8lAOrVYxVBAxFykHCKHSlPQUyWiAPMSeMj94DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq+7sa2igOzf6AotYkdeyedvJ2AuM/wUwmTt6T8O50o=;
 b=MG4sfvukac6I9YT3rflmjsbSU+5I3qcBDqyUSJbHz5tLLXnAzY2c2ogN5sBZ/R/Kswy2cgADRNrYy49trrEBLmh7TYd8mKBd7jtEhddvt2opOZQjiYFiznKuoo2tf8/EzoMq8U3HX45F9KTcQtB7LCpev4arKeoPIe1dhdgxZLNICf8G8w25ettImaIAB23bin481nDvTHaXahiRKq2LmMsS6h5pQLgKg2nX30JBEbD9YvBNOmfAMG+ASAK8Xfxa6aFtQ2tsoFSlIzfFg+wHff8Lbvu0tQHQzlDCFlcAU13u0U795om7ESGlRIu78oC4VoNWhdA1hqKkOB97p4b11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq+7sa2igOzf6AotYkdeyedvJ2AuM/wUwmTt6T8O50o=;
 b=ng4XewCZOszA//AqVOmU11mtoO6w28Z9KSG/7thMvfg/KjkYodTKPWlsaJKujVisNHTRhSPX0Ii1ZuTteWhvIb5ShOz6eKzL9JoD+gBQ6a4c1ddzLbb7I/d7xptndqSIiftNsj19kRhlFplqmlTtKo5/PH/tYiy6EETqOGRw25k=
Received: from DM6PR02CA0157.namprd02.prod.outlook.com (2603:10b6:5:332::24)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 17:47:57 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::3d) by DM6PR02CA0157.outlook.office365.com
 (2603:10b6:5:332::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Mon, 31 Oct 2022 17:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 17:47:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 12:47:55 -0500
Date:   Mon, 31 Oct 2022 12:47:38 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <luto@kernel.org>, <jun.nakajima@intel.com>,
        <dave.hansen@intel.com>, <ak@linux.intel.com>, <david@redhat.com>,
        <aarcange@redhat.com>, <ddutile@redhat.com>, <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>, <tabba@google.com>,
        <mhocko@suse.com>, Muchun Song <songmuchun@bytedance.com>,
        <wei.w.wang@intel.com>
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221031174738.fklhlia5fmaiinpe@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a35e7ef-47a5-44d6-06ec-08dabb680b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0bZsW97XnTLKNE3U/GCiVFaFDr4XiV5QNtrbECT8Ja1PE/q/Kb8gTREh5+7V/5UZS6PS5Dl8YwHy0MbhkDtMzzhuFc2zPI4aIdl9b07DdfPVDrsLRRSuhwX382Jj9gXDIf10rqJBrLMhP72j9nxU3oojuTo4//qUumVB1ESNvSB91JdcvwsdxemMcTjRXzEL7d/16gADw3Hfmzmn+93hG2FL0Wr0gSCmYCZNn3B4Lc7fkMLGLbmxGDAPydATCC0s4iKpvm04JhazPdKhnxabwRZUaqz6EolWoHawHbxC13K1Zc8XSojR5N7VHvmeIkbKAm1p77sDpkEPd1j722yjcDfRIoqHmumWgKfLM2EJX7ycKoVqkYWOt0Zy10K/tLPVgeqZj9JhYdG1MxJ4TkYglsRo5u7KaQiWC/V7f8msL+zGIWX4fKAVmPOtBWGl+1Z5nb0WwhZUtKZJQZRMdcdqGmyTWT31NYR9bZSg/UxLK70nJk3sKCgl1sxtMkXFhQe2lF1GzrZQ95kj2g0I7TBafYGcSVigpnRaSiWn9ESkvd4eFqS5bh+8Wgov84xSYeMLRv+X69JdcIJY7ec84QGpFmitbjHhIBhoBDS8pwZC5aGP96wz08zOftZpf8eLaPpHVbgsmdwkvoqEKzwTlBoa5F9gzJDowj8F3rKWMr6l2Mp+1pNsD1SwUk7TonkKLVMfCNQln8ofm+9GgBmtYzYzzsir01miJIOVEASHEBA6lIoAJHFuCKMXNo1WhQeMATUTGqgHRLiE9wPdUkimuk2uRRSK3px2Tpud73BNK1pZs0dB60vYcgh+815mYFqnBvE/zQTmYA60IzuWALHo212Gtc8DmViE/2AGPUb/YMlu4CeuiuzYoDWuxuBTqpBSCvU
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(336012)(426003)(82310400005)(47076005)(186003)(1076003)(16526019)(26005)(2616005)(40460700003)(36860700001)(83380400001)(40480700001)(41300700001)(8936002)(70206006)(70586007)(4326008)(8676002)(2906002)(44832011)(7406005)(7416002)(5660300002)(478600001)(966005)(6666004)(316002)(54906003)(6916009)(30864003)(86362001)(36756003)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 17:47:56.8227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a35e7ef-47a5-44d6-06ec-08dabb680b6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Introduce 'memfd_restricted' system call with the ability to create
> memory areas that are restricted from userspace access through ordinary
> MMU operations (e.g. read/write/mmap). The memory content is expected to
> be used through a new in-kernel interface by a third kernel module.
> 
> memfd_restricted() is useful for scenarios where a file descriptor(fd)
> can be used as an interface into mm but want to restrict userspace's
> ability on the fd. Initially it is designed to provide protections for
> KVM encrypted guest memory.
> 
> Normally KVM uses memfd memory via mmapping the memfd into KVM userspace
> (e.g. QEMU) and then using the mmaped virtual address to setup the
> mapping in the KVM secondary page table (e.g. EPT). With confidential
> computing technologies like Intel TDX, the memfd memory may be encrypted
> with special key for special software domain (e.g. KVM guest) and is not
> expected to be directly accessed by userspace. Precisely, userspace
> access to such encrypted memory may lead to host crash so should be
> prevented.
> 
> memfd_restricted() provides semantics required for KVM guest encrypted
> memory support that a fd created with memfd_restricted() is going to be
> used as the source of guest memory in confidential computing environment
> and KVM can directly interact with core-mm without the need to expose
> the memoy content into KVM userspace.
> 
> KVM userspace is still in charge of the lifecycle of the fd. It should
> pass the created fd to KVM. KVM uses the new restrictedmem_get_page() to
> obtain the physical memory page and then uses it to populate the KVM
> secondary page table entries.
> 
> The userspace restricted memfd can be fallocate-ed or hole-punched
> from userspace. When these operations happen, KVM can get notified
> through restrictedmem_notifier, it then gets chance to remove any
> mapped entries of the range in the secondary page tables.
> 
> memfd_restricted() itself is implemented as a shim layer on top of real
> memory file systems (currently tmpfs). Pages in restrictedmem are marked
> as unmovable and unevictable, this is required for current confidential
> usage. But in future this might be changed.
> 
> By default memfd_restricted() prevents userspace read, write and mmap.
> By defining new bit in the 'flags', it can be extended to support other
> restricted semantics in the future.
> 
> The system call is currently wired up for x86 arch.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  include/linux/restrictedmem.h          |  62 ++++++
>  include/linux/syscalls.h               |   1 +
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  include/uapi/linux/magic.h             |   1 +
>  kernel/sys_ni.c                        |   3 +
>  mm/Kconfig                             |   4 +
>  mm/Makefile                            |   1 +
>  mm/restrictedmem.c                     | 250 +++++++++++++++++++++++++
>  10 files changed, 328 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/restrictedmem.h
>  create mode 100644 mm/restrictedmem.c
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 320480a8db4f..dc70ba90247e 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -455,3 +455,4 @@
>  448	i386	process_mrelease	sys_process_mrelease
>  449	i386	futex_waitv		sys_futex_waitv
>  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
> +451	i386	memfd_restricted	sys_memfd_restricted
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..06516abc8318 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,7 @@
>  448	common	process_mrelease	sys_process_mrelease
>  449	common	futex_waitv		sys_futex_waitv
>  450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451	common	memfd_restricted	sys_memfd_restricted
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/restrictedmem.h b/include/linux/restrictedmem.h
> new file mode 100644
> index 000000000000..9c37c3ea3180
> --- /dev/null
> +++ b/include/linux/restrictedmem.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _LINUX_RESTRICTEDMEM_H
> +
> +#include <linux/file.h>
> +#include <linux/magic.h>
> +#include <linux/pfn_t.h>
> +
> +struct restrictedmem_notifier;
> +
> +struct restrictedmem_notifier_ops {
> +	void (*invalidate_start)(struct restrictedmem_notifier *notifier,
> +				 pgoff_t start, pgoff_t end);
> +	void (*invalidate_end)(struct restrictedmem_notifier *notifier,
> +			       pgoff_t start, pgoff_t end);
> +};
> +
> +struct restrictedmem_notifier {
> +	struct list_head list;
> +	const struct restrictedmem_notifier_ops *ops;
> +};
> +
> +#ifdef CONFIG_RESTRICTEDMEM
> +
> +void restrictedmem_register_notifier(struct file *file,
> +				     struct restrictedmem_notifier *notifier);
> +void restrictedmem_unregister_notifier(struct file *file,
> +				       struct restrictedmem_notifier *notifier);
> +
> +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> +			   struct page **pagep, int *order);
> +
> +static inline bool file_is_restrictedmem(struct file *file)
> +{
> +	return file->f_inode->i_sb->s_magic == RESTRICTEDMEM_MAGIC;
> +}
> +
> +#else
> +
> +static inline void restrictedmem_register_notifier(struct file *file,
> +				     struct restrictedmem_notifier *notifier)
> +{
> +}
> +
> +static inline void restrictedmem_unregister_notifier(struct file *file,
> +				       struct restrictedmem_notifier *notifier)
> +{
> +}
> +
> +static inline int restrictedmem_get_page(struct file *file, pgoff_t offset,
> +					 struct page **pagep, int *order)
> +{
> +	return -1;
> +}
> +
> +static inline bool file_is_restrictedmem(struct file *file)
> +{
> +	return false;
> +}
> +
> +#endif /* CONFIG_RESTRICTEDMEM */
> +
> +#endif /* _LINUX_RESTRICTEDMEM_H */
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a34b0f9a9972..f9e9e0c820c5 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1056,6 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>  					    unsigned long home_node,
>  					    unsigned long flags);
> +asmlinkage long sys_memfd_restricted(unsigned int flags);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 45fa180cc56a..e93cd35e46d0 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>  #define __NR_set_mempolicy_home_node 450
>  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>  
> +#define __NR_memfd_restricted 451
> +__SYSCALL(__NR_memfd_restricted, sys_memfd_restricted)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 452
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 6325d1d0e90f..8aa38324b90a 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -101,5 +101,6 @@
>  #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
>  #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
>  #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> +#define RESTRICTEDMEM_MAGIC	0x5245534d	/* "RESM" */
>  
>  #endif /* __LINUX_MAGIC_H__ */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 860b2dcf3ac4..7c4a32cbd2e7 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -360,6 +360,9 @@ COND_SYSCALL(pkey_free);
>  /* memfd_secret */
>  COND_SYSCALL(memfd_secret);
>  
> +/* memfd_restricted */
> +COND_SYSCALL(memfd_restricted);
> +
>  /*
>   * Architecture specific weak syscall entries.
>   */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0331f1461f81..0177d53676c7 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1076,6 +1076,10 @@ config IO_MAPPING
>  config SECRETMEM
>  	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
>  
> +config RESTRICTEDMEM
> +	bool
> +	depends on TMPFS
> +
>  config ANON_VMA_NAME
>  	bool "Anonymous VMA name support"
>  	depends on PROC_FS && ADVISE_SYSCALLS && MMU
> diff --git a/mm/Makefile b/mm/Makefile
> index 9a564f836403..6cb6403ffd40 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -117,6 +117,7 @@ obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
>  obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
>  obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
>  obj-$(CONFIG_SECRETMEM) += secretmem.o
> +obj-$(CONFIG_RESTRICTEDMEM) += restrictedmem.o
>  obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
>  obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
>  obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> new file mode 100644
> index 000000000000..e5bf8907e0f8
> --- /dev/null
> +++ b/mm/restrictedmem.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "linux/sbitmap.h"
> +#include <linux/pagemap.h>
> +#include <linux/pseudo_fs.h>
> +#include <linux/shmem_fs.h>
> +#include <linux/syscalls.h>
> +#include <uapi/linux/falloc.h>
> +#include <uapi/linux/magic.h>
> +#include <linux/restrictedmem.h>
> +
> +struct restrictedmem_data {
> +	struct mutex lock;
> +	struct file *memfd;
> +	struct list_head notifiers;
> +};
> +
> +static void restrictedmem_notifier_invalidate(struct restrictedmem_data *data,
> +				 pgoff_t start, pgoff_t end, bool notify_start)
> +{
> +	struct restrictedmem_notifier *notifier;
> +
> +	mutex_lock(&data->lock);
> +	list_for_each_entry(notifier, &data->notifiers, list) {
> +		if (notify_start)
> +			notifier->ops->invalidate_start(notifier, start, end);
> +		else
> +			notifier->ops->invalidate_end(notifier, start, end);
> +	}
> +	mutex_unlock(&data->lock);
> +}
> +
> +static int restrictedmem_release(struct inode *inode, struct file *file)
> +{
> +	struct restrictedmem_data *data = inode->i_mapping->private_data;
> +
> +	fput(data->memfd);
> +	kfree(data);
> +	return 0;
> +}
> +
> +static long restrictedmem_fallocate(struct file *file, int mode,
> +				    loff_t offset, loff_t len)
> +{
> +	struct restrictedmem_data *data = file->f_mapping->private_data;
> +	struct file *memfd = data->memfd;
> +	int ret;
> +
> +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> +			return -EINVAL;
> +	}
> +
> +	restrictedmem_notifier_invalidate(data, offset, offset + len, true);
> +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> +	restrictedmem_notifier_invalidate(data, offset, offset + len, false);
> +	return ret;
> +}

In v8 there was some discussion about potentially passing the page/folio
and order as part of the invalidation callback, I ended up needing
something similar for SEV-SNP, and think it might make sense for other
platforms. This main reasoning is:

  1) restoring kernel directmap:

     Currently SNP (and I believe TDX) need to either split or remove kernel
     direct mappings for restricted PFNs, since there is no guarantee that
     other PFNs within a 2MB range won't be used for non-restricted
     (which will cause an RMP #PF in the case of SNP since the 2MB
     mapping overlaps with guest-owned pages)

     Previously we were able to restore 2MB mappings to some degree
     since both shared/restricted pages were all pinned, so anything
     backed by a THP (or hugetlb page once that is implemented) at guest
     teardown could be restored as 2MB direct mapping.

     Invalidation seems like the most logical time to have this happen,
     but whether or not to restore as 2MB requires the order to be 2MB
     or larger, and for GPA range being invalidated to cover the entire
     2MB (otherwise it means the page was potentially split and some
     subpages free back to host already, in which case it can't be
     restored as 2MB).

  2) Potentially less invalidations:
      
     If we pass the entire folio or compound_page as part of
     invalidation, we only needed to issue 1 invalidation per folio.

  3) Potentially useful for hugetlbfs support:

     One issue with hugetlbfs is that we don't support splitting the
     hugepage in such cases, which was a big obstacle prior to UPM. Now
     however, we may have the option of doing "lazy" invalidations where
     fallocate(PUNCH_HOLE, ...) won't free a shmem-allocate page unless
     all the subpages within the 2M range are either hole-punched, or the
     guest is shut down, so in that way we never have to split it. Sean
     was pondering something similar in another thread:

       https://lore.kernel.org/linux-mm/YyGLXXkFCmxBfu5U@google.com/

     Issuing invalidations with folio-granularity ties in fairly well
     with this sort of approach if we end up going that route.

I need to rework things for v9, and we'll probably want to use struct
folio instead of struct page now, but as a proof-of-concept of sorts this
is what I'd added on top of v8 of your patchset to implement 1) and 2):

  https://github.com/mdroth/linux/commit/127e5ea477c7bd5e4107fd44a04b9dc9e9b1af8b

Does an approach like this seem reasonable? Should be work this into the
base restricted memslot support?

Thanks,

Mike
