Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129B6726299
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 16:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbjFGOUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbjFGOUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:20:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB773137;
        Wed,  7 Jun 2023 07:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4a98Kt180BJOS2FA+qblsKep9J6J3SQXSWVyt+VIG5J4C+hep31/yqZW34YHvb16vqIyO8uqcgVg1ZJRg7hAtUjtPfxQ050cbDnOPHuRqD+xIwZSGcJiun1Q9+I9vOk+kQ1CoROoUzWs6OPHB0u3SNWsbZxTHdn9Ule5bFWdvRX7/neJE19dXiQ/QrGPzKe7Cgv3ZVT015WLI2tGOCwUvSWNXE3bVrV/pX8Y1wV0AnbjDcQE9EF67xRRxZ3niVrjE6V/pA1C1OR3dQlAdP7eHE3k7YPmFNpzyj5ol/k/uwjrc+PccJGBBZGXHjI6JaEZHUi1v2vULxpGWCmDeCl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLh2oRtE/VgRfaB3/2FPgd7s36lGrmafpuQ/aS63PpU=;
 b=Q2mbwgXQb0CBa3ztv5UOPQ6QULtBZXKPS4b0pfA7/Y6LgtvNBYYlHqs6OALdeWV0oRW6K5FI0Iu0785Bu8EuoDDyLNhTUxqKBajdSi1Of/3sumMPOrX0nIe4GPngj8AXOGAi8tMBIHPGHYaygHV2h6JvplxiuP1HtyaeHIf+CiNfGXdFvKoSRlY8lh2PWR5fQS9I9deYxtoZsYY+4kiWcPgrfv7PPYRQvlPekuxG+BvtgSPeD5ozVddH7A9XTw97iQBLgutNSqr9rUA3sCfKQH9zJK0k+DAJLnMi/fVm3bl9ePxYyHWy+R8uqaG0Fr7AWsDGirQK6B8wNh15Eq4QuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLh2oRtE/VgRfaB3/2FPgd7s36lGrmafpuQ/aS63PpU=;
 b=WDeESPRA6Q4U3Kzs03pRuve9rM3YNVgum6UDbAU7U6BVe8xUu4+Gqalny+2pwJ5VZEr608gpc8I0kcqgFNyBB439BAe5lgxgdPYDG1xC2YhKXpzVfaoSJhQuzmtoErp8YZquacDolME9Cy7o3LihywRydT/Z8k3MQXQNtNUpdk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 14:20:10 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb%3]) with mapi id 15.20.6455.028; Wed, 7 Jun 2023
 14:20:10 +0000
Message-ID: <37f64467-c9d7-826d-de41-aa571b2df0ec@amd.com>
Date:   Wed, 7 Jun 2023 10:20:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     yazen.ghannam@amd.com, avadnaik@amd.com,
        alexey.kardashevskiy@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] ACPI: APEI: EINJ: Refactor
 available_error_type_show()
Content-Language: en-US
To:     Avadhut Naik <Avadhut.Naik@amd.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230525204422.4754-1-Avadhut.Naik@amd.com>
 <20230525204422.4754-2-Avadhut.Naik@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230525204422.4754-2-Avadhut.Naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:408:ac::49) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4f0f13-97ec-418b-de9d-08db67624d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQbwoXBjPzxiF2NynhEaxSs5kXjPlVVuWFR+FxGLsHVG8wqJdroGlh357jdi1b0a/ArhnHmSZVecpVAKNtDFxVwdKHFK5mYtEAyU8p3QchbJjTK/4HTfPVNqkkFAp0kF9l54zadEEP95G8Le5pAv+fYzH6JExAuxbQZhiAviH97pCnKIYLenAW6l832Bh6Hti2EVZS/YyN9JEPAusi57THY1+d/8bHiAryy1lz50SS0GGeC6P6MP4k/J+oyAa/xobelMEbmVI/ZMczkI4Mwx57AfP31va3MZCesbGhcNk7mlBV6GS7vWelQxZ+2fNI73AlQaDfrikgaIIELK6i6lZpSFl0uzO6enu2jdgBS/M3iCq3jEmR63qUp3xXyopsEemIzA11UXwBPfXiGYJ0stFYpCynoOU3v4UDPWF/Kl4JSYT4sjAw52FxIH3dLvjpbmJMx0xcTcqpgKhwLkGGDW1pzYc3DW7vqCioudWReKq66VsP+N3jfAcY/InEJSZA8IEOUlZxZLUPxsjyoI2DsFlb1BUThzyuZmDRINUT/T3Ql7L20KMOxvI5BIzG18E1uB68p2C1SapUx9dKKSctFi4AzA9JovRpPjsxgmONcLVUQQ2ArbAKYIYxV1dBXquUuI4hAYP4QN4g9fM8Z8ajyoxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(2906002)(2616005)(36756003)(31696002)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(4326008)(31686004)(6506007)(53546011)(6512007)(26005)(186003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktJeEtTczBvQ1dyT0haTHlRd2p3emNwK3YrQXloZW02NHZ6RTI4TWhCZzdF?=
 =?utf-8?B?NjBpemU1akdRTG9CTm1oZlc3Q1dSMWpvTGxVcnA1S1JueFVUbmNaOWxzMnVa?=
 =?utf-8?B?aXUvZEN2TXVPeDcrNXJpZTJhMkdxSzFmVm9MaE1ybmVObVRCdkxQaUNXQVp4?=
 =?utf-8?B?NVZYelFyMjRoZlBoV0ZMNys0NW5yTlpwNjhJYVFvWWo5N0FRMEl6K3NldHBj?=
 =?utf-8?B?M05oSmRBNGlBSUh3UkdTZVk2QXJRdUFBVUVMVkVBZnJNKzB3MDlZQmRHNDQ3?=
 =?utf-8?B?L0NkZlVmSVgya3JGbWN3ZVZFS2l2WkVDcjdzNkErS0RLUGwzUHB4Z3NuNVdT?=
 =?utf-8?B?LzIwK0hJY0YwMjdOdmtDL0luc0RMWFBHd2Z6OTEzeXYrWHoySlNMS1I4RmVB?=
 =?utf-8?B?TmVJNnhUYzE5T04vNFZzbUxESURQMTNIZzVSU2o2RURlR2tSTUo5dmZMSVdV?=
 =?utf-8?B?R2p2VjBDZWMvWnA2QkpDQWVveDJQdVBOVS9ZenkvaHVYbzBKZlJTWmRWbFZB?=
 =?utf-8?B?V0F6S3I2R1dZMmxoVzhOZE1tTlMvVi83QnFITUtsN1hCbGhUYU9SUHhHOE5R?=
 =?utf-8?B?SkdUNUhweGhXdWFjVjhYQjVtQXZWWVFuV2FvUWNWaUNMT29VYUwxZm83NnI0?=
 =?utf-8?B?OVhSU1QzS2lkWFJVaDNTenZOUmttQm5mR09Yb0ExSlBha2dYODd3a3IzMXQ4?=
 =?utf-8?B?ZzZoVHRuZGxCUXlnSmxoZGJHSW55K2JVZTIyZGwrcFFqbmZ2U2Q2TjBCTU4r?=
 =?utf-8?B?bzNaM3ZUWVF6MHNqeW5KMHo3L1lzWTExc2hFSVI1MkVrQWRIL3RJV1lRNmJT?=
 =?utf-8?B?UkZERHd6S2g3ZkFmYWh5L01qMEpzRnRTMTJSRnBqTWVGZVRZQU0zdUdyK3Fy?=
 =?utf-8?B?V2lQMGxQSWh5MXlQREExS3IzSzFSdVBxUGJja1liQ0dDU0NDV3ljTU5QdzQy?=
 =?utf-8?B?bUlyeHNsR0o5TEZ6TnBJQXphUG9uS3pKd2VDQllHSjkrY04rbHVnVEk1ZGJx?=
 =?utf-8?B?VlhBbDY5Nng3VitQRXRMbXhWZjYvV3NBVnRCcjZaV3FHay83aEk5YjJoWkJW?=
 =?utf-8?B?Z1E2SUFBMVRFUGxWYlNLQVJ6c1RBVUtlTE1vc3FISnE3NllycTlOcXJUcTZ2?=
 =?utf-8?B?TXMzeDJkVjhyUE4vZ3crSXlDckZCYXl1NFRaeVVyOVJHVjZMcHplYkpDSm9w?=
 =?utf-8?B?YkNFYXZEek1QbFpSbVVlUjhCYzJ6TEFFbHk5cFBNQzZSS1p4eWI3RXJyNnJF?=
 =?utf-8?B?c1FHVU9PUThtamE0WDE4SmRWcXNmZFlVUkg3Tk9DdkZzeUlxa1RHeXhFb1o2?=
 =?utf-8?B?Ykk4SEJxRUdXR241YmE4YmFocll5WFhBMG5NSXFXVDlMTXI0RlZaaHlRRXdo?=
 =?utf-8?B?L01aZGdZZnNweWJFeittL1kwWHNONnErNjhZblA5bll3K2ZzbjhrOVBNS0xx?=
 =?utf-8?B?NEdxVUxiNVVJVzFBSHR2MzhzNmNheWVoY1hxUVNsQnpEd3gxRTM2M04xTWJE?=
 =?utf-8?B?RWFxN0g3anU4azdKQURJQkNTcmVqVWdpcnRBSzZEUzhoVEtwME5kSUdWbE91?=
 =?utf-8?B?emRBVi81OEV5RWdoYkFNRldETytVWlFCZFZxdUVYQXB5c0dnT1JpOXV2VS9s?=
 =?utf-8?B?SlZxOXF5R01oVnVZZjhtY09OSkFBd1ROWHVTU0Npc080QnpENEpRWEVZaXBR?=
 =?utf-8?B?OUFtenFRS0tBd28ydnhFaDV2T2JEbHp6TUZ5d0piNXBuSGYzOGdOalRsWWxy?=
 =?utf-8?B?M1FWamVlbytGcmJLcndJQ3l6eXAxbjBQQWsvR0ZzaFlCR3NFR0kva0tiZHhJ?=
 =?utf-8?B?dWsyVFpIYkR0ZXlQUXJSeTBzZ0JBc1ZQVzVKeEMrNDBqdkxzalNqeG1QMHN4?=
 =?utf-8?B?MWthQzliTkJhaEsrb3huOG11Um5pSkpTaGFwMXFWV2QvTHA2MUlBblZIeUxX?=
 =?utf-8?B?eGEyNDJMbWlpLzd5K1RZUHo5V1JodHg3dWc0Ukd5clRqditGYlAxVm9tanE3?=
 =?utf-8?B?Uzc4c1dRMklrZ2U1bTdPbk1ST2VXbVFCR1o3YjJQSDlQUjNNVFVWK0daTFYx?=
 =?utf-8?B?bU5kL1cyZVArSkwrcDgyWUd5VVZuL1p5Sy9xbGEybE1XMFo2aEZBZkd1aFE5?=
 =?utf-8?Q?PVe0sbBWqrEStL24XbbZgMvl0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4f0f13-97ec-418b-de9d-08db67624d3e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:20:10.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNHuhe0QhnlqJcNKsUvZTxs3kLHf/S35QrPAOFig0mtiDRYU6vTcc+tISoHvaIWfKMd8cXf8VkRbL4VmT+7c0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/25/23 4:44 PM, Avadhut Naik wrote:
> OSPM can discover the error injection capabilities of the platform by
> executing GET_ERROR_TYPE error injection action.[1] The action returns
> a DWORD representing a bitmap of platform supported error injections.[2]
> 
> The available_error_type_show() function determines the bits set within
> this DWORD and provides a verbose output, from einj_error_type_string
> array, through /sys/kernel/debug/apei/einj/available_error_type file.
> 
> The function however, assumes one to one correspondence between an error's
> position in the bitmap and its array entry offset. Consequently, some
> errors like Vendor Defined Error Type fail this assumption and will
> incorrectly be shown as not supported, even if their corresponding bit is
> set in the bitmap and they have an entry in the array.
> 
> Navigate around the issue by converting einj_error_type_string into an
> array of structures with a predetermined mask for all error types
> corresponding to their bit position in the DWORD returned by GET_ERROR_TYPE
> action. The same breaks the aforementioned assumption resulting in all
> supported error types by a platform being outputted through the above
> available_error_type file.
> 
> [1] ACPI specification 6.5, Table 18.25
> [2] ACPI specification 6.5, Table 18.30
> 
> Suggested-by: Alexey Kardashevskiy <alexey.kardashevskiy@amd.com>
> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
> ---
>  drivers/acpi/apei/einj.c | 43 ++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 013eb621dc92..d5f8dc4df7a5 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -577,25 +577,25 @@ static u64 error_param2;
>  static u64 error_param3;
>  static u64 error_param4;
>  static struct dentry *einj_debug_dir;
> -static const char * const einj_error_type_string[] = {
> -	"0x00000001\tProcessor Correctable\n",
> -	"0x00000002\tProcessor Uncorrectable non-fatal\n",
> -	"0x00000004\tProcessor Uncorrectable fatal\n",
> -	"0x00000008\tMemory Correctable\n",
> -	"0x00000010\tMemory Uncorrectable non-fatal\n",
> -	"0x00000020\tMemory Uncorrectable fatal\n",
> -	"0x00000040\tPCI Express Correctable\n",
> -	"0x00000080\tPCI Express Uncorrectable non-fatal\n",
> -	"0x00000100\tPCI Express Uncorrectable fatal\n",
> -	"0x00000200\tPlatform Correctable\n",
> -	"0x00000400\tPlatform Uncorrectable non-fatal\n",
> -	"0x00000800\tPlatform Uncorrectable fatal\n",
> -	"0x00001000\tCXL.cache Protocol Correctable\n",
> -	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
> -	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
> -	"0x00008000\tCXL.mem Protocol Correctable\n",
> -	"0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",
> -	"0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",
> +static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
> +	{0x00000001, "Processor Correctable"},
> +	{0x00000002, "Processor Uncorrectable non-fatal"},
> +	{0x00000004, "Processor Uncorrectable fatal"},
> +	{0x00000008, "Memory Correctable"},
> +	{0x00000010, "Memory Uncorrectable non-fatal"},
> +	{0x00000020, "Memory Uncorrectable fatal"},
> +	{0x00000040, "PCI Express Correctable"},
> +	{0x00000080, "PCI Express Uncorrectable non-fatal"},
> +	{0x00000100, "PCI Express Uncorrectable fatal"},
> +	{0x00000200, "Platform Correctable"},
> +	{0x00000400, "Platform Uncorrectable non-fatal"},
> +	{0x00000800, "Platform Uncorrectable fatal"},
> +	{0x00001000, "CXL.cache Protocol Correctable"},
> +	{0x00002000, "CXL.cache Protocol Uncorrectable non-fatal"},
> +	{0x00004000, "CXL.cache Protocol Uncorrectable fatal"},
> +	{0x00008000, "CXL.mem Protocol Correctable"},
> +	{0x00010000, "CXL.mem Protocol Uncorrectable non-fatal"},
> +	{0x00020000, "CXL.mem Protocol Uncorrectable fatal"},
>  };
>

I think it'd be easier to read if the masks used the BIT() macro rather
than a hex value.

Thanks,
Yazen
