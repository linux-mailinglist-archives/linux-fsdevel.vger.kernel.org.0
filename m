Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F205625FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 00:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiF3WWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 18:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiF3WWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:22:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17B3A2;
        Thu, 30 Jun 2022 15:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1o6k544A11JQIULQrl3DckEqCaQA3hj76EyHnYr4tp9njCrVKf8dHbYrkXFHfM+LRus2qsboHt/6OuXjE+oGJy6vIzFwdvuc+BG00HmU93YzgSaAhA+hVZk3KQFfdVXT1FaCrPIaxWJ0ZWyd++Bd9jgvATmgL17d6sSAwy824r1NbFHedhmiAuf+btmCp4i4wk+Mng/FFzTGoUDhoW9+KbE1tszBMeqghIlxNA0oIV4p9cN2JjQEHx1+3XXzNleN621QGJKUK/rLGo+PPbWtxMxWfxqr7PcPm8iEUzYFFQLAeOpfCS9KsP+Mh+URmd1S2f+8m/snNFN7fJrfBGWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDdvE/+qLXuAvKitUqu8CFVheNxtCtHZvfWwUHG1068=;
 b=jHQjWnt3s50X0zoJWkbB04WeIXbUw9iSH6IBaRwJrgGTIAnG1IJYewCMhOIUBdsO1VnTXa0YsMUSIUNFqiggsCwNRCQYxPTA2wJ+fdzsoIs7OI9tv/CMYQW7fSSbztRPzpCF8c+0zZydgm9Sy6BZE64dYZXRXYFA/8RMcyFyRRwxx9rq5J49kRQG+/gZIgwhjIyH6Ep11iEmrSyaff7Hl4j2Rc/OJCu8q4gs+xl+SGAaG3Q1jhh0mTAVtJ2EExxgu40KXLE5njaOkB/fDdZEqwr3cxknN01hFxVWM0USf+/i35uLzunh2m6wZHCS1Z45iDe1uynWnbXSVaURYN6Icw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDdvE/+qLXuAvKitUqu8CFVheNxtCtHZvfWwUHG1068=;
 b=NPD+cmFuHwFd21SkLbknHj1F39ac/FNDuXtzhmvMBIDcI2yr+KJiLlWvrb29wc3om6Y6Q7N6qIJyRYFD/gTJnANwaic/U5hjhHwIVecVXSiWu36zgWNfdEKzBw7JXIwyCCmdG4+gABilVbl/m0HAst/eFZaK/LzmmzPCtJT4aiE=
Received: from BN9P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::28)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 22:22:00 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::62) by BN9P220CA0023.outlook.office365.com
 (2603:10b6:408:13e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 22:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 22:22:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 17:21:59 -0500
Date:   Thu, 30 Jun 2022 17:21:40 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Vishal Annapurve <vannapurve@google.com>
CC:     Chao Peng <chao.p.peng@linux.intel.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
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
        x86 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Steven Price" <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Jun Nakajima" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, <aarcange@redhat.com>,
        <ddutile@redhat.com>, <dhildenb@redhat.com>,
        "Quentin Perret" <qperret@google.com>, <mhocko@suse.com>
Subject: Re: [PATCH v6 6/8] KVM: Handle page fault for private memory
Message-ID: <20220630222140.of4md7bufd5jv5bh@amd.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-7-chao.p.peng@linux.intel.com>
 <b3ce0855-0e4b-782a-599c-26590df948dd@amd.com>
 <20220624090246.GA2181919@chaop.bj.intel.com>
 <CAGtprH82H_fjtRbL0KUxOkgOk4pgbaEbAydDYfZ0qxz41JCnAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGtprH82H_fjtRbL0KUxOkgOk4pgbaEbAydDYfZ0qxz41JCnAQ@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5fecce7-6f56-4080-cfa6-08da5ae6f3ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB4089:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2QpwV8hL6dMAI9riXKR5ZLlDlOA+N4IsIvDs2cG6vwUsCuUwB5piVkHhPRMUmxec0BpSIf2dn+9teTt0w9OH7eK6lgym0sa479giZjgGKH9Qrc3UJeyIP1usR6VNKLvi8NS4G1hUUf1rhUuI8t656nXygxYdtPTNNOYTPs2VZxi6ltEeGyCv6FKyM2Vwh9YDkU/o+/fsustHg8MHhRyaEevWYAltL4dMC9iYIqELYfwMS+6QbFI0+aY98978dksFsFwTjCQ+tIlhNmeDKSUM6F/ZKTS74utfp1OEMsgRgBHAn97BGcE2hZ2ehAbMpjdF8Jar/uBUxpVh4hBNU20f2Fqo0alSHGJiKCqT9ceI4xFdaJHFbHi56mrDvWuoJsaR5WVVTvh4GUKNPJ/tS5uHUpI5XGxpMbpIcHSgAcQsiBKIJJxpmNlicGyiiPKQ1w+Kv6X6POJJOGjcCh+yFkwjs4Eos9ZL11Vsqkngkq8LIPoxE3yqpfCgUijxcWUlVRmiMbNc2/W7zj0EQF/ECZAsZkBNMKfrdqaTajRk05O94RZUb76PBS4X6eozgdc8FdZgrdMsCtx5dxUaB4yygv2/tguO40XaFCvv2hZETKfSntGepWrs+EvH95hC1aKWvsTdCq9IRFQpsJkq4FMB5DGslE6WCzjHRYhHFhv1dmFGh+EqmuySyMYLtQ2otbe/PbEGr7W/QwakdQO6peHt+qAkXVTc+SLYc498p9IB7+3+AG6H8xoXkQadJ4csHubsm6A+el1yw6PUdmOsL5KBii2gVrd90NFsn8sdMbn0dTabvjbiKxcbiErd4yKk4jrmTaho4/x7UYDiB5NiUGfnTpjD0MyF0I4xTqSeMNOzEFvCRLRZnT+qVef0Tj278fbgTu5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(40470700004)(36840700001)(46966006)(40480700001)(356005)(6916009)(81166007)(336012)(1076003)(44832011)(316002)(36860700001)(40460700003)(36756003)(5660300002)(7416002)(82740400003)(41300700001)(70586007)(82310400005)(8676002)(966005)(70206006)(7406005)(4326008)(86362001)(16526019)(426003)(186003)(2616005)(2906002)(83380400001)(6666004)(8936002)(47076005)(478600001)(26005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:22:00.2863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fecce7-6f56-4080-cfa6-08da5ae6f3ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 12:14:13PM -0700, Vishal Annapurve wrote:
> With transparent_hugepages=always setting I see issues with the
> current implementation.
> 
> Scenario:
> 1) Guest accesses a gfn range 0x800-0xa00 as private
> 2) Guest calls mapgpa to convert the range 0x84d-0x86e as shared
> 3) Guest tries to access recently converted memory as shared for the first time
> Guest VM shutdown is observed after step 3 -> Guest is unable to
> proceed further since somehow code section is not as expected
> 
> Corresponding KVM trace logs after step 3:
> VCPU-0-61883   [078] ..... 72276.115679: kvm_page_fault: address
> 84d000 error_code 4
> VCPU-0-61883   [078] ..... 72276.127005: kvm_mmu_spte_requested: gfn
> 84d pfn 100b4a4d level 2
> VCPU-0-61883   [078] ..... 72276.127008: kvm_tdp_mmu_spte_changed: as
> id 0 gfn 800 level 2 old_spte 100b1b16827 new_spte 100b4a00ea7
> VCPU-0-61883   [078] ..... 72276.127009: kvm_mmu_prepare_zap_page: sp
> gen 0 gfn 800 l1 8-byte q0 direct wux nxe ad root 0 sync
> VCPU-0-61883   [078] ..... 72276.127009: kvm_tdp_mmu_spte_changed: as
> id 0 gfn 800 level 1 old_spte 1003eb27e67 new_spte 5a0
> VCPU-0-61883   [078] ..... 72276.127010: kvm_tdp_mmu_spte_changed: as
> id 0 gfn 801 level 1 old_spte 10056cc8e67 new_spte 5a0
> VCPU-0-61883   [078] ..... 72276.127010: kvm_tdp_mmu_spte_changed: as
> id 0 gfn 802 level 1 old_spte 10056fa2e67 new_spte 5a0
> VCPU-0-61883   [078] ..... 72276.127010: kvm_tdp_mmu_spte_changed: as
> id 0 gfn 803 level 1 old_spte 0 new_spte 5a0
> ....
>  VCPU-0-61883   [078] ..... 72276.127089: kvm_tdp_mmu_spte_changed: as
> id 0 gfn 9ff level 1 old_spte 100a43f4e67 new_spte 5a0
>  VCPU-0-61883   [078] ..... 72276.127090: kvm_mmu_set_spte: gfn 800
> spte 100b4a00ea7 (rwxu) level 2 at 10052fa5020
>  VCPU-0-61883   [078] ..... 72276.127091: kvm_fpu: unload
> 
> Looks like with transparent huge pages enabled kvm tried to handle the
> shared memory fault on 0x84d gfn by coalescing nearby 4K pages
> to form a contiguous 2MB page mapping at gfn 0x800, since level 2 was
> requested in kvm_mmu_spte_requested.
> This caused the private memory contents from regions 0x800-0x84c and
> 0x86e-0xa00 to get unmapped from the guest leading to guest vm
> shutdown.

Interesting... seems like that wouldn't be an issue for non-UPM SEV, since
the private pages would still be mapped as part of that 2M mapping, and
it's completely up to the guest as to whether it wants to access as
private or shared. But for UPM it makes sense this would cause issues.

> 
> Does getting the mapping level as per the fault access type help
> address the above issue? Any such coalescing should not cross between
> private to
> shared or shared to private memory regions.

Doesn't seem like changing the check to fault->is_private would help in
your particular case, since the subsequent host_pfn_mapping_level() call
only seems to limit the mapping level to whatever the mapping level is
for the HVA in the host page table.

Seems like with UPM we need some additional handling here that also
checks that the entire 2M HVA range is backed by non-private memory.

Non-UPM SNP hypervisor patches already have a similar hook added to
host_pfn_mapping_level() which implements such a check via RMP table, so
UPM might need something similar:

  https://github.com/AMDESE/linux/commit/ae4475bc740eb0b9d031a76412b0117339794139

-Mike

> 
> > > >     host_level = host_pfn_mapping_level(kvm, gfn, pfn, slot);
> > > >     return min(host_level, max_level);
> > > >  }
> > >
> 
> Regards,
> Vishal
