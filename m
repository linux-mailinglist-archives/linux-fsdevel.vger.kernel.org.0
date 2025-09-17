Return-Path: <linux-fsdevel+bounces-61966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1B7B8104E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFD71C812AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35652FAC18;
	Wed, 17 Sep 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1X0FB2mM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="908+1eCG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1X0FB2mM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="908+1eCG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E52F6167
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126721; cv=none; b=RzzLSnV9S3nLaUgJuzg+D/yiwJ1meeQZXug36cp9oJxPR7ddJlw6TsTKqAijOvwNvtMB0pCFgF2TOxeaxaRTKfwyZ7T4D4Nwvuu9xtRv5Wg9PS3RiOKiN02+q4Qy1fqOTyndlEKVJKbyd8yHJJPQFziWt7nn+TolcYgKXXoDRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126721; c=relaxed/simple;
	bh=b/sX81J63Q/D5xL8SS2bkKQF5x4z5vx2k9v0pU4YPAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlx0Y/xnqLRMQG8ySiXr2+HC3Z2AbD1GazYFaCxYusPUlJ92t1XFwQzdXBceeXDbPEIx6tJl23PBRNV+4IfaMeLktlZErpDl6vkoNh1J8y3HvN3HsMydo46aV9P8C5EW9dPg7TIgIG4HJo1/cSwogVpz3E0qW8mRcb6Bf3NxkQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1X0FB2mM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=908+1eCG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1X0FB2mM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=908+1eCG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17AD633C57;
	Wed, 17 Sep 2025 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aL6KHVqrA0+agv7oS7Ez+IbCA7tUmgOwJs7zPgxI9r0=;
	b=1X0FB2mMj4oEImvp29+3U2d9zUSH37fSBz56gaAfkm3pwa3Fn89MtqftCAK57YgeBbRMb+
	vRThtzzMOzDr+uDlLH9PHmA0OYya8/X+/+CiONWoJYVjQsf2z7x1noEXoCEcfCVYK0yuRx
	CrN2SclEOhWT7tKzdaUlRkjAljo3ySk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aL6KHVqrA0+agv7oS7Ez+IbCA7tUmgOwJs7zPgxI9r0=;
	b=908+1eCGihaZOHuP+g+77+hlOg8IVfCklFBjjUZddW0lrNLP/KXUPWSEiEi0sSXs1FQi20
	Y1m/lfGBXiDQCxDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758126718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aL6KHVqrA0+agv7oS7Ez+IbCA7tUmgOwJs7zPgxI9r0=;
	b=1X0FB2mMj4oEImvp29+3U2d9zUSH37fSBz56gaAfkm3pwa3Fn89MtqftCAK57YgeBbRMb+
	vRThtzzMOzDr+uDlLH9PHmA0OYya8/X+/+CiONWoJYVjQsf2z7x1noEXoCEcfCVYK0yuRx
	CrN2SclEOhWT7tKzdaUlRkjAljo3ySk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758126718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aL6KHVqrA0+agv7oS7Ez+IbCA7tUmgOwJs7zPgxI9r0=;
	b=908+1eCGihaZOHuP+g+77+hlOg8IVfCklFBjjUZddW0lrNLP/KXUPWSEiEi0sSXs1FQi20
	Y1m/lfGBXiDQCxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EA0213A63;
	Wed, 17 Sep 2025 16:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CS+QA37iymgrMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 16:31:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AEA3DA083B; Wed, 17 Sep 2025 18:31:53 +0200 (CEST)
Date: Wed, 17 Sep 2025 18:31:53 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jakub Kicinski <kuba@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5/9] nsfs: add inode number for anon namespace
Message-ID: <yb2ijk5qzgjz6beqk7vub5uzsensvxrcccllwl5dj4swbbwaik@vt2sqwvgkkyz>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-5-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-work-namespace-ns_common-v1-5-1b3bda8ef8f2@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 17-09-25 12:28:04, Christian Brauner wrote:
> Add an inode number anonymous namespaces.
                     ^ missing 'for'
 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/uapi/linux/nsfs.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> index 5d5bf22464c9..e098759ec917 100644
> --- a/include/uapi/linux/nsfs.h
> +++ b/include/uapi/linux/nsfs.h
> @@ -53,6 +53,9 @@ enum init_ns_ino {
>  	TIME_NS_INIT_INO	= 0xEFFFFFFAU,
>  	NET_NS_INIT_INO		= 0xEFFFFFF9U,
>  	MNT_NS_INIT_INO		= 0xEFFFFFF8U,
> +#ifdef __KERNEL__
> +	MNT_NS_ANON_INO		= 0xEFFFFFF7U,
> +#endif
>  };
>  
>  struct nsfs_file_handle {
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

