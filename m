Return-Path: <linux-fsdevel+bounces-60054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D341B413C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD62163BCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221592D6E6E;
	Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NSR14QC3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CA2D4B55
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875343; cv=none; b=DAD7F5d4J+wu94J1HK+PgeHQxF8hOg7NaTjXwlx1sLqcPMZtB9EKbDcW9Sp6uhsxmRNs8dIVEfombpwFcgXpkkGNgJPV5fBOa3Xxfn7zK33iaKf9KdGKOVqqKz0UN7b9Az2fZvlUGiUVuFYhclNV8W9p7WYSqW/7FDuCPuVIxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875343; c=relaxed/simple;
	bh=YOFDeNDrIhsCzrSLdjrzy5CThW0Lpmy9/FA8aiGTDRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4o8Qg6DQtTkdqnusQbP+mlrBz2RPYmN+h1kk50vwBZiW6KlMgR9u0rQ32vLqehAudzADBLeO/AM98wbcR/WNOf1W1DJtNnymZ3z8aMq7qnp7B3r5MaPhQN4y046FKLCKEEWCYd5DDalwmaD3kXseP7UFrhXe8H5cif/bcT7kzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NSR14QC3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uyfuQOv8jV/n/o6UMa+1KdXqTk7SB8XAIdl/PD9VJxw=; b=NSR14QC3q0wbtjE4NsXhhXQH+c
	tCCvdBwjl79wS7566QIZkcZPPMXN7WvmgQVdfAL6yTBifsZqZhFsw2wap1HoZzPxAKxgg31FRH2nz
	VsG6eO+IWYzsOjThkCtn4QANB29mLYbAYzSOr5STlUpWBysr4uHvUBbn+F1RdPBncLWP3pKDLY1QX
	262grK3jCyB1FdO4yZ5IlvsZ5cHBIM4X7QTpkMGdFE50SwWD7hQJw5vEcgWnJS8+/i3WYOu7Z9ZJM
	Ybf1ZhExkdCGRRuX9DQ+kSKIEpl+RwHX3HdVL0rKGAbQaVAcFTL0F2lY/EE33UY1jGefSNhLiFbm6
	+l4rjJzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX1-0000000Ap6U-3mlp;
	Wed, 03 Sep 2025 04:55:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 08/65] mark_mounts_for_expiry(): use guards
Date: Wed,  3 Sep 2025 05:54:29 +0100
Message-ID: <20250903045537.2579614-8-viro@zeniv.linux.org.uk>
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

Clean fit; guards can't be weaker due to umount_tree() calls.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 13e2f3837a26..898a6b7307e4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3886,8 +3886,8 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 	if (list_empty(mounts))
 		return;
 
-	namespace_lock();
-	lock_mount_hash();
+	guard(namespace_excl)();
+	guard(mount_writer)();
 
 	/* extract from the expiration list every vfsmount that matches the
 	 * following criteria:
@@ -3909,8 +3909,6 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 		touch_mnt_namespace(mnt->mnt_ns);
 		umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 	}
-	unlock_mount_hash();
-	namespace_unlock();
 }
 
 EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
-- 
2.47.2


