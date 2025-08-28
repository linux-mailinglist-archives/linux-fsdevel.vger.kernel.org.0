Return-Path: <linux-fsdevel+bounces-59532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB5AB3ADF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD827ABDAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1AC2D29BF;
	Thu, 28 Aug 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Koox3tuf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984E2C1596
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422490; cv=none; b=fRH8R2vvXQ1CKlPu6JAIGJ8c8gPxDAku8X8t0g9WV6+8ZYdlSM+qfQZV2yjIfENXacDP4P6Rh4WstQsM3A1JnRmDhinQPFncGZf3OMfoT/BCcR0Zea4VxIJJBuYrneooXFVihy0EUUimSqC6d1QEogfCIf/Vlxy0Wp1EqwsY+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422490; c=relaxed/simple;
	bh=6jkuFjOeHeODHmoI8Z2zujt9SaYDXJdl0G/wJIdzBqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDQ6GH9U887WfgYw7k0dBCOqn6t0qyc2+qFYDzVpFmeuS7mB6Yx3uMvQX+1HH4NnSdxLMczzHJ5osQh7suNEyIHniRZZ5cfrRTIL0OYDmlO0pYGvVThGLt8i/L0brlF/DwL0uytLk1ZCuo32eL2yk6m5SDTn0+bA3MuUXdB5evs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Koox3tuf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f1+oNk22zgVWnaIWRDQqEzny9G/nuoySiUKC6x5Qdp8=; b=Koox3tufoyCH4s8cVbWjGxRkex
	spGB62EVqmR7fPKQlJnqBJ/1/eRKLmW7znxMPuQvIKarqeKQKfInw2UKVAOZ0Xi/VK9R9Qh9BCqqD
	VIJY0rOvW+rG08ZBrio0f6EGezwYU1ssRLJTS7MKXQfwl8A3pYe4uJc6odlTVUwCZmVE/APhBh7YF
	jkZ+6/nJHE3meNlCBXU7jTfce2RdkseZi69bBzNZS1xHSIEp660NHaneSrYHDR/WQC1tBC0Qehs/e
	RO/NHutZ+XcIHxEDhj3/nEaGlOH7R9cK441lciJJ0cLofZUmJlIqqG7a0grBsrhAp9QUqLMCV5XKT
	Dk1d19qg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlix-0000000F211-0pdc;
	Thu, 28 Aug 2025 23:08:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 04/63] __detach_mounts(): use guards
Date: Fri, 29 Aug 2025 00:07:07 +0100
Message-ID: <20250828230806.3582485-4-viro@zeniv.linux.org.uk>
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

Clean fit for guards use; guards can't be weaker due to umount_tree() calls.
---
 fs/namespace.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 767ab751ee2a..1ae1ab8815c9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2032,10 +2032,11 @@ void __detach_mounts(struct dentry *dentry)
 	struct pinned_mountpoint mp = {};
 	struct mount *mnt;
 
-	namespace_lock();
-	lock_mount_hash();
+	guard(namespace_excl)();
+	guard(mount_writer)();
+
 	if (!lookup_mountpoint(dentry, &mp))
-		goto out_unlock;
+		return;
 
 	event++;
 	while (mp.node.next) {
@@ -2047,9 +2048,6 @@ void __detach_mounts(struct dentry *dentry)
 		else umount_tree(mnt, UMOUNT_CONNECTED);
 	}
 	unpin_mountpoint(&mp);
-out_unlock:
-	unlock_mount_hash();
-	namespace_unlock();
 }
 
 /*
-- 
2.47.2


