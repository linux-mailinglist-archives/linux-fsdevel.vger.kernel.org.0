Return-Path: <linux-fsdevel+bounces-63000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E45DBA893C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376253AA575
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9BE284B29;
	Mon, 29 Sep 2025 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQM5kN0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0234BA41
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137553; cv=none; b=JeepGq1X06JtOeC5M5YJiet4LTjlBJ/hBGrbqMzA2ph9URb98fg+BujYdczgtGxymq6YlJQoG5/A6oe/oDpS6sVheNdlZ3rsl/BwlCAZDd8PowpzIr1AM14AVM0JWIoH9Pp3Lr16Kx0jj0VX+qS4bIGOQJLN56SF3xn8LVuRXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137553; c=relaxed/simple;
	bh=aJIXFbQzD7C3Q3cbP/Y2zZW3bB3oSP9uA7tGjZg9Ygw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh6orufiEdw+DbsY56Gvkl4eG+FN2JqnLk1GQLdLxR6wC0ZbyWk6X42pGQmm4wGOSO1GLmcMWqNiHP6VLulr6hWCXn3//kQgbyVRHcdV68gz8ggL8Ploh564HapbWZeZd3GoKfzT7hIomZOgDsLDSzLJ8ncI0KfYar69/hbIZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQM5kN0/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759137551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m14nFMin7/94WpJU41b6+xjuPj85lzMdm8NE7gofAB4=;
	b=NQM5kN0/qOV+BaMIq3veXsOtRoloDZ3aG0hfXaw1Mzkyqkl5oAUze2XbZQ+4KcN73KyFqZ
	nMIE7dssvN8B1LI245pdEJFKEnDymr1q+4EZzB6LkDQNvYXUR/Oq3l0lIxwwPUpgyfKIZo
	H2sh/Zti0ZJiQcwuPbd2gXIPtgip9lQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-itVRuzJYO8qR-gRmwG7xDA-1; Mon,
 29 Sep 2025 05:19:05 -0400
X-MC-Unique: itVRuzJYO8qR-gRmwG7xDA-1
X-Mimecast-MFC-AGG-ID: itVRuzJYO8qR-gRmwG7xDA_1759137543
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13CEB19560B3;
	Mon, 29 Sep 2025 09:19:03 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 206F530001A4;
	Mon, 29 Sep 2025 09:18:56 +0000 (UTC)
Date: Mon, 29 Sep 2025 17:18:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH V4 5/6] loop: try to handle loop aio command via NOWAIT
 IO first
Message-ID: <aNpOiQbgrSukFaUT@fedora>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
 <20250928132927.3672537-6-ming.lei@redhat.com>
 <d043680f-1d7a-bcb8-2588-4eae403f050d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d043680f-1d7a-bcb8-2588-4eae403f050d@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Sep 29, 2025 at 02:44:53PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/09/28 21:29, Ming Lei 写道:
> > Try to handle loop aio command via NOWAIT IO first, then we can avoid to
> > queue the aio command into workqueue. This is usually one big win in
> > case that FS block mapping is stable, Mikulas verified [1] that this way
> > improves IO perf by close to 5X in 12jobs sequential read/write test,
> > in which FS block mapping is just stable.
> > 
> > Fallback to workqueue in case of -EAGAIN. This way may bring a little
> > cost from the 1st retry, but when running the following write test over
> > loop/sparse_file, the actual effect on randwrite is obvious:
> > 
> > ```
> > truncate -s 4G 1.img    #1.img is created on XFS/virtio-scsi
> > losetup -f 1.img --direct-io=on
> > fio --direct=1 --bs=4k --runtime=40 --time_based --numjobs=1 --ioengine=libaio \
> > 	--iodepth=16 --group_reporting=1 --filename=/dev/loop0 -name=job --rw=$RW
> > ```
> > 
> > - RW=randwrite: obvious IOPS drop observed
> > - RW=write: a little drop(%5 - 10%)
> > 
> > This perf drop on randwrite over sparse file will be addressed in the
> > following patch.
> > 
> > BLK_MQ_F_BLOCKING has to be set for calling into .read_iter() or .write_iter()
> > which might sleep even though it is NOWAIT, and the only effect is that rcu read
> > lock is replaced with srcu read lock.
> > 
> > Link: https://lore.kernel.org/linux-block/a8e5c76a-231f-07d1-a394-847de930f638@redhat.com/ [1]
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/block/loop.c | 62 ++++++++++++++++++++++++++++++++++++++++----
> >   1 file changed, 57 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 99eec0a25dbc..57e33553695b 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -90,6 +90,8 @@ struct loop_cmd {
> >   #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
> >   #define LOOP_DEFAULT_HW_Q_DEPTH 128
> > +static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd);
> > +
> >   static DEFINE_IDR(loop_index_idr);
> >   static DEFINE_MUTEX(loop_ctl_mutex);
> >   static DEFINE_MUTEX(loop_validate_mutex);
> > @@ -321,6 +323,15 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
> >   	if (!atomic_dec_and_test(&cmd->ref))
> >   		return;
> > +
> > +	/* -EAGAIN could be returned from bdev's ->ki_complete */
> > +	if (cmd->ret == -EAGAIN) {
> > +		struct loop_device *lo = rq->q->queuedata;
> > +
> > +		loop_queue_work(lo, cmd);
> > +		return;
> > +	}
> > +
> >   	kfree(cmd->bvec);
> >   	cmd->bvec = NULL;
> >   	if (req_op(rq) == REQ_OP_WRITE)
> > @@ -436,16 +447,40 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
> >   	int nr_bvec = lo_cmd_nr_bvec(cmd);
> >   	int ret;
> > -	ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
> > -	if (unlikely(ret))
> > -		return ret;
> > +	/* prepared already for aio from nowait code path */
> > +	if (!cmd->use_aio) {
> > +		ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
> > +		if (unlikely(ret))
> > +			goto fail;
> > +	}
> > +	cmd->iocb.ki_flags &= ~IOCB_NOWAIT;
> >   	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
> > +fail:
> >   	if (ret != -EIOCBQUEUED)
> >   		lo_rw_aio_complete(&cmd->iocb, ret);
> >   	return -EIOCBQUEUED;
> >   }
> > +static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd,
> > +			    int rw)
> > +{
> > +	struct request *rq = blk_mq_rq_from_pdu(cmd);
> > +	loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
> > +	int nr_bvec = lo_cmd_nr_bvec(cmd);
> > +	int ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
> > +
> > +	if (unlikely(ret))
> > +		goto fail;
> > +
> > +	cmd->iocb.ki_flags |= IOCB_NOWAIT;
> > +	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
> 
> Should you also check if backing device/file support nowait? Otherwise
> bio will fail with BLK_STS_NOTSUPP from submit_bio_noacct().

Good catch, nowait should only be applied in case of FMODE_NOWAIT, will add the
check.


Thanks,
Ming


