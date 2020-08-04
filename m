Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF123BA28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 14:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgHDMVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 08:21:24 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com ([40.107.22.112]:23041
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727786AbgHDMMC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdY7qdjXIIZVuTFEQKFaqlcLd9ABr2+gbcVplMk3b6XUnPix9tvBetJ/uHKRVHSzHMJfQbrk5reKsCaeaQpFTUTHV7wZOmMJxGhnq3pVQnsF7Gd44bN9JHr6bQCz1bVySDoU32gvyXagMUnpf6AS919fN7Tm99pYykkmxX+hjghwEF7UrdQb+kAX/ooZ4STesLqcY1LX3LP1cG8x9d1L2UpAs5umlpZ/AsxlHtcoFKTmgNlYVAyiTY7DPRMsY4EZ2JTJt5UC5BFLsdyhaAcvLKQ2AH1kBgOv6+GEEZJ3RlxcVrOr3KxieumUdNySeu+u2dMG2RTCM+2tVg0hSccqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYSw/81WJ60WUOG4hg8wHvqm75XTPjGA8HgDvG+R3MM=;
 b=G64YpfDevFTI1EoROlFJQ2WYHZjttW8gkNcUYIkZYynOYVgm1xE+gm3reJmrX+J29JjNPK1JN5aYdJZD6aIjALoLtD7rzfjRNpH2QoYkJmD75zc1A2x3aUZtRXLGr4yPvkd6cHWk1u5F8bHNqK46s4JioeILPks7vXPMNBgwxpL7aKhf7cpyp9lDbomXgr85tZzIzGOeDdCfNOZu/MVt8kLRYdG7nJK1n6YDiC2ZpVqEB7UOmyyT5SvJZ2vvuy7TuPC3QsRV5C5mb+RJ915EkFHOgpZ6dUYaZEDki5VKF2kwjfjrtrsQThcL/fQhLvII7XPdeXQJnXrKj39rqzycjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYSw/81WJ60WUOG4hg8wHvqm75XTPjGA8HgDvG+R3MM=;
 b=k7CDNKMQh7Lj24HCblb3qKBfvBZ1cRRcQ6bDMkJ4ZUXL1rodOs5mS5/b0q2FPM1Y0dMKXkW97dNe3pZ4GuzqAGmc23fmz9mnO8TDS/SdrfOZYjKNnqKo55qcl45ZA3vSDFYepjBk8i7ZeD8QUAuA8pgiScJD+GSPuKwjQeAppOU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM6PR08MB4756.eurprd08.prod.outlook.com (2603:10a6:20b:cd::17)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Tue, 4 Aug
 2020 12:11:58 +0000
Received: from AM6PR08MB4756.eurprd08.prod.outlook.com
 ([fe80::bc7a:376d:e743:f295]) by AM6PR08MB4756.eurprd08.prod.outlook.com
 ([fe80::bc7a:376d:e743:f295%5]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 12:11:58 +0000
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
To:     Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
 <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
 <20200804054313.GA100819@gmail.com>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <b64dc485-de42-cd42-a0d6-b9962d9ca4fd@virtuozzo.com>
Date:   Tue, 4 Aug 2020 15:11:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200804054313.GA100819@gmail.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0077.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::30) To AM6PR08MB4756.eurprd08.prod.outlook.com
 (2603:10a6:20b:cd::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.39] (178.234.188.22) by AM0PR10CA0077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend Transport; Tue, 4 Aug 2020 12:11:56 +0000
X-Originating-IP: [178.234.188.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeb16269-bc0b-4f79-5faf-08d8386f95af
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53661FB5E3DC5D1E8745A8C3B74A0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBUKY2ih6fbG6wxFJRusEuN8cDKmwMI4n4Pa/++D7JHAZOpqdDjoaKMNy4CKbDU30r6clHQfj+7gP9wWEv3IQUDUaYpjxo9jtSd5QXo0kOHeu3G6hHHJRw/R2QHoYT4vxWJlrTtkSutpBdUrN0QNbPy0NH8ixcK4mZtscZAo0XaG+vRmnPVm/e4p6VrZYE8wmbXRW2+6nH4S1f+Vl/qtsYUzjXC8Zeo8q8CtFzLsgU/hKo4YFscRq6s2Zw+eNItMLwt7i59PM7eAUnsaIv+x9DuMCWI0s3nXCKJohZr0b7baRwFaDu9tPZIIWDzUISkMfDNPx0lfURNGXvBzArjpkXkRu0WQOLSzdb6swW3TBmYrhC6kDkI2yXYxNacAqLrF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4756.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39840400004)(66476007)(66556008)(66946007)(16526019)(478600001)(7416002)(86362001)(4326008)(83380400001)(5660300002)(52116002)(31696002)(8936002)(186003)(8676002)(6486002)(53546011)(16576012)(316002)(36756003)(2906002)(26005)(110136005)(2616005)(956004)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ulxsMShXsJroLakDmaK2Ag/inlKVL2o7YqmT1+P8qg/0+mjxHidkLuRhWVj6WAiX3j+P5ihggCqmGIQXInI3C5PaO0O8qF58APN4dlUlsN4x0OUbmBbu2YDYYga1nCU7MbJWagHx12awQQX+ApW6gqb04cU+lsnP2jyYp9tS42m2qxQ+iPgYaZmorbz8ZzYAU50Kb7OODh4wY5rFotynwTJVKQOi1RRmVr41RqTg/fjWolSNsiKSidW90EtVpL/PHwJFwxIMa1T4BtPIAG8h4XyXXx4Dcfay45+OlmHgHFMEIsk5KXUhAnztklHvZmGZ7MNOyt/ge9Fh/c+JOU2/Xfd3eSzih3wTeYEERv2xwyJQ/z9sr+3XIEQFDhNv6yh/o+mzVKXfy3JpINEtIy1YIEyWzialrw6aj8sKpDFKbpjN75/9DfXQ/yQvyP6u4dCITd/FTX8TvCpTjsMeppIo06kdyvaK4NJNFbsjZr4O1uR7iJ/vnwqD8g2PjpHUDBcYkvzjetyjKWD5sp3qzhwJaBXgL/U4gSfZqAf89pj+loJV7SvsWCu22NUdyZhP8EBpXe21/iCURB0myrXlavlzgv+dn0qR+0t/Us3IqJvfWMCg7p9yJCbVBuuOC+AGfRIY1HkVbMdxu3HC7bL4Mrbx7Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb16269-bc0b-4f79-5faf-08d8386f95af
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4756.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 12:11:57.9457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt5UJefHWrxhtagfDkvrnzcHwrqtLrAu057WRSARGXZGthj5j8SArIWdCBd6GoJzUxiUJbSP5YYpKFgg4ezHPjHL2t+F0+92cyVZTjPTtFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/4/20 8:43 AM, Andrei Vagin wrote:
> On Thu, Jul 30, 2020 at 06:01:20PM +0300, Kirill Tkhai wrote:
>> On 30.07.2020 17:34, Eric W. Biederman wrote:
>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>>>
>>>> Currently, there is no a way to list or iterate all or subset of namespaces
>>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
>>>> but some also may be as open files, which are not attached to a process.
>>>> When a namespace open fd is sent over unix socket and then closed, it is
>>>> impossible to know whether the namespace exists or not.
>>>>
>>>> Also, even if namespace is exposed as attached to a process or as open file,
>>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
>>>> this multiplies at tasks and fds number.
> 
> Could you describe with more details when you need to iterate
> namespaces?
> 
> There are three ways to hold namespaces.
> 
> * processes
> * bind-mounts
> * file descriptors
> 
> When CRIU dumps a container, it enumirates all processes, collects file
> descriptors and mounts. This means that we will be able to collect all
> namespaces, doesn't it?

Yes we can. But it would be much easier for us to have all namespaces in 
one place isn't it?

And this patch-set has another non-CRIU use case. It can simplify a view 
to namespaces for a normal user. Lets consider some cases:

Lets assume we have an empty (no processes) mount namespace M which is 
held by single open fd, which was put in a unix socket and closed, unix 
socket has single open fd to it which was in it's turn put to another 
unix socket and again and again until we reach unix socket max depth... 
How should normal user find this mount namespace M?

Lets assume that M also has a nsfs bindmount which helds some empty 
network namespace N... How should normal user find N?

Lets also assume that M has overmounted "/":

mount -t tmpfs tmpfs /

Now if you would enter M you would see single tmpfs (because of implicit 
chroot to overmount on setns) in mountinfo and there is no way to see 
full mountinfo if you does not know real root dentry... How should 
normal user (or even CRIU) find N?

So my personal opinion is that we need this interface, maybe it should 
be done somehow different but we need it.

> 

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
