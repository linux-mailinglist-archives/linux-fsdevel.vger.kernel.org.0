Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6463BC8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbfFJTOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:14:34 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45023 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389167AbfFJTOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:33 -0400
Received: by mail-vs1-f68.google.com with SMTP id v129so6191889vsb.11;
        Mon, 10 Jun 2019 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVPQA1G03TZXmMhT1ReNlX8Dqt4hVw5sMuV447dMS9w=;
        b=BTH0LYCBiNfV2iYfhZtj+8EvTN2VZXZ9ofvyVlCb/xe8hZ60b75zs24bbUQx3dlxgo
         ldFA0kuEVfLr/SgpdkcJWGWH4zkEaJy1y0wB1lJECLqgrzO6t/5fJiMHzulB8cJBxJ0n
         O2fc534HbAhSmMLHS9/Uik8Uily6fOY9e+hP+Qhe9dqH96Ap80897eB67shJDQF8AKCQ
         Qav+fWUnKs92o6G9DoqJFDdOPy5pZ2DANGHnKad+r5+TH418hLTZ2WzsAm56IosibY+S
         OD+ttL58RuVwpTxNn5e6JxlvmRjGWsX7hKyGnDFQZaXTjPkFHjCeDImHeW5aLYf3K/wo
         lbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVPQA1G03TZXmMhT1ReNlX8Dqt4hVw5sMuV447dMS9w=;
        b=Hmn+zY84J9SmWJIwf3gCle2mbsxud0Bpzui7QmKaItE217UrTnpb4NY89g9Nbm9U+b
         zZR48m6d00xPUeEDgxf7XMgHuxpdp8LlNTWN2WcSxaY4rMZ5EMJpM/+DGaNQkMzf4ekn
         0J2Y6IgYDUc+/HJimwOBTDR4X1MpZ9PyIHi/VQCz49jymi/jMV51OJI+m5zIUDEazRis
         PJPB6iuE7y/B2wmWiuU8vmxjuxnsCCITd7PUQkH2cV50Q8VSAvyIl3ejTCvQ69wJAPDE
         Cl3pP7fBFnzMA5j3pC1AjAv/hyi++W22ifiXAXxB+LKJ469aYBuZHQVD5fnNFRubIdNh
         6reg==
X-Gm-Message-State: APjAAAWqP1Z6zYsPCpuRAr4PrTOPX/TBZ4tKT5MwJPUP6otfTGA+pJUl
        QT2d9TH5I7AvpAn1gpavNEWhwix3fw==
X-Google-Smtp-Source: APXvYqzUnGf9oPJeyunuLj6dNdswq27mhvEh0TasLZVBTzt24Ki+McvPeFyUsUWw5Rr9p3dYjhJepQ==
X-Received: by 2002:a67:7cd0:: with SMTP id x199mr28882627vsc.233.1560194071634;
        Mon, 10 Jun 2019 12:14:31 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:30 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 03/12] mm: pagecache add lock
Date:   Mon, 10 Jun 2019 15:14:11 -0400
Message-Id: <20190610191420.27007-4-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a per address space lock around adding pages to the pagecache - making it
possible for fallocate INSERT_RANGE/COLLAPSE_RANGE to work correctly, and also
hopefully making truncate and dio a bit saner.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/inode.c            |  1 +
 include/linux/fs.h    | 24 +++++++++++++
 include/linux/sched.h |  4 +++
 init/init_task.c      |  1 +
 mm/filemap.c          | 81 +++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9a453f3637..8881dc551f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -350,6 +350,7 @@ EXPORT_SYMBOL(inc_nlink);
 static void __address_space_init_once(struct address_space *mapping)
 {
 	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ);
+	pagecache_lock_init(&mapping->add_lock);
 	init_rwsem(&mapping->i_mmap_rwsem);
 	INIT_LIST_HEAD(&mapping->private_list);
 	spin_lock_init(&mapping->private_lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28e76790..a88d994751 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -418,6 +418,28 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
 				struct page *page, void *fsdata);
 
+/*
+ * Two-state lock - can be taken for add or block - both states are shared,
+ * like read side of rwsem, but conflict with other state:
+ */
+struct pagecache_lock {
+	atomic_long_t		v;
+	wait_queue_head_t	wait;
+};
+
+static inline void pagecache_lock_init(struct pagecache_lock *lock)
+{
+	atomic_long_set(&lock->v, 0);
+	init_waitqueue_head(&lock->wait);
+}
+
+void pagecache_add_put(struct pagecache_lock *);
+void pagecache_add_get(struct pagecache_lock *);
+void __pagecache_block_put(struct pagecache_lock *);
+void __pagecache_block_get(struct pagecache_lock *);
+void pagecache_block_put(struct pagecache_lock *);
+void pagecache_block_get(struct pagecache_lock *);
+
 /**
  * struct address_space - Contents of a cacheable, mappable object.
  * @host: Owner, either the inode or the block_device.
@@ -452,6 +474,8 @@ struct address_space {
 	spinlock_t		private_lock;
 	struct list_head	private_list;
 	void			*private_data;
+	struct pagecache_lock	add_lock
+		____cacheline_aligned_in_smp;	/* protects adding new pages */
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
 	 * On most architectures that alignment is already the case; but
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1549584a15..a46baade99 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -43,6 +43,7 @@ struct io_context;
 struct mempolicy;
 struct nameidata;
 struct nsproxy;
+struct pagecache_lock;
 struct perf_event_context;
 struct pid_namespace;
 struct pipe_inode_info;
@@ -935,6 +936,9 @@ struct task_struct {
 	unsigned int			in_ubsan;
 #endif
 
+	/* currently held lock, for avoiding recursing in fault path: */
+	struct pagecache_lock *pagecache_lock;
+
 	/* Journalling filesystem info: */
 	void				*journal_info;
 
diff --git a/init/init_task.c b/init/init_task.c
index c70ef656d0..92bbb6e909 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -115,6 +115,7 @@ struct task_struct init_task
 	},
 	.blocked	= {{0}},
 	.alloc_lock	= __SPIN_LOCK_UNLOCKED(init_task.alloc_lock),
+	.pagecache_lock = NULL,
 	.journal_info	= NULL,
 	INIT_CPU_TIMERS(init_task)
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
diff --git a/mm/filemap.c b/mm/filemap.c
index d78f577bae..93d7e0e686 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -113,6 +113,73 @@
  *   ->tasklist_lock            (memory_failure, collect_procs_ao)
  */
 
+static void __pagecache_lock_put(struct pagecache_lock *lock, long i)
+{
+	BUG_ON(atomic_long_read(&lock->v) == 0);
+
+	if (atomic_long_sub_return_release(i, &lock->v) == 0)
+		wake_up_all(&lock->wait);
+}
+
+static bool __pagecache_lock_tryget(struct pagecache_lock *lock, long i)
+{
+	long v = atomic_long_read(&lock->v), old;
+
+	do {
+		old = v;
+
+		if (i > 0 ? v < 0 : v > 0)
+			return false;
+	} while ((v = atomic_long_cmpxchg_acquire(&lock->v,
+					old, old + i)) != old);
+	return true;
+}
+
+static void __pagecache_lock_get(struct pagecache_lock *lock, long i)
+{
+	wait_event(lock->wait, __pagecache_lock_tryget(lock, i));
+}
+
+void pagecache_add_put(struct pagecache_lock *lock)
+{
+	__pagecache_lock_put(lock, 1);
+}
+EXPORT_SYMBOL(pagecache_add_put);
+
+void pagecache_add_get(struct pagecache_lock *lock)
+{
+	__pagecache_lock_get(lock, 1);
+}
+EXPORT_SYMBOL(pagecache_add_get);
+
+void __pagecache_block_put(struct pagecache_lock *lock)
+{
+	__pagecache_lock_put(lock, -1);
+}
+EXPORT_SYMBOL(__pagecache_block_put);
+
+void __pagecache_block_get(struct pagecache_lock *lock)
+{
+	__pagecache_lock_get(lock, -1);
+}
+EXPORT_SYMBOL(__pagecache_block_get);
+
+void pagecache_block_put(struct pagecache_lock *lock)
+{
+	BUG_ON(current->pagecache_lock != lock);
+	current->pagecache_lock = NULL;
+	__pagecache_lock_put(lock, -1);
+}
+EXPORT_SYMBOL(pagecache_block_put);
+
+void pagecache_block_get(struct pagecache_lock *lock)
+{
+	__pagecache_lock_get(lock, -1);
+	BUG_ON(current->pagecache_lock);
+	current->pagecache_lock = lock;
+}
+EXPORT_SYMBOL(pagecache_block_get);
+
 static void page_cache_delete(struct address_space *mapping,
 				   struct page *page, void *shadow)
 {
@@ -829,11 +896,14 @@ static int __add_to_page_cache_locked(struct page *page,
 	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
 	mapping_set_update(&xas, mapping);
 
+	if (current->pagecache_lock != &mapping->add_lock)
+		pagecache_add_get(&mapping->add_lock);
+
 	if (!huge) {
 		error = mem_cgroup_try_charge(page, current->mm,
 					      gfp_mask, &memcg, false);
 		if (error)
-			return error;
+			goto out;
 	}
 
 	get_page(page);
@@ -869,14 +939,19 @@ static int __add_to_page_cache_locked(struct page *page,
 	if (!huge)
 		mem_cgroup_commit_charge(page, memcg, false, false);
 	trace_mm_filemap_add_to_page_cache(page);
-	return 0;
+	error = 0;
+out:
+	if (current->pagecache_lock != &mapping->add_lock)
+		pagecache_add_put(&mapping->add_lock);
+	return error;
 error:
 	page->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
 	if (!huge)
 		mem_cgroup_cancel_charge(page, memcg, false);
 	put_page(page);
-	return xas_error(&xas);
+	error = xas_error(&xas);
+	goto out;
 }
 
 /**
-- 
2.20.1

