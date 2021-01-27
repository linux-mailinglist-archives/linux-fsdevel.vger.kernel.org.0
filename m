Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AF73058F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 11:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhA0K5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 05:57:22 -0500
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:37856
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236007AbhA0KzE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:55:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDct+n6XpURJh/Smm5e0V4IapDNrTiBwPR5Dp+OS82JZFa/w+Rjg7c4tdwj5s3hDs82GzgQUh5MWO9wl7LNtTQBOfsenQFAev3peIVIPlbg7N/iWX+95Ivrmt9z30uJGRo3wkUL+UJqGKf4GZ74cN5RCdgmlOQTh8Qzt3lC6VzGOzED592EIkERZ/ZM3R6MA/MtfbeWH6rP5yNUCDL1wZOV09Dbha+nqDqKIsjzMUrH70hqYuy8nbMTJApOqVq2C9xuwKc1yHEncm52kBIwGmfYMdWKZiIskG771XmbZye5IdkiM3lF4IUy3VQyQJ3qzESYnCLQhyRePapEzWWX6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxcuQ43UtVKrlDdNHP1rNUtcsO9Xxu59Irj7+0sfD9Q=;
 b=YhRtDsqvo0an4tRbRQl5rQjADSnVCDCGuvS3+81a036HijNzcW8dZdlaj96hKbhtN/I0m4W0aG9Wdg7b31HlpcgKqd3zx1C21VkXKNjc1f5nRqR7BavR6JVJNQZS+AD8TuOE4gdjA19FOchOoqSEyu8DazNY90T1RWDXY0lOBCx0OSbX6SUs7SOYM8tZ/vA2VNCDUoUJRj+RpTbTE+YxYvl37Zto1VfuLUsZ1eg1jXzuyOjdeHDKC+msKJ7ABAujxj00m/HrN17kABbFXLWgqJp65Qo++A3CLzFldTttNxXlmtH8rSA7J+a0EuHBYOpXdq1yvS26rGgCudjzPwn1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxcuQ43UtVKrlDdNHP1rNUtcsO9Xxu59Irj7+0sfD9Q=;
 b=Za7uq6F8lF3ZqPF4RjcGM289RTqS9FS5e2P1GN30ZTChH8E/hNsdRsNlfEb3Qnv3oKFR8K00zjXRMI70b8IxgRXOm1Z8VIWcsFnUZs5qI2nSnYPUvH92o0YpOq6goYdkC7FBPz5LtsVhBWRSdqeyriG82i6SzYLbd3NgkR4MBkM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3901.namprd12.prod.outlook.com (2603:10b6:208:16c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 10:54:06 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 10:54:06 +0000
Subject: Re: [PATCH] procfs/dmabuf: Add /proc/<pid>/task/<tid>/dmabuf_fds
To:     Michal Hocko <mhocko@suse.com>,
        Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@kernel.org, gregkh@linuxfoundation.org,
        hridya@google.com, jannh@google.com, kernel-team@android.com,
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
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-api@vger.kernel.org
References: <20210126225138.1823266-1-kaleshsingh@google.com>
 <20210127090526.GB827@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6b314cf2-99f0-8e63-acc7-edebe2ca97d7@amd.com>
Date:   Wed, 27 Jan 2021 11:53:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210127090526.GB827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 10:54:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27bb2f17-2e7f-45b1-aef5-08d8c2b1dd61
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:
X-Microsoft-Antispam-PRVS: <MN2PR12MB390116F93F675BC67E8525C483BB9@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4BBB0i5p9A2z5vY4KAC651KUJQ0brRImfHef2UbnhhkEpRzTkBN5DV2MvKJROz0expXs8SRyWPsCQFRTkcKzsbfSNOgvhj4XyJUPMG9b+KAKa1keQ3aVTG3zT4mmwUQpMwjvzvQ7WhIJgqp8hnwRTvewi1BDZWWu3fuSEezJYgEzmC6jYGMeCgSJ9uz40gkN5+nJf1sa7xJtgEefGARDMMEUNR8l0pcxFOrxLtaLk3GLjdnPluhPlPzAV1AxFpSJ03wxYwg6AQ2Xv6tbLLUiLG6K10J0dyPMJ9I7z7Lk9E07A+vTI5aBpBHp84LNx48auKiAE0sm8i5FLWIBaO+1PyO5H0Fzfp3royBYLwnRe25LMYnlSAx8avwPeaf5QTwMP4FwxCbYv5t1A6yEfRdFrvD+LdTDIonTqJvONkLbL5jGAq4OkFHpKqj9TaICUlGI8lug1ugwkaAj+wY/YLVHSha9TRJsCgEDBa2hUL3pMnW5/0pGUxIqzxgrlFNHRErDC78BsbBd3kyLw90mKT6ZrUDA6/h1XcII7OFjWxtrMJCGWlMWALQ42Hy2dMu6ise+T5uMXEb7WS+GKx4zRLeqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(2616005)(83380400001)(52116002)(30864003)(66556008)(8676002)(2906002)(66476007)(31686004)(186003)(110136005)(66946007)(31696002)(34580700001)(45080400002)(16526019)(7416002)(6486002)(6666004)(478600001)(86362001)(966005)(4326008)(7406005)(54906003)(36756003)(316002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZXpLeCt2cm4yMG1EWTcyOHROR1RVTEVHbkczUDlPVUN2UXhHU1N0LzlabXVO?=
 =?utf-8?B?TExYNzVFYlFOV1ZHT1F5YytUa2hxVXRJY3pRWUZ5WGdkMVlIZFYxaHNzTDFN?=
 =?utf-8?B?cWMydWROcEFzVDFQalJlZjdtWGVvaitnc2pmWXQzZm12dC9LWE9WWUVaUjFn?=
 =?utf-8?B?WVBEb0ExSjNDNFFpVldPNWRSK1FzbWFuWDZZM0ROWDU1Mk84ejBJZjkrK1Zt?=
 =?utf-8?B?dWhtVjZCOUl1YzlXMC9XUkt0Q3JOOGVYQVRaK3VCUEVOVkNvRjRWbWpqZDRh?=
 =?utf-8?B?ejJxSVVGNjdSb29GZDVtRGV5a0dzR0RrZkRua3VMQjdkaDh2Sy9JeXl1eFVC?=
 =?utf-8?B?YjkrMnQ1RnIrb0FSUU4xSXFTMFlUWmRCM1hZTm5Wc2xzUUo1N2w3K3pzYWYr?=
 =?utf-8?B?elZUOVI0YWM1ZEQ1Sk4zVUJ0RS9iWEtTMzJNMVNsY1poeHpPMVc1ZjBVYkls?=
 =?utf-8?B?UVZrZEhtOFVIeXZ1RkRxWGJsMUVGaDlSRllwUHJEK0s1Ky9HcmtLaU1ZRUdt?=
 =?utf-8?B?SytmcTV0Mm1sOVNoWEJJTTh3ZjJ6c3RLengrNlhBb0I1WmRkZzh0c1d0TUhW?=
 =?utf-8?B?QVkzWnE3MjRDclBWay9KOTdENS9JRGxjRXdJWk9udkhtbEN1Y0lNVGJ2d0NT?=
 =?utf-8?B?d2VRQ3NhSlN4VjMzREFpd2NlM3Z4eDJTakYwQVZDSjdVdG10azZaMjhSejdl?=
 =?utf-8?B?dk9TUzE2VzRwekU0ZmVwd2dpNTB5cVFFMGZwa2gvUHZrZVZnUm8zUEhxa3ZS?=
 =?utf-8?B?Zk5RbFkwNVMwaE1Pb3hIc2h4WGt5R2xSbnVHbWhocW9rQjJiWFF6aFJoS0dq?=
 =?utf-8?B?dTRFQmR2bmxyWHVqSnpqeXgwMDdtMzFsK2FGMXNiVEtVb3RHTlZVSTdRUzND?=
 =?utf-8?B?L3c5VGE3aHFkcS9ZWnhIbEQ4WEJuZmpPZFpKS1UzU0l3UE1rNzA4UW0xVC9k?=
 =?utf-8?B?TU5uWWhqUlJFMC9MV3hab2JQRGxmSmJIWjkwVjVLR05Lekw3Vy9raURteEIv?=
 =?utf-8?B?TUpHWGVUT2pVcUErbHEwTlQ5RjhGS0MvRG1CaWwwOWxQOE9LOEJHQzdZM0ZM?=
 =?utf-8?B?WGY1UUEzUjhJNmF5Z2p3dUM2cFYyTTJBenZZREhBNWlvWUFlVGlPc2F5ck4y?=
 =?utf-8?B?Nlp5RjlUTGFVSU1COXBHMW5EaFZNZEZ3ZWNrMytYMkw3YWQrOEI0cnJGL1Ev?=
 =?utf-8?B?NzRPQkhmY3d2L2N3N2dtVkJWTkxTYy9HM25WbWxHTGRqU0xzMis3Y2k2SU5w?=
 =?utf-8?B?U2tCN0FRMzc5NXVIQWI0TzhKQkp2Z3pCMHFuQ2I5SDludjVkVUkxb0ZCQnVt?=
 =?utf-8?B?bHdTZXByZCsxMlhxWVVyd0Q0dTNiWnFibGRwYUl1U0p1VWR3ZlIwdmcrMTRP?=
 =?utf-8?B?aGd4cHFLY3Eyck9HLzdSeVdNOHhqb3B3VE5WV0NRZ2lkRGx1RzVpMEVNakZW?=
 =?utf-8?B?bmRUWlJkQ3FxTFhZL21yNVlaYkRFVGZOSWI0eUdKQUUwS3NQN0pOUWpmM2hU?=
 =?utf-8?B?MCtxZTBsdENmbllnU1IvNG1RWThOTkFXNkdtTEtZeFdwOUFmUk1kdUI5RVV2?=
 =?utf-8?B?bFk0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bb2f17-2e7f-45b1-aef5-08d8c2b1dd61
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 10:54:05.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qlin0AK2FkdeYdSrcuT/ut8QrkidWkUj98qK2EeXAH+tXMWxWNnVLVUZDFp0mbeX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 27.01.21 um 10:05 schrieb Michal Hocko:
> [Cc linux-api as this is a new user interface]
>
> On Tue 26-01-21 22:51:28, Kalesh Singh wrote:
>> In order to measure how much memory a process actually consumes, it is
>> necessary to include the DMA buffer sizes for that process in the memory
>> accounting. Since the handle to DMA buffers are raw FDs, it is important
>> to be able to identify which processes have FD references to a DMA buffer.
>>
>> Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
>> /proc/<pid>/fdinfo -- both of which are only root readable, as follows:
>>    1. Do a readlink on each FD.
>>    2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD.
>>    3. stat the file to get the dmabuf inode number.
>>    4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
>>
>> Android captures per-process system memory state when certain low memory
>> events (e.g a foreground app kill) occur, to identify potential memory
>> hoggers. To include a process’s dmabuf usage as part of its memory state,
>> the data collection needs to be fast enough to reflect the memory state at
>> the time of such events.
>>
>> Since reading /proc/<pid>/fd/ and /proc/<pid>/fdinfo/ requires root
>> privileges, this approach is not suitable for production builds. Granting
>> root privileges even to a system process increases the attack surface and
>> is highly undesirable. Additionally this is slow as it requires many
>> context switches for searching and getting the dma-buf info.
>>
>> With the addition of per-buffer dmabuf stats in sysfs [1], the DMA buffer
>> details can be queried using their unique inode numbers.

While this looks technically clean I have to agree with Daniel that this 
approach doesn't sounds like the right thing to do. The fundamental 
problem goes deeper than what's proposed here.

In general processes are currently not held accountable for memory they 
reference through their file descriptors. DMA-buf is just one special case.

In other words you can currently do something like this

fd = memfd_create("test", 0);
while (1)
     write(fd, buf, 1024);

and the OOM killer will terminate random processes, but never the one 
holding the memfd reference.

It even becomes worse with GPU and acceleration drivers where easily all 
of the system memory is allocated for for games or scientific 
applications without being able to see that in proc or sysfs.

Some years ago I've proposed a way to at least improve the OOM killer 
decision which process to terminate, but that never went something.

Regards,
Christian.

>>
>> This patch proposes adding a /proc/<pid>/task/<tid>/dmabuf_fds interface.
>>
>> /proc/<pid>/task/<tid>/dmabuf_fds contains a list of inode numbers for
>> every DMA buffer FD that the task has. Entries with the same inode
>> number can appear more than once, indicating the total FD references
>> for the associated DMA buffer.
>>
>> If a thread shares the same files as the group leader then its
>> dmabuf_fds file will be empty, as these dmabufs are reported by the
>> group leader.
>>
>> The interface requires PTRACE_MODE_READ_FSCRED (same as /proc/<pid>/maps)
>> and allows the efficient accounting of per-process DMA buffer usage without
>> requiring root privileges. (See data below)
>>
>> Performance Comparison:
>> -----------------------
>>
>> The following data compares the time to capture the sizes of all DMA
>> buffers referenced by FDs for all processes on an arm64 android device.
>>
>> -------------------------------------------------------
>>                     |  Core 0 (Little)  |  Core 7 (Big) |
>> -------------------------------------------------------
>> >From <pid>/fdinfo  |      318 ms       |     145 ms    |
>> -------------------------------------------------------
>> Inodes from        |      114 ms       |      27 ms    |
>> dmabuf_fds;        |    (2.8x  ^)      |   (5.4x  ^)   |
>> data from sysfs    |                   |               |
>> -------------------------------------------------------
>>
>> It can be inferred that in the worst case there is a 2.8x speedup for
>> determining per-process DMA buffer FD sizes, when using the proposed
>> interfaces.
>>
>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fdri-devel%2F20210119225723.388883-1-hridya%40google.com%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cfafaecb186a8408c307208d8c2a2b264%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473351428416475%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=NIhGLE6ysENKIZPMKari23pczegYl5xNwbz0gzK8sj4%3D&amp;reserved=0
>>
>> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>> ---
>>   Documentation/filesystems/proc.rst |  30 ++++++
>>   drivers/dma-buf/dma-buf.c          |   7 +-
>>   fs/proc/Makefile                   |   1 +
>>   fs/proc/base.c                     |   1 +
>>   fs/proc/dma_bufs.c                 | 159 +++++++++++++++++++++++++++++
>>   fs/proc/internal.h                 |   1 +
>>   include/linux/dma-buf.h            |   5 +
>>   7 files changed, 198 insertions(+), 6 deletions(-)
>>   create mode 100644 fs/proc/dma_bufs.c
>>
>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>> index 2fa69f710e2a..757dd47ab679 100644
>> --- a/Documentation/filesystems/proc.rst
>> +++ b/Documentation/filesystems/proc.rst
>> @@ -47,6 +47,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>>     3.10  /proc/<pid>/timerslack_ns - Task timerslack value
>>     3.11	/proc/<pid>/patch_state - Livepatch patch operation state
>>     3.12	/proc/<pid>/arch_status - Task architecture specific information
>> +  3.13	/proc/<pid>/task/<tid>/dmabuf_fds - DMA buffers referenced by an FD
>>   
>>     4	Configuring procfs
>>     4.1	Mount options
>> @@ -2131,6 +2132,35 @@ AVX512_elapsed_ms
>>     the task is unlikely an AVX512 user, but depends on the workload and the
>>     scheduling scenario, it also could be a false negative mentioned above.
>>   
>> +3.13 /proc/<pid>/task/<tid>/dmabuf_fds - DMA buffers referenced by an FD
>> +-------------------------------------------------------------------------
>> +This file  exposes a list of the inode numbers for every DMA buffer
>> +FD that the task has.
>> +
>> +The same inode number can appear more than once, indicating the total
>> +FD references for the associated DMA buffer.
>> +
>> +The inode number can be used to lookup the DMA buffer information in
>> +the sysfs interface /sys/kernel/dmabuf/buffers/<inode-no>/.
>> +
>> +Example Output
>> +~~~~~~~~~~~~~~
>> +$ cat /proc/612/task/612/dmabuf_fds
>> +30972 30973 45678 49326
>> +
>> +Permission to access this file is governed by a ptrace access mode
>> +PTRACE_MODE_READ_FSCREDS.
>> +
>> +Threads can have different files when created without specifying
>> +the CLONE_FILES flag. For this reason the interface is presented as
>> +/proc/<pid>/task/<tid>/dmabuf_fds and not /proc/<pid>/dmabuf_fds.
>> +This simplifies kernel code and aggregation can be handled in
>> +userspace.
>> +
>> +If a thread has the same files as its group leader, then its dmabuf_fds
>> +file will be empty as these dmabufs are already reported by the
>> +group leader.
>> +
>>   Chapter 4: Configuring procfs
>>   =============================
>>   
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index 9ad6397aaa97..0660c06be4c6 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -29,8 +29,6 @@
>>   #include <uapi/linux/dma-buf.h>
>>   #include <uapi/linux/magic.h>
>>   
>> -static inline int is_dma_buf_file(struct file *);
>> -
>>   struct dma_buf_list {
>>   	struct list_head head;
>>   	struct mutex lock;
>> @@ -434,10 +432,7 @@ static const struct file_operations dma_buf_fops = {
>>   	.show_fdinfo	= dma_buf_show_fdinfo,
>>   };
>>   
>> -/*
>> - * is_dma_buf_file - Check if struct file* is associated with dma_buf
>> - */
>> -static inline int is_dma_buf_file(struct file *file)
>> +int is_dma_buf_file(struct file *file)
>>   {
>>   	return file->f_op == &dma_buf_fops;
>>   }
>> diff --git a/fs/proc/Makefile b/fs/proc/Makefile
>> index bd08616ed8ba..91a67f43ddf4 100644
>> --- a/fs/proc/Makefile
>> +++ b/fs/proc/Makefile
>> @@ -16,6 +16,7 @@ proc-y	+= cmdline.o
>>   proc-y	+= consoles.o
>>   proc-y	+= cpuinfo.o
>>   proc-y	+= devices.o
>> +proc-y	+= dma_bufs.o
>>   proc-y	+= interrupts.o
>>   proc-y	+= loadavg.o
>>   proc-y	+= meminfo.o
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index b3422cda2a91..af15a60b9831 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -3598,6 +3598,7 @@ static const struct pid_entry tid_base_stuff[] = {
>>   #ifdef CONFIG_SECCOMP_CACHE_DEBUG
>>   	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
>>   #endif
>> +	REG("dmabuf_fds", 0444, proc_tid_dmabuf_fds_operations),
>>   };
>>   
>>   static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
>> diff --git a/fs/proc/dma_bufs.c b/fs/proc/dma_bufs.c
>> new file mode 100644
>> index 000000000000..46ea9cf968ed
>> --- /dev/null
>> +++ b/fs/proc/dma_bufs.c
>> @@ -0,0 +1,159 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Per-process DMA-BUF Stats
>> + *
>> + * Copyright (C) 2021 Google LLC.
>> + */
>> +
>> +#include <linux/dma-buf.h>
>> +#include <linux/fdtable.h>
>> +#include <linux/ptrace.h>
>> +#include <linux/seq_file.h>
>> +
>> +#include "internal.h"
>> +
>> +struct dmabuf_fds_private {
>> +	struct inode *inode;
>> +	struct task_struct *task;
>> +	struct file *dmabuf_file;
>> +};
>> +
>> +static loff_t *next_dmabuf(struct dmabuf_fds_private *priv,
>> +		loff_t *pos)
>> +{
>> +	struct fdtable *fdt;
>> +	struct file *file;
>> +
>> +	rcu_read_lock();
>> +	fdt = files_fdtable(priv->task->files);
>> +	for (; *pos < fdt->max_fds; ++*pos) {
>> +		file = files_lookup_fd_rcu(priv->task->files, (unsigned int) *pos);
>> +		if (file && is_dma_buf_file(file) && get_file_rcu(file)) {
>> +			priv->dmabuf_file = file;
>> +			break;
>> +		}
>> +	}
>> +	if (*pos >= fdt->max_fds)
>> +		pos = NULL;
>> +	rcu_read_unlock();
>> +
>> +	return pos;
>> +}
>> +
>> +static void *dmabuf_fds_seq_start(struct seq_file *s, loff_t *pos)
>> +{
>> +	struct dmabuf_fds_private *priv = s->private;
>> +	struct files_struct *group_leader_files;
>> +
>> +	priv->task = get_proc_task(priv->inode);
>> +
>> +	if (!priv->task)
>> +		return ERR_PTR(-ESRCH);
>> +
>> +	/* Hold task lock for duration that files need to be stable */
>> +	task_lock(priv->task);
>> +
>> +	/*
>> +	 * If this task is not the group leader but shares the same files, leave file empty.
>> +	 * These dmabufs are already reported in the group leader's dmabuf_fds.
>> +	 */
>> +	group_leader_files = priv->task->group_leader->files;
>> +	if (priv->task != priv->task->group_leader && priv->task->files == group_leader_files) {
>> +		task_unlock(priv->task);
>> +		put_task_struct(priv->task);
>> +		priv->task = NULL;
>> +		return NULL;
>> +	}
>> +
>> +	return next_dmabuf(priv, pos);
>> +}
>> +
>> +static void *dmabuf_fds_seq_next(struct seq_file *s, void *v, loff_t *pos)
>> +{
>> +	++*pos;
>> +	return next_dmabuf(s->private, pos);
>> +}
>> +
>> +static void dmabuf_fds_seq_stop(struct seq_file *s, void *v)
>> +{
>> +	struct dmabuf_fds_private *priv = s->private;
>> +
>> +	if (priv->task) {
>> +		task_unlock(priv->task);
>> +		put_task_struct(priv->task);
>> +
>> +	}
>> +	if (priv->dmabuf_file)
>> +		fput(priv->dmabuf_file);
>> +}
>> +
>> +static int dmabuf_fds_seq_show(struct seq_file *s, void *v)
>> +{
>> +	struct dmabuf_fds_private *priv = s->private;
>> +	struct file *file = priv->dmabuf_file;
>> +	struct dma_buf *dmabuf = file->private_data;
>> +
>> +	if (!dmabuf)
>> +		return -ESRCH;
>> +
>> +	seq_printf(s, "%8lu ", file_inode(file)->i_ino);
>> +
>> +	fput(priv->dmabuf_file);
>> +	priv->dmabuf_file = NULL;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct seq_operations proc_tid_dmabuf_fds_seq_ops = {
>> +	.start = dmabuf_fds_seq_start,
>> +	.next  = dmabuf_fds_seq_next,
>> +	.stop  = dmabuf_fds_seq_stop,
>> +	.show  = dmabuf_fds_seq_show
>> +};
>> +
>> +static int proc_dmabuf_fds_open(struct inode *inode, struct file *file,
>> +		     const struct seq_operations *ops)
>> +{
>> +	struct dmabuf_fds_private *priv;
>> +	struct task_struct *task;
>> +	bool allowed = false;
>> +
>> +	task = get_proc_task(inode);
>> +	if (!task)
>> +		return -ESRCH;
>> +
>> +	allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
>> +	put_task_struct(task);
>> +
>> +	if (!allowed)
>> +		return -EACCES;
>> +
>> +	priv = __seq_open_private(file, ops, sizeof(*priv));
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->inode = inode;
>> +	priv->task = NULL;
>> +	priv->dmabuf_file = NULL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int proc_dmabuf_fds_release(struct inode *inode, struct file *file)
>> +{
>> +	return seq_release_private(inode, file);
>> +}
>> +
>> +static int tid_dmabuf_fds_open(struct inode *inode, struct file *file)
>> +{
>> +	return proc_dmabuf_fds_open(inode, file,
>> +			&proc_tid_dmabuf_fds_seq_ops);
>> +}
>> +
>> +const struct file_operations proc_tid_dmabuf_fds_operations = {
>> +	.open		= tid_dmabuf_fds_open,
>> +	.read		= seq_read,
>> +	.llseek		= seq_lseek,
>> +	.release	= proc_dmabuf_fds_release,
>> +};
>> +
>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>> index f60b379dcdc7..4ca74220db9c 100644
>> --- a/fs/proc/internal.h
>> +++ b/fs/proc/internal.h
>> @@ -303,6 +303,7 @@ extern const struct file_operations proc_pid_smaps_operations;
>>   extern const struct file_operations proc_pid_smaps_rollup_operations;
>>   extern const struct file_operations proc_clear_refs_operations;
>>   extern const struct file_operations proc_pagemap_operations;
>> +extern const struct file_operations proc_tid_dmabuf_fds_operations;
>>   
>>   extern unsigned long task_vsize(struct mm_struct *);
>>   extern unsigned long task_statm(struct mm_struct *,
>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>> index cf72699cb2bc..087e11f7f193 100644
>> --- a/include/linux/dma-buf.h
>> +++ b/include/linux/dma-buf.h
>> @@ -27,6 +27,11 @@ struct device;
>>   struct dma_buf;
>>   struct dma_buf_attachment;
>>   
>> +/**
>> + * Check if struct file* is associated with dma_buf.
>> + */
>> +int is_dma_buf_file(struct file *file);
>> +
>>   /**
>>    * struct dma_buf_ops - operations possible on struct dma_buf
>>    * @vmap: [optional] creates a virtual mapping for the buffer into kernel
>> -- 
>> 2.30.0.280.ga3ce27912f-goog

