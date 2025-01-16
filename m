Return-Path: <linux-fsdevel+bounces-39358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3690A13256
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5791667CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D9F170A13;
	Thu, 16 Jan 2025 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rKHNQ34P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290C9137C37;
	Thu, 16 Jan 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005002; cv=none; b=gkq6WTM9HZZlfdaxq3xVcqFtAE/y4MqDpSffYeJHTbv/o6SQfdNjHBR0QFpbYwSOgEQ+AcstI6kKwKikpMkOY5oLO4IaCLdKf3AdWch+6ClekVtCTBb5EL22xY+6/6OQHAvW7fzbUtq9LrkQgKSCeXDkTwaIb18OVBaY45c6UdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005002; c=relaxed/simple;
	bh=5/9yM5ojUlQc53d97UeQCAbTyQhStbmVRo+Y1Ie111M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6nIGr6qTnm+N6XiIR88jCCtzKOAWtSv2w0s+XNvjCJkwCZiM3ZCmB4psPoANT5pqzUftb+bZf8p6vWSGfhyhareeGxDqdvIpCRgDYd7xA1DhhDFsSXInFw4AC+45CBHr8D5AZW4Up1wAPRuwArUgC+TpR2E9wyn1DBFpPC0Q5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rKHNQ34P; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=38sAdafy9hl8ktdl0+YXGOT6YW1uWUKdlWxFvgD4pCQ=; b=rKHNQ34PK28x9b3B4OEVjXhuig
	q3tBE2/1Hy4/HPXcUpgbJonQNy5gIOrtTWuAJ5QA5R4JT47A7MURsv1u2DPookLl3fT8SO5Yno8cb
	nT6Jrd+enQoRf8X2LWWEjximJ9PhBVGjsrmHHmFPI3mwSYYBxTizAnlmU+TQNItbgm4+wjn6SM6XR
	41oFsI1KXTrc+Yq/7WHE7Fa7WPNl3vnhV11k9LY9ZDbkPYbcJcpXJ/gLG14LNj4pUVswhO6BjJhXl
	pf5b9UwBKfV+n86uPR8aIU5NHodzXw1lgpx03rD/iVwbmCX+JcpOpKKlzpklPPqu9Bdf5S7LFZTq0
	18tiTeUA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILd-000000022GR-3mVY;
	Thu, 16 Jan 2025 05:23:18 +0000
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
Subject: [PATCH v2 01/20] make sure that DNAME_INLINE_LEN is a multiple of word size
Date: Thu, 16 Jan 2025 05:22:58 +0000
Message-ID: <20250116052317.485356-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116052103.GF1977892@ZenIV>
References: <20250116052103.GF1977892@ZenIV>
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

Reviewed-by: Jan Kara <jack@suse.cz>
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


