Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E0B5B3C2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 17:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiIIPiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 11:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiIIPiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:38:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70599286C7;
        Fri,  9 Sep 2022 08:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3LlxYWsC8GDRaPf6O1mXUYoGK3O1gbQ+aJnrEB0xv6OIN0cVyo/Qw0fN87CAdPDmJglHhmmyJHlqiUAZiKICwFrXfMYy8LlhqGQxgoAdWkKPg20z8xOs89viaC4G9Przlbm+aqRnYPekFxZ15jERduVJoE72AZQJdcmS3Rpl9pymPQpdZazvhPl8wl1GTwA0maEz2pj9/mDK23xzYXZASpoWGbrbSMe97KXBKGfiSFfCyjFOjOX4ybvApC2P2VcoBNuExygitv5LM//h0rzG2+r6hmKpDXRKIieXHXbYd/YnOUJu3OUviMV7Mh6H68ZGisFNtKMLJ1SN/UfntIm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArFRh4lsuk91DZT1WsJsDLoImSaBpXMYiHSpZQqJ1gw=;
 b=SzXddS5J4X4YzyZlEy8Kg9c1BXa/KUX7qW7EYrdQ1+NxX7Py+3BV67mIN8e9CSbX4x7NZDI7747dLiBbornVZdjURtWDjsj+HpUSDAGby6y7s9Vy0rjQ1PJl6WOHe3LeDp2D20Jy23D6Ehv82W6UDWiQWI6PQnI4iSGI6LYp1LGIDMoF3jRYoZkVv2jijdE5cYWGsU37R3BAQGzrRN4FrSjHuL4YmXq2JUo38JPQj+1S1AD1j8hkE7GQpYihAEls551po0AFqOk62eLEb0lKLcix6bERIzyRsjhmSqf1x1UojyKzTUeYk13KigI8h4zEA3M1h5U0gj1sJSX8f/LO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArFRh4lsuk91DZT1WsJsDLoImSaBpXMYiHSpZQqJ1gw=;
 b=mNH0FqKQaAMFjFkm+2aZ/8a8glVD3InwHPM4BWdff95jEbEwIvecta7Yy/EET2yE818Fhv6IsPFvDq6SS6WkgrNn1gylBLAwYwlUeDOXktJ6Hezr+mam/qxHwUDMUwpywUWO46+bGPB3zrYE0VgNvG6f9eNbaOV15j9sNsHzFBU=
Received: from MW4PR03CA0320.namprd03.prod.outlook.com (2603:10b6:303:dd::25)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Fri, 9 Sep
 2022 15:35:41 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::49) by MW4PR03CA0320.outlook.office365.com
 (2603:10b6:303:dd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Fri, 9 Sep 2022 15:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 15:35:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 10:35:40 -0500
Date:   Fri, 9 Sep 2022 10:35:22 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <qemu-devel@nongnu.org>, <linux-kselftest@vger.kernel.org>,
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
        Quentin Perret <qperret@google.com>, <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220909153522.r2a4amvtfp7l56zo@amd.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 132b7a38-5735-445d-b3a6-08da9278f426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdzNXyjMfiDoTinxpZMddodgFmtulx1RMDUdFgvS+bwBelMUidwj9Gcd2C1BhxJPTY6bF5BF+1oYKOwsAyarHy8g3/RGIF12IXP1Ur3Fn3h9OvlxXXuPRxX6V+c9j31CPfWOU186/8kGav4TjT5RlAneYd9n1CvavFsn1Mu8PvdaBevD1bXiy7c9fewV7n5RwKI91xDISegxuFwDygB+SKhaJKTzJ/uYbNwun1p3f+FBFRHb1ilw6rVtnp+vGRXTMzWH5gtcYFBb0BXAcksNZm9GTW5OFOEAaA0hqRUKM1F01kjUfDbGBiJdpKgPPp5LhDFB3hSon76VLtLFG9CgBBmXQv4JP41CuTVXKQu71gS7aJSlIudJqXn/IPf4zupY8ELf8Kr2j2fOQcKE+qe8SFVByt8+FweJ3ox55VmV76BZNUtfTiC3Jp64Wsuk/ijs1bS9K4o9iiTjFKNbHuTLBr7nZIcQE6M3P6P7v1a+wu1hTSMNJgxmNN5duP79hngrPq36cYzMUJ2BljoZJ3WegAK4wZIqJpLFOqEGgJAGeYHIVrmggNGfc8ujXb6fnFvpCgJbt7MRnGXWgVb6jne6QzBBtqPmPuosWyUAD2NZcHFFcu0YUfZd6gMZU+SImrUQ6SAZx+uoRhOPkDHxMfolWQnw+gEdHQ9nDWZ6vZ5KKmGINsaCTkGJ7FdHXtK9dNuQlwz3Fl6hoz9SsSH2TLXp5yVShpxHxYLxWyYX7bjvOOCKwoykh9b8+QEHhpNNdGxsSYPQ1ogUmg/pUJXdG7AKdkOIkT8KR02M90V0CqKujZprjfsz3j7GynOWCjXPywDeyWp4s5FWnvbh3tC5sxBhRqJ6ovgAdsJkqXOyhHdHMvfwgKbva/fOmKJSWgx7G3rD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(40470700004)(36840700001)(46966006)(426003)(2906002)(7416002)(86362001)(16526019)(6916009)(356005)(40480700001)(40460700003)(316002)(478600001)(81166007)(966005)(41300700001)(186003)(83380400001)(336012)(36860700001)(54906003)(2616005)(47076005)(1076003)(82310400005)(6666004)(82740400003)(7406005)(26005)(70206006)(44832011)(8936002)(4326008)(8676002)(70586007)(36756003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 15:35:41.4379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132b7a38-5735-445d-b3a6-08da9278f426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:20:02PM +0800, Chao Peng wrote:
> This is the v7 of this series which tries to implement the fd-based KVM
> guest private memory. The patches are based on latest kvm/queue branch
> commit:
> 
>   b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
> split_desc_cache only by default capacity
> 
> Introduction
> ------------
> In general this patch series introduce fd-based memslot which provides
> guest memory through memory file descriptor fd[offset,size] instead of
> hva/size. The fd can be created from a supported memory filesystem
> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
> and the the memory backing store exchange callbacks when such memslot
> gets created. At runtime KVM will call into callbacks provided by the
> backing store to get the pfn with the fd+offset. Memory backing store
> will also call into KVM callbacks when userspace punch hole on the fd
> to notify KVM to unmap secondary MMU page table entries.
> 
> Comparing to existing hva-based memslot, this new type of memslot allows
> guest memory unmapped from host userspace like QEMU and even the kernel
> itself, therefore reduce attack surface and prevent bugs.
> 
> Based on this fd-based memslot, we can build guest private memory that
> is going to be used in confidential computing environments such as Intel
> TDX and AMD SEV. When supported, the memory backing store can provide
> more enforcement on the fd and KVM can use a single memslot to hold both
> the private and shared part of the guest memory. 

Hi everyone,

Just wanted to let you all know that I reserved a slot at the LPC
Confidential Computing Microconference to discuss some topics related
to unmapped/inaccessible private memory support:

  "Unmapped Private Memory for Confidential Guests"
  Tuesday, Sep 13th, 10:00am (Dublin time)
  https://lpc.events/event/16/sessions/133/#20220913

The discussion agenda is still a bit in flux, but one topic I really
wanted to cover is how we intend to deal with the kernel directmap
for TDX/SNP, where there is a need to either remove or split mappings
so that KVM or other kernel threads writing to non-private pages
don't run into issues due mappings overlapping with private pages.[1]

Other possible discussion topics:

  - guarding against shared->private conversions while KVM is
    attempting to access a shared page (separate PFN pools for
    shared/private seems to resolve this nicely, but may not be
    compatible with things like pKVM where the underlying PFN
    is the same for shared/private)[2]

  - extending KVM_EXIT_MEMORY_FAULT to handle batched requests to
    better handle things like explicit batched conversions initiated
    by the guest

It's a short session so not sure how much time we'll actually have
to discuss things in detail, but maybe this can at least be a good
jumping off point for other discussions.

Thanks, and hope to see you there!

[1] https://lore.kernel.org/all/YWb8WG6Ravbs1nbx@google.com/
[2] https://lore.kernel.org/lkml/CA+EHjTy6NF=BkCqK0vhXLdtKZMahp55JUMSfxN96-NT3YiMXYQ@mail.gmail.com/
