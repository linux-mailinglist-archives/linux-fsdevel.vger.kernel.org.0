Return-Path: <linux-fsdevel+bounces-29616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB497B6CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 04:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E1CB24AE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89A82485;
	Wed, 18 Sep 2024 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KR2vky0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775713D8E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726626275; cv=fail; b=BXVpCrSQREmqcXszoxfCfFeeNAH2TJjyL7Ga6SrhSTgS6Ik6FeYxLnjTA0RS+5BlZr1fjXJ/sIycCJdlCQlgbkiYoCcC1sYQaDOCByOhm2g3uL20PyQCz4tNs6DKVUBtMOJB9Sbs7nnFyXzm+HPl9fsz3VUOnN1p0QaVaVnORqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726626275; c=relaxed/simple;
	bh=c6MHac7YbQckjtIq6LQcbFHw3K4xXg7ONsS86AS4dGU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H1R9zlJNxxOz3YL+BMYTvsMXfTbIZfnnZA4w+Zyy0/0qQUAfMXLKruNW3AH1basmGawwCG55twZG4DiAk4CLH1NCZzlyK9GNDqv4XbVhKWpCSary96w5BEZqnfE4BGd7jDj0QKDna7jBeMYlAJhu25YDY+5qUKFbkjeBlmyn0nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KR2vky0z; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726626273; x=1758162273;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c6MHac7YbQckjtIq6LQcbFHw3K4xXg7ONsS86AS4dGU=;
  b=KR2vky0z8E5s6/MYIxIUoMztvX7j39nHSnNwBOJSwRY+RDpDAQopcJlH
   CUv73HTQeV719RT1ILaXVgAmguHbur1kkKBBkHAQO8NwnO/GayFN4ePHz
   17f8OxR5x5Folh45X3LY/Ut6VLo3RxObahU50xtH0st0TPT/GTbjPn/ze
   2A2WQrSbZK6c7bCXZEMZKhPn4el6xz382nHpRTLrzL0wJg07fE2R1/MwA
   3HHRqhpsdiDopEcka1VHwqZrlAN0ALX0EbG3/Q0gdhYDS0qaDHf9KnH9I
   mhdZjZLbpZSWbNOp4vkVuOznXsMg2/uvYQQbSgex06W2QAN21TcTq2CAi
   Q==;
X-CSE-ConnectionGUID: J5xBVjzESZ6dGsLcPIM3Ow==
X-CSE-MsgGUID: CwKKXpENQ3ijHQYkmY1P8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="43034324"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="43034324"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 19:24:32 -0700
X-CSE-ConnectionGUID: KuqEL8hKSnyBz1/bN94oJg==
X-CSE-MsgGUID: EesfQPfLTtWGPEeIJORVKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="73492058"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2024 19:24:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 19:24:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 17 Sep 2024 19:24:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Sep 2024 19:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyujeyHefFr0cHqvTCntLmk+fku73S2iRiI/8ryFv3Bdwll3Jjj99T7efn4Bqnwu/F77EHmwMyWP5u6ovtX553LMt59CXKbcVVOwjbRxXHcGcC3tv1x2SYKwEtVwd0HhZkiIrvebR97efkpxfYe40pjEllFhgDXxU3bHbSwLzAvAxAILLRlPKRuIceyJkwRTrWk6RC/fQ7+7HSZxifp0dsMixGQjxzUk8xgAroJ/ZUZLpp75Aw+P/g9KDagpe9O7zx7koFDNMcf38jMtNNjs4zuRO4hSUcAuNPh9Un/JI7Nls2E8k4rxjz1UgHBtUwb1hbGskeEtUzqb9+Vmc7NQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZzISte3zsherJXmi4/SDNQ7766zWdca3+5L6iVPsg8=;
 b=lrIRPfWGwlqpJqH8zYASXGanyLB3TUNMOIgGlKgINzH1pIZzE49NAIOC8H2hnrlH/usz0BwvAg/MD0GYzRBIo9tx6psjdgRv2FgZp+9pgQUGsK3rO7PNwI5NT40qAXqlKV4KpxmSMEbIcuHTacMyJF82sTmgMLXBOaZbboyu4BiKyR3weUGsuc5MCz+G6BiTFeEAGV1p26wgiPUFLWtnc2Dn7o/CjREGbBDSBo6yikIfthfV/BFyqmLwRvTYAZqanIGKKnIrrwG/Cz5vBAWOJicmNomOQ8AMY37haMTs/06OQgvYxWDlVUPSFKPq5O0Y4nLppHk70WC3BNCGNv+jdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7465.namprd11.prod.outlook.com (2603:10b6:806:34e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 02:24:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 02:24:27 +0000
Date: Wed, 18 Sep 2024 10:24:17 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: David Howells <dhowells@redhat.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>, "Jeff
 Layton" <jlayton@kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [netfs] a05b682d49:
 BUG:KASAN:slab-use-after-free_in_copy_from_iter
Message-ID: <Zuo50UCuM1F7EVLk@xsang-OptiPlex-9020>
References: <202409131438.3f225fbf-oliver.sang@intel.com>
 <1263138.1726214359@warthog.procyon.org.uk>
 <20240913-felsen-nervig-7ea082a2702c@brauner>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240913-felsen-nervig-7ea082a2702c@brauner>
X-ClientProxiedBy: SG2PR02CA0086.apcprd02.prod.outlook.com
 (2603:1096:4:90::26) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 918c5999-8667-410b-cc00-08dcd78904ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A45CUjix23qnVcQSyp2hqm38NzTy/v3ErulrsF/+YwcP9jboWwd2bbj4ZbmO?=
 =?us-ascii?Q?+g9RH92IatYDQ1EVZB+60Gmix7NE6XBRiX6ycZ8xIC4CHTXRHs09IGHoeSTG?=
 =?us-ascii?Q?YPq9YG4vS3HcnXVx5EPjjLA564HjxORu4HyYTpvutqTexGzRgBz9lw5PU5dC?=
 =?us-ascii?Q?1Hve1+PivDFGh14qxe5fEVkRPFboL8sK69e5sHWkUWZFZoQGtDjyNIFiAI0U?=
 =?us-ascii?Q?9287tr5S/YkJv1ro+Litps2GUlVNxrZ1Y8CojfS4r0DWzvvGpMhyBHP4ttvq?=
 =?us-ascii?Q?rQrAKDeRArtb0Q+Kf7BIwEP7j+ZcMHCHQOvYrWuFRJN7tRufA6ArRgKjViHZ?=
 =?us-ascii?Q?WgeWBtoi5lENcKWvJRxM16yDISHYVi1cL7YNo3ItqZecEG2Sbvwra/deb6cU?=
 =?us-ascii?Q?4QsgGA+oL0e+vCaivMSGMAS02AZq7bnhDQ68wNS4H6PXHE45qezs+uzAWpHT?=
 =?us-ascii?Q?C+X4ufuwcRyCNNl0JRlPbhSVUrVwrlA3nrAa4BTeBac4RjHC/6O2XqZFXVnN?=
 =?us-ascii?Q?6DR8rTAa+SmvI7wh0V0k3tFOgsykMFq2H/Igxi4XsOTB7LGFm/3VsKdNaGi4?=
 =?us-ascii?Q?2uucIuVU88/Jgn5b/z10L1+AgHeZDgSIiNliKynn9ZGjYgbGTfZL/oR7gSfU?=
 =?us-ascii?Q?J1fD/lLuBrev6zhoAhU2XGke+g3Yx2YA/y8NJK6v78NqKhrlkbMPdUXVDuAi?=
 =?us-ascii?Q?3jniws4uvM0JMqc4MARXP2EqPx2vIK+6NYt1gQnaVKRfX/7cK50LDmEm+27y?=
 =?us-ascii?Q?UgZG4E3qIIyf73R3vnAeSphVUS2nqiF5zfu7y6G9rR6twmx1WwVbNCJjiq6p?=
 =?us-ascii?Q?0YlCGkhDhIGuFWXpFBPWxi3Q2wwNfCopDdJbfLykwScm5nruJQjvcQQT4/QE?=
 =?us-ascii?Q?a14gnKwwUWuXp1hjP6PczDf+zgrXA5SlJNChxMlYOYNw/8uCtVhKw6qgU5D9?=
 =?us-ascii?Q?V1fMLvGyJ2IIC6bLpCJY4+10umwkl+4QZJOGNYKe5n3abeV6k8r93l/LIl9W?=
 =?us-ascii?Q?YpoHjDF3BCxsnxcouCO9HLU2+Jrsi+bN+PJHD6Xy+FFpMqD38u7oPVvVqoyD?=
 =?us-ascii?Q?tqFWSeVhqmB4vOyOq85dYaT9L2KqIC09VDx8aMaqV7xuOWnPshAIX150SoFk?=
 =?us-ascii?Q?m+Rgq9T3WgS112Xi1l16O2IYvM1KbozhXOaWJcKy7GTJPrqIweBX7ujVrA63?=
 =?us-ascii?Q?pxzJIqhEZ/+Oprr0T400KBKX8ZqLCHW392iQrqfhHH4qNpWBMZVTMAM3XVth?=
 =?us-ascii?Q?PGp2Ajj7EehBkzaE1N4gIbyX9DW6RFRs1JD2Wb5cT1vfhrOZzQveRYLrBfvA?=
 =?us-ascii?Q?sQzZy48l2KfD5qIKkKmjaqmN6C+7NHgnjzRtAssia/QAPuEq/PKGZTqw/09a?=
 =?us-ascii?Q?stMbpkg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERRqv26v4aHkq81rYpiusxstXBGkqOtjEwhw9fEcwpQi3Bo5tDxAq4jTKTeW?=
 =?us-ascii?Q?cP9DWcxQ/7PWNL9zkE3FyrKICD8IxOGbTP10+GjnSUIh4qEQEHFLDnEBnkSd?=
 =?us-ascii?Q?KA1phXaXh7Ps7Ul9y/bwoffgwj90rlKK75OkE8ArUiUmYnV5wloiw8/SEgGj?=
 =?us-ascii?Q?nP6n02oI8dwYirRMY0J7/mbWiibC+gYVXyazzMrjENqtyn6eEpFw5Clc6ZlE?=
 =?us-ascii?Q?PkPjE8QQThrvpk+3SPnss0LKu6aPOuk/bD7KAqLWPWuuz/rXStT3fwRjnEhI?=
 =?us-ascii?Q?Zx9S94MnFsDEJiVMRsSgbSH/QADu25xTQqFansCJBm+1Va0Y70uIaCe06V2I?=
 =?us-ascii?Q?e4e06Qxqui/BfLrsHc/GOoiAasSHbzgKFm8gwvWZZJ7yLAJn2EyrPmxyLHDv?=
 =?us-ascii?Q?5ah82l4qZk/Gby13Y3h+1x0ReQF71FwzYyFnh4QNuw43aNdtHVFu1WVx5b3Y?=
 =?us-ascii?Q?HEJlfQXNfudxhXxhX/iLEVnnY5Wl5uHUIsZroNHKcsG0gjV2TaeGvt5MCTNX?=
 =?us-ascii?Q?iRC7OrlC39rralQZeAplDEvHgwDuw4hMSSwet2aLm0ixnxoobZ9tLUwD/5Ep?=
 =?us-ascii?Q?h5hK9qQo/ss4gvGaU9jIPnxvSeqF+BWLUv19CqAK6GfXzheFBhG/1dkquR5I?=
 =?us-ascii?Q?NGVfs6v3pTDVAfeHtD1HH2Vkdf4PU/HyycbX1tJxB0tL3LgZ3PNOBUgeCIRx?=
 =?us-ascii?Q?uxnT9lus9FEGC2Z8Qo3HfzmauEq37EdnooCQpNKLNZ8e7IgZUUqI9YaXqf0p?=
 =?us-ascii?Q?dyQ3iIQVjtTsUY6au/9QjzTqCtd125zTx7yV8mH4Z32SLQ7KivL0ysQXP9jh?=
 =?us-ascii?Q?lqIqRU2ZWdq/Dn57FYULrdO0Q6qsQqKSrMhH/0yDbi8iHLEYQuSSI2UKeOja?=
 =?us-ascii?Q?6mwl+yK/35HV9QleMHfa5CaVq9SVfp4xwcGtxtQOpNQLZxvxJ9kA0HwvK2Vc?=
 =?us-ascii?Q?dykCZ2vn2uxwAv31If8AYx0enZLArHX7YYPDIYI83KunbRNFTOvJfd5Ztw79?=
 =?us-ascii?Q?co2FbETxKZS6oNZ57Xo2xh3nGUWNnCbNrYBP6CT6/0Q5Eag7gx5gn7JFGIqi?=
 =?us-ascii?Q?ORynYbCjeVSwe3Blw4RZNUknNZeLufl+9lHZekwT5KIgYwH5qCBgzj1/SiRi?=
 =?us-ascii?Q?KY3SUEftwQawYMWGLGgpaOb4sWpInjqn3J3gJDnSUQbZDfwTaE3Ivbn8Dipz?=
 =?us-ascii?Q?yxVnpPvBskip5ZkIzpoiWzPAHKt5r2cpBV15mYSrDRbZR3RUzSW28b7tNBTS?=
 =?us-ascii?Q?/RW5pD8ipGX7P3JOkeON4OUu9LYQP6RRvInebrjttfAq9aLyaQTXW1dQ6MNp?=
 =?us-ascii?Q?H52SF1aUdnJm6S7FBXpEDXWnVHtEsOBGGoQleQEouu+rBP2W124RYjeQtB13?=
 =?us-ascii?Q?k5J20uy2ZF0vtrFyGFTW7dU7oRFl3rozUC8u34NKFYDihbM+w6SudgP2xeXb?=
 =?us-ascii?Q?wuX6qoXUluCnBPA1NQu19dha1sLuswF4jrZsYHUErHgDah4J6EKwEONz6+gh?=
 =?us-ascii?Q?K3zd27yMOXFETU7lBrakielmb3XSrzzdK2cdFthzRIDH9qcFR8yfuHSV3syL?=
 =?us-ascii?Q?lmLQpKWp9wfL2Mfy8YHDhNCDv4q9d4GGRY44z4QSojC8N3c2e9BVdayatIuf?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 918c5999-8667-410b-cc00-08dcd78904ce
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 02:24:27.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VH9IkF0ID3w+cceqMPfBWYK7M/xxe/5P2IvGWqpUlDBNRKIhZG/H2a+2bal3BOZPjpNTByaXnVv3T+0v/JX+2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7465
X-OriginatorOrg: intel.com

hi, Christian Brauner, hi, David Howells,

On Fri, Sep 13, 2024 at 10:11:25AM +0200, Christian Brauner wrote:
> On Fri, Sep 13, 2024 at 08:59:19AM GMT, David Howells wrote:
> > Can you try with the attached change?  It'll get folded into Christian's
> > vfs.netfs branch at some point.
> 
> The fix you pasted below is already applied and folded into vfs.netfs.
> But what the kernel test robot tested was an old version of that branch.
> 
> The commit hash that kernel test robot tested was:
> 
> commit: a05b682d498a81ca12f1dd964f06f3aec48af595 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> but in vfs.netfs we have:
> cd0277ed0c188dd40e7744e89299af7b78831ca4  ("netfs: Use new folio_queue data type and iterator instead of xarray iter")

thanks for information!

howerver, we noticed there is still similar issues upon cd0277ed0c which now
is in mainline. we reported in below link FYI.
https://lore.kernel.org/oe-lkp/202409180928.f20b5a08-oliver.sang@intel.com/

the issue is still reproduced on mainline or linux-next/master tip when bot
finished the bisect.

[test failed on linus/master      a430d95c5efa2b545d26a094eb5f624e36732af0]
[test failed on linux-next/master 7083504315d64199a329de322fce989e1e10f4f7]

> 
> and the diff between the two is:
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 84a517a0189d..97003155bfac 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1026,7 +1026,7 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
>                 iov_offset += part;
>                 extracted += part;
> 
> -               *pages = folio_page(folio, offset % PAGE_SIZE);
> +               *pages = folio_page(folio, offset / PAGE_SIZE);
>                 get_page(*pages);
>                 pages++;
>                 maxpages--;
> 
> So this is a bug report for an old version of vfs.netfs.
> 
> > 
> > David
> > ---
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index 84a517a0189d..97003155bfac 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -1026,7 +1026,7 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
> >  		iov_offset += part;
> >  		extracted += part;
> >  
> > -		*pages = folio_page(folio, offset % PAGE_SIZE);
> > +		*pages = folio_page(folio, offset / PAGE_SIZE);
> >  		get_page(*pages);
> >  		pages++;
> >  		maxpages--;
> > 
> 

