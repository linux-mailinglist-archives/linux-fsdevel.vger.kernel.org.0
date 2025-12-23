Return-Path: <linux-fsdevel+bounces-71949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15567CD7E1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 03:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12693019BD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C826B742;
	Tue, 23 Dec 2025 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="niLRlSdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AF238166;
	Tue, 23 Dec 2025 02:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457396; cv=fail; b=B+k5WMhZGlebgEULMYCw5PYHkBoJiykEkZ/Zj1XYFdH6dm1ZHPlkVXjI9/aZeB8lq7sw+YbuHZ88PuXNVa3t+HNulz0Ctp4dqQk8FHjzofCjMzO9UuDP/4bsG+f4IoMw6jkyoUx2XoXoccAVdNdhtTK+KfBX+wguq4UZ7a6prxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457396; c=relaxed/simple;
	bh=7BbnKyBDJbogK92mZKxVLnfa2nZAQOsCsrGJN0BSgH4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LhjwlVs17ByqvXdqVifvgBBx8kBAMyAtyxFGgP1W/lFndnaj7gB/xRT88yqdg2KsmEN+dDxkNP+ZX0bFPzkj+t8LAk6yAKyJ0mRVsJasEIFhyGKyhYBUGDYtwIwswJqA1EhszYpUvSJgvKtW2u9s/uITVq7FQbCuns9e8+JRRoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=niLRlSdW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766457395; x=1797993395;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7BbnKyBDJbogK92mZKxVLnfa2nZAQOsCsrGJN0BSgH4=;
  b=niLRlSdW/zXdUisanYdL9qq80VMwRuipxlwFr5d+T/ZlckrzKw4Ne3xj
   FMfR2DSiFB1a7QlCE78qDwF87MTflYY+z4CDWrg86OyaaQUIOp/xtm3pg
   8y+JZKJoby3Nwdk8j/SHBf3Oobzy3jxA+kQFx0PU7NctmM9aTVND0ZCyq
   ebBwo7fYZEdaNcHwaiv4oUr2Ysu/lRQeNcZxejRQsYygp2hlouDugd6CT
   Ef/If60iip67meKG++tXdUAM9rn78Q0CifivqPTiveFebBUYLKCyFeQVw
   1jDvtznctgVSYN8Xx+OP7nPsruM2+hbDFAAAS8ZkEa1vQuEIUtsk5umJX
   Q==;
X-CSE-ConnectionGUID: oX0GJXuJR3KioP7tTp3JWQ==
X-CSE-MsgGUID: 7veG4aUUSgGHnq16iAwpHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="85724908"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="xz'341?scan'341,208,341";a="85724908"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 18:36:34 -0800
X-CSE-ConnectionGUID: SoXKpNzSQna35PHkAWTxAQ==
X-CSE-MsgGUID: C1jdThqsQvCoOaEeDeufcQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 18:36:34 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 18:36:33 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 22 Dec 2025 18:36:33 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 18:36:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBIcD7SZ5zWBcgskscj9uYL7B8XvrA7v2EiuWx3S+7o2d6zjKHMdSPTN69CJIXf7GEnsYQCWBZSxo3cEcAOUuNzDpmZbRdU54xP1Ru+9aC1hVhc4dndkKKNK++zI7pXOP+Hwgp/SwS1wlQShDvFEWTd/N6kYrlQpGHmpGux2Tfu8XRaVIqw6nLETQhyict0jwM3XVNPmCd+5m5eg3nW++fTqSUS6lAF7g9G0E2XofAXE0AGae8eKhVMNDa6jYrgYkP2Vf5F8zV4jWoo6iQftnptRTpBAyhP5m+x7CkaeWDIf5IMtMn6O5gsdL8QncZclPve307fU9FLQpeKl8rrh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/+LsOpsfTRllzu2Yrmz2yQ293WiJ4ddi/KUhWIpiIw=;
 b=I8wU44iX5y9M5+ZveK3VW2AI3diRSqLOxmNPTBRRXIYpIBEzUpzxFvTFTNA/5Te5yUSuF4gaoH9GfUmI0NODsdImQfhSsRse+2c6qzZVr2z9jQbFJe3+Xosp1szDeCn9YeO81o+2hoaZ+/X5bl/hqMwB2we5NiM4Gq0qKsOgIcVfKGYsONCJMNoCux59xl8z1GuLJ0VIQY9FiXgY9q5Z+T/E/pZRqnOIrdRDq6E2qnz9951cSPbkiOfGWa/a/HyVWOX81tocJ9wVsBO1RvcOFbZ3G4VqM1jqnCK2vghUJuajY4MAfk8UG5PTMMWO8ybkJtG5qeq2dWCRgal4uu4Opw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Tue, 23 Dec
 2025 02:36:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 02:36:31 +0000
Date: Tue, 23 Dec 2025 10:36:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Sandeen <sandeen@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [fs]  51a146e059: BUG:kernel_hang_in_boot_stage
Message-ID: <202512230315.1717476b-lkp@intel.com>
Content-Type: multipart/mixed; boundary="HvV0I5CcnTCdgCAl"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: f12c4eb8-10aa-4171-759e-08de41cc14ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|4053099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iz2m76j7yhuUcuLGVpr0Eef66rlO6fDrnAWbJEx040lK1qkqanSH0/P007ed?=
 =?us-ascii?Q?t8n/3b1Mh7RHZTpSFWw1cC2HRY7JY0OKXqaXuP+ZpDVRwGdBFSpzqqA2zNiQ?=
 =?us-ascii?Q?1TROtc7w9aQ8SwFVBPOvbrdOvcFd49S+xd7oo59qRnmz6nornKtGH03Jl+TS?=
 =?us-ascii?Q?+49KmHQrE/4Y5/00f9ByALGHOFFhLVakbbm4V0AQ8XOsS6svCAH6bLm1TWSZ?=
 =?us-ascii?Q?xc8oYhpcqMjYtRViHqLWulRrBoXJyhHLha29iJzhF70CPOqnJK++kLxitTvZ?=
 =?us-ascii?Q?sBYYxIRTBs4+7F/xnLGsFjGVDkC51SplxndCyBwkMFX6ROXcQX5jf2dgwvNh?=
 =?us-ascii?Q?jvME2RosbApl5KO+i/h61o4PF2NkgbsZQ8LjTeMyAuhZ1MtBlQBMt4vHROHV?=
 =?us-ascii?Q?tu6rZ3WsOgkxCfvWSU6dI4cxVT+GD5hVGPb6FQsk8S4Bvs/1P/xeVl0PKCsg?=
 =?us-ascii?Q?l9xUlv880fswSqpXOOhQUU2vhl4qFSZu614FE432NxB6jg0NBpwyOHp4G8Kb?=
 =?us-ascii?Q?pJyYkuTSYfe6rXJhIs2wpYJ0jFUEyNgcCrTGL80/2Oa3OpP9JdgEiY9Ddwh/?=
 =?us-ascii?Q?gQY30xIigRB5ARj4K7AQs3CM7NquVsweDNeoVz21BCvKWQZ0MW7P+JKC2TVL?=
 =?us-ascii?Q?ipVWD4hjyMaaTnmZV7GCIxF43d0yOZG9ZbIMJM+K35eX0F85LOwmm69AvYQ6?=
 =?us-ascii?Q?v2fsyDL6vUg5JdLPSdxwVChFKVxgKvGGtfXNdsvicANu3jP3rSbYXIOZ0iPI?=
 =?us-ascii?Q?7Pz8WCkZ2eB0rtqqmPj7mpFP493VGCwjYKdcK3rF0UoAFnbvtBejiQ5Gwls0?=
 =?us-ascii?Q?tIeaydT2ND9RGwMQY+hk3UuZISx7ShqTFm5AlcTli7IYU6vJidpt+Vwd0hyH?=
 =?us-ascii?Q?5TQ+f6qwpvqipR39hYC9vOA0uAJIFVd5/sCvp8DaLALYSVgolGM9++zfKVgM?=
 =?us-ascii?Q?KiRrT3iegnRnrfcszPJKT3VJPxK+Rf4sk2mZ4K1uggCysG3L1U+nPBFAjy2R?=
 =?us-ascii?Q?fisxovve9EhwxmDuDfH0z8RAY3w9KxCBPXwR7ivE6IlD+vPhVMnnJyliR086?=
 =?us-ascii?Q?ZLRocXDgcJXBVou1IfKETzDdx+G4Lpn8IrPz4XqK6HrdbHBey3a4MJWGH28c?=
 =?us-ascii?Q?QU9J6KGKg5FPkJHuuVF1jY4PUKp4Q+23SoRZM9GYRy6XOzWb5IQaJZAkIL9c?=
 =?us-ascii?Q?zEdABT9GPq3Utjl0epK4k93j6kDw/tvJRf/f+AKs/ofPI5i7jnuU8I05xld6?=
 =?us-ascii?Q?91RHIJ8ete3jw5fzAkV2/9CHP4EFKAaDrxJVYNiDSCGxv5+N0ueBe/Bp+XvG?=
 =?us-ascii?Q?8SoMkg6L+qt2yj4t0OrMGk3iaYg6ayyalb8l9EcpU9yKUimwdFYuNcnlO+4w?=
 =?us-ascii?Q?evp2iKRsGtn/lP3gGDUHxNSQ4dR8jjgQHBEcoHYEac0jSRa27P0fJsKrcc0j?=
 =?us-ascii?Q?veadFbAk3OVS6walibWWvp3wTFVz+Sgz1zFFm2hLNC1gSSVrh06JVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JvAkpKT78YKp6WOO87yc7V+MGqdRaLmIT9SBQMqrVImwx1mxOjdtqzUXU58m?=
 =?us-ascii?Q?JI/QMP6e61U3im1bycMXUoF33fTzCKGQNtnQpOcg+HoD7NvfOUEe5GtaE9uQ?=
 =?us-ascii?Q?xiBLB1lPlTdHzH/cglrir/ATiPFsvc5IhSYXhRi7OFt3kzV6GuaurrthUJSs?=
 =?us-ascii?Q?VlAIIMeLLSyfYs9ucC0LxHbcD//aCdz/MDH7oRMm3A52pS3YkgiXIVOS3sUd?=
 =?us-ascii?Q?owJ47ZxnDvkUPBCSSEPnrHDrT0uIXuqYghn/BWjc70yrgXN/EYmoypUYJ0Ce?=
 =?us-ascii?Q?1ebWah24tZOEDpTw+jUCmTBWpg0d27zD2ifMihUQ9bzEFgK6o0ZNdnglPYFp?=
 =?us-ascii?Q?W06VYRNrqdGmTwYe44TPU9hFZJ8Av1be5ycTvVSZ+mtmzRH4YtJxZNf2NiVE?=
 =?us-ascii?Q?EuNWSjwtt2Zs/v7n8+rGVbNL0GwojDvzoX6UfC79U+beOZHSr4pEwzTIFWPb?=
 =?us-ascii?Q?HnkweFIA5IQdv3DmIJfWAg7oxxC8pLGosUknHwVR1HmpiQb1M/aLCTAjBaqE?=
 =?us-ascii?Q?N3Je5/tymVS1N6bLWbgTCwssm7rqF87MfP1+1VectkUDyDbKCLzKVORgwCeT?=
 =?us-ascii?Q?L5XwBc5viFjYnz2GjM30O/oWVpw5IqqCGCSPHz0RI7s3DJZkj2hEP5wi6GW6?=
 =?us-ascii?Q?uVnGUoXusAuZl4MP2EatJp6ycI5uH6J1m2ryquheQ2oHCLcVONsTOhnC8gF8?=
 =?us-ascii?Q?cPwEqlchBFYJ5q5XbHY0fZ6NGsYAnhbAvkaihrj/GQersN/hHrnYrNRqRRUZ?=
 =?us-ascii?Q?dB5uukFDDWfUy8swqaWDq+q1srYjRZM41kT86J/zRxiU+tkoepO5Y9DLAlFA?=
 =?us-ascii?Q?PbTFfGJkaSSyL1+BEpuOBqCIhndeVjRd/ce2L2GMyCv7UsYZSQPP35IrdLTH?=
 =?us-ascii?Q?Kq6ZAL7/+on7W56N9kXgo1vLrpGpP+ajOXPzmcBRxBaHLpUAYUh3MNvbwAZs?=
 =?us-ascii?Q?DcqY/MrYu985Emqscv1HBeTwn9FaV89YyGw+ir+P1uzdnMYLdBxw/jrRtHWq?=
 =?us-ascii?Q?LGbD2fNV/NlG9vvfy+2T6qgBY/qVgx3oWt1nuj0HvjRzqgMftt4PDCWbs7Md?=
 =?us-ascii?Q?oWZh9frmTWUkPLPUMe1JiVt/gpiS+vro2aqd4X7URrOCgRJaK0C5Ht3nQKc5?=
 =?us-ascii?Q?uOBFWB/e8aTOc4FK8aFbwhkIUGycw19s6CrvKCkFg91yDPWPvjAx9s12ZorP?=
 =?us-ascii?Q?BGbgf1a90hR0UgHb4RWsrRFkrORb35KSgYLcPUVkNJ1y/ybHJlN+4gxOwCib?=
 =?us-ascii?Q?4lrZwRK6UOoIQxGzJVdpFfsQZCvERxvGfFnt7nt8emqMFu06RTRwZsvRxuZc?=
 =?us-ascii?Q?0ulZ25Kx411vebcsAZ43tskzgFFo1nBfWOzEpbvBamTqxB5MQV1VaB9rcLlB?=
 =?us-ascii?Q?u7YO84KAUtRjqV1n/FIi6xyDPOaP83IH2E5tVO93BxvSqc7ZUJnYKxTwcrm3?=
 =?us-ascii?Q?o/w4G6C0r3j7dyk79OPghHR2fS33OH0hqTHXE2N47+fvvHNS8HDJc2Tn2YQ8?=
 =?us-ascii?Q?sgSxjrPxtWtVaWPNkfthPZ62wmB0lOwwOVZrOZyQhtNFwS602QNi73QJBZSk?=
 =?us-ascii?Q?JPQa7vK7JYQ3lBkOcrdA1RGQqdl7k0oOPZN2FSDMkDKaZg50/2CJz6VdvbhH?=
 =?us-ascii?Q?K5QSoojDx7w2lo8uJv74hP/PzPjnDhBh319Tf8OwZo+jBvScKjoZj2p+OLYM?=
 =?us-ascii?Q?9JOUZ2LOyMAtQts622rem6JOTIIqvro4eAGns/6EkMSLpPbQG8ix9Ba7+ZDZ?=
 =?us-ascii?Q?9YAeDunEbQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f12c4eb8-10aa-4171-759e-08de41cc14ab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 02:36:31.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvIQuPbY+2TdPD9O+z45k3oFpXT0YrjCjfQM3Y+xEvleSeDPLZDhLGVz7+Dh9aKKzY6K9Av2kRw/HYibvL+a1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6054
X-OriginatorOrg: intel.com

--HvV0I5CcnTCdgCAl
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,


we don't have enough knowledge to analyze the connection between the issue and
this change. just observed the issue is quite persistent on 51a146e059 and
clean on its parent.


=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/sleep:
  vm-snb-i386/boot/debian-11.1-i386-20220923.cgz/i386-randconfig-2006-20250804/gcc-14/1

d5bc4e31f2a3f301 51a146e0595c638c58097a1660f
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200        100%         200:200   last_state.booting
           :200        100%         200:200   last_state.is_incomplete_run
           :200        100%         200:200   dmesg.BUG:kernel_hang_in_boot_stage


we cannot spot out useful information from dmesg which is uploaded to [1]. also
attached one dmesg from parent commit (d5bc4e31f2) FYI.


kernel test robot noticed "BUG:kernel_hang_in_boot_stage" on:

commit: 51a146e0595c638c58097a1660ff6b6e7d3b72f3 ("fs: Remove internal old mount API code")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master cc3aa43b44bdb43dfbac0fcb51c56594a11338a8]

in testcase: boot

config: i386-randconfig-2006-20250804
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512230315.1717476b-lkp@intel.com


[   15.178608][    T1] signal: max sigframe size: 1760
[   15.669386][    T1] rcu: Hierarchical SRCU implementation.
[   15.785114][    T1] rcu: 	Max phase no-delay instances is 1000.
[  104.130757][    C0] workqueue: round-robin CPU selection forced, expect performance impact
[  110.182304][    C0] random: crng init done
BUG: kernel hang in boot stage



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251223/202512230315.1717476b-lkp@intel.com [1]



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--HvV0I5CcnTCdgCAl
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-d5bc4e31f2.xz"
Content-Transfer-Encoding: base64

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
+fqFAAGbW8HIAgCe4EyYscRn+wIAAAAABFla

--HvV0I5CcnTCdgCAl--

