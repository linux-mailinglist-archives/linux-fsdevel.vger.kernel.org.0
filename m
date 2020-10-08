Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAAF28704A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgJHH4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgJHH41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:56:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51000C0613D6;
        Thu,  8 Oct 2020 00:56:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so3568212pgm.11;
        Thu, 08 Oct 2020 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2lAuZY+zAFWdjZI2zWvNi356b2sKzGmvUf75gafHJXM=;
        b=K1aaLzfUCrptJTIAZl158Rd5hRyDuRIyJIxBl985m5sCESH2tj90eMvSsReceCA6TR
         Yeyc2NMcNS/zJolMIG1kJT3wKshzQqVuUdGGJTPr6SjInjxMGVRnN/g/7Y7N4PDliwBu
         zPMhbYUtSsWz6J1SEKgK/pQiFKgUDPedA7LnRznIfSlLOvGgEGerKYsLpgXfLaxqGFis
         f5/LQRHmY4+a1CySWvymELU0l1FGeGoXgBY8X//z25l8HAZfXudRBwYrv2W5+QT/0xwt
         sMQ649AaGUIuTVfiHb35yR2/aWNfvvlyGZ1tn0tqP4+JwixwQnVjPRZTadCw2d863DFZ
         xqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2lAuZY+zAFWdjZI2zWvNi356b2sKzGmvUf75gafHJXM=;
        b=r0H6uryk1WUVo/OprHIT0zwH6G/kz/uul8t7Ld/P/GOnPn3GvNH7sgVSxVPqO3/tRv
         dH9pjT/BdBslPdq4P+8uQUNFrqyL3VXiUrmqFviwGsqOljEOtumFagEl7MwovcguFfsM
         44rxzwa+LhjBOZxKB99JZKozg49rW4E6ZKFReNoU45Md7eOaOyos2Y1/uLP2v6dBuSOj
         J93wIeOGAPFTwzac6tREB7XPYfFJa+HKWkaJmML04hA6RT3EX48634ou90Kfitc2q558
         vFdZZrg3ERerU5ZGeGrDtPDb4vFGgIHAFcU18d0IIGgy8yJdZR9G0a+ImIsVMQAwg4u2
         eE3A==
X-Gm-Message-State: AOAM532O50aHMwmEfOcO5vMzru3H0EKGDTruRK1RWOudXUTXxMXZKNv3
        oCe4vNiACmCsvLeZ2a+eQXWxnHlLYZ0CNw==
X-Google-Smtp-Source: ABdhPJzKACFEvYxYVvHX+wvfLK7h21I4Puwri8PgdyyDOKDlutYOAq9/UWwxrpOiqNKwCL2xhAv1aw==
X-Received: by 2002:a63:2145:: with SMTP id s5mr5994447pgm.288.1602143773888;
        Thu, 08 Oct 2020 00:56:13 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:56:13 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [PATCH 34/35] dmem: add dmem unit tests
Date:   Thu,  8 Oct 2020 15:54:24 +0800
Message-Id: <0c0e00b2d89079714eb33fc3260a7d23518cb8ea.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

This test case is used to test dmem management system.

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 tools/testing/dmem/Kbuild      |   1 +
 tools/testing/dmem/Makefile    |  10 ++
 tools/testing/dmem/dmem-test.c | 184 +++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 tools/testing/dmem/Kbuild
 create mode 100644 tools/testing/dmem/Makefile
 create mode 100644 tools/testing/dmem/dmem-test.c

diff --git a/tools/testing/dmem/Kbuild b/tools/testing/dmem/Kbuild
new file mode 100644
index 000000000000..04988f7c76b7
--- /dev/null
+++ b/tools/testing/dmem/Kbuild
@@ -0,0 +1 @@
+obj-m += dmem-test.o
diff --git a/tools/testing/dmem/Makefile b/tools/testing/dmem/Makefile
new file mode 100644
index 000000000000..21f141f585de
--- /dev/null
+++ b/tools/testing/dmem/Makefile
@@ -0,0 +1,10 @@
+KDIR ?= ../../../
+
+default:
+	$(MAKE) -C $(KDIR) M=$$PWD
+
+install: default
+	$(MAKE) -C $(KDIR) M=$$PWD modules_install
+
+clean:
+	rm -f *.o *.ko Module.* modules.* *.mod.c
diff --git a/tools/testing/dmem/dmem-test.c b/tools/testing/dmem/dmem-test.c
new file mode 100644
index 000000000000..4baae18b593e
--- /dev/null
+++ b/tools/testing/dmem/dmem-test.c
@@ -0,0 +1,184 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/sizes.h>
+#include <linux/list.h>
+#include <linux/nodemask.h>
+#include <linux/slab.h>
+#include <linux/dmem.h>
+
+struct dmem_mem_node {
+	struct list_head node;
+};
+
+static LIST_HEAD(dmem_list);
+
+static int dmem_test_alloc_init(unsigned long dpage_shift)
+{
+	int ret;
+
+	ret = dmem_alloc_init(dpage_shift);
+	if (ret)
+		pr_info("dmem_alloc_init failed, dpage_shift %ld ret=%d\n",
+			dpage_shift, ret);
+	return ret;
+}
+
+static int __dmem_test_alloc(int order, int nid, nodemask_t *nodemask,
+			     const char *caller)
+{
+	struct dmem_mem_node *pos;
+	phys_addr_t addr;
+	int i, ret = 0;
+
+	for (i = 0; i < (1 << order); i++) {
+		addr = dmem_alloc_pages_nodemask(nid, nodemask, 1, NULL);
+		if (!addr) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		pos = __va(addr);
+		list_add(&pos->node, &dmem_list);
+	}
+
+	pr_info("%s: alloc order %d on node %d has fallback node %s... %s.\n",
+		caller, order, nid, nodemask ? "yes" : "no",
+		!ret ? "okay" : "failed");
+
+	return ret;
+}
+
+static void dmem_test_free_all(void)
+{
+	struct dmem_mem_node *pos, *n;
+
+	list_for_each_entry_safe(pos, n, &dmem_list, node) {
+		list_del(&pos->node);
+		dmem_free_page(__pa(pos));
+	}
+}
+
+#define dmem_test_alloc(order, nid, nodemask)	\
+	__dmem_test_alloc(order, nid, nodemask, __func__)
+
+/* dmem shoud have 2^6 native pages available at lest */
+static int order_test(void)
+{
+	int order, i, ret;
+	int page_orders[] = {0, 1, 2, 3, 4, 5, 6};
+
+	ret = dmem_test_alloc_init(PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(page_orders); i++) {
+		order = page_orders[i];
+
+		ret = dmem_test_alloc(order, numa_node_id(), NULL);
+		if (ret)
+			break;
+	}
+
+	dmem_test_free_all();
+
+	dmem_alloc_uinit();
+
+	return ret;
+}
+
+static int node_test(void)
+{
+	nodemask_t nodemask;
+	unsigned long nr = 0;
+	int order;
+	int node;
+	int ret = 0;
+
+	order = 0;
+
+	ret = dmem_test_alloc_init(PUD_SHIFT);
+	if (ret)
+		return ret;
+
+	pr_info("%s: test allocation on node 0\n", __func__);
+	node = 0;
+	nodes_clear(nodemask);
+	node_set(0, nodemask);
+
+	ret = dmem_test_alloc(order, node, &nodemask);
+	if (ret)
+		goto exit;
+
+	dmem_test_free_all();
+
+	pr_info("%s: begin to exhaust dmem on node 0.\n", __func__);
+	node = 1;
+	nodes_clear(nodemask);
+	node_set(0, nodemask);
+
+	INIT_LIST_HEAD(&dmem_list);
+	while (!(ret = dmem_test_alloc(order, node, &nodemask)))
+		nr++;
+
+	pr_info("Allocation on node 0 success times: %lu\n", nr);
+
+	pr_info("%s: allocation on node 0 again\n", __func__);
+	node = 0;
+	nodes_clear(nodemask);
+	node_set(0, nodemask);
+	ret = dmem_test_alloc(order, node, &nodemask);
+	if (!ret) {
+		pr_info("\tNot expected fallback\n");
+		ret = -1;
+	} else {
+		ret = 0;
+		pr_info("\tOK, Dmem on node 0 exhausted, fallback success\n");
+	}
+
+	pr_info("%s: Release dmem\n", __func__);
+	dmem_test_free_all();
+
+exit:
+	dmem_alloc_uinit();
+	return ret;
+}
+
+static __init int dmem_test_init(void)
+{
+	int ret;
+
+	pr_info("dmem: test init...\n");
+
+	ret = order_test();
+	if (ret)
+		return ret;
+
+	ret = node_test();
+
+
+	if (ret)
+		pr_info("dmem test fail, ret=%d\n", ret);
+	else
+		pr_info("dmem test success\n");
+	return ret;
+}
+
+static __exit void dmem_test_exit(void)
+{
+	pr_info("dmem: test exit...\n");
+}
+
+module_init(dmem_test_init);
+module_exit(dmem_test_exit);
+MODULE_LICENSE("GPL v2");
-- 
2.28.0

