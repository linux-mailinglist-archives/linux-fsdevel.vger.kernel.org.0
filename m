Return-Path: <linux-fsdevel+bounces-19374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACC8C4237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AA21C21471
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D65153836;
	Mon, 13 May 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yMHlst5y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C1j0Z/kB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yMHlst5y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C1j0Z/kB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29822153506;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607698; cv=none; b=gG0HqWROR0KCn2NA3OYjZ7S/+rCqtM8bPRCR/jHIJTYCcAGQWQmR8ZxK6sZ4I7Ul29UMJFQUPc4InqaROHEc9RiQ4YYJ61V3jBZOrCeZAGkFh7lGOaeICNdhNRrIDej4vm33T8Ohuc1QZ5zUuHFneuR9AU9fwTmVY0GAQBbpot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607698; c=relaxed/simple;
	bh=1EI/UcsIVLUr0m8ZrGqAcbzizFxPtEW4md7T6LrXnWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB71WZPX2mw5AjbxKQ1LgfX1CNCfQ9adcwqo+APNmUm3zN48bFOyGlcU8o3xzSTiGs8YCr9LWdue010bA7rITkgcdzCTLBZbRtKPjOlkAxwmRxQQB319E1SJAQha4us5+pqXt87Vz4tRaSooL3SVm97kI31xxeK1E2UgoHhZfj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yMHlst5y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C1j0Z/kB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yMHlst5y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C1j0Z/kB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B27734A0C;
	Mon, 13 May 2024 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpIPmb5o1aje34T/34PjSM4GjKJ+lGMuc0t9GkRWB5U=;
	b=yMHlst5ypLpWPlkTGlHOSLzZpgmEyvpkEsyZuapj6guclg3FXIou/gOLir/QP/JqWWx7p2
	yILVUYWdsOvgpLssr7VWWarNztrkDlanMRJO3B3NpiwoLD3+NlQDbl74tBMlP+JujE8d50
	QYCHtGrbJHyouul739bTlFH71Lpjqas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpIPmb5o1aje34T/34PjSM4GjKJ+lGMuc0t9GkRWB5U=;
	b=C1j0Z/kBmcz4YMn1TbpL8HH7aweTYdWXd0PyiIzCZ6LxnO1+3Kyc3lc+od4ifhIJeYWXZn
	hwFCLWTH5hWkuqAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yMHlst5y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="C1j0Z/kB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpIPmb5o1aje34T/34PjSM4GjKJ+lGMuc0t9GkRWB5U=;
	b=yMHlst5ypLpWPlkTGlHOSLzZpgmEyvpkEsyZuapj6guclg3FXIou/gOLir/QP/JqWWx7p2
	yILVUYWdsOvgpLssr7VWWarNztrkDlanMRJO3B3NpiwoLD3+NlQDbl74tBMlP+JujE8d50
	QYCHtGrbJHyouul739bTlFH71Lpjqas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpIPmb5o1aje34T/34PjSM4GjKJ+lGMuc0t9GkRWB5U=;
	b=C1j0Z/kBmcz4YMn1TbpL8HH7aweTYdWXd0PyiIzCZ6LxnO1+3Kyc3lc+od4ifhIJeYWXZn
	hwFCLWTH5hWkuqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2384013A67;
	Mon, 13 May 2024 13:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +AT8B44YQmYqDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 93F6AA0891; Sun, 12 May 2024 09:38:12 +0200 (CEST)
Date: Sun, 12 May 2024 09:38:12 +0200
From: Jan Kara <jack@suse.cz>
To: David Howells <dhowells@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: Don't reduce symlink i_mode by umask if no ACL
 support
Message-ID: <20240512073812.fkrbriddfvfj3igp@quack3>
References: <1586868.1715341641@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586868.1715341641@warthog.procyon.org.uk>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6B27734A0C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DATE_IN_PAST(1.00)[30];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]

On Fri 10-05-24 12:47:21, David Howells wrote:
>     
> If CONFIG_EXT4_FS_POSIX_ACL=n then the fallback version of ext4_init_acl()
> will mask off the umask bits from the new inode's i_mode.  This should not
> be done if the inode is a symlink.  If CONFIG_EXT4_FS_POSIX_ACL=y, then we
> go through posix_acl_create() instead which does the right thing with
> symlinks.
> 
> However, this is actually unnecessary now as vfs_prepare_mode() has already
> done this where appropriate, so fix this by making the fallback version of
> ext4_init_acl() do nothing.
> 
> Fixes: 484fd6c1de13 ("ext4: apply umask if ACL support is disabled")
> Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Max Kellermann <max.kellermann@ionos.com>
> cc: Jan Kara <jack@suse.com>
> cc: Christian Brauner <brauner@kernel.org>
> cc: linux-ext4@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/acl.h |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
> index ef4c19e5f570..0c5a79c3b5d4 100644
> --- a/fs/ext4/acl.h
> +++ b/fs/ext4/acl.h
> @@ -68,11 +68,6 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
>  static inline int
>  ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
>  {
> -	/* usually, the umask is applied by posix_acl_create(), but if
> -	   ext4 ACL support is disabled at compile time, we need to do
> -	   it here, because posix_acl_create() will never be called */
> -	inode->i_mode &= ~current_umask();
> -
>  	return 0;
>  }
>  #endif  /* CONFIG_EXT4_FS_POSIX_ACL */
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

