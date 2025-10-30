Return-Path: <linux-fsdevel+bounces-66437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C805FC1F2A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD303A4B3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A78F33B6E7;
	Thu, 30 Oct 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpfrmsiV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7C30E84B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814808; cv=none; b=GZtwMNC8ndb/eP++QPLk3tb+0W8/mhd0WVBHh62JQ53xdWHgQAF9WoRR/EmJsrAqw9J9hHWxWIPKI0wPfcxxlAIn0dkDhFtOYUV3clVQLwTzeRA4JiF4BguBhfdCB3oqCdIsLt/FxwKkWEc4lZo9RBFgyRW7Xi38DL6Ttf7LueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814808; c=relaxed/simple;
	bh=L4OqF4veqjJRfD75vtvwH0IaU1PIwn/jrpz4y/4KfdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qTZR+ycs1RvCCXp9SWrtDLXtX4K1JvFFfWQordL8tGiZgveSJWzKQteEOflg7OdIT5hNh935ebn3QggJLCGyB17Hs8pB6VS6myVGjM9stDwkTpkHaXxom5xLiNjirVtWNfOaejgbzmWfxllVWqq6ECsQMlMilY7m03O9xf8fVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpfrmsiV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so183279366b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761814805; x=1762419605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0+8fO05/PuCO9OoMUOz5f65CPRV2XshMkV8o8v782M=;
        b=ZpfrmsiVYEZe/B8rJhOqd6EVay/zlhXos4vc6N6XM2sSSvHpCI2B019oyZTRY8TkNx
         m1F65vzXxyPPKkNn6eUUKljL68qFSubXliQ7WmiJZG9MgVmW1onJPxijZG1wbDiTCG42
         Q5A0no7rh3Qmxyh1t8alY5z2Dh27Pu8tSKl6qrUxIgmm6/TAu2dyvWeG6apm71vO4vZ5
         Ympj0/k74JSRqXIRbtZSOc19qs9UVlCmd8G0lSVag7oZjHYGIh6n4rp/R9NXhPhZKo56
         kwkoKab/F8FrQF/Jm1/uzksbcE5fBiwW5PZParfh+bYLOTHK64aad2l6qcqtrkPbrvxR
         obZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814805; x=1762419605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0+8fO05/PuCO9OoMUOz5f65CPRV2XshMkV8o8v782M=;
        b=Z4gTuHnjLwwC9YiSBzuSizYB8pH5WgbvF+mRkIXQLlxWdliH9rjR0JGtSjk1CnNAKr
         j0mzd+BrQ3/DLW+7wP77CeMMKd1Ig3RRN6WYS8aB2ldgB/lb19HU5KzKI2pWVFzlviEn
         W2MHkcKDYBTs7qEBneGaOPl4EfaZwVD9yS9ECu2E/B9XgvPYlg6n9XxaDOMhCRh7Wd3c
         6QpcneQd/wAuV/QWaCf/ffMgPki49Oa9ekbicl7iqfAWtBhc9xudkkVijUy0BDkgxDt6
         W0vG2x/wfGzBysmWdaf4c43z2VOFJ/3oS0RMUAjY0Crlxjgz4ycktBqgRLE5IWT8ojeO
         lvUg==
X-Forwarded-Encrypted: i=1; AJvYcCW8tI5XH5dlxnX6untULkqqfqUpyEZFMZocvrq44xhI4mCGsSgH5vLcOxI/3yiSrijrY2qA1QjH/jjniDkJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLK8+avPTkibKMpq3RPZM0YdsDSsJGpZzjy0YK5ZSSHel9IwU
	Lm5a9xxGiW85Uf7Q7DBnnFa2yx8hSY8IGXcSEHkUa+5ueJ+r6kucIfzH
X-Gm-Gg: ASbGncu7cvj88sVxqXeXLGkiv0HOq7BXiz15ikCM3QBqwI3IDjUVQSV5aEUFZ+LMVgM
	GajumozQlLmIvAn3zfNpitgo+U+R5EA+kB6jGdml6+NvjKXwC2XNyo8cd182qhEfZ2nsyJhCbJs
	Nh0SFoyAXV3BcMVFB01h2RLBELpsLA8Gi/pdosi/jvwQ5Kv9FTW84D8xWrm0BZIEhwzjWwRhJsH
	Ta2c1C6OP/QaO09358miFHGLMmu+Lu7tQdBtALB7028i/7YKGkfpVnQTeSIQeL9d/8oyqAdPldY
	ptMwxJgJY/y9gncxm9syQD5/y8OA4SnQQtKFQXnTf5AtkIN8MOuN8Ti5pthhBcZvj4VU6lQk27q
	epjZZUNPHynoL3neJ68vctFxDb8iQ+mAiNECxQWIcUrqLRO4LN5gJWBA34krQA6BCRQ3ECfiTcG
	iZ70Z9Z2wHNtmxfRHYt5/S9S/WDCAB03T9ON24e4DHOIsgjKxF
X-Google-Smtp-Source: AGHT+IETnbn5ZI7bAOkJG2PqIFf3VbumGaZSxqD4BZrdpxfKUgB6mVZK6e1kKPBpYaEUFcyabzCN/w==
X-Received: by 2002:a17:907:7211:b0:b40:6e13:1a7f with SMTP id a640c23a62f3a-b703d38ca50mr669744566b.27.1761814804969;
        Thu, 30 Oct 2025 02:00:04 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d854430dbsm1676234666b.63.2025.10.30.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:00:04 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: hide names_cachep behind runtime access machinery
Date: Thu, 30 Oct 2025 09:59:45 +0100
Message-ID: <20251030085949.787504-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The var is used twice for every path lookup, while the cache is
initialized early and stays valid for the duration.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

ACHTUNG WARNING POZOR UWAGA Блять: I did some testing and ifdef MODULE
seems to work, but perhaps someone with build-fu could chime in? I
verified with a hello world module that this fine, but maybe I missed a
case.

v2:
- ifdef on module usage -- the runtime thing does *not* work with modules
- patch up the section warn, thanks to Pedro for spotting what's up with
  the problem

Linus cc'ed as he added the runtime thing + dcache usage in the first place.

The machinery does not support kernel modules and I have no interest in
spending time to extend it.

I tried to add a compilation time warn should someone compile a module
with it, but there is no shared header so I decided to forego doing it.

Should someone(tm) make this work for modules I'm not going to protest.

Absent that, vast majority of actual usage is coming from core kernel,
which *is* getting the new treatment and I don't think the ifdef is
particularly nasty.

 fs/dcache.c                       |  1 +
 include/asm-generic/vmlinux.lds.h |  3 ++-
 include/linux/fs.h                | 13 +++++++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 035cccbc9276..786d09798313 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3265,6 +3265,7 @@ void __init vfs_caches_init(void)
 {
 	names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);
+	runtime_const_init(ptr, names_cachep);
 
 	dcache_init();
 	inode_init();
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index dcdbd962abd6..c7d85c80111c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -939,7 +939,8 @@
 
 #define RUNTIME_CONST_VARIABLES						\
 		RUNTIME_CONST(shift, d_hash_shift)			\
-		RUNTIME_CONST(ptr, dentry_hashtable)
+		RUNTIME_CONST(ptr, dentry_hashtable)			\
+		RUNTIME_CONST(ptr, names_cachep)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 68c4a59ec8fb..1095aff77a89 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2960,8 +2960,17 @@ extern void __init vfs_caches_init(void);
 
 extern struct kmem_cache *names_cachep;
 
-#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
-#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
+/*
+ * XXX The runtime_const machinery does not support modules at the moment.
+ */
+#ifdef MODULE
+#define __names_cachep		names_cachep
+#else
+#define __names_cachep		runtime_const_ptr(names_cachep)
+#endif
+
+#define __getname()		kmem_cache_alloc(__names_cachep, GFP_KERNEL)
+#define __putname(name)		kmem_cache_free(__names_cachep, (void *)(name))
 
 extern struct super_block *blockdev_superblock;
 static inline bool sb_is_blkdev_sb(struct super_block *sb)
-- 
2.34.1


