Return-Path: <linux-fsdevel+bounces-60087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E946B413ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EE7545CDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF72C2D97AC;
	Wed,  3 Sep 2025 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vcDtZfch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7702D4B7F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875349; cv=none; b=IfbVsF+MO0wouLG+LhKT9VM5sMqF3YCHM+1Qxb4gTuDeKBHbQGeWYm1i123QV0j9efCuah5C0TpeZSqz66icH6mTVxSiGXVcqFuHj27SUAoWjjIy65ErDUVTmhkA9l0FF8CQZEKAdmyYhpG4HrnC8s2VOCuo0IkfjIDjGBULOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875349; c=relaxed/simple;
	bh=18xwCYHv9phgT/TpywL4+pXgKKgKdgEVLtJIuuRwLOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDYOJ0CLECatunmS7HVjwF0uGEM+LqCgXjwknf51IfVzkdXFMNm7b1rU+KDQ+sEGNLg3hFBMmkC6u3scvrWOygb8QjNoPn4eAS82b8YyQUd2ECv5qKfE4TLmN8ffvTUq/myZdYnhf1BvCPSMitS7FwplNRTUJnqHT4R1HEFVXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vcDtZfch; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f/rfdlyiUunDSHddI54Okc62XItNqt40vMfwrGriDZc=; b=vcDtZfchPLahP0tRNmkwlq38Uu
	lF7ZMjxgXvD9N+a/F0lhD2tmBzBLwFG06El2X+35IIsUltaJQSxA4sSduAc28FNAvsC0Bqc86AAUH
	ixrTpkLonzNO+KKVbNeJoSc6N7oAXA9EzURttoSu1eDLO9JC6NWdURJZLcoMGF9SRdSvVqG09YfCC
	4CNObyU39kRF7JZgVflNJcJUysBVc35RhM/v8Kw/7mrlCUKgC5bwL5Afj26GselCgBLqFCetS5lXp
	2FJMW0SXEj2dnE9hr1qwvKFZaYtsX1926ahzdrRNn03gBAGxCRl9Mb2jltuB9WJfapSXPgQVrVHag
	RQvg2+ig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX7-0000000ApDS-3msv;
	Wed, 03 Sep 2025 04:55:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 44/65] do_{loopback,change_type,remount,reconfigure_mnt}(): constify struct path argument
Date: Wed,  3 Sep 2025 05:55:06 +0100
Message-ID: <20250903045537.2579614-45-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f3f26125444d..894631bcbdbd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2914,7 +2914,7 @@ static int flags_to_propagation_type(int ms_flags)
 /*
  * recursively change the type of the mountpoint.
  */
-static int do_change_type(struct path *path, int ms_flags)
+static int do_change_type(const struct path *path, int ms_flags)
 {
 	struct mount *m;
 	struct mount *mnt = real_mount(path->mnt);
@@ -3034,8 +3034,8 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 /*
  * do loopback mount.
  */
-static int do_loopback(struct path *path, const char *old_name,
-				int recurse)
+static int do_loopback(const struct path *path, const char *old_name,
+		       int recurse)
 {
 	struct path old_path __free(path_put) = {};
 	struct mount *mnt = NULL;
@@ -3265,7 +3265,7 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
  * superblock it refers to.  This is triggered by specifying MS_REMOUNT|MS_BIND
  * to mount(2).
  */
-static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
+static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
 {
 	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
@@ -3302,7 +3302,7 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
  * If you've mounted a non-root directory somewhere and want to do remount
  * on it - tough luck.
  */
-static int do_remount(struct path *path, int ms_flags, int sb_flags,
+static int do_remount(const struct path *path, int ms_flags, int sb_flags,
 		      int mnt_flags, void *data)
 {
 	int err;
-- 
2.47.2


