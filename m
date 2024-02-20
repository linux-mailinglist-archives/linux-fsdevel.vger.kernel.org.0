Return-Path: <linux-fsdevel+bounces-12189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7585CC11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D451F233C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9C0154C09;
	Tue, 20 Feb 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TN1vm74f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB611468E0;
	Tue, 20 Feb 2024 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471829; cv=fail; b=fKskKLPaXfQXBbU0RQ1LwYStwT/ZC2IGgE6HPay8WNup/pYkAgw0l6h45Rr49mDecXO/aJvRk3d8wCa0Rxh/WVil/aUrdZOc0aoBPWuxOKssDuDCcyxJd0Pf1+ObqJBWrE5VYIsAYBMfrZL3PHYcuja13qMAvDX/u5vGQJvkl7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471829; c=relaxed/simple;
	bh=vHcdGsBiA0g3ai2BEPvu+PoGa9QJUM5Az1pTdjhxgp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iDgDAnqFdiKl/omABY2CUM3D+5rzl+byFKe68VJtVPC7acNN1UWJ45l+k+Tg/CQDjUUlez0ANo4ndmbKqXYF7mg4cOHp5NmKaKsG84TY65A/fPFzlsaxtypJS6pfxnETfgNM7O4z2Kz2KY4O6CCBf3v8Hitwxa5RB0SY3vLjZNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TN1vm74f; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708471828; x=1740007828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vHcdGsBiA0g3ai2BEPvu+PoGa9QJUM5Az1pTdjhxgp4=;
  b=TN1vm74fuNCTm06akhicTAnL8of2jtQw7DF9O4bcA01KtPvfl972rXtQ
   SJMNd1PRPSH5WagNLjMm5R65FKk9MiegnN3V9cAHPYnI8+lA8YsBfZFQc
   V+0itBN6Z2ii5V8VkYGnfx3SdsE4yk0sP0m2S7CfJsXs32C6V/zpXwy9L
   XRWGcEuX8s7wji3xiTgDNJGG8u7bt7XLAnD+Zupl1UMfMRLiGIwy+fP1L
   s2HGk9m3bOkoOON3E5QkBKLVnA+vYNQYeK0Ex70Rgwmh9EmuxBbIvnwgZ
   nSYj/kZ7Ok04HYQbLOSpDV11dMlZQRopZnn5oW0xvZvY95O/hWifFVo60
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="5562147"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5562147"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:30:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5236334"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 15:30:26 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 15:30:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 15:30:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 15:30:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q26Q8u/hHgyapj+DlLHTngYQIYzziESfpc+iqTapkv4vAJKsP3Pqx6FO4WXAf9enzsbHGW4Q+5fD1ap82zKG1RqgUUXpGj4JpufDA2f85PDkYLEWLyl+Ymxh19UGrCqV8YhCGNJ0c60HEA4RQcqZ58mPX4EQ162bVhjIt9L2Jcid2qpMi1YktegXqaocX7yMZoFXTBz2wqLlRyXhCGxDtlg7J19UtdUshi9+73NVObC+kCFarvSMcn30ehJWMCQEpVnGWFXiv5KYwS+y44zdkj3skBjo5if2l3/J4ErvXrVyr+mOth6r8G/oxvg2GeQR74nCR1p9Chu6aPrzsQJWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHcdGsBiA0g3ai2BEPvu+PoGa9QJUM5Az1pTdjhxgp4=;
 b=YbZeX+X4NlXWK/edeSC/XURfr+By+xTsUkA+AuexdcgHdN4DcLc3uA/dRnsCsGyb6BBw2pLhSO5/H8J09dEDTovGq4OlPeA71E7/WSygzJFboLGQu7cFa4p6xoIPO0nTKWDQ2jxntthPtFci9/5v8uChxcjjfY8Liu3ugJWnTCf0hdvB4hQu/hDVu5OgWXVrnvqZnAH5R5xmlw7DzCZMX3JSlVLknPOBdTImM4bx8gT6Wf50DdkrYBE90vSifsjgOzIFuz0fME1Y5OdaYeuQfx+2xXOEuTq+HjGSXLUxpA+xe5ARx2q9EMxWmUxip7BbZBi3a/X3YbsF49cQHlTTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8442.namprd11.prod.outlook.com (2603:10b6:610:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 23:30:23 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 23:30:23 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dalias@libc.org" <dalias@libc.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "broonie@kernel.org" <broonie@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "shuah@kernel.org"
	<shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org"
	<maz@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>, "fweimer@redhat.com"
	<fweimer@redhat.com>, "keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "will@kernel.org" <will@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "thiago.bauermann@linaro.org"
	<thiago.bauermann@linaro.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "sorear@fastmail.com" <sorear@fastmail.com>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in
 userspace
Thread-Topic: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Thread-Index: AQHaVpxQxL7eT1mQek6VcjPJOSVEZ7ETiLSAgAAiyYCAAASHgIAATE8A
Date: Tue, 20 Feb 2024 23:30:22 +0000
Message-ID: <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
	 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
	 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
	 <20240220185714.GO4163@brightrain.aerifal.cx>
In-Reply-To: <20240220185714.GO4163@brightrain.aerifal.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8442:EE_
x-ms-office365-filtering-correlation-id: ba4184fe-3d62-4453-c121-08dc326be8e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yl7cdz09XK47zs1uVrczQSG65+Hz1zKcjpOARtq3O83jcyAgIVLNkSN8DD0pHNKVBfd2XoIrdQENsT7yWzWO+TCv/MUV6LIUbhrOvv2bUbcb1Esg4xMqmrxhYspQOGNA4A+MMWg5lrUBPK+vC5qVn2qsWMifWU8kC1WJ2TEnJgvY0kS4Ww4L0Gju+Wu5oDzJUbzf8mD5ZRZcIDGBHIf7RuHRnU8GM9HptKXZ1+ol/vyt/crrNUQgHpQj4qTmNxPMzFFWNK5Bz3b/+jmCOaSR2wsxbxukPdwEsSUVujE1EjFl3sr0AnGlDs2eS8ib8unrAORUa5DLR7zBFpUOLlqmAI07ZFZwNd5ue3eFcvL2T0BFpNGMCAjQsIv63ra/S2RPncrL+21SpvK/W7TbxQBbXULBBvA5EVT5Lb/JSTzjiHyhB/ov+10AbIvXVOJNnyVcnnFntToYU5iOv0tOq2STG1vFX30pVgdkH2FaNkA5/1KButfY0hswX71O0qpqudviR834EqNSOtuPclfeB6pWWAZswP2FMBKOVtvldmtAMo6Ygt/OTEorYBkxBNm7swhuSxu+fLLo5+xR28I2Rhoz1+2O0gMx4skgOdanqe2wRyDkhbD/YPM0QQrNvhqdqTi+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlpBbTBLZURXN1pzZDVCSW1TS1N6KzNjaUVJUlJrRGpxanZXcmtqV3FQay9X?=
 =?utf-8?B?bjBpVmFGTFdoa3N6ODdXN0ZSUjlyekRRdjBodEE5clZyRVhnL1lka2Nwallm?=
 =?utf-8?B?eWxGTzh3N3c5TWdnQ3BOcnM1SHZPWllsZkVEK1lLTG1Qb2h4YmVJd05jQkQz?=
 =?utf-8?B?ejJOMGhjU2RDNE55MUZoVVY2TU5vWDMzZjlObi9vYUNraGtXM255ck5QZUdF?=
 =?utf-8?B?UkUxUzQ1b0xnTytKUGdvSEt0ZjJmcDMzbXRSK05xR0JqeGdzcEhZOHBzdnRB?=
 =?utf-8?B?Z2ZqMmRxajRsK0hvVitmL2pwUFRjNWxDSUsvaE0yYjdqOSt4WUhRVHZIV2NX?=
 =?utf-8?B?TkM1dWdHSjFtamgrSU9JQ3VMTWpWQWdnVWlBeFBJN04zNk90YWxndktlSU1k?=
 =?utf-8?B?Y1VjaEVTTUQ0SW5aa3ZqVnN2bDBOZ2hWVjJxL0lKbkpSL3VFVTJUT1ZlSlFO?=
 =?utf-8?B?NjdvYjNqQ3F0L2NvRG9xV002ZnVGbUlEeENPa3Zwa09hT3B5U1lvdmR3QkFn?=
 =?utf-8?B?MnppdDlwaG16bUd6dUgrNGp2TUJpY1I2aW1MWmdXb21YNS9NbzJkdFk5ZTl4?=
 =?utf-8?B?SFg5UnlHWlB5V1djUUE4dU5IV1Y3K00xUm5pU2MwNkh2R0RiclFkdDd3cEV4?=
 =?utf-8?B?VWluQitzaXdyOUg1cEZBNXlkKzNkbm5zR3BJaXpmR3ZIVFpqNzN4UTVsNlVu?=
 =?utf-8?B?VzFyVUx4ZFRIZWE3NDNLTjdrS0FveGM1M3RGaGRXYmluRHlyTk1zQ0hEWXF1?=
 =?utf-8?B?MGRPRkFpQlI1L1c1eUFLRXExY3g1WHkvalZIbkNKS2haSzZFRnpMSldxU1lW?=
 =?utf-8?B?cHMzdVo3cnVmVlFOTHdkb3VjUTFKdUF5VGxpekt1Z1paY2VtYnAwNXk2dFg5?=
 =?utf-8?B?MXNDWTI5QlJCK0p0VE9DRURHeGdkWGExM3EwTzd4RDRpNjB0Qk9VMFZIeXdR?=
 =?utf-8?B?Rmp4Q1JMN1lvM1NtNkttbWZuVHU4ejdLNWRPWUFvaklJeGl0TlNpT0JJOGN3?=
 =?utf-8?B?c2xMeUZ2SzBBOVJUWC9vWFB2V2ljZVUvbmk1T0U1WEhtblNySHNPV09xMFdZ?=
 =?utf-8?B?a0xVYWZjcWc1MFV4cEl2a00yZmI4c2RRWlc4Rk1XR1dTeTdEek5SOThIeC93?=
 =?utf-8?B?NzhBb3RydFZGbmlUSTV6VTlIMmY2LzFXNmcwSjEvdk4waG1WVE9rQzh3cGZB?=
 =?utf-8?B?UFE5TlBuR1dDR0xRMVh4WkJxSzcraUpaNmFLVjEwb2E1U2VoL0RneUtRNnVl?=
 =?utf-8?B?STV0NEphYVVBVlFQTS9PTzBVNjlHZDFwanI2K1M2ZExUYUJPSUV3cW9vUktK?=
 =?utf-8?B?Z2J1QWkrL25ZTVdDUWI2YWwrNyttd0s5dW8rNjd3TUtTbzlVcUxXaXlhNXo2?=
 =?utf-8?B?VWVGUVl6R3V2b1k5MTBiYUhaSytTQjZXSTJOcDc3UjBxRyt2bFRTMzY2SGRk?=
 =?utf-8?B?RDhqbHFxdnQ3WjdxT1pqT0JMdkxoUWdQaW95d3BVQ0orejRQVzVHelA4d3d2?=
 =?utf-8?B?NkJkZ2RCblJTUUtmN3VPYlNQMGg0YWliVTJvVWRrd2R6L2tnS3IyL0xqRkdr?=
 =?utf-8?B?NXdUUkh5QTY0Q3FRaWJ5QWZ5UWxyMjJIZzF4a1dTTzdyVlJZREJWV0lCK254?=
 =?utf-8?B?VnFRbkQxUzUzY0hFaXZaV0VIQ3lIUzhkYmhkSTVQRG81cm81Y0Y3QWUyNG85?=
 =?utf-8?B?aGNBcncxd05OeWlpMVpjNmlFeHZPNjMwZm5ONkFqWkpaOW1DQTBSN0UyWDFF?=
 =?utf-8?B?bnVxZE42amVNT0djUVAra1Z4R3JJNjRRMkE0ZzdOK2MxbXFqc2RyZTc1ZVNW?=
 =?utf-8?B?NkpCRk9WM1owVXpISUZXSEJLazNVeVYvWG9objRESmFITHJyNFNVZTd5U2FQ?=
 =?utf-8?B?OVE5WGVmaDhvM3ZWWDA1Vk1hZkNPTWlQMU4ydjRxeXkxMlFJdVJLa3RkdWJS?=
 =?utf-8?B?cTBJaDZ1WUxocWhOZUE0RFJOSTNLNWlxZUl2RjdrcnVGQU9venVNWjNCNHlR?=
 =?utf-8?B?bkNrZngwVXkvanpKcThPMGUzTmVuakVsYUxUNEpoMFhtaWN3ZlUvQXJOMzQv?=
 =?utf-8?B?aWxzc1BDQmhTTDBsVkdlNFhJNUFjQXh2OHNOem5xbzdmMDkrMEcybnliK09M?=
 =?utf-8?B?WkxUU21rZ3UrVGtud3dTdTNaV0lsOCtqbkNsU1doMjJRTzg1V3NjYWRwcXU5?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01D5DF396AAC104797E8D63FDC3E515F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4184fe-3d62-4453-c121-08dc326be8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 23:30:22.9747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGGvGeRrmBjSTgCv8tz+1PYm+Ih7Tr/7AXJeMArcaERLBGRcELewNxOvbg3qfLMjyNKcOV2AIwii7Us+kfrEd4QRNs3leWbM5x3gIe0LbiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8442
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDEzOjU3IC0wNTAwLCBSaWNoIEZlbGtlciB3cm90ZToNCj4g
T24gVHVlLCBGZWIgMjAsIDIwMjQgYXQgMDY6NDE6MDVQTSArMDAwMCwgRWRnZWNvbWJlLCBSaWNr
IFAgd3JvdGU6DQo+ID4gSG1tLCBjb3VsZCB0aGUgc2hhZG93IHN0YWNrIHVuZGVyZmxvdyBvbnRv
IHRoZSByZWFsIHN0YWNrIHRoZW4/IE5vdA0KPiA+IHN1cmUgaG93IGJhZCB0aGF0IGlzLiBJTkNT
U1AgKGluY3JlbWVudGluZyB0aGUgU1NQIHJlZ2lzdGVyIG9uIHg4NikNCj4gPiBsb29wcyBhcmUg
bm90IHJhcmUgc28gaXQgc2VlbXMgbGlrZSBzb21ldGhpbmcgdGhhdCBjb3VsZCBoYXBwZW4uDQo+
IA0KPiBTaGFkb3cgc3RhY2sgdW5kZXJmbG93IHNob3VsZCBmYXVsdCBvbiBhdHRlbXB0IHRvIGFj
Y2Vzcw0KPiBub24tc2hhZG93LXN0YWNrIG1lbW9yeSBhcyBzaGFkb3ctc3RhY2ssIG5vPw0KDQpN
YXliZSBJJ20gbWlzdW5kZXJzdGFuZGluZy4gSSB0aG91Z2h0IHRoZSBwcm9wb3NhbCBpbmNsdWRl
ZCBhbGxvd2luZw0Kc2hhZG93IHN0YWNrIGFjY2VzcyB0byBjb252ZXJ0IG5vcm1hbCBhZGRyZXNz
IHJhbmdlcyB0byBzaGFkb3cgc3RhY2ssDQphbmQgbm9ybWFsIHdyaXRlcyB0byBjb252ZXJ0IHNo
YWRvdyBzdGFjayB0byBub3JtYWwuDQoNCj4gPiANCj4gPiBXb24ndCB0aGlzIHByZXZlbnQgY2F0
Y2hpbmcgc3RhY2sgb3ZlcmZsb3dzIHdoZW4gdGhleSBoYXBwZW4/IEFuDQo+ID4gb3ZlcmZsb3cg
d2lsbCBqdXN0IHR1cm4gdGhlIHNoYWRvdyBzdGFjayBpbnRvIG5vcm1hbCBzdGFjayBhbmQgb25s
eQ0KPiA+IGdldA0KPiA+IGRldGVjdGVkIHdoZW4gdGhlIHNoYWRvdyBzdGFjayB1bndpbmRzPw0K
PiANCj4gSSBkb24ndCB0aGluayB0aGF0J3MgYXMgYmlnIGEgcHJvYmxlbSBhcyBpdCBzb3VuZHMg
bGlrZS4gSXQgbWlnaHQNCj4gbWFrZQ0KPiBwaW5wb2ludGluZyB0aGUgc3BvdCBhdCB3aGljaCB0
aGluZ3Mgd2VudCB3cm9uZyB0YWtlIGEgbGl0dGxlIGJpdA0KPiBtb3JlDQo+IHdvcmssIGJ1dCBp
dCBzaG91bGQgbm90IGFkbWl0IGFueSB3cm9uZy1leGVjdXRpb24uDQoNClJpZ2h0LCBpdCdzIGEg
cG9pbnQgYWJvdXQgZGVidWdnaW5nLiBJJ20ganVzdCB0cnlpbmcgdG8gYW5hbHl6ZSB0aGUNCnBy
b3MgYW5kIGNvbnMgYW5kIG5vdCBjYWxsaW5nIGl0IGEgc2hvd3N0b3BwZXIuDQoNCj4gPiANCj4g
PiBTaGFkb3cgc3RhY2tzIGN1cnJlbnRseSBoYXZlIGF1dG9tYXRpYyBndWFyZCBnYXBzIHRvIHRy
eSB0byBwcmV2ZW50DQo+ID4gb25lDQo+ID4gdGhyZWFkIGZyb20gb3ZlcmZsb3dpbmcgb250byBh
bm90aGVyIHRocmVhZCdzIHNoYWRvdyBzdGFjay4gVGhpcw0KPiA+IHdvdWxkDQo+ID4gc29tZXdo
YXQgb3BlbnMgdGhhdCB1cCwgYXMgdGhlIHN0YWNrIGd1YXJkIGdhcHMgYXJlIHVzdWFsbHkNCj4g
PiBtYWludGFpbmVkDQo+ID4gYnkgdXNlcnNwYWNlIGZvciBuZXcgdGhyZWFkcy4gSXQgd291bGQg
aGF2ZSB0byBiZSB0aG91Z2h0IHRocm91Z2gNCj4gPiBpZg0KPiA+IHRoZXNlIGNvdWxkIHN0aWxs
IGJlIGVuZm9yY2VkIHdpdGggY2hlY2tpbmcgYXQgYWRkaXRpb25hbCBzcG90cy4NCj4gDQo+IEkg
d291bGQgdGhpbmsgdGhlIGV4aXN0aW5nIGd1YXJkIHBhZ2VzIHdvdWxkIGFscmVhZHkgZG8gdGhh
dCBpZiBhDQo+IHRocmVhZCdzIHNoYWRvdyBzdGFjayBpcyBjb250aWd1b3VzIHdpdGggaXRzIG93
biBkYXRhIHN0YWNrLg0KDQpUaGUgZGlmZmVyZW5jZSBpcyB0aGF0IHRoZSBrZXJuZWwgcHJvdmlk
ZXMgdGhlIGd1YXJkIGdhcHMsIHdoZXJlIHRoaXMNCndvdWxkIHJlbHkgb24gdXNlcnNwYWNlIHRv
IGRvIGl0LiBJdCBpcyBub3QgYSBzaG93c3RvcHBlciBlaXRoZXIuDQoNCkkgdGhpbmsgbXkgYmln
Z2VzdCBxdWVzdGlvbiBvbiB0aGlzIGlzIGhvdyBkb2VzIGl0IGNoYW5nZSB0aGUNCmNhcGFiaWxp
dHkgZm9yIHR3byB0aHJlYWRzIHRvIHNoYXJlIGEgc2hhZG93IHN0YWNrLiBJdCBtaWdodCByZXF1
aXJlDQpzb21lIHNwZWNpYWwgcnVsZXMgYXJvdW5kIHRoZSBzeXNjYWxsIHRoYXQgd3JpdGVzIHJl
c3RvcmUgdG9rZW5zLiBTbw0KSSdtIG5vdCBzdXJlLiBJdCBwcm9iYWJseSBuZWVkcyBhIFBPQy4N
Cg0KPiANCj4gRnJvbSB0aGUgbXVzbCBzaWRlLCBJIGhhdmUgYWx3YXlzIGxvb2tlZCBhdCB0aGUg
ZW50aXJlbHkgb2Ygc2hhZG93DQo+IHN0YWNrIHN0dWZmIHdpdGggdmVyeSBoZWF2eSBza2VwdGlj
aXNtLCBhbmQgYW55dGhpbmcgdGhhdCBicmVha3MNCj4gZXhpc3RpbmcgaW50ZXJmYWNlIGNvbnRy
YWN0cywgaW50cm9kdWNlZCBwbGFjZXMgd2hlcmUgYXBwcyBjYW4gZ2V0DQo+IGF1dG8ta2lsbGVk
IGJlY2F1c2UgYSBsYXRlIHJlc291cmNlIGFsbG9jYXRpb24gZmFpbHMsIG9yIHJlcXVpcmVzDQo+
IGFwcGxpY2F0aW9ucyB0byBjb2RlIGFyb3VuZCB0aGUgZXhpc3RlbmNlIG9mIHNvbWV0aGluZyB0
aGF0IHNob3VsZCBiZQ0KPiBhbiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwsIGlzIGEgbm9uLXN0YXJ0
ZXIuIFRvIGV2ZW4gY29uc2lkZXIgc2hhZG93DQo+IHN0YWNrIHN1cHBvcnQsIGl0IG11c3QgdHJ1
ZWx5IGJlIGZ1bGx5IG5vbi1icmVha2luZy4NCg0KVGhlIG1hbnVhbCBhc3NlbWJseSBzdGFjayBz
d2l0Y2hpbmcgYW5kIEpJVCBjb2RlIGluIHRoZSBhcHBzIG5lZWRzIHRvDQpiZSB1cGRhdGVkLiBJ
IGRvbid0IHRoaW5rIHRoZXJlIGlzIGEgd2F5IGFyb3VuZCBpdC4NCg0KSSBhZ3JlZSB0aG91Z2gg
dGhhdCB0aGUgbGF0ZSBhbGxvY2F0aW9uIGZhaWx1cmVzIGFyZSBub3QgZ3JlYXQuIE1hcmsgaXMN
Cndvcmtpbmcgb24gY2xvbmUzIHN1cHBvcnQgd2hpY2ggc2hvdWxkIGFsbG93IG1vdmluZyB0aGUg
c2hhZG93IHN0YWNrDQphbGxvY2F0aW9uIHRvIGhhcHBlbiBpbiB1c2Vyc3BhY2Ugd2l0aCB0aGUg
bm9ybWFsIHN0YWNrLiBFdmVuIGZvciByaXNjdg0KdGhvdWdoLCBkb2Vzbid0IGl0IG5lZWQgdG8g
dXBkYXRlIGEgbmV3IHJlZ2lzdGVyIGluIHN0YWNrIHN3aXRjaGluZz8NCg0KQlRXLCB4ODYgc2hh
ZG93IHN0YWNrIGhhcyBhIG1vZGUgd2hlcmUgdGhlIHNoYWRvdyBzdGFjayBpcyB3cml0YWJsZQ0K
d2l0aCBhIHNwZWNpYWwgaW5zdHJ1Y3Rpb24gKFdSU1MpLiBJdCBlbmFibGVzIHRoZSBTU1AgdG8g
YmUgc2V0DQphcmJpdHJhcmlseSBieSB3cml0aW5nIHJlc3RvcmUgdG9rZW5zLiBXZSBkaXNjdXNz
ZWQgdGhpcyBhcyBhbiBvcHRpb24NCnRvIG1ha2UgdGhlIGV4aXN0aW5nIGxvbmdqbXAoKSBhbmQg
c2lnbmFsIHN0dWZmIHdvcmsgbW9yZSB0cmFuc3BhcmVudGx5DQpmb3IgZ2xpYmMuDQoNCj4gDQo+
ID4gPiBfV2l0aG91dF8gZG9pbmcgdGhpcywgc2lnYWx0c3RhY2sgY2Fubm90IGJlIHVzZWQgdG8g
cmVjb3ZlciBmcm9tDQo+ID4gPiBzdGFjaw0KPiA+ID4gb3ZlcmZsb3dzIGlmIHRoZSBzaGFkb3cg
c3RhY2sgbGltaXQgaXMgcmVhY2hlZCBmaXJzdCwgYW5kDQo+ID4gPiBtYWtlY29udGV4dA0KPiA+
ID4gY2Fubm90IGJlIHN1cHBvcnRlZCB3aXRob3V0IG1lbW9yeSBsZWFrcyBhbmQgdW5yZXBvcnRh
YmxlIGVycm9yDQo+ID4gPiBjb25kaXRpb25zLg0KPiA+IA0KPiA+IEZXSVcsIEkgdGhpbmsgdGhl
IG1ha2Vjb250ZXh0KCkgc2hhZG93IHN0YWNrIGxlYWtpbmcgaXMgYSBiYWQgaWRlYS4NCj4gPiBJ
DQo+ID4gd291bGQgcHJlZmVyIHRoZSBleGlzdGluZyBtYWtlY29udGV4dCgpIGludGVyZmFjZSBq
dXN0IGRpZG4ndA0KPiA+IHN1cHBvcnQNCj4gPiBzaGFkb3cgc3RhY2ssIHJhdGhlciB0aGFuIHRo
ZSBsZWFraW5nIHNvbHV0aW9uIGdsaWJjIGRvZXMgdG9kYXkuDQo+IA0KPiBBSVVJIHRoZSBwcm9w
b3NhbCBieSBTdGVmYW4gbWFrZXMgaXQgbm9uLWxlYWtpbmcgYmVjYXVzZSBpdCdzIGp1c3QNCj4g
dXNpbmcgbm9ybWFsIG1lbW9yeSB0aGF0IHJldmVydHMgdG8gbm9ybWFsIHVzYWdlIG9uIGFueQ0K
PiBub24tc2hhZG93LXN0YWNrIGFjY2Vzcy4NCj4gDQoNClJpZ2h0LCBidXQgZG9lcyBpdCBicmVh
ayBhbnkgZXhpc3RpbmcgYXBwcyBhbnl3YXkgKGJlY2F1c2Ugb2Ygc21hbGwNCnVjb250ZXh0IHN0
YWNrIHNpemVzKT8NCg0KQlRXLCB3aGVuIEkgdGFsayBhYm91dCAibm90IHN1cHBvcnRpbmciIEkg
ZG9uJ3QgbWVhbiB0aGUgYXBwIHNob3VsZA0KY3Jhc2guIEkgbWVhbiBpdCBzaG91bGQgaW5zdGVh
ZCBydW4gbm9ybWFsbHksIGp1c3Qgd2l0aG91dCBzaGFkb3cgc3RhY2sNCmVuYWJsZWQuIE5vdCBz
dXJlIGlmIHRoYXQgd2FzIGNsZWFyLiBTaW5jZSBzaGFkb3cgc3RhY2sgaXMgbm90DQplc3NlbnRp
YWwgZm9yIGFuIGFwcGxpY2F0aW9uIHRvIGZ1bmN0aW9uLCBpdCBpcyBvbmx5IHNlY3VyaXR5IGhh
cmRlbmluZw0Kb24gdG9wLg0KDQpBbHRob3VnaCBkZXRlcm1pbmluZyBpZiBhbiBhcHBsaWNhdGlv
biBzdXBwb3J0cyBzaGFkb3cgc3RhY2sgaGFzIHR1cm5lZA0Kb3V0IHRvIGJlIGRpZmZpY3VsdCBp
biBwcmFjdGljZS4gSGFuZGxpbmcgZGxvcGVuKCkgaXMgZXNwZWNpYWxseSBoYXJkLg0K

