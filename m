Return-Path: <linux-fsdevel+bounces-58919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9BAB33578
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408B23A19B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6217281352;
	Mon, 25 Aug 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nzbc2Fu2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65DD277017
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097041; cv=none; b=HKVT+FuXZbhxh0UMTP0VKKs2H9sxYaaSyTlksPPJVFqOsf51BUUVpJjjhTCH+ekuvkIaYdD3grirvXUb3cCSMKtfePwHwaAPMublICFFamvhvSCk5o2eBD4tFcpZx6c23OQlEx6NotLBYvqDFYiAHAXX6HiVihXvUggxL9Gzfgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097041; c=relaxed/simple;
	bh=Rz+uV/3zD+bxP5fS3zT4bvYvcAQUNzWJIhDLT98j8EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh4jguKsP+45OqCiiZronotJKsDcUMPJmO+oOqKleihdV95F2AJUvQ9U1eF+1CMx3YSgTCmkirKw+peBOhzg3MDMR5nBLI1Ep4HJhyZYgsWo+xFm/91cU8Id2mQmyXMje1u61Gn0szC/JuGZ0gJNe7ngcul8DM7TwQ0gLVUdmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nzbc2Fu2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5gaeO5nxhyLdPzjnM1urOt6AoExdUe6qc3DxuNiFto4=; b=nzbc2Fu25IqkSfbe21ZsQveLCD
	luWQmfZdY9wQGZZr1Y9LTlqvHPk9iaoUGFMWDu8AUPnvG9L26XXhdt4ny4ERRvD04RFTgNc3o3Xb7
	6jXHebSXA2h2Gq3sPv5jFy/L96Cd54350w1iR698GEiCVFaUxpIfrVcMtyWXLkviqG0kJGAkp6zZI
	z9r7VL8sG1EecgR9jhR19FSbtTBh3sn0qUsr4oF6nP1icpJTdTMHP5stZmq1jacr/s30M/gBvRcwC
	Du7I/jwSE4CSo2PXWbb2ocA6dFxr4TXXdrX6TgH6r4DofCiX3vjC+mDhdzYToFY3O2sl80utNSY80
	NrDcdwSQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3m-00000006TBC-0Kmg;
	Mon, 25 Aug 2025 04:43:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 21/52] finish_automount(): simplify the ELOOP check
Date: Mon, 25 Aug 2025 05:43:24 +0100
Message-ID: <20250825044355.1541941-21-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It's enough to check that dentries match; if path->dentry is equal to
m->mnt_root, superblocks will match as well.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9e04133d81dd..5c4b4f25b5f8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3803,8 +3803,7 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 
 	mnt = real_mount(m);
 
-	if (m->mnt_sb == path->mnt->mnt_sb &&
-	    m->mnt_root == dentry) {
+	if (m->mnt_root == path->dentry) {
 		err = -ELOOP;
 		goto discard;
 	}
-- 
2.47.2


