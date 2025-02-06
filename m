Return-Path: <linux-fsdevel+bounces-41019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C216A2A061
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7C1161AF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A99F22371B;
	Thu,  6 Feb 2025 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r5C0MKQM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ceHtDF+g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r5C0MKQM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ceHtDF+g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF42253E1;
	Thu,  6 Feb 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820889; cv=none; b=YIT+Npc/NeYv+aF5OlCOKTgRXxrQmVs8IS5M6r2R0rVROVsGnXxIvJLwsOBHA/eSiH227OGwANfdDBZG5AA9vke9BX5nZp78x3GoJyTyjE5HRjpG+65RKPjScP7TOz7zgXuiXT+EfBocs8YCo3mSoYuxxGaRq8XqchBN0TMxPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820889; c=relaxed/simple;
	bh=Doh1fi3lk7dyxRVk4PxHj8QN0P0CPQ4ijx82ja3lDFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqjkQ3etuEF/rZouxElFXJfj5TQ3Nz5IiQDl5Z2Tc8d0LAy7Ti0HlKOYOGzNdJ17USIycsNFb8j+yMjc/Cc5NI/N1vvOI1K/WAPE5WjA9cRSFnarg8hYIi1HR7A/ey+0kbG2LytV8cAUc57XJnONGre2elNcziK748z58yyoQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r5C0MKQM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ceHtDF+g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r5C0MKQM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ceHtDF+g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 643B61F381;
	Thu,  6 Feb 2025 05:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzJzvVSPDZKlnRYA1D5bBmX9O8UlzUVlfs44jkMjMDU=;
	b=r5C0MKQMo0q15d8mBnQh4wzPZm9l7XYY+hdVZUyOWnAv+NdcuhAA8NJ8N2YLsEzmHGgJzs
	XpEGcbqmD86LWdh7gJO6jzfi+FBWN/UDId6TED5QBk5YxU4Pk0PmEYXoj6R78XBbyPy68u
	3TdfX/NHUEAtcQYANMsiObxoxpZCgIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzJzvVSPDZKlnRYA1D5bBmX9O8UlzUVlfs44jkMjMDU=;
	b=ceHtDF+gXEs6hqVqFFr/dv1cZtqedHnRkVde8mWEgVGzOmynyQmY+O5XlOh7p4YeSb3Ybf
	UGB7MsEp9Kig7LCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r5C0MKQM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ceHtDF+g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzJzvVSPDZKlnRYA1D5bBmX9O8UlzUVlfs44jkMjMDU=;
	b=r5C0MKQMo0q15d8mBnQh4wzPZm9l7XYY+hdVZUyOWnAv+NdcuhAA8NJ8N2YLsEzmHGgJzs
	XpEGcbqmD86LWdh7gJO6jzfi+FBWN/UDId6TED5QBk5YxU4Pk0PmEYXoj6R78XBbyPy68u
	3TdfX/NHUEAtcQYANMsiObxoxpZCgIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzJzvVSPDZKlnRYA1D5bBmX9O8UlzUVlfs44jkMjMDU=;
	b=ceHtDF+gXEs6hqVqFFr/dv1cZtqedHnRkVde8mWEgVGzOmynyQmY+O5XlOh7p4YeSb3Ybf
	UGB7MsEp9Kig7LCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A170D13795;
	Thu,  6 Feb 2025 05:48:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DntlFRJNpGcCCAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:48:02 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] nfsd: use lookup_and_lock_one() and lookup_and_lock_rename_one()
Date: Thu,  6 Feb 2025 16:42:54 +1100
Message-ID: <20250206054504.2950516-18-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 643B61F381
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

nfsd now used lookup_and_lock_one() when creating/removing names in the
exported filesystem.
It uses lookup_and_lock_rename_one() when renaming.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsproc.c |  12 +++---
 fs/nfsd/vfs.c     | 107 +++++++++++++---------------------------------
 2 files changed, 36 insertions(+), 83 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c..27c2b1d5e1ac 100644
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
+	done_lookup_and_lock(dirfhp->fh_dentry, dchild, LOOKUP_CREATE);
+put_write:
 	fh_drop_write(dirfhp);
 done:
 	fh_put(dirfhp);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 740332413138..af4a7f75cca0 100644
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
+	done_lookup_and_lock(dentry, dchild, LOOKUP_CREATE);
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
+	done_lookup_and_lock(dentry, dnew, LOOKUP_CREATE);
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
+	done_lookup_and_lock(ddir, dnew, LOOKUP_CREATE);
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
@@ -1788,7 +1774,7 @@ __be32
 nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 			    struct svc_fh *tfhp, char *tname, int tlen)
 {
-	struct dentry	*fdentry, *tdentry, *odentry, *ndentry, *trap;
+	struct dentry	*fdentry, *tdentry, *odentry, *ndentry;
 	struct inode	*fdir, *tdir;
 	__be32		err;
 	int		host_err;
@@ -1824,9 +1810,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out;
 	}
 
-	trap = lock_rename(tdentry, fdentry);
-	if (IS_ERR(trap)) {
-		err = nfserr_xdev;
+	host_err = lookup_and_lock_rename_one(fdentry, tdentry,
+					      &odentry, &ndentry,
+					      fname, flen, tname, tlen,
+					      0, LOOKUP_CREATE|LOOKUP_RENAME_TARGET);
+	if (host_err) {
+		err = nfserrno(host_err);
 		goto out_want_write;
 	}
 	err = fh_fill_pre_attrs(ffhp);
@@ -1836,30 +1825,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (err != nfs_ok)
 		goto out_unlock;
 
-	odentry = lookup_one_len(fname, fdentry, flen);
-	host_err = PTR_ERR(odentry);
-	if (IS_ERR(odentry))
-		goto out_nfserr;
-
-	host_err = -ENOENT;
-	if (d_really_is_negative(odentry))
-		goto out_dput_old;
-	host_err = -EINVAL;
-	if (odentry == trap)
-		goto out_dput_old;
-
-	ndentry = lookup_one_len(tname, tdentry, tlen);
-	host_err = PTR_ERR(ndentry);
-	if (IS_ERR(ndentry))
-		goto out_dput_old;
-	host_err = -ENOTEMPTY;
-	if (ndentry == trap)
-		goto out_dput_new;
-
 	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
 	    nfsd_has_cached_files(ndentry)) {
 		close_cached = true;
-		goto out_dput_old;
+		goto out_unlock;
 	} else {
 		struct renamedata rd = {
 			.old_mnt_idmap	= &nop_mnt_idmap,
@@ -1884,11 +1853,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 				host_err = commit_metadata(ffhp);
 		}
 	}
- out_dput_new:
-	dput(ndentry);
- out_dput_old:
-	dput(odentry);
- out_nfserr:
 	err = nfserrno(host_err);
 
 	if (!close_cached) {
@@ -1896,7 +1860,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		fh_fill_post_attrs(tfhp);
 	}
 out_unlock:
-	unlock_rename(tdentry, fdentry);
+	done_lookup_and_lock_rename(fdentry, tdentry, odentry, ndentry);
 out_want_write:
 	fh_drop_write(ffhp);
 
@@ -1943,18 +1907,11 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
-	inode_lock_nested(dirp, I_MUTEX_PARENT);
-
-	rdentry = lookup_one_len(fname, dentry, flen);
+	rdentry = lookup_and_lock_one(NULL, fname, flen, dentry, LOOKUP_REMOVE);
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
@@ -1981,11 +1938,10 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		host_err = vfs_rmdir(&nop_mnt_idmap, dirp, rdentry);
 	}
 	fh_fill_post_attrs(fhp);
-
-	inode_unlock(dirp);
+out_unlock:
+	done_lookup_and_lock(dentry, rdentry, LOOKUP_REMOVE);
 	if (!host_err)
 		host_err = commit_metadata(fhp);
-	dput(rdentry);
 	iput(rinode);    /* truncate the inode here */
 
 out_drop_write:
@@ -2001,9 +1957,6 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 out:
 	return err;
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 /*
-- 
2.47.1


