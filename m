Return-Path: <linux-fsdevel+bounces-25432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB7794C267
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089001F25193
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41807190072;
	Thu,  8 Aug 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xYCDjqeR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TU+e/szu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xYCDjqeR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TU+e/szu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45918E02D;
	Thu,  8 Aug 2024 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133783; cv=none; b=KUdF2/ZQtTD3nYMFaRfThPNeChR4VAcZkVyxiOBn/F1niq4Oeqp4Q4QEwukVS2xXTWJqiJFpdCRdOSFLDuaWgFMtrpFY+Jj0nPdZoBTrp8JYEU5Re1F7WUyfQ5T9mPlCMy4Kt2AAmopZ1dnJKIxPNYxiVtQrV+fbK+P/bA9P6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133783; c=relaxed/simple;
	bh=oiNt3zQhf2fAbHacBRwBrXzakGMPA8rWzLwHAOmexrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QE+vTaIjuvxeZf0PBBQUeo3mQb22EVCu1J1u6GZJWbN1lP6U/PEPFsNxZ0EoUqrJ/SgTW9YhMqG6YDMyl8BdfKFN3BQ12g7I6hdWt/ru/Z8eTeK5xbRglwxf94WgGBhhcPJObafatUNRp9+GG5Vr2vtG42YuCouLmoOHNdSG4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xYCDjqeR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TU+e/szu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xYCDjqeR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TU+e/szu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1312E21A78;
	Thu,  8 Aug 2024 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723133774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0ohOEvrrS1lZvLDs9GuVUY/ywqsHb0YvG8L7If+N7s=;
	b=xYCDjqeRAVKndLrwWQDtZ5/JWy8rNc0Fn0aB17nOHB4vPD+vaWkRBUyIzBknyeTDj3idOe
	Qdj5j9VcyGd61Hh38CtnlWnwWQasLU1o9EK0hw9TlZQYEXsdJYV0R4VF5eJXmqe/VWHaVy
	DWaFi3nCJL7VMxlts+tXj+f/KGocMa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723133774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0ohOEvrrS1lZvLDs9GuVUY/ywqsHb0YvG8L7If+N7s=;
	b=TU+e/szuJtgHxNxlUqDjBe9YFGuLi1DaLzmNPOtuHJ4qBbmdUEurUDf5xQQfxpf8KM8ReZ
	/f2RoIWsZnE1K+CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723133774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0ohOEvrrS1lZvLDs9GuVUY/ywqsHb0YvG8L7If+N7s=;
	b=xYCDjqeRAVKndLrwWQDtZ5/JWy8rNc0Fn0aB17nOHB4vPD+vaWkRBUyIzBknyeTDj3idOe
	Qdj5j9VcyGd61Hh38CtnlWnwWQasLU1o9EK0hw9TlZQYEXsdJYV0R4VF5eJXmqe/VWHaVy
	DWaFi3nCJL7VMxlts+tXj+f/KGocMa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723133774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0ohOEvrrS1lZvLDs9GuVUY/ywqsHb0YvG8L7If+N7s=;
	b=TU+e/szuJtgHxNxlUqDjBe9YFGuLi1DaLzmNPOtuHJ4qBbmdUEurUDf5xQQfxpf8KM8ReZ
	/f2RoIWsZnE1K+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 088E113B20;
	Thu,  8 Aug 2024 16:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5/ISAk7vtGY7KQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Aug 2024 16:16:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 93A88A0851; Thu,  8 Aug 2024 18:16:09 +0200 (CEST)
Date: Thu, 8 Aug 2024 18:16:09 +0200
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: don't set SB_RDONLY after filesystem errors
Message-ID: <20240808161609.xntlkgsglosowndg@quack3>
References: <20240805201241.27286-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805201241.27286-1-jack@suse.cz>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Mon 05-08-24 22:12:41, Jan Kara wrote:
> When the filesystem is mounted with errors=remount-ro, we were setting
> SB_RDONLY flag to stop all filesystem modifications. We knew this misses
> proper locking (sb->s_umount) and does not go through proper filesystem
> remount procedure but it has been the way this worked since early ext2
> days and it was good enough for catastrophic situation damage
> mitigation. Recently, syzbot has found a way (see link) to trigger
> warnings in filesystem freezing because the code got confused by
> SB_RDONLY changing under its hands. Since these days we set
> EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
> stop doing that.
> 
> Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
> Reported-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> Note that this patch introduces fstests failure with generic/459 test
> because it assumes that either freezing succeeds or 'ro' is among mount
> options. But we fail the freeze with EFSCORRUPTED. This needs fixing in
> the test but at this point I'm not sure how exactly.

OK, I have noticed that recent versions of fstests have the check already
improved and so generic/459 passes with these changes.

								Honza
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index e72145c4ae5a..93c016b186c0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  
>  	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
>  	/*
> -	 * Make sure updated value of ->s_mount_flags will be visible before
> -	 * ->s_flags update
> +	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
> +	 * modifications. We don't set SB_RDONLY because that requires
> +	 * sb->s_umount semaphore and setting it without proper remount
> +	 * procedure is confusing code such as freeze_super() leading to
> +	 * deadlocks and other problems.
>  	 */
> -	smp_wmb();
> -	sb->s_flags |= SB_RDONLY;
>  }
>  
>  static void update_super_work(struct work_struct *work)
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

