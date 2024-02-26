Return-Path: <linux-fsdevel+bounces-12872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE396868227
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAB81F25298
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FC4131733;
	Mon, 26 Feb 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="Sisyyq5J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SLpntasc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96252AD0F;
	Mon, 26 Feb 2024 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980972; cv=none; b=isaTUb9pO+7kbeT279HFrfISAa74YKLVtagGv9tOy2+Gr3aGq1F0NopGiPUAfSJXtyezH7QwRyMzaxLTwuZbwswiH1xxnIrWVne8U4MduU0zRf2EMU8v/lOVIMbJ6tdw4M5vyUbxzbC7qnhuBmz9GHSQQmvjR8YQiK57kr7Q4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980972; c=relaxed/simple;
	bh=QLAbqKeBhGRCT6THiD1vK7O6pLkm2J856ju0bLi64o8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nj/g5ctdnUPFglBVkAejz32DzO7nVAVBt0IB2EK5UjWAUSS8f+FeLSwGkhsllzk51qNeTGFMdH+vjzJX0oR1+4H0zRthrJouZgG0ES5aDxUCEUH8RTjnXr9NHsiDtF2AoOBS85CqH3aJmKGZ53gFriRTfVZguovuSUgCFSj9svw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=Sisyyq5J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SLpntasc; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id BF9685C0042;
	Mon, 26 Feb 2024 15:56:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 15:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1708980968; x=
	1709067368; bh=bmT2DnSl6CM0A0GVel5YhNk6o76L5d7SeCcHbqGzTpM=; b=S
	isyyq5JHwqTW4KpZhy1XySg8XgYGf1U31W9+oJuGrFnFz7ObS8I48ak/0qKIhiSY
	wXaoWaKKavaiVlCO9kwiePnIDhzFyQ3e53y0Ucqm1UqkZFWqNaxiolMwflChevaZ
	HZXMdiifJi/RWTH7twtRj+AkPopHnI2obz0dQbThzg8oGIzf9lNv5His6IIJbfo9
	JY9ihQPRABEgJlCkC8cFwi7AQrRWEHoDlCHwgVNG+0mQygKMfBdfaNf10b721q1X
	kdQkiiQhIDwxxu8TFGkVzgcsoLpttpCWwmmN/XGUVlbrgRJqCCLtTPNybE+lg6zX
	qBfAgjRA+MntZiH4rJWtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1708980968; x=1709067368; bh=b
	mT2DnSl6CM0A0GVel5YhNk6o76L5d7SeCcHbqGzTpM=; b=SLpntascn9IURNetF
	9B8Hm3byN8LSOlvZICgnuZCtSOYPR25BUDU20f9761HnKyDT4AMwPaNrTaiQAKDl
	z8Jn4uZG+8wQx+udvcASDVKO9Z5HgXKQBJJgGv+VDTgEgCEpKYj3hvupG0K9Ux2X
	3fEx3MHEz0WUYP09566Q22g+Pvsf+DI45ujEGWebH4G1vkSSTrKX5HkclS7UjyPP
	t1C53iOzwQA9EKo/c5b4jVex6FbLZ1icy4TH9hp6xNdWxG4GHKnpRU8DxcmKRbqM
	AUqOHRZdF2SW8ZpE8/t6jGwaa1QW/IoDaYlLrARcv0srySbHro9zDI79b0YYJT6K
	QzyvA==
X-ME-Sender: <xms:5_rcZUP8uHMJTfDS_VSpD6wgyiIuc712uC89JTC3O6ARjaa-HflDlw>
    <xme:5_rcZa-2IWiefyosOLq7xLOTty4au_OMHmiH1U_GgTgUfkCtNBgD_TTl3mM1vT2e6
    C_a7_Hzz-G-s0ZrOQ>
X-ME-Received: <xmr:5_rcZbRaMMNw3Voes2LDCw8-wu6NXq37nPLbF5sAt5kthjZCjfE_632KVe4vCesBMzVahg_-BmncTm0P0t0VbSugnAS3F2tUvNRUQ4pYJAPiNP_aSAvZlcPF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteduve
    ehteehheeiteeihfejveejledtgfdvieeuiedutefftdevtdfhteevtdffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:5_rcZcvC54c_scBmr5ZTPeIN210O0R8TBskFpMRVhVh60qpI420V0A>
    <xmx:5_rcZccWGPAV90ezITbWsDUB6ucJJt0MOGrcXgGWgk5f2TtHNeJz3Q>
    <xmx:5_rcZQ0ZE_EzF5lKDEpvgXYd6heNptNTw7zJizYHxsQXJb-l5sviqg>
    <xmx:6PrcZbCDMSLb8vf1xjlt68I5-WzxW-8ABig9OGq5oTT7AmuroFOd9g>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 15:56:07 -0500 (EST)
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 0/8] Split a folio to any lower order folios
Date: Mon, 26 Feb 2024 15:55:26 -0500
Message-ID: <20240226205534.1603748-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
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

Hi all,

File folio supports any order and multi-size THP is upstreamed[1], so both
file and anonymous folios can be >0 order. Currently, split_huge_page()
only splits a huge page to order-0 pages, but splitting to orders higher than
0 might better utilize large folios, if done properly. In addition,
Large Block Sizes in XFS support would benefit from it during truncate[2].
This patchset adds support for splitting a large folio to any lower order
folios. The patchset is on top of mm-everything-2024-02-24-02-40.

In addition to this implementation of split_huge_page_to_list_to_order(),
a possible optimization could be splitting a large folio to arbitrary
smaller folios instead of a single order. As both Hugh and Ryan pointed
out [3,5] that split to a single order might not be optimal, an order-9 folio
might be better split into 1 order-8, 1 order-7, ..., 1 order-1, and 2 order-0
folios, depending on subsequent folio operations. Leave this as future work.


Changelog
===

Since v4[4]
1. Picked up Matthew's order-1 folio support in the page cache patch, so
   that XFS Large Block Sizes patchset can avoid additional code churn in
   split_huge_page_to_list_to_order().
2. Dropped truncate change patch and corresponding testing code.
3. Removed thp_nr_pages() use in __split_huge_page()
   (per David Hildenbrand).
4. Fixed __split_page_owner() (per David Hildenbrand).
5. Changed unmap_folio() to only add TTU_SPLIT_HUGE_PMD if the folios is
   pmd mappable (per Ryan Roberts).
6. Moved swapcached folio split warning upfront and return -EINVAL
   (per Ryan Roberts).

Since v3
---
1. Excluded shmem folios and pagecache folios without FS support from
   splitting to any order (per Hugh Dickins).
2. Allowed splitting anonymous large folio to any lower order since
   multi-size THP is upstreamed.
3. Adapted selftests code to new framework.

Since v2
---
1. Fixed an issue in __split_page_owner() introduced during my rebase

Since v1
---
1. Changed split_page_memcg() and split_page_owner() parameter to use order
2. Used folio_test_pmd_mappable() in place of the equivalent code

Details
===

* Patch 1 changes unmap_folio() to only add TTU_SPLIT_HUGE_PMD if the
  folio is pmd mappable.
* Patch 2 adds support for order-1 page cache folio.
* Patch 3 changes split_page_memcg() to use order instead of nr_pages.
* Patch 4 changes split_page_owner() to use order instead of nr_pages.
* Patch 5 and 6 add new_order parameter split_page_memcg() and
  split_page_owner() and prepare for upcoming changes.
* Patch 7 adds split_huge_page_to_list_to_order() to split a huge page
  to any lower order. The original split_huge_page_to_list() calls
  split_huge_page_to_list_to_order() with new_order = 0.
* Patch 8 adds a test API to debugfs and test cases in
  split_huge_page_test selftests.

Comments and/or suggestions are welcome.

[1] https://lore.kernel.org/all/20231207161211.2374093-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20240226094936.2677493-1-kernel@pankajraghav.com/
[3] https://lore.kernel.org/linux-mm/9dd96da-efa2-5123-20d4-4992136ef3ad@google.com/
[4] https://lore.kernel.org/linux-mm/cbb1d6a0-66dd-47d0-8733-f836fe050374@arm.com/
[5] https://lore.kernel.org/linux-mm/20240213215520.1048625-1-zi.yan@sent.com/


Matthew Wilcox (Oracle) (1):
  mm: Support order-1 folios in the page cache

Zi Yan (7):
  mm/huge_memory: only split PMD mapping when necessary in unmap_folio()
  mm/memcg: use order instead of nr in split_page_memcg()
  mm/page_owner: use order instead of nr in split_page_owner()
  mm: memcg: make memcg huge page split support any order split.
  mm: page_owner: add support for splitting to any order in split
    page_owner.
  mm: thp: split huge page to any lower order pages
  mm: huge_memory: enable debugfs to split huge pages to any order.

 include/linux/huge_mm.h                       |  21 ++-
 include/linux/memcontrol.h                    |   4 +-
 include/linux/page_owner.h                    |  14 +-
 mm/filemap.c                                  |   2 -
 mm/huge_memory.c                              | 173 +++++++++++++-----
 mm/internal.h                                 |   3 +-
 mm/memcontrol.c                               |  10 +-
 mm/page_alloc.c                               |   8 +-
 mm/page_owner.c                               |   6 +-
 mm/readahead.c                                |   3 -
 .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++-
 11 files changed, 276 insertions(+), 83 deletions(-)

-- 
2.43.0


