Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4A49270C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242852AbiARNWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:22:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:18774 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242808AbiARNWO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512134; x=1674048134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tGgrzrdRsYU+NqPfrWvM/m/GPitol5J3LJPXDgJxTB8=;
  b=I1erD7Q9ENroY+8/OPNtN1yK2NJ56XLm27mOKZ3BhwV5swFcPV6+GZoi
   bdmTY8iJdQD1EeUSfj7E8qj0WX22Zur1hdCyDHFshZ6f3HSc2M1x4lWxQ
   KC3W8HobzeaCgQNDcbwJwvNPF3FJg72a7PdDmto1NLjbDRHR93K/ppgMw
   BsfpP/wgbgYszypK024LjvWcVJePrJPXqPMuDuM3Rv/NVIcNBFDtFT2Aj
   T5jZ48Yns+AizeQ/gtPxvgdkEgTBzm4ijlB0sOwocDfR3Bc5Rm9xUjFO3
   6NMzU2l/WwTiz5tFHE/wigYmyzASOTqxA9tOSlht+Fq+EYg4i4+WTxaC5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="243636251"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="243636251"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531791674"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 05:22:06 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v4 02/12] mm/memfd: Introduce MFD_INACCESSIBLE flag
Date:   Tue, 18 Jan 2022 21:21:11 +0800
Message-Id: <20220118132121.31388-3-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new memfd_create() flag indicating the content of the
created memfd is inaccessible from userspace. It does this by force
setting F_SEAL_INACCESSIBLE seal when the file is created. It also set
F_SEAL_SEAL to prevent future sealing, which means, it can not coexist
with MFD_ALLOW_SEALING.

The pages backed by such memfd will be used as guest private memory in
confidential computing environments such as Intel TDX/AMD SEV. Since
page migration/swapping is not yet supported for such usages so these
pages are currently marked as UNMOVABLE and UNEVICTABLE which makes
them behave like long-term pinned pages.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/uapi/linux/memfd.h |  1 +
 mm/memfd.c                 | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

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
index 9f80f162791a..26998d96dc11 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -245,16 +245,19 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
+		       MFD_INACCESSIBLE)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
 {
+	struct address_space *mapping;
 	unsigned int *file_seals;
 	struct file *file;
 	int fd, error;
 	char *name;
+	gfp_t gfp;
 	long len;
 
 	if (!(flags & MFD_HUGETLB)) {
@@ -267,6 +270,10 @@ SYSCALL_DEFINE2(memfd_create,
 			return -EINVAL;
 	}
 
+	/* Disallow sealing when MFD_INACCESSIBLE is set. */
+	if (flags & MFD_INACCESSIBLE && flags & MFD_ALLOW_SEALING)
+		return -EINVAL;
+
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
 	if (len <= 0)
@@ -315,6 +322,17 @@ SYSCALL_DEFINE2(memfd_create,
 		*file_seals &= ~F_SEAL_SEAL;
 	}
 
+	if (flags & MFD_INACCESSIBLE) {
+		mapping = file_inode(file)->i_mapping;
+		gfp = mapping_gfp_mask(mapping);
+		gfp &= ~__GFP_MOVABLE;
+		mapping_set_gfp_mask(mapping, gfp);
+		mapping_set_unevictable(mapping);
+
+		file_seals = memfd_file_seals_ptr(file);
+		*file_seals &= F_SEAL_SEAL | F_SEAL_INACCESSIBLE;
+	}
+
 	fd_install(fd, file);
 	kfree(name);
 	return fd;
-- 
2.17.1

