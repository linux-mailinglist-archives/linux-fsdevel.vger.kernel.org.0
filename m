Return-Path: <linux-fsdevel+bounces-64665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC07BF03A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A69E3E7CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423B72F6173;
	Mon, 20 Oct 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zxouHgNg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5lzRlQJq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zxouHgNg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5lzRlQJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20F2F6186
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953105; cv=none; b=olV2Zi0msm+uX1BI0byC+Nn7LDeKmCad5mJ+t5V6UWMDwh9exjeYQfljxSMOVBo99DNEr6BHAZKWONA57cmBtNHS1xqVDHIJNBokt51I2Pnjn0sCGPwuQq4vUBxKaVghYe9stHeTCdlkyQFMRvL50VBcKPa8ZTtYE1B+h72Mpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953105; c=relaxed/simple;
	bh=h6eHIKNIKxvv7MntNZ2NPluU3sYBXbkxa/iV1J5GD+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP9NCPVuKapGb6T1e+gI5qd27wexajG+7s/VLvBfCToVCEf1SFWhqQlS5CPXDIA9TCxuECbqYmI/WL3/m8bPIvM+xmM7UZYHOP1bEq+wKZi/KvXHjFbrm0gvkAbku0HbCvibhBVjJOM3FeJiVdq8kak/bIiHlHAhbrhME1h+3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zxouHgNg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5lzRlQJq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zxouHgNg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5lzRlQJq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B602B21182;
	Mon, 20 Oct 2025 09:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3Kd6mbbrPRG0zwXHtLEs9ID63+xl85WNbtfLvd00nw=;
	b=zxouHgNgKUzdOarvvgPHxxhBWfS94a/uSkfjawCnhR8cbzz69iJLdEIMLj+zu50BZJJba5
	bUTYv7oaSLn8CNysGSrIzr02b4aqBS2pxKu3DHfqFRoON9pn+7ej6fZrScypIZq2azmnM9
	x+TSTCq6IzdNyUQ8GrWILzHPDDFkhg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3Kd6mbbrPRG0zwXHtLEs9ID63+xl85WNbtfLvd00nw=;
	b=5lzRlQJqx8tIyzMXiqieG4GgqzCjJXMTESHJy83TMpTfVtscp3W2GniczNdnyGo/OW71MN
	UX0rYu63KQ2G2IBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3Kd6mbbrPRG0zwXHtLEs9ID63+xl85WNbtfLvd00nw=;
	b=zxouHgNgKUzdOarvvgPHxxhBWfS94a/uSkfjawCnhR8cbzz69iJLdEIMLj+zu50BZJJba5
	bUTYv7oaSLn8CNysGSrIzr02b4aqBS2pxKu3DHfqFRoON9pn+7ej6fZrScypIZq2azmnM9
	x+TSTCq6IzdNyUQ8GrWILzHPDDFkhg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3Kd6mbbrPRG0zwXHtLEs9ID63+xl85WNbtfLvd00nw=;
	b=5lzRlQJqx8tIyzMXiqieG4GgqzCjJXMTESHJy83TMpTfVtscp3W2GniczNdnyGo/OW71MN
	UX0rYu63KQ2G2IBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A767513AAC;
	Mon, 20 Oct 2025 09:38:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id urrbKAYD9mgtDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:38:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55C9AA0856; Mon, 20 Oct 2025 11:38:14 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:38:14 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 03/13] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Message-ID: <n5ihwvsits3u7fwvzuk42vmqdv45ap6u4gh77diegtxik42emp@whyfqmynxnl2>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
 <20251013-dir-deleg-ro-v1-3-406780a70e5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-dir-deleg-ro-v1-3-406780a70e5e@kernel.org>
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Mon 13-10-25 10:48:01, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> vfs_link, vfs_unlink, and vfs_rename all have existing delegation break
> handling for the children in the rename. Add the necessary calls for
> breaking delegations in the parent(s) as well.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 7377020a2cba02501483020e0fc93c279fb38d3e..6e61e0215b34134b1690f864e2719e3f82cf71a8 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4667,6 +4667,9 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
>  	else {
>  		error = security_inode_unlink(dir, dentry);
>  		if (!error) {
> +			error = try_break_deleg(dir, delegated_inode);
> +			if (error)
> +				goto out;
>  			error = try_break_deleg(target, delegated_inode);
>  			if (error)
>  				goto out;
> @@ -4936,7 +4939,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
>  	else if (max_links && inode->i_nlink >= max_links)
>  		error = -EMLINK;
>  	else {
> -		error = try_break_deleg(inode, delegated_inode);
> +		error = try_break_deleg(dir, delegated_inode);
> +		if (!error)
> +			error = try_break_deleg(inode, delegated_inode);
>  		if (!error)
>  			error = dir->i_op->link(old_dentry, dir, new_dentry);
>  	}
> @@ -5203,6 +5208,14 @@ int vfs_rename(struct renamedata *rd)
>  		    old_dir->i_nlink >= max_links)
>  			goto out;
>  	}
> +	error = try_break_deleg(old_dir, delegated_inode);
> +	if (error)
> +		goto out;
> +	if (new_dir != old_dir) {
> +		error = try_break_deleg(new_dir, delegated_inode);
> +		if (error)
> +			goto out;
> +	}
>  	if (!is_dir) {
>  		error = try_break_deleg(source, delegated_inode);
>  		if (error)
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

