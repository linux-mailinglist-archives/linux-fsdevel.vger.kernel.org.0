Return-Path: <linux-fsdevel+bounces-23789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FC59330B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 20:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8998B231C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271C1A01A1;
	Tue, 16 Jul 2024 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVPfOtsB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61B1B94F;
	Tue, 16 Jul 2024 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155818; cv=fail; b=SXbbTxwOV4PQJWWCV0q5ABAyDPpLhcVc8vXbdeNRxLFvI8hGTlPy1RZVcAvUJoUJf2CocF4EDVIFN+7+ru7xIpvWQ8LKaJy42W8MG0A5uhMbzK+pp7NBBiwhQV2BLo/BIH6xbrx0nEQ5eSPN9pHstew6mfCQl64La6FgMesvrcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155818; c=relaxed/simple;
	bh=ukRlywhm4de//G1Al8T3Tioc9Rw74+VDhexxrgPDrgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lbQVIQvcN8uHoZV8fTUyfcBQiVd/gH6gGAGVFCHCzsEWXNnj4feRbUf81nS1lLMP7Wq/HH8n/3CMEzdtdJWHn1mg3wmh4Xz7WmSqUt6R46PGti/imibbOwBOH1ZxKk8Jqbtla3qw26pSGmA0zsI1gjRqyh1do9sn0gkGtqUG/1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVPfOtsB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721155817; x=1752691817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ukRlywhm4de//G1Al8T3Tioc9Rw74+VDhexxrgPDrgE=;
  b=OVPfOtsBitSIPeC2QFgFSo5W+nhZEk9NHGJHyNz7r6PSRvHIs6cXO1B8
   N3RlWG2osHG8Mopp24T2fdcgplRCEGJnsFii4cGfvos6X4tCr4S0ci/Aj
   voA6qfN+ikuBqCAMYL+7yK7G7YdsErbFNgcJ0niyGGN7JLFGht5bR65Zf
   JXAaTtAdhvo5lYVHQrYIr3Qe6jmoPP8j7FOPBB+2wetFQtHwZKyLgUtwm
   GBN9173xeDzsrLQPmRY5UDyAoHnzxYGdkxgLqru/Uox2NE/SEw9TqbXx2
   EcecUHHMS85zeU4oN7iH2FcnTYfRE8FtebT7KmzxVsX7VXLGBTYalc9se
   A==;
X-CSE-ConnectionGUID: hHLjiEOuTCet0AfsC3fRlg==
X-CSE-MsgGUID: 6aDPdGTQQBaXGK9M35OO7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18430517"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="18430517"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 11:50:16 -0700
X-CSE-ConnectionGUID: QhpB61ZfSyGOIO1BD9glCg==
X-CSE-MsgGUID: WQ9dY8nLRjKIra8/B7W/rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="49851341"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 11:50:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 11:50:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 11:50:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 11:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXGHbjMiLOwydeqJ3WD/lsGVBxUYj0CMW6vc0cWyiYD1IVmHJnpTHC0i/iqOkgWrTPU+I1aZBL4+cN7tNfCIOVoOLxC8Q8eWK3YciUmr5DTuXoKqNp+q7kzgNykCM0HeREobyZ7jSGtXDqdUpP4IyEBh5dd9AbG1uZMmaLEQHTpzva03PwSXipMZRordg8Yq22OTrpEkHYl8apCESJWN7mxovjFGkU016e2Mvt4E9icTlhuDy8Z+WrWUvcVYe8yFet/FCbUtQ1BA6NccdThkPvGeRKpRyGudSyDay8K6w1RclnUc3dTot3heykDdJqS+lfM1y7DzTD823kLoS7Wyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukRlywhm4de//G1Al8T3Tioc9Rw74+VDhexxrgPDrgE=;
 b=Yfqj97jsMmo722TPhKX3Er0nfrMQ2XoGt+4+FbziyZHgfFezMBvtc3gelSvqTDMzTNCwbhaUKng8tTwkP3XaLqND8h6sCJr00j4pXODIVVqC4j35zUXfozDpzcMUPAgUBj2ZpgrTBub8wMZVSa4DZ+lCwUc179GjKEodTSeajf3zjlQ3IHpReODDWCvtRBKBmklwC7ZKS9v/LUGY2MRst0cNZWy/nfivwlL69SSbD5l/wvITbz5OLcth+R4g0izk0MsK8pg0kxFoI4siuO0M52bKNdKWw7rMb6i1sEL9KVV9IxXF/e7UzPUAsq75PqHbatjczL1kIeFZVAhtxSOjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ2PR11MB7428.namprd11.prod.outlook.com (2603:10b6:a03:4cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 18:50:12 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 18:50:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "fweimer@redhat.com" <fweimer@redhat.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "sroettger@google.com" <sroettger@google.com>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"ross.burton@arm.com" <ross.burton@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"Schimpe, Christina" <christina.schimpe@intel.com>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "kees@kernel.org"
	<kees@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"maz@kernel.org" <maz@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>, "Pandey, Sunil
 K" <sunil.k.pandey@intel.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 05/39] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Thread-Topic: [PATCH v9 05/39] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Thread-Index: AQHaxxDwOzLoaxD3VkqS4FsXYkxulLHv3AWygACDWgCACXR3gA==
Date: Tue, 16 Jul 2024 18:50:12 +0000
Message-ID: <2fb80876e286b4db8f9ef36bcce04bbf02af0de2.camel@intel.com>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
	 <20240625-arm64-gcs-v9-5-0f634469b8f0@kernel.org>
	 <87a5iph6u2.fsf@oldenburg.str.redhat.com>
	 <Zo7SdDT_cBp6uXgT@finisterre.sirena.org.uk>
In-Reply-To: <Zo7SdDT_cBp6uXgT@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ2PR11MB7428:EE_
x-ms-office365-filtering-correlation-id: 426bfd04-def7-423c-c54b-08dca5c81f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z3dqSER4K0c1bWVxRCswd2dEdjlaOEJFRGtUNG04d2xtazBLbytuQTR4SFhj?=
 =?utf-8?B?Y0NLeVRGTy8wZEFNL1hSN1RRN0gzdC96eFgxTHBJTGNPSU52YUgwUHdhMSs4?=
 =?utf-8?B?Y0VJTmI2RXBQdU1Zd2VwdlhZM3p3Z3dyT2pseHFTVFB2QnVBMFEveWZNU1Jz?=
 =?utf-8?B?RkF6cXliLzRoN1NFdnNSVUtwY3pKcUF2SVZscVhZZUFWYlU3U2t1TmZBVjY2?=
 =?utf-8?B?N3N1TlJSUTZDVmRoK0xlUGo2a29VQTI2Q2RySVVsckl3MGhSU0Myc0ZpZ3lX?=
 =?utf-8?B?ejNkbW9NeHZONWVnWUZlR2plSVVMYjU2WG56RS9ESUxxNEJhNlJWdVRZWVZS?=
 =?utf-8?B?M3A4YWtKVDRTcGRhTnFSa0VxZFRGZU40K1J0d3R0QjVvQlVuQnBMa3ZaY0pM?=
 =?utf-8?B?YkdCbnBLU09ZN2gySmFGN3hrUnIvbjFxQnppamNDZkE1ZmFxZGo4MGg2dk81?=
 =?utf-8?B?U1VRRkFnZWN1SjY0VjBCTUJQWjVUMHlLZ0Y1bjZEZndLN3Bzd0RRZWFTN01m?=
 =?utf-8?B?dllKL0syeEpqUWF2aFpLdGlRNU5BYWJHNklENWRKdTl4bUVvZEszQzA0SEl5?=
 =?utf-8?B?cXNURkxlamI4Z3lBRjFxSjhWeHdiQzl3Z2g3S0dHR01Fa2VZVHZwWFd4VHFa?=
 =?utf-8?B?N3JsWkVtaXVOZWJtcDZCUHZSMW1BTkhVaUZEcko1TWhRTjVKOTB0SjUwSjdC?=
 =?utf-8?B?d1BybGExcFJmWjhySWtpTkhyMWZrWWEra3JEbzBmNTJ2RUNXcndkMk94cmQy?=
 =?utf-8?B?SnNlaU5sV3hoSlZ4K2NXeVpUQm9KLzVZOTE5Tm1pdGxtcVBHQjFvV2NGTHMy?=
 =?utf-8?B?YmRmQzBnL1BJNTBkT3UzUWZ5dHBJckNNeWMwY2Vxakx5ZE91Y3lJc0ZLNSs1?=
 =?utf-8?B?RjZkQ0RUYWRuc2JEaHZCKzVDR3d0SExUbWRPalV2MEFCTHZNRjNIeE1DVWx6?=
 =?utf-8?B?Q1UzWTM4MDV5emNYcE1LZzJkcktDbDJqSkVlbVMxOWxVNllhZC8yK1R1eTN4?=
 =?utf-8?B?bFhUb29RNWZjOXFLRlpRcUQwdlpwYzYxVTJBOERKNmZwUFZEeGhDL1NuRzdE?=
 =?utf-8?B?dzJxVTNMTnphbTNEdk1zcmJqbEtFM3I5cEFaSCtTNzNNZmozajQ5TW1ibU1C?=
 =?utf-8?B?THppeGpIbVgyMndrd0hLY2ZEU3hsUUJ2TDZTKyt0cUloY0xUakVmb3VZSzJ4?=
 =?utf-8?B?bTl6ODR3dDBtM1hKMTFnT3hwSlEvVG9xMytHWExxZ28wV29uZjNySXkwbllQ?=
 =?utf-8?B?bWhuVEFRNHllbVNwc0tuTG1JL20reUJqM1pvZWloU2dGT2FLTGlVaVUwaU5N?=
 =?utf-8?B?dnBOYnQ3N2JrM0grUTMrbytlL3lnRHlxblYxUlNSRnlMOTVMRVF0MlpXS20r?=
 =?utf-8?B?NmlqdTJDcEZxY1pHa2JyRXF4bG1vbFZlU3RxWUg1NmVOSWsxYjdwSmFhdXcw?=
 =?utf-8?B?NThjQVFudU1TRTd4OWl3WDJPb2NwWXZYN2dycnM0NmlLaVRlbE5GMGhkK3VN?=
 =?utf-8?B?bTExOEpFOWtZK3pIVjN3dDAraVdRNG4rT0FsdE81YXlnQ1lMRDNHV1NkcDJa?=
 =?utf-8?B?cGs1bzRzdnRkRmozdngyckZDYVlFUTJ4dTc0OWdGbU5XaVFOMEVzQVJmRW1x?=
 =?utf-8?B?aUVRNW1jR2toWlV5MjlqYnlxREFPWWdEMjdYSC9rTnR5LzVLVmFwUEZIY29Y?=
 =?utf-8?B?QlFvZFpDUldJYnZWMkZMYlhFb0tnZXJWTDVWRktRKzdzZDNkQ21PVnZoam1n?=
 =?utf-8?B?OGxScXZ3TWg1ckY3c253amZnVStNMDdYclFDdHJSRXNJTGFBam0rei9VOFMw?=
 =?utf-8?Q?LC/GxPBr3iEWaY8yMUVaEkkW0C+Kgj9Qj5D3c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0NBSHI5T2hZbnp3U3BKcjQ5bU1SR3dtU2dHTGNkV2JJSXdmL0x6QWU3bVo1?=
 =?utf-8?B?ZVN4Mm1WeDl5dmlZSXZxamVvdnFaOGN5RVM0UXZUa0h1a05sZG5YeG9FZFZ0?=
 =?utf-8?B?NDdtUDFHK0xjaFZhYVVjTmNLSktEeFpTTkVXcXlkQ3Uzek5NNHdoNDZHSVNt?=
 =?utf-8?B?UkdHL3BoSGozRFgvb2JxZ1l5ZTcrTVNrNS91ZzlXd2hid0R2NGlldWJmMlc1?=
 =?utf-8?B?QnJSRUtpb1pMRFpFWFZhYVdma1RPZTdwV0Uza2tjUnNUM3ZIc2NGY2pTR2dT?=
 =?utf-8?B?ZmJiSGRiMGx1SEdVVlU5NVNRc1JVTkJtZDNsK3QxVk9Delg4aFhXL0MxMCt0?=
 =?utf-8?B?TFlOeVBaQ3FGQXJsN2owZ0ErbWlSeUwzdUFUUHVvM0xkWkFiNlllcTZhKzAw?=
 =?utf-8?B?UW5DQU5PRTE5clhUTXhMUCtLMGNyTmZOdU1SQWd4RWVlLzFObDd3TjZRMzg5?=
 =?utf-8?B?SE1sZWkxOTFLS3JURUl2YXNVUnRoMjc3NkZsWklDS3BoM0NwRXIvUlFpUHEz?=
 =?utf-8?B?R1Z3eUJva04yTnZwUVgrU0cwYTRpYmhtUXJaUkpQM052cG45Qnd4Ly90bE4w?=
 =?utf-8?B?Wk1WRVhpRlhqdmlndmo1NlpSTjdQTEgvNVd4UlJ1UVZyaWVjdnFxTVNrZW90?=
 =?utf-8?B?TFVOdXVvWDFUYTc3RUdWS3ZjV1BtUG5SY3BFek91SFVuQnNXcUs2RUUzNnpI?=
 =?utf-8?B?VGo5Wm9SciswK2QwY1hVSzBjemlvaTBuQVVnQlFSRndDSTF0dksrcktPZWhv?=
 =?utf-8?B?TkpVczEyS1hLeFdxZzBFbkl6K00zSWhqNnlSTlAzalUrd0NTMkFRTDJoTjc3?=
 =?utf-8?B?TmNqQ1lBWXorV2I2cUFxMFdwWFhaejQyKzdjVnhjSUJseFdqWG1MSE12RDRv?=
 =?utf-8?B?ZEJpOXRUR3ZLWjVCU3lncGxvR29NcGtWRVMvd1BNYWxQRFc1akhkK25mMFBI?=
 =?utf-8?B?N3dFaEFxTEVlanVjMkdYOXhLK0srU3FtWUdya0pUQWMvSGE4OWVhVDhlT0gx?=
 =?utf-8?B?NXNNdzFvQklmY09Iei96ZTBJRXlHakxROHo1eUdDMTZCT1ROamI2THRqZWNZ?=
 =?utf-8?B?ZVZuMm5VL1dPTEozUTIwOWlTYWNrbWMrenEvTmlPaU5MdjhMMHEvb2RQNVBM?=
 =?utf-8?B?NmdnbytZSmxGaVdGOEVGMlNvdk9nRXI2Vy83QXJ0elBNY0YwT2xIYXBZdXVC?=
 =?utf-8?B?ajZyMnl2eURTMGErbkd4QUFnamJXRStwRGJoSC92cmx0Yis5Y3lKRlNXaHJR?=
 =?utf-8?B?Rk1nZ1gzTzdEbHNHNlppWStmSXFUQmhDWjluNkpNSzVTQjhsQjNWS213OGd0?=
 =?utf-8?B?dkM1TFhiZ3JJL1J0cnNZc3RtVFprb0ZnYmY0bnBUTGhJL2lhK2pTSXJ0cE5V?=
 =?utf-8?B?NmNpcXFodU9MeWxTOTE0c1p2dXhXWkFWRmFTM3NlZU15bTZid0luWmxDckZE?=
 =?utf-8?B?MUpRdTVuVm91N204TGVYTVNGYjFEeGpYWEFmcHpRSCtaelhwM0JRT2EzVFcx?=
 =?utf-8?B?TlJibmg2R3piTnRhZlJxQjY3RkdRNmZENzk2MDF0NDNXNFM1RE9ZZWdKZ2lC?=
 =?utf-8?B?eXZRMDNOU29YWlRQdWZ2VTY1bmZ1ZUVVeXM1RHMxM2R3MjZxdURpbDdSbVBL?=
 =?utf-8?B?MVcrWDBkQWUwT0RrZHJNY3MrRStFNkRUcXdIZ3BlZmRJQVdVOVVWcGw0QVdF?=
 =?utf-8?B?K2Z5UmwzcUc2Sytocit2RU9rMWxvMEMzdS9weHQ4Sk1LVkpSNnFBaXN3Wm5K?=
 =?utf-8?B?OXF3Yk1CYmZQRWgxWDNrdi9Bb3ZJSHZYdk1rSlBEYjlRcHh4bElkRG1QblF0?=
 =?utf-8?B?OFhvZDVXVU1Jc3JiWUZJZmJ3SWdGWFVqTFlQakg5NVRva216T3BpejlIejc0?=
 =?utf-8?B?cGMzTDRDRkFGQXhCZEhXSGQ1VFdYWUNEdHdOazRqTWpoS3gyTEU0T1d3VUd6?=
 =?utf-8?B?NVpuTEY0OWFiSC9ZclRKZHBwNnd3cTBKN1JBR29GTU1NNFRnU2xMMU9uYnMx?=
 =?utf-8?B?VklHVlU5a3U1UFIvRnVLNkdzS3FLZnJMVHIxZDhGeWs2QjArOFZ6L3E2bnV1?=
 =?utf-8?B?Nk56ZHJNYm5tWDM4YnN5SUU3TWgyc212UVBMVlhwR0JYWmc5a1dMNit6Y2Fj?=
 =?utf-8?B?L0t5NUdJMWxhemVreXBVaTBBUVZaQWN4LytRTzc0bkxTMWhNZ2pCcFdjZ3Bm?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF534A61ACB4C947A05EAAAA9A2D7304@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426bfd04-def7-423c-c54b-08dca5c81f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 18:50:12.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SS8hqLx3uUx7KYmjsv3/IXQJszqS1mDGQoG3KCYy/bRdtgJ35zokMWgIEsPWaqJ4NdjREvTeRdGE3ihEyR0177PevH+w2yxDxJtzgcb8D0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
X-OriginatorOrg: intel.com

K1N0ZXBoZW4sIHdobyBoYWQgYmVlbiBhc2tpbmcgYWJvdXQgUklQIGludGVncml0eSBhd2hpbGUg
YmFjay4NCg0KVGhyZWFkIGNvbnRleHQgZm9yIFN0ZXBoZW46DQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sL1pvN1NkRFRfY0JwNnVYZ1RAZmluaXN0ZXJyZS5zaXJlbmEub3JnLnVrLyN0DQoN
Ck9uIFdlZCwgMjAyNC0wNy0xMCBhdCAxOToyNyArMDEwMCwgTWFyayBCcm93biB3cm90ZToNCj4g
T24gV2VkLCBKdWwgMTAsIDIwMjQgYXQgMTI6MzY6MjFQTSArMDIwMCwgRmxvcmlhbiBXZWltZXIg
d3JvdGU6DQo+ID4gKiBNYXJrIEJyb3duOg0KPiANCj4gPiA+ICsqIFdoZW4gR0NTIGlzIGVuYWJs
ZWQgZm9yIHRoZSBpbnRlcnJ1cHRlZCB0aHJlYWQgYSBzaWduYWwgaGFuZGxpbmcNCj4gPiA+IHNw
ZWNpZmljDQo+ID4gPiArwqAgR0NTIGNhcCB0b2tlbiB3aWxsIGJlIHdyaXR0ZW4gdG8gdGhlIEdD
UywgdGhpcyBpcyBhbiBhcmNoaXRlY3R1cmFsIEdDUw0KPiA+ID4gY2FwDQo+ID4gPiArwqAgdG9r
ZW4gd2l0aCBiaXQgNjMgc2V0IGFuZCB0aGUgdG9rZW4gdHlwZSAoYml0cyAwLi4xMSkgYWxsIGNs
ZWFyLsKgIFRoZQ0KPiA+ID4gK8KgIEdDU1BSX0VMMCByZXBvcnRlZCBpbiB0aGUgc2lnbmFsIGZy
YW1lIHdpbGwgcG9pbnQgdG8gdGhpcyBjYXAgdG9rZW4uDQo+IA0KPiA+IEhvdyBkb2VzIHRoaXMg
bWFya2VyIGludGVyZmVyZSB3aXRoIFRvcCBCeXRlIElnbm9yZSAoVEJJOyBJIGhvcGUgSSBnb3QN
Cj4gPiB0aGUgbmFtZSByaWdodCk/wqAgVGhlIHNwZWNpZmljYXRpb24gY3VycmVudGx5IGRvZXMg
bm90IHNheSB0aGF0IG9ubHkNCj4gPiBhZGRyZXNzZXMgcHVzaGVkIHRvIHRoZSBzaGFkb3cgc3Rh
Y2sgd2l0aCB0aGUgdG9wIGJ5dGUgY2xlYXJlZCwgd2hpY2gNCj4gPiBwb3RlbnRpYWxseSBtYWtl
cyB0aGUgbWFya3VwIGFtYmlndW91cy7CoCBPbiB4ODYtNjQsIHRoZSBzYW1lIGlzc3VlIG1heQ0K
PiANCj4gSW5kZWVkLi4uwqAgR2l2ZW4gdGhhdCB3ZSB1c2UgdGhlIGFkZHJlc3Mgb24gdGhlIEdD
UyBhcyBwYXJ0IG9mIHRoZSB0b2tlbg0KPiBvbiBmaXJzdCBwYXNzIEkgdGhpbmsgd2UgY291bGQg
Z2V0IGF3YXkgd2l0aCBqdXN0IHVzaW5nIHRoZSBhZGRyZXNzIGFuZA0KPiBub3Qgc2V0dGluZyB0
aGUgdG9wIGJpdCwgd2UnZCBoYXZlIGFuIGludmFsaWQgY2FwIHBvaW50aW5nIGludG8gYSBHQ1MN
Cj4gcGFnZSB3aGljaCBzaG91bGRuJ3Qgb3RoZXJ3aXNlIGJlIG9uIHRoZSBHQ1MuwqAgSSdsbCBn
aXZlIHRoYXQgc29tZSBtb3JlDQo+IHRob3VnaHQuDQo+IA0KPiA+IGV4aXN0IHdpdGggTEFNLsKg
IEkgaGF2ZSBub3QgdGVzdGVkIHlldCB3aGF0IGhhcHBlbnMgdGhlcmUuwqAgT24gQUFyY2g2NA0K
PiA+IGFuZCBSSVNDLVYsIGl0IG1heSBiZSBtb3JlIG5hdHVyYWwgdG8gdXNlIHRoZSBMU0IgaW5z
dGVhZCBvZiB0aGUgTFNCIGZvcg0KPiA+IHRoZSBtYXJrIGJpdCBiZWNhdXNlIG9mIGl0cyBpbnN0
cnVjdGlvbiBhbGlnbm1lbnQuDQo+IA0KPiBUaGUgTFNCIGlzIGFscmVhZHkgdGFrZW4gYnkgdGhl
IGFyY2hpdGVjdHVyZSBvbiBhYXJjaDY0LCB0aGUgYm90dG9tIGJpdHMNCj4gb2YgdGhlIHZhbHVl
IGFyZSB1c2VkIGZvciB0aGUgdG9rZW4gdHlwZSBmaWVsZCB3aXRoIG5vIHZhbHVlcy9iaXRzDQo+
IHJlc2VydmVkIGZvciBzb2Z0d2FyZSB1c2UuDQo+IA0KPiA+IFdlIGFsc28gaGF2ZSBhIGdhcCBv
biB4ODYtNjQgZm9yIGJhY2t0cmFjZSBnZW5lcmF0aW9uIGJlY2F1c2UgdGhlDQo+ID4gaW50ZXJy
dXB0ZWQgaW5zdHJ1Y3Rpb24gYWRkcmVzcyBkb2VzIG5vdCBlbmQgdXAgb24gdGhlIHNoYWRvdyBz
dGFjay4NCj4gPiBUaGlzIGFkZHJlc3MgaXMgcG90ZW50aWFsbHkgcXVpdGUgaW50ZXJlc3Rpbmcg
Zm9yIGJhY2t0cmFjZSBnZW5lcmF0aW9uLg0KPiA+IEkgYXNzdW1lIGl0J3MgY3VycmVudGx5IG1p
c3NpbmcgYmVjYXVzZSB0aGUga2VybmVsIGRvZXMgbm90IHJlc3VtZQ0KPiA+IGV4ZWN1dGlvbiB1
c2luZyBhIHJlZ3VsYXIgcmV0dXJuIGluc3RydWN0aW9uLsKgIEl0IHdvdWxkIGJlIHJlYWxseSB1
c2VmdWwNCj4gPiBpZiBpdCBjb3VsZCBiZSBwdXNoZWQgdG8gdGhlIHNoYWRvdyBzdGFjaywgb3Ig
cmVjb3ZlcmFibGUgZnJvbSB0aGUNCj4gPiBzaGFkb3cgc3RhY2sgaW4gc29tZSBvdGhlciB3YXkg
KGUuZy4sIHRoZSBhZGRyZXNzIG9mIHRoZSBzaWduYWwgY29udGV4dA0KPiA+IGNvdWxkIGJlIHB1
c2hlZCBpbnN0ZWFkKS7CoCBUaGF0IHdvdWxkIG5lZWQgc29tZSBmb3JtIG9mIG1hcmtlciBhcyB3
ZWxsLg0KPiANCj4gUmlnaHQsIHdlJ2QgaGF2ZSB0byBtYW51YWxseSBjb25zdW1lIGFueSBleHRy
YSBhZGRyZXNzIHdlIHB1dCBvbiB0aGUNCj4gR0NTLsKgIEknbSBub3Qgc2VlaW5nIGFueSBnYWdl
dGlzYXRpb24gaXNzdWVzIHdpdGggd3JpdGluZyBhbiBleHRyYSB2YWx1ZQ0KPiB0aGVyZSB0aGF0
IGlzbid0IGEgdmFsaWQgc3RhY2sgY2FwIGF0IHRoZSBtaW51dGUgYnV0IEknbGwgbmVlZCB0byB0
aGluaw0KPiBpdCB0aHJvdWdoIHByb3Blcmx5IC0gZG9uJ3Qga25vdyBpZiBhbnlvbmUgZWxzZSBo
YXMgdGhvdWdodHMgaGVyZT8NCg0KU2hhZG93IHN0YWNrIGhhcyBvbmUgbWFpbiB1c2FnZSAoc2Vj
dXJpdHkpIGFuZCBhbm90aGVyIGxlc3MgcHJvdmVuLCBidXQNCmludGVyZXN0aW5nIHVzYWdlIGZv
ciBiYWNrdHJhY2luZy7CoEknbSB3YXJ5IG9mIGFkZGluZyB0aGluZ3MgdG8gdGhlIHNoYWRvdyBz
dGFjaw0KYXMgdGhleSBjb21lIHVwIGluIGFuIGFkLWhvYyBmYXNoaW9uLCBlc3BlY2lhbGx5IGZv
ciB0aGUgZnV6emllciB1c2FnZS7CoERvIHlvdQ0KaGF2ZSBhIGhhbmRsZSBvbiBldmVyeXRoaW5n
IHRoZSB0cmFjaW5nIHVzYWdlIHdvdWxkIG5lZWQ/DQoNCkJ1dCBiZXNpZGVzIHRoYXQgSSd2ZSB3
b25kZXJlZCBpZiB0aGVyZSBjb3VsZCBiZSBhIHNlY3VyaXR5IGJlbmVmaXQgdG8gYWRkaW5nDQpz
b21lIGZpZWxkcyBvZiB0aGUgc2lnZnJhbWUgKFJJUCBiZWluZyB0aGUgcHJpbWUgb25lKSB0byB0
aGUgc2hhZG93IHN0YWNrLCBvciBhDQpjcnlwdG9ncmFwaGljIGhhc2ggb2YgdGhlIHNpZ2ZyYW1l
Lg0KDQoNCg==

