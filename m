Return-Path: <linux-fsdevel+bounces-19470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAF98C5C53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 22:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78021C2193B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FD81DFFC;
	Tue, 14 May 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3WrMlBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1BC1DA2F
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718761; cv=fail; b=pZj0vMQN2q2ng3vz2RUiLgdoJZFeJcyVQgFl+xPEIB3M2ErfA2Y7+ayDnm8ZRPa/R2vnxxiJhSWjBGVMhGForybKYHjeW7s6DIWZ1i2ZM4Bj+M6bc6ay6s9h9Xu3YGrmEpa4iW+2kcJgm1RTn8VMRpqPkCsnIn1B6uGiCq99Znk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718761; c=relaxed/simple;
	bh=emPM8KaqAZ4N/acG4d1XYngDWCsCQTWUJs7KuLQdQ1o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cm3ZvladzGMYo6CgNkrro/q31brc3AsxT0zuMgom0vf5Ve/NRM5tsW0oekEEN4r0gw/PLLf1ookW0yMiee43SPTV3P8xolWg5IQjGa9tPUoihMfnn6V1lrTZ5IXC0YCfKNOT9AzOXVqjS3LRpqhpR9bWfWRWgJZ3Agq/VSWCEQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3WrMlBI; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715718760; x=1747254760;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=emPM8KaqAZ4N/acG4d1XYngDWCsCQTWUJs7KuLQdQ1o=;
  b=Y3WrMlBIpBRD/cyS8Z0PhqDKUiV9KCiu6VuGDAWVqItFuWP/odFDM4WP
   Wyn+i+V2FKfGITVF8e3+2jg5SrpskvZG1kozfuPfPus6x69nlrNyW1o3k
   9rhdqN4SSF6VKtz/hcZoGOjA7iq9VDK4RMGF69O7lAYXpQsEdhNdPbDeQ
   hO6v8rRZhygMXLwoPE3sNRHau2qs7euS3g68Jm61AkaGNUq4n2CV2uD6p
   4EEhVLAMhSSyYqDE3d4NMwbDwQ3DBJxpc7ffn3ASbYCza8gHwegtHql2q
   Ppp4xA3/xccS7XW/GEhCz2dPOCqxdHYpHPd5Ask7xOIKhqN/7JNKKgQM/
   Q==;
X-CSE-ConnectionGUID: 7XOOzBUiSxqhQJRJWuzJtA==
X-CSE-MsgGUID: FV/x51AlQQS3fY/abSGr5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11851473"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11851473"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 13:32:39 -0700
X-CSE-ConnectionGUID: /C6SmXKRSTOhpfiP/Ak3fw==
X-CSE-MsgGUID: ItkZy9mjRQSBnlmky0BRnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35335105"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 13:32:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 13:32:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 13:32:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 13:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYcfnq8l/i5JDRrz51/Ca7h9HYYgdy9AcY8zPp5VDYgfVNaWSLQlyddYjUWejwIo/cm0Ms0Nh60uCL6a2UJ0r0OgsmSKBh/XjUYLZvp95OhR52pMg/CJEx2Hmd6EBnebzz3ymiIl5MgU7xj2aN00Bjo2rJtotDFb6vIHBPEwp53pwMGhRLaubGiKE6WVHF9XX1LXoXHCsx1PgZw0H3cs/SDyNqQRsg3VLXBP/b9Ru4Oy11iTJPSoIdgUW0WcKQUBTpu7lGRcWiujzaY6Dy8A1Hbx8tg+XQPN8FIfwNECyypV4yaupLM7iZlY0RdLPtLZBK7Nt+uElphB5xLyu/Nbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cwgAjNgZZXKKXXkfFFYZJ7s/H0yfI7U6pHyIF/jaDY=;
 b=LpjCXbextLpPP3dYEqlwoLGjJpFYpqeSRyVJtTSZINhiYZWAcFRxOcGJv6S6H3kW4SZOy4cGk9qQElqRa6OjwcrutxGKIGw0Nz4B9+Wu58UOs9ciz4Cq+X3oz9Art+P0A7AobhjTCyraq/FzQxj8M9CsbigGUP34AbIC5Bn2WAWXug/QPExuHkWTba/Elt1PZbe1JS0rFxCdf5hZhngN7VqPSUk2mFmM9zQN3q7qebn43ZFxBojvwiYw+SyggbdxgXfKCLZ8zUYv4kNclgZnOu2tkou4QzkIDfku0Vyc6YgVRubLjCJ1Dw/JLcm79ho1/iTOk+7Xk1FGVaVXxSq+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 20:32:30 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 20:32:30 +0000
Date: Tue, 14 May 2024 20:31:47 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: John Harrison <john.c.harrison@intel.com>
CC: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	<intel-xe@lists.freedesktop.org>, Lucas De Marchi <lucas.demarchi@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/xe/guc: Expose raw access to GuC log over debugfs
Message-ID: <ZkPKM/J0CiBsNgMe@DUT025-TGLU.fm.intel.com>
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
 <20240512153606.1996-5-michal.wajdeczko@intel.com>
 <d0fd0b46-a8ac-464b-99e7-0b5384a79bf6@intel.com>
 <83484000-0716-465a-b55d-70cd07205ae5@intel.com>
 <3127eb0f-ef0b-46e8-a778-df6276718d06@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3127eb0f-ef0b-46e8-a778-df6276718d06@intel.com>
X-ClientProxiedBy: BYAPR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::42) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ0PR11MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a13c861-e888-43f6-a8c1-08dc7454fa34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kiaky2l75NuDPWwwJuXe4gwOaHCPlUyCjsGgemag7BRBRBUg2mKlAzDifk?=
 =?iso-8859-1?Q?6Ozj2X8rgIF+as+mpEw6CKepaJ3+3O0utVLSFZhC/spusI1DQJG2rHl+7C?=
 =?iso-8859-1?Q?YzSY/RArmdFLVNYjFET81bjG3ke8OWIThkeWrAGLydh8kxvO9r1UJmyww9?=
 =?iso-8859-1?Q?vZJPjuB69qSuAPFo3kkd18zj+1Lb7I3tl+6Pr2PBmtSfNs7QWpfTlRochD?=
 =?iso-8859-1?Q?KhYh5y01o/QhwwfdmuMAHMsMSFRQnwn6FNL/Dqv10Al+SMS8gwuNBt3TSd?=
 =?iso-8859-1?Q?7EqL/MhCGcHVGR1PEGwDE3YeZVsiWyl3VuPGaP4aBo+xb5EaEdtbyxZv8H?=
 =?iso-8859-1?Q?RUQJZrqFgwTqOBe+/FsIHTlbVIUqQGe9wx9Fa5MTee3dkAafoCVWKWGMDZ?=
 =?iso-8859-1?Q?e3hRKLWW/n5hU7kKdqEiTtqfCdD3Zw7Juct3xAO+LzeWAjVE1zIj8yFrez?=
 =?iso-8859-1?Q?q1++D02vfULJOkaomtY2aP3rA6MBHlpkT4R92yIzpUHVdVwoNjYjD57kfM?=
 =?iso-8859-1?Q?24BDaiG2Aeo4VnbtaunxqSdq74jzkPX7lPmN/4tU4IuWAzgzBgVstXKdzO?=
 =?iso-8859-1?Q?j2fztjpN2e+0oFSsJB35gGhIhtvuMUH8wRvghfwCyZwNeF30uYHy9ZVc5f?=
 =?iso-8859-1?Q?Z7KUcBG0BREkjaZQ0xr+++sjwwGWss1DyNjUBxtN5/fp+z9j1GSapa6ed1?=
 =?iso-8859-1?Q?dNo1rjkUTbW5esbonRuH2rMHroEDvZBrJGFefu8GLm7dLfCfa3RlEhH/EB?=
 =?iso-8859-1?Q?3cS2SFq1ME4UesAnN+IZrkcFKl2QmG2VTMeEidvLPRQhW+Ls3ete7WraBX?=
 =?iso-8859-1?Q?nLbYT2VrtNjhNhfVpd2DPcFei063RRUJZPrmWThco8pWfyieOOWInqM776?=
 =?iso-8859-1?Q?r9JDu0jYs4quOHv3e1wi/itlW8zeDg4wK6aTVK0mZqWgoGsF1pgOfy5hvB?=
 =?iso-8859-1?Q?NrtcaTjukm8RrbbBryLoKYnmKV078Rrc+Ir17A1Ldx4urqTDXln5lTZIgg?=
 =?iso-8859-1?Q?F4mptS5JkNP15MAQZtmX/5YRndtDyoBIZc8pYAWO+3qoZGCsDuDx79zrbo?=
 =?iso-8859-1?Q?8Qkqtx+9uQ2CNakiHrUWB/jB202+Q5tEkp4hATwy6cJ4gtg/S70cW/yMQH?=
 =?iso-8859-1?Q?/Hgt5vlIhKak02VhOjLjUpvJy/Xy8TQ9/CEw2TTDA24YpeR5dnkn1RDjpn?=
 =?iso-8859-1?Q?hnjx96UlQeBhjXJpVTaPLkXAJHiF5/IOy3VtvtpAC0vNXb6L45yaO99Axx?=
 =?iso-8859-1?Q?J94xMmMazYt7/FtdLu13gqMjU85eyF3yL3CkdkLlE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uMKYV70ZljdUsgG/8GarNM9B5mo1mVfhoJC80mHxxkK8QQYQjtBck8oyIY?=
 =?iso-8859-1?Q?+HqZdtztYlhXkF7/Dn7GChCpmm7TYyONA4E+Rv6Kw9H+VlJfiBaJ3ioW/V?=
 =?iso-8859-1?Q?ABz81E6PN0UM/+9X3iOkU/LtygfCS2a2epfKTTvIcDPQV1y9BOfFLFYP6q?=
 =?iso-8859-1?Q?uohR9KJCV+uSB/nTKX/wuF4EaaAyH7RwE1qsNBO0QkO9Su26ccZZliM33b?=
 =?iso-8859-1?Q?A4f6F9DTlZNLl6D3Kzt1hQzj2+kBSN7ZJIahyMS3pF8gyW01N8kFrsa+87?=
 =?iso-8859-1?Q?QYcsEvy3DaT2zkqvKOea5pXZHaoqB+o7Ta4DTG7UGTjuXgJgNoV4Eh+3VK?=
 =?iso-8859-1?Q?Bf4OkQ20Ste94SBE2Fg/hlicp6bdGT0+9+eBAsQdsEyXBsDrg2GC7TtrJR?=
 =?iso-8859-1?Q?14J/+JKrIEZCKw1U/0/UCboGOu/hTjJTdBnwilSKOF/7h9NKo6f2j+tsqj?=
 =?iso-8859-1?Q?br2mznekiFT6hJCq/fwrNauURXgySCLyD6W0A+HOpMiFCr9A8+iK0J7i6w?=
 =?iso-8859-1?Q?BivBb6CJ4KkGAaYBz/QzeGek1XH/1Y06FHmvrvULuxxGs94XIGgXbsm0L/?=
 =?iso-8859-1?Q?Orbp7BCJcXW2bY6Y9cjB/sNi0tjscsuHGOjG2U4ktr/JUWvbdzVUwZJ/AG?=
 =?iso-8859-1?Q?pM+zgUR7HmEMMKzRR9c1bGq2DxS4bwNNyCVgmtlA9nXLUhtxTCzZ1rJ8nL?=
 =?iso-8859-1?Q?Hoa/YYBfJ7CyyNI+WGh51fZGreUeQlL6ynL0xczmoGSpSS+Qs6JafxuSB6?=
 =?iso-8859-1?Q?Bln0487LYP3X1ti6tIRz4mqf1p3tj6n6GM6r4D6rmfWIuFFhUmMrFDsLgG?=
 =?iso-8859-1?Q?oYfg8PvYbc0k14WKIzEBmgUsdzaPPj0rXtMPVWM0gdvc11H7gxGJx75YUG?=
 =?iso-8859-1?Q?7Vaq3a0JrbstfNwEQwipCR2p18L3RlzMLTlMmJQ0HvvZ7+riOyB0kN2uuu?=
 =?iso-8859-1?Q?GcTex8nLx3ZYcM/EQLIm+DWW5CjyzVJ02d8PFK4Qj+IpFoq13Rq3jmy4Yi?=
 =?iso-8859-1?Q?8KG1I4BtIIDgotTXQt+K/p7oN33Lm9CuJLlud8khiVchx/aVJtiR0xpRHw?=
 =?iso-8859-1?Q?CAl7uImiJwRVDH0N9LFoDf//nYq9FZ5hHQUlqyUvmgtKgDVzq0tRyeplmz?=
 =?iso-8859-1?Q?W2qeR81NF+K2dD/NTfCUwnZ+WFp9oh9Q8XD5dEYIxbDtHnvFCyoYksd0gN?=
 =?iso-8859-1?Q?Lc4oTNqEtCGQmPHBoW4EO8Cl1WwBJSJ36Kc8jy/WvIlKf9KCv+ciYagwYV?=
 =?iso-8859-1?Q?D+xKkGIpJgsrfUlHEHDJH2Iq1ZuNa2bHoMyzDnt7r/vhUP38IM9j2THD/7?=
 =?iso-8859-1?Q?eK2ov6bBjn/KmCoctDBf8cUGXIuxSYMXRNqBgVrQg9OxJSVhKA15pcS/4/?=
 =?iso-8859-1?Q?5yHCgtqO4D/af8iRars8oHAIFaewW+3rktBhP5D411zKOJulJPdd+KmOAS?=
 =?iso-8859-1?Q?MBpyJgSbsgyfcclBjxFQEFtyk4qabp3sgMPdFdwD8my3Ih77jNGNx6+rmY?=
 =?iso-8859-1?Q?tDTHPVjr6y55h3PnYdBBzExQvZxNh/m8un8QrB6T0y6dJkUOP7+RW20pmG?=
 =?iso-8859-1?Q?7EhJYOYzd53e/PSSTz8QJEXvqqVA/3pg9nPL3KcTdhfNGNq4rlYHnTzJXT?=
 =?iso-8859-1?Q?9sO6cf0mKAGs+7hGo5g1dnbctTV0RVBRJEX66vH/yorqRFU/9EgNNrTQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a13c861-e888-43f6-a8c1-08dc7454fa34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 20:32:30.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5pu8WCkTc63GM4bsrmWkHTLTgneJJGKLqmZ3K1E8V9lfCHs6pTkq1N24Me79UiB2vM7ODeKd0hP7r4dovTgTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
X-OriginatorOrg: intel.com

On Tue, May 14, 2024 at 11:13:14AM -0700, John Harrison wrote:
> On 5/14/2024 07:58, Michal Wajdeczko wrote:
> > On 13.05.2024 18:53, John Harrison wrote:
> > > On 5/12/2024 08:36, Michal Wajdeczko wrote:
> > > > We already provide the content of the GuC log in debugsfs, but it
> > > > is in a text format where each log dword is printed as hexadecimal
> > > > number, which does not scale well with large GuC log buffers.
> > > > 
> > > > To allow more efficient access to the GuC log, which could benefit
> > > > our CI systems, expose raw binary log data.  In addition to less
> > > > overhead in preparing text based GuC log file, the new GuC log file
> > > > in binary format is also almost 3x smaller.
> > > > 
> > > > Any existing script that expects the GuC log buffer in text format
> > > > can use command like below to convert from new binary format:
> > > > 
> > > >      hexdump -e '4/4 "0x%08x " "\n"'
> > > > 
> > > > but this shouldn't be the case as most decoders expect GuC log data
> > > > in binary format.
> > > I strongly disagree with this.
> > > 
> > > Efficiency and file size is not an issue when accessing the GuC log via
> > > debugfs on actual hardware.
> > to some extend it is as CI team used to refuse to collect GuC logs after
> > each executed test just because of it's size
> I've never heard that argument. I've heard many different arguments but not
> one about file size. The default GuC log size is pretty tiny. So size really
> is not an issue.
> 
> > 
> > > It is an issue when dumping via dmesg but
> > > you definitely should not be dumping binary data to dmesg. Whereas,
> > not following here - this is debugfs specific, not a dmesg printer
> Except that it is preferable to have common code for both if at all
> possible.
> 
> > 
> > > dumping in binary data is much more dangerous and liable to corruption
> > > because some tool along the way tries to convert to ASCII, or truncates
> > > at the first zero, etc. We request GuC logs be sent by end users,
> > > customer bug reports, etc. all doing things that we have no control over.
> > hmm, how "cp gt0/uc/guc_log_raw FILE" could end with a corrupted file ?
> Because someone then tries to email it, or attach it or copy it via Windows
> or any number of other ways in which a file can get munged.
> 
> > 
> > > Converting the hexdump back to binary is trivial for those tools which
> > > require it. If you follow the acquisition and decoding instructions on
> > > the wiki page then it is all done for you automatically.
> > I'm afraid I don't know where this wiki page is, but I do know that hex
> > conversion dance is not needed for me to get decoded GuC log the way I
> > used to do
> Look for the 'GuC Debug Logs' page on the developer wiki. It's pretty easy
> to find.
> 
> > > These patches are trying to solve a problem which does not exist and are
> > > going to make working with GuC logs harder and more error prone.
> > it at least solves the problem of currently super inefficient way of
> > generating the GuC log in text format.
> > 
> > it also opens other opportunities to develop tools that could monitor or
> > capture GuC log independently on  top of what driver is able to offer
> > today (on i915 there was guc-log-relay, but it was broken for long time,
> > not sure what are the plans for Xe)
> > 
> > also still not sure how it can be more error prone.
> As already explained, the plan is move to LFD - an extensible, streamable,
> logging format. Any non-trivial effort that is not helping to move to LFD is
> not worth the effort.
> 
> > 
> > > On the other hand, there are many other issues with GuC logs that it
> > > would be useful to solves - including extra meta data, reliable output
> > > via dmesg, continuous streaming, pre-sizing the debugfs file to not have
> > > to generate it ~12 times for a single read, etc.
> > this series actually solves last issue but in a bit different way (we
> > even don't need to generate full GuC log dump at all if we would like to
> > capture only part of the log if we know where to look)
> No, it doesn't solve it. Your comment below suggests it will be read in 4KB
> chunks. Which means your 16MB buffer now requires 4096 separate reads! And
> you only doing partial reads of the section you think you need is never
> going to be reliable on live system. Not sure why you would want to anyway.
> It is just making things much more complex. You now need an intelligent user
> land program to read the log out and decode at least the header section to
> know what data section to read. You can't just dump the whole thing with
> 'cat' or 'dd'.
> 

Briefly have read this thread but seconding John's opinion that anything
which breaks GuC log collection via a simple command like cat is a no
go. Also anything that can allow windows to mangle the output would be
less than idle too. Lastly, GuC log collection is not a critical path
operation so it likely does not need to optimized for speed.

Matt

> > 
> > for reliable output via dmesg - see my proposal at [1]
> > 
> > [1] https://patchwork.freedesktop.org/series/133613/
> 
> > 
> > > Hmm. Actually, is this interface allowing the filesystem layers to issue
> > > multiple read calls to read the buffer out in small chunks? That is also
> > > going to break things. If the GuC is still writing to the log as the
> > > user is reading from it, there is the opportunity for each chunk to not
> > > follow on from the previous chunk because the data has just been
> > > overwritten. This is already a problem at the moment that causes issues
> > > when decoding the logs, even with an almost atomic copy of the log into
> > > a temporary buffer before reading it out. Doing the read in separate
> > > chunks is only going to make that problem even worse.
> > current solution, that converts data into hex numbers, reads log buffer
> > in chunks of 128 dwords, how proposed here solution that reads in 4K
> > chunks could be "even worse" ?
> See above, 4KB chunks means 4096 separate reads for a 16M buffer. And each
> one of those reads is a full round trip to user land and back. If you want
> to get at all close to an atomic read of the log then it needs to be done as
> a single call that copies the log into a locally allocated kernel buffer and
> then allows user land to read out from that buffer rather than from the live
> log. Which can be trivially done with the current method (at the expense of
> a large memory allocation) but would be much more difficult with random
> access reader like this as you would need to say the copied buffer around
> until the reads have all been done. Which would presumably mean adding
> open/close handlers to allocate and free that memory.
> 
> > 
> > and in case of some smart tool, that would understands the layout of the
> > GuC log buffer, we can even fully eliminate problem of reading stale
> > data, so why not to choose a more scalable solution ?
> You cannot eliminate the problem of stale data. You read the header, you
> read the data it was pointing to, you re-read the header and find that the
> GuC has moved on. That is an infinite loop of continuously updating
> pointers.
> 
> John.
> 
> > 
> > > John.
> > > 
> > > > Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > Cc: John Harrison <John.C.Harrison@Intel.com>
> > > > ---
> > > > Cc: linux-fsdevel@vger.kernel.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > ---
> > > >    drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 ++++++++++++++++++++++++++
> > > >    1 file changed, 26 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c
> > > > b/drivers/gpu/drm/xe/xe_guc_debugfs.c
> > > > index d3822cbea273..53fea952344d 100644
> > > > --- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
> > > > +++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
> > > > @@ -8,6 +8,7 @@
> > > >    #include <drm/drm_debugfs.h>
> > > >    #include <drm/drm_managed.h>
> > > >    +#include "xe_bo.h"
> > > >    #include "xe_device.h"
> > > >    #include "xe_gt.h"
> > > >    #include "xe_guc.h"
> > > > @@ -52,6 +53,29 @@ static const struct drm_info_list debugfs_list[] = {
> > > >        {"guc_log", guc_log, 0},
> > > >    };
> > > >    +static ssize_t guc_log_read(struct file *file, char __user *buf,
> > > > size_t count, loff_t *pos)
> > > > +{
> > > > +    struct dentry *dent = file_dentry(file);
> > > > +    struct dentry *uc_dent = dent->d_parent;
> > > > +    struct dentry *gt_dent = uc_dent->d_parent;
> > > > +    struct xe_gt *gt = gt_dent->d_inode->i_private;
> > > > +    struct xe_guc_log *log = &gt->uc.guc.log;
> > > > +    struct xe_device *xe = gt_to_xe(gt);
> > > > +    ssize_t ret;
> > > > +
> > > > +    xe_pm_runtime_get(xe);
> > > > +    ret = xe_map_read_from(xe, buf, count, pos, &log->bo->vmap,
> > > > log->bo->size);
> > > > +    xe_pm_runtime_put(xe);
> > > > +
> > > > +    return ret;
> > > > +}
> > > > +
> > > > +static const struct file_operations guc_log_ops = {
> > > > +    .owner        = THIS_MODULE,
> > > > +    .read        = guc_log_read,
> > > > +    .llseek        = default_llseek,
> > > > +};
> > > > +
> > > >    void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
> > > >    {
> > > >        struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
> > > > @@ -72,4 +96,6 @@ void xe_guc_debugfs_register(struct xe_guc *guc,
> > > > struct dentry *parent)
> > > >        drm_debugfs_create_files(local,
> > > >                     ARRAY_SIZE(debugfs_list),
> > > >                     parent, minor);
> > > > +
> > > > +    debugfs_create_file("guc_log_raw", 0600, parent, NULL,
> > > > &guc_log_ops);
> > > >    }
> 

