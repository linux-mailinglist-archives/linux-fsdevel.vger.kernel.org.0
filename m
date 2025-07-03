Return-Path: <linux-fsdevel+bounces-53763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC60AF6906
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 06:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C94A46BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 04:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19C428B417;
	Thu,  3 Jul 2025 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XF3ChXwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690DF9D9;
	Thu,  3 Jul 2025 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515953; cv=fail; b=DzucbkXHfBjXBRmq7pe+PQJ1gL3Y/GJdat0YOWpcyHwuUJbfsKpx+yNGoIsmY34p6GgW2Atbn8bMCh3w25qB41FR8h0uxCoEQrMa71DRQ+rU2riQjKfN+XyRVDeqXwcgvQt7HRtnKy8VjPkApDebJYu1SNeJCEOuyb9m51Ofw7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515953; c=relaxed/simple;
	bh=ELi+ljYgr1oW7a0A5hcgNXZFseFKSfIZLtqUb8ygRr4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfKuELHFoG1JTluDA+wfOO1r8gAwy0ASw6Zbuy64kTBGbX39wuPqEn4mOJjB4SLRprmKuGmLicoWlQspkHjdwsFO1vmXRkkMLFzQ5+keguB3oja5Z3Arc5Z0KJnDnp8vbyq2DUx+QlucXYfBsj92ElwTyYr/O6VaR9upQo5Ez9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XF3ChXwJ; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNivaKzb4KXx0iNke8L25MYcVfHz1gtt9pMnKN3psJ6GVOXodkaeBOzrhDd+qnTH1uLQ4TFb1TPjjIvBaplkvECde72UA9zoHPSiiZ7Hgzk1vwUZsBYcKNWmXWBU0Su887QPnXddBsjNRHuqgDGNH6OjxCK/jWnVGRetFwf8nD5BYc3WC7ULdYDwqflLusCyiRuOavHmtpqgpge6q2dnOcJ8M6pbH0rBCzhu8qCA6kjzSEIUQkuhBYcA79mgxHeWIV+riWeyYV/fRIzGp/dmFs/tTxhPjrFq2q+2GjbYm2rZ/Fwy2IhuM/Vu7VaH74Hirmg/evtbplU9frc0h7AnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxBSUWvQFpoKdeQfpk9ytP6kXYZfFhdGBN+lbJyBHZM=;
 b=OxLcepyDIwHhPsOIZookcx3cLJN67HWpa44fhZaxmiNgO8Wb07f1nmyf84fVaA1tZX4658bOjC0sPGelvmSa5z1kHjl7pKN3SbJQ6B3D81vTG/Elcz3RokJrN+upMEV8VkLpy7TvHzsLwJ5uUVNjkD1dTMXf9dw5LbtavIEbIKMGs2b99LNJt2MYtaRfTsVW2SL+aWZK/cecASnFOxkpNmMSb2iqw0s8q8noX6Tmy75zQJ2LoRf/Fe6KaxY3zRAApgIFjplKLxAd7abHX4UVZ2TwXBpArf0roJ0EhadKJUbK+yK3Z2f3rTGHQqjNan36PyeRr89GMSsdglqqes0cUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxBSUWvQFpoKdeQfpk9ytP6kXYZfFhdGBN+lbJyBHZM=;
 b=XF3ChXwJljjrIboVsORXuCAMh0Yxla4KKcwfumSldDlbLVGefAqffsPMztcZgYLzio8Dnfp9SPRDOw+27jGBqr/LmCjQvColpqJ3jUnzFE953nE7L5PsZlZfvCEywE5nNKr/I8nIbPODTADWwCo5o8YXlpASwRWhf5ElkAHOk1I=
Received: from BN9PR03CA0117.namprd03.prod.outlook.com (2603:10b6:408:fd::32)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 3 Jul
 2025 04:12:25 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::22) by BN9PR03CA0117.outlook.office365.com
 (2603:10b6:408:fd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 04:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 04:12:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 23:12:24 -0500
Date: Wed, 2 Jul 2025 23:12:10 -0500
From: Michael Roth <michael.roth@amd.com>
To: Vishal Annapurve <vannapurve@google.com>
CC: Ackerley Tng <ackerleytng@google.com>, <kvm@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
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
	<thomas.lendacky@amd.com>, <usama.arif@bytedance.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yan.y.zhao@intel.com>, <yilun.xu@intel.com>, <yuzenghui@huawei.com>,
	<zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
Message-ID: <20250703041210.uc4ygp4clqw2h6yd@amd.com>
References: <20250529054227.hh2f4jmyqf6igd3i@amd.com>
 <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
 <20250702232517.k2nqwggxfpfp3yym@amd.com>
 <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c08db78-8b79-471e-9fff-08ddb9e7d107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXBWQm8wMnBYY0ZYc2RLV2hrQ1FpZGVmL2g2dDlDQmFkU3BmQTdhTFZ0Ujdj?=
 =?utf-8?B?TlluMk83aGVhbHA2MDFudzEwcjY0Ni9wQlRwMDRFMTd3WDhkbFF5UkVQOUZV?=
 =?utf-8?B?OE9MN3NObUxRR2dtMXJhNWlrSjRQdzJXanBMT0twUWVJTFlDL3l4UG85cEJx?=
 =?utf-8?B?VW5QeFNsTVQ1QVV2eVFjS1ptZDJMbnpaT0wyVnVzeFBodjNZMEJYeHBVb2ly?=
 =?utf-8?B?SkVXZFo4dzdpeFdJM1I2RlFReGxMaUZjQkIvRWEzd29pMkdQRVBzcTdvNFA2?=
 =?utf-8?B?WmtwYWhUNmVxcEhQQnhQcXB3c2ZUTXlONkVreGhXaEVxN2F2M0RXWk1Pbi9L?=
 =?utf-8?B?R205NmVmRFp4WTNRTzlwU09zMXF0aGdLd1g4Y1Mzbi9WSG03NVRudCtlQnlp?=
 =?utf-8?B?U2I2T3g0dVZIS0QwT3VGRmZmRzRJM2tseG1HZjdCV3kweUZlMGY0QnBjZkRY?=
 =?utf-8?B?a2xCUlFVSXdnelR5RnB1RjUyKzhGNVpTWlliK2l1OXI2eDVGeWlNM0x4SG1B?=
 =?utf-8?B?RjBMeTd3Rk52OTZjTXRvRFo0Uys0SThhZnNqNzlFMm4vV2ZxTGpyUWR0RjJD?=
 =?utf-8?B?VTd2UVdzVjRvL044SW9rQTJmQWlKeks1Z0UwM04xQ2xualc3WlFMMitmYng3?=
 =?utf-8?B?LzRaWkp6OEdmVm8zSTRrRGFQQ2s5bjZ4Szk2ZFBWUmdkTmdOdkF1aTVuZzFM?=
 =?utf-8?B?THpFb2RFZUpSNzZPQ2g2ajNzSW5SVFM3SWRPd0V4aWtOSFVVcTRLMy8yWHNX?=
 =?utf-8?B?L2oyWVBMcFc3TVVWVTd6b21DU1l4UGxnRmx6UTNiMElPSVFWMEhRQWhaazNY?=
 =?utf-8?B?dnl6Q1hLQTVGU0VSdWIxcTdna2ZMVlBTYXBDRlIxNE43NnZrTU5PSlNPMFln?=
 =?utf-8?B?SEwvaVNGSmV4WFJ0MzBzMzQ5NTFLK2NKMmVrUmRFZW51eHNlNlJxSlhYbkVI?=
 =?utf-8?B?YkRuK3RqcnRxaXRtbGwwZElPdzlwUnNxb20ycnJOQ0hIZjBMcGpBZTBmWmdS?=
 =?utf-8?B?dlNLaG5FdmdEN3Q1ZXJRMGQ0TkJKSG1IclJ6ZWttd05iK1BSVUNtWjJVMllh?=
 =?utf-8?B?YllidkdnMTJJY2FmTnF3UGl5YmtmNGlFcHlJUUNUdGxuSHFkaGpJcTNRYnJs?=
 =?utf-8?B?cDBFZXBTYWRwekVOWmJoZjl3a1JsdllURUpiV3M5ejBuMWZRSWFvbG82U1My?=
 =?utf-8?B?VVNNY0g0TkxkbEhDTzV5RVJmTkxnVjdiOFd0YktqVjJIR0FTd1p0NVlHT2w5?=
 =?utf-8?B?Ty9ZaW9xYnFiZzdZUlB6aXdOd01UWnM1cXdTTks2NGwvNUIranZwU1ByaUJX?=
 =?utf-8?B?b21KbTByeDJLcHo2RVdqdElKbGowMWk4d0lWcjJrV1pUT3VMM3dTbE5pSjRX?=
 =?utf-8?B?UFBibnJDMHBnenJzamJNUWtDd1YxMmdWOGw3QXp3OWJsSTlPaXUvWEt1WVA0?=
 =?utf-8?B?SktEaExXTDhoUlZSaE1rWktTUmNqMW5TcDhUb3dpUVVWeWZUYmpjd0kzT24w?=
 =?utf-8?B?czN0WFdLRUx3cDlJTmtCQnFHOVdONndlU29JdllvV0lybklPbFFWbXQ0Z1g3?=
 =?utf-8?B?MGxVb1pVaVF2UmE0MWRmZGRrUHQxZkhsMDlYZDl0Y1JPaWJ6M3ZhaFE0aXJU?=
 =?utf-8?B?c2g3ZUtkN1BGWG5WOUVmWWdoV2ErQ0pnUE9CRXhrTjUvNExITEN5QkRBbCtG?=
 =?utf-8?B?S1d2UGR0YmkrU3hSZDUyVzk4Z3NoZDg3a0tCZGlRcmhuTWdTamxQTi9XT1dS?=
 =?utf-8?B?N1pYeG9UdTJTbU5NNWZKdjIra2poZzAyd0dEdEpYbUEzT1Y2UnpIQ2tpWjJo?=
 =?utf-8?B?TFYxbW9xODI3R1U1RGkxYUFuZjV6WnJsQmhwSTMxUWk2ZEhndzJYWG9qOEkx?=
 =?utf-8?B?SUZDcnRadHdlU3dZTUZLQngyM09LLzJvR2hDYWZLaWFpRzJzVGVzelp4SHBR?=
 =?utf-8?B?dVM2MmxzaXgvTi9kV0RWR0VVWTYyNkRWNGdZTVB5VldRMm9lcUFvbmFodTdK?=
 =?utf-8?B?N0xnWnZ4RVJ1SEtRUzNITy9yVDNBdDVFakJMdlVVNXFWMCtvdnprU21qTkdt?=
 =?utf-8?B?Y09GWmhwdVFmMkFJRFhseEd6cGl1UDVwdkQzUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 04:12:25.1408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c08db78-8b79-471e-9fff-08ddb9e7d107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

On Wed, Jul 02, 2025 at 05:46:23PM -0700, Vishal Annapurve wrote:
> On Wed, Jul 2, 2025 at 4:25 PM Michael Roth <michael.roth@amd.com> wrote:
> >
> > On Wed, Jun 11, 2025 at 02:51:38PM -0700, Ackerley Tng wrote:
> > > Michael Roth <michael.roth@amd.com> writes:
> > >
> > > > On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:
> > > >> Track guest_memfd memory's shareability status within the inode as
> > > >> opposed to the file, since it is property of the guest_memfd's memory
> > > >> contents.
> > > >>
> > > >> Shareability is a property of the memory and is indexed using the
> > > >> page's index in the inode. Because shareability is the memory's
> > > >> property, it is stored within guest_memfd instead of within KVM, like
> > > >> in kvm->mem_attr_array.
> > > >>
> > > >> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
> > > >> retained to allow VMs to only use guest_memfd for private memory and
> > > >> some other memory for shared memory.
> > > >>
> > > >> Not all use cases require guest_memfd() to be shared with the host
> > > >> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
> > > >> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
> > > >> private to the guest, and therefore not mappable by the
> > > >> host. Otherwise, memory is shared until explicitly converted to
> > > >> private.
> > > >>
> > > >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > >> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> > > >> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > > >> Co-developed-by: Fuad Tabba <tabba@google.com>
> > > >> Signed-off-by: Fuad Tabba <tabba@google.com>
> > > >> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
> > > >> ---
> > > >>  Documentation/virt/kvm/api.rst |   5 ++
> > > >>  include/uapi/linux/kvm.h       |   2 +
> > > >>  virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++++-
> > > >>  3 files changed, 129 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > > >> index 86f74ce7f12a..f609337ae1c2 100644
> > > >> --- a/Documentation/virt/kvm/api.rst
> > > >> +++ b/Documentation/virt/kvm/api.rst
> > > >> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
> > > >>  The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for CoCo VMs.
> > > >>  This is validated when the guest_memfd instance is bound to the VM.
> > > >>
> > > >> +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the 'flags' field
> > > >> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.  Setting GUEST_MEMFD_FLAG_INIT_PRIVATE
> > > >> +will initialize the memory for the guest_memfd as guest-only and not faultable
> > > >> +by the host.
> > > >> +
> > > >
> > > > KVM_CAP_GMEM_CONVERSION doesn't get introduced until later, so it seems
> > > > like this flag should be deferred until that patch is in place. Is it
> > > > really needed at that point though? Userspace would be able to set the
> > > > initial state via KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls.
> > > >
> > >
> > > I can move this change to the later patch. Thanks! Will fix in the next
> > > revision.
> > >
> > > > The mtree contents seems to get stored in the same manner in either case so
> > > > performance-wise only the overhead of a few userspace<->kernel switches
> > > > would be saved. Are there any other reasons?
> > > >
> > > > Otherwise, maybe just settle on SHARED as a documented default (since at
> > > > least non-CoCo VMs would be able to reliably benefit) and let
> > > > CoCo/GUEST_MEMFD_FLAG_SUPPORT_SHARED VMs set PRIVATE at whatever
> > > > granularity makes sense for the architecture/guest configuration.
> > > >
> > >
> > > Because shared pages are split once any memory is allocated, having a
> > > way to INIT_PRIVATE could avoid the split and then merge on
> > > conversion. I feel that is enough value to have this config flag, what
> > > do you think?
> > >
> > > I guess we could also have userspace be careful not to do any allocation
> > > before converting.

(Re-visiting this with the assumption that we *don't* intend to use mmap() to
populate memory (in which case you can pretty much ignore my previous
response))

I'm still not sure where the INIT_PRIVATE flag comes into play. For SNP,
userspace already defaults to marking everything private pretty close to
guest_memfd creation time, so the potential for allocations to occur
in-between seems small, but worth confirming.

But I know in the past there was a desire to ensure TDX/SNP could
support pre-allocating guest_memfd memory (and even pre-faulting via
KVM_PRE_FAULT_MEMORY), but I think that could still work right? The
fallocate() handling could still avoid the split if the whole hugepage
is private, though there is a bit more potential for that fallocate()
to happen before userspace does the "manually" shared->private
conversion. I'll double-check on that aspect, but otherwise, is there
still any other need for it?

> >
> > I assume we do want to support things like preallocating guest memory so
> > not sure this approach is feasible to avoid splits.
> >
> > But I feel like we might be working around a deeper issue here, which is
> > that we are pre-emptively splitting anything that *could* be mapped into
> > userspace (i.e. allocated+shared/mixed), rather than splitting when
> > necessary.
> >
> > I know that was the plan laid out in the guest_memfd calls, but I've run
> > into a couple instances that have me thinking we should revisit this.
> >
> > 1) Some of the recent guest_memfd seems to be gravitating towards having
> >    userspace populate/initialize guest memory payload prior to boot via
> >    mmap()'ing the shared guest_memfd pages so things work the same as
> >    they would for initialized normal VM memory payload (rather than
> >    relying on back-channels in the kernel to user data into guest_memfd
> >    pages).
> >
> >    When you do this though, for an SNP guest at least, that memory
> >    acceptance is done in chunks of 4MB (with accept_memory=lazy), and
> >    because that will put each 1GB page into an allocated+mixed state,
> 
> I would like your help in understanding why we need to start
> guest_memfd ranges as shared for SNP guests. guest_memfd ranges being
> private simply should mean that certain ranges are not faultable by
> the userspace.

It's seeming like I probably misremembered, but I thought there was a
discussion on guest_memfd call a month (or so?) ago about whether to
continue to use backchannels to populate guest_memfd pages prior to
launch. It was in the context of whether to keep using kvm_gmem_populate()
for populating guest_memfd pages by copying them in from separate
userspace buffer vs. simply populating them directly from userspace.
I thought we were leaning on the latter since it was simpler all-around,
which is great for SNP since that is already how it populates memory: by
writing to it from userspace, which kvm_gmem_populate() then copies into
guest_memfd pages. With shared gmem support, we just skip the latter now
in the kernel rather needing changes to how userspace handles things in
that regard. But maybe that was just wishful thinking :)

But you raise some very compelling points on why this might not be a
good idea even if that was how that discussion went.

> 
> Will following work?
> 1) Userspace starts all guest_memfd ranges as private.
> 2) During early guest boot it starts issuing PSC requests for
> converting memory from shared to private
>     -> KVM forwards this request to userspace
>     -> Userspace checks that the pages are already private and simply
> does nothing.
> 3) Pvalidate from guest on that memory will result in guest_memfd
> offset query which will cause the RMP table entries to actually get
> populated.

That would work, but there will need to be changes on userspace to deal
with how SNP populates memory pre-boot just like normal VMs do. We will
instead need to copy that data into separate buffers, and pass those in
as the buffer hva instead of the shared hva corresponding to that GPA.

But that seems reasonable if it avoids so many other problems.

> 
> >    we end up splitting every 1GB to 4K and the guest can't even
> >    accept/PVALIDATE it 2MB at that point even if userspace doesn't touch
> >    anything in the range. As some point the guest will convert/accept
> >    the entire range, at which point we could merge, but for SNP we'd
> >    need guest cooperation to actually use a higher-granularity in stage2
> >    page tables at that point since RMP entries are effectively all split
> >    to 4K.
> >
> >    I understand the intent is to default to private where this wouldn't
> >    be an issue, and we could punt to userspace to deal with it, but it
> >    feels like an artificial restriction to place on userspace. And if we
> >    do want to allow/expect guest_memfd contents to be initialized pre-boot
> >    just like normal memory, then userspace would need to jump through
> >    some hoops:
> >
> >    - if defaulting to private: add hooks to convert each range that's being
> >      modified to a shared state prior to writing to it
> 
> Why is that a problem?

These were only problems if we went the above-mentioned way of
populating memory pre-boot via mmap() instead of other backchannels. If
we don't do that, then both these things cease to be problems. Sounds goods
to me. :)

> 
> >    - if defaulting to shared: initialize memory in-place, then covert
> >      everything else to private to avoid unecessarily splitting folios
> >      at run-time
> >
> >    It feels like implementations details are bleeding out into the API
> >    to some degree here (e.g. we'd probably at least need to document
> >    this so users know how to take proper advantage of hugepage support).
> 
> Does it make sense to keep the default behavior as INIT_PRIVATE for
> SNP VMs always even without using hugepages?

Yes!

Though, revisiting discussion around INIT_PRIVATE (without the baggage
of potentially relying on mmap() to populate memory), I'm still not sure why
it's needed. I responded in the context of Ackerley's initial reply
above.

> 
> >
> > 2) There are some use-cases for HugeTLB + CoCo that have come to my
> >    attention recently that put a lot of weight on still being able to
> >    maximize mapping/hugepage size when accessing shared mem from userspace,
> >    e.g. for certain DPDK workloads that accessed shared guest buffers
> >    from host userspace. We don't really have a story for this, and I
> >    wouldn't expect us to at this stage, but I think it ties into #1 so
> >    might be worth considering in that context.
> 
> Major problem I see here is that if anything in the kernel does a GUP
> on shared memory ranges (which is very likely to happen), it would be
> difficult to get them to let go of the whole hugepage before it can be
> split safely.
> 
> Another problem is guest_memfd today doesn't support management of
> large user space page table mappings, this can turnout to be
> significant work to do referring to hugetlb pagetable management
> logic.

Yah that was more line-of-sight that might be possible by going this
route, but the refcount'ing issue above is a showstopper as always. I'd
somehow convinced myself that supporting fine-grained splitting somehow
worked around it, but you still have no idea what page you need to avoid
converting and fancy splitting doesn't get you past that. More wishful
thinking. =\

Thanks,

Mike

> 
> >
> > I'm still fine with the current approach as a starting point, but I'm
> > wondering if improving both #1/#2 might not be so bad and maybe even
> > give us some more flexibility (for instance, Sean had mentioned leaving
> > open the option of tracking more than just shareability/mappability, and
> > if there is split/merge logic associated with those transitions then
> > re-scanning each of these attributes for a 1G range seems like it could
> > benefit from some sort of intermediate data structure to help determine
> > things like what mapping granularity is available for guest/userspace
> > for a particular range.
> >
> > One approach I was thinking of was that we introduce a data structure
> > similar to KVM's memslot->arch.lpage_info() where we store information
> > about what 1G/2M ranges are shared/private/mixed, and then instead of
> > splitting ahead of time we just record that state into this data
> > structure (using the same write lock as with the
> > shareability/mappability state), and then at *fault* time we split the
> > folio if our lpage_info-like data structure says the range is mixed.
> >
> > Then, if guest converts a 2M/4M range to private while lazilly-accepting
> > (for instance), we can still keep the folio intact as 1GB, but mark
> > the 1G range in the lpage_info-like data structure as mixed so that we
> > still inform KVM/etc. they need to map it as 2MB or lower in stage2
> > page tables. In that case, even at guest fault-time, we can leave the
> > folio unsplit until userspace tries to touch it (though in most cases
> > it never will and we can keep most of the guest's 1G intact for the
> > duration of its lifetime).
> >
> > On the userspace side, another nice thing there is if we see 1G is in a
> > mixed state, but 2M is all-shared, then we can still leave the folio as 2M,
> > and I think the refcount'ing logic would still work for the most part,
> > which makes #2 a bit easier to implement as well.
> >
> > And of course, we wouldn't need the INIT_PRIVATE then since we are only
> > splitting when necessary.
> >
> > But I guess this all comes down to how much extra pain there is in
> > tracking a 1G folio that's been split into a mixed of 2MB/4K regions,
> > but I think we'd get a lot more mileage out of getting that working and
> > just completely stripping out all of the merging logic for initial
> > implementation (other than at cleanup time), so maybe complexity-wise
> > it balances out a bit?
> >
> > Thanks,
> >
> > Mike
> >
> > >
> > > >>  See KVM_SET_USER_MEMORY_REGION2 for additional details.
> > > >>
> > > >>  4.143 KVM_PRE_FAULT_MEMORY
> > > >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > > >> index 4cc824a3a7c9..d7df312479aa 100644
> > > >> --- a/include/uapi/linux/kvm.h
> > > >> +++ b/include/uapi/linux/kvm.h
> > > >> @@ -1567,7 +1567,9 @@ struct kvm_memory_attributes {
> > > >>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> > > >>
> > > >>  #define KVM_CREATE_GUEST_MEMFD    _IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
> > > >> +
> > > >>  #define GUEST_MEMFD_FLAG_SUPPORT_SHARED   (1UL << 0)
> > > >> +#define GUEST_MEMFD_FLAG_INIT_PRIVATE     (1UL << 1)
> > > >>
> > > >>  struct kvm_create_guest_memfd {
> > > >>    __u64 size;
> > > >> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > >> index 239d0f13dcc1..590932499eba 100644
> > > >> --- a/virt/kvm/guest_memfd.c
> > > >> +++ b/virt/kvm/guest_memfd.c
> > > >> @@ -4,6 +4,7 @@
> > > >>  #include <linux/falloc.h>
> > > >>  #include <linux/fs.h>
> > > >>  #include <linux/kvm_host.h>
> > > >> +#include <linux/maple_tree.h>
> > > >>  #include <linux/pseudo_fs.h>
> > > >>  #include <linux/pagemap.h>
> > > >>
> > > >> @@ -17,6 +18,24 @@ struct kvm_gmem {
> > > >>    struct list_head entry;
> > > >>  };
> > > >>
> > > >> +struct kvm_gmem_inode_private {
> > > >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > > >> +  struct maple_tree shareability;
> > > >> +#endif
> > > >> +};
> > > >> +
> > > >> +enum shareability {
> > > >> +  SHAREABILITY_GUEST = 1, /* Only the guest can map (fault) folios in this range. */
> > > >> +  SHAREABILITY_ALL = 2,   /* Both guest and host can fault folios in this range. */
> > > >> +};
> > > >> +
> > > >> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index);
> > > >> +
> > > >> +static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
> > > >> +{
> > > >> +  return inode->i_mapping->i_private_data;
> > > >> +}
> > > >> +
> > > >>  /**
> > > >>   * folio_file_pfn - like folio_file_page, but return a pfn.
> > > >>   * @folio: The folio which contains this index.
> > > >> @@ -29,6 +48,58 @@ static inline kvm_pfn_t folio_file_pfn(struct folio *folio, pgoff_t index)
> > > >>    return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
> > > >>  }
> > > >>
> > > >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > > >> +
> > > >> +static int kvm_gmem_shareability_setup(struct kvm_gmem_inode_private *private,
> > > >> +                                loff_t size, u64 flags)
> > > >> +{
> > > >> +  enum shareability m;
> > > >> +  pgoff_t last;
> > > >> +
> > > >> +  last = (size >> PAGE_SHIFT) - 1;
> > > >> +  m = flags & GUEST_MEMFD_FLAG_INIT_PRIVATE ? SHAREABILITY_GUEST :
> > > >> +                                              SHAREABILITY_ALL;
> > > >> +  return mtree_store_range(&private->shareability, 0, last, xa_mk_value(m),
> > > >> +                           GFP_KERNEL);
> > > >
> > > > One really nice thing about using a maple tree is that it should get rid
> > > > of a fairly significant startup delay for SNP/TDX when the entire xarray gets
> > > > initialized with private attribute entries via KVM_SET_MEMORY_ATTRIBUTES
> > > > (which is the current QEMU default behavior).
> > > >
> > > > I'd originally advocated for sticking with the xarray implementation Fuad was
> > > > using until we'd determined we really need it for HugeTLB support, but I'm
> > > > sort of thinking it's already justified just based on the above.
> > > >
> > > > Maybe it would make sense for KVM memory attributes too?
> > > >
> > > >> +}
> > > >> +
> > > >> +static enum shareability kvm_gmem_shareability_get(struct inode *inode,
> > > >> +                                           pgoff_t index)
> > > >> +{
> > > >> +  struct maple_tree *mt;
> > > >> +  void *entry;
> > > >> +
> > > >> +  mt = &kvm_gmem_private(inode)->shareability;
> > > >> +  entry = mtree_load(mt, index);
> > > >> +  WARN(!entry,
> > > >> +       "Shareability should always be defined for all indices in inode.");
> > > >> +
> > > >> +  return xa_to_value(entry);
> > > >> +}
> > > >> +
> > > >> +static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
> > > >> +{
> > > >> +  if (kvm_gmem_shareability_get(inode, index) != SHAREABILITY_ALL)
> > > >> +          return ERR_PTR(-EACCES);
> > > >> +
> > > >> +  return kvm_gmem_get_folio(inode, index);
> > > >> +}
> > > >> +
> > > >> +#else
> > > >> +
> > > >> +static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
> > > >> +{
> > > >> +  return 0;
> > > >> +}
> > > >> +
> > > >> +static inline struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
> > > >> +{
> > > >> +  WARN_ONCE("Unexpected call to get shared folio.")
> > > >> +  return NULL;
> > > >> +}
> > > >> +
> > > >> +#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
> > > >> +
> > > >>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> > > >>                                pgoff_t index, struct folio *folio)
> > > >>  {
> > > >> @@ -333,7 +404,7 @@ static vm_fault_t kvm_gmem_fault_shared(struct vm_fault *vmf)
> > > >>
> > > >>    filemap_invalidate_lock_shared(inode->i_mapping);
> > > >>
> > > >> -  folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> > > >> +  folio = kvm_gmem_get_shared_folio(inode, vmf->pgoff);
> > > >>    if (IS_ERR(folio)) {
> > > >>            int err = PTR_ERR(folio);
> > > >>
> > > >> @@ -420,8 +491,33 @@ static struct file_operations kvm_gmem_fops = {
> > > >>    .fallocate      = kvm_gmem_fallocate,
> > > >>  };
> > > >>
> > > >> +static void kvm_gmem_free_inode(struct inode *inode)
> > > >> +{
> > > >> +  struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
> > > >> +
> > > >> +  kfree(private);
> > > >> +
> > > >> +  free_inode_nonrcu(inode);
> > > >> +}
> > > >> +
> > > >> +static void kvm_gmem_destroy_inode(struct inode *inode)
> > > >> +{
> > > >> +  struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
> > > >> +
> > > >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > > >> +  /*
> > > >> +   * mtree_destroy() can't be used within rcu callback, hence can't be
> > > >> +   * done in ->free_inode().
> > > >> +   */
> > > >> +  if (private)
> > > >> +          mtree_destroy(&private->shareability);
> > > >> +#endif
> > > >> +}
> > > >> +
> > > >>  static const struct super_operations kvm_gmem_super_operations = {
> > > >>    .statfs         = simple_statfs,
> > > >> +  .destroy_inode  = kvm_gmem_destroy_inode,
> > > >> +  .free_inode     = kvm_gmem_free_inode,
> > > >>  };
> > > >>
> > > >>  static int kvm_gmem_init_fs_context(struct fs_context *fc)
> > > >> @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
> > > >>  static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
> > > >>                                                  loff_t size, u64 flags)
> > > >>  {
> > > >> +  struct kvm_gmem_inode_private *private;
> > > >>    struct inode *inode;
> > > >> +  int err;
> > > >>
> > > >>    inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
> > > >>    if (IS_ERR(inode))
> > > >>            return inode;
> > > >>
> > > >> +  err = -ENOMEM;
> > > >> +  private = kzalloc(sizeof(*private), GFP_KERNEL);
> > > >> +  if (!private)
> > > >> +          goto out;
> > > >> +
> > > >> +  mt_init(&private->shareability);
> > > >> +  inode->i_mapping->i_private_data = private;
> > > >> +
> > > >> +  err = kvm_gmem_shareability_setup(private, size, flags);
> > > >> +  if (err)
> > > >> +          goto out;
> > > >> +
> > > >>    inode->i_private = (void *)(unsigned long)flags;
> > > >>    inode->i_op = &kvm_gmem_iops;
> > > >>    inode->i_mapping->a_ops = &kvm_gmem_aops;
> > > >> @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
> > > >>    WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> > > >>
> > > >>    return inode;
> > > >> +
> > > >> +out:
> > > >> +  iput(inode);
> > > >> +
> > > >> +  return ERR_PTR(err);
> > > >>  }
> > > >>
> > > >>  static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
> > > >> @@ -654,6 +769,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
> > > >>    if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
> > > >>            valid_flags |= GUEST_MEMFD_FLAG_SUPPORT_SHARED;
> > > >>
> > > >> +  if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
> > > >> +          valid_flags |= GUEST_MEMFD_FLAG_INIT_PRIVATE;
> > > >> +
> > > >>    if (flags & ~valid_flags)
> > > >>            return -EINVAL;
> > > >>
> > > >> @@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> > > >>    if (!file)
> > > >>            return -EFAULT;
> > > >>
> > > >> +  filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> > > >> +
> > > >
> > > > I like the idea of using a write-lock/read-lock to protect write/read access
> > > > to shareability state (though maybe not necessarily re-using filemap's
> > > > invalidate lock), it's simple and still allows concurrent faulting in of gmem
> > > > pages. One issue on the SNP side (which also came up in one of the gmem calls)
> > > > is if we introduce support for tracking preparedness as discussed (e.g. via a
> > > > new SHAREABILITY_GUEST_PREPARED state) the
> > > > SHAREABILITY_GUEST->SHAREABILITY_GUEST_PREPARED transition would occur at
> > > > fault-time, and so would need to take the write-lock and no longer allow for
> > > > concurrent fault-handling.
> > > >
> > > > I was originally planning on introducing a new rw_semaphore with similar
> > > > semantics to the rw_lock that Fuad previously had in his restricted mmap
> > > > series[1] (and simiar semantics to filemap invalidate lock here). The main
> > > > difference, to handle setting SHAREABILITY_GUEST_PREPARED within fault paths,
> > > > was that in the case of a folio being present for an index, the folio lock would
> > > > also need to be held in order to update the shareability state. Because
> > > > of that, fault paths (which will always either have or allocate folio
> > > > basically) can rely on the folio lock to guard shareability state in a more
> > > > granular way and so can avoid a global write lock.
> > > >
> > > > They would still need to hold the read lock to access the tree however.
> > > > Or more specifically, any paths that could allocate a folio need to take
> > > > a read lock so there isn't a TOCTOU situation where shareability is
> > > > being updated for an index for which a folio hasn't been allocated, but
> > > > then just afterward the folio gets faulted in/allocated while the
> > > > shareability state is already being updated which the understand that
> > > > there was no folio around that needed locking.
> > > >
> > > > I had a branch with in-place conversion support for SNP[2] that added this
> > > > lock reworking on top of Fuad's series along with preparation tracking,
> > > > but I'm now planning to rebase that on top of the patches from this
> > > > series that Sean mentioned[3] earlier:
> > > >
> > > >   KVM: guest_memfd: Add CAP KVM_CAP_GMEM_CONVERSION
> > > >   KVM: Query guest_memfd for private/shared status
> > > >   KVM: guest_memfd: Skip LRU for guest_memfd folios
> > > >   KVM: guest_memfd: Introduce KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
> > > >   KVM: guest_memfd: Introduce and use shareability to guard faulting
> > > >   KVM: guest_memfd: Make guest mem use guest mem inodes instead of anonymous inodes
> > > >
> > > > but figured I'd mention it here in case there are other things to consider on
> > > > the locking front.
> > > >
> > > > Definitely agree with Sean though that it would be nice to start identifying a
> > > > common base of patches for the in-place conversion enablement for SNP, TDX, and
> > > > pKVM so the APIs/interfaces for hugepages can be handled separately.
> > > >
> > > > -Mike
> > > >
> > > > [1] https://lore.kernel.org/kvm/20250328153133.3504118-1-tabba@google.com/
> > > > [2] https://github.com/mdroth/linux/commits/mmap-swprot-v10-snp0-wip2/
> > > > [3] https://lore.kernel.org/kvm/aC86OsU2HSFZkJP6@google.com/
> > > >
> > > >>    folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
> > > >>    if (IS_ERR(folio)) {
> > > >>            r = PTR_ERR(folio);
> > > >> @@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> > > >>            *page = folio_file_page(folio, index);
> > > >>    else
> > > >>            folio_put(folio);
> > > >> -
> > > >>  out:
> > > >> +  filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
> > > >>    fput(file);
> > > >>    return r;
> > > >>  }
> > > >> --
> > > >> 2.49.0.1045.g170613ef41-goog
> > > >>
> > >

