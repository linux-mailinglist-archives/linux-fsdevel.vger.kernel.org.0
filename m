Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6FE63C7C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 20:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiK2THV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 14:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiK2THT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:07:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A95925F8;
        Tue, 29 Nov 2022 11:07:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqmyOBWe1TnDdlflTgp+FIkZURp7HdzPCiPyUyuQQZMfdKUSFlq/lM7ZngnunvktGHYlfP+taNjszD1BJKxvmkiIiZDLk20XEHdFvjT4Gg61Wx3LlNT9WAXyg0yH6spflnN3Vg5D7bNrPS9A+j1NFS8jg/B1+AZUcqp3dEFrvStry66zqGhWHUoAOzynYmMUTzoK3iAzSHNrexNHILtcCanjdLWKXDfw7fGtJudwVCcWZJ53ioF5N1i67aLrVnSZVIPYs5smzKA4Ngsy4SaHiuyh+RxYQ7QOsazqBwumzCMr+mdY1+tciGw6yDJtfyoOIifa+sgVuElg1TPw3MxSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyhsfZfDSnfHac33DvGjtVqqyJKCi1TX7dxHWWYx9sI=;
 b=NRVLhRFV35/z2sNbIhjUN6pGa5bLdrW2xlwUMzdF7GBcGTD70fEkycsq+tbeQZD4ro5GOH+EoGo5pdtapBMJzkmaowaZJ0W2Y6HNkZb2UUHlVWkm7Ycd7N0ZTGOOe/vDHz68Y4l5cwiICMkHspxGWr1KP/xovnmSNWdnQf1+L1EBmMI0IFsMun3FIwjGTVmF8i8BDtWCL/aqVG/5+LD5SXlpB9IIDfECY96gRA/72swcc4x28ZVVz71MqCSqv7rLNIGlVYez4ensG+hWIZ+l+6hnTjFonSy+e11dV0daW9sYJK4cQ7fu1wrIvZDU39Y5tmEkKEW5viojXqdbjGdZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyhsfZfDSnfHac33DvGjtVqqyJKCi1TX7dxHWWYx9sI=;
 b=IFlw9rIc3GenHnfhx+sN4TuaWNNSFxITX7CtyCKdNEd0k8kLxZCQCclCwxgUVhd8Pv2TdkGRt27miR04j+li5TQm6lgmZcXNvyV6L27gRK0VaukAVhD2FLTnqXs4sX/IjWOQ4/8FQkxeCsUqwI8KtKkJylqEMZYXt1rXA043dDc=
Received: from DM6PR01CA0015.prod.exchangelabs.com (2603:10b6:5:296::20) by
 DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Tue, 29 Nov 2022 19:07:16 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::41) by DM6PR01CA0015.outlook.office365.com
 (2603:10b6:5:296::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18 via Frontend
 Transport; Tue, 29 Nov 2022 19:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Tue, 29 Nov 2022 19:07:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 13:07:15 -0600
Date:   Tue, 29 Nov 2022 13:06:58 -0600
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
Message-ID: <20221129190658.jefuep7nglp25ugt@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221129003725.l34qhx6n44mq2gtl@amd.com>
 <20221129140615.GC902164@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221129140615.GC902164@chaop.bj.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 69789a1f-1946-480f-2466-08dad23cedfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UK+9yNabpw4Bhe9toh5F1gx0IR3BxAaFRau79xY1hpgUFoT8oghQW28MjB5fJ29QctPytR5jcMCIkgWGWc7IgClelH2QmLu0S/8vyE9N8BALfnMOrKzA0AdtFyGvoeGq9vInBhEtURkZinlPX+Q0X55PgNIDJyyYl6NnpDPN3ab2iS+9eI6FGqBNBurdJx5B220JKLEOtVppBga3hxosQ4xNNqZpW4Hswxl9K9BvJbc+58hQiDN/NvFJ7J9bIVtc0eVoUpG8uU7TDY67oVFS1Xwq267UjkDOIhGYYKrZZeyalrszj4b9ygmgkiegfsF1geY/Z8A8Mo/1ON2xG3qVIDZw8FGYVGPxSKebmInW4UODn8ioeOmyUy+g+Z0fDv+DELPUqGDFGzEsX51xaamEjsvXHMAIlSMtYPpMdSsX3Q2vYMzBgD6kf31Lkh4T1m6kQn6XRo4iJkCvaW8en6MFQLUlHCFpr2njK8K2xW7hbUC2ANfXJbWo253tvvaoVWsoGrGPWPW01ZHyt4jPD/nMCKpI4oMdxSkN0LlJtDw9uxd4vmdtnxLD1KLn/C0M4X2VzVpWYTqdtsmQB21qWbkG44cS6TuVsisUaZ/32i0kIxI5Kqf3zldK8nXtv33dIWcrg3ZOaxlW3Apg9CTZWSiw73tbqgR7Sqrh8lS8fD1Cj8Caxu4I1L/8qKjezSHjHTWzpQQLaawln1KNZ4hms1O6TcJ+0NtiGsc5/3/BpWmWf2MCPpZw5jLOZIfXTWAzzRNjKdPIe6/Yeq5gijP9gTmbrWP/BjxCZBfiQy6Ssm/cEr7dERZ6ZdXHW6Y/B+R1vdzk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(36756003)(36860700001)(86362001)(6666004)(966005)(45080400002)(478600001)(70586007)(316002)(2616005)(1076003)(41300700001)(16526019)(8936002)(6916009)(70206006)(26005)(5660300002)(7406005)(426003)(7416002)(2906002)(40480700001)(47076005)(44832011)(356005)(81166007)(40460700003)(82740400003)(54906003)(186003)(8676002)(4326008)(336012)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 19:07:15.7626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69789a1f-1946-480f-2466-08dad23cedfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:06:15PM +0800, Chao Peng wrote:
> On Mon, Nov 28, 2022 at 06:37:25PM -0600, Michael Roth wrote:
> > On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> ...
> > > +static long restrictedmem_fallocate(struct file *file, int mode,
> > > +				    loff_t offset, loff_t len)
> > > +{
> > > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > > +	struct file *memfd = data->memfd;
> > > +	int ret;
> > > +
> > > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > > +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > > +			return -EINVAL;
> > > +	}
> > > +
> > > +	restrictedmem_notifier_invalidate(data, offset, offset + len, true);
> > 
> > The KVM restrictedmem ops seem to expect pgoff_t, but here we pass
> > loff_t. For SNP we've made this strange as part of the following patch
> > and it seems to produce the expected behavior:
> 
> That's correct. Thanks.
> 
> > 
> >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommit%2Fd669c7d3003ff7a7a47e73e8c3b4eeadbd2c4eb6&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C99e80696067a40d42f6e08dad2138556%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638053278531323330%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WDj4KxJjhcntBWJUGCjNmMPfZMGQkCSaAo6ElYrGgF0%3D&amp;reserved=0
> > 
> > > +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> > > +	restrictedmem_notifier_invalidate(data, offset, offset + len, false);
> > > +	return ret;
> > > +}
> > > +
> > 
> > <snip>
> > 
> > > +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> > > +			   struct page **pagep, int *order)
> > > +{
> > > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > > +	struct file *memfd = data->memfd;
> > > +	struct page *page;
> > > +	int ret;
> > > +
> > > +	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> > 
> > This will result in KVM allocating pages that userspace hasn't necessary
> > fallocate()'d. In the case of SNP we need to get the PFN so we can clean
> > up the RMP entries when restrictedmem invalidations are issued for a GFN
> > range.
> 
> Yes fallocate() is unnecessary unless someone wants to reserve some
> space (e.g. for determination or performance purpose), this matches its
> semantics perfectly at:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.man7.org%2Flinux%2Fman-pages%2Fman2%2Ffallocate.2.html&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C99e80696067a40d42f6e08dad2138556%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638053278531323330%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=67sdTY47cM1IBUG2eJCltYF5SyGOpd9%2FVxVlHUw02tU%3D&amp;reserved=0
> 
> > 
> > If the guest supports lazy-acceptance however, these pages may not have
> > been faulted in yet, and if the VMM defers actually fallocate()'ing space
> > until the guest actually tries to issue a shared->private for that GFN
> > (to support lazy-pinning), then there may never be a need to allocate
> > pages for these backends.
> > 
> > However, the restrictedmem invalidations are for GFN ranges so there's
> > no way to know inadvance whether it's been allocated yet or not. The
> > xarray is one option but currently it defaults to 'private' so that
> > doesn't help us here. It might if we introduced a 'uninitialized' state
> > or something along that line instead of just the binary
> > 'shared'/'private' though...
> 
> How about if we change the default to 'shared' as we discussed at
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FY35gI0L8GMt9%2BOkK%40google.com%2F&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C99e80696067a40d42f6e08dad2138556%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638053278531323330%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=qzWObDo7ZHW4YjuAjZ5%2B1wEwbqymgBiNM%2BYXiyUSBdI%3D&amp;reserved=0?

Need to look at this a bit more, but I think that could work as well.

> > 
> > But for now we added a restrictedmem_get_page_noalloc() that uses
> > SGP_NONE instead of SGP_WRITE to avoid accidentally allocating a bunch
> > of memory as part of guest shutdown, and a
> > kvm_restrictedmem_get_pfn_noalloc() variant to go along with that. But
> > maybe a boolean param is better? Or maybe SGP_NOALLOC is the better
> > default, and we just propagate an error to userspace if they didn't
> > fallocate() in advance?
> 
> This (making fallocate() a hard requirement) not only complicates the
> userspace but also forces the lazy-faulting going through a long path of
> exiting to userspace. Unless we don't have other options I would not go
> this way.

Unless I'm missing something, it's already the case that userspace is
responsible for handling all the shared->private transitions in response
to KVM_EXIT_MEMORY_FAULT or (in our case) KVM_EXIT_VMGEXIT. So it only
places the additional requirements on the VMM that if they *don't*
preallocate, then they'll need to issue the fallocate() prior to issuing
the KVM_MEM_ENCRYPT_REG_REGION ioctl in response to these events.

QEMU for example already has a separate 'prealloc' option for cases
where they want to prefault all the guest memory, so it makes sense to
continue making that an optional thing with regard to UPM.

-Mike

> 
> Chao
> > 
> > -Mike
> > 
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*pagep = page;
> > > +	if (order)
> > > +		*order = thp_order(compound_head(page));
> > > +
> > > +	SetPageUptodate(page);
> > > +	unlock_page(page);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(restrictedmem_get_page);
> > > -- 
> > > 2.25.1
> > > 
