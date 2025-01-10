Return-Path: <linux-fsdevel+bounces-38839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FE9A08B4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28819168F4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A320E6FE;
	Fri, 10 Jan 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q3ZsOe8T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfoNCHiC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ayyTMnT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RWpZUKgP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED120E314;
	Fri, 10 Jan 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500549; cv=none; b=mG136SM6gX32Ab2s1luzF8dwKCBIe/lJrHm/AReycvZytqikvRlfYsg7y/yNvHo8gdS6CJZ+oZ09esDqw/tQ7rfx5oLWN4LyGe0Ad5jeO+HcGNfIGpvWvduq31BGlL/jQC2A2wdsHtwylCtB71LFbzMTHp7oJ6NspZs/67tX+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500549; c=relaxed/simple;
	bh=pOy/fojA+ihAOoFriMe0gEX1v2rHGIz81KL4crRLkmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj9kgla/bg7AzwRU9myIYj0Bf9o6ViZN1wybUpAV/n2VS4z6QYZ5RXoy/IFzm1Rm8Nh/USF3PoN5CrNdAS/JHEWB7pJqJ0DrUMPs70MmQ67Q4rFG9e+tz6dXSO3Ifmar2nyi8R9evka5cC7/6HmIXjB2BddMZMzmOHOPm3NSrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q3ZsOe8T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QfoNCHiC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3ayyTMnT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RWpZUKgP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84BEA21137;
	Fri, 10 Jan 2025 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736500544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZV6ydw7BDiN1oC5jPD8I8BhqRskag8NibNuKSjDakA=;
	b=q3ZsOe8TRGK/g/BY610no7zbTl9AETkWdNAdsFmngYCUnmZdvYS/q7FieuwAPdOXsbHBuO
	ouegit0AoHumfIpYuYFwAz/WC1p6RZtZn8L8FTnVbJpth2NPYi7ZpDSEOyRlOwDKPw2IFv
	srNkx66qip7XXrsx0n4eAR2MH1+PtYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736500544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZV6ydw7BDiN1oC5jPD8I8BhqRskag8NibNuKSjDakA=;
	b=QfoNCHiCk1PdZ/6oKeZSLf369tbWPTwShxnlHpk8XW/kLnq/3zGBQGU+vwtpxnJ+IwpnPI
	oBEi5JCfpq4uQiCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3ayyTMnT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RWpZUKgP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736500543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZV6ydw7BDiN1oC5jPD8I8BhqRskag8NibNuKSjDakA=;
	b=3ayyTMnTY/zVOnxNBdjZzKNEHcNwRNM/jtLpgjpRzJA25JCRO+k482ZNCbjEqc8VJQKhvE
	M65fZJgaILQyedqmT1MJrRiwuNnBGXerxwPD01bHcus4M8xNamc8/ad5X+lraoOPCi707+
	0lmuMZfnuThLlnWMEI4kMYU4o+x1E5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736500543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZV6ydw7BDiN1oC5jPD8I8BhqRskag8NibNuKSjDakA=;
	b=RWpZUKgPy0O11t7IdromUiombOTL6ebAFCkd7CYTo9HjpUuBDZZ1eZZggO1v0AtlXKiNX0
	dcDzGFH8dONMxXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 755EA13763;
	Fri, 10 Jan 2025 09:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dyylHD/lgGfMDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Jan 2025 09:15:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1CD41A0889; Fri, 10 Jan 2025 10:15:39 +0100 (CET)
Date: Fri, 10 Jan 2025 10:15:39 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, linux-nfs@vger.kernel.org, 
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH 05/20] ext4 fast_commit: make use of name_snapshot
 primitives
Message-ID: <cahupehos3slr6zr65s7dpppd4diyy6jzh2m2r4yo3ophew43w@pzsjzj4nc5wc>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110024303.4157645-5-viro@zeniv.linux.org.uk>
X-Rspamd-Queue-Id: 84BEA21137
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,omnibond.com,suse.cz,szeredi.hu,linux-foundation.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 10-01-25 02:42:48, Al Viro wrote:
> ... rather than open-coding them.  As a bonus, that avoids the pointless
> work with extra allocations, etc. for long names.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 29 +++++------------------------
>  fs/ext4/fast_commit.h |  3 +--
>  2 files changed, 6 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 26c4fc37edcf..da4263a14a20 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -322,9 +322,7 @@ void ext4_fc_del(struct inode *inode)
>  	WARN_ON(!list_empty(&ei->i_fc_dilist));
>  	spin_unlock(&sbi->s_fc_lock);
>  
> -	if (fc_dentry->fcd_name.name &&
> -		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> -		kfree(fc_dentry->fcd_name.name);
> +	release_dentry_name_snapshot(&fc_dentry->fcd_name);
>  	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
>  
>  	return;
> @@ -449,22 +447,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
>  	node->fcd_op = dentry_update->op;
>  	node->fcd_parent = dir->i_ino;
>  	node->fcd_ino = inode->i_ino;
> -	if (dentry->d_name.len > DNAME_INLINE_LEN) {
> -		node->fcd_name.name = kmalloc(dentry->d_name.len, GFP_NOFS);
> -		if (!node->fcd_name.name) {
> -			kmem_cache_free(ext4_fc_dentry_cachep, node);
> -			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, handle);
> -			mutex_lock(&ei->i_fc_lock);
> -			return -ENOMEM;
> -		}
> -		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
> -			dentry->d_name.len);
> -	} else {
> -		memcpy(node->fcd_iname, dentry->d_name.name,
> -			dentry->d_name.len);
> -		node->fcd_name.name = node->fcd_iname;
> -	}
> -	node->fcd_name.len = dentry->d_name.len;
> +	take_dentry_name_snapshot(&node->fcd_name, dentry);
>  	INIT_LIST_HEAD(&node->fcd_dilist);
>  	spin_lock(&sbi->s_fc_lock);
>  	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> @@ -832,7 +815,7 @@ static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
>  {
>  	struct ext4_fc_dentry_info fcd;
>  	struct ext4_fc_tl tl;
> -	int dlen = fc_dentry->fcd_name.len;
> +	int dlen = fc_dentry->fcd_name.name.len;
>  	u8 *dst = ext4_fc_reserve_space(sb,
>  			EXT4_FC_TAG_BASE_LEN + sizeof(fcd) + dlen, crc);
>  
> @@ -847,7 +830,7 @@ static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
>  	dst += EXT4_FC_TAG_BASE_LEN;
>  	memcpy(dst, &fcd, sizeof(fcd));
>  	dst += sizeof(fcd);
> -	memcpy(dst, fc_dentry->fcd_name.name, dlen);
> +	memcpy(dst, fc_dentry->fcd_name.name.name, dlen);
>  
>  	return true;
>  }
> @@ -1328,9 +1311,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  		list_del_init(&fc_dentry->fcd_dilist);
>  		spin_unlock(&sbi->s_fc_lock);
>  
> -		if (fc_dentry->fcd_name.name &&
> -			fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> -			kfree(fc_dentry->fcd_name.name);
> +		release_dentry_name_snapshot(&fc_dentry->fcd_name);
>  		kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
>  		spin_lock(&sbi->s_fc_lock);
>  	}
> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> index 2fadb2c4780c..3bd534e4dbbf 100644
> --- a/fs/ext4/fast_commit.h
> +++ b/fs/ext4/fast_commit.h
> @@ -109,8 +109,7 @@ struct ext4_fc_dentry_update {
>  	int fcd_op;		/* Type of update create / unlink / link */
>  	int fcd_parent;		/* Parent inode number */
>  	int fcd_ino;		/* Inode number */
> -	struct qstr fcd_name;	/* Dirent name */
> -	unsigned char fcd_iname[DNAME_INLINE_LEN];	/* Dirent name string */
> +	struct name_snapshot fcd_name;	/* Dirent name */
>  	struct list_head fcd_list;
>  	struct list_head fcd_dilist;
>  };
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

