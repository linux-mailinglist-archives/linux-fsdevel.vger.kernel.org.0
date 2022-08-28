Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E4C5A3BE9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 07:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiH1FFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 01:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiH1FFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:05:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5541C1AF1A;
        Sat, 27 Aug 2022 22:05:03 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mj6so31846pjb.1;
        Sat, 27 Aug 2022 22:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=Dk8UIs/c+CLgPEHFmonIUx+xfGZCTd8TAowD0oryF0c=;
        b=Giww/iA74FMuP7airt9dHd03zh+Hbm7d4y3XijdLQJgvDDQPRk6SCS/iofam5a4i9r
         nldWSqpdB0PT5Sfu2H0UAfkyGJ7s7kAfV2PCHrJxBZNTAel9dz+IJZ2yk4gxGK2mmvvU
         MXaCOhlcmWIGGl0LBmoOo1XHcXlzr8pP2k9h679wV89tFpBY3RLB/Um+HgF6mokomlT/
         glbaNJyCTCujnSFZCn16iO2mIZLINnPxTgZsuDtD1gOB0Sx9+iXH5VCnve/dXj8007Pb
         8Y+GiUXZzICA8so7z5dVxnBSiGpevGE6idbGdN98b+LMpKs15J1SHBWY25mUJP0DutHB
         ZXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=Dk8UIs/c+CLgPEHFmonIUx+xfGZCTd8TAowD0oryF0c=;
        b=UDs1p3hD+J2TV7sUhm5nAzG/8W6+PK+4GB9qj5zJfH72EVJMiDPVThzJy5G1+D8tbb
         pIROnIowmWXc0O9GnUFNx3+Kdd/wWQJRDi2+E2rdqap6pKCxOwsEiPvBTRyaxJ1AZUkC
         jP2yY1Q9Amk9H0xVb+7tWgtVR3ngILU+JExdmNnU7i9LH8xQjOhRQDtoVy47q6wQAnDr
         o6xo0mn+EF/3QKmMVLs7WkBj7oE+7S09zG6kPFluR35Ugo2Wi7a6qaGedE7uT2tDwwfT
         f7luIjxKtDxeSG0MPIb38BnSCcy05MVbsOfiqP82j3xt/c4avYHGHjsoeQEOmXT6fWbl
         3j2w==
X-Gm-Message-State: ACgBeo0JpP7lPW11CC2kPeY9J9e8mKSCK8BJ9QL/oBafsFR16XtPvl54
        OGy7hrvm5xkDcrxcd4eS5dw=
X-Google-Smtp-Source: AA6agR7KZ65I/MvGY4mknkkMovblc4YfdtX2xlYVhBkAo4HYWCV9tE/cJHdnQPl2pXLGEIdQWs9gyg==
X-Received: by 2002:a17:903:18a:b0:16f:8a63:18fe with SMTP id z10-20020a170903018a00b0016f8a6318femr11068503plg.174.1661663102281;
        Sat, 27 Aug 2022 22:05:02 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090a67ca00b001fa79c1de15sm4197612pjm.24.2022.08.27.22.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:05:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/9] kernfs: Add KERNFS_REMOVING flags
Date:   Sat, 27 Aug 2022 19:04:37 -1000
Message-Id: <20220828050440.734579-7-tj@kernel.org>
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

KERNFS_ACTIVATED tracks whether a given node has ever been activated. As a
node was only deactivated on removal, this was used for

 1. Drain optimization (removed by the previous patch).
 2. To hide !activated nodes
 3. To avoid double activations
 4. Reject adding children to a node being removed
 5. Skip activaing a node which is being removed.

We want to decouple deactivation from removal so that nodes can be
deactivated and hidden dynamically, which makes KERNFS_ACTIVATED useless for
all of the above purposes.

#1 is already gone. #2 and #3 can instead test whether the node is currently
active. A new flag KERNFS_REMOVING is added to explicitly mark nodes which
are being removed for #4 and #5.

While this leaves KERNFS_ACTIVATED with no users, leave it be as it will be
used in a following patch.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/kernfs/dir.c        | 21 +++++++--------------
 include/linux/kernfs.h |  1 +
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index b3d2018a334d..f8cbd05e9b68 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -705,13 +705,7 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 			goto err_unlock;
 	}
 
-	/*
-	 * ACTIVATED is protected with kernfs_mutex but it was clear when
-	 * @kn was added to idr and we just wanna see it set.  No need to
-	 * grab kernfs_mutex.
-	 */
-	if (unlikely(!(kn->flags & KERNFS_ACTIVATED) ||
-		     !atomic_inc_not_zero(&kn->count)))
+	if (unlikely(!kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
 	spin_unlock(&kernfs_idr_lock);
@@ -753,10 +747,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		goto out_unlock;
 
 	ret = -ENOENT;
-	if (parent->flags & KERNFS_EMPTY_DIR)
-		goto out_unlock;
-
-	if ((parent->flags & KERNFS_ACTIVATED) && !kernfs_active(parent))
+	if (parent->flags & (KERNFS_REMOVING | KERNFS_EMPTY_DIR))
 		goto out_unlock;
 
 	kn->hash = kernfs_name_hash(kn->name, kn->ns);
@@ -1336,7 +1327,7 @@ void kernfs_activate(struct kernfs_node *kn)
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
-		if (pos->flags & KERNFS_ACTIVATED)
+		if (kernfs_active(pos) || (pos->flags & KERNFS_REMOVING))
 			continue;
 
 		WARN_ON_ONCE(pos->parent && RB_EMPTY_NODE(&pos->rb));
@@ -1368,11 +1359,13 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 	pr_debug("kernfs %s: removing\n", kn->name);
 
-	/* prevent any new usage under @kn by deactivating all nodes */
+	/* prevent new usage by marking all nodes removing and deactivating */
 	pos = NULL;
-	while ((pos = kernfs_next_descendant_post(pos, kn)))
+	while ((pos = kernfs_next_descendant_post(pos, kn))) {
+		pos->flags |= KERNFS_REMOVING;
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
+	}
 
 	/* deactivate and unlink the subtree node-by-node */
 	do {
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 367044d7708c..b77d257c1f7e 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -112,6 +112,7 @@ enum kernfs_node_flag {
 	KERNFS_SUICIDED		= 0x0800,
 	KERNFS_EMPTY_DIR	= 0x1000,
 	KERNFS_HAS_RELEASE	= 0x2000,
+	KERNFS_REMOVING		= 0x4000,
 };
 
 /* @flags for kernfs_create_root() */
-- 
2.37.2

