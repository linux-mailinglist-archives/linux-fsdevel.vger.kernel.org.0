Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEDA53F4D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 06:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiFGEKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 00:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiFGEKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:10:31 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F296CA3EB
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 21:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nU+iTBi7IslSn8ruozWCCF8I9RCilDXIonsFt0+jWPY=; b=HI3bjk2KRsuB75zwcgNAl/5qUd
        GcxZYuvmXPxsE8y+TMA90gYWY2faqTSOxhQV76TY+vjYDkor8vncDu1OBZIM8i0Gn6Nc+HZrfi/KT
        XGhSsp+2cxlLdEy9GQiIi2g6d2hs4EgqCmk0vX3iO9A6ac32Ipez9L+EIT0XRiU5YIBsG8tQPC8f0
        qoKRdu52TJVgE1fCil1fl1lFP/dAqlcMb4Ek8XQutKWMuZ354UAHxCFMDAV8pcEEE2PtWndl38Rqe
        nZhaZGAjxJUK1kUyg+U65/08AmGbqoYS9xtzK1dDGEjUZPQor/I0s4SpBJCL1F54IdCia+ZIohI1h
        r9AGzQXw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyQY0-004YlC-9z; Tue, 07 Jun 2022 04:10:28 +0000
Date:   Tue, 7 Jun 2022 04:10:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/9] struct file: use anonymous union member for rcuhead and
 llist
Message-ID: <Yp7PtAl5fuh/hqhS@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Once upon a time we couldn't afford anon unions; these days minimal
gcc version had been raised enough to take care of that.
---
 fs/file_table.c    | 16 ++++++++--------
 include/linux/fs.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 5424e3a8df5f..b989e33aacda 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -45,7 +45,7 @@ static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
 static void file_free_rcu(struct rcu_head *head)
 {
-	struct file *f = container_of(head, struct file, f_u.fu_rcuhead);
+	struct file *f = container_of(head, struct file, f_rcuhead);
 
 	put_cred(f->f_cred);
 	kmem_cache_free(filp_cachep, f);
@@ -56,7 +56,7 @@ static inline void file_free(struct file *f)
 	security_file_free(f);
 	if (!(f->f_mode & FMODE_NOACCOUNT))
 		percpu_counter_dec(&nr_files);
-	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
+	call_rcu(&f->f_rcuhead, file_free_rcu);
 }
 
 /*
@@ -142,7 +142,7 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
 	f->f_cred = get_cred(cred);
 	error = security_file_alloc(f);
 	if (unlikely(error)) {
-		file_free_rcu(&f->f_u.fu_rcuhead);
+		file_free_rcu(&f->f_rcuhead);
 		return ERR_PTR(error);
 	}
 
@@ -341,13 +341,13 @@ static void delayed_fput(struct work_struct *unused)
 	struct llist_node *node = llist_del_all(&delayed_fput_list);
 	struct file *f, *t;
 
-	llist_for_each_entry_safe(f, t, node, f_u.fu_llist)
+	llist_for_each_entry_safe(f, t, node, f_llist)
 		__fput(f);
 }
 
 static void ____fput(struct callback_head *work)
 {
-	__fput(container_of(work, struct file, f_u.fu_rcuhead));
+	__fput(container_of(work, struct file, f_rcuhead));
 }
 
 /*
@@ -374,8 +374,8 @@ void fput(struct file *file)
 		struct task_struct *task = current;
 
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
-			init_task_work(&file->f_u.fu_rcuhead, ____fput);
-			if (!task_work_add(task, &file->f_u.fu_rcuhead, TWA_RESUME))
+			init_task_work(&file->f_rcuhead, ____fput);
+			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
 				return;
 			/*
 			 * After this task has run exit_task_work(),
@@ -384,7 +384,7 @@ void fput(struct file *file)
 			 */
 		}
 
-		if (llist_add(&file->f_u.fu_llist, &delayed_fput_list))
+		if (llist_add(&file->f_llist, &delayed_fput_list))
 			schedule_delayed_work(&delayed_fput_work, 1);
 	}
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..6a2a4906041f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -924,9 +924,9 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
 
 struct file {
 	union {
-		struct llist_node	fu_llist;
-		struct rcu_head 	fu_rcuhead;
-	} f_u;
+		struct llist_node	f_llist;
+		struct rcu_head 	f_rcuhead;
+	};
 	struct path		f_path;
 	struct inode		*f_inode;	/* cached value */
 	const struct file_operations	*f_op;
-- 
2.30.2

