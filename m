Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ECB7275E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 05:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjFHDtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 23:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjFHDtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:49:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEF926B5;
        Wed,  7 Jun 2023 20:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHzXFC2a3xRXW+OzWKguGNHE/OI69NXwfc6ysegWLxaNtg/KAzAl+hMbNsCY4cG/lYUz5aqACIj1U/YWkMtSLF7QMhxgL6uoTff5RfBYsEQHWHGRAO99Z3L1S7ODDFzVpNCjAVQ0Oayf5R/JkQ9qQcNs+Jer/mgVPwBJdK9a1xhKSL+/NvrCGV9aiXS1mzUdyBx/4fsHGd8haQsTTotUEDBLF5ZDl8kOvw5gFoMJUZBurGNU+pj9cgHh7qh2LcC8bWUSvtzq2yvrXujG9BaPhOkqzseT4d+tCDaMorDj/KZRP9+PVv0LJzUwVrdXEZ1kdl7ChlHhr4dBllVnuKGWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L0X9j+SlfrIu/KiAv02S1GhXiAL82f1qIegIMq3eDo=;
 b=OFDO4IrnvZVjyNX0fbW77G42XZM9YJTqFeA8tagWfH+q7j/3vH9o2E+juOOrIKXye4IKWkBL5JDoGESw4Z37R8Def1X/tNTn6IUEc3B0nb8rNVgxEExtcaJmDKfBw2PxNCTnm7VP6o44dfhgUQYrKl8JLrqlztRVDKTKTbK63Dq43WXAN8UZ5jDvT1ZwoMjI+6+9mFxCSgNEmOjELO0nqnG14Ojp/tqOF9VEwSX1J6R4NCAB7v7Tzw0ID2/uZ+FmGZ4FIklgHhIGGVyHXhevSsA0L/LHaqayabQJHPamAqBVF9NSn4s4NBk4o2qAmahpooot0QsWnsHV5rSlfEn6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L0X9j+SlfrIu/KiAv02S1GhXiAL82f1qIegIMq3eDo=;
 b=QjhYo61U2dujkTFqOjUfFHry0qTMogo2qCVL6kJeGeHgumeEz158gAnLgsoLrh/+Sjvyt33bc9+vwRLX2x5IwGcl1mtooYdcivSgbHQO1PNF6tyMcZH05PWzapUzRHuv1E+BTnJdDWN0eANLSjxsuWtHHh+pL1jpLrsMegI8SmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.31; Thu, 8 Jun 2023 03:49:01 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::ff22:cffa:293:5cef]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::ff22:cffa:293:5cef%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 03:49:01 +0000
Message-ID: <aeecb9a0-b3b2-cfa2-e5b7-a64d1ffe1c0c@amd.com>
Date:   Thu, 8 Jun 2023 13:48:51 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [RFC PATCH v2 1/3] ACPI: APEI: EINJ: Refactor
 available_error_type_show()
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Avadhut Naik <Avadhut.Naik@amd.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     avadnaik@amd.com, alexey.kardashevskiy@amd.com,
        linux-kernel@vger.kernel.org
References: <20230525204422.4754-1-Avadhut.Naik@amd.com>
 <20230525204422.4754-2-Avadhut.Naik@amd.com>
 <37f64467-c9d7-826d-de41-aa571b2df0ec@amd.com>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <37f64467-c9d7-826d-de41-aa571b2df0ec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0048.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::18) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a54ad92-fcfa-434b-45ad-08db67d34b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVIG0m/s2qwLeLN1uRBFRBZ9C6JBa0VnkeEP/2wWd9C5gxbV0MdP0w19NvFCM/+Mx7xBSTFxsXmPbc1YJZpZ46qa6Zdjike0MLe2O1nZ7uCy5fknXhR6RxsbTCiPC3eeGRc0qXdoKbx8VHQakpyd5Mz5Zg9J3wm7IShw//ga4XdRbMzhBfpmkuU1N2tAVo+OAkbDay8ZUFp84axpa+Mm4XWl/yobYLiiiK3WyMWDpBdWRbJqejb4h5mu416OWQWCkLoXljlpIkyk7NIyMShTRVtVT08DEzXKiGhU5dZfdDxZw7oKA6I1sphejgRNVJf5v/Svy8gqtlOGVMIQfHwG9TKUCCIIgAhtgZLnfVz0USjnW1inAQiQooL/GhSCtmg5A9N7xFsz9gNctNLN/fLRFr0b4oQjjOkwxk4s8RJlFNc+HPYYa8cg0hzucSe0Hb9KwM/f19iCZ12+wbTOPqw2Jg6DYmT+qxj/FDRqqAGd3TTaeeYu49r24M2Jp/YWrWGRwt9F8IZSnnCx3lFEgzuvqN6xABz/yWK/PE7sN1vUd8KJIGDUx/CFBCCmpLuVfXiFDX7qc/QZxCZlMTnaqPj+I2biRBmpumfrJevuoJUZkTXiH28zPo3+4OLQqRycVYv0lKw2sXN9dAicP/RGmhsKcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(53546011)(478600001)(186003)(36756003)(6506007)(2616005)(83380400001)(6512007)(26005)(6666004)(6486002)(316002)(8676002)(41300700001)(66946007)(66476007)(66556008)(4326008)(31696002)(31686004)(5660300002)(2906002)(110136005)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZiMmxWWlFuNnBZVmZrTjNsb3JJaDBWMldvWFRBRmFZVldDT3BHS2cyUDlF?=
 =?utf-8?B?S3ROeXJiVXZ5eVh4b2dXc1laT1AwS2RabjdtendXcWxObit3Tk81bGpYa2ZJ?=
 =?utf-8?B?VEYxTm5reEJYazVsWWFMQTFQeWdWSXBmdEd4NzFhMDFYWGFtNjJ0Skladjk5?=
 =?utf-8?B?UDJ4OHQ5RjRkcmRQZXY5d0hJdFU5ZzRHWUVQNGJHUmwvNGh5cDh2dmZXWWIz?=
 =?utf-8?B?VjRZRzlJcGNDWUdPMjFsOWFLUlpkR05OUEtFVitCd3Zhak9QMU81d1dBQVRh?=
 =?utf-8?B?VzJ0UlU0WjVPOWQxQ3NpemNDb3ZqMFd6cWZERmpITTVhOWhFL0ZaTGxuUlkz?=
 =?utf-8?B?UENUU3NuaEhoK1gzMkRWOW5uMlM0c3ppem9KVG5XVWl0QWdONzJPZ0UwUXZY?=
 =?utf-8?B?RGpLdmZEUXNOL0pVSUhsMndJUUlPaHVjRS9CTHc2LytXOERhc2FMK1Fnci9B?=
 =?utf-8?B?L2RESFRacVZMc2Mzc0IrK1dNdURtSjZGMzBLR2d2OU5XOFg5R2VVc1hsamlT?=
 =?utf-8?B?YmlZUkpOQUxqVlFaR000WVplbEE2bXRDdXZnL0J2c2lScEVZL1N2b1ZkT2sx?=
 =?utf-8?B?RlZUdW5QSWVpUnhIMUQ4dndFMHFQTGxhUlFTRUt1T1ZDQVQ3WjlmS1lmNzFQ?=
 =?utf-8?B?aDJ5WFd1YjlTZW1HSnFnUUluK1NvZHR5eDhPUzNXTEMyYW5kVUFzS3JNamtM?=
 =?utf-8?B?b09FbjJSQ1d6UllhV3ltaW8vaFJpK2tDOUpHdjhkelVLVDBkbnFzeFl2VXg3?=
 =?utf-8?B?V25BSEdsNUNsVGI2TGlvcktnbEduOXdkdHBFSzhMemFleGt0N01rajJ0R0tm?=
 =?utf-8?B?dUZ5dFhTcmdNWE11Y0VhbXNsS213QkVyQXJucSt3bWhvUVJFWDlOOTBvMmRO?=
 =?utf-8?B?dTk2S29nUEh0K2FJQ3R6LzRHdklJNFJvWk1HUGlqWGpUMVNRUkN1SVJIYUNo?=
 =?utf-8?B?UjlYTUlBYU9vTUxxOXJXcmtmaklNTUlWK2xnT09wbm8wL0lZdkd5SVBHRnNH?=
 =?utf-8?B?MmZ5U041SnZFRkxuRjBhZExrYm84Nnl2VmFuVmpvUTVNTFd5UWFiYUdJMG1D?=
 =?utf-8?B?ZzVIZXhlanByallKTG1UWU5qaFFZTFBGZFNFZ1ZJdWhJMlZNN0g2U3ZSOW9m?=
 =?utf-8?B?RngxUUZjSzM1ZC96YStPMGZId2w3WUFtMStOdEFUaDZwamh4Q0Rnd2Vmc3lQ?=
 =?utf-8?B?REFxK0RzVGRBQkJwN2oxNkVHVnNvRVZ0OEZpODVybVppV2dUZDJIYWJVSU5s?=
 =?utf-8?B?eHZxb0ZKT2JicWhaQjR0SDBrYm1HYURFcjdyZkFjRVNCR0JHd2ZjaVBIZGYw?=
 =?utf-8?B?THdiOWZvMXR0Snk1OEVPVkltZzFFZWF3dCtDNHNjNGJBenhlR3J0d0MyTEtv?=
 =?utf-8?B?aTVaN0p1WThoNTQvaUlPRnlzVWo3c0JBWU45TEtUSDUzdGV3ejd4QU9ZNnZM?=
 =?utf-8?B?c2haRENablQ4eHpDR0J5SFNRb1laeUNYNGJUSHluYWlRYWxBOEJJMS9ldkc3?=
 =?utf-8?B?bVUxQk9LWlpaMkVyK3JOdEkxcjBzS0cwL0Npb01xUWRWazZTTUxKYkRUei9w?=
 =?utf-8?B?QmFZdGhuYVlRbFprMmMwWlJ0VkZIWXAyaXhlUFovZ1FRdi8xVWtqeURVMkFZ?=
 =?utf-8?B?TkkxNklPSjRpQjBLbG9zVmxtakJxS0crY29nSmt6a2kwMW1qejVvbklXcjcr?=
 =?utf-8?B?aGE1T0Z2SFZyQm9KMExYOE12SzRFbkVOZTQ1MGhINnBQTnl5c0xXc1lhVTE0?=
 =?utf-8?B?SWI4SDRDM0x1Y0hPYnhoY0NMWXMyRCtCYm1RMmJub1VHNmJqaHJIbFRSdlYv?=
 =?utf-8?B?ZmJaSENFTnVEcGpGUXdaUHEybzF4Sng0TjI5cjdxK2pLMW1qUWpwUFpBa1g3?=
 =?utf-8?B?NTZFanVNWlprV0ZibGErZ1IyY01vOFhIdisrYnBBazBQaWNBZHpqbWpHRGJy?=
 =?utf-8?B?R3VlZW01alE1UDJQZmhxTUtRc3FmOTh5REt5ZG1xU2EwVVJTZnVnYWFIVzVw?=
 =?utf-8?B?SkNvNnlaNGdMbVpES0doZWlOWXpKUUdRNVlhYXFEYnhtbmIwQjI5UGwvQUk2?=
 =?utf-8?B?Z1E3cXh1YUdDTjlBOWpxNkpJYW4xaVZlWW53OWZnM3k4QWUzdEphdG5GSjRo?=
 =?utf-8?Q?At2ZNzmR34J/QmwKT06fJGdmg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a54ad92-fcfa-434b-45ad-08db67d34b98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 03:49:01.3620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzT/J9NaoJC2LMqJREdHvkI7QPGDUeJafDY8400cx17Sr2tqCN3pRy0i3ShAaDC3n3cP3aTTnt+iWmobS1fhIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/6/23 00:20, Yazen Ghannam wrote:
> On 5/25/23 4:44 PM, Avadhut Naik wrote:
>> OSPM can discover the error injection capabilities of the platform by
>> executing GET_ERROR_TYPE error injection action.[1] The action returns
>> a DWORD representing a bitmap of platform supported error injections.[2]
>>
>> The available_error_type_show() function determines the bits set within
>> this DWORD and provides a verbose output, from einj_error_type_string
>> array, through /sys/kernel/debug/apei/einj/available_error_type file.
>>
>> The function however, assumes one to one correspondence between an error's
>> position in the bitmap and its array entry offset. Consequently, some
>> errors like Vendor Defined Error Type fail this assumption and will
>> incorrectly be shown as not supported, even if their corresponding bit is
>> set in the bitmap and they have an entry in the array.
>>
>> Navigate around the issue by converting einj_error_type_string into an
>> array of structures with a predetermined mask for all error types
>> corresponding to their bit position in the DWORD returned by GET_ERROR_TYPE
>> action. The same breaks the aforementioned assumption resulting in all
>> supported error types by a platform being outputted through the above
>> available_error_type file.
>>
>> [1] ACPI specification 6.5, Table 18.25
>> [2] ACPI specification 6.5, Table 18.30
>>
>> Suggested-by: Alexey Kardashevskiy <alexey.kardashevskiy@amd.com>
>> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
>> ---
>>   drivers/acpi/apei/einj.c | 43 ++++++++++++++++++++--------------------
>>   1 file changed, 22 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 013eb621dc92..d5f8dc4df7a5 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -577,25 +577,25 @@ static u64 error_param2;
>>   static u64 error_param3;
>>   static u64 error_param4;
>>   static struct dentry *einj_debug_dir;
>> -static const char * const einj_error_type_string[] = {
>> -	"0x00000001\tProcessor Correctable\n",
>> -	"0x00000002\tProcessor Uncorrectable non-fatal\n",
>> -	"0x00000004\tProcessor Uncorrectable fatal\n",
>> -	"0x00000008\tMemory Correctable\n",
>> -	"0x00000010\tMemory Uncorrectable non-fatal\n",
>> -	"0x00000020\tMemory Uncorrectable fatal\n",
>> -	"0x00000040\tPCI Express Correctable\n",
>> -	"0x00000080\tPCI Express Uncorrectable non-fatal\n",
>> -	"0x00000100\tPCI Express Uncorrectable fatal\n",
>> -	"0x00000200\tPlatform Correctable\n",
>> -	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>> -	"0x00000800\tPlatform Uncorrectable fatal\n",
>> -	"0x00001000\tCXL.cache Protocol Correctable\n",
>> -	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>> -	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
>> -	"0x00008000\tCXL.mem Protocol Correctable\n",
>> -	"0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",
>> -	"0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",
>> +static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>> +	{0x00000001, "Processor Correctable"},
>> +	{0x00000002, "Processor Uncorrectable non-fatal"},
>> +	{0x00000004, "Processor Uncorrectable fatal"},
>> +	{0x00000008, "Memory Correctable"},
>> +	{0x00000010, "Memory Uncorrectable non-fatal"},
>> +	{0x00000020, "Memory Uncorrectable fatal"},
>> +	{0x00000040, "PCI Express Correctable"},
>> +	{0x00000080, "PCI Express Uncorrectable non-fatal"},
>> +	{0x00000100, "PCI Express Uncorrectable fatal"},
>> +	{0x00000200, "Platform Correctable"},
>> +	{0x00000400, "Platform Uncorrectable non-fatal"},
>> +	{0x00000800, "Platform Uncorrectable fatal"},
>> +	{0x00001000, "CXL.cache Protocol Correctable"},
>> +	{0x00002000, "CXL.cache Protocol Uncorrectable non-fatal"},
>> +	{0x00004000, "CXL.cache Protocol Uncorrectable fatal"},
>> +	{0x00008000, "CXL.mem Protocol Correctable"},
>> +	{0x00010000, "CXL.mem Protocol Uncorrectable non-fatal"},
>> +	{0x00020000, "CXL.mem Protocol Uncorrectable fatal"},
>>   };
>>
> 
> I think it'd be easier to read if the masks used the BIT() macro rather
> than a hex value.

Makes sense but I'd say because it is easier to match the APCI spec 
which uses the bit numbers, not easier to read (which is arguable).


> 
> Thanks,
> Yazen

-- 
Alexey
