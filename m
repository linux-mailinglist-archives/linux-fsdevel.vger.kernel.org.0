Return-Path: <linux-fsdevel+bounces-39823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C063A18DB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 09:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B8C1883B7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 08:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948D120FA83;
	Wed, 22 Jan 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBgI+SJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18A20F099
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535437; cv=fail; b=ZXU90jHYrTPPeE4lpXUnF86oLKI+wKJN1YNFkr/dIqI101wpLw38tif47Nhg9uoBY5SaoUvjOBoNvzEUVorqyF2pu8V0P7fkCiDdFr4WG7NusztuhGKGrGHPz+FnTjfyf8ToMXEc7biOtrdJK8W6S2LId/W67VPTQc6KpOnp9xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535437; c=relaxed/simple;
	bh=yk13HblDgiFZ7SFqjcoM+M/+R6lYYiaytFiABzQnHc4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=onFjys+8a43AmPsSloApYS06+4H6IsT89aXrWj8Y+xEw3rIya7x1BERu+8AML1Ml73iUvFE9uIFWHIQ/IpnN2azVldRSHIsazfrN8t+ipdkyycD6I3FGASyhPNrkidlD/29j+x6neCfFOUwxA9y7yauoQWTxjvqeHppCxFdWUlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBgI+SJT; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737535435; x=1769071435;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yk13HblDgiFZ7SFqjcoM+M/+R6lYYiaytFiABzQnHc4=;
  b=SBgI+SJTmb9RMnrA8RD6qi7gk7pGLgwx+A0QhYx4QtWrFjyHWH2/hqVY
   LF0pZufv0oLivjHNroEXokg6jH2yt9l01tTy3Ca4xi7Eua8ZrkRBZbVGJ
   /1Ao4ZsZAfI3dD6u0Ztj1febtd1fgWuJImq7LaRlQ9dIWQucuBg3FGuOl
   MnEz8yt2MYX8zcoF14A13jKDajC3qdhzV3vVyOI7c9ru7xGY/SZ9tlhId
   QLsl/417V8Rj+baJ6cHJFtkfSGzGQ8H9AXG7gTJUKuV/ATJFB6WAjheyk
   ouBhcA3KNCYw7JHht4m0j3IsdHFJ8YefBbyZzK5Zqxh+XZ8ektc/cwTPV
   A==;
X-CSE-ConnectionGUID: OtstrGwcSAuCywhLKPTGFA==
X-CSE-MsgGUID: PA5vVA++Ty2stR3pKLG3iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="60451189"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="gz'50?scan'50,208,50";a="60451189"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 00:43:52 -0800
X-CSE-ConnectionGUID: F7x/UnQ3R1ORtmz9lhpw8w==
X-CSE-MsgGUID: je8Icg7wRp+0bvAHtHWCgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="gz'50?scan'50,208,50";a="112048795"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 00:43:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 00:43:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 00:43:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 00:43:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyJlD4jvtQyn3Lf0A8pDakAji0pq+gZ6iW2TnFHWWy/qN5BeO2V/fQSuPQUq27EcjVj6Pt+P6xvMgIQPzZXDME4xcyNk/RImHSUhJjUHzTrx2jsKSr0Wq6E07jZwVb/mciEE62EwSxv2cds+fpXyDSBedNF+PSa4LzFVcoALsvvqTVkB5gsCkDLeU9aRMgpOyXVljZL85pk6BkjlqxvB6vPuu6BedxOI/yLRWnaPt+hDQ+d4Gg3tpG6JjeUWU2grEBNHC83aFyHcvW0BH6udQn03UP/360xCXswqXmKXdg5Ij42AN3PD8HBYMT3LL3HHq9lCdGFMkTD/CXxbSgN35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfNhvh0T9+B3CxpuFxzNdqnQQs0/r0vx4Mk0Wa0RlkY=;
 b=XkPGEQrJzcSnJAsSazUjDwO9fsraAVfHq7yNzHRQ6Q2OKtGBLGj2CA2kYsVms7xerdnr5Egir7ZY81PSkIhNMrHoNvhM86CsBPa+lbuVS3mNLpyv59/O/d9bpaHvtYazCedpoamzo4Kl8Q8OB0fQUtDoZhtaAuvlKHw+4YoxWTZeHXlmWmL7rsDc8LUrvcaLkFWMbLRuBXc67yzxESkUV5FBoP2nkFOCg+EYcJ4tZwJS4JU2cJZC/gX+Dk9uh2xJwNl/uNU5sgcQ/2siwfnAqZ71Gs2yTz2e2fi47qBb344nE9v/Y3eo1BNJZPwV2U5XNwaSpW7tZW9OcERMKYpUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ1PR11MB6298.namprd11.prod.outlook.com (2603:10b6:a03:457::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 08:43:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 08:43:20 +0000
Date: Wed, 22 Jan 2025 16:43:10 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, WangYuli <wangyuli@uniontech.com>,
	<linux-fsdevel@vger.kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [pipe_read]  aaec5a95d5:
 stress-ng.poll.ops_per_sec 11.1% regression
Message-ID: <Z5CvnkE+1ETscjR+@xsang-OptiPlex-9020>
References: <202501201311.6d25a0b9-lkp@intel.com>
 <20250120155009.GD7432@redhat.com>
Content-Type: multipart/mixed; boundary="Fr+RsLH3riO3P4sC"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250120155009.GD7432@redhat.com>
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ1PR11MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 7617d7b4-f306-4120-5813-08dd3ac0d2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?3U5gtolFECEK+s3gs2TqY6cpfftO5zB7zqKN/NA3cr7r81kq3wa+r5PVNL?=
 =?iso-8859-1?Q?hFnhZXx9rII6etzuSnSAmFHSVMQ06duyT4Il3pOAJsnkavsYT5CKKNNTwg?=
 =?iso-8859-1?Q?hxkgg2nUEF4wAc57nBBuDVz8OSaHIKbGYEFIu7ujrPgaAPHFojkiPUKtqo?=
 =?iso-8859-1?Q?H7dOMYknGqCVAJCR0UA/xM8ieklwFgQnl/7Anx4sbvgZtEYcGSrDTAnRsJ?=
 =?iso-8859-1?Q?W7ZSJd1hnXOa2bd8QrIeLhBCgx0tPUl/aUBXwA/LhBTKrxJAFH4uvq/45m?=
 =?iso-8859-1?Q?XdWb7VmchkHVmmqJNwyXLnxCS/n1SXgFFi5p7BbtMInU5b21xu3BMHoScp?=
 =?iso-8859-1?Q?WaJRiKbU4afaRyyLKiwnmOF5IC+0CLhmEDmC9lr2NQzJKGTGDMLXYGi1Z2?=
 =?iso-8859-1?Q?OR/XepSixmqgUka2+MlbFyVOuHsT29ZPCSWOu+Z2sFECfxr/ssYUcNCsOA?=
 =?iso-8859-1?Q?rqsCRdLjHvqqYqtvsDZbWDWbkCt4QsKY/Hx/nJMYNV03KKiP7WYCN9082p?=
 =?iso-8859-1?Q?eFU7CTQ0+1nUhxYa7OuL2EFghLDkGBJuvUAXhxkgJLP3TmH/X13lWXt0nG?=
 =?iso-8859-1?Q?4LcrxPlAZxAOTXMsdPbWZEAdi6apfLvE5BD0qZ4njgIFLgYlSLapxGu82V?=
 =?iso-8859-1?Q?/xsklAnOZP+IE5c2GiEqFXP9YNE/YzQ/6i1iVZeSnpilthF9I/u+Qi8w02?=
 =?iso-8859-1?Q?L9W0jkVzzjiKJ3/6txLVvHAwZ+a1n6FzPCrVloeG0Zq3GVKTl48AMOtJEf?=
 =?iso-8859-1?Q?nsxwpwbW68LgpuhdN3znl/oGt9dNkU4xVJvWMMj5c36Ry86OtwF7VT0LLQ?=
 =?iso-8859-1?Q?tgWHf0/bez7WPiZbKvBJpE6pHFOEcoalIsoERsKDPQbVAqhJa9+W8ZlrRS?=
 =?iso-8859-1?Q?fee6+ShVuIyNo9B0RtnDLy6zNutRGsvfiamPWanzVtbe9SW8XuO7ylJObi?=
 =?iso-8859-1?Q?hLuK1hQ2nKENVwd8AmFLfb8uVvyJ0wz/WVL33YlEsfsTACu4++qW+p1E6/?=
 =?iso-8859-1?Q?jDjx/08u5IR54nC2GLZ2BTiUcrnbsVmAzTq6aHi0LTTZ7JzRTJqENkpYb1?=
 =?iso-8859-1?Q?GwcwxSC3Rc0fkQGIR3QzOlV20ABzFY2pVqEgT3rgJG4pAIjZwPp8kqUJRv?=
 =?iso-8859-1?Q?qGngC30EjuLYHrIiUib1+W6Fg9qfGK1LfSYYVRmQpd73VYfcNWdFulu7Ko?=
 =?iso-8859-1?Q?ZF/9DOscm7UKycr3/juPEC1e3yfUyk69d8E43HQZ9KCDHodIfsdpeywKvL?=
 =?iso-8859-1?Q?gJd/iTD17QDvV2j1NA+xFYVs3xLn2OGTsrLj4yTElo/Qa5CEcZQnKHqNIs?=
 =?iso-8859-1?Q?fgoC3CrqCfoxvL0XrwDs9g1gRVZSzLZn5qOg9rSyDfYYEWgDoZk1mRm5Ke?=
 =?iso-8859-1?Q?/rWpWKddolH+CK1sRbG4OtH5exnSzmig=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8MTN+xexTVmFZnrphzNL1S59MK3itEpLX1eZMQkoF6XXNXliIyoeZPv8P6?=
 =?iso-8859-1?Q?D0w8Lgl/zK1OuIZf0rgUHvzsedW/85AQVGBs0vzASHmYDOUoSSjpmqoBH/?=
 =?iso-8859-1?Q?tGRJpyiyqdavROpiFlzYL7PTuIQlLQX4v3fW+WYPkpr42tCA92POwfEVTq?=
 =?iso-8859-1?Q?dlGqGw9wbZ6/sEgKaj433VIu38NyDOgbFYErWQmeNkWjq+cEe1Mff6t6Po?=
 =?iso-8859-1?Q?CxAnS3+YSSo5XOFvwTq1rvKhpW6KlhQYToLIDYMZfYiVjVVU7x9qnXvUSm?=
 =?iso-8859-1?Q?WlSkJq/b4qqHXqKXgvn2jyjKEn1AP711sDg+5I1UKCH1wDvNgcwdAhCf3i?=
 =?iso-8859-1?Q?x7VnZb5yov3Z/6UTQRMs35ttxDrd19d7IfzGTvplYKjmiq9qGtEEecMdz5?=
 =?iso-8859-1?Q?bFBS+9HJvvJsrCrjLrDNIYdjNQzkgkbKkY1lU/pVZNUKPOrVirXbqWL1Bb?=
 =?iso-8859-1?Q?QexF2qYOBOE/RzCXv8uhcZGtSlD0qKSd26UNCQqCRE6qw7O9axDCwoILDj?=
 =?iso-8859-1?Q?l/q4ewnmQpKH0+Nley8fhdyVsE+ReCPUVoc7asLM1l0TWM/ICS6g28UGTZ?=
 =?iso-8859-1?Q?s1ByN60L/fksHFxO8c02FySewxQ9I6siEGVV7burzWG5OoK+MIA+V/ks90?=
 =?iso-8859-1?Q?0w0r/27At6Y2Us8VVpHEH6bGNcDqLTfXmIfJ2Z/zE4WgpBumNKOEarte51?=
 =?iso-8859-1?Q?yapKmNrJAy68xkuMu/oXkTxK81Bz05cQWu1uPjxU64Lv0WZ/MIUfnBpaqV?=
 =?iso-8859-1?Q?vdwGKDl362tArZc+3yHiSpIsU/E5HYteRK5qkmOi+0eJmViiebK9cGb071?=
 =?iso-8859-1?Q?CTsDt3wha7UAo7kcztwckHHekcggy4UEGZahAOtPd6t+qP1+U9S8mS+mM2?=
 =?iso-8859-1?Q?HFsRuSnLpCc7XOXawWmuFrCcB5sBd7fBoVgAkWTlfJMvwn157QouFIsN6O?=
 =?iso-8859-1?Q?7c0xfMHr5eqAAA09N2qqK342fKQOQDpSjt0i+5FE5w212JR+dwUuGeFFw+?=
 =?iso-8859-1?Q?qZ/7JrFUNeVSnh0f19oLLRW2HUrXE1jgmsSkV25m516INnquhR23nSnTj1?=
 =?iso-8859-1?Q?zKqw9ym37VN2fdTJgxQ8BD0KvDiIptdmZxE+C9bDwH4COFoHL5b3GtNyFS?=
 =?iso-8859-1?Q?IOO8glEf9k5uW5HKJy14uBE34W50yTSiUCEOtObE1fxjUfrXXKmsxum2FV?=
 =?iso-8859-1?Q?THXsPZV7uchz0xXEGPywzt/byzkuhwhnf8fBH6+4zr4Olvsy+p1uh2p0Vi?=
 =?iso-8859-1?Q?iPedjWU7YkP/geDVstgG/O9cQuGJgVPaMKL/Pi095h8PtQZxsA26KvRWpn?=
 =?iso-8859-1?Q?U6wJepzL74MGiCw9af3RNwhRj/hWMXTmrDnG8NzMh0S+rWbXf6fcVEWLzI?=
 =?iso-8859-1?Q?ZOY8TGYL1A7vMDEylSTrhdrh8ECwnphVnkJY+Ftvpsmm41ahtfwaJcsJDJ?=
 =?iso-8859-1?Q?M7Ngxzd9UEj4DyJRq1DnKSVauCQVIWKtp2/WX3eo9GGD3BzTOTlEFYDQEi?=
 =?iso-8859-1?Q?AWjHxPyLUmulT1TMMsaPw12F4DtaNYq1fFNM/h/QPUMiBleD+Uwo0hxhgS?=
 =?iso-8859-1?Q?bu/5TgB8GCiGYW9YROZIMpesuzPY1TrZCB7/iYRsJ3nssVpFklcEWBqKZb?=
 =?iso-8859-1?Q?OPhhw0+MdGP/+LjBo97Czqd4m02dqWIRVwGdCb9zeJnz1M3D55O9XyhQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7617d7b4-f306-4120-5813-08dd3ac0d2cc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 08:43:20.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpHGH9Eua2y8evzl+qt1/2/klfSeXSZ8I5Isq0/hhAwP0dmukFDzTl3tq1PxGhsAovqA7MkEsJDUWxE4zJAFJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6298
X-OriginatorOrg: intel.com

--Fr+RsLH3riO3P4sC
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

hi, Oleg,

On Mon, Jan 20, 2025 at 04:50:10PM +0100, Oleg Nesterov wrote:
> Again, I'll try to take another look tomorrow. Not sure I will find the
> explanation though...
> 
> But can you help? I know nothing about stress-ng.
> 
> Google finds a lot of stress-ng repositories, I've clone the 1st one
> https://github.com/ColinIanKing/stress-ng/blob/master/stress-poll.c
> hopefully this is what you used.

yes, this is the one we used.
(you could see it in https://github.com/intel/lkp-tests/blob/master/programs/stress-ng/pkg/PKGBUILD)

> 
> On 01/20, kernel test robot wrote:
> >
> >       9.45            -6.3        3.13 ±  9%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > ...
> >      10.00            -6.5        3.53 ±  9%  perf-profile.children.cycles-pp.pipe_read
> >       2.34            -1.3        1.07 ±  9%  perf-profile.children.cycles-pp.pipe_poll
> 
> Could you explain what do these numbers mean and how there are calculated?
> 
> "git-grep cycles-pp" find nothing in stress-ng/ and tools/perf/

we use perf. the perf-profile is a so-callded 'monitor' name.
https://github.com/intel/lkp-tests/blob/master/monitors/no-stdout/perf-profile
this link shows how this 'monitor' runs.

I attached a perf-profile.gz in one run FYI.
within it, you can see something like "-e cycles:pp"

then for each run, all data will be parsed by
https://github.com/intel/lkp-tests/blob/master/programs/perf-profile/parse

for each commit, we run the test at least 6 times, then comparison list could
give avg and @stddev like
      2.34            -1.3        1.07 ±  9%  perf-profile****

> 
> > kernel test robot noticed a 11.1% regression of stress-ng.poll.ops_per_sec on:
> 
> same for ops_per_sec

this the kpi for this stress-ng.poll test. the raw output looks like:

2025-01-17 00:02:55 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --poll 224
stress-ng: info:  [6458] setting to a 1 min run per stressor
stress-ng: info:  [6458] dispatching hogs: 224 poll
stress-ng: info:  [6458] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
stress-ng: metrc: [6458] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [6458]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [6458] poll          776040080     60.00    451.84   1488.52  12933899.40      399947.20        14.44          1844
stress-ng: info:  [6458] for a 60.08s run time:
stress-ng: info:  [6458]   13457.69s available CPU time
stress-ng: info:  [6458]     451.85s user time   (  3.36%)
stress-ng: info:  [6458]    1488.58s system time ( 11.06%)
stress-ng: info:  [6458]    1940.43s total time  ( 14.42%)
stress-ng: info:  [6458] load average: 44.46 13.42 4.66
stress-ng: info:  [6458] skipped: 0
stress-ng: info:  [6458] passed: 224: poll (224)
stress-ng: info:  [6458] failed: 0
stress-ng: info:  [6458] metrics untrustworthy: 0
stress-ng: info:  [6458] successful run completed in 1 min


we parse this data by
https://github.com/intel/lkp-tests/blob/master/programs/stress-ng/parse
then got the stress-ng.poll.ops_per_sec for this run from
bogo ops/s (real time)  --  12933899.40

again, below data is the avg for multi-runs:
  14516970           -11.1%   12907569        stress-ng.poll.ops_per_sec
(no %stddev since we won't show it if it's < 3%, which means stable enough)


> 
> >       6150           -47.8%       3208        stress-ng.time.percent_of_cpu_this_job_got
> 
> same for percent_of_cpu_this_job_got
> 
> >       2993           -50.6%       1477        stress-ng.time.system_time
> >     711.20           -36.0%     454.85        stress-ng.time.user_time
> 
> Is that what I think it is?? Does it run faster?

these time data are got by
https://github.com/intel/lkp-tests/blob/master/tests/wrapper#L38

below is a raw data FYI.

        Command being timed: "/lkp/lkp/src/programs/stress-ng/run"
        User time (seconds): 451.86
        System time (seconds): 1488.79
        Percent of CPU this job got: 3222%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 1:00.21  <---- (1)
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 222324
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 0
        Minor (reclaiming a frame) page faults: 87235
        Voluntary context switches: 194087227
        Involuntary context switches: 78364
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

> 
> Or it exits after some timeout and the decrease in system/user_time can be
> explained by the change in the mysterious 'percent_of_cpu_this_job_got' above?

above (1) seems expected, we run the test 60s.

from the data you spot out, it seems stress-ng test itself get less cpu time
to run, which may explain why it become slow.

this reminds us maybe your commit about fs/pipe could have some impacts on our
'monitors'. so we rerun the tests by disabling all monitors. but still see
similar regression.
(below is the full list of compasison, as you can see, it's much shorter than
in our original report, since now 'monitors' are disabled, so no monitor data.)


=========================================================================================
compiler/cpufreq_governor/debug-setup/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/no-monitor/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/poll/stress-ng/60s

d2fc0ed52a284a13 aaec5a95d59615523db03dd53c2
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    105111 ± 25%     -58.9%      43248 ± 10%  time.involuntary_context_switches
      6036           -46.1%       3253        time.percent_of_cpu_this_job_got
      2901           -48.7%       1489        time.system_time
    734.52           -36.0%     469.77        time.user_time
 4.472e+08           -55.5%   1.99e+08        time.voluntary_context_switches
 8.817e+08            -9.8%  7.957e+08        stress-ng.poll.ops
  14694617            -9.8%   13261019        stress-ng.poll.ops_per_sec
    105111 ± 25%     -58.9%      43248 ± 10%  stress-ng.time.involuntary_context_switches
      6036           -46.1%       3253        stress-ng.time.percent_of_cpu_this_job_got
      2901           -48.7%       1489        stress-ng.time.system_time
    734.52           -36.0%     469.77        stress-ng.time.user_time
 4.472e+08           -55.5%   1.99e+08        stress-ng.time.voluntary_context_switches

> 
> Oleg.
> 

--Fr+RsLH3riO3P4sC
Content-Type: application/gzip
Content-Disposition: attachment; filename="perf-profile.gz"
Content-Transfer-Encoding: base64

H4sIAAAAAAAAA+yca2/bxtLH3/dTEDgITg9gM1zu7JKM4Reu7TZ+Tm6wHbRBURC0RNl8rAtLUkn8
nJ7v/uz8qQtXsm5WYjupXZSRhjvLmdnf7I0U/+Hsj/5++IfTSvJqWKRtZ9B3zN8L5+cic/4n6Tsi
cDzvhSdfKM/xPV+Zsldp0k4L52NalJkp/sIRRthOqsQZdDplWtUVyCjyx/Iy+7/UcWq5ksr3VBjw
yU6aVJYSTkahJr7MoKz6SS814u51vlvmxW7hsdagdIq0myYln9KukK63W7TErud5Iti9TJK0pZJI
tVWkTek8LToNW0153y1ayr0UwtM69ES7TRemXFK0rsz5z6GOcfl+0cqHpYlHN+vzhXy/IU0+Jll3
IjSidlq2zPeTfpV2fzz9l/NbOujzv++6SZX1hz0npNA7PD/6rS6etU3hX9L+0NQNnR29I0juhOZ0
NaiSrtNLe4Pihi+hpSYOi3P9Eyv32iODnpuoPL9I+62rXlJcl8/ZURxMdFqDou3s/unsXjq7u0Wa
dKusl+4LZ7fn+Eo7u4kRtwbDfrUvPP6Tzm7qtG5a3bR8kefO7sB5XvVyXIFrdNGKu0eO5MJGt744
/18WrecXWf95+jHtV88/JVnl5Kbhdqu0rExBvu5gWDnkOcZ4FDKmo1n3pxfccXYcE5J95z9O4Otw
h48RHwMPR4Gjj6PEkXBUOGocAxyhG0A3hG4I3RC6IXRD6IbQDaEbQjeEbgjdCLoRdCPoRtCNoBtB
N4JuBN0IuhHrmhDhKHD0cZQ4Eo4KR41jgGOII3QFdAV0BXQFdAV0BXQFdAV0BXQFdH3o+tD1oetD
14euD10fuj50fej60JXQldCV0JXQldCV0JXQldCV0JXQJegSdAm6BF2CLkGXoEvQJegSdBV0FXQV
dBV0FXQVdBV0FXQVdBV0NXQ1dDV0NXQ1dDV0NXQ1dMGVBFcSXElwJcGVBFcSXElwJcGVBFcSXElw
JcGVBFcSXElwJcGVBFcSXElwJcGVBFcSXElwJcGVBFcSXElwJcGVBFcSXElwReCKwBWBKwJXBK4I
XBG4InBF4IrAFYErAlcErghcEbgicEXgisAVgSsCVwSuCFwRuCJwReCKwBWBKwJXBK4IXBG4InBF
4IrAFYErAlcErghcEbgicEXgisAVgSsCVwSuCFwRuCJwReCKwBWBKwJXBK4IXBG4InBF4IrAFYEr
AlcErghcEbgicEXgisAVgSsCVwSuCFwRuCJwReCKwBWBKwJXBK4IXBG4InBF4IrAFYErAlcErghc
EbgicEXgisAVgSuKhPPfHae6yblz9Zwf3x2f/hyff3h3HL88OD369eD0+F879Vi87wgOe2vQ72SX
jcKHb9+/OY9f/hofvnsfH344fHV8ZlT+45RJL++msRkLskF7Z/y1U6R/Ov/lyupBZHJiZMLJu7/O
T47M/6+P/zo8ePXq8OXByZu/TNV/nRwdvzk/+fnk+HTHjFZJO+4Mip6ZCxido79evT0733HaWZlc
dFMeFUxIsv6VuXZVf8nNAJeVaZzl5rs/uWrWjpNuty6Sfm51zaAcXw55HNrHFGVm9GkPe72bF8Pm
2EPISUJOEnKSkJOEnCTkJCEnCTmpkJMKOamQkwo5qZCTCjmpkJMKOamQkwo5qZCTCjmpkJMKOamQ
kwo5qZCTCjmpkJMKOamQkwo5qZCTCjmpkJMKOamQkwo5qZCTCjmpkJMKOamQkwo5qZCTCjmpkJMK
OamQkwo5qZCTCjmpkJMKOamQkwo5qZCTCjmpkJMKOamQkwo5qZCTCjmpkJMKOamQkwo5qZCTCjmp
kJMKOamQkwo5qZCTCjmpkJMKOamQkwo5qZCTCjmpkJMKOamQkwo5qZCTCjmpkJMKOamQkwo5qZCT
CjmpkJMKOamQkwo5qZCTCjmpkJMKfb0CVwpcKXClwJUCVwpcKXClwJUGVxpcaXClwZUGVxpcaXCl
wZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUG
VxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpc
aXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXCl
wZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwZUGVxpcaXClwVUArgJwFYCrAFwF4CoAVwG4CsBV
AK4CcBWAqwBcBeAqAFcBuAqEaow9wvmxHHSqT0mRLhxxPkfWmHP2a3z0/vXrD19quFlvkLGGlfGY
cZ0W/XRmHLn6WH/v9ZK8/tQa9Hr1pyopr+tP6wxEdR3+tJI4/Zy26q/X5U3vYjDSvMg7cT1k1cMX
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
v3QhgFY2/luvKo4p/pf/5v9//X/5fMEtXXADAA==

--Fr+RsLH3riO3P4sC--

