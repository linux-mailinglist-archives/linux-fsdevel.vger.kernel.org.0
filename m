Return-Path: <linux-fsdevel+bounces-62773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D9BA0736
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE33A8D96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C5E3016F7;
	Thu, 25 Sep 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpgEc8qK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IkI9+abl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpgEc8qK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IkI9+abl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC32FFFBE
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815416; cv=none; b=Im9eXZQMXc/nBXRWKcDiTAL0BAGNDPe4DqCdsgwawTg5/7d34ecEGEBimDqutoANpWPR2Ulh/XyxJEdTttMaKz+X2FZWTXNgHPeBETW4aUZo6fPUbkIuujltJOYE7YGtouLLc5zloZnNyUPRs0dVnWTod1+5V4ubiUYr3z21v+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815416; c=relaxed/simple;
	bh=m6QpFkawOmNhd7oWD+5jM7932immcIjNUJPNoGbbhJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdinlalJ115LygmSdcFm0A1VTbVI6WAAu6qee2WeaPjySaAkKUSElbLpmFMA/dHSEh5WzkNteGXr3CH+kle7AedDw2kRCfK1sGbyJtbxda8oKeKnTZPOYjleuwtLhsvyNLsSFgPdEiFq8LZuI2KgE0QDAJn7zGtDa+ImhDCBdXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpgEc8qK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IkI9+abl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpgEc8qK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IkI9+abl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A007F6C201;
	Thu, 25 Sep 2025 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758815411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npyjLIAhWT4lA3Ad1zBxTWNYe7yHm1djiA0bY7sYY5w=;
	b=cpgEc8qKjm4aPAoxXDmt6+/5y5ekg+AORLSL8Xp9cK0Pasex+iS5bWwE2iolNf4lbBz7Wy
	Q8f95/u4Inv2doM1sA69HerhXnG7T2k48vJuIHZodQvT82TfWkugTfOFFAlgZ5l/H0BwUx
	dbv5OD/2rTfaPuzfLRPwbBOUL1M9V9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758815411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npyjLIAhWT4lA3Ad1zBxTWNYe7yHm1djiA0bY7sYY5w=;
	b=IkI9+ablHR65/GBROEZLxndPdM5+1dZOUgcGiyb07mj/bP+pwkQC9/aHFbN54Kl8zfujot
	G1I/49D7EmRNhRBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758815411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npyjLIAhWT4lA3Ad1zBxTWNYe7yHm1djiA0bY7sYY5w=;
	b=cpgEc8qKjm4aPAoxXDmt6+/5y5ekg+AORLSL8Xp9cK0Pasex+iS5bWwE2iolNf4lbBz7Wy
	Q8f95/u4Inv2doM1sA69HerhXnG7T2k48vJuIHZodQvT82TfWkugTfOFFAlgZ5l/H0BwUx
	dbv5OD/2rTfaPuzfLRPwbBOUL1M9V9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758815411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npyjLIAhWT4lA3Ad1zBxTWNYe7yHm1djiA0bY7sYY5w=;
	b=IkI9+ablHR65/GBROEZLxndPdM5+1dZOUgcGiyb07mj/bP+pwkQC9/aHFbN54Kl8zfujot
	G1I/49D7EmRNhRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C3A413869;
	Thu, 25 Sep 2025 15:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U1njIbNk1WgwWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Sep 2025 15:50:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D429A0AA0; Thu, 25 Sep 2025 17:50:07 +0200 (CEST)
Date: Thu, 25 Sep 2025 17:50:07 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Jonathan Corbet <corbet@lwn.net>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Paulo Alcantara <pc@manguebit.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Rick Macklem <rick.macklem@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 22/38] vfs: add fsnotify_modify_mark_mask()
Message-ID: <mr6lfsrdp77g7ndnhignxby6fniku2fb3u5yykvwng67sneo7o@d6dozubh4t4c>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
 <20250924-dir-deleg-v3-22-9f3af8bc5c40@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-dir-deleg-v3-22-9f3af8bc5c40@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,microsoft.com,talpey.com,brown.name,redhat.com,lwn.net,szeredi.hu,manguebit.org,linuxfoundation.org,tyhicks.com,chromium.org,goodmis.org,efficios.com,vger.kernel.org,lists.samba.org,lists.linux.dev];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 24-09-25 14:06:08, Jeff Layton wrote:
> nfsd needs to be able to modify the mask on an existing mark when new
> directory delegations are set or unset. Add an exported function that
> allows the caller to set and clear bits in the mark->mask, and does
> the recalculation if something changed.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/mark.c                 | 29 +++++++++++++++++++++++++++++
>  include/linux/fsnotify_backend.h |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 798340db69d761dd05c1b361c251818dee89b9cf..5ed42b24df7f6aa3812a7069b4c37f0c6b3414fa 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -309,6 +309,35 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  		fsnotify_conn_set_children_dentry_flags(conn);
>  }
>  
> +/**
> + * fsnotify_modify_mark_mask - set and/or clear flags in a mark's mask
> + * @mark: mark to be modified
> + * @set: bits to be set in mask
> + * @clear: bits to be cleared in mask
> + *
> + * Modify a fsnotify_mark mask as directed, and update its associated conn.
> + * The caller is expected to hold a reference to the mark.
> + */
> +void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear)
> +{
> +	bool recalc = false;
> +	u32 mask;
> +
> +	WARN_ON_ONCE(clear & set);
> +
> +	spin_lock(&mark->lock);
> +	mask = mark->mask;
> +	mark->mask |= set;
> +	mark->mask &= ~clear;
> +	if (mark->mask != mask)
> +		recalc = true;
> +	spin_unlock(&mark->lock);
> +
> +	if (recalc)
> +		fsnotify_recalc_mask(mark->connector);
> +}
> +EXPORT_SYMBOL_GPL(fsnotify_modify_mark_mask);
> +
>  /* Free all connectors queued for freeing once SRCU period ends */
>  static void fsnotify_connector_destroy_workfn(struct work_struct *work)
>  {
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index d4034ddaf3926bf98d8801997e50ba7ddf776292..8d50e6aad3c62c67a9bf73a8d9aab78565668c5f 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -912,6 +912,7 @@ extern void fsnotify_get_mark(struct fsnotify_mark *mark);
>  extern void fsnotify_put_mark(struct fsnotify_mark *mark);
>  extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
>  extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
> +extern void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear);
>  
>  static inline void fsnotify_init_event(struct fsnotify_event *event)
>  {
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

