Return-Path: <linux-fsdevel+bounces-28921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA590970FF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 09:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546E9B20E24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67481B0100;
	Mon,  9 Sep 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fkqMdK3p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PTTG0viW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fkqMdK3p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PTTG0viW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939CD1AF4FB
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867353; cv=none; b=YXjXVd6njMeVZMAURk5uM7kiyTvYkLsIH5J+c8ojNNmfvy8hnUNs1uvb57aYZ35t43VtGD6SIjAt4MM3wZmxsfxRk+eNjsa6US+cfNwbrqEzrrGTB6pYu4gS/yL9mkQaXziCw1PDVSTPE7TfISR6QHmqwZ57qTen/J++7i6SxKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867353; c=relaxed/simple;
	bh=AUGZ/nehwMkpWcdcursqLNHDc7HyHvIHCQRPXa1jSYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftXkBvsN3ZEeDcyTpGL84q1+Brm4h23FBmVfuYiREhm21LoQT2VeZ62LXBxOCGvdyDPJb+ll7SxzsPWlGwO+u4kmuyGlz/A0n+cWlv8GBCBUGRCHTY9x7vUhz6oFrS4aekphRn8oYnF6j3qMyW/JfR7QnTj47ibIT0YD//Of7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fkqMdK3p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PTTG0viW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fkqMdK3p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PTTG0viW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C81A91F796;
	Mon,  9 Sep 2024 07:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725867349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjdvzWnFo0sw9Py9keuQCbChIIJcEk0Ik/FVllKA6bs=;
	b=fkqMdK3ptB8FOHQY8erxxlRaaz7ezKDmlBHDvEGdZYO9jQjolKVvFnbILKTWp9LjVw2bBK
	CRwZGKWJDaPGLAOiMiE8lKUzAaL7s/cXAKbYA4XLV16O/ZK+m9YHfrbt1X6aPCMMwfGHU3
	XCoJv5jc3X1Rqwp75k+2CjjKXdxyqIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725867349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjdvzWnFo0sw9Py9keuQCbChIIJcEk0Ik/FVllKA6bs=;
	b=PTTG0viWpzjS+TZwJdR5Qj4dz/80evnsLhUvE7dSETWPqpFPBdOTROkZG7QJVQI9OmE8FG
	HHwtU903S5fwO8AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725867349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjdvzWnFo0sw9Py9keuQCbChIIJcEk0Ik/FVllKA6bs=;
	b=fkqMdK3ptB8FOHQY8erxxlRaaz7ezKDmlBHDvEGdZYO9jQjolKVvFnbILKTWp9LjVw2bBK
	CRwZGKWJDaPGLAOiMiE8lKUzAaL7s/cXAKbYA4XLV16O/ZK+m9YHfrbt1X6aPCMMwfGHU3
	XCoJv5jc3X1Rqwp75k+2CjjKXdxyqIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725867349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjdvzWnFo0sw9Py9keuQCbChIIJcEk0Ik/FVllKA6bs=;
	b=PTTG0viWpzjS+TZwJdR5Qj4dz/80evnsLhUvE7dSETWPqpFPBdOTROkZG7QJVQI9OmE8FG
	HHwtU903S5fwO8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE4F413312;
	Mon,  9 Sep 2024 07:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UuGLKlWl3mayXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Sep 2024 07:35:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 478D3A095F; Mon,  9 Sep 2024 09:35:45 +0200 (CEST)
Date: Mon, 9 Sep 2024 09:35:45 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] inode: make i_state a u32
Message-ID: <20240909073545.7b6z6rh6gawwu3r2@quack3>
References: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
 <20240823-work-i_state-v3-6-5cd5fd207a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-work-i_state-v3-6-5cd5fd207a57@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 23-08-24 14:47:40, Christian Brauner wrote:
> Now that we use the wait var event mechanism make i_state a u32 and free
> up 4 bytes. This means we currently have two 4 byte holes in struct
> inode which we can pack.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f257f8fad7d0..746ac60cef92 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -681,7 +681,8 @@ struct inode {
>  #endif
>  
>  	/* Misc */
> -	unsigned long		i_state;
> +	u32			i_state;
> +	/* 32-bit hole */
>  	struct rw_semaphore	i_rwsem;
>  
>  	unsigned long		dirtied_when;	/* jiffies of first dirtying */
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

