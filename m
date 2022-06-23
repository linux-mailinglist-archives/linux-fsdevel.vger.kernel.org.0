Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7D558B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 01:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiFWXAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 19:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFWXAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:00:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B5A5D112;
        Thu, 23 Jun 2022 16:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoGy3AGFwHC0+NnXOYj8CmJzqTU3hR9GQS1tYL1sSrOPtnLJKr3sKlMmjDFQKlfVIM31FQvb8pPN81GOY8fPB1Q/kNtd9+uw5JjOdfjWunulgjUJxZRDju5zX2GJp9wChMKUTE6ZMMilDXmEQe/3OkBZXI/zt61cEOv30x1KPOjvr2f0+vHGtHu2HmEQJNEN0ufAMEn/zdjQARX8mmrEMu/MVBAJmNytNDbrii26tQQrIlvt6lCDD+8O9rRog5dhzvniIAM+jjkfcvd9X3QdWYtALi62uuyZzcoJYvINS4epMlPuTyMD/gFfHu2fV0Es4TzE2BmAboPqjqtlDz6gcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyamViTq1nBVi9xIjb/e7PY0gptonM7vBa3se7GZiFw=;
 b=CFLJNDLBu/E2TYT6VYoqW+81mxIGkIV3mq/kTYoSjr+uq84FXUpoMPdF9LZYF43jZQtuzASzYT0V4qWFlMRHnCOFLY3lR8Sy+2i2ezYN7VSbmm7CEBLrzqtWBCO/gM9HtC5hm8+VJ56hlWnmJqBN0ScpJB4UpwFQ/40i3AdreFtc9Pkg1iTio2hdPyBRXhoXjnmTPfsLNhmfLURfjFK35+yiwvt1boPl6McXyn3aso013Qs3GkmM67vA9NG+HnDTgaQ4PnIomf9CX+XeWRMS7Nb88WZFsJ4mESqw2poEeq8SDg7inWShtiWnn1g69mQLZtwXdhi1H2/DQ1Dwr6s/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyamViTq1nBVi9xIjb/e7PY0gptonM7vBa3se7GZiFw=;
 b=atgzjGE3jRVBW7/o7bDUJl/ee5/S6Gu+XZzlD+iAUAljqzH9CrYpsQJ83OKnrx69hJiVHmsc5rX1kkaAphTM9HM6lD/5G8B8hZbtLLCnNsQb7XBpss6iVqSlx2/NsSXcswy3mBvTl3iZdVAc/v9kcjF0OlbAaQ37ewXPU6XGHfI=
Received: from BN6PR12CA0043.namprd12.prod.outlook.com (2603:10b6:405:70::29)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 23:00:07 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::82) by BN6PR12CA0043.outlook.office365.com
 (2603:10b6:405:70::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17 via Frontend
 Transport; Thu, 23 Jun 2022 23:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 23:00:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 23 Jun
 2022 18:00:06 -0500
Date:   Thu, 23 Jun 2022 17:07:51 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <luto@kernel.org>, <jun.nakajima@intel.com>,
        <dave.hansen@intel.com>, <ak@linux.intel.com>, <david@redhat.com>,
        <aarcange@redhat.com>, <ddutile@redhat.com>, <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>, <mhocko@suse.com>
Subject: Re: [PATCH v6 7/8] KVM: Enable and expose KVM_MEM_PRIVATE
Message-ID: <20220623220751.emt3iqq77faxfzzy@amd.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-8-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220519153713.819591-8-chao.p.peng@linux.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41f2cc68-07a1-439c-c99c-08da556c1df8
X-MS-TrafficTypeDiagnostic: DS7PR12MB5815:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMQER8qa581Q0yKLb6m725j+nrTlmsVafu9Jmrkl4r1diWywwDCPswbB9hT/dLvDJF76DL6h/PZUjKcQD/Saw9KuV+o29w/CWT/wABmDG7PsaH6GRo/c/OQc2uVUUFp3R2mAvYRfsR+d+j74AC3inUipssISlM9I/FLqz2+tDypSM7A7Hw7WY7q2zbvIw7BrP5dzJddnOhwEpR3vxX75aWwR6OIa7sG8xlEGalVE3wwVerDWuTAcPxc9z7CDD0kYB+uxgzuGGcnOlTnaMUM89dynoTM/6AvoqT2h6d3oqMlYEkeudT6O8smJTpMxuMuor2la0BfpfU05gB+ZgaTXuwTwx1LxMB72WOBJ7GO1ZlBHltu1Rw6y/NYH+H6D18YpojVm+DxToENfXJ9WS1v4e4gHuwmb12T5n0Hy4w0yKhy2vzjXNwC62m4MxqrMuvcxFJLGI1SO8DU2f0UFy4uFIgimjRvvC+10tQ6nVi0v69iw9vWaA56tHEiTrHWlIE2S65cobqYdXeMVcvJ6KTSXD0q4uJ4P0syAQxBsvzHREvUINFu/+A5CekZ27JjNIXBwtXLRw6DdqAXBwUDRejJnjY2hvAsJCKZCUElYSR3VLYiO518M1spMecqiMHNjfh5aVOBIs3MNqqFi8PzHUlmuWmbrs7KCb00p6Lm5CoAOoTvoyxHftkRCwN3Abs00FsyAMC10NKN28QInCpZ8a23iKAno0pLxuGPFhXpxdHXq34t/P7JNNLuHEVj0pEbHeUvaXXxPjUpRyJPYOkL4UyGb7sP9SIFaVF9XgK5cqaXAaIhRpJAIGd+7ySOtFRgjgd2SpZE1/OYJ8xkjaxj6dStNYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(40470700004)(46966006)(26005)(83380400001)(426003)(186003)(6916009)(36860700001)(82740400003)(5660300002)(40460700003)(6666004)(47076005)(2906002)(336012)(36756003)(82310400005)(70206006)(356005)(8676002)(7416002)(40480700001)(4326008)(70586007)(16526019)(54906003)(44832011)(86362001)(7406005)(316002)(2616005)(8936002)(1076003)(81166007)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 23:00:07.3238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f2cc68-07a1-439c-c99c-08da556c1df8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 11:37:12PM +0800, Chao Peng wrote:
> Register private memslot to fd-based memory backing store and handle the
> memfile notifiers to zap the existing mappings.
> 
> Currently the register is happened at memslot creating time and the
> initial support does not include page migration/swap.
> 
> KVM_MEM_PRIVATE is not exposed by default, architecture code can turn
> on it by implementing kvm_arch_private_mem_supported().
> 
> A 'kvm' reference is added in memslot structure since in
> memfile_notifier callbacks we can only obtain a memslot reference while
> kvm is need to do the zapping. The zapping itself reuses code from
> existing mmu notifier handling.
> 
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/kvm_host.h |  10 ++-
>  virt/kvm/kvm_main.c      | 132 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 131 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index b0a7910505ed..00efb4b96bc7 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -246,7 +246,7 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
>  #endif
>  
> -#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
> +#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_MEMFILE_NOTIFIER)
>  struct kvm_gfn_range {
>  	struct kvm_memory_slot *slot;
>  	gfn_t start;
> @@ -577,6 +577,7 @@ struct kvm_memory_slot {
>  	struct file *private_file;
>  	loff_t private_offset;
>  	struct memfile_notifier notifier;
> +	struct kvm *kvm;
>  };
>  
>  static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
> @@ -769,9 +770,13 @@ struct kvm {
>  	struct hlist_head irq_ack_notifier_list;
>  #endif
>  
> +#if (defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)) ||\
> +	defined(CONFIG_MEMFILE_NOTIFIER)
> +	unsigned long mmu_notifier_seq;
> +#endif
> +
>  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>  	struct mmu_notifier mmu_notifier;
> -	unsigned long mmu_notifier_seq;
>  	long mmu_notifier_count;
>  	unsigned long mmu_notifier_range_start;
>  	unsigned long mmu_notifier_range_end;
> @@ -1438,6 +1443,7 @@ bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
>  int kvm_arch_post_init_vm(struct kvm *kvm);
>  void kvm_arch_pre_destroy_vm(struct kvm *kvm);
>  int kvm_arch_create_vm_debugfs(struct kvm *kvm);
> +bool kvm_arch_private_mem_supported(struct kvm *kvm);
>  
>  #ifndef __KVM_HAVE_ARCH_VM_ALLOC
>  /*
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index db9d39a2d3a6..f93ac7cdfb53 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -843,6 +843,73 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>  
>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>  
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +static void kvm_private_mem_notifier_handler(struct memfile_notifier *notifier,
> +					     pgoff_t start, pgoff_t end)
> +{
> +	int idx;
> +	struct kvm_memory_slot *slot = container_of(notifier,
> +						    struct kvm_memory_slot,
> +						    notifier);
> +	struct kvm_gfn_range gfn_range = {
> +		.slot		= slot,
> +		.start		= start - (slot->private_offset >> PAGE_SHIFT),
> +		.end		= end - (slot->private_offset >> PAGE_SHIFT),

This code assumes that 'end' is greater than slot->private_offset, but
even if slot->private_offset is non-zero, nothing stops userspace from
allocating pages in the range of 0 through slot->private_offset, which
will still end up triggering this notifier. In that case gfn_range.end
will end up going negative, and the below code will limit that to
slot->npages and do a populate/invalidate for the entire range.

Not sure if this covers all the cases, but this fixes the issue for me:

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 903ffdb5f01c..4c744d8f7527 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -872,6 +872,19 @@ static void kvm_private_mem_notifier_handler(struct memfile_notifier *notifier,
                .may_block      = true,
        };

        struct kvm *kvm = slot->kvm;
+
+       if (slot->private_offset > end)
+               return;
+

