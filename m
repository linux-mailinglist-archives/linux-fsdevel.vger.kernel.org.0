Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC91959A9DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 02:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244382AbiHTAGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 20:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244345AbiHTAGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:06:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61FC57B6;
        Fri, 19 Aug 2022 17:06:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h28so5589605pfq.11;
        Fri, 19 Aug 2022 17:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=AERyVPp0aIIpnzNRwhJB17x8x5LyrI6Aaxeip9H6oCA=;
        b=ggmC0fr0r3UI7gdFZK3Xh43gi58dZvPVKLx+1hGjFtvg7MkX68E8TQsS28B6KvahsY
         2h6s4UQ4qBVAKBqH2T5MBvcVUzwu/hLnacrYC37A5Fq4mjyGvo/UxV5BbiRtF0EcRIHn
         u/xvZ4mVWqx2da2Fkel32BApfUe9h89Ql7NjQQyCpdh5QurgQBd8wChSxrm/H0LBMBOk
         Z+oQMk9jT2Cf6GMDWzwiyWg6cP2tzMUB/Qz95Hc7qa8K0mDuUVkdB7oV5V4WkQgx3+0s
         CextOmvJPrUM3BuxoIUHj60A3ds/DKzGF9Jx0y2tz7MjbtmDeJk7VYDfndHfcgiKGm8O
         FQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=AERyVPp0aIIpnzNRwhJB17x8x5LyrI6Aaxeip9H6oCA=;
        b=ncHez03Zb1COPM29sIPDWZHNBheumU2E0AB1n+PNi+ShkNFyX83n4Qy1eytA+Bkbp0
         NzfVgw8RNLoMFpmH1irlUFu+5Ixj3Y65JQ8XGFUEWBzQhxdHItZ1WKu8qz1COj0Saxez
         mHQ5nXsDN/Is+Un2xsaJejSW0523K17065eg9DSe1bvgADB1UIj5GKEJhJNXGh0WOIA7
         RsnUz9kL4hSwUvAt0v8SNZHDZa33ccQL5qdD8JcDo/h2h7IyKnqQF1X1Ql05TwwFsBMz
         NRwoUpxP4RPbG7TJbQnRhpxwoR/ukg29vgUEEtHoV1E3PvWpjRWLm71EfzV+Zv1XofkQ
         mP9Q==
X-Gm-Message-State: ACgBeo2fDsT3ibQm3lBvfw1OEdcZSpqVfoSMDWPEEBwDkXabsDsuT9g/
        94uuwhNyu/7Hpz4RWUPkrwg=
X-Google-Smtp-Source: AA6agR6jsejD4MUpvfYtdAIlc96IJdJB//MpwKCmycFY8a7T6uDqh4sYWYJU7BwFtXlqADIjp0WnMA==
X-Received: by 2002:a05:6a00:15c5:b0:536:1bac:6469 with SMTP id o5-20020a056a0015c500b005361bac6469mr4146720pfu.30.1660953963140;
        Fri, 19 Aug 2022 17:06:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a2f5])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b00172709064besm3691932plb.46.2022.08.19.17.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 17:06:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/7] kernfs: Simply by replacing kernfs_deref_open_node() with of_on()
Date:   Fri, 19 Aug 2022 14:05:45 -1000
Message-Id: <20220820000550.367085-2-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820000550.367085-1-tj@kernel.org>
References: <20220820000550.367085-1-tj@kernel.org>
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

