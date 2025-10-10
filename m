Return-Path: <linux-fsdevel+bounces-63760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C3BCD53B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0314189419C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B412F1FFE;
	Fri, 10 Oct 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qyjV93bF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXIPxXvm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qyjV93bF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXIPxXvm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5B2F0693
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104056; cv=none; b=XFSWwVawxW789fbypJIwtdp3z4bBrVhQY4q1FKM5DjfbaOXEx883atzsW/ooeIjAxybGGmDtK1cknPE7DCyTNPBjlZ64Yr++DctKXbwRsBBBu9SPoYgH/33ykX7AczdCu4SjKxPU3krzxuBqjaNXw79D4PW/sYc4gcdL6WgJ+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104056; c=relaxed/simple;
	bh=cL1HPOXOoRQqAW+trFcBYQam/s1EVUwH+wJ87rh29Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExOHk/cIXruRhwDKI6p+OmR9PvjpCEyWXWSIv6p+kMGAVetEuYU4F9HY0Q0NKJCTef+l1WyAJ0L9QhGVBEaP59rE3vSkGvU0M4OWtdv2XA0kXZsy3bEVZLSAw+Oo++KjikADM5Ykoo5Mg9X3njFljfRoOp//8LJvlA8+kD0iRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qyjV93bF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FXIPxXvm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qyjV93bF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FXIPxXvm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1CA421F2A;
	Fri, 10 Oct 2025 13:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760104051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sufIZEkjBSCUUgqxs7dtAgeGm55696GDPH5Hgw3fgYQ=;
	b=qyjV93bFgQlwTMgKr4frsx/E5m1C2OSypShgH0rutvL7HIHgQFW3OubC0Lzr+N7EbpVufZ
	uf8qu3WuMkB7Iq1lcLfEV9dB6SkvrtXDtWA4aPum7pnPDOInwdUDqwGnbD4KnQgKZ7RpFQ
	vZ1Nzn2NOCm/WzpQSvpKBw7eiik/cN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760104051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sufIZEkjBSCUUgqxs7dtAgeGm55696GDPH5Hgw3fgYQ=;
	b=FXIPxXvmgwWYErOpREz6leTDKWtSeZ42OMsEq1KUQAir39bv0T10EQFd2QegDpW/3hFVUG
	d0ctEbF/QuROzuBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qyjV93bF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FXIPxXvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760104051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sufIZEkjBSCUUgqxs7dtAgeGm55696GDPH5Hgw3fgYQ=;
	b=qyjV93bFgQlwTMgKr4frsx/E5m1C2OSypShgH0rutvL7HIHgQFW3OubC0Lzr+N7EbpVufZ
	uf8qu3WuMkB7Iq1lcLfEV9dB6SkvrtXDtWA4aPum7pnPDOInwdUDqwGnbD4KnQgKZ7RpFQ
	vZ1Nzn2NOCm/WzpQSvpKBw7eiik/cN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760104051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sufIZEkjBSCUUgqxs7dtAgeGm55696GDPH5Hgw3fgYQ=;
	b=FXIPxXvmgwWYErOpREz6leTDKWtSeZ42OMsEq1KUQAir39bv0T10EQFd2QegDpW/3hFVUG
	d0ctEbF/QuROzuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E9DE1375D;
	Fri, 10 Oct 2025 13:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K4nJInMO6WivbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 13:47:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5EADA0A58; Fri, 10 Oct 2025 15:47:30 +0200 (CEST)
Date: Fri, 10 Oct 2025 15:47:30 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 01/14] fs: move wait_on_inode() from writeback.h to
 fs.h
Message-ID: <ftmhmoslzb6h3z2w4fuumvqcwmis5xeqep5nlgbhdklrcwzok4@re6ar7llo7ol>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-2-mjguzik@gmail.com>
X-Rspamd-Queue-Id: B1CA421F2A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 09-10-25 09:59:15, Mateusz Guzik wrote:
> The only consumer outside of fs/inode.c is gfs2 and it already includes
> fs.h in the relevant file.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Fair. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h        | 10 ++++++++++
>  include/linux/writeback.h | 11 -----------
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ac62b9d10b00..b35014ba681b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -949,6 +949,16 @@ static inline void inode_fake_hash(struct inode *inode)
>  	hlist_add_fake(&inode->i_hash);
>  }
>  
> +static inline void wait_on_inode(struct inode *inode)
> +{
> +	wait_var_event(inode_state_wait_address(inode, __I_NEW),
> +		       !(READ_ONCE(inode->i_state) & I_NEW));
> +	/*
> +	 * Pairs with routines clearing I_NEW.
> +	 */
> +	smp_rmb();
> +}
> +
>  /*
>   * inode->i_rwsem nesting subclasses for the lock validator:
>   *
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index e1e1231a6830..06195c2a535b 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -189,17 +189,6 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
>  void inode_wait_for_writeback(struct inode *inode);
>  void inode_io_list_del(struct inode *inode);
>  
> -/* writeback.h requires fs.h; it, too, is not included from here. */
> -static inline void wait_on_inode(struct inode *inode)
> -{
> -	wait_var_event(inode_state_wait_address(inode, __I_NEW),
> -		       !(READ_ONCE(inode->i_state) & I_NEW));
> -	/*
> -	 * Pairs with routines clearing I_NEW.
> -	 */
> -	smp_rmb();
> -}
> -
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  
>  #include <linux/cgroup.h>
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

