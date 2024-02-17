Return-Path: <linux-fsdevel+bounces-11923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078ED8592A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 21:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371F01C22BFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 20:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29457FBC2;
	Sat, 17 Feb 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/VgTJ4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC567FBAC;
	Sat, 17 Feb 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201451; cv=none; b=m9OenjuRKdhYD1E0hCKuD9WzFBYc6CfKQ3mGftdizUFIAJo7VJoS3CIhp3haM9CZhk7ldLE4F9RBk3n72+phF7uilnh6dvngnLbHgkmwN60bJR33LMJUM2YkeyRB0QCD8R+5VyRAeaFWtI/eRUUanUbaNchNobzheoqPfnsI8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201451; c=relaxed/simple;
	bh=r6dLn2R32hxUVKrwHaR6P90sYMJO3HfuXaP1srQuHsY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGeq762d7q8FXyZEDTlesMwDnrPM9wgHfW9GsjYa69R/XDIHhI3VQn7JDk5eF+GEsmRjqDsQb5Jtz+jc2aLGfWWOvKRyCm/2RIya7HpmW2ZFq5Z5lJ3D4QvJxpNVFBng0ooKBQkkV8LLSek/OgHIfHy0VnVv/VSS8QrE4sjdW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/VgTJ4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B52C433C7;
	Sat, 17 Feb 2024 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708201451;
	bh=r6dLn2R32hxUVKrwHaR6P90sYMJO3HfuXaP1srQuHsY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O/VgTJ4chu/g5D0kuQ6IwQrqk6Yged1gYNOnPpILQjot3IwuwxhS0tjBHhH+sQ2Kz
	 Zxyb7DTRLGPN4oi1a1lmsh4iMS7n4x8eU7JR4n/7kJCgHm31IjaEMLd1aj3WKlJZTI
	 cWR5pWetfkjmwe/CpCU4IWr+5zr/kolzJq/4IHeq53kuEhX7f+Lj34sgVaaCR9TUTA
	 WqRRhpu5EBPzA0IeI1/a8ljmj1zl5QVpNFm6gr31iF/Lh2h1sWihqI5TErBNv7U0Gl
	 nkriuby+Se6wuvehqDAuLb9N0LS2Jbw55eloingd6OQJgzmXnWAbWh+8Yghq/aV+hZ
	 9cHhYH/qLF81Q==
Subject: [PATCH v2 5/6] test_maple_tree: testing the cyclic allocation
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Sat, 17 Feb 2024 15:24:08 -0500
Message-ID: 
 <170820144894.6328.13052830860966450674.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
References: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
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



