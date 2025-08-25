Return-Path: <linux-fsdevel+bounces-58909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3CCB33564
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD43A189EE2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8008B24A05D;
	Mon, 25 Aug 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mO2YRffs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474223B63C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097039; cv=none; b=l0XFjX0NQChmmDT7QxmVcQNy8JAfisQnQxaZWF5S6Coddi8BjQ+zBOHMh/5S62VXDVWv9ODqwtA/MGvVlUtvYBfyjF2OGfyLXniw0hDNBdVejPeEN1d0WmGcVuKXs+9lXks5toooPlspgT7Vu/SnasDYnXLV6rV9oi4MKE8PmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097039; c=relaxed/simple;
	bh=6jkuFjOeHeODHmoI8Z2zujt9SaYDXJdl0G/wJIdzBqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbbUGBe+Y3R7SGPR169rSjUdZqYCsXLuw5xsseA0yhmgN1D9nXNjN/qBzlQrJRZ23lkQnoMXqPdtjnE05KfI5KuQd+Uu/OOKro5CUG1BIEkW66vG54wJ1wAOjaeDlzPo2YCVSo6XEK5c3I+OTej7cJG7iltAw8RYRXhPbxa2s9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mO2YRffs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f1+oNk22zgVWnaIWRDQqEzny9G/nuoySiUKC6x5Qdp8=; b=mO2YRffsoQix/qbhZR+vvrJypN
	8x9UwM+PY6icT77gK/4hSoFl5XkipW0JhRuby++rR3Ypz6a7+Qou5ANVzTSYB+7HEfc93D+mSGvvs
	c2PYyc2Ov5+hQfPEUKeW/K3dATw37YVxOmqp2NHoPLRo5Ph2tMqmLJwVrOgNM0VvSc90yMn4Jzgj5
	M9hJLo5vBVMcrUvVeoP3mRn0dJEEXXPfxkT1OYax2A4gfN2WPzaoxdALGjYPIdwKNe/n1sGKBRazn
	5N2gZXhzdud9mluegMSAuoFko1ACp9/5dOdZbLRtNRycC4Jr1qZHU2YFiENT7Oi5M0PsBZJrUe4hh
	TOWSfKag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3k-00000006T8X-05US;
	Mon, 25 Aug 2025 04:43:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 04/52] __detach_mounts(): use guards
Date: Mon, 25 Aug 2025 05:43:07 +0100
Message-ID: <20250825044355.1541941-4-viro@zeniv.linux.org.uk>
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


