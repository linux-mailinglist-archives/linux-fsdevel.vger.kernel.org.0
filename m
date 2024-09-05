Return-Path: <linux-fsdevel+bounces-28762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0A96DF13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 18:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91BC285C59
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5319EEBF;
	Thu,  5 Sep 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="raQBOqqQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y1aRGPPS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="raQBOqqQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y1aRGPPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809719D89E
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552161; cv=none; b=lQpn6Jza3hjTQ3x5nV5L4CFkWErnzxp1r/0+hmIEcG1lS1iY50kiEzX1z35Sb+ZYtRan4y1ZoMv1F+8flZeXM5Fbj4JcVKoeaORG8XI38ps6yH/IEJOaWJSRIdy579myEYknpy06vm7mrxmODLCcx7adchqaLdPUKJ+oXeTxM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552161; c=relaxed/simple;
	bh=eqs+Pn7niYm2iaO7RaPQ+63BEr+ku7XUuDBdbqf+Zew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKRniYZhCA8wTkimY0kovjiWa2U1MIxitcZG6/SjxIhR4W7GE4u3CjF3VgZXlJ80NI+mVOsTwP+Aq7R3Ft2kWvCRKw+cSNU7mLlt0kX0lIgs8KTIkCgMwpbx9Qk6GvnnpdwNVhU6pwJ/001DqbO+IWR3vh14W/3LCeG+qUHW7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=raQBOqqQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y1aRGPPS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=raQBOqqQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y1aRGPPS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 651731F829;
	Thu,  5 Sep 2024 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725552158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0K+6lAlrdJUGABAtoPEUdjRbMUNkm+8XHawLcm8i7w=;
	b=raQBOqqQwklHKxasLVMHCnqHUHSW+3goajiR8rrYPdE1a3YP4Rz7ncY9uwWD61aiv5EKI7
	gNsZfvQZpjKyB+D1MITme2eTFhJNDHyzLqfm3h3DITvc28rrvRK84uIY5471RM2o1C5Jn0
	CX/Eyf60pims+VC9zRp0nyFnhfi1PP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725552158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0K+6lAlrdJUGABAtoPEUdjRbMUNkm+8XHawLcm8i7w=;
	b=Y1aRGPPSm6VUBNf7hZlrMgmuDRuLvpntG9h6SmAvFurAjaypWioRs/cOmtFPNAAfDtQhjy
	+ZIw7CMpkuSastCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725552158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0K+6lAlrdJUGABAtoPEUdjRbMUNkm+8XHawLcm8i7w=;
	b=raQBOqqQwklHKxasLVMHCnqHUHSW+3goajiR8rrYPdE1a3YP4Rz7ncY9uwWD61aiv5EKI7
	gNsZfvQZpjKyB+D1MITme2eTFhJNDHyzLqfm3h3DITvc28rrvRK84uIY5471RM2o1C5Jn0
	CX/Eyf60pims+VC9zRp0nyFnhfi1PP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725552158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0K+6lAlrdJUGABAtoPEUdjRbMUNkm+8XHawLcm8i7w=;
	b=Y1aRGPPSm6VUBNf7hZlrMgmuDRuLvpntG9h6SmAvFurAjaypWioRs/cOmtFPNAAfDtQhjy
	+ZIw7CMpkuSastCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EC61139D2;
	Thu,  5 Sep 2024 16:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0WxLEx7W2WbPNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Sep 2024 16:02:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EB7F3A096C; Thu,  5 Sep 2024 18:02:33 +0200 (CEST)
Date: Thu, 5 Sep 2024 18:02:33 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] inode: port __I_SYNC to var event
Message-ID: <20240905160233.6nlnpfqt27oyxqva@quack3>
References: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
 <20240823-work-i_state-v3-3-5cd5fd207a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-work-i_state-v3-3-5cd5fd207a57@kernel.org>
X-Spam-Level: 
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
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 23-08-24 14:47:37, Christian Brauner wrote:
> Port the __I_SYNC mechanism to use the new var event mechanism.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 45 +++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 1a5006329f6f..d8bec3c1bb1f 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1386,12 +1386,13 @@ static void requeue_io(struct inode *inode, struct bdi_writeback *wb)
>  
>  static void inode_sync_complete(struct inode *inode)
>  {
> +	assert_spin_locked(&inode->i_lock);
> +
>  	inode->i_state &= ~I_SYNC;
>  	/* If inode is clean an unused, put it into LRU now... */
>  	inode_add_lru(inode);
> -	/* Waiters must see I_SYNC cleared before being woken up */
> -	smp_mb();
> -	wake_up_bit(&inode->i_state, __I_SYNC);
> +	/* Called with inode->i_lock which ensures memory ordering. */
> +	inode_wake_up_bit(inode, __I_SYNC);
>  }
>  
>  static bool inode_dirtied_after(struct inode *inode, unsigned long t)
> @@ -1512,17 +1513,25 @@ static int write_inode(struct inode *inode, struct writeback_control *wbc)
>   */
>  void inode_wait_for_writeback(struct inode *inode)
>  {
> -	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_SYNC);
> -	wait_queue_head_t *wqh;
> +	struct wait_bit_queue_entry wqe;
> +	struct wait_queue_head *wq_head;
> +
> +	assert_spin_locked(&inode->i_lock);
> +
> +	if (!(inode->i_state & I_SYNC))
> +		return;
>  
> -	lockdep_assert_held(&inode->i_lock);
> -	wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
> -	while (inode->i_state & I_SYNC) {
> +	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
> +	for (;;) {
> +		prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
> +		/* Checking I_SYNC with inode->i_lock guarantees memory ordering. */
> +		if (!(inode->i_state & I_SYNC))
> +			break;
>  		spin_unlock(&inode->i_lock);
> -		__wait_on_bit(wqh, &wq, bit_wait,
> -			      TASK_UNINTERRUPTIBLE);
> +		schedule();
>  		spin_lock(&inode->i_lock);
>  	}
> +	finish_wait(wq_head, &wqe.wq_entry);
>  }
>  
>  /*
> @@ -1533,16 +1542,20 @@ void inode_wait_for_writeback(struct inode *inode)
>  static void inode_sleep_on_writeback(struct inode *inode)
>  	__releases(inode->i_lock)
>  {
> -	DEFINE_WAIT(wait);
> -	wait_queue_head_t *wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
> -	int sleep;
> +	struct wait_bit_queue_entry wqe;
> +	struct wait_queue_head *wq_head;
> +	bool sleep;
> +
> +	assert_spin_locked(&inode->i_lock);
>  
> -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> -	sleep = inode->i_state & I_SYNC;
> +	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
> +	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
> +	/* Checking I_SYNC with inode->i_lock guarantees memory ordering. */
> +	sleep = !!(inode->i_state & I_SYNC);
>  	spin_unlock(&inode->i_lock);
>  	if (sleep)
>  		schedule();
> -	finish_wait(wqh, &wait);
> +	finish_wait(wq_head, &wqe.wq_entry);
>  }
>  
>  /*
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

