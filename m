Return-Path: <linux-fsdevel+bounces-387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D087CA6F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294C51C20928
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9882629D;
	Mon, 16 Oct 2023 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NshltZec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E3250E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:51:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637EA8E;
	Mon, 16 Oct 2023 04:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6Mo6gtpAWSHb297iuFOIkhe4ZhUYn4BJqOwBgzMUVGgfT6Xkj29gmR0/7Vg/LAXnRcrze+EJk5ODIF7DtcksozIyA+Ur7fBfsK8MfrCgLrJUi2Tj4SFDF0ENZkFoWpxFOsNzx1p5O6XEZ5ftusFy2wMUQGJdHlyGxMARrEeg6+Ep82isl+8Zj67+iqDrzTIThBC9nY9s4wWMOp1DkGIcQyFkHbSuJ2K4nPQJ/KI11Lo0WEWGwgf3Tnaz0KyAmn8xOwW56jAe7oaFPccuaDpnagW4xSYYe74g6cshjCz0TlkOkSVTS9GpX88Ef1kANA60PJkehcyBAJjoxm9xL3fnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6r+AaXiMfP6DqpU50t2O7OQBg0H2kuK2cPCbe+iqdk=;
 b=Q5w8g3/cYNJF9zneXyYcmQ9dt8Qd99X8tvTRuUmXCyQkgyRS7wR20rnmozq0LcHhRfCg6fRfjafOhiSbZHHdnvcxd3ET/8d1HUxKEF1hWMWxTPxSx/NQNYPYiFi/coGnmcFbINk2NHUAI/awc1eFeSEtOn002gMNjoWoJG/9UgJuvRnqrovPDuuppyX43VUWMetJL6yAFwnRjZewmiYemvGr+F9/GVn4KRxRYyqPxf+vRKpl/RaCN5umSkKKgDa3bgVv3aU/49ZBydIRMweZiZwHQcJ51qGbZIXnqOGTHJYELB5RD+fOrFPMiYlh+oi/P7hAbnLzYNLNA1v9DQYpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6r+AaXiMfP6DqpU50t2O7OQBg0H2kuK2cPCbe+iqdk=;
 b=NshltZecGun76FF8SViCfMlPYMAHcIMboM+4VaWjCe558zKm7hiZWB/Ch20Bw65cSnrJoAbwtIGXRhAK9FTP9kjWfPTWsr99oaiwMztwKGoHzn3zSdX1p6UKD23YG3CIh406wK0mTEIymzGU/R4m0cNgeySp/BWC1aBOqr6lr1Q=
Received: from SN6PR05CA0001.namprd05.prod.outlook.com (2603:10b6:805:de::14)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 11:51:43 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::8e) by SN6PR05CA0001.outlook.office365.com
 (2603:10b6:805:de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Mon, 16 Oct 2023 11:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:51:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:51:42 -0500
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <isaku.yamahata@intel.com>,
	<ackerleytng@google.com>, <vbabka@suse.cz>, <ashish.kalra@amd.com>,
	<nikunj.dadhania@amd.com>, <jroedel@suse.de>, <pankaj.gupta@amd.com>
Subject: [PATCH RFC gmem v1 0/8] KVM: gmem hooks/changes needed for x86 (other archs?)
Date: Mon, 16 Oct 2023 06:50:20 -0500
Message-ID: <20231016115028.996656-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca35c15-0f6d-4fe7-f8ef-08dbce3e442e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T4US11wJ89oUft+hnZ1Jy/w+/NwzeyO//CRlDlAarxLuLcl0a+E5O2OyHYLPrIPMWzMGzR7euRKL0rdgwR3dBB7A8hutI56rjezoc486ESoyucE1P+QL9gO4rpolqQAPizXjOajBBS72svqtsbG/ZfmB5/03YsRqSy+YglkT7l43tIA2KcGLcqS23WjO9MRUKckte1rrBSOWypba0mHjf4mrGPf7KIQvG44TuyAF8MtmpDN5gLqu2QkjQre1pU3ALoalxuqAiLQ4xKQWK/ziZw9d/0wkP2W/YqLTWQtXVuWjNlyZyakjL+lMu8lTyjHMjRdTIUgRILzGMzfvtQZlFRw18Ai/Z7UD/jzr6e8AK3gnWoNv9PwEgol7Nfo28aawvjfWA/k+pD/oUQRUDH88/uJxgz/00qNP+8Z6qsE7ruyME/Ur44ycW+BVwmzxpc7A4r3A+B49ST1iP3pYidqM1CSmd0LxzjE04iRLXQotAS4oS8u/YP54NcAOno3VKHmh7xwucqDLrp34Ew3ucKWkH2/Ev4890RXCtRWQ8gXV1Wqz66ZixDfz0CpiX37g2ySejsW+koAdw1SWPYo9KIumsDtAEzLHk579CotVcKO05h2Zgpa2K2jcm0lkueQ3PrOk680ZTJ5v8Alim/k7IhSdra5vWm2wQm98Pk2O9LvLIJqynXSWwjN77XgfItpxzIv7reAZhwygrpLkozjVyimoQaASDGR4TgmLnbvXkgWG1Rx3Y1KFktbu4vpWCz4e6y5RHwxmFBbf06ujfPlzgL9e1butqkHWRzaDZWsCR8+58H4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(316002)(478600001)(966005)(54906003)(6916009)(70206006)(70586007)(6666004)(1076003)(26005)(336012)(426003)(16526019)(2616005)(7416002)(4326008)(8676002)(8936002)(2906002)(44832011)(5660300002)(41300700001)(36756003)(81166007)(86362001)(356005)(47076005)(36860700001)(83380400001)(82740400003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:51:42.9655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca35c15-0f6d-4fe7-f8ef-08dbce3e442e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset is also available at:

  https://github.com/mdroth/linux/commits/gmem-x86-v1-rfc

and is based on top of the kvm-x86 gmem tree (e7af8d17224a):

  https://github.com/kvm-x86/linux/commits/guest_memfd


== OVERVIEW ==

This is a series of patches that are currently needed for implementing
SEV-SNP hypervisor support on top of guest_memfd, but have a lot of
potential to overlap with changes that may be also be needed for TDX.

The goal of this series is to help reach a consensus on what
functionality implemented here is indeed common between SNP/TDX, and
try to finalize what these interfaces should look like so we can
incorporate them into a common gmem/x86 tree to base on top of to
reduce potential churn from the various SNP/TDX-specific patchsets.

A couple of the patches here are newer versions of patches that were
included in a similar series posted by Isaku here[1] that were revised
to incorporate feedback from Sean and others.

Some of the approaches implementated have deviated somewhat from what
may have been discussed/suggested on the list. For these cases I've
tried to provide my rationale below along with some relevant background
so that we can continue these discussions from where we left off and
reach a consensus on what these need to look like to be usable for both
SNP and TDX, and acceptable for gmem in general.


== Hooks for preparing gmem pages (patch #3) ==

The design here is mainly driven by this discussion with Sean[2]. In the
prior version used by v9 SNP hypervisor patchset[3] and included in
Isaku's patchset[1], this hook was triggered directly by KVM MMU just
prior to mapping it into the guest NPT/EPT to handle things like putting
it into the initial 'private' state as defined by the architecture (e.g.
'guest-owned' state in the SNP RMP table).

Sean was hoping to tie this update to allocation time rather than
mapping time, so it has more symmetry with the 'invalidation' side that
happens when the backing pages are freed back to the host, and allows
for better run-time performance if userspace opts to pre-allocate pages
in advance, since the cost of the 'preparation' hook could then also be
paid up front.

To accomodate this I changed this hook to trigger automatically when
a folio is allocated either via kvm_gmem_get_pfn(), or via an
fallocate() operation. There are a couple places in this implementation
where things fall a bit short of the original design goals however:

  1) For SNP, preparing a page as 'guest-owned' in the RMP table
     requires the GPA, which can only be known after the guest_memfd
     range that being allocated has been bound to a memslot, and there's
     no guarantee userspace won't attempt to fallocate() in advance of
     binding to a memslot unless we enforce that as part of the gmem
     API.

     Instead, this implementation simply attempts to call the prepare
     hook every time a folio is accessed via the common
     kvm_gmem_get_folio() path to ensure these 'deferred' preparation
     hooks will happen before KVM MMU maps any pages into a guest.
     Thus, it's up to the architecture/platform to keep track of
     whether a page is already in the 'prepared' state. For SNP this
     tracked via the RMP table itself, so we sort of already have this
     for free.

  2) AIUI the design proposed by Sean would involve gmem internally
     keeping track of whether or not a page/folio has already been
     prepared. As mentioned above, in the version we instead simply
     punt that tracking to the architecture.

     I experimented with tracking this inside gmem though, but it was a
     bit of a mis-start. I tried using an xarray to keep track of 2
     states: 'allocated'/'prepare', since both would be need if we
     wanted to be able to do things like handle deferred preparation
     hooks for situations like a memslot getting bound to a range that
     has already been allocated.

     The 'allocated' state was inferred based on whether an entry was
     present for a particular gmem offset, and the entry itself was a
     set of flags, 'prepared' being one of them. However, at the time
     there was a TODO[4] to investigate dropping the use of filemap in
     favor of doing that internally in gmem, and this seemed like it
     could be an intermediate step toward that, so I started heading
     down that road a bit by using higher-order/multi-index xarray
     entries with the thought of eventually being able to just track
     the folios themselves and drop reliance on filemap. This got messy
     quickly however and I dropped it once Paolo's investigations
     suggested that replacing filemap completely probably wouldn't be
     very worthwhile.[3]

     So maybe internally tracking 'allocated'/'prepared' states in gmem
     is more doable if we take a simpler approach like 4K-granularity
     xarrays or sparse bitmaps, or something else, but it's still
     enough additional complexity that I think it would be good to
     understand better what we really gain by doing this tracking in
     gmem. The one thing I can think of is the ability to immediately
     move already-allocated pages into the 'prepared' state if userspace
     decides to pre-allocate them prior to binding the range to a
     memslot, but I'm not sure how much that buys us performance-wise.
     At least for SNP, the initial guest payload will necessarily be
     put into 'prepared' state prior to boot, and anything other than
     that will need to go through the hole shared->private+PVALIDATE
     dance where saving on an RMPUPDATE in that path probably wouldn't
     make a huge difference.


== Hooks for invalidating gmem pages (patch #4) ==

In the prior version used by v9 SNP hypervisor patchset[3] and included
in Isaku's patchset[1], gmem calls these hooks directly during
hole-punching operations or during kvm_gmem_release() to make gmem
patches accessible to the host before freeing them.

There was an open TODO[4] for looking at making using of
.invalidate_folio, .evict_inode, and similar callbacks to handle this
sort of cleanup.

Toward that end I switched to using .free_folio to trigger these
arch-specific hooks since it seemed to be the most direct choice. What's
nice about that is even in the context of future support for things like
intra-host migration to support live update[5], where multiple gmem
instances might share an inode, there is less risk of one gmem instance
clobbering the other when it is release, since the reference counting on
the underlying inode will keep the inode alive.

One downside to using .free_folio is there is no metadata to pass along
with it: the callback gets PFN/order and that's it. For SNP this is
fine, but maybe for other platforms that's not enough to handle the
cleanup work.

If some sort of metadata *is* needed, .invalidate_folio is an option
since it can also pass along information associated with the folio via
folio_attach_private() and otherwise behaves similarly to .free_folio.
One major exception however it hole-punching, where splitting the folio
results in the private data being lost. And unlike normal pagecache
users, there aren't obvious points to re-attach it like read/write
operations on some file. So we'd probably need to do something like
scan for split folios in the hugepage-ranges that contain the range
that got hole-punched and re-attach the private data immeditely after
each hole-punch operation. That, or interesting some other flag to ask
mm/truncate.c to handle this for us. Or just stick with the prior
in Isaku's patchset[1].


== Determining whether #NPFs were for private access (patch #5-8) ==

This is mainly driven by these discussions[6][7], which suggest moving
toward special-casing handling based on VM type where necessary, but
consolidating around the use of the AMD-defined encryption bit to
encode whether a guest #NPF / EPT violation was for a private page or
not. Toward that end I defined the SNP vm type here and pulled in a
patch from the SNP patchset that introduces PFERR_GUEST_ENC_MASK, and
use those to initialize struct kvm_page_fault's .is_private field. My
that with TDX sythesizing the same PFERR_GUEST_ENC_MASK that logic
there would work the same for both TDX/SNP vm types.


== References ==

[1] https://lkml.kernel.org/kvm/CUU93XA8UKMG.X15YWDK533GB@suppilovahvero/t/
[2] https://lore.kernel.org/lkml/ZLqVdvsF11Ddo7Dq@google.com/
[3] https://lore.kernel.org/kvm/CABgObfZiS+e7oDbwuC1Uycsz8Mjsu-FSfSmu=3R0M71vUhpq_Q@mail.gmail.com/
[4] https://lore.kernel.org/kvm/ZOjpIL0SFH+E3Dj4@google.com/
[5] https://lore.kernel.org/lkml/ZN%2F81KNAWofRCaQK@google.com/t/
[6] https://lkml.kernel.org/kvm/ZJnXObRHhn5Q1dX2@google.com/
[7] https://lore.kernel.org/kvm/20230612042559.375660-1-michael.roth@amd.com/T/#me8a395cdf682068d8e5152c358016bf2fa4328e5


Any suggestions and feedback are very much appreciated.

-Mike

----------------------------------------------------------------
Brijesh Singh (1):
      KVM: x86: Define RMP page fault error bits for #NPF

Michael Roth (7):
      mm: Introduce AS_INACCESSIBLE for encrypted/confidential memory
      KVM: Use AS_INACCESSIBLE when creating guest_memfd inode
      KVM: x86: Add gmem hook for initializing memory
      KVM: x86: Add gmem hook for invalidating memory
      KVM: x86/mmu: Pass around full 64-bit error code for KVM page faults
      KVM: x86: Add KVM_X86_SNP_VM vm_type
      KVM: x86: Determine shared/private faults based on vm_type

 arch/x86/include/asm/kvm-x86-ops.h |  2 ++
 arch/x86/include/asm/kvm_host.h    | 13 +++++++
 arch/x86/include/uapi/asm/kvm.h    |  1 +
 arch/x86/kvm/mmu/mmu.c             | 15 +++++---
 arch/x86/kvm/mmu/mmu_internal.h    | 24 +++++++++++--
 arch/x86/kvm/mmu/mmutrace.h        |  2 +-
 arch/x86/kvm/mmu/paging_tmpl.h     |  2 +-
 arch/x86/kvm/x86.c                 | 21 ++++++++++-
 include/linux/kvm_host.h           | 18 ++++++++++
 include/linux/pagemap.h            |  1 +
 mm/truncate.c                      |  3 +-
 virt/kvm/Kconfig                   |  8 +++++
 virt/kvm/guest_memfd.c             | 71 +++++++++++++++++++++++++++++++++++---
 13 files changed, 165 insertions(+), 16 deletions(-)



