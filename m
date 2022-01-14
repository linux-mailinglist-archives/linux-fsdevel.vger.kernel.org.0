Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E42548E342
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 05:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbiANEYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 23:24:35 -0500
Received: from mail-eopbgr60116.outbound.protection.outlook.com ([40.107.6.116]:62437
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239157AbiANEYe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 23:24:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM62wP5D1KRX10n+3m9DFRFhSHtDYtQBqhk9abIspcY2Ne2UU8aSvQy2IS+cith4+DE9Q1BN2SfUa+KuaphbioP7c0ITp+ms59c70McO0jTjsFk0sHtCQcoDtVmSM/+4mGv7o5U/mcO0NNxaxCr6wluKUjodxV8YCjULTxcRlLs564J/4Vcchv9H6HOqIRbpLUghCEX73zNW3U9ZFtP/kKdAWrOgrWhHvmihT5d2pb5a55WoBf8JoQpYR9y0XndQBIdYbAaIn9HHMAOy7Ew3bTmG7ASdrPYVjr6DNfaMHjDCIXCn+J56LhA5OkW3t4dJ+iajEOmsRNi2LrpkDMnGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJhlvqFver067c3fR4wji8k7z8NbpPOgsqN/BcxleZs=;
 b=geVwf/yeZBDWhnbZCax3/S+tdiH3h02hs30LR2DJBZJKK6I9eVObaFNu59FqqHZSsEoQc/3Lvdql28WTzkl8aeAhURaodZVW/wPie2VQ3EwPIgdVITSUjT5HxL7rDLPB/imOokmycRlSha/TimH8y9lAGz7tScNVwbntjbs0g7OuiEA0l3LgYTUbYT0jhfyhhRyEDSpueq6v5urf5JA9543SIDcb8GUwfToLV4+0qEyxUcCRFn0iaRD1xXeDjIcETl/ej/lg8o/7JhDTxIJRAAViut0G103NXxspqNxdaVbvivE1pq7BV7MUwddnOXzXI6SXmZJ73um1z9V4afsFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJhlvqFver067c3fR4wji8k7z8NbpPOgsqN/BcxleZs=;
 b=SyV4/A02srvzbfJkUGTNlgxdNgVLka7RIePy0xnihG7BPmCstYsF+2bC68+ykI765DuxZrMD6ZqEmzZjcSe20pWKT9qa5q5f3gVI/EMAIiurgMAcq3F7Us/RFtdAebygnMfsAtlOXUPaXL+UdU7wuV4x7lUj+AVDZYjbXHYVEIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by AM9PR08MB5922.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 04:24:31 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::947:5bc8:88ae:da30]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::947:5bc8:88ae:da30%6]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 04:24:31 +0000
Message-ID: <f1128946-5675-7d8e-e475-d889dc7f5f80@virtuozzo.com>
Date:   Fri, 14 Jan 2022 07:24:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Content-Language: en-US
From:   Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143419.rgxumbts2jjb4aig@senku>
 <20220112145109.pou6676bsoatfg6x@wittgenstein>
 <011a03b8-81a8-9b0e-a41b-93d9dde12d5f@virtuozzo.com>
 <20220113064643.dhhdhb7kw2qetyu3@senku>
 <8452fb29-b308-df9a-c2d4-f0ad29b1649c@virtuozzo.com>
In-Reply-To: <8452fb29-b308-df9a-c2d4-f0ad29b1649c@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR08CA0002.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::14) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 378f8ead-69b9-4951-b76a-08d9d715c2ec
X-MS-TrafficTypeDiagnostic: AM9PR08MB5922:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB59227D821705B149C5ED05E7E1549@AM9PR08MB5922.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iJfHpFHUYeiBDmhVA/1hT/01gO3q0IyQMTXxv2jm2b9IeJdTZ054Sq3kHmgIDKMbBbytJ++KIHDfDOKK8z4DKHOcAkJcZMvYHAO+p2u6FYxn/NiMJq0OzGBylHFAOvsr2Xj7Sz+WMcp7wmE2nuLrDxBapizZJBURxsvMGoOKsKD9Yl5KZDPGxVsPz5JOBReezaAihuNHps+KLTv4uPAzbLawBNW+/IjXOi20Af4AkwIdFHnAHRk40BTmb3mfsUWFgu8TJ1fGc2NCcjbY3kIEbUfhlDLqEUzcDs9G6ceQuRfpz+g4WIPDTOFlQMircSKVOnGYKAt/eJRgd7tvK+Z4NreEr3PsKVN8kEcPj/YvLM2qf5b74Di1OUf/vz6fSeOC4QRgOzJtlsBBljLm5cZOWqWlYD1F02BgmF13DpkZz8cvD1Pz2vib74UlWs8UJ5hCXGsJ7wnqOLozcANmjhsjJroZXNLwU1bWuK4dwxKRW+o1ta2A0Xf0jdAiTLRhRplC/sUBma6sddKvn1MvAWDN3TT2ki0HFoEdDx+Jh2iVNzTZv3cRQWKh87Zsfre3Pga5hAgl+fT97SbaME/JC/hXXmZxPOUqztC3kJfLhuJp4Ov1s7RhQDKQyPAQ0jLbR21BcxiNDzhXVKUrpJHwBhvqWEpI59YT0hV7Bffoc94+oUNR/eWzMDqEHA/fpWEvWLcJDGaqJyL2+7kEqEXDlhumqiooxgP/SMAdyjFM5Eiu7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB5732.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6916009)(508600001)(4326008)(86362001)(31696002)(38100700002)(44832011)(83380400001)(186003)(66946007)(26005)(316002)(8936002)(31686004)(53546011)(8676002)(6506007)(6512007)(5660300002)(2616005)(36756003)(6486002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGtQM3ZwNUxrOXBGdUhKQmhISGRGSm9qcUpEdlY5TVY0V0hOY0VvSEliY1F1?=
 =?utf-8?B?cmRTTUpkQ1FYZkdFNnkvem5ZWlY4OElDclF4Wnd2RWVoK2tiTnFMOVF6MWIv?=
 =?utf-8?B?bzhPeVJFaCtGSXMydlJwbnZBRDNlSHFQYzJZUkFnSFhha1BQVUllRENyd0VT?=
 =?utf-8?B?RHFMVldscGVDbHNHeStYNEwzNEl1WWR5NWhHMXlJVG03Z2pJUzhSMER6cWFN?=
 =?utf-8?B?VW9kSUVCRFJQRTJzSGhNUVJCS05vUHpzNFlNV3pFYVdPa3VscjBtTWFVM3Ew?=
 =?utf-8?B?N1o4OFJZVDRkb2g0aXBHSWdUY1c0MVBFN01YdUVWVXlZL093SThZZTZvWURU?=
 =?utf-8?B?ZkR1RXFnV1NPOSt3NkR5OGg4bHFDQm5IYlRsYm9qRWQ4blIvcjgreXVHcW9p?=
 =?utf-8?B?UWJGdUZyWDJjWkUzNlJhQldiYnBUOHB0QkpodkJpakFVWjdnTi95dUdTM0ow?=
 =?utf-8?B?ZDhkTWRkQmsxV01oTkhZY1g5UkcvaWdlUC9jZ0F6VWsxeittdFBDaitXMWhw?=
 =?utf-8?B?VHFHS25Dcml4R0pRcnNOL1J5UkF0UW5hc0JMaUw1K0JlL2hFeFVuVThGcXRt?=
 =?utf-8?B?V1NYUGdwYzZ5TDgwWW5aSVEvSEhqTUY4YStCOGM4UEdZUWxKcVNnL0ZmRlhn?=
 =?utf-8?B?K0Jvd0E2a2w4ZCtTb1gwaGxJa1dPT1creUpHK2xaSEpkRi9kdGViU1Y5OXVG?=
 =?utf-8?B?aUxTYUVTS25tMFF3WGt6WURaMW0xNHdRRzNtZUF0VXZGbjUyMnJRY29mNVJ2?=
 =?utf-8?B?TU5mQ0pjd2sxKzFlcW5aOWNBZWxLOGErQmIrdVJwOFdDeGdVWE01N0M0ek5u?=
 =?utf-8?B?Q2pOYkpnZ2xsTHNJR2pMWnV5WUVhRExrWEZYUmtaZU9XK056S2hZUjJsWDQy?=
 =?utf-8?B?Q0dpM0dJQlBkWXc4b2JLcXFxMlFRdVVKTnpIaE5hZDM0NFlIb0VGY0dvRDJV?=
 =?utf-8?B?OG1yZXduL2RoMjFFT081alVQMXdub1UwYXVFelQrcmVHdDRBTVFPRUFIZ0xo?=
 =?utf-8?B?R3JpbnEzUUQvL3ljMXc2L1J4UXVwejcwaERVN21xZjVmMzBPK0tseTBta2Q2?=
 =?utf-8?B?ekFMbUJoUmdzOE9XVS8rRG9kaDJRdGJQUFdRNmp1OVFkZ29uRTVaRmNyeDVI?=
 =?utf-8?B?QmFTVmVmV2d5dHV5K3doZVdGdVVDUzBqK1RyQ2h1R243cFB5M3RSWWRqSG40?=
 =?utf-8?B?L2ZVOGFsaU5aVnAvcFlKUXRxZXJEOVA2VDE3OW1xd0xlVUxEajBGS0labjR2?=
 =?utf-8?B?N0s1QjBVYWRMNnh2eDFHQ0dQZlVic1YxVDhhdXUvbGhGRWZweUp5LzI0ZS9J?=
 =?utf-8?B?aktLUEsreUN5U1hNS0ZuVitmWVc1VzZ6blZReUtNVXJ6aW44ckFMNmhiK2p5?=
 =?utf-8?B?N0gzUTl3RkZGYTJKcml2SGpxeXd4RGxVbVE2Z3FFaXArekVQb21QL21GMEZi?=
 =?utf-8?B?NVNGTzY0NDF5M1FNUTAyUEs4bjZkTk9sbzdpa281WmNsOSthR3lJRWcyalc0?=
 =?utf-8?B?Wk1ma2ExZ0IvVjVYK1hOSU43WllUVlNhck5FRTJyL0xrRnQ0cnE4KzRUKzhs?=
 =?utf-8?B?RDdnQktsTDZaalVZZ25FSkQ1TmlGTkI1NWtZZ3NTekdxNi85b29zcXM1OVZX?=
 =?utf-8?B?aFV4cGhDTHZ0N0RtOUorcC9KdENOcTQ4ejFweGczcFpySHhXamxYazEvOWwy?=
 =?utf-8?B?VXVzVG9XUGxydVBrKzFVSHJIYWJMVWUwZ0xVZlhJdUVkMkFKSDB1UkFXSkpD?=
 =?utf-8?B?ZWhqRFBwOHpCVGY3bnVqeUV5OHlXS0lBS2EvaDYyaFNNZ1BUbisyNHQyOHNL?=
 =?utf-8?B?eE8wQUE2OTdYZmRMcGNwM0RCWU9xOXRJZGxObHRtOCt0ekVKa0JOYms1SFBy?=
 =?utf-8?B?NXhEQS9aTnRnKzVqUlV4dm9zeHhPVnlYaERpWXBGQVRkc05PRzh1N3BiZlRs?=
 =?utf-8?B?WkZIRmQxa2tONmhRVjRleTRYK3pUU3FhR3F2eWFMY1FQVTJjaXByOG5HejRQ?=
 =?utf-8?B?RHVGQkpUOEVhVUdSNXFDMHFMcTQvUnBPNkt0VHZJZG5WVGRWNk91VEJxUDVu?=
 =?utf-8?B?cHVZZC9PTFhUSll0dktRQUd2ZlNVQnhQMUpPckhQa09UL3pHS1BzZ0NmYkd4?=
 =?utf-8?B?UHgxZFpNTTlRSVVqdHlJempPNkVLRndTbi95akR1V1JzYUQxK29FNnhja3pS?=
 =?utf-8?B?SkF4ZUN1OGthWkkvYkhpajBhSllncDZnaVZDVFhhNitFMHduL0JOWTNySmE1?=
 =?utf-8?B?MEZoeEU0SUg0d0RxV3BEKzFKMWdnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378f8ead-69b9-4951-b76a-08d9d715c2ec
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 04:24:31.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCWvD1Wsb4Q98EpMurh9inonIsjFcDJUFabFS7r5Bwuny2tJ2GkCLJcyYAGmbLPUkdA0ZzVoWOqVQk62P7lTg55pjqrUpr4hgrT31imYZms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5922
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/13/22 10:52, Andrey Zhadchenko wrote:
> 
> 
> On 1/13/22 09:46, Aleksa Sarai wrote:
>> On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
>>> On 1/12/22 17:51, Christian Brauner wrote:
>>>> On Thu, Jan 13, 2022 at 01:34:19AM +1100, Aleksa Sarai wrote:
>>>>> On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> 
>>>>> wrote:
>>>>>> If you have an opened O_PATH file, currently there is no way to 
>>>>>> re-open
>>>>>> it with other flags with openat/openat2. As a workaround it is 
>>>>>> possible
>>>>>> to open it via /proc/self/fd/<X>, however
>>>>>> 1) You need to ensure that /proc exists
>>>>>> 2) You cannot use O_NOFOLLOW flag
>>>>>
>>>>> There is also another issue -- you can mount on top of magic-links 
>>>>> so if
>>>>> you're a container runtime that has been tricked into creating bad
>>>>> mounts of top of /proc/ subdirectories there's no way of detecting 
>>>>> that
>>>>> this has happened. (Though I think in the long-term we will need to
>>>>> make it possible for unprivileged users to create a procfs mountfd if
>>>>> they have hidepid=4,subset=pids set -- there are loads of things
>>>>> containers need to touch in procfs which can be overmounted in 
>>>>> malicious
>>>>> ways.)
>>>>
>>>> Yeah, though I see this as a less pressing issue for now. I'd rather
>>>> postpone this and make userspace work a bit more. There are ways to
>>>> design programs so you know that the procfs instance you're interacting
>>>> with is the one you want to interact with without requiring 
>>>> unprivileged
>>>> mounting outside of a userns+pidns+mountns pair. ;)
>>>>
>>>>>
>>>>>> Both problems may look insignificant, but they are sensitive for 
>>>>>> CRIU.
>>>>>> First of all, procfs may not be mounted in the namespace where we are
>>>>>> restoring the process. Secondly, if someone opens a file with 
>>>>>> O_NOFOLLOW
>>>>>> flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also 
>>>>>> open the
>>>>>> file with this flag during restore.
>>>>>>
>>>>>> This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
>>>>>> struct open_how and changes getname() call to getname_flags() to 
>>>>>> avoid
>>>>>> ENOENT for empty filenames.
>>>>>
>>>>> This is something I've wanted to implement for a while, but from 
>>>>> memory
>>>>> we need to add some other protections in place before enabling this.
>>>>>
>>>>> The main one is disallowing re-opening of a path when it was 
>>>>> originally
>>>>> opened with a different set of modes. [1] is the patch I originally
>>> I looked at this patch. However I am not able to reproduce the problem.
>>> For example, I can't open /proc/self/exe as RDWR with the following:
>>> fd1 = open(/proc/self/exe, O_PATH)
>>> fd2 = open(/proc/self/fd/3, O_RDWR) <- error
>>> or open file with incorrect flags via O_PATH to O_PATH fd from proc
>>> This is fixed or did I understand this problem wrong?
>>
>> You will get -ETXTBSY because the /proc/self/exe is still a current->mm
>> of a process. What you need to do is have two processes (or fork+exec a
>> process and do this):
>>
>>   1. Grab the /proc/$pid/exe handle of the target process.
>>   2. Wait for the target process to do an exec() of another program (or
>>      exit).
>>   3. *Then* re-open the fd with write permissions. This is allowed
>>      because the file is no longer being used as the current->mm of a
>>     process and thus is treated like a regular file handle even though
>>     it was only ever resolveable through /proc/self/exe which should
>>     (semantically) only ever be readable.
>>
>> This attack was used against runc in 2016 and a similar attack was
>> possible with some later CVEs (I think there was also one against LXC at
>> some point but I might be mistaken). There were other bugs which lead to
>> this vector being usable, but my view is that this shouldn't have been
>> possible in the first place.
>>
>> I can cook up a simple example if the above description isn't explaining
>> the issue thoroughly enough.
>>
> 
> Thanks for the explanation! I get it now
> 
>>>>> wrote as part of the openat2(2) (but I dropped it since I wasn't sure
>>>>> whether it might break some systems in subtle ways -- though according
>>>>> to my testing there wasn't an issue on any of my machines).
>>>>
>>>> Oh this is the discussion we had around turning an opath fd into a say
>>>> O_RDWR fd, I think.
>>>> So yes, I think restricting fd reopening makes sense. However, going
>>>> from an O_PATH fd to e.g. an fd with O_RDWR does make sense and 
>>>> needs to
>>>> be the default anyway. So we would need to implement this as a denylist
>>>> anyway. The default is that opath fds can be reopened with whatever and
>>>> only if the opath creator has restricted reopening will it fail, i.e.
>>>> it's similar to a denylist.
>>>>
>>>> But this patch wouldn't prevent that or hinder the upgrade mask
>>>> restriction afaict.
>>>
>>> This issue is actually more complicated than I thought.
>>>
>>> What do you think of the following:
>>> 1. Add new O_EMPTYPATH constant
>>> 2. When we open something with O_PATH, remember access flags (currently
>>> we drop all flags in do_dentry_open() for O_PATH fds). This is similar
>>> to Aleksa Sarai idea, but I do not think we should add some new fields,
>>> because CRIU needs to be able to see it. Just leave access flags
>>> untouched.
>>
>> There are two problems with this:
>>
>>   * The problem with this is that O_PATH and O_PATH|O_RDONLY are
>>     identical. O_RDONLY is defined as 0. I guess by new fields you're
> 
> Yes, I didn't thought about that.
> 
>>     referring to what you'd get from fcntl(F_GETFL)?
>>
>>     What you're suggesting here is the openat2() O_PATH access mask
>>     stuff. That is a feature I think would be useful, but it's not
>>     necessary to get O_EMPTYPATH working.
>>
>>     If you really need to be able to get the O_PATH re-opening mask of a
>>     file descriptor (which you probably do for CRIU) we can add that
>>     information to F_GETFL or some other such interface.
> 
> That would be cool. In the patch I saw new FMODE_PATH_READ and
> MODE_PATH_WRITE but there was no option to dump it.
> 
>>
>>   * We need to make sure that the default access modes of O_PATH on
>>     magic links are correct. We can't simply allow any access mode in
>>     that case, because if we do then we haven't really solved the
>>     /proc/self/exe issue.
>>
>>> 3. for openat(fd, "", O_EMPTYPATH | <access flags>) additionally check
>>> access flags against the ones we remembered for O_PATH fd
>>
>>   * We also need to add the same restrictions for opening through
>>     /proc/self/fd/$n.
>>
>>> This won't solve magiclinks problems but there at least will be API to
>>> avoid procfs and which allow to add some restrictions.
>>
>> I think the magic link problems need to be solved if we're going to
>> enshrine this fd reopening behaviour by adding an O_* flag for it.
>> Though of course this is already an issue with /proc/self/fd/$n
>> re-opening.
> 
> I think these issues are close but still different. Probably we can make
> three ideas from this discussion.
> 1. Add an O_EMPTYPATH flag to re-open O_PATH descriptor. This won't be
> really a new feature (since we can already do it via /proc for most
> cases). And also this won't break anything.
> 2. Add modes for magiclinks. This is more restrictive change. However I
> don't think any non-malicious programs will do procfs shenanigans and
> will be affected by this changes. This is the patch you sent some time
> ago

Oops, I didn't notice third patch in you series "open: O_EMPTYPATH: 
procfs-less file descriptor re-opening". This is exactly what I tried to
do.
It will be very cool if you resurrect and re-send magic-links
adjustments and O_EMPTYPATH.


> 3. Add an option to restrict O_PATH re-opening (maybe via fcntl?). And
> make it apply if someone tries to do /proc workaround with this exact
> O_PATH fd
> 
>>
>> However since I already have a patch which solves this issue, I can work
>> on reviving it and re-send it.
>>
> 
> Why not if it only makes it better
