Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6165AFFB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfF3Ny7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:54:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40428 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfF3Ny6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:54:58 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so22702132ioc.7;
        Sun, 30 Jun 2019 06:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFl/12abZsxlHQOvbNs0jA4y0Op6uiHqdyePKLNdn/0=;
        b=pF/Qcfda961qy+PU0GWabe0ozVU9PgK+HBQKkLsyTi2+Zg0n43a+gwtdV4qUq9LWgs
         O3zNnLMmfAoTtctjQjiPn8mXI6slBaCR2btMS9D91c+V/DRWrxUrUy5LuEhsa9JxSmAy
         eBVB3M8ER6oV/7HuCWUdT0BaXAbjsLlu3iq3VzdPAYQxUiye6U057SdFL89ZK0ycPzqF
         4bmw6z91SB0ynB9k480Gr2mM1Z6Lqq/3LcqZ2xJz1yz4zJFbh+mNAbC2Aw5EH+TbldL1
         uBW+1ZrEh0uMWhdJJDsn8DMoOdYvW9ZrOr6zZGVnQiXskOHlDyGf/QENYNdMv3uXFPc5
         IvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFl/12abZsxlHQOvbNs0jA4y0Op6uiHqdyePKLNdn/0=;
        b=TZOY2/+eT96l6c4ztHqpOU0RPcdwh3sHRp0+9yMQ+iCtMSH9njVKkFwS2ja4PsrV7J
         +6xuSelV/a3q4MlOmernKXUp026SZeNr+0l068mdsspYAReazwZhwY5rYRuYkK0kIwSb
         4kc8haQjrIVIwufBFRG0JNm7bA+bFS94ml3mbILG+ja4WrImmleSLD/y49i6cl4AJ7tb
         OG+y29igPNkkIqwFy7YzqKnjniFAvkMSHS2Xl/AMhNmfmyeh1YjjbZegqX1HQoC4nBNX
         2xh21W+Ud5Pp3BV8+HOx9GxDNf3p4SkUCcbng87o6cHmXOHuYiHbTYVtkNwlLLJjbHuj
         MfZw==
X-Gm-Message-State: APjAAAUYhi895nGmyNGFCXdT8s1OU8IHZcUeLD2yp0LHAHlvc6egNoyC
        1gypPpnnB5apabfL7wyx6g==
X-Google-Smtp-Source: APXvYqyFRLCQwAPGkowVDhKMgyIOmc7/njVGvigmGOrwy72PqIivSsr8+hjG6zNFfQYw05WIPz38gw==
X-Received: by 2002:a5d:9613:: with SMTP id w19mr13679400iol.140.1561902896814;
        Sun, 30 Jun 2019 06:54:56 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.54.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:54:56 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/16] nfsd: add a new struct file caching facility to nfsd
Date:   Sun, 30 Jun 2019 09:52:29 -0400
Message-Id: <20190630135240.7490-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-5-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
 <20190630135240.7490-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Currently, NFSv2/3 reads and writes have to open a file, do the read or
write and then close it again for each RPC. This is highly inefficient,
especially when the underlying filesystem has a relatively slow open
routine.

This patch adds a new open file cache to knfsd. Rather than doing an
open for each RPC, the read/write handlers can call into this cache to
see if there is one already there for the correct filehandle and
NFS_MAY_READ/WRITE flags.

If there isn't an entry, then we create a new one and attempt to
perform the open. If there is, then we wait until the entry is fully
instantiated and return it if it is at the end of the wait. If it's
not, then we attempt to take over construction.

Since the main goal is to speed up NFSv2/3 I/O, we don't want to
close these files on last put of these objects. We need to keep them
around for a little while since we never know when the next READ/WRITE
will come in.

Cache entries have a hardcoded 1s timeout, and we have a recurring
workqueue job that walks the cache and purges any entries that have
expired.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Richard Sharpe <richard.sharpe@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/Kconfig     |   1 +
 fs/nfsd/Makefile    |   3 +-
 fs/nfsd/export.c    |  13 +
 fs/nfsd/filecache.c | 885 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h |  60 +++
 fs/nfsd/nfssvc.c    |   9 +-
 fs/nfsd/trace.h     | 140 +++++++
 fs/nfsd/vfs.c       |  65 ++--
 fs/nfsd/vfs.h       |   3 +
 9 files changed, 1155 insertions(+), 24 deletions(-)
 create mode 100644 fs/nfsd/filecache.c
 create mode 100644 fs/nfsd/filecache.h

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index d25f6bbe7006..bff8456220e0 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -3,6 +3,7 @@ config NFSD
 	tristate "NFS server support"
 	depends on INET
 	depends on FILE_LOCKING
+	depends on FSNOTIFY
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index 2bfb58eefad1..6a40b1afe703 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_NFSD)	+= nfsd.o
 nfsd-y			+= trace.o
 
 nfsd-y 			+= nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
-			   export.o auth.o lockd.o nfscache.o nfsxdr.o stats.o
+			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
+			   stats.o filecache.o
 nfsd-$(CONFIG_NFSD_FAULT_INJECTION) += fault_inject.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3)	+= nfs3proc.o nfs3xdr.o
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index baa01956a5b3..052fac64b578 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -22,6 +22,7 @@
 #include "nfsfh.h"
 #include "netns.h"
 #include "pnfs.h"
+#include "filecache.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_EXPORT
 
@@ -232,6 +233,17 @@ static struct cache_head *expkey_alloc(void)
 		return NULL;
 }
 
+static void expkey_flush(void)
+{
+	/*
+	 * Take the nfsd_mutex here to ensure that the file cache is not
+	 * destroyed while we're in the middle of flushing.
+	 */
+	mutex_lock(&nfsd_mutex);
+	nfsd_file_cache_purge();
+	mutex_unlock(&nfsd_mutex);
+}
+
 static const struct cache_detail svc_expkey_cache_template = {
 	.owner		= THIS_MODULE,
 	.hash_size	= EXPKEY_HASHMAX,
@@ -244,6 +256,7 @@ static const struct cache_detail svc_expkey_cache_template = {
 	.init		= expkey_init,
 	.update       	= expkey_update,
 	.alloc		= expkey_alloc,
+	.flush		= expkey_flush,
 };
 
 static int
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
new file mode 100644
index 000000000000..4759fdc8a07e
--- /dev/null
+++ b/fs/nfsd/filecache.c
@@ -0,0 +1,885 @@
+/*
+ * Open file cache.
+ *
+ * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
+ */
+
+#include <linux/hash.h>
+#include <linux/slab.h>
+#include <linux/hash.h>
+#include <linux/file.h>
+#include <linux/sched.h>
+#include <linux/list_lru.h>
+#include <linux/fsnotify_backend.h>
+#include <linux/fsnotify.h>
+#include <linux/seq_file.h>
+
+#include "vfs.h"
+#include "nfsd.h"
+#include "nfsfh.h"
+#include "filecache.h"
+#include "trace.h"
+
+#define NFSDDBG_FACILITY	NFSDDBG_FH
+
+/* FIXME: dynamically size this for the machine somehow? */
+#define NFSD_FILE_HASH_BITS                   12
+#define NFSD_FILE_HASH_SIZE                  (1 << NFSD_FILE_HASH_BITS)
+#define NFSD_LAUNDRETTE_DELAY		     (2 * HZ)
+
+#define NFSD_FILE_LRU_RESCAN		     (0)
+#define NFSD_FILE_SHUTDOWN		     (1)
+#define NFSD_FILE_LRU_THRESHOLD		     (4096UL)
+#define NFSD_FILE_LRU_LIMIT		     (NFSD_FILE_LRU_THRESHOLD << 2)
+
+/* We only care about NFSD_MAY_READ/WRITE for this cache */
+#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
+
+struct nfsd_fcache_bucket {
+	struct hlist_head	nfb_head;
+	spinlock_t		nfb_lock;
+	unsigned int		nfb_count;
+	unsigned int		nfb_maxcount;
+};
+
+static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
+
+static struct kmem_cache		*nfsd_file_slab;
+static struct kmem_cache		*nfsd_file_mark_slab;
+static struct nfsd_fcache_bucket	*nfsd_file_hashtbl;
+static struct list_lru			nfsd_file_lru;
+static long				nfsd_file_lru_flags;
+static struct fsnotify_group		*nfsd_file_fsnotify_group;
+static atomic_long_t			nfsd_filecache_count;
+static struct delayed_work		nfsd_filecache_laundrette;
+
+enum nfsd_file_laundrette_ctl {
+	NFSD_FILE_LAUNDRETTE_NOFLUSH = 0,
+	NFSD_FILE_LAUNDRETTE_MAY_FLUSH
+};
+
+static void
+nfsd_file_schedule_laundrette(enum nfsd_file_laundrette_ctl ctl)
+{
+	long count = atomic_long_read(&nfsd_filecache_count);
+
+	if (count == 0 || test_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags))
+		return;
+
+	/* Be more aggressive about scanning if over the threshold */
+	if (count > NFSD_FILE_LRU_THRESHOLD)
+		mod_delayed_work(system_wq, &nfsd_filecache_laundrette, 0);
+	else
+		schedule_delayed_work(&nfsd_filecache_laundrette, NFSD_LAUNDRETTE_DELAY);
+
+	if (ctl == NFSD_FILE_LAUNDRETTE_NOFLUSH)
+		return;
+
+	/* ...and don't delay flushing if we're out of control */
+	if (count >= NFSD_FILE_LRU_LIMIT)
+		flush_delayed_work(&nfsd_filecache_laundrette);
+}
+
+static void
+nfsd_file_slab_free(struct rcu_head *rcu)
+{
+	struct nfsd_file *nf = container_of(rcu, struct nfsd_file, nf_rcu);
+
+	put_cred(nf->nf_cred);
+	kmem_cache_free(nfsd_file_slab, nf);
+}
+
+static void
+nfsd_file_mark_free(struct fsnotify_mark *mark)
+{
+	struct nfsd_file_mark *nfm = container_of(mark, struct nfsd_file_mark,
+						  nfm_mark);
+
+	kmem_cache_free(nfsd_file_mark_slab, nfm);
+}
+
+static struct nfsd_file_mark *
+nfsd_file_mark_get(struct nfsd_file_mark *nfm)
+{
+	if (!atomic_inc_not_zero(&nfm->nfm_ref))
+		return NULL;
+	return nfm;
+}
+
+static void
+nfsd_file_mark_put(struct nfsd_file_mark *nfm)
+{
+	if (atomic_dec_and_test(&nfm->nfm_ref)) {
+
+		fsnotify_destroy_mark(&nfm->nfm_mark, nfsd_file_fsnotify_group);
+		fsnotify_put_mark(&nfm->nfm_mark);
+	}
+}
+
+static struct nfsd_file_mark *
+nfsd_file_mark_find_or_create(struct nfsd_file *nf)
+{
+	int			err;
+	struct fsnotify_mark	*mark;
+	struct nfsd_file_mark	*nfm = NULL, *new;
+	struct inode *inode = nf->nf_inode;
+
+	do {
+		mutex_lock(&nfsd_file_fsnotify_group->mark_mutex);
+		mark = fsnotify_find_mark(&inode->i_fsnotify_marks,
+				nfsd_file_fsnotify_group);
+		if (mark) {
+			nfm = nfsd_file_mark_get(container_of(mark,
+						 struct nfsd_file_mark,
+						 nfm_mark));
+			mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
+			fsnotify_put_mark(mark);
+			if (likely(nfm))
+				break;
+		} else
+			mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
+
+		/* allocate a new nfm */
+		new = kmem_cache_alloc(nfsd_file_mark_slab, GFP_KERNEL);
+		if (!new)
+			return NULL;
+		fsnotify_init_mark(&new->nfm_mark, nfsd_file_fsnotify_group);
+		new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
+		atomic_set(&new->nfm_ref, 1);
+
+		err = fsnotify_add_inode_mark(&new->nfm_mark, inode, 0);
+
+		/*
+		 * If the add was successful, then return the object.
+		 * Otherwise, we need to put the reference we hold on the
+		 * nfm_mark. The fsnotify code will take a reference and put
+		 * it on failure, so we can't just free it directly. It's also
+		 * not safe to call fsnotify_destroy_mark on it as the
+		 * mark->group will be NULL. Thus, we can't let the nfm_ref
+		 * counter drive the destruction at this point.
+		 */
+		if (likely(!err))
+			nfm = new;
+		else
+			fsnotify_put_mark(&new->nfm_mark);
+	} while (unlikely(err == -EEXIST));
+
+	return nfm;
+}
+
+static struct nfsd_file *
+nfsd_file_alloc(struct inode *inode, unsigned int may, unsigned int hashval)
+{
+	struct nfsd_file *nf;
+
+	nf = kmem_cache_alloc(nfsd_file_slab, GFP_KERNEL);
+	if (nf) {
+		INIT_HLIST_NODE(&nf->nf_node);
+		INIT_LIST_HEAD(&nf->nf_lru);
+		nf->nf_file = NULL;
+		nf->nf_cred = get_current_cred();
+		nf->nf_flags = 0;
+		nf->nf_inode = inode;
+		nf->nf_hashval = hashval;
+		atomic_set(&nf->nf_ref, 1);
+		nf->nf_may = may & NFSD_FILE_MAY_MASK;
+		if (may & NFSD_MAY_NOT_BREAK_LEASE) {
+			if (may & NFSD_MAY_WRITE)
+				__set_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags);
+			if (may & NFSD_MAY_READ)
+				__set_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
+		}
+		nf->nf_mark = NULL;
+		trace_nfsd_file_alloc(nf);
+	}
+	return nf;
+}
+
+static bool
+nfsd_file_free(struct nfsd_file *nf)
+{
+	bool flush = false;
+
+	trace_nfsd_file_put_final(nf);
+	if (nf->nf_mark)
+		nfsd_file_mark_put(nf->nf_mark);
+	if (nf->nf_file) {
+		get_file(nf->nf_file);
+		filp_close(nf->nf_file, NULL);
+		fput(nf->nf_file);
+		flush = true;
+	}
+	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
+	return flush;
+}
+
+static void
+nfsd_file_do_unhash(struct nfsd_file *nf)
+{
+	lockdep_assert_held(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
+
+	trace_nfsd_file_unhash(nf);
+
+	--nfsd_file_hashtbl[nf->nf_hashval].nfb_count;
+	hlist_del_rcu(&nf->nf_node);
+	if (!list_empty(&nf->nf_lru))
+		list_lru_del(&nfsd_file_lru, &nf->nf_lru);
+	atomic_long_dec(&nfsd_filecache_count);
+}
+
+static bool
+nfsd_file_unhash(struct nfsd_file *nf)
+{
+	if (test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+		nfsd_file_do_unhash(nf);
+		return true;
+	}
+	return false;
+}
+
+/*
+ * Return true if the file was unhashed.
+ */
+static bool
+nfsd_file_unhash_and_release_locked(struct nfsd_file *nf, struct list_head *dispose)
+{
+	lockdep_assert_held(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
+
+	trace_nfsd_file_unhash_and_release_locked(nf);
+	if (!nfsd_file_unhash(nf))
+		return false;
+	/* keep final reference for nfsd_file_lru_dispose */
+	if (atomic_add_unless(&nf->nf_ref, -1, 1))
+		return true;
+
+	list_add(&nf->nf_lru, dispose);
+	return true;
+}
+
+static int
+nfsd_file_put_noref(struct nfsd_file *nf)
+{
+	int count;
+	trace_nfsd_file_put(nf);
+
+	count = atomic_dec_return(&nf->nf_ref);
+	if (!count) {
+		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
+		nfsd_file_free(nf);
+	}
+	return count;
+}
+
+void
+nfsd_file_put(struct nfsd_file *nf)
+{
+	bool is_hashed = test_bit(NFSD_FILE_HASHED, &nf->nf_flags) != 0;
+
+	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
+	if (nfsd_file_put_noref(nf) == 1 && is_hashed)
+		nfsd_file_schedule_laundrette(NFSD_FILE_LAUNDRETTE_MAY_FLUSH);
+}
+
+struct nfsd_file *
+nfsd_file_get(struct nfsd_file *nf)
+{
+	if (likely(atomic_inc_not_zero(&nf->nf_ref)))
+		return nf;
+	return NULL;
+}
+
+static void
+nfsd_file_dispose_list(struct list_head *dispose)
+{
+	struct nfsd_file *nf;
+
+	while(!list_empty(dispose)) {
+		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
+		list_del(&nf->nf_lru);
+		nfsd_file_put_noref(nf);
+	}
+}
+
+static void
+nfsd_file_dispose_list_sync(struct list_head *dispose)
+{
+	bool flush = false;
+	struct nfsd_file *nf;
+
+	while(!list_empty(dispose)) {
+		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
+		list_del(&nf->nf_lru);
+		if (!atomic_dec_and_test(&nf->nf_ref))
+			continue;
+		if (nfsd_file_free(nf))
+			flush = true;
+	}
+	if (flush)
+		flush_delayed_fput();
+}
+
+/*
+ * Note this can deadlock with nfsd_file_cache_purge.
+ */
+static enum lru_status
+nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
+		 spinlock_t *lock, void *arg)
+	__releases(lock)
+	__acquires(lock)
+{
+	struct list_head *head = arg;
+	struct nfsd_file *nf = list_entry(item, struct nfsd_file, nf_lru);
+
+	/*
+	 * Do a lockless refcount check. The hashtable holds one reference, so
+	 * we look to see if anything else has a reference, or if any have
+	 * been put since the shrinker last ran. Those don't get unhashed and
+	 * released.
+	 *
+	 * Note that in the put path, we set the flag and then decrement the
+	 * counter. Here we check the counter and then test and clear the flag.
+	 * That order is deliberate to ensure that we can do this locklessly.
+	 */
+	if (atomic_read(&nf->nf_ref) > 1)
+		goto out_skip;
+	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags))
+		goto out_rescan;;
+
+	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags))
+		goto out_skip;
+
+	list_lru_isolate_move(lru, &nf->nf_lru, head);
+	return LRU_REMOVED;
+out_rescan:
+	set_bit(NFSD_FILE_LRU_RESCAN, &nfsd_file_lru_flags);
+out_skip:
+	return LRU_SKIP;
+}
+
+static void
+nfsd_file_lru_dispose(struct list_head *head)
+{
+	while(!list_empty(head)) {
+		struct nfsd_file *nf = list_first_entry(head,
+				struct nfsd_file, nf_lru);
+		list_del_init(&nf->nf_lru);
+		spin_lock(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
+		nfsd_file_do_unhash(nf);
+		spin_unlock(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
+		nfsd_file_put_noref(nf);
+	}
+}
+
+static unsigned long
+nfsd_file_lru_count(struct shrinker *s, struct shrink_control *sc)
+{
+	return list_lru_count(&nfsd_file_lru);
+}
+
+static unsigned long
+nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
+{
+	LIST_HEAD(head);
+	unsigned long ret;
+
+	ret = list_lru_shrink_walk(&nfsd_file_lru, sc, nfsd_file_lru_cb, &head);
+	nfsd_file_lru_dispose(&head);
+	return ret;
+}
+
+static struct shrinker	nfsd_file_shrinker = {
+	.scan_objects = nfsd_file_lru_scan,
+	.count_objects = nfsd_file_lru_count,
+	.seeks = 1,
+};
+
+static void
+__nfsd_file_close_inode(struct inode *inode, unsigned int hashval,
+			struct list_head *dispose)
+{
+	struct nfsd_file	*nf;
+	struct hlist_node	*tmp;
+
+	spin_lock(&nfsd_file_hashtbl[hashval].nfb_lock);
+	hlist_for_each_entry_safe(nf, tmp, &nfsd_file_hashtbl[hashval].nfb_head, nf_node) {
+		if (inode == nf->nf_inode)
+			nfsd_file_unhash_and_release_locked(nf, dispose);
+	}
+	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
+}
+
+/**
+ * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
+ * @inode: inode of the file to attempt to remove
+ *
+ * Walk the whole hash bucket, looking for any files that correspond to "inode".
+ * If any do, then unhash them and put the hashtable reference to them and
+ * destroy any that had their last reference put. Also ensure that any of the
+ * fputs also have their final __fput done as well.
+ */
+void
+nfsd_file_close_inode_sync(struct inode *inode)
+{
+	unsigned int		hashval = (unsigned int)hash_long(inode->i_ino,
+						NFSD_FILE_HASH_BITS);
+	LIST_HEAD(dispose);
+
+	__nfsd_file_close_inode(inode, hashval, &dispose);
+	trace_nfsd_file_close_inode_sync(inode, hashval, !list_empty(&dispose));
+	nfsd_file_dispose_list_sync(&dispose);
+}
+
+/**
+ * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
+ * @inode: inode of the file to attempt to remove
+ *
+ * Walk the whole hash bucket, looking for any files that correspond to "inode".
+ * If any do, then unhash them and put the hashtable reference to them and
+ * destroy any that had their last reference put.
+ */
+static void
+nfsd_file_close_inode(struct inode *inode)
+{
+	unsigned int		hashval = (unsigned int)hash_long(inode->i_ino,
+						NFSD_FILE_HASH_BITS);
+	LIST_HEAD(dispose);
+
+	__nfsd_file_close_inode(inode, hashval, &dispose);
+	trace_nfsd_file_close_inode(inode, hashval, !list_empty(&dispose));
+	nfsd_file_dispose_list(&dispose);
+}
+
+/**
+ * nfsd_file_delayed_close - close unused nfsd_files
+ * @work: dummy
+ *
+ * Walk the LRU list and close any entries that have not been used since
+ * the last scan.
+ *
+ * Note this can deadlock with nfsd_file_cache_purge.
+ */
+static void
+nfsd_file_delayed_close(struct work_struct *work)
+{
+	LIST_HEAD(head);
+
+	list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb, &head, LONG_MAX);
+
+	if (test_and_clear_bit(NFSD_FILE_LRU_RESCAN, &nfsd_file_lru_flags))
+		nfsd_file_schedule_laundrette(NFSD_FILE_LAUNDRETTE_NOFLUSH);
+
+	if (!list_empty(&head)) {
+		nfsd_file_lru_dispose(&head);
+		flush_delayed_fput();
+	}
+}
+
+static int
+nfsd_file_lease_notifier_call(struct notifier_block *nb, unsigned long arg,
+			    void *data)
+{
+	struct file_lock *fl = data;
+
+	/* Only close files for F_SETLEASE leases */
+	if (fl->fl_flags & FL_LEASE)
+		nfsd_file_close_inode_sync(file_inode(fl->fl_file));
+	return 0;
+}
+
+static struct notifier_block nfsd_file_lease_notifier = {
+	.notifier_call = nfsd_file_lease_notifier_call,
+};
+
+static int
+nfsd_file_fsnotify_handle_event(struct fsnotify_group *group,
+				struct inode *inode,
+				u32 mask, const void *data, int data_type,
+				const struct qstr *file_name, u32 cookie,
+				struct fsnotify_iter_info *iter_info)
+{
+	trace_nfsd_file_fsnotify_handle_event(inode, mask);
+
+	/* Should be no marks on non-regular files */
+	if (!S_ISREG(inode->i_mode)) {
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	/* don't close files if this was not the last link */
+	if (mask & FS_ATTRIB) {
+		if (inode->i_nlink)
+			return 0;
+	}
+
+	nfsd_file_close_inode(inode);
+	return 0;
+}
+
+
+static const struct fsnotify_ops nfsd_file_fsnotify_ops = {
+	.handle_event = nfsd_file_fsnotify_handle_event,
+	.free_mark = nfsd_file_mark_free,
+};
+
+int
+nfsd_file_cache_init(void)
+{
+	int		ret = -ENOMEM;
+	unsigned int	i;
+
+	clear_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags);
+
+	if (nfsd_file_hashtbl)
+		return 0;
+
+	nfsd_file_hashtbl = kcalloc(NFSD_FILE_HASH_SIZE,
+				sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
+	if (!nfsd_file_hashtbl) {
+		pr_err("nfsd: unable to allocate nfsd_file_hashtbl\n");
+		goto out_err;
+	}
+
+	nfsd_file_slab = kmem_cache_create("nfsd_file",
+				sizeof(struct nfsd_file), 0, 0, NULL);
+	if (!nfsd_file_slab) {
+		pr_err("nfsd: unable to create nfsd_file_slab\n");
+		goto out_err;
+	}
+
+	nfsd_file_mark_slab = kmem_cache_create("nfsd_file_mark",
+					sizeof(struct nfsd_file_mark), 0, 0, NULL);
+	if (!nfsd_file_mark_slab) {
+		pr_err("nfsd: unable to create nfsd_file_mark_slab\n");
+		goto out_err;
+	}
+
+
+	ret = list_lru_init(&nfsd_file_lru);
+	if (ret) {
+		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
+		goto out_err;
+	}
+
+	ret = register_shrinker(&nfsd_file_shrinker);
+	if (ret) {
+		pr_err("nfsd: failed to register nfsd_file_shrinker: %d\n", ret);
+		goto out_lru;
+	}
+
+	ret = lease_register_notifier(&nfsd_file_lease_notifier);
+	if (ret) {
+		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
+		goto out_shrinker;
+	}
+
+	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops);
+	if (IS_ERR(nfsd_file_fsnotify_group)) {
+		pr_err("nfsd: unable to create fsnotify group: %ld\n",
+			PTR_ERR(nfsd_file_fsnotify_group));
+		nfsd_file_fsnotify_group = NULL;
+		goto out_notifier;
+	}
+
+	for (i = 0; i < NFSD_FILE_HASH_SIZE; i++) {
+		INIT_HLIST_HEAD(&nfsd_file_hashtbl[i].nfb_head);
+		spin_lock_init(&nfsd_file_hashtbl[i].nfb_lock);
+	}
+
+	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_delayed_close);
+out:
+	return ret;
+out_notifier:
+	lease_unregister_notifier(&nfsd_file_lease_notifier);
+out_shrinker:
+	unregister_shrinker(&nfsd_file_shrinker);
+out_lru:
+	list_lru_destroy(&nfsd_file_lru);
+out_err:
+	kmem_cache_destroy(nfsd_file_slab);
+	nfsd_file_slab = NULL;
+	kmem_cache_destroy(nfsd_file_mark_slab);
+	nfsd_file_mark_slab = NULL;
+	kfree(nfsd_file_hashtbl);
+	nfsd_file_hashtbl = NULL;
+	goto out;
+}
+
+/*
+ * Note this can deadlock with nfsd_file_lru_cb.
+ */
+void
+nfsd_file_cache_purge(void)
+{
+	unsigned int		i;
+	struct nfsd_file	*nf;
+	LIST_HEAD(dispose);
+	bool del;
+
+	if (!nfsd_file_hashtbl)
+		return;
+
+	for (i = 0; i < NFSD_FILE_HASH_SIZE; i++) {
+		spin_lock(&nfsd_file_hashtbl[i].nfb_lock);
+		while(!hlist_empty(&nfsd_file_hashtbl[i].nfb_head)) {
+			nf = hlist_entry(nfsd_file_hashtbl[i].nfb_head.first,
+					 struct nfsd_file, nf_node);
+			del = nfsd_file_unhash_and_release_locked(nf, &dispose);
+
+			/*
+			 * Deadlock detected! Something marked this entry as
+			 * unhased, but hasn't removed it from the hash list.
+			 */
+			WARN_ON_ONCE(!del);
+		}
+		spin_unlock(&nfsd_file_hashtbl[i].nfb_lock);
+		nfsd_file_dispose_list(&dispose);
+	}
+}
+
+void
+nfsd_file_cache_shutdown(void)
+{
+	LIST_HEAD(dispose);
+
+	set_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags);
+
+	lease_unregister_notifier(&nfsd_file_lease_notifier);
+	unregister_shrinker(&nfsd_file_shrinker);
+	/*
+	 * make sure all callers of nfsd_file_lru_cb are done before
+	 * calling nfsd_file_cache_purge
+	 */
+	cancel_delayed_work_sync(&nfsd_filecache_laundrette);
+	nfsd_file_cache_purge();
+	list_lru_destroy(&nfsd_file_lru);
+	rcu_barrier();
+	fsnotify_put_group(nfsd_file_fsnotify_group);
+	nfsd_file_fsnotify_group = NULL;
+	kmem_cache_destroy(nfsd_file_slab);
+	nfsd_file_slab = NULL;
+	fsnotify_wait_marks_destroyed();
+	kmem_cache_destroy(nfsd_file_mark_slab);
+	nfsd_file_mark_slab = NULL;
+	kfree(nfsd_file_hashtbl);
+	nfsd_file_hashtbl = NULL;
+}
+
+static bool
+nfsd_match_cred(const struct cred *c1, const struct cred *c2)
+{
+	int i;
+
+	if (!uid_eq(c1->fsuid, c2->fsuid))
+		return false;
+	if (!gid_eq(c1->fsgid, c2->fsgid))
+		return false;
+	if (c1->group_info == NULL || c2->group_info == NULL)
+		return c1->group_info == c2->group_info;
+	if (c1->group_info->ngroups != c2->group_info->ngroups)
+		return false;
+	for (i = 0; i < c1->group_info->ngroups; i++) {
+		if (!gid_eq(c1->group_info->gid[i], c2->group_info->gid[i]))
+			return false;
+	}
+	return true;
+}
+
+static struct nfsd_file *
+nfsd_file_find_locked(struct inode *inode, unsigned int may_flags,
+			unsigned int hashval)
+{
+	struct nfsd_file *nf;
+	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
+
+	hlist_for_each_entry_rcu(nf, &nfsd_file_hashtbl[hashval].nfb_head,
+				 nf_node) {
+		if ((need & nf->nf_may) != need)
+			continue;
+		if (nf->nf_inode != inode)
+			continue;
+		if (!nfsd_match_cred(nf->nf_cred, current_cred()))
+			continue;
+		if (nfsd_file_get(nf) != NULL)
+			return nf;
+	}
+	return NULL;
+}
+
+/**
+ * nfsd_file_is_cached - are there any cached open files for this fh?
+ * @inode: inode of the file to check
+ *
+ * Scan the hashtable for open files that match this fh. Returns true if there
+ * are any, and false if not.
+ */
+bool
+nfsd_file_is_cached(struct inode *inode)
+{
+	bool			ret = false;
+	struct nfsd_file	*nf;
+	unsigned int		hashval;
+
+        hashval = (unsigned int)hash_long(inode->i_ino, NFSD_FILE_HASH_BITS);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(nf, &nfsd_file_hashtbl[hashval].nfb_head,
+				 nf_node) {
+		if (inode == nf->nf_inode) {
+			ret = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	trace_nfsd_file_is_cached(inode, hashval, (int)ret);
+	return ret;
+}
+
+__be32
+nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  unsigned int may_flags, struct nfsd_file **pnf)
+{
+	__be32	status;
+	struct nfsd_file *nf, *new;
+	struct inode *inode;
+	unsigned int hashval;
+
+	/* FIXME: skip this if fh_dentry is already set? */
+	status = fh_verify(rqstp, fhp, S_IFREG,
+				may_flags|NFSD_MAY_OWNER_OVERRIDE);
+	if (status != nfs_ok)
+		return status;
+
+	inode = d_inode(fhp->fh_dentry);
+	hashval = (unsigned int)hash_long(inode->i_ino, NFSD_FILE_HASH_BITS);
+retry:
+	rcu_read_lock();
+	nf = nfsd_file_find_locked(inode, may_flags, hashval);
+	rcu_read_unlock();
+	if (nf)
+		goto wait_for_construction;
+
+	new = nfsd_file_alloc(inode, may_flags, hashval);
+	if (!new) {
+		trace_nfsd_file_acquire(rqstp, hashval, inode, may_flags,
+					NULL, nfserr_jukebox);
+		return nfserr_jukebox;
+	}
+
+	spin_lock(&nfsd_file_hashtbl[hashval].nfb_lock);
+	nf = nfsd_file_find_locked(inode, may_flags, hashval);
+	if (nf == NULL)
+		goto open_file;
+	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
+	nfsd_file_slab_free(&new->nf_rcu);
+
+wait_for_construction:
+	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
+
+	/* Did construction of this file fail? */
+	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+		nfsd_file_put_noref(nf);
+		goto retry;
+	}
+
+	this_cpu_inc(nfsd_file_cache_hits);
+
+	if (!(may_flags & NFSD_MAY_NOT_BREAK_LEASE)) {
+		bool write = (may_flags & NFSD_MAY_WRITE);
+
+		if (test_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags) ||
+		    (test_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags) && write)) {
+			status = nfserrno(nfsd_open_break_lease(
+					file_inode(nf->nf_file), may_flags));
+			if (status == nfs_ok) {
+				clear_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
+				if (write)
+					clear_bit(NFSD_FILE_BREAK_WRITE,
+						  &nf->nf_flags);
+			}
+		}
+	}
+out:
+	if (status == nfs_ok) {
+		*pnf = nf;
+	} else {
+		nfsd_file_put(nf);
+		nf = NULL;
+	}
+
+	trace_nfsd_file_acquire(rqstp, hashval, inode, may_flags, nf, status);
+	return status;
+open_file:
+	nf = new;
+	/* Take reference for the hashtable */
+	atomic_inc(&nf->nf_ref);
+	__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
+	__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
+	list_lru_add(&nfsd_file_lru, &nf->nf_lru);
+	hlist_add_head_rcu(&nf->nf_node, &nfsd_file_hashtbl[hashval].nfb_head);
+	++nfsd_file_hashtbl[hashval].nfb_count;
+	nfsd_file_hashtbl[hashval].nfb_maxcount = max(nfsd_file_hashtbl[hashval].nfb_maxcount,
+			nfsd_file_hashtbl[hashval].nfb_count);
+	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
+	atomic_long_inc(&nfsd_filecache_count);
+
+	nf->nf_mark = nfsd_file_mark_find_or_create(nf);
+	if (nf->nf_mark)
+		status = nfsd_open_verified(rqstp, fhp, S_IFREG,
+				may_flags, &nf->nf_file);
+	else
+		status = nfserr_jukebox;
+	/*
+	 * If construction failed, or we raced with a call to unlink()
+	 * then unhash.
+	 */
+	if (status != nfs_ok || inode->i_nlink == 0) {
+		bool do_free;
+		spin_lock(&nfsd_file_hashtbl[hashval].nfb_lock);
+		do_free = nfsd_file_unhash(nf);
+		spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
+		if (do_free)
+			nfsd_file_put_noref(nf);
+	}
+	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
+	smp_mb__after_atomic();
+	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
+	goto out;
+}
+
+/*
+ * Note that fields may be added, removed or reordered in the future. Programs
+ * scraping this file for info should test the labels to ensure they're
+ * getting the correct field.
+ */
+static int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
+{
+	unsigned int i, count = 0, longest = 0;
+	unsigned long hits = 0;
+
+	/*
+	 * No need for spinlocks here since we're not terribly interested in
+	 * accuracy. We do take the nfsd_mutex simply to ensure that we
+	 * don't end up racing with server shutdown
+	 */
+	mutex_lock(&nfsd_mutex);
+	if (nfsd_file_hashtbl) {
+		for (i = 0; i < NFSD_FILE_HASH_SIZE; i++) {
+			count += nfsd_file_hashtbl[i].nfb_count;
+			longest = max(longest, nfsd_file_hashtbl[i].nfb_count);
+		}
+	}
+	mutex_unlock(&nfsd_mutex);
+
+	for_each_possible_cpu(i)
+		hits += per_cpu(nfsd_file_cache_hits, i);
+
+	seq_printf(m, "total entries: %u\n", count);
+	seq_printf(m, "longest chain: %u\n", longest);
+	seq_printf(m, "cache hits:    %lu\n", hits);
+	return 0;
+}
+
+int nfsd_file_cache_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, nfsd_file_cache_stats_show, NULL);
+}
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
new file mode 100644
index 000000000000..0c0c67166b87
--- /dev/null
+++ b/fs/nfsd/filecache.h
@@ -0,0 +1,60 @@
+#ifndef _FS_NFSD_FILECACHE_H
+#define _FS_NFSD_FILECACHE_H
+
+#include <linux/fsnotify_backend.h>
+
+/*
+ * This is the fsnotify_mark container that nfsd attaches to the files that it
+ * is holding open. Note that we have a separate refcount here aside from the
+ * one in the fsnotify_mark. We only want a single fsnotify_mark attached to
+ * the inode, and for each nfsd_file to hold a reference to it.
+ *
+ * The fsnotify_mark is itself refcounted, but that's not sufficient to tell us
+ * how to put that reference. If there are still outstanding nfsd_files that
+ * reference the mark, then we would want to call fsnotify_put_mark on it.
+ * If there were not, then we'd need to call fsnotify_destroy_mark. Since we
+ * can't really tell the difference, we use the nfm_mark to keep track of how
+ * many nfsd_files hold references to the mark. When that counter goes to zero
+ * then we know to call fsnotify_destroy_mark on it.
+ */
+struct nfsd_file_mark {
+	struct fsnotify_mark	nfm_mark;
+	atomic_t		nfm_ref;
+};
+
+/*
+ * A representation of a file that has been opened by knfsd. These are hashed
+ * in the hashtable by inode pointer value. Note that this object doesn't
+ * hold a reference to the inode by itself, so the nf_inode pointer should
+ * never be dereferenced, only used for comparison.
+ */
+struct nfsd_file {
+	struct hlist_node	nf_node;
+	struct list_head	nf_lru;
+	struct rcu_head		nf_rcu;
+	struct file		*nf_file;
+	const struct cred	*nf_cred;
+#define NFSD_FILE_HASHED	(0)
+#define NFSD_FILE_PENDING	(1)
+#define NFSD_FILE_BREAK_READ	(2)
+#define NFSD_FILE_BREAK_WRITE	(3)
+#define NFSD_FILE_REFERENCED	(4)
+	unsigned long		nf_flags;
+	struct inode		*nf_inode;
+	unsigned int		nf_hashval;
+	atomic_t		nf_ref;
+	unsigned char		nf_may;
+	struct nfsd_file_mark	*nf_mark;
+};
+
+int nfsd_file_cache_init(void);
+void nfsd_file_cache_purge(void);
+void nfsd_file_cache_shutdown(void);
+void nfsd_file_put(struct nfsd_file *nf);
+struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
+void nfsd_file_close_inode_sync(struct inode *inode);
+bool nfsd_file_is_cached(struct inode *inode);
+__be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  unsigned int may_flags, struct nfsd_file **nfp);
+int	nfsd_file_cache_stats_open(struct inode *, struct file *);
+#endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 18d94ea984ba..a6b1eab7b722 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -27,6 +27,7 @@
 #include "cache.h"
 #include "vfs.h"
 #include "netns.h"
+#include "filecache.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
@@ -313,6 +314,9 @@ static int nfsd_startup_generic(int nrservs)
 	if (nfsd_users++)
 		return 0;
 
+	ret = nfsd_file_cache_init();
+	if (ret)
+		goto dec_users;
 	/*
 	 * Readahead param cache - will no-op if it already exists.
 	 * (Note therefore results will be suboptimal if number of
@@ -320,7 +324,7 @@ static int nfsd_startup_generic(int nrservs)
 	 */
 	ret = nfsd_racache_init(2*nrservs);
 	if (ret)
-		goto dec_users;
+		goto out_file_cache;
 
 	ret = nfs4_state_start();
 	if (ret)
@@ -329,6 +333,8 @@ static int nfsd_startup_generic(int nrservs)
 
 out_racache:
 	nfsd_racache_shutdown();
+out_file_cache:
+	nfsd_file_cache_shutdown();
 dec_users:
 	nfsd_users--;
 	return ret;
@@ -340,6 +346,7 @@ static void nfsd_shutdown_generic(void)
 		return;
 
 	nfs4_state_shutdown();
+	nfsd_file_cache_shutdown();
 	nfsd_racache_shutdown();
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 80933e4334d8..ffc78a0e28b2 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -126,6 +126,8 @@ DEFINE_NFSD_ERR_EVENT(read_err);
 DEFINE_NFSD_ERR_EVENT(write_err);
 
 #include "state.h"
+#include "filecache.h"
+#include "vfs.h"
 
 DECLARE_EVENT_CLASS(nfsd_stateid_class,
 	TP_PROTO(stateid_t *stp),
@@ -164,6 +166,144 @@ DEFINE_STATEID_EVENT(layout_recall_done);
 DEFINE_STATEID_EVENT(layout_recall_fail);
 DEFINE_STATEID_EVENT(layout_recall_release);
 
+#define show_nf_flags(val)						\
+	__print_flags(val, "|",						\
+		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
+		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
+		{ 1 << NFSD_FILE_BREAK_READ,	"BREAK_READ" },		\
+		{ 1 << NFSD_FILE_BREAK_WRITE,	"BREAK_WRITE" },	\
+		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
+
+/* FIXME: This should probably be fleshed out in the future. */
+#define show_nf_may(val)						\
+	__print_flags(val, "|",						\
+		{ NFSD_MAY_READ,		"READ" },		\
+		{ NFSD_MAY_WRITE,		"WRITE" },		\
+		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" })
+
+DECLARE_EVENT_CLASS(nfsd_file_class,
+	TP_PROTO(struct nfsd_file *nf),
+	TP_ARGS(nf),
+	TP_STRUCT__entry(
+		__field(unsigned int, nf_hashval)
+		__field(void *, nf_inode)
+		__field(int, nf_ref)
+		__field(unsigned long, nf_flags)
+		__field(unsigned char, nf_may)
+		__field(struct file *, nf_file)
+	),
+	TP_fast_assign(
+		__entry->nf_hashval = nf->nf_hashval;
+		__entry->nf_inode = nf->nf_inode;
+		__entry->nf_ref = atomic_read(&nf->nf_ref);
+		__entry->nf_flags = nf->nf_flags;
+		__entry->nf_may = nf->nf_may;
+		__entry->nf_file = nf->nf_file;
+	),
+	TP_printk("hash=0x%x inode=0x%p ref=%d flags=%s may=%s file=%p",
+		__entry->nf_hashval,
+		__entry->nf_inode,
+		__entry->nf_ref,
+		show_nf_flags(__entry->nf_flags),
+		show_nf_may(__entry->nf_may),
+		__entry->nf_file)
+)
+
+#define DEFINE_NFSD_FILE_EVENT(name) \
+DEFINE_EVENT(nfsd_file_class, name, \
+	TP_PROTO(struct nfsd_file *nf), \
+	TP_ARGS(nf))
+
+DEFINE_NFSD_FILE_EVENT(nfsd_file_alloc);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_put_final);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_release_locked);
+
+TRACE_EVENT(nfsd_file_acquire,
+	TP_PROTO(struct svc_rqst *rqstp, unsigned int hash,
+		 struct inode *inode, unsigned int may_flags,
+		 struct nfsd_file *nf, __be32 status),
+
+	TP_ARGS(rqstp, hash, inode, may_flags, nf, status),
+
+	TP_STRUCT__entry(
+		__field(__be32, xid)
+		__field(unsigned int, hash)
+		__field(void *, inode)
+		__field(unsigned int, may_flags)
+		__field(int, nf_ref)
+		__field(unsigned long, nf_flags)
+		__field(unsigned char, nf_may)
+		__field(struct file *, nf_file)
+		__field(__be32, status)
+	),
+
+	TP_fast_assign(
+		__entry->xid = rqstp->rq_xid;
+		__entry->hash = hash;
+		__entry->inode = inode;
+		__entry->may_flags = may_flags;
+		__entry->nf_ref = nf ? atomic_read(&nf->nf_ref) : 0;
+		__entry->nf_flags = nf ? nf->nf_flags : 0;
+		__entry->nf_may = nf ? nf->nf_may : 0;
+		__entry->nf_file = nf ? nf->nf_file : NULL;
+		__entry->status = status;
+	),
+
+	TP_printk("xid=0x%x hash=0x%x inode=0x%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=0x%p status=%u",
+			be32_to_cpu(__entry->xid), __entry->hash, __entry->inode,
+			show_nf_may(__entry->may_flags), __entry->nf_ref,
+			show_nf_flags(__entry->nf_flags),
+			show_nf_may(__entry->nf_may), __entry->nf_file,
+			be32_to_cpu(__entry->status))
+);
+
+DECLARE_EVENT_CLASS(nfsd_file_search_class,
+	TP_PROTO(struct inode *inode, unsigned int hash, int found),
+	TP_ARGS(inode, hash, found),
+	TP_STRUCT__entry(
+		__field(struct inode *, inode)
+		__field(unsigned int, hash)
+		__field(int, found)
+	),
+	TP_fast_assign(
+		__entry->inode = inode;
+		__entry->hash = hash;
+		__entry->found = found;
+	),
+	TP_printk("hash=0x%x inode=0x%p found=%d", __entry->hash,
+			__entry->inode, __entry->found)
+);
+
+#define DEFINE_NFSD_FILE_SEARCH_EVENT(name)				\
+DEFINE_EVENT(nfsd_file_search_class, name,				\
+	TP_PROTO(struct inode *inode, unsigned int hash, int found),	\
+	TP_ARGS(inode, hash, found))
+
+DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode_sync);
+DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode);
+DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_is_cached);
+
+TRACE_EVENT(nfsd_file_fsnotify_handle_event,
+	TP_PROTO(struct inode *inode, u32 mask),
+	TP_ARGS(inode, mask),
+	TP_STRUCT__entry(
+		__field(struct inode *, inode)
+		__field(unsigned int, nlink)
+		__field(umode_t, mode)
+		__field(u32, mask)
+	),
+	TP_fast_assign(
+		__entry->inode = inode;
+		__entry->nlink = inode->i_nlink;
+		__entry->mode = inode->i_mode;
+		__entry->mask = mask;
+	),
+	TP_printk("inode=0x%p nlink=%u mode=0%ho mask=0x%x", __entry->inode,
+			__entry->nlink, __entry->mode, __entry->mask)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fc24ee47eab5..d12d2de3b444 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -699,7 +699,7 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
 }
 #endif /* CONFIG_NFSD_V3 */
 
-static int nfsd_open_break_lease(struct inode *inode, int access)
+int nfsd_open_break_lease(struct inode *inode, int access)
 {
 	unsigned int mode;
 
@@ -715,8 +715,8 @@ static int nfsd_open_break_lease(struct inode *inode, int access)
  * and additional flags.
  * N.B. After this call fhp needs an fh_put
  */
-__be32
-nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
+static __be32
+__nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 			int may_flags, struct file **filp)
 {
 	struct path	path;
@@ -726,25 +726,6 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	__be32		err;
 	int		host_err = 0;
 
-	validate_process_creds();
-
-	/*
-	 * If we get here, then the client has already done an "open",
-	 * and (hopefully) checked permission - so allow OWNER_OVERRIDE
-	 * in case a chmod has now revoked permission.
-	 *
-	 * Arguably we should also allow the owner override for
-	 * directories, but we never have and it doesn't seem to have
-	 * caused anyone a problem.  If we were to change this, note
-	 * also that our filldir callbacks would need a variant of
-	 * lookup_one_len that doesn't check permissions.
-	 */
-	if (type == S_IFREG)
-		may_flags |= NFSD_MAY_OWNER_OVERRIDE;
-	err = fh_verify(rqstp, fhp, type, may_flags);
-	if (err)
-		goto out;
-
 	path.mnt = fhp->fh_export->ex_path.mnt;
 	path.dentry = fhp->fh_dentry;
 	inode = d_inode(path.dentry);
@@ -798,10 +779,50 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 out_nfserr:
 	err = nfserrno(host_err);
 out:
+	return err;
+}
+
+__be32
+nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
+		int may_flags, struct file **filp)
+{
+	__be32 err;
+
+	validate_process_creds();
+	/*
+	 * If we get here, then the client has already done an "open",
+	 * and (hopefully) checked permission - so allow OWNER_OVERRIDE
+	 * in case a chmod has now revoked permission.
+	 *
+	 * Arguably we should also allow the owner override for
+	 * directories, but we never have and it doesn't seem to have
+	 * caused anyone a problem.  If we were to change this, note
+	 * also that our filldir callbacks would need a variant of
+	 * lookup_one_len that doesn't check permissions.
+	 */
+	if (type == S_IFREG)
+		may_flags |= NFSD_MAY_OWNER_OVERRIDE;
+	err = fh_verify(rqstp, fhp, type, may_flags);
+	if (!err)
+		err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
+	validate_process_creds();
+	return err;
+}
+
+__be32
+nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
+		int may_flags, struct file **filp)
+{
+	__be32 err;
+
+	validate_process_creds();
+	err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
 	validate_process_creds();
 	return err;
 }
 
+
+
 struct raparms *
 nfsd_init_raparms(struct file *file)
 {
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index db351247892d..31fdae34e028 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -75,8 +75,11 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
 				loff_t, unsigned long);
 #endif /* CONFIG_NFSD_V3 */
+int 		nfsd_open_break_lease(struct inode *, int);
 __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
+__be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *, umode_t,
+				int, struct file **);
 struct raparms;
 __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
-- 
2.21.0

