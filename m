Return-Path: <linux-fsdevel+bounces-5296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEAF809AFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 05:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096BA281D73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 04:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA0563AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="anmxB+fk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RVlBKXdB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E8D10E6;
	Thu,  7 Dec 2023 19:39:49 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD09022102;
	Fri,  8 Dec 2023 03:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702006787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vu248dzuKJlGI9r2nLRgAmjct9Ps79FDgE6mGoaCwWU=;
	b=anmxB+fkH2fqhNie3MRW+XjNo0iXCABg60BSQw5Gsayu+iRy7OkPLqu3TWa1mTc05JFt4b
	PB64CHduam7aN+CxqIAk22QBDh8iM9NqskeG90Tsq/T3SdNhJ7iBncCsTGKBzfB+NjIlQb
	YV+pMG2fSEtB7Ejcs7hIWeF6ddVnbHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702006787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vu248dzuKJlGI9r2nLRgAmjct9Ps79FDgE6mGoaCwWU=;
	b=RVlBKXdBjGA2gqTyBfMjuQ3JTo5Idgr/yQkZVdm/OFHxFJVi1kDjDn+oWJNh1MzyNl0vx4
	h92N1tS4/CTf9XCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DB3C13725;
	Fri,  8 Dec 2023 03:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h/XQKNmNcmX+MAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 08 Dec 2023 03:30:33 +0000
From: NeilBrown <neilb@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of files.
Date: Fri,  8 Dec 2023 14:27:26 +1100
Message-ID: <20231208033006.5546-2-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208033006.5546-1-neilb@suse.de>
References: <20231208033006.5546-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [10.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 10.00

Calling fput() directly or though filp_close() from a kernel thread like
nfsd causes the final __fput() (if necessary) to be called from a
workqueue.  This means that nfsd is not forced to wait for any work to
complete.  If the ->release of ->destroy_inode function is slow for any
reason, this can result in nfsd closing files more quickly than the
workqueue can complete the close and the queue of pending closes can
grow without bounces (30 million has been seen at one customer site,
though this was in part due to a slowness in xfs which has since been
fixed).

nfsd does not need this.  This quite appropriate and safe for nfsd to do
its own close work.  There is now reason that close should ever wait for
nfsd, so no deadlock can occur.

So change all fput() calls to __fput_sync(), and convert filp_close() to
the sequence get_file();filp_close();__fput_sync().

This ensure that no fput work is queued to the workqueue.

Note that this removes the only in-module use of flush_fput_queue().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c   |  3 ++-
 fs/nfsd/lockd.c       |  2 +-
 fs/nfsd/nfs4proc.c    |  4 ++--
 fs/nfsd/nfs4recover.c |  2 +-
 fs/nfsd/vfs.c         | 12 ++++++------
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ef063f93fde9..e9734c7451b5 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -283,7 +283,9 @@ nfsd_file_free(struct nfsd_file *nf)
 		nfsd_file_mark_put(nf->nf_mark);
 	if (nf->nf_file) {
 		nfsd_file_check_write_error(nf);
+		get_file(nf->nf_file);
 		filp_close(nf->nf_file, NULL);
+		__fput_sync(nf->nf_file);
 	}
 
 	/*
@@ -631,7 +633,6 @@ nfsd_file_close_inode_sync(struct inode *inode)
 		list_del_init(&nf->nf_lru);
 		nfsd_file_free(nf);
 	}
-	flush_delayed_fput();
 }
 
 /**
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 46a7f9b813e5..f9d1059096a4 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -60,7 +60,7 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 static void
 nlm_fclose(struct file *filp)
 {
-	fput(filp);
+	__fput_sync(filp);
 }
 
 static const struct nlmsvc_binding nfsd_nlm_ops = {
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6f2d4aa4970d..20d60823d530 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -629,7 +629,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		nn->somebody_reclaimed = true;
 out:
 	if (open->op_filp) {
-		fput(open->op_filp);
+		__fput_sync(open->op_filp);
 		open->op_filp = NULL;
 	}
 	if (resfh && resfh != &cstate->current_fh) {
@@ -1546,7 +1546,7 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
 	long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
 
 	nfs42_ssc_close(filp);
-	fput(filp);
+	__fput_sync(filp);
 
 	spin_lock(&nn->nfsd_ssc_lock);
 	list_del(&nsui->nsui_list);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 3509e73abe1f..f8f0112fd9f5 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -561,7 +561,7 @@ nfsd4_shutdown_recdir(struct net *net)
 
 	if (!nn->rec_file)
 		return;
-	fput(nn->rec_file);
+	__fput_sync(nn->rec_file);
 	nn->rec_file = NULL;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fbbea7498f02..15a811229211 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -879,7 +879,7 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 
 	host_err = ima_file_check(file, may_flags);
 	if (host_err) {
-		fput(file);
+		__fput_sync(file);
 		goto out;
 	}
 
@@ -1884,10 +1884,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	fh_drop_write(ffhp);
 
 	/*
-	 * If the target dentry has cached open files, then we need to try to
-	 * close them prior to doing the rename. Flushing delayed fput
-	 * shouldn't be done with locks held however, so we delay it until this
-	 * point and then reattempt the whole shebang.
+	 * If the target dentry has cached open files, then we need to
+	 * try to close them prior to doing the rename.  Final fput
+	 * shouldn't be done with locks held however, so we delay it
+	 * until this point and then reattempt the whole shebang.
 	 */
 	if (close_cached) {
 		close_cached = false;
@@ -2141,7 +2141,7 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp,
 	if (err == nfserr_eof || err == nfserr_toosmall)
 		err = nfs_ok; /* can still be found in ->err */
 out_close:
-	fput(file);
+	__fput_sync(file);
 out:
 	return err;
 }
-- 
2.43.0


