Return-Path: <linux-fsdevel+bounces-38881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC343A09659
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97A716A66C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2277421322C;
	Fri, 10 Jan 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G4mG36iN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85818211A36;
	Fri, 10 Jan 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524057; cv=none; b=V2odBdGgF8NXNXNTzt4PHJvkqInqUgvAFyztb2ozd0QMRxkVLdHazzm3jZw7kPz1VMbXDvaZHHzVRcE9IrgIaOy4JKRZy1Q8NWjhEo375HzglEDCdjFTwI8g58Ie+VnVxICTBxn0r2obitI4b6UiF37wBsqtktjnR8r/nBGvd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524057; c=relaxed/simple;
	bh=PBXXx7pW7eA48iN3Hdo1hG7FWWvlkYwDQgtJNZjLljA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ms0BtGDASTeN/+kxgfmRaGpjP6LfuoOA/Q79ybgw+auYa5OejUTktBm0pX4zh1fGLWbLNzSHPUyIDdy6WJL7VHUEew2ahNO2Twd3TJdEPOq1R9ELRNZ1/kp6BdaEgXG9o6buWxWqXjepX6F3bnRP7k9ljn6iowMTfdmdFg4CVdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=G4mG36iN; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736524056; x=1768060056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cN9Hyj3eVGx1RuR/kRE7v7aHU8VJ+bo+4A0MAmXwMOI=;
  b=G4mG36iNkrNYEyo7CBS+AcKTke59e5065yEDoZIiZjKKKF2SydqxcNjh
   RXk5mugWz9KhKx/o2hMIHeTCkaJDAgZ+24Qh2cFRP2Lgd6k7hUod5wlP1
   8yfu+82DWi4Kusvx/hzy9P1bkuxxagRvp5SwAKoxuwZE60tEZ0eR2w/M/
   w=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="262160788"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 15:47:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:19422]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.22:2525] with esmtp (Farcaster)
 id 885983d0-7c00-418f-9f0d-8bbdfc3b2667; Fri, 10 Jan 2025 15:47:29 +0000 (UTC)
X-Farcaster-Flow-ID: 885983d0-7c00-418f-9f0d-8bbdfc3b2667
Received: from EX19D020UWA004.ant.amazon.com (10.13.138.231) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 15:47:27 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D020UWA004.ant.amazon.com (10.13.138.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 15:47:27 +0000
Received: from email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 10 Jan 2025 15:47:27 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com (Postfix) with ESMTPS id 9C2B34039B;
	Fri, 10 Jan 2025 15:47:25 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <willy@infradead.org>, <pbonzini@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <michael.day@amd.com>, <david@redhat.com>, <jthoughton@google.com>,
	<michael.roth@amd.com>, <ackerleytng@google.com>, <graf@amazon.de>,
	<jgowans@amazon.com>, <roypat@amazon.co.uk>, <derekmn@amazon.com>,
	<nsaenz@amazon.es>, <xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [RFC PATCH 2/2] KVM: guest_memfd: use filemap_grab_folios in write
Date: Fri, 10 Jan 2025 15:46:59 +0000
Message-ID: <20250110154659.95464-3-kalyazin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250110154659.95464-1-kalyazin@amazon.com>
References: <20250110154659.95464-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

The write syscall on guest_memfd makes use of filemap_grab_folios to
grab folios in batches.  This speeds up population by 8.3% due to the
reduction in locking and tree walking when adding folios to the
pagecache.

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 virt/kvm/guest_memfd.c | 176 +++++++++++++++++++++++++++++++++--------
 1 file changed, 143 insertions(+), 33 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e80566ef56e9..ccfadc3a7389 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -102,17 +102,134 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	return filemap_grab_folio(inode->i_mapping, index);
 }
 
+/*
+ * Returns locked folios on success.  The caller is responsible for
+ * setting the up-to-date flag before the memory is mapped into the guest.
+ * There is no backing storage for the memory, so the folios will remain
+ * up-to-date until they're removed.
+ *
+ * Ignore accessed, referenced, and dirty flags.  The memory is
+ * unevictable and there is no storage to write back to.
+ */
+static int kvm_gmem_get_folios(struct inode *inode, pgoff_t index,
+			       struct folio **folios, int num)
+{
+	return filemap_grab_folios(inode->i_mapping, index, folios, num);
+}
+
 #if defined(CONFIG_KVM_GENERIC_PRIVATE_MEM) && !defined(CONFIG_KVM_AMD_SEV)
+static int kvm_kmem_gmem_write_inner(struct inode *inode, pgoff_t index,
+				     const void __user *buf,
+                                     struct folio **folios, int num)
+{
+	int ret, i, num_grabbed, num_written;
+
+	num_grabbed = kvm_gmem_get_folios(inode, index, folios, num);
+	if (num_grabbed < 0)
+		return num_grabbed;
+
+	for (i = 0; i < num_grabbed; i++) {
+		struct folio *folio = folios[i];
+		void *vaddr;
+
+		if (folio_test_hwpoison(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			ret = -EFAULT;
+			break;
+		}
+
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			ret = -ENOSPC;
+			break;
+		}
+
+		folio_unlock(folio);
+
+		vaddr = kmap_local_folio(folio, 0);
+		ret = copy_from_user(vaddr, buf + (i << PAGE_SHIFT), PAGE_SIZE);
+		if (ret)
+			ret = -EINVAL;
+		kunmap_local(vaddr);
+
+		if (ret) {
+			folio_put(folio);
+			break;
+		} else {
+			kvm_gmem_mark_prepared(folio);
+			folio_put(folio);
+		}
+	}
+
+	num_written = i;
+
+	for (i = num_written; i < num_grabbed; i++) {
+		folio_unlock(folios[i]);
+		folio_put(folios[i]);
+	}
+
+	return num_written ?: ret;
+}
+
+static struct folio *kvm_kmem_gmem_write_folio(struct inode *inode, pgoff_t index,
+					       const char __user *buf)
+{
+	struct folio *folio;
+	void *vaddr;
+	int ret = 0;
+
+	folio = kvm_gmem_get_folio(inode, index);
+	if (IS_ERR(folio))
+		return ERR_PTR(-EFAULT);
+
+	if (folio_test_hwpoison(folio)) {
+		ret = -EFAULT;
+		goto out_unlock_put;
+	}
+
+	if (folio_test_uptodate(folio)) {
+		ret = -ENOSPC;
+		goto out_unlock_put;
+	}
+
+	folio_unlock(folio);
+
+	vaddr = kmap_local_folio(folio, 0);
+	ret = copy_from_user(vaddr, buf, PAGE_SIZE);
+	if (ret)
+		ret = -EINVAL;
+	kunmap_local(vaddr);
+
+	if (ret) {
+		folio_put(folio);
+		kvm_gmem_mark_prepared(folio);
+		goto out_err;
+	}
+
+	folio_put(folio);
+
+	return folio;
+
+out_unlock_put:
+	folio_unlock(folio);
+	folio_put(folio);
+out_err:
+	return ERR_PTR(ret);
+}
+
 static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
 				   size_t count, loff_t *offset)
 {
+	struct inode *inode = file_inode(file);
+	int ret = 0, batch_size = FILEMAP_GET_FOLIOS_BATCH_SIZE;
 	pgoff_t start, end, index;
-	ssize_t ret = 0;
 
 	if (!PAGE_ALIGNED(*offset) || !PAGE_ALIGNED(count))
 		return -EINVAL;
 
-	if (*offset + count > i_size_read(file_inode(file)))
+	if (*offset + count > i_size_read(inode))
 		return -EINVAL;
 
 	if (!buf)
@@ -123,9 +240,8 @@ static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
 
 	filemap_invalidate_lock(file->f_mapping);
 
-	for (index = start; index < end; ) {
-		struct folio *folio;
-		void *vaddr;
+	for (index = start; index + batch_size - 1 < end; ) {
+		struct folio *folios[FILEMAP_GET_FOLIOS_BATCH_SIZE] = { NULL };
 		pgoff_t buf_offset = (index - start) << PAGE_SHIFT;
 
 		if (signal_pending(current)) {
@@ -133,46 +249,40 @@ static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 
-		folio = kvm_gmem_get_folio(file_inode(file), index);
-		if (IS_ERR(folio)) {
-			ret = -EFAULT;
+		ret = kvm_kmem_gmem_write_inner(inode, index, buf + buf_offset, folios, batch_size);
+		if (ret < 0)
 			goto out;
-		}
 
-		if (folio_test_hwpoison(folio)) {
-			folio_unlock(folio);
-			folio_put(folio);
-			ret = -EFAULT;
+		index += ret;
+		if (ret < batch_size)
+			break;
+	}
+
+	for (; index < end; index++) {
+		struct folio *folio;
+		pgoff_t buf_offset = (index - start) << PAGE_SHIFT;
+
+		if (signal_pending(current)) {
+			ret = -EINTR;
 			goto out;
 		}
 
-		if (folio_test_uptodate(folio)) {
-			folio_unlock(folio);
-			folio_put(folio);
-			ret = -ENOSPC;
+		folio = kvm_kmem_gmem_write_folio(inode, index,
+						  buf + buf_offset);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
 			goto out;
 		}
-
-		folio_unlock(folio);
-
-		vaddr = kmap_local_folio(folio, 0);
-		ret = copy_from_user(vaddr, buf + buf_offset, PAGE_SIZE);
-		if (ret)
-			ret = -EINVAL;
-		kunmap_local(vaddr);
-
-		kvm_gmem_mark_prepared(folio);
-		folio_put(folio);
-
-		index = folio_next_index(folio);
-		*offset += PAGE_SIZE;
 	}
 
 out:
 	filemap_invalidate_unlock(file->f_mapping);
+	if (index > start) {
+		*offset += (index - start) << PAGE_SHIFT;
+		return (index - start) << PAGE_SHIFT;
+	}
 
-	return ret && start == (*offset >> PAGE_SHIFT) ?
-		ret : *offset - (start << PAGE_SHIFT);
+	return ret;
 }
 #endif
 
-- 
2.40.1


