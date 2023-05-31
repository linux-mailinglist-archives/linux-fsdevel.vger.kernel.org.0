Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9488C717CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 12:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjEaKE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 06:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbjEaKEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 06:04:23 -0400
Received: from out-60.mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31135113
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 03:04:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685527129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjcsinqX7KwTJ40/JcL+JgGM2W0swatrtd18npIFtVk=;
        b=baMB2GLVbbUmgLTp+CUXyhhVv/9x56bQV3iqZ8MjrGpSa7p5jatJsXPULpCV9EV8+jBrYl
        PchelLFH6ZF8vYpgvhoNebbx99TRM79XB4NftLwSZ90r/JoVrRMdf+o3xlQ1brouvtCBtm
        EjXCENjNIePsNVRgiPye7pdqlsEyPGs=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 8/8] fs: use unregister_shrinker_delayed_{initiate, finalize} for super_block shrinker
Date:   Wed, 31 May 2023 09:57:42 +0000
Message-Id: <20230531095742.2480623-9-qi.zheng@linux.dev>
In-Reply-To: <20230531095742.2480623-1-qi.zheng@linux.dev>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kirill Tkhai <tkhai@ya.ru>

Previous patches made all the data, which is touched from
super_cache_count(), destroyed from destroy_super_work():
s_dentry_lru, s_inode_lru and super_block::s_fs_info.

super_cache_scan() can't be called after SB_ACTIVE is cleared
in generic_shutdown_super().

So, it safe to move heavy unregister_shrinker_delayed_finalize()
part to delayed work, i.e. it's safe for parallel do_shrink_slab()
to be executed between unregister_shrinker_delayed_initiate() and
destroy_super_work()->unregister_shrinker_delayed_finalize().

This makes the heavy synchronize_srcu() to do not affect on user-visible
unregistration speed (since now it's executed from workqueue).

All further time-critical for unregistration places may be written
in the same conception.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/super.c         | 4 +++-
 include/linux/fs.h | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 4e9d08224f86..c61efb74fa7f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -165,6 +165,8 @@ static void destroy_super_work(struct work_struct *work)
 							destroy_work);
 	int i;
 
+	unregister_shrinker_delayed_finalize(&s->s_shrink);
+
 	WARN_ON(list_lru_count(&s->s_dentry_lru));
 	WARN_ON(list_lru_count(&s->s_inode_lru));
 	list_lru_destroy(&s->s_dentry_lru);
@@ -337,7 +339,7 @@ void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
-		unregister_shrinker(&s->s_shrink);
+		unregister_shrinker_delayed_initiate(&s->s_shrink);
 		fs->kill_sb(s);
 
 		put_filesystem(fs);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 30b46d0facfc..869dd8de91a5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1929,6 +1929,11 @@ struct super_operations {
 	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
 	struct dquot **(*get_dquots)(struct inode *);
 #endif
+	/*
+	 * Shrinker may call these two function on destructing super_block
+	 * till unregister_shrinker_delayed_finalize() has completed
+	 * in destroy_super_work(), and they must care about that.
+	 */
 	long (*nr_cached_objects)(struct super_block *,
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
-- 
2.30.2

