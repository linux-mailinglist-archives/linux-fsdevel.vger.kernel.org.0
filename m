Return-Path: <linux-fsdevel+bounces-64812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D443BF4B60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 08:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3C7B4F1F27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 06:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204AF26B2B0;
	Tue, 21 Oct 2025 06:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="QXCCh+wl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xFp2uNtT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5062676F4;
	Tue, 21 Oct 2025 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761028521; cv=none; b=ar9d1ZGUhrarn/XcHxhSmUdK4zREyayvrWJwJq+QVPAquBcIuv7wcQ6QjDmaSBexVr3X7+dHid+pRIsK1pkoG/1nG101m24Hf5xcE0u2lgi5gHpBb8vkiAfj8Eu+dhwZ53BI7juQMbHib+uFZ5Abq797he04gFIznHYU9mdmsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761028521; c=relaxed/simple;
	bh=OHQu+XKo6skE/AbbqbtZpEGw/Mu4KS/tNRUdIuZJQuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcd++v++TeNRkJQZIFFmnAHdqsPKSUMmVtY7OQD6tB4Ry54okUX1T/Vqs7C/cSEeo8SSSIwO6AyCGEFFHn8R/iqsk+qXvjAnufY2p81+opV3+opAa+kPjpdLEwIne6a3ICP8tGBFoGHmVDh7GcreGETW6sGmnC87htJ5aL1dEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=QXCCh+wl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xFp2uNtT; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 5BAD31300B96;
	Tue, 21 Oct 2025 02:35:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 02:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761028518; x=
	1761035718; bh=kouMDpsaKBTceLHHuEwo+6TiQxOHciskzTrX3DfsJ3o=; b=Q
	XCCh+wlD3svjomR7bq/ZXyKCTAllt0sB6rnGPRh6WbpAUaLqYqn7grdgZDhn6okE
	bwew6ngIvP8YShoHzhnu5JgSDdbpSs5ffGwKkWv2aa/miiJtrq+Vu+Ohkbmf47IC
	17As1WXT+KUkyeSVNIB1oKijJLKzMFaXZWLEEVn+1nYH2DiBcEdJfYPtOz2k0q6I
	PdjT+1UuD7Y6OfR4EIZSlwC1A6Iv5+IwHm9TjZ+j0iKxSuA+HgMni92AeOOLC+LB
	mAJTJeXI13/CL1vg2g9jBlc+gQwgPJ1Wz08Lm7rGN+7wYnUKNBB398QywOlHlvtk
	RyZUcjDvnws1sIOdrtpVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761028518; x=1761035718; bh=k
	ouMDpsaKBTceLHHuEwo+6TiQxOHciskzTrX3DfsJ3o=; b=xFp2uNtTRo2P0y3Ox
	MfRvo7pja/nXrVqr6GeQqZ6u6LKRlHRTVoChkL8TncaavvtNonkDt7jyVAj1EA79
	rgzFCGrMQUbzyPhdxis8JVuTQvCMPoeN8ly8hzUDYuiDCdB46WCOQacRdL4mEg4r
	1sNgCG8Zlh9llLxFj6iglEi/jnnrHfgQXEPZ6l2uSLMkyrjZbL/IRzgtjp31b/zo
	oZ7GZgbN5ATWKMYKxUobrRkwr+Esv8uqewKGLaKWjOaLDY01Gdrkx0K0NTlYVgvC
	THXbgSalMTvkW5+POLb5oAQjVi0NlAVc4zSN+lw4V/fl8cB37mG7fjd7aw0H1gZZ
	tc3Yw==
X-ME-Sender: <xms:pSn3aHyVwJ3duZ9SATxnHz8siDK50UyVPwck5MkjbGH7NJlht6KQoQ>
    <xme:pSn3aMdk1Z3ihI-LiHOzD2EyJiog1ReQZrKiooyvbOCvR4igvIhmvYuoXrYakiCfN
    RwkAGldnBrMfnsUBlTUJxKWEjGZ0n51WtGloaTM_1-y7oaf5VENcsrt>
X-ME-Received: <xmr:pSn3aF0rkl1CVJy9STbeSQUVKvkPPV5NDYOXmLUKle0jOMGXGOY5x949vUKBIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepgeevhedtgfdvhfdugeffueduvdegveejhfevveeghfdvveeiveet
    iedvheejhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:pSn3aNsLt991mStyAV0HAgJWyIXtq7Kp_lMdmpYRGsLrWdig0p_CJA>
    <xmx:pSn3aJ-zPPQsw54nKraZa_jW03DOnuxF85pX8IWvx2R7GLmR1BTkDA>
    <xmx:pSn3aJT73sUt3Z5xvP8XdmPBGPj5p29zjkRrSoYwrXSuoavZB0jSfQ>
    <xmx:pSn3aHCyYqhXC2Z69UJPa_cLsp_D3g4t7ogYt1ES723cUEXy7UiUSw>
    <xmx:pin3aO3o6sgLVZt7w08b4lGkV3xJRri3v-9zh2GIh6SqIG7GW1FkK4GP>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 02:35:16 -0400 (EDT)
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
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH 2/2] mm/truncate: Unmap large folio on split failure
Date: Tue, 21 Oct 2025 07:35:09 +0100
Message-ID: <20251021063509.1101728-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021063509.1101728-1-kirill@shutemov.name>
References: <20251021063509.1101728-1-kirill@shutemov.name>
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
 mm/truncate.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..cdb698b5f7fa 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -177,6 +177,28 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	return 0;
 }
 
+static int try_folio_split_or_unmap(struct folio *folio, struct page *split_at)
+{
+	enum ttu_flags ttu_flags =
+		TTU_RMAP_LOCKED |
+		TTU_SYNC |
+		TTU_BATCH_FLUSH |
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
+	if (ret)
+		try_to_unmap(folio, ttu_flags);
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
@@ -249,12 +271,13 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 			goto out;
 
 		/*
+		 * Split the folio.
+		 *
 		 * make sure folio2 is large and does not change its mapping.
-		 * Its split result does not matter here.
 		 */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split(folio2, split_at2, NULL);
+			try_folio_split_or_unmap(folio2, split_at2);
 
 		folio_unlock(folio2);
 out:
-- 
2.50.1


