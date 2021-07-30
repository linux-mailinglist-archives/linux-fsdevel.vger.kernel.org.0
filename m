Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275813DB4DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbhG3IGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhG3IGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:06:43 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB3C061765
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 01:06:39 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 3so4784209qvd.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 01:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1kfuy3p4fQPWj8BIXMnfIDnrdaVNjXGHJ629/sTHhN0=;
        b=CGPy5pxveZbPA1YkH+RTGRMS6aPEOFmKcznpUhPyKtR9PWFd7pRCReXbF5wpNnlYp/
         9SpcE6rwiUrLzJQyIfAD/Yzb5gZ3Mv8DewkIbl39cqv3QD3ds4jZEJSD49UlWMzu+xLT
         5JlghbqtaO9QyjG6S5rwyAiGMYfZTJVtRuFXIRVXiwjvyY71TgPJTMDUX+0TaOp+wGx9
         kZgUaTLM3vhSlQud2H2zdrvR9FR1S6J7SWdH6M1/RsHPz5Pq7alHk4GsDrodUH/l+fXh
         vXErqQtQA1uE+Mggx8zNjo9CJz9yMyRMqxCpNn4IOIPbAFTZ9xwBw1wqz0A9YfmLWtvb
         J0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1kfuy3p4fQPWj8BIXMnfIDnrdaVNjXGHJ629/sTHhN0=;
        b=Xo9YCuA1vqxKxz6nCIo270D7Yt6BkzQJ8OaWMybhbvF2beRBdR7UxpUfzkhFSmlFeu
         rs2ztclR8YkteanNUJczQCHQ+uUxlu+oNRP7bfuYCzVMwRP31nWu3HAaOOUp1BdUvunI
         fSZIuhZPTNxR80/QwVcS6Ys6oz0pvwVnc6rnWwRU1WcKtXDm9h/Yl+yxHSk2/McVBuRj
         IeGyny1oMppgiyP1Q3ZSM+oN9tepii6rdjSumRVLRivZutY57WIGycIjqKQ+vlhF2sLy
         kkKrviR/lPEv/LbfVzdjmj6cJh9z9H8seFpc/YQCPlyJ1S/wytxfmAzQtz2WgBB4Z6HQ
         MoEQ==
X-Gm-Message-State: AOAM5334GzL8xWms4yM8B+uyEYs9HYZxlwoXE2EC/ah0M/7x1+a33pfI
        29ZqLezwEHl0YWJFONltwIvKfw==
X-Google-Smtp-Source: ABdhPJzjhVOQvAERKlBjHv/dpZ6fohKVV28g9IpIkBW8etwIftV8Ohu4XnZ/N7AaWt7UMH4c2S5Vmg==
X-Received: by 2002:a05:6214:ca5:: with SMTP id s5mr1431061qvs.58.1627632398575;
        Fri, 30 Jul 2021 01:06:38 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t8sm328269qtq.28.2021.07.30.01.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 01:06:37 -0700 (PDT)
Date:   Fri, 30 Jul 2021 01:06:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 14/16] mm: user_shm_lock(,,getuc) and
 user_shm_unlock(,,putuc)
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <4bd4072-7eb0-d1a5-ce49-82f4b24bd070@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

user_shm_lock() and user_shm_unlock() have to get and put a reference on
the ucounts structure, and get fails at overflow.  That will be awkward
for the next commit (shrinking ought not to fail), so add an argument
(always true in this commit) to condition that get and put.  It would
be even easier to do the put_ucounts() separately when unlocking, but
messy for the get_ucounts() when locking: better to keep them symmetric.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/hugetlbfs/inode.c | 4 ++--
 include/linux/mm.h   | 4 ++--
 ipc/shm.c            | 4 ++--
 mm/mlock.c           | 9 +++++----
 mm/shmem.c           | 6 +++---
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index cdfb1ae78a3f..381902288f4d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1465,7 +1465,7 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 
 	if (creat_flags == HUGETLB_SHMFS_INODE && !can_do_hugetlb_shm()) {
 		*ucounts = current_ucounts();
-		if (user_shm_lock(size, *ucounts)) {
+		if (user_shm_lock(size, *ucounts, true)) {
 			task_lock(current);
 			pr_warn_once("%s (%d): Using mlock ulimits for SHM_HUGETLB is deprecated\n",
 				current->comm, current->pid);
@@ -1499,7 +1499,7 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	iput(inode);
 out:
 	if (*ucounts) {
-		user_shm_unlock(size, *ucounts);
+		user_shm_unlock(size, *ucounts, true);
 		*ucounts = NULL;
 	}
 	return file;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f1be2221512b..43cb5a6f97ff 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1713,8 +1713,8 @@ extern bool can_do_mlock(void);
 #else
 static inline bool can_do_mlock(void) { return false; }
 #endif
-extern bool user_shm_lock(loff_t size, struct ucounts *ucounts);
-extern void user_shm_unlock(loff_t size, struct ucounts *ucounts);
+extern bool user_shm_lock(loff_t size, struct ucounts *ucounts, bool getuc);
+extern void user_shm_unlock(loff_t size, struct ucounts *ucounts, bool putuc);
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
diff --git a/ipc/shm.c b/ipc/shm.c
index 748933e376ca..3e63809d38b7 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -289,7 +289,7 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
 		shmem_lock(shm_file, 0, shp->mlock_ucounts);
 	else if (shp->mlock_ucounts)
 		user_shm_unlock(i_size_read(file_inode(shm_file)),
-				shp->mlock_ucounts);
+				shp->mlock_ucounts, true);
 	fput(shm_file);
 	ipc_update_pid(&shp->shm_cprid, NULL);
 	ipc_update_pid(&shp->shm_lprid, NULL);
@@ -699,7 +699,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	ipc_update_pid(&shp->shm_cprid, NULL);
 	ipc_update_pid(&shp->shm_lprid, NULL);
 	if (is_file_hugepages(file) && shp->mlock_ucounts)
-		user_shm_unlock(size, shp->mlock_ucounts);
+		user_shm_unlock(size, shp->mlock_ucounts, true);
 	fput(file);
 	ipc_rcu_putref(&shp->shm_perm, shm_rcu_free);
 	return error;
diff --git a/mm/mlock.c b/mm/mlock.c
index 7df88fce0fc9..5afa3eba9a13 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -818,7 +818,7 @@ SYSCALL_DEFINE0(munlockall)
  */
 static DEFINE_SPINLOCK(shmlock_user_lock);
 
-bool user_shm_lock(loff_t size, struct ucounts *ucounts)
+bool user_shm_lock(loff_t size, struct ucounts *ucounts, bool getuc)
 {
 	unsigned long lock_limit, locked;
 	long memlock;
@@ -836,7 +836,7 @@ bool user_shm_lock(loff_t size, struct ucounts *ucounts)
 		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 		goto out;
 	}
-	if (!get_ucounts(ucounts)) {
+	if (getuc && !get_ucounts(ucounts)) {
 		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 		goto out;
 	}
@@ -846,10 +846,11 @@ bool user_shm_lock(loff_t size, struct ucounts *ucounts)
 	return allowed;
 }
 
-void user_shm_unlock(loff_t size, struct ucounts *ucounts)
+void user_shm_unlock(loff_t size, struct ucounts *ucounts, bool putuc)
 {
 	spin_lock(&shmlock_user_lock);
 	dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, (size + PAGE_SIZE - 1) >> PAGE_SHIFT);
 	spin_unlock(&shmlock_user_lock);
-	put_ucounts(ucounts);
+	if (putuc)
+		put_ucounts(ucounts);
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 35c0f5c7120e..1ddb910e976c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1163,7 +1163,7 @@ static void shmem_evict_inode(struct inode *inode)
 
 	if (shmem_mapping(inode->i_mapping)) {
 		if (info->mlock_ucounts) {
-			user_shm_unlock(inode->i_size, info->mlock_ucounts);
+			user_shm_unlock(inode->i_size, info->mlock_ucounts, true);
 			info->mlock_ucounts = NULL;
 		}
 		shmem_unacct_size(info->flags, inode->i_size);
@@ -2276,13 +2276,13 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 	 * no serialization needed when called from shm_destroy().
 	 */
 	if (lock && !(info->flags & VM_LOCKED)) {
-		if (!user_shm_lock(inode->i_size, ucounts))
+		if (!user_shm_lock(inode->i_size, ucounts, true))
 			goto out_nomem;
 		info->flags |= VM_LOCKED;
 		mapping_set_unevictable(file->f_mapping);
 	}
 	if (!lock && (info->flags & VM_LOCKED) && ucounts) {
-		user_shm_unlock(inode->i_size, ucounts);
+		user_shm_unlock(inode->i_size, ucounts, true);
 		info->flags &= ~VM_LOCKED;
 		mapping_clear_unevictable(file->f_mapping);
 	}
-- 
2.26.2

