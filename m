Return-Path: <linux-fsdevel+bounces-51843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F66ADC178
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 07:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3BF166919
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 05:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3921D00E;
	Tue, 17 Jun 2025 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrtGr3UC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3B156F5E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137343; cv=fail; b=fy0z0z8UfTu2Iwhx6DT1WRU0NoPD5EoCP+ZQagmKcewKRmNmLbdUZMDZ6OnkgFJzrDYIsT9D4//lGLoAotry7btXkmnRquaBRN0Ete/BSfFi5AU44r7LYWik4jNrhUv6Nrl/OyfA3zBfma8UHakGghG9xd12NOXIFJPx6nP4vW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137343; c=relaxed/simple;
	bh=RoLjR6AkpOkTudT6xPc8geCcJ/JLyMvvxnPIOOdgKk4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=D9grnrmQZIZ88qO/BtPgW3l+abJcjFzF39RuXXXI9ioY7Q4DlLZF+SbnnXL2vMwtrBA8xK6SO/uwKvi2JZiDqcRFCeJOomhmvohMMSjA91fSwTE4BXtkfC/E/ugTx+/7P+bLvQej4/ely32T89n50BWio4U06sx8i/Lc6iIyYec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrtGr3UC; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750137341; x=1781673341;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RoLjR6AkpOkTudT6xPc8geCcJ/JLyMvvxnPIOOdgKk4=;
  b=mrtGr3UCLqGo3QQaIketmVcU2LhGdA5iBn5EMzaDQ9RrigiKu+YdZlxV
   DMG0SYtoCAYPEGXv571h+O8qbuHDJG8oFzq9u3CUmTFAZCJqsDZKJznFt
   P6larullXePqDCFDCkCZw4klI4zcfyPabk3xtUaKTLoWMkDfBZLNaUcqo
   5SNN+vT0QPbnm9TGbzTT1tGAWZ/u5S5Mzr71Gnw4/YA2TXdnBBQaqoMeG
   LCospjXaoKC3ZcIJXWA+O3bqPHyj2hIq4USc1HDc92tyRtuIk0A8NlHC3
   NsYXmycsLdMRdCzMTHoRqyPO/J8pcH/31CucQ5MzjWKJmhbUcnqgEu6EM
   A==;
X-CSE-ConnectionGUID: RzQxptYmSM6gn8Nz4NvxMg==
X-CSE-MsgGUID: dBmfS8hVRK2SCpd+2Z+7NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62903778"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="62903778"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 22:15:40 -0700
X-CSE-ConnectionGUID: aFW09GZZR+uSzvR6koafLQ==
X-CSE-MsgGUID: +5QL1ka7RP+w8zXOUV+sMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="148570586"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 22:15:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 22:15:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 22:15:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 22:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNqRjZHAVh/oNg5zPMaqlI2BB2ehTVo1My6uF6XhODivKuZx8fZ+0Xj4A1Ah6NeofGARDl4+jaSpnrcMvm2nF8QN7CBwULrbEeyMuuP/kvQVHxdf1JA8ICwu3TG2A2n3O/2F3tBay/qDtLAIff31fBowyANHHAyLL0KeUmmkkamNpZe32ppXfpATuazQsNSu00fGmqVFlzUZIJh2nYZVhYKqJAlSXYS83qLFWNl377HXGoXbLhKz9ng+Nq8W18f0SOCXH4NKZNIi5r3iSM9YV5Du5Ghmh6IhGXbA5U62NYR57L9PXHK+O/21anYoidgLBzkLvaCpSdh3wNBWyGj6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMVSP/h8vhDturtNUHEraNhA7Au27KkvVoraxF1+xPg=;
 b=GIILzziB/ULUSyQDhzDKdGLAWltHHn7ztRlgw6ybcwJ3lL6M8O09PD1pnGHMRThKrqdW5FijT4V+CFj4bmWFevNzsS5nhqpA8ofI9Eu5biJW+EPM4+rAfsLmycGUDV4t5yYHIOqOiTR3B9hiqZMTW3WAlEQugaXzWnQIH/TWfxh/Q/KztfH5b3fkefBidQkbMM1jPCB2GC9pJ1QcQR2jBYR+YtWhfbt4KQkIVcB3M0Mxr2DcN8L3nsy1AW8SH5vZ37P4h233ouGIisojeHoSBnHWMVmqu+sACGoKbeavQLgHqqe5yNOLtZ6c4JBn8D+X9VNeb2fs0+76yxYAewzwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7284.namprd11.prod.outlook.com (2603:10b6:208:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 05:15:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 17 Jun 2025
 05:15:09 +0000
Date: Tue, 17 Jun 2025 13:14:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [brauner-vfs:work.pidfs] [pidfs]  56e50aa99d:
 WARNING:at_kernel/pid.c:#put_pid
Message-ID: <202506171228.578f7de6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU3P306CA0005.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ff4785-42ce-4c8b-3844-08ddad5dedbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pe9csP+OXpO6G4H9VLo+AwwvdLu6CODGB6CDThB14ZOr0g+VT3s/FuYA6A3d?=
 =?us-ascii?Q?u13IP/DiOxFF1ZNMOsuKxQq6BvC7dmfSdvmYM5TRbsI0fduQMbAZ3QgSp8Ej?=
 =?us-ascii?Q?h/N5HQ0c+67snPSzkyQ7bMtgOQfRs+ojdvZACq695YquF8yfiQs5Qip67pni?=
 =?us-ascii?Q?QVsFYd7rMYzFE1Zb2Rlbcu9v9x2bzKuh6NkxR6z6bu+3yKIzAahlxURgLq/v?=
 =?us-ascii?Q?Hmg3NylWO99uWEpYs1Kwa9AVDdxh9/TY7TaYwDepW+sogjyqqGI5JqJ3XCCQ?=
 =?us-ascii?Q?COgFbLvWYeXXQ8DebSwJMGrbCtinXIn/HEueTAdTcNJsYoEy1IYmnr1AVyLm?=
 =?us-ascii?Q?YyJtUOVh6KifG0mGx95O5tMioJacx13+ORB62P+Q4YHaHnDyGkmv//Z5AQAD?=
 =?us-ascii?Q?xrn9CqKBJG46MXihak1RPXfWgQaCR0ZZ2s0IjvGM4vqa19dZaW8Pyt4rZVs9?=
 =?us-ascii?Q?5LJl5JmG06H71JUytZKSQMNXK9Poum+R3FTpZuHxmKNlMGoTzNiM5zKWX417?=
 =?us-ascii?Q?73xLGwAHZMX06tyUqVa/LnXxbqwSHIhDbuHjH5AcPUDbbDqRORaJIdWjcmsb?=
 =?us-ascii?Q?MfgZoA78ulC03XxYYkZnYc4qgVHZvfgeGZIhz629j0m7QYdTBTzH4n3QliYA?=
 =?us-ascii?Q?p3Nl6TnswVNz6S7BxKNl5EFwlncGmYEYMOZxHZb0Lv96s+Qp6WFOScAZoAUy?=
 =?us-ascii?Q?I7IgHpPtJDfzHEQlbnzpjPbtMRgsZD3jQnXvZSpOTGaVBMxDazf7QSiJtq/X?=
 =?us-ascii?Q?NK/kbU8VWxRflCsoNAEo4K0W9t18tf1mGFlQzxK9pE4SFVVatZ+DnfM/xlu2?=
 =?us-ascii?Q?PghYXdZxJ9zqPiX5HZRPGHnqEPG9G2essb9Fi1mifu0rL+CgXyrDpIGZhuIg?=
 =?us-ascii?Q?ZxRDODhJWZV7JRK/mNXtaIHsV324xKDq7hlK1OO4+fiMUZlxmC9jVg6QisRe?=
 =?us-ascii?Q?4FswBSO9iFiUBdCM0rPextFfgyIgmRu5rxgVPOdel3MhRyF8wqAnrgobwaH9?=
 =?us-ascii?Q?8yACAA2WnjepWIE6MiGmwY9KzR7pK9FGPit4GjbnXYzvbCCsj2GnJ1HziFo3?=
 =?us-ascii?Q?8QFr1nx0FDjjjdKylgziW+ubNNwPhgXPSA+91tV4lyoekdEU7nhHg8ccTUPl?=
 =?us-ascii?Q?aL7XW0gqMUzpVqUxuF+Ig5s/LyLUvCdqRw1QAn+R3wU/UmrelSrX3X0wlnBR?=
 =?us-ascii?Q?6W3W/WaTDLDwBogBo68gwUTOINa09Got2IG7rtDoYNESxERGUZR14nzTFAUM?=
 =?us-ascii?Q?nnfU4CprUm7FU6sN7yI7WepopED2Ki0FbYPONSkE8V+8+FT/3eZ29o/wRBjg?=
 =?us-ascii?Q?CTugbXKGFynASh2cNiGJ843mBWYOXhZ6eEr5ov/uzsb304B1dopw74gKJ3Nt?=
 =?us-ascii?Q?EIcE71IedMaZw/+38gkWULVPx/xd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2XINZTVV5hRITRWKqOtPjaO2X2HCcWc20aO3IRyvZBSxlWd2TG3FlfXcNBbZ?=
 =?us-ascii?Q?Bzh6RCjB1u1hY7HHwdvOqutpS93xjf39o2hDJ+mvUdxEAniTTObO+hfNo4ID?=
 =?us-ascii?Q?LLrDRutW27ICm55q1/fEglVUWco+QmyLpNq+VSekfXlGQzb90QzkXUpcyDQO?=
 =?us-ascii?Q?6l6OkvOV8T/fk5pQiIWO9uCSVT569zffxqFMF0ltatfaJirVpVD9OtiIhc9A?=
 =?us-ascii?Q?CfyA2biaM50QRRHIBQ+dCCig9Em5rNDpCP6sWyvp/daW/tjK0QuuD05CRGYE?=
 =?us-ascii?Q?jGqvpqEqL9rF3MTckz80aTQlZQtYYZ7mzS4dxANFCUh/JfvQpe1uSww3OJhd?=
 =?us-ascii?Q?SpyeFYRn3hhEtD1q0UztLZl7vZPpumhrTnwgrvB9MnCkNYDoowhfLMfCMGFp?=
 =?us-ascii?Q?qz8jYleeAoZFQkWjAksqmYY23RchMtaLU35FjVitAXiQozh8dKcow13xAS2h?=
 =?us-ascii?Q?+zsrz5+5fEgRrTD9RtPP1qI9jAL3lbp+Rf/ksgXvQQD5uhPFPA+9VRs4QIgz?=
 =?us-ascii?Q?NCNkOZm8+qMc5gh2/zduE9C5aToH/lfUuLSD3dGbLi5gPyd4o869J9AHJ3B3?=
 =?us-ascii?Q?bnrUmKFHkiGLEf+m3vAWGtdJ1Zjje9/Gwmwddz/6jhyeyv718CMFxtmZ35VM?=
 =?us-ascii?Q?tpRb2Xzrryn2Qqlzu4PiLEJ7pBb3Ymm62+quIQ4VvlfPvfh2hpqKCs+nakBm?=
 =?us-ascii?Q?28wk+U4RdarcWxdAxPKoAoqMLl1dPDhrM/3M7ZIdMRC4hacwLeHYK/qXOSL5?=
 =?us-ascii?Q?9B1kEgg/HzlvNKKb7Mv3iv/we+6+dmB9og6d3GxJF0jap8+nT9yMDUcV3oHN?=
 =?us-ascii?Q?o3M3CkAQpDBvOY/kWPthyToVNXnfYILDqwvpiESSAAHKHmnmHKePKaryFzlF?=
 =?us-ascii?Q?HnuRqCeCElPc9iOvxM3Wc/7bpoc+/PQUxbvZ6aYIRmjDS23bj0WK2niDNiFy?=
 =?us-ascii?Q?3i0FjxkLfMgozBaKtZtzCCGvnzVTFJZcDK7+fDsDOefdgsxzHiyY+yvtcOI+?=
 =?us-ascii?Q?2WaU3+U4ybN4FfNC3BmO8Bfhzv3AbvuLUJUOXgtAAV8Ymo1RiQlgXYEhHEVo?=
 =?us-ascii?Q?fIBWvIIxhENpEliQLv/CYOyACZQDi1OWWs6CWTteArxv00/9zyqywFLNpM6+?=
 =?us-ascii?Q?QrwuyGmUO8YvemRQbjWuMhaP/Qp6zD+1/4ubnQ9+Ww6cQWT/U2DP4jea8VFC?=
 =?us-ascii?Q?JhzzH4GzHwqVgU6eIXf0h+aIrQVM7SZQNybtdUnTA8fkCyfJirG1eUHm04/w?=
 =?us-ascii?Q?MxUlMjdw7QDl+ZaNAuuRaE/GP8fbhwp1LjtTGM376fycdgoSbStisUw0U0cT?=
 =?us-ascii?Q?MGhLNm+FDxHl8XrWC5jZ+7hBRGa8TtohOauAYHRSoZZ+dARpU5DJy0SWRdgA?=
 =?us-ascii?Q?Kim/FI7m0x76X+C05RdycLrimIpOqDsFxEMF92rZvCED70X+5y0aLSEmub4A?=
 =?us-ascii?Q?2MWI85WLye6EwZBlQgJpxLQt2EQrsPVYUvbm3DkJbgBytA6HMs5aBVepRsjB?=
 =?us-ascii?Q?TnnrFQqsLRw6CQEApdh19KXc7eriTI/dTNMnUSVYxUChAykyf2YWRKMys2MP?=
 =?us-ascii?Q?I90LxuHHj6I47vHyUG3MLxRqsKOBbSdVJ/+JAECV7dE4oYOnaJBJEpdW6K2m?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ff4785-42ce-4c8b-3844-08ddad5dedbc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 05:15:08.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvT7ONrC2zyxlzT/b56zrzAoOCL6IliBlWejigo9bQz8z7/DgfizDugE5+ZQTPGqz2Z6vVkRYz++mUyuwjF8Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7284
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/pid.c:#put_pid" on:

commit: 56e50aa99df4ccdc736362bac4e62e2dfc55f58a ("pidfs: keep pidfs dentry stashed once created")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.pidfs

in testcase: boot

config: x86_64-randconfig-161-20250617
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+------------+
|                                                                                                                                                        | v6.16-rc1 | 56e50aa99d |
+--------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+------------+
| WARNING:at_kernel/pid.c:#put_pid                                                                                                                       | 0         | 18         |
| RIP:put_pid                                                                                                                                            | 0         | 18         |
| RIP:pv_native_safe_halt                                                                                                                                | 0         | 16         |
| WARNING:possible_circular_locking_dependency_detected                                                                                                  | 0         | 18         |
| WARNING:possible_circular_locking_dependency_detected_systemd_is_trying_to_acquire_lock:at:pidfs_dentry_prune_but_task_is_already_holding_lock:at:dput | 0         | 12         |
| WARNING:possible_circular_locking_dependency_detected_S04udev_is_trying_to_acquire_lock:at:pidfs_dentry_prune_but_task_is_already_holding_lock:at:dput | 0         | 6          |
+--------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506171228.578f7de6-lkp@intel.com


[    8.810471][    C0] ------------[ cut here ]------------
[ 8.813523][ C0] WARNING: CPU: 0 PID: 1 at kernel/pid.c:103 put_pid (kernel/pid.c:103 (discriminator 12)) 
[    8.816825][    C0] Modules linked in:
[    8.820235][    C0] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc1-00001-g56e50aa99df4 #1 NONE  47b83492c05af33e69456fb6bcdb41d4f4e07a6e
[    8.823518][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 8.826880][ C0] RIP: 0010:put_pid (kernel/pid.c:103 (discriminator 12)) 
[ 8.830249][ C0] Code: ae b6 4c 00 eb 0e e8 27 15 22 00 eb 07 7c 1f e8 1e 15 22 00 5b 41 5c 41 5e 41 5f 5d 31 c0 31 c9 31 ff 31 f6 c3 e8 08 15 22 00 <0f> 0b eb b1 e8 ff 14 22 00 48 89 df be 03 00 00 00 e8 32 17 a6 00
All code
========
   0:	ae                   	scas   %es:(%rdi),%al
   1:	b6 4c                	mov    $0x4c,%dh
   3:	00 eb                	add    %ch,%bl
   5:	0e                   	(bad)
   6:	e8 27 15 22 00       	call   0x221532
   b:	eb 07                	jmp    0x14
   d:	7c 1f                	jl     0x2e
   f:	e8 1e 15 22 00       	call   0x221532
  14:	5b                   	pop    %rbx
  15:	41 5c                	pop    %r12
  17:	41 5e                	pop    %r14
  19:	41 5f                	pop    %r15
  1b:	5d                   	pop    %rbp
  1c:	31 c0                	xor    %eax,%eax
  1e:	31 c9                	xor    %ecx,%ecx
  20:	31 ff                	xor    %edi,%edi
  22:	31 f6                	xor    %esi,%esi
  24:	c3                   	ret
  25:	e8 08 15 22 00       	call   0x221532
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb b1                	jmp    0xffffffffffffffdf
  2e:	e8 ff 14 22 00       	call   0x221532
  33:	48 89 df             	mov    %rbx,%rdi
  36:	be 03 00 00 00       	mov    $0x3,%esi
  3b:	e8 32 17 a6 00       	call   0xa61772

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb b1                	jmp    0xffffffffffffffb5
   4:	e8 ff 14 22 00       	call   0x221508
   9:	48 89 df             	mov    %rbx,%rdi
   c:	be 03 00 00 00       	mov    $0x3,%esi
  11:	e8 32 17 a6 00       	call   0xa61748
[    8.833608][    C0] RSP: 0000:ffffc90000007d30 EFLAGS: 00010246
[    8.836857][    C0] RAX: 0000000000000000 RBX: ffff88810097b680 RCX: 0000000000000000
[    8.840191][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    8.843543][    C0] RBP: ffffc90000007d50 R08: 0000000000000000 R09: 0000000000000000
[    8.846866][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
[    8.850184][    C0] R13: ffffffff815def00 R14: ffffffff85109e00 R15: ffff88810097b6d0
[    8.853572][    C0] FS:  0000000000000000(0000) GS:ffff888428b69000(0000) knlGS:0000000000000000
[    8.856838][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.860167][    C0] CR2: ffff88843ffff000 CR3: 0000000005075000 CR4: 00000000000406b0
[    8.863517][    C0] Call Trace:
[    8.864777][    C0]  <IRQ>
[ 8.865686][ C0] ? rcu_do_batch (kernel/rcu/tree.c:?) 
[ 8.866882][ C0] delayed_put_pid (kernel/pid.c:114) 
[ 8.870176][ C0] rcu_do_batch (include/linux/rcupdate.h:341 (discriminator 1) kernel/rcu/tree.c:2578 (discriminator 1)) 
[ 8.873601][ C0] rcu_core (kernel/rcu/tree.c:2834) 
[ 8.876884][ C0] rcu_core_si (kernel/rcu/tree.c:2850) 
[ 8.880198][ C0] handle_softirqs (arch/x86/include/asm/jump_label.h:36 include/trace/events/irq.h:142 kernel/softirq.c:580) 
[ 8.883559][ C0] __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:682) 
[ 8.886442][ C0] irq_exit_rcu (kernel/softirq.c:698 (discriminator 5)) 
[ 8.886885][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 (discriminator 24)) 
[    8.890222][    C0]  </IRQ>
[    8.893537][    C0]  <TASK>
[ 8.896593][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 8.896859][ C0] RIP: 0010:__pageblock_pfn_to_page (include/linux/mm.h:1512 include/linux/mm.h:1733 mm/page_alloc.c:1516) 
[ 8.900183][ C0] Code: 3c 20 00 74 0c 48 c7 c7 20 23 e6 84 e8 9a ca 06 00 48 c1 e3 06 48 03 1d 6f fa 3c 03 74 61 48 89 d8 48 c1 e8 03 42 80 3c 20 00 <74> 08 48 89 df e8 77 ca 06 00 4c 8b 2b 4c 89 e8 48 c1 e8 36 4c 8d
All code
========
   0:	3c 20                	cmp    $0x20,%al
   2:	00 74 0c 48          	add    %dh,0x48(%rsp,%rcx,1)
   6:	c7 c7 20 23 e6 84    	mov    $0x84e62320,%edi
   c:	e8 9a ca 06 00       	call   0x6caab
  11:	48 c1 e3 06          	shl    $0x6,%rbx
  15:	48 03 1d 6f fa 3c 03 	add    0x33cfa6f(%rip),%rbx        # 0x33cfa8b
  1c:	74 61                	je     0x7f
  1e:	48 89 d8             	mov    %rbx,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  2a:*	74 08                	je     0x34		<-- trapping instruction
  2c:	48 89 df             	mov    %rbx,%rdi
  2f:	e8 77 ca 06 00       	call   0x6caab
  34:	4c 8b 2b             	mov    (%rbx),%r13
  37:	4c 89 e8             	mov    %r13,%rax
  3a:	48 c1 e8 36          	shr    $0x36,%rax
  3e:	4c                   	rex.WR
  3f:	8d                   	.byte 0x8d

Code starting with the faulting instruction
===========================================
   0:	74 08                	je     0xa
   2:	48 89 df             	mov    %rbx,%rdi
   5:	e8 77 ca 06 00       	call   0x6ca81
   a:	4c 8b 2b             	mov    (%rbx),%r13
   d:	4c 89 e8             	mov    %r13,%rax
  10:	48 c1 e8 36          	shr    $0x36,%rax
  14:	4c                   	rex.WR
  15:	8d                   	.byte 0x8d
[    8.903639][    C0] RSP: 0000:ffffc9000001fe20 EFLAGS: 00000246
[    8.906853][    C0] RAX: 1ffffd4001f4c000 RBX: ffffea000fa60000 RCX: 0000000000000000
[    8.910185][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    8.913478][    C0] RBP: ffffc9000001fe48 R08: 0000000000000000 R09: 0000000000000000
[    8.916227][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
[    8.916886][    C0] R13: 0000000000440000 R14: 00000000003e99ff R15: ffff88843ffd32c0
[ 8.920289][ C0] set_zone_contiguous (mm/mm_init.c:2340) 
[ 8.923614][ C0] page_alloc_init_late (mm/mm_init.c:?) 
[ 8.926911][ C0] kernel_init_freeable (init/main.c:1583) 
[ 8.930180][ C0] ? rest_init (init/main.c:1465) 
[ 8.933549][ C0] kernel_init (init/main.c:1475) 
[ 8.936647][ C0] ? rest_init (init/main.c:1465) 
[ 8.936860][ C0] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 8.940091][ C0] ? rest_init (init/main.c:1465) 
[ 8.943087][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[    8.943574][    C0]  </TASK>
[    8.946853][    C0] irq event stamp: 3236
[ 8.950200][ C0] hardirqs last enabled at (3246): __console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:344 kernel/printk/printk.c:2885) 
[ 8.953563][ C0] hardirqs last disabled at (3255): __console_unlock (kernel/printk/printk.c:342 (discriminator 9)) 
[ 8.956893][ C0] softirqs last enabled at (2734): handle_softirqs (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:426 kernel/softirq.c:607) 
[ 8.960161][ C0] softirqs last disabled at (2737): __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:682) 
[    8.963143][    C0] ---[ end trace 0000000000000000 ]---

...


[   64.023435][    T1] 
[   64.023863][    T1] ======================================================
[   64.024924][    T1] WARNING: possible circular locking dependency detected
[   64.025966][    T1] 6.16.0-rc1-00001-g56e50aa99df4 #1 Tainted: G        W          
[   64.027155][    T1] ------------------------------------------------------
[   64.028213][    T1] systemd/1 is trying to acquire lock:
[   64.029076][    T1] ffff888130098fb8 (&pid->wait_pidfd){....}-{3:3}, at: pidfs_dentry_prune+0x9d/0x100
[   64.030543][    T1] 
[   64.030543][    T1] but task is already holding lock:
[   64.031674][    T1] ffff88812e7fe880 (&lockref->lock){+.+.}-{3:3}, at: dput+0x212/0x600
[   64.032976][    T1] 
[   64.032976][    T1] which lock already depends on the new lock.
[   64.032976][    T1] 
[   64.034554][    T1] 
[   64.034554][    T1] the existing dependency chain (in reverse order) is:
[   64.035902][    T1] 
[   64.035902][    T1] -> #1 (&lockref->lock){+.+.}-{3:3}:
[   64.037079][    T1]        _raw_spin_lock+0x39/0x80
[   64.037857][    T1]        lockref_get+0x15/0x80
[   64.038597][    T1]        pidfs_stash_dentry+0xa8/0x140
[   64.039437][    T1]        path_from_stashed+0x445/0x800
[   64.040277][    T1]        pidfs_register_pid+0x92/0x140
[   64.041088][    T1]        unix_socketpair+0xd8/0x600
[   64.041863][    T1]        __sys_socketpair+0x23b/0x380
[   64.042681][    T1]        __x64_sys_socketpair+0xa0/0xc0
[   64.043521][    T1]        x64_sys_call+0xc56/0xe40
[   64.044286][    T1]        do_syscall_64+0x76/0x280
[   64.045060][    T1]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   64.046011][    T1] 
[   64.046011][    T1] -> #0 (&pid->wait_pidfd){....}-{3:3}:
[   64.047203][    T1]        __lock_acquire+0x1580/0x2d00
[   64.048036][    T1]        lock_acquire+0xf4/0x280
[   64.048812][    T1]        _raw_spin_lock_irq+0x64/0xc0
[   64.049627][    T1]        pidfs_dentry_prune+0x9d/0x100
[   64.050472][    T1]        __dentry_kill+0x9b/0x540
[   64.051272][    T1]        dput+0x3bf/0x600
[   64.051946][    T1]        pidfs_put_pid+0x58/0x80
[   64.052730][    T1]        unix_sock_destructor+0x95/0x200
[   64.053613][    T1]        __sk_destruct+0x58/0x640
[   64.054398][    T1]        sk_destruct+0x9a/0x100
[   64.055150][    T1]        __sk_free+0x1bf/0x2c0
[   64.055891][    T1]        sk_free+0x47/0x80
[   64.056799][    T1]        unix_release_sock+0x5ec/0x800
[   64.057635][    T1]        unix_release+0x91/0xc0
[   64.058372][    T1]        __sock_release+0xca/0x280
[   64.059171][    T1]        sock_close+0x21/0x40
[   64.059897][    T1]        __fput+0x355/0x8c0
[   64.060593][    T1]        fput_close_sync+0xa4/0x140
[   64.061374][    T1]        __se_sys_close+0x67/0x100
[   64.062173][    T1]        __x64_sys_close+0x3d/0x80
[   64.062951][    T1]        x64_sys_call+0x66/0xe40
[   64.063711][    T1]        do_syscall_64+0x76/0x280
[   64.064506][    T1]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   64.065471][    T1] 
[   64.065471][    T1] other info that might help us debug this:
[   64.065471][    T1] 
[   64.066954][    T1]  Possible unsafe locking scenario:
[   64.066954][    T1] 
[   64.068079][    T1]        CPU0                    CPU1
[   64.068899][    T1]        ----                    ----
[   64.069714][    T1]   lock(&lockref->lock);
[   64.070401][    T1]                                lock(&pid->wait_pidfd);
[   64.071479][    T1]                                lock(&lockref->lock);
[   64.072521][    T1]   lock(&pid->wait_pidfd);
[   64.072891][    T1] 
[   64.072891][    T1]  *** DEADLOCK ***
[   64.072891][    T1] 
[   64.073520][    T1] 3 locks held by systemd/1:
[   64.073888][    T1]  #0: ffff88812e7b2018 (&sb->s_type->i_mutex_key#9){+.+.}-{4:4}, at: __sock_release+0x9c/0x280
[   64.074728][    T1]  #1: ffff88812e7fe880 (&lockref->lock){+.+.}-{3:3}, at: dput+0x212/0x600
[   64.075416][    T1]  #2: ffff888100418bb0 (&sb->s_type->i_lock_key#4){+.+.}-{3:3}, at: lock_for_kill+0x83/0x200
[   64.076230][    T1] 
[   64.076230][    T1] stack backtrace:
[   64.076721][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Tainted: G        W           6.16.0-rc1-00001-g56e50aa99df4 #1 NONE  47b83492c05af33e69456fb6bcdb41d4f4e07a6e
[   64.076734][    T1] Tainted: [W]=WARN
[   64.076737][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   64.076743][    T1] Call Trace:
[   64.076748][    T1]  <TASK>
[   64.076753][    T1]  __dump_stack+0x21/0x40
[   64.076761][    T1]  dump_stack_lvl+0xcd/0x180
[   64.076768][    T1]  dump_stack+0x15/0x40
[   64.076773][    T1]  print_circular_bug+0x300/0x340
[   64.076786][    T1]  check_noncircular+0x121/0x140
[   64.076797][    T1]  __lock_acquire+0x1580/0x2d00
[   64.076812][    T1]  lock_acquire+0xf4/0x280
[   64.076821][    T1]  ? pidfs_dentry_prune+0x9d/0x100
[   64.076833][    T1]  ? trace_irq_disable+0x65/0x1c0
[   64.076839][    T1]  ? _raw_spin_lock_irq+0x3c/0xc0
[   64.076849][    T1]  ? pidfs_dentry_prune+0x9d/0x100
[   64.076858][    T1]  _raw_spin_lock_irq+0x64/0xc0
[   64.076865][    T1]  ? pidfs_dentry_prune+0x9d/0x100
[   64.076875][    T1]  pidfs_dentry_prune+0x9d/0x100
[   64.076884][    T1]  __dentry_kill+0x9b/0x540
[   64.076893][    T1]  dput+0x3bf/0x600
[   64.076901][    T1]  ? dput+0x42/0x600
[   64.076909][    T1]  pidfs_put_pid+0x58/0x80
[   64.076918][    T1]  unix_sock_destructor+0x95/0x200
[   64.076926][    T1]  ? unix_write_space+0x400/0x400
[   64.076933][    T1]  __sk_destruct+0x58/0x640
[   64.076944][    T1]  sk_destruct+0x9a/0x100
[   64.076952][    T1]  __sk_free+0x1bf/0x2c0
[   64.076961][    T1]  sk_free+0x47/0x80
[   64.076970][    T1]  unix_release_sock+0x5ec/0x800
[   64.076978][    T1]  unix_release+0x91/0xc0
[   64.076985][    T1]  __sock_release+0xca/0x280
[   64.076994][    T1]  ? sock_mmap+0xc0/0xc0
[   64.077001][    T1]  sock_close+0x21/0x40
[   64.077009][    T1]  __fput+0x355/0x8c0
[   64.077020][    T1]  fput_close_sync+0xa4/0x140
[   64.077029][    T1]  __se_sys_close+0x67/0x100
[   64.077035][    T1]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   64.077042][    T1]  __x64_sys_close+0x3d/0x80
[   64.077048][    T1]  x64_sys_call+0x66/0xe40
[   64.077054][    T1]  do_syscall_64+0x76/0x280
[   64.077061][    T1]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   64.077068][    T1] RIP: 0033:0x7f8f004aa8e0
[   64.077075][    T1] Code: 0d 00 00 00 eb b2 e8 ff f7 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d 01 1d 0e 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
[   64.077081][    T1] RSP: 002b:00007ffdcfd48558 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[   64.077088][    T1] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8f004aa8e0
[   64.077093][    T1] RDX: 0000563b305c8bfa RSI: 0000000000000003 RDI: 0000000000000003
[   64.077097][    T1] RBP: 00007f8eff9447f0 R08: 0000000000000007 R09: 0000563e53b9a710
[   64.077102][    T1] R10: f07149c8a2714e9d R11: 0000000000000202 R12: 0000000000000002
[   64.077106][    T1] R13: 00007ffdcfd485d8 R14: 0000563e53a8e870 R15: 0000000000000000
[   64.077114][    T1]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250617/202506171228.578f7de6-lkp@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


