Return-Path: <linux-fsdevel+bounces-38267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9548A9FE52C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 11:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB893A1F0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C781A3BC0;
	Mon, 30 Dec 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H4Ro4E+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062931A0728
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735553498; cv=none; b=E1H34SVYKXGYlAus7mpIADG6F15tL0CmtLc9/5ITiCQ05I9Fr/1MJvIJLBVF3WFt25IQ2hb3n8CFCOwCRPMgMid1GMJfZ5X4GBnZXM0mHqWSwE8vxeOhPOA9bJFRDkwPZ15dye2XirlHcopEPLD+jHijXRdcATJsXoJcfnzcx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735553498; c=relaxed/simple;
	bh=o7ArtUZXxuucJZFRat3oYyC/ucZYiLYDAWi6MjCcjY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=uye7B/VCOx2gfHRfrb0suAT/LNxHw/uuFrFnbivdGpIR/ygKsGan5aA3yrEl7jXC0ED26MF2ylON25hySaET4+gt4gGXp0S5CMHa+OvB/vL/3jeNEV10ASv8srll5qIRfQqSXJSw6ix/BEH090IPhH5NUPvVmT4cMRn4laMVw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=H4Ro4E+j; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241230101132epoutp04b9475b9cc47c1752758fa4d0976d0e03~V7LTJ6pKr0567705677epoutp04x
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 10:11:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241230101132epoutp04b9475b9cc47c1752758fa4d0976d0e03~V7LTJ6pKr0567705677epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1735553492;
	bh=EFRBiDgKYImOx8Br/vOz/mESdqSm5gtt2bMqsIhy7gk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=H4Ro4E+jK9OzQEJkkerXCrMf7cL0CMXm33WEMTBR6vGbBjajdcBbKImzWso2qJFT8
	 Te6Q4+ZwsnP6S0wbRoTmrRmWVvdMMJAH9IPCWP0GpRk3ZCLVyek5I154G62V6i/bPK
	 5557fa2g0vu2gGjfbxDaXO7QQD5TO3Tgq90C6j/s=
Received: from epsmgec5p1new.samsung.com (unknown [182.195.42.68]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241230101131epcas5p44adc64fac7c45a222fc92b0c7e463a03~V7LSg1CWd3097130971epcas5p4g;
	Mon, 30 Dec 2024 10:11:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FA.14.19710.3D172776; Mon, 30 Dec 2024 19:11:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241230101102epcas5p1c879ea11518951971c8f1bf3dbc3fe39~V7K2-lIGT0213902139epcas5p1d;
	Mon, 30 Dec 2024 10:11:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241230101102epsmtrp1fbef31ef58f36203384008c5a4e11d1a~V7K2_wxz32371223712epsmtrp12;
	Mon, 30 Dec 2024 10:11:02 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-f3-677271d39e90
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	23.9C.18729.5B172776; Mon, 30 Dec 2024 19:11:02 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241230101058epsmtip1b5aaea1f9588d4ba67356f1459c6e936~V7Kzrb3GZ1811518115epsmtip1D;
	Mon, 30 Dec 2024 10:10:58 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: viro@zeniv.linux.org.uk, elver@google.com, brauner@kernel.org,
	jack@suse.cz, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, r.thapliyal@samsung.com, Maninder Singh
	<maninder1.s@samsung.com>
Subject: [PATCH 1/1] lib/list_debug.c: add object information in case of
 invalid object
Date: Mon, 30 Dec 2024 15:40:43 +0530
Message-Id: <20241230101043.53773-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7bCmuu7lwqJ0gyfXDS3mrF/DZvH68CdG
	i7Yz21ktZk9vZrLYs/cki8XlXXPYLO6t+c9qcXh+G4vFxnvZFuf/Hmd14PJYsKnUY9OqTjaP
	TZ8msXucmPGbxaNvyypGjzMLjrB7fN4k57HpyVumAI4oLpuU1JzMstQifbsEroz+P79ZCjpM
	K2Yc/crYwPhWq4uRk0NCwETi+PpZzCC2kMBuRok3n5Ih7E+MEg2rgOJcQPY3Ron1e5YxwjRc
	/dXCBJHYyyjxef13FgjnC6PE0U8PWUCq2AT0JFbt2gNmiwjkSKw8e4oVpIhZYBajxK8/S9hB
	EsICkRJvj+1nArFZBFQlfh5YyAZi8wrYSOxbcYsJYp28xMxL39kh4oISJ2c+ARvKDBRv3job
	7D4JgZ/sEvvbPrJANLhI7O3dxwxhC0u8Or6FHcKWknjZ3wZkcwDZ5RJbJ9RD9LYwSuyfM4UN
	osZe4snFhawgNcwCmhLrd+lDhGUlpp5axwSxl0+i9/cTqNt4JXbMg7FVJVpubmCFsKUlPn+E
	OcdD4sy6pSyQMI2V6FzfwTaBUX4WkndmIXlnFsLmBYzMqxglUwuKc9NTk00LDPNSy/WKE3OL
	S/PS9ZLzczcxghOSlssOxhvz/+kdYmTiYDzEKMHBrCTCey6pIF2INyWxsiq1KD++qDQntfgQ
	ozQHi5I47+vWuSlCAumJJanZqakFqUUwWSYOTqkGJpPTZsnNfzm+qfG31iz/9uvHT4+Ddtp9
	P2cr67C1zdwioT19Gt9DjeTD1684bxE7lN1/setZY3Ob2anbFhO1dvza/fqWY3HxH1brR/wL
	5HfFVWk9Ue4UsJkywcLFquIA02WRDcltlr7tZyc7rOHZZWF7c8dFy+UZScml0h6PUjKvCa90
	2y8Ye/q4pX3Yuqhu31jrmiWfAhTv3dzSKrR+2jOn/h7ZObyVHm6P/p/9qHneeObBl06bog//
	XHXTSuanx+cDa4+ErPCUXX46z6okr+au4FSbZO/wkt6d1854xrw8JxkT+7zXrL4jK6XA48Xx
	XbMdnI9xKXdb+6d9mrLh1bsV7/sPpT//euyndOwcWyWW4oxEQy3mouJEAN8IGw23AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSnO62wqJ0g38LRCzmrF/DZvH68CdG
	i7Yz21ktZk9vZrLYs/cki8XlXXPYLO6t+c9qcXh+G4vFxnvZFuf/Hmd14PJYsKnUY9OqTjaP
	TZ8msXucmPGbxaNvyypGjzMLjrB7fN4k57HpyVumAI4oLpuU1JzMstQifbsEroz+P79ZCjpM
	K2Yc/crYwPhWq4uRk0NCwETi6q8Wpi5GLg4hgd2MEgsfz2KDSEhL/Pz3ngXCFpZY+e85O0TR
	J0aJUwcvghWxCehJrNq1B6xIRKBIYtm5BSwgRcwC8xgl2rf1sYIkhAXCJb5s3cwEYrMIqEr8
	PLAQrJlXwEZi34pbTBAb5CVmXvrODhEXlDg58wnYUGagePPW2cwTGPlmIUnNQpJawMi0ilEy
	taA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOMC1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHec0kF
	6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqYPHyXPAu9
	9oP7xkqhK7vK7Q+48DhYXL5coVcvnG/RW/O94JDEUglLa4FZZrp/dit0F7J6B/hk55Wfenua
	49vXP2UvT76a1n+sXLUz+aQK28uzYTKW//O6g2eu7GP8GreVb1ZPCZ+n5dH8FxqJ8ad5dz9Y
	86dk79stWblX52j56tRdqVjb171fv1fi3SxBQ+v6T7fWZWrOO6luseJX7b7of1F/RHpndxxS
	YDr+Yq+A/fW92/uvM5gur+xull7xKuasVsOEG6v/P+lp87LvEr2hvJDDeu0rDwWmeTMZ6iWe
	l4nytHotU29kP6XprPfAJJZjgvNPU97YYKUUj7wQU/XdX0xOtN55Po19tecuu39KLMUZiYZa
	zEXFiQAus5xh3wIAAA==
X-CMS-MailID: 20241230101102epcas5p1c879ea11518951971c8f1bf3dbc3fe39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20241230101102epcas5p1c879ea11518951971c8f1bf3dbc3fe39
References: <CGME20241230101102epcas5p1c879ea11518951971c8f1bf3dbc3fe39@epcas5p1.samsung.com>

As of now during link list corruption it prints about cluprit address
and its wrong value, but sometime it is not enough to catch the actual
issue point.

If it prints allocation and free path of that corrupted node,
it will be a lot easier to find and fix the issues.

Adding the same information when data mismatch is found in link list
debug data:

[   14.243055]  slab kmalloc-32 start ffff0000cda19320 data offset 32 pointer offset 8 size 32 allocated at add_to_list+0x28/0xb0
[   14.245259]     __kmalloc_cache_noprof+0x1c4/0x358
[   14.245572]     add_to_list+0x28/0xb0
...
[   14.248632]     do_el0_svc_compat+0x1c/0x34
[   14.249018]     el0_svc_compat+0x2c/0x80
[   14.249244]  Free path:
[   14.249410]     kfree+0x24c/0x2f0
[   14.249724]     do_force_corruption+0xbc/0x100
...
[   14.252266]     el0_svc_common.constprop.0+0x40/0xe0
[   14.252540]     do_el0_svc_compat+0x1c/0x34
[   14.252763]     el0_svc_compat+0x2c/0x80
[   14.253071] ------------[ cut here ]------------
[   14.253303] list_del corruption. next->prev should be ffff0000cda192a8, but was 6b6b6b6b6b6b6b6b. (next=ffff0000cda19348)
[   14.254255] WARNING: CPU: 3 PID: 84 at lib/list_debug.c:65 __list_del_entry_valid_or_report+0x158/0x164

moved prototype of mem_dump_obj() to bug.h, as mm.h can not be included
in bug.h.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
Comment: I am not sure about moving of prototype, we can make a new wrapper also,
so please suggest what is best option. because name mem_dump_obj does
not go with bug.h

 fs/open.c           |  2 +-
 fs/super.c          |  2 +-
 include/linux/bug.h | 10 +++++++++-
 include/linux/mm.h  |  6 ------
 lib/list_debug.c    | 22 +++++++++++-----------
 5 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 0a5d2f6061c6..932e5a6de63b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1529,7 +1529,7 @@ static int filp_flush(struct file *filp, fl_owner_t id)
 {
 	int retval = 0;
 
-	if (CHECK_DATA_CORRUPTION(file_count(filp) == 0,
+	if (CHECK_DATA_CORRUPTION(file_count(filp) == 0, filp,
 			"VFS: Close: file count is 0 (f_op=%ps)",
 			filp->f_op)) {
 		return 0;
diff --git a/fs/super.c b/fs/super.c
index c9c7223bc2a2..5a7db4a556e3 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -647,7 +647,7 @@ void generic_shutdown_super(struct super_block *sb)
 		 */
 		fscrypt_destroy_keyring(sb);
 
-		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes),
+		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes), NULL,
 				"VFS: Busy inodes after unmount of %s (%s)",
 				sb->s_id, sb->s_type->name)) {
 			/*
diff --git a/include/linux/bug.h b/include/linux/bug.h
index 348acf2558f3..a9948a9f1093 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -73,15 +73,23 @@ static inline void generic_bug_clear_once(void) {}
 
 #endif	/* CONFIG_GENERIC_BUG */
 
+#ifdef CONFIG_PRINTK
+void mem_dump_obj(void *object);
+#else
+static inline void mem_dump_obj(void *object) {}
+#endif
+
 /*
  * Since detected data corruption should stop operation on the affected
  * structures. Return value must be checked and sanely acted on by caller.
  */
 static inline __must_check bool check_data_corruption(bool v) { return v; }
-#define CHECK_DATA_CORRUPTION(condition, fmt, ...)			 \
+#define CHECK_DATA_CORRUPTION(condition, addr, fmt, ...)		 \
 	check_data_corruption(({					 \
 		bool corruption = unlikely(condition);			 \
 		if (corruption) {					 \
+			if (addr)					 \
+				mem_dump_obj(addr);			 \
 			if (IS_ENABLED(CONFIG_BUG_ON_DATA_CORRUPTION)) { \
 				pr_err(fmt, ##__VA_ARGS__);		 \
 				BUG();					 \
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d61b9c7a3a7b..9cabab47a23e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4097,12 +4097,6 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 
 extern int sysctl_nr_trim_pages;
 
-#ifdef CONFIG_PRINTK
-void mem_dump_obj(void *object);
-#else
-static inline void mem_dump_obj(void *object) {}
-#endif
-
 #ifdef CONFIG_ANON_VMA_NAME
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 			  unsigned long len_in,
diff --git a/lib/list_debug.c b/lib/list_debug.c
index db602417febf..ee7eeeb8f92c 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -22,17 +22,17 @@ __list_valid_slowpath
 bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
 				struct list_head *next)
 {
-	if (CHECK_DATA_CORRUPTION(prev == NULL,
+	if (CHECK_DATA_CORRUPTION(prev == NULL, NULL,
 			"list_add corruption. prev is NULL.\n") ||
-	    CHECK_DATA_CORRUPTION(next == NULL,
+	    CHECK_DATA_CORRUPTION(next == NULL, NULL,
 			"list_add corruption. next is NULL.\n") ||
-	    CHECK_DATA_CORRUPTION(next->prev != prev,
+	    CHECK_DATA_CORRUPTION(next->prev != prev, next,
 			"list_add corruption. next->prev should be prev (%px), but was %px. (next=%px).\n",
 			prev, next->prev, next) ||
-	    CHECK_DATA_CORRUPTION(prev->next != next,
+	    CHECK_DATA_CORRUPTION(prev->next != next, prev,
 			"list_add corruption. prev->next should be next (%px), but was %px. (prev=%px).\n",
 			next, prev->next, prev) ||
-	    CHECK_DATA_CORRUPTION(new == prev || new == next,
+	    CHECK_DATA_CORRUPTION(new == prev || new == next, NULL,
 			"list_add double add: new=%px, prev=%px, next=%px.\n",
 			new, prev, next))
 		return false;
@@ -49,20 +49,20 @@ bool __list_del_entry_valid_or_report(struct list_head *entry)
 	prev = entry->prev;
 	next = entry->next;
 
-	if (CHECK_DATA_CORRUPTION(next == NULL,
+	if (CHECK_DATA_CORRUPTION(next == NULL, NULL,
 			"list_del corruption, %px->next is NULL\n", entry) ||
-	    CHECK_DATA_CORRUPTION(prev == NULL,
+	    CHECK_DATA_CORRUPTION(prev == NULL, NULL,
 			"list_del corruption, %px->prev is NULL\n", entry) ||
-	    CHECK_DATA_CORRUPTION(next == LIST_POISON1,
+	    CHECK_DATA_CORRUPTION(next == LIST_POISON1, next,
 			"list_del corruption, %px->next is LIST_POISON1 (%px)\n",
 			entry, LIST_POISON1) ||
-	    CHECK_DATA_CORRUPTION(prev == LIST_POISON2,
+	    CHECK_DATA_CORRUPTION(prev == LIST_POISON2, prev,
 			"list_del corruption, %px->prev is LIST_POISON2 (%px)\n",
 			entry, LIST_POISON2) ||
-	    CHECK_DATA_CORRUPTION(prev->next != entry,
+	    CHECK_DATA_CORRUPTION(prev->next != entry, prev,
 			"list_del corruption. prev->next should be %px, but was %px. (prev=%px)\n",
 			entry, prev->next, prev) ||
-	    CHECK_DATA_CORRUPTION(next->prev != entry,
+	    CHECK_DATA_CORRUPTION(next->prev != entry, next,
 			"list_del corruption. next->prev should be %px, but was %px. (next=%px)\n",
 			entry, next->prev, next))
 		return false;
-- 
2.25.1


