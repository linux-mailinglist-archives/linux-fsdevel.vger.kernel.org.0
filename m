Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCED7786EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 07:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjHKFTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 01:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHKFTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:19:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195489B;
        Thu, 10 Aug 2023 22:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6lXihFYPmHvFXP2qz1xNF21l41NXMsrympHG5gQdRIh9bvZtEsNAF1egYLWpvu7X5ULpdjLm/9tbXUT5jqzFXD0x/Km4G9QtoxX+wH5Ephh73rZekzdDTibLnBLwtqat4aFaMldECizhK9AUCGSLZylWd4eMvudH6Gz5FGJ/mOcMRkcOVXowiTF/wjWZxFQDli+1vwzz7qOaMX47/Pn81JJOQ8iHKj57eDoG+5VvHBrM/tAhsF9Z0lJqzbY7IULAphZ48cJ7jPZA9V+fDXgtumxQ35CMJC5hDmCHiat6SEqITjapfBCcsLNKHB2IEW7FjBAHymMv0hyPOqd2o/uXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2A2o94KoNcKWWYuyD7loor70IR3GeaRhwieI+kslDw=;
 b=UPiIz5LPAEETwquPeIHa4tt32RZCmf3v13UFe0R7GlJjSd/ElKrQvd+RU7IVhBunhO3hEg+c93VQ/m9ZjZcH8wbPTKkDrqnWoacXqz2MsMl9CUspILPICByHsoAYW4aa6Uk4EgbAOBUG8UFQsdcSC11DF+xBYGg4BKvNs79i06g3wtkQ2cdJRRiD64j/KzBqsU0LwtyrmoKA15eFP4X8VTHzBJJ4XJpyZBj6lNdR5MwoKJl6Hl9rabxjn+1BS4t1KYEsb0bkYebkY12XmH2baUL9w7tkMKbT9IQMsjL1+yfcYBvlMSfvr9bc7++yZ+EsI84R2+LRDJqryXFXl7wjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2A2o94KoNcKWWYuyD7loor70IR3GeaRhwieI+kslDw=;
 b=GtKAxStUdPAgO661Cgd7NXarJuuhsLizmnqI9mG7zPl8rL9y4JdHzKsNP1ZtSpQ3NexjAdS3anNYxW28nBg1vtD2U97Tl1LBAXpD7uU1PeIE8oJ9rC6a/sX6GfBgq1MjiRn0cTYP8KFqihxHi6ls+rwQI+Ad2pRfiQQTAliSxD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 05:19:02 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582%7]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 05:19:02 +0000
Message-ID: <64391bea-aac3-3046-2a69-8b0791ad734f@amd.com>
Date:   Fri, 11 Aug 2023 00:18:59 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 0/4] Add support for Vendor Defined Error Types in Einj
 Module
Content-Language: en-US
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc:     yazen.ghannam@amd.com, alexey.kardashevskiy@amd.com,
        linux-kernel@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org
References: <20230621035102.13463-1-avadhut.naik@amd.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20230621035102.13463-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::8) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffc6d33-fc19-4f5f-fdd1-08db9a2a796c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +a+XuAzw2B67S24QME+BijTaC3HKb1iFM/bspe1A4UkQQe1mT/j4PkmGLODDgp+BDJTDrDV0xCbOcnCw28eJ060qH5HCXJBaCySmOSrxm3WqWy5YeG2GFhbzTtYM7kXwPm5I+7of9OkX9JjslW4iPWG78F/sqH7za7TdFZ3+LIFXifZ+6y0weXKAb1UTyYqfu+NzUSREWbkz4fRRv7liWtuvKj6rd+aGo07yNo2k62YOGg1h+R45L302KdZQ0C/Ih1DTsLKjYrYNJ7ZYRLM+T/ND4NOTcELKEO92Sms9uQN0zJ/nk2u6SqPE4WQE0vBn4Ef5GxnkutfncUijgoRWD6GJmajqKbYt8Y5G+/iOoM+Vp0yek7uBs9BLGGe2IwrD+DobyDB6E2tqmNEK+WtyQgJLkyV8wjNQcp4dF0BWapRvTZ70P8UtcYgiNaMOhez9Php/hfjJPOxYV8rCf6i2SxGBDGg5l9LcLEuDj6M1qPUj/yICSuJ7LO3OJoYiEHSkCTXs22TaI/sqnwV57+UtXqvXzx4aaFRlrqzUl5XMgV7p+UrPIfVVuwzLQluAFak0izxPfNKSYjN8qBa4hVL6LjSHbXg+ja7Tgr4Dh3hVrA/d/EUaouqdsat7pVC20ea3fBmRNxuSAYauJrgkg0wc3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(1800799006)(186006)(31686004)(53546011)(6486002)(6506007)(26005)(66476007)(6666004)(478600001)(66556008)(66946007)(36756003)(83380400001)(2616005)(41300700001)(316002)(4326008)(6512007)(2906002)(31696002)(38100700002)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JhWnEya2hhYW9QeGk1QXhSR1Q3anVFQWhDZGNYOWtUVUFTeTFkSVRnQzZl?=
 =?utf-8?B?SlRDUmM4dWJIRG5IRkVvNzgxb0Q3VzF4bVZocTM5akFiR3luaExkaXpLYWdM?=
 =?utf-8?B?SXlFekFkUmVLdlhYQ09qV3hQL1lydTI4d0ZYRFk2TVMzU1N3R0ZORGFMNmRr?=
 =?utf-8?B?OEN6SjF1SWR5ZXRiOFNhaytYcnpab1ZWVTM0Z1hBUHRPUjVoY21kNkEwd1FM?=
 =?utf-8?B?RkFCbkJuem1UYTJjeFlhZFhTcE94OHMwOEdUWm52WWhtc0U4aURpb29DK0F6?=
 =?utf-8?B?aXQ0RWJyNnNCaDNNRFlHb1RMd3lyZWxRZkhzcmY3VmdVdGhoUnFNU2lhbCtV?=
 =?utf-8?B?WjYrSEV3eW80UE91SmVUU0NVdVZNbGd4VkN6R2NCV1YrcUZOQmlTZGxKY21i?=
 =?utf-8?B?dUhGeWVaUmRSSWZOYTZLbDcyUWs1NHd1SCtmcnJEM0hBYUROY2JBSFYycE01?=
 =?utf-8?B?TS9oSmpZV2xDclFZQWEzNG5OZ3NvWWE4c01CZCsyV2NuWGdaV0dwQXM1UGFu?=
 =?utf-8?B?eHY0WVl2RFZZM2x0Z092bnNrazFkT1pnY0xnaW1sK2ZROGM0S3luRzBXbnI2?=
 =?utf-8?B?QUVqWFFnWWVCOHhXYTgyQjR5M29HN0xQZzY2OFJGZFFyUFAwNkkzWmZJVno2?=
 =?utf-8?B?YjJKL1Y1enBzc3lPQXdBd3BoUkpLTUxJZmVIUlQxdnp6TExhRXhxcWxaNDMz?=
 =?utf-8?B?M1BoT2lSS2U4eWYzUjVTQndHUlJtWE5qdmZVMytSNHFSOVhyeGQ4WWkyQXh1?=
 =?utf-8?B?ZXl1MUtwL2J4OE5CaWd1MVBxaVVUaHNMd2t0ZTRTaEZ2VUpXdER5OWgvS252?=
 =?utf-8?B?QWxHWE10azVLbDBibUh2SWpvRzZTWkk2YUV1QWZnSHp2cTZyRGZoMnVhekVw?=
 =?utf-8?B?VjVoMEs1VVljVGF6NUpvQnNyaEVkbGFNU25wWDFoQkZYaUo4ZmJOZjNBeHZH?=
 =?utf-8?B?dWZxaXpmNVk4SDUyNU8zRWR4d1ZSWUtjZzBnZkhiVEs2cVJSR2JJODFpTzBB?=
 =?utf-8?B?NDNpSzdBQ3p1MjE4MUFhOE9wSXlZbVdpSlFhVEg1NjRncE8zeG5zdDRXSC9h?=
 =?utf-8?B?SzZKdXd1WU9sV3dZcTN4aUFjdXA0aFVZN0dZbUc4akl3VWFkVnB0dHNHbWdl?=
 =?utf-8?B?SURsM1VQYzJBVGVndVNMSW9CcUx0TWNiN1VoUSs0WHN5SUhqZWRsWER2VjVp?=
 =?utf-8?B?NnRtdXJSS1lnS2g4c1JKdUgvY1VjbWdkZnE3TVFBYWFRcTdkZmY2WG9kaFZS?=
 =?utf-8?B?bTBxeTBFWjVFdDhmek53UUdCTW9lb2NmamFwTUR3SmxjQk9KNjIveE5IbVhU?=
 =?utf-8?B?Q3RjajBhazNBVmxqMVN6ZGRvcDlsZ2Q4MjJmbXJGd1VTcFlhdUdadGNKZEVa?=
 =?utf-8?B?ZGR3TzhoQ2JXL3NaZi9LNE5PS0hDVjFYQ1ZtcDdwVFp3TW9mY2haODBVS2JP?=
 =?utf-8?B?UW5DbWdmWTVkZjJ2V1RWZnhOSHZ3MlYxc0M3UDhFUWVDTFBiUlVzZy92N3VR?=
 =?utf-8?B?MitScGhLYktLNDZPMDIvMkNQMjJJbFNUTmJ5UGtyZTAyalhUSFIxdEV4d0tq?=
 =?utf-8?B?OGcveFMyaUhldzFGRDZKOTdlcGJ2Tm9HQ3ZDakM3cDRMU09yUWE4UlRaWWZl?=
 =?utf-8?B?eWlsYU5wekpaMDBiVmFmbDlseVErREVSY0VaVWs1RUI5NkhiNzlETC8wc2pF?=
 =?utf-8?B?V2YvRmZLMzcwTUhjUUJyeUJMWkxRTkU0ZlBmZmg1WUtwbzdDNGVKQXdDVHRC?=
 =?utf-8?B?Yit6aDlVVnBiYm9HUkFGcHBERjdxRlRIMGs5c0NqWkxpVVJvNGxnOG8yaFJL?=
 =?utf-8?B?aitBOGxCaTROay8xUmdjVGI5RXlUQVZqdXR0OVBqL1ZIaFFzSWRCYWJ4YUJt?=
 =?utf-8?B?UGJWQnFwbWJnTjRjR0tOb3BzcHBoV3B4aWo2dXNKT3ZMaHVKL1NwQ2tVNEh0?=
 =?utf-8?B?eWU5czdLVEcwdFBQUlFUbHAyVnZIK1hOaHliVUlWM0Y1eVVuck9HdkRNaUFM?=
 =?utf-8?B?cmlGNHJoTHRmYTlGaVIvOG5neWtMZ0FzUHVqNGgybW5NU0xubmlodHBzbG4r?=
 =?utf-8?B?aWg1RnBzK0pMNCtIZWpJbERaKzJQZzV5WW42UDBJaFdma3cyaVd3VnhmNXBN?=
 =?utf-8?Q?x1GbAP0wdDizOQZnZcyDM2UzH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffc6d33-fc19-4f5f-fdd1-08db9a2a796c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:19:02.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXOFFJGRYp+6De1GKTkyAFSD3mOdQrTDom559XrQUhx353Y/7pnfCasUO9hPk4jo+jBHCVaObmAU5jLPs3WDuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/20/2023 22:50, Avadhut Naik wrote:
> From: Avadhut Naik <Avadhut.Naik@amd.com>
> 
> This patchset adds support for Vendor Defined Error types in the einj
> module by exporting a binary blob file in module's debugfs directory.
> Userspace tools can write OEM Defined Structures into the blob file as
> part of injecting Vendor defined errors.
> 
> The first patch refactors available_error_type_show() function to ensure
> all errors supported by the platform are output through einj module's
> available_error_type file in debugfs.
> 
> The second patch adds a write callback for binary blobs created through
> debugfs_create_blob() API.
> 
> The third patch fixes the permissions of panicinfo file in debugfs to
> ensure it remains read-only
> 
> The fourth patch adds the required support i.e. establishing the memory
> mapping and exporting it through debugfs blob file for Vendor-defined
> Error types.
> 
> Changes in v2:
>  - Split the v1 patch, as was recommended, to have a separate patch for
> changes in debugfs.
>  - Refactored available_error_type_show() function into a separate patch.
>  - Changed file permissions to octal format to remove checkpatch warnings.
> 
> Changes in v3:
>  - Use BIT macro for generating error masks instead of hex values since
> ACPI spec uses bit numbers.
>  - Handle the corner case of acpi_os_map_iomem() returning NULL through
> a local variable to a store the size of OEM defined data structure.
> 
> Changes in v4:
>  - Fix permissions for panicinfo file in debugfs.
>  - Replace acpi_os_map_iomem() and acpi_os_unmap_iomem() calls with
>    acpi_os_map_memory() and acpi_os_unmap_memory() respectively to avert
>    sparse warnings as suggested by Alexey.
> 
> Avadhut Naik (4):
>   ACPI: APEI: EINJ: Refactor available_error_type_show()
>   fs: debugfs: Add write functionality to debugfs blobs
>   platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
>   ACPI: APEI: EINJ: Add support for vendor defined error types
> 
>  drivers/acpi/apei/einj.c                  | 67 ++++++++++++++++-------
>  drivers/platform/chrome/cros_ec_debugfs.c |  2 +-
>  fs/debugfs/file.c                         | 28 ++++++++--
>  3 files changed, 70 insertions(+), 27 deletions(-)
> 
Hi everyone,

Any further comments on this set? Specifically, for the changes being introduced
in the einj module.

-- 
Thanks,
Avadhut Naik
