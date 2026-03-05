Return-Path: <linux-fsdevel+bounces-79479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CInPF1JgqWnj6QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:52:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6451C210061
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0114301F5EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4EE37FF70;
	Thu,  5 Mar 2026 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnwnEQWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D070384226;
	Thu,  5 Mar 2026 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707843; cv=none; b=Mh9MI8k9f8V+Ux7q/Wfa55C59RTP1JiO2R7hbEyA5dTrvPcft0RXP+JKLxkmWB+NvHwapPZ+mLtxg++vkX6sSIjTronTd6JgUqg7MJUsfcVgZS6LkB3sV18Clu+W9qPbCUbOU2LQZ8Bp3TyYL5KN1+L2LGFbN5x0k4+uX7oXjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707843; c=relaxed/simple;
	bh=K6atPXEwAz6pCpNgSjUNbutgg0Ze42UtzX9vGX/lf1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqiV2wf4OSNueaS7phOVu7BKnIiDSh1T+s54fgAFpjxAqAxgslgduqjfuFnFECiknAo0FvOnsFFg9wSYdtz+KjX2l9NiOPQF/eIjiNv8Q6aM8f69XN+vzrc/cXEQ6Z4WgV05gmKDSwvtu4K/GA+WlqvO3Lp5bgQFXlZhDM2bb9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnwnEQWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EE8C19422;
	Thu,  5 Mar 2026 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707842;
	bh=K6atPXEwAz6pCpNgSjUNbutgg0Ze42UtzX9vGX/lf1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnwnEQWppRWj2X12TGMNPtDnaTYkVoE6SscxZf2XjuEV7EAMd5hPqHKmJjNb0couT
	 4Yr/gp9nN20VjAigjL3TT+oUbgvsXjg7/Ngchr1ZaD54JKZbRZ73qB38gEujixGeGv
	 GINuPfK8VIIcOs7b9HhLhT6ob1XPKTe868CSOX9LzAaUFCygQtAA6pK9T2qM+SKukc
	 lwmvOrm2Me7Xdn4E6B0XZtJszykq6mOYjj2lfsdMujilXsAJrPXpnpfI0518yH9B9C
	 7R1lexJePjT6Xn446TcwX5w5HCUlDQBBguymYuFcXM2YbOz5DUroMVLiDxaAhKV0Ch
	 kEWuHUjWY/9mw==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-mm@kvack.org,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/6] mm: reintroduce vma_flags_test() as a singular flag test
Date: Thu,  5 Mar 2026 10:50:17 +0000
Message-ID: <f33f8d7f16c3f3d286a1dc2cba12c23683073134.1772704455.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772704455.git.ljs@kernel.org>
References: <cover.1772704455.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6451C210061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79479-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Since we've now renamed vma_flags_test() to vma_flags_test_any() to be very
clear as to what we are in fact testing, we now have the opportunity to
bring vma_flags_test() back, but for explicitly testing a single VMA flag.

This is useful, as often flag tests are against a single flag, and
vma_flags_test_any(flags, VMA_READ_BIT) reads oddly and potentially causes
confusion.

We use sparse to enforce that users won't accidentally pass vm_flags_t to
this function without it being flagged so this should make it harder to get
this wrong.

Of course, passing vma_flags_t to the function is impossible, as it is a
struct.

Also update the VMA tests to reflect this change.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h              | 17 +++++++++++++++--
 mm/hugetlb.c                    |  2 +-
 mm/shmem.c                      |  4 ++--
 tools/testing/vma/include/dup.h |  8 ++++++++
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 66b90de30bf6..5622d04c9ba9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1051,6 +1051,19 @@ static __always_inline vma_flags_t __mk_vma_flags(size_t count,
 	return flags;
 }
 
+/*
+ * Test whether a specific VMA flag is set, e.g.:
+ *
+ * if (vma_flags_test(flags, VMA_READ_BIT)) { ... }
+ */
+static __always_inline bool vma_flags_test(const vma_flags_t *flags,
+		vma_flag_t bit)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+
+	return test_bit((__force int)bit, bitmap);
+}
+
 /*
  * Helper macro which bitwise-or combines the specified input flags into a
  * vma_flags_t bitmap value. E.g.:
@@ -1957,8 +1970,8 @@ static inline bool vma_desc_is_cow_mapping(struct vm_area_desc *desc)
 {
 	const vma_flags_t *flags = &desc->vma_flags;
 
-	return vma_flags_test_any(flags, VMA_MAYWRITE_BIT) &&
-		!vma_flags_test_any(flags, VMA_SHARED_BIT);
+	return vma_flags_test(flags, VMA_MAYWRITE_BIT) &&
+		!vma_flags_test(flags, VMA_SHARED_BIT);
 }
 
 #ifndef CONFIG_MMU
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8286c5db2c12..bd9f3b2d2cb0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6591,7 +6591,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * attempt will be made for VM_NORESERVE to allocate a page
 	 * without using reserves
 	 */
-	if (vma_flags_test_any(&vma_flags, VMA_NORESERVE_BIT))
+	if (vma_flags_test(&vma_flags, VMA_NORESERVE_BIT))
 		return 0;
 
 	/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 965a8908200b..5e7dcf5bc5d3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3086,7 +3086,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	spin_lock_init(&info->lock);
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
-	info->flags = vma_flags_test_any(&flags, VMA_NORESERVE_BIT)
+	info->flags = vma_flags_test(&flags, VMA_NORESERVE_BIT)
 		? SHMEM_F_NORESERVE : 0;
 	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
@@ -5827,7 +5827,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 				       unsigned int i_flags)
 {
 	const unsigned long shmem_flags =
-		vma_flags_test_any(&flags, VMA_NORESERVE_BIT) ? SHMEM_F_NORESERVE : 0;
+		vma_flags_test(&flags, VMA_NORESERVE_BIT) ? SHMEM_F_NORESERVE : 0;
 	struct inode *inode;
 	struct file *res;
 
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index ef6b9d963acc..630478f0d583 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -844,6 +844,14 @@ static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits);
 #define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
 					 (const vma_flag_t []){__VA_ARGS__})
 
+static __always_inline bool vma_flags_test(const vma_flags_t *flags,
+		vma_flag_t bit)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+
+	return test_bit((__force int)bit, bitmap);
+}
+
 static __always_inline bool vma_flags_test_any_mask(const vma_flags_t *flags,
 		vma_flags_t to_test)
 {
-- 
2.53.0


