Return-Path: <linux-fsdevel+bounces-67663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF08BC45DAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 644BD347E3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B0A306482;
	Mon, 10 Nov 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9H4zuVK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PaD2TIJH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9H4zuVK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PaD2TIJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A433302144
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769721; cv=none; b=qDG+tDgP/4MaHceePlapS26dg1k+U24h1mQUz6ri05SR5p9yTDjSaLgHT9FKoBdCKNIXAygmL42UK2zarOZURqupJRm/+OKhNwOsSxZY20IcnYmiwvFiZLpXXGcmyxzAnlrXtGU/9YgKDMCJTyW//beTq0dvGnb4r51MPkwcRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769721; c=relaxed/simple;
	bh=5+KpAfE6e5+SNEfojqNpLo+3z5Dm2ls1XvlYKx9dPNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0wcQ017xYzkt5V5XiE4zN1mRyDk2cKJSZyj42tRsgTv3t1h55YTNob2mgX6est93OWeGrvZycLgpWa2VuXU9qsKbBuFfLvVdoVp0OzXYQqHPXa690VkzfQ+Cl9Mq3pyiDL6IBo3jPUbtYMCmHzSMfFl3E0YM/1lGFRBv0olTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9H4zuVK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PaD2TIJH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9H4zuVK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PaD2TIJH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF9F81F397;
	Mon, 10 Nov 2025 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762769717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpAzgZwgaXAMUhdZYvJPS1DCHf4SfTjZHBEO9W1TBJM=;
	b=u9H4zuVKJKqp3iHsc/n18IQlHYpZ1HdzXla8kf7aMlg2Dh7JBq33sb1DChWjLyPjbpCP0J
	XnhcIZWKZtWFGFJXEoZPO6QqlNU2LG3VprK5hev59eaUxkvQnsntOP/vOSwEQI1o+/PNeI
	OrC+b38+TdIKonDzKVauPCeyYcXZiLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762769717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpAzgZwgaXAMUhdZYvJPS1DCHf4SfTjZHBEO9W1TBJM=;
	b=PaD2TIJHgfwMBJzptGA8wKZxnXlghGGcjvppW0dtHQAKC99x05/G8Zie1FN6T6bf9M9bWV
	6RhXxjT7EuksrcAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762769717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpAzgZwgaXAMUhdZYvJPS1DCHf4SfTjZHBEO9W1TBJM=;
	b=u9H4zuVKJKqp3iHsc/n18IQlHYpZ1HdzXla8kf7aMlg2Dh7JBq33sb1DChWjLyPjbpCP0J
	XnhcIZWKZtWFGFJXEoZPO6QqlNU2LG3VprK5hev59eaUxkvQnsntOP/vOSwEQI1o+/PNeI
	OrC+b38+TdIKonDzKVauPCeyYcXZiLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762769717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpAzgZwgaXAMUhdZYvJPS1DCHf4SfTjZHBEO9W1TBJM=;
	b=PaD2TIJHgfwMBJzptGA8wKZxnXlghGGcjvppW0dtHQAKC99x05/G8Zie1FN6T6bf9M9bWV
	6RhXxjT7EuksrcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0C9B14338;
	Mon, 10 Nov 2025 10:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jSwrJzW7EWmLFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 10:15:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B75BA28B1; Mon, 10 Nov 2025 11:15:17 +0100 (CET)
Date: Mon, 10 Nov 2025 11:15:17 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	tytso@mit.edu, torvalds@linux-foundation.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/3] fs: retire now stale MAY_WRITE predicts in
 inode_permission()
Message-ID: <holqxdoanjsu7cnuczcrdmnzd2u73lbc6do4hxupi6nctwrhzp@yrp4dz73tbde>
References: <20251107142149.989998-1-mjguzik@gmail.com>
 <20251107142149.989998-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107142149.989998-4-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri 07-11-25 15:21:49, Mateusz Guzik wrote:
> The primary non-MAY_WRITE consumer now uses lookup_inode_permission_may_exec().
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 6b2a5a5478e7..2a112b2c0951 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -546,7 +546,7 @@ static inline int do_inode_permission(struct mnt_idmap *idmap,
>   */
>  static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
>  {
> -	if (unlikely(mask & MAY_WRITE)) {
> +	if (mask & MAY_WRITE) {
>  		umode_t mode = inode->i_mode;
>  
>  		/* Nobody gets write access to a read-only fs. */
> @@ -577,7 +577,7 @@ int inode_permission(struct mnt_idmap *idmap,
>  	if (unlikely(retval))
>  		return retval;
>  
> -	if (unlikely(mask & MAY_WRITE)) {
> +	if (mask & MAY_WRITE) {
>  		/*
>  		 * Nobody gets write access to an immutable file.
>  		 */
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

