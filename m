Return-Path: <linux-fsdevel+bounces-38969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13CEA0A792
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99E53A8A01
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB02192B8C;
	Sun, 12 Jan 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LiDPAedQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338D17ADE8
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669230; cv=none; b=IYBJ9JdHjw/C2trCv907wyjGMU/RcA4pVFRIPK1PBlFVVdzPblZeljvBuLlHMYJgY4Bo59xyxu+QwSaTKmVUXr26Esfsj/GaTwCI9MYMjfCxXzExdp09dgvpTVg+n5cAAo04EUsa45Qfo1grvXdrPYIdBSLMSUw3H4G22ImBqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669230; c=relaxed/simple;
	bh=CyRscPQ+JqS39wJ/rbHekCJ5IcGNMw//iYJkpDOpE9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxmg4qTEKcRKX54ga5a06ecJrHEIMpX7J4r9Y9jlkDsUiBPJs8YpG0GFxcngWxnuIgyUbUkEmBx6ii/Ge6T8MGOVE8tOqpXo7plXI3MyaxIQZLP/eil868botqJfgVhHd+8UOBZP4VIt1ZqmbJVG8CiB26kaQpZ88RZFSR89Tds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LiDPAedQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qf5TAAhkW5LD0bVX6MGG2xxw06KJdOFvtPuRfP0r7QU=; b=LiDPAedQXoBXXltZwd1BONVkEQ
	tA7vK4NXKr+bDTOMlygjD5VANPGu82eF7nOu1z01hjAzYpHpOmhzIH3E33sBhdZ/mgpgF7HePwHiS
	GPmsrBlAKK7CuDt9E0GgOiJBNX49dD7ffHCmWvaWPrCIrWBXXURb5+jakqzhZpZ7JWHA8ZOxYqh6L
	AZV9qXuay9+N+DCafnRToIP8/ETjKLMXK3NGd2k89qL6GdGm7pivzqA5WGVGD3CLueEJTsliGjKbu
	29dgSjf64eoIagle45BFVs6t8JXwdmfxsKaDI55FAAG/aa6KhVTpILxE9VbwhEHxMm/oV0tsSCsYL
	t5eo4PJA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszz-00000000akE-1g9D;
	Sun, 12 Jan 2025 08:07:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 17/21] slub: don't mess with ->d_name
Date: Sun, 12 Jan 2025 08:07:01 +0000
Message-ID: <20250112080705.141166-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112080705.141166-1-viro@zeniv.linux.org.uk>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
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
 mm/slub.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c2151c9fee22..4f006b047552 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7513,10 +7513,7 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 		return -ENOMEM;
 	}
 
-	if (strcmp(filep->f_path.dentry->d_name.name, "alloc_traces") == 0)
-		alloc = TRACK_ALLOC;
-	else
-		alloc = TRACK_FREE;
+	alloc = debugfs_get_aux_num(filep);
 
 	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL)) {
 		bitmap_free(obj_map);
@@ -7572,11 +7569,11 @@ static void debugfs_slab_add(struct kmem_cache *s)
 
 	slab_cache_dir = debugfs_create_dir(s->name, slab_debugfs_root);
 
-	debugfs_create_file("alloc_traces", 0400,
-		slab_cache_dir, s, &slab_debugfs_fops);
+	debugfs_create_file_aux_num("alloc_traces", 0400, slab_cache_dir, s,
+					TRACK_ALLOC, &slab_debugfs_fops);
 
-	debugfs_create_file("free_traces", 0400,
-		slab_cache_dir, s, &slab_debugfs_fops);
+	debugfs_create_file_aux_num("free_traces", 0400, slab_cache_dir, s,
+					TRACK_FREE, &slab_debugfs_fops);
 }
 
 void debugfs_slab_release(struct kmem_cache *s)
-- 
2.39.5


