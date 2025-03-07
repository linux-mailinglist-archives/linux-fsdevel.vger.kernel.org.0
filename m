Return-Path: <linux-fsdevel+bounces-43394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68628A55C8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 02:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05901898F35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 01:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8BB149C4A;
	Fri,  7 Mar 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="WW75kKEV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02E018A6A6;
	Fri,  7 Mar 2025 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309127; cv=none; b=H2pYr94MSqlncX+d1XjhPyTMHyjrv+LNS10P7SUbhG1kncK649HSukZNgHVCb0Lxn57XRxXXCzMclrYQLP6siblHt+kJL/gaHBlJ57u7NGPE5JhunBxqP9816uq22tdDlv7yg6y6vo2it0pQdgVQsSpWNojzRR9+I4+II4gc88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309127; c=relaxed/simple;
	bh=zDPtEVg/MaMKzIDcBmsu+Ksp5ZiaJWqHPkqXOcJ+wKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCFIezy2Ni6W124WLLR2KB+Vner0prptMXIFl+cguYNllx6znMhc82QKhFFIFSEecmaNAFzXiJxV02YOrGINF1T3TzJVQmsHG4ocs4MVCi+lXzqSBbJJv9el34tll/8FozOsojQzKvwU2fI0dLYXQLB4B5pvrrzrR3pk3531bG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=WW75kKEV; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741309125; x=1772845125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oXAk78z0pait+Woj/pzvjhLafLsZG4rU6PcvxTGAP2w=;
  b=WW75kKEVr19LwEX+8YZBcpldFnlHb5uQhTKuCTv46Zf1a5Z2XMZ+5bj5
   9XJrtp2EUzIl99PeAejBf29CUIvEMg7pf+zfyzEArJ4lh7YZa4bD/CemY
   sx1y7SH+pkfJgdIZn2otDDTEQZ6RMSKRXVNcsPSw9o3G2YVVh47+CLtnY
   g=;
X-IronPort-AV: E=Sophos;i="6.14,227,1736812800"; 
   d="scan'208";a="472783411"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:58:43 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:1261]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.251:2525] with esmtp (Farcaster)
 id ed8deb03-f964-450e-8c8f-083e6f99ea68; Fri, 7 Mar 2025 00:58:41 +0000 (UTC)
X-Farcaster-Flow-ID: ed8deb03-f964-450e-8c8f-083e6f99ea68
Received: from EX19D014EUA003.ant.amazon.com (10.252.50.119) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D014EUA003.ant.amazon.com (10.252.50.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 00:58:34 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTP id 72A2840294;
	Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 0A87A4FF0; Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Pratyush Yadav <ptyadav@amazon.de>, Jonathan Corbet <corbet@lwn.net>,
	"Eric Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Hugh Dickins <hughd@google.com>, Alexander Graf
	<graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David
 Woodhouse" <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, "Mike
 Rapoport" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, "Wei
 Yang" <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: [RFC PATCH 3/5] mm: shmem: allow callers to specify operations to shmem_undo_range
Date: Fri, 7 Mar 2025 00:57:37 +0000
Message-ID: <20250307005830.65293-4-ptyadav@amazon.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307005830.65293-1-ptyadav@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In a following patch, support for preserving a shmem file over kexec
handover (KHO) will be added. When a shmem file is to be preserved over
KHO, its pages must be removed from the inode's page cache and kept
reserved. That work is very similar to what shmem_undo_range() does. The
only extra thing that needs to be done is to track the PFN and index of
each page and get an extra refcount on the page to make sure it does not
get freed.

Refactor shmem_undo_range() to accept the ops it should execute for each
folio, along with a cookie to pass along. During undo, three distinct
kinds of operations are made: truncate a folio, truncate a partial
folio, truncate a folio in swap. Add a callback for each of the
operations. Add shmem_default_undo_ops that maintain the old behaviour,
and make callers use that.

Since the ops for KHO might fail (needing to allocate memory, or being
unable to bring a page back from swap for example), there needs to be a
way for them to report errors and stop the undo. Because of this, the
function returns an int instead of void. This has the unfortunate side
effect of implying this function can fail, though during normal usage,
it should never fail. Add some WARNs to ensure that if that assumption
ever changes, it gets caught.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---

Notes:
    I did it this way since it seemed to be duplicating the least amount of
    code. The undo logic is fairly complicated, and I was not too keen on
    replicating it elsewhere. On thinking about this again, I am not so sure
    if that was a good idea since the end result looks a bit complicated.

 mm/shmem.c | 165 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 134 insertions(+), 31 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4ea6109a80431..d6d9266b27b75 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1064,12 +1064,56 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 	return folio;
 }
 
+struct shmem_undo_range_ops {
+	/* Return -ve on error, or number of entries freed. */
+	long (*undo_swap)(struct address_space *mapping, pgoff_t index,
+			  void *old, void *arg);
+	/* Return -ve on error, 0 on success. */
+	int (*undo_folio)(struct address_space *mapping, struct folio *folio,
+			  void *arg);
+	/*
+	 * Return -ve on error, 0 if splitting failed, 1 if splitting succeeded.
+	 */
+	int (*undo_partial_folio)(struct folio *folio, pgoff_t lstart,
+				  pgoff_t lend, void *arg);
+};
+
+static long shmem_default_undo_swap(struct address_space *mapping, pgoff_t index,
+				    void *old, void *arg)
+{
+	return shmem_free_swap(mapping, index, old);
+}
+
+static int shmem_default_undo_folio(struct address_space *mapping,
+				    struct folio *folio, void *arg)
+{
+	truncate_inode_folio(mapping, folio);
+	return 0;
+}
+
+static int shmem_default_undo_partial_folio(struct folio *folio, pgoff_t lstart,
+					    pgoff_t lend, void *arg)
+{
+	/*
+	 * Function returns bool. Convert it to int and return. No error
+	 * returns needed here.
+	 */
+	return truncate_inode_partial_folio(folio, lstart, lend);
+}
+
+static const struct shmem_undo_range_ops shmem_default_undo_ops = {
+	.undo_swap = shmem_default_undo_swap,
+	.undo_folio = shmem_default_undo_folio,
+	.undo_partial_folio = shmem_default_undo_partial_folio,
+};
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
  */
-static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
-								 bool unfalloc)
+static int shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
+			    bool unfalloc,
+			    const struct shmem_undo_range_ops *ops, void *arg)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -1081,7 +1125,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	bool same_folio;
 	long nr_swaps_freed = 0;
 	pgoff_t index;
-	int i;
+	int i, ret = 0;
 
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
@@ -1099,17 +1143,31 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += shmem_free_swap(mapping,
-							indices[i], folio);
+
+				ret = ops->undo_swap(mapping, indices[i], folio,
+						     arg);
+				if (ret < 0) {
+					folio_unlock(folio);
+					break;
+				}
+
+				nr_swaps_freed += ret;
 				continue;
 			}
 
-			if (!unfalloc || !folio_test_uptodate(folio))
-				truncate_inode_folio(mapping, folio);
+			if (!unfalloc || !folio_test_uptodate(folio)) {
+				ret = ops->undo_folio(mapping, folio, arg);
+				if (ret < 0) {
+					folio_unlock(folio);
+					break;
+				}
+			}
 			folio_unlock(folio);
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
+		if (ret < 0)
+			goto out;
 		cond_resched();
 	}
 
@@ -1127,7 +1185,13 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	if (folio) {
 		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		folio_mark_dirty(folio);
-		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
+		ret = ops->undo_partial_folio(folio, lstart, lend, arg);
+		if (ret < 0) {
+			folio_unlock(folio);
+			folio_put(folio);
+			goto out;
+		}
+		if (ret == 0) {
 			start = folio_next_index(folio);
 			if (same_folio)
 				end = folio->index;
@@ -1141,7 +1205,14 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		folio = shmem_get_partial_folio(inode, lend >> PAGE_SHIFT);
 	if (folio) {
 		folio_mark_dirty(folio);
-		if (!truncate_inode_partial_folio(folio, lstart, lend))
+		ret = ops->undo_partial_folio(folio, lstart, lend, arg);
+		if (ret < 0) {
+			folio_unlock(folio);
+			folio_put(folio);
+			goto out;
+		}
+
+		if (ret == 0)
 			end = folio->index;
 		folio_unlock(folio);
 		folio_put(folio);
@@ -1166,18 +1237,21 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			folio = fbatch.folios[i];
 
 			if (xa_is_value(folio)) {
-				long swaps_freed;
-
 				if (unfalloc)
 					continue;
-				swaps_freed = shmem_free_swap(mapping, indices[i], folio);
-				if (!swaps_freed) {
+
+				ret = ops->undo_swap(mapping, indices[i], folio,
+						     arg);
+				if (ret < 0) {
+					break;
+				} else if (ret == 0) {
 					/* Swap was replaced by page: retry */
 					index = indices[i];
 					break;
+				} else {
+					nr_swaps_freed += ret;
+					continue;
 				}
-				nr_swaps_freed += swaps_freed;
-				continue;
 			}
 
 			folio_lock(folio);
@@ -1193,35 +1267,58 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 						folio);
 
 				if (!folio_test_large(folio)) {
-					truncate_inode_folio(mapping, folio);
-				} else if (truncate_inode_partial_folio(folio, lstart, lend)) {
-					/*
-					 * If we split a page, reset the loop so
-					 * that we pick up the new sub pages.
-					 * Otherwise the THP was entirely
-					 * dropped or the target range was
-					 * zeroed, so just continue the loop as
-					 * is.
-					 */
-					if (!folio_test_large(folio)) {
+					ret = ops->undo_folio(mapping, folio,
+							      arg);
+					if (ret < 0) {
 						folio_unlock(folio);
-						index = start;
 						break;
 					}
+				} else {
+					ret = ops->undo_partial_folio(folio, lstart, lend, arg);
+					if (ret < 0) {
+						folio_unlock(folio);
+						break;
+					}
+
+					if (ret) {
+						/*
+						 * If we split a page, reset the loop so
+						 * that we pick up the new sub pages.
+						 * Otherwise the THP was entirely
+						 * dropped or the target range was
+						 * zeroed, so just continue the loop as
+						 * is.
+						 */
+						if (!folio_test_large(folio)) {
+							folio_unlock(folio);
+							index = start;
+							break;
+						}
+					}
 				}
 			}
 			folio_unlock(folio);
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
+		if (ret < 0)
+			goto out;
 	}
 
+	ret = 0;
+out:
 	shmem_recalc_inode(inode, 0, -nr_swaps_freed);
+	return ret;
 }
 
 void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 {
-	shmem_undo_range(inode, lstart, lend, false);
+	int ret;
+
+	ret = shmem_undo_range(inode, lstart, lend, false,
+			       &shmem_default_undo_ops, NULL);
+
+	WARN(ret < 0, "shmem_undo_range() should never fail with default ops");
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	inode_inc_iversion(inode);
 }
@@ -3740,9 +3837,15 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			info->fallocend = undo_fallocend;
 			/* Remove the !uptodate folios we added */
 			if (index > start) {
-				shmem_undo_range(inode,
-				    (loff_t)start << PAGE_SHIFT,
-				    ((loff_t)index << PAGE_SHIFT) - 1, true);
+				int ret;
+
+				ret = shmem_undo_range(inode,
+						       (loff_t)start << PAGE_SHIFT,
+						       ((loff_t)index << PAGE_SHIFT) - 1,
+						       true,
+						       &shmem_default_undo_ops,
+						       NULL);
+				WARN(ret < 0, "shmem_undo_range() should never fail with default ops");
 			}
 			goto undone;
 		}
-- 
2.47.1


