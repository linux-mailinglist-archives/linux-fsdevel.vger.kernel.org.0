Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E9A568154
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 10:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiGFIZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 04:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiGFIYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:24:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9932409C;
        Wed,  6 Jul 2022 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657095881; x=1688631881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Po9DZUbErgtxR1/AAtJ9I8hzg80rqfcA4AORQCSRJWU=;
  b=asFMRB4bOYHEGR1jijlfUec4Z9tfjZDhTaPrLM8WrPL+ycXD5SHKn0VL
   IvqTB7/U10t7CKapRrUsM0gbLi/ZJ/ESzHdwqoV3kfMVGIUvEJ0ira2lz
   73SIx093zU56hh5ICv1mJr+EWEEH6gltywo9b/96zn/wC5yVH8Dfqfq/g
   LCo33IlHJyF/XvpIxzoy+oMcTF2sPuo6hgcpR1bfmser/4O0GVax2XOyu
   t8ncZCB4MhKuZNl/A0Ef3FNsocJVpWENxxUQTrgvytCQTvLfI/uQBRoAN
   BfpBe7dHvPnwrAYFyQDMaRw4zdl5D6BtIhQgx6GCnu1g/uBBh+APUOfuL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="281231847"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="281231847"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 01:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="567967920"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 01:24:30 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 05/14] mm/memfd: Introduce MFD_INACCESSIBLE flag
Date:   Wed,  6 Jul 2022 16:20:07 +0800
Message-Id: <20220706082016.2603916-6-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new memfd_create() flag indicating the content of the
created memfd is inaccessible from userspace through ordinary MMU
access (e.g., read/write/mmap). However, the file content can be
accessed via a different mechanism (e.g. KVM MMU) indirectly.

It provides semantics required for KVM guest private memory support
that a file descriptor with this flag set is going to be used as the
source of guest memory in confidential computing environments such
as Intel TDX/AMD SEV but may not be accessible from host userspace.

The flag can not coexist with MFD_ALLOW_SEALING, future sealing is
also impossible for a memfd created with this flag.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/uapi/linux/memfd.h |  1 +
 mm/memfd.c                 | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 7a8a26751c23..48750474b904 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -8,6 +8,7 @@
 #define MFD_CLOEXEC		0x0001U
 #define MFD_ALLOW_SEALING	0x0002U
 #define MFD_HUGETLB		0x0004U
+#define MFD_INACCESSIBLE	0x0008U
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/memfd.c b/mm/memfd.c
index 2afd898798e4..72d7139ccced 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -18,6 +18,7 @@
 #include <linux/hugetlb.h>
 #include <linux/shmem_fs.h>
 #include <linux/memfd.h>
+#include <linux/memfile_notifier.h>
 #include <uapi/linux/memfd.h>
 
 /*
@@ -262,7 +263,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
+		       MFD_INACCESSIBLE)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
@@ -284,6 +286,10 @@ SYSCALL_DEFINE2(memfd_create,
 			return -EINVAL;
 	}
 
+	/* Disallow sealing when MFD_INACCESSIBLE is set. */
+	if (flags & MFD_INACCESSIBLE && flags & MFD_ALLOW_SEALING)
+		return -EINVAL;
+
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
 	if (len <= 0)
@@ -330,12 +336,19 @@ SYSCALL_DEFINE2(memfd_create,
 	if (flags & MFD_ALLOW_SEALING) {
 		file_seals = memfd_file_seals_ptr(file);
 		*file_seals &= ~F_SEAL_SEAL;
+	} else if (flags & MFD_INACCESSIBLE) {
+		error = memfile_node_set_flags(file,
+					       MEMFILE_F_USER_INACCESSIBLE);
+		if (error)
+			goto err_file;
 	}
 
 	fd_install(fd, file);
 	kfree(name);
 	return fd;
 
+err_file:
+	fput(file);
 err_fd:
 	put_unused_fd(fd);
 err_name:
-- 
2.25.1

