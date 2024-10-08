Return-Path: <linux-fsdevel+bounces-31403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C93995B35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 00:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A64D1C22091
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87391216444;
	Tue,  8 Oct 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fga1Sraz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9F14A82;
	Tue,  8 Oct 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428144; cv=fail; b=nhZx9juUbThHy6Fs8gavDlZyA45nVjcERg11lQGyaqb0dACwiwk/DLuXYNgUv+TlBPcxkSHV9QEHd6jPsEJOWC1AG2UT9p3BhTEe1cz53VeO37BzBQVl/Zkt3YO2z6DR4072Q66L6Qqfy7KMxFau3WqPzxwqACwy4jrkVm22ZMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428144; c=relaxed/simple;
	bh=ntH3qQwQMGF/qtWw1ckeJLDPJtrUEsivYxp7Fwlojfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=epFb/r8Hc8hmPBWC+o7zi9vufAQUyk/VcIUbt10dUTd32u6XOcxtlgj1kOKmtJ55Isfqv8XPCy3B6OxYWP0UT7onicPThV+XaR0/MBHwxj4fYlRopBwjoqabEkIfEVugzZAhgA0nDzQ9l3b69Be5ISPKpbB+DAMx5yGabMiWmJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fga1Sraz; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728428143; x=1759964143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ntH3qQwQMGF/qtWw1ckeJLDPJtrUEsivYxp7Fwlojfw=;
  b=fga1Sraz0uRyHaYOixYdqqeRFc5ZTpQHoR8LHFAjCA+3aVXRjAd/GCz6
   /+1vJaWiHZdeN+fG3CN5pzO7WmxFTZZ7vTqs9Dt/ekqj9gSYME62ZEqvs
   4vIX2RcbDvxEY7Hzb9n6p1WYHzQO1StgNUdrARhpemSaLOnk80sa9O4Ct
   PKKrfFqW+Puhm3mOJdb5cyUDkln6n3uJeoxL94rq1o7kBLlV/DGiC3K+J
   knB9r5MzVmhP2sn78iX7Dy3RWgvMrZ2D67CMdO2whREO2clGwnJK6qFr7
   0IJoxx8g3BEkmhLtfB02ZKnFM75j9i2IWW9u//8pZkj7NdPGuo0G0G/N/
   Q==;
X-CSE-ConnectionGUID: YgCip+CdTlys+rrCIzS3mg==
X-CSE-MsgGUID: 1LPi9DrDTqGG7sd0S+OLdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15301101"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="15301101"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 15:55:42 -0700
X-CSE-ConnectionGUID: x/7DE7NNRCCTTpHAYfW5zA==
X-CSE-MsgGUID: 0L8awBwATpGt7EEctFSSgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106785472"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 15:55:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 15:55:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 15:55:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 15:55:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 15:55:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 15:55:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdeRqE0UmK97tK646xtWjHg3P0vlcX/RbdLh77/GQh3bNkoy2zfKYVuy2dejUt5MZHF2BOKkp1lERs4TlS3usBllYYWok6XRmIzvHkahoRun6v5FkzHBzju2cMT98a31E1HpSafpJc0Rh+XI/kDOC+Rmo+wDGkEwPzuYGtbCLbuxBTykzeWB8DgpZCa1NL9P+2FyqLmPGPWfRwbpOX4HPTHA/IaRkMERRS9dC41Gx8OshE6C3Heja6LciTfQj9EPczCz3yJ8Xlmbyk8DKJ0neUExtbE8GnDTCCKMXptzgyc6dgotEB8o7EEnQpbQ6ZW21tjOrHa/pH1IIvvFg3MimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntH3qQwQMGF/qtWw1ckeJLDPJtrUEsivYxp7Fwlojfw=;
 b=moHWKWpakPwMwFTTV1ECmyeaNxSQDJabt24zJ6RY43ty/tNGWVj84VWukXaxnJyL5OzCb43IAahxjr0cgyG6GbvNeFqajg9NNX/2O7Jee8U+g6TGfXA6/RVSQ1acnl0gPLvQx8uIMD7Bi1vJuPOtigksQZsTMhFJa5hKVFj7ZTXO7SA23YwUmHcEOFnaYfzJ9NCUczEisDEHOi+UAiUuRhhWwjmhmqPGG0gCJHVGCboWhxN8BdQW/MG3TDZtT9HbueqlNDtKs7GfaMlEZ/YRYO6ePFSDdMSnF8SzDUxBT8WW4f4nikdErD4zf5125HLZqQnG2UCBDkpM9OfA0Vm2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 22:55:32 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 22:55:29 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "corbet@lwn.net" <corbet@lwn.net>, "robh@kernel.org" <robh@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"brauner@kernel.org" <brauner@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "oleg@redhat.com"
	<oleg@redhat.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor@kernel.org" <conor@kernel.org>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "kees@kernel.org"
	<kees@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "shuah@kernel.org"
	<shuah@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "jim.shu@sifive.com"
	<jim.shu@sifive.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
	"cleger@rivosinc.com" <cleger@rivosinc.com>, "kito.cheng@sifive.com"
	<kito.cheng@sifive.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "samitolvanen@google.com"
	<samitolvanen@google.com>, "evan@rivosinc.com" <evan@rivosinc.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "atishp@rivosinc.com" <atishp@rivosinc.com>,
	"andybnac@gmail.com" <andybnac@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "charlie@rivosinc.com" <charlie@rivosinc.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"alexghiti@rivosinc.com" <alexghiti@rivosinc.com>
Subject: Re: [PATCH v6 16/33] riscv/shstk: If needed allocate a new shadow
 stack on clone
Thread-Topic: [PATCH v6 16/33] riscv/shstk: If needed allocate a new shadow
 stack on clone
Thread-Index: AQHbGdLZKp0M89bQgUujzl7/KIk8xrJ9drAA
Date: Tue, 8 Oct 2024 22:55:29 +0000
Message-ID: <aa75cbd142c51b996423f18769d8b8d7ecc39081.camel@intel.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
	 <20241008-v5_user_cfi_series-v6-16-60d9fe073f37@rivosinc.com>
In-Reply-To: <20241008-v5_user_cfi_series-v6-16-60d9fe073f37@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB6325:EE_
x-ms-office365-filtering-correlation-id: 067a9711-5079-4c6f-d989-08dce7ec4e44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?dXJGVEJZbkF3b3J2dlBDSUM2OUk0V3BwZXJ6UEtEVG52elRQVzBpMEp0MlV0?=
 =?utf-8?B?VUs4REg2MTRxV0daUGczREMxMTJkWkkzL0FwcnNZVHBtM1I1eTVWa0YxUnlJ?=
 =?utf-8?B?Ynp1TWhWR3YyU3BnK0pyRUNPRXFSZjExdHZCdjRGTDZYSzRsNHpGdW80OVRq?=
 =?utf-8?B?QStFUklJNzlMNER6L3Qxcy8wME95eGh2QUZiZTQ0N2NVZGZHbGJtaXpHK0t1?=
 =?utf-8?B?SkZ1bnRtUE9xTE84ZkVuaVZyZEVQakhYdlhRMXFuOU1MWGs3bHZiUTJpMTdu?=
 =?utf-8?B?UllML3U3Z3MvejZHanFTc3lLRHFaWXY3L0QwRVlRWWZMbFp5ZW9MMERFQUlQ?=
 =?utf-8?B?a0ZZa2wybWdra3JlQnB0eGQwOGV0aWpWTGxhOXJ2MVFNZ0FUQUwyUml5aDEv?=
 =?utf-8?B?SUtFOTdmZkI2dzd1Z3lKeWFyQU5BL2hyV1JJWFBmalprZDFETVFnR2pxbzhx?=
 =?utf-8?B?Y0dTQUxZK0dOVDhMQ3N3QTg0bThMaFlhbXFzU2xETSt2bkZCcVVIckhXL1k4?=
 =?utf-8?B?SWtiU3RTRVB0R1hzeEMvZ3UvekFSL2dMZ3Q3ZkE1QVNmb1ZmZkw4aU1EN0hq?=
 =?utf-8?B?NlRvaHVnS2NyRGlwdTBpZjM2T1I1R3dFRHEzRG84a0dWZFY0OE1obTREdWlL?=
 =?utf-8?B?RHUvc3Q3WVcvQTM0cmdNUkw4Z2phUk1DRTZ5cC9kZVhPa09pMU1NSmt4T3Ra?=
 =?utf-8?B?Y1VNN0U2aDNBM0Q2ZGpmNk1JdGVDTlpVYXBBQ2MzdGVtbHA1Z0JoQ0lRYlN2?=
 =?utf-8?B?SEo4cHlsY0Q4ZDEwNXg3S1dRRi90aC84Wjk2RGd6Rk80d0tBam9BZW5IMkJE?=
 =?utf-8?B?elRWVnEzMkJrQ2tSdkZNWSs1T1hNRkpDWEN6OUp2REpKWTdCMHV0Z0JUWWNt?=
 =?utf-8?B?WVNEcVFDMyswQ3FybXA3RmtaZFJiQzl6V1F0c3lwZWdId054eUlwWVB3elZo?=
 =?utf-8?B?QWdHK3c4N3dRckhWNmhQeGJ2N2tNNXZPZk1wL3pBUkZydnQwRE1JanRwVHdI?=
 =?utf-8?B?NjliK29rTWhnbWNpdGhzKzdtc2FHU3d5ZnJZK1VLcDZ6ei9TZG1OcFplQ0pn?=
 =?utf-8?B?ckpETERsbG1qZS9KSW9Ybjh1RDNxNzMvMXFsSEx0Z2o4cG5wY29KZUJoVkJL?=
 =?utf-8?B?OStUSnlNVC93d01LVEhXZnVEY3Y4UDZldGEwTzBsY20xOHI5L2hQMGxoYTE4?=
 =?utf-8?B?dEpKVHExT2ZPbnlkcHJJbmViWnZXMVNzanFJK0xUS0Q4ZGZpdnFhSGVnQkp5?=
 =?utf-8?B?bzFpTWM3TnczQlN3SGNNNER4amZlMVovTEpIMm5PME8wZDBJUU5ZU2tYZTg0?=
 =?utf-8?B?MFlrcTFETkZiUmN6VTBxME56QjdkL3ZVNUJkaUpxSU95MTBmYmlxZm4rc3RU?=
 =?utf-8?B?Y0tGck53aUJvUzd6emgyV0l3YzU2Z3ZpamFtNDdxNHYrTUl4M3h4Snhtbkx3?=
 =?utf-8?B?Vk5UY0QxQkRJK1JqUndid2t4cW0zT1FxZFBpeGxybjg1VVkybnh6MnFhTkxB?=
 =?utf-8?B?bGM3bmFUS0phTmtSRk16amVpVDZ1N3YyK1pCcStFSHhFMGtFbjFXYzFJZlhp?=
 =?utf-8?B?cG12d1lEVFp3cEdYc2ZzektEUWt3eVY3ZWNwV1RSeklyOVRYSzB6R2pvUERM?=
 =?utf-8?B?T1YrbFUyNEFEYXByL3NiOUFhaFNlQk5HMGt1TzN0dmFoTXE4VEgxODR3RGg3?=
 =?utf-8?B?Z1lKK3N1MmNPUWZiYXJNdGlBZG44bzdMbE9MbVRTV0pQTDBmUTJJd2xRVHAy?=
 =?utf-8?B?U2NXTUNXeDdDNTFackYvTGNnRFdjSUlSb241K01pY0tUVWtOU2VVVEdsWjFG?=
 =?utf-8?Q?1IbQFgJUgKGG7JDZhybb9dJV/5f4w7upgZrUc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmJWdkN2eTRMa25TUTllK1RNeTNlRGVjVWZPTGQ2RmE3M1NLZGh2N3F6czlU?=
 =?utf-8?B?akFnNm5aVVJpSmxoOGxKRUd1Y3Q5aExBY0F5OE5vYVQycjZaM2UyL2twRmFs?=
 =?utf-8?B?R1VlcXNaeWNoT2dsMStGQ3ozd1lrMGh0ektIOWl3Vy9CMHhFL0xsMzcwOE5M?=
 =?utf-8?B?TFdMYSthWHNLSzh6VDJpN3ZMZVZwUHFvWFlvUFVDTTJSWUY4ejZmSmhjVVFH?=
 =?utf-8?B?WFg0R0loMXErSHpPWEQrc013Mk80bjBYaW82Rkk3K0toUnIzazdzSTVZaGcw?=
 =?utf-8?B?ampCVHVDRWxCQTlJN0pNVDYyQ2xsd0U0dWRzTGNSWjJ5UHRBVDE3OXNzcXhh?=
 =?utf-8?B?U0ZUQUN3NFZ0c2hidlBMNEZxajRUWGZCblhzcVg1MGlVb05BR2QyeEdNUThU?=
 =?utf-8?B?UTJnZHNna1dLQ3JVbVVUTFRqQk1FeGN3REZjYm44VFhjL3daL0dWZVVSUlJn?=
 =?utf-8?B?bnU0WU11ODRwU3FWNEI1R0tpN3lESWc2Z0czc1hsZmZOWVlXdCt1Z2orSE9N?=
 =?utf-8?B?UGlIVlVrTTUrUlo3M0tyaGhQVFFBSDJyU09SaUNpaHE3L3NtTUJDQ1lsUW5t?=
 =?utf-8?B?QmRoT1RWQlFrMkdWNXNPdFJWTjYxT2F3Z1NIbG93VEpiTytKQVJhM2w2VFFh?=
 =?utf-8?B?RWZIYzU3NEdubEFqMHI1ekYvVm5BbWZ5SVpCU1lKRWFzVGZEYWVuWENHV256?=
 =?utf-8?B?ZHZkbVZFdUF4aWk3b3JhTUJJQjh3aWo2MnF6MkJJQVNlbU9UN0R0MU5xNUN1?=
 =?utf-8?B?c1Q4SEpuT1Qzb0JRM3dqYk5sRU9qUy94Y2MxTlQ2aGFhM1M3ajB5a2FEUXdD?=
 =?utf-8?B?STNBS2RaSFlKRDdFQTZlV2lpSndLOFhmNzY1c3d2Mi9pSmJraUl0UXR6MXR5?=
 =?utf-8?B?bzZ4OUhZbkhBYlpKSUh3K1duc2I3QmVRMU9YVjhJSWh1Um1TcmtHSkgxZE9w?=
 =?utf-8?B?RE1iYkFtNnlQbWNUVmdzbWl1K0pnaDRtNnM2aWtoaDdnbzRPUG5kVElKR2pn?=
 =?utf-8?B?cGN5L3BrdCttcXNqN2QwY0pLNXVTSkJ4ZWxrNHp3OGNqbzQ4dTI3QzJqVkVa?=
 =?utf-8?B?OHNtNnIwTlc1MHdSQXRNRzFROUpBZTN1U2FVL3pRUktnTGlpbml0WlhDaHpN?=
 =?utf-8?B?d1Nrc3BmWE9tT2ZkaVZITUxjL05tL2h5YmFEYkRjR1ZzbDlHd0dwS2tBQ05Q?=
 =?utf-8?B?aDBwemsxMjVieFNzdzRNZXhrUUhFRUdMSXUydXdJc2g4aFgrcVR4Y3ZTd0M5?=
 =?utf-8?B?YkdNN0FLSUpiY2RCa0UzU0hOakZtL2tsN3dabko1UWJtblNYNkkxS1BQekdN?=
 =?utf-8?B?QUlCaHA4Q2lWNkZTa3ZKNXNvU1p2MFZzVStjTGJobWhvS0prK2ovVG1SZjlP?=
 =?utf-8?B?NWZaYTJkbkFvVk11SjBzMURkN2hUUFd2K0VaRGZiYkJVNFVMNno5RDVHY1pD?=
 =?utf-8?B?VUo1RWRtcTFIeVhFN2FxckpzV01sNFA4SEVQNytiUlhCYithbERaZ1hXOFlQ?=
 =?utf-8?B?bkZJaUhkaHR2VEJxbHQ0NkV1d2N5UGdpbmRCVVZpS3BKbXVCL1JtVFpOS1VW?=
 =?utf-8?B?YnE5Q0x2R1RrQWVYblUvSVdYVDJSTDNFTDdMVFFBNlZjdzYvdXFqTVlFUWxI?=
 =?utf-8?B?UW96TmwxcG5BVmViTHRzY1RVcmxQVk5LNEJEN3QyZk5tM3c5TEFrZWI5bW1q?=
 =?utf-8?B?bm4xVzlaSXcycStOemVHMm9SQ2YvSkFPb3hjcTRVamM5a3A4SkFEMHBxTUJq?=
 =?utf-8?B?T3d3VDNBQWJXWUxNS1NWUXh6MS8xYTVuVkM5UWl5UEluRmExa3lkcWJMSWh5?=
 =?utf-8?B?TEUxWGVJQnNXTXJEaHNkeTF1RHhKYVg0M3NLZWNFUkMyRStHNFNUQ2dqS1Z6?=
 =?utf-8?B?U3lZVFpLbWZJMEd0NUQ3NEtoL0xkTVlValVmZHZQZHlQVHVVbG55amw3TnFY?=
 =?utf-8?B?bEVoQnIvK0tVZ3ZBR0xUdjBWOURWRXN6WDd5WTgxTHF5cmswWUYra2RzOHZz?=
 =?utf-8?B?aE05cFU5Ui85YVV1WTEwVHFiVWlTR0FuTUJVVTRGUkVCUHpZUnFuMnBEcUFP?=
 =?utf-8?B?ODR0TUQyclJzTTZSNW50cXovODFhMytRREJXbEN2MlpMRXl3KzdBT2gwZkE2?=
 =?utf-8?B?OWo3bm9MMDNIWUZoMVhoY1hiRlREMUtMNmQ1VkxWMy9uU2daRlNkRjBUWWxS?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66BCF30BD2546C49838D24CC550DC2F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067a9711-5079-4c6f-d989-08dce7ec4e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 22:55:29.0908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84YxJcfVaZe8hzlnhDGBf772Hb2KWgvwNUSRXI3k/Ldqx/Rjx75Y6P0AspRfzf9VvdKhNEF4bPHOBDVCcoJCWMQoSdW9WIt3tZaf3w4PHTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTEwLTA4IGF0IDE1OjM2IC0wNzAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
ICt1bnNpZ25lZCBsb25nIHNoc3RrX2FsbG9jX3RocmVhZF9zdGFjayhzdHJ1Y3QgdGFza19zdHJ1
Y3QgKnRzaywNCj4gKwkJCQkJwqDCoCBjb25zdCBzdHJ1Y3Qga2VybmVsX2Nsb25lX2FyZ3MgKmFy
Z3MpDQo+ICt7DQo+ICsJdW5zaWduZWQgbG9uZyBhZGRyLCBzaXplOw0KPiArDQo+ICsJLyogSWYg
c2hhZG93IHN0YWNrIGlzIG5vdCBzdXBwb3J0ZWQsIHJldHVybiAwICovDQo+ICsJaWYgKCFjcHVf
c3VwcG9ydHNfc2hhZG93X3N0YWNrKCkpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJLyoNCj4g
KwkgKiBJZiBzaGFkb3cgc3RhY2sgaXMgbm90IGVuYWJsZWQgb24gdGhlIG5ldyB0aHJlYWQsIHNr
aXAgYW55DQo+ICsJICogc3dpdGNoIHRvIGEgbmV3IHNoYWRvdyBzdGFjay4NCj4gKwkgKi8NCj4g
KwlpZiAoIWlzX3Noc3RrX2VuYWJsZWQodHNrKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwkv
Kg0KPiArCSAqIEZvciBDTE9ORV9WRk9SSyB0aGUgY2hpbGQgd2lsbCBzaGFyZSB0aGUgcGFyZW50
cyBzaGFkb3cgc3RhY2suDQo+ICsJICogU2V0IGJhc2UgPSAwIGFuZCBzaXplID0gMCwgdGhpcyBp
cyBzcGVjaWFsIG1lYW5zIHRvIHRyYWNrIHRoaXMgc3RhdGUNCj4gKwkgKiBzbyB0aGUgZnJlZWlu
ZyBsb2dpYyBydW4gZm9yIGNoaWxkIGtub3dzIHRvIGxlYXZlIGl0IGFsb25lLg0KPiArCSAqLw0K
PiArCWlmIChhcmdzLT5mbGFncyAmIENMT05FX1ZGT1JLKSB7DQo+ICsJCXNldF9zaHN0a19iYXNl
KHRzaywgMCwgMCk7DQo+ICsJCXJldHVybiAwOw0KPiArCX0NCj4gKw0KPiArCS8qDQo+ICsJICog
Rm9yICFDTE9ORV9WTSB0aGUgY2hpbGQgd2lsbCB1c2UgYSBjb3B5IG9mIHRoZSBwYXJlbnRzIHNo
YWRvdw0KPiArCSAqIHN0YWNrLg0KPiArCSAqLw0KPiArCWlmICghKGFyZ3MtPmZsYWdzICYgQ0xP
TkVfVk0pKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCS8qDQo+ICsJICogcmVhY2hpbmcgaGVy
ZSBtZWFucywgQ0xPTkVfVk0gd2FzIHNwZWNpZmllZCBhbmQgdGh1cyBhIHNlcGFyYXRlIHNoYWRv
dw0KPiArCSAqIHN0YWNrIGlzIG5lZWRlZCBmb3IgbmV3IGNsb25lZCB0aHJlYWQuIE5vdGU6IGJl
bG93IGFsbG9jYXRpb24gaXMgaGFwcGVuaW5nDQo+ICsJICogdXNpbmcgY3VycmVudCBtbS4NCj4g
KwkgKi8NCj4gKwlzaXplID0gY2FsY19zaHN0a19zaXplKGFyZ3MtPnN0YWNrX3NpemUpOw0KPiAr
CWFkZHIgPSBhbGxvY2F0ZV9zaGFkb3dfc3RhY2soMCwgc2l6ZSwgMCwgZmFsc2UpOw0KPiArCWlm
IChJU19FUlJfVkFMVUUoYWRkcikpDQo+ICsJCXJldHVybiBhZGRyOw0KPiArDQo+ICsJc2V0X3No
c3RrX2Jhc2UodHNrLCBhZGRyLCBzaXplKTsNCj4gKw0KPiArCXJldHVybiBhZGRyICsgc2l6ZTsN
Cj4gK30NCg0KQSBsb3Qgb2YgdGhpcyBwYXRjaCBhbmQgdGhlIHByZXZpb3VzIG9uZSBpcyBzaW1p
bGFyIHRvIHg4NidzIGFuZCBhcm0ncy4gSXQgZ3JlYXQNCnRoYXQgd2UgY2FuIGhhdmUgY29uc2lz
dGVuY3kgYXJvdW5kIHRoaXMgYmVoYXZpb3IuDQoNClRoZXJlIG1pZ2h0IGJlIGVub3VnaCBjb25z
aXN0ZW5jeSB0byByZWZhY3RvciBzb21lIG9mIHRoZSBhcmNoIGNvZGUgaW50byBhDQprZXJuZWwv
c2hzdGsuYy4NCg0KU2hvdWxkIHdlIHRyeT8NCg==

