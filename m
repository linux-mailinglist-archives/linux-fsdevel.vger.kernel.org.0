Return-Path: <linux-fsdevel+bounces-49885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A7AC473A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 06:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A6E3B64E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 04:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6DA1A3159;
	Tue, 27 May 2025 04:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsJN2yJr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52155442C;
	Tue, 27 May 2025 04:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748320389; cv=fail; b=O9P9wfzQ9xAokRuYkTdaCfeW/fGsvnpc/nNRa0XjHCP02Gx5ntU8Y5/7AZF7AMUfCr7gk3zgeKllYBxO6xx7E6S4iCzP5WaCNh/HODRAP3bx9+2LnjqA+y7NB8QTtSgsAycuULsm7dPPAaxEHhQvzh0Jy0EVf/17xVIfrk87GYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748320389; c=relaxed/simple;
	bh=PaMf/GOdt3yFrLuzB8E1+cvFaXZzc8VMsoAYqy24bSc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JAmG7mwcMjd8BoVdpAa1cI+VH6m0RyVdRoWm/8SgPvKkRVhpWwlxYANhEozpLkvZUcLNhcaGyAetcQ1Fms+dyTEBFiCMaQpxxY8Sf1QbYFOIN74bpes1gV/8TGKVblvYZlmnGxp9P4YqVh277SGf2dFnyzmUbH1KW12c6LQmJ5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsJN2yJr; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748320387; x=1779856387;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=PaMf/GOdt3yFrLuzB8E1+cvFaXZzc8VMsoAYqy24bSc=;
  b=FsJN2yJrz/wVyz6zXr07HldK7seJr2MHxoiYIP/fr9SOIRhj/SQZ3G1X
   uueqx1EbeDjSqP4kCKknO9QivY6oR88uu+4yfvmXvh4/kIa9Zen0LepSP
   5uqQTQ+vD9v9wx0eWUH5dRF0Stmr/fpoe+U7ILg+eUwCzUOvNPQo7+8V/
   oGWSqTzGtLwjfeYbFHA6LgLubd4bMK7cU7cqt6FHvjR4r9ovdDDkZqwDo
   aH68cPt2i4gDMatKYr1CJklxucwOmOKQy7c1abJcuhCYne/GZeM6V8h4G
   MvdS6qtdyFC4wgo/JuMvWhIPLD3xeFsBNVFsxBo0jQhTlbLRtbUxnKfPU
   Q==;
X-CSE-ConnectionGUID: wAbRq3B0TIuSLAjM+DhmAg==
X-CSE-MsgGUID: UHL0JMW8SAaPGFpHUFPOuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50292491"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="50292491"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 21:33:05 -0700
X-CSE-ConnectionGUID: WK5Iy1zeSGi9lZxUNoGZ4g==
X-CSE-MsgGUID: 258hafC9TRiuvyP87C8lGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="142588509"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 21:33:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 21:33:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 21:33:04 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.89)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 21:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpghqYCkOR7xAhRMb7UuLZQIB0Pmaj3aRI5THN7fxkX5auWnULHZ1iAWerRghD+AoEMWJ5l8eMQ3Yg5o6X446tRCGz/jYzNpuingjCFaiBga1lHgjV78+qDUguCO/voGW8FmQ3nkJVIea69RlnKwmswD+OHF6AWdsMWRXh11+b/MSdb7M+/ZZcoFbNrNuinRGAHGpUH6U0zd6bZRT1aDwzXaA6T2mYxaLOhPHO3lrzJGbiGp9eoAaLwoTnclnPhH9ACzCxeism69O1nUpBHgsFe2dHZdduOhrCVHzSZbKL7GydDIpCqe3bkFpllDoYjf1D0giAfObCk/nCmC1tB5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYFWgd9C2tlLz3ZC/1pSgZa+xnRD/AgnhJA7+ZZoCPI=;
 b=J8irs112iqRT2DV2fUurPciYEu+gCnZzX9osStRZTJMN7ODWOWlNyUmT4zosEsUXW/BnaicHxBDl8BUfYDsLk66yPCOMx1U9eBJJYzhNIDz/RtujanEk+TpdRAlBzdi0pRlnbwoLVrUH497MASn/s2+UFhxpK7JcrwbML4QcRhSbGuPOGFxqTGVZaPls0wj+2EoFa4Y5iUM189COL8f1Jz0YX6g5WfOqcOs4pTmAKvBss1WAk1pR1xn+tKh5GWbqIB+9g2VXeIEpXHyURf68tuHPl2ZMeQeqEoBaw+lqDedCsOrY1rH8hWttUhoBjOJAwRFAW/VnFBknCLP7fSVTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SJ5PPF183C9380E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::815) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 04:32:46 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 04:32:46 +0000
Date: Tue, 27 May 2025 12:30:11 +0800
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
Subject: Re: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
Message-ID: <aDU/0+XLZKv5kae7@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SJ5PPF183C9380E:EE_
X-MS-Office365-Filtering-Correlation-Id: e6830692-8b87-49bd-e80f-08dd9cd7876f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vm7GomJA1LgTjtT8JjxHVEEg6m8jcGUCAaGcPUAFmTmn+YZs5DKRqZR/gRlY?=
 =?us-ascii?Q?VabSI/q9946DiBnrcU7U8ZdMdSr5qJLqy7/G2a6ACaWxvFNSYYqvrXcKBa4V?=
 =?us-ascii?Q?Wb0VpIqOCKHT2f1WZZurS0MrgqmZ44ExkFUC0d+VoKCRKO+P7gOvDaNVaLXi?=
 =?us-ascii?Q?ORZ6vB7SgutKTRQzAmz+9S4MezP9dApKtTaPHVMVcfdwFg2i8wHM2Jl9AaWh?=
 =?us-ascii?Q?LalOfFfIBwROsB5AXc0Y2BWCQO1oYxkwRBK0DZKRWpx5lLBtl5SkYrBKIQ92?=
 =?us-ascii?Q?18uSlVggVIMWf5OYN3JmEyDAGF5LpX8PoEx7IgVKRjdxh1ogKR3eZSnT2iQg?=
 =?us-ascii?Q?/EovizWcf/YSOeyAFNc7Kg7JcZTMvl4kGfvS82LQMkIOaQhDf+oaQFMDWlPC?=
 =?us-ascii?Q?cWnOFYHQYtjeCZRjFxf7mbP33Lqbd0xDjxgzGdXDL9OiF91UemifDyGVo0H+?=
 =?us-ascii?Q?tfVQWmFSCOg0MvNwjz2OUHc2DHp9Zg4WdudRbS0wOAw/CF+jgYZQhS8i3/IF?=
 =?us-ascii?Q?k7XDWg5bH3dgWKfCX9A1ZYR8oTahSBNy837TDV46+EiIyRpbg+xsDxc+6ZGu?=
 =?us-ascii?Q?z/sn1H79FtiEQP061x4RFeNvZnjncm+HkDvnzMPJxPTfLLpaN+KmdobGdQrw?=
 =?us-ascii?Q?YgHM8azLI7KvxYrbr/fdgmzOe8s7XrEVVuXhwz07qQaXe+BRdj0WCLOR2BcR?=
 =?us-ascii?Q?DIJVW+M2Byyud+4FOAhkJAYjHbAmbcAiuX+XGy79W7TbM9dXzRD6dVFYteII?=
 =?us-ascii?Q?tOHPtcbs3TvxAo1PSzhyiT5AP/U4Sye4wXM06iVeL4xn/QB2ImSywgQxFyVp?=
 =?us-ascii?Q?P2PS+NP+pHqE5XrBYXX6laVHT5ye2TINLiwcLoDqlhIHYBZJrb8ecCv/a71D?=
 =?us-ascii?Q?vRGyKZDZKeU0tJVgelQRpY0gMy6LhwYrDs9trVDAsqldr914aR9mkLN2i0IQ?=
 =?us-ascii?Q?sXG5UrQrL72Ti1XSj2T6ScwRgLH+vLuL77OBLU8k51aSEEufEmc7qCPJUOYg?=
 =?us-ascii?Q?V0nw7kfmFBtQX8GJsSkr/0Znu4UeGaEw1A9fJThy//gHbLUf4GDJqyanQjRs?=
 =?us-ascii?Q?RGcsxNQ79wwk6tHKY2KU5e5kRCh7eCs+okyX2itkEeQGM++hduz6NhCvFXx1?=
 =?us-ascii?Q?dIseE1CbfJxadCPFklJ5o20lqrxhCKqze6ijlCdh6Kz82Zn5RGhXZaaJNxMa?=
 =?us-ascii?Q?taNKToxXK8+Azv7f95nixE3j4+MT4IaFb68tOYVNhZ4YaIGtQOTMjLfkuV9h?=
 =?us-ascii?Q?LgpHylPC0TOXczIrp6PY86dYQ1gi6TPvkQHDFGu9s/c4omjTggwOWgRLjJsf?=
 =?us-ascii?Q?tmCHXzgKYEHdMzAfst0AOQmtiKKB3eGK3tRmu6apytPZeFO7Hjt4sxlwG4FL?=
 =?us-ascii?Q?Kv1891uAQOCvQvtTaGMPrTBtgE9g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SDVRO4Pt7DBfJZpjyOHSiZt6YRHxbkhSWiNoh4TAtt8ZTtPdQ+cYTrEMdRPS?=
 =?us-ascii?Q?vN1wMBHEJirGEW4jSvYuQHjeSSkOz7OQzgxWzrm5Dcmc8f3sB66wGgG+rZqo?=
 =?us-ascii?Q?BkOU90pfpafxSbHK2YdETlpd2UhwajAU06rj/2YWwSLSUzXim2qXAHBbmr7S?=
 =?us-ascii?Q?uE/9VGYABmPMDtJP86RfsdGxM8QWWNWATN6dQQt3D4ED41OmMEBng+b8J8ED?=
 =?us-ascii?Q?auARXei9G6UVpNelpB4rlZMvpuPl3S4OzUwjprBwkB2IhnA4yXuzuHh8Ft7L?=
 =?us-ascii?Q?fJp4bHsgvKzwk+LfDAtOW9FyZXMDorsoqElK00OT6bEKbRXNB+e4llq3tgXo?=
 =?us-ascii?Q?2rNE82lqGorr21Dbj3nHvFAwReBqlJ5WMfvBADhOPXMbp/YA5oje/CrH9LCr?=
 =?us-ascii?Q?Is9RdAt56mD7nnwSvHQ7wCmIVif1cdEBq3UfbFYEz5iDGi9ORz63lkYM/IDa?=
 =?us-ascii?Q?qRMZrvBzssPyyiFqbNTLKBvKsY9Mt9MWzeBCLaIhSVMR1z6gaacE+7hc8JD5?=
 =?us-ascii?Q?URMyRQGXfKcLfnhKti6UCcsv2vgWxpkDt9MKRRiRgLAoh//xcQHRC5NDaQdP?=
 =?us-ascii?Q?lYORNjgfxujfteQKUF2a+MYQQ5NcBbfQrf9QDu8S04h59aEkBLssi42Hw+/k?=
 =?us-ascii?Q?rgR0pwIWxW3QwdBrukOS/PibjZLUsVY105jTDW23rNsGgbvmQr3ZaRrabN/D?=
 =?us-ascii?Q?PTCTQr8sEeRFMIvt+B50pdDibBMaalMIW3e8PQfZ0jd8BnhHwtWkWtKzo2bn?=
 =?us-ascii?Q?hiOLXGQJharFwceeBnku+3paExXqc4hihI5dYxwl2+TXp7lx500yjQ6TwAbZ?=
 =?us-ascii?Q?BNhUCSHvEltT3enIFHumzP6gKw2RXAmilzy+fNeUMaivhizaY/muB5UqCeAu?=
 =?us-ascii?Q?LCQkCeLhLT4oTDbbreyRdHRD80SHDPt5bpJxIYAC2urVNJ9T0bjW95kkzKy4?=
 =?us-ascii?Q?2tTNGugrMoBKtQZLtQTX5wQ3JHhYLTmCJjV2HPCe7CqlHFhFKWdE/JiSkZCf?=
 =?us-ascii?Q?codvBm79P1rWAM/MQhY4fzFakpnYSJpzZC3P4RaSFc8lwf99TFl9CiixFjpU?=
 =?us-ascii?Q?XlS4XsoIjE8or7nkG5yWKMc0DQt9oMt7XFJXNWQ78IDwt+tqWPZ4jxldNBxW?=
 =?us-ascii?Q?ePvwJMvJfDXKlEOPjOWIH3NaFBTv8evsgdISsZ7VMDX2JfDOr82hxvtNi1KJ?=
 =?us-ascii?Q?3V0fkC98QjdkefNFkFrOswTOCUVMdPYrhxeuwGp4MV7p+/pQ3HD8U1imI+ui?=
 =?us-ascii?Q?JN5Td4CddhsVriV2bvtNw/C0yH4La7VgU2UTw7dR5OBN9B1yiq4T3Mkt8ow7?=
 =?us-ascii?Q?Gz12M8GWAGcO1qUFdY++6YvZygfQUg3bTsSz2D9AMk83krpRmf3bTna5VNjk?=
 =?us-ascii?Q?2WEKWvOVjvNv2C6o5+KUXSYP3/POIcVDP8b8OZmqWsWIe6bhXHlS911jN/XK?=
 =?us-ascii?Q?MWgc3/cCCLXQXR8zK7Gy81sSjiVwbgsNd1gskmHXPDAtZe93aM1P8i2CgP4F?=
 =?us-ascii?Q?Bcd5GY1LrmHMlZjx3JlNFUiARUudiol30w/PmPXUnWtO531b2W4tjt1kSq06?=
 =?us-ascii?Q?TPE2XZVNplJaf806RDKK3ixv4m68eqCnaf8DAR6X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6830692-8b87-49bd-e80f-08dd9cd7876f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 04:32:46.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qz0sBoX+yTuIbfAvj/jG41iBZel15w5md63yIcOOOZ64nUlV0xay3znGbfj+F8g0SEE0io/K6933vDD0WRXKbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183C9380E
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:42:17PM -0700, Ackerley Tng wrote:
> In this patch, newly allocated pages are split to 4K regular pages
> before providing them to the requester (fallocate() or KVM).
> 
> During a private to shared conversion, folios are split if not already
> split.
> 
> During a shared to private conversion, folios are merged if not
> already merged.
> 
> When the folios are removed from the filemap on truncation, the
> allocator is given a chance to do any necessary prep for when the
> folio is freed.
> 
> When a conversion is requested on a subfolio within a hugepage range,
> faulting must be prevented on the whole hugepage range for
> correctness.
> 
> See related discussion at
> https://lore.kernel.org/all/Z__AAB_EFxGFEjDR@google.com/T/
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Change-Id: Ib5ee22e3dae034c529773048a626ad98d4b10af3
> ---
>  mm/filemap.c           |   2 +
>  virt/kvm/guest_memfd.c | 501 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 483 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a02c3d8e00e8..a052f8e0c41e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -223,6 +223,7 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
>  	filemap_unaccount_folio(mapping, folio);
>  	page_cache_delete(mapping, folio, shadow);
>  }
> +EXPORT_SYMBOL_GPL(__filemap_remove_folio);
>  
>  void filemap_free_folio(struct address_space *mapping, struct folio *folio)
>  {
> @@ -258,6 +259,7 @@ void filemap_remove_folio(struct folio *folio)
>  
>  	filemap_free_folio(mapping, folio);
>  }
> +EXPORT_SYMBOL_GPL(filemap_remove_folio);
>  
>  /*
>   * page_cache_delete_batch - delete several folios from page cache
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index c578d0ebe314..cb426c1dfef8 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -41,6 +41,11 @@ static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
>  				      pgoff_t end);
>  static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
>  				    pgoff_t end);
> +static int __kvm_gmem_filemap_add_folio(struct address_space *mapping,
> +					struct folio *folio, pgoff_t index);
> +static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
> +						pgoff_t start, size_t nr_pages,
> +						bool is_split_operation);
>  
>  static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
>  {
> @@ -126,6 +131,31 @@ static enum shareability kvm_gmem_shareability_get(struct inode *inode,
>  	return xa_to_value(entry);
>  }
>  
> +static bool kvm_gmem_shareability_in_range(struct inode *inode, pgoff_t start,
> +					    size_t nr_pages, enum shareability m)
> +{
> +	struct maple_tree *mt;
> +	pgoff_t last;
> +	void *entry;
> +
> +	mt = &kvm_gmem_private(inode)->shareability;
> +
> +	last = start + nr_pages - 1;
> +	mt_for_each(mt, entry, start, last) {
> +		if (xa_to_value(entry) == m)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static inline bool kvm_gmem_has_some_shared(struct inode *inode, pgoff_t start,
> +					    size_t nr_pages)
> +{
> +	return kvm_gmem_shareability_in_range(inode, start, nr_pages,
> +					     SHAREABILITY_ALL);
> +}
> +
>  static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
>  {
>  	if (kvm_gmem_shareability_get(inode, index) != SHAREABILITY_ALL)
> @@ -241,6 +271,105 @@ static bool kvm_gmem_has_safe_refcount(struct address_space *mapping, pgoff_t st
>  	return refcount_safe;
>  }
>  
> +static void kvm_gmem_unmap_private(struct kvm_gmem *gmem, pgoff_t start,
> +				   pgoff_t end)
> +{
> +	struct kvm_memory_slot *slot;
> +	struct kvm *kvm = gmem->kvm;
> +	unsigned long index;
> +	bool locked = false;
> +	bool flush = false;
> +
> +	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
> +		pgoff_t pgoff = slot->gmem.pgoff;
> +
> +		struct kvm_gfn_range gfn_range = {
> +			.start = slot->base_gfn + max(pgoff, start) - pgoff,
> +			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
> +			.slot = slot,
> +			.may_block = true,
> +			/* This function is only concerned with private mappings. */
> +			.attr_filter = KVM_FILTER_PRIVATE,
> +		};
> +
> +		if (!locked) {
> +			KVM_MMU_LOCK(kvm);
> +			locked = true;
> +		}
> +
> +		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> +	}
> +
> +	if (flush)
> +		kvm_flush_remote_tlbs(kvm);
> +
> +	if (locked)
> +		KVM_MMU_UNLOCK(kvm);
> +}
> +
> +static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> +				      pgoff_t end)
> +{
> +	struct kvm_memory_slot *slot;
> +	struct kvm *kvm = gmem->kvm;
> +	unsigned long index;
> +	bool found_memslot;
> +
> +	found_memslot = false;
> +	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
> +		gfn_t gfn_start;
> +		gfn_t gfn_end;
> +		pgoff_t pgoff;
> +
> +		pgoff = slot->gmem.pgoff;
> +
> +		gfn_start = slot->base_gfn + max(pgoff, start) - pgoff;
> +		gfn_end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff;
> +		if (!found_memslot) {
> +			found_memslot = true;
> +
> +			KVM_MMU_LOCK(kvm);
> +			kvm_mmu_invalidate_begin(kvm);
> +		}
> +
> +		kvm_mmu_invalidate_range_add(kvm, gfn_start, gfn_end);
> +	}
> +
> +	if (found_memslot)
> +		KVM_MMU_UNLOCK(kvm);
> +}
> +
> +static pgoff_t kvm_gmem_compute_invalidate_bound(struct inode *inode,
> +						 pgoff_t bound, bool start)
> +{
> +	size_t nr_pages;
> +	void *priv;
> +
> +	if (!kvm_gmem_has_custom_allocator(inode))
> +		return bound;
> +
> +	priv = kvm_gmem_allocator_private(inode);
> +	nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> +
> +	if (start)
> +		return round_down(bound, nr_pages);
> +	else
> +		return round_up(bound, nr_pages);
> +}
> +
> +static pgoff_t kvm_gmem_compute_invalidate_start(struct inode *inode,
> +						 pgoff_t bound)
> +{
> +	return kvm_gmem_compute_invalidate_bound(inode, bound, true);
> +}
> +
> +static pgoff_t kvm_gmem_compute_invalidate_end(struct inode *inode,
> +					       pgoff_t bound)
> +{
> +	return kvm_gmem_compute_invalidate_bound(inode, bound, false);
> +}
> +
>  static int kvm_gmem_shareability_apply(struct inode *inode,
>  				       struct conversion_work *work,
>  				       enum shareability m)
> @@ -299,35 +428,53 @@ static void kvm_gmem_convert_invalidate_begin(struct inode *inode,
>  					      struct conversion_work *work)
>  {
>  	struct list_head *gmem_list;
> +	pgoff_t invalidate_start;
> +	pgoff_t invalidate_end;
>  	struct kvm_gmem *gmem;
> -	pgoff_t end;
> +	pgoff_t work_end;
>  
> -	end = work->start + work->nr_pages;
> +	work_end = work->start + work->nr_pages;
> +	invalidate_start = kvm_gmem_compute_invalidate_start(inode, work->start);
> +	invalidate_end = kvm_gmem_compute_invalidate_end(inode, work_end);
Could we just notify the exact gfn range and let KVM adjust the invalidate
range?

Then kvm_gmem_invalidate_begin() can asks KVM to do EPT splitting before any
kvm_mmu_unmap_gfn_range() is performed.


>  	gmem_list = &inode->i_mapping->i_private_list;
>  	list_for_each_entry(gmem, gmem_list, entry)
> -		kvm_gmem_invalidate_begin(gmem, work->start, end);
> +		kvm_gmem_invalidate_begin(gmem, invalidate_start, invalidate_end);
>  }
>  
>  static void kvm_gmem_convert_invalidate_end(struct inode *inode,
>  					    struct conversion_work *work)
>  {
>  	struct list_head *gmem_list;
> +	pgoff_t invalidate_start;
> +	pgoff_t invalidate_end;
>  	struct kvm_gmem *gmem;
> -	pgoff_t end;
> +	pgoff_t work_end;
>  
> -	end = work->start + work->nr_pages;
> +	work_end = work->start + work->nr_pages;
> +	invalidate_start = kvm_gmem_compute_invalidate_start(inode, work->start);
> +	invalidate_end = kvm_gmem_compute_invalidate_end(inode, work_end);
>  
>  	gmem_list = &inode->i_mapping->i_private_list;
>  	list_for_each_entry(gmem, gmem_list, entry)
> -		kvm_gmem_invalidate_end(gmem, work->start, end);
> +		kvm_gmem_invalidate_end(gmem, invalidate_start, invalidate_end);
>  }
>  
>  static int kvm_gmem_convert_should_proceed(struct inode *inode,
>  					   struct conversion_work *work,
>  					   bool to_shared, pgoff_t *error_index)
>  {
> -	if (!to_shared) {
> +	if (to_shared) {
> +		struct list_head *gmem_list;
> +		struct kvm_gmem *gmem;
> +		pgoff_t work_end;
> +
> +		work_end = work->start + work->nr_pages;
> +
> +		gmem_list = &inode->i_mapping->i_private_list;
> +		list_for_each_entry(gmem, gmem_list, entry)
> +			kvm_gmem_unmap_private(gmem, work->start, work_end);
> +	} else {
>  		unmap_mapping_pages(inode->i_mapping, work->start,
>  				    work->nr_pages, false);
>  
> @@ -340,6 +487,27 @@ static int kvm_gmem_convert_should_proceed(struct inode *inode,
>  	return 0;
>  }
>  
> +static int kvm_gmem_convert_execute_work(struct inode *inode,
> +					 struct conversion_work *work,
> +					 bool to_shared)
> +{
> +	enum shareability m;
> +	int ret;
> +
> +	m = to_shared ? SHAREABILITY_ALL : SHAREABILITY_GUEST;
> +	ret = kvm_gmem_shareability_apply(inode, work, m);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Apply shareability first so split/merge can operate on new
> +	 * shareability state.
> +	 */
> +	ret = kvm_gmem_restructure_folios_in_range(
> +		inode, work->start, work->nr_pages, to_shared);
> +
> +	return ret;
> +}
> +
>  static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
>  				  size_t nr_pages, bool shared,
>  				  pgoff_t *error_index)
> @@ -371,18 +539,21 @@ static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
>  
>  	list_for_each_entry(work, &work_list, list) {
>  		rollback_stop_item = work;
> -		ret = kvm_gmem_shareability_apply(inode, work, m);
> +
> +		ret = kvm_gmem_convert_execute_work(inode, work, shared);
>  		if (ret)
>  			break;
>  	}
>  
>  	if (ret) {
> -		m = shared ? SHAREABILITY_GUEST : SHAREABILITY_ALL;
>  		list_for_each_entry(work, &work_list, list) {
> +			int r;
> +
> +			r = kvm_gmem_convert_execute_work(inode, work, !shared);
> +			WARN_ON(r);
> +
>  			if (work == rollback_stop_item)
>  				break;
> -
> -			WARN_ON(kvm_gmem_shareability_apply(inode, work, m));
>  		}
>  	}
>  
> @@ -434,6 +605,277 @@ static int kvm_gmem_ioctl_convert_range(struct file *file,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_KVM_GMEM_HUGETLB
> +
> +static inline void __filemap_remove_folio_for_restructuring(struct folio *folio)
> +{
> +	struct address_space *mapping = folio->mapping;
> +
> +	spin_lock(&mapping->host->i_lock);
> +	xa_lock_irq(&mapping->i_pages);
> +
> +	__filemap_remove_folio(folio, NULL);
> +
> +	xa_unlock_irq(&mapping->i_pages);
> +	spin_unlock(&mapping->host->i_lock);
> +}
> +
> +/**
> + * filemap_remove_folio_for_restructuring() - Remove @folio from filemap for
> + * split/merge.
> + *
> + * @folio: the folio to be removed.
> + *
> + * Similar to filemap_remove_folio(), but skips LRU-related calls (meaningless
> + * for guest_memfd), and skips call to ->free_folio() to maintain folio flags.
> + *
> + * Context: Expects only the filemap's refcounts to be left on the folio. Will
> + *          freeze these refcounts away so that no other users will interfere
> + *          with restructuring.
> + */
> +static inline void filemap_remove_folio_for_restructuring(struct folio *folio)
> +{
> +	int filemap_refcount;
> +
> +	filemap_refcount = folio_nr_pages(folio);
> +	while (!folio_ref_freeze(folio, filemap_refcount)) {
> +		/*
> +		 * At this point only filemap refcounts are expected, hence okay
> +		 * to spin until speculative refcounts go away.
> +		 */
> +		WARN_ONCE(1, "Spinning on folio=%p refcount=%d", folio, folio_ref_count(folio));
> +	}
> +
> +	folio_lock(folio);
> +	__filemap_remove_folio_for_restructuring(folio);
> +	folio_unlock(folio);
> +}
> +
> +/**
> + * kvm_gmem_split_folio_in_filemap() - Split @folio within filemap in @inode.
> + *
> + * @inode: inode containing the folio.
> + * @folio: folio to be split.
> + *
> + * Split a folio into folios of size PAGE_SIZE. Will clean up folio from filemap
> + * and add back the split folios.
> + *
> + * Context: Expects that before this call, folio's refcount is just the
> + *          filemap's refcounts. After this function returns, the split folios'
> + *          refcounts will also be filemap's refcounts.
> + * Return: 0 on success or negative error otherwise.
> + */
> +static int kvm_gmem_split_folio_in_filemap(struct inode *inode, struct folio *folio)
> +{
> +	size_t orig_nr_pages;
> +	pgoff_t orig_index;
> +	size_t i, j;
> +	int ret;
> +
> +	orig_nr_pages = folio_nr_pages(folio);
> +	if (orig_nr_pages == 1)
> +		return 0;
> +
> +	orig_index = folio->index;
> +
> +	filemap_remove_folio_for_restructuring(folio);
> +
> +	ret = kvm_gmem_allocator_ops(inode)->split_folio(folio);
> +	if (ret)
> +		goto err;
> +
> +	for (i = 0; i < orig_nr_pages; ++i) {
> +		struct folio *f = page_folio(folio_page(folio, i));
> +
> +		ret = __kvm_gmem_filemap_add_folio(inode->i_mapping, f,
> +						   orig_index + i);
> +		if (ret)
> +			goto rollback;
> +	}
> +
> +	return ret;
> +
> +rollback:
> +	for (j = 0; j < i; ++j) {
> +		struct folio *f = page_folio(folio_page(folio, j));
> +
> +		filemap_remove_folio_for_restructuring(f);
> +	}
> +
> +	kvm_gmem_allocator_ops(inode)->merge_folio(folio);
> +err:
> +	WARN_ON(__kvm_gmem_filemap_add_folio(inode->i_mapping, folio, orig_index));
> +
> +	return ret;
> +}
> +
> +static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
> +						      struct folio *folio)
> +{
> +	size_t to_nr_pages;
> +	void *priv;
> +
> +	if (!kvm_gmem_has_custom_allocator(inode))
> +		return 0;
> +
> +	priv = kvm_gmem_allocator_private(inode);
> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_page(priv);
> +
> +	if (kvm_gmem_has_some_shared(inode, folio->index, to_nr_pages))
If the guest_memfd is configured with GUESTMEM_HUGETLB_FLAG_1GB, it seems that
whenever there's a shared page within a 1GB range, the folio will always be
split into 4KB folios. Is it good?

> +		return kvm_gmem_split_folio_in_filemap(inode, folio);
> +
> +	return 0;
> +}
> +
> +/**
> + * kvm_gmem_merge_folio_in_filemap() - Merge @first_folio within filemap in
> + * @inode.
> + *
> + * @inode: inode containing the folio.
> + * @first_folio: first folio among folios to be merged.
> + *
> + * Will clean up subfolios from filemap and add back the merged folio.
> + *
> + * Context: Expects that before this call, all subfolios only have filemap
> + *          refcounts. After this function returns, the merged folio will only
> + *          have filemap refcounts.
> + * Return: 0 on success or negative error otherwise.
> + */
> +static int kvm_gmem_merge_folio_in_filemap(struct inode *inode,
> +					   struct folio *first_folio)
> +{
> +	size_t to_nr_pages;
> +	pgoff_t index;
> +	void *priv;
> +	size_t i;
> +	int ret;
> +
> +	index = first_folio->index;
> +
> +	priv = kvm_gmem_allocator_private(inode);
> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> +	if (folio_nr_pages(first_folio) == to_nr_pages)
> +		return 0;
> +
> +	for (i = 0; i < to_nr_pages; ++i) {
> +		struct folio *f = page_folio(folio_page(first_folio, i));
> +
> +		filemap_remove_folio_for_restructuring(f);
> +	}
> +
> +	kvm_gmem_allocator_ops(inode)->merge_folio(first_folio);
> +
> +	ret = __kvm_gmem_filemap_add_folio(inode->i_mapping, first_folio, index);
> +	if (ret)
> +		goto err_split;
> +
> +	return ret;
> +
> +err_split:
> +	WARN_ON(kvm_gmem_allocator_ops(inode)->split_folio(first_folio));
> +	for (i = 0; i < to_nr_pages; ++i) {
> +		struct folio *f = page_folio(folio_page(first_folio, i));
> +
> +		WARN_ON(__kvm_gmem_filemap_add_folio(inode->i_mapping, f, index + i));
> +	}
> +
> +	return ret;
> +}
> +
> +static inline int kvm_gmem_try_merge_folio_in_filemap(struct inode *inode,
> +						      struct folio *first_folio)
> +{
> +	size_t to_nr_pages;
> +	void *priv;
> +
> +	priv = kvm_gmem_allocator_private(inode);
> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> +
> +	if (kvm_gmem_has_some_shared(inode, first_folio->index, to_nr_pages))
> +		return 0;
> +
> +	return kvm_gmem_merge_folio_in_filemap(inode, first_folio);
> +}
> +
> +static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
> +						pgoff_t start, size_t nr_pages,
> +						bool is_split_operation)
> +{
> +	size_t to_nr_pages;
> +	pgoff_t index;
> +	pgoff_t end;
> +	void *priv;
> +	int ret;
> +
> +	if (!kvm_gmem_has_custom_allocator(inode))
> +		return 0;
> +
> +	end = start + nr_pages;
> +
> +	/* Round to allocator page size, to check all (huge) pages in range. */
> +	priv = kvm_gmem_allocator_private(inode);
> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> +
> +	start = round_down(start, to_nr_pages);
> +	end = round_up(end, to_nr_pages);
> +
> +	for (index = start; index < end; index += to_nr_pages) {
> +		struct folio *f;
> +
> +		f = filemap_get_folio(inode->i_mapping, index);
> +		if (IS_ERR(f))
> +			continue;
> +
> +		/* Leave just filemap's refcounts on the folio. */
> +		folio_put(f);
> +
> +		if (is_split_operation)
> +			ret = kvm_gmem_split_folio_in_filemap(inode, f);
The split operation is performed after kvm_gmem_unmap_private() within
kvm_gmem_convert_should_proceed(), right?

So, it seems that that it's not necessary for TDX to avoid holding private page
references, as TDX must have released the page refs after
kvm_gmem_unmap_private() (except when there's TDX module or KVM bug).

> +		else
> +			ret = kvm_gmem_try_merge_folio_in_filemap(inode, f);
> +
> +		if (ret)
> +			goto rollback;
> +	}
> +	return ret;
> +
> +rollback:
> +	for (index -= to_nr_pages; index >= start; index -= to_nr_pages) {
> +		struct folio *f;
> +
> +		f = filemap_get_folio(inode->i_mapping, index);
> +		if (IS_ERR(f))
> +			continue;
> +
> +		/* Leave just filemap's refcounts on the folio. */
> +		folio_put(f);
> +
> +		if (is_split_operation)
> +			WARN_ON(kvm_gmem_merge_folio_in_filemap(inode, f));
> +		else
> +			WARN_ON(kvm_gmem_split_folio_in_filemap(inode, f));
> +	}
> +
> +	return ret;
> +}
> +
> +#else
> +
> +static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
> +						      struct folio *folio)
> +{
> +	return 0;
> +}
> +
> +static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
> +						pgoff_t start, size_t nr_pages,
> +						bool is_split_operation)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
>  #else
>  
>  static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
> @@ -563,11 +1005,16 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  		return folio;
>  
>  	if (kvm_gmem_has_custom_allocator(inode)) {
> -		void *p = kvm_gmem_allocator_private(inode);
> +		size_t nr_pages;
> +		void *p;
>  
> +		p = kvm_gmem_allocator_private(inode);
>  		folio = kvm_gmem_allocator_ops(inode)->alloc_folio(p);
>  		if (IS_ERR(folio))
>  			return folio;
> +
> +		nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(p);
> +		index_floor = round_down(index, nr_pages);
>  	} else {
>  		gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
>  
> @@ -580,10 +1027,11 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  			folio_put(folio);
>  			return ERR_PTR(ret);
>  		}
> +
> +		index_floor = index;
>  	}
>  	allocated_size = folio_size(folio);
>  
> -	index_floor = round_down(index, folio_nr_pages(folio));
>  	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index_floor);
>  	if (ret) {
>  		folio_put(folio);
> @@ -600,6 +1048,13 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  		return ERR_PTR(ret);
>  	}
>  
> +	/* Leave just filemap's refcounts on folio. */
> +	folio_put(folio);
> +
> +	ret = kvm_gmem_try_split_folio_in_filemap(inode, folio);
> +	if (ret)
> +		goto err;
> +
>  	spin_lock(&inode->i_lock);
>  	inode->i_blocks += allocated_size / 512;
>  	spin_unlock(&inode->i_lock);
> @@ -608,14 +1063,17 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  	 * folio is the one that is allocated, this gets the folio at the
>  	 * requested index.
>  	 */
> -	folio = page_folio(folio_file_page(folio, index));
> -	folio_lock(folio);
> +	folio = filemap_lock_folio(inode->i_mapping, index);
>  
>  	return folio;
> +
> +err:
> +	filemap_remove_folio(folio);
> +	return ERR_PTR(ret);
>  }
>  
> -static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> -				      pgoff_t end)
> +static void kvm_gmem_invalidate_begin_and_zap(struct kvm_gmem *gmem,
> +					      pgoff_t start, pgoff_t end)
>  {
>  	bool flush = false, found_memslot = false;
>  	struct kvm_memory_slot *slot;
> @@ -848,7 +1306,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	filemap_invalidate_lock(inode->i_mapping);
>  
>  	list_for_each_entry(gmem, gmem_list, entry)
> -		kvm_gmem_invalidate_begin(gmem, start, end);
> +		kvm_gmem_invalidate_begin_and_zap(gmem, start, end);
>  
>  	if (kvm_gmem_has_custom_allocator(inode)) {
>  		kvm_gmem_truncate_inode_range(inode, offset, offset + len);
> @@ -978,7 +1436,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  	 * Zap all SPTEs pointed at by this file.  Do not free the backing
>  	 * memory, as its lifetime is associated with the inode, not the file.
>  	 */
> -	kvm_gmem_invalidate_begin(gmem, 0, -1ul);
> +	kvm_gmem_invalidate_begin_and_zap(gmem, 0, -1ul);
>  	kvm_gmem_invalidate_end(gmem, 0, -1ul);
>  
>  	list_del(&gmem->entry);
> @@ -1289,7 +1747,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  	end = start + folio_nr_pages(folio);
>  
>  	list_for_each_entry(gmem, gmem_list, entry)
> -		kvm_gmem_invalidate_begin(gmem, start, end);
> +		kvm_gmem_invalidate_begin_and_zap(gmem, start, end);
>  
>  	/*
>  	 * Do not truncate the range, what action is taken in response to the
> @@ -1330,6 +1788,9 @@ static void kvm_gmem_free_folio(struct address_space *mapping,
>  	 */
>  	folio_clear_uptodate(folio);
>  
> +	if (kvm_gmem_has_custom_allocator(mapping->host))
> +		kvm_gmem_allocator_ops(mapping->host)->free_folio(folio);
> +
>  	kvm_gmem_invalidate(folio);
>  }
>  
> -- 
> 2.49.0.1045.g170613ef41-goog
> 

