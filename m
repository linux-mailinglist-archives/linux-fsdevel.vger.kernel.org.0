Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EE163C802
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 20:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiK2TT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 14:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiK2TTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:19:08 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5586C702;
        Tue, 29 Nov 2022 11:18:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya78Ezq9m7iGOb0sLxhOhdB9bV1Mpjxj6p+V5fAR9jb9/4LI6MO9HNjAqnosS3U/PFaXdQAhlrcWwfnKRYUn5mvF4iPpPTod6CIPzrptF5/faksK76tetsi19s5lerIGPVLDdyw7B50vf/oihJTwVw7c+FH2djOcCbobiOUkNJKNVZ6SHByxakEUTxSc/mH7zqH8EVdGOuVqmADoSxOF+fmJ32+PPZj492ptcS8gZ8+/y4YtyM5NpeRE06gUfFEERTDSN9/++vmxt2f1O+KaOUUmFfT4R7w/MBBZek5yOMk+lm9OskCPo7k5/Hyv+XC4j2xzDANJrDTaI38WJiNLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJbBt7jAQwWyBruyyDiBbG+QCwuQffS38SJ/h8ChIxs=;
 b=OegI722G3BsnsulCrxkkAcDthQ5py0/UANx8PtUSl9lmXkfnKABbn5E3Afuej7UxuU9G/XC7XUBlmAA/RavvHyRdj81eTWovj5RgueabRlRrkHVqOZP8Bx4Q6EiRK1V4tBguINW0VocNIsTvjWoI7w6JyqKamWm6HutBPyrikvwkOPHJYtglgFTjcDhZ4pLJ+IQcEwmhQnnsKBJwCBhaQCwY7y/jDy8QBaUGVN3wQl2WouX5WbxMgZ7WJdwaV9WvhMDbvsNIMf1OzFHngIP6YR5GAaMiMrvWNoG7AgmRohtq+f9E/hl9ZBlra4W6RQwEUsPQtuETnCF9cy2ZiP6+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJbBt7jAQwWyBruyyDiBbG+QCwuQffS38SJ/h8ChIxs=;
 b=YkZuBPysnBEWDO0SyiBUXCNqnZQz3AH2EZlZzxp3L9XQ9V/YhisxT8JlP3X1XyK0cKfluRAaAlfX9lhy7AzUy9wwnf/52nfvBdJFBVjH1YK5iohXOyb7+fwWPNL3T7B6d0FC5qnnt4719/97TpMdcRzR6X4F/RIg44qU0X6m1n4=
Received: from BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::18)
 by BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 19:18:34 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::d) by BL1P221CA0028.outlook.office365.com
 (2603:10b6:208:2c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 19:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Tue, 29 Nov 2022 19:18:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 13:18:32 -0600
Date:   Tue, 29 Nov 2022 13:18:15 -0600
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
Message-ID: <20221129191815.atuv6arhodjbnvb2@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221129003725.l34qhx6n44mq2gtl@amd.com>
 <20221129140615.GC902164@chaop.bj.intel.com>
 <20221129190658.jefuep7nglp25ugt@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221129190658.jefuep7nglp25ugt@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|BL0PR12MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: a53f2ff8-3fec-4330-5e15-08dad23e81d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1YQoXVVqN5Zt/GSq3FNnFzuDCgiUcoO9srG8o3nC50G/UigLFTf0mJbYp3NQV303UTvLYS6vvYOxpmm5qY1F822Z76imP6MtJYsTwfYcU+Kvzev6sx66p1vIq8ivrYQskldJK+Xhg1VJcEz1uMOwBe9Sv4d7eYMPbyOlf5hsL8Hd5NAuGRQrls2e1pRDWeUD3YkoPFHCV3144ibUn2RjjCuBlIxyP44GJmkd9y8XRhI+pBWxdEEukY5i+wjlKBtoko48N8Ldrv5x1cHzxOIl7sjJex/dhoAawXIpMqskuIf2DsImSuY2nWNkguwXtnNqhUBv5DGnrfFG3Mq/vv++eVA0JgKgeYET9tMiGTLe5/xJuFYIiZ9ELFrcEWC77ufGSsIBCyJFiLqNPv5gLyGCUhPRMMjB4sYL/LlCr3KcnPiJI1kMlsUb/XPavFsncES0QALvpA5fL7lTcl/CKnNdT2FKAsekzIypOQbDXNzbnd5D3dJwZ5212lKoIm8dVWr2voFwV96tjHqW2dCnw/NS3LaLmiENH//eZloRJ6bMBI1qqbrvQv9MOHkOiP0pAUN4zMvM7tAo/Se2YPTU+jPwl9wwv2tVIAGRRU8RNiSEcq7SJnzcqcKEDjrcgzIJdAAQyQZ9BfPXd37Yx6xS37UjfMayySNmQpU3H7NkI3kUMmakoDhmQG872kMuO62FaXHTsUwBdwzz3kAcHtNNrDtrxKOoVlFOs1+JnkRFlR1qPcOYyYMPO0kLAhnMjpneQSclaBOHJT4n/qsPygPP3sna+4tRU9F850LYa6mAzwBDNYD7KNXam1g7q49sdlX0bvE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(8936002)(5660300002)(45080400002)(1076003)(36756003)(8676002)(4326008)(70206006)(54906003)(316002)(36860700001)(82740400003)(47076005)(40480700001)(81166007)(426003)(83380400001)(356005)(966005)(7406005)(82310400005)(40460700003)(86362001)(26005)(478600001)(336012)(2616005)(6666004)(16526019)(7416002)(186003)(6916009)(41300700001)(70586007)(44832011)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 19:18:33.2299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53f2ff8-3fec-4330-5e15-08dad23e81d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 01:06:58PM -0600, Michael Roth wrote:
> On Tue, Nov 29, 2022 at 10:06:15PM +0800, Chao Peng wrote:
> > On Mon, Nov 28, 2022 at 06:37:25PM -0600, Michael Roth wrote:
> > > On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> > ...
> > > > +static long restrictedmem_fallocate(struct file *file, int mode,
> > > > +				    loff_t offset, loff_t len)
> > > > +{
> > > > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > > > +	struct file *memfd = data->memfd;
> > > > +	int ret;
> > > > +
> > > > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > > > +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > > > +			return -EINVAL;
> > > > +	}
> > > > +
> > > > +	restrictedmem_notifier_invalidate(data, offset, offset + len, true);
> > > 
> > > The KVM restrictedmem ops seem to expect pgoff_t, but here we pass
> > > loff_t. For SNP we've made this strange as part of the following patch
> > > and it seems to produce the expected behavior:
> > 
> > That's correct. Thanks.
> > 
> > > 
> > >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommit%2Fd669c7d3003ff7a7a47e73e8c3b4eeadbd2c4eb6&amp;data=05%7C01%7CMichael.Roth%40amd.com%7C0c26815eb6af4f1a243508dad23cf713%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638053456609134623%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=kAL42bmyBB0alVwh%2FN%2BT3D%2BiVTdxxMsJ7V4TNuCTjM4%3D&amp;reserved=0
> > > 
> > > > +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> > > > +	restrictedmem_notifier_invalidate(data, offset, offset + len, false);
> > > > +	return ret;
> > > > +}
> > > > +
> > > 
> > > <snip>
> > > 
> > > > +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> > > > +			   struct page **pagep, int *order)
> > > > +{
> > > > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > > > +	struct file *memfd = data->memfd;
> > > > +	struct page *page;
> > > > +	int ret;
> > > > +
> > > > +	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> > > 
> > > This will result in KVM allocating pages that userspace hasn't necessary
> > > fallocate()'d. In the case of SNP we need to get the PFN so we can clean
> > > up the RMP entries when restrictedmem invalidations are issued for a GFN
> > > range.
> > 
> > Yes fallocate() is unnecessary unless someone wants to reserve some
> > space (e.g. for determination or performance purpose), this matches its
> > semantics perfectly at:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.man7.org%2Flinux%2Fman-pages%2Fman2%2Ffallocate.2.html&amp;data=05%7C01%7CMichael.Roth%40amd.com%7C0c26815eb6af4f1a243508dad23cf713%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638053456609134623%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=acBSquFG%2FHtpbcZfHDZrP2O63bu06rI0pjiPJFSJSj8%3D&amp;reserved=0
> > 
> > > 
> > > If the guest supports lazy-acceptance however, these pages may not have
> > > been faulted in yet, and if the VMM defers actually fallocate()'ing space
> > > until the guest actually tries to issue a shared->private for that GFN
> > > (to support lazy-pinning), then there may never be a need to allocate
> > > pages for these backends.
> > > 
> > > However, the restrictedmem invalidations are for GFN ranges so there's
> > > no way to know inadvance whether it's been allocated yet or not. The
> > > xarray is one option but currently it defaults to 'private' so that
> > > doesn't help us here. It might if we introduced a 'uninitialized' state
> > > or something along that line instead of just the binary
> > > 'shared'/'private' though...
> > 
> > How about if we change the default to 'shared' as we discussed at
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FY35gI0L8GMt9%2BOkK%40google.com%2F&amp;data=05%7C01%7CMichael.Roth%40amd.com%7C0c26815eb6af4f1a243508dad23cf713%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638053456609134623%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Q1vZWQiZ7mx12Qn5aKl4s8Ea9hNbwCJBb%2BjiA1du3Os%3D&amp;reserved=0?
> 
> Need to look at this a bit more, but I think that could work as well.
> 
> > > 
> > > But for now we added a restrictedmem_get_page_noalloc() that uses
> > > SGP_NONE instead of SGP_WRITE to avoid accidentally allocating a bunch
> > > of memory as part of guest shutdown, and a
> > > kvm_restrictedmem_get_pfn_noalloc() variant to go along with that. But
> > > maybe a boolean param is better? Or maybe SGP_NOALLOC is the better
> > > default, and we just propagate an error to userspace if they didn't
> > > fallocate() in advance?
> > 
> > This (making fallocate() a hard requirement) not only complicates the
> > userspace but also forces the lazy-faulting going through a long path of
> > exiting to userspace. Unless we don't have other options I would not go
> > this way.
> 
> Unless I'm missing something, it's already the case that userspace is
> responsible for handling all the shared->private transitions in response
> to KVM_EXIT_MEMORY_FAULT or (in our case) KVM_EXIT_VMGEXIT. So it only
> places the additional requirements on the VMM that if they *don't*
> preallocate, then they'll need to issue the fallocate() prior to issuing
> the KVM_MEM_ENCRYPT_REG_REGION ioctl in response to these events.
> 
> QEMU for example already has a separate 'prealloc' option for cases
> where they want to prefault all the guest memory, so it makes sense to
> continue making that an optional thing with regard to UPM.

Although I guess what you're suggesting doesn't stop userspace from
deciding whether they want to prefault or not. I know the Google folks
had some concerns over unexpected allocations causing 2x memory usage
though so giving userspace full control of what is/isn't allocated in
the restrictedmem backend seems to make it easier to guard against this,
but I think checking the xarray and defaulting to 'shared' would work
for us if that's the direction we end up going.

-Mike

> 
> -Mike
> 
> > 
> > Chao
> > > 
> > > -Mike
> > > 
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	*pagep = page;
> > > > +	if (order)
> > > > +		*order = thp_order(compound_head(page));
> > > > +
> > > > +	SetPageUptodate(page);
> > > > +	unlock_page(page);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(restrictedmem_get_page);
> > > > -- 
> > > > 2.25.1
> > > > 
