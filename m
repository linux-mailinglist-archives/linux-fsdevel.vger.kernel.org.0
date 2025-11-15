Return-Path: <linux-fsdevel+bounces-68585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA88C60D3E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 00:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2F26C28BFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 23:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FB930C377;
	Sat, 15 Nov 2025 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MU0St5ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE13074B3
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249689; cv=none; b=leKjYq75tAeEJ/RX63hzxPASTPZz3zYhS8sPM71QkPnrmW8R8EGXCL4WPzQ2JE8x8VSRRZE2YsbkD1ao8EIP9M5nCFl2tPQVlv2trOW9cPAfuJGCbG1OR3nloIXi798Hg2g8jO9Qx1W+K9tQjF70eeqkf9V4rjo8actoOZxRqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249689; c=relaxed/simple;
	bh=ofxtTHhqb802FVk4Sz/AUTZJyer5O95kDxWgWujt1uQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebaLfSgUQGp5YfX7lAaokonmJ8FqrneCIWlTpNIWum755untPegaN+BBJ6nkiZT+e4kneyj/venJbK4PNqvOo67N9keMiUYY6ofGCmlkjku9wrRUje8a5Sw36UXVuF36T4FGJgRQCBQWbw5Advixs/AW6Xug5S9ouMQg7yCWvJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=MU0St5ek; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7869deffb47so29921907b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 15:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249686; x=1763854486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eLZ78bp0n4p6Wf1XgYT9EXfbUSCOwy9XSJd2QadY6Y=;
        b=MU0St5ek5BHZIjMoxb8a/pdJBRZMUeNYvc4Vl6PWIeLG5J2JB65i9eTHN/SrhEYN0y
         wyYg1CWYQ4SWxauig7H9N8ELoesAOLaqG9WS0S2WmLGe7K0nHQA0RrDhVCwBlu+g16Zv
         oIYx/CDHRtLWdV1Wr9CAf0rHG2quBj0YLawytcwOJATZAQdqU4f7sraq0weiY9/UQyt7
         jR1Z4+Phh2UPcKNpPyIGKEDFHGQrffP/fE4dOxTRabTEsreb5r1l5ugoh/bB06e01vrH
         C/4av6+QbZdPsShCH9vUEEtiwG0p3S37rBYydBBc8lHDmW9ddIuslt99n/RvNuvcrbN9
         iD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249686; x=1763854486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/eLZ78bp0n4p6Wf1XgYT9EXfbUSCOwy9XSJd2QadY6Y=;
        b=djHScpzN61jyRFlRVsI0N9Zae9MFnMrpw9PKq2cOKGYijULcB6Y6zDJpUiyOy8DUtc
         zRPBlrNqLEE5qpw2nmUVzAZFhJLF0zfJU0djrgIoNtWVKKobE/oDHHXxzPm+BRblUUoZ
         ULCXRIj6m7xYnQ6u/bRm4fu7AaBRTzgR2gCGofotOPjobQefkhprXZqNUTXomVHLwp/j
         nWxXuusKTO2Z++/QmbOrZa0CBfEwH46q1ePiw8LUBbjOkhZEaZkngDsz2vr6qcNAY+Ck
         7IeRrbk9nTumhui8YFTA9C1j4apWPA9dTCrk9rkjpcVQ0AGxqNfZ0os4pwkVcKA4woIT
         /H0g==
X-Forwarded-Encrypted: i=1; AJvYcCWBk2VwZox0yB8L34YBoN1FqApdaUx8gqDHzbth3fQegVa/JWOddU48iDHCSK70bXJhdAscfXZbVNWhrHYP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DDP/k94xxSBBcMBJpDcgNtvhXT4eemPdCbOS6f3c7hoeL1hd
	5308fCVDwKBIJZlxMG5UyoCyGu+oDPuJ6WxSucJRk8B2e6XutNJN0bQkwCQUjva5U5w=
X-Gm-Gg: ASbGncvcWEObXAUfoUfVTtPe2AkZaIUQ4AZCDsgYNO+f4yZg0YBCcPLgx+QZXLAbncQ
	w4OJ2bmwLWTlGh/0F8mnyU1wJ+sCFoYHM19ZespM9TGum8GQ4Gj6ndUP9NB84PfbDAEOy2Y5H6i
	Wc/ujgWFsF7EB2Ow1rdnplKWipcawQAqOvLyviXIqeSlZ1tkeKesZon+Pn2LOle4LIL+ygngRMP
	D6pcTrqW52hGMKwwPN3/gEOI7TJgRd4elIhhp46wEZDhszMw4eoTCVTUeK4MLPZVXtCvdHyDUaG
	sAtVipjseXBQ7zkMT10lvMjhLmpSErZn9urlBKC9y999sCDdlj+smeHGU3LgQcm4hBrqJOhnVC6
	bM1faY4/0sOZpp5G6eFAsWsyVos9mMLyeZCZ3quuuBxjIZZ6Ncg+ZWQNjs2p7a9QcDYjxrVXtV4
	yXLi4M5n4H6tJhWZfbX/8LoBkbQFhTpxP3kpj+HtED0QUqYEiQt/GFxiAmbaj4UpxRJmw5
X-Google-Smtp-Source: AGHT+IHk0jQUizdAzkiK9Xpe2uUL2VAa8k1RUUTK2HykUPyp4K26BcN3/UXlJAExurxnthMVN+vR9Q==
X-Received: by 2002:a05:690c:2603:b0:786:5be2:d460 with SMTP id 00721157ae682-78929e29f77mr74299087b3.1.1763249686563;
        Sat, 15 Nov 2025 15:34:46 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:45 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
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
	chrisl@kernel.org
Subject: [PATCH v6 13/20] mm: shmem: export some functions to internal.h
Date: Sat, 15 Nov 2025 18:33:59 -0500
Message-ID: <20251115233409.768044-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
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
index 05c3db840257..c3dc4af59c14 100644
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
2.52.0.rc1.455.g30608eb744-goog


