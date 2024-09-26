Return-Path: <linux-fsdevel+bounces-30133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B42986ABE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 03:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4C81C2160C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 01:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95817108A;
	Thu, 26 Sep 2024 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiefU+nC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6FD45C14;
	Thu, 26 Sep 2024 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727315249; cv=fail; b=fRc7PokKA7x+sfwJzT1UJNS0xFKCSpuG8wVPdcI4J/ZZYBRLsYGOzGL7qqxqbT8OHIRfOo/3eEBe1x6pXcHdG6kx7InjJKCOvE6+lr9PbIIIKcDa+1yY8I7V3mm0GBEBM3pHf5/IXUwIu53Pw3+cXriLEo4vbu9p2eseQpV/T0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727315249; c=relaxed/simple;
	bh=qBIF9/+GSbMX07HgJJwOSLJTW4olbloY95BgZlbutI8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TvMi/g7Lt9kX0e/FSnZr3lAC0X91rGHPOQY/StnMXVvfBf6mz1Vl2zVDy1xmMj3ZMM8YBMz5PxJWulPjF6hSLe/go7MjiRg27Fywaf3OrlejaBWskRMtAJwjfSyKzODTeKu3DG+DkQLc+8vohoHD97aeRmGPMcr0wwXpMokwX3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiefU+nC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727315248; x=1758851248;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=qBIF9/+GSbMX07HgJJwOSLJTW4olbloY95BgZlbutI8=;
  b=BiefU+nCzhDbmAAp5MIvRe4zAnTk/3g0Y7SOP+VxjMcPCO/OZcsO0mXQ
   JEZetiZZvJs/RyCVvHCTgKvxyB72Y65KQ8Wjk6OATdBsWUPl4WNASuRlR
   yqfgL5RLZgxL5wCPVivyJLhxlvOMyzGgEJnP/h7W4gImNMph7via60J+2
   6fHOugVzJd4GrOzrP2io93PEbWXkJImwcS4YCSwfc6C4zJCZ0HJTZtpZY
   KPRpaSYh/LRRQwoWKQxd3GGeOOi2y4qm7kBSrs3annvRiVLqyGn76Bktu
   XQYzywg5nUm7QsV9TgMiew4poAInrmtcrWB8mBeNywuC+Phy1ttil7Dm1
   g==;
X-CSE-ConnectionGUID: JZ7M8i6DSKyWKiIXPpzP2A==
X-CSE-MsgGUID: mu2cIUAZR+WniPeSIz1JDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26488079"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="26488079"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 18:47:15 -0700
X-CSE-ConnectionGUID: 2Dwm3hzUQU2dfg5U+dNegw==
X-CSE-MsgGUID: MfjiyRtMT6W7OvaNaE8zKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="102728038"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 18:47:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 18:47:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 18:47:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 18:47:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 18:47:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 18:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvOtDzDY2IuAYbh5af1EcHjUCdIG9y0EU9rE7/Wts1FidAytPwAkn2SEMxcHHZUzitIBh5jEWUd+DTPFPVdVvjQdMflIG0sBG11GNZIIUVSTu3S+e45BqnYXMT2rcpOs0Rp+e9QXFyBV/8gbuLK+/a3QbSOnqtGW/o/O5RcZwddY2FicoYEvIVXS4MzmkKI4Pfnik10MeiNahVmpIzoOofdYe65hNthijpx7SeldaWJgQv+8aRInXSlwH+DsKNa21ZEyuzRl7rfY5jYs9Vp7FdG5nK9Zdts7KKMZm8Ps+JqVciRHqQa4idjhv3IZW69FnoJjZ56O4/jglW2EZJsSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOXzKvynoHmGkGThsz4hhjKkHrNV0mqo+JRK83zGsv0=;
 b=QT7VMabaZJI56jXau28C5D5/k3/m9gd3/qKXjEqDFOcZ59ACqE4GQE1DdTBTf0UFoDj8mTLrr+AcOXg2H1wDiGd7Uk/le/R36CcVf2mbhryHHOW7DSXsmPaUORT1decBZa6ssTKg6JHvG2tiB3LMpnXbKihp8NqnFgv0FYOT6XcPTCtWhlTOFS33zHYXASVPGt/WPYrwdljIGEmVmtrUOww9XdnolpT7SuWM2DaSqkTCNp7SPIaJ7qU61HB2DT4Miw4/ir+Dd4rKazKoZibZabADHv9awN5zIauIJuz1u/UTQ/5E1AbaNft7253LTI+VHDTilF/bghz/oGjsB/vXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 01:47:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 01:47:10 +0000
Date: Thu, 26 Sep 2024 09:46:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>,
	<linux-hardening@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] acl: Annotate struct posix_acl with __counted_by()
Message-ID: <202409260949.a1254989-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240923213809.235128-2-thorsten.blum@linux.dev>
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BY1PR11MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6522c1-f8d5-48ac-255a-08dcddcd22b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VsKYLWZNHte7qSxtKyJtebcz6hD5JZdT9RtEnJWEVDoVuX5F5xlPgCmeKypJ?=
 =?us-ascii?Q?10b6xTTSB78ciuZbAEWZHk2gEoibX3Og7fnlL7lknz4jpQwLgJaTthB5j3uk?=
 =?us-ascii?Q?T9Y0Ymah8B7sjCMLaXSLf60tsK4s/F13q5fGdWZZPySfwxggR09XkzIPkDlS?=
 =?us-ascii?Q?jLdHoSeMVwYVSn5rVwBVPcY8A3mKCUxcsyqCb0BFsh2LA+H0ihsbrsiq5HQq?=
 =?us-ascii?Q?veZ50UF8mZgOn03tTiU1AZAq8qxMmD4ivrd5FKfygxuh0H9i6DagyVhRSWHh?=
 =?us-ascii?Q?tzsfOrt/ku1H2SLCgteyTGJHT5hp8oSIBwSxEJxu8bEJolmzXiwdytdDOYO/?=
 =?us-ascii?Q?cN8eTFKD9SYqS3pzbGNSYxxYbcKo70aZPHPyFc+mW6X5w8A7EIM2n3RUwhOe?=
 =?us-ascii?Q?VwqhNeXk5FselZDVeND5oaJY2Qwu/v+BeA2sVWHawxZ3tHaj+NgD7QK67RS7?=
 =?us-ascii?Q?iVahZJQKhOlDnjauuMCDapj/bIwLp1VCjGG0hPo5+Fh13k9jcH7VMtl405iq?=
 =?us-ascii?Q?gg8Vjl98Ie6edSQ1qPyKFdx+DG5IPyH0b7xkL5QvY7/olA51GOD6hNmCzLtr?=
 =?us-ascii?Q?VsRceqsnn/JKJsYKquJtnnWOv2g6l/ZZKpM/50IkTebrrAtP3jS9bPARlHbT?=
 =?us-ascii?Q?l5FGCDmkf3parRleQoQIR2nHz4DFsbZ11ettBm8MAx15Ci9s5tJj/a0B4P9G?=
 =?us-ascii?Q?D9namE1cCN8YUf/e6nCGvl+5VbXpD8Kn2hAgKb5FIXVMHNaX9dYzA3rD3iRL?=
 =?us-ascii?Q?ovKyUgEP91ChJxXnbS7gR2bA6NOI1Pk8QMwC708uoc3OICHHzOEVGdObz9pv?=
 =?us-ascii?Q?NmU1zIRGCHvrg7FOoL/RsU52GRcB9LV8q5t4XFORC1HTYXYj4fIp4EecnfHa?=
 =?us-ascii?Q?x36l/mTrT3prMmfJW18IP7EsgTkdWBvR1KvCWoamSMwxcyiUNAp/fM77CnuL?=
 =?us-ascii?Q?o3A3UnhF8wf/4Gb/AQZ81I2glV8PnjwvOh3OGmSqf7Z57atDPKGeSKZaYaMh?=
 =?us-ascii?Q?X10GCKiIzDSEAKtcJEzVz6j5mh2pJQcGE79rBN6Yo0JgSk/zdwc79EzIBdP1?=
 =?us-ascii?Q?kqlY0RkpC25/4ESEOPtEIOahtmAW6ea+zZxu/oe3/Q16UPEIwvdiyJT2quez?=
 =?us-ascii?Q?QCKVDGWWFkgecIdkiMZZk/BNk8tj2WzN5nVtja/fd14mG+HvhYZoKB8Yq8PT?=
 =?us-ascii?Q?TV/8ZP+Kl98HqrHA7EtE+hEDwMWwa/vnbEThWg16Nh3nifk+B0AQ6NNbESw/?=
 =?us-ascii?Q?ZaBIgXrqjs+Y1Pj/mGC6tWf8obVQdwU/67Q6Rh9DPtlY73TiM4szjyZJ6Xga?=
 =?us-ascii?Q?//A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TX56Vot1n9vXrDeQwdGz4qiZnI78VMPK1JD3Ij/snIp4enacQOIZ0hYtdFCI?=
 =?us-ascii?Q?KP18feGF9+17jAR6IOmjHa7j+DKBPRlYAy5BFB6BYVlWrXgXNz2CbF3Evfbz?=
 =?us-ascii?Q?/T28RsDSt1cqfCyGn5fxhcHtBo2dXn5E57WSkZFUeVRT1uPmYP6rdZPSAsKt?=
 =?us-ascii?Q?gukTX2Jd5iPYvGK++MGG5yvxS8X+2t4xXJPp+zyVclMW9Zmu7QCcVIOr2MO2?=
 =?us-ascii?Q?BehoB9Az4S8wOinT5dMw7ZnrBatm32D1iQgpM0npx1DODT3rQmbUpfrFXdmC?=
 =?us-ascii?Q?yrYfmmcLG9G3NdWOP7MEVm6g4D2HXOIIKLxTCv1c0uJmdiiK65K9ct0oswSf?=
 =?us-ascii?Q?9ljk2D7hUBNbQunuh2pKJcAdeANzE+gfIRu3cQ3v8YYKXs7w668X3ikzj1sv?=
 =?us-ascii?Q?Q75NfurvPEiPCDrg/bQaT8y4KvUk3T5K7t3y9xKjubMDQGwEXvMlzLg0HrbG?=
 =?us-ascii?Q?91m47WOvgk0TNbslO10DIC6G4cFKWkVEp8eBH1Wt4bzmbpSPWe3kfTWoxp3E?=
 =?us-ascii?Q?EGFAIGBegAathN/mQLDtjsYs8trn3N4yz4ZW0mw1KYJSsi0wwhQ4+a4wkddH?=
 =?us-ascii?Q?mRBRPGiq9XI9GDZ0fI9696JAMh/63PjlT6NH/1R9idJycJcIqxyNu2aizdhZ?=
 =?us-ascii?Q?AwVTTSFalPEsF9HLHJbp8GbI/OzD65jvc9RSw7SME/Idi54zX5ShayyL5BnY?=
 =?us-ascii?Q?47qtqu3HQ5z4S4YBmsBpaBnCa60Q4XKd42jULYyfODC1rC/8qnvvUusk/HGv?=
 =?us-ascii?Q?PgW7wWe7hcrGYAlqpL2hspABSV0CtBMW8uPV56NS5TVydPCBFensO4s7tfDO?=
 =?us-ascii?Q?usEL1nqOeEDQ4s4NROjx9+pubiBd7b5B74DGnsCl18Bb0M5e22xuGDuSvcNv?=
 =?us-ascii?Q?dCj6ABNluePO+R9Bb1uCDHQ+SscbahvM1SyxoHoA3YJ3ToRkcdP8nrtPuMer?=
 =?us-ascii?Q?Ona7VdXurmk5KVqD0XQDRT5nFvyw3yN6zHIVnfb6V8k79o9yDsA3odhK0oW4?=
 =?us-ascii?Q?1njmS1TfcccADmna/fMmNFfYYE4FwmsdgGiNK6yPCKeCpDDwbjQe8EXd9MuS?=
 =?us-ascii?Q?dThei9kThwf598DawIIcp6bYTwZmgi1IOIO24uQYzTb+RD7m57G4Quhh4ZY6?=
 =?us-ascii?Q?zQiBBjlhJSRH3K961Fk0SopvYjlfea5+2wQc17vluyGgJ9aI9AGmjcuQpV4P?=
 =?us-ascii?Q?zWpDUdLfks42/FM8PZK0Pt1dgfknr5DQ9uri5zj0A01TkdCeT7S5DkfSPUP8?=
 =?us-ascii?Q?isVA5g/kox7nxtYtuLtzA5/L+o/+hhxWutIxuQtyMm7EMbdj6c/AfQivXot3?=
 =?us-ascii?Q?ZUWO+nnpX5VC4HlVoiFr2d1s4nu/71K3J+wubLEcrt607qKuYD/wUu/rbmtg?=
 =?us-ascii?Q?/ksU7BlKp1mdP8HiLLGij0HQJhyjl/88iGFcu584hfJbt+MqZq4unEvDKIW/?=
 =?us-ascii?Q?KnPAUbVdmODE5nTLKDy3w6fzT67wxyZy+qBK/8CgfqhgziVvcIVdUVqPpxTT?=
 =?us-ascii?Q?BRfkWm8G/+0j2HVz1m6bkzKcDWyRFbz9izeYQCofonB8hipI3T0XmYgkcaIG?=
 =?us-ascii?Q?44/9PFHJctrwQkRre2CcCxlJnUHkinpmupG0QbMP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6522c1-f8d5-48ac-255a-08dcddcd22b2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 01:47:10.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4zp3V8rTTeECJGK0X8SzZBcvb/dWrppWKfq543SJ8nbvyPGciwRyuktCz/gq8K/zP0BkvsrZG5vi/0fmwsH+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_lib/string_helpers.c:#__fortify_report" on:

commit: 3d2d832826325210abb9849ee96634bf5a197517 ("[PATCH] acl: Annotate struct posix_acl with __counted_by()")
url: https://github.com/intel-lab-lkp/linux/commits/Thorsten-Blum/acl-Annotate-struct-posix_acl-with-__counted_by/20240924-054002
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20240923213809.235128-2-thorsten.blum@linux.dev/
patch subject: [PATCH] acl: Annotate struct posix_acl with __counted_by()

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------+------------+------------+
|                                                   | c72f8f06a2 | 3d2d832826 |
+---------------------------------------------------+------------+------------+
| boot_successes                                    | 18         | 0          |
| boot_failures                                     | 0          | 18         |
| WARNING:at_lib/string_helpers.c:#__fortify_report | 0          | 18         |
| RIP:__fortify_report                              | 0          | 18         |
| kernel_BUG_at_lib/string_helpers.c                | 0          | 18         |
| Oops:invalid_opcode:#[##]KASAN                    | 0          | 18         |
| RIP:__fortify_panic                               | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception          | 0          | 18         |
+---------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409260949.a1254989-oliver.sang@intel.com


[   25.825642][  T121] ------------[ cut here ]------------
[   25.826209][  T121] kmemdup: detected buffer overflow: 72 byte read of buffer size 68
[ 25.826866][ T121] WARNING: CPU: 0 PID: 121 at lib/string_helpers.c:1030 __fortify_report (lib/string_helpers.c:1029) 
[   25.827588][  T121] Modules linked in:
[   25.827895][  T121] CPU: 0 UID: 0 PID: 121 Comm: systemd-tmpfile Not tainted 6.11.0-rc6-00294-g3d2d83282632 #1
[   25.828870][  T121] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 25.829661][ T121] RIP: 0010:__fortify_report (lib/string_helpers.c:1029) 
[ 25.830093][ T121] Code: f6 c5 01 49 8b 37 48 c7 c0 00 8a 56 86 48 c7 c1 20 8a 56 86 48 0f 44 c8 48 c7 c7 80 87 56 86 4c 89 f2 49 89 d8 e8 d1 37 dd fe <0f> 0b 5b 41 5e 41 5f 5d 31 c0 31 c9 31 ff 31 d2 31 f6 45 31 c0 c3
All code
========
   0:	f6 c5 01             	test   $0x1,%ch
   3:	49 8b 37             	mov    (%r15),%rsi
   6:	48 c7 c0 00 8a 56 86 	mov    $0xffffffff86568a00,%rax
   d:	48 c7 c1 20 8a 56 86 	mov    $0xffffffff86568a20,%rcx
  14:	48 0f 44 c8          	cmove  %rax,%rcx
  18:	48 c7 c7 80 87 56 86 	mov    $0xffffffff86568780,%rdi
  1f:	4c 89 f2             	mov    %r14,%rdx
  22:	49 89 d8             	mov    %rbx,%r8
  25:	e8 d1 37 dd fe       	call   0xfffffffffedd37fb
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	5b                   	pop    %rbx
  2d:	41 5e                	pop    %r14
  2f:	41 5f                	pop    %r15
  31:	5d                   	pop    %rbp
  32:	31 c0                	xor    %eax,%eax
  34:	31 c9                	xor    %ecx,%ecx
  36:	31 ff                	xor    %edi,%edi
  38:	31 d2                	xor    %edx,%edx
  3a:	31 f6                	xor    %esi,%esi
  3c:	45 31 c0             	xor    %r8d,%r8d
  3f:	c3                   	ret

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	5b                   	pop    %rbx
   3:	41 5e                	pop    %r14
   5:	41 5f                	pop    %r15
   7:	5d                   	pop    %rbp
   8:	31 c0                	xor    %eax,%eax
   a:	31 c9                	xor    %ecx,%ecx
   c:	31 ff                	xor    %edi,%edi
   e:	31 d2                	xor    %edx,%edx
  10:	31 f6                	xor    %esi,%esi
  12:	45 31 c0             	xor    %r8d,%r8d
  15:	c3                   	ret
[   25.831566][  T121] RSP: 0018:ffffc90001e6f8a0 EFLAGS: 00010246
[   25.832052][  T121] RAX: 0000000000000000 RBX: 0000000000000044 RCX: 0000000000000000
[   25.832705][  T121] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   25.833348][  T121] RBP: 000000000000001c R08: 0000000000000000 R09: 0000000000000000
[   25.833964][  T121] R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff920003cdf27
[   25.834570][  T121] R13: dffffc0000000000 R14: 0000000000000048 R15: ffffffff86568730
[   25.835152][  T121] FS:  00007f994a290440(0000) GS:ffffffff87eba000(0000) knlGS:0000000000000000
[   25.835834][  T121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.836385][  T121] CR2: 0000561875daa188 CR3: 0000000160dd0000 CR4: 00000000000406f0
[   25.837005][  T121] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   25.837609][  T121] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   25.838212][  T121] Call Trace:
[   25.838482][  T121]  <TASK>
[ 25.838717][ T121] ? __warn (kernel/panic.c:242) 
[ 25.839053][ T121] ? __fortify_report (lib/string_helpers.c:1029) 
[ 25.839436][ T121] ? __fortify_report (lib/string_helpers.c:1029) 
[ 25.839816][ T121] ? report_bug (lib/bug.c:?) 
[ 25.840206][ T121] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 25.840551][ T121] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 25.840932][ T121] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 25.841336][ T121] ? __fortify_report (lib/string_helpers.c:1029) 
[ 25.841732][ T121] __fortify_panic (lib/string_helpers.c:1037) 
[ 25.842094][ T121] __posix_acl_chmod (include/linux/fortify-string.h:751) 
[ 25.842493][ T121] ? make_vfsgid (fs/mnt_idmapping.c:122) 
[ 25.842837][ T121] ? capable_wrt_inode_uidgid (include/linux/mnt_idmapping.h:193 kernel/capability.c:480 kernel/capability.c:499) 
[ 25.843285][ T121] posix_acl_chmod (fs/posix_acl.c:624) 
[ 25.843671][ T121] shmem_setattr (mm/shmem.c:1240) 
[ 25.844039][ T121] ? ns_to_timespec64 (include/linux/math64.h:29 kernel/time/time.c:529) 
[ 25.844456][ T121] ? inode_set_ctime_current (fs/inode.c:2331) 
[ 25.844894][ T121] ? shmem_xattr_handler_set (mm/shmem.c:1173) 
[ 25.845322][ T121] ? rcu_read_lock_any_held (kernel/rcu/update.c:388) 
[ 25.845736][ T121] ? security_inode_setattr (security/security.c:?) 
[ 25.846157][ T121] ? shmem_xattr_handler_set (mm/shmem.c:1173) 
[ 25.846582][ T121] notify_change (fs/attr.c:?) 
[ 25.846952][ T121] chmod_common (fs/open.c:653) 
[ 25.847315][ T121] ? __ia32_sys_chroot (fs/open.c:637) 
[ 25.847709][ T121] ? user_path_at (fs/namei.c:3019) 
[ 25.848068][ T121] ? kmem_cache_free (mm/slub.c:4474) 
[ 25.848489][ T121] do_fchmodat (fs/open.c:701) 
[ 25.848842][ T121] ? do_faccessat (fs/open.c:686) 
[ 25.849210][ T121] ? print_irqtrace_events (kernel/locking/lockdep.c:4311) 
[ 25.849640][ T121] __x64_sys_chmod (fs/open.c:725 fs/open.c:723 fs/open.c:723) 
[ 25.850010][ T121] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 25.850371][ T121] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:?) 
[ 25.850790][ T121] ? tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:?) 
[ 25.851208][ T121] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:?) 
[ 25.851621][ T121] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:619) 
[ 25.852040][ T121] ? print_irqtrace_events (kernel/locking/lockdep.c:4311) 
[ 25.852522][ T121] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 25.852917][ T121] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 25.853285][ T121] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 25.853667][ T121] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 25.854053][ T121] ? exc_page_fault (arch/x86/mm/fault.c:1543) 
[ 25.854445][ T121] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   25.854921][  T121] RIP: 0033:0x7f994adcdc47
[ 25.855282][ T121] Code: eb d9 e8 9c 04 02 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 5f 00 00 00 0f 05 c3 0f 1f 84 00 00 00 00 00 b8 5a 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 a1 0d 00 f7 d8 64 89 01 48
All code
========
   0:	eb d9                	jmp    0xffffffffffffffdb
   2:	e8 9c 04 02 00       	call   0x204a3
   7:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   e:	00 00 00 
  11:	66 90                	xchg   %ax,%ax
  13:	b8 5f 00 00 00       	mov    $0x5f,%eax
  18:	0f 05                	syscall
  1a:	c3                   	ret
  1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  22:	00 
  23:	b8 5a 00 00 00       	mov    $0x5a,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 89 a1 0d 00 	mov    0xda189(%rip),%rcx        # 0xda1c3
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 89 a1 0d 00 	mov    0xda189(%rip),%rcx        # 0xda199
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240926/202409260949.a1254989-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


