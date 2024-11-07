Return-Path: <linux-fsdevel+bounces-33971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCA99C10DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 22:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E04B219A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDFC194C92;
	Thu,  7 Nov 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhUyF43n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA021791D;
	Thu,  7 Nov 2024 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014539; cv=fail; b=HGfRZiWBXk053bv+zPslX76JEifuCI/CB9RrTm+8D3NFfA0oRmuXcbYNAmaMcYodFDjKb2GE0twH/arSQAXPXmbtNcVLoLOIQEtyWkrDGMx0H2JVDA/xVz5A2c2kXUkow04MF6jtH7DJsZKmsHLwbEAvvhkIblE+76SAK1poY0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014539; c=relaxed/simple;
	bh=dXduTX0TpBHSHfMOqVmePEnHvSEERM4F/TON4MzmW/U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PgKLaVVSi9V6dVjf4zWjWEsyD/bexfy4WUOfBifLwd0NZZSuy+iKq5Or/KLaaias4WOeBvEMiWZvyeopvuCvO3r/Bt4A9wg6ogmNuixpuF5ucJduCCvMLiUYzNuWZKFOUj+cEMDB4ibvK8W01X/Cpeyj63erTdhPy64TUId8VjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhUyF43n; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731014539; x=1762550539;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dXduTX0TpBHSHfMOqVmePEnHvSEERM4F/TON4MzmW/U=;
  b=QhUyF43ncGu+QN8Rqm0ge/NBmV+6kVs+a5XraMHIeDyd2zYRjoxRMKOJ
   34AnU4rLh+iHQ3/Oa3jP9S5hQkr0Uocwq28lqC0UzqFKRvMYUfz/aJNNg
   ibl4xNLMd+UbjyLzjWdxV34d8VfvoG24Im2VZgjZwQNihxZny2sqtZay3
   A19WZJwEv/AEiVgDbSek/93HmVFAez6kOl+1Gzgrlc8SlbQBSF2dT5AJe
   Qf3ERbKpWNTAS7P3I5CJww8BdM4S4fnH/h/CwE17ma5JyAy3ii4OrD0gR
   20ACbQpnxHpfBEC1I2NtqQnWApzavccfh0ap76YdEOLyhx+H9cw4L7mZG
   Q==;
X-CSE-ConnectionGUID: jx1Tk3+QRYik1tMtBojDYA==
X-CSE-MsgGUID: pAAs3hegQPS9+7qTaf8nzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30839749"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30839749"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 13:22:18 -0800
X-CSE-ConnectionGUID: pK8lutH0Scu6jEqVkv/JfA==
X-CSE-MsgGUID: oc1P5kZQShOcaDjgwTEfPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="89785406"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 13:22:17 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 13:22:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 13:22:16 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 13:22:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEHnEOLjgHy5VdKDpNYo7q8Jk5ws5RLDpki2Eqx65IM4UJNzsXO0cILzui3DcdtmqUcnNaFvuroSrXTlkEsqjH7oRdMI4A7Oir/lkySq0dA8BHuaBpF8ksQuXyLu+l6h2VEYQOgV0EDAr+sqRRxwp+ojN7gMwEoF8zzf44/NwnVmKBOZqOuPnnEOisD2xHAQPJjkKPQIxu7/dq086/rhZqNdjgecIXeYNgVdtZ0evK/t0pQK7ExzafNGr0pDO8tZ5Iv/Xbh090GUpfcA7xru51XW5J4TcUfetMaNSGzTWOHYHNWrR/PW+RQTtlhWbnxc78ixcx9/XpohoLW7UzdTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqUXU94u8793TLBlssLoUfgnfevWV6lfXnFetx3kBRQ=;
 b=DRJff8KPMaaEifIKoQmcDk943wOuGWhNpDj0pkGf3s5Ha5BKn3PPylzYWHVMFeb/pFfWksmzvEY0KIUYqTwDBEtVIJ9McmFjP62VB7zznnXPhsMxLqnjUIkFaMqvHH58guJiY39D2QQbQuvF4K5No+xKVB6qDquwyOiyzPTJxU345KcdrZgbaA+Bxv1x3FUlD9mNzSbcsEBdFMctvewn35Rqbn3CkTzysCBE9H4taItDz3Lb+rqBh4CpIFXSLie9Hy0UV1XHL74qElwO4r0BPeD+b9f61uu1CNZ6Zwwbu3aCsPXzDqmzqKGcM1WOqLiDwKYmlNky8yl1YB1eWP5HnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 21:22:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 21:22:14 +0000
Date: Thu, 7 Nov 2024 13:22:11 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>
CC: Jan Kara <jack@suse.cz>, Asahi Lina <lina@asahilina.net>, Dave Chinner
	<david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Sergio
 Lopez Pascual" <slp@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<asahi@lists.linux.dev>
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
Message-ID: <672d2f839e4b8_10bc6294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
 <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
 <20241106121255.yfvlzcomf7yvrvm7@quack3>
 <672bcab0911a2_10bc62943f@dwillia2-xfh.jf.intel.com.notmuch>
 <20241107100105.tktkxs5qhkjwkckg@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241107100105.tktkxs5qhkjwkckg@quack3>
X-ClientProxiedBy: MW4PR04CA0311.namprd04.prod.outlook.com
 (2603:10b6:303:82::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: a046f7fc-0dd1-4281-f4cf-08dcff723fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H8YgpG3PiEI9L6tzm+nqWciOjN2LYMhvfx1c7/a3am5Uq8rksnXocDzmp4ad?=
 =?us-ascii?Q?9BJHme+Jj0fHn8xExMUDukxFet46dc1lWhOQQRb5P1+MlTcCvnlz4l/0v75U?=
 =?us-ascii?Q?CU8KMeX8MUcMIBcJ1jGLgZKisrf4sUxZjhk8fl6DXCWIijKgAYl2MtVKmQDp?=
 =?us-ascii?Q?KORVWAMi6XSj2AeWZEpscsnAuXHLQsEJLgMntpZ61LwnS1vQdgjFUe3J+ebx?=
 =?us-ascii?Q?5my6LQMesGLtuVzLdYUQaqFLQ6QEvX3+8/Cl+LK1TnwCrZn9fQiQe/NSEBlm?=
 =?us-ascii?Q?s1kfa1IeFK8OZBva/oCnO4Mxpf4jXC11GH+5jWfcvAuvfKcTIJQqOZd/kQGq?=
 =?us-ascii?Q?92UBMLoDE3GTkhnPB3I3HQeYoKj7X9FefY6NRLkUt3IXbSm6xnbuTIxe9GEn?=
 =?us-ascii?Q?j5y1OM9hIpZNZn8MEcpIz+Apts3K739FcCwCEzXE2oBRFvPZuOPH73JPCqRT?=
 =?us-ascii?Q?+4VzejfHYGpil02JT2hOgxORkndgL0JoKjWzddTkTYEVfCbRzQV41sjXsrTq?=
 =?us-ascii?Q?i+IdtwbZrLJ9Vx61yRIUCbC+WMnrJBMzBBCazSk9bMwjHRJWYflArl+w65Xb?=
 =?us-ascii?Q?j2/cPqKl57XiauYcr1iLG2sL+aiI+7jCwdCyp0sRM6poTnYxry5hafR9z8ax?=
 =?us-ascii?Q?Z6t1LMK4Nzq92VJWyUDEfqTLJVsorUdchUGmayQvr2KZXQlV+823M+McUsik?=
 =?us-ascii?Q?8MQj6aKvlPExkCOAscz+MqOsibaFyMm1XgbVCKXdNbiegSpWVbldvjDZ1+Ca?=
 =?us-ascii?Q?USW7XNdwmXWUVWTak5fqKNlP7Q4VsdnY53+C+bopiFyy4CpDsUM4Rapz9FGm?=
 =?us-ascii?Q?+C/CyMlch1ZIsavmPUEfEGMZl3YWLPL57jmXernUC/uo9t88avdAw+55dcp1?=
 =?us-ascii?Q?JMGSGI87OB0O2EcUyWE0u3AYTQehNEQDIF0RFh9upt/XqqPTy+pZXADWcvPB?=
 =?us-ascii?Q?ziV4vmLCT9E2AzI730Gp3Q6+7ygomJbTzOSkGAS6F9+/g9n/DvAg7AbgB8W/?=
 =?us-ascii?Q?2Be9IP+VbgFUQg+Qb2zc6YwVIURIRlz/L5Fdm+qwtjuiIXyFgPtXUotDIK+j?=
 =?us-ascii?Q?ffl6iGTuf9VKXKuU+3asAZUTUdB21GkExSAjrIF6N+lfdvKxcvcx7E10WgpH?=
 =?us-ascii?Q?uXuQoNr/KXIPW0UZvK5Wklz56+YafPWWQ/cIPfEYH6JWLUEMsQjCinyKKAIc?=
 =?us-ascii?Q?tkaoKKJC3X7iEQ5Chz/0oFximiJUoEV6KU47ONvMcXYH0aCxvVLkgUythecO?=
 =?us-ascii?Q?4OloLW8j4LMZkrN+JhyG07WB9FLHjilmD/12CWIOchQxfjM7SiA1oTR6hhJm?=
 =?us-ascii?Q?vP7qkboyf19B4EoN1ryI7crZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ULY74OROe62icBfYGkbl7vTW74fsJhkeWNGEINIJBXWCswXEX0ErWfTxjAI?=
 =?us-ascii?Q?Urwk0wyv6zsPNFE+CKXpraM8kwu320NFURMAkpmzQD7KfX/YKZk5n/utk1/G?=
 =?us-ascii?Q?GcE3xXrP+70MPe5MrnHGQmlttpFQXJ0sqr/8UAyGezaR+4GXbTGplYT4dJFI?=
 =?us-ascii?Q?ZiFiCAzmhuQF19uc1XYJwH0rfEXIqPh0DOHHUgnAJLZC7KZaDFWGlZaFN2Nv?=
 =?us-ascii?Q?puKNDznIoNJOl10MX8sMLj2duUJF4lK8XaOJxv9AEHuV6sGBty9wSNP+sF6d?=
 =?us-ascii?Q?ENARfWkgKsm3uKT9HISUIRXOT7vEfYPD4PDXs+8r5JLwQcjG6S/8LW03U0O1?=
 =?us-ascii?Q?pJnNp1AAEYw1a5g6MF8V8YTtVRglYfMdRQ19fTuBXEleBsZw+KHOFlemU4Pe?=
 =?us-ascii?Q?9qgtICcDMI7jI8/hHZ+IerncZdJyRY8nYsyZvktW2fjwoTmRCQjlbmti56FZ?=
 =?us-ascii?Q?KAJ0YNep6J8mbKbsfFewX9obcT3Pb52h6Xsq0/a8ogYKEop3OaSDCBQXVEnh?=
 =?us-ascii?Q?newGQDWcEVGDxqKvHqlkRoL4XgwxaMDlgCbL3qZZ68EZ1fxWCxCXSA0ppZ6z?=
 =?us-ascii?Q?UD+gVobz44isWlfQH86Ibihm2jfl/w1wukgCToAPIb700GIkvoZxjb6fDYox?=
 =?us-ascii?Q?PR4Zdv0k/pnHkcdvXvD8P2u/PxzADNEfjAa9EzmhlQvFCS/C3iypJeiANd2w?=
 =?us-ascii?Q?MUZzMbnbmWQo8hrj0ZGANhwgSmPkjITfj0X2PTgCzLDbD5oUsNAO83NobNdk?=
 =?us-ascii?Q?gZxEkHgYb5kXuk7De3I+bgVwNDPsVaJ0AP6fgCy5W/f0+qlS4zWLYSpA4F0X?=
 =?us-ascii?Q?Z4Qla7fUJHKCLyPe1EurLG05Eiwvy72Potm26qH9jnp0Rh8okamTl7NmyhNv?=
 =?us-ascii?Q?YiGpwabflOAxKvejw41wZ1/I+XgT9LF8f3ZEPs4+7mjvdtnbCqIRSbMGAdXx?=
 =?us-ascii?Q?QWPTVP/RsZHgdYtQr6oZVfPdQ2eCChliJCDZ+z95yCdRHs3XT5Hhdu44y8Y0?=
 =?us-ascii?Q?3yfbNRfFKQin2iQfLZVUDMGyYP9O2L9MTW9sedirDg0jchATPxdK7VOWW7wA?=
 =?us-ascii?Q?I/JnphsbkqNEMziyRR/ZY8ZMxdeGXiuB5Ps3ZsJSpMHkGY1NLRPzoBnnUBaP?=
 =?us-ascii?Q?UCQw3a6c5lFWQlpHHApEm+A29hEl+VEnxTnnHcql5yxlyL9DhX4mtMiiW4YV?=
 =?us-ascii?Q?sOzmSU2fiH9s8alvBVzEA0ACmXRKKVSug0mo1apxd7KV//+AcnbYzJ2LvsZx?=
 =?us-ascii?Q?LRlJJ9EHKatGUApOi1MGVlijfsIFY1N4WzaMcwsghplSfyU/Ao0tg37CFkgM?=
 =?us-ascii?Q?YTY3gzCRKyhN2I3CWi8phEKLT/FOIjSy9ZgmHzzLneZGq7a6WhJ8u7YUN97d?=
 =?us-ascii?Q?NviPuSjtoR1kh0iAE9tdX6uv9DZxjudaO4ISzMd4HFDcgq2FbMVJsl/m7/HV?=
 =?us-ascii?Q?iW6PAK6Y+p5CbXq3zt3cYM2hxCgypQvc7n4hnQ409OdrQoYxveX8dCeZipjp?=
 =?us-ascii?Q?q90lgsBEKdo0y00Ei9R2ej9NFlI/gDRivHzfKUQ4RWE4/fwXMT4SN+x1Ujzp?=
 =?us-ascii?Q?OpRAO93z/ZqgfJaW5zAdvpbXnTPiECIsquFnjeS8TeEft4C7oVGvPiopwdxz?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a046f7fc-0dd1-4281-f4cf-08dcff723fc7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 21:22:14.2766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxKG3G3QH+OxFhld7dtzwz9Kdn3Y0fqlxL/z2FyGF9x49VII0Zv1H5Ik89xtfFe8w5jYH5g3tnJ+wZ1V0thLQ0UtRKT8A562BrCbtURQPGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com

Jan Kara wrote:
> On Wed 06-11-24 11:59:44, Dan Williams wrote:
> > Jan Kara wrote:
> > [..]
> > > > This WARN still feels like the wrong thing, though. Right now it is the
> > > > only thing in DAX code complaining on a page size/block size mismatch
> > > > (at least for virtiofs). If this is so important, I feel like there
> > > > should be a higher level check elsewhere, like something happening at
> > > > mount time or on file open. It should actually cause the operations to
> > > > fail cleanly.
> > > 
> > > That's a fair point. Currently filesystems supporting DAX check for this in
> > > their mount code because there isn't really a DAX code that would get
> > > called during mount and would have enough information to perform the check.
> > > I'm not sure adding a new call just for this check makes a lot of sense.
> > > But if you have some good place in mind, please tell me.
> > 
> > Is not the reason that dax_writeback_mapping_range() the only thing
> > checking ->i_blkbits because 'struct writeback_control' does writeback
> > in terms of page-index ranges?
> 
> To be fair, I don't remember why we've put the assertion specifically into
> dax_writeback_mapping_range(). But as Dave explained there's much more to
> this blocksize == pagesize limitation in DAX than just doing writeback in
> terms of page-index ranges. The whole DAX entry tracking in xarray would
> have to be modified to properly support other entry sizes than just PTE &
> PMD sizes because otherwise the entry locking just doesn't provide the
> guarantees that are expected from filesystems (e.g. you could have parallel
> modifications happening to a single fs block in pagesize < blocksize case).

Oh, yes, agree with that, was just observing that if "i_blkbits !=
PAGE_SHIFT" then at a mininum the range_start and range_end values from
writeback_control would need to be checked for alignment to the block
boundary.

> > All other dax entry points are filesystem controlled that know the
> > block-to-pfn-to-mapping relationship.
> > 
> > Recall that dax_writeback_mapping_range() is historically for pmem
> > persistence guarantees to make sure that applications write through CPU
> > cache to media.
> 
> Correct.
> 
> > Presumably there are no cache coherency concerns with fuse and dax
> > writes from the guest side are not a risk of being stranded in CPU
> > cache. Host side filesystem writeback will take care of them when / if
> > the guest triggers a storage device cache flush, not a guest page cache
> > writeback.
> 
> I'm not so sure. When you call fsync(2) in the guest on virtiofs file, it
> should provide persistency guarantees on the file contents even in case of
> *host* power failure.

It should, yes, but not necessarily through
dax_writeback_mapping_range().

> So if the guest is directly mapping host's page cache pages through
> virtiofs, filemap_fdatawrite() call in the guest must result in
> fsync(2) on the host to persist those pages. And as far as I vaguely
> remember that happens by KVM catching the arch_wb_cache_pmem() calls
> and issuing fsync(2) on the host. But I could be totally wrong here.

While I imagine you could invent some scheme to trap
dax_flush()/arch_wb_cache_pmem() as the signal to trigger page writeback
on the host, my expectation is that should be handled by the
REQ_{PREFLUSH,FUA} to the backing device that follows a page-cache
writeback event. This is the approach taken by virtio_pmem.

Now, if virtio_fs does not have a block_device to receive those requests
then I can see why trapping arch_wb_cache_pmem() is attempted, but a
backing device signal to flush the host conceptually makes more sense to
me because dax, on the guest side, explicitly means there are no
software buffers to write-back. The host just needs a coarse signal that
if it is buffering any pages on behalf of the guest, it now needs to
flush them.

