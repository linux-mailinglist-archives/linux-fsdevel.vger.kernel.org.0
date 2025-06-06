Return-Path: <linux-fsdevel+bounces-50850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC78EAD04E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 17:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD5F1899A6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7EB289350;
	Fri,  6 Jun 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2FeXr7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311013EFF3;
	Fri,  6 Jun 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222577; cv=fail; b=sbqNSDf+xt0H+Wm7vEvjWuR5tMnciDY+4ZdeeaE6ZjK2vbk9Z+GMe6+FCF/cJ8XFSO7cA9HfItWIdUuYZOpM+QMaBmiA8PkAsO29GLUzlaUMOONbbDAGODbdcgTzcjZgQHVVkSgvWu3xenLLn8ucM2HP5Y2BIhMNbpvMCE+YxZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222577; c=relaxed/simple;
	bh=+ZN3nZPDeAoC5NkSAjZNLLG2RILW9RerPeZRZ7NrXXs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S//spe8BVOKIH/0uHUGJrohPoKmWwjKRXO2eLXMWiyrvbEnto8kehBdBd0efcRgeZi9C+6PY911GsGSl4PWHo0BHx2EWmT83FBlD9Vt+T0gJ3/zH56qTXSmd5QIMcT6Y4Bjazh084sgO7+vH74qAjTBdNbT3hBLCm/F84P4XMW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2FeXr7j; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749222575; x=1780758575;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+ZN3nZPDeAoC5NkSAjZNLLG2RILW9RerPeZRZ7NrXXs=;
  b=i2FeXr7jN7n9yY+QjJe2CDxkXCYAWv5YNTsf6X0zx7jebQ2GeJWNNh3o
   TXgjzvImPKQMfPvFuRO6ayDush5m5lBb6eUfGMLotsjJAVMLtZoTNZ1U4
   hjBDNuOMArZ/EWtbpMtm9jxfa3wWlPc3Nyj4VXDnCbvJnadStOnvMWyfk
   KeAjhmSDxuvMYDoy61b2s0pIIZUpYqEKxED56nOIdt0zNpp8h8wy9/lXe
   hfy9g4WyQzXaCNPrsiQJGek+XvIwImApLn9hi7J8MEOJglbX32rxaPGvP
   M61tnjnJeugHoGkxz2baB0zmIMtrzfayJVw1kTcaVeXnNhWLM30PStOXH
   A==;
X-CSE-ConnectionGUID: x8sDMec5RZyvLKlKC8CliA==
X-CSE-MsgGUID: tRiG/8FJTWKKpC+GVd/2Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="62734014"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="62734014"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 08:08:34 -0700
X-CSE-ConnectionGUID: zKqOytjLREaAokSXA7g2yw==
X-CSE-MsgGUID: Vh1hEcIcTyCO2A5BCp1YyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="150685917"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 08:08:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 08:08:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 08:08:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.56) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 6 Jun 2025 08:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUAMc0zcaBiTFHZPdAJe0K2hmZGQGASrWAMonAVvdkxCMiKi/DsKZTQFrzokWRd7Fwh8+KfLwA++s1QeyQgYsYCcM7g+jxEb+0NJwHV+Qn2W1ULoHqZp58KOPqIfXrHBxGSvloBUuNuX4VzA3J8bkV7NRH+9vkhoSNuVQGr/tOYrRJyDQEuXFNbTnD3BBr+mkKlmvQUknOgPNcNWm+0Gb7CdgPjIYs9ByU6gXnkeR14Rs+PdCTrZGBTryjGVO0euGSeH7ER9QkO8I46tSSod5VXDyLuALl/SNWJOQX4fGnY2MWWir6CjQE1iYgj+2n4cwYgMgTyNm4ytgS4TFqUkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLNlnXDl/suLR42cmko/CHaJV2RTszdMAaLL9q5ARM8=;
 b=cMd70QCpn/TASaDov+7GH6uTkEP/rMh2y2MLP94kk/f5amYlsrT/3yKrc16SBS+pFNsG52x5g0yfkRyLYf7gkGN/X6oCe7pvtU/ueFoFJIMbnbkRw6Q1X7gj7hLWFkIZgSkNNzZAfP52i/gBGrY3F3PGlpxdF2S5dCDfbRgsB53nebJfyA9RxTldMWOhnrdka+xq7ooMr64lw8XVfowHVSmMqrlj7Tcc1QDrUceZq8quJfLmzcBTKhUuhzihQh8u5FSoDcXH6lmfXXjcFdtZlIobfz3lK5slu3NxLqboJRALkHkbxxd4V8FnXMlqU6EkdoJjIw2NET610E5Nqn4J/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 15:08:24 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 15:08:24 +0000
Date: Fri, 6 Jun 2025 10:09:11 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Paul Moore <paul@paul-moore.com>, Mike Rapoport <rppt@kernel.org>
CC: Ackerley Tng <ackerleytng@google.com>,
	<linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-fsdevel@vger.kernel.org>, <aik@amd.com>,
	<ajones@ventanamicro.com>, <akpm@linux-foundation.org>,
	<amoorthy@google.com>, <anthony.yznaga@oracle.com>, <anup@brainfault.org>,
	<aou@eecs.berkeley.edu>, <bfoster@redhat.com>, <binbin.wu@linux.intel.com>,
	<brauner@kernel.org>, <catalin.marinas@arm.com>, <chao.p.peng@intel.com>,
	<chenhuacai@kernel.org>, <dave.hansen@intel.com>, <david@redhat.com>,
	<dmatlack@google.com>, <dwmw@amazon.co.uk>, <erdemaktas@google.com>,
	<fan.du@intel.com>, <fvdl@google.com>, <graf@amazon.com>,
	<haibo1.xu@intel.com>, <hch@infradead.org>, <hughd@google.com>,
	<ira.weiny@intel.com>, <isaku.yamahata@intel.com>, <jack@suse.cz>,
	<james.morse@arm.com>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
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
	<seanjc@google.com>, <shuah@kernel.org>, <steven.price@arm.com>,
	<steven.sistare@oracle.com>, <suzuki.poulose@arm.com>, <tabba@google.com>,
	<thomas.lendacky@amd.com>, <vannapurve@google.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yan.y.zhao@intel.com>, <yilun.xu@intel.com>, <yuzenghui@huawei.com>,
	<zhiquan1.li@intel.com>
Subject: Re: [PATCH 1/2] fs: Provide function that allocates a secure
 anonymous inode
Message-ID: <68430497a6fbf_19ff672943@iweiny-mobl.notmuch>
References: <cover.1748890962.git.ackerleytng@google.com>
 <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
 <aD_8z4pd7JcFkAwX@kernel.org>
 <CAHC9VhQczhrVx4YEGbXbAS8FLi0jaV1RB0kb8e4rPsUOXYLqtA@mail.gmail.com>
 <aEEv-A1ot_t8ePgv@kernel.org>
 <CAHC9VhR3dKsXYAxY+1Ujr4weO=iBHMPHsJ3-8f=wM5q_oo81wA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR3dKsXYAxY+1Ujr4weO=iBHMPHsJ3-8f=wM5q_oo81wA@mail.gmail.com>
X-ClientProxiedBy: MW3PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:303:2a::34) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CH0PR11MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 8879f3e8-f363-4255-2726-08dda50bfb7d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG9YUzZOeUVnV21UaWs1c3dqazFKUDJTQ2dHQkF2Qm9abDhkODVabkIxQXM0?=
 =?utf-8?B?RWVhc1JNYU9tZW9seEdvRUYva1dRVjE2VFpSSVplclRCZ2dRQmo0V1pPYVBP?=
 =?utf-8?B?TVp4OVRUUTB0TTkwVU1Yb01xTk9Pd1MrUU91KzQ3aWE4aHA4UkdRM25yUDl3?=
 =?utf-8?B?aGFkOHlGUlRyKzFJZ2I4Um9kZEdCYklsWG9wemtDZmVDVjc0ZDRYczBuNWxF?=
 =?utf-8?B?UktabFBaZndzMUxuMS80MXVRTm1DZ1BWQ25xSzNPbk1RMnRGaWpkNjE0c2lu?=
 =?utf-8?B?cWhQK3U4blhsWXRENUtEUHh2RHVSNzdEU1hZZUlGMGk0c2tDTEV5TkNRVmtp?=
 =?utf-8?B?dVh0cTlaRmo0RWlDQ1JSUXZKN1Era05iZzVBVmRCdjhQcDhYOHJrVm81VEpw?=
 =?utf-8?B?V0FPM3hnU0hXTW1EOVliZmxXQnRJYzNzTlYxajlIZ0dTOGN4cFB0VlZDQ2tM?=
 =?utf-8?B?TWtibXg5Mzl6SzZQVjdWZEZETVBHQlY1T2FmVWUxNElZT0E0U0hHbFBldEhS?=
 =?utf-8?B?Zkk2UzBnUnJQejVqWUJZbTc2NFVWR05IK0x4NHJyc0hneTlmVE9JT0paRmts?=
 =?utf-8?B?MjBkWTRYd1YzYm15cjREa3FSQTRVSDZiQ00yajY5MmdNQkV1azdObjlnVVBQ?=
 =?utf-8?B?eEttR2EyOFVyVCsvalFBWWZJRlAzV2h2eW5WaGZ2Tm9ZZTRlTWMvdVB0RXJK?=
 =?utf-8?B?ZWJpVEV6TGhWQ2Q1cnFmWllRQWJEeTJ1OVVvS0hMcnpjdG8xMGRmOTgvMFh5?=
 =?utf-8?B?bTVwU25rSGhDSjJ6VFIxSlF4bFZ2VkoyVFR4OThUcWxab3lwRE94ZHE3Z3dF?=
 =?utf-8?B?UzE5b2R4ZVhxT1daUWYramFqUDFUUmwxRmw4QStSL2lGZnN4TEdONEFIalJx?=
 =?utf-8?B?Q1V1b2xCTUw0eGJHbHhZMElnbTE2UWZYd3FpeVlUMWx0UXdVWVpOaEE5NU13?=
 =?utf-8?B?MmN5T1g5aXZPMitJUlFLZ1piWGpNVU1rQXVyN1F2YUVoOE84Vk9adUxzRGty?=
 =?utf-8?B?ekdTS05oTldabVRGSjVPMkZOM1hCMTlxYnlob1RJS0lYNXc3RU1ER1dZczlC?=
 =?utf-8?B?clRUYmFvUVVQVWVnVFFwZitSYXNsS0N0WC9Qbys2aWp1aEJFU2FRRXozcW81?=
 =?utf-8?B?NkMvNXprS3BiYjZDbFdzaHRKVUhEWGJDa0p5Qmc4V3h4elJRa01WZVBXNzEv?=
 =?utf-8?B?S0RhL3VmMEJ2M3NzKzV5bXEzS3Q1STFxWmVIT2ZmaFczdVJqRlJaa2Z0Rlkz?=
 =?utf-8?B?NURGNmswVE8yd2lmeXovc0VSRVhxS0J6cGZrRG5UQjdaZGowUzk1QUZoMit5?=
 =?utf-8?B?Ky90SnhvZlZOYk9Ec0srenJZUmlQUko0UE9pamREQ1ZaQXFraU1BZExZY3pq?=
 =?utf-8?B?RFE1Rzg1OUpBU2VTYXphWWJhMnZUOHRjSEE4SFNIZk5CS2VjbndoN2tkVzNW?=
 =?utf-8?B?eWRQSnFFbmJFWjYxYkgxN0RsVXd0dVF2SGczbnMwMXNyeG1oYlVnbVIybTlC?=
 =?utf-8?B?ZWRCMy9OZDVTN2VCNnMwcXFCSUlIdnU1SzZNVCtLVHV2U1BMRGZhYU0zbmw4?=
 =?utf-8?B?WUVIcUFraWpzSllrRzhCSm5rbzZoR2Y4WTE3bGRiWXNYS2Y4OTlndmVNOEly?=
 =?utf-8?B?Z1ltK05jUklteTB6aTY5dkJHQTIwdkNLY0xuOXF1ZGRWSWFwOG9ieGVDRlg0?=
 =?utf-8?B?L0ZjeDNCVE5ybWZDUnBkTHNBUWJwY25NZ3Nkb0k1emZ6NjltUE1oMDlqbkNn?=
 =?utf-8?B?Mmp5M0U5MWJIM2ZRZXBxVGRBTC9SaUdhNTdudHJ0UUd1V3N5YndCcGJmbG9Y?=
 =?utf-8?B?WURrNVozdUUxZWhDb3BVNVgxRER2L2lIRmxWSEhZSDRBQ0RVZWNRRkV2OXND?=
 =?utf-8?B?NlNWemk5VGJheEVKa0tXSDJkVHY2a3ZqUC8vNFZiZmNRR2wrUlUxYlR1Tjg2?=
 =?utf-8?Q?ejqlLHZlmT0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXRTS3dpSktWc2Q0eHhuRUp3NTlsa3JhNW1qeDlER0hKVmN3cllBSGVGYkJY?=
 =?utf-8?B?YjB2L1pwS2Vwdm4wVWhraXJnTHAvVG42RVNJbm5ENUEvSGR3SXhVTmxrcHF4?=
 =?utf-8?B?NU1RMXhKNkhtMXlrazhHMXZHbEQvbHVmUjBjOVI3QVRESU5QT2FiSUIwcGlE?=
 =?utf-8?B?NXdNeFk5V2QwVjhOand6L3FYZFhqVGM0YVlPLyt4dVBlK3NIeGovWm01OFBN?=
 =?utf-8?B?S0dpeEpuOTg5SXZWc3hkQ01UeVFjcXhVT1dXdnNjN1NkK0hRc25QekdMcWti?=
 =?utf-8?B?a2JGU3ZmaE9ZRWFvQjJDNFl4ZTIxWXphSW5RNkhvcTVXL3VidVFDZ2kyNVBx?=
 =?utf-8?B?aE9HYTN0dHVEeXp2dWRMRldYeHFmWVZvUHI3c21KcDRkQk9GSWp3d0FSTnZt?=
 =?utf-8?B?Y2VhSFllQmdLZERmSjQzMnNSa3FBcEVWbzhSYlFXZW1hczZrZjMzRSsyZGFX?=
 =?utf-8?B?L2hZZzlvZ1R3OG8rNVZNU1dnK3dTWVRzdk5sNHhjL2Q1dWJsWXhPMmNxV2lH?=
 =?utf-8?B?MUpTV0tOWEYyQ0x3WnpYWkNMcDlTMVNIdFptRnoxVGp6MXIxN3hIeW5RYVd4?=
 =?utf-8?B?UnIxanZsUDhrTkROdGtlU3dJb3AzVElVNDBkNWF6OHlIV3hwTStwTFdudkFH?=
 =?utf-8?B?anFITjU0WHdQUjU2VWZPaHczd1lhTU1xbEFRMTlwYXdmOHdnRGRTUHRydnlh?=
 =?utf-8?B?QnFPTnpGeVRjWHNGb1NWSE5QYTgwSGVIdVJaQXJ2Y052VFYwSzVGQWhsTnVx?=
 =?utf-8?B?R1YwcXd0cm9PamFleXBCT2tyVWorcXJSZlJRVmp3MlRhY2VOU0cvbFh6b3hM?=
 =?utf-8?B?bllQQWt4NGlnZnFHNGdwT1UzQWcxU0ZzWGFXYXBvMmxkb0tJQ0l6dVF3UmFI?=
 =?utf-8?B?dTl4VGRGSllyU3lOZllTZzlqTlFGRTQ3N3I5dmFQdXF6RWxIdnNROFBZWk4y?=
 =?utf-8?B?ekpEa25DMmFzVmVtVnI0QWtDa0kxdk5CK3pJWnlZb2l2T1BIcUtnRUtuZytS?=
 =?utf-8?B?ZTJpQSszNGlza1JUYXRuU2VqeXFTMGdtc01NcjJFR3NPeERoUUVkeHg2aFJi?=
 =?utf-8?B?Rlk3aHJjZTcvTUxYRCtOT2pxR1VtbmFqcTZ6cmxTbFVJaWc4MHN0S1ArTnVN?=
 =?utf-8?B?TlVadDBPUHRLNURsbE5JVDd6ZzhuVWwvak9aNmNtMUtEUzRkczJHQ0ttc1lC?=
 =?utf-8?B?WTFDRy9JcVJuRE9JQ2VBbnQyM3JqbWlqOVB0Ni9IOGg1SFMzd2Y5d1I5Smwv?=
 =?utf-8?B?dUlvU3RhL2NhQU5GTFVzelpLVWpURFRCZ0E2UmtDM3ZPOVFpaDl6VTlkcUU1?=
 =?utf-8?B?eDhxaG1zRGowbTBPUERmSFFSN1NpTnNhNTR4bEt0RHdZSHFyY24rWU1wTG03?=
 =?utf-8?B?RjRPZjVhdzBUdy9lLzJOaFlVRnNZN0ZFWklZUXFieFoxWGZ6M0h5UnkyMUxZ?=
 =?utf-8?B?S0ZzV0JXMW8xbmJRTnBCTFlKYXBjKzJhVTlsSzVwYmoxQVdHNUdPZG9xb3ds?=
 =?utf-8?B?eDF2T05FSWtUdGJHblBGZi9xamhLQUhCTHAyYVA0TXdXdW9ubnI5enkzZzJh?=
 =?utf-8?B?S1RldDlHZnU5dFU0Y0FtSmltVnhKcUVyaktib3pDYUpjRm1DRWNKZUF4UlpC?=
 =?utf-8?B?aFJSbFZWRGRSM3VUOTBBSWZvREVIOFVUQXI3WlVBSUVIV2ZaS3Fmc1FlYUd4?=
 =?utf-8?B?VGVoVHNhaGpBdkU0SXc4UFd2eWt2d0tQbXM1Vml4a2MvUlN6S3NlazUydEZV?=
 =?utf-8?B?R1FQRHFseGJCVmZTWXVKZDBEbHVlSWhIN2NPaWNxRnpPTHlUK2E3dDNsd0RH?=
 =?utf-8?B?UG8xWWkrb2c2UEc2TVcvRTJBelQwbmN4RzJ5d0xIQ01iNjlnaHhJanBva211?=
 =?utf-8?B?cCtVS1lWV3hRekpua2xCRXlLLy90dS9PU0p0RXhzL1NyUXJkMkNQSlFKMmsr?=
 =?utf-8?B?MDZ2ZmxJbi9yOGNPQUhmc0d4Y25BNmJidS9FU2xMNjlrMDRLMmpYdmF0cU4v?=
 =?utf-8?B?c2NCV1BDZnFtR2JjNzQ5bmxncU14TWd0T0VmbGE1NCtCZnZlREdQR2FjTnRy?=
 =?utf-8?B?ZUYzK0pYTW8wWXhMWTZXTnkwOG9SYkpmY0c0bHZhTGlBcXllTlZSYTZMUmpr?=
 =?utf-8?Q?bma9UEVsn1FwE3c4C3wrqehYI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8879f3e8-f363-4255-2726-08dda50bfb7d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:08:24.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+l5m7VssgHlA3vwz9cL3VbgzGMq8qupU3WvoWRKM83XQJNsD8Xk4ibsiF/hollSDOqxi5PGBhZkkf+pH3hkWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8189
X-OriginatorOrg: intel.com

Paul Moore wrote:
> On Thu, Jun 5, 2025 at 1:50 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > secretmem always had S_PRIVATE set because alloc_anon_inode() clears it
> > anyway and this patch does not change it.
> 
> Yes, my apologies, I didn't look closely enough at the code.
> 
> > I'm just thinking that it makes sense to actually allow LSM/SELinux
> > controls that S_PRIVATE bypasses for both secretmem and guest_memfd.
> 
> It's been a while since we added the anon_inode hooks so I'd have to
> go dig through the old thread to understand the logic behind marking
> secretmem S_PRIVATE, especially when the
> anon_inode_make_secure_inode() function cleared it.  It's entirely
> possible it may have just been an oversight.

I'm jumping in where I don't know what I'm talking about...

But my reading of the S_PRIVATE flag is that the memory can't be mapped by
user space.  So for guest_memfd() we need !S_PRIVATE because it is
intended to be mapped by user space.  So we want the secure checks.

I think secretmem is the same.

Do I have that right?

Ira

[snip]

