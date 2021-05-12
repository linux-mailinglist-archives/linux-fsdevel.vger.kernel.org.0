Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E1A37EF5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 01:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhELXMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 19:12:24 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:33302 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442180AbhELV5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 17:57:11 -0400
Received: by mail-qt1-f182.google.com with SMTP id 1so18440657qtb.0;
        Wed, 12 May 2021 14:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=luhmE8aUs42J0e2iXCpD+UJrpL+zbVWRaOYfzlXnGGk=;
        b=YYO0/D82zNnuBnYvnJeOogbT28P1TMn5A30EgyKpiy+CYKg9OM83QlM9Mi58XX8R9X
         4Fs4lbGXivhDP4ctHqSczLDMvpqnNmUpEpRhUB/OgI/j8lRkiUk3cuYuM+q44EHtX04/
         ii+M8vM0BJkZQF6mTMEnuSAhEwRNryG8eW1Uanpk47zN4j5NhfOr/6Brfr3mFVeH5veA
         ojxS8mowRpy5+b4yVByKO4oyWnCnRG+LYNXhuZ0fJJBSBfec2o6Anz2ZOFvQ2mWvgaXE
         6a7O9zunJebEwktbCo3ZFMzF1mw7LwirW6uPseSZqvzZczHj/wNZcI+b/dO+nn+o64mD
         72kg==
X-Gm-Message-State: AOAM532KGZPRhFcH4Pjagv7Z8eLSYvHAJXbxWgsnqipcxR/lJZ0GbM/a
        /GI1ef7rpzN2Uy6oHm8unn/PSVmwBS8=
X-Google-Smtp-Source: ABdhPJyQRFa+Xx2huDp+cX0TTQBPvZ6j251BYDRv+ObtObAU3RKuT4JNT4RN4OH0+dDcuAOWAWTOkQ==
X-Received: by 2002:ac8:538a:: with SMTP id x10mr35760207qtp.226.1620856561782;
        Wed, 12 May 2021 14:56:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848? ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
        by smtp.gmail.com with ESMTPSA id m205sm1019683qke.2.2021.05.12.14.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 14:56:01 -0700 (PDT)
Subject: Re: [PATCH 08/15] io_uring: don't sleep when polling for I/O
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-9-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <22a8e5a0-b292-a2c5-148d-287c1a50e2b9@grimberg.me>
Date:   Wed, 12 May 2021 14:55:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/12/21 6:15 AM, Christoph Hellwig wrote:
> There is no point in sleeping for the expected I/O completion timeout
> in the io_uring async polling model as we never poll for a specific
> I/O.  Split the boolean spin argument to blk_poll into a set of flags
> to control sleeping and the oneshot behavior separately.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c           | 18 ++++++++----------
>   drivers/nvme/host/core.c |  2 +-
>   fs/block_dev.c           |  8 ++++----
>   fs/io_uring.c            | 14 +++++++-------
>   fs/iomap/direct-io.c     |  6 +++---
>   include/linux/blkdev.h   |  6 +++++-
>   include/linux/fs.h       |  2 +-
>   include/linux/iomap.h    |  2 +-
>   mm/page_io.c             |  2 +-
>   9 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ac0b517c5503..164e39d34bf6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3873,7 +3873,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q, blk_qc_t qc)
>   }
>   
>   static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
> -		bool spin)
> +		unsigned int flags)
>   {
>   	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, cookie);
>   	long state = current->state;
> @@ -3896,7 +3896,7 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
>   		if (current->state == TASK_RUNNING)
>   			return 1;
>   
> -		if (ret < 0 || !spin)
> +		if (ret < 0 || (flags & BLK_POLL_ONESHOT))
>   			break;
>   		cpu_relax();
>   	} while (!need_resched());
> @@ -3909,15 +3909,13 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
>    * blk_poll - poll for IO completions
>    * @q:  the queue
>    * @cookie: cookie passed back at IO submission time
> - * @spin: whether to spin for completions
> + * @flags: BLK_POLL_* flags that control the behavior
>    *
>    * Description:
>    *    Poll for completions on the passed in queue. Returns number of
> - *    completed entries found. If @spin is true, then blk_poll will continue
> - *    looping until at least one completion is found, unless the task is
> - *    otherwise marked running (or we need to reschedule).
> + *    completed entries found.
>    */
> -int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> +int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
>   {
>   	if (cookie == BLK_QC_T_NONE ||
>   	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> @@ -3926,12 +3924,12 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>   	if (current->plug)
>   		blk_flush_plug_list(current->plug, false);
>   
> -	/* If specified not to spin, we also should not sleep. */
> -	if (spin && q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
> +	if (!(flags & BLK_POLL_NOSLEEP) &&
> +	    q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
>   		if (blk_mq_poll_hybrid(q, cookie))
>   			return 1;
>   	}
> -	return blk_mq_poll_classic(q, cookie, spin);
> +	return blk_mq_poll_classic(q, cookie, flags);

I think that the combination of oneshot and nosleep flags to replace
a boolen spin is a little hard to follow (especially that spin doesn't
mean spinning without sleeping).

Maybe we should break it to:
1. replace spin to flags with ONESHOT passed from io_uring (direct
    replacement)
2. add NOSLEEP passed from io_uring as there is no need for it.

Just a suggestion though that would help (me at least) to follow
this more easily.
