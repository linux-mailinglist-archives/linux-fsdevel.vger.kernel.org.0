Return-Path: <linux-fsdevel+bounces-59333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C1B3757B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 01:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876DA3618FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 23:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC8306D2B;
	Tue, 26 Aug 2025 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1Gp409c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6132D641A;
	Tue, 26 Aug 2025 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756250478; cv=fail; b=owLXhNeYf4HxP4pnPXTMza0fmIorJkOsgmPsaPVA5w160qbUp3I21UjjTQNvg88EGaflzRMkMo3Zm/PAAcFBSNKsywkrHmWCs2qY6EzyDRLi3ydhqdFlQP8LP+y48RwuvjnzCDEH+eBbIYXPsQTbx0odvdTS3chgYLVTUYQcwEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756250478; c=relaxed/simple;
	bh=VAie6FCzvAPOTP1vGgkK0NylHUaTQWwSR4cX/0DYMVo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ItiJnVphAEBgj3Q55zX16l82MC8ZemFKeWovUa/DDuxaLzmLrbUHwlOjy3aMl3HVBYDSbH0LqpcqJcRUbmqo+pxNw6lNP6qtMCmSBw6+cBIi1rm7YkfvB9WwM17Uk6wy8qfKs53EDTmTAwpt4d1PwyD3Xi4xFEYD4fEXJt3RaE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1Gp409c; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756250477; x=1787786477;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VAie6FCzvAPOTP1vGgkK0NylHUaTQWwSR4cX/0DYMVo=;
  b=Y1Gp409cz3d6lxdtUV4vHac8/qsku+nfjsdqeiPPaelA82lwCBl4KXXl
   dNb3+lifPREGsZ6jsYkU4QKcje/1coaioYXLqdWJntAtAE6LgJC+aFMzT
   I4MDS09cvjtmzy+Oq9TWAvtBebfe9dCuTD8Qv3rJ0ztuXhnqr+Y8clfoF
   m0xglMxXSzYTDLxwEU9cwh17c6HK4VxMLLfrpRgRRxUzkDKQ23yEQYvbx
   R5C0nU6niVnwHkRFeWvmw2Nz3Gc7g40d6gqm2ZTIx8PG3a8UG1VzKiUfa
   K1+5oVe42txYQ1JeShrnarb13r3/W4R2SWoKbl0TnSCoicZEBe6btQ6dz
   A==;
X-CSE-ConnectionGUID: B75Sdxt8Qq+kLtksip0TRQ==
X-CSE-MsgGUID: EzVKzX5YSLmcNuoChMgIEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62145126"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62145126"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:21:15 -0700
X-CSE-ConnectionGUID: 4fgoqFD3RwW8VMLCrB21Ww==
X-CSE-MsgGUID: teWiB7/LQiyZ9REpZdWMkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169632701"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:21:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:21:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 16:21:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.72) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1yedYNu0IwdIn3izOp5Y3TgEw3uczH68LAICPkYSyCrGHQXuH+6sTfnUrwCwyNu6FblzaDTdBM70LlmRVhKF/XpsVLiFWpG4WLGqdIX8PBRBBrBkDCk3uMSTZd4j+5AJmaftzrAdTpIZv9nvpVD0DoGuBlMDDJOBoDpNym9XTmmsu5k96OhQAzx25iA/73lz39UHe3P4wCtXbmHBfgMoVWa7QnmDB65ApZh/RXPJzE4kKseFTkKWKwQIdnc+m/nMPLb9QSJscl6vCHEvhW6OlKsWsb177mou27m2BuCyatuQ2D3MqFlEK+GqT4UzpoZ94hEDBdRuo2fsqbqVm/K1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2OJ8XJEIss3vmb8b0HpDaNJ2e6g+44HvB7Lj2jTzeY=;
 b=aIpnDzqgiO0HPie9yqKV14iL0+zLx+5YkhhSPNm1zuRz13Z7gGYYMSvLkxDFaFbVjfA80G8e9+Vjbo2Y+J3XdSgzy/AnokWH5MqSdu8/cmpvhkg3BqQaB9JKH+1+D2Cv6W0UkSP325lU5GXUlinesIf3AhQWtZTbA1OZlg4QVdxpgW+7ekr9lYrR2gF7BscORgqGIc7V+QatfjQGpwux0t7mmmQrNc3+Df4R+zzYFVFkYWu2ewZJfwHz/IDQ30jFzn7NyzRkLfPvBHOBZcSIIxnYY8DTfXJsdlIeKAYvGo1FcPU7ANT9qK7UdWA9ZROypKCgoaDETcQZlot98Jdi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SJ2PR11MB8471.namprd11.prod.outlook.com
 (2603:10b6:a03:578::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 23:21:11 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::4df9:6ae0:ba12:2dde]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::4df9:6ae0:ba12:2dde%7]) with mapi id 15.20.9052.013; Tue, 26 Aug 2025
 23:21:11 +0000
Date: Tue, 26 Aug 2025 16:21:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Ying Huang" <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>
Subject: Re: [PATCH 0/6] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL
Message-ID: <aK5BY7bQ_dMZLFNT@aschofie-mobl2.lan>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BYAPR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::16) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SJ2PR11MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfa5387-8f47-478c-2c85-08dde4f73e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jHGTIT1Zz2kp8GZh+6EZgBasYi/ES+lbxVwE/tRHCQSuq1dEepCFF9QcVM89?=
 =?us-ascii?Q?Iqsy/VeelqEDVrfgMf2cDAssHmG+XMyaY8PzeItCrY3dQumXJbC0sMDzPgsn?=
 =?us-ascii?Q?em+12bUniBL48QmqRwVw77GdtFWWjcwlImipl41Bd9BDPN9rRhaUaLjJjhSq?=
 =?us-ascii?Q?l5tUzZRlIYS5myZAUZC/1258Z/0epXZ5ezsn1wsA4+xATkBzpVvKb0t3uhdN?=
 =?us-ascii?Q?Nai81obKw+wLgfwtS9iPmOUGXvh8YTGfuByPnYMR642LpQAYg70XUI4RPI4F?=
 =?us-ascii?Q?StW7ungge6CRlzzxZmb28UIlcdEZL4o5DKnfLkDzbIuYjOMCCc1VspQbvFgX?=
 =?us-ascii?Q?nICTKtmy/RRuUO7WsUK4/1XNkSI/gKroUWOeS04QWWeZxYD5ddII7IAG1rIo?=
 =?us-ascii?Q?exmk9vpDaXpjJwN0E8lM2Xgj2ZF54gwulx1m3RnxvfEnYpJcztfZPxiJhvmA?=
 =?us-ascii?Q?oAULvTktPS80T0FvzvP1JIqWUhw5mom9+qezb4AJanabp53YoQJ8bX0ymUou?=
 =?us-ascii?Q?zwLd5zw3ZZTF27WQs04oSVN6YNrjnFvxNEYCMqu0jFQlMMX6OY8uvUOnO7O2?=
 =?us-ascii?Q?PowViLTYzSXpJPy+Jjp5s8DgtBrDGOB/9Dt+I2uCGA8RYsqbdkZ69gczrjT6?=
 =?us-ascii?Q?Py/acc8TzTODcG+/1zCs8rfNjYQQgvw93cUVSrEy9zvA6zXuoJT01lvdRFWa?=
 =?us-ascii?Q?dW/x5iLx1qhiYtclyjZHo2SHpoxI/DG2klG1zF8gfkTowoWx861OxX+w/VX0?=
 =?us-ascii?Q?HQHJ+5BINVYgnCy86o2mWkyvlT0zBkQe0ez6vCOOwMSIGoRI5N6f+WDjLTyo?=
 =?us-ascii?Q?MY8AZL+5wMSl8Qd+l44g5ifWIfQfi/l75eoCcuCrMDv5zKXS4pMy3XWCLWYH?=
 =?us-ascii?Q?ZhUD6sVsFU0kjfFpzodEV+wfR//G0RQxH1dSwBbEtwL4ch9Pdu1sRN9CoWWT?=
 =?us-ascii?Q?3brfPy9wgb8fdCDhruMZWuhsGz2bgpAEisrxxZLFsAd2sbPw7x40T9WvJuC6?=
 =?us-ascii?Q?tEk5d1XTju3XIQ1SWGGSDBAE2h7ekWerJh69ekBgL58XJkx9w6c7oDtDqy9s?=
 =?us-ascii?Q?z8QfHGh+U2XsTtTtHUJJrA0/qikIJYGQU1djnIh16Hfxs+ZVK9VcD25S7uZE?=
 =?us-ascii?Q?ecKzpfW5Q6jBi0GlbY+2LCM0bigP6Qc9gSEuBDzJ/Hx17ytVMIIYUC42JTua?=
 =?us-ascii?Q?OofNjqDg9miyT0b1+rk7aDDWHFQQse7z5RS7uqwUJj1HRtUS7m9cJSVjy6SV?=
 =?us-ascii?Q?ZvTYhr8ERveLtGq6uNS0yOy1THKWBcmBlhn+ERwW7dZDvV0StADQwXBb+wLs?=
 =?us-ascii?Q?BEbI4wnv0aDstwAUlH30DCcAn8Ho5hhcKP+xYQavFru5wphqvsezpZ2iXoMm?=
 =?us-ascii?Q?tAM1i+8sENFefFhCxVaLwoeUkJ8FkFrEzYJun8Pv8rfBguKATVp57GcHwMEr?=
 =?us-ascii?Q?jlR+QSV/9WU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uR0zcsBx+5YL08eZSJYYBd5ueJPFCekZs9eWuQXQHUrwCbQuG5VlgUFrepsJ?=
 =?us-ascii?Q?ILROWsUPkgrJZQc5n/QOS39vZhz/4RCsHHZZ76I+yLtbBRyMhcHI9wyIBjRy?=
 =?us-ascii?Q?JbvwpaOq/jVaR6Dr+IoWs28zVEjrvhUe0KifrI2rheqoD/VVMEJWyatjxiIH?=
 =?us-ascii?Q?H6FnwNuLU8/qYzAjXqt/IcqI3TlMqxW2tJT7EOVWYe1c1Zo1JZyAzv3zggNO?=
 =?us-ascii?Q?wQ3YTGC2G3WySwefPGp+FXHfTCrXBKJX7Xw/hBphg9pwrvUO8cdos3aXFtxd?=
 =?us-ascii?Q?zMXLsOVtZBs/RfWZxmtE+KxrM/OgMVzwFK49Y//ObnUpbOuto8HzXTxML7Yx?=
 =?us-ascii?Q?4XL+7ayDAs1ukC4+TcGIXfPWnOOut/OSM4d7p2Wkm5ZE9AqIbWVQ7I0RVOz4?=
 =?us-ascii?Q?p233SYwGTkoGZjGU33p15aP3C+YTJipmQmZUAUMVyRW6aeCg7wHKY7W3uCg6?=
 =?us-ascii?Q?YuCurlJPc4JvPLIaiKkgGFnvrH+Pmyf2ZE7/tfSldNHN+QENFvb0x++CBXEs?=
 =?us-ascii?Q?PkvG9MG6F9HMwNZtL0NaF+bxhUAL0C0yT0qrZ+eXrKF5/SFw6HKqeMWr5deD?=
 =?us-ascii?Q?yUBBmtta9HP0vg8Nk+p++wNzQc/yuOudcn3LsFr02VIPPxcVeLW1uXMzQc8D?=
 =?us-ascii?Q?vNMfSXJ7RUas7kwD5T3qd8qKfx4ACpbyFcCQtu3MtB59TznGfrhpTLg5o8vm?=
 =?us-ascii?Q?1Mngzre44rGY92gLmtvBfcdjh6vGKHS6kJrGaCAg1DEDNaddo9KC0gpx2hCt?=
 =?us-ascii?Q?zjg88R/zfgW9gfbou+AgvmMbkmS8unB2boDwajBcDjxXseCbapz1O/yjPz74?=
 =?us-ascii?Q?SUJIrTe6ffRngeh6lRSNqv9wQOFLAbddJE3YPEbHUFbXRetb70rHWyNRZyp1?=
 =?us-ascii?Q?2a+E7rm/CXFKql2leAHqrTdj0eJZDj9cwpQo7+zlvqFtmfaQJPZXCRlQSNKq?=
 =?us-ascii?Q?NUZyv3z9ApJPt1eyX9SWrghiAecSI6n1tnlkBkD101iOOrTR+kkB0pEGr7cr?=
 =?us-ascii?Q?OmNo1u8P4oO82tN/rsHf6zjZ7vRmx/8yWgmvhO4WAX5m2PHhcubIp9V7p2XG?=
 =?us-ascii?Q?RpE0e4Uxr/xsB+2/lAHExHHjXxxJpjKhn/G3KXjMEyw1MZqeGnvd4OTqyl8T?=
 =?us-ascii?Q?oiEUcuIzw8+IkVoW5vKxygLVjHE4LxVPzim121swBbqyiLs9kLvYLWx4PkJx?=
 =?us-ascii?Q?Uy1tUzPy6mgqVLncIAtKTxtX0OdMg3qFYvxJY/dqm9fK5eaRZaN40AINC/Lx?=
 =?us-ascii?Q?6+4qhhU+qiN3c6f2ZYn4qxdObfuN5o2JPEil5+e7QLShtHyyWFp/VO+0jxCG?=
 =?us-ascii?Q?HVuZFmsixIb3qmSD/uhrdgLzYbMXz11TLB6IQuYX1F/JmX2KkhuTO/MyfdRG?=
 =?us-ascii?Q?GiFuntX03/ePRVMEFiONPQEB4h5YaBbVqz9mWAjsXmNJljwJeNkcDMrW1Mui?=
 =?us-ascii?Q?sTxxz2ErcVDEpDyRXhYgwdfWNOgU5WIKGTwIpZfIIkH8vhvbTYn9NjHSWJHu?=
 =?us-ascii?Q?Ms8yC4PUPoGFhD1+v+xV7pRBCQX4h2RetjN9Ex2fZuJiyy7UQukkUkkY6LX2?=
 =?us-ascii?Q?crq/LeDpQWchIr7CpSKA2xT9NqwvWY1LWhtZ0nzu9jnkYi45tN9Ce48NBaMk?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfa5387-8f47-478c-2c85-08dde4f73e26
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:21:10.9622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LVVsZBxDpKR1aANZwbnAMv0cNpRot41uYhu6WCapTaDUKDdGJ8CC/5b2/kqzUSnQhSq0y8tQJLzwR00OQtLJ+k4dn5Z1V0oRt+OKkwPJR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com

On Fri, Aug 22, 2025 at 03:41:56AM +0000, Smita Koralahalli wrote:
> This series aims to address long-standing conflicts between dax_hmem and
> CXL when handling Soft Reserved memory ranges.

Hi Smita,

I was able to try this out today and it looks good. See one question
about the !CXL_REGION case below.

Test case of a hot replace a dax region worked as expected. It appeared
with no soft reserved and after tear down, the same region could be
rebuilt in place.

Test case with CONFIG_CXL_REGION=N looks good too, as in DAX consumed
the entire resource. Do we intend the Soft Reserved resource to remain
like this:
c080000000-17dbfffffff : CXL Window 0
  c080000000-c47fffffff : Soft Reserved
    c080000000-c47fffffff : dax2.0
      c080000000-c47fffffff : System RAM (kmem)

These other issues noted previously did not re-appear:
- kmem dax3.0: probe with driver kmem failed with error -16
- resource: Unaddressable device  [ ] conflicts with []

-- Alison

snip


