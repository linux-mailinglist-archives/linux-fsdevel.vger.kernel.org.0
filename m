Return-Path: <linux-fsdevel+bounces-60047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D01B413BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E061554899D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1372D59F7;
	Wed,  3 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dKKJJnWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1992D481F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875342; cv=none; b=WZjwwPSsNZpB5Rv5+xuCVP8GBUsXx0/7hqYk2Oy4I9sm46BJ0nytpvKQE8FN4yy2e1FFVy8uzf3xEGYNY87MBsJK16HlmmDvRFBpEZ/qmiOKbx0/PyCnuL/sWGLZpWuVEwOoAEUANnF4LiCmKjlgfQ8UdhiDHFFiTbMLNu0ybv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875342; c=relaxed/simple;
	bh=j56Lz/1ae55amC1kIGJfBot/A/tMiX40HPhe11T+81A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPhwE/56Xnw2qtrQ8qZhqSZsVd5qG4jPNMZfKFItr06xMIqbuoTQATj8Vv8pGRL/s3zg+59rDuLJjzv3oByE+8Gd9PgCv60KlqStdo1GdBiRXLbD/JyxSMyvSBaJthKPhrSsyNTtJPKQbidLA9THRLGrpsdq3w5JrxwXV0LCWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dKKJJnWq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AWxRMJ8zKhhDYtKZTmRTBGuLCZH5wsCsFAPM5AArloA=; b=dKKJJnWqpxRVSFxQM1iB9tLmty
	I17+gcqbzUXIf4X8VLlwTdXFKrhAFL408nECw1mnvBcze7h2RBGgO8cfa9FqD8CM8AIUFXDuvOKqh
	0PBcnMujoT970vdlOjWUvSfVFFBfCwvoLmqSy+VqU/4swcU11nn7NgtoQ0dF5xT/NaFsev96vmnaf
	YXYuAIWzZot38bOWWmbePeijhU3Bk1jJ4Uatnr7+OYuxp4WRziHYiSIqJeJZzEpbLvARxEWWCS3go
	I0EV9yeJWUnEhcSdNC89wRo3oUNkIp6495UkijHC6JgHfVvdOok03EOjJ0lKqUZTt/V6Tc6Y8mZGt
	yHbcrIXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX1-0000000Ap5w-1F1Y;
	Wed, 03 Sep 2025 04:55:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 05/65] __is_local_mountpoint(): use guards
Date: Wed,  3 Sep 2025 05:54:26 +0100
Message-ID: <20250903045537.2579614-5-viro@zeniv.linux.org.uk>
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

clean fit; namespace_shared due to iterating through ns->mounts.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1ae1ab8815c9..f1460ddd1486 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -906,17 +906,14 @@ bool __is_local_mountpoint(const struct dentry *dentry)
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mount *mnt, *n;
-	bool is_covered = false;
 
-	down_read(&namespace_sem);
-	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
-		is_covered = (mnt->mnt_mountpoint == dentry);
-		if (is_covered)
-			break;
-	}
-	up_read(&namespace_sem);
+	guard(namespace_shared)();
+
+	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node)
+		if (mnt->mnt_mountpoint == dentry)
+			return true;
 
-	return is_covered;
+	return false;
 }
 
 struct pinned_mountpoint {
-- 
2.47.2


