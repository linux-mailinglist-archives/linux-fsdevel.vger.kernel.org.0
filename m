Return-Path: <linux-fsdevel+bounces-11446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B0B853D50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736541F25740
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300F62814;
	Tue, 13 Feb 2024 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th8U8xQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81441627FC;
	Tue, 13 Feb 2024 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860276; cv=none; b=fCSGrRJVznXsHjz1Ns3eyN1Dg6tEu4DFmmabvyET91Vqjpd0KccgvQsp78TJvg/lry3LIZiD0HYwsQdEIVCKXEN3ijVoOXxMbUyQNku9BcNzR0KGHoRq3NFHOe3MldomX2OmK8G/iUVD34EHADQeA39IpOby5PjiYcfXOwIrLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860276; c=relaxed/simple;
	bh=r6dLn2R32hxUVKrwHaR6P90sYMJO3HfuXaP1srQuHsY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkXA/J50pGzMakWih6ua2sc/DLzVgRNjo14XddvgEJi76TybHcPRKwMIF9nvVdgRyt+pgdcsgdUphTnOTZOOcGsHXtqL1Cks+jJLIZRF5hsShNe08PtQ3oEJXKlvb1wtWdCywgNEqQtQ+rkWLF+cYDNXhYSXUoheLVnqWTw7Qu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th8U8xQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFACC433F1;
	Tue, 13 Feb 2024 21:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707860276;
	bh=r6dLn2R32hxUVKrwHaR6P90sYMJO3HfuXaP1srQuHsY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Th8U8xQDYjqE1oQO4SMhsymZnm2aTPh8ZM7SpIcq4/V3kMtNsQxxEPtEb+A/tXJZf
	 G7CeU83YmDWCAhd/8bx6jK94iSNmgavwSA4WP4N4dJI0dRaDB/zSKquDqTQXzeFO7m
	 nC38c/PXELlpiHWShA/rc3NbKs6cX7/7sxgiSLwa58znNQ1vr0pOGxb0cnwQgQdJbs
	 a8EcruWbXzSxvwZRj8o8Y+0+5a327ukO27y3BcROelsesxB4/7N/jTda8uI3qtQj8A
	 oJsu3SksCpvwru3/pix1RG4ASCwWk4HWxBO5o5oD9ZaLDJTRzKXMbRscRM2tuNVH9G
	 qMSYb7+IbpL7g==
Subject: [PATCH RFC 5/7] test_maple_tree: testing the cyclic allocation
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Tue, 13 Feb 2024 16:37:54 -0500
Message-ID: 
 <170786027413.11135.7987491534374292548.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
References: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Liam R. Howlett <Liam.Howlett@oracle.com>

This tests the interactions of the cyclic allocations, the maple state
index and last, and overflow.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 lib/test_maple_tree.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 29185ac5c727..399380db449c 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3599,6 +3599,45 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	mas_unlock(&mas);
 }
 
+static noinline void __init alloc_cyclic_testing(struct maple_tree *mt)
+{
+	unsigned long location;
+	unsigned long next;
+	int ret = 0;
+	MA_STATE(mas, mt, 0, 0);
+
+	next = 0;
+	mtree_lock(mt);
+	for (int i = 0; i < 100; i++) {
+		mas_alloc_cyclic(&mas, &location, mt, 2, ULONG_MAX, &next, GFP_KERNEL);
+		MAS_BUG_ON(&mas, i != location - 2);
+		MAS_BUG_ON(&mas, mas.index != location);
+		MAS_BUG_ON(&mas, mas.last != location);
+		MAS_BUG_ON(&mas, i != next - 3);
+	}
+
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+	next = 0;
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (int i = 0; i < 100; i++) {
+		mtree_alloc_cyclic(mt, &location, mt, 2, ULONG_MAX, &next, GFP_KERNEL);
+		MT_BUG_ON(mt, i != location - 2);
+		MT_BUG_ON(mt, i != next - 3);
+		MT_BUG_ON(mt, mtree_load(mt, location) != mt);
+	}
+
+	mtree_destroy(mt);
+	/* Overflow test */
+	next = ULONG_MAX - 1;
+	ret = mtree_alloc_cyclic(mt, &location, mt, 2, ULONG_MAX, &next, GFP_KERNEL);
+	MT_BUG_ON(mt, ret != 0);
+	ret = mtree_alloc_cyclic(mt, &location, mt, 2, ULONG_MAX, &next, GFP_KERNEL);
+	MT_BUG_ON(mt, ret != 0);
+	ret = mtree_alloc_cyclic(mt, &location, mt, 2, ULONG_MAX, &next, GFP_KERNEL);
+	MT_BUG_ON(mt, ret != 1);
+}
+
 static DEFINE_MTREE(tree);
 static int __init maple_tree_seed(void)
 {
@@ -3880,6 +3919,11 @@ static int __init maple_tree_seed(void)
 	check_state_handling(&tree);
 	mtree_destroy(&tree);
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	alloc_cyclic_testing(&tree);
+	mtree_destroy(&tree);
+
+
 #if defined(BENCH)
 skip:
 #endif



