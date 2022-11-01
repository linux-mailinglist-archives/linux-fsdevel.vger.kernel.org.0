Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1761524A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 20:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKATbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKATbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:31:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A95510FF6;
        Tue,  1 Nov 2022 12:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iv9dMDUyEBuE3K2OzGlSTMOChorcOPwLTWlDbBYH0lV0siw8Mfp197zoUk1+OkqGyK32rFfffFYhvxhF4c1+EWvQPYFpAviVbNglq3YWrwb/BQIGvvOM1P6sq/rPcAShLXU7OngM/A8sIsJOISTJGEXkiyBR+wT+gHOSXPnOAnw1o+ttzPc2bE7bMs3VBEY96rD60syZOZrIOsNNup0YR19ZenlTIBRQmMLoacSagwM6z15coswyL/MTpc47V1awXcw+0qGT6ZO1ht3HkhW9C/QiW/ESSMljyQMWRL3unrntUnrzH/uxbSegJqUco/FHjyL/KGyoD53ShgBcsR9DcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFa3GDMV0g50ESwk/KTlS9VgrMdhFtnU/7Z9cnpDY7k=;
 b=gJruDmk/kYCn3Xtodth8XWHqNS+vm/inf3lzUi5UkIpbwUlShX5ZciLaDJTZFx8ZsCwjFW+8Vnv5myh83bXO73OhH1Whfpmfw+jzZ1gjJ2w/u2dVhsM2tPE1XQQpgwi5CNudsuzOpXO6uy9PmYGgWBtoELbtCTAd57xB2PX16pJFlND616PbERALa9ewWNEMOVzxJMYBa2dN6YkCLdYig43pPnmLXqd1efFQFmC+bekcp65d/IOXVIWO5YrX6zCzcPQFU5upVtL7GvqisC65mYHehxC+PnF7YcydVnQjYIe5ncSpy4VEP7ufDtPNG7z7JnnW2KWMYdyH9CAzSAdPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFa3GDMV0g50ESwk/KTlS9VgrMdhFtnU/7Z9cnpDY7k=;
 b=Yj81iFqhUxDtY7E9G7K1XkwKTl2nzbfT775Z2Y76ZgN7KyQIe9OE9rGIcO6+mGI77km2rsp+fceZRdvl/V/6BSeJkdRK2TqM4p9xoNR3QXWjBFGWIUc6Cb9VPCwLRx5wVvpjnzV6i9Ar1bM1lBD1njxS9N6ozQm+XYKPUMc1H7U=
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 19:31:18 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::1a) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Tue, 1 Nov 2022 19:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.21 via Frontend Transport; Tue, 1 Nov 2022 19:31:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 14:31:16 -0500
Date:   Tue, 1 Nov 2022 14:30:58 -0500
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
Message-ID: <20221101193058.tpzkap3kbrbgasqi@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221101113729.GA4015495@chaop.bj.intel.com>
 <20221101151944.rhpav47pdulsew7l@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221101151944.rhpav47pdulsew7l@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e667e3-64da-42b1-5b16-08dabc3fa5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzTQn/36RRLwjXj+/hYLOsXBbV3RsvZK5xTvdbsteLrsnmYyA9px7KWDeVkeKcwrXBGWPj6Efwq1Me7KihP2/B0O1I3X+T7YIOJmKSA5NapjZ4JZC1rd7V1+vfTcMnpXOe3P8+E5dyUOwIhP1dpcfMRPOSX1ZqXneKWy01LcJMguplfVn9UwPRw9YrApuWgpei8h/PbYKRxZ9Rfi/c8DK0WRSlYCEoCMcIzxR5/qYoSWTy8lIZzC0KNLYl3pMmDYjN9fSaT3zzBjhWnYpdu5BIlu+2n8Gwng1NYEnYObypktEgaIvg4JgNG3WHctzLld9TiVcKsyQg1/XCI1ZwrwYrpQT1YxYjILJimCoWrCwhTg7uM3EBCeBxIfj9HcFdv83jYyf5g96iK536taJPj9Psvez8ZFMdldZk1fWlpO+exDHy8m4wQECIZZVGq+lUyFBdiuApL3FonrYghEPQXHv9OqDQ+HOiPzdzFbwCsGXK+6eh1HEtAQxnZOYFx21wSwhFxdtK2oORbBNYgtUWV0EqHqU9Oh2mN1wFj/Z+wOnwuIvhvOLvPfvi8o2gnPnoQg28bISi6x3SD70qaMzynAHVZGbj9NersnouTI7J5uMRGc5UKBNKVwU/BUuf2OFdGnsfR+8Vt+m9g3FPKpbkXm+ChO3QsvMcB8ngmij2HvdlvWyZB9m3dY+H4qHT/xFZaEWCVCuxXPFq94kEyyvwVfvxZ7daBu/ZNnI4X3OYoB4PUEfhqxCrQbLidzlcYkigq6IMK+e13LJUd+5a0CIrEQUcrpS/ebMABWAKffykOg9Y6tuEUfetY4bIuMfryEVnsS13n05zBnb4FE8T1nuY7RSySAL8rJG3i5KG4sG65+ozDa5JUJxSSv8e4VAlPMwdmE+DiBIcKrr0Fqm+XZrlng2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(336012)(47076005)(186003)(426003)(4326008)(86362001)(83380400001)(7416002)(5660300002)(81166007)(82740400003)(356005)(44832011)(7406005)(2906002)(41300700001)(82310400005)(8936002)(70206006)(1076003)(36860700001)(16526019)(26005)(70586007)(45080400002)(40480700001)(478600001)(6666004)(316002)(54906003)(966005)(8676002)(40460700003)(2616005)(36756003)(6916009)(3714002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:31:17.6598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e667e3-64da-42b1-5b16-08dabc3fa5e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:19:44AM -0500, Michael Roth wrote:
> On Tue, Nov 01, 2022 at 07:37:29PM +0800, Chao Peng wrote:
> > On Mon, Oct 31, 2022 at 12:47:38PM -0500, Michael Roth wrote:
> > > On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> > 
> > > 
> > >   3) Potentially useful for hugetlbfs support:
> > > 
> > >      One issue with hugetlbfs is that we don't support splitting the
> > >      hugepage in such cases, which was a big obstacle prior to UPM. Now
> > >      however, we may have the option of doing "lazy" invalidations where
> > >      fallocate(PUNCH_HOLE, ...) won't free a shmem-allocate page unless
> > >      all the subpages within the 2M range are either hole-punched, or the
> > >      guest is shut down, so in that way we never have to split it. Sean
> > >      was pondering something similar in another thread:
> > > 
> > >        https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-mm%2FYyGLXXkFCmxBfu5U%40google.com%2F&amp;data=05%7C01%7CMichael.Roth%40amd.com%7C28ba5dbb51844f910dec08dabc1c99e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638029128345507924%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=bxcRfuJIgo1Z1G8HQ800HscE6y7RXRQwvWSkfc5M8Bs%3D&amp;reserved=0
> > > 
> > >      Issuing invalidations with folio-granularity ties in fairly well
> > >      with this sort of approach if we end up going that route.
> > 
> > There is semantics difference between the current one and the proposed
> > one: The invalidation range is exactly what userspace passed down to the
> > kernel (being fallocated) while the proposed one will be subset of that
> > (if userspace-provided addr/size is not aligned to power of two), I'm
> > not quite confident this difference has no side effect.
> 
> In theory userspace should not be allocating/hole-punching restricted
> pages for GPA ranges that are already mapped as private in the xarray,
> and KVM could potentially fail such requests (though it does currently).
> 
> But if we somehow enforced that, then we could rely on
> KVM_MEMORY_ENCRYPT_REG_REGION to handle all the MMU invalidation stuff,
> which would free up the restricted fd invalidation callbacks to be used
> purely to handle doing things like RMP/directmap fixups prior to returning
> restricted pages back to the host. So that was sort of my thinking why the
> new semantics would still cover all the necessary cases.

Sorry, this explanation is if we rely on userspace to fallocate() on 2MB
boundaries, and ignore any non-aligned requests in the kernel. But
that's not how I actually ended up implementing things, so I'm not sure
why answered that way...

In my implementation we actually do issue invalidations for fallocate()
even for non-2M-aligned GPA/offset ranges. For instance (assuming
restricted FD offset 0 corresponds to GPA 0), an fallocate() on GPA
range 0x1000-0x402000 would result in the following invalidations being
issued if everything was backed by a 2MB page:

  invalidate GPA: 0x001000-0x200000, Page: pfn_to_page(I), order:9
  invalidate GPA: 0x200000-0x400000, Page: pfn_to_page(J), order:9
  invalidate GPA: 0x400000-0x402000, Page: pfn_to_page(K), order:9

So you still cover the same range, but the arch/platform callbacks can
then, as a best effort, do things like restore 2M directmap if they see
that the backing page is 2MB+ and the GPA range covers the entire range.
If the GPA doesn't covers the whole range, or the backing page is
order:0, then in that case we are still forced to leave the directmap
split.

But with that in place we can then improve on that by allowing for the
use of hugetlbfs.

We'd still be somewhat reliant on userspace to issue fallocate()'s on
2M-aligned boundaries to some degree (guest teardown invalidations
could be issued as 2M-aligned, which would be the bulk of the pages
in most cases, but for discarding pages after private->shared
conversion we could still get fragmentation). This could maybe be
addressed by keeping track of those partial/non-2M-aligned fallocate()
requests and then issuing them as a batched 2M invalidation once all
the subpages have been fallocate(HOLE_PUNCH)'d. We'd need to enforce
that fallocate(PUNCH_HOLE) is preceeded by
KVM_MEMORY_ENCRYPT_UNREG_REGION to make sure MMU invalidations happen
though.

Not sure on these potential follow-ups, but they all at least seem
compatible with the proposed invalidation scheme.

-Mike

> 
> -Mike
> 
> > 
> > > 
> > > I need to rework things for v9, and we'll probably want to use struct
> > > folio instead of struct page now, but as a proof-of-concept of sorts this
> > > is what I'd added on top of v8 of your patchset to implement 1) and 2):
> > > 
> > >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommit%2F127e5ea477c7bd5e4107fd44a04b9dc9e9b1af8b&amp;data=05%7C01%7CMichael.Roth%40amd.com%7C28ba5dbb51844f910dec08dabc1c99e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638029128345507924%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=iv%2BOMPe5AZuUtIW6bCH%2BRhJPljS14JrTXbQXptLG9fM%3D&amp;reserved=0
> > > 
> > > Does an approach like this seem reasonable? Should be work this into the
> > > base restricted memslot support?
> > 
> > If the above mentioned semantics difference is not a problem, I don't
> > have strong objection on this.
> > 
> > Sean, since you have much better understanding on this, what is your
> > take on this?
> > 
> > Chao
> > > 
> > > Thanks,
> > > 
> > > Mike
