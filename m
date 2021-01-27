Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7795430592F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbhA0LFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 06:05:37 -0500
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:34016
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236393AbhA0LC5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:02:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZRlugVJTiL8l9S/qpeUQ6za2AEhFLu9YZAan3/gLH4Kfa6DzTgXpWmjAQlfzC/JrrZI2peCld8pOUoizcsZ9c0gISsU2MB+2fRnUkLfQiBGj+GURehVL9S6OXsySUaFt5Z0Nr9hlejhmN0LzIC6RO76ml6scU7Dvj62v5EkrpbwQa31FZyZnHhfp2VzuEqdV2N9mfilMoYfXcEBg4IydgXdfrEP+4s0s5H5AWhSOlTy0fVviXG4eAdR8zpkW1cOOShbLbYCOA3UcmSLKmEhAGxa4Q7rHpw2XMDw3F8bRMWQdiyPfqEDYARbPcRnACQIKAezxYMtO+eb2zcQzu3mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJSFAr2JEbe7h5H5ZKMXourJbFlzzd2nOHX3it5Ie/s=;
 b=jI/s0bVXCKcDTvev6SEdqBKHaToy59EgdmzuRbh+dr0w78j3W5KpcytBPVs+mkDANY/BW1LkzFM2WLvr2U+DCv4xDxWQinloIcwLuPauaA0gab08DW1UP3ew5KafnO+c2NKgWEN5ZK3o3TxPijQFAXhqKXk8sE++RPp4cWIGufcMkS6McW6U7q3YuxRm9QJSc0vl8x0V+2GsXk3gj7tj8jBSe+hYIOsGHeEAO2N0bemDCzE8oLp1jEgTTHKsD/m04HH/At7GZ4V32Rl2XUAcDt29VmVYodVrpABVKHguvNC3fr7en8kZJuXyjieCWZkTp86gX2Iv4XBBXe8Rn3CsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJSFAr2JEbe7h5H5ZKMXourJbFlzzd2nOHX3it5Ie/s=;
 b=xUuulsCXSyD4Ai5BmxyB6iOl7Xo+Fh52VMTkslfpPLPlDnYviPtO5gMm2ojw87lolPZFJufthUiczkLasfih6A9iOre3ddlOB0CWfG5DlGXGBJ4ZUqVds+A+Kvz5vwPdtZi2zlebG6720NOhDYIlGgZ7ZXJjTBAMTy3UuyUsviM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3901.namprd12.prod.outlook.com (2603:10b6:208:16c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 11:02:03 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 11:02:03 +0000
Subject: Re: [PATCH] procfs/dmabuf: Add /proc/<pid>/task/<tid>/dmabuf_fds
To:     Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        kernel-team <kernel-team@android.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>, Hui Su <sh_def@163.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>
References: <20210126225138.1823266-1-kaleshsingh@google.com>
 <CAG48ez2tc_GSPYdgGqTRotUp6NqFoUKdoN_p978+BOLoD_Fdjw@mail.gmail.com>
 <YBFG/zBxgnapqLAK@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ea04b552-7345-b7d5-60fe-7a22515ea63a@amd.com>
Date:   Wed, 27 Jan 2021 12:01:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YBFG/zBxgnapqLAK@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:208:1::36) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0059.eurprd04.prod.outlook.com (2603:10a6:208:1::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Wed, 27 Jan 2021 11:01:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bad9c4f3-c6e6-4e5c-d456-08d8c2b2f97c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:
X-Microsoft-Antispam-PRVS: <MN2PR12MB390115C5005B246686B10A6B83BB9@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wVDOw4Xvpw7e8+6T0HEhvyA90mTxhBqvvxZ3PLJ1G1+rSwQASeTXpQv25BzetjqTKMhsh0HI8b5LRpqd688buj2kTH35d38L+LGFaPHs74gqYZ5FZXHtg/oypwqZYUWDN6GTjkpGdb6zbOb9utlg0vBDF0fuK1drREVlRS/PBBAyi701j64BPHuS8R3JBsd3i3vYDfDA2EOzHnhm0O4cQkoR9waKNTmSVs7laPg0Z1cQqG9ttzz4iwh8/+komushJogA/P7soOewAt2MTw+CPh1C9fRbaPs1J7fddNk2L+WRfNz+R+ntDuR1Py9uac4tIWnA1GTMzPHvHltXywbFS4mAVWhJwbLq1r0CQapEMtIw96OsvQFvlb2naiBPlmNp62yhLyeiFqaM5IfsMFxUcPHxyRQkbyx3KboWkuAr7cHB9qemOEWXuvkc7Q2gpyGxMsgUEVW7NmgRNigad6Rk5nLmyDlgcertUkQnA4qbvz8nP6eW3HL/FSsTWRzXkkd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(2616005)(83380400001)(52116002)(66556008)(8676002)(2906002)(66476007)(31686004)(186003)(110136005)(66946007)(31696002)(34580700001)(16526019)(7416002)(6486002)(6666004)(478600001)(86362001)(4326008)(7406005)(54906003)(36756003)(53546011)(316002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S3FyQXFuaXpFYkFwbHZDYWtlMkgzQ0RhcXMxYzFaZjNVRmlhZHJsd293YUZ3?=
 =?utf-8?B?eDhkSEthUWFOZFZHM1RoNVdrc1hOSUx6MW9MaTRGc3VLLzNUL0lWTm1HRHhJ?=
 =?utf-8?B?b2tRYVAyb29XQlhWUklwNHEwWm1NQzNmMHJFMitIQ1gvajdFSjVlOTJ5bDNZ?=
 =?utf-8?B?Rk5QM2VYL0lNM0phMTRPak5lVDhrMVl0c0hKT0tDV3dHMkFBa0VkbzVvNUlM?=
 =?utf-8?B?emttbzlvRWlmSHdQRjZtMDFId1BWYTRLbHBOL0V1eVZjMEFNUS85a1hJaUdp?=
 =?utf-8?B?VTFmbjRhcWxoWlR2TkVQMWhNbGxCajNMYTRlRm1iaytnR3puZzNaMklqVVkv?=
 =?utf-8?B?QitjQ1Q2ZjMvYzV2WU12K0VYdGEzWHVPbjBuc2FNS2hUUXBIUDd6QXdrWHBs?=
 =?utf-8?B?cndZR1JOanF4MHpMYndUYVJpRHVmQ0lvVjFPekxNTWk1blUzb0QxbUsxNWpV?=
 =?utf-8?B?M3BPdUZ2YUhqTlhkcEhDWFFsSG1lVFpOMGFNQVdwWnl4dld6ZW1oUFovN1g2?=
 =?utf-8?B?N3c1b3p5MnN5eEFsd2FtbGY5YldpcnFRMjZublVrOWhocTNpelU0cllNVmVZ?=
 =?utf-8?B?Qnh6NjczTkdVWDQyNm5NTzhiM1dwR21ST2xCZkI3dVdZOTRyWmJxZE9QTlJC?=
 =?utf-8?B?RHZkRnFBd3M1RXYwNERXNHhsT1hNbjVEa0JiVGF2cWdueUlobXUvak8vZ2Vy?=
 =?utf-8?B?OFd2ZDhLN2czNlFvVloxL0NGQWc0Ky85RU8zTW4zOUNGQU8wZDRBWldiS2da?=
 =?utf-8?B?V3ZmbGd3djkyVXh5L1RyN3V1VTJNUXdmeCtkQ1RyRGhPWVBjcFdQME9vdzhN?=
 =?utf-8?B?ZUN3UEVvZ2hJUWNONkg5UmFnNUlrT1FaN3h6RjNlM1FQMGZyK2hTaEhuNGQr?=
 =?utf-8?B?NWFvSy9FTmRuc2I3MFd3MEhpWEh6a3NrajNZNWJPZDZGQVNlZmNoSndkanZy?=
 =?utf-8?B?dUg0RWwxcUFPRzVKSkNHNFNveW05alZFTUkzSTByRnpFTXZSOVFMRVhCaXA5?=
 =?utf-8?B?WUJ3UndlbVQxTmxPTzVTMVladi9oY3lhTVFYY3VraWZCRE9GZUtWRW1pNnNx?=
 =?utf-8?B?MmZZZHBJWDBMMWo0OVRwakhXODYrcE9jdkJMSzNuQWJ6QkpBVkxsdkt1SkJQ?=
 =?utf-8?B?MkxRL1luWWxBZk9xVnR6WHQ1dGNOeVc1bkhBYWJrTUx2QzNMQWIraXdUTEZX?=
 =?utf-8?B?TlFldi9uWGpuZFlrZG16cm8vN2t0ZitlZnBuY2YvL25pMkcwZFYvQUk0ZmVh?=
 =?utf-8?B?dlhxc2dBS0tYMjFFZWdHSEhoVEZRbzVQbWxsVHprUW9hQWg5NjRPQ2JEMVhU?=
 =?utf-8?B?QVZLTUNhSndiMU1kTVU0bU4wRmgranlvaWpIZUwvRFRMQlpNVGZIZ0FHaUVG?=
 =?utf-8?B?MmkveHlyUEN3SmRiL0J6dVZ2bVZaRktDN1paQlhncjJqSklJdXgwaTdBdkRt?=
 =?utf-8?B?cjVDV1dzaUw2aWxQNHdHcDFxRWVzdWNHUHJRNUVLSlloRlBFMFZXakQ5TUpS?=
 =?utf-8?B?VVJ5VWljU1FnRlpkZFE3a0FaQjR2Z2pmbkU3VkJsZlMxWlhibVEvbzB2MjE3?=
 =?utf-8?B?UEZmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad9c4f3-c6e6-4e5c-d456-08d8c2b2f97c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 11:02:03.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FTX22ttGIfist2bUXl/WF2wlrwOp6ZM56na/czmblq8mAAClDiHaVeQL0oAg2dl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 27.01.21 um 11:57 schrieb Michal Hocko:
> On Wed 27-01-21 11:47:29, Jann Horn wrote:
>> +jeffv from Android
>>
>> On Tue, Jan 26, 2021 at 11:51 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>>> In order to measure how much memory a process actually consumes, it is
>>> necessary to include the DMA buffer sizes for that process in the memory
>>> accounting. Since the handle to DMA buffers are raw FDs, it is important
>>> to be able to identify which processes have FD references to a DMA buffer.
>> Or you could try to let the DMA buffer take a reference on the
>> mm_struct and account its size into the mm_struct? That would probably
>> be nicer to work with than having to poke around in procfs separately
>> for DMA buffers.
> Yes that would make some sense to me as well but how do you know that
> the process actually uses a buffer? If it mmaps it then you already have
> that information via /proc/<pid>/maps. My understanding of dma-buf is
> really coarse but my impression is that you can consume the memory via
> standard read syscall as well. How would you account for that.

Somewhat correct. This interface here really doesn't make sense since 
the file descriptor representation of DMA-buf is only meant to be used 
for short term usage.

E.g. the idea is that you can export a DMA-buf fd from your device 
driver, transfer that to another process and then import it again into a 
device driver.

Keeping a long term reference to a DMA-buf fd sounds like a design bug 
in userspace to me.

> [...]
> Skipping over a large part of your response but I do agree that the
> interface is really elaborate to drill down to the information.
>
>> I'm not convinced that introducing a new procfs file for this is the
>> right way to go. And the idea of having to poke into multiple
>> different files in procfs and in sysfs just to be able to compute a
>> proper memory usage score for a process seems weird to me. "How much
>> memory is this process using" seems like the kind of question the
>> kernel ought to be able to answer (and the kernel needs to be able to
>> answer somewhat accurately so that its own OOM killer can do its job
>> properly)?
> Well, shared buffers are tricky but it is true that we already consider
> shmem in badness so this wouldn't go out of line. Kernel oom killer
> could be more clever with these special fds though and query for buffer
> size directly.

Some years ago I've proposed an change to improve the OOM killer to take 
into account how much memory is reference through special file 
descriptors like device drivers or DMA-buf.

But that never want anywhere because of concerns that this would add to 
much overhead to the OOM killer.

Regards,
Christian.
