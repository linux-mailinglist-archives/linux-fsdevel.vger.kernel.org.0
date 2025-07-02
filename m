Return-Path: <linux-fsdevel+bounces-53602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F209AAF0E30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D59189504F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277E923957D;
	Wed,  2 Jul 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ey832ScC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF12367B3;
	Wed,  2 Jul 2025 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445509; cv=fail; b=FTuT+jgu6okEhBwE7NC6C050PX34/RwpD63Pkhr2ea3nINdOGEvEn8NwH91Byu3Pz4fPHbFcpViEbllP/6U6P0xH9uRGBfc48qXGjqd0RiABBCORo/WMrfH8P8UuL5R2ge6i27LrepEwN4RvCA6i74I2NDaL8EN+AL6RgseRpPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445509; c=relaxed/simple;
	bh=oxvr/j2brGEjV7f+syPnINivsrNz+5iqfnc6WRLGBtI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uvV43qqViDmlU0LtxMGShVOswyYmGneq6FC/HMcpy9CUKJRYbffYozk7GLgTD6iSoSS3IRD3+gwBmqkfb/Y4UlKyf21yqi4WIajZA6uPxPZj8R3QENYHHI8HrTCBKqUMGVd7lPwRXM66wTcHlATnCmcV0yZHFdyVTrU/Wd73JaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ey832ScC; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751445508; x=1782981508;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oxvr/j2brGEjV7f+syPnINivsrNz+5iqfnc6WRLGBtI=;
  b=ey832ScCYuQlY/2FSZ9Cq0iOqXOf7u0YQCkGoJbCDU/PJsZQYBD1U89I
   CGiRq0Tg8MBAOggWy0XEYpK740jPRH2+JeUcH2vrlHRMDqPBBN8jpK8Ln
   Ah1YKexzaUvMjLmYEWkDj//1YA+Uvr3NSPP7TPwFi9LXAXcR3OeR0Nq4P
   usXLWQwSOqQimwQU2VymRRxIIM9HJBil0cHRM4oTQoBcIUr8spBYT+8/+
   P8Xlc4yhhPJxuiJUqlY08xLQBGgTsiMqpIJ1eMe3gjJdEWla7O0xJlpXf
   IL1X1og2ihfDCZ5yDL8FL5Ep5HzkFzRicd3O1dIvaJiuLQpPCQdCen2OH
   g==;
X-CSE-ConnectionGUID: qvMZ079QQ1C3AtlDQ/+HkQ==
X-CSE-MsgGUID: sj+K1ipoRgS3xI18bIABKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53661765"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53661765"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:38:26 -0700
X-CSE-ConnectionGUID: KvEctvg2Q/aBkuiAJfApnw==
X-CSE-MsgGUID: b1638uTRQ/KShrjdukMNkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153788600"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:38:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 01:38:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 01:38:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.64)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 01:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vvyb1917wqndgupfN0FuXcD7FJV1xutuhYhV5uMe77e/9K1td0yAsm5wX7iWEnz9NQfjZHshyZJ045IG5Eibusji3462m+dm4Dc6cynaPSGbhPHl8mXygyIvEjPSTQvFicCG8AuXOycF701dSAgh9zWFKCj8aON24Lonq9IPBrY4vu+RJ3APbTGfvaNEbN8OuS7tD0YmZ4JPuiK55FZhS35bVPdh2MvLDogbmvtXgQrS5pi9Cz4u5ODivP6eQWICpzKxxwU3rzlIM0zBG1jhJxeevYMCX5Zxtq9HckGIlwGsFzmhkXDnz3/WBHupMQ1g69nRZ/S4O/1Irw2HHrBHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMcisIX9erHhPhRijIpu3CUadWZ0nYMPgKabtym5k3c=;
 b=asM+zWETuoH1hOi2+n5hSKOBVElOtDi+5vWMHo146VbNRDtY8HACyAwXb1+LLt8N9SpFBbawsRMDLv393ZTHuodmcRqIgBMDuIHGnht3FtIMV/uw6VeiH9wISvBZulwYw+YNvhpbSg3ljc1PKm/zSrCE93U6hs3ER6FIDXqf4PL/FEyIIxy0rr1qmZRonv0ICJydKwh0PoqRbU/f190NUZRdPu1fi8XtppzfHz2/qjf4sKkc9yn+1ysMVSgMM92r/UJCLHtNNnaEqAj2FpPuKNOEQUcYvkW+NGAMfXNtG/puocx4LIiM/J71hgG5QIUIQCizUKhPmn5Cxxdu3BCfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SJ5PPFC0624F2CA.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::850) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 08:38:23 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 08:38:23 +0000
Date: Wed, 2 Jul 2025 16:35:25 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Vishal Annapurve <vannapurve@google.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, "Fuad
 Tabba" <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-fsdevel@vger.kernel.org>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dmatlack@google.com>,
	<dwmw@amazon.co.uk>, <erdemaktas@google.com>, <fan.du@intel.com>,
	<fvdl@google.com>, <graf@amazon.com>, <haibo1.xu@intel.com>,
	<hch@infradead.org>, <hughd@google.com>, <ira.weiny@intel.com>,
	<isaku.yamahata@intel.com>, <jack@suse.cz>, <james.morse@arm.com>,
	<jarkko@kernel.org>, <jgowans@amazon.com>, <jhubbard@nvidia.com>,
	<jroedel@suse.de>, <jthoughton@google.com>, <jun.miao@intel.com>,
	<kai.huang@intel.com>, <keirf@google.com>, <kent.overstreet@linux.dev>,
	<kirill.shutemov@intel.com>, <liam.merwick@oracle.com>,
	<maciej.wieczor-retman@intel.com>, <mail@maciej.szmigiero.name>,
	<maz@kernel.org>, <mic@digikod.net>, <michael.roth@amd.com>,
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
	<steven.sistare@oracle.com>, <suzuki.poulose@arm.com>,
	<thomas.lendacky@amd.com>, <usama.arif@bytedance.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yilun.xu@intel.com>, <yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
Message-ID: <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SJ5PPFC0624F2CA:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f323d1-6ecf-4f73-4a26-08ddb943ce03
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzcydHkrSnh5cUhsUUVvL0p6SFo5ck1FMzk4L2JjUmxyL3Rzc294MjBsVHZl?=
 =?utf-8?B?NFFFTWRFL24yUXJhdUQ2VVJCdzJxbmpqZm9EWE9QeklzZEN2dHRZREpVVWUw?=
 =?utf-8?B?SE1oaWgvQ1g3U2xYUjB6c0hQckFDbVRwb25TM1hmeWxQYytjeEFzL0tzQXhr?=
 =?utf-8?B?YWJER0JmMTVIY0JMcTd0aHpFZ0pNVXBONnVyenk2elh6aWpTb2FqSzVzbCtn?=
 =?utf-8?B?eXdhK01MWm1pNVRsblgyUVFXNm9TeXZsZHEvZEFmcDJyT0pzWU1jR0xEOGFa?=
 =?utf-8?B?dk5rYmNjbVRLNHZNQXdScWNaVW9ON2wxOVNIcDd2YllNL21RN1F4ZC9lYlNh?=
 =?utf-8?B?Z3JZL0dwUlN3WnNmVEdYUVZVMkdvVmJtczFDeGxXaE1HZEMwSWlodzNpR3RV?=
 =?utf-8?B?cVZZb0lEa0psYU5VMjdMS2U1Ly9mSXg4MXRFODRDTDRJSkdDbURLSFM0TWY5?=
 =?utf-8?B?NWZreEJmYnhkMENaSjFUekFhVGkwaEdacTk2b1l6NGZHa3BHa3hSa2Qyc0hJ?=
 =?utf-8?B?cFV0TnNiWGxCUEpicWRUMDhXcWl5WEg5cG5ka2dqTmRSSDQ0NG9HQ3lWeXV2?=
 =?utf-8?B?ekNQeFNLODBRdEp1eVA3WFdQVTRORyt5Yy9KTU5nZGYxb2pmVGsyZHFqT3dM?=
 =?utf-8?B?WkFub0dYUVZXTkhpUkRhQ2xRNlVlcTVvOHF2aVhkdjA3QU95U2VFWGo4eWJw?=
 =?utf-8?B?TXNQSUV1Q094d2xPVUd5czhYUzdMTGM3WEdBZDZETG1wK0ZVLzc2Q0JONGpL?=
 =?utf-8?B?S05KTUVvd1BTeHk1M25hVThLa21aajZJM3VGWTVubEhCd3lrenZzUmpTbFpP?=
 =?utf-8?B?QjVvWkRPY3BnRm9RZzAybmZoUnhsZGZ6NlJ4Rys1WWFwWVlKeSs5dVFFTFN0?=
 =?utf-8?B?aUNER09Vczd6SkE4REpxWjRHTWlBdGp2S3ZPeXNBYmxLSEdjcDRCSUV1SENm?=
 =?utf-8?B?VGhXOEpjYVlwRTNEMnc4M3ZqOHlrc21JQUVrS0dwOHpNcGdwUlo1QjBRM2dP?=
 =?utf-8?B?MmF4L1NkZ3cveHFXT3VDK0NJeVB1ZlAxK0xtSnNnUFNHdFZVbzVEd2d3cVdV?=
 =?utf-8?B?L09nYUJsUzcvRkJoOERuc0V5YXJXSWc3S0x0VmhLcGRBci9DSkxpajZKQVk0?=
 =?utf-8?B?T1JGRGVvbno1Y0h4ZkRoT1pvWUUrVCt6Uy81UVlkOCtWWHM3cmdEb3JHeUVw?=
 =?utf-8?B?cWVYUUsvazFxcXU4MUh3UzlYQXNUOFNGVUZMSUpXdUF1aHlvMUsvYTlLdTg3?=
 =?utf-8?B?VHpybVVzWUNRZk5NY0syL0swY2tHN2JycFFmVTdUMFZPT2l3NlNvcjRFMSt0?=
 =?utf-8?B?dmlLdzZ3KzBpV1pnTXYzNTFQZVNHY3lNdzJlNEYxaVZ2VldnZGhmM2hXQlBS?=
 =?utf-8?B?RGpUc2dMWld0UTl3OXNuaUZGa0x5anBZNEt4MXpjaFpaZlJ5NW4vZTB2TlNq?=
 =?utf-8?B?UStPR1pzUHlhdXBqUGN4SkRXbUYyZWUrN3dlQkIxZVRKMENvZEpUWXVqMTlC?=
 =?utf-8?B?VVFqU0w0SjhtUmd1b0RrZlpkZTlPZmhoZUkvYzNUY1JUdFhIbnBKRGpjWVdq?=
 =?utf-8?B?V1FFZ0ZRT3N5UXBCcVhXRkh5QXREMkJzTGV3ZFFzcUxFaEVseFg1bUk0YjVm?=
 =?utf-8?B?R3FiWXhHdFA4Z2d0bERJUmhYMkpVeC8ybEhOZVNHNzYyTE4rRFlPbnRhbkg5?=
 =?utf-8?B?a05PZWNZMXBXb29ZR2orZmdHbWJWbTVqZm5BWmFnREl5bityS3JRNWlGUUtJ?=
 =?utf-8?B?SFRwTU1oKzlQN3RyTjdwUS84T2NWaG80MFlPOHNkMkg3a3B5TWovMVkwc2N4?=
 =?utf-8?B?QXRuRGprRXZtT0MrMXJJY0F2OEhIMXJmSFpzWnlpZnFpZXNhMXhtUkZSTWRz?=
 =?utf-8?B?YUVTQjIvUmQ1VS9ZTHZwUlZZSVVVa0pULzV1THVLRGJka0NqVmg1TUVQbnM1?=
 =?utf-8?Q?Txydq2n4Elo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHlqYSt6R0NiMnY0dzJwczJ0WTUwcEx1MTRqS0d2RHFNVkllbTJPeG5RMDdt?=
 =?utf-8?B?NTJaQ2EySVN1TXFMSGtOSTRZMVJMTTAwU29IUFlIaUt4c0tQMW9DZjZzQS9s?=
 =?utf-8?B?dGVuRHhxZEk5NWdteWZWWlRGYk9jSmg0T1lHTUdGSjkrRFhIWVpIVlEzQ2Fw?=
 =?utf-8?B?Y29sK0pDNlZTT09WZkYxMmlRV1h4VGFCdUZhRkNML3VOR2JhVXBFUS9GcWdX?=
 =?utf-8?B?SUhUUkdOcHJOK0VzcUlnd3pOMEd2RHZaa1dxOHNhTnFNNXRhN0VBd3BrcVhJ?=
 =?utf-8?B?OVpqaUI1c0I3ZFY0dDJ4Q0dEdERzUWh4MTZ0QzhwVjYvTWFGZjJjdFZqTFVm?=
 =?utf-8?B?ZW1sVHNMNnAxaEdORWxsdWdOUlFraS9WUlBlSWdJRlkwT25aQ0VMNit3Vmtu?=
 =?utf-8?B?MkZVSElMaXQ5RjNENUMvSUp1Um9MSFFsL2JXdElETFhmKzZ4YWpRa2lqVmYv?=
 =?utf-8?B?anc3T2lGdkF3bFBLS0lBV0JMK3JJcTljNkl2RmlHVXJ2cUZlUnh1cmllTmlw?=
 =?utf-8?B?YTd4WmgwTllCZ3BHdHJNUnk2YUsxQW9uUTlLT0pVM2UrZllOUmkyK2I0bVUy?=
 =?utf-8?B?d0c5YXJtODMzZ1k1WkVxdXFUR0FPeXZxK1ByaVFVUUFGMWNYWU1uejltc3NV?=
 =?utf-8?B?QnpLL2NSdVNOaFNWSDYycnJseUxmL29Da0FiS09DY3MvbGplSzJZeFZlbHBT?=
 =?utf-8?B?a01ReEd2cUJHaFBTRUYreFZiNlQ5TCtHbjlXRUM3dk1MNmxPLzdTL1IzZlBK?=
 =?utf-8?B?VFZUMld6Q2RqNmNCS0FWdG9YS0daM1l5Rmhqb2FTWWZHRmdLVVY1d2RJMDhp?=
 =?utf-8?B?WTB0K1dpYk14Wmk2V2VOT1E4VkNycWd4eTA1WVczOTNGQjZaNWQ1ZG1VZzVo?=
 =?utf-8?B?RHZ0dWw2a0dxVmd3dW5JZ1Zlc1VQVThlTlRQR3FoVFBjeUlPMVhudU0raGY3?=
 =?utf-8?B?TXVqQWpPUU9pbVIyRVR1QjZDWHlVeEp4K2hRTmZsTldMS0VHaTRpUXMxQ1Zv?=
 =?utf-8?B?cEpRYjJNNGMrcDlmTlpPdGZZaTAvN2RQVlhRaTFzN09kSmhCaWp5cUE4R1lD?=
 =?utf-8?B?M214Wlc2aHJqYjlva0RYNVo3V2RCZTJnN3ZBSjQrd3o2TTY3R1lDZ1MwazFF?=
 =?utf-8?B?d3U4MG44SnpiNHN1Yy9qbjBCSXFzd3ZOR0VwK0Vuci83amMzWWtxcUs4T1V0?=
 =?utf-8?B?dUkyRXV2UWc3TFlCdm9hemo2Wkw1THIrUUxzb2c1RGtCbVFpbjc0a0ZYRk0v?=
 =?utf-8?B?QmNvNVFpK2cwRFE0LzZHb3FDY2dPQWg5OVJFbS9jZ29YaldsSjkwT3Z5WTJI?=
 =?utf-8?B?R3lRazlFeGt4NWZhcDZxMUxqUmRaQjdyQ0FrcGFRUFZZM25pWnFBbmtnSlI0?=
 =?utf-8?B?VWhJcytJMVloTkczdi8vL0hqNVRtQm9oQTcxTW9RemJBVkZ3em5zVXlFSWRp?=
 =?utf-8?B?cU5rajZqaGxjeGJ1aS9tTHVrbktWSFh0UmpsNVFDaSt5WndKOXc0TkU3OU1K?=
 =?utf-8?B?VUY5RmQyd1VNYW5UMkNBZVlEQjhmSFM0OW9kZkpDNVB6MGYwVDliZzZkTTJJ?=
 =?utf-8?B?TWxacWZNdW1VMkNKQjF3aDllSVZydzNhTkpSdkVVc2V3eUs1MjRIK2lrSDRL?=
 =?utf-8?B?dWJ1eklpMEtBc1pVUEYyM1FHeThiR1RGL2I3MHg1ODJYbkdYVldXR0tUZ1FC?=
 =?utf-8?B?QnkzL3pmT290WklJa3F2cGNRWEF5dmFxUTU5RXcycSt3RldHWnRHM0o5NUlW?=
 =?utf-8?B?MmFzYXVKTnBBSk1vRS9aaE0wVEJRTzFLZXVxYnk1VUwxYjVoSmNoTGVhK1hn?=
 =?utf-8?B?OHJuTDVoQUwyZ2djOTR2c2szNTVsVnhxMFpQQ3gwbGZwUWdSM1NybHZhZk1o?=
 =?utf-8?B?QytodnBGc2lZcHA4d0hpQ0RuMzZ3ZlBRQW80b3NXS0JIMVBjbzRCUGNNQmlH?=
 =?utf-8?B?TFJSTHJBK3FpTDFKd1dmSTlyWU1VK25GOGVWVVRCTlR5NFB5ZlplR0FBT2pN?=
 =?utf-8?B?dUFmZXV5N21WWGpEc21lOGxxaXo3bk5TU1pnK3dnT0RlbkFYR2VoVkdJUUtm?=
 =?utf-8?B?NmRGdDNiS004YUNEYSt1NnN1VzVCbERldE5ObGZKbWZMS0UzQ0E2QU5rV21m?=
 =?utf-8?Q?888U4P9ksKxBB415Vt6w5CHG8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f323d1-6ecf-4f73-4a26-08ddb943ce03
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 08:38:22.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8WFCQrQu3436cMa98fTihEL7fgNR2Ub+AEPFBQFrTuHW4FGfluCY7j25w1IQPbacNMDT6r87pfKGS2QZ2XlhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC0624F2CA
X-OriginatorOrg: intel.com

On Tue, Jun 24, 2025 at 07:10:38AM -0700, Vishal Annapurve wrote:
> On Tue, Jun 24, 2025 at 6:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
> >
> > > Now, I am rebasing my RFC on top of this patchset and it fails in
> > > kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
> > > folios in my RFC.
> > >
> > > So what is the expected sequence here? The userspace unmaps a DMA
> > > page and maps it back right away, all from the userspace? The end
> > > result will be the exactly same which seems useless. And IOMMU TLB
> 
>  As Jason described, ideally IOMMU just like KVM, should just:
> 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
> by IOMMU stack
In TDX connect, TDX module and TDs do not trust VMM. So, it's the TDs to inform
TDX module about which pages are used by it for DMAs purposes.
So, if a page is regarded as pinned by TDs for DMA, the TDX module will fail the
unmap of the pages from S-EPT.

If IOMMU side does not increase refcount, IMHO, some way to indicate that
certain PFNs are used by TDs for DMA is still required, so guest_memfd can
reject the request before attempting the actual unmap.
Otherwise, the unmap of TD-DMA-pinned pages will fail.

Upon this kind of unmapping failure, it also doesn't help for host to retry
unmapping without unpinning from TD.


> 2) Directly query pfns from guest_memfd for both shared/private ranges
> 3) Implement an invalidation callback that guest_memfd can invoke on
> conversions.
> 
> Current flow:
> Private to Shared conversion via kvm_gmem_convert_range() -
>     1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
> on each bound memslot overlapping with the range
>          -> KVM has the concept of invalidation_begin() and end(),
> which effectively ensures that between these function calls, no new
> EPT/NPT entries can be added for the range.
>      2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
> actually unmaps the KVM SEPT/NPT entries.
>      3) guest_memfd invokes kvm_gmem_execute_work() which updates the
> shareability and then splits the folios if needed
> 
> Shared to private conversion via kvm_gmem_convert_range() -
>     1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
> on each bound memslot overlapping with the range
>      2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
> actually unmaps the host mappings which will unmap the KVM non-seucure
> EPT/NPT entries.
>      3) guest_memfd invokes kvm_gmem_execute_work() which updates the
> shareability and then merges the folios if needed.
> 
> ============================
> 
> For IOMMU, could something like below work?
> 
> * A new UAPI to bind IOMMU FDs with guest_memfd ranges
> * VFIO_DMA_MAP/UNMAP operations modified to directly fetch pfns from
> guest_memfd ranges using kvm_gmem_get_pfn()
>     -> kvm invokes kvm_gmem_is_private() to check for the range
> shareability, IOMMU could use the same or we could add an API in gmem
> that takes in access type and checks the shareability before returning
> the pfn.
> * IOMMU stack exposes an invalidation callback that can be invoked by
> guest_memfd.
> 
> Private to Shared conversion via kvm_gmem_convert_range() -
>     1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
> on each bound memslot overlapping with the range
>      2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
> actually unmaps the KVM SEPT/NPT entries.
>            -> guest_memfd invokes IOMMU invalidation callback to zap
> the secure IOMMU entries.
If guest_memfd could determine if a page is used by DMA purposes before
attempting the actual unmaps, it could reject and fail the conversion earlier,
thereby keeping IOMMU/S-EPT mappings intact.

This could prevent the conversion from partially failing.

>      3) guest_memfd invokes kvm_gmem_execute_work() which updates the
> shareability and then splits the folios if needed
>      4) Userspace invokes IOMMU map operation to map the ranges in
> non-secure IOMMU.
> 
> Shared to private conversion via kvm_gmem_convert_range() -
>     1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
> on each bound memslot overlapping with the range
>      2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
> actually unmaps the host mappings which will unmap the KVM non-seucure
> EPT/NPT entries.
>          -> guest_memfd invokes IOMMU invalidation callback to zap the
> non-secure IOMMU entries.
>      3) guest_memfd invokes kvm_gmem_execute_work() which updates the
> shareability and then merges the folios if needed.
>      4) Userspace invokes IOMMU map operation to map the ranges in secure IOMMU.
> 
> There should be a way to block external IOMMU pagetable updates while
> guest_memfd is performing conversion e.g. something like
> kvm_invalidate_begin()/end().
> 
> > > is going to be flushed on a page conversion anyway (the RMPUPDATE
> > > instruction does that). All this is about AMD's x86 though.
> >
> > The iommu should not be using the VMA to manage the mapping. It should
> 
> +1.
> 
> > be directly linked to the guestmemfd in some way that does not disturb
> > its operations. I imagine there would be some kind of invalidation
> > callback directly to the iommu.
> >
> > Presumably that invalidation call back can include a reason for the
> > invalidation (addr change, shared/private conversion, etc)
> >
> > I'm not sure how we will figure out which case is which but guestmemfd
> > should allow the iommu to plug in either invalidation scheme..
> >
> > Probably invalidation should be a global to the FD thing, I imagine
> > that once invalidation is established the iommu will not be
> > incrementing page refcounts.
> 
> +1.
> 
> >
> > Jason
> 

