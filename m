Return-Path: <linux-fsdevel+bounces-63767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C18BABCD78A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C0E74FFB94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3452F99A5;
	Fri, 10 Oct 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RqUreT6b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w8vcmEYd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RqUreT6b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w8vcmEYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71D2F90DB
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105760; cv=none; b=tGcJxYAWIsXAe3WZbJ8kskv5b2Tr3Xdxmuakk/O9kRWyrS6MSIMAkhW9WEop/pa2ElhcMJG1LaGyUL/1PeyqQrDMxY1aahx9KQPWNdvJ04MKUkBmkU71iyFtj1I4t9+iKKeNWu3NK1ziC8isevJgqU5vzqWmIE78h4PJ2tu0LWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105760; c=relaxed/simple;
	bh=uw2Ra7SKIQ6DzFatNSHGgYtbKJe9M4DAUUqzwwLdiQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWbb7S6RYjdIG9b8Cc0LJYltqTpaRjukd2W4DJMzcW+uuoVKx0O5n0JzTV67wYzu11HDAMZcqPzwxCPMlhu8TQXL+3M0+F3fUeCpgFRKdWyXwFKkk3M+lw0wiFEIv1lX0aozxTma4nZxK53A1TJ8TR23XzlV2xrP+AyQ5geS8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RqUreT6b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w8vcmEYd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RqUreT6b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w8vcmEYd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C06F1F397;
	Fri, 10 Oct 2025 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0qW8WvGK9GRf1olcZDAqZ9ZDNuJrDZDc0ZIlfNsJTgk=;
	b=RqUreT6bIseP0WLbFfj3R2g/9X9tH6F7qsUqWMuqt+cYdnGjwN1fiUZYjdibkpBnDsAkAW
	vP6IWZUIq4UHeO5IaO7ipdXgwzD3FG4ChQD6SlDHUjvmpGZzxKYbC+7IAalO6UtF8m47RK
	roo+nvunP7M1m5TBM4Gq5Onk66zaFFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0qW8WvGK9GRf1olcZDAqZ9ZDNuJrDZDc0ZIlfNsJTgk=;
	b=w8vcmEYd/3HGBg1uKBqGH2stOvZsUv8ZN88xjNO9qoueNVdbQFGExRWYqiJZkOP5AvsytH
	wRRVIKxlAwkPf/BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RqUreT6b;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w8vcmEYd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0qW8WvGK9GRf1olcZDAqZ9ZDNuJrDZDc0ZIlfNsJTgk=;
	b=RqUreT6bIseP0WLbFfj3R2g/9X9tH6F7qsUqWMuqt+cYdnGjwN1fiUZYjdibkpBnDsAkAW
	vP6IWZUIq4UHeO5IaO7ipdXgwzD3FG4ChQD6SlDHUjvmpGZzxKYbC+7IAalO6UtF8m47RK
	roo+nvunP7M1m5TBM4Gq5Onk66zaFFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0qW8WvGK9GRf1olcZDAqZ9ZDNuJrDZDc0ZIlfNsJTgk=;
	b=w8vcmEYd/3HGBg1uKBqGH2stOvZsUv8ZN88xjNO9qoueNVdbQFGExRWYqiJZkOP5AvsytH
	wRRVIKxlAwkPf/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50B3B1375D;
	Fri, 10 Oct 2025 14:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SLSyExwV6WjhCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:15:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 903F5A0A58; Fri, 10 Oct 2025 16:15:55 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:15:55 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 08/14] smb: use the new ->i_state accessors
Message-ID: <axpsruczzp2xvpckjduswimqzdkfci3hioegogzrz7xqk4oxj2@itxjjeqwkbzx>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-9-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-9-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 6C06F1F397
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 09-10-25 09:59:22, Mateusz Guzik wrote:
> Change generated with coccinelle and fixed up by hand as appropriate.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> cheat sheet:
> 
> If ->i_lock is held, then:
> 
> state = inode->i_state          => state = inode_state_read(inode)
> inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
> inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)
> 
> If ->i_lock is not held or only held conditionally:
> 
> state = inode->i_state          => state = inode_state_read_once(inode)
> inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
> inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)
> 
>  fs/smb/client/cifsfs.c |  2 +-
>  fs/smb/client/inode.c  | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 1775c2b7528f..103289451bd7 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -484,7 +484,7 @@ cifs_evict_inode(struct inode *inode)
>  {
>  	netfs_wait_for_outstanding_io(inode);
>  	truncate_inode_pages_final(&inode->i_data);
> -	if (inode->i_state & I_PINNING_NETFS_WB)
> +	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB)
>  		cifs_fscache_unuse_inode_cookie(inode, true);
>  	cifs_fscache_release_inode_cookie(inode);
>  	clear_inode(inode);
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 8bb544be401e..32d9054a77fc 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -101,7 +101,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
>  	cifs_dbg(FYI, "%s: revalidating inode %llu\n",
>  		 __func__, cifs_i->uniqueid);
>  
> -	if (inode->i_state & I_NEW) {
> +	if (inode_state_read_once(inode) & I_NEW) {
>  		cifs_dbg(FYI, "%s: inode %llu is new\n",
>  			 __func__, cifs_i->uniqueid);
>  		return;
> @@ -146,7 +146,7 @@ cifs_nlink_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
>  	 */
>  	if (fattr->cf_flags & CIFS_FATTR_UNKNOWN_NLINK) {
>  		/* only provide fake values on a new inode */
> -		if (inode->i_state & I_NEW) {
> +		if (inode_state_read_once(inode) & I_NEW) {
>  			if (fattr->cf_cifsattrs & ATTR_DIRECTORY)
>  				set_nlink(inode, 2);
>  			else
> @@ -167,12 +167,12 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
>  	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
>  	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
>  
> -	if (!(inode->i_state & I_NEW) &&
> +	if (!(inode_state_read_once(inode) & I_NEW) &&
>  	    unlikely(inode_wrong_type(inode, fattr->cf_mode))) {
>  		CIFS_I(inode)->time = 0; /* force reval */
>  		return -ESTALE;
>  	}
> -	if (inode->i_state & I_NEW)
> +	if (inode_state_read_once(inode) & I_NEW)
>  		CIFS_I(inode)->netfs.zero_point = fattr->cf_eof;
>  
>  	cifs_revalidate_cache(inode, fattr);
> @@ -194,7 +194,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
>  	inode->i_gid = fattr->cf_gid;
>  
>  	/* if dynperm is set, don't clobber existing mode */
> -	if (inode->i_state & I_NEW ||
> +	if (inode_state_read(inode) & I_NEW ||
>  	    !(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DYNPERM))
>  		inode->i_mode = fattr->cf_mode;
>  
> @@ -236,7 +236,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
>  
>  	if (fattr->cf_flags & CIFS_FATTR_JUNCTION)
>  		inode->i_flags |= S_AUTOMOUNT;
> -	if (inode->i_state & I_NEW) {
> +	if (inode_state_read_once(inode) & I_NEW) {
>  		cifs_set_netfs_context(inode);
>  		cifs_set_ops(inode);
>  	}
> @@ -1638,7 +1638,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
>  		cifs_fattr_to_inode(inode, fattr, false);
>  		if (sb->s_flags & SB_NOATIME)
>  			inode->i_flags |= S_NOATIME | S_NOCMTIME;
> -		if (inode->i_state & I_NEW) {
> +		if (inode_state_read_once(inode) & I_NEW) {
>  			inode->i_ino = hash;
>  			cifs_fscache_get_inode_cookie(inode);
>  			unlock_new_inode(inode);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

