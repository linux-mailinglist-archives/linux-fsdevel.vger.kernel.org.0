Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27226287002
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgJHHyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgJHHyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:21 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F03C0613D2;
        Thu,  8 Oct 2020 00:54:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so3571836pgb.10;
        Thu, 08 Oct 2020 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+sV95vA2BDTcBvqCnGOEpgiyhXPcFlSLw1X7ElmDJgI=;
        b=sND/U8OEe6GU6RkIumK8RwtOKOvmzscP48r+GyA7ruj9/ehlYV2Wf8uuh+4YdmvBrP
         tKgMYCzILANziQBYJfA4FaB9t5pm7G3KdGGrqUPsCQWcFXyBpX/00Ftn27V+r8coIpCQ
         n6pYYalt7QUZcbKpzsYxuiulIOzfiBrS2L/CYJHFNDGULtfMCCsRURy6HMDvt7ng7jKc
         9YRT4OJWgBWyaExro9EIGGXvYdS3KnOYF0Hw8MMI43/FP8eI0IGEqNJPnRBaVAouzxYF
         kjXQfQzVZ2lTpHHmLOOtgU0Q+zj+tXyfLk5iPm0CRvLNxDyYObv9tWBH33WTp1FANTTf
         ws8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+sV95vA2BDTcBvqCnGOEpgiyhXPcFlSLw1X7ElmDJgI=;
        b=V5Apqs1atWmnZ314dZTvcwniK+tZSrz1SRmEDq9SusQpKmm8gmne6uSVMq/SwpZZmX
         jH456op8UIBExGDY6VXe/Q/Lv+oyaR++5tGhim+Ynd78urxf+3ZF+3sqwePLg9s5Wh7i
         yRcfamf9kp21A5rHPbHaDbl7y+ORWzbuXL8HYJMoQLa76m8ChgNG3K/9/VsEV/LNxJrt
         O6wzMo/PvuVi0u1m7AsuX8aGdP6x6PHKrr+0fXWMwyr5tugRBomUyltIbTlOpUL02D3j
         yDgeWJGUyF3CtbEEtor9cM5DIks8E+JcNNT+kDJ1hvKtvr+st8ZaNGm3qaWY4NP2VBt0
         1bRw==
X-Gm-Message-State: AOAM532qDrSI7tSBmF3qPJlBLE9iTxuWYjyrL3d3aiwrS5fstU6b0vMZ
        3EtROjLEVb5BgNr7bPgYA0U=
X-Google-Smtp-Source: ABdhPJwE2e7CNavbiBISV2NjA6SfUvI+81Hi54CJJ1evij31Sib3fuZDPmy/ahgLBeekOnZBrmHqqA==
X-Received: by 2002:a63:5d08:: with SMTP id r8mr6229132pgb.174.1602143659882;
        Thu, 08 Oct 2020 00:54:19 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:54:19 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [PATCH 08/35] dmem: show some statistic in debugfs
Date:   Thu,  8 Oct 2020 15:53:58 +0800
Message-Id: <c53436d969cd70fd67b3eb8e02b75e138c364e91.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Create 'dmem' directory under debugfs and show some
statistic for dmem pool, track total and free dpages
on dmem pool and each numa node.

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 mm/Kconfig |   9 +++++
 mm/dmem.c  | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index e1995da11cea..8a67c8933a42 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -235,6 +235,15 @@ config DMEM
 	  Allow reservation of memory which could be dedicated usage of dmem.
 	  It's the basics of dmemfs.
 
+config DMEM_DEBUG_FS
+	bool "Enable debug information for direct memory"
+	depends on DMEM && DEBUG_FS
+	def_bool n
+	help
+	  This option enables showing various statistics of direct memory
+	  in debugfs filesystem.
+
+#
 # support for memory compaction
 config COMPACTION
 	bool "Allow for memory compaction"
diff --git a/mm/dmem.c b/mm/dmem.c
index aa34bf20f830..6992e57d5df0 100644
--- a/mm/dmem.c
+++ b/mm/dmem.c
@@ -164,6 +164,103 @@ int dmem_region_register(int node, phys_addr_t start, phys_addr_t end)
 	return 0;
 }
 
+#ifdef CONFIG_DMEM_DEBUG_FS
+struct debugfs_entry {
+	const char *name;
+	unsigned long offset;
+};
+
+#define DMEM_POOL_OFFSET(x)	offsetof(struct dmem_pool, x)
+#define DMEM_POOL_ENTRY(x)	{__stringify(x), DMEM_POOL_OFFSET(x)}
+
+#define DMEM_NODE_OFFSET(x)	offsetof(struct dmem_node, x)
+#define DMEM_NODE_ENTRY(x)	{__stringify(x), DMEM_NODE_OFFSET(x)}
+
+static struct debugfs_entry dmem_pool_entries[] = {
+	DMEM_POOL_ENTRY(region_num),
+	DMEM_POOL_ENTRY(registered_pages),
+	DMEM_POOL_ENTRY(unaligned_pages),
+	DMEM_POOL_ENTRY(dpage_shift),
+	DMEM_POOL_ENTRY(total_dpages),
+	DMEM_POOL_ENTRY(free_dpages),
+};
+
+static struct debugfs_entry dmem_node_entries[] = {
+	DMEM_NODE_ENTRY(total_dpages),
+	DMEM_NODE_ENTRY(free_dpages),
+};
+
+static int dmem_entry_get(void *offset, u64 *val)
+{
+	*val = *(u64 *)offset;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(dmem_fops, dmem_entry_get, NULL, "%llu\n");
+
+static int dmemfs_init_debugfs_node(struct dmem_node *dnode,
+				    struct dentry *parent)
+{
+	struct dentry *node_dir;
+	char dir_name[32];
+	int i, ret = -EEXIST;
+
+	snprintf(dir_name, sizeof(dir_name), "node%ld",
+		 dnode - dmem_pool.nodes);
+	node_dir = debugfs_create_dir(dir_name, parent);
+	if (!node_dir)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(dmem_node_entries); i++)
+		if (!debugfs_create_file(dmem_node_entries[i].name, 0444,
+		   node_dir, (void *)dnode + dmem_node_entries[i].offset,
+		   &dmem_fops))
+			return ret;
+	return 0;
+}
+
+static int dmemfs_init_debugfs(void)
+{
+	struct dentry *dmem_debugfs_dir;
+	struct dmem_node *dnode;
+	int i, ret = -EEXIST;
+
+	dmem_debugfs_dir = debugfs_create_dir("dmem", NULL);
+	if (!dmem_debugfs_dir)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(dmem_pool_entries); i++)
+		if (!debugfs_create_file(dmem_pool_entries[i].name, 0444,
+		   dmem_debugfs_dir,
+		   (void *)&dmem_pool + dmem_pool_entries[i].offset,
+		   &dmem_fops))
+			goto exit;
+
+	for_each_dmem_node(dnode) {
+		/*
+		 * do not create debugfs files for the node
+		 * where no memory is available
+		 */
+		if (list_empty(&dnode->regions))
+			continue;
+
+		if (dmemfs_init_debugfs_node(dnode, dmem_debugfs_dir))
+			goto exit;
+	}
+
+	return 0;
+exit:
+	debugfs_remove_recursive(dmem_debugfs_dir);
+	return ret;
+}
+
+#else
+static int dmemfs_init_debugfs(void)
+{
+	return 0;
+}
+#endif
+
 #define PENALTY_FOR_DMEM_SHARED_NODE		(1)
 
 static int dmem_nodeload[MAX_NUMNODES] __initdata;
@@ -364,7 +461,8 @@ static int __init dmem_late_init(void)
 				goto exit;
 		}
 	}
-	return ret;
+
+	return dmemfs_init_debugfs();
 exit:
 	dmem_uinit();
 	return ret;
-- 
2.28.0

