Return-Path: <linux-fsdevel+bounces-39901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7575A19C56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9000D3AD691
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA81F49625;
	Thu, 23 Jan 2025 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bBqdc5XT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429D2914;
	Thu, 23 Jan 2025 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596806; cv=none; b=gUI1W7dw/VMXnxwRdyY2Nwy8Eg0cS0ZxLa5Y8Y/L4QQij7N6kJK7wYHI44eYoaMnVpVIJuywhlmcQmWsilm1sK7X3SdRkzU857D485TZreHDVvAQo9pMoLvoB3OnnT8fvV4FO/Zd/QxfGDG6pklWucthz9zBgpclj5M41nAF1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596806; c=relaxed/simple;
	bh=XPZkiJKXYfeFofa+2VFXwjMK3RU50OpTdvCEwvPZQgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJKkAnA+8L/MaFgP+YVc93LC6RiPjYLOet0b4H2i3euxtIlsF8x+Ohd8kBbmhqxzrMgD98f/CLfNPHXiQqswluUtTcw5KruurkHpSQeFEuDkrC45G10ms1ST4bX6QKgCHZdECSh8HcVcptE/euuv8wTmaNju9jfuJemVlUr1wgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bBqdc5XT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=d06SqmicZT/MxgsCOW0a8y/YjAavZHt5mB4tHTNwgH0=; b=bBqdc5XTg2+JftM5OteQOFxdQf
	roylvUpjWe52D0cs6+J675WBrgE4poEQBkRmublhcYFZvgpAoK3lWR5I2J5rz6uFceEywMOPg7BpY
	jb+ShruUs75FfaMmbPg0Oz4yQtWWS0TXvNimD6qku5AcgTm+IJHkp3Bqi0Lj6COS5YVHl9JyIPJrU
	RooA8Vttp7vZ4BgeNGf2YWFBPvyZRkvpmieAkuqnsnBap6QJdSKfNdVh9O1CfEXZzIKwyUxFnwWfy
	aZ82SGFoFZHt1WK7nnysWjLaPUKjzYeVu0zwE6F5gLbu9ANoo/8z6uVoVfA+EmOT0xqoALIXy8zsS
	gXRDjg1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIt-00000008F1W-1Py4;
	Thu, 23 Jan 2025 01:46:43 +0000
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
Subject: [PATCH v3 01/20] make sure that DNAME_INLINE_LEN is a multiple of word size
Date: Thu, 23 Jan 2025 01:46:24 +0000
Message-ID: <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123014511.GA1962481@ZenIV>
References: <20250123014511.GA1962481@ZenIV>
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


