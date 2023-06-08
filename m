Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17F472764B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 06:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjFHEpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 00:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjFHEou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:44:50 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F9C26BF;
        Wed,  7 Jun 2023 21:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILr+UeH5zgfk8Kx6Lu/uY69KhMBGmuo7y5Wp7g9vlugqREY6deAeS/sL/FdLAcuEptchwZAAg+cdO0xKl1FA+EbA2YMRVJcYppLxGb32kOf7qJkX7myK5AYtZTz4idQxEuXnU9pUmhnfzII99HhyaPP5b7dVqqR7YGP9BmzjlAyMtqojAYPiJ9JB6Z9YaqmzJ9GXE3v7NE/cAK8snP4j/mxv+0ggJfKYck4F7pXX777m8aKZffzPTYhDdiblJjzs0eER660Ig62v07uEaNYecEnMLIMj/zQwIyPPwqO+ywnpTXkO+i6f7y/XxwWsLnLAP98DVVtuw0wui2cKBdhFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnJ/G+L4mGZesvrGv73xws7dzuzRdN8MyjuPJHzKw/M=;
 b=XBabIO7YyXdREsc+3n3w8gxLt1MPiv9Q/H4VKw4A8xbxQ/xspLFxRzcIdhToxpLwhgrpKNCnpCio2J8YukO0mad36wnQxw3SyoICXk2hi9KakXTAqO0z4fq08Hnt3AqfM7n9DSUl4KSB7mYQKcq+y/MEYd32MK1TkEPGusuWTI2XPFZMEYRfPj5fGQY5E+Wpi/ZqFQP4JATUR6xTsa5NXAMXiypxM5lzKINn9vsPCqQ5FWocTv8IHO4fcw5Ko9EF1wR5Gw5QSzhkD5piELgWb47X6q7zP97McrXV6bohfVAHSa2oPkvq8msguhVVk9BrXnA+UwLxE5ywCfskfFH6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnJ/G+L4mGZesvrGv73xws7dzuzRdN8MyjuPJHzKw/M=;
 b=tZ2mjVh586EtSPXeI15qs8Tc02g9wm8+FTasleHE/4PYF5ksnSBEcnCwPOLzaRMQ4gPgTUg4ZgWEk3ebQAVKsYNk3URq+Galz+/xKy05bKyK5xmYfRRvXhXvPLWItxF634a5QvjO4SeL3d0qYJlu2r/GATgvZbbO+fvwNtLrpbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 04:44:46 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::ff22:cffa:293:5cef]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::ff22:cffa:293:5cef%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 04:44:46 +0000
Message-ID: <7c9c819d-b01c-fb2a-8b8d-67cd7160ab97@amd.com>
Date:   Thu, 8 Jun 2023 14:44:36 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [RFC PATCH v2 3/3] ACPI: APEI: EINJ: Add support for vendor
 defined error types
Content-Language: en-US
To:     Avadhut Naik <Avadhut.Naik@amd.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     avadnaik@amd.com, yazen.ghannam@amd.com,
        alexey.kardashevskiy@amd.com, linux-kernel@vger.kernel.org
References: <20230525204422.4754-1-Avadhut.Naik@amd.com>
 <20230525204422.4754-4-Avadhut.Naik@amd.com>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20230525204422.4754-4-Avadhut.Naik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY3PR01CA0124.ausprd01.prod.outlook.com
 (2603:10c6:0:1a::33) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 2276a48c-e1c0-4e30-a9a8-08db67db157a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwYsdFJNpeL3lCJRwPb02J6oXIANKcmQCy1Bjmg9iJ8L4eQJylRo+bqSmSwPdXnOcojOx0E92wDkPO0rUAQv3lCDHj3tohPRRJkXGrG2d3uPedxoI2CUg/v53GD7QQBjnjeFOu79Rh/3u+5/XLrBtf07rJvtlPzRlVxrKyo90bKcJ43ey36qc2MFOrAmZzopjr1K6JscXjk0c0s/RVrAPDwA4x6JLM/HTT5eJSOBMoS21JZ1Bf90JrGq7ciK8ZS86cYEdrug2R7hT6fc4MuRtwknZFWAOzmQC70YGxQa0p++sLhWp3Cu0lmMX+RP8H0X+osGMNz0AH0Smszv6x9BVp2aTV1PBcOV1rwsQF1H16pv4K2s1NYvEHMNjK5rG5+GirAbZPCFl8KcDxjTVd75a3LHnTU1d+NzfHaXKl3+hQQa7969r69zxtT8kN7y2wr3/NfDJWrAbrDDPgY6NaKcCJXya7haE4sddYgvqTNOA9DA2AabWEueKqxpd6ckvXkujzknAW6WF0M00UL0oPF1dR1oRw2tbhG6jmXp8H9EazvBS8E2y23QnwqALYIzGoo0lpD1ZaxE0NbPfv6dMBa1psJoSdeLE6afAi70r83Q6BCDh3jN07HP3xhWjNAUygOkV3n6VL1BDF8LIl+XZX9/pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(8676002)(8936002)(478600001)(6666004)(5660300002)(41300700001)(6486002)(316002)(26005)(186003)(31686004)(6506007)(66556008)(66946007)(6512007)(53546011)(66476007)(4326008)(2616005)(83380400001)(2906002)(38100700002)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmgyRnJ4OTR3VFkwMlVLbkpKZHRHdENVZ2ZTbVcyM3R3VHU5TjA5bHVJYWxS?=
 =?utf-8?B?TTFwK1NKTk5ZbVpqOURTTkNyK0NsUmJWblpJN2R4WjNxV2FGdUtDbWJZL0FL?=
 =?utf-8?B?a3djcnIvRTdPa0lkeEgrOTlnVEp6cEJrR0xqYkE1bjBWS25OVjN4TmFZU28x?=
 =?utf-8?B?Y3FwUEJ6VUhGc2pRbmZOeVVVZmFhWjBQKzNjOE9lakJBWjhwL014UEVEdmNV?=
 =?utf-8?B?Nk9hd3VjMXVwNzNZRmROS2tJVnBlYldsWEk5U0FQTG9kY3hWejJVdUwxNEli?=
 =?utf-8?B?ZjJxWVNRSHhxb3kxSVZTQjVyNmZyMHAxWWdROG1yUjE1cDN1cytuc2lVeDBV?=
 =?utf-8?B?MStOdEd2Y2hTcWVvYTlGYmNTcUVVWXVzVHVOYzVCM3N3N2Zmb0xra0dxOElS?=
 =?utf-8?B?N2k1YjFCSW45S2JYVEhLZ3JhOUZBYVpaZUlyWnRzRG1hSU10alI0MFdIcmFK?=
 =?utf-8?B?UkdRekxZcmV1c0pCaE1pcU5ERS9QWjdEamE4bVRJM0tvLzNlMG9xUHFRSGgv?=
 =?utf-8?B?RWkwTUtkdGt1R1NMTCs3dzI1b3htT2RXY080T2FJd0hVZC8xaEpJaHFxVjh5?=
 =?utf-8?B?NS9rR0hyWVV0UjY4YklxbWRmYjB0a3ErcW82dkJPa0pwZzd0dVFDSjMrRXg0?=
 =?utf-8?B?V0FyNytJMnVMWHNQRitRTkRSYlBBOVJNcTVXaUF0ckI1dXIrOWFKd0NyR04v?=
 =?utf-8?B?RUZIUXZ1UG1GL2VYYUEreDdNV21nbkpzRDgvZEVQcyt1REk1eS9sT2ErTmx4?=
 =?utf-8?B?aElycHhZQnRHWVdqRVlwZFk2MlBHaGo4WG9JMTRZUHVoMnB2SnB0RW9JZmNk?=
 =?utf-8?B?VkhKQmFFV2tIcTVlN1Z3TzhXK01HWGd3eVF0K3RjeUh5eFFvZE84MUxuS3FT?=
 =?utf-8?B?V1diQU5pME1hd3lKVDBHWm4va0Y2MW1UN2s2UDFUYlVkYTlVbC9EelJqZ2hJ?=
 =?utf-8?B?ZHFwLzNRQVI0ZE1sWnk3MXFnZGhIVUYvRklLUXdRYXd2cFg4Tll0ZVNvRllw?=
 =?utf-8?B?OWpvaHpqbGlja3RtNUYrRUhoRzY0ZGRNY01kNnZYWXFISnFHd0lTbVNQLzJ2?=
 =?utf-8?B?aVc1NEM1ZTYxV1ZJdUtrVGRsaE9UL1QvRU1HaGh6bEsrNkZnaUFtS0NEeExs?=
 =?utf-8?B?YjRRL1BBN0d1LzMzb3RqU3VKU1I5dUJGOHlscWlFRytmOW8rWmRtZHRJWXV5?=
 =?utf-8?B?M0FpdVRvZXoyR0JkeFFITnNWNWdnMENCdkJSdkt1S1pxR0ptY3MzQ3JEZXpS?=
 =?utf-8?B?WjBCZWtzRG93ZG00MERsSjREU2N6b20zZ2FFV281WEVQOXg2K3g2QnhhR3oy?=
 =?utf-8?B?WTB6UUFaTHBOLzJTTllEVzNuK3VMdis4Q0V2RHpFaXRTNldUSCtVQWU2UUR1?=
 =?utf-8?B?V2hway9YeFM4UUd6eFVPZXJ6RkF2MjJkWTFtNFp1bkVPY3o4dkRoaFNsTUti?=
 =?utf-8?B?Z0RybWlBTVd0U1pGdHYvYVE1S2Z0ekFEYnZTY3gyMmMxcWxBTkdxSU9hUldl?=
 =?utf-8?B?ZERtVWFoTzl0dTdwMnVXVlpkMGRlanVJQ3gwSW9jbmRsakxZZ0ZWQy9PdmVh?=
 =?utf-8?B?WDdyNjR2QnhpZDVqQmdRdk9NY0djZWpiN2dUcmpZOXdzcHVYZFU2a2JzOHh5?=
 =?utf-8?B?R1MvMTY1ZFo0WXhPb3VNei94NmYzcXZySDFhaTEwLy9iY1Mwc2xubEdZOUtV?=
 =?utf-8?B?TTh3aTJZbnR5YWlZRjA3L0l6OC9QcS8vT25vR3hTdWdBZnlNN0kza2krZkpz?=
 =?utf-8?B?SFA0by9xL1EyeWtnbXhyOUpLMGNiaVJIOU9jVVFiYmNVVE1KVkpOZHMrUThV?=
 =?utf-8?B?Yy9JRXNSTThqRTFScmhINU1KdDY2SDJIalM3U1BwT1ZuakNPUWpyQ1R1MTJQ?=
 =?utf-8?B?bTdMc3lnam5ibTFsOTVUemtKU04wOGNxaVJ4anVKKzM4YkJvZHIxNmxsOTJF?=
 =?utf-8?B?OGRYNWtHbU95VFJQRSsxc01uVjd5SFA0Q2ltV1VBblRGRVVOQVBiYlZFamdp?=
 =?utf-8?B?cS9zYXBzcXFiL3dBcExuY1IyNmJjQWpJVDZjeXhEdUFXKy9xejhaODI3WHdq?=
 =?utf-8?B?Q0lSbWtHSFdxWlhlMHVOUWtiZWZMajVHZ0V0TWFTVVNCTEJFRVY3VWkyTWVQ?=
 =?utf-8?Q?7klEAQ8zb9j254QZBpazhflHJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2276a48c-e1c0-4e30-a9a8-08db67db157a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 04:44:46.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUbri2KmTOheghoC5F3zA60U9zQngurctrIFZ6gp9WIB36RChP3iygm8dwgIZY/1OjdFqOTJ8iU0QgRe6aLIGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 26/5/23 06:44, Avadhut Naik wrote:
> Vendor-Defined Error types are supported by the platform apart from
> standard error types if bit 31 is set in the output of GET_ERROR_TYPE
> Error Injection Action.[1] While the errors themselves and the length
> of their associated "OEM Defined data structure" might vary between
> vendors, the physical address of this structure can be computed through
> vendor_extension and length fields of "SET_ERROR_TYPE_WITH_ADDRESS" and
> "Vendor Error Type Extension" Structures respectively.[2][3]
> 
> Currently, however, the einj module only computes the physical address of
> Vendor Error Type Extension Structure. Neither does it compute the physical
> address of OEM Defined structure nor does it establish the memory mapping
> required for injecting Vendor-defined errors. Consequently, userspace
> tools have to establish the very mapping through /dev/mem, nopat kernel
> parameter and system calls like mmap/munmap initially before injecting
> Vendor-defined errors.
> 
> Circumvent the issue by computing the physical address of OEM Defined data
> structure and establishing the required mapping with the structure. Create
> a new file "oem_error", if the system supports Vendor-defined errors, to
> export this mapping, through debugfs_create_blob(). Userspace tools can
> then populate their respective OEM Defined structure instances and just
> write to the file as part of injecting Vendor-defined Errors.
> 
> [1] ACPI specification 6.5, section 18.6.4
> [2] ACPI specification 6.5, Table 18.31
> [3] ACPI specification 6.5, Table 18.32
> 
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
> ---
>   drivers/acpi/apei/einj.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index d5f8dc4df7a5..9f23b6955cf0 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -73,6 +73,7 @@ static u32 notrigger;
>   
>   static u32 vendor_flags;
>   static struct debugfs_blob_wrapper vendor_blob;
> +static struct debugfs_blob_wrapper vendor_errors;
>   static char vendor_dev[64];
>   
>   /*
> @@ -182,6 +183,16 @@ static int einj_timedout(u64 *t)
>   	return 0;
>   }
>   
> +static void get_oem_vendor_struct(u64 paddr, int offset,
> +				  struct vendor_error_type_extension *v)
> +{
> +	u64 target_pa = paddr + offset + sizeof(struct vendor_error_type_extension);
> +
> +	vendor_errors.size = v->length - sizeof(struct vendor_error_type_extension);
> +	if (vendor_errors.size)
> +		vendor_errors.data = acpi_os_map_iomem(target_pa, vendor_errors.size);


acpi_os_map_iomem() can return NULL but you check for the size (see 
below comments).

> +}
> +
>   static void check_vendor_extension(u64 paddr,
>   				   struct set_error_type_with_address *v5param)
>   {
> @@ -194,6 +205,7 @@ static void check_vendor_extension(u64 paddr,
>   	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
>   	if (!v)
>   		return;
> +	get_oem_vendor_struct(paddr, offset, v);
>   	sbdf = v->pcie_sbdf;
>   	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
>   		sbdf >> 24, (sbdf >> 16) & 0xff,
> @@ -596,6 +608,7 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>   	{0x00008000, "CXL.mem Protocol Correctable"},
>   	{0x00010000, "CXL.mem Protocol Uncorrectable non-fatal"},
>   	{0x00020000, "CXL.mem Protocol Uncorrectable fatal"},
> +	{0x80000000, "Vendor Defined Error Types"},
>   };
>   
>   static int available_error_type_show(struct seq_file *m, void *v)
> @@ -768,6 +781,10 @@ static int __init einj_init(void)
>   				   einj_debug_dir, &vendor_flags);
>   	}
>   
> +	if (vendor_errors.size)
> +		debugfs_create_blob("oem_error", 0200, einj_debug_dir,
> +				    &vendor_errors);

Here writing to "oem_error" will crash.


> +
>   	pr_info("Error INJection is initialized.\n");
>   
>   	return 0;
> @@ -793,6 +810,8 @@ static void __exit einj_exit(void)
>   			sizeof(struct einj_parameter);
>   
>   		acpi_os_unmap_iomem(einj_param, size);
> +		if (vendor_errors.size)
> +			acpi_os_unmap_iomem(vendor_errors.data, vendor_errors.size);

And here is will produce an error message I suppose.

Just change get_oem_vendor_struct() to store the size in a local 
variable and only copy it to vendor_errors.size if vendor_errors.data!=NULL.

With that bit fixed,

Reviewed-by: Alexey Kardashevskiy <aik@amd.com>



>   	}
>   	einj_exec_ctx_init(&ctx);
>   	apei_exec_post_unmap_gars(&ctx);

-- 
Alexey
