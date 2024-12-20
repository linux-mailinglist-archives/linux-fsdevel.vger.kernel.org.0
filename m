Return-Path: <linux-fsdevel+bounces-37910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD479F8A77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB2B1897557
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2936E13B298;
	Fri, 20 Dec 2024 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JmTKbEUK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jccQc5g6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JmTKbEUK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jccQc5g6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27951A83EF;
	Fri, 20 Dec 2024 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664199; cv=none; b=n8zQzFIKSxctLxa5/EhqZtpkiWAxP174eDmtyivwfk73qUN88LD7MlrNkyYsEKbs7yeclKqb8K0XZ8X4RTArJUw35YPwTK9Lh6Yzsp0zDxP/4ZD/3X7+keXFqcoW01nHSv3O9C090gbsv4+/Vkz1tcP67xr5cQYgYmt8bU63hH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664199; c=relaxed/simple;
	bh=qmeWqCbcfrxnRSB0BSzquZCh8r6lbGcB7uCaJ4rrfO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtV0Fa7tBXmcxxsQ4yWPCFGegUcqPauNRLkx2J7wgh1ekQXbbfYNBWqPJ6DYZqcVgtICUJ0m3aWwzDkp20yOGSbZwaK7I8CGXqJOMiAmRiszuGaU1Y5nZrpJr4h85Zuam3MvlR4kObZcQDZed728umE7uZxIAOrdyjjRKnTnrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JmTKbEUK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jccQc5g6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JmTKbEUK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jccQc5g6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D7961F385;
	Fri, 20 Dec 2024 03:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MOfGsNLkxyU8h2zwoe18I6cYlAXQeQBcJEBsYCWOsY=;
	b=JmTKbEUKmOGMtCDEHzHW9b9KB8o63nuF3aEwy60JdX9S6EUeb9yBgrndrcW4TPzVWpWxD0
	WER23Le/kf+M2SRJdP3BWOtDVY0HHaJfyJ+0Up6DK/vm5WVM2wQwCl+Q/DvyIIk4wrfn2i
	ObQjJUxagq0xAkd0AKh8ZJ6YnzRjgQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MOfGsNLkxyU8h2zwoe18I6cYlAXQeQBcJEBsYCWOsY=;
	b=jccQc5g6gRHr17e/HDn6TwAZTy+QeRixKGXjsv8OoW1KH3DetWVXGd03jnO6i5NZMFH8vC
	dxDlIL8ZCM4TfFBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MOfGsNLkxyU8h2zwoe18I6cYlAXQeQBcJEBsYCWOsY=;
	b=JmTKbEUKmOGMtCDEHzHW9b9KB8o63nuF3aEwy60JdX9S6EUeb9yBgrndrcW4TPzVWpWxD0
	WER23Le/kf+M2SRJdP3BWOtDVY0HHaJfyJ+0Up6DK/vm5WVM2wQwCl+Q/DvyIIk4wrfn2i
	ObQjJUxagq0xAkd0AKh8ZJ6YnzRjgQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MOfGsNLkxyU8h2zwoe18I6cYlAXQeQBcJEBsYCWOsY=;
	b=jccQc5g6gRHr17e/HDn6TwAZTy+QeRixKGXjsv8OoW1KH3DetWVXGd03jnO6i5NZMFH8vC
	dxDlIL8ZCM4TfFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7FA213A32;
	Fri, 20 Dec 2024 03:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lur1JgHgZGePGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:09:53 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] nfsd: use lookup_and_lock_one()
Date: Fri, 20 Dec 2024 13:54:29 +1100
Message-ID: <20241220030830.272429-12-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220030830.272429-1-neilb@suse.de>
References: <20241220030830.272429-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

nfsd now used looksup_and_lock_one() when creating/removing names in the
exported filesystem.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsproc.c | 12 ++++-----
 fs/nfsd/vfs.c     | 67 +++++++++++++++--------------------------------
 2 files changed, 27 insertions(+), 52 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c..11ad710a0853 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -311,17 +311,16 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto done;
 	}
 
-	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
+	dchild = lookup_and_lock_one(NULL, argp->name, argp->len,
+				     dirfhp->fh_dentry, LOOKUP_CREATE);
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
-		goto out_unlock;
+		goto put_write;
 	}
 	fh_init(newfhp, NFS_FHSIZE);
 	resp->status = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
 	if (!resp->status && d_really_is_negative(dchild))
 		resp->status = nfserr_noent;
-	dput(dchild);
 	if (resp->status) {
 		if (resp->status != nfserr_noent)
 			goto out_unlock;
@@ -331,7 +330,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		resp->status = nfserr_acces;
 		if (!newfhp->fh_dentry) {
-			printk(KERN_WARNING 
+			printk(KERN_WARNING
 				"nfsd_proc_create: file handle not verified\n");
 			goto out_unlock;
 		}
@@ -427,7 +426,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 out_unlock:
-	inode_unlock(dirfhp->fh_dentry->d_inode);
+	done_lookup_and_lock(dirfhp->fh_dentry, dchild);
+put_write:
 	fh_drop_write(dirfhp);
 done:
 	fh_put(dirfhp);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 740332413138..011fb68bfa4b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1551,19 +1551,13 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one_len(fname, dentry, flen);
+	dchild = lookup_and_lock_one(NULL, fname, flen, dentry, LOOKUP_CREATE);
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild)) {
 		err = nfserrno(host_err);
-		goto out_unlock;
+		goto out;
 	}
 	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
-	/*
-	 * We unconditionally drop our ref to dchild as fh_compose will have
-	 * already grabbed its own ref for it.
-	 */
-	dput(dchild);
 	if (err)
 		goto out_unlock;
 	err = fh_fill_pre_attrs(fhp);
@@ -1572,7 +1566,8 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
 	fh_fill_post_attrs(fhp);
 out_unlock:
-	inode_unlock(dentry->d_inode);
+	done_lookup_and_lock(dentry, dchild);
+out:
 	return err;
 }
 
@@ -1656,8 +1651,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	dentry = fhp->fh_dentry;
-	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dnew = lookup_one_len(fname, dentry, flen);
+	dnew = lookup_and_lock_one(NULL, fname, flen, dentry, LOOKUP_CREATE);
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
 		inode_unlock(dentry->d_inode);
@@ -1673,11 +1667,11 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 	fh_fill_post_attrs(fhp);
 out_unlock:
-	inode_unlock(dentry->d_inode);
+	done_lookup_and_lock(dentry, dnew);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
-	dput(dnew);
-	if (err==0) err = cerr;
+	if (err==0)
+		err = cerr;
 out_drop_write:
 	fh_drop_write(fhp);
 out:
@@ -1721,43 +1715,35 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 
 	ddir = ffhp->fh_dentry;
 	dirp = d_inode(ddir);
-	inode_lock_nested(dirp, I_MUTEX_PARENT);
-
-	dnew = lookup_one_len(name, ddir, len);
+	dnew = lookup_and_lock_one(NULL, name, len, ddir, LOOKUP_CREATE);
 	if (IS_ERR(dnew)) {
-		err = nfserrno(PTR_ERR(dnew));
-		goto out_unlock;
+		err = PTR_ERR(dnew);
+		goto out_drop_write;
 	}
 
 	dold = tfhp->fh_dentry;
 
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
-		goto out_dput;
+		goto out_unlock;
 	err = fh_fill_pre_attrs(ffhp);
 	if (err != nfs_ok)
-		goto out_dput;
+		goto out_unlock;
 	host_err = vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
 	fh_fill_post_attrs(ffhp);
-	inode_unlock(dirp);
-	if (!host_err) {
+out_unlock:
+	done_lookup_and_lock(ddir, dnew);
+	if (!err && !host_err) {
 		err = nfserrno(commit_metadata(ffhp));
 		if (!err)
 			err = nfserrno(commit_metadata(tfhp));
-	} else {
+	} else if (!err) {
 		err = nfserrno(host_err);
 	}
-	dput(dnew);
 out_drop_write:
 	fh_drop_write(tfhp);
 out:
 	return err;
-
-out_dput:
-	dput(dnew);
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 static void
@@ -1943,18 +1929,11 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
-	inode_lock_nested(dirp, I_MUTEX_PARENT);
-
-	rdentry = lookup_one_len(fname, dentry, flen);
+	rdentry = lookup_and_lock_one(NULL, fname, flen, dentry, 0);
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
-		goto out_unlock;
+		goto out_drop_write;
 
-	if (d_really_is_negative(rdentry)) {
-		dput(rdentry);
-		host_err = -ENOENT;
-		goto out_unlock;
-	}
 	rinode = d_inode(rdentry);
 	err = fh_fill_pre_attrs(fhp);
 	if (err != nfs_ok)
@@ -1981,11 +1960,10 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		host_err = vfs_rmdir(&nop_mnt_idmap, dirp, rdentry);
 	}
 	fh_fill_post_attrs(fhp);
-
-	inode_unlock(dirp);
+out_unlock:
+	done_lookup_and_lock(dentry, rdentry);
 	if (!host_err)
 		host_err = commit_metadata(fhp);
-	dput(rdentry);
 	iput(rinode);    /* truncate the inode here */
 
 out_drop_write:
@@ -2001,9 +1979,6 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 out:
 	return err;
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 /*
-- 
2.47.0


