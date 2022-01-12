Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF748CB61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 19:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356357AbiALS4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 13:56:22 -0500
Received: from mail-db8eur05on2105.outbound.protection.outlook.com ([40.107.20.105]:7137
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356336AbiALS4O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:56:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKnfpPNwfXpM2nVHbPjR6w0TT1xmngNDiw7wy8GYClwcTlJ98riagZENcsDrtf3cM8J+uVPhjE23TPUnLUj+mL/WhJeYRc27P2MF2dGhvzhcaHlKrCx93e0qlLzzPxhAFn0jy4mlpTo8AxatHudPZFcXHKIWchtCfPeCmtZ19ZmnVYtOBVqGWFzvaS3SCjOJnq3/LaaU3gzhycr3UtX6ANzYcFr5yuQ6oV6BygtSMV60zqqOuehtxahmpyXHS0TogdrHb3m6/mQtYshKDYskcbt0n7D4pCaPr6JwX2gYU9qAGPWYnJEMC+481+emWBboG6hS8+u5rD3fSfgAKPDl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz4NjDfOgK+QrexHRp/s3AsbtGiJ7JqQrnv3q7Bp/sM=;
 b=OuNQt7lIdVMDEuY0yYCKCnh31xQZr5PRFF0zPdnJiIwlO+yTZ1Dhj02omoOBkbV1vl2MUeIcZ+VK2op5ul8+quiJMqQO9KA33X0HHErmLzpse03+u+xOPtmILGX4mZQEiY/p5Aogo4rrh2Gb6saqjSEZ9SeOjX6UIZTjI4M9kCfvOIYN+vspzOCqOLyAk4iymXdiYUrxSoI+dnNfOODIzkZOU6Q2Ya2Os/uBGyuU+vt2HtsPp/H0VtsA/2YbxWrPaZS8m0S/MlSITJhG4FtO5zNt1cZseKpFFsKSHoJy/ffcGjhNE5jHvoZUjYR1LUeXPBcdgDe65Z9Q+2WtRtbbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz4NjDfOgK+QrexHRp/s3AsbtGiJ7JqQrnv3q7Bp/sM=;
 b=HdecFqYn5xQZOYc3CRfLgkR3yHNvzlQ3cydlAZyzAC/O+GwkYDTVu8pu+u6kIwdOJc0dxQG8/jdJ+xGRYZT69DqZP8hjcBJ83zhmtuywjCwKlj/5w+Pl66sOLtGOsdfytIJepJmhop83mmk1jx2sSMgUL4jHUbN/92A5K5g1ouM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by AM9PR08MB5889.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 18:56:12 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::947:5bc8:88ae:da30]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::947:5bc8:88ae:da30%6]) with mapi id 15.20.4888.011; Wed, 12 Jan 2022
 18:56:12 +0000
Message-ID: <011a03b8-81a8-9b0e-a41b-93d9dde12d5f@virtuozzo.com>
Date:   Wed, 12 Jan 2022 21:56:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143419.rgxumbts2jjb4aig@senku>
 <20220112145109.pou6676bsoatfg6x@wittgenstein>
From:   Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
In-Reply-To: <20220112145109.pou6676bsoatfg6x@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0502CA0004.eurprd05.prod.outlook.com
 (2603:10a6:203:91::14) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34c1af7e-12ce-4846-4499-08d9d5fd33d1
X-MS-TrafficTypeDiagnostic: AM9PR08MB5889:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB588946EA8E39242DF7BAAFADE1529@AM9PR08MB5889.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qh0FgTq9BVz0K09Sgu1jz2aq0D1udXFEJhT/Po2ta2Mv1I0y8u/3AOpOChOMQMTSkvlhNGuj4YD4Bs1NiAVZ6LzACl5YHuSQNVTH4LRAudZmq9V7rGuQRNN+CbSEEnlEezK+YNfRLbdkLxeS6ERZDKp3+r6ywYVJTX4smCImfvDUKNj9JfV4jkQC4wdOKDFsgVyPrLOibof+LpLvM087EVsOdZrbTgHpfkZmihbhndPKZqcbDBkNAorOpRgg2/ab8delJdbEj/PSYfZWUqKcAcVyIPweBlALasHMsWYPNh4WDhxWZcWmhUEd10IwKw9sKNm621zqRB8j0c6O5Znf4YHdWz5y+gBYIHhJ4Nv4NnY7bx3UaMPSpPFufEH93Tm1sIhz3gMSjoKbqZC0Z4waDpgyRiAfnfXwflQilbaKpyd1WRnXSMtms/EDQ7bayMSt+HyeZQU2LBpf9zQ3fyrSk2b+2qXIiBE7ncvhzUvjHSaSWpXvsJlsk1x5OE4M3ED9XhHvCviBxEVgEEdRodWhx3ERQOQOBfN9wo9eWn06TLvh8sZ9WpiT0uu8CSJWOU4B826RNbHBN0R1ae2hQFRZ2rmurU3pSNp0J+0NYHCPpDdwPoq1AeqEp68AtOpMq7z/Nn9itKHN8xj6YdHwqyNTKQnLl4IEGbxZ/fSN+M9NUmt24XW3Az6FQEj7SekK4rgyuwyAgsueOZWyLzSJHdCN2Xv/0weyQjmz3gdO/D0/HW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB5732.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(26005)(6666004)(2906002)(186003)(6486002)(6512007)(83380400001)(110136005)(31686004)(4326008)(31696002)(8936002)(36756003)(44832011)(38100700002)(86362001)(316002)(5660300002)(53546011)(66476007)(66946007)(6506007)(508600001)(8676002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHl5N0ZiV3B0Vzh2KzU2TDRXQ1pCSXdIOVYweWd5eENCdys1UjIxSVJDWFZz?=
 =?utf-8?B?QnZsRXBZc1M5cGhPT0J3VUdUR2xWRG9GVjNMbE92cWFzVUlNQk5LcndLT1Za?=
 =?utf-8?B?SWZMeVRKWFhYY2NQZm93eGY1eDdwODBHWVFxckdKMEh0ZzJaMjNxNnVML1BB?=
 =?utf-8?B?elJmQnJwc2RPclJIS3JhQ2JFMlBWdThKb2I3MCtnZXMzV3c0RE4xUWsxSmQ1?=
 =?utf-8?B?NmdqcjlvZWNBWGlod2JnM0ZFdUYrZ29aZ0NHVDNQaE1tT2xZUDM1NytGWjhq?=
 =?utf-8?B?b1JRV2EzY1E5SUZvcjdLZTB0L2l6WTh1ekMrRWl1dmFDT2VqV1IwOGtQWkpT?=
 =?utf-8?B?MG9ndW1VVHI5aHZQeEtRME5jTElGdGxjRjBVczZFU3AxVmNPL05KUmxqQXg1?=
 =?utf-8?B?dSs3ZGlYQXN5K1ZUanJ6bTEveTVZTkh4WFRNS25BMFlxTFZFNllZa0h0OFdP?=
 =?utf-8?B?STh1N3hscVBYMDlJTVJvQmYvV1ZBeDhGYTIwVmwybWZUd3llU3haMDNsR2tB?=
 =?utf-8?B?Um9zZWZ4RUJDVWlQMjBhemVDcEVLZk04WmViekpNTHFUWWJxTzZHTGNxSnBO?=
 =?utf-8?B?SUVTZkFoNjZkNVFhY0VUK3F0YnFWL004ZWZmOWVuV28ybXBXSEtsM0hFTVBJ?=
 =?utf-8?B?bUxTeG4yb0hxTlROaVlUc0xwZStGc2MzVjlvY3hKalNIYUVtSHpKTDhiWVo3?=
 =?utf-8?B?bEsybStjc0E5VXkwN29Nc283a0J1VTZUMlU5VXRHTi91clluUGl4eHZ2R3FX?=
 =?utf-8?B?Mms3L0NJWlFVQ1dKbmUyVmZOS2FSVXNBSUJtUGN0cnJ0Q1ZqSWZqWVM1OW5T?=
 =?utf-8?B?UjJuQ01ZK1VZVisyK0NPUEhRZmZOdC9vQ2pMSDBSSk5SRlR6M1BjeU81N1FZ?=
 =?utf-8?B?SUJjR3JTbytRa1JFK1cvL1NLam5OZVdZMWlyV21EUkxkamdITmE1OWluWkZu?=
 =?utf-8?B?QnpnbmJrQVp0dGp4SG1KRkEwcytvWnErRDFVOHRielk2NW0rRXZMN2lQMlp6?=
 =?utf-8?B?bVZmc3Y3dGNxWEc3N1lSM25vVnU4STRqYlRTU2FRMHZTMG43UlRPeGx2emxp?=
 =?utf-8?B?dkRJVUtJUHhZd2lzbkZJRWovY1Fray9jTjllR0ErdlZLdytKdDVkbjRoK3Iw?=
 =?utf-8?B?UlZoSG4xTXhJYlFPakgzKzBrM2hZSDFXSlZCK256VGNaSUM3ekhlSnUzeFd6?=
 =?utf-8?B?blZSM0ZzVUxBa1phYjZOcVVJaW16dXh4cHVwem9rSUc5bFJqV1hKK0xNdGZq?=
 =?utf-8?B?TzVidjB0a0RjK2lQaXdWa3I4R3hoUEtiNjhPWERQbTByczlXSDdXQWhUTDdW?=
 =?utf-8?B?UDdNWTZpNHMzQ0NLc2hNTjZyMkJKQUFoZGdnTmJoM1VGeWRjRGQrUHM0WlJC?=
 =?utf-8?B?eXhDbjVxOVE3VWNSdzFhWm1acHlsRk5ZbDRsWUN3dXhkVFB0OWlCTzhobGRq?=
 =?utf-8?B?NFVVN05WdDQvYk5IdWFrampjWDE2TzZZMG91UVlLaVdNcTR4R3F5ajN1elRZ?=
 =?utf-8?B?SGV3UThrZ1F0STQzMjU4dkpUUFVHS2FUaThaR1F3K1ZVcXF3dVVydUwxVkp2?=
 =?utf-8?B?a2dOSHhiZVJ5VHR1b0p5YUZobDEvc3dSeGNkQ05SczZRUlowWDRSUlZKQ0x5?=
 =?utf-8?B?bStnWFpwc0ZCSDZiN29ERFVuMzZ0MHF3VnZpemlQMXM0bTFCQzhCUFN0bHBZ?=
 =?utf-8?B?N1YwSTU2Z3FVelpGRUF3YW5sV3B6NUlQRTRQRDVGS2JGQ1FNMTBwR09HUlFO?=
 =?utf-8?B?VXBnejZ0MWpRdkxOKytEdFZHaWJsajNLaVUrUUhPbHYrU3NnUUt2UEI1aUJ0?=
 =?utf-8?B?MmcwTkpxQ3RVS29qR1gvQjNLTVFRdnNkT0tPWHlpc0JRZHh2WlFNNE5uN3hV?=
 =?utf-8?B?NXNnalB1ZlFyYlJtRklKOFpKQm5PTjROOVdPbHR4cWxvL1pYSUxhMXVqQ1Fu?=
 =?utf-8?B?OHd2bXNNTmM3a1hIazJlOWlMOUhkWW03cWkydHh2SkFFNTI4dTVyaDErcVY4?=
 =?utf-8?B?UmwxUGI4U1U1YlVKYi9uODV5MjcxcksrcE9OYkJuS05TZHB1T3AzMUpScXU0?=
 =?utf-8?B?UXJVZEJWVnFFUzNTOUJST1UyVUJoQjJ1T096QlJIZ2l3OFpUU0Z3N21ucFdW?=
 =?utf-8?B?OFgzUFRCNlMrU2ViRzNXc2N6K1UwUVRUK3A0U0V4MmRKTnRickRzcFFLbm1G?=
 =?utf-8?B?QVBqdFZUM1hnY0UyNHA4SSs4b1lEOTdwQ0Jkc051aG5aQmVPYzUzR1V5U1B4?=
 =?utf-8?B?RDNjWlpNYzcwYXJieGxaSS92Y3BBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c1af7e-12ce-4846-4499-08d9d5fd33d1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 18:56:12.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeksDSsRNfNZeHOEO+HIVNoMkJa8Z8mmO6UJ7xx77qj9SWUiIyrqyHfUOuaS4J/IPtt6cDpVJb1oqVAth5rrjeNT2Q/u+Juq6FIEnG4MsRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5889
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/12/22 17:51, Christian Brauner wrote:
> On Thu, Jan 13, 2022 at 01:34:19AM +1100, Aleksa Sarai wrote:
>> On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
>>> If you have an opened O_PATH file, currently there is no way to re-open
>>> it with other flags with openat/openat2. As a workaround it is possible
>>> to open it via /proc/self/fd/<X>, however
>>> 1) You need to ensure that /proc exists
>>> 2) You cannot use O_NOFOLLOW flag
>>
>> There is also another issue -- you can mount on top of magic-links so if
>> you're a container runtime that has been tricked into creating bad
>> mounts of top of /proc/ subdirectories there's no way of detecting that
>> this has happened. (Though I think in the long-term we will need to
>> make it possible for unprivileged users to create a procfs mountfd if
>> they have hidepid=4,subset=pids set -- there are loads of things
>> containers need to touch in procfs which can be overmounted in malicious
>> ways.)
> 
> Yeah, though I see this as a less pressing issue for now. I'd rather
> postpone this and make userspace work a bit more. There are ways to
> design programs so you know that the procfs instance you're interacting
> with is the one you want to interact with without requiring unprivileged
> mounting outside of a userns+pidns+mountns pair. ;)
> 
>>
>>> Both problems may look insignificant, but they are sensitive for CRIU.
>>> First of all, procfs may not be mounted in the namespace where we are
>>> restoring the process. Secondly, if someone opens a file with O_NOFOLLOW
>>> flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open the
>>> file with this flag during restore.
>>>
>>> This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
>>> struct open_how and changes getname() call to getname_flags() to avoid
>>> ENOENT for empty filenames.
>>
>> This is something I've wanted to implement for a while, but from memory
>> we need to add some other protections in place before enabling this.
>>
>> The main one is disallowing re-opening of a path when it was originally
>> opened with a different set of modes. [1] is the patch I originally
I looked at this patch. However I am not able to reproduce the problem.
For example, I can't open /proc/self/exe as RDWR with the following:
fd1 = open(/proc/self/exe, O_PATH)
fd2 = open(/proc/self/fd/3, O_RDWR) <- error
or open file with incorrect flags via O_PATH to O_PATH fd from proc
This is fixed or did I understand this problem wrong?
>> wrote as part of the openat2(2) (but I dropped it since I wasn't sure
>> whether it might break some systems in subtle ways -- though according
>> to my testing there wasn't an issue on any of my machines).
> 
> Oh this is the discussion we had around turning an opath fd into a say
> O_RDWR fd, I think.
> So yes, I think restricting fd reopening makes sense. However, going
> from an O_PATH fd to e.g. an fd with O_RDWR does make sense and needs to
> be the default anyway. So we would need to implement this as a denylist
> anyway. The default is that opath fds can be reopened with whatever and
> only if the opath creator has restricted reopening will it fail, i.e.
> it's similar to a denylist.
> 
> But this patch wouldn't prevent that or hinder the upgrade mask
> restriction afaict.

This issue is actually more complicated than I thought.

What do you think of the following:
1. Add new O_EMPTYPATH constant
2. When we open something with O_PATH, remember access flags (currently
we drop all flags in do_dentry_open() for O_PATH fds). This is similar
to Aleksa Sarai idea, but I do not think we should add some new fields,
because CRIU needs to be able to see it. Just leave access flags
untouched.
3. for openat(fd, "", O_EMPTYPATH | <access flags>) additionally check
access flags against the ones we remembered for O_PATH fd

This won't solve magiclinks problems but there at least will be API to
avoid procfs and which allow to add some restrictions.
