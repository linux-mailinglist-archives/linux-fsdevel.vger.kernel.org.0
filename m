Return-Path: <linux-fsdevel+bounces-29675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12F597C2DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 04:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543FA1F22558
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 02:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B6111A8;
	Thu, 19 Sep 2024 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVlofEfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBA320F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714218; cv=fail; b=exM6SjvihGXN6+nTUtBqW0tslVNJdf9bn0IkMivPbqCkuRXvkQYvw/SRFAfYdQ76IdMUMcP1F06i6bkkU8J2eqNhOkg9nEBJFL5uq5D76HnanbODwTxmECS/czf0+UpHkhDlHsmrpX2PmK8MEJt4EWR5RliA3L/+Ry79iyo+Cv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714218; c=relaxed/simple;
	bh=/3Qrvx2EaQRGwJCnSG5aLQPonwhR3LXgkGxBsm7eotw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FHG++fzqrztaqLC/mIwRWPhT/URkdMaqgPSEEhFxOCxBfeAQdEyCrqoEwidfjCFT+q7pAbcF7OHA44m56OpzWjav/nPWxqfrP2Ob4R43GS/KK3w/MAQr9i+fDskl/E4nzluyoihvdB6FaqB200z8i/MPEnkiLXnj/VzuPDENFHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVlofEfw; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726714216; x=1758250216;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/3Qrvx2EaQRGwJCnSG5aLQPonwhR3LXgkGxBsm7eotw=;
  b=bVlofEfw2Kmq9AbSAUs2UUfKEMINI47iAivcvWk68GL1PengB636UGjk
   8416OJoG6Uqbkh2LCor0xUGqwSAbKcnHXMrUoq1BEI6sfjizzoaavLhoI
   1aeTsgqgSK7txTLRZb9eXQG94XDoMQtA6n4/TWeueIfQmTbojc2V9FO+U
   8ToBDU43Y1elDJbv+IBvSYypzV89cpBMdN5mlp6EdLNd3NNJPmMrCCBGW
   vcxsb/65F8qy0tKsTU8X32JyS6az4E1qwHrkwrtN2BvUDEp9BBd/aSjFP
   xjYY7PfhRZbLOThh7YWGAEzDXLpaE0b3cwrZXCKuu+T3PIk4coIiswUbH
   Q==;
X-CSE-ConnectionGUID: nil4P5gYQUO/dO90G9KjMg==
X-CSE-MsgGUID: CQ91H8tvSqqYrC5AscJUGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25597021"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="25597021"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 19:50:16 -0700
X-CSE-ConnectionGUID: jK77FooLQRKGPBEAVSAc3Q==
X-CSE-MsgGUID: v2mKvmHnSaGcntqcGO1W2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="74318532"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2024 19:50:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 19:50:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 18 Sep 2024 19:50:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Sep 2024 19:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDQBvWkIdM609Bo9w3tIkvOjaAfTr0RFJHuTPgLEv3K+ijXr8uX0oVizYMfkMVjHv2VxRNYCCPZf0vt6lK/5J6AftKUTBTEp0wsWaLJOCyKL275OM4IjoCRXLiYMh8izhIyUiXHWcYp4vs4+pzu6wx00B3OK1pNY5q7tQnbv6NXlP6uMNrhymZQf4x8R60CKSHA6j21lynV5fkoO0yhVbBbRMKrdqQXHC1ty+N7y64ggGYjHPUTXh6Sc+XnHVJgfxj8mjmj+TFObaE1dysiwnI90pdiWCSb/hPwNtbNwpvRjRD4F3p9t3bb13LsCBIpvSjYnYW5ItCT90IzzzyUfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tL5rUasJlu/8Kzkt6M9Tq8tNx1hJxIG4fwOn4d2sSc=;
 b=TB9/4/O0r18M6QTzeeFzwvG4Nt7JULKv34XBr49jqumNx0FcvovVLG9bk1UsWEvsOrsvobnWmlOox9mFp/OeGZvJqovwkebbnWV3eKdK/QAutLPueZIbQR85bwswLEITgLc1Szi5mhCQDiASNoiykSrwgINRdaZgQxfWR0EMEBz00hjE3hK178eh4n7t8d9WcwfpTE1B+6O5LvqU8+9SBaRPUsZITR1miG/GjFCccCWzczyvwqU0YkLg96sRgnx5x5+EURu6XpE4cl6ozD8mepajpqXsLsY+0s81VnE5fav1AL3e9uK7yfiEx3nlNsWAggYhi1LYSDm8QAcSRxfoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4583.namprd11.prod.outlook.com (2603:10b6:208:26a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 02:50:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 02:50:13 +0000
Date: Thu, 19 Sep 2024 10:50:03 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, Jeff Layton
	<jlayton@kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [netfs] a05b682d49:
 BUG:KASAN:slab-use-after-free_in_copy_from_iter
Message-ID: <ZuuRW82LGwgiVz/n@xsang-OptiPlex-9020>
References: <202409131438.3f225fbf-oliver.sang@intel.com>
 <2377098.1726668218@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2377098.1726668218@warthog.procyon.org.uk>
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d3b582-7063-42b6-9167-08dcd855c87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7UwFDPBmgYQRdX7elTY29M5UgWjn4k0K4rhwL6CQ9pbqF2GfN57Dl4XG6+mR?=
 =?us-ascii?Q?sN5/6cSAU57XcbfpxIpyB4wVyxi27o70TDVT1X5UEz3lqNVxBQCr6rtW+lgi?=
 =?us-ascii?Q?PjUmQiK1vLBk0rJytP94S/43ZWKg/Qy1vn7d5bRLl2USFF33eiiz0O6qrn4K?=
 =?us-ascii?Q?ioN/MVyQzFL6jRMxSy+pJcNIn0wdTEA3Wo1uLfrxkK2D3fpaQKS97qgUaDyJ?=
 =?us-ascii?Q?DflD0Ldhr8j0JRm9DGEvURWX8whi/ORSG6bHas365lg2TUKV53Cxj4b9hUIj?=
 =?us-ascii?Q?M8yr/uqsDVkyF4cmPrlYqc9ww1Yc8kxxPGxkNQwtBWnJw+T/xbar10PnlLMv?=
 =?us-ascii?Q?7nHx5P6TS0BU3mXTmj1DU5yuCiJVK/NIVO8Uw/2if2w9NF/NapSG4Keewrm0?=
 =?us-ascii?Q?C9r+KD4U5TL/LWykcKT+z0N38otbEPs8gdBUxQRiJ5Nh4311s0Ut/jGk8PX7?=
 =?us-ascii?Q?dj6Igj9tcJZxkHXKYGXtcKqjKX8cfSTXjAP1p3TCevuSfpDLY6HNoBsyja0K?=
 =?us-ascii?Q?iqbL1FCg25YOetz6HtcU+9KzVuiggfwz8V04F5nACOZN7o7scrFY2t0n03+x?=
 =?us-ascii?Q?Yna7gcWoWppJnPSNzMvAyj2l8hVnm5GN50yiah9nPuXpCVbrf7jMH8SEkkpX?=
 =?us-ascii?Q?iI2MqEPU6gceCM2TJxegN4HqYzgt0PYe97c7EDzaZdl/U6kSTcdEs2WK3A3R?=
 =?us-ascii?Q?2Ruj3xwBDhcu3IFuEwpnA3jEeH3jRrfV9TKQny0Qxyfh1UburJJrNXfAn2tA?=
 =?us-ascii?Q?hhaRHEIC+T9bgFJ6V/AFROg13cvy4asUipxR/VUzg0+cG2JkZ11C+bnk6WLY?=
 =?us-ascii?Q?pXklipnbE1QJbjOJPnEORMOzoDzDAvrxs2G1Cjwqj5A4+i9yPIo6trXX+3Wb?=
 =?us-ascii?Q?MsKGBxcPjBjepYLmm/7dbMvtz5mvL16hRNjLY6qjrtn0FKFkTq0JPQumbTnr?=
 =?us-ascii?Q?4lXj5AEB/WHWTYugdJ4rKXnxv9ti4wRv914u9MmWiHFkFT1MsSXmmfBjFKSZ?=
 =?us-ascii?Q?eiJckSOg0cIitCRD3fsrVhF7/J+kmvn2cEYwm2ehR13G7BFGQ3LgRg/dNc9g?=
 =?us-ascii?Q?DXN0NUKedpYgGfV6+OcK15sXw3DARVJTw6jGZcI8SfPXK9NmNhfrlY8isApx?=
 =?us-ascii?Q?q/VkWaY3AYJYWeOnFwlLj2vKrLIwSaMbAeaDB8fIdHZhMgxFGvc7rlc1yJmx?=
 =?us-ascii?Q?mrhBfAAHu2eQG0QSZ0YDspEC0aN/VK4/U9dp3mhlnZwjQ3RS418DmUerTttO?=
 =?us-ascii?Q?CLX238/co50HJfHHRQHd6TAxC4yhyTM0HLsQAAD7cOdYnXyncwCODMqCboXI?=
 =?us-ascii?Q?4AYooNrEg8wOiKBt7TiCe+lYaRfwor2ZPKE59nLRvdfYZtXz4tj8Qis2j+TX?=
 =?us-ascii?Q?IPsUK8o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vgsv4DH4bNyyLnb8+NaLST43HbUrMnLhTZGMskhAZOB/Cn9zXMYKd2AMXSKc?=
 =?us-ascii?Q?QekG0O/K2a4XKkvCYmLCtUn9jpSy4bXf/PohhljgQrcctgQFA1Sxmlj1sQIq?=
 =?us-ascii?Q?d+A4AcVq26zTfZP3qzeUQKFBP7ZE+zFiR1qY5DgoU4DVDcbL0PXXo4ECKdoV?=
 =?us-ascii?Q?u8nL9ikcyrZwoxAUW/kAcJ60yIP4i55au+oU2Z5eql9GXbFQ3JmA3G8bnLej?=
 =?us-ascii?Q?c6Z0tOGL6Wf9npSKxSSf5TGGNhUdg8060WDykugUduZoPPHcZxbDwjLnvy5g?=
 =?us-ascii?Q?pN1vat4KZMTeEyLTA2jdDYwReeOcDpE3t4yx8HrjFubMvFQS6Cleii76beb+?=
 =?us-ascii?Q?/no94OWqbbHYhQlj8A4GrvjzwgfvGzGCa2wdWXXQI30oO8xDVCzgh1dx88fl?=
 =?us-ascii?Q?8aDM0mv4cES4VJJafLrIgOSxfyhBhtJemq5AmmeQqRui7pvOKwtOjyhRVT0j?=
 =?us-ascii?Q?K6yAuDmfRSXR+dCCtnNRgc3EuYbpn8QJoubqoSUPnFA5w4DsKJXqiRQLh5ug?=
 =?us-ascii?Q?Sby/t+7Kp3ego7CwII6rYmudkOd+ijNP0SzM0qDGi6XncQiTEMKQmWXuIRNe?=
 =?us-ascii?Q?r2YMM3JPynlZn4h6ymG3E2NHpS2f/uS+ErP4koqB8FKXxA2KP8ln58X0jOSr?=
 =?us-ascii?Q?gv9aG22SGcFYBJfg3s/v+13gGDseLwZyvCgHhk2PSI57gTk47Yh18pxA+l+m?=
 =?us-ascii?Q?5XdxOVoVw5n3hbpgH4eLDf6uKfVJc9ynqO/vdkjYqZ1lv1visnZXeJkFvMLi?=
 =?us-ascii?Q?l1cxTb5xxj9FvH/J7McTCOV8yqIAE1Vy6gGjkxkAoF8UbKr9/CcSTvrRI9lS?=
 =?us-ascii?Q?3ZhwCIQ/TwD/+IlmHYhEE0b9AnP8hX0RUwO7eTfGqdpxgIp3S8vf8KXYtrs4?=
 =?us-ascii?Q?baUHjO0hHlgzMcZoMSAIArthgZsnhYL7zQiWl/cy+UmprcpcDPRMevQTYTMU?=
 =?us-ascii?Q?ZTBvw5eSrXZ/vWrT+rYiQKhCPAYzSY90mXi2eFue4bOUen1ZKvp3S75IEF3P?=
 =?us-ascii?Q?tHs4ai09z4Sjzc5fOJw0cvKNoW75mNNPUfJkU+NW6MWNTBh0cnHGwtOGuaVD?=
 =?us-ascii?Q?mvmph/EljmQGdScL45m4nta+NEdcsnov0aOF9TGwOnnyl134FdUKMNmN/x/Q?=
 =?us-ascii?Q?mSuR3Ialk3acperIU1IhE/anobPHBlh72ylMt8ibRQWSj/bwLRiHz+p2Za8V?=
 =?us-ascii?Q?a3GO5G4UtM5F778aKEerzB9hm5rVTZPrmTAcAOfmtmQlnBccAMe+q5K9uQzf?=
 =?us-ascii?Q?Z8QF/lUqbNJ2MO8ewqCRkM9PbzassTC94k5dDY62vu6T3iTgcaL4JCHHE0Zf?=
 =?us-ascii?Q?bBSVgz7NNKT2pBvHP5S3S4aN2XNBMbfevN3nd2JH8ebPTB9sZgiUjZtZwBs6?=
 =?us-ascii?Q?Ylmm64OvplTbJKjw0K8jVmvrOTTzgRRarQHLgklcNGxhjXnspxBCEwGLAPa+?=
 =?us-ascii?Q?1y1dBoZ+INSOhRlF6Qauh6f+ehFQ+n3vGhDyuaJ62Y5uIM2ITcbu2gmWa9L+?=
 =?us-ascii?Q?UAXbYaouO5G143L4YR8by3JiR7loo1klbdSeQzCBGWE9/gih7HwqyhKnaR7E?=
 =?us-ascii?Q?eooRmlszSVU7MoiB+DAeSmnUSo2RqyhTMBVNT601EgsYfI+bIUdfQ4CfTb73?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d3b582-7063-42b6-9167-08dcd855c87e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:50:13.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpceGMsX5JKs1n0jJTrlSN2VON+QlfUks1XtFIuJ/+NJDeF1cLF+eOqwNPaIkWdUiqorbWBSvXdUIXO7ooz4Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4583
X-OriginatorOrg: intel.com

hi, David,

sorry that we only have initial support for fedora
https://github.com/intel/lkp-tests?tab=readme-ov-file#supported-distributions

we will look this issue. however, due to resource constraint, we may not be
able to supply quick support.

btw, for this case, it really need 4 hdd partitions, so need refer to
https://github.com/intel/lkp-tests?tab=readme-ov-file#run-your-own-disk-partitions


On Wed, Sep 18, 2024 at 03:03:38PM +0100, David Howells wrote:
> Hi Oliver,
> 
> The reproducer script doesn't manage to build (I'm using Fedora 39):
> 
> + /usr/lib/rpm/check-rpaths
> *******************************************************************************
> *
> * WARNING: 'check-rpaths' detected a broken RPATH OR RUNPATH and will cause
> *          'rpmbuild' to fail. To ignore these errors, you can set the
> *          '$QA_RPATHS' environment variable which is a bitmask allowing the
> *          values below. The current value of QA_RPATHS is 0x0000.
> *
> *    0x0001 ... standard RPATHs (e.g. /usr/lib); such RPATHs are a minor
> *               issue but are introducing redundant searchpaths without
> *               providing a benefit. They can also cause errors in multilib
> *               environments.
> *    0x0002 ... invalid RPATHs; these are RPATHs which are neither absolute
> *               nor relative filenames and can therefore be a SECURITY risk
> *    0x0004 ... insecure RPATHs; these are relative RPATHs which are a
> *               SECURITY risk
> *    0x0008 ... the special '$ORIGIN' RPATHs are appearing after other
> *               RPATHs; this is just a minor issue but usually unwanted
> *    0x0010 ... the RPATH is empty; there is no reason for such RPATHs
> *               and they cause unneeded work while loading libraries
> *    0x0020 ... an RPATH references '..' of an absolute path; this will break
> *               the functionality when the path before '..' is a symlink
> *          
> *
> * Examples:
> * - to ignore standard and empty RPATHs, execute 'rpmbuild' like
> *   $ QA_RPATHS=$(( 0x0001|0x0010 )) rpmbuild my-package.src.rpm
> * - to check existing files, set $RPM_BUILD_ROOT and execute check-rpaths like
> *   $ RPM_BUILD_ROOT=<top-dir> /usr/lib/rpm/check-rpaths
> *  
> *******************************************************************************
> ERROR   0002: file '/usr/local/sbin/fsck.f2fs' contains an invalid runpath '/usr/local/lib' in [/usr/local/lib]
> ERROR   0002: file '/usr/local/sbin/mkfs.f2fs' contains an invalid runpath '/usr/local/lib' in [/usr/local/lib]
> ERROR   0002: file '/usr/local/lib/libf2fs_format.so.9.0.0' contains an invalid runpath '/usr/local/lib' in [/usr/local/lib]
> error: Bad exit status from /var/tmp/rpm-tmp.ASUBws (%install)
> 
> RPM build warnings:
>     source_date_epoch_from_changelog set but %changelog is missing
> 
> RPM build errors:
>     Bad exit status from /var/tmp/rpm-tmp.ASUBws (%install)
> error: open of /mnt2/lkp-tests/programs/xfstests/pkg/rpm_build/RPMS/xfstests-LKP.rpm failed: No such file or directory
> ==> WARNING: Failed to install built package(s).
> 

