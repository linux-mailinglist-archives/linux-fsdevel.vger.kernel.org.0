Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02AC261854
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 19:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbgIHRwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 13:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbgIHQNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDE9C0619EA
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2020 06:57:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j2so17118468ioj.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2020 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lLPV/2TbMLCWwjxZmMjGQAv9RQQ5QdmKtS2Q2m060x4=;
        b=uJazPLWezWgC/PxcgavzXTzULVjK+HH/0rnfAycuhBQCpgkDFk/fvQpqKS7RzEpiXG
         ERAROiLm7VLunZJpzttkIeY7b1VyZ7vdAdTmly29bZuLWeEEHdxvjUkOpVL/XgnAQLYP
         U563XLl1LCPU1Vs+xCapjB1tF5YvK5Li0o6rXx6tkcIIdFWG/q5TU59d1Vbfyhey0Iqk
         FjDr8t0q6o0KqVSUzgviXQkWRhNR4U26NzOXYB0n6lNBNEhD4nJZeQCKGy7YfpsuHGrd
         n/zLgKw2/0PIclu34Gpdgs81l5h979bDDAONUe9gK227ECpK+s8PjAKkmwpLLY/KXPFR
         17Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lLPV/2TbMLCWwjxZmMjGQAv9RQQ5QdmKtS2Q2m060x4=;
        b=CdQdnGfPB+ToY2y7fN1oXnwHzi6O6rEoqcLlXn3+ms1AK+jyNfvD0bcO4VQrSZ5RwH
         bHx/TXpK7tJBhIdOy1US2gdq/VH8S1JnBMDVxnja1uFBQMc5R/Jjb+F9UR3xoA4dWJkV
         00qapa5xbBPEcUsjgBOYSfgbefkaU6ea4iEQ1SWXxK9kHYDiY4oDCZwL5x1GepZTHhYV
         SEN4/yjKBFDr4ynhM98otcwByFicPpqOaQ4peMwfD3/bb/H5wVRPQA3R1lXmW3Z10i3+
         g9cAYZSSP1DiY1JmKH9KHVDRgCszdZYl/DUaiv4v6V+hLotbYzPeB/55e98FnyMlglK/
         GnAw==
X-Gm-Message-State: AOAM533WhVqjceahlLfDY7g0Q0YLenID1tbhAzss2/4VgtWVwYRchMk4
        wXvmFY3wgZ77Ub5XTPUrLVcCUw==
X-Google-Smtp-Source: ABdhPJxhox+LWrxM6t17Fh8h96lJUzdn1I3RGOvUMfkfWJnmtrv7CdbTJs/zo6NSzHwk+R3I3Syr5A==
X-Received: by 2002:a6b:c8d6:: with SMTP id y205mr527426iof.177.1599573430313;
        Tue, 08 Sep 2020 06:57:10 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e28sm10512528ill.79.2020.09.08.06.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 06:57:09 -0700 (PDT)
Subject: Re: [PATCH v6 3/3] io_uring: allow disabling rings during the
 creation
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        Aleksa Sarai <asarai@suse.de>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20200827145831.95189-1-sgarzare@redhat.com>
 <20200827145831.95189-4-sgarzare@redhat.com>
 <20200908134448.sg7evdrfn6xa67sn@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <045e0907-4771-0b7f-d52a-4af8197e6954@kernel.dk>
Date:   Tue, 8 Sep 2020 07:57:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908134448.sg7evdrfn6xa67sn@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/8/20 7:44 AM, Stefano Garzarella wrote:
> Hi Jens,
> 
> On Thu, Aug 27, 2020 at 04:58:31PM +0200, Stefano Garzarella wrote:
>> This patch adds a new IORING_SETUP_R_DISABLED flag to start the
>> rings disabled, allowing the user to register restrictions,
>> buffers, files, before to start processing SQEs.
>>
>> When IORING_SETUP_R_DISABLED is set, SQE are not processed and
>> SQPOLL kthread is not started.
>>
>> The restrictions registration are allowed only when the rings
>> are disable to prevent concurrency issue while processing SQEs.
>>
>> The rings can be enabled using IORING_REGISTER_ENABLE_RINGS
>> opcode with io_uring_register(2).
>>
>> Suggested-by: Jens Axboe <axboe@kernel.dk>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v4:
>>  - fixed io_uring_enter() exit path when ring is disabled
>>
>> v3:
>>  - enabled restrictions only when the rings start
>>
>> RFC v2:
>>  - removed return value of io_sq_offload_start()
>> ---
>>  fs/io_uring.c                 | 52 ++++++++++++++++++++++++++++++-----
>>  include/uapi/linux/io_uring.h |  2 ++
>>  2 files changed, 47 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 5f62997c147b..b036f3373fbe 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -226,6 +226,7 @@ struct io_restriction {
>>  	DECLARE_BITMAP(sqe_op, IORING_OP_LAST);
>>  	u8 sqe_flags_allowed;
>>  	u8 sqe_flags_required;
>> +	bool registered;
>>  };
>>  
>>  struct io_ring_ctx {
>> @@ -7497,8 +7498,8 @@ static int io_init_wq_offload(struct io_ring_ctx *ctx,
>>  	return ret;
>>  }
>>  
>> -static int io_sq_offload_start(struct io_ring_ctx *ctx,
>> -			       struct io_uring_params *p)
>> +static int io_sq_offload_create(struct io_ring_ctx *ctx,
>> +				struct io_uring_params *p)
>>  {
>>  	int ret;
>>  
>> @@ -7532,7 +7533,6 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>>  			ctx->sqo_thread = NULL;
>>  			goto err;
>>  		}
>> -		wake_up_process(ctx->sqo_thread);
>>  	} else if (p->flags & IORING_SETUP_SQ_AFF) {
>>  		/* Can't have SQ_AFF without SQPOLL */
>>  		ret = -EINVAL;
>> @@ -7549,6 +7549,12 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>>  	return ret;
>>  }
>>  
>> +static void io_sq_offload_start(struct io_ring_ctx *ctx)
>> +{
>> +	if ((ctx->flags & IORING_SETUP_SQPOLL) && ctx->sqo_thread)
>> +		wake_up_process(ctx->sqo_thread);
>> +}
>> +
>>  static inline void __io_unaccount_mem(struct user_struct *user,
>>  				      unsigned long nr_pages)
>>  {
>> @@ -8295,6 +8301,9 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>>  	if (!percpu_ref_tryget(&ctx->refs))
>>  		goto out_fput;
>>  
>> +	if (ctx->flags & IORING_SETUP_R_DISABLED)
>> +		goto out_fput;
>> +
> 
> While writing the man page paragraph, I discovered that if the rings are
> disabled I returned ENXIO error in io_uring_enter(), coming from the previous
> check.
> 
> I'm not sure it is the best one, maybe I can return EBADFD or another
> error.
> 
> What do you suggest?

EBADFD seems indeed the most appropriate - the fd is valid, but not in the
right state to do this.

> I'll add a test for this case.

Thanks!

-- 
Jens Axboe

