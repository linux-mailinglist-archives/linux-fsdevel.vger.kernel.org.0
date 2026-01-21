Return-Path: <linux-fsdevel+bounces-74781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHUtG+BxcGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:27:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B61520B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 526FD4A40B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF2C43DA2E;
	Wed, 21 Jan 2026 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eb+tRD/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92844105F
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768976835; cv=none; b=Fuy51SXSDg574/tuARHooeoVwbk/lech5BaZtZwVgrSpz1wssR2ChKHYBA0aF0PF0Wm8VY4wmJKzDZWZJlzPBOE5oloUfm2UNYmCa0bRAgvNsUw9Ily0rVjh+pUW5hP5HVZlL5Qb4IOBEbR82XLeGSYfCKeOclSq30nkGF7YiRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768976835; c=relaxed/simple;
	bh=F/e/1SQuPlXVM0fbpmrX8eyhOkpYxwKnYyBNKMtSO1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SVKT8tDoYqle3HKrVtLIXLVo9W1higCRbGzIqPWawsDjD9mM+rk0fD9noZeU6SJIp+cD9ovLKCpLh5CH4uiLwA2Sm6EWiZ7rLkopuPsuHJK2yydLDvwJoMZOHSErQj9A17ss4q+/6aK9x1Kwe60Ow1YBlgnlKJIGgAJ1AjgSjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eb+tRD/e; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qyo1UXxvb80ZNtm/KnUth+3Ew/cM0x9cJHvAGUTak5g=;
	b=eb+tRD/eivjXTKEyxjwn/9SYlw6P2b7VcP22XoR/Ovy3xm6Qht9REnU6iMn3JgkCNq/gYGpZp
	5pS0xlvCRC28HMJW1t8OHh0L1qnzoXfoP6rM5C3hPNuNPlxChTN0I1ohu2qUMyxkeer7OWlJMUq
	O+4T5QaPJcUKv8aGfJDQcbM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dwvJT0PjSz1T4H4;
	Wed, 21 Jan 2026 14:23:05 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 8913740588;
	Wed, 21 Jan 2026 14:27:07 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 14:27:06 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <willy@infradead.org>, <akpm@linux-foundation.org>, <david@kernel.org>,
	<lorenzo.stoakes@oracle.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <Liam.Howlett@oracle.com>,
	<npache@redhat.com>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
	<baohua@kernel.org>, <lance.yang@linux.dev>, <shardul.b@mpiricsoftware.com>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
CC: <wangkefeng.wang@huawei.com>, <tujinjiang@huawei.com>
Subject: [RFC PATCH] mm/khugepaged: free empty xa_nodes when rollbacks in collapse_file
Date: Wed, 21 Jan 2026 14:22:43 +0800
Message-ID: <20260121062243.1893129-1-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500001.china.huawei.com (7.202.194.229)
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-74781-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[tujinjiang@huawei.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,huawei.com:email,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: 42B61520B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

collapse_file() calls xas_create_range() to pre-create all slots needed.
If collapse_file() finally fails, these pre-created slots are empty nodes
and aren't destroyed.

I can reproduce it with following steps.
1) create file /tmp/test_madvise_collapse and ftruncate to 4MB size, and
then mmap the file
2) memset for the first 2MB
3) madvise(MADV_COLLAPSE) for the second 2MB
4) unlink the file

in 3), collapse_file() calls xas_create_range() to expand xarray depth, and
fails to collapse due to the whole 2M region is empty. collapse_file()
rollback path doesn't destroy the pre-created empty nodes.

When the file is deleted, shmem_evict_inode()->shmem_truncate_range()
traverses all entries and calls xas_store(xas, NULL) to delete, if the leaf
xa_node that stores deleted entry becomes emtry, xas_store() will
automatically delete the empty node and delete it's  parent is empty too,
until parent node isn't empty. shmem_evict_inode() won't traverse the empty
nodes created by xas_create_range() due to these nodes doesn't store any
entries. As a result, these empty nodes are leaked.

We couldn't simply destroy empty nodes in rollback path, because xarray
lock is released and re-held several times in collapse_file(). Another
collapse_file() call may take concurrently, and those empty nodes may
be needed by the another collapse_file() call.

To fix it, move xas_create_range() call just before update new_folio to
xarray, to guarantee collapse_file() doesn't unlock xarray lock
temporarily. Besides, xas_create_range() may fails too, we don't unlock
xarray lock and retry again, just destroy the new created empty xa_nodes
with xarray lock held to prevent any concurrency.

Fixes: 77da9389b9d5 ("mm: Convert collapse_shmem to XArray")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
---
 include/linux/xarray.h |  1 +
 lib/xarray.c           | 19 +++++++++++++++++++
 mm/khugepaged.c        | 36 +++++++++++++++++++-----------------
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index be850174e802..972df5ceeb84 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1555,6 +1555,7 @@ void xas_destroy(struct xa_state *);
 void xas_pause(struct xa_state *);
 
 void xas_create_range(struct xa_state *);
+void xas_destroy_range(struct xa_state *xas, unsigned long start, unsigned long end);
 
 #ifdef CONFIG_XARRAY_MULTI
 int xa_get_order(struct xarray *, unsigned long index);
diff --git a/lib/xarray.c b/lib/xarray.c
index 9a8b4916540c..e6126052f141 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -752,6 +752,25 @@ void xas_create_range(struct xa_state *xas)
 }
 EXPORT_SYMBOL_GPL(xas_create_range);
 
+void xas_destroy_range(struct xa_state *xas, unsigned long start, unsigned long end)
+{
+	unsigned long index;
+	void *entry;
+
+	for (index = start; index < end; ++index) {
+		xas_set(xas, index);
+		entry = xas_load(xas);
+		if (entry)
+			continue;
+
+		if (!xas->xa_node || xas_invalid(xas))
+			continue;
+
+		if (!xas->xa_node->count)
+			xas_delete_node(xas);
+	}
+}
+
 static void update_node(struct xa_state *xas, struct xa_node *node,
 		int count, int values)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 97d1b2824386..969058088eee 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1863,7 +1863,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	struct folio *folio, *tmp, *new_folio;
 	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
-	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
+	XA_STATE(xas, &mapping->i_pages, 0);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
 
@@ -1882,22 +1882,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	new_folio->index = start;
 	new_folio->mapping = mapping;
 
-	/*
-	 * Ensure we have slots for all the pages in the range.  This is
-	 * almost certainly a no-op because most of the pages must be present
-	 */
-	do {
-		xas_lock_irq(&xas);
-		xas_create_range(&xas);
-		if (!xas_error(&xas))
-			break;
-		xas_unlock_irq(&xas);
-		if (!xas_nomem(&xas, GFP_KERNEL)) {
-			result = SCAN_FAIL;
-			goto rollback;
-		}
-	} while (1);
-
+	xas_lock_irq(&xas);
 	for (index = start; index < end;) {
 		xas_set(&xas, index);
 		folio = xas_load(&xas);
@@ -2194,6 +2179,23 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		xas_lock_irq(&xas);
 	}
 
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
+	xas_create_range(&xas);
+	if (xas_error(&xas)) {
+		xas_set_order(&xas, start, 0);
+		if (nr_none) {
+			for (index = start; index < end; index++) {
+				if (xas_next(&xas) == XA_RETRY_ENTRY)
+					xas_store(&xas, NULL);
+			}
+		}
+		xas_destroy_range(&xas, start, end);
+		xas_unlock_irq(&xas);
+		result = SCAN_FAIL;
+
+		goto rollback;
+	}
+
 	if (is_shmem)
 		lruvec_stat_mod_folio(new_folio, NR_SHMEM_THPS, HPAGE_PMD_NR);
 	else
-- 
2.43.0


