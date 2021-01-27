Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E8F305950
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 12:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbhA0LMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 06:12:05 -0500
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:29021
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236284AbhA0LKQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:10:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrLkXjl0c6SC/yLrCe68WmnM5wZSGcTTo6r3F+u2GqnGmdpMU1kNrUT71OraX0kMGN0UCyF6bcaQzxI9Sr7O2psG0TisexSChnIAvdZAAIAnchtHr0SPf+NYWRgWZWazDc83BvRcc35BWChBOVVN3SJzHc0SnrJdG7ABG52Z36LzSrzW2xesxAccIMEEFmJbyhNiC9oCOonXamVIvbJQJwwn5iR/fnjimZr4ntDtpi8osTceuWK4Ws4EM+p37oksDMdTGxMQqpNBVruUkSEaYAau2iP6i/GAFEm69rePbRh94fqZsdro0BieosEbcHfOONywheTrZ+BVrj02dOL5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBk7NBve3gI6w6oDOto8fvYB5dWJn7D7DYz9kpIt6m0=;
 b=jKpJKwhEusETQH2bruyr0S3D4KZcUzQn+CyH1y56ZAmU9ZM3101DixIa//O8iafCPIZP2k4q0oslysTN0Q1f3aEa5MQTpH/IkTGvWOx58Cc29Q3BXlE6z4UzK/XyQjtJCimbOuRdGLxir5UOrmyYJ/8bCXKmwJf7yU4z2pf0F6EvXcauUihDu+qU6lwNzqxO0yGZJsLMeP4siWZULpaMb3hKNNZEVfon3Kg5gwR1ddKy5RLDNftmOMJZNplWZMAALSxSgzOx/X+eisgwX77Tg50gG/7VZ2GK4ZF0U6YS3if/9Syfi7iW9EDHPAV2BQC7pVJj5Ifn9Rccw/Ao73kvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBk7NBve3gI6w6oDOto8fvYB5dWJn7D7DYz9kpIt6m0=;
 b=eFdnPSBfPBkOuFL84/hoo+SbWEvjw0IRlEMuGAjVHHQY8dfd4OGkIRkqY25WuyC4JS2WREs081jLMK64BTHqDp3eKPQQfptibV1PaSUtA81sHuEi/RIyX+chg1Cpm0p2FlEpCy5jMBgNqfXY6GmsmasmgxXl/WsblWxBZrpCnRk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 11:08:58 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 11:08:58 +0000
Subject: Re: [PATCH] procfs/dmabuf: Add /proc/<pid>/task/<tid>/dmabuf_fds
To:     Michal Hocko <mhocko@suse.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>, surenb@google.com,
        minchan@kernel.org, gregkh@linuxfoundation.org, hridya@google.com,
        jannh@google.com, kernel-team@android.com,
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
 <6b314cf2-99f0-8e63-acc7-edebe2ca97d7@amd.com>
 <YBFIMIR2FXoYDd+0@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7dd33165-4fb9-a424-9b5e-08c69583c979@amd.com>
Date:   Wed, 27 Jan 2021 12:08:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YBFIMIR2FXoYDd+0@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::8) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM8P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 11:08:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45034901-9e1a-4d0a-2a8c-08d8c2b3f1aa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4061:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40611F979E6173516AF2009783BB9@MN2PR12MB4061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UaZ7LIaJFHOHBJ7pK0ohuJcEBC60ycrfDWTFd/OQnePbEMdYgTFiSaaaknrBQ29LKaOLIDSY1HVyr/3qoySMD19ZyKHSgitNIHKc+UHN05ZWypaEvP5EDQatIF8RK4vI0uewQNIk4rP9GRmojCnk75wS1zTLuUhAXSpK2JxHII2W1kWit1rZKoo0T8i6M/3bk0xybHeJ4pjkX3EHohXwVb+Na1tDNWGynhjTtpzvY2ONYee4t/YLxmbiyDzNY7ilgf97/bNZRwDDFVz4blmfsZjQnB9n1TM4RNcJdttyUvLdmmhkIENIGfNJ4G/IisGW0lBEPGaxSXq/D4wLvQK9yZgfEmTWH4HxMrDg72Q6qqsHw5hOyqafbOEm2jHm8IQoeL/fPINC7zeWTXaQNqWnq3HANTwnGek9/glwSjNNni+6oT+Vz1tvqvlAgQrTNhGitzHQIEsfnnLa7Z/Yc368YVlCrUSrFceVtnGyN8Salpx4/tQeQ4+uus0dHCBaULHjvmrT0ArdoiXbfM2pgIiSJsWm5+9cbYq87HKy497hXiQccgj3VbTL1R0or56j9DSri/iZjf8MkOYcfrCv/Xe6n5FvMKt7MhMTutqZdazkMDYiE9M6hagF6Oe6t7mX04hJXxZxWnAnOk2llLg8HyIj3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(478600001)(31696002)(6666004)(7416002)(66476007)(7406005)(66556008)(4326008)(34580700001)(83380400001)(6486002)(36756003)(52116002)(8936002)(2906002)(186003)(66574015)(6916009)(2616005)(316002)(54906003)(31686004)(8676002)(66946007)(5660300002)(86362001)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SHJ3VmVQUGlhUHJQQmhmS2Y1MTgxTmlOSXduQnFxVXlJaVg1dFYzdktaYm1L?=
 =?utf-8?B?eEtUdFd3RDFvam16UlJsdzF3NjZ5bjFYQ21SZ2dYSDRJc3lGK0daRGhCN1Jl?=
 =?utf-8?B?LzRmdTNWZmFyRm1aTldWZHRtbkhmeEptc09PVjZldGU3ZG9GYkx2YzJ2bmNZ?=
 =?utf-8?B?UUdyQXlHMlhlbUtZZlNsd1JlWEhMQ09iN0RkZ09veUQvOEpFb2hFNCtwc3ds?=
 =?utf-8?B?RlE3eWNxZnd6Q0FOUVFmaEtvUDlGclFwVDhzTmpMZHJJVHFPM3hFWXlURjVY?=
 =?utf-8?B?MmVjR0o1U0NEb0NzRHhxeHNzcmk5bi9IdXJudGVyYTFia2daU3ZUeU9rTVd4?=
 =?utf-8?B?aG9hK0pFemNlVW1xZTNFRHJBNlRkVGUvS0ZndUtpcnhTYlQzb1NaYjFhTHpn?=
 =?utf-8?B?d0kwSlNvcGpscU9zT001MlBlVFF1ZDhBa3VRZTQxY1N5cHFhNk5zbHJ1WG1H?=
 =?utf-8?B?Q05wd1lrejU0Qm82bVZSMzlNNDRkUUJMVW0wWCtEK3FXQy8xOFk1SHdzWlIz?=
 =?utf-8?B?NkNUYUYycEg1MExSV2UwWGp4aTZPdThlUmxDL3I1dkRGdm9vZFZCeWcvN3d5?=
 =?utf-8?B?SkRzR05IOVR5NVRRNHU5KzNIZWI5bFR2RElaQXpOT3lzZ1M1WW1ZY2xlWThv?=
 =?utf-8?B?T2tZK0pDaFozUGJVNmxpQ3NWR3hQUEgzajlKNmpXeEhGQmtheC8zYjVwNTlL?=
 =?utf-8?B?ZmNoSWl5bW04cDdvN3pIeEJ6aHRXSy9LU29qV3lDcnJxVHVWL3Z5WWE1dkpT?=
 =?utf-8?B?bnMraWYzb2JkMW1veEJmQ1orK0lZNi9mdld1YmVkNDVwNXMxQ3JMRWo5UnJD?=
 =?utf-8?B?bllWVURRTnJFVTJhY3ZXZ0RSNUdnMTIwV1grZHNxdlRSdG8rNlBvZExGdnRy?=
 =?utf-8?B?d0JiMW4wdGRNTUVyem9XMHVERDhUNVNFR0dXbVA4YjBnOGh3YVJiQ1ZsMnU5?=
 =?utf-8?B?eUlzWGVBYkFhSHF4Q1E1bGIzWnZDUHdSU0QxQ1MrQWVQSWpYajBtN2RINlI3?=
 =?utf-8?B?SGJ1WFo0cFdESitRdWJNbTFsWU5kWGx0cmRUcFBkZ1J3MUhNREthYkpZcTFQ?=
 =?utf-8?B?OEVPSVQ3WlhMdXJYdUFVLzFqV1V5NzRWMWlrOUkrOWtoY1JCRGxRR0hNS2E0?=
 =?utf-8?B?ZFNBenUwQmhOZ3pZTjRqbnBZQWJLdVcxcmpsTHg3QklaT2orMnRkUEt3ZFR6?=
 =?utf-8?B?UUg4eTQ2KzErcjZlSnQ0alhBQUZ2ZlA0Yi9IS0U5QjRZZURiTlJEZ1N2eElR?=
 =?utf-8?B?RGdZTlVQL1YyL3JNT2JFbDVTNThLdzRDanZhNWtkai9wSDF2N0xTcXB1RFdx?=
 =?utf-8?B?b1lXcngxRVJudDRkcE9FM2ZEMGxoRGdja0QwYndvYXRrNFZsa0JIY1NPRE1E?=
 =?utf-8?B?T0VJMzhxWnNiVjJFTzlwWmFWZC8xbVQrdmFqVVNBNXVRVk9ndG80cEJ6Zkgz?=
 =?utf-8?B?aVhoMVRXeDNoQTVUdzVGc0VmQWFJTUxsanRLMTh2dVdGWjhCZG1aMVNLL3BL?=
 =?utf-8?B?WjZzSlQ4RzRndmxLUzVrdE9vN3JtWnY1N05kY0NuRkVHNzYzSEl4Q25ZMktE?=
 =?utf-8?B?QjVlZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45034901-9e1a-4d0a-2a8c-08d8c2b3f1aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 11:08:58.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS/D544h006ScwcBrUlBdMSgQXRdPCoMwoE0hdOulgHAvGFTm22PA/bUQd/o/M47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 27.01.21 um 12:02 schrieb Michal Hocko:
> On Wed 27-01-21 11:53:55, Christian König wrote:
> [...]
>> In general processes are currently not held accountable for memory they
>> reference through their file descriptors. DMA-buf is just one special case.
> True
>
>> In other words you can currently do something like this
>>
>> fd = memfd_create("test", 0);
>> while (1)
>>      write(fd, buf, 1024);
>>
>> and the OOM killer will terminate random processes, but never the one
>> holding the memfd reference.
> memfd is just shmem under cover, no? And that means that the memory gets
> accounted to MM_SHMEMPAGES. But you are right that this in its own
> doesn't help much if the fd is shared and the memory stays behind a
> killed victim.

I think so, yes. But I just tested this and it doesn't seem to work 
correctly.

When I run the few lines above the OOM killer starts to terminate 
processes, but since my small test program uses very very little memory 
basically everything else gets terminated (including X, desktop, sshd 
etc..) before it is terminated as well.

Regards,
Christian.

> But I do agree with you that there are resources which are bound to a
> process life time but the oom killer has no idea about those as they are
> not accounted on a per process level and/or oom_badness doesn't take
> them into consideration.

