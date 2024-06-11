Return-Path: <linux-fsdevel+bounces-21386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4890348D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB491C2199A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0611A17332B;
	Tue, 11 Jun 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4zV2twK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A11813D8A7;
	Tue, 11 Jun 2024 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092806; cv=fail; b=cuOg3NV9WJQcG6d/I80vgGCuY/37ttdh4zq/Yqo28RX+vFLhkJlTASITbjcqgivuhcDKEQtCzBcILDGsaEEOv1w4bB+T24N7gbj+pDTntb7YJadixt5y0S17zehhs4atqe+YOVCxgDOUD0/xaOWgURkyGPoJPTvzuMuf1q98FWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092806; c=relaxed/simple;
	bh=EHrvhkPd2clawd7D4unEyGcEMHWNJXcplxfgc52+wss=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=d/zZd/DTfXagGKTYMw203U1JAoUc2BXMBv5blsgAxU9Y7YWtiIQwD1DFom0/G1oHLnm2ITdghG5iJ/k+mqwA43Hcma92EWZ/ZZTA9AYh5PQI4N/p6eI0RAfOj7Pl5T01/QZxi1mhLuYXqZq0EiPk9Fq11vMHmVtpSbczDLIryX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4zV2twK; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718092805; x=1749628805;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EHrvhkPd2clawd7D4unEyGcEMHWNJXcplxfgc52+wss=;
  b=S4zV2twKxk+wC8QOyOT8fcQDTM+ib6wPfigdM+Vrb9hlonCEq6/oo0Z/
   JkVlsHGNmoRpj8CcLXX49Dfzw8RCVt3GY4KsuJsVSfDqn7xnP5fskiy35
   zGGaTlCkarpOZ+3WKBnP6g2cBVnHyviDsnFZ0eCfzyX/0ZBbHr9AVXyRo
   aTzfhU0u0IVYAZT8R+uxv0V/vVZfeVJr2tC7Bn2f19A8wltkxUKDspiV5
   GtI3lwSDj489WNMDBEi8kux7jxYNBldc6OIDvSgrw0QI+Ae5ILCPyBVfq
   zCbPeqenhQyO4WJ+47CKR++fXKAuETTavlmVloECQ4SlT97bd0YnDTdk+
   w==;
X-CSE-ConnectionGUID: etreRhIlTza0hHItvzNnXA==
X-CSE-MsgGUID: Yd07nObhQjqPPWlqUF2azg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="37308274"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="37308274"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 01:00:03 -0700
X-CSE-ConnectionGUID: KV6EbLeRTF6aAqFD+ESimw==
X-CSE-MsgGUID: 0rnSgMJcS4eiSgqMJQAq5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="40029898"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 01:00:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 01:00:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 01:00:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 01:00:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 01:00:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV1qJTZBGocYYIWI5P4ll3r2Ic+OZI6P7ewLg/EjdtXOF8zo63UUCkPKqmDvVfK/kkzQTDzjE6vkb0KisMnOqk2CidkO9LVBNPMrmJyNT4ifBu3Dybjje7eE+C6BU0aXfQNVO4f3dNdiWmNzLPVTbC3x6/8JARkSGHDxEdxiQtV6XQcaR7Vl6RIWhN92C3YkaQ9ujhan778n371l/aMWJfOG6Hf1y6JJ7/TFeJvB4lXyrB9SdluN5wjClcDVL+LmM/LDcU4l8XlGyHcH3n/NvyJCxYnM3JNu33LXdJwz2S6+skhxV0HQSgjvq0QuRkx1J7sr0l6qD4Hzgg7g+E/kGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZAx77Y249zuTeGkgiHZgKQ440v5wWelXc3o+ulBIS4=;
 b=N5NIGtJfvjNRg986wmjGambKKYjePIlvx92gluV4fss+SQAM2bfIf3usnVMDYQDfWMusZH8NP+ZunTtbdSWTEND1sGr1S9SelDiaO2nzaOsYof26bMOb+JGoj19zvfsefVOZW5665y+Vxon0dk/1XGTP/afTI3f6VN7HesuWQDoWonGrOtb6ABo0NHBbq2y243He6G0TyI2/IU848d5h/ExYA2B3hJuXqkMJu1pcbiBZD+NmEfjPbiAATT6O1jJ3yuy9Fxd1NJ4rUn9EJXTebO5H0sOvOR2oDoK3vufCpdgEllZDk4jOjPFhjzP9Yasa84on+hzbfbyfSEkrygNbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BY1PR11MB8054.namprd11.prod.outlook.com (2603:10b6:a03:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 07:59:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 07:59:58 +0000
Date: Tue, 11 Jun 2024 15:59:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Steve French <stfrench@microsoft.com>, Enzo Matsumiya <ematsumiya@suse.de>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [netfs]  9b038d004c: xfstests.generic.617.fail
Message-ID: <202406111527.994f629c-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BY1PR11MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5948aae8-36b5-4b50-8955-08dc89ec7d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9wJh1AYemh8DWpYPlXInaxTYlHnvEa1YwdyN8zQZXkt2MeYrMgeVtBbLTmwe?=
 =?us-ascii?Q?TiRlOopnBCRcuJWdO+UB/mHqQZk8J2IGRyeJLrHyDC1RbZYJ/kJATfrcHxHb?=
 =?us-ascii?Q?Lq3nXj0/lxfITlg5s/qPllWlhfVLDnkd8mwOYPcHrh4gYnWlmEXCxdcSvlrr?=
 =?us-ascii?Q?yuq6VOCnkWxdXuC8plY1vt6N+qlOZ0q038iyKt+YwuBxGyBuYf0aTZmRmUVi?=
 =?us-ascii?Q?BKK/VNrPMgqV+R1nJino9jFA+0/tVwGAAg9YAATluMoJlmjj+oYojIbUhEVZ?=
 =?us-ascii?Q?SvD6C/tgtEU1JZqy3YF3nSytGUfcyhWFYG5q4nWOBLS/XNJ8DAxs7/wLDyWO?=
 =?us-ascii?Q?FI8E+9iWbM1P5JYgR9shfJx7YLRQlJBkTknH/ecgT4wvXndNdb1uwBauISPW?=
 =?us-ascii?Q?zUAp1lO41hx390+vc/DusSFyKCFe6xmiRtKuWvu6yCij7oY2oUd2h2Jaey7W?=
 =?us-ascii?Q?/FpLYOli/gFhsP7LonwcBQE5EtbrxTL2FbbI/W3rLrFGp/0QaimmohjSsjo2?=
 =?us-ascii?Q?E8Vof4D5c8s+mtiFhFo5fJM4HNj6mSU+Slkeh9kgyoJFGUfLhR2Jf8/mD/Ta?=
 =?us-ascii?Q?0wI0J1DlLQwucCSQXLjpEP7/t1GaSdEOX2cxHYazav8JVSgAdicCcYfCAAdF?=
 =?us-ascii?Q?TmzaDucg9hQS/onwELyLutyWGTUst5HYRY7gqfEQQNjEO/IV3CRSSQl8ZDqH?=
 =?us-ascii?Q?hxafIJ8aigJoebCfOZbz4AHVSNnxqkbnXsWAUeelgkerq5whHeuzsdkmKBer?=
 =?us-ascii?Q?LQRCuqlsGjn2NZ7I/XSsbTACvYpm2iRh+0A+ILmLp+/Av7SLsCcVuWI4EFx/?=
 =?us-ascii?Q?nlcyE9fYjQweXJ0flUzos4mqkSe4d/tJH8Q20eJYBAFEgqj4C9vXL37nwUuB?=
 =?us-ascii?Q?rfDEZjxmXPu2f/ytFICtfPpCHn/iaqO0ulbrNNYqwFlGDDUJj9jRW6J72Cdf?=
 =?us-ascii?Q?ZK+OhMuJdEWbHzLPDwHYl18Td2cHlhU7F7dAhEcjiNNPJuBGt/80YxIzXbjI?=
 =?us-ascii?Q?S/b+WkKiyBetb0vFZ40NKFwjf0Syii0LfHcEnMaCkqG0iPlrWUavJrsmU+9k?=
 =?us-ascii?Q?r09F5CoAo1M5OHoMFgVoIkyIDmDYxR+g6/LPFptDLnIZ3cn0ggUzrTyO5wpY?=
 =?us-ascii?Q?AMcgKnwKgeTFfo5G4kMD62DsNY4MqkLtS4qmoEmGNmcGNnOujU8UU5oRNYGI?=
 =?us-ascii?Q?H9CTTH6e5AyCAv4BhOlYtyCqSlxJgZlSsMlZpbzeP/YIGzYdf/9twfmGfb3m?=
 =?us-ascii?Q?VsasYVhXpTnoQmK7FlPGI9NCyFfh3X1TIvokRfJlpQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2lLolfTGhpW3lYoS2WW7ANj9ahFBhTBz3lJlMxG689yZxyulV+TUCAJ+Zg4F?=
 =?us-ascii?Q?SUxwOx+cSE8xSPMxFAQhHzxQHZ5pR4GrFFC9llLbQvBXlnlO82si4tfQM0yt?=
 =?us-ascii?Q?HX79hUDdXnke2QgcQVYwU2A2ivH9HuNicHFEzAIZr/AF/dj/8B3Nm9xX0F+a?=
 =?us-ascii?Q?mvjWm3LdJiPrqjHe3wetEBiHJqGyv0qx575rv09gJAEj/yabwUGkb1gtQ2Tf?=
 =?us-ascii?Q?LfHv/TJP4vXAjppOX+1sg4rMVrttUar+KOjsr6RWdT2dbTj073vKCmGW+MQU?=
 =?us-ascii?Q?5m7+ecq3ajJGPL5jKkYSCYu0XhnwvC81xv/K+dfQjED0SekilB+4GEnop3mp?=
 =?us-ascii?Q?J8TDB+7s5fjckFuwu7hhvFyAjwMzH/4It1NvU/r26fSWVWtBpK2WINudTjL+?=
 =?us-ascii?Q?Tbiby9zS6QzEkE7b+ufscCXJtboJk+k9x9LVYjS3B0ryrnDKqVHRC76UhwkI?=
 =?us-ascii?Q?0ukMgl0AIvZeXR6b1nG3KkrUqq1UnCEp6BwZr8clF99Ke5E6xPHPTkwgJipd?=
 =?us-ascii?Q?HG9zLIS++hZ8l96ayDfHfmLL9x97YHwNGaZ9jrzu6Mf4+ave88Vg4bffQHUx?=
 =?us-ascii?Q?5IPOJHnXmOFlWphe3fOiLwkrSfYqlNnLqrCbCfJT0ANs4e3X/iSMCv7ti2mF?=
 =?us-ascii?Q?FFw63KZlDwtBv+UMHBKiWF/RwDl1QW6RPstYwk/mqg9At8rBhGo+wGL8HegF?=
 =?us-ascii?Q?eB7wsKOE6h4fXzvSB9mkGGHzhyHW9L0pdjlmkBZM9A7FKtgCDGVP5bI1/zxC?=
 =?us-ascii?Q?ZBNTSZzf1J0y/3PWz8t1lJC1A/d/zMUEZ4Iyk5RnJfvcMnd0RvwSlDy3J8qg?=
 =?us-ascii?Q?ocH4JIk4BWQlrgoJ1JQCscEh6l26l7mcXeI4gjzc11PqfZoPZy6dKEVopBh1?=
 =?us-ascii?Q?oIiSa8lM3UO5Aisg9rTEXPCa9cf/66QIxeXNSAc6efh85UXe+LDoRB7sh2V9?=
 =?us-ascii?Q?rAJCA0ZMUHlOqatCW3aAYe7RdNPgLgPGLs1c7PBhOOqwL7M3UEHhVUcaMJaO?=
 =?us-ascii?Q?YZervO6nQUmHiwV4tGCD80z34uYCLvunMCcJk6P3F+/6wNzOSM0NTEIAlxhZ?=
 =?us-ascii?Q?UwVk6m3hRN0pARo0FrnMUXXpD22Pe9kaqq3DdimTTXbJJSrLseoGE9hv87S1?=
 =?us-ascii?Q?h8OJzb8kpnAyWl8lsDja0BI3814AEXQmIRMVyZreFYXvfHm0IvUamZhhtoVQ?=
 =?us-ascii?Q?u0eS/vpYH3nqrCpgL2S53ivQiJWmOrEuMjH1+6/SGb8Z/s1w+z2I5V6ed7yG?=
 =?us-ascii?Q?k/0ooSVF3atwTohkO+38Qq9q90uGkFtzaFqBYKzGKlKvgkJGDb3Fd+Vgl2Rv?=
 =?us-ascii?Q?RouRjm8VFoy3vha19b6xvSIdY3wq0L42zXrlB5lxcXuGbhHEmQkvqYADcyhl?=
 =?us-ascii?Q?AOFutNUmUr5sr9JA2PKA0VQLEYOH67dcEgNJDxbmuzm/ovTvsoLBRO58IvhK?=
 =?us-ascii?Q?q5WSFZkdu7eqsWVlE6bUmLKVP3h16fqmL/OSaY+FeFSUOhQw85UXSZ3tY+pQ?=
 =?us-ascii?Q?7iwAQCD1nMHPTh4Ch7qWzURXoLEayI2wwlzt+Zvu19xomEEl0eVYR06vIPNW?=
 =?us-ascii?Q?VyOjpQy6zdyU+yf5sGVU2V5lX1dOeK7U5oMFgOK6nMY+nsoFWp55hFPEAlMf?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5948aae8-36b5-4b50-8955-08dc89ec7d47
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 07:59:58.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaEjEByH5QzzAD6Van+1ojNNjEc7razzsd7uVPQQEnjJgFfOnbRMZm+hH3YBsbYsiMtJJUVQqFQxJ5YoMIM91w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8054
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.617.fail" on:

commit: 9b038d004ce95551cb35381c49fe896c5bc11ffe ("netfs: Fix io_uring based write-through")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      2df0193e62cf887f373995fb8a91068562784adc]
[test failed on linux-next/master ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f]

in testcase: xfstests
version: xfstests-x86_64-98379713-1_20240603
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv3
	test: generic-617



compiler: gcc-13
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406111527.994f629c-oliver.sang@intel.com

2024-06-06 01:33:53 mount /dev/sda1 /fs/sda1
2024-06-06 01:33:54 mkdir -p /smbv3//cifs/sda1
2024-06-06 01:33:54 export FSTYP=cifs
2024-06-06 01:33:54 export TEST_DEV=//localhost/fs/sda1
2024-06-06 01:33:54 export TEST_DIR=/smbv3//cifs/sda1
2024-06-06 01:33:54 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=3.0,mfsymlinks,actimeo=0
2024-06-06 01:33:54 echo generic/617
2024-06-06 01:33:54 ./check -E tests/cifs/exclude.incompatible-smb3.txt -E tests/cifs/exclude.very-slow.txt generic/617
FSTYP         -- cifs
PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.9.0-10324-g9b038d004ce9 #1 SMP PREEMPT_DYNAMIC Thu Jun  6 03:01:37 CST 2024

generic/617       - output mismatch (see /lkp/benchmarks/xfstests/results//generic/617.out.bad)
    --- tests/generic/617.out	2024-06-03 12:10:00.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/617.out.bad	2024-06-06 01:34:51.537054472 +0000
    @@ -1,2 +1,12 @@
     QA output created by 617
    +uring write bad io length: 0 instead of 110592
    +short write: 0x0 bytes instead of 0x1b000
    +LOG DUMP (4 total operations):
    +1(  1 mod 256): SKIPPED (no operation)
    +2(  2 mod 256): SKIPPED (no operation)
    +3(  3 mod 256): SKIPPED (no operation)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/617.out /lkp/benchmarks/xfstests/results//generic/617.out.bad'  to see the entire diff)
Ran: generic/617
Failures: generic/617
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240611/202406111527.994f629c-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


