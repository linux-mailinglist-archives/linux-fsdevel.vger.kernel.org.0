Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4504F5496
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 07:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355494AbiDFFQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 01:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452611AbiDFCnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:43:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E11F28D28B;
        Tue,  5 Apr 2022 16:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LveaNtaSuUFsKQZNo9u12G929P/fOz10P6C1+wSkvLepE3BpdBWqoDiA09TMOUOzgUX056BClR59SV8t4TmBQqHTy77O4orv5AmUVYM060Gn/wx9lIJ3RhN/rZibsm7nRwhWe9vT6DiHpWvhfX+To6FxiVIRBO83u4h9XGxUTndpmDRLnbfZRioCeeXSHP2GTnzAiHIOC4OtEG1bnY+GkduGA42oNzkpaJKR1hCdGk1eNUur1Dbns/iHUxTQldGUC86n30DOZCpjaQM4BBtTwcc5qNvPPGMEk6pF+35UXtShd+Wk9IipXyR93M+6Xn06lk1Lyg4zQ3h5d+VVsgjqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cTshoiNEzUhGR2N20KDEn2hbEIxXYt9QGCpMSh1uHo=;
 b=gYxWWY5DsZpj4ARk6+0V2BRqLn10OZtoF9tFMsPD5i+POSMLtYIH0HN+PfoWgCMcNfWBzmxBT7ACFswXFPlMts3vx3qhXiGjM3udoOAZ7VcplnEqIQBaYMWcV9W5X4r3EEfWH9BPmGZ+0nSLmGohx1JlXyScA59XeWAWwsrQKZVuO/Kc1jePHX9io1F2dlilrdC8wleypo1GI21wrvg3z/axqg/qf4sh8EAAMdTeG4OTWdjXgTpAAwpNgCyC8OwA64AW16iaE/8dM0uxv5ZU0Wk2XfL/s+w8X0l2MvdRmHoAqL/M5gXreSOWzxorgT7QHWppwhFxb2aPbVU6DS7wSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cTshoiNEzUhGR2N20KDEn2hbEIxXYt9QGCpMSh1uHo=;
 b=YrrAjNz9c2cgYOURCzgoMRBdWzh79Y+gkWnT3srwH3Dn5OenPZRKQYTZqOH0tooIvInMGtD9VBINmS96H4PRorikZ9pqA7pqm5pfvvKppR55RMeXdKT82Mq1FbO+AyJ5YBySkpehs2KgvhhcN3bM6VSpQt8pqi2eULG0ZW3eaRQ=
Received: from DM6PR08CA0059.namprd08.prod.outlook.com (2603:10b6:5:1e0::33)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 23:45:59 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::8b) by DM6PR08CA0059.outlook.office365.com
 (2603:10b6:5:1e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 23:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 5 Apr 2022 23:45:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 18:45:57 -0500
Date:   Tue, 5 Apr 2022 18:45:35 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <qemu-devel@nongnu.org>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <luto@kernel.org>, <jun.nakajima@intel.com>,
        <dave.hansen@intel.com>, <ak@linux.intel.com>, <david@redhat.com>
Subject: Re: [PATCH v5 11/13] KVM: Zap existing KVM mappings when pages
 changed in the private fd
Message-ID: <20220405234535.ijctzcbxkat2o5ij@amd.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-12-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-12-chao.p.peng@linux.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77618f83-6c49-40be-2dd0-08da175e6f27
X-MS-TrafficTypeDiagnostic: MN2PR12MB4141:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4141D943198D04652D37D5C995E49@MN2PR12MB4141.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NCX5iVgeL6lMXvrQu71D7WH4LHSXqlU6q4TanIp667EOq626HQ189DKD9c6OAezbrWcpwnikujhp4WRyIj+18eTX5muys5qvxRr+NJJV3ilkHFepi5QeoaeIX1gwkVbUFdFa9/6is2M6jkfA33123LfsSIK2DSrkb/D/5p8sDEM4ZfbNuXG0Wf3wdAmCQxZnaZfRqFBHOvDReU+fnKk1Yum7nWNTzWUqY8w4WMJaKzdUOf+I8t2CP8NiitOqMWZinxgdFiaZEXt5FR8CnhvbR2AfZC/xWctMREXie9tWlKXcMXJwgPU6GQIJB3wkznZRRM1WH1Y4HPZFzTd217KTJ3wLBNgkuHLr6XdkjE1wYUzYZPpnnyS6pojuwTll3D9FSTzDIIUdktu963+LfGGXqb5wi+LcRUelEIb/SqDzhQPUGmo4YG7Qe5cnmTFklobeW05LSZYKLFVqeJk2AvIGgj6DY6d1XK+EwYS8clvqPW6uVofMnKye0kZOWl3OCEeSDcbXJshVeonoduES1u7xnUz8BVBKzkFcbOZnlW35nfIYel2eO0nSWixlTAPAJnN79JFgYS80DwHPyKCyd6zOickt+SW4Qv24AhC654xQMy0T5vlRZVxIpaN+9y7pHPSvLbXEfgxgMY9LMVyWJnRDp9DiNuoCcElAlMnjU4lXnzEuHxTV4Pb8AZRurrzvrrt9mHBeH/8YNDaPpVzQnADMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(16526019)(36860700001)(508600001)(36756003)(186003)(54906003)(6916009)(356005)(1076003)(26005)(40460700003)(2616005)(336012)(316002)(426003)(44832011)(82310400005)(7416002)(8676002)(86362001)(5660300002)(2906002)(4326008)(70206006)(70586007)(7406005)(47076005)(6666004)(8936002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 23:45:58.4299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77618f83-6c49-40be-2dd0-08da175e6f27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:09:09PM +0800, Chao Peng wrote:
> KVM gets notified when memory pages changed in the memory backing store.
> When userspace allocates the memory with fallocate() or frees memory
> with fallocate(FALLOC_FL_PUNCH_HOLE), memory backing store calls into
> KVM fallocate/invalidate callbacks respectively. To ensure KVM never
> maps both the private and shared variants of a GPA into the guest, in
> the fallocate callback, we should zap the existing shared mapping and
> in the invalidate callback we should zap the existing private mapping.
> 
> In the callbacks, KVM firstly converts the offset range into the
> gfn_range and then calls existing kvm_unmap_gfn_range() which will zap
> the shared or private mapping. Both callbacks pass in a memslot
> reference but we need 'kvm' so add a reference in memslot structure.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/kvm_host.h |  3 ++-
>  virt/kvm/kvm_main.c      | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 9b175aeca63f..186b9b981a65 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -236,7 +236,7 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
>  #endif
>  
> -#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
> +#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_MEMFILE_NOTIFIER)
>  struct kvm_gfn_range {
>  	struct kvm_memory_slot *slot;
>  	gfn_t start;
> @@ -568,6 +568,7 @@ struct kvm_memory_slot {
>  	loff_t private_offset;
>  	struct memfile_pfn_ops *pfn_ops;
>  	struct memfile_notifier notifier;
> +	struct kvm *kvm;
>  };
>  
>  static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 67349421eae3..52319f49d58a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -841,8 +841,43 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>  
>  #ifdef CONFIG_MEMFILE_NOTIFIER
> +static void kvm_memfile_notifier_handler(struct memfile_notifier *notifier,
> +					 pgoff_t start, pgoff_t end)
> +{
> +	int idx;
> +	struct kvm_memory_slot *slot = container_of(notifier,
> +						    struct kvm_memory_slot,
> +						    notifier);
> +	struct kvm_gfn_range gfn_range = {
> +		.slot		= slot,
> +		.start		= start - (slot->private_offset >> PAGE_SHIFT),
> +		.end		= end - (slot->private_offset >> PAGE_SHIFT),
> +		.may_block 	= true,
> +	};
> +	struct kvm *kvm = slot->kvm;
> +
> +	gfn_range.start = max(gfn_range.start, slot->base_gfn);
> +	gfn_range.end = min(gfn_range.end, slot->base_gfn + slot->npages);
> +
> +	if (gfn_range.start >= gfn_range.end)
> +		return;
> +
> +	idx = srcu_read_lock(&kvm->srcu);
> +	KVM_MMU_LOCK(kvm);
> +	kvm_unmap_gfn_range(kvm, &gfn_range);
> +	kvm_flush_remote_tlbs(kvm);
> +	KVM_MMU_UNLOCK(kvm);
> +	srcu_read_unlock(&kvm->srcu, idx);

Should this also invalidate gfn_to_pfn_cache mappings? Otherwise it seems
possible the kernel might end up inadvertantly writing to now-private guest
memory via a now-stale gfn_to_pfn_cache entry.
