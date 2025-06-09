Return-Path: <linux-fsdevel+bounces-51023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCFCAD1E46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A661F16BC21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32ED2528EF;
	Mon,  9 Jun 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ACshVvNF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENhJaAes";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ACshVvNF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENhJaAes"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3D2571A2
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474036; cv=none; b=ngbXMkvAHvdluShJcJ/vJRmO7cL6mK5vffeNKtosKBTr55NnsP2GZ4nT6JmJe9QAxaye7A2vVWoSuPTXCUkOGghoYyc14h05ENiMSyihEVi4t0EyIoZ2TIa8ErsQ82/aVFUXTPnNxhLJHIROCEI2orSgQ4y9GbFELmN7zMgPMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474036; c=relaxed/simple;
	bh=3xhl2LNu/wRAF+quPDBiV6VhMbSKSQbC+rt012wC4vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBp6mHN4XezEG0EetuOTMAtGwEfUnlcVxIOpBNH9yjAAFKuF9+vAmcnTaIKM5oDlWcoZn6nt0dSizlRIC7c7IEiTg9cv1tKvmicNHRgbDnc0izHe7UIz2y8G6qnJeXxb1EKHE6/fRbXzoyT1f1iqnqN9sN6Xi4al0SSGM+h1IwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ACshVvNF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENhJaAes; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ACshVvNF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENhJaAes; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB95B2117D;
	Mon,  9 Jun 2025 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749474031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3pP6nhn7jj2JVMUX408uMm7p8lqzIg3XBb7vL5PGrM4=;
	b=ACshVvNFzhGot4hSZC0pUBKX5bxt3ChAyMUPqAFM1Bd4IFfZz7P3Kc9ElYTuUavil0SMD8
	vKe72D4KU8q0z0oUZTy4H7NANXo0EE6ridw7pVEUUgnfTKNuuzDt90EAwUUWJFE551BlnB
	BG4sgjTrb9IJ5TeA7OVMSxRPzb4gEts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749474031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3pP6nhn7jj2JVMUX408uMm7p8lqzIg3XBb7vL5PGrM4=;
	b=ENhJaAesi/jyHTO5LdDX5uZ0VQZWkh4bZe57XzkuKVfj0C/ppnWMyVfaNECyd0PX6rH56V
	E8aqA/u23Idu3TCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ACshVvNF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ENhJaAes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749474031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3pP6nhn7jj2JVMUX408uMm7p8lqzIg3XBb7vL5PGrM4=;
	b=ACshVvNFzhGot4hSZC0pUBKX5bxt3ChAyMUPqAFM1Bd4IFfZz7P3Kc9ElYTuUavil0SMD8
	vKe72D4KU8q0z0oUZTy4H7NANXo0EE6ridw7pVEUUgnfTKNuuzDt90EAwUUWJFE551BlnB
	BG4sgjTrb9IJ5TeA7OVMSxRPzb4gEts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749474031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3pP6nhn7jj2JVMUX408uMm7p8lqzIg3XBb7vL5PGrM4=;
	b=ENhJaAesi/jyHTO5LdDX5uZ0VQZWkh4bZe57XzkuKVfj0C/ppnWMyVfaNECyd0PX6rH56V
	E8aqA/u23Idu3TCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA505137FE;
	Mon,  9 Jun 2025 13:00:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JCWJKe/aRmisVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Jun 2025 13:00:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39E20A094C; Mon,  9 Jun 2025 15:00:31 +0200 (CEST)
Date: Mon, 9 Jun 2025 15:00:31 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org, 
	coda@cs.cmu.edu, codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] coda: use iterate_dir() in coda_readdir()
Message-ID: <6zirxkpkdrtpcoewopaaotmw4jpjvjmqq4tijudvrpeo4227pi@hyljuie6ngem>
References: <20250608230952.20539-1-neil@brown.name>
 <20250608230952.20539-4-neil@brown.name>
 <8f2bf3aed5d7bd005adcdeaa51c02c7aa9ca14ba.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2bf3aed5d7bd005adcdeaa51c02c7aa9ca14ba.camel@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[brown.name,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,cs.cmu.edu,redhat.com,tyhicks.com,szeredi.hu,vger.kernel.org,coda.cs.cmu.edu,lists.linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BB95B2117D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Mon 09-06-25 08:17:15, Jeff Layton wrote:
> On Mon, 2025-06-09 at 09:09 +1000, NeilBrown wrote:
> > The code in coda_readdir() is nearly identical to iterate_dir().
> > Differences are:
> >  - iterate_dir() is killable
> >  - iterate_dir() adds permission checking and accessing notifications
> > 
> > I believe these are not harmful for coda so it is best to use
> > iterate_dir() directly.  This will allow locking changes without
> > touching the code in coda.
> > 
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/coda/dir.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> > index ab69d8f0cec2..ca9990017265 100644
> > --- a/fs/coda/dir.c
> > +++ b/fs/coda/dir.c
> > @@ -429,17 +429,9 @@ static int coda_readdir(struct file *coda_file, struct dir_context *ctx)
> >  	cfi = coda_ftoc(coda_file);
> >  	host_file = cfi->cfi_container;
> >  
> > -	if (host_file->f_op->iterate_shared) {
> > -		struct inode *host_inode = file_inode(host_file);
> > -		ret = -ENOENT;
> > -		if (!IS_DEADDIR(host_inode)) {
> > -			inode_lock_shared(host_inode);
> > -			ret = host_file->f_op->iterate_shared(host_file, ctx);
> > -			file_accessed(host_file);
> > -			inode_unlock_shared(host_inode);
> > -		}
> > +	ret = iterate_dir(host_file, ctx);
> > +	if (ret != -ENOTDIR)
> >  		return ret;
> > -	}
> >  	/* Venus: we must read Venus dirents from a file */
> >  	return coda_venus_readdir(coda_file, ctx);
> >  }
> 
> 
> Is it already time for my annual ask of "Who the heck is using coda
> these days?" Anyway, this patch looks fine to me.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Send a patch proposing deprecating it and we might learn that :) Searching
the web seems to suggest it is indeed pretty close to dead.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

