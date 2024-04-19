Return-Path: <linux-fsdevel+bounces-17290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F58AB029
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF891F242C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAAB132804;
	Fri, 19 Apr 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkDM0HaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AEA12F5A9;
	Fri, 19 Apr 2024 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535392; cv=fail; b=LMXPacL+DDtYPZG7tlXezK3JiKCBDsNGbx6MDEeFVKQ9TCtf5d9AvJuBhfgHzjQVO74QHAiiXUgAuTbDx7Q01wnahYMMovvgZe6jYhVTZ5ywg+G3ccK07d5fSPYFmYLSwsxvqhdsIUiEq+RNMga8Jkk6KhDnFSOi3/rWqO3Ns2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535392; c=relaxed/simple;
	bh=a7FB073AmjBwgAgtK1jW3KYhAmx+o2vYK4ftJbZCqYc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qQObngOCqCIFemrhW2seoiWhep+/uEEC2W1aYZVN1xkJkusKtgBzLeRCxREnMvDlmc5UlddNmJj2VIktAZcNjN888+n0z3Z1e76DvU3qRXQxPa0ZIrBuNEl0kh4k4RnoKpWWC9CFyvDt8uSjbGQO5FwxK06TBnjM1FXnVw/LeiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkDM0HaX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713535388; x=1745071388;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a7FB073AmjBwgAgtK1jW3KYhAmx+o2vYK4ftJbZCqYc=;
  b=SkDM0HaX5q7PxOuctV/2EFnT1BOPr4uu1T5Wqh37VgfEX62dt4zzfGFY
   dx+s4WaRXOKMPEa8SWG5KbXZw7OWdT005qT2MrpOOBVAaDm2BMlLLIgji
   m631RWNxhzAIdO5Mt1DMAqCMz9okmQUWf8h7CoEZLnB6niIGWz/e8O51r
   a5/72mTqh2asdrFBMId/bAd9SECc30utXGYox9eNWZal98IKoEE0bN1fx
   MRAD6ceBBblHEvxDlsaaJwLiX4Odk4ChniC1w8KJsq0WQmso9eTk37Hxv
   aKdNO1YFGvsHPjolph+kXpMxbb936QCYTC7YMGkbjwArtBtYIuInm0Xh8
   A==;
X-CSE-ConnectionGUID: C3bxsIijQ8+ZBKsRk6T3CA==
X-CSE-MsgGUID: VmplemxbSKaYUtHfcFlNzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9358300"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9358300"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:03:05 -0700
X-CSE-ConnectionGUID: wAXzw8GjQE+FD6izcyZ4Dw==
X-CSE-MsgGUID: /8UWTVQlTE23R489u/lxBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27990943"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 07:03:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 07:03:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 07:02:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 07:02:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 07:02:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZIXn0vhHcm08nDe9V0DbYp92HSSZ5kOgw14mjRfMmQlzGnKkZQAg7AAM9okKYEoiokNNGubyKs+g/abGbvIgKpSmHM87fjde2peDJX+w9fYfUELLCj+4eXeDB4IyHtdlqnZ/rKCW9jc1pCaNPJdBh1d+XxqPR7Q2cwnc5VqOCYIg9UKwTD99s/h39be4XGfxRzlNVCmacVMC1wUs9tTA6szSThCOqrnv9LNi/fza9PVvZ6QaBOCgb72gWu0Sf+CWpEWDe3pQDdQZYCnRA/jex6kW/31cQGoIVwuiFKdfUMFhgji954j9gCU9kTD3a2jkw4FS1yJw9eD89oVraCmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41zSAAfISOyzsIhe6GBTpK5KKU92QhCfoVu8YJblsDg=;
 b=DnORyY9VxBRLg5DXPkqXFW4Syhmi64OSRvduHfmZRCjl7ouMjglC82ypMEgBBqiUb04WOeGbYQl8e01Wpw01bHhi4bKq5OQkeXMoFae011+uCYJFQw9UAeIUSzstCJN/O1eaGZ44ygL7MCDjGtCATleYfyLsdPcoKHBUStlbQeywzx8uy8ktE5/OJVK+HtDQlScuDnASiufcD8LSXPbsvGNvrCxTVl2HqJBbeYJBP1r2EhykoJYtdf/c3T8F/jOCAz++0DT+9YVwdSb1KWHqIpE4HEykhMs2lp0h9CP5jnNGb1MeT2wn5awtUzcqfQ0PYr6BiTJtTW96EI6RmuxJXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH8PR11MB6730.namprd11.prod.outlook.com (2603:10b6:510:1c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 14:01:59 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7472.025; Fri, 19 Apr 2024
 14:01:59 +0000
Message-ID: <852918ac-31a9-4924-a551-8b91de91b0e4@intel.com>
Date: Fri, 19 Apr 2024 22:01:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/18] mm/rmap: always inline anon/file rmap
 duplication of a single PTE
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Peter Xu <peterx@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Yang Shi <shy828301@gmail.com>, Zi Yan
	<ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins
	<hughd@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
	<dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, "Muchun
 Song" <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <naoya.horiguchi@nec.com>, Richard Chang <richardycc@google.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-3-david@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20240409192301.907377-3-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH8PR11MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: fb88c039-2d90-4c9a-ef4f-08dc607947dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: qWcIe6v1u0PkhgxddH690cnaxomX7sXCeWzQAvYmsxICATZumsdOZThA/59fSQUxcejQmJcXeoj3bl8irMnY/Aq3Ry/PEkh2Y1eJVCN2F89EqAEsOvQpyAOMME4934ntZTe2Kj05JOdKBZ2LNNq0i+JaS8J455pYgrea9EaH1802WUS/q9ni3hZnW/kuDoPVYRisp7F+hVX9zguNhHPuhWZqeE5NeqBlqzR3/lly1Daz2YKRNuQaR9wQf9cWfBf+s6vydXSkMV/SKgDLx3IGXzU9wAxDUZxzla01i/1uMBvgUoo8KqzA9qy46gsaemCTYv0HiZYoO3eQeSrEpol9k2JHV6a+MnKCnOwipQ35kC1X2tTbcDBdcPWdK13+hnEuQ9qDOjpuyT5NhvoDMh/GYah0tAUpl39djPehSk2VOHrMMJ0383Vrn+9tCy9gRi8Lrliuz5BmMNn897+gIAp53Mu2QpKrPLx+hXjX9QuTL/F2mE65SmcYuk2CEl3X0sqOaWWYS5diFN3NhaOjFZQg77oL8mlbyghNOTu+v4kRw5ltIrWRgQ566Ot668qnAP4WabemFeQCXNLgBGsKy5BfF7hYzqDuMD7BKfaurSzaD+zaP4XjRHX7VFVs7BhJq3CN/eScVh1yzKEkGu6eMMMCoObJBoU6F7WltomMkg+1Teo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWpHYjRpbjNYVGF5RUFrSWVwLzl6UDk4amxQNzR1aWJMSTdqR3FKbXFBYXNh?=
 =?utf-8?B?UENwNHBTRTRNSkJVOWtUUFRVV0VtdDVvRDI5cmhZREdSS0F6eGpUbFQwSHVm?=
 =?utf-8?B?TWltSG9tR2VJY2xVWXhVdkpqamkyZXVGRUo1T1dLNFVXN1o1VktCakZiQTdD?=
 =?utf-8?B?S2h6a2dCYmxHSGVIN1BVYXR3VVN5dDdOU2x0U2ZhMHFxQTY5OFEyaEluRjZP?=
 =?utf-8?B?TWEyelFVWDBFSEZFN3g2aS9xWHJjeUszeXZnUkJhR2dCZEMxNnJyZ2NEVkYr?=
 =?utf-8?B?UVhMbWtsYm9KeEpwU2R6M0p1ZzE1cFFyTXl1ZHhXQUphQXJDZS9sV0pEYXJO?=
 =?utf-8?B?SmJBL0NjYkJ3dmQ0VXN4b1h3aVovbENta0JqejdxcHBaVVoyQ3l3TXE2WG1I?=
 =?utf-8?B?L21IS3MrTWZYYWQxb3NzTWFocllrVVVmTjErN3U3b0s1cWprWFFXeUpxci9n?=
 =?utf-8?B?SXpnT0oyMFZxcUJRcEIrU1A0VzNaYzU2b0pabnNGaVpNV3lGa3hyVnVjRjNs?=
 =?utf-8?B?M1B3bHBhT2o5R01IRFBnT1YxcHpJQ1ZIV3NRNk5NbjExYWRZTDEzM211Z3dM?=
 =?utf-8?B?MnhUb1dsL01hVWdaOE1tYlVPTnJtZjJQbEtKQk02SGVRT25nenk5azZjeWM5?=
 =?utf-8?B?ejd2Nnk3cmhCSnlaUnZIeHZCUTNSbUhOcmNqL25STUU1aXJEc1RJWnQzWlNr?=
 =?utf-8?B?elFhbGRyWER1VGNkRzU5U1FEY0lQbVVmSGFSbU1zeVdzK0FveGNUbHdvMDY4?=
 =?utf-8?B?SXJxWStvcC9TaEcybUgwbjZ4NmFMSFdwbkV3NHd4QVpYRjFsOXhDakJYY1B2?=
 =?utf-8?B?eU1LdzVGNkhkTXA2UFlMV1hqRThWMnZLODlwQnNHZ055WHUxN0pDemtUNmlm?=
 =?utf-8?B?bUszeUt5QWgyWForcitla2VKVnVOcUN5S0N4NVZGT0tsc0pkeVJIUlZ5R1My?=
 =?utf-8?B?UGNwYW1qaCtYaW1XUUFCajk3K0dCWng3WXNad1o1dVdtWVloNmVySDkyeUd1?=
 =?utf-8?B?UWg1czJEQStEdmhzYjdhb21oZTI2TUJheTJBNHpCRlQ5M0NoVExrZlU3c04z?=
 =?utf-8?B?Y3dFek9yZUpXU3d3V0xqZjJsNVVDZHZxRVBuaDFWQlpxazQvUzBmNGtlakY4?=
 =?utf-8?B?QVVhZTNqRlJjQmVXOTF5ak0wYlZXSjBzejljdnBOOGgwVElaVHZrYVc4MFNx?=
 =?utf-8?B?TGRtNXByQUsrWEtrcjhBMHZ6WGtjeHBMR242QXpSa09OdGRUcVljSGt0MWJ5?=
 =?utf-8?B?bFJSL1hxZDNFWHlOQWo1M1FvS1UwWDN5NG1BMW9DYkx5ZlRlV0JrWE8zam9t?=
 =?utf-8?B?MkFTcS83ZDFDaFQ4M3o1Vk42cnoxR0pGMTAza254WFo0Z25SQ09US0NHMWpU?=
 =?utf-8?B?ZW9nelhPbU9Zd0srR1BuTTFlVWg3WGc1TUZXMXdqUEtBcEg0VWE3QUdNaFBo?=
 =?utf-8?B?SEI5ZlZPc0sreU8zN0kzUExSL3A4MTl3ZTJiejVlUkErV1hOelBUY1dmMWFF?=
 =?utf-8?B?cFNDQlpRUmpKemRQSnAxRFl6VlIwVWN3QVhrN2tGOHk4Q0UvbjJkMnlOUTE4?=
 =?utf-8?B?OENuejduVTBwUkMzazFWeHVySWt1SWowc0dtOVNTc3lNVzVjM1NxelR4VHV3?=
 =?utf-8?B?UnVuZDFVL1d5cktsQk56Y3JiM2p2MzZYRHdqb2w3MjI2RDdBZEJERTBLL1FF?=
 =?utf-8?B?bnF3Mk1SM1VtNGxJRG1PTWI0MllzZ2pEV2c2MGsxaVJ0SXdyVmhCaVN6NXB0?=
 =?utf-8?B?dysvOGdmYVFxRlRRcnFHbU5CY2h6R2Y4NVdORmRTM3pkRHZTTHpnVndMWTJ4?=
 =?utf-8?B?b0F1R2R6K0EzemlVVDdVeE5XQUU3TFdqdEhQUjY3djlEaHBhMmV4L24zVVMz?=
 =?utf-8?B?MytEZWJsckpHOFNIZ0xzeG1XaFlFV0JKY29XVVlGQlhjQm50L2lmRXdrWUdq?=
 =?utf-8?B?UFhIT2QxNVFhZHQzMFdlaERxZE1kZm5odExWU2Fla3VxM0FNVGFCYU9MZnlN?=
 =?utf-8?B?Vk9zeW9qdTc2ZlVjY20rN0daOFZ3NGhDaE5FeTl2MEF0bVVDVXFNdGx1cDFW?=
 =?utf-8?B?b0ttT0xiRFJyODV1SlpyL0s4L29xc0R0Nm1hS05sSkFyTUdJSkROZjNmbis2?=
 =?utf-8?B?WEcxOS9NVWpqRGdFY1BXRmhyMHZnUWVva0pVUmd4eDhYYWtZS1Q3M0hlbkdK?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb88c039-2d90-4c9a-ef4f-08dc607947dd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:01:59.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rs3ePm46BdHvVcenJPebi/WbaaHzDrl6IKabEmZznFFzC8uZgO/cFj20RZGnnwMsMkRwYi0A4ESCUAfIU20/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6730
X-OriginatorOrg: intel.com



On 4/10/2024 3:22 AM, David Hildenbrand wrote:
> As we grow the code, the compiler might make stupid decisions and
> unnecessarily degrade fork() performance. Let's make sure to always inline
> functions that operate on a single PTE so the compiler will always
> optimize out the loop and avoid a function call.
> 
> This is a preparation for maintining a total mapcount for large folios.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

