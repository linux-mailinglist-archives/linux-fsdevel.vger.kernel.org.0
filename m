Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4C258643
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 05:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIADjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 23:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgIADjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:39:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8EDC0612FF
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 20:39:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e33so1925885pgm.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 20:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CmWImjbfkai8w8IYrzWttSFE/ShThoXbvLekJzQkDNE=;
        b=2Hpp2pGPGoM76EKftl74jbI1jE6i7BkynyJ4YEmKkncEDpi7syFP4I6+fZ40aXoMWP
         4jHntOowSoOmVOmt3/HKPrWZeu0hPu4w4Xw5l/nPcBhXe8mpT+ekpd6/nvfhlPBvka35
         bVdb4MsJL2T012kuCrdQLPBK9FQWt2jc38W+VKcfMdwe4fcc1ydnRfEXtPvTTdqB0uz1
         Roak8DeVTXNH9SdCwuhtN4cW48ZXgHlA4qR1GtjrQO9Zv5qm1FSCvQvlqfL50Xsdkfpp
         aL6oEfHl4LCfAP/k+ddBM2K88gUh0fwJoqJpZLv8o8PMGJlB2cvgsmslGDup+j6jdPxL
         mlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CmWImjbfkai8w8IYrzWttSFE/ShThoXbvLekJzQkDNE=;
        b=AJvag0N9Llez0yqG4UkR/zJ7i1B8z1IX1J1XF0wadaZbp/F7BxMoHyHqfJ4GYb4XPs
         fENJ+V9N34kb+fyHrtP2LgQNFWtunEDXS6nFiltR8efXjpUC+EIgXQIfzuyqbTQHlXfx
         DcCbyhLztnHjxqODdxSCemvSr81vXcsBc/4EDrU9e9cGk/VnLDvImcQUM9/+3SB6jWDl
         uHhqB/IGkO7IMvrDfbCkLveRlIEySnAnVm9LxKQ4vzV/lEtaLhcJxBSD7lcPDJDVREaz
         Hhhzz4qM+sPNjehMKtqZuzfyCr6qoGTZOogwPMFSm9TpTDzSBd9ct9vr2UwyO0meDCkJ
         17+A==
X-Gm-Message-State: AOAM530h2Yc8OVPg2bckq3oKXmXkmn8kKtL+8l15JEhd9kmfbbojBQ9Q
        3Wyd2mJdT4qG3dk4ifjgw0djfA==
X-Google-Smtp-Source: ABdhPJxwc59YPWeeBw2UNybtTAbxjkWeEOLQHBC6jojvyuHuUAYP7kos/LMRkBGs5mEgIM5IdCOWkw==
X-Received: by 2002:aa7:8657:: with SMTP id a23mr3953845pfo.169.1598931542218;
        Mon, 31 Aug 2020 20:39:02 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o192sm9966704pfg.81.2020.08.31.20.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 20:39:01 -0700 (PDT)
Subject: Re: [PATCH] io_uring: Fix NULL pointer dereference in
 io_sq_wq_submit_work()
To:     Xin Yin <yinxin_1989@aliyun.com>, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200901015442.44831-1-yinxin_1989@aliyun.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae9f3887-5205-8aa8-afa7-4e01d03921bc@kernel.dk>
Date:   Mon, 31 Aug 2020 21:38:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901015442.44831-1-yinxin_1989@aliyun.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/20 7:54 PM, Xin Yin wrote:
> the commit <1c4404efcf2c0> ("<io_uring: make sure async workqueue
> is canceled on exit>") caused a crash in io_sq_wq_submit_work().
> when io_ring-wq get a req form async_list, which may not have been
> added to task_list. Then try to delete the req from task_list will caused
> a "NULL pointer dereference".

Hmm, do you have a reproducer for this?

> @@ -2356,9 +2358,11 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>   * running. We currently only allow this if the new request is sequential
>   * to the previous one we punted.
>   */
> -static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
> +static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req,
> +							struct io_ring_ctx *ctx)
>  {
>  	bool ret;
> +	unsigned long flags;
>  
>  	if (!list)
>  		return false;
> @@ -2378,6 +2382,13 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
>  		list_del_init(&req->list);
>  		ret = false;
>  	}
> +
> +	if (ret) {
> +		spin_lock_irqsave(&ctx->task_lock, flags);
> +		list_add(&req->task_list, &ctx->task_list);
> +		req->work_task = NULL;
> +		spin_unlock_irqrestore(&ctx->task_lock, flags);
> +	}
>  	spin_unlock(&list->lock);
>  	return ret;
>  }
> @@ -2454,7 +2465,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>  			s->sqe = sqe_copy;
>  			memcpy(&req->submit, s, sizeof(*s));
>  			list = io_async_list_from_req(ctx, req);
> -			if (!io_add_to_prev_work(list, req)) {
> +			if (!io_add_to_prev_work(list, req, ctx)) {
>  				if (list)
>  					atomic_inc(&list->cnt);
>  				INIT_WORK(&req->work, io_sq_wq_submit_work);
> 

ctx == req->ctx, so you should not need that change.

-- 
Jens Axboe

