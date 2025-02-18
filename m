Return-Path: <linux-fsdevel+bounces-41986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B126A39B98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 13:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096191888FB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060524338D;
	Tue, 18 Feb 2025 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TAREbrzY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnAnKXVx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TAREbrzY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnAnKXVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A4243360
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879981; cv=none; b=hsRxZh9/Ih0umXNwva2KgwYyFgD65ik4jU8/j3nAM8t63asDi2vPPHxVLhxv6ZtUtPfNUKU1hVvAxLnq63X998E4SG8aDYX5rTgV4WAFoKs5Rrzf8Kwdff9g5UpBZVIp7dT6/VzCgjsP4G54kmDsalKhUBNjax51aJ/KLL1XisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879981; c=relaxed/simple;
	bh=uvY12ll0+h1JvJ9Mw86EYSrYQTnm9N8kMKjrmKSQxcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnmCjZWVProJ5DzDD6ydw0lEYOsCeaMZHWQUFoeQbocu50M9Y5kIjwE5y/hVZGh1xv3kUqvAGYk26Pvsh2zSE1AWOaEGQKPhnZzlgda2iohs/bok6cR+b78VHyV2T67N38xTRHXrleQYAE8iK1y2L8LfDANU6oHXt61vrxJh2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TAREbrzY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnAnKXVx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TAREbrzY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnAnKXVx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9A262116B;
	Tue, 18 Feb 2025 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739879977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ol1flL+Hvau9bpFE3r/g/0SVaK1xls8DuJbRXxcnKyk=;
	b=TAREbrzYm/GkYrsT1QJamu5iMjt/5xUwjoQMEnqqkYt99T3jWyJW/a2BfUCTrz6A+A4owJ
	CsIqQaiW6JklmDANH9sGL5vkOdAo1Kb0Lq1sLZAAkM+hDusehlZFsd58dwvT3fR+0Vtdl3
	sN6YdRKQW76ikT/EzRbPc5wc5PHXlOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739879977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ol1flL+Hvau9bpFE3r/g/0SVaK1xls8DuJbRXxcnKyk=;
	b=lnAnKXVxNA5uaLoLaae5n43I9hPNQyiNrcMlhJt/y8XH6rax9tMuDzihEOBd/SJfoWWgx1
	k4TNWjgqSEtA73BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TAREbrzY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lnAnKXVx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739879977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ol1flL+Hvau9bpFE3r/g/0SVaK1xls8DuJbRXxcnKyk=;
	b=TAREbrzYm/GkYrsT1QJamu5iMjt/5xUwjoQMEnqqkYt99T3jWyJW/a2BfUCTrz6A+A4owJ
	CsIqQaiW6JklmDANH9sGL5vkOdAo1Kb0Lq1sLZAAkM+hDusehlZFsd58dwvT3fR+0Vtdl3
	sN6YdRKQW76ikT/EzRbPc5wc5PHXlOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739879977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ol1flL+Hvau9bpFE3r/g/0SVaK1xls8DuJbRXxcnKyk=;
	b=lnAnKXVxNA5uaLoLaae5n43I9hPNQyiNrcMlhJt/y8XH6rax9tMuDzihEOBd/SJfoWWgx1
	k4TNWjgqSEtA73BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE9F2132C7;
	Tue, 18 Feb 2025 11:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QASgKil2tGfrKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Feb 2025 11:59:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 76231A08B5; Tue, 18 Feb 2025 12:59:37 +0100 (CET)
Date: Tue, 18 Feb 2025 12:59:37 +0100
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Dave Chinner <david@fromorbit.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] vfs: export invalidate_inodes()
Message-ID: <ze23goaoxiryaczmik3y66p23c35tf3ipfw27prlozrqciqlap@6lmpmsx7xsy3>
References: <20250216165008.6671-1-luis@igalia.com>
 <20250216165008.6671-2-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216165008.6671-2-luis@igalia.com>
X-Rspamd-Queue-Id: B9A262116B
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,igalia.com:email];
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

On Sun 16-02-25 16:50:07, Luis Henriques wrote:
> Signed-off-by: Luis Henriques <luis@igalia.com>

Please use evict_inodes(). It is already exported and does exactly the same
these days. We should really merge the patch deleting invalidate_inodes()
:)

									Honza

> ---
>  fs/inode.c         | 1 +
>  fs/internal.h      | 1 -
>  include/linux/fs.h | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 5587aabdaa5e..88387ecb2c34 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -939,6 +939,7 @@ void invalidate_inodes(struct super_block *sb)
>  
>  	dispose_list(&dispose);
>  }
> +EXPORT_SYMBOL(invalidate_inodes);
>  
>  /*
>   * Isolate the inode from the LRU in preparation for freeing it.
> diff --git a/fs/internal.h b/fs/internal.h
> index e7f02ae1e098..7cb515cede3f 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -207,7 +207,6 @@ bool in_group_or_capable(struct mnt_idmap *idmap,
>   * fs-writeback.c
>   */
>  extern long get_nr_dirty_inodes(void);
> -void invalidate_inodes(struct super_block *sb);
>  
>  /*
>   * dcache.c
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2c3b2f8a621f..ff016885646e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3270,6 +3270,7 @@ extern void discard_new_inode(struct inode *);
>  extern unsigned int get_next_ino(void);
>  extern void evict_inodes(struct super_block *sb);
>  void dump_mapping(const struct address_space *);
> +extern void invalidate_inodes(struct super_block *sb);
>  
>  /*
>   * Userspace may rely on the inode number being non-zero. For example, glibc
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

