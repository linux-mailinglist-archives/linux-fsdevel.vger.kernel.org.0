Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3995207D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 00:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiEIWio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 18:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiEIWiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 18:38:24 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DA2BB2F4;
        Mon,  9 May 2022 15:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X93LAsFWjwE6Dtv/yV0N9p3Ntu78GkPNZ3LlcSy2T4BXvRtuqV3Qsh/0o4gGt6WAxXoYl7RNt4Z0puVXcqRFc+WWurkSqIF664csLpq0siPfDnLQwjzCEbi6AIEq+UBpwcad35Ryq3AAfELY52Kh4/W0szLloPOkJohgvqotiWlgl79jojE0S+3UUQVCjFXfizFtE2rzB05Leil1o+5CmOps0pq0BlOqdOpfn6y8KooP2f00VMYoQAoDcxTt1CQtNFoE5gdXtZzif01yuL9WTZSCYDxw72K/O5imlCFt/mT1FAApoERJB7j0U8l2M2MHmLT9KPq2tD3uRPietZdMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV9Kg2j0DRdyfUDBha8NBvq1F6CoqYZbTd7tDpPG1Pc=;
 b=esm65ZbeMJvbHrFv81JbUgIwWp7ybDIjCQjuoe1YyXLZxn6g1VQZCOAXyzmt9aNoOJyVmczDHy5yQblhcM4DcY9Iz/4j6PGvKq3JIcCvcrN2r/bHwyPpbht6dCXV7qc+T96G6C7y+JNHeU+Bvx9roK5icFPWIaYQ+2OCQMqk+QeRl9Z3tk1G1Zsq0wdE1ZJkIG+S+1dxOVWD+iOd3zcyU7z2FEA/REqm5RaR4mA/Cm+5VMHga7Oxl9VZ/Kq+WspXefufeq6MAIXGnR76P2pS0duPs5w23YzbnRHsgvT+ixsS4jCTK8wIbhSdtr5bDUBtxFD1bdRh88qI4cZbu7dGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV9Kg2j0DRdyfUDBha8NBvq1F6CoqYZbTd7tDpPG1Pc=;
 b=QMa/0fhShXlihhcCYR/qsL0eRXxEnxHOX2R0199QDQFMGO+TX3qvLLRT0UydqI4EOZnMUSN30d0nOgQOKskmNYd/nwhuQnmJ+NPJIaKrdExFw6AZhGC9Xs9kL7ryM2h8NNFnMkiyBL0/5ib3VXMwICm0mzWYQJ3NmeykAxsM42Q=
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by BN8PR12MB3522.namprd12.prod.outlook.com (2603:10b6:408:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 22:34:24 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::e9) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Mon, 9 May 2022 22:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 22:34:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 17:34:20 -0500
Date:   Mon, 9 May 2022 17:30:56 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
CC:     Sean Christopherson <seanjc@google.com>,
        Quentin Perret <qperret@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Price <steven.price@arm.com>,
        kvm list <kvm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        <nikunj@amd.com>, <ashish.kalra@amd.com>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220509223056.pyazfxjwjvipmytb@amd.com>
References: <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com>
 <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
 <YkyEaYiL0BrDYcZv@google.com>
 <20220422105612.GB61987@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220422105612.GB61987@chaop.bj.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73f7ec9f-689c-4cfc-d086-08da320c11e7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3522:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3522C449B7012E298786098C95C69@BN8PR12MB3522.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVePioz6TbXO5OlI9pH/XBKEZJwep9E6h940Fu0MLgEl6X7DkNM7fm6u/iksmou+dSFgXgrptH7IoanQdhsmFMviftkBuhuRKfrofkKbYe6lYqR5IvdFAVUUgId7aV2+01ohe+2NnaANPGtanRiYWwQ0LQxOccTB++B8MJGKBJn42xCraQtvVDK35K4MtLgioADSBlrylQYmVH0sJIjSXNd4GOxNKC7NhitvOTLrvwnyfL40jRSL0Ib25xi+zP4mflnHIoBvQCNSGJFvVe9e6Z8w3Wn4NczxXRcnI4c6baor9radDEz3sfHkS8MU+ejv77mbMRYHZZQjau93k6qlbIfakxizoKjixuoVUOmvY0bQyMF/mxnTJgDAE2+ZeEcTcPP1H9wA2PN7ki+e+KtbxTbVfxDnTYPlACbuBRQTi7xtbaHk5eo5phC7rxdaWfxVQjoPoCk8P6l5QbNC3T3YMNc9C1G4B2+2pCrpRpIiOWMMNU3sYnxf2tV8rq9CEBWUBnywjoO8BRmDAOqaHtwLTNOEL64o2ht7lC572E/tKghlkZik9qLLnAUV01Kz9tQnXbP9ALQJKnOs+1AZT+LUwQeU4Ly4sSOLCQWIkcd8wFDUUij+ajATVO6EHSr+/juRGkPsIiLRotNZWDejKpSFXjKjPdJzhCzF40VQ+Q2AzV4boEx7nSs1pjQext4SVFVvr5tO612+Kfwq5VWqKGOHPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(1076003)(2616005)(54906003)(86362001)(6916009)(4326008)(316002)(8936002)(356005)(6666004)(26005)(81166007)(70586007)(8676002)(3716004)(44832011)(508600001)(2906002)(40460700003)(426003)(82310400005)(336012)(7406005)(83380400001)(47076005)(16526019)(7416002)(5660300002)(186003)(36756003)(36860700001)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 22:34:24.7122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f7ec9f-689c-4cfc-d086-08da320c11e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 06:56:12PM +0800, Chao Peng wrote:
> Great thanks for the discussions. I summarized the requirements/gaps and the
> potential changes for next step. Please help to review.

Hi Chao,

Thanks for writing this up. I've been meaning to respond, but wanted to
make a bit more progress with SNP+UPM prototype to get a better idea of
what's needed on that end. I've needed to make some changes on the KVM
and QEMU side to get things working so hopefully with your proposed
rework those changes can be dropped.

> 
> 
> Terminologies:
> --------------
>   - memory conversion: the action of converting guest memory between private
>     and shared.
>   - explicit conversion: an enlightened guest uses a hypercall to explicitly
>     request a memory conversion to VMM.
>   - implicit conversion: the conversion when VMM reacts to a page fault due
>     to different guest/host memory attributes (private/shared).
>   - destructive conversion: the memory content is lost/destroyed during
>     conversion.
>   - non-destructive conversion: the memory content is preserved during
>     conversion.
> 
> 
> Requirements & Gaps
> -------------------------------------
>   - Confidential computing(CC): TDX/SEV/CCA
>     * Need support both explicit/implicit conversions.
>     * Need support only destructive conversion at runtime.
>     * The current patch should just work, but prefer to have pre-boot guest
>       payload/firmware population into private memory for performance.

Not just performance in the case of SEV, it's needed there because firmware
only supports in-place encryption of guest memory, there's no mechanism to
provide a separate buffer to load into guest memory at pre-boot time. I
think you're aware of this but wanted to point that out just in case.

> 
>   - pKVM
>     * Support explicit conversion only. Hard to achieve implicit conversion,
>       does not record the guest access info (private/shared) in page fault,
>       also makes little sense.
>     * Expect to support non-destructive conversion at runtime. Additionally
>       in-place conversion (the underlying physical page is unchanged) is
>       desirable since copy is not disirable. The current destructive conversion
>       does not fit well.
>     * The current callbacks between mm/KVM is useful and reusable for pKVM.
>     * Pre-boot guest payload population is nice to have.
> 
> 
> Change Proposal
> ---------------
> Since there are some divergences for pKVM from CC usages and at this time looks
> whether we will and how we will support pKVM with this private memory patchset
> is still not quite clear, so this proposal does not imply certain detailed pKVM
> implementation. But from the API level, we want this can be possible to be future
> extended for pKVM or other potential usages.
> 
>   - No new user APIs introduced for memory backing store, e.g. remove the
>     current MFD_INACCESSIBLE. This info will be communicated from memfile_notifier
>     consumers to backing store via the new 'flag' field in memfile_notifier
>     described below. At creation time, the fd is normal shared fd. At rumtime CC
>     usages will keep using current fallocate/FALLOC_FL_PUNCH_HOLE to do the
>     conversion, but pKVM may also possible use a different way (e.g. rely on
>     mmap/munmap or mprotect as discussed). These are all not new APIs anyway.

For SNP most of the explicit conversions are via GHCB page-state change
requests. Each of these PSC requests can request shared/private
conversions for up to 252 individual pages, along with whether or not
they should be treated as 4K or 2M pages. Currently, like with
KVM_EXIT_MEMORY_ERROR, these requests get handled in userspace and call
back into the kernel via fallocate/PUNCH_HOLE calls.

For each fallocate(), we need to update the RMP table to mark a page as
private, and for PUNCH_HOLE we need to mark it as shared (otherwise it
would be freed back to the host as guest-owned/private and cause a crash if
the host tries to re-use it for something). I needed to add some callbacks
to the memfile_notifier to handle these RMP table updates. There might be
some other bits of book-keeping like clflush's, and adding/removing guest
pages from the kernel's direct map.

Not currently implemented, but the guest can also issue requests to
"smash"/"unsmash" a 2M private range into individual 4K private ranges
(generally in advance of flipping one of the pages to shared, or
vice-versa) in the RMP table. Hypervisor code tries to handle this
automatically, by determining when to smash/unsmash on it's own, but...

I'm wondering how all these things can be properly conveyed through this
fallocate/PUNCH_HOLE interface if we ever needed to add support for all
of this, as it seems a bit restrictive as-is. For instance, with the
current approach, one possible scheme is:

  - explicit conversion of shared->private for 252 4K pages:
    - we could do 252 individual fallocate()'s of 4K each, and make sure the
      kernel code will do notifier callbacks / RMP updates for each individual
      4K page

  - shared->private for 252 2M pages:
    - we could do 252 individual fallocate()'s of 2M each, and make sure the
      kernel code will do notifier callbacks / RMP updates for each individual
      2M page

But for SNP most of these bulk PSC changes are when the guest switches
*all* of it's pages from shared->private during early boot when it
validates all of it's memory. So these pages tend to be contiguous
ranges, and a nice optimization would be to coalesce these 252
fallocate() calls into a single fallocate() that spans the whole range.
But there's no good way to do that without losing information like
whether these should be treated as individual 4K vs. 2M ranges.

So I wonder, since there's talk of the "binding" of this memfd to KVM
being what actually enabled all the private/shared operations, if we
should introduce some sort of new KVM ioctl, like
KVM_UPM_SET_PRIVATE/SHARED, that could handle all the
fallocate/hole-punching on the kernel side for larger GFN ranges to reduce
the kernel<->userspace transitions, and allow for 4K/2M granularity to be
specified as arguments, and maybe provide for better
backward-compatibility vs. future changes to memfd backend interface.

> 
>   - Add a flag to memfile_notifier so its consumers can state the requirements.
> 
>         struct memfile_notifier {
>                 struct list_head list;
>                 unsigned long flags;     /* consumer states its requirements here */
>                 struct memfile_notifier_ops *ops; /* future function may also extend ops when necessary */
>         };
> 
>     For current CC usage, we can define and set below flags from KVM.
> 
>         /* memfile notifier flags */
>         #define MFN_F_USER_INACCESSIBLE   0x0001  /* memory allocated in the file is inaccessible from userspace (e.g. read/write/mmap) */
>         #define MFN_F_UNMOVABLE           0x0002  /* memory allocated in the file is unmovable */
>         #define MFN_F_UNRECLAIMABLE       0x0003  /* memory allocated in the file is unreclaimable (e.g. via kswapd or any other pathes) */
> 
>     When memfile_notifier is being registered, memfile_register_notifier will
>     need check these flags. E.g. for MFN_F_USER_INACCESSIBLE, it fails when
>     previous mmap-ed mapping exists on the fd (I'm still unclear on how to do
>     this). When multiple consumers are supported it also need check all
>     registered consumers to see if any conflict (e.g. all consumers should have
>     MFN_F_USER_INACCESSIBLE set). Only when the register succeeds, the fd is
>     converted into a private fd, before that, the fd is just a normal (shared)
>     one. During this conversion, the previous data is preserved so you can put
>     some initial data in guest pages (whether the architecture allows this is
>     architecture-specific and out of the scope of this patch).
> 
>   - Pre-boot guest payload populating is done by normal mmap/munmap on the fd
>     before it's converted into private fd when KVM registers itself to the
>     backing store.

Is that registration still intended to be triggered by
KVM_SET_USER_MEMORY_REGION, or is there a new ioctl you're considering?

I ask because in the case of SNP (and QEMU in general, maybe other VMMs),
the regions are generally registered before the guest contents are
initialized. So if KVM_SET_USER_MEMORY_REGION kicks of the conversion then
it's too late for the SNP code in QEMU to populate the pre-conversion data.

Maybe, building on the above approach, we could have something like:

KVM_SET_USER_MEMORY_REGION
KVM_UPM_BIND(TYPE_TDX|SEV|SNP, gfn_start, gfn_end)
<populate guest memory>
KVM_UPM_INIT(gfn_start, gfn_end) //not sure if needed
KVM_UPM_SET_PRIVATE(gfn_start, gfn_end, granularity)
<launch guest>
...
KVM_UPM_SET_PRIVATE(gfn_start, gfn_end, granularity)
...
KVM_UPM_SET_SHARED(gfn_start, gfn_end, granularity)
etc.

Just some rough ideas, but I think addressing these in some form would help
a lot with getting SNP covered with reasonable performance.

> 
>   - Implicit conversion: maybe it's worthy to discuss again: how about totally
>     remove implicit converion support? TDX should be OK, unsure SEV/CCA. pKVM
>     should be happy to see. Removing also makes the work much easier and prevents
>     guest bugs/unitended behaviors early. If it turns out that there is reason to
>     keep it, then for pKVM we can make it an optional feature (e.g. via a new
>     module param). But that can be added when pKVM really gets supported.

SEV sort of relies on implicit conversion since the guest is free to turn
on/off the encryption bit during run-time. But in the context of UPM that
wouldn't be supported anyway since, IIUC, the idea is that SEV/SEV-ES would
only be supported for guests that do explicit conversions via MAP_GPA_RANGE
hypercall. And for SNP these would similarly be done via explicit page-state
change requests via GHCB requests issued by the guest.

But if possible, it would be nice if we could leave implicit conversion
as an optional feature/flag, as it's something that we considered
harmless for the guest SNP support (now upstream), and planned to allow
in the hypervisor implementation. I don't think we intentionally relied on
it in the guest kernel/uefi support, but I need to audit that code to be
sure that dropping it wouldn't cause a regression in the guest support.
I'll try to confirm this soon one I get things running under UPM a bit more
reliably.

> 
>   - non-destructive in-place conversion: Out of scope for this series, pKVM can
>     invent other pKVM specific interfaces (either extend memfile_notifier and using
>     mmap/mprotect or use totaly different ways like access through vmfd as Sean
>     suggested).
> 
> Thanks,
> Chao

Also, happy to help with testing things on the SNP side going forward, just
let me know.

Thanks!

-Mike
