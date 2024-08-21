Return-Path: <linux-fsdevel+bounces-26450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744CB959565
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 09:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB392824FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 07:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741721A2852;
	Wed, 21 Aug 2024 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4KQ/OVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2B1A2848;
	Wed, 21 Aug 2024 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224258; cv=fail; b=qjR9t7/r20eahXwxVR1abgOq8xlHq4FxIIlStZ6nVnQRvFmyLS1OCeibwNlFWMJumpJgCIAG/stTaeE1/tJtZObYa9ARQObvzu0xnzRxUVIJWYgLLdkOD8/6AE5n8xNDZuVTG48NXyPgdFpcbVy8Mj4BX1KAnpuf55gD6xLciPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224258; c=relaxed/simple;
	bh=8VWThRhJ2BEBW7oTz5wfLZND/eebDDdO6kJxn58Qfrs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l8mstiW4hSXsSY2GV2RV9aXmNsjSofT+SZ18D9inrUAPxaMNs7ZAmvsgwVDRqVxQ3PWBUkktNerDuzv8EAVDDrvqpvzum+TWmfDfSh+Hgsg1ACHDtqwciKfbB+3KXPgxglM2mG9CI0POsXkIp+L0BEPTAgmkiAKpnPk5B6uLRsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4KQ/OVL; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724224256; x=1755760256;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=8VWThRhJ2BEBW7oTz5wfLZND/eebDDdO6kJxn58Qfrs=;
  b=B4KQ/OVLOnKuQLtnafYPXsEIHASrZJvm6tYDl5vAIczpYwJqzKF1zalW
   gZJ6pH98JHPPWn+1aBazE2W+5D3OqMdsDrwMaWHmW1KEGBKS8FIn2YZuN
   Cfkq12zKSHHW5biE8FLtZlV1h4IK3eiyU+B6oMGr/kmSSeDKWAW+WZHJ4
   rXuLZ35ltdIJuGQmvoDTo8ObtAxDvEBwXOrscqy768S19S3i0Bl4WJ84L
   EBNpQYo/Bb+FbfJddKyMjbyzL0gGNX9SiUSZmW8pYaAA+0o5bdBroaHm1
   DsSjQJ057oIliOlhnIiSBnA8BOs1PiMFrA8BbEi0HMrQpfcVbcjhO7kLn
   A==;
X-CSE-ConnectionGUID: ShTCeDxEQWKVVy8+krkl2Q==
X-CSE-MsgGUID: SiyHC4kmRqeuxXjHR70SUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22536474"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22536474"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 00:10:52 -0700
X-CSE-ConnectionGUID: T7Nu6l1UR5eVufT1zOoTRg==
X-CSE-MsgGUID: Y/AB1z/AQ4uEF80HqfB0XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61030208"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 00:10:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 00:10:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 00:10:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 00:10:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0K7d5r2kHOsOg7AE9i5aUs/zA27vGPtmMyKz4lt4xyb0ylTGzq2DKnUjv903ZxCMTqWsKbxBOJoOUXS66uY4W8hEdAOoaMlb9cE/xBkvSrTKqQtHEBpvDqKB63+MKJIAEwnrtFGvkouvSf4Wtx5ej/AdiMlpnezQFCddbbWyCmJT1iYnI4LJ7e5rP11s5vF7D0otf4alrzwzC1x9eI4VWqFotj5oqKLJO5+xXcxEObrgYZHy+/durdqFPv7RbOfhLofsk5qhpjO0so8U8bKcS0mdybZpddGQ8Nxkz3qGEBJ2sFYnrUF6wRgFc9jgAoagziSDt2Obc9sMwTecVX9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80WLCftGcJn5OCiKlaUMfNCnD6NgC9u9rDZ7QFfp0lg=;
 b=ZIN0X+b5+DVGrcgOJOMWFRTFNnm3Vocs6o9IBUHlb0mQw5LTOdxRW2SJe9z8c+DqKjog0MLqIEc1VgNeWQsoZ+51OBWKuqf5a3N4bYZ6dSsSOrUnJkXWKXQBAvDHGn0ViswYFA8Vh7EPleG1ZaKpsUSZxnpI373kqBLXlcpxK+LSF1TwukGqSG68WA045rfZ8QA7BmZAf2KbTdekP8ufbtosFY7CRb5PFbP6IAYJasM4sQvzCXVQMl+ghG8zLtCqHFGIz7vdnT80KqL2XGyG3lq575ZYSwDEqs34zb2M1jFJl6xWyAb/8mIkkrIuw6I3NzcSHa+KnQ2uyQhxjxZ2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 07:10:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 07:10:48 +0000
Date: Wed, 21 Aug 2024 15:10:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH 5/9] Block: switch bd_prepare_to_claim to use
 ___wait_var_event()
Message-ID: <202408211439.954a6d41-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819053605.11706-6-neilb@suse.de>
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 44dc73b0-a1ee-49e4-72af-08dcc1b061fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ny//IjuYl8Z1vkSZWeXD31NuWaCSCkUbi9aYQf2EacM+yMORQyFspMnjdoRY?=
 =?us-ascii?Q?6rbLy1yb+a+jyD/x8UNFLzdpIT17Sev5Exe2vOuC3DmCpr4xuJ9Dplz6WuM1?=
 =?us-ascii?Q?2x5yplPPavU6p/8+YVc3ASZjZfhhlKiEZLe/Sx5SUzdxXQvGS/UaR1DTjUQu?=
 =?us-ascii?Q?d56XubkEA8tnwoPLZgg7PsHvTpqY9ABlfSe/1cu8K+QH33gHBqmzprLsc7W0?=
 =?us-ascii?Q?1IHnVe88usBpn54DD/GHf8k5PfM30Hgr7LmC6Gfd4NIwiVIDr1q704+/K5fH?=
 =?us-ascii?Q?PRV5oI/xxm4YEkMiIQ5yhrVV+0QcEl1HUFdC54P8LzR6o2vWLA9LGFHLtF2j?=
 =?us-ascii?Q?x4lYI+f9vHRf7ahGEPYY+wEynK8x35aXA4/xnZSV90ZY4hyu7vHBCMVeBiHi?=
 =?us-ascii?Q?O/GwXmwCjnGfTHVlJ1lJM7lKPpdAUUpy5K/Xc85zgKLqz9YIwEoOsvKPaxK1?=
 =?us-ascii?Q?i5VRX890HLTz11FzY9cXPzIuzeK5Kakbb69niQiG41RDYZDiciwBZrHM6yuh?=
 =?us-ascii?Q?bT+zXQY2PDRmgSQEXaXL7DUrveYo+8nnSlDcVhw6psbRIiNou+vuny/pkBaq?=
 =?us-ascii?Q?l6bRLv2CDJohQ9qvOqyyBL49o21FDonUqZEDUz0qFnQAdIfJtsBximFMTCQq?=
 =?us-ascii?Q?KgJ4eI7WXa+SttzNzwI/K/oyVKQ3+1wGzE2j1J+JjMiTsBn2oy4kLfZhPMOq?=
 =?us-ascii?Q?ypMiL+7/NMxZPr5CsqDaAQYbbNyL06jtrO6v6I6eVYCnOupeBkpdiV+RbayL?=
 =?us-ascii?Q?ua4HZb8YJLtdqZisCu6YfLdeZGwDkqeeaQTN4G9Xn9HPyJzbrQUbswoKnLoY?=
 =?us-ascii?Q?immush60IdWjHTVEhK4uWvT1gW0bvPx/wvVkHCvIsw28y0G8BnRo41ys1uIe?=
 =?us-ascii?Q?LUPwDo4Cml2cMIuD3uPPEFokS77oVRp1jjOHMXgO5rALS6T7zLQv1aN6oTTC?=
 =?us-ascii?Q?WerwGATiruLnO5ytQLgB6FNJrm3ECz23rMCLkzT/RVCuTR+Kmzxcnl35BnjO?=
 =?us-ascii?Q?ockK4QbXXQWE5QEqvfDm6Gnq9I2EH5CTtoaQDobvLYhCGZfimDSNEddRab3j?=
 =?us-ascii?Q?slCjiKjxgdJ9xwBs8VRoJwvcov/57wuewBzTvN3hK3F6B+aggz6NP8/g15QW?=
 =?us-ascii?Q?vocR/BWiElwobDFOu25lnv8aKRGHGrzf/S3jGf+OGeBfgKvqqIaPM+KAXEiY?=
 =?us-ascii?Q?qd3ff25PnF/DEu6Al9KDtE/Z+fQk1OJgZDpN8cSDwOY2S1+uwtXs5L/layP8?=
 =?us-ascii?Q?S4YLmMMm93YNtk4dyurR2TsqSGe0NU5Pph6gvKvqpPMUp+0QR+p35zmU03Md?=
 =?us-ascii?Q?e88O2mj3nnMOEqLKLgZD9TeP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOfP2X6dSKLWdkDNqkavEqStg1xlx+J1uecCS61QOCcg1ujm5VAkh2+6Twlg?=
 =?us-ascii?Q?EHRGKYeHB4qmio3YnlJ2G3PoF3NmxjKeZ26P+LA27hbg+UiLVJlBaX1ut4TM?=
 =?us-ascii?Q?v6ZQYJ/ISfMFYAtJkSkVRTLw5RH9eyDelkte+yCreRt7dIc9UmLtAe8nA7Yl?=
 =?us-ascii?Q?PspQAIly+1wUPGe6Qe0Bdu8FXkJjkMdlvLOte1fuY3LmVfOMsSHy5uQ7Xj9i?=
 =?us-ascii?Q?YR2ekY5EvCMxG7ymTy6MVKqPgOCiz6j1mUQRE+AuJ0ZdnGfwo5/RMoPN/yco?=
 =?us-ascii?Q?wkxAeeLv9e11RkIQuqlzzrL/pK/H2vyjmtWg6fLlRnUJkbl2mki237sso0+e?=
 =?us-ascii?Q?edRrG0EoSr7zZLYzSqhsqI3nB/bbv04uBQAXSpbBYrNEiSwQZf66fJtc5ryn?=
 =?us-ascii?Q?lJBsW2lqI7FWk+LM8WRli1DSjt9B2+HGRJzXJwFwLvr9K7t6nMsVFKJF/Dps?=
 =?us-ascii?Q?Ukuc4dGCG0Maf9L/v83nEbGogIitPXIyo+VpLtIhLbTbTbWZ3Odh64pgvPXx?=
 =?us-ascii?Q?ZLaIA7WAfjnVp+nDySfCNB5X5rknrYM/3MPJb8XYxmz1H/3CepbFM5GFR8Yo?=
 =?us-ascii?Q?mFeBBhqCtGGhRP75m4mg/ZahHOdt4f7Dl0uJbB1Xdd3qIIlu9Wg9Eo8qAlQ7?=
 =?us-ascii?Q?FwWJv8UaW4IzK74BlEl9wCuaHgUGFJUk17SZ3DKsyX0Q9b/znhM78BCfpVbU?=
 =?us-ascii?Q?D3o+Us4XoCIsjbcUu43qHRm3Qe/m+MhICygZjtW3IHKtEgNs2p1pvwIDjAAO?=
 =?us-ascii?Q?1T+8U0YyUHZ8Rk64ENLQXZjqdDbOQUA4Q1lhjnVoS+mvY4pn21Ao+QKXovr0?=
 =?us-ascii?Q?FmxbN7HiKxCR5uZb1uGfvDnNO0UNnuzwIXYSqwJqrg9HPXU0v8xGz9PZqO46?=
 =?us-ascii?Q?jitTLgF9+1JFi5MkiNuW16idviq5JmeKXGvt8OttftTSTuG7Dzwj8tfemUEk?=
 =?us-ascii?Q?pQY71T2EhEmsIa9Ja9x53J+xPBHaU70iim0d+gxrrZrKJ1VL4CpPvwCbUiPJ?=
 =?us-ascii?Q?w+36S0HFo7gg33DJ93TudjxRyH5s1auNjDM395E1TOiJ9EPPmx/FMLFwZXnb?=
 =?us-ascii?Q?X4sSLwAwH6FUcHnEKUmhy+QwW/EhsrLWQTzZcR3Nch60dcMqx/PBx5JFHp8+?=
 =?us-ascii?Q?7J+GtSRIK43af7TIYXeWnzxCZMmB0NertqolphnLybOilZCPrYF3FNsPACVu?=
 =?us-ascii?Q?6UUT3PnXbt9iv2unwlb04NKBXy6T5ZynttjDKOCZXQtlFl7RT8S+h4Tg7BF9?=
 =?us-ascii?Q?xYqV+FRe1bCXT4fITj3hKqjFYDoBbfyAu3kfW3l8RWRJcIT8IvEShcXfO5fO?=
 =?us-ascii?Q?Os4m4kRlcNRGQMBQlCJvPCyqsP2uPsTqScUPO5Z4C8EM+e/K+fx8b1a1worD?=
 =?us-ascii?Q?v9MRdebHHXfvglJ3MgtoeZqfZZj9VV4dai9yY3vVUYtQ8bzGb848U7R78ino?=
 =?us-ascii?Q?x2S2ziY/IzpKEiC5G5OGN8k8f0K5FYB6DIyghPY03ALVrJW1BcAnAISF2yuy?=
 =?us-ascii?Q?oFqXZBWOp+BHoQB0eB4Ad/WWoenCfrtok3ALCQZmFN85hUarCMwTwJgfF+ZF?=
 =?us-ascii?Q?zUPO6cE5gEKpsz9uQDPa4K1HYdk/tpy4JMbVnL7nZ3qFgFmrVhXL6C8V7488?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dc73b0-a1ee-49e4-72af-08dcc1b061fa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:10:48.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhkvUWLD4kl+a9h+IL/0oHaAHE9k4yEuGpTD31Wx7WnE8Wvc71zrDG36/FPevBGcNBsivhQja4TQLnaTuf585Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_block/bdev.c" on:

commit: b80d7798a6f9db2c094014570a73728ace8d844d ("[PATCH 5/9] Block: switch bd_prepare_to_claim to use ___wait_var_event()")
url: https://github.com/intel-lab-lkp/linux/commits/NeilBrown/i915-remove-wake_up-on-I915_RESET_MODESET/20240819-134414
base: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link: https://lore.kernel.org/all/20240819053605.11706-6-neilb@suse.de/
patch subject: [PATCH 5/9] Block: switch bd_prepare_to_claim to use ___wait_var_event()

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | 30a670cac3 | b80d7798a6 |
+------------------------------------------+------------+------------+
| boot_successes                           | 9          | 0          |
| boot_failures                            | 0          | 9          |
| kernel_BUG_at_block/bdev.c               | 0          | 9          |
| Oops:invalid_opcode:#[##]PREEMPT_SMP_PTI | 0          | 9          |
| RIP:bd_finish_claiming                   | 0          | 9          |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 9          |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408211439.954a6d41-lkp@intel.com


[    8.768327][ T2733] ------------[ cut here ]------------
[    8.768333][ T2733] kernel BUG at block/bdev.c:583!
[    8.768342][ T2733] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
[    8.768348][ T2733] CPU: 1 UID: 0 PID: 2733 Comm: cdrom_id Not tainted 6.11.0-rc3-00005-gb80d7798a6f9 #1
[    8.768352][ T2733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 8.768355][ T2733] RIP: 0010:bd_finish_claiming (block/bdev.c:583) 
[ 8.768388][ T2733] Code: 48 c7 03 00 00 00 00 f0 83 44 24 fc 00 48 89 df e8 0f bc b1 ff 48 c7 c7 00 97 a0 82 5b 41 5c 41 5d 41 5e 41 5f e9 5a aa 95 00 <0f> 0b 0f 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
   7:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
   d:	48 89 df             	mov    %rbx,%rdi
  10:	e8 0f bc b1 ff       	call   0xffffffffffb1bc24
  15:	48 c7 c7 00 97 a0 82 	mov    $0xffffffff82a09700,%rdi
  1c:	5b                   	pop    %rbx
  1d:	41 5c                	pop    %r12
  1f:	41 5d                	pop    %r13
  21:	41 5e                	pop    %r14
  23:	41 5f                	pop    %r15
  25:	e9 5a aa 95 00       	jmp    0x95aa84
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	0f 0b                	ud2
  2e:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f 0b                	ud2
   4:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[    8.768392][ T2733] RSP: 0000:ffffc90000a5bc00 EFLAGS: 00010246
[    8.768396][ T2733] RAX: 0000000000000000 RBX: ffff888125940000 RCX: 0000000000000000
[    8.768398][ T2733] RDX: 0000000000000000 RSI: ffff88812a326800 RDI: ffff888125940000
[    8.768400][ T2733] RBP: 000000000000000d R08: 0000000000000004 R09: 00000002f1ee446d
[    8.768402][ T2733] R10: 00646b636f6c6200 R11: ffffffffa0015f60 R12: ffff888125940000
[    8.768404][ T2733] R13: 0000000000000000 R14: ffff88812a326800 R15: 0000000000000000
[    8.768407][ T2733] FS:  0000000000000000(0000) GS:ffff88842fd00000(0063) knlGS:00000000f7d406c0
[    8.768410][ T2733] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[    8.768412][ T2733] CR2: 00000000f7d0315c CR3: 000000012a244000 CR4: 00000000000406f0
[    8.768417][ T2733] Call Trace:
[    8.769866][ T2733]  <TASK>
[ 8.769875][ T2733] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 8.769884][ T2733] ? die (arch/x86/kernel/dumpstack.c:? arch/x86/kernel/dumpstack.c:447) 
[ 8.769888][ T2733] ? do_trap (arch/x86/kernel/traps.c:129) 
[ 8.769893][ T2733] ? bd_finish_claiming (block/bdev.c:583) 
[ 8.769898][ T2733] ? do_error_trap (arch/x86/kernel/traps.c:175) 
[ 8.769902][ T2733] ? bd_finish_claiming (block/bdev.c:583) 
[ 8.769905][ T2733] ? handle_invalid_op (arch/x86/kernel/traps.c:212) 
[ 8.769909][ T2733] ? bd_finish_claiming (block/bdev.c:583) 
[ 8.769912][ T2733] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 8.769917][ T2733] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 8.769926][ T2733] ? __pfx_sr_open (drivers/scsi/sr.c:593) sr_mod
[ 8.769932][ T2733] ? bd_finish_claiming (block/bdev.c:583) 
[ 8.769936][ T2733] bdev_open (block/bdev.c:914) 
[ 8.769940][ T2733] ? iput (fs/inode.c:1821) 
[ 8.769945][ T2733] blkdev_open (block/fops.c:631) 
[ 8.769949][ T2733] ? __pfx_blkdev_open (block/fops.c:610) 
[ 8.769952][ T2733] do_dentry_open (fs/open.c:959) 
[ 8.769958][ T2733] vfs_open (fs/open.c:1089) 
[ 8.769962][ T2733] path_openat (fs/namei.c:3727) 
[ 8.769966][ T2733] ? call_rcu (kernel/rcu/tree.c:2996) 
[ 8.769972][ T2733] do_filp_open (fs/namei.c:3913) 
[ 8.769978][ T2733] do_sys_openat2 (fs/open.c:1416) 
[ 8.769982][ T2733] do_sys_open (fs/open.c:1431) 
[ 8.769986][ T2733] do_int80_emulation (arch/x86/entry/common.c:?) 
[ 8.769990][ T2733] ? irqentry_exit_to_user_mode (arch/x86/include/asm/processor.h:702 arch/x86/include/asm/entry-common.h:91 include/linux/entry-common.h:364 kernel/entry/common.c:233) 
[ 8.769994][ T2733] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[    8.769999][ T2733] RIP: 0023:0xf7f111b2
[ 8.770004][ T2733] Code: 89 c2 31 c0 89 d7 f3 aa 8b 44 24 1c 89 30 c6 40 04 00 83 c4 2c 89 f0 5b 5e 5f 5d c3 90 90 90 90 90 90 90 90 90 90 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
All code
========
   0:	89 c2                	mov    %eax,%edx
   2:	31 c0                	xor    %eax,%eax
   4:	89 d7                	mov    %edx,%edi
   6:	f3 aa                	rep stos %al,%es:(%rdi)
   8:	8b 44 24 1c          	mov    0x1c(%rsp),%eax
   c:	89 30                	mov    %esi,(%rax)
   e:	c6 40 04 00          	movb   $0x0,0x4(%rax)
  12:	83 c4 2c             	add    $0x2c,%esp
  15:	89 f0                	mov    %esi,%eax
  17:	5b                   	pop    %rbx
  18:	5e                   	pop    %rsi
  19:	5f                   	pop    %rdi
  1a:	5d                   	pop    %rbp
  1b:	c3                   	ret
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	90                   	nop
  27:	90                   	nop
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b6 00                	mov    $0x0,%dh
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b6 00                	mov    $0x0,%dh


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240821/202408211439.954a6d41-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


