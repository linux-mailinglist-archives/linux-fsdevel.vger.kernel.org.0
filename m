Return-Path: <linux-fsdevel+bounces-13258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E71286DECC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 11:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4D0289584
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9FB6BB33;
	Fri,  1 Mar 2024 10:02:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963536A8D5;
	Fri,  1 Mar 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287349; cv=none; b=pyx6qTMOs7cS8SofLDmrHbsFQnFPbUrTqP1CDtjJuf1IYaXBpHGXSbBvODwW/xgibwv0dHTVeMlCAtIX6j7SnPUZ71OpdQvaBraLNqJHUAiMXrY72eGUheL21oHNr0tLfTzfomkM0lcOgBtdwXF3q6L6NmEgiSH9IXTmfI7a4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287349; c=relaxed/simple;
	bh=79h4Z6GRUMbULpsIRmWKBRoU0c2r7XfcFM37uKiif9I=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ifc0O28lb77D9Xb+rSKWadC4yyCJSLGxX2W7qoIoLDc8jHjQ4atYApqBiPbNath5DjtFc7pfZehEW55//PCO+FDGZNjAJkSKA9km02qPDGqESYH9aWjWN90NhUm3/lq8NZFzOKrMMsr0OGEGhMZj0WqbPLKQPwp0CNuvJwD9Ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TmNqt51m7zvWFc;
	Fri,  1 Mar 2024 18:00:10 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id BFCDD140EAE;
	Fri,  1 Mar 2024 18:02:22 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 18:02:21 +0800
Subject: Re: [PATCH RFC 1/2] iomap: Add a IOMAP_DIO_MAY_INLINE_COMP flag
To: Dave Chinner <david@fromorbit.com>
CC: <brauner@kernel.org>, <djwong@kernel.org>, <jack@suse.cz>,
	<tytso@mit.edu>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20240229113849.2222577-1-chengzhihao1@huawei.com>
 <20240229113849.2222577-2-chengzhihao1@huawei.com>
 <ZeEkFUCUQ4eR7AlX@dread.disaster.area>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3de3ede5-31e0-2b7b-f523-9fd22090401f@huawei.com>
Date: Fri, 1 Mar 2024 18:02:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZeEkFUCUQ4eR7AlX@dread.disaster.area>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/1 8:40, Dave Chinner Ð´µÀ:

Hi Dave, thanks for your detailed and nice suggestions, I have a few 
questions below.
> On Thu, Feb 29, 2024 at 07:38:48PM +0800, Zhihao Cheng wrote:
>> It will be more efficient to execute quick endio process(eg. non-sync
>> overwriting case) under irq process rather than starting a worker to
>> do it.
>> Add a flag to control DIO to be finished inline(under irq context), which
>> can be used for non-sync overwriting case.
>> Besides, skip invalidating pages if DIO is finished inline, which will
>> keep the same logic with dio_bio_end_aio in non-sync overwriting case.
>>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> A nice idea, but I don't think an ext4 specific API flag is the
> right way to go about enabling this. The iomap dio code knows if
> the write is pure overwrite already - we have the IOMAP_F_DIRTY flag
> for that, and we combine this with IOMAP_DIO_WRITE_THROUGH to do the
> pure overwrite FUA optimisations.
> 
> That is:
> 
> 		/*
>                   * Use a FUA write if we need datasync semantics, this is a pure
>                   * data IO that doesn't require any metadata updates (including
>                   * after IO completion such as unwritten extent conversion) and
>                   * the underlying device either supports FUA or doesn't have
>                   * a volatile write cache. This allows us to avoid cache flushes
>                   * on IO completion. If we can't use writethrough and need to
>                   * sync, disable in-task completions as dio completion will
>                   * need to call generic_write_sync() which will do a blocking
>                   * fsync / cache flush call.
>                   */
>                  if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
>                      (dio->flags & IOMAP_DIO_WRITE_THROUGH) &&
>                      (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev)))
>                          use_fua = true;
> 
> Hence if we want to optimise pure overwrites that have no data sync
> requirements, we already have the detection and triggers in place to
> do this. We just need to change the way we set up the IO flags to
> allow write-through (i.e. non-blocking IO completions) to use inline
> completions.
> 
> In __iomap_dio_rw():
> 
> +	/* Always try to complete inline. */
> +	dio->flags |= IOMAP_DIO_INLINE_COMP;
> 	if (iov_iter_rw(iter) == READ) {
> -               /* reads can always complete inline */
> -               dio->flags |= IOMAP_DIO_INLINE_COMP;
> ....
> 
> 	} else {
> +		/* Always try write-through semantics. If we can't
> +		 * use writethough, it will be disabled along with
> +		 * IOMAP_DIO_INLINE_COMP before dio completion is run
> +		 * so it can be deferred to a task completion context
> +		 * appropriately.
> +		 */
> +               dio->flags |= IOMAP_DIO_WRITE | IOMAP_DIO_WRITE_THROUGH;

There is a behavior change here, if we set IOMAP_DIO_WRITE_THROUGH 
unconditionally, non-datasync IO will be set with REQ_FUA, which means 
that device will flush writecache for each IO, will it affect the 
performance in non-sync dio case?
> 		iomi.flags |= IOMAP_WRITE;
> -               dio->flags |= IOMAP_DIO_WRITE;
> .....
> 		/* for data sync or sync, we need sync completion processing */
>                  if (iocb_is_dsync(iocb)) {
>                          dio->flags |= IOMAP_DIO_NEED_SYNC;
> 
> -                      /*
> -                       * For datasync only writes, we optimistically try using
> -                       * WRITE_THROUGH for this IO. This flag requires either
> -                       * FUA writes through the device's write cache, or a
> -                       * normal write to a device without a volatile write
> -                       * cache. For the former, Any non-FUA write that occurs
> -                       * will clear this flag, hence we know before completion
> -                       * whether a cache flush is necessary.
> -                       */
> -                       if (!(iocb->ki_flags & IOCB_SYNC))
> -                               dio->flags |= IOMAP_DIO_WRITE_THROUGH;
> +			* For sync writes we know we are going to need
> +			* blocking completion processing, so turn off
> +			* writethrough now.
> +			*/
> 			if (iocb->ki_flags & IOCB_SYNC) {
> 				dio->flags &= ~(IOMAP_DIO_WRITE_THROUGH |
> 						IOMAP_DIO_INLINE_COMP);
> 			}
>                  }
> 

[...]
> 
> However, this does mean that any spinlock taken in the ->end_io()
> callbacks now needs to be irq safe. e.g. in xfs_dio_write_end_io()
> the spinlock protection around inode size updates will need to use
> an irq safe locking, as will the locking in the DIO submission path
> that it serialises against in xfs_file_write_checks(). That probably
> is best implemented as a separate spinlock.
> 
> There will also be other filesystems that need to set IOMAP_F_DIRTY
> unconditionally (e.g. zonefs) because they always take blocking
> locks in their ->end_io callbacks and so must always run in task
> context...
Should we add a new flag(eg. IOMAP_F_ENDIO_IRQ ?) to indicate that the 
endio cannot be done under irq? Because I think IOMAP_F_DIRTY means that 
the metadata needs to be written, if we add a new semantics(endio must 
be done in defered work) for this flag, the code will looks a little 
complicated.


