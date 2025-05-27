Return-Path: <linux-fsdevel+bounces-49883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95229AC46F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 05:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C98F3B2AD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 03:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064DB1CDFAC;
	Tue, 27 May 2025 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9UYmB9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C71AF0BB;
	Tue, 27 May 2025 03:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748318284; cv=fail; b=l5UGAbWj02LTex3pAi4GReA6i/oxko9L/I93ctRevHm5eW5GRVic3lMS34WnvTf8YqfhyIGCspdD9ULVdISQMgNVScf58NlSWB2bKnmya9i1vfXEdARrDyHmHJxEO3X6sI3pbGK27ei9PGRVZy6ucm0p13FWCYb31pmTN+7gpzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748318284; c=relaxed/simple;
	bh=SNgPd4XmTvrP603pena9eN9uXZRrMbYYGve25gLqV2k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RJy0Ry2jOAH2b3IiPjR1A5zfQtP/FsjlOXSiQ5n/hShep6jmq4s2WjvWUrSrk1MVyobZy0rhkUKzfPeL9oCwwA0DpzI4aQ+SC2oWFEAfIxgZ8arwCTMyxa4EsZjWyvcjLpbBSuRRxU3yGyBITS2afmrlI/3Vpg+5E2MPdmkx+CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9UYmB9V; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748318282; x=1779854282;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=SNgPd4XmTvrP603pena9eN9uXZRrMbYYGve25gLqV2k=;
  b=G9UYmB9V//0nSlWYVaRN0PbNpQ9eNNVeZvCHz2BxdFrJItX5EWDNzA0i
   epwqaoUOcxsxD9ZQmd8ysgqaA1VWFXbG46vcmulilsyOSgOxiHCGU0UsY
   x2yiHD0sT5C1Bev/8kzQ+oP/nLmVv+EU2KNjYEYk7VB9nGmBRvVstCISL
   jrz31k8iY8AJDP/tVgQw5sfLBbpFpBWmgZhVcQpBEhxuJGqzdrjb585Yz
   K53NdXc79Rm+VoowftHmGdY7OZxFWZcpzd2uLBZMGho1H32OBs5jVVxou
   XZP/hluHFZ9YynY7gQpyN5Ly9yIgLRHvzzsDPcOSZAm9SwW9RTKrcxsX9
   Q==;
X-CSE-ConnectionGUID: fgGbwl2lSniX1sa86NBbgg==
X-CSE-MsgGUID: xNLyqXEfSWWqKj2OpmKP3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="52912160"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="52912160"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 20:58:01 -0700
X-CSE-ConnectionGUID: DGqMyltyTXq3QbtKPJ2fKg==
X-CSE-MsgGUID: wf4r03dTRXKFW9ArxUbX0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="173558118"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 20:58:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 20:58:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 20:58:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.72)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 20:58:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2E16LyMsh2AqUYQ5xnIF/mWXo3HdflorldZgt49HVNEUPx5J4UM+iS+w5poXP+6sevA1a5BcjwYp9Ls46yjxnsg36R/fT7xBsQWgCSGqn6Ibhhw916DSnQJuNiAYsRMnZGifl35BYXvbmWqtZw2DCeH4zwLN04/xCeRxelsylIZlVSjcUh2jbpcUEGe6pQZPhWXne62Tg5dk1KkgpjC4MpjgIZQYfentwCE7hE9hH/8xixNFQYxqOeETNoBpiet72eTsGLLB5TvzrAD0ey5xSNF73epZqGIUkgvGI/fjez5GVyZih7jbfr+nOcEaTscShek6w8Vtv5Rg7zY+4UKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=recnqj/tKj8My/FsOSy5DA+CzOPHKuyVet84YN10YQI=;
 b=cGUxbIch9RtRj0nOaw0x2QshF9lktOB69UwZMw2MBa4v0liJa+ffZYKm8c+cL8+9cK5TWpfSUL285A2LE6P2v3EV3HYA3ikpvAhumdwZj0t0CGTBnUuePDf2CamZAJQ5kJIi/zqM2Q2zHSt3u40NtYrc6Eh1TG5VNzZM6AXfbarq4MHVTMpLC4N1sxCw6ZlGFjsXuOAZPppmYAUVjgR8pOpNjSB0tLbo54RO/Wm0vrlmnA+rim9v2/Etzb1c5J5WEnwrigfmVLaa5Cimg8l9SKzps0/QfhRfiBJBhh17y+2Tc1VsiBVxVgHaGloPHpiH0juIEHM9v4582OBnIzKNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA0PR11MB8355.namprd11.prod.outlook.com (2603:10b6:208:480::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 03:57:52 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 03:57:51 +0000
Date: Tue, 27 May 2025 11:55:16 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
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
	<michael.roth@amd.com>, <mpe@ellerman.id.au>, <muchun.song@linux.dev>,
	<nikunj@amd.com>, <nsaenz@amazon.es>, <oliver.upton@linux.dev>,
	<palmer@dabbelt.com>, <pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <pdurrant@amazon.co.uk>, <peterx@redhat.com>,
	<pgonda@google.com>, <pvorel@suse.cz>, <qperret@google.com>,
	<quic_cvanscha@quicinc.com>, <quic_eberman@quicinc.com>,
	<quic_mnalajal@quicinc.com>, <quic_pderrin@quicinc.com>,
	<quic_pheragu@quicinc.com>, <quic_svaddagi@quicinc.com>,
	<quic_tsoni@quicinc.com>, <richard.weiyang@gmail.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <roypat@amazon.co.uk>,
	<rppt@kernel.org>, <seanjc@google.com>, <shuah@kernel.org>,
	<steven.price@arm.com>, <steven.sistare@oracle.com>,
	<suzuki.poulose@arm.com>, <tabba@google.com>, <thomas.lendacky@amd.com>,
	<usama.arif@bytedance.com>, <vannapurve@google.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yilun.xu@intel.com>, <yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 06/51] KVM: Query guest_memfd for private/shared
 status
Message-ID: <aDU3pN/0FVbowmNH@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <237590b163506821120734a0c8aad95d9c7ef299.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <237590b163506821120734a0c8aad95d9c7ef299.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA0PR11MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a5be00-9e98-4b0b-eb9f-08dd9cd2a6f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3GtH3QT91QYJqw2KKlapjWNyE+tspyx/jnyK5SxXHc/zmxcvxnYggBW7ko0V?=
 =?us-ascii?Q?FIqJW35hcuo9pXrPBmef26PrKFwMpp/Toqyv15Ly6ncRin7b/h/4siCqAZJw?=
 =?us-ascii?Q?wYjduh099UyoLCaRqTfrpXRr3N9y1dAgtURFIi2JakQie9SM0253V1WEq2sj?=
 =?us-ascii?Q?Pcxh0SxNgNRcRDy/6gMYkbzOrEck2j12JDMbuHPCJhDtwi8OGv8S69jkUAQ/?=
 =?us-ascii?Q?tLnAzn6obtJma/tdSW5CLgRsv9mto5f945MFoL45Qj+8Z7Jfe72RpMly1wNf?=
 =?us-ascii?Q?CiPuqMqAmgSM9ja4Gz8YApq8bCFOieb/yQLgvL/iSmXE2wUzXQ7yjgD5Cf3g?=
 =?us-ascii?Q?MmGup64NsDnPIvSDTrXNjjb2TREqGLw0F21upSKgp/YNZTAtEf0Yd3VC5sRY?=
 =?us-ascii?Q?qInm9SRinxKXDnsjnkWdZ2+bHWJRsqcYN9kwIb3ta+lk7TUN/YQxPdWcEUVZ?=
 =?us-ascii?Q?jvOYa+yB30Z3Yj9iCvLkbITBHEU/66ucKcGycllMKVqJJXAOuXRzh1bi9s2I?=
 =?us-ascii?Q?fFLZH2XdiIUu4/fSpjDiyQyKOkmgmUUM/JiHy1IKpG6n2QU7idlUwbdD/0/4?=
 =?us-ascii?Q?YKMIcm/UnBsBkS+hJDmW7wU/d9sjmRlCccSD1MbRG2xHoA43ZwdxRkb9AE+C?=
 =?us-ascii?Q?eJkVDAbpXCHZ/mOkw8szgyTXAx4oTwB69DvY1/oscCGnD3UClnhZMEgToRzt?=
 =?us-ascii?Q?gLD5WurL1xIWjeA6yxk7WBtdFC3bWNpNOX8rHluLOIgbi4eakIf1l1yWccos?=
 =?us-ascii?Q?QFrC3drqWEY98ZSNb+oU/VUROS+2ePrkmRq/aIauLoEUpvVf3qztQ6vxpfR8?=
 =?us-ascii?Q?XB3zaYZr9SLfxg/ya/Dk+EBGXaYPTtN2yUTUdncEdr4Y8u9MTiw2Pb2jqYoM?=
 =?us-ascii?Q?PXgOrkFaTUtUHYi02vwq0Y0tDq5vWdbBuiUF2sMk1OAhprPi30JalpwDb1hT?=
 =?us-ascii?Q?Q4y9FSt2DsblQ5YXBOMkonltYXYTdcF0dpDGMaOW6mkfDBKPpwoz1TSnrN9j?=
 =?us-ascii?Q?AukrBQzU5FGSMo0aBu9gin9Kni/MM8K5KUjOdL+vhL/Td6S2ojvDskFaZeAv?=
 =?us-ascii?Q?mcOJ2aa9Uqw/pyaVmHePHWFziWDPl8BXJIdrcYuOPLrJDxQ7UzF54PPrVc8I?=
 =?us-ascii?Q?T6RRDfqlO6mwIQIexVrkHONgihUJE4xXgJe2ZSlHO0xJY0MGTSOA9V7y3q1k?=
 =?us-ascii?Q?GilFuSzmzYuc+wW8hD367e1h1ghaJWNRndYx00o3H/FD27/cfGWftU+QN6vb?=
 =?us-ascii?Q?+QlrcKYN9NSXyQrskt588B2x60N1uASWJLETZXKFti4MzDJCvNA6LKDLDaMg?=
 =?us-ascii?Q?bC//s7t4Bo+mYdymjmbQd37iwqcDD6mLCnbFV+5xTbyEuqpTpTXa6CChqPS4?=
 =?us-ascii?Q?dKI4CkwO+K5Z7S54lWbEW9Tw1jI8JBkHAbkOPZ1gh4VrZ1PciQbDKNOwqJr/?=
 =?us-ascii?Q?KO5OB0Xod5g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GboFjqp4d/v+eu6GeWnT/iD7L2ardeQ1YLSp0+Q4X/KUTl0UIO8tewe5CUM/?=
 =?us-ascii?Q?hV1O2ScvkXdQO1KqSCDi//Zbgl7GTfSzH7lXwlL2E4UQ7jaVbTbkiYKJylwc?=
 =?us-ascii?Q?QEVSz4NjOnsTl/s2KRZLzRBmL+rcFX7d0ClGK6BwKGG9tfqBbXku2HwWFAzO?=
 =?us-ascii?Q?l8edtYTxHhUfp2NUBzouIjQTkSYSQBHOj3fQ6LVbI1yq67p0rS1lMHhLTv34?=
 =?us-ascii?Q?d0+sw8tCUSh0fmJc/jt6cliEePtBzjusGG0DzyxoYugh6ZWkkNuPCOV1vDv6?=
 =?us-ascii?Q?AmHvCFEV25Jc1SWBH8Lm5Dw5dvaHTHUhSovxl7HvV5H75gjf2PghU2TsZ7YD?=
 =?us-ascii?Q?UXFjM6d2EQl5KNEm44fO9GREjkZljE2OIoU5c8CGiSMeQ63g5oCkWzIS0pkz?=
 =?us-ascii?Q?SZcvwaVxwFaYo7NyTGm4+psL+Q4UlzF8M7HG+xF3DqM2MJt3d9dW9dpe2lIs?=
 =?us-ascii?Q?7so4mnIRhwgYY1LyYfUiWIvMJuboWefnijSGBUxnqhUdImb/LqmpPY/3YaB4?=
 =?us-ascii?Q?qGciAGDrvu11zRzpCof1GKNQngznNYG0pAtXKxqtIGxh8jaCWHPfX9eR7+Yb?=
 =?us-ascii?Q?nSURwQoe1gnPqUvX5d6ah9zxNGPf5rPRLs7aZAl0xzysV6qQb/j4jg11aPJR?=
 =?us-ascii?Q?oLjPAFGBuNdTZtzKF/XjtS19BG0/vsXwxSn3xGyXCbTEecc7Goi+hUjoFpYb?=
 =?us-ascii?Q?XaNDxowKUf5HUETvdH+Yo17LANeHRvvgDPD1BYNWFvMEvh9ry5sLzrEH1QRo?=
 =?us-ascii?Q?gmzOL4OO1It6HF275Bl0qNsaYWbetEXv9x/bvj9sa5BcDpqNJfRrocxBAvQd?=
 =?us-ascii?Q?kYkqnfJtLkLCi7FmjfWAy0FvDrMC8fxQyLADR1xwKeD6js/sr5UB8uo5LRSP?=
 =?us-ascii?Q?nlRlSXMtUNUOmj9PEu0G0Dum/oP9NySmzmHZMtOn9URLVwUBSHO71kZzPRG2?=
 =?us-ascii?Q?a5cBO8yKrI6zbtpxH72AbnUj1CAqgkWYiG6PzrEuDNzbPsGWT2MLCJgJRShe?=
 =?us-ascii?Q?yDeegfmqupqfGggrpCf9lhi8KaqmX1lQdDGY3rFF3rCGKH3a/5BbsXvfzCAz?=
 =?us-ascii?Q?PhzqGxQ2cgIRGnUzVflmKMUWBf5yGOkGHQ7/l2lEPc70By43vGzS3SPCuGI6?=
 =?us-ascii?Q?d7QNKY7Vb9s1qlcYrldBSY6Po5pBsOEBg2bg1xKmqymG8zebC2paWVEHMRCk?=
 =?us-ascii?Q?D2wKkhTdFzxdyrtly5Fp+gPo1Mn8tmfLtq71dSWgNkHXztzWUHOMYVnzDk2N?=
 =?us-ascii?Q?tqEXaKMrn8aj3tognjt4XDBdg06dRy7vo4GlcwCDNyRcl1Aqy/BHKoW0fCYa?=
 =?us-ascii?Q?wkzEW80YxlCPY+mbFa/C8oqfRwpKMy/Uxc2cT1nue/jjldORAsuP5dIyVaji?=
 =?us-ascii?Q?m2DTIItkNoaWVk7SAGgP4YJHGKCcZ5UWQVxnr6nYEJ5ipnSNcMU+bfG/BD5L?=
 =?us-ascii?Q?cUb1I9glwZbrEe9l7DwSFg5JyFYxoJZuokLKydK+g4Xknn3l/WP6WHXsJ7mb?=
 =?us-ascii?Q?AjiznZQHazxpvbokOuECwiV8VLkjr4QRuxBLFmKm4dKAroh4udXbb1qNnpPF?=
 =?us-ascii?Q?QQUO+fZHHV6Oj+ab0CPXuqDSDz8FcAJOM+fMY1v9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a5be00-9e98-4b0b-eb9f-08dd9cd2a6f9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 03:57:51.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFA/tTinLpkOjjXaPaNaD5KIviXNiAk409fJ3nEh+V+ogcmOsaTWVR2pNzk9AKKjygXYpGaRTB4/Qgow7zJDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8355
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:41:45PM -0700, Ackerley Tng wrote:
> Query guest_memfd for private/shared status if those guest_memfds
> track private/shared status.
> 
> With this patch, Coco VMs can use guest_memfd for both shared and
> private memory. If Coco VMs choose to use guest_memfd for both
> shared and private memory, by creating guest_memfd with the
> GUEST_MEMFD_FLAG_SUPPORT_SHARED flag, guest_memfd will be used to
> provide the private/shared status of the memory, instead of
> kvm->mem_attr_array.
> 
> Change-Id: I8f23d7995c12242aa4e09ccf5ec19360e9c9ed83
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  include/linux/kvm_host.h | 19 ++++++++++++-------
>  virt/kvm/guest_memfd.c   | 22 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index b317392453a5..91279e05e010 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2508,12 +2508,22 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
>  }
>  
>  #ifdef CONFIG_KVM_GMEM_SHARED_MEM
> +
>  bool kvm_gmem_memslot_supports_shared(const struct kvm_memory_slot *slot);
> +bool kvm_gmem_is_private(struct kvm_memory_slot *slot, gfn_t gfn);
> +
>  #else
> +
>  static inline bool kvm_gmem_memslot_supports_shared(const struct kvm_memory_slot *slot)
>  {
>  	return false;
>  }
> +
> +static inline bool kvm_gmem_is_private(struct kvm_memory_slot *slot, gfn_t gfn)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
>  
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> @@ -2544,13 +2554,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  		return false;
>  
>  	slot = gfn_to_memslot(kvm, gfn);
> -	if (kvm_slot_has_gmem(slot) && kvm_gmem_memslot_supports_shared(slot)) {
> -		/*
> -		 * For now, memslots only support in-place shared memory if the
> -		 * host is allowed to mmap memory (i.e., non-Coco VMs).
> -		 */
> -		return false;
> -	}
> +	if (kvm_slot_has_gmem(slot) && kvm_gmem_memslot_supports_shared(slot))
> +		return kvm_gmem_is_private(slot, gfn);
When userspace gets an exit reason KVM_EXIT_MEMORY_FAULT, looks it needs to
update both KVM memory attribute and gmem shareability, via two separate ioctls?


>  	return kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;

>  }
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 6f6c4d298f8f..853e989bdcb2 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -865,6 +865,28 @@ bool kvm_gmem_memslot_supports_shared(const struct kvm_memory_slot *slot)
>  }
>  EXPORT_SYMBOL_GPL(kvm_gmem_memslot_supports_shared);
>  
> +bool kvm_gmem_is_private(struct kvm_memory_slot *slot, gfn_t gfn)
> +{
> +	struct inode *inode;
> +	struct file *file;
> +	pgoff_t index;
> +	bool ret;
> +
> +	file = kvm_gmem_get_file(slot);
> +	if (!file)
> +		return false;
> +
> +	index = kvm_gmem_get_index(slot, gfn);
> +	inode = file_inode(file);
> +
> +	filemap_invalidate_lock_shared(inode->i_mapping);
> +	ret = kvm_gmem_shareability_get(inode, index) == SHAREABILITY_GUEST;
> +	filemap_invalidate_unlock_shared(inode->i_mapping);
> +
> +	fput(file);
> +	return ret;
> +}
> +
>  #else
>  #define kvm_gmem_mmap NULL
>  #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
> -- 
> 2.49.0.1045.g170613ef41-goog
> 

