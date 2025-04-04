Return-Path: <linux-fsdevel+bounces-45716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF13A7B71A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 07:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AE33B84D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 05:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C4B156C63;
	Fri,  4 Apr 2025 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQJF20/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DAE376;
	Fri,  4 Apr 2025 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744229; cv=none; b=VEFTM5tS2YLjhGfOHmLul1YhpBr4FbfqnddJfmTgmm/YFqJLrJOBEbTsv5fZVcZyjlVpWkYYjbTaPbtv/8FCMeTBdijyL/P3BmB8z0ZzpQW9CFN5BdZpH0sHcrxrVN8PvBNWTCukJzFi1Nf4CLqmAa2rt1WTRyExUY4zDkSwrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744229; c=relaxed/simple;
	bh=b/dWOEJUtthRdL0hwa2p3YSPznOZdiGQPXzmsuaR8C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGX5QFUwq/k4yTarT9eGe3LjufG7vTPEO8DM2Tuesm5qkYJsiMrVP/xmk2SQD+A/Drxs8VEkoI5SbFravssaILZWaci+pXjcJAocjQkuWXI/jPtIug57IKMrdidBNAE8cVvaW/oWSMXMhWr9ux38x5tV74t4QOZ7eVzAGPp4nxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQJF20/O; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0618746bso11021145e9.2;
        Thu, 03 Apr 2025 22:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743744226; x=1744349026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=erAv7JoyA1Zu+xnpzHAQheWpjIen+lhF/W4nW1Nuqoo=;
        b=dQJF20/OwL4zefMCo/P7YjpGzoVLoLqs0wXorj0mm7D2PoZydMdUypOUNgQJ3146L8
         Wrabk+rKTFTIU40qP5ESnRwjVp/coJIOetecnSCl1RjDyV3TQWcbXq2qab5H0HX2bYge
         teQDEFrMBRJTeBfMyvc6S6qBSOrLjI0ZthqhbysHVygGPXVJCsmM2Gq6Z+u6RhmZ6RaZ
         qSo1xC2WdmGFAnqudGPE84aTCKRBFLZ7Zj0Oswtrt8bXADGhs48BZuQ7zd6DtYSqkQaQ
         T/OclCOA6cHjWr2uxpuySHJCoYwpqRX8lSL3k9nRFOCQPIywlLm4p3OcDm6nVtcwGjjd
         9Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743744226; x=1744349026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erAv7JoyA1Zu+xnpzHAQheWpjIen+lhF/W4nW1Nuqoo=;
        b=Q7aY4hRmYA3tA0FOOwDai7zfywoik2VnRDodmu4cDwloBOOdTkJz3jjnQ5cRBRec7p
         WJwIIXzgFMm+9x0R0ObbtBzLjLweXlvlXJa8cbZf+AEH1C0yoyxAPyNj4vQLZbQtfHkh
         Wp9M4NUFJXFDAXZvKZ7DAaLr0tsa7bj3ayc29QpHiQ8FG0ZlIa+S4Cq/M9yzjpiBvqp8
         lH8s6vDGmksB4a2nBp1e/Ck8oyVnV/wVLMGOmkqmTglRgA3ninBlPSICluIHo4/gADvb
         IHgbeV2wmrxcgDEbykWYeBjW0QCNG7IHngYPZEZiBMOGlGninaRzawXx2ejGOLo478s6
         kCCw==
X-Forwarded-Encrypted: i=1; AJvYcCUrA4+P9iRV+H8ESRPSxINIV2hXCi5v53gpjgsXrfu0xExnUvGPK48NYpqp1P7OPSROXlkzOZrMFOCP2Zf0@vger.kernel.org, AJvYcCXTHeHvPU3vbH4WdW8TWZbP2kRG0xz1sgpgtq6Sz47GeaKrtu/dYRkpXxiig0gHmK0zMMjn8KUlLaXv5Gm2@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvfqvXDFS4XjrNJ7Wo2wkGccZ5QOimoZl5drflIRfFqttFl+Y
	mZXUTSn+zBvW2ZMH/taB9rhpXMrm8550vHqsK/YSSAs6nlRsaTO+
X-Gm-Gg: ASbGnctbTe0b2mGChG2InEEYsaZWB07BE8rQvTA33t0yPBWd0HKuLlmkUPNjUK8gcwx
	cCoao6LV9wazzpdFEQtjRY2lgPA1fgGR4VzBM7XWRkaKWHuphNO6kwb6ELbhEaDkgUHCPjPy3tI
	JyGJX6MXy6T6jeQBXZgE1/Mlpsu0tlCbfqoz9w6abpjVhWbNtHSj5kxCY1c1rvdxrbIspcr/PXP
	8zFJQQvDL0l1IQ5mSkG+w1pHandyUmfOsSgQIdpbsEyJlI6/zyvlTnrktQDzlxiNPMZjB7E2Xn5
	p1jnBcn40tZkacoud/puto8NUS905NLxCGAK4DyqfmQdWCcuB79b+3qDvU2x
X-Google-Smtp-Source: AGHT+IGDNBBpyCmvjcKuSt6wNZOj4t3YyIiQvnI7ftAolOKe54QSZynC2+DvZKGrBQSROn+H/z4u5A==
X-Received: by 2002:a05:600c:500c:b0:43d:bb9:ad00 with SMTP id 5b1f17b1804b1-43ecf8cf6b2mr16238095e9.15.1743744225648;
        Thu, 03 Apr 2025 22:23:45 -0700 (PDT)
Received: from f.. (cst-prg-6-220.cust.vodafone.cz. [46.135.6.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096cc1sm3415487f8f.5.2025.04.03.22.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 22:23:44 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: remove stale log entries from fs/namei.c
Date: Fri,  4 Apr 2025 07:23:40 +0200
Message-ID: <20250404052340.1371976-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parties interested in learning about development history of the file can
git log on it (on this repo or one of custom imports of pre-git
history).

While here remove a questionable comment about copying pathnames into
the kernel to "reduce some races" and "hopefully speeding things up".
Making an in-kernel copy is not optional.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

an actual submission this time around

 fs/namei.c | 86 +-----------------------------------------------------
 1 file changed, 1 insertion(+), 85 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 360a86ca1f02..6f20ac056540 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5,16 +5,6 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
-/*
- * Some corrections by tytso.
- */
-
-/* [Feb 1997 T. Schoebel-Theuer] Complete rewrite of the pathname
- * lookup logic.
- */
-/* [Feb-Apr 2000, AV] Rewrite to the new namespace architecture.
- */
-
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -44,83 +34,9 @@
 #include "internal.h"
 #include "mount.h"
 
-/* [Feb-1997 T. Schoebel-Theuer]
- * Fundamental changes in the pathname lookup mechanisms (namei)
- * were necessary because of omirr.  The reason is that omirr needs
- * to know the _real_ pathname, not the user-supplied one, in case
- * of symlinks (and also when transname replacements occur).
- *
- * The new code replaces the old recursive symlink resolution with
- * an iterative one (in case of non-nested symlink chains).  It does
- * this with calls to <fs>_follow_link().
- * As a side effect, dir_namei(), _namei() and follow_link() are now 
- * replaced with a single function lookup_dentry() that can handle all 
- * the special cases of the former code.
- *
- * With the new dcache, the pathname is stored at each inode, at least as
- * long as the refcount of the inode is positive.  As a side effect, the
- * size of the dcache depends on the inode cache and thus is dynamic.
- *
- * [29-Apr-1998 C. Scott Ananian] Updated above description of symlink
- * resolution to correspond with current state of the code.
- *
- * Note that the symlink resolution is not *completely* iterative.
- * There is still a significant amount of tail- and mid- recursion in
- * the algorithm.  Also, note that <fs>_readlink() is not used in
- * lookup_dentry(): lookup_dentry() on the result of <fs>_readlink()
- * may return different results than <fs>_follow_link().  Many virtual
- * filesystems (including /proc) exhibit this behavior.
- */
-
-/* [24-Feb-97 T. Schoebel-Theuer] Side effects caused by new implementation:
- * New symlink semantics: when open() is called with flags O_CREAT | O_EXCL
- * and the name already exists in form of a symlink, try to create the new
- * name indicated by the symlink. The old code always complained that the
- * name already exists, due to not following the symlink even if its target
- * is nonexistent.  The new semantics affects also mknod() and link() when
- * the name is a symlink pointing to a non-existent name.
- *
- * I don't know which semantics is the right one, since I have no access
- * to standards. But I found by trial that HP-UX 9.0 has the full "new"
- * semantics implemented, while SunOS 4.1.1 and Solaris (SunOS 5.4) have the
- * "old" one. Personally, I think the new semantics is much more logical.
- * Note that "ln old new" where "new" is a symlink pointing to a non-existing
- * file does succeed in both HP-UX and SunOs, but not in Solaris
- * and in the old Linux semantics.
- */
-
-/* [16-Dec-97 Kevin Buhr] For security reasons, we change some symlink
- * semantics.  See the comments in "open_namei" and "do_link" below.
- *
- * [10-Sep-98 Alan Modra] Another symlink change.
- */
-
-/* [Feb-Apr 2000 AV] Complete rewrite. Rules for symlinks:
- *	inside the path - always follow.
- *	in the last component in creation/removal/renaming - never follow.
- *	if LOOKUP_FOLLOW passed - follow.
- *	if the pathname has trailing slashes - follow.
- *	otherwise - don't follow.
- * (applied in that order).
- *
- * [Jun 2000 AV] Inconsistent behaviour of open() in case if flags==O_CREAT
- * restored for 2.4. This is the last surviving part of old 4.2BSD bug.
- * During the 2.4 we need to fix the userland stuff depending on it -
- * hopefully we will be able to get rid of that wart in 2.5. So far only
- * XEmacs seems to be relying on it...
- */
 /*
- * [Sep 2001 AV] Single-semaphore locking scheme (kudos to David Holland)
- * implemented.  Let's see if raised priority of ->s_vfs_rename_mutex gives
- * any extra contention...
- */
-
-/* In order to reduce some races, while at the same time doing additional
- * checking and hopefully speeding things up, we copy filenames to the
- * kernel data space before using them..
- *
  * POSIX.1 2.4: an empty pathname is invalid (ENOENT).
- * PATH_MAX includes the nul terminator --RR.
+ * PATH_MAX includes the nul terminator.
  */
 
 #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
-- 
2.43.0


