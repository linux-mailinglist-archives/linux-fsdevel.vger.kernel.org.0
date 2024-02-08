Return-Path: <linux-fsdevel+bounces-10691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9209284D722
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174DB1F22F3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2762AFC18;
	Thu,  8 Feb 2024 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1YtD7J8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FE2031E;
	Thu,  8 Feb 2024 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351884; cv=fail; b=vA44Qgb16ne57DnkbCR4ANqu6mW/FyB1AT/01WZAa/2IijchAOO3b3pdoNv2ixZk+L2Rx7bUg83zKM01x0vn2EJXfCkAOsa+8Ngbmfm4g1Xz0SNwnoQDWE94wLvhd2SlApfgqRUkZ27eJu270YoOPOh/vx0Ttmm2WA3x5A/30OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351884; c=relaxed/simple;
	bh=24P25l7WOVAQI9MXmURNl7SfRkxv1meyHJ91yk9qp1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIsngnCX6q8YR0ir8UiepHxSKHN4K1MeOUGMa6/baYVIsB/09lpIhduUoso0nIStcUDG4vU4HjfHBvGOlxreEVAn82C0DacU3RtxZod3tyvxYHZ7ZjeEqKq3zr9IIb7lnXMZ0748WlCYRBWi6OiHN4rQ91QTpe0SW7Gfmj7DtqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1YtD7J8G; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=da5i96kltwco148uw98uOhprLh+nfRKUtr2VA4j8UXFevJh++aI8PQ+Q1QTKFT3zEhCdRc6olllSgWmazDt9kE0oCCe+rlnwNLYDUPnpU/tTNwmUEhKFuyFVE0M7SgjbGQewyHchFJBvhhoy05ht/GJK5hf3Vqf/LVqcihLwcgAbH/kVsLgkpjXrjVuslBjmzg+g3wqQkrJfVElMHpfOKmeBCOmpdjHr0KMzm9G3H2sjeOVNlB6JJ5FVtaRnRD+M5DQFIBoLlw9F+QCEU2gQYpvkrDvfFh3o+ZMcuyYwfCDqW6Q8Lgx06HKWvtPTOndXCprEyb35XgENC3l5WvcQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CYBAY5yRIT9SKIkZFN8jpfkACBa/PVJwqDruYaCGOY=;
 b=kgZ2mrtIxxy/R3Q2hIGD5VWDpRjovlpGdKivFi/w/QbzVCAGp0Kq8gFYY+AOEZG8vCM8pJUPB46T76S+brZiZdegDuQZo75MQlJnsOFIHATiC3BqyqR6I8gs5EhHt3WXFgMlId7zKjLlh7Vqmk1nUnStPk5Q8m7NwRLtJd+zTyq5Kz3vQS1ar+KxjzCnta95hZG9N6TpO3cHNhhh2xCmGYT/B+9hltmoRfNwbj4qhgoqAALJmZTgvxkVAL9D+UUxp+OerbEcucm9JK9yBywKzBMPzCn3gCR6gMWrf3WJJSYdB4YUiTGk6e4ObZ9ipoNJrUr+wBTy/oWraIrxMdSyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CYBAY5yRIT9SKIkZFN8jpfkACBa/PVJwqDruYaCGOY=;
 b=1YtD7J8G6dEfDHKnjz5QjepfHP+uf/ZY0aiu0s+Jr+ouHzFcmNcT51v4atN/pVsuhzP8PkQ4ehdiQBMJLiNVZrqsLTvT42Fb5939IOaqmPcT/J3/yABuJLhHfMVCmEr9PbmajLorliPSpYRDZHi0mzrZlrTYrdmhlrZPOtnleRo=
Received: from BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 00:24:39 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::ba) by BYAPR07CA0086.outlook.office365.com
 (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 00:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:24:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:24:38 -0600
Date: Wed, 7 Feb 2024 18:24:20 -0600
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <isaku.yamahata@intel.com>, <ackerleytng@google.com>,
	<vbabka@suse.cz>, <ashish.kalra@amd.com>, <nikunj.dadhania@amd.com>,
	<jroedel@suse.de>, <pankaj.gupta@amd.com>, <thomas.lendacky@amd.com>
Subject: Re: [PATCH RFC gmem v1 8/8] KVM: x86: Determine shared/private
 faults based on vm_type
Message-ID: <20240208002420.34mvemnzrwwsaesw@amd.com>
References: <20231016115028.996656-1-michael.roth@amd.com>
 <20231016115028.996656-9-michael.roth@amd.com>
 <ZbmenP05fo8hZU8N@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZbmenP05fo8hZU8N@google.com>
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cf77cf-ad8e-40af-c1dc-08dc283c5688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BpLq/KEt89wK2BWexDAJoBmv1kYonYPuq8V6uE/+q2xPJRy8ohVWjQNNs1y+I1OgOqHnMYe0j58f/uPWMB83HFaSJTbJZv5ZwXLa+IyKLRowhxjvFwViD4vTToetTOf+AwsIphJYbL55ex+iRZbibrPOy4k97Y4a9R8WQDD6ZCfGnfKc+Wz0ZJLoyu0VYD4nLw9gdEyon9Yq4UYMZkPO3s0Ubf0sM5MLpJitHmYmRPmwcyQHiIA4TGvi8gTodAKtAMx0ACnSZPUB2C68vjoThdK8NVWJLUx7k9q7NBEiELqBSIRsbnrf4OFpt4Yq3lFXqQUwTtyc4cMn8fOcGt/QQ8LkXcpIH9u62R03QsqrPeQwW+gccXn0X0HhR/wdMJ2qJXsBtJ+Z22DX3q5tMx7hcRNXP9Bc2KHXP1Oe71RTl9q2d4CRPRV1frifqFJRCgntf3It325MMMHLtojAPH5f4Lz4GqblyGdEquzY8AkNw5MUUmbovGaFg5SJz4H5GKWlMaE7rSreAft5soLUCwcVBKCH/bHh1Cuo9/zznQJzam7gks6lehOMEnunJZcgU4Av02tH+fgCkpWRLBa56Lk2+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(86362001)(41300700001)(966005)(83380400001)(82740400003)(356005)(81166007)(336012)(426003)(8936002)(66899024)(6666004)(316002)(4326008)(6916009)(2906002)(5660300002)(36756003)(16526019)(26005)(70206006)(54906003)(7416002)(8676002)(44832011)(70586007)(2616005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:24:39.3001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cf77cf-ad8e-40af-c1dc-08dc283c5688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

On Tue, Jan 30, 2024 at 05:13:00PM -0800, Sean Christopherson wrote:
> On Mon, Oct 16, 2023, Michael Roth wrote:
> > For KVM_X86_SNP_VM, only the PFERR_GUEST_ENC_MASK flag is needed to
> > determine with an #NPF is due to a private/shared access by the guest.
> > Implement that handling here. Also add handling needed to deal with
> > SNP guests which in some cases will make MMIO accesses with the
> > encryption bit.
> 
> ...
> 
> > @@ -4356,12 +4357,19 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  			return RET_PF_EMULATE;
> >  	}
> >  
> > -	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> > +	/*
> > +	 * In some cases SNP guests will make MMIO accesses with the encryption
> > +	 * bit set. Handle these via the normal MMIO fault path.
> > +	 */
> > +	if (!slot && private_fault && kvm_is_vm_type(vcpu->kvm, KVM_X86_SNP_VM))
> > +		private_fault = false;
> 
> Why?  This is inarguably a guest bug.

AFAICT this isn't explicitly disallowed by the SNP spec. There was
however a set of security mitigations for SEV-ES that resulted in this
being behavior being highly discouraged in linux guest code:

  https://lkml.org/lkml/2020/10/20/464  

as well as OVMF guest code:

  https://edk2.groups.io/g/devel/message/69948

However the OVMF guest code still allows 1 exception for accesses to the
local APIC base address, which is the only case I'm aware of that
triggers this condition:

  https://github.com/tianocore/edk2/blob/master/OvmfPkg/Library/CcExitLib/CcExitVcHandler.c#L100

I think the rationale there is that if the guest absolutely *knows* that
encrypted information is not stored at a particular MMIO address, then
it can selectively choose to allow for exceptional cases like these. So
KVM would need to allow for these cases in order to be fully compatible
with existing SNP guests that do this.

> 
> > +	if (private_fault != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> >  		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> >  		return -EFAULT;
> >  	}
> >  
> > -	if (fault->is_private)
> > +	if (private_fault)
> >  		return kvm_faultin_pfn_private(vcpu, fault);
> >  
> >  	async = false;
> > diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> > index 759c8b718201..e5b973051ad9 100644
> > --- a/arch/x86/kvm/mmu/mmu_internal.h
> > +++ b/arch/x86/kvm/mmu/mmu_internal.h
> > @@ -251,6 +251,24 @@ struct kvm_page_fault {
> >  
> >  int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
> >  
> > +static bool kvm_mmu_fault_is_private(struct kvm *kvm, gpa_t gpa, u64 err)
> > +{
> > +	bool private_fault = false;
> > +
> > +	if (kvm_is_vm_type(kvm, KVM_X86_SNP_VM)) {
> > +		private_fault = !!(err & PFERR_GUEST_ENC_MASK);
> > +	} else if (kvm_is_vm_type(kvm, KVM_X86_SW_PROTECTED_VM)) {
> > +		/*
> > +		 * This handling is for gmem self-tests and guests that treat
> > +		 * userspace as the authority on whether a fault should be
> > +		 * private or not.
> > +		 */
> > +		private_fault = kvm_mem_is_private(kvm, gpa >> PAGE_SHIFT);
> > +	}
> 
> This can be more simply:
> 
> 	if (kvm_is_vm_type(kvm, KVM_X86_SNP_VM))
> 		return !!(err & PFERR_GUEST_ENC_MASK);
> 
> 	if (kvm_is_vm_type(kvm, KVM_X86_SW_PROTECTED_VM))
> 		return kvm_mem_is_private(kvm, gpa >> PAGE_SHIFT);
> 

Yes, indeed. But TDX has taken a different approach for SW_PROTECTED_VM
case where they do this check in kvm_mmu_page_fault() and then synthesize
the PFERR_GUEST_ENC_MASK into error_code before calling
kvm_mmu_do_page_fault(). It's not in the v18 patchset AFAICT, but it's
in the tdx-upstream git branch that corresponds to it:

  https://github.com/intel/tdx/commit/3717a903ef453aa7b62e7eb65f230566b7f158d4

Would you prefer that SNP adopt the same approach?

-Mike

