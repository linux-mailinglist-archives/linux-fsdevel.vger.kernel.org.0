Return-Path: <linux-fsdevel+bounces-64651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE866BEFFCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 10:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0582C1891B9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32F42EC0A0;
	Mon, 20 Oct 2025 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImI/Z1vZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4C2C1595;
	Mon, 20 Oct 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949407; cv=fail; b=VYb4a00AGcAdPjknTxS1dY8A/SElp3rhzc8oRg7WgOMansmV/Ad9CX8qLtf6IB3x868POPn/RmwiMVnFP37PN32dF0WgyNaVwGZHTSvndBMEAdxqsbhyy8PSS4KI+uuDz6tKMQmkKEzUmt4AMsmBn8PxYw3TMhBr5nFbVq468YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949407; c=relaxed/simple;
	bh=MV/LBnfTj0kC2fP55u0yIZCHZetX0+SrTViLUHWbdzM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eGW3p8ndwqhcR85N1gXr+Ud2Mq/gM4jJxK68ZwHd6aTjkhPwrcyG2s+omhQazeThGxsxAGz7MBjKyPc5iDhB3kF5R2fxffPObg7VYjFTMf6C3CjZtHAbHNyTwDf5AADb4hDLh3IZq7ClekmN0MNKu++SxRWZDooUEVzj88E+iJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImI/Z1vZ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760949405; x=1792485405;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=MV/LBnfTj0kC2fP55u0yIZCHZetX0+SrTViLUHWbdzM=;
  b=ImI/Z1vZrD9NE4TuWJXqqZXKCqzDn33AqEpcixeXQic8UxEur8w1IrN0
   NEYHu1MnAnDroWDeF7XTq2Oco3NhXQ7+GK6J/W8Vr3jTj/uNSGGZyTp92
   tLhlFzF9rL5nCJDXgjLBZ3YDSie9zCxbgE6ND3lB618qYWG+2WC20/OG5
   zuI2lc+4Shxk6vhNCCxKCNNM+Nq8d/UkwMIzuC37+7hjaMUllr2EsneNf
   kQwm/suKzehJnI2QE1vshETThzxqR43qAY0lAJeHc2TiIOQyvZhWr470P
   rGpSLfUosazDqLeDneKSNdlqqbaDtj6Eg5ttiJe828MO8tsMCvfxakSUn
   w==;
X-CSE-ConnectionGUID: wIJfHBjWS8q94Df56l55kA==
X-CSE-MsgGUID: dBrra38XSJKVN8FDzR6ylQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="50631625"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="50631625"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 01:36:45 -0700
X-CSE-ConnectionGUID: U1qL9ifARIenN/XvZdbTIw==
X-CSE-MsgGUID: b3xWaFFSSJSv79oXVk3bJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="182978759"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 01:36:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:36:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 01:36:44 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:36:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv4073F/0Bp2qW9Zc9O8QygSAJ7YcCcGyrQLUA9eaVvcTNs3Phqatb6+Q2lm+C+Wj4JvLY6jPanDkb9e1UcJJ8prukXLTJiMoEyf62rHKvkAu1ofa9rUbW3KUeoxj/fOCzJa89dj52ZJ2abjTmf7Z/s/a2TKIk5nCQtdMzHVMcGczSs3oI2WPDk4qgLFCLBGQe3UnD3ZrSAv+AIfxJmjw9MWVbpSEDKdosh9ufjrd/nDJZOoA2ZcdfwNhsLkF0wqnhYtgxKFmLiL1W3SCWidp6SxgSERn+32ay2MFTM5GbYN53nzu2tABnx8MCaFtfXMy8Gjn6GTpSS+s9Z12PDw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXh8ban+v4mkN67BTSB5OQKd/4jZrWcSb4ei5XA4oJ4=;
 b=Ovld633lgU6cchVlT1H9Id1UcYplGlrVmLE0Q5Mi31z09HNLlCBqwC8oPoZIkSncDT4kCQVkR53zursxjqUOy0fbeGozy6KXuEM0lY29YBQDB5YJlJvFrq+tseqGY9rFq9SNZDfSq7u3YUmOdFblMTmKPO/dcKKAhV4HLjBwRD5Ohr3zWpWwXyZoOjOOcK36dO8D8zx9FlKAiVBCTcom5ODJtHUIrn2lgiVyimXO2KRW0BNzRpDDXYA8+hXqqIzxvszgIA0iN13S7HNNIzLbI01jAHzNl+dkl9fiI3tHqtUtRzSFrgJU5GeDGJ4jPemtfF8z/FNWiYyVX1edOec/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB8119.namprd11.prod.outlook.com (2603:10b6:806:2f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 08:36:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:36:41 +0000
Date: Mon, 20 Oct 2025 16:36:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@ownmail.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 06/14] VFS: introduce start_creating_noperm() and
 start_removing_noperm()
Message-ID: <202510201610.40b1a654-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015014756.2073439-7-neilb@ownmail.net>
X-ClientProxiedBy: KUZPR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:d10:33::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: c9585fe0-c8a1-4a41-b589-08de0fb3cb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+kM2jezQWFGiJcEHv8uVax6P9BTaLQzN/7j8Nqsd4VhPWuFM79ObUcT9nvBS?=
 =?us-ascii?Q?eT8fH4TL0qeTd2FJAZJumlR4/RGIpzDWc0EXdj0yJjU+gCswUhXGHoac9gXt?=
 =?us-ascii?Q?x386yzPVHv6EagZ0ngjYWrVYLm/IuCqe3WFxgQogiVJ4w832f6jhCBwGuKmX?=
 =?us-ascii?Q?/WyLxRau+uL7e67wdTTZvmSCVHMpKaioTa3RV+18jp/hENAApiBR+LvefxcA?=
 =?us-ascii?Q?2H+RoQytwr51oDypiCwrj5APEKwqN3KZiITG/SohRhKDryvk9Dp1POfPNQEQ?=
 =?us-ascii?Q?vQlXpMKKDA7bg/6T3bZI055fVamnX3gcG7I1kAMVvs2K5meFbXRs3aLXqMM6?=
 =?us-ascii?Q?a0q7o7nD1GjD55B62sT7r3aPi9SNMz3f05vbboIctuj2psH7aYKQ3Pjs8MOV?=
 =?us-ascii?Q?xc6m+modIklSmhoA+PiV7/TP8yulyF2vReIQQK0yB8si16j5oz9LNF22M/Mf?=
 =?us-ascii?Q?dN89L2dQAdVvs/01uQPNAI/xcYwHB/LlhMupNbsrdY94ZqF75HngvYM0LsfW?=
 =?us-ascii?Q?4jR/R8iKh3LPhQ4CWOfQ7634hOLKMuiygXj1izT/HkD70ASMmv0+CBVpKN2H?=
 =?us-ascii?Q?zmyf7egMY+w49uKEHcYXQga1Ix936YmXWMEm7ML7EemAAqGhUiPEgEpjrpp2?=
 =?us-ascii?Q?tHoZawNM1OlBY4ozcszX3ABVKiTagMXmRsxETIwAOSj6hAxhsBZU3iOI/DxH?=
 =?us-ascii?Q?d3UqyF0mv5W9LdeIyghehFhM8UB1spvSoILgvnnNaAX+NBK4OS5J/B+tdGLt?=
 =?us-ascii?Q?nzEi2z256ByKQD8ApWog+g9a/GOBzuAX4J8ULt2OHzJYcwatb/MO/D2PvKrq?=
 =?us-ascii?Q?fYJoYsUQW1A8bJ7RwWsOYvJWzVeyT0WVD4Old33vB44HIu8Nz95iFRYP203Y?=
 =?us-ascii?Q?f1Cc9MQwv6PhO4WIguY1Pv8a071zToL7mq8JkCLZZGe1Aq098MpXHcOb8jYY?=
 =?us-ascii?Q?tBoWVaU7/X3eYIZQGERxLHtXh5icx0Am+2NUIuN5udTiiiUJsLgzAcgFuFJX?=
 =?us-ascii?Q?ZU00MGhCZdVJS2CXCPd+2UOXULhwknxxi8fisqEuHDp5Jd6af3w+KHnF7F4i?=
 =?us-ascii?Q?RYE3RzE8ndyqgl+FSjWaJgOdnFkazV08bQnC0SomenJcAm7NE5WiRG14bW4e?=
 =?us-ascii?Q?vb7bLQ+cBp14BZKE56XgHNAWTYr7HzzlwUjXdnGJw1dfYTenDSXZNi5Qoyx3?=
 =?us-ascii?Q?LZnLH+bWdzwXglqHzlzfu0/hRM0SK2cm9f8kaxaOVYad59959wrPQFbgNJZT?=
 =?us-ascii?Q?kZ/9d8117ZW08UbdPY3m3gniaC7bWRmRUPe/Z9F/Vi5ruM9U6p0qWrsfB23a?=
 =?us-ascii?Q?MJGlWGASXekV+aKyEv5Eemh4NKmifkNMDaIwD3bV+/joPBDD7VOUOxQR1eMV?=
 =?us-ascii?Q?/bJG4NI8ay0ly52xXc8YU2JZytm/aGIAo2Q8Jp2VuCqIjleK9HUgCN06KYcA?=
 =?us-ascii?Q?CeNMjQBx7+myDRDuQWFd+Y41anl7G5pP+co9n2vlOpF3tA2IQvqzZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9mqck7LUv1iT9Fbn2POk36sVvxyrgo1hS9vc+2m3x9nj/UFSSymUG2ZAg4B4?=
 =?us-ascii?Q?ZSNugW92BMDymVOnohahGXECYwg/MxxVac0IE5eFmyoeuvGnqwNAW/NZnj/q?=
 =?us-ascii?Q?ZXGlc8uMsZVQBvoRhvtPNJDIYinmqvwKqQObzxanhqhvRLNTtQi7wBEvqfV1?=
 =?us-ascii?Q?PYG/0+aiC57bZrZvCxg1DfOSTO0Zk63v2bltVbat9pYkzgz9sI8OS95M9e2o?=
 =?us-ascii?Q?6ctYGD2x0PAddA9cfAwwNIdtwuETV07vWYd0tyMeFfbfftE9Ezeo0m0u0eHd?=
 =?us-ascii?Q?G/sPrvibaKwlvd93BH8AAUm3vzNxB2B7qizNpOZfPLGHCpj/Wn6+LzRdsuuD?=
 =?us-ascii?Q?Y4/A3GMJiVkqaw4ddd97MK59qbVE8TMzOgdfDjIzu/elmU6DTwUTcKdd0M2B?=
 =?us-ascii?Q?BwRzK9Bnm3p+KLRaZyJO/3jiJMEBLB3vofaOSSasILRqqgxNR1bFxeUb+Cmm?=
 =?us-ascii?Q?QC+lktU2ZZEhjhVa2l20/s2R/6k82nzpgTq27k9tZ3WLIk4/r7gFOq+GpG4h?=
 =?us-ascii?Q?MlBrC4QkmPVSQ0WN2BgPXwfoSFC//oSmFcM7PACYdtqgAtNkX7R8D4wrFSo5?=
 =?us-ascii?Q?nXFMblrwjqY5fnwIKZKNYumscUvho9zGHWYty+VVlCAW0xj0jUV/C9GvPshz?=
 =?us-ascii?Q?jq2d4MQlqvb1IhwTXz9obpmS29fOiXoJvuOFYqiHNeaQ/wBOJoYl4RBlEB6Y?=
 =?us-ascii?Q?ux5eLP3Znw4pCcAUTQoA8ulHr8DB7r23U8qpeK3nV59eluCfQ5NOVVUhH82S?=
 =?us-ascii?Q?Knvm70rc9gXop6R7x9Y5NIKVNC7COoIJce1uvBOoA9moZNQ5Vljdt8sDRJmN?=
 =?us-ascii?Q?fpCqdKaEKkvP0I9blFE6jt3Qai4yQSRw3QY4owngF8UAS2HZ4NxWyJnNJYgS?=
 =?us-ascii?Q?pgrFCOcN9umW1mPJ1W2p9e4FMO9mU0zZVgXW76BW5qbploMwXCNm97/hxEau?=
 =?us-ascii?Q?TZ+3l66QEfa30in9xUTZf5jSsp8bES6PTdu+SY9pRL7LM8X0u/K78d7CFMV2?=
 =?us-ascii?Q?jJXXCvjB9XFf42HqHC9vq6pdqn26r5mhSBoyh8jHRz7/67tGZ8+bvkgNGPTB?=
 =?us-ascii?Q?6fBG3P/cKCKwS6jJNBF+jGjgzsPuSON+Mv8xtc3qenyBcwwTrxohDtN0QNd1?=
 =?us-ascii?Q?0Ibca0Ga4K6Wsh7M/7+eRgghuU79v8bLdE6ht3yd3JLYQBdAR+N179ZPUOwp?=
 =?us-ascii?Q?ck8HcffvO2Z3TOqlI1xA1HnXaBc5iR/mc0EKdb1U5+ee+mPR0hp0s1JWKD+u?=
 =?us-ascii?Q?lahLTH9sCZasjEzUPNgLTnCDO1uWy1nk0yn4YbF23XmdatZ7xh3yIsao5h92?=
 =?us-ascii?Q?zOyFLdV6NmPFQRNiLGudWVSTpb8jtFGWOjVzDhMV0QPAG4sbJGhSZw2zmsgU?=
 =?us-ascii?Q?N9mEw0xGZmiDVeGewuAFaS4p6swaYbLzdG7teLkqdZ6Xgzx+P0YGVJBQyEbs?=
 =?us-ascii?Q?p2GLTe7HOZQD7zLNCmJIH1jXrtzFlQXk558z5LatsMyifbI6n9m4Gg6H5UaR?=
 =?us-ascii?Q?//vKdF1eM73FY58h2Hx/x7kBLTitMBtPMjh1yaEiEFecn36e9eE3HpVVRc4R?=
 =?us-ascii?Q?IpsoTSfw0WNk7nAk+vjfJ1xp6I9nxwTYqR7aSvWgXSbVt9A+w4wNpkDAfksP?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9585fe0-c8a1-4a41-b589-08de0fb3cb38
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:36:41.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UjQ/2b/fWW676a0aw/3OIND+vfcISIe0r39+6m5zZtx59wJzDM6rZ9ef1QfIWQoM2pztqXaAgOyd9YaGV3Y6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8119
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_fs/open.c" on:

commit: dc62b71efff8093d50a9e1f7321cabcb76ff8447 ("[PATCH v2 06/14] VFS: introduce start_creating_noperm() and start_removing_noperm()")
url: https://github.com/intel-lab-lkp/linux/commits/NeilBrown/debugfs-rename-end_creating-to-debugfs_end_creating/20251015-095112
base: https://git.kernel.org/cgit/linux/kernel/git/driver-core/driver-core.git 3a8660878839faadb4f1a6dd72c3179c1df56787
patch link: https://lore.kernel.org/all/20251015014756.2073439-7-neilb@ownmail.net/
patch subject: [PATCH v2 06/14] VFS: introduce start_creating_noperm() and start_removing_noperm()

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: x86_64-randconfig-074-20251018
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | 04e655aedc | dc62b71eff |
+------------------------------------------+------------+------------+
| boot_successes                           | 9          | 0          |
| boot_failures                            | 0          | 9          |
| kernel_BUG_at_fs/open.c                  | 0          | 9          |
| Oops:invalid_opcode:#[##]                | 0          | 9          |
| RIP:dentry_open                          | 0          | 9          |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 9          |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510201610.40b1a654-lkp@intel.com


[   58.472072][ T3648] ------------[ cut here ]------------
[   58.472990][ T3648] kernel BUG at fs/open.c:1116!
[   58.479432][ T3648] Oops: invalid opcode: 0000 [#1]
[   58.480255][ T3648] CPU: 0 UID: 192664024 PID: 3648 Comm: trinity-c2 Tainted: G                T   6.18.0-rc1-00006-gdc62b71efff8 #1 PREEMPT
[   58.482041][ T3648] Tainted: [T]=RANDSTRUCT
[   58.482680][ T3648] RIP: 0010:dentry_open (fs/open.c:1116)
[   58.483443][ T3648] Code: df 48 89 c3 48 89 c6 e8 90 fe ff ff 85 c0 74 0f 89 c5 48 89 df e8 82 92 00 00 48 63 c5 eb 03 48 89 d8 5b 5d c3 cc cc cc cc cc <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 66
All code
========
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	c3                   	ret
   4:	48 89 c6             	mov    %rax,%rsi
   7:	e8 90 fe ff ff       	call   0xfffffffffffffe9c
   c:	85 c0                	test   %eax,%eax
   e:	74 0f                	je     0x1f
  10:	89 c5                	mov    %eax,%ebp
  12:	48 89 df             	mov    %rbx,%rdi
  15:	e8 82 92 00 00       	call   0x929c
  1a:	48 63 c5             	movslq %ebp,%rax
  1d:	eb 03                	jmp    0x22
  1f:	48 89 d8             	mov    %rbx,%rax
  22:	5b                   	pop    %rbx
  23:	5d                   	pop    %rbp
  24:	c3                   	ret
  25:	cc                   	int3
  26:	cc                   	int3
  27:	cc                   	int3
  28:	cc                   	int3
  29:	cc                   	int3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  33:	0f 1f 84 00 00 00 00 
  3a:	00 
  3b:	66                   	data16
  3c:	66                   	data16
  3d:	66                   	data16
  3e:	66                   	data16
  3f:	66                   	data16

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   9:	0f 1f 84 00 00 00 00 
  10:	00 
  11:	66                   	data16
  12:	66                   	data16
  13:	66                   	data16
  14:	66                   	data16
  15:	66                   	data16
[   58.486214][ T3648] RSP: 0018:ffff88813b80fe20 EFLAGS: 00010246
[   58.487088][ T3648] RAX: 0000000000000001 RBX: ffff888142398000 RCX: ffff888142354000
[   58.488074][ T3648] RDX: ffff88813acdc000 RSI: 00000000fffffff9 RDI: ffff88813b80fe58
[   58.489177][ T3648] RBP: 0000000000000213 R08: 0000000000000000 R09: 0000000000000000
[   58.490214][ T3648] R10: ffff888141f59a90 R11: ffffffff81960fc9 R12: 0000000000000000
[   58.491333][ T3648] R13: 00000000fffffff9 R14: ffff888102692798 R15: ffff888142354000
[   58.492445][ T3648] FS:  00000000357bf880(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[   58.493720][ T3648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.494658][ T3648] CR2: 00007ffffffff000 CR3: 0000000142163000 CR4: 00000000000406b0
[   58.495806][ T3648] Call Trace:
[   58.496319][ T3648]  <TASK>
[   58.496723][ T3648]  do_mq_open (ipc/mqueue.c:923)
[   58.497381][ T3648]  __x64_sys_mq_open (ipc/mqueue.c:949 ipc/mqueue.c:942 ipc/mqueue.c:942)
[   58.498090][ T3648]  ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   58.498979][ T3648]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   58.499657][ T3648]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   58.500484][ T3648] RIP: 0033:0x463519
[   58.501061][ T3648] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 59 00 00 c3 66 2e 0f 1f 84 00 00 00 00
All code
========
   0:	00 f3                	add    %dh,%bl
   2:	c3                   	ret
   3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   a:	00 00 00 
   d:	0f 1f 40 00          	nopl   0x0(%rax)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	0f 83 db 59 00 00    	jae    0x5a11
  36:	c3                   	ret
  37:	66                   	data16
  38:	2e                   	cs
  39:	0f                   	.byte 0xf
  3a:	1f                   	(bad)
  3b:	84 00                	test   %al,(%rax)
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	0f 83 db 59 00 00    	jae    0x59e7
   c:	c3                   	ret
   d:	66                   	data16
   e:	2e                   	cs
   f:	0f                   	.byte 0xf
  10:	1f                   	(bad)
  11:	84 00                	test   %al,(%rax)
  13:	00 00                	add    %al,(%rax)
	...
[   58.503916][ T3648] RSP: 002b:00007ffc376f2be8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f0
[   58.505150][ T3648] RAX: ffffffffffffffda RBX: 00000000000000f0 RCX: 0000000000463519
[   58.506312][ T3648] RDX: 0000000000000030 RSI: fffffffffffffff9 RDI: 00007f9ad403e000
[   58.507487][ T3648] RBP: 00007f9ad4949000 R08: 0000000030010000 R09: 0000000001000000
[   58.508586][ T3648] R10: 00007f9ad403e008 R11: 0000000000000246 R12: 0000000000000002
[   58.509732][ T3648] R13: 00007f9ad4949058 R14: 00000000357bf850 R15: 00007f9ad4949000
[   58.510897][ T3648]  </TASK>
[   58.511374][ T3648] Modules linked in:
[   58.512025][ T3648] ---[ end trace 0000000000000000 ]---
[   58.524399][ T3648] RIP: 0010:dentry_open (fs/open.c:1116)
[   58.527033][ T3648] Code: df 48 89 c3 48 89 c6 e8 90 fe ff ff 85 c0 74 0f 89 c5 48 89 df e8 82 92 00 00 48 63 c5 eb 03 48 89 d8 5b 5d c3 cc cc cc cc cc <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 66
All code
========
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	c3                   	ret
   4:	48 89 c6             	mov    %rax,%rsi
   7:	e8 90 fe ff ff       	call   0xfffffffffffffe9c
   c:	85 c0                	test   %eax,%eax
   e:	74 0f                	je     0x1f
  10:	89 c5                	mov    %eax,%ebp
  12:	48 89 df             	mov    %rbx,%rdi
  15:	e8 82 92 00 00       	call   0x929c
  1a:	48 63 c5             	movslq %ebp,%rax
  1d:	eb 03                	jmp    0x22
  1f:	48 89 d8             	mov    %rbx,%rax
  22:	5b                   	pop    %rbx
  23:	5d                   	pop    %rbp
  24:	c3                   	ret
  25:	cc                   	int3
  26:	cc                   	int3
  27:	cc                   	int3
  28:	cc                   	int3
  29:	cc                   	int3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  33:	0f 1f 84 00 00 00 00 
  3a:	00 
  3b:	66                   	data16
  3c:	66                   	data16
  3d:	66                   	data16
  3e:	66                   	data16
  3f:	66                   	data16

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   9:	0f 1f 84 00 00 00 00 
  10:	00 
  11:	66                   	data16
  12:	66                   	data16
  13:	66                   	data16
  14:	66                   	data16
  15:	66                   	data16


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251020/202510201610.40b1a654-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


