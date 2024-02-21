Return-Path: <linux-fsdevel+bounces-12208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3210E85CF4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 05:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6F8B23B1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 04:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51939FC8;
	Wed, 21 Feb 2024 04:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVkWLzTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557539AE1;
	Wed, 21 Feb 2024 04:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708489857; cv=fail; b=E+oviznnptLB9OScwjGh0dO8OPhKcYckCSAzgKK6OEdzOmrsvl5eAQUQWh3IkPuH16p3qeSF1l9tzujYT1KXS7IjnGi7/mDgm5u8izsp+VLz0i6eWmiMJdZgA06jV/KXVDE3ZUNhf+fNgVMvDMNwXomtkpwAJBa19Kc/5msKX90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708489857; c=relaxed/simple;
	bh=/haKh5XkLk63Ews24pAIl9uKjQoYPq3dFaKmxCA+hvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ff5d6483pZLZWLtCZCqetT1O2UHMPy3GDwWBIwbfI9pk/LXx+RvRns1MTloi6ENGI1GuunlzVL8MGbd2B06b8dtZrXRP3C7jnEIBfWE4Lgvq58uwAaGk6FfqTWVViEb9ZVw3v2LZ1H+mgxNoY2NgWBaJFvlfb3Ls2zKdg7/xDzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVkWLzTa; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708489857; x=1740025857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/haKh5XkLk63Ews24pAIl9uKjQoYPq3dFaKmxCA+hvk=;
  b=HVkWLzTa6mniOvN8Qzenn7mduS6voAXgUBeyLxahLLu04b4bgNSJPVHp
   w6yktPWDzsjCh8Hje/7jK38UG3UtnC+5dFfBjuNzf46Nos6qFnp49XORz
   uOR4Z5tESiqQgPnk4QsmYB6HfLsFNVqJWhU5HTo7WatEzH4mU7FzHy66J
   OjoPzn8ZPZ7m/qoOq9Giekpnc0aRNJQif2I05jyvN+upo4EzeK3LyoUdF
   hqDfbXtiJRibv2WoQ93Ts/m+tt/EwdrmYjyxBtZSAw7OO73QEue0eHVWk
   nB4wYOQ3R73uDuEQinw9mlaky/2GB9OXuXz49eKu/CfWwQexEAXFm+7D4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="25094056"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="25094056"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 20:30:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4979723"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 20:30:52 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 20:30:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 20:30:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 20:30:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7FzGxDjbYMEfiVOUtr9MIXNjyOkq+jLo4KdPCvDvD9xHJemKldV4E8+cV6IhTEMpTL6wRKA66OZG+5obwORpJa5IzVY/3cmOpzHSmgbVMC6Gk2+DDeN8QFcuMr+TS2Xs7o3uo9lB/VWfE2gff13h5FQDNl7PrWq6JJu1YwdpIoF5ALOGmnmYmAhirvluQrNix9GZfztZY69Sp2C6/D18KRYOPgCxpVrqw4djr33f/49luq2oHKyiDqpb252Z4cJ3Ic2e6FkhswgzO4Rhx1fvioCL3f0iEyaAYeme8IQM3Vss/bcxxwHoprkD7b2JhUHpTOs4kz0TYgZTOsEEJd+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/haKh5XkLk63Ews24pAIl9uKjQoYPq3dFaKmxCA+hvk=;
 b=RdJvRPQnOqRm6bdip3rne6Rg6CfPO7/gmREZIIkzukf27+pTUCJJNsFEFPFljJrj7pC2MpTIfeE0cSnvKYSM0pyiOTMCpaCPX68IFGtp5IwERP9CRt2A6nMObctIF/sxjYoF2nyBimlBJefhkO1NJQiD3pID3ye1a8E39DVRAGSW8ASWcIAGyW+onjstv8RYc4b/BtpsyaXAnl5jf3kw8it9sZo8Zt9bPv+fTWpS3C8cXxsmMdNwt4gqIsgJl9Ya2MmvDGfe/gPo6tKhnZaMplmyT6cGVSE+BdL1J0Dsu1uZrykkLn9aanumlpRDR7iBaKLSk9JCTBk+cFeb7IdRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB4838.namprd11.prod.outlook.com (2603:10b6:510:40::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 04:30:49 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 04:30:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sorear@fastmail.com" <sorear@fastmail.com>, "dalias@libc.org"
	<dalias@libc.org>
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
	<akpm@linux-foundation.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in
 userspace
Thread-Topic: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Thread-Index: AQHaVpxQxL7eT1mQek6VcjPJOSVEZ7ETiLSAgAAiyYCAAASHgIAATE8AgAAIRQCAAEurAA==
Date: Wed, 21 Feb 2024 04:30:49 +0000
Message-ID: <8d28fce4b0d1fc2c757621d9a0f82a5c2db8e78c.camel@intel.com>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
	 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
	 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
	 <20240220185714.GO4163@brightrain.aerifal.cx>
	 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
	 <063acc75-ea1d-4dd3-aecb-e5c8884005db@app.fastmail.com>
In-Reply-To: <063acc75-ea1d-4dd3-aecb-e5c8884005db@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB4838:EE_
x-ms-office365-filtering-correlation-id: 2b021f81-719d-4d4a-063e-08dc3295e166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDOAaRa2C0t1/o+h+zWC6vjHsgpB+fwl/j7dgci1pbXd/sDntgohehLESE9eXT7GdwrvgPPbyZVRaNPP9ZBhluKBXidwqpMNlBS72IwVrb950GYSN7go/RTmRQzozMrRCHZ6uGPtVsJGamSliCF97wcSX1r+PRIMuA3sOmYrMp2+gPShkgdnhLAmBKR0Jqv+7HrkWdO/h/YWwoM8LXM0t8Ef/IR9ksYHVl0oWvR3S+gugyh/qehfG+PqDOgrZSIg3c+bHeNVb10cG65X16XtdoOoFxJ2Ha8TUP8YO4bTZBPZcpHjzeRVFdVgZNMK59fhjmsC3TQksBTLuiyRorLzcjFZtaioW+bORlLOwVhfqnYHI9NSlMusyN14dvlGFxnYdOx5dOeWYPPYwF3BvRRj7Ono9/PyQpDEV/1iLqVC/uZwtg3IcEolhT9bg/hmeoFOCRaNSM2ENEQx84HaxgJEQ2o37JtkCV9AxCWpRIfa2qqHDCnEiD4AD/8mv3mXWRDx4ZUA+barzLE5QFsfhqwjhB8w/t3wV5lejcEtFHIy2S+7wMUBAZxbnccFprIq3DyDDSOG08aPmD6LcPE+dSfhJQ0CXWGjdMigBVyNI+irOruUNK2WM4xWvyf7ZsZeQgzO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXR2dG5aZzEyR250a3pJM0dOOHZoQzZwakEvbUZ6M3NNSFVFelBUai9hZytr?=
 =?utf-8?B?QnRYa1ZQWE9MbkJXekpvWU1EbTJxaVJna2w3ZmlmMWlZcEtkL2Raemc5aTlV?=
 =?utf-8?B?TzdjRlNyL2VLVEV2TzFBdzcyRDVid0VwNlE4OW5MM25obHNZUmFjZ2RyeHdm?=
 =?utf-8?B?aFg5R3B5UWRDcElvT1Flb3lCV3A4VlQ5bHZFdXZhRmFPb1BNREt1MHRUUnZH?=
 =?utf-8?B?NVM5Qyt5cXVscWkwWFBVV3hCbExFbXhEV2JWNWt1dkVGNmpwYUZyT09lZXgr?=
 =?utf-8?B?cDhqNHZ6WHpyNjZ0KzRYTTZYWjNLWWdrZ3M1NXpXK0twelB4dW9UMzFmbzVR?=
 =?utf-8?B?cG1pZHdUQVVKZFFxd1ZoSnoyTFFGRGZHVndEeWhySkVtbzJYYlFvSWt0LzVx?=
 =?utf-8?B?M1ZlbFNjYk5KSThIOFUyMmYzUG1WaHdKYThtWXByWEtGSEhlNzgwWkdFOHVj?=
 =?utf-8?B?ZGo0VjlUb0c3cThIald0c1R3TWxtT3NpMldsSEY4YTF5RGpWb3A3dXpQSG0x?=
 =?utf-8?B?bGNNWW5jdy9MZ1dvN1BjeEZlU1VpcVhhamFiOTNoVWNRQ01XRldaUHhzZW1D?=
 =?utf-8?B?Q2F4M0xwVVZKMGdYdjY5K2ZoYlU1SmFIK0JTcTlKUFNXS1NQK25oVkpoaFR2?=
 =?utf-8?B?VTFUZ09MRThUTmtTakgvc1kvREoveGZlQ01QVE5vRVNsSWRTVWRmRDk5NEgy?=
 =?utf-8?B?N095S050Q3d5dm4zU1I2Z3ptZVczYmhObzBXaEcxbW1Xd3hFTEkrYzBybXkv?=
 =?utf-8?B?L29tS3NTdytxaGdnOHA5bnBkVklhQVJzblZSU0k3RytNWlVGbjNOQ3JMZVdI?=
 =?utf-8?B?bWd0ZDRqQzhHREFVbWxHNmJtTDZQK1RXWFJjaGdnY1JHWlNTN0NGWkVyYWZI?=
 =?utf-8?B?Zmg5d3YrOGdrVUI1SjBvV3ovNmkreXdNYnRMMEZsTUt2NUFxUW1RRDBCSW9Z?=
 =?utf-8?B?Q0t6TG9veE9ROCszeS96cnpxaG1uY0J5MEMyQWtva083MU16RW5jL0NqZzdw?=
 =?utf-8?B?dWUwNVhuWVh2eTRkNVUxM2lSOGNHL09rS1lmUGVsaXdrY0k4VUh4QVE5U0tQ?=
 =?utf-8?B?QjVmOTgrZWVPRjFnU2FyallMcC81U24xZldZL21aSEN2K0NBMDdyZy9BREQ0?=
 =?utf-8?B?ZG5GMFdMa054T2szZFBhaG9RSEV0ZFpaYUFWSDN1TlBaVVN2K1lpc2JYaHdk?=
 =?utf-8?B?NVJkVU5KOXdUSUJKV3dLN0lCZUczbkJpL0lPQmZqWDFlak11V0VTVTV6OXBH?=
 =?utf-8?B?aW1IRm4vckNveXJnaFFmNmtFT21WQUZoZ3hhR3F3S1ZjeUR5QXBHd3lBY3RJ?=
 =?utf-8?B?VXJYTzJJaDFmZGZKZ0tPaWY5K2Z2YllaazFtaUExQWhyZlRRUjFvT2RIR29Q?=
 =?utf-8?B?ZHhPVGZQVjFyV2tjVkpRbFBHQTdpZ3g2NHFZbUR3Njl0TER2eVRpWC8zMml0?=
 =?utf-8?B?Mm1zTHUxSTZaajNaWFBzUGVLbVdNWGxlWndRd2V0ZXJmc2ErYVEvNDgrSnR5?=
 =?utf-8?B?dmxsZjdJak5lakh6dlhleGpyNnM1ai8wV3BlUStZc0xheCtOcHA5K21vbkNa?=
 =?utf-8?B?QVNkb1hOTnlNTG1qajYxNnhuNVk3dzllTTVDOG16d2NnM2U5VHZ1MldMblE1?=
 =?utf-8?B?MWdORlBxc2xUaDhEZi9lTzRPTVJ2ZWJ0anpid0d3VTJScU9Lelc0V3dKb3lu?=
 =?utf-8?B?SVdYdEJISlZWeGRBVmYyVjlUOEJXS3dHSFJqU0h5UlhFaU14Q2FxQjR4VGI3?=
 =?utf-8?B?ZDE3d3NuQ0MycEYwZUUrcGVkRzcwVW5GbVhaUm9nM050U0t3TTg3UjZCbzBw?=
 =?utf-8?B?YXpQYXZ2SjRYYldQUUdqdTMvTy9LTXdsckl5RS9Lb2FESXo4aEtmdSs1aVNh?=
 =?utf-8?B?bEx2aWwyRmhFcm5LTW5ZMklmOHMvb01ObVhjVFpzZ0c3b0RzZ0FwZTZvNlFV?=
 =?utf-8?B?Sy94Qy8yUmd4cTRvM2RGYUltYWZQWTZIaGxILysrQ2I5a1pRZzRKVnZTOEdJ?=
 =?utf-8?B?WVhiNkZwWklESk9aODM2ZFZXZmZrL3JFT0Nlak1KWXVRdEtPQ2Fra212Mzln?=
 =?utf-8?B?dDRrQzhSK0xxVE9tOUhNMUhDcUxoOXNKWCtZVEtLUjJLNW5ha1JUU3pIdWNK?=
 =?utf-8?B?SjVMaDJicDJIeVUxNXpjSmFsMEV5bzR2K3ZaNjBWa2diSzhOdWo5M2dZSEgv?=
 =?utf-8?Q?Wv6+6q+hl7VuEk1a67LH4eI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F73A1482C2DCA54DBF0A9C909029FCBD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b021f81-719d-4d4a-063e-08dc3295e166
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 04:30:49.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXiPL1z2q4+rwNjcM434V4Pw3uG/lVvJYAY2+eyhkjeFa0b0GtLRB2rl1A+n9h+jSS9fcZB/MTWo33C6lE+S+rczK52NaCiWYV+FaUHgQPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4838
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDE4OjU5IC0wNTAwLCBTdGVmYW4gTydSZWFyIHdyb3RlOg0K
PiANCj4gSWRlYWxseSBmb3IgcmlzY3Ygb25seSB3cml0ZXMgd291bGQgY2F1c2UgY29udmVyc2lv
biwgYW4gaW5jc3NwDQo+IHVuZGVyZmxvdw0KPiB3aGljaCBwZXJmb3JtcyBzaGFkb3cgc3RhY2sg
cmVhZHMgd291bGQgYmUgYWJsZSB0byBmYXVsdCBlYXJseS4NCg0KV2h5IGNhbid0IG1ha2Vjb250
ZXh0KCkganVzdCBjbG9iYmVyIHBhcnQgb2YgdGhlIGxvdyBhZGRyZXNzIHNpZGUgb2YNCnRoZSBw
YXNzZWQgaW4gc3RhY2sgd2l0aCBhIHNoYWRvdyBzdGFjayBtYXBwaW5nPyBMaWtlIHNheSBpdCBq
dXN0DQptdW5tYXAoKSdzIHBhcnQgb2YgdGhlIHBhc3NlZCBzdGFjaywgYW5kIG1hcF9zaGFkb3df
c3RhY2soKSBpbiBpdCdzDQpwbGFjZS4NCg0KVGhlbiB5b3UgY291bGQgc3RpbGwgaGF2ZSB0aGUg
c2hhZG93IHN0YWNrLT5ub3JtYWwgY29udmVyc2lvbiBwcm9jZXNzDQp0cmlnZ2VyZWQgYnkgbm9y
bWFsIHdyaXRlcy4gSUlVQyB0aGUgY29uY2VybiB0aGVyZSBpcyB0byBtYWtlIHN1cmUgdGhlDQpj
YWxsZXIgY2FuIHJldXNlIGl0IGFzIG5vcm1hbCBtZW1vcnkgd2hlbiBpdCBpcyBkb25lIHdpdGgg
dGhlDQp1Y29udGV4dC9zaWdhbHRzdGFjayBzdHVmZj8gU28gdGhlIG5vcm1hbC0+c2hhZG93IHN0
YWNrIHBhcnQgY291bGQgYmUNCmV4cGxpY2l0Lg0KDQpCdXQgdGhlIG1vcmUgSSB0aGluayBhYm91
dCB0aGlzLCB0aGUgbW9yZSBJIHRoaW5rIGl0IGlzIGEgaGFjaywgYW5kIGENCnByb3BlciBmaXgg
aXMgdG8gdXNlIG5ldyBpbnRlcmZhY2VzLiBJdCBhbHNvIHdvdWxkIGJlIGRpZmZpY3VsdCB0bw0K
c2VsbCwgaWYgdGhlIGZhdWx0aW5nIGNvbnZlcnNpb24gc3R1ZmYgaXMgaW4gYW55IHdheSBjb21w
bGV4Lg0KDQo=

