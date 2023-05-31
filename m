Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69E5717CB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 12:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbjEaKE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 06:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbjEaKEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 06:04:21 -0400
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0386E5
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 03:04:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685527112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ES1OZTmJM6HPZiOufnJqkIPYyFHG+uxk+XMAxdW/H0=;
        b=pME7V5sghWDhiBYKlYhlIGGcd+I8ZIhtp+E9A11aBMxPx6kduDLdGh2+5uOlz/UhrC8USH
        AInETjEYhvnYApFG/QCWzh1ONDgIapx8Zsu0DP7P6tbY+y9jVOZnflKJtLkCkwkXmah55p
        +X/uwLrssbh7WgAqh01669o0MFk+pHM=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 4/8] fs: shrink only (SB_ACTIVE|SB_BORN) superblocks in super_cache_scan()
Date:   Wed, 31 May 2023 09:57:38 +0000
Message-Id: <20230531095742.2480623-5-qi.zheng@linux.dev>
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

This patch prepares superblock shrinker for delayed unregistering.
It makes super_cache_scan() avoid shrinking of not active superblocks.
SB_ACTIVE is used as such the indicator. In case of superblock is not
active, super_cache_scan() just exits with SHRINK_STOP as result.

Note, that SB_ACTIVE is cleared in generic_shutdown_super() and this
is made under the write lock of s_umount. Function super_cache_scan()
also takes the read lock of s_umount, so it can't skip this flag cleared.

SB_BORN check is added to super_cache_scan() just for uniformity
with super_cache_count(), while super_cache_count() received SB_ACTIVE
check just for uniformity with super_cache_scan().

After this patch super_cache_scan() becomes to ignore unregistering
superblocks, so this function is OK with splitting unregister_shrinker().
Next patches prepare super_cache_count() to follow this way.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/super.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 2ce4c72720f3..2ce54561e82e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -79,6 +79,11 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	if (!trylock_super(sb))
 		return SHRINK_STOP;
 
+	if ((sb->s_flags & (SB_BORN|SB_ACTIVE)) != (SB_BORN|SB_ACTIVE)) {
+		freed = SHRINK_STOP;
+		goto unlock;
+	}
+
 	if (sb->s_op->nr_cached_objects)
 		fs_objects = sb->s_op->nr_cached_objects(sb, sc);
 
@@ -110,6 +115,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 		freed += sb->s_op->free_cached_objects(sb, sc);
 	}
 
+unlock:
 	up_read(&sb->s_umount);
 	return freed;
 }
@@ -136,7 +142,7 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	 * avoid this situation, so do the same here. The memory barrier is
 	 * matched with the one in mount_fs() as we don't hold locks here.
 	 */
-	if (!(sb->s_flags & SB_BORN))
+	if ((sb->s_flags & (SB_BORN|SB_ACTIVE)) != (SB_BORN|SB_ACTIVE))
 		return 0;
 	smp_rmb();
 
-- 
2.30.2

