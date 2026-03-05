Return-Path: <linux-fsdevel+bounces-79478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MICUKStgqWlc6QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:51:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20B21003B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D480303225A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4435F38424A;
	Thu,  5 Mar 2026 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzRe592d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFA384229;
	Thu,  5 Mar 2026 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707840; cv=none; b=UhDEN8vMOy4CKgRMbdfZEwS+TMzjs7qw/mDPTo+0dIh4TpA3ucks9WVIKqJLjX+seErP5rJzbEXuv9D2naGwQCicsWml6x/ST2zH3T0ZoNKc62UjMIVzFhN5tkefeWrQP2sHmkyweTUTAgGScw0PhcFJueGD8OH3eqFyiscP120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707840; c=relaxed/simple;
	bh=DYhXxlFibg/ph+ULNrBqyx61MpJC3w0/qL0oDFFaj48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KidtSYV4bn3fZZuVwUJGI8ayn0z/6+90Gp8vBOTLTT1Amw2ab46sQFs9bTSMB94nk5BmMc7a/gQNAgQE/eI9HuAqrYTthzW9IvpOdrb81S7xqNKqUbgGksGmHGyGkB8hPtvtIIWTR16jO6giQ+ED+WD1ujh0CWrRNTOTp2qvmmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzRe592d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B328C2BCB2;
	Thu,  5 Mar 2026 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707839;
	bh=DYhXxlFibg/ph+ULNrBqyx61MpJC3w0/qL0oDFFaj48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzRe592dIXMITxgi3/PMgCbLgnQE+I+PwMx0WtLY14sm0eiu04iJcrc8TQhUREmTw
	 pMUJVal4HNAiq1fs/UAY0/7GXh6sQzdNTGwpgGUnbBmhLhbeTp7nW342JH2E3TZsK2
	 QL52Vs6CB2ZADgGsvLkubcObTuz+czHasN1nAmuooUDg3xLhM4mkM6awtLec9H2q0o
	 R2nKhYT/awx8tr7NJjxrObPoyneblu4xJB0rwFgvYAXDpDaz1T2DOCgRZrzDZ0ZyCc
	 XcXhwWR/vWuMnRpspwy0ytUtb6G2tLgQ4NJhINCnUElVjKMQQHfwTfahU2F9VbnbQQ
	 PbvCFCm3KZCJQ==
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
Subject: [PATCH 3/6] mm: always inline __mk_vma_flags() and invoked functions
Date: Thu,  5 Mar 2026 10:50:16 +0000
Message-ID: <241f49c52074d436edbb9c6a6662a8dc142a8f43.1772704455.git.ljs@kernel.org>
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
X-Rspamd-Queue-Id: 7B20B21003B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79478-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Be explicit about __mk_vma_flags() (which is used by the mk_vma_flags()
macro) always being inline, as we rely on the compiler converting this
function into meaningful.

Also update all of the functions __mk_vma_flags() ultimately invokes to be
always inline too.

Note that test_bitmap_const_eval() asserts that the relevant bitmap
functions result in build time constant values.

Additionally, vma_flag_set() operates on a vma_flags_t type, so it is
inconsistently named versus other VMA flags functions.

We only use vma_flag_set() in __mk_vma_flags() so we don't need to worry
about its new name being rather cumbersome, so rename it to
vma_flags_set_flag() to disambiguate it from vma_flags_set().

Also update the VMA test headers to reflect the changes.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h                 | 8 +++++---
 include/linux/mm_types.h           | 2 +-
 tools/testing/vma/include/custom.h | 5 +++--
 tools/testing/vma/include/dup.h    | 5 +++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9a052eedcdf4..66b90de30bf6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1031,21 +1031,23 @@ static inline bool vma_test_atomic_flag(struct vm_area_struct *vma, vma_flag_t b
 }
 
 /* Set an individual VMA flag in flags, non-atomically. */
-static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
+static __always_inline void vma_flags_set_flag(vma_flags_t *flags,
+		vma_flag_t bit)
 {
 	unsigned long *bitmap = flags->__vma_flags;
 
 	__set_bit((__force int)bit, bitmap);
 }
 
-static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+static __always_inline vma_flags_t __mk_vma_flags(size_t count,
+		const vma_flag_t *bits)
 {
 	vma_flags_t flags;
 	int i;
 
 	vma_flags_clear_all(&flags);
 	for (i = 0; i < count; i++)
-		vma_flag_set(&flags, bits[i]);
+		vma_flags_set_flag(&flags, bits[i]);
 	return flags;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1a808d78245d..294efc22b2a4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1056,7 +1056,7 @@ struct vm_area_struct {
 } __randomize_layout;
 
 /* Clears all bits in the VMA flags bitmap, non-atomically. */
-static inline void vma_flags_clear_all(vma_flags_t *flags)
+static __always_inline void vma_flags_clear_all(vma_flags_t *flags)
 {
 	bitmap_zero(flags->__vma_flags, NUM_VMA_FLAG_BITS);
 }
diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index 802a76317245..833ff4d7f799 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -102,7 +102,8 @@ static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 		refcount_set(&vma->vm_refcnt, 0);
 }
 
-static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+static __always_inline vma_flags_t __mk_vma_flags(size_t count,
+		const vma_flag_t *bits)
 {
 	vma_flags_t flags;
 	int i;
@@ -114,6 +115,6 @@ static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
 	vma_flags_clear_all(&flags);
 	for (i = 0; i < count; i++)
 		if (bits[i] < NUM_VMA_FLAG_BITS)
-			vma_flag_set(&flags, bits[i]);
+			vma_flags_set_flag(&flags, bits[i]);
 	return flags;
 }
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 59788bc14d75..ef6b9d963acc 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -780,12 +780,13 @@ static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
 	*bitmap &= ~value;
 }
 
-static inline void vma_flags_clear_all(vma_flags_t *flags)
+static __always_inline void vma_flags_clear_all(vma_flags_t *flags)
 {
 	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
 }
 
-static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
+static __always_inline void vma_flags_set_flag(vma_flags_t *flags,
+		vma_flag_t bit)
 {
 	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
 
-- 
2.53.0


