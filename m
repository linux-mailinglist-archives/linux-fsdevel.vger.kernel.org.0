Return-Path: <linux-fsdevel+bounces-62991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8FABA8290
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 08:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED973B3F0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 06:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D42BE7DF;
	Mon, 29 Sep 2025 06:45:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118AF1DE8AD;
	Mon, 29 Sep 2025 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128303; cv=none; b=jmKoPnz+XkJfjke12e+dI8/vh7mWPwHcolsVWlAtfBrFj6T6gTMtTKZUdQtS/mGO3eIzHpv5xh6H/z2+k7VOi6AigZtdZj5bOc8JnzhhC3ONlwk8ExAYdQx1ax6wtD9Pt0eicHnFtWjM+djwx/uTyZwSxsGnBJjc5f3hH4zBBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128303; c=relaxed/simple;
	bh=VR0tNqlEtaHNo6K68DKgjEOek9PiL7jrLFavRfBNQBk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BAnnCbEY6kKzSb7x7mm9tRqLvLHv8j+iQ3XeYxeHu2Df9S8qV6x1qDThmVohYooXskZB7gNljKNmnG19/iSuoTmRi91FXrE9k0vhTmDyMV9ND13IRTt5RyIhKeoRzkMESn0P/ChKEvssxoGgZ+X/AfWXhDyMGYDO08UDFq9oO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cZsB36bqXzKHMdr;
	Mon, 29 Sep 2025 14:44:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5E20E1A06D7;
	Mon, 29 Sep 2025 14:44:57 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHi2PlKtpomjTEBA--.25025S3;
	Mon, 29 Sep 2025 14:44:55 +0800 (CST)
Subject: Re: [PATCH V4 5/6] loop: try to handle loop aio command via NOWAIT IO
 first
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
 <20250928132927.3672537-6-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d043680f-1d7a-bcb8-2588-4eae403f050d@huaweicloud.com>
Date: Mon, 29 Sep 2025 14:44:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250928132927.3672537-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHi2PlKtpomjTEBA--.25025S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1UWw1DJFWUJr13Zr4fZrb_yoW7WF4fpF
	4YgayYkFZ8tF47Wa9xXw48u34ag3WfXry7Zw4Sgw4Y9F1ayr9IvF18tryYvF4xJrZ7Gr18
	Za1qyryDWr1jq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/09/28 21:29, Ming Lei Ð´µÀ:
> Try to handle loop aio command via NOWAIT IO first, then we can avoid to
> queue the aio command into workqueue. This is usually one big win in
> case that FS block mapping is stable, Mikulas verified [1] that this way
> improves IO perf by close to 5X in 12jobs sequential read/write test,
> in which FS block mapping is just stable.
> 
> Fallback to workqueue in case of -EAGAIN. This way may bring a little
> cost from the 1st retry, but when running the following write test over
> loop/sparse_file, the actual effect on randwrite is obvious:
> 
> ```
> truncate -s 4G 1.img    #1.img is created on XFS/virtio-scsi
> losetup -f 1.img --direct-io=on
> fio --direct=1 --bs=4k --runtime=40 --time_based --numjobs=1 --ioengine=libaio \
> 	--iodepth=16 --group_reporting=1 --filename=/dev/loop0 -name=job --rw=$RW
> ```
> 
> - RW=randwrite: obvious IOPS drop observed
> - RW=write: a little drop(%5 - 10%)
> 
> This perf drop on randwrite over sparse file will be addressed in the
> following patch.
> 
> BLK_MQ_F_BLOCKING has to be set for calling into .read_iter() or .write_iter()
> which might sleep even though it is NOWAIT, and the only effect is that rcu read
> lock is replaced with srcu read lock.
> 
> Link: https://lore.kernel.org/linux-block/a8e5c76a-231f-07d1-a394-847de930f638@redhat.com/ [1]
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/block/loop.c | 62 ++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 99eec0a25dbc..57e33553695b 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -90,6 +90,8 @@ struct loop_cmd {
>   #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
>   #define LOOP_DEFAULT_HW_Q_DEPTH 128
>   
> +static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd);
> +
>   static DEFINE_IDR(loop_index_idr);
>   static DEFINE_MUTEX(loop_ctl_mutex);
>   static DEFINE_MUTEX(loop_validate_mutex);
> @@ -321,6 +323,15 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
>   
>   	if (!atomic_dec_and_test(&cmd->ref))
>   		return;
> +
> +	/* -EAGAIN could be returned from bdev's ->ki_complete */
> +	if (cmd->ret == -EAGAIN) {
> +		struct loop_device *lo = rq->q->queuedata;
> +
> +		loop_queue_work(lo, cmd);
> +		return;
> +	}
> +
>   	kfree(cmd->bvec);
>   	cmd->bvec = NULL;
>   	if (req_op(rq) == REQ_OP_WRITE)
> @@ -436,16 +447,40 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>   	int nr_bvec = lo_cmd_nr_bvec(cmd);
>   	int ret;
>   
> -	ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
> -	if (unlikely(ret))
> -		return ret;
> +	/* prepared already for aio from nowait code path */
> +	if (!cmd->use_aio) {
> +		ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
> +		if (unlikely(ret))
> +			goto fail;
> +	}
>   
> +	cmd->iocb.ki_flags &= ~IOCB_NOWAIT;
>   	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
> +fail:
>   	if (ret != -EIOCBQUEUED)
>   		lo_rw_aio_complete(&cmd->iocb, ret);
>   	return -EIOCBQUEUED;
>   }
>   
> +static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd,
> +			    int rw)
> +{
> +	struct request *rq = blk_mq_rq_from_pdu(cmd);
> +	loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
> +	int nr_bvec = lo_cmd_nr_bvec(cmd);
> +	int ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
> +
> +	if (unlikely(ret))
> +		goto fail;
> +
> +	cmd->iocb.ki_flags |= IOCB_NOWAIT;
> +	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);

Should you also check if backing device/file support nowait? Otherwise
bio will fail with BLK_STS_NOTSUPP from submit_bio_noacct().

Thanks,
Kuai

> +fail:
> +	if (ret != -EIOCBQUEUED && ret != -EAGAIN)
> +		lo_rw_aio_complete(&cmd->iocb, ret);
> +	return ret;
> +}
> +
>   static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>   {
>   	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
> @@ -1903,6 +1938,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	struct request *rq = bd->rq;
>   	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
>   	struct loop_device *lo = rq->q->queuedata;
> +	int rw = 0;
>   
>   	blk_mq_start_request(rq);
>   
> @@ -1915,9 +1951,24 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	case REQ_OP_WRITE_ZEROES:
>   		cmd->use_aio = false;
>   		break;
> -	default:
> +	case REQ_OP_READ:
> +		rw = ITER_DEST;
> +		cmd->use_aio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
> +		break;
> +	case REQ_OP_WRITE:
> +		rw = ITER_SOURCE;
>   		cmd->use_aio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
>   		break;
> +	default:
> +		return BLK_STS_IOERR;
> +	}
> +
> +	if (cmd->use_aio) {
> +		int res = lo_rw_aio_nowait(lo, cmd, rw);
> +
> +		if (res != -EAGAIN)
> +			return BLK_STS_OK;
> +		/* fallback to workqueue for handling aio */
>   	}
>   
>   	loop_queue_work(lo, cmd);
> @@ -2069,7 +2120,8 @@ static int loop_add(int i)
>   	lo->tag_set.queue_depth = hw_queue_depth;
>   	lo->tag_set.numa_node = NUMA_NO_NODE;
>   	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
> -	lo->tag_set.flags = BLK_MQ_F_STACKING | BLK_MQ_F_NO_SCHED_BY_DEFAULT;
> +	lo->tag_set.flags = BLK_MQ_F_STACKING | BLK_MQ_F_NO_SCHED_BY_DEFAULT |
> +		BLK_MQ_F_BLOCKING;
>   	lo->tag_set.driver_data = lo;
>   
>   	err = blk_mq_alloc_tag_set(&lo->tag_set);
> 


