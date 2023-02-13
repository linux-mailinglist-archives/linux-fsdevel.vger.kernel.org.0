Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF76946B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 14:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjBMNMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 08:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBMNLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:11:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F931B301;
        Mon, 13 Feb 2023 05:11:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ8cX2kfJtqKBMAMKtjbWmXIOptC6o2/UF5ttGozTxaz4EF+VidrjAevOyrzTm4eK5f+dkjz58TNIFITZa+0QBJcyINL+Y3m7dRCdOCuLV+9UDJr3uqEUTxW2V1g7FVdTxqrnpL7r1zHSOMIJWvB7sbq/CUXlXlbC+e6y64HgctzLU77D4j6CpvMZFIvrhFW3zZSY4zvl2/uv61MhJxc/i5Xo+lTxMJP7ikAPq0Be/p93Dt6r6FQaHzF/JU0xyBZCBG+13CpJxzkaLN0y3OCgeL5Vxa0+oz5dFZNDMzJf/H8/ROU6Vx1pcwH2x6GNwSDvurtkJlX/jCngwHvqTFRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oc6oSvXnNMZHBlKk5I8u5HarYwTI1zPhOKepv6OtT+A=;
 b=csSceXT5GztRYqBiZWbd+kNY4ILPvBEZV4x7LLYCqrqPl5FD/dgxAKIB208A/2xwvpuKMkKmh+5LuzvlXpRsciuz5MzNkwMXLs4PCBVD9jqXPgieka1pCtqUU4KztsNtc5BZZfTO1K24p4bbIYKbm7r1Ofm1LWV4ZAhuZdgz0LVrb0o9QoUNdcztclqLWDcIiTIOImJcNPs19tiBEbArZ80YF0j5ojErmPAbdiYb9qsVXd1bfmP1k87NQy8c4kCO8vHBghYLQOB9etFODgb+QAe3AvR3ioBA9aA0/LJOv6DDyfpA/ykxSdUOAQx8k2RSnIrE0cU9q7lPLpD7wDMDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=shutemov.name smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oc6oSvXnNMZHBlKk5I8u5HarYwTI1zPhOKepv6OtT+A=;
 b=0BdjaUZ8UuJJ1SF8wuLnkebo+EYystehXAjyFzhFl7s+jbswiMGTpIQJkiGN6Abe0Yl8VhozLMELcBh7DnfwtpklddDgNF4R7JD6ux0hbARhdRF92T+QClrEpfjBPz+Yuo658jsQ17zquTXUmLn5poU/KcLHu5k2zP2uGzHETNk=
Received: from DM6PR12CA0024.namprd12.prod.outlook.com (2603:10b6:5:1c0::37)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 13:11:36 +0000
Received: from DS1PEPF0000E639.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::14) by DM6PR12CA0024.outlook.office365.com
 (2603:10b6:5:1c0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 13:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E639.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Mon, 13 Feb 2023 13:11:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 07:11:32 -0600
Date:   Mon, 13 Feb 2023 07:10:11 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "tabba@google.com" <tabba@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20230213131011.uoabwhapj2ukdmwx@amd.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
 <20221219075313.GB1691829@chaop.bj.intel.com>
 <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
 <20221220072228.GA1724933@chaop.bj.intel.com>
 <126046ce506df070d57e6fe5ab9c92cdaf4cf9b7.camel@intel.com>
 <20221221133905.GA1766136@chaop.bj.intel.com>
 <Y6SevJt6XXOsmIBD@google.com>
 <20230123154334.mmbdpniy76zsec5m@box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230123154334.mmbdpniy76zsec5m@box>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E639:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ab4da4-9686-42d7-0ac8-08db0dc3d5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJS1LaHRlI8OV364lZ2FzIVHkRtQQsMzRwhxwPNHoHB4DoEBV7Jb4vXX1hLlP/q6pbQctKJMf2Q8Aa4bU6jD1annzuLbCJ3EHpkaTuYVVT+zumDlFS8v4SfUDnmzILGfDUmhIt00zrdwZWGuvROYuF1Y1h0+81y1G3Slpx6pCqgumQQH1+24Dy603xOaS7JFK0p/fIv2u4SvvKg3136Us1GshjN19T2FEP0KmTK6eSkjngUHmk0Ww1Dc7XezguhivR+w/nkWWrZgkVvxn/BVZvvKTkmsdMDcN1rH58DNi0XgleVXXzv0sPTYnFsGRkNfuxXe43ajKAlXxph+59eqjQtp9SppQvCAvhnm5sHMnNXKQRwGr8UYEsHM33I67QFouPUczh1kHgphqPoBlMR4tbem946wqQEeCtpiqLhusqvq5YhUimRelgaP5ds7i5mPpbj1j12y9zJDkAYJpxapo1hRtuP8FnH8K2ggsNyi/shXe2qldjP17rQnpe/Xkb7hGRC9Hed4SoJUN6T8+xgmw+KEop9C+a3XwNafPeY+ESCyNqH7c0Gze+PCcPSbdkZDeTMV1t8+sObCJyVW9y6rB3ZEaA2fc1n1c/sO9XBkVracLaeQpXBRwxEn2KLKN7rfhaHGFOLJs/qHBowrCokovKexhaQMM0jS9Lt6FSMCBYshLLox7nQ0P1nBB2LvQT1zF6RH3QtOJE2vu1NC/Hb1W0H20QTKAvxjel5WGN06lrBXywLJK9fghSD5lKNvhmbiksHNZI8u4AQysMOmToQZVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(40470700004)(36840700001)(46966006)(86362001)(40480700001)(36860700001)(82310400005)(82740400003)(81166007)(70586007)(40460700003)(36756003)(4326008)(70206006)(8676002)(41300700001)(54906003)(316002)(6916009)(356005)(7366002)(7416002)(8936002)(44832011)(2906002)(5660300002)(2616005)(7406005)(83380400001)(4001150100001)(47076005)(966005)(336012)(426003)(478600001)(1076003)(16526019)(26005)(186003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 13:11:35.6528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ab4da4-9686-42d7-0ac8-08db0dc3d5a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E639.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 06:43:34PM +0300, Kirill A. Shutemov wrote:
> On Thu, Dec 22, 2022 at 06:15:24PM +0000, Sean Christopherson wrote:
> > On Wed, Dec 21, 2022, Chao Peng wrote:
> > > On Tue, Dec 20, 2022 at 08:33:05AM +0000, Huang, Kai wrote:
> > > > On Tue, 2022-12-20 at 15:22 +0800, Chao Peng wrote:
> > > > > On Mon, Dec 19, 2022 at 08:48:10AM +0000, Huang, Kai wrote:
> > > > > > On Mon, 2022-12-19 at 15:53 +0800, Chao Peng wrote:
> > > > But for non-restricted-mem case, it is correct for KVM to decrease page's
> > > > refcount after setting up mapping in the secondary mmu, otherwise the page will
> > > > be pinned by KVM for normal VM (since KVM uses GUP to get the page).
> > > 
> > > That's true. Actually even true for restrictedmem case, most likely we
> > > will still need the kvm_release_pfn_clean() for KVM generic code. On one
> > > side, other restrictedmem users like pKVM may not require page pinning
> > > at all. On the other side, see below.
> > > 
> > > > 
> > > > So what we are expecting is: for KVM if the page comes from restricted mem, then
> > > > KVM cannot decrease the refcount, otherwise for normal page via GUP KVM should.
> > 
> > No, requiring the user (KVM) to guard against lack of support for page migration
> > in restricted mem is a terrible API.  It's totally fine for restricted mem to not
> > support page migration until there's a use case, but punting the problem to KVM
> > is not acceptable.  Restricted mem itself doesn't yet support page migration,
> > e.g. explosions would occur even if KVM wanted to allow migration since there is
> > no notification to invalidate existing mappings.
> 
> I tried to find a way to hook into migration path from restrictedmem. It
> is not easy because from code-mm PoV the restrictedmem page just yet
> another shmem page.
> 
> It is somewhat dubious, but I think it should be safe to override
> mapping->a_ops for the shmem mapping.
> 
> It also eliminates need in special treatment for the restrictedmem pages
> from memory-failure code.
> 
> shmem_mapping() uses ->a_ops to detect shmem mapping. Modify the
> implementation to still be true for restrictedmem pages.
> 
> Build tested only.
> 
> Any comments?

Hi Kirill,

We've been testing your approach to handle pinning for the SNP+UPM
implementation and haven't noticed any problems so far:

  (based on top of Sean's updated UPM v10 tree)
  https://github.com/mdroth/linux/commit/f780033e6812a01f8732060605d941474fee2bd6

Prior to your patch we also tried elevating refcount via
restrictedmem_get_page() for cases where shmem_get_folio(..., SGP_NOALLOC)
indicates the page hasn't been allocated yet, and that approach also
seems to work, but there are potential races and other ugliness that
make your approach seem a lot cleaner.

-Mike

> 
> diff --git a/include/linux/restrictedmem.h b/include/linux/restrictedmem.h
> index 6fddb08f03cc..73ded3c3bad1 100644
> --- a/include/linux/restrictedmem.h
> +++ b/include/linux/restrictedmem.h
> @@ -36,8 +36,6 @@ static inline bool file_is_restrictedmem(struct file *file)
>  	return file->f_inode->i_sb->s_magic == RESTRICTEDMEM_MAGIC;
>  }
>  
> -void restrictedmem_error_page(struct page *page, struct address_space *mapping);
> -
>  #else
>  
>  static inline bool file_is_restrictedmem(struct file *file)
> @@ -45,11 +43,6 @@ static inline bool file_is_restrictedmem(struct file *file)
>  	return false;
>  }
>  
> -static inline void restrictedmem_error_page(struct page *page,
> -					    struct address_space *mapping)
> -{
> -}
> -
>  #endif /* CONFIG_RESTRICTEDMEM */
>  
>  #endif /* _LINUX_RESTRICTEDMEM_H */
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index d500ea967dc7..a4af160f37e4 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -9,6 +9,7 @@
>  #include <linux/percpu_counter.h>
>  #include <linux/xattr.h>
>  #include <linux/fs_parser.h>
> +#include <linux/magic.h>
>  
>  /* inode in-kernel data */
>  
> @@ -75,10 +76,9 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
>  		unsigned long len, unsigned long pgoff, unsigned long flags);
>  extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
>  #ifdef CONFIG_SHMEM
> -extern const struct address_space_operations shmem_aops;
>  static inline bool shmem_mapping(struct address_space *mapping)
>  {
> -	return mapping->a_ops == &shmem_aops;
> +	return mapping->host->i_sb->s_magic == TMPFS_MAGIC;
>  }
>  #else
>  static inline bool shmem_mapping(struct address_space *mapping)
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f91b444e471e..145bb561ddb3 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -62,7 +62,6 @@
>  #include <linux/page-isolation.h>
>  #include <linux/pagewalk.h>
>  #include <linux/shmem_fs.h>
> -#include <linux/restrictedmem.h>
>  #include "swap.h"
>  #include "internal.h"
>  #include "ras/ras_event.h"
> @@ -941,8 +940,6 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>  		goto out;
>  	}
>  
> -	restrictedmem_error_page(p, mapping);
> -
>  	/*
>  	 * The shmem page is kept in page cache instead of truncating
>  	 * so is expected to have an extra refcount after error-handling.
> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> index 15c52301eeb9..d0ca609b82cb 100644
> --- a/mm/restrictedmem.c
> +++ b/mm/restrictedmem.c
> @@ -189,6 +189,51 @@ static struct file *restrictedmem_file_create(struct file *memfd)
>  	return file;
>  }
>  
> +static int restricted_error_remove_page(struct address_space *mapping,
> +					struct page *page)
> +{
> +	struct super_block *sb = restrictedmem_mnt->mnt_sb;
> +	struct inode *inode, *next;
> +	pgoff_t start, end;
> +
> +	start = page->index;
> +	end = start + thp_nr_pages(page);
> +
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> +		struct restrictedmem *rm = inode->i_mapping->private_data;
> +		struct restrictedmem_notifier *notifier;
> +		struct file *memfd = rm->memfd;
> +		unsigned long index;
> +
> +		if (memfd->f_mapping != mapping)
> +			continue;
> +
> +		xa_for_each_range(&rm->bindings, index, notifier, start, end)
> +			notifier->ops->error(notifier, start, end);
> +		break;
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_MIGRATION
> +static int restricted_folio(struct address_space *mapping, struct folio *dst,
> +			    struct folio *src, enum migrate_mode mode)
> +{
> +	return -EBUSY;
> +}
> +#endif
> +
> +static struct address_space_operations restricted_aops = {
> +	.dirty_folio	= noop_dirty_folio,
> +	.error_remove_page = restricted_error_remove_page,
> +#ifdef CONFIG_MIGRATION
> +	.migrate_folio	= restricted_folio,
> +#endif
> +};
> +
>  SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
>  {
>  	struct file *file, *restricted_file;
> @@ -209,6 +254,8 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
>  	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
>  	file->f_flags |= O_LARGEFILE;
>  
> +	file->f_mapping->a_ops = &restricted_aops;
> +
>  	restricted_file = restrictedmem_file_create(file);
>  	if (IS_ERR(restricted_file)) {
>  		err = PTR_ERR(restricted_file);
> @@ -293,31 +340,3 @@ int restrictedmem_get_page(struct file *file, pgoff_t offset,
>  }
>  EXPORT_SYMBOL_GPL(restrictedmem_get_page);
>  
> -void restrictedmem_error_page(struct page *page, struct address_space *mapping)
> -{
> -	struct super_block *sb = restrictedmem_mnt->mnt_sb;
> -	struct inode *inode, *next;
> -	pgoff_t start, end;
> -
> -	if (!shmem_mapping(mapping))
> -		return;
> -
> -	start = page->index;
> -	end = start + thp_nr_pages(page);
> -
> -	spin_lock(&sb->s_inode_list_lock);
> -	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> -		struct restrictedmem *rm = inode->i_mapping->private_data;
> -		struct restrictedmem_notifier *notifier;
> -		struct file *memfd = rm->memfd;
> -		unsigned long index;
> -
> -		if (memfd->f_mapping != mapping)
> -			continue;
> -
> -		xa_for_each_range(&rm->bindings, index, notifier, start, end)
> -			notifier->ops->error(notifier, start, end);
> -		break;
> -	}
> -	spin_unlock(&sb->s_inode_list_lock);
> -}
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c1d8b8a1aa3b..3df4d95784b9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -231,7 +231,7 @@ static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
>  }
>  
>  static const struct super_operations shmem_ops;
> -const struct address_space_operations shmem_aops;
> +static const struct address_space_operations shmem_aops;
>  static const struct file_operations shmem_file_operations;
>  static const struct inode_operations shmem_inode_operations;
>  static const struct inode_operations shmem_dir_inode_operations;
> @@ -3894,7 +3894,7 @@ static int shmem_error_remove_page(struct address_space *mapping,
>  	return 0;
>  }
>  
> -const struct address_space_operations shmem_aops = {
> +static const struct address_space_operations shmem_aops = {
>  	.writepage	= shmem_writepage,
>  	.dirty_folio	= noop_dirty_folio,
>  #ifdef CONFIG_TMPFS
> @@ -3906,7 +3906,6 @@ const struct address_space_operations shmem_aops = {
>  #endif
>  	.error_remove_page = shmem_error_remove_page,
>  };
> -EXPORT_SYMBOL(shmem_aops);
>  
>  static const struct file_operations shmem_file_operations = {
>  	.mmap		= shmem_mmap,
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
