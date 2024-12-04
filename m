Return-Path: <linux-fsdevel+bounces-36416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A31C9E38C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A036286354
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE041B372C;
	Wed,  4 Dec 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QYhTiyS9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="91W21iiy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QYhTiyS9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="91W21iiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F1192D70;
	Wed,  4 Dec 2024 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311629; cv=none; b=ja4pRMJo2L3+VV/a+0McBCHh6tcelVFS1MOY0FhsQz9fba9+jFBnHQwNvD9Mi9W5bs6KfY+wnqhKbFv2RenLClPgEZwsUqyIrJGSC44Lp7DfbGvKvUCQ+WcObQkwj56980icVX3Zi308z10i+0nTtBmX4BPYCAClpkQ9/V73vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311629; c=relaxed/simple;
	bh=PFRn3SGhnoozp3qOlFIq1FHCxlbiVxXerVcc6TG/vn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODsnp7NsiNmVW9XuKoCoZabO6oVDsAZ1N+12k12tgpQ8vf2RB2rvjf8ExJJuQfrxDIR6TiaiYf1tCBEaWOLk4Y1Qaj0ue4vk8dC/BLLRNFdpdIGTLoCOqturewHba8WBNi5HdlJG4lfYOhb0ugvhW21a9DGSm4NY/lqxkci8Ia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QYhTiyS9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=91W21iiy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QYhTiyS9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=91W21iiy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B57D2115B;
	Wed,  4 Dec 2024 11:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733311626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZbRM7aT9H1zCBrthd8zNiiKo8o7hfrWZ+zYFC840jM=;
	b=QYhTiyS98L90Ejp4UTqBDdrkHsZD25sBzm/WeLeRLO7kn47yIat7mDHa9ntw1qN6VCE7lE
	FrM+CO4bOrwh2Tg/v+Nl2fO/1d8d4xuwe4w4Xbm3Z9fFjo3DrPDuQ9EVt6hl7vtedY+1kl
	o+CvM4CYToQLY53o95uGFQz2bGoRzMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733311626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZbRM7aT9H1zCBrthd8zNiiKo8o7hfrWZ+zYFC840jM=;
	b=91W21iiyUEgT1iIljCiRMPB3jrv7G9qooMXHedvLN+ISvlAnxas0KB8AACY6TWKxnU2iH2
	/4dRZgCQrV5GSECw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733311626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZbRM7aT9H1zCBrthd8zNiiKo8o7hfrWZ+zYFC840jM=;
	b=QYhTiyS98L90Ejp4UTqBDdrkHsZD25sBzm/WeLeRLO7kn47yIat7mDHa9ntw1qN6VCE7lE
	FrM+CO4bOrwh2Tg/v+Nl2fO/1d8d4xuwe4w4Xbm3Z9fFjo3DrPDuQ9EVt6hl7vtedY+1kl
	o+CvM4CYToQLY53o95uGFQz2bGoRzMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733311626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZbRM7aT9H1zCBrthd8zNiiKo8o7hfrWZ+zYFC840jM=;
	b=91W21iiyUEgT1iIljCiRMPB3jrv7G9qooMXHedvLN+ISvlAnxas0KB8AACY6TWKxnU2iH2
	/4dRZgCQrV5GSECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C6241396E;
	Wed,  4 Dec 2024 11:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cMi8Doo8UGcYEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 11:27:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EFDE1A0918; Wed,  4 Dec 2024 12:27:05 +0100 (CET)
Date: Wed, 4 Dec 2024 12:27:05 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 03/27] ext4: don't write back data before punch hole in
 nojournal mode
Message-ID: <20241204112705.vb2vhlklnzswtvlf@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-4-yi.zhang@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 22-10-24 19:10:34, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> There is no need to write back all data before punching a hole in
> data=ordered|writeback mode since it will be dropped soon after removing
> space, so just remove the filemap_write_and_wait_range() in these modes.
> However, in data=journal mode, we need to write dirty pages out before
> discarding page cache in case of crash before committing the freeing
> data transaction, which could expose old, stale data.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

With the ext4_truncate_page_cache_block_range() function I propose, this
will get slightly simpler. But overall the patch looks good.

								Honza

> ---
>  fs/ext4/inode.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f8796f7b0f94..94b923afcd9c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3965,17 +3965,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  
> -	/*
> -	 * Write out all dirty pages to avoid race conditions
> -	 * Then release them.
> -	 */
> -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> -		ret = filemap_write_and_wait_range(mapping, offset,
> -						   offset + length - 1);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	inode_lock(inode);
>  
>  	/* No need to punch hole beyond i_size */
> @@ -4037,6 +4026,21 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  		ret = ext4_update_disksize_before_punch(inode, offset, length);
>  		if (ret)
>  			goto out_dio;
> +
> +		/*
> +		 * For journalled data we need to write (and checkpoint) pages
> +		 * before discarding page cache to avoid inconsitent data on
> +		 * disk in case of crash before punching trans is committed.
> +		 */
> +		if (ext4_should_journal_data(inode)) {
> +			ret = filemap_write_and_wait_range(mapping,
> +					first_block_offset, last_block_offset);
> +			if (ret)
> +				goto out_dio;
> +		}
> +
> +		ext4_truncate_folios_range(inode, first_block_offset,
> +					   last_block_offset + 1);
>  		truncate_pagecache_range(inode, first_block_offset,
>  					 last_block_offset);
>  	}
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

