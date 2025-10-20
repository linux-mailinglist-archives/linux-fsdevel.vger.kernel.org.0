Return-Path: <linux-fsdevel+bounces-64723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F3DBF270A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 18:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F126A3A568F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D6028B4FE;
	Mon, 20 Oct 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="PBpui/It";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6zxy14j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D381DF742;
	Mon, 20 Oct 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977864; cv=none; b=oHgrdvMsXo9nFofUwkmRGmaMfu/skn7QseswHKaOUubF5DUDet7443FgGxRTLo9gLHa7Uzr/L3fu1/53fbGqBYz8mZyfptvIrtsPNOI/ykYA2xiDzxyr6hJW3nVVENzAAetiaLifVm7IWoJL7tDEJWGq2K9cJxu37kFY96uOUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977864; c=relaxed/simple;
	bh=w8rhJjponnOl2mseTR527adzZWMscgfe5AvbiFb9iBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOsf8a0COFp4shER+xHx7TP4uNytPaQOLbjVPmLyjvF1u+87Pctd+NiLcUTZEc5AbVPTdiLc0gcQDsofFklQbxFRpQT6/2M6zB6Nj6Vno5G9ZV2LYmIyDG+uG1PvLAQy+6+Nbm3NxNp2IBx6An7Xp1BwwCGofuAHBxTVZwKY7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=PBpui/It; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6zxy14j; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id ED40213803F7;
	Mon, 20 Oct 2025 12:30:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 12:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1760977859; x=1760985059; bh=ZXqgQTmDEC
	sjgcK+mqROvdAj9L7HPXL3OBL6D8o0jX8=; b=PBpui/ItG0Dz0gEq24nr9/U2Ct
	+LyL6JuW6DEF+F7K2jN3INZHke5HfWDAkeyyWDxmRfN7jXuY6ojqQP0pQTWfvTUo
	ozpFBI8tb6qGtWQ6/QVykqkc/SD94ZjUBEzR8Z9j1rvkN9WAF9c/v/lkaSH+Quqh
	v6rlSs+/NAaMj7sDcN+8oyEt7hReImgpTiqOyj+rQ87XwGPtYTdWF2eeIuKZn6CP
	gwV4+gA0w+jzp5aMp1dC2zQAAsFzg2K2qol2yPIcKiGzr7glSbP7BvfwTdbgLpwb
	FTRVO6J9vYHMjSCmf1SIhwQh+LzsXNydAZoeAPR0mvUj+tcs4pJsoaJK4LDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760977859; x=1760985059; bh=ZXqgQTmDECsjgcK+mqROvdAj9L7HPXL3OBL
	6D8o0jX8=; b=B6zxy14jXgENJdrrfbrO9Wym6KBvpsWTVLHctDOFybRV+Vt8tqg
	oMT0x8qWsk4dUlkcBa7iwVgziG/asNLXgswGIoDi8JnJaIVIovY0P0DcgHkOy8pj
	Xz463otovez1SExf7HLqb0ZlWqwSr/p8jfK3smsgfeNRE1ilmDpQKuyfJvwliF3H
	Abvqze0AregGZj7PaWSFTCEq7wqZK0KWbFGPjXKFvFW35PmpHK7uLt9mL64emjMA
	ne/8qz2uSAwXt5dTKk7jFTuaGJ/sGU37Zm5OjPFG/JozoAKjShQNzkQQgu2yUnZo
	1BuiOwo1Zzdvdbz6M0yR59R/vV20wP1/T+g==
X-ME-Sender: <xms:wmP2aO6gDWAZmuys2FloIkuECbW3puVDoCFIutRK-iUGvL8hwD-A2w>
    <xme:wmP2aPjRgtsLq04aCGg7MJhSU1ZiezZRS6UhkbdYyIlpELGGhWshXD_fMFOMapp5U
    yfoF_Tt2bi5OJh2VybioBw2kOH6N__JrIrYGP58WiPxExvaRWgu8g>
X-ME-Received: <xmr:wmP2aNo9wbVNeCxNYgDJ0E1gjRede9RdU-zD8RlckeJFROgo0mEutqSETAUANg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepvdehvedutdfhkeetffduiedukedtveejkeefkeegvedtteevkedtueeu
    hfehveeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpohhpvghnghhrohhuphdroh
    hrghdpihgpshhiiigvrdhmmhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtg
    hpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehvihhroh
    esiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrrghunhgvrhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghl
    vgdrtghomhdprhgtphhtthhopehvsggrsghkrgesshhushgvrdgtii
X-ME-Proxy: <xmx:wmP2aDIXk3ie16Gw-5qxQA0WsgTyiZow9hkxwgpOSr4DKe0VQdhbBw>
    <xmx:wmP2aCtzoQF5fOoYxl4BXJRFn5HnoPEFWa1k8g1e6wP0NW0JdvCKpg>
    <xmx:wmP2aLtH1QIFINGnIMOX5oF_b9FwoAhdHNUJ2Hdf7VYeY8ed390CDA>
    <xmx:wmP2aBWA9h-wFEaEZ_xYN6B4rNLCiZMM7Xokd8bN2DvtyP-y7ZSQaw>
    <xmx:w2P2aHSQyHmH-Hg3Nn9XKxLD7FuKXe84gLKoyRHg48g9nRSadC2Y5H6w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 12:30:57 -0400 (EDT)
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
Subject: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Date: Mon, 20 Oct 2025 17:30:52 +0100
Message-ID: <20251020163054.1063646-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

I do NOT want the patches in this patchset to be applied. Instead, I
would like to discuss the semantics of large folios versus SIGBUS.

## Background

Accessing memory within a VMA, but beyond i_size rounded up to the next
page size, is supposed to generate SIGBUS.

This definition is simple if all pages are PAGE_SIZE in size, but with
large folios in the picture, it is no longer the case.

## Problem

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

Generic/749 was introduced last year with reference to POSIX, but no
real workloads were mentioned. It also acknowledged the tmpfs deviation
from the test case.

POSIX indeed says[3]:

	References within the address range starting at pa and
	continuing for len bytes to whole pages following the end of an
	object shall result in delivery of a SIGBUS signal.

Do we care about adhering strictly to this in absence of real workloads
that relies on this semantics?

I think it valuable to allow kernel to map memory with a larger chunks
-- whole folio -- to get TLB benefits (from both huge pages and TLB
coalescing). I value TLB hit rate over POSIX wording.

Any opinions?

See also discussion in the thread[1] with the report.

[1] https://lore.kernel.org/all/20251014175214.GW6188@frogsfrogsfrogs
[2] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/tests/generic/749?h=for-next&id=e4a6b119e5229599eac96235fb7e683b8a8bdc53
[3] https://pubs.opengroup.org/onlinepubs/9799919799/

Kiryl Shutsemau (2):
  mm/memory: Do not populate page table entries beyond i_size.
  mm/truncate: Unmap large folio on split failure

 mm/filemap.c  | 18 ++++++++++--------
 mm/memory.c   | 12 ++++++++++--
 mm/truncate.c | 29 ++++++++++++++++++++++++++---
 3 files changed, 46 insertions(+), 13 deletions(-)

-- 
2.50.1


