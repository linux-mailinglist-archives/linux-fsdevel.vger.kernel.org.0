Return-Path: <linux-fsdevel+bounces-16611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF789FE78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 19:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E541F24D02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F26817F382;
	Wed, 10 Apr 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcPH038s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041417F375
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770014; cv=none; b=j/oEJxT7eh1Ij5eTnAQjz2UmVpN2QoWhw2jdTHFHs6O7EJ4+TEMYEAJ19nQU2lBlBBtA4KzizBWHzZxpG0Avws/0VlFXqPuW+h49aMz04QLILK9jvzDYgNyvDO+WSntlWTdP/i0dE3Zw0SBybgfrGNkke/oSBfECKlJwITZVrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770014; c=relaxed/simple;
	bh=8a3DBXg7hhfdUQ3RyfxlUX1F2I1ZewtL5n+AJ7i1NO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNxN7kNQVvaI4t9mtwCy0xPtgOnGWsw+aHLrdfruZCt5/y2VzKt9Y78dMTBsb1ajw37wKHi9GEDBFeF433GqrUOw5GucW0gQouL79YUVDsLWmZcH+SFXCiDSLYcy+1ixLttlUYT3slKbP/ExTyoxGZN9QfMlBWWmVJVA/HGWFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcPH038s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712770011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvrK1xeD8grMUj7IGa5lN1CzcJxYgQcYtrUkQ3eifvk=;
	b=PcPH038s9vB+L+RZK38A8YoN0FTD8v0m4HST+0Qv0/loFge9c4WfVgB2OAXDszmWuROcu+
	rbUZ8SzVjZQP3eJLL6S7Gj8tyVI5CzGt/VmbX8+F5ahhFbRjmWzaj0aRRez9Koyd85k+ko
	kYkNcTKnWJshvItzezmyVIrG6jvJWeo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-3kWFnip_Pr2em1p1NlKgzg-1; Wed, 10 Apr 2024 13:26:49 -0400
X-MC-Unique: 3kWFnip_Pr2em1p1NlKgzg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69b197557b0so42290956d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 10:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712770009; x=1713374809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvrK1xeD8grMUj7IGa5lN1CzcJxYgQcYtrUkQ3eifvk=;
        b=xMiAbw9STEAy847x87857sY8MIZ/5x7cSyMT+TJ7fMADaZf3lnUOSoerWnu58z4Wut
         Ll0p03k38cUeXEaNsCq1+l1DIoiTj5MyYGq4mRm3ixfV56BKDmEi7l24zHJnoSLt+Uwd
         7ZaeunYF1dMrYRAkgW1Qpde75BIESjuab/LO1YxNPSkoSuMylWhYHwGKYV/Muw9NaEiq
         uODqRkzRV6qbNI2hjroErd2LES3+sGYJzTWA6hOxYlN30vx/p3hucsfP8TXOszrp5r04
         OjU9co7cbJzb21FzWwjd1I577UhQe8upNH9bJ/KwHsJYkvZ4bhvT12bbG/pfKQKlpMtq
         zHhA==
X-Gm-Message-State: AOJu0YwOnRpMbPjd27YT1pXcbUA2Y+kuXSlnKQOI2vel0W1/drgV0ou7
	v3qr3WArU7u8zSJJKTLTukjgKzaYveDNNcpkE7azlqK2QGHT6nlAniWllsrw16NL2xCUDj3ujfD
	9xSnJeEYw9t2CGnw9bkhIuJzS1iPnUI2HT6Njy6qeANrlPE368R2uJM9uRChpizk=
X-Received: by 2002:a05:6214:d6a:b0:69b:243a:46c with SMTP id 10-20020a0562140d6a00b0069b243a046cmr3689301qvs.34.1712770009393;
        Wed, 10 Apr 2024 10:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENlG1Ttc7CoucrebyF8rwj5w6PnqB4FtRGniqXuoTW722Dlp/ItwidpVu+OB/JrzsrPrI9qw==
X-Received: by 2002:a05:6214:d6a:b0:69b:243a:46c with SMTP id 10-20020a0562140d6a00b0069b243a046cmr3689277qvs.34.1712770008984;
        Wed, 10 Apr 2024 10:26:48 -0700 (PDT)
Received: from [192.168.1.165] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id l9-20020a0cc209000000b0069941839737sm5035258qvh.3.2024.04.10.10.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:26:48 -0700 (PDT)
Message-ID: <a8493592-2a9b-ac14-f914-c747aa4455f3@redhat.com>
Date: Wed, 10 Apr 2024 13:26:47 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH vfs.all 19/26] dm-vdo: convert to use bdev_file
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
 brauner@kernel.org, viro@zeniv.linux.org.uk, axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
 dm-devel@lists.linux.dev
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-20-yukuai1@huaweicloud.com>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20240406090930.2252838-20-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+dm-devel

On 4/6/24 05:09, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that dm upper layer already statsh the file of opened device in

                                  ^ stashes

> 'dm_dev->bdev_file', it's ok to get inode from the file.
> There are no functional changes, prepare to remove 'bd_inode' from
> block_device.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/dm-vdo/dedupe.c                |  7 ++++---
>   drivers/md/dm-vdo/dm-vdo-target.c         |  9 +++++++--
>   drivers/md/dm-vdo/indexer/config.c        |  2 +-
>   drivers/md/dm-vdo/indexer/config.h        |  4 ++--
>   drivers/md/dm-vdo/indexer/index-layout.c  |  6 +++---
>   drivers/md/dm-vdo/indexer/index-layout.h  |  2 +-
>   drivers/md/dm-vdo/indexer/index-session.c | 18 ++++++++++--------
>   drivers/md/dm-vdo/indexer/index.c         |  4 ++--
>   drivers/md/dm-vdo/indexer/index.h         |  2 +-
>   drivers/md/dm-vdo/indexer/indexer.h       |  6 +++---
>   drivers/md/dm-vdo/indexer/io-factory.c    | 17 +++++++++--------
>   drivers/md/dm-vdo/indexer/io-factory.h    |  4 ++--
>   drivers/md/dm-vdo/indexer/volume.c        |  4 ++--
>   drivers/md/dm-vdo/indexer/volume.h        |  2 +-
>   drivers/md/dm-vdo/vdo.c                   |  2 +-
>   15 files changed, 49 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
> index 117266e1b3ae..0e311989247e 100644
> --- a/drivers/md/dm-vdo/dedupe.c
> +++ b/drivers/md/dm-vdo/dedupe.c
> @@ -2191,7 +2191,7 @@ static int initialize_index(struct vdo *vdo, struct hash_zones *zones)
>   	uds_offset = ((vdo_get_index_region_start(geometry) -
>   		       geometry.bio_offset) * VDO_BLOCK_SIZE);
>   	zones->parameters = (struct uds_parameters) {
> -		.bdev = vdo->device_config->owned_device->bdev,
> +		.bdev_file = vdo->device_config->owned_device->bdev_file,
>   		.offset = uds_offset,
>   		.size = (vdo_get_index_region_size(geometry) * VDO_BLOCK_SIZE),
>   		.memory_size = geometry.index_config.mem,
> @@ -2582,8 +2582,9 @@ static void resume_index(void *context, struct vdo_completion *parent)
>   	struct device_config *config = parent->vdo->device_config;
>   	int result;
>   
> -	zones->parameters.bdev = config->owned_device->bdev;
> -	result = uds_resume_index_session(zones->index_session, zones->parameters.bdev);
> +	zones->parameters.bdev_file = config->owned_device->bdev_file;
> +	result = uds_resume_index_session(zones->index_session,
> +					  zones->parameters.bdev_file);
>   	if (result != UDS_SUCCESS)
>   		vdo_log_error_strerror(result, "Error resuming dedupe index");
>   
> diff --git a/drivers/md/dm-vdo/dm-vdo-target.c b/drivers/md/dm-vdo/dm-vdo-target.c
> index 5a4b0a927f56..79e861c2887c 100644
> --- a/drivers/md/dm-vdo/dm-vdo-target.c
> +++ b/drivers/md/dm-vdo/dm-vdo-target.c
> @@ -696,6 +696,11 @@ static void handle_parse_error(struct device_config *config, char **error_ptr,
>   	*error_ptr = error_str;
>   }
>   
> +static loff_t vdo_get_device_size(const struct device_config *config)
> +{
> +	return i_size_read(file_inode(config->owned_device->bdev_file));
> +}
> +
>   /**
>    * parse_device_config() - Convert the dmsetup table into a struct device_config.
>    * @argc: The number of table values.
> @@ -878,7 +883,7 @@ static int parse_device_config(int argc, char **argv, struct dm_target *ti,
>   	}
>   
>   	if (config->version == 0) {
> -		u64 device_size = i_size_read(config->owned_device->bdev->bd_inode);
> +		u64 device_size = vdo_get_device_size(config);
>   
>   		config->physical_blocks = device_size / VDO_BLOCK_SIZE;
>   	}
> @@ -1011,7 +1016,7 @@ static void vdo_status(struct dm_target *ti, status_type_t status_type,
>   
>   static block_count_t __must_check get_underlying_device_block_count(const struct vdo *vdo)
>   {
> -	return i_size_read(vdo_get_backing_device(vdo)->bd_inode) / VDO_BLOCK_SIZE;
> +	return vdo_get_device_size(vdo->device_config) / VDO_BLOCK_SIZE;
>   }
>   
>   static int __must_check process_vdo_message_locked(struct vdo *vdo, unsigned int argc,
> diff --git a/drivers/md/dm-vdo/indexer/config.c b/drivers/md/dm-vdo/indexer/config.c
> index 5532371b952f..dcf0742a6145 100644
> --- a/drivers/md/dm-vdo/indexer/config.c
> +++ b/drivers/md/dm-vdo/indexer/config.c
> @@ -344,7 +344,7 @@ int uds_make_configuration(const struct uds_parameters *params,
>   	config->volume_index_mean_delta = DEFAULT_VOLUME_INDEX_MEAN_DELTA;
>   	config->sparse_sample_rate = (params->sparse ? DEFAULT_SPARSE_SAMPLE_RATE : 0);
>   	config->nonce = params->nonce;
> -	config->bdev = params->bdev;
> +	config->bdev_file = params->bdev_file;
>   	config->offset = params->offset;
>   	config->size = params->size;
>   
> diff --git a/drivers/md/dm-vdo/indexer/config.h b/drivers/md/dm-vdo/indexer/config.h
> index 08507dc2f7a1..8ba0cf72dec9 100644
> --- a/drivers/md/dm-vdo/indexer/config.h
> +++ b/drivers/md/dm-vdo/indexer/config.h
> @@ -25,8 +25,8 @@ enum {
>   
>   /* A set of configuration parameters for the indexer. */
>   struct uds_configuration {
> -	/* Storage device for the index */
> -	struct block_device *bdev;
> +	/* File of opened storage device for the index */
> +	struct file *bdev_file;
>   
>   	/* The maximum allowable size of the index */
>   	size_t size;
> diff --git a/drivers/md/dm-vdo/indexer/index-layout.c b/drivers/md/dm-vdo/indexer/index-layout.c
> index 627adc24af3b..32eee76bc246 100644
> --- a/drivers/md/dm-vdo/indexer/index-layout.c
> +++ b/drivers/md/dm-vdo/indexer/index-layout.c
> @@ -1668,7 +1668,7 @@ static int create_layout_factory(struct index_layout *layout,
>   	size_t writable_size;
>   	struct io_factory *factory = NULL;
>   
> -	result = uds_make_io_factory(config->bdev, &factory);
> +	result = uds_make_io_factory(config->bdev_file, &factory);
>   	if (result != UDS_SUCCESS)
>   		return result;
>   
> @@ -1741,9 +1741,9 @@ void uds_free_index_layout(struct index_layout *layout)
>   }
>   
>   int uds_replace_index_layout_storage(struct index_layout *layout,
> -				     struct block_device *bdev)
> +				     struct file *bdev_file)
>   {
> -	return uds_replace_storage(layout->factory, bdev);
> +	return uds_replace_storage(layout->factory, bdev_file);
>   }
>   
>   /* Obtain a dm_bufio_client for the volume region. */
> diff --git a/drivers/md/dm-vdo/indexer/index-layout.h b/drivers/md/dm-vdo/indexer/index-layout.h
> index e9ac6f4302d6..28f9be577631 100644
> --- a/drivers/md/dm-vdo/indexer/index-layout.h
> +++ b/drivers/md/dm-vdo/indexer/index-layout.h
> @@ -24,7 +24,7 @@ int __must_check uds_make_index_layout(struct uds_configuration *config, bool ne
>   void uds_free_index_layout(struct index_layout *layout);
>   
>   int __must_check uds_replace_index_layout_storage(struct index_layout *layout,
> -						  struct block_device *bdev);
> +						  struct file *bdev_file);
>   
>   int __must_check uds_load_index_state(struct index_layout *layout,
>   				      struct uds_index *index);
> diff --git a/drivers/md/dm-vdo/indexer/index-session.c b/drivers/md/dm-vdo/indexer/index-session.c
> index aee0914d604a..914abf5e006b 100644
> --- a/drivers/md/dm-vdo/indexer/index-session.c
> +++ b/drivers/md/dm-vdo/indexer/index-session.c
> @@ -335,7 +335,7 @@ int uds_open_index(enum uds_open_index_type open_type,
>   		vdo_log_error("missing required parameters");
>   		return -EINVAL;
>   	}
> -	if (parameters->bdev == NULL) {
> +	if (parameters->bdev_file == NULL) {
>   		vdo_log_error("missing required block device");
>   		return -EINVAL;
>   	}
> @@ -349,7 +349,7 @@ int uds_open_index(enum uds_open_index_type open_type,
>   		return uds_status_to_errno(result);
>   
>   	session->parameters = *parameters;
> -	format_dev_t(name, parameters->bdev->bd_dev);
> +	format_dev_t(name, file_bdev(parameters->bdev_file)->bd_dev);
>   	vdo_log_info("%s: %s", get_open_type_string(open_type), name);
>   
>   	result = initialize_index_session(session, open_type);
> @@ -460,15 +460,16 @@ int uds_suspend_index_session(struct uds_index_session *session, bool save)
>   	return uds_status_to_errno(result);
>   }
>   
> -static int replace_device(struct uds_index_session *session, struct block_device *bdev)
> +static int replace_device(struct uds_index_session *session,
> +			  struct file *bdev_file)
>   {
>   	int result;
>   
> -	result = uds_replace_index_storage(session->index, bdev);
> +	result = uds_replace_index_storage(session->index, bdev_file);
>   	if (result != UDS_SUCCESS)
>   		return result;
>   
> -	session->parameters.bdev = bdev;
> +	session->parameters.bdev_file = bdev_file;
>   	return UDS_SUCCESS;
>   }
>   
> @@ -477,7 +478,7 @@ static int replace_device(struct uds_index_session *session, struct block_device
>    * device differs from the current backing store, the index will start using the new backing store.
>    */
>   int uds_resume_index_session(struct uds_index_session *session,
> -			     struct block_device *bdev)
> +			     struct file *bdev_file)
>   {
>   	int result = UDS_SUCCESS;
>   	bool no_work = false;
> @@ -502,8 +503,9 @@ int uds_resume_index_session(struct uds_index_session *session,
>   	if (no_work)
>   		return result;
>   
> -	if ((session->index != NULL) && (bdev != session->parameters.bdev)) {
> -		result = replace_device(session, bdev);
> +	if (session->index != NULL &&
> +	    bdev_file != session->parameters.bdev_file) {
> +		result = replace_device(session, bdev_file);
>   		if (result != UDS_SUCCESS) {
>   			mutex_lock(&session->request_mutex);
>   			session->state &= ~IS_FLAG_WAITING;
> diff --git a/drivers/md/dm-vdo/indexer/index.c b/drivers/md/dm-vdo/indexer/index.c
> index 1ba767144426..48b16275a067 100644
> --- a/drivers/md/dm-vdo/indexer/index.c
> +++ b/drivers/md/dm-vdo/indexer/index.c
> @@ -1336,9 +1336,9 @@ int uds_save_index(struct uds_index *index)
>   	return result;
>   }
>   
> -int uds_replace_index_storage(struct uds_index *index, struct block_device *bdev)
> +int uds_replace_index_storage(struct uds_index *index, struct file *bdev_file)
>   {
> -	return uds_replace_volume_storage(index->volume, index->layout, bdev);
> +	return uds_replace_volume_storage(index->volume, index->layout, bdev_file);
>   }
>   
>   /* Accessing statistics should be safe from any thread. */
> diff --git a/drivers/md/dm-vdo/indexer/index.h b/drivers/md/dm-vdo/indexer/index.h
> index edabb239548e..6e2e203f43f7 100644
> --- a/drivers/md/dm-vdo/indexer/index.h
> +++ b/drivers/md/dm-vdo/indexer/index.h
> @@ -72,7 +72,7 @@ int __must_check uds_save_index(struct uds_index *index);
>   void uds_free_index(struct uds_index *index);
>   
>   int __must_check uds_replace_index_storage(struct uds_index *index,
> -					   struct block_device *bdev);
> +					   struct file *bdev_file);
>   
>   void uds_get_index_stats(struct uds_index *index, struct uds_index_stats *counters);
>   
> diff --git a/drivers/md/dm-vdo/indexer/indexer.h b/drivers/md/dm-vdo/indexer/indexer.h
> index 3744aaf625b0..246ff2810e01 100644
> --- a/drivers/md/dm-vdo/indexer/indexer.h
> +++ b/drivers/md/dm-vdo/indexer/indexer.h
> @@ -128,8 +128,8 @@ struct uds_volume_record {
>   };
>   
>   struct uds_parameters {
> -	/* The block_device used for storage */
> -	struct block_device *bdev;
> +	/* The bdev_file used for storage */
> +	struct file *bdev_file;
>   	/* The maximum allowable size of the index on storage */
>   	size_t size;
>   	/* The offset where the index should start */
> @@ -314,7 +314,7 @@ int __must_check uds_suspend_index_session(struct uds_index_session *session, bo
>    * start using the new backing store instead.
>    */
>   int __must_check uds_resume_index_session(struct uds_index_session *session,
> -					  struct block_device *bdev);
> +					  struct file *bdev_file);
>   
>   /* Wait until all outstanding index operations are complete. */
>   int __must_check uds_flush_index_session(struct uds_index_session *session);
> diff --git a/drivers/md/dm-vdo/indexer/io-factory.c b/drivers/md/dm-vdo/indexer/io-factory.c
> index 515765d35794..f4dedb7b7f40 100644
> --- a/drivers/md/dm-vdo/indexer/io-factory.c
> +++ b/drivers/md/dm-vdo/indexer/io-factory.c
> @@ -22,7 +22,7 @@
>    * make helper structures that can be used to access sections of the index.
>    */
>   struct io_factory {
> -	struct block_device *bdev;
> +	struct file *bdev_file;
>   	atomic_t ref_count;
>   };
>   
> @@ -59,7 +59,7 @@ static void uds_get_io_factory(struct io_factory *factory)
>   	atomic_inc(&factory->ref_count);
>   }
>   
> -int uds_make_io_factory(struct block_device *bdev, struct io_factory **factory_ptr)
> +int uds_make_io_factory(struct file *bdev_file, struct io_factory **factory_ptr)
>   {
>   	int result;
>   	struct io_factory *factory;
> @@ -68,16 +68,16 @@ int uds_make_io_factory(struct block_device *bdev, struct io_factory **factory_p
>   	if (result != VDO_SUCCESS)
>   		return result;
>   
> -	factory->bdev = bdev;
> +	factory->bdev_file = bdev_file;
>   	atomic_set_release(&factory->ref_count, 1);
>   
>   	*factory_ptr = factory;
>   	return UDS_SUCCESS;
>   }
>   
> -int uds_replace_storage(struct io_factory *factory, struct block_device *bdev)
> +int uds_replace_storage(struct io_factory *factory, struct file *bdev_file)
>   {
> -	factory->bdev = bdev;
> +	factory->bdev_file = bdev_file;
>   	return UDS_SUCCESS;
>   }
>   
> @@ -90,7 +90,7 @@ void uds_put_io_factory(struct io_factory *factory)
>   
>   size_t uds_get_writable_size(struct io_factory *factory)
>   {
> -	return i_size_read(factory->bdev->bd_inode);
> +	return i_size_read(file_inode(factory->bdev_file));
>   }
>   
>   /* Create a struct dm_bufio_client for an index region starting at offset. */
> @@ -99,8 +99,9 @@ int uds_make_bufio(struct io_factory *factory, off_t block_offset, size_t block_
>   {
>   	struct dm_bufio_client *client;
>   
> -	client = dm_bufio_client_create(factory->bdev, block_size, reserved_buffers, 0,
> -					NULL, NULL, 0);
> +	client = dm_bufio_client_create(file_bdev(factory->bdev_file),
> +					block_size, reserved_buffers,
> +					0, NULL, NULL, 0);
>   	if (IS_ERR(client))
>   		return -PTR_ERR(client);
>   
> diff --git a/drivers/md/dm-vdo/indexer/io-factory.h b/drivers/md/dm-vdo/indexer/io-factory.h
> index 7fb5a0616a79..a3ca84d62f2d 100644
> --- a/drivers/md/dm-vdo/indexer/io-factory.h
> +++ b/drivers/md/dm-vdo/indexer/io-factory.h
> @@ -24,11 +24,11 @@ enum {
>   	SECTORS_PER_BLOCK = UDS_BLOCK_SIZE >> SECTOR_SHIFT,
>   };
>   
> -int __must_check uds_make_io_factory(struct block_device *bdev,
> +int __must_check uds_make_io_factory(struct file *bdev_file,
>   				     struct io_factory **factory_ptr);
>   
>   int __must_check uds_replace_storage(struct io_factory *factory,
> -				     struct block_device *bdev);
> +				     struct file *bdev_file);
>   
>   void uds_put_io_factory(struct io_factory *factory);
>   
> diff --git a/drivers/md/dm-vdo/indexer/volume.c b/drivers/md/dm-vdo/indexer/volume.c
> index 655453bb276b..edbe46252657 100644
> --- a/drivers/md/dm-vdo/indexer/volume.c
> +++ b/drivers/md/dm-vdo/indexer/volume.c
> @@ -1465,12 +1465,12 @@ int uds_find_volume_chapter_boundaries(struct volume *volume, u64 *lowest_vcn,
>   
>   int __must_check uds_replace_volume_storage(struct volume *volume,
>   					    struct index_layout *layout,
> -					    struct block_device *bdev)
> +					    struct file *bdev_file)
>   {
>   	int result;
>   	u32 i;
>   
> -	result = uds_replace_index_layout_storage(layout, bdev);
> +	result = uds_replace_index_layout_storage(layout, bdev_file);
>   	if (result != UDS_SUCCESS)
>   		return result;
>   
> diff --git a/drivers/md/dm-vdo/indexer/volume.h b/drivers/md/dm-vdo/indexer/volume.h
> index 8679a5e55347..1dc3561b8b43 100644
> --- a/drivers/md/dm-vdo/indexer/volume.h
> +++ b/drivers/md/dm-vdo/indexer/volume.h
> @@ -130,7 +130,7 @@ void uds_free_volume(struct volume *volume);
>   
>   int __must_check uds_replace_volume_storage(struct volume *volume,
>   					    struct index_layout *layout,
> -					    struct block_device *bdev);
> +					    struct file *bdev_file);
>   
>   int __must_check uds_find_volume_chapter_boundaries(struct volume *volume,
>   						    u64 *lowest_vcn, u64 *highest_vcn,
> diff --git a/drivers/md/dm-vdo/vdo.c b/drivers/md/dm-vdo/vdo.c
> index fff847767755..eca9f8b51535 100644
> --- a/drivers/md/dm-vdo/vdo.c
> +++ b/drivers/md/dm-vdo/vdo.c
> @@ -809,7 +809,7 @@ void vdo_load_super_block(struct vdo *vdo, struct vdo_completion *parent)
>    */
>   struct block_device *vdo_get_backing_device(const struct vdo *vdo)
>   {
> -	return vdo->device_config->owned_device->bdev;
> +	return file_bdev(vdo->device_config->owned_device->bdev_file);
>   }
>   
>   /**


