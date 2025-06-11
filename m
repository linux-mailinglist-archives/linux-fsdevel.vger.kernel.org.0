Return-Path: <linux-fsdevel+bounces-51257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6343BAD4DA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8C21BC0791
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3842475F2;
	Wed, 11 Jun 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ILrnEfx6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A723E34D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628484; cv=none; b=vEDuBitPiLaHkDr3hqxZTBij1D8IiyD5WUutXjuKup5spFzL+heInGZWBmsS+zzV2JUZHMUyTtnjcHxsmLCPexTTmtss7BaMMoF+t6OJDsit4qdiaCkLVycjrwA5KyPzyqpzRoL0YEZaFO5wb2HCwxn4fBVK1tLKPtI16bxd5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628484; c=relaxed/simple;
	bh=S6jn44TOL7YTY0FDn2OsCirceLZQ7j53rUd+UrQR/7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgELFp/9Q+/Ajz7qrdKIl61yu2vgS1Cv9Bzg2EuShxdH4M59ancfupxHc/JvtjGKJU0P3uO9osQ+fmls1dVeiiuKVLDV9TOpBPNu27nt6m+20sw1rRmY7HNEHsiKrsuOwLDty0D6xun4AVq+0cYuh117hTaSmkF47J84cofHmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ILrnEfx6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iO7gGstoiB5KaveN+9aYytQUn6VSAxkcr1Fr1wwPy4I=; b=ILrnEfx6Ia3QrrjejZyJAohQhb
	6b0LQjrD9GKJXSY1XOluLgs7NrA4i1XEr/ZFNfHX/7/ixwHQWqXvYf5mEYLJdzbz9r0TQn/M1Dh07
	VqAQpvWbcD7OIbnIhh0w3wnE0bu+n+hm3DhSpRYnuHArT2VGdGMeJEEVn10i+dELJtPQo1cUDmQF/
	jbeztplAPKcbb+hVs4GAD6G7hLbatIZjUoYzEi4BBWC4UHs02nvgUz1SDzVEqA8lOBUzp2W87O5on
	+m+TrWJxJLPhhgOdMtM2pd5f51i4zWRL9VDNWrD1ZuIJMzSeE/4RrMWD517w0cLF7TaXHRS82oryx
	pU8A1JdQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIC-0000000HTzl-2Z8B;
	Wed, 11 Jun 2025 07:54:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 18/21] efivarfs: use DCACHE_DONTCACHE instead of always_delete_dentry()
Date: Wed, 11 Jun 2025 08:54:34 +0100
Message-ID: <20250611075437.4166635-18-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/efivarfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index f76d8dfa646b..23ff4e873651 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -183,7 +183,6 @@ static int efivarfs_d_hash(const struct dentry *dentry, struct qstr *qstr)
 static const struct dentry_operations efivarfs_d_ops = {
 	.d_compare = efivarfs_d_compare,
 	.d_hash = efivarfs_d_hash,
-	.d_delete = always_delete_dentry,
 };
 
 static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
@@ -351,6 +350,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_magic             = EFIVARFS_MAGIC;
 	sb->s_op                = &efivarfs_ops;
 	set_default_d_op(sb, &efivarfs_d_ops);
+	sb->s_d_flags |= DCACHE_DONTCACHE;
 	sb->s_time_gran         = 1;
 
 	if (!efivar_supports_writes())
-- 
2.39.5


