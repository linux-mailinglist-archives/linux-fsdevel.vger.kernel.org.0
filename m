Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D1A490202
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 07:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiAQGf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 01:35:59 -0500
Received: from mail-eopbgr50136.outbound.protection.outlook.com ([40.107.5.136]:61670
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231189AbiAQGf7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:35:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCV3zH3n20/Pqx9XzC4pQYznCYqQG48o9McZS42WOAtIiZQ7VxamxlwemAOO6hBtzeo5ERp0stfXiwqhppQkt2O5MOOFcXmXZlZUUDOH5LpIarh9jLJus4l3h/5PeZzyDinbXlJnu5WJbLIp9oKzyTr/u98KLljhuifyveGxt0fv0ry+AG6yEjPDtxR7XYPvTyHdL9m5V7TEbO7mqgIriIro/KzdB5Yh7o7iIi0WzSOi4yK//QVeL+xMlpfRqo7vd3SehojoHK4bH4bQ2J/ksLKzKDHf0GmSCn41Ib+JwTc32wc3Jtn4toSZQ/aiFTsfpucju9pOG6ZaubsCvS5A/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51O7DGQdGrBxIWZNEW571QWFYCG7Ip/Duv63EPpkv8Q=;
 b=aB3Bm4AVg/w9EnJd78vlYAkq3+qxGKylinC1fyobo3s3ELDlP0VbHqnOz1H1WB9bMQc9ZQar6WjLS6XHb/elsSfNDOY++hkRdkyIoS1b4ImmtE+/UxM6XOHSfiuxQqVcE06q6uClBL2EqxvgqPAcLtfbe1GurpzKDfFyxWbq7UjxnXbP3A341Of1FYcdYe5RJ/JwveApfEL04Lgz1w/jJ1gsa9utfkPILCkMMMix/gEuDXZjTQuFtTvvbyCTkcP4NK4lF+YmCE7gqrOnq1HtHYF7mwLYtIpgjlRH61Dz/ELqAxNFdCDKySdlt8XL1rD2eean1vX7YKD57cG7EtOJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51O7DGQdGrBxIWZNEW571QWFYCG7Ip/Duv63EPpkv8Q=;
 b=UbLFGLGuW9aHLX9Rk2xxVjdw+EDbUvXtTCWQfB24tPl2Z6kUpC2utev5gOOc54M4k85ASzptUjKE7ZlS9hc462Hk2Mj9/w9teSrvjIFR9ZrGaW2VRTRCsWamrA8EGFp0Zyt/Dsy1loSFmI7nILpjWX/K35Yzk8+WMgUDo0L/Hp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by AM7PR08MB5368.eurprd08.prod.outlook.com (2603:10a6:20b:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 06:35:56 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::947:5bc8:88ae:da30]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::947:5bc8:88ae:da30%6]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 06:35:55 +0000
Message-ID: <4799d395-f808-9668-2db5-59f6de545757@virtuozzo.com>
Date:   Mon, 17 Jan 2022 09:35:52 +0300
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
 <8452fb29-b308-df9a-c2d4-f0ad29b1649c@virtuozzo.com>
 <f1128946-5675-7d8e-e475-d889dc7f5f80@virtuozzo.com>
 <20220114042817.qxpqims6qbteyasc@senku>
From:   Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
In-Reply-To: <20220114042817.qxpqims6qbteyasc@senku>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR07CA0038.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::23) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04653077-d332-4f8b-ba83-08d9d9839d66
X-MS-TrafficTypeDiagnostic: AM7PR08MB5368:EE_
X-Microsoft-Antispam-PRVS: <AM7PR08MB53680B7543D50AB665F891EEE1579@AM7PR08MB5368.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maaQBOueKPXRBvcXyCkoea5CsoiXYRncn+l54HIL3Pl6yQGxW8eEP7e9yWLCb5x7mG/akkW0oUFQFrdrBub+7F9cvna9mJ+SiXyMBk5SsETgLeH09/RU/loSuGKG3u9wIjEgqieJ3i53POfLgSp2Ctdp9xyawm/Oshhn5TDbDJ9J2B+6K90yBYYdAtPdYk4BY5uP98/gHFpnK2nZU2l1hK2RUMAkuBwM5orLCJzIKWzlXN0LjBNBUXiT1w8FYsiKeLdqtk5WTngzVE/sggOyx+j25X7txMbkEmkWBI+wl2kb8aQ7D9Eaz7AIa0jq09dldov7FD7EyADZ3Y0swnRy9NtZKCnlFEdVKyfefAXhOk4S994GZn9Yn/KDC/yN+vCSEgLGHxRR1KoNj8CFl3EaT2veaitahu4D7AFerZZK9wJoT7pcCmolzqnmFF+tx3H46F5rTfGBgbMuJBmmPlRO64F0z3JijmrcZ4ndKfEmy3pwH62t1+yHZTjyc2nBsVk2OkC3zZgLLX0LCNBbrXp+aPhoFYbkCwFwavWqhMHfDXwYnEicbu1Zusy6kLuCt/ZFhB96vhAa5lUcTWxuOxyo3LzySQqa0GMs4NWToEnwpezh3bYWg2faXy5RBE2XDYhFfppT5CNuf3hy2VjhErcHsC/7b+JrRBgYCKzqEreXI9bZZTtqg78QiqDG8bpSGHQa1QX7H1oNGa7zu7QmVUJB8JdwZQFJdTGcJ4AOnsBLoEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB5732.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(66946007)(8676002)(8936002)(2616005)(86362001)(508600001)(26005)(186003)(6486002)(66476007)(66556008)(31696002)(6512007)(31686004)(2906002)(5660300002)(38100700002)(316002)(6666004)(36756003)(4326008)(6916009)(6506007)(53546011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHNSN3dJSkpqRnNsR1Z4UGVZRHNtekJGcVhKUCtJL3dKTitIR3hObjBxSE1x?=
 =?utf-8?B?TjNpN2RMTFdYREM1OWpWejI5dFNvYWR5bXdqcWlHT0ZHV2FHZ1pOMFJiMzFh?=
 =?utf-8?B?cUVaOHJ5N0lQT2FvYjRZZWVIT01DVlUrTEVWMi9tQnJoYUtRWlpZbFhpc1VI?=
 =?utf-8?B?cWZPZyt0a043OVluS3hDK1NYbmkvbWtJRGtPUTBmUWZpeTVpWXlrS0xaUFVq?=
 =?utf-8?B?eW93YUxTek9RRldoVnJ5VndLVlJFdnJRcU1MUm8wZjV3TVU0S0hWMldnVkMv?=
 =?utf-8?B?blZ5MkV5eFA5K1ZITDlCZGN0K3Mrb2FicEVSaURsaE9JK2x4OE1oeXNtZWx4?=
 =?utf-8?B?cFZVRkQ0RFlxOENUZWk0VjNkMkowSmxwVEd0OFprOTdMMlF1YUFDT0xEc0tP?=
 =?utf-8?B?SWdNdHZpRUxRNDJVamw1blU0Y2c5bFdUckZHdDR6dTB6YWlpOHhhczZnWVZO?=
 =?utf-8?B?aXVLZ0UyUFJ3TWp0dkNNcTNTTHpQNGt2YWZyeFhTQ0tJcTgxNUgxSlcwaHBk?=
 =?utf-8?B?M0RqRWhLQ1IxUGl6MDRFWUhiOFc4aTRwdWtSY3pqbTF4Mm5hTXI3S0RnZ1Rk?=
 =?utf-8?B?cEF4ZjdYTVQ5eDluUllOMUE2dEVjU0Ezb3JaTU1sMksxT09EbkNMK1VTYTBy?=
 =?utf-8?B?K0w5U0lsdVkrTjA5NVR4YVhnUk5RbUxsaGg5MGdJWnpNb20xUGlaTkUrcnkz?=
 =?utf-8?B?Wks2c3o1OVFydk13cnNQQVltNmYrQ0xSQnJPdkhUeEJ4bElUOHdPZDVJL01a?=
 =?utf-8?B?aEw0c2txOU1LdERDL3dicEd1eVErcGtqZFE3cHpHTjJYN3cxazlwQVRGWU94?=
 =?utf-8?B?RVdVYUx0dzRjNjVIT0RwemZXSnN0NjJMWnpRSnVJYjZSb1Q3UkFlb1RHeUx3?=
 =?utf-8?B?cFY4NWptZWFIZ1NFSU9vN0dKTDZzZWlkQ0RJM1pXVGh0TUZETE0vaTBuTVBZ?=
 =?utf-8?B?bmdBSER6Z3habGpFeEFIVExuWTNZWk9TS0pQQU1pQ00rSFR5ejlRMDZhRlVy?=
 =?utf-8?B?NzVxL1NiSEluaW9WQjZJTDJiUUl4MktWSzh3d25yN29lT2k2cVRmSjdLeTFr?=
 =?utf-8?B?dDB5a21NRjR4RGlCam5BdllYcHhFVGcxU2E5NDMwc0ErUUtKYTEydGFySnlL?=
 =?utf-8?B?UlFBM1g5aVFobmorQTBrL0wwUEM2M1B1aE12WUZUc1VZVEl3STdYSFRzNGlV?=
 =?utf-8?B?OW9RL0hIYUdEWEhsUk1SdTlVLzBmRHF0SFQ4Z1pUdUN2WlVuK0NmNHl3T1lr?=
 =?utf-8?B?K2RueUtxdEtJMkxtZ2FhSXNqdkliNGVOQ1ZpRGg5VnlzaWtvL3VBSWQramxJ?=
 =?utf-8?B?ZWxxeldwMnkzMXJHNmtpZEJUWkl6RTVGd2V4Z04yQnpDZzV1SlBzN1luMzZQ?=
 =?utf-8?B?L1hzRXJFRytyWmNBaGoyTW9zbkt1ZUNncGtLcjByQVlHemp4MXZjU2xqUnRZ?=
 =?utf-8?B?ODdUYXE5blBBdHhZTkNCOFVha2ZCK0g0NlZRUXlGNlJJQkpMSC9RYnFiZkxX?=
 =?utf-8?B?ak85WEtGRHdpNGJXYmN2TFQ2aVBwV3MzenJjUVpLMlBVOElsUGJHQWZYU2Vn?=
 =?utf-8?B?dkNZb1BUNkVma1dZN1VTU2Z4U1pkd01qa0tHclRZQktyR1RoK3V5czd6OFdz?=
 =?utf-8?B?c1dYQlF4aXBSSVVuSTdhNTBpMFloTTUwZUtkZXJIMnZJdHhJaEY0UGxqejZr?=
 =?utf-8?B?WXlMWHJCSlQyNVk5RlVhMkY2Smd1V0xzWldlOEdZeGFSc0VNSUdrenduQ3o4?=
 =?utf-8?B?bUJMWnhpTTRDaytSTU5pa3ROeG4yQjRRdjdncXlwdFluMCtuQlFwK0VYTnVr?=
 =?utf-8?B?dHZZWExvdDVNdm14YlkzMUlSWG1PSmdvTm43bG9pNkZUZWJvSjY5SUpRTmVU?=
 =?utf-8?B?UU9Hcjh5YU9vNTYwczZlRDd3NEJXTFFGRXFOSk5MVjZ0MXRTRGRtbnZUeExs?=
 =?utf-8?B?aEloTDU2a09TMGU2Z29BZWpGMGwxcE5kWnZJVVE5UEU3TjZnaUVRSkZyZGlS?=
 =?utf-8?B?MHk3RjFCcTA0VmFWeW5PN3B1dGN1eWhXUmRpSlZheU0xUkN4eXVLYzZlbzJG?=
 =?utf-8?B?ZjNsMnRzc0c0cE5LY3FBWndhWHFkOUdaaXFLSDFDcURLeHBFUktKalZtWHdT?=
 =?utf-8?B?NFR4amJkNU9GT0dRYkJXVFhZRmxldy9KeG9rS1FUVXJPWGRYc1d4YWdTbXhB?=
 =?utf-8?B?RkkyeWwweUx4ZFRBaC9XQzl0YmIyQzhad3Bta3NsMkVyNDl5TVQrWjZmMFcz?=
 =?utf-8?B?ZW5TUFhxV0dMTWlvRERwem1wRlFnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04653077-d332-4f8b-ba83-08d9d9839d66
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 06:35:55.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9BYkw9KmW2xi2lNnyhoKsjsZDJCZGk9qIUz2A775lC3jP3myoxd26ZZqojkyd401zSyDaUweBchXrmNWYzoDNJ/GclHXg40d5UUkWah2oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/14/22 07:28, Aleksa Sarai wrote:
> On 2022-01-14, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
>>
>>
>> On 1/13/22 10:52, Andrey Zhadchenko wrote:
>>>
>>>
>>> On 1/13/22 09:46, Aleksa Sarai wrote:
>>>> On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
>>>>> On 1/12/22 17:51, Christian Brauner wrote:
>>>>>> On Thu, Jan 13, 2022 at 01:34:19AM +1100, Aleksa Sarai wrote:
>>>>>>> On 2022-01-12, Andrey Zhadchenko
>>>>>>> <andrey.zhadchenko@virtuozzo.com> wrote:
>>>>>>>> If you have an opened O_PATH file, currently there
>>>>>>>> is no way to re-open
>>>>>>>> it with other flags with openat/openat2. As a
>>>>>>>> workaround it is possible
>>>>>>>> to open it via /proc/self/fd/<X>, however
>>>>>>>> 1) You need to ensure that /proc exists
>>>>>>>> 2) You cannot use O_NOFOLLOW flag
>>>>>>>
>>>>>>> There is also another issue -- you can mount on top of
>>>>>>> magic-links so if
>>>>>>> you're a container runtime that has been tricked into creating bad
>>>>>>> mounts of top of /proc/ subdirectories there's no way of
>>>>>>> detecting that
>>>>>>> this has happened. (Though I think in the long-term we will need to
>>>>>>> make it possible for unprivileged users to create a procfs mountfd if
>>>>>>> they have hidepid=4,subset=pids set -- there are loads of things
>>>>>>> containers need to touch in procfs which can be
>>>>>>> overmounted in malicious
>>>>>>> ways.)
>>>>>>
>>>>>> Yeah, though I see this as a less pressing issue for now. I'd rather
>>>>>> postpone this and make userspace work a bit more. There are ways to
>>>>>> design programs so you know that the procfs instance you're interacting
>>>>>> with is the one you want to interact with without requiring
>>>>>> unprivileged
>>>>>> mounting outside of a userns+pidns+mountns pair. ;)
>>>>>>
>>>>>>>
>>>>>>>> Both problems may look insignificant, but they are
>>>>>>>> sensitive for CRIU.
>>>>>>>> First of all, procfs may not be mounted in the namespace where we are
>>>>>>>> restoring the process. Secondly, if someone opens a
>>>>>>>> file with O_NOFOLLOW
>>>>>>>> flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU
>>>>>>>> must also open the
>>>>>>>> file with this flag during restore.
>>>>>>>>
>>>>>>>> This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
>>>>>>>> struct open_how and changes getname() call to
>>>>>>>> getname_flags() to avoid
>>>>>>>> ENOENT for empty filenames.
>>>>>>>
>>>>>>> This is something I've wanted to implement for a while,
>>>>>>> but from memory
>>>>>>> we need to add some other protections in place before enabling this.
>>>>>>>
>>>>>>> The main one is disallowing re-opening of a path when it
>>>>>>> was originally
>>>>>>> opened with a different set of modes. [1] is the patch I originally
>>>>> I looked at this patch. However I am not able to reproduce the problem.
>>>>> For example, I can't open /proc/self/exe as RDWR with the following:
>>>>> fd1 = open(/proc/self/exe, O_PATH)
>>>>> fd2 = open(/proc/self/fd/3, O_RDWR) <- error
>>>>> or open file with incorrect flags via O_PATH to O_PATH fd from proc
>>>>> This is fixed or did I understand this problem wrong?
>>>>
>>>> You will get -ETXTBSY because the /proc/self/exe is still a current->mm
>>>> of a process. What you need to do is have two processes (or fork+exec a
>>>> process and do this):
>>>>
>>>>    1. Grab the /proc/$pid/exe handle of the target process.
>>>>    2. Wait for the target process to do an exec() of another program (or
>>>>       exit).
>>>>    3. *Then* re-open the fd with write permissions. This is allowed
>>>>       because the file is no longer being used as the current->mm of a
>>>>      process and thus is treated like a regular file handle even though
>>>>      it was only ever resolveable through /proc/self/exe which should
>>>>      (semantically) only ever be readable.
>>>>
>>>> This attack was used against runc in 2016 and a similar attack was
>>>> possible with some later CVEs (I think there was also one against LXC at
>>>> some point but I might be mistaken). There were other bugs which lead to
>>>> this vector being usable, but my view is that this shouldn't have been
>>>> possible in the first place.
>>>>
>>>> I can cook up a simple example if the above description isn't explaining
>>>> the issue thoroughly enough.
>>>>
>>>
>>> Thanks for the explanation! I get it now
>>>
>>>>>>> wrote as part of the openat2(2) (but I dropped it since I wasn't sure
>>>>>>> whether it might break some systems in subtle ways -- though according
>>>>>>> to my testing there wasn't an issue on any of my machines).
>>>>>>
>>>>>> Oh this is the discussion we had around turning an opath fd into a say
>>>>>> O_RDWR fd, I think.
>>>>>> So yes, I think restricting fd reopening makes sense. However, going
>>>>>> from an O_PATH fd to e.g. an fd with O_RDWR does make sense
>>>>>> and needs to
>>>>>> be the default anyway. So we would need to implement this as a denylist
>>>>>> anyway. The default is that opath fds can be reopened with whatever and
>>>>>> only if the opath creator has restricted reopening will it fail, i.e.
>>>>>> it's similar to a denylist.
>>>>>>
>>>>>> But this patch wouldn't prevent that or hinder the upgrade mask
>>>>>> restriction afaict.
>>>>>
>>>>> This issue is actually more complicated than I thought.
>>>>>
>>>>> What do you think of the following:
>>>>> 1. Add new O_EMPTYPATH constant
>>>>> 2. When we open something with O_PATH, remember access flags (currently
>>>>> we drop all flags in do_dentry_open() for O_PATH fds). This is similar
>>>>> to Aleksa Sarai idea, but I do not think we should add some new fields,
>>>>> because CRIU needs to be able to see it. Just leave access flags
>>>>> untouched.
>>>>
>>>> There are two problems with this:
>>>>
>>>>    * The problem with this is that O_PATH and O_PATH|O_RDONLY are
>>>>      identical. O_RDONLY is defined as 0. I guess by new fields you're
>>>
>>> Yes, I didn't thought about that.
>>>
>>>>      referring to what you'd get from fcntl(F_GETFL)?
>>>>
>>>>      What you're suggesting here is the openat2() O_PATH access mask
>>>>      stuff. That is a feature I think would be useful, but it's not
>>>>      necessary to get O_EMPTYPATH working.
>>>>
>>>>      If you really need to be able to get the O_PATH re-opening mask of a
>>>>      file descriptor (which you probably do for CRIU) we can add that
>>>>      information to F_GETFL or some other such interface.
>>>
>>> That would be cool. In the patch I saw new FMODE_PATH_READ and
>>> MODE_PATH_WRITE but there was no option to dump it.
>>>
>>>>
>>>>    * We need to make sure that the default access modes of O_PATH on
>>>>      magic links are correct. We can't simply allow any access mode in
>>>>      that case, because if we do then we haven't really solved the
>>>>      /proc/self/exe issue.
>>>>
>>>>> 3. for openat(fd, "", O_EMPTYPATH | <access flags>) additionally check
>>>>> access flags against the ones we remembered for O_PATH fd
>>>>
>>>>    * We also need to add the same restrictions for opening through
>>>>      /proc/self/fd/$n.
>>>>
>>>>> This won't solve magiclinks problems but there at least will be API to
>>>>> avoid procfs and which allow to add some restrictions.
>>>>
>>>> I think the magic link problems need to be solved if we're going to
>>>> enshrine this fd reopening behaviour by adding an O_* flag for it.
>>>> Though of course this is already an issue with /proc/self/fd/$n
>>>> re-opening.
>>>
>>> I think these issues are close but still different. Probably we can make
>>> three ideas from this discussion.
>>> 1. Add an O_EMPTYPATH flag to re-open O_PATH descriptor. This won't be
>>> really a new feature (since we can already do it via /proc for most
>>> cases). And also this won't break anything.
>>> 2. Add modes for magiclinks. This is more restrictive change. However I
>>> don't think any non-malicious programs will do procfs shenanigans and
>>> will be affected by this changes. This is the patch you sent some time
>>> ago
>>
>> Oops, I didn't notice third patch in you series "open: O_EMPTYPATH:
>> procfs-less file descriptor re-opening". This is exactly what I tried to
>> do.
>> It will be very cool if you resurrect and re-send magic-links
>> adjustments and O_EMPTYPATH.
> 
> I'll rebase it (adding a way to dump the reopening mask for O_PATH
> descriptors) and send it next week (assuming it doesn't require too
> much tweaking).

Thanks!

> 
> It should be noted that on paper you can get the reopening mask with the
> current version of the patchset (look at the mode of the magic link in
> /proc/self/fd/$n) but that's obviously not a reasonable solution.
> 
>>> 3. Add an option to restrict O_PATH re-opening (maybe via fcntl?). And
>>> make it apply if someone tries to do /proc workaround with this exact
>>> O_PATH fd
> 
> I originally wanted to do this in openat2() since it feels analogous to
> open modes for regular file descriptors (in fact I planned to make
> how->mode a union with how->upgrade_mask) but I'll need to think about
> how to expose that in fcntl().
> 

Probably new openat2() field is even better. We do not really need new
F_SETFL for O_PATH descriptors, because you would always re-open it with
O_EMPTYPATH again with stricter flags. As for exposing this flags for
CRIU, new line in /proc/<PID>/fdinfo/<N> is fine (and preferable even
if you add new fcntl())

>>>> However since I already have a patch which solves this issue, I can work
>>>> on reviving it and re-send it.
>>>
>>> Why not if it only makes it better
> 
