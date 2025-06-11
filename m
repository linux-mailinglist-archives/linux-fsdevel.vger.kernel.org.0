Return-Path: <linux-fsdevel+bounces-51255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E25AD4DA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE862189FD0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C424247DE1;
	Wed, 11 Jun 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qjzMBbMJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9223D2BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628484; cv=none; b=PAT9g+mLNsqlnMx5uQthjyotX2cU9vM9Qr8qtHDSMtyoM+kVwoqpc+wuwhdfV0WY2JmPD/bLEhMwnBBRBqDgLckoHb3Hs5MI91Qm6+awP1JMbC223NFnAFPL7cw742uz8ZKzVIyG8+rZVMY4vjd/2tkUdwqoYdDhJhCES+43KzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628484; c=relaxed/simple;
	bh=IoLvHIAshoQK9KxZ+/PXw3yUM8lUhJMtRMGMZg+LJs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivhscT02M0mKzuIOKLwKgS3S9wtmT8LiMofkWsDiH3PbfVzPQch0wb1P63cQErP22q//u6JT5CwDRGQotFFFF8OXndCyDPOvImZrbRFWs6UvBGX/kvCNDL3tULaNYFVkD25+Oa4Snp7rucMQ0c/pV2quhYW5RwTfqyieaK6QYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qjzMBbMJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EX+5A2gWr3tZYwn1/AKdfvqfl3o0GuSUfQGHJ2U2QQk=; b=qjzMBbMJPJMwpd8lqfyXuCbnJ8
	kYz0HLLRXGAz5KiJwn1nzAykJAEy645FkFM55Q2fLYC3HwbEdLeve1y7fp4y/a921lUFkGKnHrM0e
	Z/sCqOIRiXKR0KqWxodl/0YtDBBx6pXCyD1pNN/qPcVgBuGuEk6dmSrVzzsmgPmqFkOoaw3tGUT6o
	V7lX3RoY5wH4a3ixVcBr6kRiYrGataOfdZ4h7zDsw0hgXViO8pqrsoT+kY6musjOLrT9nqmEfiBID
	r3YgqIKhCleQhPbkMQcyL3l4azcyQgPnVS7X+5snyVFarZRToQwrXhweUnsTwUGIbl+5KlVEkXEs0
	mo3blMGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIC-0000000HTz2-1jwu;
	Wed, 11 Jun 2025 07:54:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 17/21] 9p: don't bother with always_delete_dentry
Date: Wed, 11 Jun 2025 08:54:33 +0100
Message-ID: <20250611075437.4166635-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

just set DCACHE_DONTCACHE for "don't cache" mounts...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/9p/vfs_dentry.c | 1 -
 fs/9p/vfs_super.c  | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 5061f192eafd..04795508a795 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -127,7 +127,6 @@ const struct dentry_operations v9fs_cached_dentry_operations = {
 };
 
 const struct dentry_operations v9fs_dentry_operations = {
-	.d_delete = always_delete_dentry,
 	.d_release = v9fs_dentry_release,
 	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
 	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 5c3dc3efb909..795c6388744c 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -134,10 +134,12 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	if (retval)
 		goto release_sb;
 
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		set_default_d_op(sb, &v9fs_cached_dentry_operations);
-	else
+	} else {
 		set_default_d_op(sb, &v9fs_dentry_operations);
+		sb->s_d_flags |= DCACHE_DONTCACHE;
+	}
 
 	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
 	if (IS_ERR(inode)) {
-- 
2.39.5


