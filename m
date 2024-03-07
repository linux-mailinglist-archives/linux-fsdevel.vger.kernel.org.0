Return-Path: <linux-fsdevel+bounces-13861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2D874CDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5168283324
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF2127B4D;
	Thu,  7 Mar 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ox1MH+NB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247421E52A
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809346; cv=none; b=EnbMW4I1FHT9c/Hv7rKfqpeA1/0oP+gGyNjqNYRI+Qniw21yyJaHPIcRnZTyVxlRTcZ+yqsJAKmG97hyMaAn9XzxUhxlfZFbX3JAjNUPVB14UpwBhC2J4Pz/S4BJOrjs6IsAGk57N45xDsrhGVUGX5yPx/YDIWz092WUrrYAFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809346; c=relaxed/simple;
	bh=jE66qC+TUWnSOohnYVQvtZUZfYDRxM0Jl4e3DWdEllM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNlwkw8d0dJjfb79mCLeL/sgW3woGpRSJiL/XXvo1Ru0ncWRZlgC2ZwJZGXJ3+zxsLRmekMPEAJaTH1d5davSD7jrGTKqwddQiTimb76oMxmuhzXvMJWVIzPJylsnKjSkojshybq1iutjdH5E9e91HVFJglHcty5TQQkdA43jUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ox1MH+NB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709809343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ELPJMiYv8En8P/hVP2pnkUG9L7naxhl47oaBUoUc8N4=;
	b=Ox1MH+NBCkBMXe3moKyy+e4XVyMyWZKqTJjYtTwF2DEi09/aC9Lu3GZN9G1lRlzeqCQgQL
	/MBLVr3PTKfafnaLFFZ34zfd1pLU5dHmDNlUoRXpErvWOwGgJrxoowLdrgcWoaYnsfDVYo
	y4QDx3wrSzxgvAcIDFvMjLLo3TyzKRM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-71cghha1O7-qhqOVLwQo3A-1; Thu, 07 Mar 2024 06:02:22 -0500
X-MC-Unique: 71cghha1O7-qhqOVLwQo3A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412c7ee0c97so5630735e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 03:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809340; x=1710414140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELPJMiYv8En8P/hVP2pnkUG9L7naxhl47oaBUoUc8N4=;
        b=BQqHXhT0pcu9KENLD6uyYaZndHugEfCRBTC3EtJ7Xo5StuerWRRo6TQkMRux/h28UU
         Yuc0q8B2sNoVOKhl4fTq+vD0oLgaflfoYU9qbT7S7OP8S8JOorsYazmE8tZrkTbwLi6m
         vYi2lgRmvRJwmmOMXG8n7k/h2aBvJK5xzx8jGmkVmdCF5xngAU+cZAb/GlPscxiG01oG
         Xb/1YYNSe0lcw0hin4uliCjrWwLVJLzV7839sTpmo59Ab03WzubCqtb+YDAYwsy0ELMv
         EFOJpliK/fbXTOdz4ujStVM167xgy1eBR5xGTKltZ3VeCI+wfI08l/E2b+60QH+eNIrN
         CT0A==
X-Forwarded-Encrypted: i=1; AJvYcCUyuhc9nm/TSwgNg6mEJwy7KaLY9Ne9tePAavnmPZJVJZrA0kle5bu5xEhUtpQvnhBSs/k9I/0k/EYs4I7VLTXAXrU054pOHu/l9VUfXA==
X-Gm-Message-State: AOJu0YwLM1p40KwTmNEPLMuhWufam+wK8gjqUc//nxKcLVoD4iohGPe0
	8pEtG0xpJvF+5xfelsLsVMFGpEXSGDnhFdFXwfe9f3FefrfmwtKKFC438YdFxh+ua360N6Vm6Ps
	brCK1sZVMkR0bW6XbmxXX7K2Mz/loq4vYK+Or5qT/DMhnwTYF6nR0DOCB8rjUV2aScryBtzE=
X-Received: by 2002:a05:600c:1f81:b0:412:f137:742c with SMTP id je1-20020a05600c1f8100b00412f137742cmr4394694wmb.11.1709809339934;
        Thu, 07 Mar 2024 03:02:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe1d8+nfkjL4Efs0DeINLBOca9eRGr2NKryJc0D80b+BhRb40CSjNoJpuozSHJfokn/lM32Q==
X-Received: by 2002:a05:600c:1f81:b0:412:f137:742c with SMTP id je1-20020a05600c1f8100b00412f137742cmr4394667wmb.11.1709809339486;
        Thu, 07 Mar 2024 03:02:19 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (92-249-208-180.pool.digikabel.hu. [92.249.208.180])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b00412b4dca795sm2332625wmo.7.2024.03.07.03.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:02:18 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] ovl: use refcount_t in readdir
Date: Thu,  7 Mar 2024 12:02:05 +0100
Message-ID: <20240307110217.203064-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At this point this is just a cleanup, since the refcount is also protected
by overlayfs inode lock.

This will change in a following patch.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/readdir.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 0ca8af060b0c..b894a97f8ef8 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/cred.h>
 #include <linux/ratelimit.h>
+#include <linux/refcount.h>
 #include "overlayfs.h"
 
 struct ovl_cache_entry {
@@ -30,7 +31,7 @@ struct ovl_cache_entry {
 };
 
 struct ovl_dir_cache {
-	long refcount;
+	refcount_t refcount;
 	u64 version;
 	struct list_head entries;
 	struct rb_root root;
@@ -243,9 +244,7 @@ static void ovl_cache_put(struct ovl_dir_file *od, struct inode *inode)
 {
 	struct ovl_dir_cache *cache = od->cache;
 
-	WARN_ON(cache->refcount <= 0);
-	cache->refcount--;
-	if (!cache->refcount) {
+	if (refcount_dec_and_test(&cache->refcount)) {
 		if (ovl_dir_cache(inode) == cache)
 			ovl_set_dir_cache(inode, NULL);
 
@@ -405,8 +404,7 @@ static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 
 	cache = ovl_dir_cache(inode);
 	if (cache && ovl_inode_version_get(inode) == cache->version) {
-		WARN_ON(!cache->refcount);
-		cache->refcount++;
+		refcount_inc(&cache->refcount);
 		return cache;
 	}
 	ovl_set_dir_cache(d_inode(dentry), NULL);
@@ -415,7 +413,7 @@ static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 	if (!cache)
 		return ERR_PTR(-ENOMEM);
 
-	cache->refcount = 1;
+	refcount_set(&cache->refcount, 1);
 	INIT_LIST_HEAD(&cache->entries);
 	cache->root = RB_ROOT;
 
-- 
2.44.0


