Return-Path: <linux-fsdevel+bounces-14472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853CB87CF7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D891F23607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8913BBCD;
	Fri, 15 Mar 2024 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+ruU/SE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="44kdoP+J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+ruU/SE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="44kdoP+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03B381B4;
	Fri, 15 Mar 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514447; cv=none; b=JgjHfXFbZXGAdd2IhwfrHm9/CoxPNrpEICqdpWXflHgd8qMEsf9o+dKU612rxnTL3Q65q6aAlVZNYnuvuebuI9MQC9L79LYvs/l/YRdLadvbs/E4Eo1Kb9IFFj/GgJ3iQh2seZAsXILEAAfLWILOQAeZ+FP8BpQibwVrRm77/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514447; c=relaxed/simple;
	bh=OZIEYaaMXk5vpFBwixf/tNyOKxVP1jx6iDlXpp0BG5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS11jcT0h40Wh2vE57JvilkqXlQjEdLX+R7EosEd8DxYlm0p1QwNjwN5Q/Nj02GXx6vgar8GfIgW5q0yVwaIFm/fHArywdauYzy+XZNnjxP7YUAT/riBSNolYXfBKg757IYA67LP8knbh5ujnyx5zkSGSHJU1P6EQDqrFbFz20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+ruU/SE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=44kdoP+J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+ruU/SE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=44kdoP+J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BE491FB6D;
	Fri, 15 Mar 2024 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710514443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwGE2iOkEEeJ6EzCD4SWS9g0TxewKkk2xipr6tY+aoo=;
	b=a+ruU/SEbIfi6jPofVjdXNvQaSFilcEK08lLah4zZjW4ojLS+PMuio6j4boxPwdV3C4RGS
	V5VsFSBoXRX7gPKKNutAvBP/xLOkQqsCJNg1QUnryUpEcypxytGsKNn9aOiujXxUZ8Lr6b
	dGfWfmdinThftaCGU9VKFo6vkzdQyKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710514443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwGE2iOkEEeJ6EzCD4SWS9g0TxewKkk2xipr6tY+aoo=;
	b=44kdoP+J0Cjqjoz6k1at5paP+Dvvn+MQ1dPSzu6kXpngEJAqbBAnjpuySa1DdbkQrwxblR
	z1AcEpwxhSwfiVCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710514443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwGE2iOkEEeJ6EzCD4SWS9g0TxewKkk2xipr6tY+aoo=;
	b=a+ruU/SEbIfi6jPofVjdXNvQaSFilcEK08lLah4zZjW4ojLS+PMuio6j4boxPwdV3C4RGS
	V5VsFSBoXRX7gPKKNutAvBP/xLOkQqsCJNg1QUnryUpEcypxytGsKNn9aOiujXxUZ8Lr6b
	dGfWfmdinThftaCGU9VKFo6vkzdQyKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710514443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwGE2iOkEEeJ6EzCD4SWS9g0TxewKkk2xipr6tY+aoo=;
	b=44kdoP+J0Cjqjoz6k1at5paP+Dvvn+MQ1dPSzu6kXpngEJAqbBAnjpuySa1DdbkQrwxblR
	z1AcEpwxhSwfiVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E42E1368C;
	Fri, 15 Mar 2024 14:54:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KdQtDwth9GWpRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:54:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDE6EA07D9; Fri, 15 Mar 2024 15:54:02 +0100 (CET)
Date: Fri, 15 Mar 2024 15:54:02 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 09/19] gfs2: prevent direct access of bd_inode
Message-ID: <20240315145402.2vroseztnxfh2wfx@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-10-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-10-yukuai1@huaweicloud.com>
X-Spam-Score: -4.01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="a+ruU/SE";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=44kdoP+J
X-Rspamd-Queue-Id: 4BE491FB6D

On Thu 22-02-24 20:45:45, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all filesystems stash the bdev file, it's ok to get inode
> from the file.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/gfs2/glock.c      | 2 +-
>  fs/gfs2/ops_fstype.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 34540f9d011c..95ade8979f6b 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -1227,7 +1227,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
>  	mapping = gfs2_glock2aspace(gl);
>  	if (mapping) {
>                  mapping->a_ops = &gfs2_meta_aops;
> -		mapping->host = s->s_bdev->bd_inode;
> +		mapping->host = file_inode(s->s_bdev_file);
>  		mapping->flags = 0;
>  		mapping_set_gfp_mask(mapping, GFP_NOFS);
>  		mapping->i_private_data = NULL;
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 572d58e86296..4384cb39b06c 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -114,7 +114,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
>  
>  	address_space_init_once(mapping);
>  	mapping->a_ops = &gfs2_rgrp_aops;
> -	mapping->host = sb->s_bdev->bd_inode;
> +	mapping->host = file_inode(sb->s_bdev_file);
>  	mapping->flags = 0;
>  	mapping_set_gfp_mask(mapping, GFP_NOFS);
>  	mapping->i_private_data = NULL;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

