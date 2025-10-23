Return-Path: <linux-fsdevel+bounces-65285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B1C00436
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB15D3A9684
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073963081D7;
	Thu, 23 Oct 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="cFhzcu2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LCM9trZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C39F308F12;
	Thu, 23 Oct 2025 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211988; cv=none; b=OUSt7PKCuipyCShHS1sxc2TPfUSqPiY3rwqYeNpwayFlGSEV1YNd2hOZCbteckPfM+JwdEaiQzv/IYe8TVBr3KczzEiLE17SnNXB68z8l6DHgLJyfk+LQmgdgGTKJ+IQq6CB+ceusb8LOstOgM0hWafCZj7C3hcjikwtE8RjmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211988; c=relaxed/simple;
	bh=mh+Jhq2H9uaAJh9tBZQ8VECEmmiboM5ZGdsetheo3eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c20zihAqO+EwKvYQJEU4eZLQ0gEkpBlW2+gQOHS6/aHmYJ60hgQS0V1ACffRWbBncz288DHJyedqRlXXLVJcd258i/YT8HnEhBskh4Cv4vAyYftjDFOufhwf8fiZZGRbfRudfkKBpuO5+k68gchojw6bwadP6xgOKZJuQTxriyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=cFhzcu2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LCM9trZC; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 34F5313000E6;
	Thu, 23 Oct 2025 05:33:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 05:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761211982; x=
	1761219182; bh=ok4mnq2NNACQ1V+S0uDNcBIlKAcl6TkUg957YVuWVaA=; b=c
	Fhzcu2XHPlMJIp+8ynL1IL70VNFTbVzhZgJNsRhgvKmGfujCLVHXuB+U+cY3EFhk
	ciRMd1AJBh7a6Kgt5y2yizbKmQ1b7wJ9Vv5ERMQ4s+G71KaXczSyTAOSr4LyPs12
	F6AohsGhU43C75T9lG7NLL3i45uT74mzoXGAdxgoiwFr4+JjMx1t+aCT1mBh44YI
	gy0NPSUUxLvudWyM9blszLhFKAn/GTr2AKIBsPhz6VxOrc485LAEBL2CvJkLT3gF
	Ac2TeUZB09sNfI18taQLvSZHdTP572oj6pQwf9SyaOC5sHHUjb1OOqd6++aAu9I6
	NEIIrfqIRUXPjS8x98HWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761211982; x=1761219182; bh=o
	k4mnq2NNACQ1V+S0uDNcBIlKAcl6TkUg957YVuWVaA=; b=LCM9trZCurcWKdisH
	LkfAhVdG6vi7pZmV3manZ/m1fb4C+qTEhxF93nz9PI9eWs3icpnsKZ8u8ZsiXPc2
	GLgPUSS6hhjRC8KKpNZAbUM5cA4eqrMPK+EZeOnX7RtSj5Xyx6hzKZ0TMURMVlKc
	HWY5XAW2DLuQI5vySlw8nHnPRPlsbrxEZ3S2UwTGv7qlttmtB2sxVAAlhjTZ5oX1
	gignm0S3ePoClflysHCyAtBei5lpPim5hTTRD3Dqq+cUbzR1TIKmO3La+W31InZQ
	eLFrxihQ89YSkYBRfMSPUg8rjW6sy0Jkt3ayCq5sVNqdkALGgf68f9scDCQbkrT0
	Vy4KQ==
X-ME-Sender: <xms:Tfb5aMmyHFljBnsb3T2W25zar78VSSV4KWibHv4HCUUasEl_0CFZrg>
    <xme:Tfb5aAupddsLE8U8p1qCL9UMl-nOE39MZbcDbiriDac_N2T9NxKdmWpJ7Cev42B-L
    ilf2htyRPGOkTEn-lCAB54TMMl4cMjTSYsuSx-V_LO39rN4iY2prM0>
X-ME-Received: <xmr:Tfb5aIPsSN9UugIv3MurODpcwgqgxsyX0j1bXX1_yUiEvtAniegtq1NvWZZdpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepgeevhedtgfdvhfdugeffueduvdegveejhfevveeghfdvveeiveet
    iedvheejhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:Tfb5aKo18UVhomkB2aK9sNqjotI7KT9fxU3Zf4ai2P_RtBX7uoXrmA>
    <xmx:Tfb5aJ_u6v5qW2M6wnTuOrPhfZIe-TQITOg0uwfxBQUPaPx4-l8jhw>
    <xmx:Tfb5aBq7KEciwv1RRBzv0Ez_k1lMiZ2FGqmzI-WTy-IEijjbuTUdNA>
    <xmx:Tfb5aPhFJjVqMhzMckii8yRXzqZUkW0GYtOHZo-bTcgBJPtnEBF5EQ>
    <xmx:Tvb5aPkcE7oDWD3GX-VIMa2dEWn5uNDjZMvEAEb0jt9WFdtzHtnhyM4O>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 05:33:01 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCHv2 2/2] mm/truncate: Unmap large folio on split failure
Date: Thu, 23 Oct 2025 10:32:51 +0100
Message-ID: <20251023093251.54146-3-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023093251.54146-1-kirill@shutemov.name>
References: <20251023093251.54146-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
supposed to generate SIGBUS.

This behavior might not be respected on truncation.

During truncation, the kernel splits a large folio in order to reclaim
memory. As a side effect, it unmaps the folio and destroys PMD mappings
of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
are preserved.

However, if the split fails, PMD mappings are preserved and the user
will not receive SIGBUS on any accesses within the PMD.

Unmap the folio on split failure. It will lead to refault as PTEs and
preserve SIGBUS semantics.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/truncate.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..304c383ccbf0 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -177,6 +177,28 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	return 0;
 }
 
+static int try_folio_split_or_unmap(struct folio *folio, struct page *split_at)
+{
+	enum ttu_flags ttu_flags =
+		TTU_SYNC |
+		TTU_SPLIT_HUGE_PMD |
+		TTU_IGNORE_MLOCK;
+	int ret;
+
+	ret = try_folio_split(folio, split_at, NULL);
+
+	/*
+	 * If the split fails, unmap the folio, so it will be refaulted
+	 * with PTEs to respect SIGBUS semantics.
+	 */
+	if (ret) {
+		try_to_unmap(folio, ttu_flags);
+		WARN_ON(folio_mapped(folio));
+	}
+
+	return ret;
+}
+
 /*
  * Handle partial folios.  The folio may be entirely within the
  * range if a split has raced with us.  If not, we zero the part of the
@@ -224,7 +246,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		return true;
 
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split(folio, split_at, NULL)) {
+	if (!try_folio_split_or_unmap(folio, split_at)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -248,13 +270,10 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		if (!folio_trylock(folio2))
 			goto out;
 
-		/*
-		 * make sure folio2 is large and does not change its mapping.
-		 * Its split result does not matter here.
-		 */
+		/* make sure folio2 is large and does not change its mapping */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split(folio2, split_at2, NULL);
+			try_folio_split_or_unmap(folio2, split_at2);
 
 		folio_unlock(folio2);
 out:
-- 
2.50.1


