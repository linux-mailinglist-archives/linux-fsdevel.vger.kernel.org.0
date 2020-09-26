Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21717279BC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgIZSHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 14:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbgIZSHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 14:07:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB71C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 11:07:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so5921308pfd.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qRpDmm/g2i3mpPL44HfU6Aop5YrghidKPobGJTRxFOg=;
        b=mcf5Oah3ns16yKInn1mBN9s9z9lkH8Pw4Wh0Wm1R8wmgN4+hH3M4VaBSzrjZq9yRAY
         yj6tmJDj1Gw3JWv8VKfcAslXBY5O6YMoTGzh8Q9DDp43kVRs65txHVz3iQEP2rZ4PL5J
         z0ZdXbthr/jquOGX1CNHf3KfYotYhz6BZGMbcql4GjyTAUTDJ7VAE8GRk+GO+vtSDsT0
         l40YQlYgPmE9tlI9Z5GpMUDN34B4PSednZWWBl9OIJMc+VdOtYMm76kYtRSdMZJLUXTc
         Z0U9smrIxUW8B60GOunzj0sEykB5fTNTC7C6QNUZkxwuOzAWKsDFTkYvXB1vdZbqNy8R
         BmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qRpDmm/g2i3mpPL44HfU6Aop5YrghidKPobGJTRxFOg=;
        b=DfUijtYQGCoYmu1aWG8gfDh62f3mKyStKk3EIE8zqvWhZGVTC3I2sHPCuqZNMKcy9u
         bq92xqCcEaGhnxVQ2Mv2Agc41BytzO1wOnRS0DKk9MMa5x7kG9wFx4fJ+lwZsHWL4foP
         /QesjGLUpVIi+Xnz/vHQhxCYgiKlV5JiVgB7uIMAbfeM+FRL++4Mrs61cqZhFa+HZV46
         /WzETva7O+xjqfW8QOoU6ywOk0YmfrmYACYIcVSE9y0klVuHE+q1J9jq/7glRwC2J5GL
         2qdLdvPXL96fxudZXg1lzRY+vI/ng9RuGLztD9DHK0zQvpvfB2m3pOs8I0i0p2JG7MLH
         niew==
X-Gm-Message-State: AOAM530A9msKMqrUkV9PSwS5twtkTd4CgPrIceInvh27M7cxsEYvI1ND
        Uprw8XChDhSn1845ZootCVErsw==
X-Google-Smtp-Source: ABdhPJxpXFQhrlElKUlbAYWtsq+VviE3L43aeWcF+Iu0dH4PD9nYwcDeT4Cd+H4ijKlj/onYr7M3bA==
X-Received: by 2002:a63:4f10:: with SMTP id d16mr3399364pgb.152.1601143641188;
        Sat, 26 Sep 2020 11:07:21 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i126sm6239382pfc.48.2020.09.26.11.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 11:07:20 -0700 (PDT)
Subject: Re: [PATCH next] io-wq: fix use-after-free in io_wq_worker_running
To:     Hillf Danton <hdanton@sina.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk,
        syzbot+45fa0a195b941764e0f0@syzkaller.appspotmail.com,
        syzbot+9af99580130003da82b1@syzkaller.appspotmail.com,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20200926132655.6192-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ac425e8-f302-4e91-0c1d-3ebb0a40cf96@kernel.dk>
Date:   Sat, 26 Sep 2020 12:07:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926132655.6192-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/20 7:26 AM, Hillf Danton wrote:
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -200,7 +200,6 @@ static void io_worker_exit(struct io_wor
>  {
>  	struct io_wqe *wqe = worker->wqe;
>  	struct io_wqe_acct *acct = io_wqe_get_acct(wqe, worker);
> -	unsigned nr_workers;
>  
>  	/*
>  	 * If we're not at zero, someone else is holding a brief reference
> @@ -228,15 +227,11 @@ static void io_worker_exit(struct io_wor
>  		raw_spin_lock_irq(&wqe->lock);
>  	}
>  	acct->nr_workers--;
> -	nr_workers = wqe->acct[IO_WQ_ACCT_BOUND].nr_workers +
> -			wqe->acct[IO_WQ_ACCT_UNBOUND].nr_workers;
>  	raw_spin_unlock_irq(&wqe->lock);
>  
> -	/* all workers gone, wq exit can proceed */
> -	if (!nr_workers && refcount_dec_and_test(&wqe->wq->refs))
> -		complete(&wqe->wq->done);
> -
>  	kfree_rcu(worker, rcu);
> +	if (refcount_dec_and_test(&wqe->wq->refs))
> +		complete(&wqe->wq->done);
>  }

Nice, we came up with the same fix, thanks a lot for looking into this.
I pushed this one out for syzbot to test:

https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.9&id=41d5f92f60a61e264dafbada79175dad0bc60c5b

which is basically identical. I did consider the EXIT check as well, but
we don't really need it, so I'd prefer to leave that out of it.

I'll queue yours up.

-- 
Jens Axboe

