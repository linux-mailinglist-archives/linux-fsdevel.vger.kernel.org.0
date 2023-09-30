Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3627B3DCD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 05:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjI3D2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 23:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3D17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 23:27:59 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49077B4
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:27:57 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a1d0fee86aso109573647b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696044476; x=1696649276; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3VmQUPLhrERK4N60GAFBYo4ZpXXYTUhvBGEGGQtmto=;
        b=HyfOoLyE9tL6Xt3WfX7ZgrcqzE++2BLrNZwAz2xF0aRgKlvj+x3ksYc4TT5bRP/QMz
         8/xBu5nQ4LZSClT8ng7KIv1A0C0cbqpH4Z94AOpsLZg5vJ4YN7ACoaFce9mcUd0y+SvC
         0T5RD6ln/s9f0wI+3CnUYBssX8T46ENUkC0K/mmCwUSu0GIvywYNNYraZGOUjXtTwZNR
         ds/Wtgq3Qb1WmlSvFBZRS68LnuMUMIYxzztLMuPJz2ctH+5MV11y3F0VUYIx06UkZWRb
         X5vLvPJbTBYXthaUy9/xjzQweOnMWWiSLQdqGmGvsh06+khz4Gr3i/xf2V+XYkgbbJg+
         tecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696044476; x=1696649276;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3VmQUPLhrERK4N60GAFBYo4ZpXXYTUhvBGEGGQtmto=;
        b=l+yj0BahfeexH/p4lwY5TcktwKynfgttMjzdnQ6HiDl8A+c9q1THo/RRvULgHTiYOS
         6WwtIZ4R58QbLeKcdzEW8euj4G+F7NkhtrIbNo7eTnUroMulErpEB3d58bm5OJCV/965
         9WLbP8hnVmGCI+9ucfTr451OEFREJ70zZ7CBEr/Rbt8FlH4LhXbVDJpjVWDxM7ab5KqU
         lfgCQfELN691wKP3CTCjfnvIm401RI2hYRNVbYY71jgXj4WmYGUBK290s15HGTMf5gBK
         g+xlIYTke6YQodkALsDgK+02vlUPsOSm8ee8zX110IVvLiOJJ+sqghAJce926Xg6IfQJ
         Frmw==
X-Gm-Message-State: AOJu0YyI+VvdyzdZr+2KB1jUgireqydoRTkOYW8NsGnYQDWfHoiv61io
        RWxBkvB+GV9Xcj4uftga8cUvQA==
X-Google-Smtp-Source: AGHT+IHp1qF65eHgx27QgmeBCNpipwBMvCNXdEQuNLXjnq7w6FkkrCvB+RR9BXWpFDUscD7OTgD8iw==
X-Received: by 2002:a0d:ee46:0:b0:5a1:635e:e68 with SMTP id x67-20020a0dee46000000b005a1635e0e68mr5109602ywe.46.1696044476344;
        Fri, 29 Sep 2023 20:27:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l8-20020a0de208000000b00586108dd8f5sm5983418ywe.18.2023.09.29.20.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 20:27:55 -0700 (PDT)
Date:   Fri, 29 Sep 2023 20:27:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 3/8] shmem: factor shmem_falloc_wait() out of shmem_fault()
In-Reply-To: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
Message-ID: <6fe379a4-6176-9225-9263-fe60d2633c0@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

That Trinity livelock shmem_falloc avoidance block is unlikely, and a
distraction from the proper business of shmem_fault(): separate it out.
(This used to help compilers save stack on the fault path too, but both
gcc and clang nowadays seem to make better choices anyway.)

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 126 +++++++++++++++++++++++++++++------------------------
 1 file changed, 69 insertions(+), 57 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 824eb55671d2..5501a5bc8d8c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2148,87 +2148,99 @@ int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
  * entry unconditionally - even if something else had already woken the
  * target.
  */
-static int synchronous_wake_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
+static int synchronous_wake_function(wait_queue_entry_t *wait,
+			unsigned int mode, int sync, void *key)
 {
 	int ret = default_wake_function(wait, mode, sync, key);
 	list_del_init(&wait->entry);
 	return ret;
 }
 
+/*
+ * Trinity finds that probing a hole which tmpfs is punching can
+ * prevent the hole-punch from ever completing: which in turn
+ * locks writers out with its hold on i_rwsem.  So refrain from
+ * faulting pages into the hole while it's being punched.  Although
+ * shmem_undo_range() does remove the additions, it may be unable to
+ * keep up, as each new page needs its own unmap_mapping_range() call,
+ * and the i_mmap tree grows ever slower to scan if new vmas are added.
+ *
+ * It does not matter if we sometimes reach this check just before the
+ * hole-punch begins, so that one fault then races with the punch:
+ * we just need to make racing faults a rare case.
+ *
+ * The implementation below would be much simpler if we just used a
+ * standard mutex or completion: but we cannot take i_rwsem in fault,
+ * and bloating every shmem inode for this unlikely case would be sad.
+ */
+static vm_fault_t shmem_falloc_wait(struct vm_fault *vmf, struct inode *inode)
+{
+	struct shmem_falloc *shmem_falloc;
+	struct file *fpin = NULL;
+	vm_fault_t ret = 0;
+
+	spin_lock(&inode->i_lock);
+	shmem_falloc = inode->i_private;
+	if (shmem_falloc &&
+	    shmem_falloc->waitq &&
+	    vmf->pgoff >= shmem_falloc->start &&
+	    vmf->pgoff < shmem_falloc->next) {
+		wait_queue_head_t *shmem_falloc_waitq;
+		DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
+
+		ret = VM_FAULT_NOPAGE;
+		fpin = maybe_unlock_mmap_for_io(vmf, NULL);
+		shmem_falloc_waitq = shmem_falloc->waitq;
+		prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
+				TASK_UNINTERRUPTIBLE);
+		spin_unlock(&inode->i_lock);
+		schedule();
+
+		/*
+		 * shmem_falloc_waitq points into the shmem_fallocate()
+		 * stack of the hole-punching task: shmem_falloc_waitq
+		 * is usually invalid by the time we reach here, but
+		 * finish_wait() does not dereference it in that case;
+		 * though i_lock needed lest racing with wake_up_all().
+		 */
+		spin_lock(&inode->i_lock);
+		finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
+	}
+	spin_unlock(&inode->i_lock);
+	if (fpin) {
+		fput(fpin);
+		ret = VM_FAULT_RETRY;
+	}
+	return ret;
+}
+
 static vm_fault_t shmem_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
-	struct inode *inode = file_inode(vma->vm_file);
+	struct inode *inode = file_inode(vmf->vma->vm_file);
 	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
 	struct folio *folio = NULL;
+	vm_fault_t ret = 0;
 	int err;
-	vm_fault_t ret = VM_FAULT_LOCKED;
 
 	/*
 	 * Trinity finds that probing a hole which tmpfs is punching can
-	 * prevent the hole-punch from ever completing: which in turn
-	 * locks writers out with its hold on i_rwsem.  So refrain from
-	 * faulting pages into the hole while it's being punched.  Although
-	 * shmem_undo_range() does remove the additions, it may be unable to
-	 * keep up, as each new page needs its own unmap_mapping_range() call,
-	 * and the i_mmap tree grows ever slower to scan if new vmas are added.
-	 *
-	 * It does not matter if we sometimes reach this check just before the
-	 * hole-punch begins, so that one fault then races with the punch:
-	 * we just need to make racing faults a rare case.
-	 *
-	 * The implementation below would be much simpler if we just used a
-	 * standard mutex or completion: but we cannot take i_rwsem in fault,
-	 * and bloating every shmem inode for this unlikely case would be sad.
+	 * prevent the hole-punch from ever completing: noted in i_private.
 	 */
 	if (unlikely(inode->i_private)) {
-		struct shmem_falloc *shmem_falloc;
-
-		spin_lock(&inode->i_lock);
-		shmem_falloc = inode->i_private;
-		if (shmem_falloc &&
-		    shmem_falloc->waitq &&
-		    vmf->pgoff >= shmem_falloc->start &&
-		    vmf->pgoff < shmem_falloc->next) {
-			struct file *fpin;
-			wait_queue_head_t *shmem_falloc_waitq;
-			DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
-
-			ret = VM_FAULT_NOPAGE;
-			fpin = maybe_unlock_mmap_for_io(vmf, NULL);
-			if (fpin)
-				ret = VM_FAULT_RETRY;
-
-			shmem_falloc_waitq = shmem_falloc->waitq;
-			prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
-					TASK_UNINTERRUPTIBLE);
-			spin_unlock(&inode->i_lock);
-			schedule();
-
-			/*
-			 * shmem_falloc_waitq points into the shmem_fallocate()
-			 * stack of the hole-punching task: shmem_falloc_waitq
-			 * is usually invalid by the time we reach here, but
-			 * finish_wait() does not dereference it in that case;
-			 * though i_lock needed lest racing with wake_up_all().
-			 */
-			spin_lock(&inode->i_lock);
-			finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
-			spin_unlock(&inode->i_lock);
-
-			if (fpin)
-				fput(fpin);
+		ret = shmem_falloc_wait(vmf, inode);
+		if (ret)
 			return ret;
-		}
-		spin_unlock(&inode->i_lock);
 	}
 
+	WARN_ON_ONCE(vmf->page != NULL);
 	err = shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
 				  gfp, vmf, &ret);
 	if (err)
 		return vmf_error(err);
-	if (folio)
+	if (folio) {
 		vmf->page = folio_file_page(folio, vmf->pgoff);
+		ret |= VM_FAULT_LOCKED;
+	}
 	return ret;
 }
 
-- 
2.35.3

