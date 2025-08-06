Return-Path: <linux-fsdevel+bounces-56801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343E6B1BDC5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 02:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24296266E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 00:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2965695;
	Wed,  6 Aug 2025 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GGrF1uOW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oCbDjzsH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3D13AF2;
	Wed,  6 Aug 2025 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754439062; cv=none; b=l5mohOFbZZmJARfeyc64PQ71lfdkKezdRftciz4AZlNLHtosp8vIPpiEL53ywM/XZSrlJTkcd/52V8KxBOPOH8k+ceMYx6muDG781UzACR8jPxUZHnMCID5kuLRexbn7BMClMfRk+b9ydL0nwr4cPFXCZzj7+OgmMnTESH02B5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754439062; c=relaxed/simple;
	bh=H8IpWBITRasSJMwNzPiT+Hxrs2ExC/XmGa1fk+R77ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SG0tERjgeBD/LjfPtiJTdfzcKvBKETOF+GEHawUvYJvEmheyE1i7w6WQxIkmxII+i3WsTMl1PDRSD2GOP1j9CP13g/1GsqvcZoURAWa3mT8IVBZ6ilL9+4mKTi0i4GHK3aFiIkMiDgGvF36PN9QQSpZCqXfuSkIb/pmp5KQNiRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GGrF1uOW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oCbDjzsH; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 203B01D0024E;
	Tue,  5 Aug 2025 20:10:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Aug 2025 20:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754439058; x=
	1754525458; bh=NMkug1PZF2QAfivblMu+w2TJxSj/x/jO/BIhiNhgEAg=; b=G
	GrF1uOWR5MDmu7iedNKmcnSawwxfou0p9UqxNUMBsMWsuN9wRlwLxjnTo8m3zc5M
	nObp6f1faws8totu9es1+Nq52vloBczQevQhH8ZxlC9A4GzaqL1LYym8dihZt4AG
	vfSvVtgEhXyUjtyfvCrHUr4YouyNOCyzeXEGNhuK6KA/2RUWHYa9U6ydKI5F2E3H
	dgmpo/jSYMLYlpLjiRf7N6QRxHR8QqbZMhdMR4agv+zpVt5dEu3Tyy1Xl1klypjh
	O8wureZFYxLFksMtxWLt1afrCJqhNlKX+1hD4Cxy6mGhIxYVUGutKxD0jI0S9Aq+
	Hmr5Z8cxRf/tJUQ7C1tBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754439058; x=1754525458; bh=N
	Mkug1PZF2QAfivblMu+w2TJxSj/x/jO/BIhiNhgEAg=; b=oCbDjzsHAuG03l79C
	ajpGywvRrJXz6UmB5jHjrxwxBZCo18XD996ekP1Ax2tOZ6M40HSzyE1hDng/R783
	komopR2kWdj6E+g897Tm5EbAEs+E5aNTgidojpdextoZChI7YTEIcz1EdeJcCqvs
	bLDBGbHi881Ew/0XSubf9uO/Om+vOcz/Hz/nax4pUQPbF/m17RaBXVPIQSZiB1Xk
	A87vYvZGD5VGwX8zxAp5WFuKJc7gr2YEWEdj7EMiRr7qoeYS+zQzvb0tpy9HL1cd
	Tpdn+hsxUQYS6NAoBUstLu00fQ1ncM1Z+y+H/0CP0ykippQyZlXA6mgqkXl/33KS
	qJ5Pg==
X-ME-Sender: <xms:kp2SaC3BqECAlvdzvihEOwcVdywbPvMCZbJr65QywvgXlDCrYYvAJQ>
    <xme:kp2SaI6CmYjwXaxPVmfIEeyfgIhWTW_9FhJFkpl7rNY0c1LAxupaAW41nY2a3D_ZB
    ydFKVWytRBbyQTmxh8>
X-ME-Received: <xmr:kp2SaD-K3eXlK0-EjR7TgNI9O5VKDh_FjhZf3170KuvvF7fq3CYi5YJFvBUKW1sXSJRxRZwQ3Cop9r_wmWopb44hkwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeiheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepgedute
    ffveeileetueejheevveeugfdttddvgfeijefhjeetjeduffehkeelkeehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomhdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslhhi
    nhhugidruggvvhdprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtohepfihquhesshhushgvrdgtohhm
X-ME-Proxy: <xmx:kp2SaHXSdnG8j0oyDfF47wPag9u3kOVwos43rOmYwk5XHOVB09rogQ>
    <xmx:kp2SaOq08RiY7n4O0xhXWeZEeDUWPTNU9nZq3HPhD2W0Z6bpMZxlrg>
    <xmx:kp2SaJkBuQ4R7P3Pqtpl2E7qLOE9BfiaaxtdcAYPnEeCdO0pQ1Dcrg>
    <xmx:kp2SaO1BKhjA8M96K5tUgLGc9nojcxjeIwFDG54kkIR9mMFMoouE8w>
    <xmx:kp2SaN0JikDm19k-l6Qrs5Hr9cu60wHcs0cLP3wEbCb6rG-sS0NsJUWT>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 20:10:58 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Cc: shakeel.butt@linux.dev,
	hch@infradead.org,
	wqu@suse.com
Subject: [PATCH 3/3] mm: add vmstat for cgroup uncharged pages
Date: Tue,  5 Aug 2025 17:11:49 -0700
Message-ID: <eae30d630ba07de8966d09a3e1700f53715980c2.1754438418.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754438418.git.boris@bur.io>
References: <cover.1754438418.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If cgroups are configured into the kernel, then uncharged pages can only
come from filemap_add_folio_nocharge. Track such uncharged folios in
vmstat so that they are accounted for.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/linux/mmzone.h |  3 +++
 mm/filemap.c           | 18 ++++++++++++++++++
 mm/vmstat.c            |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 283913d42d7b..a945dec65371 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -241,6 +241,9 @@ enum node_stat_item {
 	NR_HUGETLB,
 #endif
 	NR_BALLOON_PAGES,
+#ifdef CONFIG_MEMCG
+	NR_UNCHARGED_FILE_PAGES,
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index ccc9cfb4d418..0a258b4a9246 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -146,6 +146,22 @@ static void page_cache_delete(struct address_space *mapping,
 	mapping->nrpages -= nr;
 }
 
+#ifdef CONFIG_MEMCG
+static void filemap_mod_uncharged_vmstat(struct folio *folio, int sign)
+{
+	long nr = folio_nr_pages(folio) * sign;
+
+	if (!folio_memcg(folio))
+		__lruvec_stat_mod_folio(folio, NR_UNCHARGED_FILE_PAGES, nr);
+}
+#else
+static void filemap_mod_uncharged_cgroup_vmstat(struct folio *folio, int sign)
+{
+	return;
+}
+#endif
+
+
 static void filemap_unaccount_folio(struct address_space *mapping,
 		struct folio *folio)
 {
@@ -190,6 +206,7 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 		__lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
 		filemap_nr_thps_dec(mapping);
 	}
+	filemap_mod_uncharged_vmstat(folio, -1);
 
 	/*
 	 * At this point folio must be either written or cleaned by
@@ -978,6 +995,7 @@ int filemap_add_folio_nocharge(struct address_space *mapping, struct folio *foli
 		if (!(gfp & __GFP_WRITE) && shadow)
 			workingset_refault(folio, shadow);
 		folio_add_lru(folio);
+		filemap_mod_uncharged_vmstat(folio, 1);
 	}
 	return ret;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a78d70ddeacd..63318742ae5a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1281,6 +1281,9 @@ const char * const vmstat_text[] = {
 	"nr_hugetlb",
 #endif
 	"nr_balloon_pages",
+#ifdef CONFIG_MEMCG
+	"nr_uncharged_file_pages",
+#endif
 	/* system-wide enum vm_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
-- 
2.50.1


