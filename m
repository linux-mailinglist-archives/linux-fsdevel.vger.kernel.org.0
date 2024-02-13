Return-Path: <linux-fsdevel+bounces-11452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA0A853DC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0541F2CB5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A761686;
	Tue, 13 Feb 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="mr1rlhoL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fd2Djm86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185661684;
	Tue, 13 Feb 2024 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861350; cv=none; b=S8DONL/Q/1It8vb7d/2NMqqcnVICGG++jY/Kv04US5M+1SIs8Ox75xnr6ezijebSTOxd3P/cLIPNP2YvHAnR9GH+JmEAwk/GudlV0ywGujUTJGJ8cBWWtZTVGendg6PCeSwq+f38ppA1bEd6kD3U3u1vRiyfl3+JAAX7ZWBevEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861350; c=relaxed/simple;
	bh=/GyMLqEaIzbvTZ7xam4FQ0e1scykPoZPxEo4U3yALw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pEQ79YLG4b8CFG5TXRRKpOyaxIW/12L+rYD/xzloLPqe9EUeKU+VAtSZ+Yaz0XeTxRCz8uZTDvmrH2AHRd0VhDNvwZxL2N1aN3qoZ7WSpFRuP9GcJ0gsNyzrbszxYQHw/VCkFPReuIP01ErancH+CE8jJkdDnP4WSoaD63Ckgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=mr1rlhoL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fd2Djm86; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 94E005C00B9;
	Tue, 13 Feb 2024 16:55:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 13 Feb 2024 16:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm3; t=1707861346; x=
	1707947746; bh=rKsJORufnnGtyC9mo4arxw/2f9LvMA7u/22qfgccp3c=; b=m
	r1rlhoLr2CPDTqsvidZUK1X1seSyDWNlCrtq5VdswnoSB7r4Dslk2NS5/Ex2154j
	u4r0ppFXXbbylSIwiVpj1pRT9PExZzo9rIaoFf3G241fWxGuJZ3IY1uKfBpvgWpm
	eY6O3NgMy0niZoaPwyB2lAFa/OCK0o3hEUGxF5IFQfbBRZXsFmgUeAUDN23/FHRt
	2XKa6BuqUlXiZXJRJMw9MeQLVQ9rWoIParVMyzU1YjOXeNY18Q45l+Hh8bJUnqa5
	3VUq3BuZ1YkX+H0dwDuJ+vQ+CONJlprI6FfXNXZKoux5Z6evZQU+Pp4Mkgvez/vZ
	A/rxo3iq07cjOJzf8lsbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1707861346; x=1707947746; bh=r
	KsJORufnnGtyC9mo4arxw/2f9LvMA7u/22qfgccp3c=; b=Fd2Djm86eNZq4Z3Lw
	MptTHyTJB/A++7ca2z3/dZltN6Su0fua9dJHFOXn5UTGA0s5zv6Dx8P9bDl5DuSZ
	enKaCtT43/48VRr9lMbrKXiqDitLlytuhvBltIBLLankuEt/pWb9XFjkxiR3/GM8
	KgL4O+LuJ+OPToSsVJctYyrFySFW0UeQwUkZOBbKXlMJqFBtM+psqcA7JkZtg2A8
	Iafj/K0R+HeelFUsD6lOWLbC6B0EfVphE9aIBi0J/p33joIg1rFa0bYHEjMmHWFl
	ZatMuVRFtsDz0UQnXB2HUvRsAyOSqbfKYo1mhC34Grf/YGgzwT8KhA57a5D7b9fS
	Rzx/A==
X-ME-Sender: <xms:YuXLZcawUI-DQBxk4O6fVj3k1_Im8S-srfKvn1f_ofMyXtMLMuGRYQ>
    <xme:YuXLZXZEq3bt7Xod245ANSeKVZNWcL2WjOK19zZXqHifwlFveBE8WdehAI9gSImBx
    xl1RA1bvvMuVw_BKw>
X-ME-Received: <xmr:YuXLZW-Cls5PWOt1uJNR8cqeHIyKLuV0sJ5eYmzyAoQ9Ak7Agcj_h3UKfB3uD2ZRlkMbVA4W7cLATS-QJIy_3z1y0cjL9vhDXHxVW9vCv6mU_OBDhZxK330o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteduve
    ehteehheeiteeihfejveejledtgfdvieeuiedutefftdevtdfhteevtdffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:YuXLZWqvfPT-tt657zYvNbobjkSvgtn0jzCMkDb_2jiXnE0KiWuUrw>
    <xmx:YuXLZXqwq_ysUqTFfVs0gQOA8XabcR40rPMxodHTdqKb8lLL4FY8hQ>
    <xmx:YuXLZURcBtMsFWG4C6ohK8xc6qgp8sTDdP8TqANLc_u5wE13HMZiHA>
    <xmx:YuXLZe8idbP8I4VCtDUTyw3u10YZbwkP9gBvtJSKgjk9yOLIxTwcPg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 16:55:45 -0500 (EST)
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
Subject: [PATCH v4 0/7] Split a folio to any lower order folios
Date: Tue, 13 Feb 2024 16:55:13 -0500
Message-ID: <20240213215520.1048625-1-zi.yan@sent.com>
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
0 is going to better utilize large folios. In addition, Large Block
Sizes in XFS support would benefit from it[2]. This patchset adds support for
splitting a large folio to any lower order folios and uses it during file
folio truncate operations.

For Patch 6, Hugh did not like my approach to minimize the number of
folios for truncate[3]. I would like to get more feedback, especially
from FS people, on it to decide whether to keep it or not.

The patchset is on top of mm-everything-2024-02-13-01-26.

Changelog 
===

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

* Patch 1 changes split_page_memcg() to use order instead of nr_pages
* Patch 2 changes split_page_owner() to use order instead of nr_pages
* Patch 3 and 4 add new_order parameter split_page_memcg() and
  split_page_owner() and prepare for upcoming changes.
* Patch 5 adds split_huge_page_to_list_to_order() to split a huge page
  to any lower order. The original split_huge_page_to_list() calls
  split_huge_page_to_list_to_order() with new_order = 0.
* Patch 6 uses split_huge_page_to_list_to_order() in large pagecache folio
  truncation instead of split the large folio all the way down to order-0.
* Patch 7 adds a test API to debugfs and test cases in
  split_huge_page_test selftests.

Comments and/or suggestions are welcome.

[1] https://lore.kernel.org/all/20231207161211.2374093-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/qzbcjn4gcyxla4gwuj6smlnwknz2wvo5wrjctin6eengjfqjei@lzkxv3iy6bol/
[3] https://lore.kernel.org/linux-mm/9dd96da-efa2-5123-20d4-4992136ef3ad@google.com/

Zi Yan (7):
  mm/memcg: use order instead of nr in split_page_memcg()
  mm/page_owner: use order instead of nr in split_page_owner()
  mm: memcg: make memcg huge page split support any order split.
  mm: page_owner: add support for splitting to any order in split
    page_owner.
  mm: thp: split huge page to any lower order pages (except order-1).
  mm: truncate: split huge page cache page to a non-zero order if
    possible.
  mm: huge_memory: enable debugfs to split huge pages to any order.

 include/linux/huge_mm.h                       |  21 +-
 include/linux/memcontrol.h                    |   4 +-
 include/linux/page_owner.h                    |  10 +-
 mm/huge_memory.c                              | 149 +++++++++---
 mm/memcontrol.c                               |  10 +-
 mm/page_alloc.c                               |   8 +-
 mm/page_owner.c                               |   8 +-
 mm/truncate.c                                 |  21 +-
 .../selftests/mm/split_huge_page_test.c       | 223 +++++++++++++++++-
 9 files changed, 382 insertions(+), 72 deletions(-)

-- 
2.43.0


