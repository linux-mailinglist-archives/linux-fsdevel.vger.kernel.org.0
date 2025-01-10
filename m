Return-Path: <linux-fsdevel+bounces-38783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C4A0858B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCC1188B6D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804A206F1D;
	Fri, 10 Jan 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="n7W3mIqv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE5149C50;
	Fri, 10 Jan 2025 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476988; cv=none; b=sSqr1QrYTC9mL/NQVJx4H3RNobwzHzFjHtjZV9QlsY2CUJNYn9HWUEUI/AijJTM/swyqaGaJV/yGLeRmyj8l06oLFC2F3pcBiLKmwMjzKzIjzjpkxaL2IjhjWY6QWHfSnUwbuBTUYm3v9/LIvUg7CiDYR13m4s877Y4ZONx3yAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476988; c=relaxed/simple;
	bh=/+23/NdxjPLdcAKyYWPvhNukDGf5iaCTaLLO1EjgLHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gb4MXX1hGgIl4g7HFzn3vuwOM8HqDMrk3i9oaDl1O9fFmcsjXvN2LaVlzCvWmTH5HEF8r2PjURZNokt47EDJEKs0IRnfqwPhS/TMxLtJAwQJbUfNP0w//lREqRrPdD1TZlRDbO2vNCP72AVV/deNvoQrO62H59ydRIb9MKnjfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=n7W3mIqv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YothkI0qm/ny+i6tgohpDmcCLFOR152J1clRwveDxFk=; b=n7W3mIqvH9FENwHMUbUkXs9b7e
	mgJPo6XHjpX8rQd+QAItxDxXmBvOL4zagODv3prl80Qxo6bNNAbQZ5ImXGOG+gTwlM0nNw7CfpQBH
	JiXKsq03wSMpvYw9FxmwQipZ8fBCQSpZZBG5YAG4f/n6MyFPfMxsBBdC0ODQ8zEO1Ouu3C9wK2TS2
	kq+iGCR2kPe+HXBBDPM0AnSJuk9rK86wXl4CSdiXvswFt3OCG/9HhSJbXLnN3ZASt+7FkdYCC8vhx
	3DjyHbq8q6YgttmqUX4/1wfJS2diuJdCMoYxDUaZ5eRbrTiAelphJLDxS9KmiV6SlFT0FPWuL2aGC
	kvfu8aOw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zH-0000000HRau-2CE5;
	Fri, 10 Jan 2025 02:43:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH 01/20] make sure that DNAME_INLINE_LEN is a multiple of word size
Date: Fri, 10 Jan 2025 02:42:44 +0000
Message-ID: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110023854.GS1977892@ZenIV>
References: <20250110023854.GS1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... calling the number of words DNAME_INLINE_WORDS.

The next step will be to have a structure to hold inline name arrays
(both in dentry and in name_snapshot) and use that to alias the
existing arrays of unsigned char there.  That will allow both
full-structure copies and convenient word-by-word accesses.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 4 +---
 include/linux/dcache.h | 8 +++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b4d5e9e1e43d..ea0f0bea511b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2748,9 +2748,7 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			/*
 			 * Both are internal.
 			 */
-			unsigned int i;
-			BUILD_BUG_ON(!IS_ALIGNED(DNAME_INLINE_LEN, sizeof(long)));
-			for (i = 0; i < DNAME_INLINE_LEN / sizeof(long); i++) {
+			for (int i = 0; i < DNAME_INLINE_WORDS; i++) {
 				swap(((long *) &dentry->d_iname)[i],
 				     ((long *) &target->d_iname)[i]);
 			}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bff956f7b2b9..42dd89beaf4e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -68,15 +68,17 @@ extern const struct qstr dotdot_name;
  * large memory footprint increase).
  */
 #ifdef CONFIG_64BIT
-# define DNAME_INLINE_LEN 40 /* 192 bytes */
+# define DNAME_INLINE_WORDS 5 /* 192 bytes */
 #else
 # ifdef CONFIG_SMP
-#  define DNAME_INLINE_LEN 36 /* 128 bytes */
+#  define DNAME_INLINE_WORDS 9 /* 128 bytes */
 # else
-#  define DNAME_INLINE_LEN 44 /* 128 bytes */
+#  define DNAME_INLINE_WORDS 11 /* 128 bytes */
 # endif
 #endif
 
+#define DNAME_INLINE_LEN (DNAME_INLINE_WORDS*sizeof(unsigned long))
+
 #define d_lock	d_lockref.lock
 
 struct dentry {
-- 
2.39.5


