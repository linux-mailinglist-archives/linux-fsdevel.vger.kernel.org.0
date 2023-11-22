Return-Path: <linux-fsdevel+bounces-3486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3FF7F524A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB691C20BC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA041CF8C;
	Wed, 22 Nov 2023 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCX1z6jI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED571703;
	Wed, 22 Nov 2023 13:12:32 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso204290b3a.0;
        Wed, 22 Nov 2023 13:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687552; x=1701292352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vndFmtwoNBfvOSHr5hNiC5ndKtGe9ea3Be2dCt86/rY=;
        b=TCX1z6jIkLlsoLVCH5SmYQhGEaYyrHjOOP2C7HxFhIwnNfD9Bvxw074Ujx4VEZp2S+
         tzw2iO3/4lI9kEWyRPQbO7V39EIBawKUCTBrgXLfem3i5Zqi1f2jWft/p+mKKkuYBVP9
         3xg0QYbN3+XUmo2ENp2hH1/iXuaChTz7lMLSg4U56TN3p/5YgaMObtY1TTQXQUhfGOA8
         ei5FGMF0L/jr3g6Fx93jWe7yX8aL3AC1Id0RAe4k8LzS+EX/ndyJ6NzzMRz2bv8CgRjv
         qmFt1vbTLKSW4r9COidZNttv1bM8TOD9tVa5/CweETWP5rIJmHkhTjigxVbp5uREu7l1
         nRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687552; x=1701292352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vndFmtwoNBfvOSHr5hNiC5ndKtGe9ea3Be2dCt86/rY=;
        b=vYV+xS8OP2IeX/mBpG4GKhHL5PY5sFrbDerHxIhIjsi3y97KG3iDqy4wTa7iOnQVPY
         C9p0jK8cgS7S2HWou23bl0Tty0qG0GP+EXQjJQQffpEM8/nGuN/vQHigSNVZLzX2pu9w
         Tnw/j1bQJYaS8LfK85UhJhFDel4UdAxhAtBau3pncK20YjYeQ0h8YBg8CcatYndb1xoB
         ah+jdJ5Xo5cZx2JFSbA+fOLaaGfEej6v+aTq922jpFMqe5ZD1KXh8PwsdyYOIE8xl/oZ
         2CAEtMSduycYKjNL5YzIqpSGp6Yxe2Jnbh4pUxjjiDGkGpfJV5lQTCzrCkbb9Zm2CQqX
         ZNDQ==
X-Gm-Message-State: AOJu0Yxv1Ryqfg2T129FBekcYf8WHnIoFx7Ndkx429gYvQ813ZBvuGAz
	LqOjZFg77iBkh4oM57T54w==
X-Google-Smtp-Source: AGHT+IFbCsnwOzk3NV6X56jO78VOMP+TCUq5eJCWYi9iESvIVcb1EX5hhADLjZtOWBoP1ANbQ+1PSw==
X-Received: by 2002:a05:6a00:2d94:b0:6c4:d615:2169 with SMTP id fb20-20020a056a002d9400b006c4d6152169mr1127761pfb.10.1700687552189;
        Wed, 22 Nov 2023 13:12:32 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:31 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 09/11] mm/mempolicy: build mpol_parse_str unconditionally
Date: Wed, 22 Nov 2023 16:11:58 -0500
Message-Id: <20231122211200.31620-10-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpol_parse_str is conditioned on CONFIG_TMPFS.  We intend to reuse
this interface for procfs/mempolicy, so build unconditionally.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h | 4 ----
 mm/mempolicy.c            | 2 --
 2 files changed, 6 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index b951e96a53ce..1adbcc10f291 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -158,9 +158,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 		     const nodemask_t *to, int flags);
 
 
-#ifdef CONFIG_TMPFS
 extern int mpol_parse_str(char *str, struct mempolicy **mpol);
-#endif
 
 extern void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol);
 
@@ -276,12 +274,10 @@ static inline void check_highest_zone(int k)
 {
 }
 
-#ifdef CONFIG_TMPFS
 static inline int mpol_parse_str(char *str, struct mempolicy **mpol)
 {
 	return 1;	/* error */
 }
-#endif
 
 static inline int mpol_misplaced(struct folio *folio,
 				 struct vm_area_struct *vma,
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e0c9127571dd..a418af0a1359 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3115,7 +3115,6 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
-#ifdef CONFIG_TMPFS
 /**
  * mpol_parse_str - parse string to mempolicy, for tmpfs mpol mount option.
  * @str:  string containing mempolicy to parse
@@ -3248,7 +3247,6 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		*mpol = new;
 	return err;
 }
-#endif /* CONFIG_TMPFS */
 
 /**
  * mpol_to_str - format a mempolicy structure for printing
-- 
2.39.1


