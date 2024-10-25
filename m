Return-Path: <linux-fsdevel+bounces-32861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982C59AFC3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 10:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5828D281DD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 08:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EFD1D14FC;
	Fri, 25 Oct 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvvcEurC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AA1D0E08;
	Fri, 25 Oct 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843864; cv=fail; b=sVoBdxE9siCdwretyA0GPEZYVSaLRWx78cZUcXTsh76SBclvyE+QKv0zjODKLDfLJ+wBlJYwxEOJPxGgNDICdxIghK1QB9ZFuFf/hr9434LU1yCaJ+yBnwrnOVPTOENDpPtOlHz1BwfX05zpiXjmAzoJcrtg999bIs5UeiOPtt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843864; c=relaxed/simple;
	bh=QtNaCn+NgVLdBrWXPcUeNQRP7brAg/XECtqAzoTPVxk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nwvRCRHRRK3VBStuiHz4BL2yaIXBZyBx2z6r56O11M46TOuydPyEXrCTwFoDrJNlVq2O5URDOX7HYQFzlxpvnXRwInroggIoy1A0tMqHswvIPaRoiTek973+L5HJ6bcejOFKIQatzvNRLZLvb3W/xRQoQmCM3nJJkb2rb5O+KMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvvcEurC; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729843861; x=1761379861;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QtNaCn+NgVLdBrWXPcUeNQRP7brAg/XECtqAzoTPVxk=;
  b=nvvcEurCJVchZnB1De9zS7Q8iIARQSO+jHyWFY46A+K/CARjPhk05/Dv
   03PWRMt7w+XrdzuXxhRactCmFsmRqysfawVV0hMYHwuJkFXkGTHficIm5
   KyBLtHPRR2Xh1dhU3L5qaKnui38UYCiYSrNbRqjQ/0mHCU4RFpY/ipibQ
   c4vdlYRBGG4Aik7d7tXlRwJVGA6QBJ9AWLoha7LYhf+ziG3rEcew/fy86
   +sNUIdXR8OS0KuoC3cYFcN3+VOixrpSNBy2lPop69uJCNjNc24Psj9oM8
   1O1wwZdIQBn/ij0eChcyfvZ+Yl8JeP6FlhFCs2CoMF08w6aCQtUYMKP7h
   g==;
X-CSE-ConnectionGUID: CNpXS0tFSPW02VLghJpeEg==
X-CSE-MsgGUID: QsewTwI7RIaNol7l2M2siw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40879310"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="40879310"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:10:58 -0700
X-CSE-ConnectionGUID: w+j+gAtERBCbb6iQPN+bSw==
X-CSE-MsgGUID: j/021AIMTCm4cmzA1ZikIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85639813"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:10:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:10:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:10:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRhE5vZW36JzZZrWtY1sTvhtYsEQEDxYZkeVW5SAeNrWyzdcryARxfj5fgSB25/IAN+VovEsuGTRdoeKKkIVTvUurnFLXqqkJX+6HIALORf6vTZsPYTcXVR0pL7I9EHv8Qv4fvp3+jpcDHrnydmYtqz2YNCS04EXVM6LbCmBxx+SwPXfddbmRAii0EfurWUZiMu9A6u/tOHGfektmQ+fRKfyv/WTYwi2UQGj9bcnHVmuXklJaTgYK+k+ar/xG0nHiNuDRq3nZvMRu6wiXr5DQO/0afwZgz1+kcGc4CqMNkIdKKm7pWPkc6UMm41JzdDvmQzbpefeQ6mPqJfFTJ5idw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcUADq9NStYfYwxDIhUblUBkT69GuhtsjvE2GqtLWQQ=;
 b=nuyCmB+cbI8ueG11Xkwc1sp7BEUAkbFCy7cjcFu1AbSVwN2nOtr86S1Pn/Eu7iItRJu2cYcBaxOiWD7+CDYHwiv3ImemM+//hYZtGo7MRANGKEttpuiMeSingblPBmcgmjwfgQbxtMw5Or9TP9FAJyUzOsKKBz/5nwLgg1x6iM4v2K2CLrSAYKimBpIQ2jLwT7fxPPEoW22V9yDZOT9l4u8YJYrWzCqviJUIvmnBTv4cplvUGBGfK1EaKTW4z3fZQkdr8HdQGg9c3+HgwV8oBW+EUBo5Arcl4IBYRVaupXHG3prKJM6xfeJKXWB3IjJMWxPLB2ZRZl2ywIMsf8mjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5314.namprd11.prod.outlook.com (2603:10b6:610:bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:10:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:10:49 +0000
Date: Fri, 25 Oct 2024 16:10:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Shuah Khan
	<skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>, "Christian
 Brauner" <christian@brauner.io>, Shuah Khan <shuah@kernel.org>, "Liam R .
 Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, <pedro.falcato@gmail.com>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>, Oliver Sang
	<oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 4/4] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <202410251504.707d78fc-oliver.sang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9851fa9f87d22f352f960b847d99459ef7d74a1.1729198898.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: accf04f8-65ea-49f7-ce17-08dcf4cc8900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2tJTm1rNkpwakNIaDE1QkpMK3hlUlZuYWFCTnZTVnMrRlkreWxPQlhtQlRw?=
 =?utf-8?B?Mit0S1k0QkN6RUQxNExVelhtak5nSStsZGJEUTRTeml0OFhuUlNNd1l6cjh5?=
 =?utf-8?B?cmtRanhEUGxRR2ROVE9PTFRPd1o5RThFZm1mUXJtbjZKV3pqdEpXTHgzOXJF?=
 =?utf-8?B?S2dxa2FsOTNIbjQyOW5iQnZZa2wxWjNvWVFpU2Q4dU9xaFpMZldEOFFsNk42?=
 =?utf-8?B?eDhwY0dCSGZhVGY2U0dlUGlMNGVYWHBkS29vUjdnczlUeHIzODFlY2lydzIz?=
 =?utf-8?B?ZlJ2Q0hxalVhZ09rYXlEbEpOWTRlREdOdjRyZGttMG9SUmRCWlBLcTR2V1hM?=
 =?utf-8?B?bnZKTE9CRVlGbWlpbUUwRm14czZ3VjhGMVZTemtoVkVReE5OWHo2dS80VGhh?=
 =?utf-8?B?Ukp1TTRJdG5FMm1GWDQ4bGVrNTRpRmN3aC9BZjJBejNzV21QRnJ0OWFGQmNE?=
 =?utf-8?B?SWFFL0ZReHdkUjVaSGo5ajZsajM5aStpNlhDbEc5akpET2NjcXhjQVZFYXdj?=
 =?utf-8?B?NzB0OENaOUNaeFltSEU1VG02eUpVM0lRdFpyeEZzL2RvNkN0ZkR3czdQRjAx?=
 =?utf-8?B?UEJ2RVB4Yk9QeVYvUkhLU3F3dUEwdCtCRUFiVW5UdUthcHBEN3U1T1QrL2dm?=
 =?utf-8?B?bDcyUksvM1FncExLTlZBZW1EM29uTndUZUhPUmlVWjlwd1V6TmFUNzRnNXNW?=
 =?utf-8?B?eVk2WjUxQUFkQVBNQUxtdGszTmxTQ0RDdHJmd3VCWlllUnh1SVptUTJub210?=
 =?utf-8?B?S1RZWTdvZjhXKzRJRzdmOVJnK0pqdFREZW1mOEwyUUVVZFZJcUNRME9vN0dS?=
 =?utf-8?B?TmJQcmFIYzlzaFFNRjBVNUJUZTRSMjA4WUJvVmZYVlhKcEc5OENQc3U1UDJM?=
 =?utf-8?B?K1gxeTYxbThQbm1VektwWm5mYmFHTTdKVUhSSndkK0ZFNnl5UjNVN0tyMmIy?=
 =?utf-8?B?VUx3Sk1hWFpQc1VCeWlXVW1pTXFvV0k0ZnJHUm05aEdINjY1dmRSNFhlc2FF?=
 =?utf-8?B?VDl4T2FkQzQ5R1kvSjlUU2V0T0hyQ3V2dW5JT1MrY0lMSnZiK2cvUlFYcTA3?=
 =?utf-8?B?ZjhFdWtINm42SE9jUDZuTHlOUDhUTHNsK0U1dzE1Uk8zdDlXbTZsUlMxeE5O?=
 =?utf-8?B?R1BaZEloa0tCcXlFc01QVVdpOVlFYkdKK2xWQW41RkJlUzVUa0tKMEJ5aW5v?=
 =?utf-8?B?a2dvaUREYXZqOHlwclo2V1VRM0VEQnhvZTNJM3M3aHZzZmhKUnFSVTNiUXpr?=
 =?utf-8?B?WjlnYzNHUDNPODByK21LakczTTVhV2wyZHAwdWh6NDhseW1ZbzBSclViM05n?=
 =?utf-8?B?NjJRU21TTGdzVVBRRkIwNEM5NWxub0RrQU1RcTdibnBuSElpeHhBZCtld3BV?=
 =?utf-8?B?ZlV3K2hEOFprdjU0VFBaQ3JOb1JkS2IxaFNYTEhPZXJjZGJLSmg0ak5nUldk?=
 =?utf-8?B?MUR4VUR0dHhHUWdPa0dEZGZ4cHJTZW1sSGE1a1VScU04Wm9xRThyUTU4Y3B6?=
 =?utf-8?B?WHE3Q2ZyYi92NjNEUDFuZ0tGNytRUndOL1Y3V2V1bTRIL1JEMTVNMkNMUnlp?=
 =?utf-8?B?SHlqUERsVnlwN1lnbmIrRXI4YXNrcGFRUDIrMk1QdThDSFYwL0Y3cXV0dm53?=
 =?utf-8?B?UmQwSExDazIzQjh0WE9yeWYrS1hiUmtxcDl4QTFmTERFOUMzNmpxcnAvanpB?=
 =?utf-8?B?WGxLOGJhQk44ZmFOa0VCb0NQUDVDU1FHVmVLMDgzWjc2Q2h2bHlxbFdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2pRUXoyZFdteGpIVm1WM3pZOHBXRmQrcDR5YlNYbFE1ekhJMmRKWXpxVVJ1?=
 =?utf-8?B?TDNRSmhDK0U3a0wvQ1RJdmxwY0lEY2NkamdDZXJiTVIxTW85YXhCWWRJNmJX?=
 =?utf-8?B?Smo4dlMwZEljV3RPVXZHQnVFTUtWVHd0cUZPVng0aEJvSmJHditLQjU0MVlu?=
 =?utf-8?B?WWd3U1NiN1VMcDA3cElIQU52bXBpaWp3TDRlRCsrU1h2cmVkTGxCVll5eWxs?=
 =?utf-8?B?TjdOZ01xdVhmdUdJMmE1U1MwTjAwSmFvWGRTblVPRGtvL2ZFakhERlBLaFg3?=
 =?utf-8?B?TnJOb3ZtQkFkQlhVdFJGM0R6MzJDK0x6OEtjTVhBbDVsUkl1dU95RGI2RThm?=
 =?utf-8?B?RkJkclZJVzVlUWJacFpwdHpVQ1FWaFdKMS9mNDBMVzNVR1VURkZLdFR5cHZG?=
 =?utf-8?B?eG93VnJIUXNJMjhtcmJIdU5EdmRQaE1zQmZCd2thSk1rMjFSWXJBcmV6a2RW?=
 =?utf-8?B?Qkx0aDdHTGxXL2VDUUVENEt6emxOVVVPR2xrbkpGZERxM2luRDVjRE1sZFdt?=
 =?utf-8?B?blErSE9zaWVYT3U2UGY5N2prYWh2UFdIME9kZlVSTjB3enJjL2RFaTdscGph?=
 =?utf-8?B?bDVFODgzQytBYjNyVlNFb1JVb2NFcnd0eUhDVSswbVVPekZLTWZCUTJNeFU3?=
 =?utf-8?B?bG1OOUlQY1JuWVZ0c2FjeDdHRFJEOXBEa0FhZG5Pc0VlOWhUNG82ZWd3N2xX?=
 =?utf-8?B?SHBoT21UTmVqazE5Tmh4U2JGMkVUWGZaUTBlOHJVbWZJTEQ4ZHZKRHZvMVlG?=
 =?utf-8?B?NWVrSENkVU5uc1Nra2d2OExwZ2NVYjlhOHVRTEs4MlFmV1ppOU1JYlJHeWNx?=
 =?utf-8?B?ZnF1U1AwbVY4Q1M3aTJLanQ5bDFXUFRkYlBybzU1c3RnMXNkdEhsTllsYlpx?=
 =?utf-8?B?MUVlVmFEd2lUTDRPNkdvdzhLdWh1aW9rTUIxNkhsaXFCNDkyMWx0MjQ4RHVG?=
 =?utf-8?B?U0ZrUDd0WnZhV2p6eUhiWG9zT2R2alYxQnNBeVZFYjFEcmxqWkhTZElvMmVh?=
 =?utf-8?B?a01vaEN4blMxVG9iQ2d0STNKRE9zUVlxK1Zjay9YQ3RqQm4rRUtlTy9yMTZ4?=
 =?utf-8?B?Z2JZRE9QSGQ4SklvWTMzNlBYdUcwMmRUdnEwNFlZSWUxTUNmaVhmODhsRmVR?=
 =?utf-8?B?UGc5aTJNRHZVSVpGMWp3dWdSc29TYTFZdmxOVGRTVXpqOFhFRklJZzIzcWdG?=
 =?utf-8?B?dTNNSTlPNDJHL0hQTkdUWHdhRzd0SkZpWTk0eVhiSTdudExmL0VwdFB5NHNS?=
 =?utf-8?B?ZVg2NVFUK3pacnQ3ZFNSbEo5a2duZzM1TFNHTlIwdGlTMG5FbnZqZEdtYkFE?=
 =?utf-8?B?YWxyWExFam00eGd5aTR1MnlSYk5XYkFTeFNQYkRXbXJCRkpJenc0TDBkQ3NG?=
 =?utf-8?B?UE02MTEvV1hqOFBoVkpuZkNUdDRMbCswNnlJbXZsbVp0ZDBHbnhOby8wQm4x?=
 =?utf-8?B?L0tueVNHeFFqUXl6bXRQYXJUMFJXb2ZwdWZCMm9sRkhDSkE2SzkvSmRmMEYx?=
 =?utf-8?B?bXprZjdDOEQxZTVaMjZXT1hCdm9yQy9UVU9XbGVsMTIxNnlGd0gzZEQ0K1Q5?=
 =?utf-8?B?RXJueU42UmVoM0pPR0J1RmtnVHVOOUNVZ21nR2l6blJZdFMrM0RUUFd5dnVE?=
 =?utf-8?B?bmxTVlhsWGFNUjY5Y0hxbTN0TFIwdzhsWVRpQXlBd1FIQmtsS3paazFHdS90?=
 =?utf-8?B?cVFDczBua2VrMjZJMW9malVJMnJIWjBVT3plbXBvNFVuMkFvUEIzQ25HOTgx?=
 =?utf-8?B?QkRCMGI4UXB6V0ltMldseWtOWHZHK25pNWV6emxjK0lBMkVvc3VydThZNmFC?=
 =?utf-8?B?S2pUUm9zc1VMK3Rha3QybE90ZzN2OE9jS2MxNVZORUoxc3pNNnE1ZzhvREt3?=
 =?utf-8?B?Z3lnNEdja2pSWE43RUVhZlBXS211dUlzM0doSTkrbllOYkZNY2VrYlVKTll2?=
 =?utf-8?B?K1JXUHVlWGdhalB0TFpYREtmZHRmNzBrbU42K2p3K0VEbWVjV3pNZDJqUWJu?=
 =?utf-8?B?NW9lRVg1OVd4aG5pa2VROXh3dkN2T2ZkVjNzRHVDZ0pHa3VEcDFEc0ZaTmMw?=
 =?utf-8?B?LzVTZFMvTTEra09aRjBwNUt5aG9RWGc2TGtHVC9UVGw5Nll5WE9UWHJxYmNs?=
 =?utf-8?B?U1J2RWRaZjhHT3FjQjRpT3NoVzhQdUFpckIzb0tva2hZK1lYUlVwSDNLU3pZ?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: accf04f8-65ea-49f7-ce17-08dcf4cc8900
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 08:10:49.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+AHqvIBTzRa9qwmkT1F/LSAZVSrGTp2qnEZMgeYc4tjsS64dxtP/8rBjjcvETNv1k4K8KF6JXWfsNS9zLkxJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5314
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.cgroup.make.fail" on:

commit: 930cb1423ee2522760ffde43455b14df5c0d5487 ("[PATCH v4 4/4] selftests: pidfd: add tests for PIDFD_SELF_*")
url: https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/pidfd-extend-pidfd_get_pid-and-de-duplicate-pid-lookup/20241018-050825
base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
patch link: https://lore.kernel.org/all/b9851fa9f87d22f352f960b847d99459ef7d74a1.1729198898.git.lorenzo.stoakes@oracle.com/
patch subject: [PATCH v4 4/4] selftests: pidfd: add tests for PIDFD_SELF_*

in testcase: kernel-selftests
version: kernel-selftests-x86_64-977d51cf-1_20240508
with following parameters:

	group: cgroup



config: x86_64-rhel-8.3-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410251504.707d78fc-oliver.sang@intel.com

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487
'/usr/sbin/iptables' -> '/usr/sbin/iptables-nft'
'/usr/sbin/iptables-restore' -> '/usr/sbin/iptables-nft-restore'
'/usr/sbin/iptables-save' -> '/usr/sbin/iptables-nft-save'
'/usr/sbin/ip6tables' -> '/usr/sbin/ip6tables-nft'
'/usr/sbin/ip6tables-restore' -> '/usr/sbin/ip6tables-nft-restore'
'/usr/sbin/ip6tables-save' -> '/usr/sbin/ip6tables-nft-save'
2024-10-23 12:53:55 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2024-10-23 12:53:55 make -j36 -C cgroup
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup'
  CC       test_core
  CC       test_cpu
  CC       test_cpuset
  CC       test_freezer
  CC       test_hugetlb_memcg
  CC       test_kill
  CC       test_kmem
  CC       test_memcontrol
  CC       test_pids
  CC       test_zswap
  CC       wait_inotify
In file included from /usr/x86_64-linux-gnu/include/asm/fcntl.h:1,
                 from /usr/x86_64-linux-gnu/include/linux/fcntl.h:5,
                 from /usr/x86_64-linux-gnu/include/linux/pidfd.h:7,
                 from ../pidfd/pidfd.h:19,
                 from test_kill.c:13:
/usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:156:8: error: redefinition of ‘struct f_owner_ex’
  156 | struct f_owner_ex {
      |        ^~~~~~~~~~
In file included from /usr/include/x86_64-linux-gnu/bits/fcntl.h:61,
                 from /usr/include/fcntl.h:35,
                 from ../pidfd/pidfd.h:8:
/usr/include/x86_64-linux-gnu/bits/fcntl-linux.h:274:8: note: originally defined here
  274 | struct f_owner_ex
      |        ^~~~~~~~~~
/usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:196:8: error: redefinition of ‘struct flock’
  196 | struct flock {
      |        ^~~~~
/usr/include/x86_64-linux-gnu/bits/fcntl.h:35:8: note: originally defined here
   35 | struct flock
      |        ^~~~~
/usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:210:8: error: redefinition of ‘struct flock64’
  210 | struct flock64 {
      |        ^~~~~~~
/usr/include/x86_64-linux-gnu/bits/fcntl.h:50:8: note: originally defined here
   50 | struct flock64
      |        ^~~~~~~
make: *** [../lib.mk:221: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup/test_kill] Error 1
make: *** Waiting for unfinished jobs....
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup'
2024-10-23 12:53:56 make quicktest=1 run_tests -C cgroup
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup'
  CC       test_kill
In file included from /usr/x86_64-linux-gnu/include/asm/fcntl.h:1,
                 from /usr/x86_64-linux-gnu/include/linux/fcntl.h:5,
                 from /usr/x86_64-linux-gnu/include/linux/pidfd.h:7,
                 from ../pidfd/pidfd.h:19,
                 from test_kill.c:13:
/usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:156:8: error: redefinition of ‘struct f_owner_ex’
  156 | struct f_owner_ex {
      |        ^~~~~~~~~~
In file included from /usr/include/x86_64-linux-gnu/bits/fcntl.h:61,
                 from /usr/include/fcntl.h:35,
                 from ../pidfd/pidfd.h:8:
/usr/include/x86_64-linux-gnu/bits/fcntl-linux.h:274:8: note: originally defined here
  274 | struct f_owner_ex
      |        ^~~~~~~~~~
/usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:196:8: error: redefinition of ‘struct flock’
  196 | struct flock {
      |        ^~~~~
/usr/include/x86_64-linux-gnu/bits/fcntl.h:35:8: note: originally defined here
   35 | struct flock
      |        ^~~~~
/usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:210:8: error: redefinition of ‘struct flock64’
  210 | struct flock64 {
      |        ^~~~~~~
/usr/include/x86_64-linux-gnu/bits/fcntl.h:50:8: note: originally defined here
   50 | struct flock64
      |        ^~~~~~~
make: *** [../lib.mk:222: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup/test_kill] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup'



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241025/202410251504.707d78fc-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


