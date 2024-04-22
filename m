Return-Path: <linux-fsdevel+bounces-17369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85AC8AC48E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 08:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085FD1C20C46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 06:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B0D482EB;
	Mon, 22 Apr 2024 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlDU7OCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE43BBCC;
	Mon, 22 Apr 2024 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768947; cv=fail; b=is7XymvjgH9IenwxbnMyxphOtprF3oorzS3poGafdbhx0n2gYd9v/FCIPAXBr1ddFhb1fGFI0DWhFc75TPAIUO94AmPLdiBub+jXP1QkeWgZMyw97nf2pxCiX2pBAzUpvedEeDdd4M1g80MukQ68aTVMefj80/MFNTVQtK1MycE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768947; c=relaxed/simple;
	bh=OMWE8Mu9PY7nTuhtrkhgfY/jIZCw+RLdYMPNeof+wlY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PoBcqpcoVfm4kCiNYqaaWt4ycBB4jGCHrJH0aDjOPdz0ZB/Qx+8gXHOard8dsv4/LqO1+8n4TgnobzLKXSM9B9qfU/p8r1Mp2Pksq2HIRLA1zAuzRWGn44yMTMWGDV9ppk6pDSmMWCYE4AsHDfFIs0RAdJPFDwktqMOXHfacax8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlDU7OCA; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713768945; x=1745304945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OMWE8Mu9PY7nTuhtrkhgfY/jIZCw+RLdYMPNeof+wlY=;
  b=DlDU7OCAOvW/jQHZLEgQB3/oj5L+YLZg8gxTQO53t6gfBNqzQEWmQgc6
   nUssrFxGynZy4/3MNX+6gC7uYetPTlD7+GM5iXrHOAPt4NNZPAqPi1wCB
   q1OGJtPXnktSt3UnVhxUF4MjzuA76s+xB7EDPazu6LWwb5FB7RH4fD3dx
   DqPXbI2AvfUOrngohZbxRwpwFG+gt55yLX+roMgkd/3TNAQJte0qhdacT
   1aK7tw5xwtcIrsuJuF1DHfrbzvfMwiYmBvF9RCmU3BvYbWk1QI49gGfjj
   l0p4KoPPMA1eNt8bw3FolcH3nWMdTkfM2esL+uJ/V4J0fcXD8XvVkW3uc
   A==;
X-CSE-ConnectionGUID: YbqBNMzBQRqW61282ILu4g==
X-CSE-MsgGUID: qirN3apZSR2CkdPqbgEEeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9209738"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9209738"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 23:55:42 -0700
X-CSE-ConnectionGUID: HngqSDYkTZu9Zjry6fVniw==
X-CSE-MsgGUID: CSHFRW43TOqfdAu0a4RlSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="61361127"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Apr 2024 23:55:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Apr 2024 23:55:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Apr 2024 23:55:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 21 Apr 2024 23:55:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 21 Apr 2024 23:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjOSKmL65pU6yZTc+SiSSlMptCayloDjKP9rrJ1ojRrzyruYjGzAEsKgkBJFxbz0beWIxd2yeeuvPDDERlBJTJ8uKu8lsXGXFJW7YfuscqsjncQtZzG6N0pstlXRD+w3PW6NYf6FDJ+7WtrMAq4uLBW99nRZWgJk93BlwpbNaBQGNzSUwdv/Af0k1vAv9/8TyyZvomJVTL8rKaDACkrcGRUWXGUh05E16juTqCbF8r2Q3lB6rNrDlsihJbaaC43+MwcVq6n+UBssEzcrXduh26aVvpGFo4xZHaMGeyYx3S0wyc0fxMk+xsehzK5rEC5YkptaPo36puwJgYj93HbkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImGM7NgVaCjVtgroLy35OAU55+705orKTYAd570D5wQ=;
 b=MwU6TNp6c5FXcbtQ+68CI0YGQ4XlAkgW4BGOSzB690JKxK82AmBRDrqCqgUewZxmeYjSAQQidu8B6chi7QPe9qFLhBnS1vZ8KNjKaGF9Jca4t7LbuVfUiVJijcZOge8M/6WZSjW+D4lUxwdRANadFChkQLlY6C50zHd64eOP/MlnGeKT6dZRLKC3NKtFDflEIKHgpmxbMxsg86s/TJdYsBJ1Kghi0bcF3+E5/07/um3x74LUlkIMOsPUoMjBj5/D0jIhEbFWwGE0QeV393rILfg5C4iHc3iYx5GGqxYLeG+eNfF7oR524CufXeZCjgl9322ZMshQGQedKNhimOPHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB8301.namprd11.prod.outlook.com (2603:10b6:208:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 06:55:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 06:55:38 +0000
Date: Mon, 22 Apr 2024 14:55:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [axboe-block:rw_iter] [fs/proc]  611088cbf6: segfault_at_ip_sp_error
Message-ID: <202404221436.c921df08-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ba41bb-0d4a-4069-8234-08dc629937ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AqCRu5x7p1e9qv6of8/DOr/Y8xogpUqtGDhOyh7rFX1gMGiCOONhMmoGQaws?=
 =?us-ascii?Q?WsfNVDlARV1T5OwKg4+xum+liN1UKwO1RY4N++sYaH/mHz/Fgcs1xTMd+xP7?=
 =?us-ascii?Q?P+4Hji236UMhwnx02LDWja224cuFOKqgG3GShFlkmg+mLmEqb0O3yP1OVQni?=
 =?us-ascii?Q?pYX0PGVKCZMK2WwYTcKRTuS/Leym6RjlN8S3e+Ptuh0EjxFNAB5ax23jdqhN?=
 =?us-ascii?Q?10FLcYx37RI68dTrUJC1qGICAcoGHMbgSlQ2W+W40FeO3m/vYJMqUhn1awLO?=
 =?us-ascii?Q?1Hypq2DJ2GVTSUVShwWjfnvVPhGsZQQc4QquxfGx7g15oqnvRwUy4fsKDSW+?=
 =?us-ascii?Q?fnl13B+/LyEF5XkpClzGFUvq1OgJR3Lp0cFlTdCU8YhTu0iAXCQ61Y9AesSp?=
 =?us-ascii?Q?LmlXjWvF3vXj1uCnlyGVK97NIVZ2O7PQMyLkdRR/pfvZMGj/rnVezBplRFZV?=
 =?us-ascii?Q?yhIufTfCzCkxyiwBsEiVS9AAyO6yyDU2WsKAM63f3W1zOWYq4K+EZxSLB66U?=
 =?us-ascii?Q?06qAyawroO3XKjWQuEAX18h2zDefBm1CooJvfC/IdAIjcR963MvDrkAsbRMW?=
 =?us-ascii?Q?R+hMSlesEum8FsHwcniWZGV5U+R1KBZj0XRoF0TUCHct+ZgrctwcQZlE4PgI?=
 =?us-ascii?Q?S3tvN7LwUFupcpvBReXiKSFX095SatrVZDsMsoeqUv+jP/9z94T2PQ0HH3oY?=
 =?us-ascii?Q?EGIbqrmHeSNVNF4mwmLjaevaSrDZEyNptfLgHfgedCRdzwOjh2vbFdf8BDDF?=
 =?us-ascii?Q?qgWwl7EnlieLjGvgEVgllZ1tPxxbszUcAYyt/H0pmvInybDAA60Qk1NtulSb?=
 =?us-ascii?Q?ULYspmcg89sSh545/1mzZoeYcXNeptm7Z7org6wpwcNd9l4X6hnnancyhhxI?=
 =?us-ascii?Q?DwPIu1kgZ71DbdVxxRA9Y/8SoLnqQseXRt6ZwZOk+P42Ko6fELwq8JWroWxL?=
 =?us-ascii?Q?n5oXaClV3tdFz5x2Mx0MAG6JxO+LHpcbPwhiGJ1g6n8Tz4/603rwAB40Hqqk?=
 =?us-ascii?Q?u+8ZsEBIFNXfUcdsuwCi4PTXSDAP4bC20MH30Q7lP6FRQ5dTkAJ2xE8LQARm?=
 =?us-ascii?Q?+vlf5c9fsZgdpvYeqnxyGVKIOx9th20pB5ef04dn4+nkV8bD7B1gXYXQ4m7M?=
 =?us-ascii?Q?ynk29XczzEgUJX/1mOu4MF0u65LNP4LZFSm/ALrWqbPOhS5wAzHAEmKGPq11?=
 =?us-ascii?Q?EtDM4ToxjXP3b+FpREIsJoK/CHsQw/ORH6T87JljPlmFuSGdXWMl9LUlrWA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OLOI8/WMBUcylMkqL3PZTZwgRnVREFPS9QpWHtHzEKjWmhRYHJFKZKWbI6er?=
 =?us-ascii?Q?ng2AsS7Cv5pPQdKzrG+rTgJdyX3zCz3jMB4a89kcC8Y0hcOApDJvGrBvrD5j?=
 =?us-ascii?Q?N8veG7sYbGZzu3Yi5pQoBBPYpGYQX0x6FUtJRB/Tb5SPoJqhuGk7UfpTSXR0?=
 =?us-ascii?Q?DW4JggIcCAfdbK3lNdHcT9GzxaGOIE0O/8XK0CdLzAZMmvbP1rJwiStXOSYn?=
 =?us-ascii?Q?r5nmR65JzKwYcuekrr3DWd7D/eoDG5h7fyx/4/2pXqhsRWN+BPS948K9eOKF?=
 =?us-ascii?Q?v3Oo4LhQb28DV7WUAQh7Vy0zkECrlzjTbaGs8YfFF46ty2aAnnLVYrCfMHtB?=
 =?us-ascii?Q?gHcyW1tPcfkLqOcc12crcFUAB9KsVQJ+oHVkEes6c5xvmqhqedBD8GAoYbDo?=
 =?us-ascii?Q?FjD6kDQcaPudM5M//iZViLNxqZwcur4dfPtO43R4AFixMgVn6vFj8Di+8v06?=
 =?us-ascii?Q?imkq9IYJlWWoofxhNU6RNGqOhqD7fuYrw3QNUlOmzzGLyHoJApMG1m7rNFoP?=
 =?us-ascii?Q?0muCvg3g6HbbCne4UFH4ldkO0a6WAMZJEynN306iIanbOWYNQ3F81l38uhtz?=
 =?us-ascii?Q?9A+ztNw/1w7RBfIYv6JvRReuVyx3wGuWq2xlQxdM22y4fs4Z7DxGF/TaABZh?=
 =?us-ascii?Q?KEtUKBBbnyGFBGx76d6iDLj5PfYyUztseLqWXG8WOxu7hyf2NwD3MP1L2RPc?=
 =?us-ascii?Q?AWqZIRGPZWDqxy4nejv9tZJm874soIYRvGGgft99eXFS9X5cXprjGBcHW4xI?=
 =?us-ascii?Q?175v0QorrAg3yFp0eiWqGvR1cDnouEfe3So40OTIu2Mljoxzn95yJZauFnL0?=
 =?us-ascii?Q?8HOn+rSTxPRmOX3/S1LJ7/7gZKwOL861XYlWp0TzNhxf/IJrCydAj6k2et7a?=
 =?us-ascii?Q?475sXa19Ob6dH7/6BlMyDlkmo4Zj4V2T4jBoDY4LjLX8l040OV9mrTUXLJNC?=
 =?us-ascii?Q?ruVAZArZMwqy35M6FMtanQogftwzgQsxzwdMyGomLNCPqiwQPhBiUhz89XeR?=
 =?us-ascii?Q?ydPNeWArbHTYSjsS6ubATsjkoBwZnB39l1s15UP3ZcWleIOp1fx9BXg8+ehN?=
 =?us-ascii?Q?6qewXtQ98hJy+IexrcXSeLhmbAVv/6faNoqc+1IQOuZ2FDVpuIGAVpGITcY2?=
 =?us-ascii?Q?EnpbsigX+cwdp74nIOZO2bIaAbEVLZjP7gli+Z9ju2YmnKQSToqquGyVzxFQ?=
 =?us-ascii?Q?eXtxqPQwhSXTenRYpB8lim/11Zah+OewKoE/bZUMjuusGmBtPFT821X6xpOH?=
 =?us-ascii?Q?YVAYJrN0UgtVyOH9ltUqhUdsTZ8oyGcsolTa/dgciEvRhvMbtxa0hZnQL9RL?=
 =?us-ascii?Q?BzfoklwlMCK2b5mhPksvCXukf5u9cp6YFy7KkU0B5Qug9kl9xqzB5NNrD3O/?=
 =?us-ascii?Q?CwQIGzorzCYIRIvzp89AEuW3f9E7wYb7PcINIZ19wfIzgtHW9d4S0wxdZhq1?=
 =?us-ascii?Q?Un6vwKEbZyLTtpq07qvBWUjTL1faTPximJx4T5ZyKSLezY9ZtrOrBlQUi93I?=
 =?us-ascii?Q?XMTy5D2RvlhE+M5/qbm1ITGOyTgn0GjCgfJ6x/UUBzEMAPe0lCdA4NSk5SjM?=
 =?us-ascii?Q?yT8Jr4GoTbTFNTVpbgRgTTCmntGyFLyc9etoIb6t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ba41bb-0d4a-4069-8234-08dc629937ce
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 06:55:38.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GD3vMWEK7sL4WI0hft9ncaAsQB90TEh3DHFiYwRdJqd80pmBSLqPDWhx1fn5ZFnV7jIOH+MIt5cfhxPkjtjCNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8301
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "segfault_at_ip_sp_error" on:

commit: 611088cbf6bda5c9218c735809215f2b6f6ca8a9 ("fs/proc: convert to read/write iterators")
https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git rw_iter

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------+------------+------------+
|                                                              | 255806aeec | 611088cbf6 |
+--------------------------------------------------------------+------------+------------+
| segfault_at_ip_sp_error                                      | 0          | 20         |
+--------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404221436.c921df08-oliver.sang@intel.com



[  809.068720][  T602] vmstat[602]: segfault at 50b000 ip b7f2f6ec sp bfef7790 error 6 in libprocps.so.7.1.0[b7f2f000+a000] likely on CPU 0 (core 0, socket 0)
[ 809.071867][ T602] Code: 84 91 00 00 00 89 74 24 0c 89 ee 89 cd 90 57 6a 01 6a 08 55 e8 e5 fb ff ff 8b 83 f0 09 00 00 8b 54 24 24 8b 4c 24 28 83 c4 10 <89> 14 30 89 4c 30 04 8b 44 24 14 83 c6 08 85 c0 75 d2 8b 74 24 0c
All code
========
   0:	84 91 00 00 00 89    	test   %dl,-0x77000000(%rcx)
   6:	74 24                	je     0x2c
   8:	0c 89                	or     $0x89,%al
   a:	ee                   	out    %al,(%dx)
   b:	89 cd                	mov    %ecx,%ebp
   d:	90                   	nop
   e:	57                   	push   %rdi
   f:	6a 01                	pushq  $0x1
  11:	6a 08                	pushq  $0x8
  13:	55                   	push   %rbp
  14:	e8 e5 fb ff ff       	callq  0xfffffffffffffbfe
  19:	8b 83 f0 09 00 00    	mov    0x9f0(%rbx),%eax
  1f:	8b 54 24 24          	mov    0x24(%rsp),%edx
  23:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  27:	83 c4 10             	add    $0x10,%esp
  2a:*	89 14 30             	mov    %edx,(%rax,%rsi,1)		<-- trapping instruction
  2d:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
  31:	8b 44 24 14          	mov    0x14(%rsp),%eax
  35:	83 c6 08             	add    $0x8,%esi
  38:	85 c0                	test   %eax,%eax
  3a:	75 d2                	jne    0xe
  3c:	8b 74 24 0c          	mov    0xc(%rsp),%esi

Code starting with the faulting instruction
===========================================
   0:	89 14 30             	mov    %edx,(%rax,%rsi,1)
   3:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
   7:	8b 44 24 14          	mov    0x14(%rsp),%eax
   b:	83 c6 08             	add    $0x8,%esi
   e:	85 c0                	test   %eax,%eax
  10:	75 d2                	jne    0xffffffffffffffe4
  12:	8b 74 24 0c          	mov    0xc(%rsp),%esi
[  809.127897][  T543] vmstat[543]: segfault at 4df000 ip b7f926ec sp bfe31560 error 6 in libprocps.so.7.1.0[b7f92000+a000] likely on CPU 0 (core 0, socket 0)
[ 809.131027][ T543] Code: 84 91 00 00 00 89 74 24 0c 89 ee 89 cd 90 57 6a 01 6a 08 55 e8 e5 fb ff ff 8b 83 f0 09 00 00 8b 54 24 24 8b 4c 24 28 83 c4 10 <89> 14 30 89 4c 30 04 8b 44 24 14 83 c6 08 85 c0 75 d2 8b 74 24 0c
All code
========
   0:	84 91 00 00 00 89    	test   %dl,-0x77000000(%rcx)
   6:	74 24                	je     0x2c
   8:	0c 89                	or     $0x89,%al
   a:	ee                   	out    %al,(%dx)
   b:	89 cd                	mov    %ecx,%ebp
   d:	90                   	nop
   e:	57                   	push   %rdi
   f:	6a 01                	pushq  $0x1
  11:	6a 08                	pushq  $0x8
  13:	55                   	push   %rbp
  14:	e8 e5 fb ff ff       	callq  0xfffffffffffffbfe
  19:	8b 83 f0 09 00 00    	mov    0x9f0(%rbx),%eax
  1f:	8b 54 24 24          	mov    0x24(%rsp),%edx
  23:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  27:	83 c4 10             	add    $0x10,%esp
  2a:*	89 14 30             	mov    %edx,(%rax,%rsi,1)		<-- trapping instruction
  2d:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
  31:	8b 44 24 14          	mov    0x14(%rsp),%eax
  35:	83 c6 08             	add    $0x8,%esi
  38:	85 c0                	test   %eax,%eax
  3a:	75 d2                	jne    0xe
  3c:	8b 74 24 0c          	mov    0xc(%rsp),%esi

Code starting with the faulting instruction
===========================================
   0:	89 14 30             	mov    %edx,(%rax,%rsi,1)
   3:	89 4c 30 04          	mov    %ecx,0x4(%rax,%rsi,1)
   7:	8b 44 24 14          	mov    0x14(%rsp),%eax
   b:	83 c6 08             	add    $0x8,%esi
   e:	85 c0                	test   %eax,%eax
  10:	75 d2                	jne    0xffffffffffffffe4
  12:	8b 74 24 0c          	mov    0xc(%rsp),%esi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240422/202404221436.c921df08-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


