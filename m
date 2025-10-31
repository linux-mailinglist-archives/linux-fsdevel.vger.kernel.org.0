Return-Path: <linux-fsdevel+bounces-66617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AEDC266E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 18:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A00188D5CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43345309EE7;
	Fri, 31 Oct 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF9uIm7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52DD306B0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932562; cv=none; b=P+TBdNGdaNmAuiZU3cLP2sqMnMB0QIWBaoEtH6kXWbnfSl9V3FZODrKFNgp3+x0bLUdVWlOagq+c9dJa5OddyQhLJsRNZq+9Eb9Z8wuh7bnXlscFLNdHZ2S7oS8Og70q8E/Haz9xh+91lY6M6m4s45Oh3nn/9h1gTXOTF+43Hbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932562; c=relaxed/simple;
	bh=Vi1AK7tDXHNu8+6GtOYCB2t8PHiERIYxjsDeSZzFi74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOztZHLLx9jsMLmJS8K7qeZJfvMNK6XlinVbuRG/FpVVuw448bhvITFWsGGQCh8VvGkWdpSsIFT8U5wxIk/NagfcJytcPfUGoC7m74Wnlct2J0wnvccL0jeExXtW8EqOtfkZc4HEErvAH1JADthL2Hnngva2zr2zYS72d8MM8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF9uIm7E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso22399975e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932559; x=1762537359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UIJC3NBM2UMTqk3PoOY9/nc0pjUoYvTCpDCDkdmqZY=;
        b=FF9uIm7Exou+2N+0e6oUKT2+SbjNAFwYdQud0Kh1eGQm+XgEkQcMuoKI1GaqUPBGyv
         ziBxWld/spuW4Jdm2VN48+6iKdL6xsY6u+QjZQ1FignyeNyVFV3wJojvInDe3XEzH1A7
         Uo6mXVs/hapkYK5yR4gcId3Rr/Ep7nPR07r1dWbSj9xErw6yOpDnh3MpD9hMAB+EToCF
         Sv+LccIEy7CmmNJs16GST6JTB7Z5EGdlLsX0z9NbtVXsLgQ8yR8dNCElukaDww+AjdwR
         FLLzbTVvJUYis/9X00l6zuE6Yneyi+V7aalio+TzfNVoB/7CsAq4kVh5RzVY1HRvlIx/
         boGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932559; x=1762537359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UIJC3NBM2UMTqk3PoOY9/nc0pjUoYvTCpDCDkdmqZY=;
        b=Ms5o8neqV+3x9aOiYdV27HZXNqHsobNY0NNyupe9IUAmd40Voe24H++XDO+EHO64vy
         cZkkkyL+L2TFRY/XLLx+xUHRxdY03ZMOu0b1ossz0UV2uT1S6K3GGjXvWRBU8Twno14f
         8X1k5YGTp3uVY1xYqT0Di2XiG4SZBInNlfDgxu80Iu/t3D1KhmekLnsj//T38tQZt34S
         OCN9V6csQFYhZUSnIKVEFZdUSyCRE6/4pOEIM5NJSB/HYO4A6CnUBovi6N5vA2nFQBgZ
         SoIQ8o7cHYe9qI4jet0pKLBM/0FKI7bxM2lB9fTdeLpzJ9snvieQDb8pWvGGlPO5Ted+
         Im8g==
X-Forwarded-Encrypted: i=1; AJvYcCVymOGM+PNp1lysj6BS1yYL+2clBCngEEhoJDmuxI2HVK6whd8Z5s7AohDv1xn1NEOSWnb3eNOQz90+o4+9@vger.kernel.org
X-Gm-Message-State: AOJu0YyDn5yY0G53iUqvu0nLRT2q6urVA5McRO1nFvc+jRAn8ojjO9VS
	g/hz2PiVbXbIsatg50w0QmS23wcsO3WmTCEZo+Yiq2W1s6b+vfen/gwt
X-Gm-Gg: ASbGncur3sVXc9qgVbdN3BUbrhIPfxOP0/2za5pFom4+R3YGjpPZHz0jkwDGWhT8RGu
	MCbDNChg4d0W9Tp+HFOXfHwQ2QeilMrCI+dwMg4cvW+9JM0H/4wE26kQQNN+XSWmhbcqSqnbNu/
	qdQl3wGRGbdanoSjRegQZpm7MTJM7QnbDNNahSCRNTuPkHn7ud32kR56x7JGkoB1Usu15d8CAE9
	XG/9Mder6HVExpo357347FENIWju50NWSJGHskxlBje5VoeMRH+6F5QWbhujSIRL282cZxTGqNw
	ZpY/gb/5A6jqQ3MzEGq139dEiTS7t6wIxxcDzkcgLTXk75gxxVzgM+zSd6aswe4plgpACmxIBED
	KB4Cqjc5v7pu8L/hxiUWJjnrX9Am+L8ykY8RX28TNfRHxdNezs9j1mW7cN9paVCkc8bhduFAnIl
	HzaJEvL5nXtwt9Xn9t0Qw/bfJjoW/kX2cqfBZlZdYOfJciFcNA9oiTwBxhwwFBZt1Ivl93uw==
X-Google-Smtp-Source: AGHT+IHibtVJIWc/K0mBwQe+U2KmBQDQucGno7lWKNr4elHe+BJ6Gz1X/k6uEZugfHrHL+Io8kpDnw==
X-Received: by 2002:a05:600c:8b30:b0:471:15df:9fc7 with SMTP id 5b1f17b1804b1-4773086d57cmr36912715e9.26.1761932558871;
        Fri, 31 Oct 2025 10:42:38 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53eafbsm6728865e9.12.2025.10.31.10.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:42:38 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 3/3] fs: hide names_cachep behind runtime access machinery
Date: Fri, 31 Oct 2025 18:42:20 +0100
Message-ID: <20251031174220.43458-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031174220.43458-1-mjguzik@gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The var is used twice for every path lookup, while the cache is
initialized early and stays valid for the duration.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c                       |  1 +
 include/asm-generic/vmlinux.lds.h |  3 ++-
 include/linux/fs.h                | 17 +++++++++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index de3e4e9777ea..1afef6cf16b7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3259,6 +3259,7 @@ void __init vfs_caches_init(void)
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
index 947d7958eb72..bf0606ace221 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -50,6 +50,10 @@
 #include <linux/unicode.h>
 
 #include <asm/byteorder.h>
+#ifndef MODULE
+#include <asm/runtime-const-accessors.h>
+#endif
+
 #include <uapi/linux/fs.h>
 
 struct backing_dev_info;
@@ -3044,8 +3048,17 @@ extern void __init vfs_caches_init(void);
 
 extern struct kmem_cache *names_cachep;
 
-#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
-#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
+/*
+ * XXX The runtime_const machinery does not support modules at the moment.
+ */
+#ifdef MODULE
+#define __names_cachep_accessor		names_cachep
+#else
+#define __names_cachep_accessor		runtime_const_ptr(names_cachep)
+#endif
+
+#define __getname()		kmem_cache_alloc(__names_cachep_accessor, GFP_KERNEL)
+#define __putname(name)		kmem_cache_free(__names_cachep_accessor, (void *)(name))
 
 extern struct super_block *blockdev_superblock;
 static inline bool sb_is_blkdev_sb(struct super_block *sb)
-- 
2.34.1


