Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38324D48B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbiCJOLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbiCJOLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:11:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E68F637;
        Thu, 10 Mar 2022 06:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921408; x=1678457408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=s3KeBsvI7L7pbUPmXrVsTjDsdOJOMmhGXQWiylgk8+Q=;
  b=Tyo/fwpvW4j2fqABwXK8nR0supuYn55ZCaw6lMNcrUJ//0q8eMGoDpiS
   l5+DsVjkv8kBNzuirDO2SeaxKfYXldV17NwY9hpU3sG6uzgCBUvG3cGWZ
   h9fxIX8qh6xqZ2ej/cCZ+AxKxMWoeqQmX9Uv6HuPT+FkVaVMdlf9APVsJ
   GGVUTzuKjWaOWA15vKy/+Xg+Eptb0N/Oi75WXYObe+zi+wfDgZ1fLDkkf
   to7zEWJzW/jQHggGunowEwrkai/ii15KqXTH7irLWcf9X2HJzlg1oGzt4
   w/Hp4ZWCpzE4Zs964bqxLCoIkbsd496wjqUJwXd40Q+U9Xd6n6678relI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="254084871"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="254084871"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554654936"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:10:00 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory against RLIMIT_MEMLOCK
Date:   Thu, 10 Mar 2022 22:09:02 +0800
Message-Id: <20220310140911.50924-5-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since page migration / swapping is not supported yet, MFD_INACCESSIBLE
memory behave like longterm pinned pages and thus should be accounted to
mm->pinned_vm and be restricted by RLIMIT_MEMLOCK.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 mm/shmem.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7b43e274c9a2..ae46fb96494b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -915,14 +915,17 @@ static void notify_fallocate(struct inode *inode, pgoff_t start, pgoff_t end)
 static void notify_invalidate_page(struct inode *inode, struct folio *folio,
 				   pgoff_t start, pgoff_t end)
 {
-#ifdef CONFIG_MEMFILE_NOTIFIER
 	struct shmem_inode_info *info = SHMEM_I(inode);
 
+#ifdef CONFIG_MEMFILE_NOTIFIER
 	start = max(start, folio->index);
 	end = min(end, folio->index + folio_nr_pages(folio));
 
 	memfile_notifier_invalidate(&info->memfile_notifiers, start, end);
 #endif
+
+	if (info->xflags & SHM_F_INACCESSIBLE)
+		atomic64_sub(end - start, &current->mm->pinned_vm);
 }
 
 /*
@@ -2680,6 +2683,20 @@ static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 	return offset;
 }
 
+static bool memlock_limited(unsigned long npages)
+{
+	unsigned long lock_limit;
+	unsigned long pinned;
+
+	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	pinned = atomic64_add_return(npages, &current->mm->pinned_vm);
+	if (pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
+		atomic64_sub(npages, &current->mm->pinned_vm);
+		return true;
+	}
+	return false;
+}
+
 static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 							 loff_t len)
 {
@@ -2753,6 +2770,12 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		goto out;
 	}
 
+	if ((info->xflags & SHM_F_INACCESSIBLE) &&
+			memlock_limited(end - start)) {
+		error = -ENOMEM;
+		goto out;
+	}
+
 	shmem_falloc.waitq = NULL;
 	shmem_falloc.start = start;
 	shmem_falloc.next  = start;
-- 
2.17.1

