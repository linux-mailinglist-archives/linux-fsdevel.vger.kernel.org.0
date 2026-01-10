Return-Path: <linux-fsdevel+bounces-73124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56706D0CEB6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C02330AE2CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6828B29993D;
	Sat, 10 Jan 2026 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HIWKl4Pf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873B280A29;
	Sat, 10 Jan 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017666; cv=none; b=avQKeeRSA2hjAbCmx6GUOg6jAnYT4A44CjCfkpcv8I4SjgPkzgibqxqyX2QFMBx7cwU+5hZeIiqbTc88EvU/yviM7M3MLqsQqeNnaJwLH5vlkVWKrfpu/1kNbjn6ZVr5a4p4PxbQkj+X424ddxbQcXV6Sk65YnZDf2OiFR4Imd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017666; c=relaxed/simple;
	bh=tKP1aoJsMshShmP7ntwoPS9EYaOrFv/7/uBuq6JO8AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utyglzB5/UFDStq/iqZzGbKrDabTVNCkyBVqOFz2ZqBy5QafOLI6hN4VTx1damoFgoXWzlrk6uG3dHLWiz6INzkZlWl/tG/w/ZCOtqjMNRfQR1VlO2Ks0Qoy6dRI4CvYuQuoTkgCvPb9LPz706fNOREi0vtX+xIApCzvqh6oN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HIWKl4Pf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QpWF0f2SP02fz5D0RQUbdZlrc1oKAOcosJWDE+NgvuA=; b=HIWKl4PfjCkBCTB/oOEIVkqj+Z
	5YZATPeRZsWeb5vCSUWK70sBsvb74NkrcRaT0oNRKQE4hJQ5UBuYKTklpm3XIvq1nU3MB8Jz+gMND
	tC+3u4TJG4qPy/Osswy1K8O5OgMZKWvJa4TeC58hXAly6rJvcF6Vzyd8wcETf7aibPEz9N3gcfixj
	2n9si2f/S8XjgWiMe/3QCRqzvSlg7n84lcXieqIx51vwa1zc3yb3/uS/tvoHF0nzLqCDcLB51T9Wr
	U6/+JW5R9eXd0o6pSLUjxrxzEpnR06tjBb8qthBJ+kLFOPV9RQIe06B2i9RWSmbeyC9JsHc+pZGV0
	RwJtMCUw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB9-000000085aC-2Hni;
	Sat, 10 Jan 2026 04:02:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/15] turn mm_cachep static-duration
Date: Sat, 10 Jan 2026 04:02:13 +0000
Message-ID: <20260110040217.1927971-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/fork.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d5b7e4d51596..f83ca2f5826f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -478,7 +478,8 @@ struct kmem_cache_opaque files_cache;
 struct kmem_cache *fs_cachep;
 
 /* SLAB cache for mm_struct structures (tsk->mm) */
-static struct kmem_cache *mm_cachep;
+static struct kmem_cache_opaque mm_cache;
+#define mm_cachep to_kmem_cache(&mm_cache)
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
@@ -3011,7 +3012,7 @@ void __init mm_cache_init(void)
 	 */
 	mm_size = sizeof(struct mm_struct) + cpumask_size() + mm_cid_size();
 
-	mm_cachep = kmem_cache_create_usercopy("mm_struct",
+	kmem_cache_setup_usercopy(mm_cachep, "mm_struct",
 			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			offsetof(struct mm_struct, saved_auxv),
-- 
2.47.3


