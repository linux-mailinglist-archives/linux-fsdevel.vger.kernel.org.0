Return-Path: <linux-fsdevel+bounces-21811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333A190AA20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 11:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D3B3210C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4FE19307B;
	Mon, 17 Jun 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e0eoA3Rw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="60VR4dPt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e0eoA3Rw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="60VR4dPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5022F190673;
	Mon, 17 Jun 2024 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617070; cv=none; b=Ret+ZKYY3TbGmXpD59WqRmKh5AfLjYYkMvqGsHrrt9y6nIGN+lCpPBYjL8C/VZGmEjMFInjoyJo+EiCasl/Tgffn8nEA6Nc0VBTrxLE0Xw0Bg4SM/zVKu04eveDrwAoYhtQEMHAj5Rr4tCgPK6CAyyKNGF5UfQ/pOiBL496iud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617070; c=relaxed/simple;
	bh=6GJI8RyV4Rxgbr0HGunZUiPB2c9B8M95YOgm2k5GYIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy12kYpESvpLidfbm0vQYkScPK9OeI1PWfb5OaMGEjzWiSHVImPeZ3KKwtZ788jI/sDN4rnhbuPADWrO6kG9y+joKQrh6ys56F2hXxPwxzTUCUVNQIynvit2mo1Yqika7kCtOUk71uM0G39TL3RDZpVzeghElTdEUb+473Pc20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e0eoA3Rw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=60VR4dPt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e0eoA3Rw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=60VR4dPt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C3045FE13;
	Mon, 17 Jun 2024 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718617066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SflxasanEA/QtBQMFtVqAWfy8whSAsE2lNZEdzjNdd4=;
	b=e0eoA3RwXAUApO9OKFPUvDLR7Su4DXfOVMavcXGgWD2mB625CNUBJPgxynUWq0RXpTy8U1
	dNsdSNXz/cOIs0WeOmwg1BkKaXMXVSMq6zA50xqDvsb5sW1PN5LCTejML6iMlLLvh9ChwR
	vRsoNbrAf5iy8S1rJq8pbDgMGE3USQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718617066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SflxasanEA/QtBQMFtVqAWfy8whSAsE2lNZEdzjNdd4=;
	b=60VR4dPt9IjY7qkDextIsvc8s7WdXcsVzYK2nbo624/PVrX35T0zYvjSGzWKaS1ETvUHRr
	KnV99vuMnASrOjDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e0eoA3Rw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=60VR4dPt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718617066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SflxasanEA/QtBQMFtVqAWfy8whSAsE2lNZEdzjNdd4=;
	b=e0eoA3RwXAUApO9OKFPUvDLR7Su4DXfOVMavcXGgWD2mB625CNUBJPgxynUWq0RXpTy8U1
	dNsdSNXz/cOIs0WeOmwg1BkKaXMXVSMq6zA50xqDvsb5sW1PN5LCTejML6iMlLLvh9ChwR
	vRsoNbrAf5iy8S1rJq8pbDgMGE3USQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718617066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SflxasanEA/QtBQMFtVqAWfy8whSAsE2lNZEdzjNdd4=;
	b=60VR4dPt9IjY7qkDextIsvc8s7WdXcsVzYK2nbo624/PVrX35T0zYvjSGzWKaS1ETvUHRr
	KnV99vuMnASrOjDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E24913AAA;
	Mon, 17 Jun 2024 09:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lkRuA+oDcGYgeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 09:37:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9A78A0886; Mon, 17 Jun 2024 11:37:45 +0200 (CEST)
Date: Mon, 17 Jun 2024 11:37:45 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Amir Goldstein <amir73il@gmail.com>,
	James Clark <james.clark@arm.com>, ltp@lists.linux.it,
	linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
Message-ID: <20240617093745.nhnc7e7efdldnjzl@quack3>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,arm.com,lists.linux.it,vger.kernel.org,zeniv.linux.org.uk,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1C3045FE13
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sat 15-06-24 07:35:42, Christian Brauner wrote:
> On Wed, 12 Jun 2024 17:09:55 +1000, NeilBrown wrote:
> > When a file is opened and created with open(..., O_CREAT) we get
> > both the CREATE and OPEN fsnotify events and would expect them in that
> > order.   For most filesystems we get them in that order because
> > open_last_lookups() calls fsnofify_create() and then do_open() (from
> > path_openat()) calls vfs_open()->do_dentry_open() which calls
> > fsnotify_open().
> > 
> > [...]
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
> 
> [1/1] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open used.
>       https://git.kernel.org/vfs/vfs/c/7536b2f06724

I have reviewed the patch you've committed since I wasn't quite sure which
changes you're going to apply after your discussion with Amir. And I have
two comments:

@@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
  */
 int vfs_open(const struct path *path, struct file *file)
 {
+	int ret;
+
 	file->f_path = *path;
-	return do_dentry_open(file, NULL);
+	ret = do_dentry_open(file, NULL);
+	if (!ret)
+		/*
+		 * Once we return a file with FMODE_OPENED, __fput() will call
+		 * fsnotify_close(), so we need fsnotify_open() here for symmetry.
+		 */
+		fsnotify_open(file);
+	return ret;
 }

AFAICT this will have a side-effect that now fsnotify_open() will be
generated even for O_PATH open. It is true that fsnotify_close() is getting
generated for them already and we should strive for symmetry. Conceptually
it doesn't make sense to me to generate fsnotify events for O_PATH
opens/closes but maybe I miss something. Amir, any opinion here?

@@ -3612,6 +3612,9 @@ static int do_open(struct nameidata *nd,
 	int acc_mode;
 	int error;
 
+	if (file->f_mode & FMODE_OPENED)
+		fsnotify_open(file);
+
 	if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
 		error = complete_walk(nd);
 		if (error)

Frankly, this works but looks as an odd place to put this notification to.
Why not just placing it just next to where fsnotify_create() is generated
in open_last_lookups()? Like:

        if (open_flag & O_CREAT)
                inode_lock(dir->d_inode);
        else
                inode_lock_shared(dir->d_inode);
        dentry = lookup_open(nd, file, op, got_write);
-	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
-		fsnotify_create(dir->d_inode, dentry);
+	if (!IS_ERR(dentry)) {
+		if (file->f_mode & FMODE_CREATED)
+	                fsnotify_create(dir->d_inode, dentry);
+		if (file->f_mode & FMODE_OPENED)
+			fsnotify_open(file);
+	}
        if (open_flag & O_CREAT)
                inode_unlock(dir->d_inode);
        else
                inode_unlock_shared(dir->d_inode);

That looks like a place where it is much more obvious this is for
atomic_open() handling? Now I admit I'm not really closely familiar with
the atomic_open() paths so maybe I miss something and do_open() is better.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

