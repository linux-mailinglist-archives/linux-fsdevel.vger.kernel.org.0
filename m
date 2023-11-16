Return-Path: <linux-fsdevel+bounces-2990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C637EE8EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96279280F73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94DA495DE;
	Thu, 16 Nov 2023 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hSA7gZRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46403181;
	Thu, 16 Nov 2023 13:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhsnDlMxNF2Qo6qEaAxoeu3x0Ieb7GdbKIC/36w8lZQAHlHdozMGgVUbg/PCaAzSdUwXOlmjtVkMqKJz3GdbrCRYfrgXiGxuPDVQyqbcMJAXxDlXfw/J6x9nZ83Wk+dTm85h/3vU9p4e6NxxIDnOlytzQ8z3rz4SfItH0GPGGwbUJBbAB0hvX2zbO+MU6ulzbrfwVh3W/vKHoMCPt2hS+ykHQG19use7lGR5FgEVLiOA8BDCUDgb5jn53OgI/UhsampV9XnczUP/enWHhqfO/pYi9YMWlQsbNBKpxvWzbBzKosUVcKYbQAntuIORe1IJJRuJbi9B99R/FWbUb8Sf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkC3m0veB7xXlky/uZ1uL88zNrOLKeqBg5W/LkOWpXo=;
 b=MvA80oq5XPktv+oL27V+yfoApitcG0VJf6qBEkhikLFfqLgVMBAzl3nt77unCBkfKRJqtPM+CKbL9V7ltjN3ZnNR/L6u6uGHnNWS4n0qBI6H3FU3bAYH4xKLQ+iOiKORyEDADNLFY1DkJ42Pvn9CfmeWcdASvVdyEYFfqo65VoVioYBoSmLo97kNPBJMy271Dt4A/ncGtqoE459/5MM/lVUAfi0Xtb5ggJd8JkSj5qm11VibYjvUN/ZqejrqP+0WexS9kNXm13o8tjeZWvrvmzoHk9cnL7h709KhmEI6vXaHupsQKTy3dI9pkQh9bG7+3cgtCBm8lCDwgILlMvGR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkC3m0veB7xXlky/uZ1uL88zNrOLKeqBg5W/LkOWpXo=;
 b=hSA7gZRv73vJuiJEVRedV0zKkjAXUqLoETBGN1wTVSVXbuoomxCbcsjZMUJo0O637wmoDAKXjhu+X9TxkyWv7Y58jZblS5VYjtRaa/oudezPqzb0ebghcGwZ9/n9s3Q9X2tTFtbjEOmNTS0//hQAIOquYykg7QGSkr2tTNfCruA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 21:46:46 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 21:46:46 +0000
Message-ID: <97a875be-3ebc-4d73-a4f1-2633b28b1111@amd.com>
Date: Thu, 16 Nov 2023 15:46:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v5 1/4] ACPI: APEI: EINJ: Refactor
 available_error_type_show()
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexey.kardashevskiy@amd.com, yazen.ghannam@amd.com
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-2-avadhut.naik@amd.com>
 <20231108201905.GCZUvtOSDkVqFPBmfk@fat_crate.local>
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20231108201905.GCZUvtOSDkVqFPBmfk@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32)
 To CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 989cef03-980a-4d5d-5391-08dbe6ed8790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YxuFEb2ojnMbsjT9yBLMV9MR34FKqG3+NGtc7mBzBrP7RJYheW9zDmx2yUrKLT1wlxRBIsQdwNCulHJt1GTI5ZB+qRPYp3bih57yDkigOOtqYCegcNO6IEFzey47ddhZiwt3Jt90hgfxelIYfRmm9U/boYNG82R1/L5LUcqfjVmsb8WQiTNY58nJE/Qo4/QjDG4f/gNqheimkLbHWQYdiU1IYcCkZP3il8/CnlFd79MLFzAhmkJZB9mVMA+/gGrgWZqjRbdBhZdaznD02wdZD12wl5AE6Vtf6QIPnWF1bCSUVYgpWLI/Zzm8S6yzKSu+n00a1x72RkUPWpXa91NcxMHHqqJZ2q2ang4xNRarpDGc3+o5pG3Qpx4T/b9YMCYashnp4X79UVRIJlfMRAkD8lo6u15YJgTDUp1hf1aM4w4oyKj044dzeVNrPQFmhdunAp8NwOYMQBZfzsYbiHegB2jHW6izMJ5PE5VSXq+29y0a3Acak4Sz2lmOZdoDS12CL2HYiFn48MVoB50w+6AGEfgHjvPDz5PX5w++O9H+RdkqY1feTvaMSdq3Ons5XMl+siMPAtA4DPFd3nwXQ4FF7COF63eAuTXa5hhWE0R16XjD5m4gAXq96U+VKZvjAIJtGJ6AiWlII2wrDLLV6y0D5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(110136005)(31696002)(66556008)(66946007)(66476007)(6636002)(36756003)(8676002)(4326008)(8936002)(2906002)(26005)(41300700001)(53546011)(6512007)(2616005)(6506007)(31686004)(5660300002)(478600001)(6486002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0tlR1dmRnFTYVFRcFhTZmVJMkVKeGg4bHQrRGtldGMyOUxkcFowR2g0MHAw?=
 =?utf-8?B?NUdKV3M3ZlVuNUVldlUwYVZSaXVvNjQxeXlRSHdGb2lScUx5RWlCb2MrYW1o?=
 =?utf-8?B?c0tqWXBBTU4yWi94L0xGeWtBWDlHMHRrSnpMWG9pVkU2c0dIQktWZ1E2YTZv?=
 =?utf-8?B?MTlSTy92bVVQNFJwRm5wYnRBWGhqdVREMFlyeGlWTWRZdmV3dTB5ZnNHd0Q2?=
 =?utf-8?B?aFRhc1o4SWl2Nkcrd1VWQXRhVGJGdkphaDkwajREVDVQeFBaSUg5TVdyc3h0?=
 =?utf-8?B?N0JpWStIOC9YODAyUDNNb25ZT1lrdEY2ZzdxaXByanA3Y3hUSkVtZWRMSUxr?=
 =?utf-8?B?NFNwTjBGb3lvSDFkd0xhbzRwSEFyY2NvclJTU3dUTFZJNjdBNkwwOXhlV3N2?=
 =?utf-8?B?T3hJZytUNm92WFg3U0Z6L3NRZkxvdHlVcTVSK0hKd0RIUDhNMXdNc2owNkc1?=
 =?utf-8?B?Sm1wMVRTeWlCK0p2eEU5RGJHM0NvcUtlbHdyWjhTTURtR2g3MjJwQ3VJWjBL?=
 =?utf-8?B?cDRXakRRNk9nc05DWDhUbmVrQitBdlV6M2ZSVlRjL0FVZkFVeTJMbG5IOXVL?=
 =?utf-8?B?OEkyYldRUWRNWDdFRWphdWsveUQySDkwMk9zZGlyYTFTVzA2WTJCc3lPNGNZ?=
 =?utf-8?B?bjdzN2ExalpIeHNnTmluNUFZVU5UTXpOc0kzMHJFL01rNGp0VURBMnNDQzdx?=
 =?utf-8?B?SVY4amFJQjFKdG9tZStWVVJGdVFOTlNDeUVhMnVYRkdUdGNMKzdFMzVldmZ5?=
 =?utf-8?B?elFsNVdvSnl2M3ZJUVNYRC9DeGgxTU1NajV1NTZsUVBEaWhwaHpPS29DOTA3?=
 =?utf-8?B?UTdyUVMrTFk2dERhTmNPelRHS3NSNTRqWXpjQkRCUlRKc3YwdUlOYVFoODFR?=
 =?utf-8?B?aHV3SjVOanY1SVN6YldRWUV0VzdtUC9jbTgxenNUZ0hIS1ZNTlJFMTU4QXBq?=
 =?utf-8?B?Wm82N1RNZG9yMENpN0tObGtHQmRWWW9lcitwcFpzd29tS3NGMHBRNE1yTGNj?=
 =?utf-8?B?OGd5dVpyU1k1SVpTQ2dGM0FQWnVDRWRhdEY3SnZBcllTQk1iU2xMNDlPRWZn?=
 =?utf-8?B?MGZZYkdGMnI4VWl0WlQvTS8vRzBESE5KazJ1RS95Snlac1d1dURjTmNPTzNK?=
 =?utf-8?B?YXhNMzUrSDRkeVJOeGR6SFJUREY3c1BpK1l3M1NCU2tETHdlTFlGdGt3YzBn?=
 =?utf-8?B?YythK2k5OHI1Qk5RYi9rOFRKYjhtWnd6WURvUjEyd1h6VWdmWk9Nb1hUNWVX?=
 =?utf-8?B?NE5hT3JIeHFmdlpkbUgzbFh6VFpDdEl6c2R6NVFqQmhhYmJvNkJnN3JlOVFz?=
 =?utf-8?B?QlJnT3hnemNWT3V1djMzV3dmdXMwMllhdlVjZ0sxb2FFVGFHQ1dYdS9ETDhN?=
 =?utf-8?B?ZTBYTGhhS2ZMOXlRNm4wa09sSHZmNnVOWC9xaTNyZ0htWmFQM1o0TFIrRUZw?=
 =?utf-8?B?R1BqYnNDemxyelNFQkdld0VyeWtSTnFyUjRRaDhqYk8vdDJhM0p5UWdVeDd3?=
 =?utf-8?B?a0Z1WVo0MSs2WDRkNDRrb0RRNlptRXpkUmI4M0MxdDZkenBxbVIxSlEzNnl6?=
 =?utf-8?B?Vlo3R0xkR3BUSUhFOVoxalhWZ04wQnU4NVg4SWR3MHZwYW9TNUxJVTdvL21t?=
 =?utf-8?B?aDdEVEJ6Rkdnd1dXUUZFdmtQU3pma2VmUWgzSmVkb1EvSTA3U1Njek8wNWw0?=
 =?utf-8?B?cEZlaVdoZERuUmZnRFFZYys0cG1KbmRjS3Vwa2lmN1JFR0lRcm12RUpaTnA4?=
 =?utf-8?B?TUVuWks2aEF6bUo2bC9ucjl4aDRXK0IydktPcjRSWWp4S1Y5TEc5NGdqSWhJ?=
 =?utf-8?B?SHJLNWpDR240TDdrQ1RpWHplTU1LYmViUGZJZ3hlckZydW9lUHJYaVdMMkdl?=
 =?utf-8?B?K1owd1NqK0laMjNXT0RhVWJ5WmZqQ2o4WDRLbWlKWUhNcVlqSDVUbXZNQmlH?=
 =?utf-8?B?aUdEOHJORzJJUnZJazhpNjM3SFlsWDFBaFhNWXhmcktTdGY4QVJHVlhWajVx?=
 =?utf-8?B?am5rRHk5VTgxbGFUTjNZQS9WOFl1NkZnNTczMDdqOEJDR2VlVERJQXhOdmRD?=
 =?utf-8?B?UlpKV3lFa0wzeGRXVnkzaWdHdmM4Q2lvK1llNGZWNWNNVW5mbE1VdE56U0cw?=
 =?utf-8?Q?DqPjtzGDu2ls8jh6dizYZqP3N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989cef03-980a-4d5d-5391-08dbe6ed8790
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 21:46:46.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97laQPo8gtpqkGsfg90X1LaHorDh6Lpuc1UW88u67BzuWqG227la2v52w8f5Ouk0gVutoVeGxPZiWcP0Tv4ktw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

Hi,

On 11/8/2023 14:19, Borislav Petkov wrote:
> On Tue, Nov 07, 2023 at 03:36:44PM -0600, Avadhut Naik wrote:
>> +static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>> +	{BIT(0), "Processor Correctable"},
>> +	{BIT(1), "Processor Uncorrectable non-fatal"},
>> +	{BIT(2), "Processor Uncorrectable fatal"},
>> +	{BIT(3), "Memory Correctable"},
>> +	{BIT(4), "Memory Uncorrectable non-fatal"},
>> +	{BIT(5), "Memory Uncorrectable fatal"},
>> +	{BIT(6), "PCI Express Correctable"},
>> +	{BIT(7), "PCI Express Uncorrectable non-fatal"},
>> +	{BIT(8), "PCI Express Uncorrectable fatal"},
>> +	{BIT(9), "Platform Correctable"},
>> +	{BIT(10), "Platform Uncorrectable non-fatal"},
>> +	{BIT(11), "Platform Uncorrectable fatal"},
>> +	{BIT(12), "CXL.cache Protocol Correctable"},
>> +	{BIT(13), "CXL.cache Protocol Uncorrectable non-fatal"},
>> +	{BIT(14), "CXL.cache Protocol Uncorrectable fatal"},
>> +	{BIT(15), "CXL.mem Protocol Correctable"},
>> +	{BIT(16), "CXL.mem Protocol Uncorrectable non-fatal"},
>> +	{BIT(17), "CXL.mem Protocol Uncorrectable fatal"},
> 
> Might as well put spaces between the '{' and '}' brackets for better
> readability.
> 
>>  static int available_error_type_show(struct seq_file *m, void *v)
>> @@ -607,8 +607,9 @@ static int available_error_type_show(struct seq_file *m, void *v)
>>  	if (rc)
>>  		return rc;
>>  	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
>> -		if (available_error_type & BIT(pos))
>> -			seq_puts(m, einj_error_type_string[pos]);
>> +		if (available_error_type & einj_error_type_string[pos].mask)
> 
> Call that variable simply "error_type". Those are simple functions, one
> can see that it is the available error type.
> 
>> +			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
>> +				   einj_error_type_string[pos].str);
>>  
>>  	return 0;
> 
> But those are just nitpicks.
> 
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
Thanks for reviewing. Will address this in v6.
> Thx.
> 

-- 
Thanks,
Avadhut Naik

