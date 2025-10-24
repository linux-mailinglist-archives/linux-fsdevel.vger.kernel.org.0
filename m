Return-Path: <linux-fsdevel+bounces-65435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A999C053C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A71A0686A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5AE3090C9;
	Fri, 24 Oct 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ANiS5Erw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tlbb2HLV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D12308F39;
	Fri, 24 Oct 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296721; cv=none; b=ojKc0bAIcE71g3V6HUxEqyZm9ETYb83bsgiUet1/au0sgUxhSOjGw7bPsQEfqrL9JNa8hv/9IQARth1vehxKPqUmV0PXTx0Mu5X7tbBex+IMKg8Oq+ig0zDpV6X6g+n/jXAxanlviocRzg+CnI8Ip2tQjU+BWGX4jl8wNlMLC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296721; c=relaxed/simple;
	bh=dP5980YsRaLUhiroNTQesPNMylhYRYAU7PYAYKzy1E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlGHRxrGRKs/Cp6l6THyw7ESVPXuxqdSfemr2OVJPfZxTlBvrRVAzwwHWvt1tnJRtQWCnGQVHdWx+hJDbCn8aa6qARGZgOv5jvb2F5h8OEa44gqXCBrcqpGHpZ43kOcNAkmth9lOrrRc+Xltl7QDE80dSSupKaDsAar/2WvQoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ANiS5Erw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tlbb2HLV; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 65E981380333;
	Fri, 24 Oct 2025 05:05:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 05:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761296717; x=
	1761303917; bh=LzxoOpuRHVLLxFPTQuj5Q9D1orPS20zYzzKfEt8tzg8=; b=A
	NiS5ErwWj07SDbOX7wjxBWb9q9Gy18k1wlFyespmT6y7i78YixIe67iX6xAus+42
	dKwoTJm3rEHg+N2tSW4/dnLGihhQvGqXzQsiIr0B/i8EhsGafADk7s+EOnOiZGz/
	g25mTFNIEL85njmLOB6br8GiEza4+JI5Kl1mWkelPrRdoiui4hUwwTR8ondqozkH
	yBxU1o40xDvJMKzkLL+68Dk+UpBEBETjseTQYDwD69lu3rKNJ8KrSCzjrtQ93OPK
	l5lGqjx2llYIVym4iDsHfkEUVqPrFt3Lpi998s2SYHm5OLT/gzU7ZYNeUIeA81/e
	bMkDzAYvzEsUuARwH0cig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761296717; x=1761303917; bh=LzxoOpuRHVLLxFPTQuj5Q9D1orPS20zYzzK
	fEt8tzg8=; b=Tlbb2HLVyYS7KstUdegxMU7zEdNEa7N52WD4YLnYURYlpdyQQTc
	c0J83zvzy3JzpIwg+h1I3TBTst6gR9U7qn14a4PfUEV4aflq9k+Y2xvYt5cnwcCW
	nDQuawtKQSqjS4sYwbzbGYOaYOdfQxcU90SK0Fj/uozES4FU5J158KBoOMnUVIkt
	IvFG0pYjek/QvtwMjCljmAoDcmN62kTompAmvIgxKz704SqW8/8ctZA6VDhPCvxa
	KYI/0OxiER9nrnd4MSKS0bOGwvAj9xdMqYF+iBdk9WlI/rQaOXlPBhzOVrsDacB6
	rOJS88/Dn+177BnxCUTRb+dLNRtDLLkRZcw==
X-ME-Sender: <xms:S0H7aHL04JtqiuSargFb7zQJAxCpLHhAczxS72CAoPagNc7gcmbR2A>
    <xme:S0H7aEOW8NTp8RxBicT8q61ykl6-kyA9HsqMozR6Su22VJiynieIW_V5hk-b9rkqs
    Mf2esSAT6WU7UsRfm0v3EDuiR_rksm1CJ2_8LZVKWONGCfF2p3Zsg>
X-ME-Received: <xmr:S0H7aCpD1WNKN8XVf1yqtLQ78p6E2Z7A67xQoTfj_lmd1ri0D7ljIjUq-uET1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepgeefheelvedvteffleeuffdtffelvdfgteehgeeiveetgfefhfei
    jeehveekieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghm
    ohhvrdhnrghmvgdpnhgspghrtghpthhtohepgeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhughhhugesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhr
    ghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhorhgv
    nhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhirghmrd
    hhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgesshhu
    shgvrdgtii
X-ME-Proxy: <xmx:S0H7aNdki9UJUz0NQesx9xxTyDsPWu4kz3OouIZBFGvZJCcu1qQ2LQ>
    <xmx:S0H7aLae0FnbklGqvr3ErBnn_WMZkGG8niRmkyzB02Rg153NsKVAVQ>
    <xmx:S0H7aACB0vysQ-M5-RkvyLNY2LXH1dkxsQEusVw75cPr9s9yLP-Tng>
    <xmx:S0H7aGCiXudRcMIYBzADUv7SEN63WFVKILIuG87dZnH5nNRU0pIf8w>
    <xmx:TUH7aNFSqtzaDOz-qPI1dGtn0qLQi1xryUp4aAbrWfAvhOkN2V1U5nWA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 05:05:14 -0400 (EDT)
Date: Fri, 24 Oct 2025 10:05:11 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] mm/truncate: Unmap large folio on split failure
Message-ID: <efm75n5srtb4xp5akp4x6sq6522p4hivzge7ufwnkodsw2yixt@ahntf6d2qe4h>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-3-kirill@shutemov.name>
 <20251023135644.f955b3aa4b4df23f621087c4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023135644.f955b3aa4b4df23f621087c4@linux-foundation.org>

On Thu, Oct 23, 2025 at 01:56:44PM -0700, Andrew Morton wrote:
> On Thu, 23 Oct 2025 10:32:51 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > supposed to generate SIGBUS.
> > 
> > This behavior might not be respected on truncation.
> > 
> > During truncation, the kernel splits a large folio in order to reclaim
> > memory. As a side effect, it unmaps the folio and destroys PMD mappings
> > of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
> > are preserved.
> > 
> > However, if the split fails, PMD mappings are preserved and the user
> > will not receive SIGBUS on any accesses within the PMD.
> > 
> > Unmap the folio on split failure. It will lead to refault as PTEs and
> > preserve SIGBUS semantics.
> 
> This conflicts significantly with mm-hotfixes's
> https://lore.kernel.org/all/20251017013630.139907-1-ziy@nvidia.com/T/#u,
> whcih is cc:stable.
> 
> What do do here?

The patch below applies cleanly onto mm-everything.

Let me now if you want solve the conflict other way around. I can rebase
Zi's patch on top my patchset.

From 3ebc2c6690928def2b123e5f44014c02011cfc65 Mon Sep 17 00:00:00 2001
From: Kiryl Shutsemau <kas@kernel.org>
Date: Mon, 20 Oct 2025 14:08:21 +0100
Subject: [PATCH] mm/truncate: Unmap large folio on split failure

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
 mm/truncate.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 9210cf808f5c..6936b8e88e72 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -177,6 +177,29 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	return 0;
 }
 
+static int try_folio_split_or_unmap(struct folio *folio, struct page *split_at,
+				    unsigned long min_order)
+{
+	enum ttu_flags ttu_flags =
+		TTU_SYNC |
+		TTU_SPLIT_HUGE_PMD |
+		TTU_IGNORE_MLOCK;
+	int ret;
+
+	ret = try_folio_split_to_order(folio, split_at, min_order);
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
@@ -226,7 +249,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 
 	min_order = mapping_min_folio_order(folio->mapping);
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split_to_order(folio, split_at, min_order)) {
+	if (!try_folio_split_or_unmap(folio, split_at, min_order)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -250,13 +273,10 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		if (!folio_trylock(folio2))
 			goto out;
 
-		/*
-		 * make sure folio2 is large and does not change its mapping.
-		 * Its split result does not matter here.
-		 */
+		/* make sure folio2 is large and does not change its mapping */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split_to_order(folio2, split_at2, min_order);
+			try_folio_split_or_unmap(folio2, split_at2, min_order);
 
 		folio_unlock(folio2);
 out:
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

