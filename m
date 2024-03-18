Return-Path: <linux-fsdevel+bounces-14722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF17087E592
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 10:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85312281F90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7D62C198;
	Mon, 18 Mar 2024 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Maku2pZN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QwfRJ4Ea";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Maku2pZN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QwfRJ4Ea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC928E17;
	Mon, 18 Mar 2024 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753603; cv=none; b=CCGzM6kwEX1DT3TMXlYIy1Fs9ttrYmLYfMRTr3sIE9hK6WfA3/VwtxHOsjFgH+QoyNfwHwWYGKlvQtyqV28NNkurx3hqfooX76G4G9CCxYZR7Du9wqcBtuN3QZVAn+XCqnd2mMsdWOYBxeE74lin37mlcjHEcS/eJJjNso6WskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753603; c=relaxed/simple;
	bh=otWs4KfvLFeqD4yhHEaQrCRKz4G0u00jN7GCpBVq2Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq1gieOdC5lLCAFPJxqKF9Js2cYRgVKegfUJPspALWOhPTSfXD7spv3iR267xLHIun5KGcQTgH5hjmGxK7NGd8Liul7hvKx2alOHPK9ReUiURneMRiPMYjogDsBaNw8cmlRZMT6RznHsu343Q0h5CzmaXuJaQ5PMMrBINXDDhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Maku2pZN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QwfRJ4Ea; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Maku2pZN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QwfRJ4Ea; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01DC45C2FF;
	Mon, 18 Mar 2024 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710753599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MCLBpVrAkZcuCusbDFgHDGAADGt2TY21c+ObJQ0RmGw=;
	b=Maku2pZNuhrAUkSUB1fGv88GAKGai5DU4bMUavMyoOf6N8A2MSs340O7+0t2e+oEcXayiQ
	/lGIw9TCh/Y0goldLtKUpIC3/0aVOYx+YmmNSldwu0Pb3yanfnFgF7QCtbrCIOyTNNBij3
	e4t0ki5GWORBNhpq25LtcCn4KLwRDcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710753599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MCLBpVrAkZcuCusbDFgHDGAADGt2TY21c+ObJQ0RmGw=;
	b=QwfRJ4EaIVHvcGJOPyW6LigL3ad7jUbvc4IPWTOIQNLIw1nVQ9V/g6rHrzmNQTYXnHI7UK
	dVNKlounWZJ0yiBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710753599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MCLBpVrAkZcuCusbDFgHDGAADGt2TY21c+ObJQ0RmGw=;
	b=Maku2pZNuhrAUkSUB1fGv88GAKGai5DU4bMUavMyoOf6N8A2MSs340O7+0t2e+oEcXayiQ
	/lGIw9TCh/Y0goldLtKUpIC3/0aVOYx+YmmNSldwu0Pb3yanfnFgF7QCtbrCIOyTNNBij3
	e4t0ki5GWORBNhpq25LtcCn4KLwRDcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710753599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MCLBpVrAkZcuCusbDFgHDGAADGt2TY21c+ObJQ0RmGw=;
	b=QwfRJ4EaIVHvcGJOPyW6LigL3ad7jUbvc4IPWTOIQNLIw1nVQ9V/g6rHrzmNQTYXnHI7UK
	dVNKlounWZJ0yiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E91D71349D;
	Mon, 18 Mar 2024 09:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bN7lOD4H+GX5SQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Mar 2024 09:19:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9E6DFA07D9; Mon, 18 Mar 2024 10:19:58 +0100 (CET)
Date: Mon, 18 Mar 2024 10:19:58 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 17/19] dm-vdo: prevent direct access of
 bd_inode
Message-ID: <20240318091958.u3yqy2ab7rbqbroq@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-18-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-18-yukuai1@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 22-02-24 20:45:53, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that dm upper layer already statsh the file of opened device in
> 'dm_dev->bdev_file', it's ok to get inode from the file.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Given there are like three real uses of ->bdev in dm-vdo, I suspect it
might be better to just replace bdev with bdev_file in struct io_factory
and in struct uds_parameters.

								Honza

> ---
>  drivers/md/dm-vdo/dedupe.c                |  3 ++-
>  drivers/md/dm-vdo/dm-vdo-target.c         |  5 +++--
>  drivers/md/dm-vdo/indexer/config.c        |  1 +
>  drivers/md/dm-vdo/indexer/config.h        |  3 +++
>  drivers/md/dm-vdo/indexer/index-layout.c  |  6 +++---
>  drivers/md/dm-vdo/indexer/index-layout.h  |  2 +-
>  drivers/md/dm-vdo/indexer/index-session.c | 13 +++++++------
>  drivers/md/dm-vdo/indexer/index.c         |  4 ++--
>  drivers/md/dm-vdo/indexer/index.h         |  2 +-
>  drivers/md/dm-vdo/indexer/indexer.h       |  4 +++-
>  drivers/md/dm-vdo/indexer/io-factory.c    | 13 ++++++++-----
>  drivers/md/dm-vdo/indexer/io-factory.h    |  4 ++--
>  drivers/md/dm-vdo/indexer/volume.c        |  4 ++--
>  drivers/md/dm-vdo/indexer/volume.h        |  2 +-
>  14 files changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
> index a9b189395592..532294a15174 100644
> --- a/drivers/md/dm-vdo/dedupe.c
> +++ b/drivers/md/dm-vdo/dedupe.c
> @@ -2592,7 +2592,8 @@ static void resume_index(void *context, struct vdo_completion *parent)
>  	int result;
>  
>  	zones->parameters.bdev = config->owned_device->bdev;
> -	result = uds_resume_index_session(zones->index_session, zones->parameters.bdev);
> +	zones->parameters.bdev_file = config->owned_device->bdev_file;
> +	result = uds_resume_index_session(zones->index_session, zones->parameters.bdev_file);
>  	if (result != UDS_SUCCESS)
>  		vdo_log_error_strerror(result, "Error resuming dedupe index");
>  
> diff --git a/drivers/md/dm-vdo/dm-vdo-target.c b/drivers/md/dm-vdo/dm-vdo-target.c
> index 89d00be9f075..b2d7f68e70be 100644
> --- a/drivers/md/dm-vdo/dm-vdo-target.c
> +++ b/drivers/md/dm-vdo/dm-vdo-target.c
> @@ -883,7 +883,7 @@ static int parse_device_config(int argc, char **argv, struct dm_target *ti,
>  	}
>  
>  	if (config->version == 0) {
> -		u64 device_size = i_size_read(config->owned_device->bdev->bd_inode);
> +		u64 device_size = i_size_read(file_inode(config->owned_device->bdev_file));
>  
>  		config->physical_blocks = device_size / VDO_BLOCK_SIZE;
>  	}
> @@ -1018,7 +1018,8 @@ static void vdo_status(struct dm_target *ti, status_type_t status_type,
>  
>  static block_count_t __must_check get_underlying_device_block_count(const struct vdo *vdo)
>  {
> -	return i_size_read(vdo_get_backing_device(vdo)->bd_inode) / VDO_BLOCK_SIZE;
> +	return i_size_read(file_inode(vdo->device_config->owned_device->bdev_file)) /
> +		VDO_BLOCK_SIZE;
>  }
>  
>  static int __must_check process_vdo_message_locked(struct vdo *vdo, unsigned int argc,
> diff --git a/drivers/md/dm-vdo/indexer/config.c b/drivers/md/dm-vdo/indexer/config.c
> index 260993ce1944..f1f66e232b54 100644
> --- a/drivers/md/dm-vdo/indexer/config.c
> +++ b/drivers/md/dm-vdo/indexer/config.c
> @@ -347,6 +347,7 @@ int uds_make_configuration(const struct uds_parameters *params,
>  	config->sparse_sample_rate = (params->sparse ? DEFAULT_SPARSE_SAMPLE_RATE : 0);
>  	config->nonce = params->nonce;
>  	config->bdev = params->bdev;
> +	config->bdev_file = params->bdev_file;
>  	config->offset = params->offset;
>  	config->size = params->size;
>  
> diff --git a/drivers/md/dm-vdo/indexer/config.h b/drivers/md/dm-vdo/indexer/config.h
> index fe7958263ed6..688f7450183e 100644
> --- a/drivers/md/dm-vdo/indexer/config.h
> +++ b/drivers/md/dm-vdo/indexer/config.h
> @@ -28,6 +28,9 @@ struct uds_configuration {
>  	/* Storage device for the index */
>  	struct block_device *bdev;
>  
> +	/* Opened device fot the index */
> +	struct file *bdev_file;
> +
>  	/* The maximum allowable size of the index */
>  	size_t size;
>  
> diff --git a/drivers/md/dm-vdo/indexer/index-layout.c b/drivers/md/dm-vdo/indexer/index-layout.c
> index 1453fddaa656..6dd80a432fe5 100644
> --- a/drivers/md/dm-vdo/indexer/index-layout.c
> +++ b/drivers/md/dm-vdo/indexer/index-layout.c
> @@ -1672,7 +1672,7 @@ static int create_layout_factory(struct index_layout *layout,
>  	size_t writable_size;
>  	struct io_factory *factory = NULL;
>  
> -	result = uds_make_io_factory(config->bdev, &factory);
> +	result = uds_make_io_factory(config->bdev_file, &factory);
>  	if (result != UDS_SUCCESS)
>  		return result;
>  
> @@ -1745,9 +1745,9 @@ void vdo_free_index_layout(struct index_layout *layout)
>  }
>  
>  int uds_replace_index_layout_storage(struct index_layout *layout,
> -				     struct block_device *bdev)
> +				     struct file *bdev_file)
>  {
> -	return uds_replace_storage(layout->factory, bdev);
> +	return uds_replace_storage(layout->factory, bdev_file);
>  }
>  
>  /* Obtain a dm_bufio_client for the volume region. */
> diff --git a/drivers/md/dm-vdo/indexer/index-layout.h b/drivers/md/dm-vdo/indexer/index-layout.h
> index bd9b90c84a70..9b0c850fe9a7 100644
> --- a/drivers/md/dm-vdo/indexer/index-layout.h
> +++ b/drivers/md/dm-vdo/indexer/index-layout.h
> @@ -24,7 +24,7 @@ int __must_check uds_make_index_layout(struct uds_configuration *config, bool ne
>  void vdo_free_index_layout(struct index_layout *layout);
>  
>  int __must_check uds_replace_index_layout_storage(struct index_layout *layout,
> -						  struct block_device *bdev);
> +						  struct file *bdev_file);
>  
>  int __must_check uds_load_index_state(struct index_layout *layout,
>  				      struct uds_index *index);
> diff --git a/drivers/md/dm-vdo/indexer/index-session.c b/drivers/md/dm-vdo/indexer/index-session.c
> index 1949a2598656..df8f8122a22d 100644
> --- a/drivers/md/dm-vdo/indexer/index-session.c
> +++ b/drivers/md/dm-vdo/indexer/index-session.c
> @@ -460,15 +460,16 @@ int uds_suspend_index_session(struct uds_index_session *session, bool save)
>  	return uds_status_to_errno(result);
>  }
>  
> -static int replace_device(struct uds_index_session *session, struct block_device *bdev)
> +static int replace_device(struct uds_index_session *session, struct file *bdev_file)
>  {
>  	int result;
>  
> -	result = uds_replace_index_storage(session->index, bdev);
> +	result = uds_replace_index_storage(session->index, bdev_file);
>  	if (result != UDS_SUCCESS)
>  		return result;
>  
> -	session->parameters.bdev = bdev;
> +	session->parameters.bdev = file_bdev(bdev_file);
> +	session->parameters.bdev_file = bdev_file;
>  	return UDS_SUCCESS;
>  }
>  
> @@ -477,7 +478,7 @@ static int replace_device(struct uds_index_session *session, struct block_device
>   * device differs from the current backing store, the index will start using the new backing store.
>   */
>  int uds_resume_index_session(struct uds_index_session *session,
> -			     struct block_device *bdev)
> +			     struct file *bdev_file)
>  {
>  	int result = UDS_SUCCESS;
>  	bool no_work = false;
> @@ -502,8 +503,8 @@ int uds_resume_index_session(struct uds_index_session *session,
>  	if (no_work)
>  		return result;
>  
> -	if ((session->index != NULL) && (bdev != session->parameters.bdev)) {
> -		result = replace_device(session, bdev);
> +	if ((session->index != NULL) && (bdev_file != session->parameters.bdev_file)) {
> +		result = replace_device(session, bdev_file);
>  		if (result != UDS_SUCCESS) {
>  			mutex_lock(&session->request_mutex);
>  			session->state &= ~IS_FLAG_WAITING;
> diff --git a/drivers/md/dm-vdo/indexer/index.c b/drivers/md/dm-vdo/indexer/index.c
> index bd2405738c50..3600a169ca98 100644
> --- a/drivers/md/dm-vdo/indexer/index.c
> +++ b/drivers/md/dm-vdo/indexer/index.c
> @@ -1334,9 +1334,9 @@ int uds_save_index(struct uds_index *index)
>  	return result;
>  }
>  
> -int uds_replace_index_storage(struct uds_index *index, struct block_device *bdev)
> +int uds_replace_index_storage(struct uds_index *index, struct file *bdev_file)
>  {
> -	return uds_replace_volume_storage(index->volume, index->layout, bdev);
> +	return uds_replace_volume_storage(index->volume, index->layout, bdev_file);
>  }
>  
>  /* Accessing statistics should be safe from any thread. */
> diff --git a/drivers/md/dm-vdo/indexer/index.h b/drivers/md/dm-vdo/indexer/index.h
> index 7fbc63db4131..9428ee025cda 100644
> --- a/drivers/md/dm-vdo/indexer/index.h
> +++ b/drivers/md/dm-vdo/indexer/index.h
> @@ -72,7 +72,7 @@ int __must_check uds_save_index(struct uds_index *index);
>  void vdo_free_index(struct uds_index *index);
>  
>  int __must_check uds_replace_index_storage(struct uds_index *index,
> -					   struct block_device *bdev);
> +					   struct file *bdev_file);
>  
>  void uds_get_index_stats(struct uds_index *index, struct uds_index_stats *counters);
>  
> diff --git a/drivers/md/dm-vdo/indexer/indexer.h b/drivers/md/dm-vdo/indexer/indexer.h
> index a832a34d9436..5dd2c93f12c2 100644
> --- a/drivers/md/dm-vdo/indexer/indexer.h
> +++ b/drivers/md/dm-vdo/indexer/indexer.h
> @@ -130,6 +130,8 @@ struct uds_volume_record {
>  struct uds_parameters {
>  	/* The block_device used for storage */
>  	struct block_device *bdev;
> +	/* Then opened block_device */
> +	struct file *bdev_file;
>  	/* The maximum allowable size of the index on storage */
>  	size_t size;
>  	/* The offset where the index should start */
> @@ -314,7 +316,7 @@ int __must_check uds_suspend_index_session(struct uds_index_session *session, bo
>   * start using the new backing store instead.
>   */
>  int __must_check uds_resume_index_session(struct uds_index_session *session,
> -					  struct block_device *bdev);
> +					  struct file *bdev_file);
>  
>  /* Wait until all outstanding index operations are complete. */
>  int __must_check uds_flush_index_session(struct uds_index_session *session);
> diff --git a/drivers/md/dm-vdo/indexer/io-factory.c b/drivers/md/dm-vdo/indexer/io-factory.c
> index 61104d5ccd61..a855c3ac73bc 100644
> --- a/drivers/md/dm-vdo/indexer/io-factory.c
> +++ b/drivers/md/dm-vdo/indexer/io-factory.c
> @@ -23,6 +23,7 @@
>   */
>  struct io_factory {
>  	struct block_device *bdev;
> +	struct file *bdev_file;
>  	atomic_t ref_count;
>  };
>  
> @@ -59,7 +60,7 @@ static void uds_get_io_factory(struct io_factory *factory)
>  	atomic_inc(&factory->ref_count);
>  }
>  
> -int uds_make_io_factory(struct block_device *bdev, struct io_factory **factory_ptr)
> +int uds_make_io_factory(struct file *bdev_file, struct io_factory **factory_ptr)
>  {
>  	int result;
>  	struct io_factory *factory;
> @@ -68,16 +69,18 @@ int uds_make_io_factory(struct block_device *bdev, struct io_factory **factory_p
>  	if (result != VDO_SUCCESS)
>  		return result;
>  
> -	factory->bdev = bdev;
> +	factory->bdev = file_bdev(bdev_file);
> +	factory->bdev_file = bdev_file;
>  	atomic_set_release(&factory->ref_count, 1);
>  
>  	*factory_ptr = factory;
>  	return UDS_SUCCESS;
>  }
>  
> -int uds_replace_storage(struct io_factory *factory, struct block_device *bdev)
> +int uds_replace_storage(struct io_factory *factory, struct file *bdev_file)
>  {
> -	factory->bdev = bdev;
> +	factory->bdev = file_bdev(bdev_file);
> +	factory->bdev_file = bdev_file;
>  	return UDS_SUCCESS;
>  }
>  
> @@ -90,7 +93,7 @@ void uds_put_io_factory(struct io_factory *factory)
>  
>  size_t uds_get_writable_size(struct io_factory *factory)
>  {
> -	return i_size_read(factory->bdev->bd_inode);
> +	return i_size_read(file_inode(factory->bdev_file));
>  }
>  
>  /* Create a struct dm_bufio_client for an index region starting at offset. */
> diff --git a/drivers/md/dm-vdo/indexer/io-factory.h b/drivers/md/dm-vdo/indexer/io-factory.h
> index 60749a9ff756..e5100ab57754 100644
> --- a/drivers/md/dm-vdo/indexer/io-factory.h
> +++ b/drivers/md/dm-vdo/indexer/io-factory.h
> @@ -24,11 +24,11 @@ enum {
>  	SECTORS_PER_BLOCK = UDS_BLOCK_SIZE >> SECTOR_SHIFT,
>  };
>  
> -int __must_check uds_make_io_factory(struct block_device *bdev,
> +int __must_check uds_make_io_factory(struct file *bdev_file,
>  				     struct io_factory **factory_ptr);
>  
>  int __must_check uds_replace_storage(struct io_factory *factory,
> -				     struct block_device *bdev);
> +				     struct file *bdev_file);
>  
>  void uds_put_io_factory(struct io_factory *factory);
>  
> diff --git a/drivers/md/dm-vdo/indexer/volume.c b/drivers/md/dm-vdo/indexer/volume.c
> index 8b21ec93f3bc..a292840a83e3 100644
> --- a/drivers/md/dm-vdo/indexer/volume.c
> +++ b/drivers/md/dm-vdo/indexer/volume.c
> @@ -1467,12 +1467,12 @@ int uds_find_volume_chapter_boundaries(struct volume *volume, u64 *lowest_vcn,
>  
>  int __must_check uds_replace_volume_storage(struct volume *volume,
>  					    struct index_layout *layout,
> -					    struct block_device *bdev)
> +					    struct file *bdev_file)
>  {
>  	int result;
>  	u32 i;
>  
> -	result = uds_replace_index_layout_storage(layout, bdev);
> +	result = uds_replace_index_layout_storage(layout, bdev_file);
>  	if (result != UDS_SUCCESS)
>  		return result;
>  
> diff --git a/drivers/md/dm-vdo/indexer/volume.h b/drivers/md/dm-vdo/indexer/volume.h
> index 7fdd44464db2..5861654d837e 100644
> --- a/drivers/md/dm-vdo/indexer/volume.h
> +++ b/drivers/md/dm-vdo/indexer/volume.h
> @@ -131,7 +131,7 @@ void vdo_free_volume(struct volume *volume);
>  
>  int __must_check uds_replace_volume_storage(struct volume *volume,
>  					    struct index_layout *layout,
> -					    struct block_device *bdev);
> +					    struct file *bdev_file);
>  
>  int __must_check uds_find_volume_chapter_boundaries(struct volume *volume,
>  						    u64 *lowest_vcn, u64 *highest_vcn,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

