Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8BF614E34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 16:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiKAPUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiKAPUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:20:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E74C0D;
        Tue,  1 Nov 2022 08:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSs+JTlzPr8QqtV3Rkvvh5etYgfxg4eAyOwO8mdNcFlZx4iCJro+wKA2bz9XWbVVmJtW3RJSemxR84FqrjsJmDHHFNFP0PlhSZr3MmN1uSv8VCPwl03YwFBziTQW/htuf8Du8oaD1HfzZK25XMhfsm4ddaNeaNukcAfYcV/w4ErIlmInFNFWA+EOU9M/5YdK6/EFQNzeXeBN7oHyFr4h438cuE2uAr/fajn/gC4ZNLxKuxghdGMGeF1jdIKfrY/0vB2lvMiezhOSypMWcMo5KwJvUjizwBejijTSlGLjet9Odl7xNB7IdF/N5NnSD6x4Qr+sk9Ls5tEiVaCrmze/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SKoWoYcAKO/nnwiw3Q0uRIl4iyB1XAGG/11kmZPbT8=;
 b=Eb0ft1APpgNVzcmXB/fxNJEKplkbvUieLODuUBqxs4IdXL79Cp0div3T6PZQkykxgJKL7TjZJWLIdTd0uFsPX2kpeiVhMRWQzUhe3xUmLB6idZfHUB4+RYlHe4QRLH5kvC7/IuBRPEuw8wZyKRizB0A/gjsHV1wFmUCpzD0WUIPfH5f+OFm/s8RMtnluqaqtCjs1LkFMcYIUJEtosWsvUZoWocDfnj678HwA//14O43SlvP6hU7Yz6fAssgl6dizDJvx5hbqlpS1zAtvbAXOx39f3DFMm0htbs35HHve2rENCqFXrbSRMMRFL8S9lKyqt0iBBdYGOtGM4gsm5Oph7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SKoWoYcAKO/nnwiw3Q0uRIl4iyB1XAGG/11kmZPbT8=;
 b=LtML3CDP0Blbd4Fu6NzP6CBIm3CArWr5PzjnwPohwkSNhn3foFfbxp/gZ/7st02tL7XsvIo6y9iMR7CQi1nv+6EW0qNTAsMq35X2zG9LVp5Ldr6OthxaXFHxZzXZUUzzAyAUu86mHIZ8ZsPNT6BXEs22kx2vRLTG/A4i+qxDi4I=
Received: from DS7PR03CA0259.namprd03.prod.outlook.com (2603:10b6:5:3b3::24)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 15:20:02 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::53) by DS7PR03CA0259.outlook.office365.com
 (2603:10b6:5:3b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Tue, 1 Nov 2022 15:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 15:20:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 10:20:00 -0500
Date:   Tue, 1 Nov 2022 10:19:44 -0500
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
Message-ID: <20221101151944.rhpav47pdulsew7l@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221101113729.GA4015495@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221101113729.GA4015495@chaop.bj.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d0c1ae-a892-40ba-4aa0-08dabc1c8c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4IwM+kP159b8Z7zh5Kw34P4pqk8ijEe3MinBoWvsOCVrJBRNw0A6I5bGst2aswj7/grUgfU9ImSq0VUZH8eLRR+b5xoqLhFcYm9DNkDrMvedGjYT46mXMz3vYgabrwYhTSpofehOkATfkpXRdsStZ/WbDAZRkDJZKs2HRR6QJMwZDf9Zrwh0TLCTIvvwKC9YtDoGebXHWLCoySh9D0GmMGHGN9ofOVf3O3XBn13u+7Bt/vbNR1e/ysI/rZbjtyl/pVfni6/DqQczZy7iVj6qRuRZxFCY+oP+OfOIzMPwNGJsgTazOYlheg1YMasiG4KUQ8pbuFFbvuPRQOIZQWotkiD5/ebD+N2mVbshdv4TWErWjDVa95nbhvizWnreDIVY4zuePOuhR8jinQB03EH7Ok3H3ggAq8FTEKVs07FfqijC7fO8b4CGwqMH8OyQbsbnXzNAmoCpOJplcsQWBv8eIGaOcwyGlOR12l+4JpBqn2TZRyEtIRsDVoKkgsSVor+syiM2B+lTRsNkRGQbICIS/QdGi0w6URSojrxi4L7tbEq8Ildm6tHu1vqndywDIUkxDVdWW5g3luWuA9stmwIDgwtOmbRoVMej8tUxDa1N0P7ag052dqmOM2rIouavWZU9vZwPISaiBzmkYEeGIEGbEK5MYXRP7nb1jmaeWhV6rJpQ2VIWNl5A8DtklSbRVKgCr7OWkHmzkDTwVf+vpsFcwEjKfLxccCaosdVxYC/3oQVwjcEafpoLINNHtlvysgLFQVSCPNavp7IXQiXFXKcQO1dDOSwOIVs8LiNYrjR6D6JGElA5uZlw5JzYRT1Q/nHc0FVwjB6jrrtZokJ/kwco+WnOE4AJbaaBuvMXK3U3dyiSdz818vuLRZYalUfCcXJ5ncxQ8PQ2GdMOSx/juX1Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(966005)(478600001)(2906002)(186003)(1076003)(16526019)(336012)(2616005)(44832011)(41300700001)(70206006)(4326008)(6666004)(36756003)(54906003)(316002)(70586007)(8676002)(6916009)(83380400001)(82740400003)(40480700001)(40460700003)(45080400002)(82310400005)(47076005)(5660300002)(86362001)(426003)(7406005)(26005)(8936002)(7416002)(36860700001)(81166007)(356005)(3714002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 15:20:02.4128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d0c1ae-a892-40ba-4aa0-08dabc1c8c49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 07:37:29PM +0800, Chao Peng wrote:
> On Mon, Oct 31, 2022 at 12:47:38PM -0500, Michael Roth wrote:
> > On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > +struct restrictedmem_data {
> > > +	struct mutex lock;
> > > +	struct file *memfd;
> > > +	struct list_head notifiers;
> > > +};
> > > +
> > > +static void restrictedmem_notifier_invalidate(struct restrictedmem_data *data,
> > > +				 pgoff_t start, pgoff_t end, bool notify_start)
> > > +{
> > > +	struct restrictedmem_notifier *notifier;
> > > +
> > > +	mutex_lock(&data->lock);
> > > +	list_for_each_entry(notifier, &data->notifiers, list) {
> > > +		if (notify_start)
> > > +			notifier->ops->invalidate_start(notifier, start, end);
> > > +		else
> > > +			notifier->ops->invalidate_end(notifier, start, end);
> > > +	}
> > > +	mutex_unlock(&data->lock);
> > > +}
> > > +
> > > +static int restrictedmem_release(struct inode *inode, struct file *file)
> > > +{
> > > +	struct restrictedmem_data *data = inode->i_mapping->private_data;
> > > +
> > > +	fput(data->memfd);
> > > +	kfree(data);
> > > +	return 0;
> > > +}
> > > +
> > > +static long restrictedmem_fallocate(struct file *file, int mode,
> > > +				    loff_t offset, loff_t len)
> > > +{
> > > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > > +	struct file *memfd = data->memfd;
> > > +	int ret;
> > > +
> > > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > > +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > > +			return -EINVAL;
> > > +	}
> > > +
> > > +	restrictedmem_notifier_invalidate(data, offset, offset + len, true);
> > > +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> > > +	restrictedmem_notifier_invalidate(data, offset, offset + len, false);
> > > +	return ret;
> > > +}
> > 
> > In v8 there was some discussion about potentially passing the page/folio
> > and order as part of the invalidation callback, I ended up needing
> > something similar for SEV-SNP, and think it might make sense for other
> > platforms. This main reasoning is:
> 
> In that context what we talked on is the inaccessible_get_pfn(), I was
> not aware there is need for invalidation callback as well.

Right, your understanding is correct. I think Sean had only mentioned in
passing that it was something we could potentially do, and in the cases I
was looking at it ended up being useful. I only mentioned it so I don't
seem like I'm too far out in the weeds here :)

> 
> > 
> >   1) restoring kernel directmap:
> > 
> >      Currently SNP (and I believe TDX) need to either split or remove kernel
> >      direct mappings for restricted PFNs, since there is no guarantee that
> >      other PFNs within a 2MB range won't be used for non-restricted
> >      (which will cause an RMP #PF in the case of SNP since the 2MB
> >      mapping overlaps with guest-owned pages)
> 
> Has the splitting and restoring been a well-discussed direction? I'm
> just curious whether there is other options to solve this issue.

For SNP it's been discussed for quite some time, and either splitting or
removing private entries from directmap are the well-discussed way I'm
aware of to avoid RMP violations due to some other kernel process using
a 2MB mapping to access shared memory if there are private pages that
happen to be within that range.

In both cases the issue of how to restore directmap as 2M becomes a
problem.

I was also under the impression TDX had similar requirements. If so,
do you know what the plan is for handling this for TDX?

There are also 2 potential alternatives I'm aware of, but these haven't
been discussed in much detail AFAIK:

a) Ensure confidential guests are backed by 2MB pages. shmem has a way to
   request 2MB THP pages, but I'm not sure how reliably we can guarantee
   that enough THPs are available, so if we went that route we'd probably
   be better off requiring the use of hugetlbfs as the backing store. But
   obviously that's a bit limiting and it would be nice to have the option
   of using normal pages as well. One nice thing with invalidation
   scheme proposed here is that this would "Just Work" if implement
   hugetlbfs support, so an admin that doesn't want any directmap
   splitting has this option available, otherwise it's done as a
   best-effort.

b) Implement general support for restoring directmap as 2M even when
   subpages might be in use by other kernel threads. This would be the
   most flexible approach since it requires no special handling during
   invalidations, but I think it's only possible if all the CPA
   attributes for the 2M range are the same at the time the mapping is
   restored/unsplit, so some potential locking issues there and still
   chance for splitting directmap over time.

> 
> > 
> >      Previously we were able to restore 2MB mappings to some degree
> >      since both shared/restricted pages were all pinned, so anything
> >      backed by a THP (or hugetlb page once that is implemented) at guest
> >      teardown could be restored as 2MB direct mapping.
> > 
> >      Invalidation seems like the most logical time to have this happen,
> 
> Currently invalidation only happens at user-initiated fallocate(). It
> does not cover the VM teardown case where the restoring might also be
> expected to be handled.

Right, I forgot to add that in my proposed changes I added invalidations
for any still-allocated private pages present when the restricted memfd
notifier is unregistered. This was needed to avoid leaking pages back to
the kernel that still need directmap or RMP table fixups. I also added
similar invalidations for memfd->release(), since it seems possible that
userspace might close() it before shutting down guest, but maybe the
latter is not needed if KVM takes a reference on the FD during life of
the guest.

> 
> >      but whether or not to restore as 2MB requires the order to be 2MB
> >      or larger, and for GPA range being invalidated to cover the entire
> >      2MB (otherwise it means the page was potentially split and some
> >      subpages free back to host already, in which case it can't be
> >      restored as 2MB).
> > 
> >   2) Potentially less invalidations:
> >       
> >      If we pass the entire folio or compound_page as part of
> >      invalidation, we only needed to issue 1 invalidation per folio.
> 
> I'm not sure I agree, the current invalidation covers the whole range
> that passed from userspace and the invalidation is invoked only once for
> each usrspace fallocate().

That's true, it only reduces invalidations if we decide to provide a
struct page/folio as part of the invalidation callbacks, which isn't
the case yet. Sorry for the confusion.

> 
> > 
> >   3) Potentially useful for hugetlbfs support:
> > 
> >      One issue with hugetlbfs is that we don't support splitting the
> >      hugepage in such cases, which was a big obstacle prior to UPM. Now
> >      however, we may have the option of doing "lazy" invalidations where
> >      fallocate(PUNCH_HOLE, ...) won't free a shmem-allocate page unless
> >      all the subpages within the 2M range are either hole-punched, or the
> >      guest is shut down, so in that way we never have to split it. Sean
> >      was pondering something similar in another thread:
> > 
> >        https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-mm%2FYyGLXXkFCmxBfu5U%40google.com%2F&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C3aba56bf7d574c749ea708dabbfe2224%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638028997419628807%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=c7gSLjJEAxuX8xmMiTDMUHNwUdQNKN00xqtAZAEeow8%3D&amp;reserved=0
> > 
> >      Issuing invalidations with folio-granularity ties in fairly well
> >      with this sort of approach if we end up going that route.
> 
> There is semantics difference between the current one and the proposed
> one: The invalidation range is exactly what userspace passed down to the
> kernel (being fallocated) while the proposed one will be subset of that
> (if userspace-provided addr/size is not aligned to power of two), I'm
> not quite confident this difference has no side effect.

In theory userspace should not be allocating/hole-punching restricted
pages for GPA ranges that are already mapped as private in the xarray,
and KVM could potentially fail such requests (though it does currently).

But if we somehow enforced that, then we could rely on
KVM_MEMORY_ENCRYPT_REG_REGION to handle all the MMU invalidation stuff,
which would free up the restricted fd invalidation callbacks to be used
purely to handle doing things like RMP/directmap fixups prior to returning
restricted pages back to the host. So that was sort of my thinking why the
new semantics would still cover all the necessary cases.

-Mike

> 
> > 
> > I need to rework things for v9, and we'll probably want to use struct
> > folio instead of struct page now, but as a proof-of-concept of sorts this
> > is what I'd added on top of v8 of your patchset to implement 1) and 2):
> > 
> >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommit%2F127e5ea477c7bd5e4107fd44a04b9dc9e9b1af8b&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C3aba56bf7d574c749ea708dabbfe2224%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638028997419628807%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=jOFT0iLmeU7rKniEkWOsTf2%2FPI13EAw4Qm7arI1q970%3D&amp;reserved=0
> > 
> > Does an approach like this seem reasonable? Should be work this into the
> > base restricted memslot support?
> 
> If the above mentioned semantics difference is not a problem, I don't
> have strong objection on this.
> 
> Sean, since you have much better understanding on this, what is your
> take on this?
> 
> Chao
> > 
> > Thanks,
> > 
> > Mike
