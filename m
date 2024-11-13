Return-Path: <linux-fsdevel+bounces-34612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E09C6C4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955DDB2B32A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400861F8907;
	Wed, 13 Nov 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2PeK782b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wEcWvfJa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2PeK782b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wEcWvfJa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D31178CC8;
	Wed, 13 Nov 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491838; cv=none; b=Ucbq4NHjAOU7xT2WFYIFEgi9ZRXV1Fazyq3jVazaKmB+oHd9E2S/dSjRlUg9ASLuT/Au/QPErXbQjomRrE4XCk3Xvikc8k0dorMAex4tScDdl0RW4Q/CnECsr+uP9lWJT8IJ20kNPWg1Nv28q6HqGMgPNHK0Wi/m+r85zDo3pWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491838; c=relaxed/simple;
	bh=37YQFC3QOEjDo9h7rf5yQ21f6VNagKCKG3xPM8cP9g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrcYaCoayuHm0XsttgZui7TmmlPNbYqa0W93ZGFp1kjvJyZcdoTXFTV0Rz/J7AJskSiGA16amc9Ktez7W2L4Ra+KCtUs2G5bH+SJOMl/Y0wOiAGeOnLnMxrR7uI4IQsWoPS7AGvuahLd3RAtcpwZu+4kPINFhv1MK0mpZCnSnek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2PeK782b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wEcWvfJa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2PeK782b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wEcWvfJa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 278291F37C;
	Wed, 13 Nov 2024 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1tVxJiCCuXNfk0qGPASJbvm0/hl/h3KyXPElURHw3g=;
	b=2PeK782bX5eJq5QY6OTM0iGrSyt7dhMB8t+F8VUJsDGPyfkAR27PUr7WhNOhkNo+Nss9BE
	qMH2CInc0IqlAfV3jrkUE23Cn/6/5BFbxGm24XPS9670vlyNEBl36w31YndCes494VbdsE
	GYcBvJQTcLzUsMFURZRI7CymFJ0Ao4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1tVxJiCCuXNfk0qGPASJbvm0/hl/h3KyXPElURHw3g=;
	b=wEcWvfJaIGLwLrNP/J3CDUW53xbr46y2qWjR+dT53TMG/uMFjqj+sXDXmrywThlHrQ1OPU
	bXy4NY9x8mlXEQCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2PeK782b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wEcWvfJa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1tVxJiCCuXNfk0qGPASJbvm0/hl/h3KyXPElURHw3g=;
	b=2PeK782bX5eJq5QY6OTM0iGrSyt7dhMB8t+F8VUJsDGPyfkAR27PUr7WhNOhkNo+Nss9BE
	qMH2CInc0IqlAfV3jrkUE23Cn/6/5BFbxGm24XPS9670vlyNEBl36w31YndCes494VbdsE
	GYcBvJQTcLzUsMFURZRI7CymFJ0Ao4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1tVxJiCCuXNfk0qGPASJbvm0/hl/h3KyXPElURHw3g=;
	b=wEcWvfJaIGLwLrNP/J3CDUW53xbr46y2qWjR+dT53TMG/uMFjqj+sXDXmrywThlHrQ1OPU
	bXy4NY9x8mlXEQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E781213A6E;
	Wed, 13 Nov 2024 09:57:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XYv7N/p3NGe6GQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:57:14 +0000
Message-ID: <be3e2822-0289-4ce2-b7ef-e09b260ed3d6@suse.de>
Date: Wed, 13 Nov 2024 10:57:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/8] block/bdev: lift block size restrictions and use common
 definition
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
 david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241113094727.1497722-1-mcgrof@kernel.org>
 <20241113094727.1497722-7-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241113094727.1497722-7-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 278291F37C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,kernel.org,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 11/13/24 10:47, Luis Chamberlain wrote:
> We now can support blocksizes larger than PAGE_SIZE, so lift
> the restriction up to the max supported page cache order and
> just bake this into a common helper used by the block layer.
> 
> We bound ourselves to 64k, because beyond that we need more testing.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/bdev.c           | 5 ++---
>   include/linux/blkdev.h | 6 +++++-
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 167d82b46781..3a5fd65f6c8e 100644
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
> +	 * and it's value is larger than 512 */
>   	sb->s_blocksize = size;
>   	sb->s_blocksize_bits = blksize_bits(size);
>   	return sb->s_blocksize;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50c3b959da28..cc9fca1fceaa 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -25,6 +25,7 @@
>   #include <linux/uuid.h>
>   #include <linux/xarray.h>
>   #include <linux/file.h>
> +#include <linux/pagemap.h>
>   
>   struct module;
>   struct request_queue;
> @@ -268,10 +269,13 @@ static inline dev_t disk_devt(struct gendisk *disk)
>   	return MKDEV(disk->major, disk->first_minor);
>   }
>   
> +/* We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER) */
> +#define BLK_MAX_BLOCK_SIZE      (SZ_64K)
> +

Please make the comment a bit more descriptive, indicating that beyond 
64k more testing is required, hence it's not enabled for now.

We _could_ add a config option to make this conditional...

>   /* blk_validate_limits() validates bsize, so drivers don't usually need to */
>   static inline int blk_validate_block_size(unsigned long bsize)
>   {
> -	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
> +	if (bsize < 512 || bsize > BLK_MAX_BLOCK_SIZE || !is_power_of_2(bsize))
>   		return -EINVAL;
>   
>   	return 0;
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

