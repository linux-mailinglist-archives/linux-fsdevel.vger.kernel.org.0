Return-Path: <linux-fsdevel+bounces-35021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE1D9D0037
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 19:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BCDB25A3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826EB1AE018;
	Sat, 16 Nov 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="O+VnJ8kt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D15193419
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731779973; cv=none; b=lSmDlHYfow6tCJi5Yn9L5h9xl2NHWrjkuX9TPa42uWgk680tXR+mVuPugsAEj9sCzD14BexgWqIvg8hwPxk/a427e7VPI0LWqN0BhpgAnSUC0pTNvuO33VvOtO4m7PYncwyFaWNpy0JRDavgwrpuFgk52r2TO4U+kHyhkqHRq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731779973; c=relaxed/simple;
	bh=A/eMaK4QwZ9hjbeO9HV9UZXJqXekh8pTRkBamgc9JYY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jA6w0CSjFTcZG4ok9m3JOiDJHilor93JzmUfKkNJafsC/dB+5z6B7B2zCvFOaS3K4qTGcluOcQmd4+vCA7ZR9yZ5JnoV5iGAl3DnabXLsPp7JsjaOXSwd2vp+3jVtz74J5wQAW642VbTbgIMoHKKMO4EB1Aru16Z/iwAP60V704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=O+VnJ8kt; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b161fa1c7bso168023185a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 09:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731779970; x=1732384770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+zqV+yymXPy0a+WK0KlfZbpXJ50Be1gsnAxvt14Xcw=;
        b=O+VnJ8ktm442R9PDCcUAQp7g4R2wDqeZNzur6+CuVdmVz+mZX6wEsCfxBnOZqHKbIo
         5rCzugQZCPaZ5CGFhWXJDBTqOlFxXb47bug0UddsyiXrCCHWu1Z+rBcJQeljyH9mLhsE
         iiMoExWi2vf4sQBnCvqRlPRQ7o9XjADlVaW6oUEVc3myck82H4wDvasbZuBVx7i1zYmr
         UCpgnzqG1hM7HEnuWwgbI353cJicmFDxWv3ff426Gs1VHKxpN1jrN56aKOrP9kx2E0JL
         /NPK7tIx6VtnDjYzrKkCk7+3aSYTP9xSw1U5pQK3ARbBjqz60RAdy0vgHvMoAkGriHva
         raKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731779970; x=1732384770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+zqV+yymXPy0a+WK0KlfZbpXJ50Be1gsnAxvt14Xcw=;
        b=m0NEQiTPmo6V3QP+Dy58aUWWhUiQtCaRkW7W7mOrf5ajb4IgUjmbhhwqr0xpeZ9Qd8
         sKYBoOSdPc/mAVDvHB0HcZPxXax+z+K+DJNf38O1EHRiZIuebKiHMdAdXFs0UJAofU8O
         kjz23USB8gH9ixgbGHBlXNVnds6rE7LMk2WwOK+JV3TXqctOTv8wTAdfhfJvqoWpVKqG
         FLtunxEhCbqXFaKOZuvbrPx85w/gcgM5pc1ms5e8tZF3wZgi5RhUlFAEiO6F3iOyxD3S
         Q5ThkE8oOrCv/UTnOmBKrYPjmA2NyzIXwvDbTg0HFQWiZZsNOrpxHyhEFibZIYVG//ic
         3G6w==
X-Forwarded-Encrypted: i=1; AJvYcCWCa6tiAmruqUPcqxkhr8afwPzzjxsspUKhr043eaDqPArC8gckyXe16LIX8WEDfGFdA3qGsi/TeUHR4LSy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb591GPjsL963HYzJNvrh7UhttZ1KfQPas0Gf6D0ZyjHUWQpUZ
	U3wmKf1zIfDBE03X6cxCvnV4EXx9u6EHhSu+LY/Br+WGVpluzOGssOYihCKtIg8=
X-Google-Smtp-Source: AGHT+IFM6KBibOKfJYXQZBFVrr3w+/SZOQZsHgHNA1kQveXXhFr8pkzrxC/81+yPU1STXi1ZMpKadw==
X-Received: by 2002:a05:620a:4507:b0:7b1:4762:65 with SMTP id af79cd13be357-7b3622b4a6bmr766363285a.20.1731779970003;
        Sat, 16 Nov 2024 09:59:30 -0800 (PST)
Received: from soleen.c.googlers.com.com (51.57.86.34.bc.googleusercontent.com. [34.86.57.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca309d6sm280530085a.94.2024.11.16.09.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 09:59:29 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	derek.kiernan@amd.com,
	dragan.cvetic@amd.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	shuah@kernel.org,
	vegard.nossum@oracle.com,
	vattunuru@marvell.com,
	schalla@marvell.com,
	david@redhat.com,
	willy@infradead.org,
	osalvador@suse.de,
	usama.anjum@collabora.com,
	andrii@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	rientjes@google.com,
	gthelen@google.com
Subject: [RFCv1 3/6] mm: Add a dump_page variant that accept log level argument
Date: Sat, 16 Nov 2024 17:59:19 +0000
Message-ID: <20241116175922.3265872-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page Detective uses info level, while dump_page() uses warn level.
Add a new function dump_page_lvl() that accepts  log level argument
to be able to dump pages at specific level. Also, this enables adding
a modules specific prefix to output of this function.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 fs/inode.c              | 18 +++++++-------
 include/linux/fs.h      |  2 +-
 include/linux/mmdebug.h |  1 +
 mm/debug.c              | 53 ++++++++++++++++++++++-------------------
 4 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8dabb224f941..1114319d82b2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -603,7 +603,7 @@ void __remove_inode_hash(struct inode *inode)
 }
 EXPORT_SYMBOL(__remove_inode_hash);
 
-void dump_mapping(const struct address_space *mapping)
+void dump_mapping(const char *loglvl, const struct address_space *mapping)
 {
 	struct inode *host;
 	const struct address_space_operations *a_ops;
@@ -619,31 +619,31 @@ void dump_mapping(const struct address_space *mapping)
 	 */
 	if (get_kernel_nofault(host, &mapping->host) ||
 	    get_kernel_nofault(a_ops, &mapping->a_ops)) {
-		pr_warn("invalid mapping:%px\n", mapping);
+		printk("%sinvalid mapping:%px\n", loglvl, mapping);
 		return;
 	}
 
 	if (!host) {
-		pr_warn("aops:%ps\n", a_ops);
+		printk("%saops:%ps\n", loglvl, a_ops);
 		return;
 	}
 
 	if (get_kernel_nofault(dentry_first, &host->i_dentry.first) ||
 	    get_kernel_nofault(ino, &host->i_ino)) {
-		pr_warn("aops:%ps invalid inode:%px\n", a_ops, host);
+		printk("%saops:%ps invalid inode:%px\n", loglvl, a_ops, host);
 		return;
 	}
 
 	if (!dentry_first) {
-		pr_warn("aops:%ps ino:%lx\n", a_ops, ino);
+		printk("%saops:%ps ino:%lx\n", loglvl, a_ops, ino);
 		return;
 	}
 
 	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
 	if (get_kernel_nofault(dentry, dentry_ptr) ||
 	    !dentry.d_parent || !dentry.d_name.name) {
-		pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
-				a_ops, ino, dentry_ptr);
+		printk("%saops:%ps ino:%lx invalid dentry:%px\n",
+		       loglvl, a_ops, ino, dentry_ptr);
 		return;
 	}
 
@@ -653,8 +653,8 @@ void dump_mapping(const struct address_space *mapping)
 	 * Even if strncpy_from_kernel_nofault() succeeded,
 	 * the fname could be unreliable
 	 */
-	pr_warn("aops:%ps ino:%lx dentry name(?):\"%s\"\n",
-		a_ops, ino, fname);
+	printk("%saops:%ps ino:%lx dentry name(?):\"%s\"\n",
+	       loglvl, a_ops, ino, fname);
 }
 
 void clear_inode(struct inode *inode)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a25b72397af5..fa2b04bed9d6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3137,7 +3137,7 @@ extern void unlock_new_inode(struct inode *);
 extern void discard_new_inode(struct inode *);
 extern unsigned int get_next_ino(void);
 extern void evict_inodes(struct super_block *sb);
-void dump_mapping(const struct address_space *);
+void dump_mapping(const char *loglvl, const struct address_space *);
 
 /*
  * Userspace may rely on the inode number being non-zero. For example, glibc
diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 39a7714605a7..69849d457f4c 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -11,6 +11,7 @@ struct mm_struct;
 struct vma_iterator;
 
 void dump_page(const struct page *page, const char *reason);
+void dump_page_lvl(const char *loglvl, const struct page *page);
 void dump_vma(const struct vm_area_struct *vma);
 void dump_mm(const struct mm_struct *mm);
 void vma_iter_dump_tree(const struct vma_iterator *vmi);
diff --git a/mm/debug.c b/mm/debug.c
index aa57d3ffd4ed..0df242c77c7c 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -67,36 +67,38 @@ static const char *page_type_name(unsigned int page_type)
 	return page_type_names[i];
 }
 
-static void __dump_folio(struct folio *folio, struct page *page,
-		unsigned long pfn, unsigned long idx)
+static void __dump_folio(const char *loglvl, struct folio *folio,
+			 struct page *page, unsigned long pfn,
+			 unsigned long idx)
 {
 	struct address_space *mapping = folio_mapping(folio);
 	int mapcount = atomic_read(&page->_mapcount);
 	char *type = "";
 
 	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount + 1;
-	pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
-			folio_ref_count(folio), mapcount, mapping,
-			folio->index + idx, pfn);
+	printk("%spage: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
+	       loglvl, folio_ref_count(folio), mapcount, mapping,
+	       folio->index + idx, pfn);
 	if (folio_test_large(folio)) {
-		pr_warn("head: order:%u mapcount:%d entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
-				folio_order(folio),
-				folio_mapcount(folio),
-				folio_entire_mapcount(folio),
-				folio_nr_pages_mapped(folio),
-				atomic_read(&folio->_pincount));
+		printk("%shead: order:%u mapcount:%d entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
+		       loglvl,
+		       folio_order(folio),
+		       folio_mapcount(folio),
+		       folio_entire_mapcount(folio),
+		       folio_nr_pages_mapped(folio),
+		       atomic_read(&folio->_pincount));
 	}
 
 #ifdef CONFIG_MEMCG
 	if (folio->memcg_data)
-		pr_warn("memcg:%lx\n", folio->memcg_data);
+		printk("%smemcg:%lx\n", loglvl, folio->memcg_data);
 #endif
 	if (folio_test_ksm(folio))
 		type = "ksm ";
 	else if (folio_test_anon(folio))
 		type = "anon ";
 	else if (mapping)
-		dump_mapping(mapping);
+		dump_mapping(loglvl, mapping);
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
 	/*
@@ -105,22 +107,22 @@ static void __dump_folio(struct folio *folio, struct page *page,
 	 * state for debugging, it should be fine to accept a bit of
 	 * inaccuracy here due to racing.
 	 */
-	pr_warn("%sflags: %pGp%s\n", type, &folio->flags,
-		is_migrate_cma_folio(folio, pfn) ? " CMA" : "");
+	printk("%s%sflags: %pGp%s\n", loglvl, type, &folio->flags,
+	       is_migrate_cma_folio(folio, pfn) ? " CMA" : "");
 	if (page_has_type(&folio->page))
 		pr_warn("page_type: %x(%s)\n", folio->page.page_type >> 24,
 				page_type_name(folio->page.page_type));
 
-	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
-			sizeof(unsigned long), page,
-			sizeof(struct page), false);
+	print_hex_dump(loglvl, "raw: ", DUMP_PREFIX_NONE, 32,
+		       sizeof(unsigned long), page,
+		       sizeof(struct page), false);
 	if (folio_test_large(folio))
-		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
-			sizeof(unsigned long), folio,
-			2 * sizeof(struct page), false);
+		print_hex_dump(loglvl, "head: ", DUMP_PREFIX_NONE, 32,
+			       sizeof(unsigned long), folio,
+			       2 * sizeof(struct page), false);
 }
 
-static void __dump_page(const struct page *page)
+void dump_page_lvl(const char *loglvl, const struct page *page)
 {
 	struct folio *foliop, folio;
 	struct page precise;
@@ -149,22 +151,23 @@ static void __dump_page(const struct page *page)
 	if (idx > nr_pages) {
 		if (loops-- > 0)
 			goto again;
-		pr_warn("page does not match folio\n");
+		printk("%spage does not match folio\n", loglvl);
 		precise.compound_head &= ~1UL;
 		foliop = (struct folio *)&precise;
 		idx = 0;
 	}
 
 dump:
-	__dump_folio(foliop, &precise, pfn, idx);
+	__dump_folio(loglvl, foliop, &precise, pfn, idx);
 }
+EXPORT_SYMBOL_GPL(dump_page_lvl);
 
 void dump_page(const struct page *page, const char *reason)
 {
 	if (PagePoisoned(page))
 		pr_warn("page:%p is uninitialized and poisoned", page);
 	else
-		__dump_page(page);
+		dump_page_lvl(KERN_WARNING, page);
 	if (reason)
 		pr_warn("page dumped because: %s\n", reason);
 	dump_page_owner(page);
-- 
2.47.0.338.g60cca15819-goog


