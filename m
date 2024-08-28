Return-Path: <linux-fsdevel+bounces-27487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E3961C24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34940B22631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 02:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9241A8F;
	Wed, 28 Aug 2024 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jaeM4dmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BA8F49
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812370; cv=fail; b=eeA4hBWjaf5uxvdgu3z9M/NXXq/BmrAgMGXsbtNIFF+CF540HLSS5fxVGsgYB9umhyEUjngosZaT1sKXSBVzHcyLERKy6U383S0AHW4OC0geEs7+zjY0b/TiDhdxCJDsxgwUYBy7ILdU9H5214JoVRXQBzRyzqyw0ZOc9v6bMKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812370; c=relaxed/simple;
	bh=dPdrFkh76M/ckTsGMCVa333PNqAfk6JrRr7toFLOeDs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZVXjOrHLDGIseWl56yHLho9++rrlgitvQhjWPbkg7Jeg7Ki86Er37vbbAwT3xTt8HIREXpMjuTLnYDHg3FG8Lv6358MCjoebGzOKImHhi6lcTIiRGyphRh/G7lfepJEWStlyeXBEZaZqY4a1lmWwO5t9Rbu3u6MU9I6EN7FRwVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jaeM4dmn; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724812368; x=1756348368;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dPdrFkh76M/ckTsGMCVa333PNqAfk6JrRr7toFLOeDs=;
  b=jaeM4dmnvLQVds7f8vX9rPfbI8AP8tcVB52GWgpXfL9uPZ5p9w0yW62M
   ZnzpFbIaUue9QGkFpqbRT4ed2GPNEg5r5T2jJQkrdIMMJOHr1Fv5soprH
   AK5jHX0uqn4IbtoiT6BsadxSe3jYqePcx9rTqjpEDOoQ9K5Hz4rGmIwZC
   UnIAAOOOK9zfqNledKoLmjGSiHoOnsNrK7kO/ci3hKUrdepHerqsrb4fu
   pfSx/UI7u1tSr4yDX6unaQnJlJKlyY+34UN8IDM7jN6UXaa6a5PJtbtea
   w/E7mvr85lZ2Z1ZjnEPvXlgA6T/Ex4eSt5ueuPYSpLU847K65MGqYkQJK
   w==;
X-CSE-ConnectionGUID: kmOXT4OSSxeU9VDltMsp/w==
X-CSE-MsgGUID: Bls+pLT7S6i05DBYAMzRNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22847234"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="22847234"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 19:32:48 -0700
X-CSE-ConnectionGUID: XI+aCWJ3QqCooFG12p/2vA==
X-CSE-MsgGUID: W8aKPJ7YSYWt94yNOVbBxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63059794"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 19:32:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 19:32:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 19:32:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 19:32:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 19:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qf3Xkyva63ec6ZtPDAIptttxp/wKRvVxYh9BhcnEYw4wgH3bd2V8J8JVQ4zHfdYReRhijND9HVJ/toD5G5X2HKnR1VEBmIEU/Km/UrHWZwzH0pzmIMzab+9sWWEKto31hlSIUOUEr97X7tZKItePzkiZTfsvLimPPU0C2M6B8hKfLrVIIi83KxB66OLR767a9iEp1K2W9LdSM8UOibkbtlUKK7ohQc5u457gKJBbma92RCnL1IZ5D6je/tAagmzg2vaUdKQbFuiwSqrzBFPO690gW+/7+g01Qg7EHObQOmcfTaVSsiQ8Kn3MHcIN5WyBq4oknTV9bj+OdjE0nuYiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ3qF1q7hkzoenmBNPJanbHNGLOfuhC8fXMXtvNpzpk=;
 b=Di4Zx/uEpo/me6v7h38QtM8LffjPRBkTHysgaW6XZX1EJXJuQ1UPyydkU+8zecIqfsx99/IPmPGOhxYXQ0IQo1t0+u3JgvMSU50mLunT+pFDA8AKPII4oQNB/GUleMIe9cNcSE5l58Bmm5jls53gMyF45tfWlT4VrMb6qRKDY43irC1TLkBsSmgzVmy+xoVum7lnEsqLh/JISlMiXAJzGZVtRyx9VldHeuV0e3PzKEM8whN27HFR54+0WHVZyURuGpTzwBDBpRfnq5YhFPWh1WogI1noyaCcmwdJEcTzBfLK9GhKUH6oxQyQ5PYkYu8vvvqv717793efNDILTCYSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8581.namprd11.prod.outlook.com (2603:10b6:408:1e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 02:32:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 02:32:44 +0000
Date: Wed, 28 Aug 2024 10:32:34 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [brauner-vfs:work.dio] [fs]  155a115703:  fio.write_iops -2.3%
 regression
Message-ID: <Zs6MQrimwwCVCbVk@xsang-OptiPlex-9020>
References: <202408271524.6ecfb631-oliver.sang@intel.com>
 <20240827-ansehen-mengenlehre-13e54cc52e38@brauner>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827-ansehen-mengenlehre-13e54cc52e38@brauner>
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f6c7bc-2174-4830-e067-08dcc709b24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gdoGKlQ0lCAuGDwNcD0N/BFMIHsQwxfPKuFwcYEARFjkDWY0irqQ8M4oeYzQ?=
 =?us-ascii?Q?Pg+VlOkEQs/T5thuBAo6bP9FkxR2LPaqyMADJTejR/ZTnTWx1Zwslald9SKc?=
 =?us-ascii?Q?5L08pUngASa1DDaZCANwUvDflCfxHBooH3xnshVUWhzFek2z+GTuQS9D0Z9X?=
 =?us-ascii?Q?1/wsbXtSoLVxDkZKxZrlRTgLfdEs2j/X8A0S0tIBybIMg2TI2zfd504Aw2GH?=
 =?us-ascii?Q?MRdmyTz8C0naQ5wFeogieBKU1zpGRRnptu3kGJPW9/vRWvedLTC8Bg2XoSdu?=
 =?us-ascii?Q?0OS6XPDjTg7WLIFBHPLHGzd43T1cuSvy/AgFn7SUIvNjj4tDqEt3eYS2YzCc?=
 =?us-ascii?Q?vftrgBVzdjUvCuNY88EMtnRO9iUXbggRkgaUjCgWhZ/41gk0h/52QHtZLM4l?=
 =?us-ascii?Q?diEDdIExt49IOHUOa89o0Nf1cpDZEfmWe5Xe+nkH3mXXGFGFa1+oEuwCte3j?=
 =?us-ascii?Q?t6ryOVZoJ3l+OTUC2aptfw1TqAMSPxSBDaGcNCTV4zcqD6taWel6ez7XRx9/?=
 =?us-ascii?Q?VXWWnuqFrG4ECeSmSo9w67PscWlMhgwCEhC4tr4XmpE1dsF/Jew/XjoIpVoJ?=
 =?us-ascii?Q?ofRAxyD7IK7A4fr+0A1iUP1kZQQ7LzDb+4wAYvwXCgQhW6/Wq9XUZK7EZych?=
 =?us-ascii?Q?tKa7jbgpewzmlXhpxW6sVRuJCquPHfvHuAUztpeK3Ff0SRmTSff2YQMnEmUn?=
 =?us-ascii?Q?hbouEO6iahXCvUYno+XpVsEjjXShheAFyzwJk7j87uWiHrYoMp+wpkYbVdAk?=
 =?us-ascii?Q?2w0xfS0GbRAASWNXGRMH1SQwCB4nEsEazj6jfenNIJu+Pkcehkzh7hGewGvU?=
 =?us-ascii?Q?Nc+B6lfgif7Ld7hCVYyFvdfmjlNT6JJ7fc60N0pU5leXHekpXmhOsxLLDhOt?=
 =?us-ascii?Q?ERczbIf+E5kUxaeAykKlCn83cDt81tw0whlPmzJ8ZKNef/2oZJd1Q3DsOvWt?=
 =?us-ascii?Q?xUIcyaRhZnxKcOJWjTNG+SfF+v5+3r4QnYEMQD+LJzhWHcxQ+fnCHo8MZIRk?=
 =?us-ascii?Q?1OFdYJ3++uIMenuPRpCQNUG2LtV5saK3Oq16OLENdgmSnQEQ34jCGOEMvwlV?=
 =?us-ascii?Q?b/gSBgEvNQQXqR8om5/nlJhGWDG8aj6qQfgZjH6QX+RnfafAIYhKhVv0Y80m?=
 =?us-ascii?Q?7Zw/eotBOnheOFZbfIdqDi/jQEHg9ZByNPhBaprLDO+bz3SlHslBnmCtVi2G?=
 =?us-ascii?Q?GYjW5QHq/jx0X62mq/uAwHggMpHrr/ahnUZn5ulMJjgk1gj/7iGeqlTUMnjp?=
 =?us-ascii?Q?PqcDLTBfmcVakAZuVlEfrQ/xVl+BZOyGviqbwHdRbyiJT9Kg+sIY4mhCO/0O?=
 =?us-ascii?Q?OT4FqMA0TUb5vDd2NghvbGlLHhUJwut5Mk1dVGRhZRDDUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O9FRUhvoFeedN0TiEJSVs22O7p+czleQ2DZwaOZ5NnmQvprW+zofvglQAbTL?=
 =?us-ascii?Q?iQ52SNzd69NxmCnhpMcNeGpLWjx+B8zQd0MTeKLRDQ01CDK/ce9gX/n/Qfq8?=
 =?us-ascii?Q?3wg0yy9HKkgliaRpNmGV6+HOTJeyiH0LQZwdmAA1twoqNZeXH7DQfsHCI+C0?=
 =?us-ascii?Q?F43xa/gWginclxSXCs6AGBEHWIFRX+Ygc0vU2Nbcque+teNbdTA07L1gXUsL?=
 =?us-ascii?Q?iEQdRmyMZHAS+oduC3mQhjgq4cZvxHQT+2MlwraZBrJjv8b2wb/r+HEy5F9V?=
 =?us-ascii?Q?B5YRTo+eufIOZHG2XwTMpdZX1Lwws9euiRFMFPSMP6alfHNhJu5dJFdB1oQn?=
 =?us-ascii?Q?7J9lokTyei81mWWqD20OiZl6Q7g48b+e+oCPfxXbD0S7bAtZvG0upx2YwsMS?=
 =?us-ascii?Q?eRo1vaYXYQbR+mL2Al6YVNvHok/lA1kdTTZsdDjAnJmIDENBlcPnP9bw6r1z?=
 =?us-ascii?Q?oVrXnXyp1EgBChrznPnaT9i3rRFy5JN5qQknfqKjmDU55E3BrecoQ5F9I3r9?=
 =?us-ascii?Q?ZyIQlLhy1cT74SWE5l2vyLUh1yYHDI4Y5Os1O6naqZ3Z1zT6NE5lmjDEwRyL?=
 =?us-ascii?Q?bYYNLUzSMNX9fC+iRO+/mhbk751a3U0Sbd6s7HnJPVKzxDtGVn5oEY2UsEWu?=
 =?us-ascii?Q?GJ7zGSmKls3qk8LPap2lpfy0vNRx2NplxFQvt8ImvWPIFwxZStmjwggsbPwJ?=
 =?us-ascii?Q?4pDLMAZ833pRn4C7/zBiuwssCBIig8tTVibdlE6Ftw07LUQBgkAeU9FC8Oh8?=
 =?us-ascii?Q?Tpk4DH0rveGJzptlfbTVBN6oNUxx2V5AZjHeBcOFzWnQK32UYDI7vCie56TF?=
 =?us-ascii?Q?N5Gv1ZbYMoqX0FonqypBQKKUpHttV/xnTClZX6+QAMm7fczMvuto0H9jF5gI?=
 =?us-ascii?Q?amHKrPRhY2EvACh2NH3ozPtx2G3lscedhQYv83lBtjxfskrBsU56d0uOZnL+?=
 =?us-ascii?Q?G5bY5WISx2FAFpAkh8F3EfIC0WcAb09yDo6pp+Dek3HdBbdl/c5g27FoEFMr?=
 =?us-ascii?Q?3NNvmuouV23jKimpMnpD4WFMPMlbu8sPvQ/LnWuoVZxb/9TYePwzPrJ7rXk4?=
 =?us-ascii?Q?8gls6hUR0JjsVsKd5GgaQ+jzJRemjsSsHdHlFk4YrEGJruvIWaIMEPi+0uvB?=
 =?us-ascii?Q?w5vksO9Uv+9tSB/9ZkxQvNmUAeSCKww+gl0+AFguTqsDmoyg1TbRO0MICA2t?=
 =?us-ascii?Q?9dFftHINLFOlowaQBD9nXbVqSDq/i2U2AOJBOYu7cEv27hR+o0JayQaUMFMg?=
 =?us-ascii?Q?lMV824YJpNuggP3n1pD6DX50rFCCzb2mj5JxXv5YoGX8QQGRG0CDNR+Fy0HX?=
 =?us-ascii?Q?K3XliHHdE63Oqf+X3qI09Ybsmnim7GpBlQEuz0gcvk1X4SfxTBwvVUpu3dut?=
 =?us-ascii?Q?xFifNLDilnid6S7yKpMmwSEvjq6ieJMAlf9yBdqi/wNoxqxoK400RDl+WUu7?=
 =?us-ascii?Q?iaOGubGdBnRrdZ/NPFxMvMO2R+IVKDK+hI84SGuNI3/2UKAWoqiw8g2oltgH?=
 =?us-ascii?Q?Qj7zPJbvpBNgs+FjJlgCSEH8NJKNI/VVnhC4kQNXWfAMeAJgQKwDT/G2FBL4?=
 =?us-ascii?Q?oSt7u8uupcPfsXyASphvROVow+xqfB6d7JOMJoNzmoV8WRB2blqBclEQL4gL?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f6c7bc-2174-4830-e067-08dcc709b24b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 02:32:44.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5v3LQ8b0TDqesVpLFOHplqnj9ziLWHYTZPmcx+jgWuPQ1CJ8vS+H2EvJtQX+A0C8AHCIkDimxebt0ahNHk4wzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8581
X-OriginatorOrg: intel.com

hi, Christian,

On Tue, Aug 27, 2024 at 10:39:23AM +0200, Christian Brauner wrote:
> On Tue, Aug 27, 2024 at 04:33:55PM GMT, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -2.3% regression of fio.write_iops on:
> > 
> > 
> > commit: 155a11570398943dcb623a2390ac27f9eae3d8b3 ("fs: remove audit dummy context check")
> > https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.dio
> 
> This is a dead branch and the patches in there have gone into other
> branches in different versions.
> 
> Aside from that it seems extremely unlikely to be related to this.

thanks a lot for information!

> 
> Thanks!
> Christian

