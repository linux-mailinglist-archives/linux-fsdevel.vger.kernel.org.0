Return-Path: <linux-fsdevel+bounces-69731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6419C83FDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CEFB34970A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C502D8DAF;
	Tue, 25 Nov 2025 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oH3RdG+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228D18C332;
	Tue, 25 Nov 2025 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059630; cv=fail; b=A+CnlHMmyWW2CmnLRK1m9zQupbQ97gZLMbrBpZOq7xMGmWIGespyj3QOollkJiTfLJzJjVHYj0Ac2xBUqIUaX8vRV5Epp+CFJO6QAsBvEp6/VhW0EDG9LOIlTCI8o8mzMJXd+h45AV9huDSWIdOCLa9+AuH73GQJygCS0yWfTWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059630; c=relaxed/simple;
	bh=H0A06Pnenq3dAPynci5AQV86F4UkMBZPw8DceG9loeU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EBfWq9iiobh/4ik6HUSeJI6AYkZ5RuF5AfvPBSBoIbqvwIZmaS0twx7U+q8ibL+Kz6G1F5YxVTpK2jaoBdiBS3I5hsclqCEhkLZ0C84rEmp1P7qf/20KRYQpHPfHhsxWWoB830XOiQdj8Srke5nZQqF0DVk4r2KIM8eMBVBQKtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oH3RdG+n; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764059628; x=1795595628;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=H0A06Pnenq3dAPynci5AQV86F4UkMBZPw8DceG9loeU=;
  b=oH3RdG+nSoX5p0g3lQMZgFStvU3G/tjNv2Zb3+z3JzEGI+SwWaHbu8d7
   iHwKnqSUPg7OeQXQkPMRMxpOmjsgcyLJEkH0MnVIbl2owYx1ZJmpvZxzt
   xNTjaC2DeFkoGL6wCZQG+jfYAequZ5sE5r+2zTp/DoDH3Zd4SBjOtnYbi
   0zsuvLgclXEeZ6PV9bJFdGebCBBaAICma5GY3FeZtqU1ZpbQzI4mbOFeZ
   mtV2dE/oBEk9xsib2ypf3SSKCsNGMVoRM05s1ZEai6O9ZdXSnDMgddLjm
   YeI/aJVHgoU58etg6wyYIdbq8rFmfqcssU7y3D6QOSDOGWuxBaclUEjpv
   Q==;
X-CSE-ConnectionGUID: FGz75D4ERtGiOTVxxlGfgA==
X-CSE-MsgGUID: 5dhWCPPEQrqR4+lQxuvOsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77546537"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="77546537"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:33:48 -0800
X-CSE-ConnectionGUID: HThkj9UsRraErmQNLRxUbg==
X-CSE-MsgGUID: CE+WUPCdSRuIcaCDGpZ3mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="192461379"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:33:48 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 00:33:47 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 00:33:47 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 00:33:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7+D3rDP9BAUwPm5NDn2oAeI8vgq9pB+u5bR/JTnEWqvgyfIFmuTUwpXCpkRBl52LblUA27jchNGqQaAe5tUCUEBbRu+5mX/JmWvmN6TEpOiuL2N/ox+JWuU37JXqTKGZxKRCb3nKAEjyOlj7c1gvgu8Qsfbi519rv8T+bbxVw9W7rmAAAEnUXTBiEmAXXhAsQ2zPxoAXeuupb9/pRjEnmdTSYa9Ucsp2vqaj9gr2qXWCedHyyBJaO/tujf4zXUIEjh+soVrJkrbKU8Zz2H3UeO+BZ576MZGVz7Q8luinyKuDBpohGtTR/G2bDt9MNWTLEZtETkXAYiUFkLMSlvAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4DeE9Q6qfPfJ/fH8r/jpXUnlB24Nkxq1uILSxOOlz0=;
 b=UpY0220d/9f1CtL+G+/bA4Cgd89vXbLH9U2q8sH3jXzPIPaldsoUIzfYRf7LU19FmxFrPkvpGG3jeF+8XsYjRlZ4INruxfyNqYxEZVB1qTslhVR8mpEIRZ0oeejhJJWqEisijSmss1EAmhthRNiJdiSqFVS8HOJD6CIGXIkCjc3otnsnf8FLO8LMRMPDJyoQaBvKhdr70dlSFMqLCm7IU/t5bYQ+2+eTddARtVLvmvYcEL0tJVTtk4Dp2XWaSGxdqCRAHUIfL/lVBYiw49UBuSt3B6JEDCajHU4oDW+CHN94mrTTKwCOgxH/Tq/MsPrQuH3QMXXUy1dmcdYwp1vzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:33:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 08:33:45 +0000
Date: Tue, 25 Nov 2025 16:33:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Andrei Vagin <avagin@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [linus:master] [fs/namespace]  78f0e33cd6: ltp.listmount04.fail
Message-ID: <202511251629.ccc5680d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: KL1PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::24) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 577a216e-2786-498a-9158-08de2bfd58db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4KE5bUw18dL4H3fO+jbRbx0r+TYHL3sRiz1VNYs7jwS3S810bEy98kOD+ShE?=
 =?us-ascii?Q?Zcyftbuhy1Ws/4W+2+bk2mmxGtswT5q9ca/Edv1EpxeZ0T2xAu4S68y4xN8o?=
 =?us-ascii?Q?Wemjf/uJoq4cckbu2aoq1ioSIEEYxZXGjwszxCl2QNhSZWbmtfTmcGLdJ7Lk?=
 =?us-ascii?Q?jtdpNdObU2EqffK7ouoQnOorsxozDsvSwfMlLAdegCXIstBXxKxC2sh0YMzG?=
 =?us-ascii?Q?aA2nklumQNazEZGabsI2agjNh3SRxD1sitPjKwms19ZW7hoYDyov1C8uVTwI?=
 =?us-ascii?Q?cOltQWtEpHaZE5v5zG2hf67XVVThOUSte8wl0Cu0aL2/WP1/aSZdpAZJNd+1?=
 =?us-ascii?Q?YQg1azvT5xy1hSs457DApwF2KvMn7y6ePzmx++t6hcCDvFmcafN1TaJvSHgR?=
 =?us-ascii?Q?Mgbr+iFNutqCrZPvyN/4MN525ibt+PCkqMBwl4IzmFeJDLqvZrQxD7snKYja?=
 =?us-ascii?Q?0ZsatSafEYIwcU3bVbNKIQpNjHkfgLmTKHjfSWSVDZ4kr/Bmj5T0FGsW4HzS?=
 =?us-ascii?Q?TCuXATsHvMNhmKpBzv7/TizPMuVJpAVCTwYbscDE/H694JUMnTJ/KOFtchFu?=
 =?us-ascii?Q?LcUAzXe9iH/9gAHYc7B3pBQiMZ4uWd7wakT7WA/FLdV6jLQn2XGOAvtxa1gW?=
 =?us-ascii?Q?NGvSNyctAZH8U58w/UKVioV25EFx7OxxxKsRcZGKD5b4QZNvt8DzRPLeKTgy?=
 =?us-ascii?Q?WyhET3r00t24cD5l0akAUF1gNi31KiBirJdkWSYBwO3/zhtIkt+Sj+VBPgSt?=
 =?us-ascii?Q?nM0aKYHLpDGaff4F9wMiK5GwcOCFqoIOyt9fxsIdVRu6VLAe49nY7S/ULtmu?=
 =?us-ascii?Q?RPOhYP9iiUiPyZlV4W06i0ZbS0XMh3ZdaiPcEfBtGWKh9yLL4obtJHLn1OSP?=
 =?us-ascii?Q?Vx4vmPlH2pedV0XsKnlx2czmV/IyqAgwzkoPLhvqslYAbaIS8FUiMAsaLGww?=
 =?us-ascii?Q?Y8o0wmEaFs49TMwMyJfD5bjTrA6+d6y7OzFgtbzUW/T4Q7XlbbHiDuqE5zQ1?=
 =?us-ascii?Q?DZCl1LKoUgBiieMv6wyCscsOuSQ3VodZSxymKnl3fRpLxkqm0gGz6tLhbgn/?=
 =?us-ascii?Q?5cQpAxYLkS9iGokzFreGx8CJhyxiUCI5/FgUMYT/IzCOf4UC7Zh5yNniqB+h?=
 =?us-ascii?Q?bu8g7KfIss37kTSF9IlfuTSrz8UcuGd/C3wWwCOvYdVMs5Is+Wi6DWxrudQR?=
 =?us-ascii?Q?jspI7KOXAiLQ+OfCY3iH/jaU7ov+9bIJY6SRbamhWSTpxXKQNljN5qRi3giU?=
 =?us-ascii?Q?nc2fGp3Zgq39sTrY5GeM/P8PPXRraCTd2CA0Qnd9YfrL3idKcuyc24+jJXa+?=
 =?us-ascii?Q?/ba096MwrifI1IzoZvGUKyVpTRpICiNFUzia2yLwvgzkyGLonqhl6YaGdmwX?=
 =?us-ascii?Q?/m6u7B1btXNU0n3nTr8O5RAVXLdN/jsMGEswC0N7PGQRNhviu6fAXh04FhL6?=
 =?us-ascii?Q?tHyed38Khv+CjUs2ZP3vJT+LY5HlQiYhBzUYqOVRyiHQm2Ng4n3gHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zP+D+2VFGZ1fHtMP3hU4xtAtiAZ62Lgb9Q/pmY2bsk6e5rQ6wzvZBejiPCLb?=
 =?us-ascii?Q?p7fXjtGrF0bD5H9Zpj7HIQUnSJWjoug9QXrpIqUJp/fYAxbWZyjsJlrNm2kp?=
 =?us-ascii?Q?rpLSpoqmCcuIObs7Quu6RMT/o21D7h1tN2znaQEnGjvW114PLesWeXqjlJ0I?=
 =?us-ascii?Q?VJ6M+snh/YCGe2zl+2VSRH/Bm81UZFQRgKr8q59Wwkyvd2muyKfkAPrtPTtG?=
 =?us-ascii?Q?qnWJjILFJt6N5sTcvHqMgHnb3ajhdwN7b/Ufr3Sh3eppilaaEQAgyG2mqmp+?=
 =?us-ascii?Q?ElJwoeNKOOtWZCCBRA8iaTmsyymZEH090LBZvmkfO0AC91qvD0lU9xKizv0e?=
 =?us-ascii?Q?NGvjzpYzkZsMhO6oiSRYhr55ws77sQPezRQiQZdo5e8LrJAR3WbkayJBMt/u?=
 =?us-ascii?Q?7dcBTTYh183itKhEx8tks7ToNl9IWSRxokDqRkFvnuFU4UyCk16Ase8M2WPu?=
 =?us-ascii?Q?6XX9IBi1EjKGLIqZBC8KTr9eAnrpu4ddvSdjEZZHZlMSVKUOawXcLN+pxtaC?=
 =?us-ascii?Q?kOXgiW7pn/VDUujO8qGzNTDavP3+ynvGsJfePDf1CIH8Z535y1ZKn1wbTkuy?=
 =?us-ascii?Q?vfsS6WEu0uxQ9O0k0BXFfLrhyjrNZtJAsMBcLlJ076Kvu5kYd1IjyEsKfxNX?=
 =?us-ascii?Q?8fciHttRFeTQaKdzF2RFsurPeCe4t1yIn82bF6fHEkhTv7ecp9tSxmlVhkmb?=
 =?us-ascii?Q?FXeib2p1qkOIedlw/Tr3wIkzTKwkCwzdrrHqbla5zQ0Or2vNES178hQUSpf0?=
 =?us-ascii?Q?mf24F5UFo1aqhtXG1l0LOiXmwYdFng35z5CfPQa+MrDzzdysRAsKHhzxaKdO?=
 =?us-ascii?Q?qPbu4VaTMBDUOA/rB6oW2VOF/nhAb0tD72JG9l8AH74Xf+MUyrzWzG6JGl3z?=
 =?us-ascii?Q?HnuwR2JuSghK5Szkg6jbEbJNT34BOkNED9dzURK823q30wM0hA+RqgBm6mxO?=
 =?us-ascii?Q?1r8b2RxCB0SDGeUKQ42vmRiWt1koMnAq7UIu5iXFb4p3OyEBTGyHBuNCDaYd?=
 =?us-ascii?Q?8V/aLXNRgZR4PZG7UiQevixlWUC/nJwaK3MB2BZPZlexsSMBwyhOs1jnHdcZ?=
 =?us-ascii?Q?HmQoQRPdHWfn9edtpWh3iaXsvJYe7kFULg98UtLKzRJ89pdD2paVwBMCrRuq?=
 =?us-ascii?Q?c5BKE11enNvHAOlmFmXHoVYUSRz+W+DJIPunKnHf+INFG1up21n5fyhnhotN?=
 =?us-ascii?Q?cju5GVLz1/N65TqOHovTY8ft27HHDjD4eYIDwzjf7/frkhulfCiH4vSrvnmr?=
 =?us-ascii?Q?ceKq4hTfb7trnCImpeBc/ig3sQJ/vXXCuNkf9ktpQOGtX4STf97vnPhOr0qx?=
 =?us-ascii?Q?Zr0+GgJ7hIB3cD6PaeGFcRxa+pXEVI1VfCi6eJITCLXt42tjp+w++vQgpCFD?=
 =?us-ascii?Q?j/mEueAhjzOY35Af8Eh/MMIn1KJj3GW4vWiOa8BmtGDEhIMHPuECJLzM+BhU?=
 =?us-ascii?Q?HVNGqkFobeeovYkqnZwSywBZxC0oY8YgeLxP4EIrjFgOYzYWjairNe7tvk3W?=
 =?us-ascii?Q?+K5DWzdEGnJkGWuglqdr2fxZCaX/Lrim3EbuG0pHbXSoJOvc1QZkE3YBUwTZ?=
 =?us-ascii?Q?QpjwhtSwcnzndKXEmp9C/XDS/ajPzsBMZ2wBLVU85O203sgSeQLexT9Ejntd?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 577a216e-2786-498a-9158-08de2bfd58db
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:33:45.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tejFa5NpYRQbyWIB+5b+Mc6U29vh5ZeCs/JxorrsdEeMPT5FQ+yDyMzIzB0waGWkLIfqyfxwPsWVMuzyEzm9Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.listmount04.fail" on:

commit: 78f0e33cd6c939a555aa80dbed2fec6b333a7660 ("fs/namespace: correctly =
handle errors returned by grab_requested_mnt_ns")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master fd95357fd8c6778ac7dea6c57a19b8b182b6e91f]
[test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]

in testcase: ltp
version:=20
with following parameters:

	disk: 1SSD
	fs: btrfs
	test: syscalls-06/listmount04



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (=
Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511251629.ccc5680d-lkp@intel.co=
m

2025-11-20 21:35:09 export LTP_RUNTIME_MUL=3D2
2025-11-20 21:35:09 export LTPROOT=3D/lkp/benchmarks/ltp
2025-11-20 21:35:09 kirk -U ltp -f temp_single_test -d /fs/sdb1/tmpdir
Host information

	Hostname:   lkp-ivb-d04
	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
	Directory:  /fs/sdb1/tmpdir/kirk.root/tmp9k8rfwr2

Connecting to SUT: default

Starting suite: temp_single_test
---------------------------------
=1B[1;37mlistmount04: =1B[0m=1B[1;31mfail=1B[0m  (0.016s)
                                                                           =
                                                    =20
Execution time: 0.085s

	Suite:       temp_single_test
	Total runs:  1
	Runtime:     0.016s
	Passed:      7
	Failed:      1
	Skipped:     0
	Broken:      0
	Warnings:    0
	Kernel:      Linux 6.18.0-rc1-00119-g78f0e33cd6c9 #1 SMP PREEMPT_DYNAMIC F=
ri Nov 21 04:59:36 CST 2025
	Machine:     unknown
	Arch:        x86_64
	RAM:         6900660 kB
	Swap:        0 kB
	Distro:      debian 13

Disconnecting from SUT: default
Session stopped



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251125/202511251629.ccc5680d-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


