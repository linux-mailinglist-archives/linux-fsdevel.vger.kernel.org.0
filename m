Return-Path: <linux-fsdevel+bounces-54205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26203AFBFA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 03:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96511AA19E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4481E47A5;
	Tue,  8 Jul 2025 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9fQSkdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C28800;
	Tue,  8 Jul 2025 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936889; cv=fail; b=NEbogh0jJNhYgTbyTvTZIpyB293oIOJbPg6VuwqEpY5R0Rd3kWyMpaFGvI0u2/0/8mjiyQ9wORgUI6a2upWAJxEuSfVPJG+/Vw8W/LQQLABUd+Bz/eofvwcDFzAmW/GO7QDe0YEr3mqoy/b5RUYJzh7wpLionqYWUXcBqbML6Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936889; c=relaxed/simple;
	bh=XXZwdkoMTcqAV9MuIMDj3yDXDgXyfgvj91LEeo+7RV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BEuBTmDWepdbshdCa7QHdsJzXhB/fsDGTN7mH7rghhEuaTkcEIhY5wwb8rWNtzJk/175rtibdWa7VuxzipfKP6kQpyoxeV5S3qlAtJmMhh4CucSupq962uuigdRow1HD1fUEIIiMASbDFAVivrMp4GDl4TAR3lhynojinpTeipo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9fQSkdY; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751936887; x=1783472887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XXZwdkoMTcqAV9MuIMDj3yDXDgXyfgvj91LEeo+7RV4=;
  b=S9fQSkdYM+fxIbFkLvaus1FOJ9WfYF/vLvNJHEFDFE0WCTea0b2yFY2l
   p9Kfk3d+jLmg6Frni5Wnesz1uzpkcyX2oU2FHCrfwjpTpE3J+cob0s7tm
   C0VS3caC03BRx5NviLe4Z/99aCSaLN8u0S7OdUMMKC0Y+u3iMpwoivovI
   90QPxw5+7HrNq8r1ZyD0aPzpGZ+PovWM38Q9I/S9dpsMaaIXnNykcrQ9a
   irfWpeuZCpgoLPm+OVM9NwB/sjWKj5qMuPORp50QERKgJs+M9CD2bzC/5
   34JMeDDwCq5FjEMUqslBUfEet1WGC8p1VM6iEX5B5LwEQkQitOkDn9o+r
   A==;
X-CSE-ConnectionGUID: SYPB1zkfQ024ySZpboAiGQ==
X-CSE-MsgGUID: 7VhVlni1RAecGvwg9gMgaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54092758"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="54092758"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 18:08:06 -0700
X-CSE-ConnectionGUID: Hq0zvsylRYqcFpLU1kRLXA==
X-CSE-MsgGUID: S6tKAR9kSBGS861DTppdhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="154780195"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 18:08:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 18:08:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 18:08:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.50)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 18:08:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtND9x241/TsW382h32SzvCPyUJ1E+2mbNYDvxmmyVsvoEuUo/9dEuZtSEUzSyH2VTgOp/5Oo+toFeLbOEMHE8MF1LWY56Olcm+7crROtl7XQlz5sQiYDNY6RNTXeNNrPipMXMrJz8Ad37avn82/AQV5weviO3xWoUNMvLXqoyHQ1PSANo0IZZVPrvxxC+bqkXmTGu257Ei8bybpGvXF71zRD8gKhwkmJcURWp2huG7sHL7f2EugnmZ5rYK+Rau8EVHw8yD6XN9yqK7t3dm1kNYSgMZwosv+gdQngyFBE1aVtyWfgh2T3GUBT2YqivzDnZvMZbCIbgOkKLPksojLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXZwdkoMTcqAV9MuIMDj3yDXDgXyfgvj91LEeo+7RV4=;
 b=Mzs0JBVxH0JK+ojj08O7Kkqq8sxbp62+JpTD6JugATMvZZfuisIgcMUntHwtn9FwQp5uFzW0WFSAKds5NMI4vc2PWByM9Lnkf5lfKJV5jIp38aZetCxQkKyoA2zaWcsSOa6wtjuTEXf7ozI8bNl3+Ktg2fU/QwzqSxJ1spy3OdOl1PEcHaItG92r9mx6KUDRbkAjd6HnnkrMZJd7HL0sJCBngKFmqjBxOODukc3oocN+3CHT6Hzn/3Xq6NjyzXT0VSu1Vj+IWmV3tK8MUbPqc4gcLK04phFNB136+vS5sAJS5S86WhbLbmtMqkvGc6a0vL0qHAGs3rT9bb5HFTq3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 01:08:02 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 01:08:02 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>,
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk"
	<pdurrant@amazon.co.uk>, "peterx@redhat.com" <peterx@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "amoorthy@google.com"
	<amoorthy@google.com>, "jack@suse.cz" <jack@suse.cz>, "maz@kernel.org"
	<maz@kernel.org>, "keirf@google.com" <keirf@google.com>, "pvorel@suse.cz"
	<pvorel@suse.cz>, "anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "hughd@google.com"
	<hughd@google.com>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"Wang, Wei W" <wei.w.wang@intel.com>, "Du, Fan" <fan.du@intel.com>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>,
	"steven.price@arm.com" <steven.price@arm.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "fvdl@google.com" <fvdl@google.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "anup@brainfault.org" <anup@brainfault.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tabba@google.com" <tabba@google.com>, "mic@digikod.net" <mic@digikod.net>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"rientjes@google.com" <rientjes@google.com>, "Aktas, Erdem"
	<erdemaktas@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"willy@infradead.org" <willy@infradead.org>, "Xu, Haibo1"
	<haibo1.xu@intel.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>,
	"Graf, Alexander" <graf@amazon.com>, "nikunj@amd.com" <nikunj@amd.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "jgowans@amazon.com" <jgowans@amazon.com>, "Xu,
 Yilun" <yilun.xu@intel.com>, "liam.merwick@oracle.com"
	<liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"Weiny, Ira" <ira.weiny@intel.com>, "richard.weiyang@gmail.com"
	<richard.weiyang@gmail.com>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, "qperret@google.com" <qperret@google.com>,
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "pgonda@google.com"
	<pgonda@google.com>, "quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>,
	"hch@infradead.org" <hch@infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>,
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrQKWaYAgAAM4gCAEFZTAIAAkwSAgAC4SICAAP4mgIAA8aaAgAmqgQCAAA20gIAADwOA
Date: Tue, 8 Jul 2025 01:08:01 +0000
Message-ID: <006899ccedf93f45082390460620753090c01914.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
	 <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
	 <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
	 <CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gCiDS6BAFtQ@mail.gmail.com>
	 <aGIBGR8tLNYtbeWC@yzhao56-desk.sh.intel.com>
	 <CAGtprH-83EOz8rrUjE+O8m7nUDjt=THyXx=kfft1xQry65mtQg@mail.gmail.com>
	 <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com>
	 <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
	 <aGxXWvZCfhNaWISY@google.com>
	 <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
In-Reply-To: <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB6223:EE_
x-ms-office365-filtering-correlation-id: d50a715d-ede3-46b8-5848-08ddbdbbe2f2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WjFHQktMSmc2N0JWUlcrMDFqSS9nK1daRFFaYXhRZjc5eFlQWEI3WkVXbHNw?=
 =?utf-8?B?cmpHelc5REhuWFdEQmY1Nm1TRGh6eTNwODhDcWFBZmEzWTliT3QvM2tGZHZL?=
 =?utf-8?B?b1hDU29YWU9iTndzZ05QYTVOeTI4MHhMc0x4ZzF6NDNLcVVJMFdZNFU2OWxt?=
 =?utf-8?B?bTFQZUFGUi9ueWN3cGZMb1dNcFhKUHRkeUFxNzV6OUJPbncvMmVXR0hlN3dQ?=
 =?utf-8?B?Q3phT0lILzZTdEdOa3BaS1A3NzhhYnZTeUJzZUJPejBxMlIydDZyaG52WjVD?=
 =?utf-8?B?R3k3cHdxTEs2MFhIU1k0ektUQ1RjT3IwRlVGK0FzdTFnWDRaL0JqWG5veUE2?=
 =?utf-8?B?L2RXY0xoMCt1TktCRThpNWN5RGJhRVh0TVBrWXdvcERHczZHRXBVK0FoeFp3?=
 =?utf-8?B?OTJPV083Z3lEZnNvUmhXdHRDNlNDWkdPdU95Uk1oalhlRFI0VWI4dVZxQ05Q?=
 =?utf-8?B?eHQrNkFPMjRmVk56RTZkeFA0b0o5aTBRMEZBVEFNNTZkNmRiR2R4TXJEMS9E?=
 =?utf-8?B?Sk5RMEJ2NGdyMmhCanpNVytMN0FTSUkxb01rYlN3TGR6K2tjV1RRRUsvNWU4?=
 =?utf-8?B?ZE1mb0ZySkxWcDlSdTg5bnQ4c3VxRUcyUDZMOWxZbTJhVTFsV1pZU0hYcHNL?=
 =?utf-8?B?VFpjNGJYU3RpOTQybnRUeWQxVlJKL1ViM1p3OGZtdTFhWU82dVF1d2c3alBQ?=
 =?utf-8?B?aXQ0ZldwTXpia2pZT3hKdmZGTGFmZ3Y5ZW5xcENxTW5FbTdtaDlNd0ZUaUtK?=
 =?utf-8?B?U1FoaFg0M2ZSUlhhZndXbFNXeDQ4a3kxSzFVTlR2TnNBWFh2eG1WZnZ5MU1y?=
 =?utf-8?B?YmxmT3dlM1ZKQlRHcTY4RGRWVm1BbHQwL2NQb2daY2IwTFcrZlJTYWNyT2R4?=
 =?utf-8?B?MmZydEswd3pCczJtWnZPcUR3WTA1eGlDK05qMXUzcTV6cjRVOUdrcUZFcmtr?=
 =?utf-8?B?KzcrMFp0RmlldFZna2t2UHlweERPb2ZRQ1JzemtoRXFESVhqNGltZUxkdXZS?=
 =?utf-8?B?SUcydjkxekN6eGZaN2x2Y1cxZFNOdHZDaXpXbG83bVNzd0NnbEF3cTJRY2JI?=
 =?utf-8?B?QWdUQXplTkR1ejRYVUY1ZUE4TkJRdjVpdDlzMHplRDNFYngrMXJRdGM1eEJX?=
 =?utf-8?B?dWhYSS9vYmlXTzcyaG5yRmN3UXJ6R0VQQWVLb2lOQytNWUdMbWlxS0pSTXcy?=
 =?utf-8?B?Y1dDZW1oWEJTaWxpUnZhOWhLM1NTNWN1aHZyaDh3WEl5djBtNnBMb2ZsbzBn?=
 =?utf-8?B?cHY3ajYyVjFUeHY4TUFGWEtIT2J3VUtreUl3UXd3Rlh6a1k5dXpFL2RqbVJz?=
 =?utf-8?B?MW1CTzVlYld5b0IrdEdnay80NlBMSFBnbDJkUHdnNWxCV00rc1JTOXBBR1Iy?=
 =?utf-8?B?UGF3eTI5RGswYTE3ZnlHQmNvemgwTGx0ZDUra0tzOWZDTVpoRXdoTXdGNmNS?=
 =?utf-8?B?SVJnR2tIUUEwUTIzMUVZd3p3cFNqU3pnVWJoWk9kenBiYmtnaDZ5K0IzTGZn?=
 =?utf-8?B?Z0lsWTJxSkt4WTUzZVhpSi9ad0FTOEpNaHAwa01vZU5EcmtzQ05aOVhEMjN3?=
 =?utf-8?B?L1NDRC9HbThtOXl3T1lGblMrcys0Tk5uTmI5ak90SDJHV3NqTCtxM1RFOFNK?=
 =?utf-8?B?OEZLWWFjNFFGS1FqaDRqODJDdWs5TS9rNXROeHNZcWZwNEl6d0s0RVpTQjVY?=
 =?utf-8?B?emh3Z25VcXZTbFZBNEMwODRDR3BzbXpRWmpLQXhsT2JuZXRsazcvRlVmTGhr?=
 =?utf-8?B?TURjcTJwWGJHdmFZQWdJZEFxMGZEc3VSdXA4Y0VUaTAyaG5TSm81RlEzR3RW?=
 =?utf-8?B?RkQxNS91RWVMdlJwZEh2WmNqeUg3WHdReTlFSC80WmJmYzBpMGNPeTlyY2tJ?=
 =?utf-8?B?dVRWd0U3QjFCZmRTQmlQVlB4aEFFM3FiamJpS3RCSGR5SDQyb1dHYnV2bU5u?=
 =?utf-8?B?MmR2L3VPY2w2clZpOTArbWhRMW5kdFNhei9vKzkrelhNc0FpWEVvVStURUtG?=
 =?utf-8?B?OW92dVRHK1JnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXF1TzJJQjFvZTlldGlaN2wvVXFwK2VZcjljRzc1V1poZ3FnWVp4R3orandO?=
 =?utf-8?B?RWFrdGNXZkE1dW9BTERzeHUzS3hLLytJdEs3WEZWNU54YWlMWVltUWJrTTF2?=
 =?utf-8?B?WG9HYXY5cE82clBRKzBFMlB1Z3VtV0E1Ry9yb1UySHFGWnFkOTJ6dkxpeU1u?=
 =?utf-8?B?OFJiRXJNemhQMXRlZ1FjeWs0djNreEFoblVRUk9wekhsYzhQMnpRUHNiWFY2?=
 =?utf-8?B?dzNjcDZqcVk5RDIxaVR2MzN3UHUrMHNYV3JReG1VaHhvano1QlFHRFNIRnA2?=
 =?utf-8?B?YjFTMVZzWlBCSWFqKzV0UTFhLzd1UXVMUGhtRGRlc1dmWEJ6SGErQmN4ZU1h?=
 =?utf-8?B?dlNLUUhsVWJHejlSR0NubW1la1dDdU9FWU1CWjJZVHdPZld0bVBOMWFDcFRr?=
 =?utf-8?B?Wk1rVWk1NU1jemhLekxJaFdWa1RrYmlkSlZBSndPK2hWRnFUd1lKZXR4T3Q0?=
 =?utf-8?B?cUVwR0Z6Zy8zakgxNVc1dTFJMktLVkljU0s2VElHU04xa3Q4dmFEZFY1NS8w?=
 =?utf-8?B?eGtpZ0FraUhkRGFKOTZyVEFPWWttRTUwM1U4M0N0ZENIZ0llaUMySGVSWEVD?=
 =?utf-8?B?TTVuazFHczVKSTJYNVpVZFlCbUcyWTFRQXg0ckZkdXFpckJJQzQydzIxYWk3?=
 =?utf-8?B?STZJUVowVnlhRVpCRGpOaGpzbVNabXkyeEpmUlU2cVJUL0ZSWWMwMjlaUkdw?=
 =?utf-8?B?UWFZVWxzVjRZeHR0dHpDMDliT2ZKTzBRWmJ0QlJCREhweFlROGlteDZQWkVr?=
 =?utf-8?B?ZzdJenJTQk5HQnlQR01sOWNFakVMRDE4TlhKb09aaE5IdGQveEpKMkxlZnFv?=
 =?utf-8?B?b0p6a3Bja2dDa0Z6UHJUcmtIcFZrTXU4OVBka1Vic2NOWXR4Y2ZVa1NpUHlm?=
 =?utf-8?B?YzNkQUhJaW11OHFSTVM1NkQ4aUFicDB5d1lrN2JhQ2o0aGhZSHpNVm5iSTRv?=
 =?utf-8?B?aWhEdUdYanhDc2tkWEx4T2JjUGYwVUo4YzdEMTFOa0tITGpRT0xudlRLYlYr?=
 =?utf-8?B?MU9QczNqRXBwMm1KcW5CbjJnWmF2S1JtU3FFM05sMkFRY0ZEeXlmb1p0UVZU?=
 =?utf-8?B?eS84S09YNlAyTU5iV0dvcnRFNlBhS2tLNWJ4b2huR2J0NmN1aGh6bHRFbGZk?=
 =?utf-8?B?WG90R2ZPUVZlRmxCUFRTUS9xczdJd1RabWJkeEdaRVNaUUc3WExCbEpwV083?=
 =?utf-8?B?QlFoQWpqd3BlWVlUTXdBQjRWZHEyWjFBQThKdEMyY1JDb0tad3hMcmFyVHIw?=
 =?utf-8?B?OUtTbVNJSU12dEFNRGRFTHFtcTBqNVVPT0I2QXFCTnlzOVNuQ1BhTVFKK1VL?=
 =?utf-8?B?UmVNSHFBMlpUSTRLYzRwVDJId29ZaENRSUFUSzdZM1cvSXpySDlJS0hkTGZZ?=
 =?utf-8?B?U2phVDIzb0ZvUnFiMjFsWnBJVXAyL2xDNm5iVEh5ajBBbllTelZWOWZ6bTlu?=
 =?utf-8?B?QmJhZ1lvUkR6UFZGR215UVZaMERMNWQzSi9MZzJJQ3BvUmxEOHZhcG1RRm40?=
 =?utf-8?B?dlZNVUhUR2p6RWJienlCMjZST2xOenozWFphaitUZDkvTmNURURna0tSd040?=
 =?utf-8?B?d2txc0Ewb1JVZlNSeFQxQ3RGMDJuaFJDRGVvWUJ0WjBzMmVlUTB4TklmeDJV?=
 =?utf-8?B?eGUxZGZkNUhYaytLMVBZWW1ReG9Ea1lQM01JNm5POHFjSHN6bUNCUHowMzIy?=
 =?utf-8?B?WE5qdjkwQ2ZFVEk4Unkyc1ZnLzdYWEFkelZSZFFSckVtYXJOeU14NlhaWDRy?=
 =?utf-8?B?U1l0SS9TeXVqRFdlSXlpVHArTTJHTnFMcDNqaUo1ajFTcjVSeHZvZkUxUVNh?=
 =?utf-8?B?Z3VCR1BCUjFEcTV5cnFnQ2dVTDF4MGxLbTIrYkp1Qmsva1BqalZJZlN6TGxB?=
 =?utf-8?B?T1p2NGdKbUtWd0g3L1ZDU3lBdy90YWFWaGVhY3pvOHllNTVrTmE5TnREMHIy?=
 =?utf-8?B?UkRvNmIxS0NXTlJxTS9MbEUvdU5TMVVGck03WFdtVCtrTVZKR21yc3lkTThj?=
 =?utf-8?B?cmJsTnFTV0hPdzc5cXVzTUMvOEFWU0VTMUdJQlkwQTVsa2JtZExId3hFOUZm?=
 =?utf-8?B?K3BPVWUwa25CcHQzRW54VEphaS90Z2xVMm9ubS91ZDcwcXlqNDYyalIzZUZZ?=
 =?utf-8?B?UUVBVENkRUNraG5FZ0VNd2hQY01ubHdVVVpyVTFucXM0akl3NGd1MjZpbDJT?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1C42683E7A0614BB4D3223CD5EA2D16@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50a715d-ede3-46b8-5848-08ddbdbbe2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 01:08:02.0505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /STUJT5nwD2KCbxWFjrS5GAmzTmAYyojFKxfjlpyQBN9/naQYem7H5nkk/U0DDLEItuIchKlbyMGc72iD0AcVKCQ+zKTnu4HbpDyB7jBJss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA3LTA3IGF0IDE3OjE0IC0wNzAwLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3Rl
Og0KPiA+IA0KPiA+IFNvbWUgYXJjaGl0ZWN0dXJlcywgZS5nLiBTTlAgYW5kIFREWCwgbWF5IGVm
ZmVjdGl2ZWx5IHJlcXVpcmUgemVyb2luZyBvbg0KPiA+IGNvbnZlcnNpb24sDQo+ID4gYnV0IHRo
YXQncyBlc3NlbnRpYWxseSBhIHByb3BlcnR5IG9mIHRoZSBhcmNoaXRlY3R1cmUsIGkuZS4gYW4g
YXJjaC92ZW5kb3INCj4gPiBzcGVjaWZpYw0KPiA+IGRldGFpbC4NCj4gDQo+IENvbnZlcnNpb24g
b3BlcmF0aW9uIGlzIGEgdW5pcXVlIGNhcGFiaWxpdHkgc3VwcG9ydGVkIGJ5IGd1ZXN0X21lbWZk
DQo+IGZpbGVzIHNvIG15IGludGVudGlvbiBvZiBicmluZ2luZyB1cCB6ZXJvaW5nIHdhcyB0byBi
ZXR0ZXIgdW5kZXJzdGFuZA0KPiB0aGUgbmVlZCBhbmQgY2xhcmlmeSB0aGUgcm9sZSBvZiBndWVz
dF9tZW1mZCBpbiBoYW5kbGluZyB6ZXJvaW5nDQo+IGR1cmluZyBjb252ZXJzaW9uLg0KPiANCj4g
Tm90IHN1cmUgaWYgSSBhbSBtaXNpbnRlcnByZXRpbmcgeW91LCBidXQgdHJlYXRpbmcgInplcm9p
bmcgZHVyaW5nDQo+IGNvbnZlcnNpb24iIGFzIHRoZSByZXNwb25zaWJpbGl0eSBvZiBhcmNoL3Zl
bmRvciBzcGVjaWZpYw0KPiBpbXBsZW1lbnRhdGlvbiBvdXRzaWRlIG9mIGd1ZXN0X21lbWZkIHNv
dW5kcyBnb29kIHRvIG1lLg0KDQpGb3IgVERYIGlmIHdlIGRvbid0IHplcm8gb24gY29udmVyc2lv
biBmcm9tIHByaXZhdGUtPnNoYXJlZCB3ZSB3aWxsIGJlIGRlcGVuZGVudA0Kb24gYmVoYXZpb3Ig
b2YgdGhlIENQVSB3aGVuIHJlYWRpbmcgbWVtb3J5IHdpdGgga2V5aWQgMCwgd2hpY2ggd2FzIHBy
ZXZpb3VzbHkNCmVuY3J5cHRlZCBhbmQgaGFzIHNvbWUgcHJvdGVjdGlvbiBiaXRzIHNldC4gSSBk
b24ndCAqdGhpbmsqIHRoZSBiZWhhdmlvciBpcw0KYXJjaGl0ZWN0dXJhbC4gU28gaXQgbWlnaHQg
YmUgcHJ1ZGVudCB0byBlaXRoZXIgbWFrZSBpdCBzbywgb3IgemVybyBpdCBpbiB0aGUNCmtlcm5l
bCBpbiBvcmRlciB0byBub3QgbWFrZSBub24tYXJjaGl0ZWN0dWFsIGJlaGF2aW9yIGludG8gdXNl
cnNwYWNlIEFCSS4NCg0KVXAgdGhlIHRocmVhZCBWaXNoYWwgc2F5cyB3ZSBuZWVkIHRvIHN1cHBv
cnQgb3BlcmF0aW9ucyB0aGF0IHVzZSBpbi1wbGFjZQ0KY29udmVyc2lvbiAob3ZlcmxvYWRlZCB0
ZXJtIG5vdyBJIHRoaW5rLCBidHcpLiBXaHkgZXhhY3RseSBpcyBwS1ZNIHVzaW5nDQpwcml2YXRl
L3NoYXJlZCBjb252ZXJzaW9uIGZvciB0aGlzIHByaXZhdGUgZGF0YSBwcm92aXNpb25pbmc/IElu
c3RlYWQgb2YgYQ0Kc3BlY2lhbCBwcm92aXNpb25pbmcgb3BlcmF0aW9uIGxpa2UgdGhlIG90aGVy
cz8gKFhpYW95YW8ncyBzdWdnZXN0aW9uKQ0KDQoNCg==

