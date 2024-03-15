Return-Path: <linux-fsdevel+bounces-14470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E674187CF6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA69B2826A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728053BBCD;
	Fri, 15 Mar 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WXpHXMSc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oqt9Oe2f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DjFv/ALT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZsgD9ASg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777A39AF0;
	Fri, 15 Mar 2024 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514175; cv=none; b=EmY3HJ4Dj6ZHtxXrpQ7h2e/Ui6XKNqDVWjsPX0mVY9t8q/ZxTVF+mO8cn/z11fZIPh8ZaKTWbXApZ3qOkKolzjNl5YJZTlAZfmG6Q2WN0+RUStVKd1hjuim1D40QnhQUb46sKwlFyvMrndhbIafpWqZMeR4quGDXE5h0E/MXFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514175; c=relaxed/simple;
	bh=YGWNw7DlwJSZi5bz7TH4uvbYnp8kdLu2SZMkFNz3pPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdsX9q7aykRQ1YpJw1POg2eAnQ5H4IZ90bTCyBrrmBpYml7D52GiHRXS/ceiPLp/fpYvH7LEz9LmfIMKwhuOkzcU34uPRcvNdGsVmq/+9twI1Gt00rFGYG/tHNJRcuoo5bgRx1ntwxiNoO+cESIJWCM/cCK92kie5cuxl+yCSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WXpHXMSc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oqt9Oe2f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DjFv/ALT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZsgD9ASg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7557421DF0;
	Fri, 15 Mar 2024 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710514172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMqBjYAKWEo2HM7yookHDBHQVa8Pa2/3AbGhly1UNpI=;
	b=WXpHXMScmKe65PK7mwAi16x0ZNTUi+jOV6P6uv6FxMYvqtd4ygm8LgJN949ZLQYPIaEnKR
	wUMLDNLDPxMqGycCKhQSkhZIGC9sOdVzodlRyBnXnrqgsvckuOrCTa2ppX+SyRJrtce7b7
	WUlIddvIsJfegCvlLtr2UZ7NJSpoSKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710514172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMqBjYAKWEo2HM7yookHDBHQVa8Pa2/3AbGhly1UNpI=;
	b=Oqt9Oe2fjf5rUxRRrw9snALsNMedzWpC45EWIIIHw9HQaNdI4XDY37pgClqzP//LEOLGwO
	GoHLR7dEbFv/3ODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710514170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMqBjYAKWEo2HM7yookHDBHQVa8Pa2/3AbGhly1UNpI=;
	b=DjFv/ALTlSCKbxsQG+WJkpoR3Dbw9UDT8Yd9ghMohXFea6h5CXO4LU4EnAofWTSEOB0qAL
	ttFFlWjpOmG2pN2JEIyQRyYcOrW/QDEyRaVcauRXqCSyo5CvTKPkO5D5mhYxLsDWr6cwRe
	vaQneTZ7LjdxekS2CW9veLsf+YqU+kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710514170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMqBjYAKWEo2HM7yookHDBHQVa8Pa2/3AbGhly1UNpI=;
	b=ZsgD9ASgXUidWAOMhiuwHS69VXuDcaJQq9xkW+Px9TyJHGjkZoQhNDvh+yO67GdBxnrQAd
	87Cfq/mz4BLE2gBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6939E13931;
	Fri, 15 Mar 2024 14:49:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a7mvGfpf9GUfRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:49:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0DC9CA07D9; Fri, 15 Mar 2024 15:49:30 +0100 (CET)
Date: Fri, 15 Mar 2024 15:49:30 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 08/19] nilfs2: prevent direct access of
 bd_inode
Message-ID: <20240315144930.x25wdqsd7e5xxm5m@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-9-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-9-yukuai1@huaweicloud.com>
X-Spam-Score: -3.38
X-Spamd-Result: default: False [-3.38 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.58)[98.13%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Thu 22-02-24 20:45:44, Yu Kuai wrote:
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
>  fs/nilfs2/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index aa5290cb7467..2940e8ef88f4 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2790,7 +2790,7 @@ int nilfs_attach_log_writer(struct super_block *sb, struct nilfs_root *root)
>  	if (!nilfs->ns_writer)
>  		return -ENOMEM;
>  
> -	inode_attach_wb(nilfs->ns_bdev->bd_inode, NULL);
> +	inode_attach_wb(file_inode(nilfs->ns_sb->s_bdev_file), NULL);
>  
>  	err = nilfs_segctor_start_thread(nilfs->ns_writer);
>  	if (unlikely(err))
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

