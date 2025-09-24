Return-Path: <linux-fsdevel+bounces-62575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76045B99B8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 14:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2063B1451
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 12:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE803019BA;
	Wed, 24 Sep 2025 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t8MtAFkT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ck/7zHTb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t8MtAFkT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ck/7zHTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FE30149B
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715228; cv=none; b=ZiyA2wrinn56Y8ADzXt7cPgiQXV81yQZOBbrHiCVDXQ1W3Dl185zjPGYXg26NuuYaRS3J0Uhn/VhxjGPJ6x7914bPIy15yxvQsslELn9/+HJpx0NR0U1JdqHOPOJZyXizvCLEc5tUYZ908knawz2631NlKQeNLUjxKTHP/701bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715228; c=relaxed/simple;
	bh=glX9xFAzT3W3CQ1/rmQ95RyEcvVGdasD5ZVDXoHjF9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jld1xsME5ax6iU140t+zm2M07lxlSLbb3/7oCb2UqkVzLxQlEz9D9bprmXwfTdwp1OdJg60SCZk+PVkOWRlevwxk3gWEFoMjW4e3SGqqq+Je6Jxbu/7v/pXVKIP2ACrcGDnZl/qpqaI4tnP/QTC0HocA0hEOrZpKB+61wgXbh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t8MtAFkT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ck/7zHTb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t8MtAFkT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ck/7zHTb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AD6A34168;
	Wed, 24 Sep 2025 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758715224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbBlA6VZCyHVZvqtMvN73o62DA0QS+Hpq66jjsQePxM=;
	b=t8MtAFkTcPwIZ69WJwfUfQSrn2IPdQ0ttUcGBpZ85/phYccKsh3JAQEHLQjCxs4iLPa37m
	BBuqHZ5CK6us9iYaDIEtyeA2o6d14zc/tkJAgZR1CaPCEvTOEn4rJFie3tvLgRAww2tlyV
	wEKR8GDKxz3XeL6UtOndAbSjM+nr3Xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758715224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbBlA6VZCyHVZvqtMvN73o62DA0QS+Hpq66jjsQePxM=;
	b=Ck/7zHTbJxsjkkdFBKpvapJSnofdIUCbstMDs7FrYPbBnUbKKk2FQjG50reilGIJwVkEoS
	Q4nmi9a2TQ+/SWCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t8MtAFkT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Ck/7zHTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758715224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbBlA6VZCyHVZvqtMvN73o62DA0QS+Hpq66jjsQePxM=;
	b=t8MtAFkTcPwIZ69WJwfUfQSrn2IPdQ0ttUcGBpZ85/phYccKsh3JAQEHLQjCxs4iLPa37m
	BBuqHZ5CK6us9iYaDIEtyeA2o6d14zc/tkJAgZR1CaPCEvTOEn4rJFie3tvLgRAww2tlyV
	wEKR8GDKxz3XeL6UtOndAbSjM+nr3Xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758715224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbBlA6VZCyHVZvqtMvN73o62DA0QS+Hpq66jjsQePxM=;
	b=Ck/7zHTbJxsjkkdFBKpvapJSnofdIUCbstMDs7FrYPbBnUbKKk2FQjG50reilGIJwVkEoS
	Q4nmi9a2TQ+/SWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E2BE13647;
	Wed, 24 Sep 2025 12:00:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4pTkGljd02gPSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 12:00:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2F1F9A0A9A; Wed, 24 Sep 2025 14:00:20 +0200 (CEST)
Date: Wed, 24 Sep 2025 14:00:20 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] ns: drop assert
Message-ID: <25byqesyh4xqu4j7trvq3rkz2kkr6ej7eblami6wf2kat5aymm@jt3cfzkgawgj>
References: <20250924-work-namespaces-fixes-v1-0-8fb682c8678e@kernel.org>
 <20250924-work-namespaces-fixes-v1-3-8fb682c8678e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-work-namespaces-fixes-v1-3-8fb682c8678e@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7AD6A34168
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed 24-09-25 13:34:00, Christian Brauner wrote:
> Otherwise we warn when e.g., no namespaces are configured but the
> initial namespace for is still around.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/nscommon.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index 92c9df1e8774..c1fb2bad6d72 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -46,8 +46,6 @@ static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
>  		VFS_WARN_ON_ONCE(ops != &utsns_operations);
>  		break;
>  #endif
> -	default:
> -		VFS_WARN_ON_ONCE(true);
>  	}
>  }
>  #endif
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

