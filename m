Return-Path: <linux-fsdevel+bounces-25332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E87694AF05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 19:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC3B254C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B58713D533;
	Wed,  7 Aug 2024 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3g4WFyC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xgxkXLTZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HlkjxqrP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iVhA26L6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57AD8286A;
	Wed,  7 Aug 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052474; cv=none; b=bwBWOkuhbBa3Aj4Xp17isqyNGYxnrWMozG8MmsbapoDUh94ZyzLMUYq2sdDsWHoKEOL3Xwb1IMplgdCDh/gQEl4tTJHAIy08BgmY7OIyrdB7Inb+ng9BRBbBIaH+sVU/J3vInSHnZv+7iKYp0cfP1hS9wIKaYjYeOCxAFfNT+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052474; c=relaxed/simple;
	bh=Rq4GKEjVRYzNeNaspEUvwi/V1zw0jvP8g0nu4QQVLh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmXRW/epPBAIh4zi90WDgFh/QbmYSuXUU1/aHeHvUoLgNU4cHjRkxtsQ6CoUi8/UBu6Ta5euRGzNfNBKE3cu7cIpuTlIk1IlfJdEMfCTR5UbBHvMWapMnldieAVRCFMd9ZuyuyT59snXi1wLzW/QJOLUj8NBDx8xe9bnC4upl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3g4WFyC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xgxkXLTZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HlkjxqrP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iVhA26L6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E13841FB95;
	Wed,  7 Aug 2024 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723052470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/GtgqVmUziMUsWkZ8W64gEKilUHrvGZFRWvP/oTBUM=;
	b=Y3g4WFyCJxbW0zWQHw5nHgEF6tD4w1cThYmE8jdkFnwpi2c3iLZt2mb71sFjIObr6Zqku4
	ia+z8Y4wkYeV/opb6PnxtkfcunWo7cqv9tg6PbxnNKTLI56NYFiiMKnA1osnW6faHY21az
	e9J0x7B4d13C7giQVLZCb13GH/VJKjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723052470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/GtgqVmUziMUsWkZ8W64gEKilUHrvGZFRWvP/oTBUM=;
	b=xgxkXLTZ35jeJE4KMkuDvfo77W2P0ghTr9GAioVu49P2HqoMf6I3WQjHebSGHn4oxDa0KF
	QquWCb5Sw37ikQAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HlkjxqrP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iVhA26L6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723052468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/GtgqVmUziMUsWkZ8W64gEKilUHrvGZFRWvP/oTBUM=;
	b=HlkjxqrPYUYLApG6KaK/a+oqpE5Kg7ycpR8XuaDCDfW2jesvhzBy+b99D53z5WLJ1oWXU4
	rFo1gN0ssEJUtRTgHVV+Q3VFXI5oJoFbE9XCSBxKMG1s7JaaVDmRAUHe8QWeVKvOQbuDwV
	vbccHYCC7BN3jKjJcFVFJHMCk6uL7Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723052468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/GtgqVmUziMUsWkZ8W64gEKilUHrvGZFRWvP/oTBUM=;
	b=iVhA26L6dnPTetdpirt2k1YYRn0z5K9EJsqxzWpGnUpVFHbAwNyG5pOxGd9Ndbdsy5sboe
	7vBGfVNYUqM8dBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D054813A7D;
	Wed,  7 Aug 2024 17:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TkibMrSxs2Y+JgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 17:41:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7117AA0762; Wed,  7 Aug 2024 19:41:08 +0200 (CEST)
Date: Wed, 7 Aug 2024 19:41:08 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 06/10] ext4: update delalloc data reserve spcae in
 ext4_es_insert_extent()
Message-ID: <20240807174108.l2bbbhlnpznztp34@quack3>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802115120.362902-7-yi.zhang@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: E13841FB95
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.49

On Fri 02-08-24 19:51:16, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now that we update data reserved space for delalloc after allocating
> new blocks in ext4_{ind|ext}_map_blocks(), and if bigalloc feature is
> enabled, we also need to query the extents_status tree to calculate the
> exact reserved clusters. This is complicated now and it appears that
> it's better to do this job in ext4_es_insert_extent(), because
> __es_remove_extent() have already count delalloc blocks when removing
> delalloc extents and __revise_pending() return new adding pending count,
> we could update the reserved blocks easily in ext4_es_insert_extent().
> 
> Thers is one special case needs to concern is the quota claiming, when
> bigalloc is enabled, if the delayed cluster allocation has been raced
> by another no-delayed allocation(e.g. from fallocate) which doesn't
> cover the delayed blocks:
> 
>   |<       one cluster       >|
>   hhhhhhhhhhhhhhhhhhhdddddddddd
>   ^            ^
>   |<          >| < fallocate this range, don't claim quota again
> 
> We can't claim quota as usual because the fallocate has already claimed
> it in ext4_mb_new_blocks(), we could notice this case through the
> removed delalloc blocks count.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
...
> @@ -926,9 +928,27 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  			__free_pending(pr);
>  			pr = NULL;
>  		}
> +		pending = err3;
>  	}
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> +	/*
> +	 * Reduce the reserved cluster count to reflect successful deferred
> +	 * allocation of delayed allocated clusters or direct allocation of
> +	 * clusters discovered to be delayed allocated.  Once allocated, a
> +	 * cluster is not included in the reserved count.
> +	 *
> +	 * When bigalloc is enabled, allocating non-delayed allocated blocks
> +	 * which belong to delayed allocated clusters (from fallocate, filemap,
> +	 * DIO, or clusters allocated when delalloc has been disabled by
> +	 * ext4_nonda_switch()). Quota has been claimed by ext4_mb_new_blocks(),
> +	 * so release the quota reservations made for any previously delayed
> +	 * allocated clusters.
> +	 */
> +	resv_used = rinfo.delonly_cluster + pending;
> +	if (resv_used)
> +		ext4_da_update_reserve_space(inode, resv_used,
> +					     rinfo.delonly_block);

I'm not sure I understand here. We are inserting extent into extent status
tree. We are replacing resv_used clusters worth of space with delayed
allocation reservation with normally allocated clusters so we need to
release the reservation (mballoc already reduced freeclusters counter).
That I understand. In normal case we should also claim quota because we are
converting from reserved into allocated state. Now if we allocated blocks
under this range (e.g. from fallocate()) without
EXT4_GET_BLOCKS_DELALLOC_RESERVE, we need to release quota reservation here
instead of claiming it. But I fail to see how rinfo.delonly_block > 0 is
related to whether EXT4_GET_BLOCKS_DELALLOC_RESERVE was set when allocating
blocks for this extent or not.

At this point it would seem much clearer if we passed flag to
ext4_es_insert_extent() whether EXT4_GET_BLOCKS_DELALLOC_RESERVE was set
when allocating extent or not instead of computing delonly_block and
somehow infering from that. But maybe I miss some obvious reason why that
is correct.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

