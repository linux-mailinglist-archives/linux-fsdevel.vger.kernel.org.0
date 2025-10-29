Return-Path: <linux-fsdevel+bounces-66306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A6C1B4AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FF644E8D2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E423FC54;
	Wed, 29 Oct 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm+5stKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27B1C5D46
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746146; cv=none; b=Nz1gz1IPg7qEYGMGda0eTUWx9iDl2jKvvxUKlyQKg9/XQSTsz3A6uHKqJnodD3iclM2AIE/v7/qaTawNSg5tucdp6knoV9m4gdtrH2SinrXl+MvH3+GSO3RFbkpStY7CDJp6TzWajV8BN9qWDzJ3BSZ3qDE00Uz1vQA0mOwzuVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746146; c=relaxed/simple;
	bh=kDjiYYa+XoKtrZgKJjxdI4my5UeWml8agUmpTGGgvQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2wc93sKJkHjX1XASnBHump9zqUutPJskbtCbwqeMUQstU55iiNnHHOtf+IzEU2h9jBfkEEjKWX1UL6b7dQTziYjM+m4s/VNAS+MfsTW8slGxAs4zLAlYpAcxbAyC31CerdeLLfkLiBe98wqZctFGC6z4Il6kPPWxVn2u7xsHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm+5stKC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso6167700a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761746143; x=1762350943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IInKCL3RDPRCGSLvZWACn/czzIIKwfck9D0q9Pkvxck=;
        b=Tm+5stKC4jStX8LWJV6ob8xXcVXT3OPf6isMYwc+r53zVEoP6tEEx37NENs3EPNlRG
         QTumnQYeTXYqo77NjtoKpp7BfffV3mxkynnnpbryh+C7Nax6Gvcm6ACmgfwKZ4RkSR2A
         Pgb0rcUUhj3c4HahEJFvo9MCcAaB38h8fA+a4oDvo/YEV68m8nBeSyTpLKtbreXsIqUD
         2efSH+ttZizbQDxDm1tUnfbf5eVJ4AeC74zB4zngz9EjtNQJk+SVm1NuSJ6IXa/DVKlm
         6oqfpLu69btXiSyj4I2WLDd5tLFp4OSpNxglEYjXBf1iv3f9NIdO5jNl64hjCx+dC55e
         oUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746143; x=1762350943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IInKCL3RDPRCGSLvZWACn/czzIIKwfck9D0q9Pkvxck=;
        b=M0PleWqemSFhxEZh9E+cDoEaKkSRRjuG60XvVjw+jTl9GPerAa/zcnFwyRBLPsjPHy
         iVPJjguIikX7xpVUy9JLX/Ydlk/PA1MYvllDZkPx33kMPCvDZ27Wt5HWDbFBSpYoWxfw
         Q2aj7ypIKZ7p7NpFSw8UVVflHJR8JUk2NOKCdn1rEgHfKXDARf7bz1d8n75Gdu7UmnVE
         D1d4FO/TmIKh3u0iw7P3zQ8PvLyJaHucBgzsRW18B98poo1oYgsqgO8YqjvWH5JjOhJK
         KmV7aLp03bkkEqOfGzIBkNfSFraZqxNg+oJ7Z1LHY+GATD5oxFCP/mhjS5Olzzl9TJWK
         HMGg==
X-Forwarded-Encrypted: i=1; AJvYcCXtDQ8whS8LnfB840PqIeB9W7CgAL+RHDumAtvLKtdh0SWVMChPrIsgvR1KCEYdwqzCugvJaM8honAF+6vK@vger.kernel.org
X-Gm-Message-State: AOJu0YwdCaCa5h+YKm+k1XdTt1CzW7tysFNGnhhUDjpedc2Bp7cME5W5
	j8SY4buyxfgTyFJ3Tw/nDQ0cIKSoQ5Xd5RRZ8kOI8SuCyX1HuWGdG5ah
X-Gm-Gg: ASbGncs/GoHTS0bHiVRJelz6U8jCtU7LXNIWFchTtZSbS7iXpv3+ymMmZqEPlqOUkFD
	+8u5ZuH0v4047o0CNuDRnpCo1QiobOR7DIZKKDp8JJPC9o3OT+sAj7nxCGBovR4DNCqdrgJYVYF
	GYr3Lz76pruT4NWfs7zeugfNf6Pss/iNy4ifohBNnCQJDPbqW78scpeJyHbjL6RN/cO0K5DXCUn
	sKVHOu+Ce0F73CKDsRYxikxEZLtOsORqa5HuIbFz/iezOr9a74wKaVQyum4g+Rnyn177hItiS9l
	N9zB377SoyL2x39e6blo0YsQXK1UZdfNVGXeSw0kBh+3Kj61Icx2mFChAchkGW6cG4hGblJ/fL8
	Vfuhssv6QlPNFuWBO9bRalall60zZrJpzDsX4/6Q1OakPHfTxlvOVVWSGbdTgz6OgmcMlB8KLsO
	fzbXR/EG6cM+++8pC49cAkypTapmiXFKhJYWtLX8h25Jk6Fb5q/KZvGtIJF1Q=
X-Google-Smtp-Source: AGHT+IHGF8rgk9jMOle8qoaOj44dzw/iGjaOwXckf8wSylKdB6FkqWuzCorlot8CB5ukyGmS0ZQuNw==
X-Received: by 2002:a05:6402:2353:b0:63c:3c63:75ed with SMTP id 4fb4d7f45d1cf-6404425113dmr2611515a12.22.1761746143277;
        Wed, 29 Oct 2025 06:55:43 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82b6esm12043982a12.11.2025.10.29.06.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:55:42 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [WIP RFC PATCH] fs: hide names_cachep behind runtime_const machinery
Date: Wed, 29 Oct 2025 14:55:38 +0100
Message-ID: <20251029135538.658951-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All path lookups end up allocating and freeing a buffer. The namei cache
is created and at boot time and remains constant, meaning there is no
reason to spend a cacheline to load the pointer.

I verified this boots on x86-64.

The problem is that when building I get the following:
ld: warning: orphan section `runtime_ptr_names_cachep' from `vmlinux.o' being placed in section `runtime_ptr_names_cachep'

I don't know what's up with that yet, but I will sort it out. Before I
put any effort into it I need to know if the idea looks fine.

---
 fs/dcache.c        | 1 +
 include/linux/fs.h | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 68c4a59ec8fb..08ea27340309 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2960,8 +2960,9 @@ extern void __init vfs_caches_init(void);
 
 extern struct kmem_cache *names_cachep;
 
-#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
-#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
+#define __const_names_cachep	runtime_const_ptr(names_cachep)
+#define __getname()		kmem_cache_alloc(__const_names_cachep, GFP_KERNEL)
+#define __putname(name)		kmem_cache_free(__const_names_cachep, (void *)(name))
 
 extern struct super_block *blockdev_superblock;
 static inline bool sb_is_blkdev_sb(struct super_block *sb)
-- 
2.34.1


