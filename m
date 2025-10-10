Return-Path: <linux-fsdevel+bounces-63777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654A9BCD979
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE8B1A622F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347252F6585;
	Fri, 10 Oct 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rEOGc2QG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k8Bd1OmN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rEOGc2QG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k8Bd1OmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64AE2F49EA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107465; cv=none; b=eLyzxUfqjwgLJwhXJOXUJMX6EDr8U9w5nMIwgAFaN9X1151FiizdbEIVNU6ZNEW7fNuHpNE+ow9vFeDZ5MFfl1WzpBfnPPI2/OEZgkYulEDnIxf2ApniAi71w3tKsQqF9ug0LvlCQ/e7SkNO5YYzduqH2n97VNE+r1AE9ZZ6Oos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107465; c=relaxed/simple;
	bh=otewvy1SKQKUiBbtFLMLxCv1J0smN2v/CXcupri8NvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMlJA7d1a0cqfRgu2ZVtnTEwaUH6tPcHwE9szk8fTkO7Q+5SzKoym7kkKHM9F5vlWnrYUpKKob6xgwM+7xR8G9HVc40/a+fDezWCzauq8Zz1mqKpWcOhS47zinaywgYIKAFVSSGZt+OfQKKVDHRS7BsiFzQURus55tkludKR8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rEOGc2QG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k8Bd1OmN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rEOGc2QG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k8Bd1OmN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E81071F393;
	Fri, 10 Oct 2025 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760107462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAAwqaAerezpxf2CYgSSWjLVyuTqzxcgxlzpFnSX2vA=;
	b=rEOGc2QGAu8Cnqx+FyIAN0gYX3YCn0MNtWLodXfkX3kCH3qcnvTAHgDNDv1qBtc9OpJ0WB
	zb2JAO2kLcGb7oaTYpSkXmWFMBVVqm8MVPSQmY1Ea5m+D0Sw/wZawDsz4XpRKq24Ud6t2J
	lAwwtKPM33aTYAH9YXYs5ToIe8agogY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760107462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAAwqaAerezpxf2CYgSSWjLVyuTqzxcgxlzpFnSX2vA=;
	b=k8Bd1OmNTb4kY+4JisnsrWtZOGzKYbMNyNv5rnmMAsSliimeSASBiRr8vPAorbNOwBnvDr
	SxecT5fpZYMaoyAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rEOGc2QG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k8Bd1OmN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760107462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAAwqaAerezpxf2CYgSSWjLVyuTqzxcgxlzpFnSX2vA=;
	b=rEOGc2QGAu8Cnqx+FyIAN0gYX3YCn0MNtWLodXfkX3kCH3qcnvTAHgDNDv1qBtc9OpJ0WB
	zb2JAO2kLcGb7oaTYpSkXmWFMBVVqm8MVPSQmY1Ea5m+D0Sw/wZawDsz4XpRKq24Ud6t2J
	lAwwtKPM33aTYAH9YXYs5ToIe8agogY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760107462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAAwqaAerezpxf2CYgSSWjLVyuTqzxcgxlzpFnSX2vA=;
	b=k8Bd1OmNTb4kY+4JisnsrWtZOGzKYbMNyNv5rnmMAsSliimeSASBiRr8vPAorbNOwBnvDr
	SxecT5fpZYMaoyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5FC813A40;
	Fri, 10 Oct 2025 14:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yq5qLMUb6WjvJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:44:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 02876A0A58; Fri, 10 Oct 2025 16:44:19 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:44:19 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 03/14] fs: provide accessors for ->i_state
Message-ID: <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>
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
X-Rspamd-Queue-Id: E81071F393
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 09-10-25 09:59:17, Mateusz Guzik wrote:
> +static inline void inode_state_set_raw(struct inode *inode,
> +				       enum inode_state_flags_enum flags)
> +{
> +	WRITE_ONCE(inode->i_state, inode->i_state | flags);
> +}

I think this shouldn't really exist as it is dangerous to use and if we
deal with XFS, nobody will actually need this function.

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

Ditto here.

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

Nobody needs this so I'd just provide inode_state_replace().

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

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

