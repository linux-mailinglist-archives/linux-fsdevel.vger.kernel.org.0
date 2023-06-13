Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412D972EF7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 00:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbjFMWeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 18:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjFMWeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:34:13 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB95012E;
        Tue, 13 Jun 2023 15:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVoVw1T80gEaKLE2TfmTZefuefpeFfgu5MvVRFRtfAgr2DzJnXCazxfta5X2icI0mC4VRmKD/bQHzsH3BpfZBpgltU7Us0FWseAbnWz5391jtZxzD/9YAuxuT+lT1cKT/5BoNF0qpSkx9FlKu09h7j86Nsdy5wEQzhtTreUuHGOIvEZAeblX8IbWdvf5i7JT2DX2y7+oWHBW5mxa8eV0JU8RnhMu5QY48YxTv9ojCuYwSj0/QNnRcBa/TdR+l53tvj4dW6vVdJ/48HJ/nskWgxDeGQTv5zDOCaRbtPhhHoeq8lEIe/yRlVtlGO71pLjQ/0BgOwKiZtBeHqBxNxx96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDxrEyj7Fn7TkXkQgeRK2YP2CVMQEBJVbyw3+EHIAaQ=;
 b=lAISkTlPwDqxVbn0U/S9T0oG+IwdSZmgEC5igQM6ubXyYxr1nhrV6ur2tXMXC+DSFZj1nw1FynhXz/WFYfgUiISOnzRuRQAdayckIutM0EtptvW8SEApEk89J457xOKHoJULUkrsSf9Z0EJlNvUmkEHCG/Mmc+A6irjPEj209bGQDfL1339QPDXMwv3TsJgaoZcggUST2X6Rcumt6BeKVd2xX2GEfmunoHsXD8RcxZGIEeZMU+Z/d623j98maUDEzRo2PehiCsmedv7WUxuebA2Lt3ygmrm7xFcCjM8zR+YndGrZz7/mqimISvb8oTGy7793jJf+bcsxgXhhxW3L4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDxrEyj7Fn7TkXkQgeRK2YP2CVMQEBJVbyw3+EHIAaQ=;
 b=FXKEqy2CpC7ymEJJF6VxRB2FIadwQU5r7dTcfkr3e1ld2Zmmf8+qT5q4IJnNYDskIQyZPjve8bF8Kw8GRJnZzzOlzliLPssoHB8EBTq9YQCLqMzzrkXstOC7bB8CVEZssIOPbZVZW/WMQ/ww3V7C7EwxDJjGFvrlvtk9w7lOATk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 22:34:09 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::ddd3:9069:b6e9:ed8d]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::ddd3:9069:b6e9:ed8d%6]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 22:34:09 +0000
Message-ID: <f9e8243d-78e2-4aa1-e6f2-5ac2a8c1745d@amd.com>
Date:   Tue, 13 Jun 2023 17:34:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [RFC PATCH v3 0/3] Add support for Vendor Defined Error Types in Einj
 Module
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yazen.ghannam@amd.com,
        alexey.kardashevskiy@amd.com, linux-kernel@vger.kernel.org,
        Avadhut Naik <Avadhut.Naik@amd.com>
References: <20230612215139.5132-1-Avadhut.Naik@amd.com>
 <2023061341-anything-unlimited-cb62@gregkh>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <2023061341-anything-unlimited-cb62@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd48b59-1338-4c28-72c9-08db6c5e4de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBpoZBwyoPZ2cHSqLzC41qjClSL3nGSorCDDVsfUS4WCNfluKE6lsKecqYIdXqKVfvEwuZQZKdHN6J16Lpj2TGP9cA5/fnnzI9MNohI8sDa8ZXNnAbo70uhk5LFNkZ7ZfyTCrAZZ2eFKT/weMr0rKsByY50MfLQwqJSlM5enKjxNLehIP4T8pIfmO+4ASX4Hp79p+nyGbs/hx9wEtAJSf1Nfjtx0khFup0gr7JWa0htQFweCEzLpSHFQ4YKJH3OWQjtfpl5IUP0KKc64RoTU6Q7aOAdJ5tk2WyjOk46FSIuhiHjrLMXHaa+ToTiHzx276FH5548eqJx7as4FTl9J5Wa4uPxfKhxRtMHXLpLlGX8RfaQbrojulwQAWN3GxQU/qjoXYYQcLVLrXBFqrdRaVq+W+3GjmUdugODWuJhmZSzaoevVeq5bCN2OLk3K7ArRWZjoKYDxCQdRSQbCjLWzB5NZj67mPkwyM73j97uLGTNGxCPtM60EYehB2C2K+U+xEZun3x8HqCZQLCV+6figuy3YaAk7MSTjzuHkGCUanTFSVIjPR1nC9nkwB20bv6LrSaZefyi2qOr14iprNgbbJD/k5I6h72b79zA4hDWfW18ov+id9YgynGVF5j6Hg8diFle1CIuZ2Om1K4f9GGNYNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(6486002)(36756003)(83380400001)(2616005)(38100700002)(31696002)(53546011)(6506007)(6512007)(26005)(186003)(2906002)(4326008)(316002)(6916009)(66476007)(31686004)(41300700001)(66556008)(5660300002)(478600001)(66946007)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmhYcnlBYjVFdVlYeEgyYmNKb3d5ZDNYZk4yR1FuaWRCMDRkQUxDaGF2ZGZL?=
 =?utf-8?B?ZytEdDBsVmhuMWZYUTlTN2VneEMvQTZFbndCUkt2UE1qQ2lCcFQ5Q0dscDBx?=
 =?utf-8?B?NS9aSkVLSlJmYzFkL1dWYXRlYjV4MGtJM1J3NktHSXd4a1hiZDJXa24rWnhB?=
 =?utf-8?B?dW1QODJrV2VXZFliS2t0OGlObjA4UjdISUJoYys4ZEVaSEoyMVJVUmUwaEdT?=
 =?utf-8?B?RlZoRm1nVFliRUNjQmtIdlRYVTJXbnVhUlNoY25HRE9YY1czRTFObnNEblBz?=
 =?utf-8?B?NmVXZVVLZXVDVTBMa3M0cVNXS2RtQlkxZUU0eE9OaGJXVUExWklqSHM5c09k?=
 =?utf-8?B?bUNCRW44VjdTdDZSb1FLV2RJZ3dkMGs0REhXSHA0amovNUFzUlBrUWk4YUVs?=
 =?utf-8?B?RVhYbUlQTkdsVU5SRzVJc1RUR0JJQXhMQml4NHVQam9hMFJkS3J2akpQQ2px?=
 =?utf-8?B?NXhqMm5xckluWExGRWd6eFNCTHhYZ1FaaEN1SVlhcVgzdG9MTTZyRDBpcThF?=
 =?utf-8?B?TjdSNXpzdDdnd29wbWdEN09XRE9TOUdWZnBYQ2xaNGxHa0g2eHZ6NW8wTFUw?=
 =?utf-8?B?c1VmY1dSYWpnU1M3NFNmMnZUa25BQTJ1b211dnlwRlVLZDFMbE1MNjlabVBT?=
 =?utf-8?B?MFA5R0RrSHVHMndWT2NJMzV3Mkl2WGFRV0IrVXJ3cWtDS1dWVWFuYVROVUlo?=
 =?utf-8?B?Q0gxOXFUa0VyTlV3OEdqblNON1pDOWtzV1FhT1BUR0phc3AzaUhFamJrWk0x?=
 =?utf-8?B?NjNFTERJcllsMld4cDVPTGlOYXMybGMwa2d1NlpVRllGNDRIdlh2NnkxTi9o?=
 =?utf-8?B?ZlY0R0crVkJZcUdPVDhaRjkvTnlLeXdqNlFRbnVheDZRd3lKWFJaSUJXY3ZT?=
 =?utf-8?B?YnlPL0RNTGhiUDlHUHRSU0NCTHBJMEptRnJwczlFSm45SDgvUkRxMFVLcEZL?=
 =?utf-8?B?dDFMNTRwMXc0RU4vd09XZVAwcjRNQzdWZjdFN2JUdGJ1RjVYUmx2Y2V5bVlH?=
 =?utf-8?B?N041djdidDJMQ3FaOVlUWFNZZXB1NnltemdNT0E2TGtXOFNTakc0TVZwMkds?=
 =?utf-8?B?ZjFwQXN1K2dhd252Y01jSEZiVWhLdURRNW1xSEpKSUJEelJlakhJZTgxeTNW?=
 =?utf-8?B?MkJpQ3VTWHpET1ZULzFSbTV4YVJDK2NvaXRzVThsMWxTZUpEYm1qYXBQRDh3?=
 =?utf-8?B?UVlBWGlnSHF4SEIvc0hSdDNCTnFEdGI1K1lMTUkvM3FBc3FtK0lYM2U1STVV?=
 =?utf-8?B?b0FNZllTRXBDdjFnUEIxMVhaVjhISFp0YUxlODdJL3Npd05TV3kwUXRlTkow?=
 =?utf-8?B?NzBwUzQyVWtoa3lDdFRQeWxnVlNQS3p4d1ZTNS82R2ovSzg3TmdzZXFGV1hM?=
 =?utf-8?B?aXR6NCtZaG15VXRzMGQxSEdSbWs2R2M1TEF6blVPeGFtQSsvdUovdmtzTWRo?=
 =?utf-8?B?Rko3UWF4dk9sWTFHYmgzMk1ZWkQ1cWlUTnQ1em4ySDdIZ3Uxa1RlVWhNMkRQ?=
 =?utf-8?B?a1RuNlY0WlRJWmRqQ09haGZWZHpkWm1xWTllRzNRNG5abVR1WXVJVFo0Z1RK?=
 =?utf-8?B?MGxTMnlQTi85Z1pwUHJENnR1WmhObVkrTnh2ajJEYTBlUGxtYlR1UlV5N3NX?=
 =?utf-8?B?YVJ2c3ZlSURYU3V4Y1lQNC80NmpucVY2VFN0QXd5M2tXZ1VGcTdPS1F6MUlX?=
 =?utf-8?B?NXJwWHBPOVh5bkZRYUx1KzlNZm5IU05wcmszeldBRmErNE9OaU00V0dYY0hR?=
 =?utf-8?B?K3BwTDNiOXlPZ2E4VllROTd5RzlldVE1Mk9HUERkY3dNZ0h4RFpIV3BUU3lk?=
 =?utf-8?B?QTlScEVzZjVyTXgvS0VOb293ZUpsaVpTMUI0MHVCQVBkN0N3d0xveWRxZ2Vl?=
 =?utf-8?B?NCt5U2UrUlZYUFJadmJzZkw3czl5YnJHTnU2UkExMnZWWjl1c0FUdFdXZmV3?=
 =?utf-8?B?ajU4ZWw2ajN1aUNxRDZ2SUo5QTVjeDVnNEZicm93Y3FWdXRYTi9qdG5USjRx?=
 =?utf-8?B?eEwyVmZDdGZTa3Q2YzdmSmNTQWZnQUJsMk51WkNqR005MHhBZ2pLaWRJL3Qz?=
 =?utf-8?B?YkUzQkNJRHpDdW12UkV2dEJES09jSkJYQWVlTHBtZVJ6Z1hpN2pkcjB5MldD?=
 =?utf-8?Q?cPClxb+J4C06QXbT7/Tg+xyq5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd48b59-1338-4c28-72c9-08db6c5e4de2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 22:34:09.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mGkd3qLN6riI+haVPK3bJQ83q2Ha0GwdOEDJoaqgvbUlpG6OOJIQwmNlZSk4eH882qgtEQAAfZGcZ7UUyRCVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/13/2023 03:01, Greg KH wrote:
> On Mon, Jun 12, 2023 at 09:51:36PM +0000, Avadhut Naik wrote:
>> This patchset adds support for Vendor Defined Error types in the einj
>> module by exporting a binary blob file in module's debugfs directory.
>> Userspace tools can write OEM Defined Structures into the blob file as
>> part of injecting Vendor defined errors.
>>
>> The first patch refactors available_error_type_show() function to ensure
>> all errors supported by the platform are output through einj module's
>> available_error_type file in debugfs.
>>
>> The second patch adds a write callback for binary blobs created through
>> debugfs_create_blob() API.
>>
>> The third adds the required support i.e. establishing the memory mapping
>> and exporting it through debugfs blob file for Vendor-defined Error types.
>>
>> Changes in v2:
>>  - Split the v1 patch, as was recommended, to have a separate patch for
>> changes in debugfs.
>>  - Refactored available_error_type_show() function into a separate patch.
>>  - Changed file permissions to octal format to remove checkpatch warnings.
>>
>> Changes in v3:
>>  - Use BIT macro for generating error masks instead of hex values since
>> ACPI spec uses bit numbers.
>>  - Handle the corner case of acpi_os_map_iomem() returning NULL through
>> a local variable to a store the size of OEM defined data structure.
>>
>> Avadhut Naik (3):
>>   ACPI: APEI: EINJ: Refactor available_error_type_show()
>>   fs: debugfs: Add write functionality to debugfs blobs
>>   ACPI: APEI: EINJ: Add support for vendor defined error types
>>
>>  drivers/acpi/apei/einj.c | 67 +++++++++++++++++++++++++++-------------
>>  fs/debugfs/file.c        | 28 ++++++++++++++---
>>  2 files changed, 69 insertions(+), 26 deletions(-)
>>
>> -- 
>> 2.34.1
>>
> 
> Why is a RFC series at v3?  What is left to be done with it to make you
> confident that it can be merged?
> 
	Wasn't very confident of the debugfs changes since the binary blobs
created through debugfs_create_blob() have been read-only for a considerable
amount of time. Was wondering if there were some known issues in making them
writable. So, wanted to seek opinion on the changes while also incorporating
the feedback received. Having said that, since you confirmed that you are okay
with the debugfs changes, will remove the RFC tag in subsequent revision.
Apologies for the confusion and inconvenience caused, if any.

> I almost never review RFC patches as obviously the submitter doesn't
> think it is good enough to be reviewed, and hundreds of other patches in
> my review queue are from people who think they are ready to be merged,
> so this puts your stuff always at the bottom of the list...
> 
> When submitting something with "RFC" ask what type of comments you are
> looking for and why you do not think this is ready yet, otherwise we
> have no idea...
>
	Thank you so much for patiently clearing that up! Will surely keep
this in mind for the next time.
 
Thanks,
Avadhut Naik

> thanks,
> 
> greg k-h

-- 

