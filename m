Return-Path: <linux-fsdevel+bounces-30134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF10986AE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 04:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E2283B05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 02:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49F17A918;
	Thu, 26 Sep 2024 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAJyrz5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26217278D;
	Thu, 26 Sep 2024 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727316970; cv=fail; b=VwHIBL/eqoZIn4hahCawfWeqCDaM5AYBMMYiJX7gMbcnGQRtUwfj34s87xOXpjwVL+4hohvUqCwLY2nTZC5PsdLH5pkXVLhEgXyNYMnXTDnDNek6bV7YxLA0TX2Vun2Wg7gyrynI0Vv+o560V4mGCGbHq2gRGccoZ/aUXwXGwYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727316970; c=relaxed/simple;
	bh=bwkfPtfd0mTPGpRwBi0XzewTyrGuO7aXGvCZZRTErKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c5YeRGJsnfznQRyDl1w4lq7WtiJCjjO7SX0TJ7PAK9aUGRyduEqCGk2+nhYZwRq147o+M2Rku9Fmfh7/MzpeQY7XgT6NSyREsKaHL8UX4it3POT5jmTATO9gAdPF+eIeyqtV7reGD7TO2aIphqcY7hBe51KqIknLD3WDLXuMBtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAJyrz5x; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727316969; x=1758852969;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bwkfPtfd0mTPGpRwBi0XzewTyrGuO7aXGvCZZRTErKU=;
  b=lAJyrz5xcZQdGme/+ZjnDTRnSQEl50knnpW9NGhQP0TeMHI8Fp9VKjfw
   zXLrbEUS6hrZmdnLORrhIrIBRfoXeW8daNbkc01tgASb9cRkZk7nv3QqY
   2yR2nuSyN/32eN/YIP11coGK1+dhgv49fDwtyAmA7mgH22LXJWy+ktNf5
   vdlkkc1mIU5b038ROH3yEAczUVWcxQknrtNAicru0Vexvpv1h1qZNU/NF
   7z68kizu71QOaoreuOGMBjenGIjVCdxlGIQeKV2GYsGtduD5UiNL1S+XV
   pMGtI0GYtgifF1CPRlgxjS08h83u+85PPVeOT6reE6bWO7Jh3DFLJq13Q
   g==;
X-CSE-ConnectionGUID: wt04A3hGRUWLJFKP5vxs8w==
X-CSE-MsgGUID: lFEw8fZDQa+VnelWF8C+Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37749988"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="37749988"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 19:16:08 -0700
X-CSE-ConnectionGUID: t1BXk8EUTna9uL20QIR0Iw==
X-CSE-MsgGUID: FD4KXVZPSvCrVEJaHOlzLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="95311882"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 19:16:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 19:16:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 19:16:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 19:16:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 19:16:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqH+tiP9RdjiSi/wD6Wxc+yJyAu9ONnrWhArHeI514Z8GNWkm1fm/5/r0CC6QeYGT3b1zriJLNPQBZ3R9i9WrbVM7HKT5fsuhDxdIwFwkLq38hZOVnjhd+1nwfvswNvhLKJ+YeMbVx2YQGuur3Z/pQi9HtP2Jgra6i9mIV82gFd0qASsfR885J8jKvD3FuEiwME81iZfl+AS7BJ1pD274xQYhwgpuX8/d8BtVOdr0gXAAzJzPPB0pNGpMS36tjWH2MpUIG9zhEcK8wBjB+TNF5RvmPrzBKnWiJmHnrY4F2cOZUDoAv/PoTXR7ANXmR9rmGVreEszVTGvnuQI8/C7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP05yi3WLhgRC4BlCcR5c8cepO4qz7P2XKxoRfUo0QQ=;
 b=Ri0PXaMFNHMrC38zlfJQodPJILgcTh0235ADabWoG5xcLr8oxyZo/3NrI/zDgyqA9DtScQXIhyYsL9feSybzV7T5WrqsgeF2n6ARjhzbVkqBAHtUSrNURYqGGThCTfgHVfUeIVG0khA3VtmxfC/6Vs4499Bns2dTrVmVC9sEg9MIogAYnvW7aMGeEmxeOP1+wE0CDPQWvxeGE2J4epozKUPXjlwDH1u8oPE09bcYv0ZSlwsnJs8hCLdEyzqIzfQXUSA5QU/QM6OQOQmgcXSkd2AHDdAUm4DPycrBtu9rWHC1VsXKRjshrxYDtNuH6yY0vQh9AzkY+5UL5zzNOLXX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 02:16:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 02:16:04 +0000
Date: Thu, 26 Sep 2024 10:15:54 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [netfs] cd0277ed0c:
 BUG:KASAN:slab-use-after-free_in_copy_from_iter
Message-ID: <ZvTD2t5s8lwQyphN@xsang-OptiPlex-9020>
References: <202409180928.f20b5a08-oliver.sang@intel.com>
 <1191671.1727214007@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1191671.1727214007@warthog.procyon.org.uk>
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c55ae5-2793-4fff-4ee3-08dcddd12c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bktlugNfaC7WmvZ866J7PzT2IZaOZukPwB+I6t7NmhnIK0DOt4Kh3gkOVtWt?=
 =?us-ascii?Q?llmgYgDUDgqe3uh4Ieb6qaw/pjXa/dUOI577JLSCsYF5SRrfCygKc6ipU4o+?=
 =?us-ascii?Q?xJvZreVBGz0G6crfRGGnlS2RVvYRKJenYzmbO/CwuvPWQp/LgwGq9rY3b8nJ?=
 =?us-ascii?Q?c7Gfnj9xH+4Lus6NzT/91NuN+Ty2gjM6PWw9VpHslF6kGkZo9xmTwQIJyXZ+?=
 =?us-ascii?Q?oMQQQMcL7L1EwRYJRjaQEigZlIWouhYJOO+WXryAkFuOHAJi2C7m8GUEeNTl?=
 =?us-ascii?Q?J811a5Y3R/5Y6WowV4SDll61PmIgtnV8I8FUb79X7En8OBULVYrEsXE7fPou?=
 =?us-ascii?Q?3Ut2JQ3Uio3NQIF3jfcwPiw0Oi0MnHtqUq93CIIWO2wBmcGBO8JtUHuDGGBF?=
 =?us-ascii?Q?sy+DMA4FOXsP/taQacE+y1OD8nDRSIVmUDG0DPnBCNzLrL/5W7ohZpgHT8Hi?=
 =?us-ascii?Q?kLR3eRQBVifo4VAkkCQYRpv1qNONYnsDsU2VqbTzQ8mm+JBsCrGpvOoZHld9?=
 =?us-ascii?Q?bT9jf0wUcfxA5a6pt2bYdw//bOVocV628e5lhNCcOk9K3LrGdslSJGG/TK5I?=
 =?us-ascii?Q?Ptm1jJIr5L8up1Cjipdj5PmdR1cIo5Q/Y5rx7PuTaMTqF/FRTIZ/h3tbBAtd?=
 =?us-ascii?Q?tZYlU6qqg9e73BkIEwMxSWgPTTTKCTEmv2/MseQezcYPQAe26r/3vM6u3M80?=
 =?us-ascii?Q?Pbqb0rGlf8UBAKt5NtUTOK7gu3Z7Sf9pxW6R7mi6dX/kJ4bih/1yuK512SE4?=
 =?us-ascii?Q?q20a97nqkfT5WOOd8RaPsvNHBE0TdOkijze1R5DMiwGtwy2/eqB0KG35/fwg?=
 =?us-ascii?Q?lZso5crWXKzlKZQvZVKAmJ5kMuIWXigvnN4XXNSNBGjFFezUPInQqIvw3lwX?=
 =?us-ascii?Q?upbCymQ9WyNtH8A6jviCQCjG5gj7kNjMKu0H5OFYX6Bn3oetSZ7SvL7e73tj?=
 =?us-ascii?Q?WFdbRpB9JkAubTV3aAjS7Ouph1qYU9aH3cDHLM8rfiEtzbiAmeDhJLf0ncU5?=
 =?us-ascii?Q?13eazmdNtn4ajYArZx5qMqtd5fU9M38US3LFNnFp4ENhuHdLEraHug3WPIa/?=
 =?us-ascii?Q?TwqZuon0UkDVsakuKVSptHtSzks2/Kz0+K6ZqQy6YPps14VZR+eemcS3cdgE?=
 =?us-ascii?Q?burMXeZDD9cYHGKKbC7jvrOgMjkfgHWCbQzAkNgz0TaFKR7qcXSGObEQxR9I?=
 =?us-ascii?Q?Pyim7mZGUICYEcgH69gW0o4VLCVY23xkUWxVd+xZnFFRjbrEZehWCYzhKDgP?=
 =?us-ascii?Q?mfrVjnJ/CdlkExUAVeTLOkCPPKYsuGan+DEFxpuUnIu/6oSKMCOo238l75cg?=
 =?us-ascii?Q?scZbMboDPlbuqaqjcRkDeNpv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BNy95rbh+QIJIR2fFzqImOGIpuW2eqUDJ+EZsx/kXirFq47KiI83HerLriEZ?=
 =?us-ascii?Q?j0XocJA9LfHt5mCbYGqKwqhM1eF1JYkNcE6QzhWlECKps0YNqV7+h1p0rcmz?=
 =?us-ascii?Q?VA8KxfVdrFt2jOUpZSCrISnLvIB6/0FneyO3NJIAR3J+sG3eiU6FfBVG2g7I?=
 =?us-ascii?Q?G0nQNGEvO2rKHmVcBMA/l82K+ipcUH9SII21JNArVoB3OSADn/37lQai0CQI?=
 =?us-ascii?Q?+XBdM8Mr83zDrwiiuYqjsNoOUScQ5yloU02utcwPxlG/PrLVeh3dRVjFUL36?=
 =?us-ascii?Q?GOiSJxZMOWPPGlFb5eVCzUbDC4juwpswOTaR8HqZ4yH5KXT8tqfpv9VX1JWO?=
 =?us-ascii?Q?bnp04nWIYyZeZOdypY9+NPeP5h8sGzGIzW+vTORlhTxxRx3WpLCMUJ59WEP+?=
 =?us-ascii?Q?M+EdQcjyqiYQze+9T2pP9O1Y0vm3rK69QLo/hnnT2wr1TXPBQVLgEjSZ5u/G?=
 =?us-ascii?Q?x6OVmDvLLVKy4iP1e8wxlKM9oCO7d+w7p5mYAfdIK9c3S3I78H2CnqNl7Yff?=
 =?us-ascii?Q?bqmRMYi3gtb2KVg2dvZa2E8mt35OQ8NMk9fiQE+hEyXJlXD7N3c8exp7o7jI?=
 =?us-ascii?Q?IREwViQ8m1tN7X5BQeEzjwKb/vQ0TiCjZm0aWyWFmtzHq0m8oOsHC5OQ6PmH?=
 =?us-ascii?Q?raO4Y4vCRW1NqksMT8+uz0fikx0+DlrnLOS8WbGJGbBUzg0DrgWThte0RFHV?=
 =?us-ascii?Q?lGPcLgWaAJ63clWt/oG/DcPKml3S+W01WPA5sKFa5Gsh5klYl/yj1SdQ3kxw?=
 =?us-ascii?Q?KEfQn/hCoiwImzaGYPMJm7WrGbRzUWaWCPBv/Iq9GOLu/C+MBkg3QZZ9wGGg?=
 =?us-ascii?Q?GmlSobyHZ5E/KQgY/MGOzjEbzUkn6ZWhLjz4q+4b/zIm0R/AM2QlrCeuAHKJ?=
 =?us-ascii?Q?tAuinIs6+PlLBJ/dLIuuuD4GvMmED+Mb5SvofIYRRLvdRmOlhVcUO+WDbqfj?=
 =?us-ascii?Q?pdXbxNkKCU0JS6DJcABayQ+UxFrltWibJGCA9hAopFA4JJc/7eWmWOH7SBiX?=
 =?us-ascii?Q?NC0IWn7AethrUUbYvqTK2c1NXuJw0K30ae4ePg/wXPI2yoSXwbPTaJ/oVeNY?=
 =?us-ascii?Q?RA0x1d/LSP9P49CXyyW94emG9gt5V09cMpUTXdAArkjDbgRqiPkMs0Y1ATpP?=
 =?us-ascii?Q?pQUvTHpWc+G8LzUM3d3aHOYKN9hynzPQlGjz56YIgpvUaXxLAPzSjDrLFdz4?=
 =?us-ascii?Q?w1wuEDZCx4hiyXg3tyNeSbcyxp9qB+6ch931MwaoRT2KR3gO04aWUkKl6yo7?=
 =?us-ascii?Q?YaAafJqJgiWDzlqMEFtLSpAeKEi/krkbNfotyBMrdWjaBHBONsntYm99hT/Y?=
 =?us-ascii?Q?tbmAjtGCWvjeRKZdLjWd2nR/gtFcgZ632voFeldYv2XCGLJGnAYUmxyu7K9G?=
 =?us-ascii?Q?/lYKNCHABp271hHK7eG9RINlQxXPsUvqgG7+UfGmbegCsOGHr6G11lAtHMYG?=
 =?us-ascii?Q?t9p3NvH4oLWvoE5o+8Zw8fhiAu/SysYFwB0yjZaAaBtV4Iz4rElAiWdK1+cv?=
 =?us-ascii?Q?/mKAv/u/4giYTzhQYwloShKtHlodpmjxz+8I9BTwbcc/MZ/svkltB5h1uB41?=
 =?us-ascii?Q?RRbdr+x1nhCkccl7VMk00KTeISwKLfHLB40HszLS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c55ae5-2793-4fff-4ee3-08dcddd12c3d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 02:16:04.0673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQXCK5Ktqrv0EejZ44gOzlxLAes3Wvw1Y+nILUD548D9ta8JC87o+SICeXwx/AE2/1AX8h+oIeV0wz6K7TjA+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7643
X-OriginatorOrg: intel.com

Hi, David,

On Tue, Sep 24, 2024 at 10:40:07PM +0100, David Howells wrote:
> Hi Oliver,
> 
> Can you try the attached?

yes, this patch fixed the issue we reported.
Tested-by: kernel test robot <oliver.sang@intel.com>

we found this patch cannot apply on cd0277ed0c directly, so apply it upon
mainline commit
684a64bf32b6e Merge tag 'nfs-for-6.12-1' of git://git.linux-nfs.org/projects/anna/linux-nfs

for this report, we found the failure for generic/113
(https://download.01.org/0day-ci/archive/20240918/202409180928.f20b5a08-oliver.sang@intel.com/xfstests)

by the patch

=========================================================================================
compiler/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/4HDD/smbv2/ext4/x86_64-rhel-8.3-func/debian-12-x86_64-20240206.cgz/lkp-skl-d05/generic-group-11/xfstests

commit:
  684a64bf32b6e ("Merge tag 'nfs-for-6.12-1' of git://git.linux-nfs.org/projects/anna/linux-nfs")
  b0b53eafc5a38 (linux-devel/fixup-684a64bf32b6e) netfs: Fix write oops in generic/346 (9p) and maybe generic/074 (cifs)

684a64bf32b6e488 b0b53eafc5a3803dcebf2899cbc
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6          -83%            :6     dmesg.BUG:KASAN:slab-use-after-free_in_copy_from_iter
           :6          100%           6:6     xfstests.generic.113.pass


since generic/074 is mentioned, we also tested and confirmed it's also a good
fix. thanks

=========================================================================================
compiler/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/4HDD/smbv2/ext4/x86_64-rhel-8.3-func/debian-12-x86_64-20240206.cgz/lkp-skl-d05/generic-074/xfstests

commit:
  684a64bf32b6e ("Merge tag 'nfs-for-6.12-1' of git://git.linux-nfs.org/projects/anna/linux-nfs")
  b0b53eafc5a38 (linux-devel/fixup-684a64bf32b6e) netfs: Fix write oops in generic/346 (9p) and maybe generic/074 (cifs)


684a64bf32b6e488 b0b53eafc5a3803dcebf2899cbc
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6          -83%            :6     dmesg.BUG:KASAN:slab-use-after-free_in_copy_from_iter
           :6          100%           6:6     xfstests.generic.074.pass


> 
> Thanks,
> David

