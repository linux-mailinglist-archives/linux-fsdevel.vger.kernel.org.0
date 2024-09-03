Return-Path: <linux-fsdevel+bounces-28380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494B0969F66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A914DB21843
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708991CA6BF;
	Tue,  3 Sep 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IpsuWSih";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yWo7RPf2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IpsuWSih";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yWo7RPf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAFA1CA699
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371459; cv=none; b=DrszbUBQUjF0+v2Aq7VJaSU3z5P/37K1bpmNDOyxUQ+SutAL+8iLfV7ns/JaCNQDS44HXhNkVz4BJVyk5oKtoJ3poIkDjnZPuntiY5RlndAGf87EA7Fza1nkpEGfDi7PHBmYgISxV5ilqnkvNKxhj7k4EYCbddTTMot30fzGq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371459; c=relaxed/simple;
	bh=WDpcqd/qFK/gpnnOfVtSs+1oFWx0b64HqN7GXeiknrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5coH1djnx1RFfdw5sDBqv+UdQVUw7gGPykzaWc2/7p0ro1DVCDeEgJsqZ+T02coBldICeT9FmEuNls8roOu0RFhD6NkxF1mbSpmmJbjUog6cC2kIeSjRzxUPdpvXiVJyeV9xLNuKdczFPm6RkMDrObrmtFXAXzLAxQhtOVqobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IpsuWSih; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yWo7RPf2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IpsuWSih; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yWo7RPf2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58C8921A79;
	Tue,  3 Sep 2024 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725371456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X9xko/RFFAgDJLBOnQpRzowZ7s8BT7oQboitDAKgDGU=;
	b=IpsuWSihJhENFFLqycWJUf9/ci2v2+kMgB3MyoOvPGBtr6G6H38JcF/nIqWlQcRHBUX9YP
	QH8LuJavJFDuRJ7cppLwCztmxkS3caZMH04hYdQjaYFayRdKrRhpJ3GdXRrgkB8D7vxMWk
	3XWaZ2xmeIYstMR4ai3YdGFkDZWWt1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725371456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X9xko/RFFAgDJLBOnQpRzowZ7s8BT7oQboitDAKgDGU=;
	b=yWo7RPf2uGOITLoKDRkTPq80nt3kswOrq5A+fMLERQzZ/YC1aaTwUN7VyOm3mRgy9aotd9
	DNCEzVyWHOreHjAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IpsuWSih;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yWo7RPf2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725371456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X9xko/RFFAgDJLBOnQpRzowZ7s8BT7oQboitDAKgDGU=;
	b=IpsuWSihJhENFFLqycWJUf9/ci2v2+kMgB3MyoOvPGBtr6G6H38JcF/nIqWlQcRHBUX9YP
	QH8LuJavJFDuRJ7cppLwCztmxkS3caZMH04hYdQjaYFayRdKrRhpJ3GdXRrgkB8D7vxMWk
	3XWaZ2xmeIYstMR4ai3YdGFkDZWWt1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725371456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X9xko/RFFAgDJLBOnQpRzowZ7s8BT7oQboitDAKgDGU=;
	b=yWo7RPf2uGOITLoKDRkTPq80nt3kswOrq5A+fMLERQzZ/YC1aaTwUN7VyOm3mRgy9aotd9
	DNCEzVyWHOreHjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CA2413A52;
	Tue,  3 Sep 2024 13:50:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8U6vEkAU12bMTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 13:50:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E8EDBA096C; Tue,  3 Sep 2024 15:50:55 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:50:55 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 18/20] fs: add f_pipe
Message-ID: <20240903135055.jhcusfiopheb2jej@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-18-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-18-6d3e4816aa7b@kernel.org>
X-Rspamd-Queue-Id: 58C8921A79
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 30-08-24 15:04:59, Christian Brauner wrote:
> Only regular files with FMODE_ATOMIC_POS and directories need
> f_pos_lock. Place a new f_pipe member in a union with f_pos_lock
> that they can use and make them stop abusing f_version in follow-up
> patches.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

What makes me a bit uneasy is that we do mutex_init() on the space in
struct file and then pipe_open() will clobber it. And then we eventually
call mutex_destroy() on the clobbered mutex. I think so far this does no
harm but mostly by luck. I think we need to make sure that when f_pos_lock
is unused, we don't even call mutex_init() / mutex_destroy() on it.

								Honza

> ---
>  include/linux/fs.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3e6b3c1afb31..ca4925008244 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1001,6 +1001,7 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
>   * @f_cred: stashed credentials of creator/opener
>   * @f_path: path of the file
>   * @f_pos_lock: lock protecting file position
> + * @f_pipe: specific to pipes
>   * @f_pos: file position
>   * @f_version: file version
>   * @f_security: LSM security context of this file
> @@ -1026,7 +1027,12 @@ struct file {
>  	const struct cred		*f_cred;
>  	/* --- cacheline 1 boundary (64 bytes) --- */
>  	struct path			f_path;
> -	struct mutex			f_pos_lock;
> +	union {
> +		/* regular files (with FMODE_ATOMIC_POS) and directories */
> +		struct mutex		f_pos_lock;
> +		/* pipes */
> +		u64			f_pipe;
> +	};
>  	loff_t				f_pos;
>  	u64				f_version;
>  	/* --- cacheline 2 boundary (128 bytes) --- */
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

