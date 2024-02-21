Return-Path: <linux-fsdevel+bounces-12299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC2485E54F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C5E1F23979
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E352D85281;
	Wed, 21 Feb 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQ6lqPHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41B84FD7;
	Wed, 21 Feb 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539162; cv=fail; b=u2ueqrIgvVuI6pJJON7CAGLoUaG7b/tLvQA76e/5LLoB/M1jmoi1xC66pWqSPHNnaAVZYaiIFIvcfxwQt/ysJgSowRUFnyOeJp6z0ZNZkRuagpiZU6vB592Uw+Mz+SvsLcuPnOt2cmgwHEvoUoCSGl9mxwkXRbHaOWNFo2euJiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539162; c=relaxed/simple;
	bh=tJCX6ZeZNBVawwMjkmLsesCbI4WdzvuMklbF92XMess=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Om92DWfhK5MjRHwVBsS+admSQfx1Xty0lKXEOPJsRdmVxqCfcRRDS4Flq1txeo2o392fSkZ9YuNW/mHZ/BkpzpNY5CIqUb1DwOzL/l3o4wb5nmj9j5JaBQkjYXpqo1JkzZNAjjnlP90IvKWLF4yt/tUjzGKfZHiMkY5B1Wjimhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQ6lqPHn; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708539160; x=1740075160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tJCX6ZeZNBVawwMjkmLsesCbI4WdzvuMklbF92XMess=;
  b=QQ6lqPHnBxS7EK4KPz+taiL+C3S/+WnRZH10EcMct17jdOem+pMfN8mL
   O3+ndd0hGS2wstVMUrVI5ZPqwUDF/1Bw1tMEFSmqzsVIrLM3ukw3DTtM+
   MyDLUYBiFc0MpwyyIr7CwFuN0cIRz/dbg3Vbu0e1QE7LAbmF6LlJclpVE
   kD7msTqQQyMBoVWyf0Z2ggDq20e2Ekt5dCmfDLBHoVNDwFfjhy3bfLj1h
   Ck9wAyfB7UJ8ZSaOjzGtIIOD8/itLxTyBDSuGybPZRqNarveNW9ozogFm
   AZyX23NynTIpG0IEHrYKJ8eU6uZl1nzFxTF9WZj5WPw8zJ0LPswz958K7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28162159"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28162159"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:12:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936681513"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936681513"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 10:12:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 10:12:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 10:12:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 10:12:33 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 10:12:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5DvEUBEUf9wiIdKgUvzF/MjqEguyvfS82Q6W9jwtToYnAu0hoPWXz6PC0RAehd+abaiA38XGGO7ezgZ3wYuVc2qsse9s+7posis+kgssOwF4dJndqIEhqUE0XlTupVRUS9v+sGvLA/hh7yY+xJZdQIs+SAp5XZ4Dmx9Xy33Jk1MzwdAOcvud6LAMatVDY7/zMinHNNN76lJUv1F2HmHnhglk+vnEvyHwbiOk8PC80NlW7tWDXtyge4dHQ6bxQoim14fucdP9MxDGH3yWCgxnhzoXSDQK0RRflWUtBTAgcKi6SO5M2Q6Cw+X42b61eg9xNGdfyrsb6lNxZBqji3QZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJCX6ZeZNBVawwMjkmLsesCbI4WdzvuMklbF92XMess=;
 b=HL9RSZUy5yP8sH/pLFeRT55dxBdT1BEDaTnuwuUB1s4iK3IyHnb/ygID4opOvjjkqe01U2cuzT6+9SjUTa2t79BKmEQIDKC1oz9vxtZUyBwfaShKIGC5zFJddw8gMSVFdE17dxK2hqp/XFdPOVwucd+cX/zwETp0jyNFqsTWQGt+aTvbYFXkmSGYqN8qPnGN42bx+EGnwz38WxcKJSP9csPN0gvkIaMLD7hBscUxEQwB+k7f094bgS8uLihbDac3f8hzz5I7B9b82CckrliBTs+xmDrKF3Y6nw9qvu+ddwSZOoYaqcMOYWsqlpKhjuD0z3oKbRi1oi2RWdBcO0GZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8564.namprd11.prod.outlook.com (2603:10b6:610:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 18:12:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 18:12:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "dalias@libc.org"
	<dalias@libc.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"maz@kernel.org" <maz@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "will@kernel.org"
	<will@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "thiago.bauermann@linaro.org"
	<thiago.bauermann@linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "sorear@fastmail.com" <sorear@fastmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in
 userspace
Thread-Topic: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Thread-Index: AQHaVpxQxL7eT1mQek6VcjPJOSVEZ7ETiLSAgAAiyYCAAASHgIAATE8AgAAGrQCAAAuagIAADnuAgADQTgCAABIegIAALDIAgAAF54CAAAQ9gA==
Date: Wed, 21 Feb 2024 18:12:30 +0000
Message-ID: <f4a54297767eb098d903404cbe8860d655d79bed.camel@intel.com>
References: <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
	 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
	 <20240220185714.GO4163@brightrain.aerifal.cx>
	 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
	 <20240220235415.GP4163@brightrain.aerifal.cx>
	 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
	 <20240221012736.GQ4163@brightrain.aerifal.cx>
	 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
	 <20240221145800.GR4163@brightrain.aerifal.cx>
	 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
	 <20240221175717.GS4163@brightrain.aerifal.cx>
In-Reply-To: <20240221175717.GS4163@brightrain.aerifal.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8564:EE_
x-ms-office365-filtering-correlation-id: 82657b25-7e25-44bd-25ae-08dc3308ab80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66k4FU8PsIAQlxHo0kAZS1PMj7ZIsBmKVrGOs/JLLFsqcbnVnBVr9dOJ/mqgz+RsB6g/xCjWqLTovvY3U3QxHd5BLV6PwRU8v83rcHHtrsOkwZQW73lWLnMCse8NCB8ihSflXbB9GNJVsv9inLjG5NeeVqotLQsDbuK0g/eNdH5LSnV3PJ3wjuNtv5WmJyQ3BSn/bsI3N5ejCuUGqUh/SJBQqQu0daHHRjFNE6kM6I8iL7l1sPiTbwwBd3x1r5QEp9alknSt3gBYFAjfYGZypoR7plO/8P+yYcIL0k6UBOPY2Doc+wLUvMns/fgPGKo1x8W1GeDuMaYiAr9ZSYONOiMN9SzyXzumhESbnIN2tAvSEIWCLLLzM5Fv0/5aovKUm62Bb8mQQ6wg2zOZnxEu3bE2tndnpPM08ekA0F/VWVW0h233yXY6QUQ+pVsV+d5LYY31HO2tEk6hAheT3ksYJudaaH+/CGfmUI0HHKQdbx76QQjQk/IpcPY9i2Hy6vOeunJZ35ODnC2wiXwKk9n8aZ0xbZwJwc0c2bLgYn9v2hwxL0Vd/sz/BqCI+a6LnFChS4BZwqCKk3IQu2g8ixrq5Gv96aLZEBRya7gsI5lQkGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nnk2SXU1UHFYTU5IN05nUFVBQ0hHY1VaTlgvalRSeUZPWi9UNit3a2l2NE9o?=
 =?utf-8?B?Y2I2SHYxSGtMaVJna0lLemV5cndaMG9vS0N3MU1aQkxuU3BIcXRDcUpDdkww?=
 =?utf-8?B?dkVPR1g2a0VhTUtrUXphS3padjI4aXE2d1JicG9sTGlHbHdvQ1M3L3VpOXVD?=
 =?utf-8?B?WTFoNDhyR2ZQZVpuYm1tejN6U1VpcWpPY0RmcVdBdW05OTUzTHp2c0tQNlQ2?=
 =?utf-8?B?WEpLRjcyaDVDVzM5OWFISWQyeWEvVm01TktsbTJTREVvd0pEQnRBbmVnMlhB?=
 =?utf-8?B?dVBSNWJnMVpiYjBCaWtHZGJtem9aK3hFSFpkd0MrempMQVpjZ2o0MVBsMW5T?=
 =?utf-8?B?Q0Q2S0w3cm5zOUNPczdVK29GWVlXZEp4YSs1bG1kSHkxRkdmK204eFZ4eVZP?=
 =?utf-8?B?M3QvOHB6M2RLZmtpalBCd1hyV3NXZjNPSk8wM2xmRm9zN05rSzNibzdRWXlC?=
 =?utf-8?B?MXExMWgzOGtvQ3l6bytoVWppd1A2eVc4M2NscHR5UmFhNGlYTzYyYkRsaUgr?=
 =?utf-8?B?WHRENFFnaUEvVXdyZFZrOWhDWU1jLzIzOWY1aFpZbThYUzZ6a3ZuU1Fpa3B3?=
 =?utf-8?B?MklhYnIzcnJyOVdtUDdqMGlzdTVlTlRNaFB3dzRpdDV4MXhSSi9kTVBDNFNL?=
 =?utf-8?B?TmxmbktQWTlzU0c4WkxNdE1nWGNJTzViS1ZUS2Y0S0RrMnJQcHR6a201R2w5?=
 =?utf-8?B?dlhvN0NiWE1FUjloelpLd2V6ZnFuYUsxZzhhKzRJLzBoYkNiNlZMQWxUZ1Zx?=
 =?utf-8?B?Z2dDRE9wSjVEYTFEQS9vbHNhSWxuMHF3bGhkOFJmQ0JMMXJPckIyV1E1Y0FK?=
 =?utf-8?B?R3FHM0tCYkd0eE4xNCtQWFY5THBFTnBaalJReTFvalNGaTllSW1PaEZrYWYz?=
 =?utf-8?B?MDA1UjIrTTdtd0JvbXNLTHAvbngwQjR3c1duMkkvRlBKakpISi9LR0Z0WEpz?=
 =?utf-8?B?QXljS1VFSCtra1NEQjE2YUg3ZGVZTjMraXI0cmc2TE5WNENRK1lPMGZxWE5V?=
 =?utf-8?B?ZXl6UTVEVEsva3k2UFhmZWQ1WU5zdTF4N0NWZGRhRkdEYVRxbXREcWhKb241?=
 =?utf-8?B?V1h2Y1lwbXNDTHRSalNDMU5CdUt0Zzhyc2lRdE9kQVJwdHVqSWcxbUVyN1Y3?=
 =?utf-8?B?QnZQSW9XREVYSkRsZlFJQ2x4amZad3NxekFRV0UrcnpSdVFZREJLeWQ4SWtm?=
 =?utf-8?B?dFM4d0hIYUdwczVqQ0tvNm45dmVnTklqTTI5Uy9OZEVJejFMM3Z2SEE4MlFL?=
 =?utf-8?B?cE5YUEtwakhxNmVsTWpjdVR3QTczR1V2ZjZWMGo5UEEvQ1A0MldJdVNlSzFD?=
 =?utf-8?B?NjBXTnJBSm52QS93NkRtT2ZQbjEzaUR1ZHFKWk1XbVlSVHJabXVFNlR3YWxR?=
 =?utf-8?B?b3lYS2E4aitxN21tMlJMWTh1Wml2TG1JdGdGcmkxa2JRYzdjZGJjOUpKRkoz?=
 =?utf-8?B?cmlUazJUdVgxUXJaYWNIVDdmN2NQOFVDVXprc2dxLzdJdmNiVk0vSHJha0lX?=
 =?utf-8?B?a2VWNlhoWDhvSDFEaUd6WS80dEY4K2s0eUtOVllRY1RsSGR4K3FVTEZtbEhz?=
 =?utf-8?B?S0U3UDBZUUhRZzNlSE1IL0d5NVdLeS9Ta3YyVFI5TXVLWk51VnVMN0kxbXAx?=
 =?utf-8?B?bGM4RWpUOEdYc1NXMVN4QTZ4Q0I3K1VkS1p0cWw0ZnBtRHFpWnYyQ1Bpck1U?=
 =?utf-8?B?cklsQXpJK29NSzlaNFAvTXRISXdINkRsS0RzMVdqTm1ZSHNLR0dQamovcmhv?=
 =?utf-8?B?T0NnQnkrOUJzYnFRRk05QVk3MEFXQnZnMGlocExuZVdwUTkzTzNRUkFFaDFm?=
 =?utf-8?B?c25jWnhtaHVPMU85SWdHZFg4emdQWG5XZVBHbTJjR01PMHJDRWI2TFlWSFhy?=
 =?utf-8?B?Nll6aTRwSkZnZURaUm1IVlFGci95a2RBdCtOS0pYUm9KT09DQ1pTZFhsK292?=
 =?utf-8?B?VmhDMjkyRGd4R0JuZ211VE53Z2N2Znk0ajlCTTQ2SWFnbVQvM0ZpUXFnaDR4?=
 =?utf-8?B?a2J5UVh3MzdHeHJIODFaeEFyYTBoNVdTLzNYZmpsc2VsMmZ5YXVPeEFnWUhn?=
 =?utf-8?B?a2JOWGM5VVkxRXdrVmJvd2hMUWw4SkZvZEJNN3UyVTdRZ2ppV1JQalJRNmVH?=
 =?utf-8?B?OGl3UVJwWm1nOHR2aTBiQzRtc3IwT05KUVZSTWw3SzluaWJ0Tm9NOGtVWENj?=
 =?utf-8?Q?A7u/UbKt+hR6ZmdcqEA4etI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2105222828E6E24AAFC3DEA129C7B2F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82657b25-7e25-44bd-25ae-08dc3308ab80
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 18:12:30.9211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kmj/ER548NlpVsmZezQJghQZSyTS1GS3tt2kXUkor7RUnRa4s7SBDA51zVQ71ctZlmPq31LjrHlw0NwfQzBus3xEx5o/Ro2EUcauLPktDkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8564
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDEyOjU3IC0wNTAwLCBkYWxpYXNAbGliYy5vcmcgd3JvdGU6
DQo+ID4gVGhpcyBmZWVscyBsaWtlIGl0J3MgZ2V0dGluZyBjb21wbGljYXRlZCBhbmQgSSBmZWFy
IGl0IG1heSBiZSBhbg0KPiA+IHVwaGlsbA0KPiA+IHN0cnVnZ2xlIHRvIGdldCBzdWNoIGNvZGUg
bWVyZ2VkLCBhdCBsZWFzdCBmb3IgYXJtNjQuwqAgTXkgaW5zdGluY3QNCj4gPiBpcw0KPiA+IHRo
YXQgaXQncyBnb2luZyB0byBiZSBtdWNoIG1vcmUgcm9idXN0IGFuZCBnZW5lcmFsbHkgdHJhY3Rh
YmxlIHRvDQo+ID4gbGV0DQo+ID4gdGhpbmdzIHJ1biB0byBzb21lIHN1aXRhYmxlIHN5bmNocm9u
aXNhdGlvbiBwb2ludCBhbmQgdGhlbiBkaXNhYmxlDQo+ID4gdGhlcmUsIGJ1dCBpZiB3ZSdyZSBn
b2luZyB0byBkbyB0aGF0IHRoZW4gdXNlcnNwYWNlIGNhbiBob3BlZnVsbHkNCj4gPiBhcnJhbmdl
IHRvIGRvIHRoZSBkaXNhYmxpbmcgaXRzZWxmIHRocm91Z2ggdGhlIHN0YW5kYXJkIGRpc2FibGUN
Cj4gPiBpbnRlcmZhY2UgYW55d2F5LsKgIFByZXN1bWFibHkgaXQnbGwgd2FudCB0byBub3RpY2Ug
dGhpbmdzIGJlaW5nDQo+ID4gZGlzYWJsZWQNCj4gPiBhdCBzb21lIHBvaW50IGFueXdheT/CoCBU
QkggdGhhdCdzIGJlZW4gaG93IGFsbCB0aGUgcHJpb3IgcHJvcG9zYWxzDQo+ID4gZm9yDQo+ID4g
cHJvY2VzcyB3aWRlIGRpc2FibGUgSSd2ZSBzZWVuIHdlcmUgZG9uZS4NCj4gDQo+IElmIGl0J3Mg
cG9zc2libGUgdG8gZGlzYWJsZSBwZXItdGhyZWFkIHJhdGhlciB0aGFuIHBlci1wcm9jZXNzLCBz
b21lDQo+IHRoaW5ncyBhcmUgZWFzaWVyLiBEaXNhYmxpbmcgb24gYWNjb3VudCBvZiB1c2luZyBh
bHQgc3RhY2tzIG9ubHkNCj4gbmVlZHMNCj4gdG8gYmUgZG9uZSBvbiB0aGUgdGhyZWFkcyB1c2lu
ZyB0aG9zZSBzdGFja3MuIEhvd2V2ZXIsIGZvciBkbG9wZW4NCj4gcHVycG9zZXMgeW91IG5lZWQg
YSB3YXkgdG8gZGlzYWJsZSBzaGFkb3cgc3RhY2sgZm9yIHRoZSB3aG9sZQ0KPiBwcm9jZXNzLg0K
PiBJbml0aWFsbHkgdGhpcyBpcyBvbmx5IG5lZWRlZCBmb3IgdGhlIHRocmVhZCB0aGF0IGNhbGxl
ZCBkbG9wZW4sIGJ1dA0KPiBpdCBuZWVkcyB0byBoYXZlIHByb3BhZ2F0ZWQgdG8gYW55IHRocmVh
ZCB0aGF0IHN5bmNocm9uaXplcyB3aXRoDQo+IGNvbXBsZXRpb24gb2YgdGhlIGNhbGwgdG8gZGxv
cGVuIGJ5IHRoZSB0aW1lIHRoYXQgc3luY2hyb25pemF0aW9uDQo+IG9jY3VycywgYW5kIHNpbmNl
IHRoYXQgc3luY2hyb25pemF0aW9uIGNhbiBoYXBwZW4gaW4gbG90cyBvZg0KPiBkaWZmZXJlbnQN
Cj4gd2F5cyB0aGF0IGFyZSBwdXJlbHkgdXNlcnNwYWNlICh0aGFua3MgdG8gZnV0ZXhlcyBiZWlu
ZyB1c2Vyc3BhY2UgaW4NCj4gdGhlIHVuY29udGVuZGVkIGNhc2UpLCBJIGRvbid0IHNlZSBhbnkg
d2F5IHRvIG1ha2UgaXQgd29yayB3aXRob3V0DQo+IGV4dHJlbWVseSBpbnZhc2l2ZSwgaGlnaC1j
b3N0IGNoZWNrcy4NCg0KRm9yIGdsaWJjJ3MgdXNlLCB3ZSB0YWxrZWQgYWJvdXQgYSBjb3VwbGUg
b2Ygb3B0aW9ucy4NCjEuIEEgbW9kZSB0byBzdGFydCBzdXBwcmVzc2luZyB0aGUgI1VEJ3MgZnJv
bSB0aGUgc2hhZG93IHN0YWNrDQppbnN0cnVjdGlvbnMNCjIuIEEgbW9kZSB0byBzdGFydCBzdXBw
cmVzc2luZyAjQ1BzICh0aGUgZXhjZXB0aW9uIHRoYXQgaGFwcGVucyB3aGVuDQp0aGUgc2hhZG93
IHN0YWNrIGRvZXNuJ3QgbWF0Y2gpLiBTbyB0aGUgc2hhZG93IHN0YWNrIGluc3RydWN0aW9ucw0K
Y29udGludWUgdG8gb3BlcmF0ZSBub3JtYWxseSwgYnV0IGlmIHRoZSBzaGFkb3cgc3RhY2sgZ2V0
cyBtaXNtYXRjaGVkDQpkdWUgdG8gbGFjayBvZiBzdXBwb3J0LCB0aGUgcmV0IGlzIGVtdWxhdGVk
LiBJdCBwcm9iYWJseSBpcyBzYWZlciAoYnV0DQpzdGlsbCBub3QgcGVyZmVjdCksIGJ1dCB0aGUg
cGVyZm9ybWFuY2UgcGVuYWx0eSBvZiBlbXVsYXRpbmcgZXZlcnkgUkVUDQphZnRlciB0aGluZ3Mg
Z2V0IHNjcmV3ZWQgdXAgd291bGQgYmUgYSBzaWduaWZpY2FudCBkb3duIHNpZGUuIFRoZXJlDQph
bHNvIG5lZWRzIHRvIGJlIGNsZWFuIGhhbmRsaW5nIG9mIHNoYWRvdyBzdGFjayAjUEZzLg0KMy4g
UGVyLXRocmVhZCBsb2NraW5nIHRoYXQgaXMgdXNlZCBhcm91bmQgYWxsIHNoYWRvdyBzdGFjayBv
cGVyYXRpb25zDQp0aGF0IGNvdWxkIGJlIHNlbnNpdGl2ZSB0byBkaXNhYmxpbmcuIFRoaXMgY291
bGQgYmUgbWF5YmUgZXhwb3NlZCB0bw0KYXBwcyBpbiBjYXNlIHRoZXkgd2FudCB0byB1c2Ugc2hh
ZG93IHN0YWNrIGluc3RydWN0aW9ucyBtYW51YWxseS4gVGhlbg0KZHVyaW5nIGRsb3BlbigpIGl0
IHdhaXRzIHVudGlsIGl0IGNhbiBjbGVhbmx5IGRpc2FibGUgc2hhZG93IHN0YWNrIGZvcg0KZWFj
aCB0aHJlYWQuIEluIGVhY2ggY3JpdGljYWwgc2VjdGlvbnMgdGhlcmUgYXJlIGNoZWNrcyBmb3Ig
d2hldGhlcg0Kc2hhZG93IHN0YWNrIGlzIHN0aWxsIGVuYWJsZWQuDQoNCjMgaXMgdGhlIGNsZWFu
ZXN0IGFuZCBzYWZlc3QgSSB0aGluaywgYW5kIGl0IHdhcyB0aG91Z2h0IGl0IG1pZ2h0IG5vdA0K
bmVlZCBrZXJuZWwgaGVscCwgZHVlIHRvIGEgc2NoZW1lIEZsb3JpYW4gaGFkIHRvIGRpcmVjdCBz
aWduYWxzIHRvDQpzcGVjaWZpYyB0aHJlYWRzLiBJdCdzIG15IHByZWZlcmVuY2UgYXQgdGhpcyBw
b2ludC4NCg0KMSBhbmQgMiBhcmUgUE9DZWQgaGVyZSwgaWYgeW91IGFyZSBpbnRlcmVzdGVkOg0K
aHR0cHM6Ly9naXRodWIuY29tL3JwZWRnZWNvL2xpbnV4L2NvbW1pdHMvc2hzdGtfc3VwcHJlc3Nf
cmZjLw0KDQo+IA0KPiBJZiBmb2xrcyBvbiB0aGUga2VybmVsIHNpZGUgYXJlIG5vdCBnb2luZyB0
byBiZSBhbWVuYWJsZSB0byBkb2luZyB0aGUNCj4gdGhpbmdzIHRoYXQgYXJlIGVhc3kgZm9yIHRo
ZSBrZXJuZWwgdG8gbWFrZSBpdCB3b3JrIHdpdGhvdXQgYnJlYWtpbmcNCj4gY29tcGF0aWJpbGl0
eSB3aXRoIGV4aXN0aW5nIGludGVyZmFjZXMsIGJ1dCB0aGF0IGFyZSBpbXBvc3NpYmxlIG9yDQo+
IG5lYXItaW1wb3NzaWJsZSBmb3IgdXNlcnNwYWNlIHRvIGRvLCB0aGlzIHNlZW1zIGxpa2UgYSBk
ZWFkLWVuZC4gQW5kDQo+IEkNCj4gc3VzcGVjdCBhbiBvcGVyYXRpb24gdG8gImRpc2FibGUgc2hh
ZG93IHN0YWNrLCBidXQgd2l0aG91dCBtYWtpbmcNCj4gdGhyZWFkcyBzdGlsbCBpbiBTUy1jcml0
aWNhbCBzZWN0aW9ucyBjcmFzaCIgaXMgZ29pbmcgdG8gYmUNCj4gbmVjZXNzYXJ5Li4NCg0KSSB0
aGluayB3ZSBoYXZlIHRvIHdvcmsgdGhyb3VnaCBhbGwgdGhlIGFsdGVybmF0aXZlIGJlZm9yZSB3
ZSBjYW4NCmFjY3VzZSB0aGUga2VybmVsIG9mIG5vdCBiZWluZyBhbWVuYWJsZS4gSXMgdGhlcmUg
c29tZXRoaW5nIHRoYXQgeW91DQp3b3VsZCBsaWtlIHRvIHNlZSBvdXQgb2YgdGhpcyBjb252ZXJz
YXRpb24gdGhhdCBpcyBub3QgaGFwcGVuaW5nPw0K

