Return-Path: <linux-fsdevel+bounces-37624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E979F486E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 11:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED8E188B0D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C21E0087;
	Tue, 17 Dec 2024 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vhqtP1oE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AcM1u5LR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vhqtP1oE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AcM1u5LR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294DDEEB2;
	Tue, 17 Dec 2024 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429950; cv=none; b=Ma/SO0oDFA/jWszx4WbI02zNNzs6t56UW4WyHotuAZmA7VR471rAeYiY/iCVlxTzL/291QHoVCYqS50WKOv/qFpC41IVvQQ617eOqRZFtz4uNiE0G4gl7sxvozIBbXuSXFkFqBopy7etqTvLK24W9xkNxIQvW1gvD44TItEcTR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429950; c=relaxed/simple;
	bh=j1dyIoKVJtimQxhRxJCg8Dvp2eZVpJ9EKHcWkAZv/qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8ZNVeHTeVe3fsxViDy0JF4AZ75AYhnU9NCFukOEfYIDoDdBz1b/zy29VhB9KQ9etuV2zarzUqho8TFGiTGoZug6GPoE/uXF3KQABQ8hpOAQI/YGXjgbopLtUrqBcmjdOly98Pe+rW1W0X8PQMri8DZ5o8ApMoMhY4IFrNDX5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vhqtP1oE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AcM1u5LR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vhqtP1oE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AcM1u5LR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19EDC1F392;
	Tue, 17 Dec 2024 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734429947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/6NS1ssR6spHYiu3y0Y1SnfsByi/sQPG7A7syHmwAI=;
	b=vhqtP1oENdHaVHJtPBNZOLB8F8gGPgoX6XF9TP4fGrJSkvYFHxT4m3jSQnPqPHuFa6aswP
	TgwEc4Ud4n+LPpF0h/vKRRESZW/Nuf89W/6fLQsIVBeEweAH6gtukXwlmJMMLvYagK4j3a
	/ZhmSaz9uERbLrH2ULnxlK1YnoJec+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734429947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/6NS1ssR6spHYiu3y0Y1SnfsByi/sQPG7A7syHmwAI=;
	b=AcM1u5LRYaa5tmevPECZZnduWTT4DHNLGNBXbF1r5Jp/ppnxucuDYYY/z8SRUdedowohd5
	lUwJsq790dU+RADg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vhqtP1oE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AcM1u5LR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734429947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/6NS1ssR6spHYiu3y0Y1SnfsByi/sQPG7A7syHmwAI=;
	b=vhqtP1oENdHaVHJtPBNZOLB8F8gGPgoX6XF9TP4fGrJSkvYFHxT4m3jSQnPqPHuFa6aswP
	TgwEc4Ud4n+LPpF0h/vKRRESZW/Nuf89W/6fLQsIVBeEweAH6gtukXwlmJMMLvYagK4j3a
	/ZhmSaz9uERbLrH2ULnxlK1YnoJec+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734429947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/6NS1ssR6spHYiu3y0Y1SnfsByi/sQPG7A7syHmwAI=;
	b=AcM1u5LRYaa5tmevPECZZnduWTT4DHNLGNBXbF1r5Jp/ppnxucuDYYY/z8SRUdedowohd5
	lUwJsq790dU+RADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BD6A13A3C;
	Tue, 17 Dec 2024 10:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CdKzGPpMYWe0OwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Dec 2024 10:05:46 +0000
Message-ID: <6053c010-a623-485d-89b7-de34f05a5c8a@suse.de>
Date: Tue, 17 Dec 2024 11:05:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 09/11] block/bdev: lift block size restrictions and use
 common definition
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
 dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-10-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241214031050.1337920-10-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 19EDC1F392
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,kernel.org,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 12/14/24 04:10, Luis Chamberlain wrote:
> We now can support blocksizes larger than PAGE_SIZE, so lift
> the restriction up to the max supported page cache order and
> just bake this into a common helper used by the block layer.
> 
> We bound ourselves to 64k as a sensible limit. The hard limit,
> however is 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER).
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/bdev.c           |  5 ++---
>   include/linux/blkdev.h | 11 ++++++++++-
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 167d82b46781..b57dc4bff81b 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -157,8 +157,7 @@ int set_blocksize(struct file *file, int size)
>   	struct inode *inode = file->f_mapping->host;
>   	struct block_device *bdev = I_BDEV(inode);
>   
> -	/* Size must be a power of two, and between 512 and PAGE_SIZE */
> -	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
> +	if (blk_validate_block_size(size))
>   		return -EINVAL;
>   
>   	/* Size cannot be smaller than the size supported by the device */
> @@ -185,7 +184,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
>   	if (set_blocksize(sb->s_bdev_file, size))
>   		return 0;
>   	/* If we get here, we know size is power of two
> -	 * and it's value is between 512 and PAGE_SIZE */
> +	 * and its value is larger than 512 */
>   	sb->s_blocksize = size;
>   	sb->s_blocksize_bits = blksize_bits(size);
>   	return sb->s_blocksize;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 08a727b40816..a7303a55ed2a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -269,10 +269,19 @@ static inline dev_t disk_devt(struct gendisk *disk)
>   	return MKDEV(disk->major, disk->first_minor);
>   }
>   
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +/*
> + * The hard limit is (1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER).
As this is the hard limit, one wonders why we don't use it ...
So please add a comment why we restrict it to 64k.

> + */
> +#define BLK_MAX_BLOCK_SIZE      (SZ_64K)
> +#else
> +#define BLK_MAX_BLOCK_SIZE      (PAGE_SIZE)
> +#endif
> +
>   /* blk_validate_limits() validates bsize, so drivers don't usually need to */
>   static inline int blk_validate_block_size(unsigned long bsize)
>   {
> -	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
> +	if (bsize < 512 || bsize > BLK_MAX_BLOCK_SIZE || !is_power_of_2(bsize))
>   		return -EINVAL;
>   
>   	return 0;

Otherwise:
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

