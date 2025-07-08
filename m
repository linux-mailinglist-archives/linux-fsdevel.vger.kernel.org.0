Return-Path: <linux-fsdevel+bounces-54308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F7AFD9B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 23:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5346C582D77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B072459DA;
	Tue,  8 Jul 2025 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJykLHUk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69CE23D298;
	Tue,  8 Jul 2025 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009820; cv=fail; b=gcJe9g+OeDHXmdNTNvKxVhe473XtyP16vR+IddXvnB7ui3S0JaofiRA+8SRQShW7X1pCVGJxXDl10ulkNyT+R6CRNVmqzKnD6zAor6VOv2Jq5HqmWc2OYL0u0FI/pAobvpvmy2KDm2hm2vOdDD9PkQeMuSZUOXl019cVfr3RgLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009820; c=relaxed/simple;
	bh=sMe7INSWzGqI1O3fxVzeL7Oe0sVdRWToayfBXSeSVnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NqsuitIXhDzrLoZFRixL7rUzMtme4r97hUlJajoFqimUdJ4QkO+QXv2VsZDCOJ4Oj5bZowkA+YoaBD95ywc0cqfx06amhP2t4Xijd3s6cvXv4ymne4NkXJGB6A9UMFyG4rbGhPe8jV8n/5o2oJY6zEGfAMxJAQsVwQK+xVxuK6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJykLHUk; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752009819; x=1783545819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sMe7INSWzGqI1O3fxVzeL7Oe0sVdRWToayfBXSeSVnU=;
  b=VJykLHUk8ISi2NpDJe2ZEJuppxgxY9kEDhlShIYe8AwWzHR6/bTWazt4
   yGb4prv/FaUiH6cfAMIxfPsJIvPWksa23dEYqPWmbQSCp04jmOb6vbGmC
   NA+ZwCDH0LEtJhYyAjdV1dO93Po8fIfNF8Nzqgkb+MwX/JONPKk14cv6O
   Df7fUjyqTjunDkO+n7gRL/EOrPcDYwcAff3g6TW2qFbbEC+ZTvTmKrHwU
   n7WRcAdAY1wq3lEeiLKqIArxS1iRmpTZlhE6EEybekExA+3GfAPh7cRDl
   dHUNV6+TXietR/X11ahCa39e/pOYm5P2LbFRJFDbCXocyZ8mHYxfH8hOE
   g==;
X-CSE-ConnectionGUID: XWF+UDmhQZ6TQ2++eXwRDw==
X-CSE-MsgGUID: O/Jtxbu3SLeC4arisqZ4AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53473085"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53473085"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 14:23:37 -0700
X-CSE-ConnectionGUID: 4yGBO0YYSm+6SpPmlq3OxQ==
X-CSE-MsgGUID: F0+WdizqRxuWmPr9v11yHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155330389"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 14:23:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 14:23:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 14:23:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.83) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 14:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcLD8RaN0MmH2g5EiYdNomjBr4hH3j2q4SvuQ98rQxX0uCQ39FGmiK1qF5b/MxQtCih6P/8w1fxAGwABkSrTt8SNgZW0e3MvP3TIqIDi542LDp14m/s1HyKUngN9VevNYMhC8prZ0iITKi5RkKrigtNdjqq6q0Al3rMqo6vAIM0mqZLaw3Gf/6JxIJoL3ZlJOtw56NEDZ0Hl+Fyw3rA6DpNHiRP6f20OGW1FLMPzQ49VpHrgulK6m9WarwWyS/u7jhl1TfzLivnpxKl+LzMZa1vUQDw+hgmSk5J3F8klb8nSsvoK6H9B4CCdTvp5uGtP12eN4kACDc7XmmU8ef0Ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMe7INSWzGqI1O3fxVzeL7Oe0sVdRWToayfBXSeSVnU=;
 b=u3O/R2LTTPB7havpVC45kiE8ORSPqpvjzoqaWwJylrN+tRa/zN+VUTmXC1uAtdlccNXc6lGIpL8BtoCGUPQkAl0Xe6wkNJtEx8Belr76fwktX+0QCZl8vd3UPepTLlhPAhGn/awyjRPFA+tniUmsIcYbE/MHF9hFN2GFQB/YqJ8NlWjK+jJ9mtuRreH3GMJ6BtSPZKc83UJOFzpTFeaeR80IvFFpkVlilbjm1wbOERg7vScYrz5Hv+Of1BODxvSA1ukvrJQvi8lj6KJEv2zuIZ1fBu8GF1PijtVycjSRlvIX8bZMY3kSlWFkPXIOTiDl5E4SlZqWtlf3ccFcept2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM3PPFD3EB37DFC.namprd11.prod.outlook.com (2603:10b6:f:fc00::f52) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 8 Jul
 2025 21:23:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 21:23:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "pvorel@suse.cz" <pvorel@suse.cz>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org"
	<x86@kernel.org>, "amoorthy@google.com" <amoorthy@google.com>,
	"tabba@google.com" <tabba@google.com>, "quic_svaddagi@quicinc.com"
	<quic_svaddagi@quicinc.com>, "maz@kernel.org" <maz@kernel.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "Shutemov, Kirill"
	<kirill.shutemov@intel.com>, "jack@suse.cz" <jack@suse.cz>,
	"hughd@google.com" <hughd@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "mail@maciej.szmigiero.name"
	<mail@maciej.szmigiero.name>, "rppt@kernel.org" <rppt@kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"willy@infradead.org" <willy@infradead.org>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com"
	<usama.arif@bytedance.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>,
	"keirf@google.com" <keirf@google.com>, "quic_cvanscha@quicinc.com"
	<quic_cvanscha@quicinc.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, "Wang,
 Wei W" <wei.w.wang@intel.com>, "anup@brainfault.org" <anup@brainfault.org>,
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mic@digikod.net" <mic@digikod.net>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "Du, Fan" <fan.du@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"rientjes@google.com" <rientjes@google.com>, "Aktas, Erdem"
	<erdemaktas@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"steven.price@arm.com" <steven.price@arm.com>, "bfoster@redhat.com"
	<bfoster@redhat.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, "Xu,
 Haibo1" <haibo1.xu@intel.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>,
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
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>, "hch@infradead.org"
	<hch@infradead.org>, "will@kernel.org" <will@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrQKWaYAgAAM4gCAEFZTAIAAkwSAgAC4SICAAP4mgIAA8aaAgAmqgQCAAA20gIAADwOAgADddQCAAAjqgIAABCOAgAAGpoCAAB1VAIAABn+AgAAGtgCAAAKygIAAC/GAgAApRQA=
Date: Tue, 8 Jul 2025 21:23:31 +0000
Message-ID: <f0575436d3d7abe9356c670084d89e1cfbadd239.camel@intel.com>
References: <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
	 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
	 <aG0pNijVpl0czqXu@google.com>
	 <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
	 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
	 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
	 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
	 <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
	 <aG1dbD2Xnpi_Cqf_@google.com>
	 <5decd42b3239d665d5e6c5c23e58c16c86488ca8.camel@intel.com>
	 <aG1ps4uC4jyr8ED1@google.com>
In-Reply-To: <aG1ps4uC4jyr8ED1@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM3PPFD3EB37DFC:EE_
x-ms-office365-filtering-correlation-id: 191f40b8-3bbd-45df-7574-08ddbe65b066
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eW90Tk55d2FyUFB5RlRtb1EvZjBCUVdMUy9oa0JGOWRjbGVLVUF4OFAyQ29P?=
 =?utf-8?B?ZVpDNXpJQnJmUmRvbnNGTloreW1aSEcyV0daU1JKWW5Lc2lSTFVYYlM2eER4?=
 =?utf-8?B?Smc1c1g0dlNsS3h5aW9vWlZnS08zb1lXV0RwbmtLd2puQWM0bFJhOGppcHZp?=
 =?utf-8?B?cHU1SjRhU0RnTlY1MGhndCthdGxFN2N1REhDaDlOb0RNcjVGbUMzQnEwdFV4?=
 =?utf-8?B?L3Via005ZnVGY1IxTThtVE56Mmw3bWdIUVg3QWJSdXkyZHlpK3owSDIvV1A1?=
 =?utf-8?B?aHBWV2ZZMEFuLzMzSHYwbzZOZUgvSFRCUUJvYTFYamdiNktKeGFTa0NoYjYx?=
 =?utf-8?B?UGZSYStWeUM0c1Y0RHgxL2NrQTkxRjJqN3ArNU1uaTNPbkhsazhrbGJBWmg1?=
 =?utf-8?B?SW1XdDllaEk0YjNvV2c0T0FVYW9LdU1PRE9DTUJvM1l2MlZVRVZBOFNFWEV2?=
 =?utf-8?B?WjUvNHFNanBwalVFNjE5S0NJRDNtOGFadEdTamtLbEFoRlpFREwvejNnR04v?=
 =?utf-8?B?U0xXa0lmUWRVOEdvK0FHYTg0S2FlR0Z5NEk3TEtmbUsrL2liNCt5TjNtZVF5?=
 =?utf-8?B?TlV5M2hXU3NIdkh3dkpkY09KQmlTcmRNcTRzRXNSVjdvTnRQYXJ6WmpIY0l5?=
 =?utf-8?B?eHBJZHpQMWN4MU9ieUc1SWVPazUxR2N0QXU5NlQ4R29zc2d4cm1CQkY5cFN1?=
 =?utf-8?B?ZjgzTklMMnZDN3dJWFo4Ykt2b2Vmc0dmbUlKaTd4a2JZNWNaRWtJRTF6K3Rm?=
 =?utf-8?B?WVIzRnpGUDBLdTl2bVNTbDJEbVdQcjhjNVMxaVd1dXU5a2hBb3UwTDhqc3ZX?=
 =?utf-8?B?dnU0M0I5dlRnbS9DWnFCTHhLRnJGanJqT2xWT01FSWY5cmFHaDdZdXJGclVP?=
 =?utf-8?B?TDFsU1F5K0hyc3RkUVZTQnZaZHE5TnhHeGcwSk5KUVoxVmwzVmgxejBkT292?=
 =?utf-8?B?WldXOFpSbGRYczFqVTR6WjU5U2VwTFBPd3ZzYlJuOWFDWS9WVFRwRTcvQ2ZD?=
 =?utf-8?B?UnF2cG84UFV1dkMzWmFzVEtjem90OThzK2V5a1VXK1ZrdXZCWnZvNVdMcHBH?=
 =?utf-8?B?SlVqM2dkQXZhN0RITk9yM3U2aGFMMGtWTys2WTAzSXhZM3NrMm1IRTd5N1JU?=
 =?utf-8?B?U0plUUxsWTJudWFiUmtpTUwxeE0vMlZMRjdRWE1UL2pHTFU0ZUJEa0tqY1hS?=
 =?utf-8?B?eER3VnRFelNHaUlib3lSZUxrK2tacmNwYnJERmlqY3RweTZVdGcwNFFpVXg0?=
 =?utf-8?B?cTU0bG50K04zbkZrdERiVGFvU2d2dHNOUlBHWjJhWkdKcVA0OGJaRzBBRDNv?=
 =?utf-8?B?cWt5b3NKRW5QbW1KQmQvdXF5Wmt2cDBCS1l1enJrcC83K2pLemJxMmI0WXk0?=
 =?utf-8?B?UDlBKytmeVBRMlJma1dPQVVvZjJDblNnVkhhR1RLY21QditPK0lPZG1nRTlu?=
 =?utf-8?B?bTR5bWpDZTBDbDZrTDlZNWhxbE9XNnp6T1FwdUZRbVJhcGp6cVBCeXp6Nitx?=
 =?utf-8?B?TXJsZjkxazRVOUZnQ0xaOTl4M3kvZDdrTnF3eGRNZ01KLzBXOXNEM2I3Tndr?=
 =?utf-8?B?d2Vva0pySnExSEppdVNIejlBZ3BZME1nVU9lZkh1dHZKbkwxN0VxYm01L2kx?=
 =?utf-8?B?MjdKRlF4RHRiM0hjdGcyRHNvZG56ei81b1AxaUFNMDBzbHFCK2czTTZ5S3JX?=
 =?utf-8?B?NWNIZ1Q3aGRjekwyc2lyYTY4Y1lSODY2VlIxRDhhTnp3Wm8ydzhoajA4YVBF?=
 =?utf-8?B?emo5LzZJbWlPV1dWNlZvOUZGNzVWTkJ5SFZmbzdTVnJpQ1hHZ2VsTUk2QXg2?=
 =?utf-8?B?c0NzSkZsRGFZN0RTUXdDV2txOSt0Vk5maU1ST2g3M0VDQ3hTbXZvdkJFQ0JS?=
 =?utf-8?B?ZC9LdTBEc05xVm1ORWIvbnZpWFl2SXU5c1FTR0loVUE5L3pMR2NheThDMEg4?=
 =?utf-8?B?L2dKek1YbldWWDNnZTk1ZS9yck9DdUdvNlJPaEhTRGxmSDNwWGRNRGlvc2s2?=
 =?utf-8?Q?nFNSiBAldOF6Wq3EoSRz3JXivLmG04=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0pzZ1NBQnd4Ylh1WG00K1BiQUl4WGdTZExTSzdwaXNiUHpwNkYxdS9IaldD?=
 =?utf-8?B?U0gxck1RZDkyd3Fyc3l3NDUxT1QwWjk1TWJiUU9iZk9BOUdqb1RiN3IrdWxu?=
 =?utf-8?B?SkNqczhHT1JCWS9mRUs0RUc5RkhKU2daMnpqTWVacTJNVUVXRTNPTHFSSkEr?=
 =?utf-8?B?akw2b08vTWFORTRKVC9xd2N6cTJ0ZVZSaGxWSWtDNHJZQUc0elVzVVhrazZv?=
 =?utf-8?B?eXlpcC9hUGNMZnBFM0lpNERlYTN2ZTR1MHd0NkJ6VnBkQU03cDNvRGh6ZVNB?=
 =?utf-8?B?WEdCSkNxb1NBL2xmcU8xNTVTQmcvWkRzTnF4Vk4xS2FHc0tyenFUZnlFM2pI?=
 =?utf-8?B?NzRmUEZmZEJhdnUrSlFTb0VPNjkxbFAxNG5qVk54RG1vK2JUaVRpR0wwcUxp?=
 =?utf-8?B?a0xIcnBka0tNSnFibVZBRGNHTmY4RnFzRXM2ZlBaUlNJazlCckx2emZIaUEx?=
 =?utf-8?B?a2I1cEkzTEUxbjJiamhKWCtSUUlnUlRZMlZ1MWtoZVZTdFVCRlBGY3h2NmVa?=
 =?utf-8?B?VllGRXZydVpJcjI1ajJaanBrcm9lQXlOMTVMNTI5Vkk5VDBCZzQ2MmZ4ZlF1?=
 =?utf-8?B?V3JRSjB3TmQ3T1B4QUFjMUwzRTdaYXZTMnFVWUg2NTYrMXlxOUpzYlh1citw?=
 =?utf-8?B?NTdyb2RtWnpwTjBpVE9McDJQS1gyaVRQOGdPNFhQSkxPOGE5Rm9tb3lBNlpV?=
 =?utf-8?B?TURoUUhhYTdxS2JTUDFmb04ydVBySlZZQ3Uram5Hajc4T1BKRFdjKzlreGRK?=
 =?utf-8?B?bmJ3MERxMHBxR3pONW81K1JLQmJFZGw3NWt1eUx0NGdJQjE3MXdLejFudmd0?=
 =?utf-8?B?Vlg4azJHVWxCMC9GdllkZk93TUpxTi9vcHgyVGpsOVVYTk05S0VHUnl3SnNk?=
 =?utf-8?B?WnFXeHl0VldpY0V0MzFoVUVoUXVoZlNXUW51alRKMFNsY3R1eVEwRzZwTUh0?=
 =?utf-8?B?K1VVdm5PeTdEcVNOSnpHM3d6aktjeGlRczF6cnk4QlZOalNWUnlodHlVWUp6?=
 =?utf-8?B?bDJrek5FcDAzYVZ1QnJCUWdtU2RocXN1SlEwTHIwamt5ak5UUkVrSlk4RDBG?=
 =?utf-8?B?MnVYcFhKUEdkSlY5N0N4UVNFYnAvTnY4a0d1VWsvcnZlNzN2aktMRlhsYnly?=
 =?utf-8?B?L3NaQm9pamVJVVc5TzRoczk4S1BoMmtpMW5CU1dRQTFpakVyM2Q5VVBYRXV5?=
 =?utf-8?B?R2orenRjYk5BcWFXajdmM0kwYWhKdVdOU1g2dlpvQy9CRXk3RDJnNFdsaXkx?=
 =?utf-8?B?b0RPTm5hYmc1TmdKMGw5bWVYOW1vK1pIVFg3cmZ5TGphSTJyc3dpMWUvZkZl?=
 =?utf-8?B?eHFNMXJrcTUvL0NGRDB3RHIzYU5FUU40MWNGNE5rZnoyK2FiZ2ZkVzZCcFht?=
 =?utf-8?B?VjI0andnU1NhMy9oZzRIMGFzMGpBa1dsaW9pZUFFaHNEU203MFo0RE01QlRK?=
 =?utf-8?B?a1QwQnVKNjNsdEdOMFhuV2FYWnJlZFFXazBzdTd2YjluVlhXdTZZUkNwckRK?=
 =?utf-8?B?cE9SOXRKM1hxUTlHV3hBLzJ4TWFmSld1OFRmMDU4dERrYk8zK2FNTE5xdjEv?=
 =?utf-8?B?a2p2eFQ0b2lwbEUxM1l6TjFCaFE0Wlo3MkZhc3FueTJtRnlWbDhiV0Nkb1Vi?=
 =?utf-8?B?YkYvb3ZtUzExVzVqb3g1TWJoMkdteFdOSjJSeHh2a3AwRUFIejExOFdtS2Vu?=
 =?utf-8?B?ZjVmbnpYdTBhOEI0aFdvWlNvQ0NxYVVSRlZaRGMzSmxpOWc0WjhZV1V5cno5?=
 =?utf-8?B?Z3ZNWjAySVk5VmFXOWhobG1ORFBDRHg1QURNV0J2UE1ycElqMWt0VTRJSFFz?=
 =?utf-8?B?U3VHMUNpWVRNNGV4YmVPUWE0eGhDelQyekRtWWhHclRwYzdLeDN3b2dxdkdO?=
 =?utf-8?B?Z29hdFB2cm9QdXMyK2hjNzdxZHNKRnVSVGd2UDU4bEhZdXBiZkR4YXEzNElN?=
 =?utf-8?B?MGgvaFFMMERxajhmT0hMZmdjcVZHbmd6RzdqMXU5T3JlZ1gxNzhJQWdsYVJL?=
 =?utf-8?B?Qy9PSUo5STRYOWVHcjVqMTFrYXNYaUpZYkJTWUpNZHRJdlc5NTZMV05qK0Vq?=
 =?utf-8?B?YkxpSFRJcEtBdnplUmI5d3hFUXU2REVkUkxZOEM1YkVnVWxqbklxcTFJdHlN?=
 =?utf-8?B?NVBBbldZVkJKb0RJa0hQM05SNjA1SnlJVUVCUUtKSEtSR1pxMzVTZ3BSS1p5?=
 =?utf-8?Q?aqXBA2aPVp1OQ2gCfwMB1ww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E5B810F1AFC6545A528558A273FE01C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191f40b8-3bbd-45df-7574-08ddbe65b066
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 21:23:31.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJP/D+t9eFhv14XFln4ExBQVyoxGpbYcediuUhHvATH2O2mmHJTrx0WoZ8mdk4/680KDXwDFApu8HurQJseIkx7cuTrFWPTODlZahwr4mbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD3EB37DFC
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA3LTA4IGF0IDExOjU1IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBJIHRoaW5rIHRoZSBhbnN3ZXIgaXMgdGhhdCB3ZSB3YW50IHRvIGxldCBndWVzdF9t
ZW1mZCBsaXZlIGJleW9uZCB0aGUgInN0cnVjdCBrdm0iDQo+IGluc3RhbmNlLCBidXQgbm90IGJl
eW9uZCB0aGUgVmlydHVhbCBNYWNoaW5lLsKgIEZyb20gYSBwYXN0IGRpc2N1c3Npb24gb24gdGhp
cyB0b3BpY1sqXS4NCj4gDQo+IA0KW3NuaXBdDQo+IEV4YWN0bHkgd2hhdCB0aGF0IHdpbGwgbG9v
ayBsaWtlIGluIGNvZGUgaXMgVEJELCBidXQgdGhlIGNvbmNlcHQvbG9naWMgaG9sZHMgdXAuDQo+
IA0KPiBbKl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1pPTzc4MllHUlkwWU11UHVAZ29v
Z2xlLmNvbQ0KDQpUaGFua3MgZm9yIGRpZ2dpbmcgdGhpcyB1cC4gTWFrZXMgc2Vuc2UuIE9uZSBn
bWVtZmQgcGVyIFZNLCBidXTCoA0Kc3RydWN0IGt2bSAhPSBhIFZNLg0KDQoNCg==

