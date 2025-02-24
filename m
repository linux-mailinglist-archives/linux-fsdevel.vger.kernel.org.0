Return-Path: <linux-fsdevel+bounces-42526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD4AA42EF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCE1189DCD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453CD1FC7D9;
	Mon, 24 Feb 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="T9jQASEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841351DB924
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432057; cv=none; b=nsN8p9KsxPl3etB6581LL8eqTyJQHuaKQe+qkI8hxWejxP3u1axKqoNBN7uFxHNmlKIH3xVGfHca//ByJxMqn91tauINB2/8AZbkCsqqzc/vwacdDqujKPDzqGE8IyQU+JBWrRDFja9NXQpVfqgxvtspb6HvrSFRjh/N8Ywwhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432057; c=relaxed/simple;
	bh=NPPbaDJmaNqmL5MpPzHxHiJ1DJLXiZehhpRuPjGC8MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7YEGXX6eqL9Xf+24I+cSva8GNoStJ2IiKQcbvjcNl/zdDzwP/Xzql1q79MarBgDR08OiSVNkG0u6DvEAwMBu8AAD+rtXjogZqYfm9r6HmUVhOiv6Kfq92y5TXzyKYWN0xy9d2NEaCbdaqAub1yILlH4Qmv5Hop9dOHxUXJ9Vvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=T9jQASEa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WtKAUEuQhnljuFsyUMpPw1pmoCH3D2344CGwy3eQ60g=; b=T9jQASEafIuAd8qpXbX0UB7v9T
	tOjSLhzfvUIfjIR76MUK6qmkSMlLwAfQd1Ft4cHEEONPwgO1dHRsnIa4JY42mt+aJRBKPL1sXgsg2
	hnqMbhI6LmXJT6ZErwYVveDE4aVS+QbCBnxu7dIDttx+YH9RquxYiIXWBoM/E3RW8GLh8krHYPfo3
	W30MzKAprqZn1cgr8YIODllv5H36+nCFZZkkOLZagyaFrqH1vXxRmF4CTWC7pbl13TUV0MrKRM7Ut
	vSDKu3Q82QnCWIKdR2nHWMbvkpTW59SH0zjj1WIpgXn9qqBfhyU4wQPBpJxmvcRUzVvgBaCMKuAbZ
	djQQPKrw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsi-00000007My4-37zT;
	Mon, 24 Feb 2025 21:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 12/21] shmem: no dentry retention past the refcount reaching zero
Date: Mon, 24 Feb 2025 21:20:42 +0000
Message-ID: <20250224212051.1756517-12-viro@zeniv.linux.org.uk>
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

Just set DCACHE_DONTCACHE in ->s_d_flags and be done with that.
Dentries there live for as long as they are pinned; once the
refcount hits zero, that's it.  The same, of course, goes for
other tree-in-dcache filesystems - more in the next commits...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0ecb49113bb2..dd84b1c554a8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4971,7 +4971,6 @@ static void shmem_put_super(struct super_block *sb)
 static const struct dentry_operations shmem_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
-	.d_delete = always_delete_dentry,
 };
 #endif
 
@@ -5028,6 +5027,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif /* CONFIG_TMPFS */
+	sb->s_d_flags |= DCACHE_DONTCACHE;
 	sbinfo->max_blocks = ctx->blocks;
 	sbinfo->max_inodes = ctx->inodes;
 	sbinfo->free_ispace = sbinfo->max_inodes * BOGO_INODE_SIZE;
-- 
2.39.5


