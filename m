Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B415D21E92B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 09:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGNHEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 03:04:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:61109 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgGNHE3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:04:29 -0400
IronPort-SDR: /KgLZW4dFvREbw1hbd/0VuJ+D/5ZkkxHP23O7JcRBzVKZ5kBY8G0qeUyPItldvf6eR8wDCH6pU
 XnnPra5O9u8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="150261214"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="150261214"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:28 -0700
IronPort-SDR: M1818UDpOziaMV+1NuZExXbDGKfxAHE7xxsE/1/8eIxmubbVe3Yh1zWgdqipkeJC59admPi65v
 orXIGfMQFVpQ==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="390397762"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:26 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 13/15] dax: Stray write protection for dax_direct_access()
Date:   Tue, 14 Jul 2020 00:02:18 -0700
Message-Id: <20200714070220.3500839-14-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714070220.3500839-1-ira.weiny@intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

dax_direct_access() is a special case of accessing pmem via a page
offset and without a struct page.

Because the dax driver is well aware of the special protections it has
mapped memory with, call dev_access_[en|dis]able() directly instead of
the unnecessary overhead of trying to get a page to kmap.

Like kmap though, leverage the existing dax_read[un]lock() functions
because they are already required to surround the use of the memory
returned from dax_direct_access().

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 021739768093..e8d0a28e6ed2 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -30,12 +30,14 @@ static DEFINE_SPINLOCK(dax_host_lock);
 
 int dax_read_lock(void)
 {
+	dev_access_enable();
 	return srcu_read_lock(&dax_srcu);
 }
 EXPORT_SYMBOL_GPL(dax_read_lock);
 
 void dax_read_unlock(int id)
 {
+	dev_access_disable();
 	srcu_read_unlock(&dax_srcu, id);
 }
 EXPORT_SYMBOL_GPL(dax_read_unlock);
-- 
2.25.1

