Return-Path: <linux-fsdevel+bounces-29445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D29979CA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 10:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E91C225B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8F13D28F;
	Mon, 16 Sep 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyM4mzyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730DC522A;
	Mon, 16 Sep 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474727; cv=fail; b=c3DbnMhH5kGiEm78GkJNg4FhWIBSBzNAhfSH4FHluAkJrMMzazZkhzDZlFI9G4dbqpTDjmC7u+bUZ5GBMAjgud6HBQurOtuFfc6IE2h93SxR6o41DCqCAE0SYXf/ngg0iY7G3YsbVB4LHUxT3WxbK/gM5Kdo5R/hzdjCLgsPtIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474727; c=relaxed/simple;
	bh=cHCB36rz9fpnvksToGCUbMUbCr4PKPxLLdeF2IqGNqs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=r1PCS9f8ZpGvV4z3X+k9HG+UoFFzpUJNLsVbchGkCgvtjwWjXZLLYB6Ze46MpTRTJk6MGYaMzTXcKln5wudD16+Jw6NCkNPB1ewCI9Ov46p7fA//w8Ej+L21vBuexsqKognJT/0dp8JJiQ54wqrqwOVJ/0y+O79gVqWGHLLBaCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyM4mzyv; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726474725; x=1758010725;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cHCB36rz9fpnvksToGCUbMUbCr4PKPxLLdeF2IqGNqs=;
  b=XyM4mzyvCkJXe3BkyXjfn03VZvETK4o0XfQgFn0Ui4byvwxWUJPuHWXw
   fp3HTEyp39XITRGyO5dgMn2PGd029b8K6ARKe2wfLK589EbPVvIOvS2hz
   oYulp1zlSCxkLJmI05+48YI++eH8dX760fFLjVaJ7XJYR0ntnNaCzBtBx
   6H0rNNw0YbugMhFUTF667yVkQf9FRNTNfRvINI9hBW9D3peAhrkvxgyME
   bYc2Ai5RsN0szLsr8G/4TpRI6R8D0E/gjjub8Z+ZHHo/68Ptir9cBUr4L
   J/VYvzNzs4lY+xe+iyW79nPNs2KIkgbEVWNEEDuKGVe+LGdcPw/lmxOfy
   A==;
X-CSE-ConnectionGUID: zYajxvFVTk2w7XvvqiiW6Q==
X-CSE-MsgGUID: LQJplN0VSwyeNfnxYCDtYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="36426335"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="36426335"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 01:18:45 -0700
X-CSE-ConnectionGUID: GdYaW1G7SOa9CFAstdIk6Q==
X-CSE-MsgGUID: NP198WeCRriBYHhPf0BwOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="73571377"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 01:18:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 01:18:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 01:18:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 01:18:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 01:18:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4bdbzZNO9UlsPymOgY1pmL2dWh0j7f/6elW92SVghhqOuv+8DeSFJXQSTUbIrI0453KYQWmKyDyRvRsuyyk7SzYySRKfyP9tqH+8fopZou61RckuIy/Cgtnf1cuV4J6BMIRZUN7h6gjlSE7Q1lmGgCj8tG0LiMnvdUFbVx6D5YGAECKgEluaomRvyyottPp40Ez10HY4V3cCW6oX9bo9Ow2UHAcjnl21TVOblAMjlQLVy97JQ9UjhCqej9KD9AIZaAKewcNjbQBSM7pVGa5vzlcLIhheWp22/TPxTC+Xns63uNwOYeCL4hbO9yYQatbKrLO9LQHMWvDw2G1ZdsO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTA4gUmpSQaDzu4yWRXJF1llgOVtej+wsrsGLhyLKEQ=;
 b=KYlQ9rgzwAHkVFG5QK52RU4RbcdtZ/PWUevmw6FG3d0FnGCjmOxj2bVMt3ZRYpnnobYmojfKxaSbre8n2zqTMTXb7fMSNowZ/TiqUgFYurhuSH3++L6h7WsNWUYluUtQV/AE2yXGBgXDIKWD7aEe0W0owL/Gy9JsBBo4gti0PmgP5Lq9cCPMlZcJckuCu3MBnyu3VKWT693iqORuVvJZclb0oWoREEc5CctN9ThxKDWV8j6ekxDj+U+Vop3e2zywnkKTuZEQz6SIEIVLj2XMsGZoUj4kVjGNmxRLUcF47WKGRrmasDO8B+f3PVyzaQ7CX9sY+Nx9dCPb6a/WxaoWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 08:18:38 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:18:38 +0000
Date: Mon, 16 Sep 2024 16:18:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, Jeff Layton
	<jlayton@kernel.org>, Steve French <sfrench@samba.org>, Paulo Alcantara
	<pc@manguebit.com>, <netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:fs-next] [netfs, cifs]  73425800ac:
 xfstests.generic.080.fail
Message-ID: <202409161629.98887b2-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: b6895d99-db3b-4b95-0c85-08dcd6282ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jok5ojgWIgvsD4m5BnZ3S2kyxb6f1ZSHpNgiRJA+JhR0IFsktEGSpqWBNIIp?=
 =?us-ascii?Q?aauZQqGiF7xlD03sDo5XlnqDdJmm69j+uP+wknvz6t9KIoIvi7TZ/Rx5B+nA?=
 =?us-ascii?Q?b6D4vLJP7cQRpmEyQ037EbcAK5rbGuAyzJ4/c4c9Y9qzgkTfccnGkiFVETmJ?=
 =?us-ascii?Q?3ykCthBE+h9qST+2dLh10SXwWVjyUJdg2MJ5A9+zXlrTCMSrIXrOcfYAk7oP?=
 =?us-ascii?Q?i4Wtz4ORUNFglarbGlpWXGLb23Z6kbgaB8YhnfGDTarkSuy1rdDA562CvqtV?=
 =?us-ascii?Q?5plP6dPxggYljK7/P5F+B1XDNZngVCo30zcmwmPIcTK9FV0Uaw1Gzf/eJfgm?=
 =?us-ascii?Q?ltCQnUXHV2PnVLcFcqrlXfALaFVfshJy4dCXa+it1uS0/uQlzaGdhmomzRGH?=
 =?us-ascii?Q?9B/0+jtSdQNxKrPcsiUWqne3MhJsJjjFvi0o2rRzekrxabI0dLI6BeB0t2Ib?=
 =?us-ascii?Q?28Q0W6c7F3cB5sGs41g+zDjDFGiBsMFDtsnhPJZwqzn5Mnhyd/gR9w1T0+cp?=
 =?us-ascii?Q?tfKXYLkw7lVfXo3yxfdxJGLjckZc6cfOW2rDCJRGeTvXePPAPiIG7OdOABGU?=
 =?us-ascii?Q?7uKtpKqWbHbvWsEpdyYK9AijiDw8PMEyo3atXgZYcdgTKX/FNAazOEgynUPG?=
 =?us-ascii?Q?XNAW5W3X7CmqdSML/eMO12NXQftnw3HpKJOmgx8f8PtsGmC+PInBH1W8eGzk?=
 =?us-ascii?Q?Y6KKnar1iFiAlFRGrSnoj/GHAF5cMFJehBrNUq09zQgU6T0B1VU8Z4N+UL4Z?=
 =?us-ascii?Q?mlBbg1/z+2Y1xM1rlh7zR38BAt5MlammXmUKfG8Z/bZEafquphfmTge76GJT?=
 =?us-ascii?Q?jPAgz9pgy/MAAirTuMZfRau9kw6XZli4L6QFEDwYUuWRdTTGTwvKIHkqIqfM?=
 =?us-ascii?Q?Eaz/0MY6FNCQWESoGHZWusW+EAQzk3Z0ZCrQ8Fx2jDYVXpa4q+61Mzo2kcFn?=
 =?us-ascii?Q?7oCsqWG/fxEUNTlDci6YORGfMiz1ZWMjxIDNBmKKVpQoWb+8YRWw1PwiIWep?=
 =?us-ascii?Q?P3Gvzlmu5EqRX5eDmca8fGU3Yb8pFOPWu4405A9bcJIFeZiTupbvDBzWl4qY?=
 =?us-ascii?Q?ZRWKMY1/KCie3K3PpiL/i+YEr39weZoB4hlS4mctP/D2AAzzc+HUUOZfooe4?=
 =?us-ascii?Q?pR9ettrIs3ShrDPcsxUWin6x1RgMA/K5twemHTiRbuytSbyV+tVtue8Zwwb+?=
 =?us-ascii?Q?FMcMExOHQG9+8R1v/Vj4ady8EVyWUcFOwd71QJVFyJWC23jd+qZ0IlBWaV1y?=
 =?us-ascii?Q?ItP58g8nr1uawy9Dn4xU5042BYQtRk7xN9TQpa85bu+uLeWdp9Vg5PIRNtLj?=
 =?us-ascii?Q?zhe1Ij2gDsGx2/3rZz7WVV/vByGpH8M85wjoVxCxjQvwC1Hxn77MREwLXugb?=
 =?us-ascii?Q?ZZKx7oQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pViQCumGty2knc3S38fo2SMH/6puNfVllXFXL5QQbNZA8pmLvho4vmumiQOl?=
 =?us-ascii?Q?JJnXMMzVyOJR+N+CnISp1dUvX7vxIgNYVncXRK3StcPxGjq+/jBASiAA9Cd/?=
 =?us-ascii?Q?WNTzZldZ52n1XmLJ6+d8Yerg1jfdgZg9qTAEaQfZG7cb62NifKvnx+a2eNML?=
 =?us-ascii?Q?vZNlPViZTiTB0hzyMFoOAzHsPa+BeqYxky+zjRz42s+rtXpcG6TCVU/VY0Df?=
 =?us-ascii?Q?VUjTxFvYJvg4pMI65eaRKcwgqrU6n5N3kCRPeLUtUXEEMH6SeTF1/OHdp1RL?=
 =?us-ascii?Q?zBP7S7eptYLcVYu2VgmDClJ7xQkei736glLIgEKp2WSvOPCDa01MuIwzSMbL?=
 =?us-ascii?Q?sVmj0ulWRrUY7+ZvGfHaRLR9WJ1sbvTv8iCYbtqtb1dpy3/RjlMTjc+0Pw96?=
 =?us-ascii?Q?AIvZzrMgXJipffSPIN+ZJxwv5Mh5Zw0+q5JPr4EdnSw14y29cf4NLPaeEty3?=
 =?us-ascii?Q?lcgJWBbdKt4hnfYwVW8e3eytkJSyNTNiqD0+JlYZqjT+xCScG4KOG5SoS+zg?=
 =?us-ascii?Q?hPBdeZ0wsOZIbMFFU0+SWNNLADoivcXUN8wZ/xSceqD4/H0cramesCOD+8u9?=
 =?us-ascii?Q?Iyc1vCbx9yvXexmJtpwb5SAZ2VeX9UaEDTiyCrlihXssA08QIVdAmu9UsV3O?=
 =?us-ascii?Q?99Yfj8JUu8j7R0dXxan5lotKnNp7gSArMH7T0fvNzTzpqwtgRSIc2d+kCrNp?=
 =?us-ascii?Q?bgGu0aV7wxPfnXDpLVOOASIKFHN3mfhmQTyybXk6oz0B8OlEhlcokWJ/pNX6?=
 =?us-ascii?Q?oqGhQivi2ipnfwikq8pqzOV7tODMydwqNLFzAhrOU+bXMqUTTaRHy1+hXpKv?=
 =?us-ascii?Q?qNS9vAkhoRxMOUK8lTcbDvK2IcSncGj4Hq7n9zSoevPDHq6Nqo9hdMLqaNg6?=
 =?us-ascii?Q?LgtjmKRrtIJZGNs0T943oBTqe9mvIMa/qsAhfVQTL3n+CeDR/+Q8ETrfXBF4?=
 =?us-ascii?Q?M4ldWjec8/FY3JsXVVUfyjMNtoq3/iGXEWxq7CMWyU7A45lXhoCzJP4Q9mTu?=
 =?us-ascii?Q?IlV8KsGAUPI8hFihxwgKCZeaz4/MTCJKTFsfCXnZy1AZ91f/FqXXmaymsmgd?=
 =?us-ascii?Q?o0zuGvMaNbiKTwUUia/8Fbwch/m587yJhSPtk1/85FwX7xE16gJDSX6h2SRt?=
 =?us-ascii?Q?vEyDnxl4WKABhth1wZEzz8pGyfcsR5A8NzFzc+Ggvf6iHMO+mjxZWNohh0TJ?=
 =?us-ascii?Q?DzQiUyCHLcRWhWh+Q1xCerb2SzXK2oOS3B68kzYjY3FD5aed4vdS+li1RPtt?=
 =?us-ascii?Q?SphuCgW5IrQAjcV6qgSf7fazq0VEx9wFI/0HFsqocFDESKkgUz3uL0EXvAHC?=
 =?us-ascii?Q?Vw79BMveBcgaulpfCUUNcTkITAlxZvf+828Yh/pSGrZpPzG1U8fvMC9XhDp5?=
 =?us-ascii?Q?gR4yzE3nrrwl+pRNMcbUe+CcaZsofxEJXfhcpFtwo/8tZmjqk+vTLQQrjb5/?=
 =?us-ascii?Q?S0+vLcMIbfl9kCvHAU31qR9Q9vpCytaRqHrcZINE46Oma03gdiVXveikTj/I?=
 =?us-ascii?Q?DAghbrbulRvGKHyQItjK0ZaBztA0AFdYiIv+Gzn4DrYtdxegpo5a7FeGPmCZ?=
 =?us-ascii?Q?//Q9hwc+dtM+aaU3k9KwoBwQPzrFjMo0GpYiWlPLtU42Q9D8IC1v5BU8B9hT?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6895d99-db3b-4b95-0c85-08dcd6282ab5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:18:38.4062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3Hdo3GgipsL/Ox1Bvs+UBkoq9uNKoRTd7v6h7WEmNGo5XLSaFq+7aVBeTBVjoMRy55V0nu4OF5WUEcwG6Jt+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.080.fail" on:

commit: 73425800ac948cb78063b897a0c345d788f3594d ("netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git fs-next

[test failed on linux-next/master 57f962b956f1d116cd64d5c406776c4975de549d]

in testcase: xfstests
version: xfstests-x86_64-b1465280-1_20240909
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv3
	test: generic-080



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409161629.98887b2-oliver.sang@intel.com

2024-09-12 04:03:56 mount /dev/sda1 /fs/sda1
2024-09-12 04:03:56 mkdir -p /smbv3//cifs/sda1
2024-09-12 04:03:56 export FSTYP=cifs
2024-09-12 04:03:56 export TEST_DEV=//localhost/fs/sda1
2024-09-12 04:03:56 export TEST_DIR=/smbv3//cifs/sda1
2024-09-12 04:03:56 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=3.0,mfsymlinks,actimeo=0
2024-09-12 04:03:56 echo generic/080
2024-09-12 04:03:56 ./check -E tests/cifs/exclude.incompatible-smb3.txt -E tests/cifs/exclude.very-slow.txt generic/080
FSTYP         -- cifs
PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.11.0-rc6-00056-g73425800ac94 #2 SMP PREEMPT_DYNAMIC Thu Sep 12 08:55:10 CST 2024

generic/080       [failed, exit status 2]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/080.out.bad)
    --- tests/generic/080.out	2024-09-09 16:31:23.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/080.out.bad	2024-09-12 04:04:40.252660942 +0000
    @@ -1,2 +1,4 @@
     QA output created by 080
     Silence is golden.
    +mtime not updated
    +ctime not updated
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/080.out /lkp/benchmarks/xfstests/results//generic/080.out.bad'  to see the entire diff)
Ran: generic/080
Failures: generic/080
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240916/202409161629.98887b2-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


