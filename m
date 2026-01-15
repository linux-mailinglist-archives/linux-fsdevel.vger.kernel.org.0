Return-Path: <linux-fsdevel+bounces-74025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A84AD292AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 00:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3DFB3044345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 23:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4BD330329;
	Thu, 15 Jan 2026 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avqgU0CB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66F272813;
	Thu, 15 Jan 2026 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518286; cv=fail; b=azpwTT2kV/5Uay9ZcrfIZzltMtVLYCTwOPJTIxukTlYaZPzoWAuYACZM/m23f2ORLoG9Iemm9vyOwQrFW4imA5JrjvEzmx4EFpcP/kNozKmDeMV0t95sxtwhaZpLn8HxMqlqGoqE8lxwQeqAyZvKtC/Xw2py4w9oP70ZuURFsCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518286; c=relaxed/simple;
	bh=2ExAuhCQtfJWRmot5LSaZWkVzCWXbMmyXhMK2LpLn7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dA63KDMSBzHUC1qGQ+4ZfspIYtXWw6CtLvF9cVOvlSbQwKdRRL5+hYRQTHwjjo3Kp2fLP9ocgbBQn/BuJnZbYC6BVI7vraSGwWARZVkBw7hRLCQNPWekthbkbNBISpmuC1tCAz6SLl0OxO3tVqnmKQItbcFRyc9ZM8xycehYyOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avqgU0CB; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768518286; x=1800054286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2ExAuhCQtfJWRmot5LSaZWkVzCWXbMmyXhMK2LpLn7g=;
  b=avqgU0CBSOu2CqEeijTX5sLAQVXe2crGfk1FSuG8jJYikUHsHoj0FgPX
   phc8ykl2Gca4LtUJLNoMADnTL0zYlFlmKrFqVyMVLesPHf+zHUOgOhgaw
   UuJS+xsOLY6ARA/WQ4Em8JBb1kgQZ16VW+EC673KgqudnACcwuMSjX/g0
   6b2KIWQDeWQVOGevsnx6QFncLtcwDs5wpbdR/rbO2/xiGb2gcTWZTTsHv
   17LqF4Q41ezLUAOKv/GXF1T3rOKJR2+mrFiE90GXn1bxjdfZY/n0cyedI
   lU+sVbJuVvluz82rmj5opAsNvDoEVW37wi6Dw8DDpGM7jmc6Px/547QKe
   w==;
X-CSE-ConnectionGUID: paoDz3O+Qtaq0d2s6/w/6w==
X-CSE-MsgGUID: nb5EYSaTSC+kB3hyHrmoaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80946813"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="80946813"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 15:04:45 -0800
X-CSE-ConnectionGUID: cNDdHy7eS6up4hO9iYP92w==
X-CSE-MsgGUID: +c+ZsKzkSzaRod+jqUH0JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="205562630"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 15:04:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 15:04:38 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 15:04:38 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 15:04:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3Hfribdl2bT3X8sqcRuVmGauesnXeydqoHx9aeEmEKMgl0muHaHPoH19iy+OfRPP24/oR3AsVjkvsr1wy8Xymk3HdtDuBg7lxZ67nqC4TaQehrq8zi2A+oxJkzke7ozp0yio/viVGTB8+CkHUUI7wky+jt1cOMiyNGBPFkOCVRdIlXm+HnogycQbpr4NHPUjOdyb1np/piRvKGtgtP9Cp1nW4oKWNPpGwRfbrwsrBiarKIeNquB/1VIcsaMdPqVHMGUaKhT928Jws/mq6mAyfI5Qko5YS65/qnEnCgJPoqS4XVsVPAFU9lQmPMA0DezCFBoew+Et4NrwQWFYYXOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ExAuhCQtfJWRmot5LSaZWkVzCWXbMmyXhMK2LpLn7g=;
 b=wKTTUs7T9hqoTz7IwF8agc76EaqoAXDSHudlLIzSbSKv+tRxJBbCcvvo25hKJR0qF4/bkK+81O4ikVVHRx9jwMywm6y7yT9UFWUedzG7nDPKR6Pfp97d6GtByg3b6IyYfEs3t22a7HOZrd80vtAzFlm0fndK9qzqq652If6K891pCCIDe4Fh3+Z2ZFwoY9Vdp4FpT8b9H3OsPhjlaOCyoeJiHnjm91pnD7KlUiTbCA57XWhs3UXZ9yKlqDeAY19qAPbHWebIV+CflQc/13I0dTgcF01lYhU/zL0TT2XgHITLcz0z1vnAFq+UDu1yXcWc/PnBepFVATPwg7rLpMfMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 23:04:33 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 23:04:33 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, "kernel@xen0n.name"
	<kernel@xen0n.name>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
CC: "david@kernel.org" <david@kernel.org>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "jgross@suse.com"
	<jgross@suse.com>, "surenb@google.com" <surenb@google.com>,
	"riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"maz@kernel.org" <maz@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "ast@kernel.org" <ast@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "Annapurve, Vishal"
	<vannapurve@google.com>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"pjw@kernel.org" <pjw@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"willy@infradead.org" <willy@infradead.org>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "wyihan@google.com" <wyihan@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "jmattson@google.com" <jmattson@google.com>,
	"luto@kernel.org" <luto@kernel.org>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "haoluo@google.com" <haoluo@google.com>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hpa@zytor.com"
	<hpa@zytor.com>, "song@kernel.org" <song@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk"
	<itazur@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"andrii@kernel.org" <andrii@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "derekmn@amazon.com"
	<derekmn@amazon.com>, "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "jackmanb@google.com" <jackmanb@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "jannh@google.com"
	<jannh@google.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kas@kernel.org" <kas@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHchnGR8zlgd593vU675Y8ML/1Q0bVT2boA
Date: Thu, 15 Jan 2026 23:04:33 +0000
Message-ID: <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
	 <20260114134510.1835-8-kalyazin@amazon.com>
In-Reply-To: <20260114134510.1835-8-kalyazin@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW3PR11MB4666:EE_
x-ms-office365-filtering-correlation-id: c12deba3-9892-4569-53c6-08de548a722b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SnVYSlFOUzFHMkpzTHRYZ05rOU1vejhHb3d5K2x3eHNTSFJheVpPcGROVXJW?=
 =?utf-8?B?dnU5VGpCOG01VWxpbkhFeGEzNk51bHFtL25JTDl2OXZmMHEvRlZ2dHhicWtp?=
 =?utf-8?B?Z2pndW05OHZJeU5tTlA0M29DTjJxMnVjMHhrV0x6Qm95TmVuSVZjVEFVWldY?=
 =?utf-8?B?S0tOcGxqK2NmVWgyY05wRmFISkcwQ2gyOUtYMi9ySnRpOUFEYWZJem5Fc3Yx?=
 =?utf-8?B?Ny9RbXdhbVU0ZTlBQVplT2R1SkFuOCtQQTlqTVJtZkF0Nnp5OWRPWFgxMm1J?=
 =?utf-8?B?em5vamtzNGx0RjlHdHZWUW96V3hjVy9xQkhCUkh6Unl5WHhyK3YrVjdacXVS?=
 =?utf-8?B?QXFmRmlIZnlabHNCaTZJdGVzTXRBTWpXMkd5SUVCckc0MEgzeDhCQkMvZVdC?=
 =?utf-8?B?SzFNTHo4V1h4UnFSSXBxVTNLWkloL013K1p0bGloRy81UlZEUFhlcC9BUjZy?=
 =?utf-8?B?SnJzaHhrRWdBY1NMQTlkdnhSSmY1d1Z1YnlDM1VLZFplTWFSVmdIYnpWZE5o?=
 =?utf-8?B?VmdRYlhVTkRUL0cwOExybjNubU9kakk2RzhTMGRwbXFJMlRXZnVlR2hVZHBC?=
 =?utf-8?B?b3dHNTMwaUMvZVM3c3kwT21uTzRhWXBqeDNmQW1CcU5BVnNsbDJmTCtnSU5u?=
 =?utf-8?B?UDVRdFM3NUs3OFFiQzE1NE43WVd1TUNSLzJHcEVxekFqWTFpTk5Wc3Z5Z3p0?=
 =?utf-8?B?bHdGRFpMckhPKyt0SUlaaGlGSlk1Y045VEh0ZVZ6bTQvc0I5VVJoREZTSWxQ?=
 =?utf-8?B?ekU0enM5RnI3N3p3aUd1R1duNysxalZpbDRvU1hVMG5qeVBuaStGZU5hLzA2?=
 =?utf-8?B?U3NkUFZ1OENMMExvWkVKWGVvSnZkTDhwVWxGSldlNnVMWWVmNlJoV2NwazdT?=
 =?utf-8?B?eXlGWVhGaVVSTzFhdkV6MldwaHBqVTFEUmxDQ1M4OU91VVQzN2xmTzhLMENT?=
 =?utf-8?B?NnN4ZXRoRlFvQ0xEdEVnbUs1Y2kxcG1EL0t4VitpMERoVUNhTGdrTWN3NUVt?=
 =?utf-8?B?NWlCbTZWaWpBYnBnQk9oa2N1TkpjdUxvejVhcFdFRjdOREJGVFVDVGovVEVY?=
 =?utf-8?B?YkhpN0hVQmVmSjhwK3QzQ1hoUVIySzlmYk5kK1lHOGxXaW1wSGxETVp5Qms3?=
 =?utf-8?B?Y2VJWjdBM1Rja1lrd3BHcHlyUEhpMzFUbnpILzQ3cERNbVFTS0ZNdDhVMkJx?=
 =?utf-8?B?MXF0UUZMMUZmbUd2aCtiaE50cEJEdldnNWVXV0dvUEpTVFVvTklXcG9wWFpj?=
 =?utf-8?B?TjlWZ3FkRWFiZmtZS1JZYldxKzE0cFJ3blFkNVRUeFE4Y2ZyMHB0bWNNQURz?=
 =?utf-8?B?ME01NXZvaHROUHY1UUJsMTFxSkN3TWExQjRlaURnRzI1Tk5TYUN1c2t3R3U3?=
 =?utf-8?B?cnBqK2tMMVBjNFJkQ1F2QUR1N1dVaVNnSzZwTHJZRk8xb1pxaFFpRHVLTi9u?=
 =?utf-8?B?cWNnb05nLzJHRTlaRmEyZllrUG9RVG9ZYWZBVUFCMFVWVU9vMlFEYzZ5bzdJ?=
 =?utf-8?B?MUthSDZHbFlsSG9NRTBYT0NYaGNrSGdmUE1zeEJCTkVYUDRZeEQvdHNweGhm?=
 =?utf-8?B?U0M3QWpBUkl3SHNvTkdRL09sTk95TkdEcE10Zk1mdVM1OWJBZUxxekY5MmEv?=
 =?utf-8?B?SnhSRHB0MDJvN2wvamlEdTJqRW41Z2tjTFZ6Qm81bUR4T2RCU2RkRTBvalo3?=
 =?utf-8?B?ZnM2QVYzVitPaUpMaFVsQmNrT29ScmdDeXMva0dqVHJGTE11eEdZemxiRk9k?=
 =?utf-8?B?YlFpREEwZXZCczBoekprNlJVaVFudDkyR3dpMGR2R2c1RDVkbkwvanRCQTAz?=
 =?utf-8?B?QUduZzdpay9hbGNVTEpLZnpyTXlhVjh3U1NLMVFSYVVxM1oyY2Z3Wm9rbGlE?=
 =?utf-8?B?VmM3SjhEaGpXVVB6ZG41RTRZdS82aHM1ZUJUNEI5TWpZTkZCN3d5ZEdncEQy?=
 =?utf-8?B?bnFJRS9VNkdVcy8wM2lkcDVRbVhESmRwSXNYdDdwM2JMdjA3UmJUZTJNOXlr?=
 =?utf-8?B?Qm82UmVWQWtreGdWWXN4eXl6WXQwbkM4VW9JaE80aHRSSFA1bXZScFUvU2Na?=
 =?utf-8?B?b1g1eUtYMUx3V1NtaEV2akFtT3RLZzQ1UnJBaHJabTZaRytCanQ4c3hPdTZ4?=
 =?utf-8?B?aEsvZDFJSUxGeWhUNkd5L0NPRG9mUHkvVExzYUNtbVJMeTk4dytzSHVKMHBj?=
 =?utf-8?Q?/Ppt10r4ktbRE5jMIy3e6OUmO/oZkhMduIemT+lXWucV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L21IYmwvLzNqWmdpT0czQ09YWUFibmpZZXozZ0FXWUw4elRMOHpudllHZEFa?=
 =?utf-8?B?YnZuRlpvUmErZG1DU0Y4K2h6ZWwwSER0OTBUVWQ4azVGRUgrakNJeDdZc2N5?=
 =?utf-8?B?azZjVGJBaGxveEFsMU5vTGkvOUNVNWp1MXpQaWJFSHJXL01INnNDSFBZUldh?=
 =?utf-8?B?U1BOMHM4Zi9YQXRuRWhRNWJVZVBvVW5DWTRsUEV6QkRIRWZuVCs3c0NsR3dm?=
 =?utf-8?B?V282NEQxNHFMeGFsU3NuaTc3WWtEMFh6YjRTT2Z5bXJjNmtEWnVUQWZLMDlx?=
 =?utf-8?B?NzRqODNPMkJZT3liWlpiZEV1M2p4WUZqcEpYK1R2S2F2OFhiR1l6Y09GbW5B?=
 =?utf-8?B?NWhXQ3k5cEY1c1VYc0J5ZWNMbklKM0hxSlZQQ0s1YlRlSXBnaUhrM2RSTlh1?=
 =?utf-8?B?cHk4M2ZnK3lzK2ZVanM5Mi9aU3E4WmdLODFPVk9hNm1aeisyeGZmMTVxdVhE?=
 =?utf-8?B?eEIxWmFPcG53Z1JndHQ5S0pyLzd3NmwxZmlXQldWejFuem1rcU1Xb2VySlA2?=
 =?utf-8?B?SHk4Z012Y1FyRWFHS1BFUDhtcWNKQmxPeDdBQ2QrUkt5emxpNXdxNmxtallk?=
 =?utf-8?B?d0lDeXJicDlGQUJINWFTRFRlV0lXY2VRbm1SWVNEU0JGVUNidUhFTEhRWXRM?=
 =?utf-8?B?VDhHK2hheEJlNk9jR2xwd2JkclpHY09wbmljS3VTbEFkbDlESFplN3VnZTEx?=
 =?utf-8?B?Y214Y25wd3lmTzNnb3pRcG9nN3lzdlB5a3crSWpCejBmT3BWTHdsOVdTWmUr?=
 =?utf-8?B?Zk01U1JmZ0RxallQMXpJNmNvRm5qNVgvRk5vK2g4bUd2UDVRbEhYYndlWmsw?=
 =?utf-8?B?Q0pWL2xXTXVhRkdSZDdsTEZ3TjRIczR0UXhvR2FVZU95VDAvbjN3SVhNVHVo?=
 =?utf-8?B?OHpVWEw3OG00c0d5ZFNuUFIzNlQzdDdsMmNVV0Q4MEkwVnY1YTFFUG9PMWNp?=
 =?utf-8?B?OG1LcDlrc3FZaDhGVzdxekVhanVtZFV5bTFlM1NGdlpQRllZU2JzSkQxQUQ5?=
 =?utf-8?B?bFp4bmUzQ01GUVpQWEhJWklocUg5bU1PWnpmcTZFRFlUS1NEQzdHYlZiek1M?=
 =?utf-8?B?aFNXcTBXZkRsNEVKQmRqMVgybkxyZkJTaTl2U0MvNkhtRHlMN3gramluVmxK?=
 =?utf-8?B?OHVYSmdvMGZPbGduSmpuNGdwQjdEWGxmQTBSSFJoS3BIanBpNkVZa0dxb3RC?=
 =?utf-8?B?SEY5MXV5WWFUQWUwUHBPa3BPbGpsUWFzMXlHNFMzbkJCNGJ2R2tTSXJnMnpa?=
 =?utf-8?B?dDhXaENnY3JLU3VseFkwOWJjV1lTQ0pFMDB3YmFxVGo2dDMxRmI1THV2eXhU?=
 =?utf-8?B?MUVYRVAxYVc3WmdETFY1YmxVNUJESlVsMWsvNWtId2Z5QWFzSXIyNHIvTzR4?=
 =?utf-8?B?aVhnSTFvVWlsbmJKV3dveUhwMXhYejJlSjV4d1VKUjhveERoRCt0YlNmVXpT?=
 =?utf-8?B?S0JBalJlRCtFbjJPbk5PcVZhN2N2b2RySE1MNjQwcXJpM1lrVytpMXd6cGlD?=
 =?utf-8?B?dExRY3lvVkV1SXE2L05adFB5cjdCQ20xWE40dzF6bDFRdmxBY0hvd3NhaTBE?=
 =?utf-8?B?ZTdONG5hdW5MWjAvVXc0d1FVQ1F2ZUdXalZ5bExOcWlCNFZ5dmtQNHluSDRo?=
 =?utf-8?B?Z0xSZ2x0ZEdobFcwekZ0NkVCZ1dGSGhWUlZ6THAybXV6UnJ3SlVwTmFNTWxE?=
 =?utf-8?B?VTgxUmdtR3VBNWtUVStzQiszejdNV1B5VmR1YVdPajZNYVF1T0tTTkFYWmNS?=
 =?utf-8?B?VFlOTFhTK04vY0dSM1IzRlRkTUF6TkFjQjBoYWtsdVF6T2l4dWUvOTRKZFEr?=
 =?utf-8?B?dHpXLy80NStNSmZMK1Y1SGFyUWY0ZVlvdFBqWVp1WGFBNFpOU3lHaUlwZ3k0?=
 =?utf-8?B?K1lud3c1RzFTU2p6TklveDErRFhwUW9sZ0VEdCtDUVRTcXdNNW9rZVVjdm8w?=
 =?utf-8?B?c0dvc0xXYUhYekZHbFBkQThkS29qeEJuZFBndXNCenFjQ1c0d01aTkNSTkZW?=
 =?utf-8?B?Ri9GNFY2OVBQQnJRdk1HNHdXUVI0OU44WUhXOVlQd20wYWdtT1FDK1U4ZkQ4?=
 =?utf-8?B?V09vWTQxVDRvYkJ4L2RYRUZaVDlaVkJRMDgzcmlKejRNRDk1T2N2elpVU0Ni?=
 =?utf-8?B?UnF2M2hVNHRld1dEVEFtY2ZUYkdZbnRmMjhXVjJWd2tQSDZzTFJxSDNUR1Zu?=
 =?utf-8?B?ZmVoQmM2Rk9FY1QvTWxiYjYxRGlvQnBtNDZzWmNUeDBLTkZkTnU5b0JrUVhW?=
 =?utf-8?B?b0VaMXZ6bkJvemZJN1k1NjgwNXlKSVgzdGhaM05YSVA0TUJwZnVSbVJ2UWNJ?=
 =?utf-8?B?a3JJeFowQVV4c2tYOUcxVHVNTGRzNVMxYXFrbzRzNlB1VlhBcHdvbUhPMDFa?=
 =?utf-8?Q?pYDWcc1AFIf/yc+c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00F06019329ACF42B9353BEBD6CEC327@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12deba3-9892-4569-53c6-08de548a722b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 23:04:33.0775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XV7wYl97H2c4X8uidKa0G6ibtqGwNe7j6uEk4z5Cmp7P0zwLhuo12aXdWf8nZio0xLmoB3KMQQfGk4twgJwwvxKCxrvU/I4WpgIrF1wVDaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTAxLTE0IGF0IDEzOjQ2ICswMDAwLCBLYWx5YXppbiwgTmlraXRhIHdyb3Rl
Og0KPiBBZGQgR1VFU1RfTUVNRkRfRkxBR19OT19ESVJFQ1RfTUFQIGZsYWcgZm9yIEtWTV9DUkVB
VEVfR1VFU1RfTUVNRkQoKQ0KPiBpb2N0bC4gV2hlbiBzZXQsIGd1ZXN0X21lbWZkIGZvbGlvcyB3
aWxsIGJlIHJlbW92ZWQgZnJvbSB0aGUgZGlyZWN0IG1hcA0KPiBhZnRlciBwcmVwYXJhdGlvbiwg
d2l0aCBkaXJlY3QgbWFwIGVudHJpZXMgb25seSByZXN0b3JlZCB3aGVuIHRoZSBmb2xpb3MNCj4g
YXJlIGZyZWVkLg0KPiANCj4gVG8gZW5zdXJlIHRoZXNlIGZvbGlvcyBkbyBub3QgZW5kIHVwIGlu
IHBsYWNlcyB3aGVyZSB0aGUga2VybmVsIGNhbm5vdA0KPiBkZWFsIHdpdGggdGhlbSwgc2V0IEFT
X05PX0RJUkVDVF9NQVAgb24gdGhlIGd1ZXN0X21lbWZkJ3Mgc3RydWN0DQo+IGFkZHJlc3Nfc3Bh
Y2UgaWYgR1VFU1RfTUVNRkRfRkxBR19OT19ESVJFQ1RfTUFQIGlzIHJlcXVlc3RlZC4NCj4gDQo+
IE5vdGUgdGhhdCB0aGlzIGZsYWcgY2F1c2VzIHJlbW92YWwgb2YgZGlyZWN0IG1hcCBlbnRyaWVz
IGZvciBhbGwNCj4gZ3Vlc3RfbWVtZmQgZm9saW9zIGluZGVwZW5kZW50IG9mIHdoZXRoZXIgdGhl
eSBhcmUgInNoYXJlZCIgb3IgInByaXZhdGUiDQo+IChhbHRob3VnaCBjdXJyZW50IGd1ZXN0X21l
bWZkIG9ubHkgc3VwcG9ydHMgZWl0aGVyIGFsbCBmb2xpb3MgaW4gdGhlDQo+ICJzaGFyZWQiIHN0
YXRlLCBvciBhbGwgZm9saW9zIGluIHRoZSAicHJpdmF0ZSIgc3RhdGUgaWYNCj4gR1VFU1RfTUVN
RkRfRkxBR19NTUFQIGlzIG5vdCBzZXQpLiBUaGUgdXNlY2FzZSBmb3IgcmVtb3ZpbmcgZGlyZWN0
IG1hcA0KPiBlbnRyaWVzIG9mIGFsc28gdGhlIHNoYXJlZCBwYXJ0cyBvZiBndWVzdF9tZW1mZCBh
cmUgYSBzcGVjaWFsIHR5cGUgb2YNCj4gbm9uLUNvQ28gVk0gd2hlcmUsIGhvc3QgdXNlcnNwYWNl
IGlzIHRydXN0ZWQgdG8gaGF2ZSBhY2Nlc3MgdG8gYWxsIG9mDQo+IGd1ZXN0IG1lbW9yeSwgYnV0
IHdoZXJlIFNwZWN0cmUtc3R5bGUgdHJhbnNpZW50IGV4ZWN1dGlvbiBhdHRhY2tzDQo+IHRocm91
Z2ggdGhlIGhvc3Qga2VybmVsJ3MgZGlyZWN0IG1hcCBzaG91bGQgc3RpbGwgYmUgbWl0aWdhdGVk
LsKgIEluIHRoaXMNCj4gc2V0dXAsIEtWTSByZXRhaW5zIGFjY2VzcyB0byBndWVzdCBtZW1vcnkg
dmlhIHVzZXJzcGFjZSBtYXBwaW5ncyBvZg0KPiBndWVzdF9tZW1mZCwgd2hpY2ggYXJlIHJlZmxl
Y3RlZCBiYWNrIGludG8gS1ZNJ3MgbWVtc2xvdHMgdmlhDQo+IHVzZXJzcGFjZV9hZGRyLiBUaGlz
IGlzIG5lZWRlZCBmb3IgdGhpbmdzIGxpa2UgTU1JTyBlbXVsYXRpb24gb24geDg2XzY0DQo+IHRv
IHdvcmsuDQoNClREWCBkb2VzIHNvbWUgY2xlYXJpbmcgYXQgdGhlIGRpcmVjdCBtYXAgbWFwcGlu
ZyBmb3IgcGFnZXMgdGhhdCBjb21lcyBmcm9tIGdtZW0sDQp1c2luZyBhIHNwZWNpYWwgaW5zdHJ1
Y3Rpb24uIEl0IGFsc28gZG9lcyBzb21lIGNsZmx1c2hpbmcgYXQgdGhlIGRpcmVjdCBtYXANCmFk
ZHJlc3MgZm9yIHRoZXNlIHBhZ2VzLiBTbyBJIHRoaW5rIHdlIG5lZWQgdG8gbWFrZSBzdXJlIFRE
cyBkb24ndCBwdWxsIGZyb20NCmdtZW0gZmRzIHdpdGggdGhpcyBmbGFnLg0KDQpOb3QgdGhhdCB0
aGVyZSB3b3VsZCBiZSBhbnkgZXhwZWN0ZWQgdXNlIG9mIHRoZSBmbGFnIGZvciBURHMsIGJ1dCBp
dCBjb3VsZCBjYXVzZQ0KYSBjcmFzaC4NCg==

