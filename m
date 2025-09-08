Return-Path: <linux-fsdevel+bounces-60492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EADBB488FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F352189CBAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA4B2F546E;
	Mon,  8 Sep 2025 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o7jFqXcf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Z2tqfaD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o7jFqXcf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Z2tqfaD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2092F39CD
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324821; cv=none; b=nc9TZWBClgI98nzr70jCqH8K017Z+jSs1XlddIWc74H65nhqfYjxgRwvSCbbi4VsJZAWAungNyj4Kj2BS8YUDJgw9TgCnhhDmgemqAg+dex8PvCcGQprqqbPIE2Qbipn4nrYqTd11eNmipAxnOETVJZTObmfeGCmbfGr8aEBrx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324821; c=relaxed/simple;
	bh=skiarMqzub9fxFHhfrE7YTXPY0UKa7G+Qdgil3URMS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ+/v9TXaNOGEa4naJiEhSy1ytumx7oiY+J1Hzq3q7IKoJUmZrPu/3UhQqRlToFnRPYxPhX6ZZ2ZeR5SWlCL/LnQLS/qlcEqpjbTvLz8HGrBIA0iDTHtv9qQzilR5SE0edxeZKV9GzTOnMCEXxzSUrWlQmXBn5OJV40Jy7Plk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o7jFqXcf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Z2tqfaD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o7jFqXcf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Z2tqfaD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C75537984;
	Mon,  8 Sep 2025 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbzphvKptZiaox1pB9Wf3pl26mRbNixPdl1I+eG/MU4=;
	b=o7jFqXcfUrG8jGJSOuqacoTEEYiJ3pztvD+fhMLoT7KIz64qUq4INLC9VhNefdJaacLN4l
	UrbjbzHkf3lC6UJEO/ybKnEsIOp/3QMSkUogD+vdXRidOBgHW+vdELRwDA0uyJkSMYPTKg
	6s6aAj5ddHYeeX0oUCt6/TGK3X4QQfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbzphvKptZiaox1pB9Wf3pl26mRbNixPdl1I+eG/MU4=;
	b=+Z2tqfaD9AlOLursy7UajjglVdPJKEvUzCVc62khfF1ydPdn0oZMK4pxHBZ0rhIZJCtGCn
	p0huLScoFnxqCKBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o7jFqXcf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+Z2tqfaD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbzphvKptZiaox1pB9Wf3pl26mRbNixPdl1I+eG/MU4=;
	b=o7jFqXcfUrG8jGJSOuqacoTEEYiJ3pztvD+fhMLoT7KIz64qUq4INLC9VhNefdJaacLN4l
	UrbjbzHkf3lC6UJEO/ybKnEsIOp/3QMSkUogD+vdXRidOBgHW+vdELRwDA0uyJkSMYPTKg
	6s6aAj5ddHYeeX0oUCt6/TGK3X4QQfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbzphvKptZiaox1pB9Wf3pl26mRbNixPdl1I+eG/MU4=;
	b=+Z2tqfaD9AlOLursy7UajjglVdPJKEvUzCVc62khfF1ydPdn0oZMK4pxHBZ0rhIZJCtGCn
	p0huLScoFnxqCKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80AD413869;
	Mon,  8 Sep 2025 09:46:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vL1pHxCmvmgFbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:46:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41E44A0A2D; Mon,  8 Sep 2025 11:46:56 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:46:56 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 20/21] apparmor/af_unix: constify struct path * arguments
Message-ID: <h7sdxue4efjl33gujgejzprrobbivl26col6b5chynndrfsssx@hxrwza67izwu>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-20-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-20-viro@zeniv.linux.org.uk>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8C75537984
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,linux-foundation.org,gmail.com,oracle.com,apparmor.net];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -4.01

On Sat 06-09-25 10:11:36, Al Viro wrote:
> unix_sk(sock)->path should never be modified, least of all by LSM...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  security/apparmor/af_unix.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> index 9129766d1e9c..ac0f4be791ec 100644
> --- a/security/apparmor/af_unix.c
> +++ b/security/apparmor/af_unix.c
> @@ -31,7 +31,7 @@ static inline struct sock *aa_unix_sk(struct unix_sock *u)
>  }
>  
>  static int unix_fs_perm(const char *op, u32 mask, const struct cred *subj_cred,
> -			struct aa_label *label, struct path *path)
> +			struct aa_label *label, const struct path *path)
>  {
>  	AA_BUG(!label);
>  	AA_BUG(!path);
> @@ -224,7 +224,7 @@ static int profile_create_perm(struct aa_profile *profile, int family,
>  
>  static int profile_sk_perm(struct aa_profile *profile,
>  			   struct apparmor_audit_data *ad,
> -			   u32 request, struct sock *sk, struct path *path)
> +			   u32 request, struct sock *sk, const struct path *path)
>  {
>  	struct aa_ruleset *rules = profile->label.rules[0];
>  	struct aa_perms *p = NULL;
> @@ -386,9 +386,9 @@ static int profile_opt_perm(struct aa_profile *profile, u32 request,
>  
>  /* null peer_label is allowed, in which case the peer_sk label is used */
>  static int profile_peer_perm(struct aa_profile *profile, u32 request,
> -			     struct sock *sk, struct path *path,
> +			     struct sock *sk, const struct path *path,
>  			     struct sockaddr_un *peer_addr,
> -			     int peer_addrlen, struct path *peer_path,
> +			     int peer_addrlen, const struct path *peer_path,
>  			     struct aa_label *peer_label,
>  			     struct apparmor_audit_data *ad)
>  {
> @@ -445,7 +445,7 @@ int aa_unix_create_perm(struct aa_label *label, int family, int type,
>  static int aa_unix_label_sk_perm(const struct cred *subj_cred,
>  				 struct aa_label *label,
>  				 const char *op, u32 request, struct sock *sk,
> -				 struct path *path)
> +				 const struct path *path)
>  {
>  	if (!unconfined(label)) {
>  		struct aa_profile *profile;
> @@ -599,9 +599,9 @@ int aa_unix_opt_perm(const char *op, u32 request, struct socket *sock,
>  
>  static int unix_peer_perm(const struct cred *subj_cred,
>  			  struct aa_label *label, const char *op, u32 request,
> -			  struct sock *sk, struct path *path,
> +			  struct sock *sk, const struct path *path,
>  			  struct sockaddr_un *peer_addr, int peer_addrlen,
> -			  struct path *peer_path, struct aa_label *peer_label)
> +			  const struct path *peer_path, struct aa_label *peer_label)
>  {
>  	struct aa_profile *profile;
>  	DEFINE_AUDIT_SK(ad, op, subj_cred, sk);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

