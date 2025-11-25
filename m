Return-Path: <linux-fsdevel+bounces-69734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7FC84176
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F9884E769F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257D2FF148;
	Tue, 25 Nov 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJgSARwP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E32FE05B;
	Tue, 25 Nov 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061013; cv=fail; b=ucuwLjtU9yzFcAnKvBfkAZMZPe2rQv8aersBu6DTas3zcqJblx6XgL/HZ5wsXKuORDjblOnt4EoyRWreh8GAePSQvivyhyKWPz9CKQM0S4hmFoZciksSo2SJ4ry73GQVxOV6NWbWZvm7tQrZdwsU795LVT8tcE1SnR1Jsgkln9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061013; c=relaxed/simple;
	bh=h7Rz3inlOt/ZuYyu6exlq8J3ZGN9u2GniSDwPxx9N1Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nUMg8HqpUxxWxtHzAMULXAW4Cen0r1YGY3sD333ZnI0HwYoo25KCy50ooXOs8p1DbkS9KnZ6hqJ63fTxIykMB8M0kpwpBQ88P5RvZhkEoic/dNVHpZ4PFfnyUNTbiWndir36QKr3k1lTPcnnA9Wuv2I6ApoX/U17giYX+2PqDgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJgSARwP; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764061012; x=1795597012;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=h7Rz3inlOt/ZuYyu6exlq8J3ZGN9u2GniSDwPxx9N1Q=;
  b=CJgSARwP02HH/lgv/G0WbrQqjhZwTAcOYkfg/cmx81BryqCbo/mcekhP
   a4V4Q52V4eEREVYDpbruS9g9Wnvkd4ut/bHA2+MYFbARWhlgc5jyX5M/3
   UNfsmXbsxzSrjSGT5JXQpnlJKgGImoy4SHE6tKXDYh90+zN2lCwP+XUOa
   VvdNBCISknMl8ce+vxJAXA/Wl09nEpLS24WrZsADIijuR7AtOH0lDMoMm
   WKq3IhSmaif3XIymrNhiqSGjoW/wphBE9HOtT5cG1I8BTl+cQlaIAd3fO
   YGF6gUTd4avKdgzlT4nMEGhcLbL6rWrN4nYbwaDR9fjMZM/WSUsBsjieo
   Q==;
X-CSE-ConnectionGUID: WAIrySnLTuSi+hf3OtKN/Q==
X-CSE-MsgGUID: SrG6Y7ulQNekozjBtEeRdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="66233891"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="66233891"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:56:51 -0800
X-CSE-ConnectionGUID: bnXzMxwZQri23vXJp1HfAA==
X-CSE-MsgGUID: iPqJPpe6RxWNKTacCnzSAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="196881205"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:56:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 00:56:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 00:56:50 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 00:56:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1MRb2vpHfupRrfTdeyETdH+l9XKaTeIpvD+fAqq3Vhqxxk86GGgGLsBGJ2/TWfrHGUjZYY2Jmga/D0F0QQ+Rt4bglOH9ZrNo1CRV4KPiwhdD0jYotCYCK50Gdt1esabNhcuFUfE+WtWG+3VBqjinMCU1ViYr1PvdQWsqK+izq/xwyMQAoTR97F/Kw6gqiIOSH/0ysaH9RRKZ8O7yPUEjcCnjQwXvFBWfg5J2/TqnV7u/3OCWX4GXh2E25wCcIyNuYUjNJnJAFlvDbt+sboLH5V+maK9bq7lB1PGFJRcnGbFbBaCGhpf5jkE1zr/UWC1/bbEz+7C6+MJadGPgsTkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D877lO+dIyRREWO/R03eAjU10B/NiQJgCu63rHNn2eA=;
 b=xd4hiXyEcf0HotYubfKePGl/zhstai7KN5F4jZFjfvC3nKpI25hbCgdq6sAXe59k1izsuUqB418ChfwwL1B/VPK/CLF4auwoZ/nP8zNwLGVZYcRscjEj8ajZfqGBXXAAJ4YXhekMcZ9+Gz07kXe8UBu57Pq7GHujuzTjI7FBMsEcWT7z547VjQRSBLFnguJarusll7Pnx/xRMV1fSE8Ko/ZG4TR2GfGneRAFXRt4lXkm0PmouZjLQBpenKXzxjy/ntL3t6rOJE9LhwIF7vW+MA1GdbVZMEXaxgvd0dAPbv+v/uDiEhKPHhNAGvpd683r6G+NeaNGesuxOKBgXMbgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7395.namprd11.prod.outlook.com (2603:10b6:930:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:56:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 08:56:44 +0000
Date: Tue, 25 Nov 2025 16:56:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Joel Granados <joel.granados@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [sysctl]  50b496351d: ltp.proc01.fail
Message-ID: <202511251654.9c415e9b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: KUZPR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:d10:30::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c18990-2652-4edb-6501-08de2c008f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WDsEcNRk0AMI7Gnx7/5SOKC7C0DkOWw/QqeAicIyXo1EVBcK3H8anpmjsWzn?=
 =?us-ascii?Q?XO5OprMB3mdc0yVv3Mj9PcvtfUECgYuN5VhENdNcq8PtY3Fmgz9dJEL8Dxgk?=
 =?us-ascii?Q?sQW4NfEWJAlhAjjhRU9salFjbYOFOwYsFq7SJxX+kV0Zjcegs20ElGLnDk95?=
 =?us-ascii?Q?we7PYejj7bwstXfdbuYJwpvarl4JrEuKGFYMzKXSVRPdzZSynYhA/KiTwWaF?=
 =?us-ascii?Q?78quIAgcfFxUYWyCDF8x6K6moNMMTqJRMvWLCwzZKIWDN2mirHa/TK/hQLIC?=
 =?us-ascii?Q?Ww1N5bPYE2tgQwVZ9E9JMA1q3mKW/xy1yIiCkU0+HG80KzU/4dhChwN+Gmrl?=
 =?us-ascii?Q?R/QdWh3ywjNufm+hK0xXRQYz+nyzYEW1fnCyK1sKGZStynKScbEF3Ebpv5at?=
 =?us-ascii?Q?8ucR0F/hj4ZZpnFrXQZjnVYiqPVBEIUijGHbOlV25gnrh0AXPzbDrbUen6jA?=
 =?us-ascii?Q?r7nAkAHHPYEhc4uR3jjS1nds3axT8LCqUa+UleHGOHu0sqbgNAYiYQAkyset?=
 =?us-ascii?Q?5DErrMZDQD8J23esBMyTB4C6b22RcHYB3EkIuaB9MLI9wicgdB42CkH6sq71?=
 =?us-ascii?Q?Q2GN7c2wnQJpug3NF6dgENYaj/ZZdQaVZ5rkhZIuhewnziVRcOD4i+n2U6mP?=
 =?us-ascii?Q?7YuZA5CdfDgsn4KIE8lT6t7tFD5lttquQZ+btyhTcKgcSmoVejuYBhxFJeiJ?=
 =?us-ascii?Q?dD08OgZepun4qSY8uOWtzXDqggwDTUQQ04rDZYkzWD9mxVnPxC9fT+4nIFrU?=
 =?us-ascii?Q?zEkYzp2z1lT9AKDxJeTrEALfJXeDbQ5OsXsHKnUwsi3IyTakZJJveqW4HlFs?=
 =?us-ascii?Q?KUcKyE41276dE+nCwTDzlb8OXtco23cauuX2vI0oluuZVkdkxwJBN0YKC3zX?=
 =?us-ascii?Q?1PD+rHu9stNHADGzeFSDJJsLPTu+UsldE+CsRcWnVWgNR5IGF8n4Tbvfk1LX?=
 =?us-ascii?Q?LWEus6IIZfMcAV3qhibjpe8fcaVGY0oDymzh8bgaHxRxX9Uf81z0zS2F4c0c?=
 =?us-ascii?Q?2xicZwEf1JB2zH4g0rUddrIqzeP54snwtW74V5OShLNJA6yWBeaIayNa9tb2?=
 =?us-ascii?Q?4H/aFcQBfVq6n8sP4S7vAbicwI9XW1nKLea2SbH1qyaQvPf7CXBJB4OjGKDn?=
 =?us-ascii?Q?I/B5zmWAZM4OKBJGFZaE7fiBbvRmqXsEifRWM6XxSaAcoy0WVXirxnXpHgU6?=
 =?us-ascii?Q?VBaMwao05/2v0tDTfSbF/LvaMkxXdpKX4yqFahAfo9cp3HHOHRCCq5xNxYOJ?=
 =?us-ascii?Q?UrDBHl5POi/B8kajIdjEYgGCNKDu6BxmQqcUbIZNGY2V6HsqGrW4z/9GXClm?=
 =?us-ascii?Q?ukLcGzSvK7xHk0zvnnYJrT7iISV84bqyj/Oo72LvmVbCXy43QST+OaYFPTQn?=
 =?us-ascii?Q?QK6iEYAvKc5QMc/xR+jNp3c8F0nS1adb4HCNq9toNhbnpJZSc5ldSUl3/ptA?=
 =?us-ascii?Q?Eo4p90cNNwVSDVQK+pR2QhIcs49l94p9Z2Gk3I8PXFngqH2GcEpLig=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xX+mAUUa8cvPnBxViqdlxizflb9Z6ZrJwGhl1BxWrVYaukxXQdHQ5PUbDzty?=
 =?us-ascii?Q?I+WuQTwRrYWxq9lezNVeazOozDeVipqw1QmSd3TLcqxWjxVldtUYNf8/3spp?=
 =?us-ascii?Q?Mvo9G2It7SFElSYJY3eQbrvaoHREmFR3vgbWibGGthY+zk8pps6Pu9HHbGG1?=
 =?us-ascii?Q?+s/6TuLnrJ6gHZ3KN1xwdzmmR8Md18ffcTSoi6S3pNq1Be98mprSXfI3BiC3?=
 =?us-ascii?Q?kFdE+Ofd91xswVreCy8bnZ0dDkAX723CIXyIwQYLbqva/rbMqBkrjTSbUJUW?=
 =?us-ascii?Q?jUa/eVdRMxIDkxjbopDYoegAm53o2Pt1WdTCRwFyUkJA5sy3Rcp8/YA95enw?=
 =?us-ascii?Q?k5ORzrUoV5x9LRN2L/z5knc1EyuwCxyKYSM0/bJ+8O+0oYIEvzQ9N+JaBTP2?=
 =?us-ascii?Q?O2SWYoDO7JYgZdWA/CvhqfSG7sIoY69sgc7gJEBwSQZuyFGNkEynQ0Z/ruPP?=
 =?us-ascii?Q?oWgrQswPGzQ55vWN6h9JuvxEizOe+9uCmus0eJfXDr86ITGyqzWQzUiiPhSv?=
 =?us-ascii?Q?m+6XIaMvmyRaTOcr9DfWV+dEkIt0Hv2iQlh3h+QOUNW/tPI8QFefu3tDjTlj?=
 =?us-ascii?Q?rgGDaf2ctnZyqRv5arI6fr9B7qTjcX32eN6gtP7KjdbAcPEYbGCmK2ZytrAD?=
 =?us-ascii?Q?FtDVrj9aaGXngLHlsmoTFA8Z12+km8Wrr0DAZ09GejzPypTHJmsZr1L3CrfW?=
 =?us-ascii?Q?Tv3WZjTo74Z9PtBR+hZ9pecOpqu9dAk3nCStw7vBFHp6JIpAaa/hydlvDFJe?=
 =?us-ascii?Q?bVlCtcIaKGOTPKzixXs4ZmVqwFMpyIyTRDrXLtkpnRgJY0RxSOJWfnu7IJru?=
 =?us-ascii?Q?2AlflvJfQs7HA12ijYLyaCiHidJXJrg+zHkqUcnPobaN0iSA6JoPcXxdURKP?=
 =?us-ascii?Q?MYdK6YGceKwSqu80ap4T6b6HYT4h/jJTL/lJM2AqVblzHChjUjG19Vvn5wkI?=
 =?us-ascii?Q?3UbF3zFxolcC/5qLa2qYIJkhNvCeFcAV5wb1ZsP7J+bmDvyZPvChlwkaUosO?=
 =?us-ascii?Q?MKn2dX5wRd1d34wvFdLwacmnZAty3xya1KXeWIOI51gboviVTgS6LE1as6vO?=
 =?us-ascii?Q?HXBCJVApJZGW5XV2CiFlb72RJg5kI5aAev94TWt6QZs5dzpi8Rs2ET/OOU2G?=
 =?us-ascii?Q?BFEpVRlDsCec0H5SxLjOakCKOPLekkhzmQ7LbUbjXnmBvyA2P3EZcPzJOpG0?=
 =?us-ascii?Q?E/wsLGYBld3gVTZz1N6yl2LrYDo8DfhK4BmLRg8uwLRcD1TLiy5E4PEzFaeQ?=
 =?us-ascii?Q?+4q29u1MBqJeY3M3OzhMTKpA/hNg3mV5uC3ttAu15/+DjCzC/PzZTRI17Xwb?=
 =?us-ascii?Q?9xs8+Oy7Vjdt0jY9U7SvvFFjgJA9pioBBUm7d8yR4md61prkLylwXfI/kLy9?=
 =?us-ascii?Q?BkpACfOPKCE0Pv8wwztlvHDXJqDF5htvGiyp4U28Aj3xOW3ZocJ9j84sPp7y?=
 =?us-ascii?Q?hI7xWE64eGxvND/w5jAvAASN8TO/TMfCKZ/cpZyLVWnxx3ybP81D5R25bPSF?=
 =?us-ascii?Q?iMlRlW8iOdciKY/IB1AxbDigNmU4iFJBGScTjywMMROtTXMF2Fxhhba4RXpG?=
 =?us-ascii?Q?4mHaMCqCvEkmm6Cp+fd+lGI56/s4UD36O9akJY7t4rqU/9/5dlnME1WhPe9Y?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c18990-2652-4edb-6501-08de2c008f27
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:56:44.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BXfYbiKqkhAl2OfEmNHoC36U+wynSi53eiiKzYbW/GVXIM0kzcxa1Rr7djEGDFY7W2vOspRT8KNql5P0KCObw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.proc01.fail" on:

commit: 50b496351d803ceb78dfadb2388d9ea0fb8456af ("sysctl: Create integer c=
onverters with one macro")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]

in testcase: ltp
version:=20
with following parameters:

	disk: 1HDD
	fs: xfs
	test: fs-00



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00G=
Hz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511251654.9c415e9b-lkp@intel.co=
m

PATH=3D/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bi=
n:/lkp/lkp/src/bin
2025-11-25 05:37:33 cd /lkp/benchmarks/ltp
2025-11-25 05:37:33 export LTP_RUNTIME_MUL=3D2
2025-11-25 05:37:33 export LTPROOT=3D/lkp/benchmarks/ltp
2025-11-25 05:37:33 kirk -U ltp -f fs-00
Host information

	Hostname:   lkp-csl-d02
	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
	Directory:  /tmp/kirk.root/tmpmy94ls_t

Connecting to SUT: default

Starting suite: fs-00
----------------------
=1B[1;37mgf15: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (11.383s=
)
=1B[1;37mgf17: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (2m 0s)
=1B[1;37mgf20: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (28.551s=
)
=1B[1;37mgf25: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (0.010s)
=1B[1;37mrwtest01: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (1m =
0s)
=1B[1;37mrwtest04: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (1m =
1s)
=1B[1;37minode01: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (0.00=
7s)
=1B[1;37minode02: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (0.14=
1s)
=1B[1;37mstream01: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (0.0=
03s)
=1B[1;37mstream05: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (0.0=
02s)
=1B[1;37mlftest01: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  (0.0=
66s)
=1B[1;37mproc01: =1B[0m=1B[1;31mfail=1B[0m | =1B[1;33mtainted=1B[0m  (7.624=
s)     <----
=1B[1;37mread_all_dev: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  =
(0.096s)
                                                                           =
                                                    =20
Execution time: 4m 50s

	Suite:       fs-00
	Total runs:  13
	Runtime:     4m 50s
	Passed:      18
	Failed:      22
	Skipped:     0
	Broken:      0
	Warnings:    0
	Kernel:      Linux 6.18.0-rc1-00009-g50b496351d80 #1 SMP PREEMPT_DYNAMIC S=
at Nov 22 05:23:17 CST 2025
	Machine:     unknown
	Arch:        x86_64
	RAM:         114663044 kB
	Swap:        0 kB
	Distro:      debian 13

Disconnecting from SUT: default
Session stopped



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251125/202511251654.9c415e9b-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


