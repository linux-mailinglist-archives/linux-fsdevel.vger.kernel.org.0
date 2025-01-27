Return-Path: <linux-fsdevel+bounces-40144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E478A1D87D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E347A3F16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA12746B;
	Mon, 27 Jan 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TB8DZOJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A028460;
	Mon, 27 Jan 2025 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988401; cv=fail; b=LcGb1KI7q1tPPLcSWY2mNgE0mJ71DfIGky1Vj3Hl2WLBTBOsGgvaAYdjtgaEJKQZoECKXuKREahmh1+/xvFoFrcySyD/q+ci8ot6F+q0CQuSMBBLLMbveDtPCYzlQ7Eq1YoTNEI+iEhGp0/OIGBvG3+4/tAsc/gClGtNr23D09M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988401; c=relaxed/simple;
	bh=9Rvhpk2+zYc1XBpU4FglRX2WOVO1/5qoxNXNwKw2xKA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=X4ljr17afYxj10tL0lpYGsb9tUCgwB34PpsWNvM6bK4VV8/yOrIZ46QJ7c6q6AMtPNibTNx4+KdXmnowvBqHdpDVMslPjm/YbKS14colUCdsSbFazXhy4ZSIstfcqY19Foq5wIRA/3PLf3XowU6EYKSa4c3zcd3wB24zs8oIvxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TB8DZOJB; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737988399; x=1769524399;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=9Rvhpk2+zYc1XBpU4FglRX2WOVO1/5qoxNXNwKw2xKA=;
  b=TB8DZOJByhlo3WcblH5w6XFKvT8UR6C4WwBpJkyWzO/SAbaqEqSouo/m
   qiyOnrbLU2IANjvu6LshyxuVQqBw5/Sk02WKVrTJfCZuSW6pWzMiUYugv
   41O/LRDfQ6n3WsBbmJqH2BZXmjiFMdG+TBn5Dg7A5jrot+dNfr0CjcLUp
   tRX/xPuX4c9h8cMKfrSEno+AFQdYSacvzFbTaOeXH7zLrKFZx6azUPW0W
   fQj02/VT9FyrZKv21brKWKcJe+F9PHE4xBb1leg3gxj5fBhboeUn5skHM
   rArtoGKXwC0X3y8MggmECf4t7kqyYgtiGArKIhfNmtmpcLEIiq64dKIOt
   g==;
X-CSE-ConnectionGUID: H/oS4G1bTnWmsPKx7lHqIA==
X-CSE-MsgGUID: yjt+BZjJSU+6BivWEj242w==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="49839174"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="49839174"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 06:32:52 -0800
X-CSE-ConnectionGUID: HYdwFMwHTPqjjZugeRRqPQ==
X-CSE-MsgGUID: FOt8zYuSSSqtjIkuL1Egaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113070614"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 06:32:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 06:32:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 06:32:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 06:32:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2BVpkF7iBpsYx1cGkQRjRr2m69LRYt9o7LB0bySB07xx+yzXXO4c3zexkCNLG8xCx/L9h7wcyfIEbwj56pEqRRsrC5ViK5Mm7ZsG8Nj9Kh5W/cCN2GaXLoZlnR8adY6NOdWih5iFdbVxube13ZSK3Z5ALbF37qZGiWwqHiDK6rah5/O7WGk16EweIFjeJFKDo/dQXEFCfspTdR1zlvD4qyPKi67a/ZyDT82JVMUvdYlwbRZyevAvkoa9U1jSXO2NSSg8gdN1lIrrG7t653LTnDt7R9jW2tbcKwfZUZHfr5ems52ybSFogcHEivqBnI4FiIW/xEeB/En4Rmu9aVvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbX6J08CCX8wFwGha37cvJyFHtY3xPNE6uKXkFXL/Rs=;
 b=SdMgkENFvNlTgCC3VkcXdshSfn15QxJYruVqF65o+FOY4xqBwf5LvYsPRA8BElm9RhB8VwT6MEj4Xt+2RKQvGEQTZ4LT7aLAruZlKuljclWcy7FhbvqT1L1bGK3yVocxdR/hCVv5tkABUhkY7MVjDBzCZLKGYLZCrGY1EJel3SopbkOfP+uK0KhwNhiDfrvBFjKpUwCZ8az5hWM0cjH3lOU/WIGjGc82ihrrw9PsD4cY+mJTXo94Jm3Jks69ZzbaCbhvqjaR7/rb39xhnJgkW+Lpdl8HdT9VJPILppgzC0aHtr5IS1qC0QCrIn8GVck9OHfEycQfUkdZbJQt9EPvQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6405.namprd11.prod.outlook.com (2603:10b6:8:b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Mon, 27 Jan
 2025 14:32:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 14:32:19 +0000
Date: Mon, 27 Jan 2025 22:32:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [pidfs]  16ecd47cb0:  stress-ng.fstat.ops_per_sec
 12.6% regression
Message-ID: <202501272257.a95372bc-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:820:d::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 1246f185-84bd-4058-479b-08dd3edf67ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Zp1i32SHUf/zrIhX842GtyQjA2VktJmiFVs5r+A5JZcehmpbKm0PgpsF0m?=
 =?iso-8859-1?Q?Yv2vL2jmz0Ykd/bxb3WTxpMzRE80Pxov6tmfhLFz4OGPORitpPy2MsvMK6?=
 =?iso-8859-1?Q?2NkLMfq/ko+MBYhHPOHeFuUT+pFrHJviXJUtaYpeznnqkGHijclF3Fp/Li?=
 =?iso-8859-1?Q?Y3CaxOQ+CDKak0clCzE+gWOMak13qPSi48U74Oj32ACPDHnU0d8s/ytedu?=
 =?iso-8859-1?Q?U8rxWHFMSV2yteAt96aw3QcJr7gw6586D2uhQPyPFCT8pYjlqdSVe/DPCI?=
 =?iso-8859-1?Q?lw1DbJ9TQgNILUsObGC6WR6g56PpFiC/4oZXBw3GP45n0dCm6jJNsCOm5z?=
 =?iso-8859-1?Q?lpiGA+WU1OXAoI9NNenB0rwtk3OYpckSblU1XkbuUBuvN3fVLHQrscx1n6?=
 =?iso-8859-1?Q?74QwWA180w0CXny5qWy4V8HP0SBzdOG8pVugpaz1j8Wwg7traKXw9QRNGv?=
 =?iso-8859-1?Q?1tbRpeBNsumaNwupq0DjAmYHQFPzrsIdev6Fxfuiv2uYIbJlWpkAbEr4kY?=
 =?iso-8859-1?Q?Mpi0UeAKZqw+WOFt2IrGM7By0QGwVwlhmkUuZSfJuc2cdVwoOd/e7xY7n1?=
 =?iso-8859-1?Q?TczipGADUWJQveWzTOKOPtVcGk5299tiJbKT61hWwz93Z+0cviE72bkSZ/?=
 =?iso-8859-1?Q?/hc6P/h6mO9HvDBIZUOoDVrYuX2Bz0g9z1mtHJmETWWkx6neu5qmWk1/94?=
 =?iso-8859-1?Q?rTAY8Vkf4Lh2+NDfdDDA/B4MZZ3/KKKqEzzWHML3MW91FSbs8C5AK60mMS?=
 =?iso-8859-1?Q?sRyXSyk87vT7Q1Ysa6k89qcmkA7JHiQv95au+hMMTQC3FniggdVAWs3OVr?=
 =?iso-8859-1?Q?7hFJgbtQVnLSlIEdqnEeS9yBcmKX4Eucabjmt7S5NW++8BnIJPOT0WLr1L?=
 =?iso-8859-1?Q?evs8GAOfQ519vI9XpDKdhVmGijpJUGmcdPAvWJu13Jbpzjb1cJxKyWB4zg?=
 =?iso-8859-1?Q?VirI4UDsixbZfdqWzYayzyQ6jM1dPxSjIpptfgaNULYdp1jrfblVuAMB4N?=
 =?iso-8859-1?Q?6s6Crbb/Bmk7LJZi37xbOVwWlbykkFBPPoKMfxI4HUxtD9Scf8HUkwTIwE?=
 =?iso-8859-1?Q?V3WEFSL+NgS8T/6MlrIICqVXVEOrIBhDKO5plsRTEyFTzULP6ZEfmzDT07?=
 =?iso-8859-1?Q?GJkT8G8TfATj4EgMLJVARFC/J3yOSKRpaq+iiPRaFNjV+b+tL4pyGiHL85?=
 =?iso-8859-1?Q?rl67UwsqqeoPgXkP3TwpDMl3xjAGHenEjzlR9bnDJIqGs9/qDxcrjBwTIG?=
 =?iso-8859-1?Q?XYNbZyd6+8J+ieqJWZ3od/b8bQpijhZAmPrRe72PNdR03dwV8hJUe19F5J?=
 =?iso-8859-1?Q?NZX5KXK3Unjvq9p0ICbR7biRVu4sawp1Z5bBCcQiS3lt1uLMJ2JiIPnG+Z?=
 =?iso-8859-1?Q?/vvdtRGCZUKgJGCouu9x0YxfquqUsU4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aVmwZsdTVZw0E3PEpBO3UgTUQ98NY02bWZtt3ccYGYe2HAsTXWT/hNuEvq?=
 =?iso-8859-1?Q?lCO485Gfy1L+WYKwkoOb6c5JgN+efqIrTbBoOI6SuQqUu54iV25PF8ldem?=
 =?iso-8859-1?Q?VjwJEaeVTbG121nVu5CPqt8HzW8TUnzf1AlZkFQB4hl1oaFeOSxBhZQ6Bq?=
 =?iso-8859-1?Q?q0ShFzF4HHfpeV7S0dMurWlypJuHx6XB1najBn4y6aci7dyBvv1UA7aWh6?=
 =?iso-8859-1?Q?EajRhqqe+9IwbtGFU6Gs/EV8HcSoEvur3oh7AAU3nDwfdvyjZiSDoAbS94?=
 =?iso-8859-1?Q?CQjRdkk9UZgIBMf0rTi6z+K6PaLl/3kJFfglAIjRHLUbncTqFUg+vD0P97?=
 =?iso-8859-1?Q?34a+iEWI3gBjBl4K81q9nmvAqQUW8WI++awtmaz1I3TtyU0+pw9yRWDi9u?=
 =?iso-8859-1?Q?7dFnznXltauvsBzfd35Xm6qzX7OyTLMKTyawievbWPERkqhF63I5VkNEQh?=
 =?iso-8859-1?Q?+LlOvwmutH5eoB4W9QyEKyH9V4G6wJApL0JddtdF1sFmK1NzOUL0AHOZW9?=
 =?iso-8859-1?Q?y70tXx8snf0vVLkFjgL9bmThShN/yn7FDi9zkAV7opt2DZVmcXM0vK1PhO?=
 =?iso-8859-1?Q?Fd2mfMbDUVVmZ2GyGvPfLgkegvWWrSMfJqLkKQNU2wNBq7+4vh+bYOa/E/?=
 =?iso-8859-1?Q?MzuWdWQ4AycechQ6ULh/1msSyfklMACSWdTLz8DTo9pH69zdnRY5aLFEdN?=
 =?iso-8859-1?Q?tq7XvtF2dVl3RXcUMVGXVxllsN0X8zdARIds+Puhgp3zFd9M8OsM+mXnsM?=
 =?iso-8859-1?Q?nb1GmqDEgqwN+TSzy8rcovegnLmgNx7wZcN8OonPlxT1g5fTB3zW4fBSVz?=
 =?iso-8859-1?Q?25ZIlzcE6IA0BXghiIu54Eb139pxYeb7lSSsbl27eV43typI2jLug8MgLU?=
 =?iso-8859-1?Q?urABqffpcy8Bjnj2RZLyY7wFNOKyAc3d9CMmrPHTheEjYyGy3nSg9nlLoL?=
 =?iso-8859-1?Q?AGrdaeMz1v7VbkxkY94AEsAtO9i/wisCc0FPtJfjc+skm49XlfIq7aP7zj?=
 =?iso-8859-1?Q?OSiR5CulNBiPDP8fcujtlHOaQYyVvgiaIlIFNcWy2sl6DhqRgGrtjIZkBA?=
 =?iso-8859-1?Q?IpjZyG3jVv1zLZRMEgqOtUFzskHshWa0DKQbmr06dpByAHW8UoUMgVG4iL?=
 =?iso-8859-1?Q?O0etO+D8xN+FdFkg2wjrtJkbKS21fLDo3HZ2W1tLWeJJdvP8b2aGSKP7RT?=
 =?iso-8859-1?Q?AOTd+OrGvBck6dmyU6NC5zFUW1nO3G9316SJIhziTmVSkC9i0G2D8IQI+6?=
 =?iso-8859-1?Q?x+uvs1/ai/EZ8on2mdVhAKBwVI5LVNvcdWKZh1n1gaklXdhK7BevjK4Rh4?=
 =?iso-8859-1?Q?uatDGbVRwsbJHu0w+1yFAsk14UQMoLZY9vEWzPKRXqJ5BnUQObUM99Ubg4?=
 =?iso-8859-1?Q?cmA52souLbUHShrbQ7ND/gX9t7boKLMUfwCjfTat+cxhdfJYSKuduPDEW3?=
 =?iso-8859-1?Q?iHwcOPI3VlK53xzsCVL1SdjVX1GO1zr7oxWpT5Sh+rJk+N2vJ5oz05aoo3?=
 =?iso-8859-1?Q?VQMTT17rIoaSZBLVL/XdYOzc+GhTEMqgNKn79ejB+1k2DITvQDspiTzn+B?=
 =?iso-8859-1?Q?TpARHlW0F2CNHo0zGYZizygfoG16+E1z0VGtxZXGuxyT/pUorkSID+3E4k?=
 =?iso-8859-1?Q?dUPR6mDYBN0XtvFEe5D1+gFQymJLN6IJDQkgkMTKS9E86DFS57DXtVkw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1246f185-84bd-4058-479b-08dd3edf67ad
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 14:32:19.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G7Go+7yzsAZXq96mY3UnnffFZzBTbDThOc35dhHyEy1IhevHKMRM2OuasXfhfzr/81fB1cC36+JckH5Hk8yHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6405
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 12.6% regression of stress-ng.fstat.ops_per_sec on:


commit: 16ecd47cb0cd895c7c2f5dd5db50f6c005c51639 ("pidfs: lookup pid through rbtree")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      aa22f4da2a46b484a257d167c67a2adc1b7aaf68]
[test failed on linux-next/master 5ffa57f6eecefababb8cbe327222ef171943b183]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	test: fstat
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.pthread.ops_per_sec 23.7% regression                                   |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=pthread                                                                                |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501272257.a95372bc-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250127/202501272257.a95372bc-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/fstat/stress-ng/60s

commit: 
  59a42b0e78 ("selftests/pidfd: add pidfs file handle selftests")
  16ecd47cb0 ("pidfs: lookup pid through rbtree")

59a42b0e78888e2d 16ecd47cb0cd895c7c2f5dd5db5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2813179 ±  2%     -30.7%    1948548        cpuidle..usage
      7.22            -6.8%       6.73 ±  2%  iostat.cpu.user
      0.38            -0.0        0.33        mpstat.cpu.all.irq%
   5683055 ±  5%     -13.3%    4926006 ± 10%  numa-meminfo.node1.Active
   5683055 ±  5%     -13.3%    4926006 ± 10%  numa-meminfo.node1.Active(anon)
    681017           -13.0%     592632        vmstat.system.cs
    262754            -8.6%     240105        vmstat.system.in
  25349297           -14.3%   21728755        numa-numastat.node0.local_node
  25389508           -14.3%   21770830        numa-numastat.node0.numa_hit
  26719069           -14.2%   22919085        numa-numastat.node1.local_node
  26746344           -14.2%   22943171        numa-numastat.node1.numa_hit
  25391110           -14.3%   21771814        numa-vmstat.node0.numa_hit
  25350899           -14.3%   21729738        numa-vmstat.node0.numa_local
   1423040 ±  5%     -13.3%    1233884 ± 10%  numa-vmstat.node1.nr_active_anon
   1423039 ±  5%     -13.3%    1233883 ± 10%  numa-vmstat.node1.nr_zone_active_anon
  26748443           -14.2%   22948826        numa-vmstat.node1.numa_hit
  26721168           -14.2%   22924740        numa-vmstat.node1.numa_local
   4274794           -12.6%    3735109        stress-ng.fstat.ops
     71246           -12.6%      62251        stress-ng.fstat.ops_per_sec
  13044663           -10.2%   11715455        stress-ng.time.involuntary_context_switches
      4590            -2.1%       4492        stress-ng.time.percent_of_cpu_this_job_got
      2545            -1.6%       2503        stress-ng.time.system_time
    212.55            -8.2%     195.17 ±  2%  stress-ng.time.user_time
   6786385           -12.7%    5924000        stress-ng.time.voluntary_context_switches
   9685654 ±  2%     +15.2%   11161628 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
   4917374 ±  6%     +26.4%    6217585 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.min
   9685655 ±  2%     +15.2%   11161628 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
   4917374 ±  6%     +26.4%    6217586 ±  8%  sched_debug.cfs_rq:/.min_vruntime.min
    319.78 ±  4%      -8.9%     291.47 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
    331418           -12.3%     290724        sched_debug.cpu.nr_switches.avg
    349777           -12.0%     307943        sched_debug.cpu.nr_switches.max
    247719 ±  5%     -18.2%     202753 ±  2%  sched_debug.cpu.nr_switches.min
   1681668            -5.8%    1584232        proc-vmstat.nr_active_anon
   2335388            -4.2%    2237095        proc-vmstat.nr_file_pages
   1434429            -6.9%    1336146        proc-vmstat.nr_shmem
     50745            -2.5%      49497        proc-vmstat.nr_slab_unreclaimable
   1681668            -5.8%    1584232        proc-vmstat.nr_zone_active_anon
  52137742           -14.2%   44716504        proc-vmstat.numa_hit
  52070256           -14.2%   44650343        proc-vmstat.numa_local
  57420831           -13.4%   49744871        proc-vmstat.pgalloc_normal
  54983559           -13.7%   47445719        proc-vmstat.pgfree
      1.30           -10.6%       1.17        perf-stat.i.MPKI
 2.797e+10            -7.0%    2.6e+10        perf-stat.i.branch-instructions
      0.32 ±  4%      +0.0        0.33        perf-stat.i.branch-miss-rate%
     24.15            -1.1       23.00        perf-stat.i.cache-miss-rate%
 1.689e+08           -17.1%  1.401e+08        perf-stat.i.cache-misses
  6.99e+08           -12.9%  6.085e+08        perf-stat.i.cache-references
    708230           -12.7%     618047        perf-stat.i.context-switches
      1.71            +8.2%       1.85        perf-stat.i.cpi
    115482            -2.7%     112333        perf-stat.i.cpu-migrations
      1311           +21.2%       1588        perf-stat.i.cycles-between-cache-misses
 1.288e+11            -7.3%  1.195e+11        perf-stat.i.instructions
      0.59            -7.4%       0.55        perf-stat.i.ipc
     12.84           -11.0%      11.43        perf-stat.i.metric.K/sec
      1.31           -10.5%       1.17        perf-stat.overall.MPKI
      0.29 ±  4%      +0.0        0.30        perf-stat.overall.branch-miss-rate%
     24.21            -1.1       23.07        perf-stat.overall.cache-miss-rate%
      1.71            +8.2%       1.85        perf-stat.overall.cpi
      1303           +21.0%       1576        perf-stat.overall.cycles-between-cache-misses
      0.58            -7.6%       0.54        perf-stat.overall.ipc
 2.724e+10            -6.8%  2.539e+10        perf-stat.ps.branch-instructions
 1.648e+08           -16.8%  1.371e+08        perf-stat.ps.cache-misses
 6.807e+08           -12.7%  5.943e+08        perf-stat.ps.cache-references
    689389           -12.5%     603372        perf-stat.ps.context-switches
 1.255e+11            -7.0%  1.167e+11        perf-stat.ps.instructions
 7.621e+12            -6.9%  7.097e+12        perf-stat.total.instructions
     56.06           -56.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     56.04           -56.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.25           -31.2        0.00        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.23           -31.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_exit.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.22           -31.2        0.00        perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.58           -27.6        0.00        perf-profile.calltrace.cycles-pp.exit_notify.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
     23.72           -23.7        0.00        perf-profile.calltrace.cycles-pp.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.68           -23.7        0.00        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.15           -20.2        0.00        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.23           -19.2        0.00        perf-profile.calltrace.cycles-pp.fstatat64
     16.51           -16.5        0.00        perf-profile.calltrace.cycles-pp.statx
     14.81           -14.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
     14.52           -14.5        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
     14.52           -14.5        0.00        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64
     14.05           -14.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone3
     14.04           -14.0        0.00        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit.x64_sys_call
     13.55           -13.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit
     13.24           -13.2        0.00        perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.__x64_sys_exit.x64_sys_call
     13.08           -13.1        0.00        perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
     12.01           -12.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.statx
     11.93           -11.9        0.00        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.exit_notify.do_exit.__x64_sys_exit
     11.76           -11.8        0.00        perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
     11.72           -11.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
     11.45           -11.4        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.exit_notify.do_exit
     10.27           -10.3        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      7.21            -7.2        0.00        perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.25            -5.3        0.00        perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
     86.11           -86.1        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     85.52           -85.5        0.00        perf-profile.children.cycles-pp.do_syscall_64
     41.40           -41.4        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     40.49           -40.5        0.00        perf-profile.children.cycles-pp.queued_write_lock_slowpath
     31.57           -31.6        0.00        perf-profile.children.cycles-pp.x64_sys_call
     31.23           -31.2        0.00        perf-profile.children.cycles-pp.do_exit
     31.23           -31.2        0.00        perf-profile.children.cycles-pp.__x64_sys_exit
     27.59           -27.6        0.00        perf-profile.children.cycles-pp.exit_notify
     23.72           -23.7        0.00        perf-profile.children.cycles-pp.__do_sys_clone3
     23.69           -23.7        0.00        perf-profile.children.cycles-pp.kernel_clone
     20.18           -20.2        0.00        perf-profile.children.cycles-pp.copy_process
     19.70           -19.7        0.00        perf-profile.children.cycles-pp.fstatat64
     16.58           -16.6        0.00        perf-profile.children.cycles-pp.statx
     13.51           -13.5        0.00        perf-profile.children.cycles-pp.__do_sys_newfstatat
     13.25           -13.2        0.00        perf-profile.children.cycles-pp.release_task
     12.22           -12.2        0.00        perf-profile.children.cycles-pp.vfs_fstatat
     11.38           -11.4        0.00        perf-profile.children.cycles-pp.vfs_statx
     10.36           -10.4        0.00        perf-profile.children.cycles-pp.__x64_sys_statx
      8.25            -8.3        0.00        perf-profile.children.cycles-pp.filename_lookup
      7.89            -7.9        0.00        perf-profile.children.cycles-pp.getname_flags
      7.74            -7.7        0.00        perf-profile.children.cycles-pp.path_lookupat
     41.39           -41.4        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/pthread/stress-ng/60s

commit: 
  59a42b0e78 ("selftests/pidfd: add pidfs file handle selftests")
  16ecd47cb0 ("pidfs: lookup pid through rbtree")

59a42b0e78888e2d 16ecd47cb0cd895c7c2f5dd5db5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 6.458e+08 ±  3%     -20.7%  5.119e+08 ±  6%  cpuidle..time
   4424460 ±  4%     -56.5%    1923713 ±  2%  cpuidle..usage
      1916           +17.2%       2245 ±  2%  vmstat.procs.r
    880095           -24.7%     662885        vmstat.system.cs
    717291            -7.6%     662983        vmstat.system.in
      4.81            -0.9        3.87 ±  2%  mpstat.cpu.all.idle%
      0.48            -0.1        0.42        mpstat.cpu.all.irq%
      0.32 ±  3%      -0.1        0.26 ±  2%  mpstat.cpu.all.soft%
      1.77            -0.3        1.46        mpstat.cpu.all.usr%
  43182538           -21.9%   33726626        numa-numastat.node0.local_node
  43338607           -22.0%   33814109        numa-numastat.node0.numa_hit
  43334202           -22.8%   33451907        numa-numastat.node1.local_node
  43415892           -22.6%   33601910        numa-numastat.node1.numa_hit
  43339112           -22.0%   33811967        numa-vmstat.node0.numa_hit
  43183037           -21.9%   33724483        numa-vmstat.node0.numa_local
  43416602           -22.6%   33599378        numa-vmstat.node1.numa_hit
  43334912           -22.8%   33449374        numa-vmstat.node1.numa_local
     13189 ± 14%     -24.0%      10022 ± 19%  perf-c2c.DRAM.local
      9611 ± 16%     -28.8%       6844 ± 17%  perf-c2c.DRAM.remote
     16436 ± 15%     -32.1%      11162 ± 19%  perf-c2c.HITM.local
      4431 ± 16%     -30.8%       3064 ± 19%  perf-c2c.HITM.remote
     20868 ± 15%     -31.8%      14226 ± 19%  perf-c2c.HITM.total
    205629           +67.1%     343625        stress-ng.pthread.nanosecs_to_start_a_pthread
  12690825           -23.7%    9689255        stress-ng.pthread.ops
    210833           -23.7%     160924        stress-ng.pthread.ops_per_sec
   5684649           -16.0%    4772378        stress-ng.time.involuntary_context_switches
  26588792           -21.0%   20998281        stress-ng.time.minor_page_faults
     12705            +5.1%      13353        stress-ng.time.percent_of_cpu_this_job_got
      7559            +5.6%       7986        stress-ng.time.system_time
    132.77           -24.1%     100.72        stress-ng.time.user_time
  29099733           -22.3%   22601666        stress-ng.time.voluntary_context_switches
    340547            +1.4%     345226        proc-vmstat.nr_mapped
    150971            -3.2%     146184        proc-vmstat.nr_page_table_pages
     48017            -2.0%      47078        proc-vmstat.nr_slab_reclaimable
    540694 ±  9%     +50.6%     814286 ± 15%  proc-vmstat.numa_hint_faults
    255145 ± 22%     +62.3%     414122 ± 17%  proc-vmstat.numa_hint_faults_local
  86757062           -22.3%   67418409        proc-vmstat.numa_hit
  86519300           -22.4%   67180920        proc-vmstat.numa_local
  89935256           -22.2%   69939407        proc-vmstat.pgalloc_normal
  27887502           -20.1%   22295448        proc-vmstat.pgfault
  86343992           -22.7%   66777255        proc-vmstat.pgfree
   1187131 ± 23%     -42.2%     686568 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.stddev
  12970740 ± 42%     -49.3%    6577803 ± 11%  sched_debug.cfs_rq:/.left_deadline.max
   2408752 ±  4%      -9.6%    2177658 ±  2%  sched_debug.cfs_rq:/.left_deadline.stddev
  12970554 ± 42%     -49.3%    6577515 ± 11%  sched_debug.cfs_rq:/.left_vruntime.max
   2408688 ±  4%      -9.6%    2177606 ±  2%  sched_debug.cfs_rq:/.left_vruntime.stddev
   1187132 ± 23%     -42.2%     686568 ± 15%  sched_debug.cfs_rq:/.min_vruntime.stddev
  12970563 ± 42%     -49.3%    6577516 ± 11%  sched_debug.cfs_rq:/.right_vruntime.max
   2408788 ±  4%      -9.6%    2177610 ±  2%  sched_debug.cfs_rq:/.right_vruntime.stddev
   2096120           -68.2%     665792        sched_debug.cpu.curr->pid.max
    655956 ±  8%     -53.1%     307752        sched_debug.cpu.curr->pid.stddev
    124008           -24.6%      93528        sched_debug.cpu.nr_switches.avg
    270857 ±  4%     -38.9%     165624 ± 10%  sched_debug.cpu.nr_switches.max
     27972 ± 13%     -67.5%       9102 ± 17%  sched_debug.cpu.nr_switches.stddev
    179.43 ±  4%     +17.8%     211.44 ±  4%  sched_debug.cpu.nr_uninterruptible.stddev
      4.21           -13.4%       3.65        perf-stat.i.MPKI
  2.03e+10            -8.3%  1.863e+10        perf-stat.i.branch-instructions
      0.66            -0.1        0.61        perf-stat.i.branch-miss-rate%
 1.289e+08           -16.7%  1.074e+08        perf-stat.i.branch-misses
     39.17            +0.7       39.92        perf-stat.i.cache-miss-rate%
 3.806e+08           -21.8%  2.976e+08        perf-stat.i.cache-misses
 9.691e+08           -23.3%  7.437e+08        perf-stat.i.cache-references
    903142           -24.9%     678436        perf-stat.i.context-switches
      6.89           +11.5%       7.69        perf-stat.i.cpi
 6.239e+11            +1.0%  6.304e+11        perf-stat.i.cpu-cycles
    311004           -18.5%     253387        perf-stat.i.cpu-migrations
      1631           +29.1%       2106        perf-stat.i.cycles-between-cache-misses
 9.068e+10            -9.7%  8.192e+10        perf-stat.i.instructions
      0.15            -9.5%       0.14        perf-stat.i.ipc
     10.41           -22.2%       8.11        perf-stat.i.metric.K/sec
    462421           -19.7%     371144        perf-stat.i.minor-faults
    668589           -21.0%     527974        perf-stat.i.page-faults
      4.22           -13.6%       3.65        perf-stat.overall.MPKI
      0.63            -0.1        0.57        perf-stat.overall.branch-miss-rate%
     39.29            +0.7       40.04        perf-stat.overall.cache-miss-rate%
      6.94           +11.7%       7.75        perf-stat.overall.cpi
      1643           +29.3%       2125        perf-stat.overall.cycles-between-cache-misses
      0.14           -10.5%       0.13        perf-stat.overall.ipc
 1.971e+10            -8.6%  1.801e+10        perf-stat.ps.branch-instructions
 1.237e+08           -17.2%  1.024e+08        perf-stat.ps.branch-misses
 3.713e+08           -22.3%  2.887e+08        perf-stat.ps.cache-misses
 9.451e+08           -23.7%   7.21e+08        perf-stat.ps.cache-references
    883135           -25.3%     659967        perf-stat.ps.context-switches
    304186           -18.9%     246645        perf-stat.ps.cpu-migrations
 8.797e+10           -10.0%  7.916e+10        perf-stat.ps.instructions
    445107           -20.6%     353509        perf-stat.ps.minor-faults
    646755           -21.7%     506142        perf-stat.ps.page-faults
 5.397e+12           -10.2%  4.846e+12        perf-stat.total.instructions





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


