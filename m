Return-Path: <linux-fsdevel+bounces-25404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F194B93B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 10:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640471F2197E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 08:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D018991D;
	Thu,  8 Aug 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D41RdabG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67C25634
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106941; cv=fail; b=Q1GGVE6dq3jX6k9hSRNUqWLyMZqdPdWlNlUDCEDcKpx9G133jos5yq4lCgOrYYepWdN7NhbkFHRWFtJkCEypb7jUtePFURbx/pSUI0zoFZ6Eqnhs+e+WGaVboJCE43pICe169YE2etCW+n4aRlHFU1m8wcPBbXH0N0mWGoPg3dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106941; c=relaxed/simple;
	bh=2YpxokX5giLhbd5mUoa4KhJMkESNr24hUCGJkJq2A1M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uM6WuJin4VNgUx/3PeoewBEsU8lODNub9L9DOUfpHNXwLlEQFkpFO3gLVLflOd4NswOEPPSEeTZkQqMxKakOuTHhX2yXv8ECti69+oJteSY/yvjywXjQ582tzbXZ8MlSmZGGAuJ3S2AQ76Bgu6vZAdppTkZYz9Ymy7hLX/uFpYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D41RdabG; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723106939; x=1754642939;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2YpxokX5giLhbd5mUoa4KhJMkESNr24hUCGJkJq2A1M=;
  b=D41RdabGQSfBtaL3Z6ZkcWJjeB5X6Vbq8ll5JiYw8Ng8Z71E2Q3aS66Y
   kQHtlM+txaWS/MTek5YRgKpknLGnvkU/MW/sMM1HBCmrF4CQ9i5gVUA8u
   8nm7dNXZszE87JWWwkkcCJZDjD8U8+s+Q2zwVX3QXkVDi10I2l+slLW+W
   MZ+4Nc6SpnofrOjrzCJPFK+lmaJZoOzoLrbS+la/5otKrVvhpb1sgSxlS
   Wu/GIXgGiB8Qze87QPtyejNWYNtkyVppxoJNG/5WXGVHCc63v67WgptJl
   MOGW77PKmTfsBKHooOqFiRzDGI/41a6P3t+6yyyObGPJivQxhHjax8fPz
   Q==;
X-CSE-ConnectionGUID: IO0NU76IS+iDFfrnwunKVw==
X-CSE-MsgGUID: c5K/uMpAQ4axbbj1RjuV5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="46622195"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="46622195"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:48:59 -0700
X-CSE-ConnectionGUID: YIq3fznkQlCLFEocmZFNOQ==
X-CSE-MsgGUID: gnQlgGuiQ6i/rwJACnGsIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="87802921"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 01:48:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 01:48:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 01:48:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 01:48:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 01:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAHdqbjqJTq9i5G9JIWM7bk1d9s34DdN6MCIUaiG6bgLIFrKynduAL3IdbRXMQoVDreTO+lP57K2ZsO6CEaMBgmZ9B7t/xsM4aJQjGeedfrt3k1F3d5HTrWi+UUVVpo9bAVhbdWb3CHB+gW+hnZp5IT+qD3sMrCAdBSsHhJaIeD46PvckiH6MG/rRzvZujfjYmxgoqKRwxGhqjUFg0VErLHrLFX8WZvv9V+d92OqeTEsxWC/JZiWh4+RIbzE4URr+aXA3Ok/bp6SBOEyIMkHHo9isLI7SBlaDSYjWie5p5n42JVs14DxWUaPF32idYk+giO2p2AdJrGKYNI7IJ3QeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGeUWOGr7iytDdAK993crEJcAneC0D6ncAAUaNuYh7M=;
 b=aGMLZJ6YyqZJ/dQWYtfvNyLqmu70R1aLcuLUvjcmgAXthA/FoV2bKtAnk0WjwzGhSvEKUpJ3GEHvmdcm4uARm8ywwddI0Y3PBbEh8lj9MUQ1nke6ojMJLs/PPLAJZVUmStFLlmPo8Hf48d1N7EnuwVp5PTThLlVzcAPvgkZHI1+EguAmxHcnedh/dTQ6W4NiN25+edpW6YoYA6GjcAElNRPjHpVsmmwmu718NAvfj/HKs8X9fnwdm7s2qZrEiT7pqwBVxVbHGYihoAUsVa65G8CQmpJjzLmFFybhNH3GUPrrhWFsu+Vm/zjNEGCVQTT4CsajCLsTOPj5ML27TPhwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7884.namprd11.prod.outlook.com (2603:10b6:208:3dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 08:48:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 08:48:49 +0000
Date: Thu, 8 Aug 2024 16:48:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jeff Layton
	<jlayton@kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [dhowells-fs:netfs-writeback] [netfs]  6afe9feeb3:
 BUG:KASAN:slab-use-after-free_in_copy_from_iter
Message-ID: <202408081649.796e7bd-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 428bb70c-a83c-4588-2367-08dcb786ebc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Enojrgy2pOHliDBv6vjwHqB5li2/VHSKpvkVoe5IB/8KGJjiygQp/nc8t1nx?=
 =?us-ascii?Q?6gP2P2fic4qLU8CX3tm2HYtULkFHdHGsQFwNRLrc+cKh10+d9/5Zk3ByLq4p?=
 =?us-ascii?Q?0HEZsPwiCHG/QHEPv5W+xALOX0HCJlmIoQc4kKzAEd/kM5KAZQiJpI9QWNPn?=
 =?us-ascii?Q?1WHT1fd0vducGpiOLRB4RAChCJGFFyJPpLnSX6KkFxZfdwOXOynUHal0yjRz?=
 =?us-ascii?Q?SXXw7M3pJTzblYTcAba5givkXpaflxXLL9UWDyBp2fSutA0uKWKnnF3jIhI4?=
 =?us-ascii?Q?rqKqna1vHe0Uqx2oDkI15JAhTOlkzFzdk2wrydn6B9z0D88f7VNB26HyHrMT?=
 =?us-ascii?Q?UGJCiB0G1ABfeLGiGfJ0GrhiKEUAj9Sd5ZqEKapjqJyiLllQI4kC75kXDOJF?=
 =?us-ascii?Q?z+jauR8mv26mujLPxNtUDscU7y/73idFEmPJBce5l18VMn3blVne3V42QCGE?=
 =?us-ascii?Q?5YRZAPMKrSqsGBMTVU6QF67x1FLsnvMk+t2AoLIgysX7BDUqQ6AyIHsab+Jc?=
 =?us-ascii?Q?BWL8FhlBtoVWB8ToqSz+MLOSOBTrYHVxRyHc0YTjYVvAU+47KvD5Bfo7scjF?=
 =?us-ascii?Q?jn8oAtZPzuJxg+rvc/tIkbhezyII57z5U1hAnGS8jw2II8Ley+qr9L75WTzF?=
 =?us-ascii?Q?i3mw/UjoT1S4ysKmbB9Zw1bQ1sK0lKu4LhfnsAZm1WaoB36GqzGoiBKewlRr?=
 =?us-ascii?Q?7yfbj79NCLqHJmQAbL6PH9qYH3EhDt3RlBf01c1PBol7m2/XvOchs6G6r1h0?=
 =?us-ascii?Q?hPxwedzRpGBdWJ7saWLo5eXDRoi7M2souJEtXzwMnIf7Y3Ubbn5+G7pUOUzb?=
 =?us-ascii?Q?eZm8p7yBpnI1cg2YSOfIdFIxqGG+nYBupBmPymfB7HiM+zfp9e7r2aoXkFjX?=
 =?us-ascii?Q?m5Sms8d69HLT604sF1xp6u+rTHGi6SnPpCUV3e3ljuDzpH4+YT+UbX1EEApH?=
 =?us-ascii?Q?wgCNSTxT0Q6wkbZTO6zlWFjvdSwiVkdXkOSgDuwr2jizMuZgU+PujvhWuvpS?=
 =?us-ascii?Q?SkivRRG8bnDMMirGYVTr51J8t58N3BdAEIlPieCBJCj+itH2QFR/KxMUPHVG?=
 =?us-ascii?Q?SRLnz8VVNk9I0QMZC8UTHssBnH0KqWHb6b31O/oq4w6i+CWm1fARsguHroqu?=
 =?us-ascii?Q?93awLjI2WYi8P2DOJLH2nZecompMVQ40XEVGHpKCIJ7ryublTOrh3C45ozgl?=
 =?us-ascii?Q?mIaodRb8foS7wDgg7fOQ0co73AXnyRtm5WROgCliAknjbITipyOns6ZJkFPY?=
 =?us-ascii?Q?ZgGg3kenUTu0RcDO1idJRfzU8NoOqrb3s0F4mJtLj14HKSmUBpqo6Nvpwmzu?=
 =?us-ascii?Q?MRKbwTMhc7Q7d0qi8zoVvAXA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TomakKbmr3o4jB7bt5XTD0sab+UjkT8Cgt6RDMCc19atCigP+TWLHz0vX6Ua?=
 =?us-ascii?Q?qqWw3M9EuvE+KR6Wm7gkxUPInZawj/VzaMWu/CoVP9BvM1CmGI31VFdZCIX5?=
 =?us-ascii?Q?Nvrqt2t8kmjtpovdRt3M3SxGv+kohDD0xkV6PZ3SRZ8He1CbhFyQOGrqIRfw?=
 =?us-ascii?Q?B6ohyzVv/rEpAKouj3Qr9jBxZknuH4UuXw7keXSCBVG4UDC7RnJ8NelzmZvK?=
 =?us-ascii?Q?D/ESCz8rV0pbpU373s2Vg79PFn9h+zQ5U/6l2NDbzTTPO29Tr4C8kIM1JO1j?=
 =?us-ascii?Q?w+QjWUjXG4NNDSj3b+PILkG6fAVgxS8KFpsbKul5jsAuUWxGrong1vvCKUw5?=
 =?us-ascii?Q?TbgGIepDMTWBJ7rZuwjnp42aQUcjVNycBisYXl1O0BUYezexoZu7GTFfX9Tk?=
 =?us-ascii?Q?FzaUV87yI8L46J518HVNGdNV1aDfO2uX5N/5CkZkXYsx6hfRfGKRPc+hUC/J?=
 =?us-ascii?Q?kT44EWZdLL//mRsX570cGL5RvXHEHR2+tv0Ytlu4rX+sSJtzQa3bq7jcYwOP?=
 =?us-ascii?Q?+E4jcr0KWbmSG+tPHymzfno7txxD7UWV8GVziehIjTXKV8wWg1A/gFTTg7gC?=
 =?us-ascii?Q?LqCyuGDxFCl4C0eztqbWwLRgxUn/iaFjkY1eKxk0i6Z9MCKKZzrZgiixWaUM?=
 =?us-ascii?Q?Sz8y1MATepn94Xa9q/JcZQn5icfhkCwvOfMZvxXrCyaGuH0lLHc1PkN6bPr/?=
 =?us-ascii?Q?W3iQGc23HQNQPD5ucuWqz/3xbDNtiAhmOKDnv/t/MecrULU/xEhNcn5O05F/?=
 =?us-ascii?Q?T5JComlxyzS1pnrho8bipu3XxLiSwMF84VhfkXdqDJRJcLQHnTPPxInqt+JO?=
 =?us-ascii?Q?scSXD4laFxsKfa9YKqHaca74c8e7REyZfwxhGERnZXHBdMP+ZfgJ5T6NqsRn?=
 =?us-ascii?Q?RtLUPxDFZn+AUckpc3ypWON2+QW93e5/iVjSDgBzaeqwgO0DVc/+zWD302ap?=
 =?us-ascii?Q?dtL4q3Lq1xJgdP0K1Ua1CbBB05R/sxrsFp0TcmdH3bI2U5FUuIKHVXJRYyFo?=
 =?us-ascii?Q?3sC2np+HAKGPscAQa8Ge+UTJ8YjN9nL3rdfg2fyq/GvVz+2YnjRut8EHw+8x?=
 =?us-ascii?Q?4T4sN4u65ZOkF+G+GuX/YnIe+//sijgVZUaDOkpczkNkSS7HcGG3KP7f06DG?=
 =?us-ascii?Q?siZXLWW2Lks+TYaCbTe2q+byjEqawYERPNN0gRlRojuzub5hav3WxVuFB/u2?=
 =?us-ascii?Q?pKKKEe0fD83fNSf5RCtAQh2QWnR6UCvFeyFrF+t0jbtZa1bKrrSzKQHB+tFg?=
 =?us-ascii?Q?S4298670kZ9mKYEpc7XG4d4JjKuGKS9jc9U0T1sW6u0lIUS8gWEDAyBxcK5g?=
 =?us-ascii?Q?lXbs6BBdMTDiq3eKsEOthlPy0PNMZKOSzfr4dtMdLRk5HGF+F/hD68rtPcks?=
 =?us-ascii?Q?bP5F7fEBwQOlT0fbpLm5tQNhLuPoxfoG6cHMOD/RW60S6HEUyNNkLyrkSYxg?=
 =?us-ascii?Q?HnUp0qi9pHqE2THQz/3TnISPx1W/agK95h2oo+udCKH7V+RGGaU5ifr/3rBQ?=
 =?us-ascii?Q?aN9iBA1bWN1d7he9ogtmtEdDL8eJq/zj02GfBCUqdiIA5KZwBerMKmENbLgp?=
 =?us-ascii?Q?Pt4i8K0iuU8/AaQXaCfpjIoKQsMfUuNOHcmq740bfppoABh7Iww6IVLxrY9A?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 428bb70c-a83c-4588-2367-08dcb786ebc4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 08:48:49.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7Hmw0iqFLmpkL/DgQ8bbH68y9Awmkw53D/4XmogOsMiDGL3SfKxwtKolXBkF05E+QU4vD6XOdum0SFwBiP+rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7884
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_copy_from_iter" on:

commit: 6afe9feeb377343e805b41bf08504bba6fcbaa7b ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git netfs-writeback

in testcase: xfstests
version: xfstests-x86_64-b3b32377-1_20240729
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv2
	test: generic-group-13



compiler: gcc-13
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408081649.796e7bd-oliver.sang@intel.com


[ 388.136673][ T2650] BUG: KASAN: slab-use-after-free in _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[  388.144431][ T2650] Read of size 8 at addr ffff88813dc6b520 by task xfs_io/2650
[  388.151751][ T2650]
[  388.153947][ T2650] CPU: 0 UID: 0 PID: 2650 Comm: xfs_io Not tainted 6.11.0-rc1-00018-g6afe9feeb377 #1
[  388.163269][ T2650] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[  388.171372][ T2650] Call Trace:
[  388.174524][ T2650]  <TASK>
[ 388.177328][ T2650] dump_stack_lvl (lib/dump_stack.c:122) 
[ 388.181698][ T2650] print_address_description+0x30/0x410 
[ 388.188158][ T2650] ? _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 388.193126][ T2650] print_report (mm/kasan/report.c:489) 
[ 388.197400][ T2650] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
[ 388.202195][ T2650] ? _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 388.207164][ T2650] kasan_report (mm/kasan/report.c:603) 
[ 388.211436][ T2650] ? _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 388.216409][ T2650] _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 388.221204][ T2650] ? __pfx_try_charge_memcg (mm/memcontrol.c:2158) 
[ 388.226434][ T2650] ? __pfx__copy_from_iter (lib/iov_iter.c:254) 
[ 388.231593][ T2650] ? __mod_memcg_state (mm/memcontrol.c:555 (discriminator 1) mm/memcontrol.c:669 (discriminator 1)) 
[ 388.236566][ T2650] ? check_heap_object (arch/x86/include/asm/bitops.h:206 (discriminator 1) arch/x86/include/asm/bitops.h:238 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) include/linux/page-flags.h:827 (discriminator 1) include/linux/page-flags.h:848 (discriminator 1) include/linux/mm.h:1122 (discriminator 1) include/linux/mm.h:2138 (discriminator 1) mm/usercopy.c:199 (discriminator 1)) 
[  388.241552][ T2650]  ? 0xffffffff81000000
[ 388.245567][ T2650] ? __check_object_size (mm/memremap.c:167) 
[ 388.251246][ T2650] skb_do_copy_data_nocache (include/linux/uio.h:213 include/linux/uio.h:230 include/net/sock.h:2167) 
[ 388.256655][ T2650] ? __pfx_skb_do_copy_data_nocache (include/net/sock.h:2158) 
[ 388.262594][ T2650] ? __sk_mem_schedule (net/core/sock.c:3194) 
[ 388.267406][ T2650] tcp_sendmsg_locked (include/net/sock.h:2195 net/ipv4/tcp.c:1218) 
[ 388.272463][ T2650] ? cifs_flush (fs/smb/client/file.c:2726) cifs
[ 388.277444][ T2650] ? filp_flush (fs/open.c:1526) 
[ 388.281720][ T2650] ? __pfx_tcp_sendmsg_locked (net/ipv4/tcp.c:1049) 
[ 388.287126][ T2650] ? filp_close (fs/open.c:1540) 
[ 388.291315][ T2650] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.h:107 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:127 (discriminator 4) kernel/locking/spinlock.c:178 (discriminator 4)) 
[ 388.296113][ T2650] ? __pfx__raw_spin_lock_bh (kernel/locking/spinlock.c:177) 
[ 388.301431][ T2650] tcp_sendmsg (net/ipv4/tcp.c:1355) 
[ 388.305533][ T2650] sock_sendmsg (net/socket.c:730 (discriminator 1) net/socket.c:745 (discriminator 1) net/socket.c:768 (discriminator 1)) 
[ 388.309897][ T2650] ? stack_trace_save (kernel/stacktrace.c:123) 
[ 388.314623][ T2650] ? __pfx_sock_sendmsg (net/socket.c:757) 
[ 388.319529][ T2650] ? recalc_sigpending (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 kernel/signal.c:178 kernel/signal.c:175) 
[ 388.324509][ T2650] smb_send_kvec (fs/smb/client/transport.c:215) cifs
[ 388.329725][ T2650] __smb_send_rqst (fs/smb/client/transport.c:361) cifs
[ 388.335056][ T2650] ? __pfx___smb_send_rqst (fs/smb/client/transport.c:274) cifs
[ 388.340915][ T2650] ? __pfx_mempool_alloc_noprof (mm/mempool.c:385) 
[ 388.346499][ T2650] ? __asan_memset (mm/kasan/shadow.c:84 (discriminator 2)) 
[ 388.350949][ T2650] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
[ 388.355488][ T2650] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[ 388.360546][ T2650] ? smb2_setup_async_request (fs/smb/client/smb2transport.c:903) cifs
[ 388.366873][ T2650] cifs_call_async (fs/smb/client/transport.c:841) cifs
[ 388.372196][ T2650] ? __pfx_cifs_call_async (fs/smb/client/transport.c:787) cifs
[ 388.378041][ T2650] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
[ 388.382596][ T2650] ? __asan_memset (mm/kasan/shadow.c:84 (discriminator 2)) 
[ 388.387047][ T2650] ? __smb2_plain_req_init (arch/x86/include/asm/atomic.h:53 include/linux/atomic/atomic-arch-fallback.h:992 include/linux/atomic/atomic-instrumented.h:436 fs/smb/client/smb2pdu.c:552) cifs
[ 388.393155][ T2650] smb2_async_writev (fs/smb/client/smb2pdu.c:5014) cifs
[ 388.398744][ T2650] ? __pfx_smb2_async_writev (fs/smb/client/smb2pdu.c:4881) cifs
[ 388.404765][ T2650] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
[ 388.409306][ T2650] ? cifs_prepare_write (fs/smb/client/file.c:77) cifs
[ 388.415061][ T2650] ? netfs_advance_write (fs/netfs/write_issue.c:298) 
[ 388.420208][ T2650] netfs_advance_write (fs/netfs/write_issue.c:298) 
[ 388.425181][ T2650] ? netfs_buffer_append_folio (arch/x86/include/asm/bitops.h:206 (discriminator 1) arch/x86/include/asm/bitops.h:238 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) include/linux/page-flags.h:827 (discriminator 1) include/linux/page-flags.h:848 (discriminator 1) include/linux/mm.h:1122 (discriminator 1) include/linux/folio_queue.h:102 (discriminator 1) fs/netfs/misc.c:43 (discriminator 1)) 
[ 388.430848][ T2650] netfs_write_folio (fs/netfs/write_issue.c:466) 
[ 388.435733][ T2650] ? writeback_get_folio (mm/page-writeback.c:2502) 
[ 388.440882][ T2650] netfs_writepages (fs/netfs/write_issue.c:538 (discriminator 1)) 
[ 388.445598][ T2650] ? __kernel_text_address (kernel/extable.c:79 (discriminator 1)) 
[ 388.450759][ T2650] ? __pfx_netfs_writepages (fs/netfs/write_issue.c:497) 
[ 388.455994][ T2650] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26) 
[ 388.460707][ T2650] do_writepages (mm/page-writeback.c:2683) 
[ 388.465157][ T2650] ? stack_trace_save (kernel/stacktrace.c:123) 
[ 388.469868][ T2650] ? __pfx_do_writepages (mm/page-writeback.c:2673) 
[ 388.474839][ T2650] ? stack_depot_save_flags (lib/stackdepot.c:609) 
[ 388.480158][ T2650] ? kasan_save_track (arch/x86/include/asm/current.h:49 (discriminator 1) mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1)) 
[ 388.484867][ T2650] ? kasan_save_free_info (mm/kasan/generic.c:582 (discriminator 1)) 
[ 388.489928][ T2650] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
[ 388.494465][ T2650] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[ 388.499522][ T2650] ? __kasan_record_aux_stack (mm/kasan/generic.c:541 (discriminator 1)) 
[ 388.504926][ T2650] ? wbc_attach_and_unlock_inode (arch/x86/include/asm/jump_label.h:27 include/linux/backing-dev.h:176 fs/fs-writeback.c:737) 
[ 388.510679][ T2650] filemap_fdatawrite_wbc (mm/filemap.c:398 mm/filemap.c:387) 
[ 388.515912][ T2650] __filemap_fdatawrite_range (mm/filemap.c:422) 
[ 388.521317][ T2650] ? __pfx___filemap_fdatawrite_range (mm/filemap.c:422) 
[ 388.527424][ T2650] ? __pfx_task_work_add (kernel/task_work.c:54) 
[ 388.532395][ T2650] filemap_write_and_wait_range (mm/filemap.c:685 mm/filemap.c:676) 
[ 388.537977][ T2650] cifs_flush (fs/smb/client/file.c:2729 (discriminator 2)) cifs
[ 388.542863][ T2650] filp_flush (fs/open.c:1526) 
[ 388.546967][ T2650] filp_close (fs/open.c:1540) 
[ 388.550983][ T2650] put_files_struct (fs/file.c:438 fs/file.c:452 fs/file.c:449) 
[ 388.555700][ T2650] do_exit (kernel/exit.c:878) 
[ 388.559651][ T2650] ? __pfx_do_exit (kernel/exit.c:821) 
[ 388.564106][ T2650] ? update_load_avg (kernel/sched/fair.c:4410 kernel/sched/fair.c:4747) 
[ 388.569001][ T2650] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:107 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:120 (discriminator 4) kernel/locking/spinlock.c:170 (discriminator 4)) 
[ 388.573892][ T2650] do_group_exit (kernel/exit.c:1012) 
[ 388.578264][ T2650] get_signal (kernel/signal.c:746 kernel/signal.c:2794) 
[ 388.582648][ T2650] ? finish_task_switch+0x1b3/0x750 
[ 388.588319][ T2650] ? __pfx_get_signal (kernel/signal.c:2682) 
[ 388.593031][ T2650] ? __schedule (kernel/sched/core.c:6399) 
[ 388.597485][ T2650] arch_do_signal_or_restart (arch/x86/kernel/signal.c:310 (discriminator 1)) 
[ 388.602893][ T2650] ? __pfx_arch_do_signal_or_restart (arch/x86/kernel/signal.c:307) 
[ 388.608910][ T2650] syscall_exit_to_user_mode (kernel/entry/common.c:111 include/linux/entry-common.h:328 kernel/entry/common.c:207 kernel/entry/common.c:218) 
[ 388.614407][ T2650] do_syscall_64 (arch/x86/entry/common.c:102) 
[ 388.618771][ T2650] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  388.624527][ T2650] RIP: 0033:0x7f877d125d32
[ 388.628802][ T2650] Code: Unable to access opcode bytes at 0x7f877d125d08.

Code starting with the faulting instruction
===========================================
[  388.635684][ T2650] RSP: 002b:00007f877cdffdb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000022
[  388.643958][ T2650] RAX: fffffffffffffdfe RBX: 00007f877ce006c0 RCX: 00007f877d125d32
[  388.651794][ T2650] RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000000
[  388.659642][ T2650] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffe43b01d37
[  388.667478][ T2650] R10: 00007f877d06bf80 R11: 0000000000000293 R12: ffffffffffffff80
[  388.675314][ T2650] R13: 0000000000000002 R14: 00007ffe43b01c40 R15: 00007f877c600000
[  388.683154][ T2650]  </TASK>
[  388.686037][ T2650]
[  388.688226][ T2650] Allocated by task 2650:
[ 388.692414][ T2650] kasan_save_stack (mm/kasan/common.c:48) 
[ 388.696948][ T2650] kasan_save_track (arch/x86/include/asm/current.h:49 (discriminator 1) mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1)) 
[ 388.701485][ T2650] __kasan_kmalloc (mm/kasan/common.c:370 mm/kasan/common.c:387) 
[ 388.705934][ T2650] netfs_buffer_append_folio (include/linux/slab.h:681 fs/netfs/misc.c:25) 
[ 388.711424][ T2650] netfs_write_folio (fs/netfs/write_issue.c:432) 
[ 388.716307][ T2650] netfs_writepages (fs/netfs/write_issue.c:538 (discriminator 1)) 
[ 388.721017][ T2650] do_writepages (mm/page-writeback.c:2683) 
[ 388.725468][ T2650] filemap_fdatawrite_wbc (mm/filemap.c:398 mm/filemap.c:387) 
[ 388.730699][ T2650] __filemap_fdatawrite_range (mm/filemap.c:422) 
[ 388.736107][ T2650] filemap_write_and_wait_range (mm/filemap.c:685 mm/filemap.c:676) 
[ 388.741687][ T2650] cifs_flush (fs/smb/client/file.c:2729 (discriminator 2)) cifs
[ 388.746589][ T2650] filp_flush (fs/open.c:1526) 
[ 388.750690][ T2650] filp_close (fs/open.c:1540) 
[ 388.754704][ T2650] put_files_struct (fs/file.c:438 fs/file.c:452 fs/file.c:449) 
[ 388.759411][ T2650] do_exit (kernel/exit.c:878) 
[ 388.763339][ T2650] do_group_exit (kernel/exit.c:1012) 
[ 388.767702][ T2650] get_signal (kernel/signal.c:746 kernel/signal.c:2794) 
[ 388.772066][ T2650] arch_do_signal_or_restart (arch/x86/kernel/signal.c:310 (discriminator 1)) 
[ 388.777478][ T2650] syscall_exit_to_user_mode (kernel/entry/common.c:111 include/linux/entry-common.h:328 kernel/entry/common.c:207 kernel/entry/common.c:218) 
[ 388.782973][ T2650] do_syscall_64 (arch/x86/entry/common.c:102) 
[ 388.787338][ T2650] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  388.793091][ T2650]
[  388.795282][ T2650] Freed by task 2622:
[ 388.799128][ T2650] kasan_save_stack (mm/kasan/common.c:48) 
[ 388.803669][ T2650] kasan_save_track (arch/x86/include/asm/current.h:49 (discriminator 1) mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1)) 
[ 388.808211][ T2650] kasan_save_free_info (mm/kasan/generic.c:582 (discriminator 1)) 
[ 388.813103][ T2650] poison_slab_object (mm/kasan/common.c:242) 
[ 388.817993][ T2650] __kasan_slab_free (mm/kasan/common.c:256 (discriminator 1)) 
[ 388.822642][ T2650] kfree (mm/slub.c:4474 mm/slub.c:4594) 
[ 388.826311][ T2650] netfs_delete_buffer_head (fs/netfs/misc.c:60) 
[ 388.831650][ T2650] netfs_writeback_unlock_folios (fs/netfs/write_collect.c:137) 
[ 388.837489][ T2650] netfs_collect_write_results (fs/netfs/write_collect.c:551) 
[ 388.843241][ T2650] netfs_write_collection_worker (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 fs/netfs/write_collect.c:641) 
[ 388.849080][ T2650] process_one_work (kernel/workqueue.c:3231) 
[ 388.853878][ T2650] worker_thread (kernel/workqueue.c:3306 (discriminator 2) kernel/workqueue.c:3390 (discriminator 2)) 
[ 388.858415][ T2650] kthread (kernel/kthread.c:389) 
[ 388.862343][ T2650] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 388.866627][ T2650] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[  388.871249][ T2650]
[  388.873436][ T2650] The buggy address belongs to the object at ffff88813dc6b400
[  388.873436][ T2650]  which belongs to the cache kmalloc-512 of size 512


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240808/202408081649.796e7bd-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


