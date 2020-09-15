Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9752526B7C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgIPA3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgIONti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:49:38 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A4C061A10
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:36:56 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e23so3235140otk.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5nixci3CSSlm0JVJHjLv8kSY8PhichT9C9IRwcdycYA=;
        b=frM1guUPtYEMHzBHOmBXc1LJN0o/Mhxc876Up3RbNvLAopbQ51jsxn66hMudOWe+7D
         qb0q6byNtnMAi7YZ/5QVMXXBGRO8H+YZre3Z0q+2wt1a/4W5UmqMAoPDfsHXvx/gaacZ
         f9VKtNiD/2RmhiywtqC6DD11yNsMPRZHlVGu+H8XXcT7nMXl0TKxbHdXwp2msnugNfda
         5FMcbZ5ppng5F+r02LNIJJvEOmSKmXygmLJuVT1IevEOJqkJpB2Z9xq0q0A5nRd25IjN
         FsYcvSBU0Fre2hTvb7hD+Dc7Ro39e+TKVPUsoQrkRDiwf2ncucLBcd23rPxa1gqOO8pG
         g65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5nixci3CSSlm0JVJHjLv8kSY8PhichT9C9IRwcdycYA=;
        b=ui/EeYHBITWTIz3bvbXOUdoi3s2KH5S1nHYJxgenqrgR4elykw0aLPfEZYfpXH0Jy9
         R7zQQr0Jwr2gdhoQV7f4L+aJA9kJ5d6FAT16qIuZSSWmggVq5Jwy1FyGLue/OJGMIFp/
         hqiTZjo89oWfe0eLI1Z27ZVnVdf187zb/UaYzrSNvdKYiOfe/DjWRHv/XAnT+nRtN1+U
         EqEyFod/LiNwpIDspI7BnUN/l/UfEhRUQFm6FyXSA8ShhqHzLneQXeXEI0ahN7MpxX0x
         EbRlFRZ5qu8KxvQsv21GFIVevr8qVylmXx+mNkLENUr/Wu2Wmv0vXV7JO4SneZgDExfY
         ohHA==
X-Gm-Message-State: AOAM532egpncMdqDxuSXeOavtCCuX+4WteU5Pp/GWkF+mm6+KHBiGxqk
        V3TKZY10NfXVHmIR8x1NIv498g==
X-Google-Smtp-Source: ABdhPJx6pSgCgdr+Rct0Mxa3o9lj8STvJmmRBbJOVmXhNia2GSJl/blPThqV+VQFP2sH8jbgfvKpMw==
X-Received: by 2002:a9d:315:: with SMTP id 21mr13659132otv.278.1600177016337;
        Tue, 15 Sep 2020 06:36:56 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o13sm5597673otj.2.2020.09.15.06.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:36:55 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix the bug of child process can't do io task
From:   Jens Axboe <axboe@kernel.dk>
To:     Yinyin Zhu <zhuyinyin@bytedance.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200915130245.89585-1-zhuyinyin@bytedance.com>
 <e206f1b4-1f22-c3f5-21a6-cec498d9c830@kernel.dk>
Message-ID: <0d66eabc-3b8b-2f84-05b7-981c2b6fe5dd@kernel.dk>
Date:   Tue, 15 Sep 2020 07:36:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e206f1b4-1f22-c3f5-21a6-cec498d9c830@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/20 7:25 AM, Jens Axboe wrote:
> On 9/15/20 7:02 AM, Yinyin Zhu wrote:
>> when parent process setup a io_uring_instance, the ctx->sqo_mm was
>> assigned of parent process'mm. Then it fork a child
>> process. So the child process inherits the io_uring_instance fd from
>> parent process. Then the child process submit a io task to the io_uring
>> instance. The kworker will do the io task actually, and use
>> the ctx->sqo_mm as its mm, but this ctx->sqo_mm is parent process's mm,
>> not the child process's mm. so child do the io task unsuccessfully. To
>> fix this bug, when a process submit a io task to the kworker, assign the
>> ctx->sqo_mm with this process's mm.
> 
> Hmm, what's the test case for this? There's a 5.9 regression where we
> don't always grab the right context for certain linked cases, below
> is the fix. Does that fix your case?

Ah hang on, you're on the 5.4 code base... I think this is a better
approach. Any chance you can test it?

The problem with yours is that you can have multiple pending async
ones, and you can't just re-assign ctx->sqo_mm. That one should only
be used by the SQPOLL thread.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2a539b794f3b..e8a4b4ae7006 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -514,7 +514,7 @@ static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 		}
 	}
 
-	req->task = current;
+	req->task = get_task_struct(current);
 
 	spin_lock_irqsave(&ctx->task_lock, flags);
 	list_add(&req->task_list, &ctx->task_list);
@@ -1832,6 +1832,7 @@ static void io_poll_complete_work(struct work_struct *work)
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_ev_posted(ctx);
+	put_task_struct(req->task);
 	io_put_req(req);
 out:
 	revert_creds(old_cred);
@@ -2234,11 +2235,11 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 
 		ret = 0;
 		if (io_req_needs_user(req) && !cur_mm) {
-			if (!mmget_not_zero(ctx->sqo_mm)) {
+			if (!mmget_not_zero(req->task->mm)) {
 				ret = -EFAULT;
 				goto end_req;
 			} else {
-				cur_mm = ctx->sqo_mm;
+				cur_mm = req->task->mm;
 				use_mm(cur_mm);
 				old_fs = get_fs();
 				set_fs(USER_DS);
@@ -2275,6 +2276,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		}
 
 		/* drop submission reference */
+		put_task_struct(req->task);
 		io_put_req(req);
 
 		if (ret) {

-- 
Jens Axboe

