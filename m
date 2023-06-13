Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF29572EF81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 00:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbjFMWf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 18:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbjFMWfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:35:17 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592DE127;
        Tue, 13 Jun 2023 15:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqHUStifxKVQUbQyTjX7HkPjbnIja1EnkbDmVjaRtzqkR5uJmRN1jsrO7Y3tobTeLxcWnVXJXZqkWiMEzY0LFLK+1MyZVhc3kHTpTizgZr01m6D4qaWE6pwPCsnrXM/Z9jjvabqvxf/rZ2/agK8B6ycZyMa5YSlnQpaHt6u3j00MkLc0nMytaDu5N6qoxFyCgO0DVvNQDSyvnBGe3qO0r2LRKzijqVmi6hp+mP4g0bJxmS03GHXK/cNhAq74FrH9pQkeQnBzcHHGFjpjxSGnGu/WuoFA4XpmFYrsikGiF/tLf96pSUoY8XhAI/wd0JDrRmPV+LregAwoLrtCEMM8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbwVm3EK+xBi07Frerr63Hf7oLUCRow0SESNHAzH794=;
 b=Vpt2KGZZsx7vk2CU8WwT/2L2iG7z8eZ+u0YqFC9PEZAB91JCM0XO6QuYaqvigKSZQ8Py/4aDKboZlpRq23tivykN4iy8fDmQqKxWgzkXOAy4eiPanvXU5Rx7VOY5yrk5v8DznM7hZ3FZUPag0yQ5aRBFdhea5HmAlCIEFWV7VB0KvKHpBglWquVwRaeV1cG5DDADxFPZcd8kYZ/YFZijAuvB8N6jG2NiEA7EC6cs4sJmiUCHLP1YYZsZQ8E2p8M5tX9I+8VposwwefaXR/WFX/Z46HtAq8Mcl6EBORQLP2LUbg3cdEufvYFmdf+QlHXAFN0u6gxFwMBmVIr4GZEYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbwVm3EK+xBi07Frerr63Hf7oLUCRow0SESNHAzH794=;
 b=5qkntxU6LBTZagnZSuIs4AXaQDTvDTuoV5vrSaj8P7UC4hXp9NYHtWAiUklSefsv9kdaxxeLECXobDhQg1m5EpnrA2rxgaBrH69irsrl0yg78XziCGlDOA8RG676h4Gv70VM+9xj161FSu2lrOc5/z6hcPwxfpVw9ycoqBBBTmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 22:35:14 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::ddd3:9069:b6e9:ed8d]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::ddd3:9069:b6e9:ed8d%6]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 22:35:13 +0000
Message-ID: <417346e2-09cc-3b33-e4cf-57d00a8edbbe@amd.com>
Date:   Tue, 13 Jun 2023 17:35:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [RFC PATCH v3 2/3] fs: debugfs: Add write functionality to debugfs
 blobs
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Alexey Kardashevskiy <aik@amd.com>
Cc:     Avadhut Naik <Avadhut.Naik@amd.com>, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yazen.ghannam@amd.com,
        alexey.kardashevskiy@amd.com, linux-kernel@vger.kernel.org
References: <20230612215139.5132-1-Avadhut.Naik@amd.com>
 <20230612215139.5132-3-Avadhut.Naik@amd.com>
 <2023061334-surplus-eclair-197a@gregkh>
 <1d55a83a-b36a-4319-16bc-c1aa72e361b5@amd.com>
 <2023061329-splinter-rundown-a61a@gregkh>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <2023061329-splinter-rundown-a61a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0058.namprd12.prod.outlook.com
 (2603:10b6:802:20::29) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d26db0-6215-4e28-13a7-08db6c5e745c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Y6XcmkdXr2PZe78j5hABBu3q0Q6mBUzsr61lxmAkusZh0gFPNQdnFYeD4yqhA+Hke+KwKIGpV04AfCF87OO4sYURvW+y3tXWVJnZWzD4/i26+UMGmDpt0VXFjk9wj/403jU/Cb5bOAp7f+mQbizQ7G38zg0TP5JGkP82LhvB4bEzvmqUh3Cq0CQN8MLr4ezHv3hw9UgMlB//v5WSXJr0dNlWe5MiEMTYoG7/8YSeHXoZyJR9cjiVXcgVm7fZT4MmuxWZKqWugbWI+0Jejx2vEKxhLrx0gvxdOVp5OvRZ7dY/QBwJRRj/8egEy8Qa+N8S9lkc7Q7NjYAkGOH4n4DTWETwyjq351HT8JhcIRoVpSbYtPlTGGyxSrCWvlRYA/tEIjUQcPCvR1qW+isdZE6nTCVI9GBn8GQ/a5Yc+chma9lkRExgx9KDNaVy7EifwMh7TRkUZ9S9cB+TdNgCzrsKDr8+xx8OJFidGt9g4iKalRIa4ktO2vDJgm4OQ+aFawgXpvxhTNv5Z3RsWPLciZGFLjHbo7kuCsJsWmOyzCeigVeKRzgvPDb42mk2Y4ae4agqxsCFApkVU23HOrcNa8HU5EZd0ZJY7Fwx+UJPQywyrn6aGGNpt+7LxmY00226aLONdu0EbnskqFfr8OQMzznAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(6486002)(36756003)(83380400001)(2616005)(38100700002)(31696002)(53546011)(6506007)(6512007)(26005)(186003)(2906002)(110136005)(4326008)(6636002)(316002)(66476007)(31686004)(41300700001)(66556008)(5660300002)(478600001)(66946007)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEhiWUlhVHY5L1gwQ2cvdmRMTWs1TGV4UU5xVWM1VjFOUnI5OC9xSUtGUXJj?=
 =?utf-8?B?NFpUNVRWQVpUSTFnWWoyaVFOL0VDdkZab2p2ZXYrVkx1bHF6MGFjOTFFUUZa?=
 =?utf-8?B?a0NaYVplZzQ5NHlBZjBGdEFZQ2FxUldBRzlwN3hoL1N0WXIvNjkrNU55SjBj?=
 =?utf-8?B?M05MVGlMck5CbXRUWCt5NWQzZDhNRGJlMFp4UkN2S016TURMUmhaTzZEUVNX?=
 =?utf-8?B?TlhrSEZjV2RvSmlMOW03MHNhYXRXVVpKd1VJSEhSTlJQQ2pMa2JvYnpzV0Zh?=
 =?utf-8?B?RC9lNXFDYTBlQ2d0WlVvaGdXVm9BSHRWYzBzRUxRU3BYcHpTenlvWE5mdnls?=
 =?utf-8?B?c2hadGhZWFZlOFdKb3BPVUxRNXBlZnY4NDFsbm1zOGNKNThTVnAvUVdNN0dM?=
 =?utf-8?B?S0NIYUhtWEhNZlE5aTU1b0lkTlZHOW1nbGdXRzh6QlpBMDEvYUkxU2RWdHRv?=
 =?utf-8?B?N0hNa1JLQXdQQXplSzkxak9mMUtvb1YxdTBGaDVQbW1DZ1VzU2NoeTUwQkpi?=
 =?utf-8?B?S3VLMzFVdWk2ajR3S1ZuSFVNc2xKdUp3RWJvQm9ESG1TdHBXSnZjTXRqcENU?=
 =?utf-8?B?SzZnU09JQWdqSVo1L0h3eUw0Tng1RGppTW9TeXZnTm5yWVdXbWZvS0NKd0RF?=
 =?utf-8?B?bmVTMy9aV0JpQjNBMjJCbEhiMlJTMFZscnFxRDZvUDhNOEdZWWxLYkFTMk1Q?=
 =?utf-8?B?UVROSFF3djYrbkhFaVhmc0ZONCtJTlNyVFhpVzVYMDJMMVZVanovSS9CSHM1?=
 =?utf-8?B?R0NsczNkR0tjY3RWS1k2REdubUp3NEUweU9TU3ZtMGVWbDZxU1ZSd3hBSEY0?=
 =?utf-8?B?Tlh3QTJYY281UURCYkhBVWZrZThzZGJoNWJDMEZxYm4wSGxSSXRuWVMycldS?=
 =?utf-8?B?OVRBRkZ4K21XNGhPcHZKN2l6YmNzV25JRWh3UDZmZlgxMjRIQ1F0MVpacHJm?=
 =?utf-8?B?dmtLd0F0SHhzazZzTnlKdHhjQis3UlcxMVRvYjN2cVVrSE1jYzI1YngvL1hP?=
 =?utf-8?B?TGNsMUVwNHRNcnI1TCtzMWZaZnozdlBBZlQyZjRiTEF6ZUhjVXl1ZSt0R0Vh?=
 =?utf-8?B?UWV0c3BETWNOdUhuRzBML1pJS2pWRlUxTVNsT0J5TjJ6ZS83SHVkeEJsM2gx?=
 =?utf-8?B?bWJ2VEEzZDNHUlM3UlBuaXhzTTZ3cnoxT3V3M29DVHg3a2VGV3JoeWpibVYz?=
 =?utf-8?B?U0pyeCtlTHVLelhtMGhMY2hqQnAybllqQ1UrQWIyTWU3L3BTdkJCVjBUcU1i?=
 =?utf-8?B?SytjY3VTUU1VdlBVdU9nNEpjd1cvQXhiQ1JTYStoc08wRGNrRWdDZlVqanla?=
 =?utf-8?B?cm5DdlNKcjU1eDd4eGdaWTZ3TkdPbUtvSWNrTk42Q3pRbzdpT3NrYlZtMTRn?=
 =?utf-8?B?K2VWcFpyWW1JWmVYRTNTWmhYcEFxWk9IQ2V0VkpKRlBIdzdRdmV4YmFJelU0?=
 =?utf-8?B?cnRIR0ZRaXNwd09XTUJuY1plY1VvdndPVXB5UWdWT0M3d0srajFaYkFUOHZ1?=
 =?utf-8?B?NzdzZVl0ZEI2Qm84UUJJd29nWitkOFpTczBwUThGMzRNZTJuUEwzQ3k3ZDl0?=
 =?utf-8?B?TjdGNXZjVTdMWktEQlZvTzkwc3BEWnJ1dkZTbzkvaHZPUGtBaFFRSktQb3ky?=
 =?utf-8?B?WUREVzNHNWI3eENVOXhSKzRYdzNpdmxBTElndFFJcTdSSzhxVElUdHllOTNC?=
 =?utf-8?B?TFptN05uaTVDYm1mM0FVMDkwNkV2OENqRUlnejNCUzlXOUF0eUFOdC9KZisv?=
 =?utf-8?B?Sk1jSWhnb3lPZ3dQUktEc2J0cHRQYm95RHdDeS9LUTVzaEpGZkZuN3J5aENS?=
 =?utf-8?B?VDg5TnJTaVZxNUFPa2ZLUWk5VHZKWEZMaE9wcmQxeXhyTi9JTTBpR2RSbUdu?=
 =?utf-8?B?bk1VSVY4NXFpOWpoaXVlNzhja0JERlRYbW5SbkNTT281czZCOGJLUVB3NFpn?=
 =?utf-8?B?WmdGNmhQa1NoR2lkeUxuQXhxbTJMckp2VGxMbmg5RGFvcVRKV0F2b2xXQVI1?=
 =?utf-8?B?ckQ1MldVSnVuVHZjUU8wcmJmQmVSeTVQcXNlRk04RWM2WklIOFVWdUFaRzVS?=
 =?utf-8?B?VXBzdlNEYVJxQjJGNkJERnJqSFpNUWRRVWhGbkF0eEFydURCeHhLS1pyM0FV?=
 =?utf-8?Q?0LEt3X/6JHX0ar605eDCCG2VQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d26db0-6215-4e28-13a7-08db6c5e745c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 22:35:13.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrhaTe7LEB8WXArPlMArVPUxK08iL2D37VRAGpid74LpThPURrQ65EUzDQ7PrShp+ybQ0mVbaha5F0JU6ZwSIg==
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

Hi,

	Thanks for reviewing!	

On 6/13/2023 05:22, Greg KH wrote:
> On Tue, Jun 13, 2023 at 08:05:41PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 13/6/23 17:59, Greg KH wrote:
>>> On Mon, Jun 12, 2023 at 09:51:38PM +0000, Avadhut Naik wrote:
>>>>   /**
>>>> - * debugfs_create_blob - create a debugfs file that is used to read a binary blob
>>>> + * debugfs_create_blob - create a debugfs file that is used to read and write
>>>> + * a binary blob
>>>>    * @name: a pointer to a string containing the name of the file to create.
>>>> - * @mode: the read permission that the file should have (other permissions are
>>>> - *	  masked out)
>>>> + * @mode: the permission that the file should have
>>>>    * @parent: a pointer to the parent dentry for this file.  This should be a
>>>>    *          directory dentry if set.  If this parameter is %NULL, then the
>>>>    *          file will be created in the root of the debugfs filesystem.
>>>> @@ -992,7 +1010,7 @@ static const struct file_operations fops_blob = {
>>>>    *
>>>>    * This function creates a file in debugfs with the given name that exports
>>>>    * @blob->data as a binary blob. If the @mode variable is so set it can be
>>>> - * read from. Writing is not supported.
>>>> + * read from and written to.
>>>>    *
>>>>    * This function will return a pointer to a dentry if it succeeds.  This
>>>>    * pointer must be passed to the debugfs_remove() function when the file is
>>>> @@ -1007,7 +1025,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
>>>>   				   struct dentry *parent,
>>>>   				   struct debugfs_blob_wrapper *blob)
>>>>   {
>>>> -	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
>>>> +	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
>>>
>>> Have you audited all calls to this function to verify that you haven't
>>> just turned on write access to some debugfs files?
>>
>> I just did, it is one of S_IRUGO/S_IRUSR/0444/0400/(S_IFREG | 0444). So we
>> are quite safe here. Except (S_IFREG | 0444) in
>> drivers/platform/chrome/cros_ec_debugfs.c which seems wrong as debugfs files
>> are not regular files.
>>
>>> Why not rename this to debugfs_create_blob_wo() and then make a new
>>> debugfs_create_blob_rw() call to ensure that it all is ok?
>>
>> It is already taking the mode for this purpose. imho just
>> cros_ec_create_panicinfo()'s debugfs_create_blob("panicinfo", S_IFREG |
>> 0444,...) needs fixing.
> 
> Yes, well it's taking the mode, but silently modifying it :)
> 
> Ok, thanks for the audit, respin this with that fix and then I don't
> have a problem with it (other than binary debugfs files fill me with
> dread, what could go wrong...)
> 
	Will add the fix for cros_ec_create_panicinfo()'s debugfs_create_blob()
usage.

Thanks,
Avadhut Naik

> thanks,
> 
> greg k-h

-- 
