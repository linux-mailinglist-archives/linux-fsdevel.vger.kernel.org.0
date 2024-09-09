Return-Path: <linux-fsdevel+bounces-28920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827C970FF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 09:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815B5B20D3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 07:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173041B0111;
	Mon,  9 Sep 2024 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ISjBBdds";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DtutjaBZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ISjBBdds";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DtutjaBZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5141AF4F3
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867333; cv=none; b=jqPGsUYgWs6sGDP6/ipfeQiFZ9UmvAF/bZ0frX5VOP34r5YxwqXz+LDmjGsTKnuAEU2xtklhc8J0tb1/dJKtZVHKdpE0iPmavTUb7aPKFcWCZWNEZ+h4EkDVTs/4tDHTxsImcafvXyukQtiehagjQWF7bvyAdlUqlziSjS3vbF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867333; c=relaxed/simple;
	bh=UG6xdJYM+wuwgbj2/OOJIA2oprIS06MFfgCflZNaMEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsHTJu/NyGoYAkql10exdpvYCgdHJEjX0x/i2O7pV5XKIY34nSMSWeUdS3JsQxuHZ2bNtMh6crVlGcVlRKPkZLtNyZiJvQsFKI7cXc3IvT39fwx6d2EC7EUunLmxooICVG2nRNCyEKgciOeqgZAdmM1COtSIDqsytpi0CrAjy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ISjBBdds; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DtutjaBZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ISjBBdds; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DtutjaBZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 081BD1F796;
	Mon,  9 Sep 2024 07:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725867329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnbF3lnH80yJFKoaRIIpJWXOawbrni1R8IAZ5rznYtk=;
	b=ISjBBdds6RMh6Gsak4ocJ4EPWOvWNT5CMIeGZ5yt/x+k1muLzpZfnGw0OO2Pkpflo/ayci
	vdC7cGIz9mFCsFeQweG7bYZwYc/tFWKTxGi07K6aWf6Ju4Ug2NkBjlAfcWSx6LZcBVwhN/
	TgWfA2p23GKtXSPzs0nIZZu/mSHTtYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725867329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnbF3lnH80yJFKoaRIIpJWXOawbrni1R8IAZ5rznYtk=;
	b=DtutjaBZEYBSuGuu62yx5m3q384RyplRyDXdIke9Kdxl2k2jby393jqJV2Vo+P5ROhAgRd
	/Vat+kcWU+1gnXBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ISjBBdds;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DtutjaBZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725867329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnbF3lnH80yJFKoaRIIpJWXOawbrni1R8IAZ5rznYtk=;
	b=ISjBBdds6RMh6Gsak4ocJ4EPWOvWNT5CMIeGZ5yt/x+k1muLzpZfnGw0OO2Pkpflo/ayci
	vdC7cGIz9mFCsFeQweG7bYZwYc/tFWKTxGi07K6aWf6Ju4Ug2NkBjlAfcWSx6LZcBVwhN/
	TgWfA2p23GKtXSPzs0nIZZu/mSHTtYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725867329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnbF3lnH80yJFKoaRIIpJWXOawbrni1R8IAZ5rznYtk=;
	b=DtutjaBZEYBSuGuu62yx5m3q384RyplRyDXdIke9Kdxl2k2jby393jqJV2Vo+P5ROhAgRd
	/Vat+kcWU+1gnXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBF2413312;
	Mon,  9 Sep 2024 07:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QNmUOUCl3maEXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Sep 2024 07:35:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51B7EA095F; Mon,  9 Sep 2024 09:35:24 +0200 (CEST)
Date: Mon, 9 Sep 2024 09:35:24 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] inode: port __I_LRU_ISOLATING to var event
Message-ID: <20240909073524.73ycov2nlyvmbzn5@quack3>
References: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
 <20240823-work-i_state-v3-5-5cd5fd207a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-work-i_state-v3-5-5cd5fd207a57@kernel.org>
X-Rspamd-Queue-Id: 081BD1F796
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 23-08-24 14:47:39, Christian Brauner wrote:
> Port the __I_LRU_ISOLATING mechanism to use the new var event mechanism.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 37f20c7c2f72..8fb8e4f9acc3 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -511,24 +511,35 @@ static void inode_unpin_lru_isolating(struct inode *inode)
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
>  	inode->i_state &= ~I_LRU_ISOLATING;
> -	smp_mb();
> -	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
> +	/* Called with inode->i_lock which ensures memory ordering. */
> +	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
>  	spin_unlock(&inode->i_lock);
>  }
>  
>  static void inode_wait_for_lru_isolating(struct inode *inode)
>  {
> +	struct wait_bit_queue_entry wqe;
> +	struct wait_queue_head *wq_head;
> +
>  	lockdep_assert_held(&inode->i_lock);
> -	if (inode->i_state & I_LRU_ISOLATING) {
> -		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
> -		wait_queue_head_t *wqh;
> +	if (!(inode->i_state & I_LRU_ISOLATING))
> +		return;
>  
> -		wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
> +	wq_head = inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
> +	for (;;) {
> +		prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
> +		/*
> +		 * Checking I_LRU_ISOLATING with inode->i_lock guarantees
> +		 * memory ordering.
> +		 */
> +		if (!(inode->i_state & I_LRU_ISOLATING))
> +			break;
>  		spin_unlock(&inode->i_lock);
> -		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
> +		schedule();
>  		spin_lock(&inode->i_lock);
> -		WARN_ON(inode->i_state & I_LRU_ISOLATING);
>  	}
> +	finish_wait(wq_head, &wqe.wq_entry);
> +	WARN_ON(inode->i_state & I_LRU_ISOLATING);
>  }
>  
>  /**
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

