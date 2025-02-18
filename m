Return-Path: <linux-fsdevel+bounces-41931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF08DA392A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48ACE3B08DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9171AAE01;
	Tue, 18 Feb 2025 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9Ory23m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E2190661;
	Tue, 18 Feb 2025 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856678; cv=fail; b=ibLZvvOUbHrFuPFMhTX9Bmm+m6uoYh8t4qGmNUPRch6jK8wL1F05gqoL/qUsi5VB6f+daWokBWk14WBajI3RlZmLV78PTXmbJqonzEHiCl1CUmr1iVJcg/cEsiV7VOzk0/DV1nAcEDkd2OVuUGzx3PrGL1gkSLyfoK3tum2sQZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856678; c=relaxed/simple;
	bh=bDbY/x9i3T6rrQwVweJIfHA5fxcJRikfL4FHt2yuF6E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P7RO2dnBZ3KvdHY/6bd7jhzXpDCNpC6uhZX8la5ZqHKlNnuVpHQ5JSTBQ3YNOmg3ncFkKLBSlgwlSOTUQw8P3s9p2FqOQ++ZGVWvfb4617o+7sX6ToQcphn1Sr76ZJ8hj3Z3nyd4/MrnqHHq20mrsclol1sWRaXT92tT+C+Tags=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9Ory23m; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739856678; x=1771392678;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bDbY/x9i3T6rrQwVweJIfHA5fxcJRikfL4FHt2yuF6E=;
  b=B9Ory23mzkLN5shHtksswK5CAVAuY9wakVZw5JDt5eczYMLIISJ4ABoO
   raQTWU7RIe4Ky8oXrk/CmVcYSYNutW9dZoqBkFvO2cU8qOi+Nz+9m5w0q
   uzFAxSP3t1el0/MFZ/p2bmyTyTp4yyyRTkB4XwciRJG6tSZl3zqZ9wAyW
   zrBpJtkUJrEmepynMqOntLTF40SYsCzZxXFsKWRUjSU5nr6ZNyHWMQrtG
   boB63PL5o7oEOxHAd3YMWc94Iao2DwLxsjlPdfyUBjPQlo8DdVMgo9qS7
   cytSdvpiKjxKccRpt+1Myt/FC2+ZeYOT6dHL6HpGNFUmnaF87QQBSzbb7
   A==;
X-CSE-ConnectionGUID: NoVAamFQSdmWLUZPlg0zDg==
X-CSE-MsgGUID: wjd1QO3eTAysRMjVamfP5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39773737"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="39773737"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:31:17 -0800
X-CSE-ConnectionGUID: Y6k6RkGiSx2dlXjQTaKtjw==
X-CSE-MsgGUID: cJNrTH0fQmC61RY119qfnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118930038"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:31:16 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 17 Feb 2025 21:31:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Feb 2025 21:31:15 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 21:31:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eK20moqYiWvTvuaLN77qG2S8ocp8D+fnetanIfpI2rKG4VrCd05K0P/aHMQt/znq5bMzIEi8wUmC0ZfZ+cOGfceLfK9me88cXa8Erc+vvu2EN3RVGeqLSC8ifuSgk9FxfHUrpban73JWr3qCvTxVoipN5WQfKVOZkVQb62JVNG3U94caOQHUJ/BAqYFD2xzPF/9jiZu1UywKZMEI5rd8jtdPnoTzX2e2me1YOLBe2gaxfJ8+ox5XXB93Hdw/PIhDjNRUi1tJty6cIWsT9Xe/eQcJp8J16nm46XhrVynoEhVLtM4cgMz/RJAyQeZEpSKg6BHo3KTkN2h8/hsr5pEjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efftE4VuypWU84/lP4sYM0ZG8MZLHpSFaOOeH5CIYmQ=;
 b=m/S8xaYN7nKGf9sEIifpfxI6ekzJ+KId3n0pIO1nVGH0I45q3gycZSpB8AVa1/cM/sl/wvtyT69l5E74tfRdipVtz1huv2q2ff9cn33SDRn3TdTSMcx2NzOAZsVBkGBqgYfCcCKqIt/0nU1y4LUg/rxldFYuudTDBihCxQCXMl0yOYssNYi/BRaOMbbHed3Go9OSNBU6yOl4Z4ctbkDOxbjUvY4OXS5DF5V2YIHhRh+o+uulrrXygmhGK5S/nTDqMAzd74+Af9xzLXFFVDpL/W/X++hLHGDeD1B5NSKZbIGQsifeeYqNKcCKHivcvcmkld8RWhTD2ZBLmt3NZpMUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Tue, 18 Feb
 2025 05:31:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 05:31:13 +0000
Date: Tue, 18 Feb 2025 13:31:05 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [do_pollfd()]  8935989798:
 will-it-scale.per_process_ops 11.7% regression
Message-ID: <Z7QbGTVwIwnwhMAK@xsang-OptiPlex-9020>
References: <202501261509.b6b4260d-lkp@intel.com>
 <20250127192616.GG1977892@ZenIV>
 <Z5ilYwlw9+8/9N3U@xsang-OptiPlex-9020>
 <20250128191042.GO1977892@ZenIV>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250128191042.GO1977892@ZenIV>
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: fd83a9e0-c343-4ae1-40d0-08dd4fdd75b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ohkVu8zMVzWPvfAdCD3sybmdPWCNKRpV9Y4BxiU84QlojSHQwXq1n7l6DRQd?=
 =?us-ascii?Q?IGEPPYq5i01MUvabOQywXl2um0zW2lLkQq07siKbKbnevl0frgL8ps+bfEU4?=
 =?us-ascii?Q?RY9KgbTEVNycs2cpMttK7KleQgxJeu2ptMxn+i2sSRWq+1b3CduGDXsnCvDw?=
 =?us-ascii?Q?OAXDeRtPsDeIqme7mjDutKyRwkXkeqp1ixRINwV/R+ksWeCzDiSsj1jncStx?=
 =?us-ascii?Q?NGA0OTAtk2pWVBotA4N147pvuC6O42dAj1TdkRnkwviPMeVjyaY66xVF4doX?=
 =?us-ascii?Q?dTf4Q66sXb8xI4nfdY8TAtLAOP53FHs/YZ4fymN9Xd9TIQJn/ka9pBYYeR++?=
 =?us-ascii?Q?7r1RFpnJrfWyR9BosYoPS048XED+MjlrEWB9UuXrMg1JwdDD2Ku8e7VN+kfi?=
 =?us-ascii?Q?S4dMEuhrTQuYVFwRm8YXL6EnuKiBVOw4jflWTcpQnjGRuI8iZnByC/6JaKZs?=
 =?us-ascii?Q?RcjWFU4tiXvFKRPVu8Kt7YyvwZXgt7cIVEdES2UZhofCoSDa976qlsoMKm7T?=
 =?us-ascii?Q?/E9As+hGFzzp9oGVe3gUw3YXoNi47rPtut72jJ8bbBMqdYYlCWlCIh38LvyY?=
 =?us-ascii?Q?/OdUDA9rbtRYyojypk7bHhOA4sKZa9cS0v+7yLrr83AVqF+YC+n9sfQNPEZf?=
 =?us-ascii?Q?mEHCFKUK7zQZtvzGBf8nQdGPgUJjHTR6SnNPDOKVPQ/JzHlhqffe1vid/G4X?=
 =?us-ascii?Q?CtDSWz2Z+D3ZSpRbYrMSH+jroe//TR64fu0lvuXA6QkvZ4yZUOh64umc0c/v?=
 =?us-ascii?Q?csV7+ojF0gCN+LPM0HYk/K89BxeYJQ0LQD2w++4GoxP+jei3hApJOmjbtsIc?=
 =?us-ascii?Q?PJMSgXvANzioiYupe0g9XAxDBC0yNww/21vY5Lmiq0AO4m+BfrvIXPh+gtfO?=
 =?us-ascii?Q?H2irD6vCYmkQc6VhLCNnIvZq6VekCn+jgtJPeVvslMbempZbTMnjdcl25/dP?=
 =?us-ascii?Q?C4tupk/QloglKMLN0ZUdOwwBxNf5ZlBiHcEabzRRk3yLdT5G8YrJipopZBib?=
 =?us-ascii?Q?IlDbGNMikRZ0kXJSngjD0SKHzp6wgMXwhIO2BK5cqfkWBu6tGiZITq+lX1IZ?=
 =?us-ascii?Q?sxuRttxjLSbSStPkp/GPEXMGLkFks6+Z4oDFZHXYQeBSXqPycCK5IqJ1izC0?=
 =?us-ascii?Q?QNSBjnk+yt+RCU5mn8Yg2khjeKsibjmoJIv346uT+9Ar0oOZnw2NpoIrTwkh?=
 =?us-ascii?Q?b86CAzf6LtII9DkGgHmGJLXkLe2dBR3atyKtkA3MWcQTVvUkOPUInpoC92rH?=
 =?us-ascii?Q?Cf+9MgT0iOtTVMsViYe3rmRIqJiKafE3CN7IV6F5XjhrNz+ltsECuMm6eu7z?=
 =?us-ascii?Q?4LolJsfigZVbXoCQ6lWTpcrzZ7aNnZOO7bS4IwfFmNkQ5b97RFROecqMvEHU?=
 =?us-ascii?Q?6WfuS/dAt1wp00M0S1shXJmMvEPy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?syK9IojJRSYWNZL5g9REqGHB0nXE4uit4VMFwjhMj6MJXxa/Y8eqAvcEfI44?=
 =?us-ascii?Q?hAVJmjIhFAHpLAAi8Ivpef/YvceimyMjuiX/evd2GN1zCmotGS5aCiiJeawc?=
 =?us-ascii?Q?Dc2GK3mFvocHyhBHpHPD/Ao6qKgZEkCI/+qv0QgIvL30vtfZ4WibzmD9cTzp?=
 =?us-ascii?Q?jg7/dkDy7TUAR1MUxTv0L7WWTWsBnB4ZSMnpiobXiVq5GVHo/TAbXjbUH/Ur?=
 =?us-ascii?Q?QVJR47bIVdC9/C2obZCdV1niowDCWPCLfEgReRqE3cXNITwDwNUe2gIHFL71?=
 =?us-ascii?Q?uMiHpMk+DS7bRddUNVGlgubrlsQygLTgjXy5yz1ZOBlxLAPfnl18/ZS3/YqK?=
 =?us-ascii?Q?PzWe4chKMHNAzHnuGJMf2siLbsZSRwJ5kO+Rbx2augzTwaPIB1sT5W6YHqCS?=
 =?us-ascii?Q?nKXXgEdwe9mkfoQt/Ni2pfsDPs7Z5xLCwNOPdSB8A/piOLZNQA+h3Cpq620t?=
 =?us-ascii?Q?lcSVlMpEXFPKoHLxX16QpsdlJ4TheIJ+v7djh5Ot37LwIAeunfroU94507Ye?=
 =?us-ascii?Q?vPwy+CUTCYMx3ku85E98Hg9gPLut+8vjQlXQmKyWeqD3RcorUyIyWtPp8hlj?=
 =?us-ascii?Q?Nm0SsmPqkKvQ0Joo3Tfg/YDzmP3luwgij6ZXmvPZr/hsiNVmUwchZLS3Pglh?=
 =?us-ascii?Q?DWA8PHU0bwb3m+SvhOQ2XJ2Rg0CX+Wh7HG5Tle8oKdVsUIAwkptigeHo2VT1?=
 =?us-ascii?Q?BEH1AqsAHvDBO2hl1tqTZNWKzCI8YuJB7gXCXxvMQGLw4OLCOHpYbNb+Pi9g?=
 =?us-ascii?Q?JoyEidJZDZ33D850MBdrzxVFRzTxoJKMZPEUv0aKO2++9uGzSNeAJBVq1+Lv?=
 =?us-ascii?Q?pyhn+GQj1Mu9wwRGERQgAMMoyqpQtKPRFn/KGBrT5+4f1UYlG3l6His44wGu?=
 =?us-ascii?Q?9OY1Y462WqiGEZw5c5U4KMxvijsAHEcfdILY98bV+ExnawdtNMTNMARxmv79?=
 =?us-ascii?Q?cjDGVaORn+voIP/wNpV7sE8e6LHKp7V5ROn5FhWnugLnNSi21rKZxdJzhX/+?=
 =?us-ascii?Q?RrpJ/dvhb84ambySAsMElyI2xBtl1CLFPZ4vysGkNeVUHzpu/945Wu6vu84o?=
 =?us-ascii?Q?ws2hY6m06m0bxL7XOpCEFfckIwysYwqGBKSkD4iR8Ul25Tj1KSE3N1KzzyL8?=
 =?us-ascii?Q?4g0uWunrPAlXPVbBEsTXKUBEMjznHomj87IOioYnl1ByeCyXfZlyXRAGLAf9?=
 =?us-ascii?Q?q1EXAPp0q0dIsRNEVKBng4TFHo7Ksv8Go8j9cxw4XUGvnNBmRRJSqSl9kez8?=
 =?us-ascii?Q?NV/ECgX8t5dg3o3q06drgwFDJTcOFlDB19EZgUzblujjZQSXkNsqj0RnEmQ+?=
 =?us-ascii?Q?XeWhQrUTXYggP/ZontJJnvjvk2ixqzdp36PXSlVHBGWjL2Pf10OnFBmdsfrn?=
 =?us-ascii?Q?LNFywLuheJv7NELxBXfwHZxqLN8kr36siHB8Rfdujj5nsAK3AS9RURdupBgj?=
 =?us-ascii?Q?+GCCeyVKywAnzQE8qZLFr2NyalI9Q+fxkwGY+/f2lBs7DfC/h5QzrgnlT3N4?=
 =?us-ascii?Q?NDd/l9SPRlB7X7HcTaCy4D1asXlhM6Da2Qoftql4avmCrajiTYDugJeRWjpP?=
 =?us-ascii?Q?d9DQTWj7jsha69KxwaPA4LJuMCT2hkB04ph3hHTrbfvp8x+V/Df+LEVvO8fA?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd83a9e0-c343-4ae1-40d0-08dd4fdd75b8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 05:31:13.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebwCXWmCaNThPV32sKyojwP3e6jM6NzqWeiT+8N8ddbOa7XCk8MNygcHPFCqxYu29odeWGVWx+grzlh4gvWEBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com

hi, Al Viro,

On Tue, Jan 28, 2025 at 07:10:42PM +0000, Al Viro wrote:
> On Tue, Jan 28, 2025 at 05:37:39PM +0800, Oliver Sang wrote:
> 
> > > Just to make sure it's not a geniune change of logics somewhere,
> > > could you compare d000e073ca2a, 893598979838 and d000e073ca2a with the
> > > delta below?  That delta provably is an equivalent transformation - all
> > > exits from do_pollfd() go through the return in the end, so that just
> > > shifts the last assignment in there into the caller.
> > 
> > the 'd000e073ca2a with the delta below' has just very similar score as
> > d000e073ca2a as below.
> 
> Not a change of logics, then...  AFAICS, the only differences in code generation
> here are different spills and conditional fput() not taken out of line.
> 
> I'm somewhat surprised by the amount of slowdowns, TBH...  Is there any
> chance to get per-insn profiles for those?  How much time is spent in
> each insn of do_poll()/do_pollfd()?

sorry for late.
we cannot support per-insn profiles for now.

at the same time, we revisit this results on some newer platforms, found there
is no signicicant regression by same tests.

on an Intel(R) Xeon(R) 6972P (Granite Rapids) with 128G memory

=========================================================================================
compiler/cpufreq_governor/debug-setup/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/no-monitor/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-gnr-2ap2/poll2/will-it-scale

d000e073ca2a08ab 89359897983825dbfc08578e7ee
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    775439            +0.6%     780350        will-it-scale.per_process_ops


on an INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory

=========================================================================================
compiler/cpufreq_governor/debug-setup/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/no-monitor/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-emr-2sp1/poll2/will-it-scale

d000e073ca2a08ab 89359897983825dbfc08578e7ee
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    583865            -0.8%     579319        will-it-scale.per_process_ops 


on an Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory

=========================================================================================
compiler/cpufreq_governor/debug-setup/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/no-monitor/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/poll2/will-it-scale


d000e073ca2a08ab 89359897983825dbfc08578e7ee
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    595389            -1.6%     586063        will-it-scale.per_process_ops


our original report is upon a Skylake which maybe kind of old.

if you still want more check or you have more patch want us to check, please
let us know. thanks

