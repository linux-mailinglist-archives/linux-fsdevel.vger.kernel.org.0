Return-Path: <linux-fsdevel+bounces-63597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD1DBC5058
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 14:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48D319E33CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9626276038;
	Wed,  8 Oct 2025 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uTP0LTdN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XxssVcb3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uTP0LTdN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XxssVcb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CE2727E5
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928103; cv=none; b=ol4mPf6AvYGs4zuIe6+6BZZ5eILpRmUjWKOh5R7klFNlTruugJgCsTfl8BWOffM6GMmCN/ID2NcGTRJnyCLmomBa30WVOnbjR2Q+byISHZ/5emrfO/TKCtNC8V3FdZ6mY7F8GvxXzDTbPzR8ihp81l2vnW9jdbJe8Sn+fnf6ONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928103; c=relaxed/simple;
	bh=UPdWiu75orYUiT/S17D2mvtCcxoV53pfo8sO6VIpeKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9XGLGkkfbk3eH4HApaB1FGOSNeSrLNGHFpegNztxhN5ULsrj+zCA6b8yPPvIvXPFA7N6+0pWcHF85j28ZSzhvPzhm37aBYg+3qF8EQ+65vlc6CuQ4DQYBddQKp68umGF3BZ5vc2RytnVBCjX3bMEXwUgtd5YzBCRB9aAQK7YUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uTP0LTdN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XxssVcb3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uTP0LTdN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XxssVcb3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C677F1FC05;
	Wed,  8 Oct 2025 12:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759928098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e1CtbGSnAs+YF38WLCWa/DOZeDRzNvL7cxSmBij76wU=;
	b=uTP0LTdNVRqTbtLXZvLoickB5NY6m8Lmbjp1CV/SyhWCAk7bLtD/eGMW8we0WE8PSZpoHl
	X1tyhSSJ+I5+oO1Ymfo1/SMqi2KBuaeW7RL6q5ppj7kIySMTDmU2+ul+2ggwBrGcvwu417
	0rXTYjHXHW429Xk9RvckxuQTnGgkouk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759928098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e1CtbGSnAs+YF38WLCWa/DOZeDRzNvL7cxSmBij76wU=;
	b=XxssVcb3huVBKPYWIbiOVZduv9XGAZrN3o/9gQKWUYDgzYiUHVeA6gbAJ58TKXrigByebE
	s2M7/q/P4mgKWzCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759928098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e1CtbGSnAs+YF38WLCWa/DOZeDRzNvL7cxSmBij76wU=;
	b=uTP0LTdNVRqTbtLXZvLoickB5NY6m8Lmbjp1CV/SyhWCAk7bLtD/eGMW8we0WE8PSZpoHl
	X1tyhSSJ+I5+oO1Ymfo1/SMqi2KBuaeW7RL6q5ppj7kIySMTDmU2+ul+2ggwBrGcvwu417
	0rXTYjHXHW429Xk9RvckxuQTnGgkouk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759928098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e1CtbGSnAs+YF38WLCWa/DOZeDRzNvL7cxSmBij76wU=;
	b=XxssVcb3huVBKPYWIbiOVZduv9XGAZrN3o/9gQKWUYDgzYiUHVeA6gbAJ58TKXrigByebE
	s2M7/q/P4mgKWzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE5CD13693;
	Wed,  8 Oct 2025 12:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r8qPKiJf5miURQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 12:54:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 17A34A0A9C; Wed,  8 Oct 2025 14:54:58 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:54:58 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 13/13] ext4: add two trace points for moving extents
Message-ID: <kkecvhazplnbbvv2omtwae6jckon3onaym5gbxp7bndnoqr5eq@xow35t5dhhph>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-14-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-14-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 25-09-25 17:26:09, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> To facilitate tracking the length, type, and outcome of the move extent,
> add a trace point at both the entry and exit of mext_move_extent().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c       | 14 ++++++-
>  include/trace/events/ext4.h | 74 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 0fa97c207274..53a8b9caeeda 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -13,6 +13,8 @@
>  #include "ext4.h"
>  #include "ext4_extents.h"
>  
> +#include <trace/events/ext4.h>
> +
>  struct mext_data {
>  	struct inode *orig_inode;	/* Origin file inode */
>  	struct inode *donor_inode;	/* Donor file inode */
> @@ -311,10 +313,14 @@ static int mext_move_extent(struct mext_data *mext, u64 *m_len)
>  	int ret, ret2;
>  
>  	*m_len = 0;
> +	trace_ext4_move_extent_enter(orig_inode, orig_map, donor_inode,
> +				     mext->donor_lblk);
>  	credits = ext4_chunk_trans_extent(orig_inode, 0) * 2;
>  	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, credits);
> -	if (IS_ERR(handle))
> -		return PTR_ERR(handle);
> +	if (IS_ERR(handle)) {
> +		ret = PTR_ERR(handle);
> +		goto out;
> +	}
>  
>  	ret = mext_move_begin(mext, folio, &move_type);
>  	if (ret)
> @@ -372,6 +378,10 @@ static int mext_move_extent(struct mext_data *mext, u64 *m_len)
>  	mext_folio_double_unlock(folio);
>  stop_handle:
>  	ext4_journal_stop(handle);
> +out:
> +	trace_ext4_move_extent_exit(orig_inode, orig_map->m_lblk, donor_inode,
> +				    mext->donor_lblk, orig_map->m_len, *m_len,
> +				    move_type, ret);
>  	return ret;
>  
>  repair_branches:
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 6a0754d38acf..a05bdd48e16e 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -3016,6 +3016,80 @@ TRACE_EVENT(ext4_update_sb,
>  		  __entry->fsblk, __entry->flags)
>  );
>  
> +TRACE_EVENT(ext4_move_extent_enter,
> +	TP_PROTO(struct inode *orig_inode, struct ext4_map_blocks *orig_map,
> +		 struct inode *donor_inode, ext4_lblk_t donor_lblk),
> +
> +	TP_ARGS(orig_inode, orig_map, donor_inode, donor_lblk),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(ino_t, orig_ino)
> +		__field(ext4_lblk_t, orig_lblk)
> +		__field(unsigned int, orig_flags)
> +		__field(ino_t, donor_ino)
> +		__field(ext4_lblk_t, donor_lblk)
> +		__field(unsigned int, len)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= orig_inode->i_sb->s_dev;
> +		__entry->orig_ino	= orig_inode->i_ino;
> +		__entry->orig_lblk	= orig_map->m_lblk;
> +		__entry->orig_flags	= orig_map->m_flags;
> +		__entry->donor_ino	= donor_inode->i_ino;
> +		__entry->donor_lblk	= donor_lblk;
> +		__entry->len		= orig_map->m_len;
> +	),
> +
> +	TP_printk("dev %d,%d origin ino %lu lblk %u flags %s donor ino %lu lblk %u len %u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  (unsigned long) __entry->orig_ino,  __entry->orig_lblk,
> +		  show_mflags(__entry->orig_flags),
> +		  (unsigned long) __entry->donor_ino,  __entry->donor_lblk,
> +		  __entry->len)
> +);
> +
> +TRACE_EVENT(ext4_move_extent_exit,
> +	TP_PROTO(struct inode *orig_inode, ext4_lblk_t orig_lblk,
> +		 struct inode *donor_inode, ext4_lblk_t donor_lblk,
> +		 unsigned int m_len, u64 move_len, int move_type, int ret),
> +
> +	TP_ARGS(orig_inode, orig_lblk, donor_inode, donor_lblk, m_len,
> +		move_len, move_type, ret),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(ino_t, orig_ino)
> +		__field(ext4_lblk_t, orig_lblk)
> +		__field(ino_t, donor_ino)
> +		__field(ext4_lblk_t, donor_lblk)
> +		__field(unsigned int, m_len)
> +		__field(u64, move_len)
> +		__field(int, move_type)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= orig_inode->i_sb->s_dev;
> +		__entry->orig_ino	= orig_inode->i_ino;
> +		__entry->orig_lblk	= orig_lblk;
> +		__entry->donor_ino	= donor_inode->i_ino;
> +		__entry->donor_lblk	= donor_lblk;
> +		__entry->m_len		= m_len;
> +		__entry->move_len	= move_len;
> +		__entry->move_type	= move_type;
> +		__entry->ret		= ret;
> +	),
> +
> +	TP_printk("dev %d,%d origin ino %lu lblk %u donor ino %lu lblk %u m_len %u, move_len %llu type %d ret %d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  (unsigned long) __entry->orig_ino,  __entry->orig_lblk,
> +		  (unsigned long) __entry->donor_ino,  __entry->donor_lblk,
> +		  __entry->m_len, __entry->move_len, __entry->move_type,
> +		  __entry->ret)
> +);
> +
>  #endif /* _TRACE_EXT4_H */
>  
>  /* This part must be outside protection */
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

