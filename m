Return-Path: <linux-fsdevel+bounces-66723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA3FC2A92D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D02F14EB8D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13FF2DCF44;
	Mon,  3 Nov 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DCUlnY/z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0ERLWzA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DCUlnY/z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0ERLWzA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C22DC328
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158479; cv=none; b=rNAd9lBt/GlRMjUed5F3wI9M+ADS7Golx3tAAaHf9RTwWsX7lvnMbSGQs9n9MPuj2wChPV3trlUnL8SR08VvM648I262qabxsnG260uwnzYC4QUyZOK8tSeM2/2KZ9xw9rBRi2lmsvebBU+bB/Oni531o1autbt9ndXATCHnG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158479; c=relaxed/simple;
	bh=oiBLm27BCgs7aLGWQVA7hJPj0s5QbRXxxbIZk/KkJpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEyxSXHXyWFa6o8e7pAwwCNi5OidMzH7NmncSAFwFLLLFk1+aRy4gb5XavaYGh17BOp3owbLu7CqV1dGJfGeqM3+83SpyUz4fZHJyQGJ0Ofc3PCB4pdsUzgjt5eJ/axQ8pt/V/tWTAKcQLvIwf/dUK//jk/Bel22jsJO582ocEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DCUlnY/z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c0ERLWzA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DCUlnY/z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c0ERLWzA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D43421DB0;
	Mon,  3 Nov 2025 08:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762158476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ee5KZvxhugRFMpeq4Qiq/n3Z6f7uctA6ZH0uyPJXPCI=;
	b=DCUlnY/z3Ky1Xm7HAejt1r3xOlJx51+9ntNJx4rLAM1au4uIxhA/I1M8OZuE94qrPu60kX
	EpDC1vkxqvmvaXNgVg/qOQ0xKL/3Va1UhHOxrIjyBcwG3dlHYVO0tINJ77JXK1M0Hq9rjV
	/Z9dKUSvi/2zuIeoYrXGy/CvkH/+zqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762158476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ee5KZvxhugRFMpeq4Qiq/n3Z6f7uctA6ZH0uyPJXPCI=;
	b=c0ERLWzAYo0wOk3SCD6EFNCY8xqV9JLpQwjjnzLOVniOLfYrVnJ5Uh7SEcq4IcwLxr1AMe
	wSuB8/J/wL2IgSBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762158476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ee5KZvxhugRFMpeq4Qiq/n3Z6f7uctA6ZH0uyPJXPCI=;
	b=DCUlnY/z3Ky1Xm7HAejt1r3xOlJx51+9ntNJx4rLAM1au4uIxhA/I1M8OZuE94qrPu60kX
	EpDC1vkxqvmvaXNgVg/qOQ0xKL/3Va1UhHOxrIjyBcwG3dlHYVO0tINJ77JXK1M0Hq9rjV
	/Z9dKUSvi/2zuIeoYrXGy/CvkH/+zqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762158476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ee5KZvxhugRFMpeq4Qiq/n3Z6f7uctA6ZH0uyPJXPCI=;
	b=c0ERLWzAYo0wOk3SCD6EFNCY8xqV9JLpQwjjnzLOVniOLfYrVnJ5Uh7SEcq4IcwLxr1AMe
	wSuB8/J/wL2IgSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBD3A139A9;
	Mon,  3 Nov 2025 08:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VYWQOYtnCGkVcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 08:27:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B850A2A64; Mon,  3 Nov 2025 09:27:55 +0100 (CET)
Date: Mon, 3 Nov 2025 09:27:55 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 08/25] ext4: support large block size in ext4_readdir()
Message-ID: <kfzwluvt7sb43pl7fr4qexvflentvgm5y2s52kxg4exe6tsq7n@e4kjkexvwtvg>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-9-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-9-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,huaweicloud.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 

On Sat 25-10-25 11:22:04, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_readdir(), page_cache_sync_readahead() is used to readahead mapped
> physical blocks. With LBS support, this can lead to a negative right shift.
> 
> To fix this, the page index is now calculated by first converting the
> physical block number (pblk) to a file position (pos) before converting
> it to a page index. Also, the correct number of pages to readahead is now
> passed.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index d4164c507a90..256fe2c1d4c1 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -192,13 +192,13 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
>  			continue;
>  		}
>  		if (err > 0) {
> -			pgoff_t index = map.m_pblk >>
> -					(PAGE_SHIFT - inode->i_blkbits);
> +			pgoff_t index = map.m_pblk << inode->i_blkbits >>
> +					PAGE_SHIFT;
>  			if (!ra_has_index(&file->f_ra, index))
>  				page_cache_sync_readahead(
>  					sb->s_bdev->bd_mapping,
> -					&file->f_ra, file,
> -					index, 1);
> +					&file->f_ra, file, index,
> +					1 << EXT4_SB(sb)->s_min_folio_order);
>  			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
>  			bh = ext4_bread(NULL, inode, map.m_lblk, 0);
>  			if (IS_ERR(bh)) {
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

