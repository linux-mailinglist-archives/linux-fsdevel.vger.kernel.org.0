Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED122359F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgGQHWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:22:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:20243 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbgGQHVF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:05 -0400
IronPort-SDR: xbw9HOsH0CKThNWWvjalevgbyGZJ+oPXCU1v5yYYEbSX5fmrxdRos3zo08Ti5TJm128dYapz9F
 c6BIXzgWpOnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129632997"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="129632997"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:04 -0700
IronPort-SDR: 4zwRcwamzur591b0APcoSq3hW8wylsw0cAqcpjKNMF8iH8HcKZLa37STEc1jY9FgE2B4hxhh1+
 0G1zRQBjWkzQ==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="361271089"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:03 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V2 06/17] x86/pks: Add a debugfs file for allocated PKS keys
Date:   Fri, 17 Jul 2020 00:20:45 -0700
Message-Id: <20200717072056.73134-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

The sysadmin may need to know which PKS keys are currently being used.

Add a debugfs file to show the allocated PKS keys and their names.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/mm/pkeys.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 16f735c12fcd..e565fadd74d7 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -328,3 +328,43 @@ void pks_key_free(int pkey)
 	mutex_unlock(&pks_lock);
 }
 EXPORT_SYMBOL_GPL(pks_key_free);
+
+static int pks_keys_allocated_show(struct seq_file *m, void *p)
+{
+	int i;
+
+	mutex_lock(&pks_lock);
+	for (i = PKS_KERN_DEFAULT_KEY; i < PKS_NUM_KEYS; i++) {
+		/* It is ok for pks_key_users[i] to be NULL */
+		if (test_bit(i, &pks_key_allocation_map))
+			seq_printf(m, "%d: %s\n", i, pks_key_users[i]);
+	}
+	mutex_unlock(&pks_lock);
+
+	return 0;
+}
+
+static int pks_keys_allocated_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pks_keys_allocated_show, NULL);
+}
+
+static const struct file_operations pks_keys_allocated_fops = {
+	.open		= pks_keys_allocated_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init pks_keys_initcall(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_PKS)) {
+		/* Create a debugfs file to show allocated PKS keys. */
+		debugfs_create_file("pks_keys_allocated", 0400,
+				    arch_debugfs_dir, NULL,
+				    &pks_keys_allocated_fops);
+	}
+
+	return 0;
+}
+late_initcall(pks_keys_initcall);
-- 
2.28.0.rc0.12.gb6a658bd00c9

