Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592661CED6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 09:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgELHA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 03:00:28 -0400
Received: from mail-bgr052100133062.outbound.protection.outlook.com ([52.100.133.62]:30923
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbgELHA1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 03:00:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN4uV2/F8rRRoZCXFJjTdeP2Ho7Jaq3cdT28YYyaeZRq20CJo3jMV3bkWncfVUyqtyUdQwkeWoVSx56JkMCUKIf6+QllI1xRm6QDo0RqppnK27jA8zgV2bVPxGLjExkyTt4LwShEvWq0hm21J6SKnib/sCBnS3hIhmVcRh0WcWdLh2/PV+fRKGoxiYKg8uf1MwmM4c2g69c+zarIzrma9VrRHCuE6v02u/ATEzW5dV6/2yRS8TBzrVct91VRhgTMoZjGfxk5YsYyZFceEQ63CIrWllYNJQxyC06BFilVddWTKhX4maAijlORPVdYDiX6eEzPhI2fcWDvEm+rh1Wevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBhjaoWNsYjaFrHkBumgtKY4esCOOxHjsdQoLNQzMas=;
 b=BAfs5Ouq4caO83ARfnJ8Et19nkUkUjO7otvrzSAc6lxnBvBsJMJYkJaLWNJ5rshwaPhLpR3QUfjjYx0S3Z+0WqoNboAtt1hJmCpYg5/YRwRJUla96nNm9k2wTCmXwVkU1xhFozSpnodaJoBhckWKWT9z4xBY7v0MWS3ppL+0tJhhI7yoM3g4Htx4vqpngJInj6GJ1OXrsB/RmRoenxpCElpQQUg32T4BBQN1hqyNEqrD/peMGkbo90bNVslmMVIEpz2O8JokNiY451kOWmxHlAZMKZLXgz/qSNjE8q3BHQLqk6TdR2Z73KEtdXIVxA/boBKFPGM+C5lKmt3dzNBQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBhjaoWNsYjaFrHkBumgtKY4esCOOxHjsdQoLNQzMas=;
 b=OkfcX50gpSycsfkpWt2OELNiPLdL17yu/rqqAXgyi8UQ4k9M8RbY2ndq9A5y2hMmfVry4uN3Tup3hAkkxSxezHDR3Qdji4gYPbTQZ4t8N6CDtDCQFplyzADTHeifV0kOqVaJNZ0t28JvnA6O8rSv7lpGbUuOdYL+SIlcwY5aHe8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2639.namprd11.prod.outlook.com (2603:10b6:805:59::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 07:00:22 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::75b1:da01:9747:ae65]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::75b1:da01:9747:ae65%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 07:00:22 +0000
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200410114720.24838-1-zhe.he@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <367c2762-485d-a2bf-d0a7-f1f059346166@windriver.com>
Date:   Tue, 12 May 2020 15:00:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200410114720.24838-1-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::22) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by YTBPR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Tue, 12 May 2020 07:00:20 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd27ffe-57c1-493d-0d8d-08d7f64223af
X-MS-TrafficTypeDiagnostic: SN6PR11MB2639:
X-Microsoft-Antispam-PRVS: <SN6PR11MB2639FDE458918F918957C2448FBE0@SN6PR11MB2639.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWS9WvsqMK/N1GqaAK+mN29WISGlOii7HtByanGXQV/ujuNXHUTjJd3VnKOhvdS648a6xIblc/ZvzJxNQ6qG2IrxyKOvo1tGjNUyfi2IP0HxzVFuG+C62tj7o8O8kJcK62br7F27iNZ65OmSq//mnj5RH0+U9jiLJQMTiCtA8aMxSw/efIqPr7a2Ri/a/XyGVDgah8ncPmlKLB1XCFAIcbBrx5sMmm6+kBc0ATcI8CeM6pa413rMI5xGBgS2PM/ol4nVXu5dAISi0+B1sIxj8lApIoFk3KSNG164pODmx6bTbuWYugiyJIPuruihofHRy3zf4p9mMwNZBeizq7dIz3yAhmhvFQpwZ2/1U7Gk2fDKZHAbAUr54auxI5pgNtM517YagOIL2XMNRYrOCkG9ko0qItxp5XGouKoVIBeIP4eTy22TN31iPcYY2cVBYXPkXWjPPA+fBGDTqPPTFOnA/VbKLBRIm6Tr+9LT6dQSLxLRp1ryYgpggQrK0X6INxBByuAgqW4utHmWEXahgGRSFxDAEW9HFOc/8i2mR+UkUqYobjxqLuc5VoJBJm5dgfSSa3UW8NCGW73BRx2m/nxyXD91F1jJqJp1QTMaM7MznZxx59zItHMQZ8FBJQrMZe0XfsvMTZ48M2V+SuZkOiMI9k0rynC8lUoCnEHQhmMMldQ6hB5dPpjcaXa6G1bmrP7OHIdMq2/kUTjcb6jxtd5Br8z2n1ddvetMUvVgwtsqRQyrxIPzLWJ2b2aXJKv753ooZR74SBGYiNNwTNX4uxmjjOc2LSKl8eyoWePpi2dl6XMojK1VFlo/YvW5lcN1AXZakESqr0I9AB1oZcBlBU1bdawH3e969o4GQ2uGyKDM1D1UjrQv7HnzGcunMSe6aFmcodDKQ4N2RczNTsWoT6RNSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SN6PR11MB3360.namprd11.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(346002)(396003)(136003)(366004)(376002)(39850400004)(33430700001)(31696002)(2906002)(26005)(16526019)(186003)(86362001)(52116002)(5660300002)(6666004)(478600001)(31686004)(6706004)(956004)(33440700001)(2616005)(36756003)(16576012)(6486002)(316002)(53546011)(66556008)(8676002)(8936002)(66476007)(66946007)(78286006)(161623001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: 1CQWiIbEUnn2xMjNhw4BmCScBzXdzqRbKMwLY3GCMhNBPGZ6DZ15fpvz5pG2IBwg2/xQUwTT/PIuTEqYHsMlRFgcCjui9uUKc5C36Ktr92m7jiYLpEkgjsAtQmvVUvYNtc1nfN6mVuEnWUvM1+uMPyhbH1Tqp8VvsDoir1J8vANomqMrtoVylehnGuiND9WbDaZeTeQ6Nj6silZPuKQlmIOvwuHkodPX1ow9rm7COIJyhfBoka2y5UPcq5EkZ3X2wNiq0ksplk8Lp0oydhD9/dPlmPqO3igCi3qaxzHeocryvS7UeDZ/SYm25bagI3khrCAUFc7VmvRMswitT16PNfgx+PQoHqSIBOyZPgi78yhA+CgXZplwqRMyfSSbi6d7UsezExxWECi/Bt42joyO4uzoDrtXwpedd6Ynhe826wWMZos3B/8i+/M10X9w5WM7iHVu4Lf30rkFVxjWRS6vgsVmdObPkhv6KweASAGzNjE=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd27ffe-57c1-493d-0d8d-08d7f64223af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 07:00:22.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GPYTY+cFKrqzbO58BnpwiBqbwQAxFBPcnIjQK5O2dayccDdM71Lj9Abc+WC/ZL8iLfFt1KxZhR36whV4nePUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2639
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can this be considered for this moment?
This is actually v2 of
"[PATCH 1/2] eventfd: Make wake counter work for single fd instead of all".

Thanks,
Zhe

On 4/10/20 7:47 PM, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
>
> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> introduces a percpu counter that tracks the percpu recursion depth and
> warn if it greater than zero, to avoid potential deadlock and stack
> overflow.
>
> However sometimes different eventfds may be used in parallel. Specifically,
> when heavy network load goes through kvm and vhost, working as below, it
> would trigger the following call trace.
>
> -  100.00%
>    - 66.51%
>         ret_from_fork
>         kthread
>       - vhost_worker
>          - 33.47% handle_tx_kick
>               handle_tx
>               handle_tx_copy
>               vhost_tx_batch.isra.0
>               vhost_add_used_and_signal_n
>               eventfd_signal
>          - 33.05% handle_rx_net
>               handle_rx
>               vhost_add_used_and_signal_n
>               eventfd_signal
>    - 33.49%
>         ioctl
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_ioctl
>         ksys_ioctl
>         do_vfs_ioctl
>         kvm_vcpu_ioctl
>         kvm_arch_vcpu_ioctl_run
>         vmx_handle_exit
>         handle_ept_misconfig
>         kvm_io_bus_write
>         __kvm_io_bus_write
>         eventfd_signal
>
> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> ---- snip ----
> 001: Call Trace:
> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> 001:  handle_rx+0xb9/0x900 [vhost_net]
> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> 001:  vhost_worker+0xbe/0x120 [vhost]
> 001:  kthread+0x106/0x140
> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> 001:  ? kthread_park+0x90/0x90
> 001:  ret_from_fork+0x35/0x40
> 001: ---[ end trace 0000000000000003 ]---
>
> This patch enlarges the limit to 1 which is the maximum recursion depth we
> have found so far.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  fs/eventfd.c            | 3 ++-
>  include/linux/eventfd.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 78e41c7c3d05..8b9bd6fb08cd 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -70,7 +70,8 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>  	 * it returns true, the eventfd_signal() call should be deferred to a
>  	 * safe context.
>  	 */
> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) >
> +	    EFD_WAKE_COUNT_MAX))
>  		return 0;
>  
>  	spin_lock_irqsave(&ctx->wqh.lock, flags);
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index dc4fd8a6644d..e7684d768e3f 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -29,6 +29,9 @@
>  #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
>  #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
>  
> +/* This is the maximum recursion depth we find so far */
> +#define EFD_WAKE_COUNT_MAX 1
> +
>  struct eventfd_ctx;
>  struct file;
>  

