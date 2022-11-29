Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB8D63B660
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 01:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiK2AIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 19:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiK2AHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 19:07:08 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7423E0AA;
        Mon, 28 Nov 2022 16:06:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of0tBZqTlkAHR+gG7Fl7SbGxypLfbXGayQAK9p1tPwASOXXEQOE1A7BSex+XwxgAIQ8G2NaDS/0votsEuODEN/cdJ+12Zb6iXlCVxjn+Wx1VSENyErEW5MunFehFsWRv8Bl08d6YpairZSc9mAvk4Nd9W4zEgL6XpYVdYEH2yevCC9AzskWBort/23aXsxyy3iR2pdOx+q8Xy7VRZnSyrvzz6j5yF2CThhnCvFEyKz5N8jIm0ZIIp380yn9Ea7GVb2kHtygkkbPCWP9TqGP+RSByaMOvhDtf8y04IGA2J4Rna7aa9e8GFRKw1KrG0aERUxlM4VfxK4GfaVKjGK0Aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNd89Q66h7ZOO8SF9fKSc9FtR0XbLbDRMcdyQAyUqxg=;
 b=e3J7napzQwqI/6NApMbKw2kuqk60cizO2HOFNdRy87EYDzmCe8xmWjbxXSqxgPbo5owZajPGLW02Ga4rJ4ZAL0+awIq8QzdyXMhnqCddXgP8U5Y47aevItSUtD/YxUk7NT/v5CqPTDiqgB82qkTk5lyeHOgmkdk9ESMIMOgSJm8lhwoKDd3y88HZ9j7MnXHU47OpHyilQLYYYheI7hF25h9lhe6t/A1EOcTG8HkK6yeTokLP20OBiMQR2aE30+rVlPiZezdfO7HdpmBBg6j5lGrTSnq0buCRxF1CtjDx/GTmsYs1vOL/eZGp5GCOoygmmHDMlGE08e6ZfeROV6SQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNd89Q66h7ZOO8SF9fKSc9FtR0XbLbDRMcdyQAyUqxg=;
 b=DbEIxiHPNuaHOZMboF7nOAOPwKoAmeMf08J4JJ8yK698ycUgCbEXDpT3gXcQf3ZdPQ83YfpgpfM5qQr4fhd9QGDwSKR2f8POETPCQMx3ahmIUUtXpsuQ3zcpQ1SL4muoJnGF9PfI3yM1oxqdAO1y+kwHy6U/r0faX/O4iZ8Q/b4=
Received: from MW4PR03CA0233.namprd03.prod.outlook.com (2603:10b6:303:b9::28)
 by DM6PR12MB4864.namprd12.prod.outlook.com (2603:10b6:5:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 00:06:50 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::2) by MW4PR03CA0233.outlook.office365.com
 (2603:10b6:303:b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 00:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Tue, 29 Nov 2022 00:06:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 28 Nov
 2022 18:06:48 -0600
Date:   Mon, 28 Nov 2022 18:06:32 -0600
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
Message-ID: <20221129000632.sz6pobh6p7teouiu@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|DM6PR12MB4864:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a79ab7-be20-437b-bf06-08dad19d9d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWZ/FK29m3a28AbYyuD8LMLpmWEx1JfoGtOQH2q9xHDYLZfLjXifX+Ap6ygllqG8O6n0BVf3QIcoieUJenqRstuU0J0ov/BbWLioNRgZZ7PDllYKdBBlArTHkTygHHnFyp9H+0F+yb3YXc9r5m+ctw4N7WunUDlHqLewf4PPzlZ3wQR8POL0UWxilnTQvuHAA9L9DQc2yozfSktSzRR1YbKXnFTu3Hx3ojFq6EtKaXYiYe7B1e0yeC6909vdZpNJxUfTAg4vymyAYtZAUZWjEREmQmKAlZAeNSIE8xgwMroAu865IF92z8aFzXCH2nccDDGa53QWHTLQu/SHDIMvqomLwnRz6bHuRC0kullNx18dOlaoifyk6RoWnUVExoKM+R2wqvfhwXlHrER0ctFEDNIWW+iF11/mcOpt3fS5sMm4FW53jYZqx2JMJ9AJ4lhpnMCtQoH3S1zUUByYMgqE6kepu9Ap26spMgGM96N9olt7uj2RJHy87RBTojqwNPhLQVp69FR3YULfKz8onz/T5CeJXw8lWUBs/BxYyaWA7tASNK1jnUq58TXBxenMsnz6rDP4qs+QZSxXV51bytOPXtzEKDRWJnvMPk66qSJvshoVAP8UmXAn1mIJ4ndtM/IyzKnVrfacZdVdDe45LPqDPfGiDNiAy4kYFPT06mb6TICv5yae6rpys0uZ3yM7XfpyMuLfgM+960aYuQPScL3t2+TVoWcRdVDHw9eptHxTVIg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(356005)(40480700001)(81166007)(36756003)(2906002)(40460700003)(86362001)(7406005)(7416002)(6666004)(478600001)(44832011)(70586007)(316002)(70206006)(41300700001)(45080400002)(5660300002)(36860700001)(4326008)(8676002)(54906003)(26005)(8936002)(6916009)(82740400003)(1076003)(336012)(16526019)(83380400001)(186003)(2616005)(82310400005)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 00:06:50.4325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a79ab7-be20-437b-bf06-08dad19d9d50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4864
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>=20

<snip>

> +static struct file *restrictedmem_file_create(struct file *memfd)
> +{
> +	struct restrictedmem_data *data;
> +	struct address_space *mapping;
> +	struct inode *inode;
> +	struct file *file;
> +
> +	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	data->memfd =3D memfd;
> +	mutex_init(&data->lock);
> +	INIT_LIST_HEAD(&data->notifiers);
> +
> +	inode =3D alloc_anon_inode(restrictedmem_mnt->mnt_sb);
> +	if (IS_ERR(inode)) {
> +		kfree(data);
> +		return ERR_CAST(inode);
> +	}
> +
> +	inode->i_mode |=3D S_IFREG;
> +	inode->i_op =3D &restrictedmem_iops;
> +	inode->i_mapping->private_data =3D data;
> +
> +	file =3D alloc_file_pseudo(inode, restrictedmem_mnt,
> +				 "restrictedmem", O_RDWR,
> +				 &restrictedmem_fops);
> +	if (IS_ERR(file)) {
> +		iput(inode);
> +		kfree(data);
> +		return ERR_CAST(file);
> +	}
> +
> +	file->f_flags |=3D O_LARGEFILE;
> +
> +	mapping =3D memfd->f_mapping;
> +	mapping_set_unevictable(mapping);
> +	mapping_set_gfp_mask(mapping,
> +			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);

Is this supposed to prevent migration of pages being used for
restrictedmem/shmem backend?

In my case I've been testing SNP support based on UPM v9, and for
large guests (128GB+), if I force 2M THPs via:

  echo always >/sys/kernel/mm/transparent_hugepages/shmem_enabled

it will in some cases trigger the below trace, which suggests that
kcompactd is trying to call migrate_folio() on a PFN that was/is
still allocated for guest private memory (and so has been removed from
directmap as part of shared->private conversation via REG_REGION kvm
ioctl, leading to the crash). This trace seems to occur during early
OVMF boot while the guest is in the middle of pre-accepting on private
memory (no lazy accept in this case).

Is this expected behavior? What else needs to be done to ensure
migrations aren't attempted in this case?

Thanks!

-Mike


# Host logs with debug info for crash during SNP boot

=2E..
[  904.373632] kvm_restricted_mem_get_pfn: GFN: 0x1caced1, PFN: 0x156b7f, p=
age: ffffea0006b197b0, ref_count: 2
[  904.373634] kvm_restricted_mem_get_pfn: GFN: 0x1caced2, PFN: 0x156840, p=
age: ffffea0006b09400, ref_count: 2
[  904.373637] kvm_restricted_mem_get_pfn: GFN: 0x1caced3, PFN: 0x156841, p=
age: ffffea0006b09450, ref_count: 2
[  904.373639] kvm_restricted_mem_get_pfn: GFN: 0x1caced4, PFN: 0x156842, p=
age: ffffea0006b094a0, ref_count: 2
[  904.373641] kvm_restricted_mem_get_pfn: GFN: 0x1caced5, PFN: 0x156843, p=
age: ffffea0006b094f0, ref_count: 2
[  904.373645] kvm_restricted_mem_get_pfn: GFN: 0x1caced6, PFN: 0x156844, p=
age: ffffea0006b09540, ref_count: 2
[  904.373647] kvm_restricted_mem_get_pfn: GFN: 0x1caced7, PFN: 0x156845, p=
age: ffffea0006b09590, ref_count: 2
[  904.373649] kvm_restricted_mem_get_pfn: GFN: 0x1caced8, PFN: 0x156846, p=
age: ffffea0006b095e0, ref_count: 2
[  904.373652] kvm_restricted_mem_get_pfn: GFN: 0x1caced9, PFN: 0x156847, p=
age: ffffea0006b09630, ref_count: 2
[  904.373654] kvm_restricted_mem_get_pfn: GFN: 0x1caceda, PFN: 0x156848, p=
age: ffffea0006b09680, ref_count: 2
[  904.373656] kvm_restricted_mem_get_pfn: GFN: 0x1cacedb, PFN: 0x156849, p=
age: ffffea0006b096d0, ref_count: 2
[  904.373661] kvm_restricted_mem_get_pfn: GFN: 0x1cacedc, PFN: 0x15684a, p=
age: ffffea0006b09720, ref_count: 2
[  904.373663] kvm_restricted_mem_get_pfn: GFN: 0x1cacedd, PFN: 0x15684b, p=
age: ffffea0006b09770, ref_count: 2

# PFN 0x15684c is allocated for guest private memory, will have been remove=
d from directmap as part of RMP requirements

[  904.373665] kvm_restricted_mem_get_pfn: GFN: 0x1cacede, PFN: 0x15684c, p=
age: ffffea0006b097c0, ref_count: 2
=2E..

# kcompactd crashes trying to copy PFN 0x15684c to a new folio, crashes try=
ing to access PFN via directmap

[  904.470135] Migrating restricted page, SRC pfn: 0x15684c, folio_ref_coun=
t: 2, folio_order: 0
[  904.470154] BUG: unable to handle page fault for address: ffff88815684c0=
00
[  904.470314] kvm_restricted_mem_get_pfn: GFN: 0x1cafe00, PFN: 0x19f6d0, p=
age: ffffea00081d2100, ref_count: 2
[  904.477828] #PF: supervisor read access in kernel mode
[  904.477831] #PF: error_code(0x0000) - not-present page
[  904.477833] PGD 6601067 P4D 6601067 PUD 1569ad063 PMD 1569af063 PTE 800f=
fffea97b3060
[  904.508806] Oops: 0000 [#1] SMP NOPTI
[  904.512892] CPU: 52 PID: 1563 Comm: kcompactd0 Tainted: G            E  =
    6.0.0-rc7-hsnp-v7pfdv9d+ #10
[  904.523473] Hardware name: AMD Corporation ETHANOL_X/ETHANOL_X, BIOS RXM=
1006B 08/20/2021
[  904.532499] RIP: 0010:copy_page+0x7/0x10
[  904.536877] Code: 00 66 90 48 89 f8 48 89 d1 f3 a4 31 c0 c3 cc cc cc cc =
48 89 c8 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc 66 90 b9 00 02 00 00 <f3=
> 48 a5 c3 cc cc cc cc 90 48 83 ec 10 48 89 1c 24 4c 89 64 24 08
[  904.557831] RSP: 0018:ffffc900106dfb78 EFLAGS: 00010286
[  904.563661] RAX: ffff888000000000 RBX: ffffea0006b09810 RCX: 00000000000=
00200
[  904.571622] RDX: ffffea0000000000 RSI: ffff88815684c000 RDI: ffff88816bc=
5d000
[  904.579581] RBP: ffffc900106dfba0 R08: 0000000000000001 R09: ffffea0006b=
097c0
[  904.587541] R10: 0000000000000002 R11: ffffc900106dfb38 R12: ffffea00071=
add60
[  904.595502] R13: cccccccccccccccd R14: ffffea0006b09810 R15: ffff888159c=
1e0f8
[  904.603462] FS:  0000000000000000(0000) GS:ffff88a04df00000(0000) knlGS:=
0000000000000000
[  904.612489] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  904.618897] CR2: ffff88815684c000 CR3: 00000020eae16002 CR4: 00000000007=
70ee0
[  904.626855] PKRU: 55555554
[  904.629870] Call Trace:
[  904.632594]  <TASK>
[  904.634928]  ? folio_copy+0x8c/0xe0
[  904.638818]  migrate_folio+0x5b/0x110
[  904.642901]  move_to_new_folio+0x5b/0x150
[  904.647371]  migrate_pages+0x11bb/0x1830
[  904.651743]  ? move_freelist_tail+0xc0/0xc0
[  904.656406]  ? isolate_freepages_block+0x470/0x470
[  904.661749]  compact_zone+0x681/0xda0
[  904.665832]  kcompactd_do_work+0x1b3/0x2c0
[  904.670400]  kcompactd+0x257/0x330
[  904.674190]  ? prepare_to_wait_event+0x120/0x120
[  904.679338]  ? kcompactd_do_work+0x2c0/0x2c0
[  904.684098]  kthread+0xcf/0xf0
[  904.687501]  ? kthread_complete_and_exit+0x20/0x20
[  904.692844]  ret_from_fork+0x22/0x30
[  904.696830]  </TASK>
[  904.699262] Modules linked in: nf_conntrack_netlink(E) xfrm_user(E) xfrm=
_algo(E) xt_addrtype(E) br_netfilter(E) xt_CHECKSUM(E) xt_MASQUERADE(E) xt_=
conntrack(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_tcpudp(E) ip6table_mangle(E=
) ip6table_nat(E) iptable_mangle(E) iptable_nat(E) nf_nat(E) nf_conntrack(E=
) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E) nfnetlink(E) ip6table_fi=
lter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel=
_rapl_common(E) amd64_edac(E) bridge(E) stp(E) llc(E) kvm_amd(E) overlay(E)=
 nls_iso8859_1(E) kvm(E) crct10dif_pclmul(E) ghash_clmulni_intel(E) aesni_i=
ntel(E) crypto_simd(E) cryptd(E) rapl(E) ipmi_si(E) ipmi_devintf(E) wmi_bmo=
f(E) ipmi_msghandler(E) efi_pstore(E) binfmt_misc(E) ast(E) drm_vram_helper=
(E) joydev(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) input_leds(E) i2c_=
algo_bit(E) fb_sys_fops(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ccp(E=
) k10temp(E) mac_hid(E) sch_fq_codel(E) parport_pc(E) ppdev(E) lp(E) parpor=
t(E) drm(E) ip_tables(E)
[  904.699316]  x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) zstd_com=
press(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq=
(E) async_xor(E) async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) raid1(E) raid0=
(E) multipath(E) linear(E) crc32_pclmul(E) hid_generic(E) usbhid(E) hid(E) =
e1000e(E) i2c_piix4(E) wmi(E)
[  904.828498] CR2: ffff88815684c000
[  904.832193] ---[ end trace 0000000000000000 ]---
[  904.937159] RIP: 0010:copy_page+0x7/0x10
[  904.941524] Code: 00 66 90 48 89 f8 48 89 d1 f3 a4 31 c0 c3 cc cc cc cc =
48 89 c8 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc 66 90 b9 00 02 00 00 <f3=
> 48 a5 c3 cc cc cc cc 90 48 83 ec 10 48 89 1c 24 4c 89 64 24 08
[  904.962478] RSP: 0018:ffffc900106dfb78 EFLAGS: 00010286
[  904.968305] RAX: ffff888000000000 RBX: ffffea0006b09810 RCX: 00000000000=
00200
[  904.976265] RDX: ffffea0000000000 RSI: ffff88815684c000 RDI: ffff88816bc=
5d000
[  904.984227] RBP: ffffc900106dfba0 R08: 0000000000000001 R09: ffffea0006b=
097c0
[  904.992187] R10: 0000000000000002 R11: ffffc900106dfb38 R12: ffffea00071=
add60
[  905.000145] R13: cccccccccccccccd R14: ffffea0006b09810 R15: ffff888159c=
1e0f8
[  905.008105] FS:  0000000000000000(0000) GS:ffff88a04df00000(0000) knlGS:=
0000000000000000
[  905.017132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  905.023540] CR2: ffff88815684c000 CR3: 00000020eae16002 CR4: 00000000007=
70ee0
[  905.031501] PKRU: 55555554
[  905.034558] kvm_restricted_mem_get_pfn: GFN: 0x1cafe01, PFN: 0x19f6d1, p=
age: ffffea00081d2150, ref_count: 2
[  905.045455] kvm_restricted_mem_get_pfn: GFN: 0x1cafe02, PFN: 0x19f6d2, p=
age: ffffea00081d21a0, ref_count: 2
=2E..
