Return-Path: <linux-fsdevel+bounces-30135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 899B8986AE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 04:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A94284A32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 02:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306217335E;
	Thu, 26 Sep 2024 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaUtf0MI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAFB4120B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727317267; cv=fail; b=kWm244E+sZsMstPnDCJtjoiHeBXlIlLmMFKi423+3iaeo1PatA+kN19uK7b+ZAgwDvKzouQaswC0vriUP28mf+OIrTKDgfbEF+y/7cf8Myyr7h1O9B9j34exePVP5Hm9IkEM4SsXXt6v7tFACUt/tGfWWfDpqbSI+Hth8vPPdQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727317267; c=relaxed/simple;
	bh=dGbXqeXra5+unxTEq/dz1Tfk3tNIDE5u24Kl+Zs75KM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VtkTLHPnyokGHhfgQZxRMsaOP0lHThCY6+euWtTIj4d0JiZpabHO18F34N9AMJqbhuSLxz0y08xX0Novjyc0yCXheTG7FlaTutFnryBwhsz0wNcEsqqCJV5BQQxDjQjnH3mz65COh/jwvpfre87Gnd0Vt2r2Nagg9rX6UE+z2j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaUtf0MI; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727317264; x=1758853264;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dGbXqeXra5+unxTEq/dz1Tfk3tNIDE5u24Kl+Zs75KM=;
  b=PaUtf0MI53Q1es+87DZgYu5YE3SvSVJM57Kr7YWPS0eyQ6bG3Gupz6+Q
   ghwG4Ir921YlhSEo7AjYVyJ+phdXB86XTKGsYfh4vV59jjZlKlsR5Rzzf
   LgYmmfXOIL4oaVz+ZidoJNR/7IaBere8MnLn+bTy+wtuKrtHWt1iLMM5x
   o7stVFtgnSMV0kO7R7JCQa3lr/2mO4KxSMz+LA+MUBGzrvoFbNEl0gvf/
   fzuAs4cQ1bCMq1PJkrT6coUAYmYp1SQ259wtZKKKof3Fu3eBUX9cIJ04N
   lHCb4ZhN0PZm48VZ7aWkjCqnzeSGvGlPjCnRyftf560GVEhlGzLxGSmLQ
   A==;
X-CSE-ConnectionGUID: OrO5cVY4SUqwnttWw70u5w==
X-CSE-MsgGUID: 7AQNyGMCTs+FMFBr2gYeQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26573701"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="26573701"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 19:21:04 -0700
X-CSE-ConnectionGUID: KWQWrOLSR0CEKlN/pw3lEQ==
X-CSE-MsgGUID: IRvXLfghQSm/tET7JmT7ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="72279161"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 19:20:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 19:20:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 19:20:56 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 19:20:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HF7DNRYBU8WH3t4yLCYqR2nOTk2S8D8Vn0+kJXxVyR6uyty9xqGVX3Jsb1fWJKH/wJq5Y5CoGoqTp/3kNN6i6k3a/pBUd41l6+kaE2G6r+gMWeWVe+zbdRABnZpdqG17NcuOSTZRWQYIhwwyiJ/DTXwt0PhvReuLaAgzmeY1U1Ag4lW73w2G/Vc2UpA16mAb+O374wGiOLfZbDDTjUUnafe3NqdNx7RjSeVdasiBI/kNo+cbAc8mx0WXMSFQZD1H928zOizHSuwWvbNC034G9MCidxvdBZhbGXxrvuCuwk6goVDluim7kXT1qgg7+VLOVfdctnS0t/Rwjz3NmcwQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXoj3dgmCHMJo41l9eRm8VTiA9QCXeR18XoHgzx+oZ0=;
 b=Hh+aPR6hEKVbC+bqz6zOaMERQp0dvbtfPUnKzjOZZfZnyAQfOG4+XcM2iV19F8J3DdYCmh7lHR8tdrCn+D011Mh9enyoaTNPUrySkIjjLmLMXiYF3/JjuHc74XvpQZwzFDWKmXeXmH3COKf2+n5159dYJwDoa8GszpT6LOIokBtfCf+dHssW54FKLErviaf7deuL+K9xOt8IoJ7OgZevYTq2oBzv1g8BR9RlT3uzWLukhCDQcFIanK0w0toodfuq9uRUlv8jCHYgQpT6bCuGpc/wpg/VzAE15SCOaPCfl38BhP1W3Qa1P2Q3nTsv0/4PltVREbFZsDKd6afkYqeZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6404.namprd11.prod.outlook.com (2603:10b6:510:1f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 02:20:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 02:20:53 +0000
Date: Thu, 26 Sep 2024 10:20:44 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, Jeff Layton
	<jlayton@kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [netfs] a05b682d49:
 BUG:KASAN:slab-use-after-free_in_copy_from_iter
Message-ID: <ZvTE/CyH1uavtHL3@xsang-OptiPlex-9020>
References: <202409131438.3f225fbf-oliver.sang@intel.com>
 <1191933.1727214450@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1191933.1727214450@warthog.procyon.org.uk>
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7eefcc-a4e6-463d-14b0-08dcddd1d888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X+y6mG0y/a6d3SBhaenEfZW35QfW2VJND2z9pD5941XD+R44Ajodj1JySZVV?=
 =?us-ascii?Q?XUZdRrHiLPIWQ7Q05SBQWOXlB24CGPkmtGLk1jIHd99UtGHUZVl7gbvc+RvT?=
 =?us-ascii?Q?74edchWjdDBfKR1xzcc+bxVS+2k7veWpWnbVFc1B0/EvVS9qiX/1GGmtmi09?=
 =?us-ascii?Q?Kpgj+Lky6fCeYEkpwaVdBhwA6BxUYSggIWTghZNeDzIhLMHJTkqXlSYZuRmk?=
 =?us-ascii?Q?DQ82CDQ3+TwNTfCWF881VSHxtRcSHdWh2wEKp494lUIFRoJ0y4pMpVjnB+kS?=
 =?us-ascii?Q?zwCYZgvTgwb6orYUeuP6RZAXNpDeGN3lh5ia3k94GoKU4BLSswh5qZIY48Ns?=
 =?us-ascii?Q?JRbIZWJ+/2oCJH4uCahakmqBjL8lxx3fzGWE1jio4v0A5lmBCZFJsCPJXfG6?=
 =?us-ascii?Q?5DYz9t1L3kd4Y8FoZdxiUJPkvZhP07PvtK13ng3vFNyp32gTLHmp0ZWMc7aB?=
 =?us-ascii?Q?sSWi7OmORMgN1bX2Ml/dyHdz03Wclz6MPLQFvClfG0b1VQV6pN+fACQ7+Dht?=
 =?us-ascii?Q?5pojgN3C92pTwUvhmTB5/vlu0EkLPtLBLvSa68zzM4jegNcGKUFAD4kBEO+b?=
 =?us-ascii?Q?VcjI2MJ5NTthheFwRSFhxpngCbxA5MUjBYjLi+HP420Eqg5CjVq6nXo5hNUC?=
 =?us-ascii?Q?3CTKE+0w7sRp1wEQDzmvU8NfpYvULaKWoYQ7QkpGkAkIGVLb/F9b4mX2buam?=
 =?us-ascii?Q?L0AjWABHlVKQ6yrm6hJsyMAn4zZhBJuiF796RyXGp2QIXKjeJfAV45b5frv0?=
 =?us-ascii?Q?JwvF/+TvHch3ZMhVXH3u9tLDoTFHrfXMrJ08svxBARh/h4ybs6BhhgGMhfI6?=
 =?us-ascii?Q?QPb8bZYC2lwNu8R2FBJd78Yw540Q2UR4pvRldkQualDatsN0Ze5Tfi1GJYw/?=
 =?us-ascii?Q?aOqUBvUPgaynwAQaExRAlpco8DXWVOoM/IykAilRT27Lg/oHvEoVJp58mwOw?=
 =?us-ascii?Q?D6Sk+LLqbuP/G32RHZwH9n7IcwOV2Rgizonj3wbnkcG48F6LYASLZKoAPafw?=
 =?us-ascii?Q?1tJ9oP7clFOIq6H9lXr3Ea0KsXqcja0c5EjCFh4p++sX/eMCNQAHF3zcFMIl?=
 =?us-ascii?Q?n2fqJzzhK9jDx9cG3+PPO4AJ2jLqv4lBW98q3Occh2OepcFfnYKhlibUeMQB?=
 =?us-ascii?Q?saLoUIUM4dQPhi85Cmq9TSWFsOhGGNYC3JpHLr839hGG8skD3MkfT+O7V+pz?=
 =?us-ascii?Q?LCjaD8inLTqZjChrbTwnrYXGxuYuyoAaCzbInhn49QP663PlCE1BuV1pR6KI?=
 =?us-ascii?Q?q0wGrRnUUuIMQNaMjikx/zhwUw3uPd5/P+SNJTpDqewYfv9QcbH/ZJHxcZpB?=
 =?us-ascii?Q?HCc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L9yKNqpRyVVznURSqjd36K4nPvSIcYMmIIJh6sX9zwDiw0y/S2cZ8rKYCteP?=
 =?us-ascii?Q?kB5EryJYk9obRnJF1J/G0HGvLhxrrt+f9jGgaxrC44NvY/1m7By3Yu727GXQ?=
 =?us-ascii?Q?3DV1hJbRY7A37Q38s1CuZKEzhTPRXXAA39aXnasdcd6uZAo1a9h285AEHjmD?=
 =?us-ascii?Q?z97EsrGwCo2xG4Wppwtcndeq5+89LmxbXFklvFK+pmOOwgKUXxpbG/Rl7lvn?=
 =?us-ascii?Q?sOZoNinu5yfw6tO6TwzLVF6H/UcDPeJ2p6CROJ3g2mIURvErodM2qB4y58+R?=
 =?us-ascii?Q?6cB6oOh75/2lZ9PKUeSjzB1Dmg4RVMGVxJ/8ehvsfRPErMw9c5sUc9Hp5vrM?=
 =?us-ascii?Q?F1vTwME1Csa8oQhEqn+7zppxAa2f7TjAcctHCbFN47G9cjkD6XvRhwsiRTyv?=
 =?us-ascii?Q?Tgre0+XRxarbOvQsoND5XDyzK4Ki/BGN5g2HDzJPmSroI8cAJRTex0YeDiRh?=
 =?us-ascii?Q?8QzPGi/+NLGnSBUZtdtEftOu8yBsO5PyIllC6d6f9TxKlr8Bjdbmss9uzjw/?=
 =?us-ascii?Q?85i0AVHFPmYEPjhg2LYgOkOoEspE86nyF75YIZHgGdiWADwIVN/y/WTsQG2c?=
 =?us-ascii?Q?0Xc1yf3yHamd9lxeKPrjr9hm+qRzZq/xYRdEwZrw4y40Ot4srTKUtocuqOQv?=
 =?us-ascii?Q?0+OsFJzMTleWqlLb334twO+U6p9ZJcsqb3AUFvjPVBZYA0dJXKB3+vgFn0RP?=
 =?us-ascii?Q?ppX+3ssoPRcxM/XpMoc2urZ+vSna73nO2HDuAd8NzGaofDlyPUDHnEJveqCF?=
 =?us-ascii?Q?moqaXKk+fAjGyWk8+2SkwSgJslsCXGqCy7HOOm6i2YGe8EUtho7+et/gvZKn?=
 =?us-ascii?Q?9gfGdzk5VZYyzrSNPw5uvUT9GWl/YVcss6UjmsCMioPwFP2gFF4eadpt9B0C?=
 =?us-ascii?Q?evQHUPPWagLOPw/BftrkLmLXdEwXi12vix2tO9R9j5UPFd4BnLVMZ/Be/7fC?=
 =?us-ascii?Q?RX7mytdEKSw5vJqk7AC887atYU/lfX7/XuQINBHEYr08MblokoP2rxVKWsjh?=
 =?us-ascii?Q?s+Nf9h4Sy58kYVKzYj0qxsU3DB/CJEHO3eYUPOiivn3Klu1gGkajzMUO37Zn?=
 =?us-ascii?Q?n1ONjCtHHDSK1PqPrQGTaTYltVoJuoiTY5jSWqq66zEEr00nVdEbK68PGVig?=
 =?us-ascii?Q?T+e+dNpbe3w63StUHCW0Hxn2nFl0dyAitoTVHiOmRopNgXfgUC3gEmjEdJPV?=
 =?us-ascii?Q?toTVQaKlrBdEL2JinDIPbPasgbTmEgkYS2gWoMQD/6dc9Wv2D6X2cZ4hAPaj?=
 =?us-ascii?Q?7PSb/cK5v+jhNFZLmgrpe7S+ph0s7wMRJ03SaoVTLVik6ZzXoY4m8FPLM8Zv?=
 =?us-ascii?Q?aegQtPYyb56YKPvbc1onz43YTnwawD45Svwi6XecAet3uLGg37SRWUrHAgdO?=
 =?us-ascii?Q?Z2qc42SVTHL/QkhBWMDg18acuEShaaeoonSebWKmixLLG73KUHRSaE1PusGX?=
 =?us-ascii?Q?yj+Ft4EhOyL/XzKJip1BNNM3yxmFE7rqUyqBqTuCfbw11u9f2r3ZlwOp9j4E?=
 =?us-ascii?Q?WkyVXUcItQAeJpGzLxvC70f33Qx8NMuxkBtl+8KlupJcUUwRQI68RMAz/qmT?=
 =?us-ascii?Q?lDSkQWXPCPFXKSWtS6q+OjG22IBHFr/wjF4VClPgpuEc3SUiBFX6dgrMC5e8?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7eefcc-a4e6-463d-14b0-08dcddd1d888
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 02:20:53.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y76bqV5lHKGvNmdwtZoA+R4vNy6VZpUcE787yVEJLoXJZtEem/xXqvxDE1DGA4Sn+N+7iioUNuu0UY/wZSzFUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6404
X-OriginatorOrg: intel.com

hi, David,

On Tue, Sep 24, 2024 at 10:47:30PM +0100, David Howells wrote:
> Does the attached fix the problem?

yes, as I've replied in
https://lore.kernel.org/all/ZvTD2t5s8lwQyphN@xsang-OptiPlex-9020/

thanks!

> 
> David
> ---
> netfs: Fix write oops in generic/346 (9p) and maybe generic/074 (cifs)
> 
> In netfslib, a buffered writeback operation has a 'write queue' of folios
> that are being written, held in a linear sequence of folio_queue structs.
> The 'issuer' adds new folio_queues on the leading edge of the queue and
> populates each one progressively; the 'collector' pops them off the
> trailing edge and discards them and the folios they point to as they are
> consumed.
> 
> The queue is required to always retain at least one folio_queue structure.
> This allows the queue to be accessed without locking and with just a bit of
> barriering.
> 
> When a new subrequest is prepared, its ->io_iter iterator is pointed at the
> current end of the write queue and then the iterator is extended as more
> data is added to the queue until the subrequest is committed.
> 
> Now, the problem is that the folio_queue at the leading edge of the write
> queue when a subrequest is prepared might have been entirely consumed - but
> not yet removed from the queue as it is the only remaining one and is
> preventing the queue from collapsing.
> 
> So, what happens is that subreq->io_iter is pointed at the spent
> folio_queue, then a new folio_queue is added, and, at that point, the
> collector is at entirely at liberty to immediately delete the spent
> folio_queue.
> 
> This leaves the subreq->io_iter pointing at a freed object.  If the system
> is lucky, iterate_folioq() sees ->io_iter, sees the as-yet uncorrupted
> freed object and advances to the next folio_queue in the queue.
> 
> In the case seen, however, the freed object gets recycled and put back onto
> the queue at the tail and filled to the end.  This confuses
> iterate_folioq() and it tries to step ->next, which may be NULL - resulting
> in an oops.
> 
> Fix this by the following means:
> 
>  (1) When preparing a write subrequest, make sure there's a folio_queue
>      struct with space in it at the leading edge of the queue.  A function
>      to make space is split out of the function to append a folio so that
>      it can be called for this purpose.
> 
>  (2) If the request struct iterator is pointing to a completely spent
>      folio_queue when we make space, then advance the iterator to the newly
>      allocated folio_queue.  The subrequest's iterator will then be set
>      from this.
> 
> Whilst we're at it, also split out the function to allocate a folio_queue,
> initialise it and do the accounting.
> 
> The oops could be triggered using the generic/346 xfstest with a filesystem
> on9P over TCP with cache=loose.  The oops looked something like:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000008
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  ...
>  RIP: 0010:_copy_from_iter+0x2db/0x530
>  ...
>  Call Trace:
>   <TASK>
>  ...
>   p9pdu_vwritef+0x3d8/0x5d0
>   p9_client_prepare_req+0xa8/0x140
>   p9_client_rpc+0x81/0x280
>   p9_client_write+0xcf/0x1c0
>   v9fs_issue_write+0x87/0xc0
>   netfs_advance_write+0xa0/0xb0
>   netfs_write_folio.isra.0+0x42d/0x500
>   netfs_writepages+0x15a/0x1f0
>   do_writepages+0xd1/0x220
>   filemap_fdatawrite_wbc+0x5c/0x80
>   v9fs_mmap_vm_close+0x7d/0xb0
>   remove_vma+0x35/0x70
>   vms_complete_munmap_vmas+0x11a/0x170
>   do_vmi_align_munmap+0x17d/0x1c0
>   do_vmi_munmap+0x13e/0x150
>   __vm_munmap+0x92/0xd0
>   __x64_sys_munmap+0x17/0x20
>   do_syscall_64+0x80/0xe0
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
> 
> This may also fix a similar-looking issue with cifs and generic/074.
> 
>   | Reported-by: kernel test robot <oliver.sang@intel.com>
>   | Closes: https://lore.kernel.org/oe-lkp/202409180928.f20b5a08-oliver.sang@intel.com
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: v9fs@lists.linux.dev
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/internal.h    |    2 +
>  fs/netfs/misc.c        |   72 ++++++++++++++++++++++++++++++++++---------------
>  fs/netfs/objects.c     |   12 ++++++++
>  fs/netfs/write_issue.c |   12 +++++++-
>  4 files changed, 76 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index c7f23dd3556a..79c0ad89affb 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -58,6 +58,7 @@ static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
>  /*
>   * misc.c
>   */
> +struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq);
>  int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio,
>  			      bool needs_put);
>  struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq);
> @@ -76,6 +77,7 @@ void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async);
>  void netfs_put_request(struct netfs_io_request *rreq, bool was_async,
>  		       enum netfs_rreq_ref_trace what);
>  struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq);
> +struct folio_queue *netfs_folioq_alloc(struct netfs_io_request *rreq, gfp_t gfp);
>  
>  static inline void netfs_see_request(struct netfs_io_request *rreq,
>  				     enum netfs_rreq_ref_trace what)
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 0ad0982ce0e2..a743e8963247 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -9,34 +9,64 @@
>  #include "internal.h"
>  
>  /*
> - * Append a folio to the rolling queue.
> + * Make sure there's space in the rolling queue.
>   */
> -int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio,
> -			      bool needs_put)
> +struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq)
>  {
> -	struct folio_queue *tail = rreq->buffer_tail;
> -	unsigned int slot, order = folio_order(folio);
> +	struct folio_queue *tail = rreq->buffer_tail, *prev;
> +	unsigned int prev_nr_slots = 0;
>  
>  	if (WARN_ON_ONCE(!rreq->buffer && tail) ||
>  	    WARN_ON_ONCE(rreq->buffer && !tail))
> -		return -EIO;
> -
> -	if (!tail || folioq_full(tail)) {
> -		tail = kmalloc(sizeof(*tail), GFP_NOFS);
> -		if (!tail)
> -			return -ENOMEM;
> -		netfs_stat(&netfs_n_folioq);
> -		folioq_init(tail);
> -		tail->prev = rreq->buffer_tail;
> -		if (tail->prev)
> -			tail->prev->next = tail;
> -		rreq->buffer_tail = tail;
> -		if (!rreq->buffer) {
> -			rreq->buffer = tail;
> -			iov_iter_folio_queue(&rreq->io_iter, ITER_SOURCE, tail, 0, 0, 0);
> +		return ERR_PTR(-EIO);
> +
> +	prev = tail;
> +	if (prev) {
> +		if (!folioq_full(tail))
> +			return tail;
> +		prev_nr_slots = folioq_nr_slots(tail);
> +	}
> +
> +	tail = netfs_folioq_alloc(rreq, GFP_NOFS);
> +	if (!tail)
> +		return ERR_PTR(-ENOMEM);
> +	tail->prev = prev;
> +	if (prev)
> +		/* [!] NOTE: After we set prev->next, the consumer is entirely
> +		 * at liberty to delete prev.
> +		 */
> +		WRITE_ONCE(prev->next, tail);
> +
> +	rreq->buffer_tail = tail;
> +	if (!rreq->buffer) {
> +		rreq->buffer = tail;
> +		iov_iter_folio_queue(&rreq->io_iter, ITER_SOURCE, tail, 0, 0, 0);
> +	} else {
> +		/* Make sure we don't leave the master iterator pointing to a
> +		 * block that might get immediately consumed.
> +		 */
> +		if (rreq->io_iter.folioq == prev &&
> +		    rreq->io_iter.folioq_slot == prev_nr_slots) {
> +			rreq->io_iter.folioq = tail;
> +			rreq->io_iter.folioq_slot = 0;
>  		}
> -		rreq->buffer_tail_slot = 0;
>  	}
> +	rreq->buffer_tail_slot = 0;
> +	return tail;
> +}
> +
> +/*
> + * Append a folio to the rolling queue.
> + */
> +int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio,
> +			      bool needs_put)
> +{
> +	struct folio_queue *tail;
> +	unsigned int slot, order = folio_order(folio);
> +
> +	tail = netfs_buffer_make_space(rreq);
> +	if (IS_ERR(tail))
> +		return PTR_ERR(tail);
>  
>  	rreq->io_iter.count += PAGE_SIZE << order;
>  
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index d32964e8ca5d..dd8241bc996b 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -250,3 +250,15 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async,
>  	if (dead)
>  		netfs_free_subrequest(subreq, was_async);
>  }
> +
> +struct folio_queue *netfs_folioq_alloc(struct netfs_io_request *rreq, gfp_t gfp)
> +{
> +	struct folio_queue *fq;
> +
> +	fq = kmalloc(sizeof(*fq), gfp);
> +	if (fq) {
> +		netfs_stat(&netfs_n_folioq);
> +		folioq_init(fq);
> +	}
> +	return fq;
> +}
> diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> index 04e66d587f77..0929d9fd4ce7 100644
> --- a/fs/netfs/write_issue.c
> +++ b/fs/netfs/write_issue.c
> @@ -153,12 +153,22 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
>  				loff_t start)
>  {
>  	struct netfs_io_subrequest *subreq;
> +	struct iov_iter *wreq_iter = &wreq->io_iter;
> +
> +	/* Make sure we don't point the iterator at a used-up folio_queue
> +	 * struct being used as a placeholder to prevent the queue from
> +	 * collapsing.  In such a case, extend the queue.
> +	 */
> +	if (iov_iter_is_folioq(wreq_iter) &&
> +	    wreq_iter->folioq_slot >= folioq_nr_slots(wreq_iter->folioq)) {
> +		netfs_buffer_make_space(wreq);
> +	}
>  
>  	subreq = netfs_alloc_subrequest(wreq);
>  	subreq->source		= stream->source;
>  	subreq->start		= start;
>  	subreq->stream_nr	= stream->stream_nr;
> -	subreq->io_iter		= wreq->io_iter;
> +	subreq->io_iter		= *wreq_iter;
>  
>  	_enter("R=%x[%x]", wreq->debug_id, subreq->debug_index);
>  

