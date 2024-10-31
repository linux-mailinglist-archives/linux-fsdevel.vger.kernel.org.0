Return-Path: <linux-fsdevel+bounces-33332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABDB9B7655
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 09:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5B21C218D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2B51552E7;
	Thu, 31 Oct 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jz0bWRZ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1368148832;
	Thu, 31 Oct 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362996; cv=fail; b=JS6gFuon9LHntgkUJpKz/cLINZqqOSOlCwSkjnZWpVCRei1yC1sMd5PD8ABDXG8OL5Q0k+GimhwN3VwF2eO+NYL5rVozECRmvZKedsXUo6O0HhTLImAiqDvmzwZZr+n/RClkQiEWUmMWbjQLsq8ydqcjTkfZKEoNaepMPmqQ4Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362996; c=relaxed/simple;
	bh=nVwuUdCDxZDcJNdTh6yvAh3HwsUYlzjtPKrUJKX1+jc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SRpyqdbVQ5hqS3vHNgqtA3oFHKvg0drUPU9WXmhp1TqrHwqEuWvBE37jvKbIWk+gNoJCZq3hU/2IS1yXiPaeSTaIpM+8vnb2UciVVeHRk3eU4JZoA2Mm1ri/h+H3oNOsA3/S5WKDClq/ZyLst7w2a4ueOLoFmzTM1YHhiHf1sSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jz0bWRZ4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730362994; x=1761898994;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=nVwuUdCDxZDcJNdTh6yvAh3HwsUYlzjtPKrUJKX1+jc=;
  b=Jz0bWRZ47LpYTPBV8/zNI3CRCZrhjsVelVOnr4UU31st7+RHwoavxE9E
   gqbZ0sLqQw9B0xAsRP9vX7Tka/V/sSxZm4RvnjKU0Ob8mDt6QeX06iYxO
   kqu5XUZOBy9vKTQ4UjforMfT6w5ejuHSrwr7hlIuh1EkeHTRLzHHHt6C7
   ftg4FnpwAzypBqscc2ajipsx5EQ6KNsvkEveq+bRK0yw8nLabJEUFMkaZ
   3Lub8XBPOvtZHC6C8WlGi3XbplVuYz1OK+jZp4x3SVe96/Xve2FPToi/K
   Ere0olodJUdjKElVKF+lq7rET3tC038HuQJEbqnkFpExfGN+3SLYi9OgT
   w==;
X-CSE-ConnectionGUID: O7uEw/B/QPWkqBYAz+QpOA==
X-CSE-MsgGUID: ffWZjE3tQMy50eYJ+UcnFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41189631"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41189631"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 01:23:13 -0700
X-CSE-ConnectionGUID: iR5WyWAvQR2LeiezboKjsQ==
X-CSE-MsgGUID: +1GiOJJLRGKmH4cqH37jXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82209959"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 01:23:13 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 01:23:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 01:23:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 01:23:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6tqz6QtMzD/bKLoNu8Ce9tA57LEVkSrlqkpiVqaqYvRvWDQ8XI25yuxGPdzX8BYxMkfAa7TPlVKJMZHiWl9Nk4g/UjV2ewAHmO6tIDFciwpMfQOeY/JTXutPA4zjE+d3Sw/po96F7B+7sl3aTjGWBSe/Bi5MSWhDzVWENXTr3nBcTzL/HexYxk6SQ1yq7CbQK5KjR87WCBv2ViFLwtaGWHYCQLkAoY9626R0pl/ZNwD6wz3RVqRhrG5q1S6FaMxU2sWTPQDasBvNrdQaxL7n0oidGnLpzp8+G99jHoDoPi+OSX/bdazLhCUwX3y08ja+vL+JwMsqbOLwOaW2b35Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7KAqSdpP/NGGWKRiTYgiWV1gB65HCVC/5veSDp9sOY=;
 b=WFuRFbhaE+fw/+2xelq/kbLUHORxqIy+MP9QqnwMT+yiI1fm6vfeG7O1kLV6YsxFlFBD8yOHeLOY6r9ryZ4aOENOuzbJFP8BHWsVPEPBAFZhHwWrfjx80mBszuEbSkPKJ7x9jzOtY6Cmk9Bh8zYMGCEr0PxlntFhaTonbteUyiJUWGSGUsSj0TNS61/ZNqRviFPmJZKNhpCkZ4J7XG+5oFotv5dzF9+R0X+XiXclD+3apMZRFop1hL+4KSf2ygkp1PHoXxkhClV70LVjQ6wcILd96UHf1XtTRL6t+wuri5dd64cCKsIEVn6wmNCXZZ4GdrU5Wa8KZC54Clj66ku0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB8302.namprd11.prod.outlook.com (2603:10b6:208:482::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 08:23:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.025; Thu, 31 Oct 2024
 08:23:04 +0000
Date: Thu, 31 Oct 2024 16:22:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>,
	<oliver.sang@intel.com>
Subject: Re: [CI 1/1] pmu changes
Message-ID: <202410311530.3de6361b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029144803.631999-2-lucas.demarchi@intel.com>
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f414bdd-8fd3-471b-3e5e-08dcf9853dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hcfkbpRU9Z9Cbc5TwUvnnGjFGt63GrBQM7tyEGjkkb955yp0jU6dk70A6k1Z?=
 =?us-ascii?Q?B59tSVlNbnmHRu1eL4i2A0jir0gozfLT47citoq70z/yP59qn8lFQdr83QVS?=
 =?us-ascii?Q?vfFBs7r9R4tzPNKKkgRpQJ2VRrCXoJ6cy1ZZPRYVoWSjDQxgB2dHywEKpWVQ?=
 =?us-ascii?Q?pIg1ebeY6MVpbBLiAhzsvhyZQbFN1gsj6MpbLNkf1Hn6Lofbv0+uHLHfxyUc?=
 =?us-ascii?Q?oxP5evQrQ6tpxuxelMPFOGeNiaYdRG6zyfv9oAUz649pNLnhrENZDPKGyIPk?=
 =?us-ascii?Q?LhSrwLv02bnK3iN3nF1kbfwAgY52w1kb43cFItBnJn+CQx1lU5M3Tlqd0BMN?=
 =?us-ascii?Q?xELprGo7azOsJ11ue2zDKs/6JFDJUR8ODz6mCPx7cZEAHnNwucEj8DWjWZVA?=
 =?us-ascii?Q?qvJ1EHZ12AI9Q67hkcBG1AUK2QS7a11/6ZWpbDolX2S6HGvtEfCCCJfWNdS7?=
 =?us-ascii?Q?4CNkgXxNNbfIt/isA2bxUHmTzWE1eV4rozW6JY450YthGwwm5nrWc1RcxeFR?=
 =?us-ascii?Q?EkPnLILH8zD+nuIOgHwHhRXKzZvtk/QjdFiLXGUNTazbfhJoP8FjP0D8ZfOn?=
 =?us-ascii?Q?T+1w5FiQzXuG9BMaCC6Um9YT3/U3SRYhDoTbJnwaec10Ph8vsJ5Ovwob4e7U?=
 =?us-ascii?Q?ll0evt9wTwNe8Ucj4vkatvylJvgC1PiuJo2MhwIqCPMoh0KiTlGBvnk5ZSMY?=
 =?us-ascii?Q?0EL7tM5jYvIS5xIieeN1LDzaQHjVsneQm3Yh/OQVcO/qtzQvf4oufPFstWW2?=
 =?us-ascii?Q?3R1hCDqSSXI2CzhfXOIaF+pWNIVPh55zOcUKVdO/wXrrC6TXUfhjo0pTycYw?=
 =?us-ascii?Q?W4Ov8ZsLWe+dzV1kxMHTuzp0Z2SqtlEz7C/kVXulqav9tPCC5N7XDofj+Cpt?=
 =?us-ascii?Q?uVnd6kwx9juPyw8ZvHlzyEZIG1EzgFZuKnkTj1qnzo2bvr5D5tXFmmjDrk1z?=
 =?us-ascii?Q?qknDqeJ9ea28WkdcY7TCDhkkDlUs86wwEDT0aoF2Fhu71+QjI+cTUB58IfDD?=
 =?us-ascii?Q?FPYENBPS6eV6wDwcw9FBpYg3aLUU/xKKVUCLQF+mQmJLxKSE6NXUhh1BOJ7q?=
 =?us-ascii?Q?TnLnC5QX5pvm/jIJtezXlwEGhvbXAEeHfbiZbgBPorVF5Cwd94jYgL3CpU1W?=
 =?us-ascii?Q?Ske1dyEnXikbhcPysGohTrhbe2HBWjpq122nMYbi6k1wTyKAYykkOFp25XYG?=
 =?us-ascii?Q?NL1fyirmC2X1xT1wTSNvJQsLIo4i63dJDTy7J8jsO+4wCaKS2KPD4+31tJ/N?=
 =?us-ascii?Q?j/9v7Aw8o+GYUGCC+k9P93GvdOiV5iVLsSz4QStc6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJio6hm7uFszWQgSOg74TbUXFo1IQiWXOd6tbNP6Ba6r11Gp7cjX4txHaHev?=
 =?us-ascii?Q?zNt5wCI6Rngc3qJAEc1YhQk8DfiJtX3OLutH1hXdms8NpVUDS6GJhGge3d2A?=
 =?us-ascii?Q?xV4wwSWvp4pTAF5qkJJGDra2WuKtthYlQPC/cifbpBmLvkfu/sXQL1qKnVcA?=
 =?us-ascii?Q?Sw+mUlSpIUxwMJvR8Ex7Gcg3QUwUS/JCZQmAs5NInWstkZA+H/n14z4ZiNWp?=
 =?us-ascii?Q?tvO6L1+nQCvLbH/ZeHzPqNOOJMMBgd787/6Y/Hl32z219YvpfTAqH3VLR6Vv?=
 =?us-ascii?Q?iO5JakaRvyS3+EUZRxngBea+/COUtw6eXyZ8GkcSoGnH93Yqv8wtivTnTJ34?=
 =?us-ascii?Q?kjoIqrNxUFF+PLRr1qglODgHyY9gNDQ8NiuhzxhhvLKTi7x1XBYUElU+3VMy?=
 =?us-ascii?Q?cFG2VCpyOtcKZapJBgATnOdIOqWuAhuEOO5lFgn8WONWQQ3e8CHQNqxid23H?=
 =?us-ascii?Q?iPNGFhGxTewiGeS8c1KagYnVr0oQrvZHl8eMUwmjTJSbMYeQ/i63gjXOnf0e?=
 =?us-ascii?Q?OrKmP0F3s1JaBk4oA06vkYJGoRYoQcWf+MKXXiYyIMQnivwvxzAjGxi7jR4F?=
 =?us-ascii?Q?OMjmvEd1cW4E/Tko/tSiuQ1Cfy1DACQKUB8CkVcleUTv5o7RKJkfsLXDuDfb?=
 =?us-ascii?Q?nKp6U9ndTjx8NzgTcqxgiT4TsrkYNBKeGYIZygkmyPu8aNsWaOqrIEnoLKh6?=
 =?us-ascii?Q?xE9N2d/nE7CxmFIiN5rvBfLDH7LKvZWKG89mtSqISntrJviVJx+rHbtjBluJ?=
 =?us-ascii?Q?K0de6eynSk493iNBXPHBem3wrs6MKgIZb/gleWI1BrxH/fUjsrwm/AYIZRBs?=
 =?us-ascii?Q?fm1jjWM1UwOpQh7hRouy1pDUNxgg9Tv/AHeGlJx6pxKaCW9TKLVn9Z0Hyh1N?=
 =?us-ascii?Q?oF+V9xtH6XAZh5yqh9kVNgqMJQV5yskyP9/clfFGPL+GQbSKNHLO5vLdtgo5?=
 =?us-ascii?Q?ZVCMxpFTrJA8dCYHN6FB3CcqkbrTFRUAR9kbnIuQLYGlgwZ9cNABghQIuqjR?=
 =?us-ascii?Q?z46UCBZTZ0z4XYOUXv4aQHaR1tH1ZZZtcWceEai5J2DEx+nV0YovJrLMuFwJ?=
 =?us-ascii?Q?bIqdDkRzV3fbjYgCBtY1uVErH0zTcpb+eBQlNcInVwQIX88IpQAv2TJfWjhJ?=
 =?us-ascii?Q?w07IiR2t1rCEyM7qu02W+OCrvEFv6rC+XNGCdVNesujJ3QvA3O67CQepqjHm?=
 =?us-ascii?Q?HmLEPAuAxvy2m8gSTUAi6Ds6G+0+wE+ZC+Fz6QhnfRKxID4EEAemmYhEjr6r?=
 =?us-ascii?Q?DMqduYD/FIg4iuZWZh8kXIxqR+p/k0LoIbNi3ADFu+VghzjNnYpssNp3Gpn3?=
 =?us-ascii?Q?26zCLGu1WoLPt3VE71TLHUwR+d6YTCTzu0fs4X3yY8gLBrbMnGDYnVsRc9GD?=
 =?us-ascii?Q?vAounhltzQQsxIj0F4fZ4AD1CZDe9j4xlEH6TF59HPOFyn3LNsNgbFM68JsL?=
 =?us-ascii?Q?HQEghk0LUjb/4ZT+be7k+Sj6l9k1ySvbOg9IuIZBLT8vsKblqwj6r8YaMI1H?=
 =?us-ascii?Q?40BqPGK7EzJbd1hpLH53sjeUWZ1hD5ueybWaqXJmpGHn0UYVvyB+l/jNEODZ?=
 =?us-ascii?Q?FYYak+ELZtsHFeA3yrhKplq5jeaV0yljedIRZAD0TxH8n0pccKuhDEnaaZxw?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f414bdd-8fd3-471b-3e5e-08dcf9853dc4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 08:23:04.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q28YDcsMD+knfKfBTAta72JGc+VXunFbdkIFzCzzRd2MJoVOGAEeP9UuleLTXKxn45C2uEpPLo3Kbsig+OSmHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8302
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 47b40a2914e5bd319e85aab763b60dd2e13b4076 ("[CI 1/1] pmu changes")
url: https://github.com/intel-lab-lkp/linux/commits/Lucas-De-Marchi/pmu-changes/20241029-224928
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20241029144803.631999-2-lucas.demarchi@intel.com/
patch subject: [CI 1/1] pmu changes

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5



config: i386-randconfig-141-20241030
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------+------------+------------+
|                                                | 150dab31d5 | 47b40a2914 |
+------------------------------------------------+------------+------------+
| BUG:kernel_NULL_pointer_dereference,address    | 0          | 6          |
| Oops                                           | 0          | 6          |
| EIP:__free_event                               | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 6          |
+------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410311530.3de6361b-lkp@intel.com


[  269.760917][ T5119] BUG: kernel NULL pointer dereference, address: 00000000
[  269.762008][ T5119] #PF: supervisor read access in kernel mode
[  269.762871][ T5119] #PF: error_code(0x0000) - not-present page
[  269.763640][ T5119] *pdpt = 000000006b932001 *pde = 0000000000000000
[  269.764436][ T5119] Oops: Oops: 0000 [#1] PREEMPT PTI
[  269.765118][ T5119] CPU: 0 UID: 65534 PID: 5119 Comm: trinity-c1 Tainted: G S                 6.12.0-rc3-00137-g47b40a2914e5 #1
[  269.766301][ T5119] Tainted: [S]=CPU_OUT_OF_SPEC
[  269.766950][ T5119] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 269.768012][ T5119] EIP: __free_event (include/linux/list.h:119 (discriminator 5) include/linux/list.h:215 (discriminator 5) include/linux/list.h:229 (discriminator 5) kernel/events/core.c:5395 (discriminator 5)) 
[ 269.768671][ T5119] Code: 74 60 8b 47 34 8d 77 08 e8 d6 18 f0 ff 89 f0 e8 db fd a5 01 85 f6 74 4a 8b 83 a8 03 00 00 8b 93 a4 03 00 00 8d 8b a4 03 00 00 <3b> 08 0f 85 ad 00 00 00 3b 4a 04 0f 85 a4 00 00 00 89 42 04 89 10
All code
========
   0:	74 60                	je     0x62
   2:	8b 47 34             	mov    0x34(%rdi),%eax
   5:	8d 77 08             	lea    0x8(%rdi),%esi
   8:	e8 d6 18 f0 ff       	call   0xfffffffffff018e3
   d:	89 f0                	mov    %esi,%eax
   f:	e8 db fd a5 01       	call   0x1a5fdef
  14:	85 f6                	test   %esi,%esi
  16:	74 4a                	je     0x62
  18:	8b 83 a8 03 00 00    	mov    0x3a8(%rbx),%eax
  1e:	8b 93 a4 03 00 00    	mov    0x3a4(%rbx),%edx
  24:	8d 8b a4 03 00 00    	lea    0x3a4(%rbx),%ecx
  2a:*	3b 08                	cmp    (%rax),%ecx		<-- trapping instruction
  2c:	0f 85 ad 00 00 00    	jne    0xdf
  32:	3b 4a 04             	cmp    0x4(%rdx),%ecx
  35:	0f 85 a4 00 00 00    	jne    0xdf
  3b:	89 42 04             	mov    %eax,0x4(%rdx)
  3e:	89 10                	mov    %edx,(%rax)

Code starting with the faulting instruction
===========================================
   0:	3b 08                	cmp    (%rax),%ecx
   2:	0f 85 ad 00 00 00    	jne    0xb5
   8:	3b 4a 04             	cmp    0x4(%rdx),%ecx
   b:	0f 85 a4 00 00 00    	jne    0xb5
  11:	89 42 04             	mov    %eax,0x4(%rdx)
  14:	89 10                	mov    %edx,(%rax)
[  269.770846][ T5119] EAX: 00000000 EBX: ece52bd8 ECX: ece52f7c EDX: 00000000
[  269.771647][ T5119] ESI: 840a5728 EDI: 840a5720 EBP: 8a9e3a90 ESP: 8a9e3a84
[  269.772469][ T5119] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010286
[  269.773369][ T5119] CR0: 80050033 CR2: 00000000 CR3: 6bada000 CR4: 000406f0
[  269.774272][ T5119] DR0: 76a0e000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  269.775127][ T5119] DR6: ffff0ff0 DR7: 00030602
[  269.775810][ T5119] Call Trace:
[ 269.776374][ T5119] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 269.777014][ T5119] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 269.777590][ T5119] ? page_fault_oops (arch/x86/mm/fault.c:715) 
[ 269.778232][ T5119] ? kernelmode_fixup_or_oops+0x68/0x84 
[ 269.779041][ T5119] ? __bad_area_nosemaphore+0x11d/0x1c8 
[ 269.779854][ T5119] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835) 
[ 269.780558][ T5119] ? do_user_addr_fault (arch/x86/mm/fault.c:1452) 
[ 269.781302][ T5119] ? __print_lock_name (kernel/locking/lockdep.c:728) 
[ 269.782017][ T5119] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 269.782707][ T5119] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 269.783506][ T5119] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 269.784205][ T5119] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 269.784987][ T5119] ? __free_event (include/linux/list.h:119 (discriminator 5) include/linux/list.h:215 (discriminator 5) include/linux/list.h:229 (discriminator 5) kernel/events/core.c:5395 (discriminator 5)) 
[ 269.787167][ T5119] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 269.787970][ T5119] ? __free_event (include/linux/list.h:119 (discriminator 5) include/linux/list.h:215 (discriminator 5) include/linux/list.h:229 (discriminator 5) kernel/events/core.c:5395 (discriminator 5)) 
[ 269.788626][ T5119] perf_event_alloc (kernel/events/core.c:12566) 
[ 269.789313][ T5119] __do_sys_perf_event_open (kernel/events/core.c:12978) 
[ 269.790044][ T5119] ? perf_event_output_forward (kernel/events/core.c:8148) 
[ 269.790792][ T5119] __ia32_sys_perf_event_open (kernel/events/core.c:12865) 
[ 269.791511][ T5119] ia32_sys_call (arch/x86/entry/syscall_32.c:44) 
[ 269.792158][ T5119] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:386) 
[ 269.792821][ T5119] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5827 kernel/locking/lockdep.c:5790) 
[ 269.793531][ T5119] ? __lock_acquire (kernel/locking/lockdep.c:5202) 
[ 269.794189][ T5119] ? find_held_lock (kernel/locking/lockdep.c:5315) 
[ 269.794830][ T5119] ? __lock_release+0x49/0x15c 
[ 269.795490][ T5119] ? hrtimer_start_range_ns (kernel/time/hrtimer.c:338 kernel/time/hrtimer.c:1246 kernel/time/hrtimer.c:1302) 
[ 269.796180][ T5119] ? find_held_lock (kernel/locking/lockdep.c:5315) 
[ 269.796805][ T5119] ? __lock_release+0x49/0x15c 
[ 269.797495][ T5119] ? __lock_acquire (kernel/locking/lockdep.c:5202) 
[ 269.798131][ T5119] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5827 kernel/locking/lockdep.c:5790) 
[ 269.798742][ T5119] ? find_held_lock (kernel/locking/lockdep.c:5315) 
[ 269.799363][ T5119] ? __lock_release+0x49/0x15c 
[ 269.800028][ T5119] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:514) 
[ 269.800661][ T5119] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:514) 
[ 269.801307][ T5119] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4613) 
[ 269.802056][ T5119] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 269.802747][ T5119] ? __do_fast_syscall_32 (arch/x86/entry/common.c:391) 
[ 269.803393][ T5119] ? __ia32_sys_alarm (kernel/time/itimer.c:295 kernel/time/itimer.c:308 kernel/time/itimer.c:306 kernel/time/itimer.c:306) 
[ 269.804009][ T5119] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4613) 
[ 269.804739][ T5119] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 269.805424][ T5119] ? __do_fast_syscall_32 (arch/x86/entry/common.c:391) 
[ 269.806050][ T5119] ? __lock_release+0x49/0x15c 
[ 269.806669][ T5119] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:514) 
[ 269.807213][ T5119] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:514) 
[ 269.807782][ T5119] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4613) 
[ 269.808416][ T5119] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 269.808858][ T5119] ? __do_fast_syscall_32 (arch/x86/entry/common.c:391) 
[ 269.809284][ T5119] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5827 kernel/locking/lockdep.c:5790) 
[ 269.809705][ T5119] ? find_held_lock (kernel/locking/lockdep.c:5315) 
[ 269.810270][ T5119] ? __lock_release+0x49/0x15c 
[ 269.810857][ T5119] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:514) 
[ 269.811447][ T5119] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:514) 
[ 269.811994][ T5119] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4613) 
[ 269.812645][ T5119] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 269.813265][ T5119] ? __do_fast_syscall_32 (arch/x86/entry/common.c:391) 
[ 269.813848][ T5119] ? mutex_unlock (kernel/locking/mutex.c:549) 
[ 269.814377][ T5119] ? __f_unlock_pos (fs/file.c:1168) 
[ 269.814949][ T5119] ? ksys_read (include/linux/file.h:68 include/linux/file.h:85 fs/read_write.c:715) 
[ 269.815480][ T5119] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4613) 
[ 269.816143][ T5119] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 269.816761][ T5119] ? __do_fast_syscall_32 (arch/x86/entry/common.c:391) 
[ 269.817368][ T5119] ? __do_fast_syscall_32 (arch/x86/entry/common.c:391) 
[ 269.817932][ T5119] ? irqentry_exit (kernel/entry/common.c:367) 
[ 269.818468][ T5119] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 269.819026][ T5119] do_SYSENTER_32 (arch/x86/entry/common.c:450) 
[ 269.819555][ T5119] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836) 
[  269.819984][ T5119] EIP: 0x77f83579
[ 269.820310][ T5119] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241031/202410311530.3de6361b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


