Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F56F8C4B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 00:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjEEWP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 18:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjEEWP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 18:15:57 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6228A49F2;
        Fri,  5 May 2023 15:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc1xUBjdH+n+ror6fRN6joXyB8oMD8I5qzdwwVVV6tP7tP3NjjhoHKB8/i3gRd3i+dYNnN7XB5c95aTbQ32ORdB8gZlWAbQxcOdNVHk2xClTe/p6mwIgLz+IUVUP9Laj+TFp4IkSuvgLKHN0zDBCHETItGnsdr011l0KPBkcEtlUIQDQ+f38zcBMT00I3YskQPPzTqle/xBiyXbzvaBHV0Pwx6KNRZ16/H06ZuYFeDkUQsvJ1S0XxMn7U/X0vmgtFA+Z/PqFOWsm2sqZGWUe8UHfNuu+pWHIt8a0NDyouOGT24XJGI1gtbuhGQ3heDGl8kRZRWiJwhbG0+Tvffwklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u18VGQfMKvOQyx9xf4QoEGqwUy5Ng9DvF6gBqhfkRj0=;
 b=PCfcNDSKRO3ieUNwdykBBnSfasfgQx8mLP+uffgMGrV3dVRkqez9u+ye6bQl2AXlsokARk8RH2ouLfNIY64y28hLNdUsJ86UsnmwNmNQVk9JNxrekz4ldxOAQO9fvcd9n44911o1ybLaY49tdGM8dIzkUCedNkvrlYYuZ616fGTkArv4nfnqi7RmDDz/HzvHx7FMrB/inV7VbWsEkR++scFkZRxIJ7st4q0HwR9v01cndtfQROMZR2mXx+IQPoK2u0Jr6QrQ9gWdHRMmh6xduKTnBFPtLk5EWnSc9TpafpVFv/9hiQLJCB/6ygdsbkzwfMP4jmJ4gzVWvEhJW49IzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u18VGQfMKvOQyx9xf4QoEGqwUy5Ng9DvF6gBqhfkRj0=;
 b=tSbAaHabAOldOA98bZYe04M5F/3afMQCBTpKOsUhphj2uFmbT42lDIUB/LohqnRBBLjqDAzg12xmlsHgGvFoL+H8bfk3wuCyJVcAsF8cOEmsdysV+yUon3P/iiLliepwOtOBr9cZbKfuAcP7+Ku/lyKRDut8uDFjf8mT5PafrNNknm/dZrmNW/UMhOdqlcTfr9pgCNZ6IhEaM2tfZkVMg44MMDu1QSdQzwkSFAwHBXpSt8t/2Xpcppx20ZgLOFeEVHv8bCAnW3YrrX/6jgyqtFR2VvZwub7GEb2Qqbc5u62pr5lQ/0J+7KHFux2Iz+9v7gwuLDo1DdsnLYi3B+Q+Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM8PR04MB7217.eurprd04.prod.outlook.com (2603:10a6:20b:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 22:15:48 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6363.029; Fri, 5 May 2023
 22:15:48 +0000
Message-ID: <4b9b1a6e-fce0-4371-980b-497400582e37@suse.com>
Date:   Sat, 6 May 2023 06:15:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <12aa446b-39c7-c9fb-c3a4-70bfb57d9bbc@igalia.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
In-Reply-To: <12aa446b-39c7-c9fb-c3a4-70bfb57d9bbc@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM8PR04MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 6535b1ce-53d7-4eda-861c-08db4db64788
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDeYAjFlQb8Q5wfK6gsiROLxftToG6M7tV3aBjU3rBvFSi6gPX5YIzLMxh24RZwSmqbtQ9uCB4HcWEmAWox5yDis/dVrWJoVdBC8v07u1lIgTMMMUjE0XEgepKq2FkTVCqss3RLldMRorSfIowQ2a+Ndh3AHGm4F3eSv8VhDwbH2vqMA10iAZJbXYsCu0NWJac5VIZIj0Bz6g7kIKs3JiLvXJvBbDDAWhVREPjoolwQr9uVc7a18lxAyFea6i8t/M1xtUdVaG0IT18uVh9hQ+WZTAooF6GuRpryk1jTok5e3QQ27OeToCa9AH27S+ECqsc4mHulylw64eVzkCsM7WkLounXRzuWd8YxTb0TJb+N8OhlGUkdJPIUu35mH62uBO/UykRiRK+SNOz9Fp9R0GKuefDrmda9LA+AlzcFPqKN9kjQFwDGGbo9i+5MrmJV3By7M1pQ4JpWoAEJuL15G8YxvOZMjrNO5SAiK5YJ/gXQ/tRDi2HML8mvTR2uvFMjpLoMYqArLxnaLk2JC8E+LiAKvQaIyWNaHxAIWj1XNFuv6arSmtLqYiof6oUO6OqD5TpDL68DS7lkPcu1GXzNGlD6AiNOff/IkhHlNGobEUc9aesiSAaJ3uBy4cRD18oN5qKpW0bLr/mIjCZwqO/DK2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(31686004)(66476007)(66556008)(4326008)(66946007)(478600001)(316002)(110136005)(86362001)(6666004)(36756003)(6486002)(31696002)(83380400001)(6512007)(107886003)(53546011)(6506007)(2616005)(8936002)(5660300002)(8676002)(2906002)(7416002)(41300700001)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNpbmI4V3FVelNtcEN4WHlQK0ZpMm5vS3FLMytxSHNGVmtrazRvTk5FZzVm?=
 =?utf-8?B?YUIzL25KMTBOUTZ1UWxWNHdKSGZnNFUyYTN1emx1ZWkzOHZrUEdTSTRsZjU1?=
 =?utf-8?B?WkZCSlltbGE4SUcvVnVWRmNoYzJUUGdBMVc3VTNPQ0NDbis1U0xuWHF4cnBh?=
 =?utf-8?B?NlpGZ2JQb2xpUEYvVW1MZW5GZWVKUllCMUI4SEdvLzJFazA1dmNtTDN1bE5v?=
 =?utf-8?B?QnJ1NlFkdlZlS3FwTVp2SlBzdERDeDQrRXo1N05CODhoNStTcVpWQkoxNGdI?=
 =?utf-8?B?WmcybDI4NU9EeFBmMEhWbHhXRXloSWFJQk1PRm9lWFBTcHFiQ3VoMXp4WnFV?=
 =?utf-8?B?eE9wOG1GSTRLMmlSR2F2dXpsZVArTmhxQUcydU1FeHo5dTM1QS93aEV3U1o2?=
 =?utf-8?B?Z3kyU1EvUVUxSmpMTmRZeC9UbEtJS1J4SmxBMk5NUDBoa0ZKQTRwVVlNa0Nx?=
 =?utf-8?B?NHkvb0xQNzVBSFc0MFljcVI0Q3dLVmF1V0pvdFJYdUxDNGZzb3czd1oyN2pZ?=
 =?utf-8?B?c0lTeDdjd1hYRkxzRG03L3NxNXppL25GZlE4cGJKcjFjZndJem92bTU0YXJJ?=
 =?utf-8?B?TnRaMEYwMkpBbWZsR2xXQlZwa0R4dGVFVms4Tk8yTlFGR1M3a1Q0cXRkQ2c1?=
 =?utf-8?B?QitlVmx0NDNhSWVkVzVBRnRVcllSdzBSWHVpbG5zbk41NVF6RTZTdU0vcGlT?=
 =?utf-8?B?NXF6bjBONzI3VWE0bGMvNTlBMWxFZU9Gdm0rY1pzZFZsVTdBbTRzRDdiSW1P?=
 =?utf-8?B?ZVNaMndjdm9uOTBWUUMrT0NWS3RsdVhrRXpzeGZCM1NGZDVyZDdRbnEwNXZZ?=
 =?utf-8?B?WlpnWGNPVWtiS242Mm1hSU92Z0hBR1VUdTRaT1ZSRjNJa3RCUENIQ3Rvcnhz?=
 =?utf-8?B?eHRMTXh5OUpuNm1UcC9LTFNtTWdYMExlcG5wZW1xTU5YMTVncVZHd0VoVmtW?=
 =?utf-8?B?ZnExMmczMzZka0kxRHB4SHAyNDdhTXJXU0xUa29jcFVUMzJZbWY5aHBLTHVa?=
 =?utf-8?B?eDdsWm1JbjgrUUpHVkJpWElxZXVVVFZyeWRKbmY0U2NtcitQdE5NbUpSdzJ1?=
 =?utf-8?B?dXVFMHZnc3JGanIrQTVCRmJ1TDJZQ2pVK3ZYTUtLalgyeFoyYXI3WkdpUEJz?=
 =?utf-8?B?SHBVMXBqQnRaRTVlMHBVMVowT3lVRmpHbXVLamNTa2xnRGFzc21haEFvNldv?=
 =?utf-8?B?K1VYL2NtRUs1eGJyQ0c2SkVtbTl1cHhFd1hsMXpJSCtQL3F4R1h6QlQvb1hP?=
 =?utf-8?B?UUt5QjZJL1c5UXhrL2FmZ3ByMHVmdUxrWEpFT0NuYVVpdmtGV1NDRGNzNVBZ?=
 =?utf-8?B?VXpNUEIvcTBCTld5NTRIRE9pN3FtTExtR2d4Y2VKckg2S3RZK1oza3dBRGZU?=
 =?utf-8?B?KzZjZHNoM01zdlZoOHhTRG5YWTlpQi9RdWlwVk5ldlFnNXdJSkxNcTN2NC9K?=
 =?utf-8?B?OVhRZ1Q0SlRJOFN2M0VOaFAxSlRMcHFZc3FaMHZJU3ZuR2ZUV213M05KcHVr?=
 =?utf-8?B?ampXbU9FTXl3eVdxNzVNOWpRUkdxMTRzcEZrcnN0SDVEeDBaQk9OWjNnS0R6?=
 =?utf-8?B?YUFSbmdtMEFiOVoxS3ZicFZxMjZlKzhNK1VPYlkvck5LdGF0T3kwQkxoc2lS?=
 =?utf-8?B?MU5lQjVOcmFWemVIUFNvN3lwcWVIR25QZzkyUS96L1FjTXIrV01POEJtT2Zi?=
 =?utf-8?B?SEFta1JLVzRnWG9nNXR5OU5kYlBCcmN0ZERscTZBK1N5cU50d1c5V1ZHYk94?=
 =?utf-8?B?U3N3NmZzNU40NnFtVW9ydGRIQ25XZSt2UkN4SFVpNmZzY3RnVEh6b3cyN1pO?=
 =?utf-8?B?RTAwMGJGSHZLeUhXd21RZnlua0JmWUNzbVpqUkVPczJNWmpMa2pHTTRQdFNG?=
 =?utf-8?B?cmtJbU90aVgyWnN2SFVMMTJ5Zy9ERDRPMjhwcGQralZJQW9HLzAyODQ2aWRX?=
 =?utf-8?B?eldxTmRKOUI0SjZJN0YyRUlwVWZFRFQrU0U5alpoc2FlVTlCeXU3RkJUM21k?=
 =?utf-8?B?NDI0RGtJWUI3cGZYOU9DYSthK1F6dlhaVmhuaWltdk94bkVGM0xYMnY3Tll6?=
 =?utf-8?B?QjVtQ0JaS3RKSm5IQWtFM0ZuL01sL2xFMitWWVA2aHVjWDNGNGlIZUZoS25O?=
 =?utf-8?B?dm5QL1NHWmd2bkR6NUFqb1hwQjJnNk1SQUJaRk9VWjl3MzQ0UmREelNPLy9J?=
 =?utf-8?Q?foYPxSrbWRhxH60yUf4vGIQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6535b1ce-53d7-4eda-861c-08db4db64788
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 22:15:48.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/PyvD7B3yH1o2JH7QYyOX3XCBQkU4E9VHArdxchD3NUyBnuYsD3ZxWcR4jU858Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7217
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/5 23:51, Guilherme G. Piccoli wrote:
> On 05/05/2023 04:21, Qu Wenruo wrote:
>> [...]
>> Exactly, the biggest problem is the multi-device support.
>>
>> Btrfs needs to search and assemble all devices of a multi-device
>> filesystem, which is normally handled by things like LVM/DMraid, thus
>> other traditional fses won't need to bother that.
> 
> Hi Qu, thanks a bunch for your feedback, and for validating my
> understanding of the issue!
> 
> 
>>   [...]
>>
>> I would prefer a much simpler but more explicit method.
>>
>> Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.
>>
>> By this, we can avoid multiple meanings of the same super member, nor
>> need any special mount option.
>> Remember, mount option is never a good way to enable/disable a new feature.
>>
>> The better method to enable/disable a feature should be mkfs and btrfstune.
>>
>> Then go mostly the same of your patch, but maybe with something extra:
>>
>> - Disbale multi-dev code
>>     Include device add/replace/removal, this is already done in your
>>     patch.
>>
>> - Completely skip device scanning
>>     I see no reason to keep btrfs with SINGLE_DEV feature to be added to
>>     the device list at all.
>>     It only needs to be scanned at mount time, and never be kept in the
>>     in-memory device list.
>>
> 
> This seems very interesting, but I'm a bit confused on how that would
> work with 2 identical filesystem images mounted at the same time.
> 
> Imagine you have 2 devices, /dev/sda1 and /dev/sda2 holding the exact
> same image, with the SINGLE_DEV feature set. They are identical, and
> IIUC no matter if we skip scanning or disable any multi-device approach,
> in the end both have the *same* fsid. How do we track this in the btrfs
> code now? Once we try to mount the second one, it'll try to add the same
> entity to the fs_uuids list...

My bad, I forgot to mention that, if we hit such SINGLE_DEV fses, we 
should also not add them to the fs_uuids list either.

So the fs_uuids list conflicts would not be a problem at all.

> 
> That's the problem I faced when investigating the code and why the
> proposal is to "spoof" the fsid with some random generated one.
> 
> Also, one more question: why do you say "Remember, mount option is never
> a good way to enable/disable a new feature"? I'm not expert in
> filesystems (by far heh), so I'm curious to fully understand your
> point-of-view.

We had a bad example in the past, free space tree (aka, v2 space cache).

It's initially a pretty convenient way to enable the new feature, but 
now it's making a lot of new features, which can depend on v2 cache, 
more complex to handle those old mount options.

The compatibility matrix would only grow, and all the (mostly one-time) 
logic need to be implemented in kernel.

So in the long run, we prefer offline convert tool.

Thanks,
Qu

> 
>  From my naive viewpoint, seems a mount option is "cheaper" than
> introducing a new feature in the OS that requires changes on btrfs
> userspace applications as well as to track incompatibilities in
> different kernel versions.
> 
> Thanks again,
> 
> 
> Guilherme
