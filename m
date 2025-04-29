Return-Path: <linux-fsdevel+bounces-47572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD572AA07CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01128484D39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFDC2BE0E4;
	Tue, 29 Apr 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/yOL/EX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k1hzt2sk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/yOL/EX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k1hzt2sk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821821F416A
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745920503; cv=none; b=Is41IMEqH54hewICxnX/wK75OHH+uGA95tCophiYfnfM1dg3rs3AvUy8jrxW9BzhZirHpDiRU76APeW8+IrM7H5XtZYY7idXSoTwaegiuU7iKoZRnWxnJxhZ9g7k9f4kyds9l77FgcJTvb8Vf+xaU41rbe3MhylLi/9nXc+h+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745920503; c=relaxed/simple;
	bh=sT3XIdFQ6Pyhe7oapXbNFeTfYoCnYG7Zz7pboetzDSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OibsJiXR+xRb/F6ifKK5sPq33RrNCsTYn9vnId7dBZthMj1fIHDotUma35wDInOSO2C59SjTW604VNOC+OFHsewRjcIo/zsfjak4DT2cf+MzH6vj4fmvMY9fjVoJI8O5tYcqVLbqCBpN42zcQUeXNkQ+PU9H1/8sHHXNTwFUTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/yOL/EX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k1hzt2sk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/yOL/EX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k1hzt2sk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AA9B2120B;
	Tue, 29 Apr 2025 09:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745920499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xlHQqP7IumQSWX28RlWg5A7y/SFv7iickr6pEHy2mI=;
	b=y/yOL/EXPIhgLHCTn3kEuHw2QuB5slroRXNaWjQ2Yt8yGhdWb/s+HMm+Fm0iG2CiqKDhCq
	3dFqcVy/ElFOAdYfVb02jVDXKgtF/+m2yW947OF1urfkCUIWFeIEIw6/p/KguIXYaen9/t
	DO30xmO5z6jE12pxS0LtKduR6LByS7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745920499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xlHQqP7IumQSWX28RlWg5A7y/SFv7iickr6pEHy2mI=;
	b=k1hzt2skMNFN0GRxEC714b5zn1wQ11lWK+hyC2EXkFcXDZwtVc7ElMJjwyHd3+ygW680ky
	c6swYpr7pFJKgTAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745920499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xlHQqP7IumQSWX28RlWg5A7y/SFv7iickr6pEHy2mI=;
	b=y/yOL/EXPIhgLHCTn3kEuHw2QuB5slroRXNaWjQ2Yt8yGhdWb/s+HMm+Fm0iG2CiqKDhCq
	3dFqcVy/ElFOAdYfVb02jVDXKgtF/+m2yW947OF1urfkCUIWFeIEIw6/p/KguIXYaen9/t
	DO30xmO5z6jE12pxS0LtKduR6LByS7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745920499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xlHQqP7IumQSWX28RlWg5A7y/SFv7iickr6pEHy2mI=;
	b=k1hzt2skMNFN0GRxEC714b5zn1wQ11lWK+hyC2EXkFcXDZwtVc7ElMJjwyHd3+ygW680ky
	c6swYpr7pFJKgTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D5001340C;
	Tue, 29 Apr 2025 09:54:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GO94IvOhEGg2IwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Apr 2025 09:54:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D006A0952; Tue, 29 Apr 2025 11:54:51 +0200 (CEST)
Date: Tue, 29 Apr 2025 11:54:51 +0200
From: Jan Kara <jack@suse.cz>
To: alexjlzheng@gmail.com
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH] fs: remove useless plus one in super_cache_scan()
Message-ID: <7k7og24ts2sfulbqni7dtosknr5nng4p6l5zfu4mrbyoqfd6mz@wfslwlrlcaux>
References: <20250428135050.267297-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428135050.267297-1-alexjlzheng@tencent.com>
X-Spam-Score: -3.79
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.968];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 28-04-25 21:50:50, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> After commit 475d0db742e3 ("fs: Fix theoretical division by 0 in
> super_cache_scan()."), there's no need to plus one to prevent
> division by zero.
> 
> Remove it to simplify the code.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>

Fair enough. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 97a17f9d9023..6bbdb7e59a8d 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -201,7 +201,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
>  
>  	inodes = list_lru_shrink_count(&sb->s_inode_lru, sc);
>  	dentries = list_lru_shrink_count(&sb->s_dentry_lru, sc);
> -	total_objects = dentries + inodes + fs_objects + 1;
> +	total_objects = dentries + inodes + fs_objects;
>  	if (!total_objects)
>  		total_objects = 1;
>  
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

