Return-Path: <linux-fsdevel+bounces-42532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4832A42EF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359803A6DCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656631DF98F;
	Mon, 24 Feb 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IacL6qOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BE1DC988
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432058; cv=none; b=aAR26+8Gqk5Muh36aQf0d1mEHZo9Q3XLR6xeQbRPKzf7z6KGOo2865sAeQtbMiU+FMxFCHbpvVnLFqvjOoiMTUZL47ynJKeFmwfLcnMdXKmypjdMhrNTvGxzsbcRQWCeZfKxz8rk/aXkIw/gbvWBqlxY6LVqG5KrhL0BAlC1DN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432058; c=relaxed/simple;
	bh=/A09aAjRjuwKtcQrKKqLGcjpx0yAwegBq/fe06evzgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLXqu/vjig8BGYkGttpfuwe1m4uphk185MKBlVcD6jNziQj/KIYeMldX8/2zLU08ICvlgWXO8hYcgqC4y/qHu0Ag0fAeCkrgucTsKXla/9XIJT95ZpFPHDL1frFRPviakgCjjXEEqCQW9jYMYCT83IrdfOezX4Y4Mt8vrvvf9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IacL6qOi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VYZO+x/hvyf21V34X4v4xsQI3+aYJvPgNcWQXmiLaQ8=; b=IacL6qOixcKSg7mp5K9h57hkUN
	bOi4/3d9WBqUVa+j7QJBqtr96HvGyKP60Q/YVbKF1B0rGeP6Vd101cngtbCDpmH0/IiALbg8ceUnT
	wnk+V48ce1Mx0Ki0y0lJ38LzLeTYB0uN7RJ5xb4EzS34xAlrdvlTB8OSpBmU21FhmUgClHfiCI9/r
	qWZ2mdVyRYAT3sJc5yG/oexhFAyW9ORP4Bn6wHFKYBfENgUF+/jJQTRxxg5GINgd/jBZfsayZ8INe
	Kifz+5pHGhGQSpMzVoVvbP7HpJZOpdOe3/qeRl1KLKwVIhlHfi0v1n2uuK065ix7sgGBkekDsfs3K
	UWM8hrmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsj-00000007Mzb-3aSR;
	Mon, 24 Feb 2025 21:20:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 20/21] configfs: use DCACHE_DONTCACHE
Date: Mon, 24 Feb 2025 21:20:50 +0000
Message-ID: <20250224212051.1756517-20-viro@zeniv.linux.org.uk>
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
 fs/configfs/dir.c   | 1 -
 fs/configfs/mount.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 7d10278db30d..637267a76ad8 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -67,7 +67,6 @@ static void configfs_d_iput(struct dentry * dentry,
 
 const struct dentry_operations configfs_dentry_ops = {
 	.d_iput		= configfs_d_iput,
-	.d_delete	= always_delete_dentry,
 };
 
 #ifdef CONFIG_LOCKDEP
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 20412eaca972..740f18b60c9d 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -93,6 +93,7 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	root->d_fsdata = &configfs_root;
 	sb->s_root = root;
 	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
+	sb->s_d_flags |= DCACHE_DONTCACHE;
 	return 0;
 }
 
-- 
2.39.5


