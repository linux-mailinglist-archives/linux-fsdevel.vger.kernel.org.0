Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC3D63D83E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 15:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiK3OcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 09:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiK3OcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:32:00 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597B081380;
        Wed, 30 Nov 2022 06:31:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI6rP4h3Gtd+TKM6/OFN8xfBe1iJTpvYX6EB3Dmzfkpend2dIgkRcbmZHkNxGT+vwijgvyoQEEFw9ifyalVGRdmrftJAUJJgloo6RWozaif/yBFaEB+TjqrEjhw/LEXLR3Ciq2tNijUmOzSUPjYZnnduu54Q9Qd9unPrhhe9hVpU5neCEbvJPmTtoKBlKwmt4z06JqDNFHbGY5biZDpaUEh9OIU1/1clyGaWkpjky9O7J4cOZC+WF0InbX3gCXf1dQoKd8y0XiCKXD4RNOyHjpjJPs8Zu1E5KXXkSl9Lb+9NfoOq6Mcr7+/kYHwV7QOhnhKaut+9p9y2YsyHqxlqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X94a/BZrJrzOrdnlzM17noCrSKUuj83mShL7oXywayA=;
 b=VbQDrQQQdaONZgTI91CbHXaJmXR5GLGIqVXac/HavhyLm99egnHYF+rog40ILYieAt9yaz13Z9XTquoAaUVJCaG//mBC9gyuxNPdLHulOE8ZrC7d0kn8RYeGkBcrAJOcgeWd/5yjHMFsSHgS80jdzn8UKP1EfXsgUAOmfqbk+fr7nqn2Szlb+A/1y5WhuvFEk82myjRZdhBAcGrQclq0WJT/Ee4CTmGhCNvjIxBv2h3cW5igKGIIbc9LfG8bp03nrY3mqwo0v2Abmr9Aqa7yvvCScDr/bAsBsyKnfkTaamlixLVCISbCOmghuCuv6uXyNpm6DZc4Ouaz5PsldK5cwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X94a/BZrJrzOrdnlzM17noCrSKUuj83mShL7oXywayA=;
 b=dn09wEPoTeFD75Gn32k/f8K7rx0VV5DzSweh2posY9dLt/ljrh4Y7cM6lZMP8OrNbWNKYKtzhWCy+jNLPVzG6DiOqa7r7vkFegn3xUJCVioQBZMhEja+UcbrDQPnV8OjKH+N+D2m318nDXaIrJvAHHL1Hv0fJeq0f7EH+kACh8s=
Received: from BN9PR03CA0384.namprd03.prod.outlook.com (2603:10b6:408:f7::29)
 by CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 14:31:48 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::2d) by BN9PR03CA0384.outlook.office365.com
 (2603:10b6:408:f7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 14:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 30 Nov 2022 14:31:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 08:31:46 -0600
Date:   Wed, 30 Nov 2022 08:31:27 -0600
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
Message-ID: <20221130143127.4oangkfh4gantce6@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221129003725.l34qhx6n44mq2gtl@amd.com>
 <20221129140615.GC902164@chaop.bj.intel.com>
 <20221129190658.jefuep7nglp25ugt@amd.com>
 <20221129191815.atuv6arhodjbnvb2@amd.com>
 <20221130093931.GA945726@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221130093931.GA945726@chaop.bj.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|CH2PR12MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2aecdb-737b-4211-40a0-08dad2df9ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Auop8QR9RxtbMPxo/Grvyn+LHvn5wThyrC9SexUvezlYPheE3QDmFxI0nqNF2WBNK2Vo0zaupszv/5y0sjsXDBMb981jAtVWqXX/i/fRIEUWkDdbDZSr7Do29meu87vOSk79df8KxmPot9eNuOuzVE/8v/1JoDrSFOV+5rxHQKdlsQBIC3yNtg27Uf7nIZZrnX7XT3oJd/8bPhkgkIHiKic1UGq0SXpRDklCTM6MRLJQb7lW1SKMmJ+IbryU30GLofYdUHwOYmfgg7UXkJVquQgtNlnpy/cPvuN/CKxZ/5ViQlzgoRWk8KLg6GplseHHMqJ2M/VSlWcGL1n6s4adUnz6Wc6K4LW0RXGTWuQcfx8RHKoi8C2vPwfoK9NVg07o8KeaEXT+b+t94G9iN8gyAtfqfLxOnFA9EJ3lC0xzOMyFI2UAcP6bJVQgaL7u75rXUQjOk30nHhXZAS8eR9L6nHFHAQqLFOzqQedlW1x+u7hyEKEV2UfiAanUs/XCvizAFPSamLhu7HDOnMgqi2p/pmBH+u11A8w6H8UFr8peHTYF2jMd+Iu6fGgPPoKzpTBAVr4cfZp+m9YnvOdwyxmGzal2bDVFckj6ufhfKUx0JPJw8NZ7AkSgGCsUlLh3kF28zpQx1kCwu8oKKwAUQ8UyikMBT5eKxXYELFWDu4cod7Yz91zTO/kaFvOw6g3aU4qdDUrrz+YCp3fe0x94v73NidlQKd/sFW+roEY9Z+3qySkoQGM7uFai+Z+gk9aFEpE4u7THrPOEDvMRtXSzAMeXqPU+VMRAXsiPEUzQysphTRvGB2RW7JD4h2yXsXTY0sp
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(47076005)(426003)(6666004)(86362001)(478600001)(966005)(7416002)(7406005)(16526019)(81166007)(356005)(36756003)(40460700003)(40480700001)(2906002)(2616005)(82740400003)(186003)(83380400001)(82310400005)(1076003)(336012)(70586007)(44832011)(41300700001)(316002)(26005)(36860700001)(8936002)(54906003)(8676002)(4326008)(6916009)(5660300002)(45080400002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:31:47.3075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2aecdb-737b-4211-40a0-08dad2df9ca1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 05:39:31PM +0800, Chao Peng wrote:
> On Tue, Nov 29, 2022 at 01:18:15PM -0600, Michael Roth wrote:
> > On Tue, Nov 29, 2022 at 01:06:58PM -0600, Michael Roth wrote:
> > > On Tue, Nov 29, 2022 at 10:06:15PM +0800, Chao Peng wrote:
> > > > On Mon, Nov 28, 2022 at 06:37:25PM -0600, Michael Roth wrote:
> > > > > On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> > > > ...
> > > > > > +static long restrictedmem_fallocate(struct file *file, int mode,
> > > > > > +				    loff_t offset, loff_t len)
> > > > > > +{
> > > > > > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > > > > > +	struct file *memfd = data->memfd;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > > > > > +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > > > > > +			return -EINVAL;
> > > > > > +	}
> > > > > > +
> > > > > > +	restrictedmem_notifier_invalidate(data, offset, offset + len, true);
> > > > > 
> > > > > The KVM restrictedmem ops seem to expect pgoff_t, but here we pass
> > > > > loff_t. For SNP we've made this strange as part of the following patch
> > > > > and it seems to produce the expected behavior:
> > > > 
> > > > That's correct. Thanks.
> > > > 
> > > > > 
> > > > >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommit%2Fd669c7d3003ff7a7a47e73e8c3b4eeadbd2c4eb6&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf3ad9d505bec4006028308dad2b76bc5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638053982483658905%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ipHjTVNhiRmaa%2BKTJiodbxHS7TOaYbBhAPD0VZ%2FFU2k%3D&amp;reserved=0
> > > > > 
> > > > > > +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> > > > > > +	restrictedmem_notifier_invalidate(data, offset, offset + len, false);
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > 
> > > > > <snip>
> > > > > 
> > > > > > +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> > > > > > +			   struct page **pagep, int *order)
> > > > > > +{
> > > > > > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > > > > > +	struct file *memfd = data->memfd;
> > > > > > +	struct page *page;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> > > > > 
> > > > > This will result in KVM allocating pages that userspace hasn't necessary
> > > > > fallocate()'d. In the case of SNP we need to get the PFN so we can clean
> > > > > up the RMP entries when restrictedmem invalidations are issued for a GFN
> > > > > range.
> > > > 
> > > > Yes fallocate() is unnecessary unless someone wants to reserve some
> > > > space (e.g. for determination or performance purpose), this matches its
> > > > semantics perfectly at:
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.man7.org%2Flinux%2Fman-pages%2Fman2%2Ffallocate.2.html&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf3ad9d505bec4006028308dad2b76bc5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638053982483658905%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=NJXs0bvvqb3oU%2FGhcvgHSvh8r1DouskOY5CreP1Q5OU%3D&amp;reserved=0
> > > > 
> > > > > 
> > > > > If the guest supports lazy-acceptance however, these pages may not have
> > > > > been faulted in yet, and if the VMM defers actually fallocate()'ing space
> > > > > until the guest actually tries to issue a shared->private for that GFN
> > > > > (to support lazy-pinning), then there may never be a need to allocate
> > > > > pages for these backends.
> > > > > 
> > > > > However, the restrictedmem invalidations are for GFN ranges so there's
> > > > > no way to know inadvance whether it's been allocated yet or not. The
> > > > > xarray is one option but currently it defaults to 'private' so that
> > > > > doesn't help us here. It might if we introduced a 'uninitialized' state
> > > > > or something along that line instead of just the binary
> > > > > 'shared'/'private' though...
> > > > 
> > > > How about if we change the default to 'shared' as we discussed at
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FY35gI0L8GMt9%2BOkK%40google.com%2F&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf3ad9d505bec4006028308dad2b76bc5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638053982483658905%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2F1g3NdU0iLO6rWVgSm42UYlfHGG2EJ1Wp0r%2FGEznUoo%3D&amp;reserved=0?
> > > 
> > > Need to look at this a bit more, but I think that could work as well.
> > > 
> > > > > 
> > > > > But for now we added a restrictedmem_get_page_noalloc() that uses
> > > > > SGP_NONE instead of SGP_WRITE to avoid accidentally allocating a bunch
> > > > > of memory as part of guest shutdown, and a
> > > > > kvm_restrictedmem_get_pfn_noalloc() variant to go along with that. But
> > > > > maybe a boolean param is better? Or maybe SGP_NOALLOC is the better
> > > > > default, and we just propagate an error to userspace if they didn't
> > > > > fallocate() in advance?
> > > > 
> > > > This (making fallocate() a hard requirement) not only complicates the
> > > > userspace but also forces the lazy-faulting going through a long path of
> > > > exiting to userspace. Unless we don't have other options I would not go
> > > > this way.
> > > 
> > > Unless I'm missing something, it's already the case that userspace is
> > > responsible for handling all the shared->private transitions in response
> > > to KVM_EXIT_MEMORY_FAULT or (in our case) KVM_EXIT_VMGEXIT. So it only
> > > places the additional requirements on the VMM that if they *don't*
> > > preallocate, then they'll need to issue the fallocate() prior to issuing
> > > the KVM_MEM_ENCRYPT_REG_REGION ioctl in response to these events.
> 
> Preallocating and memory conversion between shared<->private are two
> different things. No double fallocate() and conversion can be called

I just mean that we don't actually have additional userspace exits for
doing lazy-faulting in this manner, because prior to mapping restricted
page into the TDP, we will have gotten a KVM_EXIT_MEMORY_FAULT anyway so
that userspace can handle the conversion, so if you do the fallocate()
prior to KVM_MEM_ENCRYPT_REG_REGION, there's no additional KVM exits
(unless you count the fallocate() syscall itself but that seems
negligable compared to memory allocation).

For instance on QEMU side we do the fallocate() as part of
kvm_convert_memory() helper.

But thinking about it more, the main upside to this approach (giving VMM
control/accounting over restrictedmem allocations), doesn't actually
work out. For instance if VMM fallocate()'s memory for a single 4K page
prior to shared->private conversion, shmem might still allocate a THP for
that whole 2M range, and userspace doesn't have a good way to account
for this. So what I'm proposing probably isn't feasible anyway.

> different things. No double fallocate() and conversion can be called
> together in response to KVM_EXIT_MEMORY_FAULT, but they don't have to be
> paired. And the fallocate() does not have to operate on the same memory
> range as memory conversion does.
> 
> > > 
> > > QEMU for example already has a separate 'prealloc' option for cases
> > > where they want to prefault all the guest memory, so it makes sense to
> > > continue making that an optional thing with regard to UPM.
> 
> Making 'prealloc' work for UPM in QEMU does sound reasonable. Anyway,
> it's just an option so not change the assumption here.
> 
> > 
> > Although I guess what you're suggesting doesn't stop userspace from
> > deciding whether they want to prefault or not. I know the Google folks
> > had some concerns over unexpected allocations causing 2x memory usage
> > though so giving userspace full control of what is/isn't allocated in
> > the restrictedmem backend seems to make it easier to guard against this,
> > but I think checking the xarray and defaulting to 'shared' would work
> > for us if that's the direction we end up going.
> 
> Yeah, that looks very likely the direction satisfying all people here.

Ok, yah after some more thought this probably is the more feasible
approach. Thanks for your input on this.

-Mike

> 
> Chao
> > 
> > -Mike
> > 
> > > 
> > > -Mike
> > > 
> > > > 
> > > > Chao
> > > > > 
> > > > > -Mike
> > > > > 
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	*pagep = page;
> > > > > > +	if (order)
> > > > > > +		*order = thp_order(compound_head(page));
> > > > > > +
> > > > > > +	SetPageUptodate(page);
> > > > > > +	unlock_page(page);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(restrictedmem_get_page);
> > > > > > -- 
> > > > > > 2.25.1
> > > > > > 
