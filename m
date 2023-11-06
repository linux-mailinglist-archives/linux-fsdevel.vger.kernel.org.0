Return-Path: <linux-fsdevel+bounces-2053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E7E7E1D42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E5C2813F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634F3171C8;
	Mon,  6 Nov 2023 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjXfxRXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA822171A9;
	Mon,  6 Nov 2023 09:29:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2DEF1;
	Mon,  6 Nov 2023 01:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699262987; x=1730798987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SX/EdGYO+EHv3iK5y0EBmdkV+IVHLED11jvSHWhRLfQ=;
  b=PjXfxRXK+NYX898pAnLu0rGMxUTVhEJX8NwU2M1I5NbcdCr61ufy2KMi
   eUFOspyqig22dB7y0V9i+Rk9vEkTTYYmHfV8OTrSDLFAuY9GSzc6YiX+R
   7dolR5CkzhaG3ITOQTORYraZM/i6IqdLmCGJIMF6jSynk7gY0i5KAwG+C
   XiqeGkVTiMsJ4zCV0oqL9CIrchHPR4DijaclfrTgAYexVMXJ7EQcGPHpB
   O65umBFr6udAcVKr4Vu8lmYh8ciArG6mts5OO8hpeGdc/6bPCnj/rwY5h
   n0owerrvR8iyjuTkm/I6kOzqpAApg8hqzeeLBAcqtMk1zC8DqA0L9leED
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="386415853"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="386415853"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:29:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1009468939"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="1009468939"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 01:29:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 01:29:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 01:29:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 01:29:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqXGEwvSCmwPoZelfmL+m25KtYZGwoMjd3VjhCrmIyIF7l/k+u2+8mN9f3lKVTTSG6efhTijc9u+vXVsUrfA3MpcxvcZ40MbjvuAh2SMaHoYDBDbOquHg3kVXHpdrJufT1Ie64TQvM+ndDO8KokLbBR51uWNL174eNkCn8qv9B5AXjKtcFXjcOsJTzaJd5nTr4JR+RXr5zpoZo5V8HHHi/o4RHnLVtRiqI4932ywoUyjYrDtw/vwjXGNhT9ZPz0cwloRuXVoeThs6cYuqmDJPJjw3CyUzJie8ytGAbMrqujJQOE/Sq7qZgiJu9n45kS/+IoRKqj/xateAMGWBWUGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX/EdGYO+EHv3iK5y0EBmdkV+IVHLED11jvSHWhRLfQ=;
 b=Y03HSijGJHTtHMDxdfueHxw6BgejUNMJS7b9OC8uU6VhGCSGckorNSlnvsLmeyYmE9yHL/b4d3jsDq7iBZ5bR8WpWRPQHPR5LFE4tvvS7bMigmKQPWoiTgAzCB8gEgnJNP06SB/75HGFK4WQlXEohgaaqEskNmdfKuENON8d/usv1nsvK/fswYjTBVnZr4A6AVgjahpcHQCaO70/SmIJ64LCduPm4H3qzq6xyedGP425X/itV4N4LmbsiDvcdQe6z1wl0thIt/44uHX0dL77oWzv01y1WnbmYJnnehFP86XvvuA0PkmMN/Pg5CRAXwbXp38m6NrV0jx32Ma2wWRlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 09:29:43 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.021; Mon, 6 Nov 2023
 09:29:43 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "Christopherson,,
 Sean" <seanjc@google.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "maz@kernel.org"
	<maz@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "anup@brainfault.org" <anup@brainfault.org>,
	"willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm-riscv@lists.infradead.org"
	<kvm-riscv@lists.infradead.org>, "mic@digikod.net" <mic@digikod.net>,
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "tabba@google.com" <tabba@google.com>,
	"amoorthy@google.com" <amoorthy@google.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "Annapurve,
 Vishal" <vannapurve@google.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
	"yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
	"qperret@google.com" <qperret@google.com>, "dmatlack@google.com"
	<dmatlack@google.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [PATCH 03/34] KVM: Use gfn instead of hva for mmu_notifier_retry
Thread-Topic: [PATCH 03/34] KVM: Use gfn instead of hva for mmu_notifier_retry
Thread-Index: AQHaEAWKALgh7o/PQ0+hlh/f39aBp7BtB3sA
Date: Mon, 6 Nov 2023 09:29:42 +0000
Message-ID: <814958af6bf6b00752a715da74a0cb85efded1aa.camel@intel.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
	 <20231105163040.14904-4-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-4-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB5525:EE_
x-ms-office365-filtering-correlation-id: f305c237-1707-4472-2eba-08dbdeaae884
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQIoN1rckUJ9MEVuwFdsQqrRryLSdEluZbI0/UCbTyGMOBuo4a3L9Lhph2YJN/Hh9scsZAlj5C+V9WPnoCrJliqgFgbbpWVec+aHPZVH7+qRHaF3gDwanGZM/I6PvmqfyyFYIiccPRnIF2EsIK4tDG/nTAdrhcrc5LQa70ultkK6HQQa/S76QAPxbVZMkXITrQqT8tfEDHm1zw797Aga0NICDTY70EkFlhzS01nsg31PBVenPu8TJaSPtEQKcEk+APpT8teKHO+xyTd7NLYFePWONK9WWRBuTG7dnFQ5X8wiUTdSs7YdvAsyEV0ZuQ+4Oc3f0Yii4PJ+KqxrYvGYnr2VjPQY4wBuNAk5KI8W3gUzBvzMCbTwOraX2NJpk3x7G0O6UcqPJE0pG/R1WUeTbluMj9BrVS9BOtDZXBvZMIkmAESG6Gntm68TXI63+5l1sYuDoYTpb9p533tjeGVuKfMP3n43vglkTUCHVasSzyNr9lSQzkCgxCA6+6PTAf9pMut71tlLcmFyzY4UfxsJZ1L3WVjy3Rhlw/QwR3D3zFa1NBJP7PjR1cp2DQYiZ3OYdWnMRbCQCDDXyEIbvzu45ZmLwdHvoZd3iQXUdO9axDv708WVGMBzgTr0ni7WR0XT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(6512007)(6486002)(6506007)(478600001)(71200400001)(2906002)(38100700002)(36756003)(86362001)(122000001)(82960400001)(7416002)(5660300002)(7406005)(41300700001)(66476007)(64756008)(66446008)(54906003)(83380400001)(66556008)(66946007)(26005)(921008)(38070700009)(91956017)(110136005)(316002)(8936002)(76116006)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWQrazlJQXdFU29QMWhtckgvMFQ4YTZnamZJSm1VNHQrazkzVk9rRU1JRTJO?=
 =?utf-8?B?WkEvcnpOWEgycWpIemlEOXBlVkVTWTVLV0Z3UFUzNDk5WnBDMnhyREZHVkht?=
 =?utf-8?B?c3Nhc1d5UnZqekkwa0c3WHdudFZ1RFZuTVZ5YmpKZXV3K2htVlBlOWVLMnJO?=
 =?utf-8?B?SXByUHFiS3Azb3M2N1YzbW1mU29qdXpRcHViYk5LeG1OajE5WFNjdXNuamZa?=
 =?utf-8?B?R1YvVlZCczd2VTNiNlRIaVM4eXhyeDMzSU5JY0l1anI2SDQyOVZCNHhucWxW?=
 =?utf-8?B?OUZydCtZSGM1dTNHYys5MGpzREYzbG51K28yU2hpbldoSGVuei93MHg4Qkps?=
 =?utf-8?B?SUh0akhlT1dEY29QeXZWSVU0RGpvVWFkVUU2dVhISXhaNkpUWEM3TXB2c21T?=
 =?utf-8?B?UmRpL2hRUTF0YmNNNlhueEdFTVpHb3FWaEpXS1NJZE93cmVvd3RnSUNYNnpi?=
 =?utf-8?B?T2N0R3l1alJqcGQ0VlpyM29Wakc3NGpaS0ZxemhXVnFtOFkzSEpUQVlWd0NQ?=
 =?utf-8?B?NTAvS1JpVW1lUkJZV1g4S1FOTjlldjBsSkhGNzNxREl4NHBiUHJXTTdYYmZy?=
 =?utf-8?B?TU1Ma2hZZ2E4OG1vYjRYK250ZTk1cU9SYnBpOFcybmpiblV2dHJHOG5KcFVu?=
 =?utf-8?B?QVlCWXAxdThLNGhLZE9kanoyVzBVbFdRSG9LOFloUmU1TmJwQm9Yb1ZXc3pX?=
 =?utf-8?B?dFgvNEhXNXZMY0pEck1FMjczMXJneVVDazJzTWRuV3hOck9hZ3JKT0VGb3JK?=
 =?utf-8?B?WjlHQk96WmZDVFdDU2FRTFJJanJNb2FJWFg2MGhxam12Q0Y0eFV2cG9ZUE5l?=
 =?utf-8?B?eWlJS1BVb0pkODZMQnpHOTZsSHVmSnlsTFZHQlhCNW9vNlQwemNOV2YrYlNj?=
 =?utf-8?B?eVM5MmtXaDYvTEN2aFBwTzV5UCsrbnRQektZQnozT1pUUnFrWW10ak9SbnFK?=
 =?utf-8?B?RGtUYlNLdW1FVlJaYnU2TEFnTHFBM2t5UGZEeUdiTG1LOEpmR0VBdGNJbU16?=
 =?utf-8?B?RWRIQnh0MEhIbG1EL1luMUlUYUsyZlVQL3ZTK05laDd1WWI2YldBb2RUUERi?=
 =?utf-8?B?K05GVFlQVXJiMmZzL1F0L3E0eHRqVEVrV2QvZVNHWGxVd1MzY2NGSGYyVUNB?=
 =?utf-8?B?ZGc1T3Rta1A2Yys0OGtCcnAxQW1IVjZVM2xFT0RvNkxyZGh5dWFMREoyL1Ir?=
 =?utf-8?B?d3c3ZStDdzc0SDNwenBycHpxUGJrTTBhQnAvRks5ek9jSWNjY0xPOHZuamVY?=
 =?utf-8?B?VFk1RVE0bGdYSWpPZXJNUEYxN0xHRjVUUTJxOGVtcjBQZHErUndxQW44djhU?=
 =?utf-8?B?bHlWUGFFRnVnK04wcG1FOVpHd2gwUVp0MVNzM0pBd1FjWE5JLzh1M1dwbVVV?=
 =?utf-8?B?Y3Z6bTk3VENYNnFyWWlmQzVPUGZPSFV6d0pRR3IvQ2dQa2F6SnJiNDRUd01w?=
 =?utf-8?B?cVdpWUNyd2pxUUNJdG56R2NMSnYxcktmMHNMTnpoYzg3SUNFaC9LL3FTbVJT?=
 =?utf-8?B?RTZYTlJFWjJFOWRaL1JhTit5VHZUOWNNaHR6ZE9XVEhZbTVnU0ZWSkpXbWlM?=
 =?utf-8?B?djh6U1J6TUVMSnRFdTFLRXZzZkxVM0dOeGtOTFVjZmFscG9TaFl3YTNWYkFV?=
 =?utf-8?B?S2RiRHdUZS9WSWdyRnkwUUpFNHBwVlpnNlVtNEx2MDlLM0dhdlpheGxCRDM3?=
 =?utf-8?B?YTYvQjZJZjZvdTBhZWpzQXhYeERQRVQ5Vzd6bDNGQTdjU3Rnai9LUW5tTWYx?=
 =?utf-8?B?WGRxQjFSaWYzVHh3ZFZ0NU5HZU1GbitoaUUrME4xYkFGVHpPOEY0S2lBd2Jq?=
 =?utf-8?B?Zm9waXMvc3N6THlkZzZnWWk5Z2FFcW9XVXhDZGI5UFVZZ2FBUW9leUpjYzhX?=
 =?utf-8?B?SVdTcU8vUGhDcEZRZXNLWEk2SHlZRzhWaWlXVFQyS0gvS3gwRnVqaGl3bXUr?=
 =?utf-8?B?R0RUNlVOMy9iM21RTTBiUk8xdm5Ib29vQVVJK1Q2Vnc4ZnFrQ1dYMG8wSG5O?=
 =?utf-8?B?YXdnaElacVFxWEVVVE1MUVU2d21kS0Yvd0ZqMUQxUGVPNXVhci9xUVk1VWI1?=
 =?utf-8?B?TlJibHpzRmpPWTd0TGgxM3diNEVEcFNuUVluN21wK3ByNnNGazJUb0pxMWhU?=
 =?utf-8?B?Ync5L2NpY0JpRDgzS0tsaEEwOFhrd0RySDVtSEFsd1p6ZG5KcTFwUnRLbi90?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <613E3D0EF52E884EA53029B3BAB1F523@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f305c237-1707-4472-2eba-08dbdeaae884
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 09:29:42.9363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kgk5ISa1eCbX8YsILs9QKK0rlaEUxabejbh8eSH4v1E0JnuOHR4d6uEgkwtL3GNyoS3NgSzD17C8ykKqoxjc7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5525
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDIzLTExLTA1IGF0IDE3OjMwICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBGcm9tOiBDaGFvIFBlbmcgPGNoYW8ucC5wZW5nQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IEN1
cnJlbnRseSBpbiBtbXVfbm90aWZpZXIgaW52YWxpZGF0ZSBwYXRoLCBodmEgcmFuZ2UgaXMgcmVj
b3JkZWQgYW5kIHRoZW4NCj4gY2hlY2tlZCBhZ2FpbnN0IGJ5IG1tdV9pbnZhbGlkYXRlX3JldHJ5
X2h2YSgpIGluIHRoZSBwYWdlIGZhdWx0IGhhbmRsaW5nDQo+IHBhdGguIEhvd2V2ZXIsIGZvciB0
aGUgc29vbi10by1iZS1pbnRyb2R1Y2VkIHByaXZhdGUgbWVtb3J5LCBhIHBhZ2UgZmF1bHQNCj4g
bWF5IG5vdCBoYXZlIGEgaHZhIGFzc29jaWF0ZWQsIGNoZWNraW5nIGdmbihncGEpIG1ha2VzIG1v
cmUgc2Vuc2UuDQo+IA0KPiBGb3IgZXhpc3RpbmcgaHZhIGJhc2VkIHNoYXJlZCBtZW1vcnksIGdm
biBpcyBleHBlY3RlZCB0byBhbHNvIHdvcmsuIFRoZQ0KPiBvbmx5IGRvd25zaWRlIGlzIHdoZW4g
YWxpYXNpbmcgbXVsdGlwbGUgZ2ZucyB0byBhIHNpbmdsZSBodmEsIHRoZQ0KPiBjdXJyZW50IGFs
Z29yaXRobSBvZiBjaGVja2luZyBtdWx0aXBsZSByYW5nZXMgY291bGQgcmVzdWx0IGluIGEgbXVj
aA0KPiBsYXJnZXIgcmFuZ2UgYmVpbmcgcmVqZWN0ZWQuIFN1Y2ggYWxpYXNpbmcgc2hvdWxkIGJl
IHVuY29tbW9uLCBzbyB0aGUNCj4gaW1wYWN0IGlzIGV4cGVjdGVkIHNtYWxsLg0KPiANCj4gU3Vn
Z2VzdGVkLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gQ2M6
IFh1IFlpbHVuIDx5aWx1bi54dUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENoYW8gUGVu
ZyA8Y2hhby5wLnBlbmdAbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogRnVhZCBUYWJi
YSA8dGFiYmFAZ29vZ2xlLmNvbT4NCj4gVGVzdGVkLWJ5OiBGdWFkIFRhYmJhIDx0YWJiYUBnb29n
bGUuY29tPg0KPiBbc2VhbjogY29udmVydCB2bXhfc2V0X2FwaWNfYWNjZXNzX3BhZ2VfYWRkcigp
IHRvIGdmbi1iYXNlZCBBUEldDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24g
PHNlYW5qY0Bnb29nbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogUGFvbG8gQm9uemluaSA8cGJvbnpp
bmlAcmVkaGF0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFh1IFlpbHVuIDx5aWx1bi54dUBsaW51eC5p
bnRlbC5jb20+DQo+IE1lc3NhZ2UtSWQ6IDwyMDIzMTAyNzE4MjIxNy4zNjE1MjExLTQtc2Vhbmpj
QGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJl
ZGhhdC5jb20+DQo+IA0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwu
Y29tPg0K

