Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 405A45B009
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfF3NzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:47065 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfF3NzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:10 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so8921968iol.13;
        Sun, 30 Jun 2019 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8v/Ebd6+7083OXnEgXRyVKh9Tif5AkweJO2UQ3FM16s=;
        b=K/CD8iX5/+3pCkVbUbFZa5TWRV8sLQu/vDxxlEqLQQiCD3ECRmfJYPHhapJ7ZTYKU7
         AEM7D8S0hBWxLTIkSkhgGi1bFLiYw8n87jaaSppRS104+/vD238mAEXFWt0tMWRyF+qF
         nRd3AQtG6xWWaPxcNhcCN9QGFhGkN6aikuus61gVQDg2nTFCmguUCrRoP463evVXgWR7
         EjbA1d1WF0ficUGC8DGLllz0waqBS6fjqQ2DM7NRr/P11509AFZGE5G54zGT022l/Nw2
         Y+8nMROA8BlEc/oxcIY1OGDS5JfdJoPBZCRt9V0QxSew2lea60HW0F5Fdp+4w4w5wyXe
         sqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8v/Ebd6+7083OXnEgXRyVKh9Tif5AkweJO2UQ3FM16s=;
        b=fExjo1O26xhYh/41Pc6qIwGFxioFXLw7v8CZPWT30I02/EXSHdeoEKOQxlmfMYUaZB
         ZKe5fw1n+dxYP2nMgGgZjb/XtRQvWDFaiGKVQs3phqXMwAGTIEkkaGkTfWIAxc4/rQjo
         MSKdxYiPKe9uZ+5CEQc3L7FnH6XTlJt4Y6xKbdemBKmmxCKM/Y7Cze28VaBpTcphAIGs
         BdzpwBsyneTrpnty7It1R/6HLw6WHFjw9BnWjphopG7auYN5K+8CcoxFdS8Fu0RPO0RM
         bzMKzizpAjGOpmR2YdEP1nvROuTAlRimjs+EwoUl38O+TM6QapfyiuQ3nylIOJRrhQD7
         QPUQ==
X-Gm-Message-State: APjAAAXfnKmJdEke2xg+oVmOUFsLaHbxoPxFikGwlErDHkPiTqAG0YzH
        vNeZuQhLO0kAnZbhc8dn3hCB0YyuXQ==
X-Google-Smtp-Source: APXvYqxPZJFjyfoUCT+ubROjqjt8n0lMqGID4y1rGu0HWUSp9h4bbDgO3IP6rqstWEftDOQyXbfJcg==
X-Received: by 2002:a6b:1cc:: with SMTP id 195mr17371706iob.87.1561902909015;
        Sun, 30 Jun 2019 06:55:09 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.55.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:55:08 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/16] nfsd: close cached files prior to a REMOVE or RENAME that would replace target
Date:   Sun, 30 Jun 2019 09:52:38 -0400
Message-Id: <20190630135240.7490-15-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-14-trond.myklebust@hammerspace.com>
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
 <20190630135240.7490-11-trond.myklebust@hammerspace.com>
 <20190630135240.7490-12-trond.myklebust@hammerspace.com>
 <20190630135240.7490-13-trond.myklebust@hammerspace.com>
 <20190630135240.7490-14-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

It's not uncommon for some workloads to do a bunch of I/O to a file and
delete it just afterward. If knfsd has a cached open file however, then
the file may still be open when the dentry is unlinked. If the
underlying filesystem is nfs, then that could trigger it to do a
sillyrename.

On a REMOVE or RENAME scan the nfsd_file cache for open files that
correspond to the inode, and proactively unhash and put their
references. This should prevent any delete-on-last-close activity from
occurring, solely due to knfsd's open file cache.

This must be done synchronously though so we use the variants that call
flush_delayed_fput. There are deadlock possibilities if you call
flush_delayed_fput while holding locks, however. In the case of
nfsd_rename, we don't even do the lookups of the dentries to be renamed
until we've locked for rename.

Once we've figured out what the target dentry is for a rename, check to
see whether there are cached open files associated with it. If there
are, then unwind all of the locking, close them all, and then reattempt
the rename.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c | 62 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 58b6d8df95d4..f5cf64a40112 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1590,6 +1590,26 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	goto out_unlock;
 }
 
+static void
+nfsd_close_cached_files(struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (inode && S_ISREG(inode->i_mode))
+		nfsd_file_close_inode_sync(inode);
+}
+
+static bool
+nfsd_has_cached_files(struct dentry *dentry)
+{
+	bool		ret = false;
+	struct inode *inode = d_inode(dentry);
+
+	if (inode && S_ISREG(inode->i_mode))
+		ret = nfsd_file_is_cached(inode);
+	return ret;
+}
+
 /*
  * Rename a file
  * N.B. After this call _both_ ffhp and tfhp need an fh_put
@@ -1602,6 +1622,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	struct inode	*fdir, *tdir;
 	__be32		err;
 	int		host_err;
+	bool		has_cached = false;
 
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
 	if (err)
@@ -1620,6 +1641,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
+retry:
 	host_err = fh_want_write(ffhp);
 	if (host_err) {
 		err = nfserrno(host_err);
@@ -1659,11 +1681,16 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
 		goto out_dput_new;
 
-	host_err = vfs_rename(fdir, odentry, tdir, ndentry, NULL, 0);
-	if (!host_err) {
-		host_err = commit_metadata(tfhp);
-		if (!host_err)
-			host_err = commit_metadata(ffhp);
+	if (nfsd_has_cached_files(ndentry)) {
+		has_cached = true;
+		goto out_dput_old;
+	} else {
+		host_err = vfs_rename(fdir, odentry, tdir, ndentry, NULL, 0);
+		if (!host_err) {
+			host_err = commit_metadata(tfhp);
+			if (!host_err)
+				host_err = commit_metadata(ffhp);
+		}
 	}
  out_dput_new:
 	dput(ndentry);
@@ -1676,12 +1703,26 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	 * as that would do the wrong thing if the two directories
 	 * were the same, so again we do it by hand.
 	 */
-	fill_post_wcc(ffhp);
-	fill_post_wcc(tfhp);
+	if (!has_cached) {
+		fill_post_wcc(ffhp);
+		fill_post_wcc(tfhp);
+	}
 	unlock_rename(tdentry, fdentry);
 	ffhp->fh_locked = tfhp->fh_locked = false;
 	fh_drop_write(ffhp);
 
+	/*
+	 * If the target dentry has cached open files, then we need to try to
+	 * close them prior to doing the rename. Flushing delayed fput
+	 * shouldn't be done with locks held however, so we delay it until this
+	 * point and then reattempt the whole shebang.
+	 */
+	if (has_cached) {
+		has_cached = false;
+		nfsd_close_cached_files(ndentry);
+		dput(ndentry);
+		goto retry;
+	}
 out:
 	return err;
 }
@@ -1728,10 +1769,13 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
-	if (type != S_IFDIR)
+	if (type != S_IFDIR) {
+		nfsd_close_cached_files(rdentry);
 		host_err = vfs_unlink(dirp, rdentry, NULL);
-	else
+	} else {
 		host_err = vfs_rmdir(dirp, rdentry);
+	}
+
 	if (!host_err)
 		host_err = commit_metadata(fhp);
 	dput(rdentry);
-- 
2.21.0

