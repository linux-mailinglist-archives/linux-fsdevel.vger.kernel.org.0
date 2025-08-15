Return-Path: <linux-fsdevel+bounces-58063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AC9B288E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 01:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFAA5C52FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 23:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5412D73AC;
	Fri, 15 Aug 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="aQISgYRG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ToTlhkBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0132D46D4;
	Fri, 15 Aug 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301199; cv=none; b=fz5jq/NM/WgtXyoryknOBsh6ZfYtceEZJ+buaehT2kqzjhPrKInz02jrbyXxcN4iS2bLwStHcOVC2A0lcs4Au2B64JbJosvN/e3dBMK2d4BhDx1EMI2X0Fyg6wZeuaU2CCb/AMNh4cIIxb7vPn3uIRlDt2ffWUWuv6pR5XYRpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301199; c=relaxed/simple;
	bh=ma8z3/IJMGF9jmO9EVOAoS3OvJdokw4+H+cnf6W8JEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9ilNLRE+ZTHnsSgCc9YzHOG0UYGsR3gTytdc0sEyRXDpZXYuaYuIQpLkLeW/wYx/1nPjY/DAb49mMk/K7mrEuHQLT5LMt0J2MBi6gsR4QOisGRi8V42dT/ugGSbbkcHQVkWddZ8JOOVknP9uMAd0QPAmkvkn4b5M3UAfy0h13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=aQISgYRG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ToTlhkBk; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DAB19EC0108;
	Fri, 15 Aug 2025 19:39:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 15 Aug 2025 19:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755301196; x=
	1755387596; bh=NO/jJ6ZiW1tdMPtN/CCN4imJC1OmTM+b3Sd0mX3qBPI=; b=a
	QISgYRG0CG6MRoaLui2JOBi6iUXRe9PcD2s/c24purhDwSqhgHBnzQt4ygpI8PcZ
	x8tlWYDANzZ/5t3O+5HlLqyqcq4VC69/K0tC4CYU8QPOSlo6xmXLMwEcGL1uPgJr
	YcL9PlrGAg5icLVFz3NY+mEmcARWllqfkfXLMnU4HHURatHCD7RtugdDhrWOtyRs
	EDa2h1w5Otp+X6P+YiiQ7qJfDWlBVLN4x4Ph3gQ69fWyBA6Z6hi4dgVDFidXr+Hg
	ypYgAxAIhWvIbjKBuOEMOFnghgVTcVwq5EOOGTM/LTVKXoifYH5AKj/cx4THfNjp
	5Gy3UHi5zYDZxp1Yv7Xvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755301196; x=1755387596; bh=N
	O/jJ6ZiW1tdMPtN/CCN4imJC1OmTM+b3Sd0mX3qBPI=; b=ToTlhkBkmy/JsKMV3
	Ki0fZkBHCBkrTvXIWRaZiHyGnfrrNopCkOqLumUnfSfz7Vt1c5Js9huzEH48l6Hf
	3otz7xyujcL3nfqijs622B8U8VI/rV9DIdgkcKiYkB9twVPuBHUePOEWKwhB/qjV
	VW/8wKw/6GW6iLE4qPAKTid/roSPyG3y6jEIiY1yUwzD+59pwN289WLh4xg6avWy
	IXRhVJi0l0uzBVIPNTgoaUIs7kkq4WPJ5FRIjL1nVfnKNVVLjZflpfsj5jH72uV0
	SP16OkdtbT3jOP83G5qDu6KpJJd7XzyozUgbwzmFJCLsggR27djnvfRT2NvJ6bK2
	lr5vg==
X-ME-Sender: <xms:TMWfaOLQR28UXLEfZsB1F6AcvIvs5K8ahyXIrPVIZ0qu6ZCr_duX9Q>
    <xme:TMWfaJ_QS7s7fns5yxTqo2jsDvOJakvbYEM9jH7ZZsfAMp4u1lT9I04f1wo7VQbsp
    yVBFTSy_R_-IIB6yxQ>
X-ME-Received: <xmr:TMWfaHwNmGOdK_lx5TGQ-VOnF7nw5JqYLjtqli8KszWoSIVeNnEsVqUUOhmags7GpOSy0jDN6-7jnYxRIukXrWL-hgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfedtucetufdoteggodetrf
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
    nhhugidruggvvhdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhope
    ifihhllhihsehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:TMWfaG6BBW4eDY-wFu89FPYi0J4dlo10_lM9LvmmAj1salr0rmRJeg>
    <xmx:TMWfaO_qcQ7rUoPfDrNL02gu8Ha0SH0gxoXSsws5_qt1wADeyKHexw>
    <xmx:TMWfaLp_dOlHc2Yd8SdVImZ_Nyz6xtdCSkadK5PXS0CsrBoQSFfyQg>
    <xmx:TMWfaPqbvJGk3h9l9LJcr1IDO77ghiOfOsM2kCD2m4Vnlmayq-1LTw>
    <xmx:TMWfaE4wM1V1wfLsyKPSNJiRv4YQ1YQO72lSrH7gqzOYS8qezBjWH9Ps>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 19:39:56 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Cc: shakeel.butt@linux.dev,
	wqu@suse.com,
	willy@infradead.org
Subject: [PATCH v2 2/3] mm: add vmstat for cgroup uncharged pages
Date: Fri, 15 Aug 2025 16:40:32 -0700
Message-ID: <a0b3856a4f86bcd684c715469c8a1cb2000bcbe2.1755300815.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755300815.git.boris@bur.io>
References: <cover.1755300815.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uncharged pages are tricky to track by their essential "uncharged"
nature. To maintain good accounting, introduce a vmstat counter tracking
all uncharged pages. Since this is only meaningful when cgroups are
configured, only expose the counter when CONFIG_MEMCG is set.

Confirmed that these work as expected at a high level by mounting a
btrfs using AS_UNCHARGED for metadata pages, and seeing the counter rise
with fs usage then go back to a minimal level after drop_caches and
finally down to 0 after unmounting the fs.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/linux/mmzone.h |  3 +++
 mm/filemap.c           | 17 +++++++++++++++++
 mm/vmstat.c            |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0c5da9141983..f6d885c97e99 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -245,6 +245,9 @@ enum node_stat_item {
 	NR_HUGETLB,
 #endif
 	NR_BALLOON_PAGES,
+#ifdef CONFIG_MEMCG
+	NR_UNCHARGED_FILE_PAGES,
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 6046e7f27709..cd5af44a838c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -146,6 +146,19 @@ static void page_cache_delete(struct address_space *mapping,
 	mapping->nrpages -= nr;
 }
 
+#ifdef CONFIG_MEMCG
+static void filemap_mod_uncharged_vmstat(struct folio *folio, int sign)
+{
+	long nr = folio_nr_pages(folio) * sign;
+
+	lruvec_stat_mod_folio(folio, NR_UNCHARGED_FILE_PAGES, nr);
+}
+#else
+static void filemap_mod_uncharged_vmstat(struct folio *folio, int sign)
+{
+}
+#endif
+
 static void filemap_unaccount_folio(struct address_space *mapping,
 		struct folio *folio)
 {
@@ -190,6 +203,8 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 		__lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
 		filemap_nr_thps_dec(mapping);
 	}
+	if (test_bit(AS_UNCHARGED, &folio->mapping->flags))
+		filemap_mod_uncharged_vmstat(folio, -1);
 
 	/*
 	 * At this point folio must be either written or cleaned by
@@ -987,6 +1002,8 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		if (!(gfp & __GFP_WRITE) && shadow)
 			workingset_refault(folio, shadow);
 		folio_add_lru(folio);
+		if (!charge_mem_cgroup)
+			filemap_mod_uncharged_vmstat(folio, 1);
 	}
 	return ret;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 71cd1ceba191..c8c8b5831f2d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1289,6 +1289,9 @@ const char * const vmstat_text[] = {
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
 	[I(NR_BALLOON_PAGES)]			= "nr_balloon_pages",
+#ifdef CONFIG_MEMCG
+	[I(NR_UNCHARGED_FILE_PAGES)]		= "nr_uncharged_file_pages",
+#endif
 #undef I
 
 	/* system-wide enum vm_stat_item counters */
-- 
2.50.1


