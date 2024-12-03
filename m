Return-Path: <linux-fsdevel+bounces-36351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815269E27CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 17:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04896B43FD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A751F7070;
	Tue,  3 Dec 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UyW5Co6A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6GI7+aqu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UyW5Co6A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6GI7+aqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAB41DE2A1;
	Tue,  3 Dec 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237652; cv=none; b=noowhmQxf8X10s2xKMlRGGfhPqqYgoyLH7qM1Ned6ufbvQy+eiXjCedAhF+6FBJYYm7twVNtAQ98gt/l+Ldx5ycAbmGKx91cmrhFc0ZWIdKmCoLY1VYyZfHB0xjP1KiWXazY7toTygCQD6KROtJtYH52xWyeAF8cwXegEbDLwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237652; c=relaxed/simple;
	bh=Cgp0aVpGuH/a2to/EWgDyXZphEaJ74fnS/zi9gCJoQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndOJLXogwK9jtwUi4Uy/iLi+M4F2YOwA2cFJdqd7OfEOYFc3wZfuGxIhu8B6EuldINwgMMkqn/1ds2Rr6d8j/mN7PrOGKlsAIVeC2dpQLSJMgsTnKUt5MItlQhfzc02l53rLN1+tO2duvTtdIt6IZ/SQu+XR0uJOwnsUHVH9SW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UyW5Co6A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6GI7+aqu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UyW5Co6A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6GI7+aqu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80BC21F445;
	Tue,  3 Dec 2024 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733237648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m4AITg/5U1zUV+aG8sv7Kf09dOMINBEqCs99iqGpvE=;
	b=UyW5Co6ApkcDwAKNJlGLrHKSojoGwIGSLXAxCZTy4MFVYkAKjJHRHntiBysbyYlH1mB6WI
	TbB3rU6KLmCRnkti/MpapENm8xJ6DofM+N0lghnJ7r1RsiguMfdgXO3fajzrCVvd7qZEMf
	h4Pb4V5+d6B7An3+rF3RsugJucWl2bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733237648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m4AITg/5U1zUV+aG8sv7Kf09dOMINBEqCs99iqGpvE=;
	b=6GI7+aquw181fIBAL++ot75wImDroDkys7ITGg3KANQet6YiqztFyNsM6psWAmbDfIs6xD
	mYWieZpjhrNQqwBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UyW5Co6A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6GI7+aqu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733237648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m4AITg/5U1zUV+aG8sv7Kf09dOMINBEqCs99iqGpvE=;
	b=UyW5Co6ApkcDwAKNJlGLrHKSojoGwIGSLXAxCZTy4MFVYkAKjJHRHntiBysbyYlH1mB6WI
	TbB3rU6KLmCRnkti/MpapENm8xJ6DofM+N0lghnJ7r1RsiguMfdgXO3fajzrCVvd7qZEMf
	h4Pb4V5+d6B7An3+rF3RsugJucWl2bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733237648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m4AITg/5U1zUV+aG8sv7Kf09dOMINBEqCs99iqGpvE=;
	b=6GI7+aquw181fIBAL++ot75wImDroDkys7ITGg3KANQet6YiqztFyNsM6psWAmbDfIs6xD
	mYWieZpjhrNQqwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72B51139C2;
	Tue,  3 Dec 2024 14:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mPf8G5AbT2cRPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Dec 2024 14:54:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D9C16A08FB; Tue,  3 Dec 2024 15:54:03 +0100 (CET)
Date: Tue, 3 Dec 2024 15:54:03 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 2/2] jbd2: flush filesystem device before updating tail
 sequence
Message-ID: <20241203145403.5yas7kngvf4gzb6d@quack3>
References: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
 <20241203014407.805916-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203014407.805916-3-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 80BC21F445
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	URIBL_BLOCKED(0.00)[huawei.com:email,suse.com:email,suse.cz:email,suse.cz:dkim];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 03-12-24 09:44:07, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When committing transaction in jbd2_journal_commit_transaction(), the
> disk caches for the filesystem device should be flushed before updating
> the journal tail sequence. However, this step is missed if the journal
> is not located on the filesystem device. As a result, the filesystem may
> become inconsistent following a power failure or system crash. Fix it by
> ensuring that the filesystem device is flushed appropriately.
> 
> Fixes: 3339578f0578 ("jbd2: cleanup journal tail after transaction commit")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Ah, good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 4305a1ac808a..f95cf272a1b5 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -776,9 +776,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	/*
>  	 * If the journal is not located on the file system device,
>  	 * then we must flush the file system device before we issue
> -	 * the commit record
> +	 * the commit record and update the journal tail sequence.
>  	 */
> -	if (commit_transaction->t_need_data_flush &&
> +	if ((commit_transaction->t_need_data_flush || update_tail) &&
>  	    (journal->j_fs_dev != journal->j_dev) &&
>  	    (journal->j_flags & JBD2_BARRIER))
>  		blkdev_issue_flush(journal->j_fs_dev);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

