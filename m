Return-Path: <linux-fsdevel+bounces-26236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606C956581
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 10:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E40C282FC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3568015B11F;
	Mon, 19 Aug 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIvGDMVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0515B0EC
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055848; cv=fail; b=Yij+x7WqCm+PWizE6gmVa08jVkgyvNsZkaXKUqmz1o6d81RqOmF5QN+V7kjUSKtmZ8WeqtLP5QfygbDl/g00hcLmI9cSKPfIjEvwJwSnN09YcHIC2o9xeICWsQl2uGZ0d1k/K/j1NU7oTG1uUXr+HQDhLaCKhLRZDES8X3t2G3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055848; c=relaxed/simple;
	bh=QqiRfouK1BscuMinY1447nzjK1wNTGAwBHmqhPkeX9g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Qcz7uUnFxOYYPP0hBnvcfAlsTTBT2NB+FLNl+RK0Hkt2kS3qOhpdHxCKBRi4JHCUQTrifpKfCQ5UBxS6nOf93a61RKXpNz7SHloe7KbgtLXhJcq7Kyn/m3AbbCgxlK20TzY4lJONaN1PiGYIS5Or02EehnFS7UPf7Cjb8UWynak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIvGDMVN; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724055847; x=1755591847;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QqiRfouK1BscuMinY1447nzjK1wNTGAwBHmqhPkeX9g=;
  b=QIvGDMVNvXVmVrctlhtLDxdwX6L0QwdL+TAGykY9vb1F9xu6mSsVnPW+
   dVVZtDtVAibxTRuY4165/AWt7yKwjLSxwBOrb9p8FeQ6kAX2C+nkobCqw
   I4k1MWV9QnH7Rn2I5ROhRBLeDre+lg93Mh43UWo9unu18Rd4quH+CT03U
   cdm9gMN7AdfYX7sj+8ruM/WSfFDt5cPZgtMCh7mxxnBLjf9qg6qpjuKJO
   QrqjLX3W+kTwvT9zW4HKwmrqhEAA8Pj+2/i0XOyP8M/S9tqwLM/k5wXHq
   LZtu7dnpnu4co4kNYd47QJ/tXzLOAXRSBpKxJF9ZHpfPMfuYLLnyDHavu
   Q==;
X-CSE-ConnectionGUID: gwGc+JNrQJSn5us+s5pXvQ==
X-CSE-MsgGUID: TShfLmyzQQmif8ohPvxa+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="47690057"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="47690057"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:24:06 -0700
X-CSE-ConnectionGUID: 1xyt+tP3S2+JkkIyltqB5w==
X-CSE-MsgGUID: nrzu5jGdQi67nwZBjvon1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65185829"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 01:24:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 01:24:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 01:24:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 01:24:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 01:24:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRdhI3ijFBZwDyC6D4xgXelzpGJpkF50uHqjBfx9K2M93czItgdq610QfOruFzVb3noTHMz2dlPiQvxdQgmVC0InHcBzX9wocl/tLL9InxPkzLXKXO7/k+ZZyxaOITZaQybaDpzOdG62ysWcXBGDPivEEaO9FqbVJilB+dhjQW6H9A+3uOdZ7xeBW93kCxyFIeWW+LO0AQJS6vhvVaXvmBbvwVPKg+rGrQdl7jzjFMQrhlNBALPGG6sQohfNozRzuD9UqiV0g74Ajb/eH5m4Bi1XAzw0MrOWu6oRCwVJfTL8thzmvRxbaNdiXICIRGh+j2AaIUAs5jTpIsl0HYtntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxCzzXfKk6VLDn5xirPJUUlGEP8zTW7tUUEV8YISNmc=;
 b=Z3k2ImOjT6QwW9nLdJ093UASh/LCmwN2didwILVkVy93Kc1vw2a0aJuFx/ZUjPbwhCOJweIIjQwA8MwJFoa+cAYyzYB/6cv3RtLhWH7katB9aTY1tgOUXMhdvWNP1TkMAQiazX9fmXwqRXOe54XR8RwH6LUw/KZczSZVepNn65ho7/0VR77jisZXyd+C6exNWAJytAuoyNET0eYQhOBiLMSvHNpmRQR2BN+S1IVtO/rU36EiOB+mq25vZjpy8p7SyRFN5dBhDQz9r7XiYWhsmrVMDqmHhoYkqS6qbO9pkqmhOPx/hms2uWMs0rq7Rd8SZFpbh1ozHz42SOjyubCOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4981.namprd11.prod.outlook.com (2603:10b6:510:39::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 08:24:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 08:24:02 +0000
Date: Mon, 19 Aug 2024 16:23:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [brauner-vfs:vfs.misc.jeff] [[DRAFT UNTESTED] fs] 6a0f6c435f:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202408191554.44eda558-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e25780-d8a5-4738-cd95-08dcc02847f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NLVTCnRUfpXfl7Q1lP1X8iuMqmnmQp49onjJuaU0A2JPEwZG8Nmk+NPBoZFu?=
 =?us-ascii?Q?Eos0SOY2wXpS03OrzTSiA7IH8WFqqBbuDOw5eu59qYyEe5gSerfrZfdVk+Lm?=
 =?us-ascii?Q?uyVMbTLqxAgcMWJYXFOX+nPKnne48eAROJjtR/aU5hIwofoTI0wFkJ5rPhAu?=
 =?us-ascii?Q?K4V/U/kNd4EucXO6K+j51/038+q2U5tAtG+Tq/Ggzcw8f6uI5exQCfsefZUS?=
 =?us-ascii?Q?3Qbi9VRQuf76U5CnoXlsEZnE7xV+B8N2QR+1cK5yAIh9oaUkHB9rOhAXrKGX?=
 =?us-ascii?Q?4aq1Oe4qMi3d2U7uefzAeuCOu9NLycbtXUmu1C/f48A/BBWKG8XSKgUnMHEB?=
 =?us-ascii?Q?SqwpiRSSpBqbF5BXI/+0pD20c4dfjlotxF691q3MNJOje9Pidmsq4z1gb8yK?=
 =?us-ascii?Q?2PkKGQ9F5mjQTR/F/1qQPjCAxCft/VsB2Prd0jfGKPY85xTiYKtlClX/LRl8?=
 =?us-ascii?Q?rDanpGaDOUyidhVzsg8oXAC2B+Ml5pR8shXo0Pqcn8X/nNZGoeXnm5A5RAMo?=
 =?us-ascii?Q?PVi8zR7erFSN62HK9OmvTJpht/gdVuQ1fMbORgUlv7LXHNYTeEAbJq+SrlE4?=
 =?us-ascii?Q?i9BbppXV3UWOEXgW9tGviig825BSsj9xI6cqR/o7uCsFenZq06i0IfapxTdV?=
 =?us-ascii?Q?Hr6IPtLNJC2HdNZC3C0BEuOfgAqj5ro6SIryaMsnEVQysxbH0enDHm4bVJVK?=
 =?us-ascii?Q?pYNDmiFFZV2u7j6vgu2RXMEnZIwcnV/rQydQftEblcI0erNrC4ltAvqMx8Mm?=
 =?us-ascii?Q?GU/Prbn6ge/i+ffGKq0IHU5qdPkIQ3u71kldy3omcrWlE2h6U4DT5E2sVoQv?=
 =?us-ascii?Q?J4h5QlbQwS0Cer7GUIdnGXuf9koipXwLe1A1Mq4v+p8cxqRKIR+a5kRkUXq6?=
 =?us-ascii?Q?OMihuQiAtWH3nzqP6mYKJcMCTcHwA04NrIoLlWJ5eUaO6+yrYU5gvsFosvKR?=
 =?us-ascii?Q?zViEG+2PEe1sia88iJuDfFnlz7ccrpawQRbZgTWeyGCxlGGcZeYbdTkRyx7+?=
 =?us-ascii?Q?IRiPCUOiCRgc29ilIkX7RuCZ5jmU1bqq1wEEGN/QOWWi6x5FW1Xjj2+HWTH4?=
 =?us-ascii?Q?Fb/OQBIyKv51+PnHXIVG+srtBva2PdU5wB9RyHFoyBK8pSZPNKaP8ah++9Hh?=
 =?us-ascii?Q?WuOcp2H6mvrUOKg7xXetAjebCrmHBPDb7eM5AOvEF+/vf1qky85/HSScEPTD?=
 =?us-ascii?Q?p0VLS0gZG+Af160+bmSc6EZ3QTzjeDULZwZ0Ebk/5AISKOfOYJuuDuUzbWIz?=
 =?us-ascii?Q?1pHSBcJlcZgnT8SKg0MIRGXBdg1ea1KNV9gzuFIx6qjaAY5H66gEtLwwr9PJ?=
 =?us-ascii?Q?CwwRch7mI6pCKHAFfpnTtHhb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rmseYEuSbURA4zsbd80gj05KU6kMjUHFB1IQsTNhIzvGtzOeTHqfJD5TLob5?=
 =?us-ascii?Q?p95Zahj0/iaUmfye6jzxa1kMdjqnnIP24ZG+aUYTOq1Isf+5gd/fmszsTpiW?=
 =?us-ascii?Q?mPhYLzhS8KTDO4BkGq37IpoYjm9O17U/uHkuCuPoCNzebDEVfC/WTfkXuj/s?=
 =?us-ascii?Q?kNapApgYt+h27VANUY+1Cp4NUBq5mgVV9SLCpyILR72nlC6jMRCgbMifxznk?=
 =?us-ascii?Q?HDMEDsoyVsCisrP5epXB28LWiag+QGmYiQBkLbC+8CVXJaiOyu5v53Fj3pb4?=
 =?us-ascii?Q?Eve41CAr1h/sGWzZbI1Osrs3OYbl42jxj1XSLWQ5mn5PdFFkOuAxa2+9QfcL?=
 =?us-ascii?Q?qkInWik188cwpchYLvR+ygxMV1sFu5WW8Rsz3gv5dmE7ilfwy94kshfQl6d2?=
 =?us-ascii?Q?NdfOYsM2YhsCifSxOt6J42a0BxLTiFKzCT0jnnqh/ytOODQwmvCjMyJiGsK/?=
 =?us-ascii?Q?SvRSeRuNpNgjJfvLR2yM6zm272o9deLw/Zu+mx/QztsKsjqadm5bEhVK/yGX?=
 =?us-ascii?Q?FbMZ0MLQXqj4MfQD4Y8rSRLVIftN+5tCRgogYunQB3tn7Z5m1MGyIugINuee?=
 =?us-ascii?Q?FPtDQEjLXEpk5lNsrtpwNdEx3qdJ23p4svRcWB2mzRdV3mru0aMmafxMe9W1?=
 =?us-ascii?Q?MM632VJW0zVpbAbAWcLwH6eX2Ujm6U/Vcb0CIJ9PPGajcSJS7dXtO1rraeBf?=
 =?us-ascii?Q?V5JbUvXhJvOvOy3AX9KHsS14Mch0o8ymf82aKdTIG3VlH0r00T2i6FjudZ8B?=
 =?us-ascii?Q?Ov39wYy5+PjyAA8+A9G+2fyyzHxvYbyg9OiANwO71KRWwpKNREJLoimYrdyF?=
 =?us-ascii?Q?AIY/wJNbpKt4O/pV4yUvgBMVKO6fBtvf/iHq/gUhK6RsMA87T1moi4rKSTMK?=
 =?us-ascii?Q?lyD/rld3g8B75Isb0EVOQf/xxhydDKCQijGLCDtMlbV0wuspjad23BjxtUO7?=
 =?us-ascii?Q?lF61KkjV2aTjnKuUPBQFGiZeN2Rx4MoWRmyiLif7rs3MxLkGiVDipkl8T7R3?=
 =?us-ascii?Q?9EgUDpqcTFlBYJm8kubCvgaJwfGKWlu7eOq+TxBE2UdbHIOqHEjbE9ypzgXi?=
 =?us-ascii?Q?mzFTa7AycSXaCzm4XUhNbu8XFvYRaksvexn7tRcNrzURryHDUZWfMQYE1WyQ?=
 =?us-ascii?Q?J/MJP6niSKcfSggZYAKJxOL53sPrKWD+77AWFEfeEMwyS8U2zdjuI5sh+cK6?=
 =?us-ascii?Q?XEJRyrlOfWBU163iHXuqebc7Nz6R1wQFgAWaD6t3sWETFdM3PjdKDH9TMIAv?=
 =?us-ascii?Q?TlNF8ScDk/XpKzwnzOdW1hYE0K4zHyeaTsYY0/5CUjzVZUuZA2L6pzdTYzhZ?=
 =?us-ascii?Q?6fHgsUkFc4QV6CbyZ4Nd2amhgPryetPeHeroUnAPjWHqSji8QgWyGcK5MZ/J?=
 =?us-ascii?Q?ZPHSKLTiTIL7E3YaKNzdXMO6DUSUJoMn83D0MaiVK6HJ4U9QcyYQtaJIZpBC?=
 =?us-ascii?Q?3zbFrWuj3r+fcK+yDDDQ7eSfbG1MSvhlc2Os+ukgrzMSMOLlFAvrfktxocxx?=
 =?us-ascii?Q?+xAFX620l7BtxflbLVow83hzSpwH65yebvZEj802Y/Z+8K/WXWPHMUhF86YP?=
 =?us-ascii?Q?KEdhy0L6A7iBVAId7ufBMxqRivkCKZUdO6PVDt+HsKplcumFhPOARcIMp8Ck?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e25780-d8a5-4738-cd95-08dcc02847f2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 08:24:02.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YashlESsB8d25hEbyAd8/pjwWOpPvOabiIgJeH8YvZKv1Zfya5zCmMAUPKS2Dnpoym5vVKwqYvMGwFTV9JYscQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4981
X-OriginatorOrg: intel.com



Hello,

we noticed this is a "[DRAFT UNTESTED]" patch, below report just FYI what we
observed in our tests.


kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 6a0f6c435fb1bbc61b7319146c520b872bb3d86d ("[DRAFT UNTESTED] fs: try an opportunistic lookup for O_CREAT opens too")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.misc.jeff

in testcase: trinity
version: trinity-x86_64-bba80411-1_20240603
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 619d77cf74 | 6a0f6c435f |
+---------------------------------------------+------------+------------+
| boot_successes                              | 6          | 0          |
| boot_failures                               | 0          | 6          |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 6          |
| Oops                                        | 0          | 6          |
| RIP:open_last_lookups                       | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 6          |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408191554.44eda558-lkp@intel.com


[   67.376606][ T6760] BUG: kernel NULL pointer dereference, address: 000000000000005e
[   67.377423][ T6760] #PF: supervisor read access in kernel mode
[   67.377976][ T6760] #PF: error_code(0x0000) - not-present page
[   67.378502][ T6760] PGD 16b2ea067 P4D 16b2ea067 PUD 0
[   67.378978][ T6760] Oops: Oops: 0000 [#1] PREEMPT SMP
[   67.379444][ T6760] CPU: 0 UID: 65534 PID: 6760 Comm: trinity-c4 Tainted: G                T  6.11.0-rc1-00022-g6a0f6c435fb1 #1
[   67.380468][ T6760] Tainted: [T]=RANDSTRUCT
[ 67.380817][ T6760] RIP: 0010:open_last_lookups (fs/namei.c:3633 fs/namei.c:3660) 
[ 67.381294][ T6760] Code: c8 03 89 47 34 48 89 df 48 89 54 24 08 e8 ee eb ff ff 8b 34 24 48 8b 54 24 08 49 89 c7 85 f6 74 50 48 85 c0 0f 84 0b 01 00 00 <48> 83 78 68 00 0f 84 f3 03 00 00 48 3d 00 f0 ff ff 77 14 8b 43 14
All code
========
   0:	c8 03 89 47          	enter  $0x8903,$0x47
   4:	34 48                	xor    $0x48,%al
   6:	89 df                	mov    %ebx,%edi
   8:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
   d:	e8 ee eb ff ff       	call   0xffffffffffffec00
  12:	8b 34 24             	mov    (%rsp),%esi
  15:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  1a:	49 89 c7             	mov    %rax,%r15
  1d:	85 f6                	test   %esi,%esi
  1f:	74 50                	je     0x71
  21:	48 85 c0             	test   %rax,%rax
  24:	0f 84 0b 01 00 00    	je     0x135
  2a:*	48 83 78 68 00       	cmpq   $0x0,0x68(%rax)		<-- trapping instruction
  2f:	0f 84 f3 03 00 00    	je     0x428
  35:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
  3b:	77 14                	ja     0x51
  3d:	8b 43 14             	mov    0x14(%rbx),%eax

Code starting with the faulting instruction
===========================================
   0:	48 83 78 68 00       	cmpq   $0x0,0x68(%rax)
   5:	0f 84 f3 03 00 00    	je     0x3fe
   b:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
  11:	77 14                	ja     0x27
  13:	8b 43 14             	mov    0x14(%rbx),%eax
[   67.382823][ T6760] RSP: 0018:ffff8881a5407d20 EFLAGS: 00010286
[   67.383333][ T6760] RAX: fffffffffffffff6 RBX: ffff8881a5407db0 RCX: 0000000000000000
[   67.384026][ T6760] RDX: ffff8881a5407ed4 RSI: 0000000000000040 RDI: 0000000000000000
[   67.384726][ T6760] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   67.385415][ T6760] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88816b431200
[   67.386090][ T6760] R13: 0000000000008241 R14: ffff8881a544d9c0 R15: fffffffffffffff6
[   67.386767][ T6760] FS:  00007fe3bc195740(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[   67.387496][ T6760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.388081][ T6760] CR2: 000000000000005e CR3: 000000016b376000 CR4: 00000000000406f0
[   67.388799][ T6760] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   67.389519][ T6760] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   67.390229][ T6760] Call Trace:
[   67.390532][ T6760]  <TASK>
[ 67.390796][ T6760] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 67.391153][ T6760] ? page_fault_oops (arch/x86/mm/fault.c:715) 
[ 67.391591][ T6760] ? exc_page_fault (arch/x86/include/asm/paravirt.h:687 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 67.392027][ T6760] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 67.392485][ T6760] ? open_last_lookups (fs/namei.c:3633 fs/namei.c:3660) 
[ 67.392930][ T6760] ? link_path_walk+0x247/0x280 
[ 67.393496][ T6760] path_openat (fs/namei.c:3942 (discriminator 1)) 
[ 67.393876][ T6760] do_filp_open (fs/namei.c:3972) 
[ 67.394267][ T6760] ? simple_attr_release (fs/libfs.c:1617) 
[ 67.394754][ T6760] ? alloc_fd (fs/file.c:560 (discriminator 10)) 
[ 67.395155][ T6760] ? lock_release (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:5782) 
[ 67.395585][ T6760] do_sys_openat2 (fs/open.c:1416) 
[ 67.396012][ T6760] __x64_sys_openat (fs/open.c:1442) 
[ 67.396453][ T6760] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 67.396873][ T6760] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   67.397426][ T6760] RIP: 0033:0x7fe3bc28ff01
[ 67.397838][ T6760] Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d ea 26 0e 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
All code
========
   0:	75 57                	jne    0x59
   2:	89 f0                	mov    %esi,%eax
   4:	25 00 00 41 00       	and    $0x410000,%eax
   9:	3d 00 00 41 00       	cmp    $0x410000,%eax
   e:	74 49                	je     0x59
  10:	80 3d ea 26 0e 00 00 	cmpb   $0x0,0xe26ea(%rip)        # 0xe2701
  17:	74 6d                	je     0x86
  19:	89 da                	mov    %ebx,%edx
  1b:	48 89 ee             	mov    %rbp,%rsi
  1e:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
  23:	b8 01 01 00 00       	mov    $0x101,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	0f 87 93 00 00 00    	ja     0xc9
  36:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  3b:	64                   	fs
  3c:	48                   	rex.W
  3d:	2b                   	.byte 0x2b
  3e:	14 25                	adc    $0x25,%al

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	0f 87 93 00 00 00    	ja     0x9f
   c:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
  11:	64                   	fs
  12:	48                   	rex.W
  13:	2b                   	.byte 0x2b
  14:	14 25                	adc    $0x25,%al
[   67.399602][ T6760] RSP: 002b:00007ffdc391cab0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
[   67.400397][ T6760] RAX: ffffffffffffffda RBX: 0000000000000241 RCX: 00007fe3bc28ff01
[   67.401128][ T6760] RDX: 0000000000000241 RSI: 000055acb903417a RDI: 00000000ffffff9c
[   67.401835][ T6760] RBP: 000055acb903417a R08: 0000000000000004 R09: 0000000000000001
[   67.402551][ T6760] R10: 00000000000001b6 R11: 0000000000000202 R12: 000055acb903417a
[   67.403261][ T6760] R13: 000055acb903cfa2 R14: 0000000000000001 R15: 0000000000000000
[   67.403999][ T6760]  </TASK>
[   67.404281][ T6760] Modules linked in: crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha1_ssse3 ipmi_msghandler serio_raw
[   67.405542][ T6760] CR2: 000000000000005e
[   67.405992][ T6760] ---[ end trace 0000000000000000 ]---
[ 67.406504][ T6760] RIP: 0010:open_last_lookups (fs/namei.c:3633 fs/namei.c:3660) 
[ 67.406987][ T6760] Code: c8 03 89 47 34 48 89 df 48 89 54 24 08 e8 ee eb ff ff 8b 34 24 48 8b 54 24 08 49 89 c7 85 f6 74 50 48 85 c0 0f 84 0b 01 00 00 <48> 83 78 68 00 0f 84 f3 03 00 00 48 3d 00 f0 ff ff 77 14 8b 43 14
All code
========
   0:	c8 03 89 47          	enter  $0x8903,$0x47
   4:	34 48                	xor    $0x48,%al
   6:	89 df                	mov    %ebx,%edi
   8:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
   d:	e8 ee eb ff ff       	call   0xffffffffffffec00
  12:	8b 34 24             	mov    (%rsp),%esi
  15:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  1a:	49 89 c7             	mov    %rax,%r15
  1d:	85 f6                	test   %esi,%esi
  1f:	74 50                	je     0x71
  21:	48 85 c0             	test   %rax,%rax
  24:	0f 84 0b 01 00 00    	je     0x135
  2a:*	48 83 78 68 00       	cmpq   $0x0,0x68(%rax)		<-- trapping instruction
  2f:	0f 84 f3 03 00 00    	je     0x428
  35:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
  3b:	77 14                	ja     0x51
  3d:	8b 43 14             	mov    0x14(%rbx),%eax

Code starting with the faulting instruction
===========================================
   0:	48 83 78 68 00       	cmpq   $0x0,0x68(%rax)
   5:	0f 84 f3 03 00 00    	je     0x3fe
   b:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
  11:	77 14                	ja     0x27
  13:	8b 43 14             	mov    0x14(%rbx),%eax


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240819/202408191554.44eda558-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


