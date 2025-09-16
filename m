Return-Path: <linux-fsdevel+bounces-61836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC84B7F529
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A84817E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166F2EB5C4;
	Tue, 16 Sep 2025 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wwrKXeXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9E635;
	Tue, 16 Sep 2025 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063356; cv=fail; b=qI2n/OiksDeOLWabK2hkyy/gTlEgZkuBAfB2kg0iUGY8GphDHZoEX5LS5L1qPC7FzM+MASPeM5JqBsqQEn61JrxJDoPytPBLfVyOUZGnVqiOq9mRIAMGtJYSywZcIjFtVmV5ongrfQ8g62vDbR3VFXoEqJudrrlmFDA5fEx8f2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063356; c=relaxed/simple;
	bh=l2iR1vYyY/+HtVQjPsLPT4HjgydkwZWXUXzCGbBnlfg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRshrrE3ldtjkAXlo0j5hrs3Lgs/a7kNgetphQd2Lx/d3ZcgvMbs8WPVW1EjJVSby3AynlE4wNFYnEs9WWpw+HLfBuym9RfLGLTl9Cu9YbO8yrDTCgYzq+B7/lvwQPchYCdmTipN1geoxCRhT3hAJk6kYn/7goapxU6O1wI17jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wwrKXeXE; arc=fail smtp.client-ip=40.93.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is5eKdPAcNMv5dFiOLm9ygklzEkLeyJ0pXe2C4rSqwz+AMq0p617XjEpTcLyxrMEkgBfA2z11RjX2HORCfx+0yyd7vnNOCir4n+pmoZbvqQu3GtE3/x3/wIOLJorCpl2lxl5k+5pG2HPk90gtX5uHeFKaqRZu74NVnaZGxdwvf6VTsEB+iuYrmvwSG0G0ARQT5eb+b/gB2+TejC4j+zSViXKP7EbLYZ7yeFG9d3n0Q/OtunSYT+hZy6UgQMEF2p5z0nqVGVTAgae/809VQrsfG4e7BwpEZwvny8er4vaC7OJG5UOEQXMStkCQb/GgCrXy59rzs5lN3dV0Qnkrkz53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe4bsTp43qZuhrHnazkCcfcXjpy1Ct2d5tgeQmhOv2Q=;
 b=Ws9rBLKD2ap5GG3jeRoIpWKG9E9ILyclfPdan9m/w1ZGKtji+C/zg2SqbERqVEYQEEILDKMOvVX9QlE1GiwocVgR2zfwsQIwEL7/ke9JrUt3phMyiYwNYFoqg+8JTiT6oy4+QK8lx/pRn+T/QwZiPP4GT03s77EqvaR8fpi/2blfrMf+jeSUG5KoNmUyt7kLSMrGBNHV+31en/5FujIRcJxqBQ7fekx4lyCK0mY2Eno21lTK4K+fl7Zb0lb6Lm8Oa0nffv9wxaL7+LWkhzBvFEa2GIStFCz8N+qb1613K3T8zDf7ynDTvBiNj5q+8oDpoT8GZW9Z67wUWVokifHFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe4bsTp43qZuhrHnazkCcfcXjpy1Ct2d5tgeQmhOv2Q=;
 b=wwrKXeXEaJu/d2RGm91kNsvUNarf5gXJB/2UNOMEl4loNNaixLT8Zxcv/HGFTeN9T5/EmU8Erqb/fe5fIHDhkV0BKfOLbxFmsCn9A7CMLsUKUdCi/B6X5hGresRb9fEvekUIKH4A55+zARzaYsy0FSgzi+hxMHtB1pN4elOJn18=
Received: from BN0PR08CA0014.namprd08.prod.outlook.com (2603:10b6:408:142::23)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 22:55:50 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::1e) by BN0PR08CA0014.outlook.office365.com
 (2603:10b6:408:142::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 22:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 22:55:49 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 15:55:49 -0700
Date: Tue, 16 Sep 2025 17:55:28 -0500
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
Subject: Re: [RFC PATCH v2 29/51] mm: guestmem_hugetlb: Wrap HugeTLB as an
 allocator for guest_memfd
Message-ID: <20250916225528.iycrfgf4nz6bcdce@amd.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <b3c2da681c5bf139e2eaf0ea82c7422f972f6288.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b3c2da681c5bf139e2eaf0ea82c7422f972f6288.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: c16f7376-f289-4450-3c64-08ddf5742e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a3t2/6h4+Gmywo9zU/HXvQ2xggfiEJbJ7SgtRdhfzyb9JMiGY5ca8xejFVVU?=
 =?us-ascii?Q?duMSMsITwjHPPk7u9J8NSWJMOS0gdpE3j+N56hgFaklJlAAC3FVn5Nxq3lHs?=
 =?us-ascii?Q?iJrL4uc+41VgXYD/OSd4dgtQZqVimS7qFaCo+IxkKAJPiOfW9hQ2aETB3cJV?=
 =?us-ascii?Q?gZHAXkt8j+p+S1CIBVv12ZmIdyw/dSJBOSl+eXbCrV1OER/o4bZqc4M3Zsrc?=
 =?us-ascii?Q?rlXYX6GZsYm5tqp5zsDbSWuwKzTlyoEKoaHKvDzouCkZ7RsrQYcP/r2nOfyp?=
 =?us-ascii?Q?1h2NTgAmuoQ8m/80JV0mCqI7Pucp4+c4wA+tDWmPuzo7Lz3Z9SKybASAqFEc?=
 =?us-ascii?Q?C9fGiSTf0lR129RmdOee4SzKtBTpkD2rrXt6NZRyP7SYdSA8Yia5Gj7XGdEk?=
 =?us-ascii?Q?8Jyl7V0ULVxreK/CvImWTwus5HKBrjai26veyjlghUBu+BC5dddCicX1KTCF?=
 =?us-ascii?Q?FdLyKolqRddGJl62Uo5n0YZ5KNWInW2m0uiPtp7ybhN0njiWy8PMhiYm4Sjn?=
 =?us-ascii?Q?jPimRvp5dsC1mw/iPb/HdUFNwdilOK2BFrfzhjHm8Ul7cP5SWewy/ALDxqd6?=
 =?us-ascii?Q?cieMuAZlOBvUlQ8jhAuAXncsEAkmi/fQVYP93a82JPgx44kntKIS+vDg3UmF?=
 =?us-ascii?Q?eiShYHwONgxvoooXLt7I6qeDJIf0Lb4rZNpQ7AmlWCCUCHuH5TKrQMkiU+TD?=
 =?us-ascii?Q?FXFuslhdYOsBbRnbyrLhnDaZ2FLdm4nLo5AVqocTqfxRzfczdIyYBe1fiGP5?=
 =?us-ascii?Q?wdYRvOqxquwI20JkruJ7J9Gk4I8EI6LAVW1aow01JqtDh27QLTDdYiSeHtto?=
 =?us-ascii?Q?OlFVzcpS8dCufrJuN6N62K3OKgmGTlQGuvBXzlhIp5739D7eLMCMD1PZUimq?=
 =?us-ascii?Q?wPBsQri7TsK3398ulWcNxuPIaf6TflES+FPn4SPD6mZsO26sDTrVt4YSC511?=
 =?us-ascii?Q?V4yYZK4czqLgGMSOQnpf2fWWEC/HggHAGEvY+qYU6PZ6AictRS1+WzcwpLJl?=
 =?us-ascii?Q?U4AbkI1cRP1XZwx+/cwPuUacSMyafqm9qV90WlGo+IEXe2ecTbpvX5sFs5+Z?=
 =?us-ascii?Q?GzzqSBPn7Jwp3qv9qDGKsN72FLAm5qFN96UdnNeeAKzP7q8Wts6+kUxDA/k5?=
 =?us-ascii?Q?XbRuQ7eHzXEq04KUVTrmMLbdYqbQ8caHc6FHsjo7zo+RyB3E4JIj0O5RARpy?=
 =?us-ascii?Q?d18JA3GEEayPpTOmPU0nnhnHRfjyEQE5ZT8MN35TwykTQS70Ko+vLz8/0Eq9?=
 =?us-ascii?Q?h5tYKuJZRrXafzNZ1sYeKEzRdtpUGe/XrcK5d+Koqyl1uOC/4egfSHbGp+yR?=
 =?us-ascii?Q?yoNqVQ2mVRKn5/g5QgtiA8xjGv/KB8B4HO8l3OzCL1zcnVEqMc394vt5yNq6?=
 =?us-ascii?Q?xVpvHRcGe1iaxTNqHI62d26GTry2A7zSSB24ytzsnS/gmK+juVrkc0OVFvB4?=
 =?us-ascii?Q?m8V1WwJrcftGW/KTqFg40TtosI9WA5ukd/Zc8qcDhuI8cHGNqEWaNdU0EcDo?=
 =?us-ascii?Q?XkVh7+14Sz10jzVvfmD+DaS4xMP0XAuHDtrN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 22:55:49.9744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16f7376-f289-4450-3c64-08ddf5742e6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065

On Wed, May 14, 2025 at 04:42:08PM -0700, Ackerley Tng wrote:
> guestmem_hugetlb is an allocator for guest_memfd. It wraps HugeTLB to
> provide huge folios for guest_memfd.
> 
> This patch also introduces guestmem_allocator_operations as a set of
> operations that allocators for guest_memfd can provide. In a later
> patch, guest_memfd will use these operations to manage pages from an
> allocator.
> 
> The allocator operations are memory-management specific and are placed
> in mm/ so key mm-specific functions do not have to be exposed
> unnecessarily.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 
> Change-Id: I3cafe111ea7b3c84755d7112ff8f8c541c11136d
> ---
>  include/linux/guestmem.h      |  20 +++++
>  include/uapi/linux/guestmem.h |  29 +++++++
>  mm/Kconfig                    |   5 +-
>  mm/guestmem_hugetlb.c         | 159 ++++++++++++++++++++++++++++++++++
>  4 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/guestmem.h
>  create mode 100644 include/uapi/linux/guestmem.h
> 
> diff --git a/include/linux/guestmem.h b/include/linux/guestmem.h
> new file mode 100644
> index 000000000000..4b2d820274d9
> --- /dev/null
> +++ b/include/linux/guestmem.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_GUESTMEM_H
> +#define _LINUX_GUESTMEM_H
> +
> +#include <linux/fs.h>
> +
> +struct guestmem_allocator_operations {
> +	void *(*inode_setup)(size_t size, u64 flags);
> +	void (*inode_teardown)(void *private, size_t inode_size);
> +	struct folio *(*alloc_folio)(void *private);
> +	/*
> +	 * Returns the number of PAGE_SIZE pages in a page that this guestmem
> +	 * allocator provides.
> +	 */
> +	size_t (*nr_pages_in_folio)(void *priv);
> +};
> +
> +extern const struct guestmem_allocator_operations guestmem_hugetlb_ops;
> +
> +#endif
> diff --git a/include/uapi/linux/guestmem.h b/include/uapi/linux/guestmem.h
> new file mode 100644
> index 000000000000..2e518682edd5
> --- /dev/null
> +++ b/include/uapi/linux/guestmem.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_GUESTMEM_H
> +#define _UAPI_LINUX_GUESTMEM_H
> +
> +/*
> + * Huge page size must be explicitly defined when using the guestmem_hugetlb
> + * allocator for guest_memfd.  It is the responsibility of the application to
> + * know which sizes are supported on the running system.  See mmap(2) man page
> + * for details.
> + */
> +
> +#define GUESTMEM_HUGETLB_FLAG_SHIFT	58
> +#define GUESTMEM_HUGETLB_FLAG_MASK	0x3fUL
> +
> +#define GUESTMEM_HUGETLB_FLAG_16KB	(14UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_64KB	(16UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_512KB	(19UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_1MB	(20UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_2MB	(21UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_8MB	(23UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_16MB	(24UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_32MB	(25UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_256MB	(28UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_512MB	(29UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_1GB	(30UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_2GB	(31UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_16GB	(34UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +
> +#endif /* _UAPI_LINUX_GUESTMEM_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 131adc49f58d..bb6e39e37245 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1218,7 +1218,10 @@ config SECRETMEM
>  
>  config GUESTMEM_HUGETLB
>  	bool "Enable guestmem_hugetlb allocator for guest_memfd"
> -	depends on HUGETLBFS
> +	select GUESTMEM
> +	select HUGETLBFS
> +	select HUGETLB_PAGE
> +	select HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  	help
>  	  Enable this to make HugeTLB folios available to guest_memfd
>  	  (KVM virtualization) as backing memory.
> diff --git a/mm/guestmem_hugetlb.c b/mm/guestmem_hugetlb.c
> index 51a724ebcc50..5459ef7eb329 100644
> --- a/mm/guestmem_hugetlb.c
> +++ b/mm/guestmem_hugetlb.c
> @@ -5,6 +5,14 @@
>   */
>  
>  #include <linux/mm_types.h>
> +#include <linux/guestmem.h>
> +#include <linux/hugetlb.h>
> +#include <linux/hugetlb_cgroup.h>
> +#include <linux/mempolicy.h>
> +#include <linux/mm.h>
> +#include <linux/pagemap.h>
> +
> +#include <uapi/linux/guestmem.h>
>  
>  #include "guestmem_hugetlb.h"
>  
> @@ -12,3 +20,154 @@ void guestmem_hugetlb_handle_folio_put(struct folio *folio)
>  {
>  	WARN_ONCE(1, "A placeholder that shouldn't trigger. Work in progress.");
>  }
> +
> +struct guestmem_hugetlb_private {
> +	struct hstate *h;
> +	struct hugepage_subpool *spool;
> +	struct hugetlb_cgroup *h_cg_rsvd;
> +};
> +
> +static size_t guestmem_hugetlb_nr_pages_in_folio(void *priv)
> +{
> +	struct guestmem_hugetlb_private *private = priv;
> +
> +	return pages_per_huge_page(private->h);
> +}
> +
> +static void *guestmem_hugetlb_setup(size_t size, u64 flags)
> +
> +{
> +	struct guestmem_hugetlb_private *private;
> +	struct hugetlb_cgroup *h_cg_rsvd = NULL;
> +	struct hugepage_subpool *spool;
> +	unsigned long nr_pages;
> +	int page_size_log;
> +	struct hstate *h;
> +	long hpages;
> +	int idx;
> +	int ret;
> +
> +	page_size_log = (flags >> GUESTMEM_HUGETLB_FLAG_SHIFT) &
> +			GUESTMEM_HUGETLB_FLAG_MASK;
> +	h = hstate_sizelog(page_size_log);
> +	if (!h)
> +		return ERR_PTR(-EINVAL);
> +
> +	/*
> +	 * Check against h because page_size_log could be 0 to request default
> +	 * HugeTLB page size.
> +	 */
> +	if (!IS_ALIGNED(size, huge_page_size(h)))
> +		return ERR_PTR(-EINVAL);

For SNP testing we ended up needing to relax this to play along a little
easier with QEMU/etc. and instead just round the size up via:

  size = round_up(size, huge_page_size(h));

The thinking is that since, presumably, the size would span beyond what
we actually bind to any memslots, that KVM will simply map them as 4K
in nested page table, and userspace already causes 4K split and inode
size doesn't change as part of this adjustment so the extra pages would
remain inaccessible.

The accounting might get a little weird but it's probably fair to
document that non-hugepage-aligned gmemfd sizes can result in wasted memory
if userspace wants to fine tune around that.

-Mike

> +
> +	private = kzalloc(sizeof(*private), GFP_KERNEL);
> +	if (!private)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Creating a subpool makes reservations, hence charge for them now. */
> +	idx = hstate_index(h);
> +	nr_pages = size >> PAGE_SHIFT;
> +	ret = hugetlb_cgroup_charge_cgroup_rsvd(idx, nr_pages, &h_cg_rsvd);
> +	if (ret)
> +		goto err_free;
> +
> +	hpages = size >> huge_page_shift(h);
> +	spool = hugepage_new_subpool(h, hpages, hpages, false);
> +	if (!spool)
> +		goto err_uncharge;
> +
> +	private->h = h;
> +	private->spool = spool;
> +	private->h_cg_rsvd = h_cg_rsvd;
> +
> +	return private;
> +
> +err_uncharge:
> +	ret = -ENOMEM;
> +	hugetlb_cgroup_uncharge_cgroup_rsvd(idx, nr_pages, h_cg_rsvd);
> +err_free:
> +	kfree(private);
> +	return ERR_PTR(ret);
> +}
> +
> +static void guestmem_hugetlb_teardown(void *priv, size_t inode_size)
> +{
> +	struct guestmem_hugetlb_private *private = priv;
> +	unsigned long nr_pages;
> +	int idx;
> +
> +	hugepage_put_subpool(private->spool);
> +
> +	idx = hstate_index(private->h);
> +	nr_pages = inode_size >> PAGE_SHIFT;
> +	hugetlb_cgroup_uncharge_cgroup_rsvd(idx, nr_pages, private->h_cg_rsvd);
> +
> +	kfree(private);
> +}
> +
> +static struct folio *guestmem_hugetlb_alloc_folio(void *priv)
> +{
> +	struct guestmem_hugetlb_private *private = priv;
> +	struct mempolicy *mpol;
> +	struct folio *folio;
> +	pgoff_t ilx;
> +	int ret;
> +
> +	ret = hugepage_subpool_get_pages(private->spool, 1);
> +	if (ret == -ENOMEM) {
> +		return ERR_PTR(-ENOMEM);
> +	} else if (ret > 0) {
> +		/* guest_memfd will not use surplus pages. */
> +		goto err_put_pages;
> +	}
> +
> +	/*
> +	 * TODO: mempolicy would probably have to be stored on the inode, use
> +	 * task policy for now.
> +	 */
> +	mpol = get_task_policy(current);
> +
> +	/* TODO: ignore interleaving for now. */
> +	ilx = NO_INTERLEAVE_INDEX;
> +
> +	/*
> +	 * charge_cgroup_rsvd is false because we already charged reservations
> +	 * when creating the subpool for this
> +	 * guest_memfd. use_existing_reservation is true - we're using a
> +	 * reservation from the guest_memfd's subpool.
> +	 */
> +	folio = hugetlb_alloc_folio(private->h, mpol, ilx, false, true);
> +	mpol_cond_put(mpol);
> +
> +	if (IS_ERR_OR_NULL(folio))
> +		goto err_put_pages;
> +
> +	/*
> +	 * Clear restore_reserve here so that when this folio is freed,
> +	 * free_huge_folio() will always attempt to return the reservation to
> +	 * the subpool.  guest_memfd, unlike regular hugetlb, has no resv_map,
> +	 * and hence when freeing, the folio needs to be returned to the
> +	 * subpool.  guest_memfd does not use surplus hugetlb pages, so in
> +	 * free_huge_folio(), returning to subpool will always succeed and the
> +	 * hstate reservation will then get restored.
> +	 *
> +	 * hugetlbfs does this in hugetlb_add_to_page_cache().
> +	 */
> +	folio_clear_hugetlb_restore_reserve(folio);
> +
> +	hugetlb_set_folio_subpool(folio, private->spool);
> +
> +	return folio;
> +
> +err_put_pages:
> +	hugepage_subpool_put_pages(private->spool, 1);
> +	return ERR_PTR(-ENOMEM);
> +}
> +
> +const struct guestmem_allocator_operations guestmem_hugetlb_ops = {
> +	.inode_setup = guestmem_hugetlb_setup,
> +	.inode_teardown = guestmem_hugetlb_teardown,
> +	.alloc_folio = guestmem_hugetlb_alloc_folio,
> +	.nr_pages_in_folio = guestmem_hugetlb_nr_pages_in_folio,
> +};
> +EXPORT_SYMBOL_GPL(guestmem_hugetlb_ops);
> -- 
> 2.49.0.1045.g170613ef41-goog
> 
> 

