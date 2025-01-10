Return-Path: <linux-fsdevel+bounces-38801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096DFA085CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 04:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFBD16A1B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4661FF7DA;
	Fri, 10 Jan 2025 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVKEwzZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9BD204C35;
	Fri, 10 Jan 2025 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478906; cv=fail; b=g6lH4Z3ZVrkYPyvTORKv352/zOWiQTE2FYxXLQVmsWaG1Fdfw5O9xTn4427rDjJdawbDInx1EP96vURtrSSiY7NHD0XCPe84G9jBExCFISRAMIGOfV/0CgOPHAKqBbpCqNjMQNuVWNoUWqsuYcsS/7XK9LNl5pHoEvrpte4w7Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478906; c=relaxed/simple;
	bh=uUBK6IOww4fy1jHFEVN1LlMw3DTI/5WUD6PhqF8qWY4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eNRDDuCtn24wDrKGwumLfHhzlN1rTEKHk7oKaleUK0DcLfrlsnoSttKkX/raPvDBNxgwFFRzq5uDboejKAFPj4246M4BLudTuUqxzPOv9Vdp8usRNBHMBJxiPx6RkdJ0E+PTu9nGXk/RBehc0iZPj54Rzccu21/OT77NB9t+REk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVKEwzZ6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736478904; x=1768014904;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=uUBK6IOww4fy1jHFEVN1LlMw3DTI/5WUD6PhqF8qWY4=;
  b=AVKEwzZ6lMNw6O8T3q2zab35NPvXfJMRjJaogbX+c5dcK2vCPxvH+iqg
   9zBkUvvHOmcGm9AQ8+LOOAWFLNkoQa3ao1MS/xwjHMrGAKHSZXylGo7Ed
   nsRDaanYSZcgZ+koPzizDLir163g3LQ8MHCq7znMKaL0VGD3gPEK4Gl5A
   AwO2LaSLpd9GZURZvfBXkHmO2nHJEB86ig/ItiBAlz38b4jVm5zL+8CeJ
   /xLgLHyNnGiFH4AFqQo66xV2YripGyDuQQQPmepfPiHVqkAf4pmRYbPdj
   QvmrTGaRIQAfpgoCQmI4yIoyvTwW7h/NojAvzR1jvGSY/af29l7SeEsYG
   w==;
X-CSE-ConnectionGUID: JJhFxITORMe9MNyFpbwZNw==
X-CSE-MsgGUID: fuw0qRsAQ1ujs2ynLO9MhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36650886"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36650886"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 19:15:03 -0800
X-CSE-ConnectionGUID: y9Z2kTRWQhyadQeN7Q/OPw==
X-CSE-MsgGUID: cR07T4AGRMCHmSelsEu44A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="108645625"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 19:15:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 19:15:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 19:15:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 19:15:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYqV52CX4Lmz6j0umqnexRFbsYs2XOeE0eSFrpT3sPnVeEilwxIavLBw4Cmjix6PyVMuVIXPCGbwBfVsMZqA38q2HtqyaSTMZ7ZCFuR4BWM+uIW2Sq53rKFO56A2x9J4NZGMsIYz5OFWbVnwwsY0X7d+Ed8rLNyNFjPEijzvBZeEWqNxfqtb921XFu3kMPLatohmB+pzNK85/4CwPQLPtp6iumbZJdmrp1jNBwe00yDoZ61V+KwDDC/fkAHniZXfcaNmWz7Pr6TG9QZ/yu4V7GIolCsMBXX3EXAsm35TzTRVwmEOtNy7cRo47rk1BSkFKv71PD52UhFxZKlKbtgfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpDIBGE9WpJTKRPxfMkyK5h4GXHPotWKRgpqKYYKYI8=;
 b=uVoxqDjWRWWm+NvKZ6M4jVn5NuMXLHW6cizfNVBxpu/f9ptpw/OCZlwOFIKaOUtTNcdPXhVItjkrb/COWSeSC2RJv7PyFmVBwRw27akqJowqh9Za+bM49qDM3bMHQkfm7NgyEHW+RFGISc6iKLmV4zP6uy7Spehac3I+Vb/zM2IDnWoG63wM4ZLH1Nvq9L3dVIVbBBLpDWyDY4AT8ub/duL5DuY3pIWtDYYObRIczCQQsW8pYlO0a+HIO3yL6jCR46x4lC3uQ6CW4zQw/riXmCB6dIEKq+d0riKxaVhA9FMrA6fNJJNv9ngLYRqTci2+2OlXFIahubXY0NJRSRlRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5770.namprd11.prod.outlook.com (2603:10b6:a03:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 03:14:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 03:14:59 +0000
Date: Fri, 10 Jan 2025 11:14:51 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [viro-vfs:work.d_revalidate] [dcache]  077ab1260a:
 will-it-scale.per_process_ops 1.9% improvement
Message-ID: <202501101058.cd8beeba-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e9688e-fe08-49e5-8a5c-08dd3124f778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?tl2Z/fqTrHdI0aT0wvhVChUKXguH63tPRTieivOb+C8h+1b/AzRLBMx6x2?=
 =?iso-8859-1?Q?96lKkWfwMi+HCw1MXyU1VwYo41BstHlXxXYsd1YeIUQuvqDABdeUbIw/eg?=
 =?iso-8859-1?Q?TkG8TREtJ4f6IBP60ahMGxKRRyFUbzQueaDhnfpu5842um4O8sIMqC/siY?=
 =?iso-8859-1?Q?icP6tc/vTFQCymtpu2IYH0g+KP/hxUZmartxAryG463h1PzmaPD+6ZTxVR?=
 =?iso-8859-1?Q?VXGQT+9pUjTLvnQMSXIct2xaZPAZeJtXRW6WFExAHrFZwya3h4xcOgfkjY?=
 =?iso-8859-1?Q?UB0uDBqCR7O3TzZ/FsyEwhEZ220u5lSJmuyfNBSqX4exTn8F1n2SQv34Bf?=
 =?iso-8859-1?Q?EVj8YnxbhpU0n96hMar0lPKjF3GXYD0XNZjvMxUbU6FBCpKYZ4lDJ3LDXa?=
 =?iso-8859-1?Q?Zsrt2BtlF2ymx0xjY1KwMGZUJLtb429heHAjPSgZ+sNmal0/0vFw1HrHXI?=
 =?iso-8859-1?Q?FToD1soM4SeDEWmYvQ5wyqkHm5XBFUBF3i8xd5L6t81kFdDmjAizF8Kw9P?=
 =?iso-8859-1?Q?ROobFSlG5Nu/kWr3Q2XyhL/496TnaGtX3i/1sgBOe4EM43N+cYotN0XTvB?=
 =?iso-8859-1?Q?NiFNmAiEIbOWn1At+pbXKr2kLtYKNb3o5851ReiJv00yAHkuDalruPhdbU?=
 =?iso-8859-1?Q?3czIzkJLAj+nVgYJcMin8mlUBrNgKuM8kCHkQK028CW67s6WJGo0xDZ4J5?=
 =?iso-8859-1?Q?wxmbUNaJNNGDQpzrxXD+2+I+AcX/XjSfjDAAOxPUqaZrb+kPBds4U5n4QV?=
 =?iso-8859-1?Q?uGpvx6vAOw5NFxw5mA0Ypxm94XEdfi+gWRVNbMR77JVYxId36x20ODxgmt?=
 =?iso-8859-1?Q?Fp86RXUynaY2g/dQBtRKDTCHYxxnY/kHLdAe/74jrh7yuNtti2yGiiXbZq?=
 =?iso-8859-1?Q?V/aHbpAQgDwtpX+okvHVXRBGCEjzQACYzldLuD3LyqKJfexVBXWI8sOwFF?=
 =?iso-8859-1?Q?1xQpUC5tBeeSeY6aCMeeU0/gkfwRiYaptnAfieEqoPTdyCRpsSI3tkyzVs?=
 =?iso-8859-1?Q?fs9gcIu8yBfr0W4EqJ08BhpipeIZ8Qxjz3awDuqCB06YCsz/frcgDfkj3M?=
 =?iso-8859-1?Q?CzSiKB+vG8rWush4NqnB4WYwRlg4GJ7cAZNSnLpbksqSODPUsx5uJoT3n0?=
 =?iso-8859-1?Q?ds9+9sTwKMcX53OOeax3/f2kZh34MQcvxdXLY8rW0O7XW7e4XxV3kjOybK?=
 =?iso-8859-1?Q?5+6m2COKB5TFgBe4SifatD1RbjU1sNc6ofGll7pu0LHLPcoVyx7/yW43TY?=
 =?iso-8859-1?Q?xMRlV/ASD/bh1TT8k8K7ocbHxLGRCEWFGkoY8/AgJVR6keggo89oW+xxSG?=
 =?iso-8859-1?Q?DSbIF7MFIbnjddlCeVfWmHQO28MSBR4psm7xlaDTUsIUlMEPQeRv4MNw1+?=
 =?iso-8859-1?Q?cuTqCXkLER8nWAtSOqgclBfr//Q2TSBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?J7NAycQJv220D/e4LOgmK7A8S4dxM2AJv83IXI9JN5hXcaL0e7u1TjfhYI?=
 =?iso-8859-1?Q?JKiMVFGAE6qUvV2cmanAgDj58roYHWSwnjH28UXU5iE9dfRS4V0r9tcZCb?=
 =?iso-8859-1?Q?a/YsFCHrsJLV0XQMipDvXxENVfTv45n8tJSRtwTaEuUV/yBxG7fR0SMqnj?=
 =?iso-8859-1?Q?JrmSExIXU2GddNioQMnQ0wMv/D//o6YVOXUNBv9cbhao9E5nLwPm0ka/yv?=
 =?iso-8859-1?Q?HPykikHqbmcj1/Z++dnBsXwpylKqgoVgYEn/krke/wnBzPdH8JqWmhO7HK?=
 =?iso-8859-1?Q?9CN4r75TAGEcX+exsMPQY1u1mEVYVxwC6QLCRlMVth2r0DBujfijMzRKLq?=
 =?iso-8859-1?Q?91T9EoWeD4H1oTxpTM75cIf489DjKewG/FdQLRb8+eEbR/shHPYdU+Ombo?=
 =?iso-8859-1?Q?KReLXbBxI8V0xxUBBKjDv23DEf5cLQAtSPqSAqrBgCvCykXoHuSU0w+1IA?=
 =?iso-8859-1?Q?4kSn7hHI6+Kj/Gig+JvTi9o7jsrLNrne0lhdim7Lt9q22/3ONBGda2VI5s?=
 =?iso-8859-1?Q?RRifn7VPXixSUdC1sM2Eud1HqNKsRktSc3DBMqafB98WWLt7t1n5ELw1ac?=
 =?iso-8859-1?Q?ufUV8YPrvVWuodqB5uE0lcrq0gs/AKYhVCGVSsfeiiNJeP39Kz7EYwrhuF?=
 =?iso-8859-1?Q?lJS92M/IQtAb6Ve3L7Ljjx1viFt/fVvgYWqopCBm25C6JmNizFfQJi5ktx?=
 =?iso-8859-1?Q?k9EmLWDzGDrjVwNsziBqoMAfiLFkADOwsMIKQ2VhUeX4rom4IFLwZ5Ft24?=
 =?iso-8859-1?Q?sSOmlcuL28UKtG9lhNxTusI9E95L3n2C2Sx1WK3rWJ/YL6C4tdYPLXiyjb?=
 =?iso-8859-1?Q?QEyCQ7ug2JaQW6gPZb2ffhvNfUU66bZsosG+ci2CCiW1pFuiK9Fm40Qr1T?=
 =?iso-8859-1?Q?JoWDq/7Q0emvgcmSe3CE5yaAFplRNi+3EhRf4C6jbrvALZEhCtLEUUfAVk?=
 =?iso-8859-1?Q?geaZyAvub2Mc4fMKC4Nmu+ldkq9omzbscFFwMXR45czKHwpjhr4oq0qTpw?=
 =?iso-8859-1?Q?qr3cVbmL3U2tn13y6jBIrPo2p6SGjwuwutcDMWZbAgcbFSEtiM1aFtnxb7?=
 =?iso-8859-1?Q?lZr9I8/tLy1EVh6tR8tCP+ZELN59sE8ydCXGbUxDMlls88l7Vh7QQ0vQOQ?=
 =?iso-8859-1?Q?HAV/hBk7gHdp0WlLSOUvxPSntYGUIbOopA1jlHNoWHyhhQcVrApmDwrENl?=
 =?iso-8859-1?Q?vCfIrF0GwDairqSKHGVZHHAv/SM5I07v5/2W0T73kHrLAXFouQYylW0cxG?=
 =?iso-8859-1?Q?LP/r9tEHOjYhgKRM0ZIF+pfA+w15LF+EFPMPB27k6rTGHjAFdUu6zlTOv3?=
 =?iso-8859-1?Q?A3rxdycjNIftRNQzohBHmQZFsf0b3t8g90+GzYhQa/r6S2KeqadkVCiEg8?=
 =?iso-8859-1?Q?0la4k57NcRR2LEJPkJS+iX1Uimixi34n6o9oxDcD73mO8rdykNPzOZi8Xw?=
 =?iso-8859-1?Q?IhCwrBKicK8WhD27Fkvig0IacaxsyBiREpMlFdaXs7s9pNel2rS/o7LbUK?=
 =?iso-8859-1?Q?F7IZYgIcBzMKW/YaoWr6V0yXKwhnPKb+YGSxBD3xKRwRfazLBvCwiKlXjS?=
 =?iso-8859-1?Q?+1bvV2gXinBOug9Zl56Y+yIRToNC02IaoJ9mq5G75o38BrJEdJ1aZgmmrw?=
 =?iso-8859-1?Q?bYngj+7yJofP0ivkeW5QsY4c09tPYVNAnfSOMcxDMGScu8ubaBBJHkKg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e9688e-fe08-49e5-8a5c-08dd3124f778
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 03:14:59.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZekFEzM7esxvhvYYSCsoKJkalzhVbiXRyoC9C+tpJsek/5J2IHVYidYwhrpRCTN5jFi5v6MtnJU/rOMNfBEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 1.9% improvement of will-it-scale.per_process_ops on:


commit: 077ab1260a52068a62a5fb08fa2c5f1d0dcf2738 ("dcache: back inline names with a struct-wrapped array of unsigned long")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git work.d_revalidate

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: poll2
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250110/202501101058.cd8beeba-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/poll2/will-it-scale

commit: 
  cf0cc84299 ("make sure that DNAME_INLINE_LEN is a multiple of word size")
  077ab1260a ("dcache: back inline names with a struct-wrapped array of unsigned long")

cf0cc842995ca3da 077ab1260a52068a62a5fb08fa2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    294.00 ± 10%     +15.2%     338.67 ±  5%  perf-c2c.DRAM.remote
    243.33 ±  9%     +13.7%     276.67 ±  6%  perf-c2c.HITM.remote
     21502 ±  5%    +413.7%     110453 ±117%  sched_debug.cfs_rq:/.load.max
      2543 ±  6%    +336.8%      11109 ±111%  sched_debug.cfs_rq:/.load.stddev
    274.83 ± 19%     +28.8%     353.86 ±  6%  sched_debug.cfs_rq:/.util_est.min
  24387540            +1.9%   24841387        will-it-scale.104.processes
    234495            +1.9%     238859        will-it-scale.per_process_ops
  24387540            +1.9%   24841387        will-it-scale.workload
      0.85 ± 11%     -20.5%       0.68 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_noprof.do_sys_poll.__x64_sys_poll.do_syscall_64
      1.71 ± 11%     -20.6%       1.36 ± 10%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_noprof.do_sys_poll.__x64_sys_poll.do_syscall_64
     38.41 ±104%     -78.0%       8.46        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3676 ± 13%     -34.3%       2415 ± 21%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.85 ± 11%     -20.5%       0.68 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_noprof.do_sys_poll.__x64_sys_poll.do_syscall_64
      3676 ± 13%     -34.3%       2415 ± 21%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
 4.591e+10            +1.9%  4.676e+10        perf-stat.i.branch-instructions
 1.367e+08            +1.9%  1.392e+08        perf-stat.i.branch-misses
      1.08            -1.9%       1.06        perf-stat.i.cpi
 2.584e+11            +1.9%  2.632e+11        perf-stat.i.instructions
      0.92            +1.9%       0.94        perf-stat.i.ipc
      1.08            -1.8%       1.06        perf-stat.overall.cpi
      0.93            +1.9%       0.94        perf-stat.overall.ipc
 4.575e+10            +1.9%   4.66e+10        perf-stat.ps.branch-instructions
 1.362e+08            +1.9%  1.388e+08        perf-stat.ps.branch-misses
 2.575e+11            +1.9%  2.623e+11        perf-stat.ps.instructions
 7.785e+13            +1.9%   7.93e+13        perf-stat.total.instructions
     59.17            -1.5       57.63        perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     71.18            -1.4       69.76        perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     70.73            -1.4       69.32        perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     72.76            -1.3       71.48        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     76.80            -1.1       75.70        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
     43.66            -1.1       42.61        perf-profile.calltrace.cycles-pp.fdget.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
     94.61            -0.2       94.40        perf-profile.calltrace.cycles-pp.__poll
      0.92            +0.0        0.94        perf-profile.calltrace.cycles-pp.kfree.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.66            +0.1        2.73        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__poll
      4.90            +0.2        5.10        perf-profile.calltrace.cycles-pp.testcase
      5.81            +0.2        6.04        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__poll
      1.98 ±  3%      +0.3        2.26 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__poll
      7.25            +0.3        7.56        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__poll
     59.29            -1.6       57.72        perf-profile.children.cycles-pp.do_poll
     71.24            -1.4       69.83        perf-profile.children.cycles-pp.__x64_sys_poll
     70.82            -1.4       69.41        perf-profile.children.cycles-pp.do_sys_poll
     72.83            -1.3       71.55        perf-profile.children.cycles-pp.do_syscall_64
     76.94            -1.1       75.84        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     43.57            -1.0       42.53        perf-profile.children.cycles-pp.fdget
     95.18            -0.2       94.97        perf-profile.children.cycles-pp.__poll
      1.16 ±  2%      +0.2        1.32 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      3.50            +0.2        3.69        perf-profile.children.cycles-pp.entry_SYSCALL_64
      4.91            +0.2        5.12        perf-profile.children.cycles-pp.testcase
      6.22            +0.2        6.46        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      7.31            +0.3        7.62        perf-profile.children.cycles-pp.syscall_return_via_sysret
     42.16            -1.0       41.16        perf-profile.self.cycles-pp.fdget
     16.86            -0.6       16.30        perf-profile.self.cycles-pp.do_poll
      0.90            +0.0        0.93        perf-profile.self.cycles-pp.kfree
      0.32 ±  2%      +0.0        0.36 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      1.20 ±  3%      +0.1        1.32 ±  2%  perf-profile.self.cycles-pp.__poll
      0.76 ±  2%      +0.1        0.89 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      4.88            +0.1        5.00        perf-profile.self.cycles-pp.do_sys_poll
      3.10            +0.2        3.28        perf-profile.self.cycles-pp.entry_SYSCALL_64
      4.18            +0.2        4.37        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.73            +0.2        4.94        perf-profile.self.cycles-pp.testcase
      6.16            +0.2        6.40        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      7.30            +0.3        7.62        perf-profile.self.cycles-pp.syscall_return_via_sysret




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


