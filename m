Return-Path: <linux-fsdevel+bounces-58826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB91B31BB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B7CB2750C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D4B30AAC6;
	Fri, 22 Aug 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQXDKKsJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8VuhjnPo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQXDKKsJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8VuhjnPo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2031305E15
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872461; cv=none; b=aSd7/ksz3YoGXDdHiCCiYe3cVDB+09LmbJ3T708nS5Na3UkK2W9qHTFe3Y643goDO4TRjwsFPptVTpvFAlko0+b1WWeHjCDeJZUswfMe2Mny21k3eoB2bKmO7lBpj+enKHnncPnO4MEvsaBvnBba5okjKYdcUPJ5ycnIMXPXQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872461; c=relaxed/simple;
	bh=5UmMfYB8VQJrXom+sSwT/BdHnJFPQzY5BsCfFzL+REk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbgH78H/EFlU2J5e2f3QT+qVYc0OZd8qNfyeHKp2QhczgmygkBP0eO0vFvVubsNZou7AC8NHNGkxc/L0EjeZbdWmvafxWg3BMghuCNLxVbhZGmlPAsEtpqlUk2+W89ssQ4mSTuBD2sOiUlpg/7k2TOR9jrfN1IX5EtmiG1krhAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQXDKKsJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8VuhjnPo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQXDKKsJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8VuhjnPo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08CE71F38E;
	Fri, 22 Aug 2025 14:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755872458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNV9HgGj7j9d/w8hFOK9SrZRpzIjmhafNRzujve3/6A=;
	b=BQXDKKsJN7V18tZHZLJeMv9Rt0jTOdFS4hRWSKN+kYYvUlBLGEHSza0kocv5BdwzTtxkHT
	guGtrCukQdrnp/7TWFs8V3O4uwIbH3Ss1531DJdfIRyzGKcGEWwg+phLbXEpn7NtKCbZQa
	J61wQ3DzFckGn7ved4o+CI+bFCXsNOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755872458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNV9HgGj7j9d/w8hFOK9SrZRpzIjmhafNRzujve3/6A=;
	b=8VuhjnPok1hh6LhxdmeT9lh0ozTyRcbu6NDlyEWXkWIEny9oFJlZbkYdnQrqhz7rSL0YrC
	W99LzFrBfZgYsmCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755872458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNV9HgGj7j9d/w8hFOK9SrZRpzIjmhafNRzujve3/6A=;
	b=BQXDKKsJN7V18tZHZLJeMv9Rt0jTOdFS4hRWSKN+kYYvUlBLGEHSza0kocv5BdwzTtxkHT
	guGtrCukQdrnp/7TWFs8V3O4uwIbH3Ss1531DJdfIRyzGKcGEWwg+phLbXEpn7NtKCbZQa
	J61wQ3DzFckGn7ved4o+CI+bFCXsNOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755872458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNV9HgGj7j9d/w8hFOK9SrZRpzIjmhafNRzujve3/6A=;
	b=8VuhjnPok1hh6LhxdmeT9lh0ozTyRcbu6NDlyEWXkWIEny9oFJlZbkYdnQrqhz7rSL0YrC
	W99LzFrBfZgYsmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E89FB13931;
	Fri, 22 Aug 2025 14:20:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AUjIOMl8qGi1CAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Aug 2025 14:20:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5D625A0999; Fri, 22 Aug 2025 16:20:57 +0200 (CEST)
Date: Fri, 22 Aug 2025 16:20:57 +0200
From: Jan Kara <jack@suse.cz>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Use try_cmpxchg() in start_dir_add()
Message-ID: <buw7x4axu2vojhr5mtjtrfnbynianng42atvzz7gk2t2tbjvqc@tvfo7bbjkgsx>
References: <20250811125308.616717-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811125308.616717-1-ubizjak@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 11-08-25 14:52:38, Uros Bizjak wrote:
> Use try_cmpxchg() instead of cmpxchg(*ptr, old, new) == old.
> 
> The x86 CMPXCHG instruction returns success in the ZF flag,
> so this change saves a compare after CMPXCHG (and related
> move instruction in front of CMPXCHG).
> 
> Note that the value from *ptr should be read using READ_ONCE() to
> prevent the compiler from merging, refetching or reordering the read.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 60046ae23d51..336bdb4c4b1f 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2509,8 +2509,8 @@ static inline unsigned start_dir_add(struct inode *dir)
>  {
>  	preempt_disable_nested();
>  	for (;;) {
> -		unsigned n = dir->i_dir_seq;
> -		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) == n)
> +		unsigned n = READ_ONCE(dir->i_dir_seq);
> +		if (!(n & 1) && try_cmpxchg(&dir->i_dir_seq, &n, n + 1))
>  			return n;
>  		cpu_relax();
>  	}
> -- 
> 2.50.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

