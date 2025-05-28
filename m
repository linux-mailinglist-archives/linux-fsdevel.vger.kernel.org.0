Return-Path: <linux-fsdevel+bounces-49966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0F0AC667F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 11:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612587A6545
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782027A924;
	Wed, 28 May 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwc6umlv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061A27935F;
	Wed, 28 May 2025 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426320; cv=fail; b=lrLytWFLyNsLlrI67T4WWEb7AiTS4XKqmSfHzIUDSHoybmdUoMrb5S5HNxAypvqfbevqCOpXrnior4yoqJMMmHQg2w3PkvwAv6tFxPJl4W0AiS4eScinnAb3oLreyXz8RAzOiaRDZNlouDj+lj99FfVxJ4IQe8xpA0P5P8U4IeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426320; c=relaxed/simple;
	bh=VHwHQE89svsPeeXSEr5QfqCHQquxLhs6Vr1iRtnsqOo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p6Dimyr54z9ODyg4BZ+jkZrUAzwDW4yWiZxiLN3OJu7JO4sIO5yTygSvVl1rinzcrBqcodx2GOkUghox6a3yMErGZHrwu3FMa3j+AqjYICsoroXMVNDBtIk7hj15fQc6tTFJqLp782ozJszK9LaGeENrri2U8SMIMU4IwMHnPXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwc6umlv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748426319; x=1779962319;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=VHwHQE89svsPeeXSEr5QfqCHQquxLhs6Vr1iRtnsqOo=;
  b=dwc6umlvL263mK7LqUsTuBdeu32/TsolAQZZc4aXpo6TET6PqRRvFcnW
   GXjKLy5DQoo0wg2IF9QW/voCtfUh/ok3QUrJU/Ddeg4jdhGdPWxbjYJC+
   /mXkUngUK9amMnSEKeGG+vIMZMp766X6boPwfWop1Bn+oeWDYL/ljCj5/
   w4vLtaKEU/tfRc6jffmPwYNyDxuw/rk0YPDofEp5cD3DBvWQsWakEUAfm
   sb91iDEv5RsWkWXYiAU5AeL/HbHqcqahUDwWIJwxqM3sn2WJmSN5IKiM0
   WDCK71XGSpquZ3h0UnD6H0ypujNoc8XYXJ8VYAbDRtDV1qZkco9pFOOET
   g==;
X-CSE-ConnectionGUID: EvrDfmapTya9kFtVm3A0Iw==
X-CSE-MsgGUID: 0HRyPKJtSPy4NGJ86/Ha5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61103920"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="61103920"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 02:58:37 -0700
X-CSE-ConnectionGUID: yC/Cio7kTEui9jDPYIGlzQ==
X-CSE-MsgGUID: Fa5m9SdOSLaBk4qvs1vcSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="174080527"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 02:58:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 02:58:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 02:58:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.84)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 02:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLYwMqNyxKGuASAmwJ5v939u1/l0LALkiPzWXHtDifmoOLzO3vljFLJIbSBtu6Giv2paH4DaPITMJ20ZXO2ycPVRGWcBHGwTlSLVR/3YUJUP7gKFow5t0Wq4iidFOPlw/ybALlRkc6mVFKL670mDSJQpuvHelhWdhQRaYgUmnWMxZRvaRKUJ3T4J/txX1WYEqvBbEaSM0gF/vNI5pQzZucdor7CxguDYRlMKeCzfKBnbSDS92MhciMYtIaDE5vn0EaIrEcOeK/m3wqozwWFiZPUgOGLnmpLeqMxz7neE6GADQS3+CquTBxD7RlbMbOCfXHoUKLVB17aEDwQiXOeXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn6qdLfu5oTJ5Nl7UJfA3biKwyqBFmdxoh1t/k9LdAc=;
 b=bp0ItDRm6E0lyhHcoxIPOt1NTBHbbWqzyFoAJ00bxe+xDbtbDq7njXq9Cx+GE90/W2NHERNUjyLav7C8Hqo2fxAewbYddf9NF9mNFFxx/SprgSpDyPt1srXfOoNxDPPcwIK/QFelZsL523RGg7U7EreANSIrfK7qks5UnZBh97I9Cr26K81CNsSGSz2KZ1Z4DtZDVYFv1pLpi2spy/IDAJeF6uF8oDlFpxik0GBVwqKXEWcVC+2a3y7gvq8c59TSB6mKHPNNBd+KLpoA0QqPsfB+p5s5389O4B6iXgvnj642h7zB9or8F5as8BgPsG7D9W6czW+HMabEQwsZJJqObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Wed, 28 May 2025 09:58:04 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 09:58:03 +0000
Date: Wed, 28 May 2025 17:55:26 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Ackerley Tng <ackerleytng@google.com>, <kvm@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <aik@amd.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <brauner@kernel.org>, <catalin.marinas@arm.com>,
	<chao.p.peng@intel.com>, <chenhuacai@kernel.org>, <dave.hansen@intel.com>,
	<david@redhat.com>, <dmatlack@google.com>, <dwmw@amazon.co.uk>,
	<erdemaktas@google.com>, <fan.du@intel.com>, <fvdl@google.com>,
	<graf@amazon.com>, <haibo1.xu@intel.com>, <hch@infradead.org>,
	<hughd@google.com>, <ira.weiny@intel.com>, <isaku.yamahata@intel.com>,
	<jack@suse.cz>, <james.morse@arm.com>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
	<jgowans@amazon.com>, <jhubbard@nvidia.com>, <jroedel@suse.de>,
	<jthoughton@google.com>, <jun.miao@intel.com>, <kai.huang@intel.com>,
	<keirf@google.com>, <kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
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
Message-ID: <aDbdjmRceMLs1RPN@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <237590b163506821120734a0c8aad95d9c7ef299.1747264138.git.ackerleytng@google.com>
 <aDU3pN/0FVbowmNH@yzhao56-desk.sh.intel.com>
 <e38f0573-520a-4fe8-91fc-797086ab5866@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e38f0573-520a-4fe8-91fc-797086ab5866@linux.intel.com>
X-ClientProxiedBy: KU0P306CA0038.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::19) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|CY8PR11MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff94a4a-910b-4813-0564-08dd9dce230e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7/E1i+nhRMTbC2wKJ+K6wIeWtJGhPAfSVSjjwhVecamHcXabAZ+YILBgiAMU?=
 =?us-ascii?Q?eerSgYWiHtM26uRr1ybcuLWnp6hVJ9LmmU2NbwUJUUV0BvDrv2xgzYqfRNT0?=
 =?us-ascii?Q?c9lVfzvpyljJxcWBN/VFokPlOs46/e0eYzWcid8K0OoXK71tk8ULWqdbahbA?=
 =?us-ascii?Q?Gybd9LQf8dFoR6ggIDTW8CHoPFOm+o3meG+lP6fIcEib4bAnbg33dwJmNqF/?=
 =?us-ascii?Q?aELEUewsJyWHg+0oIHrPrVv7mmAfKK4cfsUw+07Yejo54aMdFgl3kadUnzK+?=
 =?us-ascii?Q?YzXcW95KaaPWhJXNO67V4Owv+GXw5fsJ1PcldefCJh+jvOh1jdreXMpC0jgF?=
 =?us-ascii?Q?1MqPtaD7FG8J1DPlODjuHRY9LKOFkoYYVxIvdO4V7S73fnGvN/MHE5NqBfc9?=
 =?us-ascii?Q?+3kvfxmuwBzpPNvJNlzyOGNC930N61UofOEuWNbLnk4D9Jf8od5yc9pYuBOy?=
 =?us-ascii?Q?6fDVKFz1CDOGAXRGSrWdCBnLO/Qgiy38gd0/16JDDQT20cIRWRYSgz6oHH2d?=
 =?us-ascii?Q?+wdJQlT53+h4qSXZ8G3k+unTv0zpZhVYm2wRHBffZDWMJblLyR+Jp8s3JMru?=
 =?us-ascii?Q?k9suU95GNKzk8kBzdasu5N+JmngHu6w/xIarBsd2oIZVRK3CBpnIXFJ66DO2?=
 =?us-ascii?Q?q2Jg00aOkyJGCU2AvUVFMMEZbQcd35qTbuvqk4LkWU7Kahx4Y10rOx826iye?=
 =?us-ascii?Q?8KwlGdQKk2L70jipZd6Shn5AzHBr/G+uIJXnJArc2y1KbCgL4hEqrSYtqFoM?=
 =?us-ascii?Q?a+J1qAN2ZiZcCFyP4P3mIhvCLduM5ZrZsZc/dDHQfTpn7UfKnS0pa5b4p9TF?=
 =?us-ascii?Q?6ZIQmInkBuxN8njsFC/VVg6lLpIcuRGxUQq9gghmNXDUH+exy2VDzEKzPcu4?=
 =?us-ascii?Q?AX9uFpF/KCuoE2chyj+v05RdVbwBGsblJODX8zwMWf0TenHUBW1nAf21fijL?=
 =?us-ascii?Q?PUYb7KRttYNWJApaw/MUZgGZ29mit9WopRTEX/Hbjcw1U7RscaVKiQwVtsYX?=
 =?us-ascii?Q?GiurJMz3WwBcf5It5GERYMPPAlsrT8L/kRBzPz/V4WtEdU4/xj+UrEVLEJus?=
 =?us-ascii?Q?kX/SvL2aj1IC7yrguxkvXKuZka9pe7hDsv+JW03/UcDYVPCZrcXUL9yMU8Z2?=
 =?us-ascii?Q?0Y+a+NIsK4/tTL3ImQnrLxjNYph2VZaYP+IFUPSBCMUPYsRazs0XmVFDzKEU?=
 =?us-ascii?Q?1Qh5NRsFono86dABtI+IL0SqLW8TEWVAd66/3f/XRjUhJ56LUjbSOe/fkRa1?=
 =?us-ascii?Q?AcY1zXlJFOomdGuMUvWwOEB8LzKK813irPbFH1J0Ajnm7KXZ7C4CWtAEBkjT?=
 =?us-ascii?Q?P04qPvVeXpNsJWTRVPwLDiSfOSECi2Q8452yuRVGdM1G+NIpEcL1W3HOmNzy?=
 =?us-ascii?Q?OOeR/LztvZopiyLLRyoa+WFsmH+2gCDUwAKUy7DS4eEwg7nH1jururk4fobE?=
 =?us-ascii?Q?tnMKVCA9JIQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?54wwwpabmxaRFUylgVqKmlGRxgduUhWE2dtufLeCiY42F5rdjMWAWn6MbPe+?=
 =?us-ascii?Q?AS9Eyt332KvInhOt4jRZnfjxhknlhxctDoaQiHItgC8refllohDy4NcP1fV1?=
 =?us-ascii?Q?Ic/MthpE3zOgsuYj9ConEbuK7VLQepLmHIpcwm3N3MEt1Ws9lZcnbXsoFHzh?=
 =?us-ascii?Q?wqb+N/dxH4WQsQG9on9Jy03IWhWM7GjEcok+tOqfjIBkRWDR314hyVjs68/U?=
 =?us-ascii?Q?+y9FV4UrIibRp+tDLWLs76UmLgEHhVfqpdw6EQ+BHHEodX7AX815YtMygj7C?=
 =?us-ascii?Q?FhAvXppw5Hp+W+nTNDCdQsYq/Ubdu3k5kJCad6EIxDaCQJ9Aet7lv4us37Xn?=
 =?us-ascii?Q?Khl6HS1ifY1BRHv7g0Zg+NObaABNTbiLbVjo7W/MeKvBRNlGFptZA3/IC8nA?=
 =?us-ascii?Q?BJemLqZcr2Wv/RDNHJyW25efS4LjSax6Y9FWrhriWbRYzHlC8AVVSOey1MaV?=
 =?us-ascii?Q?JCLdHSkl2xxPI4Mheqf26Ct6h2zFTXu77gqU3K4MKi4+mHFnPSvCnGs5OtY3?=
 =?us-ascii?Q?UgJgyKNHFtv073eME3jpDkOmjGbdFMhFydHF45tpm3dguIcOrO0nzNnt2APj?=
 =?us-ascii?Q?7fsKZ6uwSJotVphtXxVQRARg0z0YZ32wz2kqgeCqMEHE8JXPOScb+Qqm+QfH?=
 =?us-ascii?Q?zjThCm0l8YCjbcerDpziEVQ4U7SefFCOxfJoWbhzHcjwQdDKcdkjIwNwC3Ou?=
 =?us-ascii?Q?fuhAjttYklSNiCQJ7mlx5gUIsg/RbbSQhSv1LZS+F+P0Mo7Vbfnd879onsnb?=
 =?us-ascii?Q?+UXuNUp7TfKifi9Bax84SveadeUgZmjODbDVSIhmzdrt6QKrhovZCOly8kbm?=
 =?us-ascii?Q?yfZXRJSImdFeFnh3mL2dtybKznSrsQ6MCENKH53lnBg/4ynpKaU09p8ElNPU?=
 =?us-ascii?Q?CT3L6+zDGfU8/xlp6fbs98yZDKN4iZN5QQmxKVbELlqKxuO+BobY3J26O4sL?=
 =?us-ascii?Q?hHeH8NHZ4+U3J4ZDiXzYGBMzQuX13i74+4U+SBSLxtTW/B2OV48sDtsqklEE?=
 =?us-ascii?Q?vIRDLao1TDwGauoXgIXy9skiDday5Dmplh0ETX0/osBQxSLdMgKlPClbDrEA?=
 =?us-ascii?Q?g63mFFIl3MUwR09G56ZtZYf+M/+98j60/XyD9TjJmrIx6lMe3W8VFH92ubxo?=
 =?us-ascii?Q?F9NPKFTFmghLRfOtjZficqzs4vUz8gP1F85vswo3bFgj02GWOxx6vbEk51v/?=
 =?us-ascii?Q?bbUhOk87etvhVJJTqkhNCGJntBG3Xhu2nPMI3wfDLy50tkQMicdtWsp/A5sm?=
 =?us-ascii?Q?TSWGIVBZ4QJFKA5weVexnuI5/p1odV5EpfgzlOm1g1MRONw9mpPSYkA4uM4D?=
 =?us-ascii?Q?9bdCUBE+y2nN57dfC3LDDtRIUS8DT8ilrH/12gFpFQXVVxPJ9GardP60jRo+?=
 =?us-ascii?Q?ZLfBRcNcGh/BcZA9LRiW0rLXmV2yIFrckH/0AZJJB3C5J+SMpDp03aa5yWEh?=
 =?us-ascii?Q?k2YvlaVJ+qTY2/RGVIp3dgeNqTuZDb5TN19btEj+f61KyFBhiBXb0ea8rkbQ?=
 =?us-ascii?Q?3dif8ZaHpliEe3lipUcYL4QbYkVwH3BiuBBKgcH6gmOexYvcqlBhPqfSAASG?=
 =?us-ascii?Q?Ew0oAxg6jB5pHaeJZCIypXpsPQBDRcrlRVF8c6J1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff94a4a-910b-4813-0564-08dd9dce230e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 09:58:03.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OM8XiBtxsG/AJpVsMecLYoOp4XceDr7VtmJcTPWn6/9caNIb15HHvaXLOOei8ksB3uDT49Lcs3vCTRF6lPWjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com

On Wed, May 28, 2025 at 04:08:34PM +0800, Binbin Wu wrote:
> 
> 
> On 5/27/2025 11:55 AM, Yan Zhao wrote:
> > On Wed, May 14, 2025 at 04:41:45PM -0700, Ackerley Tng wrote:
> > > Query guest_memfd for private/shared status if those guest_memfds
> > > track private/shared status.
> > > 
> > > With this patch, Coco VMs can use guest_memfd for both shared and
> > > private memory. If Coco VMs choose to use guest_memfd for both
> > > shared and private memory, by creating guest_memfd with the
> > > GUEST_MEMFD_FLAG_SUPPORT_SHARED flag, guest_memfd will be used to
> > > provide the private/shared status of the memory, instead of
> > > kvm->mem_attr_array.
> > > 
> > > Change-Id: I8f23d7995c12242aa4e09ccf5ec19360e9c9ed83
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > ---
> > >   include/linux/kvm_host.h | 19 ++++++++++++-------
> > >   virt/kvm/guest_memfd.c   | 22 ++++++++++++++++++++++
> > >   2 files changed, 34 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > index b317392453a5..91279e05e010 100644
> > > --- a/include/linux/kvm_host.h
> > > +++ b/include/linux/kvm_host.h
> > > @@ -2508,12 +2508,22 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> > >   }
> > >   #ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > > +
> > >   bool kvm_gmem_memslot_supports_shared(const struct kvm_memory_slot *slot);
> > > +bool kvm_gmem_is_private(struct kvm_memory_slot *slot, gfn_t gfn);
> > > +
> > >   #else
> > > +
> > >   static inline bool kvm_gmem_memslot_supports_shared(const struct kvm_memory_slot *slot)
> > >   {
> > >   	return false;
> > >   }
> > > +
> > > +static inline bool kvm_gmem_is_private(struct kvm_memory_slot *slot, gfn_t gfn)
> > > +{
> > > +	return false;
> > > +}
> > > +
> > >   #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
> > >   #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> > > @@ -2544,13 +2554,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > >   		return false;
> > >   	slot = gfn_to_memslot(kvm, gfn);
> > > -	if (kvm_slot_has_gmem(slot) && kvm_gmem_memslot_supports_shared(slot)) {
> > > -		/*
> > > -		 * For now, memslots only support in-place shared memory if the
> > > -		 * host is allowed to mmap memory (i.e., non-Coco VMs).
> > > -		 */
> > > -		return false;
> > > -	}
> > > +	if (kvm_slot_has_gmem(slot) && kvm_gmem_memslot_supports_shared(slot))
> > > +		return kvm_gmem_is_private(slot, gfn);
> > When userspace gets an exit reason KVM_EXIT_MEMORY_FAULT, looks it needs to
> > update both KVM memory attribute and gmem shareability, via two separate ioctls?
> IIUC, when userspace sets flag GUEST_MEMFD_FLAG_SUPPORT_SHARED to create the
> guest_memfd, the check for memory attribute will go through the guest_memfd way,
> the information in kvm->mem_attr_array will not be used.
> 
> So if userspace sets GUEST_MEMFD_FLAG_SUPPORT_SHARED, it uses
> KVM_GMEM_CONVERT_SHARED/PRIVATE to update gmem shareability.
> If userspace doesn't set GUEST_MEMFD_FLAG_SUPPORT_SHARED, it still uses
> KVM_SET_MEMORY_ATTRIBUTES to update KVM memory attribute tracking.
Ok, so the user needs to search the memory region and guest_memfd to choose the
right ioctl.

For slots with guest_memfd of flag GUEST_MEMFD_FLAG_SUPPORT_SHARED, the
KVM_LPAGE_MIXED_FLAG bit in the lpage_info cannot reflect the truth and a false
value there may also prevent KVM from installing a huge page.

> > 
> > 
> > >   	return kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> > >   }
> 
> 

