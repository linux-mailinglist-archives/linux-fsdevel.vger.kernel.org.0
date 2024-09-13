Return-Path: <linux-fsdevel+bounces-29349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E1978701
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 19:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEA51C242F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D8B126BEA;
	Fri, 13 Sep 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="hMBe0VNy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1C1C2BF;
	Fri, 13 Sep 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249214; cv=none; b=L4ESj/sszaLwfYFKv+O2ossm7LRJcDHvmH3gCHSh/3J97LSxPAdKNu2RNccqH016pQVzRZvX/mq22UZhEkFclkwBBYFet2cK6UvohyGIdcRbD13ZHokojtqAtTCBPlGNYRhsEnv3pPq40g9Hzbfhctwu6+aw58QRSox3qnTOxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249214; c=relaxed/simple;
	bh=XcuFu7CBhGrA7Vf6zHDY6IJb0fmDzn8wCNN4pukLdqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FZwS9qUr1vpSa1Djl1w1IyPkvZaHkeSc2wl6QPrnpKRObW1Uq8I6xy6gHoEh4SiHdy9eA66YbnjNY75DluIDCb8yGJ1lXMU/VOUFB4F5gLJP7un6mWFXiEZsUmQjLzMO0+k4x/2gae8bFOCWPNTuc4cpY8+rIsKmDnuAPAXb8MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=hMBe0VNy; arc=none smtp.client-ip=173.37.86.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5433; q=dns/txt; s=iport;
  t=1726249213; x=1727458813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Een6jqFsAIKR9yxn1aG6e3vj/VQBH6dT7iePuwzEn3o=;
  b=hMBe0VNyB/fQa08Ua3ZFnjdqMiKQGMowKteCQaC6TgWIgHiAWrlMQfiT
   yoaA5H7XyeP/EokRLGilB0MTybibkz5we89a8DoQt9kMlENQMcB2ZaR6w
   Dx8yaAGtg98nlcRnxTY2BxKtEsUdx9FGMaKFew7GMWGmIV60brsULxROC
   c=;
X-CSE-ConnectionGUID: x9C4BFYkTUih79vTmhhsFA==
X-CSE-MsgGUID: fr+wke/nSsmb1In6dACamg==
X-IPAS-Result: =?us-ascii?q?A0DEAADkd+RmmJNdJa1agliEGkNIlkOBFpA0jE2BJQNWD?=
 =?us-ascii?q?wEBAQ9EBAEBhQeJfgImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQUBAQUBAQECA?=
 =?us-ascii?q?QcFFAEBAQEBAQEBNwUOO4YChl4hCgsBRimBFBMUgm2CZQOvdoF5M4EBhHrZO?=
 =?us-ascii?q?IFsGIEwjUKFZScbgUlEgRWBO4E3dosHBIYYhUKDDhZwhC0KiVQliVqPQ0iBI?=
 =?us-ascii?q?QNZIQIRAVUTDQoLCQWJOYMmKYFrgQqDC4UngWcJYYhOgQgtgRGBHzqCAoE3S?=
 =?us-ascii?q?oVNgQaCU2tOPAINAjeCKYETglqENUADCxgNSBEsNRQbBj5uB6tuR4FCAQVtL?=
 =?us-ascii?q?RBRFGZDPBgfCy4LAjCSNiQDj3CCHqB9hCGhOxozhAWTf5JAAZh1ox00FB01h?=
 =?us-ascii?q?GaBZzqBWzMaCBsVO4JnUhkPji0NCc9RJjI7AgcLAQEDCY1fAQE?=
IronPort-Data: A9a23:CnUytajECA68GBcalX4TI4T/X161qxAKZh0ujC45NGQN5FlHY01je
 htvX27VOfeCNGamf9BzPNm//UlX6p6Gn9JgTwA5/ikwE3tjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1HwdOGn9SQhvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSHULOZ82QsaD5MuvvY8EgHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUIq80rK09/9
 sAlKTBSPw6/guK225ySH7wEasQLdKEHPasFsX1miDreF/tjGMmFSKTR7tge1zA17ixMNa+BP
 IxCNnw+N1KZP0In1lQ/UPrSmM+og3jlej9wo1OOrq1x6G/WpOB0+OKwaoOKJoTRFa25mG6Wv
 CHZ/Gm+BCoBMdbG6Dzb/luHj+rAyHaTtIU6T+DgqaUw3zV/3Fc7DBwQSEv+r+K1h1CzX/pBJ
 EEOvCkjt64/8AqsVNaVdxm5pmOU+x0RQdxdF8Uk5wyXjKnZ+QCUAi4DVDEpQNUlrMoeQT0sy
 0/MkdT0AzBmrLySTzSa7Lj8kN+pETIeIWlHbigeQE5cup/ooZo4iVTESdML/LOJYsPdCWDbn
 xqknSsCurQT0p8V66C7/Uvpqmf5znTWdTId6gLSV2Ojywp2Yo+5eoClgWQ3C94ed+51qXHf4
 BA5d9ii0QwYMX2aeMWwrAglBrql4bOONyfRxAc2WZIg7D+qvXWkeOi8AQ2Sxm83bK7omhewP
 Cc/XD+9ArcIYBNGiocsP+qM5zwCl/SIKDgcfqm8giBySpZwbhSb2ypleFSd2Wvg+GB1zvthY
 MnGIJvxXSdAYUiC8NZQb7pAuVPM7n1vrV4/ubihknxLLJLHPifMEuZfWLdwRrtgvf3ayOkqz
 zqvH5DXk0oECrKWjtj/+o8IJldCNmkgGZ3zsIRWcOXFSjeK60l/Y8I9NYgJItQ/94wMz7+g1
 ijkBidwlgGl7VWZclriV5yWQO61NXqJhShlbXVE0JfB8yVLXLtDG49EJ8JqJuZ8qr09pRO2J
 tFcE/i97j10Ymyv01wggVPV9eSOqDzDadqyAheY
IronPort-HdrOrdr: A9a23:v72nB6vWmWZVcH7IkhlZUhOb7skDedV00zEX/kB9WHVpmwKj+/
 xG+85rtyMc5wx+ZJhNo7q90cq7MBDhHOBOgLX5VI3KNGLbUQCTQ72Kg7GO/9TIIVyaygck78
 ddm2wUMqyWMbC85vyKhDWFLw==
X-Talos-CUID: =?us-ascii?q?9a23=3AFmRazmlXEDCLjdqBzMU+O6LujfnXOW2M5yv6DX6?=
 =?us-ascii?q?7NVtoSOLEV2OV+KN/veM7zg=3D=3D?=
X-Talos-MUID: 9a23:rhpi4AixUBMgUsegcm08ZsMpOt0r/KejT0Y2ipAM4uiCayBZED6Yg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,226,1719878400"; 
   d="scan'208";a="252174038"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 17:40:05 +0000
Received: from sjc-ads-7729.cisco.com (sjc-ads-7729.cisco.com [10.30.222.16])
	by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id 48DHe4uw017907;
	Fri, 13 Sep 2024 17:40:04 GMT
From: Haider Miraj <hmiraj@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: xe-linux-external@cisco.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] [RFC] proc: Add mmap callback for /proc/<pid>/mem
Date: Fri, 13 Sep 2024 10:40:03 -0700
Message-Id: <20240913174003.1786581-1-hmiraj@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.222.16, sjc-ads-7729.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com

This patch introduces memory mapping (mmap) support for the /proc/<pid>/mem
interface. The new functionality allows users to map the memory of a
process into their address space reusing the same pages

The idea is to mmap another process's memory by first pinning the pages in
memory and then using `remap_pfn_range` to map them as device memory, reusing
the same pages. A list of pinned pages is maintained and released back on the
close call. This design has certain limitations.

I am seeking comments and advice on the following:
- Given that read access to `/proc/<pid>/mem` is already allowed for
  privileged users, are there specific reasons or concerns that have prevented
  the implementation of `mmap` for this interface?
- Is there a way to insert anonymous pages into a file-backed VMA so that it
  honors reverse mapping, eliminating the need to keep track of pinned pages?
- I plan to implement a page fault handler as well.

I am looking for feedback on how to improve this implementation and what
additional considerations are necessary for it to be accepted by the community.

Cc: xe-linux-external@cisco.com
Signed-off-by: Haider Miraj <hmiraj@cisco.com>
---
 fs/proc/base.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..405de47d0c1c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -117,6 +117,17 @@
 static u8 nlink_tid __ro_after_init;
 static u8 nlink_tgid __ro_after_init;
 
+struct vma_info {
+	struct list_head page_list_head;
+	uintptr_t vma_start_addr;
+	uintptr_t vma_end_addr;
+};
+
+struct page_list_item {
+	struct list_head list;
+	struct page *page;
+};
+
 struct pid_entry {
 	const char *name;
 	unsigned int len;
@@ -926,12 +937,130 @@ static int mem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static void mem_vma_close(struct vm_area_struct *vma)
+{
+	struct vma_info *info;
+	struct page_list_item *item, *tmp;
+
+	info = vma->vm_private_data;
+
+	if (info) {
+		/* Avoid cleanup if we are being split, instead print warning */
+		if (info->vma_start_addr == vma->vm_start &&
+			info->vma_end_addr == vma->vm_end) {
+			/* Iterate over the list and free each item and call put_page */
+			list_for_each_entry_safe(item, tmp,
+						 &info->page_list_head, list) {
+				list_del(&item->list);
+				put_page(item->page);
+				kfree(item);
+			}
+
+			kfree(info);
+			vma->vm_private_data = NULL;
+		} else {
+			pr_warn("%s: VMA has been split, operation not supported\n", __func__);
+		}
+	}
+}
+
+static const struct vm_operations_struct mem_vm_ops = {
+	.close = mem_vma_close,
+};
+
+/**
+ * mem_mmap - Memory mapping function
+ *
+ * This function implements mmap call for /proc/<pid>/mem.
+ *
+ * Assumptions and Limitations:
+ * - This function does not handle reverse mapping, which is required for swapping.
+ * - The VMA is not expected to be split with an unmap call.
+ */
+static int mem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	uintptr_t addr, target_start_addr, target_end_addr;
+	struct page_list_item *item;
+	struct page *page, *zero_page;
+	unsigned long zero_page_pfn;
+	struct vma_info *info;
+	long pinned;
+	int ret;
+
+	/* Retrieve mm of the target process*/
+	struct mm_struct *mm = (struct mm_struct *)file->private_data;
+	size_t size = vma->vm_end - vma->vm_start;
+	uintptr_t start_addr = vma->vm_start;
+
+	target_start_addr = vma->vm_pgoff << PAGE_SHIFT; /* Multiply by PAGE_SIZE */
+	target_end_addr = target_start_addr + size;
+
+	if (!mm)
+		return -EINVAL;
+
+	info = kmalloc(sizeof(struct vma_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&info->page_list_head);
+	info->vma_start_addr = vma->vm_start;
+	info->vma_end_addr = vma->vm_end;
+
+	vma->vm_private_data = info;
+	vma->vm_ops = &mem_vm_ops;
+
+	zero_page = ZERO_PAGE(0);
+	zero_page_pfn = page_to_pfn(zero_page);
+
+	/* Acquire the mmap_lock before pinning the page (get_user_pages_remote) */
+	down_read(&mm->mmap_lock);
+
+	for (addr = target_start_addr; addr < target_end_addr; addr += PAGE_SIZE) {
+		unsigned long pfn;
+
+		/* Pin the user page */
+		pinned = get_user_pages_remote(mm, addr, 1, FOLL_GET | FOLL_NOFAULT,
+						&page, NULL, NULL);
+		/* Page is not resident (FOLL_NOFAULT), we will skip to the next address */
+		if (pinned <= 0) {
+			ret = remap_pfn_range(vma, start_addr, zero_page_pfn, PAGE_SIZE,
+					vma->vm_page_prot);
+			if (ret)
+				goto err_unlock;
+			start_addr += PAGE_SIZE;
+			continue;
+		}
+
+		/* We need to keep track of pages which are pinned */
+		item = kmalloc(sizeof(struct page_list_item), GFP_KERNEL);
+		if (!item) {
+			kfree(info);
+			return -ENOMEM;
+		}
+
+		item->page = page;
+		list_add(&item->list, &info->page_list_head);
+		pfn = page_to_pfn(page);
+
+		/* Remap the page frame under current vma */
+		ret = remap_pfn_range(vma, start_addr, pfn, PAGE_SIZE,
+					vma->vm_page_prot);
+		if (ret)
+			kfree(item);
+
+		start_addr += PAGE_SIZE;
+	}
+err_unlock:
+	up_read(&mm->mmap_lock);
+	return 0;
+}
+
 static const struct file_operations proc_mem_operations = {
 	.llseek		= mem_lseek,
 	.read		= mem_read,
 	.write		= mem_write,
 	.open		= mem_open,
 	.release	= mem_release,
+	.mmap		= mem_mmap,
 };
 
 static int environ_open(struct inode *inode, struct file *file)
-- 
2.35.6


