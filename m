Return-Path: <linux-fsdevel+bounces-19473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBA18C5D09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 23:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF2C1C2120B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 21:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45180181BBE;
	Tue, 14 May 2024 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdxLtU4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D6181BAE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715723677; cv=fail; b=gcRpgQ0j45Oh03oA0G5IXseEapgY/JiDvYImdsEynbpTBLK96ZTDE7aZ6QAHoxGr7ZvVn9xNDZHZvxhOUI0O3XuRapcROsQMB3z5DwGmHlmpkuuAj4XklZiZswxVCF/uWmNfTkBoYgAMbUxY1NBLoG9dkQRftA0wK2esm2m9NEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715723677; c=relaxed/simple;
	bh=CA3Dhi4LrqPUeIa12NvIrFtedmY/QMRxujJN4o+qLqg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rjFUyJYOff9qgPF0Q6zUrBPiAC/Zic7D7jIGK0bbvlNE5GxIbTPTU/WVFB2KA695wqTZIpd1PUviJnpyZ6FZxYF9cCVeGaYiYay0G7V2ca3EC/75xCpkhiMMuPl8u8asi8U/EDcasl0xjmdMSP7WUXt9e+IJGeJE3sgUPEVHZwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdxLtU4Q; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715723675; x=1747259675;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CA3Dhi4LrqPUeIa12NvIrFtedmY/QMRxujJN4o+qLqg=;
  b=cdxLtU4QU0l0nG5IdkX08Dix61+/SDtzWFkriKW88BIW632COXmtVB6J
   Esd63/A25ZH6SZielSAS4rM43+p0nOHD5wVWZZkSoZnWmXrEkqhLCVtjf
   7Jod/8+XyX2HoQRpYUejt9gdJZpjlRiyrOHxrVpzsHH8VKQmOnAQujhLD
   DCE+FgSdM8r8lPol8yBjjzqufrtJYPYgN/ijgxU42roiatFqEMSo3c3VT
   mDS+5uwQCAPXz3ZcCiJPoV8p6J+fcJ8412wuViLF+LXPVp7S0OclyazX4
   272QoPDKa4cqCQqUAILDYEvPH/+OeepfIg/nPwAq5G8XHAlKScHEFTT8Y
   A==;
X-CSE-ConnectionGUID: OcJBjt4lRPi2YV+mdpuTVA==
X-CSE-MsgGUID: jl5ATxfKT6iXGRzHU+lf4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22327482"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="22327482"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 14:54:24 -0700
X-CSE-ConnectionGUID: a3lAk4VBSbasUiq96wYhcA==
X-CSE-MsgGUID: r/BvLMPES4eIsI8pMj8a4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="31415575"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 14:54:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 14:54:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 14:54:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 14:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzmxXn8dSl0+nLP03y3NmpsKZeHBUWWP5TnmId8eJtdEI1/dDKQXoIEvNRLxjSkaMcKyX0SHlPgwA2U3Me5p1LePa6q9l8Puzuai7LbmUVKjSu7d5VOCZGKSbF5dLYX8PeOxakcNAoMuJ+Ggl+K0yt4iMcz2rWHAme4Z55yoYmzMnFJnt8iKIats98dd4ND9Zmr7lo1HTyDGuuBZhVCKIYb6yWZ5r8QH4NSuy0pxTMzM3RDDvjBOalMMF/af7uTBhjjyRxSJ3Sk/sxlDzm3nXtzd9rSu0dOT70IAf9KY5YkkdYoL/r9kYxqJ+UG2qF2eYl17s7yyLihVylnNYoeNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iQ9VamvwXM30d5esGrcm9pP5eTV4b0sB6C3en33Ouo=;
 b=McA0Y/yf07gAwd1MPBDVmMGgsk178Tq/C1SNjj31swdKXd1Lghii9BCevRPM4dkFEJycxCVT0GElw6DUOnRpwZKsqKNmjCJhXeR4GdGN5SoozpwsgvnLFpXAstlUQ6G4mBPL6O1zYRWoo6W+A2dIbKE+mKoIUuKPbfoXNhEDMA9RuvIxX3/IiIhEyMFbzVXNC9jCmxfUfj63Ao37FvdqVn9KFu+tEMPMgltabyJmcNMUnYIMDN0DQDZUv4OSdAlGNdB6ymScB2UTgTLApRZ5u7jHRPJwWV54UvQWPrZcRYvuOgqMl4lNmkAQ8ht6Qa7ICV/1WK1y4NCk8ezJtJuTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12)
 by PH7PR11MB6795.namprd11.prod.outlook.com (2603:10b6:510:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 21:54:20 +0000
Received: from CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550]) by CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 21:54:20 +0000
Message-ID: <49437995-be78-42ae-bb33-f10110e5f30c@intel.com>
Date: Tue, 14 May 2024 14:54:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/xe/guc: Expose raw access to GuC log over debugfs
To: Michal Wajdeczko <michal.wajdeczko@intel.com>, Matthew Brost
	<matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <linux-fsdevel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
 <20240512153606.1996-5-michal.wajdeczko@intel.com>
 <d0fd0b46-a8ac-464b-99e7-0b5384a79bf6@intel.com>
 <83484000-0716-465a-b55d-70cd07205ae5@intel.com>
 <3127eb0f-ef0b-46e8-a778-df6276718d06@intel.com>
 <ZkPKM/J0CiBsNgMe@DUT025-TGLU.fm.intel.com>
 <1c2dd2d5-1e55-4a7d-8a38-0fe96b31019e@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <1c2dd2d5-1e55-4a7d-8a38-0fe96b31019e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0261.namprd04.prod.outlook.com
 (2603:10b6:303:88::26) To CH3PR11MB8441.namprd11.prod.outlook.com
 (2603:10b6:610:1bc::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8441:EE_|PH7PR11MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 59884a50-c185-42e7-6f87-08dc74606897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnNhNGNsUWpzR05nMnBxbE9VckNkeE1mcEYzR3pCU0lBdnNVcG1oZnhVQzBH?=
 =?utf-8?B?b21GQVUydGdpMzFyS2ZBSHdRUjNoOGpqd25wRGhvbkl3ZW1kZmZJc2JzQ1hi?=
 =?utf-8?B?V0RJTWFIeVpmelNscExiZ1VEaUNIYW9weWNldktveEtmNmgvclhjOC9KK3h2?=
 =?utf-8?B?SkQ2OUtHWTg4eWwrQmtqRVc2SkVGTHp0QzNnVWdKd1BJVDIyWk9UMFo5M01a?=
 =?utf-8?B?em1meUVPYjJSWHprNWU3WEtYN3pvMHRTalF6U2psazAzVUtUeHV6Yi8wcTVO?=
 =?utf-8?B?VzBpVlA4SUFMNWZlYnVJcjFIclc4OU9zZUptekJjNmFvUysyeGlQT28zUzQz?=
 =?utf-8?B?MEpsWHZSbS8wUjNyQTI5enY3b0hXeVJHdTk1UFV5K2NtclRoRVNXeXZ4R3ZI?=
 =?utf-8?B?cW1OeExKZ2V0Ulo5WGtjbVhrZlRyUzVnREprRVBLaEdWNVFHWnBPUmw0bkEz?=
 =?utf-8?B?Wm1zSHAxS3k5WmFkMk1YREJBUTA3OWN6RDVYN09YcWFvVG9sUm4yQkNkb0hE?=
 =?utf-8?B?OU5nckhUWUpHaG5MQ0hrbzZ5N1JOK3dwS0pyWnk2bFZING95WExKdnlxdkls?=
 =?utf-8?B?R0JQZ2czOEF5K2hwMjJqMGtWeEtJc2lMQVJabEZNcldxS0VRNTVkWWd3a2Rl?=
 =?utf-8?B?NDBHWkYxV25JZC9ZbFZNTEkxaFU0M0ZZU0F1a2RieURtUWFDY1BPNTVIKzB6?=
 =?utf-8?B?cWxBeVRRalhkNlVUbWJCYkM3MVUwQzI0ZXNKUzNSNTZVaXRadDYvTFczb21Y?=
 =?utf-8?B?c3RQQVBtZXRHR3lmR05QNy9ENXhLeGUrODNmTnNmR0NXREtFMWNFc2ZkZklK?=
 =?utf-8?B?RzlOQ1VGNERTZENGQWRsdHA5anAwVnFaNVFRWm1EaTU3ZWtmSnFEazFkOElN?=
 =?utf-8?B?RVBwcGZhR2UrMWJ6cDJaSThoTjl1NUt3YzdZZW9nOGhXSlkvOTF1akF3WnZZ?=
 =?utf-8?B?emlPRm92Zk53ZldWa0NqNjIvOTdIS1Q0OTM3dW9uUkorQWREUVNMWjVBNXZn?=
 =?utf-8?B?d001S2N4TklXWnVISXh1dGYvUmxEQXFDMHdtNkpFYlo1bWdBNmEvOTVONzhl?=
 =?utf-8?B?L2NPYXowdkJKZ3ExQkZWTnE5WkpFKzlFNHFGUXBHNUdzamV1Y2ZKZTJCVlV4?=
 =?utf-8?B?NzRpMUtYSXFZNHd0UnVVV2xCT3FTa1dmR2ZPcGdHdGZpZDFWSTZWSFplcEFp?=
 =?utf-8?B?T3RyZDVFOU13ZmNUNnRTU1RhL21KeGJuMGlkMDVtSERVTTZTb0lYZ3I2Z0xs?=
 =?utf-8?B?TGl4MGhaTm5jSEZqd2pYWEtGYlEzSE9JUjJ2NTZlVXY2Y1ZTelA0NG90QnpZ?=
 =?utf-8?B?eXAyZWp1T0tjTkdXZWI4WmFTb0oyMUxkR1I2NTVUbHBlMmM2TkxnSkZTQ1hH?=
 =?utf-8?B?NDhSSk9McWZuVWFYR1RLUFBFWkZNcXNjMUgyQ3JQS1J4RStDbHpSU0hYNE1N?=
 =?utf-8?B?eWJPRnFQZUlYSFdrVUNnTXkyV0xkYVgyUDRhUytLeXVCTy9icmNXVW0yM0Na?=
 =?utf-8?B?U3YzZDFSR21wQmJLZkdvanFtanpHQ0tLYmdKbDRuN2FIMEVoTHY3RjN6Z2kw?=
 =?utf-8?B?VWVNV28zd1J6aXU1Z3JQa2Exa1FFbjdXM3QyWGNxbXZmRUVXRDd2cWZLc2pD?=
 =?utf-8?Q?NHaQSdScwRYeIFU07fcLw2fUghlitUwPQwKky6llgj90=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czE2WEdFek5jTnpkVCt0VVRIc25YdXNndVNqcTJIb2lCNThORGJVVTNuS01N?=
 =?utf-8?B?cWZSMlAxWnpWSnFZd09rT0NOMzlGalY2b29PTVZxOC9xVi9IRUUySmVnWlNR?=
 =?utf-8?B?T21lemxhNVFqZHFHTTNEV2NySFpnb0hWQ3h0TTBJc0pFSWY1SzRyNENmMVhx?=
 =?utf-8?B?cXZHUjhzU3NwTU01cW80Uk9Mb2VKNEw2aUdZUFVlTDZ1ck5MUXEzb2QvRWtX?=
 =?utf-8?B?Nk9QekhCcWtMNGwvZHJmQU40T0w4b2EvQzROYW9lYVNEY2R1UzgrekNFYUFE?=
 =?utf-8?B?OEwzVzViaDJ0STZaamc4eWxCeUtJNmpFNTgrMmp3MGZNWU4rY2NDZnQvTHp5?=
 =?utf-8?B?dVJGcjRnMlJVVzZPVWFZR3lYeU1uQ1dmbjYyVytvSmtwNWdzbTNkdnIrZ2tn?=
 =?utf-8?B?YnZQOGRaR0YvOVZ6WmF0U216UGxVWEFqQmtvNUhybUpUT2FIUzVwNFJWd0dB?=
 =?utf-8?B?Yzd3Z3ZHUGIzZkhpNHM3WVc0dmxmWE1leEJCb1NMY3BGNkovTkpodThsMlB3?=
 =?utf-8?B?czl2dmVoNU1ZUkw1eXVYcmFodXEyYlJMQ3BocFFWamJRdmFzdUNNZkpUdSto?=
 =?utf-8?B?M296UGdUOWpDTER6Vm5mTm5kekdjd1I3K0RtbitpTVVkQmhuSG9QeHBidXJ0?=
 =?utf-8?B?YUYrTnI3WUJzeDk1Vk9rb3VXb1gzeGZvelloV243YW5ZNXdUbUJ3TXpNRU5r?=
 =?utf-8?B?VVRicjJiQWIrNFlNYTJXM083UC9JU1dQNE45MzRDVDBsOUhnL0dkOVVKd0Vs?=
 =?utf-8?B?ME9UY3owUkhXVDdrTzVlbWRUODlhc2xDa1JQV0tUQnE0SE1uNGFyUktMdkJQ?=
 =?utf-8?B?MVhJaXkxU3M1Rk5ma3AzclFRY3loY0pJdlBOT3BmdTI2TGxiU1pkcUgwdUM4?=
 =?utf-8?B?SittT2lSS2U1K1ErRU9KaHlTOGU3eWdWdURFN1hFUGtPNm9aRVdGR09XeTJa?=
 =?utf-8?B?eWtNUzFhTzlGZzErdnV4RlFYRnJXZklIdWxhS2kwTW9NcnlxS0RwMmhRUWV0?=
 =?utf-8?B?eXNDK3hiR3dQWENpR1BiVE1tZ2svOHFLRHhiQ0c3Mk4rdGdxS0FZWlB3TGFm?=
 =?utf-8?B?OWNjYXZ4NmM5K3pzemlLc3FhN2MvR3FZMnBUb0Y4YUlYS2ZVODFLSGtHQW1n?=
 =?utf-8?B?dGpXNy84SEpmQ1N1SWREd0JtT0pycGE1NnhFZFdTZ1o5VDE1ZXI3TjlLb2Jx?=
 =?utf-8?B?U0lEVGkxUzlrWXEvQW9HSzRicGRwQVZZcVY4aVpSd3NyQlQzM3doY0RhTHhG?=
 =?utf-8?B?NHEvcE93ZXBwSnB0NUY0TDNzS01nOTduV1lHS1F2YkJ4ZWpMNEhtYzJmTWNo?=
 =?utf-8?B?bFZCWDNZckVpSE96WVZVSEtnU1llZ3pPMFJ2TXlldW1kRUVCZW02WTJmYkhv?=
 =?utf-8?B?ellMVjhXejdybStQZGVIUmRFSmdmNzlvdFA3ZmQ2NVlPb1lPb281aW9Xekhk?=
 =?utf-8?B?UHBYMXgvaFk2d2xmSEplQmswbENFaW53OU1vZ1BqR0RtMnpyTzRQZTY5NWVC?=
 =?utf-8?B?Qlo3QWdjeXM2RklzQ0x6UnpsU3c0Rm9telBkTElMOGpjUHlna0NjUXpocE01?=
 =?utf-8?B?S2s3Z2t0WnNFT1I3cnJJV3NRZWNkZFZvV0o4WXJHZHdHWUVYOW5ON1Q3Um03?=
 =?utf-8?B?WmpaRDBuenFnTU5ZanorZVZsUHVxaldySzRxRFFnU0d5V1ZRM1J2WGlxUGF1?=
 =?utf-8?B?V1hGQno3ZXpuY0FUTEYwQXdaUm5DZW5FdTY4UE9palZ2dms0a2kvdFJJTnNn?=
 =?utf-8?B?bFRUdGhFMnhmYnFRYjdkeGhkOWtsUGR3TlZMZ21uYzNhNk10eGJ1d1pndjNL?=
 =?utf-8?B?OU5NeE1qZDJoK2JteENOMlZJaGRUakpoQmlKSWNxR1dYYWxTdUErcjJOb3VS?=
 =?utf-8?B?aUxCbFE5OW9NRmJsYXlPK3kzUVFOVjdudHVpZmhkTXdTbkdNVE1pTFFaUWty?=
 =?utf-8?B?WkQyUzdWM2NybU5zVFpHcmdwSXhZUlQxNlRBM3U0dUwzSEVTRHlBUlg1aE45?=
 =?utf-8?B?bzkwZTZNYmFJUFlSbUhXelVOaStLNTVqUUdYQ29vRWZkRXdXLzVQcFpVVFds?=
 =?utf-8?B?bzIyek1GZkdES2lva0NseXg3Mi9iUUhSVXJHMmhYRWhuN05KOTZYcEo3bUVM?=
 =?utf-8?B?NHlSMEI0d3lIcjN3WDJoMWNmZHc5S3NaMFBXWnZTZUk2eVUzOUJEc1R0M0pD?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59884a50-c185-42e7-6f87-08dc74606897
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 21:54:20.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZoLyzP9hsTaDA3o7RarRKSBICLuFq1VfDId5ak9WCW0KJRkhsrlRtDsR+mb8nYafxA1MTxuCFLZigeuJo2Q1ZZ6oWi3xlCP6+6B8XJJG84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6795
X-OriginatorOrg: intel.com

On 5/14/2024 14:15, Michal Wajdeczko wrote:
> On 14.05.2024 22:31, Matthew Brost wrote:
>> On Tue, May 14, 2024 at 11:13:14AM -0700, John Harrison wrote:
>>> On 5/14/2024 07:58, Michal Wajdeczko wrote:
>>>> On 13.05.2024 18:53, John Harrison wrote:
>>>>> On 5/12/2024 08:36, Michal Wajdeczko wrote:
>>>>>> We already provide the content of the GuC log in debugsfs, but it
>>>>>> is in a text format where each log dword is printed as hexadecimal
>>>>>> number, which does not scale well with large GuC log buffers.
>>>>>>
>>>>>> To allow more efficient access to the GuC log, which could benefit
>>>>>> our CI systems, expose raw binary log data.  In addition to less
>>>>>> overhead in preparing text based GuC log file, the new GuC log file
>>>>>> in binary format is also almost 3x smaller.
>>>>>>
>>>>>> Any existing script that expects the GuC log buffer in text format
>>>>>> can use command like below to convert from new binary format:
>>>>>>
>>>>>>       hexdump -e '4/4 "0x%08x " "\n"'
>>>>>>
>>>>>> but this shouldn't be the case as most decoders expect GuC log data
>>>>>> in binary format.
>>>>> I strongly disagree with this.
>>>>>
>>>>> Efficiency and file size is not an issue when accessing the GuC log via
>>>>> debugfs on actual hardware.
>>>> to some extend it is as CI team used to refuse to collect GuC logs after
>>>> each executed test just because of it's size
>>> I've never heard that argument. I've heard many different arguments but not
>>> one about file size. The default GuC log size is pretty tiny. So size really
>>> is not an issue.
>>>
>>>>> It is an issue when dumping via dmesg but
>>>>> you definitely should not be dumping binary data to dmesg. Whereas,
>>>> not following here - this is debugfs specific, not a dmesg printer
>>> Except that it is preferable to have common code for both if at all
>>> possible.
>>>
>>>>> dumping in binary data is much more dangerous and liable to corruption
>>>>> because some tool along the way tries to convert to ASCII, or truncates
>>>>> at the first zero, etc. We request GuC logs be sent by end users,
>>>>> customer bug reports, etc. all doing things that we have no control over.
>>>> hmm, how "cp gt0/uc/guc_log_raw FILE" could end with a corrupted file ?
>>> Because someone then tries to email it, or attach it or copy it via Windows
>>> or any number of other ways in which a file can get munged.
>>>
>>>>> Converting the hexdump back to binary is trivial for those tools which
>>>>> require it. If you follow the acquisition and decoding instructions on
>>>>> the wiki page then it is all done for you automatically.
>>>> I'm afraid I don't know where this wiki page is, but I do know that hex
>>>> conversion dance is not needed for me to get decoded GuC log the way I
>>>> used to do
>>> Look for the 'GuC Debug Logs' page on the developer wiki. It's pretty easy
>>> to find.
>>>
>>>>> These patches are trying to solve a problem which does not exist and are
>>>>> going to make working with GuC logs harder and more error prone.
>>>> it at least solves the problem of currently super inefficient way of
>>>> generating the GuC log in text format.
>>>>
>>>> it also opens other opportunities to develop tools that could monitor or
>>>> capture GuC log independently on  top of what driver is able to offer
>>>> today (on i915 there was guc-log-relay, but it was broken for long time,
>>>> not sure what are the plans for Xe)
>>>>
>>>> also still not sure how it can be more error prone.
>>> As already explained, the plan is move to LFD - an extensible, streamable,
>>> logging format. Any non-trivial effort that is not helping to move to LFD is
>>> not worth the effort.
>>>
>>>>> On the other hand, there are many other issues with GuC logs that it
>>>>> would be useful to solves - including extra meta data, reliable output
>>>>> via dmesg, continuous streaming, pre-sizing the debugfs file to not have
>>>>> to generate it ~12 times for a single read, etc.
>>>> this series actually solves last issue but in a bit different way (we
>>>> even don't need to generate full GuC log dump at all if we would like to
>>>> capture only part of the log if we know where to look)
>>> No, it doesn't solve it. Your comment below suggests it will be read in 4KB
>>> chunks. Which means your 16MB buffer now requires 4096 separate reads! And
>>> you only doing partial reads of the section you think you need is never
>>> going to be reliable on live system. Not sure why you would want to anyway.
>>> It is just making things much more complex. You now need an intelligent user
>>> land program to read the log out and decode at least the header section to
>>> know what data section to read. You can't just dump the whole thing with
>>> 'cat' or 'dd'.
>>>
>> Briefly have read this thread but seconding John's opinion that anything
>> which breaks GuC log collection via a simple command like cat is a no
> hexdump or cp is also a simple command and likely we can assume that
> either user will know what command to use or will just type the command
> that we say.
>
>> go. Also anything that can allow windows to mangle the output would be
>> less than idle too. Lastly, GuC log collection is not a critical path
>> operation so it likely does not need to optimized for speed.
> but please remember that this patch does not change anything to the
> existing debugfs files, the guc_log stays as is, this new raw access is
> defined as another guc_log_raw file that would allow develop other use
> cases, beyond what is possible with naive text snapshots, like live
> monitor for errors, all implemented above kernel driver
Which is another issue. We now have two interfaces to the same thing. 
When should someone use one or the other? Which interface should we be 
telling the CI people to use? It is unnecessary duplication and a source 
of confusion and therefore a way to cause even more problems.

John.


>
>> Matt
>>
>>>> for reliable output via dmesg - see my proposal at [1]
>>>>
>>>> [1] https://patchwork.freedesktop.org/series/133613/
>>>>> Hmm. Actually, is this interface allowing the filesystem layers to issue
>>>>> multiple read calls to read the buffer out in small chunks? That is also
>>>>> going to break things. If the GuC is still writing to the log as the
>>>>> user is reading from it, there is the opportunity for each chunk to not
>>>>> follow on from the previous chunk because the data has just been
>>>>> overwritten. This is already a problem at the moment that causes issues
>>>>> when decoding the logs, even with an almost atomic copy of the log into
>>>>> a temporary buffer before reading it out. Doing the read in separate
>>>>> chunks is only going to make that problem even worse.
>>>> current solution, that converts data into hex numbers, reads log buffer
>>>> in chunks of 128 dwords, how proposed here solution that reads in 4K
>>>> chunks could be "even worse" ?
>>> See above, 4KB chunks means 4096 separate reads for a 16M buffer. And each
>>> one of those reads is a full round trip to user land and back. If you want
>>> to get at all close to an atomic read of the log then it needs to be done as
>>> a single call that copies the log into a locally allocated kernel buffer and
>>> then allows user land to read out from that buffer rather than from the live
>>> log. Which can be trivially done with the current method (at the expense of
>>> a large memory allocation) but would be much more difficult with random
>>> access reader like this as you would need to say the copied buffer around
>>> until the reads have all been done. Which would presumably mean adding
>>> open/close handlers to allocate and free that memory.
>>>
>>>> and in case of some smart tool, that would understands the layout of the
>>>> GuC log buffer, we can even fully eliminate problem of reading stale
>>>> data, so why not to choose a more scalable solution ?
>>> You cannot eliminate the problem of stale data. You read the header, you
>>> read the data it was pointing to, you re-read the header and find that the
>>> GuC has moved on. That is an infinite loop of continuously updating
>>> pointers.
>>>
>>> John.
>>>
>>>>> John.
>>>>>
>>>>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>>>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>>>>> Cc: John Harrison <John.C.Harrison@Intel.com>
>>>>>> ---
>>>>>> Cc: linux-fsdevel@vger.kernel.org
>>>>>> Cc: dri-devel@lists.freedesktop.org
>>>>>> ---
>>>>>>     drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 ++++++++++++++++++++++++++
>>>>>>     1 file changed, 26 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>>> b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>>> index d3822cbea273..53fea952344d 100644
>>>>>> --- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>>> +++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>>> @@ -8,6 +8,7 @@
>>>>>>     #include <drm/drm_debugfs.h>
>>>>>>     #include <drm/drm_managed.h>
>>>>>>     +#include "xe_bo.h"
>>>>>>     #include "xe_device.h"
>>>>>>     #include "xe_gt.h"
>>>>>>     #include "xe_guc.h"
>>>>>> @@ -52,6 +53,29 @@ static const struct drm_info_list debugfs_list[] = {
>>>>>>         {"guc_log", guc_log, 0},
>>>>>>     };
>>>>>>     +static ssize_t guc_log_read(struct file *file, char __user *buf,
>>>>>> size_t count, loff_t *pos)
>>>>>> +{
>>>>>> +    struct dentry *dent = file_dentry(file);
>>>>>> +    struct dentry *uc_dent = dent->d_parent;
>>>>>> +    struct dentry *gt_dent = uc_dent->d_parent;
>>>>>> +    struct xe_gt *gt = gt_dent->d_inode->i_private;
>>>>>> +    struct xe_guc_log *log = &gt->uc.guc.log;
>>>>>> +    struct xe_device *xe = gt_to_xe(gt);
>>>>>> +    ssize_t ret;
>>>>>> +
>>>>>> +    xe_pm_runtime_get(xe);
>>>>>> +    ret = xe_map_read_from(xe, buf, count, pos, &log->bo->vmap,
>>>>>> log->bo->size);
>>>>>> +    xe_pm_runtime_put(xe);
>>>>>> +
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct file_operations guc_log_ops = {
>>>>>> +    .owner        = THIS_MODULE,
>>>>>> +    .read        = guc_log_read,
>>>>>> +    .llseek        = default_llseek,
>>>>>> +};
>>>>>> +
>>>>>>     void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
>>>>>>     {
>>>>>>         struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
>>>>>> @@ -72,4 +96,6 @@ void xe_guc_debugfs_register(struct xe_guc *guc,
>>>>>> struct dentry *parent)
>>>>>>         drm_debugfs_create_files(local,
>>>>>>                      ARRAY_SIZE(debugfs_list),
>>>>>>                      parent, minor);
>>>>>> +
>>>>>> +    debugfs_create_file("guc_log_raw", 0600, parent, NULL,
>>>>>> &guc_log_ops);
>>>>>>     }


