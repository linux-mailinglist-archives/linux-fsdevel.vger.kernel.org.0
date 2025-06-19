Return-Path: <linux-fsdevel+bounces-52154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B060EADFEA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100D13BC833
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 07:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD3254AF4;
	Thu, 19 Jun 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRmODAjk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724FD24A051;
	Thu, 19 Jun 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318063; cv=fail; b=nGUgct+S5DNy1q7RNDCuGArKwF7mn5IRx3zPxmD3oKNfazcWnyA0fL3JlfHGaOzEYjg01XbWWwoR3yEAX/BthFe8DVvmkqHziylqU8xmlxsCviuokZlCBHvNdkGfkJefO9TRc/1/vkisn5ixQtjKfYDXWcbn7tjkyH8EZlPdKCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318063; c=relaxed/simple;
	bh=qtS7xvLlCsWl5vbjcbs43f9vrotpHGOJ9HBNXgHAB98=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QFGn9ATG53JlO4SnpoayYCW643IzI1VkdT301LyFR4ZnmcKNRFcl2kV3bZ/iEMq+0qpzIrPUZLu77WpbJkvjMR1A2TL7+y08v5Qs4VG+p3zi4u9grOIw1L/9adUYyo3sasiCMSkvqm6wVSZf2pZp98rcPobD5laF3mkah9p7lpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRmODAjk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750318062; x=1781854062;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qtS7xvLlCsWl5vbjcbs43f9vrotpHGOJ9HBNXgHAB98=;
  b=fRmODAjk0kCbnHmr/O+Sd3QjT9InixV7o75rDOT8yUz9RvBB9OSlHevD
   Fw4MqfVLdagROq8ET2DBR8G0Z1XrVdur4v23iu4RbjcKLtdbfsEWYr3Aa
   yA2Jt+P4iuOIsWF8PDtnlKc2UMfuzFAJyW36e+vGNCPexE2cjWyAEDFyu
   2lNobSntyuOhageCmPrN4ksIVsb2vlztS/yby5dw6SwT345DISjZbI2Vo
   jieu1K9m+jqMcxiucYucM478XZS1/h5EfY1/ZTrEJDaJxHfULvmxZA9Ny
   B+esM39Faw+y96lzWkvDi6ObpFrIqbWkwcpDjsATVnJ4g66tEUgdnU9dx
   g==;
X-CSE-ConnectionGUID: aZ6mfptwRTSWrkujRSH+SA==
X-CSE-MsgGUID: D6zhr05SSqO/Yai+5AiRaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="75095482"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="75095482"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 00:27:41 -0700
X-CSE-ConnectionGUID: l45i2Q9DQPOCpRBLl0w/1Q==
X-CSE-MsgGUID: SPPTJcxcQsSxWGDSsoSTXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="154498364"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 00:27:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 00:27:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 00:27:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 00:27:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV1hHhZMy+oBTFe11qEh3jagwokSwKtYgi1ar2r2DIgo/dG6x111vybYEXjYbuK02ioJHSSaBzEQoHNNH2P8Iyws9Boq0pkCtyV54Ose3UOWhNtMahAlXtmCtOhQ6GI0Qle4ahUHcv1n8f1gVCx2jfQis1wQnUoTUx1ymEY4Z8Dx+emOhW8qsI8WsY+NxoO+eEYq87ueDSRVxa1S0xjJGWQEC4rM/GIOnyPOh1ZcIfapCa01bLA2KAl48kS+vfM696YmFM5avnQsYJeXRyuzh5ReogOwZzAV9JrWUBv9BbbEPjDPEV1dvRwohu0mOEcXovWVY76zSi3gaRszaiz6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+IkSH7BxSvj4txYQRXwHk+Q6cwhnCNowOX28WEO2pg=;
 b=lkWnrfD+GWl2AEd07aV7v/FiejScYmU5YPr1IC2KiUUQ3P5+bfWS/PIfneNN//TrBhXg/jCi/VGHXkgk8nANqYkxmShza3+iZTcjdjjy/4KV77BwL66XLMLEqpqPVk5Fhe1CmkbltPAfuF0gP6CRZgXXawlctT4JZKBrBe2gHEgdeh7uYMYBlIbrb6JdqDoB5KU3bKEY8SduZa5FevhZfK1fLB6ph+g/P5qxL0++XUXIlchYB0V28tWqWQp9/u9QRYXKyKuPnKAbm0JH9mz7d3yiIf9degRJwTTxD94IK9q7e9tbrZH5jQAwBHu7PsMCGzQbeqLR/BGIHGVDU9uEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 07:27:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Thu, 19 Jun 2025
 07:27:37 +0000
Date: Thu, 19 Jun 2025 15:27:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [brauner-vfs:work.pidfs.xattr] [pidfs]  e3bfecb731:
 WARNING:possible_irq_lock_inversion_dependency_detected
Message-ID: <202506191555.448b188b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 45658820-78e3-48bc-1a3d-08ddaf02c3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NjJ9uuxax/3qm9rEW28KRpEUhTzKdmpUCV0dhryyvQJfos57xmcNqcgbtACV?=
 =?us-ascii?Q?ykMyKUytVorOF88cVagcU80Q9j+fyf34t5TLtF9WomgJNQhRh5FzQ5UKuUK+?=
 =?us-ascii?Q?KW+l2J6JIuH/MM/ClFa9cxh9JbokGP9CCQVYSNQgIQkvevqKGxabHu9Na2Pk?=
 =?us-ascii?Q?mqjy5M7tmTeGGd9LThPJMeoGLoQnFGMGDYnbtN40Jmu9J9ev6Xefyv4/B/8N?=
 =?us-ascii?Q?zekb5VqwxUiDjDTNpVjeryLOgGR7O0xsDHd+I5OzEklYp5hXKHGF/sWeXkop?=
 =?us-ascii?Q?4HKmxPyufX2mx4SGxpMm/sO86rb3wQWciwIkzjBtrLMJ9mnh2uedU0qhONxy?=
 =?us-ascii?Q?vCU0vN575MllFnAn6gmKaQddbvgpIZLycCRvPw/mr4nKSQOuCgk3YuBf7he8?=
 =?us-ascii?Q?3nesbMyZnQwdqR0ed62S0e4G8h5GdBgEC/VLzLhqxl062XDhADqqk3hvCbV4?=
 =?us-ascii?Q?QhqDcIlBDgp/J31Mra32A17hZjbUGljZDbviKLtWvkDBruj6eSyUDjnvPmog?=
 =?us-ascii?Q?R+mAaPmAvI9KHpOkjM9gWwCiXihK2JNlcUNB3Z5eTjTE2oJfF6SVG2wuQlLI?=
 =?us-ascii?Q?oEEatSQxrOVMDZMGwMuvOl7K9yUU5JU2KAl1uPg+w2vQJPm3tbRSmPfoSYjR?=
 =?us-ascii?Q?3Lzez7n4aXV2QwYaNO3mBwtwpUnfEvIBkeJnZqjnIaR9IPPShgYjwLArgwyQ?=
 =?us-ascii?Q?Ms/8nzA8nVIBtJE7butEUla0VHAFXkXIEOaGsVAh52NmTOLpvFs1GCcICON6?=
 =?us-ascii?Q?zC8aFhS7skYenHooJ+wCkMuiuspXsI7kcC3wS9DI4qXXK+3zXR/s6hS0ppDV?=
 =?us-ascii?Q?fuM5+dWA1YZO5j/F/4GeLSBA8vfJW1FfskPXAE4se2VKocwvVMc+Q87tlWRW?=
 =?us-ascii?Q?/EXKiqMBe/Ls/FeI0IGKVeeYWmICcRZmVCtxqVJBJEBZAlzoEc3Je7fADLwz?=
 =?us-ascii?Q?ffqt0phhv+IgId9J1JGejozyWsfse6j4aENE/7wbrNN6GihXIGbkZrHHYWLp?=
 =?us-ascii?Q?S9gIHC7CymBfQhBkdfyfRndBkqOMxQQDvXsvQLl/3t/8IXiySo+R2O3EEp70?=
 =?us-ascii?Q?eBQTeMEQJOdtwlnJBgZ2U6RjI8bXXb453hxAFkGlFLZo//HyZcV6cvHEQgxD?=
 =?us-ascii?Q?87bDGj84CEyEN6BeZswe5V4k8Dw4p4J2BhIlwMj/Jb58Q8Sb3sBcVvIIeTj0?=
 =?us-ascii?Q?IRmzlJZktlalQ2GcIutcugJgHjfFFUg3JdnSboLiYerOWixenraqu2Im1E9T?=
 =?us-ascii?Q?amFOq9lMQHWfvHIIqWlbrxOhEddKvxq5QFLwvfKTij/IAUYUiuqs+CeAkTt/?=
 =?us-ascii?Q?wnbwnkAZGpUziGi2KbgTFPxdGQXMXWzDADo5UEa5F4vX+jtAXG4/dJ6J4rhV?=
 =?us-ascii?Q?Bxsiuap7l3P1aTyg4mVkR0Ft/zV/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDhHTU7WJt450tGK3Gh93+Ivvx8N7wRguX6OwirXBJCbTlqSatgAteiYCkNh?=
 =?us-ascii?Q?OM6eeAaaIxt1yWzppWtcmYvmpkRqEViF3B6Mz02qWM3BvdX+B5jO/0aRXJK+?=
 =?us-ascii?Q?5EmXJFNHEMwmSFAYEG3GSFPczWvfGNt40nb7NGmQFw+VNAtqCDthicieo9p2?=
 =?us-ascii?Q?AwCbPI+nF+o1M6Vq1fIhop2diJROQdYx0rOtZyj5x4PtscF8pGSU3ALb2Ic8?=
 =?us-ascii?Q?E6JwLUVmYSlG7pVLwOINNImRza9yd+ZlBxx+kgjJuD2AlVlR1B1HuzfzJADp?=
 =?us-ascii?Q?PW710bapL2VN5sXpxRe00Hqf7l+gFU/YWTZEGRMyYEPoJIKWIkXTB7UPL6WN?=
 =?us-ascii?Q?TQ/J3+gRaRPG7kZI/RNVO7+YHbeQk0WPlxyQuajwln5LGJ7RPOFsZewdj4fJ?=
 =?us-ascii?Q?uioURjqbVyarBfLe0H2tDCCBr0kqNJfoMVaUFDKok3LDV5l8PjG/VSH6sq+o?=
 =?us-ascii?Q?ntzONW9s/AvBn21FLwy5u6hjEQToQZmlplPrJZth0dAejr8/UdNfwjNY2UlD?=
 =?us-ascii?Q?2emnO42lRCQ15zHaG3HJtrcv4vNUh5XM+yOL4ET3Q/GJ6IK4IM+uJLkHmxlo?=
 =?us-ascii?Q?4oNRN10XSNx//bvDPpw0ChD/7COFJzMaaH+T7qpCO5P7T6JXMuutk6cGWEoA?=
 =?us-ascii?Q?x3CNIao4UpN8nPeoZJIaQvaUkPU4N3xp3Y01W1BIdQvydR7P/F8lnle38wFX?=
 =?us-ascii?Q?949ch4K1OGiAJqN4lAgMiJdw/RccClCEzhbt3Y9YjH7de20ioCnFjs4lpeux?=
 =?us-ascii?Q?kR9PKrz7YYSQe39kMlSlBBDPrCeoBoujqQWjUCUWDpnPS6LJpG7L3PHkqN9W?=
 =?us-ascii?Q?+hM5CPL9X2FLGjOisZdHCw2ZxlmTz/cdqEIldLzEYi6jW9eP4MSWvRJ5TqG7?=
 =?us-ascii?Q?4nrY4h2A7EZEXppIb20TqoPNFk/csJ1uN4LAJ33oQgYlk2UR4UmYEedpe4AA?=
 =?us-ascii?Q?p5sVY8kxuGw+JabBAjyDFEac0z2ry8GeY1FhOUMrg7daPW0eJznYQS22xIfQ?=
 =?us-ascii?Q?nqq3IB/OjSqv2OijCZUd31azHeTcLyHLGRPFE9mWN5I6u7J5vgtLc3bOmSm4?=
 =?us-ascii?Q?wCZrMLkzqjLs0LLqkAI0TJRpdsO+9Bu1A7eRBV9BprXM8ySIZz1apjV8JU3m?=
 =?us-ascii?Q?dhDA+PKNsoL14iPcXFE5Di/w++YDBdCFzcI6GS6L8dvlZQoPQcq3dS1yCjpu?=
 =?us-ascii?Q?7NJ+QTkUAWyuQ32oJl4oqn7xvL7xNV1wbmb9LMpXNs/7k6V8PqNOtcaF/sfC?=
 =?us-ascii?Q?IENmAT8hOphBU6oTJkaBqA4869PB+HNnFK+bF5uRdRvQ/rW4Prg8VttzjS7j?=
 =?us-ascii?Q?HeIZtBaOYj4ddz3QeI3YULbi+0ipPM38lAvLJM/qD9eqF07aQDAhvsj4W6KJ?=
 =?us-ascii?Q?5w3b0/2IJbr1lCj8QO/rLGylFxV76l2Ly3E1XFnbBfcL12KGIbwIl68xfexq?=
 =?us-ascii?Q?Ea3rOO0VFJEYywFzFNhw/IZa78EOfWt5Sw9bYtFK8f3XIZIk0pd2sCnn5T/U?=
 =?us-ascii?Q?HSou35fmqAd9TwyeX6ojPmJiZ+Qbsne4lgnnwN3TYeZ/et1eV1CToej0aYg+?=
 =?us-ascii?Q?J4lZdAmJrWbEOhJ+MKR7zUkSTbqBrCLWrGS0wJhhg/hwOlchF+yxN7lTlrzw?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45658820-78e3-48bc-1a3d-08ddaf02c3d7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:27:37.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7DLcMXxz0+DuB6XtsJnYR0rZPv+uZBWZ6vo9+5Hpb9YA8np8grg79vlz2PSyo0XJZul8GzUhsJDKj7UdmvtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_irq_lock_inversion_dependency_detected" on:

commit: e3bfecb7310ade68457392f0e7d4c4ec22d0a401 ("pidfs: keep pidfs dentry stashed once created")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.pidfs.xattr

in testcase: boot

config: x86_64-randconfig-078-20250618
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------+-----------+------------+
|                                                         | v6.16-rc1 | e3bfecb731 |
+---------------------------------------------------------+-----------+------------+
| WARNING:possible_irq_lock_inversion_dependency_detected | 0         | 12         |
+---------------------------------------------------------+-----------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506191555.448b188b-lkp@intel.com


[   48.631814][    C0] WARNING: possible irq lock inversion dependency detected
[   48.632323][    C0] 6.16.0-rc1-00001-ge3bfecb7310a #1 Tainted: G                T
[   48.632866][    C0] --------------------------------------------------------
[   48.633351][    C0] sed/223 just changed the state of lock:
[ 48.633739][ C0] ffff8881123ae5d8 (&sighand->siglock){-...}-{3:3}, at: __lock_task_sighand (kernel/signal.c:1380) 
[   48.634422][    C0] but this lock took another, HARDIRQ-unsafe lock in the past:
[   48.634933][    C0]  (&lockref->lock){+.+.}-{3:3}
[   48.634939][    C0]
[   48.634939][    C0] and interrupts could create inverse lock ordering between them.
[   48.634939][    C0]
[   48.636229][    C0]
[   48.636229][    C0] other info that might help us debug this:
[   48.636782][    C0] Chain exists of:
[   48.636782][    C0]   &sighand->siglock --> &(&sig->stats_lock)->lock --> &lockref->lock
[   48.636782][    C0]
[   48.637722][    C0]  Possible interrupt unsafe locking scenario:
[   48.637722][    C0]
[   48.638283][    C0]        CPU0                    CPU1
[   48.638649][    C0]        ----                    ----
[   48.639015][    C0]   lock(&lockref->lock);
[   48.639315][    C0]                                local_irq_disable();
[   48.639774][    C0]                                lock(&sighand->siglock);
[   48.640257][    C0]                                lock(&(&sig->stats_lock)->lock);
[   48.640796][    C0]   <Interrupt>
[   48.641036][    C0]     lock(&sighand->siglock);
[   48.641365][    C0]
[   48.641365][    C0]  *** DEADLOCK ***
[   48.641365][    C0]
[   48.641932][    C0] 2 locks held by sed/223:
[ 48.642237][ C0] #0: ffffffff87307760 (rcu_read_lock){....}-{1:3}, at: kill_pid_info_type (kernel/signal.c:1451) 
[ 48.642895][ C0] #1: ffffffff87307760 (rcu_read_lock){....}-{1:3}, at: __lock_task_sighand (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 kernel/signal.c:1363) 
[   48.643557][    C0]
[   48.643557][    C0] the shortest dependencies between 2nd lock and 1st lock:
[   48.644192][    C0]     -> (&lockref->lock){+.+.}-{3:3} {
[   48.644575][    C0]        HARDIRQ-ON-W at:
[ 48.644885][ C0] __lock_acquire (kernel/locking/lockdep.c:5194) 
[ 48.645364][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873 kernel/locking/lockdep.c:5828) 
[ 48.645824][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 48.646290][ C0] __d_instantiate (fs/dcache.c:1915 (discriminator 3)) 
[ 48.646767][ C0] d_instantiate (include/linux/spinlock.h:391 fs/dcache.c:1948) 
[ 48.647225][ C0] d_make_root (fs/dcache.c:1992) 
[ 48.647672][ C0] shmem_fill_super (mm/shmem.c:5106) 
[ 48.648170][ C0] get_tree_nodev (fs/super.c:1324 fs/super.c:1342) 
[ 48.648648][ C0] vfs_get_tree (fs/super.c:1803) 
[ 48.649107][ C0] vfs_kern_mount (fs/namespace.c:6278) 
[ 48.649620][ C0] kern_mount (fs/namespace.c:6273) 
[ 48.650062][ C0] shmem_init (mm/shmem.c:5413) 
[ 48.650512][ C0] mnt_init (fs/namespace.c:6257) 
[ 48.650954][ C0] vfs_caches_init (fs/dcache.c:3243) 
[ 48.651430][ C0] start_kernel (init/main.c:1084) 
[ 48.651894][ C0] x86_64_start_reservations (arch/x86/kernel/head64.c:295) 
[ 48.652443][ C0] x86_64_start_kernel (arch/x86/kernel/head64.c:231 (discriminator 17)) 
[ 48.652952][ C0] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[   48.653433][    C0]        SOFTIRQ-ON-W at:
[ 48.653737][ C0] __lock_acquire (kernel/locking/lockdep.c:5194) 
[ 48.654213][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873 kernel/locking/lockdep.c:5828) 
[ 48.654670][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 48.655132][ C0] __d_instantiate (fs/dcache.c:1915 (discriminator 3)) 
[ 48.655605][ C0] d_instantiate (include/linux/spinlock.h:391 fs/dcache.c:1948) 
[ 48.656062][ C0] d_make_root (fs/dcache.c:1992) 
[ 48.656507][ C0] shmem_fill_super (mm/shmem.c:5106) 
[ 48.657010][ C0] get_tree_nodev (fs/super.c:1324 fs/super.c:1342) 
[ 48.657480][ C0] vfs_get_tree (fs/super.c:1803) 
[ 48.657939][ C0] vfs_kern_mount (fs/namespace.c:6278) 
[ 48.658452][ C0] kern_mount (fs/namespace.c:6273) 
[ 48.658896][ C0] shmem_init (mm/shmem.c:5413) 
[ 48.659345][ C0] mnt_init (fs/namespace.c:6257) 
[ 48.659788][ C0] vfs_caches_init (fs/dcache.c:3243) 
[ 48.660264][ C0] start_kernel (init/main.c:1084) 
[ 48.660738][ C0] x86_64_start_reservations (arch/x86/kernel/head64.c:295) 
[ 48.661266][ C0] x86_64_start_kernel (arch/x86/kernel/head64.c:231 (discriminator 17)) 
[ 48.661766][ C0] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[   48.662264][    C0]        INITIAL USE at:
[ 48.662555][ C0] __lock_acquire (kernel/locking/lockdep.c:5194) 
[ 48.663026][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873 kernel/locking/lockdep.c:5828) 
[ 48.663479][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 48.663937][ C0] __d_instantiate (fs/dcache.c:1915 (discriminator 3)) 
[ 48.664406][ C0] d_instantiate (include/linux/spinlock.h:391 fs/dcache.c:1948) 
[ 48.664866][ C0] d_make_root (fs/dcache.c:1992) 
[ 48.665307][ C0] shmem_fill_super (mm/shmem.c:5106) 
[ 48.665796][ C0] get_tree_nodev (fs/super.c:1324 fs/super.c:1342) 
[ 48.666259][ C0] vfs_get_tree (fs/super.c:1803) 
[ 48.666711][ C0] vfs_kern_mount (fs/namespace.c:6278) 
[ 48.667216][ C0] kern_mount (fs/namespace.c:6273) 
[ 48.667651][ C0] shmem_init (mm/shmem.c:5413) 
[ 48.668092][ C0] mnt_init (fs/namespace.c:6257) 
[ 48.668527][ C0] vfs_caches_init (fs/dcache.c:3243) 
[ 48.669004][ C0] start_kernel (init/main.c:1084) 
[ 48.669461][ C0] x86_64_start_reservations (arch/x86/kernel/head64.c:295) 
[ 48.669982][ C0] x86_64_start_kernel (arch/x86/kernel/head64.c:231 (discriminator 17)) 
[ 48.670476][ C0] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[   48.670950][    C0]      }
[ 48.671147][ C0] ... key at: __key.4+0x0/0x40 
[   48.671654][    C0]      ... acquired at:
[ 48.671958][ C0] __lock_acquire (kernel/locking/lockdep.c:5240) 
[ 48.672295][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873 kernel/locking/lockdep.c:5828) 
[ 48.672616][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 48.672945][ C0] lockref_get (lib/lockref.c:51) 
[ 48.673244][ C0] pidfs_stash_dentry (fs/pidfs.c:973) 
[ 48.673603][ C0] path_from_stashed (fs/libfs.c:2243) 
[ 48.673956][ C0] pidfs_register_pid (fs/pidfs.c:1067) 
[ 48.674308][ C0] unix_socketpair (net/unix/af_unix.c:754 net/unix/af_unix.c:1782) 
[ 48.674650][ C0] __sys_socketpair (net/socket.c:1764) 
[ 48.674998][ C0] __do_compat_sys_socketcall (net/compat.c:470) 
[ 48.675405][ C0] __do_fast_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:306) 
[ 48.675769][ C0] do_fast_syscall_32 (arch/x86/entry/syscall_32.c:331) 
[ 48.676116][ C0] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127) 
[   48.676561][    C0]
[   48.676737][    C0]    -> (&pid->wait_pidfd){....}-{3:3} {
[   48.677128][    C0]       INITIAL USE at:
[ 48.677415][ C0] __lock_acquire (kernel/locking/lockdep.c:5194) 
[ 48.677877][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873 kernel/locking/lockdep.c:5828) 
[ 48.678321][ C0] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 48.678820][ C0] __wake_up (kernel/sched/wait.c:106 kernel/sched/wait.c:127) 
[ 48.679243][ C0] do_notify_parent (kernel/signal.c:2187 (discriminator 11)) 
[ 48.679715][ C0] exit_notify (kernel/exit.c:762) 
[ 48.680160][ C0] do_exit (kernel/exit.c:979) 
[ 48.680582][ C0] kthread_exit (kernel/kthread.c:326) 
[ 48.681042][ C0] kthread (arch/x86/include/asm/current.h:25 include/linux/cgroup.h:649 kernel/kthread.c:462) 
[ 48.681464][ C0] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 48.681920][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[   48.682410][    C0]     }
[ 48.682603][ C0] ... key at: __key.4+0x0/0x40 
[   48.683107][    C0]     ... acquired at:
[ 48.683386][ C0] __lock_acquire (kernel/locking/lockdep.c:5240) 
[ 48.683720][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873 kernel/locking/lockdep.c:5828) 
[ 48.684037][ C0] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 48.684404][ C0] __wake_up (kernel/sched/wait.c:106 kernel/sched/wait.c:127) 
[ 48.684704][ C0] __exit_signal (kernel/exit.c:143 kernel/exit.c:211) 
[ 48.685144][ C0] release_task (kernel/exit.c:274 (discriminator 11)) 
[ 48.685647][ C0] exit_notify (kernel/exit.c:780) 
[ 48.686160][ C0] do_exit (kernel/exit.c:979) 
[ 48.686618][ C0] kthread_exit (kernel/kthread.c:326) 
[ 48.687126][ C0] kthread (arch/x86/include/asm/current.h:25 include/linux/cgroup.h:649 kernel/kthread.c:462) 
[ 48.687588][ C0] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 48.688085][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[   48.688603][    C0]
[   48.688848][    C0]   -> (&____s->seqcount#4){....}-{0:0} {
[   48.689419][    C0]      INITIAL USE at:
[ 48.689832][ C0] __lock_acquire (kernel/locking/lockdep.c:5194) 
[ 48.690480][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873 kernel/locking/lockdep.c:5828) 
[ 48.691106][ C0] __exit_signal (include/linux/seqlock.h:431 include/linux/seqlock.h:478 include/linux/seqlock.h:503 include/linux/seqlock.h:877 kernel/exit.c:198) 
[ 48.691740][ C0] release_task (kernel/exit.c:274 (discriminator 11)) 
[ 48.692403][ C0] exit_notify (kernel/exit.c:780) 
[ 48.693050][ C0] do_exit (kernel/exit.c:979) 
[ 48.693684][ C0] kthread_exit (kernel/kthread.c:326) 
[ 48.694360][ C0] kthread (arch/x86/include/asm/current.h:25 include/linux/cgroup.h:649 kernel/kthread.c:462) 
[ 48.694973][ C0] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 48.695646][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[   48.696356][    C0]      INITIAL READ USE at:
[ 48.696860][ C0] __lock_acquire (kernel/locking/lockdep.c:5194) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250619/202506191555.448b188b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


