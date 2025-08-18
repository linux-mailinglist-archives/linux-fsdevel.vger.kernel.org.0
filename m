Return-Path: <linux-fsdevel+bounces-58206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7ECB2B0C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AAC2010E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44031273800;
	Mon, 18 Aug 2025 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fT+6cKY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2582272E6A
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542852; cv=none; b=FskzumhZuXYuS1KVLh3zG7fuBT85YIZ+jjeiiBbKKK4g1XSDrkAPENYVr7fspApzRUbFeuZqnvWbxPtw8agAVISjKUksRhDaatAwj/3rn9cDKCaQirtYHWqd7Ew1i3DH0CfnbnPQfW6bQyW4tApwcTOQE492kZfOcJ4YOoGJ1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542852; c=relaxed/simple;
	bh=I3mlaDpEqcNDtF5YfZZG3GKucVAs2J1X19Vhup6jOKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmWFAAFj3ZGaqn4qg4c5ofzpv1LdXDIIhZkcHzqR9N3EOZrZ9NDSCSVQFDmu+6ytd/1uqdh4HhYmThnTKaCGoJ3rOdHa876BiaZ8rWvTxioE/C36zQIhhULZiCTeA0rSqLb+/uhe9FrXFISd4XpjvGa89czo0vFFIspW3Ocinns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fT+6cKY5; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755542839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h+q0dQZyXjwiVna/qdmYwFty7+4QP8wlenLPfPU4ybI=;
	b=fT+6cKY5SW9ud/HQq2Jjmg+rGfIZYENyeEUS2fD5hp+uiWlb58YP4vKBRHjcz6ojhSyWg9
	kP901WLvabyW9uXifTsf1ehbo/jZXV1cptnbqK15RhqKwAmMbhYFj9i6l3pqRwffY7IqPm
	Rt3QRUcLJgj+8/3wtJbTN+Bds3MBoMM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: remove warning from folio_lruvec
Date: Mon, 18 Aug 2025 11:46:44 -0700
Message-ID: <20250818184644.3679904-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
2.47.3


