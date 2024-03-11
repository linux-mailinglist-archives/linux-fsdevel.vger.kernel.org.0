Return-Path: <linux-fsdevel+bounces-14147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC54878646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 18:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E928385E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72455027F;
	Mon, 11 Mar 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R/+i/9VH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECF53E11;
	Mon, 11 Mar 2024 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177898; cv=fail; b=QnXQWFGO8wnz/BR/spj0Tynzi0OODaKvwNiLCkhxfLOiplM7ddrhsTfuOnEu3ZzLTU+/Q7M8oivn4LT6alcD1JY2bQKk6G3mGYyISQ1XvElAboAAZH3TSIV98y5RQRLUZSMHNTyHMhYp2GifNuDVdt6L6JUWnHH4DYPFoWOD42g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177898; c=relaxed/simple;
	bh=g7bsdKWbHEfcvW5bSUAEOjK3x2EFsWCmdeZhLWBXpVw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7FRH1aFd5VO+oysDhMTMwFc+hEwW82DI5ODcvCSVFazrqoiLDEFvBGR32D6tsxHZdHxSIaMKRRu2qm/fxZwZpirYfhkPRYVBh4wvlTvIvnVatx20bM7Wrqqt8QX/Ee4kfCiZQRkoGz380bl2InBg55n2oHIWZ6zBK/fM8BFO0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R/+i/9VH; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjG5yV2U8Ew2kmzPHmrg8HM917kEipGx0GhB+nRDspIDac/G/cxJHLwjUmHDn2ViFhXpHbAfMrHd8+i+tvBWRS3EjuKqrJkfa4AM01oO3jXvUAWBqESJgOp2Jehn1yKNsyc1AQN/YcD3pwJmi5XEJVLXjBBN3n4fuohLNv9d6xaO9C6Gx+wla9MRoLy1FI/feosOHxLPOJWYPNfnct3eHFJZRf+i+lmCv/p5PV/s6chEsU6uylFO0qLCdgZ0jlxNK7UUF9rLEMTwj1Tobe4bN7VjAq3ao8KBg1MgFTkllzzQIasAQT80o28hxcadqAEE+rnnvgK9MORIxdLmZ+j0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUjKg64qF1mY6nIpBIv45HQZ/e0UZydmi52FqmrvR4E=;
 b=hBKjFlNn22Vi1m+1KN1Ngk4aRM2m03ua6Z/gL0hOwN/m9AXOtB3BD5217odz3MsmB/WQ/QBVCs5PiWilN9ibQ+1j/KvhS1mNedEkuP4sogVE3pIPc4nps9rXD/bC8nPht1sM68i1Q6yMoWXuoQpWHcL9hWtXzHIqPj/bktAQ2064Pqwk9/5YjGHI/5xK902cCJsoTbuoxUKmIYCFhWKdCdBf9d10ec6/IO8MgETkCefnHfnaY56XKw4LRm9IpRAIB2xbiAgravfj6WBFRq6KKRkg+NmAI4X8uLGKKHxB47D1ODgD/RI+/DJNCGlNLYlWNnuf2rHkJu61XZiQx57BNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUjKg64qF1mY6nIpBIv45HQZ/e0UZydmi52FqmrvR4E=;
 b=R/+i/9VHyaAw0iaF+a5TGlc4kCbqsYiPO+925nzDOZ1UelU2h2SU0kvnnfnxkrdL0zL7ERD8KFVus4+PeZTYEAUUQGQwIyCcez17q0ziIKRPU3MsICRImNTTpoKu3W7jR0W5rTdKLSp7Lr5Jbzfqey2HygO/8vTxZZaCGLBvg2Y=
Received: from CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::25)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:24:54 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::61) by CH5P223CA0018.outlook.office365.com
 (2603:10b6:610:1f3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:24:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:24:52 -0500
Date: Mon, 11 Mar 2024 12:24:31 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Steven Price <steven.price@arm.com>, <kvm@vger.kernel.org>, "Suzuki K
 Poulose" <suzuki.poulose@arm.com>, "tabba@google.com" <tabba@google.com>,
	<linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <isaku.yamahata@intel.com>, <ackerleytng@google.com>,
	<vbabka@suse.cz>, <ashish.kalra@amd.com>, <nikunj.dadhania@amd.com>,
	<jroedel@suse.de>, <pankaj.gupta@amd.com>
Subject: Re: [PATCH RFC gmem v1 4/8] KVM: x86: Add gmem hook for invalidating
 memory
Message-ID: <20240311172431.zqymfqd4xlpd3pft@amd.com>
References: <20231016115028.996656-1-michael.roth@amd.com>
 <20231016115028.996656-5-michael.roth@amd.com>
 <e7125fcb-52b1-4942-9ae7-c85049e92e5c@arm.com>
 <ZcY2VRsRd03UQdF7@google.com>
 <84d62953-527d-4837-acf8-315391f4b225@arm.com>
 <ZcZBCdTA2kBoSeL8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZcZBCdTA2kBoSeL8@google.com>
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec0beee-e7f6-4d44-8e67-08dc41f02a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SkTich4ZthLpZbbZ4fp8VrAruH/g5K0F4mQlTSBF3dfX1e8opb4VKMtJd8/4pPxGMaRB1urjRqltX8IvltI4hocXrwWXS47aTCZS+7RirGlo7XZsuU6jAG1igLDkH+O98xUIjorNYeBBMwP8k0oncMDrZkfGS8fwDs04tIQyiXAJtF/Tv3H63+SgdTFtGKQJl8svjs5JFVl1hlLizLoBe+q/LayMfqyicXo0sdRE8FwY36OIWMPMXx5ASi0O7wDdvJcb/Tuy4jCjKSjHWSgW2xkPXW3+BfwwrBgC+V6THujvA325Ga94F7pcAO7T1gttZXB/L5acPd+5IxwmLnfS4qyMOIvIAN9rGHkF5vFoDbCJhA1N6Uh95gcr2M1Qg50g2mZb1ZPVLEEf5jsXHOB5NNRgf4IhiXZGDOhLeyvBKSq6sDJDMRX7iq0cfV2083A9bYl43hwZKZrh1Y+Cd5YC1RRmhO74TwB75BTFHDxga1iRBaydwzTOWj5fT9PrsQ5wDQP8uPkHIzJTeXhLhnC1UtzGvHMpdAMnw2tDZugx/GRE5rrfzree4X6f2ZbGJf5Z1Q4naKoVHS0MewOwj8I5nAmlfT1IAV9vsGrfY36J9+07V0d4bna+q05asUWnF1K2rIwd7pW41Efs3F4WPCbmFEgN+pitmlYxNC2hfjTJceXAVNVtAymQnF1fZsCMktZyNZF+TU7Zrsynec5X8utqsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:24:53.8266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec0beee-e7f6-4d44-8e67-08dc41f02a63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

On Fri, Feb 09, 2024 at 07:13:13AM -0800, Sean Christopherson wrote:
> On Fri, Feb 09, 2024, Steven Price wrote:
> > >> One option that I've considered is to implement a seperate CCA ioctl to
> > >> notify KVM whether the memory should be mapped protected.
> > > 
> > > That's what KVM_SET_MEMORY_ATTRIBUTES+KVM_MEMORY_ATTRIBUTE_PRIVATE is for, no?
> > 
> > Sorry, I really didn't explain that well. Yes effectively this is the
> > attribute flag, but there's corner cases for destruction of the VM. My
> > thought was that if the VMM wanted to tear down part of the protected
> > range (without making it shared) then a separate ioctl would be needed
> > to notify KVM of the unmap.
> 
> No new uAPI should be needed, because the only scenario time a benign VMM should
> do this is if the guest also knows the memory is being removed, in which case
> PUNCH_HOLE will suffice.
> 
> > >> This 'solves' the problem nicely except for the case where the VMM
> > >> deliberately punches holes in memory which the guest is using.
> > > 
> > > I don't see what problem there is to solve in this case.  PUNCH_HOLE is destructive,
> > > so don't do that.
> > 
> > A well behaving VMM wouldn't PUNCH_HOLE when the guest is using it, but
> > my concern here is a VMM which is trying to break the host. In this case
> > either the PUNCH_HOLE needs to fail, or we actually need to recover the
> > memory from the guest (effectively killing the guest in the process).
> 
> The latter.  IIRC, we talked about this exact case somewhere in the hour-long
> rambling discussion on guest_memfd at PUCK[1].  And we've definitely discussed
> this multiple times on-list, though I don't know that there is a single thread
> that captures the entire plan.
> 
> The TL;DR is that gmem will invoke an arch hook for every "struct kvm_gmem"
> instance that's attached to a given guest_memfd inode when a page is being fully
> removed, i.e. when a page is being freed back to the normal memory pool.  Something
> like this proposed SNP patch[2].
> 
> Mike, do have WIP patches you can share?

Sorry, I missed this query earlier. I'm a bit confused though, I thought
the kvm_arch_gmem_invalidate() hook provided in this patch was what we
ended up agreeing on during the PUCK call in question.

There was an open question about what to do if a use-case came along
where we needed to pass additional parameters to
kvm_arch_gmem_invalidate() other than just the start/end PFN range for
the pages being freed, but we'd determined that SNP and TDX did not
currently need this, so I didn't have any changes planned in this
regard.

If we now have such a need, what we had proposed was to modify
__filemap_remove_folio()/page_cache_delete() to defer setting
folio->mapping to NULL so that we could still access it in
kvm_gmem_free_folio() so that we can still access mapping->i_private_list
to get the list of gmem/KVM instances and pass them on via
kvm_arch_gmem_invalidate().

So that's doable, but it's not clear from this discussion that that's
needed. If the idea to block/kill the guest if VMM tries to hole-punch,
and ARM CCA already has plans to wire up the shared/private flags in
kvm_unmap_gfn_range(), wouldn't that have all the information needed to
kill that guest? At that point, kvm_gmem_free_folio() can handle
additional per-page cleanup (with additional gmem/KVM info plumbed in
if necessary).

-Mike


[1] https://lore.kernel.org/kvm/20240202230611.351544-1-seanjc@google.com/T/


> 
> [1] https://drive.google.com/corp/drive/folders/116YTH1h9yBZmjqeJc03cV4_AhSe-VBkc?resourcekey=0-sOGeFEUi60-znJJmZBsTHQ
> [2] https://lore.kernel.org/all/20231230172351.574091-30-michael.roth@amd.com

