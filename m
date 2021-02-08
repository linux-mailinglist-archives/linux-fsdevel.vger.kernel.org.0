Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702A63132D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 13:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBHM6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 07:58:15 -0500
Received: from mail-db8eur05on2128.outbound.protection.outlook.com ([40.107.20.128]:29988
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229888AbhBHM6I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:58:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3ZPvjXa7voinmxVfxiNAGFc6U+SsVMUOYAcVvX4kLLMKRV9WdXAhEC5tlGc34ypEhlX9gWxGfEgVyWo1BnEiI7ixfGuFv6LPIl/kWxBDIT9Ktp7vxwfTKdu90ab3ByUFC2Tp3gFpWxjbZA5T+sZb+1/I4lyzW1otdBa6XSVE5J+zkjORXepEx8wAueXgQ15dXFGXTJQlBbsafT5rDPaqyElpU0R8D/URdIjpX2kNf6gHiruTOD3GA6CLrCmNqWyYrcim4/p+FS6rSvg6iyDVQeEnvE+1d2Bc5K48eUR/F+ZEL61kzeyUWTEC9EjX8tNZ68ehKps2G8ffUdFKRSA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfRtUorABMOjOP5EnQ9/MDgwOChS1vdm0xcnA4Yrw/s=;
 b=bDgemiNhCb89deHWuoOOzJUY5DceX1AGd5O+vV6BoUcOmOUv2isWiBkbhI0LexJ1nQupeMo9dhOhuTLoTtCdWTUIjrR14qqcZfBwn9AoiCsRkqBiKsIO8yRz+Yto3rKXx+VehtDmyuSjXUa7WBdcMdHatOr7WtfAvpGErxnUKPJiGRe/T9IAfi+qSe2yexrNh20DUuK82s4E4OtPZQwcu1h/KOgJD3COFTdNfwSKeiUT81aQNSCE94hJiWdPG0OyJoSND3xrcvR3njaXOlWx1rq4/jqgHIjmlFwQAoh8inBhH1ET+PoThexK450EX61JTTBqf9XkNzX0ZEH585ARAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfRtUorABMOjOP5EnQ9/MDgwOChS1vdm0xcnA4Yrw/s=;
 b=HrxBoGRzXfaiMUB5HCDRkNlS16RgCks2/3Lo2VjOkRPvb5iJyNWIeGqcysOaGHH7UqfgsVzZbjS6m2MNSexxqHy+TyWNIrsVjVRdVK9ngcAzHeAJCEjvE7Ux84uQx14D0ONRxiSNmm2uQGv4A1hKc4kXRhKseejItwl4clbztzU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR0801MB1950.eurprd08.prod.outlook.com (2603:10a6:800:8c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Mon, 8 Feb
 2021 12:57:17 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::61e0:7654:24b6:9159]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::61e0:7654:24b6:9159%6]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 12:57:17 +0000
Subject: Re: [PATCH] fcntl: make F_GETOWN(EX) return 0 on dead owner task
To:     Jeff Layton <jlayton@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
References: <20210203124156.425775-1-ptikhomirov@virtuozzo.com>
 <20210203193201.GD2172@grain>
 <88739f26-63b0-be1d-4e6d-def01633323e@virtuozzo.com>
 <20210203221726.GF2172@grain>
 <948beb902296da5bb5d1a0db705ecb190623af84.camel@kernel.org>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <ff782e1e-6fe9-4730-2528-76dc07211e0a@virtuozzo.com>
Date:   Mon, 8 Feb 2021 15:57:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <948beb902296da5bb5d1a0db705ecb190623af84.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [81.200.17.122]
X-ClientProxiedBy: AM4PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:205::28)
 To VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.192] (81.200.17.122) by AM4PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:205::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Mon, 8 Feb 2021 12:57:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 906ae596-5e60-4518-c63b-08d8cc311049
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1950:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Antispam-PRVS: <VI1PR0801MB195063FB6E255BFAB6A79579B78F9@VI1PR0801MB1950.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IL3hfwt0NjaoRtZ7NsRMfcOxC5MfmfYKQZe7qJHGoHr3L4ozD1HuRB0Q7v0YFNOEBWx/v0sZzdA7TllQQvWcCBVFuoBF092qDyMGulihfMMrkbAUlM7imCp+tBsGj3r/x9S4VE7VK59ssGmCzeKmv7ixrkc9Yk3cZZhKgTI6TezUN7q2yMVrH+0EKWDO0vEx8N6toBoWak+Y+07ynKX9An2JM6B92wszeLXCyuJAWxs8CFBcT/m0jSlVx3Fl2S7DF428kbEoCaCrR9h/MQQrjL3v1cbn3wEeR+B7Ex/FTxAi5qsXZuPFP03bb7rF0AocSh2Wl/zMTMDZOHM6yvceFIaPkev6IEpkgLSrbs+usiDvv7iAzZ+AAQ19th48BX5Cs+UmpAvTbShugjWDZXvUPhU7dR03LNmm/qrY/DRfyxpVKr6SoWzSbwuqI0C3dzHLubYDlRcyeL6jkSQxGpUFNs9/FrrN0tl2TvsozOCNSvjfWw98I5a31qtQgh1xkZzQu9YzYdXX9gDZDKRrNRb4XZBrx/17RjpR2jHjdIuvuSgYXR6TvGQ/gFWJ2ZpH36+3HCTIDqNZ993C0a3h7toqxVC0Xvis5x2E4FC03H0ik0TmN8K519lEHoqVO6cnCDxbrZJUZ3uG7u0xsDV0uMG7+0D1VZsHbz2EoUR1NRnfVcf+ECNahr/TcnpkvyrmMzE+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39830400003)(366004)(966005)(26005)(8936002)(956004)(66476007)(4326008)(5660300002)(86362001)(52116002)(316002)(16576012)(31686004)(6486002)(54906003)(110136005)(36756003)(8676002)(2906002)(66556008)(16526019)(83380400001)(478600001)(31696002)(2616005)(186003)(53546011)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-15?Q?4AL2RVPklVH+jxko5d9KlrvZ54h+IVC9ZoaKpYNSc+nOjoHMAbu2I4XhQ?=
 =?iso-8859-15?Q?J+AzYxwdEQqkeB0+6MJs0yWRtFLch8aqSc6LZigmDc13lyDWF1KO3Sd0l?=
 =?iso-8859-15?Q?T3zG+FgZ3zg/jFpvQkJ5utkCbEQuFGBN/6UZsjfaVFykmzXo3RRceNA9r?=
 =?iso-8859-15?Q?tb4uV1upM0Ty9iDKMuV/tMvwH930S9PqD+n2tNAT/WdvByyYdNwjTFccm?=
 =?iso-8859-15?Q?OXlkz+p8v+YfcAu983gZDTsd0hOgWua8+j72M6CcDD437RBibtPM9q1wB?=
 =?iso-8859-15?Q?vsfpMoHFxRM2OJ/dz7xFG5U81fQu0K5D/j8mtMzlwd55PfXzIgdMJ/onS?=
 =?iso-8859-15?Q?HzpaGsi+7dJrQUDeLV/bphsg/p6HWeEUi8k8WWD0OFwg3/lalLmQH8M6o?=
 =?iso-8859-15?Q?YiqScMcTCPX4n98tUvHbjVYlC+C9WU2qBs4ku4PbbTjr+X2XFGXOL/rw0?=
 =?iso-8859-15?Q?g2IVaaD8M+0PpVEOVJrPEodlD6U1m2xkt7IBrzzKLthW0WORluUdDohHH?=
 =?iso-8859-15?Q?C50JwaIwEEJmfzDjkhN+8ePrqOvPFR3QCy6tfNoiutVUJK2JzjNTMAmnf?=
 =?iso-8859-15?Q?cqGOZUu+UyiPIOLaxOVJpNm3o5rFvRbTteXYEpfOO/N0EuM8EJQnbzj2G?=
 =?iso-8859-15?Q?vQr/nake+iN7GhBAPNjqqg4ylRhLlXhogMVtvgYS6CVgDIUyG75Ypr8Xu?=
 =?iso-8859-15?Q?Ubu5sztv0BT8aRzHtu52emNqRFJTo+PLJjh8+X8kOdg0+JOEsRQYkgM4t?=
 =?iso-8859-15?Q?yI2AFTl8mCTcrQd9ZF3o4akTlhT0NeKcVMAVenAt2SgQkzegqt2YVm08A?=
 =?iso-8859-15?Q?V0A9rrWrvxbD0hETN/P/pCrXOdND/dWWD4K8dBV2vd5GLBva7vqIOmVB7?=
 =?iso-8859-15?Q?BrA85gFZHbiVisNPJM2IdYmH/F5aZiHf6x1l2yQ66Ine+VLA0XrhCIF8o?=
 =?iso-8859-15?Q?6Ayo3iprd3Tnw9yUT1nGcx7eG/iUkFWw9GBYrPN0Bl1PAosLTWSElg8TI?=
 =?iso-8859-15?Q?jCdgC2492LRAaEHzQYvBB6fPAkEJyjFewLo0+tlL4+Ll1N1xKwXJOcyXp?=
 =?iso-8859-15?Q?4h/xXPorfxPuFkRm0d4W4Q/9CczD9Y7o7N+euPR0e0gQkFPC+AmsF6ZsM?=
 =?iso-8859-15?Q?0OipKyvXgWOhYucXq5Y2bswvMd5h+zg3QTMHlsnKz+CtTbw3IOUTq6kW3?=
 =?iso-8859-15?Q?h7ufKD0QV5DBoBnKSSwIW3opH5typpH7uKsumQm/q7nxuh5SOq9keu/u9?=
 =?iso-8859-15?Q?clSLUY9A3Qpt0kyWoMzTKPW1K/+7ywyzp2fMzLG/ijHY5cYnFnmpjm+SH?=
 =?iso-8859-15?Q?Y8qtTbxvYb/fr69Tyi0EfzuFA2NW+UntARxMA4wzQk1WQj5cgFKyaE1uL?=
 =?iso-8859-15?Q?sOYadrpzfDpcYRwIOcOoQnpOiWan4VAlz?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906ae596-5e60-4518-c63b-08d8cc311049
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 12:57:17.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYQF9A3QNWAi238K2/KjbzAIyJssdhBePX4nLdiDN9TnMR+YxkRlWL43mJt9ULhtVrpvt7bjDXygNNRQGzHYrSe7sbguJkHrWfO3b2PA8wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1950
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/8/21 3:31 PM, Jeff Layton wrote:
> On Thu, 2021-02-04 at 01:17 +0300, Cyrill Gorcunov wrote:
>> On Thu, Feb 04, 2021 at 12:35:42AM +0300, Pavel Tikhomirov wrote:
>>>
>>> AFAICS if pid is held only by 1) fowner refcount and by 2) single process
>>> (without threads, group and session for simplicity), on process exit we go
>>> through:
>>>
>>> do_exit
>>>    exit_notify
>>>      release_task
>>>        __exit_signal
>>>          __unhash_process
>>>            detach_pid
>>>              __change_pid
>>>                free_pid
>>>                  idr_remove
>>>
>>> So pid is removed from idr, and after that alloc_pid can reuse pid numbers
>>> even if old pid structure is still alive and is still held by fowner.
>> ...
>>> Hope this answers your question, Thanks!
>>
>> Yeah, indeed, thanks! So the change is sane still I'm
>> a bit worried about backward compatibility, gimme some
>> time I'll try to refresh my memory first, in a couple
>> of days or weekend (though here are a number of experienced
>> developers CC'ed maybe they reply even faster).
> 
> I always find it helpful to refer to the POSIX spec [1] for this sort of
> thing. In this case, it says:
> 
> F_GETOWN
>      If fildes refers to a socket, get the process ID or process group ID
> specified to receive SIGURG signals when out-of-band data is available.
> Positive values shall indicate a process ID; negative values, other than
> -1, shall indicate a process group ID; the value zero shall indicate
> that no SIGURG signals are to be sent. If fildes does not refer to a
> socket, the results are unspecified.
> 
> In the event that the PID is reused, the kernel won't send signals to
> the replacement task, correct?

Correct. Looks like only places to send signal to owner are send_sigio() 
and send_sigurg() (at least nobody else dereferences fown->pid_type). 
And in both places we lookup for task to send signal to with pid_task() 
or do_each_pid_task() (similar to what I do in patch) and will not find 
any task if pid was reused. Thus no signal would be sent.

> Assuming that's the case, then this patch
> looks fine to me too. I'll plan to pick it for linux-next later today,
> and we can hopefully get this into v5.12.
> 
> [1]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/fcntl.html#tag_16_122
> 

Thanks for finding it!

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
