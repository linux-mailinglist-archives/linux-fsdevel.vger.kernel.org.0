Return-Path: <linux-fsdevel+bounces-69818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DACC861C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9603A435D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCAB330B1F;
	Tue, 25 Nov 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="U88ZGUUw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CFB32FA2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089974; cv=none; b=XsVO2eFQLwhk62cEzLhpi8Zz8ZbVAdrdris6C7ayxGyOSa6eHVaQdmw09g/m3JDGKvQ8ZMMpnMstjprqPZNxgMVMsZGZigOummKNsRwWfv48RzDdQv2O1/v8NKIspFe2SrYT4N1ESFTOjX7BXfW8F2WAUFYsutDMfRR+9CwEbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089974; c=relaxed/simple;
	bh=KuhNTb4CjpCAEi4yupsWgshbtHoJow3Edu2RC58eD+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVUXHJssIaruxPRaKfDdkV3BsppU7SBTKNj64L6FdOtq7vLDmpweSs/9nXWzuolgpIc/+vtlRqlzHWYmZ0OztoZTWvwtlav+xCgb3xl1PxlTkGsCwv8N3Gt2m+4qAhEgV0Off/07nQbrTaZ6UOoJZHYzneQEACEh3x6lv804Vs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=U88ZGUUw; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-641e4744e59so5983140d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089970; x=1764694770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfwgkEKDg4HJju8ezcZR8QklgFqMiwexlZP+Lehn03I=;
        b=U88ZGUUw8sIuIpfHDMPI8Q+2mhFeTq4UMOJ5xNh+pvA+/gPggiKVc+Oy88M8daEp3V
         Kr3h6IOATS5pPABp90uNpjoL+4wfUqnqouasFuJ9B+QdYqdPQD/lMGECFiQrtYL2i8fi
         5oMZyIfERnWMcJWUZR/jqMlyoyMwDzyfIcsof8sk0CjUOubhJSQsZUYfHCBftBgsaCZN
         O5MPse1lXcbv3EJhGYM3stpyZYmiBeTZ3BjsUXRbC0r+7a9voyl+ki3haOC4JRV8N80G
         uTR0Ga5FN13YNYPXylzji1M/Pbj3phu0vLzlzYkucAvJUv1QtB+6k4ncrOnVdTNnHoub
         VQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089970; x=1764694770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VfwgkEKDg4HJju8ezcZR8QklgFqMiwexlZP+Lehn03I=;
        b=HZdFRhQ1rni1wu8G7G0tDfuaC27xvAXED7zmK0VrvRpxzR8FPStehW+g8sSfJbvAjo
         DFsMRd88OgLB8tszHKEvmes0kpu0Zd2JxdLtWudea/ePP+gB8B2TE/aEO4di5GVFow2d
         nv/AKDPUDYEmTfe04jQ28hikwM03wSXx1zcvhIF+M/iPXaO0xyrPhkTuo3dK8QR3E9at
         4G7JK6XNv4mElKRYWMtwhYJLAyQcxBuetD72SJA521xFM/ts8kpKGlGunN7t7wF++63V
         N+wMwU8nfMSF3Xi3odr0sSv/rXs4/jlQ3ROzSMMc6vTyA5phWSUHN4ajbTT3Pl5Ua2eu
         v93A==
X-Forwarded-Encrypted: i=1; AJvYcCVchyAdh6ZSbWp1C73obSPENyLm1+LtkagsGx8mvuMyIBiRrXY/3iVxLhpTiEoaObIWwX4Defy3hCBjEXsE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EJnDxtdBc9nWOEiNOeMedaJOfUXJK6I+xi86Xmu9t9oU9ELm
	gZ8ag28qTrr6Mws23HUvMmsvSatX/JDBgM8KjrKkZwXZupwUY52v/PRREzu86ejVQEE=
X-Gm-Gg: ASbGncuITNeBhfXgPNeGEGEVD4QofON57F9x18QGbtrPrNmFFsaYzPpNVz8bWUy1F1l
	/26JqlzKo3kTgP20FuKmgbdyV84D3ElXHtcnMH5GlFeEP0GnUCoqX8W1BmGCIpbTrkUcmKFadtm
	S4A/Di5hZtsdwr+2TeIxvQrB7Gejp+zHiQD5/B1wJQevrWIYazPxaxpVqgxHVbY9/0IR9MkZF3h
	mQHyBzihAtAla9VPkO10aONYv6GKopq1V/sozzyX/1IvPKyehxCgxK2WOmW1+hciodMRALkDkEz
	t/cx98siO2DMf2rdoPgEubTTz/NYgIkpRaBiPlkLPo2YPwTYpVakoDNCjzEN+9YdWlzo6HQ1/gP
	NzMSpSaqQG3UsDlo1BSsq/Qpe0PL+njTbG5ywVGiUaVP1r4qo//YFomHzt6uLq3Q4GTgghOlf8O
	9xChOk5+cFcTuNukUCxeGqe8FIfOM2UqYpBcFh+lxNqW8w4X2pGtpCC8hv8WfS3UwM2VHWl8rkM
	T98BEs=
X-Google-Smtp-Source: AGHT+IHxFSNIvKptfLX2O2s6I7Ya1I+lmAyOHmAnZEOWuFdMycjzG+KGE1lNfFdZGkk9BfTpPXWC4g==
X-Received: by 2002:a53:d048:0:20b0:63f:beb2:950f with SMTP id 956f58d0204a3-64302a5d4c6mr9409405d50.34.1764089970594;
        Tue, 25 Nov 2025 08:59:30 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:30 -0800 (PST)
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
Subject: [PATCH v8 12/18] mm: shmem: export some functions to internal.h
Date: Tue, 25 Nov 2025 11:58:42 -0500
Message-ID: <20251125165850.3389713-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
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
functionality will be used by memfd LUO integration.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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
index 786573479360..679721e48a87 100644
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
2.52.0.460.gd25c4c69ec-goog


