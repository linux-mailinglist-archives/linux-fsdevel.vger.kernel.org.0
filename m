Return-Path: <linux-fsdevel+bounces-33040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA39B25DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 07:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24781F21E15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 06:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266FB190054;
	Mon, 28 Oct 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDabZVce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1A18FDD0;
	Mon, 28 Oct 2024 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097269; cv=fail; b=JXIjDYpuD0B7gWB/Iu1pw4uNPmmPCA7AKumsC+Xdd2q9DuCgLFvhU+GvGMKfLR6z1PnanbcSZJOgkW9IFCUJSgYa6yE0zuFZzfg+FAToALEewvzjO4SgaU9hAOkMSdh0W8Wu0tiLVrAx0gVmAQrdMMlDEl+4Y0wdCTFVVjMfya4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097269; c=relaxed/simple;
	bh=ne174MTqkMxXMZn+Ou8uHnUtiUw9Ll1GqjFeBMrnlK8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ceINPhas+HYLCpLhXLqG278ytiAV0RqS4/E/KgLVFEaSopXJV4QTZXawPAMP4E5TbyO3ENn/z0ih+/lVp7/XRlt40XCzbXGq0FuUR2xkHSCBjE7DDZlcT582qZOfearPBfJruUISeIwsrsC4Ly0W2xXVQmTFV6I0+LR0qQrz4/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDabZVce; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730097267; x=1761633267;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ne174MTqkMxXMZn+Ou8uHnUtiUw9Ll1GqjFeBMrnlK8=;
  b=hDabZVce/xiCphLbVyZpdK0jQ89PqxoR30CL4HFI1PH/FU+i/JzYBH8b
   mjNtT/gr9vnq69ZHMzxqt4JAwfXD6OGEnQ8UKnRUXGA7tzBv+qQyhVKJR
   mH95vi5mPNZSGj5WJ+R+1awi64Gdt/ilKkROATnuQswbP7vnsB+YYfzfG
   Nl0/VIywhsMosKwNJcFJlmJq8JYrprEsBBfBp0PExlO8c7hXTAUdi9b15
   4TDgz03wsbSxSctfe6q0ewD74bc+AQYIarx6mtuT51HPf3z6b6RkkkjuI
   ajUky3zmHuecj/kjWmNYFX8zMTUluEToLJSH8pMi3czkdu2eC88sLDowc
   Q==;
X-CSE-ConnectionGUID: QCy56WskS1yDHaXmnKpDUQ==
X-CSE-MsgGUID: l9E+b3mkTSOodd8lILjpdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29544228"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29544228"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 23:34:26 -0700
X-CSE-ConnectionGUID: giCvsYq8SjSdc5kAGxBiBQ==
X-CSE-MsgGUID: l6Qrf066Q3iGwPyZ606KcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="86262472"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 23:34:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 23:34:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 23:34:25 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 23:34:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD+REPTt4Re5PgOjdCsadOcz2LwAp9+niSZGuztSObDRjcAOX3nokFz19p77aOxSpqwv7AsH2I5HIk2B1vKJ+Ap6uG6NnrNvE9fR0n9ULQSI7p19rHycCbi0PW6blXTfzUSFHYgzYn3KWH6M7mDRVyqmA5e1+VHB6LIRuleObPCFhLrlP/MkjwFezxbHLbxf8YWA9A/27owZOk8noIm310WSs8uTN5PgXUY0Q/tRptdmbtyHsfXF4uPhFU6JhkjF4BzOt4yo5w0YfMu5/JA5Nf7KYECxSg+Ro8U5gVgCU5BKZGUtYj1++9NUaFSjiLE/zVFqctB73PDfg+mgq5KU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBpxeq+NkkMRnWwdjHWAagQXe3i+K47zZPv4rW9N1+I=;
 b=khYSouIxo/j1QJeagynmwwiC4IwSLFryLhZr/7eFGPXsFJjw6CtiCkzZ51/qfCJ/2vXB3HuNCSmNSD8BSh6g8FRZoOKTd0rpg+1myc0JQDhl0Av0V+Ne7lDbi3yRIGctEbCPmDcC37ah71LboKSj9xQ9Jcn9XhCnd25Lg/2CILM9YMddj/TViji6ZsTgW+RZyafqAJe3OHRTUG4I5gnJOMjeFLMISz4o2rgbHWyghcmEhqeD+W+UHeUI1nXIZk0XgSqt9GYESLGza6SSjI8QCGEu6eRqxVCUpb1I+KcNoYCiSmvTwIQqGrio9VLFcz7vFT4YDbRFB5pIlpnt6oKB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4552.namprd11.prod.outlook.com (2603:10b6:208:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 06:34:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 06:34:10 +0000
Date: Mon, 28 Oct 2024 14:34:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>, "Lucas De
 Marchi" <lucas.demarchi@intel.com>, <oliver.sang@intel.com>
Subject: Re: [CI] pmu changes
Message-ID: <202410281436.8246527d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241023144759.3140161-1-lucas.demarchi@intel.com>
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: e988cf49-bb73-454e-6289-08dcf71a879f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D91VTM2SbW6S0glAWi9vWW40Fkw1T6fU6OZjYGswPpg4fCRQhvJ1cnuWQ5qQ?=
 =?us-ascii?Q?8+sgheSzPUU9dFG/3O/BB+lKo48zbFR/8/sA3OXwx3t4hWqDHigq7EtZO7+N?=
 =?us-ascii?Q?2YGyE3xXlhuCy8XRwR3xmaPt1KJHQZ1MZ6ejzpX2VG7u1N6Z0unkklTHroyM?=
 =?us-ascii?Q?i9pb6N/RSH/n8IGw1Xke3gS4eua0aq9Gfc7LKGqoAqc8L7I6tLqZA7NCpMXQ?=
 =?us-ascii?Q?wxiPQsX4FKFtGZIxtlxyQ4X90/Xjgnnrb4UOuq8S1U9CGOIrcfmEfZoYT32q?=
 =?us-ascii?Q?aAd5uB/wfcfahEtS92sQpP3tUHnDrPTSZw7sN+2VJuXsLGFohjsFMCX7IUGG?=
 =?us-ascii?Q?BbH3kiYavFTMGRfzGUwcBLSki/kGcUfZTu9zhTYgqRibpX4DHhgrvx9o1FL+?=
 =?us-ascii?Q?hblDMb22CSW5O5TZAqCuVHjaFIRuQDEUw87syuUSerOT5DjhCaTeRDupBNbk?=
 =?us-ascii?Q?mtXHIK9xCu5CO+o8S6GKBsVKOYulTmxcmmJPOxX7Oj9vwQFb7vUNnDoL3lTZ?=
 =?us-ascii?Q?hJT1lCD3+K5I4ENi0rYrEWtF9coCzINw1z1fcn0Hd/8RkKuZzfX7cMWUv4dq?=
 =?us-ascii?Q?lWbf+IIhWbXaVRNhLWM0BiEX562bG2fF6X9eZymINu9QjB1igOsJ/FFm8Wpa?=
 =?us-ascii?Q?ekBeqZFt8gKUFyUfWoKL2a3qLywk3WauXh+nLJXuE7kKbcDzX1qkkrVH/xBK?=
 =?us-ascii?Q?vtsRf2n6eMMygJ1SKKALyWN3+NNL2E9GQO03EdinBicoDUfLGibVx6ombdO+?=
 =?us-ascii?Q?4I3hTtglF/gMl8lQDoceMDGiNDHnVF5CkfR+ztw1akpU9yFNg3KHsQXZPl+U?=
 =?us-ascii?Q?uJGk+TA6pNlY4pyZTtRpBDFlDjS8x8IYOUOaKk1y16QI/DXUHZL7QvIX4axu?=
 =?us-ascii?Q?3BbFdeFebnPmpbTAdWDbx7Hm47jBCREiVpCrxBHldjPC7Shm5v4iLSUKKEB9?=
 =?us-ascii?Q?EIfyM6fcAeIatodLtL+mQncW4p40tLJRN9GpIgXaF8IoZhit0T7qtXhWu1Zx?=
 =?us-ascii?Q?/O17q1Rtu0gSWYD+V7wqIsQluIPuigrbljewLSk8bFLK8mGD009bQG84ildU?=
 =?us-ascii?Q?hdWtX3v5EndNaERqj3dQeslKgNijJaTcIas1S5pNZFaSvOeuXWQyEXMzum4z?=
 =?us-ascii?Q?kF3gfsUI0Hh0ILCUQp99Caos9Sq9l2Kh6RMDPaGZv2bVoTMWuTSt4jg+oe4s?=
 =?us-ascii?Q?DT3zGJ1KSnxTZVmGN2PgPP17HnbH2zyRRS927W8Y00jX9YmKjbP9dYx10BfP?=
 =?us-ascii?Q?DBYl2B1MA/YZdhBJ1R13edMZfNxV11FcHuFfKUS9EQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PpZmh37iu5+R9yACJSQgTIB2Cx3K8zsylgjrZGbcofA+5+yNTPcHTrc9RlOV?=
 =?us-ascii?Q?qOnyHnPyxZ84MZR8W9WXFf5O9+k40nfdCwR3BMP5MwWrdi1pok9dY6iawAVb?=
 =?us-ascii?Q?Q4wMpHEcRLuWi81NuBlw9Bv6/OZINHFCPQF6Hv3+Vl3RaPGYUoVro98otmQ1?=
 =?us-ascii?Q?eo9xLh642jInnE1G6ruIz7dlYtP4/bra48fwfAGgHqppbPMoi1LE6U1qvUal?=
 =?us-ascii?Q?+6Y/KAfKLb8olmEuMxu/O0Gs8KspyaO9msWYaViBlpIQRbijt5sL3R0McN7/?=
 =?us-ascii?Q?XdFW/uJzW9imoXCRtiH9kjTkOfIzzBo8GpxTxV4OerkhmOeo+iTwK3j1l42E?=
 =?us-ascii?Q?N3CUZr0Cpc9mKI1zm7wEeiun5p4YyR4u+bQ9SI+YbLONdLp1Gh5lUELbsp0u?=
 =?us-ascii?Q?20zsAaQI2j1PoMn7W+6zdvbsEF4oc3IAhSwTnc24iVJnm9usAHwxEFVMGmWn?=
 =?us-ascii?Q?6beD29qp9zLGn2kr8qWH25WlxAAn3TALZStlmOHKFtN0Pv0phQAE/Gu4KUtT?=
 =?us-ascii?Q?UnVCr2fCKYpOnMsmOvqTAjr2gEBbxTZTDymTYr71FhurNf20vpX7ktZQIjI9?=
 =?us-ascii?Q?7tERgwuPGmCulo9YHoFk1lbXQIdfQXzxTt9iyxD3HBxZxMQWpbcKo7Lc6wty?=
 =?us-ascii?Q?WLd9AbSImWRj9oarwKSPdgLkk5RndPwkvYzA4wKJARpOGtdu6BRVwsxii63K?=
 =?us-ascii?Q?S8ayuVzqLSXOhT2XmxUNicedUxronU+r+585OAmPmVfw+mTm9C93uZjaXJ5w?=
 =?us-ascii?Q?dlyCVTRvtswEP0rQ1siGXoMltTajW00X7QT0ei5vRO6M531xe40wzuNw92sZ?=
 =?us-ascii?Q?q6o37WLqLNE1XKJ22ojhpokneBSjvQmjbxaRatCrZLIXdWpua8S+YkepqFeW?=
 =?us-ascii?Q?DDJWLL8Ox5tWTJLiU2/j56KRHo4HAILISOAW/u0/F+v7jtootuYCzsnXzH+o?=
 =?us-ascii?Q?a5e8+QMJmcosXWpFFihtjCF3Ac0yJaWDGyjJ9/RMxhzd0006jXrRhwilHKFz?=
 =?us-ascii?Q?g/vmYJn7UOGpKpDYcdsPwb1NqCs21s+Av37jU4i81rRuVq3J35VCZESfx2/v?=
 =?us-ascii?Q?veyPXUfAs9Xc8k9TWhfelsrM+9LdGmR+ncZhVb+31md4BflFm0dSUuOahqba?=
 =?us-ascii?Q?fyncg/eQLoUJ7/Ddz4XSmbQn3EvY1BspvYmU3MAsK7zfY2m1T4XbtioQ+gQt?=
 =?us-ascii?Q?kI7cceUASsFvTWqUkk9JCS9F13gUvC+3Xz4NsS3+xTkI7rKjKPLXPyKweykQ?=
 =?us-ascii?Q?Oo0UyGVx2j5L7e45gDN0N+SRVfkKVU7j22SP75jKh+mC0wbU/heNdFhO03MW?=
 =?us-ascii?Q?/70aCWIbwRFmIbjzZudhinMNOvHVs1cFrfW/qXyRqK8PT/zyFa7WgYZzNwv7?=
 =?us-ascii?Q?X1ZevcD+Nb0e2wqmTIdJow4gAZ0pi6ORMRrJY6GjkMU11ZTNXMHAFc/6pnE5?=
 =?us-ascii?Q?kbIfyyTvIIyboWJNncx43kdPszUNv1tZ0SugubAO1UP9ZcDqw5CuIW30H0Uk?=
 =?us-ascii?Q?DFVZ4t4wFRz6LSa46hJy7xRF5lFOLd1KfBwmRdhMW8VLv+5nxGCwY6a4g+LF?=
 =?us-ascii?Q?aC/EiOElD0hvQ3pU4jg0busEAAdTGD1VXCNqXUIkYDABM5Ia+YDtKk28Zyd8?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e988cf49-bb73-454e-6289-08dcf71a879f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 06:34:10.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+Z5mbjnSvnCFA6FR5Ji8KX4oQdXMRQmWYhf6VEbXNRGdbIDD+JdlEg0YcKUy2YA7D4mqGN8Zbe4lz9NoZeEtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4552
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_lib/list_debug.c" on:

commit: c8b7f59b7abb8ef22fba5438b4cb2cd4c28fad0e ("[CI] pmu changes")
url: https://github.com/intel-lab-lkp/linux/commits/Lucas-De-Marchi/pmu-changes/20241023-225141
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20241023144759.3140161-1-lucas.demarchi@intel.com/
patch subject: [CI] pmu changes

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20240923
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: x86_64-randconfig-005-20241024
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410281436.8246527d-lkp@intel.com


[  398.827949][ T3983] ------------[ cut here ]------------
[  398.828239][ T3983] kernel BUG at lib/list_debug.c:52!
[  398.828549][ T3983] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[  398.829680][ T3983] CPU: 1 UID: 65534 PID: 3983 Comm: trinity-c2 Not tainted 6.12.0-rc3-00121-gc8b7f59b7abb #1
[  398.830194][ T3983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 398.830712][ T3983] RIP: 0010:__list_del_entry_valid_or_report (lib/list_debug.c:52 (discriminator 3)) 
[ 398.831079][ T3983] Code: 0f 85 ae 00 00 00 48 8b 42 08 48 39 f0 75 5f b8 01 00 00 00 48 83 c4 18 c3 cc cc cc cc 48 c7 c7 e0 bf 39 88 e8 57 60 7a fe 90 <0f> 0b 48 c7 c7 40 c0 39 88 e8 48 60 7a fe 90 0f 0b 48 c7 c7 a0 c0
All code
========
   0:	0f 85 ae 00 00 00    	jne    0xb4
   6:	48 8b 42 08          	mov    0x8(%rdx),%rax
   a:	48 39 f0             	cmp    %rsi,%rax
   d:	75 5f                	jne    0x6e
   f:	b8 01 00 00 00       	mov    $0x1,%eax
  14:	48 83 c4 18          	add    $0x18,%rsp
  18:	c3                   	ret
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	48 c7 c7 e0 bf 39 88 	mov    $0xffffffff8839bfe0,%rdi
  24:	e8 57 60 7a fe       	call   0xfffffffffe7a6080
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 c7 c7 40 c0 39 88 	mov    $0xffffffff8839c040,%rdi
  33:	e8 48 60 7a fe       	call   0xfffffffffe7a6080
  38:	90                   	nop
  39:	0f 0b                	ud2
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	c7                   	(bad)
  3e:	a0                   	.byte 0xa0
  3f:	c0                   	.byte 0xc0

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 c7 c7 40 c0 39 88 	mov    $0xffffffff8839c040,%rdi
   9:	e8 48 60 7a fe       	call   0xfffffffffe7a6056
   e:	90                   	nop
   f:	0f 0b                	ud2
  11:	48                   	rex.W
  12:	c7                   	.byte 0xc7
  13:	c7                   	(bad)
  14:	a0                   	.byte 0xa0
  15:	c0                   	.byte 0xc0
[  398.832041][ T3983] RSP: 0018:ffffc90001ba7cc8 EFLAGS: 00010246
[  398.832350][ T3983] RAX: 0000000000000033 RBX: ffff8881937bd940 RCX: ffffffff82b5feae
[  398.832749][ T3983] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8883ae33b620
[  398.833159][ T3983] RBP: ffffffff8a2e6e10 R08: 0000000000000001 R09: fffff52000374f56
[  398.833557][ T3983] R10: ffffc90001ba7ab7 R11: 0000000000000001 R12: ffffffff8a2e6e00
[  398.833953][ T3983] R13: ffff8881937bdf08 R14: ffff8881937bdf10 R15: ffff8881937bdc30
[  398.834351][ T3983] FS:  00007fe01c90d740(0000) GS:ffff8883ae300000(0000) knlGS:0000000000000000
[  398.834797][ T3983] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  398.835130][ T3983] CR2: 0000000000000000 CR3: 000000011a420000 CR4: 00000000000406b0
[  398.835529][ T3983] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  398.835925][ T3983] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  398.836322][ T3983] Call Trace:
[  398.836493][ T3983]  <TASK>
[ 398.836646][ T3983] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 398.836850][ T3983] ? do_trap (arch/x86/kernel/traps.c:156 arch/x86/kernel/traps.c:197) 
[ 398.837070][ T3983] ? __list_del_entry_valid_or_report (lib/list_debug.c:52 (discriminator 3)) 
[ 398.837391][ T3983] ? __list_del_entry_valid_or_report (lib/list_debug.c:52 (discriminator 3)) 
[ 398.837709][ T3983] ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:218) 
[ 398.837947][ T3983] ? __list_del_entry_valid_or_report (lib/list_debug.c:52 (discriminator 3)) 
[ 398.838268][ T3983] ? handle_invalid_op (arch/x86/kernel/traps.c:256) 
[ 398.838519][ T3983] ? __list_del_entry_valid_or_report (lib/list_debug.c:52 (discriminator 3)) 
[ 398.838839][ T3983] ? exc_invalid_op (arch/x86/kernel/traps.c:315) 
[ 398.839089][ T3983] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 398.839348][ T3983] ? llist_add_batch (lib/llist.c:33 (discriminator 14)) 
[ 398.839597][ T3983] ? __list_del_entry_valid_or_report (lib/list_debug.c:52 (discriminator 3)) 
[ 398.839918][ T3983] ? __list_del_entry_valid_or_report (lib/list_debug.c:52 (discriminator 3)) 
[ 398.840238][ T3983] __free_event (include/linux/list.h:215 (discriminator 5) include/linux/list.h:229 (discriminator 5) kernel/events/core.c:5395 (discriminator 5)) 
[ 398.840474][ T3983] perf_event_alloc (kernel/events/core.c:5403 kernel/events/core.c:12375) 
[ 398.840728][ T3983] __do_sys_perf_event_open (kernel/events/core.c:12980) 
[ 398.841036][ T3983] ? __pfx___do_sys_perf_event_open (kernel/events/core.c:12868) 
[ 398.841347][ T3983] ? rseq_get_rseq_cs (kernel/rseq.c:201) 
[ 398.841603][ T3983] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:514) 
[ 398.841861][ T3983] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 398.842094][ T3983] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  398.842393][ T3983] RIP: 0033:0x7fe01ca11719
[ 398.842622][ T3983] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241028/202410281436.8246527d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


