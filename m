Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45F2C1DE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgKXGIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:12216 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgKXGIN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:13 -0500
IronPort-SDR: qiuAW+fuYyiLTpEe/ADkQR7jsX4DhftcycdUAqI/yKAPd+k8CyrVQ7FH6766Ssqga9MHhkZ8TW
 WgZqNIc44TKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="169332360"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="169332360"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:13 -0800
IronPort-SDR: ZoBwrB4JFK1e6EM9E54oD67IpZ8rD1Tv7iKjj3JBFFabN5qyxMwV+LWlqPBRk2bB7j7NfqkYON
 UCcWE7VVML8w==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="546707751"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:12 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/17] lib: Use mempcy_to/from_page()
Date:   Mon, 23 Nov 2020 22:07:54 -0800
Message-Id: <20201124060755.1405602-17-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Remove kmap/mem*()/kunmap pattern and use memcpy_to/from_page()

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 lib/test_bpf.c | 11 ++---------
 lib/test_hmm.c | 10 ++--------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ca7d635bccd9..def048bc1c48 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14,6 +14,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/pagemap.h>
 #include <linux/random.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
@@ -6499,25 +6500,17 @@ static void *generate_test_data(struct bpf_test *test, int sub)
 		 * single fragment to the skb, filled with
 		 * test->frag_data.
 		 */
-		void *ptr;
-
 		page = alloc_page(GFP_KERNEL);
 
 		if (!page)
 			goto err_kfree_skb;
 
-		ptr = kmap(page);
-		if (!ptr)
-			goto err_free_page;
-		memcpy(ptr, test->frag_data, MAX_DATA);
-		kunmap(page);
+		memcpy_to_page(page, 0, test->frag_data, MAX_DATA);
 		skb_add_rx_frag(skb, 0, page, 0, MAX_DATA, MAX_DATA);
 	}
 
 	return skb;
 
-err_free_page:
-	__free_page(page);
 err_kfree_skb:
 	kfree_skb(skb);
 	return NULL;
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 80a78877bd93..6a5fe7c4088b 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -321,16 +321,13 @@ static int dmirror_do_read(struct dmirror *dmirror, unsigned long start,
 	for (pfn = start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++) {
 		void *entry;
 		struct page *page;
-		void *tmp;
 
 		entry = xa_load(&dmirror->pt, pfn);
 		page = xa_untag_pointer(entry);
 		if (!page)
 			return -ENOENT;
 
-		tmp = kmap(page);
-		memcpy(ptr, tmp, PAGE_SIZE);
-		kunmap(page);
+		memcpy_from_page(ptr, page, 0, PAGE_SIZE);
 
 		ptr += PAGE_SIZE;
 		bounce->cpages++;
@@ -390,16 +387,13 @@ static int dmirror_do_write(struct dmirror *dmirror, unsigned long start,
 	for (pfn = start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++) {
 		void *entry;
 		struct page *page;
-		void *tmp;
 
 		entry = xa_load(&dmirror->pt, pfn);
 		page = xa_untag_pointer(entry);
 		if (!page || xa_pointer_tag(entry) != DPT_XA_TAG_WRITE)
 			return -ENOENT;
 
-		tmp = kmap(page);
-		memcpy(tmp, ptr, PAGE_SIZE);
-		kunmap(page);
+		memcpy_to_page(page, 0, ptr, PAGE_SIZE);
 
 		ptr += PAGE_SIZE;
 		bounce->cpages++;
-- 
2.28.0.rc0.12.gb6a658bd00c9

