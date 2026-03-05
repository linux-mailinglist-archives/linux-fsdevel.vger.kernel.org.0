Return-Path: <linux-fsdevel+bounces-79477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bz7BSBgqWlc6QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:51:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD7C21001E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D94EF303AA8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D422D37BE81;
	Thu,  5 Mar 2026 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRuMF0Fp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E6376BD6;
	Thu,  5 Mar 2026 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707837; cv=none; b=iKMsuPl1GySRWnMFzGC9tAjBytz8MF0cId/1JwRL9yx/gPylHJHDG9oDfZzfynwONHC0LQLQMymE0ELK9wR0ZYLoANWIFvlLetbOSVBFlug+6/AOm49KjEvDDRgIYXyK/0FBFFdQWxe2Xp0EDMpRnsRF1Hsy2FHZYZH1NhxlBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707837; c=relaxed/simple;
	bh=u1CeJgjWd7kXPS3ws/muqknCR1bko0+rqrXMss6JWs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhqNlWZLjqNBhc7qL8ssG9BBcP1IFlHVRtnSyThew2YnrQb/Hmwz2ZjdB1Dtypsd2/itWxMXQSEPf0ba7vPecD3UWi3q8cbb+6DrFAehmLi4535w1r4tb/mVodl9MsT4k7MOxb7ATtkjQuveiA6whvnLamO177glGyYagWzRkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRuMF0Fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75396C116C6;
	Thu,  5 Mar 2026 10:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707837;
	bh=u1CeJgjWd7kXPS3ws/muqknCR1bko0+rqrXMss6JWs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRuMF0Fp5RgG+1TfOfSpoEQsuFnGiyxgpQaEJMycqoz5Lu0pxKWRIHueudja3BrrT
	 HS35EjVPfS42luoTz69IPj1Nb3BPZk5SG11K0m9+kjLyufD/DRqBU5HshDtwBR8mSX
	 gsx+fjzYBeNdInitBzNx4UXo7mbPJ8oDsH8QfGV5NU5hx4FQsbO7JCTL4pf05omubz
	 ZQkKT8PDabVcStINMOWLvo5KiCf6qtq8MJr2RPBXSMAbhDCDKCblz0q6XdEGUlEL20
	 81nqJV1Zevw5akClENINw2E3tAsDKSh/e4G3fS5T33Kukft3x9LbCsEoPR4Ck60mdd
	 CS2X0Ksy9gaWw==
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
Subject: [PATCH 2/6] mm: add vma_desc_test_all() and use it
Date: Thu,  5 Mar 2026 10:50:15 +0000
Message-ID: <568c8f8d6a84ff64014f997517cba7a629f7eed6.1772704455.git.ljs@kernel.org>
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
X-Rspamd-Queue-Id: DAD7C21001E
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
	TAGGED_FROM(0.00)[bounces-79477-lists,linux-fsdevel=lfdr.de];
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

erofs and zonefs are using vma_desc_test_any() twice to check whether all
of VMA_SHARED_BIT and VMA_MAYWRITE_BIT are set, this is silly, so add
vma_desc_test_all() to test all flags and update erofs and zonefs to use
it.

While we're here, update the helper function comments to be more
consistent.

Also add the same to the VMA test headers.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 fs/erofs/data.c                 |  3 +--
 fs/zonefs/file.c                |  3 +--
 include/linux/mm.h              | 24 ++++++++++++++++++++----
 tools/testing/vma/include/dup.h |  9 +++++++++
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6774d9b5ee82..b33dd4d8710e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -473,8 +473,7 @@ static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
 	if (!IS_DAX(file_inode(desc->file)))
 		return generic_file_readonly_mmap_prepare(desc);
 
-	if (vma_desc_test_any(desc, VMA_SHARED_BIT) &&
-	    vma_desc_test_any(desc, VMA_MAYWRITE_BIT))
+	if (vma_desc_test_all(desc, VMA_SHARED_BIT, VMA_MAYWRITE_BIT))
 		return -EINVAL;
 
 	desc->vm_ops = &erofs_dax_vm_ops;
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 9f9273ecf71a..5ada33f70bb4 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -333,8 +333,7 @@ static int zonefs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * ordering between msync() and page cache writeback.
 	 */
 	if (zonefs_inode_is_seq(file_inode(file)) &&
-	    vma_desc_test_any(desc, VMA_SHARED_BIT) &&
-	    vma_desc_test_any(desc, VMA_MAYWRITE_BIT))
+	    vma_desc_test_all(desc, VMA_SHARED_BIT, VMA_MAYWRITE_BIT))
 		return -EINVAL;
 
 	file_accessed(file);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db738a567637..9a052eedcdf4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1178,7 +1178,7 @@ static inline void vma_set_flags_mask(struct vm_area_struct *vma,
 #define vma_set_flags(vma, ...) \
 	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
 
-/* Helper to test all VMA flags in a VMA descriptor. */
+/* Helper to test any VMA flags in a VMA descriptor. */
 static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 		vma_flags_t flags)
 {
@@ -1186,8 +1186,8 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 }
 
 /*
- * Helper macro for testing VMA flags for an input pointer to a struct
- * vm_area_desc object describing a proposed VMA, e.g.:
+ * Helper macro for testing whether any VMA flags are set in a VMA descriptor,
+ * e.g.:
  *
  * if (vma_desc_test_any(desc, VMA_IO_BIT, VMA_PFNMAP_BIT,
  *		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)) { ... }
@@ -1195,6 +1195,22 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 #define vma_desc_test_any(desc, ...) \
 	vma_desc_test_any_mask(desc, mk_vma_flags(__VA_ARGS__))
 
+/* Helper to test all VMA flags in a VMA descriptor. */
+static inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
+		vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(&desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for testing whether ALL VMA flags are set in a VMA descriptor,
+ * e.g.:
+ *
+ * if (vma_desc_test_all(desc, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
+ */
+#define vma_desc_test_all(desc, ...) \
+	vma_desc_test_all_mask(desc, mk_vma_flags(__VA_ARGS__))
+
 /* Helper to set all VMA flags in a VMA descriptor. */
 static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
 		vma_flags_t flags)
@@ -1207,7 +1223,7 @@ static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
  * vm_area_desc object describing a proposed VMA, e.g.:
  *
  * vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
- * 		VMA_DONTDUMP_BIT);
+ *		VMA_DONTDUMP_BIT);
  */
 #define vma_desc_set_flags(desc, ...) \
 	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index c46b523e428d..59788bc14d75 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -922,6 +922,15 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 #define vma_desc_test_any(desc, ...) \
 	vma_desc_test_any_mask(desc, mk_vma_flags(__VA_ARGS__))
 
+static inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
+		vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_test_all(desc, ...) \
+	vma_desc_test_all_mask(desc, mk_vma_flags(__VA_ARGS__))
+
 static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
 					   vma_flags_t flags)
 {
-- 
2.53.0


