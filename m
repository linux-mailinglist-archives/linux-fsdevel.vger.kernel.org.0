Return-Path: <linux-fsdevel+bounces-56799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D00B1BDC1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 02:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC56266FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B399C8EB;
	Wed,  6 Aug 2025 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iL6Oybbp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iym+k+EV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C61114;
	Wed,  6 Aug 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754439057; cv=none; b=nTvcp+TU9nK+MKCVoluL+Rp/oxEFTB/V4tq3dLz4vZwy51+/pZyyygGpbUFSa0+gq8cZxQ8rDZs4rLJQr1HBSS/vCBO5wcoLqFl8PkmaQ4zX1w6NCw+z82G2xw0S6KxW1kp60su65Cs+m+o8khX0RfH8p/okS6d/qcfoj030GXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754439057; c=relaxed/simple;
	bh=bw5Xa+fIApYwNWn/mMq0R4oz6j3uhHac6x72OuBnuNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFOeacyWlDN8hmJj1wkc7pl5rycoFwPZ2W/3rYVmoirrz+8PSo+UVNvAWM6/Px+oeB7XETXtLlZNoebnrgy9cwqE6gLZ5RaomCLXlUP6Ha0twsMrS5BUR+GlsSwe103/QWDBYg9mBPg3/T1tFmE6pm2FgI3yz7KLD4Xf8Ex0bWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iL6Oybbp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iym+k+EV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 693F01D00245;
	Tue,  5 Aug 2025 20:10:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 05 Aug 2025 20:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754439054; x=
	1754525454; bh=1phRvSNuTKIF+bCvTZCq9ZVaDd/RaEEPdjAvv51sVaY=; b=i
	L6OybbpyE+rOwlETZcQyAlbv5ro83/9Q6ceQk/Q0cgyUb8IKGonHNw9H8qFbjFEY
	cPlwQrvT/neTJpYkddiXLm+rasmq+6C04rAOULRELZmN3YhL7QAlzW9zhs8/GjeX
	HWFOiFvObXPugP4bbc1bAh9KXFHuACFit2Gw073yBE0wyYugv4pfQX8d9ekgLqy+
	eL4CkezBvGpBt7l/gJ95bZRefU5oqIrv+zOOHaWPLCOnrspP90x6u+znsljFsBPC
	9NqE0QGNsUMj+lUbecjjWcjnvfkxYr3S+220E1phU02bLGlqp58Oa7VPE8ZZpGBt
	z5ZhdFYv3phBfUPC271Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754439054; x=1754525454; bh=1
	phRvSNuTKIF+bCvTZCq9ZVaDd/RaEEPdjAvv51sVaY=; b=iym+k+EVVQzDVp3Nw
	maO/VAOzJ1vRfnCTZoXEm6tVcpK6VgRDravj09yHQXicIWzvH58WNq8hTRSooGKP
	4BLozYGl+F+3/QlvmaYa74td3mIA8EF6VBJRLRFdTrTfIqakuR/8ua38g4v6R2nl
	UrzIrBoKLqo55uLhhSJOLILToNkH0gZ7yK5Nw5kmbG5RYGpquTbUjCKbzu1z25TS
	93dlm/hEQGVQ6IAa+0ApQ6IzBXSu1ejN7v7Y8PbzQfZHEzzomfk+6f2IVWktQzDR
	l+sneN+O82lfhy0pjCKUcTbACGJCJCRqAyPpjvkZob1fUX+qqCMx7+5ZcXj6nSgH
	wrd/w==
X-ME-Sender: <xms:jZ2SaPMRHOpSBKuSiS72fY6heztTwJylPXv17-3XEB7jFtqfixMZWA>
    <xme:jZ2SaNzKzHMR4jLS_fkeSoj6F2jA6XSYYSdAo7JfV32KDwaxeHHjB36bXrV6GLyyZ
    6hLjDmIutnS_EGJd4Q>
X-ME-Received: <xmr:jZ2SaHVnkWkSIosASQ1kkY8KjRsiF79ZI_u78QsWWxBTfezfeax_yQ98IRx1SnTzV95G9ZGSEs7MzEDtSadVoyn0ml4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeiheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephfevke
    ffkeffheeffffhuefggffhhedugfetudetudetueefveeijeefvdduudegnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghp
    thhtohepshhhrghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohephh
    gthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifqhhusehsuhhsvgdrtgho
    mh
X-ME-Proxy: <xmx:jZ2SaHOGkt-mJdAV-dERZ7YY6dOYhpTiqD7QroHalFzzi7Bnb0YCkw>
    <xmx:jZ2SaBCMmxCnDU_v4s-c4ju_1kW1v3l3s_owzwBucCwLGlNYtHwsew>
    <xmx:jZ2SaMfAXWSuNLzH9Jj0GCxjaybrSZYI7oBYDiKf7vb_rzB_nVGpUA>
    <xmx:jZ2SaIP8erXk91TPfiFWpJgspmz4KzGhwO99Wu_8N4Q5Vb1XrOicAg>
    <xmx:jp2SaGsrH4gBG9jUKUa6yMnjoDmezQcZTglqfRRs5halbP3HnzBO3JwD>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 20:10:53 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Cc: shakeel.butt@linux.dev,
	hch@infradead.org,
	wqu@suse.com
Subject: [PATCH 1/3] mm/filemap: add filemap_add_folio_nocharge()
Date: Tue,  5 Aug 2025 17:11:47 -0700
Message-ID: <9be3cdb1c9fb9f848719c20d4659071229f07284.1754438418.git.boris@bur.io>
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

Btrfs currently tracks its metadata pages in the page cache, using a
fake inode (fs_info->btree_inode) with offsets corresponding to where
the metadata is stored in the filesystem's full logical address space.

A consequence of this is that when btrfs uses filemap_add_folio(), this
usage is charged to the cgroup of whichever task happens to be running
at the time. These folios don't belong to any particular user cgroup, so
I don't think it makes much sense for them to be charged in that way.
Some negative consequences as a result:
- A task can be holding some important btrfs locks, then need to lookup
  some metadata and go into reclaim, extending the duration it holds
  that lock for, and unfairly pushing its own reclaim pain onto other
  cgroups.
- If that cgroup goes into reclaim, it might reclaim these folios a
  different non-reclaiming cgroup might need soon. This is naturally
  offset by LRU reclaim, but still.

A very similar proposal to use the root cgroup was previously made by
Qu, but he was advised by Christoph to instead introduce a _nocharge
variant of filemap_add_folio.

Link: https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e63fbfbd5b0f..acc8d390ecbb 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1237,6 +1237,8 @@ size_t fault_in_readable(const char __user *uaddr, size_t size);
 
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
+int filemap_add_folio_nocharge(struct address_space *mapping,
+			       struct folio *folio, pgoff_t index, gfp_t gfp);
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		pgoff_t index, gfp_t gfp);
 void filemap_remove_folio(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index bada249b9fb7..ccc9cfb4d418 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -955,20 +955,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
-int filemap_add_folio(struct address_space *mapping, struct folio *folio,
+int filemap_add_folio_nocharge(struct address_space *mapping, struct folio *folio,
 				pgoff_t index, gfp_t gfp)
 {
 	void *shadow = NULL;
 	int ret;
 
-	ret = mem_cgroup_charge(folio, NULL, gfp);
-	if (ret)
-		return ret;
-
 	__folio_set_locked(folio);
 	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
 	if (unlikely(ret)) {
-		mem_cgroup_uncharge(folio);
 		__folio_clear_locked(folio);
 	} else {
 		/*
@@ -986,6 +981,22 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(filemap_add_folio_nocharge);
+
+int filemap_add_folio(struct address_space *mapping, struct folio *folio,
+				pgoff_t index, gfp_t gfp)
+{
+	int ret;
+
+	ret = mem_cgroup_charge(folio, NULL, gfp);
+	if (ret)
+		return ret;
+
+	ret = filemap_add_folio_nocharge(mapping, folio, index, gfp);
+	if (ret)
+		mem_cgroup_uncharge(folio);
+	return ret;
+}
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
-- 
2.50.1


