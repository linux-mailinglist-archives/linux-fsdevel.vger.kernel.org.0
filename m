Return-Path: <linux-fsdevel+bounces-67855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42715C4C144
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592AF4244A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98DF2F8BDF;
	Tue, 11 Nov 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myjUiqlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46634D390;
	Tue, 11 Nov 2025 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844912; cv=fail; b=OzRjPr+zNXAvdMe6IC7STjFGyhD4itUPI36wjtaFuf2CadC8/9lNKxIR9FoYuPSfc68aNC5/z/BoP/WCgoRxJ6F1HOG7isK7SuB5VwrY6kan0gj6qGq49GOhhn4CwUuD5zJBcmXHs1nRyygCmAe9awNKVflXgvF6Gzd5RoXe44g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844912; c=relaxed/simple;
	bh=rVtifQ6Pmwr8EK1hqAOaG8nq/G65StGvJbv027K5nAA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nH/rCTw6oJE9mZvL77kB5Dn9SE4zGpX5HM3qs3KU9jwP7iQqfZcZpxaE+HRApTj8VnMtqmE78AbNBklBskUK3UefloqBGERddfUuHH1LlGq/t4iXN3qkBjJL0/owiixnMpttgJKFy1WTZncCXSroc74G7+b24aqeaUOCBx91c+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myjUiqlj; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762844907; x=1794380907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rVtifQ6Pmwr8EK1hqAOaG8nq/G65StGvJbv027K5nAA=;
  b=myjUiqljM7bZs461Mkgz8DIOBuSZH6ATCZ1q591VvZ/kcqwJJOMJ5muk
   Y1fsz31PTBH8VlcosZl85DYTh1PjfgNqZSLcQlPrIjLQ8DKl7R7QEwUUe
   5pq9HIHLIWW9dDuY+UH7Nb1or2GAmzoKPSr/Gyj+7eLOJE97hKGFM+KXN
   3yOb2pSNpYSvgaPm4Mpc76CRTmuqMs86HwlUn8nX0aJKMzMdpL70MLksO
   TpwSDKlq1JANd18Ob2Mr85MXDZ74pHj4ElCMfM+8qI1rz8HP28DLoiL2w
   vg4BtYzPH/vzhidzrMKLjuVUjaFbjCbydBLd6f3HSij9ZARKRIaHj7IO9
   w==;
X-CSE-ConnectionGUID: lexQ9AmnRDGiD1ycLOOzKg==
X-CSE-MsgGUID: SA64lUg1TjW0XgZzHrYwVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68763500"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="68763500"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 23:08:26 -0800
X-CSE-ConnectionGUID: Dqz4Ejv7S1qYg6Osa3SxlQ==
X-CSE-MsgGUID: G3LXI5J+RZ+n/7tXA0LipA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="189059114"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 23:08:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 23:08:26 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 23:08:26 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 23:08:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA7LrKa4js7WyRw5GMXcb3/HUIcq1EUaNDndKzocmpj2T6ckqp/5cSQV6ZrWke/vEaABpqJgkX++Tz8IB2mr6PB9gjsXHrsu7/fG0od7ifKOydQac5nrt4kRalrL+i0MuAZ+zxUb0SB9aOnt7tZA/mFcYFDHjS/tlSCB2FcdIDQom7s9wizApo02rt0e5Yu3KoZkKSsoYaN8pyv0kzYEbXnX12Iob/FigXu4mP5LwrWphN8SH+8tWw5QKcEcGQ/EHJc29HRutwfyvog0n0xK25NewQ4vnx2VUkzugoEumd9KVywMJmICE2DvOFoYyEsKCbPt9Xyn/Vr+dqaw98WvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAERIpw//1wU6iEG914P2+GuMirAbWfNXsGTmjl2pH0=;
 b=BCOe/tZJY2085ZkojAJMf6ZZa62ikESxLGjyxn4tZngMSH7N8g+lfdmjc7XnsfjDCKMxBCQsHQ7SzbtqlSuXHUX4dvC0fivr7NTof6Kotx/JmXFk1U0NKStLFDWuYaD4/vaAhVlyaK5B1wB/omF2ZAlTVWgv6H7eZZPG+yJjRMRta6wFMmP/scphZgcAfj34giS1YTDr3FqGN2YT4L/wGFXfRts9dmlSz/t74uGoCj26K1shp3rnMGxx0csWQdI7jaSfqgmqZJ+md/vfVKyVgDSNl+3c6KU/P8SYP5Z0iVbroDYrbcPVESuZ26E0Iznfi/V5ADcXAxlMwK35UOO8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPFF2B8F6C64.namprd11.prod.outlook.com (2603:10b6:518:1::d60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:08:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:08:19 +0000
Date: Tue, 11 Nov 2025 15:08:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [ns]  3a18f80918:
 WARNING:at_include/linux/ns_common.h:#put_cred_rcu
Message-ID: <202511111547.de480df9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPFF2B8F6C64:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c2ea1e-f957-40a4-e349-08de20f11796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nkAonsPvkcxWr7K8okomrGKMUIgIY1SqfZhTLIftb0raKyQrvFDeS5yPVY1n?=
 =?us-ascii?Q?5WP8Z4S0YcWvgheFwOUURDzmzu+JXEwJkDzKYYCFGv/dnGZTlKe5pCF7GKXD?=
 =?us-ascii?Q?uEVhf0R/eSP8wbeFe4NF+cKE/FWV0n9KgyWfDqTkGZ2Wi31R9NoHTrNO5S+i?=
 =?us-ascii?Q?d+VsVz4La6IT8Mpc/KYgxlQ+sbHOCntCXk+98zUdFN1kdig/A+hKGPZpTBIt?=
 =?us-ascii?Q?zehRw9z5wIkTDbnSeuJGCFX5moRS5M3sF97BVPp6rlTXfSl5zctWz4Z6fnlr?=
 =?us-ascii?Q?B1LoGj1h8FOFLJY64YOR/XH2EJ0X+5JL11b+IzkJzcN6G34q1ZedS3IeN55X?=
 =?us-ascii?Q?NWwdm435v3qQVg5+IJO4fp2R31GVhndlEkzMDiuaLKxldMtMQOtGCOI6m8MZ?=
 =?us-ascii?Q?zBpwnqqUk1Rk3pYnpgwhjk8PBCbtC5NrFjR/sOIj5ucTDKZqRY3slu/arWH9?=
 =?us-ascii?Q?jjR1y4yz7xcX2Q0I55yzDidmwJZF8KaQVimEms3d//O+2t2CCmdzKPlESgMm?=
 =?us-ascii?Q?n+7u/sDsnf86ItPhn+dW6+FipOJn833Y3J6hgHixGriX0icTcRWaMn9lISrd?=
 =?us-ascii?Q?xbsWd/hd8jHU91LTJw1ySmRu/+m/teDj+SfY4KpcEnrv4Z8zyAyByF0gSknt?=
 =?us-ascii?Q?o3aO+t32BAtrnPAEvhxKznIVgYvOoXwtl2M0BYWpQZs6cYaKXMQHIfX4OWK2?=
 =?us-ascii?Q?HyTB5aTs9ZbJqRfOmJSu5t5IQy5i4w7cHhGHomwkjX94QhQPcDUMUyE4Dnb/?=
 =?us-ascii?Q?zRLIEJrumZ75kqQPH/cWtYQzZI3TuuxMh+de06GdtxzC5I9QQ+32b6ReYWfo?=
 =?us-ascii?Q?1HN9HaKEyTHNZ6fX6dgNSaIaOck05FqJgfZR5c3h47ufHek6amNFigoavH0g?=
 =?us-ascii?Q?+Y6S48QbGKO7apN8VKrimiti3Oe2t7AB0e/VszZbB5cnXbe/yXp5cj+Kwl7W?=
 =?us-ascii?Q?gc6DNPiMVhRR9ZXb/4gLsOT3q26tOBUVHZ8o5JQ6Jip9VmD8VtJXv1yR2jYh?=
 =?us-ascii?Q?DFQWytyZlrMrfkAh14AINvmtNZG8uX/kAa2ktshBFu0tgGIQxjb8q/Uxs1g9?=
 =?us-ascii?Q?GFvpEWVIrBT+qEUWedGLhvH4Xe74ehYFUsPa2sVHlvC2E+PL+ULOX5v/93j4?=
 =?us-ascii?Q?n79bcs7SHAIMNzIXp0hJao5bkICUBPmYNiIfyovdmCjzXPljXZnDZ6XEl3Fc?=
 =?us-ascii?Q?ed8jYs8DWGMmhUOyG1ZkJtJZOHXDvHMSPxVBVo6z/jpxSJJ74RiMEA+qaK7+?=
 =?us-ascii?Q?XCyL5zL7Z4aHUYXrYEYcvnfDdFWDjdTRmbmsnzZcO1N8ckBqbTdcOkcJMyDf?=
 =?us-ascii?Q?vHW40QECTcvxdv2u5Dpl+8NOIhfoI7Pmb5QQfRca2xMz7bAaaW+lspWM2L3G?=
 =?us-ascii?Q?4cJYwfbhlD5cM37+Clx9KpenCyQVn3zFmr9Qek8V8l+8ofDprtPkClfk0ip0?=
 =?us-ascii?Q?O7NQeOpLHIdz6ni9EVEKUjOVSNhVUf7H4cexxhTiOTuhtq0sFCFfcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmnwjTW6+jWAzQ8cdrHEzFjVkM974ZSU/0LJlSORv2r6ul/Lbk5xQWs0tAWY?=
 =?us-ascii?Q?RFjV7r/qDjFo7kL1Njnt6W/dY0gKwlXPzf0WFoQ7cIUyyZOn0w2YW6JvjXJg?=
 =?us-ascii?Q?IoM0pHpL+luG47tsNVFRAZzZfgG1kN5MDAW/l/UEqK06Y7PH4wJrRVztFMVZ?=
 =?us-ascii?Q?y7YDZ+85U7shqZja270q7GBxwt+SE0aJTYZYofdlkIYlPmoLKNsliofmp63a?=
 =?us-ascii?Q?HHpRPeXfpNqQ7fEvsPu0IrJspG3Jym3qY7Y3lVPrWRoeQ2RLs4dkCsUsGeot?=
 =?us-ascii?Q?2BLUxwBxpqEcqzV/qlZuu8zzbCeLAFqVgJKN3Nn8HB1PHfaB/1yX7z8t3gbv?=
 =?us-ascii?Q?gtvw4eRta30QHb8Q6zs62oWjGLZCw2EZNOKEiZXFzttNW+nnLZINlfXv3N+E?=
 =?us-ascii?Q?iL813/vY3MFTz62Lpo9C8dM8c49OpIXYQR0se4UIsVFdIJ5v7KT97WXuRGn9?=
 =?us-ascii?Q?/8OpvXfcrjU83rFranQ5m72474dTmbxOWbMoc03zYajl7EfKpFSYoH/HwOJI?=
 =?us-ascii?Q?DONEFCfjMT6ILhN4Xb9O4HcT+WWT7uQ6Jb57EJfqXAyXZEt9/gZcYpSU4kLq?=
 =?us-ascii?Q?8J+IOtZNSOcstAsYeyNUnPUPdHxMvq80Trhz6uOoGhA4L2+mScawALaYfuVq?=
 =?us-ascii?Q?OAYkXxcRb051Es17ymIqeijOD+NVPU+tnRTJPe1EDEMIse/1EOmIdGBKgIb4?=
 =?us-ascii?Q?uH+U2Ab0jwMSD0SvyHCFtf1zqxL6LIDWR5GuCZL26AetYRqm6wOaa4Z64ABF?=
 =?us-ascii?Q?OcbX7/C6KK+C/+59k2uIQm8WHQWZf+aErNUvhhEbuBJNDWxtp5CJfnkAXRIw?=
 =?us-ascii?Q?O27rBvl7LjMt3f4Mn47cO7BsDRjqdmhH2Hs14kyXf6PkDADjUhRLKxJNObSE?=
 =?us-ascii?Q?5/He6Fey5ggM/MAXpaT6IoTwY3YR36jAeV4hpK0KMB7a3kNXXzInE8gBB4jR?=
 =?us-ascii?Q?jx8HuAL5jnL2i68qZmlnCthoxIt+g8UlbqxbwhA5+ecZVylQD8MnP5/SVha7?=
 =?us-ascii?Q?55SdsilBCbmvbXc+3NClfyE3VTBVn7sKkZqGi1spIdefjB5McOEnSewZJUfq?=
 =?us-ascii?Q?C979NCN/U1nPCHF8OcApvUbMLZC1WCK6zuNXxGtkMjOaqCxjVc17yng9KziJ?=
 =?us-ascii?Q?okmJYY210CwtHfzh8JsWUAUuTtBGP2g5dapHvcsJubRTC/QwhixAZAINxf3N?=
 =?us-ascii?Q?D8hnIKXtK6siEsWAUsdTaSTELVhndIpIaf3CDv4ogPF/6Wz7PxMMbWJo0YGw?=
 =?us-ascii?Q?XuI4wRJfI6HXj8eXPldomfZ4mFOB/EE/Xql/kaWTxp5b3k60dqkAgCjb3URu?=
 =?us-ascii?Q?eV/gv3WyDKgf6gsakBwLr1RBKMZ9yonnRkYfROHbDCOEMu+2/ypGNrWHAfvu?=
 =?us-ascii?Q?5pc72pg679v6gFzqEDU9EitB43t/ftlgRHd0LUiEUgQhhpOHvyYNwWclN4UJ?=
 =?us-ascii?Q?C6aBaUQSKMVf3aIQzh0xOCoN6zVFIoUjr4uJ3Q8uDuriiNTn97pJCfiAhIEo?=
 =?us-ascii?Q?A5wiYRIGh9G22Hsp2peksCbWB2x+Lh5VX/QvLJbUUtBhbwlKkSkTWam/WtFa?=
 =?us-ascii?Q?4i3/jDewObZRXKe3Vecz53YwLRDvJJQFVLYBDC3XhbXaCpC+DtWky5UlAVJK?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c2ea1e-f957-40a4-e349-08de20f11796
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:08:18.9860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCE9inrKRqlTKuvj4SPFUIQFRvwrtiEgxMs9Jes6EcMwU+TpmwkjiXWJqRQ5YQaAB5D+XAVOTldSuz108f+gMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF2B8F6C64
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_include/linux/ns_common.h:#put_cred_rcu" on:

commit: 3a18f809184bc5a1cfad7cde5b8b026e2ff61587 ("ns: add active reference count")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5



config: x86_64-randconfig-r053-20251109
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511111547.de480df9-lkp@intel.com


[   41.172047][    C1] ------------[ cut here ]------------
[   41.172821][    C1] WARNING: CPU: 1 PID: 0 at include/linux/ns_common.h:227 put_cred_rcu (include/linux/ns_common.h:227 include/linux/user_namespace.h:189 kernel/cred.c:88)
[   41.173907][    C1] Modules linked in: serio_raw(F) floppy(F) tiny_power_button(F) button(F)
[   41.174959][    C1] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: GF               T   6.18.0-rc2-00014-g3a18f809184b #1 PREEMPTLAZY  9f2dc8152166a7dcc87d7d6a6b2b12a17475cded
[   41.176815][    C1] Tainted: [F]=FORCED_MODULE, [T]=RANDSTRUCT
[   41.177517][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   41.178764][    C1] RIP: 0010:put_cred_rcu (include/linux/ns_common.h:227 include/linux/user_namespace.h:189 kernel/cred.c:88)
[   41.179419][    C1] Code: 02 48 89 e8 83 e0 07 83 c0 03 38 d0 7c 0c 84 d2 74 08 48 89 ef e8 0d 9f 55 00 8b 83 30 03 00 00 85 c0 74 09 e8 ae 24 1c 00 90 <0f> 0b 90 e8 a5 24 1c 00 48 89 df e8 fd a9 1b 00 e8 98 24 1c 00 4c
All code
========
   0:	02 48 89             	add    -0x77(%rax),%cl
   3:	e8 83 e0 07 83       	call   0xffffffff8307e08b
   8:	c0 03 38             	rolb   $0x38,(%rbx)
   b:	d0 7c 0c 84          	sarb   $1,-0x7c(%rsp,%rcx,1)
   f:	d2 74 08 48          	shlb   %cl,0x48(%rax,%rcx,1)
  13:	89 ef                	mov    %ebp,%edi
  15:	e8 0d 9f 55 00       	call   0x559f27
  1a:	8b 83 30 03 00 00    	mov    0x330(%rbx),%eax
  20:	85 c0                	test   %eax,%eax
  22:	74 09                	je     0x2d
  24:	e8 ae 24 1c 00       	call   0x1c24d7
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	e8 a5 24 1c 00       	call   0x1c24d7
  32:	48 89 df             	mov    %rbx,%rdi
  35:	e8 fd a9 1b 00       	call   0x1baa37
  3a:	e8 98 24 1c 00       	call   0x1c24d7
  3f:	4c                   	rex.WR

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	e8 a5 24 1c 00       	call   0x1c24ad
   8:	48 89 df             	mov    %rbx,%rdi
   b:	e8 fd a9 1b 00       	call   0x1baa0d
  10:	e8 98 24 1c 00       	call   0x1c24ad
  15:	4c                   	rex.WR
[   41.181507][    C1] RSP: 0018:ffffc900001c8e58 EFLAGS: 00010246
[   41.182352][    C1] RAX: 0000000000000000 RBX: ffff8881649b8780 RCX: 0000000000000000
[   41.183326][    C1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   41.184311][    C1] RBP: ffff8881649b8ab0 R08: 0000000000000000 R09: 0000000000000000
[   41.185324][    C1] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88815d490c80
[   41.186287][    C1] R13: ffffffff83d2b7c0 R14: 0000000000000004 R15: ffffffff813e6e70
[   41.187244][    C1] FS:  0000000000000000(0000) GS:ffff888799e76000(0000) knlGS:0000000000000000
[   41.188285][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.191457][    C1] CR2: 00000000004003c0 CR3: 0000000003c88000 CR4: 00000000000406b0
[   41.192491][    C1] Call Trace:
[   41.192939][    C1]  <IRQ>
[   41.193359][    C1]  rcu_do_batch (include/linux/rcupdate.h:341 kernel/rcu/tree.c:2607)
[   41.193952][    C1]  ? rcu_pending (kernel/rcu/tree.c:2529)
[   41.194567][    C1]  ? rcu_disable_urgency_upon_qs (kernel/rcu/tree.c:725 (discriminator 1))
[   41.195408][    C1]  ? trace_irq_enable+0xac/0xe0
[   41.196177][    C1]  rcu_core (kernel/rcu/tree.c:2863)
[   41.196782][    C1]  handle_softirqs (arch/x86/include/asm/jump_label.h:36 include/trace/events/irq.h:142 kernel/softirq.c:623)
[   41.197442][    C1]  __irq_exit_rcu (kernel/softirq.c:496 kernel/softirq.c:723)
[   41.198071][    C1]  irq_exit_rcu (kernel/softirq.c:741 (discriminator 38))
[   41.198779][    C1]  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052 (discriminator 35) arch/x86/kernel/apic/apic.c:1052 (discriminator 35))
[   41.199466][    C1]  </IRQ>
[   41.199885][    C1]  <TASK>
[   41.200311][    C1]  asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:569)
[   41.201027][    C1] RIP: 0010:pv_native_safe_halt (arch/x86/kernel/paravirt.c:82)
[   41.201736][    C1] Code: 48 8b 3d 28 51 54 02 e8 23 00 00 00 48 2b 05 fc cf af 00 31 ff c3 cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d 97 fc 0e 00 fb f4 <c3> cc cc cc cc 41 57 41 56 41 55 41 54 55 48 89 fd 53 44 8b 6d 00
All code
========
   0:	48 8b 3d 28 51 54 02 	mov    0x2545128(%rip),%rdi        # 0x254512f
   7:	e8 23 00 00 00       	call   0x2f
   c:	48 2b 05 fc cf af 00 	sub    0xafcffc(%rip),%rax        # 0xafd00f
  13:	31 ff                	xor    %edi,%edi
  15:	c3                   	ret
  16:	cc                   	int3
  17:	cc                   	int3
  18:	cc                   	int3
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	cc                   	int3
  1e:	cc                   	int3
  1f:	eb 07                	jmp    0x28
  21:	0f 00 2d 97 fc 0e 00 	verw   0xefc97(%rip)        # 0xefcbf
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	41 57                	push   %r15
  31:	41 56                	push   %r14
  33:	41 55                	push   %r13
  35:	41 54                	push   %r12
  37:	55                   	push   %rbp
  38:	48 89 fd             	mov    %rdi,%rbp
  3b:	53                   	push   %rbx
  3c:	44 8b 6d 00          	mov    0x0(%rbp),%r13d

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	41 57                	push   %r15
   7:	41 56                	push   %r14
   9:	41 55                	push   %r13
   b:	41 54                	push   %r12
   d:	55                   	push   %rbp
   e:	48 89 fd             	mov    %rdi,%rbp
  11:	53                   	push   %rbx
  12:	44 8b 6d 00          	mov    0x0(%rbp),%r13d
[   41.203822][    C1] RSP: 0018:ffffc9000014fe38 EFLAGS: 00000246
[   41.204551][    C1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   41.205618][    C1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   41.206601][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   41.207613][    C1] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881008322c0
[   41.208650][    C1] R13: 1ffff92000029fca R14: dffffc0000000000 R15: 0000000000000000
[   41.209689][    C1]  default_idle (arch/x86/include/asm/paravirt.h:107 arch/x86/kernel/process.c:767)
[   41.210257][    C1]  default_idle_call (include/linux/cpuidle.h:143 (discriminator 1) kernel/sched/idle.c:123 (discriminator 1))
[   41.210879][    C1]  cpuidle_idle_call (kernel/sched/idle.c:191)
[   41.211506][    C1]  ? arch_cpu_idle_exit+0x30/0x30
[   41.215390][    C1]  ? tick_nohz_start_idle (kernel/time/tick-sched.c:753)
[   41.216069][    C1]  ? tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:81)
[   41.216763][    C1]  do_idle (kernel/sched/idle.c:332)
[   41.217295][    C1]  cpu_startup_entry (kernel/sched/idle.c:427)
[   41.217929][    C1]  start_secondary (arch/x86/kernel/smpboot.c:315)
[   41.218650][    C1]  ? set_cpu_sibling_map (arch/x86/kernel/smpboot.c:233)
[   41.219100][    C1]  common_startup_64 (arch/x86/kernel/head_64.S:419)
[   41.219506][    C1]  </TASK>
[   41.219783][    C1] irq event stamp: 42022
[   41.220131][    C1] hardirqs last  enabled at (42021): tick_nohz_idle_exit (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 kernel/time/tick-sched.c:1472)
[   41.220844][    C1] hardirqs last disabled at (42022): __schedule (kernel/sched/core.c:6814)
[   41.221520][    C1] softirqs last  enabled at (42010): handle_softirqs (kernel/softirq.c:469 (discriminator 2) kernel/softirq.c:650 (discriminator 2))
[   41.222380][    C1] softirqs last disabled at (42001): __irq_exit_rcu (kernel/softirq.c:496 kernel/softirq.c:723)
[   41.223139][    C1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251111/202511111547.de480df9-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


