Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8001A45D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDJLqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 07:46:38 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:35516
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgDJLqh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:46:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJPXyDK6LNl+QyEk5FIT019IWjdZ5NWWCtp2lkN6/B53Pvwpl8G0Zpu1cPpY3jIGZCYzrgQmA25fvZi7xc6zCRkPpVE1MIhG8C0nfHsKW40V11AhJu0nBRylqZKlLCKwetWBBFqMbK3slH35i8h2VgA6xqopfifqIntJi4hlwQCrl3QR3Ta4KXBem9jEEWqUAyUWM8cor5grR0bmLnR88uPA4Vb97bLZtf/29I9CXzbK20cyDmfSgM1m4ZYV2smCWVlmsnAp8Ovx5WHoKS4LhBB2I9d64nns/US698njpARtHUUxpSqFYz0wEaRJ9743HWEEaEXWp6oTkhJ4uovu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqgSykLXI31yx5aWKsUYFTSt9cQSTql/8OJ+D04rzUM=;
 b=h5M8AUcul2xXXJtNmuRxQSjcXENdNChl4eeGcOmkm4Lell4aEEVS+VueF6K/8ieI0UaMHOuLcSrXRxCcSGcJN35NUy+GRlgxrTJHroBbsuRIn5Xm5xV4P6KxtV3ZTO3Xj/CbfvBA9jFWGcsJbR69sCor+bfrZflO0z9elKS6MBIEjjauuLo2r46ezBK3bNUadFayrh1QanpP319vy5Twa3TyNWd/lYbbGitbf5c6zKHeGgxabL53QytEokqLUbSWcazIRJLHZZJ7In0REvTpeWjChM4iA89lK+28DZ0mbyutbwYkREt/+Rpdq4v7EjGt16S9f087dQcW1GwmRq6ZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqgSykLXI31yx5aWKsUYFTSt9cQSTql/8OJ+D04rzUM=;
 b=ImpnX0Y/Lr2GJPVuTPosE1AUhjfgJs0tnx53Jj+G56063yQhLRVJ4L0eOT8JjR/6tpoRGz1xCuKeZ7PotEqjsNAh5W3+v9u74cNP8lNPHPBBBsVxQgMAAnu2OVUftZpmXNNAjhVsiX8sm4aKSwo09T61iMyksFtlLpbChRGDnKU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB3534.namprd11.prod.outlook.com (2603:10b6:805:d0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Fri, 10 Apr
 2020 11:46:35 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::75b1:da01:9747:ae65]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::75b1:da01:9747:ae65%4]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 11:46:35 +0000
Subject: Re: [PATCH 1/2] eventfd: Make wake counter work for single fd instead
 of all
To:     Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
References: <1586257192-58369-1-git-send-email-zhe.he@windriver.com>
 <3f395813-a497-aa25-71cc-8aed345b9f75@kernel.dk>
 <c4984e43-480c-3f9a-2316-249c61507bf2@windriver.com>
 <3b4aa4cb-0e76-89c2-c48a-cf24e1a36bc2@kernel.dk>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <ba1fb583-4769-a747-2cc7-2bce30cdb984@windriver.com>
Date:   Fri, 10 Apr 2020 19:46:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <3b4aa4cb-0e76-89c2-c48a-cf24e1a36bc2@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:202:2::18) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR0401CA0008.apcprd04.prod.outlook.com (2603:1096:202:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Fri, 10 Apr 2020 11:46:32 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1543efd0-da14-49af-459c-08d7dd44d230
X-MS-TrafficTypeDiagnostic: SN6PR11MB3534:
X-Microsoft-Antispam-PRVS: <SN6PR11MB3534B3DB8472D47BD6D1C4468FDE0@SN6PR11MB3534.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3360.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(376002)(39850400004)(346002)(136003)(366004)(2906002)(6706004)(36756003)(16526019)(66556008)(66476007)(66946007)(8936002)(81156014)(86362001)(6666004)(8676002)(31696002)(5660300002)(316002)(956004)(2616005)(6486002)(186003)(478600001)(26005)(16576012)(53546011)(52116002)(31686004)(78286006);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yib2kzhgu4sQsJTw41lx8FqgBZkKhY2X7gEtJPQHXYk3Lx+OuMNdSnLQA9syJQwbtbaiQTvFftbevGDeTzqTU6UrO3JGkTEASlQCcTt6jPH2SCuF9SNjpbtlWUoQ0md2bZPeVtKQRRcgyosVvYHHO7TwNcyjI38grPtRlAoVlkrvjA57Ea0ROrjW+pJ3ectmI13PkIPikyxmu0s1EJiAxU2KCcbi2sv1YaCDojXhFVXHwVc8cUhUmY/aJXV71Ijn3CI90o6snby9HmrrJZ42anKMdomTDZpN8moUtw0Fh19Keyl0IfpA9MczO2JTz3UYSM6aQ4pRYLIi/rabhO4bWSbbey/zSgxJFNwhK8Me0a24I/8EF83qcjfPvTT380B2NzhP9DRatedEITbaWm2L3aK2kotudFq/JxARBHySKOaRed1PboKqNyaRk9Flz6WHH831vGNlk5vN0NpKoVpz8YSP7TalfJciKhuPWiPhwlbB62QQQcKwZ/WmL5u5LNs5tnhLNxwf/hNbSvuHYXe7GhFcNW+ofTCBYD9tK7kioUQ=
X-MS-Exchange-AntiSpam-MessageData: AAd7I/WSjuGMvHsAZ/zru9aa+mjjT4LOROclB69dFLPC9Figbk21chwnSc41OdeRH8h72AuZRQqQpByKvK9zcwSYBwyKq+SxYmrt4wvf11M03IqbEQjGtOPzSUMFqeJIX+hUQdyRkSUbDm4bpAXY7Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1543efd0-da14-49af-459c-08d7dd44d230
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 11:46:35.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPnD35bUHjhbLKCS5zJPlf03jWI9vPp0obcrJ/hhZNx789CS3nWdsM2k3B9miAlfOClh0z6/PwYp45u2BE92Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3534
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/9/20 11:44 PM, Jens Axboe wrote:
> On 4/9/20 3:37 AM, He Zhe wrote:
>>
>> On 4/8/20 4:06 AM, Jens Axboe wrote:
>>> On 4/7/20 3:59 AM, zhe.he@windriver.com wrote:
>>>> From: He Zhe <zhe.he@windriver.com>
>>>>
>>>> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
>>>> introduces a percpu counter that tracks the percpu recursion depth and
>>>> warn if it greater than one, to avoid potential deadlock and stack
>>>> overflow.
>>>>
>>>> However sometimes different eventfds may be used in parallel.
>>>> Specifically, when high network load goes through kvm and vhost, working
>>>> as below, it would trigger the following call trace.
>>>>
>>>> -  100.00%
>>>>    - 66.51%
>>>>         ret_from_fork
>>>>         kthread
>>>>       - vhost_worker
>>>>          - 33.47% handle_tx_kick
>>>>               handle_tx
>>>>               handle_tx_copy
>>>>               vhost_tx_batch.isra.0
>>>>               vhost_add_used_and_signal_n
>>>>               eventfd_signal
>>>>          - 33.05% handle_rx_net
>>>>               handle_rx
>>>>               vhost_add_used_and_signal_n
>>>>               eventfd_signal
>>>>    - 33.49%
>>>>         ioctl
>>>>         entry_SYSCALL_64_after_hwframe
>>>>         do_syscall_64
>>>>         __x64_sys_ioctl
>>>>         ksys_ioctl
>>>>         do_vfs_ioctl
>>>>         kvm_vcpu_ioctl
>>>>         kvm_arch_vcpu_ioctl_run
>>>>         vmx_handle_exit
>>>>         handle_ept_misconfig
>>>>         kvm_io_bus_write
>>>>         __kvm_io_bus_write
>>>>         eventfd_signal
>>>>
>>>> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
>>>> ---- snip ----
>>>> 001: Call Trace:
>>>> 001:  vhost_signal+0x15e/0x1b0 [vhost]
>>>> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
>>>> 001:  handle_rx+0xb9/0x900 [vhost_net]
>>>> 001:  handle_rx_net+0x15/0x20 [vhost_net]
>>>> 001:  vhost_worker+0xbe/0x120 [vhost]
>>>> 001:  kthread+0x106/0x140
>>>> 001:  ? log_used.part.0+0x20/0x20 [vhost]
>>>> 001:  ? kthread_park+0x90/0x90
>>>> 001:  ret_from_fork+0x35/0x40
>>>> 001: ---[ end trace 0000000000000003 ]---
>>>>
>>>> This patch moves the percpu counter into eventfd control structure and
>>>> does the clean-ups, so that eventfd can still be protected from deadlock
>>>> while allowing different ones to work in parallel.
>>>>
>>>> As to potential stack overflow, we might want to figure out a better
>>>> solution in the future to warn when the stack is about to overflow so it
>>>> can be better utilized, rather than break the working flow when just the
>>>> second one comes.
>>> This doesn't work for the infinite recursion case, the state has to be
>>> global, or per thread.
>> Thanks, but I'm not very clear about why the counter has to be global
>> or per thread.
>>
>> If the recursion happens on the same eventfd, the attempt to re-grab
>> the same ctx->wqh.lock would be blocked by the fd-specific counter in
>> this patch.
>>
>> If the recursion happens with a chain of different eventfds, that
>> might lead to a stack overflow issue. The issue should be handled but
>> it seems unnecessary to stop the just the second ring(when the counter
>> is going to be 2) of the chain.
>>
>> Specifically in the vhost case, it runs very likely with heavy network
>> load which generates loads of eventfd_signal. Delaying the
>> eventfd_signal to worker threads will still end up violating the
>> global counter later and failing as above.
>>
>> So we might want to take care of the potential overflow later,
>> hopefully with a measurement that can tell us if it's about to
>> overflow.
> The worry is different eventfds, recursion on a single one could be
> detected by keeping state in the ctx itself. And yeah, I agree that one
> level isn't very deep, but wakeup chains can be deep and we can't allow
> a whole lot more. I'm sure folks would be open to increasing it, if some
> worst case kind of data was collected to prove it's fine to go deeper.

OK, thanks. v2 will be sent.

Zhe

>

