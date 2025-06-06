Return-Path: <linux-fsdevel+bounces-50819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8BACFE07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A9B3AFB1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF1C285418;
	Fri,  6 Jun 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MLhOqaev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E942356BC;
	Fri,  6 Jun 2025 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749197540; cv=fail; b=laIiOxIkCWs4DIPAcFkxtR4PZFtS+3m4RSmDWL/jxkEM1mfwMFVeGfrhIHe06RT41Ksg9poNl1C4I87NL4INWlC7LWjV3oDvEkSkkWR3KtrbnxyyN15tpsxyQAmgh+Q5Tpj/tkopCrlhoQJul70u0NmglDe+osr5k1YGRv2Axu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749197540; c=relaxed/simple;
	bh=DiKZ5Y9BxjAz/LKzQ9dyy0uCT4+OwoGfZ7iGAfgwc9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ES4+bQmKnz6xLqLrbb6jstqguFu/MGUGko99/lqNBf4/aEVmg0BDuKGKmyfqlrmc9kJb+ftAAp6gT7voYLt1UfHo7e2sHbpUkWRbuyCG57KP+lWGXKtSLMS1QAUI6iREEzInZd7OAmB0Zm+RPIQV7i6wI/qFZIlE2ZDxhnjTp8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MLhOqaev; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749197538; x=1780733538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DiKZ5Y9BxjAz/LKzQ9dyy0uCT4+OwoGfZ7iGAfgwc9E=;
  b=MLhOqaevZR3zEzmoo3S/LU04T4RBFWWL2pZSyFD5lFMvrjlXir8gCIrb
   H5d2EoYs5rsImz7hDrf5Kk4WRKKl1l6YggUHmYPagkgUjGHymTwL+gCXl
   0Qzr8Av3AgV+UmB1MaVGTTjTFEOTySPU3RRxRRHreSWrn4+NBF3Ou1t0e
   wXyxw44RpuGto4wGyBHY75Z7UIio2bL39VKX6em2Gsc1wzXPnOGwKFG3Q
   x0QTXy5O4kUN30EMohhvIcuzOnSpxi4wTcEZDEF6gRBLc+a6YuiiNBx7I
   XeScg5k+3kibNDmkwbYTQcejbHBbGIEF+Lcfd9w+Dn+etdxJeQVjtVGuN
   Q==;
X-CSE-ConnectionGUID: JvAkAVIhSZmfiJZXFHRu4g==
X-CSE-MsgGUID: eA493DElSk2zUjlZlXosgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="158254046"
X-IronPort-AV: E=Sophos;i="6.16,214,1744038000"; 
   d="scan'208";a="158254046"
Received: from mail-japaneastazon11011046.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.46])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 17:12:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjALWM54sS8ang3FvsRu9isoOvxyjT2dK4nrnG+Zm34dHLYFBgdJgKFH5f4GesDO/q126eaFPMhFbX5qOZb1a2X7fT2HP9A4qDe5oFcQBNp4PJS9UREJ8MXw3w6E4dvkGN7jn3qF70GFhfKMhvY/xOh90GASJ5M4nLqmTKiiwarRxs68duFflFh7OT49FY2LsZJ9iDaJzkIG8gjg2/98t0PCTqNFMhHf60OAYh+uWDMCeQrJbQevCVkXIAeWjou/pjEQiQsjlwcM7/emLGvgKuP9wiyBDJZ0/l64kaxIK36kwO+WYbjfInzHQTPp7y7QNc0VeUgho4zPf1TxMX6OOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiKZ5Y9BxjAz/LKzQ9dyy0uCT4+OwoGfZ7iGAfgwc9E=;
 b=OndzOwcwC+m4FJD39aUca+MXY2r5irW/kPYVRtQ7UCeJEIKo3BjocqsbccIea4Po4dSziwPa7kgeLnrBDPWHu70JlLw6vH1Fjf2aye39Np4+wPgKW9iLVfMQOjXHWWWtuBuSREHvDuPsJaCmBdxHXb+C246g0g92VyVfnFifnrOEmPsyJmaO17Bx0ctmOOdKxfbKw5o50bTZWDfeafBc3AqFggS9tHF9glRaMcgFBbgsw7m6NWDtaAJKNmOdgNeaH/8d9zu2WJ+gvdnF1j/UlVD2Quqy0brn2ymbk54u6whoEZ3ly+3kzmWtOxaPr9MyMDtUUAKVyGcjIPQYiQGrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB11753.jpnprd01.prod.outlook.com (2603:1096:400:3e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 08:11:58 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 08:11:58 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dave Jiang <dave.jiang@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 6/7] dax/hmem: Save the DAX HMEM platform device
 pointer
Thread-Topic: [PATCH v4 6/7] dax/hmem: Save the DAX HMEM platform device
 pointer
Thread-Index: AQHb1NWxrk0YdlS8XEufitYr0YwgF7P0yzoAgAEAcYA=
Date: Fri, 6 Jun 2025 08:11:57 +0000
Message-ID: <c14260c7-666c-4612-a4a5-369aa1e47f8a@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-7-Smita.KoralahalliChannabasappa@amd.com>
 <f4b861fe-d10e-497e-b7d3-af4af9c58cac@intel.com>
In-Reply-To: <f4b861fe-d10e-497e-b7d3-af4af9c58cac@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB11753:EE_
x-ms-office365-filtering-correlation-id: b4eff23e-18a5-40db-847b-08dda4d1cec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWpORWwyaWhZdGxuY2tlR3VGL3llNEhKRnMzR0xKSWRmVG9FRGhPUHo0WWZx?=
 =?utf-8?B?c2hYRXRSWTBBTmJMZUxhSzVBb1hjMlpPVm5ZL2krV2hGdXhDYnV5RHlqcGpk?=
 =?utf-8?B?VEt5c1RjRmpsaDR2UzJ4L1hXR2hpWUxFWjU2SUthLzB5VktiVFdPV3oxNXlB?=
 =?utf-8?B?MXRuWlhxdnhxTnY4aFcwSTF6NVFOV3NPcnorKzNQZU5kbmZ2WnRXQllHOGo4?=
 =?utf-8?B?RWpmS29sSFN4RDR6ZHJIc0NCZzB6Z1FBQWhtRUY0eGZMVklyZDh3U3VMaXJs?=
 =?utf-8?B?VS9kWXpLT0h1dFdka2hiK3F6WkxPK2ZOcUdHMXN2UndVMXoxdkE5b2o4YVFF?=
 =?utf-8?B?Y3FuNGlvTlM1U0VvT2FZcWZ6UnJYZVpSVUMzMTdOYlI2MDdUZXk2M2lPZEJ3?=
 =?utf-8?B?NFRVY3lYbEZyUjdRNTAwbmJ2U0NjMU9LcXY1aEdLc05hZWlWUVZUbm5hQ1Jp?=
 =?utf-8?B?cDhtcFIxL3RYcXRlTExNNFl0YzNsTUQwamhham9WTkEwM3FYVHZRTVVVRFUx?=
 =?utf-8?B?Y0tncHhuWEFPalpieE02VHcwUVFIaVAxeDFMQ0xhQkw0cXRMSFVpWGxMMWh5?=
 =?utf-8?B?Uk9td0xpU3lnZy94K0Z1UUJKOUR6ZTlVUDg3Mm1vT1hRZGx5eTZzcG82NHd1?=
 =?utf-8?B?S0RoSm44WVkzUndMcjhyOSs0YUtkaHpRUUF4emt2QVFwbE5taTdXdEt2UFVP?=
 =?utf-8?B?cm5tTXB3RGJ3WkxRYVRMTEg4dmdIc0tZcE11eGJ5cDhWNmFPS2J3a05hVXpq?=
 =?utf-8?B?SGlNQ0h0aHg1YzVic3NnTkRwTU1pcVFLbEhLUkVDSFk5QWlPT2ZWT1c1V21P?=
 =?utf-8?B?UFlyVGlPVzExc0RVVWZsTXBrYVd3MHYwUWxENHl5SFgrZUhOVVh4WTE3Rnh6?=
 =?utf-8?B?YzZMVEcrYWNTekJaUjZaOGp3dDczd2dpY2dLcjdLUUl6VjNmclkreWN2Q3pC?=
 =?utf-8?B?SWYydnhNUDRTeDUvRGloWmYyTldyQ1R4eVB4VVJpMXhzcW01dVc2NzU3NWc0?=
 =?utf-8?B?S2s1aysxaXJYMWJTN0djNkNDU0VwR0d5ZVhFZEV2dWwvN2V2S3U3ajVNOTVp?=
 =?utf-8?B?THNyNHZ0eHUydE5zSHlDdFJBYk5PQmdPWVNETTZFNmo2ajhhZ01tNzViejVL?=
 =?utf-8?B?UStJalEzbFBtOXBLemkvVU9VamFmbkFFNXNvUWhZaFlxcTJCVVpTRWJBQ2Nv?=
 =?utf-8?B?L2hUZ3BxNGJZcnNlYmppMysvb2g1dTRwZXYwRk0zZ3hMWndxRjVSWlZjWG95?=
 =?utf-8?B?ckhqUTBYK0grMVc2eHNPOXp3TUZFZmFUZHJwTmxHc2lDcDBRU2NiVVYzeDdI?=
 =?utf-8?B?UUJTbVNvNDYwUHMrNWpNUERuUFJ5ZEZsNXM5LzhQK0tjK2Q2TzU1R2UyMlRS?=
 =?utf-8?B?bklmS3NjY04yU1U3cVc1d1lXeTBJR21EZG9wQ044M3I5K2hzS1AzVGdHbU1F?=
 =?utf-8?B?S3YrcUNRWmpXOWNYekRuMjBSQ0NsZGdmQWtIc2J4WDZ3OUtQblNEMVNjTTRE?=
 =?utf-8?B?VlhaaUU4a3pIOHFpR2NnVTZkU25XSFdkbEwwdEN0TE1UVlBhM2JnZFpvWXZR?=
 =?utf-8?B?T3hkZS9NMkF1OFBTbWx5RmlEVEdxT09yT3JwQkU2TS8rNlR5N0RxakxsZFFK?=
 =?utf-8?B?OFFkQVp5d0NtamdRbi8xTFR6ZjdZZmV3S1VQMldkS3pjdDVzM0t3S00yS3ZE?=
 =?utf-8?B?VmxWMEpNbzI4a0UwVHVDN1lkditMdG9Eb2I4VW4rbDRaaGJTS3J1RCtsTlpR?=
 =?utf-8?B?WEM2S3pnZmZXdEgzNHk4NzBZRFhIZzJmUUJsQ1VPYXM5cU9OdHB2OGw5L1Uz?=
 =?utf-8?B?dXdsblR1bzZ3T3ZUZXFKTVpWaFlvQ2xwWDhoNGtvckcwazcwWXJScS9SREV0?=
 =?utf-8?B?aUtWdVUzWWV4RG51NjZldDJ6OUxiTzVyWW5lKzVvSitZaURwSUNRM1A0ZUha?=
 =?utf-8?B?aCtQZ2pzdzRITzNMNGJQNngwU2kxOTk5cDNvTlNrZkRqRlpBZjhIRXZiTzNO?=
 =?utf-8?B?TGxxeVdWSVFzTGpSeXVVUzh2WEE3dURvc3ZWdFdmREl3T2lJVktjS0MvU3RB?=
 =?utf-8?Q?S6KDsZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1cvcVRiMGxnL21BeDVTblRnNVMybElTdmg5eWF4MUh4amg1VXY3Qjl0WWRm?=
 =?utf-8?B?ZWE0SzN1USt4Z0V2OUNtZjlDZkZSWDRLL2JIZUFoZ0xOQjNYdGN0RTZrdVF5?=
 =?utf-8?B?cUJjVXNJdE4yTUkxcUlKV0RORXFVbk1EZjBRUmp1MVFzVDJOYUhqT01naXpk?=
 =?utf-8?B?MnUzSzRZVzZ3eis2bzd4bm5wQTAxT2pZTVNENklTcVhWWVowNXYxWlBrTGVO?=
 =?utf-8?B?Q3hFS3kyS3B3S3FqM0VMODFyYjVnVFF5NUNQN0FFSVY5VDFtTzJUVm9STGZD?=
 =?utf-8?B?dFRsY1NXbnVwUTZ3QmhwcHFic1BmQytQU2U2dGZPd2xRM2NEeDJKWHVINEd0?=
 =?utf-8?B?OGFIWXM3VmZIM0hvVzZzc0RSdGZUS1hMZVNoYzJXWlpIREdncGo1cjU4QmFI?=
 =?utf-8?B?Q21FY3BTUTJNMFJWejNyeWpzZ2xXRGttdFM1MUpMQjY3WVF0S2tNTU9INjZT?=
 =?utf-8?B?ZTlURTBIYnJjZnlGS2FjNVkzMFBBWm5kbUJXMlUyRmVRL3MweWhqY3oxeTNh?=
 =?utf-8?B?YmVTOVhNVjRVUHNBbUI1WFY5cTI5REhOQ25za2dxYjZoT1FPMExIMTBrMk55?=
 =?utf-8?B?VjVVL2YweFpMTjh2d3JvUzF5TlR5ZzJ1MXNaOU5FOXllU25EcU5meGkxVW92?=
 =?utf-8?B?U1Uyek1LZm5oeGNvaFUvNUNJdm41Nmx0bnJBMUtOVmZDd243S1V2SktZenly?=
 =?utf-8?B?d01LWHg4YmErWXkwenRzL2VkN1N4UVdzclB0R2xxdWNaRkV6aDBkYTA3d0RM?=
 =?utf-8?B?RHRtUjZuTnYzbFFYUi9LVjgwOW00S2p6U05HeU9iU3FrbGllY3Yzb1VVRzdm?=
 =?utf-8?B?QVlMaGJKWCtHMC9uMyszOXYxMjJyN29sZC9rVzJOdkNvQ3ZKQm1LNGl5VHhq?=
 =?utf-8?B?Mkx3dm5HSDc3MzRvY3c3eVA1emYzaU1nOXdNVDBqZWFkYzdKTGlEYW0waXow?=
 =?utf-8?B?a1A3VFNJN1pPSU5KQUxPSFI5QzhxancvVWhBcXJIVDhxdkZwL2ZoeG9SdDJI?=
 =?utf-8?B?OFV2TWMxcW5TT3o2NXJKNXpkeFIxV0RyOTNRSEJXUHViTjFsT0dPcDYrbkVy?=
 =?utf-8?B?WDJYZUxoNGhOQmRGaWNrMjdNLy9tdEVnMXYweTFoZ1VqY1lqOEVqMFNKbUdr?=
 =?utf-8?B?QzlQcW0wYkQ3SnZoMGQ3cU01L3RIeFpJNmtzQnpzdGtnaTFKdVpZdlR4UnlC?=
 =?utf-8?B?N3hTNDNCbjZTSTNQZlBWL3NjZ21PaDNPVDc3cU9VMk1PY0FmZHFEakVnMzA2?=
 =?utf-8?B?RkhFajR3ckt1VjRnaElaK2s4bkYzNm9xNHNDNVpQcmRWTTB3b0ZaVFp4Qmhy?=
 =?utf-8?B?OEF5K0ppdGphMXlhRGRpN1hndFBUVEpQTFRGaWlPUlh1OVZyaUJ3SExIRjhw?=
 =?utf-8?B?MVRvZlFOUEtobWh6bEtpdE4wU1RtSzBERDJkdUgxY0FsWW5tdGhWcFJieG1z?=
 =?utf-8?B?ZGhNQ3pvc0dPczJRWEVuNmtiZy9Uc0Q3TUplZGxXejRJWnZMQ0Y1M1JZa01B?=
 =?utf-8?B?TmIxWWxpandVQyttVmNYVnFMU1RKRnRWNWJoUjZRQzJJYW9VRkJNcVpENVlt?=
 =?utf-8?B?bHBSM3gyaUllNmRJRy9tY3ZXaS9jeXhEekRySE9aYTVvR2NNV0IzTEgxNEJG?=
 =?utf-8?B?dlRDNVpVY3NDdjExQUVnUHB0ZjlHZHcvUEppL0N3SzZ3YStpb3Z6QjRNeURh?=
 =?utf-8?B?Y0l3MlVaR3RidCtVODJrM2t1MjZaVDRwblYzZ2RxRFg1eVZFenNSYmFmbkNi?=
 =?utf-8?B?QkFELzNYTUMzbWpNMVZyZ1lHd3p1eWtwU3VzVCt1YVhhYlp2eDFmUVRuc04r?=
 =?utf-8?B?UjhwcDR5YldOUkJ6U1FoWUxOWWpSa2MvcDd5MFBmMU51L2xmaTcxbUN1NThy?=
 =?utf-8?B?OUtwRXZVblh0MDJsVmJ4YjBtQWtudUdJR3FSaWVkRFcweC8yaFRvUk1QWlpq?=
 =?utf-8?B?Zzc5UitEdCtWSHFYTlp3cVJpT1BTV3cvem01MmV2L1FVQ2xEVDk3V3o3ZCtr?=
 =?utf-8?B?NmNZWUJCMURvakhaL0xaUm0zRURramxyMG0xZy9tT1FPV0tNK3gxQWRLVWRW?=
 =?utf-8?B?L1lVTkFLTEU3Lyt0bExNWUw0NXk5TmJuUFZFTXpLRDB3cWZDakVMVnFYbmVM?=
 =?utf-8?B?U01ZZDY3Rnk4T25tQVFjRGQyRnJpL2g1NmZ4M08xNmdwZVZmN0F1Rm5oVTh4?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <214E62CC2D96F145A1F8C3C6A1C7B1CB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/3L4zRgt4XTYtWkF2V7yp3EBarZpcFRCC4pqbD9tmJ4qxcoMEyWpVoPXYSM+ZN8xAZjiSc8KEtM/dutfFZMS7TaQ+s+31ZBh3hmKF8cGxEYs6ED4YP6RSlr/c34PjJlu8QanWsj+XAKmlkRcgZQMx4QSO7xG8561nBF+jfdw96Yi7hiAXJz3xdnRoaoVLbiOvWKXk2injyMOAFU861OgtHGRIa+XHB8EJdIbq+w5JwlphW0Wkscdj72Z+gG+HryowuTt2P5wfQH+C+64lq7Nm0g1ruj0aGgghWH4FCBBzAuNYXLDcqcazQe/Z+wrfcE5zO2CZlddlnK0/cIe7jiQG/abtiZMHQ3fwwT4sfo2sTtnEs6Q1SJOIg6zhht9OKrzZbgZ/uIB+XV11XBB/PMWuZ4ejIDKX1BAsK55/Mg/EZhmwfwQfVIS6BLBws23qKGpekGlt1R/c4gwrK9RNs/rBeZjbBog4V7+aCgnHff6oncF2T8LYiXpYfS5FXezAqNDJawVr8kmK6VwYZfL8vGCz3ycvejF7S38B/yomZaWi7w9nKaeYU7qRia/e1fO3Qaf4s/AngbObptda+9feR9xlvCBuiN7mJEiOIPSMFX0NIJZQZHaZV8XdxjbI7gmA0/p
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eff23e-18a5-40db-847b-08dda4d1cec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 08:11:57.9911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9mlqdSVOb96zSb3dd3qa41y8KJl5S1eOHytK9lgTVVO6ODmAFgLdEbLlCeyV+avkePdDEGGmnmjQmgR21TMJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11753

DQoNCk9uIDA2LzA2LzIwMjUgMDA6NTQsIERhdmUgSmlhbmcgd3JvdGU6DQo+PiAtc3RhdGljIGlu
dCBobWVtX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3QgZGV2aWNlICpob3N0LCBpbnQgdGFyZ2V0X25p
ZCwNCj4+IC0JCQkJY29uc3Qgc3RydWN0IHJlc291cmNlICpyZXMpDQo+PiArc3RhdGljIGludCBo
bWVtX3JlZ2lzdGVyX2RldmljZShpbnQgdGFyZ2V0X25pZCwgY29uc3Qgc3RydWN0IHJlc291cmNl
ICpyZXMpDQo+PiAgIHsNCj4+ICsJc3RydWN0IGRldmljZSAqaG9zdCA9ICZkYXhfaG1lbV9wZGV2
LT5kZXY7DQo+PiAgIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Ow0KPj4gICAJc3RydWN0
IG1lbXJlZ2lvbl9pbmZvIGluZm87DQo+PiAgIAlsb25nIGlkOw0KPj4gQEAgLTEyNSw3ICsxMjcs
OCBAQCBzdGF0aWMgaW50IGhtZW1fcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmhvc3Qs
IGludCB0YXJnZXRfbmlkLA0KPj4gICANCj4+ICAgc3RhdGljIGludCBkYXhfaG1lbV9wbGF0Zm9y
bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICB7DQo+PiAtCXJldHVy
biB3YWxrX2htZW1fcmVzb3VyY2VzKCZwZGV2LT5kZXYsIGhtZW1fcmVnaXN0ZXJfZGV2aWNlKTsN
Cj4+ICsJZGF4X2htZW1fcGRldiA9IHBkZXY7DQoNCj4gSXMgdGhlcmUgbmV2ZXIgbW9yZSB0aGFu
IDEgREFYIEhNRU0gcGxhdGZvcm0gZGV2aWNlIHRoYXQgY2FuIHNob3cgdXA/IFRoZSBnbG9iYWwg
cG9pbnRlciBtYWtlcyBtZSBuZXJ2b3VzLg0KDQpJSVVDLA0KDQpSZWZlcnJpbmcgdG8gdGhlIGRl
dmljZSBjcmVhdGlvbiBsb2dpYyBpbiBgX19obWVtX3JlZ2lzdGVyX3Jlc291cmNlKClgIChzaG93
biBiZWxvdyksDQpvbmx5IG9uZSBgaG1lbV9wbGF0Zm9ybWAgaW5zdGFuY2UgY2FuIGV2ZXIgYmUg
cmVnaXN0ZXJlZC4gVGhpcyBlbnN1cmVzIHRoZSBjaGFuZ2UgaXMgc2FmZS4NCg0KDQpIb3dldmVy
LCBJIGFncmVlIHRoYXQgdXNpbmcgYSBnbG9iYWwgcG9pbnRlciBpbiBhIGZ1bmN0aW9uIHRoYXQg
bWF5IGJlIGNhbGxlZCBtdWx0aXBsZSB0aW1lcw0KZG9lcyByYWlzZSB2YWxpZCBjb25jZXJucy4N
Cg0KVG8gc3RyZW5ndGhlbiB0aGlzLCBob3cgYWJvdXQ6DQoxLiBBZGQgYSBjb21tZW50IGNsYXJp
Znlpbmcgc2luZ2xlLWluc3RhbmNlIGVuZm9yY2VtZW50DQoyLiBBZGQgYSB3YXJuX29uL2J1Z19v
biBmb3IgaXQ6IGBXQVJOX09OKGRheF9obWVtX3BkZXYgJiYgZGF4X2htZW1fcGRldiAhPSBwZGV2
KWANCg0KDQpzdGF0aWMgdm9pZCBfX2htZW1fcmVnaXN0ZXJfcmVzb3VyY2UoaW50IHRhcmdldF9u
aWQsIHN0cnVjdCByZXNvdXJjZSAqcmVzKQ0Kew0KCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXY7DQoJc3RydWN0IHJlc291cmNlICpuZXc7DQoJaW50IHJjOw0KDQoJbmV3ID0gX19yZXF1ZXN0
X3JlZ2lvbigmaG1lbV9hY3RpdmUsIHJlcy0+c3RhcnQsIHJlc291cmNlX3NpemUocmVzKSwgIiIs
DQoJCQkgICAgICAgMCk7DQoJaWYgKCFuZXcpIHsNCgkJcHJfZGVidWcoImhtZW0gcmFuZ2UgJXBy
IGFscmVhZHkgYWN0aXZlXG4iLCByZXMpOw0KCQlyZXR1cm47DQoJfQ0KDQoJbmV3LT5kZXNjID0g
dGFyZ2V0X25pZDsNCg0KCWlmIChwbGF0Zm9ybV9pbml0aWFsaXplZCkNCgkJcmV0dXJuOw0KDQoJ
cGRldiA9IHBsYXRmb3JtX2RldmljZV9hbGxvYygiaG1lbV9wbGF0Zm9ybSIsIDApOw0KCWlmICgh
cGRldikgew0KCQlwcl9lcnJfb25jZSgiZmFpbGVkIHRvIHJlZ2lzdGVyIGRldmljZS1kYXggaG1l
bV9wbGF0Zm9ybSBkZXZpY2VcbiIpOw0KCQlyZXR1cm47DQoJfQ0KDQoJcmMgPSBwbGF0Zm9ybV9k
ZXZpY2VfYWRkKHBkZXYpOw0KCWlmIChyYykNCgkJcGxhdGZvcm1fZGV2aWNlX3B1dChwZGV2KTsN
CgllbHNlDQoJCXBsYXRmb3JtX2luaXRpYWxpemVkID0gdHJ1ZTsNCn0NCg0KVGhhbmtzDQpaaGlq
aWFuDQoNCg0KDQoNCg0KPiANCj4gREo=

