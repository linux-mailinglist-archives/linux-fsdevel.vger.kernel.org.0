Return-Path: <linux-fsdevel+bounces-33827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A39BF7B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 21:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7441282F8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695D8209F3D;
	Wed,  6 Nov 2024 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E31FbH4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE5193091;
	Wed,  6 Nov 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923259; cv=fail; b=LXgDN3CFDoHhJoxxdwJWGqPW3Ubs/XcQyS+/0UZZhcuCMnE7g44yK1/GS4+PamNtT2U82w2gnON9wy2jc5NQ8Caq+KKKEyK5NA6VKiLQtUmpTfccP5gUaMpG1d70xC23ssPfCn/7HP5l5APo+Ix3ArGoP8odSLzuKf16GjUVku0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923259; c=relaxed/simple;
	bh=t3zd4fS7uwRvChFE6pTV5aWJ/YBdPTfv2Iwu3xlTjN8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xl/7qnHcxEo40tIxxnMeqAH1yC9Uj00bQGWNPWXZJMybsNWK+7M3ih5Wsd/yZgMSiepAh51BCmRBWJt1vDUr32n8W3xzbML2Kgmlu10dsQ+5+TicgkeKEd5nUJxi1jc8PvDBDGm7lYHcHuhJQ42oUw9XsFZwz6/rPWIaqZUiphg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E31FbH4A; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730923256; x=1762459256;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t3zd4fS7uwRvChFE6pTV5aWJ/YBdPTfv2Iwu3xlTjN8=;
  b=E31FbH4ABdHOju/yxqXI7r6/KW40LXndj4S8xHxWMWLS6NjJSO8cEgrt
   pUp6ocImkfjjxvEZHZtOD8frX5pUzzvqIH/Wti28tkqc5/TN3E+UspC9e
   PSlB62NqSl6+HgvsOYcp0Kn25Zh/2/t+4xVV9H07MJWUSoo/kKmHIYfKj
   mTwSCVkYKL3gWxC6FTwPzJnrOCKqujFSOnLV/nIaBKUxuTlTY2p3hFpju
   v0zAmejETjX8v3GGmYyxLb/WOR2LVgdSzTjdG9xTAHLeThbgGZFQt02i9
   6swk3ALUIxB2KIkrp/bk6qAfwH9lBKpOKv92cR1OB8Uw3E6e/mee88+Vs
   w==;
X-CSE-ConnectionGUID: HdywbZUiSpau8tii8ivcOQ==
X-CSE-MsgGUID: UYpk/1JzSTO0uWPKo7989w==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="34519903"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="34519903"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 12:00:56 -0800
X-CSE-ConnectionGUID: d6SgF0vWT9muciB4CSpkhQ==
X-CSE-MsgGUID: wbaq/5VnRiOyCK7kL4J9lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="84838912"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2024 11:59:50 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Nov 2024 11:59:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 6 Nov 2024 11:59:49 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 11:59:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD12nkbGoLFGuDDr0B/I/+PD9Ftb12Ddx5B0u/80WdJWNuIjzERi5y1vuQMJHly2JpXZbwIMUDqtTZ1VK4UkKVSwBVwxuQzF/CIChSnrz3Znj6MT2DSY03k8xUzHG3zaYjVIlP3mQAi0mx1YVSOHLY9T3F5JfRJdEb6ACV0UZBY71KqBe6880ePgE8M6sfPcEoKzCjYwsVxlZuCSwp9RgPJSJHWRo1/xX5l1Y39V099NlBnPwVqaptTm58yh7WDS4AYFhRGk6dG4FwehC8pIIwuiS2HCxx4l3qwJ1QfkgS6BNc/IEpYk8/+3iPnQSS+zgAVPQ3mZcAP6BlpyF7UVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKfKccntNTnc3mydRNBUa1MAbbDId5lqVFGzMr2gMeQ=;
 b=W4+yQANOglNDZPJ6S9X/dQlqA2UkU4HW5FBA+MOCGgLrU4v+sP+wUxs7AR8nDPrK279ji7cUk+FDBd0J3VzOiib3sAhw5KDnCgbxqUgRE8M4Oqmd7b/LXNQPfnX1WJPkpICiOjxedYHnNtxZcxzKLOqTLUzzaPnaPx7W5BAc/ocHlp7aVOO78Qp0nTPlaeHYLdLmis19muyc2oSu6lRf5aUcPUtQyLB7tdfNJFrPxu13Qe4qsEm7xHXQvW797bwmX5za1i1nlAgHh6aClNQy9fdj9U5hx3YOyoYj5IQ9kgl3LhHE/wTwdTc+/0KUNSEZRCFGnHAd5hExyparTF/RPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7998.namprd11.prod.outlook.com (2603:10b6:8:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 19:59:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 19:59:47 +0000
Date: Wed, 6 Nov 2024 11:59:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jan Kara <jack@suse.cz>, Asahi Lina <lina@asahilina.net>
CC: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
	Sergio Lopez Pascual <slp@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<asahi@lists.linux.dev>
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
Message-ID: <672bcab0911a2_10bc62943f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
 <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
 <20241106121255.yfvlzcomf7yvrvm7@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241106121255.yfvlzcomf7yvrvm7@quack3>
X-ClientProxiedBy: MW2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:907:1::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba8c160-cdcf-4bee-8556-08dcfe9d90c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BJOApf4ARnB0+/er7V1sTG6HX6RxhmnxiYcZ0C/aZhebeBHzSQKeEKSLxvg+?=
 =?us-ascii?Q?2q38BrAblu/V85m1TDEVkPgfCSVq5ryFIyrs7cv+iaGuaW8JK4wqcpY/Y6yN?=
 =?us-ascii?Q?LhOlU/ASLkl/Kc5ZNzoTE/DuY3CU8yR+5alI2854K2Un5mEuAiP9IsCBJpXa?=
 =?us-ascii?Q?1r7cMPFCryB/v8lzK/0YsVxKbe/bzBLnTd0/Hz6k1t00mw0++kK+cVE/wPuG?=
 =?us-ascii?Q?4NPUpx1Q2rnJxKvPPsroZWsvGDxLiEVpgLcKHfGcCfVa64aP4IIGMh62VaSr?=
 =?us-ascii?Q?oOcF55m8sGWi3vUuSSoh7AuOmqlgdYhzv5GIJqmQ3u3Vzd2n8nZil5UUZceR?=
 =?us-ascii?Q?Nyzbf63lVcuUugDaOKlgql6NRFtsqyBpFCfD1xTcWod+PHjSecsygWpQtQFG?=
 =?us-ascii?Q?bMq41TPzp3A98oTunTj71eVVth6iE8mjqalvSRzjCJXEZ1C6Q3KtpgTYtApr?=
 =?us-ascii?Q?kLkWO5fHRiG732l0wyNqAf2b4ngRRPABAtTQ1ifNuzB+glFTBN5p1INtYwjS?=
 =?us-ascii?Q?86JOEZ+2auaemlLU+37oANVUjqgdFtex1Sm8Xd+8ZZgmX8mRYVEdqDn7Va4R?=
 =?us-ascii?Q?9JjPmcOCdlr+VzSfyMdeFQZMj/CPh6z+fZzc+fZKmxHp68Gzgj/3HHYASMhn?=
 =?us-ascii?Q?WdPIbPxQJxKIMRw/nGlyi1FfSVObvvfzXhYNhdZzWYs4SK8SI6uAZ80p2RkF?=
 =?us-ascii?Q?Cc7mKyL6KDpsPcfZkDpXjj512YpOHevnyPFrYk2mD2gIm4qwRMvl2x2ssRL5?=
 =?us-ascii?Q?ottV8M5D/46fnNoQDQSBVLD0IGMt2+YBeTKxESBnJ1/Fc7eOJTWTQa5Vg7Bb?=
 =?us-ascii?Q?vXkPZ9uGjqMtd180b3Biruydfk1iAmbWK6xqXYjbTRYOiaVJ+JnbnkT2vZTi?=
 =?us-ascii?Q?LS+cD3wogcnGQncmdG/BgOw5bWR3LVpmFaxLbBqhhLuuUI2T2zhgmAfu2ePF?=
 =?us-ascii?Q?tNvRPI9jBUfZUeNs7r1+dP67hjLUv5UrfGZBruxzFDms8P5oKmjatK40l+IY?=
 =?us-ascii?Q?ADVtL072gZB8fNO2zeLUks53Orggk+eKWO9xU1tRz/YQpesYq0xT5qFGTrlF?=
 =?us-ascii?Q?vVKcz5ec42HWEg5JsHP7es5iM62/4jOZvfsLb7dIAhDB0BGgCZ1TuQU2NYWu?=
 =?us-ascii?Q?9xt3CvsvSu+v7XDug4IrktubyfMK3eSwazPleDOB7kESC3ZmTvzTp6ThuZqS?=
 =?us-ascii?Q?M1pkWTYLOjXFCluQ3SeGD8j3X2IWcU8frfouHbRWU4SCg7G4++ZLnWKae+z4?=
 =?us-ascii?Q?jlPj8FuK4Quko9nTY7EdtAsqUY6IBGQHDoqG8mBcOEMi4mjNHz68HCwC8HzI?=
 =?us-ascii?Q?1KGB9qMaglwJ2bdeEhuANysQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nqSjL8gEJ2Hx1Z/Nx0Ds4X/CzpMLDUUN+zA06hIACIyiN/dBIaAHH9l1rr0v?=
 =?us-ascii?Q?0SXtt2k+cKYUoVkWCejRybhPGI9Jr2E36K3Bb0J45x5nOhhIM+OV2ul40SIs?=
 =?us-ascii?Q?2HuP1+CQ81iU0tZwngAfPyi0wceN8pmv8W2B9qv14OCSxfLy8MFV+tTshXxi?=
 =?us-ascii?Q?b4ni5q35nZOuG1GZWPhaRozwQlMJD1OFKnjN5tKORfKQyGialu8JYoGf0Eug?=
 =?us-ascii?Q?qQjwvHIx/P9YKvmGzF9d1nbcZwOiMN2YR55h/NgccbIikdGEFvipUyAjX2BG?=
 =?us-ascii?Q?35UO1VhupJUBO1MwZCWMZqOkzqpdglEV7T+4LSBqPVl0gPKcGaXOtonwVKko?=
 =?us-ascii?Q?qZ4upMTEStuS6EsDhvXoY+rhUM1Hom74UeiZ8iRB5pgj0dW4Tqdsxiaxz+Lf?=
 =?us-ascii?Q?nbCh/E9cPV2d8sX1pQzkd9WJHIMYX3bQ55Bbj5cwmAH94nqXnduuwqecPtHc?=
 =?us-ascii?Q?z2Qb739FHGV1IACiby3r/kX73uEfG4zNnTvKApejSB/BzsJtCbvvFItYrQgU?=
 =?us-ascii?Q?FTmO+ItpYdQYv9IIkc4awUT4BqsWrglAXGE93iVdgYIgMNZbuAxMcxZfbkAY?=
 =?us-ascii?Q?4Tp1jFC/cw98QQOrEgi5uf6pfIVXXT8UPw2VAuiy/keQjqG+9+CwKntNiICi?=
 =?us-ascii?Q?bOJbOjVVSUJYn9oRY40PBgszrbxjTQqWtTkv6we+9vXEwT3h/yPWHSjZeTI5?=
 =?us-ascii?Q?2IKuDIsz7HPUFkJEEljzGkYnUbQgWqLhtvOKICIGqQrq0YzCpkI7MepQy6jf?=
 =?us-ascii?Q?Ted1NhFczpBkHrSaT0B7OQ4E9VpBFG/nrNb590j2725a2xZfb0YZeYH215fD?=
 =?us-ascii?Q?7/QBd4aoka9PWE2HActLg/mr3zF1V4SdApT8AxuYWPGLO9St+Jwf5wRVrOiw?=
 =?us-ascii?Q?souQCfDmmsWWLKO6hfqMAj4fPjxWGL4qFSHgMFhL9KwAjpcAWPdlEvNz2Uh4?=
 =?us-ascii?Q?s8Eivsr0TmaJ2OCr/Q6ICUlnCJRzWbYe5zLJp7pbtKLTxHmDwpbyw9IMd8nu?=
 =?us-ascii?Q?Nl200MtWRBDI0j4frDZmQfzQP/U/SFUZVuIvwbDjwFnlwLyCN9ePkm7s7e1F?=
 =?us-ascii?Q?tP1DTK62COZ27yAO1TYhgnOmQOgqxi6kBYAy9ikCUomTUUbcLC3p5Lbci2ZZ?=
 =?us-ascii?Q?NgmVzLfTb+GwE2evLQdUzVlQNmxlFmoTOLebEURJKXdr1sV1oeVyGYLz57w1?=
 =?us-ascii?Q?pZDgYL9+oiyy3o1NrqUm9rREZrB4+J93o1zeK9FmmFIUFmvxHnAXUVkqKQDq?=
 =?us-ascii?Q?bUmuw0618QpqZ9QYjl/vamtcF57dyUHLEP1L9GBt6t/Pj+SN2SC6IrufPPXV?=
 =?us-ascii?Q?QJaI7UgPxoULO7LGZ49cg3w8dfT6oecbLRzNadGHNtJS8RprziyHelDAuZgK?=
 =?us-ascii?Q?wMdKy7jp9hmmqgJRYjxnfodggXP5KOGWOEtDa+KFHkCDpKmuQCQdbfqkWTEg?=
 =?us-ascii?Q?HMvlqta51kiIWiwyB1hNe84YTHjSWjHf1g/mu0GBxwx+wbPNN27wdP8LqfgE?=
 =?us-ascii?Q?RnnUZcX/B8EEUL+FWYz38aznjYYM7LqsfVDxz/5ACxasvgii9y9FzCazfkJ8?=
 =?us-ascii?Q?kHCRkuv9QZRXRcZP6CcdVH4JU1NhSh8jhg222nyGgbUelEyddhraR6P6wX4w?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba8c160-cdcf-4bee-8556-08dcfe9d90c9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:59:47.3729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MmbVk5RedoKePY+FzGxy779sTHCrh4ZyEUvTQ5V3UWNqOdo9BBezzEcIzOChNL7ixZKJYBFdSV88dl6JPCc94uAEOBzhFEzx3D65nDtQbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7998
X-OriginatorOrg: intel.com

Jan Kara wrote:
[..]
> > This WARN still feels like the wrong thing, though. Right now it is the
> > only thing in DAX code complaining on a page size/block size mismatch
> > (at least for virtiofs). If this is so important, I feel like there
> > should be a higher level check elsewhere, like something happening at
> > mount time or on file open. It should actually cause the operations to
> > fail cleanly.
> 
> That's a fair point. Currently filesystems supporting DAX check for this in
> their mount code because there isn't really a DAX code that would get
> called during mount and would have enough information to perform the check.
> I'm not sure adding a new call just for this check makes a lot of sense.
> But if you have some good place in mind, please tell me.

Is not the reason that dax_writeback_mapping_range() the only thing
checking ->i_blkbits because 'struct writeback_control' does writeback
in terms of page-index ranges?

All other dax entry points are filesystem controlled that know the
block-to-pfn-to-mapping relationship.

Recall that dax_writeback_mapping_range() is historically for pmem
persistence guarantees to make sure that applications write through CPU
cache to media.

Presumably there are no cache coherency concerns with fuse and dax
writes from the guest side are not a risk of being stranded in CPU
cache. Host side filesystem writeback will take care of them when / if
the guest triggers a storage device cache flush, not a guest page cache
writeback.

So, I think the simplest fix here is potentially:

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb..15cf7bb20b5e 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -777,11 +777,8 @@ ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static int fuse_dax_writepages(struct address_space *mapping,
 			       struct writeback_control *wbc)
 {
-
-	struct inode *inode = mapping->host;
-	struct fuse_conn *fc = get_fuse_conn(inode);
-
-	return dax_writeback_mapping_range(mapping, fc->dax->dev, wbc);
+	/* nothing to flush, fuse cache coherency is managed by the host */
+	return 0;
 }
 
 static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf, unsigned int order,

