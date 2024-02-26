Return-Path: <linux-fsdevel+bounces-12873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AC386822B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008581C2374D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A5131747;
	Mon, 26 Feb 2024 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="hJT3EihE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q5oLgEgT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7712BEA8;
	Mon, 26 Feb 2024 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980973; cv=none; b=HpyaGiOyCD6a1BHkyC9VbTI9H17AqWKJrszwGz5k5FcTbGNjOCCZ3/+t63utA027VUcY9pnE0bEbUbt8CwWuieVKktVQe7CAUSzeEkhGoub0HSmOhtABf9aILF7b476AkCbtv4JxBD2uFY/alPIGH5M/p1EPIImltktF6TUSfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980973; c=relaxed/simple;
	bh=DrLa4gN39OR5eRtafDexilqk38FbJ1y40gc3XkbdbdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUVRCxsS8WDreWGd65SaEDboWZCmepRHjqOOdFq6YlsfbCK5E+swdH/do7cZXkd42ykcXAu9qw4w8Xpsq5MaBYoxOOKy9sEbr8nWg4mEU/0YPQbo2IaYDWW0TyiJqY9a0KnShN7Zarufv3zxGedho2u3E5gje9wFHoa3iTa2TSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=hJT3EihE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q5oLgEgT; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 102EB5C0098;
	Mon, 26 Feb 2024 15:56:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 26 Feb 2024 15:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708980970; x=1709067370; bh=WJOIcMtfPYUOzzIot1iJ43LJYEvqslRWUKh
	o7a0H8UI=; b=hJT3EihEH3zjGCbTc3s5Q1Im8ArJH/JWJT0hNhjb5JGTqkagU5W
	Q4hNKBxOinzn7ifNib2G/h16pcUfmI1/bqfx0QW9ipxOVL/z73oO0wIhUCRQrKIj
	QuyalNfeyGJhvoNoBMmNqOoHD+mZAQ4iOtS8zkzd6wxJ8UyxHfUZ7eiBm3YO68zB
	bD7v8Gb6j9T3B3OXeUkLj/ck3cczpXMLeakNCkel/zMJnic20K6wkIi/8IhA0LwU
	ozLTnlOLqs47hU/ehXc616Wd6Xip/Gxu9kBPBoJ7LBix5axVEearJu+HgHnojEdA
	XYKCy/eTe9paK7oZmye1sK5ka3F4fZ6sVbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708980970; x=1709067370; bh=WJOIcMtfPYUOzzIot1iJ43LJYEvqslRWUKh
	o7a0H8UI=; b=Q5oLgEgTHIUoilhhh8ikGrW+fLZkXFebzxvzF+BCqVKz0mFbfKG
	dNwr2FwozKoylm8kaJXYNkoNFkoj/B6kyoT3uz81JV7UwxrafURxKGHdux6Te0b3
	Bni3HMV50CWoYfsL+SLnqjBzl4Ui3boCn2vCF+xDO/x5DeJRTh6DLcbYuO+HHwOi
	AJLzPdTJ3wgzyZECzE9t6vANiyVrnMz4l/+p78bUdO5MVFirqZUmCBiB3alPjaAb
	1ztIjR0tLINoL8O8036DDADyCfaJuyE2PsrIAa3kOJ76zPSKzcVqY/XV/ewhmKav
	mI2WkIBa2+ajP1dPmr7bZ3UmQU+9kDzWP7g==
X-ME-Sender: <xms:6frcZbtJ_RT1WL0Ly7rRc4lqHV2g-o1y0iEiIju2dpiNADjiSD9xnQ>
    <xme:6frcZceCcOpDLUl2pY9L9-EkUsZpnvJ3UIcKejfNdmgGsG7RinXfr5S-dgT1yDTZP
    VBzOdB9Wa4w21eL8Q>
X-ME-Received: <xmr:6frcZezQOgDW0xWPV_5xIEWTyH6fLthroksUIOEBfn8tZ6ZVPODgtt_cPEdbGbBFjjsezTkElcKhPBNa3a23--gU7ao2IjjXLph3AbhU1nF8B8709EAcBw1O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:6frcZaNoMndnNa-AsDCmuw8jq-tn03GgFLmRnNRma6bzeXCBmwJIxw>
    <xmx:6frcZb_DABfA2mkono8ZGcOeq1vBVjGmOy-ZH6tQ1C9uBpBQtQoR3Q>
    <xmx:6frcZaWOKxL-g67oep7I0AQ2Wxt-6dWgNjbx_VvYDVMGZwSuQwrf9w>
    <xmx:6vrcZYjyHaE-w3DeFaSRYpJ78TzbUmdg3iicUWfUqvkkPlklopuAFw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 15:56:08 -0500 (EST)
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
Subject: [PATCH v5 1/8] mm/huge_memory: only split PMD mapping when necessary in unmap_folio()
Date: Mon, 26 Feb 2024 15:55:27 -0500
Message-ID: <20240226205534.1603748-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226205534.1603748-1-zi.yan@sent.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
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

As multi-size THP support is added, not all THPs are PMD-mapped, thus
during a huge page split, there is no need to always split PMD mapping
in unmap_folio(). Make it conditional.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 28341a5067fb..b20e535e874c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2727,11 +2727,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 
 static void unmap_folio(struct folio *folio)
 {
-	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
-		TTU_SYNC | TTU_BATCH_FLUSH;
+	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SYNC |
+		TTU_BATCH_FLUSH;
 
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
+	if (folio_test_pmd_mappable(folio))
+		ttu_flags |= TTU_SPLIT_HUGE_PMD;
+
 	/*
 	 * Anon pages need migration entries to preserve them, but file
 	 * pages can simply be left unmapped, then faulted back on demand.
-- 
2.43.0


