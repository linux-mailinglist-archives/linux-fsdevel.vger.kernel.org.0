Return-Path: <linux-fsdevel+bounces-17287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C568AAB7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 11:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2E81F22516
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4179950;
	Fri, 19 Apr 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nQCOxH11";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8YzUdRfA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nQCOxH11";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8YzUdRfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C756FE14;
	Fri, 19 Apr 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518939; cv=none; b=DlihKiWpQhruq8a092MAb7tYYowlHvk77QNIMYjmupU/zsqlgTXrMeGj/8SEk/8fvAOUvrKNNn2CjYxuw13Gkx+v1FANm/aKbtUmTyJjx3iin4Y/L/hRlIXVulaupdlXC4ee0LnNcsoIUsDoTAhgG0XrXh94oDV5GEwwb8AozIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518939; c=relaxed/simple;
	bh=52mE5RbPtObg7TlAfWaAo2QP0ODG5D8kGcJ8MqpXUQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbvgD9Qtx4CPJ40MCBuKD+KP0c9ALw0UEq/qAiA3DHz82rVIwINddUkwkEL/MzSAJhj21D3AV+7i+atFOu8UFwJE4mWb6G58ih7JCOzj+PIo4IDWkco6VtljPffFVwH08xZi0fM4+8vq+Va5tlky1yRlefTscvRfW+8kXw0JWu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nQCOxH11; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8YzUdRfA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nQCOxH11; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8YzUdRfA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 238FA5D500;
	Fri, 19 Apr 2024 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713518936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1lo3mipQFZeFWUmt8ICyTwHJv5UF+Hf5Xm8EOk8H84=;
	b=nQCOxH112pMqQ3o9wO0fpZUYS1v9TxVW+KYLwlJx10IpcBGfSVlG/47vSZfBDxQQ2EoEyC
	qC37hxjujoA5AT5VUwgW1D7PXmiyDVwacRO+wvrQajqhmAG8v+XwzCeju4GchUm/UBq3KM
	BCP+qZRErvO8eYgEISuX0xW7nkHh6ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713518936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1lo3mipQFZeFWUmt8ICyTwHJv5UF+Hf5Xm8EOk8H84=;
	b=8YzUdRfA4uL/svC/tE+OOJJXdOaBwZBaNtxb+BKJQzCRUjAS/qVtsdOQc9mvcqCT853RaP
	7DaRoTKm4aKcr3CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713518936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1lo3mipQFZeFWUmt8ICyTwHJv5UF+Hf5Xm8EOk8H84=;
	b=nQCOxH112pMqQ3o9wO0fpZUYS1v9TxVW+KYLwlJx10IpcBGfSVlG/47vSZfBDxQQ2EoEyC
	qC37hxjujoA5AT5VUwgW1D7PXmiyDVwacRO+wvrQajqhmAG8v+XwzCeju4GchUm/UBq3KM
	BCP+qZRErvO8eYgEISuX0xW7nkHh6ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713518936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1lo3mipQFZeFWUmt8ICyTwHJv5UF+Hf5Xm8EOk8H84=;
	b=8YzUdRfA4uL/svC/tE+OOJJXdOaBwZBaNtxb+BKJQzCRUjAS/qVtsdOQc9mvcqCT853RaP
	7DaRoTKm4aKcr3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 191A1136CF;
	Fri, 19 Apr 2024 09:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1c4cBlg5ImaDfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Apr 2024 09:28:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B3DFBA0825; Fri, 19 Apr 2024 11:28:55 +0200 (CEST)
Date: Fri, 19 Apr 2024 11:28:55 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: remove the redundant folio_wait_stable()
Message-ID: <20240419092855.ninertlekup4hs7f@quack3>
References: <20240419023005.2719050-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419023005.2719050-1-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-2.71)[98.72%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri 19-04-24 10:30:05, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> __filemap_get_folio() with FGP_WRITEBEGIN parameter has already wait
> for stable folio, so remove the redundant folio_wait_stable() in
> ext4_da_write_begin(), it was left over from the commit cc883236b792
> ("ext4: drop unnecessary journal handle in delalloc write") that
> removed the retry getting page logic.
> 
> Fixes: cc883236b792 ("ext4: drop unnecessary journal handle in delalloc write")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 537803250ca9..6de6bf57699b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2887,9 +2887,6 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  
> -	/* In case writeback began while the folio was unlocked */
> -	folio_wait_stable(folio);
> -
>  #ifdef CONFIG_FS_ENCRYPTION
>  	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
>  #else
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

