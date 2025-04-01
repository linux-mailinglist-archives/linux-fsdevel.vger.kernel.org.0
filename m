Return-Path: <linux-fsdevel+bounces-45412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 898CEA773B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 07:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908C17A3DA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 05:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC24D1C6FFB;
	Tue,  1 Apr 2025 05:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFmAKe6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C272111;
	Tue,  1 Apr 2025 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743484160; cv=none; b=PiO7CYwnyvsqvvI3jty3+kRSKxvjoxOIX186EivJaiJILm6/WNDF/If+MzmVfgPXgO7BK1XzqWlA0bt2qwzos8dGtndXiu9eXxxRQMWqgi8Sizbohz8GPmbIxTfDtdCcqP+r5ej09J6FngsF+OjvrJ5djOEj5fOvNUuyx36t4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743484160; c=relaxed/simple;
	bh=EwBGURhgN5l1abr65q54RpzxI5PfH2OdVdXQD/uleg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eyyjvcMxUhXN6LtKQ0auIrDVJeBbPy6ybN0B04FHcSV08EUPhlJrNkRl3rjm6KnOp73lacYbxouiQYWe7pkDp5ih5i16io7ltz7Xet5tsg/a7ALL4a5lAuhkMXJqxEOM0iuzj6JKumYS+h9wSF3avLSVkpgQpTiUZ8UoXgkV93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFmAKe6F; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so50442875e9.3;
        Mon, 31 Mar 2025 22:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743484156; x=1744088956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YlTnXiXgnLvzH66jyxciEQPnkqudlw3UyQ0edEOwwAc=;
        b=EFmAKe6FBvVktYomj+azQgHO0SwqGJossMEt1ZMJzeOVNFJrppw+nWbmztMkt5pzvN
         oyg5H1JWaNNeSSVPAtVjIr2hYWdKtLoKVhN+lg/3qLg7/yHafI19Gv3u+D3pA4lxtsYS
         efmAlYp1jelQL+49b5zGQT3qDkjWXmKm8zGpOxfJwqtLmw1zljMJcWLCXg9fGJt5vpq/
         +CBMD8OcrRBex+phLctk965Ywv/97Z5kVhIRKnO6r+wTLzrKDUe9HuxILve9drTdxKt9
         Wp0PF78gYhjhVdSATJGLwxL/lMYnG4bDQWhnUykk6k+M9LwGNdiTG+ol5DHBCL99a1y9
         BWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743484156; x=1744088956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlTnXiXgnLvzH66jyxciEQPnkqudlw3UyQ0edEOwwAc=;
        b=wofg18W4V6cUeCuqE/vjZJ5hJBMfthlvicpZcSFxMTtAWa3TORYcVWtkY1fa6Hlrdi
         wo63lhfI50Aphh3+PuMb1nxjlKKyJIDLYhV9JZFjDoIE9T5osY+mEPXESTn36tCPGfFy
         +/Wn5ohGBh+Rhu3fNUCwGS7A9yh6f+okMiPYPe9W70d16yK9CRfRn5XkeS8XSPcZmpSM
         jXHDlsRchMxW519nB8Qa2Q4uc8tons10sMTn81KMmYz039ayRSg3i+ImxwW8YOuy7XlA
         TNau5ZF294e81Jn22TACBshtumQUFrYpWw8pOIh0xIWzlvpY6blcSWstEHOpVgmB1VmF
         xq/Q==
X-Gm-Message-State: AOJu0YxWKSqNFvnL1OhH3OtfmdX5IdP9sbJGHlGyTZva/2S2raghiNVT
	1JsUAaeIc6H0OXx6jS7/oZ0FUf7a9ElwAXB2Ux5JU3OYpgMxpeYR0iCUrg==
X-Gm-Gg: ASbGncsvzxjFdZe5ka7lYb8CSyqUqZVAtwoPMLGLUlSYd8s2lsZmbnswJKXM0T0x87P
	J5lWcAebDtPCPNqrPC9cISBYe/Y01jJc5SkrgHGIGLAKyPB8CFTSCRSb0VHp2V6y3V+FnFe11pe
	NRxYzYLqhuXmuqKFoxVW1ALcPNifsK/pYIGC0nmVzsI+aXu3dN+8XBU1IbDuZ4wvZOTRudkhH6E
	P8Bvjs+vhUVG8/qoaR2Bc2KE/aWEIhNRb/Ahcku8gAEaaDj2Yc28DTIhone+C9RUZIoOvQRufoZ
	mTlNnMIClJhYLvUMxnavkRNw77PYekqC83qh93nq6IdX9CM1wNbfmdaAjw9W
X-Google-Smtp-Source: AGHT+IGACq3hIRuPpIEbFhNdWy1BLwwW8WJufQ2mSMIdfxqi086MPY0ne0AYfpUTZOIj0JdAjymSrw==
X-Received: by 2002:a05:600c:3d0a:b0:43d:fa59:be38 with SMTP id 5b1f17b1804b1-43dfa59c013mr90026475e9.32.1743484155649;
        Mon, 31 Mar 2025 22:09:15 -0700 (PDT)
Received: from f.. (cst-prg-92-82.cust.vodafone.cz. [46.135.92.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea8d16049sm8540845e9.0.2025.03.31.22.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 22:09:15 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: remove stale log entries from fs/namei.c
Date: Tue,  1 Apr 2025 07:08:46 +0200
Message-ID: <20250401050847.1071675-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 80 +-----------------------------------------------------
 1 file changed, 1 insertion(+), 79 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 360a86ca1f02..b125dadd7100 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5,14 +5,7 @@
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
+/*[Apr 1 2024 Mateusz Guzik] Removed stale log entries.
  */
 
 #include <linux/init.h>
@@ -44,77 +37,6 @@
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
-/*
- * [Sep 2001 AV] Single-semaphore locking scheme (kudos to David Holland)
- * implemented.  Let's see if raised priority of ->s_vfs_rename_mutex gives
- * any extra contention...
- */
-
 /* In order to reduce some races, while at the same time doing additional
  * checking and hopefully speeding things up, we copy filenames to the
  * kernel data space before using them..
-- 
2.43.0


