Return-Path: <linux-fsdevel+bounces-4715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2FC802A50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 03:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A623C2800F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DACC8C14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MFcbchrv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EW5Bh28G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D97113;
	Sun,  3 Dec 2023 17:41:29 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F9491FE32;
	Mon,  4 Dec 2023 01:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701654088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkymK8+FGpdtWEr2DjC76ilxRN38gXSl47BR9KVwI44=;
	b=MFcbchrvRstXWEZ81rPzAqXkGgUJi35bkxYRCPsga1K7pv0nSMCdl14cU2d1EwhEevTnya
	l6Cl9TUJs8S4YUa9dE8rVcwPv/qnDXdlyM24hvT0J//29UAZJT/4ILSA+kyMvl9HBYRpEw
	qZxRe60y6t/zVe2MAN74YMRT5omf2K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701654088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkymK8+FGpdtWEr2DjC76ilxRN38gXSl47BR9KVwI44=;
	b=EW5Bh28GSnezmpy9IkUsNrpD5/0OiRn9N5qx+7v18x50AvBIrJ21ZGwN04mr/qYPdAKvZ9
	N0HLriH/6KLdQkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F355F1368D;
	Mon,  4 Dec 2023 01:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uwuPKEMubWWUOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Dec 2023 01:41:23 +0000
From: NeilBrown <neilb@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: Don't leave work of closing files to a work queue.
Date: Mon,  4 Dec 2023 12:36:42 +1100
Message-ID: <20231204014042.6754-3-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204014042.6754-1-neilb@suse.de>
References: <20231204014042.6754-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [0.71 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.19)[-0.974];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.71

The work of closing a file can have non-trivial cost.  Doing it in a
separate work queue thread means that cost isn't imposed on the nfsd
threads and an imbalance can be created.

I have evidence from a customer site when nfsd is being asked to modify
many millions of files which causes sufficient memory pressure that some
cache (in XFS I think) gets cleaned earlier than would be ideal.  When
__dput (from the workqueue) calls __dentry_kill, xfs_fs_destroy_inode()
needs to synchronously read back previously cached info from storage.
This slows down the single thread that is making all the final __dput()
calls for all the nfsd threads with the net result that files are added
to the delayed_fput_list faster than they are removed, and the system
eventually runs out of memory.

To avoid this work imbalance that exhausts memory, this patch moves all
work for closing files into the nfsd threads.  This means that when the
work imposes a cost, that cost appears where it would be expected - in
the work of the nfsd thread.

There are two changes to achieve this.

1/ PF_RUNS_TASK_WORK is set and task_work_run() is called, so that the
   final __dput() for any file closed by a given nfsd thread is handled
   by that thread.  This ensures that the number of files that are
   queued for a final close is limited by the number of threads and
   cannot grow without bound.

2/ Files opened for NFSv3 are never explicitly closed by the client and are
  kept open by the server in the "filecache", which responds to memory
  pressure, is garbage collected even when there is no pressure, and
  sometimes closes files when there is particular need such as for
  rename.  These files currently have filp_close() called in a dedicated
  work queue, so their __dput() can have no effect on nfsd threads.

  This patch discards the work queue and instead has each nfsd thread
  call flip_close() on as many as 8 files from the filecache each time
  it acts on a client request (or finds there are no pending client
  requests).  If there are more to be closed, more threads are woken.
  This spreads the work of __dput() over multiple threads and imposes
  any cost on those threads.

  The number 8 is somewhat arbitrary.  It needs to be greater than 1 to
  ensure that files are closed more quickly than they can be added to
  the cache.  It needs to be small enough to limit the per-request
  delays that will be imposed on clients when all threads are busy
  closing files.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 62 ++++++++++++++++++---------------------------
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/nfssvc.c    |  6 +++++
 3 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ee9c923192e0..55268b7362d4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -39,6 +39,7 @@
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
 #include <linux/rhashtable.h>
+#include <linux/task_work.h>
 
 #include "vfs.h"
 #include "nfsd.h"
@@ -61,13 +62,10 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
 
 struct nfsd_fcache_disposal {
-	struct work_struct work;
 	spinlock_t lock;
 	struct list_head freeme;
 };
 
-static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
-
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
 static struct list_lru			nfsd_file_lru;
@@ -421,10 +419,31 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 		spin_lock(&l->lock);
 		list_move_tail(&nf->nf_lru, &l->freeme);
 		spin_unlock(&l->lock);
-		queue_work(nfsd_filecache_wq, &l->work);
+		svc_wake_up(nn->nfsd_serv);
 	}
 }
 
+/**
+ * nfsd_file_dispose_some
+ *
+ */
+void nfsd_file_dispose_some(struct nfsd_net *nn)
+{
+	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
+	LIST_HEAD(dispose);
+	int i;
+
+	if (list_empty(&l->freeme))
+		return;
+	spin_lock(&l->lock);
+	for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
+		list_move(l->freeme.next, &dispose);
+	spin_unlock(&l->lock);
+	if (!list_empty(&l->freeme))
+		svc_wake_up(nn->nfsd_serv);
+	nfsd_file_dispose_list(&dispose);
+}
+
 /**
  * nfsd_file_lru_cb - Examine an entry on the LRU list
  * @item: LRU entry to examine
@@ -635,28 +654,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
 		list_del_init(&nf->nf_lru);
 		nfsd_file_free(nf);
 	}
-	flush_delayed_fput();
-}
-
-/**
- * nfsd_file_delayed_close - close unused nfsd_files
- * @work: dummy
- *
- * Scrape the freeme list for this nfsd_net, and then dispose of them
- * all.
- */
-static void
-nfsd_file_delayed_close(struct work_struct *work)
-{
-	LIST_HEAD(head);
-	struct nfsd_fcache_disposal *l = container_of(work,
-			struct nfsd_fcache_disposal, work);
-
-	spin_lock(&l->lock);
-	list_splice_init(&l->freeme, &head);
-	spin_unlock(&l->lock);
-
-	nfsd_file_dispose_list(&head);
+	/* Flush any delayed fput */
+	task_work_run();
 }
 
 static int
@@ -721,10 +720,6 @@ nfsd_file_cache_init(void)
 		return ret;
 
 	ret = -ENOMEM;
-	nfsd_filecache_wq = alloc_workqueue("nfsd_filecache", 0, 0);
-	if (!nfsd_filecache_wq)
-		goto out;
-
 	nfsd_file_slab = kmem_cache_create("nfsd_file",
 				sizeof(struct nfsd_file), 0, 0, NULL);
 	if (!nfsd_file_slab) {
@@ -739,7 +734,6 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
 
-
 	ret = list_lru_init(&nfsd_file_lru);
 	if (ret) {
 		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
@@ -782,8 +776,6 @@ nfsd_file_cache_init(void)
 	nfsd_file_slab = NULL;
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	destroy_workqueue(nfsd_filecache_wq);
-	nfsd_filecache_wq = NULL;
 	rhltable_destroy(&nfsd_file_rhltable);
 	goto out;
 }
@@ -829,7 +821,6 @@ nfsd_alloc_fcache_disposal(void)
 	l = kmalloc(sizeof(*l), GFP_KERNEL);
 	if (!l)
 		return NULL;
-	INIT_WORK(&l->work, nfsd_file_delayed_close);
 	spin_lock_init(&l->lock);
 	INIT_LIST_HEAD(&l->freeme);
 	return l;
@@ -838,7 +829,6 @@ nfsd_alloc_fcache_disposal(void)
 static void
 nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
-	cancel_work_sync(&l->work);
 	nfsd_file_dispose_list(&l->freeme);
 	kfree(l);
 }
@@ -907,8 +897,6 @@ nfsd_file_cache_shutdown(void)
 	fsnotify_wait_marks_destroyed();
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	destroy_workqueue(nfsd_filecache_wq);
-	nfsd_filecache_wq = NULL;
 	rhltable_destroy(&nfsd_file_rhltable);
 
 	for_each_possible_cpu(i) {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index e54165a3224f..bc8c3363bbdf 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -56,6 +56,7 @@ void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
+void nfsd_file_dispose_some(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c7af1095f6b5..02ea16636b54 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -13,6 +13,7 @@
 #include <linux/fs_struct.h>
 #include <linux/swap.h>
 #include <linux/siphash.h>
+#include <linux/task_work.h>
 
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/svcsock.h>
@@ -949,6 +950,7 @@ nfsd(void *vrqstp)
 	}
 
 	current->fs->umask = 0;
+	current->flags |= PF_RUNS_TASK_WORK;
 
 	atomic_inc(&nfsdstats.th_cnt);
 
@@ -963,6 +965,10 @@ nfsd(void *vrqstp)
 
 		svc_recv(rqstp);
 		validate_process_creds();
+
+		nfsd_file_dispose_some(nn);
+		if (task_work_pending(current))
+			task_work_run();
 	}
 
 	atomic_dec(&nfsdstats.th_cnt);
-- 
2.43.0


