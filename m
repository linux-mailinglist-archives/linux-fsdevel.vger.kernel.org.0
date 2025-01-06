Return-Path: <linux-fsdevel+bounces-38406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40338A01F45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 07:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6981884A02
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 06:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31561D5AA0;
	Mon,  6 Jan 2025 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RORYoBLR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD5A936;
	Mon,  6 Jan 2025 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736145576; cv=fail; b=QoIdB7uXMHRZ2ihbIRVp76oWEUfazEZuvQ+GI17DsDqEKRGGWKEPG/Iso+v5Ifrqd67/yaUvPTuCdf3payDZn8uVLhM2bVHzaii9ufbQTFQB4TH4vW/48sDRa18PEnbRsKjq30WTeZ04dlhu/SGfb3gefhhmsFfkaUSmAhBJ/PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736145576; c=relaxed/simple;
	bh=1zz/73N6ffFJeANXT4chL6wWAR7kKOGQZ8QkaRR8c/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QHT8feT30cE1gF3YfhNVdHJ9m10a/P1q3d7xKTNQfvdjOn/JMrJ32oLySDTD1/ursVuKK647ykmLUuEBcqVwg8k9aJuBZlkwMTDrk2ir3Wj+CTurimE9tYqzFHBftlpG0Ae/NB5whb/NQIwozKEX/IR2HfyGl+LX6bgQ5Hzr2gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RORYoBLR; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Noz45A+vIFzA7XkbIC0Zsz4OkBLWdjQ/A6Aqe5XnHhGVg9sTaLu0qNtazIABgMu8Zt6Csa6W5t5QRoOtZNFE0mi9MpVggR7hCOfuezrwQ4IwJ1G7uQV7Iv8LH0zx7V2zDHknX0gLaRkwaE3drBDs5PISBijBGmZjf7XW0XbCJ9+b2zYzDlx79vAf9gwAYXjg8KJhpBJL40cpX9VLm/fcKiMWxN5GJ0wECsW2QnTA5hvyxpHZTOjM7WaRuxTPuw4V0+2dHW4rm/GO7yi61tzLR4YwY8cEGapC+N0Pg0dQP6l9Vps/SbShh91XdmJR4ghiwJ/EQXQsR/1lALRFmzq2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnnVwK6zgHL/hjflphlgvDnQ56uu6Ekg3Wn3gcJU7Fg=;
 b=ZCJP9V43mjVYsctsjHVVpUiJgNng/Ijj17svoqtKQVTdqWmgQTe0Awec2nPUcwjhiwV3Z/MHRa3qu+4pCGHLobLkmRjdW1qFt59QzdEjV3QI20fuGJAK7xiVqVDTT9hRCndtgKu8MhNMpV3fNn/hu9Zl5ZuDNZtrWWBxReGbwF4aVTMCXJJAdYBQOZx1tV3SYzzy0Zfx2Uva8fP5yxlDe0vGZut450lKZKgy24XnKVfIRVZx/Iz/NgllRR2DVoYC5gc7fE7kGE69nIVoELsoLVCcJUbFqa4ilg6HtM92ugFog6DhWYSjELxtfw1cIolus8fDZitN/9fG0kGvBlfmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnnVwK6zgHL/hjflphlgvDnQ56uu6Ekg3Wn3gcJU7Fg=;
 b=RORYoBLRUvd8NGwnCN8xv42KmRmDSjq8QvNbK3v0e69vOb7V5V0W1lDF65nd/8kWEkhwduWt2AoPBgcaej169EuVC5fWSk/DGLM3ahBUlwxlNkkuQGZYMDMhcOKEKUyo59VK2J4EhB8zMEH0IHmdlv5z3bfCQG84hX/ltQb3Lpw6IzMQdBaR95jCcohXZeYe9z+Z8VeLO9oig85kbiI2eiAiRVdmo91aVM2AgO9v8ZajzWMoVO7gbCCfAD2xijPKtiMaG65EuJiY32d2I8BijZeyR9gZEAVSWEqEAz5bb8QVhWMHwsPa9BpDAKV2ZKtPwEOtk8xZx37tutns++r1AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 06:39:25 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 06:39:24 +0000
Date: Mon, 6 Jan 2025 17:39:19 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH v4 15/25] huge_memory: Add vmf_insert_folio_pud()
Message-ID: <iz7glgzlighxqfsqj6flrbsnfg66wzmzrgdz7toqdtxe4jon4t@bne5qv2qfghp>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
 <03cb3c24f10818c0780a08509628893ab460e5d1.1734407924.git-series.apopple@nvidia.com>
 <ee19854f-fa1f-4207-9176-3c7b79bccd07@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee19854f-fa1f-4207-9176-3c7b79bccd07@redhat.com>
X-ClientProxiedBy: SY5P282CA0004.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:208::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 834bfd26-b4a7-4144-2b55-08dd2e1cdc4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z1n3gm1jRU0l5CC0cr947PPu4pihLgRuhzVJ5BDmMXq9oNgodiJMrB9DmqSH?=
 =?us-ascii?Q?6ymGQP76lj79GTPvWoU/alZF/g8IEhFMPHUp5JTFaMND1w1agDKawmLruFvW?=
 =?us-ascii?Q?G97NCB8kkJODGSitjQ+L3WzaqwjimUjBf3ZdvxnZ6zXCLJyDF9XJkFTvTgBa?=
 =?us-ascii?Q?L9Io0ziclt1C+RRyEJTAcQQBirsYzPhni2FcugFHnzfOVarm8jA/igpuNoX7?=
 =?us-ascii?Q?Yz3mD3Thb4nfbRRPs62QKBosbqG6QELY+2OYdO47+ckme5NG/vm2I88n223c?=
 =?us-ascii?Q?4yemLOk9IIVzdFyeb8FDC9tvw8Wj0Kke8Fwhu8vx8qxBuzr9G+zrzoe9h55B?=
 =?us-ascii?Q?b3+NG8kPGqIgjovBeaJVLI59ps+iGQsiD8YLY8hKSXBwEBSexgqd1tKPe+78?=
 =?us-ascii?Q?KdF2RmQAHFZ8/9Ps6lalRjpAvD17uPSIerc8C37UW4/W8bUhc6Hermw+16Vy?=
 =?us-ascii?Q?eoGh/zhSNA3N11sgQ4e9Q3eFuqGT+5w9yE43VigDXpaXRMpHVQmVSEgycx0S?=
 =?us-ascii?Q?FLNs9wkY1GoFjbcyuXPYGERzE942oyYCS60KzZpQpKFU7cyvm6EVMHaHyhr2?=
 =?us-ascii?Q?rna1mMcnSgIlm7M+tqHhVN4jNkaO6RT48x7pZC4sdJXo1yZTXY+sSLpJB7WZ?=
 =?us-ascii?Q?Ea+IdCrR7PrJRkIbQxMBk70nBlaupMRyGDfVFfSZQl/uZ8vXYtgYE9DJmDRu?=
 =?us-ascii?Q?kVPQGSBgZD/g33XvTrogN5nXE9B0R88Ay6Cg+tmwRC2lyjIvaFIwKWmwuql8?=
 =?us-ascii?Q?XvihlhjHhR9XjxpYr0tbGwca/XmncLqpHq/YCJ2+NCY7y0AjITmRkzKQ4C1q?=
 =?us-ascii?Q?tZOrBiutwU4qIKwAvJxlUhOHNuCffYa0j2TJlZ2rDq/lN38rzMYE2xwKG2ij?=
 =?us-ascii?Q?sWvnsBj12qlwhJeLMnfvR4EWSEMziHz8nH4PHEd+gzjyFi9s0si7dyjfTQI3?=
 =?us-ascii?Q?aDbnWuI+o19Uaq6MqLXNtIIE9zpq8+fvcGewYZ2PLajQVa3be2ZBG8dlzXeq?=
 =?us-ascii?Q?sT1L6Sl+O/xhdcQu5SUQLcsMhV9JTii9crllMzF8qjAi+gPr1Q4rWsmcuBDj?=
 =?us-ascii?Q?ObCcDeEApWNJ02enq0IlIPK9JiOC4qptnURDa5TbV50JdT1IUgrXzwlOd9bj?=
 =?us-ascii?Q?eDapr4PE0zZJT0w+6yvD55zbxO6iLyOTZTjSQiPI2jGkdwl8RaAhMC7SLxq+?=
 =?us-ascii?Q?3OyJlsYZm6L/mM27YDCt5AUAEoXxqggtIVw/ySUeSj3hxQ5Kh/fTDfDBlT61?=
 =?us-ascii?Q?h+YOFFvHI9fmwDaXkAzALuBGTFB6opmc3E7TEWK2ryVgLRvsF88vNeTtSNxG?=
 =?us-ascii?Q?5VXM4z+mLxMOrCrHGatI7tdyMj+0g+n/vCD+PbvKlURmjyYdm4nBUr9Uz2nb?=
 =?us-ascii?Q?U2XmYGawzke8Gl4iO8bIdY6k/XhS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ytnTVdGa8VLe1pqrArWVjeUXC1E3WWkCqFlRpnyf230mVRuOGlYhFNV4Bb9?=
 =?us-ascii?Q?kGwyGwA7y+CNioZvFPq0jV/YtWTaWrHTiQiaO+WAGHMkRAyz6zMLe9kSPxP2?=
 =?us-ascii?Q?SOa90kh5FNyPKi2lhH3p1YS4yhlUNurCnnNzlb+hCeIWGSbDmrK/1RCBgtJT?=
 =?us-ascii?Q?7QZPkHRfHiSh69/IAfn/hNQYj/kWYQDR+XxMyMqaW5oxuAHIv/RUtuIcc1zb?=
 =?us-ascii?Q?EN09oklVnc+vjLcpHigTOAOluGeoHI2WH4JSiX28TeK1CoxK7H1r2XidW42u?=
 =?us-ascii?Q?UoiH1dMKdg0UEc38oAn3eFZuTjq7TED+1/uzEwkcLJDeme+63ch/6t9/lmfA?=
 =?us-ascii?Q?MGXAXTw53VpC77BnXk0bd/wzDoyOhFOwaL0BAuuTDPGmqhpfrob0L3YszMbB?=
 =?us-ascii?Q?2+WlxCbQSFhIxX86dugCoP7ohcFlkVKVFmxxsBWqv6VcWLTvWBZjgYqJMyqw?=
 =?us-ascii?Q?GWZinZVT6DZ2F12CLVXdrMZqg/ovMv2R/9CRLphnkXeoKNe312UewlrtdBbt?=
 =?us-ascii?Q?yI1NSW5CNIg8sodezNZ1vI9o7aROa27xrbYbytiErka7x2cFYYx7c9NzN9IA?=
 =?us-ascii?Q?NCh/FUtp6QLWryr7uC7HCDHZ3W9TsaSHEVOfie71+pG8bqT4ye4KWaB5cOQP?=
 =?us-ascii?Q?wo/Nn9xCxfiiF5WtqoLBKZLOEHAghbUQyfg0M8anNXu2bgPIMa+eIeGE2Bu1?=
 =?us-ascii?Q?4WfaQ8a0DAaI8yCbMqQ2cwjjnoxvHwBaO8unxbnDJjL769fE7R4Xamfug39l?=
 =?us-ascii?Q?kc2rIiHgYJSEfWuWte7ugeOQcLzKmgcEaH89GzAq2f9snYOOi1SaQkgJTbNj?=
 =?us-ascii?Q?pZncEN2+XApKI4CvQOXBYFjnS4LR6237x27t2RSi1pvu6sLZtozaoSQgmg5D?=
 =?us-ascii?Q?L7r3H0kwZhA3XH563yf8BbnxNq7K9XRg2uTzH/0hzNt8LlahQ4mlRHygvn5Y?=
 =?us-ascii?Q?OCZSP7+k+GmgVYQs4qfIJ96axuAm7WZrz3pYAVRl4+uPaEUROmI3qq9pZ8GF?=
 =?us-ascii?Q?NIh7YIAEqeVVTknIq1rqlRBhSNE/IRqnVP+OaaJZ6ffvy1PvnFPvirbGNlB3?=
 =?us-ascii?Q?06Fb889je4s7RCovftx1/Vu71+oRQHEl6l8Ivxbov/0vhN36fuSP27n5jw7Z?=
 =?us-ascii?Q?14RoJy8wimUGQrva+A3Zc5GI6A/2J1g3lWT3gV6tusonBhsfzOpYv9AcoFay?=
 =?us-ascii?Q?Z+2J9hTldO/tW81lW3vrrnON+6FobUH/rJ/aoDRcXBMO7F0OcuMwt8OS7Rx2?=
 =?us-ascii?Q?GDqNd2eMx2Aw9zaeYHSQmFBayfQyU70y9xNqezbyei4CeiAvty7lxP6VcZoS?=
 =?us-ascii?Q?KNQuEsLCFFWbPpNl2uYB/Zybt6ep6SCTn9mTTbFtg+Waq2E9rA3qImHOGHPJ?=
 =?us-ascii?Q?0EOXjdAcjfZCAeCHZOMQnba2XmpKeg3B7i1OD1Iax34xofDbK9shiipVx49z?=
 =?us-ascii?Q?RjBPKFdSR19yJQFUBoauDXFJ4QpaEopIg62e6ZviTNPOhrLSR+y7jpcfwsDm?=
 =?us-ascii?Q?uDGpFITGIerZtz1yvet7zfQAyb9m4uab4yCSbGUqnuCVlaOCGGred/Cvr//j?=
 =?us-ascii?Q?Q60vBFE/dPDK2cXi7u3E+XOj+u3iG2z0jMbFaCs3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834bfd26-b4a7-4144-2b55-08dd2e1cdc4b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 06:39:24.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y14kB8oPF8T9zCttuuAOl1b090A2SFu4rjns4jwYoKoQ1nb0D3Im4Z7/UYAZbQdmssBIRniL4aAP0iK+3YDctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989

On Fri, Dec 20, 2024 at 07:52:43PM +0100, David Hildenbrand wrote:
> On 17.12.24 06:12, Alistair Popple wrote:
> > Currently DAX folio/page reference counts are managed differently to
> > normal pages. To allow these to be managed the same as normal pages
> > introduce vmf_insert_folio_pud. This will map the entire PUD-sized folio
> > and take references as it would for a normally mapped page.
> > 
> > This is distinct from the current mechanism, vmf_insert_pfn_pud, which
> > simply inserts a special devmap PUD entry into the page table without
> > holding a reference to the page for the mapping.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > ---
> >   include/linux/huge_mm.h | 11 +++++-
> >   mm/huge_memory.c        | 96 ++++++++++++++++++++++++++++++++++++------
> >   2 files changed, 95 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 93e509b..012137b 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >   vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
> >   vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
> > +vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write);
> >   enum transparent_hugepage_flag {
> >   	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
> > @@ -458,6 +459,11 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
> >   	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
> >   }
> > +static inline bool is_huge_zero_pud(pud_t pud)
> > +{
> > +	return false;
> > +}
> > +
> >   struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
> >   void mm_put_huge_zero_folio(struct mm_struct *mm);
> > @@ -604,6 +610,11 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
> >   	return false;
> >   }
> > +static inline bool is_huge_zero_pud(pud_t pud)
> > +{
> > +	return false;
> > +}
> > +
> 
> I'm really not a fan of these, because I assume we will never ever implement
> these any time soon. (who will waste 1 GiG or more on faster reading of 0s?)

Ok, I will drop these.

> >   static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
> >   {
> >   	return;
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 120cd2c..5081808 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1482,19 +1482,17 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
> >   	struct mm_struct *mm = vma->vm_mm;
> >   	pgprot_t prot = vma->vm_page_prot;
> >   	pud_t entry;
> > -	spinlock_t *ptl;
> > -	ptl = pud_lock(mm, pud);
> >   	if (!pud_none(*pud)) {
> >   		if (write) {
> >   			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn_t_to_pfn(pfn)))
> > -				goto out_unlock;
> > +				return;
> >   			entry = pud_mkyoung(*pud);
> >   			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
> >   			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
> >   				update_mmu_cache_pud(vma, addr, pud);
> >   		}
> > -		goto out_unlock;
> > +		return;
> >   	}
> >   	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
> > @@ -1508,9 +1506,6 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
> >   	}
> >   	set_pud_at(mm, addr, pud, entry);
> >   	update_mmu_cache_pud(vma, addr, pud);
> > -
> > -out_unlock:
> > -	spin_unlock(ptl);
> >   }
> >   /**
> > @@ -1528,6 +1523,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
> >   	unsigned long addr = vmf->address & PUD_MASK;
> >   	struct vm_area_struct *vma = vmf->vma;
> >   	pgprot_t pgprot = vma->vm_page_prot;
> > +	spinlock_t *ptl;
> >   	/*
> >   	 * If we had pud_special, we could avoid all these restrictions,
> > @@ -1545,10 +1541,55 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
> >   	track_pfn_insert(vma, &pgprot, pfn);
> > +	ptl = pud_lock(vma->vm_mm, vmf->pud);
> >   	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
> > +	spin_unlock(ptl);
> > +
> >   	return VM_FAULT_NOPAGE;
> >   }
> >   EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
> > +
> > +/**
> > + * vmf_insert_folio_pud - insert a pud size folio mapped by a pud entry
> > + * @vmf: Structure describing the fault
> > + * @pfn: pfn of the page to insert
> > + * @write: whether it's a write fault
> > + *
> > + * Return: vm_fault_t value.
> > + */
> > +vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write)
> > +{
> > +	struct vm_area_struct *vma = vmf->vma;
> > +	unsigned long addr = vmf->address & PUD_MASK;
> > +	pfn_t pfn = pfn_to_pfn_t(folio_pfn(folio));
> > +	pud_t *pud = vmf->pud;
> > +	pgprot_t prot = vma->vm_page_prot;
> 
> See below, pfn, prot and page can likely go.
> 
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	spinlock_t *ptl;
> > +	struct page *page;
> > +
> > +	if (addr < vma->vm_start || addr >= vma->vm_end)
> > +		return VM_FAULT_SIGBUS;
> > +
> > +	if (WARN_ON_ONCE(folio_order(folio) != PUD_ORDER))
> > +		return VM_FAULT_SIGBUS;
> > +
> > +	track_pfn_insert(vma, &prot, pfn);
> 
> Oh, why is that required? We are inserting a folio and start messing with
> VM_PAT on x86 that only applies to VM_PFNMAP mappings? :)
> 
> > +
> > +	ptl = pud_lock(mm, pud);
> > +	if (pud_none(*vmf->pud)) {
> > +		page = pfn_t_to_page(pfn);
> 
> Why are we suddenly working with that pfn_t whichcraft? :)

Heh. Mostly because insert_pfn_{pmd|pud}() still requires such witchcraft. Of
course once this series is merged there is a resonable chance we will be able to
cast a spell to remove pfn_t entirely -

https://lore.kernel.org/ linux-mm/172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com/
 
> 
> 
> > +		folio = page_folio(page);
> 
> Ehm, you got the folio ... passed into this function?
> 
> Why can't that simply be
> 
> folio_get(folio);
> folio_add_file_rmap_pud(folio, folio_page(folio, 0), vma);

No good reason. Likely it is a hangover from my original implementation, where
this function was DAX specific and took a pfn_t instead of a folio. Peter
Xu asked for a more generic version that took a folio and clearly I did a
somewhat lazy implementation of it.

Will clean it up as suggested.

> > +		folio_get(folio);
> > +		folio_add_file_rmap_pud(folio, page, vma);
> > +		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
> > +	}
> > +	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
> > +	spin_unlock(ptl);
> > +
> > +	return VM_FAULT_NOPAGE;
> > +}
> > +EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
> >   #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> >   void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
> > @@ -2146,7 +2187,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >   			zap_deposited_table(tlb->mm, pmd);
> >   		spin_unlock(ptl);
> >   	} else if (is_huge_zero_pmd(orig_pmd)) {
> > -		zap_deposited_table(tlb->mm, pmd);
> > +		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
> > +			zap_deposited_table(tlb->mm, pmd);
> >   		spin_unlock(ptl);
> >   	} else {
> >   		struct folio *folio = NULL;
> > @@ -2634,12 +2676,24 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >   	orig_pud = pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
> >   	arch_check_zapped_pud(vma, orig_pud);
> >   	tlb_remove_pud_tlb_entry(tlb, pud, addr);
> > -	if (vma_is_special_huge(vma)) {
> > +	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
> >   		spin_unlock(ptl);
> >   		/* No zero page support yet */
> >   	} else {
> > -		/* No support for anonymous PUD pages yet */
> > -		BUG();
> > +		struct page *page = NULL;
> > +		struct folio *folio;
> > +
> > +		/* No support for anonymous PUD pages or migration yet */
> > +		BUG_ON(vma_is_anonymous(vma) || !pud_present(orig_pud));
> 
> VM_WARN_ON_ONCE().
> 
> > +
> > +		page = pud_page(orig_pud);
> > +		folio = page_folio(page);
> > +		folio_remove_rmap_pud(folio, page, vma);
> > +		VM_BUG_ON_PAGE(!PageHead(page), page);
> 
> Please drop that or so something like
> 
> VM_WARN_ON_ONCE(page != folio_page(folio, 0));
> 
> > +		add_mm_counter(tlb->mm, mm_counter_file(folio), -HPAGE_PUD_NR);
> > +
> > +		spin_unlock(ptl);
> > +		tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE);
> >   	}
> >   	return 1;
> >   }
> > @@ -2647,6 +2701,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >   static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
> >   		unsigned long haddr)
> >   {
> > +	pud_t old_pud;
> > +
> >   	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
> >   	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
> >   	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
> > @@ -2654,7 +2710,23 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
> >   	count_vm_event(THP_SPLIT_PUD);
> > -	pudp_huge_clear_flush(vma, haddr, pud);
> > +	old_pud = pudp_huge_clear_flush(vma, haddr, pud);
> > +	if (is_huge_zero_pud(old_pud))
> > +		return;
> > +
> > +	if (vma_is_dax(vma)) {
> 
> Maybe you want
> 
> if (!vma_is_dax(vma))
> 	return;
> 
> To then reduce alignment. I suspect all other splitting code (besides anon
> memory) will want to do the same thing here in the future.

Yeah, that looks more readable. Thanks!

> -- 
> Cheers,
> 
> David / dhildenb
> 

