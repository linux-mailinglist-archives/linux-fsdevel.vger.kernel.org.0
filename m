Return-Path: <linux-fsdevel+bounces-14074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D5F87758B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 07:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6301C21DD9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BFC846D;
	Sun, 10 Mar 2024 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9PQEQ9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67085EA4;
	Sun, 10 Mar 2024 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710052823; cv=fail; b=DvQvzA5AvWYeffC6jyWE07EtB/mSE+veyD66RnaijlZERd5WpJh+BRJMt+Mx2/RIFoq9jJZ+y/h15PmvVwRUqio0v+frkY/WpbiVGeSiEuk5/S/c7m8cwXFT05+tC7wjnP5ncDZ4D6lE2RgYlsONiwDNPAU1Xd3Y2lYV7EfK0II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710052823; c=relaxed/simple;
	bh=1P74SRpaVwSo5sJA0iUra/4bDFejOOHW1Ig7p07HPGI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PuZNDozrvuSjbeGVR4h55IRYKm86hC59d8tL+9+vLIOdDOY1P08xryiZyOcFvp9n01cdnHioN3h9xZ3ELKrA6//fkJeBit7qhalp5VSX8X27ClYwbpVP4yCguj5/vyHYZDwLpiNgDw9jm0Tx9Eca6rGxcRUrZgIw1EoPKaglwws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9PQEQ9O; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710052821; x=1741588821;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1P74SRpaVwSo5sJA0iUra/4bDFejOOHW1Ig7p07HPGI=;
  b=K9PQEQ9OJTuFW/W/7XBheFpiuD/UOwbehzvdCgCC5uUZ2n9L/8JMH4k6
   ThVn/mrVdxmANNntDqRmPr1faDmYgscb58DlCBBl3XMiYapW4qUJnuynO
   YVrt8/b8Z8VkhmJ6JSTFLynI+vVKnADzi1jrqDAnEnVTikMDTsiwQFXc2
   P4sHH4QIXQpT6ZXZICn+OaEqiseodnOiBLE1af0Xu7TaDwZwhhyP7A6/k
   XyvLkI1dSK/Ta9GV4z/2kHnuuvo3KI7ixrJopG1zaRCaT+BO6QvRU7LoZ
   Y4bvRi1bG1BQ2rGBYEeG235aYdJjSY3anLCrTdPfrK4f04ATOMjv+CW7W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4658125"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="4658125"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 22:40:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="15354997"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Mar 2024 22:40:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Mar 2024 22:40:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 9 Mar 2024 22:40:10 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 9 Mar 2024 22:40:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvZGr7vEkqRlnpgDgG7vkpbfbyp7To9KFxEaF0Ul+FR5M28q3U1CUU3kouIt8dnfn3tWHE7VCimNkkuCCbN639udpzG2MTGlcCX7ub9TaupbkvfBVfMDnG3j3ju5Cm0Qo9y681ungHgmr2eI+Y+1SJZFAlNMBMaNKzppo5BpOCGIPKzOtwB89ttTCrIiQPKgyLoUFlbGrRhTPldD8nOyBzab1xb/x/22nMhDyJHrRuTwLrG+Hti2lLWwdxboJL43SXL08h43PiUjh06Huu/comK0nfrT8kFjWiKcFXxEaNGyNpemtPo0RE15PwgHk4zXMdmYe453fk6yq9V7Brnqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8/8kNy0KBXMRVbQQM3+UbP8aS/V9CesLIRQFq+/xCA=;
 b=LOxFyNkscvhoupqg6WQwPxLhL/2puOjqxCaoNMivT74HAr8pJ7/SM/+905L8eevsccU3DUkga5FiFpUSOm7UPeNzUqodXWH22AT/0Pr9mM29SlkhxcvMJCJrnIE9PMmvqOXzSHqwSdp6DcfzhXRDhe8FnuJXLS8cal0bwtYxnQnsaJ7opT69uOVHGzbYNSLchjCOFHIyRmDAvHXuo7bOnEsOrsetTs8avWcmw9cfb6J350znj/Wz83CgGJ+OobLOCtDVn7rTN/Nc0vnCBLur/g4QkK8VLokYBcDZiNNfqqGImXur3iIXXm2mx9c7MHyHxVyo34CBJPkwYgxuh4nbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.14; Sun, 10 Mar 2024 06:40:08 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7386.013; Sun, 10 Mar 2024
 06:40:08 +0000
Message-ID: <561465df-1370-4519-abe3-3998bd78233f@intel.com>
Date: Sun, 10 Mar 2024 14:40:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [readahead] ab4443fe3c: vm-scalability.throughput
 -21.4% regression
To: Jan Kara <jack@suse.cz>
CC: Yujie Liu <yujie.liu@intel.com>, Oliver Sang <oliver.sang@intel.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, Guo Xuenan <guoxuenan@huawei.com>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
 <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
 <20240222115032.u5h2phfxpn77lu5a@quack3>
 <20240222183756.td7avnk2srg4tydu@quack3> <ZeVVN75kh9Ey4M4G@yujie-X299>
 <dee823ca-7100-4289-8670-95047463c09d@intel.com>
 <20240307092308.u54fjngivmx23ty3@quack3>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20240307092308.u54fjngivmx23ty3@quack3>
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
X-MS-Office365-Filtering-Correlation-Id: d4824035-0052-4c6f-b1b9-08dc40cced93
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7z6G8S93yRPjDyaBcaP5L1L/4Z1UpF7ZYNtC69IIxjrLQCDJV16yeq8jxnMyzx5O9GAqbZ86RCY8FUrXFB0tq3sLfHxeJeXTED2d1a02Ng9ihE4hJyQmdvRCCyOsnowzaNtIfUvog3WWSMb8nosblCS9Xp7aDXSZ9aeqq7Z9+r3o3zj61gi4ti6QI7/vxC+Z83t94mZeTei8O31QWnRrFO8LSVwQlyh3prGi/aE5Yz9ZP06WUlK5Pq9ijpQr3uygz78ob36+FoGdSf4Qra+FWcLBt0LX+X3iKahkj704RuQjhA6hPb/tMWHFxirZvMc3+ti2FgagEKc00POPIvxtdttGTz7gxIpyoQqhrHX69mNF1kQCN+V1Yn5Ejblbv00nKLsuJqBY/6mkIbtMf74EPicHOcTnjO+hZJF63EzN7ZHKCPQOgYd5l2G6NLtFbC/WIfSvPWC2ZXaHc3dVlT7nazf9vh7x/3JBoaQlJ7MG1E/NImZHQFvcUm7HCG78ux4quBbCuck9/R1Qk980VPnYm3D+F3+05Hg/EbOcdOBiH/H+03wSFUwR895FCWMsmiomp+Q/TFN47BfdHWx22rIxY0lzZBbktY5cPs2b4PGezYjy0dug/mJ5Td/goKLkcDRh0iHM5VUiqiZjsDu1N3khG2LjLrCR710nmSB2gUeJnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5uWUM2RUo5OUxWK1BSVllpcXJqSENJdjRXNUNCdHREdnVZSUxsc0ZuZmY4?=
 =?utf-8?B?dU5SNElKQTAxdE5lVys0WnQvQmZBS1FUNGJndlYxdHBTdE1Sa2JtNmwvM2kv?=
 =?utf-8?B?cXZVZjhCNWlVVjJFbEJ6N2RrY3NEeW1VZWZOK2pxdWcyMlVadHQxTE0vQ1o4?=
 =?utf-8?B?bFllRjdKV2Y3ZG5hZ0E2Tk5VNUMzREp0dk14N3hTYnI5RTFLdVMwOWVKckFF?=
 =?utf-8?B?ZkQzWkRhQk1MNjRxd3k4SUpVKzljMjlweXg5TDZnTkhpMjlialFVN0U5Zzg1?=
 =?utf-8?B?TU5mcW43TzQvbFNYcmkwbzh2OVhmWllwcHFqeFJ5VUlKejRaeld4dVY2a29Y?=
 =?utf-8?B?UEFsOFlDQ1gzVlJhc3F4aW0rNXY1Y1BXSjV0M1B6SE5zczBjMVpPZmZrcytV?=
 =?utf-8?B?YUFVMS9UYW96NkgwS1c5VndRKzRxZ2daNTdDSU9uV0FDNHMwK01kSWJYallk?=
 =?utf-8?B?YitBV0xPbFpTbGlVYkZQK0J2R1JabC85T3hzbzg2NlV4dXoyL2ttaVpRT09y?=
 =?utf-8?B?MjZReFAxWkVMT3lMZEx0ZjFSa21yRHRqQnFkekVKbTczakVTRncxa3M5cTZY?=
 =?utf-8?B?MlNOdFlrTlJjZ1FtWmNiTFJxdEJ2TCs3anBTRjBrdEhQUnRvazc4Z2VPRVVX?=
 =?utf-8?B?Y2R3N21hSVNEWDRWMm5pWWtnaEIzajNtTERRUlZoT1NvZFZjdVNxRit4TFJC?=
 =?utf-8?B?RGVML0FJdXNtME1CNDNSOW0wTmxhTEMyUkdnc01JTHZkZjhRZHk5U0lDWG01?=
 =?utf-8?B?KzZHc280aEJKbElCN3padGEyY3cwSGNPWGUxcityUUdmZ3hXclBHbnM2L0hS?=
 =?utf-8?B?aWF3OTZFVHlhKysxWGd0K29UN0lCUE5mUk9EMHNKWDBkZDVsWXl2b2Vvcjlw?=
 =?utf-8?B?SUlzQzhxeko5ZXlzRGhtUWVxdjRLbkVCaXd2bUl5V0g5aFZSM1lHM01jeCtT?=
 =?utf-8?B?UnVzQTdQRDdCZzRGVFlNMGxuU3VaUytuS0k5TlNESWRhTzJEWmdEZUJWMEVC?=
 =?utf-8?B?ZG1tSlE5M3JBNktlc09xQ0lXQ2FyVW5paVNMeldDOFdMZlRCZzVIWkUxU2lY?=
 =?utf-8?B?R2xPNWVxaC9UUHFvbkRBcndRcXhqQ0NXbjZ1QjB1VzdiYU9iQVZQK0pBSjNl?=
 =?utf-8?B?NGF3R0xRMENTYXdBTm5HeS8wcjNVOGxaeUkzN1h5dU00RFdBV2dmY1AwNXNR?=
 =?utf-8?B?UkI2emdLZkVKRHg4dnlyMWszdGs3MlExb2tpWHNmRVp0a0dabnFvcWhJbzJX?=
 =?utf-8?B?RkZvUTFsTC80WjhBcGsxNnJOb3JGenlKdnA4V3M3U1JtTmxzc1RpL2FlRzFC?=
 =?utf-8?B?aVdzc3o5NDE2aXB0QjFmcDhwOG9Jd2ZzbHZXRitIcW9pajZwa25IRk9BTzBK?=
 =?utf-8?B?VGs3ZkNKemdqQ3JjNHgvZXJtUnNLS3A0RmkzRjVsSHEzVWIwVUdZaExiTGJ2?=
 =?utf-8?B?U25vNzhtQ0ZvQ3ZOcTlyWjlFM3hhWmNzS0dhYVlyeVQvbU9WbkEyUEtnTFgw?=
 =?utf-8?B?QlVLVGJoVXZrZFV0b1Z2b20rYnNiZHNpc1Q5QXVBZG43cG82c1F1MURUN2NC?=
 =?utf-8?B?Tkd1WWVNaEk5bkV1TWMzVjV6Tms4ZjV1RXR4Um1wN3VMVE1ZajlCQ1dmdHdV?=
 =?utf-8?B?ZXpWMTRxL0xNNjJkSlRvQm1hYWloM2wrMU9FMExqK0dvNEs2MFF3WEhkUHBt?=
 =?utf-8?B?MGZwSzN1Q3VwSnMxVzFjQ3BONW1vYWpqb29aRXpjbk81TXZUcm1ab0xQM2k5?=
 =?utf-8?B?dnpqZFcxVVlTazNJWU9EN0JDMVZlaVc2bXNQMzd0REJqMytKOVFiVUFXckRU?=
 =?utf-8?B?NGhYV0RkZEJUelVvK2VUM2QxKzRUK1RVWDdmWFlkNE9zd1FFZ01rcE1GMFNa?=
 =?utf-8?B?NXNYUmk3ZXNPd1BOWElaejV1bWpxUUVvMlpsS090LzRyNVl6SXcrTm9WVGFz?=
 =?utf-8?B?RUdMaUJpTVdnVWY2eTArSFh2VVdtdHBCOU5jNWhTUzhDL1hpZFNSVkpVSzNY?=
 =?utf-8?B?Z0tFaVVUMDMyNXNQMWRzSmo5b3pkSjZRNDJ2Nk1LVGNuSU5HNDRCK1IwRTR0?=
 =?utf-8?B?TDIzNHV2dzQ0NnFKbDQySzdINGVQYmJjYjQyaWxwVE5FWTNTbW03bGVKQXVS?=
 =?utf-8?Q?oSdLeDjtnAIRk1bThXgWhWhwG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4824035-0052-4c6f-b1b9-08dc40cced93
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 06:40:08.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuV5j1wDH8ZE50Zb227Ffo0ATYccTosrNbXig9xKzVCYLyyRxJBqyHjDSfm35JRuy9h6WOW/rpKCOZQwe/sXIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6399
X-OriginatorOrg: intel.com

On 3/7/2024 5:23 PM, Jan Kara wrote:
> Thanks for testing! This is an interesting result and certainly unexpected
> for me. The readahead code allocates naturally aligned pages so based on
> the distribution of allocations it seems that before commit ab4443fe3ca6
> readahead window was at least 32 pages (128KB) aligned and so we allocated
> order 5 pages. After the commit, the readahead window somehow ended up only
> aligned to 20 modulo 32. To follow natural alignment and fill 128KB
> readahead window we allocated order 2 page (got us to offset 24 modulo 32),
> then order 3 page (got us to offset 0 modulo 32), order 4 page (larger
> would not fit in 128KB readahead window now), and order 2 page to finish
> filling the readahead window.
> 
> Now I'm not 100% sure why the readahead window alignment changed with
> different rounding when placing readahead mark - probably that's some
> artifact when readahead window is tiny in the beginning before we scale it
> up (I'll verify by tracing whether everything ends up looking correctly
> with the current code). So I don't expect this is a problem in ab4443fe3ca6
> as such but it exposes the issue that readahead page insertion code should
> perhaps strive to achieve better readahead window alignment with logical
> file offset even at the cost of occasionally performing somewhat shorter
> readahead. I'll look into this once I dig out of the huge heap of email
> after vacation...
Hi Jan,
I am also curious to this behavior and add tried add logs to understand
the behavior here. Here is something difference w/o ab4443fe3ca6:
  - with ab4443fe3ca6:
  You are right about the folio order as the readahead window is 0x20.
  The folio order sequence is like order 2, order 4, order3, order2.

  But different thing is always mark the first order 2 folio readahead.
  So the max order is boosted to 4 in page_cache_ra_order(). The code
  path always hit
     if (index == expected || index == (ra->start + ra->size))
  in ondemand_readahead().

  If just change the round_down() to round_up() in ra_alloc_folio(),
  the major folio order will be restored to 5.

  - without ab4443fe3ca6:
  at the beginning, the folio order sequence is same like 2, 4, 3, 2.
  But besides the first order2 folio, order4 folio will be marked as
  readahead also. So it's possible the order boosted to 5.
  Also, not just path
     if (index == expected || index == (ra->start + ra->size))
  is hit. but also
      if (folio) {
  can be hit (I didn't check other path as this testing is sequential
  read).

  There are some back and forth between 5 and 2,4,3,2, the order is
  stabilized on 5.

  I didn't fully understand the whole thing and will dig deeper. The
  above is just what the log showed.


Hi Matthew,
I noticed one thing when readahead folio order is being pushed forward,
there are several times readahead trying to allocate and add folios to
page cache. But failed as there is folio inserted to page cache cover
the requested index already. Once the folio order is correct, there is
no such case anymore. I suppose this is expected.


Regards
Yin, Fengwei

