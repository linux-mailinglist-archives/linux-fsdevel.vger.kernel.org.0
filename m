Return-Path: <linux-fsdevel+bounces-28534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3036D96B863
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56FE1F21B98
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DCE1CF7A2;
	Wed,  4 Sep 2024 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J+r8TWcI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rPWvohDh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AAZUeKhm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CrDB011s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E7433C8;
	Wed,  4 Sep 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445522; cv=none; b=jmmHUe6FKVEvsEsFAf727JCMnJ69R5JL3/Rb1tVx28qpuPdomeOr7c4scnY4xulHkLjCECVscHC/KTfIOkjpq5rq3IySCNCA5/xV7hh4Ew/7Ai7rNCuC7liHLbNyhaHgpCDjDf5kFQcxKdKJccfzvUSJjMZmtYLSRmYndpIrvFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445522; c=relaxed/simple;
	bh=tNtwnvzPlP6LAb7ngSbL1HKMLnEE84UySxxPLOg1zPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNv2L6NsR2clzqcuIUCFggzXFqOn4WAsoeOfaCwlSdzOK0vUV+4b6+EmOm3oY5bHcyN4+plv+zbaEY5aTPU4IT8+t2SgAiAyAnhDgTLseUjLqitQm9IXNiiByrIO3CIJmqNdsrNEAHREF7lHzCfNVEks9/j/22/cqHZRZAsRaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J+r8TWcI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rPWvohDh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AAZUeKhm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CrDB011s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0FEA219DB;
	Wed,  4 Sep 2024 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E69eEf8yeFJ3D69O3PwbAplc0ythJLD6xHQFno2iu6o=;
	b=J+r8TWcI1Rki1D1K9NpBkRYsZiqZu+U++Gm6+BKQBCwmvWZ2zz1w1SDaB4hN4jWodYHd7p
	8TdE9VcSiHulLalOxvVHUEdi4Z/jjhi5VZocC3JqzhPG9ywEonMj6wBaGgXrPq5hxzbclx
	XjtCeLA6l6bHAaEKzmYwGCvDAnrMVsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E69eEf8yeFJ3D69O3PwbAplc0ythJLD6xHQFno2iu6o=;
	b=rPWvohDhLZdKnNSSCnKXv2lq+Kmht8rHmApTpLxwZXqkHHG+UaYNACOb+ti+xNbxj1mL5J
	vmh+bcqXMIpfqfCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AAZUeKhm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CrDB011s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E69eEf8yeFJ3D69O3PwbAplc0ythJLD6xHQFno2iu6o=;
	b=AAZUeKhm/Enj5y3guKsU+lkdreF57PyOuOflD8JYAq1uZocCbT6j7R3Kl8GHiOjuYqO8nh
	vNAPhOt+w8WS24UW0W9lbwUfra0XIYGBppijh5GUSpg8wTn49JSKtrE9Wp2vJHbbhkBIeb
	LTa5/Md+FIEh5fmkRcDxXXXj5545KwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E69eEf8yeFJ3D69O3PwbAplc0ythJLD6xHQFno2iu6o=;
	b=CrDB011s8+BXsGTN+ukdxzOisH+rWf5P5V3Nol0cFnt/PTlNCS5EdHopXS2sfHEXOMh+MM
	219U4bX23YnWMqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D505C139D2;
	Wed,  4 Sep 2024 10:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bykANI412GZmKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 10:25:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 81ECFA0968; Wed,  4 Sep 2024 12:25:03 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:25:03 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 07/12] ext4: drop ext4_es_delayed_clu()
Message-ID: <20240904102503.nrghco2rouzu7bsr@quack3>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
 <20240813123452.2824659-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813123452.2824659-8-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: E0FEA219DB
X-Spam-Score: -2.51
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,huawei.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 13-08-24 20:34:47, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since we move ext4_da_update_reserve_space() to ext4_es_insert_extent(),
> no one uses ext4_es_delayed_clu() and __es_delayed_clu(), just drop
> them.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Always nice to see code removed :) Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/extents_status.c | 88 ----------------------------------------
>  fs/ext4/extents_status.h |  2 -
>  2 files changed, 90 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 41adf0d69959..b372b98af366 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -2178,94 +2178,6 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>  	return;
>  }
>  
> -/*
> - * __es_delayed_clu - count number of clusters containing blocks that
> - *                    are delayed only
> - *
> - * @inode - file containing block range
> - * @start - logical block defining start of range
> - * @end - logical block defining end of range
> - *
> - * Returns the number of clusters containing only delayed (not delayed
> - * and unwritten) blocks in the range specified by @start and @end.  Any
> - * cluster or part of a cluster within the range and containing a delayed
> - * and not unwritten block within the range is counted as a whole cluster.
> - */
> -static unsigned int __es_delayed_clu(struct inode *inode, ext4_lblk_t start,
> -				     ext4_lblk_t end)
> -{
> -	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
> -	struct extent_status *es;
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> -	struct rb_node *node;
> -	ext4_lblk_t first_lclu, last_lclu;
> -	unsigned long long last_counted_lclu;
> -	unsigned int n = 0;
> -
> -	/* guaranteed to be unequal to any ext4_lblk_t value */
> -	last_counted_lclu = ~0ULL;
> -
> -	es = __es_tree_search(&tree->root, start);
> -
> -	while (es && (es->es_lblk <= end)) {
> -		if (ext4_es_is_delonly(es)) {
> -			if (es->es_lblk <= start)
> -				first_lclu = EXT4_B2C(sbi, start);
> -			else
> -				first_lclu = EXT4_B2C(sbi, es->es_lblk);
> -
> -			if (ext4_es_end(es) >= end)
> -				last_lclu = EXT4_B2C(sbi, end);
> -			else
> -				last_lclu = EXT4_B2C(sbi, ext4_es_end(es));
> -
> -			if (first_lclu == last_counted_lclu)
> -				n += last_lclu - first_lclu;
> -			else
> -				n += last_lclu - first_lclu + 1;
> -			last_counted_lclu = last_lclu;
> -		}
> -		node = rb_next(&es->rb_node);
> -		if (!node)
> -			break;
> -		es = rb_entry(node, struct extent_status, rb_node);
> -	}
> -
> -	return n;
> -}
> -
> -/*
> - * ext4_es_delayed_clu - count number of clusters containing blocks that
> - *                       are both delayed and unwritten
> - *
> - * @inode - file containing block range
> - * @lblk - logical block defining start of range
> - * @len - number of blocks in range
> - *
> - * Locking for external use of __es_delayed_clu().
> - */
> -unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
> -				 ext4_lblk_t len)
> -{
> -	struct ext4_inode_info *ei = EXT4_I(inode);
> -	ext4_lblk_t end;
> -	unsigned int n;
> -
> -	if (len == 0)
> -		return 0;
> -
> -	end = lblk + len - 1;
> -	WARN_ON(end < lblk);
> -
> -	read_lock(&ei->i_es_lock);
> -
> -	n = __es_delayed_clu(inode, lblk, end);
> -
> -	read_unlock(&ei->i_es_lock);
> -
> -	return n;
> -}
> -
>  /*
>   * __revise_pending - makes, cancels, or leaves unchanged pending cluster
>   *                    reservations for a specified block range depending
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index b74d693c1adb..47b3b55a852c 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -252,8 +252,6 @@ extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
>  extern void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>  					  ext4_lblk_t len, bool lclu_allocated,
>  					  bool end_allocated);
> -extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
> -					ext4_lblk_t len);
>  extern void ext4_clear_inode_es(struct inode *inode);
>  
>  #endif /* _EXT4_EXTENTS_STATUS_H */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

