Return-Path: <linux-fsdevel+bounces-65283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF625C0042A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B7FF4FDE87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF8308F15;
	Thu, 23 Oct 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="WXD9J2qo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ywj7+ApG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F03081D7;
	Thu, 23 Oct 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211980; cv=none; b=uVdbQqffectLWGJfhK71hBYVn/LO/GmdqculxM4FJ89hY/6xzu1cryMaYIQrZr4X9dLJ3tx+CX7HgefijhqvypIP5QnDWqYM60XgnCFwtAwHNYRRVzjn5u3SexYKtrSYcN0JGaAXWmqrhzLRtS5EpX4SClEoiiFtqj/h9RUT3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211980; c=relaxed/simple;
	bh=mlODJz+cHc055qdQR/LQBoEszvTUhMl8PBS2UORVQ7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxpsVjSelRoWVHYhXg2c6FJyjgDmUVpXsJZs84/kRNQaPezbwRbakW0pj8rMdHhlRZ2DBMW9WdXKNU1XHo6s0RDoSYC/LXTI3UuV7l8eG055AR9qcI/VlauWkm+S1cES6gNaWYJTkD6k/TBXLYYscuc/veLbzOklZyvYsKF3BpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=WXD9J2qo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ywj7+ApG; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 9B08F13000DF;
	Thu, 23 Oct 2025 05:32:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 05:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1761211976; x=1761219176; bh=JpEbXLdyv4
	zRi9q4jG2thsTB7UumiqydROSACboCZdc=; b=WXD9J2qolILlMu/wSfALLzy5zp
	xKjuoLs2NvfrOf0avtbD1zadDqGtSUN/e3+8hhElUB/pWrZGRa35cvxL8CBOytZZ
	IF1Uw+lZ2KJOdJf4vteKev+a1a7iw5GvY1r3EHBTrrMvRMZ6IHMj5o9kajt9gr1j
	7TKc6HCl7BA4X/tUQ9OJpR6TlAykA6owKUy2C0v0+MEK7OUjisf2ey999kmUH6Ke
	2IQ4YbLjrIY7by03g+zjshZ4TTips3/2DSlExeHa1IIhz300Kz3svDGh7LJutbdw
	MsAJMJ49e0blRJ3Bu5YpFC7UG0Lxunwxd7Kv5sR75wppGjfaxjtfMrPUDv7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761211976; x=1761219176; bh=JpEbXLdyv4zRi9q4jG2thsTB7UumiqydROS
	ACboCZdc=; b=Ywj7+ApGd0dfST1EClxkJiq63ZVw8nS0I0KH0NzRG11rhKpQl9d
	UM5sQScTUXrhgnrkSNEK86ZcySei+uZzegDTPrCSu6Z4m8Ucb5Kvy95CwaGbnY88
	/TvffQIincitKWd7fKUQH21EpwTCLTH/bqpg0mxyIivhUIBVyTajkURTozxNpaik
	McbN+nGqf2d5xux6FrXiCqN+og9yXTef9BrThVkhOIkM22GL95a09N48tdWmuSAM
	NxT60nYfqZyEmF1m7q1k+BwhS/hJmFBJnccCXPNCk/w/wWM7iyq1TvgZQR4BkiIB
	T3EUqbbSSOCZ9gN7BRGWKIlQZigXDJrWy5w==
X-ME-Sender: <xms:Rvb5aKJAEFanFnza2LtsAO3cwa5TVb5mtWsDDG0jRIpJ2WKxGGjKtA>
    <xme:Rvb5aHAEplJEeuqtc52ETz3YkyokLCLggxeLN2CZ4nc8xukvTHgYszQFirKFuHs6Z
    Wsc8iSUYVutEDYmu1EkUnGgqPsi2ox2E5gdIw1vl58KJ8LQHgW33Zo>
X-ME-Received: <xmr:Rvb5aISUGOid_JLDRxWbZ1bLIfQEdaLvUzXw18E9pSwAXfNoefyzIi5td670sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepueeivefhieejtefgtdekveefueeffedutdeukeehvdduveeufedvuddu
    geffgfdunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpohhpvghnghhrohhuphdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    ihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvdefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlhies
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinh
    hugidrohhrghdruhhkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphht
    thhopehvsggrsghkrgesshhushgvrdgtii
X-ME-Proxy: <xmx:Rvb5aBekOFYmCwP8MdsVJR3vq8SjIXp0-rmqH_luY0mDmdodx3ybVQ>
    <xmx:Rvb5aAjhBm2328QNuqORXYxyoEmVUseXfE8zil5T5WC2uHeKtZgZdA>
    <xmx:Rvb5aM9HpcvjXQNOWjwIQUeVq8LUtTXKKLHeKPmk6e5zK33H51vN-g>
    <xmx:Rvb5aAnNdDGFi26z0v-H_e4ek3IDZD6UN9okh2xgtUVdCls8yk-Cug>
    <xmx:SPb5aIzkbfmr8tJe4A1IXhYXWGIKA1RCbS7L7CafQe7XKPOui_lhaVjU>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 05:32:53 -0400 (EDT)
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
Subject: [PATCHv2 0/2] Fix SIGBUS semantics with large folios
Date: Thu, 23 Oct 2025 10:32:49 +0100
Message-ID: <20251023093251.54146-1-kirill@shutemov.name>
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

v2:
 - Fix try_to_unmap() flags;
 - Add warning if try_to_unmap() fails to unmap the folio;
 - Adjust comments and commit messages;
 - Whitespace fixes;
v1:
 - Drop RFC;
 - Add Signed-off-bys;

[1] https://lore.kernel.org/all/20251014175214.GW6188@frogsfrogsfrogs
[2]
https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/tests/generic/749?h=for-next&id=e4a6b119e5
229599eac96235fb7e683b8a8bdc53
[3] https://pubs.opengroup.org/onlinepubs/9799919799/
Kiryl Shutsemau (2):
  mm/memory: Do not populate page table entries beyond i_size
  mm/truncate: Unmap large folio on split failure

 mm/filemap.c  | 18 ++++++++++--------
 mm/memory.c   | 13 +++++++++++--
 mm/truncate.c | 31 +++++++++++++++++++++++++------
 3 files changed, 46 insertions(+), 16 deletions(-)

-- 
2.50.1


