Return-Path: <linux-fsdevel+bounces-60425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 673EAB46A8E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57535188D44C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089BD2C237C;
	Sat,  6 Sep 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Tfg6aaTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456128BAAB
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149903; cv=none; b=ufrjB0OsAGc+Chjd19uBL3iibt97tWs/OBR1qo0LuzIIhXp8bWlfSo5S3Q2Ws4SPl0idDQhQltu9JLZ8iHqsHkkdy0RJOe3ZMbtvBfSXJHdDqgW4Y3fEbT5NeGP2VGZ7pSvCi6qCqvgMDCcKqdxk75aJDmWLIbwtajrAIgnNlEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149903; c=relaxed/simple;
	bh=zzp/5qcEp6cQDAn0/2oEDh6s7PSTppbuB6KfJIHh6ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnWm9tR0zwI0oRqhSjHVev2pTLM4D6nMTz9+HaydlvV9oNB6iTcLoN6FOhT6hyrOOMdqTn/g7nTTakafXeeE6nmjHUg5BfReAzeFTqtWoEeou0uw7fyjSxxiYFGpPiJOgzsDP0pfIq1K04v3JDMKZLN+DQzL/tusy6xlnbwgZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Tfg6aaTR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zLYfHGWxlazKQ4jrVKezsOFe8oGJC8VnSfHEEhLpWrQ=; b=Tfg6aaTRnxh5H/qAYcsuuRBxs4
	nRw2nNzGavrrtCSLYPak57HxKr3reJi/kv5JqmyQWZCpErvskL8io0Fv7bAkk8cq9QEONAm+u4qaI
	ZnMRTd7sZJAV9PJRD4A7gtHOKnejCgdC30VFy4xiFgkuCwkQu00PD7tgdAqFfCrxdCTVRB3NJPPf2
	TBD2j01NTth1JwGVqiaAEpEVZx71oCu4erLjxOLFN0WZpa1A4ilQj9gRWlA61oB5jJCjMxdBQ97FI
	Hm5GCxfEopQn4zzkamLEiKvbmIVtKJRAa+IvUiPQSgv2rQdyr3EpGAawDz579cB8FN5bCD/XYYEKL
	I5hNaDiA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxP-00000000OtN-3U9H;
	Sat, 06 Sep 2025 09:11:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 12/21] ksmbd_vfs_inherit_posix_acl(): constify path argument
Date: Sat,  6 Sep 2025 10:11:28 +0100
Message-ID: <20250906091137.95554-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/smb/server/vfs.c | 2 +-
 fs/smb/server/vfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 1d9694578bff..299a5d9fcb78 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1909,7 +1909,7 @@ int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 }
 
 int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
-				struct path *path, struct inode *parent_inode)
+				const struct path *path, struct inode *parent_inode)
 {
 	struct posix_acl *acls;
 	struct posix_acl_entry *pace;
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 35725abf4f92..458e2e3917b1 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -166,6 +166,6 @@ int ksmbd_vfs_get_dos_attrib_xattr(struct mnt_idmap *idmap,
 int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 				 struct path *path);
 int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
-				struct path *path,
+				const struct path *path,
 				struct inode *parent_inode);
 #endif /* __KSMBD_VFS_H__ */
-- 
2.47.2


