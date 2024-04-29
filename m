Return-Path: <linux-fsdevel+bounces-18084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739128B5431
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 11:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014DB1F2063E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6E222F19;
	Mon, 29 Apr 2024 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S3VvU8so";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xsKVvbqt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TbEZVP/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UN283RcQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DC22EEB;
	Mon, 29 Apr 2024 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382741; cv=none; b=msQQ6nivTDQKSU/qR6TmrMFid7skS6ouUQ4PY1sY9R9qYrTaHTWYg3kWB/sky/kZj1I8N4tfJyPwDB6MSOnf7mYTkmamEtA4weiqmCgn6+scvYTlPMw0g3dpzZg7ZLdS1rPjwJEPVL1Wvho2BMiQxVuUWxWkuKvScIWtsTVtR5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382741; c=relaxed/simple;
	bh=4ioOWcAqkTZZPjxQySuZggD5dP4NRy7hb4jvt44FYWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOme/8iMR50zeRaxEI9Gri9eAjhle2HJW4mdAhqSu+P6Jq8HlufKa+U16/yJ76vKV7J/PYzmFQ4EpZc+HodPGqkOrBz7dXH0MUmaQEqsHgW0fdNuhFQPei41ONy95Cjw6mMD7mAnAHJ5Obv0eRQKV7ax2rBLnAQnsmPsZKGpnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S3VvU8so; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xsKVvbqt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TbEZVP/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UN283RcQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15C33203C2;
	Mon, 29 Apr 2024 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714382738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JibG7+lygOof8Tla5+bT9hwsr3Ht7OkMeg7rsKbncvc=;
	b=S3VvU8so2o0Yi6JisbeTYXOeHYB9NTzDma5tn7VeyLIZ1vQfNOA1hZtm+J0zWTtyEECckP
	Cj4BvBQ4Fxfrx+jBpHSVgB7BlKWWChZjiE3yjdTyf6BL26JltCUArz2VyQTGmohZdUQJdX
	2YaV4h3M7u41wceqRGb9zHiU+hqrmYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714382738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JibG7+lygOof8Tla5+bT9hwsr3Ht7OkMeg7rsKbncvc=;
	b=xsKVvbqtjs0jYUZvyC0fNteMSgilnf6otqEtr6w/N0h5c8cJXXp+hcfveDyLxgWBSeDXrE
	175FwLOMTvj4abCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="TbEZVP/y";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UN283RcQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714382737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JibG7+lygOof8Tla5+bT9hwsr3Ht7OkMeg7rsKbncvc=;
	b=TbEZVP/yaFIr8YRQhe0N+Azf+EXlFjeWWp/NNDxnkqKPoIOuLQCQCaWJNlOg0YnU9STQAP
	xHCulS25Oepn/K64TxWxqhYHRdS7+dtI+meXHn2BhCtb+DcKHINXw4LGOsN9Bj+axtaBAD
	FoQtAIXl5p/s6ROuhJw1KpQBlJYLrhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714382737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JibG7+lygOof8Tla5+bT9hwsr3Ht7OkMeg7rsKbncvc=;
	b=UN283RcQbx3kTBpA3qT6WwdhJModTs5RykCLl3VATHTtM4KSj8F/+isVI9uaHA+yNqIqIJ
	M5cVdysic/g7tECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BF39138A7;
	Mon, 29 Apr 2024 09:25:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y2vrApFnL2bOHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Apr 2024 09:25:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0282A082F; Mon, 29 Apr 2024 11:25:36 +0200 (CEST)
Date: Mon, 29 Apr 2024 11:25:36 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 6/9] ext4: make ext4_da_reserve_space() reserve
 multi-clusters
Message-ID: <20240429092536.mtlqw4omhc3mrd5g@quack3>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410034203.2188357-7-yi.zhang@huaweicloud.com>
X-Spam-Level: ****
X-Spamd-Result: default: False [4.39 / 50.00];
	BAYES_SPAM(5.10)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Score: 4.39
X-Spamd-Bar: ++++
X-Rspamd-Queue-Id: 15C33203C2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed 10-04-24 11:42:00, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Add 'nr_resv' parameter to ext4_da_reserve_space(), which indicates the
> number of clusters wants to reserve, make it reserve multi-clusters once
> a time.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c             | 18 +++++++++---------
>  include/trace/events/ext4.h | 10 ++++++----
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d37233e2ed0b..1180a9eb4362 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1479,9 +1479,9 @@ static int ext4_journalled_write_end(struct file *file,
>  }
>  
>  /*
> - * Reserve space for a single cluster
> + * Reserve space for 'nr_resv' clusters
>   */
> -static int ext4_da_reserve_space(struct inode *inode)
> +static int ext4_da_reserve_space(struct inode *inode, int nr_resv)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	struct ext4_inode_info *ei = EXT4_I(inode);
> @@ -1492,18 +1492,18 @@ static int ext4_da_reserve_space(struct inode *inode)
>  	 * us from metadata over-estimation, though we may go over by
>  	 * a small amount in the end.  Here we just reserve for data.
>  	 */
> -	ret = dquot_reserve_block(inode, EXT4_C2B(sbi, 1));
> +	ret = dquot_reserve_block(inode, EXT4_C2B(sbi, nr_resv));
>  	if (ret)
>  		return ret;
>  
>  	spin_lock(&ei->i_block_reservation_lock);
> -	if (ext4_claim_free_clusters(sbi, 1, 0)) {
> +	if (ext4_claim_free_clusters(sbi, nr_resv, 0)) {
>  		spin_unlock(&ei->i_block_reservation_lock);
> -		dquot_release_reservation_block(inode, EXT4_C2B(sbi, 1));
> +		dquot_release_reservation_block(inode, EXT4_C2B(sbi, nr_resv));
>  		return -ENOSPC;
>  	}
> -	ei->i_reserved_data_blocks++;
> -	trace_ext4_da_reserve_space(inode);
> +	ei->i_reserved_data_blocks += nr_resv;
> +	trace_ext4_da_reserve_space(inode, nr_resv);
>  	spin_unlock(&ei->i_block_reservation_lock);
>  
>  	return 0;       /* success */
> @@ -1678,7 +1678,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  	 * extents status tree doesn't get a match.
>  	 */
>  	if (sbi->s_cluster_ratio == 1) {
> -		ret = ext4_da_reserve_space(inode);
> +		ret = ext4_da_reserve_space(inode, 1);
>  		if (ret != 0)   /* ENOSPC */
>  			return ret;
>  	} else {   /* bigalloc */
> @@ -1690,7 +1690,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  				if (ret < 0)
>  					return ret;
>  				if (ret == 0) {
> -					ret = ext4_da_reserve_space(inode);
> +					ret = ext4_da_reserve_space(inode, 1);
>  					if (ret != 0)   /* ENOSPC */
>  						return ret;
>  				} else {
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 6b41ac61310f..cc5e9b7b2b44 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -1246,14 +1246,15 @@ TRACE_EVENT(ext4_da_update_reserve_space,
>  );
>  
>  TRACE_EVENT(ext4_da_reserve_space,
> -	TP_PROTO(struct inode *inode),
> +	TP_PROTO(struct inode *inode, int nr_resv),
>  
> -	TP_ARGS(inode),
> +	TP_ARGS(inode, nr_resv),
>  
>  	TP_STRUCT__entry(
>  		__field(	dev_t,	dev			)
>  		__field(	ino_t,	ino			)
>  		__field(	__u64,	i_blocks		)
> +		__field(	int,	reserve_blocks		)
>  		__field(	int,	reserved_data_blocks	)
>  		__field(	__u16,  mode			)
>  	),
> @@ -1262,16 +1263,17 @@ TRACE_EVENT(ext4_da_reserve_space,
>  		__entry->dev	= inode->i_sb->s_dev;
>  		__entry->ino	= inode->i_ino;
>  		__entry->i_blocks = inode->i_blocks;
> +		__entry->reserve_blocks = nr_resv;
>  		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
>  		__entry->mode	= inode->i_mode;
>  	),
>  
> -	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu "
> +	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu reserve_blocks %d"
>  		  "reserved_data_blocks %d",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  (unsigned long) __entry->ino,
>  		  __entry->mode, __entry->i_blocks,
> -		  __entry->reserved_data_blocks)
> +		  __entry->reserve_blocks, __entry->reserved_data_blocks)
>  );
>  
>  TRACE_EVENT(ext4_da_release_space,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

