Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38879162B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 13:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfEGLWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 07:22:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfEGLWc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 07:22:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FF76155E0;
        Tue,  7 May 2019 11:22:32 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12EA91FC;
        Tue,  7 May 2019 11:22:30 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Shenghui Wang <shhuiw@foxmail.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] io_uring: use cpu_online() to check p->sq_thread_cpu instead of cpu_possible()
References: <20190507080319.2045-1-shhuiw@foxmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 07 May 2019 07:22:30 -0400
In-Reply-To: <20190507080319.2045-1-shhuiw@foxmail.com> (Shenghui Wang's
        message of "Tue, 7 May 2019 16:03:19 +0800")
Message-ID: <x49mujypkzt.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 07 May 2019 11:22:32 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shenghui Wang <shhuiw@foxmail.com> writes:

> This issue is found by running liburing/test/io_uring_setup test.
>
> When test run, the testcase "attempt to bind to invalid cpu" would not
> pass with messages like:
>    io_uring_setup(1, 0xbfc2f7c8), \
> flags: IORING_SETUP_SQPOLL|IORING_SETUP_SQ_AFF, \
> resv: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000, \
> sq_thread_cpu: 2
>    expected -1, got 3
>    FAIL
>
> On my system, there is:
>    CPU(s) possible : 0-3
>    CPU(s) online   : 0-1
>    CPU(s) offline  : 2-3
>    CPU(s) present  : 0-1
>
> The sq_thread_cpu 2 is offline on my system, so the bind should fail.
> But cpu_possible() will pass the check. We shouldn't be able to bind
> to an offline cpu. Use cpu_online() to do the check.
>
> After the change, the testcase run as expected: EINVAL will be returned
> for cpu offlined.
>
> Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
> ---
>  fs/io_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index d91cbd53d3ca..718d7b873f4a 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2472,7 +2472,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>  							nr_cpu_ids);
>  
>  			ret = -EINVAL;
> -			if (!cpu_possible(cpu))
> +			if (!cpu_online(cpu))
>  				goto err;
>  
>  			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
