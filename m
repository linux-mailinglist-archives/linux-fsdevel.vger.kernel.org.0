Return-Path: <linux-fsdevel+bounces-67491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E58C41B97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DADF44FA9A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DEB345751;
	Fri,  7 Nov 2025 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WIaPj78v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11453343D91
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549564; cv=none; b=Qb6SgB5JbOdPf/JFfqCnjIe5LyTD0fxkpltZ7ycHmY6vKm8K42dOIweEUC4tD9oXHroAbvU7FCqUssmROBt1V7TWJUVMpkcB1XoqPX6NSSlXeV1qMbK3mSZf3coCgc3xK7z/Ismu2/dZD81KnxUaoRqiPu4kMYoUhDbsiRLIITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549564; c=relaxed/simple;
	bh=2YoVzov6bB1zBXUx8MCa0vSfim57g+g/ybqzdLdnqC4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJat8zKJ/eo2ccTwXmaryvbiL/wxsHSptuQF6q8IaIIRXW5U/FDA+xMhJlERlzPQltULGaJLFoptl0Iko8d36hhynqc2TEiKYJTH84POpjzvYD21W7DIGBo2yBlW8qlsi4awnuZ5/0BSthaTjRB+aNAE+1o5qyPnuZup3Vs+pUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WIaPj78v; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78677ff31c2so11099027b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549561; x=1763154361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7B04/0h/Qcfyqc4t6CaWgs850ouGgVZlycEHNrf/bt4=;
        b=WIaPj78vg695vgQwUK4DlX/6p67WRgOK7neDgslYM3rNERJhdHG6V3iAppvpCoXTmQ
         YvTETkOLzzTUpVKRqGJ0FQq8xkpNXICMaSHHmjFEC1R4Wo+uNOswQPK0HCBiWP/Ta6xz
         t6/waWvn92bKsy17K6arLVwjq2Z+Fj1rmRooOSYAxZp/6PUB8EKz7VeRTYR3qBfV8G3w
         KrHhQF3YDpIwYotZMcm4Mz85vIAaDcWT2IVmVeCiKb/X4XfDnJakQgvvXVF0MK+2iBkX
         Tofe6V17g4myb/cILaOQaOuNLKb7YXBNT0OngxZLx/Dv22Vr/WK6cE0UOjrZyMV9i0y/
         1/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549561; x=1763154361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7B04/0h/Qcfyqc4t6CaWgs850ouGgVZlycEHNrf/bt4=;
        b=kwU+Ogk8eIOUVqj84gaWDyDFf5eNPo2yom6RSAC1EcIukk3sygH46IeSHFbdSSOU0z
         sAaQ+tYlUVr+MMA2K/ovYNnSmUlUS5gimILk6VJ4rqcvc0sNbrShW0NMCblKsDIzDAgW
         SQH3bZCcnw+LDD/Mb0XeAFqVx3VQOUn/y2puedan8FhmQHKej3k/yw0LA5358l/sX8tG
         WnNEC/1Uuhx+E4p0nbzlQVBre0msLdUEOvdiOYOpwfzV0s1Wn7UnOaodvmzulUAl1/g/
         03pbqsfAdZC4NUnblhpYEAf7LExctlp/MfFsrwRugrJ2YXZ7EfDbQ035AmBROHrFMCOZ
         SBjA==
X-Forwarded-Encrypted: i=1; AJvYcCUxmcw9RuinAe5j2pVatYRARt1xfimv1CpEQpHyo9jUbnHK2NdE61+zsBebQ2JU2j5XnBT/v78F9SDonMk9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5Im2Xy53P7iEZICIeIMl59m2zFTAcrceNna5bvCP4VkXDZfo
	w2Dv3BXufRXKNl+SSL+Fu/ogTdeBn+5nh4glXEYeumB1x1Va+KHciybWIAUtrwuBVck=
X-Gm-Gg: ASbGncu6hxKxhv5KS3NbnljUP39W8lpX5yw8LyUpC16RFCyjMwjopehEFOVpb4mX1cl
	e1rnREbG+6KHB3exdtebWDGZqf9BVQ6xBSRVfBaa/KLOSCnZzZc9OhaiFuFCOxgryFmlUw//XuY
	JSPOejrGo1wsbyUHrncsyKDboOAFnlWCRQ214R6wnaaGs0ZRfHveNMjRsSfwE2VaFKydY/7G7uU
	iyHGTQWPw76eijrmzbivAymH2qO7KjC9nr+Up8hszLFeC0a2Pn0YShZRTvA2CvNuHb6rcdYbar2
	bLiSi+VhdMP7IG69XDbVuMH+4+VY6O9JKILAKE8yGWyHAnbcTUBM+E69mLvZ5xrwXKwlJmzfB0P
	rwU9YafNKV1pjYJRr60gmW6JnRS+wFxSbC8bNKE2uLGXn7VyhawRLdSDNj9nQ+MUy5Jgf4som5g
	IbNpccW8alRLuXfvy6rTACwPjl2ow5ExMGQxe4bk0UUW6qdKxdybFsfhyQw/+7i4HGlMQqeXDMn
	Yhap9aaNvaW
X-Google-Smtp-Source: AGHT+IGF4+/4J86N/nzQZyRsPJ7pMtknxLR4bnE8JC68ZkTL3I3E4I5rinqYLEhJi2wbGwCzdCJ5TQ==
X-Received: by 2002:a05:690c:55c5:b0:784:8153:c604 with SMTP id 00721157ae682-787d53ba2bemr6446727b3.31.1762549561166;
        Fri, 07 Nov 2025 13:06:01 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:06:00 -0800 (PST)
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
	chrisl@kernel.org
Subject: [PATCH v5 15/22] mm: shmem: export some functions to internal.h
Date: Fri,  7 Nov 2025 16:03:13 -0500
Message-ID: <20251107210526.257742-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
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
index 0af87f6c2889..3f957e86f43f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1585,6 +1585,12 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid);
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
index 2e3cb0424a1f..c3ed2dcd17f8 100644
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
@@ -890,9 +890,9 @@ static void shmem_update_stats(struct folio *folio, int nr_pages)
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
2.51.2.1041.gc1ab5b90ca-goog


