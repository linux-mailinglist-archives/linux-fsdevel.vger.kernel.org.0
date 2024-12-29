Return-Path: <linux-fsdevel+bounces-38229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35719FDDF9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473EB3A1692
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD733062;
	Sun, 29 Dec 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ti1OwuGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5454740
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459949; cv=none; b=CBlguyfwyuw+/IasYawzbKS6NKK+mo3UnuvN+6LsBMYzmQRouXSKOyyKqvL9drimIhoHZw+rK0LH1rQOYKNhACujRsPJDk8qIZBExWCB52afB++AE72GI/6pB0Rzuxb8BB1kg1k66K50+qzQAL4rwgb0q0udcz8n0mq0gZxKUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459949; c=relaxed/simple;
	bh=CyRscPQ+JqS39wJ/rbHekCJ5IcGNMw//iYJkpDOpE9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lg3DFkJlWOBErKNFucCQfN6gl5chbOPgt7Qq910oEz9aHvtxxEPtyRZehjWEQgoMCNsLK/s4JZrVFsQ882snDemyyMuQQVR0NULUwBMFEyNe5bksMZUfyqxpGiNKdZBBV630bI4Kvyltu54cl4BW+VYT4+co104Iip+enIE57qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ti1OwuGI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qf5TAAhkW5LD0bVX6MGG2xxw06KJdOFvtPuRfP0r7QU=; b=ti1OwuGITa6Dpwbc8oy0rkHPhB
	pXlDwiEthIjJh5RQKBl/9u3dAwYdqcSNswLfx3AiNGRyUk7ic7lZHszWYLn9FE/s8iOX8gGQGrhm4
	iEAcTYLqPj+M6NUyZjeFSNueulVkfN+i2TwkiGVlD7KTuXKkv6VpOHI0CUngXPh7fDGhkbKI2Or42
	MNjIoH1uui7ROGclaP/aQbFCRPcOGem2IuIRhu3uRCntJeqbVer7unEgsPSrd1Kdyp8jZBK+I/DYr
	Zr4xK19IvZe9i+53a7YS9tnnDuEg2TIGDdufAzqMyrVMB384lyG6G1Du1hH8GlL+TnTfFvHUsVBgn
	cW1GnV2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPR-0000000DOj9-2Be6;
	Sun, 29 Dec 2024 08:12:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 17/20] slub: don't mess with ->d_name
Date: Sun, 29 Dec 2024 08:12:20 +0000
Message-ID: <20241229081223.3193228-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
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


