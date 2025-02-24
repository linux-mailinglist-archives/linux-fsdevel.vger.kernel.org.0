Return-Path: <linux-fsdevel+bounces-42531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EABA42EF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9A316F1DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E50204C0E;
	Mon, 24 Feb 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WriGyRZM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690491DC98B
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432058; cv=none; b=KPELuVxgIRQ5l1WZEcj4N56qlglZ5MnqrSxszhvlBb3IymNduQs3/sjhOOn5hyQLSrxcqOLyc6ASy7EbXkI0NLhPZgU6Aj4Oe+9BUiQwgYRsCERJnvTfMfxisGf4rP4I5HxlIhfjIO/0Hl3eh2q9dmri8LQeWHUJeDgYgmfF+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432058; c=relaxed/simple;
	bh=BtW1UeSGvcKEZ/y22XbKV5Df9aRyoT7OXggm6A+Qs6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfQi4rIDTkXN/pkf4dvMyf3KUXgVZyX7V5Iht8yGWuClKPpJ8tK5dmrC0Wh/D5Ut+km3kreOoAZ8bV7Ay024f+hGIWdxR5+N3610XmeCBlPPd+JmhwRZIDorL2LHQjzrY95t5IhWCJzlGIWDFxnQpA8hYBnI9mqDtUu7OJd8roc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WriGyRZM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YFBTK8tDVuQLP/MDhvTlHFHCw9tfu5tbkzLc9m6Gpmc=; b=WriGyRZM0OBBdmzYAX/lDqCVZf
	H103gFJwNJQVSGtSERGv18QWE5jzI8ZdWE7V4jtLeGrCU4GSxP1N/1qjR5ym/eG0Kq50QVk5INMPJ
	3kd2CL8TjB6fegeXrOHR2/2J+2ESKxrHD015oNP55ZXuLPhQNabF/bYOIJI32ykHKKTg49OnxOYy7
	E4DD5QwGHhsFSi4Ilgv6zPzlScaPTpzUZMhV4vwL96h6ciJAgmK/BDH+HI7MDhtpINm9SbOg5vsmB
	gYHI0TJkYF5lPMRAybzsZ4FZunTSjwo/ceWMtSXkbUCirSosfSYE30HWsdCjnE3nne4POLjkz4NjL
	eLPMYXyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsj-00000007MzU-3Da1;
	Mon, 24 Feb 2025 21:20:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 19/21] debugfs: use DCACHE_DONTCACHE
Date: Mon, 24 Feb 2025 21:20:49 +0000
Message-ID: <20250224212051.1756517-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
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
 fs/debugfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index f54a8fd960e4..1c71d9932a67 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -258,7 +258,6 @@ static struct vfsmount *debugfs_automount(struct path *path)
 }
 
 static const struct dentry_operations debugfs_dops = {
-	.d_delete = always_delete_dentry,
 	.d_release = debugfs_release_dentry,
 	.d_automount = debugfs_automount,
 };
@@ -274,6 +273,7 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_op = &debugfs_super_operations;
 	set_default_d_op(sb, &debugfs_dops);
+	sb->s_d_flags |= DCACHE_DONTCACHE;
 
 	debugfs_apply_options(sb);
 
-- 
2.39.5


