Return-Path: <linux-fsdevel+bounces-37188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E17839EF08E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E79A178C18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C4A236940;
	Thu, 12 Dec 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nE6oXffU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0A225407;
	Thu, 12 Dec 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019783; cv=fail; b=aAur8TOCa5cgqVr1hWuNt9wzFgdwHcyzofuXKEC3iXlJGBmSZNbMogu0/CiMKwTcA0qR4xX0KVX+VD0xStXsN91SkYBj4Lf+onBWnu0GBN7gKBtVDDSJ5lJtjsfZfcfFromtaJi9Rh773c6CJWWQw+MYS1BTfIzuv8NXjBGBylw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019783; c=relaxed/simple;
	bh=/CB12MFytRL6UbNIFCIYrZbB9pDZmfETM7gPY+qP5k8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MnPzh5Y/n+82W14rFsGUqzhvPSfPEvQTQeAC84/A5g3agVwuqH2nMjauuEVTH61iCCkRHSa/1viouakDPpQAczBw6BENsW9WIYsMX+rc6sLZ4P1cTeKUiZWEwDRYEv8SdbLx40MqT6WWWHaM0uhxNEuVrYHMhphnu0ZUOtLDZSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nE6oXffU; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734019782; x=1765555782;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/CB12MFytRL6UbNIFCIYrZbB9pDZmfETM7gPY+qP5k8=;
  b=nE6oXffUqHw0lMl+lWZvVQYdbeHgMzkRvCIbrtMEEjqDUp+2gmnFzg26
   CiaxzMXyKMQOJ6FztYo0NKqutjjElIjm8oscjsEtOszFNVsIP+XcAtqS/
   2y6JYTWVWdOa+CjzduUInlKZStBG7SxVVgX65BUtrexC1NPPnbaMR49kU
   ORC5Yc6UWtkZetiWhGQ110DMIq9MBXkm2yxN0dP1rZWUYvtezwBp/euyx
   27XuS2rbCwQKWYyfM6vgyk3XJKGfPARzm5yFJ9FZQmSne8wdZO1joA7Zg
   gKBST+bcskRZe5uUbXU1APnL7NnF39mlMgnlz1AEo8anZgow59IagSt23
   Q==;
X-CSE-ConnectionGUID: o8+tC13SRwS3l7yFmo8YgQ==
X-CSE-MsgGUID: +ByFNWgrT1246ayJXyXYpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34317744"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="34317744"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 08:09:41 -0800
X-CSE-ConnectionGUID: aLlEXYnvQayKDez4RG9Qtw==
X-CSE-MsgGUID: ofb9lMUqSQS8fVsLtEXUQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119517218"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 08:09:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 08:09:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 08:09:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 08:09:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHK9tsHCa7D8RaKonec4dQNhChFGrkLHW33UaUjtWwCUr3q7BZxkLL0DvJyzYI31I1a8yt9LjdgDbP/4Y0vrOw7DpyacsSb8hJJYIiRny/B0CnPhTOzs2FnqEFYnNvlCjDcJh/4VaEhUfbB6VVFy0Rzcnrp+9RBc5XLBHS5VhuJfNzSF9SSGxT3g/dyHnxojpuJIZil7pfpYFeJttSMypGkW1ud6nsWaqbKZ+19vM8ym5DU+osi6P1YcmSy3mXjPq5mXUNOVDczUFLRFUfA4+VhvOZ4mJyGKUXVcAgK930W2Y4ww+BbV8UMFIS7QJjl/Y2H+rG1+y4RSS+5LE/t36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7ZGkKTHk9T4VqtnhMx7Wri1TEdHiZvlenP5y1C9KRU=;
 b=r84egbNGvsyO4T5hXG1StAHk5zP7imxb5o9f3c4slFc/atBEvB4FqfoOJ/kbgotDihCY8SEBKCbOG+O4f9SNdVXgjM4L3C7VsYiKODpKFawAPmpgK2GTadYJM205t5d3F0+euNbpdDVISaxaQbmd4JokXn7J6HTpKYbeCOQ7L8U2L05JofL9tJG47u9L/Wrkp8P3+gzMxmP51KepEnDFjhTpbakkRX3GYuZwx9xXVbBZr/PNZ5akPK03Oe+T39uYYcPZxrAMZSCIN269ltiCyYQOsaDB151J3vmN96XGDpTkkmPh0d4XEKwRd+R1ZHPNlDqDbPA52SPkBcVzig77sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6660.namprd11.prod.outlook.com (2603:10b6:510:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 16:09:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 16:09:05 +0000
Date: Fri, 13 Dec 2024 00:08:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Amir Goldstein
	<amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [exportfs]  7fc737d188: xfstests.generic.477.fail
Message-ID: <202412122317.43dfe501-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:4:7c::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: d22e278e-7858-4e54-0248-08dd1ac74d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pUA6cE9XPX8KHlNtMLy0wSDe+B6Nnlhd5xhP+id1cKUlj7bmXE3eT1/0VQQ4?=
 =?us-ascii?Q?7oJzamQt3P8sjQ2arD51innmayYgYHY3AJ4tnO03NcukFkk858ilf3ZDDGP+?=
 =?us-ascii?Q?HdY6Ekk+ES4iYY+JnwUyUFn0uYivgEQ+9Dpbgu+5S+2b5ESySd+j9cjGIlFl?=
 =?us-ascii?Q?cfyVfDBU1vgPSbNVqEqJfnkbpZCAYVzslnDxmkw1j8A2iT/k9u/nK521vQNk?=
 =?us-ascii?Q?FAg3S4P9728W+ZFkTB+NwX2wXLfS7dxXciTZcdxtcGe+8sUosTlFVBWlp1bW?=
 =?us-ascii?Q?ZLbwldQfvt+XmT4/NcAklg1Qbp9QY6TNz7HzpyJ98z5Jcm6540UC2e10NiP6?=
 =?us-ascii?Q?IeOG/ZkOjIxEjSF1dheYWYCG8SH9sERypKvBJiOWo3byQlhpkdHLC3kH5n8Q?=
 =?us-ascii?Q?yrPS+2ejCZvULlCIHY2Uuf2/JrSHjl/gt0RRQPNWIXt6hYujIBKqnMBUSWeY?=
 =?us-ascii?Q?oGn5oIVXGKihDsaKCqlZgOPtMd5+JBkFX9BInBk9YMzUo2/nm9JQI4+HwvmO?=
 =?us-ascii?Q?+a0TH95OTodI109CcEai7tixW1RJYd6RNzJ93k9BdcA8bUHlZ9/HAqYh0xFm?=
 =?us-ascii?Q?m6bPjDzOcxIAEYHsKARd+Gj5+i4NKSM87jNU6ong2orSfvLHLw1OHWE3jGkn?=
 =?us-ascii?Q?lIdyTQTKmZybEJOu5hCCAQlErwlF44oq6YE8NKYz8/txLY4mei/cwYtyJ4rQ?=
 =?us-ascii?Q?RAwveF8Pg7rNwEcK7qr3DDHT6KmR3Cq+GU+WZYTbtQX6L16t3VkRiHiXqwG6?=
 =?us-ascii?Q?2WtgQuIGvFC81p6fJvWHmz0vqnGSZfkMU74QtXswoXdqAtSFKtQOkSEQVNiB?=
 =?us-ascii?Q?VuNMHrHIA/TeDd6KRXsSccN8uBtcYnaRrBvP13R2KN8JZOrly9ehKnsptK7t?=
 =?us-ascii?Q?hp8FiquMl3EVr0Fhp2LEkHyckehNArUmA+b/2u/0eZMFC5jCQh5jQoseKajT?=
 =?us-ascii?Q?LVKWnHXTvM6Wc1GwRAYOxZl1Ev9s+c/KF4d5BHGRjuEmTI3WV95khy+YbbqQ?=
 =?us-ascii?Q?MFAmenAdbpeGFbVyRBGmlZTSVhN9P0ujqubswQiWoolxqbARyu2egYlWHyC7?=
 =?us-ascii?Q?yRQgSeEvNwzBQDkm1GAF8oMgACCXfez/zxwG8ZralK3/o3uGc37+xHbCpeXg?=
 =?us-ascii?Q?E8KLdweRQuq+kTvQ6qGsoH9k5/yxdMKe2YZhZ4wblRsQ+mpJW5MZv9Q00KEd?=
 =?us-ascii?Q?UQiIXeEm+b/MpDjkgHKjnEgTSo8nC0adrjExW0kuvP+hw4/2ZSsn8bwuY6km?=
 =?us-ascii?Q?IlcqzyJsp0coVspRizEGPS9KkYNOZJaInXgn/H2/FiBF8HZea8eQkERrKjJf?=
 =?us-ascii?Q?CXGBBSOgKgwNly4VBlTnZR8F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ysnjVzT7wDIiNRG/L6DSpHp/U5Z+P8CBS0f+ypUGldfXyH8UcDcaz3mMLygH?=
 =?us-ascii?Q?NJvhdIvYJs6gILr/x2C7lfcrbG2QhmKOvmyh0zGrUmKMETZJXTSBRPvlhf7I?=
 =?us-ascii?Q?gLWSaa5JZOnJuC+YbG7+G1EAYvUwOyY58yCG27JhFBe3Y8INj5loh7pSRdME?=
 =?us-ascii?Q?5hytiEoCgNXY0ak2NIUIEHJzXzwqFveVaffOpbANAjeIRrhlUdGqkNY8apDL?=
 =?us-ascii?Q?8WMCaSnol/f+XJP/niDETR33NXnB8I+Lk5Y70V+PM/1/sVJtNxpqegJvWLAb?=
 =?us-ascii?Q?otpGVKgJy5WT8agen67J7toQvZoKMEp84ES5Cb2gwLuqHb7hW5zgRSQVM0a9?=
 =?us-ascii?Q?JVDDrhoVJuJDG84aIJ7XCDG737ZCWy0Q4Shgt/nVRKrCYhLV8r/hkzz2OOgz?=
 =?us-ascii?Q?luemQ/mBKolNjbt+iaOvOxjRWsL9GNwNDR/UOyEopT0t68Cqj0Rl7p1jjzl/?=
 =?us-ascii?Q?pZ7/EREHWVM0hoIgYD23Krp1L5fHWhY3lcb9RtxojwrubD/FC3LNFWu3ozJ5?=
 =?us-ascii?Q?xvepPIw4TJxwlLUvgAwr+Q25uiFvRGdDT/6Z7kZkAuWDdosyfMBc1Hm87iaD?=
 =?us-ascii?Q?NmzSspufzFmJaIsu8jgZDDnh6U6+XdSRtL6Lo6zAQmvOw33SrTTBBc4O5GCJ?=
 =?us-ascii?Q?vjg5W47byKQhw4lPJNRUrF0+Qmk37YR/e/JgIMPgAvKEIx41pbWTiK22BLE4?=
 =?us-ascii?Q?fNC6NA4z/jHjL5LUVq+Tv27hy6opUQzoG6ICR3Cwe6uMzApQfW/O6l0GiIuW?=
 =?us-ascii?Q?vVDI1oIUUeVM+UPhFynMFZR2wjg1TiJIcEy3q0DSSKNQx51brHQsR5GvGmfv?=
 =?us-ascii?Q?WCLsLEo/vblKj03QkJmBpsu2FESSRJwaBTgyiUahvKRlHkgkAmqiAVBxcUxW?=
 =?us-ascii?Q?MKOW8p0Vk7tdkx+DUlOnz/6YzXQA9ovnYxMN43DwuaJvvMZuwpyjWIaq5tyR?=
 =?us-ascii?Q?iH+xiFRUll6fgjjJbB1O7kz9E7yqh0QkzvetDAehsS7473qpg7o2jBFHaIb9?=
 =?us-ascii?Q?jPEamB62pUq51fh+n8hIAgMbtMxaDoaLUJzIttU/XV9YHI2+dhQqKw0XJojM?=
 =?us-ascii?Q?Cxbim78oIi5CORGCLY0QQSk2dJJ8vZ0YXwhg1Zzi/sk0iLBeFViMrjbJE8je?=
 =?us-ascii?Q?r0+P8MSDtfpm2R7pHmpvypuOgcpx7lD84SilyKboSlUFoKiECvZaASIFHsTe?=
 =?us-ascii?Q?pMz6Cpyc7da3vV1p3BJ3RvI9Kitdu0fQlzLIH1gxtkvdZe+1c+KAviYncuPU?=
 =?us-ascii?Q?IeYQCzBV9h06hQ+DL73n4M6p8sBQMC89pHUVPwPNomK1hY1CIAkvV4btOkjd?=
 =?us-ascii?Q?hs3N4oJga3KAN16iyRX88nr7hAqq0jNq8SCm7glW3NskS9onPwUrhiKs/8oL?=
 =?us-ascii?Q?+xgJjmkho4JKFnqiou2hr6TzbglTnUWwS8dUJPUSEPwSN9Gy8/QmiTPbF/g7?=
 =?us-ascii?Q?7GNEglkNDn8QLeSb106F4ChECmLVfUbZd4AbWgyMBbXoYY//sPeW5mZ9ZIEl?=
 =?us-ascii?Q?+93CCvPKeK+vSHf2+8i9pQ/E+Cx6nRCLB0UB5Q96QlLHw/oBNuvIbpb92l9/?=
 =?us-ascii?Q?knzMw8gsUxvw1GlPg6P+i47kPDzvplLArjCHJY++OfUF/4kQZD5MCPPOdl8g?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d22e278e-7858-4e54-0248-08dd1ac74d6d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 16:09:05.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ci5nhCSb/AvEcKM+5cfnt+ZRlu9NHGEGvN6nMvF+2HYoVF9S0Fa6nqswoYAQHmfjF8LhKqnAqEGETjoGnV01CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.477.fail" on:

commit: 7fc737d1883200e6189579a0fc82f592fbc09e9c ("exportfs: add permission method")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 3e42dc9229c5950e84b1ed705f94ed75ed208228]

in testcase: xfstests
version: xfstests-x86_64-88be6071-1_20241208
with following parameters:

	disk: 4HDD
	fs: xfs
	test: generic-477



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412122317.43dfe501-lkp@intel.com

2024-12-11 10:24:27 export TEST_DIR=/fs/sdb1
2024-12-11 10:24:27 export TEST_DEV=/dev/sdb1
2024-12-11 10:24:27 export FSTYP=xfs
2024-12-11 10:24:27 export SCRATCH_MNT=/fs/scratch
2024-12-11 10:24:27 mkdir /fs/scratch -p
2024-12-11 10:24:27 export SCRATCH_DEV=/dev/sdb4
2024-12-11 10:24:27 export SCRATCH_LOGDEV=/dev/sdb2
2024-12-11 10:24:27 echo generic/477
2024-12-11 10:24:27 ./check generic/477
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 lkp-skl-d07 6.13.0-rc1-00013-g7fc737d18832 #1 SMP PREEMPT_DYNAMIC Wed Dec 11 18:12:26 CST 2024
MKFS_OPTIONS  -- -f /dev/sdb4
MOUNT_OPTIONS -- /dev/sdb4 /fs/scratch

generic/477       - output mismatch (see /lkp/benchmarks/xfstests/results//generic/477.out.bad)
    --- tests/generic/477.out	2024-12-08 03:24:45.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/477.out.bad	2024-12-11 10:24:33.005175715 +0000
    @@ -1,5 +1,9 @@
     QA output created by 477
     test_file_handles after cycle mount
    +/fs/sdb1/file000009: read: Bad file descriptor
     test_file_handles after rename parent
    +/fs/sdb1/file000009: read: Bad file descriptor
     test_file_handles after rename grandparent
    +/fs/sdb1/file000009: read: Bad file descriptor
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/477.out /lkp/benchmarks/xfstests/results//generic/477.out.bad'  to see the entire diff)
Ran: generic/477
Failures: generic/477
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241212/202412122317.43dfe501-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


