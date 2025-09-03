Return-Path: <linux-fsdevel+bounces-60098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01D4B413FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9A8681485
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7232DBF4B;
	Wed,  3 Sep 2025 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XTnVsQmk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4882D9ED0
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875351; cv=none; b=A0/UwQfeeXiKJUWqSxhpl7dIgC7xisXWzjct+HAghtgvXeh8DT79Ko1Mwi7tnjVdjNBiXk9Kx6inlU3n3vnE+/1VH2NEJyYHYz3YeoplZvvSUKReY0nrJ0eAI6OcAMcQBsKdOGBF3WEMRxfaRHKJ2JzGwRusMut03ypf2pEjt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875351; c=relaxed/simple;
	bh=Iby5EXCqRGBL1A7gR/Qw3UMByGOX5C3uKFUjKMDvDMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EngKFf45bG8s7zl71ZbC8BHgBsT5HFsdJVczk/Kt0WBzvfDb9NvR/+1h+KRQ7qPK23/jR2eUB/Rd/o5+VeW8eGSaD1fdCDh8LBAmJKxSo/qTT/evrIapIF3tP+wrKZG2rRF2Tt/TfF1RtRJqJgo90HDbcQZeWeokxE/PkYlF7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XTnVsQmk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dFc7HzgbpH2BgiI2TFfpRWmue4ruDWn/qwgAnX/EXXE=; b=XTnVsQmkjTwUx5UO8OjILLnEZs
	TvswcbluRFgNpMJ1VfgE4jtV4PVxRYkmXzxog++8O1lCR8JIfdvujPHc2v7zEOCA9cSMYFkTDjVFP
	P0wHDW6QPlGyOV4RDPS9WUikF1q1d80aSPcQw59EHSfYmfqJPQo1nbe6mDw6Foy3g+Q0m8fTy6z/r
	2Mtwk5rZ0R0toNXJ27IEk6ouoaYgppM+xLy4YCTA2Q/l1KXByeSjr61KUtk1zTnvcLTMwMkPQqXZ0
	6GTT4FzxXlLDqIHiQJIUCswB9qrKV2c73FJ7P/uJaPVRNYX2LULJ7J6NT6PgE8uez/4epkrnz2Qkb
	uP1ucN9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXA-0000000ApFo-0kdc;
	Wed, 03 Sep 2025 04:55:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 54/63] open_detached_copy(): don't bother with mount_lock_hash()
Date: Wed,  3 Sep 2025 05:55:16 +0100
Message-ID: <20250903045537.2579614-55-viro@zeniv.linux.org.uk>
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

we are holding namespace_sem and a reference to root of tree;
iterating through that tree does not need mount_lock.  Neither
does the insertion into the rbtree of new namespace or incrementing
the mount count of that namespace.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2e35f5eb4f81..425c33377770 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3086,14 +3086,12 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 		return ERR_CAST(mnt);
 	}
 
-	lock_mount_hash();
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		mnt_add_to_ns(ns, p);
 		ns->nr_mounts++;
 	}
 	ns->root = mnt;
 	mntget(&mnt->mnt);
-	unlock_mount_hash();
 	namespace_unlock();
 
 	mntput(path->mnt);
-- 
2.47.2


