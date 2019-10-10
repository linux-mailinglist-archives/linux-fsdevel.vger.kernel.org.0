Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835F2D2FD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfJJR5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 13:57:16 -0400
Received: from ale.deltatee.com ([207.54.116.67]:53342 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfJJR5Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:57:16 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iIcgF-0000Hl-4N; Thu, 10 Oct 2019 11:56:52 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-12-logang@deltatee.com> <20191010100526.GA27209@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d0b7e064-2e28-83b0-1593-405ab75d5bd2@deltatee.com>
Date:   Thu, 10 Oct 2019 11:56:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010100526.GA27209@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v9 10/12] block: don't check blk_rq_is_passthrough() in
 blk_do_io_stat()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey,

Thanks for the thorough review, lots here to go through. I'll address it
all as I have time and try to get the prep work done first, as soon as I
can.

On 2019-10-10 4:05 a.m., Christoph Hellwig wrote:
>> @@ -319,7 +319,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>>  	rq->cmd_flags = op;
>>  	if (data->flags & BLK_MQ_REQ_PREEMPT)
>>  		rq->rq_flags |= RQF_PREEMPT;
>> -	if (blk_queue_io_stat(data->q))
>> +	if (blk_queue_io_stat(data->q) && !blk_rq_is_passthrough(rq))
>>  		rq->rq_flags |= RQF_IO_STAT;
> 
> This needs a comment why we don't account passthrough requests by
> default.  And I'm really curious about the answer, because I don't
> know it myself.

Yes, sadly, I don't know this answer either but the comment made it
appear that someone did it deliberately. Digging into git blame suggests
that it just evolved that way. The check was originally added in 2005
here with blk_fs_request():

commit d72d904a5367 ("[BLOCK] Update read/write block io statistics at
completion time")

blk_fs_request() evolved to become blk_rq_is_passthrough() but I suspect
no one ever considered whether we want to account the passthru requests.

So, I'll leave this restriction out and see if anyone complains.

Logan

>>   *	a) it's attached to a gendisk, and
>>   *	b) the queue had IO stats enabled when this request was started, and
>> - *	c) it's a file system request
>> + *	c) it's a file system request (RQF_IO_STAT will not be set otherwise)
> 
> c) should just go away now based on your changes.
> 
>>  static inline bool blk_do_io_stat(struct request *rq)
>>  {
>>  	return rq->rq_disk &&
>> -	       (rq->rq_flags & RQF_IO_STAT) &&
>> -		!blk_rq_is_passthrough(rq);
>> +	       (rq->rq_flags & RQF_IO_STAT);
> 
> The check can be collapsed onto a single line now.
> 


