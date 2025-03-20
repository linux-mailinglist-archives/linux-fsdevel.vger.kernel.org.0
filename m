Return-Path: <linux-fsdevel+bounces-44550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A2A6A46B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9C7188E7B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451721C9EB;
	Thu, 20 Mar 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PvaMv0vs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GmnoHAVl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RQlRniVu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhhviTKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E7189F36
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468711; cv=none; b=QN5CJCwwYSEL/z/czkJjVuXAgDmAA8Sr81cJzwUYqPk6+3SfRAydL4MK2r0f+9Z9Bf3WAujzeMQylUEm6dDuuKjFIfhn0mDeyDnf5Tg1PlHwafEfFHaSVL2JDkUIXPNAD7Yry559JcsCKDFzx1n35yTK/0hdY5L6A4j8N9UUgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468711; c=relaxed/simple;
	bh=5KWvagOOXcxGkyUO5EiupSEY+fQdUPcWIo3cM5e/0Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKPkiHi0lsMVhJH9/5HRKS2Z8sqWPCZ1CXtriRbYmuPQffHaA3Hmu1mwB+PS8jSGuceBDn5rt/NKXlLged+ho2rLREL2ZToER1Du5dQmBzh8YmvvAoZpSO7e/IDl+QmFXnY1PFFpAmB2eTtOWtSCegSfdj0zz1bRlNmw9cjWUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PvaMv0vs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GmnoHAVl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RQlRniVu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhhviTKF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D44CC21F1F;
	Thu, 20 Mar 2025 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742468708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L6Su+b3PqwfdpqEvxSL+YC7Wa7Qp2i8hB73twg6itPU=;
	b=PvaMv0vsn66Eeqb6rVJt7Ex5+oW99zn0bYTmr7cMTiojW5ncJ2Odp+n+I5VajilXZn69ch
	oL5r8iMYiF8QTM+GR7etg7DgwlOTtW8E1QzG3/mScOIAz+bpOkMwpCGFZKxY4aBOtArnvg
	MdkBPahNoVnkx9pTpq1GVZ4qixjsYIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742468708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L6Su+b3PqwfdpqEvxSL+YC7Wa7Qp2i8hB73twg6itPU=;
	b=GmnoHAVlacNsLKk/hrNfGF4KYqnvdYNnxdRKQNnBT3oL4cZu2pZP26Aw2YdmRqcpIX0yus
	wOzs1esuRr3HxMDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742468707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L6Su+b3PqwfdpqEvxSL+YC7Wa7Qp2i8hB73twg6itPU=;
	b=RQlRniVu9L1M0Q0dbgy4Gd7ZUtGAxzaI14cGo08/PKlFwZEAikl0J10RHwsPMKWpjlQLuE
	ueUCz5XfmPdzQkHlO5aDcVvBd0zT5JVywNZA1YrjgLbvHlN5sV2Emu4ETLSRH/aKyR8JMX
	/ObNypsSCeeTORbCg+nMILtVi4V+87w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742468707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L6Su+b3PqwfdpqEvxSL+YC7Wa7Qp2i8hB73twg6itPU=;
	b=nhhviTKF+Qw1OicGhCLH7mllfrDUT3Ws3f5yHLJhMUIB9vB7uVm1gEQcj7e0oJp91/1SMP
	NKgNGBiUSbuifNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAEF3139D2;
	Thu, 20 Mar 2025 11:05:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id komFMWP222fpGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 20 Mar 2025 11:05:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A28EA07B2; Thu, 20 Mar 2025 12:05:03 +0100 (CET)
Date: Thu, 20 Mar 2025 12:05:03 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: call inode_sb_list_add() outside of inode hash
 lock
Message-ID: <g57h2fwia2mefxiawafzlgaximj6i75aj2blglciuxzsc65mve@kvnh7fl2cwpz>
References: <20250320004643.1903287-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320004643.1903287-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 20-03-25 01:46:43, Mateusz Guzik wrote:
> As both locks are highly contended during significant inode churn,
> holding the inode hash lock while waiting for the sb list lock
> exacerbates the problem.
> 
> Why moving it out is safe: the inode at hand still has I_NEW set and
> anyone who finds it through legitimate means waits for the bit to clear,
> by which time inode_sb_list_add() is guaranteed to have finished.
> 
> This significantly drops hash lock contention for me when stating 20
> separate trees in parallel, each with 1000 directories * 1000 files.
> 
> However, no speed up was observed as contention increased on the other
> locks, notably dentry LRU.
> 
> Even so, removal of the lock ordering will help making this faster
> later.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

I agree I_NEW will be protecting the inode from being looked up through the
hash while we drop inode_hash_lock so this is safe. I'm usually a bit
reluctant to performance "improvements" that actually don't bring a
measurable benefit but this patch looks like a no-brainer (I'm not getting
worried about added complexity :)) and at least it reduces contention on
inode_hash_lock so I agree the potential is there. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> There were ideas about using bitlocks, which ran into trouble because of
> spinlocks being taken *after* and RT kernel not liking that.
> 
> I'm thinking thanks to RCU this very much can be hacked around to
> reverse the hash-specific lock -> inode lock: you find the inode you
> are looking for, lock it and only then take the bitlock and validate it
> remained in place.
> 
> The above patch removes an impediment -- the only other lock possibly
> taken with the hash thing.
> 
> Even if the above idea does not pan out, the patch has some value in
> decoupling these.
> 
> I am however not going to strongly argue for it given lack of results.
> 
>  fs/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index e188bb1eb07a..8efd38c27321 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1307,8 +1307,8 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  	}
>  
>  	if (set && unlikely(set(inode, data))) {
> -		inode = NULL;
> -		goto unlock;
> +		spin_unlock(&inode_hash_lock);
> +		return NULL;
>  	}
>  
>  	/*
> @@ -1320,14 +1320,14 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  	hlist_add_head_rcu(&inode->i_hash, head);
>  	spin_unlock(&inode->i_lock);
>  
> +	spin_unlock(&inode_hash_lock);
> +
>  	/*
>  	 * Add inode to the sb list if it's not already. It has I_NEW at this
>  	 * point, so it should be safe to test i_sb_list locklessly.
>  	 */
>  	if (list_empty(&inode->i_sb_list))
>  		inode_sb_list_add(inode);
> -unlock:
> -	spin_unlock(&inode_hash_lock);
>  
>  	return inode;
>  }
> @@ -1456,8 +1456,8 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  			inode->i_state = I_NEW;
>  			hlist_add_head_rcu(&inode->i_hash, head);
>  			spin_unlock(&inode->i_lock);
> -			inode_sb_list_add(inode);
>  			spin_unlock(&inode_hash_lock);
> +			inode_sb_list_add(inode);
>  
>  			/* Return the locked inode with I_NEW set, the
>  			 * caller is responsible for filling in the contents
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

