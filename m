Return-Path: <linux-fsdevel+bounces-42737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B27A47197
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 02:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE8316C30F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 01:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0BE198823;
	Thu, 27 Feb 2025 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uEvueHF4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tQ+YLCmP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uEvueHF4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tQ+YLCmP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54CC140E30
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620439; cv=none; b=YMf+dphsxrZtkRg2SytThBDztChPcngpkNvA4h3RYiK/aYKdr9zmVCSgZEFc0f5h94luomTEKI8+w1Get/IdUqW63voODiUlb6Inhbck5jZxvXi/e+zzWf0L8CsTBp2YTpG8i26MbhKnIYyUSCMMVANaMviFuGd0/fYJ8Wy0Po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620439; c=relaxed/simple;
	bh=3s0yWm/5XHYd8aq9vxOE55g2Knef9B81JUShzvD0kkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVNTZQyzIe7ENlVgiqpFr9VGiAeJSqmJJiH9DJrKg1DwS2sOuWSh9eOzeEzRJ1iVgZJAQyMCtk7xvmB0zC2RerKGY6DK2l8rcz5CGg+Q55b23Hh1sLU73nJY7a8fnHaTU9OFZ1NPejLQoOWetvjUCa+ze6lesJ+ugaTTwQnDuts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uEvueHF4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tQ+YLCmP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uEvueHF4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tQ+YLCmP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E27161F387;
	Thu, 27 Feb 2025 01:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqlgJrRfFfOStNHDiZ1evU6ja72lhQY7pRBIMD+Gk1o=;
	b=uEvueHF4nkSgnjrPw+Upej5yrG03aOEaiAMrBeGdRiHQsMgbCDWhjHsPAn5PFrSav43LjM
	0VSOd69ZTVuXDGMLo1hU+3toKe/BS6om1s6PhBfe8fo1nGLhlYM0LM7H4fk9KuSkY2sPdR
	LU1dqDutdbUyvb4HluZPdPmdnGplMTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqlgJrRfFfOStNHDiZ1evU6ja72lhQY7pRBIMD+Gk1o=;
	b=tQ+YLCmPx6s51q6fgfH/Ge15LzwEIjaGCuw30NRYR+Ya58VwxYj1M6p8oj+FffLFPV0gJ/
	lIbEOCuiDGG+j8DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqlgJrRfFfOStNHDiZ1evU6ja72lhQY7pRBIMD+Gk1o=;
	b=uEvueHF4nkSgnjrPw+Upej5yrG03aOEaiAMrBeGdRiHQsMgbCDWhjHsPAn5PFrSav43LjM
	0VSOd69ZTVuXDGMLo1hU+3toKe/BS6om1s6PhBfe8fo1nGLhlYM0LM7H4fk9KuSkY2sPdR
	LU1dqDutdbUyvb4HluZPdPmdnGplMTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqlgJrRfFfOStNHDiZ1evU6ja72lhQY7pRBIMD+Gk1o=;
	b=tQ+YLCmPx6s51q6fgfH/Ge15LzwEIjaGCuw30NRYR+Ya58VwxYj1M6p8oj+FffLFPV0gJ/
	lIbEOCuiDGG+j8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EC07134A0;
	Thu, 27 Feb 2025 01:40:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uvqnE43Cv2fqEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Feb 2025 01:40:29 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ceph: return the correct dentry on mkdir
Date: Thu, 27 Feb 2025 12:32:55 +1100
Message-ID: <20250227013949.536172-4-neilb@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227013949.536172-1-neilb@suse.de>
References: <20250227013949.536172-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,vger.kernel.org,gmail.com,redhat.com,szeredi.hu,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn),to_ip_from(RL99f7qjgz3j4qaff4fhggowz5)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

ceph already splices the correct dentry (in splice_dentry()) from the
result of mkdir but does nothing more with it.

Now that ->mkdir can return a dentry, return the correct dentry.

Note that previously ceph_mkdir() could call
   ceph_init_inode_acls()
on the inode from the wrong dentry, which would be NULL.  This
is safe as ceph_init_inode_acls() checks for NULL, but is not
strictly correct.  With this patch, the inode for the returned dentry
is passed to ceph_init_inode_acls().

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/ceph/dir.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 39e0f240de06..5e98394e2dca 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1099,6 +1099,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
+	struc dentry *ret;
 	int err;
 	int op;
 
@@ -1116,32 +1117,32 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      ceph_vinop(dir), dentry, dentry, mode);
 		op = CEPH_MDS_OP_MKDIR;
 	} else {
-		err = -EROFS;
+		ret = ERR_PTR(-EROFS);
 		goto out;
 	}
 
 	if (op == CEPH_MDS_OP_MKDIR &&
 	    ceph_quota_is_max_files_exceeded(dir)) {
-		err = -EDQUOT;
+		ret = ERR_PTR(-EDQUOT);
 		goto out;
 	}
 	if ((op == CEPH_MDS_OP_MKSNAP) && IS_ENCRYPTED(dir) &&
 	    !fscrypt_has_encryption_key(dir)) {
-		err = -ENOKEY;
+		ret = ERR_PTR(-ENOKEY);
 		goto out;
 	}
 
 
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
-		err = PTR_ERR(req);
+		ret = ERR_CAST(req);
 		goto out;
 	}
 
 	mode |= S_IFDIR;
 	req->r_new_inode = ceph_new_inode(dir, dentry, &mode, &as_ctx);
 	if (IS_ERR(req->r_new_inode)) {
-		err = PTR_ERR(req->r_new_inode);
+		ret = ERR_CAST(req->r_new_inode);
 		req->r_new_inode = NULL;
 		goto out_req;
 	}
@@ -1165,15 +1166,22 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	    !req->r_reply_info.head->is_target &&
 	    !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
+	ret = ERR_PTR(err);
 out_req:
+	if (!IS_ERR(ret) && req->r_dentry != dentry)
+		/* Some other dentry was spliced in */
+		ret = dget(req->r_dentry);
 	ceph_mdsc_put_request(req);
 out:
-	if (!err)
+	if (!IS_ERR(ret)) {
+		if (ret)
+			dentry = ret;
 		ceph_init_inode_acls(d_inode(dentry), &as_ctx);
-	else
+	} else {
 		d_drop(dentry);
+	}
 	ceph_release_acl_sec_ctx(&as_ctx);
-	return ERR_PTR(err);
+	return ret;
 }
 
 static int ceph_link(struct dentry *old_dentry, struct inode *dir,
-- 
2.48.1


