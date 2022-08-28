Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670195A3BF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 07:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiH1FFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 01:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiH1FFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:05:03 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82DB1A07E;
        Sat, 27 Aug 2022 22:05:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 202so4949994pgc.8;
        Sat, 27 Aug 2022 22:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=eAa5HEKE+o5FsXIHsbV6GktX/mjE+Q7EtAaHHBP/NgU=;
        b=EaAnhadE+lQftg6TG2aEEa66PxaP2fmVaV6IQhkolpJ/PntxNcFrahHdMWNwNyAts/
         eJu9A5cb4gE+NgRF8LsmQScd7m+7brVdscTSZW348OxG5oDVYTuJVNuq9tGgAX6xkgUN
         t6LMgT6mSq+IBqQd5iQwu26FCiU03qywZzFTEr448tUIXIEEmF/1IJFVyOs+MXHp/aJu
         MRPosjgwBWr0i1lZVuTACF0j4HFTxVyl7hoTh9z6SQCnzROBuY0NEVNsx6fR1+3hMhZo
         MpeMvxaaP+rcEF7wKyfkg2edo0JhuDk02vRabn6Pyxuoo5sOwuAv2iCwCcd+feks1iKv
         EjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=eAa5HEKE+o5FsXIHsbV6GktX/mjE+Q7EtAaHHBP/NgU=;
        b=0n9/5Nrh2FWEoLi76xwxv/2XTHONgO95jYXzlFI+u+TT46OekeJLOhDftqOWNzU/Ru
         IBd+0KVsyChN2ACgv+ETr+Kh0HRVZdf3eErrs7ZncwQQFhEme6SgwBXQN+lag441w3YD
         ZR+XYLKEL9T9PkaRPnuDUD7oNRN/2+KGhHFeM90C4phjxyxHHcGESnTbpvtz8ydoCBsI
         0jItpCmLE7e4yVytb0Dsl2h7pESsHL3eACAYwnCzZs+5a7cU9sn7C16wfiNqdAzYfaGr
         m10xcRIt8PgIV5lylTwVHouaH92wIwNLJLL1LdaqwI4RmLTAxwOlYX830l2vWU/Yoxc+
         +wkg==
X-Gm-Message-State: ACgBeo3xPlTcqG0c5VHnaCcD67shfnwE0Q57AHQrAeY6zyowJ8EiqWzC
        LpP1kd20Y9DqKdCXbp5JSkU=
X-Google-Smtp-Source: AA6agR6K8O4XiErHMnaB4zNFbf9xKc+zZLLL5P7yNUiLMtq1IlI0eTs6r46Zw6Qhvx13WLxn7LgwuA==
X-Received: by 2002:a63:fb56:0:b0:429:983f:b91e with SMTP id w22-20020a63fb56000000b00429983fb91emr9281806pgj.399.1661663100499;
        Sat, 27 Aug 2022 22:05:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b001712c008f99sm4619764plh.11.2022.08.27.22.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:04:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/9] kernfs: Improve kernfs_drain() and always call on removal
Date:   Sat, 27 Aug 2022 19:04:36 -1000
Message-Id: <20220828050440.734579-6-tj@kernel.org>
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

__kernfs_remove() was skipping draining based on KERNFS_ACTIVATED - whether
the node has ever been activated since creation. Instead, update it to
always call kernfs_drain() which now drains or skips based on the precise
drain conditions. This ensures that the nodes will be deactivated and
drained regardless of their states.

This doesn't make meaningful difference now but will enable deactivating and
draining nodes dynamically by making removals safe when racing those
operations.

While at it, drop / update comments.

v2: Fix the inverted test on kernfs_should_drain_open_files() noted by
    Chengming. This was fixed by the next unrelated patch in the previous
    posting.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/kernfs/dir.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8ae44db920d4..b3d2018a334d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -472,6 +472,16 @@ static void kernfs_drain(struct kernfs_node *kn)
 	lockdep_assert_held_write(&root->kernfs_rwsem);
 	WARN_ON_ONCE(kernfs_active(kn));
 
+	/*
+	 * Skip draining if already fully drained. This avoids draining and its
+	 * lockdep annotations for nodes which have never been activated
+	 * allowing embedding kernfs_remove() in create error paths without
+	 * worrying about draining.
+	 */
+	if (atomic_read(&kn->active) == KN_DEACTIVATED_BIAS &&
+	    !kernfs_should_drain_open_files(kn))
+		return;
+
 	up_write(&root->kernfs_rwsem);
 
 	if (kernfs_lockdep(kn)) {
@@ -480,7 +490,6 @@ static void kernfs_drain(struct kernfs_node *kn)
 			lock_contended(&kn->dep_map, _RET_IP_);
 	}
 
-	/* but everyone should wait for draining */
 	wait_event(root->deactivate_waitq,
 		   atomic_read(&kn->active) == KN_DEACTIVATED_BIAS);
 
@@ -1370,23 +1379,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
-		 * kernfs_drain() drops kernfs_rwsem temporarily and @pos's
+		 * kernfs_drain() may drop kernfs_rwsem temporarily and @pos's
 		 * base ref could have been put by someone else by the time
 		 * the function returns.  Make sure it doesn't go away
 		 * underneath us.
 		 */
 		kernfs_get(pos);
 
-		/*
-		 * Drain iff @kn was activated.  This avoids draining and
-		 * its lockdep annotations for nodes which have never been
-		 * activated and allows embedding kernfs_remove() in create
-		 * error paths without worrying about draining.
-		 */
-		if (kn->flags & KERNFS_ACTIVATED)
-			kernfs_drain(pos);
-		else
-			WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
+		kernfs_drain(pos);
 
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
-- 
2.37.2

