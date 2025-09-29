Return-Path: <linux-fsdevel+bounces-62979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF01DBA7B92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF013BECB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D642BDC26;
	Mon, 29 Sep 2025 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="h+0JsHvW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DC28BA83
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107890; cv=none; b=VF/cMEg62Gcu1ZrkbyuS7QHVEX7w0AeYQyfH3Z085p+z6bR+u+UUwnKGj5nNfPJ5NbgLdmmtsksK2GhItcJlgOXoujX/qf6vGEXzZ607+3DO8LuQuzpz2lYBI0KF90nwIbaB6QB6a4kX8y/CzyjIRGJ0/m3Yx/8DrSm8UrkOWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107890; c=relaxed/simple;
	bh=f4psfNd7pl4tLW9WB19i5zd8tji59wv/dnyXClT/vO4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWrHLYLZDvuU1/lTJz34JkAoCOQ0Q0aoppTQx2l4ZbVk868AfdyQ0qWx6fWOct3je5Ia7hn3PBTqrZNIk6V9CwJ0QgzolBXD0oRFO1KlQtnlT0jM/tedTElaWaxEjKvi58nYfD96ZCgIxtlkWxFSfrlHYXV7S/6oIf9WjQopLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=h+0JsHvW; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4da37f6e64cso34637171cf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107886; x=1759712686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6klfNbsQaSU6FDtMq1rEXrmqStKMVNSQ5o5W34IBdA=;
        b=h+0JsHvW4V17uP+cyXnzHlSbn/ZPjdURR4ckrzz45eBqytrocZT9uJN7LJuqs+iwy2
         itazGG3QDsfzAJzhQDlDLLoIcMTGQ2ue1DEEv3ymBFL0uk5iqQKypFZp30VvW8I+vyRB
         WwQf9I56nR/b1/O0VcnHVPji7ElBPeI9I321hEcxdb4PZwD9y4fOVqrBFf0n4Ejo3ToK
         4a6+g/TUGksmEC8qo4JuBpEDQpb0ZLuDVK8ykHvMkOGB/viUTjFwzcanZbEw4Ra4rgqq
         L1O25eHPZR/7f1QYOukG+AqSh0qwnkiotcXVziCTp5vfl1umWagjVIst3en+pvkizK4L
         prig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107886; x=1759712686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6klfNbsQaSU6FDtMq1rEXrmqStKMVNSQ5o5W34IBdA=;
        b=jNAGKkTwZzvF15b61RgBEMkShVZbRrymZ7+H/4pSlxKrETUyXuX1DHQqT8cgtQuHJz
         D3deD5RFIaRCndKtBXhT8CU0jkFfeqsz6jlkWIbLvd1+ZCE5qXNo4YqVbwJNVQYO8lYa
         mkXs/01B8sE02yfQ+U2x0emMdmaIW5hD8uu/bTaV/gG5DCzmRcjnfCEiUw76GnQI1BBy
         AJ1AAIM+xXZXdDR85wSZ23UeIX3t3QeQsZaDdNDzJCdtqOiqDhxOWQZngAA+d7XXhMuO
         MX14o/+KHmNs27S7q1ueCFQm/O/pBdqu0VequEgFuGWAS/cHdpD6i+74SYaNZSOf2yTP
         4j/g==
X-Forwarded-Encrypted: i=1; AJvYcCXp2RnJQl1HYeHqcoU5ZI2bhCIGN4nlMYlQ0hNS7Yo2jveObo5W79uDHzh8MZAa+K6WJleK2AymJiBIPrmR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MsIVYOFu8tOrzTp0A8JyVOMus/tcaEClgiXo2gPIlAasrEBy
	LKlpP6Alufu34Of0GJs/GVjMc0lAAHZ9+7ppc2hIxjTS6AStL0kDU0gRf5wvXy1vb28=
X-Gm-Gg: ASbGncvAYkS7PfysffxNFEcsL9h5IxcY5v3EqXIOLeAJvtuH+j6UzPPA6W0dFZN/rSQ
	rAPasY3d18si+HwBRp76mR6GX2GeXCwdapEt82JGsCfmPL0T/nXO0Bv3NbbHifRlAMKDxfFArT7
	QtK7i7Q5R77ZVzt6VIN1nupabIpdXbTjYt1Ozc4fyf1FmPdzzr7AtLhv1bCp9mBuzzv7uqxg2i2
	vaXMWFL3WA4JTbkBquD6cAJLFH0ASCR8bTab3SeR35pEFtC/0x6xdAcl91m2KwFJms/QWxFl0ra
	H745f1TYnArmFITbpDafCHownZcrcU1oKYegfAeLWVqG0ggUwvNAEcsioZSh8hH3fXbwhaj8WfE
	34O/aSiYZLku4ivwp5BlAwW9A2Qqumr0jtE4JYG34o4WdJKc9EEG7/tVXfo8+5tGI0H83RIyZoB
	amBvN3p+CMquO1DcvZah9FNw5eubd6
X-Google-Smtp-Source: AGHT+IHEKESKD14PFByufgCCj+q1xbdbjfqjaSBhECif5xZZLUIBv1xuJQ+qilMP2TC7MJ+Z1A1Lng==
X-Received: by 2002:a05:622a:19a3:b0:4df:194:b46d with SMTP id d75a77b69052e-4df0194c12cmr84674601cf.80.1759107886091;
        Sun, 28 Sep 2025 18:04:46 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:45 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 23/30] mm: shmem: export some functions to internal.h
Date: Mon, 29 Sep 2025 01:03:14 +0000
Message-ID: <20250929010321.3462457-24-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

shmem_inode_acct_blocks(), shmem_recalc_inode(), and
shmem_add_to_page_cache() are used by shmem_alloc_and_add_folio(). This
functionality will also be used in the future by Live Update
Orchestrator (LUO) to recreate memfd files after a live update.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/internal.h |  6 ++++++
 mm/shmem.c    | 10 +++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1561fc2ff5b8..4ba155524f80 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1562,6 +1562,12 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
+int shmem_add_to_page_cache(struct folio *folio,
+			    struct address_space *mapping,
+			    pgoff_t index, void *expected, gfp_t gfp);
+int shmem_inode_acct_blocks(struct inode *inode, long pages);
+bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped);
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/shmem.c b/mm/shmem.c
index bd7d9afe5a27..4647a0b2831c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -219,7 +219,7 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
-static int shmem_inode_acct_blocks(struct inode *inode, long pages)
+int shmem_inode_acct_blocks(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
@@ -435,7 +435,7 @@ static void shmem_free_inode(struct super_block *sb, size_t freed_ispace)
  *
  * Return: true if swapped was incremented from 0, for shmem_writeout().
  */
-static bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
+bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	bool first_swapped = false;
@@ -861,9 +861,9 @@ static void shmem_update_stats(struct folio *folio, int nr_pages)
 /*
  * Somewhat like filemap_add_folio, but error if expected item has gone.
  */
-static int shmem_add_to_page_cache(struct folio *folio,
-				   struct address_space *mapping,
-				   pgoff_t index, void *expected, gfp_t gfp)
+int shmem_add_to_page_cache(struct folio *folio,
+			    struct address_space *mapping,
+			    pgoff_t index, void *expected, gfp_t gfp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	unsigned long nr = folio_nr_pages(folio);
-- 
2.51.0.536.g15c5d4f767-goog


