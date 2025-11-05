Return-Path: <linux-fsdevel+bounces-67080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E62C34DEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736753BAC2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7B2FD7A7;
	Wed,  5 Nov 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pcKn8+v3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/GfKYWd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pcKn8+v3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/GfKYWd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0402FA0D3
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334886; cv=none; b=ambErMjwIvwgpMW01xUsW4z6VIUMYUeeqFURHFYEhnFwOhKNb3/Gj3iq9liqbR3cZV+SSnHJ2BjSTaN3MFjPajTh3ly7EgodYU3qAWfIVhkEZ3MUCck0p2bzPBvQ2141AjoXAY/u3lXQZ1dHkKYKgxc9NbmHw7Rz9T7VRycqSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334886; c=relaxed/simple;
	bh=C3QhFnHOA++HS5Y4KqI2uJ/Xj05MyqxePuqkHT6lSkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMON+Q5AHj0mC3ojSTlY/OcxZWiGBvwYYDcdjgqa4SUzU0B7v5LIEYSpFdLWbouANy8/SYiWCDDcMTV2FANej+80vhgvt02vFnx/GQTWxua4G4fFrPWFXPPu1taYs6Wb7ojv9NBOsDTjR4mbW+aU5pSEKjba8oXdxncEygbaChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pcKn8+v3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/GfKYWd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pcKn8+v3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/GfKYWd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AE0921182;
	Wed,  5 Nov 2025 09:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eiK/n4EgZp2ORAGmnfzTUx8SD4Z3Zzb4q6XlQaVRjg=;
	b=pcKn8+v3WOaCh6LJf36XqWId7sz0FkZNc9S9M1xluLF49a4ZTDLPmM2FaiFarkOyDtJ6ld
	D75o7kjx+lCzgDN/hpSjyLtB9yeAv4G5npKqzzvHh4EvyCADFRAWR28S4fE1SWZQGk1QV8
	pGYDm+MJT0p4ya4aQiKDkhbfXpgGLQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eiK/n4EgZp2ORAGmnfzTUx8SD4Z3Zzb4q6XlQaVRjg=;
	b=V/GfKYWdyvA3hKkw8/iYaA6f+2rAQ8Axn3PMphVuZwBYDuMz5rj3jJwaODUgQQIKTJ2zkp
	scrSoQdINNac4iCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eiK/n4EgZp2ORAGmnfzTUx8SD4Z3Zzb4q6XlQaVRjg=;
	b=pcKn8+v3WOaCh6LJf36XqWId7sz0FkZNc9S9M1xluLF49a4ZTDLPmM2FaiFarkOyDtJ6ld
	D75o7kjx+lCzgDN/hpSjyLtB9yeAv4G5npKqzzvHh4EvyCADFRAWR28S4fE1SWZQGk1QV8
	pGYDm+MJT0p4ya4aQiKDkhbfXpgGLQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eiK/n4EgZp2ORAGmnfzTUx8SD4Z3Zzb4q6XlQaVRjg=;
	b=V/GfKYWdyvA3hKkw8/iYaA6f+2rAQ8Axn3PMphVuZwBYDuMz5rj3jJwaODUgQQIKTJ2zkp
	scrSoQdINNac4iCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7125F132DD;
	Wed,  5 Nov 2025 09:28:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PUmeG6MYC2kpGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:28:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B95DA083B; Wed,  5 Nov 2025 10:28:03 +0100 (CET)
Date: Wed, 5 Nov 2025 10:28:03 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 17/25] ext4: support large block size in
 ext4_block_write_begin()
Message-ID: <5p7pwuf2zjf7feneef57gvxc2pa46l346igllimpdvvtnrv6v3@js75oockzrgw>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-18-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-18-libaokun@huaweicloud.com>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huaweicloud.com:email,suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -0.30

On Sat 25-10-25 11:22:13, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Use the EXT4_P_TO_LBLK() macro to convert folio indexes to blocks to avoid
> negative left shifts after supporting blocksize greater than PAGE_SIZE.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 73c1da90b604..d97ce88d6e0a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1162,8 +1162,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>  	unsigned block_start, block_end;
>  	sector_t block;
>  	int err = 0;
> -	unsigned blocksize = inode->i_sb->s_blocksize;
> -	unsigned bbits;
> +	unsigned int blocksize = i_blocksize(inode);
>  	struct buffer_head *bh, *head, *wait[2];
>  	int nr_wait = 0;
>  	int i;
> @@ -1172,12 +1171,12 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>  	BUG_ON(!folio_test_locked(folio));
>  	BUG_ON(to > folio_size(folio));
>  	BUG_ON(from > to);
> +	WARN_ON_ONCE(blocksize > folio_size(folio));
>  
>  	head = folio_buffers(folio);
>  	if (!head)
>  		head = create_empty_buffers(folio, blocksize, 0);
> -	bbits = ilog2(blocksize);
> -	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
> +	block = EXT4_P_TO_LBLK(inode, folio->index);
>  
>  	for (bh = head, block_start = 0; bh != head || !block_start;
>  	    block++, block_start = block_end, bh = bh->b_this_page) {
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

