Return-Path: <linux-fsdevel+bounces-3280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BECAE7F2410
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 03:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F80DB21A8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 02:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5197496;
	Tue, 21 Nov 2023 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFcD0vne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B2E9C;
	Mon, 20 Nov 2023 18:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700534152; x=1732070152;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MEb81jU+9zMP4FpjtS6Km0ToaYWirQo05+YSCg1m+Es=;
  b=fFcD0vneRMFuRZEIwylba/7J1uZyp75Nf3FLuimwAXpstE6ZMDm2IK/D
   LWlAppbl2/oG9nXHysFRi6bUAgl3q4os+uhHJNNkOVb1/Ot1TB/9bNjBc
   ycj5zj7XvwbR8txFPkc5BQFEic9Zr4fXXB8sQsgIViWXXiqfry3OeZjEx
   0vh5/9XAi3JGnQ6AceHnOmQX4j+51dHWvrRLq4aawD9ee013q6BWyimcr
   Y3HeBa5CboQkEgAjJjgrHQpyqysj6f3CyJ6eXKKKZUrR+fvQKsL+QtMTZ
   JGP4Pr42MykhfYeelJ/1+eA3P3EUYqOrpCXyUL40o8gumqhnk81mZXL5J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376788404"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376788404"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:35:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="766495324"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="766495324"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:35:50 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:35:50 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:35:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:35:49 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:35:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvrSzOi3MLeVg79aNJDwn0GknC6k8AmK/X8BjRYUyjj3MJd1lf8YmnNYU+TOTpNP4LJdz0ft+0tiNuWs9VoxObdG5aa88ABs5BlX46R4tUcKUXT53WzpGaX9dNlx+Ft/+ZyPWaBwxr7ijXSMOibEoCMOmDU0m0/tmEyuEkyNad1jf8JxJiUcaKYiWLyrb+gHRL9ZWFL0GZyuoXWcy8AWRNv+0m6Mkn35N3dM0ZwaceORtBzQvm0OZay78/1RjCU4Jmffk6CVeUnB6d9S8DLG3pczLkXyVdR32JIjeVCQXnJ7vuInRHmwfYDY54B46eW8a0T2td5vyAnH1+5sXSNBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9IXd/mHEIng8mxk7+Mj4j/ZkYH6L2Vb5p9sQnWd2TE=;
 b=gaD52jwMsHODGSbi/rkEB5hO/mLxfKbh+GeeBdKhPA+qQMezys+CuDc5IBeYh+o5+h6mn7tXH9sJGKxXAW/uUbv7n15J3zk9p20gv/5I/kngRl+qsu5rb5y3EX8C1mfycmSfhSTHCeaQXTVI0/evY8hoNk3gSNMKJJ4uSKvrnhrcas7YWxO3VtSaiw/gfi2+w4XpQIrfXqn22zU9KxDpuexDmo9RjgUA2IhLesHfht42KBxIn9QRNvmXI2jo3WMA7oyxUiTGCII0cihbB3oDPRMpq2vlCLb2XZrCHrHrh2lHDZPUlbB+ygnc35L4w7cFlahEaCDqI0JUr6WdqHfcEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by IA0PR11MB7814.namprd11.prod.outlook.com (2603:10b6:208:408::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 02:35:47 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::50f0:1dd8:29fc:3f87]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::50f0:1dd8:29fc:3f87%4]) with mapi id 15.20.6977.029; Tue, 21 Nov 2023
 02:35:47 +0000
Message-ID: <133dee64-848b-4212-9432-8760b057fe0a@intel.com>
Date: Tue, 21 Nov 2023 10:34:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [filemap] c8be038067: vm-scalability.throughput
 -27.3% regression
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Feng Tang <feng.tang@intel.com>,
	Huang Ying <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>
References: <202311201605.b86d11b-oliver.sang@intel.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <202311201605.b86d11b-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|IA0PR11MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 97614555-b6d8-43dd-6435-08dbea3a9128
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0MqMiC3OSPrXandNcicR1CgzKfPJYIFyfTotjlQP/fu1f1zOgdCP2Be8G7suhGzRyN7ZHzXB2sn1h3fApxEqLzgkDp1dswadC5+lRStdCKiJudTZKy+HG6Lw3in3HyJGkVr0p9c+9YeR+i+wy9ydHu9rC917T0AixMTeU3Qgoam/zX5aymNXMzOMUcphN2bEq9aQOmibGt7YZQx80pctoe+sXB+Yarh5Xtdy1gNIyD8W/QveL+I9xAoJmOhSxnRqt8y8tTWObGjhsYAYnDq8FbjoOtiYKdn3FUhFg0Q+BzjMBcvZzR/jfRtFq1VG8b3Yng94iz9I+f/yPIGWiGU94WwYL21q1B0TZ8pHRkUoZdwMInqBXY6uTWsyF+yIZ84PCWRJhJfgHB6oMVkSqjrzfhFUHmTubs/lxGgiDG+ST2VN99Tp4KKCmFe6gmf0WCitxkdm4jwziJ044QQh46NGdszmMGBKcoMtihTkBEcEBm4ZQOKqdXodAABsGIuRxOc9LzuTOcncmNtbZcG+cBIovmF2oWx9E9uE/3d3EIUWbtcHFYrDZpjGWzqxTj8p/GEf0JD29/GfsNLgraK767fHizkEPlf/zAZgeaPuOPos6+IHHUYqwcRWtWv+87GuTMSwm1MxAc7gBULga8Nk96RNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(82960400001)(86362001)(31696002)(31686004)(6486002)(6666004)(6506007)(37006003)(66476007)(6636002)(66556008)(316002)(54906003)(66946007)(36756003)(6512007)(53546011)(26005)(83380400001)(2906002)(4744005)(478600001)(5660300002)(38100700002)(8936002)(41300700001)(8676002)(6862004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9STTdnUnFjVzQxSTF4aGY5ZytPOVVUYy8xa080RDR6WC9ueVVMemJOTjdl?=
 =?utf-8?B?V1UwTWZzN3RnQ2w1aDJ1M1ZEMVRYQWU5Znc2TXF5d2JPOVNEd0ZlbVdGWktC?=
 =?utf-8?B?MkhpZXJrSWFtdS84WnNMZE1pTUFzdW5XTElXMCt1eVB0a2xMYnhOS0c1ZzZo?=
 =?utf-8?B?ay9YUHp0V0I4dnE3ek8zNTIrU0pvVXg1ZlpaeFVGRzRuKzRDZFp2ZTJZdUJi?=
 =?utf-8?B?bFEvc2dIakdhYWRHR3VDNkowak04TkFuOGNtZ1lLYUFpZVZDVTA0bXBDbXRw?=
 =?utf-8?B?UHQ4K3VFcWZLVjJOZFhxSkJjbDg4SHhKVllqaUFRZEVTN0JONk96cjMyVjlL?=
 =?utf-8?B?RXdmTEdHcFkwMzEzRGR2dU5POE9LYitrUEFYYzQyOHZsOEJaV1IxN3dqYzZO?=
 =?utf-8?B?YkZMSjBHMmM3NXdNUDVlYW03aW1nakVrNGZrQVk2TnJJaXRlL1dUNndpdWN5?=
 =?utf-8?B?RkVvaDI5azVoc0c0OHliSGpUV0RIVEk3WndsZ3N4eEdnQ3VuS1BDR1Q1NjA0?=
 =?utf-8?B?TVlDNWR2a1VIZWVDV1FKWDlrTnUyR1Z4Mk9vemF5SC9wTHk5eWMrQjR2YTM5?=
 =?utf-8?B?OHBkZnRvTGVqbzlHRUdlWTNYcVA2YTdMdUV1OTNqQ001WGExejBiMUpKU1lQ?=
 =?utf-8?B?VmFuV1ZndVlWcWJrblJzd0MyRDZOcXhIdG9CZ0pTbDFCRVFkeG9qNENyVlBk?=
 =?utf-8?B?V2ZVNExXWlJvR1ZoZUZYL215SDZLOXcvLzI0RkhXQUJQZWszTXlmSmRSYTh6?=
 =?utf-8?B?c285clg2WHhuSDFvV3J0UjVma296VVp5Q1pnRlFsVnc3UFNNYVQ2bEFaZ1hS?=
 =?utf-8?B?dm1UckdRem9kczZPSXIwNE15dHpaVitsTXhaL3VIQy9RODBDRm5TRkVuVGs5?=
 =?utf-8?B?eFBlVnN6RFVLMmVLc0U5TEJzb0kvc01jVkZuZXFTL0tqMTA1U01DcFI2YmZy?=
 =?utf-8?B?OU43ZkV0NllRR2JmWm1BL2VzN1lyV2JjNHZ6YVZYcTd6ektaeHdBczczTVRE?=
 =?utf-8?B?dnNLem5sZE1TYUlRUXBrTHNCV2N2U2QyQVp4Y215ZVBIcmZVSzl2VG9OSmZh?=
 =?utf-8?B?UWIzUHhlcDc5NTJkc1VocUZlVTMrOGp1TWJjbjI4cmFTWUY2dGNSd0FDdTZI?=
 =?utf-8?B?OFNwMERJRm1SOHllM0VBNWxwMGp3NjFKbUt5Q2xjaUh3VStva3FaM3VHVHBR?=
 =?utf-8?B?TlRLL0dYVUtaUkVscmY5OXVORkYzUXNRcVFFdWJaUTNFZjFSaTdFa3BLZE1j?=
 =?utf-8?B?cDljckREdHcvSlphS29NWXFHVVMvcHI3TnFZTjBNVnJ4TjNhWjJneGZRdUVt?=
 =?utf-8?B?Vkh2YlVMeTM4ZzNKVDZFY0EvS0pIaG1DMHlYTUE4aEt6cEVuVENNNUV0ZmVO?=
 =?utf-8?B?bnB6YzdaS1pnRGZIUzZKMm0zaktQaDBlM0hnaTZJQWs4M2hWM3Q4clhDMGRP?=
 =?utf-8?B?MTNWTzk4REErWFRobUpuQ01IRlJJWWw2ZWw4REdETm5WT2lDd3BQOVlFWWlH?=
 =?utf-8?B?a2JTZVZzWDhXQ0htUlNJWVdOaGtDVDJaOXR0bDZEL0VLMlRaZ1lOampwZ2cr?=
 =?utf-8?B?SC9RM1JOZDRoaWxOUjc4dzNJZEI3bWFvQzNyNmEwQlhEaFJ0UkNmQjl4TExs?=
 =?utf-8?B?QzdkbTRwWFNWZzdNK0tEWnFwSWw4U0dSRDIycHRzZGlLOTRvaXMvbDljMmN0?=
 =?utf-8?B?MFdDRzh0Yk9LUHcyb2RHMWtaZHlYemRCVDFBYTRwQjRuSkttVDN6RXBmNHJB?=
 =?utf-8?B?SExHYWlIRDcvNmF1SzdFck9ETmY3M2VQMXpFd0ZlTDZGNSs0Q0JGZTFEcWNE?=
 =?utf-8?B?eTk1VHJzdG5mc0s1MmhuRlNXejF5Ym5zZDlBQlhWWDBERW53cllqSXB1QmtB?=
 =?utf-8?B?ekp4ZlBJaFdYbmFUT0hkOG9SZkVMYVRSTW9NMHlYMmM1a3M3ZnA1WWV5dlZY?=
 =?utf-8?B?NU5EY0tkVFoyYW5zRy92RFdxb3AzaWphM2FGYktmdmFZSWMzUHhrcUx3SE0w?=
 =?utf-8?B?NDh4Nkd1ckxRWXVFbzloYnE4NnJVSW5TclNNdjgxUlJleklYV3B1VWpWeXAv?=
 =?utf-8?B?UlJXNWRBenlNY1YrbWw3UUhCd0RTS05ISzhiZVhscXo1bC8wVVJFQW9MdjNw?=
 =?utf-8?B?cG5nUVJyS0ZwQ2hrUWtHSUdzcVRBZWduTmlCcU9Ia2VZWWRIOGVHR2NBNnp5?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97614555-b6d8-43dd-6435-08dbea3a9128
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 02:35:47.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bM6sCDISE9gq+v4b/4FMOhPKaQ2E8ApwUxB6PdA0CpEHjOHPBMLj1V9O7SjQbn1QQELYXSvnvgLldIZ/1i1xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7814
X-OriginatorOrg: intel.com



On 11/20/23 21:48, kernel test robot wrote:
> 
> hi, Fengwei,
> 
> we noticed c8be038067 is the fix commit for
> de74976eb65151a2f568e477fc2e0032df5b22b4 ("filemap: add filemap_map_folio_range()")
> 
> and we captured numbers of improvement for this commit
> (refer to below
> "In addition to that, the commit also has significant impact on the following tests"
> part which includes several examples)
> 
> however, recently, we found a regression as title mentioned.

Thanks for the testing. I will take a look at this regression.


Regards
Yin, Fengwei

