Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47046616FB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 22:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiKBV1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 17:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiKBV1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:27:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CAADFBC;
        Wed,  2 Nov 2022 14:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnEyxpEgCLBUr11R4tfOG52fK4v1GHFzYhQ+/c5HFLP35fGnIAUMhL3wEzSbrp1vSIYxBouHzlV1HeRLRw4MulpM75UFecOotXjw/rVO38aziYGaR5q89jMIhaeFtFNzP7I6iFoVqqNXXdMdP4nQglPxfNBe+HKCisK6q5HjDHw8S2xgyBxKPdOGtXP+O3mbeGlghI3U5bvGc9xa1aK98hLulW+gAC8bdTzM0H1VMjAz9U7LdjoVKThdEcmMLxAhn/pbSasoxqLi2LT6gB62BWtPU0WfqVuDyCj1o563T0ENWmbd8rZDOxSjMWkwmTFlc8OUFUpXjMCPoOz406VdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HOpdvixxTPUhGk84Cr9YvdY4Oa5RaCqh51pwnSr8Pw=;
 b=jPZ3BIXAxxSpMw5ONlBpCFrx+X02du4dFaskw4TW6qX6fqiAowREeHkvANMc4ejAKmFpw4Fs8w3oohGTt3Fbyvqynfzjzh0DasYTvcivJ2lZggusmJkSqRGmpYrqrBk2y5vSbZuqPPgDdoKIWfl9A9iB1UBparrP1eeXsc4FDTPhKGst0/fmC5P9Tb3mS1jskLZ6ISu2YYyH7R+W4AVaHFpm+ifKDKndUqz2sZcgCELcOskxBiTg999PcYfmpZoMXlV96plzBrnlJGjrGlC6PxTx5kehtL37JofRpDpnjNGRICk4KJCCTvoS/XXUvOGc8Ygw/PBaVWsEO9gbBqNx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=shutemov.name smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HOpdvixxTPUhGk84Cr9YvdY4Oa5RaCqh51pwnSr8Pw=;
 b=YDKe2vZMKlBVF9x5uyjg0aE35gk6c80qghVEX2QkjQgWJKBmCutUmlfCiZESc5dKdDUZvrx0E9UsX0p2bTDETwt/o2l5E/TlOUQ5S8JoTXOXszdNiy7UEQqAIhF0uhgA9NSsm07rFlnO2303o8BZJVL9LP99zZ4eiEsY/bh80bY=
Received: from DM6PR17CA0020.namprd17.prod.outlook.com (2603:10b6:5:1b3::33)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 21:27:13 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::f1) by DM6PR17CA0020.outlook.office365.com
 (2603:10b6:5:1b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Wed, 2 Nov 2022 21:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 21:27:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 16:27:12 -0500
Date:   Wed, 2 Nov 2022 16:26:56 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Chao Peng <chao.p.peng@linux.intel.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <20221102212656.6giugw542jdxsvhh@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221102211404.l5whyif3j3k67fv2@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221102211404.l5whyif3j3k67fv2@box.shutemov.name>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: de5815e3-d15f-4939-3067-08dabd1901fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2EItDXdgy1qVdqJxR4GEQrDaZ3DofdFzS+LNVJ6NsAJTMVFdBSp6zUpoaPvMWb6267FNjpOK3GF0L3xXcyq5uWRNLuq/Ufi4fc+ayxaUgAqwRo9rfluD4KybXiyZZkiAzOPeFB5kHGevljPKuxckYaN9ZREL/xrn9reHrF51j9Jtbtl4uHTHmj3fIYMmQVw1UvXacSTWAfgLOgY1ajIt+FHI7moRMF0bhhC1P6hC2h74Bu9XyAx4wShywFQZIoUbktcSgP2tS1Cs5jrQC/Oj3pWbOa9BZBYGZymrthBCap+Ro5nt2PPpjksvWECVuAPoXl12GfJIae/dQHmYbzGp4w01iMWCHWC9TnK9Ldx+q5jVs/o49bliHpyBYZDd8oIO8lsBU+FUjwFpFR2iu1qPlYZv51mMJoyUyMB9+hyUoVBR7coUvKyOPy0NguANTaArge8yyEuu7CphmRAvPo7bzFbIXHJU/b5j7a0E0zijVMfhWRVBz/nlXsZSKNYjjawjN4W7W4kjsz8ijEeKvj4kbLv5fGAsriKqEezuLPaSt08x+tqe4UI+TcxnHD4N1Sr1ZMjIyZlZFVONyxcmneXuOHmQiRerPQNmOSV7ylXag19ZczMTaJ6hI0iLDMwCBulYMjpw4eTEl243osrt4sPO67dBldmi9cTvkV+FBaRQxyxxKidT98W7E8jJE4xc8b2Ad4OdFhWzxOKa7QiuVKAsE/V9uxvLDLS6oCnFjdxCNz6+fidm5sAPmXEhy+X9qeMGvpjx5hupHqTkmx8jms/nYBjncmOrcR5JMWkY+VjwL8vWL+/Wq1dft740rMPewc/E4aOUi6BbVaeic5mLrHqbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(47076005)(186003)(6666004)(26005)(36860700001)(54906003)(1076003)(478600001)(336012)(426003)(2616005)(40480700001)(83380400001)(2906002)(16526019)(40460700003)(44832011)(7406005)(82310400005)(70586007)(5660300002)(8676002)(70206006)(7416002)(8936002)(316002)(966005)(4326008)(41300700001)(86362001)(36756003)(82740400003)(81166007)(356005)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 21:27:13.0077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de5815e3-d15f-4939-3067-08dabd1901fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:14:04AM +0300, Kirill A. Shutemov wrote:
> On Mon, Oct 31, 2022 at 12:47:38PM -0500, Michael Roth wrote:
> > 
> > In v8 there was some discussion about potentially passing the page/folio
> > and order as part of the invalidation callback, I ended up needing
> > something similar for SEV-SNP, and think it might make sense for other
> > platforms. This main reasoning is:
> > 
> >   1) restoring kernel directmap:
> > 
> >      Currently SNP (and I believe TDX) need to either split or remove kernel
> >      direct mappings for restricted PFNs, since there is no guarantee that
> >      other PFNs within a 2MB range won't be used for non-restricted
> >      (which will cause an RMP #PF in the case of SNP since the 2MB
> >      mapping overlaps with guest-owned pages)
> 
> That's news to me. Where the restriction for SNP comes from? There's no
> such limitation on TDX side AFAIK?
> 
> Could you point me to relevant documentation if there's any?

I could be mistaken, I haven't looked into the specific documentation and was
going off of this discussion from a ways back:

  https://lore.kernel.org/all/YWb8WG6Ravbs1nbx@google.com/

Sean, is my read of that correct? Do you happen to know where there's
some documentation on that for the TDX side?

Thanks,

Mike

> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
