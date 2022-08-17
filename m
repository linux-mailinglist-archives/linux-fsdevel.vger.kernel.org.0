Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19B597E29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 07:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbiHRFnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 01:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiHRFnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:43:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84133CBCA;
        Wed, 17 Aug 2022 22:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOLLeScLpdSfKP/4veWN6Jy32Nnpih8QSiB7pSb+HsW9XcRX3mAJEA/l1UtaSfcBmfElxaTxR/q6q2bM9gc+rchVAZpPdsSc0egRTxlF7gr5u4iaV5r2G9XebqK9FSTfYH7xDnmLWz4pXH3Kl08jwu2uZQu1rkmbA5bbeAOSCB8ZrspzHWNR9udplXGFQK3cVMWEBAQaeya5mOt8KilhrbzHaP5FOwEOMm7ZYbR4tHF0ijIfc+LbMB3ycK8tmKidaIjxqoj9VJ5aHgIuV0BjQCrJhBCfzsWyYD7908yYVPmN+1oT0oKrtyo/hKO9vble9XwwjL+HgMrsxIL/WhK9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BAcH77xCiHqHCWEZcjJjkDD06tsPwWpa3U8OX//Q1Y=;
 b=KrcVB//tMcd8LchTZzKOqvMryh3+Anxyrp1rtczKZveWR31/7/htSz9RaYwb/Nz3t2GQHwcQAE7rEedgNXo5ymPW9Bslj8Cnppk3hFOjy5Zd/7m8F3nmlihgdi29DOm1XIp4vAAeVkiTubrc+i0a4lYyyZlWVwPCRTUB9+f2HDqfMZE/SbXw8scUoWHp5nFznSaKdFJQX8Y0jR5COIKeLrHu9Bx7Kij9pER7Uav9518FlIgrABLNfCp2SG+18eGh+MUhWNg9lT05Ceq6uZDJbU7LT8wFBxnddrQfRZek0gfVefWyMBzTyHBv4mAOCdnVRvxM0ngp9q/e/WUDEfiARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BAcH77xCiHqHCWEZcjJjkDD06tsPwWpa3U8OX//Q1Y=;
 b=G3LHuWzOiRL3z9T60cIgzHk1QKYn8aJydVD2WioxkOPdRXIgVBm2p7gvNdchvAbUJsEHfY3MzDgJcIR8b9dV9LamCae66XrvMcbcZFEFBz+kLL4ADStnhVwtvDunD6hfkQgCBYEYeQ4dTs1L+GCqYQAVI2LAQADwI72a/zvzS3o=
Received: from MW2PR16CA0069.namprd16.prod.outlook.com (2603:10b6:907:1::46)
 by MWHPR1201MB0269.namprd12.prod.outlook.com (2603:10b6:301:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 05:43:41 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::bb) by MW2PR16CA0069.outlook.office365.com
 (2603:10b6:907:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Thu, 18 Aug 2022 05:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 05:43:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 18 Aug
 2022 00:43:40 -0500
Date:   Wed, 17 Aug 2022 10:27:19 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, <luto@kernel.org>,
        <jun.nakajima@intel.com>, <dave.hansen@intel.com>,
        <ak@linux.intel.com>, <david@redhat.com>, <aarcange@redhat.com>,
        <ddutile@redhat.com>, <dhildenb@redhat.com>,
        "Quentin Perret" <qperret@google.com>, <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, <bharata@amd.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <qemu-devel@nongnu.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220817152719.g7pgu34syekzkha5@amd.com>
References: <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
 <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
 <1407c70c-0c0b-6955-10bb-d44c5928f2d9@amd.com>
 <1136925c-2e37-6af4-acac-be8bed9f6ed5@amd.com>
 <1b02db9d-f2f1-94dd-6f37-59481525abff@amd.com>
 <20220815130411.GA1073443@chaop.bj.intel.com>
 <f0094f31-9669-47b5-eb52-6754a13ce757@amd.com>
 <20220816122457.2fjyd4uz5hp5cani@box.shutemov.name>
 <f95f35af-4824-2a2a-7cd0-71d1fda6867a@amd.com>
 <Yvu54I7Y+/ybVyec@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yvu54I7Y+/ybVyec@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84ecb84f-bf0a-4229-edd6-08da80dc9b70
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0269:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQOI2YOpuashsx9RSf9wneuMiTux2IfR+WCNPn3fGQIDY+lQJdDRe8M0iHNoEXRmtDk/hQIJlFhdB12qyb5ECiWpLsdxS0fUHZmYeeqJGgfwluiS35kRtkvOl+Z1kx3lDnKw+w6rc5Mqv0q2IIQWZg7+KpduUq0CtNlHa7FLFWPZUgpqLqdYeA6/Ef/0D5ogD5Vxnwz2yQxQu1D4ZxZVqNv8H63hHoqz6WxnGCPjuFqcH5PbJoC49ZoFQgx/K0hF1i9GRtaoasdnN5m8GTUT72m8CwLpLwEikzFaVOT3WH77RjKPUcE6U0cArIZdsAb9pcutTtuOhn/tOZM9glyU9shac27xL2cuBj90Zn/FODHrUKzyZ7tpcIiv6ZVI0RmcPt9xl9dx2YlVPWnTViTBsVnw2WuryH6icVufElhTG+EAP1T2JoD2nZOfNop2U0J0uT1AwKCIJq31dJq2aO8ZdMC7TeeboHZLimD4PYWSOnkn16dsfYAMG/kGafGq3hjlVIWCYhkLIh4P8W7ufNoX+tm2VKrxMdH/yVdArfch4ojOwyJFC2uf3i/HIiG0+pj/+lkm0GElBhz4jbWA2Fi76y/8harrRXug9o/bljJHSvN5V+hGepYSxkFKwYzIJ5EeYa6ClAULOvq8G4R4yIxRQ3Aoyy2+rLfPz0jEo9WE9TBWfeinF5/QThmkJlQiLMzaMq1CExmEn2XJDCL09qhx8xGtU+7LPmVRAeXkQCR/Jbus0BnUj8xK15ZiiXpkinD7UhMeEmJpIdct/91a4TzzHw2uqjSj202klCRb0OmyXxl8hCXdc1giPrkfaHLkk1M/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(40480700001)(2616005)(6666004)(6916009)(36860700001)(5660300002)(2906002)(426003)(7406005)(7416002)(336012)(36756003)(44832011)(54906003)(41300700001)(316002)(4326008)(47076005)(70586007)(1076003)(8936002)(86362001)(70206006)(16526019)(83380400001)(82310400005)(356005)(8676002)(82740400003)(186003)(26005)(478600001)(81166007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 05:43:41.3501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ecb84f-bf0a-4229-edd6-08da80dc9b70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0269
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:38:08PM +0000, Sean Christopherson wrote:
> On Tue, Aug 16, 2022, Gupta, Pankaj wrote:
> > 
> > > > > Actually the current version allows you to delay the allocation to a
> > > > > later time (e.g. page fault time) if you don't call fallocate() on the
> > > > > private fd. fallocate() is necessary in previous versions because we
> > > > > treat the existense in the fd as 'private' but in this version we track
> > > > > private/shared info in KVM so we don't rely on that fact from memory
> > > > > backstores.
> > > > 
> > > > Does this also mean reservation of guest physical memory with secure
> > > > processor (both for SEV-SNP & TDX) will also happen at page fault time?
> > > > 
> > > > Do we plan to keep it this way?
> > > 
> > > If you are talking about accepting memory by the guest, it is initiated by
> > > the guest and has nothing to do with page fault time vs fallocate()
> > > allocation of host memory. I mean acceptance happens after host memory
> > > allocation but they are not in lockstep, acceptance can happen much later.
> > 
> > No, I meant reserving guest physical memory range from hypervisor e.g with
> > RMPUpdate for SEV-SNP or equivalent at TDX side (PAMTs?).
> 
> As proposed, RMP/PAMT updates will occur in the fault path, i.e. there is no way
> for userspace to pre-map guest memory.

Hi Sean,

Currently I have the rmpupdate hook in KVM_MEMORY_ENCRYPT_{REG,UNREG}_REGION
ioctls, so that when the pages actually get faulted in they are already
in the expected state. I have userspace set up to call
KVM_MEMORY_ENCRYPT_* in response to explicit page state changes issued by
the guest, as well as in response to MEMORY_FAULT exits for implicit page
state changes.

Initially the private backing store may or may not be pre-fallocate()'d
depending on how userspace wants to handle it. If it's not
pre-fallocate()'d, then the pages don't get faulted in until the guest
does explicit page state changes (currently SNP guests will do this for all
memory at boot time, but with unaccepted memory patches for guest/ovmf
this will happen during guest run-time, would still allow us to make
efficient use of lazy-pinning support for shorter boot times).

If userspaces wants to pre-allocate, it can issue the fallocate() for
all the ranges up-front so it doesn't incur the cost during run-time.

Is that compatible with the proposed design?

Of course, for the initial encrypted payload, we would need to to issue
the KVM_MEMORY_ENCRYPT_{REG,UNREG}_REGION up-front. I'm doing that in
conjunction with the hack to allow pwrite() to memfd to pre-populate the
private pages before the in-place encryption that occurs when
SNP_LAUNCH_UPDATE is issued...

In the past you and Vishal suggested doing the copy from within
SNP_LAUNCH_UPDATE, which seems like a workable solution and something
we've been meaning to implement...

> 
> I think the best approach is to turn KVM_TDX_INIT_MEM_REGION into a generic
> vCPU-scoped ioctl() that allows userspace to pre-map guest memory.  Supporting
> initializing guest private memory with a source page can be implemented via a
> flag.  That also gives KVM line of sight to in-place "conversion", e.g. another
> flag could be added to say that the dest is also the source.

So is this proposed ioctl only intended to handle the initial encrypted
payload, and the KVM_MEMORY_ENCRYPT_{REG,UNREG}_REGION ioctls would
still be used for conversions post-boot?

If so, that seems reasonable, but I thought there was some consensus that
just handling it per-platform in, e.g., SNP_LAUNCH_UPDATE, was
sufficient for now until some additional need arose for a new interface.
Has something changed in the regard? Just want to understand the
motivations so we can plan accordingly.

Thanks!

-Mike

> 
> The TDX and SNP restrictions would then become addition restrictions on when
> initializing with a source is allowed (and VMs that don't have guest private
> memory wouldn't allow the flag at all).
