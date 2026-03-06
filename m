Return-Path: <linux-fsdevel+bounces-79582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AypOIamqmlTVAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 11:03:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 850A321E639
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 11:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF5D9302A3A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A571435B63A;
	Fri,  6 Mar 2026 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5eJ64at"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89C35A927;
	Fri,  6 Mar 2026 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791425; cv=none; b=ES5Ibl59tNAWVQqQK20jIvCem8AdL+1TrOVXBNWglOqalTKdGycg60gn0w0V56kqUK0fifWbjmIyNKWUMGMbwfCfK9I0DI0KUcgSlxofnYq+4vUozkOJ/HLOuxqcHyXEkHS+K+jv8GMEigcwQriXBGdvN2ihfjGi5KPBGJg6xAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791425; c=relaxed/simple;
	bh=2k86Dtm5s9d5fuxoJ9fHeDpBAjwOVfZAGlB/JmB3VzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZeQQ13+AClFJNpzxOo2vIW/kU6+3Mtt2BIA7Ty0e0wUhuVV9e/sYiqbkcAOqkJqrchbuBrfuHjhdgG3xc+1ScWXGmG+FuLPO8s/9Ap1niLKIkaFZFH2Wz104bVWdPcRf6tAY/iagyqPRqQa/aqUQwML4z4RGXDuaEtXN7XvnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5eJ64at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A5FC4CEF7;
	Fri,  6 Mar 2026 10:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772791424;
	bh=2k86Dtm5s9d5fuxoJ9fHeDpBAjwOVfZAGlB/JmB3VzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5eJ64atM8CSqw/MFjNXRrxzHZxZT0IBlWe/NQZtx2XiegpWzk9QGLezy2pa/YbfU
	 xtk86J7xCw5xi/XgfSdxYaLcnSBQI+NqT6UnzHy0w4Tf/ewxqIXGBWBnoDewzKWpqt
	 gla/VKzwagTuoRDKQmlWYIGEo255wDo0Ruxpy+b4aKGeHwOu1OT4COczr0n1spvh6m
	 YYxtdzNadC/MvG7p7bpMrLJvbXCGKo0xO+V58N36G45KnREJAziJK+kkCiOwMVW7+p
	 5H/AG3mUibbev5gybwevloaYp72DLAyI2k59DOJNlxe8cWCA5bqTCMKlTB4QC7I+m9
	 FpkwlN+s9sM0Q==
Date: Fri, 6 Mar 2026 11:03:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 10/15] cachefiles: change cachefiles_bury_object to
 use start_renaming_dentry()
Message-ID: <20260306-stolz-verzichten-2ee626da4503@brauner>
References: <20260224222542.3458677-1-neilb@ownmail.net>
 <20260224222542.3458677-11-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224222542.3458677-11-neilb@ownmail.net>
X-Rspamd-Queue-Id: 850A321E639
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79582-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,kernel.org,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:16:55AM +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> Rather then using lock_rename() and lookup_one() etc we can use
> the new start_renaming_dentry().  This is part of centralising dir
> locking and lookup so that locking rules can be changed.
> 
> Some error check are removed as not necessary.  Checks for rep being a
> non-dir or IS_DEADDIR and the check that ->graveyard is still a
> directory only provide slightly more informative errors and have been
> dropped.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/namei.c | 76 ++++++++-----------------------------------
>  1 file changed, 14 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index e5ec90dccc27..3af42ec78411 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -270,7 +270,8 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
>  			   struct dentry *rep,
>  			   enum fscache_why_object_killed why)
>  {
> -	struct dentry *grave, *trap;
> +	struct dentry *grave;
> +	struct renamedata rd = {};
>  	struct path path, path_to_graveyard;
>  	char nbuffer[8 + 8 + 1];
>  	int ret;
> @@ -302,77 +303,36 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
>  		(uint32_t) ktime_get_real_seconds(),
>  		(uint32_t) atomic_inc_return(&cache->gravecounter));
>  
> -	/* do the multiway lock magic */
> -	trap = lock_rename(cache->graveyard, dir);
> -	if (IS_ERR(trap))
> -		return PTR_ERR(trap);
> -
> -	/* do some checks before getting the grave dentry */
> -	if (rep->d_parent != dir || IS_DEADDIR(d_inode(rep))) {
> -		/* the entry was probably culled when we dropped the parent dir
> -		 * lock */
> -		unlock_rename(cache->graveyard, dir);
> -		_leave(" = 0 [culled?]");
> -		return 0;

I think this is a subtle change in behavior?

If rep->d_parent != dir after lock_rename this returned 0 in the old
code. With your changes the same condition in __start_renaming_dentry
returns -EINVAL which means cachefiles_io_error() sets CACHEFILES_DEAD
and permanently disables the cache.

> -	}
> -
> -	if (!d_can_lookup(cache->graveyard)) {
> -		unlock_rename(cache->graveyard, dir);
> -		cachefiles_io_error(cache, "Graveyard no longer a directory");
> -		return -EIO;
> -	}
> -
> -	if (trap == rep) {
> -		unlock_rename(cache->graveyard, dir);
> -		cachefiles_io_error(cache, "May not make directory loop");
> +	rd.mnt_idmap = &nop_mnt_idmap;
> +	rd.old_parent = dir;
> +	rd.new_parent = cache->graveyard;
> +	rd.flags = 0;
> +	ret = start_renaming_dentry(&rd, 0, rep, &QSTR(nbuffer));
> +	if (ret) {
> +		cachefiles_io_error(cache, "Cannot lock/lookup in graveyard");
>  		return -EIO;
>  	}
>  
>  	if (d_mountpoint(rep)) {
> -		unlock_rename(cache->graveyard, dir);
> +		end_renaming(&rd);
>  		cachefiles_io_error(cache, "Mountpoint in cache");
>  		return -EIO;
>  	}
>  
> -	grave = lookup_one(&nop_mnt_idmap, &QSTR(nbuffer), cache->graveyard);
> -	if (IS_ERR(grave)) {
> -		unlock_rename(cache->graveyard, dir);
> -		trace_cachefiles_vfs_error(object, d_inode(cache->graveyard),
> -					   PTR_ERR(grave),
> -					   cachefiles_trace_lookup_error);
> -
> -		if (PTR_ERR(grave) == -ENOMEM) {
> -			_leave(" = -ENOMEM");
> -			return -ENOMEM;
> -		}

This too?

In the old code a -ENOMEM return from lookup_one() let the cache stay
alive and returned directly. The new code gets sent via
cachefiles_io_error() causing again CACHEFILES_DEAD to be set and
permanently disabling the cache.

Maybe both changes are intentional. If so we should probably note this
in the commit message or this should be fixed?

If you give me a fixup! on top of vfs-7.1.directory I can fold it.

