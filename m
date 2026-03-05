Return-Path: <linux-fsdevel+bounces-79480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPE4L0tgqWnj6QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:51:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5EF210059
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DF863057487
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA9B37C10D;
	Thu,  5 Mar 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUxLFGSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF61376BD6;
	Thu,  5 Mar 2026 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707846; cv=none; b=aOcqxDEFurW4WSniycQ0mBUJiUEMTLjakwMXeIyAnHXoxwWk2FdzTRnHu/T5i3xiK7Of/fdjz4cWdp0l5cOvFMKQ6GGP7l4GW+M7fAjlv4y/yFfYTQiEHoWDzI9iGGDzxW3fThMFnsEvVyadjwi6x6gLBlqepG049ZifjTxsVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707846; c=relaxed/simple;
	bh=EK6fYEvH1wg5Fjr6ELYShGj5Cu5n2mWY5XPhO/+Nlxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSADzVM839p/k4TEaf1jO/HlIhV8a2afxIL3GWeSYV/5BkqvSApIiEh4ToW2OaM7ikdgFIeZ+fJK4NoCJglD2eH6PbDcb32odzrbI8gnMa4ZFHDtkUe0JxRswQphazuN9OQdSA5gKHnHk1NEOAiQ2jlcaGi0/T4djUqthXPX+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUxLFGSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7A0C2BCB4;
	Thu,  5 Mar 2026 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707846;
	bh=EK6fYEvH1wg5Fjr6ELYShGj5Cu5n2mWY5XPhO/+Nlxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUxLFGSwjcUn+c30j5c81RAPfXsVUUBDRry9ESKIK6yeaCjMkOjGYX/r9jyrIhx3d
	 MSDcAfBnydcuRaU4exr00z3uuBkYoayRS8E/jQbVSxkIxp+a+xN8CTbRZ0r92e3j8R
	 9QhQHyuJGh69jHlZi/X2kFiqNMdTa9CnYQtwGXxbo91txfjll27yeUHT8nVqEgg8KM
	 xithGz3kD1LrKxFUgiCKt1H2NlbK6vKfKqbW1k9+R98MDIOBcx6nSg008cr/jJwSCh
	 pSH00jsYh7zjNllJLU6pctKk01tbqn870dBj6bd2rMuYcw7E1yb5mGQOJi1i0tQj2q
	 7lPLYYy3OfPVg==
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
Subject: [PATCH 5/6] mm: reintroduce vma_desc_test() as a singular flag test
Date: Thu,  5 Mar 2026 10:50:18 +0000
Message-ID: <3a65ca23defb05060333f0586428fe279a484564.1772704455.git.ljs@kernel.org>
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
X-Rspamd-Queue-Id: AA5EF210059
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79480-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Similar to vma_flags_test(), we have previously renamed vma_desc_test() to
vma_desc_test_any(). Now that is in place, we can reintroduce
vma_desc_test() to explicitly check for a single VMA flag.

As with vma_flags_test(), this is useful as often flag tests are against a
single flag, and vma_desc_test_any(flags, VMA_READ_BIT) reads oddly and
potentially causes confusion.

As with vma_flags_test() a combination of sparse and vma_flags_t being a
struct means that users cannot misuse this function without it getting
flagged.

Also update the VMA tests to reflect this change.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 drivers/char/mem.c              |  2 +-
 fs/hugetlbfs/inode.c            |  2 +-
 fs/ntfs3/file.c                 |  2 +-
 fs/resctrl/pseudo_lock.c        |  2 +-
 include/linux/dax.h             |  4 ++--
 include/linux/mm.h              | 11 +++++++++++
 mm/hugetlb.c                    | 12 ++++++------
 tools/testing/vma/include/dup.h |  6 ++++++
 8 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 5118787d0954..5fd421e48c04 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -520,7 +520,7 @@ static int mmap_zero_prepare(struct vm_area_desc *desc)
 #ifndef CONFIG_MMU
 	return -ENOSYS;
 #endif
-	if (vma_desc_test_any(desc, VMA_SHARED_BIT))
+	if (vma_desc_test(desc, VMA_SHARED_BIT))
 		return shmem_zero_setup_desc(desc);
 
 	desc->action.success_hook = mmap_zero_private_success;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 079ffaaf1f6c..cd6b22f6e2b1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -164,7 +164,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 		goto out;
 
 	ret = 0;
-	if (vma_desc_test_any(desc, VMA_WRITE_BIT) && inode->i_size < len)
+	if (vma_desc_test(desc, VMA_WRITE_BIT) && inode->i_size < len)
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index c5e2181f9f02..fbdfaf989a31 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -276,7 +276,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
-	const bool rw = vma_desc_test_any(desc, VMA_WRITE_BIT);
+	const bool rw = vma_desc_test(desc, VMA_WRITE_BIT);
 	int err;
 
 	/* Avoid any operation if inode is bad. */
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 79a006c6f26c..d1cb0986006e 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -1044,7 +1044,7 @@ static int pseudo_lock_dev_mmap_prepare(struct vm_area_desc *desc)
 	 * Ensure changes are carried directly to the memory being mapped,
 	 * do not allow copy-on-write mapping.
 	 */
-	if (!vma_desc_test_any(desc, VMA_SHARED_BIT)) {
+	if (!vma_desc_test(desc, VMA_SHARED_BIT)) {
 		mutex_unlock(&rdtgroup_mutex);
 		return -EINVAL;
 	}
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 535019001577..10a7cc79aea5 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -69,7 +69,7 @@ static inline bool daxdev_mapping_supported(const struct vm_area_desc *desc,
 					    const struct inode *inode,
 					    struct dax_device *dax_dev)
 {
-	if (!vma_desc_test_any(desc, VMA_SYNC_BIT))
+	if (!vma_desc_test(desc, VMA_SYNC_BIT))
 		return true;
 	if (!IS_DAX(inode))
 		return false;
@@ -115,7 +115,7 @@ static inline bool daxdev_mapping_supported(const struct vm_area_desc *desc,
 					    const struct inode *inode,
 					    struct dax_device *dax_dev)
 {
-	return !vma_desc_test_any(desc, VMA_SYNC_BIT);
+	return !vma_desc_test(desc, VMA_SYNC_BIT);
 }
 static inline size_t dax_recovery_write(struct dax_device *dax_dev,
 		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5622d04c9ba9..9bdfa1a91552 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1193,6 +1193,17 @@ static inline void vma_set_flags_mask(struct vm_area_struct *vma,
 #define vma_set_flags(vma, ...) \
 	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
 
+/*
+ * Test whether a specific VMA flag is set in a VMA descriptor, e.g.:
+ *
+ * if (vma_desc_test(desc, VMA_READ_BIT)) { ... }
+ */
+static __always_inline bool vma_desc_test(const struct vm_area_desc *desc,
+		vma_flag_t bit)
+{
+	return vma_flags_test(&desc->vma_flags, bit);
+}
+
 /* Helper to test any VMA flags in a VMA descriptor. */
 static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 		vma_flags_t flags)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bd9f3b2d2cb0..8cde83fb8a5a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1194,7 +1194,7 @@ static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
 static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *map)
 {
 	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
-	VM_WARN_ON_ONCE(vma_desc_test_any(desc, VMA_MAYSHARE_BIT));
+	VM_WARN_ON_ONCE(vma_desc_test(desc, VMA_MAYSHARE_BIT));
 
 	desc->private_data = map;
 }
@@ -1202,7 +1202,7 @@ static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *ma
 static void set_vma_desc_resv_flags(struct vm_area_desc *desc, unsigned long flags)
 {
 	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
-	VM_WARN_ON_ONCE(vma_desc_test_any(desc, VMA_MAYSHARE_BIT));
+	VM_WARN_ON_ONCE(vma_desc_test(desc, VMA_MAYSHARE_BIT));
 
 	desc->private_data = (void *)((unsigned long)desc->private_data | flags);
 }
@@ -6600,7 +6600,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * to reserve the full area even if read-only as mprotect() may be
 	 * called to make the mapping read-write. Assume !desc is a shm mapping
 	 */
-	if (!desc || vma_desc_test_any(desc, VMA_MAYSHARE_BIT)) {
+	if (!desc || vma_desc_test(desc, VMA_MAYSHARE_BIT)) {
 		/*
 		 * resv_map can not be NULL as hugetlb_reserve_pages is only
 		 * called for inodes for which resv_maps were created (see
@@ -6634,7 +6634,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	if (err < 0)
 		goto out_err;
 
-	if (desc && !vma_desc_test_any(desc, VMA_MAYSHARE_BIT) && h_cg) {
+	if (desc && !vma_desc_test(desc, VMA_MAYSHARE_BIT) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
 		 * of the resv_map.
 		 */
@@ -6671,7 +6671,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * consumed reservations are stored in the map. Hence, nothing
 	 * else has to be done for private mappings here
 	 */
-	if (!desc || vma_desc_test_any(desc, VMA_MAYSHARE_BIT)) {
+	if (!desc || vma_desc_test(desc, VMA_MAYSHARE_BIT)) {
 		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
 
 		if (unlikely(add < 0)) {
@@ -6735,7 +6735,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	if (!desc || vma_desc_test_any(desc, VMA_MAYSHARE_BIT))
+	if (!desc || vma_desc_test(desc, VMA_MAYSHARE_BIT))
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
 		 */
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 630478f0d583..5eb313beb43d 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -922,6 +922,12 @@ static inline void vma_set_flags_mask(struct vm_area_struct *vma,
 #define vma_set_flags(vma, ...) \
 	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
 
+static __always_inline bool vma_desc_test(const struct vm_area_desc *desc,
+		vma_flag_t bit)
+{
+	return vma_flags_test(&desc->vma_flags, bit);
+}
+
 static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 					    vma_flags_t flags)
 {
-- 
2.53.0


