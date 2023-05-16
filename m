Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E857059A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 23:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjEPVgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 17:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjEPVga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 17:36:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D069983F0;
        Tue, 16 May 2023 14:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYbJfiT1G2tEF9LnGsIYtBq8Lg56Dku8eHhS7CqkAJFHOAqTezfGSWLIArlRjeaOwDLTQ4HjYmfwdEX3VqjPnGT8+l44N8sw+Cg8caIk7Q/gwILwFNGHeqYCJeG5Z1jlzJoWwJk/cXBh6RHVpp4ak3JmEYfDeTaJ71pnMdf+dRVt1glLezQ+z/qky8H/8M4ACCWz7V+dsP32ehpTfmAyzuOCSgwA1ZLDWzqwMVjS8ZiQroxvJ7p+TuaqsOXzZKRrpr5NnAznzWLidQtHKwhTRTHOSpgehmklkyqImr2UxPzByA1NwozuTQJ6QbO19BrG8E3QZLKQGsWz6i1XQeOE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLqYrSlvMRc86drBkIRq/+I0avJY+2PuG5I/Adst2ZM=;
 b=MSqNh5ID4RxRCHDYoi609IKcgj6Jv6elLCjQq5uEEFK+I05TrKSYvWssWRNsZ6W6gaVyJJQpaezLtfklmIE9+l7NUgCGW7lGsUycwQZ79w8VgVXEjfli90g+Uwg1fo1CR6ceK2yc0apmC9ILCqcCp2+K5kR117smCVny3SMhn8EbP9KHHqONBNAUJX2+ZI0yuA3tjwYsRCgxgBGo2zrs4KiuG6h264fxUyweadPcLeIopUfQb7DVdMy7Qn25CNoEdyOeE42IjjKh5/R8toWRXlODy5nGk7w8OUUfZvFqb9Ae2zS1B7DLTYiERMCSMijPoBCqFNc57LA0cVTa06YwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLqYrSlvMRc86drBkIRq/+I0avJY+2PuG5I/Adst2ZM=;
 b=2vvwBy4b1tUN9VTZAE2e5MSltxA+rT0EkiyaYj83ibbqGKDGMdAFSKSFM7gvWmww7HDDnqH2EitXN7iVXz+By7/UOJPiDZKzJwR+fVbPAO09YDSayl23OTMAe6f82bNaFyBNLJKlZN+bs8ypsRppDHtCuS2w8LSns8nRTHLSIgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 21:36:05 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::ddd3:9069:b6e9:ed8d]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::ddd3:9069:b6e9:ed8d%5]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 21:36:05 +0000
Message-ID: <d10df9d4-8cc7-b6f0-4096-cd0805407744@amd.com>
Date:   Tue, 16 May 2023 16:36:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [RFC PATCH v1] ACPI: APEI: EINJ: Add support for vendor defined error
 types
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, Avadhut Naik <Avadhut.Naik@amd.com>
References: <20230516183228.3736-1-Avadhut.Naik@amd.com>
 <2023051602-clear-encode-984e@gregkh>
Content-Language: en-US
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <2023051602-clear-encode-984e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::9) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|SA0PR12MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b8a163-4593-4be9-5724-08db56558dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiCv6W7EvaFoZGZOlRfULUrh0KBgQ5Lu1Y6Wuw1e/xsQKzFeH39jI3zGWDcmsVh65TUSA+zw0HF8bmqSJOyb2iXGSvBVgeVRKDn1NIFiSgFTtKASN6I5PkqEfE+tWITimvcCLSW+m7AS09wXaAEASFwGlQj6jPXE+iBfNW7V0Ns1zMfBSEFIUKoWnroOrQoqz2KvQZZ101E8Zy3CQ4dfZun5j9vD91LUAc6aiY778OTDtUZm2bAZ84V8qUy6OsxOBPWfQBf+fw1NC4lFJLgeK4fxkt6HfCx8oL+5KcPN55dHUgiZR6AClcy53kso48enFN3ChTU9VxhKMeD4y5u6TCXwsmTd3PS9cWneaXC1vnD7zp+wNoL73jG4ck//tAfXCGPC1qqFNnigdZ1wkbi7BDSfBwh7wUoJ2tFUoT3pjqjpuAs5lxP1h4ssa/0rxhsKGMtv8nDIWd5Z/GBbevD89h7dBreN++JN59IqiixKdxepu/ZEGHxhIRafS13vo+9vYVPsbenzyHstDnMwbVF/DBmD4Tr5n4XgYhlHlh+e9BuURSp2iuHS8m6vxzEHMAtMjHQWDMv0+4LmnrtsPy7BibfzY34ZgAg5tan4+xwAEIVqEe6YTox1fE4G9DyU0SCj38arC6qS5In6ItQcozr3JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(5660300002)(41300700001)(2616005)(2906002)(83380400001)(36756003)(31696002)(38100700002)(186003)(26005)(6506007)(6512007)(8936002)(8676002)(66556008)(53546011)(66946007)(66476007)(6486002)(478600001)(31686004)(316002)(4326008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnhCVm5KRTlPQTRYRkRKVjBrWi9EK3YwRS9MOWZDVUpubXliWUVkSjh1ODRy?=
 =?utf-8?B?OEk4MzY4TldyVFlGdXg5L09kTndtV0l1QkE3V3paOTBwcHU0eE9sSzNkSDN1?=
 =?utf-8?B?SkxtYThRa0dCS1YzZVdHSEk5YkJaV1NFektVL0hFZDNtUXdmOWdUd1FQOHFi?=
 =?utf-8?B?WWZEbTRaTnRuMGdhMmphS1dmZFcxdnc0a1VTUmxjTDRObHFTaUluNWwra3FY?=
 =?utf-8?B?c3VXVHF1RlBaVllTdXRpOGJZajNLemJYbFhaZnU5WGRHVHkxMnJabVFHaVcv?=
 =?utf-8?B?RFkzUlkvSXVkWnFCRCtzSGZkc3JCTjg5Mmw3OWdSQVh4aVRrMDRrbFVFZWVE?=
 =?utf-8?B?cEtHT1k2S2xDbnZJWitCOG1qSXljRjVHOGVCSFRrWlZrcVZYT3hsMytzRElR?=
 =?utf-8?B?OUkvRzlzYlgwUXNlUVIzR1k0K3hTTFRzRk9BRDN0WGptSHdjSE1KUUtpSEdL?=
 =?utf-8?B?ZHpTY3h0MTExaGE1Nm9lREVMOW9YcS9LeGxsNEUvUEFPcXNuNzZUUzZ0WmJK?=
 =?utf-8?B?eTBxdXQrSTd4b2kzTEpwS0lPKzZoQlhLZDRHSmVURTV1VmZGREdTV3dOT2Mr?=
 =?utf-8?B?Vzc4d1RHVUVuSXJaMS8vWXZvUVgwclcra291TG4rTmh3WUorUW0zdXVCZWpx?=
 =?utf-8?B?dEtRRE9iNWZIZTV0WUFsV0lWMGR4WEJoWkZHL2tCa2RSL0E5SnlvSnRaUTc0?=
 =?utf-8?B?NXlCcVlTUUcxaHlOdnBkV3FqcTFLblQwTG1QL2EvMVl6S1pRRjl6djduWThP?=
 =?utf-8?B?Ty9UV1B4RFlYRE5xUDJZamxjaFpaWUQ0dDdWUUNqS09HamF3WlBZenpNVXdZ?=
 =?utf-8?B?M1NGeDg4KzVBeGF5ZVFnY3hBQTZQdWRZWmREVDZ6ZllwZ0Z2S1dqT2M0K21N?=
 =?utf-8?B?YXoybXlGV1JBUDhtVHNCQWZaNTdLUnNKNXZrb3Q4M0thQnNscmwyR2xkNHYv?=
 =?utf-8?B?NGhuMGdWckJ1MGk4UTBzeVRwQXYzMGFhWmhHQWV3R0FpUTArOXVSMk1ZaVVO?=
 =?utf-8?B?c0dZeGpmY0htS3FMOStoQnIvak1jank5NXYwS0ZMVE9kSERvMU1ycmtnSmFu?=
 =?utf-8?B?eE1sNElpeFpNRGhPMEg2d1l5QjY2TGlGMGphU0VwcllEc1Z1Y2h1dlhXd25i?=
 =?utf-8?B?UmZFSkZmdVZUU3JGN0tnVWR4YWlqMG5FSVFOYnZBdW13TUxpam1pb0lTQ0ZK?=
 =?utf-8?B?ZmRHRzVFZ2pTUFZlbVpUVmRqOEg5ZHN1dkFLb1l0YW9QQzBnMzZ5S241SDMz?=
 =?utf-8?B?QXMzNHlORDFDaDEzcXhUZEtibG5DWFlwZzhVMmhtaFRjZEJSSlF1WlpmeVdF?=
 =?utf-8?B?OFFQVWhxamhwdTdhUjhDdHd0RXI0Tmk0NEc2TktxMnVHWk56RnEwZXR3Lysr?=
 =?utf-8?B?dVkvTnN1OEVsektzaXVGOEZpTXR5RkRuMHpEdnRiQWZPczZJbkoyN0p2WlFn?=
 =?utf-8?B?ajNMQ0gyWGx2Ly8rdkN1b2xxSGRrNTBEbkZXWmZ1OHNwYWZjN3JPZUpWOWtx?=
 =?utf-8?B?T3VFS1UwTlBwWnBPZmFFRW96MDZDSExuanprUHZsNi9CS1lodkFzVHc5SlhZ?=
 =?utf-8?B?VU9KRGxTbVdzQ1grNmdSRW5ZenZReW1UYzZxKzRiNkpsOEFjYXhyUllCeS95?=
 =?utf-8?B?eExwNElwc2hhZVNwY2NqNUtuV3Nta1JhNUNZNzI1L3htTCs0T0JveFNnUjlO?=
 =?utf-8?B?SEduUUhCMzFQL21hbjliWk9JTnJtRW9OdnpQaERVU285VEdTUkVCdHlTeHBM?=
 =?utf-8?B?TGt4Uk1hYy9YdDBFMW5mVEVxdnF3QW00SzhxK1UvTkFETFQxeHl0RzhjMHU1?=
 =?utf-8?B?eVlHMFRHU0k2R2NIcFEvVDM5d1dSN0pKZEU5TE1DczE0Sm0wbWVBL29uNGtz?=
 =?utf-8?B?M2VYQm5KMlBSYzhsSEFOdC9ub1JwVXZ0YkpwaXYyWEtUcUJLc08vQzZQcGgz?=
 =?utf-8?B?WjN6WlRva29IbVk5SzFwTmR6VEpjbTZBWXJMejBBdjBtd1VIRWxXSWJGc2JL?=
 =?utf-8?B?VXJKak1KMTNWVXBTSWl0TnRHUlkyeDA4T0ZIcUlpclA1YjdsL0RDY1NiQjJ3?=
 =?utf-8?B?NkdFMTM4ZUY0YWs5VmlwWEt2UjNYTnBNZEF3ZkE5ZE1YNmNydDBJMUVtRFJv?=
 =?utf-8?Q?VuFMfYncwc+7AePoNHVS2De2L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b8a163-4593-4be9-5724-08db56558dca
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 21:36:05.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhBYrrCJ+W9mNx8fJZg0PqFUf32LEqjiA9tB8//QoucCrnev6B0rfyrHxtJNxlbicw0aRvdWB+54bj8q0dI2RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
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

Hi,

On 5/16/2023 14:25, Greg KH wrote:
> On Tue, May 16, 2023 at 06:32:28PM +0000, Avadhut Naik wrote:
>> According to ACPI specification 6.5, section 18.6.4, Vendor-Defined Error
>> types are supported by the system apart from standard error types if bit
>> 31 is set in the output of GET_ERROR_TYPE Error Injection Action. While
>> the errors themselves and the length of their associated OEM Vendor data
>> structure might vary between vendors, the physical address of this very
>> structure can be computed through vendor_extension and length fields of
>> SET_ERROR_TYPE_WITH_ADDRESS Data Structure and Vendor Error Type Extension
>> Structure respectively (ACPI Spec 6.5, Table 18.31 and 18.32).
>>
>> Currently, however, the einj module only computes the physical address of
>> Vendor Error Type Extension Structure. Neither does it compute the physical
>> address of OEM Vendor structure nor does it establish the memory mapping
>> required for injecting Vendor-defined errors. Consequently, userspace
>> tools have to establish the very mapping through /dev/mem, nopat kernel
>> parameter and system calls like mmap/munmap initially before injecting
>> Vendor-defined errors.
>>
>> Circumvent the issue by computing the physical address of OEM Vendor data
>> structure and establishing the required mapping with the structure. Create
>> a new file "oem_error", if the system supports Vendor-defined errors, to
>> export this mapping, through debugfs_create_blob API. Userspace tools can
>> then populate their respective OEM Vendor structure instances and just
>> write to the file as part of injecting Vendor-defined Errors.
>>
>> Additionally, since the debugfs files created through debugfs_create_blob
>> API are read-only, introduce a write callback to enable userspace tools to
>> write OEM Vendor structures into the oem_error file.
> 
> When you say "additionally", that's usually a huge hint that you need to
> split this up into multiple patches.
> 
> Please do so here.
	Will do. Will have a separate patch for debugfs changes.
> 
> Also note that debugfs is almost never a valid api for anything you care
> about for having a running system, as it is locked down for root access
> only and some distros refuse to enable it at all due to its security
> leakage.  So be careful about creating an api here that you might need
> to use on a normal running system.
	I think we should be good in this case. The patch mainly attempts
to extend the functionality of einj module, if supported by the system.
The module itself, I think, requires for the debugfs to be mounted.

> 
> 
>>
>> Note: Some checkpatch warnings are ignored to maintain coding style.
> 
> That's not good, please follow the right style for new code.

	Noted. The only checkpatch warning that was ignored was pertaining
to the usage of S_IWUSR macro with debugfs_create_blob. Had noticed that a
majority of einj module's debugfs files have been created with S_IRUSR and
S_IWUSR macros. So used them to maintain uniformity.
	Will switch to octal permissions though.

Thanks,
Avadhut Naik

> 
> thanks,
> 
> greg k-h
