Return-Path: <linux-fsdevel+bounces-28844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7490E96F55F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80F41F251D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88E51CEAC9;
	Fri,  6 Sep 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="apLYcQDQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FWDHTDS5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="apLYcQDQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FWDHTDS5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B711CE71E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629436; cv=none; b=kXFdFWjfDb5c0ESj1ZSKpDCAZqKT8wI89JNehujZEg0o0oJPy+fiIGh1GmkQbc+qtt/AvK71Siz+F9JjqQZ4vk5j2L+5AF8NQXM7PveuPn9QB8NzBNtj7i9eM1KkT4NKaP2IouhpF4pzLdU/h9H1+JnWN2+B3WVPfgbKY67tYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629436; c=relaxed/simple;
	bh=qGHRL9CZwJlyDHmx2Re5mp52FIKoue83XYfO9sD13Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok/fqc8MSBxd0p7RXfF5/BGkG8wPfI8DfqjwmeSQ2bHX20GKhbE9YT48Qki6WzLc8UGDJv2P0jwQPAvvnxEb3TPEcg6qFdcrICkIWIMb7YJMyz7VO6SqKNED8xFG3erxIgUqQGzcNI2dNsJuaFrlqYNdJhOHzGW2T38TGZu3gNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=apLYcQDQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FWDHTDS5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=apLYcQDQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FWDHTDS5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B774521A57;
	Fri,  6 Sep 2024 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725629430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKpa2DqlaJExEM8Nhkrlk/E1YK2IvBZi4xJMVAPG++k=;
	b=apLYcQDQkxfk36idGJG69AKpS4oHPG9mOtRhZMNQpaEsMeG1cXOEGmU0J2i8RKQSQNlyVC
	KjZaYr9QIMkbzFxbqPbQaDfFKwS+PJV1vbL6fPjpwVRtt+mEmix2iS383vEFCg4DPmiaDX
	k7OgoOzQZMkYjpM3NwiRqvAh4rw8tnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725629430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKpa2DqlaJExEM8Nhkrlk/E1YK2IvBZi4xJMVAPG++k=;
	b=FWDHTDS5sX/A7B2Q59NkEez1xcv74NP5Hpvp8Ley1XPFxpGm1LkzJgPdVU5GVwBpo66J83
	RcptIfzpzCOrj5Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725629430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKpa2DqlaJExEM8Nhkrlk/E1YK2IvBZi4xJMVAPG++k=;
	b=apLYcQDQkxfk36idGJG69AKpS4oHPG9mOtRhZMNQpaEsMeG1cXOEGmU0J2i8RKQSQNlyVC
	KjZaYr9QIMkbzFxbqPbQaDfFKwS+PJV1vbL6fPjpwVRtt+mEmix2iS383vEFCg4DPmiaDX
	k7OgoOzQZMkYjpM3NwiRqvAh4rw8tnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725629430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKpa2DqlaJExEM8Nhkrlk/E1YK2IvBZi4xJMVAPG++k=;
	b=FWDHTDS5sX/A7B2Q59NkEez1xcv74NP5Hpvp8Ley1XPFxpGm1LkzJgPdVU5GVwBpo66J83
	RcptIfzpzCOrj5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA7A01395F;
	Fri,  6 Sep 2024 13:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZWWbKfYD22ZMJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Sep 2024 13:30:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47A75A0962; Fri,  6 Sep 2024 15:30:15 +0200 (CEST)
Date: Fri, 6 Sep 2024 15:30:15 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] inode: port __I_NEW to var event
Message-ID: <20240906133015.g6rtipl22cajresi@quack3>
References: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
 <20240823-work-i_state-v3-4-5cd5fd207a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-work-i_state-v3-4-5cd5fd207a57@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 23-08-24 14:47:38, Christian Brauner wrote:
> Port the __I_NEW mechanism to use the new var event mechanism.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> I'm not fully convinced that READ_ONCE() in wait_on_inode() is
> sufficient when combined with smp_mb() before wake_up_var(). Maybe we
> need smp_store_release() on inode->i_state before smp_mb() and paired
> with smp_load_acquire() in wait_on_inode().
> ---
>  fs/bcachefs/fs.c          | 10 ++++++----
>  fs/dcache.c               |  7 ++++++-
>  fs/inode.c                | 32 ++++++++++++++++++++++++--------
>  include/linux/writeback.h |  3 ++-
>  4 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 94c392abef65..c0900c0c0f8a 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -1644,14 +1644,16 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
>  				break;
>  			}
>  		} else if (clean_pass && this_pass_clean) {
> -			wait_queue_head_t *wq = bit_waitqueue(&inode->v.i_state, __I_NEW);
> -			DEFINE_WAIT_BIT(wait, &inode->v.i_state, __I_NEW);
> +			struct wait_bit_queue_entry wqe;
> +			struct wait_queue_head *wq_head;
>  
> -			prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> +			wq_head = inode_bit_waitqueue(&wqe, &inode->v, __I_NEW);
> +			prepare_to_wait_event(wq_head, &wqe.wq_entry,
> +					      TASK_UNINTERRUPTIBLE);
>  			mutex_unlock(&c->vfs_inodes_lock);
>  
>  			schedule();
> -			finish_wait(wq, &wait.wq_entry);
> +			finish_wait(wq_head, &wqe.wq_entry);

The opencoded waits are somewhat ugly. I understand this is because of
c->vfs_inodes_lock but perhaps we could introduce wait_on_inode() with some
macro magic (to do what we need before going to sleep) to make it easier?

> diff --git a/fs/inode.c b/fs/inode.c
> index 877c64a1bf63..37f20c7c2f72 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -734,7 +734,13 @@ static void evict(struct inode *inode)
>  	 * used as an indicator whether blocking on it is safe.
>  	 */
>  	spin_lock(&inode->i_lock);
> -	wake_up_bit(&inode->i_state, __I_NEW);
> +	/*
> +	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> +	 * ___wait_var_event() either sees the bit cleared or
> +	 * waitqueue_active() check in wake_up_var() sees the waiter.
> +	 */
> +	smp_mb();

Why did you add smp_mb() here? We wake up on inode state change which has
happened quite some time ago and before several things guaranteeing a
barrier...

> +	inode_wake_up_bit(inode, __I_NEW);
>  	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
>  	spin_unlock(&inode->i_lock);
>  
...
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 56b85841ae4c..8f651bb0a1a5 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -200,7 +200,8 @@ void inode_io_list_del(struct inode *inode);
>  /* writeback.h requires fs.h; it, too, is not included from here. */
>  static inline void wait_on_inode(struct inode *inode)
>  {
> -	wait_on_bit(&inode->i_state, __I_NEW, TASK_UNINTERRUPTIBLE);
> +	wait_var_event(inode_state_wait_address(inode, __I_NEW),
> +		       !(READ_ONCE(inode->i_state) & I_NEW));
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK

As far as memory ordering goes, this looks good to me. But READ_ONCE() is
not really guaranteed to be enough in terms of what inode state you're
going to see when racing with i_state updates. i_state updates would have
to happen through WRITE_ONCE() for this to be safe (wrt insane compiler
deoptimizations ;)). Now that's not a new problem so I'm not sure we need
to deal with it in this patch set but it would probably deserve a comment.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

