Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6C66C5BDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 02:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCWB2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 21:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCWB2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:28:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE681B5;
        Wed, 22 Mar 2023 18:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx8Z0uObm40mi3yuk8K1nHaWFE2bo2nQI5GSk0uc7gLBY4D3afw91ZeTr73O2YUoTlib3SbvfirkMfuwrjn3zCAXunElunospOORb46L3KShcdDU1hoUdTfoA7SoH8PVYZsNak4XvmFyAvKN+HGSBQeizWRZ7C4NHUrHOnEOCppMwEJg9yxq/s6l8d6bD0znNPajX/LAj6vzlczZlJPwW8ybfXgDD9tGX9M605RACOCd7vYfbErkd8nByyH+HrNFXVZ2z4HXgLJPYNdpHzowkH+85+e55xFeOL1Gb7r6qqCgUO/VsDUd+voJ2CS+Z33H/wjHGLRGUFJS2AFuEgYiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx0LCcrl0zhtbGtyYthgXkwmDL7Ey5uollXMP76ypVQ=;
 b=ISOIssF6qWEsvwMPt/nal2OHvseWPNezvQtyMejinG5aaRCluWoImar2FvQIqAI+bXPMpMkuY0WrMNB4R1WOPON7/VNBcek6m9WZtkqTzMyi6aJFa6yBnY59ZiP4EgBWHg4HlwY8ZN90S8w6BAJgooAOJnmfzA+Hn43+45kb+gr1NlivK+1nac0x62efuTA9788tPeUtAUdOWX3mIvSifpY0t3FZfJCqxAxfRodxzZviByTiPVa6npOqMW0gWXzvzi3xCd6AeLBlFbHzIedkl4/ocI70oMGPslUEdMxrOvWeJazHBK8KlCXfuqFsclfnEQCDm3Y4AEguQwMaMT79eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx0LCcrl0zhtbGtyYthgXkwmDL7Ey5uollXMP76ypVQ=;
 b=pa8dn0jsDfbm9tpQREmymVcwoTNcI8YYC4qm+zy6vCpsBTijJ2acWva7hbfqpzyj6UTahvanAgSa2CHY3wwK37dileayrx4aA6acoMg77L5JfHC28kOy7W8faj9w6px/kdwVRHV7sUM6YmQQAQrXQplja+0/LGlE/X/iWN7FUlM=
Received: from MN2PR15CA0059.namprd15.prod.outlook.com (2603:10b6:208:237::28)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 01:27:56 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::f1) by MN2PR15CA0059.outlook.office365.com
 (2603:10b6:208:237::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 01:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 01:27:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 20:27:54 -0500
Date:   Wed, 22 Mar 2023 20:27:37 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
CC:     Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        <mhocko@suse.com>, <wei.w.wang@intel.com>
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230323012737.7vn4ynsbfz7c2ch4@amd.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <20230119111308.GC2976263@ls.amr.corp.intel.com>
 <Y8lg1G2lRIrI/hld@google.com>
 <20230119223704.GD2976263@ls.amr.corp.intel.com>
 <Y880FiYF7YCtsw/i@google.com>
 <20230213130102.two7q3kkcf254uof@amd.com>
 <20230221121135.GA1595130@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230221121135.GA1595130@chaop.bj.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 62866689-2cda-4b67-8414-08db2b3dd3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMAXdBDFqtDpIFu82ZPHqUkd4fl7aS4dBZQjtL/hw6oW3BaJcSWalbXjEJJre0jRwXcOI4cEd45XlDjpTRAmX8qhXYZPMNxe1HUUn5LIUd/9cBFCz0Anc2TR+O6K26xEpy6AT94syR4zQpvxoFzLtmMwCy97e/zAyKPX8YTr9e4H25rwOzwIjAxZqCLSXMVEDbBz/RacrPMbvcem2DvkzBuo8ETuOEOxBfY6y6eh3Lz5EiFEBoBJ6wycIxHp9b9D9xrrshnOYs+4AhzvylzKLo/zwLrC6dlONWVizJFEGGLE6vlm1X68vEgi6xxwEc/f3GUx3MoBQgfh3JsQO5Ft1EUJwb/YfZE8axCmfItrOh6gddG+qinxFRDnTHfh9TWdHa1ue5C2l7/RbEKsaEV7M3qyWEwqmcKk7hgvq9znDIUvASCcqaxUqpi2SGkqDVYYaSlzCFS9C988vxI8bXnFTDnL+i3zjncqom92OuZRI0yKv4zhC1620iEGMLDpDVGW+oPMjJdyFoYYlEoax8ikci6WaFwcgkY3anGH2IbP5BWQMLpnKTNzSXvaH1l0H4yZtsvko6h7CYqPlOyg7vVc0eRWUAGfjMXP9g4RD1PAtQzuV4myf4A2SFd9zPoAiHiuExt+HM739KerY92e5IZFRd5uOQfzz4oYyFvdq8I56vDyRjsn6DrvEYY3XuZ7FSOnS3MwjCMj313DmL8+3cNMTi9/Y3dRSk3YO2Ff+9dlVuM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(1076003)(26005)(82310400005)(336012)(6666004)(36756003)(426003)(47076005)(40460700003)(16526019)(186003)(40480700001)(316002)(81166007)(2906002)(356005)(54906003)(41300700001)(36860700001)(8936002)(8676002)(4326008)(6916009)(70586007)(70206006)(2616005)(44832011)(82740400003)(7416002)(7406005)(5660300002)(83380400001)(966005)(86362001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:27:54.7925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62866689-2cda-4b67-8414-08db2b3dd3c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:11:35PM +0800, Chao Peng wrote:
> > Hi Sean,
> > 
> > We've rebased the SEV+SNP support onto your updated UPM base support
> > tree and things seem to be working okay, but we needed some fixups on
> > top of the base support get things working, along with 1 workaround
> > for an issue that hasn't been root-caused yet:
> > 
> >   https://github.com/mdroth/linux/commits/upmv10b-host-snp-v8-wip
> > 
> >   *stash (upm_base_support): mm: restrictedmem: Kirill's pinning implementation
> >   *workaround (use_base_support): mm: restrictedmem: loosen exclusivity check
> 
> What I'm seeing is Slot#3 gets added first and then deleted. When it's
> gets added, Slot#0 already has the same range bound to restrictedmem so
> trigger the exclusive check. This check is exactly the current code for.

With the following change in QEMU, we no longer trigger this check:

  diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
  index 20da121374..849b5de469 100644
  --- a/hw/pci-host/q35.c
  +++ b/hw/pci-host/q35.c
  @@ -588,9 +588,9 @@ static void mch_realize(PCIDevice *d, Error **errp)
       memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
                                mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
                                MCH_HOST_BRIDGE_SMRAM_C_SIZE);
  +    memory_region_set_enabled(&mch->open_high_smram, false);
       memory_region_add_subregion_overlap(mch->system_memory, 0xfeda0000,
                                           &mch->open_high_smram, 1);
  -    memory_region_set_enabled(&mch->open_high_smram, false);

I'm not sure if QEMU is actually doing something wrong here though or if
this check is putting tighter restrictions on userspace than what was
expected before. Will look into it more.

> 
> >   *fixup (upm_base_support): KVM: use inclusive ranges for restrictedmem binding/unbinding
> >   *fixup (upm_base_support): mm: restrictedmem: use inclusive ranges for issuing invalidations
> 
> As many kernel APIs treat 'end' as exclusive, I would rather keep using
> exclusive 'end' for these APIs(restrictedmem_bind/restrictedmem_unbind
> and notifier callbacks) but fix it internally in the restrictedmem. E.g.
> all the places where xarray API needs a 'last'/'max' we use 'end - 1'.
> See below for the change.

Yes I did feel like I was fighting the kernel a bit on that; your
suggestion seems like it would be a better fit.

> 
> >   *fixup (upm_base_support): KVM: fix restrictedmem GFN range calculations
> 
> Subtracting slot->restrictedmem.index for start/end in
> restrictedmem_get_gfn_range() is the correct fix.
> 
> >   *fixup (upm_base_support): KVM: selftests: CoCo compilation fixes
> > 
> > We plan to post an updated RFC for v8 soon, but also wanted to share
> > the staging tree in case you end up looking at the UPM integration aspects
> > before then.
> > 
> > -Mike
> 
> This is the restrictedmem fix to solve 'end' being stored and checked in xarray:

Looks good.

Thanks!

-Mike

> 
> --- a/mm/restrictedmem.c
> +++ b/mm/restrictedmem.c
> @@ -46,12 +46,12 @@ static long restrictedmem_punch_hole(struct restrictedmem *rm, int mode,
>          */
>         down_read(&rm->lock);
>  
> -       xa_for_each_range(&rm->bindings, index, notifier, start, end)
> +       xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
>                 notifier->ops->invalidate_start(notifier, start, end);
>  
>         ret = memfd->f_op->fallocate(memfd, mode, offset, len);
>  
> -       xa_for_each_range(&rm->bindings, index, notifier, start, end)
> +       xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
>                 notifier->ops->invalidate_end(notifier, start, end);
>  
>         up_read(&rm->lock);
> @@ -224,7 +224,7 @@ static int restricted_error_remove_page(struct address_space *mapping,
>                 }
>                 spin_unlock(&inode->i_lock);
>  
> -               xa_for_each_range(&rm->bindings, index, notifier, start, end)
> +               xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
>                         notifier->ops->error(notifier, start, end);
>                 break;
>         }
> @@ -301,11 +301,12 @@ int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
>                 if (exclusive != rm->exclusive)
>                         goto out_unlock;
>  
> -               if (exclusive && xa_find(&rm->bindings, &start, end, XA_PRESENT))
> +               if (exclusive &&
> +                   xa_find(&rm->bindings, &start, end - 1, XA_PRESENT))
>                         goto out_unlock;
>         }
>  
> -       xa_store_range(&rm->bindings, start, end, notifier, GFP_KERNEL);
> +       xa_store_range(&rm->bindings, start, end - 1, notifier, GFP_KERNEL);
>         rm->exclusive = exclusive;
>         ret = 0;
>  out_unlock:
> @@ -320,7 +321,7 @@ void restrictedmem_unbind(struct file *file, pgoff_t start, pgoff_t end,
>         struct restrictedmem *rm = file->f_mapping->private_data;
>  
>         down_write(&rm->lock);
> -       xa_store_range(&rm->bindings, start, end, NULL, GFP_KERNEL);
> +       xa_store_range(&rm->bindings, start, end - 1, NULL, GFP_KERNEL);
>         synchronize_rcu();
>         up_write(&rm->lock);
>  }
