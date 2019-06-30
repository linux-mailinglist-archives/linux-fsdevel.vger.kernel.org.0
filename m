Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8025B004
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfF3NzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43624 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfF3NzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:05 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so22674463ios.10;
        Sun, 30 Jun 2019 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGC+Q3KRtnargQZFu9O073180yqEQWXH8WOQ3uc1YvY=;
        b=sI9Mok4NjzIMYHxS3aev89T4ABZrjNaATQnPftPdV1Cw4uEE3KGtt7IDEs0yqcxBlt
         ortJUJq7+E6UlIen70qP7zSMiUTirqb6M8hWKhN8i4M/B7t/x7kOutkmOXhMhdwiV4Lz
         JDcGpGSMtQKgsozksfVKAWGjgw6E4Pv3rb92kj0c055XaIoUOGlWH7JM19g2tMn7E/gI
         xrkJeE7G3DMKMieIann/1vD/7tsZN5MwyuLUkqKrplHmJrKgeYxpkKqrSCngj7QUUx2q
         IjthfFqmVaAKQr8iZx3rOoiiCP8locDEyUhSBfXoUcbwV3D+/3pEOa8/1z7Wt6AqAt9T
         xlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGC+Q3KRtnargQZFu9O073180yqEQWXH8WOQ3uc1YvY=;
        b=dHyuTapyzyqy/jBY1qxCxfnhYAWnK7fPhoLRZbao2VyiPxapsNqWhO7c/AcNTwFtZX
         dLdj4I4enmXitA/2wqnHeZEzfyBAJYANBJkfttsR8xvDpYZLhISq42Z9+sHPED9m92dN
         jPGgAvBlZsWEFq/7xzstpK3B+ZCWfKNeATCUCqL35QlfhhBRG7wSJIwHJOAehE7TEflQ
         HGzcxdD2EOFuiKdYGL9LTJt3HJmkjWqI5/HsQpG+OOdGXFXQQheylYDxJSgqzln1EnGH
         zB2f5tAhsneJVio9wiYQF62U+rEz4e2YtJ5GSRORaOAEf78aU6wYBjkaG5xxe8W+0NKe
         sfUQ==
X-Gm-Message-State: APjAAAWNBNki9Yruwrn1GiL6r6XfDJnlZk8rlAQrbRLwuwpVxG00vxWS
        Qk2Ejfjh9/eSxfLkHw+e4w==
X-Google-Smtp-Source: APXvYqz6cZwYg09l2wJGP9xkQkuxs7ULhg2qH7LXa328Zey8lRV6DICqXWt5Tg/SL9LpcgODNWHTLw==
X-Received: by 2002:a5d:964d:: with SMTP id d13mr11723566ios.224.1561902904377;
        Sun, 30 Jun 2019 06:55:04 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.55.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:55:03 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/16] nfsd: convert fi_deleg_file and ls_file fields to nfsd_file
Date:   Sun, 30 Jun 2019 09:52:34 -0400
Message-Id: <20190630135240.7490-11-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-10-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
 <20190630135240.7490-5-trond.myklebust@hammerspace.com>
 <20190630135240.7490-6-trond.myklebust@hammerspace.com>
 <20190630135240.7490-7-trond.myklebust@hammerspace.com>
 <20190630135240.7490-8-trond.myklebust@hammerspace.com>
 <20190630135240.7490-9-trond.myklebust@hammerspace.com>
 <20190630135240.7490-10-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Have them keep an nfsd_file reference instead of a struct file.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/blocklayout.c |   3 +-
 fs/nfsd/nfs4layouts.c |  12 ++--
 fs/nfsd/nfs4state.c   | 140 +++++++++++++++++++++---------------------
 fs/nfsd/state.h       |   6 +-
 4 files changed, 82 insertions(+), 79 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 4fb1f72a25fb..878bc5d76c8a 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -15,6 +15,7 @@
 
 #include "blocklayoutxdr.h"
 #include "pnfs.h"
+#include "filecache.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
@@ -406,7 +407,7 @@ static void
 nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
-	struct block_device *bdev = ls->ls_file->f_path.mnt->mnt_sb->s_bdev;
+	struct block_device *bdev = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 
 	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp), 0, true);
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index a79e24b79095..2681c70283ce 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -169,8 +169,8 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 	spin_unlock(&fp->fi_lock);
 
 	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
-		vfs_setlease(ls->ls_file, F_UNLCK, NULL, (void **)&ls);
-	fput(ls->ls_file);
+		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
+	nfsd_file_put(ls->ls_file);
 
 	if (ls->ls_recalled)
 		atomic_dec(&ls->ls_stid.sc_file->fi_lo_recalls);
@@ -197,7 +197,7 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_owner = ls;
 	fl->fl_pid = current->tgid;
-	fl->fl_file = ls->ls_file;
+	fl->fl_file = ls->ls_file->nf_file;
 
 	status = vfs_setlease(fl->fl_file, fl->fl_type, &fl, NULL);
 	if (status) {
@@ -236,13 +236,13 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 			NFSPROC4_CLNT_CB_LAYOUT);
 
 	if (parent->sc_type == NFS4_DELEG_STID)
-		ls->ls_file = get_file(fp->fi_deleg_file);
+		ls->ls_file = nfsd_file_get(fp->fi_deleg_file);
 	else
 		ls->ls_file = find_any_file(fp);
 	BUG_ON(!ls->ls_file);
 
 	if (nfsd4_layout_setlease(ls)) {
-		fput(ls->ls_file);
+		nfsd_file_put(ls->ls_file);
 		put_nfs4_file(fp);
 		kmem_cache_free(nfs4_layout_stateid_cache, ls);
 		return NULL;
@@ -626,7 +626,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
 
 	argv[0] = (char *)nfsd_recall_failed;
 	argv[1] = addr_str;
-	argv[2] = ls->ls_file->f_path.mnt->mnt_sb->s_id;
+	argv[2] = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_id;
 	argv[3] = NULL;
 
 	error = call_usermodehelper(nfsd_recall_failed, argv, envp,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 394438e6a72f..0e578ce11d1b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -418,18 +418,18 @@ put_nfs4_file(struct nfs4_file *fi)
 	}
 }
 
-static struct file *
+static struct nfsd_file *
 __nfs4_get_fd(struct nfs4_file *f, int oflag)
 {
 	if (f->fi_fds[oflag])
-		return get_file(f->fi_fds[oflag]->nf_file);
+		return nfsd_file_get(f->fi_fds[oflag]);
 	return NULL;
 }
 
-static struct file *
+static struct nfsd_file *
 find_writeable_file_locked(struct nfs4_file *f)
 {
-	struct file *ret;
+	struct nfsd_file *ret;
 
 	lockdep_assert_held(&f->fi_lock);
 
@@ -439,10 +439,10 @@ find_writeable_file_locked(struct nfs4_file *f)
 	return ret;
 }
 
-static struct file *
+static struct nfsd_file *
 find_writeable_file(struct nfs4_file *f)
 {
-	struct file *ret;
+	struct nfsd_file *ret;
 
 	spin_lock(&f->fi_lock);
 	ret = find_writeable_file_locked(f);
@@ -451,9 +451,10 @@ find_writeable_file(struct nfs4_file *f)
 	return ret;
 }
 
-static struct file *find_readable_file_locked(struct nfs4_file *f)
+static struct nfsd_file *
+find_readable_file_locked(struct nfs4_file *f)
 {
-	struct file *ret;
+	struct nfsd_file *ret;
 
 	lockdep_assert_held(&f->fi_lock);
 
@@ -463,10 +464,10 @@ static struct file *find_readable_file_locked(struct nfs4_file *f)
 	return ret;
 }
 
-static struct file *
+static struct nfsd_file *
 find_readable_file(struct nfs4_file *f)
 {
-	struct file *ret;
+	struct nfsd_file *ret;
 
 	spin_lock(&f->fi_lock);
 	ret = find_readable_file_locked(f);
@@ -475,10 +476,10 @@ find_readable_file(struct nfs4_file *f)
 	return ret;
 }
 
-struct file *
+struct nfsd_file *
 find_any_file(struct nfs4_file *f)
 {
-	struct file *ret;
+	struct nfsd_file *ret;
 
 	spin_lock(&f->fi_lock);
 	ret = __nfs4_get_fd(f, O_RDWR);
@@ -921,25 +922,25 @@ nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid)
 
 static void put_deleg_file(struct nfs4_file *fp)
 {
-	struct file *filp = NULL;
+	struct nfsd_file *nf = NULL;
 
 	spin_lock(&fp->fi_lock);
 	if (--fp->fi_delegees == 0)
-		swap(filp, fp->fi_deleg_file);
+		swap(nf, fp->fi_deleg_file);
 	spin_unlock(&fp->fi_lock);
 
-	if (filp)
-		fput(filp);
+	if (nf)
+		nfsd_file_put(nf);
 }
 
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
-	struct file *filp = fp->fi_deleg_file;
+	struct nfsd_file *nf = fp->fi_deleg_file;
 
 	WARN_ON_ONCE(!fp->fi_delegees);
 
-	vfs_setlease(filp, F_UNLCK, NULL, (void **)&dp);
+	vfs_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
 	put_deleg_file(fp);
 }
 
@@ -1277,11 +1278,14 @@ static void nfs4_free_lock_stateid(struct nfs4_stid *stid)
 {
 	struct nfs4_ol_stateid *stp = openlockstateid(stid);
 	struct nfs4_lockowner *lo = lockowner(stp->st_stateowner);
-	struct file *file;
+	struct nfsd_file *nf;
 
-	file = find_any_file(stp->st_stid.sc_file);
-	if (file)
-		filp_close(file, (fl_owner_t)lo);
+	nf = find_any_file(stp->st_stid.sc_file);
+	if (nf) {
+		get_file(nf->nf_file);
+		filp_close(nf->nf_file, (fl_owner_t)lo);
+		nfsd_file_put(nf);
+	}
 	nfs4_free_ol_stateid(stid);
 }
 
@@ -4372,7 +4376,7 @@ static struct file_lock *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_owner = (fl_owner_t)dp;
 	fl->fl_pid = current->tgid;
-	fl->fl_file = dp->dl_stid.sc_file->fi_deleg_file;
+	fl->fl_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
 	return fl;
 }
 
@@ -4382,7 +4386,7 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 {
 	int status = 0;
 	struct nfs4_delegation *dp;
-	struct file *filp;
+	struct nfsd_file *nf;
 	struct file_lock *fl;
 
 	/*
@@ -4393,8 +4397,8 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 	if (fp->fi_had_conflict)
 		return ERR_PTR(-EAGAIN);
 
-	filp = find_readable_file(fp);
-	if (!filp) {
+	nf = find_readable_file(fp);
+	if (!nf) {
 		/* We should always have a readable file here */
 		WARN_ON_ONCE(1);
 		return ERR_PTR(-EBADF);
@@ -4404,17 +4408,17 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 	if (nfs4_delegation_exists(clp, fp))
 		status = -EAGAIN;
 	else if (!fp->fi_deleg_file) {
-		fp->fi_deleg_file = filp;
+		fp->fi_deleg_file = nf;
 		/* increment early to prevent fi_deleg_file from being
 		 * cleared */
 		fp->fi_delegees = 1;
-		filp = NULL;
+		nf = NULL;
 	} else
 		fp->fi_delegees++;
 	spin_unlock(&fp->fi_lock);
 	spin_unlock(&state_lock);
-	if (filp)
-		fput(filp);
+	if (nf)
+		nfsd_file_put(nf);
 	if (status)
 		return ERR_PTR(status);
 
@@ -4427,7 +4431,7 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 	if (!fl)
 		goto out_clnt_odstate;
 
-	status = vfs_setlease(fp->fi_deleg_file, fl->fl_type, &fl, NULL);
+	status = vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, &fl, NULL);
 	if (fl)
 		locks_free_lock(fl);
 	if (status)
@@ -4447,7 +4451,7 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 
 	return dp;
 out_unlock:
-	vfs_setlease(fp->fi_deleg_file, F_UNLCK, NULL, (void **)&dp);
+	vfs_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
 out_clnt_odstate:
 	put_clnt_odstate(dp->dl_clnt_odstate);
 	nfs4_put_stid(&dp->dl_stid);
@@ -5118,7 +5122,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	return nfs_ok;
 }
 
-static struct file *
+static struct nfsd_file *
 nfs4_find_file(struct nfs4_stid *s, int flags)
 {
 	if (!s)
@@ -5128,7 +5132,7 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
 	case NFS4_DELEG_STID:
 		if (WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
 			return NULL;
-		return get_file(s->sc_file->fi_deleg_file);
+		return nfsd_file_get(s->sc_file->fi_deleg_file);
 	case NFS4_OPEN_STID:
 	case NFS4_LOCK_STID:
 		if (flags & RD_STATE)
@@ -5157,29 +5161,27 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 		struct file **filpp, bool *tmp_file, int flags)
 {
 	int acc = (flags & RD_STATE) ? NFSD_MAY_READ : NFSD_MAY_WRITE;
-	struct file *file;
+	struct nfsd_file *nf;
 	__be32 status;
 
-	file = nfs4_find_file(s, flags);
-	if (file) {
+	nf = nfs4_find_file(s, flags);
+	if (nf) {
 		status = nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
 				acc | NFSD_MAY_OWNER_OVERRIDE);
-		if (status) {
-			fput(file);
-			return status;
-		}
-
-		*filpp = file;
+		if (status)
+			goto out;
 	} else {
-		status = nfsd_open(rqstp, fhp, S_IFREG, acc, filpp);
+		status = nfsd_file_acquire(rqstp, fhp, acc, &nf);
 		if (status)
 			return status;
 
 		if (tmp_file)
 			*tmp_file = true;
 	}
-
-	return 0;
+	*filpp = get_file(nf->nf_file);
+out:
+	nfsd_file_put(nf);
+	return status;
 }
 
 /*
@@ -5998,7 +6000,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_ol_stateid *lock_stp = NULL;
 	struct nfs4_ol_stateid *open_stp = NULL;
 	struct nfs4_file *fp;
-	struct file *filp = NULL;
+	struct nfsd_file *nf = NULL;
 	struct nfsd4_blocked_lock *nbl = NULL;
 	struct file_lock *file_lock = NULL;
 	struct file_lock *conflock = NULL;
@@ -6080,8 +6082,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			/* Fallthrough */
 		case NFS4_READ_LT:
 			spin_lock(&fp->fi_lock);
-			filp = find_readable_file_locked(fp);
-			if (filp)
+			nf = find_readable_file_locked(fp);
+			if (nf)
 				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_READ);
 			spin_unlock(&fp->fi_lock);
 			fl_type = F_RDLCK;
@@ -6092,8 +6094,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			/* Fallthrough */
 		case NFS4_WRITE_LT:
 			spin_lock(&fp->fi_lock);
-			filp = find_writeable_file_locked(fp);
-			if (filp)
+			nf = find_writeable_file_locked(fp);
+			if (nf)
 				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_WRITE);
 			spin_unlock(&fp->fi_lock);
 			fl_type = F_WRLCK;
@@ -6103,7 +6105,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	if (!filp) {
+	if (!nf) {
 		status = nfserr_openmode;
 		goto out;
 	}
@@ -6119,7 +6121,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	file_lock->fl_type = fl_type;
 	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
 	file_lock->fl_pid = current->tgid;
-	file_lock->fl_file = filp;
+	file_lock->fl_file = nf->nf_file;
 	file_lock->fl_flags = fl_flags;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = lock->lk_offset;
@@ -6141,7 +6143,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		spin_unlock(&nn->blocked_locks_lock);
 	}
 
-	err = vfs_lock_file(filp, F_SETLK, file_lock, conflock);
+	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
 	switch (err) {
 	case 0: /* success! */
 		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
@@ -6176,8 +6178,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		}
 		free_blocked_lock(nbl);
 	}
-	if (filp)
-		fput(filp);
+	if (nf)
+		nfsd_file_put(nf);
 	if (lock_stp) {
 		/* Bump seqid manually if the 4.0 replay owner is openowner */
 		if (cstate->replay_owner &&
@@ -6304,7 +6306,7 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_locku *locku = &u->locku;
 	struct nfs4_ol_stateid *stp;
-	struct file *filp = NULL;
+	struct nfsd_file *nf = NULL;
 	struct file_lock *file_lock = NULL;
 	__be32 status;
 	int err;
@@ -6322,8 +6324,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 					&stp, nn);
 	if (status)
 		goto out;
-	filp = find_any_file(stp->st_stid.sc_file);
-	if (!filp) {
+	nf = find_any_file(stp->st_stid.sc_file);
+	if (!nf) {
 		status = nfserr_lock_range;
 		goto put_stateid;
 	}
@@ -6331,13 +6333,13 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (!file_lock) {
 		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
 		status = nfserr_jukebox;
-		goto fput;
+		goto put_file;
 	}
 
 	file_lock->fl_type = F_UNLCK;
 	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(stp->st_stateowner));
 	file_lock->fl_pid = current->tgid;
-	file_lock->fl_file = filp;
+	file_lock->fl_file = nf->nf_file;
 	file_lock->fl_flags = FL_POSIX;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = locku->lu_offset;
@@ -6346,14 +6348,14 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 						locku->lu_length);
 	nfs4_transform_lock_offset(file_lock);
 
-	err = vfs_lock_file(filp, F_SETLK, file_lock, NULL);
+	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, NULL);
 	if (err) {
 		dprintk("NFSD: nfs4_locku: vfs_lock_file failed!\n");
 		goto out_nfserr;
 	}
 	nfs4_inc_and_copy_stateid(&locku->lu_stateid, &stp->st_stid);
-fput:
-	fput(filp);
+put_file:
+	nfsd_file_put(nf);
 put_stateid:
 	mutex_unlock(&stp->st_mutex);
 	nfs4_put_stid(&stp->st_stid);
@@ -6365,7 +6367,7 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 out_nfserr:
 	status = nfserrno(err);
-	goto fput;
+	goto put_file;
 }
 
 /*
@@ -6378,17 +6380,17 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 {
 	struct file_lock *fl;
 	int status = false;
-	struct file *filp = find_any_file(fp);
+	struct nfsd_file *nf = find_any_file(fp);
 	struct inode *inode;
 	struct file_lock_context *flctx;
 
-	if (!filp) {
+	if (!nf) {
 		/* Any valid lock stateid should have some sort of access */
 		WARN_ON_ONCE(1);
 		return status;
 	}
 
-	inode = locks_inode(filp);
+	inode = locks_inode(nf->nf_file);
 	flctx = inode->i_flctx;
 
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
@@ -6401,7 +6403,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 		}
 		spin_unlock(&flctx->flc_lock);
 	}
-	fput(filp);
+	nfsd_file_put(nf);
 	return status;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index f7616bc1e901..90baf5f2dd66 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -507,7 +507,7 @@ struct nfs4_file {
 	 */
 	atomic_t		fi_access[2];
 	u32			fi_share_deny;
-	struct file		*fi_deleg_file;
+	struct nfsd_file	*fi_deleg_file;
 	int			fi_delegees;
 	struct knfsd_fh		fi_fhandle;
 	bool			fi_had_conflict;
@@ -556,7 +556,7 @@ struct nfs4_layout_stateid {
 	spinlock_t			ls_lock;
 	struct list_head		ls_layouts;
 	u32				ls_layout_type;
-	struct file			*ls_file;
+	struct nfsd_file		*ls_file;
 	struct nfsd4_callback		ls_recall;
 	stateid_t			ls_recall_sid;
 	bool				ls_recalled;
@@ -648,7 +648,7 @@ static inline void get_nfs4_file(struct nfs4_file *fi)
 {
 	refcount_inc(&fi->fi_ref);
 }
-struct file *find_any_file(struct nfs4_file *f);
+struct nfsd_file *find_any_file(struct nfs4_file *f);
 
 /* grace period management */
 void nfsd4_end_grace(struct nfsd_net *nn);
-- 
2.21.0

