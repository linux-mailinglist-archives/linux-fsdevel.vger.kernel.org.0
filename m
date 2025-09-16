Return-Path: <linux-fsdevel+bounces-61834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD1DB7DCB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8401C0698F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 22:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8311C32E2C5;
	Tue, 16 Sep 2025 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dO05iMKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FEE32B482;
	Tue, 16 Sep 2025 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061741; cv=fail; b=A6mEolzVkIZkCrcBruD1zMdaGF6RfgXa6xCAG/V06TI7tj1LhvjMI1WACU6xjGVnVTwe/T03/Ese3pHrMHeK5Q0EbNmr7/cjKOYvFJtvul50DWewDzzodumAlyC46MPcmZ7KM4MHgZheP+1YT4oiNVPBBADKcQturITiktnTZec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061741; c=relaxed/simple;
	bh=qTCh42ngBeCZzyvlTNlHxY0dKX0rnYI3vO2J2JardWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/1sRG4Bw/w9tCfllpHhbJvkl4VEjZFyECviAjgxgBzmA5pF/KWcinkUtT+xB5qZHs+nEKy/WfDCplDhfgRH93HYmnGRbPLeDchR+hp15Anm7c7u24C4EKr0PXFfVRRen2fb6kvIq1np+T4PxHBd92RyS9JPXhww7wfwUYYPXh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dO05iMKn; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhJZWOAkvsKT5wpsuoFI7lEsbm4K7WKZzCX/8v2foQWY0kjMa++np8y3PVIWFdygrY+l8dISDKFJHs8PyF0Tb0FDL3AZKYniXnKy5WRewM+rfPdb7ASYeFpnp6rG35qlQF/c3LggQaI6iqp9p79a+sNLc56J1hChLaaIydzEok3RsdKRlHf2yXQj2aIwMTRwiVSmD6oziZlBrAkPbtt6gp6f3FKs9QdQJ7Lmx1lPiGXakqor7d98e90X3m4ab6ho+vGGAk1pHHz3x0qJ1QtN/N+tggjo9iE3xxszlnAPjkIL2AIQts36MeE1NiutegcVgLnpqPbwtGgEORVb6i5DKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRvJqB1cYjNMQq+zrXuIgQhoZgiwGntkhPflEykCBbE=;
 b=tYB8r9hmyNejQMCv0vy/gqzP3uXAN8EvqDvrOS2RVDAbUy0TJfP4k70YTMCBmjyVFZs1DMtZ6txA2q22lwE2y0pMnGTxsDoS7nmo53ZRX8E8x8izOJ975ilXqIt5Uet6SeE55a03AutQIGB1EEuYkpZqMYML6FmWrFjAz7keRSeoNYjYEZnyHjILsTWfJyEEUBpUPqyzZZE/to1pIp2ek8NcgVd+MUxanftdaOPNCw2xCVu5VG72xGh2fsDbyDix26uEbgE67/tnj///0CokM9PFo4YuFje71/cz7werkppNnLS3eAuSAnKxhlQJxlj6sA7WNh3TkYYan9/d6K939g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRvJqB1cYjNMQq+zrXuIgQhoZgiwGntkhPflEykCBbE=;
 b=dO05iMKn0mE+BBJrxmKKSKvF9qrlIdnbfuaF9tJkIpjI1p7SOxiGMbbFTRGLkwLzt4q7ZcdcoT8PVaqdQ5zy5MVX57IHLGubzA2ATN8DEj+8vsn6uTjhSZGOzRm7vHFJm8WKwEmP87IWiz6fvBvDVGrarNy7AB11WF/2BxW9LMk=
Received: from DS7PR05CA0014.namprd05.prod.outlook.com (2603:10b6:5:3b9::19)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 22:28:51 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::9a) by DS7PR05CA0014.outlook.office365.com
 (2603:10b6:5:3b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 22:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 22:28:50 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 15:28:50 -0700
Date: Tue, 16 Sep 2025 17:28:01 -0500
From: Michael Roth <michael.roth@amd.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <aik@amd.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dmatlack@google.com>,
	<dwmw@amazon.co.uk>, <erdemaktas@google.com>, <fan.du@intel.com>,
	<fvdl@google.com>, <graf@amazon.com>, <haibo1.xu@intel.com>,
	<hch@infradead.org>, <hughd@google.com>, <ira.weiny@intel.com>,
	<isaku.yamahata@intel.com>, <jack@suse.cz>, <james.morse@arm.com>,
	<jarkko@kernel.org>, <jgg@ziepe.ca>, <jgowans@amazon.com>,
	<jhubbard@nvidia.com>, <jroedel@suse.de>, <jthoughton@google.com>,
	<jun.miao@intel.com>, <kai.huang@intel.com>, <keirf@google.com>,
	<kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
	<liam.merwick@oracle.com>, <maciej.wieczor-retman@intel.com>,
	<mail@maciej.szmigiero.name>, <maz@kernel.org>, <mic@digikod.net>,
	<mpe@ellerman.id.au>, <muchun.song@linux.dev>, <nikunj@amd.com>,
	<nsaenz@amazon.es>, <oliver.upton@linux.dev>, <palmer@dabbelt.com>,
	<pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>, <pbonzini@redhat.com>,
	<pdurrant@amazon.co.uk>, <peterx@redhat.com>, <pgonda@google.com>,
	<pvorel@suse.cz>, <qperret@google.com>, <quic_cvanscha@quicinc.com>,
	<quic_eberman@quicinc.com>, <quic_mnalajal@quicinc.com>,
	<quic_pderrin@quicinc.com>, <quic_pheragu@quicinc.com>,
	<quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
	<richard.weiyang@gmail.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <roypat@amazon.co.uk>, <rppt@kernel.org>,
	<seanjc@google.com>, <shuah@kernel.org>, <steven.price@arm.com>,
	<steven.sistare@oracle.com>, <suzuki.poulose@arm.com>, <tabba@google.com>,
	<thomas.lendacky@amd.com>, <usama.arif@bytedance.com>,
	<vannapurve@google.com>, <vbabka@suse.cz>, <viro@zeniv.linux.org.uk>,
	<vkuznets@redhat.com>, <wei.w.wang@intel.com>, <will@kernel.org>,
	<willy@infradead.org>, <xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>,
	<yilun.xu@intel.com>, <yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 35/51] mm: guestmem_hugetlb: Add support for
 splitting and merging pages
Message-ID: <20250916222801.dlew6mq7kog2q5ni@amd.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <2ae41e0d80339da2b57011622ac2288fed65cd01.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ae41e0d80339da2b57011622ac2288fed65cd01.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: f5420751-3700-49e2-3634-08ddf570694b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qlOpVWPqD3Xy81rnCePzadVbU5FaOEsYEEYnDWxQAM8U1TBT/8cqVHiftwo3?=
 =?us-ascii?Q?AikbNWAmzRZVcgIeBJ+KJ4xgf3ITSHdFd4NCbD206aJPoDQAq6UfpG/ouo6z?=
 =?us-ascii?Q?5sl925dCBBJ/GpZvaDUbdjeACOXhdZORa5+gDktl+6NeNODyrjbDQ+NxW1mc?=
 =?us-ascii?Q?LUhw+3bIz0nOypIIb/RmCJ51hEN7QQmpgXcG+2SQa5+NVpR4fgFAVLhqfxwd?=
 =?us-ascii?Q?PVZZP7Ny+P4IBBO2GbctTZXJVp8/gtae7zOKs0+6rBFkEpO0hAkVC6QjBOTN?=
 =?us-ascii?Q?ZDft8Hd/mwRFxQrFccy03T5KhCzcxNER+eVf0QUbYzmySINK4S+P3qvkqxaA?=
 =?us-ascii?Q?tR5hpW/BBRBq4iExnSTGE1rrB6/5jpzyV8PCLaeDjh0yAaDpke8w9dYNY3lx?=
 =?us-ascii?Q?RU+nrvi8JPyUM8MO1w3T5iUDbqPMmQvHvlLYAHZCJduZdQ9IDbAEsZzxRuAH?=
 =?us-ascii?Q?wG5BZJl4caaaHuS1EHmNvHMxfujeDGF1mfBNlEodcO9j3emlX/afXkw7/tli?=
 =?us-ascii?Q?amgw6vyX2VScPC2II5fMh91gDb8O9N7O0M5ZwndOs9EMju8OXC9e7GpoIfrX?=
 =?us-ascii?Q?4xOyjyZ5SUe69R+f4xX3hV+tV7T1x8GlrvmsxP2Uj3YalMofANEwuAuyFY3A?=
 =?us-ascii?Q?LX9/o18J9icOFwgH/sCEtuN7fKvDRs/fTy7ciPG8BPn306hi/WcAuyD2gnAB?=
 =?us-ascii?Q?H/HihwX+17Ezp5l3lJPr/b4cp1E42Aj5w4aJdT/tdftWTnnzdOZ2ywNA0bS0?=
 =?us-ascii?Q?z2Zmk9IxjWXLLx5172Xgph4GOybj7mHCCpd+phA8uo+EgkDyjhLaqmDVjeSb?=
 =?us-ascii?Q?MqbSgnGLWEme6zkPnOt6KToNHf+OGhyhaafB1uX/kN3W7tvc7JKHp3iSX6ml?=
 =?us-ascii?Q?gqGRrhDrMSfQfanAltT/LLsVAe35/FsKYVt6kZtD+2xaw5EAe0Y94VmWZvzX?=
 =?us-ascii?Q?4oWoVhR/gr1eUX9FqY5HwmgCVXvMxJ+oDDArUqFGJ227j96pgutJbDM5q+t4?=
 =?us-ascii?Q?kphCfbAX40O8DwOtWnPd85yo7gErf7hT/RjDdOpPpHHBk9xT1KVJHx0DDGI9?=
 =?us-ascii?Q?+XrCirBEtYI9oVfrG08qQjnLYtPtxzPhkSQLMJJawgAmdNOa7e2hr9khk71i?=
 =?us-ascii?Q?DJJKMyFH8Arcjehw8e1YHFuJeWugxpCwCitUStt8qpb+5MxF6gjwvbfgbknV?=
 =?us-ascii?Q?ek0q4jiOmWaNrkXJzxj96UindF+WoO+GRhltOTL7ZMMi+e27wglOut3bBRQa?=
 =?us-ascii?Q?jtU091ZqtBbRSk3YJdENHwqXzFhUeFDofBU798QxIlIPP9EFGiqC2QBuvsXP?=
 =?us-ascii?Q?V8yyJp0TzYRaisXlA+NthqsUxJIgrjRzJmQzSzZYDoZbtAgGni5UXP7ggtFB?=
 =?us-ascii?Q?YNsxP8zVvs/PcGo4WUaUhn5E2z0mol9QC57AKoEBAJKQB9Pk2EEMPfArTYrJ?=
 =?us-ascii?Q?vdntjkG08aLW7NF6uXm/+1TBTKX7iBG6VjD7POhwZyJo9nuDQhXffSweFV8j?=
 =?us-ascii?Q?Q60RFK10k6V3FKjaa5Dwa4UkJEnAU/C5asqW92SCdX0Ez47Z2bhAYy8snw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 22:28:50.7362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5420751-3700-49e2-3634-08ddf570694b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

On Wed, May 14, 2025 at 04:42:14PM -0700, Ackerley Tng wrote:
> These functions allow guest_memfd to split and merge HugeTLB pages,
> and clean them up on freeing the page.
> 
> For merging and splitting pages on conversion, guestmem_hugetlb
> expects the refcount on the pages to already be 0. The caller must
> ensure that.
> 
> For conversions, guest_memfd ensures that the refcounts are already 0
> by checking that there are no unexpected refcounts, and then freezing
> the expected refcounts away. On unexpected refcounts, guest_memfd will
> return an error to userspace.
> 
> For truncation, on unexpected refcounts, guest_memfd will return an
> error to userspace.
> 
> For truncation on closing, guest_memfd will just remove its own
> refcounts (the filemap refcounts) and mark split pages with
> PGTY_guestmem_hugetlb.
> 
> The presence of PGTY_guestmem_hugetlb will trigger the folio_put()
> callback to handle further cleanup. This cleanup process will merge
> pages (with refcount 0, since cleanup is triggered from folio_put())
> before returning the pages to HugeTLB.
> 
> Since the merging process is long, it is deferred to a worker thread
> since folio_put() could be called from atomic context.
> 
> Change-Id: Ib04a3236f1e7250fd9af827630c334d40fb09d40
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  include/linux/guestmem.h |   3 +
>  mm/guestmem_hugetlb.c    | 349 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 347 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/guestmem.h b/include/linux/guestmem.h
> index 4b2d820274d9..3ee816d1dd34 100644
> --- a/include/linux/guestmem.h
> +++ b/include/linux/guestmem.h
> @@ -8,6 +8,9 @@ struct guestmem_allocator_operations {
>  	void *(*inode_setup)(size_t size, u64 flags);
>  	void (*inode_teardown)(void *private, size_t inode_size);
>  	struct folio *(*alloc_folio)(void *private);
> +	int (*split_folio)(struct folio *folio);
> +	void (*merge_folio)(struct folio *folio);
> +	void (*free_folio)(struct folio *folio);
>  	/*
>  	 * Returns the number of PAGE_SIZE pages in a page that this guestmem
>  	 * allocator provides.
> diff --git a/mm/guestmem_hugetlb.c b/mm/guestmem_hugetlb.c
> index ec5a188ca2a7..8727598cf18e 100644
> --- a/mm/guestmem_hugetlb.c
> +++ b/mm/guestmem_hugetlb.c
> @@ -11,15 +11,12 @@
>  #include <linux/mm.h>
>  #include <linux/mm_types.h>
>  #include <linux/pagemap.h>
> +#include <linux/xarray.h>
>  
>  #include <uapi/linux/guestmem.h>
>  
>  #include "guestmem_hugetlb.h"
> -
> -void guestmem_hugetlb_handle_folio_put(struct folio *folio)
> -{
> -	WARN_ONCE(1, "A placeholder that shouldn't trigger. Work in progress.");
> -}
> +#include "hugetlb_vmemmap.h"
>  
>  struct guestmem_hugetlb_private {
>  	struct hstate *h;
> @@ -34,6 +31,339 @@ static size_t guestmem_hugetlb_nr_pages_in_folio(void *priv)
>  	return pages_per_huge_page(private->h);
>  }
>  
> +static DEFINE_XARRAY(guestmem_hugetlb_stash);
> +
> +struct guestmem_hugetlb_metadata {
> +	void *_hugetlb_subpool;
> +	void *_hugetlb_cgroup;
> +	void *_hugetlb_hwpoison;
> +	void *private;
> +};
> +
> +struct guestmem_hugetlb_stash_item {
> +	struct guestmem_hugetlb_metadata hugetlb_metadata;
> +	/* hstate tracks the original size of this folio. */
> +	struct hstate *h;
> +	/* Count of split pages, individually freed, waiting to be merged. */
> +	atomic_t nr_pages_waiting_to_be_merged;
> +};
> +
> +struct workqueue_struct *guestmem_hugetlb_wq __ro_after_init;
> +static struct work_struct guestmem_hugetlb_cleanup_work;
> +static LLIST_HEAD(guestmem_hugetlb_cleanup_list);
> +
> +static inline void guestmem_hugetlb_register_folio_put_callback(struct folio *folio)
> +{
> +	__folio_set_guestmem_hugetlb(folio);
> +}
> +
> +static inline void guestmem_hugetlb_unregister_folio_put_callback(struct folio *folio)
> +{
> +	__folio_clear_guestmem_hugetlb(folio);
> +}
> +
> +static inline void guestmem_hugetlb_defer_cleanup(struct folio *folio)
> +{
> +	struct llist_node *node;
> +
> +	/*
> +	 * Reuse the folio->mapping pointer as a struct llist_node, since
> +	 * folio->mapping is NULL at this point.
> +	 */
> +	BUILD_BUG_ON(sizeof(folio->mapping) != sizeof(struct llist_node));
> +	node = (struct llist_node *)&folio->mapping;
> +
> +	/*
> +	 * Only schedule work if list is previously empty. Otherwise,
> +	 * schedule_work() had been called but the workfn hasn't retrieved the
> +	 * list yet.
> +	 */
> +	if (llist_add(node, &guestmem_hugetlb_cleanup_list))
> +		queue_work(guestmem_hugetlb_wq, &guestmem_hugetlb_cleanup_work);
> +}
> +
> +void guestmem_hugetlb_handle_folio_put(struct folio *folio)
> +{
> +	guestmem_hugetlb_unregister_folio_put_callback(folio);
> +
> +	/*
> +	 * folio_put() can be called in interrupt context, hence do the work
> +	 * outside of interrupt context
> +	 */
> +	guestmem_hugetlb_defer_cleanup(folio);
> +}
> +
> +/*
> + * Stash existing hugetlb metadata. Use this function just before splitting a
> + * hugetlb page.
> + */
> +static inline void
> +__guestmem_hugetlb_stash_metadata(struct guestmem_hugetlb_metadata *metadata,
> +				  struct folio *folio)
> +{
> +	/*
> +	 * (folio->page + 1) doesn't have to be stashed since those fields are
> +	 * known on split/reconstruct and will be reinitialized anyway.
> +	 */
> +
> +	/*
> +	 * subpool is created for every guest_memfd inode, but the folios will
> +	 * outlive the inode, hence we store the subpool here.
> +	 */
> +	metadata->_hugetlb_subpool = folio->_hugetlb_subpool;
> +	/*
> +	 * _hugetlb_cgroup has to be stored for freeing
> +	 * later. _hugetlb_cgroup_rsvd does not, since it is NULL for
> +	 * guest_memfd folios anyway. guest_memfd reservations are handled in
> +	 * the inode.
> +	 */
> +	metadata->_hugetlb_cgroup = folio->_hugetlb_cgroup;
> +	metadata->_hugetlb_hwpoison = folio->_hugetlb_hwpoison;
> +
> +	/*
> +	 * HugeTLB flags are stored in folio->private. stash so that ->private
> +	 * can be used by core-mm.
> +	 */
> +	metadata->private = folio->private;
> +}
> +
> +static int guestmem_hugetlb_stash_metadata(struct folio *folio)
> +{
> +	XA_STATE(xas, &guestmem_hugetlb_stash, 0);
> +	struct guestmem_hugetlb_stash_item *stash;
> +	void *entry;
> +
> +	stash = kzalloc(sizeof(*stash), 1);
> +	if (!stash)
> +		return -ENOMEM;
> +
> +	stash->h = folio_hstate(folio);
> +	__guestmem_hugetlb_stash_metadata(&stash->hugetlb_metadata, folio);
> +
> +	xas_set_order(&xas, folio_pfn(folio), folio_order(folio));
> +
> +	xas_lock(&xas);
> +	entry = xas_store(&xas, stash);
> +	xas_unlock(&xas);
> +
> +	if (xa_is_err(entry)) {
> +		kfree(stash);
> +		return xa_err(entry);
> +	}
> +
> +	return 0;
> +}
> +
> +static inline void
> +__guestmem_hugetlb_unstash_metadata(struct guestmem_hugetlb_metadata *metadata,
> +				    struct folio *folio)
> +{
> +	folio->_hugetlb_subpool = metadata->_hugetlb_subpool;
> +	folio->_hugetlb_cgroup = metadata->_hugetlb_cgroup;
> +	folio->_hugetlb_cgroup_rsvd = NULL;
> +	folio->_hugetlb_hwpoison = metadata->_hugetlb_hwpoison;
> +
> +	folio_change_private(folio, metadata->private);

Hi Ackerley,

We've been doing some testing with this series on top of David's
guestmemfd-preview branch with some SNP enablement[1][2] to exercise
this code along with the NUMA support from Shivank (BTW, I know you
have v3 in the works so let me know if we can help with testing that
as well).

One issue we hit is if you do a split->merge sequence the unstash of the
private data will result in folio_test_hugetlb_vmemmap_optimized() reporting
true even though the hugetlb_vmemmap_optimize_folio() call hasn't been
performed yet, and when that does get called it will be skipped, so some HVO
optimization can be lost in this way.

More troublesome however is if you later split the folio again,
hugetlb_vmemmap_restore_folio() may cause a BUG_ON() since the flags are in a
state that's not consistent with the state of the folio/vmemmap.

The following patch seems to resolve the issue but I'm not sure what the
best approach would be:

  https://github.com/AMDESE/linux/commit/b1f25956f18d32730b8d4ded6d77e980091eb4d3

Thanks,

Mike

[1] https://github.com/AMDESE/linux/commits/snp-hugetlb-v2-wip0/
[2] https://github.com/AMDESE/qemu/tree/snp-hugetlb-dev-wip0


