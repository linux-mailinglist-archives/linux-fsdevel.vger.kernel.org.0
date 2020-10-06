Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84EA28530C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 22:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgJFU0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFU0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:26:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B411DC0613D2
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2020 13:26:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i3so2163917pjz.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2020 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uNEX0ozXAl6BoosMQvMms2YwhVI/0IP0lEwVThfHmbY=;
        b=2GUcIUTHIMo6vhOS0my89Cj9kP2D4p07/rhhxDBGfqb3N3x6c6AQO+3lCuxilotc3L
         pmVCYaED3MxFa+8coBygSTGtli3oY0c1gxcQ5VsVjK9KLdrlS2EEGrGOd/gslcKAJqNZ
         kDy1NozgF2AYIHtxrezLC2sDzcg2A4tNdFPDU9wr3dPUCGdkh5N++3UO9OoLX9Ag+B2W
         WjC4r++/G9ycyK6gNX1JaqAL2/votn9dWm8EJCVdZnfJIV+OvoaqVTP1luRfJglVcUJw
         FlyteZyr83635j2JA0575M2OPorVKTKpeoUBDEmBGAo3IO84JGcUYAvq20GQDBBFsW3b
         rB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uNEX0ozXAl6BoosMQvMms2YwhVI/0IP0lEwVThfHmbY=;
        b=NoqWe0dggyttbsmoZcq2DE0lexn0sE4UJLvSzwAEvDrS1imwVuHwbZgi1UmWNzUarh
         Cu8p+bNnsPIhTMr75KNgtiyXnHxbx/jloYpKENrCmZKphuAH8dBtsMvsdZZZYzn+HeXs
         IWyGcRh8V+AGATVvx8n5nZkD66Be/S7gIWUM4ePoT32O9KkjBNydpYcgQzKgk3nXd83o
         tgCrIx+zJBTp86Xgh7++Kry4s4Xu0M1Xy9X+s+gDq67ciGx09BWjMyhhoSwbAGpW8bBA
         gBiRqSBRQJVbNlFwebe7G055fKvEuJGtfHjX/oNoWPeqvnSWRhMY/bFNqZTq40extuTY
         TSjw==
X-Gm-Message-State: AOAM533NN94WL95YaO/BDH8nTXVLFjC4StrpoP0irhzLXceCO8YDBITZ
        SuxfMRFQfUMmqzpzC1vZFfeaIw==
X-Google-Smtp-Source: ABdhPJzRWLYq7Oj3RrV+2fvHmO+qLCXG/WyhzYWtvAMD2oXcC2iLzNl3CtOpcqVq7cxg6i88OmAa0A==
X-Received: by 2002:a17:902:6ac6:b029:d3:b4d7:2e55 with SMTP id i6-20020a1709026ac6b02900d3b4d72e55mr4536406plt.62.1602015980074;
        Tue, 06 Oct 2020 13:26:20 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id hk17sm3144525pjb.14.2020.10.06.13.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 13:26:19 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] io_uring: Fix missing save the current thread
 files
To:     Muchun Song <songmuchun@bytedance.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com
References: <20200923114419.71218-1-songmuchun@bytedance.com>
 <20200923114419.71218-5-songmuchun@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f19c032-4b49-8eca-c264-be6f23751f70@kernel.dk>
Date:   Tue, 6 Oct 2020 14:26:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923114419.71218-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/23/20 5:44 AM, Muchun Song wrote:
> We forget to save the current thread files, in this case, we can not
> send SIGINT signal to the kworker because the files is not equal.
> 
> Fixes: 54ee77961e79 ("io_uring: Fix NULL pointer dereference in io_sq_wq_submit_work()")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  fs/io_uring.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 12e68ea00a543..c65f78f395655 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2391,6 +2391,8 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
>  	if (ret) {
>  		struct io_ring_ctx *ctx = req->ctx;
>  
> +		req->files = current->files;
> +
>  		spin_lock_irq(&ctx->task_lock);
>  		list_add(&req->task_list, &ctx->task_list);
>  		req->work_task = NULL;

This should be folded in with patch 1.

-- 
Jens Axboe

