Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E415A3BEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 07:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiH1FFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 01:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiH1FFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:05:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445A915719;
        Sat, 27 Aug 2022 22:05:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so1241934pjq.3;
        Sat, 27 Aug 2022 22:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=cLGQY4TMmERTL6YeLGTqdka+ZPGW9a/P3+vJTv296BA=;
        b=AFlr7fvoyzzbc+TOpmLEXIrStJx5z94G57CBoB8fpxdr+SI24UZQCnoWHwf/NDCE9G
         6GALJazJOUEpXNSJ5d3o/xXC11z3yBx3Y+W6MkrHpNOjy1Iz7iMpACyVYUmlE/4Ect3M
         Tgk4TLhLo3wkk4p/zSEPk8RbMqi9EEuGohAIDg3WR5sLpRytMDLbXvjq3rxr5grlE9JP
         dkDxHnaiRU8sBzyUc1hNVBUCoQdahiw2kb7FKEKKXkCOm32QI1zE9s0Leni6CkKQDzDj
         kfn1TNB2/XLve7+5ZsdDUPu8Sjbm6gdi2N4ppYukcWDLgILhvsFBO10x9jNSfmV5TUxq
         /0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=cLGQY4TMmERTL6YeLGTqdka+ZPGW9a/P3+vJTv296BA=;
        b=K5jQeZ531R3Wz/yEQ+HG9gc0xHgJO7R9/uzU0DFrVDFfCe+OD9RCYAZAfBOXllhdGA
         OinVPIQfVkILn5Vwr6j1jOeMQdsARuoDouRbYNygO22l/FhdPGan9nozyeMs+b+uJL7c
         1D3ytLm88IgvVb1CixmFAMWPCUGjfrd07X7bIExZtuJKr37VFd3iuKTqw/TZY7SIb4jQ
         WomP0wpRVyhlzDh0BBVFR2IC8ImWckfDIKCgSU2gd/1bW2JhWcrEkU6ScLGV83XMr5Gl
         NE9P894YD3vW3I271fAUKyy9KsAjYre/okKG9KUMbMALcgGv+0FUO0LkrqAD4UdXDL63
         pTBQ==
X-Gm-Message-State: ACgBeo3RFBPYnBvXb2Dnk86YzLKGlXWqTAdZJo+58zulROfLtZhRr8OL
        aJWe1Awn83dMAXmRTlUmTqc=
X-Google-Smtp-Source: AA6agR6Vpe2djWfMBmtzdBUcSToVljrstjLkrIWFZqlSqRFxdWww6PrmAhM4uzhM3yLjR7Fw6OqkRQ==
X-Received: by 2002:a17:903:1c8:b0:171:2ed3:6780 with SMTP id e8-20020a17090301c800b001712ed36780mr11172856plh.30.1661663105841;
        Sat, 27 Aug 2022 22:05:05 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0015e8d4eb1d5sm2620253pla.31.2022.08.27.22.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:05:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 8/9] kernfs: Implement kernfs_show()
Date:   Sat, 27 Aug 2022 19:04:39 -1000
Message-Id: <20220828050440.734579-9-tj@kernel.org>
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

Currently, kernfs nodes can be created hidden and activated later by calling
kernfs_activate() to allow creation of multiple nodes to succeed or fail as
a unit. This is an one-way one-time-only transition. This patch introduces
kernfs_show() which can toggle visibility dynamically.

As the currently proposed use - toggling the cgroup pressure files - only
requires operating on leaf nodes, for the sake of simplicity, restrict it as
such for now.

Hiding uses the same mechanism as deactivation and likewise guarantees that
there are no in-flight operations on completion. KERNFS_ACTIVATED and
KERNFS_HIDDEN are used to manage the interactions between activations and
show/hide operations. A node is visible iff both activated & !hidden.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/kernfs/dir.c        | 37 ++++++++++++++++++++++++++++++++++++-
 include/linux/kernfs.h |  2 ++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index c9323956c63c..7fb5a72cc96d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1311,7 +1311,7 @@ static void kernfs_activate_one(struct kernfs_node *kn)
 
 	kn->flags |= KERNFS_ACTIVATED;
 
-	if (kernfs_active(kn) || (kn->flags & KERNFS_REMOVING))
+	if (kernfs_active(kn) || (kn->flags & (KERNFS_HIDDEN | KERNFS_REMOVING)))
 		return;
 
 	WARN_ON_ONCE(kn->parent && RB_EMPTY_NODE(&kn->rb));
@@ -1347,6 +1347,41 @@ void kernfs_activate(struct kernfs_node *kn)
 	up_write(&root->kernfs_rwsem);
 }
 
+/**
+ * kernfs_show - show or hide a node
+ * @kn: kernfs_node to show or hide
+ * @show: whether to show or hide
+ *
+ * If @show is %false, @kn is marked hidden and deactivated. A hidden node is
+ * ignored in future activaitons. If %true, the mark is removed and activation
+ * state is restored. This function won't implicitly activate a new node in a
+ * %KERNFS_ROOT_CREATE_DEACTIVATED root which hasn't been activated yet.
+ *
+ * To avoid recursion complexities, directories aren't supported for now.
+ */
+void kernfs_show(struct kernfs_node *kn, bool show)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+
+	if (WARN_ON_ONCE(kernfs_type(kn) == KERNFS_DIR))
+		return;
+
+	down_write(&root->kernfs_rwsem);
+
+	if (show) {
+		kn->flags &= ~KERNFS_HIDDEN;
+		if (kn->flags & KERNFS_ACTIVATED)
+			kernfs_activate_one(kn);
+	} else {
+		kn->flags |= KERNFS_HIDDEN;
+		if (kernfs_active(kn))
+			atomic_add(KN_DEACTIVATED_BIAS, &kn->active);
+		kernfs_drain(kn);
+	}
+
+	up_write(&root->kernfs_rwsem);
+}
+
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index b77d257c1f7e..73f5c120def8 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -108,6 +108,7 @@ enum kernfs_node_flag {
 	KERNFS_HAS_SEQ_SHOW	= 0x0040,
 	KERNFS_HAS_MMAP		= 0x0080,
 	KERNFS_LOCKDEP		= 0x0100,
+	KERNFS_HIDDEN		= 0x0200,
 	KERNFS_SUICIDAL		= 0x0400,
 	KERNFS_SUICIDED		= 0x0800,
 	KERNFS_EMPTY_DIR	= 0x1000,
@@ -430,6 +431,7 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 				       const char *name,
 				       struct kernfs_node *target);
 void kernfs_activate(struct kernfs_node *kn);
+void kernfs_show(struct kernfs_node *kn, bool show);
 void kernfs_remove(struct kernfs_node *kn);
 void kernfs_break_active_protection(struct kernfs_node *kn);
 void kernfs_unbreak_active_protection(struct kernfs_node *kn);
-- 
2.37.2

