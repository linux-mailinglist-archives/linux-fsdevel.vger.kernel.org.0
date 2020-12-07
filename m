Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24672D0F2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgLGLeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgLGLee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:34 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C9C061A51;
        Mon,  7 Dec 2020 03:33:54 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w16so8638803pga.9;
        Mon, 07 Dec 2020 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tcGaTFLZIvDv/+RZUQXw2n3pLOeGqC9LGmpKUSJxIHk=;
        b=LnlBNsT2Ow4sDfC0QMME7MWuZITq+AEcH1sfAXBFXueeGXTmgyO9JdwNHIFIB4RP28
         gn5IWNFLijhXsJzSsKaUnVdGCQx2gyWEBTqF0Kvs61fwySFHpYos92ROZTSt5SHfNHpP
         OeImMtiG3vU9Uq5eC80XJMC+Whn9dkIcqFxDKCOBa6a4es99sdy7EHJfbDRbZezvytMN
         w02FAN9w/yfckdzYqHtTMk3cHALFlV1gyfVTQPLKMmQmnHecGcHt0t+MIVhr8i6BF3VP
         R9cuJswy7JR4RuuusdzKlbCS7tt+IM1+yJIPMKGbccth3u1CnENv8XPxLf4u/SW5Qm4e
         W00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tcGaTFLZIvDv/+RZUQXw2n3pLOeGqC9LGmpKUSJxIHk=;
        b=RLyLLfXN+0jDFvOIjRU8xfBXviObaEPZ+k3Uq1lpcYe/Xz1k0XqMQqoF5/TwuRVP8t
         iOVD3TYtiREhF6OReTOr6yQ5mA85tFSzw/vKtouw7L3ztt6x4uHZtJTfvDtBvo+jrZD8
         DonnnEk6aMsGFtEkNLCONYrdaOnSYmZFKIhR37hg9REwZBrTUTJKZRTStZdRDI6NAA52
         ZTSD7T1+gXiam6Hfb3+5AOlwY7xDLK3oArS6t5oN/TL/XjeGCANnLTzKdKLf1Qjhyh2i
         kEHRMSrHAdq5PX6BJLHxc+rIRNVVcarpewgBvcEFe+SC5qoGyfFfF2p2alu4Q34S2WNn
         wCxw==
X-Gm-Message-State: AOAM532t+bhIh8PFNJZguXasf6HOhldj5EhJBp95btca+092TYcp8k7r
        +3ccFWRWqqV1FyjRq1cwyfk=
X-Google-Smtp-Source: ABdhPJwuFOmVar8+NpPkcSNRrOAxFN6p9lyUDwrJbLZ14eN6XyJlArx3zJXtTYoeeUDbEsE3lQb1/A==
X-Received: by 2002:a63:5d59:: with SMTP id o25mr17481331pgm.218.1607340834222;
        Mon, 07 Dec 2020 03:33:54 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.33.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:33:53 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [RFC V2 08/37] dmem: show some statistic in debugfs
Date:   Mon,  7 Dec 2020 19:31:01 +0800
Message-Id: <bdd885acf956dadb6822569160aa83258b6eeccc.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 mm/Kconfig |   8 +++++
 mm/dmem.c  | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 3a6d408..4dd8896 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -234,6 +234,14 @@ config DMEM
 	  Allow reservation of memory which could be for the dedicated use of dmem.
 	  It's the basis of dmemfs.
 
+config DMEM_DEBUG_FS
+	bool "Enable debug information for direct memory"
+	depends on DMEM && DEBUG_FS
+	help
+	  This option enables showing various statistics of direct memory
+	  in debugfs filesystem.
+
+#
 # support for memory compaction
 config COMPACTION
 	bool "Allow for memory compaction"
diff --git a/mm/dmem.c b/mm/dmem.c
index aa34bf2..6992e57 100644
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
1.8.3.1

