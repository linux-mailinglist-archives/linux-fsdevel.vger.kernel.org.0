Return-Path: <linux-fsdevel+bounces-58228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64307B2B564
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2740E2A391A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7481494A8;
	Tue, 19 Aug 2025 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="s0qb2bIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eAtlw1AA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA21991B6;
	Tue, 19 Aug 2025 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563792; cv=none; b=txH1EaJ2KL6K7TFBJkPfmy+xDVIfbYw+8lKidTwjU7tmzyBymFgUVUKtbYjqRd+U46sZwaYmHJhTZVu6ij2fH54ipvCImhhj8m9Jm3TquDQXywhyAXtDaMdHPCAH8wXmAs+VCfymqZELEKRv3dX+0653lVdhFQ+mNJArHx63CLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563792; c=relaxed/simple;
	bh=V6Oz50hlpPq57S4JFpLCzy8R0ttMJ4XsvgIU2nLpmzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1ZlEJUNl568UkfInp11+dW6wVxXSXJdX9bHITkhxSyVPWnuh126sfh+uHbJQm3vB7T5o5E0j41U7eaYzdv65OMcHQpuMp27mGBktZmJMQyXxVeSt92jgenNr+pN1XTH5N2a+Zy7K41d99/rI/yln8wIs3WKDd/b+Y7/iHaZcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=s0qb2bIh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eAtlw1AA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C0D5EC0853;
	Mon, 18 Aug 2025 20:36:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 18 Aug 2025 20:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755563789; x=
	1755650189; bh=u4jbtDWlH4fW3RgHZtpgw2FYUwY1QFj6S1833X5dCgc=; b=s
	0qb2bIhJA+VfL4JxcGIFVoMcrlZfSYd+t0NtSAktMy6vA0kg1lhAQ+t14CErYEZN
	UV+bvoEWZjEA0Q5Wn7m8NbI57fap1X7+3IFWyvQUTR3TNv4uWfJ3xn1RG6wBC2WD
	4VapbYL5RxbeX6F4SNyoO+yWHGUPrylCs1YxJDN6j1f1M0kGwH9lsvIrpGKOpUOw
	+l7HZiB/rVxDWT3E0M2pVhjw2RKRbEVUwQJwZEFyHz5qdY66myu3WiH7oODZF+Ds
	7PxT1yHpBM/Cx0A5I76HwIwXk/fexwOq85wm/Q2W5toYBP6JjOYDMYHi/GTlYEWo
	POyFWc1TCrf3uBC6VgBRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755563789; x=1755650189; bh=u
	4jbtDWlH4fW3RgHZtpgw2FYUwY1QFj6S1833X5dCgc=; b=eAtlw1AAcna6a2w7y
	0Vw2NScfDCuCheV0l1m72WiwrXMFWqzLqAco40cz4Xx+sVMQ2jc4FneCdoMFbOzi
	X9NWg/5WDDhz7DHq41ykVM6kqXfV5ZKT0Z5F49z2CUJEttfol72dlpdv/CuDHOI5
	FwsEd4vP2BWYfqJWos1JtzGOusxYsNK9LwG2bs8y1BnpJPihaUaClm4hGJUur8Sl
	H5e8BnFKHbf0G++1Nd95q+CAFwh8M9fEk2VteABaUow8RnEiKwbwe0TJIaJw4LU3
	LrxcezqChGjPz/f2bWv0VmSJpvwKXSm5AnPMvx3IsK8TUnYNsccmcNWpa0VvzdX4
	5MJPg==
X-ME-Sender: <xms:DcejaN7qPpOSkCLo_Dq-y_9dJW26on58-EVvVqnLC9W82hY1D_cpHQ>
    <xme:DcejaAYLAIgTCjIltDtFaOJedbt2_KrCmVqGjH1uyUIm2WSgQsgcjYJTGZwTlwxKE
    mSo1D4XWeiZPGrAJK8>
X-ME-Received: <xmr:DcejaDjncnolvloFZXC6gZcBS9S34KRYCJoYtHzickaSB44YULF_bOrTX7oE4gt8mFMQFfb9p3FFhezRusmKXHIzNjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepueekhfeuleegtdevudeggfethfdvgfehteejuddugf
    ejffekueefudelieeuleevnecuffhomhgrihhnpehshiiisghothdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghl
    qdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohepshhhrghkvggvlhdrsghuthhtsehlih
    hnuhigrdguvghvpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtohep
    fihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmhhhotghkoheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DcejaKfQ4d8rLqZYBEsJpLYGUsBMxtScHd0Z366wZdkbI_bZ27kqew>
    <xmx:DcejaKlf-rLNhJjqlbmhjzn7nyLqqZDzZEn12TuJZvHesXOqOnJylg>
    <xmx:DcejaHyySGEK2eX4qeaQ4Fr-HbJ7PSW_BmlZF_jH1qEEg2oh0PTbzA>
    <xmx:DcejaFwGDTTdP1r1vfm6hFPe4kTE6PlyB9mOP0mPnlkTyx1iMaDHLw>
    <xmx:DcejaJLkwITDUFaiDXM_USMOTo9Dq7Nc8tYvh4MxnTpcG60Nen2wEYWb>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 20:36:28 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: akpm@linux-foundation.org
Cc: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com,
	shakeel.butt@linux.dev,
	wqu@suse.com,
	willy@infradead.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: [PATCH v3 4/4] memcg: remove warning from folio_lruvec
Date: Mon, 18 Aug 2025 17:36:56 -0700
Message-ID: <0cf22669a203b8671b6774408bfa4864ba3dbf60.1755562487.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755562487.git.boris@bur.io>
References: <cover.1755562487.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shakeel Butt <shakeel.butt@linux.dev>

Commit a4055888629bc ("mm/memcg: warning on !memcg after readahead page
charged") added the warning in folio_lruvec (older name was
mem_cgroup_page_lruvec) for !memcg when charging of readahead pages were
added to the kernel. Basically lru pages on a memcg enabled system were
always expected to be charged to a memcg.

However a recent functionality to allow metadata of btrfs, which is in
page cache, to be uncharged is added to the kernel. We can either change
the condition to only check anon pages or file pages which does not have
AS_UNCHARGED in their mapping. Instead of such complicated check, let's
just remove the warning as it is not really helpful anymore.

Closes: https://ci.syzbot.org/series/15fd2538-1138-43c0-b4d6-6d7f53b0be69
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9fa3afc90dd5..fae105a9cb46 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -729,10 +729,7 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
  */
 static inline struct lruvec *folio_lruvec(struct folio *folio)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
-
-	VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled(), folio);
-	return mem_cgroup_lruvec(memcg, folio_pgdat(folio));
+	return mem_cgroup_lruvec(folio_memcg(folio), folio_pgdat(folio));
 }
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
-- 
2.50.1


