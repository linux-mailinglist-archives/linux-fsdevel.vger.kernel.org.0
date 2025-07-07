Return-Path: <linux-fsdevel+bounces-54143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E616AFB8BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997FC16DB8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A411224220;
	Mon,  7 Jul 2025 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yjsPy/xn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dfD+s3Ld";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QTTuFMF/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R7XmGQER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8D155A25
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906273; cv=none; b=bMxOmhI//nVLLiZHBqy76pTNwgYOyFp5KdcIiN1K0kjL9XBoYqTxY5Xd2vWXiS1r/b7s+ONrVg9HMKvTtK4Humomn1K/BqnfJlStHFDrgaMM5b0sqy2Kg5geTlOuF20FNhGc06JXdyMGeDKZTld24K4ks5Z+wzGXoVNGEqfPh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906273; c=relaxed/simple;
	bh=VwalyGaeVSaD6ft++0Zi18Cq60KVfZPG7OmihocJkbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOE+uTcW6OxCausuPbHAsKEvCnuR6AjVz9lAowhzhq0RVl/mcQkBaZWJgs7z5Uoof9yNivGRVjlV2uSFKKqz4F5dVe9ymy6ke290Mm12wE+Z8a60H9Rai67xBl46adJ0Ltdz+EtuGTDbEdapCD0IGcSCpQ/Ku80c1sCIo4NNgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yjsPy/xn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dfD+s3Ld; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QTTuFMF/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R7XmGQER; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97A451F44F;
	Mon,  7 Jul 2025 16:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751906269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fltf6s910MP9MfVWU5449hqMFnTjij3rScGtoZavlBg=;
	b=yjsPy/xn8BHkLwTV/zbM9SOje2MxlKwbycuvW/awc/YrE1Z0Ejwx202c7hhZoUDKleXwVQ
	UJQ8I6Iu/4cW1G+2NFoXYwqQbAJ+Ol3xC0cxN+Fek+tyv09RN1TfBVRHEYyVTqeeNJLXDM
	lZfg3/OjPChU0Ghd70aoxEYfODCIXsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751906269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fltf6s910MP9MfVWU5449hqMFnTjij3rScGtoZavlBg=;
	b=dfD+s3LdiY/XdjtBBkjpviBKdmr9bhVhMysDcUU30u8HMyErXjRqIdoIut0YfzZXxYM4Ca
	MzzfeHNqWBHlV/DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751906268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fltf6s910MP9MfVWU5449hqMFnTjij3rScGtoZavlBg=;
	b=QTTuFMF/q2tIlQpiHOJd12NLJDU4nTYFAgxPK/lcQlmY5QnFj46+QfVSujKUkwNMTLV6qZ
	BPbxAgw0FcJwFSr0X9cq5mZzSddz/UAlRUJjQkcXrK3pKY6gDBNqD1xdjtSgAIU5Qp+ltu
	4xqmgy8IhiQMt9+wS6HaC0YzZRQG6U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751906268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fltf6s910MP9MfVWU5449hqMFnTjij3rScGtoZavlBg=;
	b=R7XmGQER5JL2dE5LqHam+dkwPeXTSdPvLKUj7j0Xw4huO+cT+9xZmL0rfQlhe6tqViycVX
	LinigTrTkxHx3XCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7817D13757;
	Mon,  7 Jul 2025 16:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YRpNHdz3a2jEWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Jul 2025 16:37:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CB7E1A098E; Mon,  7 Jul 2025 18:37:47 +0200 (CEST)
Date: Mon, 7 Jul 2025 18:37:47 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, sashal@kernel.org, naresh.kamboju@linaro.org, 
	jiangqi903@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v4 11/11] ext4: limit the maximum folio order
Message-ID: <h4snda3g6njxlahigv2ca47eknsdall7myeh7b3aw2or6z47qx@m56twof3i5ul>
References: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
 <20250707140814.542883-12-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707140814.542883-12-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,kernel.org,linaro.org,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 07-07-25 22:08:14, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In environments with a page size of 64KB, the maximum size of a folio
> can reach up to 128MB. Consequently, during the write-back of folios,
> the 'rsv_blocks' will be overestimated to 1,577, which can make
> pressure on the journal space where the journal is small. This can
> easily exceed the limit of a single transaction. Besides, an excessively
> large folio is meaningless and will instead increase the overhead of
> traversing the bhs within the folio. Therefore, limit the maximum order
> of a folio to 2048 filesystem blocks.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Joseph Qi <jiangqi903@gmail.com>
> Closes: https://lore.kernel.org/linux-ext4/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h   |  2 +-
>  fs/ext4/ialloc.c |  3 +--
>  fs/ext4/inode.c  | 22 +++++++++++++++++++---
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f705046ba6c6..9ac0a7d4fa0c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3020,7 +3020,7 @@ int ext4_walk_page_buffers(handle_t *handle,
>  				     struct buffer_head *bh));
>  int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  				struct buffer_head *bh);
> -bool ext4_should_enable_large_folio(struct inode *inode);
> +void ext4_set_inode_mapping_order(struct inode *inode);
>  #define FALL_BACK_TO_NONDELALLOC 1
>  #define CONVERT_INLINE_DATA	 2
>  
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 79aa3df8d019..df4051613b29 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1335,8 +1335,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		}
>  	}
>  
> -	if (ext4_should_enable_large_folio(inode))
> -		mapping_set_large_folios(inode->i_mapping);
> +	ext4_set_inode_mapping_order(inode);
>  
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4b679cb6c8bd..1bce9ebaedb7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5181,7 +5181,7 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
>  	return -EFSCORRUPTED;
>  }
>  
> -bool ext4_should_enable_large_folio(struct inode *inode)
> +static bool ext4_should_enable_large_folio(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  
> @@ -5198,6 +5198,22 @@ bool ext4_should_enable_large_folio(struct inode *inode)
>  	return true;
>  }
>  
> +/*
> + * Limit the maximum folio order to 2048 blocks to prevent overestimation
> + * of reserve handle credits during the folio writeback in environments
> + * where the PAGE_SIZE exceeds 4KB.
> + */
> +#define EXT4_MAX_PAGECACHE_ORDER(i)		\
> +		min(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
> +void ext4_set_inode_mapping_order(struct inode *inode)
> +{
> +	if (!ext4_should_enable_large_folio(inode))
> +		return;
> +
> +	mapping_set_folio_order_range(inode->i_mapping, 0,
> +				      EXT4_MAX_PAGECACHE_ORDER(inode));
> +}
> +
>  struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  			  ext4_iget_flags flags, const char *function,
>  			  unsigned int line)
> @@ -5515,8 +5531,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		ret = -EFSCORRUPTED;
>  		goto bad_inode;
>  	}
> -	if (ext4_should_enable_large_folio(inode))
> -		mapping_set_large_folios(inode->i_mapping);
> +
> +	ext4_set_inode_mapping_order(inode);
>  
>  	ret = check_igot_inode(inode, flags, function, line);
>  	/*
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

