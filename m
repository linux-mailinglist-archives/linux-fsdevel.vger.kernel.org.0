Return-Path: <linux-fsdevel+bounces-51413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A35AAD68C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4B417E616
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DD022172C;
	Thu, 12 Jun 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm5CtD/w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC43211499;
	Thu, 12 Jun 2025 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712679; cv=fail; b=F5URN0qqAqBwJfBZOcNJqpdyrhHgQ0LoQRW27bgoe7HvKEIiPOSTvoCLVRHZUi11Tyuc/HepFcvJ3azOFiFqX8NmN+pUX4Tg0yIfMqTOqepNPzddBfBQuGxmToU/HvcFbXZKMLKA+LKjl8BaqinE71go6/39E0lXpSJ0GFvw1Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712679; c=relaxed/simple;
	bh=Kw3NQpLoAoaEHn0/pPzBWntVGyjPNmexzv4jy/b633Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lyHvmQ0eDO8gnlo5+Qykfbchuq+pRBgaBzTZez+z22ErIwgQbHZy4mTyWgX/G/06+qbpgIdylNUjM1K0352vPUK1d9h6wuN19MOldE74Wy+jriz2qFJw1ULlPOvrvBmDghSf9fsYY+YjqVUXsYH/pPGCgxwRHrln4Eecx9tUoho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm5CtD/w; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749712676; x=1781248676;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Kw3NQpLoAoaEHn0/pPzBWntVGyjPNmexzv4jy/b633Y=;
  b=Lm5CtD/wNSBRoZib0tDEwxR+rlPjGHMtoLmIB3FmLqgXChXWmNN7Yhta
   vfDCKk+d1/2yL9Vr6JSSa5AryLWiLStQ74k9k2vHRKt1eXgyMYASpBcff
   YgQvA1gBB82j8+PQ/DxfQN3UCnaGSE6ZZlHRPX3QO7Dkdw7ta2A2vyDof
   equ7pAG3RIl1otdA5ppXFZyq6cIwMhyjYHthbm2hazpShhnSdfJJ8t2/r
   ZJJbR3/SVDWTLa2OF9ndz7v3m7P0XnyxH6AUMeiyYF0SqQY6NbregLQkW
   DMhLJjrqqM2tw+zGe+DpPwFlGvkyoF1SgJTDEW905JlmDdd2ipoaPABIH
   Q==;
X-CSE-ConnectionGUID: pNtLvfzzS3SEHtV7F4StJw==
X-CSE-MsgGUID: QwJF8fU8R0mWDaW7eAirCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="39492169"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="39492169"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 00:17:53 -0700
X-CSE-ConnectionGUID: X6SR0YttTXaDEwtxhAs4Gw==
X-CSE-MsgGUID: RbmInZvfS0SKLTiiSRBcRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="184663518"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 00:17:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 00:17:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 00:17:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 00:17:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q799yBdaX/QKHoEsaTaN2pLY4KLg7EPzaIXVxkZYy40A9WWH2VBoTeCpv/GIQWxROVJ/JzIBZKrvbj/dZBcwhi9eWnNogLMCRRsOqmc2PWssD6nxiuBrc0s4PhJ3iH5nW03JV9UhusfvDBVfsxTaKr2oTNJvo+/ykFafKu5xp7CsTYPHKI3S+xDb1XiDwHQrnfUMFyc1THp/2PU8BQ54P5ny/fxa+mUZSuPis9cqQfUEGusIBfHPednlV6zFODrKT1s1/VK+4OjH2VPVQMfeHHxfzVENBdOVYIgAxoXv2prbkp+ZTKI8wsKQjL9udjVuB5YoNv27VrO56BlmuGa5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4pqNfwO+3eDDENVxz66MA6e6PWtXfSl3K90mALiJhQ=;
 b=bYQBcUMGTdky4QQUDRRI8QlJZl9gmoe6VzRiTo0oQyq6/Kqa0x5OFz/KNDKwW4/GaeGTwfWY4prFasbDuyr3CPpCnTEk9r0is0uOCwi0XWGKuJlRiQpiOjivVDyviQMFpCCan5lOV5Wk8U2LOQ9NAoN1GoH75RX49OnyIXozJPg2lR7gwHBdNCWQYAfb9jwTx8iA7c5dwKVFKIVmEyHW5f0vKIsU5+ao8Kj8/fAaUk69ytp5uaXGA4KeTwUSs5wmeizS9WXQzkt0QNVVjSeGMJ4lZ+zqBnF6/dy+qYdqP7wyk7WeVG543K8L8HbHIPgmjgqMNXc9FAyvhQeglJMVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.20; Thu, 12 Jun
 2025 07:17:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Thu, 12 Jun 2025
 07:17:44 +0000
Date: Thu, 12 Jun 2025 15:17:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [select]  5730609ffd:  will-it-scale.per_process_ops
 3.9% improvement
Message-ID: <202506121540.6eafcec4-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0041.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: f96a775c-2946-4dc8-d95a-08dda98139f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4GN88GxhRb9g3mj1+Umr2sCJ0x79Jxe9blDHPQRrmhXhRyyyxVAF2FC0B9?=
 =?iso-8859-1?Q?K04yVRgjYk4YsS2THp9DFfAF66VtyXpljLBY/oke1euZyiYNiua7TQPlqo?=
 =?iso-8859-1?Q?MgXeHtVqmX89CgAE/hdsVu51QlHfvdjlwZWg+2mExr9SufAfunKfHmdVFZ?=
 =?iso-8859-1?Q?v9dx+aa39o5VQ2ALBlbLRl3GOhN2OJkDM6903/sMgSBA3bMKgp24bOpONx?=
 =?iso-8859-1?Q?p/AYZ9iVY3j9/BlZK6ftdBDnVLnQiYC5gaABXp0B5QhMVROq8KAdBbI2aE?=
 =?iso-8859-1?Q?7gi+H7G8wI/+r5TJOXu76cn7wTc4qpBHQ6D9RLBi0B/fU3tOPJxXil/s08?=
 =?iso-8859-1?Q?Yc9lvF93QcituqWo6fqMkvkAJC3V+NN3iBSuqf88bStRyxsv5kgyC3iZLH?=
 =?iso-8859-1?Q?tcBL4WxXmWDy6elPMI/z/ornOsWvjUAHtyE1xmJ2vu+0FST9V5yeyqxQLP?=
 =?iso-8859-1?Q?MnyYILuZePIEf0NKyQfpTqx/PjMDmm8lxK/GnX6G0bqgafBXZivzP1yIcm?=
 =?iso-8859-1?Q?LNX6TBaciLLqGrxwQNiKE/OyP5OwUJkrqK4ggp1/i3rVZTdSHkvDhWhPig?=
 =?iso-8859-1?Q?hJDgAF6vN5W9ZORCsuTBD8fPLNLvttUAmEdYr4BKg6aSYJL4cO7HAC5Bi4?=
 =?iso-8859-1?Q?qWQ0jOXPHMSAQwlWv4EsY2PaHqzpbbenNPSjx/wtrFyA6Op9hgfLD8SL9+?=
 =?iso-8859-1?Q?33z5HbRkMV4CHAxN0WsuiGPVPO4vo6TJnKU6dE7GwZHhsRnw0sGlbfBf1H?=
 =?iso-8859-1?Q?2sUhNNwAiBjmmWzCMJWaU/0oiZd++DHbwi4Lm/tTCKCyITvwALuzCj3QIE?=
 =?iso-8859-1?Q?o1xoHc/wOzr9cY8K/jQL0t9pF/whorNtYHVPUHS1CPWzxzdqubrXBH7lrW?=
 =?iso-8859-1?Q?IwNZoxJZS+K+T7Zw89oo5+iQK9rc2O0zeDQjxxDH1wfzmdD/sq6WUdtXKW?=
 =?iso-8859-1?Q?FTL8p3tr3H4OxlsXr4RgAqEhYqet3K0lvXPj/jCJCsZPPm0u/bFEgJNFl/?=
 =?iso-8859-1?Q?UZoCbMZdT6kQFlPikap0Ios4dg0GZSbWRxsnxDIUPQaHUJQl42BKRRilIS?=
 =?iso-8859-1?Q?JqY0KIWxpp8FHYfQxHKjKN/cJJEmRaTYuOSxbzkhj6wRBteftvEvGFhSYW?=
 =?iso-8859-1?Q?vI538GKxM73C82e/JX5yr6eLb2jUcwkqaUtB9GO7gb3BJaEhpK8LlS+0Uy?=
 =?iso-8859-1?Q?bbFn67mFhZHkkpNIZrpJBdIw1aEGzQrIE/2ZdX3zsUyeKPhQbQZ7YQX0pC?=
 =?iso-8859-1?Q?QW/77x7C/vm59+Kn6v+nW1Hata625H+0ZrJ8dF5MmA5qhw4CRuS62KfDzn?=
 =?iso-8859-1?Q?3Y1vXw0+iEfzYWJUcGNyzlK/+g/FUxf0kIGgO3FJXaDKRR7oPWesu6V1tX?=
 =?iso-8859-1?Q?YsFE6s485uewMBebH7HDBWOylpHL0njCN0O4qTANjT9BllYrTJOb025/2Y?=
 =?iso-8859-1?Q?qHFwoc6v/hMVYwzW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?K/5/9zMqbqM24CoYg1dqw2ItkvsMHQ0D9Q6B8MGHiUxVAbLwGEWbkoUyeq?=
 =?iso-8859-1?Q?mazLYLkLQAwqdo6rfGePXVQfaH+mwcFNtzD4RR+J4vNrvcncTmk0ZGy01R?=
 =?iso-8859-1?Q?ypDm5u106xDXe6K2gj7rL5m97VVJ3s7BK9oxJDf9wvg3MqFltfxR9GrEZe?=
 =?iso-8859-1?Q?94VKRb0i8+UYLi4awD/utH71lDHprhgSLlrYfpxrcjoh8tMDUhXX11IQnt?=
 =?iso-8859-1?Q?2BtnhZ9S8ac24NIsyCW7eqDb0DBs6Qv5aKAYMVB8cA/bow1fwAg8WXoxzG?=
 =?iso-8859-1?Q?ko17BfMPls4m0GeMFiGRFfv2j42b40rBc64/c+dZUkx0H1p3sYs2QZli65?=
 =?iso-8859-1?Q?0tSLOwoVDUjrkuC+IPX5qdjIAXcXXsWevTmPqcuxXe53sqWImsZk+c5GqC?=
 =?iso-8859-1?Q?SznzXjjZPsm2FGNmo8Vi7d1jGVTA3L9xzgCN03fHuyzST0rFG/Ozh+aY/A?=
 =?iso-8859-1?Q?eF75uphmPDLM0gbstoXMw8AGvGez59niAVvZF7OUf/arHLKS6hXJNVnT3n?=
 =?iso-8859-1?Q?mSsd9da7BWTwfhMke8m4XRbGvSIgLV/JBkxQ+yXd+9AJXiBCfV1o+7ZHAN?=
 =?iso-8859-1?Q?jMIgSypcNLJNKJyuIhKEVIo6y4b5BVSu2MCl3xJEH++HdjqS8yRxCFk7kF?=
 =?iso-8859-1?Q?hIaku97ZD7OVZ6zUsBzS7+Or/DshISOrOoYRoumYAgoqnbRFGwEg8Jkavh?=
 =?iso-8859-1?Q?8nzbYFQsohfJ9o1nOluEnkTOvH7HM5WtFwWQ0C72yZUiL9UOt5siwNfjk9?=
 =?iso-8859-1?Q?nnc3y+9yNXuCf7Rh399YzJ7sUo1PlQt+GQAR9S71iPF47chbE2NgkYlctH?=
 =?iso-8859-1?Q?4Hk5HJ5UcHxqcu55r+AB2u7CDonVTW33TWvP2CjIC0OkboUoKEOr+jPsUE?=
 =?iso-8859-1?Q?c/opEg1zJ8I3CJJ+QU+/dyEKH8DWLuezBpJOfT9wmfqChXwspm6w+JOURc?=
 =?iso-8859-1?Q?bKHzLY+CsWsZMjJPHUvR2XQsu+WjMY6RCxDthY5QsHT6w3JVacmzTSznZF?=
 =?iso-8859-1?Q?D660rCII9XYMUG+oEtDr7AKLA+EjrndrIF40CcPVzFZKSMtJEHnnW0LhNL?=
 =?iso-8859-1?Q?zzfazabSEhkNNyx+5+rPDcPUFziOoxmE2XbX3+OkcisWQ0q522to7jPfq1?=
 =?iso-8859-1?Q?GiOUXoeGcFiEw7oQRvFA51WxOV7SfifwsngpUTMLsrpIgIQwt/dAouUahV?=
 =?iso-8859-1?Q?xHGHJqdPtA7RVUsqgy+XCtC1I9F0IKs4v8Xp9WVTtuxXsA0GjHh3iry0CG?=
 =?iso-8859-1?Q?yWjvCnhwji6TPzRd8xAm1ZreL7RbBUo99cP+iK5h5mSdH7gpxo2uo6+qPW?=
 =?iso-8859-1?Q?Y40wrhvEUmcyHuEdENnBh6nRMXpVJxrjhnKTE/+gJqlb2p+LMNQ44F6pKX?=
 =?iso-8859-1?Q?GEjNBQX9GERpU3yEpsEajFdC1k5TeBqPMIVZDUchCn6xj0ype1alqS8jXX?=
 =?iso-8859-1?Q?3muLSJOI9ZBFpu3xkIoDH3cSqCK7qfTd4m0EKlFhabxe/wrvCR58vTIADD?=
 =?iso-8859-1?Q?s5t6mwWTo+9ad4xyjygzRiAdZJJ5miFCNPa1RBY5cgYGDglKP7UlouoY/X?=
 =?iso-8859-1?Q?SWWLYhYeqmy5F9Uqk+TDSQQO7k+hSICGL4pBpdfGDIEIlUnKWcZuT5eTe/?=
 =?iso-8859-1?Q?ZK7gOAIIcGzjXYqMlv73J11Cay5PiWV57RGJGD/l3E+slxHaJpDFsK7w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f96a775c-2946-4dc8-d95a-08dda98139f2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 07:17:44.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/LipNFUkLdzLpuxUytLrdnBMmMJBiAp9fo1s2di/JDOMuuF3tbRcwZxr9ec8r8oeNAwmVl7y0imqjrqbiMp8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3.9% improvement of will-it-scale.per_process_ops on:


commit: 5730609ffd7e558e1e3305d0c6839044e8f6591b ("select: do_pollfd: add unlikely branch hint return path")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: poll2
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250612/202506121540.6eafcec4-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/poll2/will-it-scale

commit: 
  f1745496d3 ("netfs: Update main API document")
  5730609ffd ("select: do_pollfd: add unlikely branch hint return path")

f1745496d3fba34a 5730609ffd7e558e1e3305d0c68 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.08 ± 31%     -35.8%       0.05 ± 31%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2800 ± 91%    +420.5%      14576 ±121%  proc-vmstat.numa_hint_faults
      1013 ± 37%    +226.4%       3308 ±101%  proc-vmstat.numa_hint_faults_local
  25518332            +3.9%   26506874        will-it-scale.104.processes
    245368            +3.9%     254873        will-it-scale.per_process_ops
  25518332            +3.9%   26506874        will-it-scale.workload
 4.802e+10            +3.8%  4.983e+10        perf-stat.i.branch-instructions
 1.475e+08            +3.4%  1.525e+08        perf-stat.i.branch-misses
      1.04            -3.6%       1.00        perf-stat.i.cpi
 2.702e+11            +3.9%  2.808e+11        perf-stat.i.instructions
      0.97            +3.7%       1.00        perf-stat.i.ipc
      1.03            -3.6%       1.00        perf-stat.overall.cpi
      0.97            +3.7%       1.00        perf-stat.overall.ipc
 4.786e+10            +3.8%  4.966e+10        perf-stat.ps.branch-instructions
  1.47e+08            +3.4%   1.52e+08        perf-stat.ps.branch-misses
 2.693e+11            +3.9%  2.799e+11        perf-stat.ps.instructions
  8.15e+13            +3.9%  8.468e+13        perf-stat.total.instructions
     42.32            -4.1       38.22        perf-profile.calltrace.cycles-pp.fdget.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
     69.75            -2.1       67.63        perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     70.28            -2.1       68.17        perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     72.20            -2.0       70.23        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     76.46            -1.8       74.67        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
     58.10            -1.5       56.63        perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     94.49            -0.5       93.97        perf-profile.calltrace.cycles-pp.__poll
      0.70            +0.0        0.72        perf-profile.calltrace.cycles-pp.__virt_addr_valid.check_heap_object.__check_object_size.do_sys_poll.__x64_sys_poll
      0.92            +0.0        0.95        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.54            +0.0        0.58 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      1.94            +0.1        2.00        perf-profile.calltrace.cycles-pp.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.68            +0.1        1.74        perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64
      2.34            +0.1        2.40        perf-profile.calltrace.cycles-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.89            +0.1        0.96        perf-profile.calltrace.cycles-pp.kfree.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.85            +0.1        2.98        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__poll
      5.86            +0.3        6.16        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__poll
      7.26            +0.5        7.72        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__poll
      5.00 ±  2%      +0.5        5.51 ±  2%  perf-profile.calltrace.cycles-pp.testcase
      2.27 ±  3%      +0.6        2.84 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__poll
     42.25            -2.8       39.42        perf-profile.children.cycles-pp.fdget
     58.21            -2.7       55.52        perf-profile.children.cycles-pp.do_poll
     70.35            -2.1       68.24        perf-profile.children.cycles-pp.__x64_sys_poll
     69.87            -2.1       67.77        perf-profile.children.cycles-pp.do_sys_poll
     72.26            -2.0       70.29        perf-profile.children.cycles-pp.do_syscall_64
     76.58            -1.8       74.80        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     95.09            -0.5       94.58        perf-profile.children.cycles-pp.__poll
      0.71            +0.0        0.73        perf-profile.children.cycles-pp.__virt_addr_valid
      0.99            +0.0        1.02        perf-profile.children.cycles-pp.check_heap_object
      0.19 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.poll_freewait
      0.54            +0.0        0.59 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.70            +0.1        1.76        perf-profile.children.cycles-pp.rep_movs_alternative
      2.09            +0.1        2.14        perf-profile.children.cycles-pp.__check_object_size
      0.89            +0.1        0.96        perf-profile.children.cycles-pp.kfree
      2.56            +0.1        2.64        perf-profile.children.cycles-pp._copy_from_user
      6.28            +0.3        6.60        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.30 ±  2%      +0.3        1.61 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      3.84            +0.4        4.22        perf-profile.children.cycles-pp.entry_SYSCALL_64
      7.33            +0.5        7.79        perf-profile.children.cycles-pp.syscall_return_via_sysret
      5.01 ±  2%      +0.5        5.52 ±  2%  perf-profile.children.cycles-pp.testcase
     40.83            -1.6       39.20        perf-profile.self.cycles-pp.fdget
     17.11            -1.0       16.07        perf-profile.self.cycles-pp.do_poll
      0.16 ±  3%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.poll_freewait
      0.65            +0.0        0.68        perf-profile.self.cycles-pp.__virt_addr_valid
      0.98            +0.0        1.01        perf-profile.self.cycles-pp._copy_from_user
      0.42 ±  2%      +0.0        0.46 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.54            +0.0        1.58        perf-profile.self.cycles-pp.rep_movs_alternative
      1.08            +0.1        1.14 ±  2%  perf-profile.self.cycles-pp.__poll
      0.88            +0.1        0.95        perf-profile.self.cycles-pp.kfree
      4.39 ±  2%      +0.2        4.59 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.22            +0.3        6.53        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.41            +0.4        3.78        perf-profile.self.cycles-pp.entry_SYSCALL_64
      7.32            +0.5        7.78        perf-profile.self.cycles-pp.syscall_return_via_sysret
      4.82 ±  2%      +0.5        5.32 ±  2%  perf-profile.self.cycles-pp.testcase




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


