Return-Path: <linux-fsdevel+bounces-46549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C6FA8B576
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C276443AB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB9233739;
	Wed, 16 Apr 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q+yMIUL7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eue1KnD/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q+yMIUL7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eue1KnD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D07224B15
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796044; cv=none; b=A/FL22kinBkwadSrDNRFxAqiLFMQwcWW2BZVMuH00Ra6yPjSJiI8PQp7sB+4sKgPK3aal7o3abXaPNqxiD1VTafhXljwBezkH/sv1yJDNqsKtSh8tTFenasy4FsLpynP1iqTcGSAXY0Z+maZ7FsGe00cZkzZJLrk7RJmuJiZ3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796044; c=relaxed/simple;
	bh=R3i/QkFkxaJFZvsChZeMX0CvXNE9OC4Lcb8iCuapcPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+EIzOw2m+TdDpMvZxkLctVkNCELOMi4UaoaKYTUNwAJKx7rqmivST0zpsGrUpdfX1uy7+hoSvL5iLs7A6s9dDg6vzu1v4l06I/iQ52saKTMVw76QiD6k5ptY15l3FTwQV9oB8BqLzju8zUntTBJqjPmp6U3yNQHFM/f3AL7Soo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q+yMIUL7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eue1KnD/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q+yMIUL7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eue1KnD/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EDF41F445;
	Wed, 16 Apr 2025 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744796041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2RqkhFh3zjAioord6et/QZOcDBsM49nuGROtbOH1d5A=;
	b=Q+yMIUL7ExpF6meXa/ng1JqnKgxk8KGd3nbiAdJnp8Al5g3Pwj8fyTp+I47Pjv8Hx9zxWD
	k7L7ovjd0ANIvYHy+9QSLuW0FRU1/WP+9giCIy/W1bkSfugvxBhrlrVaV9VmOwrWGdL6sn
	vuZJQhfqo+O5u47teb0ZYfANgGOkrLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744796041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2RqkhFh3zjAioord6et/QZOcDBsM49nuGROtbOH1d5A=;
	b=Eue1KnD/UO1IU/FP8ZdilT0mdIPLFlyWjRqQaox2ulkHiQYJS6wKYy4pKkQSeH1oftPVB2
	TYh1GTsZeUiv6mAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744796041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2RqkhFh3zjAioord6et/QZOcDBsM49nuGROtbOH1d5A=;
	b=Q+yMIUL7ExpF6meXa/ng1JqnKgxk8KGd3nbiAdJnp8Al5g3Pwj8fyTp+I47Pjv8Hx9zxWD
	k7L7ovjd0ANIvYHy+9QSLuW0FRU1/WP+9giCIy/W1bkSfugvxBhrlrVaV9VmOwrWGdL6sn
	vuZJQhfqo+O5u47teb0ZYfANgGOkrLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744796041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2RqkhFh3zjAioord6et/QZOcDBsM49nuGROtbOH1d5A=;
	b=Eue1KnD/UO1IU/FP8ZdilT0mdIPLFlyWjRqQaox2ulkHiQYJS6wKYy4pKkQSeH1oftPVB2
	TYh1GTsZeUiv6mAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6940C13976;
	Wed, 16 Apr 2025 09:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CbWwGYl5/2focwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Apr 2025 09:34:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 297C8A0947; Wed, 16 Apr 2025 11:33:53 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:33:53 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, 
	brauner@kernel.org, mcgrof@kernel.org, willy@infradead.org, hare@suse.de, 
	djwong@kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 3/7] fs/buffer: use sleeping version of __find_get_block()
Message-ID: <z6bgilhyxp77u2v75aaw3ep5hzhdrf6jwgeholt74vvkozszrf@m2up5a3q6cx5>
References: <20250415231635.83960-1-dave@stgolabs.net>
 <20250415231635.83960-4-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231635.83960-4-dave@stgolabs.net>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 16:16:31, Davidlohr Bueso wrote:
> Convert to the new nonatomic flavor to benefit from potential performance
> benefits and adapt in the future vs migration such that semantics
> are kept.
> 
> Convert write_boundary_block() which already takes the buffer
> lock as well as bdev_getblk() depending on the respective gpf flags.
> There are no changes in semantics.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 64034638ee2c..f8e63885604b 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -658,7 +658,9 @@ EXPORT_SYMBOL(generic_buffers_fsync);
>  void write_boundary_block(struct block_device *bdev,
>  			sector_t bblock, unsigned blocksize)
>  {
> -	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
> +	struct buffer_head *bh;
> +
> +	bh = __find_get_block_nonatomic(bdev, bblock + 1, blocksize);
>  	if (bh) {
>  		if (buffer_dirty(bh))
>  			write_dirty_buffer(bh, 0);
> @@ -1440,8 +1442,12 @@ EXPORT_SYMBOL(__find_get_block_nonatomic);
>  struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
>  		unsigned size, gfp_t gfp)
>  {
> -	struct buffer_head *bh = __find_get_block(bdev, block, size);
> +	struct buffer_head *bh;
> +
> +	if (gfpflags_allow_blocking(gfp))
> +		bh = __find_get_block_nonatomic(bdev, block, size);
> +	else
> +		bh = __find_get_block(bdev, block, size);
>  
>  	might_alloc(gfp);
>  	if (bh)
> --
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

