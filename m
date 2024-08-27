Return-Path: <linux-fsdevel+bounces-27343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28DD960726
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B331C20885
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963B219E80A;
	Tue, 27 Aug 2024 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0WYlG5Hx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2JsXxLpH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q4oe7HpK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i0+BRVEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560F19E7E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753280; cv=none; b=fsymM/yWO6l+vVIo0FNA3zRoyigs1wsJ7CfaGssqCQADm2dhzO5jvon43QRedbCArZ7YCn5inUSOzCRLy0sHzzxbgTJmzH+YyoE49v+xpl9Nt+tVeioJE5MCGVXBzFpGqwJTX7qu6kS9S8ay7OWesSam0vdj0vrhk+j5/tki+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753280; c=relaxed/simple;
	bh=wWSxJx9fwl2E+cceb66J5t/TmRucbR1DYMLkQRhpEFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E76shBJrukGJLhjVQ4SLjPM4kHHLMMHx1Zd0WHqbggxKrAoHrY7yrG67aAtTfynC5mVbBNWPG4/mYCU8urnYfjRPzVesP4Ur2gi2uY93IIbnrkekwbH4A7bsmKTTBePCxaSxepO5yCVcvh2gZoSG4WDxFV8rlrkAMUGrAu7bJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0WYlG5Hx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2JsXxLpH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q4oe7HpK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i0+BRVEP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27DBA21B08;
	Tue, 27 Aug 2024 10:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724753276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7t5yk08dbXavxhXEFs0sNC0e9tA/xqnXn9Q7XU6LxDc=;
	b=0WYlG5Hxpb4C2Rc55Vfl3PDuu7dmHiYhZz4ZUSsOfs2RJpkVwMhCONRkgLqU8nZyOJpqD8
	TFUjpAZ7aFwyjMgaNQ0aOIapiXhV8EkAsFK+1DkWP7aNGFqM0y+80D9vbbd22WyT8uAUL6
	ePoGTfhtYVUtrsBke0/NKwmXhqHmZTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724753276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7t5yk08dbXavxhXEFs0sNC0e9tA/xqnXn9Q7XU6LxDc=;
	b=2JsXxLpH5hzXU2kJKFcwXbC6ivnFctnGQNYyxchhw2fPpkotHuRJTW2cHkCe5CF7MwMRHI
	FR0qZmCtZXSnqLAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q4oe7HpK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i0+BRVEP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724753275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7t5yk08dbXavxhXEFs0sNC0e9tA/xqnXn9Q7XU6LxDc=;
	b=q4oe7HpKwqaUDmlcBZYGWeQXO9Dcl6ZCmVKTtpONke6QReAtjBjo9xICwlypqGhb6VqMC/
	K1aKkNXVFS9Ekp5boKSiRe+Z+PaMzCJsGKRGo+mDzIBrbw+uUlUZ7iSTuoiPPmcncziXH0
	hGKpYcRPoN1lOm11nQhYXkeExJCZt5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724753275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7t5yk08dbXavxhXEFs0sNC0e9tA/xqnXn9Q7XU6LxDc=;
	b=i0+BRVEPPCYma65QtcgirYoTkqb5A/tNb63kYQC0cYJyHF/MxF5x+MTeKezJ++f9dgN9FT
	2KSvQ7H8Ad2eeyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C94E13A44;
	Tue, 27 Aug 2024 10:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LE32BnulzWauMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 Aug 2024 10:07:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE03CA0965; Tue, 27 Aug 2024 12:07:54 +0200 (CEST)
Date: Tue, 27 Aug 2024 12:07:54 +0200
From: Jan Kara <jack@suse.cz>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next] fs: Use in_group_or_capable() helper to simplify
 the code
Message-ID: <20240827100754.sltmc6uwfcbl5wrm@quack3>
References: <20240816063849.1989856-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816063849.1989856-1-lihongbo22@huawei.com>
X-Rspamd-Queue-Id: 27DBA21B08
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 16-08-24 14:38:49, Hongbo Li wrote:
> Since in_group_or_capable has been exported, we can use
> it to simplify the code when check group and capable.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/posix_acl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 3f87297dbfdb..6c66a37522d0 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -715,8 +715,8 @@ int posix_acl_update_mode(struct mnt_idmap *idmap,
>  		return error;
>  	if (error == 0)
>  		*acl = NULL;
> -	if (!vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)) &&
> -	    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
> +	if (!in_group_or_capable(idmap, inode,
> +				 i_gid_into_vfsgid(idmap, inode)))
>  		mode &= ~S_ISGID;
>  	*mode_p = mode;
>  	return 0;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

