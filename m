Return-Path: <linux-fsdevel+bounces-19771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A08C9A6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAC11C215EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5F3200CB;
	Mon, 20 May 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XH2DYwNf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p6l+Peve";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XH2DYwNf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p6l+Peve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AED468E;
	Mon, 20 May 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197738; cv=none; b=fvoDQ3WJaGZMovbNC9ZM3k0cj7RXOISVcVztrRqZH4i0+oxMy8CbCU9whPX0oQgNwLNMg/Pn+2gleA3mBLbLchzuRP7ozFQggOKqK1bSgIheWBbbFpVBh4jeHw/78z7kFomQSrwa/Vr5u6fPXdpJkm/0XbFC3xtEydurxqI8dXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197738; c=relaxed/simple;
	bh=oCJ7bDpqMGu22xdXKDZBneb7NjcADH96lwJbKYlAQzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdFQsANw7qrnexv/45mDIMvDggYBSEw4AUfEtAqT3khd4U2JsZpQIV9RXU7uYa9dwM7gvWfd0PuJ4SQW9mgPgIqejixF1jJ+x4UMIm0txoZb+vjcyg7w8aBhXmHKNk3WfoEQMKcOdj991GBgj4T0KHcJkdRihNJyIS1bR3T3u0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XH2DYwNf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p6l+Peve; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XH2DYwNf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p6l+Peve; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 322F833C95;
	Mon, 20 May 2024 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716197734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4YQO715ufsd29IiRryzwQEwLfzp0YAfHF4/1j/eECA=;
	b=XH2DYwNf/2/iZLUFVSPaUG85W9Q8Rr8ZpKQCvrWe2yBaiAcPRLB06rQt2iNvBFfA7HurrY
	JNY0L3RmiYIRzQKSTUb4opdRU0DvFBrjptvlyOfDEeGqhYoTFkYaNQY+rAk3vpJCsV/zsA
	jlS6A2kkaJC1BoFyAtB8mOOLIm5vR00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716197734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4YQO715ufsd29IiRryzwQEwLfzp0YAfHF4/1j/eECA=;
	b=p6l+Pevebe4mOhfcB3NXQNmMsZrFlCPzEKBnHlDIo2xLgyxqZCBIQgKmY3byFUAtafAWxm
	lcb4VHcxtvmRhmBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XH2DYwNf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=p6l+Peve
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716197734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4YQO715ufsd29IiRryzwQEwLfzp0YAfHF4/1j/eECA=;
	b=XH2DYwNf/2/iZLUFVSPaUG85W9Q8Rr8ZpKQCvrWe2yBaiAcPRLB06rQt2iNvBFfA7HurrY
	JNY0L3RmiYIRzQKSTUb4opdRU0DvFBrjptvlyOfDEeGqhYoTFkYaNQY+rAk3vpJCsV/zsA
	jlS6A2kkaJC1BoFyAtB8mOOLIm5vR00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716197734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4YQO715ufsd29IiRryzwQEwLfzp0YAfHF4/1j/eECA=;
	b=p6l+Pevebe4mOhfcB3NXQNmMsZrFlCPzEKBnHlDIo2xLgyxqZCBIQgKmY3byFUAtafAWxm
	lcb4VHcxtvmRhmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24C5713A6B;
	Mon, 20 May 2024 09:35:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Oaf1CGYZS2YhZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 09:35:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B6B7BA0888; Mon, 20 May 2024 11:35:29 +0200 (CEST)
Date: Mon, 20 May 2024 11:35:29 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v5 03/10] ext4: warn if delalloc counters are not zero on
 inactive
Message-ID: <20240520093529.iyilizsnm7ktbxt5@quack3>
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
 <20240517124005.347221-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517124005.347221-4-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 322F833C95
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Fri 17-05-24 20:39:58, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The per-inode i_reserved_data_blocks count the reserved delalloc blocks
> in a regular file, it should be zero when destroying the file. The
> per-fs s_dirtyclusters_counter count all reserved delalloc blocks in a
> filesystem, it also should be zero when umounting the filesystem. Now we
> have only an error message if the i_reserved_data_blocks is not zero,
> which is unable to be simply captured, so add WARN_ON_ONCE to make it
> more visable.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 044135796f2b..b68064c877e3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1343,6 +1343,9 @@ static void ext4_put_super(struct super_block *sb)
>  
>  	ext4_group_desc_free(sbi);
>  	ext4_flex_groups_free(sbi);
> +
> +	WARN_ON_ONCE(!(sbi->s_mount_state & EXT4_ERROR_FS) &&
> +		     percpu_counter_sum(&sbi->s_dirtyclusters_counter));
>  	ext4_percpu_param_destroy(sbi);
>  #ifdef CONFIG_QUOTA
>  	for (int i = 0; i < EXT4_MAXQUOTAS; i++)
> @@ -1473,7 +1476,8 @@ static void ext4_destroy_inode(struct inode *inode)
>  		dump_stack();
>  	}
>  
> -	if (EXT4_I(inode)->i_reserved_data_blocks)
> +	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ERROR_FS) &&
> +	    WARN_ON_ONCE(EXT4_I(inode)->i_reserved_data_blocks))
>  		ext4_msg(inode->i_sb, KERN_ERR,
>  			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
>  			 inode->i_ino, EXT4_I(inode),
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

