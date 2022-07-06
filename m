Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6FF568129
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 10:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiGFIYS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 04:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiGFIX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:23:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7496C13F23;
        Wed,  6 Jul 2022 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657095837; x=1688631837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+/BgOKNb3dxFVxOORdt/5r5R408fOO4X1WIXgnHGmWI=;
  b=go6Iv3OfyhYBJiu/mOHx478uJywpkT/8Os1s+yFo5WcTooc5V8x0YuHy
   jk4S3ruDA+Ks/MjH210WmMcYUuHiFIIEmIN+IX8sBwpjGeG5fe2fxyULb
   nLjTgphU46nmUBwmm6rxPVM2jEF3aFIsr7qNsnaUk/s8deLEOeKzGh2wI
   dMUcOiLuWnJPIY0TMQsoK5WyR8i7vfUJSO+W4WVuIqI6Z7cE0nOp7J4+M
   AZeMry3XkBMj64wdXqRVrbYNsAlky6zj1BJc513mGFePvAvc7AmUwOZ1N
   +B76Qq3nJTvgt4m0kyZonTJpDWVkb+LM6Iycc6iEKC/ng7r/6ImjA7+k3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="282433172"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="282433172"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 01:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="567967821"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 01:23:46 -0700
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
Subject: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Date:   Wed,  6 Jul 2022 16:20:03 +0800
Message-Id: <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Normally, a write to unallocated space of a file or the hole of a sparse
file automatically causes space allocation, for memfd, this equals to
memory allocation. This new seal prevents such automatically allocating,
either this is from a direct write() or a write on the previously
mmap-ed area. The seal does not prevent fallocate() so an explicit
fallocate() can still cause allocating and can be used to reserve
memory.

This is used to prevent unintentional allocation from userspace on a
stray or careless write and any intentional allocation should use an
explicit fallocate(). One of the main usecases is to avoid memory double
allocation for confidential computing usage where we use two memfds to
back guest memory and at a single point only one memfd is alive and we
want to prevent memory allocation for the other memfd which may have
been mmap-ed previously. More discussion can be found at:

  https://lkml.org/lkml/2022/6/14/1255

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/uapi/linux/fcntl.h |  1 +
 mm/memfd.c                 |  3 ++-
 mm/shmem.c                 | 16 ++++++++++++++--
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..98bdabc8e309 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,7 @@
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
 #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
+#define F_SEAL_AUTO_ALLOCATE	0x0020  /* prevent allocation for writes */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 08f5f8304746..2afd898798e4 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -150,7 +150,8 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
 		     F_SEAL_WRITE | \
-		     F_SEAL_FUTURE_WRITE)
+		     F_SEAL_FUTURE_WRITE | \
+		     F_SEAL_AUTO_ALLOCATE)
 
 static int memfd_add_seals(struct file *file, unsigned int seals)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index a6f565308133..6c8aef15a17d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2051,6 +2051,8 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
 	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	enum sgp_type sgp;
 	int err;
 	vm_fault_t ret = VM_FAULT_LOCKED;
 
@@ -2113,7 +2115,12 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 		spin_unlock(&inode->i_lock);
 	}
 
-	err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, SGP_CACHE,
+	if (unlikely(info->seals & F_SEAL_AUTO_ALLOCATE))
+		sgp = SGP_NOALLOC;
+	else
+		sgp = SGP_CACHE;
+
+	err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, sgp,
 				  gfp, vma, vmf, &ret);
 	if (err)
 		return vmf_error(err);
@@ -2459,6 +2466,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
+	enum sgp_type sgp;
 	int ret = 0;
 
 	/* i_rwsem is held by caller */
@@ -2470,7 +2478,11 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 			return -EPERM;
 	}
 
-	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
+	if (unlikely(info->seals & F_SEAL_AUTO_ALLOCATE))
+		sgp = SGP_NOALLOC;
+	else
+		sgp = SGP_WRITE;
+	ret = shmem_getpage(inode, index, pagep, sgp);
 
 	if (ret)
 		return ret;
-- 
2.25.1

