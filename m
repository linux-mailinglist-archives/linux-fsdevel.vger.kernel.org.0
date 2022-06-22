Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89355415F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356786AbiFVEQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356552AbiFVEP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA332B7F
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=emn3i10uOt0R9V0ItwXp76JOrUIgmJ8DtQFEUtc/55w=; b=BfXK9BVTU6LRA5epAJMuzQ7EXh
        UbH6BU7fhhR5zQn81wOuspOqT4b/h40mdGz7vqnXodU6z5hAkUXQ8V1XNNd1rovdd3SmuHxHfXBAY
        Mfb+L6lCXxsTHut5DupSF1bsoDUI7uzxWT5q5lquSlk8vKvKRacoxZrEwNoVebnvudMFuL3l94s3C
        M1kAmx51VyLLkWKCgfCH69tdYrdtmJnnEqQWbjeLJDYeovpzHS250LlmRD/B9G/vyKQmJYSdxFMI+
        ZAw4BAtPduBLjfEXId0PbJfmdXBswM03Mfqv/AOPKhbLbW+GpPIin0oRGZLWOKbjOm3tTI1iv+lfX
        YTdoPjmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmT-0035vb-7U;
        Wed, 22 Jun 2022 04:15:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 05/44] struct file: use anonymous union member for rcuhead and llist
Date:   Wed, 22 Jun 2022 05:15:13 +0100
Message-Id: <20220622041552.737754-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Once upon a time we couldn't afford anon unions; these days minimal
gcc version had been raised enough to take care of that.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
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

