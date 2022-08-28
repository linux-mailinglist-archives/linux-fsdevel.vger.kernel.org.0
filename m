Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE545A3BE3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 07:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiH1FFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 01:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiH1FE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:04:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2FFDEAF;
        Sat, 27 Aug 2022 22:04:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y1so3227686plb.2;
        Sat, 27 Aug 2022 22:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=GRsBqrVCKPuwGb49qWX3lkLzKMs1VKBl59b0ZePoMUk=;
        b=C3bTZdHn+MPcGiGkDw4NGWQmOcOAWsC2+muEDUCBHkmpIw4Xq+nrslza4kcpj8250S
         /ILWiWnr0lzJYWivf2KiZGps65LHuJq0XgpW4PdLvfUioE/e5egOP4K51uH7sKeSE23q
         STNnYRkJmfjVx/lBRHYHYYvWrxMtLweXUs/2XjZKx7sgm1Awy7ZZ3yOk2W21ufMpyM+9
         KYoia5L84QIFLLRUoxWtxA/wvQbVb/SpV5BXnat1Q0036I8Xbzlw9B1XIvH0zAfViekV
         fBnfrldhAD4VZOm6Hi8GrPKkf9yaumqlA2hsHWIJ9A2Wi6lgqtw9OES09jCT44BfM8tG
         EsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=GRsBqrVCKPuwGb49qWX3lkLzKMs1VKBl59b0ZePoMUk=;
        b=nlH5s/x/LDPuyFdiLkuj+HRkKznOb8+DBUxekKj/uYP2uDUnEJk8o5Cqc3vxpQ+QHL
         tZdksPTzr9IOHkSUHpXzhmORsTOfEh/z7CnAKmciYmDcrq0228mJHrHGwwH6Xuii8cXC
         YqFXBVLvixGfrMAfFsVD7xAUrsGLuvGiwRC8yF0citJSytmiepvmcd3Avvbcuy6VfW+r
         WznJ6XjGiSuEgMtCZRdqaxQNTmG45luEOH/2H14VF4e/GC7dOWKNQMX7QjEWyKEMs3Ql
         jnb/pnxpELUs7zFxmxr/M+s38/cAkm+VNUglkMkojaIrW7N0B3cjj/61j5bZ8wRa6NZk
         fVaw==
X-Gm-Message-State: ACgBeo0L9yByvaH31gt87jJopIaSuisFW3sjDfViOadHjD0UNsyCVrQk
        nBliwwqFIHhefFp/fVrC0yE=
X-Google-Smtp-Source: AA6agR4NksUioHOjk10az8EUiEx/Dqnw9azdC3Ux0wK6wprATSVaCsvmy6kh8pDFxdFUtWeuHEOiqw==
X-Received: by 2002:a17:90b:4cc7:b0:1fa:b5c2:4c7d with SMTP id nd7-20020a17090b4cc700b001fab5c24c7dmr12405609pjb.69.1661663092936;
        Sat, 27 Aug 2022 22:04:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c73-20020a621c4c000000b00536779d43e7sm4538842pfc.201.2022.08.27.22.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:04:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/9] kernfs: Simply by replacing kernfs_deref_open_node() with of_on()
Date:   Sat, 27 Aug 2022 19:04:32 -1000
Message-Id: <20220828050440.734579-2-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828050440.734579-1-tj@kernel.org>
References: <20220828050440.734579-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernfs_node->attr.open is an RCU pointer to kernfs_open_node. However, RCU
dereference is currently only used in kernfs_notify(). Everywhere else,
either we're holding the lock which protects it or know that the
kernfs_open_node is pinned becaused we have a pointer to a kernfs_open_file
which is hanging off of it.

kernfs_deref_open_node() is used for the latter case - accessing
kernfs_open_node from kernfs_open_file. The lifetime and visibility rules
are simple and clear here. To someone who can access a kernfs_open_file, its
kernfs_open_node is pinned and visible through of->kn->attr.open.

Replace kernfs_deref_open_node() which simpler of_on(). The former takes
both @kn and @of and RCU deref @kn->attr.open while sanity checking with
@of. The latter takes @of and uses protected deref on of->kn->attr.open.

As the return value can't be NULL, remove the error handling in the callers
too.

This shouldn't cause any functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Imran Khan <imran.f.khan@oracle.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/kernfs/file.c | 56 +++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 43 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index b3ec34386b43..32b16fe00a9e 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -57,31 +57,17 @@ static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
 }
 
 /**
- * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
- *
- * @of: associated kernfs_open_file instance.
- * @kn: target kernfs_node.
- *
- * Fetch and return ->attr.open of @kn if @of->list is non empty.
- * If @of->list is not empty we can safely assume that @of is on
- * @kn->attr.open->files list and this guarantees that @kn->attr.open
- * will not vanish i.e. dereferencing outside RCU read-side critical
- * section is safe here.
- *
- * The caller needs to make sure that @of->list is not empty.
+ * of_on - Return the kernfs_open_node of the specified kernfs_open_file
+ * @of: taret kernfs_open_file
  */
-static struct kernfs_open_node *
-kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
+static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
 {
-	struct kernfs_open_node *on;
-
-	on = rcu_dereference_check(kn->attr.open, !list_empty(&of->list));
-
-	return on;
+	return rcu_dereference_protected(of->kn->attr.open,
+					 !list_empty(&of->list));
 }
 
 /**
- * kernfs_deref_open_node_protected - Get kernfs_open_node corresponding to @kn
+ * kernfs_deref_open_node_locked - Get kernfs_open_node corresponding to @kn
  *
  * @kn: target kernfs_node.
  *
@@ -96,7 +82,7 @@ kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
  * The caller needs to make sure that kernfs_open_file_mutex is held.
  */
 static struct kernfs_open_node *
-kernfs_deref_open_node_protected(struct kernfs_node *kn)
+kernfs_deref_open_node_locked(struct kernfs_node *kn)
 {
 	return rcu_dereference_protected(kn->attr.open,
 				lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
@@ -207,12 +193,8 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 static int kernfs_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
-	struct kernfs_open_node *on = kernfs_deref_open_node(of, of->kn);
-
-	if (!on)
-		return -EINVAL;
 
-	of->event = atomic_read(&on->event);
+	of->event = atomic_read(&of_on(of)->event);
 
 	return of->kn->attr.ops->seq_show(sf, v);
 }
@@ -235,7 +217,6 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
 	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
-	struct kernfs_open_node *on;
 	char *buf;
 
 	buf = of->prealloc_buf;
@@ -257,14 +238,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		goto out_free;
 	}
 
-	on = kernfs_deref_open_node(of, of->kn);
-	if (!on) {
-		len = -EINVAL;
-		mutex_unlock(&of->mutex);
-		goto out_free;
-	}
-
-	of->event = atomic_read(&on->event);
+	of->event = atomic_read(&of_on(of)->event);
 
 	ops = kernfs_ops(of->kn);
 	if (ops->read)
@@ -584,7 +558,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	struct mutex *mutex = NULL;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
-	on = kernfs_deref_open_node_protected(kn);
+	on = kernfs_deref_open_node_locked(kn);
 
 	if (on) {
 		list_add_tail(&of->list, &on->files);
@@ -629,7 +603,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 
-	on = kernfs_deref_open_node_protected(kn);
+	on = kernfs_deref_open_node_locked(kn);
 	if (!on) {
 		mutex_unlock(mutex);
 		return;
@@ -839,7 +813,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 		return;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
-	on = kernfs_deref_open_node_protected(kn);
+	on = kernfs_deref_open_node_locked(kn);
 	if (!on) {
 		mutex_unlock(mutex);
 		return;
@@ -874,11 +848,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
  */
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
-	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
-	struct kernfs_open_node *on = kernfs_deref_open_node(of, kn);
-
-	if (!on)
-		return EPOLLERR;
+	struct kernfs_open_node *on = of_on(of);
 
 	poll_wait(of->file, &on->poll, wait);
 
-- 
2.37.2

