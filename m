Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61362616F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 22:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKBVUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 17:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKBVUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:20:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7EE304;
        Wed,  2 Nov 2022 14:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxvdpgVAjo62W5q8fUbab6kop4vaBrJZl7NoGWGULLkXQaNPl7P6o5d7ADLzS1WaduHDwXLCPuwOfU590zaua1an4Knd4INkPMkIij7xCGr80+UwBXLYo0EvKLeWRcDLg7+KZ3EDdoU0JZQR3EYMgiWLnON8zH4rPrasGNCDTj8sfu6/S5TgiaGNUbRylFaUYgCmiYSPjxVdpqRqOk7NWBDZ9Ck0JZRlN91FVph2Qc8Qrz5cVqlv2lxOYAhLF+S07mczBBMGON2arIdMOGbjUAYUaNHTS3dIIxmvl3nFlC0ylArfUvJF2llgNixmF7Z0M3OkqKJM1MHK63oVir/rJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWEFacjGsc1xpoByb+j1GTZIZrwYvJX5+hDOn/0tepw=;
 b=O0W/EEQYsFMOvLzk779qobteXjgu9QKPiKpxmEs7JzsoyYasu83OOReveWzAAIGtDbdAggkUEB62sjTp0O1YXAwEtH+StuvzXaZVW63BvB6gQ4haeGWPQDBCSF3oYyVyygY5DWURrp+M6bJQZktekWNus1MHDW2gx4HbqxuEiyFwV3o+7Je2IKGH9dwZcaMaoT52p8cfR0PZtVaDELxO6cpEn+Ili/+u+PhuEGPWTzADwYZTArAxmHdaTDwdz/UCpRPfphzmr8aepqHqPpKtaRsk3gu/R4SW6i2ELAOfInwi9lAKcsjXXxR7l/x3fJY6JTuGMQcATloiChhxO92yTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWEFacjGsc1xpoByb+j1GTZIZrwYvJX5+hDOn/0tepw=;
 b=Pv8YQA+DWGO//0n3xhh54hGKNB23ZcPSPpha0tWlQSmSBKWfToxBLtc0jhAzNWDxPc95qDK0Jk9iTA6aBH6rgg1PrAH9RVDl5YdO2li4SHXlcE6KLonFPKXfQTboBEwtQiCKjubo5YgKAqym4onDgrXBRQCQ22Ga8C2GIf7M4yo=
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 21:19:58 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::1d) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Wed, 2 Nov 2022 21:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 21:19:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 16:19:57 -0500
Date:   Wed, 2 Nov 2022 16:19:41 -0500
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
Message-ID: <20221102211941.k2ronktwijhhzjfp@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221101113729.GA4015495@chaop.bj.intel.com>
 <20221101151944.rhpav47pdulsew7l@amd.com>
 <20221101193058.tpzkap3kbrbgasqi@amd.com>
 <20221102145325.GA4068513@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221102145325.GA4068513@chaop.bj.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: a682b897-62d0-4b47-ee1c-08dabd17fec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbnfRWxQZrKhQTzN8t7PA5P7ImpdJpwqItgfbDgi40s32+NJt2MxBpk7QBj3HKx+K18JaWqaYt3FAfh2mRpLetLrWGenDVRQd52PVzyrU07TNPrmG7ZHI5crM30Y1ju5TEnsqb3g9V9ieBL5O/7/RPKXl3DCdGB2zs73KGmMRr8rQAIosd2G4VEPhcHmYcMl7gJCigvswWqRm/ExILjqFB7+V40jHQfKMnTy+/Tsr/BnofS1qdPaxFpi5xPt6LOgjluL34xcROH7LeYeizIN95s5Reb28q0QFnV8EG8wpRhgg8COW5gmeWAcV/8neBTVKGcyQu7Echazao7tJxD2fk/1tqYDSPMnp6Og7dSxx084PcU2Jl7HPKPAugR/lj8iXJT81oriaSgyb3GLOpyDZlDx9LJByNtY4YVDhlZibSkqkBBX9rKFwxM+A2oWUjKvJU9Uv6DxD6h2NQpP6h8U1n2HfAmROJRBN2KQ6uNq1gAg2yic1CoqfnNJqZMDx1iQEa1RRgvBnXMf3A73TpgU4qxm9vZGXhEwOnEzW4RwaobdrHRU4E+F91scqqDEH6BYOg8hPntAP9dYE3Vxf01aTEKCLg2pdEzKCvP4qUwmjsuX8JMppX6rZx9jpV47Zl1XkK6wRoR4qw0V3LZD862/7Ypslm4Ak6SeFlxQIe5FSo4buBN8ymk94vVPaFiYJgurM8qlgDChfO0moX712j41TNVlkhdD6tdxBbu8xCtLKVDD45v9zjfZqLHQnls0RW5HYOXZ49EEfz1DRAaIB9FDTH+mTtSDa70eJ3bCkrH7w/wfBUMwnKy6+lihEUbrqgr0o+DFULj/oit30zn0mK18+DYxqYVY0dleIl/joYHM9WVZ7mWe9V9//ExNDpA/K1Sl37d1z+4sWslILILMNfeAvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(316002)(66899015)(6666004)(7406005)(70586007)(7416002)(45080400002)(6916009)(8936002)(54906003)(4326008)(41300700001)(70206006)(26005)(8676002)(2906002)(5660300002)(478600001)(30864003)(186003)(44832011)(1076003)(16526019)(966005)(336012)(2616005)(86362001)(82310400005)(36756003)(47076005)(82740400003)(83380400001)(81166007)(426003)(356005)(40480700001)(40460700003)(36860700001)(3714002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 21:19:58.2043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a682b897-62d0-4b47-ee1c-08dabd17fec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:53:25PM +0800, Chao Peng wrote:
> On Tue, Nov 01, 2022 at 02:30:58PM -0500, Michael Roth wrote:
> > On Tue, Nov 01, 2022 at 10:19:44AM -0500, Michael Roth wrote:
> > > On Tue, Nov 01, 2022 at 07:37:29PM +0800, Chao Peng wrote:
> > > > On Mon, Oct 31, 2022 at 12:47:38PM -0500, Michael Roth wrote:
> > > > > On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> > > > 
> > > > > 
> > > > >   3) Potentially useful for hugetlbfs support:
> > > > > 
> > > > >      One issue with hugetlbfs is that we don't support splitting the
> > > > >      hugepage in such cases, which was a big obstacle prior to UPM. Now
> > > > >      however, we may have the option of doing "lazy" invalidations where
> > > > >      fallocate(PUNCH_HOLE, ...) won't free a shmem-allocate page unless
> > > > >      all the subpages within the 2M range are either hole-punched, or the
> > > > >      guest is shut down, so in that way we never have to split it. Sean
> > > > >      was pondering something similar in another thread:
> > > > > 
> > > > >        https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-mm%2FYyGLXXkFCmxBfu5U%40google.com%2F&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C13192ae987b442f10b7408dabce2a4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638029978853935768%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Is%2Bfm3c9BGFmU%2Btn3ZgPPQnUeCK%2BhKPArsPrWY5JeSg%3D&amp;reserved=0
> > > > > 
> > > > >      Issuing invalidations with folio-granularity ties in fairly well
> > > > >      with this sort of approach if we end up going that route.
> > > > 
> > > > There is semantics difference between the current one and the proposed
> > > > one: The invalidation range is exactly what userspace passed down to the
> > > > kernel (being fallocated) while the proposed one will be subset of that
> > > > (if userspace-provided addr/size is not aligned to power of two), I'm
> > > > not quite confident this difference has no side effect.
> > > 
> > > In theory userspace should not be allocating/hole-punching restricted
> > > pages for GPA ranges that are already mapped as private in the xarray,
> > > and KVM could potentially fail such requests (though it does currently).
> > > 
> > > But if we somehow enforced that, then we could rely on
> > > KVM_MEMORY_ENCRYPT_REG_REGION to handle all the MMU invalidation stuff,
> > > which would free up the restricted fd invalidation callbacks to be used
> > > purely to handle doing things like RMP/directmap fixups prior to returning
> > > restricted pages back to the host. So that was sort of my thinking why the
> > > new semantics would still cover all the necessary cases.
> > 
> > Sorry, this explanation is if we rely on userspace to fallocate() on 2MB
> > boundaries, and ignore any non-aligned requests in the kernel. But
> > that's not how I actually ended up implementing things, so I'm not sure
> > why answered that way...
> > 
> > In my implementation we actually do issue invalidations for fallocate()
> > even for non-2M-aligned GPA/offset ranges. For instance (assuming
> > restricted FD offset 0 corresponds to GPA 0), an fallocate() on GPA
> > range 0x1000-0x402000 would result in the following invalidations being
> > issued if everything was backed by a 2MB page:
> > 
> >   invalidate GPA: 0x001000-0x200000, Page: pfn_to_page(I), order:9
> >   invalidate GPA: 0x200000-0x400000, Page: pfn_to_page(J), order:9
> >   invalidate GPA: 0x400000-0x402000, Page: pfn_to_page(K), order:9
> 
> Only see this I understand what you are actually going to propose;)
> 
> So the memory range(start/end) will be still there and covers exactly
> what it should be from usrspace point of view, the page+order(or just
> folio) is really just a _hint_ for the invalidation callbacks. Looks
> ugly though.

Yes that's accurate: callbacks still need to handle partial ranges, so
it's more of a hint/optimization for cases where callbacks can benefit
from knowing the entire backing hugepage is being invalidated/freed.

> 
> In v9 we use a invalidate_start/ invalidate_end pair to solve a race
> contention issue(https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fkvm%2FY1LOe4JvnTbFNs4u%40google.com%2F&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C13192ae987b442f10b7408dabce2a4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638029978853935768%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=zccj0lNcqBCxGVGLBYAD2BCkJuy75nTxFTSUMfDJjzM%3D&amp;reserved=0).
> To work with this, I believe we only need pass this hint info for
> invalidate_start() since at the invalidate_end() time, the page has
> already been discarded.

Ok, yah, that's the approach I'm looking at for v9: pass the page/order
for invalidate_start, but keep invalidate_end as-is.

> 
> Another worth-mentioning-thing is invalidate_start/end is not just
> invoked for hole punching, but also for allocation(e.g. default
> fallocate). While for allocation we can get the page only at the
> invalidate_end() time. But AFAICS, the invalidate() is called for
> fallocate(allocation) is because previously we rely on the existence in
> memory backing store to tell a page is private and we need notify KVM
> that the page is being converted from shared to private, but that is not
> true for current code and fallocate() is also not mandatory since KVM
> can call restrictedmem_get_page() to allocate dynamically, so I think we
> can remove the invalidation path for fallocate(allocation).

I actually ended up doing that for the v8 implementation, I figured it
was a holdover from before {REG,UNREG}_REGION were used, but too sure on
that so good to have some confirmation there.

> 
> > 
> > So you still cover the same range, but the arch/platform callbacks can
> > then, as a best effort, do things like restore 2M directmap if they see
> > that the backing page is 2MB+ and the GPA range covers the entire range.
> > If the GPA doesn't covers the whole range, or the backing page is
> > order:0, then in that case we are still forced to leave the directmap
> > split.
> > 
> > But with that in place we can then improve on that by allowing for the
> > use of hugetlbfs.
> > 
> > We'd still be somewhat reliant on userspace to issue fallocate()'s on
> > 2M-aligned boundaries to some degree (guest teardown invalidations
> > could be issued as 2M-aligned, which would be the bulk of the pages
> > in most cases, but for discarding pages after private->shared
> > conversion we could still get fragmentation). This could maybe be
> > addressed by keeping track of those partial/non-2M-aligned fallocate()
> > requests and then issuing them as a batched 2M invalidation once all
> > the subpages have been fallocate(HOLE_PUNCH)'d. We'd need to enforce
> > that fallocate(PUNCH_HOLE) is preceeded by
> > KVM_MEMORY_ENCRYPT_UNREG_REGION to make sure MMU invalidations happen
> > though.
> 
> Don't understand why the sequence matters here, we should do MMU
> invalidation for both fallocate(PUNCH_HOLE) and
> KVM_MEMORY_ENCRYPT_UNREG_REGION, right?

It should happen in both places as long as it's possible for userspace
to fallocate(PUNCH_HOLE) a private page while it is mapped to a guest.
I'm not necessarily suggesting we should make any changes there right
now, but...

We might need to consider changing that if we decide that we don't want
to allow userspace to basically force splitting the directmap by always
issuing fallocate(PUNCH_HOLE) for each 4K page rather than trying to do
it in 2M intervals when possible, since it would still result in 4K
invalidations being issued, such that optimizations like restoring the
2M directmap can't be done, even when backed by THPs or hugetlbfs pages.
One approach to deal with this is to introduce a bitmap (for instance) to
track what subpages have been fallocate(PUNCH_HOLE)'d, and defer the
actual free'ing/invalidation until a whole page has been marked for
deallocation. This would keep huge-pages/huge-invalidations intact even
if userspace is malicious/non-optimal and actively trying to slow the
host down by forcing the directmap to get split.

*If* we took that approach though, then the MMU invalidations would also
get deferred, which is bad. But if we added a check/callback that
restrictedfd.c could use to confirm that the page is already in a
shared/non-private state, then we'd know the MMU invalidation for the
private page must have already happened, so if anything got faulted in
afterward it should be a shared page. (Though I guess update_mem_attr
would also need to check this bitmap and fail for cases where a
shared->private conversion is issued for a page/range that's been
recorded as having been previously issued a deferred PUNCH_HOLE'd.

But that's only an optimization and probably needs a lot more thought,
not necessarily something I think we need to implement now.

-Mike

> 
> Thanks,
> Chao
> > 
> > Not sure on these potential follow-ups, but they all at least seem
> > compatible with the proposed invalidation scheme.
> > 
> > -Mike
> > 
> > > 
> > > -Mike
> > > 
> > > > 
> > > > > 
> > > > > I need to rework things for v9, and we'll probably want to use struct
> > > > > folio instead of struct page now, but as a proof-of-concept of sorts this
> > > > > is what I'd added on top of v8 of your patchset to implement 1) and 2):
> > > > > 
> > > > >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommit%2F127e5ea477c7bd5e4107fd44a04b9dc9e9b1af8b&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C13192ae987b442f10b7408dabce2a4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638029978854091987%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ghvLOpeqPz%2B6G593enT0p%2F3Ovh9rjHKtsuSQ2xObFHU%3D&amp;reserved=0
> > > > > 
> > > > > Does an approach like this seem reasonable? Should be work this into the
> > > > > base restricted memslot support?
> > > > 
> > > > If the above mentioned semantics difference is not a problem, I don't
> > > > have strong objection on this.
> > > > 
> > > > Sean, since you have much better understanding on this, what is your
> > > > take on this?
> > > > 
> > > > Chao
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Mike
