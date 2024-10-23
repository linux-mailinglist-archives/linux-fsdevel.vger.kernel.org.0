Return-Path: <linux-fsdevel+bounces-32682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC4A9AD583
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 22:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1C0281036
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 20:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014191E2309;
	Wed, 23 Oct 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dj8uxvmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB175809;
	Wed, 23 Oct 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715541; cv=fail; b=OdckReSVr4TycgYbU14yjK56hnm8xTkWQuqMF2DXX5p8tFRXlWBG6EIPT6tcQi8vSTLVdIwG7im49Kq54QodBtbf23/r03BDnSR9r6voy6oWadtTqkW1FTRA8rpB6wOaMzpP7gykTC9e4jyijGHWgP5Ka6ssNOxhBpEp1nF2T/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715541; c=relaxed/simple;
	bh=k1eXI1X7sARrFVZqpYAXE3oG8Gtsvpif4MWwvUcoPbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lmBhYPQglfp/rc1rJfezHdzRZpWn7rUu5hgcOiKxoPs/OtQU+fcywZmJU0eByterLPOgpNvI1CyYo0vuyvsTyWNoBH/eGECcWZcANqm3XQ/5D2B4p2uFSEF0R+EnLU25T3doTH+DEJ+ELMgWNlh5acEhm6zM96oHs8elFB2OH7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dj8uxvmQ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729715539; x=1761251539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k1eXI1X7sARrFVZqpYAXE3oG8Gtsvpif4MWwvUcoPbE=;
  b=dj8uxvmQyn2xf5GLyx1XwpDQkjGQJ7mVspjdJwO7B54HzSemYdOd5Kyo
   vqM+lHpe8z4WhO80HMO7nRZJEAKLWlA63Mo21Uh3afrwOLVD/4WU2DQ9o
   xyNn3Qd05roiTGWcNmnW6wfdN3TDM2adbL5aRmIvr7IQqHXAQmYJlAfvQ
   6yfnNRdmK5ceYdh6Za5lxkNJ/6iYVlOUO6XoaZ+MIgdNIPjotAxTzO3I7
   eVvSxnvF1EyddtY0vZafFfhOtlaAI/eP8/sflolGroKe8M5RTK6Z2E6l9
   UMsoaInoCQbj8V6xijDxMNbHN2cclJudJ4wzYatPtkUrHOwNzReQ7Ln3U
   A==;
X-CSE-ConnectionGUID: wgUyB+fGRQWWILcHUmzDtw==
X-CSE-MsgGUID: Ic6TEHvYRweCuw+T3Rta0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33017063"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33017063"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 13:32:18 -0700
X-CSE-ConnectionGUID: zH4Im51dReivlJjK1oRWLw==
X-CSE-MsgGUID: ae4oJGIlR56EDdO5Ca2M8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="111177289"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 13:32:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 13:32:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 13:32:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 13:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlPD4+UfEoqU17H0jkkj9KBKj9tTTFBhW+TlwFLH3pxQBIxW8Z56bOcb432EDkQzaSIFCDMR7OAYmfPvIImJ9eDrvxPLlTt09icSFulfzDDGCknF+D/dY5GJVwbqF2Bb7tKj1DJwjj3Etcg+OZzM7cGgMGTebMs3tb8SEiyMipDaS7Ky9jhwMdsyPJrvaAAbsNDk7bzMMnPXpCVaEeSGPtdeQ3wrkZj327CaBTgYIWQIz5xZrriN9GRGoWu1LxZzCG0rrmFT/V984GKIBSXilsENQMtA36Y81cVZP/rWH0cbGECTfEzggCKNWUKmD8BVh0HqNFsk+yl9aM2OfG5Prw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1eXI1X7sARrFVZqpYAXE3oG8Gtsvpif4MWwvUcoPbE=;
 b=fNl16fLLoZpoJFPu+hBDTf6nC7A7liB9C+1gO/weo0sZcMczFqI2U+MnJO/zAp16pliALYtIi4sP4wQJQEXflcEGmBYIWXHevmKqFlgUItRA8faecHgIEAIMXO3svNsxNLsSZkQYqQ0vxT/SWlANgEucmsLd37hYXPaP1pqMzqosdceo4XXMNzzN7RHt48zgsEzFDFUqXOBcR+o9RtoHvXEBl4tK7fhzYGdOV3XJQdhnE/Rtg9PYNYhd63jHKkzl6zvBV/Q+JO7/HWAR+WJklniNEOdSdW/T2VAB8KK92IkOwHCiwsiAcoNz02KklAOQnYm/Iv76FW/142EkE4TigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Wed, 23 Oct 2024 20:32:01 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 20:32:01 +0000
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
Subject: RE: [RFC PATCH v1 09/13] mm: zswap: Config variable to enable
 compress batching in zswap_store().
Thread-Topic: [RFC PATCH v1 09/13] mm: zswap: Config variable to enable
 compress batching in zswap_store().
Thread-Index: AQHbISi8rWXrArXvWU+XZylbH3mRtLKTiKCAgAAT61CAAQ9NAIAAJp4w
Date: Wed, 23 Oct 2024 20:32:01 +0000
Message-ID: <SJ0PR11MB567818A4A3DDDB28C0108CCAC94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-10-kanchana.p.sridhar@intel.com>
 <CAJD7tkbXTtG1UmQ7oPXoKUjT302a_LL4yhbQsMS6tDRG+vRNBg@mail.gmail.com>
 <SJ0PR11MB5678D24CDD8E5C8FF081D734C94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYAvEVK9o4Nt9qdn_2sN+rNwD9yuqNJ5jKsTs8257naFA@mail.gmail.com>
In-Reply-To: <CAJD7tkYAvEVK9o4Nt9qdn_2sN+rNwD9yuqNJ5jKsTs8257naFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DS0PR11MB7957:EE_
x-ms-office365-filtering-correlation-id: ce36b3cb-b69a-47ae-1453-08dcf3a1c00c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Qjdsd2xQeWg4RTMyaEtMbG1Pd3pKSitWWTM1V3JlaXpHbU56L2hCWUlmaC9Z?=
 =?utf-8?B?eGNOSWJPK0xVYVRhNkpVRG1SYXJlSy9BS2Z2aUF3VWZiK1RkNFNFc2p0M3ow?=
 =?utf-8?B?UkxVZWlpMmR5emU2WHVDTVh3amEzT2FqMUQ4OHBNN1VrMjVZL1NQcVVkSThI?=
 =?utf-8?B?R1phbTlxaEJuQWlzV2U0QkEyUTIyOVlSdHlRKzRjR0diY1hmT1FvaUY5RTd3?=
 =?utf-8?B?Mi92Z2IwMEZvT05ObU1wekNSKzZtU2NTSUNwVWNBSU94ejRscmhnbW1Ydlg4?=
 =?utf-8?B?NW93dkJwTjI4Vy9uNmd3Tk5kV1hKM3h1WEVZYkxkT045am1zcWt5NXh0eG9o?=
 =?utf-8?B?SFZ0Q0NCaEREejVmNGlmc3BiYlUreGkvWVM5SjY2NDc4R1dROUQxeVh6ZG5H?=
 =?utf-8?B?VGdZb3JZZVdiMXFLV0dmdzc4d25ScDJaMlRRV0p1NjV6cTQwMDFTNmtrQUIy?=
 =?utf-8?B?ZmxiVGdEV3Eyc1l4K0J4T21Rc2VGRUhzVUV6WVBXWG1yL3cvWG9hS2FFK3M5?=
 =?utf-8?B?QU1aaXp3MlRWZmRwOEdQamNRT3lQeitXQUhTT25sOUM2T1ArcFkwZVRUdTkr?=
 =?utf-8?B?emFaNGZYM2huTTJFcUJlei96WTduTHZxR2NWOTRZTlZxbThPMy93UDhNN0kz?=
 =?utf-8?B?U0VlZHBMeHIreFdINCtqYWdQdXlQSzBxOWlST3k5R3hlZVdJQnVWSGsrQnl1?=
 =?utf-8?B?SmxJQ3BlRVBqaTk1cEp5UzFRMnBXMFhZdVBVb0NKVGxuc01NQ0FLNyt0UUVW?=
 =?utf-8?B?djVGR0F0V2NueXB1OFB2eVY3UFRSRkJpdjRielptaVYyRzNPbGNjcGVoYkoz?=
 =?utf-8?B?ZmN6dCtnTG0rTno4OGF1bUZUaTRHUC9SNkJzb3JNVDRnUmtkSmpxN0dlOHl1?=
 =?utf-8?B?NVRhTW9oY3BWR05QZThIY25DYnJFeU00Y0VNU3lEdnhaY2lkbVlZQURSbFZz?=
 =?utf-8?B?TFJPM2ZOd1daTDltNHVWWVY3a1NKbG1wRWlQUkJWU3lrcEkvV2ZCbzhvRm5l?=
 =?utf-8?B?V01qRjhwUzcxU01kbndISjhueThvWTNDUzdsR2c1c2NoWWdTU01MMDJnUk1J?=
 =?utf-8?B?U00xa0EyOEtDTTZHUzNycHcwTW1hZVphR2xaaHYyWis2K1J4ZW9uMWxqdEJq?=
 =?utf-8?B?VHNwanY0Y2dCRjNBT2llbEkzZEpTeFVlNWdxbW82UU5hSHFTYVovMVNoNDhB?=
 =?utf-8?B?ZldvWndzbVU4dUtaTEJ4Q2tnTDBjRkRwc1J0ZFA2ZnhhKy9ScWYxQ2JldTVD?=
 =?utf-8?B?U05ZMDJEZkIzVkRYaTBodXY0UWNXTEpmYStRNXlYSFlFaW5DNWtOY0ZLYitE?=
 =?utf-8?B?OUdtc0VxdVZMTEtnY2lJYUVKVVBBaTdqckZoNFc5alVMZWk2TjR3TUdmckJn?=
 =?utf-8?B?Z0U3aDErdXovZGcxZjV0TmxacUlJbnFYcmZ2YWQ5Vy9CSjVId3NRYWIySk10?=
 =?utf-8?B?ZVpWVXFmVHBrdlhtTzlaTTZsZFJDSXZCV3BtUFlnLzJqVkcwVjZlWFF3QmJX?=
 =?utf-8?B?R050SStlTUN2TlRmcHU0cUNRVm5scWF0QUQ5L2xQbE40WTg0U2hobGxYK3F0?=
 =?utf-8?B?NldSS2wzUTBzVVhOQm5wanRxYjZNSFBVRExSSVBjVEhKQnJqVURlOG40S0ZX?=
 =?utf-8?B?SktReU9lb0d0VHVzdEdmVzI3YWI4b0NIdHJPMmtMcHNCeVFGMWRqaFM5d1NX?=
 =?utf-8?B?alQ3MnFvTVVBVGhHSWVKbDRvcjBhQ29CbzFsRHFwT1ozcVFXSC9STUExSlVw?=
 =?utf-8?B?TVB4LzVQYWFOUklzeHJ5RG03cWlWZHJTOWRQTmlDeEVaZjlJdHdhQ1hPWDNF?=
 =?utf-8?Q?pKgW/4E1HnOG3Iy8r0hJnm0kYxZwUG+Q8VAXk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUZUL25IaWQ1NW5zQUxGUi9wK1E2dHNQZ0lENXQ4NTdwTFlnZjRLMzZSMnFH?=
 =?utf-8?B?UHJlYUI5ektVdXYzaGwva2tRMW1rSXNIY2kxQ1p3ckhmQjFoSDBHbkdWell5?=
 =?utf-8?B?cTR4SGh1WkNxMEJjbGZxdXZXMzVwZUx4R2hZcGs5ZEdQcnJqOEpDaENxWkVh?=
 =?utf-8?B?ZS9IY2VZd0UyTERyTTBOUjRlTUpsUzBoV3cxNXlRd21hdm1iS1BzajUycmlx?=
 =?utf-8?B?N0JzV1VFbWFXUGtCMHZwVGU5MG9mUyszcmhLU0syUXhaemszSGxsUWZpUk9F?=
 =?utf-8?B?WStYV2RqZlMySVplOGM3WnhFd29yL3YrVFJUZlozdmVnaEdXWlAwN2ZuWTk2?=
 =?utf-8?B?cTlVMGpPOEo5L0trclR3QTFoWVg4VklzZE15UytqUXNvVHRlWDYzQzFWUEtC?=
 =?utf-8?B?WXBoMjdLdTJCaXRRc1QvSC9udi85Y2hoc2QxaEZmNjlGN3hIMWZrWjVQZnNK?=
 =?utf-8?B?bjRSRmVzSDc4ZkxpamhqK1NDNDNMdG0wSWRYb2NaUlRXbVZsU1lkRmQ2R28x?=
 =?utf-8?B?a2psM0t0MHZnV3VvbHhFOE1YeGxxZGJOTFRtd2FyUTFuVU41NkhYaEl2eURY?=
 =?utf-8?B?UE4zV2h4dXA5c2FCZE9kWVRhaGJ1QitYblF3SmpReDFhOHExNUV4eE1zTDlG?=
 =?utf-8?B?WTh3YjV4REk3L1R1NWFWYlA5Y2lXMi9rSmtDVSttTlluN2hsYnBDQWRmcGZW?=
 =?utf-8?B?WkxIQVhpdGRrZDJjUkRXdDBlV09EY0dmOXpUQUxvRWw2VkkxVzB3cTFJbFpW?=
 =?utf-8?B?ZzltK2ZlV2RkWVhvNm9mbWcySXg0UHppT0ZCUzFhVkNBREMzZ3hudmg1NUl2?=
 =?utf-8?B?SHNuU0Z4bWNBVHhURnB2VEhlbnk2NGg2VVp1WGxROE1EaGdjTzhWWEZ1R1h6?=
 =?utf-8?B?eHZIWmZva1FWTFY3aGYxSFZONjBiSEVzb21GRFhaSUdDSnRBODI5TkgveGhw?=
 =?utf-8?B?bHNZZDJuaE5jdjBVcXpmRGxhaHYwbkRITWpOa2NsVTBZeFNScTY0aEM5dStS?=
 =?utf-8?B?WmVHeGJ3YVVHUkhtaUV6YStLbUVmVVdCNWZUU2hQZEYrOGZIS3ZUWDlKMElC?=
 =?utf-8?B?NlZoYlBRbmxLdjFmWFJ1aU1lUHV5UHdkOTR4QVo5Wnk2WFFHTUlVOHQ1TnlI?=
 =?utf-8?B?MHZkV1ZZTWVvcGFIR3FjOGMvSXpoQVFNTDhsOUFMZWVkVnFOQnhHYmJRZkhP?=
 =?utf-8?B?eXBBTE5mUGxuZGIvODE2L0k4MnBOSmlXWm5TaVZ4Yzd1RXZoSUI0RU41ZGxT?=
 =?utf-8?B?R2ZRZHBUMmJyQlZtVmhmVGlNMmM5dTVMZ01UT1FNMy8xdEZNQ3pxM0o3Vzlj?=
 =?utf-8?B?WVV4aVh2Yk56ZHNZQXQ5WEFXR1FCbEhXeWtRQWNseGw1bjViZ1Q2NU12UHlP?=
 =?utf-8?B?SVpJajBzc0dPVGNQRmZJc1NpdVhKZGhSVi8zU3AzK003WkFBS05ROWlhTWpG?=
 =?utf-8?B?SzQzRnJreWVQbk5KLzdLekNUQ0MrQVYxU0ZqRlJZMk1DT1FVUFV0QXl6L3A5?=
 =?utf-8?B?WEtzSHNUQnNqR0pGdkZMR0RjZ0RjMVVqNjBULzRxOHhFbjhPVW1uYlFQNTdX?=
 =?utf-8?B?QTdWWHFCbkVoMkdKRDZNdkNqY1Vtbk4wcStoVDFtMys5NkdQaVlXdk95MWtD?=
 =?utf-8?B?d3A3ZDhDZUlaSHBhdytHZ3RRL3FPOFc2b1BoN0JmZXR5YjNnNlZBOWt4R24v?=
 =?utf-8?B?WVRqYVpJdFRmcC9ZYnBVR2JYcElrQzZLWWlJMFZSNE5qbHF0Yzc5L0EwcE02?=
 =?utf-8?B?UUdLOThsQnUrOGlma2ZINFFtbnZQTVNnSktZT0xOVmI4Wm04SjN1V3dHNHNS?=
 =?utf-8?B?ZkN4TnlneTBYSllNdmZmZ2lscUM2UVlvN2V1WFlEVHFUd1dKNWxFVjNwOU45?=
 =?utf-8?B?VVdTaFlBcVUzT0diRy9QbkVoREdOa0NGc25DY1dyMUZIbE1LL2piQ3hyeDNa?=
 =?utf-8?B?TmFUalNoL2MvYitNT2VtYWxtaXB4QXpZNElPZERienNLa1hBZE1FMHdjTDk2?=
 =?utf-8?B?UHVWMlU5K1NGT3FudHQwaGRzTG41aHd3UDF5MittR0N3WDVjYVB0Rk56bzdi?=
 =?utf-8?B?VFdueDF6TUtyWnZyYTMvQms3U3NYU3ZyK3prZWFwZVREbUVrWDZrL2s4OE9x?=
 =?utf-8?B?eWFuTFdhc2NYT3dFRDc5bDNZYVEzYlU4RFpvMlRoWHduY2l3VXUxWWpXazM2?=
 =?utf-8?B?U0hhemZZRHFRSDhlVHVYbFFBR0E5WUlyZ2dBd05hTmhySzl0djFWbU5EZk96?=
 =?utf-8?B?WGNMWmFNdVBBWkNsQy9FcXdBTlNnPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce36b3cb-b69a-47ae-1453-08dcf3a1c00c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 20:32:01.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znLREuvlC1N1sMCHalmDwxCBL61RuujxXKSJds7V8wWFv2VQjhXTk8LpxmUJRXEOo5fUYSLjpS0o5SLdVKc8eTNcH23ka1fpqirhve3kHTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyMywgMjAyNCAx
MToxMiBBTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGlu
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
DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxIDA5LzEzXSBtbTogenN3YXA6IENvbmZpZyB2
YXJpYWJsZSB0byBlbmFibGUNCj4gY29tcHJlc3MgYmF0Y2hpbmcgaW4genN3YXBfc3RvcmUoKS4N
Cj4gDQo+IE9uIFR1ZSwgT2N0IDIyLCAyMDI0IGF0IDc6MTfigK9QTSBTcmlkaGFyLCBLYW5jaGFu
YSBQDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogWW9zcnkgQWhtZWQg
PHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjIs
IDIwMjQgNTo1MCBQTQ0KPiA+ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAu
c3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNz
QGdtYWlsLmNvbTsNCj4gY2hlbmdtaW5nLnpob3VAbGludXguZGV2Ow0KPiA+ID4gdXNhbWFhcmlm
NjQyQGdtYWlsLmNvbTsgcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nDQo+ID4gPiA8
eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC0NCj4g
Zm91bmRhdGlvbi5vcmc7DQo+ID4gPiBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwub3JnOyBoZXJi
ZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7DQo+ID4gPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBjbGFi
YmVAYmF5bGlicmUuY29tOyBhcmRiQGtlcm5lbC5vcmc7DQo+ID4gPiBlYmlnZ2Vyc0Bnb29nbGUu
Y29tOyBzdXJlbmJAZ29vZ2xlLmNvbTsgQWNjYXJkaSwgS3Jpc3RlbiBDDQo+ID4gPiA8a3Jpc3Rl
bi5jLmFjY2FyZGlAaW50ZWwuY29tPjsgemFudXNzaUBrZXJuZWwub3JnOw0KPiB2aXJvQHplbml2
LmxpbnV4Lm9yZy51azsNCj4gPiA+IGJyYXVuZXJAa2VybmVsLm9yZzsgamFja0BzdXNlLmN6OyBt
Y2dyb2ZAa2VybmVsLm9yZzsNCj4ga2Vlc0BrZXJuZWwub3JnOw0KPiA+ID4gam9lbC5ncmFuYWRv
c0BrZXJuZWwub3JnOyBiZm9zdGVyQHJlZGhhdC5jb207IHdpbGx5QGluZnJhZGVhZC5vcmc7DQo+
IGxpbnV4LQ0KPiA+ID4gZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IEZlZ2hhbGksIFdhamRpIEsg
PHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+Ow0KPiBHb3BhbCwNCj4gPiA+IFZpbm9kaCA8dmlu
b2RoLmdvcGFsQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxIDA5
LzEzXSBtbTogenN3YXA6IENvbmZpZyB2YXJpYWJsZSB0byBlbmFibGUNCj4gPiA+IGNvbXByZXNz
IGJhdGNoaW5nIGluIHpzd2FwX3N0b3JlKCkuDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBPY3QgMTcs
IDIwMjQgYXQgMTE6NDHigK9QTSBLYW5jaGFuYSBQIFNyaWRoYXINCj4gPiA+IDxrYW5jaGFuYS5w
LnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gQWRkIGEgbmV3IHpz
d2FwIGNvbmZpZyB2YXJpYWJsZSB0aGF0IGNvbnRyb2xzIHdoZXRoZXIgenN3YXBfc3RvcmUoKQ0K
PiB3aWxsDQo+ID4gPiA+IGNvbXByZXNzIGEgYmF0Y2ggb2YgcGFnZXMsIGZvciBpbnN0YW5jZSwg
dGhlIHBhZ2VzIGluIGEgbGFyZ2UgZm9saW86DQo+ID4gPiA+DQo+ID4gPiA+ICAgQ09ORklHX1pT
V0FQX1NUT1JFX0JBVENISU5HX0VOQUJMRUQNCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGV4aXN0aW5n
IENPTkZJR19DUllQVE9fREVWX0lBQV9DUllQVE8gdmFyaWFibGUgYWRkZWQgaW4NCj4gY29tbWl0
DQo+ID4gPiA+IGVhN2E1Y2JiNDM2OSAoImNyeXB0bzogaWFhIC0gQWRkIEludGVsIElBQSBDb21w
cmVzc2lvbiBBY2NlbGVyYXRvcg0KPiBjcnlwdG8NCj4gPiA+ID4gZHJpdmVyIGNvcmUiKSBpcyB1
c2VkIHRvIGRldGVjdCBpZiB0aGUgc3lzdGVtIGhhcyB0aGUgSW50ZWwgQW5hbHl0aWNzDQo+ID4g
PiA+IEFjY2VsZXJhdG9yIChJQUEpLCBhbmQgdGhlIGlhYV9jcnlwdG8gbW9kdWxlIGlzIGF2YWls
YWJsZS4gSWYgc28sIHRoZQ0KPiA+ID4gPiBrZXJuZWwgYnVpbGQgd2lsbCBwcm9tcHQgZm9yDQo+
IENPTkZJR19aU1dBUF9TVE9SRV9CQVRDSElOR19FTkFCTEVELg0KPiA+ID4gSGVuY2UsDQo+ID4g
PiA+IHVzZXJzIGhhdmUgdGhlIGFiaWxpdHkgdG8gc2V0DQo+ID4gPiBDT05GSUdfWlNXQVBfU1RP
UkVfQkFUQ0hJTkdfRU5BQkxFRD0ieSIgb25seQ0KPiA+ID4gPiBvbiBzeXN0ZW1zIHRoYXQgaGF2
ZSBJbnRlbCBJQUEuDQo+ID4gPiA+DQo+ID4gPiA+IElmIENPTkZJR19aU1dBUF9TVE9SRV9CQVRD
SElOR19FTkFCTEVEIGlzIGVuYWJsZWQsIGFuZCBJQUEgaXMNCj4gPiA+IGNvbmZpZ3VyZWQNCj4g
PiA+ID4gYXMgdGhlIHpzd2FwIGNvbXByZXNzb3IsIHpzd2FwX3N0b3JlKCkgd2lsbCBwcm9jZXNz
IHRoZSBwYWdlcyBpbiBhIGxhcmdlDQo+ID4gPiA+IGZvbGlvIGluIGJhdGNoZXMsIGkuZS4sIG11
bHRpcGxlIHBhZ2VzIGF0IGEgdGltZS4gUGFnZXMgaW4gYSBiYXRjaCB3aWxsIGJlDQo+ID4gPiA+
IGNvbXByZXNzZWQgaW4gcGFyYWxsZWwgaW4gaGFyZHdhcmUsIHRoZW4gc3RvcmVkLiBPbiBzeXN0
ZW1zIHdpdGhvdXQNCj4gSW50ZWwNCj4gPiA+ID4gSUFBIGFuZC9vciBpZiB6c3dhcCB1c2VzIHNv
ZnR3YXJlIGNvbXByZXNzb3JzLCBwYWdlcyBpbiB0aGUgYmF0Y2ggd2lsbA0KPiBiZQ0KPiA+ID4g
PiBjb21wcmVzc2VkIHNlcXVlbnRpYWxseSBhbmQgc3RvcmVkLg0KPiA+ID4gPg0KPiA+ID4gPiBU
aGUgcGF0Y2ggYWxzbyBpbXBsZW1lbnRzIGEgenN3YXAgQVBJIHRoYXQgcmV0dXJucyB0aGUgc3Rh
dHVzIG9mIHRoaXMNCj4gPiA+ID4gY29uZmlnIHZhcmlhYmxlLg0KPiA+ID4NCj4gPiA+IElmIHdl
IGFyZSBjb21wcmVzc2luZyBhIGxhcmdlIGZvbGlvIGFuZCBiYXRjaGluZyBpcyBhbiBvcHRpb24s
IGlzIG5vdA0KPiA+ID4gYmF0Y2hpbmcgZXZlciB0aGUgY29ycmVjdCB0aGluZyB0byBkbz8gV2h5
IGlzIHRoZSBjb25maWcgb3B0aW9uDQo+ID4gPiBuZWVkZWQ/DQo+ID4NCj4gPiBUaGFua3MgWW9z
cnksIGZvciB0aGUgY29kZSByZXZpZXcgY29tbWVudHMhIFRoaXMgaXMgYSBnb29kIHBvaW50LiBU
aGUgbWFpbg0KPiA+IGNvbnNpZGVyYXRpb24gaGVyZSB3YXMgbm90IHRvIGltcGFjdCBzb2Z0d2Fy
ZSBjb21wcmVzc29ycyBydW4gb24gbm9uLQ0KPiBJbnRlbA0KPiA+IHBsYXRmb3JtcywgYW5kIG9u
bHkgaW5jdXIgdGhlIG1lbW9yeSBmb290cHJpbnQgY29zdCBvZiBtdWx0aXBsZQ0KPiA+IGFjb21w
X3JlcS9idWZmZXJzIGluICJzdHJ1Y3QgY3J5cHRvX2Fjb21wX2N0eCIgaWYgdGhlcmUgaXMgSUFB
IHRvIHJlZHVjZQ0KPiA+IGxhdGVuY3kgd2l0aCBwYXJhbGxlbCBjb21wcmVzc2lvbnMuDQo+ID4N
Cj4gPiBJZiB0aGUgbWVtb3J5IGZvb3RwcmludCBjb3N0IGlmIGFjY2VwdGFibGUsIHRoZXJlIGlz
IG5vIHJlYXNvbiBub3QgdG8gZG8NCj4gPiBiYXRjaGluZywgZXZlbiBpZiBjb21wcmVzc2lvbnMg
YXJlIHNlcXVlbnRpYWwuIFdlIGNvdWxkIGFtb3J0aXplIGNvc3QNCj4gPiBvZiB0aGUgY2dyb3Vw
IGNoYXJnaW5nL29iamNnL3N0YXRzIHVwZGF0ZXMuDQo+IA0KPiBIbW0geWVhaCBiYXNlZCBvbiB0
aGUgbmV4dCBwYXRjaCBpdCBzZWVtcyBsaWtlIHdlIGFsbG9jYXRlIDcgZXh0cmENCj4gYnVmZmVy
cywgZWFjaCBzaXplZCAyICogUEFHRV9TSVpFLCBwZXJjcHUuIFRoYXQncyA1NktCIHBlcmNwdSAo
d2l0aCA0Sw0KPiBwYWdlIHNpemUpLCB3aGljaCBpcyBub24tdHJpdmlhbC4NCj4gDQo+IE1ha2lu
ZyBpdCBhIGNvbmZpZyBvcHRpb24gc2VlbXMgdG8gYmUgaW5jb252ZW5pZW50IHRob3VnaC4gVXNl
cnMgaGF2ZQ0KPiB0byBzaWduIHVwIGZvciB0aGUgbWVtb3J5IG92ZXJoZWFkIGlmIHNvbWUgb2Yg
dGhlbSB3b24ndCB1c2UgSUFBDQo+IGJhdGNoaW5nLCBvciBkaXNhYmxlIGJhdGNoaW5nIGFsbCB0
b2dldGhlci4gSSB3b3VsZCBhc3N1bWUgdGhpcyB3b3VsZA0KPiBiZSBlc3BlY2lhbGx5IGFubm95
aW5nIGZvciBkaXN0cm9zLCBidXQgYWxzbyBmb3IgYW55b25lIHdobyB3YW50cyB0bw0KPiBleHBl
cmltZW50IHdpdGggSUFBIGJhdGNoaW5nLg0KPiANCj4gVGhlIGZpcnN0IHRoaW5nIHRoYXQgY29t
ZXMgdG8gbWluZCBpcyBtYWtpbmcgdGhpcyBhIGJvb3Qgb3B0aW9uLiBCdXQgSQ0KPiB0aGluayB3
ZSBjYW4gbWFrZSBpdCBldmVuIG1vcmUgY29udmVuaWVudCBhbmQgc3VwcG9ydCBlbmFibGluZyBp
dCBhdA0KPiBydW50aW1lLiBXZSBqdXN0IG5lZWQgdG8gYWxsb2NhdGUgdGhlIGFkZGl0aW9uYWwg
YnVmZmVycyB0aGUgZmlyc3QNCj4gdGltZSBiYXRjaGluZyBpcyBlbmFibGVkLiBUaGlzIHNob3Vs
ZG4ndCBiZSB0b28gY29tcGxpY2F0ZWQsIHdlIGhhdmUNCj4gYW4gYXJyYXkgb2YgYnVmZmVycyBv
biBlYWNoIENQVSBidXQgd2Ugb25seSBhbGxvY2F0ZSB0aGUgZmlyc3Qgb25lDQo+IGluaXRpYWxs
eSAodW5sZXNzIGJhdGNoaW5nIGlzIGVuYWJsZWQgYXQgYm9vdCkuIFdoZW4gYmF0Y2hpbmcgaXMN
Cj4gZW5hYmxlZCwgd2UgY2FuIGFsbG9jYXRlIHRoZSByZW1haW5pbmcgYnVmZmVycy4NCj4gDQo+
IFRoZSBvbmx5IHNob3J0Y29taW5nIG9mIHRoaXMgYXBwcm9hY2ggaXMgdGhhdCBpZiB3ZSBlbmFi
bGUgYmF0Y2hpbmcNCj4gdGhlbiBkaXNhYmxlIGl0LCB3ZSBjYW4ndCBmcmVlIHRoZSBidWZmZXJz
IHdpdGhvdXQgc2lnbmlmaWNhbnQNCj4gY29tcGxleGl0eSwgYnV0IEkgdGhpbmsgdGhhdCBzaG91
bGQgYmUgZmluZS4gSSBkb24ndCBzZWUgdGhpcyBiZWluZyBhDQo+IGNvbW1vbiBwYXR0ZXJuLg0K
PiANCj4gV0RZVD8NCg0KVGhhbmtzIGZvciB0aGVzZSBzdWdnZXN0aW9ucywgWW9zcnkuIFN1cmUs
IGxldCBtZSBnaXZlIHRoaXMgYSB0cnksIGFuZCBzaGFyZQ0KdXBkYXRlcy4NCg0KVGhhbmtzLA0K
S2FuY2hhbmENCg0KPiANCj4gDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEthbmNoYW5hDQo+
ID4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFN1Z2dlc3RlZC1ieTogWWluZyBIdWFuZyA8eWlu
Zy5odWFuZ0BpbnRlbC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEthbmNoYW5hIFAgU3Jp
ZGhhciA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
ICBpbmNsdWRlL2xpbnV4L3pzd2FwLmggfCAgNiArKysrKysNCj4gPiA+ID4gIG1tL0tjb25maWcg
ICAgICAgICAgICB8IDEyICsrKysrKysrKysrKw0KPiA+ID4gPiAgbW0venN3YXAuYyAgICAgICAg
ICAgIHwgMTQgKysrKysrKysrKysrKysNCj4gPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMzIgaW5z
ZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC96
c3dhcC5oIGIvaW5jbHVkZS9saW51eC96c3dhcC5oDQo+ID4gPiA+IGluZGV4IGQ5NjFlYWQ5MWJm
MS4uNzRhZDJhMjRiMzA5IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3pzd2Fw
LmgNCj4gPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC96c3dhcC5oDQo+ID4gPiA+IEBAIC0yNCw2
ICsyNCw3IEBAIHN0cnVjdCB6c3dhcF9scnV2ZWNfc3RhdGUgew0KPiA+ID4gPiAgICAgICAgIGF0
b21pY19sb25nX3QgbnJfZGlza19zd2FwaW5zOw0KPiA+ID4gPiAgfTsNCj4gPiA+ID4NCj4gPiA+
ID4gK2Jvb2wgenN3YXBfc3RvcmVfYmF0Y2hpbmdfZW5hYmxlZCh2b2lkKTsNCj4gPiA+ID4gIHVu
c2lnbmVkIGxvbmcgenN3YXBfdG90YWxfcGFnZXModm9pZCk7DQo+ID4gPiA+ICBib29sIHpzd2Fw
X3N0b3JlKHN0cnVjdCBmb2xpbyAqZm9saW8pOw0KPiA+ID4gPiAgYm9vbCB6c3dhcF9sb2FkKHN0
cnVjdCBmb2xpbyAqZm9saW8pOw0KPiA+ID4gPiBAQCAtMzksNiArNDAsMTEgQEAgYm9vbCB6c3dh
cF9uZXZlcl9lbmFibGVkKHZvaWQpOw0KPiA+ID4gPg0KPiA+ID4gPiAgc3RydWN0IHpzd2FwX2xy
dXZlY19zdGF0ZSB7fTsNCj4gPiA+ID4NCj4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCB6c3dh
cF9zdG9yZV9iYXRjaGluZ19lbmFibGVkKHZvaWQpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICBzdGF0aWMg
aW5saW5lIGJvb2wgenN3YXBfc3RvcmUoc3RydWN0IGZvbGlvICpmb2xpbykNCj4gPiA+ID4gIHsN
Cj4gPiA+ID4gICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9tbS9L
Y29uZmlnIGIvbW0vS2NvbmZpZw0KPiA+ID4gPiBpbmRleCAzM2ZhNTFkNjA4ZGMuLjI2ZDFhNWNl
ZTQ3MSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvbW0vS2NvbmZpZw0KPiA+ID4gPiArKysgYi9tbS9L
Y29uZmlnDQo+ID4gPiA+IEBAIC0xMjUsNiArMTI1LDE4IEBAIGNvbmZpZyBaU1dBUF9DT01QUkVT
U09SX0RFRkFVTFQNCj4gPiA+ID4gICAgICAgICBkZWZhdWx0ICJ6c3RkIiBpZiBaU1dBUF9DT01Q
UkVTU09SX0RFRkFVTFRfWlNURA0KPiA+ID4gPiAgICAgICAgIGRlZmF1bHQgIiINCj4gPiA+ID4N
Cj4gPiA+ID4gK2NvbmZpZyBaU1dBUF9TVE9SRV9CQVRDSElOR19FTkFCTEVEDQo+ID4gPiA+ICsg
ICAgICAgYm9vbCAiQmF0Y2hpbmcgb2YgenN3YXAgc3RvcmVzIHdpdGggSW50ZWwgSUFBIg0KPiA+
ID4gPiArICAgICAgIGRlcGVuZHMgb24gWlNXQVAgJiYgQ1JZUFRPX0RFVl9JQUFfQ1JZUFRPDQo+
ID4gPiA+ICsgICAgICAgZGVmYXVsdCBuDQo+ID4gPiA+ICsgICAgICAgaGVscA0KPiA+ID4gPiAr
ICAgICAgIEVuYWJsZXMgenN3YXBfc3RvcmUgdG8gc3dhcG91dCBsYXJnZSBmb2xpb3MgaW4gYmF0
Y2hlcyBvZiA4IHBhZ2VzLA0KPiA+ID4gPiArICAgICAgIHJhdGhlciB0aGFuIGEgcGFnZSBhdCBh
IHRpbWUsIGlmIHRoZSBzeXN0ZW0gaGFzIEludGVsIElBQSBmb3INCj4gaGFyZHdhcmUNCj4gPiA+
ID4gKyAgICAgICBhY2NlbGVyYXRpb24gb2YgY29tcHJlc3Npb25zLiBJZiBJQUEgaXMgY29uZmln
dXJlZCBhcyB0aGUgenN3YXANCj4gPiA+ID4gKyAgICAgICBjb21wcmVzc29yLCB0aGlzIHdpbGwg
cGFyYWxsZWxpemUgYmF0Y2ggY29tcHJlc3Npb24gb2YgdXB0byA4IHBhZ2VzDQo+ID4gPiA+ICsg
ICAgICAgaW4gdGhlIGZvbGlvIGluIGhhcmR3YXJlLCB0aGVyZWJ5IGltcHJvdmluZyBsYXJnZSBm
b2xpbyBjb21wcmVzc2lvbg0KPiA+ID4gPiArICAgICAgIHRocm91Z2hwdXQgYW5kIHJlZHVjaW5n
IHN3YXBvdXQgbGF0ZW5jeS4NCj4gPiA+ID4gKw0KPiA+ID4gPiAgY2hvaWNlDQo+ID4gPiA+ICAg
ICAgICAgcHJvbXB0ICJEZWZhdWx0IGFsbG9jYXRvciINCj4gPiA+ID4gICAgICAgICBkZXBlbmRz
IG9uIFpTV0FQDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9tbS96c3dhcC5jIGIvbW0venN3YXAuYw0K
PiA+ID4gPiBpbmRleCA5NDhjOTc0NWVlNTcuLjQ4OTMzMDJkOGMzNCAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvbW0venN3YXAuYw0KPiA+ID4gPiArKysgYi9tbS96c3dhcC5jDQo+ID4gPiA+IEBAIC0x
MjcsNiArMTI3LDE1IEBAIHN0YXRpYyBib29sIHpzd2FwX3Nocmlua2VyX2VuYWJsZWQgPQ0KPiA+
ID4gSVNfRU5BQkxFRCgNCj4gPiA+ID4gICAgICAgICAgICAgICAgIENPTkZJR19aU1dBUF9TSFJJ
TktFUl9ERUZBVUxUX09OKTsNCj4gPiA+ID4gIG1vZHVsZV9wYXJhbV9uYW1lZChzaHJpbmtlcl9l
bmFibGVkLCB6c3dhcF9zaHJpbmtlcl9lbmFibGVkLA0KPiBib29sLA0KPiA+ID4gMDY0NCk7DQo+
ID4gPiA+DQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICogRW5hYmxlL2Rpc2FibGUgYmF0Y2hpbmcg
b2YgY29tcHJlc3Npb25zIGlmIHpzd2FwX3N0b3JlIGlzIGNhbGxlZA0KPiB3aXRoIGENCj4gPiA+
ID4gKyAqIGxhcmdlIGZvbGlvLiBJZiBlbmFibGVkLCBhbmQgaWYgSUFBIGlzIHRoZSB6c3dhcCBj
b21wcmVzc29yLCBwYWdlcyBhcmUNCj4gPiA+ID4gKyAqIGNvbXByZXNzZWQgaW4gcGFyYWxsZWwg
aW4gYmF0Y2hlcyBvZiBzYXksIDggcGFnZXMuDQo+ID4gPiA+ICsgKiBJZiBub3QsIGV2ZXJ5IHBh
Z2UgaXMgY29tcHJlc3NlZCBzZXF1ZW50aWFsbHkuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0
YXRpYyBib29sIF9fenN3YXBfc3RvcmVfYmF0Y2hpbmdfZW5hYmxlZCA9IElTX0VOQUJMRUQoDQo+
ID4gPiA+ICsgICAgICAgQ09ORklHX1pTV0FQX1NUT1JFX0JBVENISU5HX0VOQUJMRUQpOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICBib29sIHpzd2FwX2lzX2VuYWJsZWQodm9pZCkNCj4gPiA+ID4gIHsN
Cj4gPiA+ID4gICAgICAgICByZXR1cm4genN3YXBfZW5hYmxlZDsNCj4gPiA+ID4gQEAgLTI0MSw2
ICsyNTAsMTEgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgeGFycmF5DQo+ID4gPiAqc3dhcF96c3dh
cF90cmVlKHN3cF9lbnRyeV90IHN3cCkNCj4gPiA+ID4gICAgICAgICBwcl9kZWJ1ZygiJXMgcG9v
bCAlcy8lc1xuIiwgbXNnLCAocCktPnRmbV9uYW1lLCAgICAgICAgIFwNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgICB6cG9vbF9nZXRfdHlwZSgocCktPnpwb29sKSkNCj4gPiA+ID4NCj4gPiA+ID4g
K19fYWx3YXlzX2lubGluZSBib29sIHpzd2FwX3N0b3JlX2JhdGNoaW5nX2VuYWJsZWQodm9pZCkN
Cj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICByZXR1cm4gX196c3dhcF9zdG9yZV9iYXRjaGlu
Z19lbmFibGVkOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICAvKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqDQo+ID4gPiA+ICAqIHBvb2wgZnVuY3Rpb25zDQo+ID4gPiA+
ICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLw0KPiA+ID4gPiAtLQ0KPiA+ID4g
PiAyLjI3LjANCj4gPiA+ID4NCg==

