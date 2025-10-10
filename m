Return-Path: <linux-fsdevel+bounces-63762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF46BCD574
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ACB64EEC44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBA92F5322;
	Fri, 10 Oct 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dH1wNwIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rB+dXcqJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dH1wNwIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rB+dXcqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38362F39C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104278; cv=none; b=Z4+6Qhhl6kOXKdH+KKCRsrvakYfBT4thzy+bObVrxbGmAWFRiLPUh3HyT/3+rop4yCd9x4ohir9eXO+X+AII8g66pSlwUscL1OHVXh8BX1gCC5MTDT5VSguH0OD6zIQ1umZ+ieL9LWmqAAOxujSnFOa3l6amQJQUQkQztnb9gpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104278; c=relaxed/simple;
	bh=kLOYx7mvSD4OhJMI48Ie5SbNy4L1Q8JyqS1C2Xt/0sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQH3lYPXaVwdWZFzKhDRnF5fUmxKRJULBVlS8tx59H/sETmRwYJ5wy+IY8FkVcv7gXWA0rplf22ixPsl55k9yehHO+bgnnaXlTVdQHweq7GAcfezDDFAXDfWdl7qChdyF7fSK9dgyjAyyfyFnjh9wfSm9z0tBOjwZlrwYusH/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dH1wNwIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rB+dXcqJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dH1wNwIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rB+dXcqJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FE6C21E34;
	Fri, 10 Oct 2025 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760104274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oc7zNVBk9znrZMMuWx7wLNfpWlmazUj9pruoqQp/lSw=;
	b=dH1wNwIW3KkrRXmWyCpajz6djefEvby178ge5dEMZ2FoC7MaLDdsar5eOV+TaXUyRn/GBA
	3ie96x/jgdxa4TnbeHQU60sUNa8917YpfCO3odQ9IIVeR3WMQt5lvc77pPFfnVCx83SyNK
	J1KWwag+4tUQH070zk9RwdEWPoBuQ8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760104274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oc7zNVBk9znrZMMuWx7wLNfpWlmazUj9pruoqQp/lSw=;
	b=rB+dXcqJiIrwr/UHTB8XVnxfXa5upZhkQBCjh3TPisS2Cs/aGr9IKtKLnmnVpYzUWWDDL7
	HO6kyFNExmtGKfAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dH1wNwIW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rB+dXcqJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760104274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oc7zNVBk9znrZMMuWx7wLNfpWlmazUj9pruoqQp/lSw=;
	b=dH1wNwIW3KkrRXmWyCpajz6djefEvby178ge5dEMZ2FoC7MaLDdsar5eOV+TaXUyRn/GBA
	3ie96x/jgdxa4TnbeHQU60sUNa8917YpfCO3odQ9IIVeR3WMQt5lvc77pPFfnVCx83SyNK
	J1KWwag+4tUQH070zk9RwdEWPoBuQ8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760104274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oc7zNVBk9znrZMMuWx7wLNfpWlmazUj9pruoqQp/lSw=;
	b=rB+dXcqJiIrwr/UHTB8XVnxfXa5upZhkQBCjh3TPisS2Cs/aGr9IKtKLnmnVpYzUWWDDL7
	HO6kyFNExmtGKfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1177D1375D;
	Fri, 10 Oct 2025 13:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 649CBFIP6WhBcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 13:51:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C90FA0A58; Fri, 10 Oct 2025 15:51:09 +0200 (CEST)
Date: Fri, 10 Oct 2025 15:51:09 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 03/14] fs: provide accessors for ->i_state
Message-ID: <4itnp2mhltszp24yilxqut6b3iyjya4vpdervtaojrpcwhncos@y7s4hzbfdtf4>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-4-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 1FE6C21E34
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 09-10-25 09:59:17, Mateusz Guzik wrote:
> Open-coded accesses prevent asserting they are done correctly. One
> obvious aspect is locking, but significantly more can checked. For
> example it can be detected when the code is clearing flags which are
> already missing, or is setting flags when it is illegal (e.g., I_FREEING
> when ->i_count > 0).
> 
> In order to keep things manageable this patchset merely gets the thing
> off the ground with only lockdep checks baked in.
> 
> Current consumers can be trivially converted.
> 
> Suppose flags I_A and I_B are to be handled.
> 
> If ->i_lock is held, then:
> 
> state = inode->i_state  	=> state = inode_state_read(inode)
> inode->i_state |= (I_A | I_B) 	=> inode_state_set(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear(inode, I_A | I_B)
> inode->i_state = I_A | I_B	=> inode_state_assign(inode, I_A | I_B)
> 
> If ->i_lock is not held or only held conditionally:
> 
> state = inode->i_state  	=> state = inode_state_read_once(inode)
> inode->i_state |= (I_A | I_B) 	=> inode_state_set_raw(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B) 	=> inode_state_clear_raw(inode, I_A | I_B)
> inode->i_state = I_A | I_B	=> inode_state_assign_raw(inode, I_A | I_B)
> 
> The "_once" vs "_raw" discrepancy stems from the read variant differing
> by READ_ONCE as opposed to just lockdep checks.
> 
> Finally, if you want to atomically clear flags and set new ones, the
> following:
> 
> state = inode->i_state;
> state &= ~I_A;
> state |= I_B;
> inode->i_state = state;
> 
> turns into:
> 
> inode_state_replace(inode, I_A, I_B);
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 78 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b35014ba681b..909eb1e68637 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -759,7 +759,7 @@ enum inode_state_bits {
>  	/* reserved wait address bit 3 */
>  };
>  
> -enum inode_state_flags_t {
> +enum inode_state_flags_enum {
>  	I_NEW			= (1U << __I_NEW),
>  	I_SYNC			= (1U << __I_SYNC),
>  	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
> @@ -843,7 +843,7 @@ struct inode {
>  #endif
>  
>  	/* Misc */
> -	enum inode_state_flags_t	i_state;
> +	enum inode_state_flags_enum i_state;
>  	/* 32-bit hole */
>  	struct rw_semaphore	i_rwsem;
>  
> @@ -902,6 +902,80 @@ struct inode {
>  	void			*i_private; /* fs or device private pointer */
>  } __randomize_layout;
>  
> +/*
> + * i_state handling
> + *
> + * We hide all of it behind helpers so that we can validate consumers.
> + */
> +static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
> +{
> +	return READ_ONCE(inode->i_state);
> +}
> +
> +static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +	return inode->i_state;
> +}
> +
> +static inline void inode_state_set_raw(struct inode *inode,
> +				       enum inode_state_flags_enum flags)
> +{
> +	WRITE_ONCE(inode->i_state, inode->i_state | flags);
> +}
> +
> +static inline void inode_state_set(struct inode *inode,
> +				   enum inode_state_flags_enum flags)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +	inode_state_set_raw(inode, flags);
> +}
> +
> +static inline void inode_state_clear_raw(struct inode *inode,
> +					 enum inode_state_flags_enum flags)
> +{
> +	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
> +}
> +
> +static inline void inode_state_clear(struct inode *inode,
> +				     enum inode_state_flags_enum flags)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +	inode_state_clear_raw(inode, flags);
> +}
> +
> +static inline void inode_state_assign_raw(struct inode *inode,
> +					  enum inode_state_flags_enum flags)
> +{
> +	WRITE_ONCE(inode->i_state, flags);
> +}
> +
> +static inline void inode_state_assign(struct inode *inode,
> +				      enum inode_state_flags_enum flags)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +	inode_state_assign_raw(inode, flags);
> +}
> +
> +static inline void inode_state_replace_raw(struct inode *inode,
> +					   enum inode_state_flags_enum clearflags,
> +					   enum inode_state_flags_enum setflags)
> +{
> +	enum inode_state_flags_enum flags;
> +	flags = inode->i_state;
> +	flags &= ~clearflags;
> +	flags |= setflags;
> +	inode_state_assign_raw(inode, flags);
> +}
> +
> +static inline void inode_state_replace(struct inode *inode,
> +				       enum inode_state_flags_enum clearflags,
> +				       enum inode_state_flags_enum setflags)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +	inode_state_replace_raw(inode, clearflags, setflags);
> +}
> +
>  static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
>  {
>  	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

