Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4902A739C23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 11:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjFVJGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 05:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjFVJEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:04:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A2149EF
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:58:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b693afe799so2466825ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424252; x=1690016252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpqAnPCFjvBxCUJyQNRij7IdVYJH6Jib7EICYqtSs4Q=;
        b=I9WP6mv1rDRCGtgaLzA9lhBXeFPAHaj8y0iyY2DOjVEWCsT2F7nfNJVwyIikm+kMao
         zO6QJGdxbeP+Xd2yLUuD3B5OfZQRm3B4q5mm2BLvCFNnuFgYbDreBXTpY911jw5PjLjw
         5qBcX7//daeu9fw2bM5v9uWJQ3Yj963JAAdMROcF9Ug6KJW+BwPKjtr4qnEx+svXyNj4
         WQtBJXjBe1rX51UFB2Mb+BbnprNNOvKWLYHk9IXF69UQEETABYtrhl0ZHyku4x/+376s
         ovmIBUSgYXrVJUG8L2WcJE6QBBiCJCq44tzgQbbUxJYU3EpXiLR3t2TzR3wvfdUTA7wG
         r7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424252; x=1690016252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpqAnPCFjvBxCUJyQNRij7IdVYJH6Jib7EICYqtSs4Q=;
        b=jxSEcUWfhlRpAmMdt1qt1BG81KNOl1fDVx2Puo5S79vq5nwuBTUWkgQY7ULOPEDZCf
         E2J2Q8mpxUyPJOFJlByS792n9ZweGbV74otpuJ1LMtJWtFhQXpfEpGZLcohgzAvxURtN
         TEbZt+EFCNABxlgjz9L+OvpJRWOBqI+hGXVp6F0LBNO7KT0r769Zf2OEy1sH6skjwQgt
         Gy/8/+58LYPEViFJsoaSNKHtM+o9JKDnJqzgkWydmdyrh80jhzRCRv0gR7raUEowPQgQ
         iyJ4jEtlCMvGZ7MyTT8aepq6/buRrLKhLBVTFTos74/LS3FGi6Naa8Su2Z/5gcFl6U2p
         Qczg==
X-Gm-Message-State: AC+VfDy7fx53HF54CABBqAmAwJTIvIQOlBMrVjbZJ3ZuHkTvYusoUFGU
        k+TVj4tgJJ2hC/GTNWAwv7IU9g==
X-Google-Smtp-Source: ACHHUZ6FoF5W+f0N2ZUpFBUVBh1vs3Mj6G9dcM80ve0PhcTP+4niqZQRBrFmYJGvwbhs9MGB3E6MuA==
X-Received: by 2002:a17:903:32c4:b0:1b3:e352:6d88 with SMTP id i4-20020a17090332c400b001b3e3526d88mr21673124plr.6.1687424251794;
        Thu, 22 Jun 2023 01:57:31 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:57:31 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 26/29] mm: shrinker: make count and scan in shrinker debugfs lockless
Date:   Thu, 22 Jun 2023 16:53:32 +0800
Message-Id: <20230622085335.77010-27-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like global and memcg slab shrink, also make count and scan
operations in memory shrinker debugfs lockless.

The debugfs_remove_recursive() will wait for debugfs_file_put()
to return, so there is no need to call rcu_read_lock() before
calling shrinker_try_get().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker_debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 3ab53fad8876..c18fa9b6b7f0 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -55,8 +55,8 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	if (!count_per_node)
 		return -ENOMEM;
 
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret) {
+	ret = shrinker_try_get(shrinker);
+	if (!ret) {
 		kfree(count_per_node);
 		return ret;
 	}
@@ -92,7 +92,7 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
 	rcu_read_unlock();
-	up_read(&shrinker_rwsem);
+	shrinker_put(shrinker);
 
 	kfree(count_per_node);
 	return ret;
@@ -146,8 +146,8 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		return -EINVAL;
 	}
 
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret) {
+	ret = shrinker_try_get(shrinker);
+	if (!ret) {
 		mem_cgroup_put(memcg);
 		return ret;
 	}
@@ -159,7 +159,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 
 	shrinker->scan_objects(shrinker, &sc);
 
-	up_read(&shrinker_rwsem);
+	shrinker_put(shrinker);
 	mem_cgroup_put(memcg);
 
 	return size;
-- 
2.30.2

