Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06922259FAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 22:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgIAUMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 16:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgIAUMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:12:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABB8C061246
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 13:12:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s10so650874plp.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e6GgX70OdjL1tqwJUYS3XbI1WRfgqCK//kboQuDHSjM=;
        b=aE+t+KoG0Wd8K0fWdODEaafawp7uWrxOKVIP5pOq+CaZh5a5QZaU1TKqHqo0IicpIE
         OKXyjv6Z6jfmVgDwyWYcrdz6KSAEuQG1uEUF2indrcNRycvSHu0RqUeM7aM6dZ0z4MuE
         L32x8HTrjAkMjBrG0Nqm3QVhk/L67aEZhzwZD9Gm5toLeu3ofg0idQFwnTzXeXb7q2hi
         0iTswCUa5Og2+6jqmTy11a7IQyDgaHWJXw6s/4Biz0yHTxj3kjvEmU2P5EKA0S3ydPJb
         3+3dM56syhZBvZ4aEqHMQebqkn59RAW3c9DFTEODXKBjKC55ZMsQOvCkNvxcHx34w/KK
         HkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e6GgX70OdjL1tqwJUYS3XbI1WRfgqCK//kboQuDHSjM=;
        b=ce7SI/DvrYa7XCUG4yzzNm+xBOwEKLiQl7RPidgQmipV9bMjP37YaQ4Nd7+Yq98dW4
         qMqug4FbE107GvgGW2oK6US81tSyX1M7IblQTfC4z8uYXSomEj0NK9BrVfW9DNrGD6s0
         3nsmYkZwTzgvlAG5t9gSSsRsK70jf2obHo2Ugum4xckS9ZZ4a6UZEO3AZXciRleFSrcV
         gk2bWkgtZ0X/KjUxAXtXkMwLkhrYgh3w3cJgjRgK25Pi0BqiGdCKrv/FcsRY6cyoIid+
         HbyA+YnhkSNpHrife+D4+4J2nwWUm4YCY48FJSir8RsdhYPLq7w8SU7ciDG2FuC4/w4f
         15Xg==
X-Gm-Message-State: AOAM533QZjEb0zKK0EgjyEvxWfTLk9FSOwLO/sEiOJBopZZnAwTJYuJB
        WIu7KbHKfeE+nKVV0LzO4sJuTA==
X-Google-Smtp-Source: ABdhPJw5TN1eVTK6zQzkrcnavu2RYPsBE9ZH8OtwjjON+M9+5Ru8nVKNqAhIPbU2RY0Qj3bJJgMMTg==
X-Received: by 2002:a17:90a:e80f:: with SMTP id i15mr1891990pjy.62.1598991157066;
        Tue, 01 Sep 2020 13:12:37 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id ih11sm2302448pjb.51.2020.09.01.13.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 13:12:36 -0700 (PDT)
Subject: Re: [PATCH] io_uring: Fix NULL pointer dereference in
 io_sq_wq_submit_work()
From:   Jens Axboe <axboe@kernel.dk>
To:     yinxin_1989 <yinxin_1989@aliyun.com>,
        viro <viro@zeniv.linux.org.uk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200901015442.44831-1-yinxin_1989@aliyun.com>
 <ae9f3887-5205-8aa8-afa7-4e01d03921bc@kernel.dk>
 <67f27d17-81fa-43a8-baa9-429b1ccd65d0.yinxin_1989@aliyun.com>
 <4eeefb43-488c-dc90-f47c-10defe6f9278@kernel.dk>
 <98f2cbbf-4f6f-501b-2f4e-1b8b803ce6a6@kernel.dk>
Message-ID: <1925de10-3c07-0a0b-4434-1049b7ee52c3@kernel.dk>
Date:   Tue, 1 Sep 2020 14:12:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <98f2cbbf-4f6f-501b-2f4e-1b8b803ce6a6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/20 2:01 PM, Jens Axboe wrote:
> On 9/1/20 8:52 AM, Jens Axboe wrote:
>> On 8/31/20 10:59 PM, yinxin_1989 wrote:
>>>
>>>> On 8/31/20 7:54 PM, Xin Yin wrote:
>>>>> the commit <1c4404efcf2c0> ("<io_uring: make sure async workqueue
>>>>> is canceled on exit>") caused a crash in io_sq_wq_submit_work().
>>>>> when io_ring-wq get a req form async_list, which may not have been
>>>>> added to task_list. Then try to delete the req from task_list will caused
>>>>> a "NULL pointer dereference".
>>>>
>>>> Hmm, do you have a reproducer for this?
>>>
>>> I update code to linux5.4.y , and I can reproduce this issue on an arm
>>> board and my x86 pc by fio tools.
>>
>> Right, I figured this was 5.4 stable, as that's the only version that
>> has this patch.
> 
> I took a closer look, and I think your patch can basically be boiled down
> to this single hunk. If you agree, can you resend your patch with the
> description based on that, then I'll get it queued up for 5.4-stable.
> Thanks!

Actually, we don't even need the irqsave, this should be enough:

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fada14ee1cdc..2a539b794f3b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2378,6 +2378,15 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 		list_del_init(&req->list);
 		ret = false;
 	}
+
+	if (ret) {
+		struct io_ring_ctx *ctx = req->ctx;
+
+		spin_lock_irq(&ctx->task_lock);
+		list_add(&req->task_list, &ctx->task_list);
+		req->work_task = NULL;
+		spin_unlock_irq(&ctx->task_lock);
+	}
 	spin_unlock(&list->lock);
 	return ret;
 }

-- 
Jens Axboe

