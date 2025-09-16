Return-Path: <linux-fsdevel+bounces-61719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE42B59478
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 12:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8304A2A1165
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F812C1596;
	Tue, 16 Sep 2025 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpCVFpcX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4oqwY05i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpCVFpcX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4oqwY05i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BE238C0D
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020281; cv=none; b=YIgPhrl1OU0wz66dER5rBhzjCtoMXvUKIoRcuhZd86T6f7ySIaKy/BWwKGhEiWNDPoUx0RzDxUmNKAEvesZ7K99WgzFA60IqPZdt9JJhf2xycurnMFsJV64EPknsjtqSWdp+gSBa4V4CPZ6sc3VFuNCmuBfvLui7JfASPJZiiwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020281; c=relaxed/simple;
	bh=aQgVVmPSlju7o0M+aIYZkRps02uxBR1Kmk3k+U73zZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUx2pFkvA4XJ+vJFVoeh84CtEKOgNM87UVIx0jF/RzjBeS9xhvMMZaDS8UhMSq3ZZ9RovAblh49QISGnSF0lFIb1aSf0P8HXsYcW/eNkdQaQrhwjcIcDCwQYtMgxwUetsUUm3RMtTJnydZSFoPeK6bjBQ2Jbpme2Z+3cLJev2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpCVFpcX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4oqwY05i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpCVFpcX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4oqwY05i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28E861F7E7;
	Tue, 16 Sep 2025 10:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758020278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAubBaV2bCcBFPeoDAGn/4dwCvHDWMnKc9FsyF8ucgQ=;
	b=lpCVFpcXH8WiF27L7nXAdXqOpqC3arTGdbilMSkVE7LvAApGLgILujeiUkclbLbaNLgS9s
	8SIOQG1OQGAblMKWM9dBIvBEW9jQ4u1tZGvHZl937ikk1sLXjmfqH2wkuZ6lPp+0Al5Ays
	vsGymrRAkN+7v7eVD+pOo+g1KFMubis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758020278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAubBaV2bCcBFPeoDAGn/4dwCvHDWMnKc9FsyF8ucgQ=;
	b=4oqwY05ifuT+73PdP//Da719Fr2rNxqHdvRgXNcl8IieU5/oMHl7M06d7ByomduFor6EXq
	n9XrlIHMdJlC14Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lpCVFpcX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4oqwY05i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758020278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAubBaV2bCcBFPeoDAGn/4dwCvHDWMnKc9FsyF8ucgQ=;
	b=lpCVFpcXH8WiF27L7nXAdXqOpqC3arTGdbilMSkVE7LvAApGLgILujeiUkclbLbaNLgS9s
	8SIOQG1OQGAblMKWM9dBIvBEW9jQ4u1tZGvHZl937ikk1sLXjmfqH2wkuZ6lPp+0Al5Ays
	vsGymrRAkN+7v7eVD+pOo+g1KFMubis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758020278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAubBaV2bCcBFPeoDAGn/4dwCvHDWMnKc9FsyF8ucgQ=;
	b=4oqwY05ifuT+73PdP//Da719Fr2rNxqHdvRgXNcl8IieU5/oMHl7M06d7ByomduFor6EXq
	n9XrlIHMdJlC14Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F1A5139CB;
	Tue, 16 Sep 2025 10:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2/qYB7ZCyWgcWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Sep 2025 10:57:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4943A0A56; Tue, 16 Sep 2025 12:57:57 +0200 (CEST)
Date: Tue, 16 Sep 2025 12:57:57 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	hsiangkao@linux.alibaba.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 2/2] ext4: wait for ongoing I/O to complete before
 freeing blocks
Message-ID: <62fpgbfco7nb5sy5shkix27aarsc4tuyg6pit4af6xbgojgvjc@v6dnu33wd4jb>
References: <20250916093337.3161016-1-yi.zhang@huaweicloud.com>
 <20250916093337.3161016-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916093337.3161016-3-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 28E861F7E7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Tue 16-09-25 17:33:37, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When freeing metadata blocks in nojournal mode, ext4_forget() calls
> bforget() to clear the dirty flag on the buffer_head and remvoe
> associated mappings. This is acceptable if the metadata has not yet
> begun to be written back. However, if the write-back has already started
> but is not yet completed, ext4_forget() will have no effect.
> Subsequently, ext4_mb_clear_bb() will immediately return the block to
> the mb allocator. This block can then be reallocated immediately,
> potentially causing an data corruption issue.
> 
> Fix this by clearing the buffer's dirty flag and waiting for the ongoing
> I/O to complete, ensuring that no further writes to stale data will
> occur.
> 
> Fixes: 16e08b14a455 ("ext4: cleanup clean_bdev_aliases() calls")
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Closes: https://lore.kernel.org/linux-ext4/a9417096-9549-4441-9878-b1955b899b4e@huaweicloud.com/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4_jbd2.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index b3e9b7bd7978..a0e66bc10093 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -280,9 +280,16 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
>  		  bh, is_metadata, inode->i_mode,
>  		  test_opt(inode->i_sb, DATA_FLAGS));
>  
> -	/* In the no journal case, we can just do a bforget and return */
> +	/*
> +	 * In the no journal case, we should wait for the ongoing buffer
> +	 * to complete and do a forget.
> +	 */
>  	if (!ext4_handle_valid(handle)) {
> -		bforget(bh);
> +		if (bh) {
> +			clear_buffer_dirty(bh);
> +			wait_on_buffer(bh);
> +			__bforget(bh);
> +		}
>  		return 0;
>  	}
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

