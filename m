Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB32679B73A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbjIKUzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbjIKLVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:21:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72BECDD;
        Mon, 11 Sep 2023 04:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694431305; x=1725967305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M9e2eeN/kfGtE3gA5n3bGk//DgEyKzp702J0NcFnLyE=;
  b=NKfOwgfGSd6WrjeU3QDdKYQhFHVc+GWTzubfzrKE2Q/PGHaATxUev7vj
   qBXZPntQ6En3mGr5uzb1O9J5e1h+uTIrq4JMvThMoE1T0U9vHE/oyTGw0
   QT92dbYgGxd/1+Zjrb79ABRUdIyHyPw60S33f5GaZwLRQHnvuh9AdY5Gf
   aUVNU0o5HlPv/7O1ArrBouGe0TB7sIdH128/9bmaaDWDfNv/SIASu42Yt
   VVN3J3ecPzsc4QRuitNMa/RyRCtZzM5D0rQyiNAf4ryDXe9TtH5Y+P+NQ
   UnAbdZOs8nK1gU17Tayk2m0CzanGy3uulgm0hlKcMqiQGT6zJuoovHiql
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358358431"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358358431"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778356406"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778356406"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.216.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
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
Subject: [PATCH V2 2/2] proc/kcore: Do not try to access unaccepted memory
Date:   Mon, 11 Sep 2023 14:21:14 +0300
Message-Id: <20230911112114.91323-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911112114.91323-1-adrian.hunter@intel.com>
References: <20230911112114.91323-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Support for unaccepted memory was added recently, refer commit
dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby a virtual
machine may need to accept memory before it can be used.

Do not try to access unaccepted memory because it can cause the guest to
fail.

For /proc/kcore, which is read-only and does not support mmap, this means a
read of unaccepted memory will return zeros.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 fs/proc/kcore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


Changes in V2:

          Change patch subject and commit message
          Do not open code pfn_is_unaccepted_memory()


diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 23fc24d16b31..6422e569b080 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -546,7 +546,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
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

