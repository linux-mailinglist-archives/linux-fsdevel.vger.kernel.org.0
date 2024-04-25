Return-Path: <linux-fsdevel+bounces-17723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0398B1CA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 10:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB35281C65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 08:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329206CDBF;
	Thu, 25 Apr 2024 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1bwnUtf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2E67A1A;
	Thu, 25 Apr 2024 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032821; cv=fail; b=J3/Y0Auev5wgLkiu/sBniRE8S+YKiD5Kj8llXefkpNTBsxS+7EWI5PQTBuYeQDBPRZcAK8QEtrwNdqdMemsjPWda6ruERtLhz4qbGSWXQSNnU2VtexE4WMJvBhK/T2vtkzb60p2t25ic8DVDF5C2G+aKpMIk1bV2XqINmyVyJ50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032821; c=relaxed/simple;
	bh=jXukQoJnqpN6BkOe6ooKtAqWy2ckpNyGE+43oWX041k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dto+H9oUvg9l5uGbvKfmMWbtHNxONVeu7OMnFO6h4vs8LXsbTwbjkjrnd4mMLeXSCNRbeYRYRg0AMlLj2HPxAuDljmCC/WRRSbZK6D+DZ34wr6VnTyb8SRGKYHT9/BEJ96XaU8Oq784mr4FwFf3myKCqqfUUKxvqBs4G3EwTx5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1bwnUtf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714032819; x=1745568819;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=jXukQoJnqpN6BkOe6ooKtAqWy2ckpNyGE+43oWX041k=;
  b=c1bwnUtfROzf3NUmIPdZJ6OHbN80P26/omkzvgLxvFDYDRGj3UJkXHFL
   /d0gUavJjl2UOFIyskAn8EgVT61/QOrzZZm0vXPSUcMvMJZ6u8gkCyD29
   pbckXgkdRvzP2xrLKWiXvqMX71g4Mgi2G2zva846qoSeNcN8xt4ufj6f1
   VQ6TfZ4ObivrZVl5L+AerLPpO7i6qD1ZOoD5cbJORJSxcKz78JlT5MnZC
   nRRbeLjnVjLltG5rYLgzBSDTvXHTK7AEt8/es+JpS/piux1QXiTajXJVx
   lG+jwhuzu8bq5o+tfRo3Ngmzu4rJCM16m+SWm5pXnOrYFqLEYw+PTrb3V
   g==;
X-CSE-ConnectionGUID: mFp5FIV7Tj+63euYBmKlUw==
X-CSE-MsgGUID: 5nuGS/m4QFeGC6cv0SWVSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="21122651"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="21122651"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 01:13:38 -0700
X-CSE-ConnectionGUID: 1BHdBE0LS2e0lgD/9nGy7Q==
X-CSE-MsgGUID: SPfb8SdyRP6lspp4NgAYcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="29477719"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 01:13:38 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 01:13:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 01:13:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 01:13:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmMe/e1LE/9IvUX7zF80UJEex0YjEd9WEkdAGFxEoYZ241l4Q2SMjRe74/MSTUxshFlSxtAOtm/JJOBlwGJdu0C8C7TjkXyJJ05gAyU6i/TcdzRKwJ5sbRo2ziPfBnyJIG35XlDlgLEr58kop2OP2/uMEJEoawV2+87UouXBbLifcZ0yw3uCP0UWn50dv0X5f3yRvyCirVO7xDdsDBWXAWvKKPXRecUGhp7zte8MSsRUf4ysMux5bsAyYgQ7nrcqLYsXD4rHyYryVxpcPIMY7J/QDPy/bjUAZP5kC6XmiCd4ShHJoj/tA4xeeJm28VRZ6oC4PZo95BCjMmRUc2hZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kq6KkI+nBe2tEP3MQQTWOgfMnrKVEe17JHpiDrH6Oc=;
 b=Tmp3nZlafQV2iSzc2YngPKwh6ll+4cJD1ZYPJ4MD5SjCCrN+SrbfJNbd7IR/TlfHPyo+CRAn10iazgeBOcjDjsuuWqXyr3ZSUd4jaZ2e/r7vffXBOXn6D20DjsCVXfosZaRZJEgaya6tBoITEcntZsxbPl4GkHFf2HrN+tkcYsCi1SVPrd1gANq0Nnvu5wsD9RJSd4ZPyKhTsFS+UDnWXb9qBqS5xfIuQq8ET1gDMNxUN+L27ctfMpRK4XVzNYtSNpkcA20aqO1HAtfHCwdni8fHzJ4a0p/82lBi4BRox9z7IRd3fJs5wu6ChC0R0bNQnaOPGhrjhiOayFKRDGkqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5325.namprd11.prod.outlook.com (2603:10b6:5:390::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 08:13:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 08:13:30 +0000
Date: Thu, 25 Apr 2024 16:13:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Stas Sergeev <stsp2@yandex.ru>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Eric Biederman
	<ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andy Lutomirski
	<luto@kernel.org>, David Laight <David.Laight@aculab.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Stas Sergeev
	<stsp2@yandex.ru>, Stefan Metzmacher <metze@samba.org>, Jeff Layton
	<jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Alexander Aring
	<alex.aring@gmail.com>, <linux-api@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Christian =?iso-8859-1?Q?G=F6ttsche?=
	<cgzones@googlemail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] fs: reorganize path_openat()
Message-ID: <202404251525.39b4af4e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424105248.189032-2-stsp2@yandex.ru>
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1517c7-06d4-41b7-90fd-08dc64ff9791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PLn2WexrI/urcnCz7a+CVVgFyD7vHxw4nZkxuGsBqKjsgcmoQ2OJQeLzdBs3?=
 =?us-ascii?Q?FRBgWAdEAqGcNzRQx9xQRBcUo1lvagD0ueK07xTMKRFBMWWaaz0HE4IpuOnH?=
 =?us-ascii?Q?8qlIJfWv0Q03bomng/7rv3tShZKRbj5TUlpe7PrDdAbyYAk4Mk0oCErOhV5j?=
 =?us-ascii?Q?ZbmvueawM/QnkMNGa4FjDLalqmtAsA7acJYD28q0d3fQayw8hcEKj9zbjz4C?=
 =?us-ascii?Q?EN3BByHAxOdwNzt8oW7ae6XnIu93kjypim5CTbVX3jo4WBQWqZ/R0nS2lJVh?=
 =?us-ascii?Q?155aFqbuviNEgStyO5eCZ92NoGspPPH6NIAgw6FAOhwDBSOvZHmxLyxqvzSa?=
 =?us-ascii?Q?l8VW3CNc5HCMlellTdPrp02x9D/ryWMPMFKluOyhbW2QQJZWmM3H3RiRZ4Qx?=
 =?us-ascii?Q?JhDG/DbtE0jmr8WZdg1Y8K1DvxcWxK3S+8qDZ/3t3DlqcSyqsaK0zAEhLZMh?=
 =?us-ascii?Q?S/H8PNDNTqaho4XhdEhOJv9XRWTGGDBvJdN6khPqjMAeobyxnU9IfY7wRv9g?=
 =?us-ascii?Q?j0FYgLd+DcEi+gmV+4aLAl+Lrp7ydB9QolWSXwijcobcwXi7y+2wypOpv0RI?=
 =?us-ascii?Q?Kr9sOBPLYCd66Oiv7i20j+CrI4fRUX055xJ/RKJkVSz9J+XPYJi8uTSROszs?=
 =?us-ascii?Q?5gCOMd3FDU8WOUxOzpADSLetaApLkkIDD8sJh4MW5P5d3yIcDtbcQ2iuLtLv?=
 =?us-ascii?Q?CUwqcDrq9iks7vYFwXkS8PWsfoGom7ZS4xwnB4bctHuissnsA9D1aoBae2AV?=
 =?us-ascii?Q?E5Ck/bdR7LHcFvqtZi18f700Cyw9Lkt53FwzZp5VecvYA9535zRffxvt33/M?=
 =?us-ascii?Q?AE9+JVO4TYg9rM6k19N4SLkvZMLg8EyZIxYU16fuACuH2Vsanmip0+syGiei?=
 =?us-ascii?Q?V+1HbDDSNebJosPSsIFQV0YByRe81AGRBfuoLmFO6D4rVWjTfEpd1/C/qxVE?=
 =?us-ascii?Q?jphRlh3oFtOBAQ4+QYdwpW76+u+mbTvsznF48dxwkwwcisJSkhLyA1xsut2q?=
 =?us-ascii?Q?wIBKimWsETJLx5ETccq9NnHEPUNOf3qYWAD63VAutkVxOp8Mb2aLe2sluK0w?=
 =?us-ascii?Q?eQeLrEIci3x5vGKoDA4FWiYdArKh1R+B5Rxae73kmquLAldUOHL8wtI79Cs+?=
 =?us-ascii?Q?QbOQLsMYIscQsv/y8cvx8s2KQyWr+6OeFSM36xo97aqKTj9Q8vNvos26/QlL?=
 =?us-ascii?Q?uXlnJDHG2TeGYUFrST6YoYfH8Q2rET/uvx81CUwtg59YfUn4lJJgQXE81bM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HBoN3U/joXqcwKFJSBj/WwOd/zYnQM+R9LEvKWLLTyzOEols7UX4YC3e/l21?=
 =?us-ascii?Q?+lrNwYZBGs2bKpdUZHmvhRKfo5Csdjcsu+peY4dajrWdX1yR+8AmSxrW3uHp?=
 =?us-ascii?Q?DFvKjDY85lIdkwRPvCu2AgvhalghkwmnCE2jRCFODFEwlrIsWx3CKObcaeVX?=
 =?us-ascii?Q?keHYy5TX8g4o5n+AwUfqsxq3VQhwyBCWYAST0Zfz/ySribxv9Iy970U/EC5G?=
 =?us-ascii?Q?NXRHM1fdzSa4ElJSfljgYSt+62Z/yrHjGWHNDLXPhsMX/Rjti/KiYW4hSYA/?=
 =?us-ascii?Q?NRhuJNDfJSJ583Str3BGhgk4CwpN7LiZVq/RpbW4OvWkGd7si7ShHJVltO+T?=
 =?us-ascii?Q?iXfMxolv1EdYXvPh78q3RX/xZ/QNJIEpFscIU4ME54iu29iJyrRcmQGccZaM?=
 =?us-ascii?Q?5cWKLHxg1p9B4INWtP2H9q2CpcASefKXwznYIF4A7tqGBOQWoZAETz4i9CfZ?=
 =?us-ascii?Q?m7dYRvlxc/b3wsjwyU00XwnqB85VkSEHnROCFqwQBpZbfxVGdxzVgGMbCYzi?=
 =?us-ascii?Q?B9xRuT9LK3KRoBwFDkYvXYVeVSFo52BbK6cBn/5Vuw8gyQpIPYP9pg5QIKEg?=
 =?us-ascii?Q?ki7dOuY/C7maLWF2po14QZeb2zTIpSr7565OMJ+ZdT7nau+e83uAIhgyA6fl?=
 =?us-ascii?Q?JqNOBZS1eKj+VtikcVvWfY/V6dszfjuKxtJkmOsxlRwAAzucO/2YChc8bpAH?=
 =?us-ascii?Q?HTwZBw7bGBXN1Dmm92T1tWn69TIUkZrV9zLnzS08NIbOmS37CAoc0s2/AWta?=
 =?us-ascii?Q?6VXlC5OJxuhmj6xg3l6kSBCuD6aDhY68O/BubyEtqHwH+ybsnkZ9EddgbHvo?=
 =?us-ascii?Q?49nrLOVxdrm8ZkENzo5c42hz7h8uraHaEgcEGeXM0+uliWEi0hsOtA8fFKNw?=
 =?us-ascii?Q?bdb94l8/j/W2QuAwgVXt38CJS85X2lFA+MqNy2zK121qMUx/2rOmq/WiU6ZB?=
 =?us-ascii?Q?LT8AU8bJykChyW1kCPsuEZyte+7y1khE+ommE8zxUAt2cJ+BKun1gX9Nnn8h?=
 =?us-ascii?Q?4Lwnqczn70M/ORZSna6BApW+2Bx8Zu3sV72U8CL6SyaH450thoTmi8IIGT4J?=
 =?us-ascii?Q?jcpn4o5OyUwZoJbo1SIcWK4Qe+Qt1rJMgYhWheFPoRMdL0rOUlMCNAiraVng?=
 =?us-ascii?Q?/o+avzJc8m8hLHIPdj8PMWR/Pj0Wl7l0G+95s279iMYDr/4AQAMCGXxPjWI3?=
 =?us-ascii?Q?3jY2Vlv7USjI7dO+jZb2/gRHsNq9H0VLxTYdXfbesw0GjIXFghVpXXyNjJQd?=
 =?us-ascii?Q?IWTuKCSBUktKuXZphBAwdTor0wVjsxnXa4w/bIrYU41wR3SHVBC/RGcd3CGs?=
 =?us-ascii?Q?MuvPb/t2M87/x9nsQeFMZcH3c+8JmOgRyR/omCssaKFR0FxzAxy5EjpTnilV?=
 =?us-ascii?Q?Pme+D29BDfev2xZ7aYQghkJx/OAn+7adsR6W3v0iiWhZDTfVUiSFUfrFXNyA?=
 =?us-ascii?Q?8FuyBkZ1PieHKaD1aLsLfmBxPl2gnQOVv94v5HNySS5Hkoqb7w5Fy7bE52Lb?=
 =?us-ascii?Q?1nhxpriPsAOEohZk/Bl23M+EGBcfo/sZC0tiu3N3SLQZ5H2/DhLSJoIHSEa4?=
 =?us-ascii?Q?y4WKE4XqG9SrOUn6nO2zFpu+mTh97Zz6fnNettL3O8watwt31f/6/CqLo792?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1517c7-06d4-41b7-90fd-08dc64ff9791
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:13:30.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EWVdukuy11Wpd1J4VMovKgXOVQg94nl0qFhmJLi41XWBaRg+XrYophcxY5fOkGXmDythLxJjplNhhbdQ+Eylw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h" on:

commit: 831d3c6cc6f05873e33f4aaebafbb9c27618ea0b ("[PATCH 1/2] fs: reorganize path_openat()")
url: https://github.com/intel-lab-lkp/linux/commits/Stas-Sergeev/fs-reorganize-path_openat/20240424-185527
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 9d1ddab261f3e2af7c384dc02238784ce0cf9f98
patch link: https://lore.kernel.org/all/20240424105248.189032-2-stsp2@yandex.ru/
patch subject: [PATCH 1/2] fs: reorganize path_openat()

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------------+------------+------------+
|                                                                               | 9d1ddab261 | 831d3c6cc6 |
+-------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                | 6          | 0          |
| boot_failures                                                                 | 0          | 6          |
| BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h | 0          | 6          |
+-------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404251525.39b4af4e-lkp@intel.com


[    0.591465][   T33] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:315
[    0.592508][   T33] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 33, name: kworker/u8:2
[    0.593515][   T33] preempt_count: 0, expected: 0
[    0.594071][   T33] RCU nest depth: 1, expected: 0
[    0.594633][   T33] CPU: 0 PID: 33 Comm: kworker/u8:2 Not tainted 6.9.0-rc5-00037-g831d3c6cc6f0 #1
[    0.595637][   T33] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.596216][   T33] Workqueue: async async_run_entry_fn
[    0.596216][   T33] Call Trace:
[    0.596216][   T33]  <TASK>
[ 0.596216][ T33] dump_stack_lvl (lib/dump_stack.c:116) 
[ 0.596216][ T33] __might_resched (kernel/sched/core.c:10198) 
[ 0.596216][ T33] kmem_cache_alloc (include/linux/kernel.h:73 include/linux/sched/mm.h:315 mm/slub.c:3746 mm/slub.c:3827 mm/slub.c:3852) 
[ 0.596216][ T33] alloc_empty_file (fs/file_table.c:203) 
[ 0.596216][ T33] path_openat (fs/namei.c:3796) 
[ 0.596216][ T33] do_filp_open (fs/namei.c:3833) 
[ 0.596216][ T33] file_open_name (fs/open.c:1352) 
[ 0.596216][ T33] filp_open (fs/open.c:1371) 
[ 0.596216][ T33] do_name (init/initramfs.c:373) 
[ 0.596216][ T33] flush_buffer (init/initramfs.c:452 init/initramfs.c:464) 
[ 0.596216][ T33] ? __pfx_flush_buffer (init/initramfs.c:458) 
[ 0.596216][ T33] __gunzip (lib/decompress_inflate.c:161) 
[ 0.596216][ T33] ? __pfx_nofill (lib/decompress_inflate.c:37) 
[ 0.596216][ T33] unpack_to_rootfs (init/initramfs.c:520) 
[ 0.596216][ T33] ? __pfx_error (init/initramfs.c:59) 
[ 0.596216][ T33] do_populate_rootfs (init/initramfs.c:714) 
[ 0.596216][ T33] async_run_entry_fn (kernel/async.c:136) 
[ 0.596216][ T33] process_scheduled_works (kernel/workqueue.c:3259) 
[ 0.596216][ T33] worker_thread (include/linux/list.h:373 kernel/workqueue.c:955 kernel/workqueue.c:3417) 
[ 0.596216][ T33] ? __pfx_worker_thread (kernel/workqueue.c:3362) 
[ 0.596216][ T33] kthread (kernel/kthread.c:390) 
[ 0.596216][ T33] ? __pfx_kthread (kernel/kthread.c:341) 
[ 0.596216][ T33] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 0.596216][ T33] ? __pfx_kthread (kernel/kthread.c:341) 
[ 0.596216][ T33] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[    0.596216][   T33]  </TASK>
[    1.603321][   T33] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:315
[    1.604448][   T33] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 33, name: kworker/u8:2
[    1.605466][   T33] preempt_count: 0, expected: 0
[    1.606028][   T33] RCU nest depth: 1, expected: 0
[    1.606599][   T33] CPU: 0 PID: 33 Comm: kworker/u8:2 Tainted: G        W          6.9.0-rc5-00037-g831d3c6cc6f0 #1
[    1.607761][   T33] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    1.608136][   T33] Workqueue: async async_run_entry_fn
[    1.608136][   T33] Call Trace:
[    1.608136][   T33]  <TASK>
[ 1.608136][ T33] dump_stack_lvl (lib/dump_stack.c:116) 
[ 1.608136][ T33] __might_resched (kernel/sched/core.c:10198) 
[ 1.608136][ T33] kmem_cache_alloc (include/linux/kernel.h:73 include/linux/sched/mm.h:315 mm/slub.c:3746 mm/slub.c:3827 mm/slub.c:3852) 
[ 1.608136][ T33] alloc_empty_file (fs/file_table.c:203) 
[ 1.608136][ T33] path_openat (fs/namei.c:3796) 
[ 1.608136][ T33] do_filp_open (fs/namei.c:3833) 
[ 1.608136][ T33] file_open_name (fs/open.c:1352) 
[ 1.608136][ T33] filp_open (fs/open.c:1371) 
[ 1.608136][ T33] do_name (init/initramfs.c:373) 
[ 1.608136][ T33] flush_buffer (init/initramfs.c:452 init/initramfs.c:464) 
[ 1.608136][ T33] ? __pfx_flush_buffer (init/initramfs.c:458) 
[ 1.608136][ T33] __gunzip (lib/decompress_inflate.c:161) 
[ 1.608136][ T33] ? __pfx_nofill (lib/decompress_inflate.c:37) 
[ 1.608136][ T33] unpack_to_rootfs (init/initramfs.c:520) 
[ 1.608136][ T33] ? __pfx_error (init/initramfs.c:59) 
[ 1.608136][ T33] do_populate_rootfs (init/initramfs.c:714) 
[ 1.608136][ T33] async_run_entry_fn (kernel/async.c:136) 
[ 1.608136][ T33] process_scheduled_works (kernel/workqueue.c:3259) 
[ 1.608136][ T33] worker_thread (include/linux/list.h:373 kernel/workqueue.c:955 kernel/workqueue.c:3417) 
[ 1.608136][ T33] ? __pfx_worker_thread (kernel/workqueue.c:3362) 
[ 1.608136][ T33] kthread (kernel/kthread.c:390) 
[ 1.608136][ T33] ? __pfx_kthread (kernel/kthread.c:341) 
[ 1.608136][ T33] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 1.608136][ T33] ? __pfx_kthread (kernel/kthread.c:341) 
[ 1.608136][ T33] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[    1.608136][   T33]  </TASK>
[    2.602317][   T33] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:315
[    2.603414][   T33] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 33, name: kworker/u8:2
[    2.604433][   T33] preempt_count: 0, expected: 0
[    2.604985][   T33] RCU nest depth: 1, expected: 0
[    2.605547][   T33] CPU: 0 PID: 33 Comm: kworker/u8:2 Tainted: G        W          6.9.0-rc5-00037-g831d3c6cc6f0 #1
[    2.606689][   T33] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    2.607825][   T33] Workqueue: async async_run_entry_fn
[    2.608140][   T33] Call Trace:
[    2.608140][   T33]  <TASK>
[ 2.608140][ T33] dump_stack_lvl (lib/dump_stack.c:116) 
[ 2.608140][ T33] __might_resched (kernel/sched/core.c:10198) 
[ 2.608140][ T33] kmem_cache_alloc (include/linux/kernel.h:73 include/linux/sched/mm.h:315 mm/slub.c:3746 mm/slub.c:3827 mm/slub.c:3852) 
[ 2.608140][ T33] alloc_empty_file (fs/file_table.c:203) 
[ 2.608140][ T33] path_openat (fs/namei.c:3796) 
[ 2.608140][ T33] do_filp_open (fs/namei.c:3833) 
[ 2.608140][ T33] file_open_name (fs/open.c:1352) 
[ 2.608140][ T33] filp_open (fs/open.c:1371) 
[ 2.608140][ T33] do_name (init/initramfs.c:373) 
[ 2.608140][ T33] flush_buffer (init/initramfs.c:452 init/initramfs.c:464) 
[ 2.608140][ T33] ? __pfx_flush_buffer (init/initramfs.c:458) 
[ 2.608140][ T33] __gunzip (lib/decompress_inflate.c:161) 
[ 2.608140][ T33] ? __pfx_nofill (lib/decompress_inflate.c:37) 
[ 2.608140][ T33] unpack_to_rootfs (init/initramfs.c:520) 
[ 2.608140][ T33] ? __pfx_error (init/initramfs.c:59) 
[ 2.608140][ T33] do_populate_rootfs (init/initramfs.c:714) 
[ 2.608140][ T33] async_run_entry_fn (kernel/async.c:136) 
[ 2.608140][ T33] process_scheduled_works (kernel/workqueue.c:3259) 
[ 2.608140][ T33] worker_thread (include/linux/list.h:373 kernel/workqueue.c:955 kernel/workqueue.c:3417) 
[ 2.608140][ T33] ? __pfx_worker_thread (kernel/workqueue.c:3362) 
[ 2.608140][ T33] kthread (kernel/kthread.c:390) 
[ 2.608140][ T33] ? __pfx_kthread (kernel/kthread.c:341) 
[ 2.608140][ T33] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 2.608140][ T33] ? __pfx_kthread (kernel/kthread.c:341) 
[ 2.608140][ T33] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[    2.608140][   T33]  </TASK>
[    3.648001][   T33] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:315
[    3.649103][   T33] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 33, name: kworker/u8:2
[    3.650109][   T33] preempt_count: 0, expected: 0
[    3.650660][   T33] RCU nest depth: 1, expected: 0
[    3.651223][   T33] CPU: 0 PID: 33 Comm: kworker/u8:2 Tainted: G        W          6.9.0-rc5-00037-g831d3c6cc6f0 #1
[    3.651979][   T33] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    3.651979][   T33] Workqueue: async async_run_entry_fn
[    3.651979][   T33] Call Trace:
[    3.651979][   T33]  <TASK>
[ 3.651979][ T33] dump_stack_lvl (lib/dump_stack.c:116) 
[ 3.651979][ T33] __might_resched (kernel/sched/core.c:10198) 
[ 3.651979][ T33] kmem_cache_alloc (include/linux/kernel.h:73 include/linux/sched/mm.h:315 mm/slub.c:3746 mm/slub.c:3827 mm/slub.c:3852) 
[ 3.651979][ T33] alloc_empty_file (fs/file_table.c:203) 
[ 3.651979][ T33] path_openat (fs/namei.c:3796) 
[ 3.651979][ T33] do_filp_open (fs/namei.c:3833) 
[ 3.651979][ T33] file_open_name (fs/open.c:1352) 
[ 3.651979][ T33] filp_open (fs/open.c:1371) 
[ 3.651979][ T33] do_name (init/initramfs.c:373) 
[ 3.651979][ T33] flush_buffer (init/initramfs.c:452 init/initramfs.c:464) 
[ 3.651979][ T33] ? __pfx_flush_buffer (init/initramfs.c:458) 
[ 3.651979][ T33] __gunzip (lib/decompress_inflate.c:161) 
[ 3.651979][ T33] ? __pfx_nofill (lib/decompress_inflate.c:37) 
[ 3.651979][ T33] unpack_to_rootfs (init/initramfs.c:520) 
[ 3.651979][ T33] ? __pfx_error (init/initramfs.c:59) 
[ 3.651979][ T33] do_populate_rootfs (init/initramfs.c:714) 
[ 3.651979][ T33] async_run_entry_fn (kernel/async.c:136) 
[ 3.651979][ T33] process_scheduled_works (kernel/workqueue.c:3259) 
[ 3.651979][ T33] worker_thread (include/linux/list.h:373 kernel/workqueue.c:955 kernel/workqueue.c:3417) 
[ 3.651979][ T33] ? __pfx_worker_thread (kernel/workqueue.c:3362) 
[ 3.651979][ T33] kthread (kernel/kthread.c:390) 
[ 3.651979][ T33] ? __pfx_kthread (kernel/kthread.c:341) 
[ 3.651979][ T33] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 3.651979][ T33] ? __pfx_kthread (kernel/kthread.c:341) 
[ 3.651979][ T33] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[    3.651979][   T33]  </TASK>
[    3.705833][   T33] Freeing initrd memory: 185612K



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240425/202404251525.39b4af4e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


