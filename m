Return-Path: <linux-fsdevel+bounces-63580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 084C8BC4875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8208D350DAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E722F6579;
	Wed,  8 Oct 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KukutOIP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FV7zwkrJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KukutOIP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FV7zwkrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7A2494D8
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922237; cv=none; b=ODqGbNOkqMwHZG4mvWj3dVHOXfOn7laYt9v4oqUIOHhJMfE2BDJgIIcP7dL2Zj8CCSC65aJmyu5Q4sj6CEUs2ZvQc2N4ASZtUGyTmoFoFpy4+UCvtQYgMgyY+bnmTrAZl/AqvtfCfU9/ft1wf0Oax7bc4jecVzgzW/bVty+c8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922237; c=relaxed/simple;
	bh=AoC205ZCscoSQyKJaZepCNFk+bxBuPZeEOgpEFpBkGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6RKo/X24fEwqSjV3NrcX3TKmywNiWnBzN/lwtqoja2sSbLv93iFqBfY2Yw3a7gMr4xlvvA8umjCvEvYHbtgY512ZAVzPsNih/9zJvStke4nIJflLGFPg8WmdFdy0qwnlGmwPMaKQDBoi0+4LMrVPVHWQuon7L4YreXl8P89jn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KukutOIP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FV7zwkrJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KukutOIP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FV7zwkrJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45AC41F395;
	Wed,  8 Oct 2025 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759922232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBcLPFstRaZgEJff90hg+kcbxCfTKgX+9v2BJhOSZAQ=;
	b=KukutOIPjhJT9YAsQ/GNOdlhaBxLJTZyVXWbVNe2k6d6WZcZhwZ/mkCymz15QuDBqCgskT
	/HDTz94/it1r2bgGdHipyxI+HzSNE650CGVmGCiP27RGNZkB3vm0ar/DQ/kllT5RbnyXyL
	g2A/r20RRRnZ3FYu/HRgdx1WJ4YRZdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759922232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBcLPFstRaZgEJff90hg+kcbxCfTKgX+9v2BJhOSZAQ=;
	b=FV7zwkrJhhdMCbqn8L++G516ZO94Fa/LSq+HjbS7yI37s4pCcp2Q4Duuhiyn9sgerqvEbq
	FCVi6TrM7ByljGCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KukutOIP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FV7zwkrJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759922232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBcLPFstRaZgEJff90hg+kcbxCfTKgX+9v2BJhOSZAQ=;
	b=KukutOIPjhJT9YAsQ/GNOdlhaBxLJTZyVXWbVNe2k6d6WZcZhwZ/mkCymz15QuDBqCgskT
	/HDTz94/it1r2bgGdHipyxI+HzSNE650CGVmGCiP27RGNZkB3vm0ar/DQ/kllT5RbnyXyL
	g2A/r20RRRnZ3FYu/HRgdx1WJ4YRZdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759922232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBcLPFstRaZgEJff90hg+kcbxCfTKgX+9v2BJhOSZAQ=;
	b=FV7zwkrJhhdMCbqn8L++G516ZO94Fa/LSq+HjbS7yI37s4pCcp2Q4Duuhiyn9sgerqvEbq
	FCVi6TrM7ByljGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 357CA13693;
	Wed,  8 Oct 2025 11:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CYEADThI5miuJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 11:17:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B1417A0ACD; Wed,  8 Oct 2025 13:17:11 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:17:11 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 02/13] ext4: correct the checking of quota files
 before moving extents
Message-ID: <le2eumghjeqpmng4wubvwgp5tqevhc35q3qxxkczuvthrregbw@errdd2w7d3hs>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-3-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 45AC41F395
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Thu 25-09-25 17:25:58, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The move extent operation should return -EOPNOTSUPP if any of the inodes
> is a quota inode, rather than requiring both to be quota inodes.
> 
> Fixes: 02749a4c2082 ("ext4: add ext4_is_quota_file()")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Funny bug. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 4b091c21908f..0f4b7c89edd3 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -485,7 +485,7 @@ mext_check_arguments(struct inode *orig_inode,
>  		return -ETXTBSY;
>  	}
>  
> -	if (ext4_is_quota_file(orig_inode) && ext4_is_quota_file(donor_inode)) {
> +	if (ext4_is_quota_file(orig_inode) || ext4_is_quota_file(donor_inode)) {
>  		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %lu, donor %lu]\n",
>  			orig_inode->i_ino, donor_inode->i_ino);
>  		return -EOPNOTSUPP;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

