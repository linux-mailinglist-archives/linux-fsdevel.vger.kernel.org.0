Return-Path: <linux-fsdevel+bounces-28760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7F96DF11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 18:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E370E287307
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E534919E82C;
	Thu,  5 Sep 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sBHTm0va";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZFaLgYCt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wKfZ/GSz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1QejXxXg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92D19D897
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552118; cv=none; b=BecQX7Q02ec30AsERLE9JuXkpwGH8OnT7k5WZ0mEd8i2YpMqsfnS693jBAVsi5oEsi2ioyknoUHACiaNEagy5ph/2AkFkqjKkdxo4TCygunZj6llexPJAqYHuNF0JFrn91HrYwrBbkw4DIOspZmJOv5j2fM+VWC8YxchkXi6rgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552118; c=relaxed/simple;
	bh=K+JPnJdD3aglksfai8hR7cZbe9Ee8TelDfPAvduKcH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaRUTKrp/Sbba3/xrltYUilrdtVhI2ZmFUNOsRB3nDOaHxjFn9EnOFb0Lwq973Iph5c34jy/tb+Qj889B6wfvvhC9NhbXfVIcM6x7CtocWe/kWGEHuQ9xq2d6pQiWYXXXpvtZiK1SM4DdDkF/8R4QOXikZMGP7Xt1y5d55vTDqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sBHTm0va; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZFaLgYCt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wKfZ/GSz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1QejXxXg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8737C1F828;
	Thu,  5 Sep 2024 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725552114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZlR3ZNU8tukjTCsJIeH0tI1Rras2/49KmhL/JAuL6Q=;
	b=sBHTm0vaa+RFpHBJBhN4ZDANIuEVwbXkKmE5BBjhFUw94OOg4T5j35dAn3O1rfJObO8ALK
	SGNphsce8aPdPX56G9QX2qLfyQ4Brx2gb79itPgbnxdvYpDb6AJb+B58vgIaJ4ODhzgDrM
	+XzvxIiO0r234SkiA2GHLhdMieul5y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725552114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZlR3ZNU8tukjTCsJIeH0tI1Rras2/49KmhL/JAuL6Q=;
	b=ZFaLgYCtiPcnshactxHiIheb1mSkbS+HAhpgxkN7orOkntfCB7bwadE4dVQWqZmiqjEztu
	vf/6MIltv2BMdNBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725552113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZlR3ZNU8tukjTCsJIeH0tI1Rras2/49KmhL/JAuL6Q=;
	b=wKfZ/GSzrFflx6a9Teht5oQvpOje/JlqXczQNhyHZ7Wx7Plvj1erV1WSvvbWHRhgC66Ggp
	aylQn9uVR0gHgaAayOu3SYRyZAVya0//f+Y44KBBaVSiGsnyIV9s7AGR2uH/fmB178jCsR
	8exZ7V+cRkCdXK2dTJ8KgPMo70ifl0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725552113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZlR3ZNU8tukjTCsJIeH0tI1Rras2/49KmhL/JAuL6Q=;
	b=1QejXxXgR0rZCHrG4svLuEjOn/fznrAYeKKt3I2qPtbg+GIVT9txGtmH+k3t2rU7Ioks1W
	vw6XBatjRdRgv2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C8B8139D2;
	Thu,  5 Sep 2024 16:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LIBiHvHV2WaYNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Sep 2024 16:01:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 041D5A0968; Thu,  5 Sep 2024 18:01:44 +0200 (CEST)
Date: Thu, 5 Sep 2024 18:01:44 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] fs: add i_state helpers
Message-ID: <20240905160144.w5evqmfzztdxedba@quack3>
References: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
 <20240823-work-i_state-v3-1-5cd5fd207a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-work-i_state-v3-1-5cd5fd207a57@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 23-08-24 14:47:35, Christian Brauner wrote:
> The i_state member is an unsigned long so that it can be used with the
> wait bit infrastructure which expects unsigned long. This wastes 4 bytes
> which we're unlikely to ever use. Switch to using the var event wait
> mechanism using the address of the bit. Thanks to Linus for the address
> idea.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Interesting trick with the wakeup address. I'm not sure we
100% need it since e.g. __I_NEW waiters are unlikely to combine with
__I_SYNC waiters so sharing a waitqueue should not cause big issues but I
guess we'll deal with that if we run out of waiting bits with the current
scheme. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c         | 11 +++++++++++
>  include/linux/fs.h | 15 +++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 154f8689457f..877c64a1bf63 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -472,6 +472,17 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  		inode->i_state |= I_REFERENCED;
>  }
>  
> +struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
> +					    struct inode *inode, u32 bit)
> +{
> +        void *bit_address;
> +
> +        bit_address = inode_state_wait_address(inode, bit);
> +        init_wait_var_entry(wqe, bit_address, 0);
> +        return __var_waitqueue(bit_address);
> +}
> +EXPORT_SYMBOL(inode_bit_waitqueue);
> +
>  /*
>   * Add inode to LRU if needed (inode is unused and clean).
>   *
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 23e7d46b818a..1d895b8cb801 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -744,6 +744,21 @@ struct inode {
>  	void			*i_private; /* fs or device private pointer */
>  } __randomize_layout;
>  
> +/*
> + * Get bit address from inode->i_state to use with wait_var_event()
> + * infrastructre.
> + */
> +#define inode_state_wait_address(inode, bit) ((char *)&(inode)->i_state + (bit))
> +
> +struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
> +					    struct inode *inode, u32 bit);
> +
> +static inline void inode_wake_up_bit(struct inode *inode, u32 bit)
> +{
> +	/* Caller is responsible for correct memory barriers. */
> +	wake_up_var(inode_state_wait_address(inode, bit));
> +}
> +
>  struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
>  
>  static inline unsigned int i_blocksize(const struct inode *node)
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

