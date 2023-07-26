Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6A6762FAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjGZIXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjGZIWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:22:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C366EA1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2683add3662so985788a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359024; x=1690963824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxj+btiC5bp07i0raCrQCISm2j0evx87VB7Ft6vQm0Y=;
        b=P+/0rgLtEdpbjzKqmA02o57JAFTpubjCpSW6mbosOnpFa92pkdk6Jcgr2NP/7Cwuqv
         X704pWI/GcFkT+iYFHPSJB4sqKMdrdQDbQO40IHz8iIVf4GjaTiv6wZEnyXnNguWrM+W
         x4jUL97/rQ4GOieM5c2xzpBxvTkZ6DSetuV5zIGVZqGZ2sm4rHt43AqEx6Fkn8k50sjH
         SRru4KNzIIA6FNTeYMNPz5gIVMHzVscuHdHd4gtKTsN9OUrOXGyDqcUS5HBnD3L+NgwX
         G5eGekoi/fvhPV5mfSGu8zzazu4u7WPmnD8TUvnKm5P2igUsV6DLAbGfvYr5+JXeQ9DH
         sPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359024; x=1690963824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxj+btiC5bp07i0raCrQCISm2j0evx87VB7Ft6vQm0Y=;
        b=TTmMVntD1+97hFVE3N7DlYiuFi1ah8g75hT7EwkDa3HR2rbSXvlWEgxlJckB+aWDqd
         16RbP8VUHfql4yzAPIxtY64061jkxdBvpB58tL5L5qMJDhGPBhTLuSmV0mroOUv6b2JF
         9Sc0KGU229OP9sSZTiRrY77cG1jjr7UGyBeb+plsZilVu0vPSdNBb02u5rUMN20MgTIJ
         0TfRK5CF0sn//IV24VxlI5LCkj/GkrgZ5McDFu8WoleMrmaDkpjDbuOeBuzkLF1wRrY2
         uS/Flv4O8K6HaibGDxPZxlcU8tCzwOUUYUHDOPAcQMZLOVU2L7GHCK0S3wS7Ml/yqaHS
         w7Ww==
X-Gm-Message-State: ABy/qLa4zjiR+i1Ce/v/us7366EmT6Dwulz9Maga6/N29HccMv/Z7ojn
        NFz6VCrU7DZKHBaYbm0/N6IEYw==
X-Google-Smtp-Source: APBJJlGlSCxdEfq1BDlME7pPijSE799iYFshp/KuL1hJgcfxhw5EPTeKsWGCQw9soPRWN5f9bpFYXQ==
X-Received: by 2002:a17:90b:1b4f:b0:25b:f66c:35a9 with SMTP id nv15-20020a17090b1b4f00b0025bf66c35a9mr1209893pjb.48.1690359024079;
        Wed, 26 Jul 2023 01:10:24 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.10.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:23 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 06/11] maple_tree: Introduce mas_replace_entry() to directly replace an entry
Date:   Wed, 26 Jul 2023 16:09:11 +0800
Message-Id: <20230726080916.17454-7-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If mas has located a specific entry, it may be need to replace this
entry, so introduce mas_replace_entry() to do this. mas_replace_entry()
will be more efficient than mas_store*() because it doesn't do many
unnecessary checks.

This function should be inline, but more functions need to be moved to
the header file, so I didn't do it for the time being.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/maple_tree.h |  1 +
 lib/maple_tree.c           | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 229fe78e4c89..a05e9827d761 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -462,6 +462,7 @@ struct ma_wr_state {
 
 void *mas_walk(struct ma_state *mas);
 void *mas_store(struct ma_state *mas, void *entry);
+void mas_replace_entry(struct ma_state *mas, void *entry);
 void *mas_erase(struct ma_state *mas);
 int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp);
 void mas_store_prealloc(struct ma_state *mas, void *entry);
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index efac6761ae37..d58572666a00 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5600,6 +5600,31 @@ void *mas_store(struct ma_state *mas, void *entry)
 }
 EXPORT_SYMBOL_GPL(mas_store);
 
+/**
+ * mas_replace_entry() - Replace an entry that already exists in the maple tree
+ * @mas: The maple state
+ * @entry: The entry to store
+ *
+ * Please note that mas must already locate an existing entry, and the new entry
+ * must not be NULL. If these two points cannot be guaranteed, please use
+ * mas_store*() instead, otherwise it will cause an internal error in the maple
+ * tree. This function does not need to allocate memory, so it must succeed.
+ */
+void mas_replace_entry(struct ma_state *mas, void *entry)
+{
+	void __rcu **slots;
+
+#ifdef CONFIG_DEBUG_MAPLE_TREE
+	MAS_WARN_ON(mas, !mte_is_leaf(mas->node));
+	MAS_WARN_ON(mas, !entry);
+	MAS_WARN_ON(mas, mas->offset >= mt_slots[mte_node_type(mas->node)]);
+#endif
+
+	slots = ma_slots(mte_to_node(mas->node), mte_node_type(mas->node));
+	rcu_assign_pointer(slots[mas->offset], entry);
+}
+EXPORT_SYMBOL_GPL(mas_replace_entry);
+
 /**
  * mas_store_gfp() - Store a value into the tree.
  * @mas: The maple state
-- 
2.20.1

