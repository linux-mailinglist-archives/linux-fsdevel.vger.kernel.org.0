Return-Path: <linux-fsdevel+bounces-32637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCB19ABB6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 04:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A170B227B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D03487BE;
	Wed, 23 Oct 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9GLafqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D052D047;
	Wed, 23 Oct 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650095; cv=fail; b=jQFi8JTQM3vdqauNimf454k4ZlWSKVFPcEFUhJTxnTzItsorS+l0zCmoy7k0KrzHUw0CdJ+RLLKkzcBkm+VoXx8TXITc2yqXHoAZA2lfjpjWxfB7Tw20jmw2wrUyTkX/dq3WnpZYyCWb8RPmyLe/b7NVeX4J17Z5/2rolFftpEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650095; c=relaxed/simple;
	bh=1h4mxtkHV6E4eHhz11MmXYSFFoh/v/VvxyWxupFD6E4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5AsU0e8Zb1VAxja3U7F/Ha29kvK8TpnsX0GOgeMpWgCPpGt1Qt7m/EbB070yefku4pHFeLXcCtDR8ShTdPvoR8kqLBVruQHFsr1mw1VtwoK+FN0GayjbpFv38qoQwgO2l0KX+z1ROMAPNtCSRm5nC11AhJK1eULy4g1/T/cYkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9GLafqU; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729650094; x=1761186094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1h4mxtkHV6E4eHhz11MmXYSFFoh/v/VvxyWxupFD6E4=;
  b=h9GLafqUm7dEqtNyAKdltaVwBf/u5zt/ew9iWiy/uozTWVaOhixjKjNy
   YQfOq0MQ9F2UKiQXOnH+sTUd3xfOk3iRVNOz9wQiVk2NTP8vlGEUtOPRj
   IzL2sOQgpIourT3K+TmnDYTvVb3eHlMszSqVZs7OQUVxzPTWTC6QRiqxz
   pZx/6kMMLtLCFqXV7+RJJlEsh10JdZYr1KDNn8THcd6NMq57+f2weMpOz
   W4a8rhd7MY5E/CIDE28PEjPmhr5jsFfqEEle8zmdjdPNxyvyH5ETQTD1d
   PwrpgEDvIsR/RFgbz3wBcSCOpyc2Q7tLz4hyOvSFciqtLahRGwtdK0Vp/
   Q==;
X-CSE-ConnectionGUID: 14sBoJRGRJW/RLqNwZ5Glw==
X-CSE-MsgGUID: lcLmyu5uSzW/YZZVKuplyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46678919"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46678919"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:21:32 -0700
X-CSE-ConnectionGUID: Ea3JzlcBS2ubOp7K/3JHuw==
X-CSE-MsgGUID: JA5yHEGnSy2tGXyVA6P/5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79971034"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 19:21:32 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 19:21:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 19:21:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 19:21:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 19:21:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm54brX3EFZcY/UdYDmp1mdFvU8TxndIb40W/0VVcmsfmUydJfJDoh+kCLzvODq/A/HfI8/f8glMEuF6eJ6u/2yymE000OHyUVRrsby0xi9kZbRTc5i1kDRevR1hux3m7iz1BCNHb2F/fZDH3WfO+lWIqW3xqNjZ9o2BGcflx1lV5KRcOkkRtXNX1EiTHD3AJjqYDVly8H081UvXqyNOLHvISa27GuSARZTOv8Gmv4izHxw+3IvU7ULtf8e1R5yl/H3xt67khiBl1wVWTZ7VloZnB9GaGnlo5p62cl9vLMiYyCE2lD12MMc5ebYxqf79lvWZ8xN2Xod/jSahQj0GPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h4mxtkHV6E4eHhz11MmXYSFFoh/v/VvxyWxupFD6E4=;
 b=yzhNruk5HyIfw7lprw7KQahOl9SC3FbIygqw7IVVZd/Bb2hEHYDtb3TYxKEhD0qpUediMPGEW2pMA/gq4rmwlhZfPSTbrBrgv2hjj9tNTAmO258nTIopCyvClw8GdVrsUzHnhTowEitEU1Dz1E2DSLdRQ3EEstPQM2fXOZgEVKvQ0Q3JkSWOt5b4C0GAV7rdzuYE54+jxz9I5Mw2CWA0y+fdnZOEA4bDWVMlTclk5pyujTXlL7nzDWcJzPD+JkkeHN9Sn0OxH9w8r3raOy2zqn4umrVWBRchHX8eCL02TYz+ejsOlYxm1MIybZUmHE6D0w3tQar8OeytWwLQXJxSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 02:21:22 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:21:22 +0000
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
Subject: RE: [RFC PATCH v1 11/13] mm: swap: Add IAA batch compression API
 swap_crypto_acomp_compress_batch().
Thread-Topic: [RFC PATCH v1 11/13] mm: swap: Add IAA batch compression API
 swap_crypto_acomp_compress_batch().
Thread-Index: AQHbISi5FT/8Oh21kUm+GYqHj4qWWLKTiYyAgAAYQGA=
Date: Wed, 23 Oct 2024 02:21:22 +0000
Message-ID: <SJ0PR11MB567849494865E59C7C7EE0B4C94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-12-kanchana.p.sridhar@intel.com>
 <CAJD7tkZnEp98A+bP4N8GvFn=vT5Ck4NgrqsFQn+V8gpSbyAzkg@mail.gmail.com>
In-Reply-To: <CAJD7tkZnEp98A+bP4N8GvFn=vT5Ck4NgrqsFQn+V8gpSbyAzkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB6242:EE_
x-ms-office365-filtering-correlation-id: e4b15341-ef5e-48b5-4d3c-08dcf3096354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WXQzVnhGQk01bTBwU0tnd1A5K25RKzZleDcwT3RuQzNDcXNPODVkUXZZMjhh?=
 =?utf-8?B?cGtBWE5JaC9zVkpQcE43V3pKeWViR3dpUGptOXl5YUQ2U0J5cjVlRjRQSW4x?=
 =?utf-8?B?UElwY1lvdGo3THNXUVIwaDBXcy9mRFArQndGYmdEOEw5LzV2aEk1NXA1a0lW?=
 =?utf-8?B?S2pVMnB3YkQyR3NETG9SZjJISkQ2K0lObUNtMVhPelJ1RTNUdkVtd2Q4RUlI?=
 =?utf-8?B?U1g2SXdYa2hFa2laWHEweU94L3JGbjdBRENCWFpLenQyeTY5TXZJTGZxQVJF?=
 =?utf-8?B?cFZCdWZlN2treGl3Tlp5VEdBMDhvWWNKVmZscmw0akhjQkx6L3p3SmczMnBn?=
 =?utf-8?B?NEluL21MVXZhOFp3aUtzeVBkdTZTQWwrVjVpa1dpNm14NW9rYldTditmbTZa?=
 =?utf-8?B?VmZQNTcxbERMU3BzL0Vxb0RjZHNxaFZkNUZZcitWdmloemlJVEtmZHZ3MG5u?=
 =?utf-8?B?YmF5VTR5VWFlSTExaURRWWFjQy9xYVVkcUt6alVsM2RCNUVCcGFialh0bnQ1?=
 =?utf-8?B?VkJkZFNxSE9nTThqaHQ4eGhhajUrTThEYUVKNEF3RVNHOU9lNVBRdWtsU1o4?=
 =?utf-8?B?ckVXZU16Q3FIWTVZTE5ZdVFMc0FRM1Q1eWw5SVMxckxLNDhiUnF4eDFxUTJy?=
 =?utf-8?B?NGEybDVyOTNXUkdVZEhRblhDbSs4YUxBaW4wWStKTE0xU3A3UkJGcEMrMkxF?=
 =?utf-8?B?dUZFYWhrV3RpU0lHOExTaldQWE9oOWhvSzVwZ3lkUTh4MFBRV2pFSHhyYlU2?=
 =?utf-8?B?MWNVeCszRExSbVlwZGt5VlE4M2dIVFlUREhPcnZ6L1FWWFA4OTZJUFk0MlZX?=
 =?utf-8?B?eTQwdEtFYlgzRFl0YTJ2S1o5aUx1N0dDZEphNFF0allscVlBUGJtZ0szRlNL?=
 =?utf-8?B?TGMreEVPUkhnNlR2SEVpMDRDUndQaU5YbG43RFpuek9veEdKalB1SVZEek51?=
 =?utf-8?B?SWdJa0lnSnVDZVlLaTQwYWNiSFcvOXIyMmt4Wko1YlFkN0E4N1U5Z3FkamQ0?=
 =?utf-8?B?NWVoNmlJQm9lMlJ4ZTgyV0gvQUpLU2tBY0tGbXVXQmZ6ZG1aRWpkbnBPNXRU?=
 =?utf-8?B?eDZnWXFQQUxQcmphbDE5Q3VDcVlESGNZOEN2alFla2Q2N0lDdjhxbFNyVjNJ?=
 =?utf-8?B?ZVdsWVp2MWs4ZXZYTSt0SUtsYWdrQ0pycUV2WEZ6WUduV0VvODFiQi9VazVp?=
 =?utf-8?B?eVh0L2RxQkxUMThaK3JBRU11TnBTU2ZpdENNOVdSVXhVaHpiMTlBSlBvMW81?=
 =?utf-8?B?eCtCN2lvN21nWjZOd2xCOTVMR25oSThpeGxoeHlKbkNPUUxzTDJjK2x3V3lZ?=
 =?utf-8?B?eDFtWDFkNGIzMnBrbXFTb2pySlBkY1lDbFlFa25KS015Q0trODdwM3R0ZEhK?=
 =?utf-8?B?czhvN0p0dmljMTUxMzJuNlY3MHhMYUZPaWtqM1puV3hFK00xSkY4cjhPby9M?=
 =?utf-8?B?Qy9OTUQzeXNxd2c3OVFyOUFZcFRyN0tldnovbmdRR3Q4VkdlOTZiQ3FBMWl6?=
 =?utf-8?B?VGZHVVY5M3JrL05ML05DTWkzVExuS1RUellDMDljemxLRlBuVUp3YWlRaWVG?=
 =?utf-8?B?OGljbVl6Qnc2SDhQRjZIWW9sWk5qYWZKeWYwbWpZUXhRNlI2eWJLclpLZGRy?=
 =?utf-8?B?TnlXZjZ2cU91ZlhTU1plLy81dExjUUJKNXAreWYxUTd1Z2M2SEtGazhZV20w?=
 =?utf-8?B?RzFhc094eDM2K3hsdTVjL1plT3FGSFQvS1pBNnVMRTB3M3hROWNMZnF3QTR6?=
 =?utf-8?B?NmJ6UGM3c2JHc2VYTy9XQmtERHh4RXJFMkZ5eTR4OVUrZk5Wc3I2QjdUY01w?=
 =?utf-8?Q?B3y5lDyFh4tTNHHrLam+fjkNmGY1UeZc9cfq8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjNrQlc4aGxmNXBpNHF6OWJzaGtFSkxOR04xS2FJa1NTUUtzRTd1VU9KWFhR?=
 =?utf-8?B?clB3MVJCWlNQK0Roc2IzelgvNUIyUzBVODV4ZGhyZnZlaFBod3Y3cEluNERW?=
 =?utf-8?B?UXpzdHI5R1JKNm41TUlIMzZZRkJCUC9KRERXdWxFVXdLZXZ1Zk04NzI0V3J6?=
 =?utf-8?B?NWZBcFo2cU9BY0F5Y2pkVGt6aFY4QlBsVCtoZW1panE2OVhIVVd1TkxlaUFT?=
 =?utf-8?B?WExOK0R5RERnVmMxQmR2dmJOOGI3ZHE5c3RCSmg0VGFvUGYwbGF2bjFrdlFQ?=
 =?utf-8?B?T2Z6VU1CeEpOd2dabUhFa3M2eHFZWnBvSmhwbW5HSXRZTnU5Zmdwcmt6WHBT?=
 =?utf-8?B?dFRJSllXa21CeVdqdXlEMTl4UURHU3VzNFJzUHBjL2VKZzlWaUNZaU9sOEFr?=
 =?utf-8?B?bURHWm5QODd5VEp0Z0N6SHpDamVxWUdvVFB3cm9BMmJMelJSeVdxZXNTYUFz?=
 =?utf-8?B?eGZtQkFPVG9rYkx3YlZWb1EyUlI2N0U4TGx1dlJiS3VCRVUzS0kwNjNiVWc5?=
 =?utf-8?B?NVhkZXZva1NsMWhvbnNTdW9PTHVMeEJMbDdzcC9ydi90c21UaXhhZHhhL2wy?=
 =?utf-8?B?Ym9RODMzQ0ZVSmhvanlRbDZKdVlnc2NxVjZxNWVvVVdwU1RFYXRQbnVKbUE0?=
 =?utf-8?B?RzhkTzk2K29RME8vK0RIMlZ6WWRoblhYZEJ0ZGowUkxKZWU4YURWanZhTGFD?=
 =?utf-8?B?ODlLcGtybW1FcUZtOThrWWJOWmROYU9YMkJxVTgzZlZRUUs3a1hrVFJ5amls?=
 =?utf-8?B?V2JpN2lJSU4rdk5HeVphdHBiNGswRVFET05sdUZYdVBEN3BWU1I4VlIyeUpI?=
 =?utf-8?B?MFpWMnB5eSs1ZUhNU1NsalE2c1d6NU9ueEdwZlNTa2h3b1ZXejgyS0YrTExo?=
 =?utf-8?B?bEtKZUVIOFN4R2JDcFBmTDgrMlJVRHN6TnNwWnpHQ01iWldjZVV0Q2Y0NDhx?=
 =?utf-8?B?ZnN6VktKblIwZTJ6QU96WWkrWm12eVFCOXA4ZXVTQW92SFJjRXNXUW5GL3Rs?=
 =?utf-8?B?d1U0N0JFbzJpK0ErYkFJOWlITnNtcVpjWXg5UTR5bHRScFh6TzEzT3BzeWxn?=
 =?utf-8?B?amN4aVBRRkFUZlFBN0tDN2h6R0k0ckYrMkxZaUFneS8vQjZndFU4aTQ3a01i?=
 =?utf-8?B?ZVArUFB1K1ExT1VaZDJZVjBIaXl0WnVpQ3M2anVuWjMwajJ3VDNsS281MVJw?=
 =?utf-8?B?cTNodGpXand1S3dUQnhLQUdnQ2R5MnM4WVlQRGFwOTNYWk13V1NkbVFlWDZr?=
 =?utf-8?B?V3UvR2wxaUJ0Sm8ycEYxOHoreC9YcGZETUVDV2V0Z1RaK3pFcDBlTlg2WmlW?=
 =?utf-8?B?UWhON3dEaUMwc1JZNnF1eElKak95S2NZSVlwQkMzMGF0bkZ1ODIxYXp1bVJ5?=
 =?utf-8?B?V0ZndHZ6N3hMTlZwdUtXQTJlMUZFVXppVEZ5U0pKYjhTZjRVajVWVS9iV0ww?=
 =?utf-8?B?YkRJakc4RWYzMkxnbS9Dd2YwNlZidmN6MHc3eFpDQS90N3lTWHl2Qk1YdUZs?=
 =?utf-8?B?YmtkNncxQjBlYnAweS93RVBoTXZEamtGZmh6RXJBZUJXNEtrdjZNRmZxcDE2?=
 =?utf-8?B?T0JuZ0hpWWJ3TkxzcmdvOTMxNTFmS0RINlFONWhXTzFuT2NnNE9SNXN3OENv?=
 =?utf-8?B?TnFpZHR4cTlrNEFaRVk2REs3Q2l3N1oySTJmaW9mUVJHWEJzY3FxRFRBbm9u?=
 =?utf-8?B?NzBJa1ZHN0hraTNSM2pDeDhxb0ZZdVE2YlNxVXlLVDVUN05vR0xxZ3Rvcnh1?=
 =?utf-8?B?eFUrcFptYzVTcUlHQjhuUm44WG92c1pSZkkvQnhFKy9iZzVzL0p0bkpnVFJq?=
 =?utf-8?B?NUd6UmVrQWltRGViQVZycHkwNEc2UFF0RW9KWUNZSHlMbWNwVmN6U3Z3VXA3?=
 =?utf-8?B?cE92UFh2K1ltMUhLMmJoNkJDSTdyN3Q3RTc3OUNmUzZuelF6cE9ZMmhvQ0VC?=
 =?utf-8?B?dVNobDdIUXA0ZlRLQ3RXU0RKSU5Rb09iL3BCem1hT0ptYnVET2VOZDhaODhr?=
 =?utf-8?B?alhrVUYwNzZYU0NjSVkzNGNVcjRDMFlLZGMvVGpLU3BFb0VRUEJQTGVvVXdQ?=
 =?utf-8?B?UUoyTHF0VksrODJFaThHQzBibzR6UFpVY3V4N3NQNUhoa0RXbTNIZ29jQWFm?=
 =?utf-8?B?US9pcTBlT3VBa3Q2Y0pmR3IyeWJUR0xyYzU0ZHFpcjlyZGVNeHVKRzFwNy9G?=
 =?utf-8?B?dFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b15341-ef5e-48b5-4d3c-08dcf3096354
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 02:21:22.6439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjfvZC+I7wYL5FYIpZCJhJjUQFwpYDhHUMsn/PXmtLsNs5CScqCYz81zg3YLw7ChruThV797aohsPBrsywB+zSCPxFh70KPGiY72CINAc6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjIsIDIwMjQgNTo1
MyBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVs
LmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNr
Lm9yZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgY2hlbmdtaW5n
Lnpob3VAbGludXguZGV2Ow0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyByeWFuLnJvYmVydHNA
YXJtLmNvbTsgSHVhbmcsIFlpbmcNCj4gPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0Bn
bWFpbC5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IGxpbnV4LWNyeXB0b0B2Z2Vy
Lmtlcm5lbC5vcmc7IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsNCj4gZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsgY2xhYmJlQGJheWxpYnJlLmNvbTsgYXJkYkBrZXJuZWwub3JnOw0KPiBlYmlnZ2Vy
c0Bnb29nbGUuY29tOyBzdXJlbmJAZ29vZ2xlLmNvbTsgQWNjYXJkaSwgS3Jpc3RlbiBDDQo+IDxr
cmlzdGVuLmMuYWNjYXJkaUBpbnRlbC5jb20+OyB6YW51c3NpQGtlcm5lbC5vcmc7IHZpcm9AemVu
aXYubGludXgub3JnLnVrOw0KPiBicmF1bmVyQGtlcm5lbC5vcmc7IGphY2tAc3VzZS5jejsgbWNn
cm9mQGtlcm5lbC5vcmc7IGtlZXNAa2VybmVsLm9yZzsNCj4gam9lbC5ncmFuYWRvc0BrZXJuZWwu
b3JnOyBiZm9zdGVyQHJlZGhhdC5jb207IHdpbGx5QGluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBm
c2RldmVsQHZnZXIua2VybmVsLm9yZzsgRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxp
QGludGVsLmNvbT47IEdvcGFsLA0KPiBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxIDExLzEzXSBtbTogc3dhcDogQWRkIElBQSBiYXRj
aCBjb21wcmVzc2lvbiBBUEkNCj4gc3dhcF9jcnlwdG9fYWNvbXBfY29tcHJlc3NfYmF0Y2goKS4N
Cj4gDQo+IE9uIFRodSwgT2N0IDE3LCAyMDI0IGF0IDExOjQx4oCvUE0gS2FuY2hhbmEgUCBTcmlk
aGFyDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFk
ZGVkIGEgbmV3IEFQSSBzd2FwX2NyeXB0b19hY29tcF9jb21wcmVzc19iYXRjaCgpIHRoYXQgZG9l
cyBiYXRjaA0KPiA+IGNvbXByZXNzaW9uLiBBIHN5c3RlbSB0aGF0IGhhcyBJbnRlbCBJQUEgY2Fu
IGF2YWlsIG9mIHRoaXMgQVBJIHRvIHN1Ym1pdCBhDQo+ID4gYmF0Y2ggb2YgY29tcHJlc3Mgam9i
cyBmb3IgcGFyYWxsZWwgY29tcHJlc3Npb24gaW4gdGhlIGhhcmR3YXJlLCB0byBpbXByb3ZlDQo+
ID4gcGVyZm9ybWFuY2UuIE9uIGEgc3lzdGVtIHdpdGhvdXQgSUFBLCB0aGlzIEFQSSB3aWxsIHBy
b2Nlc3MgZWFjaCBjb21wcmVzcw0KPiA+IGpvYiBzZXF1ZW50aWFsbHkuDQo+ID4NCj4gPiBUaGUg
cHVycG9zZSBvZiB0aGlzIEFQSSBpcyB0byBiZSBpbnZvY2FibGUgZnJvbSBhbnkgc3dhcCBtb2R1
bGUgdGhhdCBuZWVkcw0KPiA+IHRvIGNvbXByZXNzIGxhcmdlIGZvbGlvcywgb3IgYSBiYXRjaCBv
ZiBwYWdlcyBpbiB0aGUgZ2VuZXJhbCBjYXNlLiBGb3INCj4gPiBpbnN0YW5jZSwgenN3YXAgd291
bGQgYmF0Y2ggY29tcHJlc3MgdXAgdG8NCj4gU1dBUF9DUllQVE9fU1VCX0JBVENIX1NJWkUNCj4g
PiAoaS5lLiA4IGlmIHRoZSBzeXN0ZW0gaGFzIElBQSkgcGFnZXMgaW4gdGhlIGxhcmdlIGZvbGlv
IGluIHBhcmFsbGVsIHRvDQo+ID4gaW1wcm92ZSB6c3dhcF9zdG9yZSgpIHBlcmZvcm1hbmNlLg0K
PiA+DQo+ID4gVG93YXJkcyB0aGlzIGV2ZW50dWFsIGdvYWw6DQo+ID4NCj4gPiAxKSBUaGUgZGVm
aW5pdGlvbiBvZiAic3RydWN0IGNyeXB0b19hY29tcF9jdHgiIGlzIG1vdmVkIHRvIG1tL3N3YXAu
aA0KPiA+ICAgIHNvIHRoYXQgbW0gbW9kdWxlcyBsaWtlIHN3YXBfc3RhdGUuYyBhbmQgenN3YXAu
YyBjYW4gcmVmZXJlbmNlIGl0Lg0KPiA+IDIpIFRoZSBzd2FwX2NyeXB0b19hY29tcF9jb21wcmVz
c19iYXRjaCgpIGludGVyZmFjZSBpcyBpbXBsZW1lbnRlZCBpbg0KPiA+ICAgIHN3YXBfc3RhdGUu
Yy4NCj4gPg0KPiA+IEl0IHdvdWxkIGJlIHByZWZlcmFibGUgZm9yICJzdHJ1Y3QgY3J5cHRvX2Fj
b21wX2N0eCIgdG8gYmUgZGVmaW5lZCBpbiwNCj4gPiBhbmQgZm9yIHN3YXBfY3J5cHRvX2Fjb21w
X2NvbXByZXNzX2JhdGNoKCkgdG8gYmUgZXhwb3J0ZWQgdmlhDQo+ID4gaW5jbHVkZS9saW51eC9z
d2FwLmggc28gdGhhdCBtb2R1bGVzIG91dHNpZGUgbW0gKGZvciBlLmcuIHpyYW0pIGNhbg0KPiA+
IHBvdGVudGlhbGx5IHVzZSB0aGUgQVBJIGZvciBiYXRjaCBjb21wcmVzc2lvbnMgd2l0aCBJQUEu
IEkgd291bGQNCj4gPiBhcHByZWNpYXRlIFJGQyBjb21tZW50cyBvbiB0aGlzLg0KPiANCj4gU2Ft
ZSBxdWVzdGlvbiBhcyB0aGUgbGFzdCBwYXRjaCwgd2h5IGRvZXMgdGhpcyBuZWVkIHRvIGJlIGlu
IHRoZSBzd2FwDQo+IGNvZGU/IFdoeSBjYW4ndCB6c3dhcCBqdXN0IHN1Ym1pdCBhIHNpbmdsZSBy
ZXF1ZXN0IHRvIGNvbXByZXNzIGEgbGFyZ2UNCj4gZm9saW8gb3IgYSByYW5nZSBvZiBjb250aWd1
b3VzIHN1YnBhZ2VzIGF0IG9uY2U/DQoNClN1cmUsIHRoaXMgd291bGQgYWxzbyB3b3JrIHdlbGwu
DQoNClRoYW5rcywNCkthbmNoYW5hDQoNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5j
aGFuYSBQIFNyaWRoYXIgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gLS0tDQo+
ID4gIG1tL3N3YXAuaCAgICAgICB8ICA0NSArKysrKysrKysrKysrKysrKysrDQo+ID4gIG1tL3N3
YXBfc3RhdGUuYyB8IDExNQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgbW0venN3YXAuYyAgICAgIHwgICA5IC0tLS0NCj4gPiAgMyBmaWxl
cyBjaGFuZ2VkLCAxNjAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9tbS9zd2FwLmggYi9tbS9zd2FwLmgNCj4gPiBpbmRleCA1NjY2MTZjOTcxZDQu
LjRkY2I2N2UyY2MzMyAxMDA2NDQNCj4gPiAtLS0gYS9tbS9zd2FwLmgNCj4gPiArKysgYi9tbS9z
d2FwLmgNCj4gPiBAQCAtNyw2ICs3LDcgQEAgc3RydWN0IG1lbXBvbGljeTsNCj4gPiAgI2lmZGVm
IENPTkZJR19TV0FQDQo+ID4gICNpbmNsdWRlIDxsaW51eC9zd2Fwb3BzLmg+IC8qIGZvciBzd3Bf
b2Zmc2V0ICovDQo+ID4gICNpbmNsdWRlIDxsaW51eC9ibGtfdHlwZXMuaD4gLyogZm9yIGJpb19l
bmRfaW9fdCAqLw0KPiA+ICsjaW5jbHVkZSA8bGludXgvY3J5cHRvLmg+DQo+ID4NCj4gPiAgLyoN
Cj4gPiAgICogRm9yIElBQSBjb21wcmVzc2lvbiBiYXRjaGluZzoNCj4gPiBAQCAtMTksNiArMjAs
MzkgQEAgc3RydWN0IG1lbXBvbGljeTsNCj4gPiAgI2RlZmluZSBTV0FQX0NSWVBUT19TVUJfQkFU
Q0hfU0laRSAxVUwNCj4gPiAgI2VuZGlmDQo+ID4NCj4gPiArLyogbGludXgvbW0vc3dhcF9zdGF0
ZS5jLCB6c3dhcC5jICovDQo+ID4gK3N0cnVjdCBjcnlwdG9fYWNvbXBfY3R4IHsNCj4gPiArICAg
ICAgIHN0cnVjdCBjcnlwdG9fYWNvbXAgKmFjb21wOw0KPiA+ICsgICAgICAgc3RydWN0IGFjb21w
X3JlcSAqcmVxW1NXQVBfQ1JZUFRPX1NVQl9CQVRDSF9TSVpFXTsNCj4gPiArICAgICAgIHU4ICpi
dWZmZXJbU1dBUF9DUllQVE9fU1VCX0JBVENIX1NJWkVdOw0KPiA+ICsgICAgICAgc3RydWN0IGNy
eXB0b193YWl0IHdhaXQ7DQo+ID4gKyAgICAgICBzdHJ1Y3QgbXV0ZXggbXV0ZXg7DQo+ID4gKyAg
ICAgICBib29sIGlzX3NsZWVwYWJsZTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsg
KiBUaGlzIEFQSSBwcm92aWRlcyBJQUEgY29tcHJlc3MgYmF0Y2hpbmcgZnVuY3Rpb25hbGl0eSBm
b3IgdXNlIGJ5IHN3YXANCj4gPiArICogbW9kdWxlcy4NCj4gPiArICogVGhlIGFjb21wX2N0eCBt
dXRleCBzaG91bGQgYmUgbG9ja2VkL3VubG9ja2VkIGJlZm9yZS9hZnRlciBjYWxsaW5nDQo+IHRo
aXMNCj4gPiArICogcHJvY2VkdXJlLg0KPiA+ICsgKg0KPiA+ICsgKiBAcGFnZXM6IFBhZ2VzIHRv
IGJlIGNvbXByZXNzZWQuDQo+ID4gKyAqIEBkc3RzOiBQcmUtYWxsb2NhdGVkIGRlc3RpbmF0aW9u
IGJ1ZmZlcnMgdG8gc3RvcmUgcmVzdWx0cyBvZiBJQUENCj4gY29tcHJlc3Npb24uDQo+ID4gKyAq
IEBkbGVuczogV2lsbCBjb250YWluIHRoZSBjb21wcmVzc2VkIGxlbmd0aHMuDQo+ID4gKyAqIEBl
cnJvcnM6IFdpbGwgY29udGFpbiBhIDAgaWYgdGhlIHBhZ2Ugd2FzIHN1Y2Nlc3NmdWxseSBjb21w
cmVzc2VkLCBvciBhDQo+ID4gKyAqICAgICAgICAgIG5vbi0wIGVycm9yIHZhbHVlIHRvIGJlIHBy
b2Nlc3NlZCBieSB0aGUgY2FsbGluZyBmdW5jdGlvbi4NCj4gPiArICogQG5yX3BhZ2VzOiBUaGUg
bnVtYmVyIG9mIHBhZ2VzLCB1cCB0bw0KPiBTV0FQX0NSWVBUT19TVUJfQkFUQ0hfU0laRSwNCj4g
PiArICogICAgICAgICAgICB0byBiZSBjb21wcmVzc2VkLg0KPiA+ICsgKiBAYWNvbXBfY3R4OiBU
aGUgYWNvbXAgY29udGV4dCBmb3IgaWFhX2NyeXB0by9vdGhlciBjb21wcmVzc29yLg0KPiA+ICsg
Ki8NCj4gPiArdm9pZCBzd2FwX2NyeXB0b19hY29tcF9jb21wcmVzc19iYXRjaCgNCj4gPiArICAg
ICAgIHN0cnVjdCBwYWdlICpwYWdlc1tdLA0KPiA+ICsgICAgICAgdTggKmRzdHNbXSwNCj4gPiAr
ICAgICAgIHVuc2lnbmVkIGludCBkbGVuc1tdLA0KPiA+ICsgICAgICAgaW50IGVycm9yc1tdLA0K
PiA+ICsgICAgICAgaW50IG5yX3BhZ2VzLA0KPiA+ICsgICAgICAgc3RydWN0IGNyeXB0b19hY29t
cF9jdHggKmFjb21wX2N0eCk7DQo+ID4gKw0KPiA+ICAvKiBsaW51eC9tbS9wYWdlX2lvLmMgKi8N
Cj4gPiAgaW50IHNpb19wb29sX2luaXQodm9pZCk7DQo+ID4gIHN0cnVjdCBzd2FwX2lvY2I7DQo+
ID4gQEAgLTExOSw2ICsxNTMsMTcgQEAgc3RhdGljIGlubGluZSBpbnQNCj4gc3dhcF96ZXJvbWFw
X2JhdGNoKHN3cF9lbnRyeV90IGVudHJ5LCBpbnQgbWF4X25yLA0KPiA+DQo+ID4gICNlbHNlIC8q
IENPTkZJR19TV0FQICovDQo+ID4gIHN0cnVjdCBzd2FwX2lvY2I7DQo+ID4gK3N0cnVjdCBjcnlw
dG9fYWNvbXBfY3R4IHt9Ow0KPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgc3dhcF9jcnlwdG9fYWNv
bXBfY29tcHJlc3NfYmF0Y2goDQo+ID4gKyAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZXNbXSwNCj4g
PiArICAgICAgIHU4ICpkc3RzW10sDQo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgZGxlbnNbXSwN
Cj4gPiArICAgICAgIGludCBlcnJvcnNbXSwNCj4gPiArICAgICAgIGludCBucl9wYWdlcywNCj4g
PiArICAgICAgIHN0cnVjdCBjcnlwdG9fYWNvbXBfY3R4ICphY29tcF9jdHgpDQo+ID4gK3sNCj4g
PiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIHN3YXBfcmVhZF9mb2xpbyhzdHJ1
Y3QgZm9saW8gKmZvbGlvLCBzdHJ1Y3Qgc3dhcF9pb2NiDQo+ICoqcGx1ZykNCj4gPiAgew0KPiA+
ICB9DQo+ID4gZGlmZiAtLWdpdCBhL21tL3N3YXBfc3RhdGUuYyBiL21tL3N3YXBfc3RhdGUuYw0K
PiA+IGluZGV4IDQ2NjlmMjljZjU1NS4uMTE3YzNjYWE1Njc5IDEwMDY0NA0KPiA+IC0tLSBhL21t
L3N3YXBfc3RhdGUuYw0KPiA+ICsrKyBiL21tL3N3YXBfc3RhdGUuYw0KPiA+IEBAIC0yMyw2ICsy
Myw4IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9zd2FwX3Nsb3RzLmg+DQo+ID4gICNpbmNsdWRl
IDxsaW51eC9odWdlX21tLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zaG1lbV9mcy5oPg0KPiA+
ICsjaW5jbHVkZSA8bGludXgvc2NhdHRlcmxpc3QuaD4NCj4gPiArI2luY2x1ZGUgPGNyeXB0by9h
Y29tcHJlc3MuaD4NCj4gPiAgI2luY2x1ZGUgImludGVybmFsLmgiDQo+ID4gICNpbmNsdWRlICJz
d2FwLmgiDQo+ID4NCj4gPiBAQCAtNzQyLDYgKzc0NCwxMTkgQEAgdm9pZCBleGl0X3N3YXBfYWRk
cmVzc19zcGFjZSh1bnNpZ25lZCBpbnQNCj4gdHlwZSkNCj4gPiAgICAgICAgIHN3YXBwZXJfc3Bh
Y2VzW3R5cGVdID0gTlVMTDsNCj4gPiAgfQ0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfU1dBUA0K
PiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIFRoaXMgQVBJIHByb3ZpZGVzIElBQSBjb21wcmVzcyBi
YXRjaGluZyBmdW5jdGlvbmFsaXR5IGZvciB1c2UgYnkgc3dhcA0KPiA+ICsgKiBtb2R1bGVzLg0K
PiA+ICsgKiBUaGUgYWNvbXBfY3R4IG11dGV4IHNob3VsZCBiZSBsb2NrZWQvdW5sb2NrZWQgYmVm
b3JlL2FmdGVyIGNhbGxpbmcNCj4gdGhpcw0KPiA+ICsgKiBwcm9jZWR1cmUuDQo+ID4gKyAqDQo+
ID4gKyAqIEBwYWdlczogUGFnZXMgdG8gYmUgY29tcHJlc3NlZC4NCj4gPiArICogQGRzdHM6IFBy
ZS1hbGxvY2F0ZWQgZGVzdGluYXRpb24gYnVmZmVycyB0byBzdG9yZSByZXN1bHRzIG9mIElBQQ0K
PiBjb21wcmVzc2lvbi4NCj4gPiArICogQGRsZW5zOiBXaWxsIGNvbnRhaW4gdGhlIGNvbXByZXNz
ZWQgbGVuZ3Rocy4NCj4gPiArICogQGVycm9yczogV2lsbCBjb250YWluIGEgMCBpZiB0aGUgcGFn
ZSB3YXMgc3VjY2Vzc2Z1bGx5IGNvbXByZXNzZWQsIG9yIGENCj4gPiArICogICAgICAgICAgbm9u
LTAgZXJyb3IgdmFsdWUgdG8gYmUgcHJvY2Vzc2VkIGJ5IHRoZSBjYWxsaW5nIGZ1bmN0aW9uLg0K
PiA+ICsgKiBAbnJfcGFnZXM6IFRoZSBudW1iZXIgb2YgcGFnZXMsIHVwIHRvDQo+IFNXQVBfQ1JZ
UFRPX1NVQl9CQVRDSF9TSVpFLA0KPiA+ICsgKiAgICAgICAgICAgIHRvIGJlIGNvbXByZXNzZWQu
DQo+ID4gKyAqIEBhY29tcF9jdHg6IFRoZSBhY29tcCBjb250ZXh0IGZvciBpYWFfY3J5cHRvL290
aGVyIGNvbXByZXNzb3IuDQo+ID4gKyAqLw0KPiA+ICt2b2lkIHN3YXBfY3J5cHRvX2Fjb21wX2Nv
bXByZXNzX2JhdGNoKA0KPiA+ICsgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2VzW10sDQo+ID4gKyAg
ICAgICB1OCAqZHN0c1tdLA0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50IGRsZW5zW10sDQo+ID4g
KyAgICAgICBpbnQgZXJyb3JzW10sDQo+ID4gKyAgICAgICBpbnQgbnJfcGFnZXMsDQo+ID4gKyAg
ICAgICBzdHJ1Y3QgY3J5cHRvX2Fjb21wX2N0eCAqYWNvbXBfY3R4KQ0KPiA+ICt7DQo+ID4gKyAg
ICAgICBzdHJ1Y3Qgc2NhdHRlcmxpc3QgaW5wdXRzW1NXQVBfQ1JZUFRPX1NVQl9CQVRDSF9TSVpF
XTsNCj4gPiArICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCBvdXRwdXRzW1NXQVBfQ1JZUFRPX1NV
Ql9CQVRDSF9TSVpFXTsNCj4gPiArICAgICAgIGJvb2wgY29tcHJlc3Npb25zX2RvbmUgPSBmYWxz
ZTsNCj4gPiArICAgICAgIGludCBpLCBqOw0KPiA+ICsNCj4gPiArICAgICAgIEJVR19PTihucl9w
YWdlcyA+IFNXQVBfQ1JZUFRPX1NVQl9CQVRDSF9TSVpFKTsNCj4gPiArDQo+ID4gKyAgICAgICAv
Kg0KPiA+ICsgICAgICAgICogUHJlcGFyZSBhbmQgc3VibWl0IGFjb21wX3JlcXMgdG8gSUFBLg0K
PiA+ICsgICAgICAgICogSUFBIHdpbGwgcHJvY2VzcyB0aGVzZSBjb21wcmVzcyBqb2JzIGluIHBh
cmFsbGVsIGluIGFzeW5jIG1vZGUuDQo+ID4gKyAgICAgICAgKiBJZiB0aGUgY29tcHJlc3NvciBk
b2VzIG5vdCBzdXBwb3J0IGEgcG9sbCgpIG1ldGhvZCwgb3IgaWYgSUFBIGlzDQo+ID4gKyAgICAg
ICAgKiB1c2VkIGluIHN5bmMgbW9kZSwgdGhlIGpvYnMgd2lsbCBiZSBwcm9jZXNzZWQgc2VxdWVu
dGlhbGx5IHVzaW5nDQo+ID4gKyAgICAgICAgKiBhY29tcF9jdHgtPnJlcVswXSBhbmQgYWNvbXBf
Y3R4LT53YWl0Lg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwg
bnJfcGFnZXM7ICsraSkgew0KPiA+ICsgICAgICAgICAgICAgICBqID0gYWNvbXBfY3R4LT5hY29t
cC0+cG9sbCA/IGkgOiAwOw0KPiA+ICsgICAgICAgICAgICAgICBzZ19pbml0X3RhYmxlKCZpbnB1
dHNbaV0sIDEpOw0KPiA+ICsgICAgICAgICAgICAgICBzZ19zZXRfcGFnZSgmaW5wdXRzW2ldLCBw
YWdlc1tpXSwgUEFHRV9TSVpFLCAwKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIC8qDQo+
ID4gKyAgICAgICAgICAgICAgICAqIEVhY2ggYWNvbXBfY3R4LT5idWZmZXJbXSBpcyBvZiBzaXpl
IChQQUdFX1NJWkUgKiAyKS4NCj4gPiArICAgICAgICAgICAgICAgICogUmVmbGVjdCBzYW1lIGlu
IHNnX2xpc3QuDQo+ID4gKyAgICAgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgICBz
Z19pbml0X29uZSgmb3V0cHV0c1tpXSwgZHN0c1tpXSwgUEFHRV9TSVpFICogMik7DQo+ID4gKyAg
ICAgICAgICAgICAgIGFjb21wX3JlcXVlc3Rfc2V0X3BhcmFtcyhhY29tcF9jdHgtPnJlcVtqXSwg
JmlucHV0c1tpXSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZvdXRwdXRzW2ldLCBQQUdFX1NJWkUsIGRsZW5zW2ldKTsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAgICAqIElmIHRoZSBjcnlwdG9fYWNvbXAgcHJv
dmlkZXMgYW4gYXN5bmNocm9ub3VzIHBvbGwoKQ0KPiA+ICsgICAgICAgICAgICAgICAgKiBpbnRl
cmZhY2UsIHN1Ym1pdCB0aGUgcmVxdWVzdCB0byB0aGUgZHJpdmVyIG5vdywgYW5kIHBvbGwgZm9y
DQo+ID4gKyAgICAgICAgICAgICAgICAqIGEgY29tcGxldGlvbiBzdGF0dXMgbGF0ZXIsIGFmdGVy
IGFsbCBkZXNjcmlwdG9ycyBoYXZlIGJlZW4NCj4gPiArICAgICAgICAgICAgICAgICogc3VibWl0
dGVkLiBJZiB0aGUgY3J5cHRvX2Fjb21wIGRvZXMgbm90IHByb3ZpZGUgYSBwb2xsKCkNCj4gPiAr
ICAgICAgICAgICAgICAgICogaW50ZXJmYWNlLCBzdWJtaXQgdGhlIHJlcXVlc3QgYW5kIHdhaXQg
Zm9yIGl0IHRvIGNvbXBsZXRlLA0KPiA+ICsgICAgICAgICAgICAgICAgKiBpLmUuLCBzeW5jaHJv
bm91c2x5LCBiZWZvcmUgbW92aW5nIG9uIHRvIHRoZSBuZXh0IHJlcXVlc3QuDQo+ID4gKyAgICAg
ICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoYWNvbXBfY3R4LT5hY29tcC0+
cG9sbCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGVycm9yc1tpXSA9IGNyeXB0b19h
Y29tcF9jb21wcmVzcyhhY29tcF9jdHgtPnJlcVtqXSk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChlcnJvcnNbaV0gIT0gLUVJTlBST0dSRVNTKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZXJyb3JzW2ldID0gLUVJTlZBTDsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBlcnJvcnNbaV0gPSAtRUFHQUlOOw0KPiA+ICsgICAgICAgICAgICAgICB9IGVsc2Ugew0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIGVycm9yc1tpXSA9IGNyeXB0b193YWl0X3JlcSgNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3J5cHRvX2Fj
b21wX2NvbXByZXNzKGFjb21wX2N0eC0+cmVxW2pdKSwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFjb21wX2N0eC0+d2FpdCk7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKCFlcnJvcnNbaV0pDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBkbGVuc1tpXSA9IGFjb21wX2N0eC0+cmVxW2pdLT5kbGVuOw0KPiA+ICsg
ICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgLyoNCj4g
PiArICAgICAgICAqIElmIG5vdCBkb2luZyBhc3luYyBjb21wcmVzc2lvbnMsIHRoZSBiYXRjaCBo
YXMgYmVlbiBwcm9jZXNzZWQgYXQNCj4gPiArICAgICAgICAqIHRoaXMgcG9pbnQgYW5kIHdlIGNh
biByZXR1cm4uDQo+ID4gKyAgICAgICAgKi8NCj4gPiArICAgICAgIGlmICghYWNvbXBfY3R4LT5h
Y29tcC0+cG9sbCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiArICAg
ICAgIC8qDQo+ID4gKyAgICAgICAgKiBQb2xsIGZvciBhbmQgcHJvY2VzcyBJQUEgY29tcHJlc3Mg
am9iIGNvbXBsZXRpb25zDQo+ID4gKyAgICAgICAgKiBpbiBvdXQtb2Ytb3JkZXIgbWFubmVyLg0K
PiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICB3aGlsZSAoIWNvbXByZXNzaW9uc19kb25lKSB7
DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXByZXNzaW9uc19kb25lID0gdHJ1ZTsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBucl9wYWdlczsgKytpKSB7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
KiBTa2lwLCBpZiB0aGUgY29tcHJlc3Npb24gaGFzIGFscmVhZHkgY29tcGxldGVkDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICogc3VjY2Vzc2Z1bGx5IG9yIHdpdGggYW4gZXJyb3IuDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKGVycm9yc1tpXSAhPSAtRUFHQUlOKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29udGludWU7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGVy
cm9yc1tpXSA9IGNyeXB0b19hY29tcF9wb2xsKGFjb21wX2N0eC0+cmVxW2ldKTsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVycm9yc1tpXSkgew0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVycm9yc1tpXSA9PSAtRUFHQUlOKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wcmVzc2lvbnNfZG9uZSA9
IGZhbHNlOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkbGVuc1tpXSA9IGFjb21wX2N0eC0+cmVxW2ldLT5k
bGVuOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAg
fQ0KPiA+ICsgICAgICAgfQ0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHN3YXBfY3J5
cHRvX2Fjb21wX2NvbXByZXNzX2JhdGNoKTsNCj4gPiArDQo+ID4gKyNlbmRpZiAvKiBDT05GSUdf
U1dBUCAqLw0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBzd2FwX3ZtYV9yYV93aW4oc3RydWN0IHZt
X2ZhdWx0ICp2bWYsIHVuc2lnbmVkIGxvbmcgKnN0YXJ0LA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgKmVuZCkNCj4gPiAgew0KPiA+IGRpZmYgLS1naXQgYS9t
bS96c3dhcC5jIGIvbW0venN3YXAuYw0KPiA+IGluZGV4IDU3OTg2OWQxYmRmNi4uY2FiMzExNDMy
MWY5IDEwMDY0NA0KPiA+IC0tLSBhL21tL3pzd2FwLmMNCj4gPiArKysgYi9tbS96c3dhcC5jDQo+
ID4gQEAgLTE1MCwxNSArMTUwLDYgQEAgYm9vbCB6c3dhcF9uZXZlcl9lbmFibGVkKHZvaWQpDQo+
ID4gICogZGF0YSBzdHJ1Y3R1cmVzDQo+ID4gICoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKiovDQo+ID4NCj4gPiAtc3RydWN0IGNyeXB0b19hY29tcF9jdHggew0KPiA+IC0gICAgICAg
c3RydWN0IGNyeXB0b19hY29tcCAqYWNvbXA7DQo+ID4gLSAgICAgICBzdHJ1Y3QgYWNvbXBfcmVx
ICpyZXFbU1dBUF9DUllQVE9fU1VCX0JBVENIX1NJWkVdOw0KPiA+IC0gICAgICAgdTggKmJ1ZmZl
cltTV0FQX0NSWVBUT19TVUJfQkFUQ0hfU0laRV07DQo+ID4gLSAgICAgICBzdHJ1Y3QgY3J5cHRv
X3dhaXQgd2FpdDsNCj4gPiAtICAgICAgIHN0cnVjdCBtdXRleCBtdXRleDsNCj4gPiAtICAgICAg
IGJvb2wgaXNfc2xlZXBhYmxlOw0KPiA+IC19Ow0KPiA+IC0NCj4gPiAgLyoNCj4gPiAgICogVGhl
IGxvY2sgb3JkZXJpbmcgaXMgenN3YXBfdHJlZS5sb2NrIC0+IHpzd2FwX3Bvb2wubHJ1X2xvY2su
DQo+ID4gICAqIFRoZSBvbmx5IGNhc2Ugd2hlcmUgbHJ1X2xvY2sgaXMgbm90IGFjcXVpcmVkIHdo
aWxlIGhvbGRpbmcgdHJlZS5sb2NrIGlzDQo+ID4gLS0NCj4gPiAyLjI3LjANCj4gPg0K

