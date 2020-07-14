Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94A621E963
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 09:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGNHF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 03:05:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:63464 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgGNHEP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:04:15 -0400
IronPort-SDR: tbX199lH6+gxoeI89r9ex3VBW/twRf3oWwEnCQqLdU4FfTnUFU66rAbnrVblQlvOwVjbghLN1h
 JQu4qXWOtYJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146839879"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="146839879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:11 -0700
IronPort-SDR: 2S/nvFjzQ392JiaSqjcp8ScDg96hb1apbpi4JcpWqJ5/phFArv7EiT3mk7FEux00XHBnw/HaLS
 IAyf6X3DxdnQ==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="324463867"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:11 -0700
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
Subject: [RFC PATCH 06/15] x86/pks: Add a debugfs file for allocated PKS keys
Date:   Tue, 14 Jul 2020 00:02:11 -0700
Message-Id: <20200714070220.3500839-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714070220.3500839-1-ira.weiny@intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
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
2.25.1

