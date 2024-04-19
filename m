Return-Path: <linux-fsdevel+bounces-17270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66DF8AA6EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 04:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BF21C21031
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 02:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F8F7460;
	Fri, 19 Apr 2024 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gn7gUUfD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86D15C9;
	Fri, 19 Apr 2024 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493573; cv=fail; b=S+3FwJL8/FIm8dNXYknsSxU+aJy8F+6b1WojnumAX8YIZVsvqBIX093WpQ/r1Eilxfvna3+/3q/xSpc/ca2bfAtV344v/yKhf82HxJQoyqU8mF7R9xnAhsWREHZuWkJRviW6hdqglJVXkQohxq9Va5yj/ChRlhuyalH4YPBCOYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493573; c=relaxed/simple;
	bh=PBWK+R2Q0ni2v3jCYjZOLsr9t6GvmMvrZaKVFiQhT4Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=huIACE8sE5Ujky/R+Gxhm68BGxBtI+nWpkAxijSJuyrly6SbHvu4MXOPmF+OZqEicjrbCeFIc90Xo5MZWGZGsdlyYFmKA0MNOJes1wjVBMMq5mTXwsZGb2zKsSuv/P4lQ3C8DX/z80SG5mxM8hTVIKly+OiCn25pmyVv0rdr0jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gn7gUUfD; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713493572; x=1745029572;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PBWK+R2Q0ni2v3jCYjZOLsr9t6GvmMvrZaKVFiQhT4Q=;
  b=Gn7gUUfDKLX8gFQdYOaXxvoekU7SAxhn7jBVWgf2IwrbFA15zvSB/G6D
   YTD+BpKtETVDXHdBZWDelG7T95Ag6xewVxRO8xu/GXAB2WIzAUwxqzjIm
   nT7cwblKTC6LTDeQgs681mP7dNYY27ztnSvRI206gMVAP1tnVQyEvuePv
   XnihwAI1BZQgh+waBLpJXm/H7TB175Di101ey1cAcRLdA2zumnsA+GTWv
   AyIf44gNj2reAWwnLapD0V0nTyAlfqWAwDFhot7ZSmGlTvl8ggJkfneeg
   qVHKNsAvui+sQJlzqPt7xLHI60Dp253k06xHmavKgauUASlS+ka+o4hY8
   g==;
X-CSE-ConnectionGUID: t5WPWC6xT7mXB/oUsZ+h4A==
X-CSE-MsgGUID: /R0+LogTTAmJHlxuenOvGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26536391"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="26536391"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 19:25:58 -0700
X-CSE-ConnectionGUID: VzL5vT9/RAu41EOP0jmkgA==
X-CSE-MsgGUID: RH+H8gqWSASgD18yNvV8gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27844909"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 19:25:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 19:25:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 19:25:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 19:25:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 19:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7moUcyC5qStkEJk7NBkZiFHCZbYfr8fi2SNmxkf+EvENTWYY8qk6HHFoLwWiac154K9KyLEr+7FjhO34mXane5wBjy14WLrUoPO2c4mSB0qdIElUhxZHVMHF/pTRV6i7djRUMRSvvREXI8SiqzeIWGd3nAFsiFewjnf7No6BCT/8g/q/Xk66c2E6es1WQgLVspaKPHPv0GbFULuUZefVAtVYv5osII4sQZaf8a9ewaOQNhYWLlW4GhOlUifjg8J78fjKtXVqi3s+zXUmdm4PgvCwTDxupVtFw29Ee1ZpMmPbAzTykO4aVg/R1taKO5Qvn0QZA2SO3ALbmVt6gQwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg+hJLmi9B4fSdYMI/wZMzV5/IRZV+879c5Z+mPn7v8=;
 b=doQ6+eoNXJZ7mczwHj7UxFRg5Mc0/6vO/SvOHFHp35lE8ZISVGXiSe1GCaeLxrCByItX9yVXCF8M5bOhrwxgxsmgHjvf6Y3S/1Xu8NVWho39WC0CN0mQUf9Qu0hh2gs3L6Ff+40tQ+zwk+nEcTRc4pWEjXWekmVXeIk53Z+eCM9dRhRtamqypdmlYzzu5sqWaIbGCww3Q84JkUfqjW1bfdLLfkfrkpPpxCB45tw+/ME7f4jJUN6GUr1rDtyvQSPhl+GcPHQCtVPK9+hPwxtrpcaU+kHUYW68liTuwvCc7slqX90JT5P6G2zzIhobLMbdrp7tDHGxF3NrUalvXv12mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Fri, 19 Apr
 2024 02:25:53 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::ef38:e929:a729:2089]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::ef38:e929:a729:2089%7]) with mapi id 15.20.7452.019; Fri, 19 Apr 2024
 02:25:52 +0000
Message-ID: <c5c2ae26-d405-4b0f-8bf6-281abcdb3239@intel.com>
Date: Fri, 19 Apr 2024 10:25:41 +0800
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
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|CH3PR11MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: df504ecc-74e8-48f5-d31a-08dc601808a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEdBY1AzczdBQW1WVnBBeFpSS1IrNUxzRkgwVWxIWVc5NndJS0Q4VnA4Ym1v?=
 =?utf-8?B?RnlnMytQa3JSb1g2czIvVXVzQ2NpbTdoVXZvVmxseldBUnF5YkgyYkNTWkFh?=
 =?utf-8?B?c2Z2ZURQblYrY2h3cDgvUHlhTzgvR3hQWlNsbEhDaitBWnBrOWlOY1Y4Y1Ry?=
 =?utf-8?B?KzdRRngxK3BWZUNKSGlldE43MEhIdk5XZnVkenA0TDdxS01xT044Sm1UajFC?=
 =?utf-8?B?N3NaTS8wS2RmcjBCR2pPdmUvN0hGUmFqdXBqQTZ4YnZXcUtBaCtlNXJzTmla?=
 =?utf-8?B?RzNheUhaYVJCQUtUenFEb0FhYUF6WXE5YjFnOTdQVUdRbXhRQjJJNlQzbWpp?=
 =?utf-8?B?MXhleFdyTkxEVk9JcmlBSE4xaFVnU1hCVk5wSEpJUENzejVCc0d0dStCM0dY?=
 =?utf-8?B?Z2RRenhIMTA5aFdJY3VUK0xRWmU3bHNCeU5yZjJwS2oyNG9VSnF3UVptMWpB?=
 =?utf-8?B?Mk90L0tPTVdDYyt3MjZRamJnS3RwZklsLzhiQzFJNDhPeDlWQ3hUbHFJK2xz?=
 =?utf-8?B?a2lzbjJ6U1VXRElhWEdCMGNOSFZXQXJsNDlhRnBsa21NN1VLUDh3M2xFbDRp?=
 =?utf-8?B?anZuQTg5MmJsN0UrVHF3K1hVR1hxSmY4bzByZlRBZUx4c2tYYXBmUnZkQTVp?=
 =?utf-8?B?YkpSZGRzem54a1JRSVlqdzlFMmE4aU8zK0ZyVHo2VjZCY1hYUStLQ2lHaW9y?=
 =?utf-8?B?dDZ1eTRkZm8xUkVET21HcHdDbXA1YnBoaVVNdGRpN21IeksxdXZiYUJMTHJv?=
 =?utf-8?B?cERnclo5cU9VN2hPRjVTWUxtbGZRY1lMN0w5bURMZnc3UjRxbnVIdGhzSzNR?=
 =?utf-8?B?SnFnd25Ec210WWFBaUw3akVGbXpyTGI5SFpTK3d3S2dSZzkwODdaczBMUU5v?=
 =?utf-8?B?ZDNVOUk1L0hLOWtsRitIaWY0cGhYSlRYVG01VTIrS0pITWk2UUdZYjc2dXk4?=
 =?utf-8?B?OStVQndKZ3RkQ0g1UzNBSWF4RWJ3Ymt2cnF0Ym4ycWw1bVRVdVlJV2E4Vk1P?=
 =?utf-8?B?SDZWdlFqQlhZTTkvNVEvMko1aE93cE1Zdmk4QlRBN3NqdjFYMUEwTURhQ01Q?=
 =?utf-8?B?TytObVdTUEVEK2pUWWNlNkVFbm10K3cySHpsZ3ZFZndQbWJTUHJra3N1OE9I?=
 =?utf-8?B?dDZ5M0haZVlMditkcmxESUZoQ2tOaWQySy9HOElaaUlCWExRTlhBZTArZnhx?=
 =?utf-8?B?T28vRTI2cWw5NWRaeFV6MzNaMUQvc05pMTI3TkxZKzZIcHFKM1I1STFwK00y?=
 =?utf-8?B?MUprMGJ3NnQ2T2xpYzYrTkdxKyt2VU5VallXTU04M0hFYmQvN1ZrMUZQZWtT?=
 =?utf-8?B?a1ZaUWFMNzVEUEVuQTkxWlVvcEkwM3p0dTJJQ1Z5NFRRMTFEamZqWXk2eGkz?=
 =?utf-8?B?aDBPWkN1M1RjOGRuVUhyU1dwUW14eHNOUTFwOHZmTEI3QUZzOHlXNENMSTVE?=
 =?utf-8?B?T3NnYTFZb0Q0WUlyU01UTk5iK0tFZ0xCdzJJSE9RSEFRU2tUL0czWmQzTzZP?=
 =?utf-8?B?cWNoTGNVSWJYN1hiSm5BRGl6RUsvNHZXSU50YTM1anhtaHUxQnN0NFZrT2Jv?=
 =?utf-8?B?dytSZkZKREcxTFhRZU9PcUZ0eERaS3E4TjB4QkNEMS8ybjNKa1JodGl5NlJW?=
 =?utf-8?B?Q1g1QTB4bHNOMkJVM3lEaENDTkZtUU5Jb09DeVpFNnd4OFVsZDE5ai8zU0pj?=
 =?utf-8?B?aWVOS3NRb29RQkE2dzZNd2tmWWs5LzBiTnJiQ1FWa083NThtQ2NJbTlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhsY1RTemxWTnNuYWFlZzEwMkZqNXFQbE9HV1dTR1RCRDdEelFsSWVZMjB0?=
 =?utf-8?B?RmYrNjFpeklDaDVGQnBhUzhTWk5KMUNQQTdWTWNuNFlpTnYzT29yckFXRXJ1?=
 =?utf-8?B?OGcwVEV1MkFQdnQ1RE1vV0E4bHpuaTRHVVB0SDhOSGk0WWlZS0JwMnEvWUpK?=
 =?utf-8?B?SjhPSXBVNFE3UmVFU2gxNml5UWdsOTB2YmxKeGsxNXhoNVV1NXcrT0hlei9Y?=
 =?utf-8?B?akNyS1NJcjVQalo0bmpzUDBzMlBqZXV5QjMxeTh3T3AvZWN3ejNGT2pBSjRi?=
 =?utf-8?B?OTZFSG16aFp3QmdHRkZXMGI0MUx2ZFNpV2QycnpPaWtBTFB3SXFzeGRmVnVy?=
 =?utf-8?B?RytQdDdHMmQ3dnVBT090R2xBMURhWVljUXlNb3QxaVI0S1pLZ01oWmpOZlcy?=
 =?utf-8?B?NUlJRWw3RlRvMHR4UzQ4b2x6TmFXbWVDMWVlUkZ4eE4rRzlmMnRVdFM1bk9z?=
 =?utf-8?B?WVFhQS9LdEg3andrMytrbEVEVmgzU2FnYTBKQWNSL0k0RWJvVFV0aVVuNEpw?=
 =?utf-8?B?WW5Ib3QwMFlmNThJSXhPNHJtT3BpeFlBb01kT0lLcjJPOGphSFBmNXZ6NU5P?=
 =?utf-8?B?UHExNHFPSXAwR1IvaHlKUktLbVNQajBlU0JERUR3OUZ4OU9WMFBGV2dGSGtY?=
 =?utf-8?B?Tmh3R0FPSFo3M2tjMHdUZ2xTTm9XRXcwT2xMTklKeGNjSkxaV1F6b0VIWG1w?=
 =?utf-8?B?QXV3VWtEQzlUdDR6Y1RydkZ6Ti9KaUM2TVA0OEY1SzZyZVlCNmVqRVE1U0lv?=
 =?utf-8?B?eUQyUmY1dWx5MTU0UWRBVm5IV25icUdvbnFCZmhSUTZVTGxpeE13WDRRSW1G?=
 =?utf-8?B?bnFrR3QvdDJTWTNkWDdVWnMwTzBuVHlRa0JNcVJYZ2xNODBNYm5zaWxtUVpp?=
 =?utf-8?B?MVJ4SmhqVEM5UDRDL1pnWUUxM1FrSUM2TGNyZmNscFBoLzJZTmQ1d3ZpVkVP?=
 =?utf-8?B?MkEzOUJuRCs4SHVpUy9walpHa1BRUU9zTXlLSllRR0xpalZEVFgxT1RqbHVS?=
 =?utf-8?B?NzdiSTBvaVE3YXhWaEFBZGx4aDRhT1l0T0NSL3lwVmJFNWxmdlZmR09oTXpT?=
 =?utf-8?B?N3JZL2ZvL3VHaU5FSEdmZVJUM2prd2FoM2tEK3Z3a3c1T3F0QTByM1p0RTl2?=
 =?utf-8?B?WmxIa1VOcW9ydmFFMi9kUDZaUng3QlI0TmZkbHRTTVQ0Uzk5bFh2MzlVSzBh?=
 =?utf-8?B?d1MrNS8wOC9OWHZMT2RubytQek1SUW9XYjB2Zk43R0k0c0M4c2xSbGlOOS9Q?=
 =?utf-8?B?K2ZRQnZUUzRMVWw3cFZvT3Q5TmJpRWJSS3h0amxqMEt2UUNDL05KdHUyRnRM?=
 =?utf-8?B?WFJZTXlRSkFmS1lpU3FmN1JaSkhIdnJsbXorOExOc1VOMW1HQWhYWVBWUWdY?=
 =?utf-8?B?SWFUZGpqNFByZUx4bmtiVkpsNUVHOFJReGZLdm5rMlF3eEtQdXZoS0IzaXdz?=
 =?utf-8?B?U29hakNHWnFvakErNkw4R216aHF1WDgrSkxsVnEwNEtuTExsUzJNa2FnZ1Zv?=
 =?utf-8?B?eXlQcFpuSWdXUE9kZE1pdVBEQjJiekRpcnZ0V05YT0gvSzlOeUhvV0dhNm53?=
 =?utf-8?B?SFdKTlRsRjE1Nll3ZnlwRDlzTnFpOFU4MmVZeUVsWXUwZWlvbmNoV1B1ZExT?=
 =?utf-8?B?Kzh0OVZNUTh2NDhRbFFwYXBMdE1ZMisyL0xmNkNiazZNbXZkdUI0OGZOdmJh?=
 =?utf-8?B?VUozNlRLSE9yY2pUQjNtV05OT1N3Z0pXeEN5cGxsL3IyaUxTTWlESDZ2QWRq?=
 =?utf-8?B?WlBjbmZRdXMrM1l2NGwwQ2dGNGEvWnFRS3ptUU5DY004VVlHbzJKcnRVdzZu?=
 =?utf-8?B?am55TUYyQWFFTW9obkJrb2p0dlhkTTh6Szc4RkVkVmEzOWpqdFZ6bitTNjZz?=
 =?utf-8?B?VnpsdFV6cXhUMWdyampVcGloVmNNbExhWlVBcjdiRjZtNzdRRkIzOWhoZW1i?=
 =?utf-8?B?UmxGMHdYaHVzdDhHaVpYdEZMSUpDQ0dLK1p0R3ZxN1FQcVBmL3pMSkZyZXIy?=
 =?utf-8?B?ODMyRGJQU1BpbmFMbnhvN2oyOHltY0U2aXNWc043bkNFa3NtNEl6WS9HN0lG?=
 =?utf-8?B?MlFWNkhkT0QzN1VTaDd1SGRQRWI5SmV5NlVTcy9WS3VlWGFmdEhvdHZFN3lF?=
 =?utf-8?Q?5oGT5LzS2jrDul8ILkDwLnawm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df504ecc-74e8-48f5-d31a-08dc601808a3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 02:25:52.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opq1wXlYs2TZQ7UJlJtB0tbSktR7ElpD2PUPAZqpvRjiPcDnrcKAeLIThRgyaCESLkZ5yC0FQjFOdXpdfeL/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com



On 4/10/2024 3:22 AM, David Hildenbrand wrote:
> As we grow the code, the compiler might make stupid decisions and
> unnecessarily degrade fork() performance. Let's make sure to always inline
> functions that operate on a single PTE so the compiler will always
> optimize out the loop and avoid a function call.
> 
> This is a preparation for maintining a total mapcount for large folios.
> 
> Signed-off-by: David Hildenbrand<david@redhat.com>
The patch looks good to me. Just curious: Is this change driven by code
reviewing or performance data profiling? Thanks.


Regards
Yin, Fengwei

