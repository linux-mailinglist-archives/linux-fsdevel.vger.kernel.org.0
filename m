Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A79A48D333
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 08:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiAMHwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 02:52:23 -0500
Received: from mail-eopbgr50121.outbound.protection.outlook.com ([40.107.5.121]:59255
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232335AbiAMHwW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:52:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy1ehPPWQTXByllS3PIAPaieYCXleKy957quSYHBezV1Gy+hSl7Nly/p3FOkWw4e5z4LGqlogNtafFYg7APiqdoNHCvUuZalFyfOhl8zbVYblJfCLiZmlD850L7EQC8j65rYMTz7xacI1nnIrPu8bPxvMvzD4OfaLr6reJajPpCqOPwi/G5Y3l4pkvj3DEo2e6ey8Kqbs+W63EV71s9g4H+iTFW51IGMTtYe1f5FHAXm5C8ibdXILE0W9UYrpQwcZMLysLVyFoFHGHVN9qRa7QKxLacCxMcone5ArxywQAB5tCYe2M8AABrFz8/7tIkTIHxrBeKTY8dcd02/DQ4xtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78HDKZu+kfoophbPxqBXUmkochZe9wOhlU1ssKVhYEo=;
 b=Ky9j8tZnyjkiLAxkf8An7oAbHRrNlD0jMPvn4or7QbPYohc+E27+b9BhQUNZLEKZqFfDSttCEUMCMbF+CU9xsP7eK9IEyYVDW/Jrak5XLrL/E644rD4Xk17bCFAabCxAm5FaAN9jyv7yUEW4wLKA29YOFNrE0UfG7sMgWDJ3yQs3rjOybM76o2kAADsd3831jdw6kYgQ01CyYFd9Z9EV66IKJ0Snze8kd/VsJh/QEQU19P28uYrijdyZNth2hq/DCGMMpHcAnByy1wgetOnvY0LHQlnlbPqgCcxAdjrmNxiBlmsGvP3wkeZrFCbhyZdr4dnHN3HYNV2iWG2lOlz22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78HDKZu+kfoophbPxqBXUmkochZe9wOhlU1ssKVhYEo=;
 b=aI2OfhM5K9k5i4NLzjiPN8ilq0JoEMfNTnAIhzZ1fVHWokogw/XBVlyDDxV91axFFJg0/SQdjisKsEuYxEHfLRhVaezy33AUqbBK0NslwTKbuN6txdpBLcpQNrSWg4fknDdY9Cq6WrIKLcBEaI5lL7btBjCVXG2Rajrn38Q23i8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by DBAPR08MB5782.eurprd08.prod.outlook.com (2603:10a6:10:1b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 07:52:18 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::947:5bc8:88ae:da30]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::947:5bc8:88ae:da30%6]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 07:52:18 +0000
Message-ID: <8452fb29-b308-df9a-c2d4-f0ad29b1649c@virtuozzo.com>
Date:   Thu, 13 Jan 2022 10:52:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Content-Language: en-US
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143419.rgxumbts2jjb4aig@senku>
 <20220112145109.pou6676bsoatfg6x@wittgenstein>
 <011a03b8-81a8-9b0e-a41b-93d9dde12d5f@virtuozzo.com>
 <20220113064643.dhhdhb7kw2qetyu3@senku>
From:   Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
In-Reply-To: <20220113064643.dhhdhb7kw2qetyu3@senku>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e36b1c02-8b72-4a5b-8c63-08d9d6699f84
X-MS-TrafficTypeDiagnostic: DBAPR08MB5782:EE_
X-Microsoft-Antispam-PRVS: <DBAPR08MB57820776A3DC3F808893EEC3E1539@DBAPR08MB5782.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzWz4SQ6IwW6dICUXCrloO7ilx53UiRb2wtUHrWvh7G1+CjjprP7bvjNPQe4cV/m4ZDDjpiAcdm5R079SVNG2PKDPSb1YS0LU/sOmFrbr6hEl9Vl8bj5PhX7+Bd1gx8ko/tQQ23/Ea9VwWcOLXeKoPnfBQlIFrrynOzBjFzJyv7wSCuFCFypWYnoyDkC+wvAjGMA0NR2MRHX9i4UPNssuB33hu6hi7ah8Q/1DStkr+tL5yjzq9DvaiN/gNFcYNit6NOSin3djIZM9aLX+hmav+QQRDQXbSupMqvPmfWDh3Pxs4HgjAsrHi4nMaJxtQpA7iMo31TbjF7UU9kaYCp6AsaMtaYlriyX1whDW9NujhpLfS92NcIctD0ioWU6JacSCET0AhYs52NSkl00sN1xemXdsMS8D1yxjubwimHlMhOcYIfYvZQRgm0lLOe3YdfwtgjNbCVrt/fSng9PFag3eT4t8H76wM1+1/RU51SXDgYRnRqMx9APwAFoiT4aHeYIOKCcpxA6gP6iJWEJuFaQV09FnzaZHb4EZ0x4/+kL0FdlYZClCZfstA15clndBJRej6MVL9nWvoI5SMuSx8o+BJGJes/se+c5u9vr7KIKbKtSJLpERKd0IM/8gDOlBni8fczkLxn8gbTEQy7zSUoPnC1k1d48L0Vn+N00suw8as6vR554C2z0GJGYccbiIE5XHkkpiUkiBZ2ln/U+ncbDWDP+FJUWRf/TiAuYqY9Rl/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB5732.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2616005)(6486002)(44832011)(186003)(26005)(36756003)(83380400001)(8936002)(38100700002)(6916009)(2906002)(4326008)(31686004)(53546011)(66556008)(6506007)(66476007)(5660300002)(316002)(8676002)(66946007)(86362001)(31696002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFxVmovb2hhOXFYNlF1TzBla1lhRldhZDdyZDg5VmpHQy9xZUxFWGxnRE9J?=
 =?utf-8?B?cnM1MWZwSExLSmFSMWZvY0RKdk02TlpITjFWQ3FaMC9aQVhJZHBCYTczSnJT?=
 =?utf-8?B?eEhuNXFEOWNkRXlVK0xwbmpwL0VDVlhhbUV3R1JTaVpjVWlwZkcxcGN6SWJY?=
 =?utf-8?B?djIvSlBrV2ZqWUdEdURXTi8yNUdERzJQdjlEZ0twVG9VbFp0QWRBamU2VFRI?=
 =?utf-8?B?ejJqWXM5aFhkZWFKQ01WTFhJcVMyZkc3WDIyTEs3MVI2aFVMVDhiclU1aVVq?=
 =?utf-8?B?ZUh2WWJxWGVvdmdneDRLejg5b043MWIwbGNPc0IxclcwRmIwT2dLaXhpeGll?=
 =?utf-8?B?UkFhdnQybSs4eVE1ajNOZmtzbC9iUVpYM0dwcTUxa3BCUEltOG5mU3g4dG9Z?=
 =?utf-8?B?ZGJVQ2M5dzJITnBmVXJJSnMwYjFyb3lUQVNFUXpabG0wcU5GSXZpNXFmdExq?=
 =?utf-8?B?Unh1QU5uSnFHbGozbHpwRU8xeW9nbFFjM2Z6K1V6SVlmSmw2Vi9Yck5GNkVV?=
 =?utf-8?B?VDJsT1ZJcWw5a2ZsdEsvTENNbTdGRmdCNEFKM1JENVd6OXlocnkxN3BBdTV2?=
 =?utf-8?B?NGtGYVo2VzQ1dTBUVDNVZ2dOQnppU0lmOTdpQW1pTTkzU0pMMk9uRktHTy9N?=
 =?utf-8?B?L0hxTnpINUZBdE13OUNWdVVFQzBRdmg3M045bzZZZ3lrcXZySUJRcW9CbzBk?=
 =?utf-8?B?REhsd0g1Q2dHV1F0NHM1YUQxelQrdE5EZ2dIVjFLbVNlZzZEWFFja00rYS9F?=
 =?utf-8?B?U2tsdm93S3dlSXBiT0ZzMjZnUUtzb1liUFFEZmFsSDcwVWJtVm5vcktKRVFG?=
 =?utf-8?B?czRsdU5BNWxVNEI4aGRzaFpxNkoxaEM3dERZN3AvUzZSc3B2SFBLYng2L0Z2?=
 =?utf-8?B?TEx0dXBEYmhQeGMwMCt2MGZmY0xXTDJDY1RyNzAyYVBlM1dyaHJIWFlIMmx1?=
 =?utf-8?B?Nkk5cDV5Mkx1MFhKb1FFcjV3Mytpa1oza3FXVVlHaHlONFQ4QlVEZWMwa0N0?=
 =?utf-8?B?UHlTQWRvakZqZUtVUTRUczhSYVhTM0tzSGZVN25lR0tmV3A5UE1JLy9GUkJ1?=
 =?utf-8?B?cXRxNTNaa295aTZsdTM5SU1DS0lzc2dEaFYzVHR4YjZzL0ZOb2h1M200am1M?=
 =?utf-8?B?cXUxU0FzZUtmTExhUEJFbjZxUmNZei91NWNnT2hDR3M3Y0h6OVlQV2tYdzli?=
 =?utf-8?B?Um51UkJuVHFsaHlnc1FBbnJEcU8wRERQVmFweWRHR3ZUTjdMNytIVGtIUGFR?=
 =?utf-8?B?K2pPNllmNnFDQzg1Zm1TNTdINkRtY2xFdkJzakRuMW1HeHF4NHlnUzRnUVNi?=
 =?utf-8?B?RnBCdmhoZ0xVU2t2M2k0OE51ekZCMW84WStDNC90bjlVZ3BHRStmb3MzYkRN?=
 =?utf-8?B?UFF2ZUJsM3JKTERPaXN4TU1jVjM1OEo3bWZpNy9ab2YySUx1QU52ZEhHSmVN?=
 =?utf-8?B?dW54REtDTVNkOW5sUXd5ekNDeURYdkFTSWRoTDdGWmJlc21VTFpRZUc5WGJa?=
 =?utf-8?B?MjJZUzJMa1FXdnFtSmFuN2pvNDVnWC9uZmpTdzhGRXdsNCtlaFVqb2pEMmY3?=
 =?utf-8?B?eFY4ajA1TUhkaDN0WE5JNEpWSG9TR201ZlJmVUhiN3Y3MlZWcGl0NXNvYndz?=
 =?utf-8?B?anNhemhrTGR3QlFHaXpBaUlkRDl4d1FTV1piUGxPY0k4YnVMbnN0UkRYNC9D?=
 =?utf-8?B?T2lDSExvT2U2QXg1Ty9zcGttUTN2N2FPNFdEd3ZSQzN2VllmaGlHOXFwdmJO?=
 =?utf-8?B?WG5LY1NqM3ZWZHU1SXlMYnhSSGEzUHZIc2ZpRXNPOEhTWVd1Ri9GaWpCS3dQ?=
 =?utf-8?B?NndITjhpZ2RxM085Wm1WTW1yZWo2V2NVclhPMWtacWNBTzAwZmliUkNreDQ2?=
 =?utf-8?B?ZTd4dDJjcXRNRjlBWHhBdzNrSVBDQ1lHMUd4T0p1cFZ4UlNFZmFrSzd0QUJz?=
 =?utf-8?B?U0NETFc1aDJXUnJBY2R5UU1iYkhObzBOQVlqYUNuaGNYSWFOcEsxWFRpekUx?=
 =?utf-8?B?Vm55TXIrRVJPYVJiTVNDc0FhMXdVUHdRNkFSNzAyQXlxMnhrMFd1RitBMkl3?=
 =?utf-8?B?UFJGK0VPMnVXV1dOdVRhN0FEa3ZoM093aGVEZVE2bXF0MDhyNVh4M2xDRi9X?=
 =?utf-8?B?SlFXcGhQSlVtbEswY2R6b3h5MXhzSHQrbzJMdWlIdC9JUFVwc0ZKU3dveS9q?=
 =?utf-8?B?UkZJditQRWNMU3V1aklLNnlHUjYyajdqMUdueUVrRGVlZ0p4RTlGRGlTQ1lO?=
 =?utf-8?B?ZnoxZDQzbFRQdXZWZmVzeWNhTWlRPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36b1c02-8b72-4a5b-8c63-08d9d6699f84
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 07:52:18.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qPER44XfrX7qolC/nwSLkaMqLoCuKddo3hki6HG/+Ix3beL26KhQvBsgkvOci0C0n51RBltGgWUfeG5Y+Coofq7C/I8SCssnnFzhvKpqZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5782
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/13/22 09:46, Aleksa Sarai wrote:
> On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
>> On 1/12/22 17:51, Christian Brauner wrote:
>>> On Thu, Jan 13, 2022 at 01:34:19AM +1100, Aleksa Sarai wrote:
>>>> On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
>>>>> If you have an opened O_PATH file, currently there is no way to re-open
>>>>> it with other flags with openat/openat2. As a workaround it is possible
>>>>> to open it via /proc/self/fd/<X>, however
>>>>> 1) You need to ensure that /proc exists
>>>>> 2) You cannot use O_NOFOLLOW flag
>>>>
>>>> There is also another issue -- you can mount on top of magic-links so if
>>>> you're a container runtime that has been tricked into creating bad
>>>> mounts of top of /proc/ subdirectories there's no way of detecting that
>>>> this has happened. (Though I think in the long-term we will need to
>>>> make it possible for unprivileged users to create a procfs mountfd if
>>>> they have hidepid=4,subset=pids set -- there are loads of things
>>>> containers need to touch in procfs which can be overmounted in malicious
>>>> ways.)
>>>
>>> Yeah, though I see this as a less pressing issue for now. I'd rather
>>> postpone this and make userspace work a bit more. There are ways to
>>> design programs so you know that the procfs instance you're interacting
>>> with is the one you want to interact with without requiring unprivileged
>>> mounting outside of a userns+pidns+mountns pair. ;)
>>>
>>>>
>>>>> Both problems may look insignificant, but they are sensitive for CRIU.
>>>>> First of all, procfs may not be mounted in the namespace where we are
>>>>> restoring the process. Secondly, if someone opens a file with O_NOFOLLOW
>>>>> flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open the
>>>>> file with this flag during restore.
>>>>>
>>>>> This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
>>>>> struct open_how and changes getname() call to getname_flags() to avoid
>>>>> ENOENT for empty filenames.
>>>>
>>>> This is something I've wanted to implement for a while, but from memory
>>>> we need to add some other protections in place before enabling this.
>>>>
>>>> The main one is disallowing re-opening of a path when it was originally
>>>> opened with a different set of modes. [1] is the patch I originally
>> I looked at this patch. However I am not able to reproduce the problem.
>> For example, I can't open /proc/self/exe as RDWR with the following:
>> fd1 = open(/proc/self/exe, O_PATH)
>> fd2 = open(/proc/self/fd/3, O_RDWR) <- error
>> or open file with incorrect flags via O_PATH to O_PATH fd from proc
>> This is fixed or did I understand this problem wrong?
> 
> You will get -ETXTBSY because the /proc/self/exe is still a current->mm
> of a process. What you need to do is have two processes (or fork+exec a
> process and do this):
> 
>   1. Grab the /proc/$pid/exe handle of the target process.
>   2. Wait for the target process to do an exec() of another program (or
>      exit).
>   3. *Then* re-open the fd with write permissions. This is allowed
>      because the file is no longer being used as the current->mm of a
> 	process and thus is treated like a regular file handle even though
> 	it was only ever resolveable through /proc/self/exe which should
> 	(semantically) only ever be readable.
> 
> This attack was used against runc in 2016 and a similar attack was
> possible with some later CVEs (I think there was also one against LXC at
> some point but I might be mistaken). There were other bugs which lead to
> this vector being usable, but my view is that this shouldn't have been
> possible in the first place.
> 
> I can cook up a simple example if the above description isn't explaining
> the issue thoroughly enough.
> 

Thanks for the explanation! I get it now

>>>> wrote as part of the openat2(2) (but I dropped it since I wasn't sure
>>>> whether it might break some systems in subtle ways -- though according
>>>> to my testing there wasn't an issue on any of my machines).
>>>
>>> Oh this is the discussion we had around turning an opath fd into a say
>>> O_RDWR fd, I think.
>>> So yes, I think restricting fd reopening makes sense. However, going
>>> from an O_PATH fd to e.g. an fd with O_RDWR does make sense and needs to
>>> be the default anyway. So we would need to implement this as a denylist
>>> anyway. The default is that opath fds can be reopened with whatever and
>>> only if the opath creator has restricted reopening will it fail, i.e.
>>> it's similar to a denylist.
>>>
>>> But this patch wouldn't prevent that or hinder the upgrade mask
>>> restriction afaict.
>>
>> This issue is actually more complicated than I thought.
>>
>> What do you think of the following:
>> 1. Add new O_EMPTYPATH constant
>> 2. When we open something with O_PATH, remember access flags (currently
>> we drop all flags in do_dentry_open() for O_PATH fds). This is similar
>> to Aleksa Sarai idea, but I do not think we should add some new fields,
>> because CRIU needs to be able to see it. Just leave access flags
>> untouched.
> 
> There are two problems with this:
> 
>   * The problem with this is that O_PATH and O_PATH|O_RDONLY are
>     identical. O_RDONLY is defined as 0. I guess by new fields you're

Yes, I didn't thought about that.

>     referring to what you'd get from fcntl(F_GETFL)?
> 
>     What you're suggesting here is the openat2() O_PATH access mask
>     stuff. That is a feature I think would be useful, but it's not
>     necessary to get O_EMPTYPATH working.
> 
>     If you really need to be able to get the O_PATH re-opening mask of a
>     file descriptor (which you probably do for CRIU) we can add that
>     information to F_GETFL or some other such interface.

That would be cool. In the patch I saw new FMODE_PATH_READ and
MODE_PATH_WRITE but there was no option to dump it.

> 
>   * We need to make sure that the default access modes of O_PATH on
>     magic links are correct. We can't simply allow any access mode in
>     that case, because if we do then we haven't really solved the
>     /proc/self/exe issue.
> 
>> 3. for openat(fd, "", O_EMPTYPATH | <access flags>) additionally check
>> access flags against the ones we remembered for O_PATH fd
> 
>   * We also need to add the same restrictions for opening through
>     /proc/self/fd/$n.
> 
>> This won't solve magiclinks problems but there at least will be API to
>> avoid procfs and which allow to add some restrictions.
> 
> I think the magic link problems need to be solved if we're going to
> enshrine this fd reopening behaviour by adding an O_* flag for it.
> Though of course this is already an issue with /proc/self/fd/$n
> re-opening.

I think these issues are close but still different. Probably we can make
three ideas from this discussion.
1. Add an O_EMPTYPATH flag to re-open O_PATH descriptor. This won't be
really a new feature (since we can already do it via /proc for most
cases). And also this won't break anything.
2. Add modes for magiclinks. This is more restrictive change. However I
don't think any non-malicious programs will do procfs shenanigans and
will be affected by this changes. This is the patch you sent some time
ago
3. Add an option to restrict O_PATH re-opening (maybe via fcntl?). And
make it apply if someone tries to do /proc workaround with this exact
O_PATH fd

> 
> However since I already have a patch which solves this issue, I can work
> on reviving it and re-send it.
>

Why not if it only makes it better
