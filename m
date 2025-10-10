Return-Path: <linux-fsdevel+bounces-63768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA734BCD777
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B38E13559E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A842F5472;
	Fri, 10 Oct 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YCPcu4fd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQaCm6S/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YCPcu4fd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQaCm6S/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF7146A66
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105807; cv=none; b=j5NxiKNjPplHkzJAC8kBB8sV1a3kGuXvAITNWN0+5hDQOf3iFSVJm81HGoYXe3TmeuIRft8zTAKtTL8HTxTmGdRgem+tWcrTBZDZ8KtHg5vbVyL2BJYFQjMM069jkZXgsJirpuX4ov/CU3/cGiAvfMoFdqTmPAelDvMtv6kcDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105807; c=relaxed/simple;
	bh=sQJ1vP5GpuFmDvy2Nxvuu3zTX8DXv8fyCSkjvGhxJ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guMQGrbJh+0dTDHoEIiwBBXZQKradxsYJ9YlnDNTcHobgPZ8A58i1xxKlG7TdFP57FrfVRYao8M/JUUBDAWdgM3oJsJp9j2DQLU4Djw6mRpt4wLQf3qv4zcZNGc2gPCpb7uTUlmXif5+wQy8sav15mShZai9XpDRm4Nu+/9+Hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YCPcu4fd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQaCm6S/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YCPcu4fd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQaCm6S/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 785AE1F397;
	Fri, 10 Oct 2025 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uILofeVCGMeS4Pctv7SKp0hIJzOfvJMuu/1g3lFALaY=;
	b=YCPcu4fdxgJsQ2zMwPt/u5xQne8GwpjHsS+91F4LhLAOfp/6356zK7vNktlwoyyrhh+909
	u4GWwUCafHEdmJsaSwM4p9O+qZhE3uzb3ekboP1u+IL6QcDbRyIXiqf/QDhkhfe9o0hY+q
	6eL77y+dkTjP+F9IzUMgDtORotG+pUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uILofeVCGMeS4Pctv7SKp0hIJzOfvJMuu/1g3lFALaY=;
	b=pQaCm6S//05OnKMQFug5QjzLOR1VBrpeZLfbwIva4dsESBhe6LCgKNGA859XUo2s+e6OyF
	fkxESXBrspLPy+DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YCPcu4fd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="pQaCm6S/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760105803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uILofeVCGMeS4Pctv7SKp0hIJzOfvJMuu/1g3lFALaY=;
	b=YCPcu4fdxgJsQ2zMwPt/u5xQne8GwpjHsS+91F4LhLAOfp/6356zK7vNktlwoyyrhh+909
	u4GWwUCafHEdmJsaSwM4p9O+qZhE3uzb3ekboP1u+IL6QcDbRyIXiqf/QDhkhfe9o0hY+q
	6eL77y+dkTjP+F9IzUMgDtORotG+pUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760105803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uILofeVCGMeS4Pctv7SKp0hIJzOfvJMuu/1g3lFALaY=;
	b=pQaCm6S//05OnKMQFug5QjzLOR1VBrpeZLfbwIva4dsESBhe6LCgKNGA859XUo2s+e6OyF
	fkxESXBrspLPy+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ACA11375D;
	Fri, 10 Oct 2025 14:16:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mTlBEksV6WicDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:16:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9BD16A28C4; Fri, 10 Oct 2025 16:16:38 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:16:38 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 09/14] f2fs: use the new ->i_state accessors
Message-ID: <grn56nq7jext3w7hltdlkyvtfecm743rjndg37kuqo7tgmbtbt@mvct5kcth7xx>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-10-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-10-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 785AE1F397
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 09-10-25 09:59:23, Mateusz Guzik wrote:
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
>  fs/f2fs/data.c  | 2 +-
>  fs/f2fs/inode.c | 2 +-
>  fs/f2fs/namei.c | 4 ++--
>  fs/f2fs/super.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ef38e62cda8f..c5319864e4ff 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4222,7 +4222,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  
>  	if (map.m_flags & F2FS_MAP_NEW)
>  		iomap->flags |= IOMAP_F_NEW;
> -	if ((inode->i_state & I_DIRTY_DATASYNC) ||
> +	if ((inode_state_read_once(inode) & I_DIRTY_DATASYNC) ||
>  	    offset + length > i_size_read(inode))
>  		iomap->flags |= IOMAP_F_DIRTY;
>  
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 8c4eafe9ffac..f1cda1900658 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -569,7 +569,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (!(inode->i_state & I_NEW)) {
> +	if (!(inode_state_read_once(inode) & I_NEW)) {
>  		if (is_meta_ino(sbi, ino)) {
>  			f2fs_err(sbi, "inaccessible inode: %lu, run fsck to repair", ino);
>  			set_sbi_flag(sbi, SBI_NEED_FSCK);
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index b882771e4699..af40282a6948 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -844,7 +844,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>  		f2fs_i_links_write(inode, false);
>  
>  		spin_lock(&inode->i_lock);
> -		inode->i_state |= I_LINKABLE;
> +		inode_state_set(inode, I_LINKABLE);
>  		spin_unlock(&inode->i_lock);
>  	} else {
>  		if (file)
> @@ -1057,7 +1057,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  			goto put_out_dir;
>  
>  		spin_lock(&whiteout->i_lock);
> -		whiteout->i_state &= ~I_LINKABLE;
> +		inode_state_clear(whiteout, I_LINKABLE);
>  		spin_unlock(&whiteout->i_lock);
>  
>  		iput(whiteout);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fd8e7b0b2166..8806a1f221cf 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1798,7 +1798,7 @@ static int f2fs_drop_inode(struct inode *inode)
>  	 *    - f2fs_gc -> iput -> evict
>  	 *       - inode_wait_for_writeback(inode)
>  	 */
> -	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
> +	if ((!inode_unhashed(inode) && inode_state_read(inode) & I_SYNC)) {
>  		if (!inode->i_nlink && !is_bad_inode(inode)) {
>  			/* to avoid evict_inode call simultaneously */
>  			__iget(inode);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

