Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F38728A1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbjFHVTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 17:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbjFHVS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:18:59 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5632D52;
        Thu,  8 Jun 2023 14:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYxsS0k88DLc1DAgNWBXWMMToAClMSj0+82rjKvDgiGHjFNAMCQvfRtM9RljwpIpEPkZ9WLJUagoQry57mTUDcdkpfuVvLfh9etGENdHYov5FsTXxS/nYcwvVsQ4PMVxh+hCeTjwHSVRhD7VnImN0eid+ne/Pz5AC1cT8BvexiMF43+HrcoVM+BnInJVQfLUP03JOp4mKIadIJm1MnD9All5Ct2qiDdYcNDcRBoR6lVDDBVbo4ciksoOc2Vohkv2XSMviZ120Uoh6lCeCAI4VuHTXMzTd8qXsFYEE6RXQjXa0HNRCtJkWrxMtGKJjHMpLfZQUK9bexMT+mC6cKZYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tydib7dr9i00l6Y2HlXKDmfp/m8Jpa3M+wsQfjnv2kY=;
 b=XJPfSS5IuBPe4Gy/6PJwv4JliPjbY+SItTozNBcvahjmMEw60Gz7iIU9y+8dWRgwvhhau+o8SeWl8pl88Htm3EOgqxjZ8AE6UJ86AA/DULWms73oj8koTMNee0w7TrPww4gBfzXp6cgC2NkB3213wynWc/BclrZAVEvLviI/QNoZelElXXiNdzvC8crCMd3aV+qmWlaCHzgZcNFJO1eg5nxbTfP40oMMZxzUQTixaU+HDK4fWGq768xe/lAPkRk1QgWuGfz46ZMA5kYLL/QxagcbQoAG6gAgLFx8ULV8aaUdVKI16p5b2532iMC6A6TVu7w9I5mGa/cvhnKvTxPWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tydib7dr9i00l6Y2HlXKDmfp/m8Jpa3M+wsQfjnv2kY=;
 b=32PCsvZnTDc3H2LHmFNdpgimxgozN6A2WwRClWyDZf/Y1i+0U93Bo+m+DyMnvZblvZ1X0brbeFLM0X1/ho/As146ubaGNGfbBnv6UJdtyt/DKPjY9ecPz0FRtJwwhalnvMbCSvNpGvbLd/dfTa6bPc+geUV/Lclh0AZoYeb2Sdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) by
 DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.19; Thu, 8 Jun 2023 21:18:53 +0000
Received: from DS7PR12MB6191.namprd12.prod.outlook.com
 ([fe80::3bec:25bc:7b64:d03]) by DS7PR12MB6191.namprd12.prod.outlook.com
 ([fe80::3bec:25bc:7b64:d03%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 21:18:53 +0000
Message-ID: <0e397c7d-9298-b027-4391-a221c9f128d7@amd.com>
Date:   Thu, 8 Jun 2023 16:18:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [RFC PATCH v2 3/3] ACPI: APEI: EINJ: Add support for vendor defined
 error types
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@amd.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     yazen.ghannam@amd.com, alexey.kardashevskiy@amd.com,
        linux-kernel@vger.kernel.org, Avadhut Naik <Avadhut.Naik@amd.com>
References: <20230525204422.4754-1-Avadhut.Naik@amd.com>
 <20230525204422.4754-4-Avadhut.Naik@amd.com>
 <7c9c819d-b01c-fb2a-8b8d-67cd7160ab97@amd.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <7c9c819d-b01c-fb2a-8b8d-67cd7160ab97@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::13) To DS7PR12MB6191.namprd12.prod.outlook.com
 (2603:10b6:8:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6191:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 2480455f-30fb-4f19-6610-08db6865f5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCy7gNsjdEnI8eg+SzcYRJYM1b3grc5IVFkm4zbpxJ+yC6t8XAnHHkPkLyFG0bB6ONHwzeLZqKikwb3NOrnW1aSR86EOE2dC4nfVJfB3RwfYLLwYoEIQeSzCz1Zch4GKyNuGolIYdKxKq1SaRS3haTCZ06YpSrqAQX/j/nnVLHxjsRhB7bHNes15+25TmYm/yXCtMc0AFxSa4NAE6KxUALQQ8h+hdmo6Idfx1O0SMcnLwIY8sdd9YKH3gq4Vo23s8W/9/dPmjt4+EVDYlv45HHHj4wQ/77FOhucgjaumMM8zhJHvzsncS9SNnBIEW6n77/G/gqOl14yxnwxiFYC8/Tabkn6ExcCVIgwjRlEdBFMDXmQh/C550MPB6Ldbmo3DOwnt0UaHOdWu6rdw6kAaXCYcM+RBHQ90NjAIbupO05y+uPh5qz7YCo8XMQdEJLfFms/fmQyuDy12yVLn7GYnQJOtnxrfbOLxa0/7676vNKXoSX3gzYLgD7/SS6Rq5cu/yl9F4N3C1bPvofw/lbQShTR+d+qSvUgPRELF8Suz7fWTpkiv8SWhL83ZeAdFCLjOszKhI4CZFh8a876YBnUc2KWUcv2xzPpn89FpTKIK5QcDlXYW5pOECt2PNBqmZqg/rEwOphMgJ/B7VpKnN4ycXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6191.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199021)(6486002)(36756003)(66946007)(66476007)(2906002)(5660300002)(4326008)(66556008)(38100700002)(41300700001)(8936002)(316002)(8676002)(31696002)(478600001)(186003)(31686004)(83380400001)(2616005)(53546011)(6506007)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzRPNTVQREY5SmVmd3hPWm5GY3FTV3NrZS9rdGhmbjdMWnRKY0tWdEc1RUZ2?=
 =?utf-8?B?eFErR0NYNGpDazJQY2RVY29FZVhDejA3bVlvRVNTdUJKcThiODUrVUs2NnpK?=
 =?utf-8?B?d3krRjVXNjlxRjZidENrLzZTcDZpN0dPcERIOUtMbmljdlMvejlzUTd1N1pE?=
 =?utf-8?B?US9meVZoZjdBQnR6VTNrTGZsR25EV2dBQTNFZGpxMjJQdE54UHNpVHkvSUls?=
 =?utf-8?B?Rm9hbGtGTTBhUnJDMU82Tk1NZ1lTVG9qZjhwbC9SRkx1M21uS2JLTUVULyt2?=
 =?utf-8?B?MUhTZHRWT1BXMDl6OTIwRmRmQUZiY3pFSlpyZUVHNzluemRPNXRKaFVzc2NH?=
 =?utf-8?B?VGtOYUlkZkh1TmYwZWFuVGxpNk9zU3ZVOUh2YnFtMGF0Mk1pYVI4cVFUbTBo?=
 =?utf-8?B?TjZjV2RBaXRPRjZCNEhlWmQyY2FoUjBNYll5TCtaTnpaMnB6NDRFWHIrbHor?=
 =?utf-8?B?eGV0eG1rdTlNS1VCRTVlUWwyOHNIN3cyQ0F0b283bEdhQzV5LzhhSC9XTFFr?=
 =?utf-8?B?TERqd0ZZaGFmMjZabHlTZ2F6T003TWZPbkRPMEZkOXhQNGdhLzZid05vY3Yy?=
 =?utf-8?B?YUlUdlFnSFc5Zi9YWXR3MXlaL3dyaVVQSk5vVFUwN1J3NTlpRVh0TmxZd0FY?=
 =?utf-8?B?MmpyaENoYmRnMk5vZEY1QVI2dCtmSGUvZkpZc2E5SWhIdUszYUZTbzBPYmVC?=
 =?utf-8?B?dW5Lc1B3UUZ3Y1lHS3hNa0lEdUx5WG0zL2JSWmdsclY5ZHdLM29Udi9vd1cr?=
 =?utf-8?B?cHM4cFU5L29UTnpOWU9Vc1B6Yk1rdHQ1clZTcFViTFRJUjJORmYxVHFZbmk2?=
 =?utf-8?B?OWtPaTd4d2VGVWw1ajZMVnJKU3NEMWJtZDM4VEcrQzYxQXdPSEZ0ZFpmcE9U?=
 =?utf-8?B?ckJGb3pPaG9JN2RqZnA5ek5SSEFSNWVMRk9IaCtEZThtTFZjYUZpRC9DZzd5?=
 =?utf-8?B?R0FER0xyT25YZEdOaS8reCttekFET2xNTDhZa053R3BpVVIybUVSQnQzNkk1?=
 =?utf-8?B?bGZWQjI0eFhKQmdMV0xUdkppYkJvdEFhSXB0aGJ5UXdSTVArNHRYS2xTenhD?=
 =?utf-8?B?ZmVZT1J2SldQeFl4RnRSUDBXYTFFMmV2SFJwaEYvTWt2ZXRaNkxMTXg2YmY3?=
 =?utf-8?B?d09QcExPaFhGZG1pRGVuSFBTLy93eVE0RlBDeUMrTG0zQ1JnNmQzM0p2ZWFx?=
 =?utf-8?B?NWFIcUNCbzBYbGdqVU9URkpKejVvc1cvOFFpUm9oMUMzQ2Z3WU5vZ2hkUVhC?=
 =?utf-8?B?ZGcwMlhCWURoK00rVnlNKzVoRmlORS9Pa05jUjh6TjhrbSswTjlnWlJna3gy?=
 =?utf-8?B?K25jYi9tdkN5S3ZGazBIMTVmNmhSNS9BSk1aVDY1elhWdU1uK1Q5a2xpOVI1?=
 =?utf-8?B?Yit0SlF0Y2JXclp4cjJOcEpaQVM5djFkMkRhZ2tUMGJmeUM4cE91UDZGLzFl?=
 =?utf-8?B?cUhSeFphRmJtYlJQVnYvQ1B1T0NpL25FOVY1UVV6VmM3MGVGOU1TY1ZZRFBE?=
 =?utf-8?B?NGpaSmYzZjlzelIyS0RoR0RqQzlSZEM2RGZFTjBVRU5yM2ZXYlZ0WUZBa00v?=
 =?utf-8?B?c0tlclpXRURhZ3VvUzRWbS93QlJFN1RYZlA0aFBXVE90cWpKTmNQK2RVbFRN?=
 =?utf-8?B?R0hXOGhQNm5kZ1NKT2lnNlN2VGczSzd0dzhxZnBUbTVWTjU1MGZLL0VSR1BN?=
 =?utf-8?B?bFZlbWpJelRYbnZpbzJ2dStaTWpFQU1LL2RWd0RJbEU4a2hSTk1Xa2Y5ajV4?=
 =?utf-8?B?WnNjYmdrVnU3WEhEb1JVNGJ5TzZTVVdKOFJVUjNETE5xUVRiVmkvWk94dmd5?=
 =?utf-8?B?dnhDdm5CTy8xVitDSGJ5aTFHbTBoVGZ6L3Z0b2l6T0FSL2U2T2NVMWlzSG1C?=
 =?utf-8?B?L1FvRkdLdWJkd1QramQyNUlYZytheTlYNUFCcFQxaEZXMTZ2RkhNNWtLM0tL?=
 =?utf-8?B?ajVNc0ovRzRuSU5tL2d1REo0c2hJWG1xWEZ6d1hIeDZBRlFSN3U0czdTdFV0?=
 =?utf-8?B?cnBTaktiWnlkTml0RUl0VFFHY2FiNXhEVkpLeFh1akVlcXBRVFhCWTB6Ky9a?=
 =?utf-8?B?TE4zUis4UFVFM0ZOcnRSMTFxV0Z6a0l3aWtaSkZlbnVOSUY2UUlhaitJOU43?=
 =?utf-8?Q?5Anmgu0FP/u3sM+7e7WroK+5g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2480455f-30fb-4f19-6610-08db6865f5fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6191.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:18:53.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfcBMYDn4NAEF/hPc3hrtJdftLsk/gamkOsikbY54hPytVgw0JNk9LeunOtuCY/J2q/7Btr2ShypeRZakbKK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
	Thanks for reviewing!

On 6/7/2023 23:44, Alexey Kardashevskiy wrote:
> 
> 
> On 26/5/23 06:44, Avadhut Naik wrote:
>> Vendor-Defined Error types are supported by the platform apart from
>> standard error types if bit 31 is set in the output of GET_ERROR_TYPE
>> Error Injection Action.[1] While the errors themselves and the length
>> of their associated "OEM Defined data structure" might vary between
>> vendors, the physical address of this structure can be computed through
>> vendor_extension and length fields of "SET_ERROR_TYPE_WITH_ADDRESS" and
>> "Vendor Error Type Extension" Structures respectively.[2][3]
>>
>> Currently, however, the einj module only computes the physical address of
>> Vendor Error Type Extension Structure. Neither does it compute the physical
>> address of OEM Defined structure nor does it establish the memory mapping
>> required for injecting Vendor-defined errors. Consequently, userspace
>> tools have to establish the very mapping through /dev/mem, nopat kernel
>> parameter and system calls like mmap/munmap initially before injecting
>> Vendor-defined errors.
>>
>> Circumvent the issue by computing the physical address of OEM Defined data
>> structure and establishing the required mapping with the structure. Create
>> a new file "oem_error", if the system supports Vendor-defined errors, to
>> export this mapping, through debugfs_create_blob(). Userspace tools can
>> then populate their respective OEM Defined structure instances and just
>> write to the file as part of injecting Vendor-defined Errors.
>>
>> [1] ACPI specification 6.5, section 18.6.4
>> [2] ACPI specification 6.5, Table 18.31
>> [3] ACPI specification 6.5, Table 18.32
>>
>> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
>> ---
>>   drivers/acpi/apei/einj.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index d5f8dc4df7a5..9f23b6955cf0 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -73,6 +73,7 @@ static u32 notrigger;
>>     static u32 vendor_flags;
>>   static struct debugfs_blob_wrapper vendor_blob;
>> +static struct debugfs_blob_wrapper vendor_errors;
>>   static char vendor_dev[64];
>>     /*
>> @@ -182,6 +183,16 @@ static int einj_timedout(u64 *t)
>>       return 0;
>>   }
>>   +static void get_oem_vendor_struct(u64 paddr, int offset,
>> +                  struct vendor_error_type_extension *v)
>> +{
>> +    u64 target_pa = paddr + offset + sizeof(struct vendor_error_type_extension);
>> +
>> +    vendor_errors.size = v->length - sizeof(struct vendor_error_type_extension);
>> +    if (vendor_errors.size)
>> +        vendor_errors.data = acpi_os_map_iomem(target_pa, vendor_errors.size);
> 
> 
> acpi_os_map_iomem() can return NULL but you check for the size (see below comments).
> 
>> +}
>> +
>>   static void check_vendor_extension(u64 paddr,
>>                      struct set_error_type_with_address *v5param)
>>   {
>> @@ -194,6 +205,7 @@ static void check_vendor_extension(u64 paddr,
>>       v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
>>       if (!v)
>>           return;
>> +    get_oem_vendor_struct(paddr, offset, v);
>>       sbdf = v->pcie_sbdf;
>>       sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
>>           sbdf >> 24, (sbdf >> 16) & 0xff,
>> @@ -596,6 +608,7 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>>       {0x00008000, "CXL.mem Protocol Correctable"},
>>       {0x00010000, "CXL.mem Protocol Uncorrectable non-fatal"},
>>       {0x00020000, "CXL.mem Protocol Uncorrectable fatal"},
>> +    {0x80000000, "Vendor Defined Error Types"},
>>   };
>>     static int available_error_type_show(struct seq_file *m, void *v)
>> @@ -768,6 +781,10 @@ static int __init einj_init(void)
>>                      einj_debug_dir, &vendor_flags);
>>       }
>>   +    if (vendor_errors.size)
>> +        debugfs_create_blob("oem_error", 0200, einj_debug_dir,
>> +                    &vendor_errors);
> 
> Here writing to "oem_error" will crash.
> 
> 
>> +
>>       pr_info("Error INJection is initialized.\n");
>>         return 0;
>> @@ -793,6 +810,8 @@ static void __exit einj_exit(void)
>>               sizeof(struct einj_parameter);
>>             acpi_os_unmap_iomem(einj_param, size);
>> +        if (vendor_errors.size)
>> +            acpi_os_unmap_iomem(vendor_errors.data, vendor_errors.size);
> 
> And here is will produce an error message I suppose.
> 
> Just change get_oem_vendor_struct() to store the size in a local variable and only copy it to vendor_errors.size if vendor_errors.data!=NULL.
> 
> With that bit fixed,
> 
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> 
	Agreed. Will change the function to something like below:

static void get_oem_vendor_struct(u64 paddr, int offset,
                  struct vendor_error_type_extension *v)
{
    unsigned long vendor_size;  
    u64 target_pa = paddr + offset + sizeof(struct vendor_error_type_extension);

    vendor_size = v->length - sizeof(struct vendor_error_type_extension);

    if (vendor_size)
        vendor_errors.data = acpi_os_map_iomem(target_pa, vendor_size);

    if (vendor_errors.data)
        vendor_errors.size = vendor_size;
}

Thanks,
Avadhut Naik
> 
> 
>>       }
>>       einj_exec_ctx_init(&ctx);
>>       apei_exec_post_unmap_gars(&ctx);
> 

-- 
