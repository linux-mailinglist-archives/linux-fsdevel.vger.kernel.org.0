Return-Path: <linux-fsdevel+bounces-32635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F49ABB64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 04:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892601F245AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 02:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAE04D599;
	Wed, 23 Oct 2024 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOY3giFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C88825;
	Wed, 23 Oct 2024 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729649833; cv=fail; b=pWwTrPzICJdfwlvftHvIFavkV0Tqof3wt4rWWCKndN3wVJNobwgpoPDsp5WpL/WJdfhMbqylGUJSWeKpp3PN/QHo44z3Xgpp0m+RjUXYmFP4PXpsfYijdCi7s+n7d2W96FIedlfww5ZYiMoSQZaMJF95tYmDtL6lUAk6ewAuz9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729649833; c=relaxed/simple;
	bh=T31Kz+agko5a/s7BdYWrxwfkfpMMZy00fzsXlFGK3i4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqB4+btiNk7o2q/yBk/wm7fLhV3VjWKVw5EXFDLxY7Xp3Sa/+JtNGZzLwD8ALMesUliK1Ya7VIfBP2K/beKxookRjJtf7D8SvuSvlZGDpaDh9FAkK5y00tzOvMy/XbidawtYxlV3kLm2fzx1YFWQTk+cad/IonvSvo6ke4aKKOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOY3giFB; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729649832; x=1761185832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T31Kz+agko5a/s7BdYWrxwfkfpMMZy00fzsXlFGK3i4=;
  b=IOY3giFBciD2DK4Mnc6S6c8/07ET2iODwGLOc6I2Fh/TJf93Hp9yhgy5
   cgYZ5PQqjebeZJClYxf1RkFHvEEj0ZlrUV8GOJIXWhEeXEVtdG0HWMeQG
   EisW+7kOG059LtF3rHP1P3kFw5R8D2DMA70IHec9TGg4eFuf6Qd0TnJ2/
   rwXsyKk0a32S4trDg4M1YaY4wsgPTp6fViPNI7wz6R8xSa4zosKvXpd7O
   VMgYAD5hy2PCsywSJCXz0DQbtvO2e+MktUitqfhlqOOzzcN1Q04O/dHv/
   XtncJzKo/99Q+6zXYWfGHz8ZwQkQDmuUR/4Qq4I2Xr/jPoPr8V+h5KSwC
   A==;
X-CSE-ConnectionGUID: Y99Ii4ayQ8WPP18TJdKROg==
X-CSE-MsgGUID: KPocMoG6TDu92UWbTnwP5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28682307"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="28682307"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:17:11 -0700
X-CSE-ConnectionGUID: A3U841Q3S1O/rKEVESSTgg==
X-CSE-MsgGUID: W3famWv8TSWDdkRRB/hFnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80467511"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 19:17:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 19:17:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 19:17:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 19:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgkRKL6bg+aTbnzLvqQ8/zrSb0ZIU4/Jx4U3gBuCu87KlyXWbVZQnqpzrZdQrp2ge235ltu/iqYiq84vhNlQsFy4qJ/cWrVYo68zYnajaEkOdahdAYlaa2o4TUi8sKImfvhBlrF237OhtPM3BGj0tOmVd9ltMC73v2o6DeQG88DfyR00jyj5OTebY6r36HfMJXN5QDsmrQWuuo5XJYmVaTaJfum9pasdlDb51Uwfzl0ruj8FAnHUwPUG6jSFTJuVtDzNVrFXMtWzKoh8edwAX5iMtkLoel6/LKDk2HqYB/qpueo9x6rRt6ulOx1gqvu/VzLsnlE3BdMqaRuq/B0qkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T31Kz+agko5a/s7BdYWrxwfkfpMMZy00fzsXlFGK3i4=;
 b=OSywd9HiT1uYcVYHuqXRj/1sM6HHw7K9NIDiG1lxrtrQZXBInLOp1YEQOwjJSvjHlOMT/qpTv5J0XQcdrSp0Q2nzIeaVv3gVNDOUh9aKDC15gwy0iIsMNQsO/HtJwnJi+BlVCsSb36DFnUmWm36lk3Oi6ZOIy9etuB9H93F6H5PtcAiR5eRetNRnec/mG/llCa02UjfCWKxm7PnKARxkG9MAHmLiy+KhJWrlUbo7RMxg6FH58DS/eld12TfwQSIK0gZVgnTbc3Zrp0scEVwq4JFm4GWKs/dcWFZmFrOulJCpYmsz79URkjhQ2GLdlZ6nseT8NgCcCwKA2yoSTOKuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 02:17:06 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:17:06 +0000
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
Thread-Index: AQHbISi8rWXrArXvWU+XZylbH3mRtLKTiKCAgAAT61A=
Date: Wed, 23 Oct 2024 02:17:06 +0000
Message-ID: <SJ0PR11MB5678D24CDD8E5C8FF081D734C94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-10-kanchana.p.sridhar@intel.com>
 <CAJD7tkbXTtG1UmQ7oPXoKUjT302a_LL4yhbQsMS6tDRG+vRNBg@mail.gmail.com>
In-Reply-To: <CAJD7tkbXTtG1UmQ7oPXoKUjT302a_LL4yhbQsMS6tDRG+vRNBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB6242:EE_
x-ms-office365-filtering-correlation-id: 8ea1c649-6926-4a94-40b9-08dcf308ca75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d0M5bFcxb2U0RGJkZ0FubFlhVGh3REJRRENqOGV2WVpndDdIN0JsazluYzhs?=
 =?utf-8?B?bTZUTytnL2tnYzU0V3duQk5zeE5Fd3NjblVURlpoelFyQjZQSFFZODZKajNU?=
 =?utf-8?B?d2xiVjNNenBPRVU0RXcwdWNDeSsrbzdxdjVGZ25uZ252SEZrYlhoaVh5QXBC?=
 =?utf-8?B?cmIyWjR4TWdvTURsOHpJV2U5YkI5a2VKM05nWE5UU0k3cThtYSttZTIzUUJP?=
 =?utf-8?B?dmllajNwOGxDZVU0bDU1SDJUN205elV4ajdrZm03d1pObkY3RUxCYWZGaEZr?=
 =?utf-8?B?MXk1V2pVZzc3TVMrL3h6UEVJU1NlSW9mN3pEY0duK3RwOXpwcXVoUkFCNjZq?=
 =?utf-8?B?eDBQQTI2OWFKKy81RjZIZTh3d1o3QXlsU0h2TGpMcURhTjFNMlhMVHdxYWd3?=
 =?utf-8?B?Z0svS1M0MmNucGxrVGZNREdTanZqakJ3bnBXdmFEMkw0NGY2RVFpbC9TR1h5?=
 =?utf-8?B?L29yUzk5MG9VV0hTVWpEUVhHRzE5WHBmdlFwNEtZb0pIRmljaHZTckJDRVhB?=
 =?utf-8?B?V2hwTlVpY0lxblJnMWhoZERIVVdlVzBvcXcrbUFLNDZITmpGM21oMDNZT2xP?=
 =?utf-8?B?OHhpbSthTTY5VXVBeTcwT0dVbG9TanpMZGdKeC9tdE1ydWxab25obGxXalNq?=
 =?utf-8?B?S0p0VERmZUxTQlhoWkdFS2ZETjBjQzJ2UDlaUUMrbGtWYTFQVSsvbDhmL1o2?=
 =?utf-8?B?b1N2Z293THlseDJVR0hYTjYweG5GMEN3cjdNWmNjZ3FLQ250bG93SVZLWVgr?=
 =?utf-8?B?UkRCQithamtnSFRxcW5raHhZNHlBYm5tOWx0anROL0JjRStOU2t6V2pSZ0Vu?=
 =?utf-8?B?UFgrZjZhb0VFajdkYTd6c3M3WkZSTjNtWXFGMnFXOHNyaEpScXIvVjhHeVpO?=
 =?utf-8?B?cjFrc0ZaSkJ2ZzdMNkk2N3dlQUtCckkrenNjWGF2RXZKTUJlS0k0enBFMmpw?=
 =?utf-8?B?VUxXVHRmaEZMQ1dEOEoxcFh1dG81UXRRaVN5TnRBanI4WkhMcndmTzlSSGhn?=
 =?utf-8?B?bnZwbTNqODRUc0JHQkRMYUp6TmpaZjlkUEZrNDRVNU9YQkxhOVJaQWJCaU8v?=
 =?utf-8?B?eXZFVG9UUVdKQmVibytYV3BXN2lJUGVRcmExZHE3SlJrZHZLR3RUdUo0MGk3?=
 =?utf-8?B?aEJrUDlYNVFlRUxtaUc0YVM1MzNBKzV5OTB1N01Dc1liSEpVcTJMT2dFZmNj?=
 =?utf-8?B?Ynhic3NvOTZXa1lSTktkMlBGc2dyd3d1ZDhqaEdlZTR4cW5sS2JIWlE4WjJN?=
 =?utf-8?B?aXpMbUZDSWtndUtHWVVaUWp6V3lxbFRSN0c5ZzFSQ1FKak5mWTB3a24yOXQ1?=
 =?utf-8?B?TE40WmlsMlAxNXJib2Z0dG1KYTEvTTVuN25CTThiUm9IQ09qR0ZKUnBybGI2?=
 =?utf-8?B?azVQREQxcXB4NFozcUg5c0wvelVnc25DSFc0TmtlUEUzOTRPc21Hb3l1anQz?=
 =?utf-8?B?eE81dU1JRVNCaFAxbk1WQjB6c2hQWHBDMFE2Q0l2aXNMZllDOHZ5NjFCRjMz?=
 =?utf-8?B?N0dlbVZTSytDUFlSczZDbUhvS3QyZEV6UytVVmtDemRrSHJTSWVuWjBROG5j?=
 =?utf-8?B?OXlPREtxQWY2LzU0OVV6REZIV05jRXZja01mbENicjBobmdxamtBUDdqTnNR?=
 =?utf-8?B?aWhtaTFoOHh1ejF5Vkg4UmpCVUhFZ0xGSHBRSDNrZmpYdnFPU01XYVJBL1po?=
 =?utf-8?B?Y3dVUWxWcWJEMG51d1U1bEhLSG1XcXlabEp6R2Y3SEVScWRjeVZLbzZtcEZr?=
 =?utf-8?B?Yzc1SnVNd1pBNWNrNHNaaG0yS2lOelNhTGIxT0s5MW5IZ0dxMFMzOTBRdGJ0?=
 =?utf-8?Q?9mlcXgTudw4oQlxPq+6Mw09BGb6hx9cjC0pow=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkhjbVBQVU05VHAzVmdkRWdVOHQvWmcyRXlsUDRMVzFSRm90Mys5OTVGSGRV?=
 =?utf-8?B?VHA3VkRBUVJvdXlDdmhHY29wTUZET1VRaFpQb0F6cmlzZDVnUzNSU2tDSmRk?=
 =?utf-8?B?dFNXNmRHMFg0WU5jaWV1alRWeUZhVjdINHJiZXhGVTZUaFdOVmtvWEVOeFJk?=
 =?utf-8?B?ZjJXUXlUekRKa0JaNzE0b2FTR3JDNXR6OXRFc0MyRzlsenNDcUNQb0ZoSEVy?=
 =?utf-8?B?MzhYSXNEVk1HWjRaTlFYakllb3pKNXdHSjUwMmNpdXMzWjN3aHFFbHZFc3hH?=
 =?utf-8?B?T1VaMzArSGNGcGlFVHByNEhKWEFkYXZrQVZwOXZQS0VWUUFwbnFVbUNPVUkr?=
 =?utf-8?B?K3Y0TlVjbWllemJreW5zbWV4MzlaM3BTcWxpeTRUZU9kVUFld3VVLy8rS1p6?=
 =?utf-8?B?YVo3bnd0RE9NMFNybGszYzNyM3RhR2dSSjkvdTJHdWpHbmR3RllMeHZQcFBE?=
 =?utf-8?B?Uk5Pcm9Pem9laWt5NDMydVM4SldXMUpPU09tTGxwMTZ4OU5tUDRpNm9xQUlm?=
 =?utf-8?B?Rjd2cXJTVlE3U2lBK0lUNVdCajFETXh6YVpIa1J5QmVqWEY2UmpRRGE0MnVn?=
 =?utf-8?B?QUlsZnhrUTdnMlJEK29YamJNamp4TWJFcEx2RjdCaWlhSTBGUGdMNi9TS2tB?=
 =?utf-8?B?WFk3ZzMyRzAyTmt0WDVEbWNCWjNieDBIeXRxVzN3WUFRNEJWTEh2UGxuTjJO?=
 =?utf-8?B?YURldzZmdll0SGpOSTUxZjN6bXg4OEVJYWRaMFA5MzR1a1Zqck14cjJFS1VB?=
 =?utf-8?B?TW9FWTFZakNldjBxMDk3TER4OC9LampzMGptMFlkcjI0amlpSXQ4ZWp5VE9H?=
 =?utf-8?B?VkNjdG4zZ1pCdElTa1NMVGZSRXB2a0l5YUhMbXpIR1cwQmZQQ2dSeFkxcEFR?=
 =?utf-8?B?TTl5WWFWcFRIMTB6SFF5K3I1aVhyY2gxbUNSTExsTGxobHVBMzRLajV2YUR6?=
 =?utf-8?B?amJzTmgyYnBNaHo3NkxscXpJTnVvVk1mTjM4RGhmY1Jla1VZd2JTNXp0TDRa?=
 =?utf-8?B?dkQ1ZEJSTmpqTGNNWFBrYkJEbGhJRlJoMFBQUjUwRmRHYlZHZXhDbDlINVBm?=
 =?utf-8?B?NWZzYnF3Tmd6MGxQbmJhSlYzL2xtckpjVnhPcEZwK0JFTWNGN09rT2MwOU1j?=
 =?utf-8?B?YWZlcXZSREV5VXVicERpUE41Y3c1Vm12K3J0eUVnaWFtSURRUlgxSVdWZWZK?=
 =?utf-8?B?TkhQMlYwcjZhUENGTDFMZVBjMkIxZ3pOZlo3YkxvYzZ5RFFzNnlBd2lNdWZV?=
 =?utf-8?B?djNDZWZMRDI1WVZTbnZkMmNTdkE4MFcrN2JVNjArWDJTL2tsRVpORFQ0eFl6?=
 =?utf-8?B?cFhqOW54M08rQUdmOSsxWG9MY0N3ekc5MHV4TzJzTmdtOVpxOGZJZTl3c1Ra?=
 =?utf-8?B?cUJVai9OVUljTDJPbVQrVUNlckdEODREdks5S1hXa3NvZjZsdy9UbU1RbU52?=
 =?utf-8?B?ZndTWXZDREJpamhuUWMvMXNyUFFPYUM4amxKeGZXUThTSTZqelRMdFVLMm8z?=
 =?utf-8?B?ZWNIYktMcEVWdTMrQk9MQkxRVjFHUEc2TmRTL1h6cWxzei9sM0VteVdFY05T?=
 =?utf-8?B?UHEyYUQ2bzRMalIzdVFmQTFxZGpSSDVCVGNOUnVxeGVXb1Z6T1c0YnpOOVAr?=
 =?utf-8?B?MWNRa2ZmbFNHY0lYa0RMQUxsUExlVEVEMFAyWGVyK2Q0V3k2T2l5Vkp3dzA5?=
 =?utf-8?B?bkgwY1p6ZC9GazEvSUYzNWY1YXRoN1RpVktsbDNpZFg5TCs1QUttSzJ1TDBM?=
 =?utf-8?B?RmFnMmUwWVZGTzJaK0xJSnZMWnRVTFJmcWN3eThBNmVzblZ0eVR2WU9wRFFD?=
 =?utf-8?B?YWpaSjJmeW8yUGt5SDc5WHFkdnZtbmNsSEppR3FLdm8xbVh6VExFcHZETE9J?=
 =?utf-8?B?Q3JWaUw2TXVuZm92VVowWW5VOWVuZ055K0VzWUtWQ0VXaE9DeUpmMHlQcUJC?=
 =?utf-8?B?UGFGQUtHc0RYODlxOXd2VzFtTUFqZFk4clZFQU5oRWhTOUxkVzBVdXNPNC90?=
 =?utf-8?B?Q0VZRGVZaHlWYzdBMVVSdWtoKy9NTlJHT3pYSkxONzh1OXA1dmRlNVorK0NX?=
 =?utf-8?B?am5sUS9GQVEyN2hVQUhMc1AvNVVvdXEzNzQwVk53ZnEzWW1RcWl1OVFYNUto?=
 =?utf-8?B?SjFPdzFTNXZxR1hrdlNKOVRuUkJrRC9QRDNnZG92RzFPcWJ2Y2hxVXlHbFdz?=
 =?utf-8?B?cWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea1c649-6926-4a94-40b9-08dcf308ca75
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 02:17:06.1217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iz3TdsliBeQjVy0jOxO1e0LxCcbsDHbr4KLQnEu3A6gmKnQkWRJENWxVGxQ6CZT+8q4tOlbBBF5BT3ddrA/zAqkgJBVFe1OInGEgYbH9t54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjIsIDIwMjQgNTo1
MCBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVs
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
IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxIDA5LzEzXSBtbTogenN3YXA6IENvbmZpZyB2YXJp
YWJsZSB0byBlbmFibGUNCj4gY29tcHJlc3MgYmF0Y2hpbmcgaW4genN3YXBfc3RvcmUoKS4NCj4g
DQo+IE9uIFRodSwgT2N0IDE3LCAyMDI0IGF0IDExOjQx4oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFy
DQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBh
IG5ldyB6c3dhcCBjb25maWcgdmFyaWFibGUgdGhhdCBjb250cm9scyB3aGV0aGVyIHpzd2FwX3N0
b3JlKCkgd2lsbA0KPiA+IGNvbXByZXNzIGEgYmF0Y2ggb2YgcGFnZXMsIGZvciBpbnN0YW5jZSwg
dGhlIHBhZ2VzIGluIGEgbGFyZ2UgZm9saW86DQo+ID4NCj4gPiAgIENPTkZJR19aU1dBUF9TVE9S
RV9CQVRDSElOR19FTkFCTEVEDQo+ID4NCj4gPiBUaGUgZXhpc3RpbmcgQ09ORklHX0NSWVBUT19E
RVZfSUFBX0NSWVBUTyB2YXJpYWJsZSBhZGRlZCBpbiBjb21taXQNCj4gPiBlYTdhNWNiYjQzNjkg
KCJjcnlwdG86IGlhYSAtIEFkZCBJbnRlbCBJQUEgQ29tcHJlc3Npb24gQWNjZWxlcmF0b3IgY3J5
cHRvDQo+ID4gZHJpdmVyIGNvcmUiKSBpcyB1c2VkIHRvIGRldGVjdCBpZiB0aGUgc3lzdGVtIGhh
cyB0aGUgSW50ZWwgQW5hbHl0aWNzDQo+ID4gQWNjZWxlcmF0b3IgKElBQSksIGFuZCB0aGUgaWFh
X2NyeXB0byBtb2R1bGUgaXMgYXZhaWxhYmxlLiBJZiBzbywgdGhlDQo+ID4ga2VybmVsIGJ1aWxk
IHdpbGwgcHJvbXB0IGZvciBDT05GSUdfWlNXQVBfU1RPUkVfQkFUQ0hJTkdfRU5BQkxFRC4NCj4g
SGVuY2UsDQo+ID4gdXNlcnMgaGF2ZSB0aGUgYWJpbGl0eSB0byBzZXQNCj4gQ09ORklHX1pTV0FQ
X1NUT1JFX0JBVENISU5HX0VOQUJMRUQ9InkiIG9ubHkNCj4gPiBvbiBzeXN0ZW1zIHRoYXQgaGF2
ZSBJbnRlbCBJQUEuDQo+ID4NCj4gPiBJZiBDT05GSUdfWlNXQVBfU1RPUkVfQkFUQ0hJTkdfRU5B
QkxFRCBpcyBlbmFibGVkLCBhbmQgSUFBIGlzDQo+IGNvbmZpZ3VyZWQNCj4gPiBhcyB0aGUgenN3
YXAgY29tcHJlc3NvciwgenN3YXBfc3RvcmUoKSB3aWxsIHByb2Nlc3MgdGhlIHBhZ2VzIGluIGEg
bGFyZ2UNCj4gPiBmb2xpbyBpbiBiYXRjaGVzLCBpLmUuLCBtdWx0aXBsZSBwYWdlcyBhdCBhIHRp
bWUuIFBhZ2VzIGluIGEgYmF0Y2ggd2lsbCBiZQ0KPiA+IGNvbXByZXNzZWQgaW4gcGFyYWxsZWwg
aW4gaGFyZHdhcmUsIHRoZW4gc3RvcmVkLiBPbiBzeXN0ZW1zIHdpdGhvdXQgSW50ZWwNCj4gPiBJ
QUEgYW5kL29yIGlmIHpzd2FwIHVzZXMgc29mdHdhcmUgY29tcHJlc3NvcnMsIHBhZ2VzIGluIHRo
ZSBiYXRjaCB3aWxsIGJlDQo+ID4gY29tcHJlc3NlZCBzZXF1ZW50aWFsbHkgYW5kIHN0b3JlZC4N
Cj4gPg0KPiA+IFRoZSBwYXRjaCBhbHNvIGltcGxlbWVudHMgYSB6c3dhcCBBUEkgdGhhdCByZXR1
cm5zIHRoZSBzdGF0dXMgb2YgdGhpcw0KPiA+IGNvbmZpZyB2YXJpYWJsZS4NCj4gDQo+IElmIHdl
IGFyZSBjb21wcmVzc2luZyBhIGxhcmdlIGZvbGlvIGFuZCBiYXRjaGluZyBpcyBhbiBvcHRpb24s
IGlzIG5vdA0KPiBiYXRjaGluZyBldmVyIHRoZSBjb3JyZWN0IHRoaW5nIHRvIGRvPyBXaHkgaXMg
dGhlIGNvbmZpZyBvcHRpb24NCj4gbmVlZGVkPw0KDQpUaGFua3MgWW9zcnksIGZvciB0aGUgY29k
ZSByZXZpZXcgY29tbWVudHMhIFRoaXMgaXMgYSBnb29kIHBvaW50LiBUaGUgbWFpbg0KY29uc2lk
ZXJhdGlvbiBoZXJlIHdhcyBub3QgdG8gaW1wYWN0IHNvZnR3YXJlIGNvbXByZXNzb3JzIHJ1biBv
biBub24tSW50ZWwNCnBsYXRmb3JtcywgYW5kIG9ubHkgaW5jdXIgdGhlIG1lbW9yeSBmb290cHJp
bnQgY29zdCBvZiBtdWx0aXBsZQ0KYWNvbXBfcmVxL2J1ZmZlcnMgaW4gInN0cnVjdCBjcnlwdG9f
YWNvbXBfY3R4IiBpZiB0aGVyZSBpcyBJQUEgdG8gcmVkdWNlDQpsYXRlbmN5IHdpdGggcGFyYWxs
ZWwgY29tcHJlc3Npb25zLg0KDQpJZiB0aGUgbWVtb3J5IGZvb3RwcmludCBjb3N0IGlmIGFjY2Vw
dGFibGUsIHRoZXJlIGlzIG5vIHJlYXNvbiBub3QgdG8gZG8NCmJhdGNoaW5nLCBldmVuIGlmIGNv
bXByZXNzaW9ucyBhcmUgc2VxdWVudGlhbC4gV2UgY291bGQgYW1vcnRpemUgY29zdA0Kb2YgdGhl
IGNncm91cCBjaGFyZ2luZy9vYmpjZy9zdGF0cyB1cGRhdGVzLg0KDQpUaGFua3MsDQpLYW5jaGFu
YQ0KDQo+IA0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBZaW5nIEh1YW5nIDx5aW5nLmh1YW5nQGlu
dGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFuYSBQIFNyaWRoYXIgPGthbmNoYW5h
LnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvenN3YXAu
aCB8ICA2ICsrKysrKw0KPiA+ICBtbS9LY29uZmlnICAgICAgICAgICAgfCAxMiArKysrKysrKysr
KysNCj4gPiAgbW0venN3YXAuYyAgICAgICAgICAgIHwgMTQgKysrKysrKysrKysrKysNCj4gPiAg
MyBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC96c3dhcC5oIGIvaW5jbHVkZS9saW51eC96c3dhcC5oDQo+ID4gaW5kZXgg
ZDk2MWVhZDkxYmYxLi43NGFkMmEyNGIzMDkgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51
eC96c3dhcC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC96c3dhcC5oDQo+ID4gQEAgLTI0LDYg
KzI0LDcgQEAgc3RydWN0IHpzd2FwX2xydXZlY19zdGF0ZSB7DQo+ID4gICAgICAgICBhdG9taWNf
bG9uZ190IG5yX2Rpc2tfc3dhcGluczsNCj4gPiAgfTsNCj4gPg0KPiA+ICtib29sIHpzd2FwX3N0
b3JlX2JhdGNoaW5nX2VuYWJsZWQodm9pZCk7DQo+ID4gIHVuc2lnbmVkIGxvbmcgenN3YXBfdG90
YWxfcGFnZXModm9pZCk7DQo+ID4gIGJvb2wgenN3YXBfc3RvcmUoc3RydWN0IGZvbGlvICpmb2xp
byk7DQo+ID4gIGJvb2wgenN3YXBfbG9hZChzdHJ1Y3QgZm9saW8gKmZvbGlvKTsNCj4gPiBAQCAt
MzksNiArNDAsMTEgQEAgYm9vbCB6c3dhcF9uZXZlcl9lbmFibGVkKHZvaWQpOw0KPiA+DQo+ID4g
IHN0cnVjdCB6c3dhcF9scnV2ZWNfc3RhdGUge307DQo+ID4NCj4gPiArc3RhdGljIGlubGluZSBi
b29sIHpzd2FwX3N0b3JlX2JhdGNoaW5nX2VuYWJsZWQodm9pZCkNCj4gPiArew0KPiA+ICsgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW5saW5lIGJvb2wg
enN3YXBfc3RvcmUoc3RydWN0IGZvbGlvICpmb2xpbykNCj4gPiAgew0KPiA+ICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiA+IGRpZmYgLS1naXQgYS9tbS9LY29uZmlnIGIvbW0vS2NvbmZpZw0KPiA+
IGluZGV4IDMzZmE1MWQ2MDhkYy4uMjZkMWE1Y2VlNDcxIDEwMDY0NA0KPiA+IC0tLSBhL21tL0tj
b25maWcNCj4gPiArKysgYi9tbS9LY29uZmlnDQo+ID4gQEAgLTEyNSw2ICsxMjUsMTggQEAgY29u
ZmlnIFpTV0FQX0NPTVBSRVNTT1JfREVGQVVMVA0KPiA+ICAgICAgICAgZGVmYXVsdCAienN0ZCIg
aWYgWlNXQVBfQ09NUFJFU1NPUl9ERUZBVUxUX1pTVEQNCj4gPiAgICAgICAgIGRlZmF1bHQgIiIN
Cj4gPg0KPiA+ICtjb25maWcgWlNXQVBfU1RPUkVfQkFUQ0hJTkdfRU5BQkxFRA0KPiA+ICsgICAg
ICAgYm9vbCAiQmF0Y2hpbmcgb2YgenN3YXAgc3RvcmVzIHdpdGggSW50ZWwgSUFBIg0KPiA+ICsg
ICAgICAgZGVwZW5kcyBvbiBaU1dBUCAmJiBDUllQVE9fREVWX0lBQV9DUllQVE8NCj4gPiArICAg
ICAgIGRlZmF1bHQgbg0KPiA+ICsgICAgICAgaGVscA0KPiA+ICsgICAgICAgRW5hYmxlcyB6c3dh
cF9zdG9yZSB0byBzd2Fwb3V0IGxhcmdlIGZvbGlvcyBpbiBiYXRjaGVzIG9mIDggcGFnZXMsDQo+
ID4gKyAgICAgICByYXRoZXIgdGhhbiBhIHBhZ2UgYXQgYSB0aW1lLCBpZiB0aGUgc3lzdGVtIGhh
cyBJbnRlbCBJQUEgZm9yIGhhcmR3YXJlDQo+ID4gKyAgICAgICBhY2NlbGVyYXRpb24gb2YgY29t
cHJlc3Npb25zLiBJZiBJQUEgaXMgY29uZmlndXJlZCBhcyB0aGUgenN3YXANCj4gPiArICAgICAg
IGNvbXByZXNzb3IsIHRoaXMgd2lsbCBwYXJhbGxlbGl6ZSBiYXRjaCBjb21wcmVzc2lvbiBvZiB1
cHRvIDggcGFnZXMNCj4gPiArICAgICAgIGluIHRoZSBmb2xpbyBpbiBoYXJkd2FyZSwgdGhlcmVi
eSBpbXByb3ZpbmcgbGFyZ2UgZm9saW8gY29tcHJlc3Npb24NCj4gPiArICAgICAgIHRocm91Z2hw
dXQgYW5kIHJlZHVjaW5nIHN3YXBvdXQgbGF0ZW5jeS4NCj4gPiArDQo+ID4gIGNob2ljZQ0KPiA+
ICAgICAgICAgcHJvbXB0ICJEZWZhdWx0IGFsbG9jYXRvciINCj4gPiAgICAgICAgIGRlcGVuZHMg
b24gWlNXQVANCj4gPiBkaWZmIC0tZ2l0IGEvbW0venN3YXAuYyBiL21tL3pzd2FwLmMNCj4gPiBp
bmRleCA5NDhjOTc0NWVlNTcuLjQ4OTMzMDJkOGMzNCAxMDA2NDQNCj4gPiAtLS0gYS9tbS96c3dh
cC5jDQo+ID4gKysrIGIvbW0venN3YXAuYw0KPiA+IEBAIC0xMjcsNiArMTI3LDE1IEBAIHN0YXRp
YyBib29sIHpzd2FwX3Nocmlua2VyX2VuYWJsZWQgPQ0KPiBJU19FTkFCTEVEKA0KPiA+ICAgICAg
ICAgICAgICAgICBDT05GSUdfWlNXQVBfU0hSSU5LRVJfREVGQVVMVF9PTik7DQo+ID4gIG1vZHVs
ZV9wYXJhbV9uYW1lZChzaHJpbmtlcl9lbmFibGVkLCB6c3dhcF9zaHJpbmtlcl9lbmFibGVkLCBi
b29sLA0KPiAwNjQ0KTsNCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBFbmFibGUvZGlzYWJsZSBiYXRj
aGluZyBvZiBjb21wcmVzc2lvbnMgaWYgenN3YXBfc3RvcmUgaXMgY2FsbGVkIHdpdGggYQ0KPiA+
ICsgKiBsYXJnZSBmb2xpby4gSWYgZW5hYmxlZCwgYW5kIGlmIElBQSBpcyB0aGUgenN3YXAgY29t
cHJlc3NvciwgcGFnZXMgYXJlDQo+ID4gKyAqIGNvbXByZXNzZWQgaW4gcGFyYWxsZWwgaW4gYmF0
Y2hlcyBvZiBzYXksIDggcGFnZXMuDQo+ID4gKyAqIElmIG5vdCwgZXZlcnkgcGFnZSBpcyBjb21w
cmVzc2VkIHNlcXVlbnRpYWxseS4NCj4gPiArICovDQo+ID4gK3N0YXRpYyBib29sIF9fenN3YXBf
c3RvcmVfYmF0Y2hpbmdfZW5hYmxlZCA9IElTX0VOQUJMRUQoDQo+ID4gKyAgICAgICBDT05GSUdf
WlNXQVBfU1RPUkVfQkFUQ0hJTkdfRU5BQkxFRCk7DQo+ID4gKw0KPiA+ICBib29sIHpzd2FwX2lz
X2VuYWJsZWQodm9pZCkNCj4gPiAgew0KPiA+ICAgICAgICAgcmV0dXJuIHpzd2FwX2VuYWJsZWQ7
DQo+ID4gQEAgLTI0MSw2ICsyNTAsMTEgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgeGFycmF5DQo+
ICpzd2FwX3pzd2FwX3RyZWUoc3dwX2VudHJ5X3Qgc3dwKQ0KPiA+ICAgICAgICAgcHJfZGVidWco
IiVzIHBvb2wgJXMvJXNcbiIsIG1zZywgKHApLT50Zm1fbmFtZSwgICAgICAgICBcDQo+ID4gICAg
ICAgICAgICAgICAgICB6cG9vbF9nZXRfdHlwZSgocCktPnpwb29sKSkNCj4gPg0KPiA+ICtfX2Fs
d2F5c19pbmxpbmUgYm9vbCB6c3dhcF9zdG9yZV9iYXRjaGluZ19lbmFibGVkKHZvaWQpDQo+ID4g
K3sNCj4gPiArICAgICAgIHJldHVybiBfX3pzd2FwX3N0b3JlX2JhdGNoaW5nX2VuYWJsZWQ7DQo+
ID4gK30NCj4gPiArDQo+ID4gIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCj4g
PiAgKiBwb29sIGZ1bmN0aW9ucw0KPiA+ICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqLw0KPiA+IC0tDQo+ID4gMi4yNy4wDQo+ID4NCg==

