Return-Path: <linux-fsdevel+bounces-70552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB2C9EB81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 11:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39FCA347EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FD22EE5FE;
	Wed,  3 Dec 2025 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JLFPqAZf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fpFECRUM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DQFsljqc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M4+ziySD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D2C2EDD71
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764757955; cv=none; b=kX4cfqOf9KHvFv5txwCWA63nqyLmMz7CCOSo0fTm+auMGkLyifEUiB4XGn9qKlAP2Kl6oXTweWBhjVNxi4UEK2jj3RGpcZ8cyAZgTIoCs9c416bkc4gmP69R6VzVdy8h87Ki32hnsusF8hOnSd7ZRLbayhKWeCqzoNQ0wNOQJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764757955; c=relaxed/simple;
	bh=ZU9H9OJQaUt9aNepbCEcn0R7W3D8YmlAyaJoTMPdETQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmOSDRQ5MR+Avw4XjDOgvVEFdF1LPiRpZ/jRQm020GVCpM4S0E7HGpcZrgodaFwc4hM//wHjt0MV68XU9G6Ei6r+C3Ut7yyAKGDwv1TIkX9B+03qPeXxKCBlcTwBDWsM3KqZ6iYZxgyVEwE5ubgxsYjIFBEMQfMTGXtgEe+cvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JLFPqAZf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fpFECRUM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DQFsljqc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M4+ziySD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E28015BDF6;
	Wed,  3 Dec 2025 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764757951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5l2XamvHYNETpa7/z53JbGUFJ0OFRrpCPOyHEkKG1bc=;
	b=JLFPqAZfVcSf5ke3xnnjxQzqYnsMmgSvBRM143+mjjNlaEOqVeRIrhpkxX8gX+H+OyqMTP
	1kKT1jx7YnmSKHh6LDF7XFQBdCMYtNAJIPPfD/XX4hRWpjRSHhlRJYwpjVXT+EnzI3Wslv
	cVNulCCc/i5iXxLOTWO999cZsQByGRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764757951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5l2XamvHYNETpa7/z53JbGUFJ0OFRrpCPOyHEkKG1bc=;
	b=fpFECRUMz7G0pefD0NQlaXJoT7pBC8DNMlnKixB9Rppris32xZA6kuh+cssF9gVZIAJdjv
	R5DyoBAFI6fgVFDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764757950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5l2XamvHYNETpa7/z53JbGUFJ0OFRrpCPOyHEkKG1bc=;
	b=DQFsljqczEs+JSf/kOkCSLO7poTN/cNAPJstNnRiBvN80LzQBRTYHnQ7x3Zr43Q7fWyTeM
	6CLuEuR2EEM6VbVVaCapANX4soDvrPkyD4ZdZ7qDvdCiV+C3BfS7VReSwV0NbEpJkz0qJ9
	Mqp2f9Q8BpucxUkcEkEH60rvjYKWr+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764757950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5l2XamvHYNETpa7/z53JbGUFJ0OFRrpCPOyHEkKG1bc=;
	b=M4+ziySDTfjAFd0MSpzFpk+tRzYEzg77WL1l7AJ5vB3xST1TsfSebp/mit7ptmIKO6Afqj
	q9P/2+QyGYVFvMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D618B3EA63;
	Wed,  3 Dec 2025 10:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WhGQM74RMGknSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Dec 2025 10:32:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 88CBCA09B4; Wed,  3 Dec 2025 11:32:26 +0100 (CET)
Date: Wed, 3 Dec 2025 11:32:26 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: annotate cdev_lock with __cacheline_aligned_in_smp
Message-ID: <rlza53wd3zlgfeepceg6qe6ffd4a73jmwrcyzpmz3xivhydiw6@recoc3rucmir>
References: <20251203095508.291073-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203095508.291073-1-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Wed 03-12-25 10:55:08, Mateusz Guzik wrote:
> No need for the crapper to be susceptible to false-sharing.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/char_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index c2ddb998f3c9..84a5a0699373 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -343,7 +343,7 @@ void __unregister_chrdev(unsigned int major, unsigned int baseminor,
>  	kfree(cd);
>  }
>  
> -static DEFINE_SPINLOCK(cdev_lock);
> +static __cacheline_aligned_in_smp DEFINE_SPINLOCK(cdev_lock);
>  
>  static struct kobject *cdev_get(struct cdev *p)
>  {
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

