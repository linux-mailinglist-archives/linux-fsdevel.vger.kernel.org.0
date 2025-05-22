Return-Path: <linux-fsdevel+bounces-49695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F5DAC168F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 00:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB96EA42F07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7A26FD8B;
	Thu, 22 May 2025 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQbsh1Yd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628626FA6E;
	Thu, 22 May 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952431; cv=fail; b=Rf45sl5VlevNVVbpsDkJ9vbaMV0gr+gxIHSyNhQLFKzYRjXarAWzvttIvKSAzvfyqhn/fhIqA5GDIBcDOlBZ9IA0/1mTJC9ooJZZS3jch1DQsii38IlXsPP1vONgQLvRomRqTz0KjVxlahMgOw6bDEe8UT9ocBcE//1eLp7ydUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952431; c=relaxed/simple;
	bh=hW6hrxvPxTg8fAfckYB3fADplXFtCYsfx8C1p8pgjkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=afnh+PIaoaoJR/ao3vKWm4JfQBI7b+HZG/c58NR82HVspGIZpjYtk6L+70zTXyFI97CqUJcH9fYKYCped/GlKrBc1iNiIEf0ZV9lqcd49yOLY1oDFYkXJyruPlWQ6CmTywr3NI/O3xL/+JZp6vsUxCq/cMmF/TVh0OlQkDDEtE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQbsh1Yd; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747952430; x=1779488430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hW6hrxvPxTg8fAfckYB3fADplXFtCYsfx8C1p8pgjkw=;
  b=NQbsh1YdI/ntGggi6TTroLLEPYtxgcJQgtszVuDJ1EMSFOSwdQpOo1aT
   NsO53SPA4sYmkTuPHHh/FfMMCjr2rfd2UDf5oP5Zp5V9pFpI1fVX8bKSA
   QMPmuT4ItdH4xmnublX3tpS8txwoztNOKMcSPeEhmKgtW2xzH53f/YcE+
   PP8pMM5TFScd0g9YU5cpWtTgQg5rTOAJmtdX57QuCdjCtDr+kUm2cnbbS
   dSwIrU4xMZOdo+MMjq+RhWckcbw6kHEKBfB2kb87x2ASpNHRiU91MGLBZ
   hKgRbZS1wHlZUrz4nLegy3TcKMDYQ5+ksRdU5rnkvsAJ2BxmdKysMQKL9
   g==;
X-CSE-ConnectionGUID: AGvwZXHBSKKRjSPMdhfSUw==
X-CSE-MsgGUID: koDdFRb4RvyJo9WkGIxzHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60250675"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="60250675"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 15:20:27 -0700
X-CSE-ConnectionGUID: Ghh+uI+FQNm8mYLwPFR7mQ==
X-CSE-MsgGUID: hgRilmIwQaeV9c1ao0bA/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="164063225"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 15:20:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 15:20:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 15:20:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.52)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 15:20:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu+RgDqGKb1saFDe/Psqg8kC26eDIvZpw+p52scTMTNNsXUhP2v6vZtTRBmDj2HZodcBGpda2q7TcM3gXEehQ29DFoR8Sng6Yu87sh9mekk11hlRsYHwbQUJvxXRwF30QbfYXddKvldXFEWPo7ry5H1+Tya2ZXZkZPPW99fY+zZ+NtNVzu3YLQpDMU/JKshFvQQ+WXd0vWS/BHLJvOR4jtSdfonPoANpUwtex14RF91eyxyt/TJcYIkc/VCJrhtp2+q3YBu2ER/gaFhmv9qEBk7P8wUuJPrr2wzsQkfYRuS77Or3Sar3qHp6/VgkHlEl+D831isLw0OgB2I/Ly3Flw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW6hrxvPxTg8fAfckYB3fADplXFtCYsfx8C1p8pgjkw=;
 b=uxmS4t4DThEQmmiDas/pb5tvr5p7r6gZieIZLXQZbTblO/bPfpfHTvedUUvGHd/V/PsyTNomc9kPpWZ2xpv34XSgU8YePwHSxtAYFM51IURZbspRMwkI7dufWdOyVDHZ/bGe+BFMlnznfxAFxVxsXkrxc9Ag4LLCm2B2wLqpPnkbWrxOmDAXwc9ecWa36ofYNw73AVTliCBqrpzvuTYzPJOcbHoiCVU1d/GnKkcZdPSnFlTTST66GRyQZMfRGkBIgsSko8+EYbcDtEt7AhuGRxr5tJLlZhbVDm0ZJAoeET/ndII0yNwfWtQ9rArkuo2x8cjzopka5kOvBeYQtWUSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB7615.namprd11.prod.outlook.com (2603:10b6:510:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 22:19:57 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8746.035; Thu, 22 May 2025
 22:19:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "ackerleytng@google.com" <ackerleytng@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "pvorel@suse.cz"
	<pvorel@suse.cz>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "Miao,
 Jun" <jun.miao@intel.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "steven.price@arm.com"
	<steven.price@arm.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "jack@suse.cz" <jack@suse.cz>,
	"amoorthy@google.com" <amoorthy@google.com>, "maz@kernel.org"
	<maz@kernel.org>, "keirf@google.com" <keirf@google.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "quic_eberman@quicinc.com"
	<quic_eberman@quicinc.com>, "mail@maciej.szmigiero.name"
	<mail@maciej.szmigiero.name>, "hughd@google.com" <hughd@google.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, "Wang, Wei W"
	<wei.w.wang@intel.com>, "Du, Fan" <fan.du@intel.com>, "Wieczor-Retman,
 Maciej" <maciej.wieczor-retman@intel.com>, "quic_svaddagi@quicinc.com"
	<quic_svaddagi@quicinc.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "nsaenz@amazon.es"
	<nsaenz@amazon.es>, "aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com"
	<usama.arif@bytedance.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com"
	<quic_cvanscha@quicinc.com>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>, "anup@brainfault.org"
	<anup@brainfault.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"tabba@google.com" <tabba@google.com>, "mic@digikod.net" <mic@digikod.net>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>,
	"Li, Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com"
	<rientjes@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Aktas,
 Erdem" <erdemaktas@google.com>, "david@redhat.com" <david@redhat.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "Annapurve, Vishal" <vannapurve@google.com>,
	"Xu, Haibo1" <haibo1.xu@intel.com>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "will@kernel.org"
	<will@kernel.org>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "quic_pheragu@quicinc.com"
	<quic_pheragu@quicinc.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "pankaj.gupta@amd.com"
	<pankaj.gupta@amd.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"nikunj@amd.com" <nikunj@amd.com>, "Graf, Alexander" <graf@amazon.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "jgowans@amazon.com" <jgowans@amazon.com>, "Xu,
 Yilun" <yilun.xu@intel.com>, "liam.merwick@oracle.com"
	<liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "qperret@google.com" <qperret@google.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"pgonda@google.com" <pgonda@google.com>, "quic_pderrin@quicinc.com"
	<quic_pderrin@quicinc.com>, "hch@infradead.org" <hch@infradead.org>,
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>, "seanjc@google.com"
	<seanjc@google.com>
Subject: Re: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
Thread-Topic: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
Thread-Index: AQHbxSobNXexLibvg0WApmJDfnUF6bPfRPaA
Date: Thu, 22 May 2025 22:19:56 +0000
Message-ID: <85ae7dc691c86a1ae78d56d413a1b13b444b57cd.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
	 <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
In-Reply-To: <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB7615:EE_
x-ms-office365-filtering-correlation-id: 6887914e-26fc-4b2c-1ff1-08dd997ec899
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R0VZRXRGZFhXNENZL1U3UzFBQ0pVUDM0L240NTRwZTdBbVFqNGFvZkxlTnVC?=
 =?utf-8?B?UW9MV2VNcXkvSGN6bjVyWnRRTFJLMnRuS3ZQMlNxQnBEYlZiZDlrM1hWT29u?=
 =?utf-8?B?U2pwY2ZQU0pzQlQrYllPREFtbllYVjN3UlNJWEl2YTVYL0t1NExpS0p4cTJv?=
 =?utf-8?B?ODJ0eFU1QjFDTFYzVVFld2gyVk5jTlB1dWpEc1QwaDFzdWxTYitud1hPcnFo?=
 =?utf-8?B?TE9NTHBmUDhDb3U0RFA5N1lBK05rNmluMFRkOXBEWTJGbVYvRGtaSFV0Q0Z3?=
 =?utf-8?B?aDl3MXprNDJIT3BMRmJ4ZFloWHR3bFNxUU81TzFYdzVTRWY0VnIzRk1hNE5K?=
 =?utf-8?B?Z2Nxam4yeHphU3MrdjJCUWdHa2JOMzJJNkppUjUyZmZobW4zTG9WYUdHdDhz?=
 =?utf-8?B?WDcvMEJCT2I0TmNCRllEKzBlbHo1YzA2OGhRWmlMZjA5QjAvMFhKdk51dFg2?=
 =?utf-8?B?NDkzYXVVa3Fjck01NXIyTjFrRWJkMTZpSURtd25pUjFDRU1jZEN2b1RUS0s2?=
 =?utf-8?B?MGdpZXBKUE5hRlY3Wm4zQXZTdmdxdXdxSXE4UnpKVXBWdnR5M0hhRDVKNGY2?=
 =?utf-8?B?WUhOM2pIVnE5RVRmbkJhVTBCZFFuRUFsQndBbDhnZk9wTHNaWlYzMk51SGFm?=
 =?utf-8?B?NHEvSEhwVzBKTTErN256OG85MHY1NkV5VXgyTTRxUnN2R0tXT0laV2pJU2M5?=
 =?utf-8?B?UmdDL0VpQzlYOWdkRzZTaFpJRGh2T3BFVlZVSDlpTlBqZU5EKzBrM1UzQkgv?=
 =?utf-8?B?Y0lpQUNDVUM0czFzZjRqOWZxejRLd1B3cnJ2MldrSStoZlN4ZDFIRDFCZTdk?=
 =?utf-8?B?R0hqZWV0N05zcStvUzFjUitpV3VlRVFYR0N3YlhTNXV3cExyOTVWa2FSZ0hy?=
 =?utf-8?B?RVpKYVhnS2FEb29YMFhTbUtmSXUyS0tTRkZpelZ3eDlESzJCUlBQV3VaN2t2?=
 =?utf-8?B?TFpzWG5acGZaN0JiTVFKOGRPcVVSb2pSWUZqcEo0eXFLWXNnSTlCenVFSjht?=
 =?utf-8?B?bVhiSXIwd0lQeC9UbTdjMDBGeGVpd1FvUmthcGZYQ2VIZm9scGc5T3NPR2hw?=
 =?utf-8?B?OG5JaFRrNlg5Zk81ZlR1eWtHeGw4YWVtUlNnWnRTVlFkeG1XWVlSQjQyeDJm?=
 =?utf-8?B?VFBnRWcxaVpJR1NyM3JzbXdvY3U2QTNFRUpMaEhSbGxpVmNZMWpRK1FIRDcy?=
 =?utf-8?B?bkRRMmpJOTdFUjlzM0JRdHd4MnNVdDZkMTY3bXRWYnBHbkFpZ2JuSUluSUN6?=
 =?utf-8?B?UXRXeW03QUF2ZkdmVCtQVk9XL1hsK1Q5TTNmQWVOWEdkRmhlY1R6OFR3SWxL?=
 =?utf-8?B?cFlFWlkzdGFhVXltbXhkejdKbWJuc0I1K0V6SHRXSzllaDFMNE1KVHdJU2gr?=
 =?utf-8?B?Rjd1UjlZQmtjdENPSmFzdzYzQmNWUHd1RTk1dnAxSnUvNkFDNzVEYm9aUUd0?=
 =?utf-8?B?L2xLNThCckc5eW1SMWVkK3kxQ3BycXpwcko5TlpsbHdHck5wYzVrSjByTk15?=
 =?utf-8?B?bnNVRFllQ09FSUNxbStBdkZNOUlvbW9Ja2JGd1ZCZ2UvRFppYVFPQmw5ZldV?=
 =?utf-8?B?QnBJMkViY0Q4N3NBbE1ZYnFySnBVVy95QlVPY1RHalZzUi9EaGRlY2xkazZL?=
 =?utf-8?B?bjZBRGQ5UDFWMUI0Z3Q5S01ScDhWWXFrZWJxOHhoU1VRYUE4UGVsWWlDeGFM?=
 =?utf-8?B?eHFDbWorV2tVQy9tZnZZQ3BmRVZQY21GcENwaTRYd29tU1MyU2tJeFE4SG1h?=
 =?utf-8?B?dW9WdEU4QmdNdVdwVjlVaTFERG1wVlZWK1dnWVRZRkZyM2FUeHB5Rm5qa1o2?=
 =?utf-8?B?WEFnMFVTS1RGeXJKU2pXQjBKb0d4UjFWSTFzM0FoSkJidGI1WEl5RWxaeSt1?=
 =?utf-8?B?NzIvbERZSkZNSmdBY0JONGhYdmZVWWFwMkpLNlltZXJ6akNSWTBnaEJ2SlJJ?=
 =?utf-8?B?Kzg0aExTd1poZnJRd2xQWGJYaiswQ2poR1VuaHMwYksxM1pFQXJ6QStoc0ts?=
 =?utf-8?B?QllIejF6OEdnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1NVMDJvT1JjZmZUd1Vuc0xLTmgzRERxUzc5eWFESGZqS1R1YVdLTytzYzBD?=
 =?utf-8?B?UlhVaXNha1NudWgySTNEQlVxdFoyRUxnVE9OVkFxTXRUQmc0RGZycG1hSkZT?=
 =?utf-8?B?blRyUWZvUlJRdFZDL0JMY09xZ203akszWTdqeXZHRHVzMU8wUzk5YjFaUzZW?=
 =?utf-8?B?T2RhanZKQ0NtUEN6ak45OEM4RUdlUGJHaWoyTmdMSXFnMjZSd3d0dnA0eWl3?=
 =?utf-8?B?RFlFekl3cEpSNGJLeVdxenNsN0VBdEc5aTRVMVB0Ykc0eHZaMmJrUkdWdUYv?=
 =?utf-8?B?dGpwY3lHV2l3NU1BTWtDTjRmOUg0dGcwbVMzUVdndVdiMG1FcjFnZFc4dndi?=
 =?utf-8?B?T1BZV3VXL01HN3ptWmdaUUVxdTcwakw4THlNbHZyWDZpVUFmUjZMSFhJN1A4?=
 =?utf-8?B?b0F2TmVqd2dwNXVyN0RQczBrT1ExTmxMajhQcXprQldOMDBRaW9zNHhGalRp?=
 =?utf-8?B?cXo2ME9ZQkVqWXdYQ0pNNFRoQ05rNTNkUXMzT3loNE5xanBxVUVXRUlxeGdB?=
 =?utf-8?B?eld6Q3gyVVljam00MVdBWjBaWjMyZ25vYlVwSVI4Z0Y1N0hqQXJuYmpWUnFo?=
 =?utf-8?B?Z1pPVHdGK0w3OGtRMU1JQzJHc0JWR1RvdVh3ZWNQZnptTFovN0MwOERNQlZB?=
 =?utf-8?B?M0VMdHFtQjZELzIwS1Z1THhzTnFlOHR3S25JTzZaeEtYdjVpdit5VWE3TFI4?=
 =?utf-8?B?QVhBaUs5UkVabkdWYUdLQk5WUEVGaEozcmkvV2p6cGJlL0cyQmRnOWMxbFgx?=
 =?utf-8?B?UTBSTk5pYXFpMHhNSS9kMmVwbDIrT1hIMlRlcVhuL3BTVlVWTWZ5bkcwK2tR?=
 =?utf-8?B?VUxyYjJrZzRtNUl1YmZRUGFMVzI3MktXL3pIOSswamNBS21LZUIvK1l0R1ht?=
 =?utf-8?B?TnB6S29ubDFJbTJaVCs4cEZpeUw5YmVPOE4vM1BJK3dJREg5MVBOWWdyZWp6?=
 =?utf-8?B?TXlVOFowUk9ZNnVXYU45TSs4MTZJdUt0RFF4bnJTQldlSFUrTjUyd2pTVDVa?=
 =?utf-8?B?OE1SQnFETHA2ME1UWW5lRDM5QTZDRkx1Y3FTVVY0bzZKaUMyeUI3Z2gwTTB2?=
 =?utf-8?B?czhWc1pTdHR4M1BqQmVHNEVWYTk2bm0vc1BhYTZrVDNES2dWbWxmczRxRCtS?=
 =?utf-8?B?bXAwVGJqWUJaMHA4cTF0NXJnMisyS0xlcEVEbHJSZEdvbUdOUVpkRWgyMjkv?=
 =?utf-8?B?VXArc1JMMElkYUx3WXNLQm14cnVQWTl4cDRHRjIxdVpESWl0UVFlNWlJRWFR?=
 =?utf-8?B?L001eXdJby94dTJZbUhZK29vblVkQzJDZDdxRzBNU1h5ay9BQzN3SjFTZVNs?=
 =?utf-8?B?bUlVbUc4eklBbUpNZkQvMjZrUjdEUzlETlNQVmlpL1FGQTZLV2psZ0p3VWdi?=
 =?utf-8?B?UG56RzFGaTA0QTFPQVNDSW5SS1Qyd1Q4eTBCRm92ajl3OUJkdGgxY1NraW01?=
 =?utf-8?B?TnF5MWZpVXkyWXZzSUdyL3ZETEtNZXJGdFBLNUhmaW15Tng2b1pnV0M5RERU?=
 =?utf-8?B?KzdQY0lBWVBxOUgrN0ZOd01GZnI0SURjcmdhcVJWSXlUVURBb0NJVGRXV0Zn?=
 =?utf-8?B?Vmtydm1RbW9iVFJVSXd3S05YbFE5aUZ2NE9WQXBCU1BPZ3dxNWdFSHk0UXNk?=
 =?utf-8?B?Z2tCTFFTbFpvZzIxWld6akExSStrT0NEM25sa3FyZng4ZWVMV085bnZNeGFK?=
 =?utf-8?B?Yms2Ulp4UHpocDAwNjkzVnpmYlcxUTlOMnhDTU0zSmFwdzc4WlNtOHVHaE9G?=
 =?utf-8?B?L0VaVHJCN0sweDdzZll0STlFcUJkNjFoYVhIaVJ4MjRDU0I3dHVWV0xxdURL?=
 =?utf-8?B?ZVIxOTNNRHd3K0pjb3FWbStHdHJibGhEclFMWmJjeGRWeEp6UG9TWkN4RTVY?=
 =?utf-8?B?M1BYRGd5RjFhTDhMK2lYRGJKZFVnUld2SVo0MHQ5YUl3SkU0MGJoRzUwdW94?=
 =?utf-8?B?UWJublBORy9VOUpqVFJvRlhLTVc4MzZCOURkcWJEU3d1NDF6WEc0L3hER1dJ?=
 =?utf-8?B?MVczNFMrQmliK3ZuT1JRMVY5WjRONnVNSW9ZZERZaTllRUt1UUY1T3laVXdU?=
 =?utf-8?B?MmMwS0xFdnQ3d0hVU0tLSzhmMnZpelZmY0wzMFgvS3R4dGJlSEJGT1RsdnMx?=
 =?utf-8?B?L1hNVStENjBqVUk3Y2JKemVHUDI0ZnhUa3E4cU9YcEpZcjlwblZ3Q1AvMGFZ?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38647B14BEA1B743831521025DA6D31D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6887914e-26fc-4b2c-1ff1-08dd997ec899
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 22:19:56.6552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ux20aSIl7j+JMvnxFSbPfMm7i5fRLSngukSQSJikLFa7Ictcg7jND/WKMQyPgaSqFMW7sAhxw2Y5vg9AtyaqMMeQghZ+d1WSp0s0djX5gzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7615
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA1LTE0IGF0IDE2OjQyIC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
ICsNCj4gK3N0YXRpYyBwZ29mZl90IGt2bV9nbWVtX2NvbXB1dGVfaW52YWxpZGF0ZV9ib3VuZChz
dHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiArCQkJCQkJIHBnb2ZmX3QgYm91bmQsIGJvb2wgc3RhcnQp
DQo+ICt7DQo+ICsJc2l6ZV90IG5yX3BhZ2VzOw0KPiArCXZvaWQgKnByaXY7DQo+ICsNCj4gKwlp
ZiAoIWt2bV9nbWVtX2hhc19jdXN0b21fYWxsb2NhdG9yKGlub2RlKSkNCg0KR2VuZXJhbCBjb21t
ZW50IC0gSXQncyBhIGJpdCB1bmZvcnR1bmF0ZSBob3cga3ZtX2dtZW1faGFzX2N1c3RvbV9hbGxv
Y2F0b3IoKSBpcw0KY2hlY2tlZCBhbGwgb3ZlciB0aGUgcGxhY2UgYWNyb3NzIHRoaXMgc2VyaWVz
LiBUaGVyZSBhcmUgb25seSB0d28gYWxsb2NhdG9ycw0KYWZ0ZXIgdGhpcywgcmlnaHQ/IFNvIG9u
ZSBpcyBpbXBsZW1lbnRlZCB3aXRoIGNhbGxiYWNrcyBwcmVzdW1hYmx5IGRlc2lnbmVkIHRvDQpm
aXQgb3RoZXIgYWxsb2NhdG9ycywgYW5kIG9uZSBoYXMgc3BlY2lhbCBjYXNlIGxvZ2ljIGluIGd1
ZXN0X21lbWZkLmMuDQoNCkRpZCB5b3UgY29uc2lkZXIgZGVzaWduaW5nIHN0cnVjdCBndWVzdG1l
bV9hbGxvY2F0b3Jfb3BlcmF0aW9ucyBzbyB0aGF0IGl0IGNvdWxkDQplbmNhcHN1bGF0ZSB0aGUg
c3BlY2lhbCBsb2dpYyBmb3IgYm90aCB0aGUgZXhpc3RpbmcgYW5kIG5ldyBhbGxvY2F0b3JzPyBJ
ZiBpdA0KZGlkbid0IHdvcmsgd2VsbCwgY291bGQgd2UgZXhwZWN0IHRoYXQgYSBuZXh0IGFsbG9j
YXRvciB3b3VsZCBhY3R1YWxseSBmaXQNCnN0cnVjdCBndWVzdG1lbV9hbGxvY2F0b3Jfb3BlcmF0
aW9ucz8NCg0KPiArCQlyZXR1cm4gYm91bmQ7DQo+ICsNCj4gKwlwcml2ID0ga3ZtX2dtZW1fYWxs
b2NhdG9yX3ByaXZhdGUoaW5vZGUpOw0KPiArCW5yX3BhZ2VzID0ga3ZtX2dtZW1fYWxsb2NhdG9y
X29wcyhpbm9kZSktPm5yX3BhZ2VzX2luX2ZvbGlvKHByaXYpOw0KPiArDQo+ICsJaWYgKHN0YXJ0
KQ0KPiArCQlyZXR1cm4gcm91bmRfZG93bihib3VuZCwgbnJfcGFnZXMpOw0KPiArCWVsc2UNCj4g
KwkJcmV0dXJuIHJvdW5kX3VwKGJvdW5kLCBucl9wYWdlcyk7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyBwZ29mZl90IGt2bV9nbWVtX2NvbXB1dGVfaW52YWxpZGF0ZV9zdGFydChzdHJ1Y3QgaW5vZGUg
Kmlub2RlLA0KPiArCQkJCQkJIHBnb2ZmX3QgYm91bmQpDQo+ICt7DQo+ICsJcmV0dXJuIGt2bV9n
bWVtX2NvbXB1dGVfaW52YWxpZGF0ZV9ib3VuZChpbm9kZSwgYm91bmQsIHRydWUpOw0KPiArfQ0K
PiArDQo+ICtzdGF0aWMgcGdvZmZfdCBrdm1fZ21lbV9jb21wdXRlX2ludmFsaWRhdGVfZW5kKHN0
cnVjdCBpbm9kZSAqaW5vZGUsDQo+ICsJCQkJCSAgICAgICBwZ29mZl90IGJvdW5kKQ0KPiArew0K
PiArCXJldHVybiBrdm1fZ21lbV9jb21wdXRlX2ludmFsaWRhdGVfYm91bmQoaW5vZGUsIGJvdW5k
LCBmYWxzZSk7DQo+ICt9DQo+ICsNCg==

