Return-Path: <linux-fsdevel+bounces-59540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C5B3AE03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8C7583934
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2731B2D0C67;
	Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PS/pmO8V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0CD2D0C78
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422491; cv=none; b=MgisYpOSl3LvkiSbf7xNOHvPY5g1Jg2gu8fOT49dARuQSaQCgeUF7FKGcb8k2ZaptHZxK2M+sLrkVWmp3PFnc0dnBKddPy9vvH82fdEE+5H14Uto+dStYJCQHyXwG5h/gxj3vAxZixvVR8Oui/zKWetcuoaMqvsDmuxAn4Xo8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422491; c=relaxed/simple;
	bh=vA4DVRrLcQajvFlMcUFPRwA8sp4GhSXzCUcsF93GZH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2WxsSGD95/QJlzOOLKRMM1gsliTv260WwiMa7o0txJWvCQNReJz4oN5s3z9FBS7J93GF4BmMBn0y6XPG00ov6q8kssoW6cSKZpJEZyEVj9F3ycqoMTwIkFQzb6v1p1oIxNe7ngHRBmMKqnVAG8GnRPV2G2HgR5ss3u5gYX5ZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PS/pmO8V; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eYFNe0CB4LidaTvIMoIhxQKFwlUvYc0Vs8DJK9htegA=; b=PS/pmO8VOuTMjnVGmrqJoT/XIU
	0b1S3IjE5JNaGPrCWZnDoOxvczc60ikbtRiLE/1tWKWLwVFXdLJmIrPSD4Myn98KhORdfXp9kumUd
	Yk+J14g+0USaDNqQBn1BiBrw5AzdSdyV5NErH4kJgxk3bl70TBOVlOHBvC2EgZkN7/FNjV0JajwDv
	dz73EY20qG6K5a5YBe1S3LQ416bUd8EjesITG4oK/QoT/frfiQ+inuN9GCHaK2eNl03f7J67D2Y8r
	E2ou79xne0tdnTnvWks76pnQtSCOExv9qAajG+WfIwkdlb3DsbLVImRCZBrKfh6WRaTGBxMNtfxRL
	k6JBT1rA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliy-0000000F22T-1Fgw;
	Thu, 28 Aug 2025 23:08:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 13/63] has_locked_children(): use guards
Date: Fri, 29 Aug 2025 00:07:16 +0100
Message-ID: <20250828230806.3582485-13-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and document the locking requirements of __has_locked_children()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 59948cbf9c47..2cb3cb8307ca 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2373,6 +2373,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
 	}
 }
 
+/* locks: namespace_shared && pinned(mnt) || mount_locked_reader */
 static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
 	struct mount *child;
@@ -2389,12 +2390,8 @@ static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 
 bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
-	bool res;
-
-	read_seqlock_excl(&mount_lock);
-	res = __has_locked_children(mnt, dentry);
-	read_sequnlock_excl(&mount_lock);
-	return res;
+	guard(mount_locked_reader)();
+	return __has_locked_children(mnt, dentry);
 }
 
 /*
-- 
2.47.2


