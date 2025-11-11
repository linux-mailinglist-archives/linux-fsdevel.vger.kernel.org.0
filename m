Return-Path: <linux-fsdevel+bounces-67860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A332C4C627
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B91818979BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDECE2BEFE4;
	Tue, 11 Nov 2025 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1l6Vgn9W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QT/2PNIh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AbCJLGaq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RyY/sz17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA45E2882AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849325; cv=none; b=FLiCrOeE3rj/0Q3GdJx35atJoa51Dm3sVBKOPmCjLo3KhIo0/ommJJk3HOpjJVEli10N2GNIT3XBlR2DYSNp3QpbA8TtGTlQ9g6zZ4Ym5auvXzzlb8ntlauYvkbyehvwlhP2V/u2vf98qRBlGX6G+RmKrGewq9Py/gq6a9lGSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849325; c=relaxed/simple;
	bh=SvnP/2kFGpZb/rH94jpz0sj8LOr5nXGQyvKYmHrDiuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2VXTQXPDiAZABor6Qwwpm/vN/j6wselaEojd/G1tzRd/792KsDilJcfhzGaJYU4js2VjXbICboZJFG1A85r0mdvQynHSjs/ebdeD05Mp1togy+u/3qh+ZYDU1w1Nge7q/ajdYd/QJ/nT5lA2FTks6fh6To5vbXNYaehOLrYHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1l6Vgn9W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QT/2PNIh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AbCJLGaq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RyY/sz17; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6505D21C07;
	Tue, 11 Nov 2025 08:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762849316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zk9wMRFfHEVY2Jm5yWIcHNEmM7zAyv2N5Xyuix1WNEk=;
	b=1l6Vgn9WuDnIVY8fN9JTLLXcOXhPNZ/txVKCNeCQXz8lNQKxcGgZ5RHOGCmUpcUZfeAhvZ
	tZUQHm9PbO7gZT8wHfANKKKrny7A3QfnBuafAv1jwlWPgi1eHjg0ciMSSfZrbpKLoP3MMj
	LcJ24RwY8khNL+BaWAOGniEwf+VczVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762849316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zk9wMRFfHEVY2Jm5yWIcHNEmM7zAyv2N5Xyuix1WNEk=;
	b=QT/2PNIhRcN83djfbdXY8eHQHhwe44W/Lqt/qVnmsyKbCXLgun5Vsr/UY421bk2LZtOG2c
	kJq3bX9mePNA0nDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AbCJLGaq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="RyY/sz17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762849315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zk9wMRFfHEVY2Jm5yWIcHNEmM7zAyv2N5Xyuix1WNEk=;
	b=AbCJLGaqGks2fAJ4QfvuAr0stExAKigxzPX2Ylv4jUv7YiIF90Iw9d4PD3nDIjLWIZZefI
	kbupPB2rjlIl26ubgX54cXy9GiI7x0k4GOeLPh+/7CpDAhLV75o+NOoJ/7vj20cRFKbGEs
	Eaak5fF0bOZHq4BV+GfLSsmStPHxkqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762849315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zk9wMRFfHEVY2Jm5yWIcHNEmM7zAyv2N5Xyuix1WNEk=;
	b=RyY/sz17uwrCn38hEV5+pNuvOhb4TThKBMyAwE4aXpFkTz2aFp6umpRVwugJMcTGEIOaMF
	Imb6MAhiZ2E9ZxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59B8314869;
	Tue, 11 Nov 2025 08:21:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tpTeFSPyEmnHKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Nov 2025 08:21:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E6D2AA28C8; Tue, 11 Nov 2025 09:21:50 +0100 (CET)
Date: Tue, 11 Nov 2025 09:21:50 +0100
From: Jan Kara <jack@suse.cz>
To: Andrei Vagin <avagin@google.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/namespace: correctly handle errors returned by
 grab_requested_mnt_ns
Message-ID: <qfo4k2dkvfw3nhttuw63xhhlar2ixupi37uk6uskctt3672ntf@3mtjgep63msk>
References: <20251111062815.2546189-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111062815.2546189-1-avagin@google.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6505D21C07
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

On Tue 11-11-25 06:28:15, Andrei Vagin wrote:
> grab_requested_mnt_ns was changed to return error codes on failure, but
> its callers were not updated to check for error pointers, still checking
> only for a NULL return value.
> 
> This commit updates the callers to use IS_ERR() or IS_ERR_OR_NULL() and
> PTR_ERR() to correctly check for and propagate errors.
> 
> Fixes: 7b9d14af8777 ("fs: allow mount namespace fd")
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Andrei Vagin <avagin@google.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d82910f33dc4..9124465dca55 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -144,8 +144,10 @@ static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
>  
>  static void mnt_ns_release(struct mnt_namespace *ns)
>  {
> +	if (IS_ERR_OR_NULL(ns))
> +		return;
>  	/* keep alive for {list,stat}mount() */
> -	if (ns && refcount_dec_and_test(&ns->passive)) {
> +	if (refcount_dec_and_test(&ns->passive)) {
>  		fsnotify_mntns_delete(ns);
>  		put_user_ns(ns->user_ns);
>  		kfree(ns);
> @@ -5756,8 +5758,10 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
>  	if (kreq->mnt_ns_id && kreq->spare)
>  		return ERR_PTR(-EINVAL);
>  
> -	if (kreq->mnt_ns_id)
> -		return lookup_mnt_ns(kreq->mnt_ns_id);
> +	if (kreq->mnt_ns_id) {
> +		mnt_ns = lookup_mnt_ns(kreq->mnt_ns_id);
> +		return mnt_ns ? : ERR_PTR(-ENOENT);
> +	}
>  
>  	if (kreq->spare) {
>  		struct ns_common *ns;
> @@ -5801,8 +5805,8 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
>  		return ret;
>  
>  	ns = grab_requested_mnt_ns(&kreq);
> -	if (!ns)
> -		return -ENOENT;
> +	if (IS_ERR(ns))
> +		return PTR_ERR(ns);
>  
>  	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
>  	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
> @@ -5912,8 +5916,8 @@ static void __free_klistmount_free(const struct klistmount *kls)
>  static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *kreq,
>  				     size_t nr_mnt_ids)
>  {
> -
>  	u64 last_mnt_id = kreq->param;
> +	struct mnt_namespace *ns;
>  
>  	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
>  	if (last_mnt_id != 0 && last_mnt_id <= MNT_UNIQUE_ID_OFFSET)
> @@ -5927,9 +5931,10 @@ static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *
>  	if (!kls->kmnt_ids)
>  		return -ENOMEM;
>  
> -	kls->ns = grab_requested_mnt_ns(kreq);
> -	if (!kls->ns)
> -		return -ENOENT;
> +	ns = grab_requested_mnt_ns(kreq);
> +	if (IS_ERR(ns))
> +		return PTR_ERR(ns);
> +	kls->ns = ns;
>  
>  	kls->mnt_parent_id = kreq->mnt_id;
>  	return 0;
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

