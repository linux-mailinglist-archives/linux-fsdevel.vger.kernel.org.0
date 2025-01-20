Return-Path: <linux-fsdevel+bounces-39654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F6A166D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 07:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE2A3AAEBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 06:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64B189520;
	Mon, 20 Jan 2025 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFfHIeET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6E374F1
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737356263; cv=fail; b=DXeEjU2ZjxBaZZDJ2CSMJu50JOS3dRocPVJ1PeHpy0BCZwncDG9vHgoV3MtOof7IGW6pGBEmPp/CEUSjWROaqIFwEZ5WEKMkHZ4TC/mm9hMmOWW2ZTv3KeI45ykdlVwlRs1S18a3ntmUoDelK//W1gCwzzmwMm112ewwHIRm1Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737356263; c=relaxed/simple;
	bh=FBIUOmmNibEjQSx48beHWZErO48htrwJKoB3Xu4abp0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iyQ0+J3uWcSBml7sAYmlGP3rG3HR8HrJILOGaqQ69N6Bj9XecsLBYoXIwt6jc4VPYE1MUFA9lkJnvNknN4WRYGUmqEwgGMQ9gobm2+Um+T6AUnn1zhqb6OIvcOaqU0x6Ali3ixQzvt5jsNmItKSITON3qbInPm+S46CEwKgHdIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFfHIeET; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737356260; x=1768892260;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=FBIUOmmNibEjQSx48beHWZErO48htrwJKoB3Xu4abp0=;
  b=PFfHIeETxqyir1lJ3ru0z2E9rVYw3w0/SI2WGF56jXpRM+rCoLbAbAr3
   x2A7CVgtYsOMtWFR5peuFbheYUkwfLdNSQkUawg93UEZbe2wK99aHDftG
   Dg7WbHcE6Hn0BDRIctAOLipU9kIw5SiCts/POUToq0KKjKefbKR4ZNq0W
   swaf14DVnRTUMLLcha23nxfra1pr8X51lcUDs2J0aFDnI227F6uVB+ClB
   csEhiLzqeMq3x1w7oCAorThUnr8rFyOA1YOCX5FpGm6/C06xt1JBK/1Lk
   FReLhfbIJzAawO6cSO1oZ4DtleNfh8WWxv6ez0eBVvASVrdFYZ1UQKYkv
   w==;
X-CSE-ConnectionGUID: UC4cAtaKTPqp64Z2HPARcg==
X-CSE-MsgGUID: 5jskgcpkRqS1gfjOKZBl2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="41393726"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="41393726"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 22:57:39 -0800
X-CSE-ConnectionGUID: 8nk8HlJnQBGMefUgkgF8JA==
X-CSE-MsgGUID: mmJToOY7SFqm7PMdipmDVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111488626"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2025 22:57:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 19 Jan 2025 22:57:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 19 Jan 2025 22:57:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 19 Jan 2025 22:57:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+Lf4UNByfWeHi27eHlNb+qsl/iaarPPIB9J3/lyjVc/DRnehtXjxvVixDSvOMIyB+Za3XJwhyCdejN6LRtJkkrR4um+10TyCA1p90d8TmdphCp7gKyU0i6af6bkuEO1I/O3tq81p5F1BPRTQusDREqS87FAYk7o8TCiIXQje9emzJzogQcfvlfSem4q/joTgSHQfNCAd2PmpT0EvcKF8lajYsoeq72grE2MSYM/Zo3GlSEgzRY8G8+F0G9+3ycdFt19Kx/sjozKf8rqtR9SrKZlCYiEY/4RN+ycdGm86FTLQm3eptAPsdO+YyKz4xWw9QjsULjarlYJq28PVgWjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/Ppx5f1yEM4d4nqrritEfDm4sLbLbTtvgoS7uWkbMg=;
 b=LqNc1sdSpa0U0yyNoL4g+0sEKGhx4djDGThDmfJusyCdtEbvxmxchjGV0SHp9Ipmy8n5qiRssihu5VI7WPtfmKNa2Xf/LrKlc01u7nwkB3BUq6SZkgd5YTFgfO+DNQb+0ESvHgALlwIQ/pOVirkoxHY59vw0ez9UcH7finOG0CWRmRT2nZFBOFgchCnguqqmT02EZ/YeNPFZds+0VJYj4BRBbGo2rBeDwDCg+DhBWwyRnfpuJLUDZbBTD5gHyE64xc1MelMCBVr4SLINEm4mn0hOS72F4e1eQreZALgSiQ3oPX1r9ddu7gxVYvYV2hyv+0j26fBa188ZuwLh7IeZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8250.namprd11.prod.outlook.com (2603:10b6:510:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 06:57:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 06:57:31 +0000
Date: Mon, 20 Jan 2025 14:57:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, WangYuli <wangyuli@uniontech.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [pipe_read]  aaec5a95d5:
 stress-ng.poll.ops_per_sec 11.1% regression
Message-ID: <202501201311.6d25a0b9-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 6072783a-5eed-4e80-b80d-08dd391fb58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?DQHWQT5Ih6KrZCQjNsHtFFF3uIFRyYM+c61DdsA55u43JIsN4wsSaWzQTP?=
 =?iso-8859-1?Q?CYwBGv0sOzVNrM46DIw5CZgejCOF1ZMUhEeKEkI3rnA0I+j+FwGwZCQKDZ?=
 =?iso-8859-1?Q?7+eD+CzEKKEf7vt9nY64FZzuNw4RgirOKZk9r2QcsUvtts9lwM9Z2C0Q5z?=
 =?iso-8859-1?Q?EWFIeHECQb7z2WuvFmIDoQLp46ltB+YOx2OdsZm0JUGeoXgTncV482TeFo?=
 =?iso-8859-1?Q?8dSZ7WQ3+j6rfeZC5DCm1BQDGTtGiebGAUTpR4I2e/afnNEc6UVr4zi+P9?=
 =?iso-8859-1?Q?KswHipiQsVgzryD2Wgo9T984OFIGkgwe/P1icDMPKKOBw+DreLtOAvArRK?=
 =?iso-8859-1?Q?PP6FaEAucQzjVljv1O89rl1/Uh4A9m8KjSvPsnAthdbwM0nDMvsxjGuHBK?=
 =?iso-8859-1?Q?JvsLkbbpDiqxpnarp1oTH7AJXAb0mC7f8jy0G0CrbauTzHSpAzx+asW8eX?=
 =?iso-8859-1?Q?y1mZEl/uwns0K/1QugQUqn2tO24U0VhSA/ovaat9U3LSBAK0OmK66POoMW?=
 =?iso-8859-1?Q?upPHXOydeXQpWBBG3jPuRz8AQAM6BWg5zcbVLEFUEb6K+EeeMfsD3CRASl?=
 =?iso-8859-1?Q?sRTaoiv4CCNzekiibWIg3ZrIqw/at+9l/moorwn58VP2CkeWXIuT+IyxxT?=
 =?iso-8859-1?Q?HJIdC54tVmCaWagIhnzMXoNc9U2PR6cAsfRo0b3ttT3IaxdMoO12knXy7F?=
 =?iso-8859-1?Q?bf3uYWPq5LiOiBxG7ef7zA08bakVtqbjyXLuaX21vhi0z8su0BZceB5mb8?=
 =?iso-8859-1?Q?UB+lQBUl+xRoyQO0uQOARgPhTVUEmj3jOlTQfxaHOmit4W7cfCOxP3B36i?=
 =?iso-8859-1?Q?WweSOMgZrvmkgX6VAOsGqjzaNeG9Pe6RFLxEg4RKJcABiYZ8/9UiAD+Wcl?=
 =?iso-8859-1?Q?oBFVLMyiRT8I7r8h8GMnpsH0mgpSP9Z760ffauJJZN9CxKt43KaqGlsjVP?=
 =?iso-8859-1?Q?WhFbYXTOmGZony9O3Y3jv0z+NpM+hRjeGeEJrIZJGq11q+gQKz0jeMfStx?=
 =?iso-8859-1?Q?hWb9wKwUY6mKFP4BdleblskvyhS0joRA2A/+7Dz0r3jXUgV3gJEaI1oHhr?=
 =?iso-8859-1?Q?XeWNMR+wPucwoa2yK5M2DYgBqCKKM2CL9snQgnJKW9c3Uw0tvUoW143OMs?=
 =?iso-8859-1?Q?PqqmvptSUPz1AMM1Rt98fIug3mCHnRMROumTbp97BnNRQN0OS5CKRtFrjJ?=
 =?iso-8859-1?Q?7Y1zeokTjmghJHVAPKwuOiKukSeTO/o/7p7BW5dz4iKrXRwvt8dGUEuXZf?=
 =?iso-8859-1?Q?uObVxii88CE200dXO2nuVVTaG7GOXWLijEwYP799rqgq/jzBCur7d1TvJO?=
 =?iso-8859-1?Q?CMuEewGt5cyKv5iPPxwQD0VZMdLYZLOgwi35A4C5iSGjiYe7+RxdaDfgIH?=
 =?iso-8859-1?Q?HLnEUEnCHul6FYMeuH+ZcUZLAeCBJwmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2/JJ+dyQ8q21DNQE0SW/M2qV3kxgTtKYSgXp7fB494T9WG7gaH+HcuNOn9?=
 =?iso-8859-1?Q?u8THuwcv0PEPldB+wafqUTk/KAQkVtVWdK0E2XqXSFq0HBOr4yKzzU4BR8?=
 =?iso-8859-1?Q?Mzr1/UP4fkPA/K1xfF2ZQXPZeULa8b+oWFkSFuPARiNz0OuB1WJoYcKZl4?=
 =?iso-8859-1?Q?8noJiyyaKyz4TFDWLDpJszxu4PJSpqHXx8P3+tNOR4QcmanXHqfaPzJvZ0?=
 =?iso-8859-1?Q?vfwJvevJz3zP7/F57FEC6d/ciU93vVa0iG0UlJwVHFaos9oaFw87f8cLUn?=
 =?iso-8859-1?Q?ARdoWPkYJBCzQGjEY/lrV+MI3D3bGkUlXt2xdvoabbMu/LPF1ct9UhVunl?=
 =?iso-8859-1?Q?p+anChhBZnTuECWjAzjM/uWfWfrDzQQuZIBYkXaviOxQM89fPtLjgMimFt?=
 =?iso-8859-1?Q?szt4dBTMSb+UP7TfD5UeC8cOkEOxpDNtLwyuPvHVuqTm5KswQ/Jd/kikVL?=
 =?iso-8859-1?Q?+2cOqGaGVgnUAMV0teiJdLv2KE5BjKlQWfAzYM9ahtA84AzL92OCwVTtfZ?=
 =?iso-8859-1?Q?Dkj25hMqOlij+NH83fr2Hb6XwGnw6TQUlin8tfjTQAQOFI6Yls6TU+i3hj?=
 =?iso-8859-1?Q?iFbExEoQnMqldBt09+D9Hv/8f4f/0RbzeB2bBq68503NPCO/ERLc2ZCW4b?=
 =?iso-8859-1?Q?fxo3ThyMcR+lcgAaxVwIE9uaZWzd1825ciMZm8sEL2nr84It2Vfo/HU75p?=
 =?iso-8859-1?Q?7KcBP70T44io2BRlKnF2yEV5rnp6pv4Ybk01ld+Ygn9YqOhsF6bhc7rDKY?=
 =?iso-8859-1?Q?S3a97tNgQ6QX9q9f4Q5ZUgHI/AzLZ6Rz7Kj5tCl/e43hWC93WyakDOT3Sp?=
 =?iso-8859-1?Q?VVZQfNVzUAvS2p2DmEAGQQ+/9fYKht6vAHZKdu9N97N9+7iv+0e9YiheBK?=
 =?iso-8859-1?Q?5oLOCyAwOf8hQVVU8/NxZktZ6O5CGKxVH6utdeYHNETgBl0jpr20Luf2+e?=
 =?iso-8859-1?Q?PUlY85tDBW6HDNVwEZcM9ygoHouS80RF+bKVJw7+Ke9SeUBH4/QbTXlyJO?=
 =?iso-8859-1?Q?kkw+vF/Ldm725HEDBvrYTG5Ka/yOucQk3Yd6sudspGlmLwqyJYaH4tsgta?=
 =?iso-8859-1?Q?rnJtICZacqygvGzWSJ8ElOZLHfTfnUFqZH3m4PwVInXKxMdWQjZu6fsuQV?=
 =?iso-8859-1?Q?GUU4ng68zgV0IF9QRwEjwddZc4lcnUdpCEyW6Cb4T7fuhrogS1ylOci37J?=
 =?iso-8859-1?Q?zvEGGiwSRaLdxrgmKeuvruAyWTYOM7+GPxRTPGWH3A3gfEhId9ZqwzPDAk?=
 =?iso-8859-1?Q?86R7/S7m+iZmxVeh5iNerBQ4yGB7Ifu08/uM6p6qzzNxcgF9964/3z2nDn?=
 =?iso-8859-1?Q?VfVCJD9FyAIRgqWfoXmRp4WhFwc/4LYTYOf2SYsja7CFiSmHeefMtg4bQb?=
 =?iso-8859-1?Q?e2/HF2YI+BAC6ecafGFI6JTWvQXHYN/yrS6kh7YVpsuEWzLS8oslSEDrtN?=
 =?iso-8859-1?Q?YQsSKQyHXA2udnJtv0Kl9LQMYqkzSoJHp8BfCkF/HB071kqZ3OVg01iedT?=
 =?iso-8859-1?Q?srDG3wjIDf+dkRCsxAItojyoEWsvXgrt+tcBOG14gAJz1DjsGlahvyecyF?=
 =?iso-8859-1?Q?LxSn7JKgwjnAL/uxl08yT5kNM0LtzpIaWZGPJtPO9vvMzLQle2PYQNhq4p?=
 =?iso-8859-1?Q?enBq7jOzyvg+R9i/TwjLzi4U+6+SajFRaYhB8RgZIj9v45/upLjWJTVA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6072783a-5eed-4e80-b80d-08dd391fb58d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 06:57:31.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sknKv1JuxF+CyKtea2Csvb24ayBXx713uWoEg4wJhqrr875TPjPEYVSnYNkiI/BjMqDCvOEgb2EjEv3K0paZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8250
X-OriginatorOrg: intel.com


hi, Oleg Nesterov,

we reported
"[brauner-vfs:vfs-6.14.misc] [pipe_read]  aaec5a95d5: hackbench.throughput 7.5% regression"
in
https://lore.kernel.org/all/202501101015.90874b3a-lkp@intel.com/
but seems both you and Christian Brauner think it could be ignored.

now we captured a regression in another test case. since e.g. there are
something like below in perf data, not sure if it could supply any useful
information? just FYI. sorry if it's still not with big value.


      9.45            -6.3        3.13 ±  9%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
...
     10.00            -6.5        3.53 ±  9%  perf-profile.children.cycles-pp.pipe_read
      2.34            -1.3        1.07 ±  9%  perf-profile.children.cycles-pp.pipe_poll


Hello,

kernel test robot noticed a 11.1% regression of stress-ng.poll.ops_per_sec on:


commit: aaec5a95d59615523db03dd53c2052f0a87beea7 ("pipe_read: don't wake up the writer if the pipe is still full")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master b323d8e7bc03d27dec646bfdccb7d1a92411f189]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: poll
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501201311.6d25a0b9-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250120/202501201311.6d25a0b9-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/poll/stress-ng/60s

commit: 
  d2fc0ed52a ("Merge branch 'vfs-6.14.uncached_buffered_io'")
  aaec5a95d5 ("pipe_read: don't wake up the writer if the pipe is still full")

d2fc0ed52a284a13 aaec5a95d59615523db03dd53c2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.049e+08           -54.4%  1.847e+08        cpuidle..usage
     70.66 ±  2%     -40.9%      41.74 ±  3%  vmstat.procs.r
  13673771           -55.5%    6089704        vmstat.system.cs
   3388831            -9.5%    3067987        vmstat.system.in
      6.62           +12.4       19.04 ±  6%  mpstat.cpu.all.irq%
      0.07            -0.0        0.06        mpstat.cpu.all.soft%
     17.51            -6.8       10.76        mpstat.cpu.all.sys%
      4.98            -1.0        4.01 ±  2%  mpstat.cpu.all.usr%
     18.00 ±  4%    +110.2%      37.83 ± 37%  mpstat.max_utilization.seconds
      3483 ± 17%     -38.5%       2141 ±  9%  perf-c2c.DRAM.local
      2266 ±  5%    +256.6%       8081 ±  5%  perf-c2c.DRAM.remote
    173996 ±  2%     -50.8%      85520 ± 12%  perf-c2c.HITM.local
      1097 ± 10%     +97.5%       2168 ±  5%  perf-c2c.HITM.remote
    175093 ±  2%     -49.9%      87689 ± 11%  perf-c2c.HITM.total
   2643650            +5.6%    2790795 ±  2%  proc-vmstat.nr_active_anon
   3308720            +4.6%    3459916        proc-vmstat.nr_file_pages
   2427405            +6.2%    2578600 ±  2%  proc-vmstat.nr_shmem
   2643650            +5.6%    2790795 ±  2%  proc-vmstat.nr_zone_active_anon
    235308           -19.3%     189819 ± 12%  proc-vmstat.numa_hint_faults_local
   1437439            -5.5%    1358004 ±  3%  proc-vmstat.pgfault
  8.71e+08           -11.1%  7.745e+08        stress-ng.poll.ops
  14516970           -11.1%   12907569        stress-ng.poll.ops_per_sec
    181583           -57.1%      77818 ± 21%  stress-ng.time.involuntary_context_switches
     85474            +1.6%      86823        stress-ng.time.minor_page_faults
      6150           -47.8%       3208        stress-ng.time.percent_of_cpu_this_job_got
      2993           -50.6%       1477        stress-ng.time.system_time
    711.20           -36.0%     454.85        stress-ng.time.user_time
 4.427e+08           -56.2%  1.937e+08        stress-ng.time.voluntary_context_switches
    834292 ±  4%     -60.5%     329635 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.avg
    520206 ±  5%     -70.0%     155956 ± 44%  sched_debug.cfs_rq:/.avg_vruntime.min
     80954 ± 25%     -78.0%      17846 ± 55%  sched_debug.cfs_rq:/.left_deadline.avg
    312463 ± 46%     -69.5%      95397 ± 67%  sched_debug.cfs_rq:/.left_deadline.stddev
     80943 ± 25%     -78.0%      17842 ± 55%  sched_debug.cfs_rq:/.left_vruntime.avg
    312436 ± 46%     -69.5%      95382 ± 67%  sched_debug.cfs_rq:/.left_vruntime.stddev
    834292 ±  4%     -60.5%     329635 ± 12%  sched_debug.cfs_rq:/.min_vruntime.avg
    520206 ±  5%     -70.0%     155956 ± 44%  sched_debug.cfs_rq:/.min_vruntime.min
     80943 ± 25%     -78.0%      17842 ± 55%  sched_debug.cfs_rq:/.right_vruntime.avg
    312436 ± 46%     -69.5%      95382 ± 67%  sched_debug.cfs_rq:/.right_vruntime.stddev
    224.99 ±  4%     -32.0%     152.91 ±  9%  sched_debug.cfs_rq:/.runnable_avg.avg
    212.19 ±  4%     -30.4%     147.67 ±  8%  sched_debug.cfs_rq:/.util_avg.avg
     28.51 ±  5%     -26.3%      21.02 ± 29%  sched_debug.cfs_rq:/.util_est.avg
      0.18 ±  6%     -41.8%       0.11 ± 30%  sched_debug.cpu.nr_running.avg
      0.38 ±  6%     -23.2%       0.29 ± 14%  sched_debug.cpu.nr_running.stddev
   1893149           -63.0%     700843 ± 44%  sched_debug.cpu.nr_switches.avg
   2007234           -62.4%     755101 ± 43%  sched_debug.cpu.nr_switches.max
    845934 ± 16%     -65.9%     288868 ± 45%  sched_debug.cpu.nr_switches.min
    136058 ±  6%     -62.3%      51280 ± 45%  sched_debug.cpu.nr_switches.stddev
     54.75 ± 29%     -35.9%      35.08 ± 21%  sched_debug.cpu.nr_uninterruptible.max
      0.13 ±  3%    +138.2%       0.30 ±  3%  perf-stat.i.MPKI
 4.279e+10           -24.6%  3.224e+10        perf-stat.i.branch-instructions
      0.57            -0.1        0.47 ±  2%  perf-stat.i.branch-miss-rate%
 2.343e+08           -36.3%  1.493e+08 ±  2%  perf-stat.i.branch-misses
      3.22 ±  2%      +7.6       10.77 ±  2%  perf-stat.i.cache-miss-rate%
  29560239 ±  2%     +71.2%   50594050 ±  4%  perf-stat.i.cache-misses
 8.946e+08           -49.8%  4.494e+08 ±  2%  perf-stat.i.cache-references
  14167388           -55.5%    6301671        perf-stat.i.context-switches
      1.33           +45.2%       1.93 ±  3%  perf-stat.i.cpi
 2.778e+11            +8.5%  3.013e+11 ±  2%  perf-stat.i.cpu-cycles
   2501362           -83.7%     408632        perf-stat.i.cpu-migrations
     15733 ±  3%     -52.7%       7444 ±  7%  perf-stat.i.cycles-between-cache-misses
 2.138e+11           -25.5%  1.594e+11        perf-stat.i.instructions
      0.76           -29.3%       0.54 ±  2%  perf-stat.i.ipc
     74.48           -59.7%      29.98        perf-stat.i.metric.K/sec
     21318            -6.8%      19869 ±  6%  perf-stat.i.minor-faults
     21318            -6.8%      19869 ±  6%  perf-stat.i.page-faults
      0.14 ±  2%    +130.0%       0.32 ±  4%  perf-stat.overall.MPKI
      0.55            -0.1        0.46 ±  2%  perf-stat.overall.branch-miss-rate%
      3.30            +7.9       11.24 ±  2%  perf-stat.overall.cache-miss-rate%
      1.30           +45.5%       1.89 ±  3%  perf-stat.overall.cpi
      9426 ±  2%     -36.7%       5969 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.77           -31.2%       0.53 ±  3%  perf-stat.overall.ipc
 4.206e+10           -24.7%  3.167e+10        perf-stat.ps.branch-instructions
 2.299e+08           -36.3%  1.464e+08 ±  2%  perf-stat.ps.branch-misses
  28994632 ±  2%     +71.3%   49675855 ±  4%  perf-stat.ps.cache-misses
 8.795e+08           -49.8%  4.419e+08 ±  2%  perf-stat.ps.cache-references
  13938322           -55.5%    6196929        perf-stat.ps.context-switches
 2.732e+11            +8.3%   2.96e+11 ±  2%  perf-stat.ps.cpu-cycles
   2460505           -83.7%     402100        perf-stat.ps.cpu-migrations
 2.102e+11           -25.5%  1.565e+11        perf-stat.ps.instructions
      0.01 ± 82%    +259.6%       0.05 ± 57%  perf-stat.ps.major-faults
     20785            -7.2%      19284 ±  6%  perf-stat.ps.minor-faults
     20785            -7.2%      19284 ±  6%  perf-stat.ps.page-faults
 1.283e+13           -25.5%   9.55e+12        perf-stat.total.instructions
     40.62           -19.6       21.06 ± 10%  perf-profile.calltrace.cycles-pp.stress_run
     15.66            -8.0        7.64 ±  9%  perf-profile.calltrace.cycles-pp.stress_poll.stress_run
     12.84            -7.7        5.14 ± 16%  perf-profile.calltrace.cycles-pp.write.stress_run
     12.48            -7.5        4.98 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     13.32            -7.3        6.04 ±  9%  perf-profile.calltrace.cycles-pp.read.stress_poll.stress_run
     11.55            -7.1        4.46 ± 17%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.stress_run
     11.38            -7.0        4.33 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_run
     12.17            -7.0        5.16 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.stress_poll.stress_run
     12.00            -7.0        5.02 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_poll.stress_run
     10.32            -6.7        3.60 ± 17%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_run
     10.86            -6.7        4.16 ±  9%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_poll
     10.38            -6.6        3.81 ±  9%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      9.91            -6.4        3.52 ±  8%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      7.32            -6.3        0.97 ±  3%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      9.45            -6.3        3.13 ±  9%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.21            -6.2        3.00 ±  8%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.76 ±  2%      -5.8        0.91 ±  3%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      6.30 ±  2%      -5.4        0.88 ±  3%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      5.61 ±  2%      -4.8        0.84 ±  3%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      4.97 ±  2%      -4.2        0.78 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      4.84 ±  3%      -4.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      3.16 ±  4%      -2.6        0.61 ±  5%  perf-profile.calltrace.cycles-pp.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending
      2.57            -1.4        1.13 ±  7%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      3.45            -1.2        2.20 ±  8%  perf-profile.calltrace.cycles-pp.core_sys_select.do_pselect.__x64_sys_pselect6.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.70            -1.2        1.50 ±  8%  perf-profile.calltrace.cycles-pp.__poll.stress_run
      2.45            -1.1        1.31 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll.stress_run
      2.43            -1.1        1.30 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll.stress_run
      2.77            -1.1        1.65 ±  8%  perf-profile.calltrace.cycles-pp.do_select.core_sys_select.do_pselect.__x64_sys_pselect6.do_syscall_64
      3.70            -1.1        2.58 ±  8%  perf-profile.calltrace.cycles-pp.ppoll.stress_run
      2.92            -1.1        1.82 ±  8%  perf-profile.calltrace.cycles-pp.__select
      2.30            -1.1        1.20 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll.stress_run
      2.13            -1.1        1.08 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      2.67            -1.0        1.63 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__select
      2.65            -1.0        1.62 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      2.54            -1.0        1.54 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_pselect6.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      2.51            -1.0        1.51 ±  9%  perf-profile.calltrace.cycles-pp.do_pselect.__x64_sys_pselect6.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      2.91            -0.9        2.02 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ppoll.stress_run
      2.86            -0.9        1.98 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ppoll.stress_run
      1.35            -0.9        0.49 ± 45%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      2.53            -0.8        1.72 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_ppoll.do_syscall_64.entry_SYSCALL_64_after_hwframe.ppoll.stress_run
      1.07            -0.7        0.38 ± 70%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.01            -0.6        1.36 ± 28%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write.stress_run
      2.57            -0.6        1.94 ±  9%  perf-profile.calltrace.cycles-pp.pselect.stress_run
      1.24            -0.6        0.64 ±  9%  perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.32            -0.6        1.75 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.pselect.stress_run
      2.30            -0.6        1.74 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.pselect.stress_run
      2.18            -0.5        1.65 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_pselect6.do_syscall_64.entry_SYSCALL_64_after_hwframe.pselect.stress_run
      2.10            -0.5        1.58 ±  9%  perf-profile.calltrace.cycles-pp.do_pselect.__x64_sys_pselect6.do_syscall_64.entry_SYSCALL_64_after_hwframe.pselect
      1.59            -0.5        1.08 ± 29%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read.stress_poll.stress_run
      0.72            -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.__getrlimit.stress_run
      1.46            -0.5        1.00 ±  9%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.30            -0.4        0.86 ±  9%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      0.67            -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.65            -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_run
      0.65            -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_poll
      0.77            -0.4        0.40 ± 71%  perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      0.93            -0.3        0.58 ± 45%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.70            -0.3        0.36 ± 70%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.setrlimit64.stress_run
      0.62 ±  3%      -0.3        0.29 ±100%  perf-profile.calltrace.cycles-pp.pick_task_fair.pick_next_task_fair.__pick_next_task.__schedule.schedule
      0.60 ±  4%      -0.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.dequeue_entities.pick_task_fair.pick_next_task_fair.__pick_next_task.__schedule
      1.09            -0.3        0.77 ±  8%  perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.56 ±  4%      -0.3        0.27 ±100%  perf-profile.calltrace.cycles-pp.dl_server_stop.dequeue_entities.pick_task_fair.pick_next_task_fair.__pick_next_task
      1.15            -0.3        0.87 ±  8%  perf-profile.calltrace.cycles-pp.setrlimit64.stress_run
      0.74            -0.3        0.47 ± 45%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.setrlimit64.stress_run
      0.94            -0.3        0.68 ±  9%  perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_ppoll.do_syscall_64.entry_SYSCALL_64_after_hwframe.ppoll
      0.88            -0.2        0.65 ±  8%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      0.95            -0.1        0.88 ±  5%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      0.95            -0.1        0.88 ±  5%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      0.96            -0.1        0.90 ±  5%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      0.97            -0.1        0.91 ±  5%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      0.97            -0.1        0.91 ±  5%  perf-profile.calltrace.cycles-pp.__cmd_record
      0.97            -0.1        0.91 ±  5%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
      0.97            -0.1        0.91 ±  5%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      0.00            +0.7        0.65 ± 10%  perf-profile.calltrace.cycles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer
      0.00            +0.7        0.67 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      0.00            +0.7        0.70 ± 11%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle
      1.11 ±  8%      +0.7        1.82 ±  5%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.99 ±  9%      +0.7        1.72 ±  6%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.do_nanosleep
      0.00            +0.7        0.74 ± 11%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair
      0.00            +0.8        0.75 ± 11%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__pick_next_task
      0.40 ± 71%      +0.8        1.15 ±  9%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule.schedule
      0.00            +1.0        0.95 ± 10%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule
      0.08 ±223%      +1.0        1.05 ± 10%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up
      0.75 ±  2%      +3.1        3.88 ± 26%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.09 ±223%      +3.7        3.83 ± 27%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle.do_idle
      0.00            +3.8        3.77 ± 27%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch
      0.00            +3.8        3.78 ± 27%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule
      0.00            +3.8        3.80 ± 27%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle
     39.66            +6.2       45.84 ±  2%  perf-profile.calltrace.cycles-pp.common_startup_64
     39.42            +6.2       45.61 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     39.39            +6.2       45.60 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     39.32            +6.3       45.57 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.96 ±  4%      +8.8       12.76 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer
      4.16 ±  4%      +8.9       13.02 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      5.00 ±  3%      +9.2       14.23        perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start
      3.14 ±  8%     +12.2       15.34 ± 16%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      3.33 ±  8%     +12.4       15.73 ± 15%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start
     26.25           +12.6       38.87 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     24.91           +13.0       37.86 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     24.29           +13.0       37.33 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      8.54           +14.8       23.30 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
     13.88           +15.3       29.13 ±  2%  perf-profile.calltrace.cycles-pp.clock_nanosleep
     12.88           +15.6       28.47 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     12.90           +15.6       28.49 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      4.28 ± 10%     +16.2       20.46 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.hrtimer_try_to_cancel.dl_server_stop.dequeue_entities
      5.70 ±  3%     +16.3       22.00 ±  5%  perf-profile.calltrace.cycles-pp.dl_server_stop.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      4.20 ±  4%     +16.4       20.62 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.hrtimer_try_to_cancel.dl_server_stop.dequeue_entities.dequeue_task_fair
     11.34           +16.5       27.80 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     11.04           +16.5       27.58 ±  3%  perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     11.03           +16.5       27.57 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.88           +16.6       27.46 ±  3%  perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
      4.56 ±  4%     +16.7       21.23 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_try_to_cancel.dl_server_stop.dequeue_entities.dequeue_task_fair.try_to_block_task
      6.60 ±  2%     +16.8       23.41 ±  4%  perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      6.56 ±  2%     +16.8       23.38 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.do_nanosleep
      9.56           +16.9       26.44 ±  4%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      9.47           +16.9       26.38 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
     10.92           +20.9       31.83 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     10.03 ±  2%     +21.0       31.00 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      9.54 ±  2%     +21.0       30.58 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      9.38 ±  2%     +21.0       30.43 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      9.54 ±  4%     +21.4       30.97 ±  8%  perf-profile.calltrace.cycles-pp.enqueue_dl_entity.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate
      9.13 ±  4%     +21.6       30.74 ±  8%  perf-profile.calltrace.cycles-pp.start_dl_timer.enqueue_dl_entity.dl_server_start.enqueue_task_fair.enqueue_task
      8.84 ±  4%     +21.7       30.56 ±  8%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start.enqueue_task_fair
      6.41 ±  3%     +24.0       30.41 ±  8%  perf-profile.calltrace.cycles-pp.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up
      8.60 ±  2%     +24.8       33.35 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      8.58 ±  2%     +24.8       33.33 ±  7%  perf-profile.calltrace.cycles-pp.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      7.13 ±  3%     +24.8       31.91 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup
      7.15 ±  3%     +24.8       31.94 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      7.19 ±  3%     +24.8       31.99 ±  7%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      8.91 ±  2%     +24.8       33.76 ±  7%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     40.62           -19.6       21.06 ± 10%  perf-profile.children.cycles-pp.stress_run
     16.04            -8.1        7.94 ±  9%  perf-profile.children.cycles-pp.stress_poll
     13.84            -7.6        6.21 ±  8%  perf-profile.children.cycles-pp.write
     14.59            -7.6        7.03 ±  9%  perf-profile.children.cycles-pp.read
     12.53            -7.5        4.99 ± 10%  perf-profile.children.cycles-pp.intel_idle
     10.91            -6.7        4.20 ±  9%  perf-profile.children.cycles-pp.ksys_read
     10.44            -6.6        3.85 ±  9%  perf-profile.children.cycles-pp.vfs_read
     10.41            -6.5        3.90 ±  8%  perf-profile.children.cycles-pp.ksys_write
     10.00            -6.5        3.53 ±  9%  perf-profile.children.cycles-pp.pipe_read
      7.51            -6.4        1.07 ±  3%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      7.42            -6.4        0.98 ±  4%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
     10.00            -6.4        3.59 ±  8%  perf-profile.children.cycles-pp.vfs_write
      9.34            -6.3        3.08 ±  8%  perf-profile.children.cycles-pp.pipe_write
      6.96 ±  2%      -5.9        1.03 ±  3%  perf-profile.children.cycles-pp.sched_ttwu_pending
      5.18            -4.7        0.53 ±  8%  perf-profile.children.cycles-pp.__wake_up_sync_key
      4.50            -4.4        0.12 ± 10%  perf-profile.children.cycles-pp.__wake_up_common
     48.46            -2.3       46.12        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.58            -2.3        0.30 ±  6%  perf-profile.children.cycles-pp.select_task_rq
     47.90            -2.2       45.72        perf-profile.children.cycles-pp.do_syscall_64
      2.35            -2.1        0.27 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      2.03            -1.8        0.22 ±  5%  perf-profile.children.cycles-pp.select_idle_sibling
      4.74            -1.5        3.19 ±  8%  perf-profile.children.cycles-pp.__x64_sys_pselect6
      4.63            -1.5        3.10 ±  8%  perf-profile.children.cycles-pp.do_pselect
      2.68            -1.5        1.17 ±  7%  perf-profile.children.cycles-pp.dequeue_entity
      3.11            -1.3        1.80 ±  8%  perf-profile.children.cycles-pp.do_sys_poll
      3.35            -1.3        2.05 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.34            -1.3        1.07 ±  9%  perf-profile.children.cycles-pp.pipe_poll
      3.48            -1.3        2.22 ±  9%  perf-profile.children.cycles-pp.core_sys_select
      2.82            -1.2        1.60 ±  8%  perf-profile.children.cycles-pp.__poll
      4.00            -1.2        2.82 ±  8%  perf-profile.children.cycles-pp.ppoll
      3.05            -1.1        1.92 ±  8%  perf-profile.children.cycles-pp.__select
      2.82            -1.1        1.69 ±  8%  perf-profile.children.cycles-pp.do_select
      2.32            -1.1        1.22 ±  8%  perf-profile.children.cycles-pp.__x64_sys_poll
      1.17            -1.0        0.15 ±  6%  perf-profile.children.cycles-pp.available_idle_cpu
      1.85            -1.0        0.84 ±  7%  perf-profile.children.cycles-pp.update_load_avg
      1.05            -1.0        0.08 ± 10%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.12            -0.8        0.27 ±  8%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      3.48            -0.8        2.67 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      3.11 ±  3%      -0.8        2.30 ±  4%  perf-profile.children.cycles-pp.__pick_next_task
      2.55            -0.8        1.74 ±  8%  perf-profile.children.cycles-pp.__x64_sys_ppoll
      2.07            -0.8        1.27 ±  8%  perf-profile.children.cycles-pp.enqueue_entity
      1.85            -0.8        1.07 ±  8%  perf-profile.children.cycles-pp.do_poll
      0.77            -0.7        0.03 ± 70%  perf-profile.children.cycles-pp.__smp_call_single_queue
      1.75            -0.7        1.03 ±  9%  perf-profile.children.cycles-pp.mutex_lock
      2.84 ±  3%      -0.7        2.14 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.88            -0.7        0.19 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      2.67            -0.7        2.02 ±  8%  perf-profile.children.cycles-pp.pselect
      0.92            -0.6        0.31 ±  7%  perf-profile.children.cycles-pp.prepare_task_switch
      0.89            -0.6        0.28 ±  9%  perf-profile.children.cycles-pp.__switch_to
      0.68            -0.6        0.07 ±  8%  perf-profile.children.cycles-pp.set_task_cpu
      0.77            -0.6        0.17 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.65            -0.6        0.07 ±  9%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.72            -0.6        0.16 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      1.13 ±  3%      -0.6        0.57 ±  9%  perf-profile.children.cycles-pp.pick_task_fair
      0.86 ±  3%      -0.5        0.32 ±  8%  perf-profile.children.cycles-pp.update_cfs_group
      0.76            -0.5        0.22 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      1.57            -0.5        1.05 ±  8%  perf-profile.children.cycles-pp._copy_from_user
      1.28            -0.5        0.77 ±  8%  perf-profile.children.cycles-pp.read_tsc
      0.80            -0.5        0.32 ±  9%  perf-profile.children.cycles-pp.__pollwait
      1.50            -0.5        1.03 ±  9%  perf-profile.children.cycles-pp.copy_page_to_iter
      1.00            -0.5        0.52 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.98            -0.5        0.51 ± 10%  perf-profile.children.cycles-pp.ktime_get
      1.31            -0.4        0.87 ±  9%  perf-profile.children.cycles-pp._copy_to_iter
      0.76            -0.4        0.34 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      0.64            -0.4        0.23 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.56            -0.4        0.16 ±  7%  perf-profile.children.cycles-pp.switch_fpu_return
      0.76            -0.4        0.37 ±  9%  perf-profile.children.cycles-pp.add_wait_queue
      0.64            -0.4        0.25 ±  8%  perf-profile.children.cycles-pp.sched_clock_cpu
      1.56            -0.3        1.22 ±  8%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.56            -0.3        0.22 ± 10%  perf-profile.children.cycles-pp.sched_clock
      0.47            -0.3        0.13 ±  8%  perf-profile.children.cycles-pp.do_perf_trace_sched_wakeup_template
      0.83            -0.3        0.49 ±  8%  perf-profile.children.cycles-pp.set_user_sigmask
      1.34            -0.3        1.02 ±  8%  perf-profile.children.cycles-pp.setrlimit64
      1.12            -0.3        0.80 ±  8%  perf-profile.children.cycles-pp.touch_atime
      0.40            -0.3        0.10 ±  8%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.86            -0.3        0.56 ±  8%  perf-profile.children.cycles-pp.__do_sys_prlimit64
      0.59            -0.3        0.31 ±  4%  perf-profile.children.cycles-pp.set_next_task_fair
      0.67            -0.3        0.40 ±  8%  perf-profile.children.cycles-pp.fdget
      0.56            -0.3        0.29 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.45            -0.3        0.18 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.82            -0.3        0.55 ±  8%  perf-profile.children.cycles-pp.__getrlimit
      0.94            -0.2        0.70 ±  8%  perf-profile.children.cycles-pp.atime_needs_update
      0.54            -0.2        0.29 ±  9%  perf-profile.children.cycles-pp.hrtimer_active
      0.91            -0.2        0.66 ±  8%  perf-profile.children.cycles-pp.ktime_get_ts64
      0.95            -0.2        0.72 ±  8%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.93            -0.2        0.70 ±  9%  perf-profile.children.cycles-pp.poll_select_finish
      0.29            -0.2        0.07 ± 10%  perf-profile.children.cycles-pp.perf_tp_event
      0.34            -0.2        0.13 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.47            -0.2        0.26 ±  9%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.64 ±  2%      -0.2        0.44 ± 11%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.78            -0.2        0.58 ±  8%  perf-profile.children.cycles-pp._copy_from_iter
      0.28 ±  2%      -0.2        0.09 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
      0.36            -0.2        0.18 ±  9%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.39 ±  3%      -0.2        0.20 ± 11%  perf-profile.children.cycles-pp.task_contending
      0.67            -0.2        0.49 ±  8%  perf-profile.children.cycles-pp.get_timespec64
      0.54            -0.2        0.37 ±  8%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.63            -0.2        0.46 ±  9%  perf-profile.children.cycles-pp.mutex_unlock
      0.26 ±  2%      -0.2        0.10 ± 11%  perf-profile.children.cycles-pp.__get_user_8
      0.27 ±  2%      -0.2        0.11 ± 10%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.31 ±  2%      -0.2        0.15 ±  8%  perf-profile.children.cycles-pp.__nanosleep
      0.76            -0.2        0.60 ±  8%  perf-profile.children.cycles-pp.current_time
      0.58 ±  3%      -0.2        0.43 ±  8%  perf-profile.children.cycles-pp.idle_cpu
      0.25            -0.2        0.10 ± 11%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.32            -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.do_prlimit
      0.48            -0.1        0.34 ±  9%  perf-profile.children.cycles-pp.fdget_pos
      0.59            -0.1        0.44 ±  8%  perf-profile.children.cycles-pp.file_update_time
      0.64            -0.1        0.50 ±  8%  perf-profile.children.cycles-pp.poll_freewait
      0.54            -0.1        0.40 ±  8%  perf-profile.children.cycles-pp.select_estimate_accuracy
      0.24            -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.sleep
      0.35            -0.1        0.22 ±  8%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.49            -0.1        0.36 ±  9%  perf-profile.children.cycles-pp.rw_verify_area
      0.22 ±  2%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.reweight_entity
      0.87 ±  2%      -0.1        0.75 ±  7%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.48            -0.1        0.36 ±  9%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.17            -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.32            -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.67            -0.1        0.57 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
      0.25            -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.13 ±  3%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.18 ±  2%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.update_entity_lag
      0.38            -0.1        0.29 ±  9%  perf-profile.children.cycles-pp.remove_wait_queue
      0.48            -0.1        0.39 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.29 ±  3%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.12            -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.40            -0.1        0.32 ±  8%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.14            -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.ct_idle_exit
      0.28            -0.1        0.20 ±  8%  perf-profile.children.cycles-pp.__set_current_blocked
      0.44 ±  2%      -0.1        0.36 ±  8%  perf-profile.children.cycles-pp.x64_sys_call
      0.12 ±  3%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.__calc_delta
      0.26 ±  2%      -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.32            -0.1        0.24 ±  8%  perf-profile.children.cycles-pp._copy_to_user
      0.32            -0.1        0.25 ±  9%  perf-profile.children.cycles-pp.__cond_resched
      0.32            -0.1        0.25 ±  8%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.13 ±  3%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__dequeue_entity
      0.12 ±  3%      -0.1        0.05 ± 45%  perf-profile.children.cycles-pp.call_cpuidle
      0.28            -0.1        0.22 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.28            -0.1        0.21 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.18 ±  2%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
      0.95            -0.1        0.88 ±  5%  perf-profile.children.cycles-pp.queue_event
      0.12            -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.update_min_vruntime
      0.95            -0.1        0.88 ±  5%  perf-profile.children.cycles-pp.ordered_events__queue
      0.30            -0.1        0.23 ±  9%  perf-profile.children.cycles-pp.put_timespec64
      0.20 ±  2%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.place_entity
      0.96            -0.1        0.90 ±  5%  perf-profile.children.cycles-pp.process_simple
      0.10 ±  5%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.97            -0.1        0.91 ±  5%  perf-profile.children.cycles-pp.perf_session__process_events
      0.97            -0.1        0.91 ±  5%  perf-profile.children.cycles-pp.reader__read_event
      0.97            -0.1        0.91 ±  5%  perf-profile.children.cycles-pp.record__finish_output
      0.47            -0.1        0.42 ±  9%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.19 ±  2%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp.recalc_sigpending
      0.20            -0.0        0.15 ±  9%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.18 ±  4%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.__enqueue_entity
      0.14 ±  2%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.poll_select_set_timeout
      0.10            -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.task_non_contending
      0.15            -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.os_xsave
      0.10 ±  3%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__mutex_lock
      0.16 ±  2%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.fput
      0.19            -0.0        0.15 ±  9%  perf-profile.children.cycles-pp.security_file_permission
      0.15            -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.17 ±  2%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.rcu_all_qs
      0.12 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.vruntime_eligible
      0.14            -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.__check_object_size
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.__put_user_8
      0.11            -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.__fdelt_warn
      0.14 ±  3%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp.__memset
      0.12 ±  4%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.kill_fasync
      0.14            -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.avg_vruntime
      0.09            -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.06            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.make_vfsgid
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.task_work_run
      0.08            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__fdelt_chk@plt
      0.10 ±  5%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.put_prev_entity
      0.07            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.07            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.get_sigset_argpack
      0.08 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.sched_balance_domains
      0.07 ±  9%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp._find_next_and_bit
      0.06 ±  6%      +0.0        0.09 ± 30%  perf-profile.children.cycles-pp.handle_internal_command
      0.06 ±  6%      +0.0        0.09 ± 30%  perf-profile.children.cycles-pp.main
      0.06 ±  6%      +0.0        0.09 ± 30%  perf-profile.children.cycles-pp.run_builtin
      0.05            +0.0        0.08 ± 31%  perf-profile.children.cycles-pp.cmd_record
      0.00            +0.1        0.06 ± 31%  perf-profile.children.cycles-pp.perf_mmap__push
      0.00            +0.1        0.07 ± 36%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.48            +0.1        0.57 ±  8%  perf-profile.children.cycles-pp.timerqueue_del
      0.12 ±  3%      +0.1        0.22 ± 19%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.sched_balance_find_src_rq
      0.41            +0.1        0.52 ±  8%  perf-profile.children.cycles-pp.rb_erase
      0.08 ±  6%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.24 ±  4%      +0.2        0.43 ± 19%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.30 ±  3%      +0.2        0.48 ± 18%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.12 ±  7%      +0.2        0.32 ± 22%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.45 ±  2%      +0.3        0.74 ± 18%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.15            +0.3        0.46 ± 22%  perf-profile.children.cycles-pp.poll_idle
      0.80 ± 16%      +0.4        1.17 ±  9%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.38 ± 28%      +0.4        0.77 ± 11%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.36 ± 30%      +0.4        0.74 ± 11%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.40 ± 27%      +0.4        0.79 ± 11%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.47 ± 24%      +0.5        1.00 ±  9%  perf-profile.children.cycles-pp.sched_balance_rq
      1.51            +2.6        4.10 ± 25%  perf-profile.children.cycles-pp.finish_task_switch
     39.66            +6.2       45.84 ±  2%  perf-profile.children.cycles-pp.common_startup_64
     39.66            +6.2       45.84 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     39.42            +6.2       45.61 ±  3%  perf-profile.children.cycles-pp.start_secondary
     39.60            +6.2       45.82 ±  2%  perf-profile.children.cycles-pp.do_idle
      5.60 ±  2%      +8.7       14.34        perf-profile.children.cycles-pp._raw_spin_lock
      6.49 ±  2%      +8.8       15.24        perf-profile.children.cycles-pp.__hrtimer_start_range_ns
     13.94           +12.5       26.47 ±  4%  perf-profile.children.cycles-pp.schedule
     26.42           +12.7       39.07 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
     25.01           +13.0       37.98 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
     24.98           +13.0       37.97 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
     18.29           +13.4       31.65 ±  6%  perf-profile.children.cycles-pp.__schedule
      9.51 ±  2%     +14.3       23.82 ±  5%  perf-profile.children.cycles-pp.dequeue_entities
      8.69           +14.7       23.42 ±  4%  perf-profile.children.cycles-pp.try_to_block_task
      8.63           +14.8       23.40 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
     14.16           +15.1       29.27 ±  2%  perf-profile.children.cycles-pp.clock_nanosleep
      6.58 ±  3%     +15.9       22.49 ±  5%  perf-profile.children.cycles-pp.dl_server_stop
      6.11 ±  3%     +16.0       22.10 ±  6%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
     11.36           +16.4       27.80 ±  3%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
     11.13           +16.5       27.63 ±  3%  perf-profile.children.cycles-pp.common_nsleep
     11.04           +16.5       27.58 ±  3%  perf-profile.children.cycles-pp.hrtimer_nanosleep
     10.90           +16.6       27.48 ±  3%  perf-profile.children.cycles-pp.do_nanosleep
     13.85 ±  2%     +19.6       33.48 ±  7%  perf-profile.children.cycles-pp.ttwu_do_activate
     13.09 ±  2%     +20.3       33.39 ±  7%  perf-profile.children.cycles-pp.enqueue_task
     13.56           +20.4       33.96 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
     12.92 ±  3%     +20.4       33.35 ±  7%  perf-profile.children.cycles-pp.enqueue_task_fair
     10.20 ±  4%     +21.4       31.56 ±  8%  perf-profile.children.cycles-pp.enqueue_dl_entity
     10.24 ±  4%     +21.4       31.61 ±  8%  perf-profile.children.cycles-pp.dl_server_start
     11.02 ±  3%     +21.5       32.51 ±  7%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      9.74 ±  4%     +21.6       31.34 ±  8%  perf-profile.children.cycles-pp.start_dl_timer
     12.42           +24.0       36.41 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     11.69           +24.1       35.78 ±  6%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     11.11 ±  2%     +24.2       35.30 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     10.91 ±  2%     +24.2       35.13 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
     10.24 ±  2%     +24.2       34.49 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      9.69 ±  2%     +24.3       33.96 ±  7%  perf-profile.children.cycles-pp.hrtimer_wakeup
     11.90 ±  4%     +27.9       39.77 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     13.14 ±  4%     +38.1       51.29 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     12.52            -7.5        4.99 ± 10%  perf-profile.self.cycles-pp.intel_idle
      3.10            -1.4        1.72 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.16            -1.0        0.15 ±  6%  perf-profile.self.cycles-pp.available_idle_cpu
      1.65            -0.9        0.74 ±  5%  perf-profile.self.cycles-pp.__schedule
      1.07            -0.9        0.20 ±  8%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.44            -0.6        0.80 ±  9%  perf-profile.self.cycles-pp.mutex_lock
      0.87            -0.6        0.27 ±  9%  perf-profile.self.cycles-pp.__switch_to
      0.88            -0.6        0.28 ±  8%  perf-profile.self.cycles-pp.update_load_avg
      1.94            -0.6        1.36 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.64            -0.6        0.07 ±  9%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.85 ±  3%      -0.5        0.31 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
      0.75            -0.5        0.22 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      1.51            -0.5        1.02 ±  8%  perf-profile.self.cycles-pp._copy_from_user
      0.72            -0.5        0.23 ±  6%  perf-profile.self.cycles-pp.prepare_task_switch
      0.58            -0.5        0.09 ±  7%  perf-profile.self.cycles-pp.__wake_up_common
      1.22            -0.5        0.74 ±  8%  perf-profile.self.cycles-pp.read_tsc
      0.77            -0.5        0.31 ±  9%  perf-profile.self.cycles-pp.__pollwait
      1.25            -0.5        0.79 ±  9%  perf-profile.self.cycles-pp.stress_poll
      1.29 ±  2%      -0.5        0.83 ±  8%  perf-profile.self.cycles-pp.pipe_read
      1.26            -0.4        0.84 ±  9%  perf-profile.self.cycles-pp._copy_to_iter
      0.59            -0.4        0.18 ±  4%  perf-profile.self.cycles-pp.finish_task_switch
      0.62            -0.4        0.22 ±  9%  perf-profile.self.cycles-pp.native_sched_clock
      0.71            -0.4        0.34 ±  9%  perf-profile.self.cycles-pp.pipe_poll
      0.43            -0.4        0.08 ±  6%  perf-profile.self.cycles-pp.try_to_wake_up
      0.92            -0.4        0.57 ±  9%  perf-profile.self.cycles-pp.pipe_write
      1.53            -0.3        1.19 ±  8%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.40            -0.3        0.10 ±  8%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.42            -0.3        0.14 ±  8%  perf-profile.self.cycles-pp.menu_select
      0.56            -0.3        0.29 ±  9%  perf-profile.self.cycles-pp.do_sys_poll
      0.63            -0.3        0.37 ±  9%  perf-profile.self.cycles-pp.fdget
      1.08            -0.2        0.83 ±  9%  perf-profile.self.cycles-pp.read
      0.38            -0.2        0.13 ±  7%  perf-profile.self.cycles-pp.dequeue_entity
      0.42            -0.2        0.17 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.92            -0.2        0.67 ±  8%  perf-profile.self.cycles-pp.do_syscall_64
      0.99            -0.2        0.74 ±  8%  perf-profile.self.cycles-pp.write
      0.28            -0.2        0.04 ± 45%  perf-profile.self.cycles-pp.set_task_cpu
      0.51            -0.2        0.28 ± 10%  perf-profile.self.cycles-pp.hrtimer_active
      0.46            -0.2        0.23 ±  7%  perf-profile.self.cycles-pp.update_rq_clock
      0.76            -0.2        0.57 ±  9%  perf-profile.self.cycles-pp._copy_from_iter
      0.32 ±  2%      -0.2        0.13 ±  8%  perf-profile.self.cycles-pp.update_curr
      0.70            -0.2        0.52 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.28            -0.2        0.11 ±  8%  perf-profile.self.cycles-pp.do_idle
      0.34            -0.2        0.17 ±  7%  perf-profile.self.cycles-pp.clock_nanosleep
      0.60            -0.2        0.44 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.91            -0.2        0.74 ±  9%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.22 ±  3%      -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.60            -0.2        0.44 ±  9%  perf-profile.self.cycles-pp.mutex_unlock
      0.57 ±  2%      -0.2        0.41 ±  9%  perf-profile.self.cycles-pp.idle_cpu
      0.25 ±  2%      -0.2        0.10 ±  9%  perf-profile.self.cycles-pp.__get_user_8
      0.45 ±  2%      -0.2        0.30 ±  9%  perf-profile.self.cycles-pp.atime_needs_update
      0.37 ±  2%      -0.1        0.23 ± 11%  perf-profile.self.cycles-pp.ktime_get
      0.58            -0.1        0.43 ±  9%  perf-profile.self.cycles-pp.vfs_read
      0.24            -0.1        0.09 ±  7%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.44 ±  2%      -0.1        0.30 ±  9%  perf-profile.self.cycles-pp.fdget_pos
      0.46            -0.1        0.34 ±  9%  perf-profile.self.cycles-pp.ppoll
      0.21            -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.23 ±  2%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.19 ±  2%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.___perf_sw_event
      0.18 ±  2%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.46            -0.1        0.33 ±  8%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.21            -0.1        0.09 ± 12%  perf-profile.self.cycles-pp.sleep
      0.57            -0.1        0.46 ±  9%  perf-profile.self.cycles-pp.do_select
      0.46            -0.1        0.34 ±  8%  perf-profile.self.cycles-pp.vfs_write
      0.42            -0.1        0.31 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.16 ±  2%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.switch_fpu_return
      0.29            -0.1        0.18 ±  9%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.19            -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.reweight_entity
      0.20            -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.hrtimer_start_range_ns
      0.13 ±  3%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.29            -0.1        0.20 ± 10%  perf-profile.self.cycles-pp.rw_verify_area
      0.11            -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.__calc_delta
      0.44            -0.1        0.35 ±  8%  perf-profile.self.cycles-pp.current_time
      0.40            -0.1        0.32 ±  8%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.18 ±  2%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.11 ±  4%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.28            -0.1        0.20 ±  8%  perf-profile.self.cycles-pp.__do_sys_prlimit64
      0.10 ±  3%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.__dequeue_entity
      0.30            -0.1        0.23 ±  5%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.31            -0.1        0.24 ±  9%  perf-profile.self.cycles-pp._copy_to_user
      0.39            -0.1        0.32 ±  9%  perf-profile.self.cycles-pp.x64_sys_call
      0.11            -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.update_min_vruntime
      0.28            -0.1        0.21 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.29 ±  2%      -0.1        0.22 ±  8%  perf-profile.self.cycles-pp.ktime_get_ts64
      0.28            -0.1        0.22 ±  9%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.23            -0.1        0.17 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10 ±  3%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.place_entity
      0.13 ±  3%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.__wake_up_sync_key
      0.20 ±  2%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.select_estimate_accuracy
      0.47            -0.1        0.42 ±  9%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.30            -0.1        0.25 ± 11%  perf-profile.self.cycles-pp.core_sys_select
      0.21 ±  3%      -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.dequeue_entities
      0.20            -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.15            -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.get_timespec64
      0.24            -0.0        0.19 ±  7%  perf-profile.self.cycles-pp.do_poll
      0.21            -0.0        0.16 ±  9%  perf-profile.self.cycles-pp.setrlimit64
      0.21            -0.0        0.16 ±  7%  perf-profile.self.cycles-pp.ksys_write
      0.19 ±  2%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.recalc_sigpending
      0.23 ±  2%      -0.0        0.18 ±  8%  perf-profile.self.cycles-pp.ksys_read
      0.18            -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__cond_resched
      0.17 ±  2%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.15            -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.os_xsave
      0.11 ±  6%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__pick_next_task
      0.16 ±  2%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.__select
      0.21            -0.0        0.17 ±  9%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.17 ±  4%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__enqueue_entity
      0.06            -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__put_user_8
      0.06            -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.09 ±  5%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.common_nsleep
      0.16 ±  3%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.12 ±  3%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.16            -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.security_file_permission
      0.15 ±  2%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.fput
      0.11            -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.vruntime_eligible
      0.12 ±  3%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.__nanosleep
      0.12            -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.__x64_sys_clock_nanosleep
      0.07            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__fdelt_warn
      0.13 ±  2%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.__poll
      0.12            -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.poll_select_finish
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.set_user_sigmask
      0.13 ±  2%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.pselect
      0.10 ±  4%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp.get_nohz_timer_target
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__getrlimit
      0.09            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.do_prlimit
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.rcu_all_qs
      0.09            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.07 ±  5%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.get_sigset_argpack
      0.10 ±  3%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.do_nanosleep
      0.10 ±  4%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.file_update_time
      0.07 ±  7%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.kill_fasync
      0.12 ±  3%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.__memset
      0.10 ±  5%      -0.0        0.08 ± 12%  perf-profile.self.cycles-pp.start_dl_timer
      0.08 ±  4%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.09            -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.__x64_sys_ppoll
      0.13 ±  3%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.avg_vruntime
      0.08            -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.add_wait_queue
      0.08            -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.hrtimer_nanosleep
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.do_pselect
      0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.touch_atime
      0.07 ±  7%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.sched_balance_find_src_rq
      0.40            +0.1        0.52 ±  8%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.2        0.15 ±  9%  perf-profile.self.cycles-pp.update_curr_dl_se
      0.29 ± 30%      +0.3        0.58 ± 11%  perf-profile.self.cycles-pp.update_sg_lb_stats
     13.13 ±  5%     +38.1       51.28 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


