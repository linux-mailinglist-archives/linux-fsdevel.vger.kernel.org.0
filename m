Return-Path: <linux-fsdevel+bounces-14796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2521387F538
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 03:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4BB2827E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365664CF6;
	Tue, 19 Mar 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCEbQctK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AF64CC9
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710813627; cv=none; b=UmkEynz3KRDUtO/Izc2HdpWN618j4eJ058vbWPQu2/TEK8iSzAghVUjCAP76va5uXg2qH7dtqp3B0gFCdn014tR3GnaJJ++FWkulqClcK2lgjunfbypJ2Hojz6xS5ewWcI3Uep1+ht2xuGTqQujhv4Aze/k5udHrSg1erRaAOsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710813627; c=relaxed/simple;
	bh=tA19Xv0JrUpAj2JyGYjfZUDCXzUeyyAV1698I4s+/+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeNIWTcVZE+S75UqE8j7/XID2e0v9+HKPfCBZzDm72pU7+JdySv/mNf4BS9PRAci2fSxi7PHDOxt+hHuX7q5oG9K3EKIsrm5/EzRcrwOkRFalmF+3/8BDhuPixQXWeM1RYJfKpxuDKP3YgaVEev9eVfgxp+iClNPbEWxAKjkcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCEbQctK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710813623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWVarTuKR+5Y3OHfNtE2XAIkG9VkWP9S9gTbhHveL0Y=;
	b=eCEbQctKVYAzbfij+kD7ZdsDT8k/NkFXXkwALKXmE/WOXKgTZYmn8RyLEzg3JWwNsONtr4
	J8pk5PzJ8LbVUtEP3Ei9glYEOBROQrn/iLkMndUk68Z5GxsD8mloJGQzLo8XxILtFmv71v
	6SfDN6xTrAv6VuWLreKGgu0/J0C3s0M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-U2vEuePpPvWgR6yx9gW9ww-1; Mon, 18 Mar 2024 22:00:22 -0400
X-MC-Unique: U2vEuePpPvWgR6yx9gW9ww-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78860db5adbso451072385a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 19:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710813621; x=1711418421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWVarTuKR+5Y3OHfNtE2XAIkG9VkWP9S9gTbhHveL0Y=;
        b=I9IZxWsoI4Nz9hfYhaKDOGEgpJuTcYroS7fIE+0J0c3iLqD86CbLOnwdc1tCff9Ij3
         cuvW4rw73RV+aP5TeBXQ1O6poiaHxebbIumJDtMJSb93wesL/UroqTG705SDnr/sgRph
         quPkIXNsjwDXBQma/g113laQ8pulWnZdtVii97EIABCwPoZ8vuSXTzuZCMvBTRCxkfJD
         6U7TOO31f7UI9Q+uJ8sp4dacsuSDm1Sb3s8vqBICRfmBBpmh44rP9/PA4c6RiBv58pe+
         9JI2dq/kk470w09RCoVvBe8snNkHIN8UGINqywZdB/5MV3D/2vNuTcKZyRoIG4w75QUa
         vzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO0I2xMd3691dWXvHHdUl90h9EFlxaS9591JyCxRaqj4XQnl8vXkBk0ibHgWbrem24mUXefXghnba11GKkyNrUaclWqhS7ehhZo4UOFA==
X-Gm-Message-State: AOJu0Yxp+1+Klx9ntnxw4ZccRdZttXOw1/TYThN3w7Z6XWcj9zRu6TEp
	Y9eixHTkD3+zrrId6z0gPFhYSQZmd0mX1AvadSFkegN5WzsMiStREcz2t+LVtgI/ulafkUQ2o6/
	lTvWZbHrhc7rEb/RJ4mPmwkAcS7PldeC1XLQDO4/8w68bol3Q60hhcd/SHtkX9uLKZT2yM7dETQ
	==
X-Received: by 2002:a05:620a:469f:b0:789:e9a4:8049 with SMTP id bq31-20020a05620a469f00b00789e9a48049mr12082276qkb.41.1710813621558;
        Mon, 18 Mar 2024 19:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIQ4giey0rjSoJbDfhr4ZSge3bETRW+EwjXUM2MYck3EhfvhzFnKDQsbiiPZfOmCJexen4/A==
X-Received: by 2002:a05:620a:469f:b0:789:e9a4:8049 with SMTP id bq31-20020a05620a469f00b00789e9a48049mr12082254qkb.41.1710813621173;
        Mon, 18 Mar 2024 19:00:21 -0700 (PDT)
Received: from [192.168.1.163] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id x26-20020ae9f81a000000b00785d538aebdsm5053355qkh.95.2024.03.18.19.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 19:00:20 -0700 (PDT)
Message-ID: <f81195ba-9625-92df-895f-65f06f5a0fca@redhat.com>
Date: Mon, 18 Mar 2024 22:00:19 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC v4 linux-next 17/19] dm-vdo: prevent direct access of
 bd_inode
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>
Cc: hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-18-yukuai1@huaweicloud.com>
 <20240318091958.u3yqy2ab7rbqbroq@quack3>
 <b7642487-3349-76b1-bd16-e870d4ce37e0@huaweicloud.com>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <b7642487-3349-76b1-bd16-e870d4ce37e0@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/18/24 09:38, Yu Kuai wrote:
> Hi,
> 
> 在 2024/03/18 17:19, Jan Kara 写道:
>> On Thu 22-02-24 20:45:53, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Now that dm upper layer already statsh the file of opened device in
>>> 'dm_dev->bdev_file', it's ok to get inode from the file.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>
>> Given there are like three real uses of ->bdev in dm-vdo, I suspect it
>> might be better to just replace bdev with bdev_file in struct io_factory
>> and in struct uds_parameters.
> 
> Yes, this make sense.
> 
> Thanks for the review!
> Kuai
>

At a glance this looks completely reasonable to me. However, can you be 
sure to CC: dm-devel@lists.linux.dev for dm-vdo patches? I almost missed 
seeing this patch. I will try to give it a proper review tomorrow.

Matt

>>
>>                                 Honza
>>
>>> ---
>>>   drivers/md/dm-vdo/dedupe.c                |  3 ++-
>>>   drivers/md/dm-vdo/dm-vdo-target.c         |  5 +++--
>>>   drivers/md/dm-vdo/indexer/config.c        |  1 +
>>>   drivers/md/dm-vdo/indexer/config.h        |  3 +++
>>>   drivers/md/dm-vdo/indexer/index-layout.c  |  6 +++---
>>>   drivers/md/dm-vdo/indexer/index-layout.h  |  2 +-
>>>   drivers/md/dm-vdo/indexer/index-session.c | 13 +++++++------
>>>   drivers/md/dm-vdo/indexer/index.c         |  4 ++--
>>>   drivers/md/dm-vdo/indexer/index.h         |  2 +-
>>>   drivers/md/dm-vdo/indexer/indexer.h       |  4 +++-
>>>   drivers/md/dm-vdo/indexer/io-factory.c    | 13 ++++++++-----
>>>   drivers/md/dm-vdo/indexer/io-factory.h    |  4 ++--
>>>   drivers/md/dm-vdo/indexer/volume.c        |  4 ++--
>>>   drivers/md/dm-vdo/indexer/volume.h        |  2 +-
>>>   14 files changed, 39 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
>>> index a9b189395592..532294a15174 100644
>>> --- a/drivers/md/dm-vdo/dedupe.c
>>> +++ b/drivers/md/dm-vdo/dedupe.c
>>> @@ -2592,7 +2592,8 @@ static void resume_index(void *context, struct 
>>> vdo_completion *parent)
>>>       int result;
>>>       zones->parameters.bdev = config->owned_device->bdev;
>>> -    result = uds_resume_index_session(zones->index_session, 
>>> zones->parameters.bdev);
>>> +    zones->parameters.bdev_file = config->owned_device->bdev_file;
>>> +    result = uds_resume_index_session(zones->index_session, 
>>> zones->parameters.bdev_file);
>>>       if (result != UDS_SUCCESS)
>>>           vdo_log_error_strerror(result, "Error resuming dedupe index");
>>> diff --git a/drivers/md/dm-vdo/dm-vdo-target.c 
>>> b/drivers/md/dm-vdo/dm-vdo-target.c
>>> index 89d00be9f075..b2d7f68e70be 100644
>>> --- a/drivers/md/dm-vdo/dm-vdo-target.c
>>> +++ b/drivers/md/dm-vdo/dm-vdo-target.c
>>> @@ -883,7 +883,7 @@ static int parse_device_config(int argc, char 
>>> **argv, struct dm_target *ti,
>>>       }
>>>       if (config->version == 0) {
>>> -        u64 device_size = 
>>> i_size_read(config->owned_device->bdev->bd_inode);
>>> +        u64 device_size = 
>>> i_size_read(file_inode(config->owned_device->bdev_file));
>>>           config->physical_blocks = device_size / VDO_BLOCK_SIZE;
>>>       }
>>> @@ -1018,7 +1018,8 @@ static void vdo_status(struct dm_target *ti, 
>>> status_type_t status_type,
>>>   static block_count_t __must_check 
>>> get_underlying_device_block_count(const struct vdo *vdo)
>>>   {
>>> -    return i_size_read(vdo_get_backing_device(vdo)->bd_inode) / 
>>> VDO_BLOCK_SIZE;
>>> +    return 
>>> i_size_read(file_inode(vdo->device_config->owned_device->bdev_file)) /
>>> +        VDO_BLOCK_SIZE;
>>>   }
>>>   static int __must_check process_vdo_message_locked(struct vdo *vdo, 
>>> unsigned int argc,
>>> diff --git a/drivers/md/dm-vdo/indexer/config.c 
>>> b/drivers/md/dm-vdo/indexer/config.c
>>> index 260993ce1944..f1f66e232b54 100644
>>> --- a/drivers/md/dm-vdo/indexer/config.c
>>> +++ b/drivers/md/dm-vdo/indexer/config.c
>>> @@ -347,6 +347,7 @@ int uds_make_configuration(const struct 
>>> uds_parameters *params,
>>>       config->sparse_sample_rate = (params->sparse ? 
>>> DEFAULT_SPARSE_SAMPLE_RATE : 0);
>>>       config->nonce = params->nonce;
>>>       config->bdev = params->bdev;
>>> +    config->bdev_file = params->bdev_file;
>>>       config->offset = params->offset;
>>>       config->size = params->size;
>>> diff --git a/drivers/md/dm-vdo/indexer/config.h 
>>> b/drivers/md/dm-vdo/indexer/config.h
>>> index fe7958263ed6..688f7450183e 100644
>>> --- a/drivers/md/dm-vdo/indexer/config.h
>>> +++ b/drivers/md/dm-vdo/indexer/config.h
>>> @@ -28,6 +28,9 @@ struct uds_configuration {
>>>       /* Storage device for the index */
>>>       struct block_device *bdev;
>>> +    /* Opened device fot the index */
>>> +    struct file *bdev_file;
>>> +
>>>       /* The maximum allowable size of the index */
>>>       size_t size;
>>> diff --git a/drivers/md/dm-vdo/indexer/index-layout.c 
>>> b/drivers/md/dm-vdo/indexer/index-layout.c
>>> index 1453fddaa656..6dd80a432fe5 100644
>>> --- a/drivers/md/dm-vdo/indexer/index-layout.c
>>> +++ b/drivers/md/dm-vdo/indexer/index-layout.c
>>> @@ -1672,7 +1672,7 @@ static int create_layout_factory(struct 
>>> index_layout *layout,
>>>       size_t writable_size;
>>>       struct io_factory *factory = NULL;
>>> -    result = uds_make_io_factory(config->bdev, &factory);
>>> +    result = uds_make_io_factory(config->bdev_file, &factory);
>>>       if (result != UDS_SUCCESS)
>>>           return result;
>>> @@ -1745,9 +1745,9 @@ void vdo_free_index_layout(struct index_layout 
>>> *layout)
>>>   }
>>>   int uds_replace_index_layout_storage(struct index_layout *layout,
>>> -                     struct block_device *bdev)
>>> +                     struct file *bdev_file)
>>>   {
>>> -    return uds_replace_storage(layout->factory, bdev);
>>> +    return uds_replace_storage(layout->factory, bdev_file);
>>>   }
>>>   /* Obtain a dm_bufio_client for the volume region. */
>>> diff --git a/drivers/md/dm-vdo/indexer/index-layout.h 
>>> b/drivers/md/dm-vdo/indexer/index-layout.h
>>> index bd9b90c84a70..9b0c850fe9a7 100644
>>> --- a/drivers/md/dm-vdo/indexer/index-layout.h
>>> +++ b/drivers/md/dm-vdo/indexer/index-layout.h
>>> @@ -24,7 +24,7 @@ int __must_check uds_make_index_layout(struct 
>>> uds_configuration *config, bool ne
>>>   void vdo_free_index_layout(struct index_layout *layout);
>>>   int __must_check uds_replace_index_layout_storage(struct 
>>> index_layout *layout,
>>> -                          struct block_device *bdev);
>>> +                          struct file *bdev_file);
>>>   int __must_check uds_load_index_state(struct index_layout *layout,
>>>                         struct uds_index *index);
>>> diff --git a/drivers/md/dm-vdo/indexer/index-session.c 
>>> b/drivers/md/dm-vdo/indexer/index-session.c
>>> index 1949a2598656..df8f8122a22d 100644
>>> --- a/drivers/md/dm-vdo/indexer/index-session.c
>>> +++ b/drivers/md/dm-vdo/indexer/index-session.c
>>> @@ -460,15 +460,16 @@ int uds_suspend_index_session(struct 
>>> uds_index_session *session, bool save)
>>>       return uds_status_to_errno(result);
>>>   }
>>> -static int replace_device(struct uds_index_session *session, struct 
>>> block_device *bdev)
>>> +static int replace_device(struct uds_index_session *session, struct 
>>> file *bdev_file)
>>>   {
>>>       int result;
>>> -    result = uds_replace_index_storage(session->index, bdev);
>>> +    result = uds_replace_index_storage(session->index, bdev_file);
>>>       if (result != UDS_SUCCESS)
>>>           return result;
>>> -    session->parameters.bdev = bdev;
>>> +    session->parameters.bdev = file_bdev(bdev_file);
>>> +    session->parameters.bdev_file = bdev_file;
>>>       return UDS_SUCCESS;
>>>   }
>>> @@ -477,7 +478,7 @@ static int replace_device(struct 
>>> uds_index_session *session, struct block_device
>>>    * device differs from the current backing store, the index will 
>>> start using the new backing store.
>>>    */
>>>   int uds_resume_index_session(struct uds_index_session *session,
>>> -                 struct block_device *bdev)
>>> +                 struct file *bdev_file)
>>>   {
>>>       int result = UDS_SUCCESS;
>>>       bool no_work = false;
>>> @@ -502,8 +503,8 @@ int uds_resume_index_session(struct 
>>> uds_index_session *session,
>>>       if (no_work)
>>>           return result;
>>> -    if ((session->index != NULL) && (bdev != 
>>> session->parameters.bdev)) {
>>> -        result = replace_device(session, bdev);
>>> +    if ((session->index != NULL) && (bdev_file != 
>>> session->parameters.bdev_file)) {
>>> +        result = replace_device(session, bdev_file);
>>>           if (result != UDS_SUCCESS) {
>>>               mutex_lock(&session->request_mutex);
>>>               session->state &= ~IS_FLAG_WAITING;
>>> diff --git a/drivers/md/dm-vdo/indexer/index.c 
>>> b/drivers/md/dm-vdo/indexer/index.c
>>> index bd2405738c50..3600a169ca98 100644
>>> --- a/drivers/md/dm-vdo/indexer/index.c
>>> +++ b/drivers/md/dm-vdo/indexer/index.c
>>> @@ -1334,9 +1334,9 @@ int uds_save_index(struct uds_index *index)
>>>       return result;
>>>   }
>>> -int uds_replace_index_storage(struct uds_index *index, struct 
>>> block_device *bdev)
>>> +int uds_replace_index_storage(struct uds_index *index, struct file 
>>> *bdev_file)
>>>   {
>>> -    return uds_replace_volume_storage(index->volume, index->layout, 
>>> bdev);
>>> +    return uds_replace_volume_storage(index->volume, index->layout, 
>>> bdev_file);
>>>   }
>>>   /* Accessing statistics should be safe from any thread. */
>>> diff --git a/drivers/md/dm-vdo/indexer/index.h 
>>> b/drivers/md/dm-vdo/indexer/index.h
>>> index 7fbc63db4131..9428ee025cda 100644
>>> --- a/drivers/md/dm-vdo/indexer/index.h
>>> +++ b/drivers/md/dm-vdo/indexer/index.h
>>> @@ -72,7 +72,7 @@ int __must_check uds_save_index(struct uds_index 
>>> *index);
>>>   void vdo_free_index(struct uds_index *index);
>>>   int __must_check uds_replace_index_storage(struct uds_index *index,
>>> -                       struct block_device *bdev);
>>> +                       struct file *bdev_file);
>>>   void uds_get_index_stats(struct uds_index *index, struct 
>>> uds_index_stats *counters);
>>> diff --git a/drivers/md/dm-vdo/indexer/indexer.h 
>>> b/drivers/md/dm-vdo/indexer/indexer.h
>>> index a832a34d9436..5dd2c93f12c2 100644
>>> --- a/drivers/md/dm-vdo/indexer/indexer.h
>>> +++ b/drivers/md/dm-vdo/indexer/indexer.h
>>> @@ -130,6 +130,8 @@ struct uds_volume_record {
>>>   struct uds_parameters {
>>>       /* The block_device used for storage */
>>>       struct block_device *bdev;
>>> +    /* Then opened block_device */
>>> +    struct file *bdev_file;
>>>       /* The maximum allowable size of the index on storage */
>>>       size_t size;
>>>       /* The offset where the index should start */
>>> @@ -314,7 +316,7 @@ int __must_check uds_suspend_index_session(struct 
>>> uds_index_session *session, bo
>>>    * start using the new backing store instead.
>>>    */
>>>   int __must_check uds_resume_index_session(struct uds_index_session 
>>> *session,
>>> -                      struct block_device *bdev);
>>> +                      struct file *bdev_file);
>>>   /* Wait until all outstanding index operations are complete. */
>>>   int __must_check uds_flush_index_session(struct uds_index_session 
>>> *session);
>>> diff --git a/drivers/md/dm-vdo/indexer/io-factory.c 
>>> b/drivers/md/dm-vdo/indexer/io-factory.c
>>> index 61104d5ccd61..a855c3ac73bc 100644
>>> --- a/drivers/md/dm-vdo/indexer/io-factory.c
>>> +++ b/drivers/md/dm-vdo/indexer/io-factory.c
>>> @@ -23,6 +23,7 @@
>>>    */
>>>   struct io_factory {
>>>       struct block_device *bdev;
>>> +    struct file *bdev_file;
>>>       atomic_t ref_count;
>>>   };
>>> @@ -59,7 +60,7 @@ static void uds_get_io_factory(struct io_factory 
>>> *factory)
>>>       atomic_inc(&factory->ref_count);
>>>   }
>>> -int uds_make_io_factory(struct block_device *bdev, struct io_factory 
>>> **factory_ptr)
>>> +int uds_make_io_factory(struct file *bdev_file, struct io_factory 
>>> **factory_ptr)
>>>   {
>>>       int result;
>>>       struct io_factory *factory;
>>> @@ -68,16 +69,18 @@ int uds_make_io_factory(struct block_device 
>>> *bdev, struct io_factory **factory_p
>>>       if (result != VDO_SUCCESS)
>>>           return result;
>>> -    factory->bdev = bdev;
>>> +    factory->bdev = file_bdev(bdev_file);
>>> +    factory->bdev_file = bdev_file;
>>>       atomic_set_release(&factory->ref_count, 1);
>>>       *factory_ptr = factory;
>>>       return UDS_SUCCESS;
>>>   }
>>> -int uds_replace_storage(struct io_factory *factory, struct 
>>> block_device *bdev)
>>> +int uds_replace_storage(struct io_factory *factory, struct file 
>>> *bdev_file)
>>>   {
>>> -    factory->bdev = bdev;
>>> +    factory->bdev = file_bdev(bdev_file);
>>> +    factory->bdev_file = bdev_file;
>>>       return UDS_SUCCESS;
>>>   }
>>> @@ -90,7 +93,7 @@ void uds_put_io_factory(struct io_factory *factory)
>>>   size_t uds_get_writable_size(struct io_factory *factory)
>>>   {
>>> -    return i_size_read(factory->bdev->bd_inode);
>>> +    return i_size_read(file_inode(factory->bdev_file));
>>>   }
>>>   /* Create a struct dm_bufio_client for an index region starting at 
>>> offset. */
>>> diff --git a/drivers/md/dm-vdo/indexer/io-factory.h 
>>> b/drivers/md/dm-vdo/indexer/io-factory.h
>>> index 60749a9ff756..e5100ab57754 100644
>>> --- a/drivers/md/dm-vdo/indexer/io-factory.h
>>> +++ b/drivers/md/dm-vdo/indexer/io-factory.h
>>> @@ -24,11 +24,11 @@ enum {
>>>       SECTORS_PER_BLOCK = UDS_BLOCK_SIZE >> SECTOR_SHIFT,
>>>   };
>>> -int __must_check uds_make_io_factory(struct block_device *bdev,
>>> +int __must_check uds_make_io_factory(struct file *bdev_file,
>>>                        struct io_factory **factory_ptr);
>>>   int __must_check uds_replace_storage(struct io_factory *factory,
>>> -                     struct block_device *bdev);
>>> +                     struct file *bdev_file);
>>>   void uds_put_io_factory(struct io_factory *factory);
>>> diff --git a/drivers/md/dm-vdo/indexer/volume.c 
>>> b/drivers/md/dm-vdo/indexer/volume.c
>>> index 8b21ec93f3bc..a292840a83e3 100644
>>> --- a/drivers/md/dm-vdo/indexer/volume.c
>>> +++ b/drivers/md/dm-vdo/indexer/volume.c
>>> @@ -1467,12 +1467,12 @@ int uds_find_volume_chapter_boundaries(struct 
>>> volume *volume, u64 *lowest_vcn,
>>>   int __must_check uds_replace_volume_storage(struct volume *volume,
>>>                           struct index_layout *layout,
>>> -                        struct block_device *bdev)
>>> +                        struct file *bdev_file)
>>>   {
>>>       int result;
>>>       u32 i;
>>> -    result = uds_replace_index_layout_storage(layout, bdev);
>>> +    result = uds_replace_index_layout_storage(layout, bdev_file);
>>>       if (result != UDS_SUCCESS)
>>>           return result;
>>> diff --git a/drivers/md/dm-vdo/indexer/volume.h 
>>> b/drivers/md/dm-vdo/indexer/volume.h
>>> index 7fdd44464db2..5861654d837e 100644
>>> --- a/drivers/md/dm-vdo/indexer/volume.h
>>> +++ b/drivers/md/dm-vdo/indexer/volume.h
>>> @@ -131,7 +131,7 @@ void vdo_free_volume(struct volume *volume);
>>>   int __must_check uds_replace_volume_storage(struct volume *volume,
>>>                           struct index_layout *layout,
>>> -                        struct block_device *bdev);
>>> +                        struct file *bdev_file);
>>>   int __must_check uds_find_volume_chapter_boundaries(struct volume 
>>> *volume,
>>>                               u64 *lowest_vcn, u64 *highest_vcn,
>>> -- 
>>> 2.39.2
>>>
> 
> 


