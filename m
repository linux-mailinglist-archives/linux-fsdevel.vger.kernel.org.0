Return-Path: <linux-fsdevel+bounces-28381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6962F969F69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213FA283700
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673017BA1;
	Tue,  3 Sep 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrIkO3aN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593F1CA699;
	Tue,  3 Sep 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371605; cv=fail; b=m7wUuMpqM3bPpMPG+WGJpeBXizvVe4x8Y7OKFdNNqQOe6bkqENObmpxKywcSdwuFniGCh3mOtvho8SCFExMClUafPjrP9MuDp0zluDOquvYb/MqMviveTRz7mFwVDOW0DsJCLXSnWmO6gwY+SghLBdZ7N8NSwtoRaOLiMyqWBmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371605; c=relaxed/simple;
	bh=0haVeSzFOQQy+WcJHJ6MSTh0r9Ef5J1rCsVGRf6IMIA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cQqZ9zC7a0LbyWb9YFTbP+iATR/V3SkQbVKJVLk48Qx2Fatj+RODDGGeRqIR/5nO+s+nMcEE0OMY5Z6fl5k9pLTDrlDSVLvxFoKCN+VphlpRKMfqrJKx8YnGvZQoaHgTVXMcHCAH8xKHx2xQpTFqkock9dMIhy6A9Z3+1xE3he4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrIkO3aN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725371604; x=1756907604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0haVeSzFOQQy+WcJHJ6MSTh0r9Ef5J1rCsVGRf6IMIA=;
  b=TrIkO3aN24wdPxw7sDIdXYpQ77K+3vHLpzK+nYe7n7qvDcus6F6h7/9M
   2zN2yJwLkT+CcrvKU1525g3rdcDZ06MCJzWZrevb9Af3xdNguH9PjUW/6
   FBDYNm/jAU5OFlquF5Hl59x+o8iwHu+CQhQ/N/Eh+Sft0CmwkF4Unt+tN
   Tpaj+LOFaxyXQeGRlcpxK03qOfAuHl+WlY4d3TSHzwHIsRaFSitPg6xFF
   KJwsJ2et9sXqrbwzYYXMGYFkVhOjssdHb8SrOwejNnzhNT2ITlklY3aX/
   uoY+B0dlv2KXoVa67JBFiGuT8WYWxZ3lzX5w7DIsR0t3SeF568eLBiuee
   w==;
X-CSE-ConnectionGUID: WMGY4115SfuNtyzcpUHTPg==
X-CSE-MsgGUID: 3dYX+zXvQ52FBBpRMfl75Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23845580"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="23845580"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 06:53:24 -0700
X-CSE-ConnectionGUID: H4jXBGQySzeaQLdk/Pm2pw==
X-CSE-MsgGUID: wc7b0T9bQPiJc2VqlF0kYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="69546227"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 06:53:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 06:53:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 06:53:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 06:53:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 06:53:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAfklxXrroKXoeiutt6S6ulHVG6T/TDhxnWLUsZzxOXfyWXiB4ke3seYqMD2u48mqVchcExC2E6LV/ZxE7eu8L0/246lC9yUPMfT8vmBvySqGMz3lAqWuwoyLD2A+lGPnVye00Yr4Txs0vPtobXGehuGTddDWGv5fq65OVj3VZ9ixWvyIrkGKTLBoVme32r+jLXeVPEngPnvLNYG4tvBVK8f74ojLXhF6uzv+gyh9htWpsCLHBPx+P+KAUxUipkf89sd4llSQtDVfWJqFCjTz9JU6WMF0QHb5/nXAp5+q5/WVUPYVwZzugZs/DPKiSXhRxbFv4NGEciWPiAvORqpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvCRbFk69n+yRF9BGnMP+rKXQYx4Hc+tQ129u6yUofU=;
 b=vB9hemKWhPN8IRkT5PAMtb/6VmrGDiQ6nDDoedMdZ2i9WWKpgw0Z3srutSZ485E+Fxbnl1szDrFiM7bRLuGXnSeBvXG2cX1AT/MvyFfL5PNI2yLw5v21TkFpyX1XUUrhMfMdWhZZhsOpD6B3uhR89zh/7jmM/YQgSJLbAQHloSMfK8B/D8/QpewOw5G+L/230Q8HEpS8Jca/Oqhm/kLOMGKnzx0IaOYMztne9uNpBuwOrrPoqnh9dek5ujyOGbhzJshQu07O3IGYUDu6N2mVRZWuwmSTFkFa/BJjG7zIuFjgk92ZaB6tzub2GgklV6gb2tb7Scmzwvt14ic+HdYsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5771.namprd11.prod.outlook.com (2603:10b6:a03:424::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:53:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 13:53:14 +0000
Date: Tue, 3 Sep 2024 21:53:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [brauner-vfs:work.f_version.wip.v1] [proc] e85c0d9e72:
 WARNING:lock_held_when_returning_to_user_space
Message-ID: <202409032134.c262dced-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d4cda9-87e8-477f-a120-08dccc1fc169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cZZDF16Brf71TNjgNmIl0MjRvWRAAN3axwVdFampRnfOGuGGMioHhPcI/Ug1?=
 =?us-ascii?Q?YTsg2nSB28sUyaod+huzn91nZpj1RDFYUam4mzT58/qB4TnLxbM48PRwwfNP?=
 =?us-ascii?Q?XMMPm/o7NCVBocE4N6Ch1yslBn4M0Q1hrxTxUb3lmacEFoDEM+spiJCMkmMW?=
 =?us-ascii?Q?87+pHBOoHyppiIcVYuE5s0xKwEwDfA31KMIHLeCLssfTvxXJeLxRx7LAIly3?=
 =?us-ascii?Q?FhlOSB+YjstnKx+Vb9fMOsQ1M4Q4r/q5MlVdXjxdB9th4NJ9lQFVsaUyNXtw?=
 =?us-ascii?Q?DN1Ap3/Di3yQnBQ9jeti/IsB3FRpP0d750o7QGBBaDPEf7cWXOcOH49y4q6j?=
 =?us-ascii?Q?GjxiUZhD6waxFzeW4Uh42wTgMHRcyk8nRv3sykgMWLrEzvnknNdFp4zj6Eu9?=
 =?us-ascii?Q?zgsTDnNusvxzQLm/yHjQfyphW9Jn4htDwR9JP+KdUiPs0rwoQjdYP/C75yKn?=
 =?us-ascii?Q?/HTYq02T2HIPKeH9ZmgYSHKp+YUq9hXzmngOtY78xyu5bF1AeKGfYAibL4jW?=
 =?us-ascii?Q?VbqxNX2740ae19MMAmVr50xl6meOt27PLhoRMM8pjRiRByn7n/sv+4ZmN9ri?=
 =?us-ascii?Q?V952c2FbIVI2EjVJBtVfvIIkd2iOoZ8bLkDS6TNN+mfeyH3hwlhVGfyynqOq?=
 =?us-ascii?Q?wRfqZhnya1BKVa7cv2IgHQP3gMA8zwmWWQeJS+Sp8k1GSpCM+Pj0TLilluAd?=
 =?us-ascii?Q?LkawzYlrII1+bUhPSA0LIma+tbQpoBzcIxxIRKsKyRMvsq/1kv0zn3Dx8yJq?=
 =?us-ascii?Q?KtqR/0qAPUMQUv0RdhankxrVovSflRf7UCHVQ5YTUVykJ/+HKYI4npm7XvA2?=
 =?us-ascii?Q?Cb7+rMm5cGs/auIZH+K7+zPUs0c9XcGEnO2EoLWnPjZz3DjKJ00k2sD7S0RC?=
 =?us-ascii?Q?xvMdZIzkkx/h5p1gHDfg3zYZ+aYqniITWDs+NgkzORPU03TDdj4G+O/qIts1?=
 =?us-ascii?Q?5zE2QwIekylLZBNd8cP1bcfSjMEQ6BYwm2y3dDDFt6Fgf8l6doMGD66KPY+s?=
 =?us-ascii?Q?wHSBKbn9hWuYO5ZFRZ/ApPpjXLGn7MtPFluMyvzZRQweQ12GE8FL+mUuvOMe?=
 =?us-ascii?Q?wglBZktKgYdrMWo+R7fF5Xf4pEvLKeq/Kj9hggE35a0FUyc4wL7sOVq+uTrg?=
 =?us-ascii?Q?RmErgb/b03/YjLMrGH8wU2p0USZ325Wq6lvvqWk7Y0E3tuTJERiitDgvcwmV?=
 =?us-ascii?Q?fkRMcig/HCI3NEihgBIBifr60w5NoVgRz6El/jseR3sdGKwEZiB0aMYuvmVI?=
 =?us-ascii?Q?qOmE8sOg9UwiygLCk2X6uvzVGsCIxhknnLBBbWZAZvBETUwHFDAGFfcs5+z0?=
 =?us-ascii?Q?MSA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eXdH1/0zYorCLqXJY6oghf3UOU2Xi/yBIz9JwGxBqVV16AOSAqRwsZUMmx5n?=
 =?us-ascii?Q?VAEFqVwwP7vXXVETcb+SqBn9izQfbSBNcyFyMEVXDL3LN22krSKs9nAUOLQp?=
 =?us-ascii?Q?xjxZeU25EtSxNJJTD63PwsKvwXPYUjh8qxF+vpAdvPOI8ct/ebb689GvJfVZ?=
 =?us-ascii?Q?T9I7tdh5Mk9FWygz1gGvza5UuFRBUyjaxCS01rgTTS88wJw3n02kX874Amec?=
 =?us-ascii?Q?VgVCM9SGBmUJB31/EMDj1hHOQHVvTjXX1mUnVgmAsfgfxrFr3lKev+ElSaz2?=
 =?us-ascii?Q?BP2lhQIQiqfw24gxTqlc2XHxReshohGbIe6bhZyBGK4Jl7vuAmCHna4POra4?=
 =?us-ascii?Q?XXMJZbMgtYGCcEclKrpT1tty0z9XKZIu4n85Q7ICMu2s9ZwQVM0Pkz8k6ExZ?=
 =?us-ascii?Q?0wAEajJzH6J7mYKAJzZhg0lernUBVp6XLzVJ7kfl3OReIS6kqrKcHTo/AZh9?=
 =?us-ascii?Q?fyZocpm4n6DNOjR7rFLug5VDaG+woTnYutzHGKGO6eRcpMHMC2hmqmkjEFAc?=
 =?us-ascii?Q?R+IzILq6ST177stI8/1hEwXihZQz3+duA37TdTJUa0HXc0qkPPJE8AC/3jb1?=
 =?us-ascii?Q?/eZhcWGtdROiR/f0CBfddNhKCXEfwC5hHjn9jbfcDV7jsy6DdomdX04+tSm8?=
 =?us-ascii?Q?PnDcXsma/Nz/Cwo6CAI2UoqLxAZNMwfCRewJgkk1HEnm6if4JS1eDEnzX1uR?=
 =?us-ascii?Q?gOiYFmNJ05id9QuWcDCoErgIr41l9vBEIk/wtrBIOLlYyICnG2Vhe6vSyGDW?=
 =?us-ascii?Q?5tDU2yKh2dFL8WV5vRtTJszYUr6XfaSiBXAArMwy7/JNjWwjf/aiE5onJLwY?=
 =?us-ascii?Q?Pn+YF/PFKGxDKdLpfTJdz23NxbZlcgrncMrx8/bk1ddPpdav3s8vQqb24TAS?=
 =?us-ascii?Q?mUGkal4cr6PZmLphOZRDiVtwy72DEUwmorKKsNKdWysmdfuAJFFT4s4h8PE6?=
 =?us-ascii?Q?b2KuykGHkyfeQSxg8Kj1AbCHloFF/hh/KW1Qbe5WkRT5BpurGj2OTXxSxTfJ?=
 =?us-ascii?Q?OWSdho2VgltoceVIPhXoFuXE5Zp1Gvv+mM2CkAKv8SAVlpq48CURP7wggxDV?=
 =?us-ascii?Q?USUNlw5fq/6tCCoe65Koc8OpPlTB62v/p+k1Pv2ofHCCE9wrn1Upv5QNqx0g?=
 =?us-ascii?Q?ynN4FQ/8cd0NFvYGvQ9ihZhn4FSK2epr1dGXEGwor1mHxZXS97GqiaXirxaC?=
 =?us-ascii?Q?yr4NQAfZ2v/D4jhd2eRaCa6eHsDk6na2OinZTWF7y6NmXlEgkRp+BAuwlait?=
 =?us-ascii?Q?HmdHcZ6Lr+UgZt61fXvKB5OhQISmT3YpQiwBHiN6y4Z67oT17l8ttCWc4WjP?=
 =?us-ascii?Q?8eMP0Z9o7gAoPk4IPrv67o66oEGdE69ncyNyvE7Vs0kH6rOPwnSWwuvRY5Dn?=
 =?us-ascii?Q?vKmKjMuKYyoB78TO4eVxFCYptzAlMhCDvFBYFeE+ErLRcOJWzueuGc0WE1Mo?=
 =?us-ascii?Q?BnHxVnIgMBqEUtS/lmhQFc0zr3fycSTXrm6KgoVWVJFOQMwXaKu/Wn8Ax53Z?=
 =?us-ascii?Q?awkVEKrgUMZagKDnHnXb3JgS+0WGcbWlxJx+EOC/1zoAbLnHxSrlckuLwPcs?=
 =?us-ascii?Q?ZN2p38wXm8BKfPbVTxfCTrgxV7mrPCKdVo1Bt3RzTRHutYyhjW824hwiM9Nk?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d4cda9-87e8-477f-a120-08dccc1fc169
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:53:14.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AaMzMDjnP1sAcQqArjcbhSd+9Cunxxo24iM8kX4Q1HsvNPyvPFf45QII7c9x8yWiroi0oRJce1yeIruFaUXFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5771
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:lock_held_when_returning_to_user_space" on:

commit: e85c0d9e725529a5ed68ad0b6abc62b332654156 ("proc: wean of off f_version")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.f_version.wip.v1

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


in our tests, the issue doesn't always happen, about 47 times out of 200 runs
as below. but the parent keeps clean.


0aa860d0152c07db e85c0d9e725529a5ed68ad0b6ab
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200         24%          47:200   dmesg.BUG:scheduling_while_atomic
           :200         24%          47:200   dmesg.WARNING:lock_held_when_returning_to_user_space
           :200         24%          47:200   dmesg.is_leaving_the_kernel_with_locks_still_held



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409032134.c262dced-lkp@intel.com


[  244.794661][ T3669] WARNING: lock held when returning to user space!
[  244.795232][ T3669] 6.11.0-rc4-00021-ge85c0d9e7255 #1 Not tainted
[  244.795771][ T3669] ------------------------------------------------
[  244.796336][ T3669] trinity-c0/3669 is leaving the kernel with locks still held!
[  244.796995][ T3669] 1 lock held by trinity-c0/3669:
[ 244.797435][ T3669] #0: ec876814 (&f->f_lock){+.+.}-{2:2}, at: generic_versioned_llseek (include/linux/spinlock.h:? fs/read_write.c:195 fs/read_write.c:220) 
[  244.798313][ T3669] BUG: scheduling while atomic: trinity-c0/3669/0x00000002
[  244.798960][ T3669] INFO: lockdep is turned off.
[  244.799396][ T3669] Modules linked in:
[  244.799732][ T3669] Preemption disabled at:
[ 244.799734][ T3669] generic_versioned_llseek (include/linux/spinlock.h:? fs/read_write.c:195 fs/read_write.c:220) 
[  244.800712][ T3669] CPU: 0 UID: 65534 PID: 3669 Comm: trinity-c0 Not tainted 6.11.0-rc4-00021-ge85c0d9e7255 #1
[  244.801612][ T3669] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  244.802509][ T3669] Call Trace:
[ 244.802803][ T3669] dump_stack_lvl (kernel/printk/printk.c:359) 
[ 244.803230][ T3669] ? generic_versioned_llseek (include/linux/spinlock.h:? fs/read_write.c:195 fs/read_write.c:220) 
[ 244.803716][ T3669] __schedule_bug (lib/dump_stack.c:128 kernel/sched/core.c:5734) 
[ 244.804116][ T3669] __schedule (arch/x86/include/asm/preempt.h:33 kernel/sched/core.c:5762 kernel/sched/core.c:6411) 
[ 244.804500][ T3669] ? tick_program_event (kernel/time/tick-oneshot.c:44) 
[ 244.804952][ T3669] schedule (kernel/sched/core.c:6607 kernel/sched/core.c:6621) 
[ 244.805309][ T3669] irqentry_exit_to_user_mode (kernel/entry/common.c:? include/linux/entry-common.h:328 kernel/entry/common.c:231) 
[ 244.805817][ T3669] ? sysvec_hyperv_stimer0 (arch/x86/kernel/apic/apic.c:1043) 
[ 244.806280][ T3669] irqentry_exit (kernel/entry/common.c:367) 
[ 244.806690][ T3669] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[ 244.807225][ T3669] handle_exception (arch/x86/entry/entry_32.S:1054) 
[  244.807678][ T3669] EIP: 0x77fad092
[ 244.808003][ T3669] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[  244.809763][ T3669] EAX: ffffffea EBX: 00000015 ECX: 0000004c EDX: 20000000
[  244.810399][ T3669] ESI: fffffff8 EDI: 00000001 EBP: 3d77df35 ESP: 7fa71c78
[  244.811032][ T3669] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000216
[ 244.811752][ T3669] ? sysvec_hyperv_stimer0 (arch/x86/kernel/apic/apic.c:1043) 
[  244.834705][  T225] [main] kernel became tainted! (512/0) Last seed was 2147483651
[  244.834712][  T225]
[  244.837382][  T225] trinity: Detected kernel tainting. Last seed was 2147483651
[  244.837388][  T225]
[  244.888320][  T225] [main] exit_reason=7, but 2 children still running.
[  244.888332][  T225]
[  246.959451][  T225] [main] Bailing main loop because kernel became tainted..
[  246.959463][  T225]
[  247.099951][  T225] [main] Ran 908890 syscalls. Successes: 341513  Failures: 567373
[  247.099963][  T225]



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240903/202409032134.c262dced-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


