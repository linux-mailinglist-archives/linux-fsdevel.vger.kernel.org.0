Return-Path: <linux-fsdevel+bounces-32683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E3F9AD58A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 22:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FAF1F25DAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD71E25FC;
	Wed, 23 Oct 2024 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U03KLdeu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BBB1AC448;
	Wed, 23 Oct 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715655; cv=fail; b=bW1Fk57ogWLdWrqwBJs5CXTjUYb8C5cZ0hqPGGsNwY8gGwHDbX+as6mPBFsZzT6IMMx+/JZIarH94iLfLiRYRsiNanF9zn0O0/vEh1MbNoe35ER6XUPUjmBBU5vR8J0/H4OMxpmwKiorysijXA6o0Pgc5OG4/aAt4c3k73CQ4rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715655; c=relaxed/simple;
	bh=9XjAdFXYkln7JJjbWtqPULf0Catb0LYPcu1MaZtGS78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hlgw7LfqUDsfukVrTRthb+M8ThNGp5PMI+gWuMPExdkHggxwHE7rroQM92a1QziNBZvO3Pvclr7v4qjgK7qucLIZrsqYUGEtHSytnwFrSAc/pAOgYZ2EdPZ3dwydNniWkQmUegyVn0q0IihRzLWTto1EPuRY3yqN26nCHtYRbTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U03KLdeu; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729715650; x=1761251650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9XjAdFXYkln7JJjbWtqPULf0Catb0LYPcu1MaZtGS78=;
  b=U03KLdeuA7J/BjQoUH7M0BcXWphS9cGGw1w7hK7B/A0pbWvGsKFEOAhf
   a3p8KKWG4GW87tb4vylD2/fqzy8Jgt//ehQ2azI6f/tbthU/jH2eOEHyJ
   RwoXcYziXnefAje6LHkAheixju1CJpf8v65Yp5RW9GqNMmx3T8eUtuD5O
   0F0X9csne4Bxnq6EKElSo0zzqfrrUywmeg4CBgGRqhmxLd+AtOAPijJ0N
   z40r+bXWx6K7ofIrIdUGexbxmZzUigzhov6w9053HAQ7w+wmF1dLMmFCd
   Oo5M8ANQQ5Q95N/BitCfukuG/+4CBzG/Oz7WQklx7W22NqtsxYSYXn6Wp
   w==;
X-CSE-ConnectionGUID: 0mf2pTqYQ5+CVxheoyWYGg==
X-CSE-MsgGUID: iZkzGr6BRSa4eR1q8d/eUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46790916"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46790916"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 13:34:09 -0700
X-CSE-ConnectionGUID: q8ZwpPw6TlmPk/ab/uzdyw==
X-CSE-MsgGUID: NhhDMLXFRV+fyvBY20aWEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80297101"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 13:34:10 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 13:34:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 13:34:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 13:34:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW1nAw1P+xNUaQD+KVPn+qrTmrqFoLIkXibIVxv/kcP0VXMDoSC5y7tnrbKOlCObqqQ9Ii0jml9kzyu4Pget1w6RQbRp4cFj5wdpdC9WWl2zun2YCGol/SJlLiDMXAaf0mTkLgBLQFpORb+z4I31X4LvrGFpR0toDVuElqDuNElGSSGU6K8UrcA3BcbLrh0N24NXHuSyTR4oBe78dk8RhPQa/aDJi1MckE4Ayj774oh05FORL2ivPG/le1L5oPib7yYPCg2PmDdOmuF3/CvibhuaCLU0NPE8YT5DEEUtCmrNO3+Kz0FX0fJo7W74I45gEc48Ah64X7YnVEbrf4521A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XjAdFXYkln7JJjbWtqPULf0Catb0LYPcu1MaZtGS78=;
 b=dqyLpegJlyl7ecRHbSbuhM/jNY5WupVWNyIdi3KHAZmMXPVPdrbBY6vsXBuzjo4Dwa82f01ESDJmEaexqiE6EXY5Gj8U2kzwsmZ1wrTvMGhZee4CyMHLFnNuVyW4Viqk9G5Fjnwd2S89onORQp8iNNTF4C/EdAef3DqAYtL0hMcvpIsZA0/4kaqVasJ2ErareRDyTaKNc0YERaDHJwyk9lzDwb8dtvQKJ7GPiQnJJ5FnNV1wWlV+scGTUJgwkuMX04l/ezm38+EEYF/00436xbJY5UYFAqKdlNU8iB9sMjDqgc9ijxTEM0ZkdFsmjZnUUgAE/O7OX3QvQGkA0Q+Eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CY8PR11MB7746.namprd11.prod.outlook.com (2603:10b6:930:86::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 20:34:06 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 20:34:06 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "ebiggers@google.com" <ebiggers@google.com>,
	"surenb@google.com" <surenb@google.com>, "Accardi, Kristen C"
	<kristen.c.accardi@intel.com>, "zanussi@kernel.org" <zanussi@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "bfoster@redhat.com"
	<bfoster@redhat.com>, "willy@infradead.org" <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [RFC PATCH v1 00/13] zswap IAA compress batching
Thread-Topic: [RFC PATCH v1 00/13] zswap IAA compress batching
Thread-Index: AQHbISi7WkqKY25eqEChcyk+C2mC67KTipoAgAAXm7CAAQqnAIAAJhUg
Date: Wed, 23 Oct 2024 20:34:05 +0000
Message-ID: <SJ0PR11MB5678AA55241882949D44B376C94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkamDPn8LKTd-0praj+MMJ3cNVuF3R0ivqHCW=2vWBQ_Yw@mail.gmail.com>
 <SJ0PR11MB56784C5C542E84014525BA8CC94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZ9VLNrwyeRQf0AXdQAG8vW_ZL_y0rfU77p5HMZnch=mw@mail.gmail.com>
In-Reply-To: <CAJD7tkZ9VLNrwyeRQf0AXdQAG8vW_ZL_y0rfU77p5HMZnch=mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CY8PR11MB7746:EE_
x-ms-office365-filtering-correlation-id: 1f3cc55a-f42c-4b11-2319-08dcf3a20a17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VW9OeWxhb0dJb25VNnpnbjNnc09SZmFicVA4YXBIVTBsdnNmdjJLQ1drT3Vp?=
 =?utf-8?B?TGtDV1FrOUYzTWR0R2dMRFkyVEJSbGo2dlRoYzRMcTV4YmFtSmRqYU1DcERN?=
 =?utf-8?B?YnRvL3g3YWJkaXcyTjNJWWg1RFhGYzdWUlZOUnVmZHdkUm1ORDVaKzB2SElN?=
 =?utf-8?B?UE82UVprUG1kKzdLMjdXTzJmSHI5Y3A5bG1BMTNaYnF4c1paTUJyRkZHR1Qr?=
 =?utf-8?B?Vk0vcjV0UStFRjY3TUFrV0tlazYySlRHTXJiZzRmQ0ZaZlBqeS9RRlZISUpz?=
 =?utf-8?B?MWVHOFJGWFYrRnVCM0s2d0d5OUM0ZDh4VXpXM3EyVkpBUkZpVVcwMDRqTVVN?=
 =?utf-8?B?UUludFFIUFpnNXlmZml0L1EranY2MldWZjhTYVdWakFOT21UUjk1UHRtRVRr?=
 =?utf-8?B?M2dOUXEva0RCbU5LWC9CUkIwR3NyL1dDVjB0eXMyNVNOckRMZW1tb3ErK1RO?=
 =?utf-8?B?WTd2VVB3VTNSQi9RYmJZZXJwMkRCdmp4cWlpcmJ3NVB6NG5td2MrdDBTWjV0?=
 =?utf-8?B?VUh0UUQwemNqZ0YreFZ0YTJhNlZqdHpmMDNMWGk1U3FvU0hxbHkzb0RENlQx?=
 =?utf-8?B?N1JFdTdyeG1BckZsaWEyQ2RhWWhZZ0hvcWh6cVVpc205NjdDRHdidVg1R2Vh?=
 =?utf-8?B?Vi8rS0ZWSmZOUHNNcGhYRFNJaWd6Z3hMbWc4eVBxT2F0RDIvSnlzRFI1eUtT?=
 =?utf-8?B?cG9udUtCZHhJUTRETEZnVjRZcFVTQStSazRwcktlZXdlQy9ob0xZSE41OEpI?=
 =?utf-8?B?V3ZkN3VTODEyWUZRQlB1bUZQUjErY3haZmZkOVNocXJPMEhhc3l4amxVYm9u?=
 =?utf-8?B?RXRXQ2pkOGs0NkVBajlQUDVZSC9odVpHNllMVVBkRzZjajRJK2w1TmpHZGRk?=
 =?utf-8?B?OUx2UWppZlhCOXBMMVh4c1FuL05JTENuSEJXMjV3dXd6Yy92WmlrTmxJN0Mw?=
 =?utf-8?B?bll4ZUd4eGdjdTZHN0cvUW8yK1ZsVXhJMmxTYmNIZEw2OE9DYjBUbUhRR2ho?=
 =?utf-8?B?VW1wejJNQzBOb1NrVmhrVjBiSnd2TzcrOHo0QWZXSG91MmRJWEdtTzBNbUpo?=
 =?utf-8?B?ODFsSU9Obzg0YTlCdjRYakRMUkRvTmk3WE9acmRzSjVQaHk2QndIV3JoZHEy?=
 =?utf-8?B?dm93OWtrK3FoZmtabk9hNUUzbjVNbEZ0ZUhiOUM4VXpaQStkd0F1MFZYd0da?=
 =?utf-8?B?MWZReE02TzhOSitjREFNMXcxRTVHRWhUcE5mYkdkSWdIcG41MlpVY1VkbGJv?=
 =?utf-8?B?b0J3eUUwM0pRdmMvZk9wSGpBbjB6ODZWQURnbk1TR0dXK1JQczJQZityTTI5?=
 =?utf-8?B?bFJ6d25ybE9hQTQ2VTNpMzNtaWVCQnp4aUQrS2FsbTlZbmJMc1pSWGF5MjhS?=
 =?utf-8?B?SC9VUm1jQ2dMbHBXaFRra2ZMVGlPUnQ0MHZBcWlhQ1ZYOXRmWmZ2RFRudzV1?=
 =?utf-8?B?dTZ1dkI2NVdXMDZ1clVzM1NCenpnNEVtSGtpbUpBSlBsekxIYytjS1plUDk5?=
 =?utf-8?B?bnQrbU9SOENEcWF2QXV1TkdPS0loR2IyS0w4Q2YyS3R1YlAzdzZoWmhxQWhn?=
 =?utf-8?B?WitnVUREYUlCNDRreFVIRGh0SUU5UzlUVmN5WFNiT29RQ0xER05tV3FmL0JB?=
 =?utf-8?B?a3U5cW1kam5zbTZWOXRWcjZXZnd1bTc3RGlMYVkrUjVoY3IvSE5nZWpNam13?=
 =?utf-8?B?NFYzMHNEcWxLYXgyT0tWQU1tR2tLbENiMkkrNEZhNy9xb2Q4NkhLcFNSallP?=
 =?utf-8?B?QkVIOXRsYlBXSnFkZlE2N0c5aDRua0NzL1grTkNsMDhPSDBtWW5ONWZTc0dP?=
 =?utf-8?Q?JZ3iHx6Yf3LulYw37MmaoKf1G8kyHU2me8g5M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFRMWUdHNkwvYk1LR0tJck5GVXpmZGtWaDJ5czlqeDFFekZGZHFoZWpERHE4?=
 =?utf-8?B?U1RyblVLZVdxR3ZkYmlYTGFoVFhlRzNxdzZLRTBIWnh4K0p4Y052TjZyd2pQ?=
 =?utf-8?B?TUd5RWFIZ3pSVEdabFpCYnVBdEluVmdyZ1ByenJaazVxRUt1elRmaFFNRUkz?=
 =?utf-8?B?L21ZSTE0MTRBT3dVZjB2Q3VZSzZzcHZYNU04bzhxZ1M2clRQRTdCZVJIc254?=
 =?utf-8?B?eVdiakJhMHBCNU43aVhrbjBaaHRraVFiNkxzblQ1aHg5cW45QTUxTkM2V1lO?=
 =?utf-8?B?ZlpBcmFhYjd6NEZDZlRMREQ0Rkh2eFZYT0k5SnVGd1dLSFhGUVA2Y3dSMGw2?=
 =?utf-8?B?WlZ6R3FVTVVnaU51Q2RCQmY2WDJuN1IybG1SOWFYcWVrYVl5eWt1SDZhWG51?=
 =?utf-8?B?WWJtUitPMkZMRFhPcE1xRmFnRGE5dktFZVc1ODlHcis3YlRwNXVvemRPQVA5?=
 =?utf-8?B?bHBzNW1qT2NXclhkanlHOXZSRDJsMG1vNUljZXlxemt3RE1TblEzQ3FmTXYx?=
 =?utf-8?B?ZjlUWjlpMUxHa0ZRNnNNbHYvWnJtRmpGeUN4UFV2TERhVDFRdXF5MjZTTVRh?=
 =?utf-8?B?eVlvdHlUWDJyQWhRZFpBL0E4Zi9zRTM0NVAxTUwwRDFxTFZ5VVlZakUrQ2ov?=
 =?utf-8?B?VC9Zejh3NXBwdGlCZnFTZzJRUk92eXppWFFLK24yUHcvcWttN1c5c0hNanNu?=
 =?utf-8?B?Ui9DMmlSb24vdlltVWxlZHh3R3RCTDBKVlM0eVNocnRJejBrdWdFZ1JEU2tZ?=
 =?utf-8?B?LzZTR0JIRW9SeEp3eDBMTGNwb1ZJVTZBZ1RCQVc0dnBoUEFvOGxCSXRFcjRB?=
 =?utf-8?B?NHpHSHRCc05nSjFGK05VaWNGVnhxNGpENWZhSlFvSkhHVTV4MHVlRlJkbUVl?=
 =?utf-8?B?R0RrSDhXajlleHhEbjhVb3pPb0hXajYzdTlyY1UwNDAzTmNNQ0ZCNkp1bGg4?=
 =?utf-8?B?TWV0bm1qSG1KUWpnRUtuMkY0L1YvRlE1UHNINFlhV0JCYkp3Y1pXb1hZb2Ux?=
 =?utf-8?B?RHd5QjJuV2dIY09OaDlsY3VqNDIvaDZ1cXJDREYyaktSb3hvWkZMM1F2SXR1?=
 =?utf-8?B?amVTWDcwTGxDZzdvQmxJWm1iSmo5aWJSamZ5RzNiTWppNmZPZllJRHZWVENl?=
 =?utf-8?B?YUtBYzdQQlpXU0ZaRjg1UlhJWHEzaEQ1aDFwdWd6VHdUSjhqK3RWSmZoS0NR?=
 =?utf-8?B?SjNxVXJ6UVNTUjlucmZHalJxWHFickZqSi9lMlRjY004ZUNOSDN2UnZhUHc3?=
 =?utf-8?B?U0JsWTA4YlBYK2lCMTNjSllXeDZRNUhHMGhSMTU1SXd0VmhrUkw3YmI1dVlH?=
 =?utf-8?B?RG9LZzBvRW5pVHpmdStTK29OajRMUG5EaDhEMXRoNlJsVm9BR0FpU0c2RFFU?=
 =?utf-8?B?blFlLzRCSDg4TzFYOVcyTlZpeUdyd1VySXN4MHY0OVlLTW04dHpOTWlJdXU0?=
 =?utf-8?B?aXVRUm5FdUhsNVo1YTZIajE0MW1zVWVSVkpuWjZGczJTaC9vR254cG9IOGho?=
 =?utf-8?B?M1JWT3I3a2Y5RVViV0dtaDZIbXc2eHA1STZmTG5PaWFKS200eG4wdjVjM0F2?=
 =?utf-8?B?YWhLUkI0Uytub0JGd1ZKcnFJc3lFdFJOaXBDaWJQWFJUUm9oRzN2Q3dDN0Iz?=
 =?utf-8?B?S3ViQUFINTFTS3RLVEpYdlkzU0JjZDN1MC9KYVZnQ0dwZGFxUjVNUUNNWkdH?=
 =?utf-8?B?QjlGMWVYdE44L1VKYzYvSTJHRlFUalk3a2swajVLYjNZeG92MDdCNEZKOHJ6?=
 =?utf-8?B?RVE1Z2kvUG9ndGV1TlhReGx5TFpmS3ZkYThiWUsxd0MyZlZmSGlobHNmVzQy?=
 =?utf-8?B?OVlTUWI1UkYzZnZKOElrWGl3Q1pmU2JlYXFETTIwRzZvK0pQQVFBODAwL1Rt?=
 =?utf-8?B?M0h2ZUlvR09iNER1UXFwQnNOUlBzUjE1SGNEeEZCbFhRZm1ENk94Kyt4SEty?=
 =?utf-8?B?dWlXSVlMK2xKWXNxMkZmQUU1NXljQnRKeWphaGdhenNrQ3Z3Q3kvSWFLTjRj?=
 =?utf-8?B?VGF4VTdqcmxnby9XV3RucG9jM3NUS1F6VHhVSzgxdnh5SVY5dmF2TndjdUll?=
 =?utf-8?B?dXFyazhJRXBna1U3L3pOYzBmcXBsV2tRazYxMVJiN0lVaTRWWFQ4aUR0UWYw?=
 =?utf-8?B?aEYxeVBiWWh5M2cyVEt6V1I1Z2ZOZ2pwOEE2NGNvSXQyRU9LcGsyRTVYc04w?=
 =?utf-8?B?Nm80UnB3Sk1OdHNyWXdjdXlGOThzVm41SWczYlU3aHplSjBoWGUxQVZ3d1E1?=
 =?utf-8?B?eTRUVERtVXpnemNnTzhoSENhT25BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3cc55a-f42c-4b11-2319-08dcf3a20a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 20:34:05.8898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJXSgsbNWK+PTYYRJSx92HZAzFaTlsgbVVAB8na04W0vn0kkix5nyYp3O+4c2Xi8h1avG4xA2pvhsYmqtcyPqWQexv/B7Hy0UqDMxkV4/qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7746
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyMywgMjAyNCAx
MToxNiBBTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGlu
dGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2
YWNrLm9yZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgY2hlbmdt
aW5nLnpob3VAbGludXguZGV2Ow0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyByeWFuLnJvYmVy
dHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcNCj4gPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJh
b0BnbWFpbC5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IGxpbnV4LWNyeXB0b0B2
Z2VyLmtlcm5lbC5vcmc7IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsNCj4gZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldDsgY2xhYmJlQGJheWxpYnJlLmNvbTsgYXJkYkBrZXJuZWwub3JnOw0KPiBlYmln
Z2Vyc0Bnb29nbGUuY29tOyBzdXJlbmJAZ29vZ2xlLmNvbTsgQWNjYXJkaSwgS3Jpc3RlbiBDDQo+
IDxrcmlzdGVuLmMuYWNjYXJkaUBpbnRlbC5jb20+OyB6YW51c3NpQGtlcm5lbC5vcmc7IHZpcm9A
emVuaXYubGludXgub3JnLnVrOw0KPiBicmF1bmVyQGtlcm5lbC5vcmc7IGphY2tAc3VzZS5jejsg
bWNncm9mQGtlcm5lbC5vcmc7IGtlZXNAa2VybmVsLm9yZzsNCj4gam9lbC5ncmFuYWRvc0BrZXJu
ZWwub3JnOyBiZm9zdGVyQHJlZGhhdC5jb207IHdpbGx5QGluZnJhZGVhZC5vcmc7IGxpbnV4LQ0K
PiBmc2RldmVsQHZnZXIua2VybmVsLm9yZzsgRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdo
YWxpQGludGVsLmNvbT47IEdvcGFsLA0KPiBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxIDAwLzEzXSB6c3dhcCBJQUEgY29tcHJlc3Mg
YmF0Y2hpbmcNCj4gDQo+IE9uIFR1ZSwgT2N0IDIyLCAyMDI0IGF0IDc6NTPigK9QTSBTcmlkaGFy
LCBLYW5jaGFuYSBQDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IEhpIFlvc3J5LA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gRnJvbTogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gPiA+IFNl
bnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjIsIDIwMjQgNTo1NyBQTQ0KPiA+ID4gVG86IFNyaWRoYXIs
IEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4gaGFu
bmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsNCj4gY2hlbmdtaW5nLnpob3VAbGlu
dXguZGV2Ow0KPiA+ID4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgcnlhbi5yb2JlcnRzQGFybS5j
b207IEh1YW5nLCBZaW5nDQo+ID4gPiA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdt
YWlsLmNvbTsgYWtwbUBsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc7DQo+ID4gPiBsaW51eC1jcnlw
dG9Admdlci5rZXJuZWwub3JnOyBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7DQo+ID4gPiBk
YXZlbUBkYXZlbWxvZnQubmV0OyBjbGFiYmVAYmF5bGlicmUuY29tOyBhcmRiQGtlcm5lbC5vcmc7
DQo+ID4gPiBlYmlnZ2Vyc0Bnb29nbGUuY29tOyBzdXJlbmJAZ29vZ2xlLmNvbTsgQWNjYXJkaSwg
S3Jpc3RlbiBDDQo+ID4gPiA8a3Jpc3Rlbi5jLmFjY2FyZGlAaW50ZWwuY29tPjsgemFudXNzaUBr
ZXJuZWwub3JnOw0KPiB2aXJvQHplbml2LmxpbnV4Lm9yZy51azsNCj4gPiA+IGJyYXVuZXJAa2Vy
bmVsLm9yZzsgamFja0BzdXNlLmN6OyBtY2dyb2ZAa2VybmVsLm9yZzsNCj4ga2Vlc0BrZXJuZWwu
b3JnOw0KPiA+ID4gam9lbC5ncmFuYWRvc0BrZXJuZWwub3JnOyBiZm9zdGVyQHJlZGhhdC5jb207
IHdpbGx5QGluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LQ0KPiA+ID4gZnNkZXZlbEB2Z2VyLmtlcm5l
bC5vcmc7IEZlZ2hhbGksIFdhamRpIEsgPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+Ow0KPiBH
b3BhbCwNCj4gPiA+IFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUkZDIFBBVENIIHYxIDAwLzEzXSB6c3dhcCBJQUEgY29tcHJlc3MgYmF0Y2hpbmcN
Cj4gPiA+DQo+ID4gPiBPbiBUaHUsIE9jdCAxNywgMjAyNCBhdCAxMTo0MeKAr1BNIEthbmNoYW5h
IFAgU3JpZGhhcg0KPiA+ID4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0K
PiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBJQUEgQ29tcHJlc3Npb24gQmF0Y2hpbmc6DQo+ID4g
PiA+ID09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBSRkMg
cGF0Y2gtc2VyaWVzIGludHJvZHVjZXMgdGhlIHVzZSBvZiB0aGUgSW50ZWwgQW5hbHl0aWNzDQo+
IEFjY2VsZXJhdG9yDQo+ID4gPiA+IChJQUEpIGZvciBwYXJhbGxlbCBjb21wcmVzc2lvbiBvZiBw
YWdlcyBpbiBhIGZvbGlvLCBhbmQgZm9yIGJhdGNoZWQgcmVjbGFpbQ0KPiA+ID4gPiBvZiBoeWJy
aWQgYW55LW9yZGVyIGJhdGNoZXMgb2YgZm9saW9zIGluIHNocmlua19mb2xpb19saXN0KCkuDQo+
ID4gPiA+DQo+ID4gPiA+IFRoZSBwYXRjaC1zZXJpZXMgaXMgb3JnYW5pemVkIGFzIGZvbGxvd3M6
DQo+ID4gPiA+DQo+ID4gPiA+ICAxKSBpYWFfY3J5cHRvIGRyaXZlciBlbmFibGVycyBmb3IgYmF0
Y2hpbmc6IFJlbGV2YW50IHBhdGNoZXMgYXJlIHRhZ2dlZA0KPiA+ID4gPiAgICAgd2l0aCAiY3J5
cHRvOiIgaW4gdGhlIHN1YmplY3Q6DQo+ID4gPiA+DQo+ID4gPiA+ICAgICBhKSBhc3luYyBwb2xs
IGNyeXB0b19hY29tcCBpbnRlcmZhY2Ugd2l0aG91dCBpbnRlcnJ1cHRzLg0KPiA+ID4gPiAgICAg
YikgY3J5cHRvIHRlc3RtZ3IgYWNvbXAgcG9sbCBzdXBwb3J0Lg0KPiA+ID4gPiAgICAgYykgTW9k
aWZ5aW5nIHRoZSBkZWZhdWx0IHN5bmNfbW9kZSB0byAiYXN5bmMiIGFuZCBkaXNhYmxpbmcNCj4g
PiA+ID4gICAgICAgIHZlcmlmeV9jb21wcmVzcyBieSBkZWZhdWx0LCB0byBmYWNpbGl0YXRlIHVz
ZXJzIHRvIHJ1biBJQUEgZWFzaWx5IGZvcg0KPiA+ID4gPiAgICAgICAgY29tcGFyaXNvbiB3aXRo
IHNvZnR3YXJlIGNvbXByZXNzb3JzLg0KPiA+ID4gPiAgICAgZCkgQ2hhbmdpbmcgdGhlIGNwdS10
by1pYWEgbWFwcGluZ3MgdG8gbW9yZSBldmVubHkgYmFsYW5jZSBjb3JlcyB0bw0KPiBJQUENCj4g
PiA+ID4gICAgICAgIGRldmljZXMuDQo+ID4gPiA+ICAgICBlKSBBZGRpdGlvbiBvZiBhICJnbG9i
YWxfd3EiIHBlciBJQUEsIHdoaWNoIGNhbiBiZSB1c2VkIGFzIGEgZ2xvYmFsDQo+ID4gPiA+ICAg
ICAgICByZXNvdXJjZSBmb3IgdGhlIHNvY2tldC4gSWYgdGhlIHVzZXIgY29uZmlndXJlcyAyV1Fz
IHBlciBJQUEgZGV2aWNlLA0KPiA+ID4gPiAgICAgICAgdGhlIGRyaXZlciB3aWxsIGRpc3RyaWJ1
dGUgY29tcHJlc3Mgam9icyBmcm9tIGFsbCBjb3JlcyBvbiB0aGUNCj4gPiA+ID4gICAgICAgIHNv
Y2tldCB0byB0aGUgImdsb2JhbF93cXMiIG9mIGFsbCB0aGUgSUFBIGRldmljZXMgb24gdGhhdCBz
b2NrZXQsIGluDQo+ID4gPiA+ICAgICAgICBhIHJvdW5kLXJvYmluIG1hbm5lci4gVGhpcyBjYW4g
YmUgdXNlZCB0byBpbXByb3ZlIGNvbXByZXNzaW9uDQo+ID4gPiA+ICAgICAgICB0aHJvdWdocHV0
IGZvciB3b3JrbG9hZHMgdGhhdCBzZWUgYSBsb3Qgb2Ygc3dhcG91dCBhY3Rpdml0eS4NCj4gPiA+
ID4NCj4gPiA+ID4gIDIpIE1pZ3JhdGluZyB6c3dhcCB0byB1c2UgYXN5bmMgcG9sbCBpbg0KPiB6
c3dhcF9jb21wcmVzcygpL2RlY29tcHJlc3MoKS4NCj4gPiA+ID4gIDMpIEEgY2VudHJhbGl6ZWQg
YmF0Y2ggY29tcHJlc3Npb24gQVBJIHRoYXQgY2FuIGJlIHVzZWQgYnkgc3dhcA0KPiBtb2R1bGVz
Lg0KPiA+ID4gPiAgNCkgSUFBIGNvbXByZXNzIGJhdGNoaW5nIHdpdGhpbiBsYXJnZSBmb2xpbyB6
c3dhcCBzdG9yZXMuDQo+ID4gPiA+ICA1KSBJQUEgY29tcHJlc3MgYmF0Y2hpbmcgb2YgYW55LW9y
ZGVyIGh5YnJpZCBmb2xpb3MgaW4NCj4gPiA+ID4gICAgIHNocmlua19mb2xpb19saXN0KCkuIFRo
ZSBuZXdseSBhZGRlZCAic3lzY3RsIHZtLmNvbXByZXNzLWJhdGNoc2l6ZSINCj4gPiA+ID4gICAg
IHBhcmFtZXRlciBjYW4gYmUgdXNlZCB0byBjb25maWd1cmUgdGhlIG51bWJlciBvZiBmb2xpb3Mg
aW4gWzEsIDMyXSB0bw0KPiA+ID4gPiAgICAgYmUgcmVjbGFpbWVkIHVzaW5nIGNvbXByZXNzIGJh
dGNoaW5nLg0KPiA+ID4NCj4gPiA+IEkgYW0gc3RpbGwgZGlnZXN0aW5nIHRoaXMgc2VyaWVzIGJ1
dCBJIGhhdmUgc29tZSBoaWdoIGxldmVsIHF1ZXN0aW9ucw0KPiA+ID4gdGhhdCBJIGxlZnQgb24g
c29tZSBwYXRjaGVzLiBNeSBpbnR1aXRpb24gdGhvdWdoIGlzIHRoYXQgd2Ugc2hvdWxkDQo+ID4g
PiBkcm9wICg1KSBmcm9tIHRoZSBpbml0aWFsIHByb3Bvc2FsIGFzIGl0J3MgbW9zdCBjb250cm92
ZXJzaWFsLg0KPiA+ID4gQmF0Y2hpbmcgcmVjbGFpbSBvZiB1bnJlbGF0ZWQgZm9saW9zIHRocm91
Z2ggenN3YXAgKm1pZ2h0KiBtYWtlIHNlbnNlLA0KPiA+ID4gYnV0IGl0IG5lZWRzIGEgYnJvYWRl
ciBjb252ZXJzYXRpb24gYW5kIGl0IG5lZWRzIGp1c3RpZmljYXRpb24gb24gaXRzDQo+ID4gPiBv
d24gbWVyaXQsIHdpdGhvdXQgdGhlIHJlc3Qgb2YgdGhlIHNlcmllcy4NCj4gPg0KPiA+IFRoYW5r
cyBmb3IgdGhlc2Ugc3VnZ2VzdGlvbnMhICBTdXJlLCBJIGNhbiBkcm9wICg1KSBmcm9tIHRoZSBp
bml0aWFsIHBhdGNoLXNldC4NCj4gPiBBZ3JlZSBhbHNvLCB0aGlzIG5lZWRzIGEgYnJvYWRlciBk
aXNjdXNzaW9uLg0KPiA+DQo+ID4gSSBiZWxpZXZlIHRoZSA0SyBmb2xpb3MgdXNlbWVtMzAgZGF0
YSBpbiB0aGlzIHBhdGNoc2V0IGRvZXMgYnJpbmcgYWNyb3NzDQo+ID4gdGhlIGJhdGNoaW5nIHJl
Y2xhaW0gYmVuZWZpdHMgdG8gcHJvdmlkZSBqdXN0aWZpY2F0aW9uIG9uIGl0cyBvd24gbWVyaXQu
IEkNCj4gYWRkZWQNCj4gPiB0aGUgZGF0YSBvbiBiYXRjaGluZyByZWNsYWltIHdpdGgga2VybmVs
IGNvbXBpbGF0aW9uIGFzIHBhcnQgb2YgdGhlIDRLIGZvbGlvcw0KPiA+IGV4cGVyaW1lbnRzIGlu
IHRoZSBJQUEgZGVjb21wcmVzc2lvbiBiYXRjaGluZyBwYXRjaC1zZXJpZXMgWzFdLg0KPiA+IExp
c3RpbmcgaXQgaGVyZSBhcyB3ZWxsLiBJIHdpbGwgbWFrZSBzdXJlIHRvIGFkZCB0aGlzIGRhdGEg
aW4gc3Vic2VxdWVudCByZXZzLg0KPiA+DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgS2Vy
bmVsIGNvbXBpbGF0aW9uIGluIHRtcGZzL2FsbG1vZGNvbmZpZywgMkcgbWF4IG1lbW9yeToNCj4g
Pg0KPiA+ICBObyBsYXJnZSBmb2xpb3MgICAgICAgICAgbW0tdW5zdGFibGUtMTAtMTYtMjAyNCAg
ICAgICBzaHJpbmtfZm9saW9fbGlzdCgpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJhdGNoaW5nIG9mIGZvbGlvcw0KPiA+ICAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ICB6c3dhcCBjb21wcmVzc29yICAgICAgICAgenN0ZCAgICAgICBk
ZWZsYXRlLWlhYSAgICAgICBkZWZsYXRlLWlhYQ0KPiA+ICB2bS5jb21wcmVzcy1iYXRjaHNpemUg
ICAgIG4vYSAgICAgICAgICAgICAgIG4vYSAgICAgICAgICAgICAgICAzMg0KPiA+ICB2bS5wYWdl
LWNsdXN0ZXIgICAgICAgICAgICAgMyAgICAgICAgICAgICAgICAgMyAgICAgICAgICAgICAgICAg
Mw0KPiA+ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICByZWFsX3NlYyAgICAgICAgICAgICAgIDc4
My44NyAgICAgICAgICAgIDc2MS42OSAgICAgICAgICAgIDc0Ny4zMg0KPiA+ICB1c2VyX3NlYyAg
ICAgICAgICAgIDE1LDc1MC4wNyAgICAgICAgIDE1LDcxNi42OSAgICAgICAgIDE1LDcyOC4zOQ0K
PiA+ICBzeXNfc2VjICAgICAgICAgICAgICA2LDUyMi4zMiAgICAgICAgICA1LDcyNS4yOCAgICAg
ICAgICA1LDM5OS40NA0KPiA+ICBNYXhfUlNTX0tCICAgICAgICAgIDEsODcyLDY0MCAgICAgICAg
IDEsODcwLDg0OCAgICAgICAgIDEsODc0LDQzMg0KPiA+DQo+ID4gIHpzd3BvdXQgICAgICAgICAg
ICA4MiwzNjQsOTkxICAgICAgICA5Nyw3MzksNjAwICAgICAgIDEwMiw3ODAsNjEyDQo+ID4gIHpz
d3BpbiAgICAgICAgICAgICAyMSwzMDMsMzkzICAgICAgICAyNyw2ODQsMTY2ICAgICAgICAyOSww
MTYsMjUyDQo+ID4gIHBzd3BvdXQgICAgICAgICAgICAgICAgICAgIDEzICAgICAgICAgICAgICAg
MjIyICAgICAgICAgICAgICAgMjEzDQo+ID4gIHBzd3BpbiAgICAgICAgICAgICAgICAgICAgIDEy
ICAgICAgICAgICAgICAgMjA5ICAgICAgICAgICAgICAgMjAyDQo+ID4gIHBnbWFqZmF1bHQgICAg
ICAgICAxNywxMTQsMzM5ICAgICAgICAyMiw0MjEsMjExICAgICAgICAyMywzNzgsMTYxDQo+ID4g
IHN3YXBfcmEgICAgICAgICAgICAgNCw1OTYsMDM1ICAgICAgICAgNSw4NDAsMDgyICAgICAgICAg
NiwyMzEsNjQ2DQo+ID4gIHN3YXBfcmFfaGl0ICAgICAgICAgMiw5MDMsMjQ5ICAgICAgICAgMyw2
ODIsNDQ0ICAgICAgICAgMyw5NDAsNDIwDQo+ID4gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4NCj4g
PiBUaGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzIHNlZW4gZG9lcyBkZXBlbmQgb24gY29tcHJl
c3Npb24gYmF0Y2hpbmcNCj4gaW4NCj4gPiB0aGUgc3dhcCBtb2R1bGVzICh6c3dhcCkuIFRoZSBp
bXBsZW1lbnRhdGlvbiBpbiBwYXRjaCAxMiBpbiB0aGUgY29tcHJlc3MNCj4gPiBiYXRjaGluZyBz
ZXJpZXMgc2V0cyB1cCB0aGlzIHpzd2FwIGNvbXByZXNzaW9uIHBpcGVsaW5lLCB0aGF0IHRha2Vz
IGFuIGFycmF5DQo+IG9mDQo+ID4gZm9saW9zIGFuZCBwcm9jZXNzZXMgdGhlbSBpbiBiYXRjaGVz
IG9mIDggcGFnZXMgY29tcHJlc3NlZCBpbiBwYXJhbGxlbCBpbg0KPiBoYXJkd2FyZS4NCj4gPiBU
aGF0IGJlaW5nIHNhaWQsIHdlIGRvIHNlZSBsYXRlbmN5IGltcHJvdmVtZW50cyBldmVuIHdpdGgg
cmVjbGFpbQ0KPiBiYXRjaGluZw0KPiA+IGNvbWJpbmVkIHdpdGggenN3YXAgY29tcHJlc3MgYmF0
Y2hpbmcgd2l0aCB6c3RkL2x6by1ybGUvZXRjLiBJIGhhdmVuJ3QNCj4gZG9uZSBhDQo+ID4gbG90
IG9mIGFuYWx5c2lzIG9mIHRoaXMsIGJ1dCBJIGFtIGd1ZXNzaW5nIGZld2VyIGNhbGxzIGZyb20g
dGhlIHN3YXAgbGF5ZXINCj4gPiAoc3dhcF93cml0ZXBhZ2UoKSkgaW50byB6c3dhcCBjb3VsZCBo
YXZlIHNvbWV0aGluZyB0byBkbyB3aXRoIHRoaXMuIElmIHdlDQo+IGJlbGlldmUNCj4gPiB0aGF0
IGJhdGNoaW5nIGNhbiBiZSB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gZXZlbiBmb3IgdGhlIHNvZnR3
YXJlDQo+IGNvbXByZXNzb3JzLA0KPiA+IEkgY2FuIGdhdGhlciBiYXRjaGluZyBkYXRhIHdpdGgg
enN0ZCBmb3IgdjIuDQo+IA0KPiBUaGFua3MgZm9yIHNoYXJpbmcgdGhlIGRhdGEuIFdoYXQgSSBt
ZWFudCBpcywgSSB0aGluayB3ZSBzaG91bGQgZm9jdXMNCj4gb24gc3VwcG9ydGluZyBsYXJnZSBm
b2xpbyBjb21wcmVzc2lvbiBiYXRjaGluZyBmb3IgdGhpcyBzZXJpZXMsIGFuZA0KPiBvbmx5IHBy
ZXNlbnQgZmlndXJlcyBmb3IgdGhpcyBzdXBwb3J0IHRvIGF2b2lkIGNvbmZ1c2lvbi4NCj4gDQo+
IE9uY2UgdGhpcyBsYW5kcywgd2UgY2FuIGRpc2N1c3Mgc3VwcG9ydCBmb3IgYmF0Y2hpbmcgdGhl
IGNvbXByZXNzaW9uDQo+IG9mIGRpZmZlcmVudCB1bnJlbGF0ZWQgZm9saW9zIHNlcGFyYXRlbHks
IGFzIGl0IHNwYW5zIGFyZWFzIGJleW9uZA0KPiBqdXN0IHpzd2FwIGFuZCB3aWxsIG5lZWQgYnJv
YWRlciBkaXNjdXNzaW9uLg0KDQpBYnNvbHV0ZWx5LCB0aGlzIG1ha2VzIHNlbnNlLCB0aGFua3Mg
WW9zcnkhIEkgd2lsbCBhZGRyZXNzIHRoaXMgaW4gdjIuDQoNClRoYW5rcywNCkthbmNoYW5hDQoN
Cg==

