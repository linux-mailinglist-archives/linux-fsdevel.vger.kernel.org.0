Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A375C559A09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiFXNCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 09:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiFXNCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:02:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EC52E49;
        Fri, 24 Jun 2022 06:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOUggiIi2v5uGQ7owBCEJqY6YtaN+po3d8bGLVrmhLDSi6MSGMkLJyPYKzGiuHiKSJatOjkHqVkcXJKRCXyNdX2CMiKjgy0PJPMathhq8GARr6EbOD8lJAOO3O+SYI88akIiC8MWpgcf+8Qo1KwBiX7DMb/53CrGRXoptnIGhY0kIqX3SabOYsbXwjbzVyZbAH9V/9AkPi/NHDhoCBjm5/zNdn6JNmoDaJZXQrY7h+U4tH45PXHO4Oilb8YLU3FOHFeZsYs+3WjJF0iYnWC1wRLv1kNWR/3p1I8lO1gJGtxhAwoT1DN9Hzq5B5oP/X2UgNH6pLyxnkx2b7f55MPQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8on6/xXxc0lsJx1jxYZS6kAyl65PGQ9qYN645XAhyPc=;
 b=G0ulSERJbdqu7gzEUsdyiuURD2A3E2eOY4f8YXVQTGoGu5BbExdlKJsTFRf0YBqqJskOF45CApxrlha5HWx6WiHf5s3w+rhFhGZ8upZyihlmS/rMuxd3SGN9Fju/2f8MBIOi7rlWM7YWjunwnx6crsEqyqyLSnsblR7hr5thc+SBGz40aMWlfdYANsuhvS0PxjsNcGERzBN5FDWQ3r4pP+vq3WFRgbslJujGLW3WFr9rveoZFmXRc2eYCkETUjGRNZC/XaEQN2Wd2QjlVnU2UmabAk8bBuA2iHk6qtKiya4n05ZJwKnd6o0+Q7INBd5k6RscTUIko/yv1T84grTd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8on6/xXxc0lsJx1jxYZS6kAyl65PGQ9qYN645XAhyPc=;
 b=zyEIypN/7Zv21SNu1jm6K17i2ljKEyft/klCapsFyJB8tq1DA8+/SRT0yiL4ivP3fvUNX3dRzbq2fDjlfSca1TRqajKkt1/Z/XApEDQ4hCqkr765/RYSVIPFDFhn+XuvNNrOzwAQPgBdI0sGCOOMcRbPwqlKiq9QNjwgcF3TYyk=
Received: from BN1PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:e1::21)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 13:02:04 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::e2) by BN1PR12CA0016.outlook.office365.com
 (2603:10b6:408:e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Fri, 24 Jun 2022 13:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 13:02:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 24 Jun
 2022 08:02:02 -0500
Date:   Fri, 24 Jun 2022 08:01:44 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
CC:     Sean Christopherson <seanjc@google.com>,
        Andy Lutomirski <luto@kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Steven Price" <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <jun.nakajima@intel.com>, <dave.hansen@intel.com>,
        <ak@linux.intel.com>, <david@redhat.com>, <aarcange@redhat.com>,
        <ddutile@redhat.com>, <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>, <mhocko@suse.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20220624130144.2ydfbhytrtv4vgsl@amd.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
 <YofeZps9YXgtP3f1@google.com>
 <20220623225949.kkdx6uwjlk2ec4iq@amd.com>
 <20220624085426.GB2178308@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220624085426.GB2178308@chaop.bj.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b42f8dc5-8468-4f9a-ae39-08da55e1bc03
X-MS-TrafficTypeDiagnostic: MW5PR12MB5649:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ctnYInZpoqd5MX5k37KdlMO1N+u+N8TUnG8Nn0pudaAFTtkPcIfhB7wpCcqzTOu0vqQ6s4b1wPQZ9fR4wfBs8PdH2Q1d5rBD6FkhhUZwwRewYiO3YIaX2ZfqsprYJ/BJp05ph8A4wplzmG2crJ7CCWQCUmtYrhdSfiVCwkjGfzVvGLgoZ9OQ/BqQQ00idCTumMnte37z6r7oH4Codz+5xpDdrN3IFUYO23x0XAwweonRWc7DOciT5/CqBh5OHoDOx2gGGhtLoaoASIUJzXq8v3ab6ylhnrQU0xleTf6n9RlPJE55TBcRX7EENrRyh0GN6YHcLZUxPEA+pYVckjPGUCav++pOm4tjJ4y/XbDNTW+7SE0BCDIDwAjjoVQ7L7zILW0Ce8fqSR7raRLZfNKih+V4VGKnuo8BPKwowAMmTFtYLg/WE3+ydA1B9xBqv22jXMHYYR71quaMEkt4duFhKphpN7Zrh1KwSCq6q2fyyzdz+CYReEmIOdulN9rpMfy1wvqRrsP7jiua6kEN7vfp8Q8zLJ6ZftjDPKJ5wo1olscjQhjzF3SJet9CpNOCAwTWAqtsDtA/0w5ECQXCNterzetvEdQ0JgAdi9OAAe/4V25i+48ScljHSS1JUEjrxFATEC9AyvDR36fPaJDWBvk3e2KJH4TRpJw7eD7f2eLTa5FhnhB1TJq3A+D8Kdt50uFczwykPP24NF0Ky/VFW6cHiH1jXqCNZRev4DNkuCw3o07iVzE2WeO+LcKsd4c+GKabgpFjC+mZbkeUYMesuVmzLGoPlsrcls5gJIGk0zJfyE87iFX41ZEGwzjztRBB0l5lLMqchyDtOCxCmdOGbginQTfHzyCkXVXjdqBeZIcHcQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(40470700004)(46966006)(36840700001)(26005)(41300700001)(86362001)(40460700003)(6666004)(54906003)(966005)(478600001)(8936002)(5660300002)(2616005)(7406005)(44832011)(82310400005)(2906002)(426003)(47076005)(186003)(16526019)(1076003)(7416002)(8676002)(82740400003)(36860700001)(356005)(40480700001)(81166007)(316002)(6916009)(4326008)(36756003)(83380400001)(70206006)(70586007)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 13:02:03.5925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b42f8dc5-8468-4f9a-ae39-08da55e1bc03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 04:54:26PM +0800, Chao Peng wrote:
> On Thu, Jun 23, 2022 at 05:59:49PM -0500, Michael Roth wrote:
> > On Fri, May 20, 2022 at 06:31:02PM +0000, Sean Christopherson wrote:
> > > On Fri, May 20, 2022, Andy Lutomirski wrote:
> > > > The alternative would be to have some kind of separate table or bitmap (part
> > > > of the memslot?) that tells KVM whether a GPA should map to the fd.
> > > > 
> > > > What do you all think?
> > > 
> > > My original proposal was to have expolicit shared vs. private memslots, and punch
> > > holes in KVM's memslots on conversion, but due to the way KVM (and userspace)
> > > handle memslot updates, conversions would be painfully slow.  That's how we ended
> > > up with the current propsoal.
> > > 
> > > But a dedicated KVM ioctl() to add/remove shared ranges would be easy to implement
> > > and wouldn't necessarily even need to interact with the memslots.  It could be a
> > > consumer of memslots, e.g. if we wanted to disallow registering regions without an
> > > associated memslot, but I think we'd want to avoid even that because things will
> > > get messy during memslot updates, e.g. if dirty logging is toggled or a shared
> > > memory region is temporarily removed then we wouldn't want to destroy the tracking.
> > > 
> > > I don't think we'd want to use a bitmap, e.g. for a well-behaved guest, XArray
> > > should be far more efficient.
> > > 
> > > One benefit to explicitly tracking this in KVM is that it might be useful for
> > > software-only protected VMs, e.g. KVM could mark a region in the XArray as "pending"
> > > based on guest hypercalls to share/unshare memory, and then complete the transaction
> > > when userspace invokes the ioctl() to complete the share/unshare.
> > 
> > Another upside to implementing a KVM ioctl is basically the reverse of the
> > discussion around avoiding double-allocations: *supporting* double-allocations.
> > 
> > One thing I noticed while testing SNP+UPM support is a fairly dramatic
> > slow-down with how it handles OVMF, which does some really nasty stuff
> > with DMA where it takes 1 or 2 pages and flips them between
> > shared/private on every transaction. Obviously that's not ideal and
> > should be fixed directly at some point, but it's something that exists in the
> > wild and might not be the only such instance where we need to deal with that
> > sort of usage pattern. 
> > 
> > With the current implementation, one option I had to address this was to
> > disable hole-punching in QEMU when doing shared->private conversions:
> > 
> > Boot time from 1GB guest:
> >                                SNP:   32s
> >                            SNP+UPM: 1m43s
> >   SNP+UPM (disable shared discard): 1m08s
> > 
> > Of course, we don't have the option of disabling discard/hole-punching
> > for private memory to see if we get similar gains there, since that also
> > doubles as the interface for doing private->shared conversions.
> 
> Private should be the same, minus time consumed for private memory, the
> data should be close to SNP case. You can't try that in current version
> due to we rely on the existence of the private page to tell a page is
> private.
> 
> > A separate
> > KVM ioctl to decouple these 2 things would allow for that, and allow for a
> > way for userspace to implement things like batched/lazy-discard of
> > previously-converted pages to deal with cases like these.
> 
> The planned ioctl includes two responsibilities:
>   - Mark the range as private/shared
>   - Zap the existing SLPT mapping for the range
> 
> Whether doing the hole-punching or not on the fd is unrelated to this
> ioctl, userspace has freedom to do that or not. Since we don't reply on
> the fact that private memoy should have been allocated, we can support
> lazy faulting and don't need explicit fallocate(). That means, whether
> the memory is discarded or not in the memory backing store is not
> required by KVM, but be a userspace option.

Nice, that sounds promising.

> 
> > 
> > Another motivator for these separate ioctl is that, since we're considering
> > 'out-of-band' interactions with private memfd where userspace might
> > erroneously/inadvertently do things like double allocations, another thing it
> > might do is pre-allocating pages in the private memfd prior to associating
> > the memfd with a private memslot. Since the notifiers aren't registered until
> > that point, any associated callbacks that would normally need to be done as
> > part of those fallocate() notification would be missed unless we do something
> > like 'replay' all the notifications once the private memslot is registered and
> > associating with a memfile notifier. But that seems a bit ugly, and I'm not
> > sure how well that would work. This also seems to hint at this additional
> > 'conversion' state being something that should be owned and managed directly
> > by KVM rather than hooking into the allocations.
> 
> Right, once we move the private/shared state into KVM then we don't rely
> on those callbacks so the 'replay' thing is unneeded. fallocate()
> notification is useless for sure, invalidate() is likely still needed,
> just like the invalidate for mmu_notifier to bump the mmu_seq and do the
> zap.

Ok, yah, makes sense that we'd still up needing the invalidation hooks.

> 
> > 
> > It would also nicely solve the question of how to handle in-place
> > encryption, since unlike userspace, KVM is perfectly capable of copying
> > data from shared->private prior to conversion / guest start, and
> > disallowing such things afterward. Would just need an extra flag basically.
> 
> Agree it's possible to do additional copy during the conversion but I'm
> not so confident this is urgent and the right API. Currently TDX does
> not have this need. Maybe as the first step just add the conversion
> itself. Adding additional feature like this can always be possible
> whenever we are clear.

That seems fair. In the meantime we can adopt the approach proposed by
Sean and Vishal[1] and handle it directly in the relevant SNP KVM ioctls.

If we end up keeping that approach we'll probably want to make sure these
KVM-driven 'implicit' conversions are documented in the KVM/SNP API so that
userspace can account for it in it's view of what's private/shared. In this
case at least it's pretty obvious, just thinking of when other archs and
VMMs utilizing this more.

Thanks!

-Mike

[1] https://lore.kernel.org/kvm/20220524205646.1798325-4-vannapurve@google.com/T/#m1e9bb782b1bea66c36ae7c4c9f4f0c35c2d7e338

> 
> Thanks,
> Chao
