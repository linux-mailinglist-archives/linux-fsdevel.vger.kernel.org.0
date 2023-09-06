Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94D793670
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 09:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjIFHjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjIFHjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:39:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE97E64;
        Wed,  6 Sep 2023 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693985969; x=1725521969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCFPnesd773Gv+sIsXwxuNHU7U7Bs8P2FxvU4qByuSM=;
  b=g0CHtJZhrNgF7OKEUSNtmuSGYuZH5Ox8IysJ9Th981FngrpLjy4fYyVP
   T9MODacwYflplKZDKyC1V7fRTuH15PlSF4Nww2qDk+aVgYXED/dP7QYD6
   m8RMO2trK0vGnhpXr+5V3tp1PRQxHQILUEkTn8T6flhP6fHTimIG50spk
   on2kJeK+dsTwQApZaH5H2QmL+mP11qtH/yKdwVgfLZNasbS955YU4B9A8
   3X8pYaCp6+LNHVEn44uzkgkuf8QDctwrLLJBJ3Sqt/CcLVLiDExlO8EyL
   fSyRSFXcLpFD6dm1rS9KuLd3x8KMtOUUtDm83PCYBKxc9YsFQ3bLg2Kpq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375898463"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375898463"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="988133794"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="988133794"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.154])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:24 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH 2/3] proc/kcore: Do not map unaccepted memory
Date:   Wed,  6 Sep 2023 10:39:01 +0300
Message-Id: <20230906073902.4229-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906073902.4229-1-adrian.hunter@intel.com>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Support for unaccepted memory was added recently, refer commit
dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
a virtual machine may need to accept memory before it can be used.

Do not map unaccepted memory because it can cause the guest to fail.

For /proc/kcore, which is read-only and does not support mmap, this means a
read of unaccepted memory will return zeros.

Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 fs/proc/kcore.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 23fc24d16b31..a3091c5ed871 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -76,6 +76,13 @@ static int pfn_is_ram(unsigned long pfn)
 		return 1;
 }
 
+static bool pfn_is_unaccepted_memory(unsigned long pfn)
+{
+	phys_addr_t paddr = pfn << PAGE_SHIFT;
+
+	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
+}
+
 /* This doesn't grab kclist_lock, so it should only be used at init time. */
 void __init kclist_add(struct kcore_list *new, void *addr, size_t size,
 		       int type)
@@ -546,7 +553,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 			 * and explicitly excluded physical ranges.
 			 */
 			if (!page || PageOffline(page) ||
-			    is_page_hwpoison(page) || !pfn_is_ram(pfn)) {
+			    is_page_hwpoison(page) || !pfn_is_ram(pfn) ||
+			    pfn_is_unaccepted_memory(pfn)) {
 				if (iov_iter_zero(tsz, iter) != tsz) {
 					ret = -EFAULT;
 					goto out;
-- 
2.34.1

