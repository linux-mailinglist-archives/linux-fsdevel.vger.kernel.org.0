Return-Path: <linux-fsdevel+bounces-24997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7E9478F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF91F28171B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7F15351B;
	Mon,  5 Aug 2024 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5rIsN8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3AD13DDC2;
	Mon,  5 Aug 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852126; cv=none; b=cv8JomHa73mJdFImehx+ZkbsKIkrXFdjGZSnvhiDcCjGbTE3jSgXRolzQJDYTcXibqWfDgx/bfpCToS8lIZz3WpPLGT7lj0T/wgk2fGaxGktSvtxDj+q3wPD2yEPWng+frn8xuJHPdI8m2+WIiNgqIZLVF9MLUjJ1anF4xPKcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852126; c=relaxed/simple;
	bh=7BD7JKUmtuZQkLNSY1h5BQNhA5b6G4AJu+qBFSYhCQY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cyT2guwCv5J97BluCaNu9gXwHBWBVgWzRKmYVgoyqbpPJBQtNBXV4R2a2T3v4dXTrZoTHa+X/G5GRSkgSNJcWx9HPrj0R67xbaLhzANffV1PXvCy3gBLTh7ezys+4FhAb4lOAcRdLPhGWkT0giPKKXQvaE6yB+8x6AK+MSpjGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5rIsN8h; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc5296e214so85361665ad.0;
        Mon, 05 Aug 2024 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722852123; x=1723456923; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqYpSdE50pl9XzV3+DNmj/HrcKodDL4KzDAs90g9Vqg=;
        b=J5rIsN8hsWNl0MCqfS3ETAi8kgjh8+mDIWxvSOjh50iT6AV0wYz+J6KjM/3PWnhInt
         Zd4pHR9kblw8eMEITbOA8v1AeZ2kAGLsKvjtuBrDByPJcMbQm0rMVtYoP/HyIvaPUAnw
         jA3h5MvUmgV/tf4cAZcwI+42FyLObXo/rk3EpMfsJH8A+Cvv6hn9aEgIKnbSzEcCC99t
         2kIFQIUcIoYSdEG6c9YCHscHbKIUxOXT2zdOJNek19z0iajOW2zoLUKSHsSnUPG8us8l
         UYl9DpKPez91OqMF2GepIj9RHVIEKmBWU9rfYkBLH9fbxvZ2Vu89RWkEHrNsgl/UppB8
         nJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852123; x=1723456923;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqYpSdE50pl9XzV3+DNmj/HrcKodDL4KzDAs90g9Vqg=;
        b=f2+AGbOJYZFQg1AaQ1dxf37jc8gVzi9rWmQT0njYoU+/njMgNNgimAfKwQiSvxA0k4
         52kMygeNpzXGnuIqJRJ9jFmwGv8pETNt22okWWABhpk2YCDYovYozc/RIVBtZI98Sr7u
         NDLJguhiQ6G+w22+DXh7xrG0uWAbV/5PrRb0hF7IvklxmuonUpY9A6NGp2RwA6nWVxih
         Wp5JauzVJI+ZAhavqCxJGk2MCNzi7AEahbK2S+uP+ZSO9Vd7FtlCbhNzaRDA87/Sq78d
         GyggaE7q7HzjkewdkifvjwBw96TPectUbAgMl+fSvRMcHz0yH1u6dn3EwHABZby+vtDi
         9Z+g==
X-Forwarded-Encrypted: i=1; AJvYcCUUIQ2/wCXvrMQOS7hV39TY4jxEdOlmlp+SLiZwIiYzoKBG0W+Yo85GxC79ADLoTWdSUPEBGyfOg/hqGLhvcwGNINUdghAGwvo/fjj7xwHIcEsY34xHcpp2af2AVwZUxpwre5c8vqkgEDRE5w==
X-Gm-Message-State: AOJu0YyuZS3b9D6iAt+30k3qNH/igZ9su2uspnuvRbQyJ2z4e5KzLAVZ
	Q0bvNkneMZ+rQULxUsv2dNDGmxKHexyt2rZiHKBN3/64hee0u1So
X-Google-Smtp-Source: AGHT+IElKztUQ6gzFBTWFrbmuzZnWW/UvqeHzlqMr1XZuSHhH+xjVYflrzhFDofbtAyKex86jRowaQ==
X-Received: by 2002:a17:902:f213:b0:1fa:ff88:891a with SMTP id d9443c01a7336-1ff5744b232mr108679155ad.48.1722852123238;
        Mon, 05 Aug 2024 03:02:03 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff592b7d3bsm63330525ad.302.2024.08.05.03.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:02:02 -0700 (PDT)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <levinsasha928@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maple-tree@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] lib/htree: Modified Documentation/core-api/htree.rst
Date: Mon,  5 Aug 2024 19:01:49 +0900
Message-Id: <20240805100149.14445-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Implementation of new Hash Tree [PATCH v2]
------------------------------------------
Added description of locking interface

full source:
------------
https://github.com/kernel-bz/htree.git

Manual(PDF):
------------
https://github.com/kernel-bz/htree/blob/main/docs/htree-20240802.pdf

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 Documentation/core-api/htree.rst | 56 +++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/Documentation/core-api/htree.rst b/Documentation/core-api/htree.rst
index 78073b413779..186b4c29587f 100644
--- a/Documentation/core-api/htree.rst
+++ b/Documentation/core-api/htree.rst
@@ -85,27 +85,51 @@ Hash Tree Summary (include/linux/htree.h)
 Hash Tree API flow (lib/htree.c, lib/htree-test.c)
 -----------------------------------------------------------------------------
 
-*hts = ht_hts_alloc()           /* alloc hts */
-ht_hts_clear_init(hts, ...)	/* max nr, type(32/64bits), sort(ASC, DES) */
-*htree = ht_table_alloc(hts)    /* alloc first(depth:0) htree */
+DEFINE_HTREE_ROOT(ht_root);     /* define htree_root */
+
+*hts = ht_hts_alloc();          /* alloc hts */
+
+ht_hts_clear_init(hts, ...);    /* max nr, type(32/64bits), sort(ASC, DES) */
+
+htree_root_alloc(hts, &ht_root);/* alloc first(root) hash tree */
 
 run_loop() {
-	*udata = _data_alloc(index)             /* alloc udata */
-	ht_insert(hts, htree, udata->hdata, ..)	/* working data with index */
-	ht_erase(hts, htree, index)
-	hdata = ht_find(hts, htree, index)
-	hdata = ht_most_index(hts, htree)	/* smallest, largest index */
-	ht_statis(hts, htree, ...)		/* statistic */
+        *udata = _data_alloc(index);    /* alloc udata */
+
+        /* working data with index */
+        ht_insert_lock(hts, &ht_root, udata->hdata, ..);
+        ht_erase_lock(hts, &ht_root, index);
+        hdata = ht_find(hts, ht_root.ht_first, index);
+
+        /* smallest, largest index */
+        hdata = ht_most_index(hts, ht_root.ht_first);
+
+        /* statistic */
+        ht_statis(hts, ht_root.ht_first, ...);
 }
 
-htree_erase_all(hts, htree)     /* remove all udata */
-ht_destroy(hts, htree)          /* remove all htree */
-kfree(hts)                      /* remove hts */
+htree_erase_all_lock(hts, &ht_root);    /* remove all udata */
+ht_destroy_lock(hts, &ht_root);         /* remove all htree */
+kfree(hts)                              /* remove hts */
 
 -----------------------------------------------------------------------------
-Please refer to the attached PDF for more detailed information.
+Build (Compile)
 -----------------------------------------------------------------------------
-documents(PDF):
-	https://github.com/kernel-bz/htree/tree/main/docs/htree=20240802.pdf
+lib/Kconfig.debug
 
-Thanks.
++config HTREE_TEST
++       tristate "Hash Tree test"
++       depends on DEBUG_KERNEL
++       help
++         A performance testing of the hash tree library.
++
+
+lib/Makefile
+
++	lib-y += htree.o
++	obj-$(CONFIG_HTREE_TEST) += htree-test.o
+
+-----------------------------------------------------------------------------
+Please refer to the attached PDF for more detailed information:
+https://github.com/kernel-bz/htree/blob/main/docs/htree-20240802.pdf
+-----------------------------------------------------------------------------
-- 
2.17.1


