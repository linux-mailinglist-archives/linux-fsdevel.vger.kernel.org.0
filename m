Return-Path: <linux-fsdevel+bounces-6355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89624816B8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 11:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321FF281300
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851B19BCA;
	Mon, 18 Dec 2023 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgdYavSJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F6199C0;
	Mon, 18 Dec 2023 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702896531; x=1734432531;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NIWtzefgnu3HaBkkTATx59skryZKF8+f/5XNa7dHucA=;
  b=hgdYavSJhNcsqE1jEITb8LuhMIPKKgD4ErSwM5nCxbcCYUxS+pGNxwms
   9QHtgrZx0nsX2ZGfFU6TGg7FNB/hkQPcbBQ8wiakjJNCljklKOPJidpgi
   7sMZtiJjD1XmmDQ648+7g/bh69AxmQQnTWqXEXDLJTqROjw769CntE8mi
   +WLPCsfS3qe7XZIeDnaKNUA3Sm6AjEEuLuup4asesDV0wbuehJ6m1eYFh
   mJiqrO64kKMTYqV82gKV1ynbufUFAlH43HPkWob7nMSU0zkN8UIb7mcm1
   SRE9shyxtcZntfdG5ejdVlHyZ4mk5zR+Njhf3DPXioZsqSs1f1mmV4i1Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="375640178"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="375640178"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 02:48:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="809773231"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="809773231"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 02:48:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 02:48:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 02:48:47 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 02:48:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJk18yMmPO+MWEAbh8W+I/bZipGQDiuZ99Ms+lqRBduoWYth7XDv8ngmw9VIQbpj9CwlzLpByVKiGroPtiS26bCsKy7zBduwwbAh78fYvFc1raiorw9HsPwfWwGT19l4qnkCGGCJFP7o2GsImUDeFS39M8cGLaepwifb384ZM9BOcpGj6rzgligeMDIclls8fRn8t1sNctSkivwbBKZUgsVZZm48mrySOxyPzrENOs8hX2MRM6Ww3SmFPPBgjkDSuhhb+XlckuyzIt39zH/k4jRKrKR8Z0RlasrGujRVGuR7cKPzODmxr7uuMxfnUZ2tbI6jnsmwAj06Eo8X1EnWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEcQ287ktwc03cs/dKkOKoqND73aI9w71WZ+ryvvBGA=;
 b=l11C6eUeucFF9qlYkAHxZUqz/TdcEAlLX8m++1vDo3998YBaLuBkC9CwKnIkdc1qdCFVF8txCwpDSFWvmTgurUpmhKKe86OkEx0sa/51NWtOuJtst52CNTpV19IluOAkQG5oIJ60oBLM70Hh+ZqRI/a4yrQQ1M971Wv4QZetGMALKNEwW5PSO9H80nqsg8T9SQe+ZrB+kFGim6IpEixKyqbK5pquionsnSElcVE9dHkU34u2mWIOsPgnkJL8shOZzkO5Y34T9x4izCADc/DVFGrOSdJs/UNP+CU2z0sv5jQhHtQjG6JgXk7/IwUCLVGttF2NC1OMG4K8fhXc5DvfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 10:48:45 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 10:48:45 +0000
Message-ID: <76af02dd-1f16-41ad-86c7-3202146d0085@intel.com>
Date: Mon, 18 Dec 2023 16:18:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/50] x86/lib/cache-smp.c: fix missing include
To: Kent Overstreet <kent.overstreet@linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <tglx@linutronix.de>, <x86@kernel.org>, <tj@kernel.org>,
	<peterz@infradead.org>, <mathieu.desnoyers@efficios.com>,
	<paulmck@kernel.org>, <keescook@chromium.org>, <dave.hansen@linux.intel.com>,
	<mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
	<boqun.feng@gmail.com>, <brauner@kernel.org>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216024834.3510073-4-kent.overstreet@linux.dev>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20231216024834.3510073-4-kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: df94fd37-906d-48cd-ca04-08dbffb6e7cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZkhsNsvXLObP0dNig8oBoaNHxIjEJsDcqMmVqSv18gq2icCiktivPUzdwYsCXXnTeTQBoNH6HA4a+OUskJNkkc7NZidQkeaRwm0UmzXH+8PG6iVhpz3ub5lPq0FZdCr8ZzO+SaVVuUtj8IVXNJCjbyEV0TFVIO1wnMpKMl7w1C42Njo3q5Ep8LfQgmLbafumxbqAwakNlDSpAuunNg4egudHNthJtj4BE2f9wYDllt8u5zW4bl2Ty7BrOPgq9WBmu2Mt/Rovm+AaY1hityOhhGt+f2WYZAk2IOtY4+5QcI5FHdZ9nXmTerG0zNJ4C88kGmVbhRr0YVm0yUczlD2zSAm5cXrmMEOX4J/3zXr/+AVqLwd+OO7FVnSqtu++uG80jABaRhdWULjf6DyasXZ3PUEf+acZsduRsTNAoL30IxH2MbuSEUzMnBEYzyIx5NUCFQatrwmp0OQ9EoBGHMm6VeUt9tXv0k5TulSjTylU+VbHTXX4A8FSrzNNcu3fzqx/ukWgeC54PXPPhdDzmDBGG72v00CoGuAofwjRq7GquA9TKc+2D603js4vklGAEyKwgUhsklozVZji24xLfFwCxHf4vmcXtYi3WLtgmw7nkN9v4PHMrgjSzN/WMUCP3qOLw//8/dJU8KvPJ72+u4X6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(2616005)(6666004)(6512007)(6506007)(5660300002)(44832011)(7416002)(4744005)(41300700001)(2906002)(478600001)(6486002)(316002)(4326008)(8676002)(8936002)(66946007)(66556008)(66476007)(82960400001)(36756003)(86362001)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXBkenQyNkhlY3BEWWNJRWVlVWF4aFBBY1c1eTRGZ2RPM0lpMnhocWhLeG82?=
 =?utf-8?B?RnJ4OXRGTk8yZi9wVTFJdFVvcVhLdTQyZHErbnZ6TWthNUNPRUtBUG5nQ1Nv?=
 =?utf-8?B?K2ZNbUpSS0ZxVUh3WDNScjdsbklPajhUUUFwR1JaM0VabUpzOHQ3c1BqeXFz?=
 =?utf-8?B?dklPSDBXeURvVGFVdDk4eGxFMjdLSDd4WCs4Z3AyeEZNU1d4Q251QTlxN0dl?=
 =?utf-8?B?Y3hvNXRVb0pXUFB6WW9xZVJDekQrQzhYOWVrZHMzZ3dwdEo2L1N5VGdpMm5P?=
 =?utf-8?B?WE1vSy9wK0pCUlloVVlYMHlDd3NBRXpZZVlpK0wzTVhUUWhyNFp4VlhvM25O?=
 =?utf-8?B?TkN1UjVBRnBSRWw5amtzb1UrM0xkVitsTHVVZTRRblF2ajAreGhGZFFzQlZB?=
 =?utf-8?B?N09oZVQrNUNGM0lwNWx2RFRhZ0xLOGFBZXNEelpkajUrN3NFeWFlNWYzOGRD?=
 =?utf-8?B?eVhzSU9BZDhuVVF4cGZ5SWlqRmFET1A0TUUrQzNEY1lqOUl1TFowUVYwR3lH?=
 =?utf-8?B?d3pjNGFvMkdaTW9BNFRlV0ZMZFMvRE1UWm52Z05XMkYzRFF6UVFlNkc3Nzkx?=
 =?utf-8?B?OWdNQmZkOUtiOUxlYXh0eUlYUGRNM2wwUWYrMy9iU3JJNjZqSEpLTmx6WGhM?=
 =?utf-8?B?dDErLzlocTNOYmlMSm93K25oUTBqWTF6VkJzNG1SNW1VSDl4NmZSYzlzL1pM?=
 =?utf-8?B?ZC8vMEFDSlJ5NG9uOTVMSUlrWmoweTU1bHJmV2ppZjZIaGdhTzVxTURuMmR0?=
 =?utf-8?B?WVh3TFhpMjVOTXN0RVMyVVNWdDJDRDZKNUtKMU1qLzg0M2tLRHl3V25Vb1lS?=
 =?utf-8?B?aEFZU3N4dURYYkw2c3J4dURIby9SL09ETSt6ZFdQdkl3TFdoR0NwY3Fxa0J2?=
 =?utf-8?B?eTN1Q3BtZ3dIa2VlekpQMlk4TGUwZy9jZkpUZHdFVXB3STV0bEZvK2NEcUlp?=
 =?utf-8?B?Wmc2dWNMa01udi9HSU50d1lvb0UzRG1JbnVveDlMcm83ZTd6QnpvNTVNeWlG?=
 =?utf-8?B?VDdocWQxQmFqSUsyUlBicDZJM1N2aXZvWFlhYTdhSUd6UU1ZbjhTZzBNSmhP?=
 =?utf-8?B?M1pXTnZJQ3RnLzExTDF1elNXRy9iRE5PeUdpZGxMSkpLWFpwbWVwRkM3MlB6?=
 =?utf-8?B?OTExMXh6SHFPQ1pkOU9KaTcvM1hqak9Uc3R3M21lUGw3QzU0VmQ2aVFXZ0p2?=
 =?utf-8?B?QlN0TUx0ZmpXa28rQ0NONStGbkxOVFFsWVg0T2xrUGx2ZHdtdlV5L2c0RzZD?=
 =?utf-8?B?U1Y1QUplNEx3Vksvdzd3SHRLQktVazAyOVQzQk5BUnY4VmFtTjBnbGZLUWxi?=
 =?utf-8?B?T0VkZm5RRytpTzM4V25YK29OUlkxZERVajU3V0VxSkJlaEJaMDBNVmR5NzAz?=
 =?utf-8?B?V2pYajYyV1hUcFlNZVlXZ0xwbmRaTUkwSmZQcElJeHpmeUZ3b2FaTkg5RXN5?=
 =?utf-8?B?V01iVFhnS2U4RzA0ZXU4bDg5eXFPUU5mWUNYRzFFczFmQmpQNnRSdDVhdE82?=
 =?utf-8?B?SDl2b0c2a1RaRVlsdzJWRzcweW4zTzBtdm5VMWZTelhGMXFVcjNqMTJLbW9j?=
 =?utf-8?B?MjFNWjFyZDFPWENHdXpacFBhYkRWTkt4ZUdjYTM5QnRsQnVMb2xua2xCQ3Mr?=
 =?utf-8?B?SnNLaHJCOVFJY3JMSTZVVWNDdjhNNGhsNDcwcysvSDc0Q2duZzJsTlI4anVZ?=
 =?utf-8?B?TDRSUmx1Sy9FZlZ0UVc2Sm52VFNTS3NMeldIVGxJcHQ5NkVpc1kwSVBZM3No?=
 =?utf-8?B?UmtiLzV2WEI1WVZrRkhLd3F3OFhkNlF2REVRNlM5WVJwV1cxVDg2ZHFlQjN3?=
 =?utf-8?B?THcyMTR2VldNbXhBNm5MVmJvNC9VeTFFNmlVbmFSSXlJK3dnUGxKZW9yMTQv?=
 =?utf-8?B?WXVXZTU4aC9XaTQrVXlSYy9aRzVkUXlKN052YldwRWRvc0lCR2lnWXBhRjcv?=
 =?utf-8?B?VjV0YndxNjl2eDJ1QUtZRzdEaTB1cmtLRVZYd3JRMXFNVzBLRmFPM0IxT29q?=
 =?utf-8?B?b3FqeldEWitWaUpGL0NzQTJrZEpwVmtydDYzN0UyWEphb3ZSTFFBNm5kK3cz?=
 =?utf-8?B?MXZmN2FhRWUvQlQzaEZ2QmNQSHVscVYybzJvb21senhFV2JvSmIyR2FSVDR3?=
 =?utf-8?Q?xEBQVELeEWp1xWeYxfa5feZPm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df94fd37-906d-48cd-ca04-08dbffb6e7cb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 10:48:44.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWeiZ4aPMY1Y19fRNLabU3I/clMVfJXFcqPIj8UbO3rbylnX555MUXt35th7rGbz6H755PBY+1oI33+VuIE9bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
X-OriginatorOrg: intel.com

> diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
> index 7c48ff4ae8d1..7af743bd3b13 100644
> --- a/arch/x86/lib/cache-smp.c
> +++ b/arch/x86/lib/cache-smp.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <asm/paravirt.h>
>  #include <linux/smp.h>
>  #include <linux/export.h>
>  

I believe the norm is to have the linux/ includes first, followed by the
the asm/ ones. Shouldn't this case be the same?

Sohil

