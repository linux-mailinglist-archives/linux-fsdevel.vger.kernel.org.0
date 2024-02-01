Return-Path: <linux-fsdevel+bounces-9844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CECCF84550B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417221F2C29D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114FB15CD5B;
	Thu,  1 Feb 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UItN2PPa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L12lcfMu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eGRxXmRg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WFHIb1qa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373315B96F;
	Thu,  1 Feb 2024 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782617; cv=none; b=XN2Ok3h4Dp4EfC40q7bme8576N7fKKTQX5ARUG5xYcEYpOKoojzXVkop6ipOJYUXJsSFU2mSkGZDqXFhJqumnS8IXbdGZbPoSvuyiSTi4+4jImPX3KRqaIWuxC9NiZUmEhxQ8qnTiRahyZ1MTpxgFH7Xcdc3mxYK3GGVuCf8T1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782617; c=relaxed/simple;
	bh=ia+yxasIiI27OwjV+6IHpOU1gecxr8B8OsatSCyTlC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enSuIpEew1EKh7hrixOH97+Fzp8ZpYTta+TLOTIpjOzm8P2SSEkc8F4bKQQ7wlprtdSa+edWZGUXT/aNM8m2yDLVpGIlKyYSx8lZ2PoiAfFs/czLo+sb8p+DtYA9BVK0r2hUyaE/QpoWA76Rgm1AMtDBzJVmxqe5yegjjelK21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UItN2PPa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L12lcfMu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eGRxXmRg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WFHIb1qa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8C72221CE;
	Thu,  1 Feb 2024 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMirx4qQzcK2FG/nZplcNw7Lc9q7NkLycwRWlrvnoKQ=;
	b=UItN2PPaF7724yTI5Y+smZVJwWiz5LP4WfY/naUh5A/edLJn9w6qJxpcmBK0QLqOSbUlyu
	B+3u4L7pn84TF14NyXHvM0fJ4De3TN31BHsdqCOn3n9mMtCDYYPsM11DV1RvMT6Lklda8I
	Ns4OiKqcm3cJ7fbTE+Hn8MZYSGuZUt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMirx4qQzcK2FG/nZplcNw7Lc9q7NkLycwRWlrvnoKQ=;
	b=L12lcfMuRd3YrTEGtvXQXuu5z9VS4OXvGv5RQqhNPJL0nA3a0xzDDGv4o3ggHoKmRLWz8N
	lsGfIDmuQrur2YDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMirx4qQzcK2FG/nZplcNw7Lc9q7NkLycwRWlrvnoKQ=;
	b=eGRxXmRgRV1HWD9fpDw+o1QkpeSmRulbZHXkT5g8i+5SdwW50TKpBHHxQDCy2yoIbiJkEv
	4nW9KLa50/FenFDZv+lZrEkaQzbVAlVghTRAj0idFLmvB7rJZ4Y4Mbw2ytXUVPFid1a4B1
	yb5X6OBLqypszo588nzg5P49Ou/SVdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMirx4qQzcK2FG/nZplcNw7Lc9q7NkLycwRWlrvnoKQ=;
	b=WFHIb1qaYmNE37MsPeCRa3DBFJLEE6B+/qYBiLkyInzm8R/J1mCFVRWDeKN+rHCWlG7TlV
	TDso9MgzEPpWBwAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DCDF11329F;
	Thu,  1 Feb 2024 10:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id dMXqNZVvu2UCXgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:16:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 998D7A0809; Thu,  1 Feb 2024 11:16:53 +0100 (CET)
Date: Thu, 1 Feb 2024 11:16:53 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 20/34] erofs: port device access to file
Message-ID: <20240201101653.hya3ze4kq7ekiudm@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-20-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-20-adbd023e19cc@kernel.org>
X-Spam-Level: ****
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eGRxXmRg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WFHIb1qa
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [4.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_SPAM(5.10)[100.00%];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: 4.09
X-Rspamd-Queue-Id: E8C72221CE
X-Spam-Flag: NO

On Tue 23-01-24 14:26:37, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/erofs/data.c     |  6 +++---
>  fs/erofs/internal.h |  2 +-
>  fs/erofs/super.c    | 16 ++++++++--------
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index c98aeda8abb2..433fc39ba423 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -220,7 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  			up_read(&devs->rwsem);
>  			return 0;
>  		}
> -		map->m_bdev = dif->bdev_handle ? dif->bdev_handle->bdev : NULL;
> +		map->m_bdev = dif->bdev_file ? file_bdev(dif->bdev_file) : NULL;
>  		map->m_daxdev = dif->dax_dev;
>  		map->m_dax_part_off = dif->dax_part_off;
>  		map->m_fscache = dif->fscache;
> @@ -238,8 +238,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  			if (map->m_pa >= startoff &&
>  			    map->m_pa < startoff + length) {
>  				map->m_pa -= startoff;
> -				map->m_bdev = dif->bdev_handle ?
> -					      dif->bdev_handle->bdev : NULL;
> +				map->m_bdev = dif->bdev_file ?
> +					      file_bdev(dif->bdev_file) : NULL;
>  				map->m_daxdev = dif->dax_dev;
>  				map->m_dax_part_off = dif->dax_part_off;
>  				map->m_fscache = dif->fscache;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index b0409badb017..0f0706325b7b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -49,7 +49,7 @@ typedef u32 erofs_blk_t;
>  struct erofs_device_info {
>  	char *path;
>  	struct erofs_fscache *fscache;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct dax_device *dax_dev;
>  	u64 dax_part_off;
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 5f60f163bd56..9b4b66dcdd4f 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -177,7 +177,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  	struct erofs_fscache *fscache;
>  	struct erofs_deviceslot *dis;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	void *ptr;
>  
>  	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
> @@ -201,12 +201,12 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  			return PTR_ERR(fscache);
>  		dif->fscache = fscache;
>  	} else if (!sbi->devs->flatdev) {
> -		bdev_handle = bdev_open_by_path(dif->path, BLK_OPEN_READ,
> +		bdev_file = bdev_file_open_by_path(dif->path, BLK_OPEN_READ,
>  						sb->s_type, NULL);
> -		if (IS_ERR(bdev_handle))
> -			return PTR_ERR(bdev_handle);
> -		dif->bdev_handle = bdev_handle;
> -		dif->dax_dev = fs_dax_get_by_bdev(bdev_handle->bdev,
> +		if (IS_ERR(bdev_file))
> +			return PTR_ERR(bdev_file);
> +		dif->bdev_file = bdev_file;
> +		dif->dax_dev = fs_dax_get_by_bdev(file_bdev(bdev_file),
>  				&dif->dax_part_off, NULL, NULL);
>  	}
>  
> @@ -754,8 +754,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
>  	struct erofs_device_info *dif = ptr;
>  
>  	fs_put_dax(dif->dax_dev, NULL);
> -	if (dif->bdev_handle)
> -		bdev_release(dif->bdev_handle);
> +	if (dif->bdev_file)
> +		fput(dif->bdev_file);
>  	erofs_fscache_unregister_cookie(dif->fscache);
>  	dif->fscache = NULL;
>  	kfree(dif->path);
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

