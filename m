Return-Path: <linux-fsdevel+bounces-38288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169D9FED03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 06:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37097A1614
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 05:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB8618873E;
	Tue, 31 Dec 2024 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbGcm2AA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6B18595F;
	Tue, 31 Dec 2024 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735624171; cv=fail; b=BS6D9p4QOK1/5lVVrmKyhsqeaWA3jvDL+7Hl4QNEIvbb28bxofdfETKwbekcUusLDtYHWNxNCED+YUDBj6loEo6OLiL2pr3VaO+gJUrPxQU+2Z56eOZyAykl4fvzoJn1yD1Ks0JHG0qFGGgcH9abuOPMRqqVSioZUVm5eMu3WEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735624171; c=relaxed/simple;
	bh=s9uURSIZKkEGIwkIakqW6tuQvyxUhubDkPeJiqZCYCM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lcglj8sBRBOiJeLTsd1nrXaMcVmyUgP/hqIs5V9t28aD2Rriayj0wE7Oi5BL8M3f85xKRSo7evHs31Z5gw/3Z5Y1qHXubWht5FJ7+Yz301qJf2idj1c5YaED1xywsE6LEUohCkvp1c5+RXNEAEF430Qt2Z4qb70ZoaqHHWgamM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbGcm2AA; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735624168; x=1767160168;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=s9uURSIZKkEGIwkIakqW6tuQvyxUhubDkPeJiqZCYCM=;
  b=hbGcm2AAEt5n/lVPvEs1ArBGc8ccfFfYR+x0XTakn8b68XRyUbc9+t/t
   Ps0J62aMLQm/BNQqz3a7I69x80iKBnvwLv7wiRGL+uNNqkrlgrtFTu/R9
   2H+sXzyv5dp64DEebCKk0vAlzwBbAtV4gyj+PHUOAyiWgOfL9LubTDCc4
   QA7EcoLEiph4tD+GEyLHn/ZJq0N7XZsgT96aQAmkZUvIjcpib3iry+/Dk
   VqFEwtZSC/OAvefz8dCQ3A9SUhMK9Ra2wZV4dchQvcjcQjiYNtY55EoUd
   Ao1zDjb8eJ/Z+xBkKnNEzc5IoXLQfBJma719fWw/nA68nZF5Ym5ZgEBDS
   w==;
X-CSE-ConnectionGUID: jC3yrzdGS5+r/a9w0nhepg==
X-CSE-MsgGUID: EdWsTsKlTeelKPYTgMlDIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="35788929"
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="35788929"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 21:49:28 -0800
X-CSE-ConnectionGUID: KWM7aOwET1iBEzzh1mujNg==
X-CSE-MsgGUID: lbihu/MFQcejabexuQu4bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="105945070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Dec 2024 21:49:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 30 Dec 2024 21:49:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 30 Dec 2024 21:49:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 30 Dec 2024 21:49:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noSlPW/v1nA9WLOOXMyFvbWQREf1JQp21JkM8F19h3r6oPc8nWM3B3qVYaKjHW9hLhMF1MlPw6k/dg+iMFspILqpVGkVbAZSgBA23ryGXj8qd4ywp6VyU37PYPsVm9KxJUVkU89wzyOteOE5gyJABAWbcD6dncrwVbPaB0bTG2LffCMepzryn3uXUKS9JMOZDhIEZ6jVnfjNojG7wi0Ukws/Xqhfh/LdMePKtxVgWVo6jATFKq6iA+rSbyq6oB0CnWAO3guLTCssNRpcAEBmAxWNfjHY6prqGGBAuIBuosUUnbIz8MkHK3bAyyL7ngLavnlb4eCI2AI8Z4eftApO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA3c7ShcIqCM8G5tfvFvkIcVGS85K98kAwHeOnrlABo=;
 b=HMQ/ax1TVBcbBshx3MGYqQOzLPEwREULhjDznW9HPI1S5nAaqJ7t/6yFqBQMoF1Bd8ohDfL0nT2SgmJxSSRSn7Z8Utf2BvODTqSB/RJdSrBexFnRZxNmHmWVix8kBPPmPMIJKpdLKnyKqQ2SfHtS+QP2Ww5/FI1SjOZkuLPYQPzxmsFwipVwgIbSWyadLDyRaIjBzG9hgfMCHWAXvn/LjQYHcOjbIaCYqmMgwlPkYR7FN9+RsdPu0xsjeU2rOM2cUan4f7s/cndz/t+tl23mljcSNqpVVYNli5QUR4OilIodrBP9ZcaHPN/gOqLCNqUnZmXm+SCma0k8dx84AiA+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB8287.namprd11.prod.outlook.com (2603:10b6:510:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 05:49:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 05:49:15 +0000
Date: Tue, 31 Dec 2024 13:49:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	<v9fs@lists.linux.dev>, <linux-afs@lists.infradead.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [netfs]  b4f239c91f:
 WARNING:at_kernel/sched/core.c:#__might_sleep
Message-ID: <202412311337.146bcde4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3fed90-096a-44df-7b19-08dd295edc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HVm4M7xgIC7U0o/8/qPFO+IUpl/KijT4UpX/9SApl/0BEvtmFPR4deuIZpQp?=
 =?us-ascii?Q?bx7EK8kfbPBb6rmoYUX3vsU/exYSAgsDHylFbjHJGbbQRyS5R7hSF+ws4Ngl?=
 =?us-ascii?Q?F5XIYSiXvR6cY6IqD/C7/Jgrvar95Q5B8Zy0FYffp5cUKCwNUqxxJfUikBg1?=
 =?us-ascii?Q?XoogRcJtL3eFwSE93upxq7Y5wOQiJ4eYiTF4Hqiru48LU/KyAsGWKVWxrDaG?=
 =?us-ascii?Q?5xjspFsWmeG3u5PCg7YtQ8Hjw9MeFlv3NBZx6PSPCG1ypmZjEtsY06x+LtuD?=
 =?us-ascii?Q?VLUDR4EE5EB3uKO6qO9lA8NEKA90VxbVHAY1hx75mMMHdoupybn3HNd2aQrq?=
 =?us-ascii?Q?5/nRBhPftUf29eP+3EFfmTRq71oBkAMi+75s8bxyaT48fWzgn5HfPvpBIdqZ?=
 =?us-ascii?Q?EqhESdLz2WfdiWFPPrjKW8PoV4dISpLKE4o5W9TgIDKoD5c+GF6Qf7J+JD2s?=
 =?us-ascii?Q?+UMldBdfVFVnEeVe3saVWAdv4wQHC62TENhVjboDrk4ifv4Giv7S8nmNoZrC?=
 =?us-ascii?Q?oM86dsUYAnKw3cMpxQ3gUxw063Ra7o0/Sg391KydK0UGmifrGd5SjR4w5KsN?=
 =?us-ascii?Q?xTXVY55I+xoVOdgeAX90s+cSAZ7YnSHwWmgKngrDMvGnMw9ICSVIobi5zvYy?=
 =?us-ascii?Q?8aV2Noh7WPEW9hqJZH+ej5SAD2Rz/Z2SV288HLOodcs/W5q6SJVPXSyLd3sP?=
 =?us-ascii?Q?cFlL5obAiRSGHprwA56DhCGsE55WALzgI4+LUz9IovXkNoKNtyUCcaioUKJt?=
 =?us-ascii?Q?vAjEXsPOSWaZAe97Qkeo4I7hzdedCZyOg6/xW5oTL4+c11OqhF/UfqXKrhe3?=
 =?us-ascii?Q?nWBFBkm+JSEuQluhu7yoY02BXLVyiCDDGbntSHrmyCtrdnQYwFYz3eF9E/Cj?=
 =?us-ascii?Q?ueUeqr51qV3QtENx7NG5o2oGiAPL9C9qvxczfYprubA9xT3JmaRvRNI17rlF?=
 =?us-ascii?Q?VfqQdCfKg+q5hTX03quJC2wzZo8iNALkSdR0Y7uI+KvvtK1sxgTyg5Az9KfX?=
 =?us-ascii?Q?lvqE+uBZqNU2cKrpCLrnZcRrWX/NazuD40tp31vxcpF5Y425ke8A1DAhbD/E?=
 =?us-ascii?Q?GQHrca3NWlivmwZTZ9tdInCUJTNecjHnnOA9beEUf3IR2Ny2FRd46HI3aniq?=
 =?us-ascii?Q?Uh9jDERe/B62uCn+NwEJr/q+gc2gndhd+2ybHyan7SIvmegjK5jdoClitT9+?=
 =?us-ascii?Q?pEy+5Q1DIAd9Nov+PLMdaIcYSp1MHmX9rIpABHYKxRRECaUuuRY5xiF0D3hK?=
 =?us-ascii?Q?6ZAWtUEDW2afsmBCVZV5TTznVnslDfTsvQ2CRsV/K++Rttl1k3xthkypu3C2?=
 =?us-ascii?Q?4a6BzsUPe5iIU3JCGpLGQJ444AIZdRDZQ+osKQVti4NLOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PThvGY8fzy39C8Mu/SUCa3K3/aE/x6bkWzMTYmGNd8ZKYW1ERoBe0vOpcTIr?=
 =?us-ascii?Q?5D8JjhJzL8yiUntdmXw7vX16PQIjCufZwVTJLLzsgXCs+Pl4+KGpSA8XAfj2?=
 =?us-ascii?Q?/PGHZUHzdamDkSFflh8dWd19bqZVYpqL0xjDswaYS2hkA6tTQuMrfwEMvKFy?=
 =?us-ascii?Q?+CKNyCFfm2XvvyyNcWmnLhDhELbhVHfx8fU50qO7lt1mLmOYxrKpKSt6cdWZ?=
 =?us-ascii?Q?QXRAPPiHnxOQrfaYJZ/DSArPos6If5n+Le8Yjz5o8Kb4qe7PYdjPnp2ZNjII?=
 =?us-ascii?Q?MJtK1Mp4X7bfv9Wa48+G5ksW/cLhfVVZ56fAmFyL3FLOwecTQyXyn9yilzzo?=
 =?us-ascii?Q?00T/fDlOY1wfy0ywIfZIbccaNZxiq9fKcSykYjJRHqL+IJm8DCvQ/EhWzlOF?=
 =?us-ascii?Q?bndMRGgsDez6F4Y7V+6WvnISG6KeSoyVArT2ATIPIBq2yIE2ru5JAT3pdwr8?=
 =?us-ascii?Q?xHMngxLd+OibqZXYe04SSSw9JxHNn/To5RGAoUYSiy3Ne+Z1wanWErmq67HX?=
 =?us-ascii?Q?nI/J0qQ0NYeANiC+kVnYwPiGoiIabz8LlniTQoPWgkuoOonAGgjjB+I0JBcS?=
 =?us-ascii?Q?fE7xqd9vQz7uiiSLii7QfA9wALV5kgZ4plzKSQbYLMisRTtALXkssk9WxwFW?=
 =?us-ascii?Q?y/rk6Xw2baPZEvRo58niGwC/q4Fe7zigcDf6IqBqiNKaoSES0qXAe3f54kMn?=
 =?us-ascii?Q?oRFjyLKtbzdmk+ZkMcClBdV6RrU8xYFdC8qjzp6SDmyhB38k7aDVxMX8d8YE?=
 =?us-ascii?Q?yzjmudy8y4R6BPswYUVd4bzt7T0k7cyTeYVpDV8mg3AlgTTZC+1LSGNYKIXU?=
 =?us-ascii?Q?fpmsyb+t69h8x4N+ljdzHU8agcIgjr+WHy+c4AgOYqB+/APmPj1LNwXVGzUD?=
 =?us-ascii?Q?SGfh16sYEhtwasOIwivxu9EoHOZ+uAPDY7Hc4cPbpnsf/W7A6lbSKckK1ttc?=
 =?us-ascii?Q?ZdHFBkZ6rUaX8Oa9jGilassB2qCMnZ7lgZPOA78LWx5hrtOVfgdPp+vd2JZA?=
 =?us-ascii?Q?oW/KK6Jzdrp/7D7YqKypwOuDweX0gHE3+esfN4LVLou1iD7sRgghhCSr2HmV?=
 =?us-ascii?Q?VP43SWU7AFn2aHKQHGQ8jJ1lZl7tJZnVuUbLknJQ5L4qEnNS1Gxv1vQ9TQAc?=
 =?us-ascii?Q?sa52uEhKvl/41qc5akT+Ybk8sXrgmHm2A6Y03AaG0sYfPvoZQmRn5J2uzH2U?=
 =?us-ascii?Q?UQ6WfJzUVFQ9K7D/OLXNuwpP7lxl5YL0dc+pG0DNFHRrvMPyeeR4Z+xmca3B?=
 =?us-ascii?Q?uTTuoGfTpCWJ6guMmE7BPHLCtXWwjQae1yMSKcKxQvZB8ii/4BXfES+shoZF?=
 =?us-ascii?Q?Ta/euQ7Mpz+fVWCVv347MD6bs0Fa+uVns4yNctrnBfO8U/9iZr5nz3PR7HZq?=
 =?us-ascii?Q?5xeg0Pv8NuQv/4d3dHBYWDDONshbqzvLAKTb7jaEHXsPmJiSZbC+ZVc4U/g2?=
 =?us-ascii?Q?uei4erJDRFM56b42YDOiyNEWwULWSN8cjd72/znwwdGrPUUnKpmw3y+EohYU?=
 =?us-ascii?Q?x3jmqai548Jm/blpIMo7j7n2uqXsMVbzEZsgr8mbKc6B0WnVyuKLjGueUt8D?=
 =?us-ascii?Q?Ab9MakYrHPOVo40YfGBLxjlAMjQlEQdfxClsCMbDkK28mrZnfGJsBM4F2MP8?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3fed90-096a-44df-7b19-08dd295edc56
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 05:49:15.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2lSIANJDhFc/E00BMlj3zsf3IOZUNEV+nxsJcfwXWa0U4oXHC6QCfKmZj7RXREg19fWKz2X/fTrNV6UAZupFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8287
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/core.c:#__might_sleep" o=
n:

commit: b4f239c91f9bf643f3e5f0977c9eff2c809eeddd ("netfs: Change the read r=
esult collector to only use one work item")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: xfstests
version: xfstests-x86_64-8467552f-1_20241215
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv3
	test: generic-465



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) w=
ith 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412311337.146bcde4-lkp@intel.co=
m


[  339.815767][ T1923] ------------[ cut here ]------------
[ 339.821125][ T1923] do not call blocking ops when !TASK_RUNNING; state=3D=
2 set at prepare_to_wait (kernel/sched/wait.c:237 (discriminator 3))
[ 339.832728][ T1923] WARNING: CPU: 1 PID: 1923 at kernel/sched/core.c:8681=
 __might_sleep (kernel/sched/core.c:8681 (discriminator 9))
[  339.841830][ T1923] Modules linked in: nls_utf8 cifs cifs_arc4 nls_ucs2_=
utils rdma_cm iw_cm ib_cm ib_core cifs_md4 dns_resolver ext4 mbcache jbd2 s=
nd_hda_codec_hdmi snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic s=
nd_hda_scodec_component btrfs blake2b_generic xor zstd_compress intel_rapl_=
msr intel_rapl_common raid6_pq libcrc32c snd_soc_avs snd_soc_hda_codec snd_=
hda_ext_core x86_pkg_temp_thermal snd_soc_core intel_powerclamp coretemp sn=
d_compress sd_mod sg kvm_intel ipmi_devintf snd_hda_intel dell_pc ipmi_msgh=
andler i915 platform_profile snd_intel_dspcfg snd_intel_sdw_acpi kvm snd_hd=
a_codec snd_hda_core snd_hwdep cec crct10dif_pclmul intel_gtt crc32_pclmul =
crc32c_intel drm_buddy ghash_clmulni_intel snd_pcm dell_wmi ttm mei_wdt rap=
l drm_display_helper rfkill ahci snd_timer dell_smbios intel_cstate wmi_bmo=
f sparse_keymap dell_wmi_descriptor dcdbas intel_uncore drm_kms_helper liba=
hci pcspkr snd i2c_i801 mei_me soundcore libata i2c_smbus intel_pch_thermal=
 mei intel_pmc_core intel_vsec video pmt_telemetry pmt_class acpi_pad
[  339.842057][ T1923]  wmi binfmt_misc loop fuse drm dm_mod ip_tables
[  339.939708][ T1923] CPU: 1 UID: 0 PID: 1923 Comm: aio-dio-append- Not ta=
inted 6.13.0-rc1-00025-gb4f239c91f9b #1
[  339.949872][ T1923] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS =
1.8.1 12/05/2017
[ 339.958025][ T1923] RIP: 0010:__might_sleep (kernel/sched/core.c:8681 (di=
scriminator 9))
[ 339.963323][ T1923] Code: 00 d4 7e 49 8d bd 60 14 00 00 48 89 fa 48 c1 ea=
 03 80 3c 02 00 75 34 49 8b 95 60 14 00 00 48 c7 c7 e0 c3 0c 84 e8 09 7b f4=
 ff <0f> 0b e9 75 ff ff ff e8 2d f2 88 00 e9 26 ff ff ff 89 75 e0 e8 40
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	00 d4                	add    %dl,%ah
   2:	7e 49                	jle    0x4d
   4:	8d bd 60 14 00 00    	lea    0x1460(%rbp),%edi
   a:	48 89 fa             	mov    %rdi,%rdx
   d:	48 c1 ea 03          	shr    $0x3,%rdx
  11:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  15:	75 34                	jne    0x4b
  17:	49 8b 95 60 14 00 00 	mov    0x1460(%r13),%rdx
  1e:	48 c7 c7 e0 c3 0c 84 	mov    $0xffffffff840cc3e0,%rdi
  25:	e8 09 7b f4 ff       	call   0xfffffffffff47b33
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 75 ff ff ff       	jmp    0xffffffffffffffa6
  31:	e8 2d f2 88 00       	call   0x88f263
  36:	e9 26 ff ff ff       	jmp    0xffffffffffffff61
  3b:	89 75 e0             	mov    %esi,-0x20(%rbp)
  3e:	e8                   	.byte 0xe8
  3f:	40                   	rex

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 75 ff ff ff       	jmp    0xffffffffffffff7c
   7:	e8 2d f2 88 00       	call   0x88f239
   c:	e9 26 ff ff ff       	jmp    0xffffffffffffff37
  11:	89 75 e0             	mov    %esi,-0x20(%rbp)
  14:	e8                   	.byte 0xe8
  15:	40                   	rex
[  339.982956][ T1923] RSP: 0018:ffffc90002d3f798 EFLAGS: 00010282
[  339.988937][ T1923] RAX: 0000000000000000 RBX: ffffffff84253280 RCX: fff=
fffff823b6e6a
[  339.996823][ T1923] RDX: 1ffff110f1016b08 RSI: 0000000000000008 RDI: fff=
f8887880b5840
[  340.004710][ T1923] RBP: ffffc90002d3f7c0 R08: 0000000000000001 R09: fff=
ff520005a7ea9
[  340.012599][ T1923] R10: ffffc90002d3f54f R11: 0000000000000001 R12: 000=
000000000004a
[  340.020486][ T1923] R13: ffff888802980000 R14: ffff8881bb73d200 R15: fff=
f888803320780
[  340.028386][ T1923] FS:  00007fcb283696c0(0000) GS:ffff888788080000(0000=
) knlGS:0000000000000000
[  340.037235][ T1923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  340.040226][  T284] 512+0 records in
[  340.043725][ T1923] CR2: 000055b5dc091000 CR3: 0000000199d80002 CR4: 000=
00000003726f0
[  340.043728][ T1923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[  340.043756][  T284]
[  340.047339][ T1923] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[  340.047341][ T1923] Call Trace:
[  340.076359][ T1923]  <TASK>
[ 340.079196][ T1923] ? __warn (kernel/panic.c:748)
[ 340.083179][ T1923] ? __might_sleep (kernel/sched/core.c:8681 (discrimina=
tor 9))
[ 340.087827][ T1923] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[ 340.092232][ T1923] ? handle_bug (arch/x86/kernel/traps.c:285)
[ 340.096456][ T1923] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discri=
minator 1))
[ 340.101033][ T1923] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h=
:621)
[ 340.105958][ T1923] ? llist_add_batch (lib/llist.c:33 (discriminator 14))
[ 340.110724][ T1923] ? __might_sleep (kernel/sched/core.c:8681 (discrimina=
tor 9))
[ 340.115371][ T1923] ? __might_sleep (kernel/sched/core.c:8681 (discrimina=
tor 9))
[ 340.120036][ T1923] netfs_retry_reads (include/linux/kernel.h:73 (discrim=
inator 3) include/linux/wait_bit.h:74 (discriminator 3) fs/netfs/read_retry=
.c:263 (discriminator 3))
[ 340.124803][ T1923] netfs_collect_read_results (fs/netfs/read_collect.c:3=
34)
[ 340.130600][ T1923] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic=
.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomi=
c/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/li=
nux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spin=
lock.c:162)
[ 340.135875][ T1923] ? __pfx_netfs_collect_read_results (fs/netfs/read_col=
lect.c:186)
[ 340.142022][ T1923] netfs_read_collection (include/linux/instrumented.h:6=
8 include/asm-generic/bitops/instrumented-non-atomic.h:141 fs/netfs/read_co=
llect.c:419)
[ 340.147122][ T1923] netfs_wait_for_read (include/linux/instrumented.h:68 =
include/asm-generic/bitops/instrumented-non-atomic.h:141 fs/netfs/read_coll=
ect.c:631)
[ 340.152138][ T1923] ? __pfx_netfs_wait_for_read (fs/netfs/read_collect.c:=
614)
[ 340.157674][ T1923] ? __pfx_autoremove_wake_function (kernel/sched/wait.c=
:383)
[ 340.163632][ T1923] ? netfs_dispatch_unbuffered_reads+0x138/0xd50
[ 340.170477][ T1923] netfs_unbuffered_read_iter_locked (fs/netfs/direct_re=
ad.c:231)
[ 340.176714][ T1923] netfs_unbuffered_read_iter (fs/netfs/direct_read.c:26=
7)
[  340.177517][  T284] 512+0 records out
[ 340.182157][ T1923] vfs_read (fs/read_write.c:484 fs/read_write.c:565)
[  340.182188][  T284]
[ 340.185861][ T1923] ? vfs_read (fs/read_write.c:484 fs/read_write.c:565)
[ 340.196303][ T1923] ? __pfx_vfs_read (fs/read_write.c:546)
[ 340.200862][ T1923] ? rseq_ip_fixup (kernel/rseq.c:257 kernel/rseq.c:291)
[ 340.205534][ T1923] ? fdget (include/linux/file.h:57 fs/file.c:1154 fs/fi=
le.c:1159)
[ 340.209505][ T1923] __x64_sys_pread64 (fs/read_write.c:756 fs/read_write.=
c:764 fs/read_write.c:761 fs/read_write.c:761)
[ 340.214348][ T1923] ? __pfx___x64_sys_pread64 (fs/read_write.c:761)
[ 340.219717][ T1923] ? __x64_sys_pread64 (fs/read_write.c:761)
[ 340.224719][ T1923] ? __pfx___x64_sys_pread64 (fs/read_write.c:761)
[ 340.230090][ T1923] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/en=
try/common.c:83)
[ 340.234490][ T1923] ? do_syscall_64 (arch/x86/entry/common.c:102)
[ 340.239062][ T1923] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:1=
07 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/at=
omic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/=
spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock=
.c:170)
[ 340.243988][ T1923] ? __handle_mm_fault (mm/memory.c:5944)
[ 340.249100][ T1923] ? __pfx___handle_mm_fault (mm/memory.c:5853)
[ 340.254462][ T1923] ? __count_memcg_events (mm/memcontrol.c:583 mm/memcon=
trol.c:857)
[ 340.259735][ T1923] ? handle_mm_fault (mm/memory.c:5986 mm/memory.c:6138)
[ 340.264575][ T1923] ? do_user_addr_fault (include/linux/rcupdate.h:882 in=
clude/linux/mm.h:741 arch/x86/mm/fault.c:1340)
[ 340.269673][ T1923] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 =
arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fau=
lt.c:1539)
[ 340.274250][ T1923] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_=
64.S:130)
[  340.280045][ T1923] RIP: 0033:0x7fcb28667387
[ 340.284360][ T1923] Code: 08 89 3c 24 48 89 4c 24 18 e8 b5 f4 f8 ff 4c 8b=
 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f=
 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 05 f5 f8 ff 48 8b
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	08 89 3c 24 48 89    	or     %cl,-0x76b7dbc4(%rcx)
   6:	4c 24 18             	rex.WR and $0x18,%al
   9:	e8 b5 f4 f8 ff       	call   0xfffffffffff8f4c3
   e:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
  13:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  18:	41 89 c0             	mov    %eax,%r8d
  1b:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  20:	8b 3c 24             	mov    (%rsp),%edi
  23:	b8 11 00 00 00       	mov    $0x11,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	77 31                	ja     0x63
  32:	44 89 c7             	mov    %r8d,%edi
  35:	48 89 04 24          	mov    %rax,(%rsp)
  39:	e8 05 f5 f8 ff       	call   0xfffffffffff8f543
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 31                	ja     0x39
   8:	44 89 c7             	mov    %r8d,%edi
   b:	48 89 04 24          	mov    %rax,(%rsp)
   f:	e8 05 f5 f8 ff       	call   0xfffffffffff8f519
  14:	48                   	rex.W
  15:	8b                   	.byte 0x8b


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241231/202412311337.146bcde4-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


