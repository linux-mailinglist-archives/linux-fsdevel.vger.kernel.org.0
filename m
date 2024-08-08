Return-Path: <linux-fsdevel+bounces-25393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167E94B638
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 07:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07431F221FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 05:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69AE13E41D;
	Thu,  8 Aug 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lz96daLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868112C81F;
	Thu,  8 Aug 2024 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094627; cv=fail; b=CU9lUw6W0LFjYvjnqU+aU13NYE9tpVYLYBZyDDoMq/LS0Nzmuo0D1un6bMSPbo4NYB3I7q8SPRzd+9+8We3BbIUqTOfBPrvUzvbr9OyTklm8FUyZ7a1t/JJ7Ma8kFBMpMY539S4ENgsxc9OWazrFn+BfwgO6Ht6/8V1HQ2UwIoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094627; c=relaxed/simple;
	bh=ghZQ7mFsheoI0OPWb548P/gUYbvnbl/IeNAskjRQwTU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q8urCLYmC8U0n8lSqRHnBDRh80gzc8HieBwmpO7wcmYaIiqaZfBG7N5UjMl0fg4ryak9PC57b7x1NcKq33V9qjlc+zkmwGsCzwPMFvwbaKGZRi7yzzZpfHNtuPDol/M77Krm6uYNaVKySUKo4wD66yRSiI5vbZqPlWdXrMOMDbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lz96daLd; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723094625; x=1754630625;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ghZQ7mFsheoI0OPWb548P/gUYbvnbl/IeNAskjRQwTU=;
  b=lz96daLdyLRvuAA7Y1pPwij/PPG7QkfOTQdliPw0r9grF5CCoqAWeJaO
   dPArsUiArNGUdasAhmxXqpO7VNdsVijDm+4ssRgWug2TQD4Z2K0mYQ/rt
   12jl9t03h57b7YN9wMxwY/1V8aJy1iynoxyHHymt6X0ZLt961h45mgXXT
   hhb/yLayJWRu5bCG4HObYHJXufqM42Kky7m4vRneBuiY3iIwdTwlLAktM
   1OOu5i3FodyCgz++VNMYmsX90zAgzpXPMJWZuxREfFjA7C/CUsrg6+8o3
   bfbjZ13IyztSFmboYswoCPSmy006aIHJEpJvQEAYfjpbjiTPAiTpcpHDO
   w==;
X-CSE-ConnectionGUID: kZoclwNFQ6acFHH5Yynxiw==
X-CSE-MsgGUID: h+0g3FwXSqWjgy5pumzjhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="24960374"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="24960374"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 22:23:44 -0700
X-CSE-ConnectionGUID: 0IpZbRGQTGmhmypkr3L+nw==
X-CSE-MsgGUID: R7o4KHbsQRup6Yvt/nFFAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57047751"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 22:23:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 22:23:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 22:23:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 22:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuojcpvyBtNp5TJvdQ8TPHaM52v6woEzjokQWusQg34cq7xgSSt0KaCbsriX2FM6DY1r4Kgmq82XgDdSOScSisYe73EBJ6FqNg3hpbOsZPeYbwYTQHhUi/iGKjqc88j8t6REnFoChfwpLsQ22FfNliNPtsQ6r//+HRG3poAtGqvUq2ksz1DztMUhFA9TXsMKQQVt/TWFO/kGVHXsC3tH6cia/BMjbfeAOfSQWDWgFKBpN3dI3KNo3et+8rbOyTjVqFOqzbCgfopcLQ2TPPBxZNDyHGHdSBWYQgtQkbU3y11KGXuUZvBiIqC239/tdtdc16cqJsNBYtcP60xgmaQ5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hL/KX5Inhav+NMPpnpdee7rILaNLWJ1ppHO5ylkwc8=;
 b=GvoUp9ugCPujVB9GW+uj0M73E7tyLTUZYyM0PUCu9IS3YUcms6L3VldX6DontSgcurEzLm2ztde68d2jsJxU5iX21bTOLQIxMMEZVGqXDtFIccXTGC45/+WOys0hlcya4Ufb3TGnzG995UDfMBCV6Fne1qMn4vUOUo+3Rg+Uf1ZWAyoK8Ja+DXbcpSw2Usurt7XF8RJvYj75qOVs8tGNUOrAttQkXoZGl2onOz6k3RcLiHG5HIGFBeVQOW2zSa5f5BNCbn3DzWOeUwoQoL4H9nQ78JvwBEKNmZibIY7DnB/aJnu7PjP8tQgzhgw5yyKPgLJWoI5PKZmVwbShYb2cig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SJ0PR11MB4862.namprd11.prod.outlook.com (2603:10b6:a03:2de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Thu, 8 Aug
 2024 05:23:41 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 05:23:41 +0000
Date: Thu, 8 Aug 2024 13:24:32 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	"Vlastimil Babka" <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Eric Biederman
	<ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, SeongJae Park <sj@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Brendan Higgins <brendanhiggins@google.com>, David Gow
	<davidgow@google.com>, Rae Moar <rmoar@google.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH v4 1/7] userfaultfd: move core VMA manipulation logic to
 mm/userfaultfd.c
Message-ID: <ZrRWkINGB9jC1nQR@xpf.sh.intel.com>
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
 <50c3ed995fd81c45876c86304c8a00bf3e396cfd.1722251717.git.lorenzo.stoakes@oracle.com>
 <ZrLt9HIxV9QiZotn@xpf.sh.intel.com>
 <3c947ddc-b804-49b7-8fe9-3ea3ca13def5@lucifer.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3c947ddc-b804-49b7-8fe9-3ea3ca13def5@lucifer.local>
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SJ0PR11MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 78073695-fbcc-4a14-0ad3-08dcb76a4428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QCtDip7mZB1hWkmlgn5I9DnP2VM+ze6ZNaZ3niWXZYttidVHvV+0J7RtnK01?=
 =?us-ascii?Q?/cPWi02d+LsQZD9mOkCv+vjIXDTVnhvxMJNEDqaAegPRUP9JHBqNRQrDvZD/?=
 =?us-ascii?Q?H6+rvojE1n+QZQ4eMcmXguYXpmW1YtFApziduDAd6LlyOKB9ZgVp9r2ca4xs?=
 =?us-ascii?Q?9jygztK58MLgGvLozqCnRk9UDGn9qtERTgoqBQSgUuIyinwixLlZuUuC4f0P?=
 =?us-ascii?Q?mLWZCcyQnQwOmTaL3VNvRc9geeJg9NlLCYCqeQihgybCKphEjsuCr2XIsTkJ?=
 =?us-ascii?Q?JPq56TRgZuC3tosCp+7gIx19Ye7+5gVGSqwqelG5aKg6jDwSnuCvUl632dnL?=
 =?us-ascii?Q?YLcRUHQKYmECOGOXok7Cg/4+NRs/NDux/bernYbtm10ZNxieR2zqAeoXCN6c?=
 =?us-ascii?Q?WhTN6nbFHUylvM13qXyzcPizp44DB6+YYV9kpUWlYrNmicOZDzB1QOHaZlTP?=
 =?us-ascii?Q?gMYfeBSgE1OZZaTLxWk7rzWzc0GnVnBnBs7xPVPTP2aojdKYOwhPSZtLtQB2?=
 =?us-ascii?Q?CugP2eJ/982H+tqpMMmwnyD1yYgYxiyPzIvodrZ4ik27GMzBvSHzi3Azj3dn?=
 =?us-ascii?Q?nUgikPYXJhqnD96SWNqnkdUc0KCsMIsgV17aAC504y58FGiV28V+oro5vDkB?=
 =?us-ascii?Q?fI8/lY2YL/VmfKD9IyNzd62JeJXYmeHvHbLCwmRbQPa0m0O1ZrT4CX560tFr?=
 =?us-ascii?Q?AIw4WKE+Up6f8/dQn54gNgDETM8Ht3CkvGYrHrbRRKJKM6hhTMiIBMTCNc1g?=
 =?us-ascii?Q?fScoTQhQakK+V6TUNvHrP25ZBgUVOcvhydpS0dIR4U/J3pfYaGgOO36YnXOt?=
 =?us-ascii?Q?saiKBprXDEo/+cKXpDSXRC4b4LBV/1RMbz8zbEgUTLy0dhD/z3az3sDzdre8?=
 =?us-ascii?Q?Oh3ReJYzYoJAqnSHw4i9xF5+5czzfBxxVQN3ituoQsSkyudDecUJJGwLhgnI?=
 =?us-ascii?Q?HwGgYgO2zL6zjnRWO49418az0Jmc6tfE4yqSBIQLNvhAJkkmjO1QefIBKm8J?=
 =?us-ascii?Q?hl6k1CYWI6YV0Iiw6xGr5eq0KG6FLIW8j4ns70jsBsh+BRXTYw0rT1ExCTmu?=
 =?us-ascii?Q?FypnWQsJPTi2jipVgt+6hyN0gMWoLrXGBHBIGldeT2JLZ//o2Gbhxc0sOC35?=
 =?us-ascii?Q?yZEe9DniBsxfie86U8xhEHwaiboUavWj335EBrE6tyAqOqBIGV4rqtQ4DmbV?=
 =?us-ascii?Q?xFLUKqYpJC1a4CVzVETc3QNElphtVFI1jYZS01DXfUiM+lFulXQGxosWkljj?=
 =?us-ascii?Q?0siFk32GnVW4EyiV2JBg0OQ/f1XwlvfX2zrgmjk6pg+DzEHzfkguyg2Fbc15?=
 =?us-ascii?Q?XNSFCWfD75Y26vv/OwQhIoIX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgN7fkmUsgMhRDdWLRw9ax4Q7Y3ySdFKlE7pFcBsYCkrSTGtp8mBSbL0SQPa?=
 =?us-ascii?Q?I2zcDqB2TOkoU5ANwag3bUuAjSokX2ohgyahbMeJX5XJPiwcXNKkJJpVDY2r?=
 =?us-ascii?Q?vgv06C17FV8vc/rM+UuF4vWLy5WRpRhAEq0LTL+hhJt3SXmA24elxHIwLEp5?=
 =?us-ascii?Q?O/5ZeLOYrEh/qXY/GLL8L0+imrGd32xTBkjd+c5aDTsy56/s8qP5VJCBOOOH?=
 =?us-ascii?Q?3M9O0v3ztF4eiJzdOEqN9Cd2YTl+imCeoY6VVsTrRI8C8i1qnz42sl/b76em?=
 =?us-ascii?Q?pd0cT3NCzd0O+VbvYVWRkv51jlPsjQWrN2W4FIu91fHmw2N7gTzqhRPLM+U+?=
 =?us-ascii?Q?dXG98m1UjDk+ZBLZgjysb9T0do4mXunWhEiCybcCvZ35nWtUbGV9SRLuB6JN?=
 =?us-ascii?Q?v+vFR4nYYWwHN5qD5cs/QNQi3ejUKCjK8bJSf7rRQ+c1EDhO4nnilDo13B+n?=
 =?us-ascii?Q?2y00L/yBuHrMDW1S6T20Xk6qfXp0xgBchOQaLmvnZW153XvFZSXnhrDBB6UU?=
 =?us-ascii?Q?6adFmlaKOCk3QhdY1him0P9Xb3tMrxalPZVmf9GUlQReerdiI1LZD6nGXs48?=
 =?us-ascii?Q?ZMELUS1XV3uVOUwzy0Ju3O/1jtflyukSJr8l+eXQ6ogH4LIEg2ka1edZRp01?=
 =?us-ascii?Q?Mhd0YDFjEAKll23xmDKfvtINhV5LiZDcvbTpH5Q74sSi0lLQfDKHIJpEgzzo?=
 =?us-ascii?Q?p5RbvXleC5tkJ88zpzMdTcFJrzVg8ArFMcqyBoPzqBLz7vAPJ+4DyDIEbWYW?=
 =?us-ascii?Q?Vk78AjvsT2l8Y+4SvW82ONKuXkYOuPlYQbNZoEdjToTtggS3dTsSs++gj7JY?=
 =?us-ascii?Q?Zt7OOyq41iqs4Z3WoIfl+S5pws7PJnVSyapcEyDdDYU2Qs1S4UjDcCMlpnfY?=
 =?us-ascii?Q?DSxo9KJ1INtoABZDj9LN+vp+BQ5w1rbdOspAOucANARDifljvrlx7d7TBhUP?=
 =?us-ascii?Q?mKkie3VQ+2oAUXeoznXTgPDqgY8gDAndT/YUwr+peTq9CPKJfRN/CwSfYgj2?=
 =?us-ascii?Q?3RpCdnvLvHVJ5bhtP1taG01KWDAmRY82yqEcOSdHaK7oLDFS8lSIvVKBeYvH?=
 =?us-ascii?Q?/roOxVcZP/wUTNyA/TltgTQEszKyNl5o33/4Su8AsF/jOzjzT5oR7XazXCjJ?=
 =?us-ascii?Q?0Zow7O3igO1zCINibQNoydXJYX92N0RlaeWvbcEU2i6JJpNZiV0loZsjUSaj?=
 =?us-ascii?Q?jKwNpAAUThJQ6ijObIo3GP+AaqsFLjDF5oZzSsPl71i7ZkPRLZ9lubIRNlpk?=
 =?us-ascii?Q?Hf0OFHyDdMfSDgDmvZqKBG6akypz00h3+LLVLA5uS3QkzQ9adf+hz3Hx6u7O?=
 =?us-ascii?Q?J1nWBbQEm2NjoZmfjouc4L3jWcHDCOXqvvrvhI8ToEwnk5Jbq2A0lT8MP66z?=
 =?us-ascii?Q?9Z9Pf28rlby+TbVafbUeLkoV0faymMrEc0q8nnQqMj3cY5bwkvK7KmmOtbYV?=
 =?us-ascii?Q?iENO6/YXmjoOiPkYMewYcw4MYUBN5e0lFSyjhDTW2Io7T3lBsgzPAZuDIV+K?=
 =?us-ascii?Q?jssa3J2jiCgoQxO0otTO3yZFPh3fpMmZTPmaLfdgiGFy8MG+kWSaQoRLxnV4?=
 =?us-ascii?Q?5OqhNsvvBSyrGRkvoxlbrBrvFplqjx94sdKWTlJT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78073695-fbcc-4a14-0ad3-08dcb76a4428
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 05:23:41.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cb83qYSTc0359tX2qj/TuysrvpZuwqKm2C2fB3E9IJZWt+LGA8VEg9ofce4ORluJuXHktl1jsNZsMiaGA25mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4862
X-OriginatorOrg: intel.com

Hi Lorenzo Stoakes,

On 2024-08-07 at 13:03:52 +0100, Lorenzo Stoakes wrote:
> On Wed, Aug 07, 2024 at 11:45:56AM GMT, Pengfei Xu wrote:
> > Hi Lorenzo Stoakes,
> >
> > Greetings!
> >
> > I used syzkaller and found
> > KASAN: slab-use-after-free Read in userfaultfd_set_ctx in next-20240805.
> >
> > Bisected the first bad commit:
> > 4651ba8201cf userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
> >
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240806_122723_userfaultfd_set_ct
> 
> [snip]
> 
> Andrew - As this is so small, could you take this as a fix-patch? The fix
> is enclosed below.
> 
> 
> Pengfei - Sorry for the delay on getting this resolved, I was struggling to
> repro with my usual dev setup, after trying a lot of things I ended up
> using the supplied repro env and was able to do so there.
> 
> (I suspect that VMAs are laid out slightly differently in my usual arch base
> image perhaps based on tunables, and this was the delta on that!)
> 
> Regardless, I was able to identify the cause - we incorrectly pass a stale
> pointer to userfaultfd_reset_ctx() if a merge is performed in
> userfaultfd_clear_vma().
> 
> This was a subtle mistake on my part, I don't see any other instances like
> this in the patch.
> 
> Syzkaller managed to get this merge to happen and kasan picked up on it, so
> thank you very much for supplying the infra!
> 
> The fix itself is very simple, a one-liner, enclosed below.
> 

Thanks for your patch!
I tested the below patch on top of next-20240805, this issue could not
be reproduced. So it's fixed.

Best Regrads,
Thanks!


> ----8<----
> From 193abd1c3a51e6bf1d85ddfe01845e9713336970 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Wed, 7 Aug 2024 12:44:27 +0100
> Subject: [PATCH] mm: userfaultfd: fix user-after-free in
>  userfaultfd_clear_vma()
> 
> After invoking vma_modify_flags_uffd() in userfaultfd_clear_vma(), we may
> have merged the vma, and depending on the kind of merge, deleted the vma,
> rendering the vma pointer invalid.
> 
> The code incorrectly referenced this now possibly invalid vma pointer when
> invoking userfaultfd_reset_ctx().
> 
> If no merge is possible, vma_modify_flags_uffd() performs a split and
> returns the original vma. Therefore the correct approach is to simply pass
> the ret pointer to userfaultfd_ret_ctx().
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Fixes: e310f2b78a77 ("userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c")
> Closes: https://lore.kernel.org/all/ZrLt9HIxV9QiZotn@xpf.sh.intel.com/
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 3b7715ecf292..966e6c81a685 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1813,7 +1813,7 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
>  	 * the current one has not been updated yet.
>  	 */
>  	if (!IS_ERR(ret))
> -		userfaultfd_reset_ctx(vma);
> +		userfaultfd_reset_ctx(ret);
> 
>  	return ret;
>  }
> --
> 2.45.2

