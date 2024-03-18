Return-Path: <linux-fsdevel+bounces-14742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254C387EA39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 14:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD17B226DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 13:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA64481DC;
	Mon, 18 Mar 2024 13:38:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791847F7E;
	Mon, 18 Mar 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769100; cv=none; b=oHv/LAI3G/QYInnn2SJdFBcCK3cmdVey6WhrfEG10uFRIeJhMmNucNfE9MvixMsZNpacbE2EfuxmPkZN/2r1q8FzHWKxhzUDh5Sfsj44izI3SIFcEMNXmvHO+OLARjKeC2KE7LY2yaa9jVgsClzwqR6RA2RmU5mFvgRdqESw7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769100; c=relaxed/simple;
	bh=TW+nNoyK9VLr9DvfFuI7Dm6Kw7KGHKM+2cAyAWlem9c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KGukCYoO7kyFVnJUHnchdkdvk5BhCDhLwgvJ4fUVsOVjv1nD91UwNFOWkRpxHLkmewLR92IS3QBnrOH1YIRjD+AySva5UvIlMJCu6NiiM3GKalESx2bfCbRRF+dvTlqTwQJfvAzoPCdmJZVRz/G5KeTljEHL8VS8sY733QSEBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TywsT5zlYz4f3jJ8;
	Mon, 18 Mar 2024 21:38:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A288E1A01A7;
	Mon, 18 Mar 2024 21:38:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ6_Q_hlYp5aHQ--.21653S3;
	Mon, 18 Mar 2024 21:38:09 +0800 (CST)
Subject: Re: [RFC v4 linux-next 17/19] dm-vdo: prevent direct access of
 bd_inode
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-18-yukuai1@huaweicloud.com>
 <20240318091958.u3yqy2ab7rbqbroq@quack3>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b7642487-3349-76b1-bd16-e870d4ce37e0@huaweicloud.com>
Date: Mon, 18 Mar 2024 21:38:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240318091958.u3yqy2ab7rbqbroq@quack3>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ6_Q_hlYp5aHQ--.21653S3
X-Coremail-Antispam: 1UD129KBjvAXoW3tr48GrWDJr4DZrykGFyUKFg_yoW8Xr13Zo
	WaqrW3Wa18Jwn5JFWrJas7JFyavayDAw45Ca1rZFZxXw4Uta15JF47Jw15XF13tF10qFs8
	ZryxG3srtFWUXFs8n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYq7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/03/18 17:19, Jan Kara Ð´µÀ:
> On Thu 22-02-24 20:45:53, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Now that dm upper layer already statsh the file of opened device in
>> 'dm_dev->bdev_file', it's ok to get inode from the file.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Given there are like three real uses of ->bdev in dm-vdo, I suspect it
> might be better to just replace bdev with bdev_file in struct io_factory
> and in struct uds_parameters.

Yes, this make sense.

Thanks for the review!
Kuai

> 
> 								Honza
> 
>> ---
>>   drivers/md/dm-vdo/dedupe.c                |  3 ++-
>>   drivers/md/dm-vdo/dm-vdo-target.c         |  5 +++--
>>   drivers/md/dm-vdo/indexer/config.c        |  1 +
>>   drivers/md/dm-vdo/indexer/config.h        |  3 +++
>>   drivers/md/dm-vdo/indexer/index-layout.c  |  6 +++---
>>   drivers/md/dm-vdo/indexer/index-layout.h  |  2 +-
>>   drivers/md/dm-vdo/indexer/index-session.c | 13 +++++++------
>>   drivers/md/dm-vdo/indexer/index.c         |  4 ++--
>>   drivers/md/dm-vdo/indexer/index.h         |  2 +-
>>   drivers/md/dm-vdo/indexer/indexer.h       |  4 +++-
>>   drivers/md/dm-vdo/indexer/io-factory.c    | 13 ++++++++-----
>>   drivers/md/dm-vdo/indexer/io-factory.h    |  4 ++--
>>   drivers/md/dm-vdo/indexer/volume.c        |  4 ++--
>>   drivers/md/dm-vdo/indexer/volume.h        |  2 +-
>>   14 files changed, 39 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
>> index a9b189395592..532294a15174 100644
>> --- a/drivers/md/dm-vdo/dedupe.c
>> +++ b/drivers/md/dm-vdo/dedupe.c
>> @@ -2592,7 +2592,8 @@ static void resume_index(void *context, struct vdo_completion *parent)
>>   	int result;
>>   
>>   	zones->parameters.bdev = config->owned_device->bdev;
>> -	result = uds_resume_index_session(zones->index_session, zones->parameters.bdev);
>> +	zones->parameters.bdev_file = config->owned_device->bdev_file;
>> +	result = uds_resume_index_session(zones->index_session, zones->parameters.bdev_file);
>>   	if (result != UDS_SUCCESS)
>>   		vdo_log_error_strerror(result, "Error resuming dedupe index");
>>   
>> diff --git a/drivers/md/dm-vdo/dm-vdo-target.c b/drivers/md/dm-vdo/dm-vdo-target.c
>> index 89d00be9f075..b2d7f68e70be 100644
>> --- a/drivers/md/dm-vdo/dm-vdo-target.c
>> +++ b/drivers/md/dm-vdo/dm-vdo-target.c
>> @@ -883,7 +883,7 @@ static int parse_device_config(int argc, char **argv, struct dm_target *ti,
>>   	}
>>   
>>   	if (config->version == 0) {
>> -		u64 device_size = i_size_read(config->owned_device->bdev->bd_inode);
>> +		u64 device_size = i_size_read(file_inode(config->owned_device->bdev_file));
>>   
>>   		config->physical_blocks = device_size / VDO_BLOCK_SIZE;
>>   	}
>> @@ -1018,7 +1018,8 @@ static void vdo_status(struct dm_target *ti, status_type_t status_type,
>>   
>>   static block_count_t __must_check get_underlying_device_block_count(const struct vdo *vdo)
>>   {
>> -	return i_size_read(vdo_get_backing_device(vdo)->bd_inode) / VDO_BLOCK_SIZE;
>> +	return i_size_read(file_inode(vdo->device_config->owned_device->bdev_file)) /
>> +		VDO_BLOCK_SIZE;
>>   }
>>   
>>   static int __must_check process_vdo_message_locked(struct vdo *vdo, unsigned int argc,
>> diff --git a/drivers/md/dm-vdo/indexer/config.c b/drivers/md/dm-vdo/indexer/config.c
>> index 260993ce1944..f1f66e232b54 100644
>> --- a/drivers/md/dm-vdo/indexer/config.c
>> +++ b/drivers/md/dm-vdo/indexer/config.c
>> @@ -347,6 +347,7 @@ int uds_make_configuration(const struct uds_parameters *params,
>>   	config->sparse_sample_rate = (params->sparse ? DEFAULT_SPARSE_SAMPLE_RATE : 0);
>>   	config->nonce = params->nonce;
>>   	config->bdev = params->bdev;
>> +	config->bdev_file = params->bdev_file;
>>   	config->offset = params->offset;
>>   	config->size = params->size;
>>   
>> diff --git a/drivers/md/dm-vdo/indexer/config.h b/drivers/md/dm-vdo/indexer/config.h
>> index fe7958263ed6..688f7450183e 100644
>> --- a/drivers/md/dm-vdo/indexer/config.h
>> +++ b/drivers/md/dm-vdo/indexer/config.h
>> @@ -28,6 +28,9 @@ struct uds_configuration {
>>   	/* Storage device for the index */
>>   	struct block_device *bdev;
>>   
>> +	/* Opened device fot the index */
>> +	struct file *bdev_file;
>> +
>>   	/* The maximum allowable size of the index */
>>   	size_t size;
>>   
>> diff --git a/drivers/md/dm-vdo/indexer/index-layout.c b/drivers/md/dm-vdo/indexer/index-layout.c
>> index 1453fddaa656..6dd80a432fe5 100644
>> --- a/drivers/md/dm-vdo/indexer/index-layout.c
>> +++ b/drivers/md/dm-vdo/indexer/index-layout.c
>> @@ -1672,7 +1672,7 @@ static int create_layout_factory(struct index_layout *layout,
>>   	size_t writable_size;
>>   	struct io_factory *factory = NULL;
>>   
>> -	result = uds_make_io_factory(config->bdev, &factory);
>> +	result = uds_make_io_factory(config->bdev_file, &factory);
>>   	if (result != UDS_SUCCESS)
>>   		return result;
>>   
>> @@ -1745,9 +1745,9 @@ void vdo_free_index_layout(struct index_layout *layout)
>>   }
>>   
>>   int uds_replace_index_layout_storage(struct index_layout *layout,
>> -				     struct block_device *bdev)
>> +				     struct file *bdev_file)
>>   {
>> -	return uds_replace_storage(layout->factory, bdev);
>> +	return uds_replace_storage(layout->factory, bdev_file);
>>   }
>>   
>>   /* Obtain a dm_bufio_client for the volume region. */
>> diff --git a/drivers/md/dm-vdo/indexer/index-layout.h b/drivers/md/dm-vdo/indexer/index-layout.h
>> index bd9b90c84a70..9b0c850fe9a7 100644
>> --- a/drivers/md/dm-vdo/indexer/index-layout.h
>> +++ b/drivers/md/dm-vdo/indexer/index-layout.h
>> @@ -24,7 +24,7 @@ int __must_check uds_make_index_layout(struct uds_configuration *config, bool ne
>>   void vdo_free_index_layout(struct index_layout *layout);
>>   
>>   int __must_check uds_replace_index_layout_storage(struct index_layout *layout,
>> -						  struct block_device *bdev);
>> +						  struct file *bdev_file);
>>   
>>   int __must_check uds_load_index_state(struct index_layout *layout,
>>   				      struct uds_index *index);
>> diff --git a/drivers/md/dm-vdo/indexer/index-session.c b/drivers/md/dm-vdo/indexer/index-session.c
>> index 1949a2598656..df8f8122a22d 100644
>> --- a/drivers/md/dm-vdo/indexer/index-session.c
>> +++ b/drivers/md/dm-vdo/indexer/index-session.c
>> @@ -460,15 +460,16 @@ int uds_suspend_index_session(struct uds_index_session *session, bool save)
>>   	return uds_status_to_errno(result);
>>   }
>>   
>> -static int replace_device(struct uds_index_session *session, struct block_device *bdev)
>> +static int replace_device(struct uds_index_session *session, struct file *bdev_file)
>>   {
>>   	int result;
>>   
>> -	result = uds_replace_index_storage(session->index, bdev);
>> +	result = uds_replace_index_storage(session->index, bdev_file);
>>   	if (result != UDS_SUCCESS)
>>   		return result;
>>   
>> -	session->parameters.bdev = bdev;
>> +	session->parameters.bdev = file_bdev(bdev_file);
>> +	session->parameters.bdev_file = bdev_file;
>>   	return UDS_SUCCESS;
>>   }
>>   
>> @@ -477,7 +478,7 @@ static int replace_device(struct uds_index_session *session, struct block_device
>>    * device differs from the current backing store, the index will start using the new backing store.
>>    */
>>   int uds_resume_index_session(struct uds_index_session *session,
>> -			     struct block_device *bdev)
>> +			     struct file *bdev_file)
>>   {
>>   	int result = UDS_SUCCESS;
>>   	bool no_work = false;
>> @@ -502,8 +503,8 @@ int uds_resume_index_session(struct uds_index_session *session,
>>   	if (no_work)
>>   		return result;
>>   
>> -	if ((session->index != NULL) && (bdev != session->parameters.bdev)) {
>> -		result = replace_device(session, bdev);
>> +	if ((session->index != NULL) && (bdev_file != session->parameters.bdev_file)) {
>> +		result = replace_device(session, bdev_file);
>>   		if (result != UDS_SUCCESS) {
>>   			mutex_lock(&session->request_mutex);
>>   			session->state &= ~IS_FLAG_WAITING;
>> diff --git a/drivers/md/dm-vdo/indexer/index.c b/drivers/md/dm-vdo/indexer/index.c
>> index bd2405738c50..3600a169ca98 100644
>> --- a/drivers/md/dm-vdo/indexer/index.c
>> +++ b/drivers/md/dm-vdo/indexer/index.c
>> @@ -1334,9 +1334,9 @@ int uds_save_index(struct uds_index *index)
>>   	return result;
>>   }
>>   
>> -int uds_replace_index_storage(struct uds_index *index, struct block_device *bdev)
>> +int uds_replace_index_storage(struct uds_index *index, struct file *bdev_file)
>>   {
>> -	return uds_replace_volume_storage(index->volume, index->layout, bdev);
>> +	return uds_replace_volume_storage(index->volume, index->layout, bdev_file);
>>   }
>>   
>>   /* Accessing statistics should be safe from any thread. */
>> diff --git a/drivers/md/dm-vdo/indexer/index.h b/drivers/md/dm-vdo/indexer/index.h
>> index 7fbc63db4131..9428ee025cda 100644
>> --- a/drivers/md/dm-vdo/indexer/index.h
>> +++ b/drivers/md/dm-vdo/indexer/index.h
>> @@ -72,7 +72,7 @@ int __must_check uds_save_index(struct uds_index *index);
>>   void vdo_free_index(struct uds_index *index);
>>   
>>   int __must_check uds_replace_index_storage(struct uds_index *index,
>> -					   struct block_device *bdev);
>> +					   struct file *bdev_file);
>>   
>>   void uds_get_index_stats(struct uds_index *index, struct uds_index_stats *counters);
>>   
>> diff --git a/drivers/md/dm-vdo/indexer/indexer.h b/drivers/md/dm-vdo/indexer/indexer.h
>> index a832a34d9436..5dd2c93f12c2 100644
>> --- a/drivers/md/dm-vdo/indexer/indexer.h
>> +++ b/drivers/md/dm-vdo/indexer/indexer.h
>> @@ -130,6 +130,8 @@ struct uds_volume_record {
>>   struct uds_parameters {
>>   	/* The block_device used for storage */
>>   	struct block_device *bdev;
>> +	/* Then opened block_device */
>> +	struct file *bdev_file;
>>   	/* The maximum allowable size of the index on storage */
>>   	size_t size;
>>   	/* The offset where the index should start */
>> @@ -314,7 +316,7 @@ int __must_check uds_suspend_index_session(struct uds_index_session *session, bo
>>    * start using the new backing store instead.
>>    */
>>   int __must_check uds_resume_index_session(struct uds_index_session *session,
>> -					  struct block_device *bdev);
>> +					  struct file *bdev_file);
>>   
>>   /* Wait until all outstanding index operations are complete. */
>>   int __must_check uds_flush_index_session(struct uds_index_session *session);
>> diff --git a/drivers/md/dm-vdo/indexer/io-factory.c b/drivers/md/dm-vdo/indexer/io-factory.c
>> index 61104d5ccd61..a855c3ac73bc 100644
>> --- a/drivers/md/dm-vdo/indexer/io-factory.c
>> +++ b/drivers/md/dm-vdo/indexer/io-factory.c
>> @@ -23,6 +23,7 @@
>>    */
>>   struct io_factory {
>>   	struct block_device *bdev;
>> +	struct file *bdev_file;
>>   	atomic_t ref_count;
>>   };
>>   
>> @@ -59,7 +60,7 @@ static void uds_get_io_factory(struct io_factory *factory)
>>   	atomic_inc(&factory->ref_count);
>>   }
>>   
>> -int uds_make_io_factory(struct block_device *bdev, struct io_factory **factory_ptr)
>> +int uds_make_io_factory(struct file *bdev_file, struct io_factory **factory_ptr)
>>   {
>>   	int result;
>>   	struct io_factory *factory;
>> @@ -68,16 +69,18 @@ int uds_make_io_factory(struct block_device *bdev, struct io_factory **factory_p
>>   	if (result != VDO_SUCCESS)
>>   		return result;
>>   
>> -	factory->bdev = bdev;
>> +	factory->bdev = file_bdev(bdev_file);
>> +	factory->bdev_file = bdev_file;
>>   	atomic_set_release(&factory->ref_count, 1);
>>   
>>   	*factory_ptr = factory;
>>   	return UDS_SUCCESS;
>>   }
>>   
>> -int uds_replace_storage(struct io_factory *factory, struct block_device *bdev)
>> +int uds_replace_storage(struct io_factory *factory, struct file *bdev_file)
>>   {
>> -	factory->bdev = bdev;
>> +	factory->bdev = file_bdev(bdev_file);
>> +	factory->bdev_file = bdev_file;
>>   	return UDS_SUCCESS;
>>   }
>>   
>> @@ -90,7 +93,7 @@ void uds_put_io_factory(struct io_factory *factory)
>>   
>>   size_t uds_get_writable_size(struct io_factory *factory)
>>   {
>> -	return i_size_read(factory->bdev->bd_inode);
>> +	return i_size_read(file_inode(factory->bdev_file));
>>   }
>>   
>>   /* Create a struct dm_bufio_client for an index region starting at offset. */
>> diff --git a/drivers/md/dm-vdo/indexer/io-factory.h b/drivers/md/dm-vdo/indexer/io-factory.h
>> index 60749a9ff756..e5100ab57754 100644
>> --- a/drivers/md/dm-vdo/indexer/io-factory.h
>> +++ b/drivers/md/dm-vdo/indexer/io-factory.h
>> @@ -24,11 +24,11 @@ enum {
>>   	SECTORS_PER_BLOCK = UDS_BLOCK_SIZE >> SECTOR_SHIFT,
>>   };
>>   
>> -int __must_check uds_make_io_factory(struct block_device *bdev,
>> +int __must_check uds_make_io_factory(struct file *bdev_file,
>>   				     struct io_factory **factory_ptr);
>>   
>>   int __must_check uds_replace_storage(struct io_factory *factory,
>> -				     struct block_device *bdev);
>> +				     struct file *bdev_file);
>>   
>>   void uds_put_io_factory(struct io_factory *factory);
>>   
>> diff --git a/drivers/md/dm-vdo/indexer/volume.c b/drivers/md/dm-vdo/indexer/volume.c
>> index 8b21ec93f3bc..a292840a83e3 100644
>> --- a/drivers/md/dm-vdo/indexer/volume.c
>> +++ b/drivers/md/dm-vdo/indexer/volume.c
>> @@ -1467,12 +1467,12 @@ int uds_find_volume_chapter_boundaries(struct volume *volume, u64 *lowest_vcn,
>>   
>>   int __must_check uds_replace_volume_storage(struct volume *volume,
>>   					    struct index_layout *layout,
>> -					    struct block_device *bdev)
>> +					    struct file *bdev_file)
>>   {
>>   	int result;
>>   	u32 i;
>>   
>> -	result = uds_replace_index_layout_storage(layout, bdev);
>> +	result = uds_replace_index_layout_storage(layout, bdev_file);
>>   	if (result != UDS_SUCCESS)
>>   		return result;
>>   
>> diff --git a/drivers/md/dm-vdo/indexer/volume.h b/drivers/md/dm-vdo/indexer/volume.h
>> index 7fdd44464db2..5861654d837e 100644
>> --- a/drivers/md/dm-vdo/indexer/volume.h
>> +++ b/drivers/md/dm-vdo/indexer/volume.h
>> @@ -131,7 +131,7 @@ void vdo_free_volume(struct volume *volume);
>>   
>>   int __must_check uds_replace_volume_storage(struct volume *volume,
>>   					    struct index_layout *layout,
>> -					    struct block_device *bdev);
>> +					    struct file *bdev_file);
>>   
>>   int __must_check uds_find_volume_chapter_boundaries(struct volume *volume,
>>   						    u64 *lowest_vcn, u64 *highest_vcn,
>> -- 
>> 2.39.2
>>


