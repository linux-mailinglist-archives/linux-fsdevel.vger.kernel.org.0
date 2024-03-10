Return-Path: <linux-fsdevel+bounces-14075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C0887758D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 07:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B957B22519
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 06:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2135AD2F5;
	Sun, 10 Mar 2024 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgQLZR3a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876015C9;
	Sun, 10 Mar 2024 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710052911; cv=fail; b=QanVqQXpiu8/somKS3Z4qxi2KvAbURE0c//DYh/B4nj3WVNdvXe6g5lUQXFJ5jTXnie7QA22GSqYYInRI5BwSL1UA8U+Vo6+xQAxQvx8my7c+VpUabRPPT59vbS3UwsCcokAmD+jm2ZJRBO12RyYtpe7f+uygyIF7Yr+vaUxmr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710052911; c=relaxed/simple;
	bh=snycoDNGBqO5OcRQ9OgC4uFC2DVB6cpm6Ayk95DWXVc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYKp6hqR9p+7AeEDf85Ia30oUbXmDUjdWZJIJoxISjsjlpfEgLA3H9xR28Dae0hDWrVDiwTkPPmt41XHMg+maQF1TCFizqoUBSnAmY1FNB4vFJC32NY0Y094sYF0jV4TyS9aJ09B88evcjzqK2DO/kssn+S8sX6PwCzXatbkxXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgQLZR3a; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710052911; x=1741588911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=snycoDNGBqO5OcRQ9OgC4uFC2DVB6cpm6Ayk95DWXVc=;
  b=mgQLZR3aOeJes+WQGRlV/Qj/UIf0h+3Ip+Fobpq6UexWi6M/5XJU2HAw
   Gnjw/Dx9WRq4LdiLwEnYz4VweLH049hi3iCAwO0oexX6x4Imsvr5G/kqj
   5CbBH+PpFG9ZhTFGYwaYbzxXqdvDC30l6N/NSXgY3A2p5afwqsi0EQse6
   8+rO783RmIKueKQyWSwiwiKgQ0zYgthVWxsqnMsD+DRnMbTRg1RTMbZYU
   YWwHgqGFkXTjhPxqRT4Ek14/odCjdnk8SAPfx3FisaJbTaD/kL9Ou/yEY
   0UCXfe3XqcnEegh9kb/94jU1rTOY5G/EJyYP3JVTmHwQ7/j/5dRkuuSEP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4617148"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="4617148"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 22:41:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="11286968"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Mar 2024 22:41:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Mar 2024 22:41:48 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Mar 2024 22:41:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 9 Mar 2024 22:41:48 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 9 Mar 2024 22:41:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKuGuJtF5TutjnaZCL4dyFOEiNRn9drcJyqgsZiUqoGafcxMXwWlOugt5va7ztZgQ986/756M8MNg4DowyJBHaVlTRtYcMT7Nbxc1mdjHqHyYiie8pQzGEPsaOHgXADEHCemeWfIWIffuSqhjWaTQif3A81PqVOFpTFhTAueahxfn2QXashRsO2T0xo4ElNsnaLcHcQywdbOr5eGBoTzMkG5gkvtmmoGkJyeOwOMLTe0iWs8//abU23tQTVveEi9FjCZGY4PiTZWJkLNftHm32xNfKv8IiATJVCFvw0iaBQiLHMwraAf0l+t9TRfbcANdyLaEV7mbI+6jAXbypqeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY/RvVtI+Ka5EaMslfQ5AOQPIeNSWYbdYbqGYJHKgaw=;
 b=fp8JjxVIJg0p+SNWkUj3itCU9boPCJRVkKgp0qcikRLOLTgMQiWCw4rBD017i4OXtA6c4NW/4gfxOTGW9KNe1WLIEGh/v84Rdn5brvJYUnwCNSMHe17Io3hYWU6YqMmXorJ2p8K6KdGKJ5wKHzhN+Vm8p3ImjVMH+xJ4LsfEGZ8RmXiIWtFwRGwakAYnu31VRHKm4mpEYF9xfNAB+bNdKNBwn2x4pW7RhBznnGTi/nvak37R0Zf+XQ62wSMKOrKz/Zel7KZqVFbp4mrUMLUKEwBWWd1156MZOBaYWb/e2tP1G+EDQOPTQ6CpCTPTeC+NMY+0beMCpSfObNmh/30MCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.14; Sun, 10 Mar 2024 06:41:46 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7386.013; Sun, 10 Mar 2024
 06:41:46 +0000
Message-ID: <d7ab3fd4-6c7a-4ff9-a870-535af51256e5@intel.com>
Date: Sun, 10 Mar 2024 14:41:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [readahead] ab4443fe3c: vm-scalability.throughput
 -21.4% regression
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
CC: Yujie Liu <yujie.liu@intel.com>, Oliver Sang <oliver.sang@intel.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Guo Xuenan <guoxuenan@huawei.com>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
 <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
 <20240222115032.u5h2phfxpn77lu5a@quack3>
 <20240222183756.td7avnk2srg4tydu@quack3> <ZeVVN75kh9Ey4M4G@yujie-X299>
 <dee823ca-7100-4289-8670-95047463c09d@intel.com>
 <20240307092308.u54fjngivmx23ty3@quack3>
 <ZeoFQnVYLLBLNL6J@casper.infradead.org>
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZeoFQnVYLLBLNL6J@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: bace1491-bbeb-4ba9-8586-08dc40cd27ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLixrIPdUwllgVKNwoIsZufrVKQTKUnBuu50J7mMa9sVpaPWDaqik5KozFPsblm7CyEEFjRY6oL3PbNOs7Biczm5CUm5hHZ07iG2Ffcculq1N5mC5taPBUbQDd9YXpt/62VXf+VSvAEQiVxjpeD9iNjDa2KxNKefQuxfs7VG5D+6aIvR5Pv6eCnctT7bDe1y1BSWWvZS2V6s8S84c8utIcNap69EjruIpL67RNNGEiLYc/LNtPdj44j1P9x1xsE9BVGXRwhZ8wuZNI90baY3oqLYzIbGGIB3iDWbDBATz4Giw6QtBO5WCuTRCBNscUg9pVFYiu6pZbjsZ8ly81C1zpWl5y3HvGywm9mEyXlZVKcZ0mGqYCnlnZyl9iLEc85UcjjWyK1b7WVZI4j1nYkkoecRjDHyVU8GuNXnwTX89jhfjcgoXG63GaNMowf6vO93ilMqD0hYwVV7GeUlgpLsLojjtgjWZYbXPlHIhid1xAzHhMj8qH0+qYR9+7zui2niDRIlXZ2r8PWmLtNJajPGF9bDcqijUUVYbebCdULsI7dNF1Ol2S8T4QaAB1+8WXpDn0cAgDK0oExftfLUrhojXQXOg4qEbG25c2Sxe3fO6u/dY9G1Qu8Kta5Z5Po7NjJm/SZCYaPUvb8ZH3IQW89GWPGAysckoQ8+Z50QuS/vlmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNjcVFyZnNSdWM3UVZKZWdLWmwvVUtZR000OU0zMW5LY3hadlpzbjlUelYv?=
 =?utf-8?B?M1E5d1FrMS8vbDRZZnAzOFhzWjZteGhDL0oxWXJIcmR3azMzSnpyUlVuRzQw?=
 =?utf-8?B?K25xT1FhY3JxdjlyRUZvMDFlSVlORTdxMm9TbEZWaFVwdFRHQVd2WVNZck8v?=
 =?utf-8?B?NUNGbk9ibVdOaEUyT1QvazBCWjdDZVpQS21WOGxjWEhtTTlXVVVRT2lLeUxF?=
 =?utf-8?B?UnA4RmdXQkd2NHc2ZE90VkN5U0FDN0o3cnlCdktCYUlTckFIM29CdnZDR0hk?=
 =?utf-8?B?YVlhdHQ5Z0hNZDBZQVpUbTRkV1dLODdBZlh1aFRUT1p5bTBQbEs2VW0yY2xV?=
 =?utf-8?B?UFlWbXJHNlZsRGsrTFJjMHErZTNFc3FOcm9Mc2ZDbjBmUW1RODZBZENUQ3ZI?=
 =?utf-8?B?dmlWNUtnamZzZE9RTXh6M0JyV0ZnRm9TWFBWOWExUzBoZ0VLZVlkWnJPb0Fs?=
 =?utf-8?B?Uy8wQ2dDeDlvdFN4YXZTVldzcENJZWd3WkVVK0h2MEVIeWVxWlg5cTdmWTZP?=
 =?utf-8?B?Z1lXTGNmcjFPNllVdE1qazg5K3NCa3I3SHJ1Y0lTNnlVblJCT1F0cEEyZ3NI?=
 =?utf-8?B?TnFJUUp4LzR4bDhYVkY4aEQzWXZ2cFJoMlNSTzVpaXJKMWdFa2VOREhGTVg0?=
 =?utf-8?B?blUyTVU5Q0lhcExvbExnRzBxWUhzTkpMV0lTV29XSkN0R2FacncxZU1PZjlr?=
 =?utf-8?B?Z2ExVGhOcjRxSEN6OHZ5czFkTXRmc2ZPRVcwTGZMU1FqRkpLNHhYV0xXei9l?=
 =?utf-8?B?ZEFvWDErbnQ2cUlMSlkxSDVrYkxXclZLQXk1bThyVVl6c3ZtbjFUR2NLZTI5?=
 =?utf-8?B?TjNkRitlSHJYY3VvL3BVRlQxNFRtOGJsUThqeTM1NEZ5TjRVR2tmMVVBME00?=
 =?utf-8?B?OGY1YW5kUGNxYytIdUNtNXdKNU8wSGZJUGZSUzFialVtK0t6Q3dQdUhzVkpE?=
 =?utf-8?B?aFdGcUxnK0dJTXNpUUdDbW42N1hzd05qbW1TQ2Q5L01GQ0craTZ1dXc5ZWQy?=
 =?utf-8?B?dlJsdm9rZ2lCODJBZEdzelJRRzlhOVRhcG5PMHIyMzhnSHdzbkhaSkcreVdi?=
 =?utf-8?B?eEU5QTZRa0FnQ1FBQ24zVWtEV2NKZnpEd3QyVFdMM1NTdW5yaDZHSHNRT0Uy?=
 =?utf-8?B?eHhPLyt2UnJCdUswd1JST2dKNEliRmZTUkNpS0FVY0RKeUlRNmtuOUQzb1p1?=
 =?utf-8?B?eVFWQ1p0R2FLdVNlcUVSNEdydGtWd3VtbmtaUEF6MytWc21GSjJwcmR4dVpL?=
 =?utf-8?B?SWI3TUlpSld6dm9rZEViUFdmVEpzcHFhTjdRVU5mUW1QRnViR01QVFlweSti?=
 =?utf-8?B?ZEpJQ0k5WDNmdGs1cXo3M0ZXaEk0OHB4dStTbzdZWXV3b3phMmdySUZlaEh5?=
 =?utf-8?B?a2Q5eDZ3S08yV0lNaUZFRExLRnp5UTBueTVMbW5mWVpHZnl6Njk4STlpWDZR?=
 =?utf-8?B?Y2JQVDVSVHNPenltVlo3aU1jR3FDSFFGdXJGMmsraUZwbnQvUGtnbG5QS0xH?=
 =?utf-8?B?cHlJUjl3ejFvd3hwTkJQWEs4czFRV0x2Y3ErYk5kMmtzYUNJc2hQNXNQT25h?=
 =?utf-8?B?c04rVGh1QnIzeVlhVHdZMHJtN3B5NDU4Y0tzYzQ4Zk5wVC9ZS1RtS05WaFd4?=
 =?utf-8?B?bkRUSHNFcjZuMXUvMUs5TEdkNEZQM1pWRUNtcWMyc09xVlZNajRpNm9Pbzhj?=
 =?utf-8?B?bGJYNk43cUtPZFFMUkdmSExzSXpCZEZxUC9aZC9JZEhuTm0wRzg3ZFlmNzZ0?=
 =?utf-8?B?T1JoVzU3eENJNGdaQjRDbWMxNENLejNTbWpYWVBJZ00wemZjTCs0NDNGTXhX?=
 =?utf-8?B?VjFPZ1I0Qk9temFZQTAvRkdxaFlvalROM29yZ2RGcCtzYnJDRUNjbzlHK0Fi?=
 =?utf-8?B?eHRzeHFuUzAzUWNlTXI2Ly9DL0FSemRNa0lWTE5sUEIrdjYyUFYvMXJlakVM?=
 =?utf-8?B?bnE5cE54NzhVbUxqOGU2aE50L2IyNXc4eW44VFI5K2laYWZNc3plVTlXZm8v?=
 =?utf-8?B?Q1lMQVY0ZmJ3Zm9qK3g1N0c2YWxSTkRxTjhzMW1NRW5iL3JyOFE3RzlaODk4?=
 =?utf-8?B?SXR0TzBYVk9jYkRaZGZSZVIyYldiR283WTRvWFhpQkY2YndGeWowV1hDVG5o?=
 =?utf-8?B?dGUyYmVoZm5YbGpzUVVFVlcwMUJ0OUZmNHZqcTRXNDNTZWFTbitkcmJmeGI4?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bace1491-bbeb-4ba9-8586-08dc40cd27ba
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 06:41:46.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnvTE5oWi8sO7nm72pRfhvQNiZIz5WU4/d3R4L0agYGaE0GoZ/6QFsJ0I5+nseVPzo9N/00KSQ2C5OJOCFmJYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6399
X-OriginatorOrg: intel.com

Hi Matthew,

On 3/8/2024 2:19 AM, Matthew Wilcox wrote:
>   		/* Align with smaller pages if needed */
>   		if (index & ((1UL << order) - 1))
>   			order = __ffs(index);
> +		/* Avoid wrap */
> +		if (index + (1UL << order) == 0)
> +			order--;
>   		/* Don't allocate pages past EOF */
> -		while (index + (1UL << order) - 1 > limit)
> +		while (index + (1UL << order) - 1 > last)
The lockup is related with this line. When index == (last + 1),
deadloop here.


Regards
Yin, Fengwei

>   			order--;

