Return-Path: <linux-fsdevel+bounces-11458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27322853DD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3771C20E8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02126634E9;
	Tue, 13 Feb 2024 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="WvLMGzG8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sd8v5LS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3462A1C;
	Tue, 13 Feb 2024 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861354; cv=none; b=ug7aSTNkCSZhsdrM5R1OC2lsd8BIMRQSa3iBIDZBfNQQsWGcIhPolL2Y9ugeJKKLnGRtvIk8NqawxqfCw4Ym0zqxYF3+QDiZ5+LMdMmDxSpz+TDKPE3fWvMnc/FEhqODs4a9Z88W+Howsc1rngKQUg541sgS4S0m4BWLcxXf2KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861354; c=relaxed/simple;
	bh=OvAIGuwlGYeYczWW+K0KagfhK17treRqEU1nj29vKyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhRI4XBX0SBYLpXHkIIWuC6bPHBVbi4SFa1mAR9BcpkdHP2dzPXoDCfq+s9dq685hPCJlSJ9bAZ2krr0nNtnOnlmerLAmV7Q4xNdZzDS2TeC97dun6KoP0whU5UyK1rgYrqkJfaR7KtKBUyhJBDc380OTkNYjkfWb40j6t8j2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=WvLMGzG8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sd8v5LS0; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 7B87D5C0117;
	Tue, 13 Feb 2024 16:55:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 13 Feb 2024 16:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1707861351; x=1707947751; bh=oTNlS8iSN/pL1arvPd/5QTJjaetwy6e9fk4
	UTiJDrr4=; b=WvLMGzG8wXGQ5WLFCyib254XrZQHLxadtOA5IFge31vgtZsUNbw
	FPxOtPftSxp73UoR9iEg0kRZSjAt3xVySIfSZPJZ+naXMvtREPI0U3qhxpCwOnqu
	wwMAdeHW4ZkZaro6be6Dqd0SALeZhxUxx/qjy5Bkw/ko2pogmrCh5Gh0XPG4e4kd
	dya0nrayzU3kjfIG4G00T9cPLYiLhzzsAz8mnQFVCyxAZ65g7Af73FntZ1IvA56I
	//RKnQY3tLcyiUYnnv4PzxhGicKR/FW8SnezFUktwatcPARjUIMdMF/G92989M6F
	oegvKTtsKcbbpLMFmwuQ52mp0uNLaz0pbZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707861351; x=1707947751; bh=oTNlS8iSN/pL1arvPd/5QTJjaetwy6e9fk4
	UTiJDrr4=; b=sd8v5LS0k1pzxQL6VcVTcdNqUwTwF6t38tK/aSkdRt9DNR69YYW
	mgl3uyGhZ30NsrbitOLENl0DJQ2ZFqLAjEwrfl0soH7FXk90jzE7qFP38FVcL+M+
	4yjcb/L5toUeqbQW+1OeFqUN6+cxQNa2h5iKXgU8ITyuqdZn0m2lhUNtp8sscJkH
	71gt5FNseF2R33sHskNxGOqZdSrEzuzUczAlVcw9KlQK7KCTx82uL61DXBoBG7/1
	zb/Uxl+sqfZiUBXkoNgvExH/QammNJtjDbQg7c4N8sO7Y75+AIB7dzCV+RsHbai/
	tkYuP3C6jL93ogiwew+KhZFSV9a/jRcl/AQ==
X-ME-Sender: <xms:Z-XLZWq4XE2e0urUeIyf-wTwWkElUlqH2TySlIH-t2iD3pkUzJuaSw>
    <xme:Z-XLZUrd13OVRmIJbB8KxOxxSYKMmPt8R6JRV4jIbW4DlIoW-zLGi6hRK5rt7iICZ
    BtZMQzKDd4JB-0dsg>
X-ME-Received: <xmr:Z-XLZbMMUmd-XFF_BbX8Wb2fYcjNUES3n3AT3IHIGulju2mfSEspAYriDk_4QGa70ZPGVjzm8U9xscytsmEQuy4TXEskkwU4ws35muqCdPK4nkhDPi08g5BC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:Z-XLZV6mP-kw5YxZIQeNAmqqRsZQlyFQO0h8BZyOZ4ZvgPsac-ew6Q>
    <xmx:Z-XLZV4Ofp4ssLUpNFmmDkPecJ8B-hQtSwvdolgC7GDRIuS8rn1Qlw>
    <xmx:Z-XLZVguIwAToTyO9Hg_y7LUPViLXPWDuK9lOtBATRs3NupBGxDjPQ>
    <xmx:Z-XLZWPJZz5L4EPOo9fveqThkaDWWK480aUfFhGmfbib-A5aaeTKrA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 16:55:50 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Hugh Dickins <hughd@google.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 6/7] mm: truncate: split huge page cache page to a non-zero order if possible.
Date: Tue, 13 Feb 2024 16:55:19 -0500
Message-ID: <20240213215520.1048625-7-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213215520.1048625-1-zi.yan@sent.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

To minimize the number of pages after a huge page truncation, we do not
need to split it all the way down to order-0. The huge page has at most
three parts, the part before offset, the part to be truncated, the part
remaining at the end. Find the greatest common divisor of them to
calculate the new page order from it, so we can split the huge
page to this order and keep the remaining pages as large and as few as
possible.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/truncate.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 725b150e47ac..49ddbbf7a617 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -21,6 +21,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/shmem_fs.h>
 #include <linux/rmap.h>
+#include <linux/gcd.h>
 #include "internal.h"
 
 /*
@@ -210,7 +211,8 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
-	unsigned int offset, length;
+	unsigned int offset, length, remaining;
+	unsigned int new_order = folio_order(folio);
 
 	if (pos < start)
 		offset = start - pos;
@@ -221,6 +223,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		length = length - offset;
 	else
 		length = end + 1 - pos - offset;
+	remaining = folio_size(folio) - offset - length;
 
 	folio_wait_writeback(folio);
 	if (length == folio_size(folio)) {
@@ -235,11 +238,25 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	 */
 	folio_zero_range(folio, offset, length);
 
+	/*
+	 * Use the greatest common divisor of offset, length, and remaining
+	 * as the smallest page size and compute the new order from it. So we
+	 * can truncate a subpage as large as possible. Round up gcd to
+	 * PAGE_SIZE, otherwise ilog2 can give -1 when gcd/PAGE_SIZE is 0.
+	 */
+	new_order = ilog2(round_up(gcd(gcd(offset, length), remaining),
+				   PAGE_SIZE) / PAGE_SIZE);
+
+	/* order-1 THP not supported, downgrade to order-0 */
+	if (new_order == 1)
+		new_order = 0;
+
+
 	if (folio_has_private(folio))
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) == 0)
+	if (split_huge_page_to_list_to_order(&folio->page, NULL, new_order) == 0)
 		return true;
 	if (folio_test_dirty(folio))
 		return false;
-- 
2.43.0


