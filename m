Return-Path: <linux-fsdevel+bounces-57026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BBB1E02D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 03:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF93582324
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 01:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8045872634;
	Fri,  8 Aug 2025 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoBzVzvq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990666F06A;
	Fri,  8 Aug 2025 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754616554; cv=fail; b=FpYkN7Ih4KFEOteLqL6UhmHUdv7LUrXVkIndYkjGO6i3AVbGnnM1j27PVw+NEL7PnTjqbK1fWV70xuJw6mmGq2HhUDf9HEzeyil9DZgqVfioEXHYhEgicZZ1CSe2cNudCgBJz8o+gI+VsEwRPizmkjN10mz+AheBwahS/YpG39U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754616554; c=relaxed/simple;
	bh=JpOiukpxJF8kVjavgsFMVGULXN4vsgacktb5DV3WgUc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dmsDVNnYPK6bSX/mUu37v9DZqCUNlL7rZl8yIf6UZzypWjFsnWwBWKZXUF2DnCmbyioQPhrtEYZCzKF57vkQsNOBypcIUMiRafMBaNR5EaUK+aB3KnauiKb+urEZ3jYTLDgWO4IkEJd73ZzJv3rnfeRmiWWkW7Lhz2wJyU/uvdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoBzVzvq; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754616553; x=1786152553;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JpOiukpxJF8kVjavgsFMVGULXN4vsgacktb5DV3WgUc=;
  b=MoBzVzvqR7SA2XjdFlQPWoc7vfM/ondDx7sUaP5pRhjmh4B/QY0e+poh
   Pmpry43FztImZE1O8390AFHDekbc9AmfP/Pmqmq1zEV65MN7nNsgxqMpE
   CGLb5wj5+8kejeSbBAjdQ4/Nnk73xNqVbdQxxi1RMfqjjy61eXeQ1H3qa
   Ofn9cUzbOVQA0PqF+sloB3fPbCK/vSAhmSBJ2N6ZW2cA5nfvvI6spc0u6
   /6oIE6cCvl01VU+aYVzkn5qxWAbmPMfkMHEiz+cAuWvoJ8AmNBOm0LPL0
   SgaTaf61Z/28kW8+EyS+86GH+Lw9NecFVnWyg2k7l2j1g0IMiJtwED/s2
   A==;
X-CSE-ConnectionGUID: kgHm8TVsRVGqC7/ygKvLiA==
X-CSE-MsgGUID: +ntLLfZZTm+O3kw3ZA6zpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="82409100"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="82409100"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:25:28 -0700
X-CSE-ConnectionGUID: +HVld4HKQmKDglKgQZuWfw==
X-CSE-MsgGUID: rwjVu45XRMqxeO+vlB+lDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="164430856"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:25:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:25:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 18:25:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.56)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:25:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz0EaKPSg2E96FLaGBPwbecPObEZkOCS1TM543nufC77LX4584HJcps01UJUKucKKTOfGpHZ7EQmCfH6+LbSVp9P1z58L9ZJfx8vwF8Q6NHFGjSZwA+t/x5HZmCHX07YTboDX+tT0kc7GRWcs6Flb4nq2JOoSbkE1SbU6NbAETEjkqV8QKdxNkZo/djht05p8ykb3ccCK8oNMFlErb57sIjRb0RGFM2B04KRe//Ks/B1alIUzk5z57MZup20vYvrXbU+Ylf4L/3UZp6iuRLzZ6HyEGHQswrrz4mvq6meUvp4MtKMTuW1c2jcScd8xmwLD+TTnn+l9h/upKLYcmRUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnvtK+DS73spMVs+SfZF3uAfgJLzjlrnzAh7H2Z6XVY=;
 b=pnLjC10bEuL1ITyoi8B+s9xBuIlmkYozsoJcj9dazgP2XLYxB+8XVvWzstmgZeSHKHgpBhDEEbXTH7ERCi8KeQo7ZctvGzZ2ng47uP5clb1dsOlq1Ct57BNdRb45waiMm1PA9rynQjzI3nkWRm4HE/wXsySOtLnWPGrCQajM7PB1Hf9hgL5crSkPVLaW7q0ZiTifm/r+2l+1dWL+/EbZv0TayJYShVhvCdsGPyEzQUGCuS9+8DIsX9tTVSuCQb22PRcs//P0okwS0Hl0+JLw88xOQw3zJE0tJG2QXUnXzhW0o4hw1MW+SWvCu/YiTUwlf5V88mGsu3r7Aq+xfXBgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 01:25:24 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 01:25:24 +0000
Date: Fri, 8 Aug 2025 09:25:14 +0800
From: Philip Li <philip.li@intel.com>
To: Aleksa Sarai <cyphar@cyphar.com>
CC: kernel test robot <lkp@intel.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <oe-kbuild-all@lists.linux.dev>, David Howells
	<dhowells@redhat.com>, <linux-api@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] vfs: output mount_too_revealing() errors to
 fscontext
Message-ID: <aJVR+vUzxCiqzpNW@rli9-mobl>
References: <20250806-errorfc-mount-too-revealing-v2-2-534b9b4d45bb@cyphar.com>
 <202508071236.2BTGpdZx-lkp@intel.com>
 <2025-08-07.1754589415-related-cynic-passive-zombies-cute-jaybird-n5AIYt@cyphar.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2025-08-07.1754589415-related-cynic-passive-zombies-cute-jaybird-n5AIYt@cyphar.com>
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|PH7PR11MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: b09d55e4-8691-4148-dd85-08ddd61a72d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K1LZ7BnyVgXNy1VOqfhlnFvadPi+RuQMLGgvL2ufzfZjIb3R+hQqDwKyxBMj?=
 =?us-ascii?Q?ClHd9OnQ+tGCjNVtIY0D7NKZhwXAPxpd6LSfSLWCZSXdRlme2OWvogBf6OF9?=
 =?us-ascii?Q?Wr3UrnWhKnBLiRqxNbfSQzVcBpiFlkJhoJDYRHFRSolnVinOvz8KZudpcW0F?=
 =?us-ascii?Q?GsGc4xY9WBZOH+1qy/5oFLvM9lg76bMgip3Q1sO9lyoVFtlr+dixCsnCwyfF?=
 =?us-ascii?Q?BtXSnqpz8kZWu0q31QXFVhc2nW+Fg1BFNQu3Q3qik3S30Ac+h4tX3MBuukjN?=
 =?us-ascii?Q?le4Znu1fgL92oem8LVZetkncR6pgUlNQ2eWxEvreVLmsMIvVRnvig1d7CPwQ?=
 =?us-ascii?Q?E4TxcpbVM/KRvPLsdIKObjcMlTk1IntxMoL7gqI548YO8PDl7eUbFDcpGj7j?=
 =?us-ascii?Q?Jo8qylLH2T06bLdaKxgmcjbZWTY4Tm7M0Dpup7+merN7dwqVg3z0Obbe5XVE?=
 =?us-ascii?Q?6aGbeq5nFe89yrEV/JeqmCw8n/25rejZWBBUtwa/KHCLPs59ABmsROktvg1x?=
 =?us-ascii?Q?dvYqMYg6zyWnn/EyBj1ZRHBZ2qvRQ+pDp/f30CO4LelP89Ajpg8PqtfpUjKZ?=
 =?us-ascii?Q?KcAmAn8ofqJY7T79RUD26eEMlaQdjjrqPtnemCTc9Y97XFKKrCNxRowvfjqX?=
 =?us-ascii?Q?tgQAou0WpWMByeuq5Nst16wJKD/Bh06rdmScvWZLcvOC3JGkTwfFq/V1Bw+Z?=
 =?us-ascii?Q?/VPlxi1A9qHB6RjAGGETpLN1x2OKfKetOOrV052Oa8WePuXmCucdmoofYSSM?=
 =?us-ascii?Q?KZkGwnSkQZ1UajgLw0hj3mSQhIBFbvMh7lR6OU0OX2diji2QHw9luf2JrW5/?=
 =?us-ascii?Q?Y1wume1CvEur1Kg1ICE7yEgXnHbLnaNIwuL83Uu4OJkynpI0ucu3dlexSGEt?=
 =?us-ascii?Q?Xafpme1SkiC5/Tpus2p4lJ/ywrOksWxVEz3T+oDp12ZHqsQ4w5embViTZPmx?=
 =?us-ascii?Q?NK7pqhDOBteR1ew/tThiJ+gd0viValiNB4iiRcvPVTcf8RpVN7nl6mz4eFgf?=
 =?us-ascii?Q?o5/R2fyfdAI+nvTVB402C4e+f6xbt80JbKNn79ekHQPL4EkIzkf0gKyrIb61?=
 =?us-ascii?Q?K5EosFF1DvoAeNUu7ZNjOHkRp7rG1BraLN+25sIw3B82jMbB5TEpTH6rmRFC?=
 =?us-ascii?Q?OzEXCsHCXFGZi0xeRAx5TXqbD9VEYEy8wsKxPyqmD7UdXGaAEY0PiNvCDwcN?=
 =?us-ascii?Q?F77U296Loq5bf1OycvJ9r2vu+XWFl+z5BiqD9qDjbZA5JSLe0BV64zpHJFBO?=
 =?us-ascii?Q?mknLPZiQcUL6SNUafK3pLcA1EN/icuWY/T1SYRdt5iZmKxLaJsLiOPcZKwox?=
 =?us-ascii?Q?LswIc4jSfv+LZMyT31mVGPL4u40O5hC/6M8Qieac/DaMz11c7ifj0bu8ivut?=
 =?us-ascii?Q?RckJfEYbtMTDEK9z8WDkaqLrNSMz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5YrPr+wrDzgpKOJlrJgKm7KATbMwLD61GonCzGe0MhFJhFOk2VxqCmuAi34Z?=
 =?us-ascii?Q?k75w4YejjcGSooXS96HSMDjxOCChvIPPTjlrOhLKh+Fm5T/lobHwqr+BM16i?=
 =?us-ascii?Q?y+4Q1084kmvMbAVyC8Z6Z7KZGnjDIOUNSwKt7Fj8e+V5JtBHWdH0QCjtUmgd?=
 =?us-ascii?Q?hXxIgXP+3sb6m/8xSgIhhaFnu46SVJCdyiw7pYsb/d5rsVU7vSZ5Lmem90lQ?=
 =?us-ascii?Q?jGDnRosx61Tcoq3iAWu+IOdliVYBz0YZRnRpnW2Thok9pfHi2QsEYhPgIY6E?=
 =?us-ascii?Q?XIBHWOpgLqTLTv6SWr6aovbDl9j2uMDCMvzaL1bCqwhxnsxDL67pu56vLtNQ?=
 =?us-ascii?Q?DDUovBGNk0U598rQuafVxDHQpSP2yWvAJ6IOYaXNApU2ore+XlswH9otu1GF?=
 =?us-ascii?Q?SP2TXb9REDthJYKH0COhONSaR/KgiezcX3x8b6kUOwTE/mLS1ua++NuWLN/E?=
 =?us-ascii?Q?Qlwjqr7PftBPcyevNsXadguJPyRt7eDXCu8qmT17UYZn5cmz0e3PIIsfZ4HT?=
 =?us-ascii?Q?kIWhvsd4ZkcL8IzT6/ajVQvswFMv/TnPZw4UBaB5AfjPzvOAVxN/PXjlFNcw?=
 =?us-ascii?Q?ZhZ9sFYdwJ4rgBiNRrRxLIOJPLFKOdqhMdMg1yH+TPwXD6nK5DiY+293S6p0?=
 =?us-ascii?Q?MHeBszGLdqdDV+nns1ADlJYS6kBsdWyTJ4S6oBawrB0vGUUw2zC0QXRhTVs+?=
 =?us-ascii?Q?dU6b3rS60h5c/zASONGWNxwsMfYIS8GbkonyhV8u9QVT8hgKw3A1pk9hCvXL?=
 =?us-ascii?Q?yzalNzVAG8drh4lYn8brqJ4XO0bXSk3jNzx9DiMhNODgl2sPXWKG9beDomAo?=
 =?us-ascii?Q?GYzXuN62oOj/9rYHmOjEina5YVVRYap3plXAhEvWRzJlSLkleXDGLHGD2trx?=
 =?us-ascii?Q?If/bXkf5noGgdUvC0Jy22oWfwSVQAs+/I8C2bTcQK8Qx7iMhCN5n6yLLJui1?=
 =?us-ascii?Q?r9WKSEABED/MnV4tyaNLGEgR3yTsBXq89hzRO7Iu1VTGQwcISAles32X3cx1?=
 =?us-ascii?Q?UGeBNj4L9agoV+DKhCTVpOM3OvSiP8N2gHCSVxLAOaMXbZfg2CCmKY50fm7W?=
 =?us-ascii?Q?fKfiCDU1/FAS8u7lK/+T/uJER3a9SBCcQ3jCJNdoxM1gt0/2dXYHjZeyVoiX?=
 =?us-ascii?Q?u9GbppTkNVJVm91qFB9FADMhbDG9Ie+HHQuPSgiU0BWN4mTC/ZpBUXhhW3jK?=
 =?us-ascii?Q?KEMvmkdOUFBYnJ/yD70Hg/ggxXhDMOqiePvUnpBl7Umiya/7/IXMVwQ85R8b?=
 =?us-ascii?Q?YBr8dUdibB7DRo2uU00xHokyK5mA+VMbnSbH0WfmCtqk9YyV96BtliIA37er?=
 =?us-ascii?Q?jJsNDLsqJrQVCIUR4cyBQFsl7m/C0CvplYvYr1ZwmZHHQHZn/3z88mlLv4BT?=
 =?us-ascii?Q?i2gBKwqj4MtCIZUY51Y8bV8C7FpdEUAUM4l5qcl+dGtSHW4Lk3wIflpn5Zzk?=
 =?us-ascii?Q?5F3IjM8GOEKIqpwYcsJr+k8gwaK5v1Rzzl/Q0JRnEqUIl4gxpVn4mYdedXND?=
 =?us-ascii?Q?vdPGQGmLBbqgm+2U0e7TsBJJtqhmPb954cr7jjq1KhPPmp2moIkWC8w4Cah0?=
 =?us-ascii?Q?vXEYPfLLY0yG666yfVGtAG7wJCb4NRdFHY+X7HBV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b09d55e4-8691-4148-dd85-08ddd61a72d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 01:25:24.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBmmw1JCkSsVKrQuygg6qFXLak1wPdLTMefwKOJtjeEoSQ3kxxAXPb+qrMhE8X5X93lzP/tS81wk6QFdQeuzOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com

On Fri, Aug 08, 2025 at 03:57:09AM +1000, Aleksa Sarai wrote:
> On 2025-08-07, kernel test robot <lkp@intel.com> wrote:
> > Hi Aleksa,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on 66639db858112bf6b0f76677f7517643d586e575]
> 
> This really doesn't seem like a bug in my patch...

Sorry for the false report, this is related to [1]. I will disable the further
report of this issue to avoid meaningless report.

[1] https://lore.kernel.org/linux-riscv/d5e49344-e0c2-4095-bd1f-d2d23a8e6534@ghiti.fr/

> 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Aleksa-Sarai/fscontext-add-custom-prefix-log-helpers/20250806-141024
> > base:   66639db858112bf6b0f76677f7517643d586e575
> > patch link:    https://lore.kernel.org/r/20250806-errorfc-mount-too-revealing-v2-2-534b9b4d45bb%40cyphar.com
> > patch subject: [PATCH v2 2/2] vfs: output mount_too_revealing() errors to fscontext
> > config: riscv-randconfig-002-20250807 (https://download.01.org/0day-ci/archive/20250807/202508071236.2BTGpdZx-lkp@intel.com/config)
> > compiler: riscv32-linux-gcc (GCC) 8.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508071236.2BTGpdZx-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202508071236.2BTGpdZx-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard_out_of_sequence+0x266 (section: .text.prp_dup_discard_out_of_sequence) -> ili9486_spi_driver_exit (section: .exit.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard_out_of_sequence+0x2ae (section: .text.prp_dup_discard_out_of_sequence) -> ili9486_spi_driver_exit (section: .exit.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard_out_of_sequence+0x2f2 (section: .text.prp_dup_discard_out_of_sequence) -> mi0283qt_spi_driver_exit (section: .exit.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard_out_of_sequence+0x33e (section: .text.prp_dup_discard_out_of_sequence) -> mi0283qt_spi_driver_exit (section: .exit.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: ida_free+0xa0 (section: .text.ida_free) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: ida_free+0xba (section: .text.ida_free) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: ida_free+0xdc (section: .text.ida_free) -> devices_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: ida_alloc_range+0x4c (section: .text.ida_alloc_range) -> devices_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: ida_alloc_range+0x9c (section: .text.ida_alloc_range) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: ida_alloc_range+0x31a (section: .text.ida_alloc_range) -> devices_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: kobj_kset_leave+0x2 (section: .text.kobj_kset_leave) -> save_async_options (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __kobject_del+0x18 (section: .text.__kobject_del) -> .LVL39 (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2aa (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2ba (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2c0 (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2d0 (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2da (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2ec (section: .text.mas_empty_area_rev) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x2fe (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x314 (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x328 (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x34c (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x398 (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x39e (section: .text.mas_empty_area_rev) -> __platform_driver_probe (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x3d4 (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x400 (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_rev+0x42a (section: .text.mas_empty_area_rev) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mt_dump_node+0x230 (section: .text.mt_dump_node) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mt_dump_node+0x24a (section: .text.mt_dump_node) -> __platform_driver_probe (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x20 (section: .text.mt_dump) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x32 (section: .text.mt_dump) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x42 (section: .text.mt_dump) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x4c (section: .text.mt_dump) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x56 (section: .text.mt_dump) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x7c (section: .text.mt_dump) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0xd4 (section: .text.mt_dump) -> __platform_driver_probe (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x43e (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x454 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x466 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x4b2 (section: .text.mas_empty_area) -> platform_bus_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x4ba (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x4d2 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x532 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x548 (section: .text.mas_empty_area) -> __platform_create_bundle (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x572 (section: .text.mas_empty_area) -> .L461 (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x574 (section: .text.mas_empty_area) -> __platform_create_bundle (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x57a (section: .text.mas_empty_area) -> __platform_create_bundle (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x592 (section: .text.mas_empty_area) -> .L459 (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x5de (section: .text.mas_empty_area) -> .L457 (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x5e4 (section: .text.mas_empty_area) -> .L458 (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+0x5f0 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_root_expand+0x84 (section: .text.mas_root_expand) -> .L495 (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_root_expand+0x98 (section: .text.mas_root_expand) -> cpu_dev_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_prev_range+0x18 (section: .text.mas_prev_range) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: mas_prev+0x18 (section: .text.mas_prev) -> classes_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_augmented+0xc8 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_augmented+0xe8 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_augmented+0xf8 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_augmented+0x102 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_augmented+0x114 (section: .text.__rb_insert_augmented) -> mount_param (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: rb_first+0x8 (section: .text.rb_first) -> mount_param (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: rb_first+0xa (section: .text.rb_first) -> mount_param (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: rb_first+0x10 (section: .text.rb_first) -> mount_param (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: rb_last+0x8 (section: .text.rb_last) -> mount_param (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: rb_last+0xa (section: .text.rb_last) -> mount_param (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: rb_last+0x10 (section: .text.rb_last) -> mount_param (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __rb_erase_color+0xda (section: .text.__rb_erase_color) -> auxiliary_bus_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __rb_erase_color+0xf8 (section: .text.__rb_erase_color) -> mount_param (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __rb_erase_color+0x188 (section: .text.__rb_erase_color) -> auxiliary_bus_init (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15a8 (section: __ex_table) -> .LASF2568 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15a8 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15ac (section: __ex_table) -> .LASF2570 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15ac references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15b4 (section: __ex_table) -> .LASF2572 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15b4 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15b8 (section: __ex_table) -> .LASF2574 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15b8 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15c0 (section: __ex_table) -> .LASF2576 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15c0 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15c4 (section: __ex_table) -> .LASF2578 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15c4 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15cc (section: __ex_table) -> .LASF2580 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15cc references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15d0 (section: __ex_table) -> .LASF2574 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15d0 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15d8 (section: __ex_table) -> .LASF2583 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15d8 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15dc (section: __ex_table) -> .LASF2574 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15dc references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15e4 (section: __ex_table) -> .LASF2586 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15e4 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15e8 (section: __ex_table) -> .LASF2588 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x15e8 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15f0 (section: __ex_table) -> .L0  (section: __ex_table)
> > ERROR: modpost: __ex_table+0x15f0 references non-executable section '__ex_table'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15f4 (section: __ex_table) -> .L0  (section: __ex_table)
> > ERROR: modpost: __ex_table+0x15f4 references non-executable section '__ex_table'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x15fc (section: __ex_table) -> .L0  (section: __ex_table)
> > ERROR: modpost: __ex_table+0x15fc references non-executable section '__ex_table'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1600 (section: __ex_table) -> firsttime (section: .data.firsttime.60983)
> > >> ERROR: modpost: __ex_table+0x1600 references non-executable section '.data.firsttime.60983'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1614 (section: __ex_table) -> .LASF230 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1614 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1618 (section: __ex_table) -> .LASF232 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1618 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1620 (section: __ex_table) -> .LASF234 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1620 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1624 (section: __ex_table) -> .LASF232 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1624 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x162c (section: __ex_table) -> .LASF237 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x162c references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1630 (section: __ex_table) -> .LASF232 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1630 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1638 (section: __ex_table) -> .LASF240 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1638 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x163c (section: __ex_table) -> .LASF232 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x163c references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1644 (section: __ex_table) -> .LASF243 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1644 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1648 (section: __ex_table) -> .LASF232 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1648 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1650 (section: __ex_table) -> .LASF246 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1650 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1654 (section: __ex_table) -> .LASF232 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1654 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x165c (section: __ex_table) -> .LASF249 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x165c references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1660 (section: __ex_table) -> .LASF251 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1660 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1668 (section: __ex_table) -> .LASF253 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1668 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x166c (section: __ex_table) -> .LASF255 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x166c references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1674 (section: __ex_table) -> .LASF257 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1674 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1678 (section: __ex_table) -> .LASF259 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1678 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1680 (section: __ex_table) -> .LASF261 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1680 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1684 (section: __ex_table) -> .LASF263 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1684 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x168c (section: __ex_table) -> .LASF265 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x168c references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1690 (section: __ex_table) -> .LASF267 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1690 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1698 (section: __ex_table) -> .LASF269 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1698 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x169c (section: __ex_table) -> .LASF271 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x169c references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16a4 (section: __ex_table) -> .LASF273 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16a4 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16a8 (section: __ex_table) -> .LASF275 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16a8 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16b0 (section: __ex_table) -> .LASF277 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16b0 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16b4 (section: __ex_table) -> .LASF279 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16b4 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16bc (section: __ex_table) -> .LASF281 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16bc references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16c0 (section: __ex_table) -> .LASF283 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16c0 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16c8 (section: __ex_table) -> .LASF285 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16c8 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16cc (section: __ex_table) -> .LASF287 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16cc references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16d4 (section: __ex_table) -> .LASF289 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16d4 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16d8 (section: __ex_table) -> .LASF291 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16d8 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16e4 (section: __ex_table) -> .LASF4984 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16e4 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16ec (section: __ex_table) -> .LASF4986 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16ec references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16f0 (section: __ex_table) -> .LASF4984 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16f0 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x16fc (section: __ex_table) -> .LASF4984 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x16fc references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1704 (section: __ex_table) -> .LLST20 (section: .debug_loc)
> > ERROR: modpost: __ex_table+0x1704 references non-executable section '.debug_loc'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1708 (section: __ex_table) -> .LLST22 (section: .debug_loc)
> > ERROR: modpost: __ex_table+0x1708 references non-executable section '.debug_loc'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1710 (section: __ex_table) -> .LLST23 (section: .debug_loc)
> > ERROR: modpost: __ex_table+0x1710 references non-executable section '.debug_loc'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1714 (section: __ex_table) -> .LASF4984 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1714 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x171c (section: __ex_table) -> .LASF270 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x171c references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1720 (section: __ex_table) -> .LASF272 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1720 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x174c (section: __ex_table) -> .LASF1801 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x174c references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1750 (section: __ex_table) -> .LASF1803 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1750 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1758 (section: __ex_table) -> .LASF1805 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1758 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x175c (section: __ex_table) -> .LASF1807 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x175c references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1764 (section: __ex_table) -> .LASF1809 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1764 references non-executable section '.debug_str'
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x1768 (section: __ex_table) -> .LASF1807 (section: .debug_str)
> > ERROR: modpost: __ex_table+0x1768 references non-executable section '.debug_str'
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



