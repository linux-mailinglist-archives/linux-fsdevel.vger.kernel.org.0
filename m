Return-Path: <linux-fsdevel+bounces-69851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E1C87D63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 03:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D15A3AC95E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 02:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E0630B506;
	Wed, 26 Nov 2025 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrWzYqqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2889272E6A;
	Wed, 26 Nov 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124547; cv=fail; b=kJoTOGch5wkiXAEo4mAb6jjIOkcgK5JNFFsUM+xKqE0Yzhp5rppoKqDoq2ltqi9IU99HUXJY1ohlXX/DJtCpm8i1ZgLmiOUxYsMRfwctlrFBepLUzPvWdg1lG5zFI9E5/T60V3CQwXeE3wWHMLXyxOTxyTg2eL1p1QCDCKmb0Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124547; c=relaxed/simple;
	bh=0vyQQHTGKvyJj8HXHf7z0EaN88ayBLebgi84HJp4TmM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OKLZULZ+WDYy2ctA2MNJhOYDRKvcoEjM04FUT8zPcUqlQxwDH0kZl/WGEqo2iCgDlLaA1m2S4c/JgNCW72rsKwaazhsbA5YTLjh0623Gxr5JJd/hm7YXnR52mYcputwLBZCki23FK+4ir+VpUgYMeHI5c3+BNmC9giIz2O/o5RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrWzYqqV; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764124545; x=1795660545;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0vyQQHTGKvyJj8HXHf7z0EaN88ayBLebgi84HJp4TmM=;
  b=WrWzYqqVu9ACw1eFnSQ5IdwpU4Z+cRVXcAPVTw2OB8zYg2iRqPxYwP+8
   LLF5TLQ/bY+yLhJQa0elEUpFb8f2xgoeurvM1N+EhsDJq3C1aTxk8SyP1
   ONx9/OEOojrdjSjuBNgnQ494nZCGZvBx0XJA9Q6xTV7YVFx9tHLkvoxR6
   fF9jDOLdZ+X3tLwgIwYEXRcgHEf7XovlTmGJ5imqv3sbeD57IGCU55Iin
   zkBKwBgYY7ExaeR30Ij+VHF8VHEGEjtt04LtjZADeuFcR5yYFHMsdMIoL
   GMpGUxGwn1WlEGApI2jht7JFz3VYa13tYXUAL1Aj7IEWIdBqUF0G0jOId
   g==;
X-CSE-ConnectionGUID: CIBOtZ1IThiubPkW5ZwnGw==
X-CSE-MsgGUID: sfzQppBkSG+elR/yOIq6Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66041824"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="json'?scan'208";a="66041824"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 18:35:45 -0800
X-CSE-ConnectionGUID: Lb8WYF0xRDuL88c4qUYzcA==
X-CSE-MsgGUID: iF65/MmIQCawSihqpjzWkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="json'?scan'208";a="191956579"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 18:35:45 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 18:35:34 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 18:35:34 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 18:35:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofAPqeQj1ujJMx75dfI7YMmiPzdxoUGtt1Ue1DGxW7xR9l7wu9Z4mtnpn1LGjhR7natoifPR8CFQ48ZLY4I7RTFusXCh3BSgfT0RO7gG4HMvwfb5mz8G+6pPj1xTvQkbNaqsMaIjiYOzsD+y3C+q1ZFlUOHC/SNwSZJXcC+btq7M4Cb2ecBsAhTvVhCGEGIAfiml54LuGkertxFejZVKT2K8PNMBNegHSJMIO8N12vBrNQKc/50bdKLnWBzOGxJOdhBSI3Rovya22ZuSm34TlELvb0mXvtTEYwXllJGinVG334C4gvc5+npaPo+pmL2VjTdHXVEpPdvQld7TcsLfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSC55A9zzSkXzagTyQyKcFfKaSNamFZeoCVjy/HEwl8=;
 b=pGHEDsY8Mrts/bOagFD7sJASSGSaW7+RQD82mmKaYekP9iT2Bycy8SnoiJzLpkdPzXN6pM1KMwnA9QRkS47fTe8t2JGfTBQNP6O4yj2sX75vrrwMtJ0yZBzVK4i9yu0ubFZucgDsBsLhu0vuuqbgylL5F3zDlDU2PSf5WXbCLxy7xqPZYuEsGYcPZQwXo8odiTP3b3fuVKZQ32EWXL4AKDfP+c+EKevSh3JkSzyC+q2EFJl+ypEVKsaXn3vCVlWWW/uZ38mIo0YpnmrAji3IPJsZ6ErINKkUtFPbAWSpBKvFBPcBZI05R37q+SiyzXHtr8/AgwEHUYth8iyWPXdRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 02:35:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 02:35:00 +0000
Date: Wed, 26 Nov 2025 10:34:51 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Cyril Hrubis <chrubis@suse.cz>
CC: Joel Granados <joel.granados@kernel.org>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oe-lkp@lists.linux.dev>, <ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: Re: [LTP] [linux-next:master] [sysctl]  50b496351d: ltp.proc01.fail
Message-ID: <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>
References: <202511251654.9c415e9b-lkp@intel.com>
 <aSWI07xSK9zGsivq@yuki.lan>
Content-Type: multipart/mixed; boundary="RT0ZUs9qBXuo/ipI"
Content-Disposition: inline
In-Reply-To: <aSWI07xSK9zGsivq@yuki.lan>
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: d0135d44-180a-4682-fda5-08de2c94659a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4013099003|4053099003|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j9x9h2KQIbyuGUBaAZMv/34AOFu9vZSW3eNiqoQE48zGDzuWJBeDaXC14FsM?=
 =?us-ascii?Q?kwM2CwP76hs5Ytcecg00QDTzTB8rWfGNuC1idmXyKtoNndZv71qeBP+XlqTF?=
 =?us-ascii?Q?qvgUfXyOPxQbiAslEY1IJIG/Y3DDXKY18hFstzIKGahjwxwYNEj/1R2443I5?=
 =?us-ascii?Q?ia1JIzAuU98rypYG3ZGO0VHoTUsXSmcCaAIrqM8hcWoqFvYXnXCAKqq99vyG?=
 =?us-ascii?Q?S5M8XADL1Bk6yVBvYROSn5f2VO6Ca6t08/ZThtua2EtHuVfM+w7aVjDDW/ux?=
 =?us-ascii?Q?pZxA7ocj+vL/11gtJRPhfJ3yZ9gCrjtyNld+M/gQTcz/t9+NM5ANKKMo8eHr?=
 =?us-ascii?Q?95QG9BAQ8dDe5taIKcadp1bu2pQXydSxf+Ldp+CNJQb17OvBGS0yx+fQqK1G?=
 =?us-ascii?Q?c5U44NOz25FJcBJVGJS6xGe4PASSrH/vbPEN/uKSoaANbvn0acj6dV3br7Rw?=
 =?us-ascii?Q?4mP3/rWG+3rYCNS6qzoBsnDmHVugCEjKmXkxhN8wpMYA6UdHo5DTWX8zhCUC?=
 =?us-ascii?Q?Y2WO8QVkr7USjNijrvzV53gPxMyRl8vgadoXkfD/9Q/EOlm6KI2+UjpuPfsV?=
 =?us-ascii?Q?0W00V01GFCiA+stzp9OV+T9KsmBFToLxxZHseSoifS8H65oYdT3v4qfqsCZc?=
 =?us-ascii?Q?m8t3bbY7P2jwYg9tTnG+y7+u/JtS4k06H+ZUg19t8/E8PHT4RipMy6wo+Dh5?=
 =?us-ascii?Q?qvqw7zfqcs5Jh6Fqbl57bMMxmMi1NhxI6axcFGrptId4LJzK1S+irQBBPxxi?=
 =?us-ascii?Q?PpGUVMsXKpjGB68pOmnWypWI8S5UafCWzTBMdEbsdkN4M/yfZknJsvjbW+4R?=
 =?us-ascii?Q?V63xH+qUt64uFCK8TIceeTp170rrkp4bBNKCXqS7lfjk70+YMvS7lT8yBGlx?=
 =?us-ascii?Q?4s2t8wBsFlG5Vw6yY1tT8rE7lEpHn0+ylTsDwfIQeCztUwjCXu03wg2faxzs?=
 =?us-ascii?Q?hyjrOwOgMWkGG93w1qfNiLLDuZCZMbTLeC4YJOV+HTB+sLxZmrXhEoRV5Mla?=
 =?us-ascii?Q?C3A3ieqftRB2GRO+/ij4bZc9taQ/13equOfWEjImu51z4lcTYjkUTuQTy6BX?=
 =?us-ascii?Q?u5u91JyGdAR1La0mtnO2BYypKmfQk4A2wxIR7uCCwWYv4yrhHe5igJK/FGmq?=
 =?us-ascii?Q?5RL04QtcyP2PzX0emjxW6BG1GtS561BrY9bPJHfKOiHAzvn6/aFicr0n7hX4?=
 =?us-ascii?Q?pio4F/0Rpw3VVamwWlOcKfRiS/UXd4zYNjWuf0/Sx0o/5Slzkl8fsIoOLYYS?=
 =?us-ascii?Q?ZBwAhc2148tLcJeMDGNRepJF8CNNuPpOc2PmevJRJ21NvJB+7BvaYMTMXruf?=
 =?us-ascii?Q?fyvPt0kJGZb+iCw2tq5kHc79sFB1ZtwQHYRKrZi9QixVKzt1ATimOxKumVjZ?=
 =?us-ascii?Q?vb5wWlaIhNbFxhdaf9ZoNvGsDeJBQvzqiBtXP7xnefJd9CicidSF9XGq0Zpb?=
 =?us-ascii?Q?JiSo9OrZY9zhkXaAX+0Dztw1ueQihlrw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4013099003)(4053099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dOB4HLVStNV29Mc5a7IBkUtFpFb/pjs9cR7Qbv9ZAWyQuXV/+x45Gd/MePJv?=
 =?us-ascii?Q?uBFsJs8czK/xjGkFqiyN19PRmcBMYVHenbcWwzu3Z4aHGLdmkGPif0CDpboR?=
 =?us-ascii?Q?HVZriQoRtDWrr1Fb3bjgnlLIw1qR9Tencr9Cae4/q1cAC6QOu9bbV/32J6p4?=
 =?us-ascii?Q?PXBjDUG5kEJtq+uoWrD+KECUe56TZE64djXh42BmQuDnn7icJ+fV9hdu3E2a?=
 =?us-ascii?Q?JI7BDgPKxzBOCV0WBtAqmurlH9By/AE2yuD3W7Ohv+FGbnC8Tf7Z93NwyexP?=
 =?us-ascii?Q?FgYL747wvBbpVm1Mn4UzmGaXFkjguifoA8azlx9YEBDx/d7OEQ9iH2EsZ9F2?=
 =?us-ascii?Q?rlAEUTRn85lz4MA+A8p/PsFTujepMkY2wlcx0oeaW6DoRqyNPjNJa46np10J?=
 =?us-ascii?Q?F09Mw7fXrBut+nNIoSyiSTP8rMHhFw/5eYD0HNMHEKVIimKMeJuQp2XcgIDh?=
 =?us-ascii?Q?/O9Qtn8fErK993OyimhfgtPa6Tj4DFq2UpWVPUzkcAqpLDuboA5Be+S2wodG?=
 =?us-ascii?Q?OMZWpb6fidVPlhqVjv/X7ANDL+GNw07MbRCLfFErrkSz5/Ml5vPvH5VTaBCC?=
 =?us-ascii?Q?UMWv3SJOENQkgmqO/gkSVExaFVTPeX6pLrveW3SLUnuRJhBOiC0mQbSJ0klv?=
 =?us-ascii?Q?HunUZXK+74pbpmrcteg3ztav9WGjg7Wf1AU3QgaBo4Uwxn7pgc7wExc7Vu3P?=
 =?us-ascii?Q?Ruq2HgqyWshYerxWlHlcpGqFTMj9I3Kcc3tFKTPWm1wpgWb9kKXz0mPaZfkc?=
 =?us-ascii?Q?tNDOspDuWFry1UCRNr02SfokhGcvgvyqvswodS3ma/q1KeTd9v1hDt4A6rhg?=
 =?us-ascii?Q?7KVfS7VHtCgRv/3RMnPaWueNhm9kfpW7rn/pGjt5n74nRgaiFk+rxVqgqLOl?=
 =?us-ascii?Q?g3hnlpLMcDnkmCj8H566DPkKJ+J/uff0tENhYtaHCc7RAUnHkqEwG+PuoroY?=
 =?us-ascii?Q?ldxPpikn76XUTQSC7wEHbhRM+dfIS2nivOsBSMpyMp/d49as74agkR6dtgSi?=
 =?us-ascii?Q?eRrPCNodjSwVUTpRrhrVDj7pF2NQ4BTZC6DlKMOyKQa93GYekyEL9iur/8pD?=
 =?us-ascii?Q?BMv1Zz69NPl07pSaCG75Q1HnnnEsuw+lHJJODCrSllcu3T9mvj4WBOx9yixh?=
 =?us-ascii?Q?rj5XpqlCdENX0qOS0n/gtaS74dpxeQdGqoA546C4GcrupW3huIPZxcp8NCMw?=
 =?us-ascii?Q?W1BquqXvtpbCS3OxXVbIlvZzmuHTcpAABlbNoIIYmVGlYG3Ms8R188BhjOMr?=
 =?us-ascii?Q?qWWMQ3k2l1ekWa81CvaJz648aAPqIsm94feCAjuAVNsqNRv0oM+l9oyZmI/G?=
 =?us-ascii?Q?gbNb+ptninJet6E9kxslU7jMia0Jwn8dwXDcUmIFlTddmPpL1YJCC9JDR7x6?=
 =?us-ascii?Q?Aq1xISZJYz771Qryfrg8wuATnP/8/4g890qRZRqifVMbSvTYb/R9wD4G/Tch?=
 =?us-ascii?Q?VtmUOapWhcKNBPpePvd85/PoIuFs84snonMug/4DY1KyVrdHBLczzT/OqPht?=
 =?us-ascii?Q?aKhTqV/VEtxr/hX1F2yyRZFCgMO/JgHp9NETkQ5OsYSKn8Qk5UBf460JqEbM?=
 =?us-ascii?Q?p2kFpTcNmHuF7WhZqhmysKQqFehZ1o4vTcXdNmrDpjHK1CyykN7t8FCqP0yB?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0135d44-180a-4682-fda5-08de2c94659a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 02:35:00.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTx7zvN0/NtXeKTUzN2NmP1KpWIt+NftmTEaMI+Ad86D2MxbXbiHKsjhAnEsoN2BH92XOgKPLGKf80yoGcvhRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com

--RT0ZUs9qBXuo/ipI
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, Cyril Hrubis,

On Tue, Nov 25, 2025 at 11:45:39AM +0100, Cyril Hrubis wrote:
> Hi!
> > PATH=/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/lkp/lkp/src/bin
> > 2025-11-25 05:37:33 cd /lkp/benchmarks/ltp
> > 2025-11-25 05:37:33 export LTP_RUNTIME_MUL=2
> > 2025-11-25 05:37:33 export LTPROOT=/lkp/benchmarks/ltp
> > 2025-11-25 05:37:33 kirk -U ltp -f fs-00
> 
> Oliver can you please record the test logs with '-o results.json' and
> include that file in the download directory?

I attached one results.json FYI.

it need some code change to upload it to download directory, we will consider
to implement it in the future. thanks


> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

--RT0ZUs9qBXuo/ipI
Content-Type: application/json
Content-Disposition: attachment; filename="results.json"
Content-Transfer-Encoding: quoted-printable

{=0A=
    "results": [=0A=
        {=0A=
            "test_fqn": "gf15",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "growfiles",=0A=
                "arguments": [=0A=
                    "-W",=0A=
                    "gf15",=0A=
                    "-b",=0A=
                    "-e",=0A=
                    "1",=0A=
                    "-u",=0A=
                    "-r",=0A=
                    "1-49600",=0A=
                    "-I",=0A=
                    "r",=0A=
                    "-u",=0A=
                    "-i",=0A=
                    "0",=0A=
                    "-L",=0A=
                    "120",=0A=
                    "-f",=0A=
                    "Lgfile1",=0A=
                    "-d",=0A=
                    "$TMPDIR"=0A=
                ],=0A=
                "log": "gf15        1  TPASS  :  Test passed\n",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 11.382669687271118,=0A=
                "failed": 0,=0A=
                "passed": 1,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "gf17",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "growfiles",=0A=
                "arguments": [=0A=
                    "-W",=0A=
                    "gf17",=0A=
                    "-b",=0A=
                    "-e",=0A=
                    "1",=0A=
                    "-i",=0A=
                    "0",=0A=
                    "-L",=0A=
                    "120",=0A=
                    "-u",=0A=
                    "-g",=0A=
                    "5000",=0A=
                    "-T",=0A=
                    "101",=0A=
                    "-t",=0A=
                    "499990",=0A=
                    "-l",=0A=
                    "-C",=0A=
                    "10",=0A=
                    "-c",=0A=
                    "1000",=0A=
                    "-S",=0A=
                    "10",=0A=
                    "-f",=0A=
                    "Lgf03_",=0A=
                    "-d",=0A=
                    "$TMPDIR"=0A=
                ],=0A=
                "log": "gf17        1  TPASS  :  Test passed\n",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 120.33628177642822,=0A=
                "failed": 0,=0A=
                "passed": 1,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "gf20",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "growfiles",=0A=
                "arguments": [=0A=
                    "-W",=0A=
                    "gf20",=0A=
                    "-D",=0A=
                    "0",=0A=
                    "-b",=0A=
                    "-i",=0A=
                    "0",=0A=
                    "-L",=0A=
                    "60",=0A=
                    "-u",=0A=
                    "-B",=0A=
                    "1000b",=0A=
                    "-e",=0A=
                    "1",=0A=
                    "-r",=0A=
                    "1-256000:512",=0A=
                    "-R",=0A=
                    "512-256000",=0A=
                    "-T",=0A=
                    "4",=0A=
                    "-f",=0A=
                    "gfbigio-$$",=0A=
                    "-d",=0A=
                    "$TMPDIR"=0A=
                ],=0A=
                "log": "gf20        1  TPASS  :  Test passed\n",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 28.55143165588379,=0A=
                "failed": 0,=0A=
                "passed": 1,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "gf25",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "growfiles",=0A=
                "arguments": [=0A=
                    "-W",=0A=
                    "gf25",=0A=
                    "-D",=0A=
                    "0",=0A=
                    "-b",=0A=
                    "-i",=0A=
                    "0",=0A=
                    "-L",=0A=
                    "60",=0A=
                    "-u",=0A=
                    "-B",=0A=
                    "1000b",=0A=
                    "-e",=0A=
                    "1",=0A=
                    "-r",=0A=
                    "1024000-2048000:2048",=0A=
                    "-R",=0A=
                    "4095-2048000",=0A=
                    "-T",=0A=
                    "1",=0A=
                    "-f",=0A=
                    "gf-large-gs-$$",=0A=
                    "-d",=0A=
                    "$TMPDIR"=0A=
                ],=0A=
                "log": "gf25        1  TPASS  :  Test passed\n",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 0.009784221649169922,=0A=
                "failed": 0,=0A=
                "passed": 1,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "rwtest01",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "export",=0A=
                "arguments": [=0A=
                    "LTPROOT;",=0A=
                    "rwtest",=0A=
                    "-N",=0A=
                    "rwtest01",=0A=
                    "-c",=0A=
                    "-q",=0A=
                    "-i",=0A=
                    "60s",=0A=
                    "-f",=0A=
                    "sync",=0A=
                    "10%25000:$TMPDIR/rw-sync-$$"=0A=
                ],=0A=
                "log": "rwtest01    1  TPASS  :  Test passed\nTest passed\n=
",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 60.358551263809204,=0A=
                "failed": 0,=0A=
                "passed": 1,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "rwtest04",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "export",=0A=
                "arguments": [=0A=
                    "LTPROOT;",=0A=
                    "rwtest",=0A=
                    "-N",=0A=
                    "rwtest04",=0A=
                    "-c",=0A=
                    "-q",=0A=
                    "-i",=0A=
                    "60s",=0A=
                    "-n",=0A=
                    "2",=0A=
                    "-f",=0A=
                    "sync",=0A=
                    "-s",=0A=
                    "mmread,mmwrite",=0A=
                    "-m",=0A=
                    "random",=0A=
                    "-Dv",=0A=
                    "10%25000:$TMPDIR/mm-sync-$$"=0A=
                ],=0A=
                "log": "rwtest04    1  TPASS  :  Test passed\nTest passed\n=
",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 60.98546767234802,=0A=
                "failed": 0,=0A=
                "passed": 1,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "inode01",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "inode01",=0A=
                "arguments": [],=0A=
                "log": "inode01     0  TINFO  :  Using /tmp/LTP_inoVhPRjy a=
s tmpdir (tmpfs filesystem)\ninode01     1  TPASS  :  Test block 0\ninode01=
     2  TPASS  :  Test block 1\ninode01     3  TPASS  :  Test passed\n",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 0.007191896438598633,=0A=
                "failed": 0,=0A=
                "passed": 3,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "inode02",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "inode02",=0A=
                "arguments": [],=0A=
                "log": "inode02     0  TINFO  :  Using /tmp/LTP_inouYHBYM a=
s tmpdir (tmpfs filesystem)\ninode02     0  TINFO  :  Using /tmp/LTP_inouYH=
BYM as tmpdir (tmpfs filesystem)\ninode02     0  TINFO  :  Using /tmp/LTP_i=
nouYHBYM as tmpdir (tmpfs filesystem)\ninode02     0  TINFO  :  Using /tmp/=
LTP_inouYHBYM as tmpdir (tmpfs filesystem)\ninode02     0  TINFO  :  Using =
/tmp/LTP_inouYHBYM as tmpdir (tmpfs filesystem)\ninode02     0  TINFO  :  U=
sing /tmp/LTP_inouYHBYM as tmpdir (tmpfs filesystem)\ninode02     1  TPASS =
 :  Test passed\n",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 0.14139986038208008,=0A=
                "failed": 0,=0A=
                "passed": 1,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "stream01",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "stream01",=0A=
                "arguments": [],=0A=
                "log": "stream01    0  TINFO  :  Using /tmp/LTP_strFftw6n a=
s tmpdir (tmpfs filesystem)\nstream01    1  TPASS  :  Test passed.\n",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 0.0025658607482910156,=0A=
                "failed": 0,=0A=
                "passed": 1,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "stream05",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "stream05",=0A=
                "arguments": [],=0A=
                "log": "stream05    0  TINFO  :  Using /tmp/LTP_strHZEZVi a=
s tmpdir (tmpfs filesystem)\nstream05    1  TPASS  :  Test passed in block0=
.\nstream05    2  TPASS  :  Test passed in block1.\nstream05    3  TPASS  :=
  Test passed in block2.\nstream05    4  TPASS  :  Test passed in block3.\n=
stream05    5  TPASS  :  Test passed in block4.\n",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 0.0023467540740966797,=0A=
                "failed": 0,=0A=
                "passed": 5,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "lftest01",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "lftest",=0A=
                "arguments": [],=0A=
                "log": "tst_tmpdir.c:316: TINFO: Using /tmp/LTP_lft11lldM a=
s tmpdir (tmpfs filesystem)\ntst_test.c:2025: TINFO: LTP version: 20250930-=
33-g597613727\ntst_test.c:2028: TINFO: Tested kernel: 6.18.0-rc1-00009-g50b=
496351d80 #1 SMP PREEMPT_DYNAMIC Sat Nov 22 05:23:17 CST 2025 x86_64\ntst_k=
config.c:88: TINFO: Parsing kernel config '/proc/config.gz'\ntst_kconfig.c:=
676: TINFO: CONFIG_KASAN kernel option detected which might slow the execut=
ion\ntst_test.c:1846: TINFO: Overall timeout per run is 0h 21m 36s\nlftest.=
c:48: TINFO: started building a 100 megabyte file\nlftest.c:63: TINFO: fini=
shed building a 100 megabyte file\nlftest.c:65: TINFO: total time for test =
to run: 0 minute(s) and 0 seconds\nlftest.c:68: TPASS: test successful\n\nS=
ummary:\npassed   1\nfailed   0\nbroken   0\nskipped  0\nwarnings 0\n",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 0.06624555587768555,=0A=
                "failed": 0,=0A=
                "passed": 1,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "proc01",=0A=
            "status": "fail",=0A=
            "test": {=0A=
                "command": "proc01",=0A=
                "arguments": [=0A=
                    "-m",=0A=
                    "128"=0A=
                ],=0A=
                "log": "proc01      0  TINFO  :  Using /tmp/LTP_proOH66Le a=
s tmpdir (tmpfs filesystem)\nproc01      0  TINFO  :  /proc/sys/fs/binfmt_m=
isc/register: is write-only.\nproc01      1  TFAIL  :  proc01.c:400: read f=
ailed: /proc/sys/net/ipv4/neigh/default/anycast_delay: errno=3DEINVAL(22): =
Invalid argument\nproc01      2  TFAIL  :  proc01.c:400: read failed: /proc=
/sys/net/ipv4/neigh/default/locktime: errno=3DEINVAL(22): Invalid argument\=
nproc01      3  TFAIL  :  proc01.c:400: read failed: /proc/sys/net/ipv4/nei=
gh/default/proxy_delay: errno=3DEINVAL(22): Invalid argument\nproc01      4=
  TFAIL  :  proc01.c:400: read failed: /proc/sys/net/ipv4/neigh/default/ret=
rans_time: errno=3DEINVAL(22): Invalid argument\nproc01      5  TFAIL  :  p=
roc01.c:400: read failed: /proc/sys/net/ipv4/neigh/eth0/anycast_delay: errn=
o=3DEINVAL(22): Invalid argument\nproc01      6  TFAIL  :  proc01.c:400: re=
ad failed: /proc/sys/net/ipv4/neigh/eth0/locktime: errno=3DEINVAL(22): Inva=
lid argument\nproc01      7  TFAIL  :  proc01.c:400: read failed: /proc/sys=
/net/ipv4/neigh/eth0/proxy_delay: errno=3DEINVAL(22): Invalid argument\npro=
c01      8  TFAIL  :  proc01.c:400: read failed: /proc/sys/net/ipv4/neigh/e=
th0/retrans_time: errno=3DEINVAL(22): Invalid argument\nproc01      9  TFAI=
L  :  proc01.c:400: read failed: /proc/sys/net/ipv4/neigh/lo/anycast_delay:=
 errno=3DEINVAL(22): Invalid argument\nproc01     10  TFAIL  :  proc01.c:40=
0: read failed: /proc/sys/net/ipv4/neigh/lo/locktime: errno=3DEINVAL(22): I=
nvalid argument\nproc01     11  TFAIL  :  proc01.c:400: read failed: /proc/=
sys/net/ipv4/neigh/lo/proxy_delay: errno=3DEINVAL(22): Invalid argument\npr=
oc01     12  TFAIL  :  proc01.c:400: read failed: /proc/sys/net/ipv4/neigh/=
lo/retrans_time: errno=3DEINVAL(22): Invalid argument\nproc01      0  TINFO=
  :  /proc/sys/net/ipv6/conf/all/stable_secret: known issue: errno=3DEIO(5)=
: Input/output error\nproc01      0  TINFO  :  /proc/sys/net/ipv6/conf/defa=
ult/stable_secret: known issue: errno=3DEIO(5): Input/output error\nproc01 =
     0  TINFO  :  /proc/sys/net/ipv6/conf/eth0/stable_secret: known issue: =
errno=3DEIO(5): Input/output error\nproc01      0  TINFO  :  /proc/sys/net/=
ipv6/conf/lo/stable_secret: known issue: errno=3DEIO(5): Input/output error=
\nproc01     13  TFAIL  :  proc01.c:400: read failed: /proc/sys/net/ipv6/ne=
igh/default/anycast_delay: errno=3DEINVAL(22): Invalid argument\nproc01    =
 14  TFAIL  :  proc01.c:400: read failed: /proc/sys/net/ipv6/neigh/default/=
locktime: errno=3DEINVAL(22): Invalid argument\nproc01     15  TFAIL  :  pr=
oc01.c:400: read failed: /proc/sys/net/ipv6/neigh/default/proxy_delay: errn=
o=3DEINVAL(22): Invalid argument\nproc01     16  TFAIL  :  proc01.c:400: re=
ad failed: /proc/sys/net/ipv6/neigh/eth0/anycast_delay: errno=3DEINVAL(22):=
 Invalid argument\nproc01     17  TFAIL  :  proc01.c:400: read failed: /pro=
c/sys/net/ipv6/neigh/eth0/locktime: errno=3DEINVAL(22): Invalid argument\np=
roc01     18  TFAIL  :  proc01.c:400: read failed: /proc/sys/net/ipv6/neigh=
/eth0/proxy_delay: errno=3DEINVAL(22): Invalid argument\nproc01     19  TFA=
IL  :  proc01.c:400: read failed: /proc/sys/net/ipv6/neigh/lo/anycast_delay=
: errno=3DEINVAL(22): Invalid argument\nproc01     20  TFAIL  :  proc01.c:4=
00: read failed: /proc/sys/net/ipv6/neigh/lo/locktime: errno=3DEINVAL(22): =
Invalid argument\nproc01     21  TFAIL  :  proc01.c:400: read failed: /proc=
/sys/net/ipv6/neigh/lo/proxy_delay: errno=3DEINVAL(22): Invalid argument\np=
roc01      0  TINFO  :  /proc/kmsg: known issue: errno=3DEAGAIN/EWOULDBLOCK=
(11): Resource temporarily unavailable\nproc01      0  TINFO  :  /proc/kpag=
ecount: reached maxmbytes (-m)\nproc01      0  TINFO  :  /proc/kpageflags: =
reached maxmbytes (-m)\nproc01      0  TINFO  :  /proc/kpagecgroup: reached=
 maxmbytes (-m)\nproc01      0  TINFO  :  /proc/sysrq-trigger: is write-onl=
y.\nproc01      0  TINFO  :  /proc/self/task/6064/mem: known issue: errno=
=3DEIO(5): Input/output error\nproc01      0  TINFO  :  /proc/self/task/606=
4/clear_refs: is write-only.\nproc01      0  TINFO  :  /proc/self/task/6064=
/pagemap: reached maxmbytes (-m)\nproc01      0  TINFO  :  /proc/self/task/=
6064/attr/current: known issue: errno=3DEINVAL(22): Invalid argument\nproc0=
1      0  TINFO  :  /proc/self/task/6064/attr/prev: known issue: errno=3DEI=
NVAL(22): Invalid argument\nproc01      0  TINFO  :  /proc/self/task/6064/a=
ttr/exec: known issue: errno=3DEINVAL(22): Invalid argument\nproc01      0 =
 TINFO  :  /proc/self/task/6064/attr/fscreate: known issue: errno=3DEINVAL(=
22): Invalid argument\nproc01      0  TINFO  :  /proc/self/task/6064/attr/k=
eycreate: known issue: errno=3DEINVAL(22): Invalid argument\nproc01      0 =
 TINFO  :  /proc/self/task/6064/attr/sockcreate: known issue: errno=3DEINVA=
L(22): Invalid argument\nproc01      0  TINFO  :  /proc/self/mem: known iss=
ue: errno=3DEIO(5): Input/output error\nproc01      0  TINFO  :  /proc/self=
/clear_refs: is write-only.\nproc01      0  TINFO  :  /proc/self/pagemap: r=
eached maxmbytes (-m)\nproc01      0  TINFO  :  /proc/self/attr/current: kn=
own issue: errno=3DEINVAL(22): Invalid argument\nproc01      0  TINFO  :  /=
proc/self/attr/prev: known issue: errno=3DEINVAL(22): Invalid argument\npro=
c01      0  TINFO  :  /proc/self/attr/exec: known issue: errno=3DEINVAL(22)=
: Invalid argument\nproc01      0  TINFO  :  /proc/self/attr/fscreate: know=
n issue: errno=3DEINVAL(22): Invalid argument\nproc01      0  TINFO  :  /pr=
oc/self/attr/keycreate: known issue: errno=3DEINVAL(22): Invalid argument\n=
proc01      0  TINFO  :  /proc/self/attr/sockcreate: known issue: errno=3DE=
INVAL(22): Invalid argument\nproc01     22  TFAIL  :  proc01.c:470: readpro=
c() failed with 21 errors.\n",=0A=
                "retval": [=0A=
                    "1"=0A=
                ],=0A=
                "duration": 7.624025583267212,=0A=
                "failed": 22,=0A=
                "passed": 0,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "fail"=0A=
            }=0A=
        },=0A=
        {=0A=
            "test_fqn": "read_all_dev",=0A=
            "status": "pass",=0A=
            "test": {=0A=
                "command": "read_all",=0A=
                "arguments": [=0A=
                    "-d",=0A=
                    "/dev",=0A=
                    "-p",=0A=
                    "-q",=0A=
                    "-r",=0A=
                    "3"=0A=
                ],=0A=
                "log": "tst_test.c:2025: TINFO: LTP version: 20250930-33-g5=
97613727\ntst_test.c:2028: TINFO: Tested kernel: 6.18.0-rc1-00009-g50b49635=
1d80 #1 SMP PREEMPT_DYNAMIC Sat Nov 22 05:23:17 CST 2025 x86_64\ntst_kconfi=
g.c:88: TINFO: Parsing kernel config '/proc/config.gz'\ntst_kconfig.c:676: =
TINFO: CONFIG_KASAN kernel option detected which might slow the execution\n=
tst_test.c:1846: TINFO: Overall timeout per run is 0h 23m 16s\nread_all.c:6=
01: TINFO: Worker timeout set to 10% of runtime: 1000ms\nread_all.c:720: TP=
ASS: Finished reading files\n\nSummary:\npassed   1\nfailed   0\nbroken   0=
\nskipped  0\nwarnings 0\n",=0A=
                "retval": [=0A=
                    "0"=0A=
                ],=0A=
                "duration": 0.09578108787536621,=0A=
                "failed": 0,=0A=
                "passed": 1,=0A=
                "broken": 0,=0A=
                "skipped": 0,=0A=
                "warnings": 0,=0A=
                "result": "pass"=0A=
            }=0A=
        }=0A=
    ],=0A=
    "stats": {=0A=
        "runtime": 289.56374287605286,=0A=
        "passed": 18,=0A=
        "failed": 22,=0A=
        "broken": 0,=0A=
        "skipped": 0,=0A=
        "warnings": 0=0A=
    },=0A=
    "environment": {=0A=
        "distribution": "debian",=0A=
        "distribution_version": "13",=0A=
        "kernel": "Linux 6.18.0-rc1-00009-g50b496351d80 #1 SMP PREEMPT_DYNA=
MIC Sat Nov 22 05:23:17 CST 2025",=0A=
        "arch": "x86_64",=0A=
        "cpu": "unknown",=0A=
        "swap": "0 kB",=0A=
        "RAM": "114663044 kB"=0A=
    }=0A=
}=

--RT0ZUs9qBXuo/ipI--

