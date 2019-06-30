Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD345B008
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfF3NzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:55:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38913 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfF3NzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:55:09 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so22735708iod.6;
        Sun, 30 Jun 2019 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HjT1gJzAymhKuycGEihYS7Q831Ru9lPvINuKZXjgWgw=;
        b=BJxT1NZ3xpEyljRaS4dTjrrdyaXTMcDPBeF9gh54gt+t7rHh2YVmFYWjEAHvtGvwSe
         2Fx4DvFdFCscrhC1N6ZxYZRW3V1xTVpy4enFqhB+LlVHrVSjNsyKayE9pwyLj5kWg699
         7aXFFclWECXQcrUKVCM5rX/y/cot7erfl0L04SP5CsSrGI1HZ1GCWqn00QJxtZ1qhPN1
         4uUml2JDzVfKCurBCzUq5S7Y1tR6AVb3x6d0C/GgJ8MqIJk8QL5tDY+7AZ6fAI+pCeFe
         JfFVvwQjvbdZw7jr3rq1l4bY9eMY1FP1+Sj05TrGCb0j/rWp9UlJrvmWO2kfP7yuU9jj
         CEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HjT1gJzAymhKuycGEihYS7Q831Ru9lPvINuKZXjgWgw=;
        b=FZ/3JaCYbs2sj6D0AMmybddbAMy2vgrrzCAQzWW48WqDw/C+vBe/NbGZeLbcO0+Oey
         xtIVNHVg6r9pX/Ivxe8idFxreFWTcnTwO45TcBa7NprUj0Xf+DjqVaRcCCnkw77+2VHB
         L7AuHaj95WMxJy0RbgJgXbkTKAqm0YhPwHAL065SCOlYhwNp4Wb41hLk+8TDEMLkxo8K
         HJ2+a1UpPV8eTMfj1n/O6r/YUxK4lg3jgdqaVAV6qht/0qMVA5x5c9xp7b7zhEsvgfuP
         TQqPSeHUbMntkD7/LbzlZ+8vBQNF53e97ExDFnaNk/pasVO/S3MY1nsQoGjqJKqmYzPa
         iQJA==
X-Gm-Message-State: APjAAAVWlIn0QYP4/tC4fiM+LlZn7Cpq4xV5mVy/Kgus/oQUjO6NVsPx
        mGUTJ/5Pfa7sHR5XKbZREQ==
X-Google-Smtp-Source: APXvYqxuJhwZOIeVY0cv14IRWre/C8VidxFZ3pzhb+4jq3GjKeg7zLgd4WQEO4iyNRHXlPxk1oWaOA==
X-Received: by 2002:a5d:8844:: with SMTP id t4mr20275195ios.91.1561902907674;
        Sun, 30 Jun 2019 06:55:07 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.55.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:55:07 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/16] nfsd: rip out the raparms cache
Date:   Sun, 30 Jun 2019 09:52:37 -0400
Message-Id: <20190630135240.7490-14-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-13-trond.myklebust@hammerspace.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Nothing uses it anymore.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfssvc.c |  13 +----
 fs/nfsd/vfs.c    | 149 -----------------------------------------------
 fs/nfsd/vfs.h    |   6 --
 3 files changed, 1 insertion(+), 167 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a6b1eab7b722..d02712ca2685 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -317,22 +317,12 @@ static int nfsd_startup_generic(int nrservs)
 	ret = nfsd_file_cache_init();
 	if (ret)
 		goto dec_users;
-	/*
-	 * Readahead param cache - will no-op if it already exists.
-	 * (Note therefore results will be suboptimal if number of
-	 * threads is modified after nfsd start.)
-	 */
-	ret = nfsd_racache_init(2*nrservs);
-	if (ret)
-		goto out_file_cache;
 
 	ret = nfs4_state_start();
 	if (ret)
-		goto out_racache;
+		goto out_file_cache;
 	return 0;
 
-out_racache:
-	nfsd_racache_shutdown();
 out_file_cache:
 	nfsd_file_cache_shutdown();
 dec_users:
@@ -347,7 +337,6 @@ static void nfsd_shutdown_generic(void)
 
 	nfs4_state_shutdown();
 	nfsd_file_cache_shutdown();
-	nfsd_racache_shutdown();
 }
 
 static bool nfsd_needs_lockd(struct nfsd_net *nn)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f26c364bdbb9..58b6d8df95d4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,34 +49,6 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
-
-/*
- * This is a cache of readahead params that help us choose the proper
- * readahead strategy. Initially, we set all readahead parameters to 0
- * and let the VFS handle things.
- * If you increase the number of cached files very much, you'll need to
- * add a hash table here.
- */
-struct raparms {
-	struct raparms		*p_next;
-	unsigned int		p_count;
-	ino_t			p_ino;
-	dev_t			p_dev;
-	int			p_set;
-	struct file_ra_state	p_ra;
-	unsigned int		p_hindex;
-};
-
-struct raparm_hbucket {
-	struct raparms		*pb_head;
-	spinlock_t		pb_lock;
-} ____cacheline_aligned_in_smp;
-
-#define RAPARM_HASH_BITS	4
-#define RAPARM_HASH_SIZE	(1<<RAPARM_HASH_BITS)
-#define RAPARM_HASH_MASK	(RAPARM_HASH_SIZE-1)
-static struct raparm_hbucket	raparm_hash[RAPARM_HASH_SIZE];
-
 /* 
  * Called from nfsd_lookup and encode_dirent. Check if we have crossed 
  * a mount point.
@@ -822,67 +794,6 @@ nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	return err;
 }
 
-
-
-struct raparms *
-nfsd_init_raparms(struct file *file)
-{
-	struct inode *inode = file_inode(file);
-	dev_t dev = inode->i_sb->s_dev;
-	ino_t ino = inode->i_ino;
-	struct raparms	*ra, **rap, **frap = NULL;
-	int depth = 0;
-	unsigned int hash;
-	struct raparm_hbucket *rab;
-
-	hash = jhash_2words(dev, ino, 0xfeedbeef) & RAPARM_HASH_MASK;
-	rab = &raparm_hash[hash];
-
-	spin_lock(&rab->pb_lock);
-	for (rap = &rab->pb_head; (ra = *rap); rap = &ra->p_next) {
-		if (ra->p_ino == ino && ra->p_dev == dev)
-			goto found;
-		depth++;
-		if (ra->p_count == 0)
-			frap = rap;
-	}
-	depth = nfsdstats.ra_size;
-	if (!frap) {	
-		spin_unlock(&rab->pb_lock);
-		return NULL;
-	}
-	rap = frap;
-	ra = *frap;
-	ra->p_dev = dev;
-	ra->p_ino = ino;
-	ra->p_set = 0;
-	ra->p_hindex = hash;
-found:
-	if (rap != &rab->pb_head) {
-		*rap = ra->p_next;
-		ra->p_next   = rab->pb_head;
-		rab->pb_head = ra;
-	}
-	ra->p_count++;
-	nfsdstats.ra_depth[depth*10/nfsdstats.ra_size]++;
-	spin_unlock(&rab->pb_lock);
-
-	if (ra->p_set)
-		file->f_ra = ra->p_ra;
-	return ra;
-}
-
-void nfsd_put_raparams(struct file *file, struct raparms *ra)
-{
-	struct raparm_hbucket *rab = &raparm_hash[ra->p_hindex];
-
-	spin_lock(&rab->pb_lock);
-	ra->p_ra = file->f_ra;
-	ra->p_set = 1;
-	ra->p_count--;
-	spin_unlock(&rab->pb_lock);
-}
-
 /*
  * Grab and keep cached pages associated with a file in the svc_rqst
  * so that they can be passed to the network sendmsg/sendpage routines
@@ -2094,63 +2005,3 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
-
-void
-nfsd_racache_shutdown(void)
-{
-	struct raparms *raparm, *last_raparm;
-	unsigned int i;
-
-	dprintk("nfsd: freeing readahead buffers.\n");
-
-	for (i = 0; i < RAPARM_HASH_SIZE; i++) {
-		raparm = raparm_hash[i].pb_head;
-		while(raparm) {
-			last_raparm = raparm;
-			raparm = raparm->p_next;
-			kfree(last_raparm);
-		}
-		raparm_hash[i].pb_head = NULL;
-	}
-}
-/*
- * Initialize readahead param cache
- */
-int
-nfsd_racache_init(int cache_size)
-{
-	int	i;
-	int	j = 0;
-	int	nperbucket;
-	struct raparms **raparm = NULL;
-
-
-	if (raparm_hash[0].pb_head)
-		return 0;
-	nperbucket = DIV_ROUND_UP(cache_size, RAPARM_HASH_SIZE);
-	nperbucket = max(2, nperbucket);
-	cache_size = nperbucket * RAPARM_HASH_SIZE;
-
-	dprintk("nfsd: allocating %d readahead buffers.\n", cache_size);
-
-	for (i = 0; i < RAPARM_HASH_SIZE; i++) {
-		spin_lock_init(&raparm_hash[i].pb_lock);
-
-		raparm = &raparm_hash[i].pb_head;
-		for (j = 0; j < nperbucket; j++) {
-			*raparm = kzalloc(sizeof(struct raparms), GFP_KERNEL);
-			if (!*raparm)
-				goto out_nomem;
-			raparm = &(*raparm)->p_next;
-		}
-		*raparm = NULL;
-	}
-
-	nfsdstats.ra_size = cache_size;
-	return 0;
-
-out_nomem:
-	dprintk("nfsd: kmalloc failed, freeing readahead buffers\n");
-	nfsd_racache_shutdown();
-	return -ENOMEM;
-}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 31fdae34e028..e0f7792165a6 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -40,8 +40,6 @@
 typedef int (*nfsd_filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 
 /* nfsd/vfs.c */
-int		nfsd_racache_init(int);
-void		nfsd_racache_shutdown(void);
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
 __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
@@ -80,7 +78,6 @@ __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
 __be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
-struct raparms;
 __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
 				unsigned long *count);
@@ -118,9 +115,6 @@ __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
 				struct dentry *, int);
 
-struct raparms *nfsd_init_raparms(struct file *file);
-void		nfsd_put_raparams(struct file *file, struct raparms *ra);
-
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
-- 
2.21.0

