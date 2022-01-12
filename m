Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C348CA12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 18:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355916AbiALRp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 12:45:59 -0500
Received: from mail-am6eur05on2119.outbound.protection.outlook.com ([40.107.22.119]:40192
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240289AbiALRp6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:45:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDM0CRVcQXPaaX48RM/Wcp87PavmqSbez/ITO5iUQRxz3u9jOYNyRNXx4ocSF5mKBHvrdEq31NQm9RHdQ2H15K2HfmitDRKIdxrkNAQAA5ZhDNc/0jJ9Pp3/AE9Rk9uJnl1OABjMA5U7k2XVE/33I7+CaYxUZMGNmZEX9ME7qsvl6p02Dv/8WESSCU89Wx+xDMCeip7YjyGpK1R4gZ3r0DOdQPMWUTJTbF7skRJ5F9Qcs5QUODzJXXiLT6Cq8pL9V1IMsasLQZeCwttm064SR4qJpFzIhJdKfQW5/QdhS+Sit3oB4xYL5gH1VVOfAnkguG3zH4QsJTBvYMom+pX3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKV/Q2F301+8cdhLo6wC4niOY2V9cn/UUo8lxlgCMYM=;
 b=mNZCjRiIWfXVwTgNnrTCqPEBSdNli2xAo8wv4OI6bfzDqaapQ+VKVENDTrVrTjY0c/B06XYoeeYJFob6Eta5u+5b0c4x9AawNlS/43PivGVtmOn8BUA0fFSE0L32R4pVem/WX66W2LFGjBhU7e9okh/8EbgOd6WOrn9wccBTcC/dVyClPJhctBvoseM+uvNJoYJUn/APICIc0JSLxkVSQtRwHLs/H2qMW5T8YzKNJqEhG+vb42BhzlWMlq2CP8eE0OldEY2e19n97fsZ5lkFBcER1+eI1b3lBcqKsQDv9QC4XMgW/aBsuBYQYlspPC0p2U6GJRu+GSfnKrPZ0c5z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKV/Q2F301+8cdhLo6wC4niOY2V9cn/UUo8lxlgCMYM=;
 b=VPl1MsLOeXC4iPAhhx/boNgp0ZCNCCpVubh/gFSd3fgMKqhrhpSJeTR/SSPZq8fNYEQz+zNU+WjxY4LPQKLANkd4A82xbsPgOBb5vtpfjeCQGNUg/8+4TyiiEJ1Q983JJebYC7ImXU8yqmkJSv7RqqqVzPNI2N1oFE+gL9iFWFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBAPR08MB5734.eurprd08.prod.outlook.com (2603:10a6:10:1aa::18)
 by DBBPR08MB4630.eurprd08.prod.outlook.com (2603:10a6:10:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 17:45:56 +0000
Received: from DBAPR08MB5734.eurprd08.prod.outlook.com
 ([fe80::504:1bb2:1755:2095]) by DBAPR08MB5734.eurprd08.prod.outlook.com
 ([fe80::504:1bb2:1755:2095%6]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 17:45:56 +0000
Message-ID: <0140c600-89e2-6be7-2967-f4b13b0baeaa@virtuozzo.com>
Date:   Wed, 12 Jan 2022 20:45:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143940.ugj27xzprmptqmr7@wittgenstein>
 <20220112144331.dpbhi7j2vwutrxyt@senku>
 <20220112145325.hdim2q2qgewvgceh@wittgenstein>
From:   Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, ptikhomirov@virtuozzo.com,
        linux-api@vger.kernel.org
In-Reply-To: <20220112145325.hdim2q2qgewvgceh@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::35) To DBAPR08MB5734.eurprd08.prod.outlook.com
 (2603:10a6:10:1aa::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f03f83de-266b-48dc-0b58-08d9d5f3629c
X-MS-TrafficTypeDiagnostic: DBBPR08MB4630:EE_
X-Microsoft-Antispam-PRVS: <DBBPR08MB4630CCCD10E0E14C04E14ED9E1529@DBBPR08MB4630.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6t9Ozzb4KBz5uewUb3ZjQQHLI8k2JO98SlWzKtk3BWXJwUpbfy0sEXhzCL54WNknO79v63vkXaW33CR7v6rYBnncN08VKpE9XViV0e8w+nSmnSY56c3i5y6QdJ6JYOxeODMmEs9qjQZmNPQhTd619VFxko4sNusOCJaV8CI30Se0YH6iVpnt1HsUFU46YrM3wjo7QMtY1v6jTU0EHg9BF10q/TP2d1J1Vw7GwSjTMvigTjVEeBRNdyxrfIXUXjK5JmUHUapyxIiAFZ1Ng/Dm6h2m14h1wlkOJWmjkCg89BczL6aJ76HbaoRJjDdocu68D/khBTYzdOivZ0L1hsSkk5BC+V6JcHTdiXMJzIizVs2Q8GolWqPpSof7tBFPK1vzUivHMOv8bYNFj1DH4Unwn0/aBI6s1g6aayMlGBaG6KIdQQf8ZpCkdPBL18Sk/NI+CSpOiWZY/MxTLSH7zcjXMrBb0XJxGAYnfBFeAY9vWLYJIwfPlSs3fH/eyKuba3DAPcsJTj7Uu+1MseYpsiIZrC2g9+oFGjJYPY/XRUJv/Z5kE8XXMTsgm4ZFlSnIbmYQOV51g/zO9op0jPxI5uP3U31/7QTN1jdoQUuWNqd169JJ4W7En+9FF2Xh8nLtsq0Em0Of5sHcx/s33BD2ODUt4KV+BsN6V9Qd8TIjHFtwPCXIU8a8Z5sn1MVpTn+USNmN5ONlwISYAWTCZJGZdbMDvnrHjGPHk6F4TR+BTryTFK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR08MB5734.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(8676002)(38100700002)(86362001)(186003)(508600001)(8936002)(316002)(2906002)(31686004)(66476007)(26005)(36756003)(53546011)(6506007)(31696002)(6666004)(83380400001)(66946007)(2616005)(6486002)(5660300002)(44832011)(6512007)(4326008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFJLMFZGbkFaNWpvbTllQ1h2aDhudVVhYUZrb3UrclNoNVBGTVk0bFhyOGhR?=
 =?utf-8?B?VnU4Tm5PQUNZL2l1bE1nYkdxaHRseGdseG1VblJzRDhLbjM3Ri8waEtYL1Bl?=
 =?utf-8?B?eFFMbHJYRFh4ck5PTUhUOE5IdWZzeVFZajNwN2hVNUh5d1U3eVVKdVlNalFy?=
 =?utf-8?B?ZnN2dUxVc2c0M0J6bVFIc3R4eEk2bVN5OE5rWlMyeXpuK1NXL21JQlVWWlhV?=
 =?utf-8?B?WHUyMzZtWnZDVFBneWp5eGpvNXpMdGxQSkc5dGhFeDJUa0xDRENDRXA5eWVX?=
 =?utf-8?B?RnJaeXp6TnJwbUVkQTZ0WlhaUmRDY1FDcXlQelJTZkpmVkltckQvdk1HRXM0?=
 =?utf-8?B?R1IvZ0ltRjNuem0yU3hLRFU4QnpWL1YwQjcraGE5aTNOWDVweTllQys2ekdB?=
 =?utf-8?B?R0dwTCtPcTRRRXlMRHdzZ3VqL2FBSDBDWlorWXVzRlRFaEVuVFlOb2xzUXpy?=
 =?utf-8?B?cWM0Vzg2KzloVUZPMEVSWDdtRjFsYUd1M1BCSmxvU0Y1U1h4Y1NtV0dTMUI0?=
 =?utf-8?B?QXJ4OWtFOHU5UURMY1VFR0E1QkNLbnRlSzg3N3dNVEEwL1M4d2V5dXFsTjF1?=
 =?utf-8?B?VHhNZWdaajNkdUpTLy96WmQvaEVNT1lnK0N2YjZ6VmFkNmR5SnhweGNxeU5K?=
 =?utf-8?B?YTJIRHdzNGoyZG5RZVJpc0lNWmZkMGxxYUZ0S3l3VS9ETXdjRi9BenhjNFB3?=
 =?utf-8?B?Q2xrOFFBNXlmWXR6SnRONWNLVElqVml4cHlJM1J3UGJHYmo3eExRRXhudk5D?=
 =?utf-8?B?eVpwNDUwM0ZMV2RYeVhPTDZadGczdEdxRUlhSUtsM0VRTG5qTFEydEx1Z3FQ?=
 =?utf-8?B?MDB2aFlPTCs3dzR0RWduZ2NmVDQyOGhrbFlQY3JHZXk4VHE5cTN3QzN3aU5G?=
 =?utf-8?B?aERxMXl4VkdlRUlHUXJqQ2pkVHhmZzlmU2ZqbHYybkJEdmwyMDJIbkYrbS9D?=
 =?utf-8?B?U3dXSVdVRDM2MmVMbWQ4OUNGenV2V0Z2Vm5RblpKTWpZaXE5bjNWeUNkeG1x?=
 =?utf-8?B?bmo1QWVaYUs1VmtUVkFkaEFZa1pHTlpjdUorOGszUTdyb1NjaVY1QUErMDd5?=
 =?utf-8?B?SkZnN016MmI0dlB2cmIraEZHSG9UTkd5cDFFV21UbjI5RFAxSGlOWE1mdHRr?=
 =?utf-8?B?TG9IanJidnAwaDNjMGNCYmk0NDdqNEQ3Q2RxR1VDSk11QVFRTjBhWFNoWXkr?=
 =?utf-8?B?dVRib2F5S3JVZHNTWGxlUGZIb3VqNXJFcEhMZlVkOFl1UGl0Ti9UVGxwMHBG?=
 =?utf-8?B?ODh1dWtpZTVuWVRNMW0yZ25uZkNWakxkRUFvTTlid0tudXZ1QWZ3THlMdnhq?=
 =?utf-8?B?Y0lLcXFDWFFESXR3UVNITUtlWHpMSm1zTjJoYnN0eGt5MlZFTWljTU4veGdP?=
 =?utf-8?B?UEt1b3RuOUtjdW5nd3BjOW1DTk5YWllGSTJPeWs5Qnh3ZXFwRVcxTVgvS1J2?=
 =?utf-8?B?b1htQ1pxM2ZGZnkwaWpQWlhQc1ZyeWxWZkJaMEh6Q3Z3K2lHUktOanI3ZkFQ?=
 =?utf-8?B?NlpiZGtnaGcxVUcyRGVWbFppVkRHY3ZObXE1bk9OUUpwQTc4UEJOUENGWGk1?=
 =?utf-8?B?bFZYUVVkams2TnNtbWVwYU5VYnQ3c0draTdtUm5QOXBUTWdiNXdIZGVpaitj?=
 =?utf-8?B?aW04QVVpalB3YjVDU3BPQ1ZmY3RxYVMxM0U3OW9RaDNxTjQweDNpQ3ppc1VW?=
 =?utf-8?B?dnBQODhFSmJCdjhtRkJ1aDA4U3ZEYlBaRU5TbmxNd2RvTm1NdkhacThoTUlY?=
 =?utf-8?B?R3BJc3BhdDlUN2tOUTEyOEhDS1dkR1lGTGxxSWU4SHhXNU01dFZKK0QvZGVv?=
 =?utf-8?B?aVhaU2VxTUhxeEZNbTVURUc1SEhtWHJiek4xRnppM2Y3c25Kang2QVJKQUJ3?=
 =?utf-8?B?R1QwMjk5ODF1T0RtN3FpOGZFRGRmTHdUbUdFeDV4RDVDdkxzSVUrV1Fmd3g3?=
 =?utf-8?B?dlNDQXg4alUxTG5jcEtmUzNjS3BUcFpzUi9OZGNhMFpaQTlna2hqS0duLytO?=
 =?utf-8?B?TjRsVjAwQlV6eVEveUE4R2ZGYjY3ajJWWmN4YjRXRUpsVnBad0NGdFFpWmhG?=
 =?utf-8?B?SS9Qb0NnVU1nbDlla2NTaWJiaVlRWDAwZ1pvcWdXRnR2c0dzT2EreWU0TDNM?=
 =?utf-8?B?dzdQQUlaZzhtZmZXdHFVeVlmaEtYU0NnZmhhcTRMUDk3aVR5SllWZUNUajZ0?=
 =?utf-8?B?ZUZ6N2Z2RTNpM2ZRcmhFOXlTbW5MWlptSHU3Vi9GZUN3YTN1MXNnVERyTWV4?=
 =?utf-8?B?enVHT1FhU1A3aEh6M1h5cDdQc3B3PT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03f83de-266b-48dc-0b58-08d9d5f3629c
X-MS-Exchange-CrossTenant-AuthSource: DBAPR08MB5734.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 17:45:55.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNZcRl6rfTbrYpLhsfRjpYfbNBeBsNSiNhke+Cflz5OLq7bcgeMSvGEV8oK9XFunKdl/sfkigVqw3WtB4uL57fmZmnjBRebDiN1D3FsuC2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4630
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/12/22 17:53, Christian Brauner wrote:
> On Thu, Jan 13, 2022 at 01:43:31AM +1100, Aleksa Sarai wrote:
>> On 2022-01-12, Christian Brauner <christian.brauner@ubuntu.com> wrote:
>>> On Wed, Jan 12, 2022 at 12:02:17PM +0300, Andrey Zhadchenko wrote:
>>>> If you have an opened O_PATH file, currently there is no way to re-open
>>>> it with other flags with openat/openat2. As a workaround it is possible
>>>> to open it via /proc/self/fd/<X>, however
>>>> 1) You need to ensure that /proc exists
>>>> 2) You cannot use O_NOFOLLOW flag
>>>>
>>>> Both problems may look insignificant, but they are sensitive for CRIU.
>>>
>>> Not just CRIU. It's also an issue for systemd, LXD, and other users.
>>> (One old example is where we do need to sometimes stash an O_PATH fd to
>>> a /dev/pts/ptmx device and to actually perform an open on the device we
>>> reopen via /proc/<pid>/fd/<nr>.)
>>>
>>>> First of all, procfs may not be mounted in the namespace where we are
>>>> restoring the process. Secondly, if someone opens a file with O_NOFOLLOW
>>>> flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open the
>>>> file with this flag during restore.
>>>>
>>>> This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
>>>> struct open_how and changes getname() call to getname_flags() to avoid
>>>> ENOENT for empty filenames.
>>>
>>>  From my perspective this makes sense and is something that would be
>>> very useful instead of having to hack around this via procfs.
>>>
>>> However, e should consider adding RESOLVE_EMPTY_PATH since we already
>>> have AT_EMPTY_PATH. If we think this is workable we should try and reuse
>>> AT_EMPTY_PATH that keeps the api consistent with linkat(), readlinkat(),
>>> execveat(), statx(), open_tree(), mount_setattr() etc.
>>>
>>> If AT_EMPTY_PATH doesn't conflict with another O_* flag one could make
>>> openat() support it too?
>>
>> I would much prefer O_EMPTYPATH, in fact I think this is what I called
>> it in my first draft ages ago. RESOLVE_ is meant to be related to
>> resolution restrictions, not changing the opening mode.
> 
> That seems okay to me too. The advantage of AT_EMPTY_PATH is that we
> don't double down on the naming confusion, imho.
Unfortunately AT_EMPTY_PATH is 0x1000 which is O_DSYNC (octal 010000).
At first I thought to add new field in struct open_how for AT_* flags.
However most of them are irrelevant, except AT_SYMLINK_NOFOLLOW, which
duplicates RESOLVE flags, and maybe AT_NO_AUTOMOUNT.
O_EMPTYPATH idea seems cool
