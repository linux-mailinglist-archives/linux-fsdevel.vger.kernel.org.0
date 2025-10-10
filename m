Return-Path: <linux-fsdevel+bounces-63769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF49BCD7A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A66DA355F29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5672F83C1;
	Fri, 10 Oct 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aaUaXyAR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2NyuDw3j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aaUaXyAR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2NyuDw3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD702F549C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105842; cv=none; b=GlFBNQw1TvzB/NEZb+2W6l94uiABmZ48AbyP8GgkK1QHphSzyZibwE0AoyXuu5dvjHPDrBkOdPhzgHOpwtLJIGE5dHyxw/TWUvgk8mywkoKR9ZwruHJnqE+nbWZ1Pf9f60j2I9goslGrGRNRMc4MSqVtmerxxm2Vm9PFourPjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105842; c=relaxed/simple;
	bh=4LGOJDMi5fzwIj/dPlNIw3dRY5mZISw9DLiXswDH+7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8+NJKwQoGR9okIfPUvJ4SOqytNnIagMrZr80RF2fDFNpLv/QylZHItURPI/4NZ4tpgVgS0E4kpwgptj+aVc8/XDPCjMN+cfqckITODZtnhaBHSr3C6Yr/y0f0tdh1Xw0CS5EQlMBk04XVm+qPqDnorH/qHf38K2XZSNVhjhXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aaUaXyAR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2NyuDw3j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aaUaXyAR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2NyuDw3j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AAF5321D11;
	Fri, 10 Oct 2025 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YYXDgZFRBEzyuY0j1S5ahs2qiojEH7o+8XlMjm+SQQ=;
	b=aaUaXyARLaSliW/MCxgU1l/mqkrXzh0mVJ8d2OYeS2qtAlolWa8lvNbnW5ytHPm0oRnSuc
	9lk5gAY5ktC6KTxhqAEzzov4Ri9SxJCiF0JkbWzQrnvAIC46T3tvrXX2Z8AgszdoiQZnfQ
	bXykhpAWEQLgzBmCPtTzca9TdBNPTJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YYXDgZFRBEzyuY0j1S5ahs2qiojEH7o+8XlMjm+SQQ=;
	b=2NyuDw3jqStlvQIfromAWxNgXta9dM3cLaC+haMkzjCKaKZGSNqwJwJ9TwnbrGh+ksrdP5
	yhQEcrKobHifrnBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aaUaXyAR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2NyuDw3j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YYXDgZFRBEzyuY0j1S5ahs2qiojEH7o+8XlMjm+SQQ=;
	b=aaUaXyARLaSliW/MCxgU1l/mqkrXzh0mVJ8d2OYeS2qtAlolWa8lvNbnW5ytHPm0oRnSuc
	9lk5gAY5ktC6KTxhqAEzzov4Ri9SxJCiF0JkbWzQrnvAIC46T3tvrXX2Z8AgszdoiQZnfQ
	bXykhpAWEQLgzBmCPtTzca9TdBNPTJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YYXDgZFRBEzyuY0j1S5ahs2qiojEH7o+8XlMjm+SQQ=;
	b=2NyuDw3jqStlvQIfromAWxNgXta9dM3cLaC+haMkzjCKaKZGSNqwJwJ9TwnbrGh+ksrdP5
	yhQEcrKobHifrnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FCAF1375D;
	Fri, 10 Oct 2025 14:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f7dIG24V6Wi7DAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:17:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67F2DA28E2; Fri, 10 Oct 2025 16:17:15 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:17:15 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 10/14] gfs2: use the new ->i_state accessors
Message-ID: <r7zaigx64hzedliswst7t3ad2reo4cfnxze5x6xnxvs4ir3ko3@4oufkcykqsc2>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-11-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-11-mjguzik@gmail.com>
X-Rspamd-Queue-Id: AAF5321D11
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 09-10-25 09:59:24, Mateusz Guzik wrote:
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
>  fs/gfs2/file.c       | 2 +-
>  fs/gfs2/glops.c      | 2 +-
>  fs/gfs2/inode.c      | 4 ++--
>  fs/gfs2/ops_fstype.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index bc67fa058c84..ee92f5910ae1 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -744,7 +744,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
>  {
>  	struct address_space *mapping = file->f_mapping;
>  	struct inode *inode = mapping->host;
> -	int sync_state = inode->i_state & I_DIRTY;
> +	int sync_state = inode_state_read_once(inode) & I_DIRTY;
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  	int ret = 0, ret1 = 0;
>  
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 0c0a80b3baca..c94e42b0c94d 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -394,7 +394,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
>  	u16 height, depth;
>  	umode_t mode = be32_to_cpu(str->di_mode);
>  	struct inode *inode = &ip->i_inode;
> -	bool is_new = inode->i_state & I_NEW;
> +	bool is_new = inode_state_read_once(inode) & I_NEW;
>  
>  	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
>  		gfs2_consist_inode(ip);
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 8a7ed80d9f2d..890c87e3e365 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -127,7 +127,7 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
>  
>  	ip = GFS2_I(inode);
>  
> -	if (inode->i_state & I_NEW) {
> +	if (inode_state_read_once(inode) & I_NEW) {
>  		struct gfs2_sbd *sdp = GFS2_SB(inode);
>  		struct gfs2_glock *io_gl;
>  		int extra_flags = 0;
> @@ -924,7 +924,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
>  	gfs2_dir_no_add(&da);
>  	gfs2_glock_dq_uninit(&d_gh);
>  	if (!IS_ERR_OR_NULL(inode)) {
> -		if (inode->i_state & I_NEW)
> +		if (inode_state_read_once(inode) & I_NEW)
>  			iget_failed(inode);
>  		else
>  			iput(inode);
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index aa15183f9a16..889682f051ea 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1751,7 +1751,7 @@ static void gfs2_evict_inodes(struct super_block *sb)
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>  		spin_lock(&inode->i_lock);
> -		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
> +		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) &&
>  		    !need_resched()) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

