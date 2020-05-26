Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59B71E2348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 15:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgEZNr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgEZNrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 09:47:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A20C03E96E
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 06:47:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q9so1361698pjm.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b8XSa/siiC+feubaj5cYdBKsmqas472F78cogYFY2nU=;
        b=mZ/cPRrL9yBe+FyDGZekgAH3ygoSEQvZ+n0ICNF3QM2IGlEMhCRK8GwJiVcGZ4DFUt
         v0jgCZtojqxrOo6zEPHsBVvhZWM1f8J9y/IaM18rB2g+sbCtFruY3Yl7Y5uPKVdfGgY7
         owWMRJaufKT+QUBkjrk92VJl+CnB00cbvsrcye57H4QqYhdypFBFQR72b3/QCYyQpGVr
         ttMLTaXdJ20NlBg+QHGJdMxMmHJlak3F/7olf9GnGxN6Tz25bepZwElnNhQEYqN4hOQ4
         B3vAo8YFtRTU3QPuhab/dKF3n5aX2i4T8QAeShp9ly0EJiAc7fo/sxeyQJfQMJ9vt3NH
         q28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8XSa/siiC+feubaj5cYdBKsmqas472F78cogYFY2nU=;
        b=OCpClykwqROSGwTpKV59UO6tb8dQRpkH/5AaDB9J7qkxJNMshZtEOz1mQhgtEMvsxo
         NKSZKvF/X+87w799IHnec60CfMVugsU3tOZodUjqZlBqE7CsPzz3K8ydJ+U2oSzILQ2h
         8tjr01k2hDDsDjvjokEnyCf7GOIMnwsVfzKV0D8QkkoWf/RUsFwaqvZI/3XMUK4lOKoe
         ilJO0VIOkkk4b+o/gvRMwwI5shl9JdQTt2bmuS55Gf6iqwVaH0Jhh793f+x5gcSb+BXL
         xz5PA1SvbA3i+e8WY5sWHfUB3xI1R1Biq+83OkVBEPRHJTg6hsVc/OvX7qE6rvMs94LG
         T55w==
X-Gm-Message-State: AOAM532pCIIiuZNFGIr4bUYgG7h6rWdG63FF2ZBiPFqfJS+g0VDcwb1Z
        O5LNOD3pWBsVGC+yx+HdyerTJw==
X-Google-Smtp-Source: ABdhPJyFr6HoXe28+9kfuFiHevoxeAadV85o31fPsOqpWPAWa0zZoXCjI1ao9HS9V1lk2CtFLKryIA==
X-Received: by 2002:a17:902:b289:: with SMTP id u9mr1211767plr.138.1590500842958;
        Tue, 26 May 2020 06:47:22 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:a9e6:df54:e55e:4c47? ([2605:e000:100e:8c61:a9e6:df54:e55e:4c47])
        by smtp.gmail.com with ESMTPSA id 128sm15158827pfd.114.2020.05.26.06.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 06:47:22 -0700 (PDT)
Subject: Re: [PATCH 12/12] io_uring: support true async buffered reads, if
 file provides it
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200523185755.8494-1-axboe@kernel.dk>
 <20200523185755.8494-13-axboe@kernel.dk>
 <9c2cc031-e4ce-4c5f-5e14-21ea48c327f6@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe94b8ba-410e-8a14-5382-463e42dabf5f@kernel.dk>
Date:   Tue, 26 May 2020 07:47:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9c2cc031-e4ce-4c5f-5e14-21ea48c327f6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/26/20 1:38 AM, Pavel Begunkov wrote:
> On 23/05/2020 21:57, Jens Axboe wrote:
>> If the file is flagged with FMODE_BUF_RASYNC, then we don't have to punt
>> the buffered read to an io-wq worker. Instead we can rely on page
>> unlocking callbacks to support retry based async IO. This is a lot more
>> efficient than doing async thread offload.
>>
>> The retry is done similarly to how we handle poll based retry. From
>> the unlock callback, we simply queue the retry to a task_work based
>> handler.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/io_uring.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 99 insertions(+)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index e95481c552ff..dd532d2634c2 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -498,6 +498,8 @@ struct io_async_rw {
>>  	struct iovec			*iov;
>>  	ssize_t				nr_segs;
>>  	ssize_t				size;
>> +	struct wait_page_queue		wpq;
>> +	struct callback_head		task_work;
>>  };
>>  
>>  struct io_async_ctx {
>> @@ -2568,6 +2570,99 @@ static int io_read_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>  	return 0;
>>  }
>>  
>> +static void io_async_buf_cancel(struct callback_head *cb)
>> +{
>> +	struct io_async_rw *rw;
>> +	struct io_ring_ctx *ctx;
>> +	struct io_kiocb *req;
>> +
>> +	rw = container_of(cb, struct io_async_rw, task_work);
>> +	req = rw->wpq.wait.private;
>> +	ctx = req->ctx;
>> +
>> +	spin_lock_irq(&ctx->completion_lock);
>> +	io_cqring_fill_event(req, -ECANCELED);
> 
> It seems like it should go through kiocb_done()/io_complete_rw_common().
> My concern is missing io_put_kbuf().

Yeah, I noticed that too after sending it out. If you look at the
current one that I updated yesterday, it does add that (and also
renames the iter read helper):

https://git.kernel.dk/cgit/linux-block/commit/?h=async-buffered.5&id=6f4e3a4066d0db3e3478e58cc250afb16d8d4d91

-- 
Jens Axboe

