Return-Path: <linux-fsdevel+bounces-42521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA07A42EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA13189B02D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37411EEA43;
	Mon, 24 Feb 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R9nlPdnQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1560C1DB375
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432057; cv=none; b=uKhJIUbTnsek/n0wz4c+qgveXL15FwBTowXpxIpv6QQF5lQmGuNwmZNUp7KmkEy9oZs+FaFE0J5nPaPCLbd8xP3K9dqmM/pLW4JDnvMxYmWVyAKrfHC6c6DEjCNHC7LqXNlFg9DTfxFWU8E4943i5M3ekLeW+iB4iRzUAnofiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432057; c=relaxed/simple;
	bh=d2659bhkIH35UsNdxRwr3J80C+cALvngos3Wn/bMAbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnimxkVOmx5h/14B5LuZf7F/FAye/J3zgQPFvlKsxTvTnJ0MjU4rp7k9sqkA3/wvLuFYvedlxs9a+rbVqLPwesh+Zv/Y1359mqwHKrrHmrZy/WLN2yC0MwIfZYnlwsYP69WFS7H7W3/BW5sulnMh9D/+Z/m9sRgDiHls/1+K0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=R9nlPdnQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ao6KHlhr+JzSMKp4DwoMsM8thCxjo1AWRSQjn4BSAhY=; b=R9nlPdnQWsXWIBLFQF9dd6kTdE
	F3DVVEdDXaoj7KVO+i+NqtiYvU0gc5SR2nHNsvCTFchTycNi4Q9DIkR8s1gLsAv5PdT9r3tN5ucvI
	D7didh2eClFLX1ARdgL14KPViGut75CNaEu46yttRnrS4RqUjJOfySY5UTTEsfqMGdxcuLqb2qpiV
	4Nkk3w8kMDL5erj/CDA+XJmXETS7mVeGamPcb0prEDAUS4P4sYXOnF1K88inQptOGMtt9q7tmZkLX
	c8IFWR8iwVQMe+XIvzLl4QloSGqkBHDF9cy8dSnF8nR9CC052DiLz6L80OPa2qKtGDKywl+1R09DI
	34SNjo0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsi-00000007Mxx-2jDq;
	Mon, 24 Feb 2025 21:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 11/21] nsfs, pidfs: drop the pointless ->d_delete()
Date: Mon, 24 Feb 2025 21:20:41 +0000
Message-ID: <20250224212051.1756517-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

No dentries are ever hashed on those, so ->d_delete() wouldn't be
even looked at.  If it's unhashed, we are not retaining it in dcache
once the refcount hits zero, no matter what.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nsfs.c  | 1 -
 fs/pidfs.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 663f8656158d..f7fddf8ecf73 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -37,7 +37,6 @@ static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)
 }
 
 const struct dentry_operations ns_dentry_operations = {
-	.d_delete	= always_delete_dentry,
 	.d_dname	= ns_dname,
 	.d_prune	= stashed_dentry_prune,
 };
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 63f9699ebac3..c0478b3c55d9 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -521,7 +521,6 @@ static char *pidfs_dname(struct dentry *dentry, char *buffer, int buflen)
 }
 
 const struct dentry_operations pidfs_dentry_operations = {
-	.d_delete	= always_delete_dentry,
 	.d_dname	= pidfs_dname,
 	.d_prune	= stashed_dentry_prune,
 };
-- 
2.39.5


