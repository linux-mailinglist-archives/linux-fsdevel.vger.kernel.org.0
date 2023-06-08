Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A0C7289F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 23:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbjFHVIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 17:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjFHVIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:08:35 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D132D7B;
        Thu,  8 Jun 2023 14:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gglNtlZ/8s2qn4Ep/Oeep/L3dTykJssreTukqKbCYWeDlzxRwViXAHK8k8hBkUTGaWcensgVFWkewKTMS0gkoK+GAo0U/HNjvrZWwk9GBFARntfBZggx1j6aOtKJE2iWvbr7XlUAb18CVIi1dET2+qd9rhDnqLx9FTfz63DJwpZIN8NJPYTJACr8fR8c4Np0RsyCxeNLj1SdUvzent40paMJvItHbk+lTYHP88jHdGvVvsApT+94m4yezSH9C2VknikeSa0/Ezkfkd3mJqBncVaS/FWkVK7eoqkt5G2MhJ7wmqR57bk5/tswdyqr/qqObPweFO9buYUfrkD+HOlOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOxFeplb4LgCzONRYnKXVi2TC1OhyMDByH0cD3dEZdE=;
 b=bIkHbbVVbs4bjN8U4opt349QyIczPSp0ilObKW+5YZ27sbokyiqEbUIiTJtK736naC5Sl5nq7gIiNJTOnKRo6NuJufHSODmWC2TxoNHETs9JRPw8MbNEB2a9Md8VTEXF5dnEo1tDPf4jLfYD5yCvS00jtuwbxeFrK6W/OFbWDof8+Go9WBH+Lby+HZ1Y5W6heQWjAapPpYfme1wWeBPDY9rapvCOFUAXQqnlh22kttmmU8EQeyQb9K1bZANPeag5cj90Tulh8B6PR7L/feRkWT301ZmyXEj4ZeHikvMvGkAWbfmQnCLowCa/c51K/vM6bgCb9r2jLWVDXeY1Kq3+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOxFeplb4LgCzONRYnKXVi2TC1OhyMDByH0cD3dEZdE=;
 b=VuaDYIrm4etY3V/onTPXWrcGHc0zsjXiT5uVlINeMy8qS6prFn1B+uMj71fS5Chkzhi/R/yUmj0CBEcsNemhv/Xs18cXIM9qfrcBIy/5G0/sTF6+9/Y5DJo6Fv1uwytXc0BNo7wu05AHSiHvSfI6ERLwbxRs/uLbxre+rcY/OlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) by
 DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.38; Thu, 8 Jun 2023 21:08:32 +0000
Received: from DS7PR12MB6191.namprd12.prod.outlook.com
 ([fe80::3bec:25bc:7b64:d03]) by DS7PR12MB6191.namprd12.prod.outlook.com
 ([fe80::3bec:25bc:7b64:d03%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 21:08:32 +0000
Message-ID: <2ed4a89d-e729-6e3c-8514-f33fb0a8c207@amd.com>
Date:   Thu, 8 Jun 2023 16:08:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFC PATCH v2 1/3] ACPI: APEI: EINJ: Refactor
 available_error_type_show()
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Avadhut Naik <Avadhut.Naik@amd.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     alexey.kardashevskiy@amd.com, linux-kernel@vger.kernel.org
References: <20230525204422.4754-1-Avadhut.Naik@amd.com>
 <20230525204422.4754-2-Avadhut.Naik@amd.com>
 <37f64467-c9d7-826d-de41-aa571b2df0ec@amd.com>
 <aeecb9a0-b3b2-cfa2-e5b7-a64d1ffe1c0c@amd.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <aeecb9a0-b3b2-cfa2-e5b7-a64d1ffe1c0c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:805:f2::34) To DS7PR12MB6191.namprd12.prod.outlook.com
 (2603:10b6:8:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6191:EE_|DM6PR12MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: b01a98ba-c472-47fa-52d0-08db68648386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxiJ0w1eJRyTOkaRJLtvIfg4UUpEVC/X0I4keXUHGqfHasrB03jwyz1L2LzcHQWtyGnGIpuBf+lhKRw/fRiM8AMEtoLFR6Ksojiq968kOv/8+b0N9zmUhPzNNAkJEZBgMrXh/QUQa1GMvMi4mfwo4DXHHifFr6Q8oWAzUFFhI7v18L6Mvl+B0V5OZCECF7wilA1PSlzpazgS+rfg97DbSRAwl/EJCwqRHZl6NlYRknYxmPLs6X8owJ7mauxY1MgQw4h1578dgNpMNHyOW/2rBhMcEnUtDSnVGQptCxuWodWtevymr1JumKGLjy6sfLR/ucfgvrM1AQaUx8gUKqkllqILo8l/eRTysbhHzKZ+yA4ubXfNHvci5XQN5D0tI8SqT9bPK8MT+AA6buBNXzhOQ/iFP0Ms5nMsW0DcVABTaR+y8RVs7TvKJERzdY9yRBA5yxZtyvD9y8lOknaQiuI5uW9HwI5Gfr8ZEMTXWjD7dSLeTgJP0Usq2wcYFvPrZ9eivWSWKAA/9JywAn9az87BfcwmLbtu5UQ/0gOgCLb5d1eYQU2avp2mU85em7cMMlN1aG4l0pDOPRDX5sm70BguwSP7LYeYE9ejNUzlHYZl9u8kZKzEQ+iAg+oSpMFtnvLXtgez1z8ra1ZWkAbvmhnbBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6191.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(36756003)(2906002)(31696002)(5660300002)(31686004)(83380400001)(6666004)(186003)(53546011)(26005)(6512007)(6506007)(478600001)(6486002)(110136005)(66946007)(66476007)(316002)(66556008)(4326008)(2616005)(38100700002)(41300700001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk1adTNsa29lWWJOOFVWM2krSFFDcjMwVC9mV1A5bHB6TVpmNSszL2hQSXhY?=
 =?utf-8?B?NkRXcHFia3FhT3lXYlJTVlovajAweHk3TnFFcUt0dUVJSWk5VE9YM2llcW8r?=
 =?utf-8?B?NzRDRnZaWVVaTGpXci9GSWd0K3ZUSlhiVW01cVd2OEM2YkxnUU0zZWYybFAy?=
 =?utf-8?B?aEZuVjh4ZXo5cy92bmI3WHYrU1F5NVV2a2N1ZnFEVmMveTc2YlFXV2o3Y0h4?=
 =?utf-8?B?eGIvZm9BRmpjMm9vZkxvUEJFN2UyZWVzTUlnYTlyYlVldHIzVVpHRzNIQ2Vz?=
 =?utf-8?B?Sk5MaWpGYXRiWGsyTy94SStYdnZjYm11VHEzeXpKMzhyd29xK2NCbjRBWVJu?=
 =?utf-8?B?Rk1IQU1kdFJGcjFIYmZVOWFPaDFFc0E2MjJzZTF2c2Q2c3NJbzNrOHh0Z244?=
 =?utf-8?B?YVM4WWYzMVJkOWdOTmZ6NkZrVnFkdVFRbTNRODdXbTBXK20rdVJkcUo4NDM5?=
 =?utf-8?B?Z3ZiQ1NVWU95NDVtZHNnUWIxYkRSMy9Xak1GY2QwUkZLbUtNMTBBU0xsd2R1?=
 =?utf-8?B?czRuMDJ1T01mWHlXVy9JUlBHejVWaGtqd3VrdzhoUlU1L3YvOTNsbjZOY2do?=
 =?utf-8?B?Um0rR0g5N2VRM2RkWGtNZy9wZDE1bm8vK3RTWndQTy9pYlg2SU44dGt5TFNO?=
 =?utf-8?B?eFYrSlB1SnJvNVVHT2YzUHd5WEt3MnhDd2Y5bGhkbWx3Mi9yUDN0R1luWDRq?=
 =?utf-8?B?NUNXWkFERlRrQm1rVmJVdWw2NXZ6SnhhMXNiQy9admk0OW9NRWF1N05XZUFM?=
 =?utf-8?B?TC9vQjEzNCtTT2pvVmJtV01TejFxdWpGaXNEVm5qUS9ROURZd2VBc1J2UFps?=
 =?utf-8?B?VHRvTFJKcXo2SS9FWlZ4aFhsQzFlQ0tGa2FRcFdsSytGMkxSNTQvUi9FM2Nw?=
 =?utf-8?B?cEZsS0dMZW1OenU5R1BiS3o2MFl2N0VFZWt5a3U0STdwRGNzM0RyYS8xbm85?=
 =?utf-8?B?Q3JmSlZOUnB1OEM4eGFKSmVUQ3NJY1VRTTlvU1VuSE5tWDFDZDNTM1YwZmpQ?=
 =?utf-8?B?cEFmcmxLaklJUEloY2FVMGhHODJqMHkvT2ZyZ29ScHpDZmNZREMvQTdQamhs?=
 =?utf-8?B?WG52ZlJKb284RDl0cWlUelZMOTNsbnZxTlB0K3dTQzM0NlhWYmxQZWJGMmZl?=
 =?utf-8?B?RURDTWtwbE40UTBFaHgyLy9EVGVyRFR3Z1EyZmg3cXBDc2txbW52aDBqRnRW?=
 =?utf-8?B?bnZjc1NNUXRPWlNIOC9jK0F3bXdiNnNqMnQwcXFmRzJtTlRUOFcvbGJ5dUNw?=
 =?utf-8?B?dXB0K0hqV29ZckFTRUJrYmFpdXpQalJ4eDBJZGlyWjBTazE4eG9pb0FEbGFN?=
 =?utf-8?B?alhZY3ZSbS9acXNzeVZzbDcyNjVDeUhqNEZpSzRLUjlvbW1udXRsSFlFK1Vs?=
 =?utf-8?B?STV4MkdyMXZwcFMzNEMrTm9KSkdZMUtnUzlaQUl6Zk0zN3JMYld0eHpNOGxX?=
 =?utf-8?B?T2lzcHpnNFQ5c0tnbGVSTHdmUmVHWS80MGs4L2VtMW4wZFFSSjA1Y2szK0E0?=
 =?utf-8?B?eHNpYlNVVVI0elBITWhnQzE1dWhzRzJmUWVMdEVzL3JkK2dOK2FLemN1V2hu?=
 =?utf-8?B?cFBFU256QjlWekRQN1U0TWJnT0Fabldodng3aEkyWHhKNTlFRStZa292Yjlj?=
 =?utf-8?B?RkllL1RqKzV5TWFUQTFTaW5KcnVlOHp6Q3h5UStpelhTaFFmRzE3R3Y2cGhv?=
 =?utf-8?B?bkl4dTkrL0Job0N0ajduNkFRa2ZlVVlOSm5xa1BkQ2x2aFZTNXRLai8ycTc5?=
 =?utf-8?B?NXorRktHNU85dHZUbGo1dmNYaXR5cFFjT0lScmtrVVpTTG5EMERQck5hajFD?=
 =?utf-8?B?WTVxUXVTaC9rQS9sMGdHL05GQWVISlhDMmFhOHdIRDhsaVU5UVk5Ujg5SkJu?=
 =?utf-8?B?NytEMDFFQVV5bEJKVENOWkc3emFHM1dmbCtodndKQmxacEp2R0F6ZThpNmpY?=
 =?utf-8?B?YVlGU3JWK0wrOW9CVFhmWU1NK3VpRkp2Mk1TdUlFSkRoR2dGRGs2WTdHMFl1?=
 =?utf-8?B?QUV0Q1VnQVo3MXEvMlVtbXV3QnJJdGZKcFJyNFI4YkIwVTIxam1uSkxNRlZq?=
 =?utf-8?B?TUJKZnVyNit3b203VHd1NEQ5YW9qejVSOVVHWkpEdmZRWWk0bGl5VWwrN2ZT?=
 =?utf-8?Q?WkRD5mQK4b1A6hdCBLbrD0mnA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01a98ba-c472-47fa-52d0-08db68648386
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6191.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:08:31.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLvQeoJMCoREyg/NXtjJs4ZwWHo5Kir1FNBaP9um1Q8lcgrca4ahNDMNp644EKmqhUUy8e0YN2hIoGRTgU5IGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
	Thanks for reviewing.

On 6/7/2023 22:48, Alexey Kardashevskiy wrote:
> 
> 
> On 8/6/23 00:20, Yazen Ghannam wrote:
>> On 5/25/23 4:44 PM, Avadhut Naik wrote:
>>> OSPM can discover the error injection capabilities of the platform by
>>> executing GET_ERROR_TYPE error injection action.[1] The action returns
>>> a DWORD representing a bitmap of platform supported error injections.[2]
>>>
>>> The available_error_type_show() function determines the bits set within
>>> this DWORD and provides a verbose output, from einj_error_type_string
>>> array, through /sys/kernel/debug/apei/einj/available_error_type file.
>>>
>>> The function however, assumes one to one correspondence between an error's
>>> position in the bitmap and its array entry offset. Consequently, some
>>> errors like Vendor Defined Error Type fail this assumption and will
>>> incorrectly be shown as not supported, even if their corresponding bit is
>>> set in the bitmap and they have an entry in the array.
>>>
>>> Navigate around the issue by converting einj_error_type_string into an
>>> array of structures with a predetermined mask for all error types
>>> corresponding to their bit position in the DWORD returned by GET_ERROR_TYPE
>>> action. The same breaks the aforementioned assumption resulting in all
>>> supported error types by a platform being outputted through the above
>>> available_error_type file.
>>>
>>> [1] ACPI specification 6.5, Table 18.25
>>> [2] ACPI specification 6.5, Table 18.30
>>>
>>> Suggested-by: Alexey Kardashevskiy <alexey.kardashevskiy@amd.com>
>>> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
>>> ---
>>>   drivers/acpi/apei/einj.c | 43 ++++++++++++++++++++--------------------
>>>   1 file changed, 22 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>>> index 013eb621dc92..d5f8dc4df7a5 100644
>>> --- a/drivers/acpi/apei/einj.c
>>> +++ b/drivers/acpi/apei/einj.c
>>> @@ -577,25 +577,25 @@ static u64 error_param2;
>>>   static u64 error_param3;
>>>   static u64 error_param4;
>>>   static struct dentry *einj_debug_dir;
>>> -static const char * const einj_error_type_string[] = {
>>> -    "0x00000001\tProcessor Correctable\n",
>>> -    "0x00000002\tProcessor Uncorrectable non-fatal\n",
>>> -    "0x00000004\tProcessor Uncorrectable fatal\n",
>>> -    "0x00000008\tMemory Correctable\n",
>>> -    "0x00000010\tMemory Uncorrectable non-fatal\n",
>>> -    "0x00000020\tMemory Uncorrectable fatal\n",
>>> -    "0x00000040\tPCI Express Correctable\n",
>>> -    "0x00000080\tPCI Express Uncorrectable non-fatal\n",
>>> -    "0x00000100\tPCI Express Uncorrectable fatal\n",
>>> -    "0x00000200\tPlatform Correctable\n",
>>> -    "0x00000400\tPlatform Uncorrectable non-fatal\n",
>>> -    "0x00000800\tPlatform Uncorrectable fatal\n",
>>> -    "0x00001000\tCXL.cache Protocol Correctable\n",
>>> -    "0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>>> -    "0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
>>> -    "0x00008000\tCXL.mem Protocol Correctable\n",
>>> -    "0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",
>>> -    "0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",
>>> +static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>>> +    {0x00000001, "Processor Correctable"},
>>> +    {0x00000002, "Processor Uncorrectable non-fatal"},
>>> +    {0x00000004, "Processor Uncorrectable fatal"},
>>> +    {0x00000008, "Memory Correctable"},
>>> +    {0x00000010, "Memory Uncorrectable non-fatal"},
>>> +    {0x00000020, "Memory Uncorrectable fatal"},
>>> +    {0x00000040, "PCI Express Correctable"},
>>> +    {0x00000080, "PCI Express Uncorrectable non-fatal"},
>>> +    {0x00000100, "PCI Express Uncorrectable fatal"},
>>> +    {0x00000200, "Platform Correctable"},
>>> +    {0x00000400, "Platform Uncorrectable non-fatal"},
>>> +    {0x00000800, "Platform Uncorrectable fatal"},
>>> +    {0x00001000, "CXL.cache Protocol Correctable"},
>>> +    {0x00002000, "CXL.cache Protocol Uncorrectable non-fatal"},
>>> +    {0x00004000, "CXL.cache Protocol Uncorrectable fatal"},
>>> +    {0x00008000, "CXL.mem Protocol Correctable"},
>>> +    {0x00010000, "CXL.mem Protocol Uncorrectable non-fatal"},
>>> +    {0x00020000, "CXL.mem Protocol Uncorrectable fatal"},
>>>   };
>>>
>>
>> I think it'd be easier to read if the masks used the BIT() macro rather
>> than a hex value.
> 
> Makes sense but I'd say because it is easier to match the APCI spec which uses the bit numbers, not easier to read (which is arguable).
> 
	Agreed, will replace the hex values with BIT() macro.

Thanks,
Avadhut Naik
> 
>>
>> Thanks,
>> Yazen
> 

-- 
