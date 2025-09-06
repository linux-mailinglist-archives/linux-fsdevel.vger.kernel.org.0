Return-Path: <linux-fsdevel+bounces-60426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A997B46A95
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC0A67BCD3C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089382C236E;
	Sat,  6 Sep 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TFam8xKE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3EA28C869
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149903; cv=none; b=lqnUBfZQAwTA/zwFOoq/T/x2VoFeH5pbuwuh4jcnH4aaGAJdIXdAy0J6aTNL/FraOQqx3vQuq2dR087nJJ7LXVHbIqS93SwrUjiDF/ka23a0z9iEiqPGyxmr8gM35y0YYL/fYJHkM9UNR530IwFQv++chsxKksvypm6tc5VO/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149903; c=relaxed/simple;
	bh=zyAOqu3Kw7vUM3AiOY8d6hMtOaR+RADAVgBIrcXwUBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meOhB/ivH8i1NCwmtmu4PY1aFWUOi54wpsq2ph/X1rO50SFU+wCZuoFouVuuHuRO7+tABvRCHSrbdnE/cIC4LWSuCupKpll1UlHkvmu0m23HpWf9+EJMrIeWKdEJJHUi5eFqDxNgUQ6yhcQ+iq8srOapO2E9Ta3BAFG2e62lBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TFam8xKE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yjcuxDO9wwrVF9vYbfwYT5fq/tMjennT7rrGgm3wdlc=; b=TFam8xKE5kWeoxYRAqsfdHjf3e
	9iKyjE7HW+vxiezQ/xHeYp1q7A0kuaEkb6AdqCLDjVRdiDh9tGTCis1xOCPDKlEdRoM9YC7LtunEr
	9HKvzTvp+jyDZa7FbtD6ffJ6R3u2e85Coin5FilqEmO4nvNPeBjAF4eFb5NF3glMdDCVdplBQ7xpD
	YmZ8uyAkFUHTjHBuCMLdoY+PgSkc6Va5k93X1G22zDn7t9XMjfmQNbe5xa/tyVOGavcF+f3EFPFva
	wUKiRIpWrERzz1P+60++O12EmV5ntSna5hu89sgb9StBQG705X+bJyEFu9V6b/yz5pA9QYw/GSsjx
	MfdoaC4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxP-00000000OtX-3xOC;
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
Subject: [PATCH 13/21] ksmbd_vfs_set_init_posix_acl(): constify path argument
Date: Sat,  6 Sep 2025 10:11:29 +0100
Message-ID: <20250906091137.95554-13-viro@zeniv.linux.org.uk>
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
index 299a5d9fcb78..a33b088afa27 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1856,7 +1856,7 @@ void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock)
 }
 
 int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
-				 struct path *path)
+				 const struct path *path)
 {
 	struct posix_acl_state acl_state;
 	struct posix_acl *acls;
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 458e2e3917b1..df6421b4590b 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -164,7 +164,7 @@ int ksmbd_vfs_get_dos_attrib_xattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
 int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
-				 struct path *path);
+				 const struct path *path);
 int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
 				const struct path *path,
 				struct inode *parent_inode);
-- 
2.47.2


