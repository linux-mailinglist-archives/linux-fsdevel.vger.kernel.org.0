Return-Path: <linux-fsdevel+bounces-9053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 591B483D869
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 11:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7371C21B28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C5F13FEB;
	Fri, 26 Jan 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uFWV5/6c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4nrJbFly";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oCRuZGtD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="neMnI5wB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF013AC9;
	Fri, 26 Jan 2024 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266059; cv=none; b=EbR05zPehTSUHJul/26rSq1awCVGVmk9Ut0PfnjX8/kbQzwzLnpFG/i/usVotiq0JjDCnbzwJZ2EtkuP0idRfRIABZ4EaFu1R4LFg6sMSkpKtgHBV+ujanxax9obsHCQIfydhSPLfsj9OH/5KVXPI4k7yMk6/bRSOleDqWx3Feg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266059; c=relaxed/simple;
	bh=kw330Rj+dvXFrcyOh21QF428FI3QNljIFnkqOGrlr70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/m6552Yhz7AgZbci6KXNpFxoa78XHKBJrDb0VT+hCaYVlkGylfZ3Dn8iWDJWFBsABDDpTWIJFi1bcO/7XHLpI7jsy3wLCZ2pkschDB4V5Rl9m4SkfWr7snq2dVyj4Ae1iUP9Qp2sl92+MDc/2EC20kXMOtBAcFlalKj0oYNUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uFWV5/6c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4nrJbFly; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oCRuZGtD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=neMnI5wB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 719F721FDE;
	Fri, 26 Jan 2024 10:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706266049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfDYD1hkMdAR4BGYjFkj7xOSPN6n4QHzvjQQXC87In8=;
	b=uFWV5/6c1EHGaUvzBag7+ZrIXQIiggCVI2OolOmkzhvhsKhHpuC8eOCy/0GD1Scy6wZiTx
	ciDKNFJOeCcQudtyS0ASxoIhiOIfZUrHYcgyZ/I7l2/EkGXSJms0CTaGIe/1P5/9LLf7mm
	JQk2IeeNtVKINRc7CutKAnonn9kB0vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706266049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfDYD1hkMdAR4BGYjFkj7xOSPN6n4QHzvjQQXC87In8=;
	b=4nrJbFlyFc+tJTX0x97F2K5qP2hAJmeItCpQm/f4Vr+GeD/keeAnPKeddWhJ8xmpuhOfUe
	6l9z5dZV7gbF3DDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706266048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfDYD1hkMdAR4BGYjFkj7xOSPN6n4QHzvjQQXC87In8=;
	b=oCRuZGtDEaDojXKk77W9K6978xYhXrjBJWvilZKTV+D+mt42MLESnbDy6524QGR3rrwCJF
	fzmDqEWIPw4O+d5/Xf3RcI3t8dAG/jQAs4zHgkzZ+3Z9hdDHg1V98phCl8aYqHA7L4PEVD
	by1gdxoerrrY0rSD9JwVHg3smsUvpQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706266048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfDYD1hkMdAR4BGYjFkj7xOSPN6n4QHzvjQQXC87In8=;
	b=neMnI5wBWr2bdJwNDjgxzyXSCEH8TQu/eSWTUjVZjYV7nJGDPiYlLpiH9Ruo+EPNO/P2ej
	CFUDoNVRiYLjnbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58C1513A22;
	Fri, 26 Jan 2024 10:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YQKiFcCNs2V9JwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 26 Jan 2024 10:47:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2F462A0805; Fri, 26 Jan 2024 11:47:27 +0100 (CET)
Date: Fri, 26 Jan 2024 11:47:27 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Matthew Bobrowski <mbobrowski@mbobrowski.org>, amir73il@gmail.com,
	Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH] exec: Remove __FMODE_EXEC from uselib()
Message-ID: <20240126104727.rzksht5mjkanvo5n@quack3>
References: <20240124220619.work.227-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124220619.work.227-kees@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linux-foundation.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kevinlocke.name,google.com,linux-foundation.org,xmission.com,zeniv.linux.org.uk,kernel.org,suse.cz,kvack.org,vger.kernel.org,mbobrowski.org,gmail.com,redhat.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Wed 24-01-24 14:06:23, Kees Cook wrote:
> Path-based LSMs will bypass uselib() "open" checks since commit
> 4759ff71f23e ("exec: Check __FMODE_EXEC instead of in_execve for LSMs"),
> so don't set __FMODE_EXEC during uselib(). The LSM "open" and eventual
> "mmap" hooks will be restored. (uselib() never set current->in_execve.)
> 
> Other things that checked __FMODE_EXEC:
> 
> - fs/fcntl.c is just doing a bitfield sanity check.
> 
> - nfs_open_permission_mask() is only checking for the
>   "unreadable exec" case, which is not an issue for uselib(),
>   which sets MAY_READ, unlike execve().
> 
> - fsnotify would no longer see uselib() as FS_OPEN_EXEC_PERM, but
>   rather as FS_OPEN_PERM, but this is likely a bug fix, as uselib() isn't
>   an exec: it's more like mmap(), which fsnotify doesn't intercept.

OK, I went back to the original discussion with Steve Grubb and Matthew
Bobrowski who asked for FS_OPEN_EXEC_PERM and AFAICT this change in
uselib() should be fine wrt usescases we discussed. That doesn't mean there
cannot be some userspace which will get broken by this (in which case we'd
have to revert or find some other solution) but I'm willing to try. I'm
also CCing Steve & Matthew for input but from my side feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/lkml/CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com/
> Fixes: 4759ff71f23e ("exec: Check __FMODE_EXEC instead of in_execve for LSMs")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kevin Locke <kevin@kevinlocke.name>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index d179abb78a1c..af4fbb61cd53 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -128,7 +128,7 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
>  	struct filename *tmp = getname(library);
>  	int error = PTR_ERR(tmp);
>  	static const struct open_flags uselib_flags = {
> -		.open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
> +		.open_flag = O_LARGEFILE | O_RDONLY,
>  		.acc_mode = MAY_READ | MAY_EXEC,
>  		.intent = LOOKUP_OPEN,
>  		.lookup_flags = LOOKUP_FOLLOW,
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

