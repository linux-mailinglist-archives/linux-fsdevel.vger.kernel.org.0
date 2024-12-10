Return-Path: <linux-fsdevel+bounces-36881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20959EA5F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 03:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31F4162243
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 02:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EDD1C5CB4;
	Tue, 10 Dec 2024 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="esPZk/8V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216F1A2550;
	Tue, 10 Dec 2024 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798911; cv=none; b=JfA66hFFNXc1raHCxPjipF59EDm1xDHuC7vqYASst4SjezovND0uNw6jZNzRwUtuau74wfEgEeRBwXP/hunyhJT1jyAipHT1ldBTL4YObSOHe+H+i7Zyfq9DaI+uflZtxeiJ+9VoXC7OR17X9LPIfiunEbPovFga3k/mt8VXmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798911; c=relaxed/simple;
	bh=mpFYhDYvOtBbIT9K36AARTC1rTTgN9vbLzUIZUQo2s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9Ty0ndtxg9VljsL/fmXlp0iCIoPNnnnu78l2scUpQ8DAYdhgzUwo9GbsPIG2gIhAKva70nT+GtHRlQZ23PxbXb+w0v5y0XiaBpMdiLbxBy/b2AeJ4kMVz0gFTkfzFskNRl4LKr1avtrt7PB9EcH3H5Sg9eVQoBURbEjEoUWEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=esPZk/8V; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8gymd7MXbLtZrkDxBlIIctS56ONL2jrR6GESiXTtFpM=; b=esPZk/8Ves9bTkpV8lBoIDd5kJ
	InX1J3bP0OQsaVTGKUKSEtVCw6j2G+Gyt7R3faYhJ8+M2wsPjVU3ZHSha7r1jgbKu1RLqLS7vD3/7
	JWuNo8kro6ekGdcAAewbh3XV1q1G6JXjlM3TUvGFrUF0TIX1Omlk51/pwtR5JZN2DvA9W+3Lb7suz
	XfXNAXw14p7UJp/jxfomWUPGrPXBrfgmBOKYx4D0Xm0OwSzmTPJcG19ukyBYqQL25LKHn/ce22ODb
	3vXvH0wXktC3kXIqg5OmADPGY2S6MO7h35TU3Mbf2mPilcgpR4/lc3bKVuvZRwFFvoFWSFtDju74M
	G4l2WYhw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKqIV-00000006lRq-1DgG;
	Tue, 10 Dec 2024 02:48:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 1/5] make sure that DCACHE_INLINE_LEN is a multiple of word size
Date: Tue, 10 Dec 2024 02:48:23 +0000
Message-ID: <20241210024827.1612355-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210024523.GD3387508@ZenIV>
References: <20241210024523.GD3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... calling the number of words DCACHE_INLINE_WORDS.

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


