Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF761628BE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 23:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiKNWRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 17:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiKNWRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:17:10 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CE415821;
        Mon, 14 Nov 2022 14:17:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEQFH4XNEXfuTsYWdTscAUSjPJJi1NVOnOzyar8RyTnvMonJVbowMKNEtiEt+xgk197/aqp+dyWlMfwVcAqsLC8HCes43rpM92FzXUld87AFvlvvtpQ1fsPFxtx48S1slF7dEOEwee7vpsXmCaqdKA88FBxJwuuxjxVVDy+FinZU3S5naeBarp8ca1ZwoHK6Xtawuk3sShNTF8sKm3Jxu7a/6WZdmmHVvqV5KMyfvJSP+cD5wPMTG5DGjEQrDkKQ2qkym9DFMHCjDTU7L8TEtAVP5l6hlQc6dW/6VGcF2+Uq2NHkbuOCWhYmooUzK/kdIG0Si6JrhIAJXJFgWT2nzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V263XsirVYEAXt3LlFbznJtLX/k6bQ/ZmYJY3BrLdh4=;
 b=Jg8tdWopLvubATC82KN8z3XrTPAJM8ggSDqaYl7GocZoAWRN8x+LPJlECABBuRLE7FuSogtUacj+50UWbLLu9YC9KSSv+tbFJNImWro0qJX2F4fyp1zpgkkBkh4su3BwM8RDCNe8/3EkZS8q+NlyBDqFwJvJEStf+LV3Of/jgtfACRgqU6FMppWGDKbvxO4Mk40pH6sOXkOA6BHUEaEGDWjEhZvL3SugW9+avuJ5c3vZy/iwUgLkauhGRNl302RUGgdpV2CWSPpc7J7Yv0+F+IGae+2JxFOSYYZU0GzU3OzQUG+QsrEgmTjd3tHn4D7Ub8bv25SyibMHnfv6W77J8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=shutemov.name smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V263XsirVYEAXt3LlFbznJtLX/k6bQ/ZmYJY3BrLdh4=;
 b=bjxbgtsvfgNu+8WCr1l+i06Ye+u9kpAx5onyymdtsuTgxhM9BxsUOI6cNFEPJWULrtdDLzCPpGEFlECno28i2EivB07sXzL2hkSDSbJxIfiP/3t+gwDjiXcXaJt3dj5+G6Z/hoQo01OcEUKNj4itbnYnrfd8iWwGD2Nm4HkEe3g=
Received: from DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9) by
 BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 22:17:02 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::a6) by DS7PR05CA0079.outlook.office365.com
 (2603:10b6:8:57::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Mon, 14 Nov 2022 22:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 22:17:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 16:17:01 -0600
Date:   Mon, 14 Nov 2022 16:16:32 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        Chao Peng <chao.p.peng@linux.intel.com>, <kvm@vger.kernel.org>,
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
Message-ID: <20221114221632.5xaz24adkghfjr2q@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221101113729.GA4015495@chaop.bj.intel.com>
 <20221101151944.rhpav47pdulsew7l@amd.com>
 <20a11042-2cfb-8f42-9d80-6672e155ca2c@suse.cz>
 <20221114152843.ylxe4dis254vrj5u@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221114152843.ylxe4dis254vrj5u@box.shutemov.name>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|BN9PR12MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cee322-9008-4610-fa69-08dac68df47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BY3zSEoSRZKSh2wRev1auNh/P6OFerGFjzhoOrcPX1T5R9uqvGV/3ga/CWspUlvYlSwVSM7pdl07edr+1YCWV7IkOlcyKIm/ytcxs6bBjgIO5wokGGK2WonExKAf6E2n6rQ5WlIdcU0IJDeJ7zd9NseIyZWHhVFqrHkhWP6jV1zEX2bteHtggeOk46jmcWFBIgoRD3NRKj4Gcu0lUsUQtucjJNiTQ0MUOq96tG4XeQ3T91HhTR7kzH9G29Jv4jCqNNQufnluCWk1ulOluD3OpB/11cx5+fs8ylm9TNrJHYrKmm0JrwrW9sUqMEYJ/J+Fr/sn4S4zp6dALBootMdnM1wRYUsYEV/yt36eaIvYdsL1gJsYTJjuMmJN/P5Wm/bYsxvCWc/9M9TZ7BxqKfyZSe3zEhNjG4S1URS7a+8vCTnPrdMT7QQ49RnmvhCPaMbEaYeMPWJ1usW/kUZTCseb/jeIYrbHpj06eBWiTC9uObY4wqWhj7ns7/mjOOhtSK5+TpHMadt2wBddpgF+KkFmP8Y5rMkc/kae2EGxYDg6vNDycTLDeyviJQn8fVBX9gT9hYN9Zu3rB9mW382Lbffqyq65iklgEm0ZY6tZQjIyHFSoRMiojnWpVc4bUec4LPlmS2xI2RpsQnYdBpPoASMzg88QxAA1bQ4v4FiV8KNUUIsjI8eTGi9t6/4uSakNT6DTRghYUNKUt7NUHWlJZZvBlOtYosfO95lA7cPogHDJsiaNL/4xna0qJFo4RWDZH+kAT13ncYvqgvLicN9qIQDe7pMLttDrHTnptBv2nsV/n+0C4VH6ssK66jmnYqlwhUs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(186003)(5660300002)(6916009)(54906003)(36860700001)(83380400001)(316002)(2906002)(53546011)(40460700003)(41300700001)(1076003)(44832011)(8936002)(36756003)(16526019)(2616005)(7416002)(336012)(426003)(7406005)(40480700001)(8676002)(70586007)(4326008)(26005)(70206006)(66899015)(82310400005)(478600001)(6666004)(86362001)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 22:17:02.0059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cee322-9008-4610-fa69-08dac68df47e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:28:43PM +0300, Kirill A. Shutemov wrote:
> On Mon, Nov 14, 2022 at 03:02:37PM +0100, Vlastimil Babka wrote:
> > On 11/1/22 16:19, Michael Roth wrote:
> > > On Tue, Nov 01, 2022 at 07:37:29PM +0800, Chao Peng wrote:
> > >> > 
> > >> >   1) restoring kernel directmap:
> > >> > 
> > >> >      Currently SNP (and I believe TDX) need to either split or remove kernel
> > >> >      direct mappings for restricted PFNs, since there is no guarantee that
> > >> >      other PFNs within a 2MB range won't be used for non-restricted
> > >> >      (which will cause an RMP #PF in the case of SNP since the 2MB
> > >> >      mapping overlaps with guest-owned pages)
> > >> 
> > >> Has the splitting and restoring been a well-discussed direction? I'm
> > >> just curious whether there is other options to solve this issue.
> > > 
> > > For SNP it's been discussed for quite some time, and either splitting or
> > > removing private entries from directmap are the well-discussed way I'm
> > > aware of to avoid RMP violations due to some other kernel process using
> > > a 2MB mapping to access shared memory if there are private pages that
> > > happen to be within that range.
> > > 
> > > In both cases the issue of how to restore directmap as 2M becomes a
> > > problem.
> > > 
> > > I was also under the impression TDX had similar requirements. If so,
> > > do you know what the plan is for handling this for TDX?
> > > 
> > > There are also 2 potential alternatives I'm aware of, but these haven't
> > > been discussed in much detail AFAIK:
> > > 
> > > a) Ensure confidential guests are backed by 2MB pages. shmem has a way to
> > >    request 2MB THP pages, but I'm not sure how reliably we can guarantee
> > >    that enough THPs are available, so if we went that route we'd probably
> > >    be better off requiring the use of hugetlbfs as the backing store. But
> > >    obviously that's a bit limiting and it would be nice to have the option
> > >    of using normal pages as well. One nice thing with invalidation
> > >    scheme proposed here is that this would "Just Work" if implement
> > >    hugetlbfs support, so an admin that doesn't want any directmap
> > >    splitting has this option available, otherwise it's done as a
> > >    best-effort.
> > > 
> > > b) Implement general support for restoring directmap as 2M even when
> > >    subpages might be in use by other kernel threads. This would be the
> > >    most flexible approach since it requires no special handling during
> > >    invalidations, but I think it's only possible if all the CPA
> > >    attributes for the 2M range are the same at the time the mapping is
> > >    restored/unsplit, so some potential locking issues there and still
> > >    chance for splitting directmap over time.
> > 
> > I've been hoping that
> > 
> > c) using a mechanism such as [1] [2] where the goal is to group together
> > these small allocations that need to increase directmap granularity so
> > maximum number of large mappings are preserved.
> 
> As I mentioned in the other thread the restricted memfd can be backed by
> secretmem instead of plain memfd. It already handles directmap with care.

It looks like it would handle direct unmapping/cleanup nicely, but it
seems to lack fallocate(PUNCH_HOLE) support which we'd probably want to
avoid additional memory requirements. I think once we added that we'd
still end up needing some sort of handling for the invalidations.

Also, I know Chao has been considering hugetlbfs support, I assume by
leveraging the support that already exists in shmem. Ideally SNP would
be able to make use of that support as well, but relying on a separate
backend seems likely to result in more complications getting there
later.

> 
> But I don't think it has to be part of initial restricted memfd
> implementation. It is SEV-specific requirement and AMD folks can extend
> implementation as needed later.

Admittedly the suggested changes to the invalidation mechanism made a
lot more sense to me when I was under the impression that TDX would have
similar requirements and we might end up with a common hook. Since that
doesn't actually seem to be the case, it makes sense to try to do it as
a platform-specific hook for SNP.

I think, given a memslot, a GFN range, and kvm_restricted_mem_get_pfn(),
we should be able to get the same information needed to figure out whether
the range is backed by huge pages or not. I'll see how that works out
instead.

Thanks,

Mike

> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
