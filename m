Return-Path: <linux-fsdevel+bounces-60487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8734BB488D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E132E16DB69
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02772EDD41;
	Mon,  8 Sep 2025 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ycYHYxc2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHipa5h5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ycYHYxc2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHipa5h5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE992EE61D
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324496; cv=none; b=EQagT3QPRRadzmehFJfsgT/eonwIjmSIsJtyYDq6QcYHINzNQlZFkEpDWbJffZgb8sqw7tqraxIvPjTLu7tl0zMGOmSYyS39k1zWVxegbcNaF2O9vSLuwpLaCy4qWylsEXYrIcqmIQ2pIif3xRU/pdIEUdQVt9NvdDUA9gowE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324496; c=relaxed/simple;
	bh=kIZdooWjj5kX7B/uKdUVkBR3x5cHY023GhNOlueWl9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT9fbutQkkBsh9y/Ft6qtoyRe/OdRkwwePYmsHYnq+EAAzv3lYBYEpWWxEyfSbx8wKOi4uZQqs8BmmJxhOj8+TAv8kKD6GB6IEzTTtArB5fAGiDWGa+nFJBbpbx6VCX7TBdJNXZ0HR6Mupm7+a/G5xdswUaDHwXpLJ0AU2eez98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ycYHYxc2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHipa5h5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ycYHYxc2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHipa5h5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFA42267FF;
	Mon,  8 Sep 2025 09:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+0UlUP5n/1CmXCm8NJu4n8+dMqAuMbRbVZZErL5FhXQ=;
	b=ycYHYxc2Dkk12e0Fvv2MFOOz5FklBbaEgS3l6dkyisF9FFzB8rr63E6a84vLBlmNwnGw2N
	sqgZzuPegmhkzLs3jvxxKyLDLoP+OhdZkPWyMuIen4zxP+1/6pzQJcsX5J0k3ppoiNIAMN
	L6/tq45VtjfkxzBStM7/4fxjKbvaBlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+0UlUP5n/1CmXCm8NJu4n8+dMqAuMbRbVZZErL5FhXQ=;
	b=HHipa5h5hXPUGGhc12A99AwoHNx6ZlcBZ6E2pqsl1CraWjqXyTuCoSt0alSiL3Kk0x7B2B
	H0q5XHV1UKU7A8Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+0UlUP5n/1CmXCm8NJu4n8+dMqAuMbRbVZZErL5FhXQ=;
	b=ycYHYxc2Dkk12e0Fvv2MFOOz5FklBbaEgS3l6dkyisF9FFzB8rr63E6a84vLBlmNwnGw2N
	sqgZzuPegmhkzLs3jvxxKyLDLoP+OhdZkPWyMuIen4zxP+1/6pzQJcsX5J0k3ppoiNIAMN
	L6/tq45VtjfkxzBStM7/4fxjKbvaBlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+0UlUP5n/1CmXCm8NJu4n8+dMqAuMbRbVZZErL5FhXQ=;
	b=HHipa5h5hXPUGGhc12A99AwoHNx6ZlcBZ6E2pqsl1CraWjqXyTuCoSt0alSiL3Kk0x7B2B
	H0q5XHV1UKU7A8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B68E713869;
	Mon,  8 Sep 2025 09:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mgeOLMykvmhfbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:41:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 832DAA0A2D; Mon,  8 Sep 2025 11:41:32 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:41:32 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 06/21] nfs: constify path argument of __vfs_getattr()
Message-ID: <eykdouumgbph2twxhfslinhwxr7wqonsmayj7vm47wrhhpl3ig@7dkgad46m6sk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-6-viro@zeniv.linux.org.uk>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,linux-foundation.org,gmail.com,oracle.com,apparmor.net];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,linux.org.uk:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Sat 06-09-25 10:11:22, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/nfs/localio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index bd5fca285899..1f5d8c5f67ec 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -529,7 +529,7 @@ nfs_set_local_verifier(struct inode *inode,
>  }
>  
>  /* Factored out from fs/nfsd/vfs.h:fh_getattr() */
> -static int __vfs_getattr(struct path *p, struct kstat *stat, int version)
> +static int __vfs_getattr(const struct path *p, struct kstat *stat, int version)
>  {
>  	u32 request_mask = STATX_BASIC_STATS;
>  
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

