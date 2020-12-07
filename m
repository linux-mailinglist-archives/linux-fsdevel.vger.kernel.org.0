Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C922D0F5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgLGLgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbgLGLgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:36:16 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4BC061A56;
        Mon,  7 Dec 2020 03:35:35 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w16so8642093pga.9;
        Mon, 07 Dec 2020 03:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2oI/oh3gTLcVKVrjU4mtMVnwaLDwsHWGDZd/m897JZk=;
        b=lhjKgDf+8F/uFxn5RBaOSzYX0LvT73tAN0Gg+Z8ChDCSn1g21h9K7z03ULsA5x3FO/
         2a+Eg0te0MGsaduIR3o9k0QLaF/mI8tGtephTk2VDC0HtpswcYPbfNlwIcireWiJ3lEi
         YBLTiakDlLO8KbJjbiP2fFHdnJI2rSybJZ1rp2A8mhn/yuJGj2RdiE8Y7GUN+76U1u3F
         grW+T/JmrPwOi4a+Ia/MdYqiJ3odiRzcVjQEiwxt6frfkjpO1sZ3bLJV1WGZr7av8hnV
         KBYDpv1nu/d9yh0K3QIlXoA278BPZLPtVPY9jfVMUeGQEixWS3nOF9qEgg52Qo3REX5+
         jePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2oI/oh3gTLcVKVrjU4mtMVnwaLDwsHWGDZd/m897JZk=;
        b=S3+HlXwLU+dh2EF7RJsZ9ZeYh6bv24koic/3vXshwYR17eNG0dEBVynz1K44JX0B4n
         fjs4v1oDWkLmUOpVRuOKdSi7/pe7Xs45Vx14LDG7bZhpGzHD9nyM+AXIIwMNgV1OVcR8
         E/ntPQd7U2RnoeFdiUX9uc9I+7QsU4WOUv5QPF0G0K5/Ra9Y5pLQv33hJbtR+InlvYXo
         6Oi7ho2jqb0YQdCdW0cV2cXPTeDO+BAoBnba0nR5yEgR73y1aQB3WmB77hS4SMezG1Q+
         GLIK92Yn0yHsiggln6HkQ4Mn4soaHbDOXHvlhdmx+ddOHg+4xZOfxoYtMinvuwXimfh1
         3rwg==
X-Gm-Message-State: AOAM530jJdeGiTWNBjsYs7FBXZeCDzz44n6lzLw79W4601ZujfrXpLO6
        or3hy7XoT8TSnztNQOAy4iM=
X-Google-Smtp-Source: ABdhPJxk408hICw1VHxdPSSZFmVYiF7oejg12uAdXoM+nWbeUsNih67nBm2DaYDp/HkVlqXXpfd2hQ==
X-Received: by 2002:a17:902:fe17:b029:da:799a:8bfd with SMTP id g23-20020a170902fe17b02900da799a8bfdmr15667660plj.10.1607340935397;
        Mon, 07 Dec 2020 03:35:35 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:34 -0800 (PST)
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
Subject: [RFC V2 34/37] dmem: add dmem unit tests
Date:   Mon,  7 Dec 2020 19:31:27 +0800
Message-Id: <b62c74795b10b9bcc67093524d2850639e756f36.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

This test case is used to test dmem management system.

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 tools/testing/dmem/Kbuild      |   1 +
 tools/testing/dmem/Makefile    |  10 +++
 tools/testing/dmem/dmem-test.c | 184 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 tools/testing/dmem/Kbuild
 create mode 100644 tools/testing/dmem/Makefile
 create mode 100644 tools/testing/dmem/dmem-test.c

diff --git a/tools/testing/dmem/Kbuild b/tools/testing/dmem/Kbuild
new file mode 100644
index 00000000..04988f7
--- /dev/null
+++ b/tools/testing/dmem/Kbuild
@@ -0,0 +1 @@
+obj-m += dmem-test.o
diff --git a/tools/testing/dmem/Makefile b/tools/testing/dmem/Makefile
new file mode 100644
index 00000000..21f141f
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
index 00000000..4baae18
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
1.8.3.1

