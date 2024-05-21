Return-Path: <linux-fsdevel+bounces-19874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC98CA888
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 09:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6A01C217C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AAC4D9E3;
	Tue, 21 May 2024 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="buVjvq6z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sU/sMZAO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="buVjvq6z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sU/sMZAO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817697F;
	Tue, 21 May 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275487; cv=none; b=n1XCcB1XDagjyfgu5IknlUeMYY2+AjeMWAxn+2Xhf73fuVcURk1taIZ77eZy6O9WblWc3+Kp3LH7fupR50BtPf+OEdeXNqMMAbjKMQk2hDYI4JCOTEwa2YIURLU7kuifaDvvGBfMFzpcAG9oGQ/9fFRzZzpnpdhbQ60wKR/tL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275487; c=relaxed/simple;
	bh=12+YaxZtHKB2IO7QRO/Zo094LomXdNW7ot9Gx0n6Sys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHbJvbmE26ElaOTML/NosJ6dDlyZp5VlGO5vfbZwPzlovACZKihy2vYuVzT4JVUxDEgQFNKX53jX64OweKMpkCashD6nhunkdpG8PsZjx5FJKagf/TruzHkDkkK8aAaTFUa1Gbucw0M1bIODcrIbAXRMfmw4WkZqkghTbuItwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=buVjvq6z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sU/sMZAO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=buVjvq6z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sU/sMZAO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A301C5BF1B;
	Tue, 21 May 2024 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716275483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrjJrKusqUxQxH85qHbtWazx4QnA5k0VGbJitR/PwSU=;
	b=buVjvq6zt6wtOYyPYCr36LOwV3PlCOehpV7WNYsd6Dt+yhN5K3V9y8rF+07kPuth/ty1Dy
	JVy3bM28WBVSFKwJLJvY5U5UzvAcIctptuqrL3aV103MOnMSUBfQHAA5fz68+G52NxpQkq
	X2adOTR0somuTQV/fBKcKkXMhwhAO1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716275483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrjJrKusqUxQxH85qHbtWazx4QnA5k0VGbJitR/PwSU=;
	b=sU/sMZAOxrMrXrj8X5LxpfpQjrsc7Ff0LatX/eeBzTkuXTq6U3OBz49jIkNDe0vX7YkcQn
	BCWSuek7ubkEBICg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=buVjvq6z;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="sU/sMZAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716275483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrjJrKusqUxQxH85qHbtWazx4QnA5k0VGbJitR/PwSU=;
	b=buVjvq6zt6wtOYyPYCr36LOwV3PlCOehpV7WNYsd6Dt+yhN5K3V9y8rF+07kPuth/ty1Dy
	JVy3bM28WBVSFKwJLJvY5U5UzvAcIctptuqrL3aV103MOnMSUBfQHAA5fz68+G52NxpQkq
	X2adOTR0somuTQV/fBKcKkXMhwhAO1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716275483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrjJrKusqUxQxH85qHbtWazx4QnA5k0VGbJitR/PwSU=;
	b=sU/sMZAOxrMrXrj8X5LxpfpQjrsc7Ff0LatX/eeBzTkuXTq6U3OBz49jIkNDe0vX7YkcQn
	BCWSuek7ubkEBICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABD2A13A1E;
	Tue, 21 May 2024 07:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8nTEJxpJTGbxPQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 May 2024 07:11:22 +0000
Message-ID: <41228a01-9d0c-415d-9fef-a3d2600b1dfa@suse.de>
Date: Tue, 21 May 2024 09:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 09/12] dm: Add support for copy offload
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520103004epcas5p4a18f3f6ba0f218d57b0ab4bb84c6ff18@epcas5p4.samsung.com>
 <20240520102033.9361-10-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240520102033.9361-10-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A301C5BF1B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,acm.org,fromorbit.com,opensource.wdc.com,samsung.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On 5/20/24 12:20, Nitesh Shetty wrote:
> Before enabling copy for dm target, check if underlying devices and
> dm target support copy. Avoid split happening inside dm target.
> Fail early if the request needs split, currently splitting copy
> request is not supported.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>   drivers/md/dm-table.c         | 37 +++++++++++++++++++++++++++++++++++
>   drivers/md/dm.c               |  7 +++++++
>   include/linux/device-mapper.h |  3 +++
>   3 files changed, 47 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index cc66a27c363a..d58c67ecd794 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1899,6 +1899,38 @@ static bool dm_table_supports_nowait(struct dm_table *t)
>   	return true;
>   }
>   
> +static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
> +				   sector_t start, sector_t len, void *data)
> +{
> +	struct request_queue *q = bdev_get_queue(dev->bdev);
> +
> +	return !q->limits.max_copy_sectors;
> +}
> +
> +static bool dm_table_supports_copy(struct dm_table *t)
> +{
> +	struct dm_target *ti;
> +	unsigned int i;
> +
> +	for (i = 0; i < t->num_targets; i++) {
> +		ti = dm_table_get_target(t, i);
> +
> +		if (!ti->copy_offload_supported)
> +			return false;
> +
> +		/*
> +		 * target provides copy support (as implied by setting
> +		 * 'copy_offload_supported')
> +		 * and it relies on _all_ data devices having copy support.
> +		 */
> +		if (!ti->type->iterate_devices ||
> +		    ti->type->iterate_devices(ti, device_not_copy_capable, NULL))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
>   				      sector_t start, sector_t len, void *data)
>   {
> @@ -1975,6 +2007,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>   		limits->discard_misaligned = 0;
>   	}
>   
> +	if (!dm_table_supports_copy(t)) {
> +		limits->max_copy_sectors = 0;
> +		limits->max_copy_hw_sectors = 0;
> +	}
> +
>   	if (!dm_table_supports_write_zeroes(t))
>   		limits->max_write_zeroes_sectors = 0;
>   
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 597dd7a25823..070b41b83a97 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1717,6 +1717,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
>   	if (unlikely(ci->is_abnormal_io))
>   		return __process_abnormal_io(ci, ti);
>   
> +	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
> +	    max_io_len(ti, ci->sector) < ci->sector_count)) {
> +		DMERR("Error, IO size(%u) > max target size(%llu)\n",
> +		      ci->sector_count, max_io_len(ti, ci->sector));
> +		return BLK_STS_IOERR;
> +	}
> +
>   	/*
>   	 * Only support bio polling for normal IO, and the target io is
>   	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 82b2195efaca..6868941bc7d9 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -397,6 +397,9 @@ struct dm_target {
>   	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
>   	 */
>   	bool needs_bio_set_dev:1;
> +
> +	/* copy offload is supported */
> +	bool copy_offload_supported:1;
>   };
>   
>   void *dm_per_bio_data(struct bio *bio, size_t data_size);

Errm. Not sure this will work. DM tables might be arbitrarily, requiring 
us to _split_ the copy offload request according to the underlying 
component devices. But we explicitly disallowed a split in one of the 
earlier patches.
Or am I wrong?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


