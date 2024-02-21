Return-Path: <linux-fsdevel+bounces-12312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B885E734
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5A3B27436
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0DB86136;
	Wed, 21 Feb 2024 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikyNryHS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898F85C68;
	Wed, 21 Feb 2024 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543454; cv=fail; b=bl1Egitt4HETj/seQLM2DzG8dW9YMSP/0ZpPpjIMS2qpSr9ulLF4XEznRZiKSdMV4rWJVOOKPHBPhH9Ea6WnYn7qeOc41fGrpF2VrOUP5LgsI8au4tAKqkngNiUjsRZZvKbSxjtjO3wnGKl7vvgk9nrgM6vNmuP+OqjwQSkZN4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543454; c=relaxed/simple;
	bh=zcCPT7AHSGRei7HNsiUe5F7y+lEXjyUmqtMeTNfcCFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jrdTA38k78t68OOh3blqcX3GOmLkSc9dgo7DUw5OVd5zDbJqobPfbp8gJu3ixWYQeK6dFMCJzIuQz75LEXQaYJrNhGwsNseOikRvqMQIgGz0HYzxByjdeSma88Wd+sW/JVXcYqOGXH4RpT6tt9u1I2gP9Hqbw+9TYivPf+iRmMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikyNryHS; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708543452; x=1740079452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zcCPT7AHSGRei7HNsiUe5F7y+lEXjyUmqtMeTNfcCFQ=;
  b=ikyNryHSuUEsdt3pFOUfyYMTQkMpy0QXyl6TRwY6t4UPh+sisDcsMCNi
   8qg5by8pQQ0QUSL433KSWn2SZZBHxbZTpPJkpYKDplhGhXLvgG95YxxRK
   evQfCgJ8l/+TL1drtetiNNMWkjWcZSEjr41yiwEaEEGWYQpuTCHw2hOL7
   rnsfq5wpfehuvbbFFK1hQ0KiwlSAyAbRJpW3/OlaJHgnQtenGYaPOkbs6
   ONRRrJ7XgGhh1H8gqg7U/O8biICUZn8eRdcK+DxZEQKcq2A74hMG72xSG
   NfGqPf9ofKPKonhqMlrIvF6vyE6TYy9wZP9npl/NpTd7kukQxTVa//Y9a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20272078"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="20272078"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 11:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="9816182"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 11:22:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 11:22:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 11:22:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 11:22:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ0LuyKiRVsIomzWUC8kFovPWO0YbTobEJsKFMAdaQcolAUndQKRixhq7WUItfpnXTXuybefmDn4CC9DMapap8y1XnF00PVHHVQiOCv73Z1lA6Ti09XL6swXEtA9f/6rWKFKQaGSpMBJl2BGVDw1RLAscLaiUvch8iL+u/0p5mW09nVuS34DLn9H17MnykMXEvv3hvqo40dVOfvmeINfSmao+ikCRRT/+MU9pLGPgEmYcIoisxDQ/7lH/706dg4FyKLRcmpzONLhFi7SZkKc3mrVX7lwA4vXKD7m9+HyXxUC3eGYasvPXSLbwV9yQ3908TIA+MbLybm5THV0TJaCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcCPT7AHSGRei7HNsiUe5F7y+lEXjyUmqtMeTNfcCFQ=;
 b=ckIcSoYMBABQadoeO9+8s2WOjPcM4JWSR/fuh+K/rv4Ros0yO3abyYMiKiPA7unCBiXYKipV0Gl8yvtTXxLg3N0KbHLkbtmm7+XteaZnO1OGc3iG2opSE8yEtgrR7zEO3NcV/ajfg2L2BgR913qwtuOf4DlOGUAAOK+HmPocCM2az9JHPFTZoLI+smzPpoffTeidpssRqWGN9c5Gk2f1ii1Cl6lK8AVc0gW8BX82j9DfdTaMdDNDDxdj/CM9n2vXJm7qDJxZHx6eYyo7u6tsAEpZpztBS2T/s4CQjQu4WHGPmG6jQwd7tTtMvxS3eUS58+DgGTW0qt742sdnFXizTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 19:22:21 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 19:22:21 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dalias@libc.org" <dalias@libc.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "shuah@kernel.org"
	<shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org"
	<maz@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>, "fweimer@redhat.com"
	<fweimer@redhat.com>, "keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "will@kernel.org" <will@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "thiago.bauermann@linaro.org"
	<thiago.bauermann@linaro.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "sorear@fastmail.com" <sorear@fastmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in
 userspace
Thread-Topic: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Thread-Index: AQHaVpxQxL7eT1mQek6VcjPJOSVEZ7ETiLSAgAAiyYCAAASHgIAATE8AgAAGrQCAAAuagIAADnuAgADQTgCAABIegIAALDIAgAAF54CAAAQ9gIAABSaAgAAGX4CAAAOdgIAABGIA
Date: Wed, 21 Feb 2024 19:22:21 +0000
Message-ID: <e3a432c0fa9f5fe837e9d2fc7b36304709a34428.camel@intel.com>
References: <20240220235415.GP4163@brightrain.aerifal.cx>
	 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
	 <20240221012736.GQ4163@brightrain.aerifal.cx>
	 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
	 <20240221145800.GR4163@brightrain.aerifal.cx>
	 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
	 <20240221175717.GS4163@brightrain.aerifal.cx>
	 <f4a54297767eb098d903404cbe8860d655d79bed.camel@intel.com>
	 <20240221183055.GT4163@brightrain.aerifal.cx>
	 <c3085fbe10193dfe59b25bc7da776e60779b0e8c.camel@intel.com>
	 <20240221190639.GU4163@brightrain.aerifal.cx>
In-Reply-To: <20240221190639.GU4163@brightrain.aerifal.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB4865:EE_
x-ms-office365-filtering-correlation-id: 3bacb91a-3e7d-4d7e-4bad-08dc33126d57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lA1DGPK2VrKkREIodDb1OumuUukP/gvkYW69XCCKAnPIb6B6yCPyDGeE8y60EDwjp0ffJGgk0RMlpxC3IYBnBPf+jeYwUmBw4tC/r0PZJI0wOtk1TS31ojn49R4BcbYloMEZTM3kMeZQN/fEfGmEm9gjZhOKT0giy1rcdEEejfJGvp2ckrp2nFJ1aWQbu0kZ3eBRf8bMn9ls/hP5LbOcAgpte7qA1Tm+RZ+XRd00SHgOuuC6PlTWNo8/sDo3Yjh309xquB7I1mvTIVTj8auuTHOH4qgGdYZvFEAGCOzBrCjxlqZDW3AvDCsemiN99q8bCyVpHJhT7r5ZwtuhelArcWZmOw2kN9d1v7zCJN0sAWg58k2jiS/ufn9c9VgKcQpEablnFc8Cjv6gOumchwQ2G0TmD07FwnJtmA/PxqBuKy92JCUwUkTPNtjfCanhTwghUhtU361vPLSKRrJedOGc3tojJ0VOef5pB11Ob88o1n7wxjKfeUjFjJycGCerjpJRQxsuFmkaV6GrnE9aN256D7Eh+j7Ds2GBL4op5xQcKNkxQzd0e+RR4zlXoofEuyuOWablCFdqXQjtf8jCYngKLAm6NQFdX0Gk/GfGhJOqzG1Uliu8X9k8Fgs36aIIdfHf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230473577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHBEMnFmRW9Tdk1la2hhUUluS2EvQm55bTMrUGRLbHVhelZDVWRya1J4K0V3?=
 =?utf-8?B?SmVibTBmNHdaNzdTa01BNlFxQURGR3pqeGpKODB5OE9Kbmk5L2FYd3hWZE50?=
 =?utf-8?B?dkM3eHpIckk0MHJ5YUU1c29kMWViR2JtcFN3S2w5TUdTRWdmeDZnaUZ0eGJM?=
 =?utf-8?B?emFJM2pudTFqaDl5SmduYnZ2dnBmbHdpeTZ4NGpGeDlwRmZvUlRiYStrM3pG?=
 =?utf-8?B?YU1ZRXdnMEwyN21tcHZSTVZZVUwwMWNHZnBoMXRvUXQ0MDNXR00yeHA3VU9F?=
 =?utf-8?B?Z1h2YkVaemMydUJLT2dLUTk2S1FWb3RoNXo5ZFY1dVY4U3h0MzZzVmVtRGxW?=
 =?utf-8?B?N1lzK0NTZlJuZEpRQ2JiM3lCUFJjUHZVUWlidk5QTnFLeksweEo3WklzWTVh?=
 =?utf-8?B?blJBWVV4SDFGZlUwcmdSVFBuNTlTRG42SUEyS21oaGdjMS9hUXlEWTdMYnh6?=
 =?utf-8?B?SnhYNHF4VktMSlB1dkR2SmF5SGhxcmZZRHZaSEtWVks2ODUwZkdaWXRNTzdO?=
 =?utf-8?B?NkxZRnlsVnI0WDZoeUdHdnFaL1UwcU8vOVZucWFia3hqTGo0SEFGTUxyZ1pK?=
 =?utf-8?B?a0NPaWNhT3J2YWluSzU3VUxoenhSY3pldnFpYXVJektKaVIvQUxGUW9Zc09D?=
 =?utf-8?B?VGZZZmJSdnpXa2ZoaFQwZDdCWnhFaUZwRHVNQzVOUENpWnhSdUFoWGZPZE54?=
 =?utf-8?B?Q3UvWlpmQWxqYlREbGRZK1ZveFpYR0JSelJsOXhOeUZFcDc4Y0c2ZHZJbEdK?=
 =?utf-8?B?VkJNR3BRb1MyaEhhSDhodzJkVk56UHFZcGlNKzV3S1FhSEM1b2w2S3pMejF6?=
 =?utf-8?B?QnUrUEpNNzFoS2Uxdm9URVp3YWJlbllOS3MyVEVOVE5QZ1RVaHZCdHNkMUN5?=
 =?utf-8?B?WnFMbG05WTJrT01BcWlNL2dDV0Q0V0FYOUVSR3FuLzJlb3FEVkx4Z3JUSy90?=
 =?utf-8?B?R1lYc25TQ0t4aUN0L1Npa1pwUVpyRHNmTmlnVkEreUJVVWVhcGNpUWVFVVJs?=
 =?utf-8?B?V1BYWmprN2htZUlWZW11Z1N1RmZ0R2xMQUpGdWhYcmk4cG9CUDkxbUZIUVpl?=
 =?utf-8?B?enQ2dXFqbmdLdmNFdlZCUy96YXA2Yk1iSHZIN2RWMmd6SVFaazVVVXNCOWZl?=
 =?utf-8?B?ZFRJaCtHcVl2ZGp5UkNtMmVHOGZGUUx0aHlFeUNqY2dGU2ViODdtRUd0ZTgw?=
 =?utf-8?B?MHdEMGVzbDE1aHBDcEgzWU1wSTJ4TXM5MWpuQzBnQUpEbFhvQ284ZlZvMitw?=
 =?utf-8?B?YkRoR1BRNGd5dkhWWGIzWk1mQzQvOWNXMTh0RUx1OXd5NFFPSVNnZ29nL0s0?=
 =?utf-8?B?eGFtUStadzRVbGpFUzV0QjhXTG5TZTRKMmVkc1RVa0dUekMyenVNaElFM2N3?=
 =?utf-8?B?TW1Oc1VXRitiR3RZZFhFeUpEbVZ3aFk3VE9obWFyMFFHenlSeDY5ZC9SKzJp?=
 =?utf-8?B?ckN2WThIVm9CTitHRi9mRE5CbGhJSlNXeFpJMDlVNVVvQXlJQno3Wjcrdlpl?=
 =?utf-8?B?MytCWEszNVc4VEJMMDBjUklWOE5hcDY3NEhxV3VNc3FJSjNOSXpYZzhoVmVJ?=
 =?utf-8?B?ZTBvcUJZR0pnbzFjc0l0TWVkMFFOQVN0d1FCRmtWWkJJUHVZa3I2UmJRSHNN?=
 =?utf-8?B?NGV0STlERGtUMjc2dzR1L1M0Um85bnJROVVYckJiNnU3RXRqQXRvN2thdUlC?=
 =?utf-8?B?V1RGaUJpQWEwM1YrdDIwZVVUaythYTBCV09IYzBmeVMvUE9HSkZrNk9qRklE?=
 =?utf-8?B?b2t6RFNpLzRXeS9HYUtHZitCeC9IeXpKNy95akNaK3RKS3pibGRwRkRSN2ZJ?=
 =?utf-8?B?d09DcUlHQVBQVWZGVUZpTnRLcHpCNTJkVEFDckFQQ2I5Rm95VkRrSVRyUTI2?=
 =?utf-8?B?c3I0RlhjbUVMa3lyM3lHUFRqSFY5R3p6Qjl0c2VPZ2xLKytJcWh1OVo1WWUz?=
 =?utf-8?B?MkpOT0o4bnM0ZytIWEZKSGV2bVlsWDNyTUI1bGduNWRmVkJBNUVzdUt3T0xo?=
 =?utf-8?B?Nk9ORGQ3UnA2Y01sa3dGeTlWUHorV3VsWkI0WTkwVzBpQ0lRU1Budlg0TERh?=
 =?utf-8?B?WTZ2TlYxcGpNcFYyZ2RMWlVnY3JDL1JFVjlUUDBKaVluaEJENFRTc2NwQ2V0?=
 =?utf-8?B?Tm1nQlcrbXo5YUsyS0p0ZXE1YW14MUhVMjdkcFVzNUUvZERWYm5DODJMelZa?=
 =?utf-8?Q?Xt8KuF4NfegkRcukoWb20HA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4275E97108F917409F49BAA85992435A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bacb91a-3e7d-4d7e-4bad-08dc33126d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 19:22:21.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8GCGNJh4YNueAWcT29XOHiiFIf0A+7NxpsO+z/QQPpGy+CliOKfumLxtAWpSJIOibGGdM1jQTCAzy2E92JwD6TgqNp7b70B3AmBnZZiPdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4865
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDE0OjA2IC0wNTAwLCBkYWxpYXNAbGliYy5vcmcgd3JvdGU6
DQo+IER1ZSB0byBhcmJpdHJhcmlseSBuZXN0YWJsZSBzaWduYWwgZnJhbWVzLCBubywgdGhpcyBk
b2VzIG5vdCBzdWZmaWNlLg0KPiBBbiBpbnRlcnJ1cHRlZCBvcGVyYXRpb24gdXNpbmcgdGhlIGxv
Y2sgY291bGQgYmUgYXJiaXRyYXJpbHkgZGVsYXllZCwNCj4gZXZlbiBuZXZlciBleGVjdXRlIGFn
YWluLCBtYWtpbmcgYW55IGNhbGwgdG8gZGxvcGVuIGRlYWRsb2NrLg0KDQpEb2ghIFllcCwgaXQg
aXMgbm90IHJvYnVzdCB0byB0aGlzLiBUaGUgb25seSB0aGluZyB0aGF0IGNvdWxkIGJlIGRvbmUN
CndvdWxkIGJlIGEgdGltZW91dCBpbiBkbG9wZW4oKS4gV2hpY2ggd291bGQgbWFrZSB0aGUgd2hv
bGUgdGhpbmcganVzdA0KYmV0dGVyIHRoYW4gbm90aGluZy4NCg0KPiANCj4gPiANCj4gDQo+IEl0
J3MgZmluZSB0byB0dXJuIFJEU1NQIGludG8gYW4gYWN0dWFsIGVtdWxhdGVkIHJlYWQgb2YgdGhl
IFNTUCwgb3INCj4gYXQNCj4gbGVhc3QgYW4gZW11bGF0ZWQgbG9hZCBvZiB6ZXJvIHNvIHRoYXQg
dW5pbml0aWFsaXplZCBkYXRhIGlzIG5vdCBsZWZ0DQo+IGluIHRoZSB0YXJnZXQgcmVnaXN0ZXIu
DQoNCldlIGNhbid0IGludGVyY2VwdCBSRFNTUCwgYnV0IGl0IGJlY29tZXMgYSBOT1AgYnkgZGVm
YXVsdC4gKGRpc2NsYWltZXINCng4Ni1vbmx5IGtub3dsZWRnZSkuDQoNCj4gIElmIGRvaW5nIHRo
ZSBsYXR0ZXIsIGNvZGUgd29ya2luZyB3aXRoIHRoZQ0KPiBzaGFkb3cgc3RhY2sganVzdCBuZWVk
cyB0byBiZSBwcmVwYXJlZCBmb3IgdGhlIHBvc3NpYmlsaXR5IHRoYXQgaXQNCj4gY291bGQgYmUg
YXN5bmMtZGlzYWJsZWQsIGFuZCBjaGVjayB0aGUgcmV0dXJuIHZhbHVlLg0KPiANCj4gSSBoYXZl
IG5vdCBsb29rZWQgYXQgYWxsIHRoZSBpbnN0cnVjdGlvbnMgdGhhdCBiZWNvbWUgI1VEIGJ1dCBJ
DQo+IHN1c3BlY3QgdGhleSBhbGwgaGF2ZSByZWFzb25hYmxlIHRyaXZpYWwgd2F5cyB0byBpbXBs
ZW1lbnQgYQ0KPiAiZGlzYWJsZWQiIHZlcnNpb24gb2YgdGhlbSB0aGF0IHVzZXJzcGFjZSBjYW4g
YWN0IHVwb24gcmVhc29uYWJseS4NCg0KVGhpcyB3b3VsZCBoYXZlIHRvIGJlIHRob3VnaHQgdGhy
b3VnaCBmdW5jdGlvbmFsbHkgYW5kIHBlcmZvcm1hbmNlDQp3aXNlLiBJJ20gbm90IG9wcG9zZWQg
aWYgY2FuIGNvbWUgdXAgd2l0aCBhIGZ1bGx5IGZsZXNoZWQgb3V0IHBsYW4uIEhvdw0Kc2VyaW91
cyBhcmUgeW91IGluIHB1cnN1aW5nIG11c2wgc3VwcG9ydCwgaWYgd2UgaGFkIHNvbWV0aGluZyBs
aWtlDQp0aGlzPw0KDQpISiwgYW55IHRob3VnaHRzIG9uIHdoZXRoZXIgZ2xpYmMgd291bGQgdXNl
IHRoaXMgYXMgd2VsbD8NCg0KSXQgaXMgcHJvYmFibHkgd29ydGggbWVudGlvbmluZyB0aGF0IGZy
b20gdGhlIHNlY3VyaXR5IHNpZGUgKGFzIE1hcmsNCm1lbnRpb25lZCB0aGVyZSBpcyBhbHdheXMg
dGVuc2lvbiBpbiB0aGUgdHJhZGVvZmZzIG9uIHRoZXNlIGZlYXR1cmVzKSwNCnBlcm1pc3NpdmUg
bW9kZSBpcyBzZWVuIGJ5IHNvbWUgYXMgc29tZXRoaW5nIHRoYXQgd2Vha2VucyBzZWN1cml0eSB0
b28NCm11Y2guIEFwcHMgY291bGQgY2FsbCBkbG9wZW4oKSBvbiBhIGtub3duIHVuc3VwcG9ydGVk
IERTTyBiZWZvcmUgZG9pbmcNClJPUC4gSSBkb24ndCBrbm93IGlmIHlvdSBoYXZlIGFueSBtdXNs
IHVzZXJzIHdpdGggc3BlY2lmaWMgc2hhZG93IHN0YWNrDQp1c2UgY2FzZXMgdG8gYXNrIGFib3V0
IHRoaXMuDQo=

