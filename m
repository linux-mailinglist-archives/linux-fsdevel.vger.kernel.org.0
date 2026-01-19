Return-Path: <linux-fsdevel+bounces-74419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B1D3A2B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB2030150D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E509355803;
	Mon, 19 Jan 2026 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="muNJLIIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1mvLXEdG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="muNJLIIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1mvLXEdG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93635502D
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814464; cv=none; b=Kg76pgUTtMkCUNTPFhSQN7CiZ3bpfK4cClptj9/Eds9s/3btUV5m7u/lwIUWodx1KlNyTphWjUFV6ReAwMrBfVpTU9Punr0M4rTzq78h84PwvDZX4XHrpP1jrArNF0+HD7ZJFzTplAqxQGMN/fDar7g2jnH3NdLUzaQ1+bQwGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814464; c=relaxed/simple;
	bh=GoA5afYpTq5wbIlLlRMGhBadbyyKr08yboEePO96ZnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+RIutcLuS5QjwNcA4h5ijugla6Vc/11hI2DHGBJVpoT40dxj/63DNP9mp5b7EUXmeiVx+vujAsp8Kpdq9V4wgwZr3aLLwMigeQvWovBdXweLIOa9UmYtcUydxHMq74bW1TpvPPs+P9ZvNCu4faWOakq4pqaSF5DDJicJabRxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=muNJLIIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1mvLXEdG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=muNJLIIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1mvLXEdG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D470336FE;
	Mon, 19 Jan 2026 09:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768814460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kov4TxJ75N/pNeC/fZMYG2YU8YoOuyYPf6L+iQt/4AE=;
	b=muNJLIIWILm2zOOIfaF7GR0O61mgNXJDJxnhNkE/G7EP8d9R0bWUntUoOBk5YnEVIFTGW3
	RYJS6rE/OlyL02VXTD8v1X88IXrhOUPZedSf9xRpDPozNj5/6+hn2NohF/eG66JYWT2/zR
	iLXqPdDl8J0Mg5gX2hBgvP6QKiph8aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768814460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kov4TxJ75N/pNeC/fZMYG2YU8YoOuyYPf6L+iQt/4AE=;
	b=1mvLXEdGWwlXE1uRbDC3588tOtZSw/ezk3rT1XW+sAst3tauFVLQc4m70Cs0wksJzUrN8G
	EGWYIUtJX+m68uDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768814460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kov4TxJ75N/pNeC/fZMYG2YU8YoOuyYPf6L+iQt/4AE=;
	b=muNJLIIWILm2zOOIfaF7GR0O61mgNXJDJxnhNkE/G7EP8d9R0bWUntUoOBk5YnEVIFTGW3
	RYJS6rE/OlyL02VXTD8v1X88IXrhOUPZedSf9xRpDPozNj5/6+hn2NohF/eG66JYWT2/zR
	iLXqPdDl8J0Mg5gX2hBgvP6QKiph8aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768814460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kov4TxJ75N/pNeC/fZMYG2YU8YoOuyYPf6L+iQt/4AE=;
	b=1mvLXEdGWwlXE1uRbDC3588tOtZSw/ezk3rT1XW+sAst3tauFVLQc4m70Cs0wksJzUrN8G
	EGWYIUtJX+m68uDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 925DC3EA63;
	Mon, 19 Jan 2026 09:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hTi1I3z3bWnzSgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Jan 2026 09:21:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 60DD6A0A29; Mon, 19 Jan 2026 10:21:00 +0100 (CET)
Date: Mon, 19 Jan 2026 10:21:00 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 4/6] fsverity: use a hashtable to find the fsverity_info
Message-ID: <z4652hoxetll645hgpfuhy3pogm5y32ealgydlaz4kwve6qc2g@bl6ilzut2ybp>
References: <20260119062250.3998674-1-hch@lst.de>
 <20260119062250.3998674-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119062250.3998674-5-hch@lst.de>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO

On Mon 19-01-26 07:22:45, Christoph Hellwig wrote:
> Use the kernel's resizable hash table to find the fsverity_info.  This
> way file systems that want to support fsverity don't have to bloat
> every inode in the system with an extra pointer.  The tradeoff is that
> looking up the fsverity_info is a bit more expensive now, but the main
> operations are still dominated by I/O and hashing overhead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

...

> diff --git a/fs/verity/enable.c b/fs/verity/enable.c
> index 95ec42b84797..91cada0d455c 100644
> --- a/fs/verity/enable.c
> +++ b/fs/verity/enable.c
> @@ -264,9 +264,24 @@ static int enable_verity(struct file *filp,
>  		goto rollback;
>  	}
>  
> +	/*
> +	 * Add the fsverity_info into the hash table before finishing the
> +	 * initialization.  This ensures we don't have to undo the enabling when
> +	 * memory allocation for the hash table fails.  This is safe because
> +	 * looking up the fsverity_info always first checks the S_VERITY flag on
> +	 * the inode, which will only be set at the very end of the
> +	 * ->end_enable_verity method.
> +	 */
> +	err = fsverity_set_info(vi);
> +	if (err)
> +		goto rollback;

OK, but since __fsverity_get_info() is just rhashtable_lookup_fast() what
prevents the CPU from reordering the hash table reads before the S_VERITY
check? I think you need a barrier in fsverity_get_info() to enforce the
proper ordering. The matching ordering during setting of S_VERITY is
implied by cmpxchg used to manipulate i_flags so that part should be fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

