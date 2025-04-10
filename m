Return-Path: <linux-fsdevel+bounces-46204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7CA8450E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5290B1890D1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF4F28A41A;
	Thu, 10 Apr 2025 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnFwWNrJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m2543pVU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnFwWNrJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m2543pVU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9E28A3F2
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292195; cv=none; b=UOoGJZoYmWXpO+sKlXjroe1MVGd2JZB68lK1QS4Zmb/k7rvVDOxdTu6is7cvny6XV1mNzQtQi0Cc7FSBEX7BlUgX9jjy2UmQcNwIjAYl2etZ7s4WO0mr8tkb9UzDgk3ehNAB69ZGzQxIVlqXyy2CT3vnfEomyn3sVWa2R0lvkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292195; c=relaxed/simple;
	bh=G3JCsHTEIDMSrzwxuJNVbrGum619sm/V+oMoFrGL6q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmIK4vnjJSm92gch68g9iRZoI1+krUR2GyrL4nBhy4XedbLbtR0G+7kOw3SAilSdLpr/rxQY0OQFg+ufTQvPowzDfcQ4jIK4lDRRg0Nf4sdpJzzK9YOJ/EFyDv6w2rZj2yQsTLREd5tVaYVqUCLbx4HpLmOqyMKb0Zg5aPTwP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnFwWNrJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m2543pVU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnFwWNrJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m2543pVU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB3891F395;
	Thu, 10 Apr 2025 13:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744292190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6X3ZizTCtne9HGkeErFZvJrpS/23t7UWALSWxnxHkPg=;
	b=lnFwWNrJbWGFz+wygGgWYJe6+phUedIcMwJZN8NrkUzaOvYvwvOIX4eF8IqbUG2x5a6EdL
	r15/fdvxBplYKXxhaxA388elj4zmLXci1rG6PcJHrtWvfxuY9y6dNAkT+ziJbHjkDCDjFQ
	rwyBpSBZS1/a8Ne/6pug3GxqSIsC498=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744292190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6X3ZizTCtne9HGkeErFZvJrpS/23t7UWALSWxnxHkPg=;
	b=m2543pVUozaVCe53yZQh25q4eN+MyjMrKJyM2grOmtVY3XaoFEaaOtFXZJPQ/ZOuozIokD
	flJc+v8dylpROsAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744292190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6X3ZizTCtne9HGkeErFZvJrpS/23t7UWALSWxnxHkPg=;
	b=lnFwWNrJbWGFz+wygGgWYJe6+phUedIcMwJZN8NrkUzaOvYvwvOIX4eF8IqbUG2x5a6EdL
	r15/fdvxBplYKXxhaxA388elj4zmLXci1rG6PcJHrtWvfxuY9y6dNAkT+ziJbHjkDCDjFQ
	rwyBpSBZS1/a8Ne/6pug3GxqSIsC498=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744292190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6X3ZizTCtne9HGkeErFZvJrpS/23t7UWALSWxnxHkPg=;
	b=m2543pVUozaVCe53yZQh25q4eN+MyjMrKJyM2grOmtVY3XaoFEaaOtFXZJPQ/ZOuozIokD
	flJc+v8dylpROsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 974B8132D8;
	Thu, 10 Apr 2025 13:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U6fmJF7J92fkagAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Apr 2025 13:36:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E23B9A0910; Thu, 10 Apr 2025 15:36:25 +0200 (CEST)
Date: Thu, 10 Apr 2025 15:36:25 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, jack@suse.cz, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, riel@surriel.com, dave@stgolabs.net, 
	willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com, david@redhat.com, 
	axboe@kernel.dk, hare@suse.de, david@fromorbit.com, djwong@kernel.org, 
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH v2 6/8] fs/ext4: use sleeping version of
 __find_get_block()
Message-ID: <g2xj2du3t226jve57mw4wiig4zpqqsvomtbzeu4wk37dfqbp47@3l66fjg736yy>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-7-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410014945.2140781-7-mcgrof@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,mit.edu,dilger.ca,vger.kernel.org,surriel.com,stgolabs.net,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Wed 09-04-25 18:49:43, Luis Chamberlain wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> Trivially introduce the wrapper and enable ext4_free_blocks() to use
> it, which has a cond_resched to begin with. Convert to the new nonatomic
> flavor to benefit from potential performance benefits and adapt in the
> future vs migration such that semantics are kept.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/ext4/inode.c             | 2 ++
>  fs/ext4/mballoc.c           | 3 ++-
>  include/linux/buffer_head.h | 6 ++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1dc09ed5d403..b7acb5d3adcb 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -860,6 +860,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
>  		return sb_find_get_block(inode->i_sb, map.m_pblk);
>  
>  	/*
> +	 * Potential TODO: use sb_find_get_block_nonatomic() instead.
> +	 *

Yes, please. Since we are behind nowait check, we are fine with blocking...

								Honza

>  	 * Since bh could introduce extra ref count such as referred by
>  	 * journal_head etc. Try to avoid using __GFP_MOVABLE here
>  	 * as it may fail the migration when journal_head remains.
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 0d523e9fb3d5..6f4265b21e19 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6644,7 +6644,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  		for (i = 0; i < count; i++) {
>  			cond_resched();
>  			if (is_metadata)
> -				bh = sb_find_get_block(inode->i_sb, block + i);
> +				bh = sb_find_get_block_nonatomic(inode->i_sb,
> +								 block + i);
>  			ext4_forget(handle, is_metadata, inode, bh, block + i);
>  		}
>  	}
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 2b5458517def..8db10ca288fc 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -399,6 +399,12 @@ sb_find_get_block(struct super_block *sb, sector_t block)
>  	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
>  }
>  
> +static inline struct buffer_head *
> +sb_find_get_block_nonatomic(struct super_block *sb, sector_t block)
> +{
> +	return __find_get_block_nonatomic(sb->s_bdev, block, sb->s_blocksize);
> +}
> +

This hunk probably belongs to some introductory patch implementing
nonatomic helpers.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

