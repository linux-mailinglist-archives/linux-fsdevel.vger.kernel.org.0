Return-Path: <linux-fsdevel+bounces-37189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF849EF0BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353331895F4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB35226557;
	Thu, 12 Dec 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYcxf6MT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430042210CF;
	Thu, 12 Dec 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020023; cv=fail; b=MdB6rrit4Zc+hjHoO6DsZU6tl5IHe7vi6eK4OsmXYYWbgNr7KYJkIeTPpQtMorSY52I0gfm5I5vPu3eO4HoqkecITsWrkg6ODLAKAVxOpiK6G8d+lwNIwYOtAUQtg37l5GJPivK//VTrHWM8/dXwAmpaeD/kECyAY1pRo9821vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020023; c=relaxed/simple;
	bh=MnGdUkDS1p9aYLzJlE5qXa3hmnF/BCV3GLK8ej5IEpI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CLc9DFdsks9x2DdzQRaNJZC+8BQXE5mNziVVOa20NhlpFavM+iWLLGQGESO5+ANd546k80lZAC/Mm/3lRXpEYpn6gBIhuZBHDA2TWER2V4hAt9+T1hfRTbk2GD5tdA/+DUgVBALv9NzaOVgMBX4iyn2Xj9Pv321pbl6GEifc5wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYcxf6MT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734020022; x=1765556022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MnGdUkDS1p9aYLzJlE5qXa3hmnF/BCV3GLK8ej5IEpI=;
  b=QYcxf6MTNepU7DbparN6utQP12IS7r2wTl8H8I8HbEvYZjjzUNspxUjw
   VilGX87SQiRvB1xMngsduBhABGyky4QPZrtyibCh1NFRQaddlV8XD4W++
   v8xl/hFFsfi5f3aszU/Nr3OTh7peyfTCnCJi/5/83VJ7aUsUKw/a8T749
   lBewL0yfWCjhTNrLuYZI0G5uFWfyINd0YLHbpUdhpzw4XybQ5iVXtr1yB
   6O0xDX4Z8K66Q2fu+6JZWC35Aa7oLr//07KEx1Afam37WD1Iiwp/6mnJd
   toCIvLBMoFZsKOFmFY9IvtaTHDfqzpQFkXSYOwlhFUzsK/34rppLHpSI5
   A==;
X-CSE-ConnectionGUID: oYWvlwJ4RM65Zce7DFd/Hg==
X-CSE-MsgGUID: jVMNRZVWRqi17rJi4v9mjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34172573"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="34172573"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 08:13:32 -0800
X-CSE-ConnectionGUID: BHmGfWttSkCk6Y8w+FLs0Q==
X-CSE-MsgGUID: jjSka4FUTW216gs+gb6p8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="96013334"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 08:13:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 08:13:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 08:13:23 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 08:12:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYIuF1l89xZJx29dCAUKqraHMnNtDaWg4Zcnr7ylJq8sD8auNKrYWyo9+YJOrr5WBMG56EDKPCgoF7ygsd+6QEUOY4kC76TeKeKKfdpmo2Adj73rJ6MaIBfvFVLGpoWUsM2J8A9tAI7DLn8rtpLAJ/qymMrqA/ZPFTrx6POQWslfiqphOpu8y3hQbJ7GGcrmqpACi2GsjGrXUqBnym8sFblg3x3NnQEyN8NxMT7zCqQHyzYQdj57TAFIlGxo6f9V3XIxaHZJU3RGPVOq0lh9uGgIhNh6BNRd4N4hDkRdkW3SSJMj4mfvxpSf4tj8FIdaFyPICgvcK/OPn+AHXvgikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up6jcr1tonkzV04Sz7JtXQEYBG4teZEXPMzGfHTVo3w=;
 b=o+PhteOcWmSUbb25sj8w7GlxqJ4xZRX9fGEvt3Qg3ZcSiPWufPMwpfPnSwLa8z447dkyua9v/crH7vWf4F4yC6KTOscr6bjgyn9zJBWOOxWPouzQaMChfecpfXkdE6pGM8BBsW7a8XMpj8ytcSbj04Rprc9LlicDo4GjVEVTJQVuEoTbPOLE8u0tUOSIJ0/rbg8f+h5bQlmA4368yqTC2a97c3Te74fj3qMQWPe4u+etxS6yvS6E/zjWpvN5TgRMeZbPYK5JZMX6Lgw73x4thFgKHuqdV0y1Ywj+cXi6Fbu6jhURsnHoGC2xg2fQASuRFHdrgIo+vJgJuiV8+qGu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 16:12:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 16:12:40 +0000
Date: Fri, 13 Dec 2024 00:12:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [brauner-vfs:work.pidfs.maple_tree] [pidfs] 93d6e4cbc8:
 WARNING:inconsistent_lock_state
Message-ID: <202412122317.e295e7c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4d5772-627d-4ff3-8950-08dd1ac7cd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bYGa/uezCb2j4bVVjUfX6iUoE9+lehRH5KGkI7jFujlP1kZJCf79LK3lhjbC?=
 =?us-ascii?Q?alwCq7TL124QGjrbYVrRmnYYrRwCGzZSmnbrQrCmPp5tB6r3rh+im9k1zcY0?=
 =?us-ascii?Q?1+Xp6erWB2sfk58UrDLh0muDfzecbS9CJ0EMSqDHj16y3H21mGU3AxXX91JY?=
 =?us-ascii?Q?Vr6bkwqE9iKsOqqlj2CP9qbH7pHhV8003ExeZb7fVgl5IuUPRI6938YqTVGr?=
 =?us-ascii?Q?GV6iPD4O8b9peoZAPjDcZ6f79KPD2sHPAazHvrVJYgOrlmCPgRs0bQboijHT?=
 =?us-ascii?Q?syssUXQHGdpxZ+NrJkM+MBY616KMiXWerDAAjM8taav3KqZHs/jgPJakeWKt?=
 =?us-ascii?Q?AFbeH4xsA84ZOCSZo2b3I0VPbOclkz03+LLOwLFl4k7jvP0JGyZ32xHc4k+Z?=
 =?us-ascii?Q?IFdm/RvKtvIap/qI+1JfbPvsZDw4wfMeriQC7JXRN1HLIeLBHZMHGT4b07yj?=
 =?us-ascii?Q?RuaVZ4WP6t8zHkoIiJ0em98md0pc2tI4AOfS2rm4FVJOFBwIF93DtAKlc9TX?=
 =?us-ascii?Q?SdObink/wpeoy9vV2uAgxSiked8BZ1Y5vLAh7CdDZkd3qNx2C/vXOS40MWr4?=
 =?us-ascii?Q?q1kfJ/Pk/e8HpUXYsXYR6ICtBDRNXNN1IymkmmtRTzNFnroC9boXGF57LsSZ?=
 =?us-ascii?Q?sueLqYx3qGL5VJtdCvylPATmH6GXXym/582QkKH+IHPMDjZVv1KsE+xnlpHX?=
 =?us-ascii?Q?Q8HxP3OM99wQGP/l2W5JzI9b6oS9P+UAaWRMOlNhAnm5P9Uh5n+x8L8E3Eof?=
 =?us-ascii?Q?zzjemYMtWToHmzZ6b4QzJ8zPeKO4mZqogbzHATD2VShV7br6jqCs3lx908td?=
 =?us-ascii?Q?OlVmz4NBkl1JeHGDkjXU3EAq/lxmYHo7cUnIHjNoKPYogJvvFtGRoI2LxVT6?=
 =?us-ascii?Q?G10zQbp+5qZDCb/PyDydY+ny29B8bcrEH2YPwxzmTLq6C9yE9nYGoyqSlrhq?=
 =?us-ascii?Q?Z2h+U/ivgmKoz/+uxNUstCZMLUz7hRmYQ8bK2T1RZJfuYH9vi5XdbWuhogJA?=
 =?us-ascii?Q?YombG91JoQRI3m1/fR7vPk76a7WY4qDpFwH/lOl1h9jSpuOmG5fBiwF4h9oF?=
 =?us-ascii?Q?J2uTJMzQt7z15yS+7GqqBZi88gjD+9G/fvjZB7BEp9N9HbXiFmTTe6l2aNQa?=
 =?us-ascii?Q?MoOoOLmuSY05g8tQHaj8A3cWpmo35cB8Gv/BENz4lf+qb3kbLeFDJF7SXSS4?=
 =?us-ascii?Q?Ni1ygKdKEiFUjRmLKFdtHl8dhKtsppdurj+u0+npV/opGfP73dhQxLeCw+To?=
 =?us-ascii?Q?kZnTbNTmQD/3FrUhNkFPZMVNHhfPtJiZnNsh/wvB/WO9wRFpSKX0Vn2aUOo4?=
 =?us-ascii?Q?THAbh/+a3PSpVWJ9ZIx/NSlo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SbIIpU9fHqAiKM/JtslB/f07aXf9tNNxwCaOm+yBUxw/yIP1unCtiYAjw2tq?=
 =?us-ascii?Q?uDukQfJ97Jt0K92OY5oxOdi2LBjDz0F8sWUokAZD0rLRSnzIV0wmMTA2f0EC?=
 =?us-ascii?Q?n/ERebrBAoYPiHfsJBzHU3UCLkzKg0GWYUv7OqSXT4ymfR89Ly9iKXAnVqv0?=
 =?us-ascii?Q?jt0qO+M2XG+cQtIHMHxfU+LEKzQdEhmkN6I8KMjx3mqpELmPsnime5YCb52u?=
 =?us-ascii?Q?9ccKE9hU3WhYpT76sGgGLRe9zSysnr7cH1zQvXNxoiEX9EwRyVwMEGXu3toM?=
 =?us-ascii?Q?1t8jdVCbwWMuRxRw89D+t8GDoFytiHPnMTRFd9BbSrJxRacNV3Dd/ts/uT7T?=
 =?us-ascii?Q?quZDOKZZcDkQktf1ARV+khSxK4JW/1qspThBLklDW845toJBD89TEaEL7trl?=
 =?us-ascii?Q?leL9FpEQq9K9mKrIgqsTC1pBjfVAlA9nrRpb9Ht8poqIGFW+jlUyHAld4Sdz?=
 =?us-ascii?Q?IE3Ruly/0fE9Wc/M6VuDMz+dCbxacAUv8wi8dpTVEFzEPt9X88f1BAeOrBnw?=
 =?us-ascii?Q?DFduJUawlqqHE38Og6qFnz/dczl9hbz/2IaVyRCwtP7Y8haTWx1DMnezJjFO?=
 =?us-ascii?Q?n8V+FLVQc4sFDcv2qkB6Y5LNC8zGCxQrbC9eSPbvQ/eEWm4mEgORCQsrDJTX?=
 =?us-ascii?Q?g5WcHJGDE9b3LWKUalFA6+3Q8uAFML+VrzOG5olil+C+7dR0QomC8MEe7VlW?=
 =?us-ascii?Q?NzyqC1/NoccHGaUGrBPxeO8YqVlJ53US+erpLU+bBRtii98IagungXgHERvy?=
 =?us-ascii?Q?ltzoIW9t7IHpkrJ5XDGG4L/KUHTHVMgfs1QlXwbm/xkYDPj13+2uJYx3xOxw?=
 =?us-ascii?Q?HhGysfNf6ezqNGuvFUpALqQjmc/X4Ye3aUxaocLt9BMJ58OssESCqSZdq+u/?=
 =?us-ascii?Q?ndNGDssuaqXx+UBcQCXTOM1id/aGaeGWlJ1+rW+VVM1eVJhvreMKpFR9zalZ?=
 =?us-ascii?Q?WSTQ9Ma0O0CdLfQH0t+4CSlSh2mdDigl5KiVt5dX1vp408WbQkpixU1N3KTt?=
 =?us-ascii?Q?/0JAPmNmOJXi8208F9178vsantXpNh5qskKJhOn+JC1/CrxEaHHvXr14nb4a?=
 =?us-ascii?Q?z6tffFKYqGHwn5wjhG0ap35RcPSPtciYlYrBhksZWefLMIAjwz7qQ6KCOw3g?=
 =?us-ascii?Q?pJ4zoZfNGj4LsJbc5f6FD2nrzYRsmo9W0tXyTcljlbKNrfA7SbTxQ5lVyJFv?=
 =?us-ascii?Q?QlvZMgF+loufqjTPhP0kuIjKKrWg/O5wrlNgpkOZcOkrdDz6xfnyJQwv0BXU?=
 =?us-ascii?Q?EIXXOXcTVZ8RSQMF2IYeLEXNXHe6LqYO0RqZF5Gpd/z9uftj9tZUVWMAS4G/?=
 =?us-ascii?Q?T3Qxz4t7bms9Z/dzcqCkUDQ/YtvATKLdO6y2ww5OryZfw1Fg/l5vwirix1zu?=
 =?us-ascii?Q?yO2w6r8SbgRkBKwHJKLVMBHtoTwTdy9MpV2Z8rF3NehBd38GWLNW3ceoWkf0?=
 =?us-ascii?Q?p3xqYI4mtKJeexsZ+ZzHNr/WhdyraSJ7uUuQ58GwVvUkkwZfo5+/jo7LGH2x?=
 =?us-ascii?Q?hv2xwghq8TLn9YHVzHXMri4CrWtSpDJaYGizeqWR5lxQz+VycLTiQeHIgCxX?=
 =?us-ascii?Q?SLaTs96OKF91Sesdr0VDucyxSDDm4mfpCo7VJJrzAZedoYmbHTPcNc9ihTV9?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4d5772-627d-4ff3-8950-08dd1ac7cd88
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 16:12:40.6596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6+Smq2quxoTIpI83/yosqZHvqU/hmulJNkGh+4bySesZWdMpxD6ZNizP9oxRbhnBG+1hQTkpaoqSPYtgS9xUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6373
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:inconsistent_lock_state" on:

commit: 93d6e4cbc8375acb1995cee651b2ffbc0c8d4393 ("pidfs: use maple tree")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.pidfs.maple_tree

in testcase: boot

config: i386-randconfig-053-20241211
compiler: clang-19
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------+------------+------------+
|                                                 | 6c31256f35 | 93d6e4cbc8 |
+-------------------------------------------------+------------+------------+
| WARNING:inconsistent_lock_state                 | 0          | 12         |
| inconsistent{HARDIRQ-ON-W}->{IN-HARDIRQ-W}usage | 0          | 12         |
+-------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412122317.e295e7c-lkp@intel.com


[   15.226693][    C0] WARNING: inconsistent lock state
[   15.227260][    C0] 6.13.0-rc1-00019-g93d6e4cbc837 #1 Not tainted
[   15.227912][    C0] --------------------------------
[   15.228468][    C0] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[   15.229168][    C0] wrapper/381 [HC1[1]:SC0[0]:HE0:SE1] takes:
[ 15.229787][ C0] 447eb710 (&sighand->siglock){?.+.}-{3:3}, at: __lock_task_sighand (kernel/signal.c:1379 (discriminator 2))
[   15.230624][    C0] {HARDIRQ-ON-W} state was registered at:
[   15.231210][    C0] irq event stamp: 52
[ 15.231660][ C0] hardirqs last enabled at (51): do_user_addr_fault (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 arch/x86/mm/fault.c:1283)
[ 15.232611][ C0] hardirqs last disabled at (52): common_interrupt (arch/x86/kernel/irq.c:?)
[ 15.233569][ C0] softirqs last enabled at (0): copy_process (kernel/fork.c:2341 (discriminator 1))
[ 15.234486][ C0] softirqs last disabled at (0): 0x0
[   15.235177][    C0]
[   15.235177][    C0] other info that might help us debug this:
[   15.236041][    C0]  Possible unsafe locking scenario:
[   15.236041][    C0]
[   15.236854][    C0]        CPU0
[   15.237265][    C0]        ----
[   15.237667][    C0]   lock(&sighand->siglock);
[   15.238169][    C0]   <Interrupt>
[   15.238586][    C0]     lock(&sighand->siglock);
[   15.239121][    C0]
[   15.239121][    C0]  *** DEADLOCK ***
[   15.239121][    C0]
[   15.240047][    C0] 7 locks held by wrapper/381:
[ 15.240569][ C0] #0: 5913922c (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma (arch/x86/include/asm/jump_label.h:36 include/linux/mmap_lock.h:35 include/linux/mmap_lock.h:164 mm/memory.c:6149 mm/memory.c:6209)
[ 15.241559][ C0] #1: 427b0200 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire (include/linux/rcupdate.h:336)
[ 15.242471][ C0] #2: 427b0200 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire (include/linux/rcupdate.h:336)
[ 15.243393][ C0] #3: 427b0200 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire (include/linux/rcupdate.h:336)
[ 15.244337][ C0] #4: 591391e0 (&mm->page_table_lock){+.+.}-{3:3}, at: __pte_offset_map_lock (include/linux/spinlock.h:? mm/pgtable-generic.c:402)
[ 15.245377][ C0] #5: 427b0200 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire (include/linux/rcupdate.h:336)
[ 15.246296][ C0] #6: 427b0200 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire (include/linux/rcupdate.h:336)
[   15.247226][    C0]
[   15.247226][    C0] stack backtrace:
[   15.247920][    C0] CPU: 0 UID: 0 PID: 381 Comm: wrapper Not tainted 6.13.0-rc1-00019-g93d6e4cbc837 #1 30133bc52252e570a7a9e29c909fe9dc5601a36c
[   15.249200][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   15.250283][    C0] Call Trace:
[   15.250696][    C0]  <IRQ>
[ 15.251056][ C0] ? dump_stack_lvl (lib/dump_stack.c:122)
[ 15.251566][ C0] ? dump_stack (lib/dump_stack.c:129)
[ 15.252058][ C0] ? print_usage_bug (kernel/locking/lockdep.c:4040)
[ 15.252605][ C0] ? mark_lock_irq (kernel/locking/lockdep.c:4052 kernel/locking/lockdep.c:?)
[ 15.253148][ C0] ? save_trace (kernel/locking/lockdep.c:556 kernel/locking/lockdep.c:591)
[ 15.253670][ C0] ? mark_lock (kernel/locking/lockdep.c:4749)
[ 15.254165][ C0] ? __lock_acquire (kernel/locking/lockdep.c:?)
[ 15.254684][ C0] ? __lock_acquire (kernel/locking/lockdep.c:4670)
[ 15.255167][ C0] ? __lock_acquire (kernel/locking/lockdep.c:4670)
[ 15.255655][ C0] ? __lock_acquire (kernel/locking/lockdep.c:4670)
[ 15.256175][ C0] ? lock_acquire (kernel/locking/lockdep.c:5849)
[ 15.256702][ C0] ? __lock_task_sighand (kernel/signal.c:1379 (discriminator 2))
[ 15.257287][ C0] ? trace_raw_output_signal_deliver (include/linux/rcupdate.h:336)
[ 15.257972][ C0] ? _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162)
[ 15.258556][ C0] ? __lock_task_sighand (kernel/signal.c:1379 (discriminator 2))
[ 15.259131][ C0] ? __lock_task_sighand (kernel/signal.c:1379 (discriminator 2))
[ 15.259716][ C0] ? group_send_sig_info (kernel/signal.c:1267 kernel/signal.c:1418)
[ 15.260283][ C0] ? kill_pid_info_type (kernel/signal.c:1458)
[ 15.260838][ C0] ? posixtimer_rearm_itimer (kernel/time/itimer.c:177)
[ 15.261436][ C0] ? kill_pid_info (kernel/signal.c:1472)
[ 15.261905][ C0] ? it_real_fn (kernel/time/itimer.c:185)
[ 15.262339][ C0] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1739 (discriminator 256))
[ 15.262845][ C0] ? _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162)
[ 15.263418][ C0] ? hrtimer_interrupt (kernel/time/hrtimer.c:1865 (discriminator 2))
[ 15.263979][ C0] ? mask_and_ack_8259A (arch/x86/kernel/i8259.c:158 (discriminator 1))
[ 15.264560][ C0] ? timer_interrupt (arch/x86/kernel/time.c:40)
[ 15.265102][ C0] ? __handle_irq_event_percpu (kernel/irq/handle.c:158)
[ 15.265744][ C0] ? handle_irq_event (kernel/irq/handle.c:193 kernel/irq/handle.c:210)
[ 15.266295][ C0] ? handle_level_irq (include/linux/irq.h:348 kernel/irq/chip.c:614 kernel/irq/chip.c:650)
[ 15.266831][ C0] ? handle_untracked_irq (kernel/irq/chip.c:629)
[ 15.267408][ C0] ? __handle_irq (arch/x86/kernel/irq_32.c:97 arch/x86/kernel/irq_32.c:155)
[   15.267916][    C0]  </IRQ>
[ 15.268283][ C0] ? __common_interrupt (include/asm-generic/irq_regs.h:28 (discriminator 3) arch/x86/kernel/irq.c:288 (discriminator 3))
[ 15.268842][ C0] ? common_interrupt (arch/x86/kernel/irq.c:278 (discriminator 9))
[ 15.269399][ C0] ? asm_common_interrupt (arch/x86/entry/entry_32.S:693)
[ 15.269968][ C0] ? filemap_map_pages (arch/x86/include/asm/bitops.h:206 (discriminator 2) arch/x86/include/asm/bitops.h:238 (discriminator 2) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 2) include/linux/page-flags.h:824 (discriminator 2) include/linux/page-flags.h:845 (discriminator 2) mm/filemap.c:3677 (discriminator 2))
[ 15.270526][ C0] ? filemap_map_pages (arch/x86/include/asm/bitops.h:206 (discriminator 2) arch/x86/include/asm/bitops.h:238 (discriminator 2) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 2) include/linux/page-flags.h:824 (discriminator 2) include/linux/page-flags.h:845 (discriminator 2) mm/filemap.c:3677 (discriminator 2))
[ 15.271086][ C0] ? rcu_read_unlock (init/main.c:1376)
[ 15.271633][ C0] ? rcu_lock_acquire (include/linux/rcupdate.h:346)
[ 15.272201][ C0] ? rcu_lock_acquire (include/linux/rcupdate.h:337 (discriminator 1))
[ 15.272764][ C0] ? filemap_read_folio (mm/filemap.c:3633)
[ 15.273339][ C0] ? handle_mm_fault (mm/memory.c:5280 mm/memory.c:5313 mm/memory.c:5456 mm/memory.c:3979 mm/memory.c:5801 mm/memory.c:5944 mm/memory.c:6112)
[ 15.273892][ C0] ? filemap_read_folio (mm/filemap.c:3633)
[ 15.274430][ C0] ? do_user_addr_fault (arch/x86/mm/fault.c:1389)
[ 15.275002][ C0] ? exc_page_fault (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
[ 15.275539][ C0] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
[ 15.276210][ C0] ? handle_exception (arch/x86/entry/entry_32.S:1055)
[ 15.276776][ C0] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241212/202412122317.e295e7c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


