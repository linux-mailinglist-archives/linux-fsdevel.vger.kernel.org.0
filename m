Return-Path: <linux-fsdevel+bounces-51728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB67CADAE23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 13:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA9F188F24D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3BF299928;
	Mon, 16 Jun 2025 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzHsGbuW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A3EAF1;
	Mon, 16 Jun 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072716; cv=fail; b=KYfMjYie8lPRqu1wuQJ9SkKGhEogcwQVBAsHWjoQ7b39sdOoqD3G6N+QNybkG9IScjPFdiZzJ4fmCoMbYl0ANBcoYiTHLJXuLgtlKRqpGSzoiN0MnQvHbV9AOfwKFA1Tco7hjFKuERsQOAp1rQZ2vU9nPcegocgLVe+N8vZ3qZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072716; c=relaxed/simple;
	bh=9KlObubXbYuTYchPyXTiYgsMnBaja3ACh1UVnGAeW68=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xpg+raG5dDwp7iS0g6wspbXGTiNF0m0gTQoQhYyfY1kLUqyndBfoc14cVQ4KKLa6PHdLH2zjv+8t+ak8imdogJfm2ovxWpM364YwwZ1MyeufbZfL36A98giw0eSafFnrYAvhpXNja7CbguvBKvx4j6Os8ApuPM6m+H+BtfmmhJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzHsGbuW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750072714; x=1781608714;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=9KlObubXbYuTYchPyXTiYgsMnBaja3ACh1UVnGAeW68=;
  b=CzHsGbuWQPOZMjtE7aR7nUEywxToYq2YEIeMjBnGwfrGd3xioqmytyNo
   Oe5zh/5c6VfKgEddrjgXe6Ay3q9gYvaesZT+peeeIc63cS1Ifn0kHQWoP
   M2hEY94jMdu4IXV3Qk7n/iGD7OMRTO/GsFWjT9glSOOlUiHBLGzU9lFs9
   7X9i5mtOeuExb6XXTC+oN5P5DLrbSshrgivqeSopxEIhlxb4e7nWOaTs+
   ONCvV6YL7cPAnUT9hJjBV4PVM0azSdIr0iiXk2enefw8HcTc6JyMUfceg
   mfvrhTTHIgmL4ahKNw3fzFD1W9ABoyO/vCExhFN8lBFsLZMO8JnDf8xLB
   g==;
X-CSE-ConnectionGUID: mnmKwj/uSbGGdiZX/7TObQ==
X-CSE-MsgGUID: m+DCk+kZSNWvFmGFNAU/YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="77608922"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="77608922"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:18:32 -0700
X-CSE-ConnectionGUID: qkTgZMbfQtKWri88O14tPg==
X-CSE-MsgGUID: fHVvPxgHROWQFa680FHVeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148280179"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:18:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 04:18:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 04:18:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 04:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFiWzpr3S4X+K4aa0ldnnMJqW4nM1pmPoRICO43qWnCTR1Eh1JYHSsa/lK+D6/PFItCqUY6bRxHi5kA125zLBMO9avr/GnLQeHTO4pETS9tIajyR08wbC9mEjBGojCSwh3H3HtiW0PF/N0/GEJ4PXrGE3CQe38h4z/4+w9e2DyjvITX0dV4BDWA2Nk7Mby7PDsWpm/WFmo1tq0Iq4tKR52IwlBcvFUeE6ptFovKLWpchqUFP2soT0AaT5VhGpYjSnvbTqX4Hwh2bgt5Y2izfpIbLruf+YyiI5fMNpwqeK1ztqLgrynjdQ07lVLHtgyXsdzndS2j4F01o0lnjAVZ9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okIcKVWekEpJlICJawz01W5KpX6yyU+ieNIQ+bMqDTM=;
 b=nBe9TFQD4JoxdsznRPsZEm7OMk7liGixZ75n08hR+zGx9yAdwj6K00jpTJ/GG2ZQa1uaHvKIVPCgfQSn3W4S4IjGF/FanCipdZSHN0+in5LYDTwl0YE5cfXVnRa9cuAlGnKbz7c+C7UU3eRT3xRUSM4shgL7hvTmEY7YAiSNX/b0YiIBZi8eU0oHnigo6CWLXHrmxK3A5dT9STIafB/iM0bChxRxqN+ywaChB470dTqeZRpwk5Q1eyl7uVyLsjShgrxcggdhrMNDwEkBnkw3EGpFx4kcxa9oR48cSDjRL7PuDv2XZ8JndYrtRRb9JVKop8Lr6R/o1xPaecBDbeY26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DS7PR11MB7690.namprd11.prod.outlook.com (2603:10b6:8:e6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.24; Mon, 16 Jun 2025 11:18:21 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 11:18:21 +0000
Date: Mon, 16 Jun 2025 19:15:34 +0800
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
Message-ID: <aE/81hmduC08B8Lt@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
 <aDV7vZ72S+uJDgmn@yzhao56-desk.sh.intel.com>
 <diqztt4uhunj.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <diqztt4uhunj.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DS7PR11MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bb6e5e-a2cd-4c74-77f0-08ddacc7805d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yrp4tu51jeeGOnf0QC/SfWbOjgGKmBdcGmJfLBc2OjkYLX/mQK5y1Eco0Cya?=
 =?us-ascii?Q?G8HbHnkOF4jAGKfAyijvZS+c9lqpNaGmNn5QjUmKRlRDeeUB68hwaihjl/q+?=
 =?us-ascii?Q?2BilD8mGgMyPMSA58SSf1LGWQOUoDOTLXT5TTcV2uHe+D//bf7y9dRoIQGzF?=
 =?us-ascii?Q?jGw/qDKAzVOvbLO9pUkd/fPbVUTOq0AhX6dgoRfoMSfmOmQfKHq5Y7yWx2eL?=
 =?us-ascii?Q?ltn+oEjkMQsM02/K9fXHDC3Y1n3U4Lta9RNurvCm/QyCbp+TTodBpJhOEU+N?=
 =?us-ascii?Q?BK3v2qtWwUQhh6fIgXAMgnqigRpGJPjgiqAgRgFtSDzaOJbHV5ytWHbzBUoc?=
 =?us-ascii?Q?XHaI6/b2iKG2h/72jpAEA/gwanrcDr3joj2Vc0g3mOIGXkXDW5MrHTBIx0vy?=
 =?us-ascii?Q?p/YNNJzJzmQK4bGOZ7M+bTvTpC+TYjznEgyot7BzVwp/e6UaLsI9zPQ9q02h?=
 =?us-ascii?Q?GD+7ZqbVnW3U+2kIKgvwkGPwjmPtjxDt1j+TB5mVytsws9TsUe24xazP/LH9?=
 =?us-ascii?Q?+Bf4DAPwF5SR+7wDJf9vzfBGThHh54DvJwxOGiX+ghRpauzBllLjf04qn5bw?=
 =?us-ascii?Q?PZDQzpX8acnErP/IbDFvg96djuICP8lfbBq8s8ImhLBJ9UiqCe8DBbiYPppY?=
 =?us-ascii?Q?3aOsIYZGT7XgjFjGWarfWQrnPJh2ZtfH61bDicrAKi57Fv64QDhxUDYo3j5P?=
 =?us-ascii?Q?2jFMpFNQ7Y0tfKtKldaS4QZ+zEmNjxd+ref4g5MjGHtK1wC1F9CK+tOiQk9H?=
 =?us-ascii?Q?n+YoCWIWOuCFpyA6kgOh/hX9auXh6weQLmOkcw3iiXwiu69bAU+XqZHG0RQq?=
 =?us-ascii?Q?3p5vk31IScF70As7y66BoA+5rQBjn0vY6fS7fXiZr4eS5px61G9lB36Eb5wP?=
 =?us-ascii?Q?GkkPhqeMIUEwDAbnV5hgHR1tdOxbjNHcruKE9MJmuRo7OP0agfZxiBBePFcE?=
 =?us-ascii?Q?WuBTJXfTqlj+XBnhL8OIDeuU2w8fWho2HHEyz/Oqtqu2yf7t8i5gcSeMAxvV?=
 =?us-ascii?Q?YG6jxZ7tI8EjYePqhhA2nhKcsfgxUK+rj7NhDqbKGKK8H7t4QezVqDagdT+0?=
 =?us-ascii?Q?AlC61drG3Kdn6Y8Z4vHDvYZWNQKIIvaFXoOxMOcO5jTntG7IbaHjmNOvYj6P?=
 =?us-ascii?Q?xEIWyJSsZs7o8fOZelV1IEY8pbD1SApNzUH1WZaiadbv8hz8EYHxYbk24y/k?=
 =?us-ascii?Q?HJhhlLkgLySLt2wOubgw1YZu8kzapbNznfStGhveXtL8zTlPzftB9ljeiFWX?=
 =?us-ascii?Q?hlo2j5zpTDbQaXLLHgEvQYqUAvac6hWrfjMXWHWeJ6WxO1KfQVFGqq7ijHXu?=
 =?us-ascii?Q?C//0iWWws5n5T4sjO1Ir87wxQMYBjErdyDDX5gGEa1OlQk/Z2qEu1jm5K8f9?=
 =?us-ascii?Q?6uZZ1w2r5eGjwTBmwDd+rXeK+oS3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3dZsubGOSAt5WNCFkUciz553baL2Bj9qNBRWXorz6rMPrbtFXbPYDqPnyvYZ?=
 =?us-ascii?Q?i9N7G29rMQQT9qs6KXDOXCNofuSj5u7iLoj3TjiqEmTK7Kk82wxztm11ozd3?=
 =?us-ascii?Q?ci1eLlFCI4ci33ulDwD5YCVQ8dXyBkjRoEzDRDatwEjAGcH/zZ14KYfKF5Ro?=
 =?us-ascii?Q?hEITaaLeIYNBehYeBWOSP7KqG8lSnJrg86jYRWXXyMaAC+M9Z9dZYAe5HqkI?=
 =?us-ascii?Q?iFDEw93qSgK0APTF5UNxLkHgwhpghINrI0SD66jkR5x2pOznuDpytcAxo093?=
 =?us-ascii?Q?sWNudHX2dAYsjIWP8+l/f2X+llactxejCfmnIxvZIYgd//np/0ZqGF1fR5bd?=
 =?us-ascii?Q?a5C8wyfgkIiVfdl0s0CGPNfEVbhiteUwcBdEw3z7d/rzLq4BCzxN50X1SJBG?=
 =?us-ascii?Q?SOcTrTN3KfFXifIycF/8vwbedEvcTQ3eXCyXCSivc6okqyv+OwjNvp79hxKB?=
 =?us-ascii?Q?RoqoKjVCwdit5+1AL0HEgYsXiFskt2I9j9yA/3IQ5W1OoMBegFtOZCyytX1R?=
 =?us-ascii?Q?ouDJaDttyzxNWbjno0BskeOKQuRs43Tbjc4l3I1KHWVAp+ogA46L1v0VCiri?=
 =?us-ascii?Q?aY/T9A/29a00DywRKs5rj7CFwn/5UkvSec/+7S9OyULAgv0H2yEG/tg/2iph?=
 =?us-ascii?Q?Gbk3W3TSx7+ILq8RSrEgBwQ7bS3H+/c74ulyT0QyA3A6b9MXJcojv53XcDdd?=
 =?us-ascii?Q?zUEMpUfDXmcuptMsSF9oRheu1DsVG7H3C6CWXT6NnMX5T05mmxt5ySUe6uUp?=
 =?us-ascii?Q?UzUMkwL7OJIsFSw7PmOHkxOt0xtHWQpl+U0466OM23r9xNkL2U887RPIzndZ?=
 =?us-ascii?Q?GYyFs4QPELPR2OpWCxxnkAnw3JWPGsNA6JFkcoTaWKhW6l9HEbov2CJVFzHT?=
 =?us-ascii?Q?xAg70sLtEJUqLnr3H3av6f9EZRDcKWXdJDeLfY6E7wGBqvKnhJr6wgkzBJ1E?=
 =?us-ascii?Q?v5u5F654FoLoioSICR1V1dNl9vKpZD2XcWwJnyrluLdD7RhpngOR2CBeNe2u?=
 =?us-ascii?Q?HFjc5YSKAXe27Y3VLXYmxqqQjR0zC62WNS0AbvYY7WixVhFaTNgYg/et+JmU?=
 =?us-ascii?Q?bd5SZ29xYOVSIRux3/3eYQjPmFopNO0zJ0o/SLU5zMfCvdNWrFIVDN0WHym7?=
 =?us-ascii?Q?yvn8EDKTNXNv7Z4PqVF7N+iQ8TW3m7iunNYP67N9jIpu6ldV4aRcxVOxYsDl?=
 =?us-ascii?Q?/jHIMGgu1LQ4ybJfkCX8+PSXwEOKC0FNisqWowMQiz1bM15dikZf7toyd9Vx?=
 =?us-ascii?Q?LBBLDyNH09lczOJAE9+dcnD9ceczUVJnhFm/MCIbfUZVNpZJvaEW00e95ALY?=
 =?us-ascii?Q?U7gf6IkEgIbmLTp113vcu9nBBZwCHtL/tfb43+7PQhw2LCkUVCvQR/ZwBIh0?=
 =?us-ascii?Q?gxTq/w0TtrG7JnEUzyaK8u8utRmD3S2Qc/O8N4q8Fm8JkrujOfaCSpIlDL/x?=
 =?us-ascii?Q?LGUcQOlyxosZXA/LWhYOG19l1mJWN0q6fOed4A0COMaCjqVBUDi3nviqJpIw?=
 =?us-ascii?Q?XGO3wTMvGNWSmaKIkkaHVLE6dw9HrPcAsRwewzNQ1scmfgnZxuHZmTl9yRSo?=
 =?us-ascii?Q?xjXiiju8aEom4EEgOQUcmNJy0hjOkxStOdTJiLFW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bb6e5e-a2cd-4c74-77f0-08ddacc7805d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:18:21.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDZEaZP81/OXPMIomXg8jpnoUfxEajSEYGIKcFbTb/7qU4HYOXZJUEfxCKGqQXXpBzJvgg6w74+0nSibYwAD2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7690
X-OriginatorOrg: intel.com

On Thu, Jun 05, 2025 at 12:10:08PM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > On Wed, May 14, 2025 at 04:42:17PM -0700, Ackerley Tng wrote:
> >> +static int kvm_gmem_convert_execute_work(struct inode *inode,
> >> +					 struct conversion_work *work,
> >> +					 bool to_shared)
> >> +{
> >> +	enum shareability m;
> >> +	int ret;
> >> +
> >> +	m = to_shared ? SHAREABILITY_ALL : SHAREABILITY_GUEST;
> >> +	ret = kvm_gmem_shareability_apply(inode, work, m);
> >> +	if (ret)
> >> +		return ret;
> >> +	/*
> >> +	 * Apply shareability first so split/merge can operate on new
> >> +	 * shareability state.
> >> +	 */
> >> +	ret = kvm_gmem_restructure_folios_in_range(
> >> +		inode, work->start, work->nr_pages, to_shared);
> >> +
> >> +	return ret;
> >> +}
> >> +
> 
> Hi Yan,
> 
> Thanks for your thorough reviews and your alternative suggestion in the
> other discussion at [1]! I'll try to bring the conversion-related parts
> of that discussion over here.
> 
> >>  static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
> >>  				  size_t nr_pages, bool shared,
> >>  				  pgoff_t *error_index)
> 
> The guiding principle I was using for the conversion ioctls is
> 
> * Have the shareability updates and any necessary page restructuring
>   (aka splitting/merging) either fully complete for not at all by the
>   time the conversion ioctl returns.
> * Any unmapping (from host or guest page tables) will not be re-mapped
>   on errors.
> * Rollback undoes changes if conversion failed, and in those cases any
>   errors are turned into WARNings.
> 
> The rationale is that we want page sizes to be in sync with shareability
> so that any faults after the (successful or failed) conversion will not
> wrongly map in a larger page than allowed and cause any host crashes.
> 
> We considered 3 places where the memory can be mapped for conversions:
> 
> 1. Host page tables
> 2. Guest page tables
> 3. IOMMU page tables
> 
> Unmapping from host page tables is the simplest case. We unmap any
> shared ranges from the host page tables. Any accesses after the failed
> conversion would just fault the memory back in and proceed as usual.
> 
> guest_memfd memory is not unmapped from IOMMUs in conversions. This case
> is handled because IOMMU mappings hold refcounts. After unmapping from
> the host, we check for unexpected refcounts and fail if there are
> unexpected refcounts.
> 
> We also unmap from guest page tables. Considering failed conversions, if
> the pages are shared, we're good since the next time the guest accesses
> the page, the page will be faulted in as before.
> 
> If the pages are private, on the next guest access, the pages will be
> faulted in again as well. This is fine for software-protected VMs IIUC.
> 
> For TDX (and SNP) IIUC the memory would have been cleared, and the
> memory would also need to be re-accepted. I was thinking that this is by
> design, since when a TDX guest requests a conversion it knows that the
> contents is not to be used again.
This is not guaranteed.

On private-to-shared conversion failure, the guest may leak the page or release
the page. If the guest chooses the latter (e.g. in kvmclock_init_mem(),
kvm_arch_ptp_init()), the page is regarded as private by the guest OS.
Re-acceptance then will not happen before the guest access.

So, it's better for host to keep the original SEPT if private-to-shared
conversion fails.


 
> The userspace VMM is obligated to keep trying convert and if it gives
> up, userspace VMM should inform the guest that the conversion
> failed. The guest should handle conversion failures too and not assume
> that conversion always succeeds.
I don't think relying userspace to keep trying convert endlessly is a good
design.

> 
> Putting TDX aside for a moment, so far, there are a few ways this
> conversion could fail:
> 
> a. Unexpected refcounts. Userspace should clear up the unexpected
>    refcounts and report failure to the guest if it can't for whatever
>    reason.
This is acceptable. Unmapping shared mappings in the primary MMU or shared EPT
is harmless.

> b. ENOMEM because (i) we ran out of memory updating the shareability
>    maple_tree or (ii) since splitting involves allocating more memory
>    for struct pages and we ran out of memory there. In this case the
>    userspace VMM gets -ENOMEM and can make more memory available and
>    then retry, or if it can't, also report failure to the guest.
This is unacceptable. Why not reserve the memory before determining to start
the real conversion? If -ENOMEM is returned before executing the conversion, we
don't need to handle the restore error, which is impossible to be handled
gracefully.


> TDX introduces TDX-specific conversion failures (see discussion at
> [1]), which this series doesn't handle, but I think we still have a line
> of sight to handle new errors.
The errors can be divided into two categories:
(1) errors due to kernel bugs
(2) errors that could occur in normal or bad conditions (e.g. the -ENOMEM)

We can't handle (1), so BUG_ON or leaking memory is allowed.
However, we should try to avoid (2) especially in the rollback path.


> In the other thread [1], I was proposing to have guest_memfd decide what
> to do on errors, but I think that might be baking more TDX-specific
> details into guest_memfd/KVM, and perhaps this is better:
The TDX-specific errors in the unmapping path is of category (1).
So, we hope to resolve it by BUG_ON and leaking the memory.

The other conversion error for TDX is for splitting memory. We hope to
do the splitting before executing the real conversion.

Please check the proposal details at
https://lore.kernel.org/all/aE%2Fq9VKkmaCcuwpU@yzhao56-desk.sh.intel.com.

> We could return the errors to userspace and let userspace determine what
> to do. For retryable errors (as determined by userspace), it should do
> what it needs to do, and retry. For errors like TDX being unable to
> reclaim the memory, it could tell guest_memfd to leak that memory.
> 
> If userspace gives up, it should report conversion failure to the guest
> if userspace thinks the guest can continue (to a clean shutdown or
> otherwise). If something terrible happened during conversion, then
> userspace might have to exit itself or shutdown the host.
> 
> In [2], for TDX-specific conversion failures, you proposed prepping to
> eliminate errors and exiting early on failure, then actually
> unmapping. I think that could work too.
> 
> I'm a little concerned that prepping could be complicated, since the
> nature of conversion depends on the current state of shareability, and
> there's a lot to prepare, everything from counting memory required for
> maple_tree allocation (and merging ranges in the maple_tree), and
> counting the number of pages required for undoing vmemmap optimization
> in the case of splitting...
> 
> And even after doing all the prep to eliminate errors, the unmapping
> could fail in TDX-specific cases anyway, which still needs to be
> handled.
> 
> Hence I'm hoping you'll consider to let TDX-specific failures be
> built-in and handled alongside other failures by getting help from the
> userspace VMM, and in the worst case letting the guest know the
> conversion failed.
> 
> I also appreciate comments or suggestions from anyone else!
> 
> [1] https://lore.kernel.org/all/diqzfrgfp95d.fsf@ackerleytng-ctop.c.googlers.com/
> [2] https://lore.kernel.org/all/aEEEJbTzlncbRaRA@yzhao56-desk.sh.intel.com/
> 
> >> @@ -371,18 +539,21 @@ static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
> >>  
> >>  	list_for_each_entry(work, &work_list, list) {
> >>  		rollback_stop_item = work;
> >> -		ret = kvm_gmem_shareability_apply(inode, work, m);
> >> +
> >> +		ret = kvm_gmem_convert_execute_work(inode, work, shared);
> >>  		if (ret)
> >>  			break;
> >>  	}
> >>  
> >>  	if (ret) {
> >> -		m = shared ? SHAREABILITY_GUEST : SHAREABILITY_ALL;
> >>  		list_for_each_entry(work, &work_list, list) {
> >> +			int r;
> >> +
> >> +			r = kvm_gmem_convert_execute_work(inode, work, !shared);
> >> +			WARN_ON(r);
> >> +
> >>  			if (work == rollback_stop_item)
> >>  				break;
> >> -
> >> -			WARN_ON(kvm_gmem_shareability_apply(inode, work, m));
> > Could kvm_gmem_shareability_apply() fail here?
> >
> 
> Yes, it could. If shareability cannot be updated, then we probably ran
> out of memory. Userspace VMM will probably get -ENOMEM set on some
> earlier ret and should handle that accordingly.
> 
> On -ENOMEM in a rollback, the host is in a very tough spot anyway, and a
> clean guest shutdown may be the only way out, hence this is a WARN and
> not returned to userspace.
> 
> >>  		}
> >>  	}
> >>  
> >> @@ -434,6 +605,277 @@ static int kvm_gmem_ioctl_convert_range(struct file *file,
> >>  	return ret;
> >>  }
> >>  
> >> +#ifdef CONFIG_KVM_GMEM_HUGETLB
> >> +
> >> +static inline void __filemap_remove_folio_for_restructuring(struct folio *folio)
> >> +{
> >> +	struct address_space *mapping = folio->mapping;
> >> +
> >> +	spin_lock(&mapping->host->i_lock);
> >> +	xa_lock_irq(&mapping->i_pages);
> >> +
> >> +	__filemap_remove_folio(folio, NULL);
> >> +
> >> +	xa_unlock_irq(&mapping->i_pages);
> >> +	spin_unlock(&mapping->host->i_lock);
> >> +}
> >> +
> >> +/**
> >> + * filemap_remove_folio_for_restructuring() - Remove @folio from filemap for
> >> + * split/merge.
> >> + *
> >> + * @folio: the folio to be removed.
> >> + *
> >> + * Similar to filemap_remove_folio(), but skips LRU-related calls (meaningless
> >> + * for guest_memfd), and skips call to ->free_folio() to maintain folio flags.
> >> + *
> >> + * Context: Expects only the filemap's refcounts to be left on the folio. Will
> >> + *          freeze these refcounts away so that no other users will interfere
> >> + *          with restructuring.
> >> + */
> >> +static inline void filemap_remove_folio_for_restructuring(struct folio *folio)
> >> +{
> >> +	int filemap_refcount;
> >> +
> >> +	filemap_refcount = folio_nr_pages(folio);
> >> +	while (!folio_ref_freeze(folio, filemap_refcount)) {
> >> +		/*
> >> +		 * At this point only filemap refcounts are expected, hence okay
> >> +		 * to spin until speculative refcounts go away.
> >> +		 */
> >> +		WARN_ONCE(1, "Spinning on folio=%p refcount=%d", folio, folio_ref_count(folio));
> >> +	}
> >> +
> >> +	folio_lock(folio);
> >> +	__filemap_remove_folio_for_restructuring(folio);
> >> +	folio_unlock(folio);
> >> +}
> >> +
> >> +/**
> >> + * kvm_gmem_split_folio_in_filemap() - Split @folio within filemap in @inode.
> >> + *
> >> + * @inode: inode containing the folio.
> >> + * @folio: folio to be split.
> >> + *
> >> + * Split a folio into folios of size PAGE_SIZE. Will clean up folio from filemap
> >> + * and add back the split folios.
> >> + *
> >> + * Context: Expects that before this call, folio's refcount is just the
> >> + *          filemap's refcounts. After this function returns, the split folios'
> >> + *          refcounts will also be filemap's refcounts.
> >> + * Return: 0 on success or negative error otherwise.
> >> + */
> >> +static int kvm_gmem_split_folio_in_filemap(struct inode *inode, struct folio *folio)
> >> +{
> >> +	size_t orig_nr_pages;
> >> +	pgoff_t orig_index;
> >> +	size_t i, j;
> >> +	int ret;
> >> +
> >> +	orig_nr_pages = folio_nr_pages(folio);
> >> +	if (orig_nr_pages == 1)
> >> +		return 0;
> >> +
> >> +	orig_index = folio->index;
> >> +
> >> +	filemap_remove_folio_for_restructuring(folio);
> >> +
> >> +	ret = kvm_gmem_allocator_ops(inode)->split_folio(folio);
> >> +	if (ret)
> >> +		goto err;
> >> +
> >> +	for (i = 0; i < orig_nr_pages; ++i) {
> >> +		struct folio *f = page_folio(folio_page(folio, i));
> >> +
> >> +		ret = __kvm_gmem_filemap_add_folio(inode->i_mapping, f,
> >> +						   orig_index + i);
> > Why does the failure of __kvm_gmem_filemap_add_folio() here lead to rollback,    
> > while the failure of the one under rollback only triggers WARN_ON()?
> >
> 
> Mostly because I don't really have a choice on rollback. On rollback we
> try to restore the merged folio back into the filemap, and if we
> couldn't, the host is probably in rather bad shape in terms of memory
> availability and there may not be many options for the userspace VMM.
Out of memory is not a good excuse for rollback error.

> Perhaps the different possible errors from
> __kvm_gmem_filemap_add_folio() in both should be handled differently. Do
> you have any suggestions on that?
Maybe reserving the memory or ruling out other factors that could lead to
conversion failure before executing the conversion?
Then BUG_ON the if the failure is cause by a bug.

> >> +		if (ret)
> >> +			goto rollback;
> >> +	}
> >> +
> >> +	return ret;
> >> +
> >> +rollback:
> >> +	for (j = 0; j < i; ++j) {
> >> +		struct folio *f = page_folio(folio_page(folio, j));
> >> +
> >> +		filemap_remove_folio_for_restructuring(f);
> >> +	}
> >> +
> >> +	kvm_gmem_allocator_ops(inode)->merge_folio(folio);
> >> +err:
> >> +	WARN_ON(__kvm_gmem_filemap_add_folio(inode->i_mapping, folio, orig_index));
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
> >> +						      struct folio *folio)
> >> +{
> >> +	size_t to_nr_pages;
> >> +	void *priv;
> >> +
> >> +	if (!kvm_gmem_has_custom_allocator(inode))
> >> +		return 0;
> >> +
> >> +	priv = kvm_gmem_allocator_private(inode);
> >> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_page(priv);
> >> +
> >> +	if (kvm_gmem_has_some_shared(inode, folio->index, to_nr_pages))
> >> +		return kvm_gmem_split_folio_in_filemap(inode, folio);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +/**
> >> + * kvm_gmem_merge_folio_in_filemap() - Merge @first_folio within filemap in
> >> + * @inode.
> >> + *
> >> + * @inode: inode containing the folio.
> >> + * @first_folio: first folio among folios to be merged.
> >> + *
> >> + * Will clean up subfolios from filemap and add back the merged folio.
> >> + *
> >> + * Context: Expects that before this call, all subfolios only have filemap
> >> + *          refcounts. After this function returns, the merged folio will only
> >> + *          have filemap refcounts.
> >> + * Return: 0 on success or negative error otherwise.
> >> + */
> >> +static int kvm_gmem_merge_folio_in_filemap(struct inode *inode,
> >> +					   struct folio *first_folio)
> >> +{
> >> +	size_t to_nr_pages;
> >> +	pgoff_t index;
> >> +	void *priv;
> >> +	size_t i;
> >> +	int ret;
> >> +
> >> +	index = first_folio->index;
> >> +
> >> +	priv = kvm_gmem_allocator_private(inode);
> >> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> >> +	if (folio_nr_pages(first_folio) == to_nr_pages)
> >> +		return 0;
> >> +
> >> +	for (i = 0; i < to_nr_pages; ++i) {
> >> +		struct folio *f = page_folio(folio_page(first_folio, i));
> >> +
> >> +		filemap_remove_folio_for_restructuring(f);
> >> +	}
> >> +
> >> +	kvm_gmem_allocator_ops(inode)->merge_folio(first_folio);
> >> +
> >> +	ret = __kvm_gmem_filemap_add_folio(inode->i_mapping, first_folio, index);
> >> +	if (ret)
> >> +		goto err_split;
> >> +
> >> +	return ret;
> >> +
> >> +err_split:
> >> +	WARN_ON(kvm_gmem_allocator_ops(inode)->split_folio(first_folio));
> > guestmem_hugetlb_split_folio() is possible to fail. e.g.
> > After the stash is freed by guestmem_hugetlb_unstash_free_metadata() in
> > guestmem_hugetlb_merge_folio(), it's possible to get -ENOMEM for the stash
> > allocation in guestmem_hugetlb_stash_metadata() in
> > guestmem_hugetlb_split_folio().
> >
> >
> 
> Yes. This is also on the error path. In line with all the other error
> and rollback paths, I don't really have other options at this point,
> since on error, I probably ran out of memory, so I try my best to
> restore the original state but give up with a WARN otherwise.
> 
> >> +	for (i = 0; i < to_nr_pages; ++i) {
> >> +		struct folio *f = page_folio(folio_page(first_folio, i));
> >> +
> >> +		WARN_ON(__kvm_gmem_filemap_add_folio(inode->i_mapping, f, index + i));
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static inline int kvm_gmem_try_merge_folio_in_filemap(struct inode *inode,
> >> +						      struct folio *first_folio)
> >> +{
> >> +	size_t to_nr_pages;
> >> +	void *priv;
> >> +
> >> +	priv = kvm_gmem_allocator_private(inode);
> >> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> >> +
> >> +	if (kvm_gmem_has_some_shared(inode, first_folio->index, to_nr_pages))
> >> +		return 0;
> >> +
> >> +	return kvm_gmem_merge_folio_in_filemap(inode, first_folio);
> >> +}
> >> +
> >> +static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
> >> +						pgoff_t start, size_t nr_pages,
> >> +						bool is_split_operation)
> >> +{
> >> +	size_t to_nr_pages;
> >> +	pgoff_t index;
> >> +	pgoff_t end;
> >> +	void *priv;
> >> +	int ret;
> >> +
> >> +	if (!kvm_gmem_has_custom_allocator(inode))
> >> +		return 0;
> >> +
> >> +	end = start + nr_pages;
> >> +
> >> +	/* Round to allocator page size, to check all (huge) pages in range. */
> >> +	priv = kvm_gmem_allocator_private(inode);
> >> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> >> +
> >> +	start = round_down(start, to_nr_pages);
> >> +	end = round_up(end, to_nr_pages);
> >> +
> >> +	for (index = start; index < end; index += to_nr_pages) {
> >> +		struct folio *f;
> >> +
> >> +		f = filemap_get_folio(inode->i_mapping, index);
> >> +		if (IS_ERR(f))
> >> +			continue;
> >> +
> >> +		/* Leave just filemap's refcounts on the folio. */
> >> +		folio_put(f);
> >> +
> >> +		if (is_split_operation)
> >> +			ret = kvm_gmem_split_folio_in_filemap(inode, f);
> > kvm_gmem_try_split_folio_in_filemap()?
> >
> 
> Here we know for sure that this was a private-to-shared
> conversion. Hence, we know that there are at least some shared parts in
> this huge page and we can skip checking that. 
Ok.

> >> +		else
> >> +			ret = kvm_gmem_try_merge_folio_in_filemap(inode, f);
> >> +
> 
> For merge, we don't know if the entire huge page might perhaps contain
> some other shared subpages, hence we "try" to merge by first checking
> against shareability to find shared subpages.
Makes sense.


> >> +		if (ret)
> >> +			goto rollback;
> >> +	}
> >> +	return ret;
> >> +
> >> +rollback:
> >> +	for (index -= to_nr_pages; index >= start; index -= to_nr_pages) {
> 
> Note to self: the first index -= to_nr_pages was meant to skip the index
> that caused the failure, but this could cause an underflow if index = 0
> when entering rollback. Need to fix this in the next revision.
Yes :)

> >> +		struct folio *f;
> >> +
> >> +		f = filemap_get_folio(inode->i_mapping, index);
> >> +		if (IS_ERR(f))
> >> +			continue;
> >> +
> >> +		/* Leave just filemap's refcounts on the folio. */
> >> +		folio_put(f);
> >> +
> >> +		if (is_split_operation)
> >> +			WARN_ON(kvm_gmem_merge_folio_in_filemap(inode, f));
> >> +		else
> >> +			WARN_ON(kvm_gmem_split_folio_in_filemap(inode, f));
> > Is it safe to just leave WARN_ON()s in the rollback case?
> >
> 
> Same as above. I don't think we have much of a choice.
> 
> > Besides, are the kvm_gmem_merge_folio_in_filemap() and
> > kvm_gmem_split_folio_in_filemap() here duplicated with the
> > kvm_gmem_split_folio_in_filemap() and kvm_gmem_try_merge_folio_in_filemap() in
> > the following "r = kvm_gmem_convert_execute_work(inode, work, !shared)"?
> >
> 
> This handles the case where some pages in the range [start, start +
> nr_pages) were split and the failure was halfway through. I could call
> kvm_gmem_convert_execute_work() with !shared but that would go over all
> the folios again from the start.
> 
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +#else
> >> +
> >> +static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
> >> +						      struct folio *folio)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
> >> +						pgoff_t start, size_t nr_pages,
> >> +						bool is_split_operation)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +#endif
> >> +
> >  

