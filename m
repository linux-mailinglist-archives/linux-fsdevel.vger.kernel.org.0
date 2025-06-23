Return-Path: <linux-fsdevel+bounces-52531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B938EAE3DF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BD21690B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302A23C51C;
	Mon, 23 Jun 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hav97a+e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r48NwYQC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hav97a+e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r48NwYQC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029DCDDD3
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678293; cv=none; b=bNytHBnynEhySx/ErTSGYHNQcKdmfaqWn5JJSQC+ZXZ13+P/btjCiiI5g24Q+iew+2bcH+/gl5oM5C3y6RyLtqKQO3P5BUVUA0+CRDMqLoJbJ9v0zn8a49Gnu+9mVealpix2/ccu64ZHSs4qLTDePOeGRcJFzzrC2VXaxdxV8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678293; c=relaxed/simple;
	bh=FzEK/GVKmfAL6fHSenCBQOg959Vi0uWTVy4t/nc9Z5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFGjQaFL8pgUOC9CXYmDin9pr8oHxgStoLXe8OZy7twe+wCVzSz9TjpXkbMc/TLDwxL9a7J6/wuo+OovBVbyr6ys/IoATa4kP5qu6GHUXbU/SrpwwGjiaGxsYuJ/yXjAf2gKgNwsA+STMBfxOfi/1mZtkn/Mw/8I0JpE26JwaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hav97a+e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r48NwYQC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hav97a+e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r48NwYQC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37B5C21179;
	Mon, 23 Jun 2025 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750678290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbEmB7UzynztAWMFQtkILF89X2D/VnXEQQuC9A8fqMc=;
	b=hav97a+eyDHAZZ6GyxH8UocJInfQIozbWn4HMb798p7SebMo+vi/UTWyoJ5uqwjlWL0GbE
	NShy4MY+BfhCI/ZhrwzzvM7zRskb2WZnqJABc5wBi8uz2s8Oh+pzH+HIrZHOQqoZYIxNm2
	qaGu7qvcyYBF9leRvZfrkM3hprvLaDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750678290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbEmB7UzynztAWMFQtkILF89X2D/VnXEQQuC9A8fqMc=;
	b=r48NwYQCkWOZLMAq4tNtJ/2zRtwwE3MQcevZd28KQ5LLLPXZTVDgIfTUjvBaIKFwWBurT/
	0q8ZRlkilU40zHBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750678290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbEmB7UzynztAWMFQtkILF89X2D/VnXEQQuC9A8fqMc=;
	b=hav97a+eyDHAZZ6GyxH8UocJInfQIozbWn4HMb798p7SebMo+vi/UTWyoJ5uqwjlWL0GbE
	NShy4MY+BfhCI/ZhrwzzvM7zRskb2WZnqJABc5wBi8uz2s8Oh+pzH+HIrZHOQqoZYIxNm2
	qaGu7qvcyYBF9leRvZfrkM3hprvLaDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750678290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbEmB7UzynztAWMFQtkILF89X2D/VnXEQQuC9A8fqMc=;
	b=r48NwYQCkWOZLMAq4tNtJ/2zRtwwE3MQcevZd28KQ5LLLPXZTVDgIfTUjvBaIKFwWBurT/
	0q8ZRlkilU40zHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C36013A27;
	Mon, 23 Jun 2025 11:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3l3EChI7WWigMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 11:31:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CEA1CA2A00; Mon, 23 Jun 2025 13:31:25 +0200 (CEST)
Date: Mon, 23 Jun 2025 13:31:25 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@kernel.org
Subject: Re: [PATCH 1/9] fhandle: raise FILEID_IS_DIR in handle_type
Message-ID: <3hip4v5b4ic4kyt4hlkc26yjugja4fmmkxpli7jqyievyak4ky@5srhdoadfc7p>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-1-75899d67555f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-work-pidfs-fhandle-v1-1-75899d67555f@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 23-06-25 11:01:23, Christian Brauner wrote:
> Currently FILEID_IS_DIR is raised in fh_flags which is wrong.
> Raise it in handle->handle_type were it's supposed to be.
> 
> Fixes: c374196b2b9f ("fs: name_to_handle_at() support for "explicit connectable" file handles")
> Cc: <stable@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Indeed. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 3e092ae6d142..66ff60591d17 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -88,7 +88,7 @@ static long do_sys_name_to_handle(const struct path *path,
>  		if (fh_flags & EXPORT_FH_CONNECTABLE) {
>  			handle->handle_type |= FILEID_IS_CONNECTABLE;
>  			if (d_is_dir(path->dentry))
> -				fh_flags |= FILEID_IS_DIR;
> +				handle->handle_type |= FILEID_IS_DIR;
>  		}
>  		retval = 0;
>  	}
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

