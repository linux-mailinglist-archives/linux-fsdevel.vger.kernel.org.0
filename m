Return-Path: <linux-fsdevel+bounces-33647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C559BC349
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 03:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3C21F22C3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 02:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D2C3D0C5;
	Tue,  5 Nov 2024 02:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKI+q/V9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AAB36AF5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730774373; cv=fail; b=VHJpe5xJBGEoGJmMDZCa/EIXCXvraaTB8REhkw4CaIYSnXrSq58b5CjHJN2QVSo5kjiy6zIPgLxlvG+DkHL3pKK+gvFcNS3Mb4boqAUjBBO1ANoRozBTpXhklgwjkzXqwdIT5lNxWTa3fHjyAdFzyf5a9XHYUsDEmdZQPH/RQaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730774373; c=relaxed/simple;
	bh=D7MBpr8BgM5gCS8zPA+uPUNxRmEMkjkn+JSukKlx74w=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cGtFcOwnMNezmJnzcXKIidNH8hm4IlS8E8XNXkU6ZQkLMbabdTKeacQgV03uQYMRIpNbTreyAcxkLKtDujbX/RdZp3ufehlbNer3iLdFJ3QcIowZZTbQekTccg6urVkFki6hU9N3/N3+v2ZMQvcyRRT4d2Q2hnlAv5jq9KE1HaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKI+q/V9; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730774371; x=1762310371;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=D7MBpr8BgM5gCS8zPA+uPUNxRmEMkjkn+JSukKlx74w=;
  b=hKI+q/V9Lnyqx0HS2v5eHyeTW/KFVqYgPmFidl36qfA1DlT00vvzYYBC
   Hb8nf8TwGAp6ei6jeCx86FlLujVydOOXpN8Nl/vdpoGAf0Yosog9kNbEy
   /welSvwrk7qYPEkBs74NgfKvrBdLcFvQgL9WnT1GE27pp+UqA83V5DgDU
   tCQ3WMdQhb4yJiA2nHOhT8SD3WAJPYmO1JNpORD/oXPidoZtZHewu7D7+
   6e/F66e24X7HygGJIKeNAcwX+H2cbC88sg0De6C6EjcplTE27v3drRZLF
   dygp98QlWlpUF7jB2B/icfq0ZXlu4CZdF+JFj8MaUQ5Q53oTpOhO8cWGO
   A==;
X-CSE-ConnectionGUID: hg7VfmMRQCm1n+cgsIpcAw==
X-CSE-MsgGUID: VpeubFVmSp+Sugw7JYyu5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30451186"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30451186"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 18:39:30 -0800
X-CSE-ConnectionGUID: Guh2IAcNSOGrGsAvPniufA==
X-CSE-MsgGUID: d4e6FHBPTVark6GXnLqCFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88603843"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 18:39:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 18:39:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 18:39:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 18:39:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5r3zhRat8EgHDwjw1/p6RmrLLxTRauZGt06gsmI2ZanNLdDipEiExx6sd1YbR0gXUvFsvZCZkvpotXvG6stydiDEmxBkL58Z1tdj4aDE6bE7otkbU2szRlW14whMNKJMDRZeA44Y2XrMT6UUgutw5A66ck+EdN0eRRo2SRHGKZNuL2eVWfXwv1Xji8rZMOfQ/xLYMUADhKK+rws4elxf3jNw/JOSKDHcqL878XDG8lPU5SwysU4mS417rmmZWD/G2Ggx8RNZ+24M5Kf4gRxTvhFi9WWiDndUORec7tD9zKGP88FaMaSk10kh3fBGs7UxbxNtV+b5BWz5s2x+PxLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw42QPysqKuIjn6MLQZNIdxKDEvbznzomhYtt9QPsKU=;
 b=q+nPTCjXhlAMexxZzMda7B70KDcDFRj4uuN4/GU3FY8I3ZnuibpOrffFhfeT6ZXjsRlOccIvQ6Pr6HAudih39HwTqDqKDraMOdq9hqKnCo41gqHFUkUb+E/OSYLasDQwv63Sv641edJ6mauUinsNz2g9+0Lizfh2WtHfyexk086FO1HraQnb7d0j+omc4YWgU4yjd8w7cJhn5rkz5f8nS5UOIS1fXhKq80L4gL20D2qWJgcNSZmZX07i9HN5+HsHqzBoGrTu/Ta8ETi+oNFRfUBEmNoIjbhNHwjuS7XqQ09gT9KbAAjY/l0g55N4kOqvaJOGepKr9pgUej/WqMwmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB5081.namprd11.prod.outlook.com (2603:10b6:806:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 02:39:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 02:39:20 +0000
Date: Tue, 5 Nov 2024 10:39:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Daniel Yang <danielyangkang@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>, OGAWA Hirofumi
	<hirofumi@mail.parknet.co.jp>, "linux-kernel@vger.kernel.org (open list),
 Daniel Yang" <danielyangkang@gmail.com>,
	<syzbot+3999cae1c2d59c2cc8b9@syzkaller.appspotmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] Fix BUG: KCSAN: data-race in fat16_ent_get /
 fat16_ent_put
Message-ID: <202411051037.304ba029-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241028202645.412589-1-danielyangkang@gmail.com>
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5faf8f-d30f-4746-8415-08dcfd430d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S9HZKi6ikcAJXwNw5Dk98sMqk7K6sGQ+fTTdcGXemg6Hw5nonREJO58ssltQ?=
 =?us-ascii?Q?goCfFrH6OwBwHtuPmuoq6Nve/yXcPWaS1MfAKh4LZctVI/9rtQ7R1l/HtMBi?=
 =?us-ascii?Q?QRkEeV5z2+hXzGudrfJRCAHmWmeGerwReCHlbTX0SRHHUDqKwYfuWowpaZED?=
 =?us-ascii?Q?u0ym2rNFWQ/CexqJmhZ/Mh+LZuoXFQrcjuOwi73YPHuaEkpXndxJVNSIf5Li?=
 =?us-ascii?Q?meMuEDztZriX8az4lLxCwESuz5XCGg8TXdTpEJ91NXxQ0mdUQfUyUJjtL2yr?=
 =?us-ascii?Q?Rr5WiDGyV1fpAA61JQilwfrYYark9wKOKJCZ2h+xOgqh0sEiexRuv/d23WJ0?=
 =?us-ascii?Q?CBTvEZCRIBiJESy5mB6BfMpRIUNm1jGRD3aEHwwdyaFHIzYCE+xDmcAU/G+p?=
 =?us-ascii?Q?gabXWm8W8Ohej5JeeqmJqpUHG2A9u0at/RWpK1aaCRNYiF5do4BeJW+IL3VR?=
 =?us-ascii?Q?Cl6LN45sdLnNrHwk2U6a2SpcNCnKRQQUnLZx1gsMQ9Hz5F05+3dt94rVHJcP?=
 =?us-ascii?Q?60gJIs5/UVYzZsAAP4OP1K0JgSZ+4WN6fh3sEz/dIsfdC6fo1WwadevSJw4c?=
 =?us-ascii?Q?xYwmTtesbAe/YX80uPH7vTlBHCnFh7qqeEqDYqKjEZ4hkfZTd7GQFsmPu5r2?=
 =?us-ascii?Q?aoW7BHDywdlvLwXKXZ5Os3flfxQdvXy39+X/HpK+saTvpR4qR+rO0Wz0sULx?=
 =?us-ascii?Q?i+R5SaUBOU5UDoRpcN2FjhUx0mq5PKiXiJRJ7Bp0IOCLFIAJs+qZ0FTs0862?=
 =?us-ascii?Q?0BQFr2x/mVAyAu/zCjyc30xBSAAmCiYF6HkyHPkGEaDUPlOZr3Y+XzIiAaqN?=
 =?us-ascii?Q?rWj27FGSs+qdnQke/HSfnnPjrmJ1pbg59bhcvKKF1BkBMhD4C+MyPMDyPKql?=
 =?us-ascii?Q?2TBKL5kln+eQsOv621oa7U0efNlqP9vTXI+RnjOI+cLLj5P8i7NzouPq+95u?=
 =?us-ascii?Q?9AM9GWmtX1nIkDBzBCtLuXeLX8uSCQohPQMuLNbo9S1WaXra2IciLixaFU4Y?=
 =?us-ascii?Q?tPBhBilTv9ACI5K9CCXE55PEICVkeD9PCnQjQfPThdVXEwJREnx44KmUxCFR?=
 =?us-ascii?Q?KhDtAE3ksDvcwDOr1yS6yMbNEi9enL1rz93nxdlGql0jXo5xQDQmW3sMT8jj?=
 =?us-ascii?Q?Mn8sKqORY8jPcmi0A6BeNPoqLvECbKW7JLSZFGE/QZ0toGJYO2s8cwYZpHgq?=
 =?us-ascii?Q?KbhmgHuMy0AqSEctAeKRk12LBoIBCmOEPQQx5eUH4l18Wu4UHSDir61Vhcyo?=
 =?us-ascii?Q?bxFON+o7RhO+piWr2tBnLSGNu792YLDAZfkYrSE9Mg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aMgCXYKdkKssCrzYdN4WlyWXIwArLEmVTL3/iQsKdQOi+xe9M5J42+wkmvT8?=
 =?us-ascii?Q?CWIR0dxV2b659quYJgqR7dgGd+OCiczSDt2aOaCPYel7I6RRn/ueQockyU7G?=
 =?us-ascii?Q?YapcfjWF8yipHO3O4n5D2a1RqIf8hdrTkYnGwBKm3REVmCroBwXObU/p5+Z1?=
 =?us-ascii?Q?XWgqp8ayMrlEaYCjsSqCBcD3nyKv9CUdVvElxL7N8NAd2UgwHVup4/LE2+/1?=
 =?us-ascii?Q?6SSas4yTWK5IcGzqE+lzkSWsKbUn9a8x2bpkz0mH6dN3Rgmsu8DgJo+QHnc2?=
 =?us-ascii?Q?WoeSQUNnQ4xFhr7h4XEssE3I+VCiy3F6oQUf6Pmj7TBkR8c6ALuFzkF+cn7e?=
 =?us-ascii?Q?aLUIrZ1Kb2Q3XDyna625QPJCDefJ68jmixXixzsSVIY8351CM/vVyIeLy1QB?=
 =?us-ascii?Q?SjLiN+fQseBdj6ymXKc0BSUIcizYUoJhMXIlfbBq2HeBIJEb7Xcjc+b0EQYY?=
 =?us-ascii?Q?QeBYLWTUF7W4bdCVfiXxkVKJPYm/ESTRYzJtqAmR+MFQIRbGWuTuLEE2NwcL?=
 =?us-ascii?Q?YhQpvcb2Meuub8/vsUECKt8i1dti/qE1TkouxdixvnaUVZAboYgmER4YL0zc?=
 =?us-ascii?Q?SuPCcR8sP5XgwCx1BgoyzMt7WtGziY/oluZdGNzNd7ZjPfGXF7saqcjmBKU+?=
 =?us-ascii?Q?3BaNi8e6f4Bl0z4z8rAQiJvxEKTqh3TNXBUIfafP1CxsPLbfTrjV6B52M5Rb?=
 =?us-ascii?Q?D189Qspb8IqgVWAhjD8S9Wtv4WKk8rLG3v4fT+v9Qc/Qq0jVj+/KK99l9xFv?=
 =?us-ascii?Q?lQb3cJauftUQBFUG9lhysj4xR00SATo2VwqAAU0XyL9MmfN3eUYOkc5FXiRg?=
 =?us-ascii?Q?gTHuKzZAGZ5yVGdsOCOa8jggIhLF2PPi7GRukEb3X0/4s24BZ6lCEBe2gdCl?=
 =?us-ascii?Q?6cfKV2PKQrXa6HJoDbS179TkGCPQjHLpkKwrphpfiME+Eb/o/vFr0efN7z+A?=
 =?us-ascii?Q?pedYm9syyBALlToe/pyrDSUl0nGPQBgZNUYQOettT5G2C6NMrpmLi42Ssu7j?=
 =?us-ascii?Q?S4TtoHpj+w4/iH6FNioGHfSoVjd1Ft/eWiRu4XDwmrw0ogqC3N3DaiXB4/kH?=
 =?us-ascii?Q?//6SU6pDsikPc3kZH6bK5PDEKYuc9JokmM/5qgPmDKXXl4KFoWKCUw7fMm+k?=
 =?us-ascii?Q?GFAzXBl1MjD7KprrNDmSyD/qfNNdzVRKatjY5w1kLNicHGKMF0pyqRqDVekQ?=
 =?us-ascii?Q?rpY7odrEmC9LQzCL8gsE038anp08useqr8tPLWCWa/J2mgTxJWQqyHAAiBYp?=
 =?us-ascii?Q?HBVRmUGO12GegGc/RqCm3xQL/ROuK8HsCwHzlOpvuWszdf0jGBpJ39q5DUYL?=
 =?us-ascii?Q?TbX+Sp0AF0/BNCoDBOCiy6RhkVT+RLKgZ/lfRw6QFI/+HXsBdNlypvanWIUi?=
 =?us-ascii?Q?wIxAkKERH9D44wwtDmuu6JQeyk+rwHClbgyscPZ/2D80NdfcuKJoTn/wKKGR?=
 =?us-ascii?Q?TCwVUOntzhIoOHsCePbOYXbB1zuukpUJfUQ0UjdqMKJO/NcFwDXQFjiDrAsL?=
 =?us-ascii?Q?idWs0aNe6AugYnxUXq+bp+tVdxcBw7Ooi7EmJHJkRCtjPXDfakIxnFCjTInV?=
 =?us-ascii?Q?IJs6GXEqI62H06RKdiNCpAE9a4Ga99dJGsDtrMwqVZm1jl1cIbtYywTuEXJK?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5faf8f-d30f-4746-8415-08dcfd430d35
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 02:39:20.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4QG3A2y46pYy3EXTMPKsC43zIsAJT2o6IirXinPg4iNrfXuy4nwSGsMWnKPtfqd9NtgY2LuaQIOkEz5VBnkqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5081
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h" on:

commit: d83bdef3f16d8ab604c50c6328ebfb439fdc94a2 ("[PATCH] Fix BUG: KCSAN: data-race in fat16_ent_get / fat16_ent_put")
url: https://github.com/intel-lab-lkp/linux/commits/Daniel-Yang/Fix-BUG-KCSAN-data-race-in-fat16_ent_get-fat16_ent_put/20241029-043546
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20241028202645.412589-1-danielyangkang@gmail.com/
patch subject: [PATCH] Fix BUG: KCSAN: data-race in fat16_ent_get / fat16_ent_put

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20241102
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: syscalls-06



config: x86_64-rhel-8.3-ltp
compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411051037.304ba029-oliver.sang@intel.com


kern  :err   : [  377.372938] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
kern  :err   : [  377.382306] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4784, name: fallocate05
kern  :err   : [  377.391362] preempt_count: 1, expected: 0
kern  :err   : [  377.396140] RCU nest depth: 0, expected: 0
kern  :warn  : [  377.401018] CPU: 1 UID: 0 PID: 4784 Comm: fallocate05 Tainted: G S                 6.12.0-rc4-00129-gd83bdef3f16d #1
kern  :warn  : [  377.412292] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [  377.416956] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
kern  :warn  : [  377.425444] Call Trace:
kern  :warn  : [  377.428639]  <TASK>
kern :warn : [  377.431476] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
kern :warn : [  377.435880] __might_resched (kernel/sched/core.c:8654) 
kern :warn : [  377.440575] ? __pfx___might_resched (kernel/sched/core.c:8608) 
kern :warn : [  377.445767] ? __find_get_block (include/linux/buffer_head.h:324 fs/buffer.c:1352 fs/buffer.c:1406 fs/buffer.c:1398) 
kern :warn : [  377.450700] __bread_gfp (include/linux/kernel.h:73 include/linux/sched/mm.h:321 fs/buffer.c:1433 fs/buffer.c:1491) 
kern :warn : [  377.454958] ? generic_perform_write (mm/filemap.c:4056) 
kern :warn : [  377.460334] fat_ent_bread (fs/fat/fatent.c:109 (discriminator 3)) fat
kern :warn : [  377.465379] fat_ent_read (fs/fat/fatent.c:369) fat
kern :warn : [  377.470339] ? __pfx_fat_ent_read (fs/fat/fatent.c:350) fat
kern :warn : [  377.475821] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
kern :warn : [  377.480406] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
kern :warn : [  377.485514] fat_get_cluster (fs/fat/cache.c:267) fat
kern :warn : [  377.490800] ? kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
kern :warn : [  377.495555] ? __pfx_fat_get_cluster (fs/fat/cache.c:226) fat
kern :warn : [  377.501252] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
kern :warn : [  377.505815] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
kern :warn : [  377.510897] fat_free+0x47b/0x830 fat
kern :warn : [  377.516070] ? __pfx_fat_free+0x10/0x10 fat
kern :warn : [  377.521767] ? unmap_mapping_range (mm/memory.c:3860) 
kern :warn : [  377.526846] ? __pfx_unmap_mapping_range (mm/memory.c:3860) 
kern :warn : [  377.532406] ? __pfx_unmap_mapping_range (mm/memory.c:3860) 
kern :warn : [  377.537943] fat_truncate_blocks (fs/fat/file.c:407 (discriminator 3)) fat
kern :warn : [  377.543467] fat_write_begin (fs/fat/inode.c:218 fs/fat/inode.c:232) fat
kern :warn : [  377.548557] generic_perform_write (mm/filemap.c:4056) 
kern :warn : [  377.553723] ? __pfx___might_resched (kernel/sched/core.c:8608) 
kern :warn : [  377.558890] ? __pfx_generic_perform_write (mm/filemap.c:4018) 
kern :warn : [  377.564575] ? fat_update_time (fs/fat/misc.c:359) fat
kern :warn : [  377.569774] ? file_update_time (fs/inode.c:2383) 
kern :warn : [  377.574729] generic_file_write_iter (include/linux/fs.h:821 mm/filemap.c:4184) 
kern :warn : [  377.580005] vfs_write (fs/read_write.c:590 fs/read_write.c:683) 
kern :warn : [  377.584135] ? __pfx___might_resched (kernel/sched/core.c:8608) 
kern :warn : [  377.589309] ? __pfx_vfs_write (fs/read_write.c:664) 
kern :warn : [  377.593955] ? __pfx___might_resched (kernel/sched/core.c:8608) 
kern :warn : [  377.599121] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049) 
kern :warn : [  377.604737] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
kern :warn : [  377.610809] ? fdget_pos (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/file_ref.h:171 fs/file.c:1181 fs/file.c:1189) 
kern :warn : [  377.615141] ? up_write (arch/x86/include/asm/atomic64_64.h:87 include/linux/atomic/atomic-arch-fallback.h:2852 include/linux/atomic/atomic-long.h:268 include/linux/atomic/atomic-instrumented.h:3391 kernel/locking/rwsem.c:1372 kernel/locking/rwsem.c:1630) 
kern :warn : [  377.619204] ksys_write (fs/read_write.c:736) 
kern :warn : [  377.623369] ? __pfx_ksys_write (fs/read_write.c:726) 
kern :warn : [  377.628150] ? __rseq_handle_notify_resume (kernel/rseq.c:333) 
kern :warn : [  377.633881] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
kern :warn : [  377.638306] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
kern  :warn  : [  377.644094] RIP: 0033:0x7f287cd67240
kern :warn : [ 377.648423] Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
All code
========
   0:	40 00 48 8b          	rex add %cl,-0x75(%rax)
   4:	15 c1 9b 0d 00       	adc    $0xd9bc1,%eax
   9:	f7 d8                	neg    %eax
   b:	64 89 02             	mov    %eax,%fs:(%rdx)
   e:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  15:	eb b7                	jmp    0xffffffffffffffce
  17:	0f 1f 00             	nopl   (%rax)
  1a:	80 3d a1 23 0e 00 00 	cmpb   $0x0,0xe23a1(%rip)        # 0xe23c2
  21:	74 17                	je     0x3a
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 58                	ja     0x8a
  32:	c3                   	ret
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 28          	sub    $0x28,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 58                	ja     0x60
   8:	c3                   	ret
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 28          	sub    $0x28,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
kern  :warn  : [  377.667929] RSP: 002b:00007ffd8d96db68 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
kern  :warn  : [  377.676231] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f287cd67240
kern  :warn  : [  377.684089] RDX: 0000000000001000 RSI: 0000562f0070cf18 RDI: 0000000000000005
kern  :warn  : [  377.691953] RBP: 0000562f0070b058 R08: 0000000000000000 R09: 0000000000000075
kern  :warn  : [  377.699805] R10: 00000000000001c0 R11: 0000000000000202 R12: 0000562f0070ce08
kern  :warn  : [  377.707660] R13: 000000000011f8ec R14: 00007ffd8d96dbf0 R15: 0000000000000005
kern  :warn  : [  377.715522]  </TASK>
kern  :err   : [  379.995791] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
kern  :err   : [  380.005158] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4784, name: fallocate05
kern  :err   : [  380.014176] preempt_count: 1, expected: 0
kern  :err   : [  380.018931] RCU nest depth: 0, expected: 0
kern  :warn  : [  380.023773] CPU: 1 UID: 0 PID: 4784 Comm: fallocate05 Tainted: G S      W          6.12.0-rc4-00129-gd83bdef3f16d #1
kern  :warn  : [  380.035011] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
kern  :warn  : [  380.040515] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
kern  :warn  : [  380.048964] Call Trace:
kern  :warn  : [  380.052128]  <TASK>
kern :warn : [  380.054943] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
kern :warn : [  380.059321] __might_resched (kernel/sched/core.c:8654) 
kern :warn : [  380.063957] ? __pfx___might_resched (kernel/sched/core.c:8608) 
kern :warn : [  380.069112] ? __find_get_block (include/linux/buffer_head.h:324 fs/buffer.c:1352 fs/buffer.c:1406 fs/buffer.c:1398) 
kern :warn : [  380.074008] __bread_gfp (include/linux/kernel.h:73 include/linux/sched/mm.h:321 fs/buffer.c:1433 fs/buffer.c:1491) 
kern :warn : [  380.078211] ? generic_perform_write (mm/filemap.c:4056) 
kern :warn : [  380.083544] fat_ent_bread (fs/fat/fatent.c:109 (discriminator 3)) fat
kern :warn : [  380.088535] fat_ent_read (fs/fat/fatent.c:369) fat
kern :warn : [  380.093431] ? __pfx_fat_ent_read (fs/fat/fatent.c:350) fat
kern :warn : [  380.098847] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
kern :warn : [  380.103396] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
kern :warn : [  380.108467] fat_get_cluster (fs/fat/cache.c:267) fat
kern :warn : [  380.113714] ? kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
kern :warn : [  380.118438] ? __pfx_fat_get_cluster (fs/fat/cache.c:226) fat
kern :warn : [  380.124121] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
kern :warn : [  380.128669] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
kern :warn : [  380.133222] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
kern :warn : [  380.138290] ? __mark_inode_dirty (fs/fs-writeback.c:2519) 
kern :warn : [  380.143358] fat_free+0x47b/0x830 fat
kern :warn : [  380.148518] ? __pfx_fat_free+0x10/0x10 fat
kern :warn : [  380.154205] ? unmap_mapping_range (mm/memory.c:3860) 
kern :warn : [  380.159272] ? __pfx_unmap_mapping_range (mm/memory.c:3860) 
kern :warn : [  380.164774] ? __pfx_unmap_mapping_range (mm/memory.c:3860) 
kern :warn : [  380.170279] fat_truncate_blocks (fs/fat/file.c:407 (discriminator 3)) fat
kern :warn : [  380.175792] fat_write_begin (fs/fat/inode.c:218 fs/fat/inode.c:232) fat
kern :warn : [  380.180868] generic_perform_write (mm/filemap.c:4056) 
kern :warn : [  380.186024] ? inode_io_list_move_locked (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/backing-dev.h:51 fs/fs-writeback.c:87 fs/fs-writeback.c:130) 
kern :warn : [  380.191703] ? __pfx_generic_perform_write (mm/filemap.c:4018) 
kern :warn : [  380.197379] ? fat_update_time (fs/fat/misc.c:359) fat
kern :warn : [  380.202544] ? file_update_time (fs/inode.c:2383) 
kern :warn : [  380.207440] generic_file_write_iter (include/linux/fs.h:821 mm/filemap.c:4184) 
kern :warn : [  380.212682] vfs_write (fs/read_write.c:590 fs/read_write.c:683) 
kern :warn : [  380.216799] ? __pfx___might_resched (kernel/sched/core.c:8608) 
kern :warn : [  380.221956] ? __pfx_vfs_write (fs/read_write.c:664) 
kern :warn : [  380.226592] ? __pfx___might_resched (kernel/sched/core.c:8608) 
kern :warn : [  380.231750] ? fdget_pos (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/file_ref.h:171 fs/file.c:1181 fs/file.c:1189) 
kern :warn : [  380.236041] ksys_write (fs/read_write.c:736) 
kern :warn : [  380.240156] ? __pfx_ksys_write (fs/read_write.c:726) 
kern :warn : [  380.244880] ? switch_fpu_return (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 arch/x86/kernel/fpu/context.h:79 arch/x86/kernel/fpu/core.c:787) 
kern :warn : [  380.249777] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
kern :warn : [  380.254159] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
kern  :warn  : [  380.259924] RIP: 0033:0x7f287cd67240
kern :warn : [ 380.264217] Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
All code
========
   0:	40 00 48 8b          	rex add %cl,-0x75(%rax)
   4:	15 c1 9b 0d 00       	adc    $0xd9bc1,%eax
   9:	f7 d8                	neg    %eax
   b:	64 89 02             	mov    %eax,%fs:(%rdx)
   e:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  15:	eb b7                	jmp    0xffffffffffffffce
  17:	0f 1f 00             	nopl   (%rax)
  1a:	80 3d a1 23 0e 00 00 	cmpb   $0x0,0xe23a1(%rip)        # 0xe23c2
  21:	74 17                	je     0x3a
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 58                	ja     0x8a
  32:	c3                   	ret
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 28          	sub    $0x28,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 58                	ja     0x60
   8:	c3                   	ret
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 28          	sub    $0x28,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
kern  :warn  : [  380.283678] RSP: 002b:00007ffd8d96db68 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
kern  :warn  : [  380.291958] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f287cd67240
kern  :warn  : [  380.299803] RDX: 0000000000001000 RSI: 0000562f0070cf18 RDI: 0000000000000005
kern  :warn  : [  380.307644] RBP: 0000562f0070b058 R08: 00007f287cc6c6c0 R09: 0000000000000075
kern  :warn  : [  380.315488] R10: 00007f287cc85b98 R11: 0000000000000202 R12: 0000562f0070ce08
kern  :warn  : [  380.323330] R13: 000000000008fc76 R14: 00007ffd8d96dbf0 R15: 0000000000000005
kern  :warn  : [  380.331176]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241105/202411051037.304ba029-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


