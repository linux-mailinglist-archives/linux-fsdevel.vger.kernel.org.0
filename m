Return-Path: <linux-fsdevel+bounces-65698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C11DC0D58B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EBF188FB0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC582FF161;
	Mon, 27 Oct 2025 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="AOl3ZdS+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0Nz516H/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F42F7461;
	Mon, 27 Oct 2025 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566210; cv=none; b=kfTZyZ+jQepIdwTy5QA99iwyTYjhaSUO/Eiv7nvKXQEW8uC24Qyw47pZn6iDA7/58GMlvLNFRRAAvQFiJGRuO1Z1/t//VfEy4p9lor9D4nnBjizvIiIQX2WT1NOBcPwsW2qXgBjpCHmKSC1JGmrByAXwFgcSvJfyIqGmO4VJllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566210; c=relaxed/simple;
	bh=8PYVIbx0tY0kA0vk3SKOZZb7YeQohAml3a3cYHEWGak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmUfkCrnl9vcDNkzGK1EbLQR4b+1gHnHQynboyF1zTOdjP/zK4LZ1cos79Fhos3jKRUI1Sgw05zDK48HAVFDX/PC8cyZOK5Gymd2VMzWcTmnkYh7iERNk1YsP+mFeeqz7zPglCLGtBkCJ72vcICUgDUSSxwF6RZJYV/+QXLExhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=AOl3ZdS+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0Nz516H/; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 7E55F138020C;
	Mon, 27 Oct 2025 07:56:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 27 Oct 2025 07:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1761566206; x=1761573406; bh=8QkiUhrwE7
	SvkxSp/9VIHNDJrnJl5Yf/PMzKGs/KsxY=; b=AOl3ZdS+ebhNCWQTP52MwZtdDy
	ifgX9Qmf/dZ1ZyXAzI6r3tRNGQ16WeG47Hz6WHPPGsXPshZYcQwCHAxcatfs+VUj
	95DoykQF93sMsvU6GWwhz3D9y7i2HXLrz7lnM26lLHOzEpRuVG1l7DpuVq9fw2Iz
	UYVE+UFIEs7wiAG4KSDLpJiKe8bhK6WkdbGxeV/O/c3RtwEC6RpiFbirWYi2vqS/
	qYRSgUzUhLy7cZ/kFWHLlfQJmwciNkcN+KX2MaM+CUox+vV7JtBwV9JV14mp4mGX
	4ZxnPO+Gc86S/0uaIFvBRS/qc+R8E3E6psIjUGkOJqwlHYmYAJld7WNwHf1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761566206; x=1761573406; bh=8QkiUhrwE7SvkxSp/9VIHNDJrnJl5Yf/PMz
	KGs/KsxY=; b=0Nz516H/O3edNSM7DWL5+Oh2DWYUWiSWSfVi48ls5mv32NQYKsS
	mmu8DoFt5EqUhpLQbLr5A8LCs9vqXyvWTdxQohnR3eKHlmZpYjhgv5NhpxYsn6Ml
	4gHJ0LSOD5ZyWj2hTTXLET0Vj5i1jMWijF+JJDC59UO5v086ZKuwWHehl1FoAXA5
	9kGYBswARJ2HpPVkJYCF01VvlIPv4vxAQevEWmXFe+cRGG5XzcbFXMy2h3hvGsq5
	PfqqtX/8oeHPFtEBkShlwBgjWNh3NeQWSE85H3t7WWWzsT8b0m+yAqEIcON6FyH0
	eHE/Isq75ab8tbGezAhy/D6N1MJiNAEfv8g==
X-ME-Sender: <xms:_F3_aEM5_LGg1cszjjnbkCxMxkhGvwLAKwaDuMHsIwAnn6jXSwZuAQ>
    <xme:_F3_aP2G60ni6qJQkM34HC1YMA7vvtXyGD08pzqUXMy5p940bDrSswHuJ63IjQx0z
    YcH8wAQzNXDKSEU4xSjccSMuFkHZClSYaZnZH4OjEb70g2EH1rfNHM>
X-ME-Received: <xmr:_F3_aI3Y90Pe-2fbuwd7Cb-_oz_EIIUJh9Gcclytji6UNGOo3XZjgXcIsVAHkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepteffudduheevjeefudegkedttdevtdfhheefheetffelteeiveehvdef
    gedtheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedvfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunh
    gurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifihhllh
    ihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhl
    ihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtg
    hpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:_F3_aOyxtJGiAVeIFw5YuI7E3rf0w24TeZ_3QWJEHQ3wnzXsd43zLQ>
    <xmx:_F3_aLkioqsZ4O8fSJGjV_Ajxfn2pp9jj1iJPqAYMafdU-kELBIMEQ>
    <xmx:_F3_aCxG8f0xFXuOh_887PP1j7WImMOsAibUdZjOegr_mWgAFkVY9w>
    <xmx:_F3_aKKoEwbsq_SgslE1B4k74GLwG7K0eX5YBbVmH12VlgYr4gSzLQ>
    <xmx:_l3_aGXbf2WLSgColDcOgQZY_p2Sirf6o6-tGU_Ywk1gS-xom0z-jX2j>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:56:44 -0400 (EDT)
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
Subject: [PATCHv3 0/2] Fix SIGBUS semantics with large folios
Date: Mon, 27 Oct 2025 11:56:34 +0000
Message-ID: <20251027115636.82382-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

Accessing memory within a VMA, but beyond i_size rounded up to the next
page size, is supposed to generate SIGBUS.

Darrick reported[1] an xfstests regression in v6.18-rc1. generic/749
failed due to missing SIGBUS. This was caused by my recent changes that
try to fault in the whole folio where possible:

        19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
        357b92761d94 ("mm/filemap: map entire large folio faultaround")

These changes did not consider i_size when setting up PTEs, leading to
xfstest breakage.

However, the problem has been present in the kernel for a long time -
since huge tmpfs was introduced in 2016. The kernel happily maps
PMD-sized folios as PMD without checking i_size. And huge=always tmpfs
allocates PMD-size folios on any writes.

I considered this corner case when I implemented a large tmpfs, and my
conclusion was that no one in their right mind should rely on receiving
a SIGBUS signal when accessing beyond i_size. I cannot imagine how it
could be useful for the workload.

But apparently filesystem folks care a lot about preserving strict
SIGBUS semantics.

Generic/749 was introduced last year with reference to POSIX, but no
real workloads were mentioned. It also acknowledged the tmpfs deviation
from the test case.

POSIX indeed says[3]:

        References within the address range starting at pa and
        continuing for len bytes to whole pages following the end of an
        object shall result in delivery of a SIGBUS signal.

The patchset fixes the regression introduced by recent changes as well
as more subtle SIGBUS breakage due to split failure on truncation.

v3:
 - Make an exception for tmpfs/shmem, code restructured;
 - Rebased to mm-everything (v2 of the patchset reverted);
v2:
 - Fix try_to_unmap() flags;
 - Add warning if try_to_unmap() fails to unmap the folio;
 - Adjust comments and commit messages;
 - Whitespace fixes;
v1:
 - Drop RFC;
 - Add Signed-off-bys;

Kiryl Shutsemau (2):
  mm/memory: Do not populate page table entries beyond i_size
  mm/truncate: Unmap large folio on split failure

 mm/filemap.c  | 28 ++++++++++++++++++++--------
 mm/memory.c   | 20 +++++++++++++++++++-
 mm/truncate.c | 35 +++++++++++++++++++++++++++++------
 3 files changed, 68 insertions(+), 15 deletions(-)

-- 
2.50.1


