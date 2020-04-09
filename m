Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC91A3294
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 12:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDIKh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 06:37:27 -0400
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:20832
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgDIKh0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:37:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FU2MA7EVlQEwDV2w4TfE0nQJQJ3X3r64ivslGJEF8tXvWhaL2uzUGRuz6y0hkSTdjfauzcIVsgxN0AMUYDL/xnTsDzqPbmGnYapDu38g7dSrnYJ5AxWY+OH4RIg+t+VOAbaZ2F/67St31OYZrF7/eDlRqLMfS04aIevUeSF0jPPDNrupoEtY7wTuUNlzAc9RWo3R3T43hviMUFeWfzaHUDXkKGZutj0bEaEo20A4wU1qhCqjqMgRMOJvWoX/4DtSi9cJUINLs7lN+DAjVn1cr9IVgyC+nlGmjPXljhHDIPlnJ9dMUDlDhl9ORxzWdgrhtQXsinQULSuoOYP27Gpnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEm0sS68S5Qe4CNORcRWtf3C+XtfzUKSpEe+YKZO0+4=;
 b=oWHn3foylD2YyBWvRKKhDPHtJR0ERRE4Zo87y+es63Vjo//So+HxUnVOXdHiTlAGK4xbR1XPwwaZ/ShrI0hkVccqTl7pXIrb0YgFcOUAvVnFm8oeUBE9jl4BpZuHOlYxAYpYNdKqGqONMg1TrTlbtiw+YC8ldjM+WA9Db5B4Q4AS5doosSeeoOsvb+GrLOLPazNs51tfZP0N+FdpV25MpSw3jlsxwt/qH5r5W/FkY/wu22LLeXOnrt+WWbIrhCg8SagncARvK3JYzqpfxh5oBT8wlrZWIJwwBrbQz7Az4yRHdfUxfwqtF6HIDz8P63cvI0/kRrI94zOacUnQhhg8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEm0sS68S5Qe4CNORcRWtf3C+XtfzUKSpEe+YKZO0+4=;
 b=qQ7UOUxAnXQnOzxqXk5p9iUirftmZvd45LvUvLj4vcqsqI0jWIVtzGlfyZTv2uWBZO864KCBv4NWwm7mXP1BDsCDTum/SO2I4olNH1n1xdENIMA9eD0Up3cr1r9hJSMw0zxwAp3IPWkHSVoeHnSWznvzZnDdvI3DbdJnpBS64cA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2544.namprd11.prod.outlook.com (2603:10b6:805:5d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Thu, 9 Apr
 2020 10:37:23 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::75b1:da01:9747:ae65]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::75b1:da01:9747:ae65%4]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 10:37:23 +0000
Subject: Re: [PATCH 1/2] eventfd: Make wake counter work for single fd instead
 of all
To:     Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
References: <1586257192-58369-1-git-send-email-zhe.he@windriver.com>
 <3f395813-a497-aa25-71cc-8aed345b9f75@kernel.dk>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <c4984e43-480c-3f9a-2316-249c61507bf2@windriver.com>
Date:   Thu, 9 Apr 2020 18:37:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <3f395813-a497-aa25-71cc-8aed345b9f75@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16 via Frontend Transport; Thu, 9 Apr 2020 10:37:20 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aabdb2d-b935-4fcf-c124-08d7dc71fd00
X-MS-TrafficTypeDiagnostic: SN6PR11MB2544:
X-Microsoft-Antispam-PRVS: <SN6PR11MB25448C052699781E5D40F4E28FC10@SN6PR11MB2544.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3360.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(366004)(39840400004)(346002)(376002)(136003)(52116002)(53546011)(31686004)(5660300002)(31696002)(66476007)(66556008)(66946007)(6666004)(86362001)(186003)(6706004)(26005)(8676002)(81156014)(956004)(36756003)(16526019)(316002)(81166007)(2906002)(6486002)(16576012)(478600001)(8936002)(2616005)(78286006);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/ztEb50SLzbF4luLysrIka18gG8T4gFAslOhP79nXgxefX/QYtW7mUa00tnjEjcgfV6eiO4r+8QB2H7yFM2omIlT3bpM1T6RoYdhU9lLHwP1PvViQlsk6cdrUHEiQLYw7rKHLOQ3OzMXFM05eA7ERa76jSO/5l1P3soxVtaAwhSmFS0QwhmG/OPdsvVtn+G6cy5RRoeSOND1ZBFvrblNXDOTTPUyNW97S7AtAcqEBmvaFRkuczebFHFS7FishCMwkdlLxlVO2ZRoAkkMdU9OioPB4jABrUo55qklw8zo52lfuQQ/y5+8DITKc/4VT/1jmtnzekPgl6eZZ9je7F9j75YLkxpNN0ankKn0wewrZhJ1fwstkCmIZy0gfSLTSLxYyShwOefcXbucAq2HW3fgiy2Hrc86gjM9AWpuaktaaKjkr2KsEY+dQ3woyR/7WCVbS9C8oherpCbwZO0Frlxd+nAG/pfCO7P7RVVa9rZUvsMR20qAyaefdeR2hxoA9/hVgkkNeaURkV76fD4wgLlKEC6nqXS90XF9ytAXQ4eaGU=
X-MS-Exchange-AntiSpam-MessageData: Nsr7oabrpxrQMqHJVQBLOJlaByHyY+qhb5AdJFLNnkRRJPsXT//uAKU2sMqrNf/AvipawI04BwW4iBQ3Rgcd5WV8zXWXuHAC3Y/JiI/7zEkmfJWHawLzFOXRIAWhMYFrkhlnGIfPqYS05/2p/J4DVw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aabdb2d-b935-4fcf-c124-08d7dc71fd00
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 10:37:23.2803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWgN/dbgk9xmakECRMdxVFQxb3Eb5nW39bzsJXohfQF8183orNKZnaFW/OnYXqIZogjaCf136BuFto4wdIvRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2544
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/8/20 4:06 AM, Jens Axboe wrote:
> On 4/7/20 3:59 AM, zhe.he@windriver.com wrote:
>> From: He Zhe <zhe.he@windriver.com>
>>
>> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
>> introduces a percpu counter that tracks the percpu recursion depth and
>> warn if it greater than one, to avoid potential deadlock and stack
>> overflow.
>>
>> However sometimes different eventfds may be used in parallel.
>> Specifically, when high network load goes through kvm and vhost, working
>> as below, it would trigger the following call trace.
>>
>> -  100.00%
>>    - 66.51%
>>         ret_from_fork
>>         kthread
>>       - vhost_worker
>>          - 33.47% handle_tx_kick
>>               handle_tx
>>               handle_tx_copy
>>               vhost_tx_batch.isra.0
>>               vhost_add_used_and_signal_n
>>               eventfd_signal
>>          - 33.05% handle_rx_net
>>               handle_rx
>>               vhost_add_used_and_signal_n
>>               eventfd_signal
>>    - 33.49%
>>         ioctl
>>         entry_SYSCALL_64_after_hwframe
>>         do_syscall_64
>>         __x64_sys_ioctl
>>         ksys_ioctl
>>         do_vfs_ioctl
>>         kvm_vcpu_ioctl
>>         kvm_arch_vcpu_ioctl_run
>>         vmx_handle_exit
>>         handle_ept_misconfig
>>         kvm_io_bus_write
>>         __kvm_io_bus_write
>>         eventfd_signal
>>
>> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
>> ---- snip ----
>> 001: Call Trace:
>> 001:  vhost_signal+0x15e/0x1b0 [vhost]
>> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
>> 001:  handle_rx+0xb9/0x900 [vhost_net]
>> 001:  handle_rx_net+0x15/0x20 [vhost_net]
>> 001:  vhost_worker+0xbe/0x120 [vhost]
>> 001:  kthread+0x106/0x140
>> 001:  ? log_used.part.0+0x20/0x20 [vhost]
>> 001:  ? kthread_park+0x90/0x90
>> 001:  ret_from_fork+0x35/0x40
>> 001: ---[ end trace 0000000000000003 ]---
>>
>> This patch moves the percpu counter into eventfd control structure and
>> does the clean-ups, so that eventfd can still be protected from deadlock
>> while allowing different ones to work in parallel.
>>
>> As to potential stack overflow, we might want to figure out a better
>> solution in the future to warn when the stack is about to overflow so it
>> can be better utilized, rather than break the working flow when just the
>> second one comes.
> This doesn't work for the infinite recursion case, the state has to be
> global, or per thread.

Thanks, but I'm not very clear about why the counter has to be global or per
thread.

If the recursion happens on the same eventfd, the attempt to re-grab the same
ctx->wqh.lock would be blocked by the fd-specific counter in this patch.

If the recursion happens with a chain of different eventfds, that might lead to
a stack overflow issue. The issue should be handled but it seems unnecessary to
stop the just the second ring(when the counter is going to be 2) of the chain.

Specifically in the vhost case, it runs very likely with heavy network load
which generates loads of eventfd_signal. Delaying the eventfd_signal to worker
threads will still end up violating the global counter later and failing as
above.

So we might want to take care of the potential overflow later, hopefully with a
measurement that can tell us if it's about to overflow.

Zhe

>

