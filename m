Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B12213926
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGCLLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 07:11:35 -0400
Received: from mail-bn8nam12hn2202.outbound.protection.outlook.com ([52.100.165.202]:12727
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725984AbgGCLLe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEv9UmcDJHV0X7/gblLQ0StKRFadByUC1A0N/ZzkMfjFnkqVXCiOxoo34dtvNwN4Jpola7vWm7xDiGOgRG57VlJVRPnocuHwbIcSLuA4SQK0xmg96cqXh9Tv0ygV1/Zb+GVV231tZQULAhMtefiug3uQ/LORI+xdexWMD+4AdGpr7yY+s/1UUHRcarIokn1FDfGUAlTWrIxR7+r2cKZcoOpY8yPHmuywI4diOJhWbOagq8rYC6glCYQofu7/R6Sf4qwMIz2trHEzZHUUeBZElNWYKxxm9TRLNZlz3cbPNJpFxKsIFXXy+P59irwXJRshIFK7OJCuKg/axciYXOpQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8HWjSRLHc82CDOPAo5ARW4p6SsflqwsHhfCTEKLvlo=;
 b=Du4Ewz8HtbEEuzR3m1A2KddH593Tj3Q6rRSE/lNYVrB1CSeOqrlXpV76XSYciaKpIG/yi4wBEblX3Vpq9yBtIqlF3GMpl+WOpPkMJkh/4vZxHbng1VaDAqZCFHy6J6lmVWVhqTlixE4UXPkk00KbL9Az+mhOhMGmwhAhd/Nk2sGMNnxMeABws1fmyggvg/XJFRTVZnG8cz8JzA/TTT3RrEkc4IxvemH/WTkcZyZ4yLRtDwjyoNOhkV44+43KfNIGE9+DOWDshgTma1Cpmpf61G0+3n7/jgDHVXs+c9SzGGCyKXp2pKtWyXyh8Yic/6I02qBm9BhnNjSwef6npJ58jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8HWjSRLHc82CDOPAo5ARW4p6SsflqwsHhfCTEKLvlo=;
 b=O5dkmoAOxL6jSyaeCfTPenJya+xL8Nh12q1MhVzLqrZ0Ok6kWvHAvSXb6ptxLxR1b/JtowtwzsRcSZDFGZIysiRd6IDhvOvxQSqPKAAxkgkU1zly+yvW39/jtkyjO98p0MCBqvWQAIH2PJb6IfpMCT7jIOhESXsMB4bxxvha99A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 11:11:31 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::b15b:3bd8:5bf1:1a55]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::b15b:3bd8:5bf1:1a55%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 11:11:31 +0000
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200410114720.24838-1-zhe.he@windriver.com>
 <20200703081209.GN9670@localhost.localdomain>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <cbecaad6-48fc-3c52-d764-747ea91dc3fa@windriver.com>
Date:   Fri, 3 Jul 2020 19:11:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200703081209.GN9670@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.1 via Frontend Transport; Fri, 3 Jul 2020 11:11:29 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc5b62a-195d-4f91-cd42-08d81f41d6cd
X-MS-TrafficTypeDiagnostic: SA0PR11MB4670:
X-Microsoft-Antispam-PRVS: <SA0PR11MB46705AE8BCD759919F4AD8AE8F6A0@SA0PR11MB4670.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eN+zepoM+SE8IItbqylZs4GnZdhUDqllhnOAYmOjWPqktssFSHCiX+tnF12A8sZLOMgNW9eEu1szTjkv2G7Pxk4DDVkzyG4MU5Pxu7yJwxLAOWaHw+o3Y1r9wzzlM87/FJY3t852HAC4cub+FaRIyVPwG40oObpUaGg/PU7ml9MKxADnF0aZJK/aQyI6B8qfI7PWTE+bMk8ZwXD6SfZ1XZPv2c6EDqaHuC167MS+PR6prUqiztcqVXrf6Paour1BIj1ks8242TInH7ryCEs/IvW7VAzuag7mTBf0hT41nyNTvfP6+QszuUYrZYtqZC+7VLHZ2WUISh+aqdzDHd43bVxOMhry+8PhewZUfwDuf5EzEU6rI/cACHJEaYNnSvsFt9dBCHM7YiLxexzaKAO9lHdDBwfzBSys9E431GtP9UM7yZHFFO0nTpKzJVoLDHO/hpwMrTKrFi6NTSRfYCBJK9zfg3fFT9YU7gcY3Kn7v0/u1LeziQbyRu3N1im/2S3bnZWPyhMwr1ZcbF3xOkO7syaHkonetHIEhesh8rUUJ0nRmJo2+7WYuBh0jZYRImjRt2jocOdXulqF994Pooho0u9/nix9dZ5OqVNkTMFi8O0Ivahd37Qjigwi1tP+c5MIjlthuS1EhJgKlmr9k1wdQL+AuKUCbvsov0e7lEQgEjksA/Mdmz0V8GgYn8ogqJ/+TcUFiHJLBnwpbSpVRR7uKdhHv9iP+9eMcpD3LUgUTz3xAdeUbkJ69diUbHPJzgs5CvWU5+ZgceTMPFznfHPZXpjyEtlqF6mwGj9EEWRv8Ew/kDliOmRHqa7udBCk032MxdDHZ9hhb7G51XsVAarTdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SN6PR11MB3360.namprd11.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(39840400004)(136003)(396003)(366004)(346002)(376002)(8676002)(8936002)(5660300002)(966005)(2906002)(478600001)(956004)(2616005)(66476007)(66556008)(6486002)(6666004)(16576012)(6706004)(16526019)(6916009)(26005)(186003)(66946007)(86362001)(4326008)(31686004)(316002)(52116002)(36756003)(83380400001)(31696002)(53546011)(78286006)(161623001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: nNriU6NcfJry6ZZ9S5735jdZXxekbu0r0oLGsL3X2/3c3qVCMnryE6f9kSwA2Y3+2SapsJO8jnA1uwjnHGON/SI6mpiht2exIIblubQBgZMmaYEJ7k75ORutAt+poWLkm0/QHexSlUQ0+O1p47WCwt/6rv9iKTsDcrhseW8l6n74d+l+2xP8bsxZgwafvsJ5Gn/FmqjjvmAe91OOK1xj80D8iUPtEH5nhV5sVwkppS72DrgF4s9s/39Nk4WOfqSkM7pFoYIjct74u9Td9cfmDwwKIorEpnjq2rSXD9Mrr0TrgXYAmblfuxvq9QeQqFR9HCsH2yZwRqGm0qbuW61ICCVKO4o9bgmmmifGDb4HD8iI7wTEpfwr8LAq9Igw81FTblQJ586PVkH2oLXAFRKyOdJcCyboAGF21XRw6M/fIfILFkKVtrml3MMW//UmA8KXe0JDWq85598itv0HJRshzL/zeWwDLUH46exiqzXBXys=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc5b62a-195d-4f91-cd42-08d81f41d6cd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 11:11:31.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvnapW1Pz989giSE/q0+TXQA2O+51azuQT+Jl/CFKR9hO+uC4b3HkS/ajCqIg1n7Kv7DU5TTAH46YH6ZfI7hrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/3/20 4:12 PM, Juri Lelli wrote:
> Hi,
>
> On 10/04/20 19:47, zhe.he@windriver.com wrote:
>> From: He Zhe <zhe.he@windriver.com>
>>
>> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
>> introduces a percpu counter that tracks the percpu recursion depth and
>> warn if it greater than zero, to avoid potential deadlock and stack
>> overflow.
>>
>> However sometimes different eventfds may be used in parallel. Specifically,
>> when heavy network load goes through kvm and vhost, working as below, it
>> would trigger the following call trace.
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
>> This patch enlarges the limit to 1 which is the maximum recursion depth we
>> have found so far.
>>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
> Not sure if this approch can fly, but I also encountered the same
> warning (which further caused hangs during VM install) and this change
> addresses that.
>
> I'd be interested in understanding what is the status of this problem/fix.

This is actually v2 of the patch and has not got any reply yet. Here is the v1. FYI.
https://lore.kernel.org/lkml/1586257192-58369-1-git-send-email-zhe.he@windriver.com/

> On a side note, by looking at the code, I noticed that (apart from
> samples) all callers don't actually check eventfd_signal() return value
> and I'm wondering why is that the case and if is it safe to do so.

Checking the return value right after sending the signal can tell us if the
event counter has just overflowed, that is, exceeding ULLONG_MAX. I guess the
authors of the callers listed in the commit log just don't worry about that,
since they add only one to a dedicated eventfd.

Zhe

>
> Thanks,
>
> Juri
>

