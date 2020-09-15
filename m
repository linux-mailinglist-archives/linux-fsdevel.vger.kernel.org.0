Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F32226A655
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 15:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgION2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIONZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:25:43 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4996C061222
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:25:32 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w16so3855141oia.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RyVHdR8jBIwQ3BNbRllUCCgf0qrcLoJK+x7C0viR1NE=;
        b=wJ3w9dq4WGkHLAVxY7n5TllVUvXWKHAsTyiAO1zqRGvpG1/0nZAGylkQCAEkc30qw0
         sdRrx5LKXaDqGtVMa+2D75ZbOI2t2+gIYrfrD+JFMDZXZk+wW33LRqi/N0X7ftX00gHR
         zu70x//BFqUKOIYBIZcbdJ3p7YDhBXfQIwWM5NSmVOgKEVYm9OBLpso5+qMI2Vltexgx
         t+qr5+7omoFBf619m7FZRQzPawASQ+AxYaBSngl6IQwlIR94WTkzqGO4YxLl+VoVkBZ4
         wajpohE424xoFqEvGlfZ1HIQaCRMAqUoep6zE6jZCSXLbApL4P/Q0Bab4L65D/a6NOua
         i9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RyVHdR8jBIwQ3BNbRllUCCgf0qrcLoJK+x7C0viR1NE=;
        b=uGjSN34dxxM0+yTGrf6Ld6Vjk9rk04S9jT8/Sb//RPbRlhEpYAygPi2htnyxGFiRKc
         kvA2iq4sfrkkfQ/NYCsD0ZnMVIIUtSLGneKvGrX0O02K4DQAuZL+SCI/eXNM1lkTMUKI
         y1gxRu7jFnMGK4q1wGCfulKCZ844C2s+NT58E2iqslhf4KUY0wX69dPgyA/yjfc8itfa
         t09TOlCOTYQ+YlKWhGG9soLMC41rux2ClOx8bp/9Vwb/H16wXds5AMeEZsj7cEAg/Zs+
         YNJdwDGFNcQz+fSB09j3RTxpAMb5iPvwcQxZ8CZZLqaxBfdP+PWPGFYM4bmnoQ9U9xmG
         zwkg==
X-Gm-Message-State: AOAM533ZdoMQ2O2v7XBqim/JMi7K88sPlXkxvdxyCL7VrfRSk3jK78Cp
        Bnh9GYJmReH5uHx4GQUYpQBYaA==
X-Google-Smtp-Source: ABdhPJyT4YjSfQSBOA7Rk1epa+cHZnD91VxCDph4qsIf8187cA0apiSIFtK2ee4KGS1Y+lHtVJRWIg==
X-Received: by 2002:a05:6808:aa5:: with SMTP id r5mr3180890oij.90.1600176331905;
        Tue, 15 Sep 2020 06:25:31 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l136sm6362088oig.7.2020.09.15.06.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:25:31 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix the bug of child process can't do io task
To:     Yinyin Zhu <zhuyinyin@bytedance.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200915130245.89585-1-zhuyinyin@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e206f1b4-1f22-c3f5-21a6-cec498d9c830@kernel.dk>
Date:   Tue, 15 Sep 2020 07:25:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915130245.89585-1-zhuyinyin@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/20 7:02 AM, Yinyin Zhu wrote:
> when parent process setup a io_uring_instance, the ctx->sqo_mm was
> assigned of parent process'mm. Then it fork a child
> process. So the child process inherits the io_uring_instance fd from
> parent process. Then the child process submit a io task to the io_uring
> instance. The kworker will do the io task actually, and use
> the ctx->sqo_mm as its mm, but this ctx->sqo_mm is parent process's mm,
> not the child process's mm. so child do the io task unsuccessfully. To
> fix this bug, when a process submit a io task to the kworker, assign the
> ctx->sqo_mm with this process's mm.

Hmm, what's the test case for this? There's a 5.9 regression where we
don't always grab the right context for certain linked cases, below
is the fix. Does that fix your case?


commit 202700e18acbed55970dbb9d4d518ac59b1172c8
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Sep 12 13:18:10 2020 -0600

    io_uring: grab any needed state during defer prep
    
    Always grab work environment for deferred links. The assumption that we
    will be running it always from the task in question is false, as exiting
    tasks may mean that we're deferring this one to a thread helper. And at
    that point it's too late to grab the work environment.
    
    Fixes: debb85f496c9 ("io_uring: factor out grab_env() from defer_prep()")
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 175fb647d099..be9d628e7854 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5449,6 +5449,8 @@ static int io_req_defer_prep(struct io_kiocb *req,
 	if (unlikely(ret))
 		return ret;
 
+	io_prep_async_work(req);
+
 	switch (req->opcode) {
 	case IORING_OP_NOP:
 		break;

-- 
Jens Axboe

