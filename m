Return-Path: <linux-fsdevel+bounces-51250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9C9AD4D94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C671BC0109
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D67C234964;
	Wed, 11 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Lzo2tBKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0823AE9B
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628483; cv=none; b=Q+7Og0NALByZ7lRy9gYXLbnmwvGByIxjzZ5vduiEhmKXsR9bG7BK4jIXCbtKatVgeeyFwjVNPEc72sG59GHKxPoRqwGP0cOhXEM+qt7doLnobQ+AbMzVMT1kndpEgHQWLDEY6pK6HubrnmY2c8euDu9LcsA7hUF9fnj/SgmaNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628483; c=relaxed/simple;
	bh=V30J4Y3axzO89XtUCpf1yMLZMukR4j7uSRd/JZbp8KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWfm8AcKRRSf5Lblw5GdLUw9Oc15XOVT/viohipC8XMn7yoPLyIv8PEpQgZnLpAp3XkXSLJRBJs+JVPUAdSh3k9Dxp3tK+k9zVK0lCoQ7nX28qvSSWRFrnc+zzOf8biV9B9fCnXKPxSkrCDi+Nq3K5o5x6p5QWl25p38iqCM4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Lzo2tBKL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JUTUxamS0vLHsOcPtCDgETzt3ZjIGzgTkmMIYlgGZ+U=; b=Lzo2tBKL3iZsiWx9an307TmGkS
	S3UWCbOTkgA0sth0fKwG+oTI/K4NGjlDPTOtzHrS+JbUoQqkxrlYlgxWSaa5u0A2r8fC7eAJXvpvc
	tbDxRucL35ByVbJjeE6rKx7BEcHaLKPEFEVA5S9Jtqnt3p18GpeXQnZt2feUMLUEWD9bNcgzbsJHW
	euI4IdHaBpbIUpIrt5l8Lza4wNZq6xRKI/ZM7//ZdrbEaH/jpUQ1vCx6ymEjJRJFTURXhh88quXlt
	C5NvH56vevjK8mHP/gV0SPRY+eLg/TmaF6+G5T/bwNMLkSAu9Hj+YxmRGnPJbQuNE7nxGFxx82QES
	9xVnQMGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIB-0000000HTxq-3JVb;
	Wed, 11 Jun 2025 07:54:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 13/21] shmem: no dentry retention past the refcount reaching zero
Date: Wed, 11 Jun 2025 08:54:29 +0100
Message-ID: <20250611075437.4166635-13-viro@zeniv.linux.org.uk>
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

Just set DCACHE_DONTCACHE in ->s_d_flags and be done with that.
Dentries there live for as long as they are pinned; once the
refcount hits zero, that's it.  The same, of course, goes for
other tree-in-dcache filesystems - more in the next commits...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3583508800fc..94b2b4264607 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4980,7 +4980,6 @@ static void shmem_put_super(struct super_block *sb)
 static const struct dentry_operations shmem_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
-	.d_delete = always_delete_dentry,
 };
 #endif
 
@@ -5037,6 +5036,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif /* CONFIG_TMPFS */
+	sb->s_d_flags |= DCACHE_DONTCACHE;
 	sbinfo->max_blocks = ctx->blocks;
 	sbinfo->max_inodes = ctx->inodes;
 	sbinfo->free_ispace = sbinfo->max_inodes * BOGO_INODE_SIZE;
-- 
2.39.5


