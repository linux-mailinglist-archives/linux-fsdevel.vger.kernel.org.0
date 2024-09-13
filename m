Return-Path: <linux-fsdevel+bounces-29282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD03097798C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 09:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDAA1F228D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 07:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27FC1BC068;
	Fri, 13 Sep 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeFFA604"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4077107
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212262; cv=fail; b=b8R6CJUGJLiz6xGRLxR5ZQLVVHSdA3H7lz07erORLhnGkjGWgDdNM3tyMsHMGRhYtBymAxhjMVPE7ak6w9pgFlhpC80NOrQTq7ePX2UTXXEk+1b9MbdxdumDO7UXA7JsZQDuAiUKTNWQsY2Y7s1IVHQZJYP0IlRi2fDBv80XEiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212262; c=relaxed/simple;
	bh=fILn+f8tmJqba+XLBChSoHFdzQfGMfy7TRQu2C4sDy4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UeOfPx3kbiUoy9SPEKgp1vRgO3dYRio5AHAlfk9LM9lX7l3XpDR7HiQNJAS+XxKqKISRctDySLswuezqtKONjrDoIyLV6kDsKGd8FSUQaZAKMPxR5+zjPccm8M9A6MydkXMuc/8zLcBbOki6TnzF1C77hkMABz6bMwTHbCoNY6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeFFA604; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726212260; x=1757748260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fILn+f8tmJqba+XLBChSoHFdzQfGMfy7TRQu2C4sDy4=;
  b=jeFFA604nCamTj+5LESglWrh187NrrpdaZnQru2kw1J8vBxGWHny5VwY
   ltSXK3m48qPxmT/XpXmMcPzxTdFj72JSVVEwpF8CT5QiTUkUMiZdyW2ts
   iFFv9b/dGEckBqmDLUx533FOWS5zktZNnbyiE5rkaxH99XmxCnRA8a113
   1O/eNUHCR9uq6UPdJNE6jDCj4RvOTK/Lztkmepe63LOMqsp6Jfp9n5AUB
   BWW/tBdeA89yLARV9i6tMQ6Ob5vuK09Ln+Lg2qahvVmhkEB2l+xRBCJeh
   WVe0rpaAZAWpbS1OYbscrNCM31LGgcscdJyRfi8GZNwB13Atd97QFwZPv
   g==;
X-CSE-ConnectionGUID: bAYWF9unQaSYbhfjDb46jw==
X-CSE-MsgGUID: yN11zyijTeWKJ9lrvXXPnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25198393"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25198393"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 00:24:19 -0700
X-CSE-ConnectionGUID: nss8Zh2wRBO7rkXgVm28+w==
X-CSE-MsgGUID: RIfzgUEdSR6cP0e8nf8OZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="91218145"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 00:24:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 00:24:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 00:24:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 00:24:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 00:24:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KL5hvwTGquyuSncaPkYimUBsGsjtUdjURvK+7je/YyQna6b7HW6uNzJ+2HL3xiwfBaRk7dkNjuDKj1Wklv07FiLC9f9FUNVwu+ACw3N13mbLSUewHwk7dzPSlN0hLrAZDQ2HV0x7AyVanaSnG6nxcdEZwKbZdYtqPc+UlXcVfUMxEX9zfDC2cKKFCwMy/rFWMvsM5HLhy0zHM2aLDvxR/MU/kExIJtYw93sV2YrJ22VsKjJN8S94675p5v/Ti/MKkLYVeEK6zIwSfRUsqkq1+ygs/cUTRvYk9RTz1xIbrXGTDRuLYKCWprrDUW7qO4KwbDhTrd/6eYuXtCMn37W1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/F8uypdWaew/e5kBKLsj1RG1t0bbRCdaN7Arnzu5Sk=;
 b=xcxpntQdfvPuyQOa9IPgdNp2QIX/ZY6Nqr2uZjB9XEe+xlYZthO9Ji6o2wz2EP6QHWqwyF+hny/HDoBC/Xo1v7N/kkaGsIgqU8o0IvyF+u5ZjEJZ/usS1WRizK9KeU/HEDD4JUaj0V3kHAW438pWsGvF/BXOJ5bqUMmDKmOIhS9ylZ2oebc1MEX5jOGRRa/ImhJghgDC+hM1pkJh1g6oH8n9kqUWyju60wJ3EYjFuztscZzc5hoXRNNdJUKEOkgmpMIrVwqfeDKbR2ELvB//0f9GXVlemVofKBk4b4bkb8mLQuRWMve/LZOw7PiCUSDNwyrsSPMTUa2fJmrZbM6wow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 07:24:12 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 07:24:12 +0000
Date: Fri, 13 Sep 2024 15:24:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, Jeff Layton
	<jlayton@kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [netfs]  a05b682d49:
 BUG:KASAN:slab-use-after-free_in_copy_from_iter
Message-ID: <202409131438.3f225fbf-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f095c2d-dd62-4726-7824-08dcd3c5104b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ml7zpZFTBrsqvz1p/+4evprFL9ISWIsUQQuVWbzNbz0e6rTin0N9OYCMWQwk?=
 =?us-ascii?Q?FxY1sEW8fLp2XmqHv3RSz7xQcB0NTyJZ2Hd5N1Wwvy06vjfYYapVtjmljh0D?=
 =?us-ascii?Q?7TrDmQQvse+kLa+MggRppdTHe7AzwzXbJJSKZ2JqC1CMfIjGKOKNkxi/6A3k?=
 =?us-ascii?Q?7d15jzZiCUCMD0Gy8wISj0Jw5mnlWVvQ6UXqCblBBfqaIInljrDVkTAuF/Vk?=
 =?us-ascii?Q?g0pUWkKw1frWRs+xErFFrcyS5pVKq0yqOZOBOKdOX8w9iP9UURX/IiQz3qP7?=
 =?us-ascii?Q?HjMRksBS4220/tQX4HZRRzWquTZwYS+qPoa9nJno+/CgBgnyKxtKubQrQhQG?=
 =?us-ascii?Q?tp85pNxoCwuAlx1luVAdZJqZy/CKhvntGnGRPhFwjJswlI0vE59CXeZagKTL?=
 =?us-ascii?Q?7TmFUbijysZdaDLbQ37tATzJJ/Iwv8BqGIylw/ukhkY+DJZAThTVxgxCbAip?=
 =?us-ascii?Q?+mjpQuPGILcqubf6hU3+O2o9p2xeWZNUOhxiuBMqJFB5r3Xe2/DM1/neDwWZ?=
 =?us-ascii?Q?A5SdQ1oM5+EaTI5NC+lgm/Vw6s8CnJKpDwwFDzn+aJmSzx6sKIjEbxzYPJjx?=
 =?us-ascii?Q?739aVM2NeYMfz2ziH1aAlO7He5n/4Wqz+M3VohxzZypWyma/gWpxrEaB6jhw?=
 =?us-ascii?Q?cTEivjsYV+cCb08YLVOPxm3347hp31oXtsss5UqA+tl2wy6CPtnMwh5++8bR?=
 =?us-ascii?Q?8E3e0IRkOkCzxVxgV2doh2EzFCCqBKMLaJcPgC3sW/YS2sF/WE4VHoNRUscT?=
 =?us-ascii?Q?YfIEyIlP4PTTExOLpF9OfXdhmTKPSIeaC5D4yeheShjOgjQvReMJ6OqJNwr9?=
 =?us-ascii?Q?knaBTGK8xyim4ca4E9bkoFhQ8jbAclykZoLlovphozwZG9U2lyieUKN09nJz?=
 =?us-ascii?Q?Td6pJJrrQIoYO0LetjDwL0Er/qebCKz59k6ev/ACtX1DmLMnmtWnQ+xncT48?=
 =?us-ascii?Q?SnDz6KJUJf1/MmEo21KCU1mvWwFkdlrZPUFt0rYrxvQM8xmc8lCjhYOT6qRN?=
 =?us-ascii?Q?fio/lDJP9D+dY5W3OVU9KBw6gFrDg8769tJWQvntqus/CeA2PgI5SvySJ2KC?=
 =?us-ascii?Q?V6RNqClA7IOlmRmXsbKXr007QhpjvQTEIDpkCECsOrRcFTBOuFiq7nefz7Rm?=
 =?us-ascii?Q?6Aty0SGQwfjg0xIylHIv8Ke56Va5CvyPVOrRsCAxGE8qR+XNQM1s8hLN5Tur?=
 =?us-ascii?Q?3/q7bHdLedNvYJWzzT5FtMOSPJho+NqtEHHG+/GsF/QrKVBBliSaXu6Vi7OM?=
 =?us-ascii?Q?fkyalzoVAWekETtGHaiDcJsvmxCutDjQnxTGItFcwvq6WHvthx9IvQTqynT8?=
 =?us-ascii?Q?yi5obj8syrkhRlg8yeRuxmplKcLaNWf7u99f4QQGQQkidrS+TRNZ+AqnceJB?=
 =?us-ascii?Q?0Kv0D7A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WMTQwnqlO22dIFJOki3EmGbAx1wwbrg2h4XvTtXe21DEfhInkBs7aQaGI9ma?=
 =?us-ascii?Q?sLDHdqfCZvlwXu0/XfYgp6TdwtM4MC7sp7mucnywLcqNaUsxEbNzPXCjN5o9?=
 =?us-ascii?Q?N/oVr/cGxnl6Eil5MGl0dJ/IpsiERAxIegn0+58xwM6Y2VpwmVSPeuSbeowz?=
 =?us-ascii?Q?7dptGdJND+CRWtrZwTnmi4ReJ+ufHyWJBC53PfCrLWJMVwtxCHUF0d2fG/9M?=
 =?us-ascii?Q?3ZedamF2Zmz9AHz3Wfvy23LF5JWu4PEuNGw2nThI64FUqLROppx+YmC5Dp55?=
 =?us-ascii?Q?j6rQGgz5RaQbuNCbH81RSmU3K70zlDk1ZeNxlmLHP5uX1V02DMJxjCE+zmJL?=
 =?us-ascii?Q?WlW9jC3HSSgOfOC9/n/Z5r4sO9N2jXoxCWuRg8lZuqRHWtlofcT9WMkvEKxh?=
 =?us-ascii?Q?Fa/IcU95+mc9xA850a7LFT88x++cMAgV0Vlo3dTCEO41BioX+yCQxa3kECRp?=
 =?us-ascii?Q?atgpOAtloar7909sAw6FDPeZXEyJU1j5XdUAh6F1wJ/JBBxJlRsIvIT2Uxrv?=
 =?us-ascii?Q?vgwGaAQBe+J+itdPgLpkrWOoqWGOR1tW0Z/5RUaA+3S2wNIk66Cygs/BHCD/?=
 =?us-ascii?Q?eEzZJLCsHlRsYOPcilIoPDc+xFidBTHE+0R03pegduUVNPp17s6P5lRNIo4O?=
 =?us-ascii?Q?w34vKas3CbHTmU+Q1JuBQ3+/siJjF5+Kj8QAjpZTYujnj1XBpXLpJeHwG45K?=
 =?us-ascii?Q?S7qy6WEa1T4c2oxYM61VXpRMK7/eNFBD/emcioeAqu77goq/iDt4EYl0d1MG?=
 =?us-ascii?Q?p1Lvb+Sx88eB1O/bUT+RXJ1IrqL8of3ZBoT6i5VJ9bMSdPPzvuc3hoGdn83i?=
 =?us-ascii?Q?vRrfk2mDCCfwVuqxjArfxmDcGwz8f3TwQr0g1y3HVn7J2xIKt13+LGcAY2Cd?=
 =?us-ascii?Q?/XLlCwNq8lALZMW+a9C3Qh0ovMyxqy7cyiFCi2MTpSNu74+oMPAvLtK+OCJc?=
 =?us-ascii?Q?/6IOycIn3gOSZjyHmeL7NjlKG5hr+JB9qB6xJW1CVTxuTmjeWFnFOlOosN5u?=
 =?us-ascii?Q?qyXpR/DlqoDrp415u3Axz5veIZI1cF0LK80KmI6OCwFZWJyJt7XG/ZIAvdc7?=
 =?us-ascii?Q?Tfjan+DZo6gIBujo5pYjVUvwS8Mlxh3p5EaEKpOPdUGrJv4F17Hmr112JpYK?=
 =?us-ascii?Q?VaENFqL3o/V+XAmg1UjxAdfgTKbPZafQhiLp7jnuXpZgkWoTBU/JfEmV8ZMU?=
 =?us-ascii?Q?yc6NKQ2W32PRTqCtaeUPB3A3QYRjU+yFuwkIl9O/IGlzURDc2ZNqDtCm7eMG?=
 =?us-ascii?Q?Psxv57QXuSjC+sZIXtFs37CgINQWboadLkzftkUOYHDCOfGFKzqUu1+Sc2Ns?=
 =?us-ascii?Q?PgsFQLtoG5MQaLg5Csb1XPW5WDX9FSTW5qStqgLG2gnFIJ4ghKBSWytYAjP0?=
 =?us-ascii?Q?rFwBcz5af508jmOZtsu6TJcce7huACgkWzGV6ThEFw2Bp7NzWxvllt9DUVJl?=
 =?us-ascii?Q?XjK1iSwijDikniwcmecaldy+V9Y89DNu+7mqih6QvhKAKbRVlCVdo0pKo0Pb?=
 =?us-ascii?Q?/uy9VnEKpt5mBWsxf0EU6s8T+kBdHTtaf3fRsjZBBUq6+tPq3YY3pXqRGeXK?=
 =?us-ascii?Q?ugfW+2OuvPqGBPw8uxLnk8/zd35fXktJP/Irpz1L4yczoG7hgulmy8pab/ui?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f095c2d-dd62-4726-7824-08dcd3c5104b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 07:24:11.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZVuQpb44Td5bvQo0EEkmSLcBnFu6rqw6Ns2zYfl8g74kDTrlf5eURCETGIKKjiBa6APsiI+ncWI7NnGYVre5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_copy_from_iter" on:

commit: a05b682d498a81ca12f1dd964f06f3aec48af595 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 32ffa5373540a8d1c06619f52d019c6cdc948bb4]

in testcase: xfstests
version: xfstests-x86_64-b1465280-1_20240909
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv2
	test: generic-group-07



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409131438.3f225fbf-oliver.sang@intel.com


[ 364.731854][ T2434] BUG: KASAN: slab-use-after-free in _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[  364.739592][ T2434] Read of size 8 at addr ffff8881b2af7d20 by task fstest/2434
[  364.746901][ T2434]
[  364.749086][ T2434] CPU: 1 UID: 0 PID: 2434 Comm: fstest Not tainted 6.11.0-rc6-00065-ga05b682d498a #1
[  364.758405][ T2434] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[  364.766511][ T2434] Call Trace:
[  364.769650][ T2434]  <TASK>
[ 364.772441][ T2434] dump_stack_lvl (lib/dump_stack.c:122 (discriminator 1)) 
[ 364.776796][ T2434] print_address_description+0x2c/0x3a0 
[ 364.783231][ T2434] ? _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 364.788188][ T2434] print_report (mm/kasan/report.c:489) 
[ 364.792453][ T2434] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
[ 364.797237][ T2434] ? _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 364.802196][ T2434] kasan_report (mm/kasan/report.c:603) 
[ 364.806461][ T2434] ? _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 364.811420][ T2434] _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 364.816205][ T2434] ? __pfx_try_charge_memcg (mm/memcontrol.c:2158) 
[ 364.821438][ T2434] ? __pfx__copy_from_iter (lib/iov_iter.c:254) 
[ 364.826569][ T2434] ? __mod_memcg_state (mm/memcontrol.c:555 mm/memcontrol.c:669) 
[ 364.831529][ T2434] ? check_heap_object (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:827 include/linux/page-flags.h:848 include/linux/mm.h:1126 include/linux/mm.h:2142 mm/usercopy.c:199) 
[  364.836485][ T2434]  ? 0xffffffff81000000
[ 364.840490][ T2434] ? __check_object_size (mm/memremap.c:167) 
[ 364.846143][ T2434] skb_do_copy_data_nocache (include/linux/uio.h:219 include/linux/uio.h:236 include/net/sock.h:2167) 
[ 364.851533][ T2434] ? __pfx_skb_do_copy_data_nocache (include/net/sock.h:2158) 
[ 364.857443][ T2434] ? __sk_mem_schedule (net/core/sock.c:3194) 
[ 364.862229][ T2434] tcp_sendmsg_locked (include/net/sock.h:2195 net/ipv4/tcp.c:1218) 
[ 364.867274][ T2434] ? __pfx_tcp_sendmsg_locked (net/ipv4/tcp.c:1049) 
[ 364.872665][ T2434] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178) 
[ 364.877447][ T2434] ? __pfx__raw_spin_lock_bh (kernel/locking/spinlock.c:177) 
[ 364.882751][ T2434] tcp_sendmsg (net/ipv4/tcp.c:1355) 
[ 364.886840][ T2434] sock_sendmsg (net/socket.c:730 net/socket.c:745 net/socket.c:768) 
[ 364.891192][ T2434] ? __pfx__raw_spin_lock_bh (kernel/locking/spinlock.c:177) 
[ 364.896495][ T2434] ? __pfx_sock_sendmsg (net/socket.c:757) 
[ 364.901387][ T2434] ? recalc_sigpending (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 kernel/signal.c:178 kernel/signal.c:175) 
[ 364.906379][ T2434] smb_send_kvec (fs/smb/client/transport.c:215) cifs
[ 364.911543][ T2434] __smb_send_rqst (fs/smb/client/transport.c:361) cifs
[ 364.916848][ T2434] ? __pfx___smb_send_rqst (fs/smb/client/transport.c:274) cifs
[ 364.922668][ T2434] ? __pfx_mempool_alloc_noprof (mm/mempool.c:385) 
[ 364.928234][ T2434] ? __asan_memset (mm/kasan/shadow.c:84) 
[ 364.932672][ T2434] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 364.937195][ T2434] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[ 364.942239][ T2434] ? smb2_setup_async_request (fs/smb/client/smb2transport.c:903) cifs
[ 364.948496][ T2434] cifs_call_async (fs/smb/client/transport.c:841) cifs
[ 364.953800][ T2434] ? __pfx_cifs_call_async (fs/smb/client/transport.c:787) cifs
[ 364.959623][ T2434] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 364.964148][ T2434] ? __asan_memset (mm/kasan/shadow.c:84) 
[ 364.968586][ T2434] ? __smb2_plain_req_init (arch/x86/include/asm/atomic.h:53 include/linux/atomic/atomic-arch-fallback.h:992 include/linux/atomic/atomic-instrumented.h:436 fs/smb/client/smb2pdu.c:555) cifs
[ 364.974672][ T2434] smb2_async_writev (fs/smb/client/smb2pdu.c:5026) cifs
[ 364.980242][ T2434] ? __pfx_smb2_async_writev (fs/smb/client/smb2pdu.c:4894) cifs
[ 364.986252][ T2434] ? cifs_pick_channel (fs/smb/client/transport.c:1068) cifs
[ 364.991910][ T2434] ? cifs_prepare_write (fs/smb/client/file.c:77) cifs
[ 364.997652][ T2434] ? netfs_advance_write (fs/netfs/write_issue.c:300) 
[ 365.002792][ T2434] netfs_advance_write (fs/netfs/write_issue.c:300) 
[ 365.007758][ T2434] ? netfs_buffer_append_folio (arch/x86/include/asm/bitops.h:206 (discriminator 3) arch/x86/include/asm/bitops.h:238 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) include/linux/page-flags.h:827 (discriminator 3) include/linux/page-flags.h:848 (discriminator 3) include/linux/mm.h:1126 (discriminator 3) include/linux/folio_queue.h:102 (discriminator 3) fs/netfs/misc.c:43 (discriminator 3)) 
[ 365.013434][ T2434] netfs_write_folio (fs/netfs/write_issue.c:468) 
[ 365.018306][ T2434] ? writeback_iter (mm/page-writeback.c:2591) 
[ 365.023007][ T2434] netfs_writepages (fs/netfs/write_issue.c:540) 
[ 365.027705][ T2434] ? __pfx_netfs_writepages (fs/netfs/write_issue.c:499) 
[ 365.032922][ T2434] do_writepages (mm/page-writeback.c:2683) 
[ 365.037377][ T2434] ? rcu_segcblist_enqueue (arch/x86/include/asm/atomic64_64.h:25 include/linux/atomic/atomic-arch-fallback.h:2672 include/linux/atomic/atomic-long.h:121 include/linux/atomic/atomic-instrumented.h:3261 kernel/rcu/rcu_segcblist.c:214 kernel/rcu/rcu_segcblist.c:231 kernel/rcu/rcu_segcblist.c:343) 
[ 365.042510][ T2434] ? __pfx_do_writepages (mm/page-writeback.c:2673) 
[ 365.047466][ T2434] ? __call_rcu_common+0x321/0x9e0 
[ 365.053466][ T2434] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 365.057988][ T2434] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[ 365.063030][ T2434] ? wbc_attach_and_unlock_inode (arch/x86/include/asm/jump_label.h:27 include/linux/backing-dev.h:176 fs/fs-writeback.c:737) 
[ 365.068766][ T2434] filemap_fdatawrite_wbc (mm/filemap.c:398 mm/filemap.c:387) 
[ 365.073983][ T2434] __filemap_fdatawrite_range (mm/filemap.c:422) 
[ 365.079385][ T2434] ? __pfx___filemap_fdatawrite_range (mm/filemap.c:422) 
[ 365.085489][ T2434] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 365.090015][ T2434] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[ 365.095058][ T2434] filemap_write_and_wait_range (mm/filemap.c:685 mm/filemap.c:676) 
[ 365.100621][ T2434] cifs_flush (fs/smb/client/file.c:2763) cifs
[ 365.105493][ T2434] filp_flush (fs/open.c:1526) 
[ 365.109586][ T2434] __x64_sys_close (fs/open.c:1566 fs/open.c:1551 fs/open.c:1551) 
[ 365.114025][ T2434] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 365.118385][ T2434] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  365.124149][ T2434] RIP: 0033:0x7fc02c3878e0
[ 365.128414][ T2434] Code: 0d 00 00 00 eb b2 e8 ff f7 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d 01 1d 0e 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
All code
========
   0:	0d 00 00 00 eb       	or     $0xeb000000,%eax
   5:	b2 e8                	mov    $0xe8,%dl
   7:	ff f7                	push   %rdi
   9:	01 00                	add    %eax,(%rax)
   b:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  12:	00 00 00 
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	80 3d 01 1d 0e 00 00 	cmpb   $0x0,0xe1d01(%rip)        # 0xe1d22
  21:	74 17                	je     0x3a
  23:	b8 03 00 00 00       	mov    $0x3,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 48                	ja     0x7a
  32:	c3                   	retq   
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 18          	sub    $0x18,%rsp
  3e:	89                   	.byte 0x89
  3f:	7c                   	.byte 0x7c

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 48                	ja     0x50
   8:	c3                   	retq   
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 18          	sub    $0x18,%rsp
  14:	89                   	.byte 0x89
  15:	7c                   	.byte 0x7c
[  365.147838][ T2434] RSP: 002b:00007fffcdbaed28 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[  365.156089][ T2434] RAX: ffffffffffffffda RBX: 000055ea7a5142b0 RCX: 00007fc02c3878e0
[  365.163904][ T2434] RDX: 000000000001dd50 RSI: 0000000000000000 RDI: 0000000000000004
[  365.171718][ T2434] RBP: 0000000000000004 R08: 0000000000000004 R09: 0000000000000000
[  365.179535][ T2434] R10: 0000000000000001 R11: 0000000000000202 R12: 000000000000000a
[  365.187349][ T2434] R13: 0000000000a00000 R14: 0000000000a00000 R15: 0000000000002000
[  365.195186][ T2434]  </TASK>
[  365.198063][ T2434]
[  365.200249][ T2434] Allocated by task 2434:
[ 365.204436][ T2434] kasan_save_stack (mm/kasan/common.c:48) 
[ 365.208958][ T2434] kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 365.213492][ T2434] __kasan_kmalloc (mm/kasan/common.c:370 mm/kasan/common.c:387) 
[ 365.217927][ T2434] netfs_buffer_append_folio (include/linux/slab.h:681 fs/netfs/misc.c:25) 
[ 365.223428][ T2434] netfs_write_folio (fs/netfs/write_issue.c:434) 
[ 365.228306][ T2434] netfs_writepages (fs/netfs/write_issue.c:540) 
[ 365.233013][ T2434] do_writepages (mm/page-writeback.c:2683) 
[ 365.237456][ T2434] filemap_fdatawrite_wbc (mm/filemap.c:398 mm/filemap.c:387) 
[ 365.242681][ T2434] __filemap_fdatawrite_range (mm/filemap.c:422) 
[ 365.248079][ T2434] filemap_write_and_wait_range (mm/filemap.c:685 mm/filemap.c:676) 
[ 365.253643][ T2434] cifs_flush (fs/smb/client/file.c:2763) cifs
[ 365.258510][ T2434] filp_flush (fs/open.c:1526) 
[ 365.262604][ T2434] __x64_sys_close (fs/open.c:1566 fs/open.c:1551 fs/open.c:1551) 
[ 365.267040][ T2434] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 365.271391][ T2434] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  365.277142][ T2434]
[  365.279326][ T2434] Freed by task 11:
[ 365.282983][ T2434] kasan_save_stack (mm/kasan/common.c:48) 
[ 365.287505][ T2434] kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 365.292028][ T2434] kasan_save_free_info (mm/kasan/generic.c:582) 
[ 365.296899][ T2434] poison_slab_object (mm/kasan/common.c:242) 
[ 365.301768][ T2434] __kasan_slab_free (mm/kasan/common.c:256) 
[ 365.306399][ T2434] kfree (mm/slub.c:4478 mm/slub.c:4598) 
[ 365.310057][ T2434] netfs_delete_buffer_head (fs/netfs/misc.c:60) 
[ 365.315379][ T2434] netfs_writeback_unlock_folios (fs/netfs/write_collect.c:144) 
[ 365.321202][ T2434] netfs_collect_write_results (fs/netfs/write_collect.c:558) 
[ 365.326937][ T2434] netfs_write_collection_worker (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 fs/netfs/write_collect.c:648) 
[ 365.332759][ T2434] process_one_work (kernel/workqueue.c:3231) 
[ 365.337542][ T2434] worker_thread (kernel/workqueue.c:3306 kernel/workqueue.c:3389) 
[ 365.341980][ T2434] kthread (kernel/kthread.c:389) 
[ 365.345895][ T2434] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 365.350158][ T2434] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[  365.354767][ T2434]
[  365.356949][ T2434] The buggy address belongs to the object at ffff8881b2af7c00


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240913/202409131438.3f225fbf-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


